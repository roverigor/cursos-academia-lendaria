-- ════════════════════════════════════════════════════════════════════════════════
-- FASE 2: Expandir Curso "Dominando Obsidian" - Módulos 4 até 8 (18 lições)
-- ════════════════════════════════════════════════════════════════════════════════
-- Objetivo: Adicionar 18 lições nos módulos 4-8 do curso
-- Notas: Usa UUIDs do Outline e Professor já existentes

BEGIN;

DO $$
DECLARE
  v_professor_id UUID := '4fd9fb2c-a0ed-436d-9500-47692cd53792';
  v_project_id UUID := '2518103d-93af-4d0a-874b-9b164974fb0e';
  v_outline_id UUID := 'c7299a8c-6e98-4a1a-b79f-792df1cbeb1f';
  v_modulo4_id UUID;
  v_modulo5_id UUID;
  v_modulo6_id UUID;
  v_modulo7_id UUID;
  v_modulo8_id UUID;
  v_licao_id UUID;
BEGIN

  -- ════════════════════════════════════════════════════════════════════════════════
  -- MÓDULO 4: Notas e Markdown
  -- ════════════════════════════════════════════════════════════════════════════════


  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'modulo-4-notas-markdown',
    'Módulo 4: Notas e Markdown',
    'course_module',
    true,
    '# Módulo 4: Notas e Markdown

## O que você vai aprender
- Conceito de nota e arquitetura
- Markdown essencial
- Formatação avançada
- Melhores práticas de escrita

## Lições
1. Conceito de nota e como são arquivos
2. Potencializando com Markdown
3. Markdown Parte 2
4. Formatação por atalhos

## Objetivo
Dominar a criação de notas estruturadas com Markdown puro.',
    v_project_id,
    v_outline_id,
    4,
    'published',
    '{"lessons_count": 4, "duration_minutes": 55, "difficulty": "intermediate"}'::jsonb
  ) RETURNING id INTO v_modulo4_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_modulo4_id, v_professor_id, 'creator');

  -- Lição 4.1
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-4-1-conceito-nota',
    'Lição 4.1: Conceito de Nota e Como São Arquivos',
    'course_lesson',
    true,
    '# Lição 4.1: Conceito de Nota e Como São Arquivos

## Gancho
Antes de começar a criar, precisa entender a unidade fundamental: A NOTA.

## Promessa
Nesta lição você vai aprender:
- O que é uma nota de verdade
- Como Obsidian armazena notas
- Arquitetura interna
- Formatos e compatibilidade

## Solução

### A Nota é a Unidade Básica

Uma **nota** é:
- Um arquivo `.md` (texto puro)
- Unidade mínima do seu segundo cérebro
- Contém uma ideia, conceito ou informação
- Conectável com outras notas

**Não é apenas criar notas.**
Você precisa de metodologia para criar NOTAS INTELIGENTES.

### Como Obsidian Armazena Notas

```
seu-vault/
├── notas/
│   ├── nota1.md          ← Arquivo 1
│   ├── nota2.md          ← Arquivo 2
│   └── pasta/
│       └── nota3.md      ← Arquivo 3
```

Cada arquivo `.md` = 1 nota
Simples assim!

### O Poder do Markdown

Markdown é:
- ✅ Texto puro (legível em qualquer lugar)
- ✅ Portável (não depende de Obsidian)
- ✅ Versionável (Git-friendly)
- ✅ Extensível (suporta custom syntax)

### Tipos de Notas (Conceitual)

**Nota Atômica:**
- Uma ideia
- 1-3 parágrafos
- Autossuficiente
- Conectável

**Nota de Referência:**
- Informação estruturada
- Índices, listas
- Sem opinião

**Nota de Processo:**
- Brainstorm
- Rascunho
- Evolui com tempo

**Mapa de Conteúdo (MOC):**
- Conecta outras notas
- Índice temático
- Visão geral

### Metodologia: Não é Só Criar

Aqui na Academia Lendária, estudamos:
- Zettelkasten (conectar ideias)
- Mente Lendária (nossa metodologia)
- PARA (Processing, Actionable, Reference, Archive)
- ATLAS (Access, Train, Link, Apply, Share)

Você vai aprender aplicar tudo isso em Obsidian.

### Primeira Prática

1. Crie uma nota: "Obsidian - Primeiras Impressões"
2. Escreva 3 parágrafos
3. Salve como `obsidian-primeiras-impressoes.md`
4. Veja onde é salvo no seu vault

## Exercício Prático
1. Crie 5 notas simples
2. Nomeie com kebab-case
3. Escreva 1-3 parágrafos em cada
4. Explore a pasta no Finder/File Explorer

## Próxima Lição
Próxima: Markdown Essencial - Potencialize sua escrita',
    v_project_id,
    v_modulo4_id,
    1,
    'published',
    0.91,
    '{"duration_minutes": 13, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "16_conceito_de_nota_e_como_sao_os_arquivos-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 4.2
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-4-2-markdown-essencial',
    'Lição 4.2: Potencializando com Markdown',
    'course_lesson',
    true,
    '# Lição 4.2: Potencializando a Escrita com Markdown

## Gancho
Markdown é a LINGUAGEM do segundo cérebro. Aprender Markdown é aprender a linguagem da IA moderna.

## Promessa
Nesta lição você vai aprender:
- Sintaxe Markdown essencial
- Como escrever estruturado
- Compatibilidade universal
- Por que Markdown importa para IA

## Solução

### Por Que Markdown?

Markdown é baseado em 20 anos de experiência em escrita estruturada.

**Benefícios:**
- ✅ Simples (apenas símbolos simples)
- ✅ Legível (funciona em texto puro)
- ✅ Universal (qualquer editor suporta)
- ✅ Base para IA (ChatGPT, Claude usam Markdown)

### Sintaxe Essencial

**Títulos:**
```
# Título H1
## Título H2
### Título H3
```

**Formatação:**
```
**negrito**
*itálico*
~~tachado~~
`código inline`
```

**Listas:**
```
- Item 1
- Item 2
  - Subitem

1. Primeiro
2. Segundo
3. Terceiro
```

**Links e Imagens:**
```
[Texto do link](https://exemplo.com)
![Alt text](caminho/imagem.png)
```

**Blockquotes:**
```
> Citação importante
> Continua aqui
```

**Código:**
` `` `
def hello():
    print("Olá")
` `` `

### Estrutura Recomendada para Notas

```markdown
# Título Principal

## Context
Por que esta nota importa?

## Conceito
O que é?

## Exemplos
Casos práticos

## Conexões
Links com outras notas [[nota1]] [[nota2]]

## Próximos Passos
Ações necessárias
```

### Markdown + Obsidian

Obsidian suporta:
- ✅ Markdown padrão
- ✅ Wiki-style links: `[[nota]]`
- ✅ Referências bidirecionais
- ✅ Transclusion: `![[nota]]`
- ✅ Custom attributes

### Exercício Prático

1. Crie nota: "Markdown Cheatsheet"
2. Copie a estrutura acima
3. Preencha com exemplos
4. Teste cada sintaxe
5. Salve e abra novamente para ver renderizado

## Próxima Lição
Próxima: Markdown Parte 2 (recursos avançados)',
    v_project_id,
    v_modulo4_id,
    2,
    'published',
    0.92,
    '{"duration_minutes": 15, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 2, "source_file": "21_potencializando_a_escrita_com_markdown_porque_voce_precisa_dele-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 4.3
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-4-3-markdown-parte2',
    'Lição 4.3: Markdown Parte 2 - Recursos Avançados',
    'course_lesson',
    true,
    '# Lição 4.3: Markdown Parte 2 - Recursos Avançados

## Gancho
Agora que você domina o básico, vamos aos recursos que fazem diferença: tabelas, listas complexas e sintaxe avançada.

## Promessa
Nesta lição você vai aprender:
- Tabelas estruturadas
- Listas aninhadas complexas
- HTML inline
- Sintaxe estendida

## Solução

### Tabelas em Markdown

```markdown
| Coluna 1 | Coluna 2 | Coluna 3 |
|----------|----------|----------|
| Valor 1  | Valor 2  | Valor 3  |
| A        | B        | C        |
```

