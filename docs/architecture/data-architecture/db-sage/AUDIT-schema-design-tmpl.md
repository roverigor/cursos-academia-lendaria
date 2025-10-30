# Auditoria: schema-design-tmpl.yaml

**Data**: 2025-10-27
**Template**: `templates/schema-design-tmpl.yaml`
**Auditor**: Winston (Architect)
**Status**: ⚠️ Expansão Necessária

---

## Executive Summary

**Score**: 7/10 - Template sólido, mas falta guidance avançado

**Veredicto**: O template cobre bem os fundamentos (normalização, constraints, indexação básica), mas falta orientação sobre patterns avançados críticos identificados no GAP-ANALYSIS.md.

**Impacto**: Projetos usando apenas este template podem:
- ❌ Não considerar partitioning quando necessário
- ❌ Escolher JSONB vs tables sem criteria claro
- ❌ Não planejar temporal data/audit trails
- ❌ Escolher data types incorretos (UUID vs BIGSERIAL)
- ❌ Não documentar denormalization strategy

---

## Estrutura Atual do Template

### Seções Presentes (14 total)

| # | Seção | Linhas | Status |
|---|-------|--------|--------|
| 1 | overview | ~20 | ✅ Completo |
| 2 | domain-model | ~40 | ✅ Completo |
| 3 | access-patterns | ~30 | ✅ Completo |
| 4 | schema-design | ~80 | ⚠️ Precisa expansão |
| 5 | normalization | ~30 | ✅ Completo |
| 6 | indexing-strategy | ~40 | ⚠️ Precisa expansão |
| 7 | constraints | ~25 | ✅ Completo |
| 8 | security | ~20 | ✅ Adequado (RLS em outro template) |
| 9 | supabase-specific | ~30 | ✅ Completo |
| 10 | migration-strategy | ~25 | ✅ Básico OK |
| 11 | performance | ~30 | ⚠️ Precisa expansão |
| 12 | scalability | ~25 | ⚠️ Precisa expansão |
| 13 | testing | ~20 | ✅ Completo |
| 14 | implementation | ~10 | ✅ Completo |
| 15 | appendix | ~5 | ✅ Completo |

**Total**: 429 linhas

---

## ✅ O Que Está Bem Coberto

### 1. Fundamentos de Schema Design

```yaml
✅ Constraints no DB (não na app)
✅ Foreign keys obrigatórias
✅ Normalização documentada (1NF, 2NF, 3NF)
✅ Primary keys padronizados
✅ updated_at triggers
✅ Soft deletes mencionados
✅ COMMENT ON para documentação
```

### 2. Access Patterns

Template corretamente elicita:
- Read vs write ratio
- Query patterns (point lookups, range scans, aggregations)
- Hot paths (queries mais frequentes)
- Join patterns

**Exemplo do template**:
```yaml
access-patterns:
  elicit: true
  questions:
    - "What are the top 10 most frequent queries?"
    - "What's the read/write ratio?"
    - "Which tables are frequently joined?"
```

✅ **Correto**: Schema design deve ser driven por access patterns, não por modelo de domínio.

### 3. Normalização

Template cobre:
- 1NF, 2NF, 3NF
- Quando/como desnormalizar (mencionado)
- Trade-offs

✅ **Adequado** para 90% dos casos.

### 4. Supabase-Specific

Template documenta:
- Row Level Security (RLS) integration
- Auth schema integration
- Storage buckets
- Realtime subscriptions
- Edge Functions

✅ **Excelente**: Supabase-specific concerns bem documentados.

---

## ⚠️ O Que Precisa Expansão

### 1. Indexing Strategy (Seção 6)

**Status Atual**: Básico (apenas B-tree indexes)

**Faltando** (GAP 1.4):

