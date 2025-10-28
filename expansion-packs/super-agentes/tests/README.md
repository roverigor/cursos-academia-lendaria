# AIOS IDE Sync Tests

Test suite for the IDE sync system (`sync-to-ides.sh`).

## Test Structure

```
tests/
├── unit/               # Unit tests for individual functions
├── integration/        # Integration tests for full sync workflows
├── fixtures/           # Test data and sample files
└── README.md          # This file
```

## Running Tests

### Prerequisites

```bash
# Install bats (Bash Automated Testing System)
brew install bats-core
```

### Run All Tests

```bash
# From project root
bats expansion-packs/super-agentes/tests/unit/*.bats
bats expansion-packs/super-agentes/tests/integration/*.bats
```

### Run Specific Test File

```bash
bats expansion-packs/super-agentes/tests/unit/test_sync_file.bats
```

### Run with TAP Output

```bash
bats --tap expansion-packs/super-agentes/tests/unit/*.bats
```

## Test Coverage

### Unit Tests

- [x] `test_sync_file.bats` - Test sync_file() function
- [x] `test_pack_discovery.bats` - Test pack discovery with glob patterns
- [ ] `test_format_conversion.bats` - Test .md → .mdc conversion
- [ ] `test_wrapper_application.bats` - Test wrapper templates
- [ ] `test_backup_creation.bats` - Test backup file creation
- [ ] `test_path_handling.bats` - Test path handling with spaces
- [ ] `test_extract_description.bats` - Test description extraction

### Integration Tests

- [x] `test_sync_to_claude.bats` - Test full sync to Claude Code
- [ ] `test_sync_to_cursor.bats` - Test full sync to Cursor
- [ ] `test_dry_run.bats` - Test dry-run mode
- [ ] `test_selective_ide_sync.bats` - Test --ide= flag
- [ ] `test_pre_commit_hook.bats` - Test pre-commit hook integration

### E2E Tests

- [ ] `test_full_sync_workflow.bats` - Test complete sync workflow
- [ ] `test_backup_restore.bats` - Test backup and restore
- [ ] `test_performance.bats` - Test sync performance

## Writing Tests

### Example Unit Test

```bash
#!/usr/bin/env bats

# Test file: tests/unit/test_example.bats

setup() {
    # Runs before each test
    export TEST_DIR="$(mktemp -d)"
}

teardown() {
    # Runs after each test
    rm -rf "$TEST_DIR"
}

@test "example test case" {
    # Test implementation
    run echo "hello"
    [ "$status" -eq 0 ]
    [ "$output" = "hello" ]
}
```

### Example Integration Test

```bash
#!/usr/bin/env bats

@test "sync creates expected files" {
    run ./expansion-packs/super-agentes/scripts/sync-to-ides.sh --dry-run
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Sync complete" ]]
}
```

## Test Fixtures

Fixtures are sample files used for testing:

- `fixtures/test-config.yaml` - Sample .aios-sync.yaml
- `fixtures/test-pack/` - Sample expansion pack structure
- `fixtures/test-agent.md` - Sample agent file
- `fixtures/expected-output/` - Expected sync results

## CI Integration

### GitHub Actions

```yaml
name: Test IDE Sync

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install bats
        run: sudo npm install -g bats
      - name: Install yq
        run: sudo wget https://github.com/mikefarah/yq/releases/download/v4.35.1/yq_linux_amd64 -O /usr/bin/yq && sudo chmod +x /usr/bin/yq
      - name: Run tests
        run: bats expansion-packs/super-agentes/tests/**/*.bats
```

## Coverage Goals

- **Unit Tests**: 80% function coverage
- **Integration Tests**: All major workflows covered
- **E2E Tests**: Happy path + error scenarios

## Contributing

When adding new functionality to `sync-to-ides.sh`:

1. Write tests first (TDD)
2. Ensure tests pass before committing
3. Update this README with new test files
4. Aim for 80%+ code coverage

## Known Issues

- Tests require `yq` to be installed
- Some tests may be platform-specific (macOS vs Linux)
- Performance tests may vary based on system resources

## Future Enhancements

- [ ] Add code coverage reporting
- [ ] Add mutation testing
- [ ] Add property-based testing for edge cases
- [ ] Add performance benchmarking
- [ ] Add security scanning for shell scripts
