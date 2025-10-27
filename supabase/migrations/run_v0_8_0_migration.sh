#!/usr/bin/env bash
# =========================================================
# Run v0.8.0 Migration: MMOS Taxonomy
# =========================================================
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
MIGRATION_FILE="supabase/migrations/20251027012100_v0_8_0_mmos_taxonomy.sql"
DATA_DIR="supabase/migrations/data"

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}  MMOS Taxonomy Migration v0.8.0${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""

# Check SUPABASE_DB_URL
if [ -z "${SUPABASE_DB_URL:-}" ]; then
  if [ -f ".env" ]; then
    echo -e "${YELLOW}Loading SUPABASE_DB_URL from .env...${NC}"
    export $(grep SUPABASE_DB_URL .env | xargs)
  else
    echo -e "${RED}ERROR: SUPABASE_DB_URL not set and .env not found${NC}"
    exit 1
  fi
fi

echo -e "${GREEN}✓${NC} SUPABASE_DB_URL configured"
echo ""

# Step 1: Verify CSV files
echo -e "${YELLOW}Step 1: Verifying CSV files...${NC}"
for csv in sqlite_domains.csv sqlite_specializations.csv sqlite_skills.csv sqlite_traits.csv; do
  if [ ! -f "$DATA_DIR/$csv" ]; then
    echo -e "${RED}ERROR: Missing $csv${NC}"
    exit 1
  fi
  echo -e "${GREEN}✓${NC} Found $csv"
done
echo ""

# Step 2: Create snapshot (before)
echo -e "${YELLOW}Step 2: Creating snapshot (before migration)...${NC}"
SNAPSHOT_FILE="supabase/schemas/v0_8_0_$(date +%Y%m%d%H%M%S)_before.sql"
psql "$SUPABASE_DB_URL" -c "\
  SELECT table_name, COUNT(*) as row_count \
  FROM information_schema.tables t \
  LEFT JOIN (SELECT 'domains' as tn, COUNT(*) as cnt FROM domains UNION ALL \
             SELECT 'specializations', COUNT(*) FROM specializations UNION ALL \
             SELECT 'skills', COUNT(*) FROM skills UNION ALL \
             SELECT 'traits', COUNT(*) FROM traits) c \
  ON t.table_name = c.tn \
  WHERE table_schema='public' AND table_type='BASE TABLE' \
  AND t.table_name IN ('domains', 'specializations', 'skills', 'traits') \
  ORDER BY table_name;" > "$SNAPSHOT_FILE"
echo -e "${GREEN}✓${NC} Snapshot saved: $SNAPSHOT_FILE"
echo ""

# Step 3: Load CSV data into temp tables and run migration
echo -e "${YELLOW}Step 3: Running migration...${NC}"

# Create a combined SQL script that loads CSVs and runs migration
cat > /tmp/run_migration.sql <<'EOSQL'
-- Load specializations
\copy temp_specializations FROM 'supabase/migrations/data/sqlite_specializations.csv' WITH (FORMAT csv, HEADER true);

-- Load skills
\copy temp_skills FROM 'supabase/migrations/data/sqlite_skills.csv' WITH (FORMAT csv, HEADER true);

-- Load traits
\copy temp_traits FROM 'supabase/migrations/data/sqlite_traits.csv' WITH (FORMAT csv, HEADER true);

EOSQL

# Execute migration + CSV loading
psql "$SUPABASE_DB_URL" -f "$MIGRATION_FILE" -f /tmp/run_migration.sql

echo -e "${GREEN}✓${NC} Migration executed"
echo ""

# Step 4: Validation
echo -e "${YELLOW}Step 4: Validating migration...${NC}"
psql "$SUPABASE_DB_URL" -c "
SELECT
  'domains' as table_name, COUNT(*) as row_count FROM domains
UNION ALL
SELECT 'specializations', COUNT(*) FROM specializations
UNION ALL
SELECT 'skills', COUNT(*) FROM skills
UNION ALL
SELECT 'traits', COUNT(*) FROM traits
UNION ALL
SELECT 'mmos_id_mappings', COUNT(*) FROM mmos_id_mappings
ORDER BY table_name;"

echo ""

# Step 5: Verify mappings
echo -e "${YELLOW}Step 5: Verifying ID mappings...${NC}"
psql "$SUPABASE_DB_URL" -c "
SELECT entity_type, COUNT(*) as mapping_count
FROM mmos_id_mappings
GROUP BY entity_type
ORDER BY entity_type;"

echo ""
echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}  Migration Complete!${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""
echo "Next steps:"
echo "  - Review validation output above"
echo "  - Check snapshot file: $SNAPSHOT_FILE"
echo "  - Proceed to Phase 2 (minds + sources migration)"
echo ""