**Alinhamento:**
```markdown
| Left   | Center | Right |
|:-------|:------:|------:|
| L      |   C    |     R |
```

### Listas Aninhadas

```markdown
1. Nível 1
   1. Nível 2
      1. Nível 3
   2. Outro nível 2
2. Volta nível 1

- Bullet 1
  - Sub-bullet
    - Sub-sub-bullet
  - Outro sub
- Bullet 2
```

### HTML Inline (Quando Necessário)

```markdown
<div class="alert">Conteúdo HTML</div>

Parágrafo normal

<!-- Comentário HTML -->
```

### Footnotes

```markdown
This is a footnote[^1].

[^1]: Explicação aqui
```

### Escaping

```markdown
\# Não é título
\*Não é itálico\*
\[Não é link\]
```

### Obsidian-Specific Syntax

**Wiki-style links:**
```markdown
[[Outra nota]]
[[Nota|Texto customizado]]
```

**Transclusion (embed):**
```markdown
![[Outra nota]]
![[Outra nota#Seção]]
```

**Callouts:**
```markdown
> [!NOTE] Isso é uma nota
> Conteúdo aqui

> [!WARNING] Cuidado!
> Aviso importante

> [!TIP] Dica útil
> Conteúdo
```

### Melhores Práticas

1. **Consistência:** Use o mesmo estilo sempre
2. **Simplicidade:** Markdown simples é melhor
3. **Estrutura:** Use títulos para organizar
4. **Links:** Conecte notas relacionadas
5. **Comentários:** Use HTML para notas internas

### Ferramenta: Markdown Preview

- Obsidian mostra preview em tempo real
- Atalho: Cmd+Shift+P > "Toggle preview"
- Edit mode vs Preview mode

## Exercício Prático
1. Crie nota com 3 tabelas
2. Teste lista aninhada de 4 níveis
3. Experimente callouts
4. Faça embed de outra nota
5. Valide tudo funciona

## Próxima Lição
Próxima: Formatação por Atalhos (escrever rápido)',
    v_project_id,
    v_modulo4_id,
    3,
    'published',
    0.90,
    '{"duration_minutes": 14, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "22_markdown_parte_2-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 4.4
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-4-4-formatacao-atalhos',
    'Lição 4.4: Formatação por Atalhos',
    'course_lesson',
    true,
    '# Lição 4.4: Formatação por Atalhos

## Gancho
Você sabe Markdown, mas digitar `**` toda vez é lento. Vamos configurar atalhos para escrever rápido.

## Promessa
Nesta lição você vai aprender:
- Atalhos de formatação
- Configuração customizada
- Ganho de velocidade
- Fluxo de trabalho otimizado

## Solução

### Atalhos Nativos de Markdown

| Ação | Mac | Windows |
|------|-----|---------|
| **Negrito** | Cmd+B | Ctrl+B |
| *Itálico* | Cmd+I | Ctrl+I |
| Código | Cmd+` | Ctrl+` |

### Atalhos do Obsidian

**Dentro de Settings → Hotkeys:**

| Ação | Hotkey |
|------|--------|
| Toggle bold | Cmd+B |
| Toggle italic | Cmd+I |
| Toggle code | Cmd+` |
| Insert link | Cmd+K |
| Focus on daily note | Cmd+D |
| Search | Cmd+F |

### Customizar Atalhos Próprios

1. Settings → Hotkeys
2. Procure pela ação
3. Clique e defina seu atalho
4. Evite conflitos com SO

**Exemplos úteis:**
- Cmd+L para inserir wiki link
- Cmd+'' para blockquote
- Cmd+[ para lista com bullet

### Snippets para Velocidade

Use plugins como **Templater** ou **Quick Capture**:

```
Digita: !note
Expande para:
# Título
## Context
## Conceito
## Exemplos
## Conexões
```

### Fluxo Otimizado

1. **Capturar:** Quick note (2 segundos)
2. **Processar:** Templates (estrutura automática)
3. **Conectar:** Links rápidos (Cmd+K)
4. **Revisar:** Backlinks panel

**Resultado:** Escrever notas inteligentes em minutos, não horas.

### Treino de Velocidade

Prática recomendada:
- Dia 1: Aprenda 3 atalhos
- Dia 2: Use sem pensar
- Dia 3: Adicione 3 mais
- Semana 2: 10+ atalhos fluídos

## Exercício Prático
1. Configure 5 atalhos que mais usa
2. Pratique com 10 notas rápidas
3. Teste velocidade antes/depois
4. Customize hotkeys preferidos

## Próxima Lição
Próxima: Módulo 5 - Links Bidirecionais',
    v_project_id,
    v_modulo4_id,
    4,
    'published',
    0.89,
    '{"duration_minutes": 13, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "23_formatacao_por_atalhos-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');


  -- ════════════════════════════════════════════════════════════════════════════════
  -- MÓDULO 5: Links Bidirecionais
  -- ════════════════════════════════════════════════════════════════════════════════


  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'modulo-5-links-bidirecionais',
    'Módulo 5: Links Bidirecionais e Organização',
    'course_module',
    true,
    '# Módulo 5: Links Bidirecionais e Organização

## O que você vai aprender
- Links internos entre notas
- Tags e taxonomia
- Pastas e estrutura
- Graph view e visualização

## Lições
1. Links internos entre notas
2. Tags e sistema de tags
3. Pastas e organização
4. O gráfico do segundo cérebro

## Objetivo
Conectar notas criando um segundo cérebro que emerge naturalmente.',
    v_project_id,
    v_outline_id,
    5,
    'published',
    '{"lessons_count": 4, "duration_minutes": 58, "difficulty": "intermediate"}'::jsonb
  ) RETURNING id INTO v_modulo5_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_modulo5_id, v_professor_id, 'creator');

  -- Lição 5.1
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-5-1-links-internos',
    'Lição 5.1: Links Internos Entre Notas',
    'course_lesson',
    true,
    '# Lição 5.1: Links Internos Entre Notas

## Gancho
Uma nota isolada é apenas informação. NOTAS CONECTADAS são conhecimento emergente. Vamos aprender a conectar.

## Promessa
Nesta lição você vai aprender:
- Criar links wiki-style
- Tipos de links (forward e backlinks)
- Visualização de conexões
- Alias e customização

## Solução

### Wiki-Style Links

**Sintaxe básica:**
```markdown
[[Outra nota]]
```

Isso cria um link clicável.

**Com alias (texto customizado):**
```markdown
[[Obsidian|Ferramenta de PKM]]
```

Aparece como "Ferramenta de PKM" mas linka para "Obsidian"

### Forward Links vs Backlinks

**Forward link:** Você cria
```
Nesta nota: [[Zettelkasten]]
Você está linkando PARA Zettelkasten
```

**Backlink:** Automático
```
Na nota Zettelkasten:
O Obsidian aparece em "Linked mentions"
Obsidian linkava PARA você
```

### Como Aparecem Links

**Backlinks pane:**
- Mostra quem linka para esta nota
- Automático (não precisa fazer nada)
- Super útil para descobrir conexões

**Linked mentions:**
- Pessoas linkando pra você
- Sem você precisar ir atualizando

### Graph View

Obsidian tem visualização gráfica:
```
Ctrl+G (ou Cmd+G no Mac)
```

Você vê:
- 🔵 Notas (pontos)
- 🔗 Conexões (linhas)
- 🔴 Clusters (grupos de ideias)
- 🌟 Hubs (notas altamente conectadas)

### Estratégia de Linking

**Boas práticas:**
1. Link quando é GENUINAMENTE relacionado
2. Não force links artificiais
3. Use natural (como pensa)
4. Deixa emergir organicamente

**Anti-padrão:**
- ❌ Linkar TUDO
- ❌ Criar links aleatórios
- ❌ Só pra preencher

### Unlinked Mentions

Obsidian detecta quando você escreve nome de nota:
```
"Obsidian é uma ferramenta PKM"
↓
Obsidian vê "ferramenta PKM" e sugere link automático
```

Use: Settings → Core plugins → Unlinked mentions

## Exercício Prático
1. Crie 5 notas simples
2. Linke-as entre si (mínimo 3 links)
3. Abra Graph View (Cmd+G)
4. Veja padrão emergir
5. Use Backlinks pane

## Próxima Lição
Próxima: Tags e Sistema de Taxonomia',
    v_project_id,
    v_modulo5_id,
    1,
    'published',
    0.91,
    '{"duration_minutes": 14, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "24_links_internos_entre_as_notas-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 5.2
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-5-2-tags-sistema',
    'Lição 5.2: Tags e Sistema de Taxonomia',
    'course_lesson',
    true,
    '# Lição 5.2: Tags e Sistema de Taxonomia

## Gancho
Tags são o segundo jeito de navegar seu segundo cérebro. Se links são "horizontais", tags são "verticais".

## Promessa
Nesta lição você vai aprender:
- O que são tags
- Sistema de tags eficiente
- Hierarquia de tags
- Pesquisa com tags

## Solução

### O Que São Tags?

Tags são:
- **Rótulos** para agrupar notas
- **Transversais** (uma nota pode ter vários)
- **Navegáveis** (clique para ver todas com tag)
- **Pesquisáveis** (procure por tag)

### Sintaxe

```markdown
#tag
#tag/subtag
#tag/subtag/nivel3
```

### Sistema de Tags Recomendado

**Estrutura hierárquica:**
```
#topic/obsidian
#topic/produtividade
#topic/learning

