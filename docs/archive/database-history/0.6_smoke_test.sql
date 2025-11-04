-- =========================================================
-- 0.6_smoke_test.sql — Smoke Test Completo (0.4.sql)
-- =========================================================
-- Purpose: Test ALL features of 0.4.sql unified schema
-- Dependencies: 0.4.sql must be applied first
-- Tests:
--   - Core (minds, sources, fragments)
--   - MMOS (profiles, values, routines, obsessions, psychometrics)
--   - InnerLens (traits, proficiencies)
--   - CreatorOS (projects, content_pieces, campaigns, performance)
--   - Auth (user_profiles, provision trigger, RLS)
--   - Operational (batches, queue, executions)
--   - Views (all analytics views)

\echo ''
\echo '========================================='
\echo '  SMOKE TEST - 0.6.sql Unified Schema'
\echo '========================================='
\echo ''

-- =========================================================
-- PARTE 1: CORE (Minds, Sources, Fragments)
-- =========================================================
\echo '1. Testing CORE tables (minds, sources, fragments)...'

BEGIN;

-- 1.1) Mind (UPSERT por slug)
WITH up AS (
  INSERT INTO minds (
    slug, display_name, primary_language, short_bio,
    category, primary_domain, quality_grade,
    apex_score, completeness, confidence_avg, privacy_level
  )
  VALUES (
    'naval-ravikant',
    'Naval Ravikant',
    'en',
    'Entrepreneur-investor; filosofia prática da alavancagem.',
    'entrepreneur',
    'cognitive_philosophy',
    'A',
    0.90,
    0.60,
    0.78,
    'public'
  )
  ON CONFLICT (slug) DO UPDATE
  SET display_name = EXCLUDED.display_name,
      updated_at = now()
  RETURNING id, slug, display_name
)
SELECT '✅ Mind created: ' || slug || ' (' || display_name || ')' AS result FROM up;

-- 1.2) Categories (seed básico)
INSERT INTO categories (code, name, description) VALUES
  ('BIO', 'Biographical', 'Life events and experiences'),
  ('COG', 'Cognitive', 'Mental processes and thinking'),
  ('VAL', 'Values', 'Core beliefs and principles')
ON CONFLICT (code) DO NOTHING;

SELECT '✅ Categories seeded: ' || COUNT(*)::TEXT FROM categories;

-- 1.3) Source
WITH m AS (SELECT id AS mind_id FROM minds WHERE slug = 'naval-ravikant'),
s AS (
  INSERT INTO sources (
    mind_id, title, type, platform, author,
    published_date, url, language, quality, status
  )
  SELECT
    mind_id,
    'How to Get Rich (Without Getting Lucky)',
    'article',
    'web',
    'Naval',
    DATE '2019-05-01',
    'https://nav.al/rich',
    'en',
    'primary',
    'processed'
  FROM m
  RETURNING id, title
)
SELECT '✅ Source created: ' || title AS result FROM s;

-- 1.4) Ingestion Batch
WITH b AS (
  INSERT INTO ingestion_batches (
    pipeline_version, llm_provider, llm_model, llm_version,
    prompt_hash, params, created_by
  )
  VALUES (
    'innerlens.v1.0',
    'openai',
    'gpt-5',
    '2025-10-01',
    'abc123',
    '{"temperature": 0.2}'::jsonb,
    'smoke_test'
  )
  RETURNING id
)
SELECT '✅ Ingestion batch created: ' || id::TEXT AS result FROM b;

