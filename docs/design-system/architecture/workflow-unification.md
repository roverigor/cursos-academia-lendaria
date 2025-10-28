# Workflow Unification - Architecture Design

**Author**: Winston (Architect)
**Date**: 2025-10-28
**Status**: Proposed
**Version**: 1.0
**AIOS Priority**: P1 (Critical)

---

## Executive Summary

### Problem Statement

Brad has **two incompatible workflows** that don't talk to each other:

**Workflow 1: Brownfield Audit** (codebase scanning)
```
*audit {path} → Scans REAL codebase
  ↓ Saves: outputs/design-system/{project}/.state.yaml
*consolidate → Reads .state.yaml, processes
```

**Workflow 2: Artifact Analysis** (individual artifacts)
```
*scan {html} → Scans INDIVIDUAL artifact
  ↓ Saves: docs/design-system/analysis/*.md + registry.yaml
*consolidate → ❌ BROKEN (expects .state.yaml, not registry.yaml)
```

**User Impact**:
- Ran *scan 5x → built registry.yaml
- Tried *consolidate → "No audit found" error
- Had to open new tab, start over

### Solution

**Workflow Unification**: Single `*consolidate` command auto-detects input source (brownfield `.state.yaml` OR artifacts `registry.yaml`) and processes accordingly.

### Business Value

```
Before Unification:
- User confusion: "Which workflow am I in?"
- Wasted time: Re-learning commands per workflow
- Error rate: High (wrong command for wrong context)

After Unification:
- Single mental model: "scan/audit → consolidate → tokenize"
- Zero confusion: Commands work regardless of source
- Error rate: Near zero (auto-detection)

ROI: 10x faster onboarding, zero workflow errors
```

---

## System Architecture

### Unified Workflow Model

```
INPUT SOURCES (2 types):
┌────────────────────────────┐  ┌────────────────────────────┐
│  Brownfield (Codebase)     │  │  Artifact Analysis         │
│                            │  │                            │
│  *audit ./src              │  │  *scan {html}              │
│     ↓                      │  │     ↓                      │
│  .state.yaml               │  │  registry.yaml + .md files │
└────────────────────────────┘  └────────────────────────────┘
                ↓                            ↓
                └────────────────┬───────────┘
                                 ↓
                     ┌───────────────────────┐
                     │  UNIFIED CONSOLIDATE  │
                     │  (Auto-detection)     │
                     └───────────────────────┘
                                 ↓
                ┌────────────────┴────────────────┐
                ↓                                 ↓
    ┌──────────────────────┐        ┌──────────────────────┐
    │ Brownfield Processor │        │ Artifact Processor   │
    │ (reads .state.yaml)  │        │ (reads registry.yaml)│
    └──────────────────────┘        └──────────────────────┘
                ↓                                 ↓
                └────────────────┬────────────────┘
                                 ↓
                     ┌───────────────────────┐
                     │ consolidation-report  │
                     │ (unified output)      │
                     └───────────────────────┘
```

### Detection Algorithm

```javascript
function detectWorkflowSource(project) {
  // Priority 1: Check for brownfield audit
  const statePath = `outputs/design-system/${project}/.state.yaml`;
  if (exists(statePath)) {
    return {
      type: 'brownfield',
      source: statePath,
      processor: 'BrownfieldConsolidator'
    };
  }

  // Priority 2: Check for artifact registry (project-aware)
  const registryPath = `expansion-packs/super-agentes/scan-system/projects/${project}/registry.yaml`;
  if (exists(registryPath)) {
    return {
      type: 'artifacts',
      source: registryPath,
      processor: 'ArtifactConsolidator'
    };
  }

  // Priority 3: Check legacy registry (backward compat)
  const legacyPath = `expansion-packs/super-agentes/scan-system/registry.yaml`;
  if (exists(legacyPath)) {
    return {
      type: 'artifacts-legacy',
      source: legacyPath,
      processor: 'ArtifactConsolidator'
    };
  }

  // No source found
  return {
    type: 'none',
    error: 'No audit or scan data found. Run *audit {path} or *scan {html} first.'
  };
}
```

