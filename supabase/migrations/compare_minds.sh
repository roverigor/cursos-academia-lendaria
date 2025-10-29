#!/bin/bash
# Compare outputs/minds vs Supabase minds

OUTPUTS_DIR="outputs/minds"
SUPABASE_DB_URL="${SUPABASE_DB_URL}"

if [ -z "$SUPABASE_DB_URL" ]; then
  echo "❌ SUPABASE_DB_URL not set. Export the connection string before running."
  exit 1
fi

echo "═══════════════════════════════════════════════════════════"
echo "  Mind Comparison: outputs/minds vs Supabase"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Count minds
outputs_count=$(ls -1d "$OUTPUTS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ')
supabase_count=$(psql "$SUPABASE_DB_URL" -At -c "SELECT COUNT(*) FROM minds;")

echo "📊 Counts:"
echo "   outputs/minds:  $outputs_count directories"
echo "   Supabase:       $supabase_count rows"
echo "   Difference:     $((outputs_count - supabase_count))"
echo ""

# Find missing minds
echo "🔍 Minds in outputs/minds but NOT in Supabase:"
echo ""

missing_count=0
for mind_dir in "$OUTPUTS_DIR"/*/; do
  mind_slug=$(basename "$mind_dir")
  exists=$(psql "$SUPABASE_DB_URL" -At -c "SELECT COUNT(*) FROM minds WHERE slug = '$mind_slug';")

  if [ "$exists" = "0" ]; then
    echo "   ❌ $mind_slug"
    ((missing_count++))
  fi
done

echo ""
echo "Total missing: $missing_count minds"
echo ""

# Find extra minds (in Supabase but not in outputs)
echo "🔍 Minds in Supabase but NOT in outputs/minds:"
echo ""

extra_count=0
psql "$SUPABASE_DB_URL" -At -c "SELECT slug FROM minds;" | while read slug; do
  if [ ! -d "$OUTPUTS_DIR/$slug" ]; then
    echo "   ⚠️  $slug"
    ((extra_count++))
  fi
done

echo ""
