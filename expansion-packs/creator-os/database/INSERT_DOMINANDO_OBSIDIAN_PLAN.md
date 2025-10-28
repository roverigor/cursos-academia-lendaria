# 📚 Plano de Inserção: Curso "Dominando Obsidian" - Professor Adriano

> **Plano simples para o Haiku executar** - Passo a passo detalhado para inserir o curso no CreatorOS

---

## 🎯 Objetivo

Inserir o curso "Dominando Obsidian" do Professor Adriano Marqui no banco CreatorOS, incluindo:
- ✅ Verificar/criar mind do professor
- ✅ Criar projeto do curso
- ✅ Criar estrutura hierárquica (outline → módulos → lições)
- ✅ Aplicar frameworks pedagógicos
- ✅ Linkar professor como creator

---

## 📋 PASSO 1: Verificar se Professor Adriano existe na tabela `minds`

### Comando SQL:
```sql
-- Buscar professor Adriano
SELECT id, slug, display_name
FROM minds
WHERE display_name ILIKE '%adriano%'
   OR slug ILIKE '%adriano%';
```

### Resultados Possíveis:

**Caso A: Professor encontrado**
```
id: abc-123-def
slug: adriano_marqui
display_name: Adriano Marqui
```
→ **Ação:** Anotar o `id` (UUID) - vamos precisar dele!

**Caso B: Professor NÃO encontrado**
→ **Ação:** Precisa criar o mind primeiro (executar PASSO 1B)

---

## 📋 PASSO 1B: Criar mind do Professor Adriano (se não existir)

### Comando SQL:
```sql
-- Criar mind do Professor Adriano
INSERT INTO minds (slug, display_name, short_bio, primary_language, privacy_level)
VALUES (
  'adriano_marqui',
  'Adriano Marqui',
  'Professor especializado em gestão de conhecimento, PKM e Obsidian. Criador do método ATLAS.',
  'pt',
  'public'
) RETURNING id, slug, display_name;
```

### Resultado esperado:
```
id: abc-123-def  ← GUARDAR ESSE UUID!
slug: adriano_marqui
display_name: Adriano Marqui
```

---

## 📋 PASSO 2: Verificar se projeto "Dominando Obsidian" existe

### Comando SQL:
```sql
-- Buscar projeto
SELECT id, slug, name
FROM content_projects
WHERE slug = 'dominando-obsidian';
```

### Resultados Possíveis:

**Caso A: Projeto encontrado**
→ **Ação:** Anotar o `id` do projeto

**Caso B: Projeto NÃO encontrado**
→ **Ação:** Criar projeto (executar PASSO 2B)

---

## 📋 PASSO 2B: Criar projeto "Dominando Obsidian"

### Comando SQL:
```sql
-- Pegar audience_id correto
SELECT id FROM audience_profiles WHERE slug = 'empreendedores-digitais-iniciantes';
-- Resultado: audience_id = xyz-789

-- Criar projeto do curso
INSERT INTO content_projects (
  slug,
  name,
  description,
  project_type,
  status,
  target_audience_id,
  default_frameworks,
  project_metadata
)
VALUES (
  'dominando-obsidian',
  'Dominando Obsidian',
  'Curso completo sobre Obsidian: do básico ao avançado. Aprenda a criar seu segundo cérebro e dominar PKM (Personal Knowledge Management).',
  'course',
  'in_progress',
  (SELECT id FROM audience_profiles WHERE slug = 'empreendedores-digitais-iniciantes'),
  '["blooms_taxonomy", "didatica_lendaria", "gps"]'::jsonb,
  '{
    "metodologia": "ATLAS (Access, Train, Link, Apply, Share)",
    "duracao_estimada": "8 semanas",
    "nivel": "Básico a Avançado",
    "formato": "video + exercicios praticos"
  }'::jsonb
) RETURNING id, slug, name;
```

### Resultado esperado:
```
id: proj-456-ghi  ← GUARDAR ESSE UUID!
slug: dominando-obsidian
name: Dominando Obsidian
```

---

## 📋 PASSO 3: Criar Outline do Curso (raiz da hierarquia)

