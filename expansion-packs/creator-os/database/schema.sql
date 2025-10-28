-- ════════════════════════════════════════════════════════════════════════════════
-- CREATORÓS DATABASE SCHEMA - Ultra Minimalista
-- ════════════════════════════════════════════════════════════════════════════════
-- Design Principles:
--   • KISS: 18 campos essenciais (vs 45 original)
--   • Zero duplicação: LLM data em job_executions, source data em sources
--   • Multi-mind support: Junction table content_minds
--   • Flexibility: JSONB metadata para edge cases
--   • Calculável não armazenado: word_count, depth_level
-- ════════════════════════════════════════════════════════════════════════════════

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT FRAMEWORKS - Frameworks de criação (GPS, Bloom's, DIDÁTICA LENDÁRIA, etc.)
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS content_frameworks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  framework_type TEXT CHECK(framework_type IN (
    'pedagogical',      -- Bloom's Taxonomy, DIDÁTICA LENDÁRIA
    'content_structure', -- GPS (Gancho, Promessa, Solução)
    'storytelling',     -- Hero's Journey, Story Circle
    'marketing',        -- AIDA, PAS
    'other'
  )),
  framework_schema JSONB,  -- JSON Schema para validação
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ────────────────────────────────────────────────────────────────────────────────
-- AUDIENCE PROFILES - Perfis de público-alvo
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS audience_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  demographics JSONB,  -- age_range, location, education, occupation
  psychographics JSONB,  -- interests, values, pain_points, goals
  technical_level TEXT CHECK(technical_level IN (
    'beginner', 'intermediate', 'advanced', 'expert', NULL
  )),
  learning_preferences JSONB,  -- visual, auditory, kinesthetic, reading_writing
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT PROJECTS - Projetos de conteúdo (Academia Lendária, etc.)
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
  default_frameworks JSONB,  -- array de framework slugs
  project_metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ════════════════════════════════════════════════════════════════════════════════
-- CONTENTS - Universal, Minimal, Multi-mind (CORE TABLE)
-- ════════════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS contents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- ════════════════════════════════════════════
  -- TYPE (discriminador essencial)
  -- ════════════════════════════════════════════
  ai_generated BOOLEAN NOT NULL DEFAULT false,
  content_type TEXT NOT NULL CHECK(content_type IN (
    -- Collected (ai_generated = false)
    'raw_source', 'interview', 'podcast_transcript', 'video_transcript',
    'article', 'book_excerpt', 'essay', 'speech', 'social_media_post',
    'email', 'conversation', 'academic_paper',
    -- Generated (ai_generated = true)
    'course_outline', 'course_module', 'course_lesson',
    'book_outline', 'book_part', 'book_chapter',
    'blog_series', 'blog_post',
    'video_script', 'video_chapter',
    'social_post_linkedin', 'social_post_twitter',
    'social_thread', 'newsletter_edition',
    'other'
  )),

  -- ════════════════════════════════════════════
  -- HIERARQUIA (opcional, para cursos/livros)
  -- ════════════════════════════════════════════
  parent_content_id UUID REFERENCES contents(id) ON DELETE CASCADE,
  sequence_order SMALLINT,

  -- ════════════════════════════════════════════
  -- IDENTITY
  -- ════════════════════════════════════════════
  slug TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,

  -- ════════════════════════════════════════════
  -- CONTENT
  -- ════════════════════════════════════════════
  content TEXT,

  -- ════════════════════════════════════════════
  -- PROCESS TRACKING
  -- ════════════════════════════════════════════
  generation_execution_id UUID REFERENCES job_executions(id),
  -- Links to job_executions for ALL LLM metadata:
  --   • llm_model, llm_provider, llm_version
  --   • tokens_prompt, tokens_completion, tokens_total
  --   • cost_usd, latency_ms
  --   • params (JSONB for generation config)

  -- ════════════════════════════════════════════
  -- CREATORÓS (se ai_generated = true)
  -- ════════════════════════════════════════════
  project_id UUID REFERENCES content_projects(id) ON DELETE SET NULL,
  fidelity_score NUMERIC(3,2) CHECK(fidelity_score BETWEEN 0 AND 1),

  -- ════════════════════════════════════════════
  -- METADATA (tudo flexível aqui!)
  -- ════════════════════════════════════════════
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  -- Examples for COLLECTED content (ai_generated = false):
  -- {
  --   "source_url": "https://...",
  --   "source_platform": "YouTube",
  --   "source_date": "2024-10-15",
  --   "processing_status": "completed",
  --   "quality": "primary",
  --   "language": "pt"
  -- }
  --
  -- Examples for GENERATED content (ai_generated = true):
  -- {
  --   "audience_id": "uuid...",
  --   "persona_type": "mmos_clone",
  --   "persona_config": {...},
  --   "frameworks": ["gps", "blooms_taxonomy"],
  --   "readability_score": 0.85,
  --   "fidelity_report": {...},
  --   "format_subtype": "how_to",
  --   "generation_version": "v1.0",
  --   "regeneration_count": 2,
  --   "validation_scores": {
  --     "gps_validation": 0.95,
  --     "tone_match": 0.88
  --   }
  -- }

  -- ════════════════════════════════════════════
  -- STATUS & PUBLICATION
  -- ════════════════════════════════════════════
  status TEXT DEFAULT 'draft' CHECK(status IN (
    'draft', 'reviewed', 'published', 'archived'
  )),
  published_at TIMESTAMPTZ,
  published_url TEXT,

  -- ════════════════════════════════════════════
  -- FILE STORAGE
  -- ════════════════════════════════════════════
  file_path TEXT,

  -- ════════════════════════════════════════════
  -- TIMESTAMPS
  -- ════════════════════════════════════════════
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ  -- soft delete
);

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT_MINDS - Multi-mind support (M:N)
-- ────────────────────────────────────────────────────────────────────────────────
-- Permite que 1 conteúdo tenha múltiplas minds:
--   • Entrevistas: host + guest(s)
--   • Podcasts: host + convidados
--   • Debates: múltiplos participantes
--   • Conversas: múltiplos participantes
--   • Livros: autor principal + co-autores
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS content_minds (
  content_id UUID NOT NULL REFERENCES contents(id) ON DELETE CASCADE,
  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  role TEXT CHECK(role IN (
    'creator',      -- Criador/autor principal (generated content)
    'author',       -- Autor (collected content)
    'co_author',    -- Co-autor
    'host',         -- Host de podcast/entrevista
    'guest',        -- Convidado
    'interviewer',  -- Entrevistador
    'interviewee',  -- Entrevistado
    'participant',  -- Participante (debates, conversas)
    'moderator',    -- Moderador
    'contributor',  -- Contribuidor
    'other'
  )),
  PRIMARY KEY (content_id, mind_id)
);

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT_TAGS - Tagging (M:N)
-- ────────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS content_tags (
  content_id UUID NOT NULL REFERENCES contents(id) ON DELETE CASCADE,
  tag_id BIGINT NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (content_id, tag_id)
);

