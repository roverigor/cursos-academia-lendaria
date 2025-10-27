# Row Level Security (RLS) Patterns & Best Practices

Comprehensive guide for designing, implementing, and optimizing Row Level Security policies in Supabase/PostgreSQL for multi-tenant applications.

## Core Principles

1. **Defense in Depth** - RLS + constraints + triggers + validation layers
2. **Performance First** - Index columns used in policies
3. **Helper Functions** - Reusable, testable, optimizable
4. **Least Privilege** - Default deny, explicit allow
5. **Test Continuously** - Positive and negative cases

## Multi-Tenant Patterns

### Pattern 1: Simple Owner-Based (KISS)

**Use case:** Each user owns their data, no sharing

**Schema:**
```sql
CREATE TABLE minds (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_mind_id uuid NOT NULL REFERENCES auth.users(id),
  name text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Critical: Index for RLS performance
CREATE INDEX idx_minds_creator ON minds(creator_mind_id);
```

**Policy:**
```sql
ALTER TABLE minds ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS minds_rw ON minds;
CREATE POLICY minds_rw
  ON minds
  FOR ALL
  TO authenticated
  USING (creator_mind_id = auth.uid())
  WITH CHECK (creator_mind_id = auth.uid());
```

**Strengths:**
- Simple, easy to understand
- Fast (single index lookup)
- Hard to misconfigure

**When to use:**
- Single-user data (notes, profiles)
- No collaboration needed
- MVP/prototyping

### Pattern 2: Helper Function-Based (Recommended)

**Use case:** Complex ownership rules, needs testing/optimization

**Schema:**
```sql
CREATE TABLE minds (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_mind_id uuid NOT NULL,
  visibility text DEFAULT 'private' CHECK (visibility IN ('private', 'public', 'shared')),
  -- other fields...
);

-- Indexes for RLS helpers
CREATE INDEX idx_minds_creator ON minds(creator_mind_id);
CREATE INDEX idx_minds_visibility ON minds(visibility) WHERE visibility = 'public';
CREATE INDEX idx_mind_members_user ON mind_members(user_id);
CREATE INDEX idx_mind_members_mind ON mind_members(mind_id);
```

**Helper Functions:**
```sql
-- Check if user can view a mind
CREATE OR REPLACE FUNCTION can_view_mind(target_mind_id uuid)
RETURNS boolean AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM minds
    WHERE id = target_mind_id
      AND (
        -- Owner
        creator_mind_id = auth.uid()
        -- Public mind
        OR visibility = 'public'
        -- Shared with user
        OR EXISTS (
          SELECT 1 FROM mind_members
          WHERE mind_id = target_mind_id
            AND user_id = auth.uid()
            AND access_granted = true
        )
      )
  );
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- Check if user can edit a mind
CREATE OR REPLACE FUNCTION can_edit_mind(target_mind_id uuid)
RETURNS boolean AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM minds
    WHERE id = target_mind_id
      AND (
        -- Owner
        creator_mind_id = auth.uid()
        -- Editor permission
        OR EXISTS (
          SELECT 1 FROM mind_members
          WHERE mind_id = target_mind_id
            AND user_id = auth.uid()
            AND role IN ('editor', 'admin')
        )
      )
  );
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;
```

**Policies:**
```sql
ALTER TABLE minds ENABLE ROW LEVEL SECURITY;

-- Read policy (uses helper)
DROP POLICY IF EXISTS minds_select ON minds;
CREATE POLICY minds_select
  ON minds
  FOR SELECT
  TO authenticated
  USING (can_view_mind(id));

-- Write policy (uses helper)
DROP POLICY IF EXISTS minds_update ON minds;
CREATE POLICY minds_update
  ON minds
  FOR UPDATE
  TO authenticated
  USING (can_edit_mind(id))
  WITH CHECK (can_edit_mind(id));

-- Insert policy (owner only)
DROP POLICY IF EXISTS minds_insert ON minds;
CREATE POLICY minds_insert
  ON minds
  FOR INSERT
  TO authenticated
  WITH CHECK (creator_mind_id = auth.uid());

-- Delete policy (owner only)
DROP POLICY IF EXISTS minds_delete ON minds;
CREATE POLICY minds_delete
  ON minds
  FOR DELETE
  TO authenticated
  USING (creator_mind_id = auth.uid());
```

