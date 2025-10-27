-- =========================================================
-- ROLLBACK STRATEGY TEMPLATE
-- =========================================================
-- Rollback For: <ORIGINAL_MIGRATION_FILE>
-- Created: <YYYY-MM-DD HH:MM:SS UTC>
-- Author: <YOUR_NAME>
--
-- PHILOSOPHY: Roll-Forward, Not Roll-Back
-- =========================================================
-- Modern PostgreSQL migration best practice is to ROLL FORWARD
-- rather than roll back. Instead of undoing a migration, we
-- apply a NEW migration that negates the problematic changes.
--
-- WHY ROLL FORWARD?
-- 1. Maintains immutable migration history
-- 2. Safer for production databases
-- 3. Preserves audit trail
-- 4. Handles partial failures better
-- 5. Works with continuous deployment
--
-- Reference: https://github.com/graphile/migrate
-- Reference: https://medium.com/@jonathangfischoff/what-should-a-postgresql-migrator-do-47fd34804be
-- =========================================================

-- =========================================================
-- RECOMMENDED ROLLBACK STRATEGIES (Priority Order)
-- =========================================================

-- STRATEGY 1: ROLL FORWARD (PREFERRED) ✅
-- =========================================
-- Create a NEW migration that undoes the changes.
-- This is the safest and most traceable approach.
--
-- Example filename: YYYYMMDDHHMMSS_rollback_<original_change>.sql
--
-- Benefits:
--   - Maintains complete migration history
--   - Can be tested in staging before production
--   - Works with CI/CD pipelines
--   - Preserves data integrity
--
-- When to use: ALWAYS prefer this approach in production

-- STRATEGY 2: POINT-IN-TIME RECOVERY (PITR) ⏱️
-- =============================================
-- Restore database to a state before the problematic migration.
-- Uses PostgreSQL's Write-Ahead Log (WAL) archiving.
--
-- Commands (PostgreSQL):
--   pg_restore --host=<host> --port=5432 --username=<user> \
--     --dbname=<dbname> --verbose <backup_file>
--
-- Commands (Supabase):
--   1. Navigate to: Dashboard → Database → Backups
--   2. Select restore point (timestamp before migration)
--   3. Click "Restore" and confirm
--
-- Benefits:
--   - Fast recovery
--   - Guaranteed consistent state
--   - No custom rollback logic needed
--
-- Drawbacks:
--   - Loses ALL changes after snapshot (not just migration)
--   - Requires pre-migration backup
--   - Downtime during restore
--
-- When to use: Staging environments, catastrophic production failures

-- STRATEGY 3: MANUAL ROLLBACK SCRIPT ⚠️
-- ======================================
-- Last resort: Manually crafted SQL to undo specific changes.
-- Should ONLY be used when roll-forward is impossible.
--
-- When to use:
--   - Emergency production hotfix
--   - Roll-forward script not ready
--   - Data loss acceptable for rolled-back changes
--
-- CRITICAL WARNINGS:
--   - Test extensively in staging first
--   - May cause data loss
--   - May violate foreign key constraints
--   - May leave orphaned data
--   - High risk of human error

-- =========================================================
-- TEMPLATE: ROLL-FORWARD MIGRATION (STRATEGY 1)
-- =========================================================
-- Use this template to create a NEW migration that undoes changes.
-- Filename: YYYYMMDDHHMMSS_rollback_<original_description>.sql

BEGIN;

-- =========================================================
-- PHASE 1: DOCUMENTATION
-- =========================================================
-- Purpose: Rollback changes from <ORIGINAL_MIGRATION_FILE>
-- Original Changes:
--   - <what was added>
--   - <what was modified>
--   - <what was deleted>
-- Rollback Actions:
--   - <undo action 1>
--   - <undo action 2>
-- Data Preservation:
--   - <what data will be preserved>
--   - <what data will be archived>
--   - <what data will be lost (if any)>

-- =========================================================
-- PHASE 2: ARCHIVE DATA (Before Dropping)
-- =========================================================
-- If rolling back will destroy data, archive it first

