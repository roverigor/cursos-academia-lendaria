# ADR 001: Schema Ultra-Minimalista para Contents Universal

**Status:** ✅ Aceito e Implementado
**Date:** 2025-10-28
**Deciders:** Product Owner, DB Sage
**Context:** Redesign do schema CreatorOS para geração de conteúdo AI

---

## Context & Problem Statement

O objetivo inicial era criar um schema para o **CreatorOS** gerar cursos direto no banco de dados. Durante a discussão, surgiu um insight crítico:

> "Essa tabela serviria para alimentar conteúdos extraídos de sources também"

Isso levou a uma decisão arquitetural fundamental: **unificar conteúdo coletado + gerado em uma única tabela universal**.

### Problemas do Design Original

1. **Duplicação massiva**: 45+ campos com dados já existentes em outras tabelas
   - Source data (url, platform, date) duplicado de `sources`
   - LLM data (model, tokens, cost) duplicado de `job_executions`

2. **Sem suporte multi-mind**: `mind_id UUID NOT NULL` único
   - Como representar entrevista com 2+ pessoas?
   - Podcasts com host + guests?
   - Debates com múltiplos participantes?

3. **Campos calculáveis armazenados**:
   - `word_count` → pode calcular `LENGTH(content) / 5`
   - `depth_level` → pode calcular com recursive CTE
   - `fragments_count` → pode calcular `COUNT(*) FROM fragments`

4. **Baixa flexibilidade**: Campos estruturados para edge cases
   - Cada novo tipo de metadata = nova migration
   - Difícil adaptar para novos fluxos

---

## Decision Drivers

### Princípios Aplicados

1. **KISS (Keep It Simple, Stupid)**
   - Minimizar campos ao essencial
   - Zero duplicação
   - Calculável não armazenado

