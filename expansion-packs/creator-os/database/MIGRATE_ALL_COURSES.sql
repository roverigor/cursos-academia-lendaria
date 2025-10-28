BEGIN;


-- ═══════════════════════════════════════════════════════════════════
-- Course: Claude Code Expert: Automação Inteligente para Founders sem Código
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_professor_id UUID;
  v_project_id UUID;
  v_outline_id UUID;
  v_module_id UUID;
  v_lesson_id UUID;
BEGIN

  -- Get or create professor
  SELECT id INTO v_professor_id FROM minds WHERE slug = 'jose-carlos-amorim';

  IF v_professor_id IS NULL THEN
    INSERT INTO minds (slug, display_name, short_bio)
    VALUES ('jose-carlos-amorim', 'José Carlos Amorim', 'Transição de jornalista/gerente para AI strategist. Especialista em traduzir complexidade técnica em insights viscerais via ESPIRAL EXPANSIVA. TDAH + TAG como vantagem competitiva na era da IA.')
    RETURNING id INTO v_professor_id;
  END IF;

  -- Create or update project
  INSERT INTO content_projects (slug, name, description, status)
  VALUES ('claude-code', 'Claude Code Expert: Automação Inteligente para Founders sem Código', '', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-outline',
    'Claude Code Expert: Automação Inteligente para Founders sem Código - Outline',
    'course_outline',
    true,
    '# Claude Code Expert: Automação Inteligente para Founders sem Código

',
    v_project_id,
    1,
    'published',
    '{"total_modules": 10}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_outline_id;

  -- Link professor
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_outline_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 1
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-1',
    'Template: Script de Automação Base',
    'course_module',
    true,
    '# Template: Script de Automação Base

',
    v_project_id,
    v_outline_id,
    1,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 2
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-2',
    'Template: API REST Simples',
    'course_module',
    true,
    '# Template: API REST Simples

',
    v_project_id,
    v_outline_id,
    2,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 3
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-3',
    'Template: README.md para Projetos',
    'course_module',
    true,
    '# Template: README.md para Projetos

',
    v_project_id,
    v_outline_id,
    3,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 4
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-4',
    'Checklist: Setup Completo',
    'course_module',
    true,
    '# Checklist: Setup Completo

',
    v_project_id,
    v_outline_id,
    4,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 5
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-5',
    'Checklist: Debugging Sistemático',
    'course_module',
    true,
    '# Checklist: Debugging Sistemático

',
    v_project_id,
    v_outline_id,
    5,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 6
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-6',
    'Checklist: Projeto Pronto para Produção',
    'course_module',
    true,
    '# Checklist: Projeto Pronto para Produção

',
    v_project_id,
    v_outline_id,
    6,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 7
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-7',
    'Troubleshooting Guide: 20+ Erros Comuns',
    'course_module',
    true,
    '# Troubleshooting Guide: 20+ Erros Comuns

',
    v_project_id,
    v_outline_id,
    7,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 8
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-8',
    'Security Guide: API Keys e Secrets',
    'course_module',
    true,
    '# Security Guide: API Keys e Secrets

',
    v_project_id,
    v_outline_id,
    8,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 9
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-9',
    'Anthropic Claude Documentation',
    'course_module',
    true,
    '# Anthropic Claude Documentation

',
    v_project_id,
    v_outline_id,
    9,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 10
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-modulo-10',
    'Automate the Boring Stuff with Python',
    'course_module',
    true,
    '# Automate the Boring Stuff with Python

',
    v_project_id,
    v_outline_id,
    10,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

END $$;


-- ═══════════════════════════════════════════════════════════════════
-- Course: Didática Lendária: Como Criar Aulas que Engajam e Empolgam
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_professor_id UUID;
  v_project_id UUID;
  v_outline_id UUID;
  v_module_id UUID;
  v_lesson_id UUID;
BEGIN

  -- Get or create professor
  SELECT id INTO v_professor_id FROM minds WHERE slug = 'adriano-de-marqui';

  IF v_professor_id IS NULL THEN
    INSERT INTO minds (slug, display_name, short_bio)
    VALUES ('adriano-de-marqui', 'Adriano de Marqui', 'Adriano de Marqui é empresário de tecnologia há 26 anos, professor na Academia Lendária e especialista em didática com 20+ anos de experiência. Criador dos frameworks GPS, Semiótica da Imagem e Estrutura de Aula Completa.')
    RETURNING id INTO v_professor_id;
  END IF;

  -- Create or update project
  INSERT INTO content_projects (slug, name, description, status)
  VALUES ('didatica-lendaria', 'Didática Lendária: Como Criar Aulas que Engajam e Empolgam', '', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-outline',
    'Didática Lendária: Como Criar Aulas que Engajam e Empolgam - Outline',
    'course_outline',
    true,
    '# Didática Lendária: Como Criar Aulas que Engajam e Empolgam

',
    v_project_id,
    1,
    'published',
    '{"total_modules": 8}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_outline_id;

  -- Link professor
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_outline_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 1
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-modulo-1',
    'Template: Estrutura de Aula Completa',
    'course_module',
    true,
    '# Template: Estrutura de Aula Completa

',
    v_project_id,
    v_outline_id,
    1,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 2
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-modulo-2',
    'Template: GPS Method',
    'course_module',
    true,
    '# Template: GPS Method

',
    v_project_id,
    v_outline_id,
    2,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 3
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-modulo-3',
    'Checklist da Aula Perfeita',
    'course_module',
    true,
    '# Checklist da Aula Perfeita

',
    v_project_id,
    v_outline_id,
    3,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 4
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-modulo-4',
    'Guia de Arquétipos',
    'course_module',
    true,
    '# Guia de Arquétipos

',
    v_project_id,
    v_outline_id,
    4,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 5
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-modulo-5',
    'Banco de Reframes',
    'course_module',
    true,
    '# Banco de Reframes

',
    v_project_id,
    v_outline_id,
    5,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 6
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-modulo-6',
    'Matriz de Antídotos',
    'course_module',
    true,
    '# Matriz de Antídotos

',
    v_project_id,
    v_outline_id,
    6,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 7
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-modulo-7',
    'Mapa Mental: Didática Lendária',
    'course_module',
    true,
    '# Mapa Mental: Didática Lendária

',
    v_project_id,
    v_outline_id,
    7,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;


  -- Module 8
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-modulo-8',
    'Exercícios ChatGPT',
    'course_module',
    true,
    '# Exercícios ChatGPT

',
    v_project_id,
    v_outline_id,
    8,
    'published',
    '{"lessons_count": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

END $$;


-- ═══════════════════════════════════════════════════════════════════
-- Course: Meu Clone IA - Ganhe Tempo ou Venda Expertise
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_professor_id UUID;
  v_project_id UUID;
  v_outline_id UUID;
  v_module_id UUID;
  v_lesson_id UUID;
BEGIN

  -- Get or create professor
  SELECT id INTO v_professor_id FROM minds WHERE slug = 'unknown';

  IF v_professor_id IS NULL THEN
    INSERT INTO minds (slug, display_name, short_bio)
    VALUES ('unknown', 'Unknown', '')
    RETURNING id INTO v_professor_id;
  END IF;

  -- Create or update project
  INSERT INTO content_projects (slug, name, description, status)
  VALUES ('meu-clone-ia', 'Meu Clone IA - Ganhe Tempo ou Venda Expertise', '', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'meu-clone-ia-outline',
    'Meu Clone IA - Ganhe Tempo ou Venda Expertise - Outline',
    'course_outline',
    true,
    '# Meu Clone IA - Ganhe Tempo ou Venda Expertise

',
    v_project_id,
    1,
    'published',
    '{"total_modules": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_outline_id;

  -- Link professor
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_outline_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

END $$;


-- ═══════════════════════════════════════════════════════════════════
-- Course: Prompt Engineering - Arquitetura de Agentes Executivos
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_professor_id UUID;
  v_project_id UUID;
  v_outline_id UUID;
  v_module_id UUID;
  v_lesson_id UUID;
BEGIN

  -- Get or create professor
  SELECT id INTO v_professor_id FROM minds WHERE slug = 'rafael';

  IF v_professor_id IS NULL THEN
    INSERT INTO minds (slug, display_name, short_bio)
    VALUES ('rafael', 'Rafael', '')
    RETURNING id INTO v_professor_id;
  END IF;

  -- Create or update project
  INSERT INTO content_projects (slug, name, description, status)
  VALUES ('prompt-engineer', 'Prompt Engineering - Arquitetura de Agentes Executivos', '', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'prompt-engineer-outline',
    'Prompt Engineering - Arquitetura de Agentes Executivos - Outline',
    'course_outline',
    true,
    '# Prompt Engineering - Arquitetura de Agentes Executivos

',
    v_project_id,
    1,
    'published',
    '{"total_modules": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_outline_id;

  -- Link professor
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_outline_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

END $$;


-- ═══════════════════════════════════════════════════════════════════
-- Course: Supabase do Zero: Backend Completo sem Escrever Backend
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_professor_id UUID;
  v_project_id UUID;
  v_outline_id UUID;
  v_module_id UUID;
  v_lesson_id UUID;
BEGIN

  -- Get or create professor
  SELECT id INTO v_professor_id FROM minds WHERE slug = 'unknown';

  IF v_professor_id IS NULL THEN
    INSERT INTO minds (slug, display_name, short_bio)
    VALUES ('unknown', 'Unknown', '')
    RETURNING id INTO v_professor_id;
  END IF;

  -- Create or update project
  INSERT INTO content_projects (slug, name, description, status)
  VALUES ('supabase-zero-backend-completo', 'Supabase do Zero: Backend Completo sem Escrever Backend', '', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'supabase-zero-backend-completo-outline',
    'Supabase do Zero: Backend Completo sem Escrever Backend - Outline',
    'course_outline',
    true,
    '# Supabase do Zero: Backend Completo sem Escrever Backend

',
    v_project_id,
    1,
    'published',
    '{"total_modules": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_outline_id;

  -- Link professor
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_outline_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

END $$;


-- ═══════════════════════════════════════════════════════════════════
-- Course: Vibecoding - Criação de Apps Sem Código com IA
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_professor_id UUID;
  v_project_id UUID;
  v_outline_id UUID;
  v_module_id UUID;
  v_lesson_id UUID;
BEGIN

  -- Get or create professor
  SELECT id INTO v_professor_id FROM minds WHERE slug = 'unknown';

  IF v_professor_id IS NULL THEN
    INSERT INTO minds (slug, display_name, short_bio)
    VALUES ('unknown', 'Unknown', '')
    RETURNING id INTO v_professor_id;
  END IF;

  -- Create or update project
  INSERT INTO content_projects (slug, name, description, status)
  VALUES ('vibecoding', 'Vibecoding - Criação de Apps Sem Código com IA', '', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'vibecoding-outline',
    'Vibecoding - Criação de Apps Sem Código com IA - Outline',
    'course_outline',
    true,
    '# Vibecoding - Criação de Apps Sem Código com IA

',
    v_project_id,
    1,
    'published',
    '{"total_modules": 0}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_outline_id;

  -- Link professor
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_outline_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

END $$;

COMMIT;
