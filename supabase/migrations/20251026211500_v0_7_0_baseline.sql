-- =========================================================
-- 0.7.sql — AIOS Unified Database (Supabase / PostgreSQL 16+)
-- KISS • Performance-first • Provenance • Minimal-friction RLS
-- =========================================================
-- CHANGES vs 0.6:
--  • FIX (P0): fragments.mind_id must equal sources.mind_id (no DEFAULT);
--              add trigger set_fragment_mind_id() to inherit/validate
--  • FIX (P0): provision_user_profile() now collision-safe for slug
--  • ADD (P1): RLS for audience_profiles
--  • Keep: minimal policies; defaults on sources/mind_profiles/content_projects
-- =========================================================

-- ==============
-- EXTENSIONS
-- ==============
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ==============
-- UTIL FUNCTIONS
-- ==============
-- Snap score to tenths: 0..1 → {0..10}, threshold 0.08 up
CREATE OR REPLACE FUNCTION snap_to_tenth(score NUMERIC)
RETURNS SMALLINT
LANGUAGE plpgsql IMMUTABLE AS $$
DECLARE
  t NUMERIC := score * 10;
  i INT := floor(t);
  r NUMERIC := t - i;
BEGIN
  IF score <= 0 THEN RETURN 0; END IF;
  IF score >= 1 THEN RETURN 10; END IF;
  IF r >= 0.8 THEN RETURN LEAST(i+1,10); END IF;
  RETURN GREATEST(i,0);
END $$;

-- updated_at trigger helper
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger AS $$
BEGIN NEW.updated_at := now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- AUTH LINKING (Supabase) — users → user_profiles → minds
-- =========================================================
CREATE TABLE IF NOT EXISTS minds (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  primary_language CHAR(2),                       -- 'pt','en',...
  short_bio TEXT,
  privacy_level TEXT NOT NULL DEFAULT 'public' CHECK (privacy_level IN ('public','private')),
  apex_score NUMERIC(3,2),                        -- 0.00..1.00, opcional
  created_by TEXT,                                -- auth.users.id (string)
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Optional aliases for search/disambiguation
CREATE TABLE IF NOT EXISTS mind_aliases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  alias TEXT NOT NULL,
  UNIQUE (mind_id, alias)
);

-- Map auth.users → minds (1:1)
CREATE TABLE IF NOT EXISTS user_profiles (
  id UUID PRIMARY KEY,  -- equals auth.users.id
  mind_id UUID NOT NULL UNIQUE REFERENCES minds(id) ON DELETE RESTRICT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- FK to auth.users (Supabase)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname='fk_user_profiles_auth'
  ) THEN
    ALTER TABLE user_profiles
      ADD CONSTRAINT fk_user_profiles_auth
      FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;
  END IF;
END $$;

-- Current user's mind_id via Supabase auth (moved here after user_profiles creation)
CREATE OR REPLACE FUNCTION current_mind_id()
RETURNS uuid LANGUAGE sql STABLE AS $$
  SELECT mind_id FROM user_profiles WHERE id = auth.uid()
$$;

-- Provisioning trigger: create mind & user_profile at signup (slug collision-safe)
CREATE OR REPLACE FUNCTION provision_user_profile()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_mind_id uuid;
  v_slug text;
  v_attempt int := 0;
  v_unique_slug text;
BEGIN
  v_slug := lower(regexp_replace(split_part(NEW.email, '@', 1), '[^a-z0-9_]', '_', 'g'));
  v_unique_slug := v_slug;

  WHILE EXISTS (SELECT 1 FROM minds WHERE slug = v_unique_slug) LOOP
    v_attempt := v_attempt + 1;
    IF v_attempt > 100 THEN
      v_unique_slug := v_slug || '_' || substring(NEW.id::text from 1 for 8);
      EXIT;
    END IF;
    v_unique_slug := v_slug || '_' || v_attempt;
  END LOOP;

  INSERT INTO minds (slug, display_name, primary_language, short_bio, created_by)
  VALUES (v_unique_slug, COALESCE(NEW.raw_user_meta_data->>'name', v_unique_slug), 'pt', '', NEW.id::text)
  RETURNING id INTO v_mind_id;

  INSERT INTO user_profiles (id, mind_id)
  VALUES (NEW.id, v_mind_id)
  ON CONFLICT (id) DO NOTHING;

  RETURN NEW;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_provision_user_profile') THEN
    CREATE TRIGGER trg_provision_user_profile
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION provision_user_profile();
  END IF;
