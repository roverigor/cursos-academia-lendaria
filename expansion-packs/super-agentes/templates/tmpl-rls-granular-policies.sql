-- =========================================================
-- RLS GRANULAR POLICIES TEMPLATE
-- =========================================================
-- Table: <TABLE_NAME>
-- Created: <YYYY-MM-DD HH:MM:SS UTC>
-- Author: <YOUR_NAME>
--
-- Purpose: Granular Row Level Security policies for fine-grained control
-- Security Model: <User-Owned | Role-Based | Multi-Tenant | Hierarchical>
--
-- Performance: All policies optimized with cached auth.uid() (99.99% faster)
-- Reference: https://supabase.com/docs/guides/troubleshooting/rls-performance-and-best-practices
-- =========================================================

BEGIN;

-- =========================================================
-- STEP 1: ENABLE RLS
-- =========================================================
-- CRITICAL: Always enable RLS, even for public tables

alter table <table_name> enable row level security;

-- Verify RLS is enabled
do $$
begin
  if not exists (
    select 1 from pg_tables
    where tablename = '<table_name>'
    and rowsecurity = true
  ) then
    raise exception 'RLS not enabled on <table_name>';
  end if;
end $$;

-- =========================================================
-- STEP 2: DROP EXISTING POLICIES (Idempotent)
-- =========================================================
-- Drop old policies to ensure clean slate

drop policy if exists "<table_name>_select" on <table_name>;
drop policy if exists "<table_name>_insert" on <table_name>;
drop policy if exists "<table_name>_update" on <table_name>;
drop policy if exists "<table_name>_delete" on <table_name>;

-- Drop any anon/public policies
drop policy if exists "<table_name>_select_anon" on <table_name>;
drop policy if exists "<table_name>_select_public" on <table_name>;

-- =========================================================
-- PATTERN 1: USER-OWNED DATA (Most Common)
-- =========================================================
-- Users can only access their own rows
-- Use case: User profiles, user posts, user settings

-- SELECT: Users read own rows
-- CRITICAL: Wrap auth.uid() in SELECT for 99.99% performance improvement
create policy "<table_name>_select"
  on <table_name>
  for select
  to authenticated
  using (
    (select auth.uid()) is not null and
    (select auth.uid()) = user_id
  );

-- INSERT: Users create own rows
create policy "<table_name>_insert"
  on <table_name>
  for insert
  to authenticated
  with check (
    (select auth.uid()) is not null and
    (select auth.uid()) = user_id
  );

-- UPDATE: Users update own rows
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

-- DELETE: Users delete own rows
create policy "<table_name>_delete"
  on <table_name>
  for delete
  to authenticated
  using (
    (select auth.uid()) is not null and
    (select auth.uid()) = user_id
  );

-- =========================================================
-- PATTERN 2: PUBLIC READ, AUTHENTICATED WRITE
-- =========================================================
-- Anyone can read, only logged-in users can modify
-- Use case: Blog posts, product listings, public content

-- SELECT: Public read access
-- create policy "<table_name>_select_public"
--   on <table_name>
--   for select
--   to anon, authenticated
--   using (true);

-- INSERT: Authenticated users only
-- create policy "<table_name>_insert"
--   on <table_name>
--   for insert
--   to authenticated
--   with check (
--     (select auth.uid()) is not null and
--     (select auth.uid()) = user_id
--   );

-- UPDATE: Users update own content
-- create policy "<table_name>_update"
--   on <table_name>
--   for update
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     (select auth.uid()) = user_id
--   )
--   with check (
--     (select auth.uid()) is not null and
--     (select auth.uid()) = user_id
--   );

-- DELETE: Users delete own content
-- create policy "<table_name>_delete"
--   on <table_name>
--   for delete
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     (select auth.uid()) = user_id
--   );

-- =========================================================
-- PATTERN 3: ROLE-BASED ACCESS (JWT Claims)
-- =========================================================
-- Access based on user role stored in JWT
-- Use case: Admin panels, moderation tools, privileged operations

