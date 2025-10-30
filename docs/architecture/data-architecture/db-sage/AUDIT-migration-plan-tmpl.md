# Auditoria: migration-plan-tmpl.yaml

**Data**: 2025-10-27
**Template**: `templates/migration-plan-tmpl.yaml`
**Auditor**: Winston (Architect)
**Status**: 🔴 Gaps Críticos - Não Production-Ready

---

## Executive Summary

**Score**: 5/10 - Fundamentos OK, mas faltam features críticas para produção

**Veredicto**: Template cobre planejamento básico de migrations (change set, dependencies, safety, testing), mas **falha criticamente** em:
- ❌ Schema version tracking ausente (GAP 1.1 - CRÍTICO)
- ❌ Zero-downtime migrations não documentado (GAP 3.1 - CRÍTICO)

**Impacto**: Projetos usando apenas este template:
- ❌ **Não podem rastrear quem aplicou migrations** (sem audit trail)
- ❌ **Não podem validar integridade** (sem checksums)
- ❌ **Causam downtime obrigatório** (todas migrations requerem parada)
- ❌ **Não suportam expand/contract pattern**
- ✅ Têm rollback strategy (básico)
- ✅ Têm testing strategy (smoke tests)

**Recomendação**: ⚠️ **NÃO usar em produção sem implementar GAPs 1.1 e 3.1.**

---

## Estrutura Atual do Template

### Seções Presentes (8 total)

| # | Seção | Linhas | Status |
|---|-------|--------|--------|
| 1 | summary | ~7 | ✅ Completo |
| 2 | change-set | ~9 | ✅ Completo |
| 3 | dependencies | ~11 | ✅ Bom |
| 4 | data-migration | ~10 | ⚠️ Falta batching avançado |
| 5 | safety | ~9 | ⚠️ **Falta version tracking** |
| 6 | testing | ~9 | ✅ Adequado |
| 7 | operations | ~10 | ✅ Bom |
| 8 | communication | ~8 | ✅ Completo |
| 9 | **version-tracking** | **0** | ❌ **AUSENTE (GAP 1.1)** |
| 10 | **zero-downtime** | **0** | ❌ **AUSENTE (GAP 3.1)** |

**Total**: 93 linhas (muito básico para produção)

---

## ✅ O Que Está Bem Coberto

### 1. Executive Summary (Seção 1)

✅ **Bom planejamento** (linhas 10-17):
- Objetivo e escopo
- Risk level (Low/Med/High)
- Environments impacted
- Migration time window
- Rollback window

### 2. Change Set (Seção 2)

✅ **Detalhamento completo** (linhas 19-28):
- Tables (created/altered/dropped)
- Columns (added/modified/removed)
- Indexes (create/alter/drop)
- Functions/triggers/views
- RLS policies

### 3. Dependencies & Ordering (Seção 3)

✅ **Ordem correta** (linhas 30-41):
1. Extensions
2. Tables & constraints
3. Functions
4. Triggers
5. RLS
6. Views / MatViews

✅ **Menciona** two-phase rollout para cross-object dependencies.

### 4. Data Migration & Backfill (Seção 4)

✅ **Básico adequado** (linhas 43-51):
- Backfill queries
- Locking/impact analysis
- Batching strategy
- Verification queries

⚠️ **Faltando**: Large-scale batching (millions of rows), throttling avançado.

### 5. Safety & Rollback (Seção 5)

✅ **Rollback básico** (linhas 53-61):
- Pre-migration snapshot
- Rollback script outline
- Roll-forward strategy
- Advisory locks

⚠️ **Faltando**: Schema version tracking (crítico).

### 6. Testing Strategy (Seção 6)

✅ **Adequado** (linhas 63-71):
- Dry-run (BEGIN; ROLLBACK)
- Smoke tests
- RLS positive/negative tests
- Performance baselines (EXPLAIN)

### 7. Operational Runbook (Seção 7)

✅ **Bom** (linhas 73-83):
- Exact commands
- Snapshot procedure
- Apply migration
- Post snapshot
- Smoke tests
- Success criteria

### 8. Communication & Approval (Seção 8)

✅ **Completo** (linhas 85-92):
- Stakeholders
- Change window notice
- Post-deploy validation owners
- Incident/rollback contact

---

## ❌ O Que Está Completamente Faltando

### 1. Schema Version Tracking (GAP 1.1)

**Severidade**: 🔴 CRÍTICO

**Problema**: Template não documenta schema_migrations table customizada.