**Strengths:**
- Centralized logic (change once, apply everywhere)
- Testable in isolation
- Easier to optimize (one function)
- Self-documenting

**When to use:**
- Multi-tenant with sharing
- Complex permission rules
- Production systems

### Pattern 3: Role-Based Access Control (RBAC)

**Use case:** Explicit roles per resource (viewer/editor/admin)

**Schema:**
```sql
CREATE TABLE mind_members (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id uuid NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role text NOT NULL CHECK (role IN ('viewer', 'editor', 'admin')),
  created_at timestamptz DEFAULT now(),
  UNIQUE(mind_id, user_id)
);

-- Indexes for RLS lookups
CREATE INDEX idx_mind_members_mind_user ON mind_members(mind_id, user_id);
CREATE INDEX idx_mind_members_user ON mind_members(user_id);
```

**Helper:**
```sql
CREATE OR REPLACE FUNCTION user_mind_role(target_mind_id uuid)
RETURNS text AS $$
  SELECT
    CASE
      WHEN m.creator_mind_id = auth.uid() THEN 'owner'
      ELSE COALESCE(mm.role, 'none')
    END
  FROM minds m
  LEFT JOIN mind_members mm ON mm.mind_id = m.id AND mm.user_id = auth.uid()
  WHERE m.id = target_mind_id;
$$ LANGUAGE sql STABLE SECURITY DEFINER;
```

**Policies:**
```sql
-- Sources inherit mind permissions
CREATE POLICY sources_select
  ON sources
  FOR SELECT
  TO authenticated
  USING (user_mind_role(mind_id) IN ('owner', 'admin', 'editor', 'viewer'));

CREATE POLICY sources_insert
  ON sources
  FOR INSERT
  TO authenticated
  WITH CHECK (user_mind_role(mind_id) IN ('owner', 'admin', 'editor'));

CREATE POLICY sources_update
  ON sources
  FOR UPDATE
  TO authenticated
  USING (user_mind_role(mind_id) IN ('owner', 'admin', 'editor'))
  WITH CHECK (user_mind_role(mind_id) IN ('owner', 'admin', 'editor'));

CREATE POLICY sources_delete
  ON sources
  FOR DELETE
  TO authenticated
  USING (user_mind_role(mind_id) IN ('owner', 'admin'));
```

**When to use:**
- Collaborative editing
- Organizations/teams
- Granular permissions

## Performance Optimization

### 1. Index Every Column in Policies

```sql
-- ❌ Bad: No index on creator_mind_id
CREATE POLICY minds_rw ON minds
  USING (creator_mind_id = auth.uid());

-- ✅ Good: Index for fast lookup
CREATE INDEX idx_minds_creator ON minds(creator_mind_id);
CREATE POLICY minds_rw ON minds
  USING (creator_mind_id = auth.uid());
```

### 2. Use STABLE Functions

```sql
-- ✅ Good: STABLE allows query planner optimization
CREATE OR REPLACE FUNCTION can_view_mind(target_mind_id uuid)
RETURNS boolean
LANGUAGE plpgsql
STABLE SECURITY DEFINER -- Key: STABLE
AS $$
BEGIN
  -- logic
END;
$$;
```

### 3. Avoid Heavy Subqueries in USING

```sql
-- ❌ Bad: Complex subquery per row
CREATE POLICY sources_select ON sources
  USING (
    EXISTS (
      SELECT 1 FROM minds
      WHERE id = sources.mind_id
        AND (
          creator_mind_id = auth.uid()
          OR EXISTS (SELECT 1 FROM mind_members WHERE ...)
        )
    )
  );

-- ✅ Good: Helper function (optimized once)
CREATE POLICY sources_select ON sources
  USING (can_view_mind(mind_id));
```

### 4. Partial Indexes for Filters

```sql
-- If most minds are private, optimize public lookups
CREATE INDEX idx_minds_public ON minds(id)
  WHERE visibility = 'public';
```

### 5. Composite Indexes for Multi-Column Lookups

```sql
-- Optimize: WHERE mind_id = X AND user_id = Y
CREATE INDEX idx_mind_members_mind_user ON mind_members(mind_id, user_id);
```

## Testing Patterns

### Test 1: Impersonation Test