---

## Unified Data Model

### Common Consolidation Input

Both workflows produce a **normalized intermediate format**:

```yaml
# consolidation-input.yaml (generated internally)
source_type: "brownfield" | "artifacts"
project: "curso-claude-code"

patterns:
  colors:
    - value: "#CC785C"
      usages: 12
      locations: ["Button.tsx:45", "Card.tsx:23", ...]
      context: "accent-primary"

    - value: "#191919"
      usages: 35
      locations: [...]
      context: "background-dark"

    # ... all colors

  spacing:
    - value: "1rem"
      usages: 47
      locations: [...]
      context: "base-spacing"

  typography:
    - value: "Georgia, serif"
      usages: 8
      locations: [...]
      context: "heading-font"

  gradients:
    - value: "linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)"
      usages: 4
      locations: [...]

metadata:
  total_files: 47 | 5  # Depends on source
  total_patterns: 270
  scan_date: "2025-10-28T18:00:00Z"
```

### Consolidation Output (Unified)

Both produce **identical output format**:

```yaml
# consolidation-report.yaml
project: "curso-claude-code"
source_type: "artifacts"
consolidated_at: "2025-10-28T18:30:00Z"

before:
  total_colors: 270
  total_spacing: 89
  total_typography: 34
  total_patterns: 393

after:
  color_tokens: 15
  spacing_tokens: 7
  typography_tokens: 8
  total_tokens: 30

reduction:
  colors: 93.6%
  spacing: 92.1%
  typography: 76.5%
  overall: 92.4%

mapping:
  colors:
    "#CC785C":
      token: "accent-primary"
      usages: 12
      replaced_in: [...]

    "#191919":
      token: "bg-primary"
      usages: 35
      replaced_in: [...]

  # ... all mappings

recommendations:
  - "Create Tailwind config with 15 color tokens"
  - "Migrate 270 inline styles → token classes"
  - "Estimated effort: 12 hours"
```

---

## Implementation

### Unified Consolidate Task

**File**: `expansion-packs/super-agentes/tasks/consolidate-patterns.md`

```markdown
# Consolidate Patterns

## Objective
Reduce design pattern redundancy using intelligent clustering, regardless of input source (brownfield audit or artifact analysis).

## Prerequisites
- Project must have completed either:
  - *audit {path} (brownfield workflow), OR
  - *scan {html} (artifact workflow, 1+ artifacts)

## Workflow

### Step 1: Detect Source

```javascript
const source = detectWorkflowSource(current_project);

if (source.type === 'none') {
  error(source.error);
  exit();
}

log(`Detected workflow: ${source.type}`);
log(`Source: ${source.source}`);
```

### Step 2: Load Patterns (Source-Specific)

**If brownfield**:

```javascript
function loadBrownfieldPatterns(statePath) {
  const state = readYAML(statePath);

  return {
    colors: state.inventory.colors.map(c => ({
      value: c.hex,
      usages: c.count,
      locations: c.files,
      context: inferContext(c)
    })),
    spacing: state.inventory.spacing.map(...),
    typography: state.inventory.typography.map(...),
    // ...
  };
}
```

**If artifacts**:

```javascript
function loadArtifactPatterns(registryPath) {
  const registry = readYAML(registryPath);
  const patterns = { colors: [], spacing: [], typography: [] };

  for (const artifact of registry.artifacts) {
    const analysis = readMarkdown(artifact.path);

    // Parse color system section
    const colors = extractColorsFromAnalysis(analysis);
    patterns.colors.push(...colors);

    // Parse spacing section
    const spacing = extractSpacingFromAnalysis(analysis);
    patterns.spacing.push(...spacing);

    // ... etc
  }

  return patterns;
}
```

### Step 3: Normalize to Common Format

```javascript
const patterns = source.type === 'brownfield'
  ? loadBrownfieldPatterns(source.source)
  : loadArtifactPatterns(source.source);

