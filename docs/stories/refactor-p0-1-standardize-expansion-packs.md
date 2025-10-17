# Story: Standardize Expansion Pack Structure

**Epic:** Architecture Refactoring
**Status:** 📋 NOT STARTED
**Priority:** P0 - CRITICAL
**Estimated Effort:** 3-5 days
**Category:** Technical Debt / Architecture

---

## User Story

*As a framework maintainer, I want all expansion packs to follow a consistent directory structure, so that onboarding is easier, templates can be created, and validation is automated.*

---

## Context

**Current State - Architectural Inconsistency**:

Analysis of `docs/brownfield-architecture.md` identified that **NONE** of the 4 expansion packs follow a consistent structure:

| Pack | Extra Dirs | Issues |
|------|-----------|--------|
| mmos-mind-mapper | lib/ | ✅ Cleanest structure |
| creator-os | database/, docs/, epics/, scripts/ | ⚠️ 4 extra directories |
| etl-data-collector | bin/, config/, docs/, environments/, **node_modules/**  | 🚨 5 extras + own node_modules! |
| innerlens | docs/, epics/, scripts/, testing/, workflows/, **package.json** | 🚨 5 extras + own package.json! |

**Problems**:
1. ❌ Impossible to create expansion pack templates
2. ❌ `.expansion-creator` doesn't validate structure
3. ❌ Confuses new contributors (which structure to follow?)
4. ❌ ETL/InnerLens have independent npm dependencies (breaks monorepo)

**Impact**: Low maintainability, high cognitive load, broken DRY principle.

---

## Acceptance Criteria

### AC1: Define Universal Expansion Pack Standard

**Given** analysis of existing packs
**When** creating the standard
**Then** the structure must be:

```
expansion-packs/{pack-name}/
├── agents/           # REQUIRED - Agent definitions
├── tasks/            # REQUIRED - Task workflows
├── templates/        # REQUIRED - Document templates
├── checklists/       # REQUIRED - Validation checklists
├── data/             # OPTIONAL - Knowledge bases, frameworks
├── config.yaml       # REQUIRED - Pack configuration
└── README.md         # REQUIRED - Pack documentation

# FORBIDDEN:
❌ node_modules/      # Use root-level dependencies
❌ package.json       # Use root package.json
❌ docs/              # Use README.md only
❌ scripts/           # Use /scripts/{pack}/ if needed
❌ epics/             # Use root /docs/epics/
❌ testing/           # Use /tests/{pack}/
❌ database/          # Use /scripts/database/
❌ bin/               # Use /scripts/ or /bin/ at root
❌ config/            # Use config.yaml only
❌ environments/      # Use .env at root
```

**Validation**:
- [ ] Standard documented in `.expansion-creator/docs/STRUCTURE_STANDARD.md`
- [ ] Rationale provided for each forbidden directory
- [ ] Migration path documented for existing packs

---

### AC2: Create Structure Validation Script

**Given** the universal standard
**When** running validation
**Then** script must:

```bash
# Create: scripts/validate-expansion-structure.js

node scripts/validate-expansion-structure.js [pack-name]

# Checks:
1. Required directories exist (agents/, tasks/, templates/, checklists/)
2. Required files exist (config.yaml, README.md)
3. NO forbidden directories (node_modules/, docs/, etc.)
4. Count check: directories in root = required + optional only
5. Config.yaml has required fields
6. Agents/tasks referenced in config exist
```

**Output Format**:
```
✅ PASS: mmos-mind-mapper
  ✓ All required directories present
  ✓ No forbidden directories
  ✓ Config.yaml valid
  ✓ All dependencies exist

❌ FAIL: etl-data-collector
  ✗ Forbidden directory: node_modules/
  ✗ Forbidden directory: bin/
  ✗ Forbidden directory: config/
  ✗ Forbidden directory: docs/
  ✗ Forbidden directory: environments/
  Issues: 5 violations - REQUIRES MIGRATION
```

**Validation**:
- [ ] Script runs without errors
- [ ] Detects all current violations (15+ across 3 packs)
- [ ] Exit code 0 for pass, 1 for fail
- [ ] JSON output mode available (`--json`)

---

### AC3: Update Expansion Pack Checklist

**Given** the universal standard
**When** updating `.expansion-creator/checklists/expansion-pack-checklist.md`
**Then** section 8.1 (Slash Commands Structure) must include:

```markdown
## 1. Pack Structure & Configuration

### 1.1 Directory Structure

- [ ] ONLY required/optional directories present
- [ ] NO node_modules/ (use root dependencies)
- [ ] NO package.json (use root package.json)
- [ ] NO docs/ (use README.md)
- [ ] NO scripts/ (use /scripts/{pack}/ if needed)
- [ ] NO epics/ (use root /docs/epics/)
- [ ] NO testing/ (use /tests/{pack}/)
- [ ] NO database/, bin/, config/, environments/
- [ ] Structure validation passes: `node scripts/validate-expansion-structure.js {pack}`
```

**Validation**:
- [ ] Checklist updated with 8+ structural validation items
- [ ] Validation script referenced
- [ ] Clear guidance on where to move forbidden directories

---

### AC4: Migrate ETL Pack to Standard Structure

**Given** etl-data-collector with 5 violations
**When** migrating to standard
**Then** must:

**Migration Plan**:
```bash
# 1. Move dependencies to root
cat expansion-packs/etl-data-collector/package.json >> package.json
rm -rf expansion-packs/etl-data-collector/node_modules/
rm expansion-packs/etl-data-collector/package.json

# 2. Move bin/ executables
mv expansion-packs/etl-data-collector/bin/* scripts/etl/
rm -rf expansion-packs/etl-data-collector/bin/

# 3. Move config/ to config.yaml
# Merge expansion-packs/etl-data-collector/config/* into config.yaml
rm -rf expansion-packs/etl-data-collector/config/

# 4. Move docs/ to README.md
# Consolidate docs/ content into README.md
rm -rf expansion-packs/etl-data-collector/docs/

# 5. Move environments/ to root .env
mv expansion-packs/etl-data-collector/environments/.env.example .env.etl.example
rm -rf expansion-packs/etl-data-collector/environments/
```

**Validation**:
- [ ] ETL pack passes `validate-expansion-structure.js`
- [ ] All dependencies in root package.json
- [ ] Scripts in /scripts/etl/
- [ ] Config consolidated in config.yaml
- [ ] README.md complete
- [ ] No functionality broken (run ETL tests)

---

### AC5: Migrate InnerLens Pack to Standard Structure

**Given** innerlens with 5 violations
**When** migrating to standard
**Then** must:

**Migration Plan**:
```bash
# 1. Move dependencies to root
cat expansion-packs/innerlens/package.json >> package.json
rm expansion-packs/innerlens/package.json

# 2. Move docs/ to README.md
# Consolidate docs/ content
rm -rf expansion-packs/innerlens/docs/

# 3. Move epics/ to root
mv expansion-packs/innerlens/epics/* docs/epics/innerlens/
rm -rf expansion-packs/innerlens/epics/

# 4. Move scripts/ to root
mv expansion-packs/innerlens/scripts/* scripts/innerlens/
rm -rf expansion-packs/innerlens/scripts/

# 5. Move testing/ to root
mv expansion-packs/innerlens/testing/* tests/innerlens/
rm -rf expansion-packs/innerlens/testing/

# 6. Move workflows/ to tasks/ or root
# Analyze if workflows/ are tasks or system workflows
```

**Validation**:
- [ ] InnerLens passes `validate-expansion-structure.js`
- [ ] All dependencies in root package.json
- [ ] Scripts in /scripts/innerlens/
- [ ] Tests in /tests/innerlens/
- [ ] No functionality broken (run InnerLens tests)

---

### AC6: Migrate Creator-OS Pack to Standard Structure

**Given** creator-os with 4 violations
**When** migrating to standard
**Then** must:

**Migration Plan**:
```bash
# 1. Move database/ to root
mv expansion-packs/creator-os/database/* scripts/database/creator/
rm -rf expansion-packs/creator-os/database/

# 2. Move docs/ to README.md
# Consolidate PRD.md, CHANGELOG.md into README.md
rm -rf expansion-packs/creator-os/docs/

# 3. Move epics/ to root
mv expansion-packs/creator-os/epics/* docs/epics/creator-os/
rm -rf expansion-packs/creator-os/epics/

# 4. Move scripts/ to root
mv expansion-packs/creator-os/scripts/* scripts/creator-os/
rm -rf expansion-packs/creator-os/scripts/
```

**Validation**:
- [ ] Creator-OS passes `validate-expansion-structure.js`
- [ ] Scripts in /scripts/creator-os/
- [ ] README.md comprehensive (includes PRD, CHANGELOG sections)
- [ ] No functionality broken (run Creator-OS tests)

---

### AC7: Add Pre-Commit Hook Validation

**Given** standardized packs
**When** attempting to commit structural violations
**Then** pre-commit hook must:

```bash
# Create: .aios-core/hooks/pre-commit-expansion-guard.sh

#!/bin/bash
# Expansion Pack Structure Guard

for pack in expansion-packs/*/; do
  if ! node scripts/validate-expansion-structure.js "$(basename "$pack")"; then
    echo "❌ Structure violation in $(basename "$pack")"
    echo "Run: node scripts/validate-expansion-structure.js --fix"
    exit 1
  fi
