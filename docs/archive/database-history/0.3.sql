-- =========================================================
-- MMOS DB — Esquema Completo (Supabase/PostgreSQL 16+)
-- =========================================================

-- ============
-- EXTENSIONS
-- ============
CREATE EXTENSION IF NOT EXISTS pgcrypto;  -- gen_random_uuid()

-- ======================
-- FUNÇÕES UTILITÁRIAS
-- ======================

-- Snap p/ décimos: ≥0,08 sobe o dígito (0..10)
CREATE OR REPLACE FUNCTION snap_to_tenth(score NUMERIC)
RETURNS SMALLINT LANGUAGE plpgsql IMMUTABLE AS $$
DECLARE t NUMERIC := score * 10; i INT := floor(t); r NUMERIC := t - i;
BEGIN
  IF score <= 0 THEN RETURN 0; END IF;
  IF score >= 1 THEN RETURN 10; END IF;
  IF r >= 0.8 THEN RETURN LEAST(i+1,10); ELSE RETURN GREATEST(i,0); END IF;
END $$;

-- updated_at automático (reuso em várias tabelas)
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger AS $$
BEGIN NEW.updated_at := now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

-- =====================================
-- IDENTIDADE / PIPELINE (Minds & afins)
-- =====================================

CREATE TABLE IF NOT EXISTS minds (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL,              -- ex: 'naval-ravikant'
  display_name TEXT NOT NULL,
  subject_type TEXT,                      -- 'public_figure','private_user',...
  privacy_level TEXT,                     -- 'public','private','anonymized',...
  status TEXT,                            -- 'new','processing','ready','archived',...
  current_phase TEXT,                     -- fase do pipeline
  category TEXT,                          -- ex.: 'entrepreneur'
  primary_domain TEXT,                    -- ex.: 'cognitive_philosophy'
  birth_year INT,
  nationality TEXT,
  primary_language CHAR(2),               -- en, pt, etc.
  short_bio TEXT,                         -- 1-2 linhas
  created_by TEXT,
  agent_versions TEXT,                    -- ex.: 'analyzer=2.1,extractor=1.4'
  pipeline_version TEXT,
  completeness NUMERIC(3,2),              -- 0..1
  confidence_avg NUMERIC(3,2),            -- 0..1
  quality_grade TEXT,                     -- 'A','B','C'...
  apex_score NUMERIC(3,2),                -- 0..1
  extra JSONB,
  deleted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
-- (Patch para bancos existentes)
ALTER TABLE minds ADD COLUMN IF NOT EXISTS primary_language CHAR(2);
ALTER TABLE minds ADD COLUMN IF NOT EXISTS short_bio TEXT;

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

CREATE TABLE IF NOT EXISTS ingestion_batches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pipeline_version TEXT NOT NULL,
  llm_provider TEXT,
  llm_model TEXT,
  llm_version TEXT,
  prompt_hash TEXT,
  params JSONB,                            -- temperature/top_p/seed...
  created_by TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS pipeline_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  stage TEXT NOT NULL,                     -- 'discover','clean','chunk','extract','qa','publish'
  status TEXT NOT NULL DEFAULT 'queued',   -- 'queued','running','done','error'
  details JSONB,
  started_at TIMESTAMPTZ,
  finished_at TIMESTAMPTZ,
  UNIQUE (mind_id, stage)
);

-- ============================
-- FONTES / CATEGORIAS / TAXON
-- ============================

CREATE TABLE IF NOT EXISTS categories (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,               -- 'COG','BIO','VAL',...
  name TEXT NOT NULL,
  description TEXT
);

-- Taxonomia de competências
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

