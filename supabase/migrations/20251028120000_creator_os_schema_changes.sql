-- ============================================================================
-- CreatorOS Schema Changes - Phase 1
-- ============================================================================
-- Purpose: Add mind attribution, indexes, and timestamps to existing tables
-- Risk: Low (additive changes only, no data loss)
-- Version: v0.9.1
-- Date: 2025-10-28
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
CREATE INDEX IF NOT EXISTS idx_content_projects_creator_mind
    ON content_projects(creator_mind_id)
    WHERE creator_mind_id IS NOT NULL;

-- Index for content_projects.persona_mind_id
CREATE INDEX IF NOT EXISTS idx_content_projects_persona_mind
    ON content_projects(persona_mind_id)
    WHERE persona_mind_id IS NOT NULL;

-- Index for content_projects.target_audience_id (missing from audit)
CREATE INDEX IF NOT EXISTS idx_content_projects_target_audience
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
DO $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name = 'content_projects'
      AND column_name IN ('creator_mind_id', 'persona_mind_id');

    IF v_count = 2 THEN
        RAISE NOTICE '✓ Mind attribution columns added successfully';
    ELSE
        RAISE EXCEPTION '✗ Mind attribution columns missing (found %/2)', v_count;
    END IF;

    -- Verify timestamps
    SELECT COUNT(*) INTO v_count
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name IN ('content_minds', 'content_tags')
      AND column_name = 'created_at';

    IF v_count = 2 THEN
        RAISE NOTICE '✓ Timestamps added successfully';
    ELSE
        RAISE EXCEPTION '✗ Timestamps missing (found %/2)', v_count;
    END IF;

    -- Verify view exists
    SELECT COUNT(*) INTO v_count
    FROM information_schema.views
    WHERE table_schema = 'public'
      AND table_name = 'v_contents_with_creators';

    IF v_count = 1 THEN
        RAISE NOTICE '✓ Helper view created successfully';
    ELSE
        RAISE EXCEPTION '✗ Helper view not found';
    END IF;

    RAISE NOTICE '✓ Phase 1 (Schema Changes) completed successfully';
END $$;

COMMIT;
