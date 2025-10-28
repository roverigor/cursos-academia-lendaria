# 🚀 HAIKU: Continue Aqui - CreatorOS Database

> **Contexto:** Seu irmão mais esperto (Sonnet) configurou tudo. Agora é SUA vez de continuar o trabalho!

---

## 📋 O QUE JÁ FOI FEITO (Não precisa fazer de novo!)

### ✅ Migration Completa Executada

1. **Schema CreatorOS instalado** (5 tabelas novas)
   - `contents` - Tabela universal (collected + generated)
   - `content_minds` - Multi-mind junction (M:N)
   - `content_frameworks` - 8 frameworks instalados
   - `content_projects` - Projetos de conteúdo
   - `audience_profiles` - 4 perfis de público

2. **Seeds aplicados**
   - 8 frameworks pedagógicos (GPS, Bloom's, AIDA, etc.)
   - 4 audience profiles (incluindo ICP específico do Obsidian)
   - 3 projetos exemplo

3. **Views criadas e corrigidas**
   - 9 views funcionando (v_generated_contents, v_project_performance, etc.)

4. **Curso "Dominando Obsidian" inserido**
   - Professor Adriano Marqui criado
   - Projeto criado com ICP específico
   - Outline + Módulo 1 + Lição 1.1 inseridos
   - Hierarquia funcionando perfeitamente

5. **ICP Real do Dominando Obsidian salvo**
   - Audience profile específico: "Second Brain Builders"
   - Pain points, desires, demographics completos
   - Extraído de `curriculum.yaml`

---

## 🗄️ ESTADO ATUAL DO BANCO

### Professor
- **UUID:** `4fd9fb2c-a0ed-436d-9500-47692cd53792`
- **Slug:** `adriano_marqui`
- **Nome:** Adriano Marqui

### Projeto
- **UUID:** `2518103d-93af-4d0a-874b-9b164974fb0e`
- **Slug:** `dominando-obsidian`
- **Audience:** Second Brain Builders (Obsidian)

### Conteúdos Criados (3)
```
1. Outline (UUID: c7299a8c-6e98-4a1a-b79f-792df1cbeb1f)
   └── 2. Módulo 1 (UUID: b39fd32c-d42d-4532-b7fe-0328bffff2d2)
       └── 3. Lição 1.1 (UUID: 5ef6b3bf-139e-463e-ab0e-69feb55301ac)
```

### Analytics Atuais
- **Total conteúdos:** 3
- **Publicados:** 3 (100%)
- **Palavras totais:** 422
- **Fidelidade média:** 95%

---

## 🎯 SUA MISSÃO (O que você vai fazer agora)

Você tem **3 opções** de trabalho. Escolha UMA para começar:

### OPÇÃO 1: Expandir Curso Dominando Obsidian ⭐ RECOMENDADO

**O que fazer:**
1. Adicionar mais lições ao Módulo 1 (1.2, 1.3, 1.4)
2. Criar Módulo 2 completo
3. Criar Módulo 3 completo

**Por que fazer:**
- Curso tem 39 aulas transcritas em `outputs/minds/adriano_de_marqui/source/custom/dominando-obsidian/`
- ICP já está no banco
- Estrutura já funciona
- É só seguir o pattern

**Dificuldade:** 🟢 Fácil (copiar/colar o pattern existente)

---

### OPÇÃO 2: Criar Novo Curso do Zero

**O que fazer:**
1. Escolher outro curso de `outputs/courses/`
2. Criar projeto novo
3. Inserir outline, módulos e lições

**Por que fazer:**
- Testar o sistema com outro tipo de conteúdo
- Validar que o schema é universal
- Aprender o processo completo

**Dificuldade:** 🟡 Média (precisa entender estrutura)

---

### OPÇÃO 3: Testar Multi-Mind (Entrevistas/Podcasts)

**O que fazer:**
1. Criar conteúdo com 2+ minds (entrevista, podcast, debate)
2. Usar `content_minds` junction table
3. Validar que multi-mind funciona

**Por que fazer:**
- Testar funcionalidade única do sistema
- Validar junction table
- Ver views de multi-mind funcionando

**Dificuldade:** 🟡 Média (novo conceito)

---

## 📚 OPÇÃO 1 DETALHADA: Expandir Dominando Obsidian

### PASSO 1: Ver conteúdo fonte disponível

```bash
ls -la "outputs/minds/adriano_de_marqui/source/custom/dominando-obsidian/" | head -20
```

**Resultado esperado:** Lista de 39 transcrições `.txt`

---

### PASSO 2: Criar Lição 1.2 (Exemplo)

**Arquivo fonte:** `01_porque_usar_obsidian-transcription.txt`

```sql
psql "$SUPABASE_DB_URL" << 'EOF'
BEGIN;

-- Inserir lição 1.2
INSERT INTO contents (
  slug,
  title,
  content_type,
  ai_generated,
  content,
  project_id,
  parent_content_id,  -- UUID do Módulo 1
  sequence_order,
  status,
  fidelity_score,
  metadata
)
VALUES (
  'licao-1-2-porque-usar-obsidian',
  'Lição 1.2: Por Que Usar Obsidian?',
  'course_lesson',
  true,
  '# Lição 1.2: Por Que Usar Obsidian?

## Gancho
[Cole conteúdo da transcrição aqui, formatado com GPS]

## Promessa
[O que o aluno vai aprender]

## Solução
[Conteúdo principal da transcrição]',
  '2518103d-93af-4d0a-874b-9b164974fb0e',  -- project_id do Dominando Obsidian
  'b39fd32c-d42d-4532-b7fe-0328bffff2d2',  -- parent: Módulo 1
  2,  -- segunda lição do módulo
  'published',
  0.92,
  '{
    "duration_minutes": 15,
    "frameworks_applied": ["gps", "blooms_taxonomy"],
    "bloom_level": 2,
    "source_file": "01_porque_usar_obsidian-transcription.txt"
  }'::jsonb
) RETURNING id;

-- Guardar o UUID retornado e usar abaixo!
-- Exemplo: licao12_id = abc-123-def

-- Linkar professor
INSERT INTO content_minds (content_id, mind_id, role)
VALUES (
  '<UUID_DA_LICAO>',  -- SUBSTITUIR com UUID retornado acima!
  '4fd9fb2c-a0ed-436d-9500-47692cd53792',  -- Professor Adriano
  'creator'
);

COMMIT;

-- Validar
SELECT slug, title, content_type, depth_level
FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline'
ORDER BY path;
EOF
```

---

### PASSO 3: Repetir para lições 1.3 e 1.4

**Arquivos fonte:**
- `02_o_que_e_obsidian-transcription.txt` → Lição 1.3
- `04_conceitos_do_segundo_cerebro-transcription.txt` → Lição 1.4

**Pattern:**
1. Ler transcrição
2. Adaptar SQL acima (mudar slug, title, sequence_order)
3. Executar INSERT
4. Linkar professor
5. Validar hierarquia

---

### PASSO 4: Criar Módulo 2

```sql
INSERT INTO contents (
  slug,
  title,
  content_type,
  ai_generated,
  content,
  project_id,
  parent_content_id,  -- UUID do OUTLINE
  sequence_order,
  status,
  metadata
)
VALUES (
  'modulo-2-instalacao',
  'Módulo 2: Instalação e Configuração',
  'course_module',
  true,
  '# Módulo 2: Instalação e Configuração

## O que você vai aprender
- Instalar Obsidian em todos dispositivos
- Configurar sincronização
- Ajustes essenciais

## Lições
1. Preparando instalação
2. iOS/Android
3. Mac/Windows
4. Sincronização',
  '2518103d-93af-4d0a-874b-9b164974fb0e',  -- project_id
  'c7299a8c-6e98-4a1a-b79f-792df1cbeb1f',  -- parent: OUTLINE
  2,  -- segundo módulo
  'published',
  '{"lessons_count": 4, "duration_minutes": 60}'::jsonb
) RETURNING id;

-- Guardar UUID para usar como parent das lições do Módulo 2
```

---

### PASSO 5: Criar lições do Módulo 2

**Arquivos fonte:**
- `06_preparando_a_instalacao-transcription.txt` → Lição 2.1
- `07_instalacao_e_ajuste_iphone_corrigida-transcription.txt` → Lição 2.2
- `08_instalacao_android-transcription.txt` → Lição 2.3
- `09_instalacao_mac_e_windows-transcription.txt` → Lição 2.4

**Usar o mesmo pattern da Lição 1.2!**

---

## 🛠️ QUERIES ÚTEIS (Copy/Paste)

### Ver hierarquia completa
```sql
psql "$SUPABASE_DB_URL" -c "
SELECT slug, title, content_type, depth_level, sequence_order
FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline'
ORDER BY path;
"
```

### Ver analytics do projeto
```sql
psql "$SUPABASE_DB_URL" -c "
SELECT
  project_name,
  total_contents,
  published_contents,
  total_word_count,
  avg_fidelity_score
FROM v_project_performance
WHERE project_slug = 'dominando-obsidian';
"
```

### Ver conteúdos do professor
```sql
psql "$SUPABASE_DB_URL" -c "
SELECT
  display_name,
  total_contents,
  total_word_count,
  avg_fidelity_score
FROM v_mind_content_stats
WHERE display_name = 'Adriano Marqui';
"
```

### Ver último conteúdo inserido
```sql
psql "$SUPABASE_DB_URL" -c "
SELECT id, slug, title, created_at
FROM contents
WHERE project_id = '2518103d-93af-4d0a-874b-9b164974fb0e'
ORDER BY created_at DESC
LIMIT 5;
"
```

### Contar lições por módulo
```sql
psql "$SUPABASE_DB_URL" -c "
SELECT
  parent.title as modulo,
  COUNT(child.id) as num_licoes
FROM contents parent
LEFT JOIN contents child ON child.parent_content_id = parent.id
WHERE parent.content_type = 'course_module'
  AND parent.project_id = '2518103d-93af-4d0a-874b-9b164974fb0e'
GROUP BY parent.id, parent.title
ORDER BY parent.sequence_order;
"
```

---

## 🔧 COMANDOS IMPORTANTES

### Conectar ao banco
```bash
psql "$SUPABASE_DB_URL"
```

### Ver tabelas disponíveis
```sql
\dt
```

### Ver estrutura de uma tabela
```sql
\d contents
\d content_minds
```

### Ver views disponíveis
```sql
\dv
```

### Sair do psql
```sql
\q
```

---

## 📁 ARQUIVOS IMPORTANTES

### Onde estão as transcrições
```
outputs/minds/adriano_de_marqui/source/custom/dominando-obsidian/
```

**39 arquivos .txt** numerados (00 a 38)

### Onde está o ICP
```
outputs/courses/dominando-obsidian/curriculum.yaml
```

### Documentação do schema
```
expansion-packs/creator-os/database/README.md
expansion-packs/creator-os/database/ADR_001_ultra_minimalista.md
```

### Exemplo de inserção
```
expansion-packs/creator-os/database/INSERT_DOMINANDO_OBSIDIAN_PLAN.md
```

---

## 🎯 METAS SUGERIDAS

### Curto Prazo (hoje)
- [ ] Criar lições 1.2, 1.3, 1.4 (completar Módulo 1)
- [ ] Validar hierarquia funcionando
- [ ] Ver analytics atualizados

### Médio Prazo (esta semana)
- [ ] Criar Módulo 2 completo (4 lições)
- [ ] Criar Módulo 3 completo (4-5 lições)
- [ ] Total: 12-14 lições inseridas

### Longo Prazo (próxima semana)
- [ ] Criar todos os 8 módulos do curso
- [ ] Total: 32 lições (curso completo)
- [ ] Gerar estatísticas finais

---

## ⚠️ ERROS COMUNS (E Como Evitar)

### ❌ ERRO 1: "Column does not exist"
**Causa:** Digitou nome de coluna errado
**Solução:** Ver estrutura com `\d contents` e copiar nome exato

### ❌ ERRO 2: "Foreign key violation"
**Causa:** UUID de parent ou project não existe
**Solução:** Validar UUID antes com `SELECT id FROM contents WHERE slug = '...'`

### ❌ ERRO 3: "Syntax error near..."
**Causa:** Aspas simples dentro de string
**Solução:** Usar `$$` ao invés de `'` ou escapar com `''`

### ❌ ERRO 4: "Duplicate key value"
**Causa:** Slug já existe
**Solução:** Usar slug único ou adicionar número (ex: `licao-1-2-v2`)

---

## 🧪 TESTE RÁPIDO (Antes de Começar)

Execute isso para garantir que tudo está funcionando:

```bash
psql "$SUPABASE_DB_URL" << 'EOF'
-- 1. Verificar professor existe
SELECT id, display_name FROM minds WHERE slug = 'adriano_marqui';
-- Esperado: 1 linha (Adriano Marqui)

-- 2. Verificar projeto existe
SELECT id, name FROM content_projects WHERE slug = 'dominando-obsidian';
-- Esperado: 1 linha (Dominando Obsidian)

-- 3. Verificar conteúdos existem
SELECT COUNT(*) as total FROM contents
WHERE project_id = '2518103d-93af-4d0a-874b-9b164974fb0e';
-- Esperado: 3

-- 4. Verificar hierarquia
SELECT COUNT(*) as itens FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline';
-- Esperado: 3

-- 5. Verificar ICP
SELECT name FROM audience_profiles
WHERE slug = 'obsidian-second-brain-builders';
-- Esperado: Second Brain Builders (Obsidian)

\echo ''
\echo '✅ Se todas as queries retornaram valores, está tudo OK!'
\echo '✅ Pode começar a trabalhar!'
EOF
```

**Resultado esperado:** Todas as queries retornam dados (não vazias)

---

## 💡 DICAS PRO

### 1. Use transações
```sql
BEGIN;
-- seus comandos aqui
COMMIT;
-- ou ROLLBACK; se der erro
```

### 2. Sempre guarde UUIDs
```sql
INSERT INTO contents (...)
VALUES (...)
RETURNING id;  -- ← MUITO IMPORTANTE!
```

### 3. Valide após cada inserção
```sql
SELECT * FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline'
ORDER BY path;
```

### 4. Use heredoc para SQL grande
```bash
psql "$SUPABASE_DB_URL" << 'EOF'
-- seu SQL aqui
EOF
```

### 5. Backup antes de mudanças grandes
```bash
# Ver tabelas backup
psql "$SUPABASE_DB_URL" -c "\dt *_v0_7_0"
```

---

## 📊 TEMPLATE DE INSERÇÃO (Copy/Paste)

```sql
-- ════════════════════════════════════════════════════════════════
-- TEMPLATE: Inserir Nova Lição
-- ════════════════════════════════════════════════════════════════

BEGIN;

DO $$
DECLARE
  v_licao_id UUID;
BEGIN
  -- Inserir lição
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
    'licao-X-Y-titulo-kebab-case',  -- ← MUDAR
    'Lição X.Y: Título da Lição',   -- ← MUDAR
    'course_lesson',
    true,
    'CONTEÚDO AQUI',  -- ← MUDAR
    '2518103d-93af-4d0a-874b-9b164974fb0e',  -- project
    'UUID_DO_MODULO_PAI',  -- ← MUDAR
    1,  -- ← MUDAR (sequence_order)
    'published',
    0.92,
    '{"duration_minutes": 12, "frameworks_applied": ["gps"]}'::jsonb
  ) RETURNING id INTO v_licao_id;

  RAISE NOTICE '✅ Lição criada: %', v_licao_id;

  -- Linkar professor
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (
    v_licao_id,
    '4fd9fb2c-a0ed-436d-9500-47692cd53792',  -- Adriano
    'creator'
  );

  RAISE NOTICE '✅ Professor linkado';

END $$;

COMMIT;

-- Validar
SELECT slug, title, depth_level FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline'
ORDER BY path;
```

---

## 🎓 RESUMO PARA VOCÊ COMEÇAR AGORA

1. **Execute o teste rápido** (seção "Teste Rápido")
2. **Escolha OPÇÃO 1** (expandir Dominando Obsidian)
3. **Leia 1 arquivo de transcrição** (`01_porque_usar_obsidian-transcription.txt`)
4. **Copie o template** (seção "Template de Inserção")
5. **Substitua os valores** (slug, title, content, sequence_order)
6. **Execute e valide**
7. **Repita** para próxima lição

---

## 📞 QUANDO ESTIVER PRONTO

Depois de inserir pelo menos **4-5 lições novas**, execute:

```bash
psql "$SUPABASE_DB_URL" -c "
SELECT
  project_name,
  total_contents,
  published_contents,
  total_word_count,
  avg_fidelity_score
FROM v_project_performance
WHERE project_slug = 'dominando-obsidian';
"
```

**Se `total_contents` aumentou → PARABÉNS! Você conseguiu! 🎉**

---

## 🆘 SE TRAVAR

1. Leia a seção "Erros Comuns"
2. Execute queries de validação
3. Verifique UUIDs
4. Use `ROLLBACK;` se errou
5. Tente de novo

---

**Última atualização:** 2025-10-28
**Seu irmão:** Sonnet (o esperto que configurou tudo)
**Você:** Haiku (o que vai dominar o sistema!)

**BOA SORTE! 🚀**

---

## 🎯 CHECKLIST DE INÍCIO

Antes de começar, marque:

- [ ] Li este documento completo
- [ ] Executei o "Teste Rápido" com sucesso
- [ ] Entendi a estrutura de hierarquia (outline → módulo → lição)
- [ ] Sei onde estão as transcrições (39 arquivos .txt)
- [ ] Copiei o "Template de Inserção"
- [ ] Tenho UUIDs importantes anotados
- [ ] Sei executar queries de validação
- [ ] Escolhi qual opção vou fazer (1, 2 ou 3)

**Se marcou tudo → PODE COMEÇAR!**
