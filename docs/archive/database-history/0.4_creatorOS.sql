-- =========================================================
-- CreatorOS Tables — Supabase/PostgreSQL 16+
-- =========================================================
-- Purpose: Content creation, campaigns, performance tracking
-- Depends on: 0.3.sql (minds, sources, job_executions)
-- Version: 1.0
-- Date: 2025-10-26

-- =========================================================
-- PREREQUISITE: Extension pgcrypto (should exist from 0.3.sql)
-- =========================================================
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- =========================================================
-- PREREQUISITE: Function set_updated_at (should exist from 0.3.sql)
-- =========================================================
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger AS $$
BEGIN NEW.updated_at := now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- CORE TABLES (8 tables)
-- =========================================================

-- ===================
-- 1) CONTENT FRAMEWORKS
-- ===================
-- Pedagogical, storytelling, and marketing frameworks
CREATE TABLE IF NOT EXISTS content_frameworks (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,              -- 'gps', 'aida', 'bloom_taxonomy', 'heros_journey'
  name TEXT NOT NULL,                     -- 'GPS Framework', 'AIDA', 'Bloom's Taxonomy'
  type TEXT NOT NULL,                     -- 'pedagogical', 'storytelling', 'marketing'
  description TEXT,
  structure JSONB,                        -- Framework-specific structure (steps, elements, etc)
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_frameworks_type ON content_frameworks (type);

-- Seed data (frameworks from CreatorOS README)
INSERT INTO content_frameworks (code, name, type, description, structure) VALUES
  ('gps', 'GPS Framework', 'pedagogical', 'Goal → Position → Steps', '{"elements": ["goal", "position", "steps"]}'),
  ('didatica_lendaria', 'Didática Lendária', 'pedagogical', '7 Elements of transformational learning', '{"elements": ["contextualization", "fundamentals", "application", "practice", "feedback", "integration", "mastery"]}'),
  ('bloom_taxonomy', 'Bloom''s Taxonomy', 'pedagogical', '6 cognitive levels', '{"levels": ["remember", "understand", "apply", "analyze", "evaluate", "create"]}'),
  ('aida', 'AIDA', 'marketing', 'Attention → Interest → Desire → Action', '{"stages": ["attention", "interest", "desire", "action"]}'),
  ('pas', 'Problem-Agitate-Solve', 'storytelling', 'Problem → Agitate → Solve', '{"stages": ["problem", "agitate", "solve"]}'),
  ('heros_journey', 'Hero''s Journey', 'storytelling', 'Transformation narrative (Joseph Campbell)', '{"stages": ["ordinary_world", "call_to_adventure", "refusal", "mentor", "threshold", "tests", "ordeal", "reward", "road_back", "resurrection", "return"]}')
ON CONFLICT (code) DO NOTHING;

-- ===================
-- 2) CONTENT PROJECTS
-- ===================
-- Workspace for content creation
CREATE TABLE IF NOT EXISTS content_projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- OWNERSHIP (minds como root entity)
  creator_mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,  -- QUEM está criando
  persona_mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,  -- QUAL voz usar

  -- PROJECT METADATA
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,              -- URL-friendly name
  goals TEXT[],                           -- ['thought_leadership', 'lead_generation', 'education']
  status TEXT NOT NULL DEFAULT 'active',  -- 'active', 'paused', 'archived'

  -- OPTIONAL
  description TEXT,
  target_audience TEXT,
  default_framework_id BIGINT REFERENCES content_frameworks(id) ON DELETE SET NULL,

  -- AUDIT
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_projects_creator ON content_projects (creator_mind_id);
CREATE INDEX IF NOT EXISTS idx_projects_persona ON content_projects (persona_mind_id);
CREATE INDEX IF NOT EXISTS idx_projects_status ON content_projects (status);
CREATE UNIQUE INDEX IF NOT EXISTS idx_projects_slug ON content_projects (slug);

DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_projects_updated') THEN
    CREATE TRIGGER trg_content_projects_updated BEFORE UPDATE ON content_projects
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- ===================
-- 3) AUDIENCE PROFILES
-- ===================
-- ICP (Ideal Customer Profile) for content targeting
CREATE TABLE IF NOT EXISTS audience_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,

  -- DEMOGRAPHICS
  name TEXT NOT NULL,                     -- 'Tech Founders 28-45'
  age_range TEXT,                         -- '28-45'
  location TEXT,                          -- 'US, Europe'
  occupation TEXT,                        -- 'Software Engineer, CTO'

  -- PSYCHOGRAPHICS
  psychographic_traits JSONB,             -- Big Five scores, values, interests
  pain_points TEXT[],
  goals TEXT[],

  -- BEHAVIORAL
  content_preferences JSONB,              -- {'formats': ['blog', 'video'], 'length': 'long-form'}

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_audience_project ON audience_profiles (project_id);

DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_audience_profiles_updated') THEN
    CREATE TRIGGER trg_audience_profiles_updated BEFORE UPDATE ON audience_profiles
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- ===================
-- 4) CONTENT PIECES
-- ===================
-- Generated content artifacts (blog posts, courses, videos, etc)
CREATE TABLE IF NOT EXISTS content_pieces (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE RESTRICT,

  -- CONTENT TYPE
  type TEXT NOT NULL,                     -- 'blog', 'social', 'video_script', 'newsletter', 'course', 'lesson'
  format TEXT,                            -- 'markdown', 'html', 'yaml', 'json'

  -- CONTENT METADATA
  title TEXT NOT NULL,
  slug TEXT,                              -- URL-friendly (can be null for non-published)
  description TEXT,

  -- CONTENT BODY
  content TEXT NOT NULL,                  -- Main content (markdown, HTML, or structured data)
  metadata JSONB,                         -- Type-specific metadata (word_count, video_length, etc)

  -- FRAMEWORK & QUALITY
  framework_id BIGINT REFERENCES content_frameworks(id) ON DELETE SET NULL,
  voice_fidelity_score NUMERIC(3,2),     -- 0.0..1.0 (how well it matches persona voice)
  quality_score NUMERIC(3,2),            -- 0.0..1.0 (overall quality)

  -- GENERATION TRACKING
  generation_execution_id UUID REFERENCES job_executions(id) ON DELETE SET NULL,

  -- PUBLICATION
  status TEXT NOT NULL DEFAULT 'draft',   -- 'draft', 'review', 'published', 'archived'
  published_at TIMESTAMPTZ,
  published_url TEXT,

  -- AUDIT
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_pieces_project ON content_pieces (project_id);
CREATE INDEX IF NOT EXISTS idx_pieces_type ON content_pieces (type);
CREATE INDEX IF NOT EXISTS idx_pieces_status ON content_pieces (status);
CREATE INDEX IF NOT EXISTS idx_pieces_published ON content_pieces (published_at DESC) WHERE published_at IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_pieces_generation ON content_pieces (generation_execution_id);

DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_pieces_updated') THEN
    CREATE TRIGGER trg_content_pieces_updated BEFORE UPDATE ON content_pieces
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- ===================
-- 5) CONTENT CAMPAIGNS
-- ===================
-- Group related content pieces (product launch, course promotion, etc)
CREATE TABLE IF NOT EXISTS content_campaigns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,

  name TEXT NOT NULL,
  slug TEXT,
  goal TEXT,                              -- 'product_launch', 'course_promotion', 'thought_leadership'
  description TEXT,

  -- TIMELINE
  start_date DATE,
  end_date DATE,
  status TEXT NOT NULL DEFAULT 'planned', -- 'planned', 'active', 'completed', 'paused'

  -- METRICS TARGETS
  target_metrics JSONB,                   -- {'views': 10000, 'conversions': 100}

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_campaigns_project ON content_campaigns (project_id);
CREATE INDEX IF NOT EXISTS idx_campaigns_status ON content_campaigns (status);
CREATE INDEX IF NOT EXISTS idx_campaigns_dates ON content_campaigns (start_date, end_date);

DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_campaigns_updated') THEN
    CREATE TRIGGER trg_content_campaigns_updated BEFORE UPDATE ON content_campaigns
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- ===================
-- 6) CONTENT CAMPAIGN PIECES (M:N)
-- ===================
-- Many-to-many: campaigns ↔ content pieces
CREATE TABLE IF NOT EXISTS content_campaign_pieces (
  campaign_id UUID NOT NULL REFERENCES content_campaigns(id) ON DELETE CASCADE,
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,
  sequence_order INT,                     -- Order within campaign
  PRIMARY KEY (campaign_id, content_piece_id)
);

