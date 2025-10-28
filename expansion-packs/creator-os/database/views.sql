-- ════════════════════════════════════════════════════════════════════════════════
-- CREATORÓS DATABASE VIEWS - Queries Úteis
-- ════════════════════════════════════════════════════════════════════════════════
-- Views para análises comuns, relatórios e queries frequentes
-- ════════════════════════════════════════════════════════════════════════════════

-- ────────────────────────────────────────────────────────────────────────────────
-- V_COLLECTED_CONTENTS - Conteúdos coletados com dados de source
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_collected_contents AS
SELECT
  c.id,
  c.slug,
  c.title,
  c.content_type,
  c.content,
  get_word_count(c.content) as word_count,

  -- Metadata extraído
  c.metadata->>'source_url' as source_url,
  c.metadata->>'source_platform' as source_platform,
  (c.metadata->>'source_date')::date as source_date,
  c.metadata->>'processing_status' as processing_status,
  c.metadata->>'quality' as quality,
  c.metadata->>'language' as language,

  -- Minds associadas
  ARRAY_AGG(DISTINCT m.display_name) FILTER (WHERE m.id IS NOT NULL) as minds,
  ARRAY_AGG(DISTINCT cm.role) FILTER (WHERE cm.role IS NOT NULL) as roles,

  -- Tags
  ARRAY_AGG(DISTINCT t.name) FILTER (WHERE t.id IS NOT NULL) as tags,

  c.status,
  c.file_path,
  c.created_at,
  c.updated_at
FROM contents c
LEFT JOIN content_minds cm ON cm.content_id = c.id
LEFT JOIN minds m ON m.id = cm.mind_id
LEFT JOIN content_tags ct ON ct.content_id = c.id
LEFT JOIN tags t ON t.id = ct.tag_id
WHERE c.ai_generated = false
  AND c.deleted_at IS NULL
GROUP BY c.id;

COMMENT ON VIEW v_collected_contents IS 'Conteúdos coletados (ai_generated=false) com metadata de source extraído e minds associadas';

-- ────────────────────────────────────────────────────────────────────────────────
-- V_GENERATED_CONTENTS - Conteúdos gerados com dados de LLM e projeto
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_generated_contents AS
SELECT
  c.id,
  c.slug,
  c.title,
  c.content_type,
  c.content,
  get_word_count(c.content) as word_count,

  -- Projeto
  p.name as project_name,
  p.slug as project_slug,
  p.project_type,

  -- Audience
  ap.name as audience_name,
  c.metadata->>'audience_id' as audience_id,

  -- Persona
  c.metadata->>'persona_type' as persona_type,

  -- Frameworks
  c.metadata->'frameworks' as frameworks_used,

  -- Quality scores
  c.fidelity_score,
  c.metadata->>'readability_score' as readability_score,
  c.metadata->'validation_scores' as validation_scores,

  -- LLM tracking (via job_executions)
  je.llm_provider,
  je.llm_model,
  je.llm_version,
  je.tokens_total,
  je.cost_usd as generation_cost,
  je.latency_ms as generation_duration_ms,
  je.params as generation_params,

  -- Minds (creators)
  ARRAY_AGG(DISTINCT m.display_name) FILTER (WHERE m.id IS NOT NULL) as creators,

  -- Tags
  ARRAY_AGG(DISTINCT t.name) FILTER (WHERE t.id IS NOT NULL) as tags,

  c.status,
  c.published_at,
  c.published_url,
  c.file_path,
  c.created_at,
  c.updated_at
FROM contents c
LEFT JOIN content_projects p ON p.id = c.project_id
LEFT JOIN audience_profiles ap ON ap.id = (c.metadata->>'audience_id')::uuid
LEFT JOIN job_executions je ON je.id = c.generation_execution_id
LEFT JOIN content_minds cm ON cm.content_id = c.id AND cm.role IN ('creator', 'author')
LEFT JOIN minds m ON m.id = cm.mind_id
LEFT JOIN content_tags ct ON ct.content_id = c.id
LEFT JOIN tags t ON t.id = ct.tag_id
WHERE c.ai_generated = true
  AND c.deleted_at IS NULL
GROUP BY c.id, p.id, ap.id, je.id;

COMMENT ON VIEW v_generated_contents IS 'Conteúdos gerados (ai_generated=true) com dados de LLM, projeto, audience e creators';

