# Project Scope System - Architecture Design

**Author**: Winston (Architect)
**Date**: 2025-10-28
**Status**: Proposed
**Version**: 1.0
**AIOS Priority**: P1 (Critical)

---

## Executive Summary

### Problem Statement

Current design system workflow lacks project isolation, causing:

1. **Context Pollution**: Scanning 5 course artifacts + 8 dashboard artifacts → 13 mixed in single registry
2. **Token Waste**: Can't consolidate by project → must process all 13 together
3. **Maintenance Nightmare**: Course colors bleeding into dashboard design system
4. **No Incremental Updates**: Adding 10 new course artifacts → reprocess all 15

### Solution

**Project Scope System**: Isolated namespaces for design contexts with independent workflows, registries, and token systems.

### Business Value

```
Before P1:
- Time to add 10 artifacts to existing 5: ~2 hours (reprocess all 15)
- Risk of context mixing: HIGH
- Token cost: ~75K (full reprocessing)

After P1:
- Time to add 10 artifacts: ~30 min (incremental only)
- Risk of context mixing: ZERO (isolated)
- Token cost: ~25K (incremental only)

ROI: 4x faster, 67% token reduction, zero risk
```

---

## System Architecture

### High-Level Design

```
expansion-packs/super-agentes/scan-system/
├── projects/                           # ← NEW: Per-project registries
│   ├── curso-claude-code/
│   │   ├── registry.yaml
│   │   ├── .state.yaml
│   │   └── config.yaml
│   │
│   ├── dashboard-admin/
│   │   ├── registry.yaml
│   │   ├── .state.yaml
│   │   └── config.yaml
│   │
│   └── .project-index.yaml            # ← Global project catalog
│
├── registry.yaml                       # ← LEGACY: Migrate to default project
└── project-manager.md                  # ← NEW: Project management task

docs/design-system/
├── projects/                           # ← NEW: Per-project outputs
│   ├── curso-claude-code/
│   │   ├── analysis/
│   │   │   ├── artifact-001-*.md
│   │   │   └── ...
│   │   ├── tokens/
│   │   │   ├── tokens.yaml
│   │   │   └── exports/
│   │   ├── components/
│   │   └── consolidation-report.md
│   │
│   └── dashboard-admin/
│       ├── analysis/
│       ├── tokens/
│       └── ...
│
└── artifacts/                          # ← Shared artifact storage
    ├── originals/
    │   ├── curso/
    │   │   ├── 001-*.html
    │   │   └── ...
    │   └── dashboard/
    │       ├── 006-*.html
    │       └── ...
    └── refactored/
        ├── curso/
        └── dashboard/
```

### Data Model

#### .project-index.yaml

```yaml
# Global project catalog
projects:
  curso-claude-code:
    name: "Curso Claude Code - Educational Design System"
    type: "educational"
    created_at: "2025-10-28T15:30:00Z"
    last_scan: "2025-10-28T17:30:00Z"
    artifacts_count: 5
    status: "active"

  dashboard-admin:
    name: "Dashboard Admin - Data-Driven Design System"
    type: "admin-panel"
    created_at: "2025-10-29T10:00:00Z"
    last_scan: null
    artifacts_count: 0
    status: "initialized"

active_project: "curso-claude-code"  # Current context

metadata:
  total_projects: 2
  total_artifacts: 5
  version: "1.0.0"
```

#### projects/{name}/config.yaml

```yaml
# Project-specific configuration
project:
  name: "curso-claude-code"
  slug: "curso-claude-code"
  type: "educational"
  description: "Design system for Claude Code educational materials"

  created_at: "2025-10-28T15:30:00Z"
  created_by: "Alan Nicolas"

  # Design context
  context:
    domain: "Education/Technical Training"
    audience: "Developers learning Claude Code"
    brand_colors: ["orange", "cream", "warm-tones"]
    ui_style: "Clean, professional, educational"

  # Workflow state
  workflow:
    phase: "consolidate_complete"
    last_consolidation: "2025-10-28T18:00:00Z"
    next_step: "tokenize"

  # Paths
  paths:
    analysis: "docs/design-system/projects/curso-claude-code/analysis"
    tokens: "docs/design-system/projects/curso-claude-code/tokens"
    components: "docs/design-system/projects/curso-claude-code/components"
    artifacts_originals: "docs/design-system/artifacts/originals/curso"
    artifacts_refactored: "docs/design-system/artifacts/refactored/curso"

  # Integration
  integration:
    expansion_packs: ["creator-os"]
    linked_projects: []
```

