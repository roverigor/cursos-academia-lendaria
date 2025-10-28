#!/usr/bin/env bats
# Unit tests for sync_file() function

# Load the sync script functions
load_sync_functions() {
    # Source the sync script to get function definitions
    # Note: This requires refactoring sync-to-ides.sh to separate functions from main execution
    source "${BATS_TEST_DIRNAME}/../../scripts/sync-to-ides.sh"
}

setup() {
    # Create temporary test directory
    export TEST_DIR="$(mktemp -d)"
    export SOURCE_FILE="$TEST_DIR/source.md"
    export DEST_FILE="$TEST_DIR/dest.md"

    # Create sample source file
    cat > "$SOURCE_FILE" <<'EOF'
# Test Agent

This is a test agent file.

## Commands

- help: Show help
EOF
}

teardown() {
    # Clean up temporary directory
    rm -rf "$TEST_DIR"
}

@test "sync_file creates destination file" {
    skip "Requires function extraction from sync-to-ides.sh"

    # Test that sync_file creates the destination file
    # sync_file "$SOURCE_FILE" "$DEST_FILE" "none" "md"

    # [ -f "$DEST_FILE" ]
}

@test "sync_file creates destination directory if missing" {
    skip "Requires function extraction from sync-to-ides.sh"

    # export DEST_FILE="$TEST_DIR/nested/dir/dest.md"
    # sync_file "$SOURCE_FILE" "$DEST_FILE" "none" "md"

    # [ -d "$TEST_DIR/nested/dir" ]
    # [ -f "$DEST_FILE" ]
}

@test "sync_file creates backup of existing file" {
    skip "Requires function extraction from sync-to-ides.sh"

    # Create existing destination file
    # echo "old content" > "$DEST_FILE"

    # sync_file "$SOURCE_FILE" "$DEST_FILE" "none" "md"

    # [ -f "$DEST_FILE.bak" ]
    # [ "$(cat "$DEST_FILE.bak")" = "old content" ]
}

@test "sync_file applies wrapper template" {
    skip "Requires function extraction from sync-to-ides.sh"

    # sync_file "$SOURCE_FILE" "$DEST_FILE" "slash-command" "md"

    # # Check that wrapper was applied
    # grep -q "# /source Command" "$DEST_FILE"
}

@test "sync_file converts format to mdc" {
    skip "Requires function extraction from sync-to-ides.sh"

    # export DEST_FILE="$TEST_DIR/dest.mdc"
    # sync_file "$SOURCE_FILE" "$DEST_FILE" "none" "mdc"

    # [ -f "$DEST_FILE" ]
    # [[ "$DEST_FILE" == *.mdc ]]
}

# TODO: Add more tests after refactoring sync-to-ides.sh to separate functions