**Sem version tracking:**
- ❌ Impossível rastrear quem aplicou migration
- ❌ Sem checksums para validar integridade
- ❌ Sem rollback scripts automatizados
- ❌ Sem execution time tracking
- ❌ Sem success/failure tracking

**Solução Necessária**:

```yaml
- id: version-tracking
  title: "Schema Version Tracking"
  instruction: |
    DB Sage uses custom schema_migrations table for enhanced tracking:

    ## Setup (run once)

    ```sql
    CREATE TABLE IF NOT EXISTS public.schema_migrations (
      version TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      applied_at TIMESTAMPTZ DEFAULT NOW(),
      applied_by TEXT NOT NULL,
      execution_time_ms INTEGER,
      success BOOLEAN NOT NULL,
      checksum TEXT NOT NULL,        -- SHA256 do arquivo
      rollback_script TEXT,           -- Script de rollback
      notes TEXT,
      CONSTRAINT valid_checksum CHECK (length(checksum) = 64)
    );

    CREATE INDEX idx_migrations_applied_at
      ON schema_migrations(applied_at DESC);

    COMMENT ON TABLE schema_migrations IS
      'Custom migration tracking with checksums and rollback scripts';
    ```

    ## Migration Template

    Every migration file should:

    1. **Start with version and checksum**:
    ```sql
    -- Migration: 20251027120000_add_users_table
    -- Checksum: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
    -- Rollback: See rollback section at end

    BEGIN;

    -- Migration statements here...
    ```

    2. **Track execution**:
    ```sql
    -- Record migration start
    INSERT INTO public.schema_migrations (
      version, name, applied_by, success, checksum, rollback_script
    )
    VALUES (
      '20251027120000',
      'add_users_table',
      current_user,
      false,  -- Will update to true on success
      'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      $rollback$
        -- Rollback script here
        DROP TABLE IF EXISTS users;
      $rollback$
    );
    ```

    3. **Update on success**:
    ```sql
    -- Update to success
    UPDATE public.schema_migrations
    SET success = true, execution_time_ms = 1234
    WHERE version = '20251027120000';

    COMMIT;
    ```

    4. **Include rollback section**:
    ```sql
    -- ROLLBACK SCRIPT (DO NOT EXECUTE - stored in schema_migrations)
    -- BEGIN;
    -- DROP TABLE IF EXISTS users;
    -- DELETE FROM public.schema_migrations WHERE version = '20251027120000';
    -- COMMIT;
    ```

    ## Checksum Validation

    Generate checksum before applying migration:

    ```bash
    # Generate SHA256 checksum
    checksum=$(sha256sum migration.sql | awk '{print $1}')

    # Verify against stored checksum
    psql -c "SELECT checksum FROM schema_migrations WHERE version = '20251027120000'"
    ```

    ## Query Migration History

    ```sql
    -- Recent migrations
    SELECT version, name, applied_at, applied_by, execution_time_ms
    FROM schema_migrations
    WHERE success = true
    ORDER BY applied_at DESC
    LIMIT 10;

    -- Failed migrations
    SELECT version, name, applied_at, notes
    FROM schema_migrations
    WHERE success = false;

    -- Pending rollbacks
    SELECT version, name, rollback_script
    FROM schema_migrations
    WHERE success = true
    AND rollback_script IS NOT NULL;
    ```

    ## Integration with DB Sage Tasks

    - `db-apply-migration.md` - reads checksum, inserts into schema_migrations
    - `db-verify-order.md` - validates against schema_migrations
    - `db-rollback.md` - uses rollback_script from table
  elicit: false
```

**Recomendação**: Adicionar seção `version-tracking` após `safety` (+140 linhas).

---

### 2. Zero-Downtime Migrations (GAP 3.1)

**Severidade**: 🔴 CRÍTICO

**Problema**: Template não documenta expand/contract pattern.

**Sem zero-downtime:**
- ❌ Todas migrations requerem downtime
- ❌ Breaking changes não podem ser deployed
- ❌ Column renames causam app crashes
- ❌ Type changes requerem maintenance window

**Solução Necessária**:

```yaml
- id: zero-downtime
  title: "Zero-Downtime Migrations"
  instruction: |
    Use expand/contract pattern for non-breaking schema changes:

    ## Overview

    Zero-downtime migrations use 4 phases:

    1. **EXPAND** - Add new schema (additive only, backward compatible)
    2. **MIGRATE** - Deploy app version writing to both old and new
    3. **BACKFILL** - Migrate existing data
    4. **CONTRACT** - Remove old schema (after all apps updated)

    ## Pattern 1: Add Column

    **Safe** (no downtime required):

    ```sql
    -- PHASE 1: EXPAND
    ALTER TABLE users ADD COLUMN new_email TEXT;
    ```

    **Why safe**: Existing app ignores new column.

    ## Pattern 2: Rename Column

    **PHASE 1: EXPAND** (add new column):
    ```sql
    ALTER TABLE users ADD COLUMN new_email TEXT;

    -- Trigger to keep columns in sync
    CREATE OR REPLACE FUNCTION sync_email_columns()
    RETURNS TRIGGER AS $$
    BEGIN
      IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        NEW.new_email := COALESCE(NEW.new_email, NEW.old_email);
        NEW.old_email := COALESCE(NEW.old_email, NEW.new_email);
      END IF;
      RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER sync_email
      BEFORE INSERT OR UPDATE ON users
      FOR EACH ROW EXECUTE FUNCTION sync_email_columns();
    ```

    **PHASE 2: MIGRATE** (deploy app v2):
    ```typescript
    // App version 2 - writes to BOTH columns
    await db.query(
      'INSERT INTO users (old_email, new_email) VALUES ($1, $1)',
      [email]
    )
    ```

    **PHASE 3: BACKFILL** (migrate existing data):
    ```sql
    -- Backfill in batches (avoid long locks)
    DO $$
    DECLARE
      batch_size INT := 1000;
      total_updated INT := 0;
    BEGIN
      LOOP
        WITH batch AS (
          SELECT id FROM users
          WHERE new_email IS NULL
          LIMIT batch_size
        )
        UPDATE users
        SET new_email = old_email
        FROM batch
        WHERE users.id = batch.id;

        GET DIAGNOSTICS total_updated = ROW_COUNT;
        EXIT WHEN total_updated = 0;

        -- Log progress
        RAISE NOTICE 'Backfilled % rows', total_updated;

        -- Throttle (avoid overloading DB)
        PERFORM pg_sleep(0.1);
      END LOOP;
    END $$;
    ```

    **PHASE 4: VALIDATE** (check data integrity):
    ```sql
    -- Verify all data migrated
    SELECT count(*) FROM users WHERE new_email IS NULL;
    -- Should return 0

    -- Verify data consistency
    SELECT count(*) FROM users WHERE old_email != new_email;
    -- Should return 0 (or acceptable count for dirty data)
    ```

    **PHASE 5: MIGRATE** (deploy app v3):
    ```typescript
    // App version 3 - reads from new_email only
    await db.query('SELECT new_email FROM users WHERE id = $1', [id])
    ```

    **PHASE 6: CONTRACT** (remove old column):
    ```sql
    -- Drop trigger and function
    DROP TRIGGER IF EXISTS sync_email ON users;
    DROP FUNCTION IF EXISTS sync_email_columns();

    -- Remove old column
    ALTER TABLE users DROP COLUMN old_email;
    ```

    ## Pattern 3: Change Column Type

    **Example**: Change `age INT` → `age NUMERIC(5,2)`

    **PHASE 1: EXPAND**:
    ```sql
    ALTER TABLE users ADD COLUMN age_new NUMERIC(5,2);
    ```

    **PHASE 2: BACKFILL**:
    ```sql
    UPDATE users SET age_new = age::NUMERIC(5,2);
    ```

    **PHASE 3: APP MIGRATION** → read from age_new

    **PHASE 4: CONTRACT**:
    ```sql
    ALTER TABLE users DROP COLUMN age;
    ALTER TABLE users RENAME COLUMN age_new TO age;
    ```

    ## Pattern 4: Split Table

    **Example**: Split `users` into `users` + `user_profiles`

    **PHASE 1: EXPAND**:
    ```sql
    CREATE TABLE user_profiles (
      user_id UUID PRIMARY KEY REFERENCES users(id),
      bio TEXT,
      avatar_url TEXT
    );
    ```

    **PHASE 2: APP MIGRATION** → write to both tables

    **PHASE 3: BACKFILL**:
    ```sql
    INSERT INTO user_profiles (user_id, bio, avatar_url)
    SELECT id, bio, avatar_url FROM users;
    ```

    **PHASE 4: CONTRACT**:
    ```sql
    ALTER TABLE users DROP COLUMN bio;
    ALTER TABLE users DROP COLUMN avatar_url;
    ```

    ## Pattern 5: Add NOT NULL Constraint

    **Unsafe** (will fail if nulls exist):
    ```sql
    ALTER TABLE users ALTER COLUMN email SET NOT NULL;  -- ❌ Can break
    ```

    **Safe** (zero-downtime):

    **PHASE 1: Add default value**:
    ```sql
    ALTER TABLE users ALTER COLUMN email SET DEFAULT 'unknown@example.com';
    ```

    **PHASE 2: Backfill nulls**:
    ```sql
    UPDATE users SET email = 'unknown@example.com' WHERE email IS NULL;
    ```

    **PHASE 3: Add constraint**:
    ```sql
    ALTER TABLE users ALTER COLUMN email SET NOT NULL;
    ```

    ## When to Use Zero-Downtime

    **Use expand/contract for**:
    - Column renames
    - Type changes
    - Table splits/merges
    - Adding NOT NULL constraints
    - Removing columns

    **Don't need for**:
    - Adding nullable columns
    - Adding indexes (use CONCURRENTLY)
    - Creating new tables
    - Adding constraints (check, foreign key)

    ## Risks & Trade-offs

    **Pros**:
    - No downtime
    - Gradual rollout
    - Safe rollback

    **Cons**:
    - Longer deployment cycle (weeks vs minutes)
    - Increased complexity
    - Duplicate data temporarily
    - Requires app coordination

    ## Decision Tree

    ```
    Does migration break existing app?
      NO → Standard migration ✅
      YES → Does it affect hot path?
        NO → Maintenance window OK ✅
        YES → Use expand/contract pattern ✅
    ```
  elicit: false
```

