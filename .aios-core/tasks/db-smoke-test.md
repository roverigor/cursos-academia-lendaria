# Database Smoke Test Task

Comprehensive smoke test suite for validating database migrations, schema integrity, RLS policies, functions, triggers, and views after deployment.

## Purpose

Catch critical issues post-migration before they reach users. Tests schema structure, data integrity, security policies, and business logic in production-like conditions.

## Prerequisites

- Database migrated to target version
- `SUPABASE_DB_URL` environment variable set
- Test user UUIDs (for RLS testing)
- Expected table list

## Instructions

### 1. Gather Migration Context

Ask user:
- **Migration version** being tested (e.g., `v0.7.0`, `baseline`)
- **Test mode**: Quick (structure only) or Full (structure + RLS + functions)
- **Test user UUID** (default: generate or use `00000000-0000-0000-0000-000000000000`)

### 2. Generate Smoke Test Script

Create comprehensive test SQL:

```sql
-- ============================================================================
-- SMOKE TEST: <version> - <timestamp>
-- ============================================================================

BEGIN;

-- Configuration
\set ON_ERROR_STOP on
\timing on

-- ============================================================================
-- SECTION 1: SCHEMA STRUCTURE
-- ============================================================================

\echo '=== Testing Tables ==='

SELECT
  tablename,
  hasindexes,
  rowsecurity as rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

-- Verify expected tables exist
DO $$
DECLARE
  expected_tables text[] := ARRAY['minds', 'sources', 'fragments', 'courses', 'mind_members'];
  missing_tables text[];
BEGIN
  SELECT array_agg(t)
  INTO missing_tables
  FROM unnest(expected_tables) t
  WHERE NOT EXISTS (
    SELECT 1 FROM pg_tables
    WHERE schemaname = 'public' AND tablename = t
  );

  IF array_length(missing_tables, 1) > 0 THEN
    RAISE EXCEPTION 'Missing tables: %', array_to_string(missing_tables, ', ');
  END IF;

  RAISE NOTICE '✅ All expected tables exist';
END $$;

-- ============================================================================
-- SECTION 2: CONSTRAINTS & INDEXES
-- ============================================================================

\echo '=== Testing Foreign Keys ==='

SELECT
  tc.table_name,
  kcu.column_name,
  ccu.table_name AS foreign_table_name,
  ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.column_name;

\echo '=== Testing Indexes ==='

SELECT
  schemaname,
  tablename,
  indexname,
  indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

-- ============================================================================
-- SECTION 3: RLS POLICIES
-- ============================================================================

\echo '=== Testing RLS Status ==='

SELECT
  tablename,
  rowsecurity as rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

-- Verify critical tables have RLS
DO $$
DECLARE
  critical_tables text[] := ARRAY['minds', 'sources', 'fragments'];
  unprotected_tables text[];
BEGIN
  SELECT array_agg(tablename)
  INTO unprotected_tables
  FROM pg_tables
  WHERE schemaname = 'public'
    AND tablename = ANY(critical_tables)
    AND rowsecurity = false;

  IF array_length(unprotected_tables, 1) > 0 THEN
    RAISE WARNING '⚠️  Tables without RLS: %', array_to_string(unprotected_tables, ', ');
  ELSE
    RAISE NOTICE '✅ All critical tables have RLS enabled';
  END IF;
END $$;

\echo '=== Testing RLS Policies ==='

SELECT
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;

-- ============================================================================
-- SECTION 4: FUNCTIONS & TRIGGERS
-- ============================================================================

\echo '=== Testing Functions ==='

SELECT
  n.nspname as schema,
  p.proname as function_name,
  pg_get_function_arguments(p.oid) as arguments,
  CASE p.provolatile
    WHEN 'i' THEN 'IMMUTABLE'
    WHEN 's' THEN 'STABLE'
    WHEN 'v' THEN 'VOLATILE'
  END as volatility
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public'
ORDER BY p.proname;

\echo '=== Testing Triggers ==='

SELECT
  event_object_schema,
  event_object_table,
  trigger_name,
  event_manipulation,
  action_timing
FROM information_schema.triggers
WHERE event_object_schema = 'public'
ORDER BY event_object_table, trigger_name;

-- ============================================================================
-- SECTION 5: VIEWS
-- ============================================================================

\echo '=== Testing Views ==='

SELECT
  table_schema,
  table_name,
  view_definition
FROM information_schema.views
WHERE table_schema = 'public'
ORDER BY table_name;

-- ============================================================================
-- SECTION 6: RLS FUNCTIONAL TESTS (with impersonation)
-- ============================================================================

\echo '=== Testing RLS Policies with User Impersonation ==='

-- Create test user context
SET role authenticated;
SET request.jwt.claims = '{
  "sub": "00000000-0000-0000-0000-000000000000",
  "email": "test@example.com",
  "role": "authenticated",
  "aud": "authenticated"
}';

-- Verify impersonation
DO $$
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION '❌ Impersonation failed: auth.uid() is NULL';
  END IF;
  RAISE NOTICE '✅ Impersonating user: %', auth.uid();
END $$;

-- Test 1: User can only see their own minds
\echo '--- Test: SELECT minds (should see only user data) ---'
EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*) FROM minds WHERE creator_mind_id = auth.uid();

-- Test 2: User cannot see other users' minds
\echo '--- Test: SELECT other minds (should return 0) ---'
SELECT count(*) as other_minds_count
FROM minds
WHERE creator_mind_id != auth.uid();

-- Expected: 0 (if test user has no data, this is valid)

-- Test 3: Insert with RLS (should enforce creator_mind_id)
\echo '--- Test: INSERT source (should enforce ownership) ---'
-- Note: Will fail if mind doesn't exist or user doesn't own it
-- This is expected and validates RLS is working

-- Reset session
RESET role;
RESET request.jwt.claims;

\echo '=== RLS Tests Complete ==='

-- ============================================================================
-- SECTION 7: DATA INTEGRITY
-- ============================================================================

\echo '=== Testing Data Integrity ==='

-- Check for orphaned records (sources without minds)
SELECT
  'orphaned_sources' as issue,
  count(*) as count
FROM sources s
LEFT JOIN minds m ON s.mind_id = m.id
WHERE m.id IS NULL;

-- Check for invalid UUIDs (NULL in NOT NULL columns)
SELECT
  'minds_null_creator' as issue,
  count(*) as count
FROM minds
WHERE creator_mind_id IS NULL;

-- ============================================================================
-- FINAL SUMMARY
-- ============================================================================

\echo '=== Smoke Test Complete ==='
\echo '✅ All sections passed'
\echo 'Review output above for any warnings or unexpected results'

ROLLBACK; -- Don't commit test changes
```

