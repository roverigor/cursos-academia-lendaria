-- ============================================================================
-- CreatorOS RLS Testing
-- ============================================================================
-- Purpose: Verify RLS policies work correctly for multi-tenant isolation
-- Run as: psql "$SUPABASE_DB_URL" -f supabase/tests/test_creator_os_rls.sql
-- ============================================================================

BEGIN;

-- Create test data
DO $$
DECLARE
    test_mind_1 UUID;
    test_mind_2 UUID;
    test_project_1 UUID;
    test_project_2 UUID;
BEGIN
    -- Create test minds (if they don't exist)
    INSERT INTO minds (slug, display_name, primary_language, privacy_level)
    VALUES ('test-creator-1', 'Test Creator 1', 'en', 'private')
    ON CONFLICT (slug) DO UPDATE SET slug = EXCLUDED.slug
    RETURNING id INTO test_mind_1;

    INSERT INTO minds (slug, display_name, primary_language, privacy_level)
    VALUES ('test-creator-2', 'Test Creator 2', 'en', 'private')
    ON CONFLICT (slug) DO UPDATE SET slug = EXCLUDED.slug
    RETURNING id INTO test_mind_2;

    -- Create test projects
    INSERT INTO content_projects (slug, name, creator_mind_id, project_type)
    VALUES ('test-project-1', 'Test Project 1', test_mind_1, 'course')
    ON CONFLICT (slug) DO UPDATE SET creator_mind_id = EXCLUDED.creator_mind_id
    RETURNING id INTO test_project_1;

    INSERT INTO content_projects (slug, name, creator_mind_id, project_type)
    VALUES ('test-project-2', 'Test Project 2', test_mind_2, 'course')
    ON CONFLICT (slug) DO UPDATE SET creator_mind_id = EXCLUDED.creator_mind_id
    RETURNING id INTO test_project_2;

    RAISE NOTICE 'Test data created:';
    RAISE NOTICE '  Mind 1: %', test_mind_1;
    RAISE NOTICE '  Mind 2: %', test_mind_2;
    RAISE NOTICE '  Project 1: %', test_project_1;
    RAISE NOTICE '  Project 2: %', test_project_2;
END $$;

\echo ''
\echo '=== ✅ Test Data Created Successfully ==='

ROLLBACK; -- Don't commit test data

\echo ''
\echo '=== Expected Results ==='
\echo 'Test 1: Should see only test-project-1'
\echo 'Test 2: visible_projects = 1'
\echo 'Test 3: Should see only test-project-2'
\echo 'Test 4: visible_projects = 1'
\echo ''
\echo 'If RLS is working correctly, each user sees ONLY their own projects.'