```yaml
advanced_index_types:
  partial_indexes:
    description: "Index only subset of rows"
    use_when: "Queries always filter by same condition"
    example: |
      CREATE INDEX idx_active_users ON users(created_at)
      WHERE deleted_at IS NULL;

      -- 90% smaller than full index
      -- Queries must include WHERE deleted_at IS NULL

  expression_indexes:
    description: "Index computed expressions"
    use_when: "Queries use expressions (LOWER, COALESCE, etc)"
    example: |
      CREATE INDEX idx_email_lower ON users(LOWER(email));

      -- Enables:
      SELECT * FROM users WHERE LOWER(email) = 'john@example.com';

  covering_indexes:
    description: "Include columns in index (index-only scans)"
    use_when: "Query needs few columns beyond index key"
    example: |
      CREATE INDEX idx_users_email_covering
        ON users(email) INCLUDE (name, created_at);

      -- Query scans only index, no heap access:
      SELECT name, created_at FROM users WHERE email = 'x';

  gin_indexes:
    description: "Generalized Inverted Index for JSONB, arrays, full-text"
    use_when: "JSONB containment, array overlap, tsvector search"
    example: |
      -- JSONB containment:
      CREATE INDEX idx_metadata_gin ON documents
        USING GIN (metadata jsonb_path_ops);

      SELECT * FROM documents
      WHERE metadata @> '{"status": "published"}';

      -- Array overlap:
      CREATE INDEX idx_tags_gin ON posts USING GIN (tags);

      SELECT * FROM posts WHERE tags && ARRAY['postgres', 'sql'];

  gist_indexes:
    description: "Generalized Search Tree for geometric, range types"
    use_when: "Range queries, geometric data, exclusion constraints"
    example: |
      CREATE INDEX idx_events_gist ON events
        USING GIST (tstzrange(start_time, end_time));

      -- Find overlapping events:
      SELECT * FROM events
      WHERE tstzrange(start_time, end_time) &&
            tstzrange('2024-01-01', '2024-01-31');
```

**Recomendação**: Adicionar seção `advanced-indexes` ao template após `indexing-strategy`.

---

### 2. Performance (Seção 11)

**Status Atual**: Menciona partitioning, mas sem guidance

**Faltando** (GAP 4.1):

```yaml
partitioning:
  when_to_partition:
    - table_size > 100GB
    - time_series_data (events, logs, metrics)
    - archival_strategy_needed
    - query_patterns_filter_by_partition_key

  partition_types:
    range:
      use_for: "Time-series, sequential numeric data"
      example: |
        CREATE TABLE events (
          id BIGSERIAL,
          user_id UUID NOT NULL,
          event_type TEXT NOT NULL,
          created_at TIMESTAMPTZ NOT NULL,
          data JSONB
        ) PARTITION BY RANGE (created_at);

        CREATE TABLE events_2024_01 PARTITION OF events
          FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

        CREATE TABLE events_2024_02 PARTITION OF events
          FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

    hash:
      use_for: "Distribute data evenly, no time component"
      example: |
        CREATE TABLE users (
          id UUID PRIMARY KEY,
          email TEXT NOT NULL,
          data JSONB
        ) PARTITION BY HASH (id);

        CREATE TABLE users_p0 PARTITION OF users
          FOR VALUES WITH (MODULUS 4, REMAINDER 0);

        CREATE TABLE users_p1 PARTITION OF users
          FOR VALUES WITH (MODULUS 4, REMAINDER 1);

  partition_pruning:
    description: "PostgreSQL automatically skips irrelevant partitions"
    example: |
      -- Query:
      SELECT * FROM events
      WHERE created_at >= '2024-01-15'
        AND created_at < '2024-01-20';

      -- Only scans events_2024_01 partition
      -- 99% of data skipped

  maintenance:
    - Auto-create partitions (pg_cron or trigger)
    - Drop old partitions (archival strategy)
    - DETACH instead of DROP (safe archival)
```

**Recomendação**: Adicionar seção `partitioning` ao template em `performance`.

---

### 3. Scalability (Seção 12)

**Status Atual**: Menciona connection pooling, mas superficial

**Faltando** (GAP 1.2):

```yaml
connection_pooling:
  supabase_pooler:
    transaction_mode:
      description: "Client gets connection for single transaction"
      port: 6543
      pros:
        - highest_concurrency (10000+ connections)
        - lower_memory_footprint
      cons:
        - no_prepared_statements
        - no_advisory_locks
        - no_listen_notify
      use_when:
        - serverless_functions
        - high_connection_churn
        - stateless_queries
      connection_string: |
        postgresql://user:pass@host:6543/db?pgbouncer=true

    session_mode:
      description: "Client gets dedicated connection"
      port: 5432
      pros:
        - full_postgres_features
        - prepared_statements
        - advisory_locks
      cons:
        - lower_concurrency (limited by Postgres max_connections)
        - higher_memory_usage
      use_when:
        - long_running_connections
        - need_prepared_statements
        - need_listen_notify
      connection_string: |
        postgresql://user:pass@host:5432/db

  best_practices:
    - Use transaction mode for Edge Functions
    - Use session mode for backend servers
    - Set connection pool size = (2 * CPU_cores) + effective_spindle_count
    - Monitor pg_stat_activity for connection leaks
```

