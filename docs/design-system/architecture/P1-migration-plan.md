# P1 Architecture Migration Plan

**Author**: Winston (Architect)
**Date**: 2025-10-28
**Status**: Proposed
**Version**: 1.0

---

## Overview

This document provides a **complete migration path** from current Brad implementation to P1 architecture, combining:

1. **Project Scope System** - Multi-context isolation
2. **Workflow Unification** - Brownfield + Artifacts unified

**Dependencies**: Read these first:
- `project-scope-system.md` - Project isolation design
- `workflow-unification.md` - Unified consolidate design

---

## Migration Timeline

```
Phase 0: Preparation (30 min)
├─ Review architecture docs
├─ Backup current state
└─ User approval

Phase 1: Core Infrastructure (2-3 hours)
├─ Project index system
├─ Workflow detection layer
└─ Pattern normalization

Phase 2: Command Interface (2-3 hours)
├─ Project management commands
├─ Enhanced scan/consolidate
└─ Migration tooling

Phase 3: Testing & Validation (2 hours)
├─ Unit tests
├─ Integration tests
└─ User acceptance testing

Phase 4: Documentation & Rollout (1 hour)
├─ Update Brad agent docs
├─ Create migration guide
└─ Deploy

Total: ~10-12 hours
```

---

## Pre-Migration Checklist

### User Actions Required

```bash
# 1. Backup current state
mkdir -p backups/pre-p1-$(date +%Y%m%d)

cp expansion-packs/super-agentes/scan-system/registry.yaml \
   backups/pre-p1-$(date +%Y%m%d)/registry.yaml

cp -r docs/design-system/analysis \
      backups/pre-p1-$(date +%Y%m%d)/analysis

cp -r docs/design-system/artifacts \
      backups/pre-p1-$(date +%Y%m%d)/artifacts

# 2. Document current state
*status > backups/pre-p1-$(date +%Y%m%d)/status.txt
*list-artifacts > backups/pre-p1-$(date +%Y%m%d)/artifacts.txt

# 3. Verify backups
ls -lah backups/pre-p1-$(date +%Y%m%d)/
```

### System Requirements

- [ ] Brad v2.0 or later
- [ ] At least 100K tokens free in context window
- [ ] Git working directory clean (no uncommitted changes)
- [ ] Read/write access to expansion-packs/ and docs/

---

## Phase 1: Core Infrastructure (2-3 hours)

### 1.1 Project Index System

**Create**: `expansion-packs/super-agentes/scan-system/projects/.project-index.yaml`

```yaml
# Initial state (migrated from legacy)
projects:
  curso-claude-code:
    name: "Curso Claude Code - Educational Design System"
    type: "educational"
    created_at: "2025-10-28T15:30:00Z"
    last_scan: "2025-10-28T17:30:00Z"
    artifacts_count: 5
    status: "active"

active_project: "curso-claude-code"

metadata:
  total_projects: 1
  total_artifacts: 5
  version: "1.0.0"
```

**Create**: `expansion-packs/super-agentes/scan-system/projects/curso-claude-code/`

```bash
mkdir -p expansion-packs/super-agentes/scan-system/projects/curso-claude-code
```

### 1.2 Migrate Existing Registry

**Move**: `registry.yaml` → `projects/curso-claude-code/registry.yaml`

```bash
mv expansion-packs/super-agentes/scan-system/registry.yaml \
   expansion-packs/super-agentes/scan-system/projects/curso-claude-code/registry.yaml
```

**Edit**: Add project field to registry

```yaml
# projects/curso-claude-code/registry.yaml
registry_version: "1.0.0"
project: "curso-claude-code"  # ← ADD THIS
created_at: "2025-10-28T14:00:00Z"
last_updated: "2025-10-28T17:30:00Z"

# ... rest stays same
```

### 1.3 Create Project Config

**Create**: `projects/curso-claude-code/config.yaml`

