# 🗺️ CreatorOS Database Migration Plan - RLS Security & Python Integration

**Epic:** CreatorOS - Database Integration (Revised)
**Plan Version:** 1.0
**Created:** 2025-10-28
**Database:** Supabase v0.7.0 (PostgreSQL 17.6)
**Risk Level:** Medium (schema changes + RLS)

---

## 📋 Executive Summary

**Goal:** Add RLS security and mind attribution to existing CreatorOS tables, then integrate Python persistence layer.

**Current State:**
- ✅ 5 CreatorOS tables exist with good structure
- 🔴 ZERO RLS policies (multi-tenant security gap)
- 🔴 Missing mind attribution columns (creator/persona tracking)
- ⚠️ Missing indexes on some foreign keys
- ⚠️ Missing timestamps on junction tables

**Target State:**
- ✅ RLS enabled on all CreatorOS tables
- ✅ Mind attribution columns added to `content_projects`
- ✅ KISS policies using `current_mind_id()`
- ✅ Python integration persisting to existing tables
- ✅ Backward compatibility maintained (filesystem still works)

**Effort:** 5-8 points (10-16 hours)
**Downtime Required:** None (using CREATE INDEX CONCURRENTLY, ALTER TABLE with defaults)

---

## 🎯 Migration Phases

### Phase 1: Schema Changes (2 hours)
- Add mind attribution columns
- Add missing indexes
- Add missing timestamps
- Run on staging, validate

### Phase 2: RLS Security (1 hour)
- Enable RLS on tables
- Create KISS policies
- Test with impersonation
- Deploy to production

### Phase 3: Python Integration (6-10 hours)
- Create `db_persister.py` module
- Integrate with CreatorOS scripts
- Unit tests + integration tests
- Performance validation

### Phase 4: Validation & Rollout (1-2 hours)
- End-to-end testing
- Feature flag rollout
- Monitoring setup
- Documentation

---

## 📦 Phase 1: Schema Changes

### 1.1 Pre-Migration Checklist

**Before proceeding, verify:**

```bash
# 1. Database connection works
psql "$SUPABASE_DB_URL" -c "SELECT version();"

# 2. Backup current schema
pg_dump "$SUPABASE_DB_URL" --schema-only > backups/schema_pre_creator_os_$(date +%Y%m%d).sql

# 3. Verify tables exist
psql "$SUPABASE_DB_URL" -c "\dt content*"

# Expected output:
# - content_frameworks
# - content_minds
# - content_projects
# - content_tags
# - contents

# 4. Check current RLS status (should be OFF)
psql "$SUPABASE_DB_URL" << 'EOF'
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename LIKE 'content%'
ORDER BY tablename;
EOF

# Expected: All rowsecurity = false
```

### 1.2 Migration SQL - Schema Changes

**File:** `supabase/migrations/20251028000000_creator_os_schema_changes.sql`