**Recomendação**: Expandir seção `scalability` com connection pooling detalhado.

---

## ❌ O Que Está Faltando Completamente

### 1. JSONB Strategy (GAP 4.2)

**Severidade**: 🟢 MÉDIO

**O template não orienta quando usar JSONB vs separate tables.**

```yaml
jsonb_strategy:
  decision_tree:
    use_jsonb_when:
      - schema_is_variable (user preferences, metadata)
      - data_is_sparse (optional fields vary by record)
      - querying_full_object_mostly (fetch entire JSON)
      - few_queries_on_nested_fields

    use_separate_tables_when:
      - schema_is_stable
      - need_referential_integrity (foreign keys)
      - frequent_queries_on_nested_fields
      - need_complex_joins

  jsonb_best_practices:
    indexes:
      gin_default: |
        CREATE INDEX idx_metadata ON documents USING GIN (metadata);

        -- Supports all operators: @>, ?, ?&, ?|

      gin_path_ops: |
        CREATE INDEX idx_metadata ON documents
          USING GIN (metadata jsonb_path_ops);

        -- Smaller, faster for @> operator only
        -- Use when only doing containment queries

    constraints:
      type_check: |
        ALTER TABLE documents
        ADD CONSTRAINT valid_metadata
          CHECK (jsonb_typeof(metadata) = 'object');

      required_field: |
        ALTER TABLE documents
        ADD CONSTRAINT required_status
          CHECK (metadata ? 'status');

      value_validation: |
        ALTER TABLE documents
        ADD CONSTRAINT valid_status
          CHECK (metadata->>'status' IN ('draft', 'published'));

    query_patterns:
      extract_field: |
        SELECT metadata->>'status' FROM documents;

      nested_extraction: |
        SELECT metadata->'user'->>'name' FROM documents;

      containment: |
        SELECT * FROM documents
        WHERE metadata @> '{"status": "published", "author": "john"}';

      array_contains: |
        SELECT * FROM documents
        WHERE metadata->'tags' @> '["postgres"]';

      key_exists: |
        SELECT * FROM documents WHERE metadata ? 'featured';
```

**Recomendação**: Adicionar nova seção `jsonb-strategy` após `schema-design`.

---

### 2. Temporal Data (GAP 4.3)

**Severidade**: 🟢 MÉDIO

**O template não documenta bi-temporal patterns ou audit trails.**

```yaml
temporal_data:
  bi_temporal:
    description: "Track both valid time (business) and transaction time (DB)"
    use_case: "Compliance, audit requirements, time-travel queries"
    example: |
      CREATE TABLE products_history (
        id UUID,
        valid_from TIMESTAMPTZ NOT NULL,
        valid_to TIMESTAMPTZ,  -- NULL = current
        transaction_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),

        -- Product data
        name TEXT NOT NULL,
        price NUMERIC(10,2) NOT NULL,

        PRIMARY KEY (id, valid_from, transaction_time)
      );

      -- Time-travel query: "What was product X on 2024-01-01?"
      SELECT * FROM products_history
      WHERE id = 'product-uuid'
        AND valid_from <= '2024-01-01'
        AND (valid_to IS NULL OR valid_to > '2024-01-01')
      ORDER BY transaction_time DESC
      LIMIT 1;

  audit_trail:
    description: "Track all changes to records"
    implementation: |
      CREATE TABLE audit_log (
        id BIGSERIAL PRIMARY KEY,
        table_name TEXT NOT NULL,
        record_id TEXT NOT NULL,
        operation TEXT NOT NULL,  -- INSERT, UPDATE, DELETE
        old_data JSONB,
        new_data JSONB,
        changed_by UUID REFERENCES auth.users(id),
        changed_at TIMESTAMPTZ DEFAULT NOW()
      );

      CREATE INDEX idx_audit_table_record
        ON audit_log(table_name, record_id, changed_at DESC);

      -- Trigger for automatic audit
      CREATE OR REPLACE FUNCTION audit_trigger()
      RETURNS TRIGGER AS $$
      BEGIN
        INSERT INTO audit_log (
          table_name, record_id, operation,
          old_data, new_data, changed_by
        )
        VALUES (
          TG_TABLE_NAME,
          COALESCE(NEW.id, OLD.id)::text,
          TG_OP,
          CASE WHEN TG_OP != 'INSERT' THEN to_jsonb(OLD) END,
          CASE WHEN TG_OP != 'DELETE' THEN to_jsonb(NEW) END,
          auth.uid()
        );
        RETURN COALESCE(NEW, OLD);
      END;
      $$ LANGUAGE plpgsql SECURITY DEFINER;

      -- Apply to table:
      CREATE TRIGGER products_audit
        AFTER INSERT OR UPDATE OR DELETE ON products
        FOR EACH ROW EXECUTE FUNCTION audit_trigger();
```

