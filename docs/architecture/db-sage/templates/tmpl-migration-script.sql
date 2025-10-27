-- =========================================================
-- MIGRATION TEMPLATE
-- =========================================================
-- Migration: <SHORT_DESCRIPTION>
-- Created: <YYYY-MM-DD HH:MM:SS UTC>
-- Author: <YOUR_NAME>
-- Version: <SEMANTIC_VERSION> (e.g., v1.2.0)
-- Ticket/Issue: <REFERENCE> (e.g., #123, PROJ-456)
--
-- Purpose:
--   <Detailed description of what this migration does and why>
--   <Include business context and affected functionality>
--
-- Affected Tables/Objects:
--   - <table_name>: <what changes>
--   - <view_name>: <what changes>
--   - <function_name>: <what changes>
--
-- Breaking Changes:
--   - [ ] None
--   - [ ] <Describe breaking change and migration path>
--
-- Rollback Plan:
--   - Strategy: <Point-in-Time Recovery | Additional Migration | Manual Script>
--   - Instructions: <Step-by-step rollback process>
--
-- Testing:
--   - [ ] Tested locally with: supabase db reset
--   - [ ] Tested in staging environment
--   - [ ] Performance validated with sample data
--   - [ ] RLS policies validated for all roles
--
-- Dependencies:
--   - Required migrations: <migration_file_1>, <migration_file_2>
--   - Required extensions: <extension_name>
--   - Required roles/permissions: <role_name>
--
-- Performance Notes:
--   - Expected duration: <time estimate>
--   - Locks acquired: <table locks, if any>
--   - Indexes created: <concurrent or blocking>
--   - Backfill required: <yes/no, estimated time>
-- =========================================================

-- CRITICAL: Always wrap migrations in a transaction for atomicity
BEGIN;

-- =========================================================
-- PHASE 1: PREREQUISITES
-- =========================================================
-- Check required extensions, roles, and dependencies

-- Example: Ensure required extension is installed
-- DO $$
-- BEGIN
--   IF NOT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'uuid-ossp') THEN
--     RAISE EXCEPTION 'Required extension uuid-ossp is not installed';
--   END IF;
-- END $$;

-- Example: Validate previous migration was applied
-- DO $$
-- BEGIN
--   IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'required_table') THEN
--     RAISE EXCEPTION 'Dependency not met: required_table does not exist. Run migration YYYYMMDDHHMMSS_prerequisite.sql first';
--   END IF;
-- END $$;

-- =========================================================
-- PHASE 2: SCHEMA CHANGES (DDL)
-- =========================================================
-- Create/alter tables, columns, constraints, indexes

-- Example: Create new table
-- CRITICAL: Always enable RLS on new tables, even for public access
-- CRITICAL: Use lowercase SQL for consistency
create table if not exists <table_name> (
  id uuid primary key default gen_random_uuid(),

  -- Foreign keys
  <parent>_id uuid not null references <parent>(id) on delete cascade,

  -- Required fields
  name text not null,
  created_at timestamptz not null default now(),

  -- Optional fields
  description text,
  metadata jsonb default '{}'::jsonb,

  -- Audit fields
  updated_at timestamptz,
  deleted_at timestamptz,  -- Soft delete

  -- Constraints
  constraint <table_name>_name_not_empty check (length(trim(name)) > 0),
  constraint <table_name>_valid_dates check (created_at <= coalesce(updated_at, now()))
);

-- Add comments for documentation
comment on table <table_name> is 'Stores <business purpose>';
comment on column <table_name>.metadata is 'Flexible JSONB field for extensibility';

-- Example: Add column to existing table
-- CRITICAL: Always append new columns to end of table to avoid messy diffs
-- alter table <existing_table> add column if not exists <new_column> text;

-- Example: Modify column (DESTRUCTIVE - requires data migration)
-- WARNING: This operation may lock the table and require data backfill
-- alter table <table_name> alter column <column_name> set data type <new_type> using <column_name>::<new_type>;

-- Example: Add constraint (validate separately for zero-downtime)
-- Step 1: Add constraint NOT VALID (no table scan)
-- alter table <table_name> add constraint <constraint_name>
--   check (<condition>) not valid;
-- Step 2: Validate constraint (can be done later, in separate migration)
-- alter table <table_name> validate constraint <constraint_name>;

-- =========================================================
-- PHASE 3: INDEXES (Performance)
-- =========================================================
-- Create indexes based on access patterns

-- Example: Standard index (CONCURRENT for zero-downtime)
-- CRITICAL: Use CONCURRENTLY to avoid locking table
-- create index concurrently if not exists idx_<table>_<column>
--   on <table>(<column>);

-- Example: Partial index (smaller, faster for filtered queries)
-- create index concurrently if not exists idx_<table>_active_<column>
--   on <table>(<column>)
--   where deleted_at is null;

-- Example: Composite index (for multi-column queries)
-- create index concurrently if not exists idx_<table>_<col1>_<col2>_<col3>
--   on <table>(<col1>, <col2>, <col3> desc)
--   where <filter_condition>;

-- Example: GIN index (for JSONB, arrays, full-text search)
-- create index concurrently if not exists idx_<table>_<jsonb_column>
--   on <table> using gin (<jsonb_column> jsonb_path_ops);