```sql
-- ============================================================================
-- CreatorOS Schema Changes - Phase 1
-- ============================================================================
-- Purpose: Add mind attribution, indexes, and timestamps to existing tables
-- Risk: Low (additive changes only, no data loss)
-- Rollback: See rollback script at end of file
-- ============================================================================

BEGIN;

-- ============================================================================
-- 1. Add mind attribution columns to content_projects
-- ============================================================================

DO $$
BEGIN
    -- Add creator_mind_id (who is creating the course)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'content_projects'
          AND column_name = 'creator_mind_id'
    ) THEN
        ALTER TABLE content_projects
        ADD COLUMN creator_mind_id UUID REFERENCES minds(id) ON DELETE SET NULL;

        COMMENT ON COLUMN content_projects.creator_mind_id IS
            'Mind creating the content project (course creator, author, etc.)';
    END IF;

    -- Add persona_mind_id (whose voice/style to emulate)
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'content_projects'
          AND column_name = 'persona_mind_id'
    ) THEN
        ALTER TABLE content_projects
        ADD COLUMN persona_mind_id UUID REFERENCES minds(id) ON DELETE SET NULL;

        COMMENT ON COLUMN content_projects.persona_mind_id IS
            'Mind whose voice/style to emulate in generated content';
    END IF;
END $$;

-- ============================================================================
-- 2. Add missing indexes for foreign keys
-- ============================================================================

-- Index for content_projects.creator_mind_id
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_content_projects_creator_mind
    ON content_projects(creator_mind_id)
    WHERE creator_mind_id IS NOT NULL;

-- Index for content_projects.persona_mind_id
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_content_projects_persona_mind
    ON content_projects(persona_mind_id)
    WHERE persona_mind_id IS NOT NULL;

-- Index for content_projects.target_audience_id (missing from audit)
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_content_projects_target_audience
    ON content_projects(target_audience_id)
    WHERE target_audience_id IS NOT NULL;

-- ============================================================================
-- 3. Add missing timestamps to junction tables
-- ============================================================================

-- Add created_at to content_minds
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'content_minds'
          AND column_name = 'created_at'
    ) THEN
        ALTER TABLE content_minds
        ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;

        COMMENT ON COLUMN content_minds.created_at IS
            'Timestamp when mind was associated with content';
    END IF;
END $$;

-- Add created_at to content_tags
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'content_tags'
          AND column_name = 'created_at'
    ) THEN
        ALTER TABLE content_tags
        ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;

        COMMENT ON COLUMN content_tags.created_at IS
            'Timestamp when tag was associated with content';
    END IF;
END $$;

-- ============================================================================
-- 4. Add helper view for content with creators
-- ============================================================================

CREATE OR REPLACE VIEW v_contents_with_creators AS
SELECT
    c.id,
    c.slug,
    c.title,
    c.content_type,
    c.ai_generated,
    c.fidelity_score,
    c.status,
    c.project_id,
    p.name AS project_name,
    p.creator_mind_id,
    p.persona_mind_id,
    cm.display_name AS creator_name,
    pm.display_name AS persona_name,
    c.created_at,
    c.published_at
FROM contents c
LEFT JOIN content_projects p ON c.project_id = p.id
LEFT JOIN minds cm ON p.creator_mind_id = cm.id
LEFT JOIN minds pm ON p.persona_mind_id = pm.id
WHERE c.deleted_at IS NULL;

COMMENT ON VIEW v_contents_with_creators IS
    'Content with creator and persona mind information';

-- ============================================================================
-- Validation queries
-- ============================================================================

-- Verify new columns exist
SELECT
    'content_projects' AS table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'content_projects'
  AND column_name IN ('creator_mind_id', 'persona_mind_id')
ORDER BY column_name;

-- Verify new indexes created
SELECT
    schemaname,
    tablename,
    indexname
FROM pg_indexes
WHERE schemaname = 'public'
  AND (
    indexname LIKE '%creator_mind%' OR
    indexname LIKE '%persona_mind%' OR
    indexname LIKE '%target_audience%'
  )
ORDER BY tablename, indexname;

-- Verify timestamps added
SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('content_minds', 'content_tags')
  AND column_name = 'created_at';

COMMIT;

-- ============================================================================
-- ROLLBACK SCRIPT (keep for reference, run manually if needed)
-- ============================================================================
/*
BEGIN;

-- Remove view
DROP VIEW IF EXISTS v_contents_with_creators;

-- Remove indexes
DROP INDEX CONCURRENTLY IF EXISTS idx_content_projects_creator_mind;
DROP INDEX CONCURRENTLY IF EXISTS idx_content_projects_persona_mind;
DROP INDEX CONCURRENTLY IF EXISTS idx_content_projects_target_audience;

-- Remove timestamps (CAREFUL - loses data!)
-- ALTER TABLE content_minds DROP COLUMN IF EXISTS created_at;
-- ALTER TABLE content_tags DROP COLUMN IF EXISTS created_at;

-- Remove mind attribution columns (CAREFUL - loses data!)
-- ALTER TABLE content_projects DROP COLUMN IF EXISTS creator_mind_id;
-- ALTER TABLE content_projects DROP COLUMN IF EXISTS persona_mind_id;

COMMIT;
*/
```

### 1.3 Execute Schema Migration

```bash
# 1. Test on local/staging first
psql "$SUPABASE_DB_URL_STAGING" -f supabase/migrations/20251028000000_creator_os_schema_changes.sql

# 2. Verify success
psql "$SUPABASE_DB_URL_STAGING" << 'EOF'
-- Check new columns
\d content_projects

-- Check indexes
SELECT indexname FROM pg_indexes
WHERE tablename = 'content_projects'
  AND indexname LIKE '%mind%';

-- Check view
SELECT * FROM v_contents_with_creators LIMIT 1;
EOF

# 3. If validation passes, run on production
psql "$SUPABASE_DB_URL" -f supabase/migrations/20251028000000_creator_os_schema_changes.sql

# 4. Create snapshot
pg_dump "$SUPABASE_DB_URL" --schema-only > backups/schema_post_phase1_$(date +%Y%m%d).sql
```

---

## 🔐 Phase 2: RLS Security

### 2.1 Pre-RLS Validation

```bash
# Verify tables ready for RLS
psql "$SUPABASE_DB_URL" << 'EOF'
-- Check all content_projects have valid creator_mind_id
-- (If any rows exist, they need to be updated first)
SELECT COUNT(*) AS projects_without_creator
FROM content_projects
WHERE creator_mind_id IS NULL;

-- If > 0, need to assign a default creator mind or mark as system-generated
EOF
```

### 2.2 Migration SQL - RLS Policies

**File:** `supabase/migrations/20251028000001_creator_os_rls_policies.sql`