-- Example: Archive table data before dropping table
-- create table if not exists _archive_<table_name> as
-- select *, now() as archived_at
-- from <table_name>;

-- Example: Archive specific rows before deleting
-- create table if not exists _archive_<operation> (
--   archived_at timestamptz not null default now(),
--   archived_by uuid references auth.users(id),
--   data jsonb not null
-- );
--
-- insert into _archive_<operation> (data)
-- select to_jsonb(<table_name>.*) from <table_name>
-- where <condition>;

-- =========================================================
-- PHASE 3: DROP DEPENDENT OBJECTS (Reverse Order)
-- =========================================================
-- Drop in reverse order of creation to respect dependencies

-- Drop triggers first
-- drop trigger if exists trg_<table>_<trigger_name> on <table>;

-- Drop functions
-- drop function if exists <function_name>(<args>);

-- Drop policies
-- drop policy if exists "<policy_name>" on <table>;

-- Drop indexes
-- drop index if exists idx_<table>_<column>;

-- =========================================================
-- PHASE 4: REVERT SCHEMA CHANGES
-- =========================================================
-- Undo DDL changes from original migration

-- Example: Drop table (if created in original migration)
-- drop table if exists <table_name> cascade;

-- Example: Drop column (if added in original migration)
-- alter table <table_name> drop column if exists <column_name>;

-- Example: Rename column back (if renamed in original migration)
-- alter table <table_name> rename column <new_name> to <old_name>;

-- Example: Revert column type change
-- alter table <table_name>
-- alter column <column_name> set data type <original_type>
-- using <column_name>::<original_type>;

-- Example: Drop constraint (if added in original migration)
-- alter table <table_name> drop constraint if exists <constraint_name>;

-- Example: Re-add constraint (if removed in original migration)
-- alter table <table_name> add constraint <constraint_name>
-- check (<original_condition>);

-- =========================================================
-- PHASE 5: RESTORE PREVIOUS BEHAVIOR
-- =========================================================
-- Recreate objects that were modified/dropped

-- Example: Recreate function with original logic
-- create or replace function <function_name>(<args>)
-- returns <return_type> as $$
-- begin
--   -- Original function logic
-- end;
-- $$ language plpgsql;

-- Example: Restore RLS policy with original logic
-- create policy "<original_policy_name>"
--   on <table>
--   for <operation>
--   to <role>
--   using (<original_condition>)
--   with check (<original_condition>);

-- =========================================================
-- PHASE 6: DATA MIGRATION (If Needed)
-- =========================================================
-- Migrate data back to previous format

-- Example: Restore data from archive
-- insert into <table_name> (<columns>)
-- select <columns> from _archive_<table_name>
-- on conflict do nothing;

-- Example: Revert data transformations
-- update <table_name>
-- set <column> = <original_value>
-- where <condition>;

-- =========================================================
-- PHASE 7: VALIDATION
-- =========================================================
-- Verify rollback was successful

-- Validate table state
-- do $$
-- begin
--   if exists (select 1 from information_schema.tables where table_name = '<dropped_table>') then
--     raise exception 'Rollback validation failed: table <dropped_table> still exists';
--   end if;
-- end $$;

-- Validate RLS policies
-- do $$
-- begin
--   if exists (select 1 from pg_policies where tablename = '<table>' and policyname = '<removed_policy>') then
--     raise exception 'Rollback validation failed: policy <removed_policy> still exists';
--   end if;
-- end $$;

COMMIT;

-- =========================================================
-- POST-ROLLBACK CHECKLIST
-- =========================================================
-- [ ] Verify application functionality still works
-- [ ] Check for orphaned data in archive tables
-- [ ] Run ANALYZE on affected tables
-- [ ] Monitor application logs for errors
-- [ ] Validate RLS policies with test users
-- [ ] Update documentation to reflect rollback
-- [ ] Notify team of rollback completion