```yaml
project:
  name: "curso-claude-code"
  slug: "curso-claude-code"
  type: "educational"
  description: "Design system for Claude Code educational materials"
  created_at: "2025-10-28T15:30:00Z"
  created_by: "Alan Nicolas"

  context:
    domain: "Education/Technical Training"
    audience: "Developers learning Claude Code"
    brand_colors: ["orange", "cream", "warm-tones"]
    ui_style: "Clean, professional, educational"

  workflow:
    phase: "scan_complete"
    last_consolidation: null
    next_step: "consolidate"

  paths:
    analysis: "docs/design-system/projects/curso-claude-code/analysis"
    tokens: "docs/design-system/projects/curso-claude-code/tokens"
    components: "docs/design-system/projects/curso-claude-code/components"
    artifacts_originals: "docs/design-system/artifacts/originals/curso"
    artifacts_refactored: "docs/design-system/artifacts/refactored/curso"
```

### 1.4 Reorganize Docs Directory

**Create**: Project-specific directories

```bash
mkdir -p docs/design-system/projects/curso-claude-code/{analysis,tokens,components}
```

**Move**: Existing analysis files

```bash
mv docs/design-system/analysis/* \
   docs/design-system/projects/curso-claude-code/analysis/
```

**Update**: Paths in registry.yaml

```yaml
# projects/curso-claude-code/registry.yaml
artifacts:
  - id: "001"
    path: "docs/design-system/projects/curso-claude-code/analysis/artifact-001-*.md"  # ← Updated
    # ...
```

### 1.5 Workflow Detection Layer

**Create**: `expansion-packs/super-agentes/utils/workflow-detector.md`

```markdown
# Workflow Detector Utility

## Purpose
Detect which workflow (brownfield/artifacts) is active for current project.

## Function

```javascript
function detectWorkflowSource(project) {
  // 1. Check brownfield audit
  const statePath = `outputs/design-system/${project}/.state.yaml`;
  if (exists(statePath)) {
    return {
      type: 'brownfield',
      source: statePath,
      project: project
    };
  }

  // 2. Check project-scoped registry
  const projectRegistry = `expansion-packs/super-agentes/scan-system/projects/${project}/registry.yaml`;
  if (exists(projectRegistry)) {
    return {
      type: 'artifacts',
      source: projectRegistry,
      project: project
    };
  }

  // 3. Check legacy registry (backward compat)
  const legacyRegistry = `expansion-packs/super-agentes/scan-system/registry.yaml`;
  if (exists(legacyRegistry)) {
    return {
      type: 'artifacts-legacy',
      source: legacyRegistry,
      project: 'default',
      warning: 'Using legacy registry. Consider migrating to project system.'
    };
  }

  // 4. Not found
  return {
    type: 'none',
    error: 'No scan data found. Run *audit {path} or *scan {html} first.'
  };
}
```

## Usage

```markdown
# In consolidate-patterns.md:

Step 1: Detect source
const source = detectWorkflowSource(current_project);

if (source.type === 'none') {
  error(source.error);
  exit();
}

if (source.warning) {
  warn(source.warning);
}

log(`Workflow: ${source.type}`);
log(`Source: ${source.source}`);

Step 2: Load patterns based on source.type
# ...
```
```

### 1.6 Update consolidate-patterns.md

**Edit**: `expansion-packs/super-agentes/tasks/consolidate-patterns.md`

**Add** detection step at beginning:

```markdown
# Consolidate Patterns

## Prerequisites
- Project must have:
  - Brownfield audit (*audit {path}), OR
  - Artifact scans (*scan {html}, 1+ artifacts)

## Workflow

### Step 1: Detect Workflow Source

```javascript
// Load detector utility
const detector = load("expansion-packs/super-agentes/utils/workflow-detector.md");
const source = detector.detectWorkflowSource(current_project);

if (source.type === 'none') {
  error(source.error);
  exit();
}

log(`✓ Detected ${source.type} workflow`);
log(`  Source: ${source.source}`);
```

### Step 2: Load Patterns

```javascript
let patterns;

if (source.type === 'brownfield') {
  patterns = loadBrownfieldPatterns(source.source);
} else if (source.type.startsWith('artifacts')) {
  patterns = loadArtifactPatterns(source.source);
}