CREATE TABLE IF NOT EXISTS sources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  title TEXT NOT NULL,
  type TEXT NOT NULL,                      -- 'book','article','podcast','interview','dossier',...
  platform TEXT,                           -- 'YouTube','X','Medium','internal',...
  author TEXT,
  published_date DATE NOT NULL,
  url TEXT,
  language TEXT CHECK (char_length(language)=2),
  quality TEXT NOT NULL,                   -- 'primary','secondary','tertiary'
  status TEXT,                             -- 'discovered','cleaned','processed',...
  priority_score NUMERIC(5,2),
  priority_reasoning TEXT,
  pre_eval_decision TEXT,                  -- 'go','skip','defer'
  expected_yield INT,
  processed_at TIMESTAMPTZ,
  cleaning_version TEXT,
  extraction_version TEXT,
  word_count INT,
  avg_fragment_layer NUMERIC(3,2),
  high_layer_percentage NUMERIC(4,2),      -- 0..1
  extra JSONB,
  deleted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_sources_mind           ON sources (mind_id);
CREATE INDEX IF NOT EXISTS idx_sources_published_date ON sources (published_date);
CREATE INDEX IF NOT EXISTS idx_sources_type           ON sources (type);
CREATE INDEX IF NOT EXISTS idx_sources_status         ON sources (status);

DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_sources_updated') THEN
    CREATE TRIGGER trg_sources_updated BEFORE UPDATE ON sources
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- =========================
-- OPERACIONAL (FILA/EXEC)
-- =========================

CREATE TABLE IF NOT EXISTS processing_queue (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,
  job_type TEXT NOT NULL,                  -- 'ingest_source','chunk','extract','enrich',...
  scope_type TEXT NOT NULL,                -- 'source','mind','url','file','fragment'
  scope_id UUID,
  priority SMALLINT NOT NULL DEFAULT 5 CHECK (priority BETWEEN 1 AND 9),
  status TEXT NOT NULL DEFAULT 'queued',   -- 'queued','running','done','error','retry'
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
  llm_provider TEXT,
  llm_model TEXT,
  llm_version TEXT,
  params JSONB,               -- temperature/top_p/seed...
  tokens_prompt INT,
  tokens_completion INT,
  tokens_total INT GENERATED ALWAYS AS (
    COALESCE(tokens_prompt,0) + COALESCE(tokens_completion,0)
  ) STORED,
  cost_usd NUMERIC(12,6),
  latency_ms INT,
  input_bytes INT,
  output_bytes INT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_exec_queue   ON job_executions (queue_id);
CREATE INDEX IF NOT EXISTS idx_exec_created ON job_executions (created_at);
CREATE INDEX IF NOT EXISTS idx_exec_model   ON job_executions (llm_provider, llm_model);

-- =========================
-- CONTEÚDO (FRAGMENTS)
-- =========================

CREATE TABLE IF NOT EXISTS fragments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  source_id UUID NOT NULL REFERENCES sources(id) ON DELETE RESTRICT,
  category_id BIGINT NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
  ingestion_batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,

  layer SMALLINT,                                        -- 0..8
  location TEXT NOT NULL,                                -- 'Ch.3 p.42' / timestamps
  type TEXT NOT NULL,                                    -- 'direct_quote','framework','principle',...
  fragment_type TEXT,                                    -- 'written_thought','statement',...
  evidence_type TEXT,                                    -- 'primary','secondary'
  hierarchy TEXT,                                        -- 'fundamental','derived',...
  temporal_context TEXT,                                 -- '2018-2020'
  evolution_marker TEXT,                                 -- 'pivot','reversal'
  char_start INT,
  char_end INT,

  relevance_10 SMALLINT NOT NULL CHECK (relevance_10 BETWEEN 0 AND 10),
  relevance NUMERIC(2,1) GENERATED ALWAYS AS (relevance_10/10.0) STORED,

  confidence NUMERIC(3,2),                               -- 0..1
  self_critique_passed BOOLEAN,
  validated BOOLEAN,
  validation_status TEXT,
  validation_reasoning TEXT,

  content TEXT NOT NULL,
  verbatim TEXT,                                         -- raw/original
  context TEXT NOT NULL,
  insight TEXT NOT NULL,
  why_significant TEXT,
  raw_payload JSONB,

  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,

  deleted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE (source_id, location)
);