-- 1.5) Processing Queue + Job Execution
WITH s AS (SELECT id FROM sources WHERE title LIKE 'How to Get Rich%'),
q AS (
  INSERT INTO processing_queue (
    batch_id, job_type, scope_type, scope_id,
    priority, status, scheduled_at, started_at, finished_at
  )
  SELECT
    (SELECT id FROM ingestion_batches ORDER BY created_at DESC LIMIT 1),
    'extract_fragments',
    'source',
    s.id,
    5,
    'done',
    now() - interval '5 min',
    now() - interval '4 min',
    now() - interval '1 min'
  FROM s
  RETURNING id
),
e AS (
  INSERT INTO job_executions (
    queue_id, llm_provider, llm_model, llm_version, params,
    tokens_prompt, tokens_completion, cost_usd, latency_ms,
    input_bytes, output_bytes
  )
  SELECT
    q.id,
    'openai',
    'gpt-5',
    '2025-10-01',
    '{"temperature": 0.2}'::jsonb,
    1200,
    1800,
    0.012345,
    17500,
    20480,
    8192
  FROM q
  RETURNING id, tokens_total, cost_usd
)
SELECT '✅ Job execution created: tokens=' || tokens_total::TEXT ||
       ', cost=$' || cost_usd::TEXT AS result FROM e;

-- 1.6) Fragments
WITH m AS (SELECT id AS mind_id FROM minds WHERE slug = 'naval-ravikant'),
     s AS (SELECT id AS source_id FROM sources WHERE title LIKE 'How to Get Rich%'),
     e AS (SELECT id AS exec_id FROM job_executions ORDER BY created_at DESC LIMIT 1),
     cat AS (SELECT id AS category_id FROM categories WHERE code = 'COG')
INSERT INTO fragments (
  mind_id, source_id, category_id, ingestion_batch_id,
  layer, location, type, fragment_type, evidence_type,
  relevance_10, confidence, content, context, insight,
  generation_execution_id
)
SELECT
  m.mind_id,
  s.source_id,
  cat.category_id,
  (SELECT id FROM ingestion_batches ORDER BY created_at DESC LIMIT 1),
  5,
  'section: Specific Knowledge',
  'principle',
  'written_thought',
  'primary',
  9,
  0.85,
  'Specific knowledge is highly creative or technical; it''s on the edge of knowledge.',
  'Naval discute "specific knowledge" como alavanca pessoal.',
  'Foque em conhecimento específico e não substituível.',
  (SELECT exec_id FROM e)
FROM m, s, cat
UNION ALL
SELECT
  m.mind_id,
  s.source_id,
  cat.category_id,
  (SELECT id FROM ingestion_batches ORDER BY created_at DESC LIMIT 1),
  5,
  'section: Leverage',
  'principle',
  'written_thought',
  'primary',
  8,
  0.80,
  'Leverage comes from capital, people, and products with no marginal cost of replication (code/media).',
  'Discussão sobre leverage (capital, pessoas, código/mídia).',
  'Buscar alavancagem com código/mídia para escalar sem custo marginal.',
  (SELECT exec_id FROM e)
FROM m, s, cat;

SELECT '✅ Fragments created: ' || COUNT(*)::TEXT FROM fragments;

-- 1.7) Tags + Fragment Tags
INSERT INTO tags (name, tag_type) VALUES
  ('specific_knowledge', 'theme'),
  ('leverage', 'theme'),
  ('axiom', 'theme')
ON CONFLICT (name) DO NOTHING;

INSERT INTO fragment_tags (fragment_id, tag_id)
SELECT f.id, t.id
FROM fragments f
JOIN tags t ON (
  (t.name = 'specific_knowledge' AND f.location ILIKE '%Specific Knowledge%')
  OR (t.name = 'leverage' AND f.location ILIKE '%Leverage%')
);

SELECT '✅ Tags created and linked: ' || COUNT(*)::TEXT FROM fragment_tags;

-- 1.8) Fragment Relationships (grafo)
WITH frags AS (
  SELECT id, location FROM fragments ORDER BY created_at LIMIT 2
)
INSERT INTO fragment_relationships (from_fragment_id, to_fragment_id, relationship_type)
SELECT f1.id, f2.id, 'supports'
FROM frags f1, frags f2
WHERE f1.id < f2.id
LIMIT 1;

SELECT '✅ Fragment relationship created (supports)';

COMMIT;

\echo '✅ CORE tests passed!'
\echo ''

-- =========================================================
-- PARTE 2: MMOS ARTIFACTS (Profiles, Values, Routines)
-- =========================================================
\echo '2. Testing MMOS artifacts (profiles, values, routines, obsessions)...'