#### projects/{name}/registry.yaml

```yaml
# Per-project artifact registry (same structure as current registry.yaml)
registry_version: "1.0.0"
project: "curso-claude-code"
created_at: "2025-10-28T15:30:00Z"
last_updated: "2025-10-28T17:30:00Z"

artifacts:
  - id: "001"
    path: "docs/design-system/projects/curso-claude-code/analysis/artifact-001-*.md"
    original_path: "docs/design-system/artifacts/originals/curso/001-*.html"
    created_at: "2025-10-28T15:53:34-03:00"
    grade: "A-"
    coverage: 95

  - id: "002"
    path: "docs/design-system/projects/curso-claude-code/analysis/artifact-002-*.md"
    created_at: "2025-10-28T15:55:58-03:00"
    grade: "C"
    coverage: 0

  # ... artifacts 003-005

statistics:
  total_artifacts: 5
  average_coverage: 30
  total_colors_found: 270
  total_inline_declarations: 270
```

---

## Command Interface

### New Commands

#### Project Management

```bash
# Create new project
*new-project {name} --type={educational|admin|marketing|general}

# List all projects
*list-projects

# Switch active project
*use-project {name}

# Show current project info
*project-info

# Delete project (with confirmation)
*delete-project {name}
```

#### Enhanced Existing Commands

```bash
# Scan with project context (auto-uses active project)
*scan {html}

# Scan to specific project (override active)
*scan {html} --project={name}

# Consolidate current project
*consolidate

# Consolidate specific project
*consolidate --project={name}

# Consolidate all projects (with warning)
*consolidate --all-projects

# Tokenize current project
*tokenize

# Tokenize specific project
*tokenize --project={name}
```

### Command Examples

#### Scenario 1: Starting Fresh

```bash
User: /SA:agents:design-system

Brad: 🎨 I'm Brad, your Design System Architect...

User: *new-project curso-claude-code --type=educational

Brad: Created project "curso-claude-code"
      Type: Educational
      Location: expansion-packs/super-agentes/scan-system/projects/curso-claude-code/

      Active project set to: curso-claude-code

      Ready to scan artifacts. Use:
      *scan {path|url}  # Automatically goes to curso-claude-code

User: *scan {artifact-001-html}

Brad: Scanning artifact for project: curso-claude-code
      Saved to: docs/design-system/projects/curso-claude-code/analysis/
      Artifact 001 added to project registry

      Grade: A- (95% token coverage)

User: *scan {artifact-002-html}
User: *scan {artifact-003-html}
User: *scan {artifact-004-html}
User: *scan {artifact-005-html}

Brad: 5 artifacts scanned for project: curso-claude-code
      Ready to consolidate: *consolidate

User: *consolidate

Brad: Consolidating project: curso-claude-code (5 artifacts)

      Found:
      - 270+ color declarations
      - 15 unique colors
      - Reduction: 85%

      Consolidation complete!
      Next: *tokenize
```

#### Scenario 2: Multiple Projects

```bash
User: *list-projects

Brad: Projects (2 total):

      1. curso-claude-code (ACTIVE)
         Type: Educational
         Artifacts: 5
         Status: consolidate_complete
         Last update: 2025-10-28

      2. dashboard-admin
         Type: Admin Panel
         Artifacts: 0
         Status: initialized
         Last update: Never

User: *new-project dashboard-admin --type=admin

Brad: Created project "dashboard-admin"
      Active project set to: dashboard-admin

User: *scan {dashboard-table-html}

Brad: Scanning artifact for project: dashboard-admin
      Artifact 001 added to dashboard-admin registry

      Detected design patterns:
      - Dark theme (different from curso-claude-code warm theme)
      - Data table components (new)
      - Admin-specific colors (blue/gray cold tones)

      ✓ Project isolation working - no mixing with curso-claude-code

User: *use-project curso-claude-code

Brad: Active project: curso-claude-code
      5 artifacts, consolidate_complete

User: *tokenize

Brad: Tokenizing project: curso-claude-code
      [Only processes curso artifacts, ignores dashboard]
```

---

## Implementation Details

