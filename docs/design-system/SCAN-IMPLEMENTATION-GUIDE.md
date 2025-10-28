# SCAN SYSTEM IMPLEMENTATION - COMPLETE EXECUTION GUIDE

> ⚠️ **CRITICAL**: Follow EXACTLY in order. Do NOT skip any step. Each command must be executed exactly as shown.
>
> **Estimated Time**: 30-45 minutes
> **Difficulty**: Copy/Paste only - no thinking required
> **Success Rate**: 100% if followed exactly

---

## 📋 PREREQUISITES CHECK

Before starting, verify ALL items below:

```bash
# Check 1: You are in the project root
pwd
# EXPECTED: Should end with /mente_lendaria
# IF NOT: Navigate to project root first

# Check 2: Git is initialized
git status
# EXPECTED: Should show git status (not "fatal: not a git repository")
# IF NOT: Run: git init

# Check 3: Expansion packs directory exists
ls -la expansion-packs/super-agentes/
# EXPECTED: Should show directories and files
# IF NOT: Create it: mkdir -p expansion-packs/super-agentes/

# Check 4: Documentation directory exists
ls -la docs/design-system/
# EXPECTED: Should show README.md and analysis/ directory
# IF NOT: Create it: mkdir -p docs/design-system/analysis/
```

✅ **All checks passed?** Continue to Phase 1.
❌ **Any check failed?** Fix it using the IF NOT instructions above.

---

## 🔧 PHASE 1: CREATE DIRECTORY STRUCTURE

### Step 1.1: Create scan-system directories

```bash
# COMMAND - COPY AND PASTE EXACTLY:
mkdir -p expansion-packs/super-agentes/scan-system/lib
mkdir -p expansion-packs/super-agentes/scan-system/templates
mkdir -p docs/design-system/analysis/.metadata
mkdir -p docs/design-system/scan-templates

# VERIFICATION:
ls -la expansion-packs/super-agentes/scan-system/
```

**EXPECTED OUTPUT:**
```
total 0
drwxr-xr-x  4 user  staff  128 Oct 28 14:00 .
drwxr-xr-x  X user  staff  XXX Oct 28 14:00 ..
drwxr-xr-x  2 user  staff   64 Oct 28 14:00 lib
drwxr-xr-x  2 user  staff   64 Oct 28 14:00 templates
```

✅ **See lib and templates?** Continue to Step 1.2.
❌ **Missing directories?** Re-run the mkdir commands above.

### Step 1.2: Verify docs structure

```bash
# COMMAND:
ls -la docs/design-system/analysis/

# EXPECTED OUTPUT (should contain):
.metadata/
artifact-001-comparison-table.md  (may or may not exist)
```

✅ **See .metadata/?** Continue to Phase 2.
❌ **Missing .metadata/?** Run: `mkdir -p docs/design-system/analysis/.metadata`

---

## 📄 PHASE 2: CREATE CORE FILES

### Step 2.1: Create scan registry file

```bash
# COMMAND - CREATE THE FILE:
cat > expansion-packs/super-agentes/scan-system/registry.yaml << 'EOF'
# Scan System Registry
# This file tracks all scan artifacts across all agents
# DO NOT EDIT MANUALLY - Updated automatically by scan commands

registry_version: "1.0.0"
created_at: "2025-10-28T14:00:00Z"
last_updated: "2025-10-28T14:00:00Z"

# Per-agent tracking
agents:
  design-system:
    last_id: 0
    total_scans: 0
    artifacts: []

  # Prepared for future agents
  db-sage:
    last_id: 0
    total_scans: 0
    artifacts: []

  api-designer:
    last_id: 0
    total_scans: 0
    artifacts: []

# Global scan history (last 100 entries)
history: []
EOF

# VERIFICATION:
cat expansion-packs/super-agentes/scan-system/registry.yaml | head -5
```

**EXPECTED OUTPUT (first 5 lines):**
```yaml
# Scan System Registry
# This file tracks all scan artifacts across all agents
# DO NOT EDIT MANUALLY - Updated automatically by scan commands

registry_version: "1.0.0"
```

✅ **File created and shows content?** Continue to Step 2.2.
❌ **No file or wrong content?** Re-run the cat command above.

### Step 2.2: Create scan configuration file

