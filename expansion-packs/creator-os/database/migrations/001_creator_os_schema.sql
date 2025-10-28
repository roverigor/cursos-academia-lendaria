-- ════════════════════════════════════════════════════════════════════════════════
-- MIGRATION: CreatorOS Schema (Ultra Minimalista)
-- ════════════════════════════════════════════════════════════════════════════════
-- Version: 001
-- Description: Cria schema CreatorOS com contents universal, multi-mind support,
--              frameworks, audience profiles e projetos.
-- Dependencies: minds, sources, job_executions, tags (must exist)
-- Author: DB Sage
-- Date: 2025-10-28
-- ════════════════════════════════════════════════════════════════════════════════

-- ════════════════════════════════════════════════════════════════════════════════
-- PRE-FLIGHT CHECKS
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  -- Check required tables exist
  IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'minds') THEN
    RAISE EXCEPTION 'Required table "minds" does not exist. Run MMOS migrations first.';
  END IF;

  IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'job_executions') THEN
    RAISE EXCEPTION 'Required table "job_executions" does not exist. Run MMOS migrations first.';
  END IF;

  IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'tags') THEN
    RAISE EXCEPTION 'Required table "tags" does not exist. Run MMOS migrations first.';
  END IF;

  -- Sources is optional (for collected content)
  IF NOT EXISTS (SELECT FROM pg_tables WHERE tablename = 'sources') THEN
    RAISE NOTICE 'Table "sources" does not exist. Collected content features will be limited.';
  END IF;

  RAISE NOTICE 'Pre-flight checks passed. Proceeding with migration...';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- SCHEMA CREATION
-- ════════════════════════════════════════════════════════════════════════════════

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT FRAMEWORKS
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS content_frameworks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  framework_type TEXT CHECK(framework_type IN (
    'pedagogical', 'content_structure', 'storytelling', 'marketing', 'other'
  )),
  framework_schema JSONB,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ────────────────────────────────────────────────────────────────────────────────
-- AUDIENCE PROFILES
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS audience_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  demographics JSONB,
  psychographics JSONB,
  technical_level TEXT CHECK(technical_level IN (
    'beginner', 'intermediate', 'advanced', 'expert', NULL
  )),
  learning_preferences JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT PROJECTS
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS content_projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  project_type TEXT CHECK(project_type IN (
    'course', 'book', 'blog_series', 'video_series',
    'newsletter', 'social_media_campaign', 'other'
  )),
  status TEXT DEFAULT 'planning' CHECK(status IN (
    'planning', 'in_progress', 'completed', 'archived'
  )),
  target_audience_id UUID REFERENCES audience_profiles(id),
  default_frameworks JSONB,
  project_metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENTS (CORE TABLE) - Universal, Multi-mind
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS contents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Type
  ai_generated BOOLEAN NOT NULL DEFAULT false,
  content_type TEXT NOT NULL CHECK(content_type IN (
    'raw_source', 'interview', 'podcast_transcript', 'video_transcript',
    'article', 'book_excerpt', 'essay', 'speech', 'social_media_post',
    'email', 'conversation', 'academic_paper',
    'course_outline', 'course_module', 'course_lesson',
    'book_outline', 'book_part', 'book_chapter',
    'blog_series', 'blog_post',
    'video_script', 'video_chapter',
    'social_post_linkedin', 'social_post_twitter',
    'social_thread', 'newsletter_edition',
    'other'
  )),

  -- Hierarchy
  parent_content_id UUID REFERENCES contents(id) ON DELETE CASCADE,
  sequence_order SMALLINT,

  -- Identity
  slug TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,

  -- Content
  content TEXT,

  -- Process tracking
  generation_execution_id UUID REFERENCES job_executions(id),

  -- CreatorOS
  project_id UUID REFERENCES content_projects(id) ON DELETE SET NULL,
  fidelity_score NUMERIC(3,2) CHECK(fidelity_score BETWEEN 0 AND 1),

  -- Metadata (flexible JSONB)
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,

  -- Lifecycle
  status TEXT DEFAULT 'draft' CHECK(status IN ('draft', 'reviewed', 'published', 'archived')),
  published_at TIMESTAMPTZ,
  published_url TEXT,
  file_path TEXT,

  -- Timestamps
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT_MINDS (M:N)
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS content_minds (
  content_id UUID NOT NULL REFERENCES contents(id) ON DELETE CASCADE,
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  role TEXT CHECK(role IN (
    'creator', 'author', 'co_author', 'host', 'guest',
    'interviewer', 'interviewee', 'participant', 'moderator',
    'contributor', 'other'
  )),
  PRIMARY KEY (content_id, mind_id)
);

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT_TAGS (M:N)
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS content_tags (
  content_id UUID NOT NULL REFERENCES contents(id) ON DELETE CASCADE,
  tag_id BIGINT NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (content_id, tag_id)
);

