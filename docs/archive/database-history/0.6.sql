-- =========================================================
-- InnerLens + AIOS Unified Database — FULL DDL (KISS • Supabase PG16+)
-- =========================================================
-- Requisitos:
--   - Supabase (PostgreSQL 16+)
--   - Extensão pgcrypto (gen_random_uuid)
-- Observações:
--   - RLS mínima (1 policy por tabela de cliente, operacional sem RLS)
--   - Mind é a raiz conceitual; usuário (auth.users) mapeia 1:1 para sua mind
--   - Proveniência completa: ingestion_batches → processing_queue → job_executions
--   - Busca: FTS (GIN) em fragments
--   - Relevância: 0..10 (coluna derivada 0.0..1.0)

-- ==============
-- EXTENSIONS
-- ==============
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ==============
-- FUNÇÕES GERAIS
-- ==============
-- updated_at trigger
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger AS $$
BEGIN NEW.updated_at := now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

-- arredonda input (0..1) para décimos (≥0.08 sobe)
CREATE OR REPLACE FUNCTION snap_to_tenth(score NUMERIC)
RETURNS SMALLINT
LANGUAGE plpgsql IMMUTABLE AS $$
DECLARE t NUMERIC := score * 10; i INT := floor(t); r NUMERIC := t - i;
BEGIN
  IF score <= 0 THEN RETURN 0; END IF;
  IF score >= 1 THEN RETURN 10; END IF;
  IF r >= 0.8 THEN RETURN LEAST(i+1,10); ELSE RETURN GREATEST(i,0); END IF;
END $$;

-- =======================
-- ENTIDADES IDENTIDADE
-- =======================
CREATE TABLE IF NOT EXISTS minds (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  primary_language CHAR(2),                -- 'pt','en',...
  short_bio TEXT,
  -- meta leve (sem agregados derivados)
  category TEXT,                           -- p.ex. 'entrepreneur','creator'
  primary_domain TEXT,                     -- p.ex. 'cognitive_philosophy'
  quality_grade TEXT,                      -- 'A'..'D' (livre)
  apex_score NUMERIC(3,2),                 -- 0.00..1.00
  completeness NUMERIC(3,2),               -- 0.00..1.00
  confidence_avg NUMERIC(3,2),             -- 0.00..1.00
  privacy_level TEXT NOT NULL DEFAULT 'public' CHECK (privacy_level IN ('public','private')),
  extra JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_minds_updated') THEN
    CREATE TRIGGER trg_minds_updated BEFORE UPDATE ON minds
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS mind_aliases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  alias TEXT NOT NULL,
  UNIQUE (mind_id, alias)
);

-- =======================
-- CATEGORIAS / LOOKUPS
-- =======================
CREATE TABLE IF NOT EXISTS categories (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT
);

-- =======================
-- PROVENIÊNCIA (SOURCES)
-- =======================
CREATE TABLE IF NOT EXISTS sources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  title TEXT NOT NULL,
  type TEXT NOT NULL,               -- 'book','article','podcast','interview','dossier','web',...
  platform TEXT,                    -- 'web','youtube','spotify','x','medium',...
  author TEXT,
  published_date DATE NOT NULL,
  url TEXT,
  language CHAR(2),
  quality TEXT NOT NULL,            -- 'primary','secondary','tertiary'
  status TEXT,                      -- 'raw','processed','validated'
  publisher TEXT,
  isbn TEXT,
  page_count INT,
  duration TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_sources_mind           ON sources (mind_id);
