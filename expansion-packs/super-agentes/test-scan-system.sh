#!/bin/bash

echo "🧪 Testing Scan System..."
echo ""

# Test 1: Load library
echo "Test 1: Loading core library..."
source expansion-packs/super-agentes/scan-system/lib/scan-core.sh
if [[ $? -eq 0 ]]; then
    echo "✅ Library loaded"
else
    echo "❌ Failed to load library"
    exit 1
fi

# Test 2: Validate environment
echo ""
echo "Test 2: Validating environment..."
validate_scan_environment "design-system"
if [[ $? -eq 0 ]]; then
    echo "✅ Environment valid"
else
    echo "❌ Environment validation failed"
    exit 1
fi

# Test 3: Get next ID
echo ""
echo "Test 3: Getting next artifact ID..."
NEXT_ID=$(get_next_artifact_id "design-system")
echo "Next ID will be: $NEXT_ID"
if [[ "$NEXT_ID" == "001" ]]; then
    echo "✅ ID generation works"
else
    echo "⚠️  ID is not 001, might have existing scans"
fi

echo ""
echo "🎉 All tests passed! Scan system is ready to use."
