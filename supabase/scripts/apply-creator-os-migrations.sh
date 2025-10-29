#!/bin/bash
# ============================================================================
# CreatorOS Migration Application Script
# ============================================================================
# Purpose: Safely apply CreatorOS schema changes and RLS policies
# Usage: ./supabase/scripts/apply-creator-os-migrations.sh
# ============================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🗄️  CreatorOS Database Migration - Phase 1 & 2"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check prerequisites
echo "📋 Pre-flight checks..."

# 1. Check SUPABASE_DB_URL
if [ -z "$SUPABASE_DB_URL" ]; then
    echo -e "${RED}✗ SUPABASE_DB_URL not set${NC}"
    echo "  Please configure your .env file and run: source .env"
    exit 1
fi
echo -e "${GREEN}✓${NC} SUPABASE_DB_URL configured"

# 2. Check psql
if ! command -v psql &> /dev/null; then
    echo -e "${RED}✗ psql not found${NC}"
    echo "  Install PostgreSQL client tools"
    exit 1
fi
echo -e "${GREEN}✓${NC} psql found"

# 3. Test connection
echo ""
echo "🔌 Testing database connection..."
if ! psql "$SUPABASE_DB_URL" -c "SELECT 1" &> /dev/null; then
    echo -e "${RED}✗ Cannot connect to database${NC}"
    echo "  Check your SUPABASE_DB_URL and network connection"
    exit 1
fi
echo -e "${GREEN}✓${NC} Database connection successful"

# 4. Check if migrations exist
if [ ! -f "supabase/migrations/20251028120000_creator_os_schema_changes.sql" ]; then
    echo -e "${RED}✗ Phase 1 migration file not found${NC}"
    exit 1
fi

if [ ! -f "supabase/migrations/20251028120001_creator_os_rls_policies.sql" ]; then
    echo -e "${RED}✗ Phase 2 migration file not found${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Migration files found"

# Create backup directory
BACKUP_DIR="supabase/backups"
mkdir -p "$BACKUP_DIR"

# Backup timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/pre_creator_os_${TIMESTAMP}.sql"

echo ""
echo "💾 Creating schema backup..."
pg_dump "$SUPABASE_DB_URL" --schema-only > "$BACKUP_FILE" 2>/dev/null
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Backup created: $BACKUP_FILE"
else
    echo -e "${YELLOW}⚠${NC}  Backup failed (continuing anyway)"
fi

# Confirmation
echo ""
echo -e "${YELLOW}⚠️  IMPORTANT${NC}"
echo "This will apply the following changes to your database:"
echo ""
echo "  Phase 1 (Schema Changes):"
echo "    • Add creator_mind_id to content_projects"
echo "    • Add persona_mind_id to content_projects"  
echo "    • Create indexes for mind attribution"
echo "    • Add created_at to junction tables"
echo "    • Create v_contents_with_creators view"
echo ""
echo "  Phase 2 (RLS Security):"
echo "    • Enable RLS on 5 CreatorOS tables"
echo "    • Create KISS policies for multi-tenant isolation"
echo ""
read -p "Continue? (yes/no): " -r
echo
if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
    echo "Migration cancelled"
    exit 0
fi

# Apply Phase 1: Schema Changes
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Phase 1: Schema Changes"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

psql "$SUPABASE_DB_URL" -f supabase/migrations/20251028120000_creator_os_schema_changes.sql

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Phase 1 applied successfully"
else
    echo -e "${RED}✗ Phase 1 failed${NC}"
    echo "  Restore from backup: psql \"\$SUPABASE_DB_URL\" < $BACKUP_FILE"
    exit 1
fi

# Apply Phase 2: RLS Policies
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Phase 2: RLS Security"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

psql "$SUPABASE_DB_URL" -f supabase/migrations/20251028120001_creator_os_rls_policies.sql

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Phase 2 applied successfully"
else
    echo -e "${RED}✗ Phase 2 failed${NC}"
    echo "  Restore from backup: psql \"\$SUPABASE_DB_URL\" < $BACKUP_FILE"
    exit 1
fi

# Validation
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Checking new columns..."
psql "$SUPABASE_DB_URL" -c "
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'content_projects' 
  AND column_name IN ('creator_mind_id', 'persona_mind_id')
ORDER BY column_name;
"

echo ""
echo "Checking RLS status..."
psql "$SUPABASE_DB_URL" -c "
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
  AND tablename LIKE 'content%'
ORDER BY tablename;
"

echo ""
echo "Checking policies..."
psql "$SUPABASE_DB_URL" -c "
SELECT tablename, COUNT(*) as policy_count
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename LIKE 'content%'
GROUP BY tablename
ORDER BY tablename;
"

# Success
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "  ${GREEN}✅ Migrations Applied Successfully${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo "  1. Test RLS: psql \"\$SUPABASE_DB_URL\" -f supabase/tests/test_creator_os_rls.sql"
echo "  2. Enable persistence: export CREATOR_OS_DB_PERSIST=true"
echo "  3. Generate test course to verify database writes"
echo ""
echo "Backup location: $BACKUP_FILE"
echo ""