log(`✓ Loaded ${patterns.colors.length} colors`);
```

### Step 3: Normalize Format

[... existing clustering logic ...]
```

---

## Phase 2: Command Interface (2-3 hours)

### 2.1 Project Management Commands

**Create**: `expansion-packs/super-agentes/tasks/project-manager.md`

```markdown
# Project Manager Task

## Commands

### *new-project {name} --type={type}

Create new isolated project for design system work.

**Types**: educational, admin, marketing, general

**Steps**:
1. Validate name (slug-safe: a-z0-9-)
2. Create directories:
   - projects/{name}/
   - docs/design-system/projects/{name}/{analysis,tokens,components}
   - docs/design-system/artifacts/originals/{name}/
3. Create config.yaml
4. Create empty registry.yaml
5. Update .project-index.yaml
6. Set as active project

### *list-projects

Show all projects with stats.

### *use-project {name}

Switch active project context.

### *project-info

Show current project details.

[... full implementation ...]
```

### 2.2 Update Brad Agent Definition

**Edit**: `expansion-packs/super-agentes/agents/design-system.md`

**Add** to commands section:

```yaml
commands:
  # ... existing commands ...

  # Project management commands (NEW)
  new-project: "Create isolated design system project - Usage: *new-project {name} --type={type}"
  list-projects: "Show all projects with stats"
  use-project: "Switch active project context - Usage: *use-project {name}"
  project-info: "Show current project configuration"
  delete-project: "Delete project (with confirmation) - Usage: *delete-project {name}"
```

**Add** to dependencies:

```yaml
dependencies:
  tasks:
    - # ... existing ...
    - project-manager.md  # NEW

  utils:
    - workflow-detector.md  # NEW
```

---

## Phase 3: Testing & Validation (2 hours)

### 3.1 Unit Tests

**Create**: `expansion-packs/super-agentes/tests/test-p1-migration.md`

```markdown
# P1 Migration Tests

## Test: Project Index Creation

Given: Fresh system (no projects/)
When: Create .project-index.yaml
Then: Index exists with version 1.0.0

## Test: Legacy Migration

Given: registry.yaml with 5 artifacts
When: Run migration
Then:
  - projects/default/ created
  - registry moved to projects/default/
  - .project-index shows 1 project, 5 artifacts

## Test: Workflow Detection (Brownfield)

Given: outputs/design-system/my-app/.state.yaml exists
When: detectWorkflowSource("my-app")
Then: type = "brownfield", source = .state.yaml

## Test: Workflow Detection (Artifacts)

Given: projects/curso-claude-code/registry.yaml exists
When: detectWorkflowSource("curso-claude-code")
Then: type = "artifacts", source = projects/.../registry.yaml

## Test: Workflow Detection (None)

Given: No .state.yaml or registry.yaml
When: detectWorkflowSource("new-project")
Then: type = "none", error message shown

[... all tests ...]
```

### 3.2 Integration Test

**Manual test workflow**:

```bash
# 1. Fresh start (new tab/session)
/clear
/SA:agents:design-system

# 2. Verify migration worked
*list-projects
# Expected: curso-claude-code (5 artifacts)

# 3. Verify existing workflow works
*consolidate
# Expected: Auto-detects artifacts, processes 5

# 4. Create new project
*new-project dashboard-admin --type=admin
# Expected: Project created, switched to active

# 5. Scan to new project
*scan {dashboard-html}
# Expected: Artifact 001 added to dashboard-admin

# 6. Switch back to curso
*use-project curso-claude-code

# 7. Verify isolation
*consolidate
# Expected: Still processes only curso's 5 artifacts

# 8. Tokenize curso
*tokenize
# Expected: tokens.yaml in projects/curso-claude-code/tokens/
```

---

## Phase 4: Documentation & Rollout (1 hour)

### 4.1 Update Brad Docs

**Create**: `docs/design-system/guides/project-system.md`