-- FTS (garantir coluna gerada mesmo em bancos já existentes)
ALTER TABLE fragments
  ADD COLUMN IF NOT EXISTS tsv tsvector;
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name='fragments' AND column_name='tsv' AND is_generated='NEVER'
  ) THEN
    ALTER TABLE fragments DROP COLUMN tsv;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name='fragments' AND column_name='tsv'
  ) THEN
    ALTER TABLE fragments
      ADD COLUMN tsv tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('simple', coalesce(content,'')), 'A') ||
        setweight(to_tsvector('simple', coalesce(context,'')), 'B') ||
        setweight(to_tsvector('simple', coalesce(insight,'')), 'C')
      ) STORED;
  END IF;
END$$;

CREATE INDEX IF NOT EXISTS idx_frag_tsv        ON fragments USING GIN (tsv);
CREATE INDEX IF NOT EXISTS idx_frag_mind       ON fragments (mind_id);
CREATE INDEX IF NOT EXISTS idx_frag_source     ON fragments (source_id);
CREATE INDEX IF NOT EXISTS idx_frag_category   ON fragments (category_id);
CREATE INDEX IF NOT EXISTS idx_frag_rel10      ON fragments (relevance_10);
CREATE INDEX IF NOT EXISTS idx_frag_type       ON fragments (type);
CREATE INDEX IF NOT EXISTS idx_frag_layer      ON fragments (layer);

DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_fragments_updated') THEN
    CREATE TRIGGER trg_fragments_updated BEFORE UPDATE ON fragments
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- TAGGING
CREATE TABLE IF NOT EXISTS tags (
  id BIGSERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,               -- case-sensitive
  tag_type TEXT NOT NULL,                  -- 'domain','theme','meta','format','status',...
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
CREATE INDEX IF NOT EXISTS idx_ft_tag   ON fragment_tags (tag_id) INCLUDE (fragment_id);
CREATE INDEX IF NOT EXISTS idx_ft_frag  ON fragment_tags (fragment_id) INCLUDE (tag_id);

-- GRAFO (relacionamentos)
CREATE TABLE IF NOT EXISTS fragment_relationships (
  from_fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  to_fragment_id   UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  relationship_type TEXT NOT NULL DEFAULT 'related',      -- 'related','supports','contradicts',...
  PRIMARY KEY (from_fragment_id, to_fragment_id),
  CHECK (from_fragment_id <> to_fragment_id)
);
CREATE INDEX IF NOT EXISTS idx_rel_from ON fragment_relationships (from_fragment_id);
CREATE INDEX IF NOT EXISTS idx_rel_to   ON fragment_relationships (to_fragment_id);
CREATE INDEX IF NOT EXISTS idx_rel_type ON fragment_relationships (relationship_type);

-- canonicidade para 'related' (não-dirigido)
CREATE UNIQUE INDEX IF NOT EXISTS ux_related_canonical
  ON fragment_relationships (
    LEAST(from_fragment_id, to_fragment_id),
    GREATEST(from_fragment_id, to_fragment_id)
  )
  WHERE relationship_type = 'related';

-- ==================================
-- COMPETÊNCIAS & TRAÇOS (com evid.)
-- ==================================

CREATE TABLE IF NOT EXISTS mind_proficiencies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
  level SMALLINT CHECK (level BETWEEN 0 AND 10),  -- escala 0..10
  confidence NUMERIC(3,2),                        -- 0..1
  evidence_count INT DEFAULT 0,
  last_updated TIMESTAMPTZ DEFAULT now(),
  UNIQUE (mind_id, skill_id)
);
CREATE INDEX IF NOT EXISTS idx_mprof_mind ON mind_proficiencies (mind_id);

CREATE TABLE IF NOT EXISTS mind_proficiency_evidence (
  mind_proficiency_id UUID NOT NULL REFERENCES mind_proficiencies(id) ON DELETE CASCADE,
  fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  PRIMARY KEY (mind_proficiency_id, fragment_id)
);