CREATE INDEX IF NOT EXISTS idx_ccp_campaign ON content_campaign_pieces (campaign_id);
CREATE INDEX IF NOT EXISTS idx_ccp_piece ON content_campaign_pieces (content_piece_id);

-- ===================
-- 7) CONTENT PERFORMANCE
-- ===================
-- Post-publish metrics tracking
CREATE TABLE IF NOT EXISTS content_performance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- METRIC
  metric_type TEXT NOT NULL,              -- 'views', 'engagement', 'conversions', 'shares', 'comments', 'likes'
  value NUMERIC NOT NULL,
  unit TEXT,                              -- 'count', 'percentage', 'duration_seconds'

  -- CONTEXT
  source TEXT,                            -- 'google_analytics', 'youtube', 'twitter', 'manual'
  segment JSONB,                          -- Breakdown (geography, device, etc)

  -- TIMESTAMP
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_perf_piece ON content_performance (content_piece_id);
CREATE INDEX IF NOT EXISTS idx_perf_type ON content_performance (metric_type);
CREATE INDEX IF NOT EXISTS idx_perf_recorded ON content_performance (recorded_at DESC);
CREATE INDEX IF NOT EXISTS idx_perf_piece_type ON content_performance (content_piece_id, metric_type, recorded_at DESC);

-- ===================
-- 8) CONTENT LEARNINGS
-- ===================
-- Captured insights for improvement (learning loops)
CREATE TABLE IF NOT EXISTS content_learnings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- SCOPE
  project_id UUID REFERENCES content_projects(id) ON DELETE CASCADE,
  content_piece_id UUID REFERENCES content_pieces(id) ON DELETE CASCADE,
  campaign_id UUID REFERENCES content_campaigns(id) ON DELETE CASCADE,

  -- LEARNING
  category TEXT NOT NULL,                 -- 'audience_insight', 'format_preference', 'topic_performance', 'voice_fidelity'
  insight TEXT NOT NULL,
  evidence JSONB,                         -- Supporting data (metrics, quotes, etc)

  -- ACTIONABILITY
  actionable BOOLEAN DEFAULT true,
  priority TEXT,                          -- 'high', 'medium', 'low'
  status TEXT DEFAULT 'new',              -- 'new', 'applied', 'rejected'

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_learnings_project ON content_learnings (project_id);
CREATE INDEX IF NOT EXISTS idx_learnings_piece ON content_learnings (content_piece_id);
CREATE INDEX IF NOT EXISTS idx_learnings_campaign ON content_learnings (campaign_id);
CREATE INDEX IF NOT EXISTS idx_learnings_category ON content_learnings (category);
CREATE INDEX IF NOT EXISTS idx_learnings_status ON content_learnings (status) WHERE status = 'new';

-- =========================================================
-- EXTENDED TABLES - MARKETING (5 tables)
-- =========================================================

-- ===================
-- 9) CONTENT FUNNELS
-- ===================
-- Conversion funnel definitions (TOFU → MOFU → BOFU)
CREATE TABLE IF NOT EXISTS content_funnels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,

  name TEXT NOT NULL,
  stages JSONB NOT NULL,                  -- [{'stage': 'tofu', 'goal': 'awareness'}, {'stage': 'mofu', 'goal': 'consideration'}, ...]

  -- TARGETING
  audience_profile_id UUID REFERENCES audience_profiles(id) ON DELETE SET NULL,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_funnels_project ON content_funnels (project_id);