### Comando SQL:
```sql
-- SUBSTITUIR:
-- <PROFESSOR_UUID> = id do professor (PASSO 1)
-- <PROJECT_UUID> = id do projeto (PASSO 2)

INSERT INTO contents (
  slug,
  title,
  content_type,
  ai_generated,
  content,
  project_id,
  parent_content_id,
  sequence_order,
  status,
  metadata
)
VALUES (
  'dominando-obsidian-outline',
  'Dominando Obsidian - Outline Completo',
  'course_outline',
  true,  -- gerado por IA
  '# Dominando Obsidian - Curso Completo

## Visão Geral
Aprenda a dominar o Obsidian do zero e construa seu segundo cérebro digital usando o método ATLAS.

## Objetivos
- Configurar e personalizar Obsidian
- Dominar markdown e links bidirecionais
- Criar sistema PKM funcional
- Usar plugins essenciais
- Aplicar método ATLAS no dia a dia

## Estrutura
8 módulos + projeto final',
  '<PROJECT_UUID>',  -- SUBSTITUIR!
  NULL,  -- outline é raiz (sem parent)
  1,
  'published',
  '{
    "total_modules": 8,
    "total_lessons": 32,
    "estimated_hours": 16,
    "difficulty": "beginner_to_advanced"
  }'::jsonb
) RETURNING id, slug, title;
```

### Resultado esperado:
```
id: outline-789-jkl  ← GUARDAR ESSE UUID (é o parent dos módulos)!
slug: dominando-obsidian-outline
title: Dominando Obsidian - Outline Completo
```

---

## 📋 PASSO 4: Linkar Professor como Creator

### Comando SQL:
```sql
-- SUBSTITUIR:
-- <OUTLINE_UUID> = id do outline (PASSO 3)
-- <PROFESSOR_UUID> = id do professor (PASSO 1)

INSERT INTO content_minds (content_id, mind_id, role)
VALUES (
  '<OUTLINE_UUID>',  -- SUBSTITUIR!
  '<PROFESSOR_UUID>',  -- SUBSTITUIR!
  'creator'
);
```

### Resultado esperado:
```
INSERT 0 1
```

---

## 📋 PASSO 5: Criar Módulo 1 (exemplo)

### Comando SQL:
```sql
-- SUBSTITUIR:
-- <PROJECT_UUID> = id do projeto (PASSO 2)
-- <OUTLINE_UUID> = id do outline (PASSO 3)
-- <PROFESSOR_UUID> = id do professor (PASSO 1)

-- Criar módulo
INSERT INTO contents (
  slug,
  title,
  content_type,
  ai_generated,
  content,
  project_id,
  parent_content_id,
  sequence_order,
  status,
  metadata
)
VALUES (
  'modulo-1-introducao',
  'Módulo 1: Introdução ao Obsidian',
  'course_module',
  true,
  '# Módulo 1: Introdução ao Obsidian

## O que você vai aprender
- O que é Obsidian e por que usar
- Diferenças entre Obsidian e outras ferramentas
- Filosofia de PKM
- Primeiros passos

## Lições
1. O que é Obsidian
2. Instalação e configuração inicial
3. Interface e navegação
4. Criando sua primeira nota',
  '<PROJECT_UUID>',  -- SUBSTITUIR!
  '<OUTLINE_UUID>',  -- SUBSTITUIR! (parent é o outline)
  1,  -- primeiro módulo
  'published',
  '{
    "lessons_count": 4,
    "duration_minutes": 45,
    "learning_objectives": [
      "Entender o que é Obsidian",
      "Configurar o ambiente",
      "Navegar pela interface",
      "Criar notas básicas"
    ]
  }'::jsonb
) RETURNING id, slug, title;

-- Guardar o id retornado: modulo1_id = mno-012-pqr

-- Linkar professor ao módulo
INSERT INTO content_minds (content_id, mind_id, role)
VALUES (
  '<MODULO1_UUID>',  -- SUBSTITUIR com id retornado acima!
  '<PROFESSOR_UUID>',  -- SUBSTITUIR!
  'creator'
);
```

---

## 📋 PASSO 6: Criar Lição 1.1 (exemplo)

