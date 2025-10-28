-- ════════════════════════════════════════════════════════════════════════════════
-- CREATORÓS DATABASE SEEDS - Dados Iniciais
-- ════════════════════════════════════════════════════════════════════════════════
-- Frameworks, audience profiles e projetos exemplo
-- ════════════════════════════════════════════════════════════════════════════════

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT FRAMEWORKS - 8 Frameworks Essenciais
-- ────────────────────────────────────────────────────────────────────────────────

-- 1. GPS (Gancho, Promessa, Solução) - Framework de estrutura de conteúdo
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active)
VALUES (
  'gps',
  'GPS: Gancho, Promessa, Solução',
  'Framework de estrutura de conteúdo criado por Erico Rocha. Gancho captura atenção, Promessa gera expectativa, Solução entrega valor.',
  'content_structure',
  '{
    "sections": [
      {
        "name": "gancho",
        "title": "Gancho",
        "description": "Captura a atenção do leitor nos primeiros segundos",
        "techniques": ["curiosity_gap", "bold_statement", "story_hook", "question"],
        "validation": {
          "required": true,
          "min_words": 50,
          "max_words": 150
        }
      },
      {
        "name": "promessa",
        "title": "Promessa",
        "description": "Gera expectativa e mostra o que será entregue",
        "techniques": ["clear_benefit", "social_proof", "authority", "urgency"],
        "validation": {
          "required": true,
          "min_words": 100,
          "max_words": 300
        }
      },
      {
        "name": "solucao",
        "title": "Solução",
        "description": "Entrega valor, ensina, resolve o problema",
        "techniques": ["step_by_step", "examples", "stories", "frameworks"],
        "validation": {
          "required": true,
          "min_words": 500
        }
      }
    ]
  }'::jsonb,
  true
) ON CONFLICT (slug) DO NOTHING;

-- 2. Bloom's Taxonomy - Framework pedagógico
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active)
VALUES (
  'blooms_taxonomy',
  'Bloom''s Taxonomy',
  'Taxonomia de objetivos educacionais de Benjamin Bloom. Hierarquia de 6 níveis cognitivos: Remember, Understand, Apply, Analyze, Evaluate, Create.',
  'pedagogical',
  '{
    "levels": [
      {"level": 1, "name": "Remember", "verbs": ["define", "list", "recall", "recognize", "retrieve"]},
      {"level": 2, "name": "Understand", "verbs": ["classify", "describe", "explain", "interpret", "summarize"]},
      {"level": 3, "name": "Apply", "verbs": ["execute", "implement", "solve", "use", "demonstrate"]},
      {"level": 4, "name": "Analyze", "verbs": ["compare", "organize", "deconstruct", "differentiate", "distinguish"]},
      {"level": 5, "name": "Evaluate", "verbs": ["check", "critique", "judge", "test", "assess"]},
      {"level": 6, "name": "Create", "verbs": ["design", "construct", "produce", "plan", "generate"]}
    ],
    "application": "Use different levels for different audience maturity. Beginners need more Remember/Understand, experts need Analyze/Evaluate/Create."
  }'::jsonb,
  true
) ON CONFLICT (slug) DO NOTHING;

-- 3. DIDÁTICA LENDÁRIA - Framework pedagógico proprietário
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active)
VALUES (
  'didatica_lendaria',
  'DIDÁTICA LENDÁRIA',
  'Framework pedagógico proprietário que combina storytelling, aprendizagem ativa e estruturação progressiva.',
  'pedagogical',
  '{
    "principles": [
      {"name": "contextualizacao", "description": "Criar contexto relevante antes de ensinar"},
      {"name": "historia", "description": "Usar storytelling para engajar e memorizar"},
      {"name": "pratica_imediata", "description": "Aplicar imediatamente o que foi ensinado"},
      {"name": "progressao_logica", "description": "Construir conhecimento em camadas"},
      {"name": "conexao_emocional", "description": "Criar conexão emocional com o conteúdo"}
    ],
    "structure": {
      "abertura": "História ou gancho emocional",
      "contexto": "Por que isso importa?",
      "ensino": "Conceito principal com exemplos",
      "pratica": "Exercício ou atividade",
      "fechamento": "Recap e próximos passos"
    }
  }'::jsonb,
  true
) ON CONFLICT (slug) DO NOTHING;

