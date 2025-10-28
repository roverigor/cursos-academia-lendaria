BEGIN;


-- ═══════════════════════════════════════════════════════════════════
-- Course: claude-code
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
  VALUES ('claude-code', 'claude-code', '', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'claude-code-outline',
    'claude-code - Outline',
    'course_outline',
    true,
    '# claude-code

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

Estrutura base para qualquer script Python com error handling e logs',
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

Flask API com 4 endpoints prontos (GET, POST, PUT, DELETE)',
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

Documentação padrão para seus projetos (setup, uso, troubleshooting)',
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

4 passos para validar que ambiente está pronto (Claude Pro, VS Code, terminal, teste)',
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

Framework OBSERVE → SEARCH → ASK → ITERATE em formato checklist',
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

10 itens para validar antes de considerar projeto ''done'' (README, .env, error handling, etc)',
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

Erros mais frequentes + soluções passo-a-passo (syntax, deps, permissions, API)',
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

No-code automation para workflows híbridos',
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

Docs oficiais Claude AI (referência técnica)',
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

Livro clássico sobre automação Python (complementar)',
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
-- Course: didatica-lendaria
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
  VALUES ('didatica-lendaria', 'didatica-lendaria', '', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'didatica-lendaria-outline',
    'didatica-lendaria - Outline',
    'course_outline',
    true,
    '# didatica-lendaria

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

Template para preparar aula com 7 partes',
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

Template para aplicar Destino + Origem + Rota',
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

Validação completa de qualidade pré-gravação',
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

5 arquétipos da Academia Lendária',
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

Reframes para crenças limitantes comuns',
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

Antídotos para os 5 erros fatais',
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

Gravação rápida de vídeos',
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

Exercícios práticos de modulação com ChatGPT',
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
-- Course: Gestor de IA Generativa e fundador da Agência Lendária
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
  VALUES ('prompt-engineer', 'Gestor de IA Generativa e fundador da Agência Lendária', 'Precificar e vender agentes usando vocabulário técnico', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    'prompt-engineer-outline',
    'Gestor de IA Generativa e fundador da Agência Lendária - Outline',
    'course_outline',
    true,
    '# Gestor de IA Generativa e fundador da Agência Lendária

Precificar e vender agentes usando vocabulário técnico',
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