CREATE INDEX IF NOT EXISTS idx_sources_published_date ON sources (published_date);
CREATE INDEX IF NOT EXISTS idx_sources_type           ON sources (type);
CREATE INDEX IF NOT EXISTS idx_sources_author         ON sources (author);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_sources_updated') THEN
    CREATE TRIGGER trg_sources_updated BEFORE UPDATE ON sources
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- =========================================
-- OPERACIONAL (lotes → fila → execuções)
-- =========================================
CREATE TABLE IF NOT EXISTS ingestion_batches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pipeline_version TEXT NOT NULL,        -- 'innerlens.v1.0'
  llm_provider TEXT,                     -- 'openai','anthropic','google',...
  llm_model TEXT,                        -- 'gpt-5','claude-4.1-sonnet',...
  llm_version TEXT,
  prompt_hash TEXT,
  params JSONB,
  created_by TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS processing_queue (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,
  job_type TEXT NOT NULL,        -- 'ingest_source','chunk','extract_fragments','enrich',...
  scope_type TEXT NOT NULL,      -- 'mind','source','fragment','file','url'
  scope_id UUID,                 -- alvo (minds.id/sources.id/...)
  priority SMALLINT NOT NULL DEFAULT 5 CHECK (priority BETWEEN 1 AND 9),
  status TEXT NOT NULL DEFAULT 'queued',  -- 'queued','running','done','error','retry'
  attempts SMALLINT NOT NULL DEFAULT 0,
  scheduled_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  started_at TIMESTAMPTZ,
  finished_at TIMESTAMPTZ,
  last_error TEXT
);
CREATE INDEX IF NOT EXISTS idx_pq_status_prio ON processing_queue (status, priority, scheduled_at);
CREATE INDEX IF NOT EXISTS idx_pq_batch       ON processing_queue (batch_id);
CREATE INDEX IF NOT EXISTS idx_pq_scope       ON processing_queue (scope_type, scope_id);

CREATE TABLE IF NOT EXISTS job_executions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  queue_id UUID NOT NULL REFERENCES processing_queue(id) ON DELETE CASCADE,
  -- LLM efetivamente usado
  llm_provider TEXT,
  llm_model TEXT,
  llm_version TEXT,
  params JSONB,
  -- métricas
  tokens_prompt INT,
  tokens_completion INT,
  tokens_total INT GENERATED ALWAYS AS (COALESCE(tokens_prompt,0)+COALESCE(tokens_completion,0)) STORED,
  cost_usd NUMERIC(12,6),
  latency_ms INT,
  input_bytes INT,
  output_bytes INT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_exec_queue   ON job_executions (queue_id);
CREATE INDEX IF NOT EXISTS idx_exec_created ON job_executions (created_at);
CREATE INDEX IF NOT EXISTS idx_exec_model   ON job_executions (llm_provider, llm_model);