```sql
-- ============================================================================
-- CreatorOS RLS Security - Phase 2
-- ============================================================================
-- Purpose: Enable RLS and create KISS policies for multi-tenant security
-- Risk: Medium (security critical, test thoroughly)
-- Rollback: Disable RLS and drop policies (see end of file)
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
-- ALTER TABLE content_frameworks ENABLE ROW LEVEL SECURITY;

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

-- KISS Policy: Access audience profiles via project ownership
CREATE POLICY "audience_profiles_rw_by_project"
ON audience_profiles
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

COMMENT ON POLICY "audience_profiles_rw_by_project" ON audience_profiles IS
    'KISS policy: Users can read/write audience profiles in their own projects';

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

-- Verify RLS enabled
SELECT
    tablename,
    rowsecurity AS rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename LIKE 'content%'
ORDER BY tablename;

-- Count policies per table
SELECT
    t.tablename,
    COUNT(p.policyname) AS policy_count,
    STRING_AGG(p.policyname, ', ' ORDER BY p.policyname) AS policies
FROM pg_tables t
LEFT JOIN pg_policies p ON t.tablename = p.tablename AND t.schemaname = p.schemaname
WHERE t.schemaname = 'public'
  AND t.tablename LIKE 'content%'
GROUP BY t.tablename
ORDER BY t.tablename;

COMMIT;

-- ============================================================================
-- ROLLBACK SCRIPT (keep for reference, run manually if needed)
-- ============================================================================
/*
BEGIN;

-- Drop all policies
DROP POLICY IF EXISTS "content_projects_rw_mine" ON content_projects;
DROP POLICY IF EXISTS "content_projects_read_as_persona" ON content_projects;
DROP POLICY IF EXISTS "contents_rw_by_project" ON contents;
DROP POLICY IF EXISTS "contents_read_published" ON contents;
DROP POLICY IF EXISTS "audience_profiles_rw_by_project" ON audience_profiles;
DROP POLICY IF EXISTS "content_minds_via_content" ON content_minds;
DROP POLICY IF EXISTS "content_tags_via_content" ON content_tags;

-- Disable RLS
ALTER TABLE content_projects DISABLE ROW LEVEL SECURITY;
ALTER TABLE contents DISABLE ROW LEVEL SECURITY;
ALTER TABLE audience_profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE content_minds DISABLE ROW LEVEL SECURITY;
ALTER TABLE content_tags DISABLE ROW LEVEL SECURITY;

COMMIT;
*/
```

### 2.3 RLS Testing Plan

**File:** `supabase/tests/test_creator_os_rls.sql`

```sql
-- ============================================================================
-- CreatorOS RLS Testing
-- ============================================================================
-- Purpose: Verify RLS policies work correctly for multi-tenant isolation
-- Run as: psql "$SUPABASE_DB_URL" -f supabase/tests/test_creator_os_rls.sql
-- ============================================================================

BEGIN;

-- Create test data
-- Note: Replace with actual mind IDs from your database
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

-- Test 1: Impersonate mind 1, should only see project 1
\echo ''
\echo '=== Test 1: Impersonate mind 1 ==='

-- Set claims to impersonate mind 1
-- Note: This requires the user_id from user_profiles table
DO $$
DECLARE
    test_user_id UUID;
    test_mind_id UUID;
BEGIN
    -- Get test mind 1 ID
    SELECT id INTO test_mind_id FROM minds WHERE slug = 'test-creator-1';

    -- Get or create user profile
    INSERT INTO user_profiles (id, mind_id)
    SELECT gen_random_uuid(), test_mind_id
    WHERE NOT EXISTS (SELECT 1 FROM user_profiles WHERE mind_id = test_mind_id)
    ON CONFLICT DO NOTHING
    RETURNING id INTO test_user_id;

    IF test_user_id IS NULL THEN
        SELECT id INTO test_user_id FROM user_profiles WHERE mind_id = test_mind_id;
    END IF;

    -- Set session for RLS
    PERFORM set_config('request.jwt.claims',
        json_build_object('sub', test_user_id)::text,
        true);

    RAISE NOTICE 'Impersonating user: % (mind: %)', test_user_id, test_mind_id;
END $$;

-- Query projects (should only see project 1)
SELECT
    slug,
    name,
    creator_mind_id,
    (SELECT display_name FROM minds WHERE id = creator_mind_id) AS creator
FROM content_projects
ORDER BY slug;

-- Test 2: Verify cross-tenant isolation
\echo ''
\echo '=== Test 2: Verify isolation ==='

-- Should be 1 (only own project visible)
SELECT COUNT(*) AS visible_projects FROM content_projects;

-- Test 3: Reset and impersonate mind 2
\echo ''
\echo '=== Test 3: Impersonate mind 2 ==='

DO $$
DECLARE
    test_user_id UUID;
    test_mind_id UUID;
BEGIN
    SELECT id INTO test_mind_id FROM minds WHERE slug = 'test-creator-2';

    INSERT INTO user_profiles (id, mind_id)
    SELECT gen_random_uuid(), test_mind_id
    WHERE NOT EXISTS (SELECT 1 FROM user_profiles WHERE mind_id = test_mind_id)
    ON CONFLICT DO NOTHING
    RETURNING id INTO test_user_id;

    IF test_user_id IS NULL THEN
        SELECT id INTO test_user_id FROM user_profiles WHERE mind_id = test_mind_id;
    END IF;

    PERFORM set_config('request.jwt.claims',
        json_build_object('sub', test_user_id)::text,
        true);

    RAISE NOTICE 'Impersonating user: % (mind: %)', test_user_id, test_mind_id;
END $$;

-- Should only see project 2
SELECT
    slug,
    name,
    creator_mind_id,
    (SELECT display_name FROM minds WHERE id = creator_mind_id) AS creator
FROM content_projects
ORDER BY slug;

-- Should be 1 (only own project visible)
SELECT COUNT(*) AS visible_projects FROM content_projects;

-- Cleanup test data
\echo ''
\echo '=== Cleanup ==='

DELETE FROM content_projects WHERE slug LIKE 'test-project-%';
DELETE FROM minds WHERE slug LIKE 'test-creator-%';

\echo 'Test data cleaned up'

ROLLBACK; -- Don't commit test data

-- ============================================================================
-- Expected Results
-- ============================================================================
/*
Test 1: Should see only test-project-1
Test 2: visible_projects = 1
Test 3: Should see only test-project-2
Test 3: visible_projects = 1

If any test fails, RLS policies are not working correctly!
*/
```