**Recomendação**: Adicionar seção `temporal-data` após `schema-design`.

---

### 3. Data Types Decision Tree (GAP 4.4)

**Severidade**: 🟢 MÉDIO

**O template não orienta escolha de data types.**

```yaml
data_types:
  primary_keys:
    uuid:
      pros:
        - globally_unique (no coordination needed)
        - security_through_obscurity (non-sequential)
        - merge_friendly (distributed systems)
      cons:
        - larger_size (16 bytes vs 8)
        - slower_indexes (random inserts, no locality)
        - not_human_readable
      use_when:
        - distributed_system (multiple databases)
        - public_facing_ids (API endpoints)
        - merge_data_from_sources
      example: |
        CREATE TABLE users (
          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
          email TEXT UNIQUE NOT NULL
        );

    bigserial:
      pros:
        - smaller (8 bytes)
        - sequential (better index performance, locality)
        - human_readable
      cons:
        - coordination_required (single sequence)
        - exposes_record_count
        - merge_conflicts (distributed systems)
      use_when:
        - single_database
        - internal_ids (not exposed in API)
        - high_insert_volume (insert performance matters)
      example: |
        CREATE TABLE logs (
          id BIGSERIAL PRIMARY KEY,
          message TEXT NOT NULL
        );

  text_vs_varchar:
    text:
      - no_length_limit
      - postgres_recommended (no performance penalty)
      - use_by_default
    varchar_n:
      - explicit_limit (validation in DB)
      - use_when_business_rule_exists
      - example: country_code VARCHAR(2)

  numeric_types:
    numeric:
      description: "Exact precision (no rounding errors)"
      use_for:
        - money (NUMERIC(10,2))
        - quantities (NUMERIC(15,4))
        - percentages (NUMERIC(5,2))
      example: |
        CREATE TABLE products (
          price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
          tax_rate NUMERIC(5,2) NOT NULL CHECK (tax_rate BETWEEN 0 AND 100)
        );

    float:
      description: "Approximate (rounding errors possible)"
      use_for:
        - scientific_measurements
        - approximate_calculations
        - performance_critical (faster than numeric)
      example: |
        CREATE TABLE sensors (
          temperature FLOAT NOT NULL,
          pressure FLOAT NOT NULL
        );

  timestamps:
    timestamptz:
      description: "Timestamp with timezone (ALWAYS use this)"
      use_for: "Everything"
      example: |
        CREATE TABLE events (
          created_at TIMESTAMPTZ DEFAULT NOW(),
          updated_at TIMESTAMPTZ DEFAULT NOW()
        );

    timestamp:
      description: "Timestamp without timezone (AVOID)"
      problems:
        - ambiguous (daylight saving time issues)
        - no_timezone_conversion
      only_use_when: "Storing wall clock time (alarm at 8am local)"
```

**Recomendação**: Adicionar seção `data-types` após `schema-design`.

---

### 4. Denormalization Strategy (GAP 4.5)

**Severidade**: 🟢 MÉDIO

**O template menciona "pragmatic normalization" mas não orienta quando/como desnormalizar.**