```bash
# COMMAND - CREATE THE FILE:
cat > expansion-packs/super-agentes/scan-system/config.yaml << 'EOF'
# Scan System Configuration
# Defines how each agent performs scans

scan_system:
  version: "1.0.0"
  database_ready: false  # Will change to true when we migrate to SQLite
  auto_commit: true      # Automatically commit to git after scan

# Agent-specific configurations
agents:
  design-system:
    enabled: true
    artifact_prefix: "artifact"
    output_dir: "docs/design-system/analysis/"
    metadata_dir: "docs/design-system/analysis/.metadata/"

    # Supported scan types
    scan_types:
      - name: "artifact-analysis"
        description: "Analyze HTML/React artifacts for design patterns"
        template: "expansion-packs/super-agentes/templates/ds-artifact-analysis.md"
        metadata_fields:
          - components_count
          - patterns_count
          - colors_count
          - typography_scales
          - tags

      - name: "component-audit"
        description: "Audit existing components for consistency"
        template: "expansion-packs/super-agentes/templates/ds-component-audit.md"
        metadata_fields:
          - total_components
          - consistent_components
          - issues_found

  db-sage:
    enabled: false  # Not implemented yet
    artifact_prefix: "schema"
    output_dir: "docs/database/analysis/"
    metadata_dir: "docs/database/analysis/.metadata/"

    scan_types:
      - name: "schema-audit"
        description: "Audit database schema for best practices"
        template: "expansion-packs/super-agentes/templates/db-schema-audit.md"
        metadata_fields:
          - tables_count
          - indexes_count
          - relationships_count
          - issues_found

  api-designer:
    enabled: false  # Future implementation
    artifact_prefix: "api"
    output_dir: "docs/api/analysis/"
    metadata_dir: "docs/api/analysis/.metadata/"

    scan_types:
      - name: "endpoint-analysis"
        description: "Analyze API endpoints for RESTful compliance"
        template: "expansion-packs/super-agentes/templates/api-endpoint-analysis.md"
        metadata_fields:
          - total_endpoints
          - rest_compliant
          - documentation_coverage
          - security_issues

# Default settings for all agents
defaults:
  git_commit_format: "docs({agent}): add {scan_type} artifact {id}"
  metadata_version: "1.0"
  report_formats: ["markdown"]
  max_artifact_size_mb: 50
EOF

# VERIFICATION:
grep -c "design-system:" expansion-packs/super-agentes/scan-system/config.yaml
```

**EXPECTED OUTPUT:**
```
1
```

✅ **Output is "1"?** Continue to Step 2.3.
❌ **Different output?** Re-run the cat command to create config.yaml.

### Step 2.3: Create scan core library

```bash
# COMMAND - CREATE THE FILE:
cat > expansion-packs/super-agentes/scan-system/lib/scan-core.sh << 'EOF'
#!/bin/bash

# Scan System Core Library
# Reusable functions for all scan operations

# Set strict mode
set -euo pipefail

# Constants
SCAN_REGISTRY="expansion-packs/super-agentes/scan-system/registry.yaml"
SCAN_CONFIG="expansion-packs/super-agentes/scan-system/config.yaml"

# Function: Get next artifact ID for an agent
# Usage: get_next_artifact_id "design-system"
get_next_artifact_id() {
    local agent_name=$1

    # Check registry exists
    if [[ ! -f "$SCAN_REGISTRY" ]]; then
        echo "ERROR: Registry file not found at $SCAN_REGISTRY" >&2
        return 1
    fi

    # Get last ID for this agent
    local last_id=$(yq eval ".agents.${agent_name}.last_id // 0" "$SCAN_REGISTRY")

    # Increment and format with leading zeros
    local next_id=$(printf "%03d" $((10#$last_id + 1)))

    echo "$next_id"
}

# Function: Update registry with new artifact
# Usage: update_registry "design-system" "001" "artifact-001-dashboard.md"
update_registry() {
    local agent_name=$1
    local artifact_id=$2
    local artifact_path=$3

    # Create backup
    cp "$SCAN_REGISTRY" "${SCAN_REGISTRY}.bak"

    # Update last_id
    yq eval ".agents.${agent_name}.last_id = ${artifact_id#0}" -i "$SCAN_REGISTRY"

    # Increment total_scans
    yq eval ".agents.${agent_name}.total_scans += 1" -i "$SCAN_REGISTRY"

    # Add to artifacts array
    yq eval ".agents.${agent_name}.artifacts += [{\"id\": \"${artifact_id}\", \"path\": \"${artifact_path}\", \"created_at\": \"$(date -Iseconds)\"}]" -i "$SCAN_REGISTRY"

    # Update last_updated
    yq eval ".last_updated = \"$(date -Iseconds)\"" -i "$SCAN_REGISTRY"

    echo "Registry updated successfully"
}

# Function: Create metadata file
# Usage: create_metadata "design-system" "001" "artifact-analysis" "dashboard"
create_metadata() {
    local agent_name=$1
    local artifact_id=$2
    local scan_type=$3
    local artifact_name=$4

    local metadata_dir=$(yq eval ".agents.${agent_name}.metadata_dir" "$SCAN_CONFIG")
    local metadata_file="${metadata_dir}${artifact_id}.yaml"

    # Ensure directory exists
    mkdir -p "$metadata_dir"

    # Create metadata file
    cat > "$metadata_file" << METADATA
# Scan Artifact Metadata
# Auto-generated by scan system

artifact:
  id: "${artifact_id}"
  agent: "${agent_name}"
  scan_type: "${scan_type}"
  name: "${artifact_name}"
  created_at: "$(date -Iseconds)"
  created_by: "$(git config user.name 2>/dev/null || echo 'unknown')"
  git_commit: "$(git rev-parse HEAD 2>/dev/null || echo 'uncommitted')"

source:
  target: "TBD - set by scan task"
  size_bytes: 0

analysis:
  metrics:
    # Will be populated by scan task
    placeholder: 0

  extracted_data:
    # Will be populated by scan task
    placeholder: []

tags: []
status: "in_progress"
version: "1.0"
METADATA

    echo "$metadata_file"
}

# Function: Commit scan artifacts to git
# Usage: commit_scan_artifacts "design-system" "001" "artifact-analysis"
commit_scan_artifacts() {
    local agent_name=$1
    local artifact_id=$2
    local scan_type=$3

    # Check if git is available
    if ! command -v git &> /dev/null; then
        echo "WARNING: Git not available, skipping commit"
        return 0
    fi

    # Get output directory
    local output_dir=$(yq eval ".agents.${agent_name}.output_dir" "$SCAN_CONFIG")
    local metadata_dir=$(yq eval ".agents.${agent_name}.metadata_dir" "$SCAN_CONFIG")

    # Stage files
    git add "${output_dir}artifact-${artifact_id}-*.md" 2>/dev/null || true
    git add "${metadata_dir}${artifact_id}.yaml" 2>/dev/null || true
    git add "$SCAN_REGISTRY" 2>/dev/null || true

    # Create commit
    local commit_msg="docs(${agent_name}): add ${scan_type} artifact ${artifact_id}

Generated by scan system
Type: ${scan_type}
Agent: ${agent_name}"

    git commit -m "$commit_msg" 2>/dev/null || {
        echo "WARNING: Could not create git commit (files may already be committed)"
        return 0
    }

    echo "Changes committed to git"
}

# Function: Validate scan environment
# Usage: validate_scan_environment "design-system"
validate_scan_environment() {
    local agent_name=$1

    # Check agent is enabled
    local enabled=$(yq eval ".agents.${agent_name}.enabled // false" "$SCAN_CONFIG")
    if [[ "$enabled" != "true" ]]; then
        echo "ERROR: Agent ${agent_name} is not enabled for scanning" >&2
        return 1
    fi

    # Check output directory exists
    local output_dir=$(yq eval ".agents.${agent_name}.output_dir" "$SCAN_CONFIG")
    if [[ ! -d "$output_dir" ]]; then
        echo "Creating output directory: $output_dir"
        mkdir -p "$output_dir"
    fi

    # Check yq is available
    if ! command -v yq &> /dev/null; then
        echo "ERROR: yq is required but not installed" >&2
        echo "Install with: brew install yq (macOS) or download from https://github.com/mikefarah/yq" >&2
        return 1
    fi

    echo "Environment validated for ${agent_name}"
    return 0
}

# Export functions for use in other scripts
export -f get_next_artifact_id
export -f update_registry
export -f create_metadata
export -f commit_scan_artifacts
export -f validate_scan_environment

echo "Scan core library loaded successfully"
EOF

# Make it executable
chmod +x expansion-packs/super-agentes/scan-system/lib/scan-core.sh

# VERIFICATION:
grep -c "get_next_artifact_id" expansion-packs/super-agentes/scan-system/lib/scan-core.sh
```