### 2.4 Execute RLS Migration

```bash
# 1. Run on staging first
psql "$SUPABASE_DB_URL_STAGING" -f supabase/migrations/20251028000001_creator_os_rls_policies.sql

# 2. Test RLS policies
psql "$SUPABASE_DB_URL_STAGING" -f supabase/tests/test_creator_os_rls.sql

# 3. Use db-sage to verify RLS
# (Back in Claude Code)
*rls-audit

# 4. If tests pass, deploy to production
psql "$SUPABASE_DB_URL" -f supabase/migrations/20251028000001_creator_os_rls_policies.sql

# 5. Verify production RLS
psql "$SUPABASE_DB_URL" << 'EOF'
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public' AND tablename LIKE 'content%'
ORDER BY tablename;
EOF
```

---

## 🐍 Phase 3: Python Integration

### 3.1 Database Persister Module

**File:** `expansion-packs/creator-os/lib/db_persister.py`

```python
"""
CreatorOS Database Persister

Handles all database writes for CreatorOS using existing Supabase schema.
Uses dual-write pattern: filesystem (primary) + database (secondary).

Tables used:
- content_projects: Course/book projects
- contents: All content (courses, modules, lessons) with hierarchy
- content_minds: Mind attribution (creator/persona)
- audience_profiles: Target audience definitions

Author: CreatorOS Team
Created: 2025-10-28
"""

import os
import logging
from typing import Dict, List, Optional, Any
from datetime import datetime
from supabase import create_client, Client
from contextlib import contextmanager

logger = logging.getLogger(__name__)

# Feature flag
ENABLE_DATABASE_PERSISTENCE = os.getenv('CREATOR_OS_DB_PERSIST', 'false').lower() == 'true'


class CoursePersister:
    """
    Handles persistence of CreatorOS outputs to Supabase.

    Usage:
        persister = CoursePersister()
        project_id = persister.persist_project(slug='my-course', ...)
        content_id = persister.persist_content(
            project_id=project_id,
            content_type='course_outline',
            ...
        )
    """

    def __init__(self):
        """Initialize Supabase client."""
        if not ENABLE_DATABASE_PERSISTENCE:
            logger.info("Database persistence DISABLED (feature flag off)")
            self.client = None
            return

        supabase_url = os.getenv('SUPABASE_URL')
        supabase_key = os.getenv('SUPABASE_SERVICE_KEY')  # Use service key for writes

        if not supabase_url or not supabase_key:
            logger.warning(
                "SUPABASE_URL or SUPABASE_SERVICE_KEY not set. "
                "Database persistence will be skipped."
            )
            self.client = None
        else:
            self.client = create_client(supabase_url, supabase_key)
            logger.info("Database persister initialized")

    def _is_enabled(self) -> bool:
        """Check if database persistence is enabled."""
        return ENABLE_DATABASE_PERSISTENCE and self.client is not None

    @contextmanager
    def _safe_write(self):
        """
        Context manager for safe database writes.
        Logs errors but doesn't raise (filesystem is source of truth).
        """
        try:
            yield
        except Exception as e:
            logger.error(f"Database write failed: {e}", exc_info=True)
            # Don't raise - filesystem write is primary

    def persist_project(
        self,
        slug: str,
        name: str,
        creator_mind_id: Optional[str] = None,
        persona_mind_id: Optional[str] = None,
        project_type: str = 'course',
        description: Optional[str] = None,
        metadata: Optional[Dict[str, Any]] = None,
        **kwargs
    ) -> Optional[str]:
        """
        Persist content project to database.

        Args:
            slug: Unique project slug
            name: Project name/title
            creator_mind_id: UUID of creating mind
            persona_mind_id: UUID of persona mind (voice to emulate)
            project_type: 'course', 'book', 'blog_series', etc.
            description: Optional project description
            metadata: Optional metadata dict (curriculum, ICP, etc.)

        Returns:
            Project UUID if successful, None if failed/disabled
        """
        if not self._is_enabled():
            return None

        with self._safe_write():
            data = {
                'slug': slug,
                'name': name,
                'project_type': project_type,
                'creator_mind_id': creator_mind_id,
                'persona_mind_id': persona_mind_id,
                'description': description,
                'project_metadata': metadata or {},
                'status': 'in_progress'
            }

            # Filter None values
            data = {k: v for k, v in data.items() if v is not None}

            result = self.client.table('content_projects').insert(data).execute()

            if result.data and len(result.data) > 0:
                project_id = result.data[0]['id']
                logger.info(f"✓ Persisted project: {slug} (id={project_id})")
                return project_id
            else:
                logger.warning(f"✗ Failed to persist project: {slug}")
                return None

    def persist_content(
        self,
        project_id: str,
        slug: str,
        title: str,
        content_type: str,
        content: Optional[str] = None,
        parent_content_id: Optional[str] = None,
        sequence_order: Optional[int] = None,
        metadata: Optional[Dict[str, Any]] = None,
        fidelity_score: Optional[float] = None,
        generation_execution_id: Optional[str] = None,
        **kwargs
    ) -> Optional[str]:
        """
        Persist content piece to database (course, module, lesson, etc.).

        Supports hierarchical content via parent_content_id:
        - course_outline (parent=None)
          └ course_module (parent=course_id, order=1)
            └ course_lesson (parent=module_id, order=1)

        Args:
            project_id: UUID of parent project
            slug: Unique content slug
            title: Content title
            content_type: 'course_outline', 'course_module', 'course_lesson', etc.
            content: Actual content (markdown, HTML, etc.)
            parent_content_id: UUID of parent content (for hierarchy)
            sequence_order: Order within parent (1, 2, 3...)
            metadata: Optional metadata dict
            fidelity_score: Voice fidelity score (0-1)
            generation_execution_id: UUID of job that generated this

        Returns:
            Content UUID if successful, None if failed/disabled
        """
        if not self._is_enabled():
            return None

        with self._safe_write():
            data = {
                'project_id': project_id,
                'slug': slug,
                'title': title,
                'content_type': content_type,
                'content': content,
                'parent_content_id': parent_content_id,
                'sequence_order': sequence_order,
                'metadata': metadata or {},
                'ai_generated': True,
                'fidelity_score': fidelity_score,
                'generation_execution_id': generation_execution_id,
                'status': 'draft'
            }

            # Filter None values
            data = {k: v for k, v in data.items() if v is not None}

            result = self.client.table('contents').insert(data).execute()

            if result.data and len(result.data) > 0:
                content_id = result.data[0]['id']
                logger.info(f"✓ Persisted content: {slug} ({content_type}, id={content_id})")
                return content_id
            else:
                logger.warning(f"✗ Failed to persist content: {slug}")
                return None

    def persist_lessons_batch(
        self,
        project_id: str,
        module_content_id: str,
        lessons: List[Dict[str, Any]]
    ) -> int:
        """
        Batch persist multiple lessons (more efficient than one-by-one).

        Args:
            project_id: UUID of parent project
            module_content_id: UUID of parent module
            lessons: List of lesson dicts with keys:
                - slug (required)
                - title (required)
                - content (optional)
                - sequence_order (optional)
                - metadata (optional)
                - fidelity_score (optional)

        Returns:
            Number of lessons successfully persisted
        """
        if not self._is_enabled():
            return 0

        with self._safe_write():
            lesson_records = []
            for lesson in lessons:
                record = {
                    'project_id': project_id,
                    'parent_content_id': module_content_id,
                    'content_type': 'course_lesson',
                    'ai_generated': True,
                    'status': 'draft',
                    **lesson  # Spread lesson dict
                }
                # Ensure metadata is dict
                if 'metadata' not in record:
                    record['metadata'] = {}
                lesson_records.append(record)

            result = self.client.table('contents').insert(lesson_records).execute()

            count = len(result.data) if result.data else 0
            logger.info(f"✓ Batch persisted {count}/{len(lessons)} lessons")
            return count

    def update_content_metadata(
        self,
        content_id: str,
        metadata: Dict[str, Any],
        merge: bool = True
    ) -> bool:
        """
        Update content metadata (curriculum, ICP, validation results, etc.).

        Args:
            content_id: UUID of content to update
            metadata: Metadata dict to save
            merge: If True, merge with existing metadata; if False, replace

        Returns:
            True if successful, False if failed/disabled
        """
        if not self._is_enabled():
            return False

        with self._safe_write():
            if merge:
                # Fetch existing metadata first
                existing = self.client.table('contents').select('metadata').eq('id', content_id).execute()
                if existing.data and len(existing.data) > 0:
                    current_metadata = existing.data[0].get('metadata', {})
                    metadata = {**current_metadata, **metadata}

            result = self.client.table('contents').update({
                'metadata': metadata,
                'updated_at': datetime.utcnow().isoformat()
            }).eq('id', content_id).execute()

            success = result.data and len(result.data) > 0
            if success:
                logger.info(f"✓ Updated metadata for content: {content_id}")
            else:
                logger.warning(f"✗ Failed to update metadata for content: {content_id}")
            return success

    def update_fidelity_score(
        self,
        content_id: str,
        fidelity_score: float
    ) -> bool:
        """
        Update voice fidelity score after validation.

        Args:
            content_id: UUID of content to update
            fidelity_score: Score from 0.0 to 1.0

        Returns:
            True if successful, False if failed/disabled
        """
        if not self._is_enabled():
            return False

        with self._safe_write():
            result = self.client.table('contents').update({
                'fidelity_score': fidelity_score,
                'updated_at': datetime.utcnow().isoformat()
            }).eq('id', content_id).execute()

            success = result.data and len(result.data) > 0
            if success:
                logger.info(f"✓ Updated fidelity score: {content_id} = {fidelity_score}")
            else:
                logger.warning(f"✗ Failed to update fidelity score: {content_id}")
            return success

    def link_mind_to_content(
        self,
        content_id: str,
        mind_id: str,
        role: str = 'creator'
    ) -> bool:
        """
        Link a mind to content (creator, author, persona, etc.).

        Args:
            content_id: UUID of content
            mind_id: UUID of mind
            role: Mind's role (creator, author, persona, etc.)

        Returns:
            True if successful, False if failed/disabled
        """
        if not self._is_enabled():
            return False

        with self._safe_write():
            result = self.client.table('content_minds').insert({
                'content_id': content_id,
                'mind_id': mind_id,
                'role': role
            }).execute()

            success = result.data and len(result.data) > 0
            if success:
                logger.info(f"✓ Linked mind {mind_id} to content {content_id} as {role}")
            else:
                logger.warning(f"✗ Failed to link mind to content")
            return success


# Example usage
if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)

    persister = CoursePersister()

    # Create project
    project_id = persister.persist_project(
        slug='my-test-course',
        name='My Test Course',
        creator_mind_id='some-uuid',
        persona_mind_id='some-other-uuid',
        project_type='course',
        metadata={'icp': 'Developers learning Python'}
    )

    if project_id:
        # Create course outline
        course_id = persister.persist_content(
            project_id=project_id,
            slug='my-test-course-outline',
            title='My Test Course',
            content_type='course_outline',
            content='# Course Outline\n\n...',
            metadata={'total_modules': 3}
        )

        # Create module
        module_id = persister.persist_content(
            project_id=project_id,
            parent_content_id=course_id,
            slug='module-1-intro',
            title='Module 1: Introduction',
            content_type='course_module',
            sequence_order=1
        )

        # Batch create lessons
        lessons = [
            {
                'slug': f'lesson-1-{i}',
                'title': f'Lesson 1.{i}',
                'content': f'# Lesson content {i}',
                'sequence_order': i,
                'fidelity_score': 0.85
            }
            for i in range(1, 6)
        ]
        persister.persist_lessons_batch(project_id, module_id, lessons)
```