**Recomendação**: Adicionar seção `zero-downtime` após `version-tracking` (+200 linhas).

---

## Sumário de Gaps

| Gap | Severidade | Seção Afetada | Ação |
|-----|------------|---------------|------|
| GAP 1.1 - Schema Version Tracking | 🔴 CRÍTICO | **NOVA SEÇÃO** | Adicionar version-tracking (140 linhas) |
| GAP 3.1 - Zero-Downtime Migrations | 🔴 CRÍTICO | **NOVA SEÇÃO** | Adicionar zero-downtime (200 linhas) |
| Large-scale batching | 🟡 ALTO | data-migration | Expandir com batching avançado (50 linhas) |

---

## Recomendações de Expansão

### Expansão Estimada

| Componente | Linhas Atuais | Linhas Propostas | Δ |
|------------|---------------|------------------|---|
| version-tracking | 0 | 140 | +140 |
| zero-downtime | 0 | 200 | +200 |
| data-migration | 10 | 60 | +50 |

**Total**: 93 → **483 linhas** (+390 linhas, +419%)

### Priorização

**Fase 1 - Blocker** (340 linhas):
1. Schema version tracking (GAP 1.1) - 140 linhas
2. Zero-downtime migrations (GAP 3.1) - 200 linhas

**Fase 2 - Importante** (50 linhas):
1. Large-scale batching (millions of rows) - 50 linhas

---

## Comparação com Templates Anteriores

| Aspecto | schema-design | rls-policies | migration-plan | Winner |
|---------|---------------|--------------|----------------|--------|
| **Cobertura base** | 7/10 | 8/10 | 5/10 | rls-policies |
| **Gaps críticos** | 0 | 2 | **2** | schema-design |
| **Production-ready** | ⚠️ Precisa expansão | ⚠️ Precisa expansão | ❌ **NÃO** | schema-design |
| **Expansão necessária** | +82% | +101% | **+419%** | schema-design (menos) |

**Conclusão**: migration-plan-tmpl.yaml é o template com **mais gaps críticos** e requer **maior expansão relativa** (+419%).

---

## Conclusão

**Status**: 🔴 Não production-ready - Faltam features críticas

**Bloqueadores para Produção**:
1. ❌ Schema version tracking ausente (GAP 1.1)
2. ❌ Zero-downtime migrations não documentado (GAP 3.1)

**Próximos Passos**:
1. ✅ Marcar auditoria de migration-plan-tmpl.yaml como completa
2. ➡️ Auditar index-strategy-tmpl.yaml (próximo template)
3. 📝 Após auditar todos templates, consolidar recomendações
4. 🔨 **PRIORIDADE**: Implementar GAPs 1.1 e 3.1 **antes de qualquer outra expansão**

**Score Final**: 5/10
- ✅ Planejamento básico OK (change set, dependencies, safety)
- ✅ Rollback strategy básico
- ✅ Testing strategy adequado
- ❌ Schema version tracking **completamente ausente** (crítico)
- ❌ Zero-downtime migrations **não documentado** (crítico)
- ⚠️ Large-scale batching superficial

**Estimativa de Expansão**: +390 linhas (+419%)

**⚠️ AVISO**: Este é o template com maior necessidade de expansão (4x o tamanho atual). Priorize GAPs 1.1 e 3.1 imediatamente.

---

*Auditoria concluída: 2025-10-27*