-- 4. Hero's Journey - Framework de storytelling
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active)
VALUES (
  'heros_journey',
  'Hero''s Journey (Jornada do Herói)',
  'Framework de storytelling de Joseph Campbell. Estrutura narrativa em 12 etapas usada em filmes, livros e conteúdo.',
  'storytelling',
  '{
    "acts": [
      {
        "act": 1,
        "name": "Departure",
        "stages": [
          {"stage": 1, "name": "Ordinary World", "description": "Vida normal do herói"},
          {"stage": 2, "name": "Call to Adventure", "description": "Desafio ou oportunidade aparece"},
          {"stage": 3, "name": "Refusal of Call", "description": "Herói hesita ou recusa"},
          {"stage": 4, "name": "Meeting Mentor", "description": "Encontra guia ou mentor"},
          {"stage": 5, "name": "Crossing Threshold", "description": "Aceita o desafio"}
        ]
      },
      {
        "act": 2,
        "name": "Initiation",
        "stages": [
          {"stage": 6, "name": "Tests, Allies, Enemies", "description": "Enfrenta desafios"},
          {"stage": 7, "name": "Approach to Inmost Cave", "description": "Se prepara para maior desafio"},
          {"stage": 8, "name": "Ordeal", "description": "Momento de maior tensão"},
          {"stage": 9, "name": "Reward", "description": "Conquista ou aprendizado"}
        ]
      },
      {
        "act": 3,
        "name": "Return",
        "stages": [
          {"stage": 10, "name": "Road Back", "description": "Retorna transformado"},
          {"stage": 11, "name": "Resurrection", "description": "Provação final"},
          {"stage": 12, "name": "Return with Elixir", "description": "Compartilha aprendizado"}
        ]
      }
    ]
  }'::jsonb,
  true
) ON CONFLICT (slug) DO NOTHING;

-- 5. Story Circle (Dan Harmon) - Framework de storytelling simplificado
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active)
VALUES (
  'story_circle',
  'Story Circle (Dan Harmon)',
  'Framework de storytelling simplificado de Dan Harmon. Ciclo em 8 etapas para criar histórias envolventes.',
  'storytelling',
  '{
    "steps": [
      {"step": 1, "name": "You (Comfort Zone)", "description": "Protagonista em zona de conforto"},
      {"step": 2, "name": "Need", "description": "Surge necessidade ou desejo"},
      {"step": 3, "name": "Go", "description": "Entra em território desconhecido"},
      {"step": 4, "name": "Search", "description": "Busca solução ou objetivo"},
      {"step": 5, "name": "Find", "description": "Encontra o que procurava"},
      {"step": 6, "name": "Take", "description": "Paga o preço para conseguir"},
      {"step": 7, "name": "Return", "description": "Volta transformado"},
      {"step": 8, "name": "Change", "description": "Mudança permanente"}
    ],
    "application": "Use for case studies, testimonials, lesson narratives"
  }'::jsonb,
  true
) ON CONFLICT (slug) DO NOTHING;

-- 6. AIDA - Framework de marketing
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active)
VALUES (
  'aida',
  'AIDA (Attention, Interest, Desire, Action)',
  'Framework clássico de marketing e copywriting. Guia o leitor através de 4 estágios até a ação.',
  'marketing',
  '{
    "stages": [
      {
        "stage": "A",
        "name": "Attention",
        "description": "Captura atenção com headline, imagem ou gancho",
        "techniques": ["curiosity", "bold_claim", "visual_impact", "question"]
      },
      {
        "stage": "I",
        "name": "Interest",
        "description": "Mantém interesse com relevância e benefícios",
        "techniques": ["relatable_problem", "stats", "story", "authority"]
      },
      {
        "stage": "D",
        "name": "Desire",
        "description": "Cria desejo com transformação e prova social",
        "techniques": ["before_after", "testimonials", "scarcity", "bonuses"]
      },
      {
        "stage": "A",
        "name": "Action",
        "description": "Leva à ação com CTA claro e urgência",
        "techniques": ["clear_cta", "urgency", "guarantee", "easy_next_step"]
      }
    ]
  }'::jsonb,
  true
) ON CONFLICT (slug) DO NOTHING;