-- SELECT: Role-based read
-- create policy "<table_name>_select_role"
--   on <table_name>
--   for select
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     (
--       -- Users see own rows
--       (select auth.uid()) = user_id
--       or
--       -- Admins see everything
--       (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
--       or
--       -- Moderators see non-deleted content
--       (
--         (auth.jwt() -> 'app_metadata' ->> 'role') = 'moderator' and
--         deleted_at is null
--       )
--     )
--   );

-- INSERT: Role-based create
-- create policy "<table_name>_insert_role"
--   on <table_name>
--   for insert
--   to authenticated
--   with check (
--     (select auth.uid()) is not null and
--     (
--       -- Regular users create own rows
--       (select auth.uid()) = user_id
--       or
--       -- Admins can create for anyone
--       (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
--     )
--   );

-- UPDATE: Role-based modify
-- create policy "<table_name>_update_role"
--   on <table_name>
--   for update
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     (
--       (select auth.uid()) = user_id
--       or
--       (auth.jwt() -> 'app_metadata' ->> 'role') in ('admin', 'moderator')
--     )
--   )
--   with check (
--     (select auth.uid()) is not null and
--     (
--       (select auth.uid()) = user_id
--       or
--       (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
--     )
--   );

-- DELETE: Admin-only delete
-- create policy "<table_name>_delete_role"
--   on <table_name>
--   for delete
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
--   );

-- =========================================================
-- PATTERN 4: MULTI-TENANT (Organization/Team)
-- =========================================================
-- Access scoped to user's organization/team
-- Use case: SaaS applications, team workspaces, multi-tenant systems

-- CRITICAL: Optimize join pattern for performance
-- ✅ FAST:   team_id IN (SELECT team_id FROM team_user WHERE user_id = auth.uid())
-- ❌ SLOW:   auth.uid() IN (SELECT user_id FROM team_user WHERE team_id = table.team_id)

-- SELECT: Team members read team data
-- create policy "<table_name>_select_tenant"
--   on <table_name>
--   for select
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     team_id in (
--       select team_id
--       from team_members
--       where user_id = (select auth.uid())
--       and status = 'active'
--     )
--   );

-- INSERT: Team members create team data
-- create policy "<table_name>_insert_tenant"
--   on <table_name>
--   for insert
--   to authenticated
--   with check (
--     (select auth.uid()) is not null and
--     team_id in (
--       select team_id
--       from team_members
--       where user_id = (select auth.uid())
--       and status = 'active'
--       and role in ('admin', 'member')
--     )
--   );

-- UPDATE: Team members with permission
-- create policy "<table_name>_update_tenant"
--   on <table_name>
--   for update
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     team_id in (
--       select team_id
--       from team_members
--       where user_id = (select auth.uid())
--       and status = 'active'
--     )
--   )
--   with check (
--     (select auth.uid()) is not null and
--     team_id in (
--       select team_id
--       from team_members
--       where user_id = (select auth.uid())
--       and status = 'active'
--       and role in ('admin', 'member')
--     )
--   );

-- DELETE: Team admins only
-- create policy "<table_name>_delete_tenant"
--   on <table_name>
--   for delete
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     team_id in (
--       select team_id
--       from team_members
--       where user_id = (select auth.uid())
--       and role = 'admin'
--     )
--   );

-- =========================================================
-- PATTERN 5: TIME-BASED ACCESS
-- =========================================================
-- Access based on time conditions
-- Use case: Scheduled content, embargoed data, temporary access

-- SELECT: Published content after publish date
-- create policy "<table_name>_select_published"
--   on <table_name>
--   for select
--   to anon, authenticated
--   using (
--     published_at is not null and
--     published_at <= now() and
--     (expires_at is null or expires_at > now())
--   );

-- SELECT: Authors can see unpublished
-- create policy "<table_name>_select_draft"
--   on <table_name>
--   for select
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     (select auth.uid()) = user_id
--   );

-- =========================================================
-- PATTERN 6: HIERARCHICAL ACCESS (Parent-Child)
-- =========================================================
-- Access based on parent object ownership
-- Use case: Comments on posts, replies to threads