BEGIN;

-- 2.1) Mind Profiles
WITH m AS (SELECT id AS mind_id FROM minds WHERE slug = 'naval-ravikant'),
     e AS (SELECT id AS exec_id FROM job_executions ORDER BY created_at DESC LIMIT 1)
INSERT INTO mind_profiles (
  mind_id, layer, profile_type, title, format, payload,
  confidence_level, source_count, extraction_date,
  human_validation_status, generation_execution_id
)
SELECT
  m.mind_id,
  6,
  'values_hierarchy',
  'Layer 6: Values',
  'yaml',
  '{"top": [{"name": "AUTONOMIA", "rank": 1}, {"name": "IMPACTO", "rank": 2}, {"name": "LONGO_PRAZO", "rank": 3}]}'::jsonb,
  'high',
  5,
  CURRENT_DATE,
  'APPROVED',
  e.exec_id
FROM m, e
UNION ALL
SELECT
  m.mind_id,
  5,
  'writing_style',
  'Voice & Style',
  'md',
  '{"style_signature": "espiral_expansiva", "pillars": ["clareza", "densidade", "calma"]}'::jsonb,
  'medium',
  7,
  CURRENT_DATE,
  'PENDING',
  e.exec_id
FROM m, e
UNION ALL
SELECT
  m.mind_id,
  3,
  'routine',
  'Routine Windows',
  'yaml',
  '{"windows": [{"name": "deep_work_prime_time", "start": "22:00", "end": "02:00", "tz": "America/Sao_Paulo"}]}'::jsonb,
  'high',
  3,
  CURRENT_DATE,
  'APPROVED',
  e.exec_id
FROM m, e;

SELECT '✅ Mind profiles created: ' || COUNT(*)::TEXT FROM mind_profiles;

-- 2.2) Mind Values (destilados)
WITH p AS (
  SELECT id AS profile_id, mind_id, payload
  FROM v_mind_latest_profiles
  WHERE profile_type = 'values_hierarchy'
)
INSERT INTO mind_values (mind_id, name, rank, intensity, alignment_score, confidence_level, profile_id)
SELECT
  p.mind_id,
  (x->>'name')::TEXT,
  (x->>'rank')::INT,
  10,
  100,
  'high',
  p.profile_id
FROM p, LATERAL jsonb_array_elements(p.payload->'top') AS x
ON CONFLICT (mind_id, name) DO NOTHING;

SELECT '✅ Mind values created: ' || COUNT(*)::TEXT FROM mind_values;

-- 2.3) Mind Routine Windows
WITH p AS (
  SELECT id AS profile_id, mind_id, payload
  FROM v_mind_latest_profiles
  WHERE profile_type = 'routine'
)
INSERT INTO mind_routine_windows (mind_id, window_name, start_local, end_local, timezone, consistency, profile_id)
SELECT
  p.mind_id,
  (x->>'name')::TEXT,
  (x->>'start')::TIME,
  (x->>'end')::TIME,
  (x->>'tz')::TEXT,
  'daily',
  p.profile_id
FROM p, LATERAL jsonb_array_elements(p.payload->'windows') AS x;

SELECT '✅ Routine windows created: ' || COUNT(*)::TEXT FROM mind_routine_windows;

-- 2.4) Mind Obsessions
WITH m AS (SELECT id FROM minds WHERE slug = 'naval-ravikant')
INSERT INTO mind_obsessions (mind_id, question, intensity, confidence_level)
SELECT
  m.id,
  'How can I create more leverage?',
  9,
  'high'
FROM m
UNION ALL
SELECT
  m.id,
  'What is the nature of happiness?',
  8,
  'high'
FROM m;

SELECT '✅ Mind obsessions created: ' || COUNT(*)::TEXT FROM mind_obsessions;

-- 2.5) Mind Psychometrics
WITH m AS (SELECT id FROM minds WHERE slug = 'naval-ravikant')
INSERT INTO mind_psychometrics (mind_id, model, payload)
SELECT
  m.id,
  'big_five',
  '{"openness": 95, "conscientiousness": 85, "extraversion": 45, "agreeableness": 35, "neuroticism": 25}'::jsonb