#status/completed
#status/in-progress
#status/todo

#type/article
#type/video
#type/book

#emotion/interesting
#emotion/important
#emotion/unclear
```

### Exemplo Real

```markdown
# Nota: Zettelkasten

#topic/knowledge-management
#topic/learning
#type/methodology
#status/completed
#emotion/important

Conteúdo aqui...
```

### Buscar com Tags

**Em Obsidian:**
```
Cmd+Shift+F (busca global)
tag:#topic/obsidian
```

Mostra todas as notas com essa tag!

### Dicas

1. **Mantenha simples:** 10-15 tags principais
2. **Seja consistente:** Use nomes iguais sempre
3. **Hierarquize:** #tipo/subtipo
4. **Não exagere:** 1-3 tags por nota

### Tags vs Links

| Links | Tags |
|-------|------|
| Horizontal (entre notas) | Vertical (categorias) |
| Conectam ideias | Classificam ideias |
| Emergem | Planejados |
| Muito mais úteis | Suplementar |

**Use ambos!**
- Links para conexões
- Tags para classificação

## Exercício Prático
1. Defina 10 tags principais
2. Tagueie suas 5 notas
3. Pesquise por tag
4. Veja Tag pane em Settings
5. Organize hierarquicamente

## Próxima Lição
Próxima: Pastas e Organização',
    v_project_id,
    v_modulo5_id,
    2,
    'published',
    0.90,
    '{"duration_minutes": 15, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 2, "source_file": "29_tags-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 5.3
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-5-3-pastas-organizacao',
    'Lição 5.3: Pastas e Organização de Estrutura',
    'course_lesson',
    true,
    '# Lição 5.3: Pastas e Organização de Estrutura

## Gancho
Pastas são "ó último jeito" de organizar. Mas podem ser úteis para começar.

## Promessa
Nesta lição você vai aprender:
- Quando usar pastas
- Estrutura recomendada
- Evitar "pasta hell"
- Organização mínima

## Solução

### Realidade das Pastas

**O problema:**
Muitas pastas criam "pasta hell"
```
vault/
├── Projetos/
│   ├── Projeto1/
│   │   ├── Notas/
│   │   ├── Pesquisa/
│   │   └── Referências/
│   └── Projeto2/
```

Aí você cria 1 nota sobre 2 projetos. Onde coloca?

**A solução:**
Pastas MINIMALISTAS
```
vault/
├── 📚 Sources/      ← Material externo
├── 🧠 Brain/        ← Seu segundo cérebro
├── 📋 Templates/    ← Templates
└── 🗃️ Archive/       ← Notas antigas
```

### Estrutura Recomendada

```
vault/
├── 📚 Sources/
│   ├── Articles/
│   ├── Books/
│   └── Videos/
│
├── 🧠 Brain/
│   ├── Concepts/     (ideias principais)
│   ├── Projetos/     (seus projetos)
│   ├── Pessoas/      (contatos/influentes)
│   ├── MOC/          (mapas de conteúdo)
│   └── Daily/        (daily notes)
│
├── 📋 Templates/
│   ├── Note Template
│   ├── Project Template
│   └── Daily Template
│
└── 🗃️ Archive/
    └── (notas antigas)
```

### Quando Usar Pastas

**USE pastas para:**
- ✅ Separar "coleta" de "processamento"
- ✅ Agrupar templates
- ✅ Organizar sources externas
- ✅ Archive (notas antigas)

**NÃO USE para:**
- ❌ Categorizar tudo
- ❌ Criar hierarquias profundas
- ❌ Replicar Links/Tags

### Prática: Pastas + Links + Tags

**Melhor forma:**
1. **Pastas:** Separação de conceito (Sources vs Brain)
2. **Links:** Conexões entre notas
3. **Tags:** Classificação transversal

```markdown
# Nota: Obsidian

📁 Localização: Brain/Concepts/

#topic/tools
#topic/pkm
#type/software
#emotion/important

[[Zettelkasten]] ← Link pra outra nota
[[Second Brain]] ← Conecta ideias
```

### Refatorar Sem Dor

Se tem muitas pastas:
1. Crie estrutura nova
2. Mova arquivos gradualmente
3. Links não quebram (Obsidian atualiza)
4. Não precisa refatorar tudo de uma vez

## Exercício Prático
1. Crie a estrutura recomendada
2. Mova suas 5 notas para Brain/
3. Adicione 3 notes em Sources/
4. Teste que links funcionam
5. Veja como fica organizado

## Próxima Lição
Próxima: O Gráfico do Segundo Cérebro',
    v_project_id,
    v_modulo5_id,
    3,
    'published',
    0.89,
    '{"duration_minutes": 16, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "31_pastas-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 5.4
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-5-4-grafico-segundo-cerebro',
    'Lição 5.4: O Gráfico do Segundo Cérebro',
    'course_lesson',
    true,
    '# Lição 5.4: O Gráfico do Segundo Cérebro

## Gancho
Se fizeste tudo certo, quando você abre Graph View, seu segundo cérebro VISUALMENTE faz sentido.

## Promessa
Nesta lição você vai aprender:
- Como ler o graph view
- O que padrões significam
- Otimizar sua rede de notas
- Usar graph como feedback

## Solução

### Abrindo Graph View

```
Mac: Cmd+G
Windows: Ctrl+G
```

Você vê:
- 🔵 Pontos = Notas
- 🔗 Linhas = Links entre notas
- 🔴 Clusters = Grupos de ideias
- ⭐ Hubs = Notas super conectadas

### Padrões que Significam

**Padrão 1: Hub Central**
```
      A ← Nota principal
     /│\
    B C D ← Todas linkam pra A
```
Significa: A é conceito central, B/C/D são específicos

**Padrão 2: Cluster Conectado**
```
A ← B ← C ← D
     ↓   ↓
     E ← F
```
Significado: Grupo de ideias bem conectado (BOMMM!)

**Padrão 3: Isolado**
```
A ─ B ─ C   (isolado)

D ─ E ─ F   (isolado)
```
Significado: Dois tópicos sem conexão (normal, mas vê se precisa)

**Padrão 4: Caos Total**
```
Tudo conectado com tudo (MACARRÃO)
```
Significado: Ou você tá linkando demais, ou é normal (continua observando)

### Usando Graph como Feedback

**Boas perguntas:**
1. Há clusters isolados? Devo conectar?
2. Há uma nota com MUITOS links (hub)? É realmente central?
3. Há notas completamente isoladas? Devo deletar?
4. A forma visual bate com meu modelo mental?

### Otimizar Sua Rede

1. **Crie MOCs (Maps of Content)**
   - Nota que lista e agrupa outras
   - Torna visível no graph

2. **Evite overlink**
   - Link apenas quando genuíno
   - Deixa emergir naturalmente

3. **Crie estrutura**
   - Conceitos principais
   - Detalhes dependem deles
   - Emergem padrões

### Exemplo: Estrutura Ideal

```
ATLAS Method (Central)
  ↙    ↓    ↘