-- ════════════════════════════════════════════════════════════════════════════════
-- ÍNDICES CRÍTICOS
-- ════════════════════════════════════════════════════════════════════════════════

-- Discriminador (queries eficientes)
CREATE INDEX IF NOT EXISTS idx_contents_ai_generated
  ON contents(ai_generated)
  WHERE deleted_at IS NULL;

-- Mind-centric (padrão MMOS)
CREATE INDEX IF NOT EXISTS idx_content_minds_content
  ON content_minds(content_id);

CREATE INDEX IF NOT EXISTS idx_content_minds_mind
  ON content_minds(mind_id);

CREATE INDEX IF NOT EXISTS idx_content_minds_role
  ON content_minds(mind_id, role);

-- Hierarquia (cursos/livros)
CREATE INDEX IF NOT EXISTS idx_contents_parent
  ON contents(parent_content_id, sequence_order)
  WHERE deleted_at IS NULL;

-- FIXED: depth_level is computed, not a column
CREATE INDEX IF NOT EXISTS idx_contents_hierarchy
  ON contents(parent_content_id, sequence_order)
  WHERE deleted_at IS NULL AND parent_content_id IS NOT NULL;

-- CreatorOS
CREATE INDEX IF NOT EXISTS idx_contents_project
  ON contents(project_id)
  WHERE ai_generated = true AND deleted_at IS NULL;

