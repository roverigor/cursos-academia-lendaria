#!/bin/bash
# Compare outputs/minds vs SQLite minds

OUTPUTS_DIR="outputs/minds"
DB_PATH="outputs/database/mmos.db"

echo "═══════════════════════════════════════════════════════════"
echo "  Mind Comparison: outputs/minds vs SQLite"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Count minds
outputs_count=$(ls -1d "$OUTPUTS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ')
sqlite_count=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM minds;")

echo "📊 Counts:"
echo "   outputs/minds:  $outputs_count directories"
echo "   SQLite:         $sqlite_count rows"
echo "   Difference:     $((outputs_count - sqlite_count))"
echo ""

# Find missing minds
echo "🔍 Minds in outputs/minds but NOT in SQLite:"
echo ""

missing_count=0
for mind_dir in "$OUTPUTS_DIR"/*/; do
  mind_slug=$(basename "$mind_dir")
  exists=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM minds WHERE slug = '$mind_slug';")

  if [ "$exists" = "0" ]; then
    echo "   ❌ $mind_slug"
    ((missing_count++))
  fi
done

echo ""
echo "Total missing: $missing_count minds"
echo ""

# Find extra minds (in SQLite but not in outputs)
echo "🔍 Minds in SQLite but NOT in outputs/minds:"
echo ""

extra_count=0
sqlite3 "$DB_PATH" "SELECT slug FROM minds;" | while read slug; do
  if [ ! -d "$OUTPUTS_DIR/$slug" ]; then
    echo "   ⚠️  $slug"
    ((extra_count++))
  fi
done

echo ""