CREATE TABLE IF NOT EXISTS traits (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,               -- 'openness','risk_tolerance',...
  name TEXT NOT NULL,
  description TEXT,
  scale_min_label TEXT,
  scale_max_label TEXT,
  inverse_of BIGINT REFERENCES traits(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS trait_scores (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  trait_id BIGINT NOT NULL REFERENCES traits(id) ON DELETE CASCADE,
  final_score NUMERIC(3,2),                -- 0..1
  confidence NUMERIC(3,2),                 -- 0..1
  consistency NUMERIC(3,2),                -- 0..1
  is_central_trait BOOLEAN DEFAULT FALSE,
  time_span TEXT,                          -- '2015-2022' etc.
  notes TEXT,
  computed_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (mind_id, trait_id)
);

CREATE TABLE IF NOT EXISTS trait_score_evidence (
  trait_score_id UUID NOT NULL REFERENCES trait_scores(id) ON DELETE CASCADE,
  fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  PRIMARY KEY (trait_score_id, fragment_id)
);

-- ===========================
-- ARTEFATOS & INSIGHTS (KISS)
-- ===========================

-- 1) Perfis (YAML/MD/JSON dos agentes) versionados e auditáveis
CREATE TABLE IF NOT EXISTS mind_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  layer SMALLINT,                           -- 2..7 (quando aplicável)
  profile_type TEXT NOT NULL,               -- 'values_hierarchy','routine','psychometrics','mental_models','writing_style','recognition_patterns','voice_guide','frameworks','decision_patterns',...
  title TEXT,                               
  format TEXT,                              -- 'yaml','md','json'
  payload JSONB NOT NULL,                   -- conteúdo bruto parseado
  confidence_level TEXT,                    -- 'very_high','high','medium',...
  source_count INT,
  extraction_date TIMESTAMPTZ,
  human_validation_status TEXT,             -- 'PENDING','APPROVED','REJECTED'
  ingestion_batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_mprof_mind_type ON mind_profiles (mind_id, profile_type);
CREATE INDEX IF NOT EXISTS idx_mprof_layer     ON mind_profiles (layer);
CREATE INDEX IF NOT EXISTS idx_mprof_payload   ON mind_profiles USING GIN (payload);

DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_mprof_updated') THEN
    CREATE TRIGGER trg_mprof_updated BEFORE UPDATE ON mind_profiles
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- 2) Evidências semânticas que sustentam um perfil (opcional, mas útil)
CREATE TABLE IF NOT EXISTS mind_profile_evidence (
  profile_id UUID NOT NULL REFERENCES mind_profiles(id) ON DELETE CASCADE,
  fragment_id UUID REFERENCES fragments(id) ON DELETE SET NULL,
  source_id UUID REFERENCES sources(id) ON DELETE SET NULL,
  role TEXT,                 -- 'support','counter','example'
  notes TEXT,
  PRIMARY KEY (profile_id, fragment_id, source_id)
);
CREATE INDEX IF NOT EXISTS idx_mpe_profile ON mind_profile_evidence (profile_id);

-- 3) Valores (top-N) normalizados
CREATE TABLE IF NOT EXISTS mind_values (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  name TEXT NOT NULL,               -- ex: 'AUTONOMIA'
  rank SMALLINT NOT NULL CHECK (rank BETWEEN 1 AND 9),
  intensity SMALLINT,               -- 0..10 (quando existir)
  alignment_score SMALLINT,         -- 0..100 (quando existir)
  confidence_level TEXT,
  profile_id UUID REFERENCES mind_profiles(id) ON DELETE SET NULL,  -- origem bruta
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS ux_mind_values ON mind_values (mind_id, name);
CREATE INDEX IF NOT EXISTS idx_mind_values_rank ON mind_values (mind_id, rank);

-- 4) Obsessões centrais
CREATE TABLE IF NOT EXISTS mind_obsessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  question TEXT NOT NULL,           -- pergunta-motor
  rank SMALLINT,                    -- prioridade 1..9
  temporal_span TEXT,               -- "2014–presente"
  confidence_level TEXT,
  profile_id UUID REFERENCES mind_profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS ux_mind_obsession ON mind_obsessions (mind_id, question);