Access Train Link Apply Share (5 pilares)
  ↓     ↓    ↓   ↓    ↓
[Notas específicas de cada]
```

Graph fica:
- 1 centro
- 5 secundários
- Múltiplos detalhes
- VISUAL e faz sentido!

### Recursos Adicionais do Graph

**Filtros:**
- Por tipo de nota
- Por tag
- Por pasta

**Visualização:**
- Zoom
- Pan
- Focus mode (selecione nota, vê só relacionadas)

## Exercício Prático
1. Abra Graph View (Cmd+G)
2. Observe padrões
3. Crie MOC central
4. Linke tópicos principais pra MOC
5. Veja graph se reorganizar
6. Experimente focus mode

## Próxima Lição
Próxima: Módulo 6 - Plugins Essenciais',
    v_project_id,
    v_modulo5_id,
    4,
    'published',
    0.92,
    '{"duration_minutes": 17, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "32_o_grafico_do_segundo_cerebro_e_como_usa_lo_de_verdade-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');


  -- ════════════════════════════════════════════════════════════════════════════════
  -- MÓDULO 6: Plugins Essenciais
  -- ════════════════════════════════════════════════════════════════════════════════


  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'modulo-6-plugins-essenciais',
    'Módulo 6: Plugins Essenciais',
    'course_module',
    true,
    '# Módulo 6: Plugins Essenciais

## O que você vai aprender
- Plugins nativos poderosos
- Community plugins úteis
- Propriedades e metadados
- Customização com plugins

## Lições
1. Superpoderes com plugins nativos
2. Plugins da comunidade
3. Propriedades e metadados
4. Configuração de atalhos

## Objetivo
Turbinar seu Obsidian com funcionalidades avançadas.',
    v_project_id,
    v_outline_id,
    6,
    'published',
    '{"lessons_count": 4, "duration_minutes": 62, "difficulty": "advanced"}'::jsonb
  ) RETURNING id INTO v_modulo6_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_modulo6_id, v_professor_id, 'creator');

  -- Lição 6.1
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-6-1-plugins-nativos',
    'Lição 6.1: Superpoderes com Plugins Nativos',
    'course_lesson',
    true,
    '# Lição 6.1: Superpoderes com Plugins Nativos

## Gancho
Obsidian já vem com plugins nativos INCRÍVEIS que a maioria não conhece. Vamos ativar seus superpoderes.

## Promessa
Nesta lição você vai aprender:
- Quais plugins nativos ativar
- Como cada um funciona
- Configurações recomendadas
- Casos de uso

## Solução

### Plugins Nativos Essenciais

**1. Backlinks pane** (já vem ativado)
- Mostra quem linka pra você
- Essencial para descobrir conexões
- Esteja na aba "Linked mentions"

**2. Tag pane**
- Mostra todas as tags
- Navega por tag
- Vê frequência de uso
- Settings → Core plugins → ativar

**3. Outline**
- Mostra estrutura da nota
- Navega por seções
- Jump para qualquer heading
- Ótimo pra notas longas

**4. File tree / File explorer**
- Visualiza todas as notas
- Reorganiza pastas
- Cria notas/pastas novas
- Padrão, já vem

**5. Graph view**
- Visualiza rede de notas
- Focus mode
- Filtros
- Já explicado antes

**6. Daily notes**
- Cria nota automática todo dia
- Template customizado
- Perfeito pra diário/journaling
- Settings → Core plugins

**7. Command palette**
- Procura qualquer ação
- Sem atalho? Palette resolve
- Cmd+P / Ctrl+P
- ESSENCIAL

**8. Search**
- Busca global
- Regex support
- Por pasta, tag, tipo
- Cmd+Shift+F

### Configurações Recomendadas

**Daily Notes:**
1. Settings → Core plugins → Daily notes → Configure
2. Date format: `YYYY-MM-DD`
3. Template location: `Templates/Daily`
4. New file location: `Brain/Daily`

**Graph View:**
1. Settings → Graph view
2. Display physics: 0.8
3. Links color: customize
4. Show existing only: off

**File Explorer:**
1. Settings → File explorer
2. Allow browsing: on
3. Sort by: modified

### Casos de Uso

| Plugin | Caso de Uso |
|--------|------------|
| Backlinks | Descobrir conexões |
| Tags | Navegar tópicos |
| Outline | Notas com muitas seções |
| Graph | Visualizar emergências |
| Daily | Journaling / Reflexão |
| Search | Pesquisa poderosa |

## Exercício Prático
1. Ative 5 plugins nativos
2. Configure Daily notes
3. Crie nota hoje (teste daily)
4. Explore Graph view
5. Use Outline pra navegar

## Próxima Lição
Próxima: Plugins da Comunidade',
    v_project_id,
    v_modulo6_id,
    1,
    'published',
    0.91,
    '{"duration_minutes": 15, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "25_superpoderes_com_plugins_nativos-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 6.2
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-6-2-plugins-comunidade',
    'Lição 6.2: Plugins da Comunidade',
    'course_lesson',
    true,
    '# Lição 6.2: Plugins da Comunidade

## Gancho
Se plugins nativos são bons, community plugins são gamechangers. Vamos aprender quais instalar.

## Promessa
Nesta lição você vai aprender:
- Como instalar plugins
- Plugins mais úteis
- Evitar plugin hell
- Gerenciar dependências

## Solução

### Como Instalar Plugins

1. Settings → Community plugins → Browse
2. Procure pelo nome
3. Clique em plugin
4. Clique "Install"
5. Ative em "Installed plugins"

### Plugins Recomendados (Top 10)

**1. Dataview**
- Cria queries sobre suas notas
- Tipo SQL do seu vault
- Muito poderoso
- Curva de aprendizado média

**2. Templater**
- Templates avançados
- Variáveis dinâmicas
- Comandos customizados
- Substitui "Templates" nativo

**3. Quick Capture**
- Captura notas rápido
- Inbox system
- Depois processa
- Útil demais

**4. Calendar**
- Calendário no painel
- Daily notes integradas
- Navega por datas
- Visual bonito

**5. Excalidraw**
- Desenha diagramas
- Dentro do Obsidian
- Linhas + formas + texto
- Perfeito pra brainstorm

**6. Advanced Tables**
- Tabelas com mais poder
- Formatar fácil
- Alinhamento automático
- Se trabalha com dados

**7. Natural Language Dates**
- Converte "next friday" em data
- Muito útil
- Parseia datas naturais
- Economiza tempo

**8. Daily Notes Alias**
- Cria alias para daily notes
- Navega por data verbal
- [[Today]] funciona
- Muito conveniente

**9. Obsidian Git**
- Sincroniza vault com Git
- Backup automático
- Controle de versão
- Para geeks

**10. Obsidian Web Clipper**
- Salva web articles
- Direto no Obsidian
- Com source URL
- Perfeito pra pesquisa

### Instalação Recomendada

**Comece com:**
1. Dataview
2. Templater
3. Quick Capture
4. Calendar

**Depois adicione:**
5. Advanced Tables
6. Natural Language Dates
7. Excalidraw

**Evite no começo:**
- Excesso de plugins
- Plugins experimentais
- Demanda muito sistema

### Gerenciar Plugins

```
Settings → Community plugins → Manage
```

Aqui você pode:
- Ativar/desativar
- Ver versão
- Atualizar
- Desinstalar

**Bom hábito:**
- Revise plugins mensalmente
- Delete não-utilizados
- Atualize regularmente

### Evitar Plugin Hell

**Problema:** Instalar tudo, depois vault fica lento

**Solução:**
1. Instale um plugin por vez
2. Teste por 1 semana
3. Se não usar, delete
4. Máximo 15 plugins

### Dados Importantes

Plugins salvam dados em `.obsidian/plugins/`
- Configurações
- Caches
- Metadados

**Backup importante!** Se perder `.obsidian`, perde setup.

## Exercício Prático
1. Instale Dataview
2. Instale Templater
3. Instale Calendar
4. Configure cada um
5. Teste funcionalidades

## Próxima Lição
Próxima: Propriedades e Metadados',
    v_project_id,
    v_modulo6_id,
    2,
    'published',
    0.90,
    '{"duration_minutes": 17, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 2, "source_file": "26_plugins_da_comunidade_importando_de_outras_ferramentas-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 6.3
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-6-3-propriedades-metadados',
    'Lição 6.3: Propriedades e Metadados',
    'course_lesson',
    true,
    '# Lição 6.3: Propriedades e Metadados

## Gancho
Metadados transformam notas dumb em notas smart. Vamos aprender a adicionar contexto estruturado.

## Promessa
Nesta lição você vai aprender:
- O que são propriedades
- Sintaxe YAML frontmatter
- Tipos de propriedades
- Usar com Dataview

## Solução

### O Que São Propriedades?

Propriedades são:
- Metadados no topo da nota
- Estruturados (chave-valor)
- Queryáveis (Dataview)
- Opcional mas poderoso

### Sintaxe YAML

```markdown
---
title: Meu Título
author: Seu Nome
date: 2025-10-28
status: in-progress
tags: [obsidian, learning]
---