-- Performance
CREATE INDEX IF NOT EXISTS idx_contents_status
  ON contents(status, published_at DESC)
  WHERE deleted_at IS NULL;

-- Processing (collected only)
CREATE INDEX IF NOT EXISTS idx_contents_processing
  ON contents((metadata->>'processing_status'))
  WHERE ai_generated = false AND deleted_at IS NULL;

-- AI Analytics
CREATE INDEX IF NOT EXISTS idx_contents_generation
  ON contents(generation_execution_id)
  WHERE ai_generated = true;

-- Tags
CREATE INDEX IF NOT EXISTS idx_content_tags_content
  ON content_tags(content_id);

CREATE INDEX IF NOT EXISTS idx_content_tags_tag
  ON content_tags(tag_id);

-- Full-text search
CREATE INDEX IF NOT EXISTS idx_contents_fts
  ON contents
  USING GIN (to_tsvector('english', coalesce(title,'') || ' ' || coalesce(content,'')));

-- JSONB metadata (GIN index para queries em metadata)
CREATE INDEX IF NOT EXISTS idx_contents_metadata
  ON contents USING GIN (metadata);

-- Slug lookups
CREATE INDEX IF NOT EXISTS idx_contents_slug
  ON contents(slug)
  WHERE deleted_at IS NULL;

-- Projects
CREATE INDEX IF NOT EXISTS idx_content_projects_slug
  ON content_projects(slug);

-- Frameworks
CREATE INDEX IF NOT EXISTS idx_content_frameworks_slug
  ON content_frameworks(slug)
  WHERE is_active = true;

-- ════════════════════════════════════════════════════════════════════════════════
-- TRIGGERS
-- ════════════════════════════════════════════════════════════════════════════════

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_contents_updated_at
  BEFORE UPDATE ON contents
  FOR EACH ROW
  EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_content_frameworks_updated_at
  BEFORE UPDATE ON content_frameworks
  FOR EACH ROW
  EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_audience_profiles_updated_at
  BEFORE UPDATE ON audience_profiles
  FOR EACH ROW
  EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_content_projects_updated_at
  BEFORE UPDATE ON content_projects
  FOR EACH ROW
  EXECUTE FUNCTION set_updated_at();

-- Validação: ai_generated = true DEVE ter generation_execution_id (opcional, mas recomendado)
CREATE OR REPLACE FUNCTION validate_ai_generated_fields()
RETURNS TRIGGER AS $$
BEGIN
  -- Warning: não é obrigatório ter generation_execution_id, mas é recomendado
  -- Pode ser NULL se gerado externamente ou por sistema legado
  IF NEW.ai_generated = true AND NEW.generation_execution_id IS NULL THEN
    RAISE NOTICE 'Warning: ai_generated content without generation_execution_id (content_id: %)', NEW.id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validate_ai_generated
  BEFORE INSERT OR UPDATE ON contents
  FOR EACH ROW
  EXECUTE FUNCTION validate_ai_generated_fields();

-- Auto-calculate depth_level (virtual column via computed on read)
-- NOTE: depth_level NÃO é armazenado, é calculado via recursive CTE nas views

-- ════════════════════════════════════════════════════════════════════════════════
-- COMPUTED COLUMNS (via SQL functions)
-- ════════════════════════════════════════════════════════════════════════════════

