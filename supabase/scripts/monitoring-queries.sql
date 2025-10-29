-- ============================================================================
-- CreatorOS Database Monitoring Queries
-- ============================================================================
-- Purpose: Monitor database writes, performance, and data quality
-- Usage: psql "$SUPABASE_DB_URL" -f supabase/scripts/monitoring-queries.sql
-- ============================================================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo '  📊 CreatorOS Database Monitoring'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- ============================================================================
-- 1. Recent Database Writes (Last 24 hours)
-- ============================================================================

\echo '1️⃣  Recent Projects Created (Last 24h)'
\echo '───────────────────────────────────────────────────'

SELECT
    slug,
    name,
    creator_mind_id,
    persona_mind_id,
    project_type,
    created_at,
    (SELECT display_name FROM minds WHERE id = creator_mind_id) AS creator,
    (SELECT display_name FROM minds WHERE id = persona_mind_id) AS persona
FROM content_projects
WHERE created_at > NOW() - INTERVAL '24 hours'
ORDER BY created_at DESC
LIMIT 10;

\echo ''
\echo '2️⃣  Content Pieces by Project (Last 24h)'
\echo '───────────────────────────────────────────────────'

SELECT
    p.slug AS project,
    p.name AS project_name,
    COUNT(c.id) AS total_contents,
    SUM(CASE WHEN c.content_type = 'course_outline' THEN 1 ELSE 0 END) AS outlines,
    SUM(CASE WHEN c.content_type = 'course_module' THEN 1 ELSE 0 END) AS modules,
    SUM(CASE WHEN c.content_type = 'course_lesson' THEN 1 ELSE 0 END) AS lessons,
    AVG(c.fidelity_score) AS avg_fidelity,
    MAX(c.created_at) AS latest_content
FROM content_projects p
LEFT JOIN contents c ON c.project_id = p.id
WHERE p.created_at > NOW() - INTERVAL '24 hours'
  AND c.deleted_at IS NULL
GROUP BY p.id, p.slug, p.name
ORDER BY p.created_at DESC;

-- ============================================================================
-- 2. Content Hierarchy Verification
-- ============================================================================

\echo ''
\echo '3️⃣  Content Hierarchy Sample (Latest Project)'
\echo '───────────────────────────────────────────────────'

WITH latest_project AS (
    SELECT id FROM content_projects
    ORDER BY created_at DESC
    LIMIT 1
),
RECURSIVE content_tree AS (
    SELECT
        id, slug, title, content_type, parent_content_id,
        sequence_order, fidelity_score, 0 AS level
    FROM contents
    WHERE project_id = (SELECT id FROM latest_project)
      AND parent_content_id IS NULL
    
    UNION ALL
    
    SELECT
        c.id, c.slug, c.title, c.content_type, c.parent_content_id,
        c.sequence_order, c.fidelity_score, ct.level + 1
    FROM contents c
    JOIN content_tree ct ON c.parent_content_id = ct.id
)
SELECT
    REPEAT('  ', level) || title AS content_tree,
    content_type,
    sequence_order,
    ROUND(fidelity_score::numeric, 2) AS fidelity
FROM content_tree
ORDER BY level, sequence_order
LIMIT 20;

-- ============================================================================
-- 3. Performance Metrics
-- ============================================================================

\echo ''
\echo '4️⃣  Database Write Performance'
\echo '───────────────────────────────────────────────────'

SELECT
    'content_projects' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE created_at > NOW() - INTERVAL '24 hours') AS last_24h,
    COUNT(*) FILTER (WHERE created_at > NOW() - INTERVAL '7 days') AS last_7d,
    MAX(created_at) AS latest_write
FROM content_projects
UNION ALL
SELECT
    'contents',
    COUNT(*),
    COUNT(*) FILTER (WHERE created_at > NOW() - INTERVAL '24 hours'),
    COUNT(*) FILTER (WHERE created_at > NOW() - INTERVAL '7 days'),
    MAX(created_at)
FROM contents
UNION ALL
SELECT
    'content_minds',
    COUNT(*),
    COUNT(*) FILTER (WHERE created_at > NOW() - INTERVAL '24 hours'),
    COUNT(*) FILTER (WHERE created_at > NOW() - INTERVAL '7 days'),
    MAX(created_at)
FROM content_minds
ORDER BY table_name;

-- ============================================================================
-- 4. Data Quality Checks
-- ============================================================================

\echo ''
\echo '5️⃣  Data Quality Metrics'
\echo '───────────────────────────────────────────────────'

SELECT
    'Projects without creator' AS check_name,
    COUNT(*) AS count,
    CASE WHEN COUNT(*) = 0 THEN '✅ Pass' ELSE '⚠️  Warning' END AS status
FROM content_projects
WHERE creator_mind_id IS NULL
UNION ALL
SELECT
    'Contents without project',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN '✅ Pass' ELSE '❌ Fail' END
FROM contents
WHERE project_id IS NULL
UNION ALL
SELECT
    'Lessons without parent',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN '✅ Pass' ELSE '⚠️  Warning' END
FROM contents
WHERE content_type = 'course_lesson'
  AND parent_content_id IS NULL
UNION ALL
SELECT
    'Contents with low fidelity (<0.7)',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN '✅ Pass' ELSE '⚠️  Warning' END
FROM contents
WHERE fidelity_score IS NOT NULL
  AND fidelity_score < 0.7;

-- ============================================================================
-- 5. RLS Policy Status
-- ============================================================================

\echo ''
\echo '6️⃣  RLS Security Status'
\echo '───────────────────────────────────────────────────'

SELECT
    tablename,
    rowsecurity AS rls_enabled,
    CASE WHEN rowsecurity THEN '✅ Enabled' ELSE '❌ Disabled' END AS status
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('content_projects', 'contents', 'audience_profiles', 'content_minds', 'content_tags')
ORDER BY tablename;

\echo ''
\echo '7️⃣  RLS Policies Count'
\echo '───────────────────────────────────────────────────'

SELECT
    tablename,
    COUNT(*) AS policy_count,
    STRING_AGG(policyname, ', ' ORDER BY policyname) AS policies
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('content_projects', 'contents', 'audience_profiles', 'content_minds', 'content_tags')
GROUP BY tablename
ORDER BY tablename;

-- ============================================================================
-- 6. Mind Attribution Statistics
-- ============================================================================

\echo ''
\echo '8️⃣  Top Creators (by content count)'
\echo '───────────────────────────────────────────────────'

SELECT
    m.display_name,
    m.slug,
    COUNT(DISTINCT p.id) AS projects,
    COUNT(c.id) AS total_contents,
    AVG(c.fidelity_score) AS avg_fidelity
FROM minds m
LEFT JOIN content_projects p ON p.creator_mind_id = m.id
LEFT JOIN contents c ON c.project_id = p.id
WHERE c.deleted_at IS NULL
GROUP BY m.id, m.display_name, m.slug
HAVING COUNT(DISTINCT p.id) > 0
ORDER BY total_contents DESC
LIMIT 10;

\echo ''
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo '  ✅ Monitoring Complete'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''
\echo 'Run this regularly to monitor CreatorOS database health.'
\echo ''
