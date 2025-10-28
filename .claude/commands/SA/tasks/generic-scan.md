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
