#!/bin/bash
# ===========================================================================
# db-test.sh — Run Smoke Tests for Database Version
# ===========================================================================
# PURPOSE: Execute automated smoke tests to validate migration
#
# USAGE:
#   ./scripts/db-test.sh <version>
#
# EXAMPLE:
#   ./scripts/db-test.sh v0.7.0
#   ./scripts/db-test.sh v0.8.0
#
# FEATURES:
#   ✅ Automatic test file selection
#   ✅ set -euo pipefail for safety
#   ✅ PGAPPNAME for observability
#   ✅ Clear pass/fail reporting
#
# ===========================================================================

set -euo pipefail  # Exit on error, undefined var, pipe failure

# ===========================================================================
# CONFIGURATION
# ===========================================================================
VERSION="${1:-}"
DB_URL="${SUPABASE_DB_URL:-${DATABASE_URL:-}}"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export PGAPPNAME="smoke_test_${VERSION}"  # Appears in pg_stat_activity

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ===========================================================================
# HELPER FUNCTIONS
# ===========================================================================
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

# ===========================================================================
# VALIDATION
# ===========================================================================
if [ -z "$VERSION" ]; then
    log_error "Usage: ./scripts/db-test.sh <version>"
    echo ""
    echo "Example:"
    echo "  ./scripts/db-test.sh v0.7.0"
    echo ""
    echo "Available tests:"
    ls -1 "$PROJECT_ROOT/supabase/tests/" 2>/dev/null | grep ".sql" || echo "  (none found)"
    exit 1
fi

if [ -z "$DB_URL" ]; then
    log_error "Database URL not found. Set SUPABASE_DB_URL or DATABASE_URL"
    exit 1
fi

# Find test file (try multiple naming patterns)
TEST_FILE=""
for pattern in "${VERSION}_smoke_test.sql" "${VERSION//_/.}_smoke_test.sql" "smoke_test_${VERSION}.sql"; do
    if [ -f "$PROJECT_ROOT/supabase/tests/$pattern" ]; then
        TEST_FILE="$PROJECT_ROOT/supabase/tests/$pattern"
        break
    fi
done

if [ -z "$TEST_FILE" ] || [ ! -f "$TEST_FILE" ]; then
    log_error "Test file not found for version: $VERSION"
    echo ""
    echo "Tried patterns:"
    echo "  • ${VERSION}_smoke_test.sql"
    echo "  • ${VERSION//_/.}_smoke_test.sql"
    echo "  • smoke_test_${VERSION}.sql"
    echo ""
    echo "Available tests:"
    ls -1 "$PROJECT_ROOT/supabase/tests/" 2>/dev/null | grep ".sql"
    exit 1
fi

# ===========================================================================
# RUN TESTS
# ===========================================================================
echo ""
echo "========================================="
echo "🧪 RUNNING SMOKE TESTS"
echo "========================================="
log_info "Version: $VERSION"
log_info "Test file: $(basename "$TEST_FILE")"
log_info "PGAPPNAME: $PGAPPNAME"
log_info "Database: ${DB_URL%%@*}@***"

echo ""

if psql "$DB_URL" -v ON_ERROR_STOP=1 -f "$TEST_FILE"; then
    echo ""
    echo "========================================="
    echo "✅ ALL TESTS PASSED!"
    echo "========================================="
    log_success "Version $VERSION is validated"
    echo ""
    echo "🎯 Next steps:"
    echo "  1. Manual verification (signup, fragments, RLS)"
    echo "  2. Update supabase/docs/MIGRATIONS.md"
    echo "  3. Deploy to next environment (staging → production)"
    echo ""
    exit 0
else
    echo ""
    echo "========================================="
    echo "❌ TESTS FAILED!"
    echo "========================================="
    log_error "Version $VERSION has issues"
    echo ""
    echo "🔧 Troubleshooting:"
    echo "  1. Check test output above for specific errors"
    echo "  2. Verify migration was applied correctly"
    echo "  3. Check database logs for errors"
    echo "  4. Consider rollback: ./scripts/db-rollback.sh $VERSION"
    echo ""
    exit 1
fi