END $$;

-- =========================================================
-- LOOKUPS / TAXONOMY
-- =========================================================
CREATE TABLE IF NOT EXISTS categories (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS tags (
  id BIGSERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,          -- case-sensitive
  tag_type TEXT NOT NULL,             -- 'domain','theme'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_tags_type ON tags(tag_type);

-- Competency taxonomy (optional, used by InnerLens/MMOS)
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

-- Psych traits (Big Five or custom)
CREATE TABLE IF NOT EXISTS traits (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT
);

-- =========================================================
-- SOURCES (timeline / provenance)
-- =========================================================
CREATE TABLE IF NOT EXISTS sources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  title TEXT NOT NULL,
  type TEXT NOT NULL,                   -- 'book','podcast','interview',...
  author TEXT,
  published_date DATE NOT NULL,
  url TEXT,
  language CHAR(2),
  quality TEXT NOT NULL,                -- 'primary','secondary','tertiary'
  publisher TEXT,
  isbn TEXT,
  page_count INT,
  duration TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_sources_mind            ON sources(mind_id);
CREATE INDEX IF NOT EXISTS idx_sources_published_date  ON sources(published_date);
CREATE INDEX IF NOT EXISTS idx_sources_type            ON sources(type);
CREATE INDEX IF NOT EXISTS idx_sources_author          ON sources(author);

-- Default: when user creates their own sources
ALTER TABLE sources
  ALTER COLUMN mind_id SET DEFAULT current_mind_id();

-- =========================================================
-- OPERATIONAL (queue → executions → metrics)
-- =========================================================
CREATE TABLE IF NOT EXISTS ingestion_batches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pipeline_version TEXT NOT NULL,
  llm_provider TEXT,
  llm_model TEXT,
  llm_version TEXT,
  prompt_hash TEXT,
  params JSONB,
  created_by TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS processing_queue (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,
  job_type TEXT NOT NULL,       -- 'ingest_source','chunk','extract_fragments','enrich',...
  scope_type TEXT NOT NULL,     -- 'source','mind','url','file','fragment'
  scope_id UUID,                -- id alvo (sources.id, minds.id, etc.)
  priority SMALLINT NOT NULL DEFAULT 5 CHECK (priority BETWEEN 1 AND 9),
  status TEXT NOT NULL DEFAULT 'queued',  -- 'queued','running','done','error','retry'
  attempts SMALLINT NOT NULL DEFAULT 0,
  scheduled_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  started_at TIMESTAMPTZ,
  finished_at TIMESTAMPTZ,
  last_error TEXT
);
CREATE INDEX IF NOT EXISTS idx_pq_status_prio ON processing_queue(status, priority, scheduled_at);
CREATE INDEX IF NOT EXISTS idx_pq_batch       ON processing_queue(batch_id);
CREATE INDEX IF NOT EXISTS idx_pq_scope       ON processing_queue(scope_type, scope_id);

CREATE TABLE IF NOT EXISTS job_executions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  queue_id UUID NOT NULL REFERENCES processing_queue(id) ON DELETE CASCADE,
  llm_provider TEXT,
  llm_model TEXT,
  llm_version TEXT,
  params JSONB,
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
CREATE INDEX IF NOT EXISTS idx_exec_queue   ON job_executions(queue_id);
CREATE INDEX IF NOT EXISTS idx_exec_created ON job_executions(created_at);
CREATE INDEX IF NOT EXISTS idx_exec_model   ON job_executions(llm_provider, llm_model);

-- =========================================================
-- FRAGMENTS (atomic units) + tagging + relationships
-- =========================================================
CREATE TABLE IF NOT EXISTS fragments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  source_id UUID NOT NULL REFERENCES sources(id) ON DELETE RESTRICT,
  category_id BIGINT NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
  ingestion_batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,

  layer SMALLINT,
  location TEXT NOT NULL,
  type TEXT NOT NULL,                               -- 'direct_quote','framework','principle',...
  relevance_10 SMALLINT NOT NULL CHECK (relevance_10 BETWEEN 0 AND 10),
  relevance NUMERIC(2,1) GENERATED ALWAYS AS (relevance_10/10.0) STORED,

  content TEXT NOT NULL,
  context TEXT NOT NULL,
  insight TEXT NOT NULL,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE (source_id, location)
);

-- FTS vector (weighted)
ALTER TABLE fragments
  ADD COLUMN IF NOT EXISTS tsv tsvector GENERATED ALWAYS AS (
    setweight(to_tsvector('simple', coalesce(content,'')), 'A') ||
    setweight(to_tsvector('simple', coalesce(context,'')), 'B') ||
    setweight(to_tsvector('simple', coalesce(insight,'')), 'C')
  ) STORED;

CREATE INDEX IF NOT EXISTS idx_frag_tsv         ON fragments USING GIN (tsv);
CREATE INDEX IF NOT EXISTS idx_frag_mind        ON fragments(mind_id);
CREATE INDEX IF NOT EXISTS idx_frag_source      ON fragments(source_id);
CREATE INDEX IF NOT EXISTS idx_frag_category    ON fragments(category_id);
CREATE INDEX IF NOT EXISTS idx_frag_rel10       ON fragments(relevance_10);
CREATE INDEX IF NOT EXISTS idx_frag_type        ON fragments(type);
CREATE INDEX IF NOT EXISTS idx_frag_layer       ON fragments(layer);
-- Hot paths (covering)
CREATE INDEX IF NOT EXISTS idx_frag_mind_rel10_desc
  ON fragments (mind_id, relevance_10 DESC) INCLUDE (id, content, created_at);
CREATE INDEX IF NOT EXISTS idx_frag_source_created
  ON fragments (source_id, created_at DESC) INCLUDE (id, content, relevance);

-- Tagging (N:M)
CREATE TABLE IF NOT EXISTS fragment_tags (
  fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  tag_id BIGINT NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (fragment_id, tag_id)
);
CREATE INDEX IF NOT EXISTS idx_ft_tag   ON fragment_tags (tag_id) INCLUDE (fragment_id);
CREATE INDEX IF NOT EXISTS idx_ft_frag  ON fragment_tags (fragment_id) INCLUDE (tag_id);

-- Relationships (graph)
CREATE TABLE IF NOT EXISTS fragment_relationships (
  from_fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  to_fragment_id   UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  relationship_type TEXT NOT NULL DEFAULT 'related',  -- 'related','supports','contradicts'
  PRIMARY KEY (from_fragment_id, to_fragment_id),
  CHECK (from_fragment_id <> to_fragment_id)
);
CREATE INDEX IF NOT EXISTS idx_rel_from ON fragment_relationships(from_fragment_id);
CREATE INDEX IF NOT EXISTS idx_rel_to   ON fragment_relationships(to_fragment_id);
CREATE INDEX IF NOT EXISTS idx_rel_type ON fragment_relationships(relationship_type);

-- Canonical unique for 'related' (A-B ≡ B-A)
CREATE UNIQUE INDEX IF NOT EXISTS ux_related_canonical
  ON fragment_relationships (
    LEAST(from_fragment_id, to_fragment_id),
    GREATEST(from_fragment_id, to_fragment_id)
  )
  WHERE relationship_type = 'related';

-- =========================================================
-- MMOS ARTIFACTS (profiles / values / routines / obsessions / psychometrics)
-- =========================================================
CREATE TABLE IF NOT EXISTS mind_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  profile_type TEXT NOT NULL,         -- 'psychometric_profile','writing_style','voice_guide',...
  storage_format TEXT NOT NULL,       -- 'json','yaml','md','txt'
  content_json JSONB,                 -- when json
  content_text TEXT,                  -- when yaml/md/txt
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (mind_id, profile_type, storage_format)
);
CREATE INDEX IF NOT EXISTS idx_profiles_mind_type ON mind_profiles(mind_id, profile_type);
ALTER TABLE mind_profiles
  ALTER COLUMN mind_id SET DEFAULT current_mind_id();

