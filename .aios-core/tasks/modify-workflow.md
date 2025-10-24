# Modify Workflow Task

## Purpose

To safely modify existing workflow definitions while maintaining their orchestration logic, preserving phase transitions, and ensuring all agent interactions remain valid. This task enables workflow evolution through intelligent modifications with comprehensive validation.

## Prerequisites

- Target workflow must exist in `aios-core/workflows/`
- User must provide modification intent or specific changes
- Understanding of workflow phases and agent orchestration
- Backup system must be available for rollback

## Task Execution

### 1. Workflow Analysis and Backup

- Load target workflow from `aios-core/workflows/{workflow-name}.yaml`
- Create timestamped backup: `aios-core/workflows/.backups/{workflow-name}.yaml.{timestamp}`
- Parse and analyze workflow structure:
  - Metadata (name, description, project type)
  - Phase definitions and sequences
  - Agent assignments per phase
  - Artifact definitions
  - Entry/exit criteria
  - Mermaid diagrams (if present)

### 2. Dependency and Impact Analysis

Analyze workflow connections:
- Which agents are orchestrated by this workflow
- What artifacts are produced/consumed
- Phase transition dependencies
- Integration with other workflows
- Project type compatibility

### 3. Modification Intent Processing

If user provides high-level intent (e.g., "add code review phase"):
- Analyze current phase flow
- Determine optimal insertion point
- Identify required agents for new phase
- Define artifacts for new phase
- Ensure phase transitions remain logical

If user provides specific changes:
- Validate YAML structure changes
- Ensure phase sequencing remains valid
- Check agent availability
- Verify artifact consistency
- Maintain entry/exit criteria logic

### 4. Phase Sequencing Validation

Ensure modifications maintain valid flow:
```yaml
phases:
  planning:
    sequence: 1
    agents: [analyst, pm]
    artifacts: [project-brief, prd]
    
  # New phase insertion
  architecture_review:  # NEW
    sequence: 1.5      # Inserted between planning and architecture
    agents: [architect, qa]
    artifacts: [architecture-review-doc]
    entry_criteria: ["PRD approved"]
    exit_criteria: ["Architecture review complete"]
    
  architecture:
    sequence: 2  # Adjusted from 2
    agents: [architect]
    artifacts: [architecture-doc]
```

### 5. Mermaid Diagram Update

If workflow contains visualization:
```mermaid
graph TD
    A[Planning] --> AR[Architecture Review]  %% NEW
    AR --> B[Architecture]
    B --> C[Development]
```

Update diagram to reflect new phases and transitions.

### 6. Generate Modification Diff

Create comprehensive diff:
```diff
@@ Workflow: {workflow-name} @@
--- Current Version
+++ Modified Version

@@ Metadata @@
  name: {workflow-name}
  description: {description}
+ last_modified: {timestamp}
+ modified_by: aios-developer

@@ Phases @@
  planning:
    sequence: 1
    agents: [analyst, pm]
    
+ code_review:
+   sequence: 3.5
+   agents: [qa, senior-dev]
+   artifacts: [code-review-report]
+   entry_criteria:
+     - "Development phase complete"
+     - "All tests passing"
+   exit_criteria:
+     - "Code review approved"
+     - "No critical issues"

@@ Simple Sequence @@
- "planning → architecture → development → testing"
+ "planning → architecture → development → code_review → testing"
```

### 7. Validation Pipeline

Comprehensive validation checks:
- YAML syntax validation
- Phase sequence continuity (no gaps)
- Agent existence verification
- Artifact definition completeness
- Entry/exit criteria logic
- Circular dependency detection
- Mermaid diagram syntax (if present)

### 8. Workflow Simulation

Simulate the modified workflow:
```
Phase Flow Simulation:
1. Planning (analyst, pm) → project-brief, prd ✓
2. Architecture Review (architect, qa) → review-doc ✓
3. Architecture (architect) → architecture-doc ✓
4. Development (dev) → code, tests ✓
5. Code Review (qa) → review-report ✓
6. Testing (qa) → test-results ✓

All phase transitions valid ✓
All agents available ✓
No circular dependencies ✓
```

### 9. User Approval Flow

Present comprehensive report:
1. Summary of changes
2. Visual diff of YAML
3. Updated phase flow diagram
4. Impact analysis:
   - New phases added
   - Agent workload changes
   - Artifact additions
   - Timeline implications
5. Simulation results

Request explicit approval before applying changes.

### 10. Apply Modifications

Upon approval:
1. Write modified YAML to workflow file
2. Update Mermaid diagrams if present
3. Create git commit with descriptive message
4. Update workflow documentation
5. Notify orchestrator of changes
6. Log modification in history

### 11. Post-Modification Validation

Verify workflow functionality:
- Load modified workflow in orchestrator
- Validate all phases resolve correctly
- Check agent assignments are valid
- Ensure artifacts are properly defined
- Test phase transition logic

### 12. Rollback Capability

If issues detected:
1. Restore from timestamped backup
2. Revert git commit
3. Refresh orchestrator cache
4. Log rollback with reason

## Safety Measures

1. **Phase Continuity**: Never break phase sequences
2. **Agent Availability**: Verify all agents exist
3. **Artifact Consistency**: Maintain input/output flow
4. **Transition Logic**: Preserve entry/exit criteria
5. **Backward Compatibility**: Ensure existing projects can use modified workflow

## Output Format

```
=== Workflow Modification Report ===
Workflow: {workflow-name}
Timestamp: {ISO-8601 timestamp}
Backup: {backup-file-path}

Structure Analysis:
- Current phases: {phase-count}
- Current agents: {agent-list}
- Current artifacts: {artifact-count}

Changes Applied:
✓ Added phase: {phase-name} at position {sequence}
✓ Modified {n} phase sequences
✓ Added {n} new artifacts
✓ Updated {n} agent assignments
✓ Enhanced phase transitions

Validation Results:
✓ YAML syntax valid
✓ Phase sequence continuous
✓ All agents exist
✓ Artifacts properly defined
✓ No circular dependencies
✓ Mermaid diagram updated
✓ Git commit created: {commit-hash}

Simulation Results:
✓ All phases executable
✓ Agent assignments valid
✓ Artifact flow consistent
✓ Transitions logical

Impact Summary:
- Estimated timeline change: +{n} days
- New agent workload: {agent}: +{n} phases
- New artifacts produced: {artifact-list}

Workflow ready for use with enhanced orchestration.
```

## Error Handling

- Workflow not found → Verify name and path
- Invalid YAML → Show syntax error with line
- Phase sequence gaps → Highlight missing sequences
- Missing agents → List unavailable agents
- Circular dependencies → Show dependency cycle
- Mermaid errors → Provide diagram syntax fix

## Integration Points

- Uses `yaml-validator.js` for syntax checking
- Integrates with `git-wrapper.js` for version control
- Coordinates with orchestrator for validation
- Leverages `dependency-analyzer.js` for impact analysis 