// Both produce same structure → rest of workflow identical
```

### Step 4: Clustering (Unified)

```javascript
// Works identically for both sources
function clusterColors(colors, threshold = 0.05) {
  // HSL-based clustering
  const clusters = [];

  for (const color of colors) {
    const hsl = hexToHSL(color.value);
    const existing = clusters.find(c => hslDistance(c.hsl, hsl) < threshold);

    if (existing) {
      existing.variations.push(color);
      existing.total_usages += color.usages;
    } else {
      clusters.push({
        hsl,
        primary: color.value,
        variations: [color],
        total_usages: color.usages
      });
    }
  }

  return clusters;
}
```

### Step 5: Generate Tokens (Unified)

```javascript
function generateTokens(clusters) {
  return clusters.map((cluster, i) => ({
    name: `color-${inferSemanticName(cluster)}`,
    value: cluster.primary,
    alternatives: cluster.variations.map(v => v.value),
    total_usages: cluster.total_usages
  }));
}
```

### Step 6: Output (Unified)

```javascript
const report = {
  project: current_project,
  source_type: source.type,
  before: calculateBefore(patterns),
  after: { color_tokens: tokens.length, ... },
  reduction: calculateReduction(before, after),
  mapping: generateMapping(patterns, tokens),
  recommendations: generateRecommendations(tokens)
};

writeYAML(`docs/design-system/projects/${project}/consolidation-report.yaml`, report);
writeMarkdown(`docs/design-system/projects/${project}/consolidation-report.md`, renderReport(report));
```

## Success Criteria

- [ ] *consolidate works with brownfield .state.yaml
- [ ] *consolidate works with artifact registry.yaml
- [ ] Output format identical for both sources
- [ ] Auto-detection never fails (clear error messages)
- [ ] Backward compatible with legacy registry.yaml
```

---

## Command Interface

### Unified Commands (No Changes)

```bash
# User doesn't need to know which workflow they're in!

*consolidate                    # Auto-detects source
*consolidate --project={name}   # Auto-detects for specific project
*consolidate --all-projects     # Auto-detects for each project
```

### Internal Detection (Transparent)

```bash
User: *consolidate

Brad (internal):
  1. detectWorkflowSource("curso-claude-code")
  2. Found: registry.yaml (artifacts mode)
  3. Load patterns from 5 artifact analysis files
  4. Cluster & generate tokens
  5. Output consolidation-report.yaml

User sees:
  "Consolidating curso-claude-code (5 artifacts)"
  [... progress ...]
  "✓ Consolidation complete"
```

---

## Backward Compatibility

### Legacy Support Matrix

| Scenario | Current State | Unification Behavior |
|----------|---------------|----------------------|
| Old registry.yaml (no projects) | registry.yaml at root | Detects legacy, auto-migrates to default project |
| New project with artifacts | projects/{name}/registry.yaml | Detects project registry, processes |
| Brownfield audit | outputs/design-system/{name}/.state.yaml | Detects brownfield, processes |
| No data | Nothing | Clear error: "Run *audit or *scan first" |

### Migration Path

```bash
# Old workflow (before unification)
*scan {html}         # Creates registry.yaml
*consolidate         # ERROR: "No audit found"

# New workflow (after unification)
*scan {html}         # Creates registry.yaml
*consolidate         # ✓ Auto-detects registry, processes artifacts
```

---

## Data Flow Diagrams

### Brownfield Flow

```
User: *audit ./src
         ↓
    Scan codebase (47 files)
         ↓
    outputs/design-system/my-app/.state.yaml
         ↓
User: *consolidate
         ↓
    detectWorkflowSource() → "brownfield"
         ↓
    loadBrownfieldPatterns(.state.yaml)
         ↓
    Normalize to common format
         ↓
    Cluster patterns
         ↓
    Generate tokens
         ↓
    consolidation-report.yaml
```

