# Auditoria: index-strategy-tmpl.yaml

**Data**: 2025-10-27
**Template**: `templates/index-strategy-tmpl.yaml`
**Auditor**: Winston (Architect)
**Status**: ⚠️ Mencionado mas não detalhado

---

## Executive Summary

**Score**: 6/10 - Estrutura boa, mas falta guidance detalhado

**Veredicto**: Template menciona índices avançados (GIN, GiST, BRIN, partial, covering) mas **não fornece guidance** sobre quando/como usá-los. Equivalente a ter um cardápio sem descrições dos pratos.

**Impacto**: Projetos usando apenas este template:
- ✅ Sabem que índices avançados existem
- ❌ **Não sabem quando** usar partial vs expression vs covering
- ❌ **Não sabem como** criar GIN indexes para JSONB
- ❌ **Não sabem** trade-offs entre tipos de índice
- ❌ **Não têm decision tree** para escolher tipo correto

---

## Estrutura Atual

| # | Seção | Linhas | Status |
|---|-------|--------|--------|
| 1 | overview | ~6 | ⚠️ Menciona tipos, sem exemplos |
| 2 | patterns | ~8 | ✅ Bom |
| 3 | catalog | ~10 | ⚠️ Menciona partial/covering, sem exemplos |
| 4 | fulltext | ~7 | ⚠️ Menciona GIN, sem exemplos |
| 5 | maintenance | ~6 | ✅ Adequado |
| 6 | **advanced-indexes** | **0** | ❌ **AUSENTE (GAP 1.4)** |

**Total**: 54 linhas

---

## ✅ O Que Está Coberto (Mencionado)

- ✅ Overview menciona: B-Tree, GIN, GiST, BRIN, partial, covering (linha 14)
- ✅ Catalog menciona: partial indexes, covering indexes (linhas 34-36)
- ✅ Full-text menciona: GIN/Trigram (linha 43)
- ✅ Maintenance: pg_stat_user_indexes, unused indexes, reindex (linhas 50-52)

**Problema**: Tudo **mencionado** mas nada **exemplificado** ou **orientado**.

---

## ❌ O Que Está Faltando (GAP 1.4)

**Severidade**: 🟡 ALTO

### 1. Partial Indexes (sem exemplos)

**Mencionado** linha 34, mas sem guidance:

```yaml
advanced_indexes:
  partial:
    description: "Index only subset of rows (WHERE clause)"
    use_when: "Queries always filter by same condition"
    example: |
      -- Index only active users (90% smaller)
      CREATE INDEX idx_active_users ON users(created_at)
      WHERE deleted_at IS NULL;

      -- Index only recent orders (99% smaller)
      CREATE INDEX idx_recent_orders ON orders(user_id)
      WHERE created_at > NOW() - INTERVAL '90 days';

      -- Query must include WHERE clause
      SELECT * FROM users WHERE deleted_at IS NULL AND created_at > '2024-01-01';
```

### 2. Expression Indexes (não mencionado)

**Completamente ausente**:

```yaml
expression:
  description: "Index computed expressions"
  use_when: "Queries use expressions (LOWER, COALESCE, etc)"
  example: |
    -- Case-insensitive email lookup
    CREATE INDEX idx_email_lower ON users(LOWER(email));

    -- Enables:
    SELECT * FROM users WHERE LOWER(email) = 'john@example.com';

    -- Date truncation
    CREATE INDEX idx_orders_date ON orders(DATE(created_at));

    -- JSON path extraction
    CREATE INDEX idx_metadata_status ON documents((metadata->>'status'));
```

### 3. Covering Indexes (sem exemplos)

**Mencionado** linha 36, mas sem guidance:

```yaml
covering:
  description: "Include columns in index (index-only scans)"
  use_when: "Query needs few columns beyond index key"
  example: |
    -- Query: SELECT name, created_at FROM users WHERE email = 'x';
    CREATE INDEX idx_users_email_covering
      ON users(email) INCLUDE (name, created_at);

    -- Query scans only index, no heap access
    -- EXPLAIN shows: Index Only Scan
```

### 4. GIN Indexes (sem exemplos)

**Mencionado** linha 43 (full-text), mas falta JSONB/array:

