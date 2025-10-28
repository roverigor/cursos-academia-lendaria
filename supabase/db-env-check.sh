#!/bin/bash
# =============================================================================
# DATABASE ENVIRONMENT VALIDATION SCRIPT
# =============================================================================
# Purpose: Validate Supabase database connectivity BEFORE any work begins
# Usage: ./supabase/db-env-check.sh
#
# This script MUST be run before starting any database operations to prevent
# silent failures and wasted time on connectivity issues.
#
# Exit codes:
#   0 = All checks passed ✅
#   1 = Environment validation failed ❌
#   2 = Connection validation failed ❌
#   3 = Credentials validation failed ❌
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
CHECKS_PASSED=0
CHECKS_FAILED=0

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}DATABASE ENVIRONMENT VALIDATION${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

# =============================================================================
# STEP 1: Environment Variables Check
# =============================================================================
echo -e "${YELLOW}📋 STEP 1: Validating Environment Variables${NC}"
echo ""

if [ -f .env ]; then
    source .env
    echo -e "${GREEN}✓${NC} .env file loaded"
    ((CHECKS_PASSED++))
else
    echo -e "${RED}✗${NC} .env file not found"
    echo "  → Create .env by copying .env.example: cp .env.example .env"
    ((CHECKS_FAILED++))
    exit 1
fi

# Check SUPABASE_DB_URL
if [ -z "$SUPABASE_DB_URL" ]; then
    echo -e "${RED}✗${NC} SUPABASE_DB_URL not set in .env"
    echo "  → Add SUPABASE_DB_URL to .env file (line ~217)"
    ((CHECKS_FAILED++))
else
    echo -e "${GREEN}✓${NC} SUPABASE_DB_URL is configured"
    ((CHECKS_PASSED++))

    # Redact password for display
    DISPLAY_URL=$(echo "$SUPABASE_DB_URL" | sed 's/:.*@/:***@/')
    echo "  → URL (redacted): $DISPLAY_URL"
fi

# Check SUPABASE_URL
if [ -z "$SUPABASE_URL" ]; then
    echo -e "${RED}✗${NC} SUPABASE_URL not set in .env"
    ((CHECKS_FAILED++))
else
    echo -e "${GREEN}✓${NC} SUPABASE_URL is configured: $SUPABASE_URL"
    ((CHECKS_PASSED++))
fi

echo ""

# =============================================================================
# STEP 2: Network Connectivity Check
# =============================================================================
echo -e "${YELLOW}🌐 STEP 2: Validating Network Connectivity${NC}"
echo ""

# Extract host from SUPABASE_DB_URL
# Format: postgresql://user:pass@host:port/db
DB_HOST=$(echo "$SUPABASE_DB_URL" | sed 's/.*@\([^:]*\).*/\1/')

echo "Database Host: $DB_HOST"
echo ""

# Check if we can resolve the hostname
if ping -c 1 -W 2 "$DB_HOST" &>/dev/null; then
    echo -e "${GREEN}✓${NC} Hostname resolves and responds to ping"
    ((CHECKS_PASSED++))
else
    # Ping may fail due to ICMP restrictions, try DNS lookup instead
    if getent hosts "$DB_HOST" &>/dev/null; then
        echo -e "${GREEN}✓${NC} Hostname resolves via DNS"
        ((CHECKS_PASSED++))
    else
        echo -e "${RED}✗${NC} Cannot resolve hostname: $DB_HOST"
        echo "  → Check your internet connection"
        echo "  → Check firewall/proxy settings"
        echo "  → Verify the host is correct: $DB_HOST"
        ((CHECKS_FAILED++))
    fi
fi

echo ""

# =============================================================================
# STEP 3: Database Connection Test (silent, non-blocking)
# =============================================================================
echo -e "${YELLOW}🔗 STEP 3: Testing Database Connection${NC}"
echo ""

# Try to connect to database
if command -v psql &>/dev/null; then
    echo "Using psql to test connection..."

    # Use timeout to prevent hanging
    if timeout 10 psql "$SUPABASE_DB_URL" -c "SELECT version();" &>/dev/null; then
        echo -e "${GREEN}✓${NC} Successfully connected to Supabase database"
        echo "  → PostgreSQL is accessible and responding"
        ((CHECKS_PASSED++))
    else
        echo -e "${RED}✗${NC} Could not connect to database"
        echo "  → Check SUPABASE_DB_URL credentials"
        echo "  → Verify network access to Supabase"
        echo "  → Check if database is running"
        ((CHECKS_FAILED++))
    fi
else
    echo -e "${YELLOW}⚠${NC}  psql not installed, skipping connection test"
    echo "  → Install PostgreSQL client: brew install postgresql"
    echo "  → Or use Supabase CLI: npm install -g supabase"
fi

echo ""

# =============================================================================
# STEP 4: Schema Validation
# =============================================================================
echo -e "${YELLOW}📊 STEP 4: Validating Schema${NC}"
echo ""

if [ -f docs/database/README.md ]; then
    SCHEMA_VERSION=$(grep -m1 "version:" docs/database/README.md | sed 's/.*"\([^"]*\)".*/\1/' | head -1)
    if [ -n "$SCHEMA_VERSION" ]; then
        echo -e "${GREEN}✓${NC} Current schema version: $SCHEMA_VERSION"
        ((CHECKS_PASSED++))
    else
        echo -e "${YELLOW}⚠${NC}  Could not determine schema version"
    fi
else
    echo -e "${YELLOW}⚠${NC}  docs/database/README.md not found"
fi

echo ""

# =============================================================================
# SUMMARY
# =============================================================================
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

TOTAL_CHECKS=$((CHECKS_PASSED + CHECKS_FAILED))

if [ $CHECKS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ ALL CHECKS PASSED ($CHECKS_PASSED/$TOTAL_CHECKS)${NC}"
    echo ""
    echo "Your database environment is configured correctly!"
    echo "You can now proceed with database operations:"
    echo ""
    echo "  • DB Sage: Run '/db-sage' in Claude Code"
    echo "  • Manual work: Use 'psql \$SUPABASE_DB_URL' to connect"
    echo "  • Migrations: Run './scripts/db-migrate.sh <migration.sql>'"
    echo ""
    exit 0
else
    echo -e "${RED}❌ VALIDATION FAILED ($CHECKS_FAILED ISSUES FOUND)${NC}"
    echo ""
    echo "Checks passed: ${GREEN}$CHECKS_PASSED${NC}"
    echo "Checks failed: ${RED}$CHECKS_FAILED${NC}"
    echo ""
    echo -e "${YELLOW}Quick Troubleshooting:${NC}"
    echo ""
    echo "1. DNS Resolution Issue?"
    echo "   → Check internet connection: ping 8.8.8.8"
    echo "   → Check DNS: nslookup aws-1-us-east-2.pooler.supabase.com"
    echo "   → Check firewall: Allow traffic to *.supabase.com"
    echo ""
    echo "2. Connection Refused?"
    echo "   → Verify SUPABASE_DB_URL is correct (check .env line 217)"
    echo "   → Verify credentials: SUPABASE_PASSWORD is set"
    echo "   → Check if Supabase project is active"
    echo ""
    echo "3. psql Not Found?"
    echo "   → Install: brew install postgresql"
    echo "   → Or use Supabase CLI: brew install supabase/tap/supabase"
    echo ""
    echo "For more help, see: docs/database/TROUBLESHOOTING.md"
    echo ""
    exit 1
fi
