-- ============================================================================
-- CLEANUP: Remove Accidental Versioned Backup Tables
-- ============================================================================
-- Date: 2025-10-28
-- Issue: Tables with _v0_7_0 suffix were accidentally created as backups
-- Impact: Clutters database, confuses schema, wastes space
-- Solution: Drop all versioned tables
--
-- SAFETY: Run in transaction, can be rolled back
-- ============================================================================

BEGIN;

-- Log what we're about to do
DO $$
BEGIN
    RAISE NOTICE 'Cleaning up accidental versioned backup tables...';
    RAISE NOTICE 'These tables will be DROPPED:';
    RAISE NOTICE '  - audience_profiles_v0_7_0';
    RAISE NOTICE '  - content_campaign_pieces_v0_7_0';
    RAISE NOTICE '  - content_campaigns_v0_7_0';
    RAISE NOTICE '  - content_frameworks_v0_7_0';
    RAISE NOTICE '  - content_performance_v0_7_0';
    RAISE NOTICE '  - content_pieces_v0_7_0';
    RAISE NOTICE '  - content_projects_v0_7_0';
END $$;

-- Drop the versioned tables (CASCADE to drop dependent objects)
DROP TABLE IF EXISTS audience_profiles_v0_7_0 CASCADE;
DROP TABLE IF EXISTS content_campaign_pieces_v0_7_0 CASCADE;
DROP TABLE IF EXISTS content_campaigns_v0_7_0 CASCADE;
DROP TABLE IF EXISTS content_frameworks_v0_7_0 CASCADE;
DROP TABLE IF EXISTS content_performance_v0_7_0 CASCADE;
DROP TABLE IF EXISTS content_pieces_v0_7_0 CASCADE;
DROP TABLE IF EXISTS content_projects_v0_7_0 CASCADE;

-- Verify cleanup
DO $$
DECLARE
    remaining_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO remaining_count
    FROM pg_tables
    WHERE schemaname = 'public'
      AND tablename LIKE '%_v0_%';

    IF remaining_count > 0 THEN
        RAISE WARNING 'Still have % versioned tables remaining!', remaining_count;
    ELSE
        RAISE NOTICE 'SUCCESS: All versioned backup tables removed!';
    END IF;
END $$;

COMMIT;

-- ============================================================================
-- Post-cleanup verification
-- ============================================================================
-- Run this to verify all tables are gone:
-- SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename LIKE '%_v0_%';
-- Should return 0 rows