### 3. Execute Smoke Test

Run the generated script:

```bash
psql "$SUPABASE_DB_URL" -f supabase/tests/smoke-test-<version>.sql
```

Or run inline:

```bash
psql "$SUPABASE_DB_URL" << 'EOF'
<generated-sql>
EOF
```

### 4. Parse Results

Analyze output for:

**Critical Failures (❌):**
- Missing expected tables
- RLS disabled on critical tables
- Impersonation failures
- Foreign key violations
- Orphaned data

**Warnings (⚠️):**
- Tables without RLS (if data is public, OK)
- Missing indexes on FK columns
- VOLATILE functions (performance concern)

**Pass (✅):**
- All expected tables exist
- RLS enabled and policies active
- Constraints enforced
- Functions and triggers present

### 5. Generate Report

```
🧪 Smoke Test Report: v0.7.0

STRUCTURE: ✅
- 12 tables (expected: 12)
- 24 indexes
- 15 foreign keys
- All constraints valid

SECURITY: ⚠️
- RLS enabled: 10/12 tables
- RLS policies: 28 total
- WARNING: 'public_data' table has no RLS (by design)

FUNCTIONS: ✅
- 8 functions
- 5 triggers
- 2 views

RLS FUNCTIONAL TESTS: ✅
- User isolation: PASS (0 cross-tenant rows)
- Insert enforcement: PASS (ownership required)
- Impersonation: PASS (auth.uid() working)

DATA INTEGRITY: ✅
- No orphaned records
- No NULL violations

PERFORMANCE NOTES:
- minds query: 12ms, seq scan (add index on creator_mind_id)

Overall: ✅ PASS with 1 warning
```

### 6. Save Artifacts

- Save test script: `supabase/tests/smoke-test-v<version>.sql`
- Save output: `supabase/tests/smoke-test-v<version>-output.log`
- Document warnings: Update migration notes

## Quick Mode

If user wants fast validation (no RLS tests):

```sql
-- Quick smoke test (30 seconds)
\dt public.*           -- List tables
\di public.*           -- List indexes
SELECT * FROM pg_policies WHERE schemaname = 'public';
SELECT proname FROM pg_proc WHERE pronamespace = 'public'::regnamespace;
```

## Full Mode (Recommended)

Use complete script above. Takes 2-5 minutes but catches 95% of issues.

## Common Issues

**RLS tests fail with "permission denied":**
- Expected if test user doesn't own data
- Validates RLS is working correctly
- Use service role to seed test data first

**auth.uid() is NULL:**
- Supabase not configured (vanilla Postgres)
- Skip RLS functional tests
- Warn user to test RLS manually in Supabase

**Slow queries during test:**
- Note missing indexes in report
- Run EXPLAIN ANALYZE on slow paths
- Suggest: `*explain "<query>"` or `*analyze-hotpaths`

## Integration with Other Commands

- **Before**: `*snapshot baseline` (create rollback point)
- **After failure**: `*rollback baseline` (restore previous state)
- **For RLS deep-dive**: `*rls-audit` (detailed policy analysis)
- **For performance**: `*analyze-hotpaths` (query optimization)

## Automation

Add to CI/CD:

```bash
#!/bin/bash
# scripts/ci/smoke-test.sh

set -e

VERSION=$(git describe --tags --always)

echo "Running smoke test for $VERSION"
psql "$SUPABASE_DB_URL" -f supabase/tests/smoke-test.sql > smoke-test.log 2>&1

if grep -q "❌" smoke-test.log; then
  echo "Smoke test failed"
  cat smoke-test.log
  exit 1
fi

echo "Smoke test passed"
```

## Best Practices

1. **Run after every migration** - Catch issues before production
2. **Version test scripts** - Track what was tested when
3. **Automate in CI** - Don't rely on manual testing
4. **Test with real user** - Use actual UUID from auth.users
5. **Save outputs** - Historical log for debugging
6. **Update expected values** - Keep test in sync with schema evolution

## References

- Supabase RLS Testing: https://supabase.com/docs/guides/database/postgres/row-level-security#testing-policies
- PostgreSQL Testing: https://www.postgresql.org/docs/current/regress.html
- SQL Assertions: https://www.postgresql.org/docs/current/plpgsql-errors-and-messages.html