-- SELECT: Access if you have access to parent
-- create policy "<table_name>_select_via_parent"
--   on <table_name>
--   for select
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     exists (
--       select 1
--       from parent_table p
--       where p.id = <table_name>.parent_id
--       and (
--         p.user_id = (select auth.uid())
--         or
--         p.visibility = 'public'
--       )
--     )
--   );

-- INSERT: Create if you have access to parent
-- create policy "<table_name>_insert_via_parent"
--   on <table_name>
--   for insert
--   to authenticated
--   with check (
--     (select auth.uid()) is not null and
--     exists (
--       select 1
--       from parent_table p
--       where p.id = <table_name>.parent_id
--       and (
--         p.user_id = (select auth.uid())
--         or
--         p.allow_comments = true
--       )
--     )
--   );

-- =========================================================
-- PATTERN 7: SECURITY DEFINER FUNCTION (Performance Optimization)
-- =========================================================
-- Use security definer function for complex cross-table checks
-- Bypasses RLS for function internals (10-100x faster)

-- create or replace function user_has_access_to_<table>(row_id uuid)
-- returns boolean as $$
-- declare
--   has_access boolean;
-- begin
--   -- This function runs with security definer (no RLS penalty)
--   select exists(
--     select 1
--     from <table_name> t
--     join <related_table> r on r.id = t.related_id
--     where t.id = row_id
--     and r.user_id = auth.uid()
--   ) into has_access;

--   return has_access;
-- end;
-- $$ language plpgsql security definer stable;

-- SELECT: Use security definer function
-- create policy "<table_name>_select_via_function"
--   on <table_name>
--   for select
--   to authenticated
--   using (
--     (select auth.uid()) is not null and
--     user_has_access_to_<table>(id)
--   );

-- =========================================================
-- STEP 3: ADD POLICY COMMENTS (Documentation)
-- =========================================================

comment on policy "<table_name>_select" on <table_name> is
  'Users can read own rows (auth.uid() cached for performance)';

comment on policy "<table_name>_insert" on <table_name> is
  'Users can insert own rows (auth.uid() = user_id enforced)';

comment on policy "<table_name>_update" on <table_name> is
  'Users can update own rows (double check: USING and WITH CHECK)';

comment on policy "<table_name>_delete" on <table_name> is
  'Users can delete own rows (soft delete recommended instead)';

-- =========================================================
-- STEP 4: CREATE REQUIRED INDEXES (CRITICAL for Performance)
-- =========================================================
-- Without indexes, RLS policies will scan entire table!

-- CRITICAL: Index on user_id (100x+ performance improvement)
create index concurrently if not exists idx_<table>_user_id
  on <table_name>(user_id)
  where deleted_at is null;

-- If using team_id pattern
-- create index concurrently if not exists idx_<table>_team_id
--   on <table_name>(team_id)
--   where deleted_at is null;

-- If using time-based pattern
-- create index concurrently if not exists idx_<table>_published
--   on <table_name>(published_at, expires_at)
--   where published_at is not null;

-- =========================================================
-- STEP 5: VALIDATION & TESTING
-- =========================================================

-- Verify policies exist
do $$
declare
  policy_count int;
begin
  select count(*) into policy_count
  from pg_policies
  where tablename = '<table_name>';

  if policy_count < 4 then
    raise exception 'Expected at least 4 policies on <table_name>, found %', policy_count;
  end if;

  raise notice 'Validation passed: % policies created on <table_name>', policy_count;
end $$;

-- Verify indexes exist
do $$
begin
  if not exists (
    select 1 from pg_indexes
    where tablename = '<table_name>'
    and indexname = 'idx_<table>_user_id'
  ) then
    raise exception 'Required index idx_<table>_user_id not found';
  end if;

  raise notice 'Validation passed: Required indexes exist';
end $$;

COMMIT;

-- =========================================================
-- POST-DEPLOYMENT TESTING
-- =========================================================
-- Test policies with different users and roles

-- Test 1: Anonymous user should see nothing (unless public policy exists)
-- set request.jwt.claims to '{}';
-- select count(*) from <table_name>;  -- Expected: 0

