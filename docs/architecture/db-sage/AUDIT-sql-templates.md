# Auditoria: SQL Templates

**Data**: 2025-10-27
**Templates**: `tmpl-rls-kiss-policy.sql` + `tmpl-smoke-test.sql`
**Auditor**: Winston (Architect)
**Status**: ✅ Básicos OK, mas faltam variants

---

## Executive Summary

**Score**: 7/10 - Templates básicos funcionais, faltam variants

**Veredicto**: Ambos templates SQL são funcionais para casos simples, mas faltam variants para cobrir casos avançados (multi-tenancy, role-based, performance smoke tests).

---

## 1. tmpl-rls-kiss-policy.sql

**Linhas**: 11
**Propósito**: KISS (Keep It Simple) RLS policy para owner-only access

### ✅ O Que Está Bem Coberto

```sql
-- KISS single FOR ALL policy template (owner-only by column user_id)
ALTER TABLE :table ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS ":table_kiss_all" ON :table;
CREATE POLICY ":table_kiss_all"
ON :table
FOR ALL
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);
```

**Pontos Fortes**:
- ✅ Idempotent (DROP POLICY IF EXISTS)
- ✅ Single policy para todas operações (KISS)
- ✅ Owner-only pattern (mais comum)
- ✅ Parameterizado (:table placeholder)

### ❌ O Que Está Faltando

**Faltam variants** para outros patterns comuns:

```sql
-- VARIANT 1: Multi-tenancy (tenant isolation)
-- tmpl-rls-tenant-policy.sql
ALTER TABLE :table ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS ":table_tenant_policy" ON :table;
CREATE POLICY ":table_tenant_policy"
ON :table
FOR ALL
TO authenticated
USING (
  org_id = (auth.jwt() ->> 'org_id')::uuid
)
WITH CHECK (
  org_id = (auth.jwt() ->> 'org_id')::uuid
);

-- Index para performance
CREATE INDEX IF NOT EXISTS idx_:table_org_id
ON :table(org_id);
```

```sql
-- VARIANT 2: Role-based (role hierarchy)
-- tmpl-rls-role-policy.sql
ALTER TABLE :table ENABLE ROW LEVEL SECURITY;

-- Admin vê tudo
DROP POLICY IF EXISTS ":table_admin_all" ON :table;
CREATE POLICY ":table_admin_all"
ON :table
FOR ALL
TO authenticated
USING ((auth.jwt() ->> 'role') = 'admin')
WITH CHECK ((auth.jwt() ->> 'role') = 'admin');

-- Manager vê do seu org
DROP POLICY IF EXISTS ":table_manager_org" ON :table;
CREATE POLICY ":table_manager_org"
ON :table
FOR ALL
TO authenticated
USING (
  (auth.jwt() ->> 'role') = 'manager' AND
  org_id = (auth.jwt() ->> 'org_id')::uuid
);

-- User vê apenas próprios
DROP POLICY IF EXISTS ":table_user_own" ON :table;
CREATE POLICY ":table_user_own"
ON :table
FOR ALL
TO authenticated
USING (
  (auth.jwt() ->> 'role') = 'user' AND
  user_id = auth.uid()
);
```

```sql
-- VARIANT 3: Public read, authenticated write
-- tmpl-rls-public-read-policy.sql
ALTER TABLE :table ENABLE ROW LEVEL SECURITY;

-- Public read
DROP POLICY IF EXISTS ":table_public_read" ON :table;
CREATE POLICY ":table_public_read"
ON :table
FOR SELECT
TO anon, authenticated
USING (true);

-- Authenticated write (owner-only)
DROP POLICY IF EXISTS ":table_auth_write" ON :table;
CREATE POLICY ":table_auth_write"
ON :table
FOR INSERT, UPDATE, DELETE
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);
```

```sql
-- VARIANT 4: Time-based (scheduled content)
-- tmpl-rls-time-based-policy.sql
ALTER TABLE :table ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS ":table_scheduled" ON :table;
CREATE POLICY ":table_scheduled"
ON :table
FOR SELECT
TO authenticated
USING (
  (publish_at IS NULL OR publish_at <= NOW()) AND
  (expire_at IS NULL OR expire_at > NOW())
);

-- Index para performance
CREATE INDEX IF NOT EXISTS idx_:table_scheduling
ON :table(publish_at, expire_at)
WHERE publish_at IS NOT NULL OR expire_at IS NOT NULL;
```