Seu conteúdo aqui...
```

### Tipos de Propriedades

**String (texto):**
```yaml
title: "Obsidian Tips"
author: "Adriano"
```

**Number (número):**
```yaml
priority: 1
reading_time: 15
```

**Date (data):**
```yaml
created: 2025-10-28
updated: 2025-10-29
```

**Boolean (true/false):**
```yaml
completed: true
published: false
```

**List (lista):**
```yaml
tags: [obsidian, learning, pkm]
links: ["note1", "note2"]
```

### Exemplo Completo

```markdown
---
title: Zettelkasten Method
author: "Adriano Marqui"
date: 2025-10-28
status: completed
priority: 5
tags: [methodology, pkm, learning]
related: ["Obsidian", "Second Brain"]
reading_time: 20
---

# Zettelkasten Method

Conteúdo...
```

### Usar com Dataview

**Dataview query:**
```
table title, status, reading_time
where status = "completed"
sort priority desc
```

Mostra todas as notas com status "completed" ordenadas por priority!

### Templates com Propriedades

Use Templater para auto-preencher:

```
---
title: `<% tp.file.title %>`
author: "Adriano"
date: `<% moment(tp.file.stat.ctime).format("YYYY-MM-DD") %>`
status: "in-progress"
tags: []
---
```

Auto-preenche data!

### Boas Práticas

1. **Defina padrão:** Que propriedades TODA nota tem?
2. **Consistência:** Mesmos nomes sempre
3. **Não exagere:** 5-10 propriedades por nota
4. **Use para query:** Só vale a pena se usa com Dataview

### Exemplo: Padrão para Todas as Notas

```yaml
---
title: [auto]
created: [auto]
updated: [auto]
status: inbox
tags: []
type: note
source: null
---
```

## Exercício Prático
1. Adicione propriedades em suas 5 notas
2. Use 5-7 propriedades diferentes
3. Crie query Dataview filtrando por propriedade
4. Teste ordenar por propriedade
5. Veja insights emergindo

## Próxima Lição
Próxima: Configuração de Atalhos Avançados',
    v_project_id,
    v_modulo6_id,
    3,
    'published',
    0.89,
    '{"duration_minutes": 16, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "28_iniciando_com_propriedades-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 6.4
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-6-4-atalhos-avancados',
    'Lição 6.4: Configuração de Atalhos Avançados',
    'course_lesson',
    true,
    '# Lição 6.4: Configuração de Atalhos Avançados

## Gancho
Você já sabe atalhos básicos. Agora vamos configurar atalhos customizados que transformam seu fluxo.

## Promessa
Nesta lição você vai aprender:
- Configurar hotkeys customizados
- Atalhos por plataforma
- Evitar conflitos
- Workflow otimizado

## Solução

### Acessar Hotkeys

```
Settings → Hotkeys
```

Aqui você pode:
- Procurar qualquer comando
- Definir seu atalho
- Ver conflitos
- Resetar tudo

### Atalhos Recomendados para Configurar

**Notas:**
```
Cmd+Alt+N → Nova nota
Cmd+Alt+T → Abrir Today (daily note)
Cmd+K → Inserir link
```

**Navegação:**
```
Cmd+[ → Volta na história
Cmd+] → Próxima na história
Cmd+Shift+F → Busca global
Cmd+P → Command palette (já configurado)
```

**Graph:**
```
Cmd+G → Abrir/fechar graph view
Cmd+Shift+G → Graph local (só relacionadas)
```

**Organização:**
```
Cmd+Shift+P → Abrir palete de comandos
Cmd+L → Insert link (customize)
Cmd+; → Toggle line number (se usar)
```

### Evitar Conflitos

**Conflitos comuns:**
- Cmd+Space: Spotlight (macOS)
- Cmd+Tab: App Switcher
- Cmd+W: Fechar janela (Obsidian já usa)
- Cmd+Shift+C: Color Picker (Obsidian)

**Dica:** Veja a coluna "When" pra entender contexto.

### Padrão de Atalhos

**Desenvolver padrão:**
```
Cmd + primeira letra do comando
Cmd+Shift + menos comum
Cmd+Alt + raro
```

**Exemplo:**
```
Cmd+N → New note
Cmd+Shift+N → New window
Cmd+Alt+N → New note with template
```

### Hotkeys por Plataforma

**Diferentes em Mac vs Windows?**

Settings → Hotkeys permite especificar:
- MacOS só
- Windows só
- Ambos

```
Mac: Cmd+K
Windows: Ctrl+K
```

### Workflow Otimizado com Atalhos

**Scenario: Capturar ideia rápido**
```
1. Cmd+Alt+N → Nova nota
2. Digita ideia rápido (Cmd+B, Cmd+I, etc)
3. Cmd+K → Linka se necessário
4. Cmd+S → Salva (automático)
5. Cmd+W → Volta ao anterior
```

**Tempo total:** < 30 segundos!

### Advanced: Macro com Plugins

Com plugin "Obsidian Macro", você pode:
- Combinar múltiplos comandos
- 1 atalho = múltiplas ações

```
Exemplo:
Cmd+Shift+M executa:
  1. Nueva nota
  2. Insert template
  3. Set date
  4. Link to today
```

## Exercício Prático
1. Configure 5 hotkeys customizados
2. Use sem pensar por 1 semana
3. Adicione 5 mais quando confortável
4. Teste em ambos (Mac/Windows se aplicável)
5. Documente seus atalhos pessoais

## Próxima Lição
Próxima: Módulo 7 - ATLAS Method',
    v_project_id,
    v_modulo6_id,
    4,
    'published',
    0.88,
    '{"duration_minutes": 14, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 3, "source_file": "33_configuracao_de_atalhos-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');


  -- ════════════════════════════════════════════════════════════════════════════════
  -- MÓDULO 7: ATLAS Method
  -- ════════════════════════════════════════════════════════════════════════════════


  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'modulo-7-atlas-method',
    'Módulo 7: ATLAS Method - Método Completo',
    'course_module',
    true,
    '# Módulo 7: ATLAS Method - Método Completo

## O que você vai aprender
- Os 4 níveis de aprendizado
- ATLAS: Access, Train, Link, Apply, Share
- Integração com IA
- Workflow prático

## Lições
1. Os 4 níveis de aprendizado
2. Segundo cérebro com IA
3. Workshop: Smart Connections
4. Workshop: Canvas e Visualização

## Objetivo
Dominar metodologia completa para aprender de forma exponencial.',
    v_project_id,
    v_outline_id,
    7,
    'published',
    '{"lessons_count": 4, "duration_minutes": 68, "difficulty": "advanced"}'::jsonb
  ) RETURNING id INTO v_modulo7_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_modulo7_id, v_professor_id, 'creator');

  -- Lição 7.1
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-7-1-4-niveis-aprendizado',
    'Lição 7.1: Os 4 Níveis de Aprendizado',
    'course_lesson',
    true,
    '# Lição 7.1: Os 4 Níveis de Aprendizado

## Gancho
Nem toda aprendizagem é igual. Aprender superficialmente é diferente de dominar. Vamos estruturar.

## Promessa
Nesta lição você vai aprender:
- Os 4 níveis de aprendizado
- Identificar seu nível
- Estrutura Bloom''s ampliada
- Rota para maestria

## Solução

### Os 4 Níveis (Simplificado)

**Nível 1: EXPOSIÇÃO**
- Viu conteúdo
- Não entende ainda
- Precisa de contexto
- Ex: "Li artigo sobre Obsidian"

**Nível 2: COMPREENSÃO**
- Entende o conceito
- Consegue explicar
- Sabe quando usar
- Ex: "Sei o que é wiki-link"

**Nível 3: APLICAÇÃO**
- Consegue usar na prática
- Resolve problemas
- Adapta em contexto novo
- Ex: "Criei sistema de notas"

**Nível 4: MAESTRIA**
- Domina profundamente
- Ensina outros
- Inova a partir disso
- Ex: "Tenho workflow único"

### Bloom''s Taxonomy Expandido

```
6. CREATE       ← Maestria (criar novo)
5. EVALUATE     ← Maestria (julgar valor)
4. ANALYZE      ← Aplicação (quebrar em partes)
3. APPLY        ← Aplicação (usar em contexto)
2. UNDERSTAND   ← Compreensão (explicar)
1. REMEMBER     ← Exposição (recordar)
```

### De Exposição a Maestria

**Estrutura típica:**
```
Semana 1: Exposição
  - Assiste aula
  - Lê artigo
  - Explora ferramenta