```sql
-- Setup: Impersonate user A
SET role authenticated;
SET request.jwt.claims = '{"sub": "user-a-uuid", "email": "a@example.com"}';

-- Test: Can see own data
SELECT count(*) FROM minds WHERE creator_mind_id = auth.uid();
-- Expected: > 0

-- Test: Cannot see other user's data
SELECT count(*) FROM minds WHERE creator_mind_id != auth.uid() AND visibility = 'private';
-- Expected: 0

-- Cleanup
RESET role;
RESET request.jwt.claims;
```

### Test 2: Cross-Tenant Isolation

```sql
-- Insert test data as user A
SET request.jwt.claims = '{"sub": "user-a-uuid"}';
INSERT INTO minds (creator_mind_id, name) VALUES (auth.uid(), 'Mind A');

-- Switch to user B
SET request.jwt.claims = '{"sub": "user-b-uuid"}';

-- Verify user B cannot see user A's mind
SELECT count(*) FROM minds WHERE name = 'Mind A';
-- Expected: 0 (unless shared)
```

### Test 3: Permission Escalation

```sql
-- User B tries to update user A's mind
SET request.jwt.claims = '{"sub": "user-b-uuid"}';

UPDATE minds SET name = 'Hacked' WHERE creator_mind_id != auth.uid();
-- Expected: 0 rows affected (blocked by RLS)
```

### Test 4: Public Data Access

```sql
-- User A creates public mind
SET request.jwt.claims = '{"sub": "user-a-uuid"}';
INSERT INTO minds (creator_mind_id, name, visibility) VALUES (auth.uid(), 'Public Mind', 'public');

-- User B can see public mind
SET request.jwt.claims = '{"sub": "user-b-uuid"}';
SELECT count(*) FROM minds WHERE name = 'Public Mind';
-- Expected: 1 (public data visible)
```

## Common Pitfalls

### 1. Forgetting to Enable RLS

```sql
-- ❌ Bad: RLS not enabled (wide open!)
CREATE TABLE minds (...);

-- ✅ Good: Enable immediately
CREATE TABLE minds (...);
ALTER TABLE minds ENABLE ROW LEVEL SECURITY;
```

### 2. Using VOLATILE Functions

```sql
-- ❌ Bad: VOLATILE recalculates per row
CREATE OR REPLACE FUNCTION can_view_mind(target_mind_id uuid)
RETURNS boolean
LANGUAGE plpgsql
VOLATILE -- Kills performance!
AS $$ ... $$;

-- ✅ Good: STABLE caches per statement
CREATE OR REPLACE FUNCTION can_view_mind(target_mind_id uuid)
RETURNS boolean
LANGUAGE plpgsql
STABLE SECURITY DEFINER
AS $$ ... $$;
```

### 3. Missing Indexes

```sql
-- ❌ Bad: Policy without index
CREATE POLICY minds_rw ON minds
  USING (creator_mind_id = auth.uid()); -- Seq scan!

-- ✅ Good: Index first
CREATE INDEX idx_minds_creator ON minds(creator_mind_id);
CREATE POLICY minds_rw ON minds
  USING (creator_mind_id = auth.uid()); -- Index scan
```

### 4. Overly Permissive WITH CHECK

```sql
-- ❌ Bad: User can insert with any creator_mind_id
CREATE POLICY minds_insert ON minds
  FOR INSERT
  WITH CHECK (true);

-- ✅ Good: Enforce ownership
CREATE POLICY minds_insert ON minds
  FOR INSERT
  WITH CHECK (creator_mind_id = auth.uid());
```

### 5. Service Role Bypass

```sql
-- ⚠️ Service role bypasses ALL RLS
const { data } = await supabase
  .from('minds')
  .select('*'); // Returns ALL minds (no RLS)

-- ✅ Use anon/authenticated role when RLS matters
const { data } = await supabase
  .auth.getSession() // Authenticated user
  .from('minds')
  .select('*'); // RLS enforced
```

## Migration Strategy

### Phase 1: Add RLS to Existing Tables

```sql
-- 1. Enable RLS (no policies yet - blocks all access)
ALTER TABLE minds ENABLE ROW LEVEL SECURITY;

-- 2. Create permissive policy for testing
CREATE POLICY minds_migration_temp
  ON minds
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- 3. Test application (should work but no isolation)

-- 4. Replace with real policies
DROP POLICY minds_migration_temp ON minds;

CREATE POLICY minds_select ON minds
  FOR SELECT TO authenticated
  USING (can_view_mind(id));

-- 5. Test again (verify isolation)
```