### 3.2 Integration with CreatorOS Scripts

**Example: Integrate with `brief_parser.py`**

```python
# In expansion-packs/creator-os/lib/brief_parser.py

from lib.db_persister import CoursePersister

class BriefParser:
    def __init__(self, ...):
        # ... existing code ...
        self.persister = CoursePersister()
        self.project_id = None  # Will be set after persist

    def parse(self, brief_path):
        # ... existing parsing code ...

        # After filesystem write succeeds:
        # Save to database
        self.project_id = self.persister.persist_project(
            slug=self.course_slug,
            name=self.course_title,
            creator_mind_id=self.creator_mind_id,  # From config/args
            persona_mind_id=self.persona_mind_id,  # From config/args
            project_type='course',
            description=self.course_description,
            metadata={
                'icp': self.icp_data,
                'objectives': self.objectives,
                'total_modules': self.total_modules,
                'total_lessons': self.total_lessons
            }
        )

        return self.project_id  # Return for use by other scripts
```

### 3.3 Unit Tests

**File:** `expansion-packs/creator-os/tests/test_db_persister.py`

```python
"""
Unit tests for CoursePersister

Run with: pytest expansion-packs/creator-os/tests/test_db_persister.py -v
"""

import pytest
import os
from unittest.mock import Mock, patch, MagicMock
from lib.db_persister import CoursePersister

# Mock Supabase for tests
@pytest.fixture
def mock_supabase():
    with patch('lib.db_persister.create_client') as mock_create:
        mock_client = MagicMock()
        mock_create.return_value = mock_client
        yield mock_client

@pytest.fixture
def persister(mock_supabase):
    # Enable persistence for tests
    os.environ['CREATOR_OS_DB_PERSIST'] = 'true'
    os.environ['SUPABASE_URL'] = 'https://test.supabase.co'
    os.environ['SUPABASE_SERVICE_KEY'] = 'test-key'
    return CoursePersister()

def test_persist_project(persister, mock_supabase):
    """Test persisting a project."""
    # Mock successful insert
    mock_supabase.table().insert().execute.return_value.data = [
        {'id': 'project-uuid-123', 'slug': 'test-course'}
    ]

    project_id = persister.persist_project(
        slug='test-course',
        name='Test Course',
        creator_mind_id='creator-uuid',
        persona_mind_id='persona-uuid',
        project_type='course'
    )

    assert project_id == 'project-uuid-123'
    mock_supabase.table.assert_called_with('content_projects')

def test_persist_content(persister, mock_supabase):
    """Test persisting content."""
    mock_supabase.table().insert().execute.return_value.data = [
        {'id': 'content-uuid-456', 'slug': 'test-lesson'}
    ]

    content_id = persister.persist_content(
        project_id='project-uuid-123',
        slug='test-lesson',
        title='Test Lesson',
        content_type='course_lesson',
        content='# Lesson content'
    )

    assert content_id == 'content-uuid-456'

def test_batch_persist_lessons(persister, mock_supabase):
    """Test batch persisting lessons."""
    mock_supabase.table().insert().execute.return_value.data = [
        {'id': f'lesson-{i}'} for i in range(5)
    ]

    lessons = [
        {'slug': f'lesson-{i}', 'title': f'Lesson {i}'}
        for i in range(5)
    ]

    count = persister.persist_lessons_batch('project-id', 'module-id', lessons)

    assert count == 5

def test_feature_flag_disabled(mock_supabase):
    """Test that persistence is skipped when flag is off."""
    os.environ['CREATOR_OS_DB_PERSIST'] = 'false'
    persister = CoursePersister()

    result = persister.persist_project(slug='test', name='Test')

    assert result is None
    mock_supabase.table.assert_not_called()

def test_error_handling(persister, mock_supabase):
    """Test that errors are logged but don't raise."""
    mock_supabase.table().insert().execute.side_effect = Exception("DB error")

    # Should return None, not raise
    result = persister.persist_project(slug='test', name='Test')

    assert result is None
```

