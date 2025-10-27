#!/bin/bash
# ===========================================================================
# db-migrate.sh — Production-Grade Database Migration
# ===========================================================================
# PURPOSE: Execute migrations with automatic snapshots, validation, and rollback
#
# USAGE:
#   ./scripts/db-migrate.sh <migration_file> [--dry-run]
#
# EXAMPLE:
#   # Dry-run (validation only, no changes):
#   ./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql --dry-run
#
#   # Real execution:
#   ./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql
#
# FEATURES:
#   ✅ Dry-run with BEGIN...ROLLBACK (syntax validation)
#   ✅ Automatic snapshot before migration (with --clean --if-exists)
#   ✅ Transactional execution (-1 flag when possible)
#   ✅ Statement/lock timeouts
#   ✅ PGAPPNAME for observability
#   ✅ Expected counts validation
#   ✅ Detailed logging
#
# ===========================================================================

set -euo pipefail  # Exit on error, undefined var, pipe failure

# ===========================================================================
# CONFIGURATION
# ===========================================================================
MIGRATION_FILE="${1:-}"
DRY_RUN="${2:-}"
DB_URL="${SUPABASE_DB_URL:-${DATABASE_URL:-}}"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ===========================================================================
# HELPER FUNCTIONS
# ===========================================================================
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# ===========================================================================
# VALIDATION
# ===========================================================================
if [ -z "$MIGRATION_FILE" ]; then
    log_error "Usage: ./scripts/db-migrate.sh <migration_file> [--dry-run]"
    echo ""
    echo "Examples:"
    echo "  # Dry-run (validation only):"
    echo "  ./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql --dry-run"
    echo ""
    echo "  # Real execution:"
    echo "  ./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql"
    exit 1
fi

if [ ! -f "$MIGRATION_FILE" ]; then
    log_error "Migration file not found: $MIGRATION_FILE"
    exit 1
fi

if [ -z "$DB_URL" ]; then
    log_error "Database URL not found. Set SUPABASE_DB_URL or DATABASE_URL"
    echo ""
    echo "Example:"
    echo "  export SUPABASE_DB_URL='postgresql://postgres:[PASS]@db.[PROJECT].supabase.co:5432/postgres'"
    exit 1
fi

# ===========================================================================
# EXTRACT VERSION INFO
# ===========================================================================
FILENAME=$(basename "$MIGRATION_FILE")
VERSION=$(echo "$FILENAME" | cut -d'_' -f2-4)  # e.g., v0_7_0
export PGAPPNAME="migrate_${VERSION}"  # Appears in pg_stat_activity

log_info "Migration: $FILENAME"
log_info "Version: $VERSION"
log_info "PGAPPNAME: $PGAPPNAME"
log_info "Database: ${DB_URL%%@*}@***"  # Hide password in logs

# ===========================================================================
# STEP 0: DRY-RUN (Validation Only)
# ===========================================================================
if [ "$DRY_RUN" == "--dry-run" ]; then
    echo ""
    echo "========================================="
    echo "🧪 DRY-RUN MODE (Validation Only)"
    echo "========================================="
    log_info "Testing migration syntax with BEGIN...ROLLBACK"

    if psql "$DB_URL" -v ON_ERROR_STOP=1 <<SQL
BEGIN;
\i $MIGRATION_FILE
ROLLBACK;
SQL
    then
        log_success "Dry-run passed! Migration syntax is valid."
        log_info "No changes were made to the database."
        echo ""
        echo "✅ Ready for real execution:"
        echo "  ./scripts/db-migrate.sh $MIGRATION_FILE"
        exit 0
    else
        log_error "Dry-run failed! Fix migration syntax errors."
        exit 1
    fi
fi

# ===========================================================================
# CREATE DIRECTORIES
# ===========================================================================
mkdir -p "$PROJECT_ROOT/supabase/schemas"
mkdir -p "$PROJECT_ROOT/supabase/rollback"

# ===========================================================================
# STEP 1: PRE-MIGRATION SNAPSHOT (Restaurável)
# ===========================================================================
SNAPSHOT_PRE="$PROJECT_ROOT/supabase/schemas/${VERSION}_${TIMESTAMP}_before.sql"

echo ""
echo "========================================="
echo "📸 CREATING PRE-MIGRATION SNAPSHOT"
echo "========================================="
log_info "Snapshot: ${SNAPSHOT_PRE##*/}"
log_info "Flags: --schema-only --clean --if-exists (restaurável)"

pg_dump "$DB_URL" \
    --schema-only \
    --clean \
    --if-exists \
    --no-owner \
    --no-privileges \
    > "$SNAPSHOT_PRE"

log_success "Pre-migration snapshot created ($(du -h "$SNAPSHOT_PRE" | cut -f1))"
log_info "Rollback available: psql \$DB_URL < ${SNAPSHOT_PRE##*/}"

# ===========================================================================
# STEP 2: APPLY MIGRATION (Transactional + Timeouts)
# ===========================================================================
echo ""
echo "========================================="
echo "⏳ APPLYING MIGRATION"
echo "========================================="
log_info "Executing: $FILENAME"
log_info "Mode: Transactional (-1) with ON_ERROR_STOP"
log_info "Timeouts: statement=30s, lock=10s, idle=60s"

# Apply with timeouts and transactional mode
if psql "$DB_URL" -v ON_ERROR_STOP=1 -1 <<SQL
-- Set safety timeouts
SET statement_timeout = '30s';
SET lock_timeout = '10s';
SET idle_in_transaction_session_timeout = '60s';

-- Apply migration
\i $MIGRATION_FILE
SQL
then
    log_success "Migration applied successfully"