### Artifact Flow

```
User: *scan artifact-001.html
         ↓
    Analyze artifact
         ↓
    projects/curso/registry.yaml + analysis/artifact-001.md
         ↓
User: *scan artifact-002.html
User: *scan artifact-003.html
    [... total 5 artifacts ...]
         ↓
User: *consolidate
         ↓
    detectWorkflowSource() → "artifacts"
         ↓
    loadArtifactPatterns(registry.yaml)
         ↓
    Read 5 analysis/*.md files
         ↓
    Extract patterns from each
         ↓
    Normalize to common format
         ↓
    Cluster patterns
         ↓
    Generate tokens
         ↓
    consolidation-report.yaml
```

---

## Error Handling

### Detection Failures

```javascript
// No source found
{
  type: 'none',
  error: 'No design patterns found to consolidate.\n\n' +
         'Available workflows:\n' +
         '1. Brownfield (codebase): *audit ./src\n' +
         '2. Artifacts (individual): *scan {path|url}\n\n' +
         'Run one of these first, then *consolidate'
}

// Multiple sources (conflict)
{
  type: 'conflict',
  error: 'Found both brownfield audit AND artifact registry.\n\n' +
         'Which source should I use?\n' +
         '1. Brownfield (.state.yaml) - 47 files\n' +
         '2. Artifacts (registry.yaml) - 5 artifacts\n\n' +
         'Choose: *consolidate --source=brownfield|artifacts'
}
```

### Processing Failures

```javascript
try {
  const patterns = loadPatterns(source);
  const tokens = clusterAndGenerate(patterns);
  saveReport(tokens);
} catch (error) {
  if (error.type === 'invalid-analysis') {
    return `Error: Artifact analysis ${error.artifactId} is malformed.\n` +
           `Expected color system section, found none.\n` +
           `Re-scan artifact: *scan {path} --force`;
  }

  if (error.type === 'no-patterns') {
    return `Error: No design patterns found in source.\n` +
           `State file may be empty or corrupted.\n` +
           `Re-run: *audit {path}`;
  }

  throw error; // Unexpected error
}
```

---

## Testing Strategy

### Unit Tests

```yaml
test_detection:
  - Given: brownfield .state.yaml exists
    When: detectWorkflowSource()
    Then: type = "brownfield"

  - Given: artifact registry.yaml exists
    When: detectWorkflowSource()
    Then: type = "artifacts"

  - Given: both .state.yaml AND registry.yaml exist
    When: detectWorkflowSource()
    Then: type = "conflict", prompts user

  - Given: neither exists
    When: detectWorkflowSource()
    Then: type = "none", clear error message

test_normalization:
  - Given: brownfield patterns
    When: loadBrownfieldPatterns()
    Then: output matches common format

  - Given: artifact patterns
    When: loadArtifactPatterns()
    Then: output matches common format

  - Given: both sources
    When: normalize both
    Then: outputs are structurally identical

test_clustering:
  - Given: normalized patterns (brownfield)
    When: clusterColors()
    Then: produces N clusters

  - Given: normalized patterns (artifacts)
    When: clusterColors()
    Then: produces N clusters

  - Given: both produce same input
    When: cluster
    Then: identical output
```

### Integration Tests

```yaml
test_brownfield_workflow:
  - Create test codebase (10 files, 50 colors)
  - Run *audit
  - Verify .state.yaml created
  - Run *consolidate
  - Verify auto-detects brownfield
  - Verify consolidation-report.yaml created
  - Verify tokens reduced 80%+

test_artifact_workflow:
  - Create test project
  - Scan 5 test artifacts
  - Verify registry.yaml created
  - Run *consolidate
  - Verify auto-detects artifacts
  - Verify consolidation-report.yaml created
  - Verify tokens reduced 80%+

test_output_equivalence:
  - Run brownfield workflow → report1
  - Run artifact workflow (same patterns) → report2
  - Assert: report1.structure == report2.structure
  - Assert: report1.tokens ≈ report2.tokens (±5%)
```