-- Example: GiST index (for full-text search with trigrams)
-- create index concurrently if not exists idx_<table>_<text_column>_search
--   on <table> using gist (to_tsvector('english', <text_column>));

-- =========================================================
-- PHASE 4: ROW LEVEL SECURITY (RLS)
-- =========================================================
-- Enable RLS and create granular policies

-- CRITICAL: Always enable RLS, even for public tables
alter table <table_name> enable row level security;

-- Example: SELECT policy - authenticated users read own rows
-- CRITICAL: Wrap auth.uid() in SELECT for 99.99% performance improvement
create policy "<table_name>_select"
  on <table_name>
  for select
  to authenticated
  using (
    (select auth.uid()) is not null and
    (select auth.uid()) = user_id
  );

-- Example: INSERT policy - authenticated users create own rows
create policy "<table_name>_insert"
  on <table_name>
  for insert
  to authenticated
  with check (
    (select auth.uid()) is not null and
    (select auth.uid()) = user_id
  );

-- Example: UPDATE policy - users update own rows
create policy "<table_name>_update"
  on <table_name>
  for update
  to authenticated
  using (
    (select auth.uid()) is not null and
    (select auth.uid()) = user_id
  )
  with check (
    (select auth.uid()) is not null and
    (select auth.uid()) = user_id
  );

-- Example: DELETE policy - users delete own rows
create policy "<table_name>_delete"
  on <table_name>
  for delete
  to authenticated
  using (
    (select auth.uid()) is not null and
    (select auth.uid()) = user_id
  );

-- Example: Public read policy for anon users
create policy "<table_name>_select_public"
  on <table_name>
  for select
  to anon
  using (true);

-- Add policy comments
comment on policy "<table_name>_select" on <table_name> is 'Users can read own rows (cached auth.uid())';

-- =========================================================
-- PHASE 5: FUNCTIONS & TRIGGERS
-- =========================================================
-- Create database functions and triggers

-- Example: Trigger to auto-update updated_at
-- create or replace function trigger_set_updated_at()
-- returns trigger as $$
-- begin
--   new.updated_at = now();
--   return new;
-- end;
-- $$ language plpgsql;

-- create trigger trg_<table_name>_updated_at
--   before update on <table_name>
--   for each row
--   execute function trigger_set_updated_at();

-- Example: Trigger for audit logging
-- create or replace function audit_<table_name>()
-- returns trigger as $$
-- begin
--   insert into audit_log (table_name, record_id, operation, old_data, new_data, user_id)
--   values (
--     tg_table_name,
--     coalesce(new.id, old.id),
--     tg_op,
--     case when tg_op != 'INSERT' then to_jsonb(old) end,
--     case when tg_op != 'DELETE' then to_jsonb(new) end,
--     auth.uid()
--   );
--   return coalesce(new, old);
-- end;
-- $$ language plpgsql security definer;

-- create trigger trg_<table_name>_audit
--   after insert or update or delete on <table_name>
--   for each row
--   execute function audit_<table_name>();

-- =========================================================
-- PHASE 6: DATA MIGRATION (DML)
-- =========================================================
-- Migrate or backfill data

-- Example: Backfill new column with default values
-- update <table_name>
-- set <new_column> = <default_value>
-- where <new_column> is null;

-- Example: Data transformation
-- update <table_name>
-- set <column> = <transformation>
-- where <condition>;

-- =========================================================
-- PHASE 7: GRANTS & PERMISSIONS
-- =========================================================
-- Grant necessary permissions to roles

-- Example: Grant permissions to service role
-- grant select, insert, update, delete on <table_name> to authenticated;
-- grant select on <table_name> to anon;

-- =========================================================
-- PHASE 8: VALIDATION & SMOKE TESTS
-- =========================================================
-- Quick validation queries to ensure migration success

-- Validate table exists
do $$
begin
  if not exists (select 1 from information_schema.tables where table_name = '<table_name>') then
    raise exception 'Migration validation failed: table <table_name> was not created';
  end if;
end $$;

-- Validate RLS is enabled
do $$
begin
  if not exists (
    select 1 from pg_tables
    where tablename = '<table_name>'
    and rowsecurity = true
  ) then
    raise exception 'Migration validation failed: RLS not enabled on <table_name>';
  end if;
end $$;

-- Validate policies exist
do $$
begin
  if (select count(*) from pg_policies where tablename = '<table_name>') < 4 then
    raise exception 'Migration validation failed: Expected 4 RLS policies on <table_name>';
  end if;
end $$;

-- =========================================================
-- COMMIT TRANSACTION
-- =========================================================

COMMIT;

-- =========================================================
-- POST-MIGRATION NOTES
-- =========================================================
-- Run these commands AFTER migration if needed:
--
-- 1. Update table statistics for query planner:
--    ANALYZE <table_name>;
--
-- 2. Verify index usage:
--    SELECT * FROM pg_stat_user_indexes WHERE schemaname = 'public';
--
-- 3. Monitor for lock contention:
--    SELECT * FROM pg_locks WHERE NOT granted;
--
-- 4. Test RLS policies with impersonation:
--    SET request.jwt.claims TO '{"sub":"<user_id>"}';
--    SELECT * FROM <table_name>;  -- Should only see user's rows
--
-- 5. Verify performance with EXPLAIN:
--    EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM <table_name> WHERE <condition>;
-- =========================================================
