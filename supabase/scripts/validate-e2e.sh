#!/bin/bash
# ============================================================================
# CreatorOS E2E Validation Script
# ============================================================================
# Purpose: Validate end-to-end database integration
# Usage: ./supabase/scripts/validate-e2e.sh
# ============================================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🧪 CreatorOS E2E Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check prerequisites
echo "📋 Checking prerequisites..."

if [ -z "$SUPABASE_DB_URL" ]; then
    echo -e "${RED}✗ SUPABASE_DB_URL not set${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} SUPABASE_DB_URL configured"

if ! command -v psql &> /dev/null; then
    echo -e "${RED}✗ psql not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} psql found"

# Test connection
if ! psql "$SUPABASE_DB_URL" -c "SELECT 1" &> /dev/null; then
    echo -e "${RED}✗ Cannot connect to database${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} Database connection successful"

# Validation 1: Check schema exists
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  1️⃣  Schema Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "Checking mind attribution columns..."
COLUMNS=$(psql "$SUPABASE_DB_URL" -t -c "
SELECT COUNT(*) 
FROM information_schema.columns 
WHERE table_name = 'content_projects' 
  AND column_name IN ('creator_mind_id', 'persona_mind_id');
")

if [ "$COLUMNS" -eq 2 ]; then
    echo -e "${GREEN}✓${NC} Mind attribution columns found (2/2)"
else
    echo -e "${RED}✗ Mind attribution columns missing${NC}"
    exit 1
fi

echo "Checking indexes..."
INDEXES=$(psql "$SUPABASE_DB_URL" -t -c "
SELECT COUNT(*) 
FROM pg_indexes 
WHERE tablename = 'content_projects' 
  AND (indexname LIKE '%creator_mind%' OR indexname LIKE '%persona_mind%');
")

if [ "$INDEXES" -ge 2 ]; then
    echo -e "${GREEN}✓${NC} Mind attribution indexes found ($INDEXES)"
else
    echo -e "${YELLOW}⚠${NC}  Some indexes may be missing"
fi

# Validation 2: Check RLS enabled
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  2️⃣  RLS Security Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "Checking RLS status..."
RLS_ENABLED=$(psql "$SUPABASE_DB_URL" -t -c "
SELECT COUNT(*) 
FROM pg_tables 
WHERE schemaname = 'public' 
  AND tablename IN ('content_projects', 'contents', 'audience_profiles', 'content_minds', 'content_tags')
  AND rowsecurity = true;
")

if [ "$RLS_ENABLED" -eq 5 ]; then
    echo -e "${GREEN}✓${NC} RLS enabled on all tables (5/5)"
else
    echo -e "${RED}✗ RLS not enabled on all tables (${RLS_ENABLED}/5)${NC}"
    exit 1
fi

echo "Checking policies..."
POLICIES=$(psql "$SUPABASE_DB_URL" -t -c "
SELECT COUNT(*) 
FROM pg_policies 
WHERE schemaname = 'public' 
  AND tablename IN ('content_projects', 'contents', 'audience_profiles', 'content_minds', 'content_tags');
")

if [ "$POLICIES" -ge 7 ]; then
    echo -e "${GREEN}✓${NC} RLS policies found ($POLICIES)"
else
    echo -e "${YELLOW}⚠${NC}  Expected 7 policies, found $POLICIES"
fi

# Validation 3: Feature flag check
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  3️⃣  Feature Flag Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ "$CREATOR_OS_DB_PERSIST" = "true" ]; then
    echo -e "${GREEN}✓${NC} Feature flag ENABLED (CREATOR_OS_DB_PERSIST=true)"
elif [ "$CREATOR_OS_DB_PERSIST" = "false" ]; then
    echo -e "${YELLOW}⚠${NC}  Feature flag DISABLED (CREATOR_OS_DB_PERSIST=false)"
else
    echo -e "${YELLOW}⚠${NC}  Feature flag not set (defaults to false)"
fi

# Validation 4: Database data check
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  4️⃣  Database Data Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

PROJECT_COUNT=$(psql "$SUPABASE_DB_URL" -t -c "SELECT COUNT(*) FROM content_projects;")
CONTENT_COUNT=$(psql "$SUPABASE_DB_URL" -t -c "SELECT COUNT(*) FROM contents;")

echo "Projects in database: $PROJECT_COUNT"
echo "Contents in database: $CONTENT_COUNT"

if [ "$PROJECT_COUNT" -gt 0 ]; then
    echo ""
    echo "Latest projects:"
    psql "$SUPABASE_DB_URL" -c "
    SELECT slug, name, created_at 
    FROM content_projects 
    ORDER BY created_at DESC 
    LIMIT 5;
    "
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ E2E Validation Complete"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo "  1. Run unit tests: pytest expansion-packs/creator-os/tests/test_db_persister.py -v"
echo "  2. Run RLS tests: psql \"\$SUPABASE_DB_URL\" -f supabase/tests/test_creator_os_rls.sql"
echo "  3. Run monitoring: psql \"\$SUPABASE_DB_URL\" -f supabase/scripts/monitoring-queries.sql"
echo ""
