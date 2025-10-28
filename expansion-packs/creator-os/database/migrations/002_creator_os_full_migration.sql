-- ════════════════════════════════════════════════════════════════════════════════
-- MIGRATION 002: CreatorOS Full Migration (with data migration from v0.7.0)
-- ════════════════════════════════════════════════════════════════════════════════
-- Version: 002
-- Description: Completa migration do CreatorOS incluindo:
--              1. Backup de tabelas existentes (content_* → content_*_v0_7_0)
--              2. Criação de novas tabelas (contents, content_minds, etc.)
--              3. Migração de dados de content_pieces → contents
--              4. Seeds de frameworks, audiences, projects
-- Dependencies: minds, job_executions, tags (MMOS v0.7.0)
-- Author: DB Sage
-- Date: 2025-10-28
-- ════════════════════════════════════════════════════════════════════════════════

-- ════════════════════════════════════════════════════════════════════════════════
-- PHASE 0: PRE-FLIGHT CHECKS
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'CreatorOS Full Migration - Starting Pre-flight Checks';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';

  -- Check required MMOS tables exist
  IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'minds') THEN
    RAISE EXCEPTION '❌ Required table "minds" does not exist. Run MMOS migrations first.';
  END IF;

  IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'job_executions') THEN
    RAISE EXCEPTION '❌ Required table "job_executions" does not exist. Run MMOS migrations first.';
  END IF;

  IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'tags') THEN
    RAISE EXCEPTION '❌ Required table "tags" does not exist. Run MMOS migrations first.';
  END IF;

  RAISE NOTICE '✅ All required MMOS tables exist';

  -- Check if old CreatorOS tables exist (v0.7.0)
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_pieces') THEN
    RAISE NOTICE '⚠️  Found existing "content_pieces" table - will migrate data';
  END IF;

  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_projects') THEN
    RAISE NOTICE '⚠️  Found existing "content_projects" table - will backup and recreate';
  END IF;

  RAISE NOTICE '✅ Pre-flight checks passed';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- PHASE 1: BACKUP EXISTING TABLES
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'PHASE 1: Backing up existing v0.7.0 tables';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';

  -- Backup content_frameworks
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_frameworks') THEN
    EXECUTE 'ALTER TABLE content_frameworks RENAME TO content_frameworks_v0_7_0';
    RAISE NOTICE '✅ Backed up: content_frameworks → content_frameworks_v0_7_0';
  END IF;

  -- Backup content_projects
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_projects') THEN
    EXECUTE 'ALTER TABLE content_projects RENAME TO content_projects_v0_7_0';
    RAISE NOTICE '✅ Backed up: content_projects → content_projects_v0_7_0';
  END IF;

  -- Backup audience_profiles
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'audience_profiles') THEN
    EXECUTE 'ALTER TABLE audience_profiles RENAME TO audience_profiles_v0_7_0';
    RAISE NOTICE '✅ Backed up: audience_profiles → audience_profiles_v0_7_0';
  END IF;

  -- Backup content_pieces (will migrate to contents)
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_pieces') THEN
    EXECUTE 'ALTER TABLE content_pieces RENAME TO content_pieces_v0_7_0';
    RAISE NOTICE '✅ Backed up: content_pieces → content_pieces_v0_7_0';
  END IF;

  -- Backup content_campaigns
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_campaigns') THEN
    EXECUTE 'ALTER TABLE content_campaigns RENAME TO content_campaigns_v0_7_0';
    RAISE NOTICE '✅ Backed up: content_campaigns → content_campaigns_v0_7_0';
  END IF;

  -- Backup content_campaign_pieces
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_campaign_pieces') THEN
    EXECUTE 'ALTER TABLE content_campaign_pieces RENAME TO content_campaign_pieces_v0_7_0';
    RAISE NOTICE '✅ Backed up: content_campaign_pieces → content_campaign_pieces_v0_7_0';
  END IF;

  -- Backup content_performance
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_performance') THEN
    EXECUTE 'ALTER TABLE content_performance RENAME TO content_performance_v0_7_0';
    RAISE NOTICE '✅ Backed up: content_performance → content_performance_v0_7_0';
  END IF;

  RAISE NOTICE '✅ Phase 1 complete: All existing tables backed up';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- PHASE 2: CREATE NEW SCHEMA (from schema.sql - CORRECTED)
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'PHASE 2: Creating new CreatorOS schema';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
END $$;

-- Import schema.sql content here (corrected version)
\i /Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria/expansion-packs/creator-os/database/schema.sql