```markdown
# Design System Project System Guide

## Overview

Projects provide isolation for different design contexts...

## When to Use Projects

- Multiple design systems (course + dashboard)
- A/B testing design variations
- Client-specific customizations
- Brand variations

## Quick Start

[... user guide ...]
```

### 4.2 Create Migration Guide

**Create**: `docs/design-system/migration/to-p1-projects.md`

```markdown
# Migrating to P1 Project System

## For Existing Users

If you have artifacts from **before** P1:

1. Your data automatically migrated to "curso-claude-code" project
2. All commands work exactly as before
3. New capability: Create additional projects with *new-project

## Creating New Projects

[... step by step ...]
```

### 4.3 Update Agent README

**Edit**: `expansion-packs/super-agentes/agents/README.md`

Add P1 features section.

---

## Rollback Plan

If migration fails or issues found:

### Step 1: Stop Using P1

```bash
# Switch back to legacy mode
rm -rf expansion-packs/super-agentes/scan-system/projects/
```

### Step 2: Restore Backups

```bash
# Restore registry
cp backups/pre-p1-YYYYMMDD/registry.yaml \
   expansion-packs/super-agentes/scan-system/

# Restore analysis
rm -rf docs/design-system/analysis
cp -r backups/pre-p1-YYYYMMDD/analysis \
      docs/design-system/
```

### Step 3: Verify

```bash
/clear
/SA:agents:design-system
*status
# Should show legacy workflow
```

---

## Success Criteria

- [ ] All 5 existing artifacts accessible after migration
- [ ] *consolidate works without changes
- [ ] *tokenize works without changes
- [ ] Can create new project and scan to it
- [ ] Projects are fully isolated (no cross-contamination)
- [ ] Legacy workflow still works (backward compatible)
- [ ] Documentation complete and accurate
- [ ] Zero breaking changes for existing users

---

## Post-Migration Validation

### Checklist

```bash
# 1. Verify project structure
ls -lah expansion-packs/super-agentes/scan-system/projects/
# Expected: .project-index.yaml + curso-claude-code/

# 2. Verify docs structure
ls -lah docs/design-system/projects/
# Expected: curso-claude-code/{analysis,tokens,components}

# 3. Verify artifact count
*project-info
# Expected: 5 artifacts in curso-claude-code

# 4. Run full workflow
*consolidate
*tokenize
# Expected: Both work without errors

# 5. Create test project
*new-project test-migration --type=general
*use-project test-migration
*scan {test-html}
# Expected: Artifact added to test-migration, isolated from curso

# 6. Cleanup test
*delete-project test-migration
# Expected: Project deleted cleanly
```

---

## Risk Assessment

### Low Risk
- ✅ Data migration (files just move, not modified)
- ✅ Backward compatibility (legacy mode supported)
- ✅ Rollback (backups + simple restore)

### Medium Risk
- ⚠️ Path updates (registry paths need updating)
- ⚠️ Detection logic (new code, needs testing)

### High Risk
- 🚨 None identified

**Overall Risk**: **LOW** (well-architected, reversible, tested)

---

## Timeline Estimate

```
Preparation:       30 min
Phase 1:           3 hours
Phase 2:           3 hours
Phase 3:           2 hours
Phase 4:           1 hour
Buffer (issues):   1.5 hours
─────────────────────────
Total:            ~11 hours

Recommended schedule:
- Day 1 (4 hours): Phase 0 + Phase 1
- Day 2 (4 hours): Phase 2
- Day 3 (3 hours): Phase 3 + Phase 4
```

---

## Next Actions

1. **Alan**: Review architecture docs + migration plan
2. **Alan**: Approve P1 implementation OR request changes
3. **Winston/Brad**: Implement Phase 1 (core infrastructure)
4. **Alan**: Test Phase 1 (verify migration worked)
5. **Winston/Brad**: Implement Phase 2 (commands)
6. **Alan**: Full integration test
7. **Winston**: Documentation
8. **Alan**: Production rollout

---

**Status**: Awaiting approval to begin Phase 1
**Estimated Start**: Upon approval
**Estimated Completion**: 3-4 days at 3-4 hours/day