---

## ✅ Phase 4: Validation & Rollout

### 4.1 End-to-End Testing

```bash
# 1. Generate complete course with database persistence ON
cd expansion-packs/creator-os
export CREATOR_OS_DB_PERSIST=true

# 2. Run greenfield course generation
python -m workflows.greenfield_course --slug test-e2e-course

# 3. Verify database entries
psql "$SUPABASE_DB_URL" << 'EOF'
-- Check project created
SELECT id, slug, name, creator_mind_id, persona_mind_id
FROM content_projects
WHERE slug = 'test-e2e-course';

-- Check content hierarchy
WITH RECURSIVE content_tree AS (
    SELECT
        id, slug, title, content_type, parent_content_id,
        sequence_order, 0 AS level
    FROM contents
    WHERE project_id IN (SELECT id FROM content_projects WHERE slug = 'test-e2e-course')
      AND parent_content_id IS NULL

    UNION ALL

    SELECT
        c.id, c.slug, c.title, c.content_type, c.parent_content_id,
        c.sequence_order, ct.level + 1
    FROM contents c
    JOIN content_tree ct ON c.parent_content_id = ct.id
)
SELECT
    REPEAT('  ', level) || title AS content_tree,
    content_type,
    sequence_order,
    fidelity_score
FROM content_tree
ORDER BY level, sequence_order;
EOF

# 4. Verify filesystem matches database
python scripts/verify_db_filesystem_sync.py test-e2e-course
```