### Phase 1: Data Migration

**Migrate current registry.yaml to default project**:

```yaml
# Create: expansion-packs/super-agentes/scan-system/projects/default/.project.yaml
project:
  name: "default"
  slug: "default"
  type: "general"
  description: "Migrated from legacy registry.yaml"

# Move artifacts 001-005 to default project
```

### Phase 2: Core Infrastructure

**Files to create**:

1. `expansion-packs/super-agentes/scan-system/projects/.project-index.yaml`
2. `expansion-packs/super-agentes/scan-system/project-manager.md` (task)
3. `expansion-packs/super-agentes/templates/project-config-tmpl.yaml`
4. `expansion-packs/super-agentes/utils/project-resolver.md` (helper)

**Files to modify**:

1. `expansion-packs/super-agentes/agents/design-system.md` (add project commands)
2. `expansion-packs/super-agentes/tasks/ds-scan-artifact.md` (project-aware)
3. `expansion-packs/super-agentes/tasks/consolidate-patterns.md` (project-aware)
4. `expansion-packs/super-agentes/tasks/extract-tokens.md` (project-aware)

### Phase 3: Backward Compatibility

**Support legacy workflow**:

```javascript
// If no projects/ directory exists:
if (!exists("projects/.project-index.yaml")) {
  // Use legacy registry.yaml directly
  mode = "legacy"
  registry = "registry.yaml"
} else {
  // Use project system
  mode = "projects"
  project = get_active_project()
  registry = `projects/${project}/registry.yaml`
}
```

---

## Workflow Scenarios

### Scenario A: Incremental Scanning

```
Initial state: curso-claude-code has 5 artifacts

User scans 10 new artifacts:
*scan {006-html}
*scan {007-html}
...
*scan {015-html}

Registry updates:
- curso-claude-code/registry.yaml: artifacts 001-015

Consolidate:
*consolidate --new-only

Process: Only artifacts 006-015
Time: ~30 min (vs 2 hours full reprocess)
Tokens: ~25K (vs ~75K full reprocess)
```

### Scenario B: Cross-Project Analysis

```
User has:
- curso-claude-code: 5 artifacts
- dashboard-admin: 8 artifacts

User wants:
*consolidate --all-projects

Brad warns:
⚠️  Warning: Consolidating across 2 projects

    curso-claude-code: 5 artifacts (educational, warm)
    dashboard-admin: 8 artifacts (admin, cold)

    This will mix design contexts and may produce unusable tokens.

    Recommended: Consolidate per-project

    Proceed anyway? (y/n)

User: n

Brad: Canceled. Use:
      *use-project curso-claude-code && *consolidate
      *use-project dashboard-admin && *consolidate
```

### Scenario C: Project Cleanup

```
User: *delete-project old-prototype

Brad: ⚠️  Delete project "old-prototype"?

      This will:
      - Delete registry and config
      - Move artifacts to archive/
      - Keep analysis files (read-only)

      Type project name to confirm: _

User: old-prototype

Brad: Project "old-prototype" deleted
      - Registry archived to: projects/.archive/old-prototype/
      - Analysis preserved at: docs/design-system/projects/old-prototype/ (read-only)
```

---

## Security & Data Integrity

### Project Isolation

```yaml
security:
  project_boundaries:
    - "Projects cannot read each other's registries"
    - "Artifact IDs scoped to project (001 in curso ≠ 001 in dashboard)"
    - "Token files isolated per-project"

  validation:
    - "Project name must be slug-safe (a-z0-9-)"
    - "Cannot create project with existing name"
    - "Cannot delete active project without switch"
```

### Data Migration Safety

```yaml
migration:
  backup:
    - "Create backup of registry.yaml before migration"
    - "Store at: expansion-packs/super-agentes/scan-system/.backup-{timestamp}/"

  rollback:
    - "Keep legacy registry.yaml until user confirms migration success"
    - "Provide *rollback-migration command"
```

---

## Performance Considerations

### Token Optimization

```
Current (no projects):
- Scan 5 curso artifacts: 5 * 8K = 40K tokens
- Add 10 curso artifacts: 15 * 8K = 120K tokens (full reprocess)
- Total: 160K tokens

With projects:
- Scan 5 curso artifacts: 5 * 8K = 40K tokens
- Add 10 curso artifacts: 10 * 8K = 80K tokens (incremental only)
- Total: 120K tokens
- Savings: 25%

Plus:
- No context pollution
- Faster consolidation (fewer artifacts per run)
- Parallel processing possible (consolidate curso + dashboard simultaneously)
```