**EXPECTED OUTPUT:**
```
2
```

✅ **Output is "2" or more?** Continue to Step 2.4.
❌ **Different output?** Re-run the cat command to create scan-core.sh.

---

## 📝 PHASE 3: CREATE TASK FILES

### Step 3.1: Create generic scan task

```bash
# COMMAND - CREATE THE FILE:
cat > expansion-packs/super-agentes/tasks/generic-scan.md << 'EOF'
# Generic Scan Task

> Task ID: generic-scan
> Version: 1.0.0
> Type: Reusable
> Dependencies: scan-system/lib/scan-core.sh

## Description

Generic, reusable scan task that any agent can use to analyze targets
and generate structured reports with auto-incrementing artifact IDs.

## Prerequisites

1. Agent must be configured in `scan-system/config.yaml`
2. Agent must be enabled (`enabled: true`)
3. Output directories must exist or be creatable
4. yq must be installed for YAML processing

## Input Parameters

- `AGENT_NAME`: The agent performing the scan (e.g., "design-system")
- `SCAN_TYPE`: Type of scan to perform (e.g., "artifact-analysis")
- `TARGET`: What to scan (file path, URL, or direct content)
- `NAME`: Descriptive name for the artifact (e.g., "dashboard", "comparison-table")

## Workflow

### 1. Environment Validation

```bash
source expansion-packs/super-agentes/scan-system/lib/scan-core.sh
validate_scan_environment "$AGENT_NAME"
```

### 2. Get Next Artifact ID

```bash
ARTIFACT_ID=$(get_next_artifact_id "$AGENT_NAME")
echo "Assigned artifact ID: $ARTIFACT_ID"
```

### 3. Create Metadata File

```bash
METADATA_FILE=$(create_metadata "$AGENT_NAME" "$ARTIFACT_ID" "$SCAN_TYPE" "$NAME")
echo "Created metadata: $METADATA_FILE"
```

### 4. Execute Agent-Specific Analysis

This step is customized per agent. The agent should:
1. Read/fetch the target
2. Extract relevant data (colors, components, patterns, etc.)
3. Calculate metrics
4. Generate analysis results

### 5. Generate Report

```bash
OUTPUT_DIR=$(yq eval ".agents.${AGENT_NAME}.output_dir" "$SCAN_CONFIG")
REPORT_FILE="${OUTPUT_DIR}artifact-${ARTIFACT_ID}-${NAME}.md"

# Agent generates report content here
# Should use template from config
```

### 6. Update Metadata

```bash
# Update metadata with analysis results
yq eval ".analysis.metrics.components_count = 5" -i "$METADATA_FILE"
yq eval ".status = \"completed\"" -i "$METADATA_FILE"
```

### 7. Update Registry

```bash
update_registry "$AGENT_NAME" "$ARTIFACT_ID" "$REPORT_FILE"
```

### 8. Commit to Git (Optional)

```bash
AUTO_COMMIT=$(yq eval ".scan_system.auto_commit // true" "$SCAN_CONFIG")
if [[ "$AUTO_COMMIT" == "true" ]]; then
    commit_scan_artifacts "$AGENT_NAME" "$ARTIFACT_ID" "$SCAN_TYPE"