-- Test 2: Authenticated user should see only their rows
-- set request.jwt.claims to '{"sub":"test-user-id"}';
-- insert into <table_name> (user_id, name) values ('test-user-id', 'test');
-- select * from <table_name>;  -- Expected: 1 row (their own)

-- Test 3: User cannot see other users' rows
-- set request.jwt.claims to '{"sub":"different-user-id"}';
-- select * from <table_name>;  -- Expected: 0 rows

-- Test 4: Admin can see all rows (if role-based policy exists)
-- set request.jwt.claims to '{"sub":"admin-id","app_metadata":{"role":"admin"}}';
-- select * from <table_name>;  -- Expected: all rows

-- Test 5: Performance check with EXPLAIN
-- explain (analyze, buffers)
-- select * from <table_name> where user_id = 'test-user-id';
-- Should use Index Scan on idx_<table>_user_id

-- =========================================================
-- PERFORMANCE OPTIMIZATION CHECKLIST
-- =========================================================
-- [ ] Wrap auth.uid() in SELECT for caching
-- [ ] Add indexes on ALL columns used in policies
-- [ ] Use IN (SELECT) pattern for optimal join performance
-- [ ] Keep policy logic simple (complex logic → security definer function)
-- [ ] Avoid LIMIT/OFFSET in queries with RLS (scans all rows)
-- [ ] Monitor pg_stat_statements for slow RLS queries
-- [ ] Test with realistic data volumes (1M+ rows)
-- [ ] Consider security definer functions for cross-table checks

-- =========================================================
-- SECURITY CHECKLIST
-- =========================================================
-- [ ] RLS enabled on table
-- [ ] All operations covered (SELECT, INSERT, UPDATE, DELETE)
-- [ ] Separate policies for anon vs authenticated
-- [ ] Use app_metadata NOT user_metadata (user can modify user_metadata!)
-- [ ] Explicit NULL checks for auth.uid()
-- [ ] Test with impersonation (*impersonate command)
-- [ ] Validate policies don't allow privilege escalation
-- [ ] Document security model in comments

-- =========================================================
-- COMMON PITFALLS & FIXES
-- =========================================================

-- ❌ PITFALL 1: Forgetting NULL check
-- USING (auth.uid() = user_id)  -- FAILS for anon users silently
-- ✅ FIX: Always check IS NOT NULL
-- USING ((select auth.uid()) is not null and (select auth.uid()) = user_id)

-- ❌ PITFALL 2: Not wrapping auth.uid() in SELECT
-- USING (auth.uid() = user_id)  -- Calls function for EVERY row
-- ✅ FIX: Wrap in SELECT for caching
-- USING ((select auth.uid()) = user_id)  -- 99.99% faster

-- ❌ PITFALL 3: Using user_metadata for authorization
-- USING ((auth.jwt() -> 'user_metadata' ->> 'role') = 'admin')  -- DANGEROUS!
-- ✅ FIX: Use app_metadata (server-only)
-- USING ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')

-- ❌ PITFALL 4: Missing indexes on policy columns
-- No index on user_id → Full table scan on every query
-- ✅ FIX: Always index columns used in policies
-- CREATE INDEX idx_table_user_id ON table(user_id);

-- ❌ PITFALL 5: Inefficient join pattern
-- USING (auth.uid() IN (SELECT user_id FROM team WHERE team.team_id = table.team_id))
-- ✅ FIX: Reverse the join
-- USING (team_id IN (SELECT team_id FROM team WHERE user_id = auth.uid()))

-- =========================================================
-- REFERENCES
-- =========================================================
-- - Supabase RLS Performance: https://supabase.com/docs/guides/troubleshooting/rls-performance-and-best-practices
-- - PostgreSQL RLS Docs: https://www.postgresql.org/docs/current/ddl-rowsecurity.html
-- - Supabase RLS Guide: https://supabase.com/docs/guides/database/postgres/row-level-security
-- - Real-World Examples: https://medium.com/@jigsz6391/supabase-row-level-security-explained-with-real-examples-6d06ce8d221c
-- =========================================================
