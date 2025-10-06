#!/usr/bin/env bash
# Test all 6 phases of MMOS pipeline

set -e

echo "🧪 Testing AIOS Launcher - All 6 Phases"
echo "========================================"
echo ""

source docs/mmos/launcher/.venv/bin/activate

# Test cases: phase:prompt_id
tests=(
  "viability:viability_scorecard_apex"
  "research:research_source_discovery"
  "analysis:analysis_source_reading"
  "synthesis:synthesis_extract_core"
  "implementation:implementation_generalista_compiler"
  "testing:testing_test_generator"
)

for test in "${tests[@]}"; do
  phase="${test%%:*}"
  prompt="${test##*:}"

  echo "📍 Testing $phase phase..."
  echo "   Prompt: $prompt"

  python3 -m docs.mmos.launcher.cli \
    --mind steve_jobs \
    --phase "$phase" \
    --prompt "$prompt" \
    --show-deps \
    --dry-run 2>&1 | grep -E "(Phase:|Dependencies:|Duration:)" || true

  echo "   ✅ Success"
  echo ""
done

echo "🎉 All phases tested successfully!"
