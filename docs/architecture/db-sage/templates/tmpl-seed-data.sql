-- =========================================================
-- SEED DATA TEMPLATE (Idempotent)
-- =========================================================
-- Purpose: Load initial/reference data safely
-- Idempotent: Safe to run multiple times (INSERT ... ON CONFLICT)
-- Use case: Lookup tables, default categories, initial users
-- Reference: https://www.postgresql.org/docs/current/sql-insert.html
-- =========================================================

BEGIN;

-- =========================================================
-- SEED DATA STRATEGY
-- =========================================================
-- Always use INSERT ... ON CONFLICT for idempotency
-- This allows seeds to be re-run safely without duplicates

-- =========================================================
-- EXAMPLE 1: Categories/Tags (Lookup Data)
-- =========================================================

insert into categories (id, slug, name, description, sort_order)
values
  ('cat-tech', 'technology', 'Technology', 'Tech-related content', 10),
  ('cat-design', 'design', 'Design', 'Design and UX content', 20),
  ('cat-business', 'business', 'Business', 'Business strategies', 30)
on conflict (id) do update set
  name = excluded.name,
  description = excluded.description,
  sort_order = excluded.sort_order,
  updated_at = now();

-- =========================================================
-- EXAMPLE 2: User Roles (System Data)
-- =========================================================

insert into roles (id, name, permissions)
values
  ('role-admin', 'Admin', '{"all": true}'::jsonb),
  ('role-editor', 'Editor', '{"read": true, "write": true}'::jsonb),
  ('role-viewer', 'Viewer', '{"read": true}'::jsonb)
on conflict (id) do update set
  permissions = excluded.permissions;

-- =========================================================
-- EXAMPLE 3: Configuration (Key-Value)
-- =========================================================

insert into config (key, value, description)
values
  ('max_upload_size', '10485760', 'Max file upload size in bytes (10MB)'),
  ('session_timeout', '86400', 'Session timeout in seconds (24 hours)'),
  ('rate_limit', '100', 'API rate limit requests per minute')
on conflict (key) do update set
  value = excluded.value,
  description = excluded.description;

-- =========================================================
-- EXAMPLE 4: Test Users (Development Only)
-- =========================================================

-- Only insert test users in development/staging
-- do $$
-- begin
--   if current_database() not like '%_production%' then
--     insert into users (id, email, name, role_id)
--     values
--       ('test-admin', 'admin@example.com', 'Test Admin', 'role-admin'),
--       ('test-editor', 'editor@example.com', 'Test Editor', 'role-editor'),
--       ('test-viewer', 'viewer@example.com', 'Test Viewer', 'role-viewer')
--     on conflict (id) do nothing;
--   end if;
-- end $$;

-- =========================================================
-- EXAMPLE 5: Hierarchical Data (Parent-Child)
-- =========================================================

-- Insert parents first
insert into parent_table (id, name)
values
  ('parent-1', 'Parent 1'),
  ('parent-2', 'Parent 2')
on conflict (id) do update set
  name = excluded.name;

-- Then insert children
insert into child_table (id, parent_id, name)
values
  ('child-1-1', 'parent-1', 'Child 1.1'),
  ('child-1-2', 'parent-1', 'Child 1.2'),
  ('child-2-1', 'parent-2', 'Child 2.1')
on conflict (id) do update set
  name = excluded.name;

-- =========================================================
-- EXAMPLE 6: Many-to-Many Junction Data
-- =========================================================

-- Ensure both sides exist first
-- insert into table1 (id, name) values ...
-- insert into table2 (id, name) values ...

-- Then create relationships
-- insert into table1_table2 (table1_id, table2_id, metadata)
-- values
--   ('id1', 'id2', '{"role": "member"}'::jsonb)
-- on conflict (table1_id, table2_id) do update set
--   metadata = excluded.metadata;

-- =========================================================
-- VALIDATION
-- =========================================================

-- Verify expected row counts
do $$
declare
  category_count int;
  role_count int;
begin
  select count(*) into category_count from categories;
  select count(*) into role_count from roles;

  if category_count < 3 then
    raise exception 'Expected at least 3 categories, found %', category_count;
  end if;

  if role_count < 3 then
    raise exception 'Expected at least 3 roles, found %', role_count;
  end if;

  raise notice 'Seed data validation passed';
  raise notice '  Categories: %', category_count;
  raise notice '  Roles: %', role_count;
end $$;

COMMIT;

-- =========================================================
-- BEST PRACTICES
-- =========================================================
-- 1. Always use INSERT ... ON CONFLICT for idempotency
-- 2. Use meaningful, stable IDs (UUIDs or slugs, not serial)
-- 3. Insert in dependency order (parents before children)
-- 4. Validate counts after seeding
-- 5. Use DO blocks for conditional seeds (dev vs prod)
-- 6. Keep seeds in version control
-- 7. Document why each seed exists
-- 8. Never hard-code passwords (use environment variables)