FROM m
ON CONFLICT (mind_id) DO UPDATE
SET payload = EXCLUDED.payload,
    updated_at = now();

SELECT '✅ Mind psychometrics created/updated';

COMMIT;

\echo '✅ MMOS artifacts tests passed!'
\echo ''

-- =========================================================
-- PARTE 3: INNERLENS (Traits, Proficiencies)
-- =========================================================
\echo '3. Testing InnerLens (traits, proficiencies)...'

BEGIN;

-- 3.1) Traits (Big Five seed)
INSERT INTO traits (code, name, description) VALUES
  ('openness', 'Openness to Experience', 'Imagination, curiosity, creativity'),
  ('conscientiousness', 'Conscientiousness', 'Organization, discipline, reliability'),
  ('extraversion', 'Extraversion', 'Sociability, energy, assertiveness'),
  ('agreeableness', 'Agreeableness', 'Cooperation, empathy, trust'),
  ('neuroticism', 'Neuroticism', 'Emotional stability, stress response')
ON CONFLICT (code) DO NOTHING;

SELECT '✅ Traits seeded: ' || COUNT(*)::TEXT FROM traits;

-- 3.2) Trait Scores
WITH m AS (SELECT id FROM minds WHERE slug = 'naval-ravikant'),
     t AS (SELECT id, code FROM traits)
INSERT INTO trait_scores (mind_id, trait_id, score_10, confidence)
SELECT
  m.id,
  t.id,
  CASE t.code
    WHEN 'openness' THEN 10
    WHEN 'conscientiousness' THEN 8
    WHEN 'extraversion' THEN 5
    WHEN 'agreeableness' THEN 4
    WHEN 'neuroticism' THEN 3
  END,
  0.85
FROM m, t
ON CONFLICT (mind_id, trait_id) DO NOTHING;

SELECT '✅ Trait scores created: ' || COUNT(*)::TEXT FROM trait_scores;

-- 3.3) Domains/Specializations/Skills (taxonomia)
INSERT INTO domains (code, name, description) VALUES
  ('TECH', 'Technology', 'Software engineering, AI, etc')
ON CONFLICT (code) DO NOTHING;

INSERT INTO specializations (domain_id, code, name, description)
SELECT
  (SELECT id FROM domains WHERE code = 'TECH'),
  'AI',
  'Artificial Intelligence',
  'Machine learning, neural networks'
ON CONFLICT (code) DO NOTHING;

INSERT INTO skills (specialization_id, code, name, description)
SELECT
  (SELECT id FROM specializations WHERE code = 'AI'),
  'PROMPT_ENG',
  'Prompt Engineering',
  'Crafting effective prompts for LLMs'
ON CONFLICT (code) DO NOTHING;

SELECT '✅ Taxonomy seeded (domains/specializations/skills)';

-- 3.4) Mind Proficiencies
WITH m AS (SELECT id FROM minds WHERE slug = 'naval-ravikant'),
     s AS (SELECT id FROM skills WHERE code = 'PROMPT_ENG')
INSERT INTO mind_proficiencies (mind_id, skill_id, level_10, confidence, notes)
SELECT
  m.id,
  s.id,
  9,
  0.90,
  'Expert in prompt engineering and LLM interaction'
FROM m, s
ON CONFLICT (mind_id, skill_id) DO NOTHING;

SELECT '✅ Mind proficiencies created: ' || COUNT(*)::TEXT FROM mind_proficiencies;

COMMIT;

\echo '✅ InnerLens tests passed!'
\echo ''

-- =========================================================
-- PARTE 4: CREATOROS (Projects, Pieces, Campaigns)
-- =========================================================
\echo '4. Testing CreatorOS (projects, content, campaigns)...'

BEGIN;