-- Função: Calcular word count estimado
CREATE OR REPLACE FUNCTION get_word_count(content_text TEXT)
RETURNS INT AS $$
BEGIN
  IF content_text IS NULL THEN
    RETURN 0;
  END IF;
  RETURN LENGTH(content_text) / 5;  -- Estimativa: 5 chars por palavra
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Função: Calcular depth level (hierarquia)
CREATE OR REPLACE FUNCTION get_depth_level(content_id_param UUID)
RETURNS INT AS $$
DECLARE
  depth INT;
BEGIN
  WITH RECURSIVE hierarchy AS (
    SELECT id, parent_content_id, 0 as level
    FROM contents
    WHERE id = content_id_param

    UNION ALL

    SELECT c.id, c.parent_content_id, h.level + 1
    FROM contents c
    JOIN hierarchy h ON c.id = h.parent_content_id
  )
  SELECT MAX(level) INTO depth FROM hierarchy;

  RETURN COALESCE(depth, 0);
END;
$$ LANGUAGE plpgsql;

-- ════════════════════════════════════════════════════════════════════════════════
-- RLS POLICIES (Row Level Security)
-- ════════════════════════════════════════════════════════════════════════════════
-- NOTE: Adjust based on your authentication system
-- Assuming you have a current_mind_id() function that returns the authenticated mind's UUID

-- Collected content: público (read-only)
-- CREATE POLICY "Collected content is viewable by all" ON contents
--   FOR SELECT
--   USING (ai_generated = false AND deleted_at IS NULL);

-- Generated content: privado (owner only)
-- CREATE POLICY "Generated content is managed by creator" ON contents
--   FOR ALL
--   USING (
--     ai_generated = true
--     AND EXISTS (
--       SELECT 1 FROM content_minds cm
--       WHERE cm.content_id = contents.id
--         AND cm.mind_id = current_mind_id()
--         AND cm.role IN ('creator', 'author')
--     )
--     AND deleted_at IS NULL
--   )
--   WITH CHECK (
--     ai_generated = true
--     AND EXISTS (
--       SELECT 1 FROM content_minds cm
--       WHERE cm.content_id = contents.id
--         AND cm.mind_id = current_mind_id()
--         AND cm.role IN ('creator', 'author')
--     )
--   );

-- Enable RLS (uncomment when ready)
-- ALTER TABLE contents ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE content_minds ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE content_tags ENABLE ROW LEVEL SECURITY;

-- ════════════════════════════════════════════════════════════════════════════════
-- COMENTÁRIOS (PostgreSQL COMMENT)
-- ════════════════════════════════════════════════════════════════════════════════

COMMENT ON TABLE contents IS 'Universal content table: both collected (ai_generated=false) and generated (ai_generated=true). Multi-mind support via content_minds junction.';
COMMENT ON COLUMN contents.ai_generated IS 'Discriminator: false = collected from sources, true = AI-generated';
COMMENT ON COLUMN contents.metadata IS 'JSONB for flexible metadata. Collected: source_url, platform, processing_status. Generated: persona_config, frameworks, validation_scores.';
COMMENT ON COLUMN contents.generation_execution_id IS 'Links to job_executions for ALL LLM metadata (model, tokens, cost, latency)';
COMMENT ON COLUMN contents.fidelity_score IS 'How well AI-generated content matches the source mind (0.0-1.0)';

COMMENT ON TABLE content_minds IS 'M:N relationship between contents and minds. Enables multi-mind content (interviews, podcasts, debates).';
COMMENT ON COLUMN content_minds.role IS 'Role of the mind in the content: creator, host, guest, interviewer, participant, etc.';

COMMENT ON TABLE content_frameworks IS 'Content creation frameworks (GPS, Bloom''s Taxonomy, DIDÁTICA LENDÁRIA, Hero''s Journey, etc.)';
COMMENT ON TABLE audience_profiles IS 'Target audience profiles with demographics, psychographics, and learning preferences';
COMMENT ON TABLE content_projects IS 'Content projects (courses, books, blog series) that group related contents';

-- ════════════════════════════════════════════════════════════════════════════════
-- END OF SCHEMA
-- ════════════════════════════════════════════════════════════════════════════════