DO $$BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_content_funnels_updated') THEN
    CREATE TRIGGER trg_content_funnels_updated BEFORE UPDATE ON content_funnels
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- ===================
-- 10) A/B TESTS
-- ===================
-- A/B test configurations and results
CREATE TABLE IF NOT EXISTS ab_tests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- SCOPE
  content_piece_id UUID REFERENCES content_pieces(id) ON DELETE CASCADE,
  campaign_id UUID REFERENCES content_campaigns(id) ON DELETE CASCADE,

  -- TEST CONFIGURATION
  name TEXT NOT NULL,
  hypothesis TEXT,
  variant_a JSONB NOT NULL,               -- {'title': 'Original', 'hook': '...'}
  variant_b JSONB NOT NULL,               -- {'title': 'Variant B', 'hook': '...'}
  metric_to_optimize TEXT NOT NULL,       -- 'ctr', 'conversions', 'engagement'

  -- RESULTS
  status TEXT NOT NULL DEFAULT 'running', -- 'running', 'completed', 'inconclusive'
  winner TEXT,                            -- 'a', 'b', 'tie', null
  results JSONB,                          -- {'variant_a': {'ctr': 0.05}, 'variant_b': {'ctr': 0.08}, 'confidence': 0.95}

  -- TIMELINE
  started_at TIMESTAMPTZ,
  ended_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_abtests_piece ON ab_tests (content_piece_id);
CREATE INDEX IF NOT EXISTS idx_abtests_campaign ON ab_tests (campaign_id);
CREATE INDEX IF NOT EXISTS idx_abtests_status ON ab_tests (status);

-- ===================
-- 11) DISTRIBUTION CHANNELS
-- ===================
-- Multi-platform distribution tracking
CREATE TABLE IF NOT EXISTS distribution_channels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- CHANNEL
  channel_type TEXT NOT NULL,             -- 'blog', 'youtube', 'linkedin', 'twitter', 'email', 'medium'
  channel_name TEXT,                      -- 'Personal Blog', 'Company YouTube'

  -- PUBLICATION
  published_url TEXT,
  published_at TIMESTAMPTZ,
  status TEXT NOT NULL DEFAULT 'pending', -- 'pending', 'published', 'failed'

  -- PERFORMANCE (summary)
  total_views INT DEFAULT 0,
  total_engagement INT DEFAULT 0,
  last_synced_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_distrib_piece ON distribution_channels (content_piece_id);
CREATE INDEX IF NOT EXISTS idx_distrib_channel ON distribution_channels (channel_type);
CREATE INDEX IF NOT EXISTS idx_distrib_status ON distribution_channels (status);

-- ===================
-- 12) CONTENT ATTRIBUTION
-- ===================
-- Multi-touch attribution data
CREATE TABLE IF NOT EXISTS content_attribution (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- CONVERSION EVENT
  conversion_id TEXT NOT NULL,            -- Unique conversion identifier (order_id, signup_id, etc)
  conversion_type TEXT NOT NULL,          -- 'sale', 'signup', 'download', 'contact'
  conversion_value NUMERIC(12,2),         -- Revenue or value
  conversion_date TIMESTAMPTZ NOT NULL,

  -- TOUCHPOINTS (array of content pieces in customer journey)
  touchpoints JSONB NOT NULL,             -- [{'piece_id': 'uuid', 'timestamp': '...', 'position': 1}, ...]

  -- ATTRIBUTION MODELS
  first_touch_piece_id UUID REFERENCES content_pieces(id) ON DELETE SET NULL,
  last_touch_piece_id UUID REFERENCES content_pieces(id) ON DELETE SET NULL,
  linear_attribution JSONB,               -- Equal credit to all touchpoints
  time_decay_attribution JSONB,           -- More credit to recent touchpoints

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_attrib_conversion ON content_attribution (conversion_id);
CREATE INDEX IF NOT EXISTS idx_attrib_date ON content_attribution (conversion_date DESC);
CREATE INDEX IF NOT EXISTS idx_attrib_first ON content_attribution (first_touch_piece_id);
CREATE INDEX IF NOT EXISTS idx_attrib_last ON content_attribution (last_touch_piece_id);

-- ===================
-- 13) CONTENT SEO TRACKING
-- ===================
-- SEO performance over time
CREATE TABLE IF NOT EXISTS content_seo_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_piece_id UUID NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- KEYWORD
  keyword TEXT NOT NULL,
  search_volume INT,

  -- RANKINGS
  position INT,                           -- Google ranking position
  url TEXT,                               -- Ranking URL

  -- METRICS
  impressions INT,
  clicks INT,
  ctr NUMERIC(5,4),                       -- Click-through rate

  -- TIMESTAMP
  tracked_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_seo_piece ON content_seo_tracking (content_piece_id);