-- 5) Janelas de rotina (scheduling/UX)
CREATE TABLE IF NOT EXISTS mind_routine_windows (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  window_name TEXT NOT NULL,        -- 'deep_work_prime_time'
  start_local TIME NOT NULL,        -- '22:00'
  end_local TIME NOT NULL,          -- '02:00'
  timezone TEXT,                    -- 'America/Sao_Paulo'
  consistency TEXT,                 -- 'daily','weekly','contextual'
  notes TEXT,
  profile_id UUID REFERENCES mind_profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_mind_routine_mind ON mind_routine_windows (mind_id);

-- 6) Psicometria tipada
CREATE TABLE IF NOT EXISTS mind_psychometrics (
  mind_id UUID PRIMARY KEY REFERENCES minds(id) ON DELETE CASCADE,
  disc_d SMALLINT, disc_i SMALLINT, disc_s SMALLINT, disc_c SMALLINT,   -- 0..100
  mbti_type TEXT,                                                        -- 'ENFP'...
  enneagram_type SMALLINT, enneagram_wing TEXT,                          -- 3, 'w4'
  profile_id UUID REFERENCES mind_profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_mpsy_updated') THEN
    CREATE TRIGGER trg_mpsy_updated BEFORE UPDATE ON mind_psychometrics
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- ==========================
-- VIEWS OPERACIONAIS/KPIs
-- ==========================

-- A) Atribuição Execução → Mente + duração por execução
CREATE OR REPLACE VIEW v_job_mind_attribution AS
WITH base AS (
  SELECT
    je.id                                   AS execution_id,
    pq.batch_id,
    pq.scope_type,
    pq.scope_id,
    je.llm_provider,
    je.llm_model,
    je.tokens_prompt,
    je.tokens_completion,
    je.tokens_total,
    je.cost_usd,
    je.created_at,
    CASE
      WHEN je.latency_ms IS NOT NULL THEN je.latency_ms
      WHEN pq.started_at IS NOT NULL AND pq.finished_at IS NOT NULL
           THEN (EXTRACT(EPOCH FROM (pq.finished_at - pq.started_at)) * 1000)::BIGINT
      ELSE NULL
    END                                      AS duration_ms
  FROM job_executions je
  JOIN processing_queue pq ON pq.id = je.queue_id
),
assigned AS (
  -- (1) direta: job escopado na mente
  SELECT b.execution_id, b.batch_id, m.id AS mind_id, 'direct_mind'::text AS method,
         b.duration_ms, b.tokens_total, b.cost_usd, b.created_at, 1 AS prio
  FROM base b
  JOIN minds m ON (b.scope_type = 'mind' AND m.id = b.scope_id)

  UNION ALL
  -- (2) via source → mind
  SELECT b.execution_id, b.batch_id, s.mind_id, 'via_source'::text AS method,
         b.duration_ms, b.tokens_total, b.cost_usd, b.created_at, 2 AS prio
  FROM base b
  JOIN sources s ON (b.scope_type = 'source' AND s.id = b.scope_id)

  UNION ALL
  -- (3) fallback via fragments gerados
  SELECT b.execution_id, b.batch_id, MIN(f.mind_id) AS mind_id, 'via_frag'::text AS method,
         b.duration_ms, b.tokens_total, b.cost_usd, b.created_at, 3 AS prio
  FROM base b
  JOIN fragments f ON f.generation_execution_id = b.execution_id
  GROUP BY b.execution_id, b.batch_id, b.duration_ms, b.tokens_total, b.cost_usd, b.created_at
),
prioritized AS (
  SELECT *
  FROM (
    SELECT a.*,
           ROW_NUMBER() OVER (PARTITION BY a.execution_id ORDER BY a.prio ASC) AS rn
    FROM assigned a
  ) z
  WHERE z.rn = 1
)
SELECT
  execution_id,
  batch_id,
  mind_id,
  method,
  duration_ms,
  tokens_total,
  cost_usd,
  created_at
FROM prioritized;

-- B) Duração/custos por LOTE
CREATE OR REPLACE VIEW v_batch_durations AS
SELECT
  batch_id,
  COUNT(*)                                   AS executions_count,
  SUM(COALESCE(duration_ms,0))               AS duration_ms_sum,
  SUM(COALESCE(tokens_total,0))              AS tokens_total,
  SUM(COALESCE(cost_usd,0))                  AS cost_total_usd,
  MIN(created_at)                            AS first_exec_at,
  MAX(created_at)                            AS last_exec_at
