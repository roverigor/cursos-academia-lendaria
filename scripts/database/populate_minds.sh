#!/bin/bash
# MMOS Database - Populate Minds
# Populates the minds table with basic information from docs/minds/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/../.."
MINDS_DIR="$PROJECT_ROOT/docs/minds"
DB_PATH="$PROJECT_ROOT/docs/mmos/mmos.db"

echo "═══════════════════════════════════════════════════════════"
echo "  MMOS Database - Populate Minds"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Get all mind directories
MINDS=($(ls -1 "$MINDS_DIR" | grep -v "\.md\|\.csv" | sort))

echo "📊 Found ${#MINDS[@]} minds in $MINDS_DIR"
echo ""

# Counter
inserted=0
updated=0

# Process each mind
for mind_slug in "${MINDS[@]}"; do
  mind_dir="$MINDS_DIR/$mind_slug"

  # Skip if not a directory
  if [ ! -d "$mind_dir" ]; then
    continue
  fi

  # Convert slug to display name (capitalize each word)
  display_name=$(echo "$mind_slug" | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')

  # Check if already exists
  exists=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM minds WHERE slug = '$mind_slug';")

  # Insert or update
  if [ "$exists" -eq 0 ]; then
    sqlite3 "$DB_PATH" "
      INSERT INTO minds (
        slug,
        display_name,
        subject_type,
        privacy_level,
        status,
        version,
        created_at,
        updated_at
      ) VALUES (
        '$mind_slug',
        '$display_name',
        'public_figure',
        'public',
        'active',
        '1.0.0',
        datetime('now'),
        datetime('now')
      );
    "
    echo "  ✓ Inserted: $display_name ($mind_slug)"
    ((inserted++))
  else
    sqlite3 "$DB_PATH" "
      UPDATE minds
      SET display_name = '$display_name',
          updated_at = datetime('now')
      WHERE slug = '$mind_slug';
    "
    echo "  ✓ Updated: $display_name ($mind_slug)"
    ((updated++))
  fi
done

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  Summary"
echo "═══════════════════════════════════════════════════════════"
echo "  • New minds inserted: $inserted"
echo "  • Existing minds updated: $updated"
echo "  • Total processed: $((inserted + updated))"

# Validation
total=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM minds;")
echo ""
echo "✅ Database verification: $total minds"
echo ""
