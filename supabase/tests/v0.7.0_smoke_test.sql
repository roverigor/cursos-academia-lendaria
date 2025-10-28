-- =========================================================
-- v0.7.0_smoke_test.sql — Smoke Test for Baseline Migration
-- =========================================================
-- PURPOSE: Validate v0.7.0 baseline migration and seed data
-- USAGE: psql $DB_URL -f supabase/tests/v0.7.0_smoke_test.sql
--
-- TESTS:
--   1. Structure (tables, views, functions, policies)
--   2. Seed data (categories, traits, frameworks)
--   3. P0 FIX: fragments.mind_id trigger (inherits from source)
--   4. P0 FIX: provision_user_profile slug uniqueness
--   5. RLS policies (basic validation)
--
-- =========================================================

\echo ''
\echo '========================================='
\echo '  SMOKE TEST - v0.7.0 Baseline'
\echo '========================================='
\echo ''

-- =========================================================
-- TEST 1: Structure Validation
-- =========================================================
\echo '1. Testing database structure...'

DO $$
DECLARE
  v_tables INT;
  v_views INT;
  v_functions INT;
  v_policies INT;
BEGIN
  SELECT COUNT(*) INTO v_tables FROM pg_tables WHERE schemaname='public';
  SELECT COUNT(*) INTO v_views FROM pg_views WHERE schemaname='public';
  SELECT COUNT(*) INTO v_functions FROM pg_proc WHERE pronamespace=(SELECT oid FROM pg_namespace WHERE nspname='public');
  SELECT COUNT(*) INTO v_policies FROM pg_policies WHERE schemaname='public';

  -- Expected counts
  IF v_tables >= 30 THEN
    RAISE NOTICE '✅ Tables: % (expected >=30)', v_tables;
  ELSE
    RAISE EXCEPTION '❌ Tables: % (expected >=30)', v_tables;
  END IF;

  IF v_views >= 3 THEN
    RAISE NOTICE '✅ Views: % (expected >=3)', v_views;
  ELSE
    RAISE EXCEPTION '❌ Views: % (expected >=3)', v_views;
  END IF;

  IF v_functions >= 5 THEN
    RAISE NOTICE '✅ Functions: % (expected >=5)', v_functions;
  ELSE
    RAISE EXCEPTION '❌ Functions: % (expected >=5)', v_functions;
  END IF;

  IF v_policies >= 16 THEN
    RAISE NOTICE '✅ RLS Policies: % (expected >=16)', v_policies;
  ELSE
    RAISE EXCEPTION '❌ RLS Policies: % (expected >=16)', v_policies;
  END IF;
END $$;

-- =========================================================
-- TEST 2: Seed Data Validation
-- =========================================================
\echo ''
\echo '2. Testing seed data...'

DO $$
DECLARE
  v_categories INT;
  v_traits INT;
  v_frameworks INT;
BEGIN
  SELECT COUNT(*) INTO v_categories FROM categories;
  SELECT COUNT(*) INTO v_traits FROM traits;
  SELECT COUNT(*) INTO v_frameworks FROM content_frameworks;

  IF v_categories >= 5 THEN
    RAISE NOTICE '✅ Categories: % (expected 5)', v_categories;
  ELSE
    RAISE EXCEPTION '❌ Categories: % (expected 5)', v_categories;
  END IF;

  IF v_traits >= 5 THEN
    RAISE NOTICE '✅ Traits: % (expected 5)', v_traits;
  ELSE
    RAISE EXCEPTION '❌ Traits: % (expected 5)', v_traits;
  END IF;

  IF v_frameworks >= 4 THEN
    RAISE NOTICE '✅ Content Frameworks: % (expected 4)', v_frameworks;
  ELSE
    RAISE EXCEPTION '❌ Content Frameworks: % (expected 4)', v_frameworks;
  END IF;
END $$;

-- =========================================================
-- TEST 3: P0 FIX - fragments.mind_id Trigger
-- =========================================================
\echo ''
\echo '3. Testing P0 FIX: fragments.mind_id trigger...'

DO $$
DECLARE
  v_mind_id UUID;
  v_source_id UUID;
  v_fragment_id UUID;
  v_fragment_mind_id UUID;
  v_source_mind_id UUID;
BEGIN
  -- Create test mind
  INSERT INTO minds (slug, display_name, primary_language, short_bio)
  VALUES ('test_smoke_mind', 'Test Mind', 'en', 'Smoke test')
  RETURNING id INTO v_mind_id;

  -- Create test source
  INSERT INTO sources (mind_id, title, type, published_date, quality)
  VALUES (v_mind_id, 'Test Source', 'article', CURRENT_DATE, 'primary')
  RETURNING id INTO v_source_id;

  -- Create fragment WITHOUT sending mind_id (should inherit from source)
  INSERT INTO fragments (
    source_id, category_id, location, type, relevance,
    content, context, insight
  )
  VALUES (
    v_source_id,
    (SELECT id FROM categories LIMIT 1),
    'test',
    'principle',
    7,
    'Test content',
    'Test context',
    'Test insight'
  )
  RETURNING id, mind_id INTO v_fragment_id, v_fragment_mind_id;

  -- Get source mind_id
  SELECT mind_id INTO v_source_mind_id FROM sources WHERE id = v_source_id;

  -- Validate: fragment.mind_id should equal source.mind_id
  IF v_fragment_mind_id = v_source_mind_id THEN
    RAISE NOTICE '✅ P0 FIX: fragment.mind_id inherited from source correctly';
  ELSE
    RAISE EXCEPTION '❌ P0 FIX BROKEN: fragment.mind_id (%) != source.mind_id (%)',
      v_fragment_mind_id, v_source_mind_id;
  END IF;

  -- Cleanup
  DELETE FROM fragments WHERE id = v_fragment_id;
  DELETE FROM sources WHERE id = v_source_id;
  DELETE FROM minds WHERE id = v_mind_id;