Semana 2-3: Compreensão
  - Estuda conceitos
  - Elabora notas
  - Explica pra alguém

Semana 4-8: Aplicação
  - Usa na prática
  - Resolve problemas
  - Adapta seu contexto

Mês 3+: Maestria
  - Fluxo automático
  - Ensina outros
  - Inova/customiza
```

### Como Estruturar Seu Aprendizado

**Nível 1 (Exposição):**
- Copie tudo (templates, atalhos)
- Não tente entender ainda
- Apenas reproduza

**Nível 2 (Compreensão):**
- Por que isso funciona?
- Quando usar? Quando não?
- Explique pra um amigo

**Nível 3 (Aplicação):**
- Use em seu contexto real
- Enfrente problemas
- Adapte conforme precisa

**Nível 4 (Maestria):**
- Seu workflow é natural
- Ensine sua forma
- Crie variações únicas

### Timeline Realista

| Nível | Tempo |
|-------|-------|
| Exposição | 1-2 semanas |
| Compreensão | 2-4 semanas |
| Aplicação | 1-3 meses |
| Maestria | 3-12 meses |

**Total para Obsidian:** ~3-6 meses de uso consistente.

## Exercício Prático
1. Onde você está agora? (identifique nível)
2. O que falta pra próximo nível?
3. Crie plano para avançar
4. Documente no seu vault

## Próxima Lição
Próxima: Segundo Cérebro com IA',
    v_project_id,
    v_modulo7_id,
    1,
    'published',
    0.91,
    '{"duration_minutes": 16, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "27_os_4_niveis_de_aprendizado_e_a_forma_de_fazer_do_obsidian_um_habito-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 7.2
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-7-2-segundo-cerebro-ia',
    'Lição 7.2: Segundo Cérebro com IA',
    'course_lesson',
    true,
    '# Lição 7.2: Segundo Cérebro com IA

## Gancho
IA está transformando como aprendemos. Vamos integrar IA no seu Obsidian.

## Promessa
Nesta lição você vai aprender:
- Quando usar IA no Obsidian
- Plugins de IA
- Prompts eficazes
- Workflow com IA

## Solução

### Por Que IA?

IA pode:
- ✅ Resumir artigos longos
- ✅ Gerar ideias novas
- ✅ Conectar conceitos
- ✅ Refinar escrita
- ✅ Responder perguntas sobre seu vault

### Plugins de IA

**1. Smart Connections**
- Procura por semelhança
- Encontra notas relacionadas
- Baseado em embeddings
- Muito poderoso

**2. Obsidian AI Assistant**
- Chat direto no Obsidian
- Responde sobre vault
- Gera sugestões
- Refina texto

**3. Text Generator**
- Gera conteúdo
- Sumariza
- Brainstorm
- Expande ideias

### Quando Usar IA

**USE para:**
- ✅ Resumir conteúdo longo
- ✅ Expandir ideia em nota
- ✅ Encontrar conexões
- ✅ Refinar tom de escrita
- ✅ Brainstorm

**NÃO USE para:**
- ❌ Pensar por você
- ❌ Substituir sua voz
- ❌ Criar sem validação
- ❌ Tudo automaticamente

### Prompt Template Eficaz

```
Papel: Você é um ajudante PKM

Contexto: Estou aprendendo sobre [tópico]

Tarefa: [O que você quer]

Requisitos:
- Tom: formal/casual
- Comprimento: [comprimento]
- Estilo: [seu estilo]

Validação: Vou revisar antes de usar
```

### Workflow: Artigo → Nota com IA

```
1. Adicione artigo em Sources/
2. Use Text Generator: Summarize
3. Copie resumo
4. Smart Connections: encontra relacionadas
5. Linka as notas
6. Revise tudo
7. Guarde no Brain/
```

**Tempo:** 5-10 minutos vs 30+ manual!

### Importante: Validação

SEMPRE revise output de IA:
- Procure por erros
- Cheque referências
- Valide conclusões
- Adicione sua voz

### Ferramentas Externas (Não Obsidian)

- **ChatGPT:** Perguntas gerais
- **Claude:** Análise profunda
- **Perplexity:** Pesquisa com fontes
- **Copilot:** Geração de código

Copie resultado, cola no Obsidian, processa.

## Exercício Prático
1. Instale Smart Connections
2. Configure com sua conta
3. Processe 1 artigo com IA
4. Valide resultado
5. Adicione ao vault

## Próxima Lição
Próxima: Workshop - Smart Connections',
    v_project_id,
    v_modulo7_id,
    2,
    'published',
    0.90,
    '{"duration_minutes": 17, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "32_segundo_crebro_com_ia-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 7.3
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-7-3-workshop-smart-connections',
    'Lição 7.3: Workshop - Smart Connections Chat',
    'course_lesson',
    true,
    '# Lição 7.3: Workshop - Smart Connections Chat

## Gancho
Smart Connections é o plugin mais poderoso do Obsidian. Vamos dominar passo a passo.

## Promessa
Nesta lição você vai aprender (mão na massa):
- Instalar Smart Connections
- Configurar embeddings
- Usar o chat
- Casos práticos

## Solução

### O Que é Smart Connections?

Plugin que:
- Lê TODAS suas notas
- Cria "embeddings" (representação numérica de texto)
- Encontra notas semanticamente similares
- Chat que responde baseado em seu vault

**Resultado:** Uma IA que conhece seu segundo cérebro!

### Passo 1: Instalar

```
Settings → Community plugins → Browse
Procure "Smart Connections"
Install → Enable
```

### Passo 2: Configurar

```
Settings → Smart Connections
Escolha provider:
  - Local (runs in your computer)
  - OpenAI (precisa de key)
  - Ollama (offline)

Recomendação: OpenAI (melhor qualidade)
```

Se usar OpenAI:
1. Pegue key em openai.com
2. Cole em Settings
3. Escolha modelo (gpt-3.5-turbo é bom)

### Passo 3: Criar Index

```
Smart Connections icon (painel direito)
Clique "Index Notes"
Aguarde processa (pode demorar)
Quando terminar: 📊 Dashboard aparece
```

### Passo 4: Usar o Chat

```
Chat icon → abra chat
Digite pergunta sobre seu vault

Exemplos:
"Qual é minha metodologia de PKM?"
"O que aprendi sobre Obsidian?"
"Como eu link notas?"
"Resuma meus projetos"
```

Smart Connections busca em seu vault e responde!

### Passo 5: Usar Conexões Automáticas

```
Settings → Smart Connections
Ative: "Smart Connections links"