done

echo "✅ All expansion packs follow standard structure"
```

**Validation**:
- [ ] Hook blocks commits with violations
- [ ] Hook runs automatically on `git commit`
- [ ] Clear error messages guide developer

---

## Success Metrics

1. **Structural Consistency**: 100% of packs (4/4) pass validation
2. **Dependency Consolidation**: Only 1 package.json at root (not 3)
3. **node_modules Reduction**: 2 fewer node_modules directories
4. **Onboarding Time**: 30% reduction (1 structure to learn, not 4)
5. **Template Creation**: Expansion pack template can be generated

---

## Technical Notes

### Current Violations Summary

| Pack | node_modules | package.json | docs/ | scripts/ | epics/ | testing/ | Other |
|------|--------------|--------------|-------|----------|--------|----------|-------|
| mmos-mind-mapper | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | lib/ ✅ |
| creator-os | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ | database/ ✅ |
| etl-data-collector | ✅ 🚨 | ❌ | ✅ | ❌ | ❌ | ❌ | bin/, config/, environments/ ✅ |
| innerlens | ❌ | ✅ 🚨 | ✅ | ✅ | ✅ | ✅ | workflows/ ✅ |

**Total Violations**: 15 across 3 packs (MMOS is clean)

### Migration Risk Assessment

| Pack | Risk | Reason |
|------|------|--------|
| creator-os | 🟢 LOW | Simple moves, no npm dependencies |
| innerlens | 🟡 MEDIUM | Has package.json, needs dependency merge |
| etl-data-collector | 🔴 HIGH | node_modules + 5 directories to migrate |

### Rollback Plan

Each migration creates git snapshot:
```bash
git add . && git commit -m "pre-migration: {pack-name}"
# Migration steps
# If fails: git reset --hard HEAD^
```

---

## Dependencies

- brownfield-architecture.md (analysis complete)
- Validation script (new)
- Pre-commit hook (new)

---

## Non-Goals (Out of Scope)

- ❌ Functional changes to packs (behavior unchanged)
- ❌ Renaming packs
- ❌ Changing config.yaml format
- ❌ Migrating data/ content

---

## Risks and Mitigations

### Risk 1: Breaking dependencies during migration
**Mitigation**: Create comprehensive tests for each pack before migration

### Risk 2: Lost functionality from moved files
**Mitigation**: Git snapshots + careful move (not delete)

### Risk 3: Merge conflicts in package.json
**Mitigation**: Manual review of dependency merges, test npm install

---

## File List

**Created**:
- `scripts/validate-expansion-structure.js`
- `.expansion-creator/docs/STRUCTURE_STANDARD.md`
- `.aios-core/hooks/pre-commit-expansion-guard.sh`
- `tests/creator-os/` (moved from expansion-packs/creator-os/testing/)
- `tests/innerlens/` (moved from expansion-packs/innerlens/testing/)
- `scripts/etl/` (moved from expansion-packs/etl-data-collector/bin/)
- `scripts/creator-os/` (moved from expansion-packs/creator-os/scripts/)
- `scripts/innerlens/` (moved from expansion-packs/innerlens/scripts/)

**Modified**:
- `package.json` (merge dependencies from etl + innerlens)
- `.expansion-creator/checklists/expansion-pack-checklist.md`
- `expansion-packs/etl-data-collector/README.md` (consolidated docs/)
- `expansion-packs/creator-os/README.md` (consolidated docs/, PRD.md, CHANGELOG.md)
- `expansion-packs/innerlens/README.md` (consolidated docs/)

**Deleted**:
- `expansion-packs/etl-data-collector/node_modules/`
- `expansion-packs/etl-data-collector/package.json`
- `expansion-packs/innerlens/package.json`
- All docs/, scripts/, epics/, testing/, bin/, config/, environments/, database/ directories in packs

---

## Story Status

**Status**: 📋 NOT STARTED
**Source**: brownfield-architecture.md Section 3.1, Problem #2
**Blocked By**: None
**Blocks**: Future expansion pack creation

---

**Priority Justification**: P0 - Architectural foundation issue blocking templates, validation, and maintainability.