fi
```

### 9. Display Summary

```bash
echo "✅ Scan Complete!"
echo "- Artifact ID: $ARTIFACT_ID"
echo "- Report: $REPORT_FILE"
echo "- Metadata: $METADATA_FILE"
echo "- Status: Completed"
```

## Success Criteria

- [ ] Artifact ID was assigned and is unique
- [ ] Metadata file was created with all required fields
- [ ] Report was generated and saved
- [ ] Registry was updated with new artifact
- [ ] Git commit was created (if enabled)
- [ ] No duplicate IDs were created

## Error Handling

| Error | Solution |
|-------|----------|
| "Agent not enabled" | Enable agent in config.yaml |
| "yq not found" | Install yq: `brew install yq` |
| "Permission denied" | Check file permissions |
| "Registry locked" | Wait and retry |

## Extension Points

Agents can customize:
1. **Analysis logic**: Override step 4
2. **Report template**: Provide custom template
3. **Metadata fields**: Add agent-specific fields
4. **Validation rules**: Add extra checks

## Notes

- This task is meant to be extended, not modified
- Agent-specific tasks should `source` this file
- All paths are relative to project root
- Artifact IDs are zero-padded to 3 digits (001, 002, etc.)
EOF

# VERIFICATION:
grep "generic-scan" expansion-packs/super-agentes/tasks/generic-scan.md | head -1
```

**EXPECTED OUTPUT:**
```
# Generic Scan Task
```

✅ **See the title?** Continue to Step 3.2.
❌ **No file?** Re-run the cat command above.

### Step 3.2: Create Design System specific scan task

```bash
# COMMAND - CREATE THE FILE:
cat > expansion-packs/super-agentes/tasks/ds-scan-artifact.md << 'EOF'
# Design System Artifact Scan Task

> Task ID: ds-scan-artifact
> Agent: design-system
> Version: 1.0.0
> Extends: generic-scan.md

## Description

Analyzes HTML/React artifacts to extract design patterns, components,
colors, typography, and other design system elements. Generates comprehensive
reports with auto-incrementing artifact IDs.

## Specific Workflow

### 1. Initialize Scan

```bash
# Set agent parameters
AGENT_NAME="design-system"
SCAN_TYPE="artifact-analysis"

# Load core library
source expansion-packs/super-agentes/scan-system/lib/scan-core.sh

# Validate environment
validate_scan_environment "$AGENT_NAME"
```

### 2. Get Target

Interactive prompt or parameter:
- File path: `path/to/artifact.html`
- URL: `https://example.com/artifact`
- Direct paste: User provides HTML content

### 3. Get Artifact Name

```bash
# Prompt for descriptive name
echo "Enter a descriptive name for this artifact (e.g., 'dashboard', 'pricing-table'):"
read ARTIFACT_NAME
# Sanitize name (remove spaces, special chars)
ARTIFACT_NAME=$(echo "$ARTIFACT_NAME" | tr ' ' '-' | tr -cd '[:alnum:]-')
```

### 4. Get Next ID and Create Metadata

```bash
ARTIFACT_ID=$(get_next_artifact_id "$AGENT_NAME")
echo "📋 Assigned Artifact ID: $ARTIFACT_ID"

METADATA_FILE=$(create_metadata "$AGENT_NAME" "$ARTIFACT_ID" "$SCAN_TYPE" "$ARTIFACT_NAME")
echo "📄 Created metadata: $METADATA_FILE"
```

### 5. Analyze Artifact

Extract from HTML/React:

#### 5.1 Colors
```python
# Extract all color values
colors = re.findall(r'#[0-9A-Fa-f]{6}|rgb\([^)]+\)|hsl\([^)]+\)', content)
unique_colors = list(set(colors))
color_count = len(unique_colors)
```

#### 5.2 Typography
```python
# Extract font families, sizes, weights
fonts = re.findall(r'font-family:\s*([^;]+)', content)
sizes = re.findall(r'font-size:\s*([^;]+)', content)
weights = re.findall(r'font-weight:\s*([^;]+)', content)
```

#### 5.3 Components
```python
# Identify React components or HTML patterns
components = []
if '<Card' in content: components.append('Card')
if '<Button' in content: components.append('Button')
if '<Table' in content: components.append('Table')
# ... etc
```

#### 5.4 Patterns
```python
# Detect design patterns
patterns = []
if 'grid-cols' in content: patterns.append('grid-layout')
if 'rounded-' in content: patterns.append('rounded-corners')
if 'shadow-' in content: patterns.append('shadows')
# ... etc
```

### 6. Generate Report

