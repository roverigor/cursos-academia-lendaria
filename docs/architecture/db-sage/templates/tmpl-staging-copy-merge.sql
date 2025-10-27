-- =========================================================
-- STAGING → COPY → MERGE PATTERN (Bulk Data Loading)
-- =========================================================
-- Purpose: Safely load large CSV/data files using PostgreSQL COPY
-- Performance: 10-100x faster than INSERT statements
-- Safety: Validate in staging before merging to production table
-- Reference: https://www.postgresql.org/docs/current/sql-copy.html
-- =========================================================

BEGIN;

-- =========================================================
-- PHASE 1: CREATE STAGING TABLE
-- =========================================================
-- Staging table matches production table structure
-- No constraints, indexes, or RLS for fast loading

drop table if exists <table_name>_staging cascade;

create unlogged table <table_name>_staging (
  -- Match production table columns exactly
  id uuid,
  user_id uuid,
  name text,
  created_at timestamptz,

  -- Add staging metadata
  _loaded_at timestamptz default now(),
  _source_file text,
  _row_number bigint generated always as identity
);

comment on table <table_name>_staging is
  'Temporary staging table for bulk data loading. Data validated here before merge.';

-- =========================================================
-- PHASE 2: LOAD DATA WITH COPY
-- =========================================================
-- COPY is 10-100x faster than INSERT
-- Run from psql or application with COPY protocol

-- Example 1: COPY from CSV file
\copy <table_name>_staging (id, user_id, name, created_at) FROM '/path/to/data.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NULL');

-- Example 2: COPY from STDIN (programmatic loading)
-- COPY <table_name>_staging (id, user_id, name, created_at)
-- FROM STDIN WITH (FORMAT csv, HEADER true);
-- <paste data here>
-- \.

-- Example 3: COPY from program output
-- COPY <table_name>_staging FROM PROGRAM 'cat /path/to/data.csv' WITH (FORMAT csv, HEADER true);

-- =========================================================
-- PHASE 3: VALIDATION
-- =========================================================
-- Check data quality before merging

-- Validation 1: Check for NULL required fields
select count(*) as null_required_fields
from <table_name>_staging
where id is null or user_id is null or name is null;
-- Expected: 0

-- Validation 2: Check for duplicate keys
select count(*), count(distinct id) as unique_ids
from <table_name>_staging;
-- Should match

-- Validation 3: Check foreign key validity
select count(*) as invalid_foreign_keys
from <table_name>_staging s
left join users u on u.id = s.user_id
where u.id is null;
-- Expected: 0

-- Validation 4: Check data format/ranges
select count(*) as invalid_dates
from <table_name>_staging
where created_at > now() or created_at < '2020-01-01';

-- =========================================================
-- PHASE 4: CLEAN & TRANSFORM
-- =========================================================
-- Fix data issues identified in validation

-- Remove duplicates (keep first occurrence)
delete from <table_name>_staging
where _row_number not in (
  select min(_row_number)
  from <table_name>_staging
  group by id
);

-- Trim whitespace
update <table_name>_staging
set name = trim(name)
where name != trim(name);

-- Set defaults for missing optional fields
update <table_name>_staging
set created_at = now()
where created_at is null;

-- =========================================================
-- PHASE 5: MERGE TO PRODUCTION TABLE
-- =========================================================
-- INSERT new rows, UPDATE existing rows

-- Strategy 1: INSERT ... ON CONFLICT (Upsert)
insert into <table_name> (id, user_id, name, created_at)
select id, user_id, name, created_at
from <table_name>_staging
on conflict (id) do update set
  name = excluded.name,
  updated_at = now();

-- Strategy 2: INSERT only new rows
-- insert into <table_name> (id, user_id, name, created_at)
-- select s.id, s.user_id, s.name, s.created_at
-- from <table_name>_staging s
-- left join <table_name> p on p.id = s.id
-- where p.id is null;

-- Strategy 3: UPDATE existing rows
-- update <table_name> p
-- set
--   name = s.name,
--   updated_at = now()
-- from <table_name>_staging s
-- where p.id = s.id;

-- =========================================================
-- PHASE 6: VERIFICATION
-- =========================================================
-- Verify merge completed successfully

-- Check row count matches
select
  (select count(*) from <table_name>_staging) as staged_rows,
  (select count(*) from <table_name>) as production_rows;

-- Spot check data integrity
select s.*, p.*
from <table_name>_staging s
join <table_name> p on p.id = s.id
limit 10;

-- =========================================================
-- PHASE 7: CLEANUP
-- =========================================================
-- Drop staging table after successful load

drop table <table_name>_staging;

COMMIT;

-- =========================================================
-- PERFORMANCE TIPS
-- =========================================================
-- 1. Use unlogged staging tables (no WAL overhead)
-- 2. No indexes/constraints on staging (add after load)
-- 3. COPY is 10-100x faster than INSERT
-- 4. Disable triggers during bulk load if safe
-- 5. Increase work_mem for large sorts/merges
-- 6. Run ANALYZE after bulk insert

-- Example: Disable triggers during load
-- ALTER TABLE <table_name> DISABLE TRIGGER ALL;
-- <perform bulk insert>
-- ALTER TABLE <table_name> ENABLE TRIGGER ALL;

-- Example: Increase work_mem for session
-- SET work_mem = '256MB';
-- <perform large merge>
-- RESET work_mem;