Agora, em cada nota aparece:
"Similar notes: [lista automática]"
```

### Casos Práticos Mão na Massa

**Caso 1: Encontrar Tópicos Relacionados**
```
Pergunta: "Quais notas relacionam com [[Zettelkasten]]?"
Resposta: Smart Connections lista
```

**Caso 2: Resumir Conhecimento**
```
Pergunta: "Qual é o conceito mais importante do meu vault?"
Resposta: IA analisa tudo e diz
```

**Caso 3: Brainstorm**
```
Pergunta: "Que ideias tenho sobre PKM pessoal?"
Resposta: Agrupa e lista padrões
```

### Troubleshooting

**Problema:** "Index is empty"
Solução: Clique "Index Notes" novamente

**Problema:** "Rate limit exceeded"
Solução: Aguarde 1 minuto, ou use local model

**Problema:** "Results são ruins"
Solução: Melhore qualidade das notas; IA lê o que você escreve

### Dicas Pro

1. **Indexe regularmente:** Uma vez por semana
2. **Use buscas específicas:** Mais detalhado = melhor
3. **Valide respostas:** IA erra, você decide
4. **Combine com Dataview:** Query + Chat = poderoso

## Exercício Prático (Mão na Massa!)
1. Instale Smart Connections
2. Configure com sua conta OpenAI
3. Indexe seu vault
4. Faça 5 perguntas diferentes
5. Note insights descobertos
6. Configure "Similar notes"

## Próxima Lição
Próxima: Workshop - Canvas e Visualização',
    v_project_id,
    v_modulo7_id,
    3,
    'published',
    0.92,
    '{"duration_minutes": 19, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "34_ia_workshop_smart_connections_chat_com_o_2_cerebro-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 7.4
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-7-4-canvas-visualizacao',
    'Lição 7.4: Canvas e Visualização Avançada',
    'course_lesson',
    true,
    '# Lição 7.4: Canvas e Visualização Avançada

## Gancho
Às vezes palavras não bastam. Canvas permite visualizar ideias complexas graficamente.

## Promessa
Nesta lição você vai aprender:
- O que é Canvas
- Como criar diagramas
- Casos de uso
- Combinar com Graph

## Solução

### O Que É Canvas?

Canvas é:
- Whiteboard infinito no Obsidian
- Adiciona notas, links, formas
- Salta limitações de linha
- Perfeito pra mindmap, diagramas

### Como Acessar

```
Clique direito na pasta
New → Canvas file
Ou: Command palette → Create new canvas
```

Canvas abre com toolbar:
- 📝 Text
- 📌 Cards (links para notas)
- ➕ Shapes
- 🖌️ Colors
- 🔗 Lines

### Uso Básico

**1. Adicionar Cards (notas)**
```
Botão "Card"
Arraste pra canvas
Escreva ou linke nota
```

**2. Conectar com Linhas**
```
Botão "Line"
Clique em card A
Clique em card B
Automático conecta!
```

**3. Colorir**
```
Clique em card
Escolha cor
Organiza visualmente
```

### Casos Práticos

**Caso 1: Mindmap de Projeto**
```
Center: [Meu Projeto]
Branches: [Feature 1] [Feature 2] [Feature 3]
Sub-branches: Tasks específicas
```

**Caso 2: Comparação**
```
Left: [Obsidian]
Right: [Notion]
Middle: Diferenças

Cards mostram vantagens/desvantagens
```

**Caso 3: Estrutura de Livro**
```
Top: [Livro Title]
Chapters: [Cap 1] [Cap 2] [Cap 3]
Sections: Subtópicos
```

### Combinar Canvas + Graph

**Workflow:**
```
1. Crie canvas pra visualizar
2. Cards linkam pra notas reais
3. Abra graph view (Cmd+G)
4. Veja estrutura graficamente
5. Volte ao canvas pra detalhar
```

### Exportar Canvas

Canvas é um `.canvas` file:
- Texto puro
- Versionável com Git
- Exportável como PNG

```
Menu ... → Export as PNG
```

### Dicas

1. **Use cores estrategicamente:** Cada cor = categoria
2. **Mantenha simples:** Demais info fica poluído
3. **Linke notas:** Cards linkando pra Brain/
4. **Organize layers:** Cores + posição = estrutura

### Exemplo: Setup Completo

```
Canvas: Meu Curso Obsidian
├── Estrutura (visual)
│   ├── Módulo 1 [card]
│   ├── Módulo 2 [card]
│   └── Módulo 3 [card]
├── Dependências (linhas)
│   └── M1 → M2 → M3
└── Cada card linka pra nota real
```

Quando clica em card, abre nota completa!

## Exercício Prático
1. Crie 1 canvas novo
2. Adicione 5 cards
3. Conecte com linhas
4. Colorize por categoria
5. Linke cards para suas notas reais
6. Veja structure tomar forma

## Próxima Lição
Próxima: Módulo 8 - Projeto Final',
    v_project_id,
    v_modulo7_id,
    4,
    'published',
    0.91,
    '{"duration_minutes": 17, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "35_canvas-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');


  -- ════════════════════════════════════════════════════════════════════════════════
  -- MÓDULO 8: Projeto Final
  -- ════════════════════════════════════════════════════════════════════════════════


  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'modulo-8-projeto-final',
    'Módulo 8: Projeto Final - Colocando Tudo em Prática',
    'course_module',
    true,
    '# Módulo 8: Projeto Final - Colocando Tudo em Prática

## O que você vai aprender
- Estruturar seu segundo cérebro
- Implementar workflow completo
- Validar sistema
- Próximos passos

## Lições
1. Projeto Final Parte 1: Estrutura Completa
2. Projeto Final Parte 2: Validação e Próximos Passos

## Objetivo
Ter seu segundo cérebro 100% funcional e escalável.',
    v_project_id,
    v_outline_id,
    8,
    'published',
    '{"lessons_count": 2, "duration_minutes": 45, "difficulty": "advanced"}'::jsonb
  ) RETURNING id INTO v_modulo8_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_modulo8_id, v_professor_id, 'creator');

  -- Lição 8.1
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-8-1-projeto-parte1',
    'Lição 8.1: Projeto Final Parte 1 - Estrutura Completa',
    'course_lesson',
    true,
    '# Lição 8.1: Projeto Final Parte 1 - Estrutura Completa

## Gancho
Agora você domina cada peça. Vamos montar o quebra-cabeça inteiro de forma elegante.

## Promessa
Nesta lição você vai:
- Estruturar vault completo
- Configurar workflow end-to-end
- Implementar ATLAS Method
- Ter sistema pronto pra meses de uso

## Solução

### Estrutura Recomendada Final

```
dominando-obsidian/
├── Sources         (Material externo - articles, books, videos)
├── Brain           (Segundo cérebro - concepts, projects, people, daily, mocs)
├── Inbox           (Captura rápida - notas em processamento)
├── Templates       (note, project, daily, book-review, meeting)
├── Fleeting        (Notas temporárias e efêmeras)
└── Archive         (Notas antigas com 3+ meses)
```

### Configuração Obsidian Completa

**1. Core Plugins (ativar):**
- ✅ Backlinks pane
- ✅ Tag pane
- ✅ Outline
- ✅ Daily notes
- ✅ Graph view
- ✅ Command palette
- ✅ Search

**2. Community Plugins (instalar):**
- ✅ Dataview (queries)
- ✅ Templater (templates avançados)
- ✅ Calendar (daily notes visual)
- ✅ Quick Capture (inbox rápido)
- ✅ Smart Connections (IA)

**3. Hotkeys Customizados:**
```
Cmd+N → Nova nota
Cmd+Shift+N → Nova nota com template
Cmd+K → Insert link
Cmd+L → Insert wiki link
Cmd+D → Abrir daily note
Cmd+G → Graph view
Cmd+Shift+F → Busca global
```

**4. Daily Notes Setup:**
```
Settings → Daily notes
Format: YYYY-MM-DD
Template: Templates/daily.md
Folder: Brain/daily/
```

**5. Templates:**
```
Settings → Templater
Folder: Templates/
Configure defaults
```

### Templates Essenciais

**Template: Note Padrão**
```markdown
---
title: `<% tp.file.title %>`
date: `<% moment(tp.file.stat.ctime).format("YYYY-MM-DD") %>`
status: "in-progress"
tags: []
type: "note"
---

# `<% tp.file.title %>`

## Context
Por que esta nota importa?

## Conceito
O que é?

## Exemplos
Casos práticos