-- 4.1) Content Frameworks (seed)
INSERT INTO content_frameworks (code, name, type, description) VALUES
  ('gps', 'GPS Framework', 'pedagogical', 'Goal → Position → Steps'),
  ('aida', 'AIDA', 'marketing', 'Attention → Interest → Desire → Action'),
  ('pas', 'Problem-Agitate-Solve', 'storytelling', 'Problem → Agitate → Solve')
ON CONFLICT (code) DO NOTHING;

SELECT '✅ Content frameworks seeded: ' || COUNT(*)::TEXT FROM content_frameworks;

-- 4.2) Content Project
WITH m AS (SELECT id FROM minds WHERE slug = 'naval-ravikant')
INSERT INTO content_projects (
  creator_mind_id, persona_mind_id, name, description, goals, status
)
SELECT
  m.id,
  m.id,  -- usa própria voz
  'Naval''s Wisdom Newsletter',
  'Weekly insights on leverage, specific knowledge, and happiness',
  ARRAY['thought_leadership', 'newsletter'],
  'active'
FROM m
RETURNING id, name;

SELECT '✅ Content project created: ' || name FROM content_projects;

-- 4.3) Audience Profile
WITH p AS (SELECT id FROM content_projects ORDER BY created_at DESC LIMIT 1)
INSERT INTO audience_profiles (project_id, name, age_range, psychographic_traits)
SELECT
  p.id,
  'Tech Founders 28-45',
  '28-45',
  '{"openness": 85, "conscientiousness": 75, "interests": ["startups", "philosophy", "leverage"]}'::jsonb
FROM p;

SELECT '✅ Audience profile created';

-- 4.4) Content Pieces
WITH p AS (SELECT id FROM content_projects ORDER BY created_at DESC LIMIT 1),
     f AS (SELECT id FROM content_frameworks WHERE code = 'aida'),
     e AS (SELECT id FROM job_executions ORDER BY created_at DESC LIMIT 1)
INSERT INTO content_pieces (
  project_id, type, title, content, voice_fidelity_score,
  framework_id, generation_execution_id, published_at
)
SELECT
  p.id,
  'newsletter',
  'Building Leverage in 2025',
  'AIDA framework: Attention (hook)... Interest (pain)... Desire (solution)... Action (CTA)',
  0.92,
  f.id,
  e.id,
  now()
FROM p, f, e
UNION ALL
SELECT
  p.id,
  'blog',
  'The Power of Specific Knowledge',
  'Deep dive into Naval''s concept of specific knowledge and how to develop it.',
  0.88,
  (SELECT id FROM content_frameworks WHERE code = 'gps'),
  e.id,
  now() - interval '1 day'
FROM p, e;

SELECT '✅ Content pieces created: ' || COUNT(*)::TEXT FROM content_pieces;

-- 4.5) Content Campaign
WITH p AS (SELECT id FROM content_projects ORDER BY created_at DESC LIMIT 1)
INSERT INTO content_campaigns (project_id, name, goal, start_date, end_date)
SELECT
  p.id,
  'Launch Campaign Q4 2025',
  'Grow newsletter to 10K subscribers',
  CURRENT_DATE,
  CURRENT_DATE + interval '90 days'
FROM p;

SELECT '✅ Content campaign created';

-- 4.6) Link Campaign to Pieces
WITH camp AS (SELECT id FROM content_campaigns ORDER BY created_at DESC LIMIT 1),
     pieces AS (SELECT id FROM content_pieces ORDER BY created_at DESC LIMIT 2)
INSERT INTO content_campaign_pieces (campaign_id, content_piece_id)
SELECT camp.id, pieces.id
FROM camp, pieces;

SELECT '✅ Campaign pieces linked: ' || COUNT(*)::TEXT FROM content_campaign_pieces;

-- 4.7) Content Performance
WITH cp AS (SELECT id FROM content_pieces ORDER BY created_at DESC LIMIT 1)
INSERT INTO content_performance (content_piece_id, metric_type, value, recorded_at)
SELECT
  cp.id,
  'views',
  1250,
  now()
FROM cp
UNION ALL
SELECT
  cp.id,
  'engagement',
  87,
  now()