FROM v_job_mind_attribution
GROUP BY batch_id;

-- C) Duração/custos por MENTE
CREATE OR REPLACE VIEW v_mind_processing_time AS
SELECT
  mind_id,
  COUNT(*)                                   AS executions_count,
  COUNT(DISTINCT batch_id)                   AS batches_count,
  SUM(COALESCE(duration_ms,0))               AS duration_ms_sum,
  SUM(COALESCE(tokens_total,0))              AS tokens_total,
  SUM(COALESCE(cost_usd,0))                  AS cost_total_usd,
  MIN(created_at)                            AS first_exec_at,
  MAX(created_at)                            AS last_exec_at
FROM v_job_mind_attribution
GROUP BY mind_id;

-- D) Perfis “vigentes” por mente/tipo
CREATE OR REPLACE VIEW v_mind_latest_profiles AS
SELECT DISTINCT ON (mind_id, profile_type)
  id, mind_id, profile_type, title, format, payload,
  confidence_level, human_validation_status,
  ingestion_batch_id, generation_execution_id, created_at
FROM mind_profiles
WHERE human_validation_status IS DISTINCT FROM 'REJECTED'
ORDER BY mind_id, profile_type, created_at DESC;

-- E) Custo por artefato (profile)
CREATE OR REPLACE VIEW v_profile_costs AS
SELECT
  mp.id AS profile_id, mp.mind_id, mp.profile_type,
  je.llm_provider, je.llm_model,
  je.tokens_total, je.cost_usd, je.latency_ms,
  pq.batch_id, je.created_at AS executed_at
FROM mind_profiles mp
LEFT JOIN job_executions je ON je.id = mp.generation_execution_id
LEFT JOIN processing_queue pq ON pq.id = je.queue_id;

-- F) tokens/custo por fragmento
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

-- G) Agregado por lote/modelo
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

-- H) Status do pipeline por mente
CREATE OR REPLACE VIEW v_pipeline_status AS
SELECT
  m.id   AS mind_id,
  m.slug,
  pp.stage,
  pp.status,
  pp.started_at,
  pp.finished_at
FROM minds m
LEFT JOIN pipeline_progress pp ON pp.mind_id = m.id;

-- I) Heurística de “alta qualidade” de fragmentos
CREATE OR REPLACE VIEW v_fragments_high_quality AS
SELECT f.*
FROM fragments f
WHERE (f.relevance_10 >= 8)
  AND (f.layer IS NULL OR f.layer >= 5)
  AND (f.confidence IS NULL OR f.confidence >= 0.70)
  AND (f.self_critique_passed IS DISTINCT FROM FALSE);

-- J) Painel executivo por mente (usa tempos/custos derivados)
CREATE OR REPLACE VIEW v_mind_dashboard AS
WITH frag AS (
  SELECT mind_id,
         COUNT(*) AS fragments_total,
         AVG(f.relevance) AS avg_relevance,
         AVG(NULLIF(f.confidence,0)) AS avg_confidence
  FROM fragments f
  GROUP BY mind_id
)
SELECT
  m.id, m.slug, m.display_name,
  m.status, m.current_phase, m.quality_grade,
  m.completeness, m.confidence_avg, m.apex_score,
  COALESCE(frag.fragments_total,0)         AS fragments_total,
  frag.avg_relevance, frag.avg_confidence,
  COALESCE(t.tokens_total,0)               AS tokens_total,
  COALESCE(t.cost_total_usd,0)             AS cost_total_usd,
  COALESCE(t.duration_ms_sum,0)            AS processing_duration_ms,
  COALESCE(t.batches_count,0)              AS batches_count,
  t.first_exec_at,
  t.last_exec_at
FROM minds m
LEFT JOIN frag ON frag.mind_id = m.id
LEFT JOIN v_mind_processing_time t ON t.mind_id = m.id;