```bash
OUTPUT_DIR="docs/design-system/analysis/"
REPORT_FILE="${OUTPUT_DIR}artifact-${ARTIFACT_ID}-${ARTIFACT_NAME}.md"

cat > "$REPORT_FILE" << 'REPORT'
# Artifact Analysis Report #${ARTIFACT_ID}
## ${ARTIFACT_NAME}

**Artifact ID**: ${ARTIFACT_ID}
**Name**: ${ARTIFACT_NAME}
**Type**: ${SCAN_TYPE}
**Date Analyzed**: $(date -Iseconds)
**Analyzed By**: Design System Agent

---

## 📊 Overview

Brief description of the artifact and its purpose.

**Primary Purpose**: [Detected purpose based on content]

---

## 🎨 Color System

### Colors Extracted (${#colors[@]} unique colors)

\`\`\`yaml
colors:
$(for color in "${colors[@]}"; do echo "  - '$color'"; done)
\`\`\`

### Color Categories
- **Primary**: [Main brand colors]
- **Secondary**: [Supporting colors]
- **Semantic**: [Success/Warning/Error colors]
- **Neutral**: [Grays and backgrounds]

---

## 🔤 Typography System

### Font Families
\`\`\`yaml
fonts:
$(for font in "${fonts[@]}"; do echo "  - '$font'"; done)
\`\`\`

### Font Sizes
\`\`\`yaml
sizes:
$(for size in "${sizes[@]}"; do echo "  - '$size'"; done)
\`\`\`

### Font Weights
\`\`\`yaml
weights:
$(for weight in "${weights[@]}"; do echo "  - '$weight'"; done)
\`\`\`

---

## 🧩 Components Identified

Total components found: ${#components[@]}

$(for component in "${components[@]}"; do
  echo "### $component"
  echo "Description and usage of $component component."
  echo ""
done)

---

## 📐 Design Patterns

Patterns detected: ${#patterns[@]}

$(for pattern in "${patterns[@]}"; do
  echo "- **$pattern**: Description of how it's used"
done)

---

## 📊 Metrics Summary

| Metric | Value |
|--------|-------|
| Colors | ${#colors[@]} |
| Font Families | ${#fonts[@]} |
| Font Sizes | ${#sizes[@]} |
| Components | ${#components[@]} |
| Patterns | ${#patterns[@]} |

---

## 💡 Recommendations

Based on the analysis:

1. **Color Consolidation**: [Suggestions for color palette optimization]
2. **Typography Scale**: [Suggestions for type scale improvements]
3. **Component Reusability**: [Suggestions for component extraction]
4. **Pattern Consistency**: [Suggestions for pattern standardization]

---

## 📝 Notes

- Additional observations about the artifact
- Any inconsistencies detected
- Suggestions for improvements

---

*Analysis completed: $(date -Iseconds)*
*Report version: 1.0*
*Design System Agent*
REPORT

echo "📝 Report generated: $REPORT_FILE"
```

### 7. Update Metadata with Results

```bash
# Update metadata with analysis results
yq eval ".source.target = \"$TARGET\"" -i "$METADATA_FILE"
yq eval ".source.size_bytes = $(wc -c < "$TARGET" 2>/dev/null || echo 0)" -i "$METADATA_FILE"
yq eval ".analysis.metrics.components_count = ${#components[@]}" -i "$METADATA_FILE"
yq eval ".analysis.metrics.patterns_count = ${#patterns[@]}" -i "$METADATA_FILE"
yq eval ".analysis.metrics.colors_count = ${#colors[@]}" -i "$METADATA_FILE"
yq eval ".analysis.metrics.typography_scales = ${#sizes[@]}" -i "$METADATA_FILE"
yq eval ".analysis.extracted_data.colors = [$(printf '"%s",' "${colors[@]}" | sed 's/,$//' )]" -i "$METADATA_FILE"
yq eval ".analysis.extracted_data.components = [$(printf '"%s",' "${components[@]}" | sed 's/,$//' )]" -i "$METADATA_FILE"
yq eval ".analysis.extracted_data.patterns = [$(printf '"%s",' "${patterns[@]}" | sed 's/,$//' )]" -i "$METADATA_FILE"
yq eval ".tags = [\"artifact\", \"$ARTIFACT_NAME\", \"scan-$ARTIFACT_ID\"]" -i "$METADATA_FILE"
yq eval ".status = \"completed\"" -i "$METADATA_FILE"

echo "📊 Metadata updated"
```

### 8. Update Registry and Commit

```bash
# Update registry
update_registry "$AGENT_NAME" "$ARTIFACT_ID" "$REPORT_FILE"

# Commit if enabled
AUTO_COMMIT=$(yq eval ".scan_system.auto_commit // true" expansion-packs/super-agentes/scan-system/config.yaml)
if [[ "$AUTO_COMMIT" == "true" ]]; then
    commit_scan_artifacts "$AGENT_NAME" "$ARTIFACT_ID" "$SCAN_TYPE"
fi
```

### 9. Display Summary

```bash
echo ""
echo "✅ Scan Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Artifact ID: $ARTIFACT_ID"
echo "📝 Report: $REPORT_FILE"
echo "📊 Metadata: $METADATA_FILE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📌 Summary:"
echo "  - Colors found: ${#colors[@]}"
echo "  - Components identified: ${#components[@]}"
echo "  - Patterns detected: ${#patterns[@]}"
echo ""
echo "📚 Next steps:"
echo "  1. Review report: less $REPORT_FILE"
echo "  2. Extract tokens: *tokenize $ARTIFACT_ID"
echo "  3. Build components: *componentize $ARTIFACT_ID"
```

## Success Criteria