CREATE INDEX IF NOT EXISTS idx_seo_keyword ON content_seo_tracking (keyword);
CREATE INDEX IF NOT EXISTS idx_seo_tracked ON content_seo_tracking (tracked_at DESC);
CREATE INDEX IF NOT EXISTS idx_seo_piece_keyword ON content_seo_tracking (content_piece_id, keyword, tracked_at DESC);

-- =========================================================
-- VIEWS - PERFORMANCE & ANALYTICS
-- =========================================================

-- View: Content piece performance summary
CREATE OR REPLACE VIEW v_content_performance_summary AS
SELECT
  cp.id AS content_piece_id,
  cp.title,
  cp.type,
  cp.status,
  cp.published_at,
  COUNT(DISTINCT perf.id) AS metrics_count,
  SUM(CASE WHEN perf.metric_type = 'views' THEN perf.value ELSE 0 END) AS total_views,
  SUM(CASE WHEN perf.metric_type = 'engagement' THEN perf.value ELSE 0 END) AS total_engagement,
  SUM(CASE WHEN perf.metric_type = 'conversions' THEN perf.value ELSE 0 END) AS total_conversions,
  cp.voice_fidelity_score,
  cp.quality_score,
  proj.name AS project_name,
  m_creator.display_name AS creator_name,
  m_persona.display_name AS persona_name
FROM content_pieces cp
JOIN content_projects proj ON proj.id = cp.project_id
JOIN minds m_creator ON m_creator.id = proj.creator_mind_id
JOIN minds m_persona ON m_persona.id = proj.persona_mind_id
LEFT JOIN content_performance perf ON perf.content_piece_id = cp.id
GROUP BY cp.id, cp.title, cp.type, cp.status, cp.published_at, cp.voice_fidelity_score,
         cp.quality_score, proj.name, m_creator.display_name, m_persona.display_name;

-- View: Campaign performance
CREATE OR REPLACE VIEW v_campaign_performance AS
SELECT
  camp.id AS campaign_id,
  camp.name,
  camp.status,
  camp.start_date,
  camp.end_date,
  COUNT(DISTINCT ccp.content_piece_id) AS pieces_count,
  proj.name AS project_name
FROM content_campaigns camp
JOIN content_projects proj ON proj.id = camp.project_id
LEFT JOIN content_campaign_pieces ccp ON ccp.campaign_id = camp.id
GROUP BY camp.id, camp.name, camp.status, camp.start_date, camp.end_date, proj.name;

-- View: Project dashboard
CREATE OR REPLACE VIEW v_project_dashboard AS
SELECT
  proj.id AS project_id,
  proj.name,
  proj.status,
  m_creator.display_name AS creator,
  m_persona.display_name AS default_persona,
  COUNT(DISTINCT cp.id) AS total_pieces,
  COUNT(DISTINCT CASE WHEN cp.status = 'published' THEN cp.id END) AS published_pieces,
  COUNT(DISTINCT camp.id) AS campaigns_count,
  AVG(cp.voice_fidelity_score) AS avg_fidelity,
  AVG(cp.quality_score) AS avg_quality,
  proj.created_at
FROM content_projects proj
JOIN minds m_creator ON m_creator.id = proj.creator_mind_id
JOIN minds m_persona ON m_persona.id = proj.persona_mind_id
LEFT JOIN content_pieces cp ON cp.project_id = proj.id
LEFT JOIN content_campaigns camp ON camp.project_id = proj.id
GROUP BY proj.id, proj.name, proj.status, m_creator.display_name, m_persona.display_name, proj.created_at;

-- =========================================================
-- COMMENTS & DOCUMENTATION
-- =========================================================

COMMENT ON TABLE content_projects IS 'Content creation projects (creator uses persona voice)';
COMMENT ON TABLE content_pieces IS 'Generated content artifacts (blog, course, video, etc)';
COMMENT ON TABLE content_frameworks IS 'Pedagogical/storytelling/marketing frameworks (GPS, AIDA, etc)';
COMMENT ON TABLE content_performance IS 'Post-publish metrics (views, engagement, conversions)';
COMMENT ON TABLE content_learnings IS 'Captured insights for continuous improvement';

-- =========================================================
-- END OF SCRIPT
-- =========================================================
