#!/bin/bash
# DB Schema Snapshot - Load complete schema in ONE query
# No errors, no searching, just raw database facts
# Usage: ./db-schema-snapshot.sh (requires SUPABASE_DB_URL env var)

if [ -z "$SUPABASE_DB_URL" ]; then
  echo "ERROR: SUPABASE_DB_URL not set"
  exit 1
fi

psql "$SUPABASE_DB_URL" << 'SQL'
\set QUIET on

-- CONSOLIDATED SCHEMA SNAPSHOT (One Query, All Context)
-- Returns structured JSON with all tables, columns, relationships
-- Zero exploratory reads, zero file searches, pure database facts

\echo '=== DATABASE SCHEMA SNAPSHOT (LIVE) ==='
\echo ''

-- 1. All base tables with row counts
\echo '### TABLES'
SELECT
  json_build_object(
    'section', 'TABLES',
    'tables', json_agg(
      json_build_object(
        'name', table_name,
        'rows', (SELECT COUNT(*) FROM information_schema.tables t2 WHERE t2.table_name = t.table_name)
      ) ORDER BY table_name
    )
  ) as result
FROM information_schema.tables t
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

-- 2. All columns grouped by table
\echo ''
\echo '### COLUMNS'
SELECT
  json_build_object(
    'table', table_name,
    'fields', json_agg(
      json_build_object(
        'name', column_name,
        'type', data_type,
        'nullable', is_nullable = 'YES'
      ) ORDER BY ordinal_position
    )
  ) as result
FROM information_schema.columns c
WHERE table_schema = 'public'
GROUP BY table_name
ORDER BY table_name;

-- 3. Foreign keys (relationships)
\echo ''
\echo '### FOREIGN KEYS'
SELECT
  json_build_object(
    'table', ccu.table_name,
    'column', ccu.column_name,
    'fk_table', kcu.table_name,
    'fk_column', kcu.column_name
  ) as result
FROM information_schema.constraint_column_usage ccu
JOIN information_schema.key_column_usage kcu USING (constraint_name, constraint_schema)
WHERE ccu.table_schema = 'public'
  AND ccu.constraint_name IN (
    SELECT constraint_name FROM information_schema.table_constraints
    WHERE constraint_type = 'FOREIGN KEY'
  );

-- 4. Summary metrics
\echo ''
\echo '### SUMMARY'
SELECT
  json_build_object(
    'total_tables', (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'),
    'total_columns', (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = 'public'),
    'timestamp', NOW()
  ) as result;

\set QUIET off
SQL