-- 7. PAS (Problem, Agitate, Solve) - Framework de copywriting
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active)
VALUES (
  'pas',
  'PAS (Problem, Agitate, Solve)',
  'Framework de copywriting focado em dor e solução. Identifica problema, amplifica dor, apresenta solução.',
  'marketing',
  '{
    "stages": [
      {
        "stage": "P",
        "name": "Problem",
        "description": "Identifica problema específico do público",
        "techniques": ["specific_pain_point", "relatable_scenario", "stats"]
      },
      {
        "stage": "A",
        "name": "Agitate",
        "description": "Amplifica dor e consequências de não resolver",
        "techniques": ["emotional_impact", "worst_case_scenario", "opportunity_cost", "social_proof_of_problem"]
      },
      {
        "stage": "S",
        "name": "Solve",
        "description": "Apresenta solução e benefícios",
        "techniques": ["clear_solution", "transformation", "proof", "cta"]
      }
    ]
  }'::jsonb,
  true
) ON CONFLICT (slug) DO NOTHING;

-- 8. SEO Content Structure - Framework de estrutura de conteúdo para SEO
INSERT INTO content_frameworks (slug, name, description, framework_type, framework_schema, is_active)
VALUES (
  'seo_content_structure',
  'SEO Content Structure',
  'Framework de estruturação de conteúdo otimizado para SEO. Hierarquia de headings, densidade de palavras-chave, legibilidade.',
  'content_structure',
  '{
    "structure": {
      "h1": {"count": 1, "keyword": "primary", "description": "Título principal com keyword primária"},
      "h2": {"count": "3-7", "keyword": "secondary", "description": "Subtítulos com keywords secundárias"},
      "h3": {"count": "variable", "keyword": "long_tail", "description": "Sub-subtítulos com long-tail keywords"},
      "intro": {"words": "50-150", "description": "Introdução com keyword nos primeiros 100 palavras"},
      "body": {"words": "1500-3000", "description": "Conteúdo principal com densidade de keyword 0.5-2.5%"},
      "conclusion": {"words": "100-200", "description": "Conclusão com CTA"}
    },
    "best_practices": [
      "Use keyword in first 100 words",
      "Keep paragraphs under 150 words",
      "Use lists and bullet points",
      "Add images with alt text",
      "Internal and external links",
      "Meta description 150-160 chars"
    ],
    "readability": {
      "sentence_length": "Under 20 words average",
      "paragraph_length": "Under 150 words",
      "transition_words": "At least 30% of sentences",
      "flesch_reading_ease": "60-70 (Plain English)"
    }
  }'::jsonb,
  true
) ON CONFLICT (slug) DO NOTHING;

-- ────────────────────────────────────────────────────────────────────────────────
-- AUDIENCE PROFILES - Perfis exemplo
-- ────────────────────────────────────────────────────────────────────────────────

INSERT INTO audience_profiles (slug, name, description, demographics, psychographics, technical_level, learning_preferences)
VALUES (
  'empreendedores-digitais-iniciantes',
  'Empreendedores Digitais Iniciantes',
  'Empreendedores no início da jornada, buscando criar negócio online.',
  '{
    "age_range": "25-45",
    "location": "Brasil (maioria urbana)",
    "education": "Superior completo ou cursando",
    "occupation": "Profissionais liberais, funcionários querendo empreender"
  }'::jsonb,
  '{
    "interests": ["negócios online", "marketing digital", "infoprodutos", "liberdade financeira"],
    "values": ["autonomia", "impacto", "crescimento pessoal", "liberdade geográfica"],
    "pain_points": ["não sabe por onde começar", "falta de tempo", "medo de investir", "complexidade técnica"],
    "goals": ["criar primeiro produto digital", "ter renda extra", "substituir emprego", "ser referência"]
  }'::jsonb,
  'beginner',
  '{
    "primary": "visual",
    "secondary": "kinesthetic",
    "preferences": ["vídeos curtos", "passo a passo", "exemplos práticos", "comunidade"]
  }'::jsonb
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO audience_profiles (slug, name, description, demographics, psychographics, technical_level, learning_preferences)
VALUES (
  'desenvolvedores-fullstack',
  'Desenvolvedores Full Stack',
  'Desenvolvedores experientes buscando se aprofundar em arquitetura e liderança técnica.',
  '{
    "age_range": "25-40",
    "location": "Global (Brasil, EUA, Europa)",
    "education": "Superior em TI ou autodidata",
    "occupation": "Desenvolvedores mid-senior, tech leads"
  }'::jsonb,
  '{
    "interests": ["arquitetura de software", "DevOps", "performance", "escalabilidade", "carreira tech"],
    "values": ["excelência técnica", "aprendizado contínuo", "código limpo", "eficiência"],
    "pain_points": ["código legado", "débito técnico", "falta de docs", "crescimento de carreira"],
    "goals": ["virar tech lead", "arquitetar sistemas complexos", "aumentar salário", "trabalhar remote"]
  }'::jsonb,
  'advanced',
  '{
    "primary": "reading_writing",
    "secondary": "kinesthetic",
    "preferences": ["documentação técnica", "hands-on labs", "code examples", "deep dives"]
  }'::jsonb
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO audience_profiles (slug, name, description, demographics, psychographics, technical_level, learning_preferences)
VALUES (
  'criadores-de-conteudo',
  'Criadores de Conteúdo',
  'Creators buscando sistematizar criação e escalar audiência.',
  '{
    "age_range": "20-35",
    "location": "Global",
    "education": "Variado",
    "occupation": "YouTubers, influencers, course creators, writers"
  }'::jsonb,
  '{
    "interests": ["storytelling", "engagement", "monetização", "crescimento de audiência", "produtividade"],
    "values": ["autenticidade", "impacto", "criatividade", "consistência"],
    "pain_points": ["bloqueio criativo", "falta de tempo", "algoritmos", "monetização", "burnout"],
    "goals": ["aumentar views/subscribers", "monetizar melhor", "criar mais rápido", "manter qualidade"]
  }'::jsonb,
  'intermediate',
  '{
    "primary": "visual",
    "secondary": "auditory",
    "preferences": ["vídeos", "templates", "frameworks", "case studies", "swipe files"]
  }'::jsonb
) ON CONFLICT (slug) DO NOTHING;