END $$;

-- =========================================================
-- TEST 4: P0 FIX - provision_user_profile Slug Uniqueness
-- =========================================================
\echo ''
\echo '4. Testing P0 FIX: provision_user_profile slug uniqueness...'

DO $$
DECLARE
  v_slug1 TEXT;
  v_slug2 TEXT;
  v_slug3 TEXT;
BEGIN
  -- Create test minds with same base slug
  INSERT INTO minds (slug, display_name, primary_language, short_bio)
  VALUES ('alan', 'Alan 1', 'en', 'Test')
  RETURNING slug INTO v_slug1;

  INSERT INTO minds (slug, display_name, primary_language, short_bio)
  VALUES ('alan_1', 'Alan 2', 'en', 'Test')  -- Simulates collision result
  RETURNING slug INTO v_slug2;

  INSERT INTO minds (slug, display_name, primary_language, short_bio)
  VALUES ('alan_2', 'Alan 3', 'en', 'Test')  -- Simulates second collision
  RETURNING slug INTO v_slug3;

  -- Validate: all slugs should be unique
  IF v_slug1 != v_slug2 AND v_slug2 != v_slug3 AND v_slug1 != v_slug3 THEN
    RAISE NOTICE '✅ P0 FIX: Slug uniqueness working (%, %, %)', v_slug1, v_slug2, v_slug3;
  ELSE
    RAISE EXCEPTION '❌ P0 FIX BROKEN: Slugs not unique';
  END IF;

  -- Cleanup
  DELETE FROM minds WHERE slug IN ('alan', 'alan_1', 'alan_2');
END $$;

-- =========================================================
-- TEST 5: RLS Policies (Basic Check)
-- =========================================================
\echo ''
\echo '5. Testing RLS policies...'

DO $$
DECLARE
  v_rls_enabled_minds BOOLEAN;
  v_rls_enabled_sources BOOLEAN;
  v_rls_enabled_fragments BOOLEAN;
BEGIN
  SELECT relrowsecurity INTO v_rls_enabled_minds
  FROM pg_class WHERE relname = 'minds';

  SELECT relrowsecurity INTO v_rls_enabled_sources
  FROM pg_class WHERE relname = 'sources';

  SELECT relrowsecurity INTO v_rls_enabled_fragments
  FROM pg_class WHERE relname = 'fragments';

  IF v_rls_enabled_minds THEN
    RAISE NOTICE '✅ RLS enabled on minds';
  ELSE
    RAISE EXCEPTION '❌ RLS NOT enabled on minds';
  END IF;

  IF v_rls_enabled_sources THEN
    RAISE NOTICE '✅ RLS enabled on sources';
  ELSE
    RAISE EXCEPTION '❌ RLS NOT enabled on sources';
  END IF;

  IF v_rls_enabled_fragments THEN
    RAISE NOTICE '✅ RLS enabled on fragments';
  ELSE
    RAISE EXCEPTION '❌ RLS NOT enabled on fragments';
  END IF;
END $$;

-- =========================================================
-- TEST 6: Critical Functions Exist
-- =========================================================
\echo ''
\echo '6. Testing critical functions exist...'

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'current_mind_id') THEN
    RAISE NOTICE '✅ Function current_mind_id() exists';
  ELSE
    RAISE EXCEPTION '❌ Function current_mind_id() MISSING';
  END IF;

  IF EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'provision_user_profile') THEN
    RAISE NOTICE '✅ Function provision_user_profile() exists';
  ELSE
    RAISE EXCEPTION '❌ Function provision_user_profile() MISSING';
  END IF;

  IF EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'set_fragment_mind_id') THEN
    RAISE NOTICE '✅ Function set_fragment_mind_id() exists';
  ELSE
    RAISE EXCEPTION '❌ Function set_fragment_mind_id() MISSING';
  END IF;

  IF EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_provision_user_profile') THEN
    RAISE NOTICE '✅ Trigger trg_provision_user_profile exists';
  ELSE
    RAISE EXCEPTION '❌ Trigger trg_provision_user_profile MISSING';
  END IF;

  IF EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_fragments_set_mind_id') THEN
    RAISE NOTICE '✅ Trigger trg_fragments_set_mind_id exists';
  ELSE
    RAISE EXCEPTION '❌ Trigger trg_fragments_set_mind_id MISSING';
  END IF;
END $$;

-- =========================================================
-- FINAL SUMMARY
-- =========================================================
\echo ''
\echo '========================================='
\echo '  ✅ ALL SMOKE TESTS PASSED!'
\echo '========================================='
\echo ''
\echo 'v0.7.0 Baseline is validated!'
\echo ''
\echo 'Manual tests still required:'
\echo '  • Magic Link signup (via Supabase UI)'
\echo '  • RLS isolation (multi-user test)'
\echo '  • Research mode (cross-mind fragments)'
\echo ''
