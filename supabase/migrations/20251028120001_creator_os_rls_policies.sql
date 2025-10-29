-- ============================================================================
-- CreatorOS RLS Security - Phase 2
-- ============================================================================
-- Purpose: Enable RLS and create KISS policies for multi-tenant security
-- Risk: Medium (security critical, test thoroughly)
-- Version: v0.9.1
-- Date: 2025-10-28
-- ============================================================================

BEGIN;

-- ============================================================================
-- 1. Enable RLS on CreatorOS tables
-- ============================================================================

-- content_projects: Core project table
ALTER TABLE content_projects ENABLE ROW LEVEL SECURITY;

-- contents: All content pieces (courses, modules, lessons, etc.)
ALTER TABLE contents ENABLE ROW LEVEL SECURITY;

-- audience_profiles: Target audience definitions
ALTER TABLE audience_profiles ENABLE ROW LEVEL SECURITY;

-- content_frameworks: Framework definitions (shared, no RLS for now)
-- Note: Frameworks are likely shared across users, so no RLS

-- content_minds: Junction table (protected via contents RLS)
ALTER TABLE content_minds ENABLE ROW LEVEL SECURITY;

-- content_tags: Junction table (protected via contents RLS)
ALTER TABLE content_tags ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- 2. Create RLS policies for content_projects
-- ============================================================================

-- KISS Policy: Users can only access projects they created
CREATE POLICY "content_projects_rw_mine"
ON content_projects
FOR ALL
TO authenticated
USING (creator_mind_id = current_mind_id())
WITH CHECK (creator_mind_id = current_mind_id());

COMMENT ON POLICY "content_projects_rw_mine" ON content_projects IS
    'KISS policy: Users can only read/write their own projects';

-- Read-only access for persona minds (if needed)
CREATE POLICY "content_projects_read_as_persona"
ON content_projects
FOR SELECT
TO authenticated
USING (persona_mind_id = current_mind_id());

COMMENT ON POLICY "content_projects_read_as_persona" ON content_projects IS
    'Allow reading projects where user is the persona (read-only)';

-- ============================================================================
-- 3. Create RLS policies for contents
-- ============================================================================

-- KISS Policy: Access contents via project ownership
CREATE POLICY "contents_rw_by_project"
ON contents
FOR ALL
TO authenticated
USING (
    project_id IN (
        SELECT id FROM content_projects
        WHERE creator_mind_id = current_mind_id()
    )
)
WITH CHECK (
    project_id IN (
        SELECT id FROM content_projects
        WHERE creator_mind_id = current_mind_id()
    )
);

COMMENT ON POLICY "contents_rw_by_project" ON contents IS
    'KISS policy: Users can read/write content in their own projects';

-- Allow reading published content (public access)
CREATE POLICY "contents_read_published"
ON contents
FOR SELECT
TO authenticated
USING (
    status = 'published'
    AND deleted_at IS NULL
);

COMMENT ON POLICY "contents_read_published" ON contents IS
    'Allow reading published content (public access)';

-- ============================================================================
-- 4. Create RLS policies for audience_profiles
-- ============================================================================

-- Note: audience_profiles are shared resources (no project_id)
-- For now, allow authenticated users to read all and create their own
-- In future, add creator_mind_id column for proper ownership

-- Allow all authenticated users to read audience profiles (shared resource)
CREATE POLICY "audience_profiles_read_all"
ON audience_profiles
FOR SELECT
TO authenticated
USING (true);

COMMENT ON POLICY "audience_profiles_read_all" ON audience_profiles IS
    'Allow reading all audience profiles (shared resource)';

-- Allow authenticated users to create/update/delete
-- TODO: Add creator_mind_id column and restrict to own profiles
CREATE POLICY "audience_profiles_write_all"
ON audience_profiles
FOR INSERT
TO authenticated
WITH CHECK (true);

COMMENT ON POLICY "audience_profiles_write_all" ON audience_profiles IS
    'Allow creating audience profiles (TODO: add creator_mind_id for ownership)';

-- ============================================================================
-- 5. Create RLS policies for junction tables
-- ============================================================================

-- content_minds: Access via contents RLS
CREATE POLICY "content_minds_via_content"
ON content_minds
FOR ALL
TO authenticated
USING (
    content_id IN (
        SELECT id FROM contents
        WHERE project_id IN (
            SELECT id FROM content_projects
            WHERE creator_mind_id = current_mind_id()
        )
    )
);

COMMENT ON POLICY "content_minds_via_content" ON content_minds IS
    'Access content_minds via contents RLS (implicit protection)';

-- content_tags: Access via contents RLS
CREATE POLICY "content_tags_via_content"
ON content_tags
FOR ALL
TO authenticated
USING (
    content_id IN (
        SELECT id FROM contents
        WHERE project_id IN (
            SELECT id FROM content_projects
            WHERE creator_mind_id = current_mind_id()
        )
    )
);

COMMENT ON POLICY "content_tags_via_content" ON content_tags IS
    'Access content_tags via contents RLS (implicit protection)';

-- ============================================================================
-- Validation queries
-- ============================================================================

DO $$
DECLARE
    v_rls_count INTEGER;
    v_policy_count INTEGER;
BEGIN
    -- Verify RLS enabled
    SELECT COUNT(*) INTO v_rls_count
    FROM pg_tables
    WHERE schemaname = 'public'
      AND tablename IN ('content_projects', 'contents', 'audience_profiles', 'content_minds', 'content_tags')
      AND rowsecurity = true;

    IF v_rls_count = 5 THEN
        RAISE NOTICE '✓ RLS enabled on 5/5 tables';
    ELSE
        RAISE EXCEPTION '✗ RLS not enabled on all tables (enabled on %/5)', v_rls_count;
    END IF;

    -- Count policies
    SELECT COUNT(*) INTO v_policy_count
    FROM pg_policies
    WHERE schemaname = 'public'
      AND tablename LIKE 'content%'
      OR tablename = 'audience_profiles';

    IF v_policy_count >= 6 THEN
        RAISE NOTICE '✓ Created % RLS policies', v_policy_count;
    ELSE
        RAISE EXCEPTION '✗ Expected at least 6 policies, found %', v_policy_count;
    END IF;

    RAISE NOTICE '✓ Phase 2 (RLS Security) completed successfully';
    RAISE NOTICE '⚠️  IMPORTANT: Test RLS with impersonation before production use!';
    RAISE NOTICE '    Run: psql -f supabase/tests/test_creator_os_rls.sql';
END $$;

COMMIT;
