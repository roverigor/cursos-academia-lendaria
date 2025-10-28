-- Complete missing data in content_projects
-- Fill target_audience, frameworks, and metadata
-- Generated: 2025-10-28

BEGIN;

-- ═══════════════════════════════════════════════════════════════════
-- Claude Code
-- ═══════════════════════════════════════════════════════════════════

UPDATE content_projects
SET
  target_audience_id = '9ce0ada9-8476-4b87-92d6-1f5b1f8ebf1d', -- Empreendedores Digitais Iniciantes
  default_frameworks = jsonb_build_array(
    '6e05b667-4417-434d-8158-fa1619fbd899'::uuid,  -- GPS
    '534f159a-9448-4337-9332-7f306171396e'::uuid   -- Bloom's Taxonomy
  ),
  project_metadata = jsonb_build_object(
    'knowledge_level', 'beginner',
    'course_type', 'technical',
    'estimated_hours', 2.5,
    'language', 'pt-BR',
    'tags', jsonb_build_array('ia', 'automacao', 'claude', 'no-code')
  )
WHERE slug = 'claude-code';

-- ═══════════════════════════════════════════════════════════════════
-- Didática Lendária
-- ═══════════════════════════════════════════════════════════════════

UPDATE content_projects
SET
  target_audience_id = '188812c6-6727-4eff-83b0-283a9d8566a3', -- Criadores de Conteúdo
  default_frameworks = jsonb_build_array(
    '1fb79923-a1b5-4770-8537-d75da1426cdd'::uuid,  -- DIDÁTICA LENDÁRIA
    '6e05b667-4417-434d-8158-fa1619fbd899'::uuid,  -- GPS
    '534f159a-9448-4337-9332-7f306171396e'::uuid   -- Bloom's Taxonomy
  ),
  project_metadata = jsonb_build_object(
    'knowledge_level', 'intermediate',
    'course_type', 'pedagogical',
    'estimated_hours', 5.33,
    'language', 'pt-BR',
    'tags', jsonb_build_array('didatica', 'pedagogia', 'ensino', 'frameworks')
  )
WHERE slug = 'didatica-lendaria';

-- ═══════════════════════════════════════════════════════════════════
-- Vibecoding
-- ═══════════════════════════════════════════════════════════════════

UPDATE content_projects
SET
  target_audience_id = '9ce0ada9-8476-4b87-92d6-1f5b1f8ebf1d', -- Empreendedores Digitais Iniciantes
  default_frameworks = jsonb_build_array(
    '6e05b667-4417-434d-8158-fa1619fbd899'::uuid   -- GPS
  ),
  project_metadata = jsonb_build_object(
    'knowledge_level', 'beginner',
    'course_type', 'technical',
    'estimated_hours', 3,
    'language', 'pt-BR',
    'tags', jsonb_build_array('no-code', 'ia', 'apps', 'vibecoding')
  )
WHERE slug = 'vibecoding';

-- ═══════════════════════════════════════════════════════════════════
-- Supabase do Zero
-- ═══════════════════════════════════════════════════════════════════

UPDATE content_projects
SET
  target_audience_id = '4fe950f7-5f56-4139-a4a9-227c0979129f', -- Desenvolvedores Full Stack
  default_frameworks = jsonb_build_array(
    '6e05b667-4417-434d-8158-fa1619fbd899'::uuid,  -- GPS
    '534f159a-9448-4337-9332-7f306171396e'::uuid   -- Bloom's Taxonomy
  ),
  project_metadata = jsonb_build_object(
    'knowledge_level', 'intermediate',
    'course_type', 'technical',
    'estimated_hours', 8,
    'language', 'pt-BR',
    'tags', jsonb_build_array('supabase', 'backend', 'postgresql', 'baas')
  )
WHERE slug = 'supabase-zero-backend-completo';

-- ═══════════════════════════════════════════════════════════════════
-- Meu Clone IA
-- ═══════════════════════════════════════════════════════════════════

UPDATE content_projects
SET
  target_audience_id = '188812c6-6727-4eff-83b0-283a9d8566a3', -- Criadores de Conteúdo
  default_frameworks = jsonb_build_array(
    '6e05b667-4417-434d-8158-fa1619fbd899'::uuid   -- GPS
  ),
  project_metadata = jsonb_build_object(
    'knowledge_level', 'intermediate',
    'course_type', 'technical',
    'estimated_hours', 6,
    'language', 'pt-BR',
    'tags', jsonb_build_array('ia', 'clone', 'mmos', 'conhecimento')
  )
WHERE slug = 'meu-clone-ia';

-- ═══════════════════════════════════════════════════════════════════
-- Prompt Engineering
-- ═══════════════════════════════════════════════════════════════════

UPDATE content_projects
SET
  target_audience_id = '4fe950f7-5f56-4139-a4a9-227c0979129f', -- Desenvolvedores Full Stack
  default_frameworks = jsonb_build_array(
    '6e05b667-4417-434d-8158-fa1619fbd899'::uuid,  -- GPS
    '534f159a-9448-4337-9332-7f306171396e'::uuid   -- Bloom's Taxonomy
  ),
  project_metadata = jsonb_build_object(
    'knowledge_level', 'advanced',
    'course_type', 'technical',
    'estimated_hours', 4,
    'language', 'pt-BR',
    'tags', jsonb_build_array('prompt-engineering', 'ia', 'agentes', 'llm')
  )
WHERE slug = 'prompt-engineer';

COMMIT;

-- ═══════════════════════════════════════════════════════════════════
-- Validation Query
-- ═══════════════════════════════════════════════════════════════════

SELECT
  cp.slug,
  cp.name,
  ap.name as audience,
  jsonb_array_length(cp.default_frameworks) as frameworks_count,
  cp.project_metadata->>'knowledge_level' as level,
  cp.project_metadata->>'course_type' as type,
  jsonb_array_length(cp.project_metadata->'tags') as tags_count
FROM content_projects cp
LEFT JOIN audience_profiles ap ON cp.target_audience_id = ap.id
WHERE cp.slug IN (
  'claude-code',
  'didatica-lendaria',
  'vibecoding',
  'supabase-zero-backend-completo',
  'meu-clone-ia',
  'prompt-engineer'
)
ORDER BY cp.slug;
