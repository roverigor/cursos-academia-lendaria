-- ================================================
-- MMOS — SMOKE TEST (assume DDL já aplicado)
-- Postgres 16+ / Supabase
-- ================================================

BEGIN;

-- 1) Mind (UPSERT por slug)
WITH up AS (
  INSERT INTO minds (slug, display_name, primary_language, short_bio, category, primary_domain,
                     quality_grade, apex_score, completeness, confidence_avg)
  VALUES ('naval-ravikant','Naval Ravikant','en','Entrepreneur‑investor; filosofia prática da alavancagem.',
          'entrepreneur','cognitive_philosophy','A',0.90,0.60,0.78)
  ON CONFLICT (slug) DO UPDATE
  SET display_name = EXCLUDED.display_name
  RETURNING id
)
SELECT * FROM up;

-- 2) Catálogos mínimos
INSERT INTO categories (code,name) VALUES
  ('BIO','Biographical'),
  ('COG','Cognitive'),
  ('VAL','Values')
ON CONFLICT (code) DO NOTHING;

-- 3) Lote de ingestão
WITH b AS (
  INSERT INTO ingestion_batches (pipeline_version, llm_provider, llm_model, llm_version, prompt_hash, params, created_by)
  VALUES ('innerlens.v1.0','openai','gpt-5','2025-10-01','abc123', '{"temperature":0.2}'::jsonb, 'ops')
  RETURNING id
)
SELECT * FROM b;

-- 4) Source (artigo)
WITH m AS (SELECT id AS mind_id FROM minds WHERE slug='naval-ravikant'),
s AS (
  INSERT INTO sources (mind_id, title, type, platform, author, published_date, url, language, quality, status)
  SELECT mind_id, 'How to Get Rich (Without Getting Lucky)', 'article', 'web', 'Naval',
         DATE '2019-05-01', 'https://nav.al/rich', 'en', 'primary','processed'
  FROM m
  RETURNING id, mind_id
)
SELECT * FROM s;

-- 5) Fila + Execução (escopo = source)
WITH s AS (SELECT id FROM sources WHERE title LIKE 'How to Get Rich%'),
q AS (
  INSERT INTO processing_queue (batch_id, job_type, scope_type, scope_id, priority, status, scheduled_at, started_at, finished_at)
  SELECT (SELECT id FROM ingestion_batches ORDER BY created_at DESC LIMIT 1),
         'extract','source', s.id, 5, 'done', now()-interval '5 min', now()-interval '4 min', now()-interval '1 min'
  FROM s
  RETURNING id
),
e AS (
  INSERT INTO job_executions (queue_id, llm_provider, llm_model, llm_version, params,
                              tokens_prompt, tokens_completion, cost_usd, latency_ms, input_bytes, output_bytes)
  SELECT q.id, 'openai','gpt-5','2025-10-01','{"temperature":0.2}'::jsonb,
         1200, 1800, 0.012345, 17500, 20480, 8192
  FROM q
  RETURNING id
)
SELECT * FROM e;

-- 6) Dois fragments (com execução de geração)
WITH m AS (SELECT id AS mind_id FROM minds WHERE slug='naval-ravikant'),
     s AS (SELECT id AS source_id FROM sources WHERE title LIKE 'How to Get Rich%'),
     e AS (SELECT id AS exec_id FROM job_executions ORDER BY created_at DESC LIMIT 1),
     cat AS (SELECT id AS category_id FROM categories WHERE code='COG')
INSERT INTO fragments (mind_id, source_id, category_id, ingestion_batch_id,
                       layer, location, type, fragment_type, evidence_type,
                       relevance_10, confidence, content, context, insight,
                       generation_execution_id)
SELECT m.mind_id, s.source_id, cat.category_id,
       (SELECT id FROM ingestion_batches ORDER BY created_at DESC LIMIT 1),
       5, 'section: Specific Knowledge', 'principle', 'written_thought','primary',
       9, 0.85,
       'Specific knowledge is highly creative or technical; it''s on the edge of knowledge.',
       'Naval discute "specific knowledge" como alavanca pessoal.',
       'Foque em conhecimento específico e não substituível.',
       (SELECT exec_id FROM e)
FROM m,s,cat
UNION ALL
SELECT m.mind_id, s.source_id, cat.category_id,
       (SELECT id FROM ingestion_batches ORDER BY created_at DESC LIMIT 1),
       5, 'section: Leverage', 'principle', 'written_thought','primary',
       8, 0.80,
       'Leverage comes from capital, people, and products with no marginal cost of replication (code/media).',
       'Discussão sobre leverage (capital, pessoas, código/mídia).',
       'Buscar alavancagem com código/mídia para escalar sem custo marginal.',
       (SELECT exec_id FROM e)