-- ────────────────────────────────────────────────────────────────────────────────
-- V_MULTI_MIND_CONTENTS - Conteúdos com múltiplas minds (entrevistas, podcasts, debates)
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_multi_mind_contents AS
SELECT
  c.id,
  c.slug,
  c.title,
  c.content_type,
  c.ai_generated,
  COUNT(cm.mind_id) as minds_count,
  ARRAY_AGG(m.display_name ORDER BY
    CASE cm.role
      WHEN 'host' THEN 1
      WHEN 'interviewer' THEN 2
      WHEN 'creator' THEN 3
      WHEN 'author' THEN 4
      ELSE 5
    END
  ) as participants,
  ARRAY_AGG(cm.role ORDER BY
    CASE cm.role
      WHEN 'host' THEN 1
      WHEN 'interviewer' THEN 2
      WHEN 'creator' THEN 3
      WHEN 'author' THEN 4
      ELSE 5
    END
  ) as roles,
  get_word_count(c.content) as word_count,
  c.metadata->>'source_platform' as platform,
  c.status,
  c.created_at
FROM contents c
JOIN content_minds cm ON cm.content_id = c.id
JOIN minds m ON m.id = cm.mind_id
WHERE c.deleted_at IS NULL
GROUP BY c.id
HAVING COUNT(cm.mind_id) > 1;

COMMENT ON VIEW v_multi_mind_contents IS 'Conteúdos com múltiplas minds (entrevistas, podcasts, conversas, debates)';

-- ────────────────────────────────────────────────────────────────────────────────
-- V_GENERATION_COSTS - Custos e analytics de geração de conteúdo
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_generation_costs AS
SELECT
  je.llm_provider,
  je.llm_model,
  je.llm_version,
  COUNT(c.id) as contents_generated,
  SUM(je.tokens_total) as total_tokens,
  AVG(je.tokens_total) as avg_tokens_per_content,
  SUM(je.cost_usd) as total_cost_usd,
  AVG(je.cost_usd) as avg_cost_per_content,
  AVG(je.latency_ms) as avg_latency_ms,
  AVG(c.fidelity_score) as avg_fidelity_score,
  MIN(je.executed_at) as first_generation,
  MAX(je.executed_at) as last_generation
FROM contents c
JOIN job_executions je ON je.id = c.generation_execution_id
WHERE c.ai_generated = true
  AND c.deleted_at IS NULL
  AND je.status = 'completed'
GROUP BY je.llm_provider, je.llm_model, je.llm_version
ORDER BY total_cost_usd DESC;

COMMENT ON VIEW v_generation_costs IS 'Analytics de custos de geração por modelo LLM';

-- ────────────────────────────────────────────────────────────────────────────────
-- V_CONTENT_HIERARCHY - Hierarquia de conteúdos (cursos, livros) com depth_level
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_content_hierarchy AS
WITH RECURSIVE hierarchy AS (
  -- Base: raízes (sem parent)
  SELECT
    id,
    slug,
    title,
    content_type,
    parent_content_id,
    sequence_order,
    0 as depth_level,
    ARRAY[sequence_order] as path,
    slug as root_slug
  FROM contents
  WHERE parent_content_id IS NULL
    AND deleted_at IS NULL

  UNION ALL

  -- Recursive: filhos
  SELECT
    c.id,
    c.slug,
    c.title,
    c.content_type,
    c.parent_content_id,
    c.sequence_order,
    h.depth_level + 1,
    h.path || c.sequence_order,
    h.root_slug
  FROM contents c
  JOIN hierarchy h ON c.parent_content_id = h.id
  WHERE c.deleted_at IS NULL
)
SELECT
  h.id,
  h.slug,
  h.title,
  h.content_type,
  h.parent_content_id,
  h.sequence_order,
  h.depth_level,
  h.path,
  h.root_slug,
  c.project_id,
  p.name as project_name,
  get_word_count(c.content) as word_count,
  c.status,
  c.created_at
FROM hierarchy h
JOIN contents c ON c.id = h.id
LEFT JOIN content_projects p ON p.id = c.project_id
ORDER BY h.root_slug, h.path;

COMMENT ON VIEW v_content_hierarchy IS 'Hierarquia completa de conteúdos (cursos, livros) com depth_level calculado recursivamente';

-- ────────────────────────────────────────────────────────────────────────────────
-- V_PROJECT_PERFORMANCE - Performance de projetos (conteúdos publicados, custos, qualidade)
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_project_performance AS
SELECT
  p.id as project_id,
  p.slug as project_slug,
  p.name as project_name,
  p.project_type,
  p.status as project_status,
  COUNT(c.id) as total_contents,
  COUNT(c.id) FILTER (WHERE c.status = 'published') as published_contents,
  COUNT(c.id) FILTER (WHERE c.status = 'draft') as draft_contents,
  SUM(get_word_count(c.content)) as total_word_count,
  AVG(c.fidelity_score) as avg_fidelity_score,
  AVG((c.metadata->>'readability_score')::numeric) as avg_readability_score,
  SUM(je.cost_usd) as total_generation_cost,
  AVG(je.cost_usd) as avg_cost_per_content,
  SUM(je.tokens_total) as total_tokens,
  MIN(c.created_at) as first_content_at,
  MAX(c.published_at) as last_published_at,
  ap.name as target_audience