-- ────────────────────────────────────────────────────────────────────────────────
-- CONTENT PROJECTS - Projetos exemplo
-- ────────────────────────────────────────────────────────────────────────────────

INSERT INTO content_projects (slug, name, description, project_type, status, target_audience_id, default_frameworks, project_metadata)
VALUES (
  'academia-lendaria',
  'Academia Lendária',
  'Plataforma de cursos premium sobre empreendedorismo digital, marketing e vendas.',
  'course',
  'in_progress',
  (SELECT id FROM audience_profiles WHERE slug = 'empreendedores-digitais-iniciantes'),
  '["gps", "didatica_lendaria", "aida"]'::jsonb,
  '{
    "brand": "Academia Lendária",
    "tone": "inspirador, prático, acessível",
    "avg_lesson_length": "15-25 minutos",
    "format": "vídeo + texto + exercícios"
  }'::jsonb
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO content_projects (slug, name, description, project_type, status, target_audience_id, default_frameworks, project_metadata)
VALUES (
  'blog-tech-insights',
  'Tech Insights Blog',
  'Blog técnico com deep dives em arquitetura de software, DevOps e best practices.',
  'blog_series',
  'in_progress',
  (SELECT id FROM audience_profiles WHERE slug = 'desenvolvedores-fullstack'),
  '["seo_content_structure", "blooms_taxonomy"]'::jsonb,
  '{
    "publishing_frequency": "2x por semana",
    "avg_article_length": "2000-3000 palavras",
    "format": "long-form + code examples",
    "seo_focus": true
  }'::jsonb
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO content_projects (slug, name, description, project_type, status, target_audience_id, default_frameworks, project_metadata)
VALUES (
  'criatividade-sem-limites',
  'Criatividade Sem Limites',
  'Série de vídeos e newsletters sobre criação de conteúdo, storytelling e produtividade criativa.',
  'video_series',
  'planning',
  (SELECT id FROM audience_profiles WHERE slug = 'criadores-de-conteudo'),
  '["story_circle", "heros_journey", "gps"]'::jsonb,
  '{
    "platforms": ["YouTube", "Newsletter"],
    "video_length": "8-12 minutos",
    "newsletter_frequency": "semanal",
    "storytelling_heavy": true
  }'::jsonb
) ON CONFLICT (slug) DO NOTHING;

-- ════════════════════════════════════════════════════════════════════════════════
-- VALIDATION QUERIES
-- ════════════════════════════════════════════════════════════════════════════════

-- Verificar frameworks
-- SELECT slug, name, framework_type, is_active FROM content_frameworks ORDER BY framework_type, slug;

-- Verificar audience profiles
-- SELECT slug, name, technical_level FROM audience_profiles;

-- Verificar projetos
-- SELECT p.slug, p.name, p.project_type, p.status, a.name as audience
-- FROM content_projects p
-- JOIN audience_profiles a ON a.id = p.target_audience_id;

-- ════════════════════════════════════════════════════════════════════════════════
-- END OF SEEDS
-- ════════════════════════════════════════════════════════════════════════════════