### Phase 2: Add Helper Functions

```sql
-- 1. Create helper
CREATE OR REPLACE FUNCTION can_view_mind(target_mind_id uuid)
RETURNS boolean AS $$ ... $$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- 2. Test helper directly
SELECT can_view_mind('mind-uuid'); -- Should return true/false

-- 3. Update policies to use helper
CREATE POLICY minds_select ON minds
  FOR SELECT USING (can_view_mind(id));
```

### Phase 3: Optimize

```sql
-- 1. Analyze queries
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM minds WHERE creator_mind_id = auth.uid();

-- 2. Add indexes
CREATE INDEX idx_minds_creator ON minds(creator_mind_id);

-- 3. Re-analyze (verify improvement)
```

## Checklist: RLS Deployment

- [ ] All user data tables have RLS enabled
- [ ] Every policy has corresponding index on filtered columns
- [ ] Helper functions marked as STABLE (not VOLATILE)
- [ ] Positive tests pass (user can access own data)
- [ ] Negative tests pass (user cannot access other data)
- [ ] Public data accessible without auth (if applicable)
- [ ] Service role usage audited (only where necessary)
- [ ] EXPLAIN ANALYZE shows index scans (not seq scans)
- [ ] Foreign key relationships respect RLS (cascade policies)
- [ ] Documentation updated with permission model

## Advanced Patterns

### Time-Based Access (Expiring Shares)

```sql
CREATE TABLE shares (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mind_id uuid NOT NULL REFERENCES minds(id),
  shared_with_email text NOT NULL,
  expires_at timestamptz NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE OR REPLACE FUNCTION can_view_via_share(target_mind_id uuid)
RETURNS boolean AS $$
  SELECT EXISTS (
    SELECT 1 FROM shares
    WHERE mind_id = target_mind_id
      AND shared_with_email = auth.email()
      AND expires_at > now()
  );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE POLICY minds_select_via_share ON minds
  FOR SELECT USING (can_view_via_share(id));
```

### Hierarchical Permissions (Org → Team → User)

```sql
CREATE OR REPLACE FUNCTION user_org_role(target_org_id uuid)
RETURNS text AS $$
  SELECT role FROM org_members
  WHERE org_id = target_org_id AND user_id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Cascade: Org admin can see all team data
CREATE POLICY teams_select ON teams
  FOR SELECT
  USING (
    user_org_role(org_id) IN ('admin', 'owner')
    OR team_id IN (SELECT team_id FROM team_members WHERE user_id = auth.uid())
  );
```

## Tools & Monitoring

### Audit RLS Coverage

```sql
-- Find tables without RLS
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename NOT LIKE 'pg_%'
  AND rowsecurity = false;
```

### Analyze Policy Performance

```sql
-- See which policies are used
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT * FROM minds WHERE creator_mind_id = auth.uid();

-- Look for: "Filter: (creator_mind_id = auth.uid())"
-- Want: Index scan, not Seq scan
```

### Log Policy Violations (Trigger)

```sql
CREATE TABLE rls_violations (
  id serial PRIMARY KEY,
  user_id uuid,
  table_name text,
  attempted_operation text,
  logged_at timestamptz DEFAULT now()
);

-- Log failed UPDATE attempts
CREATE OR REPLACE FUNCTION log_rls_violation()
RETURNS TRIGGER AS $$
BEGIN
  IF NOT can_edit_mind(NEW.id) THEN
    INSERT INTO rls_violations (user_id, table_name, attempted_operation)
    VALUES (auth.uid(), TG_TABLE_NAME, TG_OP);
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER minds_violation_log
  AFTER UPDATE ON minds
  FOR EACH ROW EXECUTE FUNCTION log_rls_violation();
```

## References

- [Supabase RLS Docs](https://supabase.com/docs/guides/auth/row-level-security)
- [PostgreSQL Row Security](https://www.postgresql.org/docs/current/ddl-rowsecurity.html)
- [RLS Performance Tips](https://supabase.com/docs/guides/database/postgres/row-level-security#rls-performance-recommendations)
- [Helper Functions Pattern](https://supabase.com/docs/guides/auth/row-level-security#helper-functions)
- [Testing RLS](https://supabase.com/docs/guides/database/postgres/row-level-security#testing-policies)