```yaml
gin:
  description: "Generalized Inverted Index for JSONB, arrays, full-text"

  jsonb_containment:
    example: |
      -- JSONB containment (@>)
      CREATE INDEX idx_metadata_gin ON documents
        USING GIN (metadata jsonb_path_ops);

      SELECT * FROM documents
      WHERE metadata @> '{"status": "published"}';

  jsonb_keys:
    example: |
      -- JSONB key existence (?)
      CREATE INDEX idx_metadata_keys ON documents
        USING GIN (metadata);

      SELECT * FROM documents WHERE metadata ? 'featured';

  array_overlap:
    example: |
      -- Array overlap (&&)
      CREATE INDEX idx_tags_gin ON posts USING GIN (tags);

      SELECT * FROM posts WHERE tags && ARRAY['postgres', 'sql'];

  fulltext:
    example: |
      -- Full-text search
      CREATE INDEX idx_posts_fts ON posts USING GIN (to_tsvector('english', title || ' ' || body));

      SELECT * FROM posts
      WHERE to_tsvector('english', title || ' ' || body) @@ to_tsquery('postgres & performance');
```

### 5. GiST Indexes (sem exemplos)

**Mencionado** linha 14, sem guidance:

```yaml
gist:
  description: "Generalized Search Tree for geometric, range types"

  range_overlap:
    example: |
      -- Find overlapping events
      CREATE INDEX idx_events_gist ON events
        USING GIST (tstzrange(start_time, end_time));

      SELECT * FROM events
      WHERE tstzrange(start_time, end_time) &&
            tstzrange('2024-01-01', '2024-01-31');

  geometric:
    example: |
      -- Nearest neighbor search
      CREATE INDEX idx_locations_gist ON locations USING GIST (point);

      SELECT * FROM locations
      ORDER BY point <-> '(0,0)'::point
      LIMIT 10;

  exclusion_constraints:
    example: |
      -- Prevent overlapping bookings
      CREATE TABLE bookings (
        room_id INT,
        reserved_at tstzrange,
        EXCLUDE USING GIST (room_id WITH =, reserved_at WITH &&)
      );
```

### 6. BRIN Indexes (sem exemplos)

**Mencionado** linha 14, sem guidance:

```yaml
brin:
  description: "Block Range Index for large, naturally ordered tables"
  use_when: "Tables > 100GB with sequential data"
  example: |
    -- Time-series data (logs, events, metrics)
    CREATE INDEX idx_events_brin ON events USING BRIN (created_at);

    -- 1000x smaller than B-tree
    -- Query: WHERE created_at > NOW() - INTERVAL '7 days'

    pros:
      - tiny_size (1000x smaller than B-tree)
      - fast_inserts (no tree rebalancing)
    cons:
      - approximate (scans more rows than needed)
      - only_sequential_scans

    perfect_for:
      - append_only_logs
      - iot_sensor_data
      - time_series_metrics
```

### 7. Index Type Decision Tree (ausente)

**Crítico**: sem decision tree para escolher tipo:

```yaml
decision_tree:
  question_1: "What type of data?"
    answer_text_or_varchar:
      question: "Exact match or pattern search?"
      exact: "B-tree index"
      pattern_prefix: "B-tree + text_pattern_ops"
      pattern_any: "GIN trigram (pg_trgm)"
      fulltext: "GIN tsvector"

    answer_jsonb:
      question: "Query type?"
      containment: "GIN jsonb_path_ops"
      key_existence: "GIN"
      path_extraction: "B-tree expression index"

    answer_array:
      question: "Query type?"
      element_search: "GIN"
      exact_match: "B-tree"

    answer_numeric_or_date:
      question: "Table size and data pattern?"
      small_table: "B-tree"
      large_sequential: "BRIN (1000x smaller)"
      large_random: "B-tree"

    answer_range_type:
      overlap_queries: "GiST"
      exact_match: "B-tree"

    answer_geometric:
      nearest_neighbor: "GiST"
      exact_match: "B-tree"

  optimization_questions:
    query_always_filters_same_way: "Use partial index"
    query_uses_expressions: "Use expression index"
    query_needs_few_extra_columns: "Use covering index (INCLUDE)"
```

---

## Expansão Necessária

| Componente | Linhas Atuais | Linhas Propostas | Δ |
|------------|---------------|------------------|---|
| advanced-indexes | 0 | 200 | +200 |
| decision-tree | 0 | 60 | +60 |

**Total**: 54 → **314 linhas** (+260 linhas, +481%)

---

## Conclusão

**Status**: ⚠️ Awareness OK, guidance faltando

**Score**: 6/10
- ✅ Menciona todos tipos de índice
- ✅ Estrutura boa (access patterns → catalog → maintenance)
- ❌ Zero exemplos práticos
- ❌ Zero guidance sobre quando usar cada tipo
- ❌ Decision tree ausente

**Recomendação**: Adicionar seção `advanced-indexes` com 200+ linhas de exemplos práticos (GAP 1.4).

**Estimativa de Expansão**: +260 linhas (+481%)

---

*Auditoria concluída: 2025-10-27*
