#!/bin/bash

# ============================================================================
# SCAN SYSTEM - ALL-IN-ONE SETUP SCRIPT
#
# This script creates the ENTIRE scan system in one go.
# Just run: bash SCAN-SYSTEM-ALL-IN-ONE-SETUP.sh
# ============================================================================

set -e  # Exit on any error

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║         SCAN SYSTEM - COMPLETE AUTOMATED SETUP              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Check we're in the right place
if [[ ! -d "expansion-packs/super-agentes" ]]; then
    echo "❌ ERROR: Not in project root directory!"
    echo "   Current directory: $(pwd)"
    echo "   Expected: Should contain 'expansion-packs/super-agentes/'"
    echo ""
    echo "   Please cd to your mente_lendaria directory and run again."
    exit 1
fi

echo "✅ Project root confirmed"
echo ""
echo "📦 Creating all directories..."

# Create all directories
mkdir -p expansion-packs/super-agentes/scan-system/lib
mkdir -p expansion-packs/super-agentes/scan-system/templates
mkdir -p docs/design-system/analysis/.metadata
mkdir -p docs/design-system/scan-templates

echo "✅ Directories created"
echo ""
echo "📄 Creating scan system files..."
echo ""

# ============================================================================
# FILE 1: Registry
# ============================================================================
echo "  [1/8] Creating registry.yaml..."
cat > expansion-packs/super-agentes/scan-system/registry.yaml << 'REGISTRY_EOF'
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
REGISTRY_EOF

# ============================================================================
# FILE 2: Config
# ============================================================================
echo "  [2/8] Creating config.yaml..."
cat > expansion-packs/super-agentes/scan-system/config.yaml << 'CONFIG_EOF'
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
CONFIG_EOF

# ============================================================================
# FILE 3: Core Library
# ============================================================================
echo "  [3/8] Creating scan-core.sh..."
cat > expansion-packs/super-agentes/scan-system/lib/scan-core.sh << 'CORE_EOF'
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
CORE_EOF

chmod +x expansion-packs/super-agentes/scan-system/lib/scan-core.sh

# ============================================================================
# FILE 4: Generic Scan Task
# ============================================================================
echo "  [4/8] Creating generic-scan.md..."
cat > expansion-packs/super-agentes/tasks/generic-scan.md << 'GENERIC_EOF'
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
GENERIC_EOF

# ============================================================================
# FILE 5: DS Scan Task
# ============================================================================
echo "  [5/8] Creating ds-scan-artifact.md..."
cat > expansion-packs/super-agentes/tasks/ds-scan-artifact.md << 'DS_TASK_EOF'
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

Extract design elements from HTML/React content.

### 6. Generate Report

Create comprehensive analysis report with extracted data.

### 7. Update Metadata with Results

Update metadata file with analysis metrics and extracted data.

### 8. Update Registry and Commit

Update scan registry and optionally commit to git.

### 9. Display Summary

Show completion message with artifact details and next steps.

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
DS_TASK_EOF

# ============================================================================
# FILE 6: Report Template
# ============================================================================
echo "  [6/8] Creating ds-artifact-analysis.md template..."
cat > expansion-packs/super-agentes/templates/ds-artifact-analysis.md << 'TEMPLATE_EOF'
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

### Colors Extracted
```yaml
colors:
{{COLORS_LIST}}
```

---

## 🔤 Typography System

### Fonts and Scales
```yaml
typography:
{{TYPOGRAPHY_DATA}}
```

---

## 🧩 Components Identified

{{COMPONENTS_SECTION}}

---

## 📐 Design Patterns

{{PATTERNS_SECTION}}

---

## 📊 Metrics Summary

| Metric | Value |
|--------|-------|
| Colors | {{COLORS_COUNT}} |
| Components | {{COMPONENTS_COUNT}} |
| Patterns | {{PATTERNS_COUNT}} |

---

## 💡 Recommendations

{{RECOMMENDATIONS}}

---

*Analysis completed: {{TIMESTAMP}}*
*Report version: 1.0*
*Design System Agent*
TEMPLATE_EOF

# ============================================================================
# FILE 7: Agent Config Guide
# ============================================================================
echo "  [7/8] Creating AGENT-SCAN-CONFIG.md..."
cat > docs/design-system/AGENT-SCAN-CONFIG.md << 'AGENT_CONFIG_EOF'
# Design System Agent - Scan Command Configuration