-- ════════════════════════════════════════════════════════════════════════════════
-- ÍNDICES
-- ════════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_contents_ai_generated ON contents(ai_generated) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_content_minds_content ON content_minds(content_id);
CREATE INDEX IF NOT EXISTS idx_content_minds_mind ON content_minds(mind_id);
CREATE INDEX IF NOT EXISTS idx_content_minds_role ON content_minds(mind_id, role);
CREATE INDEX IF NOT EXISTS idx_contents_parent ON contents(parent_content_id, sequence_order) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_contents_project ON contents(project_id) WHERE ai_generated = true AND deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_contents_status ON contents(status, published_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_contents_generation ON contents(generation_execution_id) WHERE ai_generated = true;
CREATE INDEX IF NOT EXISTS idx_content_tags_content ON content_tags(content_id);
CREATE INDEX IF NOT EXISTS idx_content_tags_tag ON content_tags(tag_id);
CREATE INDEX IF NOT EXISTS idx_contents_fts ON contents USING GIN (to_tsvector('english', coalesce(title,'') || ' ' || coalesce(content,'')));
CREATE INDEX IF NOT EXISTS idx_contents_metadata ON contents USING GIN (metadata);
CREATE INDEX IF NOT EXISTS idx_contents_slug ON contents(slug) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_content_projects_slug ON content_projects(slug);
CREATE INDEX IF NOT EXISTS idx_content_frameworks_slug ON content_frameworks(slug) WHERE is_active = true;

-- ════════════════════════════════════════════════════════════════════════════════
-- FUNCTIONS
-- ════════════════════════════════════════════════════════════════════════════════

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Estimated word count
CREATE OR REPLACE FUNCTION get_word_count(content_text TEXT)
RETURNS INT AS $$
BEGIN
  IF content_text IS NULL THEN RETURN 0; END IF;
  RETURN LENGTH(content_text) / 5;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Depth level (hierarchy)
CREATE OR REPLACE FUNCTION get_depth_level(content_id_param UUID)
RETURNS INT AS $$
DECLARE depth INT;
BEGIN
  WITH RECURSIVE hierarchy AS (
    SELECT id, parent_content_id, 0 as level
    FROM contents WHERE id = content_id_param
    UNION ALL
    SELECT c.id, c.parent_content_id, h.level + 1
    FROM contents c JOIN hierarchy h ON c.id = h.parent_content_id
  )
  SELECT MAX(level) INTO depth FROM hierarchy;
  RETURN COALESCE(depth, 0);
END;
$$ LANGUAGE plpgsql;

-- Validation: ai_generated warning
CREATE OR REPLACE FUNCTION validate_ai_generated_fields()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.ai_generated = true AND NEW.generation_execution_id IS NULL THEN
    RAISE NOTICE 'Warning: ai_generated content without generation_execution_id (content_id: %)', NEW.id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ════════════════════════════════════════════════════════════════════════════════
-- TRIGGERS
-- ════════════════════════════════════════════════════════════════════════════════

CREATE TRIGGER trg_contents_updated_at BEFORE UPDATE ON contents FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_content_frameworks_updated_at BEFORE UPDATE ON content_frameworks FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_audience_profiles_updated_at BEFORE UPDATE ON audience_profiles FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_content_projects_updated_at BEFORE UPDATE ON content_projects FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_validate_ai_generated BEFORE INSERT OR UPDATE ON contents FOR EACH ROW EXECUTE FUNCTION validate_ai_generated_fields();

-- ════════════════════════════════════════════════════════════════════════════════
-- COMMENTS
-- ════════════════════════════════════════════════════════════════════════════════

COMMENT ON TABLE contents IS 'Universal content table: both collected (ai_generated=false) and generated (ai_generated=true). Multi-mind support via content_minds.';
COMMENT ON COLUMN contents.ai_generated IS 'Discriminator: false = collected, true = AI-generated';
COMMENT ON COLUMN contents.metadata IS 'Flexible JSONB metadata. Collected: source_url, platform, processing_status. Generated: persona_config, frameworks, validation_scores.';
COMMENT ON COLUMN contents.generation_execution_id IS 'Links to job_executions for LLM metadata (model, tokens, cost, latency)';

COMMENT ON TABLE content_minds IS 'M:N relationship: contents ↔ minds. Enables multi-mind content (interviews, podcasts, debates).';
COMMENT ON TABLE content_frameworks IS 'Content creation frameworks (GPS, Bloom''s, DIDÁTICA LENDÁRIA, Hero''s Journey, AIDA, PAS, etc.)';
COMMENT ON TABLE audience_profiles IS 'Target audience profiles with demographics, psychographics, learning preferences';
COMMENT ON TABLE content_projects IS 'Content projects (courses, books, blog series) that group related contents';

-- ════════════════════════════════════════════════════════════════════════════════
-- SEED DATA
-- ════════════════════════════════════════════════════════════════════════════════

-- Frameworks (8 essenciais)
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active) VALUES
('gps', 'GPS: Gancho, Promessa, Solução', 'Framework de estrutura de conteúdo criado por Erico Rocha.', 'content_structure', '{"sections":[{"name":"gancho","title":"Gancho","description":"Captura a atenção","techniques":["curiosity_gap","bold_statement"]},{"name":"promessa","title":"Promessa","description":"Gera expectativa","techniques":["clear_benefit","social_proof"]},{"name":"solucao","title":"Solução","description":"Entrega valor","techniques":["step_by_step","examples"]}]}'::jsonb, true),
('blooms_taxonomy', 'Bloom''s Taxonomy', 'Taxonomia de objetivos educacionais de Benjamin Bloom. 6 níveis cognitivos.', 'pedagogical', '{"levels":[{"level":1,"name":"Remember"},{"level":2,"name":"Understand"},{"level":3,"name":"Apply"},{"level":4,"name":"Analyze"},{"level":5,"name":"Evaluate"},{"level":6,"name":"Create"}]}'::jsonb, true),
('didatica_lendaria', 'DIDÁTICA LENDÁRIA', 'Framework pedagógico proprietário que combina storytelling e aprendizagem ativa.', 'pedagogical', '{"principles":["contextualizacao","historia","pratica_imediata","progressao_logica","conexao_emocional"]}'::jsonb, true),
('heros_journey', 'Hero''s Journey', 'Framework de storytelling de Joseph Campbell. 12 etapas.', 'storytelling', '{"acts":[{"act":1,"name":"Departure"},{"act":2,"name":"Initiation"},{"act":3,"name":"Return"}]}'::jsonb, true),
('story_circle', 'Story Circle (Dan Harmon)', 'Framework de storytelling simplificado. 8 etapas.', 'storytelling', '{"steps":[{"step":1,"name":"You"},{"step":2,"name":"Need"},{"step":3,"name":"Go"},{"step":4,"name":"Search"},{"step":5,"name":"Find"},{"step":6,"name":"Take"},{"step":7,"name":"Return"},{"step":8,"name":"Change"}]}'::jsonb, true),
('aida', 'AIDA', 'Framework de marketing: Attention, Interest, Desire, Action.', 'marketing', '{"stages":[{"stage":"A","name":"Attention"},{"stage":"I","name":"Interest"},{"stage":"D","name":"Desire"},{"stage":"A","name":"Action"}]}'::jsonb, true),
('pas', 'PAS', 'Framework de copywriting: Problem, Agitate, Solve.', 'marketing', '{"stages":[{"stage":"P","name":"Problem"},{"stage":"A","name":"Agitate"},{"stage":"S","name":"Solve"}]}'::jsonb, true),
('seo_content_structure', 'SEO Content Structure', 'Framework de estruturação de conteúdo otimizado para SEO.', 'content_structure', '{"structure":{"h1":{"count":1},"h2":{"count":"3-7"},"intro":{"words":"50-150"},"body":{"words":"1500-3000"}}}'::jsonb, true)
ON CONFLICT (slug) DO NOTHING;