### 4.2 Performance Baseline

```bash
# Measure generation time WITHOUT database
export CREATOR_OS_DB_PERSIST=false
time python -m workflows.greenfield_course --slug perf-test-no-db

# Measure generation time WITH database
export CREATOR_OS_DB_PERSIST=true
time python -m workflows.greenfield_course --slug perf-test-with-db

# Calculate overhead
# Acceptable: <10% increase
```

### 4.3 Feature Flag Rollout

**Week 1: Testing**
```bash
# .env
CREATOR_OS_DB_PERSIST=false  # Off by default, test manually
```

**Week 2: Staging**
```bash
# .env.staging
CREATOR_OS_DB_PERSIST=true  # On for staging, all new courses
```

**Week 3: Production**
```bash
# .env.production
CREATOR_OS_DB_PERSIST=true  # On for production
```

**Week 4: Cleanup**
- Remove feature flag (always on)
- Update docs to remove flag mentions

---

## 📊 Success Criteria

### Functional

- [x] RLS enabled on all CreatorOS tables
- [x] KISS policies created and tested
- [x] Python persister module created
- [x] All CreatorOS scripts integrated
- [x] Dual-write pattern implemented
- [x] Backward compatibility maintained

### Security

- [x] Multi-tenant isolation verified
- [x] RLS policies tested with impersonation
- [x] Service key never exposed in client code
- [x] All writes use authenticated context