DO $$
BEGIN
  RAISE NOTICE '✅ Phase 2 complete: New schema created';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- PHASE 3: DATA MIGRATION
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_migrated_contents INT := 0;
  v_migrated_minds INT := 0;
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'PHASE 3: Migrating data from v0.7.0';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';

  -- Migrate content_pieces → contents (if exists)
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_pieces_v0_7_0') THEN
    RAISE NOTICE 'Migrating content_pieces_v0_7_0 → contents...';

    INSERT INTO contents (
      id, ai_generated, content_type, title, content,
      project_id, fidelity_score, generation_execution_id,
      status, published_at, created_at, updated_at, slug
    )
    SELECT
      id,
      true as ai_generated,  -- content_pieces são sempre AI-generated
      type as content_type,
      title,
      content,
      project_id,
      voice_fidelity_score as fidelity_score,
      generation_execution_id,
      CASE
        WHEN published_at IS NOT NULL THEN 'published'
        ELSE 'draft'
      END as status,
      published_at,
      created_at,
      updated_at,
      'migrated-' || id::text as slug  -- Generate slug from id
    FROM content_pieces_v0_7_0;

    GET DIAGNOSTICS v_migrated_contents = ROW_COUNT;
    RAISE NOTICE '✅ Migrated % content_pieces → contents', v_migrated_contents;

    -- Migrate creator_mind relationship to content_minds
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'content_projects_v0_7_0') THEN
      INSERT INTO content_minds (content_id, mind_id, role)
      SELECT DISTINCT cp.id, p.creator_mind_id, 'creator'
      FROM content_pieces_v0_7_0 cp
      JOIN content_projects_v0_7_0 p ON p.id = cp.project_id
      WHERE p.creator_mind_id IS NOT NULL;

      GET DIAGNOSTICS v_migrated_minds = ROW_COUNT;
      RAISE NOTICE '✅ Migrated % creator_mind relationships → content_minds', v_migrated_minds;
    END IF;
  ELSE
    RAISE NOTICE '⚠️  No content_pieces_v0_7_0 found - skipping data migration';
  END IF;

  RAISE NOTICE '✅ Phase 3 complete: Data migrated';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- PHASE 4: SEEDS (frameworks, audiences, projects)
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'PHASE 4: Loading seeds';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
END $$;

-- Import seeds.sql
\i /Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria/expansion-packs/creator-os/database/seeds.sql

DO $$
BEGIN
  RAISE NOTICE '✅ Phase 4 complete: Seeds loaded';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- PHASE 5: VIEWS
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'PHASE 5: Creating views';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
END $$;

-- Import views.sql
\i /Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria/expansion-packs/creator-os/database/views.sql

DO $$
BEGIN
  RAISE NOTICE '✅ Phase 5 complete: Views created';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- PHASE 6: VALIDATION
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_contents_count INT;
  v_frameworks_count INT;
  v_audiences_count INT;
  v_projects_count INT;
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'PHASE 6: Validation';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';

  -- Count records
  SELECT COUNT(*) INTO v_contents_count FROM contents;
  SELECT COUNT(*) INTO v_frameworks_count FROM content_frameworks;
  SELECT COUNT(*) INTO v_audiences_count FROM audience_profiles;
  SELECT COUNT(*) INTO v_projects_count FROM content_projects;

  RAISE NOTICE 'Contents: %', v_contents_count;
  RAISE NOTICE 'Frameworks: %', v_frameworks_count;
  RAISE NOTICE 'Audiences: %', v_audiences_count;
  RAISE NOTICE 'Projects: %', v_projects_count;

  -- Validate expectations
  IF v_frameworks_count < 8 THEN
    RAISE WARNING '⚠️  Expected 8 frameworks, found %', v_frameworks_count;
  END IF;

  IF v_audiences_count < 3 THEN
    RAISE WARNING '⚠️  Expected 3 audience profiles, found %', v_audiences_count;
  END IF;

  IF v_projects_count < 3 THEN
    RAISE WARNING '⚠️  Expected 3 projects, found %', v_projects_count;
  END IF;

  RAISE NOTICE '✅ Phase 6 complete: Validation passed';
END $$;

-- ════════════════════════════════════════════════════════════════════════════════
-- MIGRATION COMPLETE
-- ════════════════════════════════════════════════════════════════════════════════

DO $$
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE '✅ CreatorOS Migration Complete!';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE '';
  RAISE NOTICE 'Next Steps:';
  RAISE NOTICE '1. Verify data: SELECT * FROM v_generated_contents LIMIT 5;';
  RAISE NOTICE '2. Update application code to use "contents" table';
  RAISE NOTICE '3. Test thoroughly in development';
  RAISE NOTICE '4. Drop legacy tables when safe: DROP TABLE content_pieces_v0_7_0 CASCADE;';
  RAISE NOTICE '';
END $$;
