-- ================================================
-- 004_creatorOS_core.sql — CreatorOS core (KISS)
-- Requires: pgcrypto extension, function set_updated_at()
-- Depends on: minds, job_executions
-- ================================================

-- ---------- content_projects
CREATE TABLE IF NOT EXISTS content_projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  persona_mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  name TEXT NOT NULL,
  description TEXT,
  goals TEXT[] DEFAULT '{}'::text[],          -- ex.: {'thought_leadership','lead_generation'}
  status TEXT NOT NULL DEFAULT 'active',      -- 'active','paused','archived'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_cp_creator ON content_projects (creator_mind_id);
CREATE INDEX IF NOT EXISTS idx_cp_persona ON content_projects (persona_mind_id);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_projects_updated') THEN
    CREATE TRIGGER trg_content_projects_updated
      BEFORE UPDATE ON content_projects
      FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END $$;

-- ---------- audience_profiles
CREATE TABLE IF NOT EXISTS audience_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  age_range TEXT,                              -- ex.: '25-34'
  psychographic_traits JSONB,                  -- Big Five, etc.
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_aud_project ON audience_profiles (project_id);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_audience_profiles_updated') THEN
    CREATE TRIGGER trg_audience_profiles_updated
      BEFORE UPDATE ON audience_profiles
      FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END $$;

-- ---------- content_pieces
CREATE TABLE IF NOT EXISTS content_pieces (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE RESTRICT,
  type TEXT NOT NULL,                           -- 'blog','social','video_script','newsletter','course'
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  voice_fidelity_score NUMERIC(3,2),            -- 0.00..1.00
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (project_id, title)                    -- evita duplicação acidental por projeto
);
CREATE INDEX IF NOT EXISTS idx_cp_project ON content_pieces (project_id);
CREATE INDEX IF NOT EXISTS idx_cp_type ON content_pieces (type);
CREATE INDEX IF NOT EXISTS idx_cp_published ON content_pieces (published_at DESC);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_pieces_updated') THEN
    CREATE TRIGGER trg_content_pieces_updated
      BEFORE UPDATE ON content_pieces
      FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END $$;

-- ---------- content_campaigns
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

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_campaigns_updated') THEN
    CREATE TRIGGER trg_content_campaigns_updated
      BEFORE UPDATE ON content_campaigns
      FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END $$;

-- ---------- content_campaign_pieces (junction)
CREATE TABLE IF NOT EXISTS content_campaign_pieces (
  campaign_id UUID NOT NULL REFERENCES content_campaigns(id) ON DELETE CASCADE,
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,
  PRIMARY KEY (campaign_id, content_piece_id)
);
CREATE INDEX IF NOT EXISTS idx_ccp_piece ON content_campaign_pieces (content_piece_id);

-- ---------- content_performance
CREATE TABLE IF NOT EXISTS content_performance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,
  metric_type TEXT NOT NULL,                     -- 'views','engagement','conversions','shares'
  value NUMERIC,
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_cperf_piece_time ON content_performance (content_piece_id, recorded_at DESC);
CREATE INDEX IF NOT EXISTS idx_cperf_metric ON content_performance (metric_type);

-- ---------- Views simples (KISS)

-- Última publicação e quantidade de peças por projeto
CREATE OR REPLACE VIEW v_project_content_stats AS
SELECT
  p.id AS project_id,
  COUNT(cp.id) AS pieces_count,
  MAX(cp.published_at) AS last_published_at
FROM content_projects p
LEFT JOIN content_pieces cp ON cp.project_id = p.id
GROUP BY p.id;

-- Agregado de performance por peça e métrica
CREATE OR REPLACE VIEW v_content_performance_agg AS
SELECT
  cp.content_piece_id,
  cp.metric_type,
  SUM(cp.value) AS total_value,
  MIN(cp.recorded_at) AS first_seen_at,
  MAX(cp.recorded_at) AS last_seen_at
FROM content_performance cp
GROUP BY cp.content_piece_id, cp.metric_type;
