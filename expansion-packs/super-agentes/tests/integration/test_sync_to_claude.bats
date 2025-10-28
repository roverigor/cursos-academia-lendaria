#!/usr/bin/env bats
# Integration tests for syncing to Claude Code

setup() {
    # Create temporary test environment
    export TEST_DIR="$(mktemp -d)"
    export PROJECT_ROOT="$TEST_DIR"

    # Create sample expansion pack
    mkdir -p "$TEST_DIR/expansion-packs/test-pack/agents"
    cat > "$TEST_DIR/expansion-packs/test-pack/agents/test-agent.md" <<'EOF'
```yaml
agent:
  name: Test Agent
  title: Test Agent for Testing
```

# Test Agent

This is a test agent.
EOF

    # Create sample config
    cat > "$TEST_DIR/.aios-sync.yaml" <<'EOF'
version: "1.0.0"

active_ides:
  - claude

pack_aliases:
  test-pack: TestPack

sync_mappings:
  test_pack_agents:
    source: "expansion-packs/*/agents/"
    destinations:
      claude:
        - path: ".claude/commands/{pack}/agents/"
          format: "md"
          wrapper: "none"

wrappers:
  none:
    prepend: ""

file_filters:
  include:
    - "*.md"
  exclude:
    - "README.md"

behavior:
  create_missing_dirs: true
  backup_before_sync: false
  fail_on_error: false
EOF
}

teardown() {
    # Clean up temporary directory
    rm -rf "$TEST_DIR"
}

@test "dry-run mode does not create files" {
    # Run sync in dry-run mode
    cd "$TEST_DIR"
    run ../expansion-packs/super-agentes/scripts/sync-to-ides.sh --dry-run

    # Should complete successfully
    [ "$status" -eq 0 ]

    # Should not create any files
    [ ! -d ".claude/commands" ]
}

@test "sync creates Claude Code directory structure" {
    skip "Requires running actual sync script with test config"

    # cd "$TEST_DIR"
    # run ../expansion-packs/super-agentes/scripts/sync-to-ides.sh

    # [ "$status" -eq 0 ]
    # [ -d ".claude/commands/TestPack/agents" ]
}

@test "sync creates files in correct location" {
    skip "Requires running actual sync script with test config"

    # cd "$TEST_DIR"
    # run ../expansion-packs/super-agentes/scripts/sync-to-ides.sh

    # [ "$status" -eq 0 ]
    # [ -f ".claude/commands/TestPack/agents/test-agent.md" ]
}

@test "sync respects pack aliases" {
    skip "Requires running actual sync script with test config"

    # cd "$TEST_DIR"
    # run ../expansion-packs/super-agentes/scripts/sync-to-ides.sh

    # # Should use alias "TestPack" not "test-pack"
    # [ -d ".claude/commands/TestPack" ]
    # [ ! -d ".claude/commands/test-pack" ]
}

@test "sync logs performance metrics" {
    skip "Requires running actual sync script with test config"

    # cd "$TEST_DIR"
    # run ../expansion-packs/super-agentes/scripts/sync-to-ides.sh

    # [ "$status" -eq 0 ]
    # grep -q "METRICS" ".aios-sync.log"
    # grep -q "Duration:" ".aios-sync.log"
}

# TODO: Add more integration tests after refactoring