FROM m,s,cat;

-- 7) Tags + Vinculação
INSERT INTO tags (name, tag_type) VALUES
  ('specific_knowledge','theme'),
  ('leverage','theme'),
  ('axiom','theme')
ON CONFLICT (name) DO NOTHING;

INSERT INTO fragment_tags (fragment_id, tag_id)
SELECT f.id, t.id
FROM fragments f
JOIN tags t ON (t.name='specific_knowledge' AND f.location ILIKE '%Specific Knowledge%')
   OR (t.name='leverage' AND f.location ILIKE '%Leverage%');

-- 8) Profiles (values_hierarchy + writing_style + routine) + custos
WITH m AS (SELECT id AS mind_id FROM minds WHERE slug='naval-ravikant'),
     e AS (SELECT id AS exec_id FROM job_executions ORDER BY created_at DESC LIMIT 1)
INSERT INTO mind_profiles (mind_id, layer, profile_type, title, format, payload,
                           confidence_level, source_count, extraction_date, human_validation_status,
                           generation_execution_id)
SELECT m.mind_id, 6, 'values_hierarchy', 'Layer 6: Values', 'yaml',
       '{"top":[{"name":"AUTONOMIA","rank":1},{"name":"IMPACTO","rank":2},{"name":"LONGO_PRAZO","rank":3}]}'::jsonb,
       'high', 5, now(), 'APPROVED', e.exec_id
FROM m,e
UNION ALL
SELECT m.mind_id, 5, 'writing_style', 'Voice & Style', 'md',
       '{"style_signature":"espiral_expansiva","pillars":["clareza","densidade","calma"]}'::jsonb,
       'medium', 7, now(), 'PENDING', e.exec_id
FROM m,e
UNION ALL
SELECT m.mind_id, 3, 'routine', 'Routine Windows', 'yaml',
       '{"windows":[{"name":"deep_work_prime_time","start":"22:00","end":"02:00","tz":"America/Sao_Paulo"}]}'::jsonb,
       'high', 3, now(), 'APPROVED', e.exec_id
FROM m,e;

-- 9) Destilar sinais (valores top‑3 + rotina prime time)
WITH p AS (
  SELECT id AS profile_id, mind_id, payload
  FROM v_mind_latest_profiles
  WHERE profile_type='values_hierarchy'
)
INSERT INTO mind_values (mind_id, name, rank, intensity, alignment_score, confidence_level, profile_id)
SELECT p.mind_id, (x->>'name')::text, (x->>'rank')::int, 10, 100, 'high', p.profile_id
FROM p, LATERAL jsonb_array_elements(p.payload->'top') AS x
ON CONFLICT (mind_id, name) DO NOTHING;

WITH p AS (
  SELECT id AS profile_id, mind_id, payload
  FROM v_mind_latest_profiles
  WHERE profile_type='routine'
)
INSERT INTO mind_routine_windows (mind_id, window_name, start_local, end_local, timezone, consistency, profile_id)
SELECT p.mind_id, (x->>'name')::text, (x->>'start')::time, (x->>'end')::time, (x->>'tz')::text, 'daily', p.profile_id
FROM p, LATERAL jsonb_array_elements(p.payload->'windows') AS x
ON CONFLICT DO NOTHING;

COMMIT;

-- ===== Verificações rápidas =====

-- A) Perfis vigentes
SELECT mind_id, profile_type, title, created_at
FROM v_mind_latest_profiles
ORDER BY profile_type;

-- B) Custos por artefato
SELECT * FROM v_profile_costs ORDER BY executed_at DESC LIMIT 5;

-- C) Atribuição execução→mente
SELECT * FROM v_job_mind_attribution ORDER BY created_at DESC LIMIT 5;

-- D) Custo por fragmento
SELECT * FROM v_cost_per_fragment ORDER BY executed_at DESC NULLS LAST LIMIT 5;

-- E) Rotina: estou na janela agora?
SELECT *
FROM mind_routine_windows w
JOIN minds m ON m.id = w.mind_id
WHERE m.slug='naval-ravikant'
AND (
  (w.start_local <= w.end_local AND LOCALTIME BETWEEN w.start_local AND w.end_local)
  OR
  (w.start_local  > w.end_local AND (LOCALTIME >= w.start_local OR LOCALTIME <= w.end_local))
);

-- F) Busca por tag
SELECT f.id, f.location, f.relevance_10, t.name AS tag
FROM fragments f
JOIN fragment_tags ft ON ft.fragment_id = f.id
JOIN tags t ON t.id = ft.tag_id
ORDER BY f.created_at DESC;