-- ======================
-- FRAGMENTS (núcleo)
-- ======================
CREATE TABLE IF NOT EXISTS fragments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  source_id UUID NOT NULL REFERENCES sources(id) ON DELETE RESTRICT,
  category_id BIGINT NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
  ingestion_batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,
  layer SMALLINT,                                    -- 0..8
  location TEXT NOT NULL,
  type TEXT NOT NULL,                                -- 'direct_quote','framework','principle',...
  fragment_type TEXT,                                -- 'written_thought','spoken','image_caption',...
  evidence_type TEXT,                                -- 'primary','secondary'
  relevance_10 SMALLINT NOT NULL CHECK (relevance_10 BETWEEN 0 AND 10),
  relevance NUMERIC(2,1) GENERATED ALWAYS AS (relevance_10/10.0) STORED,
  confidence NUMERIC(3,2),                           -- 0.00..1.00
  content TEXT NOT NULL,
  context TEXT NOT NULL,
  insight TEXT NOT NULL,
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  -- FTS
  tsv tsvector GENERATED ALWAYS AS (
    setweight(to_tsvector('simple', coalesce(content,'')), 'A') ||
    setweight(to_tsvector('simple', coalesce(context,'')), 'B') ||
    setweight(to_tsvector('simple', coalesce(insight,'')), 'C')
  ) STORED,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (source_id, location)
);
CREATE INDEX IF NOT EXISTS idx_frag_tsv      ON fragments USING GIN (tsv);
CREATE INDEX IF NOT EXISTS idx_frag_mind     ON fragments (mind_id);
CREATE INDEX IF NOT EXISTS idx_frag_source   ON fragments (source_id);
CREATE INDEX IF NOT EXISTS idx_frag_category ON fragments (category_id);
CREATE INDEX IF NOT EXISTS idx_frag_rel10    ON fragments (relevance_10);
CREATE INDEX IF NOT EXISTS idx_frag_type     ON fragments (type);
CREATE INDEX IF NOT EXISTS idx_frag_layer    ON fragments (layer);
-- hot paths
CREATE INDEX IF NOT EXISTS idx_frag_mind_rel10_desc ON fragments (mind_id, relevance_10 DESC) INCLUDE (id, content, created_at);
CREATE INDEX IF NOT EXISTS idx_frag_source_created  ON fragments (source_id, created_at DESC) INCLUDE (id, content, relevance);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_fragments_updated') THEN
    CREATE TRIGGER trg_fragments_updated BEFORE UPDATE ON fragments
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- ======================
-- TAGGING
-- ======================
CREATE TABLE IF NOT EXISTS tags (
  id BIGSERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,              -- case-sensitive
  tag_type TEXT NOT NULL,                 -- 'domain','theme'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_tags_type ON tags (tag_type);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_tags_updated') THEN
    CREATE TRIGGER trg_tags_updated BEFORE UPDATE ON tags
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS fragment_tags (
  fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  tag_id BIGINT NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (fragment_id, tag_id)
);
CREATE INDEX IF NOT EXISTS idx_ft_tag  ON fragment_tags (tag_id) INCLUDE (fragment_id);
CREATE INDEX IF NOT EXISTS idx_ft_frag ON fragment_tags (fragment_id) INCLUDE (tag_id);

-- ======================
-- RELACIONAMENTOS (grafo)
-- ======================
CREATE TABLE IF NOT EXISTS fragment_relationships (
  from_fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  to_fragment_id   UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  relationship_type TEXT NOT NULL DEFAULT 'related',  -- 'related','supports','contradicts'
  PRIMARY KEY (from_fragment_id, to_fragment_id),
  CHECK (from_fragment_id <> to_fragment_id)
);
CREATE INDEX IF NOT EXISTS idx_rel_from ON fragment_relationships (from_fragment_id);
CREATE INDEX IF NOT EXISTS idx_rel_to   ON fragment_relationships (to_fragment_id);
CREATE INDEX IF NOT EXISTS idx_rel_type ON fragment_relationships (relationship_type);
-- related canônico
CREATE UNIQUE INDEX IF NOT EXISTS ux_related_canonical
  ON fragment_relationships (
    LEAST(from_fragment_id, to_fragment_id),
    GREATEST(from_fragment_id, to_fragment_id)
  )
  WHERE relationship_type = 'related';

-- ======================
-- TAXONOMIA (competências)
-- ======================
CREATE TABLE IF NOT EXISTS domains (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS specializations (
  id BIGSERIAL PRIMARY KEY,
  domain_id BIGINT NOT NULL REFERENCES domains(id) ON DELETE CASCADE,
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS skills (
  id BIGSERIAL PRIMARY KEY,
  specialization_id BIGINT NOT NULL REFERENCES specializations(id) ON DELETE CASCADE,
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS mind_proficiencies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES skills(id) ON DELETE RESTRICT,
  level_10 SMALLINT NOT NULL CHECK (level_10 BETWEEN 0 AND 10),
  level NUMERIC(2,1) GENERATED ALWAYS AS (level_10/10.0) STORED,
  confidence NUMERIC(3,2),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS ux_mind_skill ON mind_proficiencies (mind_id, skill_id);

CREATE TABLE IF NOT EXISTS mind_proficiency_evidence (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_proficiency_id UUID NOT NULL REFERENCES mind_proficiencies(id) ON DELETE CASCADE,
  fragment_id UUID REFERENCES fragments(id) ON DELETE SET NULL,
  source_id UUID REFERENCES sources(id) ON DELETE SET NULL,
  note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ======================
-- TRAITS (InnerLens)
-- ======================
CREATE TABLE IF NOT EXISTS traits (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,  -- 'openness','conscientiousness','intellect', etc.
  name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS trait_scores (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  trait_id BIGINT NOT NULL REFERENCES traits(id) ON DELETE RESTRICT,
  score_10 SMALLINT NOT NULL CHECK (score_10 BETWEEN 0 AND 10),
  score NUMERIC(2,1) GENERATED ALWAYS AS (score_10/10.0) STORED,
  confidence NUMERIC(3,2),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS ux_trait_per_mind ON trait_scores (mind_id, trait_id);

CREATE TABLE IF NOT EXISTS trait_score_evidence (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trait_score_id UUID NOT NULL REFERENCES trait_scores(id) ON DELETE CASCADE,
  fragment_id UUID REFERENCES fragments(id) ON DELETE SET NULL,
  source_id UUID REFERENCES sources(id) ON DELETE SET NULL,
  note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ======================
-- ARTEFATOS (MMOS Profiles)
-- ======================
CREATE TABLE IF NOT EXISTS mind_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  layer SMALLINT,                                     -- 1..8 (opcional)
  profile_type TEXT NOT NULL,                         -- 'psychometrics','writing_style','voice_guide','values_hierarchy','routine',...
  title TEXT,
  format TEXT,                                        -- 'yaml','md','json'
  payload JSONB NOT NULL,
  confidence_level TEXT,                              -- 'low','medium','high'
  source_count INT,
  extraction_date DATE,
  human_validation_status TEXT,                       -- 'PENDING','APPROVED','REJECTED'
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_profiles_mind_type ON mind_profiles (mind_id, profile_type, created_at DESC);

CREATE TABLE IF NOT EXISTS mind_profile_evidence (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id UUID NOT NULL REFERENCES mind_profiles(id) ON DELETE CASCADE,
  fragment_id UUID REFERENCES fragments(id) ON DELETE SET NULL,
  source_id UUID REFERENCES sources(id) ON DELETE SET NULL,
  note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- sinais destilados
CREATE TABLE IF NOT EXISTS mind_values (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  rank INT,
  intensity SMALLINT,                                 -- 0..10
  alignment_score SMALLINT,                           -- 0..100
  confidence_level TEXT,
  profile_id UUID REFERENCES mind_profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (mind_id, name)
);

CREATE TABLE IF NOT EXISTS mind_routine_windows (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  window_name TEXT NOT NULL,                          -- 'deep_work_prime_time', ...
  start_local TIME NOT NULL,
  end_local TIME NOT NULL,
  timezone TEXT NOT NULL,                             -- 'America/Sao_Paulo'
  consistency TEXT,                                   -- 'daily','weekdays',...
  profile_id UUID REFERENCES mind_profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS mind_psychometrics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL UNIQUE REFERENCES minds(id) ON DELETE CASCADE,
  model TEXT,                                         -- 'big_five','mbti','enneagram',...
  payload JSONB NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS mind_obsessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  intensity SMALLINT,                                 -- 0..10
  confidence_level TEXT,
  profile_id UUID REFERENCES mind_profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ======================
-- CREATOR OS (P1)
-- ======================
CREATE TABLE IF NOT EXISTS content_projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  persona_mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  name TEXT NOT NULL,
  description TEXT,
  goals TEXT[] DEFAULT '{}'::text[],                  -- {'thought_leadership','newsletter'}
  status TEXT NOT NULL DEFAULT 'active',              -- 'active','paused','archived'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_cp_creator ON content_projects (creator_mind_id);
CREATE INDEX IF NOT EXISTS idx_cp_persona ON content_projects (persona_mind_id);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_projects_updated') THEN
    CREATE TRIGGER trg_content_projects_updated BEFORE UPDATE ON content_projects
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS audience_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  age_range TEXT,
  psychographic_traits JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_aud_project ON audience_profiles (project_id);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_audience_profiles_updated') THEN
    CREATE TRIGGER trg_audience_profiles_updated BEFORE UPDATE ON audience_profiles
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS content_pieces (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE RESTRICT,
  type TEXT NOT NULL,                                  -- 'blog','social','video_script','newsletter','course'
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  voice_fidelity_score NUMERIC(3,2),                   -- 0.00..1.00
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (project_id, title)
);
CREATE INDEX IF NOT EXISTS idx_cp_project   ON content_pieces (project_id);
CREATE INDEX IF NOT EXISTS idx_cp_type      ON content_pieces (type);
CREATE INDEX IF NOT EXISTS idx_cp_published ON content_pieces (published_at DESC);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_pieces_updated') THEN
    CREATE TRIGGER trg_content_pieces_updated BEFORE UPDATE ON content_pieces
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS content_campaigns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  goal TEXT,
  start_date DATE,
  end_date DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_cc_project ON content_campaigns (project_id);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_campaigns_updated') THEN
    CREATE TRIGGER trg_content_campaigns_updated BEFORE UPDATE ON content_campaigns
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS content_campaign_pieces (
  campaign_id UUID NOT NULL REFERENCES content_campaigns(id) ON DELETE CASCADE,
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,
  PRIMARY KEY (campaign_id, content_piece_id)
);
CREATE INDEX IF NOT EXISTS idx_ccp_piece ON content_campaign_pieces (content_piece_id);

CREATE TABLE IF NOT EXISTS content_performance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,
  metric_type TEXT NOT NULL,                            -- 'views','engagement','conversions','shares'
  value NUMERIC,
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_cperf_piece_time ON content_performance (content_piece_id, recorded_at DESC);
CREATE INDEX IF NOT EXISTS idx_cperf_metric     ON content_performance (metric_type);

-- OPTIONAL (P2): frameworks
CREATE TABLE IF NOT EXISTS content_frameworks (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,                            -- 'gps','aida','pas','bloom'
  name TEXT NOT NULL,
  type TEXT NOT NULL,                                   -- 'pedagogical','storytelling','marketing'
  description TEXT
);
ALTER TABLE content_pieces
  ADD COLUMN IF NOT EXISTS framework_id BIGINT REFERENCES content_frameworks(id);
CREATE INDEX IF NOT EXISTS idx_cp_framework ON content_pieces (framework_id);

-- ============
-- VIEWS
-- ============
-- Atribuição execução→mente (prioridade: mind → source → fragment)
CREATE OR REPLACE VIEW v_job_mind_attribution AS
SELECT
  je.id            AS execution_id,
  je.queue_id,
  COALESCE(
    NULLIF(CASE WHEN pq.scope_type='mind'    THEN pq.scope_id END, NULL),
    (CASE WHEN pq.scope_type='source'  THEN s.mind_id END),
    (CASE WHEN pq.scope_type='fragment' THEN f.mind_id END)
  ) AS mind_id,
  je.created_at
FROM job_executions je
JOIN processing_queue pq ON pq.id = je.queue_id
LEFT JOIN sources   s ON s.id = pq.scope_id
LEFT JOIN fragments f ON f.id = pq.scope_id;

-- Durações por lote
CREATE OR REPLACE VIEW v_batch_durations AS
SELECT
  batch_id,
  COUNT(*)                                         AS jobs,
  SUM(EXTRACT(EPOCH FROM (finished_at - started_at)))::INT AS seconds_total,
  MIN(started_at) AS first_started_at,
  MAX(finished_at) AS last_finished_at
FROM processing_queue
WHERE status IN ('done','error')
GROUP BY batch_id;

-- Tempo por mente (derivado)
CREATE OR REPLACE VIEW v_mind_processing_time AS
SELECT
  a.mind_id,
  SUM(EXTRACT(EPOCH FROM (pq.finished_at - pq.started_at)))::INT AS seconds_total
FROM v_job_mind_attribution a
JOIN processing_queue pq ON pq.id = a.queue_id
WHERE pq.status IN ('done','error')
GROUP BY a.mind_id;

-- Custo/tokens por fragmento
CREATE OR REPLACE VIEW v_cost_per_fragment AS
SELECT
  f.id                 AS fragment_id,
  f.mind_id,
  f.source_id,
  f.relevance,
  je.llm_provider,
  je.llm_model,
  je.tokens_prompt,
  je.tokens_completion,
  je.tokens_total,
  je.cost_usd,
  je.latency_ms,
  pq.batch_id,
  je.created_at       AS executed_at
FROM fragments f
LEFT JOIN job_executions je ON je.id = f.generation_execution_id
LEFT JOIN processing_queue pq ON pq.id = je.queue_id;

-- Agregado por lote/modelo
CREATE OR REPLACE VIEW v_batch_costs AS
SELECT
  pq.batch_id,
  je.llm_provider,
  je.llm_model,
  COUNT(DISTINCT f.id)                 AS fragments_generated,
  SUM(je.tokens_total)                 AS tokens_total,
  SUM(je.cost_usd)                     AS cost_total_usd,
  AVG(je.latency_ms)                   AS avg_latency_ms,
  MIN(je.created_at)                   AS first_exec_at,
  MAX(je.created_at)                   AS last_exec_at
FROM job_executions je
JOIN processing_queue pq ON pq.id = je.queue_id
LEFT JOIN fragments f ON f.generation_execution_id = je.id
GROUP BY pq.batch_id, je.llm_provider, je.llm_model;

-- Última versão válida por (mind, profile_type)
CREATE OR REPLACE VIEW v_mind_latest_profiles AS
SELECT DISTINCT ON (mind_id, profile_type)
  id, mind_id, profile_type, title, format, payload, confidence_level,
  source_count, extraction_date, human_validation_status, generation_execution_id, created_at
FROM mind_profiles
WHERE COALESCE(human_validation_status,'PENDING') <> 'REJECTED'
ORDER BY mind_id, profile_type, created_at DESC;

-- Custos por artefato (profile)
CREATE OR REPLACE VIEW v_profile_costs AS
SELECT
  p.id AS profile_id,
  p.mind_id,
  p.profile_type,
  je.llm_provider, je.llm_model,
  je.tokens_total, je.cost_usd, je.latency_ms,
  pq.batch_id, je.created_at AS executed_at
FROM mind_profiles p
LEFT JOIN job_executions je ON je.id = p.generation_execution_id
LEFT JOIN processing_queue pq ON pq.id = je.queue_id;

-- CreatorOS views
CREATE OR REPLACE VIEW v_project_content_stats AS
SELECT
  p.id AS project_id,
  COUNT(cp.id) AS pieces_count,
  MAX(cp.published_at) AS last_published_at
FROM content_projects p
LEFT JOIN content_pieces cp ON cp.project_id = p.id
GROUP BY p.id;

CREATE OR REPLACE VIEW v_content_performance_agg AS
SELECT
  cp.content_piece_id,
  cp.metric_type,
  SUM(cp.value) AS total_value,
  MIN(cp.recorded_at) AS first_seen_at,
  MAX(cp.recorded_at) AS last_seen_at
FROM content_performance cp
GROUP BY cp.content_piece_id, cp.metric_type;

-- ==========================================
-- AUTH → MIND (Magic Link passwordless)
-- ==========================================
-- Mapeia auth.users → mind
CREATE TABLE IF NOT EXISTS user_profiles (
  id UUID PRIMARY KEY,  -- = auth.users.id
  mind_id UUID NOT NULL UNIQUE REFERENCES minds(id) ON DELETE RESTRICT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
-- FK explícita para auth.users
ALTER TABLE user_profiles
  ADD CONSTRAINT IF NOT EXISTS fk_user_profiles_auth
  FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;

-- helper: retorna a mind do usuário autenticado
CREATE OR REPLACE FUNCTION current_mind_id()
RETURNS uuid LANGUAGE sql STABLE AS $$
  SELECT mind_id FROM user_profiles WHERE id = auth.uid()
$$;

-- provisionamento automático no primeiro signup (sem backend)
CREATE OR REPLACE FUNCTION provision_user_profile()
RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE v_mind_id uuid; v_slug text;
BEGIN
  v_slug := split_part(NEW.email, '@', 1);
  INSERT INTO minds (slug, display_name, primary_language, short_bio)
  VALUES (v_slug, COALESCE(NEW.raw_user_meta_data->>'name', v_slug), 'pt', '')
  ON CONFLICT (slug) DO NOTHING
  RETURNING id INTO v_mind_id;

  IF v_mind_id IS NULL THEN
    SELECT id INTO v_mind_id FROM minds WHERE slug = v_slug LIMIT 1;
  END IF;

  INSERT INTO user_profiles (id, mind_id) VALUES (NEW.id, v_mind_id)
  ON CONFLICT (id) DO NOTHING;

  RETURN NEW;
END $$;
DROP TRIGGER IF EXISTS trg_provision_user_profile ON auth.users;
CREATE TRIGGER trg_provision_user_profile
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION provision_user_profile();

-- =======================================================
-- RLS MÍNIMA (anti-atrio): 1 policy por tabela + DEFAULTS
-- =======================================================
-- Defaults para evitar enviar mind_id do cliente
ALTER TABLE sources   ALTER COLUMN mind_id SET DEFAULT current_mind_id();
ALTER TABLE fragments ALTER COLUMN mind_id SET DEFAULT current_mind_id();
ALTER TABLE mind_profiles ALTER COLUMN mind_id SET DEFAULT current_mind_id();

-- CreatorOS defaults
ALTER TABLE content_projects ALTER COLUMN creator_mind_id SET DEFAULT current_mind_id();

-- Habilitar RLS nas tabelas de cliente
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE minds         ENABLE ROW LEVEL SECURITY;
ALTER TABLE sources       ENABLE ROW LEVEL SECURITY;
ALTER TABLE fragments     ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_values   ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_obsessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_routine_windows ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_psychometrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE trait_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_proficiencies ENABLE ROW LEVEL SECURITY;

ALTER TABLE content_projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_pieces   ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_campaigns ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_campaign_pieces ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_performance ENABLE ROW LEVEL SECURITY;

-- Operacional (acesso só via service role) → não habilitar RLS
-- ingestion_batches / processing_queue / job_executions: deixam como está

-- Policies mínimas (FOR ALL, usando current_mind_id)
-- user_profiles: só o próprio
CREATE POLICY IF NOT EXISTS "user_profiles_me"
ON user_profiles FOR ALL TO authenticated
USING (id = auth.uid()) WITH CHECK (id = auth.uid());

-- minds: leitura pública ou minha; sem update público por ora
CREATE POLICY IF NOT EXISTS "minds_read_public_or_mine"
ON minds FOR SELECT TO authenticated
USING (privacy_level='public' OR id = current_mind_id());

-- sources
CREATE POLICY IF NOT EXISTS "sources_rw_mine"
ON sources FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

-- fragments
CREATE POLICY IF NOT EXISTS "fragments_rw_mine"
ON fragments FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

-- mind_profiles
CREATE POLICY IF NOT EXISTS "profiles_rw_mine"
ON mind_profiles FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

-- destilados/innerlens
CREATE POLICY IF NOT EXISTS "mind_values_rw_mine"
ON mind_values FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

CREATE POLICY IF NOT EXISTS "mind_obsessions_rw_mine"
ON mind_obsessions FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

CREATE POLICY IF NOT EXISTS "mind_routine_rw_mine"
ON mind_routine_windows FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

-- mind_psychometrics: 1:1
CREATE POLICY IF NOT EXISTS "mind_psy_rw_mine"
ON mind_psychometrics FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

CREATE POLICY IF NOT EXISTS "trait_scores_rw_mine"
ON trait_scores FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

CREATE POLICY IF NOT EXISTS "proficiencies_rw_mine"
ON mind_proficiencies FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

-- CreatorOS
CREATE POLICY IF NOT EXISTS "content_projects_rw_mine"
ON content_projects FOR ALL TO authenticated
USING (creator_mind_id = current_mind_id())
WITH CHECK (creator_mind_id = current_mind_id());

CREATE POLICY IF NOT EXISTS "content_pieces_select_by_project"
ON content_pieces FOR SELECT TO authenticated
USING (project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()));

CREATE POLICY IF NOT EXISTS "content_pieces_write_by_project"
ON content_pieces FOR INSERT TO authenticated
WITH CHECK (project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()));
CREATE POLICY IF NOT EXISTS "content_pieces_update_by_project"
ON content_pieces FOR UPDATE TO authenticated
USING (project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()))
WITH CHECK (project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()));

CREATE POLICY IF NOT EXISTS "content_campaigns_rw_by_project"
ON content_campaigns FOR ALL TO authenticated
USING (project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()))
WITH CHECK (project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()));

CREATE POLICY IF NOT EXISTS "content_campaign_pieces_rw_by_project"
ON content_campaign_pieces FOR ALL TO authenticated
USING (
  campaign_id IN (SELECT id FROM content_campaigns WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()))
  AND
  content_piece_id IN (SELECT id FROM content_pieces WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()))
)
WITH CHECK (
  campaign_id IN (SELECT id FROM content_campaigns WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()))
  AND
  content_piece_id IN (SELECT id FROM content_pieces WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id()))
);

CREATE POLICY IF NOT EXISTS "content_performance_rw_by_project"
ON content_performance FOR ALL TO authenticated
USING (content_piece_id IN (SELECT id FROM content_pieces WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())))
WITH CHECK (content_piece_id IN (SELECT id FROM content_pieces WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())));