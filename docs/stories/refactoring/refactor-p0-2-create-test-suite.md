# Story: Create Basic Test Suite

**Epic:** Architecture Refactoring
**Status:** 📋 NOT STARTED
**Priority:** P0 - CRITICAL
**Estimated Effort:** 5-7 days
**Category:** Quality Assurance / Technical Debt

---

## User Story

*As a developer, I want a basic test suite with 40%+ code coverage, so that refactoring is safe, regressions are detected, and code quality is guaranteed.*

---

## Context

**Current State - Zero Test Coverage**:

Analysis of `docs/brownfield-architecture.md` identified:

```bash
$ npm test
No tests found, exiting with code 1
196 files checked.
testMatch: **/__tests__/**/*.js, **/*.test.js - 0 matches
```

**Problems**:
1. 🚨 **0% code coverage** - No safety net for refactoring
2. 🚨 **Jest configured but unused** - package.json has test scripts, no tests
3. 🚨 **No CI/CD validation** - Can merge broken code
4. 🚨 **Manual QA only** - Time-consuming, error-prone
5. 🚨 **Regression risk** - No way to detect breaking changes

**Impact**:
- Refactoring is **extremely risky**
- Technical debt compounds (can't safely clean up)
- Story implementation blocked (can't validate without tests)

---

## Acceptance Criteria

### AC1: Project-Wide Test Structure

**Given** zero existing tests
**When** creating test structure
**Then** must establish:

```
tests/
├── unit/                  # Unit tests (isolated functions)
│   ├── database/
│   │   └── populate_minds.test.js
│   ├── pipeline/
│   │   ├── import-analysis.test.js
│   │   └── validate-integration.test.js
│   └── migration/
│       └── extract_metadata.test.py
├── integration/           # Integration tests (multi-component)
│   ├── mmos/
│   │   └── mind-creation.test.js
│   └── etl/
│       └── source-collection.test.js
└── e2e/                   # End-to-end tests (full workflows)
    └── launcher/
        └── prompt-execution.test.js
```

**Configuration**:
```javascript
// jest.config.js
module.exports = {
  testEnvironment: 'node',
  coverageDirectory: 'coverage',
  collectCoverageFrom: [
    'scripts/**/*.js',
    'expansion-packs/**/*.js',
    '.aios-core/**/*.js',
    '!**/node_modules/**',
    '!**/tests/**'
  ],
  testMatch: [
    '**/__tests__/**/*.js',
    '**/*.test.js'
  ],
  coverageThreshold: {
    global: {
      branches: 40,
      functions: 40,
      lines: 40,
      statements: 40
    }
  }
};
```

**Validation**:
- [ ] `tests/` directory created with 3 subdirectories
- [ ] jest.config.js updated with coverage thresholds
- [ ] npm test runs without config errors

---

### AC2: Critical Path Tests (Database Scripts)

**Given** 2 duplicate scripts (sh + js) in scripts/database/
**When** creating tests
**Then** must cover:

**Test File**: `tests/unit/database/populate_minds.test.js`

```javascript
describe('populate_minds.js', () => {
  test('converts slug to display name correctly', () => {
    // elon_musk → Elon Musk
    // nassim_taleb → Nassim Taleb
  });

  test('creates minds table entry with required fields', () => {
    // Mock SQLite, verify INSERT statement
  });

  test('detects metadata.yaml if present', () => {
    // Verify metadata parsing logic
  });

  test('handles missing minds directory gracefully', () => {
    // Error handling test
  });

  test('updates existing mind without duplicating', () => {
    // ON CONFLICT logic
  });
});
```

**Coverage Target**: 60%+ of `scripts/database/populate_minds.js`

**Validation**:
- [ ] Test file created with 5+ tests
- [ ] All tests pass
- [ ] Coverage >= 60% for populate_minds.js
- [ ] Mock SQLite database (not real DB)

---

### AC3: Pipeline Integration Tests

**Given** pipeline scripts in scripts/pipeline/
**When** creating integration tests
**Then** must cover:

**Test File**: `tests/integration/pipeline/import-analysis.test.js`

```javascript
describe('import-analysis pipeline', () => {
  test('imports analysis artifacts to database', async () => {
    // Setup: Create temp mind with analysis/
    // Execute: Run import-analysis.js
    // Verify: Database has traits, frameworks entries
  });

  test('handles missing analysis directory gracefully', async () => {
    // Error case: Mind without analysis/
  });

  test('skips already imported artifacts', async () => {
    // Idempotency test
  });
});
```

**Coverage Target**: 50%+ of `scripts/pipeline/import-analysis.js`

**Validation**:
- [ ] Integration test created with 3+ tests
- [ ] Uses temporary test fixtures (not production data)
- [ ] Cleans up after tests (no side effects)
- [ ] Coverage >= 50%

---

### AC4: Expansion Pack Tests (MMOS)

**Given** mmos pack
**When** creating tests
**Then** must cover:

**Test File**: `tests/unit/mmos/config-validator.test.js`

```javascript
describe('MMOS config.yaml validation', () => {
  test('validates required fields present', () => {
    // name, version, slashPrefix, etc.
  });

  test('rejects invalid YAML syntax', () => {
    // Malformed YAML
  });

  test('validates agents array structure', () => {
    // Each agent has id, file, role
  });

  test('validates tasks array structure', () => {
    // Each task has id, file, purpose
  });
});
```

**Coverage Target**: 40%+ of expansion pack core logic

**Validation**:
- [ ] At least 1 test file per expansion pack
- [ ] Config validation tested
- [ ] Core functionality tested (not full coverage)

---

### AC5: CI/CD Integration (GitHub Actions)

**Given** test suite created
**When** setting up CI/CD
**Then** must create:

**File**: `.github/workflows/test.yml`

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm install
      - run: npm test
      - run: npm run test:coverage
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
```

**Validation**:
- [ ] Workflow file created
- [ ] Tests run on every push/PR
- [ ] Coverage report uploaded
- [ ] Build fails if tests fail

---

### AC6: Test Documentation & Guidelines

**Given** new test suite
**When** documenting
**Then** must create:

**File**: `tests/README.md`

```markdown
# Test Suite Documentation

## Running Tests

bash
npm test              # Run all tests
npm run test:watch    # Watch mode
npm run test:coverage # With coverage report


## Writing Tests

### Unit Tests (tests/unit/)
- Test isolated functions
- Mock external dependencies
- Fast (<100ms per test)

### Integration Tests (tests/integration/)
- Test multi-component interactions
- Use test fixtures (not production data)
- Clean up after tests

### E2E Tests (tests/e2e/)
- Test full workflows
- Slower (acceptable up to 5s per test)
- Minimal mocking

## Coverage Targets

- Minimum: 40% (all metrics)
- Goal: 70%+
- Critical paths: 80%+

## Test File Naming

- Unit: `{module}.test.js`
- Integration: `{workflow}.test.js`
- E2E: `{feature}.e2e.test.js`
```

**Validation**:
- [ ] README.md created in tests/
- [ ] Examples provided
- [ ] Guidelines clear for contributors

---

## Success Metrics

1. **Coverage**: 40%+ lines/branches/functions/statements
2. **Test Count**: 30+ tests minimum
3. **CI Integration**: Tests run automatically on push
4. **Documentation**: Test guidelines documented
5. **Build Confidence**: Developers can refactor safely

---

## Technical Notes

### Test Priorities (Ordered)

1. **P0 - Database scripts** (populate_minds.js) - 60% coverage
2. **P1 - Pipeline scripts** (import-analysis.js, validate-integration.js) - 50% coverage
3. **P2 - Config validators** (expansion pack configs) - 40% coverage
4. **P3 - Utilities** (YAML parsing, file operations) - 40% coverage

### Mocking Strategy

**Database (SQLite)**:
```javascript
// Use in-memory SQLite for tests
const Database = require('better-sqlite3');
const db = new Database(':memory:');
```

**File System**:
```javascript
// Use mock-fs or tmp for file operations
const tmp = require('tmp');
const testDir = tmp.dirSync({ unsafeCleanup: true });
```

**API Calls**:
```javascript
// Use nock for HTTP mocking
const nock = require('nock');
nock('https://api.example.com').get('/data').reply(200, mockData);
```

### Performance Targets

- Unit tests: <100ms each
- Integration tests: <1s each
- E2E tests: <5s each
- Total suite: <30s

---

## Dependencies

- Jest (already in package.json)
- better-sqlite3 (already installed)
- mock-fs or tmp (new - for file mocking)
- nock (new - for HTTP mocking)

---

## Non-Goals (Out of Scope)

- ❌ 100% coverage (unrealistic for legacy code)
- ❌ Testing all legacy code (focus on critical paths)
- ❌ Performance tests (future story)
- ❌ Security tests (future story)

---

## Risks and Mitigations

### Risk 1: Tests too slow (>1min total)
**Mitigation**: Focus on unit tests (fast), minimize E2E tests

### Risk 2: Flaky tests (intermittent failures)
**Mitigation**: Proper cleanup, deterministic test data, no external dependencies

### Risk 3: Low coverage blocks development
**Mitigation**: 40% minimum (achievable), not 70%+ initially

---

## File List

**Created**:
- `tests/unit/database/populate_minds.test.js`
- `tests/unit/pipeline/import-analysis.test.js`
- `tests/integration/pipeline/import-analysis.test.js`
- `tests/unit/mmos/config-validator.test.js`
- `tests/README.md`
- `.github/workflows/test.yml`
- `jest.config.js` (updated)

**Modified**:
- `package.json` (add mock-fs, nock, tmp to devDependencies)

---

## Story Status

**Status**: 📋 NOT STARTED
**Source**: brownfield-architecture.md Section 3.7, Problem #1
**Blocked By**: None
**Blocks**: All refactoring stories (cannot refactor safely without tests)

---

**Priority Justification**: P0 - Zero coverage blocks safe refactoring. Must be completed before any structural changes.