### Comando SQL:
```sql
-- SUBSTITUIR:
-- <PROJECT_UUID> = id do projeto
-- <MODULO1_UUID> = id do módulo 1 (PASSO 5)
-- <PROFESSOR_UUID> = id do professor

INSERT INTO contents (
  slug,
  title,
  content_type,
  ai_generated,
  content,
  project_id,
  parent_content_id,
  sequence_order,
  status,
  fidelity_score,
  metadata
)
VALUES (
  'licao-1-1-o-que-e-obsidian',
  'Lição 1.1: O que é Obsidian?',
  'course_lesson',
  true,
  '# Lição 1.1: O que é Obsidian?

## Gancho (GPS)
Imagine ter acesso instantâneo a tudo que você já aprendeu, pensou ou criou. Sem buscar em pastas, sem esquecer. Parece mágico? É o poder do Obsidian.

## Promessa
Nesta lição você vai entender:
- O que torna Obsidian único
- Por que ele é chamado de "segundo cérebro"
- Como ele difere de apps como Notion, Evernote, etc.

## Solução

### O que é Obsidian?
Obsidian é um aplicativo de notas que funciona como um **segundo cérebro digital**. Diferente de outros apps:

1. **Arquivos locais** - Suas notas são `.md` no seu computador
2. **Links bidirecionais** - Conecta ideias como seu cérebro
3. **Graph view** - Visualiza conexões entre notas
4. **Markdown puro** - Formato universal e eterno
5. **Extensível** - Plugins infinitos

### Por que usar?
- ✅ Você é dono dos dados (não dependência de cloud)
- ✅ Velocidade e privacidade
- ✅ Conexões emergem naturalmente
- ✅ Personalização total

### Obsidian vs Outros
| Recurso | Obsidian | Notion | Evernote |
|---------|----------|--------|----------|
| Arquivos locais | ✅ | ❌ | ❌ |
| Links bidirecionais | ✅ | ✅ | ❌ |
| Graph view | ✅ | ❌ | ❌ |
| Offline-first | ✅ | ❌ | ⚠️ |
| Markdown nativo | ✅ | ⚠️ | ❌ |

## Exercício Prático
1. Acesse obsidian.md
2. Explore a demo online
3. Observe o graph view
4. Tente criar uma nota e um link

## Próxima Lição
Na próxima aula você vai instalar e configurar seu Obsidian pela primeira vez.',
  '<PROJECT_UUID>',  -- SUBSTITUIR!
  '<MODULO1_UUID>',  -- SUBSTITUIR! (parent é o módulo 1)
  1,  -- primeira lição do módulo
  'published',
  0.95,  -- alta fidelidade ao estilo do professor
  '{
    "duration_minutes": 12,
    "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"],
    "bloom_level": 2,
    "readability_score": 0.88,
    "video_url": null,
    "exercises": true,
    "validation_scores": {
      "gps_validation": 0.98,
      "tone_match": 0.95,
      "didatica_lendaria": 0.92
    }
  }'::jsonb
) RETURNING id, slug, title;

-- Linkar professor
INSERT INTO content_minds (content_id, mind_id, role)
VALUES (
  '<LICAO_UUID>',  -- SUBSTITUIR com id retornado!
  '<PROFESSOR_UUID>',  -- SUBSTITUIR!
  'creator'
);
```

---

## 📋 PASSO 7: Validar Hierarquia Criada

### Comando SQL:
```sql
-- Ver hierarquia completa
SELECT
  slug,
  title,
  content_type,
  depth_level,
  sequence_order,
  path
FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline'
ORDER BY path;
```

### Resultado esperado:
```
slug                           | title                                    | content_type  | depth_level | sequence_order | path
-------------------------------+------------------------------------------+---------------+-------------+----------------+------
dominando-obsidian-outline     | Dominando Obsidian - Outline Completo    | course_outline|      0      |       1        | {1}
modulo-1-introducao            | Módulo 1: Introdução ao Obsidian         | course_module |      1      |       1        | {1,1}
licao-1-1-o-que-e-obsidian     | Lição 1.1: O que é Obsidian?             | course_lesson |      2      |       1        | {1,1,1}
```

✅ **Hierarquia correta!**

---

## 📋 PASSO 8: Ver Analytics do Projeto

### Comando SQL:
```sql
-- Ver performance do projeto
SELECT
  project_name,
  project_type,
  total_contents,
  published_contents,
  draft_contents,
  total_word_count,
  avg_fidelity_score,
  target_audience
FROM v_project_performance
WHERE project_slug = 'dominando-obsidian';
```

### Resultado esperado:
```
project_name        | project_type | total_contents | published_contents | avg_fidelity_score | target_audience
--------------------+--------------+----------------+--------------------+--------------------+------------------------------------
Dominando Obsidian  | course       |             3  |                 3  |              0.95  | Empreendedores Digitais Iniciantes
```

---