### Recomendação

**Criar 4 variants adicionais**:
1. `tmpl-rls-tenant-policy.sql` (+15 linhas)
2. `tmpl-rls-role-policy.sql` (+35 linhas)
3. `tmpl-rls-public-read-policy.sql` (+20 linhas)
4. `tmpl-rls-time-based-policy.sql` (+20 linhas)

**Total novo**: +90 linhas em 4 novos arquivos

---

## 2. tmpl-smoke-test.sql

**Linhas**: 17
**Propósito**: Verificações básicas pós-migration

### ✅ O Que Está Bem Coberto

```sql
-- Basic post-migration checks (fill placeholders)
SET client_min_messages = warning;

-- Count tables/policies/functions expected
SELECT COUNT(*) AS tables FROM information_schema.tables WHERE table_schema='public';
SELECT COUNT(*) AS policies FROM pg_policies WHERE schemaname='public';
SELECT proname FROM pg_proc WHERE pronamespace = 'public'::regnamespace
  AND proname IN ('current_mind_id','provision_user_profile','set_fragment_mind_id');

-- Sanity queries (examples)
-- SELECT * FROM categories LIMIT 5;
-- SELECT * FROM minds LIMIT 5;

-- RLS sanity (should not error even if it returns 0)
-- SET LOCAL request.jwt.claims = '{"sub":"<user-uuid>","role":"authenticated"}';
-- SELECT 1 FROM fragments WHERE false;
```

**Pontos Fortes**:
- ✅ Conta objetos do schema (tables, policies, functions)
- ✅ Sanity queries (examples comentados)
- ✅ RLS check (comentado)
- ✅ SET client_min_messages = warning (reduz ruído)

### ❌ O Que Está Faltando

**Faltam smoke tests robustos**:

```sql
-- SMOKE TEST COMPLETO (tmpl-smoke-test-complete.sql)

SET client_min_messages = warning;

\echo '\n=== 📊 SCHEMA VALIDATION ==='

-- 1. Count tables (expect N tables)
\echo '✓ Tables:'
SELECT COUNT(*) AS table_count FROM information_schema.tables WHERE table_schema='public';
-- Expected: :expected_tables

-- 2. Count policies (expect M policies)
\echo '✓ Policies:'
SELECT COUNT(*) AS policy_count FROM pg_policies WHERE schemaname='public';
-- Expected: :expected_policies

-- 3. Verify RLS enabled on all tables
\echo '✓ RLS Status:'
SELECT
  schemaname,
  tablename,
  rowsecurity AS rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
AND rowsecurity = false;  -- Should return 0 rows

-- 4. Check for missing indexes on foreign keys
\echo '✓ Foreign Key Indexes:'
SELECT
  tc.table_name,
  kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
  ON tc.constraint_name = kcu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
AND NOT EXISTS (
  SELECT 1 FROM pg_indexes
  WHERE tablename = tc.table_name
  AND indexdef LIKE '%' || kcu.column_name || '%'
);
-- Should return 0 rows

\echo '\n=== 🔐 DATA INTEGRITY ==='

-- 5. Check for orphaned records (foreign key violations if not enforced)
\echo '✓ Orphaned Records:'
-- Example:
-- SELECT COUNT(*) FROM posts WHERE user_id NOT IN (SELECT id FROM users);

-- 6. Check for NULL values in NOT NULL columns (should be 0)
\echo '✓ NULL Constraint Violations:'
SELECT
  table_name,
  column_name
FROM information_schema.columns
WHERE table_schema = 'public'
AND is_nullable = 'NO'
AND column_default IS NULL;

\echo '\n=== 🚀 PERFORMANCE ==='

-- 7. Check for missing indexes on frequently queried columns
\echo '✓ Missing Indexes (potential):'
SELECT
  schemaname,
  tablename,
  attname,
  n_distinct,
  correlation
FROM pg_stats
WHERE schemaname = 'public'
AND n_distinct > 100  -- High cardinality
AND correlation < 0.1  -- Low correlation (random access)
ORDER BY n_distinct DESC
LIMIT 10;

-- 8. Check for bloated indexes (> 20% waste)
\echo '✓ Index Bloat:'
SELECT
  schemaname,
  tablename,
  indexname,
  pg_size_pretty(pg_relation_size(indexrelid)) AS index_size,
  idx_scan AS index_scans,
  idx_tup_read AS tuples_read,
  idx_tup_fetch AS tuples_fetched
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
AND idx_scan = 0  -- Unused indexes
ORDER BY pg_relation_size(indexrelid) DESC;

\echo '\n=== 🧪 RLS VALIDATION ==='

-- 9. Test RLS policies (simulate different users)
\echo '✓ RLS Owner-Only Policy:'
BEGIN;
SET LOCAL request.jwt.claims = '{"sub":"user-a-uuid","role":"authenticated"}';
SELECT COUNT(*) AS user_a_count FROM :table WHERE user_id = 'user-a-uuid';
-- Expected: > 0
ROLLBACK;

BEGIN;
SET LOCAL request.jwt.claims = '{"sub":"user-b-uuid","role":"authenticated"}';
SELECT COUNT(*) AS user_b_count FROM :table WHERE user_id = 'user-a-uuid';
-- Expected: 0 (user B should NOT see user A's data)
ROLLBACK;

\echo '\n=== 🎯 FUNCTIONAL TESTS ==='

-- 10. Test key functions
\echo '✓ Functions:'
SELECT
  proname,
  pronargs,
  prorettype::regtype AS return_type
FROM pg_proc
WHERE pronamespace = 'public'::regnamespace
AND proname IN (:expected_functions);
-- Expected: :expected_function_count functions

-- 11. Test triggers
\echo '✓ Triggers:'
SELECT
  trigger_name,
  event_manipulation,
  event_object_table
FROM information_schema.triggers
WHERE trigger_schema = 'public';

\echo '\n=== ✅ SMOKE TEST COMPLETE ==='
```

### Recomendação

**Criar smoke test completo**:
- `tmpl-smoke-test-complete.sql` (+120 linhas)

Incluir:
1. Schema validation (tables, policies, RLS status)
2. Data integrity (orphaned records, NULL violations)
3. Performance checks (missing indexes, bloat)
4. RLS validation (policy effectiveness)
5. Functional tests (functions, triggers)

---

## Sumário

| Template | Linhas | Score | Status | Ação |
|----------|--------|-------|--------|------|
| tmpl-rls-kiss-policy.sql | 11 | 7/10 | ✅ Básico OK | Criar 4 variants (+90 linhas) |
| tmpl-smoke-test.sql | 17 | 7/10 | ⚠️ Superficial | Expandir (+120 linhas) |

**Total atual**: 28 linhas
**Total proposto**: 238 linhas (+210 linhas, +750%)

---

## Recomendações Finais

### Fase 1 - Variants RLS (90 linhas)
1. `tmpl-rls-tenant-policy.sql` - Multi-tenancy
2. `tmpl-rls-role-policy.sql` - Role-based hierarchy
3. `tmpl-rls-public-read-policy.sql` - Public read, auth write
4. `tmpl-rls-time-based-policy.sql` - Scheduled content

### Fase 2 - Smoke Test Robusto (120 linhas)
1. `tmpl-smoke-test-complete.sql` - Schema, integrity, performance, RLS, functional

---

## Conclusão

**Status**: ✅ Templates básicos funcionais, faltam variants para produção

**Score Geral**: 7/10
- ✅ tmpl-rls-kiss-policy.sql cobre caso mais comum (owner-only)
- ✅ tmpl-smoke-test.sql cobre verificações básicas
- ❌ Faltam 4 RLS variants para outros patterns
- ⚠️ Smoke test precisa ser mais robusto (integrity, performance)

**Estimativa de Expansão**: +210 linhas (+750%)

---

*Auditoria concluída: 2025-10-27*