CREATE TABLE IF NOT EXISTS mind_values (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  importance_10 SMALLINT CHECK (importance_10 BETWEEN 0 AND 10),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_values_mind ON mind_values(mind_id);

CREATE TABLE IF NOT EXISTS mind_obsessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  intensity_10 SMALLINT CHECK (intensity_10 BETWEEN 0 AND 10),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_obs_mind ON mind_obsessions(mind_id);

CREATE TABLE IF NOT EXISTS mind_routine_windows (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  weekday SMALLINT CHECK (weekday BETWEEN 0 AND 6),  -- 0=Sunday
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  label TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_routine_mind ON mind_routine_windows(mind_id);

CREATE TABLE IF NOT EXISTS mind_psychometrics (
  mind_id UUID PRIMARY KEY REFERENCES minds(id) ON DELETE CASCADE,
  big_five JSONB,         -- {openness:0.7,...}
  other JSONB,            -- any additional inventories
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- InnerLens
CREATE TABLE IF NOT EXISTS trait_scores (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  trait_id BIGINT NOT NULL REFERENCES traits(id) ON DELETE RESTRICT,
  score_10 SMALLINT NOT NULL CHECK (score_10 BETWEEN 0 AND 10),
  score NUMERIC(2,1) GENERATED ALWAYS AS (score_10/10.0) STORED,
  evidence JSONB,
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (mind_id, trait_id)
);
CREATE INDEX IF NOT EXISTS idx_trait_scores_mind ON trait_scores(mind_id);

CREATE TABLE IF NOT EXISTS mind_proficiencies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES skills(id) ON DELETE RESTRICT,
  level_10 SMALLINT NOT NULL CHECK (level_10 BETWEEN 0 AND 10),
  level NUMERIC(2,1) GENERATED ALWAYS AS (level_10/10.0) STORED,
  evidence JSONB,
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (mind_id, skill_id)
);
CREATE INDEX IF NOT EXISTS idx_profs_mind ON mind_proficiencies(mind_id);

-- =========================================================
-- CREATOR OS (projects / audience / content / campaigns / frameworks)
-- =========================================================
CREATE TABLE IF NOT EXISTS content_frameworks (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  type TEXT NOT NULL,    -- 'pedagogical','marketing','storytelling'
  description TEXT
);

CREATE TABLE IF NOT EXISTS content_projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  persona_mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  name TEXT NOT NULL,
  goals TEXT[],                       -- e.g. {'thought_leadership','lead_generation'}
  status TEXT,                        -- 'active','paused','archived'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_projects_creator ON content_projects(creator_mind_id);
ALTER TABLE content_projects
  ALTER COLUMN creator_mind_id SET DEFAULT current_mind_id();

CREATE TABLE IF NOT EXISTS audience_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  age_range TEXT,
  psychographic_traits JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS content_pieces (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE RESTRICT,
  framework_id BIGINT REFERENCES content_frameworks(id) ON DELETE SET NULL,
  type TEXT NOT NULL,                -- 'blog','social','video_script','newsletter','course'
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  voice_fidelity_score NUMERIC(3,2),
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (project_id, title)
);
CREATE INDEX IF NOT EXISTS idx_pieces_project ON content_pieces(project_id);

CREATE TABLE IF NOT EXISTS content_campaigns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  goal TEXT,
  start_date DATE,
  end_date DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS content_campaign_pieces (
  campaign_id UUID NOT NULL REFERENCES content_campaigns(id) ON DELETE CASCADE,
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,
  PRIMARY KEY (campaign_id, content_piece_id)
);

CREATE TABLE IF NOT EXISTS content_performance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,
  metric_type TEXT NOT NULL,        -- 'views','engagement','conversions','shares'
  value NUMERIC,
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_perf_piece ON content_performance(content_piece_id);

-- =========================================================
-- UPDATED_AT triggers (selected tables)
-- =========================================================
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_minds_updated') THEN
    CREATE TRIGGER trg_minds_updated BEFORE UPDATE ON minds
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_sources_updated') THEN
    CREATE TRIGGER trg_sources_updated BEFORE UPDATE ON sources
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_fragments_updated') THEN
    CREATE TRIGGER trg_fragments_updated BEFORE UPDATE ON fragments
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_profiles_updated') THEN
    CREATE TRIGGER trg_profiles_updated BEFORE UPDATE ON mind_profiles
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_pieces_updated') THEN
    CREATE TRIGGER trg_pieces_updated BEFORE UPDATE ON content_pieces
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_projects_updated') THEN
    CREATE TRIGGER trg_projects_updated BEFORE UPDATE ON content_projects
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_psychometrics_updated') THEN
    CREATE TRIGGER trg_psychometrics_updated BEFORE UPDATE ON mind_psychometrics
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END $$;

-- =========================================================
-- P0 FIX: fragments.mind_id must inherit/validate from sources
-- =========================================================
CREATE OR REPLACE FUNCTION set_fragment_mind_id()
RETURNS TRIGGER AS $$
BEGIN
  -- If not provided, inherit from source
  IF NEW.mind_id IS NULL THEN
    SELECT mind_id INTO NEW.mind_id FROM sources WHERE id = NEW.source_id;
    IF NEW.mind_id IS NULL THEN
      RAISE EXCEPTION 'source_id % not found', NEW.source_id;
    END IF;
  END IF;

  -- Validate match with source
  IF NOT EXISTS (
    SELECT 1 FROM sources WHERE id = NEW.source_id AND mind_id = NEW.mind_id
  ) THEN
    RAISE EXCEPTION 'fragment.mind_id must match source.mind_id';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_fragments_set_mind_id ON fragments;
CREATE TRIGGER trg_fragments_set_mind_id
  BEFORE INSERT OR UPDATE ON fragments
  FOR EACH ROW EXECUTE FUNCTION set_fragment_mind_id();

-- =========================================================
-- ANALYTIC VIEWS (non-materialized; keep KISS)
-- =========================================================
CREATE OR REPLACE VIEW v_job_mind_attribution AS
SELECT
  je.id AS execution_id,
  je.queue_id,
  pq.batch_id,
  je.llm_provider,
  je.llm_model,
  je.tokens_prompt,
  je.tokens_completion,
  je.tokens_total,
  je.cost_usd,
  je.latency_ms,
  je.created_at AS executed_at,
  COALESCE(
    CASE WHEN pq.scope_type='mind' THEN pq.scope_id END,
    CASE WHEN pq.scope_type='source' THEN s.mind_id END,
    CASE WHEN pq.scope_type='fragment' THEN f.mind_id END
  ) AS mind_id
FROM job_executions je
LEFT JOIN processing_queue pq ON pq.id = je.queue_id
LEFT JOIN sources s ON (pq.scope_type='source' AND pq.scope_id = s.id)
LEFT JOIN fragments f ON (pq.scope_type='fragment' AND pq.scope_id = f.id);

CREATE OR REPLACE VIEW v_batch_costs AS
SELECT
  pq.batch_id,
  je.llm_provider,
  je.llm_model,
  COUNT(*)                           AS executions,
  SUM(je.tokens_total)               AS tokens_total,
  SUM(je.cost_usd)                   AS cost_total_usd,
  AVG(je.latency_ms)                 AS avg_latency_ms,
  MIN(je.created_at)                 AS first_exec_at,
  MAX(je.created_at)                 AS last_exec_at
FROM job_executions je
JOIN processing_queue pq ON pq.id = je.queue_id
GROUP BY pq.batch_id, je.llm_provider, je.llm_model;

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

-- =========================================================
-- RLS (Minimal; friction-aware)
-- =========================================================
-- Enable RLS on user-owned tables
ALTER TABLE user_profiles          ENABLE ROW LEVEL SECURITY;
ALTER TABLE minds                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE sources                ENABLE ROW LEVEL SECURITY;
ALTER TABLE fragments              ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_profiles          ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_values            ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_obsessions        ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_routine_windows   ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_psychometrics     ENABLE ROW LEVEL SECURITY;
ALTER TABLE trait_scores           ENABLE ROW LEVEL SECURITY;
ALTER TABLE mind_proficiencies     ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_projects       ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_pieces         ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_campaigns      ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_campaign_pieces ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_performance    ENABLE ROW LEVEL SECURITY;
ALTER TABLE audience_profiles      ENABLE ROW LEVEL SECURITY; -- P1 add

-- Read public minds or own
DROP POLICY IF EXISTS minds_read_public_or_mine ON minds;
CREATE POLICY minds_read_public_or_mine
ON minds FOR SELECT TO authenticated
USING (privacy_level='public' OR id = current_mind_id());

-- User-profile self
DROP POLICY IF EXISTS user_profiles_me_only ON user_profiles;
CREATE POLICY user_profiles_me_only
ON user_profiles FOR ALL TO authenticated
USING (id = auth.uid())
WITH CHECK (id = auth.uid());

-- Own-data policies (1 per table, FOR ALL)
DROP POLICY IF EXISTS sources_rw_mine ON sources;
CREATE POLICY sources_rw_mine
ON sources FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS fragments_rw_mine ON fragments;
CREATE POLICY fragments_rw_mine
ON fragments FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS profiles_rw_mine ON mind_profiles;
CREATE POLICY profiles_rw_mine
ON mind_profiles FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS values_rw_mine ON mind_values;
CREATE POLICY values_rw_mine
ON mind_values FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS obsessions_rw_mine ON mind_obsessions;
CREATE POLICY obsessions_rw_mine
ON mind_obsessions FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS routines_rw_mine ON mind_routine_windows;
CREATE POLICY routines_rw_mine
ON mind_routine_windows FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS psychometrics_rw_mine ON mind_psychometrics;
CREATE POLICY psychometrics_rw_mine
ON mind_psychometrics FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS trait_scores_rw_mine ON trait_scores;
CREATE POLICY trait_scores_rw_mine
ON trait_scores FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS profs_rw_mine ON mind_proficiencies;
CREATE POLICY profs_rw_mine
ON mind_proficiencies FOR ALL TO authenticated
USING (mind_id = current_mind_id())
WITH CHECK (mind_id = current_mind_id());

DROP POLICY IF EXISTS projects_rw_mine ON content_projects;
CREATE POLICY projects_rw_mine
ON content_projects FOR ALL TO authenticated
USING (creator_mind_id = current_mind_id())
WITH CHECK (creator_mind_id = current_mind_id());

DROP POLICY IF EXISTS audience_profiles_rw_by_project ON audience_profiles;
CREATE POLICY audience_profiles_rw_by_project
ON audience_profiles FOR ALL TO authenticated
USING (
  project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
)
WITH CHECK (
  project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
);

DROP POLICY IF EXISTS pieces_rw_by_project ON content_pieces;
CREATE POLICY pieces_rw_by_project
ON content_pieces FOR ALL TO authenticated
USING (
  project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
)
WITH CHECK (
  project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
);

DROP POLICY IF EXISTS campaigns_rw_by_project ON content_campaigns;
CREATE POLICY campaigns_rw_by_project
ON content_campaigns FOR ALL TO authenticated
USING (
  project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
)
WITH CHECK (
  project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
);

DROP POLICY IF EXISTS campaign_pieces_rw_by_project ON content_campaign_pieces;
CREATE POLICY campaign_pieces_rw_by_project
ON content_campaign_pieces FOR ALL TO authenticated
USING (
  campaign_id IN (
    SELECT id FROM content_campaigns
    WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
  )
)
WITH CHECK (
  campaign_id IN (
    SELECT id FROM content_campaigns
    WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
  )
);

DROP POLICY IF EXISTS performance_rw_by_project ON content_performance;
CREATE POLICY performance_rw_by_project
ON content_performance FOR ALL TO authenticated
USING (
  content_piece_id IN (
    SELECT id FROM content_pieces
    WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
  )
)
WITH CHECK (
  content_piece_id IN (
    SELECT id FROM content_pieces
    WHERE project_id IN (SELECT id FROM content_projects WHERE creator_mind_id = current_mind_id())
  )
);