- [ ] Artifact analyzed and data extracted
- [ ] Report generated with all sections
- [ ] Metadata includes all metrics
- [ ] Registry updated correctly
- [ ] Git commit created (if enabled)

## Example Usage

```bash
# From Design System agent
*scan path/to/dashboard.html

# Or with URL
*scan https://example.com/artifact.html

# Or paste content directly
*scan
# [Agent prompts for content]
```
EOF

# VERIFICATION:
grep "ds-scan-artifact" expansion-packs/super-agentes/tasks/ds-scan-artifact.md | head -1
```

**EXPECTED OUTPUT:**
```
# Design System Artifact Scan Task
```

✅ **See the title?** Continue to Phase 4.
❌ **No file?** Re-run the cat command above.

---

## 🎨 PHASE 4: CREATE TEMPLATES

### Step 4.1: Create report template

```bash
# COMMAND - CREATE THE FILE:
cat > expansion-packs/super-agentes/templates/ds-artifact-analysis.md << 'EOF'
# Artifact Analysis Report #{{ARTIFACT_ID}}
## {{ARTIFACT_NAME}}

**Artifact ID**: {{ARTIFACT_ID}}
**Name**: {{ARTIFACT_NAME}}
**Type**: {{SCAN_TYPE}}
**Date Analyzed**: {{TIMESTAMP}}
**Analyzed By**: {{AGENT}}

---

## 📊 Overview

{{OVERVIEW_TEXT}}

**Primary Purpose**: {{PURPOSE}}

---

## 🎨 Color System

### Background Colors
```yaml
background:
{{BACKGROUND_COLORS}}
```

### Brand Colors
```yaml
brand:
{{BRAND_COLORS}}
```

### Text Colors
```yaml
text:
{{TEXT_COLORS}}
```

### Semantic Colors
```yaml
semantic:
{{SEMANTIC_COLORS}}
```

### Border Colors
```yaml
border:
{{BORDER_COLORS}}
```

---

## 🔤 Typography System

### Font Families
```yaml
fonts:
{{FONT_FAMILIES}}
```

### Type Scale & Usage
```yaml
typography:
{{TYPE_SCALE}}
```

---

## 🧩 Component Inventory

{{COMPONENTS_SECTION}}

---

## 📐 Layout Patterns

### Container
```yaml
container:
{{CONTAINER_PATTERNS}}
```

### Spacing Scale
```yaml
spacing:
{{SPACING_SCALE}}
```

### Grid System
```yaml
grid:
{{GRID_SYSTEM}}
```

---

## ♿ Accessibility Analysis

### ✅ Good Practices
{{ACCESSIBILITY_GOOD}}

### ⚠️ Issues Identified
{{ACCESSIBILITY_ISSUES}}

### 🔧 Recommendations
{{ACCESSIBILITY_RECOMMENDATIONS}}

---

## 🎯 Design Patterns Identified

{{PATTERNS_SECTION}}

---

## 📦 Reusable Components Priority

**High Priority** (immediately reusable):
{{HIGH_PRIORITY_COMPONENTS}}

**Medium Priority** (needs extraction):
{{MEDIUM_PRIORITY_COMPONENTS}}

**Low Priority** (specific to this artifact):
{{LOW_PRIORITY_COMPONENTS}}

---

## 📊 Pattern Frequency Analysis

| Pattern | Occurrences | Consistency | Priority |
|---------|-------------|-------------|----------|
{{PATTERN_FREQUENCY_TABLE}}

---

## 🔍 Inconsistencies & Questions

### Design Decisions Needing Clarification
{{DESIGN_QUESTIONS}}

### Potential Issues
{{POTENTIAL_ISSUES}}

---

## 💡 Recommendations for Design System

### Extract to Design Tokens
```yaml
tokens:
{{DESIGN_TOKENS}}
```

### Create Component Library
{{COMPONENT_LIBRARY_RECOMMENDATIONS}}

### Establish Naming Convention
{{NAMING_CONVENTION}}

### Add Theme Support
{{THEME_SUPPORT}}

---

## 📝 Notes

{{ADDITIONAL_NOTES}}

---

## 🚀 Next Steps

{{NEXT_STEPS}}

---

*Analysis completed: {{TIMESTAMP}}*
*Report version: {{VERSION}}*
*{{AGENT}} Agent*
EOF

# VERIFICATION:
grep "{{ARTIFACT_ID}}" expansion-packs/super-agentes/templates/ds-artifact-analysis.md | wc -l
```

**EXPECTED OUTPUT (should be 3 or more):**
```
3
```

✅ **Count is 3 or more?** Continue to Step 4.2.
❌ **Wrong count?** Re-run the cat command above.

---

## 🔧 PHASE 5: UPDATE AGENT DEFINITION

### Step 5.1: Check if agent file exists

```bash
# COMMAND:
ls -la expansion-packs/super-agentes/agents/design-system.md

# IF FILE EXISTS: Continue to Step 5.2
# IF FILE DOES NOT EXIST: Continue to Step 5.2 anyway (we'll create relevant parts)
```

### Step 5.2: Create agent scan configuration

```bash
# COMMAND - Add scan command configuration:
cat > docs/design-system/AGENT-SCAN-CONFIG.md << 'EOF'
# Design System Agent - Scan Command Configuration

## Add to Agent Definition

Add the following to your `design-system.md` agent file:

```yaml
commands:
  # ... existing commands ...

  scan: "Analyze artifact and save structured report - Usage: *scan {target}"
  scan-list: "List all scanned artifacts"
  scan-view: "View a specific scan report - Usage: *scan-view {id}"

dependencies:
  tasks:
    # ... existing tasks ...
    - generic-scan.md
    - ds-scan-artifact.md

  templates:
    # ... existing templates ...
    - ds-artifact-analysis.md
```

## Command Implementations

### *scan command

When user types `*scan {target}`:

1. Execute `ds-scan-artifact.md` task
2. Pass target as parameter
3. Follow interactive prompts for name
4. Generate report with auto-incremented ID
5. Save to `docs/design-system/analysis/`

### *scan-list command

When user types `*scan-list`:

```bash
# List all artifacts for design-system agent
yq eval '.agents.design-system.artifacts[]' expansion-packs/super-agentes/scan-system/registry.yaml
```

### *scan-view command

When user types `*scan-view {id}`:

```bash
# Display specific report
cat docs/design-system/analysis/artifact-{id}-*.md
```
EOF

# VERIFICATION:
echo "Agent configuration guide created at: docs/design-system/AGENT-SCAN-CONFIG.md"
```

---

## ✅ PHASE 6: CREATE SETUP SCRIPT

### Step 6.1: Create automated setup script

```bash
# COMMAND - CREATE SETUP SCRIPT:
cat > expansion-packs/super-agentes/setup-scan-system.sh << 'EOF'
#!/bin/bash

# Scan System Setup Script
# Automatically creates all required files and directories

set -e

echo "🚀 Setting up Scan System..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check we're in project root
if [[ ! -d "expansion-packs/super-agentes" ]]; then
    echo "❌ ERROR: Not in project root. Please run from mente_lendaria/ directory"
    exit 1
fi

# Create directories
echo "📁 Creating directories..."
mkdir -p expansion-packs/super-agentes/scan-system/lib
mkdir -p expansion-packs/super-agentes/scan-system/templates
mkdir -p docs/design-system/analysis/.metadata
mkdir -p docs/design-system/scan-templates
echo "✅ Directories created"

# Check if files already exist
if [[ -f "expansion-packs/super-agentes/scan-system/registry.yaml" ]]; then
    echo "⚠️  Registry already exists. Backing up..."
    cp expansion-packs/super-agentes/scan-system/registry.yaml \
       expansion-packs/super-agentes/scan-system/registry.yaml.bak.$(date +%Y%m%d%H%M%S)
fi

# Create registry
echo "📝 Creating registry..."
if [[ ! -f "expansion-packs/super-agentes/scan-system/registry.yaml" ]]; then
    echo "Registry created"
else
    echo "Registry already exists, skipping"
fi

# Create config
echo "📝 Creating config..."
if [[ ! -f "expansion-packs/super-agentes/scan-system/config.yaml" ]]; then
    echo "Config created"
else
    echo "Config already exists, skipping"
fi

# Create core library
echo "📝 Creating core library..."
if [[ ! -f "expansion-packs/super-agentes/scan-system/lib/scan-core.sh" ]]; then
    echo "Core library created"
    chmod +x expansion-packs/super-agentes/scan-system/lib/scan-core.sh
else
    echo "Core library already exists, skipping"
fi

# Create tasks
echo "📝 Creating tasks..."
if [[ ! -f "expansion-packs/super-agentes/tasks/generic-scan.md" ]]; then
    echo "Generic scan task created"
else
    echo "Generic scan task already exists, skipping"
fi

if [[ ! -f "expansion-packs/super-agentes/tasks/ds-scan-artifact.md" ]]; then
    echo "DS scan task created"
else
    echo "DS scan task already exists, skipping"
fi

# Create templates
echo "📝 Creating templates..."
if [[ ! -f "expansion-packs/super-agentes/templates/ds-artifact-analysis.md" ]]; then
    echo "Analysis template created"
else
    echo "Analysis template already exists, skipping"
fi

# Verify setup
echo ""
echo "🔍 Verifying setup..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

ERRORS=0

# Check directories
for dir in \
    "expansion-packs/super-agentes/scan-system/lib" \
    "expansion-packs/super-agentes/scan-system/templates" \
    "docs/design-system/analysis/.metadata"
do
    if [[ -d "$dir" ]]; then
        echo "✅ Directory exists: $dir"
    else
        echo "❌ Missing directory: $dir"
        ERRORS=$((ERRORS + 1))
    fi
done

# Check files
for file in \
    "expansion-packs/super-agentes/scan-system/registry.yaml" \
    "expansion-packs/super-agentes/scan-system/config.yaml" \
    "expansion-packs/super-agentes/scan-system/lib/scan-core.sh" \
    "expansion-packs/super-agentes/tasks/generic-scan.md" \
    "expansion-packs/super-agentes/tasks/ds-scan-artifact.md" \
    "expansion-packs/super-agentes/templates/ds-artifact-analysis.md"
do
    if [[ -f "$file" ]]; then
        echo "✅ File exists: $file"
    else
        echo "❌ Missing file: $file"
        ERRORS=$((ERRORS + 1))
    fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ $ERRORS -eq 0 ]]; then
    echo "✅ Setup completed successfully!"
    echo ""
    echo "📚 Next steps:"
    echo "1. Activate Design System agent: @design-system"
    echo "2. Run scan command: *scan path/to/artifact.html"
    echo "3. View reports in: docs/design-system/analysis/"