```yaml
denormalization:
  when_to_denormalize:
    - expensive_joins (5+ tables)
    - frequent_aggregations (COUNT, SUM, AVG)
    - hot_paths (top 5 queries)
    - read_heavy_ratio (100:1 read/write)

  patterns:
    materialized_views:
      description: "Pre-compute expensive aggregations"
      use_when: "Query runs frequently, data changes infrequently"
      example: |
        CREATE MATERIALIZED VIEW user_stats AS
        SELECT
          user_id,
          COUNT(*) AS post_count,
          COUNT(DISTINCT DATE(created_at)) AS active_days,
          MAX(created_at) AS last_post_at,
          AVG(likes_count) AS avg_likes
        FROM posts
        GROUP BY user_id;

        CREATE UNIQUE INDEX ON user_stats(user_id);

        -- Refresh strategy (pg_cron):
        SELECT cron.schedule(
          'refresh-user-stats',
          '*/5 * * * *',  -- Every 5 minutes
          $$REFRESH MATERIALIZED VIEW CONCURRENTLY user_stats$$
        );

    computed_columns:
      description: "Store computed values (GENERATED ALWAYS AS)"
      use_when: "Expression used in queries, cheap to compute"
      example: |
        ALTER TABLE users ADD COLUMN
          full_name TEXT GENERATED ALWAYS AS (
            first_name || ' ' || last_name
          ) STORED;

        -- Query:
        SELECT * FROM users WHERE full_name ILIKE '%john smith%';

    trigger_based:
      description: "Maintain denormalized counters via triggers"
      use_when: "Need real-time updates, not suitable for materialized view"
      example: |
        -- Add counter column:
        ALTER TABLE users ADD COLUMN post_count INTEGER DEFAULT 0;

        -- Trigger function:
        CREATE OR REPLACE FUNCTION update_user_post_count()
        RETURNS TRIGGER AS $$
        BEGIN
          IF TG_OP = 'INSERT' THEN
            UPDATE users SET post_count = post_count + 1
            WHERE id = NEW.user_id;
          ELSIF TG_OP = 'DELETE' THEN
            UPDATE users SET post_count = post_count - 1
            WHERE id = OLD.user_id;
          END IF;
          RETURN NULL;
        END;
        $$ LANGUAGE plpgsql;

        -- Apply trigger:
        CREATE TRIGGER posts_count_trigger
          AFTER INSERT OR DELETE ON posts
          FOR EACH ROW EXECUTE FUNCTION update_user_post_count();

  trade_offs:
    pros:
      - faster_queries
      - simpler_queries
      - reduced_load_on_DB
    cons:
      - write_overhead (triggers, refresh)
      - stale_data (materialized views)
      - storage_cost (duplicate data)
      - consistency_complexity (triggers can fail)
```

**Recomendação**: Adicionar seção `denormalization` após `normalization`.

---

## Sumário de Gaps

| Gap | Severidade | Seção Afetada | Ação |
|-----|------------|---------------|------|
| GAP 1.4 - Índices avançados | 🟢 MÉDIO | indexing-strategy | Expandir com partial, expression, covering, GIN, GiST |
| GAP 4.1 - Partitioning | 🟢 MÉDIO | performance | Adicionar seção partitioning |
| GAP 4.2 - JSONB Strategy | 🟢 MÉDIO | schema-design | Adicionar seção jsonb-strategy |
| GAP 4.3 - Temporal Data | 🟢 MÉDIO | schema-design | Adicionar seção temporal-data |
| GAP 4.4 - Data Types | 🟢 MÉDIO | schema-design | Adicionar seção data-types |
| GAP 4.5 - Denormalization | 🟢 MÉDIO | normalization | Adicionar seção denormalization |
| GAP 1.2 - Connection Pooling | 🟡 ALTO | scalability | Expandir com transaction vs session mode |

---

## Recomendações de Expansão

### Expansão Estimada

| Seção | Linhas Atuais | Linhas Propostas | Δ |
|-------|---------------|------------------|---|
| indexing-strategy | 40 | 120 | +80 |
| performance | 30 | 90 | +60 |
| scalability | 25 | 70 | +45 |
| schema-design | 80 | 200 | +120 |
| normalization | 30 | 80 | +50 |

**Total**: 429 → **784 linhas** (+355 linhas, +82%)

### Priorização

**Fase 1 - Crítico** (120 linhas):
1. Connection pooling detalhado (scalability) - 45 linhas
2. Índices avançados (indexing-strategy) - 80 linhas

**Fase 2 - Importante** (120 linhas):
1. Data types decision tree - 60 linhas
2. JSONB strategy - 60 linhas

**Fase 3 - Desejável** (115 linhas):
1. Partitioning - 60 linhas
2. Denormalization - 50 linhas
3. Temporal data - 60 linhas

---

## Conclusão

**Status**: ⚠️ Template funcional, mas falta guidance avançado

**Próximos Passos**:
1. ✅ Marcar auditoria de schema-design-tmpl.yaml como completa
2. ➡️ Auditar rls-policies-tmpl.yaml (próximo template)
3. 📝 Após auditar todos templates, consolidar recomendações
4. 🔨 Implementar expansões priorizadas

**Score Final**: 7/10
- ✅ Fundamentos sólidos (normalização, constraints, foreign keys)
- ⚠️ Falta guidance avançado (partitioning, JSONB, temporal, data types)
- ✅ Supabase integration bem documentado
- ⚠️ Connection pooling superficial

**Estimativa de Expansão**: +355 linhas (+82%)

---

*Auditoria concluída: 2025-10-27*