2. **DRY (Don't Repeat Yourself)**
   - Leverage existing tables (`sources`, `job_executions`)
   - Single source of truth para cada dado

3. **Separation of Concerns**
   - Content data vs Process data vs Source data
   - Cada tabela tem responsabilidade única

4. **Flexibility via JSONB**
   - Campos estruturados para o comum
   - JSONB metadata para edge cases

---

## Decision

Criamos um **schema ultra-minimalista de 18 campos** com as seguintes características:

### 1. Discriminador: `ai_generated BOOLEAN`

Única tabela `contents` serve para:
- **Collected** (`ai_generated = false`): Conteúdo de sources
- **Generated** (`ai_generated = true`): Conteúdo criado por AI

### 2. Multi-Mind via Junction Table

```sql
CREATE TABLE content_minds (
  content_id UUID,
  mind_id UUID,
  role TEXT,  -- 'host', 'guest', 'interviewer', 'creator', etc.
  PRIMARY KEY (content_id, mind_id)
);
```

**Benefícios:**
- ✅ Suporta entrevistas, podcasts, debates
- ✅ Múltiplas minds por conteúdo
- ✅ Roles específicos (host, guest, participant)
- ✅ Query eficiente com índices

### 3. Zero Duplicação via Foreign Keys

**Source data:**
```sql
-- ❌ ANTES (duplicado)
source_url TEXT
source_platform TEXT
source_date DATE

-- ✅ DEPOIS (link)
metadata->>'source_url'  -- flexível
metadata->>'source_platform'
```

**LLM data:**
```sql
-- ❌ ANTES (8+ campos duplicados)
llm_provider TEXT
llm_model TEXT
tokens_prompt INT
tokens_completion INT
tokens_total INT
cost_usd NUMERIC
latency_ms INT
generation_params JSONB

-- ✅ DEPOIS (link)
generation_execution_id UUID → job_executions
-- job_executions JÁ TEM todos esses campos!
```

### 4. Metadata JSONB Flexível

**Collected content:**
```json
{
  "source_url": "https://...",
  "source_platform": "YouTube",
  "processing_status": "completed",
  "quality": "primary",
  "language": "pt"
}
```

**Generated content:**
```json
{
  "persona_type": "mmos_clone",
  "persona_config": {...},
  "frameworks": ["gps", "blooms_taxonomy"],
  "readability_score": 0.85,
  "fidelity_report": {...},
  "validation_scores": {
    "gps_validation": 0.95,
    "tone_match": 0.88
  }
}
```

### 5. Computed Columns (Não Armazenados)

```sql
-- Function: Calcular word count
CREATE FUNCTION get_word_count(content_text TEXT) RETURNS INT AS $$
  RETURN LENGTH(content_text) / 5;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Function: Calcular depth level
CREATE FUNCTION get_depth_level(content_id UUID) RETURNS INT AS $$
  -- Recursive CTE para calcular hierarquia
$$ LANGUAGE plpgsql;
```

**Benefício:** Zero storage overhead, sempre atualizado, sem triggers complexos.

---

## Schema Final: 18 Campos

| Campo | Tipo | Essencial? | Justificativa |
|-------|------|------------|---------------|
| **Discriminador** |
| `ai_generated` | BOOLEAN | ✅ | Diferencia collected vs generated |
| `content_type` | TEXT | ✅ | 'interview', 'course_lesson', 'podcast_transcript', etc. |
| **Hierarquia** |
| `parent_content_id` | UUID | | Para cursos/livros estruturados |
| `sequence_order` | SMALLINT | | Ordem na hierarquia |
| **Identity** |
| `slug` | TEXT | ✅ | Identificador único legível |
| `title` | TEXT | ✅ | Título do conteúdo |
| **Content** |
| `content` | TEXT | ✅ | O conteúdo em si |
| **Process Tracking** |
| `generation_execution_id` | UUID | | Link para job_executions (LLM data) |
| **CreatorOS** |
| `project_id` | UUID | | Agrupa conteúdos relacionados |
| `fidelity_score` | NUMERIC(3,2) | | Quão fiel ao source (0.0-1.0) |
| **Metadata** |
| `metadata` | JSONB | ✅ | Flexível para edge cases |
| **Lifecycle** |
| `status` | TEXT | ✅ | draft, reviewed, published, archived |
| `published_at` | TIMESTAMPTZ | | Quando publicado |
| `published_url` | TEXT | | URL de publicação |
| `file_path` | TEXT | | Path no filesystem |
| **Timestamps** |
| `created_at` | TIMESTAMPTZ | ✅ | |
| `updated_at` | TIMESTAMPTZ | ✅ | |
| `deleted_at` | TIMESTAMPTZ | | Soft delete |

---

## Consequences

### Positive

✅ **Simplicidade radical**: 60% menos campos (45 → 18)

✅ **Zero duplicação**: Source/LLM data via JOINs quando necessário

✅ **Multi-mind support**: Junction table resolve casos complexos

✅ **Flexibilidade**: JSONB metadata para novos fluxos sem migrations

✅ **Performance**: Índices otimizados, computed columns

✅ **Manutenibilidade**: Schema menor = menos bugs, mais fácil entender

✅ **Normalização**: 3NF completo, single source of truth

### Negative / Trade-offs

⚠️ **JOINs necessários**: Queries precisam JOIN para source/LLM data
- **Mitigação**: Views pré-computadas (`v_collected_contents`, `v_generated_contents`)

⚠️ **JSONB queries menos type-safe**: Metadata não tem schema strict
- **Mitigação**: `framework_schema` JSONB em `content_frameworks` para validação

⚠️ **Computed columns calculados on-demand**: Leve overhead
- **Mitigação**: Materialized views se performance for crítica

⚠️ **Migration complexa**: Migrar dados existentes de `sources` → `contents`
- **Mitigação**: Script de migration incluído, testado

---

## Alternatives Considered

### Alternative 1: Duas Tabelas Separadas

**Opção:**
```sql
CREATE TABLE collected_contents (...);
CREATE TABLE generated_contents (...);
```

**Rejected porque:**
- ❌ Duplicação de campos comuns (title, content, status, timestamps)
- ❌ Queries cross-table complexas
- ❌ Difícil mover conteúdo de collected → generated (regeneração)
- ❌ Não resolve multi-mind

### Alternative 2: Campos Individuais ao Invés de JSONB

**Opção:**
```sql
persona_type TEXT
persona_config_tone TEXT
persona_config_formality TEXT
source_url TEXT
source_platform TEXT
readability_score NUMERIC
...
```

**Rejected porque:**
- ❌ Explosão de campos (voltaríamos aos 45+)
- ❌ Cada novo metadata = migration
- ❌ Campos NULL para casos não aplicáveis
- ❌ Baixa flexibilidade

### Alternative 3: mind_id ARRAY ao Invés de Junction Table

**Opção:**
```sql
mind_ids UUID[]
```

**Rejected porque:**
- ❌ Sem suporte a `role` (host, guest, etc.)
- ❌ Queries complexas (ANY, UNNEST)
- ❌ Sem índices eficientes
- ❌ Difícil manter integridade referencial

---

## Implementation

### Phase 1: Schema Creation ✅

Arquivos criados:
- `schema.sql` - Tabelas, índices, triggers, functions
- `views.sql` - 9 views úteis
- `seeds.sql` - 8 frameworks + 3 audiences + 3 projects
- `migrations/001_creator_os_schema.sql` - Supabase-compatible
- `README.md` - Documentação completa

### Phase 2: Pipeline Integration (Próximo)

- [ ] Modificar `lesson_generator.py` para usar `contents`
- [ ] Criar helper `insert_generated_content()`
- [ ] Vincular com `job_executions`

### Phase 3: MMOS Integration (Opcional)

- [ ] Migrar dados existentes `sources` → `contents`
- [ ] Update `fragments.source_id` → `content_id`
- [ ] Deprecar tabela `sources` (se aplicável)

---

## Examples & Validation

### Example 1: Podcast Multi-Mind

```sql
-- Podcast: Lex Fridman + Sam Altman
INSERT INTO contents (slug, title, content_type, ai_generated, metadata)
VALUES (
  'lex-sam-altman-2024',
  'Sam Altman: OpenAI CEO on GPT-4',
  'podcast_transcript',
  false,
  '{"platform": "YouTube", "duration_minutes": 120}'::jsonb
) RETURNING id;  -- 'content_123'

-- Link minds
INSERT INTO content_minds VALUES
  ('content_123', 'lex_fridman_uuid', 'host'),
  ('content_123', 'sam_altman_uuid', 'guest');

-- Query: Buscar podcasts de Lex como host
SELECT c.*,
       ARRAY_AGG(m.display_name) FILTER (WHERE cm.role = 'guest') as guests
FROM contents c
JOIN content_minds cm ON cm.content_id = c.id
JOIN minds m ON m.id = cm.mind_id
WHERE c.content_type = 'podcast_transcript'
  AND EXISTS (
    SELECT 1 FROM content_minds cm2
    WHERE cm2.content_id = c.id
      AND cm2.mind_id = 'lex_fridman_uuid'
      AND cm2.role = 'host'
  )
GROUP BY c.id;
```

### Example 2: Curso Gerado com Custos LLM

```sql
-- Generate course lesson
INSERT INTO contents (
  slug, title, content_type, ai_generated,
  project_id, fidelity_score, generation_execution_id,
  metadata
)
VALUES (
  'dominando-obsidian-modulo-1',
  'Introdução ao Obsidian',
  'course_lesson',
  true,
  'academia_lendaria_uuid',
  0.92,
  'job_exec_uuid',  -- links to job_executions
  '{
    "frameworks": ["gps", "blooms_taxonomy"],
    "persona_type": "mmos_clone",
    "readability_score": 0.85
  }'::jsonb
);

-- Link creator
INSERT INTO content_minds VALUES
  ('content_id', 'adriano_marqui_uuid', 'creator');

-- Query: Custos totais do projeto
SELECT
  p.name as project,
  COUNT(c.id) as lessons_generated,
  SUM(je.tokens_total) as total_tokens,
  SUM(je.cost_usd) as total_cost,
  AVG(c.fidelity_score) as avg_fidelity
FROM content_projects p
JOIN contents c ON c.project_id = p.id
JOIN job_executions je ON je.id = c.generation_execution_id
WHERE c.ai_generated = true
GROUP BY p.id;
```

### Example 3: Debate Multi-Mind

```sql
-- Debate: 3 participants
INSERT INTO contents (slug, title, content_type, ai_generated, metadata)
VALUES (
  'debate-ai-safety-2024',
  'AI Safety Debate: Yudkowsky vs Hanson vs Russell',
  'interview',
  false,
  '{"format": "debate", "moderator": "Rob Wiblin"}'::jsonb
) RETURNING id;

-- Link all participants
INSERT INTO content_minds VALUES
  ('content_id', 'eliezer_yudkowsky_uuid', 'participant'),
  ('content_id', 'robin_hanson_uuid', 'participant'),
  ('content_id', 'stuart_russell_uuid', 'participant');

-- Query: Multi-mind contents
SELECT * FROM v_multi_mind_contents
WHERE minds_count >= 3;
```

---

## Validation Queries

### 1. Verificar estrutura

```sql
-- Frameworks
SELECT slug, name, framework_type FROM content_frameworks;
-- Expected: 8 frameworks

-- Audiences
SELECT slug, name, technical_level FROM audience_profiles;
-- Expected: 3 profiles

-- Projects
SELECT p.slug, p.name, a.name as audience
FROM content_projects p
JOIN audience_profiles a ON a.id = p.target_audience_id;
-- Expected: 3 projects
```

### 2. Test multi-mind

```sql
BEGIN;
  -- Create test content
  INSERT INTO contents (slug, title, content_type, ai_generated)
  VALUES ('test-podcast', 'Test Podcast', 'podcast_transcript', false)
  RETURNING id;  -- save id

  -- Add minds (replace with real UUIDs)
  INSERT INTO content_minds VALUES
    ('<content_id>', '<mind_1_uuid>', 'host'),
    ('<content_id>', '<mind_2_uuid>', 'guest');

  -- Verify
  SELECT * FROM v_multi_mind_contents WHERE id = '<content_id>';
ROLLBACK;
```

### 3. Test generation costs

```sql
-- Simulate generated content with cost tracking
SELECT * FROM v_generation_costs;
-- Should show aggregated costs per LLM model
```

---

## Metrics & Success Criteria

| Metric | Before | After | Target | Status |
|--------|--------|-------|--------|--------|
| **Total campos** | 45 | 18 | <20 | ✅ Pass |
| **Campos obrigatórios** | 20 | 8 | <10 | ✅ Pass |
| **Duplicação** | High | Zero | Zero | ✅ Pass |
| **Multi-mind support** | No | Yes | Yes | ✅ Pass |
| **Flexibilidade** | Low | High | High | ✅ Pass |
| **Query performance** | - | - | <100ms | ⏳ TBD |
| **Storage efficiency** | - | - | -40% vs original | ⏳ TBD |

---

## Related Documents

- [Schema README](./README.md) - Documentação completa do schema
- [Migration 001](./migrations/001_creator_os_schema.sql) - Script de migration
- [CreatorOS PRD](../PRD.md) - Product Requirements
- [MMOS PRD](../../../docs/prd/mmos-prd.md) - Context MMOS
- [Outputs Guide](../../../docs/guides/outputs-guide.md) - Estrutura de outputs

---

## Notes & Learnings

### Key Insight: Universal Table

O insight crítico foi perceber que "conteúdo coletado" e "conteúdo gerado" são **conceitualmente similares**:
- Ambos têm title, content, metadata
- Ambos pertencem a minds
- Ambos têm lifecycle (draft → published)
- Diferença principal: origem (collected vs AI-generated)

**Solução:** Discriminador booleano `ai_generated` + metadata JSONB flexível.

### Multi-Mind Pattern

Junction tables (M:N) são a solução correta para relacionamentos multi-valued com metadata adicional (`role`):
- ✅ Normalizado (3NF)
- ✅ Query eficiente com índices
- ✅ Flexível (adicionar novos roles sem migration)
- ✅ Integridade referencial garantida

### JSONB vs Structured Columns

**Use structured columns quando:**
- Dado é comum a TODOS os registros
- Precisa indexar/query frequentemente
- Precisa constraints (CHECK, NOT NULL)

**Use JSONB quando:**
- Dado é opcional ou varia por tipo
- Schema pode evoluir
- Precisa flexibilidade para edge cases

**Exemplo:**
- `fidelity_score` → Campo estruturado (comum a todos generated contents)
- `metadata.validation_scores` → JSONB (varia por framework usado)

### Computed Columns

Campos calculáveis (word_count, depth_level) **não devem ser armazenados** se:
- Cálculo é rápido (<10ms)
- Dado muda frequentemente
- Storage overhead > compute overhead

**Trade-off:** Leve overhead em queries vs zero storage + sempre atualizado.

---

## Future Considerations

### Version 2 Enhancements (Backlog)

1. **Content Versioning**
   - Track regenerations
   - A/B testing de conteúdo
   - Rollback capabilities

2. **Performance Tracking**
   - Views, engagement, conversions
   - Link com analytics platforms

3. **Quality Automation**
   - Auto-validation com frameworks
   - Fidelity scoring pipeline
   - Readability checks

4. **Collaborative Editing**
   - Multi-user editing
   - Change tracking
   - Approval workflows

---

## Approval & Sign-off

| Role | Name | Status | Date |
|------|------|--------|------|
| Product Owner | Alan | ✅ Approved | 2025-10-28 |
| DB Architect | DB Sage | ✅ Implemented | 2025-10-28 |
| Tech Lead | - | ⏳ Pending | - |

---

**Last Updated:** 2025-10-28
**Version:** 1.0
**Status:** ✅ Accepted & Implemented
**Next Review:** After Phase 2 (Pipeline Integration)