---

## Performance Considerations

### Detection Overhead

```
Detection cost:
- Check .state.yaml exists: ~50 tokens
- Check registry.yaml exists: ~50 tokens
- Parse detection result: ~100 tokens
Total: ~200 tokens

Negligible compared to consolidation cost (~68K tokens)
Overhead: 0.3%
```

### Processing Parity

```
Brownfield consolidation:
- Read .state.yaml: ~10K tokens
- Cluster patterns: ~10K tokens
- Generate report: ~15K tokens
Total: ~35K tokens

Artifact consolidation:
- Read registry.yaml: ~5K tokens
- Read 5 analysis.md files: ~43K tokens
- Cluster patterns: ~10K tokens
- Generate report: ~15K tokens
Total: ~73K tokens

Delta: ~38K tokens (artifacts slightly heavier due to markdown parsing)
Optimization opportunity: Cache parsed patterns in registry.yaml
```

---

## Open Questions

1. **Conflict Resolution**: What if both .state.yaml AND registry.yaml exist for same project?
   - **Proposal**: Prompt user to choose, or prefer brownfield (more comprehensive)

2. **Cross-Workflow Migration**: Can user switch from artifacts → brownfield mid-project?
   - **Proposal**: `*migrate-to-brownfield` command that syncs artifact data to .state.yaml

3. **Hybrid Workflows**: User wants to scan BOTH codebase AND external artifacts?
   - **Proposal**: `*merge-sources` command that combines brownfield + artifact data

4. **Performance Optimization**: Should we pre-normalize artifact data on *scan?
   - **Proposal**: Cache normalized patterns in `.metadata/patterns-cache.yaml`

---

## Success Metrics

```yaml
metrics:
  usability:
    target: "100% of users successfully run *consolidate regardless of workflow"
    measure: "Error rate on *consolidate command"

  confusion:
    target: "<5% of users ask 'which workflow am I in?'"
    measure: "Support questions about workflows"

  performance:
    target: "Detection overhead <1% of total consolidation time"
    measure: "Time spent in detectWorkflowSource vs total time"

  compatibility:
    target: "Zero breaking changes for existing brownfield users"
    measure: "Regression tests on brownfield workflow"
```

---

## Implementation Checklist

### Phase 1: Detection Layer
- [ ] Implement `detectWorkflowSource()` function
- [ ] Add detection logic to `consolidate-patterns.md`
- [ ] Write unit tests for detection
- [ ] Handle edge cases (conflicts, missing data)

### Phase 2: Pattern Loading
- [ ] Implement `loadBrownfieldPatterns()`
- [ ] Implement `loadArtifactPatterns()`
- [ ] Write normalization tests
- [ ] Verify output format parity

### Phase 3: Consolidation Logic
- [ ] Refactor clustering to work with normalized format
- [ ] Ensure token generation is source-agnostic
- [ ] Test with both brownfield and artifact inputs
- [ ] Verify output quality matches current implementation

### Phase 4: Error Handling
- [ ] Implement graceful degradation for missing data
- [ ] Add user-friendly error messages
- [ ] Create recovery workflows for common failures
- [ ] Document troubleshooting steps

### Phase 5: Integration
- [ ] Update Brad agent docs
- [ ] Add workflow unification to README
- [ ] Create migration guide for existing users
- [ ] Run full integration test suite

---

## Next Steps

1. **Review**: Alan reviews architecture, proposes changes
2. **Approval**: Get sign-off on approach
3. **Implementation**: 6-8 hours estimated
4. **Testing**: 2-3 hours
5. **Documentation**: Update Brad docs
6. **Release**: Deploy unified workflow

---

**Status**: Awaiting review & approval
**Estimated Implementation**: 6-8 hours
**Estimated Testing**: 2-3 hours
**Total**: ~10 hours for production-ready P1