-- Audience Profiles (3 exemplos)
INSERT INTO audience_profiles (slug, name, description, demographics, psychographics, technical_level, learning_preferences) VALUES
('empreendedores-digitais-iniciantes', 'Empreendedores Digitais Iniciantes', 'Empreendedores no início da jornada.', '{"age_range":"25-45","location":"Brasil","education":"Superior"}'::jsonb, '{"interests":["negócios online","marketing digital"],"pain_points":["não sabe por onde começar","falta de tempo"]}'::jsonb, 'beginner', '{"primary":"visual","preferences":["vídeos curtos","passo a passo"]}'::jsonb),
('desenvolvedores-fullstack', 'Desenvolvedores Full Stack', 'Desenvolvedores experientes.', '{"age_range":"25-40","location":"Global","education":"Superior em TI"}'::jsonb, '{"interests":["arquitetura de software","DevOps"],"pain_points":["código legado","débito técnico"]}'::jsonb, 'advanced', '{"primary":"reading_writing","preferences":["documentação técnica","code examples"]}'::jsonb),
('criadores-de-conteudo', 'Criadores de Conteúdo', 'Creators buscando sistematizar criação.', '{"age_range":"20-35","location":"Global"}'::jsonb, '{"interests":["storytelling","engagement","monetização"],"pain_points":["bloqueio criativo","burnout"]}'::jsonb, 'intermediate', '{"primary":"visual","preferences":["vídeos","templates","frameworks"]}'::jsonb)
ON CONFLICT (slug) DO NOTHING;