### Storage

```
Additional storage per project:
- config.yaml: ~2KB
- registry.yaml: ~5KB + (500 bytes * artifacts_count)
- .state.yaml: ~3KB

For 10 projects with avg 8 artifacts each:
Total overhead: ~10 * (2KB + 5KB + 3KB + 4KB) = 140KB

Negligible impact.
```

---

## Testing Strategy

### Unit Tests

```yaml
test_project_creation:
  - Create project with valid name
  - Create project with invalid name (should fail)
  - Create duplicate project (should fail)

test_project_switching:
  - Switch to existing project
  - Switch to non-existent project (should fail)
  - Verify active_project updates

test_artifact_isolation:
  - Scan to project A
  - Scan to project B
  - Verify artifact 001 in A ≠ artifact 001 in B
```

### Integration Tests

```yaml
test_full_workflow:
  - Create project "test-curso"
  - Scan 3 artifacts
  - Consolidate
  - Tokenize
  - Verify outputs in correct paths
  - Cleanup project

test_migration:
  - Start with legacy registry.yaml (5 artifacts)
  - Run migration
  - Verify default project created
  - Verify all 5 artifacts migrated
  - Verify legacy backup exists
```

---

## Migration Plan

### Step 1: Pre-Migration (User Action)

```bash
# Backup current state
cp expansion-packs/super-agentes/scan-system/registry.yaml \
   expansion-packs/super-agentes/scan-system/registry.yaml.backup

cp -r docs/design-system/analysis \
      docs/design-system/analysis.backup
```

### Step 2: System Migration (Automated)

```bash
# Run migration command
*migrate-to-projects

Brad executes:
1. Create projects/.project-index.yaml
2. Create projects/curso-claude-code/
3. Move current registry.yaml → projects/curso-claude-code/registry.yaml
4. Move docs/design-system/analysis → docs/design-system/projects/curso-claude-code/analysis
5. Create default config.yaml
6. Set active_project = "curso-claude-code"
7. Success message + verification instructions
```

### Step 3: Verification (User Action)

```bash
*list-projects
# Should show: curso-claude-code (5 artifacts)

*project-info
# Should show config details

*consolidate
# Should work exactly as before (backward compatible)
```

### Step 4: Rollback (if needed)

```bash
*rollback-migration

Brad executes:
1. Restore registry.yaml from backup
2. Restore docs/design-system/analysis from backup
3. Delete projects/ directory
4. Success message
```

---

## Open Questions

1. **Multi-tenant tokens**: Should there be a way to share tokens across projects?
   - Proposal: `*link-tokens {source_project} {target_project}`

2. **Project templates**: Pre-configured project types?
   - Proposal: `*new-project {name} --template=educational-course`

3. **Cross-project search**: Search artifacts across all projects?
   - Proposal: `*search-artifacts {query} --all-projects`

4. **Export/Import**: Share projects between teams?
   - Proposal: `*export-project {name}` → ZIP file

---

## Success Metrics

```yaml
metrics:
  adoption:
    target: "90% of new scans use project system within 2 weeks"
    measure: "Count *scan --project usage vs *scan without project"

  performance:
    target: "50% reduction in consolidation time for incremental scans"
    measure: "Time to *consolidate --new-only vs full consolidate"

  quality:
    target: "Zero context pollution incidents"
    measure: "Number of reports of mixed design contexts"

  usability:
    target: "User can create + use project without documentation in <5 min"
    measure: "User testing sessions"
```

---

## Next Steps

1. **Review & Approval**: Alan reviews architecture, proposes changes
2. **Implementation Priority**:
   - P0: Core infrastructure (project-index, config, registry)
   - P1: Command interface (*new-project, *use-project, etc)
   - P2: Migration tooling (*migrate-to-projects)
   - P3: Advanced features (linking, templates, export)
3. **Documentation**: Update Brad agent docs with project system
4. **Testing**: Write test suite before implementation

---

**Status**: Awaiting review & approval
**Estimated Implementation**: 4-6 hours (P0+P1)
**Estimated Testing**: 2 hours
**Total**: ~8 hours for production-ready P1
