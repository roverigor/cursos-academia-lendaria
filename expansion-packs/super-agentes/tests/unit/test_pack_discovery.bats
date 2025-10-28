#!/usr/bin/env bats
# Unit tests for pack discovery with glob patterns

setup() {
    # Create temporary test directory with sample pack structure
    export TEST_DIR="$(mktemp -d)"
    export PROJECT_ROOT="$TEST_DIR"

    # Create sample expansion packs
    mkdir -p "$TEST_DIR/expansion-packs/pack-1/agents"
    mkdir -p "$TEST_DIR/expansion-packs/pack-2/agents"
    mkdir -p "$TEST_DIR/expansion-packs/pack-3/tasks"  # No agents dir

    # Create sample agent files
    echo "# Agent 1" > "$TEST_DIR/expansion-packs/pack-1/agents/agent1.md"
    echo "# Agent 2" > "$TEST_DIR/expansion-packs/pack-2/agents/agent2.md"
}

teardown() {
    # Clean up temporary directory
    rm -rf "$TEST_DIR"
}

@test "glob pattern discovers all packs with agents directories" {
    # Test that glob pattern finds all packs with agents/ dirs
    cd "$TEST_DIR"

    shopt -s nullglob
    FOUND_DIRS=(expansion-packs/*/agents/)
    shopt -u nullglob

    [ ${#FOUND_DIRS[@]} -eq 2 ]
}

@test "glob pattern handles spaces in directory names" {
    # Create pack with space in name
    mkdir -p "$TEST_DIR/expansion-packs/pack with spaces/agents"
    echo "# Agent" > "$TEST_DIR/expansion-packs/pack with spaces/agents/agent.md"

    cd "$TEST_DIR"

    shopt -s nullglob
    FOUND_DIRS=(expansion-packs/*/agents/)
    shopt -u nullglob

    [ ${#FOUND_DIRS[@]} -eq 3 ]
}

@test "glob pattern returns empty array when no packs exist" {
    # Remove all packs
    rm -rf "$TEST_DIR/expansion-packs"
    mkdir -p "$TEST_DIR/expansion-packs"

    cd "$TEST_DIR"

    shopt -s nullglob
    FOUND_DIRS=(expansion-packs/*/agents/)
    shopt -u nullglob

    [ ${#FOUND_DIRS[@]} -eq 0 ]
}

@test "pack discovery excludes packs without agents directory" {
    cd "$TEST_DIR"

    shopt -s nullglob
    FOUND_DIRS=(expansion-packs/*/agents/)
    shopt -u nullglob

    # pack-3 has no agents dir, so should not be found
    [[ ! " ${FOUND_DIRS[@]} " =~ " expansion-packs/pack-3/agents/ " ]]
}