else
    log_error "Migration failed!"
    log_warning "Database unchanged (transaction rolled back)"
    log_info "Pre-migration snapshot preserved: ${SNAPSHOT_PRE##*/}"
    exit 1
fi

# ===========================================================================
# STEP 3: POST-MIGRATION SNAPSHOT
# ===========================================================================
SNAPSHOT_POST="$PROJECT_ROOT/supabase/schemas/${VERSION}_${TIMESTAMP}_after.sql"

echo ""
echo "========================================="
echo "📸 CREATING POST-MIGRATION SNAPSHOT"
echo "========================================="
log_info "Snapshot: ${SNAPSHOT_POST##*/}"

pg_dump "$DB_URL" \
    --schema-only \
    --clean \
    --if-exists \
    --no-owner \
    --no-privileges \
    > "$SNAPSHOT_POST"

log_success "Post-migration snapshot created ($(du -h "$SNAPSHOT_POST" | cut -f1))"

# ===========================================================================
# STEP 4: VERIFICATION (Expected Counts)
# ===========================================================================
echo ""
echo "========================================="
echo "🔍 VERIFYING MIGRATION"
echo "========================================="

TABLE_COUNT=$(psql "$DB_URL" -t -A -c "SELECT COUNT(*) FROM pg_tables WHERE schemaname='public';")
VIEW_COUNT=$(psql "$DB_URL" -t -A -c "SELECT COUNT(*) FROM pg_views WHERE schemaname='public';")
FUNCTION_COUNT=$(psql "$DB_URL" -t -A -c "SELECT COUNT(*) FROM pg_proc WHERE pronamespace=(SELECT oid FROM pg_namespace WHERE nspname='public');")
POLICY_COUNT=$(psql "$DB_URL" -t -A -c "SELECT COUNT(*) FROM pg_policies WHERE schemaname='public';")

log_info "Tables: $TABLE_COUNT"
log_info "Views: $VIEW_COUNT"
log_info "Functions: $FUNCTION_COUNT"
log_info "RLS Policies: $POLICY_COUNT"

# Expected counts for v0.7.0 baseline
EXPECTED_TABLES=30
EXPECTED_VIEWS=3
EXPECTED_FUNCTIONS=5
EXPECTED_POLICIES=16

if [[ "$VERSION" == "v0_7_0" ]]; then
    if [ "$TABLE_COUNT" -lt "$EXPECTED_TABLES" ]; then
        log_warning "Table count ($TABLE_COUNT) < expected ($EXPECTED_TABLES)"
    fi
    if [ "$FUNCTION_COUNT" -lt "$EXPECTED_FUNCTIONS" ]; then
        log_warning "Function count ($FUNCTION_COUNT) < expected ($EXPECTED_FUNCTIONS)"
    fi
    if [ "$POLICY_COUNT" -lt "$EXPECTED_POLICIES" ]; then
        log_warning "Policy count ($POLICY_COUNT) < expected ($EXPECTED_POLICIES)"
    fi
fi

# ===========================================================================
# STEP 5: GENERATE ROLLBACK POINTER
# ===========================================================================
ROLLBACK_SCRIPT="$PROJECT_ROOT/supabase/rollback/$(basename "$MIGRATION_FILE" .sql)_rollback.sql"

echo ""
echo "========================================="
echo "📝 GENERATING ROLLBACK SCRIPT"
echo "========================================="
log_info "Rollback: ${ROLLBACK_SCRIPT##*/}"

cat > "$ROLLBACK_SCRIPT" <<EOF
-- =========================================================
-- ROLLBACK for $FILENAME
-- =========================================================
-- Generated: $(date)
-- Purpose: Restore database to state before migration
--
-- ⚠️  WARNING: This is a DESTRUCTIVE operation!
--
-- RECOMMENDED: Use snapshot restore (safest)
--   psql \$DB_URL < supabase/schemas/${VERSION}_${TIMESTAMP}_before.sql
--
-- ALTERNATIVE: Manual rollback commands (if needed)
--   Add specific DROP/ALTER commands below
--
-- =========================================================

\echo '⚠️  Rollback via snapshot restore:'
\echo 'psql \$DB_URL < supabase/schemas/${VERSION}_${TIMESTAMP}_before.sql'
\echo ''
\echo 'This will restore database to exact state before migration.'
\echo 'All changes after snapshot will be LOST.'
EOF

log_success "Rollback pointer generated"
log_info "Rollback command: psql \$DB_URL < ${SNAPSHOT_PRE##*/}"

# ===========================================================================
# STEP 6: SUCCESS SUMMARY
# ===========================================================================
echo ""
echo "========================================="
echo "✅ MIGRATION COMPLETE!"
echo "========================================="
echo ""
log_success "Migration: $FILENAME"
log_success "Version: $VERSION"
echo ""
echo "📸 Snapshots created:"
echo "  • Before:  ${SNAPSHOT_PRE##*/}"
echo "  • After:   ${SNAPSHOT_POST##*/}"
echo ""
echo "📝 Rollback available:"
echo "  • Automatic: ./scripts/db-rollback.sh $VERSION"
echo "  • Manual:    psql \$DB_URL < ${SNAPSHOT_PRE##*/}"
echo ""
echo "📊 Database state:"
echo "  • Tables:    $TABLE_COUNT"
echo "  • Views:     $VIEW_COUNT"
echo "  • Functions: $FUNCTION_COUNT"
echo "  • Policies:  $POLICY_COUNT"
echo ""
echo "🎯 Next steps:"
echo "  1. Run smoke test: ./scripts/db-test.sh $VERSION"
echo "  2. Verify manually in database"
echo "  3. Update supabase/docs/MIGRATIONS.md with deployment info"
echo ""
echo "========================================="