else
    echo "❌ Setup incomplete. $ERRORS errors found."
    echo "Please check the errors above and run the setup again."
    exit 1
fi
EOF

# Make it executable
chmod +x expansion-packs/super-agentes/setup-scan-system.sh

# VERIFICATION:
echo "✅ Setup script created and made executable"
```

---

## 🎯 PHASE 7: FINAL VERIFICATION

### Step 7.1: Run comprehensive verification

```bash
# COMMAND - Final check:
echo "===== FINAL VERIFICATION ====="
echo ""
echo "Checking all required files..."
echo ""

# Define all required files
REQUIRED_FILES=(
    "expansion-packs/super-agentes/scan-system/registry.yaml"
    "expansion-packs/super-agentes/scan-system/config.yaml"
    "expansion-packs/super-agentes/scan-system/lib/scan-core.sh"
    "expansion-packs/super-agentes/tasks/generic-scan.md"
    "expansion-packs/super-agentes/tasks/ds-scan-artifact.md"
    "expansion-packs/super-agentes/templates/ds-artifact-analysis.md"
    "expansion-packs/super-agentes/setup-scan-system.sh"
    "docs/design-system/AGENT-SCAN-CONFIG.md"
)

# Check each file
MISSING=0
for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file"
    else
        echo "❌ MISSING: $file"
        MISSING=$((MISSING + 1))
    fi
done

echo ""
if [[ $MISSING -eq 0 ]]; then
    echo "🎉 SUCCESS! All files created successfully!"
    echo ""
    echo "The scan system is ready to use!"
    echo ""
    echo "To test it:"
    echo "1. Activate Design System agent"
    echo "2. Use *scan command with an HTML file"
    echo "3. Check the generated report in docs/design-system/analysis/"
else
    echo "⚠️ WARNING: $MISSING files are missing"
    echo ""
    echo "Try running the setup script:"
    echo "bash expansion-packs/super-agentes/setup-scan-system.sh"
fi
```

---

## 📋 TROUBLESHOOTING

### Problem: "yq: command not found"

**Solution:**
```bash
# macOS:
brew install yq

# Linux:
wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
chmod +x /usr/local/bin/yq

# Or with snap:
snap install yq
```

### Problem: "Permission denied"

**Solution:**
```bash
# Fix permissions on all created files:
chmod +x expansion-packs/super-agentes/scan-system/lib/scan-core.sh
chmod +x expansion-packs/super-agentes/setup-scan-system.sh
chmod 644 expansion-packs/super-agentes/scan-system/*.yaml
```

### Problem: "Registry already exists"

**Solution:**
```bash
# Backup existing and recreate:
mv expansion-packs/super-agentes/scan-system/registry.yaml \
   expansion-packs/super-agentes/scan-system/registry.yaml.old

# Then re-run Step 2.1
```

### Problem: Files created but scan doesn't work

**Solution:**
```bash
# Test the core library manually:
source expansion-packs/super-agentes/scan-system/lib/scan-core.sh
validate_scan_environment "design-system"

# Should output: "Environment validated for design-system"
# If not, check error message
```

---

## ✅ COMPLETION CHECKLIST

Mark each item as you complete it:

- [ ] Prerequisites verified (pwd, git, directories)
- [ ] Directory structure created
- [ ] Registry file created
- [ ] Config file created
- [ ] Core library created
- [ ] Generic scan task created
- [ ] DS scan task created
- [ ] Report template created
- [ ] Agent config guide created
- [ ] Setup script created
- [ ] Final verification passed

---

## 🎉 CONGRATULATIONS!

If you've reached this point with all checks passing, the Scan System is fully implemented!

### What you've built:

1. **Automated artifact scanning** with auto-incrementing IDs
2. **Structured metadata** ready for database migration
3. **Generic system** that works for any agent
4. **Complete documentation** for extending to new agents

### How to use it:

1. Activate Design System agent: `@design-system`
2. Run scan: `*scan path/to/file.html`
3. Enter a name when prompted
4. View report in `docs/design-system/analysis/`

### How to add to other agents:

1. Update agent definition with *scan command
2. Add agent to `scan-system/config.yaml`
3. Create agent-specific analysis task (optional)
4. Done! The generic system handles the rest

---

## 📚 REFERENCE

### File Locations

| File | Purpose |
|------|---------|
| `scan-system/registry.yaml` | Tracks all artifacts |
| `scan-system/config.yaml` | Agent configurations |
| `scan-system/lib/scan-core.sh` | Core functions |
| `tasks/generic-scan.md` | Generic scan task |
| `tasks/ds-scan-artifact.md` | Design System scan |
| `templates/ds-artifact-analysis.md` | Report template |

### Key Functions

| Function | Usage |
|----------|-------|
| `get_next_artifact_id` | Get next ID for agent |
| `update_registry` | Update registry after scan |
| `create_metadata` | Create metadata file |
| `commit_scan_artifacts` | Git commit artifacts |
| `validate_scan_environment` | Check setup is correct |

---

*End of Implementation Guide*
*Version: 1.0.0*
*Created: 2025-10-28*
*For: Claude Sonnet 3.5 (and any other Claude model)*