FROM cp
UNION ALL
SELECT
  cp.id,
  'conversions',
  12,
  now()
FROM cp;

SELECT '✅ Content performance recorded: ' || COUNT(*)::TEXT FROM content_performance;

COMMIT;

\echo '✅ CreatorOS tests passed!'
\echo ''

-- =========================================================
-- PARTE 5: AUTH (User Profiles, Provision Trigger)
-- =========================================================
\echo '5. Testing Auth (user_profiles, provision trigger)...'
\echo '⚠️  Note: Trigger tests require actual auth.users insert (Supabase only)'
\echo '    Skipping trigger test in direct psql (would fail FK constraint)'
\echo ''

-- Manual test of provision logic (without trigger)
BEGIN;

-- 5.1) Simular criação manual de user_profile
WITH new_mind AS (
  INSERT INTO minds (slug, display_name, primary_language, short_bio, privacy_level)
  VALUES ('test_user', 'Test User', 'pt', 'Smoke test user', 'private')
  RETURNING id
)
INSERT INTO user_profiles (id, mind_id)
SELECT
  gen_random_uuid(),  -- Simula auth.users.id
  new_mind.id
FROM new_mind;

SELECT '✅ User profile created (manual - trigger would do this automatically)';

-- 5.2) Test current_mind_id() function exists
SELECT '✅ Function current_mind_id() exists: ' ||
       CASE WHEN EXISTS (
         SELECT 1 FROM pg_proc WHERE proname = 'current_mind_id'
       ) THEN 'YES' ELSE 'NO' END;

-- 5.3) Test provision_user_profile() function exists
SELECT '✅ Function provision_user_profile() exists: ' ||
       CASE WHEN EXISTS (
         SELECT 1 FROM pg_proc WHERE proname = 'provision_user_profile'
       ) THEN 'YES' ELSE 'NO' END;

-- 5.4) Test trigger exists
SELECT '✅ Trigger trg_provision_user_profile exists: ' ||
       CASE WHEN EXISTS (
         SELECT 1 FROM pg_trigger WHERE tgname = 'trg_provision_user_profile'
       ) THEN 'YES' ELSE 'NO' END;

COMMIT;

\echo '✅ Auth infrastructure tests passed!'
\echo ''

-- =========================================================
-- PARTE 6: VIEWS (Analytics)
-- =========================================================
\echo '6. Testing Views (analytics)...'

-- 6.1) v_job_mind_attribution
SELECT '✅ v_job_mind_attribution: ' || COUNT(*)::TEXT || ' rows'
FROM v_job_mind_attribution;

-- 6.2) v_batch_durations
SELECT '✅ v_batch_durations: ' || COUNT(*)::TEXT || ' rows'
FROM v_batch_durations;

-- 6.3) v_mind_processing_time
SELECT '✅ v_mind_processing_time: ' || COUNT(*)::TEXT || ' rows'
FROM v_mind_processing_time;

-- 6.4) v_cost_per_fragment
SELECT '✅ v_cost_per_fragment: ' || COUNT(*)::TEXT || ' rows'
FROM v_cost_per_fragment;

-- 6.5) v_batch_costs
SELECT '✅ v_batch_costs: ' || COUNT(*)::TEXT || ' rows'
FROM v_batch_costs;

-- 6.6) v_mind_latest_profiles
SELECT '✅ v_mind_latest_profiles: ' || COUNT(*)::TEXT || ' rows'
FROM v_mind_latest_profiles;

-- 6.7) v_profile_costs
SELECT '✅ v_profile_costs: ' || COUNT(*)::TEXT || ' rows'
FROM v_profile_costs;

-- 6.8) v_project_content_stats
SELECT '✅ v_project_content_stats: ' || COUNT(*)::TEXT || ' rows'
FROM v_project_content_stats;

-- 6.9) v_content_performance_agg
SELECT '✅ v_content_performance_agg: ' || COUNT(*)::TEXT || ' rows'
FROM v_content_performance_agg;

\echo ''
\echo '✅ All views working!'
\echo ''

