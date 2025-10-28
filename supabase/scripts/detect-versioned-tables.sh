#!/bin/bash
# ============================================================================
# SAFEGUARD: Detect Accidental Versioned Tables
# ============================================================================
# Purpose: Detect tables with version suffixes (_v0_*, _v1_*, etc.)
# Usage: ./supabase/scripts/detect-versioned-tables.sh
# Exit codes:
#   0 = No versioned tables found (good)
#   1 = Versioned tables detected (bad)
# ============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "SAFEGUARD: Checking for Versioned Tables"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if SUPABASE_DB_URL is set
if [ -z "$SUPABASE_DB_URL" ]; then
    if [ -f .env ]; then
        source .env
    fi
fi

if [ -z "$SUPABASE_DB_URL" ]; then
    echo -e "${RED}✗${NC} SUPABASE_DB_URL not set"
    echo "  Run: source .env"
    exit 1
fi

# Query for versioned tables
# Pattern explanation:
#   %_v0_% → Matches: users_v0_7_0, content_v0_1_0
#   %_v1_% → Matches: users_v1_0_0
#   BUT NOT: mind_values (has _v in middle of word, not _v0_)
VERSIONED_TABLES=$(psql "$SUPABASE_DB_URL" -t -c "
SELECT tablename
FROM pg_tables
WHERE schemaname = 'public'
  AND (
    tablename ~ '.*_v[0-9]+_.*' OR  -- Matches _v0_, _v1_, etc.
    tablename LIKE '%_backup' OR
    tablename LIKE '%_backup_%' OR
    tablename LIKE '%_old' OR
    tablename LIKE '%_old_%' OR
    tablename LIKE '%_copy' OR
    tablename LIKE '%_copy_%' OR
    tablename LIKE '%_tmp' OR
    tablename LIKE '%_tmp_%' OR
    tablename LIKE '%_temp' OR
    tablename LIKE '%_temp_%'
  )
ORDER BY tablename;
" 2>&1)

# Check if query succeeded
if [ $? -ne 0 ]; then
    echo -e "${RED}✗${NC} Failed to query database"
    echo "$VERSIONED_TABLES"
    exit 1
fi

# Count versioned tables
COUNT=$(echo "$VERSIONED_TABLES" | grep -v '^$' | wc -l | tr -d ' ')

if [ "$COUNT" -eq 0 ]; then
    echo -e "${GREEN}✓${NC} No versioned tables found"
    echo ""
    echo "Your database is clean! No accidental backup tables."
    echo ""
    exit 0
else
    echo -e "${RED}✗${NC} Found $COUNT versioned table(s):"
    echo ""
    echo "$VERSIONED_TABLES" | sed 's/^/  /'
    echo ""
    echo -e "${YELLOW}These tables should NOT exist in the database.${NC}"
    echo ""
    echo "Naming conventions:"
    echo "  ✓ Good: users, content_pieces, fragments"
    echo "  ✗ Bad:  users_v0_7_0, content_backup, fragments_old"
    echo ""
    echo "To remove these tables:"
    echo "  1. Verify they are backups (check data)"
    echo "  2. Create a cleanup migration"
    echo "  3. Run: psql \"\$SUPABASE_DB_URL\" -f cleanup.sql"
    echo ""
    echo "Example cleanup.sql:"
    echo "$VERSIONED_TABLES" | grep -v '^$' | sed 's/^/DROP TABLE IF EXISTS /' | sed 's/$/;/'
    echo ""
    exit 1
fi