-- Content Projects (3 exemplos)
INSERT INTO content_projects (slug, name, description, project_type, status, target_audience_id, default_frameworks, project_metadata) VALUES
('academia-lendaria', 'Academia Lendária', 'Plataforma de cursos premium.', 'course', 'in_progress', (SELECT id FROM audience_profiles WHERE slug = 'empreendedores-digitais-iniciantes'), '["gps","didatica_lendaria","aida"]'::jsonb, '{"brand":"Academia Lendária","tone":"inspirador"}'::jsonb),
('blog-tech-insights', 'Tech Insights Blog', 'Blog técnico com deep dives.', 'blog_series', 'in_progress', (SELECT id FROM audience_profiles WHERE slug = 'desenvolvedores-fullstack'), '["seo_content_structure","blooms_taxonomy"]'::jsonb, '{"publishing_frequency":"2x por semana","seo_focus":true}'::jsonb),
('criatividade-sem-limites', 'Criatividade Sem Limites', 'Série sobre criação de conteúdo.', 'video_series', 'planning', (SELECT id FROM audience_profiles WHERE slug = 'criadores-de-conteudo'), '["story_circle","heros_journey","gps"]'::jsonb, '{"platforms":["YouTube","Newsletter"],"storytelling_heavy":true}'::jsonb)
ON CONFLICT (slug) DO NOTHING;

-- ════════════════════════════════════════════════════════════════════════════════
-- POST-FLIGHT VALIDATION
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  frameworks_count INT;
  audiences_count INT;
  projects_count INT;
BEGIN
  SELECT COUNT(*) INTO frameworks_count FROM content_frameworks;
  SELECT COUNT(*) INTO audiences_count FROM audience_profiles;
  SELECT COUNT(*) INTO projects_count FROM content_projects;

  RAISE NOTICE '✅ Migration completed successfully!';
  RAISE NOTICE '   • Frameworks: % installed', frameworks_count;
  RAISE NOTICE '   • Audience Profiles: % created', audiences_count;
  RAISE NOTICE '   • Content Projects: % created', projects_count;
  RAISE NOTICE '   • Tables: contents, content_minds, content_tags, content_frameworks, audience_profiles, content_projects';
  RAISE NOTICE '   • Views: Run views.sql to create analytics views';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- ROLLBACK SCRIPT (commented out - uncomment to rollback)
-- ════════════════════════════════════════════════════════════════════════════════
/*
-- WARNING: This will DELETE ALL CreatorOS data!
-- Only run if you need to completely rollback this migration.

DROP TABLE IF EXISTS content_tags CASCADE;
DROP TABLE IF EXISTS content_minds CASCADE;
DROP TABLE IF EXISTS contents CASCADE;
DROP TABLE IF EXISTS content_projects CASCADE;
DROP TABLE IF EXISTS audience_profiles CASCADE;
DROP TABLE IF EXISTS content_frameworks CASCADE;

DROP FUNCTION IF EXISTS validate_ai_generated_fields() CASCADE;
DROP FUNCTION IF EXISTS get_depth_level(UUID) CASCADE;
DROP FUNCTION IF EXISTS get_word_count(TEXT) CASCADE;

-- Note: set_updated_at() is shared, don't drop unless you're sure no other tables use it

-- RAISE NOTICE 'Rollback completed. All CreatorOS tables and functions dropped.';
*/

-- ════════════════════════════════════════════════════════════════════════════════
-- END OF MIGRATION
-- ════════════════════════════════════════════════════════════════════════════════