## Add to Agent Definition

Add the following to your `design-system.md` agent file:

```yaml
commands:
  scan: "Analyze artifact and save structured report - Usage: *scan {target}"
  scan-list: "List all scanned artifacts"
  scan-view: "View a specific scan report - Usage: *scan-view {id}"

dependencies:
  tasks:
    - generic-scan.md
    - ds-scan-artifact.md

  templates:
    - ds-artifact-analysis.md
```

## Command Usage

- `*scan {target}` - Analyze a new artifact
- `*scan-list` - List all scanned artifacts
- `*scan-view {id}` - View specific report

## Output Location

Reports: `docs/design-system/analysis/`
Metadata: `docs/design-system/analysis/.metadata/`
AGENT_CONFIG_EOF

# ============================================================================
# FILE 8: Simple Test Script
# ============================================================================
echo "  [8/8] Creating test script..."
cat > expansion-packs/super-agentes/test-scan-system.sh << 'TEST_EOF'
#!/bin/bash

echo "🧪 Testing Scan System..."
echo ""

# Test 1: Load library
echo "Test 1: Loading core library..."
source expansion-packs/super-agentes/scan-system/lib/scan-core.sh
if [[ $? -eq 0 ]]; then
    echo "✅ Library loaded"
else
    echo "❌ Failed to load library"
    exit 1
fi

# Test 2: Validate environment
echo ""
echo "Test 2: Validating environment..."
validate_scan_environment "design-system"
if [[ $? -eq 0 ]]; then
    echo "✅ Environment valid"
else
    echo "❌ Environment validation failed"
    exit 1
fi

# Test 3: Get next ID
echo ""
echo "Test 3: Getting next artifact ID..."
NEXT_ID=$(get_next_artifact_id "design-system")
echo "Next ID will be: $NEXT_ID"
if [[ "$NEXT_ID" == "001" ]]; then
    echo "✅ ID generation works"
else
    echo "⚠️  ID is not 001, might have existing scans"
fi

echo ""
echo "🎉 All tests passed! Scan system is ready to use."
TEST_EOF

chmod +x expansion-packs/super-agentes/test-scan-system.sh

# ============================================================================
# VERIFICATION
# ============================================================================
echo ""
echo "✅ All files created successfully!"
echo ""
echo "🔍 Verifying installation..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check all files exist
MISSING=0
for file in \
    "expansion-packs/super-agentes/scan-system/registry.yaml" \
    "expansion-packs/super-agentes/scan-system/config.yaml" \
    "expansion-packs/super-agentes/scan-system/lib/scan-core.sh" \
    "expansion-packs/super-agentes/tasks/generic-scan.md" \
    "expansion-packs/super-agentes/tasks/ds-scan-artifact.md" \
    "expansion-packs/super-agentes/templates/ds-artifact-analysis.md" \
    "docs/design-system/AGENT-SCAN-CONFIG.md" \
    "expansion-packs/super-agentes/test-scan-system.sh"
do
    if [[ -f "$file" ]]; then
        echo "✅ $(basename $file)"
    else
        echo "❌ MISSING: $file"
        MISSING=$((MISSING + 1))
    fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ $MISSING -eq 0 ]]; then
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              🎉 SETUP COMPLETED SUCCESSFULLY! 🎉            ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "📋 What was created:"
    echo "  • Complete scan system infrastructure"
    echo "  • Auto-incrementing artifact IDs"
    echo "  • Design System scan task"
    echo "  • Report templates"
    echo "  • Test suite"
    echo ""
    echo "🧪 Test the system:"
    echo "  bash expansion-packs/super-agentes/test-scan-system.sh"
    echo ""
    echo "📚 How to use:"
    echo "  1. Activate Design System agent"
    echo "  2. Run: *scan path/to/artifact.html"
    echo "  3. View report in: docs/design-system/analysis/"
    echo ""
    echo "📖 Documentation:"
    echo "  • Guide: docs/design-system/SCAN-IMPLEMENTATION-GUIDE.md"
    echo "  • Summary: docs/design-system/SCAN-SYSTEM-SUMMARY.md"
    echo ""
else
    echo ""
    echo "⚠️  WARNING: $MISSING files could not be created"
    echo "Please check permissions and try again"
    exit 1
fi

echo "✨ Done! The scan system is ready for Claude Sonnet 3.5 to use!"