FROM content_projects p
LEFT JOIN contents c ON c.project_id = p.id AND c.deleted_at IS NULL
LEFT JOIN job_executions je ON je.id = c.generation_execution_id AND je.status = 'completed'
LEFT JOIN audience_profiles ap ON ap.id = p.target_audience_id
GROUP BY p.id, ap.name
ORDER BY total_contents DESC;

COMMENT ON VIEW v_project_performance IS 'Performance de projetos: conteúdos, custos, qualidade, publicações';

-- ────────────────────────────────────────────────────────────────────────────────
-- V_MIND_CONTENT_STATS - Estatísticas de conteúdo por mind
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_mind_content_stats AS
SELECT
  m.id as mind_id,
  m.display_name,
  COUNT(c.id) as total_contents,
  COUNT(c.id) FILTER (WHERE c.ai_generated = false) as collected_contents,
  COUNT(c.id) FILTER (WHERE c.ai_generated = true) as generated_contents,
  COUNT(c.id) FILTER (WHERE c.ai_generated = true AND cm.role = 'creator') as contents_created,
  COUNT(c.id) FILTER (WHERE cm.role = 'host') as contents_as_host,
  COUNT(c.id) FILTER (WHERE cm.role = 'guest') as contents_as_guest,
  SUM(get_word_count(c.content)) as total_word_count,
  AVG(c.fidelity_score) FILTER (WHERE c.ai_generated = true) as avg_fidelity_score,
  MIN(c.created_at) as first_content_at,
  MAX(c.created_at) as last_content_at
FROM minds m
LEFT JOIN content_minds cm ON cm.mind_id = m.id
LEFT JOIN contents c ON c.id = cm.content_id AND c.deleted_at IS NULL
GROUP BY m.id;

COMMENT ON VIEW v_mind_content_stats IS 'Estatísticas de conteúdo por mind (collected, generated, roles)';

-- ────────────────────────────────────────────────────────────────────────────────
-- V_CONTENT_WITH_FRAMEWORKS - Conteúdos com frameworks aplicados (denormalized)
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_content_with_frameworks AS
SELECT
  c.id,
  c.slug,
  c.title,
  c.content_type,
  c.project_id,
  p.name as project_name,
  jsonb_array_elements_text(c.metadata->'frameworks') as framework_slug,
  cf.name as framework_name,
  cf.framework_type,
  c.fidelity_score,
  c.status,
  c.created_at
FROM contents c
JOIN content_projects p ON p.id = c.project_id
LEFT JOIN content_frameworks cf ON cf.slug = jsonb_array_elements_text(c.metadata->'frameworks')
WHERE c.ai_generated = true
  AND c.deleted_at IS NULL
  AND c.metadata->'frameworks' IS NOT NULL;

COMMENT ON VIEW v_content_with_frameworks IS 'Conteúdos gerados com frameworks aplicados (denormalized para análise)';

-- ────────────────────────────────────────────────────────────────────────────────
-- V_RECENT_CONTENTS - Conteúdos recentes (últimos 30 dias)
-- ────────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW v_recent_contents AS
SELECT
  c.id,
  c.slug,
  c.title,
  c.content_type,
  c.ai_generated,
  CASE
    WHEN c.ai_generated THEN p.name
    ELSE c.metadata->>'source_platform'
  END as source_or_project,
  ARRAY_AGG(DISTINCT m.display_name) as minds,
  get_word_count(c.content) as word_count,
  c.status,
  c.created_at,
  now() - c.created_at as age
FROM contents c
LEFT JOIN content_projects p ON p.id = c.project_id
LEFT JOIN content_minds cm ON cm.content_id = c.id
LEFT JOIN minds m ON m.id = cm.mind_id
WHERE c.deleted_at IS NULL
  AND c.created_at > now() - INTERVAL '30 days'
GROUP BY c.id, p.name
ORDER BY c.created_at DESC;

COMMENT ON VIEW v_recent_contents IS 'Conteúdos criados nos últimos 30 dias';

-- ════════════════════════════════════════════════════════════════════════════════
-- MATERIALIZED VIEWS (para queries pesadas)
-- ════════════════════════════════════════════════════════════════════════════════
-- Uncomment se precisar de performance em analytics:

-- CREATE MATERIALIZED VIEW mv_generation_costs AS
-- SELECT * FROM v_generation_costs;
-- CREATE UNIQUE INDEX ON mv_generation_costs(llm_provider, llm_model, llm_version);
--
-- -- Refresh command:
-- -- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_generation_costs;

-- ════════════════════════════════════════════════════════════════════════════════
-- END OF VIEWS
-- ════════════════════════════════════════════════════════════════════════════════