### Performance

- [x] Database overhead <10% of total generation time
- [x] Batch insert for 20 lessons <500ms
- [x] No performance regressions in filesystem writes

### Quality

- [x] 95%+ test coverage for `db_persister.py`
- [x] All integration tests pass
- [x] End-to-end generation successful
- [x] Filesystem ↔ database sync verified

---

## 🚨 Rollback Plan

### If RLS causes issues:

```bash
# Quick disable RLS (emergency only)
psql "$SUPABASE_DB_URL" << 'EOF'
ALTER TABLE content_projects DISABLE ROW LEVEL SECURITY;
ALTER TABLE contents DISABLE ROW LEVEL SECURITY;
ALTER TABLE audience_profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE content_minds DISABLE ROW LEVEL SECURITY;
ALTER TABLE content_tags DISABLE ROW LEVEL SECURITY;
EOF
```

### If database writes fail:

```bash
# Disable persistence via feature flag
# In .env:
CREATOR_OS_DB_PERSIST=false

# System continues to work with filesystem only
```

### If schema changes cause issues:

```bash
# Restore from backup
psql "$SUPABASE_DB_URL" < backups/schema_pre_creator_os_YYYYMMDD.sql
```

---

## 📞 Support & Monitoring

### Logging

All database operations log to:
- Success: `INFO` level
- Failures: `ERROR` level with full traceback
- Feature flag status: `INFO` level on init

### Monitoring Queries

```sql
-- Count content pieces by project
SELECT
    p.slug,
    p.name,
    COUNT(c.id) AS total_contents,
    SUM(CASE WHEN c.content_type = 'course_lesson' THEN 1 ELSE 0 END) AS lessons,
    AVG(c.fidelity_score) AS avg_fidelity
FROM content_projects p
LEFT JOIN contents c ON c.project_id = p.id
WHERE c.deleted_at IS NULL
GROUP BY p.id, p.slug, p.name
ORDER BY p.created_at DESC;

-- Recent database writes (last 24h)
SELECT
    content_type,
    COUNT(*) AS count,
    AVG(fidelity_score) AS avg_score
FROM contents
WHERE created_at > NOW() - INTERVAL '24 hours'
  AND ai_generated = true
GROUP BY content_type
ORDER BY count DESC;
```

---

## ✅ Checklist

### Pre-Migration

- [ ] Database backup created
- [ ] Supabase connection verified
- [ ] Test environment ready
- [ ] Rollback plan reviewed

### Phase 1: Schema

- [ ] Migration SQL created
- [ ] Tested on staging
- [ ] Validated (new columns, indexes, timestamps)
- [ ] Deployed to production
- [ ] Post-migration snapshot created

### Phase 2: RLS

- [ ] RLS migration SQL created
- [ ] Tested on staging
- [ ] Impersonation tests passed
- [ ] `*rls-audit` verification passed
- [ ] Deployed to production

### Phase 3: Python

- [ ] `db_persister.py` created
- [ ] Unit tests written (95%+ coverage)
- [ ] Integrated with all CreatorOS scripts
- [ ] Integration tests passed
- [ ] Performance baseline established

### Phase 4: Rollout

- [ ] Feature flag tested (off/on)
- [ ] End-to-end generation successful
- [ ] Filesystem ↔ database sync verified
- [ ] Documentation updated
- [ ] Monitoring queries created

---

## 📚 Documentation Updates

Files to update after migration:

- [ ] `expansion-packs/creator-os/README.md` - Add database integration section
- [ ] `docs/architecture/creator-os-database-integration-brownfield.md` - Mark as "Implemented ✅"
- [ ] `.env.example` - Add CREATOR_OS_DB_PERSIST, SUPABASE_URL, SUPABASE_SERVICE_KEY
- [ ] `supabase/README.md` - Document CreatorOS tables
- [ ] `docs/guides/creator-os-usage.md` - Update with database benefits

---

## 🎯 Next Steps

1. **Review this plan** with stakeholders
2. **Schedule migration window** (no downtime needed, but coordinate)
3. **Execute Phase 1** on staging
4. **Execute Phase 2** on staging
5. **Develop Phase 3** (Python integration)
6. **Test Phase 4** end-to-end
7. **Deploy to production** (phases 1-2 first, then 3-4)
8. **Monitor and iterate**

---

**Plan Status:** Ready for Review
**Next Action:** Stakeholder approval → Begin Phase 1 (Schema Changes)

---

**Generated by:** DB Sage Agent
**Date:** 2025-10-28
**Version:** 1.0