-- =========================================================
-- TEMPLATE: MANUAL ROLLBACK SCRIPT (STRATEGY 3 - EMERGENCY)
-- =========================================================
-- WARNING: ONLY USE IN EMERGENCIES!
-- Prefer STRATEGY 1 (Roll-Forward) or STRATEGY 2 (PITR) instead.

-- BEGIN;  -- Uncomment when ready to execute
--
-- -- Step 1: Document why manual rollback is necessary
-- -- Reason: <emergency situation>
-- -- Approved by: <name>
-- -- Risk assessment: <high/medium/low>
--
-- -- Step 2: Create safety backup
-- -- pg_dump --format=custom --file=/tmp/emergency_backup_$(date +%s).dump \
-- --   --schema=public --table=<affected_table> <database>
--
-- -- Step 3: Disable constraints temporarily (if needed)
-- -- alter table <table> disable trigger all;
-- -- alter table <table> disable row level security;
--
-- -- Step 4: Perform rollback operations
-- -- <rollback SQL here>
--
-- -- Step 5: Re-enable constraints
-- -- alter table <table> enable trigger all;
-- -- alter table <table> enable row level security;
--
-- -- Step 6: Validate integrity
-- -- select count(*) from <table>;  -- Expected: <count>
--
-- -- COMMIT;  -- Only commit after validation!

-- =========================================================
-- ROLLBACK DECISION MATRIX
-- =========================================================
--
-- | Situation                          | Strategy         | Downtime | Data Loss Risk |
-- |------------------------------------|------------------|----------|----------------|
-- | Staging environment                | PITR (Strategy 2)| High     | Acceptable     |
-- | Production, minor schema change    | Roll-Forward (1) | None     | None           |
-- | Production, data corruption        | PITR (Strategy 2)| High     | Minimal        |
-- | Production, critical emergency     | Manual (3)       | Medium   | High           |
-- | Production, breaking change        | Roll-Forward (1) | None     | None           |
-- | Development/local                  | DROP DATABASE    | N/A      | N/A            |
--
-- =========================================================
-- BEST PRACTICES FOR ROLLBACK SAFETY
-- =========================================================
--
-- 1. ALWAYS take a backup BEFORE applying any migration
--    Supabase: Manual backup via Dashboard → Database → Backups → Create Backup
--
-- 2. Test rollback in staging BEFORE production
--    - Apply migration in staging
--    - Apply rollback migration in staging
--    - Verify application functionality
--
-- 3. Use transactions for atomicity
--    - Wrap all operations in BEGIN/COMMIT
--    - Use SAVEPOINT for sub-transactions
--    - ROLLBACK automatically on error
--
-- 4. Archive data before destroying
--    - Create _archive_<table> tables
--    - Store dropped rows as JSONB
--    - Add archived_at timestamp
--
-- 5. Validate extensively after rollback
--    - Check row counts
--    - Verify foreign key integrity
--    - Test RLS policies
--    - Monitor application logs
--
-- 6. Document everything
--    - Why rollback was needed
--    - What changed
--    - Who approved
--    - Lessons learned
--
-- 7. Never modify past migrations
--    - Migrations are immutable
--    - Create new migration to fix
--    - Maintain audit trail
--
-- =========================================================
-- EMERGENCY CONTACTS
-- =========================================================
-- DBA On-Call: <phone/slack>
-- DevOps Lead: <phone/slack>
-- Supabase Support: https://supabase.com/dashboard/support
-- PostgreSQL Slack: https://postgresteam.slack.com
--
-- =========================================================
-- REFERENCES
-- =========================================================
-- - PostgreSQL PITR: https://www.postgresql.org/docs/current/continuous-archiving.html
-- - Supabase Backups: https://supabase.com/docs/guides/platform/backups
-- - Graphile Migrate Philosophy: https://github.com/graphile/migrate
-- - pgroll Zero-Downtime: https://github.com/xataio/pgroll
-- - Postgres Rollback Guide: https://www.bytebase.com/blog/postgres-rollback/
-- =========================================================