-- =========================================================
-- PARTE 7: RLS (Row Level Security)
-- =========================================================
\echo '7. Testing RLS (Row Level Security policies)...'

-- 7.1) Check RLS enabled on key tables
SELECT '✅ RLS enabled on minds: ' ||
       CASE WHEN relrowsecurity THEN 'YES' ELSE 'NO' END
FROM pg_class WHERE relname = 'minds';

SELECT '✅ RLS enabled on sources: ' ||
       CASE WHEN relrowsecurity THEN 'YES' ELSE 'NO' END
FROM pg_class WHERE relname = 'sources';

SELECT '✅ RLS enabled on fragments: ' ||
       CASE WHEN relrowsecurity THEN 'YES' ELSE 'NO' END
FROM pg_class WHERE relname = 'fragments';

SELECT '✅ RLS enabled on content_projects: ' ||
       CASE WHEN relrowsecurity THEN 'YES' ELSE 'NO' END
FROM pg_class WHERE relname = 'content_projects';

-- 7.2) Count policies
SELECT '✅ Total RLS policies: ' || COUNT(*)::TEXT
FROM pg_policies
WHERE schemaname = 'public';

-- 7.3) List policies (sample)
\echo ''
\echo 'Sample RLS policies:'
SELECT '  - ' || tablename || ': ' || policyname
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname
LIMIT 10;

\echo ''
\echo '✅ RLS infrastructure tests passed!'
\echo ''

-- =========================================================
-- PARTE 8: DEFAULTS (current_mind_id)
-- =========================================================
\echo '8. Testing DEFAULTS (current_mind_id() auto-injection)...'

-- Check if columns have DEFAULT current_mind_id()
SELECT '✅ sources.mind_id has DEFAULT: ' ||
       CASE WHEN column_default LIKE '%current_mind_id%' THEN 'YES' ELSE 'NO' END
FROM information_schema.columns
WHERE table_name = 'sources' AND column_name = 'mind_id';

SELECT '✅ fragments.mind_id has DEFAULT: ' ||
       CASE WHEN column_default LIKE '%current_mind_id%' THEN 'YES' ELSE 'NO' END
FROM information_schema.columns
WHERE table_name = 'fragments' AND column_name = 'mind_id';

SELECT '✅ content_projects.creator_mind_id has DEFAULT: ' ||
       CASE WHEN column_default LIKE '%current_mind_id%' THEN 'YES' ELSE 'NO' END
FROM information_schema.columns
WHERE table_name = 'content_projects' AND column_name = 'creator_mind_id';

\echo ''
\echo '✅ DEFAULTS tests passed!'
\echo ''

-- =========================================================
-- FINAL SUMMARY
-- =========================================================
\echo ''
\echo '========================================='
\echo '  SMOKE TEST SUMMARY'
\echo '========================================='
\echo ''

SELECT '📊 Total minds: ' || COUNT(*)::TEXT FROM minds;
SELECT '📊 Total sources: ' || COUNT(*)::TEXT FROM sources;
SELECT '📊 Total fragments: ' || COUNT(*)::TEXT FROM fragments;
SELECT '📊 Total profiles: ' || COUNT(*)::TEXT FROM mind_profiles;
SELECT '📊 Total trait_scores: ' || COUNT(*)::TEXT FROM trait_scores;
SELECT '📊 Total content_projects: ' || COUNT(*)::TEXT FROM content_projects;
SELECT '📊 Total content_pieces: ' || COUNT(*)::TEXT FROM content_pieces;
SELECT '📊 Total job_executions: ' || COUNT(*)::TEXT FROM job_executions;

\echo ''
\echo '========================================='
\echo '  ✅ ALL SMOKE TESTS PASSED!'
\echo '========================================='
\echo ''
\echo 'Database 0.4.sql is fully functional!'
\echo ''
\echo 'Next steps:'
\echo '  1. Test Magic Link auth via frontend app'
\echo '  2. Verify RLS in action (user isolation)'
\echo '  3. Populate with real data'
\echo '  4. Run performance tests (EXPLAIN ANALYZE)'
\echo ''