## 📋 PASSO 9: Ver Conteúdos do Professor Adriano

### Comando SQL:
```sql
-- Ver tudo que o professor criou
SELECT
  display_name,
  total_contents,
  generated_contents,
  contents_created,
  total_word_count,
  avg_fidelity_score
FROM v_mind_content_stats
WHERE display_name = 'Adriano Marqui';
```

---

## 🤖 Script Completo para Haiku Executar

```sql
-- ════════════════════════════════════════════════════════════════════════════════
-- SCRIPT COMPLETO: Inserir Curso "Dominando Obsidian"
-- ════════════════════════════════════════════════════════════════════════════════
-- Instruções: Substituir <PLACEHOLDERS> com UUIDs reais conforme execução

BEGIN;

-- ────────────────────────────────────────────────────────────────────────────────
-- STEP 1: Criar/Verificar Professor Adriano
-- ────────────────────────────────────────────────────────────────────────────────

DO $$
DECLARE
  v_professor_id UUID;
  v_audience_id UUID;
  v_project_id UUID;
  v_outline_id UUID;
  v_modulo1_id UUID;
  v_licao1_id UUID;
BEGIN
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Inserindo Curso: Dominando Obsidian';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';

  -- Verificar/criar professor
  SELECT id INTO v_professor_id FROM minds WHERE slug = 'adriano_marqui';

  IF v_professor_id IS NULL THEN
    RAISE NOTICE 'Criando mind: Professor Adriano...';
    INSERT INTO minds (slug, display_name, short_bio, primary_language, privacy_level)
    VALUES (
      'adriano_marqui',
      'Adriano Marqui',
      'Professor especializado em gestão de conhecimento, PKM e Obsidian. Criador do método ATLAS.',
      'pt',
      'public'
    ) RETURNING id INTO v_professor_id;
    RAISE NOTICE '✅ Professor criado: %', v_professor_id;
  ELSE
    RAISE NOTICE '✅ Professor já existe: %', v_professor_id;
  END IF;

  -- ────────────────────────────────────────────────────────────────────────────────
  -- STEP 2: Criar Projeto
  -- ────────────────────────────────────────────────────────────────────────────────

  SELECT id INTO v_audience_id FROM audience_profiles WHERE slug = 'empreendedores-digitais-iniciantes';

  RAISE NOTICE 'Criando projeto: Dominando Obsidian...';
  INSERT INTO content_projects (
    slug, name, description, project_type, status,
    target_audience_id, default_frameworks, project_metadata
  )
  VALUES (
    'dominando-obsidian',
    'Dominando Obsidian',
    'Curso completo sobre Obsidian: do básico ao avançado. Aprenda a criar seu segundo cérebro e dominar PKM.',
    'course',
    'in_progress',
    v_audience_id,
    '["blooms_taxonomy", "didatica_lendaria", "gps"]'::jsonb,
    '{"metodologia": "ATLAS", "duracao_estimada": "8 semanas", "nivel": "Básico a Avançado"}'::jsonb
  ) RETURNING id INTO v_project_id;
  RAISE NOTICE '✅ Projeto criado: %', v_project_id;

  -- ────────────────────────────────────────────────────────────────────────────────
  -- STEP 3: Criar Outline
  -- ────────────────────────────────────────────────────────────────────────────────

  RAISE NOTICE 'Criando outline do curso...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'dominando-obsidian-outline',
    'Dominando Obsidian - Outline Completo',
    'course_outline',
    true,
    '# Dominando Obsidian - Curso Completo

## Visão Geral
Aprenda a dominar o Obsidian do zero e construa seu segundo cérebro digital usando o método ATLAS.

## Objetivos
- Configurar e personalizar Obsidian
- Dominar markdown e links bidirecionais
- Criar sistema PKM funcional
- Usar plugins essenciais
- Aplicar método ATLAS no dia a dia

## Estrutura
8 módulos + projeto final',
    v_project_id,
    NULL,
    1,
    'published',
    '{"total_modules": 8, "total_lessons": 32, "estimated_hours": 16}'::jsonb
  ) RETURNING id INTO v_outline_id;
  RAISE NOTICE '✅ Outline criado: %', v_outline_id;

  -- Linkar professor ao outline
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_outline_id, v_professor_id, 'creator');
  RAISE NOTICE '✅ Professor linkado ao outline';

  -- ────────────────────────────────────────────────────────────────────────────────
  -- STEP 4: Criar Módulo 1
  -- ────────────────────────────────────────────────────────────────────────────────

  RAISE NOTICE 'Criando Módulo 1...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'modulo-1-introducao',
    'Módulo 1: Introdução ao Obsidian',
    'course_module',
    true,
    '# Módulo 1: Introdução ao Obsidian

## O que você vai aprender
- O que é Obsidian e por que usar
- Diferenças entre Obsidian e outras ferramentas
- Filosofia de PKM
- Primeiros passos',
    v_project_id,
    v_outline_id,
    1,
    'published',
    '{"lessons_count": 4, "duration_minutes": 45}'::jsonb
  ) RETURNING id INTO v_modulo1_id;
  RAISE NOTICE '✅ Módulo 1 criado: %', v_modulo1_id;

  -- Linkar professor ao módulo
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_modulo1_id, v_professor_id, 'creator');

  -- ────────────────────────────────────────────────────────────────────────────────
  -- STEP 5: Criar Lição 1.1
  -- ────────────────────────────────────────────────────────────────────────────────

  RAISE NOTICE 'Criando Lição 1.1...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-1-1-o-que-e-obsidian',
    'Lição 1.1: O que é Obsidian?',
    'course_lesson',
    true,
    '# Lição 1.1: O que é Obsidian?

## Gancho
Imagine ter acesso instantâneo a tudo que você já aprendeu. É o poder do Obsidian.

## O que é Obsidian?
Obsidian é um aplicativo de notas que funciona como um **segundo cérebro digital**.',
    v_project_id,
    v_modulo1_id,
    1,
    'published',
    0.95,
    '{"duration_minutes": 12, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2}'::jsonb
  ) RETURNING id INTO v_licao1_id;
  RAISE NOTICE '✅ Lição 1.1 criada: %', v_licao1_id;

  -- Linkar professor à lição
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao1_id, v_professor_id, 'creator');

  -- ────────────────────────────────────────────────────────────────────────────────
  -- VALIDAÇÃO FINAL
  -- ────────────────────────────────────────────────────────────────────────────────

  RAISE NOTICE '';
  RAISE NOTICE '✅ Curso "Dominando Obsidian" inserido com sucesso!';
  RAISE NOTICE '';
  RAISE NOTICE 'IDs criados:';
  RAISE NOTICE 'Professor: %', v_professor_id;
  RAISE NOTICE 'Projeto: %', v_project_id;
  RAISE NOTICE 'Outline: %', v_outline_id;
  RAISE NOTICE 'Módulo 1: %', v_modulo1_id;
  RAISE NOTICE 'Lição 1.1: %', v_licao1_id;

END $$;

COMMIT;

-- ════════════════════════════════════════════════════════════════════════════════
-- QUERIES DE VALIDAÇÃO
-- ════════════════════════════════════════════════════════════════════════════════

-- Ver hierarquia
SELECT slug, title, content_type, depth_level, sequence_order
FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline'
ORDER BY path;

-- Ver analytics do projeto
SELECT * FROM v_project_performance WHERE project_slug = 'dominando-obsidian';

-- Ver conteúdos do professor
SELECT * FROM v_mind_content_stats WHERE display_name = 'Adriano Marqui';
```

---

## ✅ Checklist de Validação

Após executar o script, verificar:

- [ ] Professor Adriano criado/encontrado
- [ ] Projeto "Dominando Obsidian" criado
- [ ] Outline criado (depth_level = 0)
- [ ] Módulo 1 criado (depth_level = 1, parent = outline)
- [ ] Lição 1.1 criada (depth_level = 2, parent = módulo1)
- [ ] Professor linkado como creator em todos (5 registros em content_minds)
- [ ] Hierarquia visível em v_content_hierarchy
- [ ] Analytics corretos em v_project_performance

---

## 🎯 Próximos Passos (para Haiku)

Depois de inserir o exemplo acima, pode:

1. **Adicionar mais lições ao Módulo 1** (lições 1.2, 1.3, 1.4)
2. **Criar Módulo 2** (com suas lições)
3. **Adicionar frameworks** via metadata
4. **Simular custos de geração** criando job_executions
5. **Testar multi-mind** criando entrevista com 2 professores

---

**Autor:** DB Sage
**Data:** 2025-10-28
**Versão:** 1.0
**Para:** Haiku (irmão mais burro, mas muito competente!)
