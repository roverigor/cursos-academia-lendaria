#!/bin/bash
# ============================================================================
# Week 2 Monitoring Script - CreatorOS Database Integration
# ============================================================================
# Purpose: Monitor database persistence during Week 2 staging deployment
# Usage: ./supabase/scripts/week2-monitor.sh
# ============================================================================

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📊 Week 2 Monitoring - CreatorOS Database Persistence"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check environment
if [ -z "$SUPABASE_DB_URL" ]; then
    echo "❌ SUPABASE_DB_URL not set. Run: source .env"
    exit 1
fi

# Check feature flag
if [ "$CREATOR_OS_DB_PERSIST" != "true" ]; then
    echo "⚠️  WARNING: CREATOR_OS_DB_PERSIST is not 'true'"
    echo "   Current value: ${CREATOR_OS_DB_PERSIST:-not set}"
    echo ""
fi

# Run monitoring queries
psql "$SUPABASE_DB_URL" << 'EOF'
\pset border 2

-- 1. Overall Statistics
\echo ''
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo '  📊 Overall Statistics'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    (SELECT COUNT(*) FROM content_projects) as total_projects,
    (SELECT COUNT(*) FROM contents WHERE content_type = 'course_outline') as total_courses,
    (SELECT COUNT(*) FROM contents WHERE content_type = 'course_module') as total_modules,
    (SELECT COUNT(*) FROM contents WHERE content_type = 'course_lesson') as total_lessons,
    (SELECT COUNT(*) FROM contents) as total_contents;

-- 2. Recent Activity (Last 24 hours)
\echo ''
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo '  🕐 Recent Activity (Last 24 Hours)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    'Projects' as type,
    COUNT(*) as count,
    MAX(created_at) as latest_created
FROM content_projects
WHERE created_at > NOW() - INTERVAL '24 hours'
UNION ALL
SELECT
    'Contents',
    COUNT(*),
    MAX(created_at)
FROM contents
WHERE created_at > NOW() - INTERVAL '24 hours';

-- 3. Mind Attribution Coverage
\echo ''
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo '  🧠 Mind Attribution Coverage'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    COUNT(*) as total_projects,
    COUNT(creator_mind_id) as with_creator,
    COUNT(persona_mind_id) as with_persona,
    ROUND(100.0 * COUNT(creator_mind_id) / NULLIF(COUNT(*), 0), 1) as creator_pct,
    ROUND(100.0 * COUNT(persona_mind_id) / NULLIF(COUNT(*), 0), 1) as persona_pct
FROM content_projects;

-- 4. Latest Projects (Top 5)
\echo ''
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo '  🆕 Latest Projects (Top 5)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    slug,
    name,
    creator_mind_id IS NOT NULL as has_creator,
    created_at
FROM content_projects
ORDER BY created_at DESC
LIMIT 5;

-- 5. Content Quality (Fidelity Scores)
\echo ''
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo '  ⭐ Content Quality (Fidelity Scores)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    content_type,
    COUNT(*) as count,
    COUNT(fidelity_score) as with_score,
    ROUND(AVG(fidelity_score)::NUMERIC, 2) as avg_score,
    ROUND(MIN(fidelity_score)::NUMERIC, 2) as min_score,
    ROUND(MAX(fidelity_score)::NUMERIC, 2) as max_score
FROM contents
WHERE fidelity_score IS NOT NULL
GROUP BY content_type
ORDER BY count DESC;

-- 6. Week 2 Progress Tracker
\echo ''
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo '  🎯 Week 2 Progress Tracker'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

WITH week2_start AS (
    SELECT '2025-10-29 00:00:00'::TIMESTAMPTZ as start_time
)
SELECT
    'Target' as metric,
    '3-5 courses' as target,
    COUNT(*)::TEXT as actual
FROM content_projects, week2_start
WHERE created_at >= week2_start.start_time
UNION ALL
SELECT
    'Status',
    CASE
        WHEN COUNT(*) >= 3 THEN '✅ Met target'
        WHEN COUNT(*) >= 1 THEN '⚠️ In progress'
        ELSE '❌ No new courses yet'
    END,
    ROUND(100.0 * COUNT(*) / 3, 1)::TEXT || '%'
FROM content_projects, week2_start
WHERE created_at >= week2_start.start_time;

EOF

echo ""
echo -e "${GREEN}✓${NC} Monitoring report complete"
echo ""
echo "💡 Tips:"
echo "  - Run this script daily during Week 2"
echo "  - Target: 3-5 courses generated this week"
echo "  - Monitor mind attribution coverage (should increase)"
echo "  - Watch for any errors in course generation logs"
echo ""