## Conexões
Links: [[]]

---
Tags: #
```

**Template: Projeto**
```markdown
---
title: `<% tp.file.title %>`
status: active
start-date: `<% moment().format("YYYY-MM-DD") %>`
deadline: null
tags: [project]
---

# Projeto: `<% tp.file.title %>`

## Objetivo
O que quer alcançar?

## Escopo
O que inclui/exclui?

## Timeline
Quando terminado?

## Tarefas
- [ ] Task 1
- [ ] Task 2

## Aprendizados
Conhecimento ganho

## Reflexão
O que aprendeu?
```

### Workflow ATLAS Completo

**1. ACCESS** (Capturar)
```
Inbox/Quick note
Cmd+N ou Quick Capture
Rápido, sem estrutura ainda
```

**2. TRAIN** (Processar)
```
1. Releia nota
2. Organize em Brain/
3. Adicione links
4. Tagueie com system
```

**3. LINK** (Conectar)
```
1. Use [[wiki-links]]
2. Navegue com backlinks
3. Veja no graph
4. Siga conexões emergentes
```

**4. APPLY** (Usar)
```
1. Ache nota quando precisa
2. Aplique aprendizado
3. Documente resultado
4. Atualize nota com outcome
```

**5. SHARE** (Compartilhar)
```
1. Crie MOC (mapa)
2. Use pra ensinar
3. Exporte se necessário
4. Documente expertise
```

## Exercício Prático: Construir Seu Vault

1. Crie estrutura de pastas acima
2. Configure todos plugins
3. Customize hotkeys
4. Crie 3 templates
5. Configure Daily notes
6. Teste fluxo ATLAS completo

**Tempo:** 2-3 horas
**Resultado:** Sistema pronto pra anos de uso!

## Próxima Lição
Próxima: Projeto Final Parte 2 - Validação',
    v_project_id,
    v_modulo8_id,
    1,
    'published',
    0.93,
    '{"duration_minutes": 24, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "multiple-synthesis"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 8.2
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-8-2-projeto-parte2',
    'Lição 8.2: Projeto Final Parte 2 - Validação e Próximos Passos',
    'course_lesson',
    true,
    '# Lição 8.2: Projeto Final Parte 2 - Validação e Próximos Passos

## Gancho
Você montou o sistema. Agora vamos validar que está working e planejar evolução.

## Promessa
Nesta lição você vai:
- Validar seu segundo cérebro
- Identificar fraquezas
- Planejar evolução
- Entrar em maestria

## Solução

### Checklist de Validação

**Estrutura:**
- [ ] Pastas criadas conforme padrão
- [ ] Nenhuma pasta com 100+ notas
- [ ] Pasta inbox vazia (ou quase)
- [ ] Archive tem notas antigas

**Configuração:**
- [ ] 5+ plugins rodando
- [ ] Hotkeys customizados funcionam
- [ ] Daily notes criando automaticamente
- [ ] Templates se auto-preenchem

**Workflow:**
- [ ] Consegue capturar nota em < 1 minuto
- [ ] Consegue encontrar nota em < 10 segundos
- [ ] Backlinks aparecem automaticamente
- [ ] Graph view mostra padrões

**Documentação:**
- [ ] MOC principal criado
- [ ] Tags documentadas
- [ ] Templates documentados
- [ ] Hotkeys documentados

### Métricas Esperadas

Após 1 mês de uso:
```
Total de notas: 50-200 (depende frequência)
Média de links por nota: 2-5
Hub notes (muito conectadas): 3-10
Isolated notes: < 10%
Tempo pra encontrar nota: < 10 segundos
Fidelidade ao workflow: 80%+
```

### Evoluir Além do Básico

**Mês 1-2:** Básico
- Criar notas
- Linkar
- Tagueiar
- Organizar

**Mês 3-6:** Intermediário
- Usar plugins avançados
- Templates complexos
- Dataview queries
- Smart Connections

**Mês 6-12:** Avançado
- Workflow otimizado (automático)
- Canvas pra visualizar
- IA integrada naturalmente
- Ensinar outros seu sistema

**Ano 2+:** Maestria
- Seu workflow é único
- Você ensina
- Contribui com plugin
- Ou escreve sobre sua forma

### Debugging: Se Algo Não Funciona

**Problema: Notas rápido se acumulam no inbox**
Solução: Agende 15 minutes daily pra processar

**Problema: Não acha notas**
Solução: Melhor tag system ou uso de folder hierarchy

**Problema: Muitos links quebrados**
Solução: Obsidian atualiza automaticamente, mas valide

**Problema: Vault fica lento**
Solução: Desative plugins pesados, archive antigos, separe em 2 vaults

### Próximos Cursos (Depois Deste)

**Depois que domina Obsidian:**
1. PKM Avançado (Zettelkasten profundo)
2. Mente Lendária (metodologia completa)
3. Escrita Digital (criar com segundo cérebro)
4. Ensino (estruturar knowledge pra compartilhar)

### Seu Segundo Cérebro Agora É:

✅ **Funcional:** Sistema rodando
✅ **Escalável:** Aguenta 1000+ notas
✅ **Pesquisável:** Encontra tudo rápido
✅ **Visual:** Graph mostra padrões
✅ **Inteligente:** IA integrada
✅ **Único:** Sua forma de pensar

### Mantendo o Momentum

**Hábito diário (5-10 min):**
- Capturar ideias
- 1 nota de reflexão
- Revisit 1 nota antiga

**Semanal (30-60 min):**
- Processar inbox
- Revisar connections
- Atualizar MOCs
- Refinar tags

**Mensal (2-3 horas):**
- Reindexar Smart Connections
- Archive notas antigas
- Revisar e refinar workflow
- Aprender novo plugin

### Celebração!

Você completou o curso "Dominando Obsidian"!

Agora você:
- ✅ Domina instalação em todos dispositivos
- ✅ Entende markdown completamente
- ✅ Cria notas estruturadas
- ✅ Conecta ideias com links
- ✅ Organiza com tags e pastas
- ✅ Usa 5+ plugins efetivamente
- ✅ Aplica ATLAS Method
- ✅ Integra IA no seu workflow
- ✅ Tem sistema de segundo cérebro funcional

**Parabéns! Você é "Dominador de Obsidian"! 🎉**

## Exercício Final

1. Complete checklist de validação
2. Documente seu workflow pessoal
3. Crie guia para alguém aprender
4. Celebre sua maestria!

## Próximos Passos

- Mantenha hábito diário
- Compartilhe com 1 amigo
- Considere outros cursos
- Continue aprendendo!

---

**Fim do Curso: Dominando Obsidian**
**Status: COMPLETO**
**Próximo: Seu próprio jeito de pensar**',
    v_project_id,
    v_modulo8_id,
    2,
    'published',
    0.94,
    '{"duration_minutes": 21, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 4, "source_file": "course-conclusion"}'::jsonb
  ) RETURNING id INTO v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');


END $$;

COMMIT;

-- ════════════════════════════════════════════════════════════════════════════════
-- QUERIES DE VALIDAÇÃO
-- ════════════════════════════════════════════════════════════════════════════════

SELECT slug, title, content_type, depth_level, sequence_order
FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline'
ORDER BY path;

SELECT
  project_name,
  total_contents,
  published_contents,
  total_word_count,
  avg_fidelity_score
FROM v_project_performance
WHERE project_slug = 'dominando-obsidian';

SELECT
  display_name,
  total_contents,
  total_word_count,
  avg_fidelity_score
FROM v_mind_content_stats
WHERE display_name = 'Adriano Marqui';

SELECT
  parent.title as modulo,
  COUNT(child.id) as num_licoes,
  ROUND(SUM((child.metadata->>'duration_minutes')::numeric), 0) as total_minutos
FROM contents parent
LEFT JOIN contents child ON child.parent_content_id = parent.id
WHERE parent.content_type = 'course_module'
  AND parent.project_id = '2518103d-93af-4d0a-874b-9b164974fb0e'
GROUP BY parent.id, parent.title
ORDER BY parent.sequence_order;

-- ════════════════════════════════════════════════════════════════════════════════
-- FIM FASE 2
-- ════════════════════════════════════════════════════════════════════════════════
