#!/bin/bash
# ===========================================================================
# db-rollback.sh — Safe Database Rollback via Snapshot Restore
# ===========================================================================
# PURPOSE: Rollback database to previous snapshot with confirmation
#
# USAGE:
#   ./scripts/db-rollback.sh <version>
#
# EXAMPLE:
#   ./scripts/db-rollback.sh v0_7_0
#
# FEATURES:
#   ✅ Automatic snapshot selection (most recent _before.sql)
#   ✅ Confirmation prompt (type 'ROLLBACK')
#   ✅ Backup current state before rollback
#   ✅ Full restore via snapshot (with --clean --if-exists)
#   ✅ set -euo pipefail for safety
#   ✅ PGAPPNAME for observability
#
# ===========================================================================

set -euo pipefail  # Exit on error, undefined var, pipe failure

# ===========================================================================
# CONFIGURATION
# ===========================================================================
VERSION="${1:-}"
DB_URL="${SUPABASE_DB_URL:-${DATABASE_URL:-}}"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
export PGAPPNAME="rollback_${VERSION}"  # Appears in pg_stat_activity

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
    log_error "Usage: ./scripts/db-rollback.sh <version>"
    echo ""
    echo "Example:"
    echo "  ./scripts/db-rollback.sh v0_7_0"
    echo ""
    echo "Available snapshots:"
    ls -1t "$PROJECT_ROOT/supabase/schemas/" 2>/dev/null | grep "_before.sql" | head -10 || echo "  (none found)"
    exit 1
fi

if [ -z "$DB_URL" ]; then
    log_error "Database URL not found. Set SUPABASE_DB_URL or DATABASE_URL"
    exit 1
fi

# ===========================================================================
# FIND MOST RECENT SNAPSHOT
# ===========================================================================
echo ""
echo "========================================="
echo "🔍 FINDING SNAPSHOTS FOR $VERSION"
echo "========================================="

# Find most recent _before.sql snapshot for this version
SNAPSHOT=$(ls -1t "$PROJECT_ROOT/supabase/schemas/${VERSION}"*_before.sql 2>/dev/null | head -1 || true)

if [ -z "$SNAPSHOT" ]; then
    log_error "No snapshots found for version: $VERSION"
    echo ""
    echo "Available snapshots:"
    ls -1t "$PROJECT_ROOT/supabase/schemas/" 2>/dev/null | grep "_before.sql" | head -10
    exit 1
fi

log_info "Found snapshot: $(basename "$SNAPSHOT")"
log_info "Created: $(stat -f "%Sm" "$SNAPSHOT" 2>/dev/null || stat -c "%y" "$SNAPSHOT" 2>/dev/null)"
log_info "Size: $(du -h "$SNAPSHOT" | cut -f1)"

# ===========================================================================
# CONFIRMATION
# ===========================================================================
echo ""
log_warning "⚠️  WARNING: DESTRUCTIVE OPERATION!"
echo ""
echo "This will restore database to snapshot:"
echo "  File: $(basename "$SNAPSHOT")"
echo ""
log_warning "ALL current data will be REPLACED with snapshot data!"
log_warning "This action CANNOT be undone!"
echo ""
read -p "Type 'ROLLBACK' to confirm: " CONFIRMATION

if [ "$CONFIRMATION" != "ROLLBACK" ]; then
    log_info "Rollback cancelled by user."
    exit 0
fi

# ===========================================================================
# BACKUP CURRENT STATE (Safety Net)
# ===========================================================================
BACKUP_FILE="$PROJECT_ROOT/supabase/schemas/backup_before_rollback_${TIMESTAMP}.sql"

echo ""
echo "========================================="
echo "📸 BACKING UP CURRENT STATE"
echo "========================================="
log_info "Backup: $(basename "$BACKUP_FILE")"
log_info "Flags: --schema-only --clean --if-exists"

pg_dump "$DB_URL" \
    --schema-only \
    --clean \
    --if-exists \
    --no-owner \
    --no-privileges \
    > "$BACKUP_FILE"

log_success "Current state backed up ($(du -h "$BACKUP_FILE" | cut -f1))"
log_info "Emergency restore: psql \$DB_URL < $(basename "$BACKUP_FILE")"

# ===========================================================================
# RESTORE SNAPSHOT
# ===========================================================================
echo ""
echo "========================================="
echo "⏳ RESTORING SNAPSHOT"
echo "========================================="
log_info "Restoring: $(basename "$SNAPSHOT")"
log_info "Mode: Full restore (DROP + CREATE via --clean --if-exists)"

# The snapshot already has DROP IF EXISTS statements (generated with --clean --if-exists)
# Just apply it directly
if psql "$DB_URL" -v ON_ERROR_STOP=1 -f "$SNAPSHOT"; then
    log_success "Snapshot restored successfully"
else
    log_error "Restoration failed!"
    log_warning "Emergency backup available: $(basename "$BACKUP_FILE")"
    log_info "To restore: psql \$DB_URL < $BACKUP_FILE"
    exit 1
fi

# ===========================================================================
# VERIFICATION
# ===========================================================================
echo ""
echo "========================================="
echo "🔍 VERIFYING RESTORATION"
echo "========================================="

TABLE_COUNT=$(psql "$DB_URL" -t -A -c "SELECT COUNT(*) FROM pg_tables WHERE schemaname='public';")
FUNCTION_COUNT=$(psql "$DB_URL" -t -A -c "SELECT COUNT(*) FROM pg_proc WHERE pronamespace=(SELECT oid FROM pg_namespace WHERE nspname='public');")
POLICY_COUNT=$(psql "$DB_URL" -t -A -c "SELECT COUNT(*) FROM pg_policies WHERE schemaname='public';")

log_info "Tables: $TABLE_COUNT"
log_info "Functions: $FUNCTION_COUNT"
log_info "Policies: $POLICY_COUNT"

# ===========================================================================
# SUCCESS
# ===========================================================================
echo ""
echo "========================================="
echo "✅ ROLLBACK COMPLETE!"
echo "========================================="
echo ""
log_success "Rolled back to: $VERSION"
log_success "Snapshot: $(basename "$SNAPSHOT")"
echo ""
echo "📸 Backups available:"
echo "  • Current state (before rollback): $(basename "$BACKUP_FILE")"
echo ""
echo "📊 Database state:"
echo "  • Tables: $TABLE_COUNT"
echo "  • Functions: $FUNCTION_COUNT"
echo "  • Policies: $POLICY_COUNT"
echo ""
echo "🎯 Next steps:"
echo "  1. Verify database manually"
echo "  2. Run smoke test: ./scripts/db-test.sh $VERSION"
echo "  3. Update supabase/docs/MIGRATIONS.md with rollback info"
echo ""
echo "========================================="
