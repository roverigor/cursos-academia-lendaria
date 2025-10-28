#!/bin/bash
# ============================================================================
# AUTOMATED TEST: Versioned Tables Prevention System
# ============================================================================
# Purpose: Test that the versioned tables prevention system works end-to-end
# Usage: ./supabase/tests/test-versioned-tables-prevention.sh
# Exit codes:
#   0 = All tests passed
#   1 = One or more tests failed
# ============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  AUTOMATED TEST: Versioned Tables Prevention System            ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if SUPABASE_DB_URL is set
if [ -z "$SUPABASE_DB_URL" ]; then
    if [ -f .env ]; then
        source .env
    fi
fi

if [ -z "$SUPABASE_DB_URL" ]; then
    echo -e "${RED}✗${NC} SUPABASE_DB_URL not set"
    echo "  Run: source .env"
    exit 1
fi

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"

    ((TESTS_RUN++))
    echo -e "${YELLOW}TEST $TESTS_RUN:${NC} $test_name"

    if eval "$test_command"; then
        echo -e "${GREEN}  ✓ PASSED${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}  ✗ FAILED${NC}"
        ((TESTS_FAILED++))
    fi
    echo ""
}

# ============================================================================
# TEST 1: Detection script exists and is executable
# ============================================================================
run_test "Detection script exists" "[ -x ./supabase/scripts/detect-versioned-tables.sh ]"

# ============================================================================
# TEST 2: Clean database detection (should pass)
# ============================================================================
run_test "Clean database detected correctly" "./supabase/scripts/detect-versioned-tables.sh"

# ============================================================================
# TEST 3: Create versioned table and detect it
# ============================================================================
test_3() {
    # Create versioned table
    psql "$SUPABASE_DB_URL" -c "CREATE TABLE test_auto_v0_0_1 (id INT);" >/dev/null 2>&1

    # Run detector (should fail)
    if ./supabase/scripts/detect-versioned-tables.sh >/dev/null 2>&1; then
        # Cleanup
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_auto_v0_0_1;" >/dev/null 2>&1
        return 1  # Test failed (detector didn't catch it)
    else
        # Cleanup
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_auto_v0_0_1;" >/dev/null 2>&1
        return 0  # Test passed (detector caught it)
    fi
}
run_test "Versioned table detected" test_3

# ============================================================================
# TEST 4: Test backup table detection
# ============================================================================
test_4() {
    # Create backup table
    psql "$SUPABASE_DB_URL" -c "CREATE TABLE test_backup (id INT);" >/dev/null 2>&1

    # Run detector (should fail)
    if ./supabase/scripts/detect-versioned-tables.sh >/dev/null 2>&1; then
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_backup;" >/dev/null 2>&1
        return 1  # Test failed
    else
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_backup;" >/dev/null 2>&1
        return 0  # Test passed
    fi
}
run_test "Backup table detected" test_4

# ============================================================================
# TEST 5: Test old table detection
# ============================================================================
test_5() {
    psql "$SUPABASE_DB_URL" -c "CREATE TABLE test_old (id INT);" >/dev/null 2>&1

    if ./supabase/scripts/detect-versioned-tables.sh >/dev/null 2>&1; then
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_old;" >/dev/null 2>&1
        return 1
    else
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_old;" >/dev/null 2>&1
        return 0
    fi
}
run_test "Old table detected" test_5

# ============================================================================
# TEST 6: Test copy table detection
# ============================================================================
test_6() {
    psql "$SUPABASE_DB_URL" -c "CREATE TABLE test_copy (id INT);" >/dev/null 2>&1

    if ./supabase/scripts/detect-versioned-tables.sh >/dev/null 2>&1; then
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_copy;" >/dev/null 2>&1
        return 1
    else
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_copy;" >/dev/null 2>&1
        return 0
    fi
}
run_test "Copy table detected" test_6

# ============================================================================
# TEST 7: Test tmp table detection
# ============================================================================
test_7() {
    psql "$SUPABASE_DB_URL" -c "CREATE TABLE test_tmp (id INT);" >/dev/null 2>&1

    if ./supabase/scripts/detect-versioned-tables.sh >/dev/null 2>&1; then
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_tmp;" >/dev/null 2>&1
        return 1
    else
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_tmp;" >/dev/null 2>&1
        return 0
    fi
}
run_test "Tmp table detected" test_7

# ============================================================================
# TEST 8: Test legitimate table NOT detected (no false positives)
# ============================================================================
test_8() {
    psql "$SUPABASE_DB_URL" -c "CREATE TABLE test_valid_table (id INT);" >/dev/null 2>&1

    # Run detector (should pass - no versioned tables)
    if ./supabase/scripts/detect-versioned-tables.sh >/dev/null 2>&1; then
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_valid_table;" >/dev/null 2>&1
        return 0  # Test passed (no false positive)
    else
        psql "$SUPABASE_DB_URL" -c "DROP TABLE test_valid_table;" >/dev/null 2>&1
        return 1  # Test failed (false positive)
    fi
}
run_test "No false positives (mind_values not flagged)" test_8

# ============================================================================
# TEST 9: Pre-commit hook exists
# ============================================================================
run_test "Pre-commit hook installed" "[ -x .git/hooks/pre-commit ]"

# ============================================================================
# TEST 10: Documentation exists
# ============================================================================
run_test "Naming conventions documented" "[ -f docs/database/NAMING-CONVENTIONS.md ]"

# ============================================================================
# SUMMARY
# ============================================================================
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}TEST SUMMARY${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════════${NC}"
echo ""
echo "Tests run:    $TESTS_RUN"
echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                 ✓ ALL TESTS PASSED!                             ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "The versioned tables prevention system is working correctly."
    echo ""
    exit 0
else
    echo -e "${RED}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                 ✗ SOME TESTS FAILED!                            ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "The versioned tables prevention system has issues."
    echo "Review the failed tests above and fix the problems."
    echo ""
    exit 1
fi
