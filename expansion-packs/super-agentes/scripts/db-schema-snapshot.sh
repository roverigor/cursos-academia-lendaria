#!/bin/bash
# 🗄️ DB Schema Snapshot - Load complete schema in ONE query
# Usage: source ./db-schema-snapshot.sh
# Result: Full schema context in memory, no additional queries needed

if [ -z "$SUPABASE_DB_URL" ]; then
  echo "❌ SUPABASE_DB_URL not set"
  exit 1
fi

echo "🔄 Loading complete schema snapshot..."

psql "$SUPABASE_DB_URL" << 'SQL'
-- CONSOLIDATED SCHEMA SNAPSHOT (One Query, All Context)
\set QUIET on
\set ON_ERROR_STOP on

-- 1. All base tables with row counts
SELECT
  'TABLES' as section,
  json_agg(
    json_build_object(
      'name', table_name,
      'rows', (SELECT COUNT(*) FROM information_schema.tables t2 WHERE t2.table_name = t.table_name)
    ) ORDER BY table_name
  ) as data
FROM information_schema.tables t
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

-- 2. All columns grouped by table
SELECT
  'COLUMNS' as section,
  json_agg(
    json_build_object(
      'table', table_name,
      'fields', json_agg(
        json_build_object(
          'name', column_name,
          'type', data_type,
          'nullable', is_nullable = 'YES'
        ) ORDER BY ordinal_position
      )
    ) ORDER BY table_name
  ) as data
FROM information_schema.columns c
WHERE table_schema = 'public'
GROUP BY table_name;

-- 3. Foreign keys (relationships)
SELECT
  'FOREIGN_KEYS' as section,
  json_agg(
    json_build_object(
      'table', ccu.table_name,
      'column', ccu.column_name,
      'fk_table', kcu.table_name,
      'fk_column', kcu.column_name
    )
  ) as data
FROM information_schema.constraint_column_usage ccu
JOIN information_schema.key_column_usage kcu USING (constraint_name, constraint_schema)
WHERE ccu.table_schema = 'public'
  AND ccu.constraint_name IN (
    SELECT constraint_name FROM information_schema.table_constraints
    WHERE constraint_type = 'FOREIGN KEY'
  );

-- 4. Junction tables (N:M) - auto-detect
SELECT
  'JUNCTION_TABLES' as section,
  json_agg(
    json_build_object(
      'table', t.table_name,
      'fk_count', (
        SELECT COUNT(*) FROM information_schema.table_constraints
        WHERE table_name = t.table_name AND constraint_type = 'FOREIGN KEY'
      )
    )
  ) as data
FROM information_schema.tables t
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
  AND (
    SELECT COUNT(*) FROM information_schema.table_constraints
    WHERE table_name = t.table_name AND constraint_type = 'FOREIGN KEY'
  ) >= 2;

-- 5. Key metrics for current session
SELECT
  'METRICS' as section,
  json_build_object(
    'total_tables', (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'),
    'total_columns', (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = 'public'),
    'timestamp', NOW()
  ) as data;

\set QUIET off
SQL

echo "✅ Schema snapshot loaded. Ready for queries."
