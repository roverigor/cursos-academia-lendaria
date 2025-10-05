# /modify-task Task

When this command is used, execute the following task:

# Modify Task Task

## Purpose

To safely modify existing task definitions while maintaining their effectiveness, preserving elicitation flows, and ensuring backward compatibility. This task enables evolution of task capabilities through intelligent modifications with comprehensive validation.

## Prerequisites

- Target task must exist in `aios-core/tasks/`
- User must provide modification intent or specific changes
- Backup system must be available for rollback
- Understanding of task dependencies and usage

## Task Execution

### 1. Task Analysis and Backup

- Load target task from `aios-core/tasks/{task-name}.md`
- Create timestamped backup: `aios-core/tasks/.backups/{task-name}.md.{timestamp}`
- Analyze task structure:
  - Purpose and prerequisites
  - Task execution steps
  - Elicitation requirements (if any)
  - Integration points
  - Output format specifications

### 2. Usage Impact Analysis

Before modifying, analyze where task is used:
- Search all agents for task dependencies
- Check workflows that reference the task
- Identify any tasks that chain into this task
- Document all usage points for impact assessment

### 3. Modification Intent Processing

If user provides high-level intent (e.g., "add validation step"):
- Analyze current task flow
- Determine optimal insertion points
- Ensure modifications maintain task coherence
- Preserve existing functionality

If user provides specific changes:
- Validate changes don't break task flow
- Ensure elicitation blocks remain valid
- Check output format compatibility
- Verify integration points remain functional

### 4. Elicitation Flow Preservation

For tasks with `elicit: true`:
- Maintain `[[LLM:` instruction blocks
- Preserve user interaction points
- Ensure prompts remain clear and actionable
- Validate response processing logic

### 5. Generate Modification Diff

Create a visual diff showing:
```diff
@@ Task: {task-name} @@
--- Current Version
+++ Modified Version

@@ Purpose @@
- Old purpose description
+ Enhanced purpose with new capabilities

@@ Task Execution @@
  ### Step 1: Initial Setup
  - Existing step content
+ - New validation substep
  
  ### Step 2: Processing
  [Content remains unchanged]
  
+ ### Step 3: New Validation Step
+ - Validate inputs against schema
+ - Check for security concerns
+ - Ensure data integrity

@@ Output Format @@
  {
    "status": "success",
    "data": {...},
+   "validation": {
+     "passed": true,
+     "checks": [...]
+   }
  }
```

### 6. Validation Pipeline

Run comprehensive validation:
- Markdown syntax validation
- Task flow logical consistency
- Elicitation block format checking
- Output format JSON/YAML validation
- Integration point compatibility
- No breaking changes to task interface

### 7. Backward Compatibility Check

Ensure modifications maintain compatibility:
- Existing inputs still accepted
- Output format additions are optional
- Task can be called with old parameters
- Graceful handling of legacy usage

### 8. User Approval Flow

Present to user:
1. Summary of changes
2. Visual diff
3. Impact analysis:
   - Affected agents and workflows
   - New capabilities added
   - Compatibility notes
4. Migration guide for existing usage

Request explicit approval before applying changes.

### 9. Apply Modifications

Upon approval:
1. Write modified content to task file
2. Update task metadata if needed
3. Create git commit with descriptive message
4. Update dependent component documentation
5. Log modification in history

### 10. Post-Modification Testing

Create test scenarios:
```javascript
// Test basic functionality
const result = await executeTask('modified-task', originalParams);
assert(result.status === 'success');

// Test new functionality
const enhancedResult = await executeTask('modified-task', newParams);
assert(enhancedResult.validation.passed === true);

// Test backward compatibility
const legacyResult = await executeTask('modified-task', legacyParams);
assert(isCompatibleOutput(legacyResult));
```

### 11. Rollback Capability

If issues detected:
1. Restore from timestamped backup
2. Revert git commit
3. Notify affected components
4. Log rollback with reason

## Safety Measures

1. **Usage Analysis First**: Always check task usage before modifying
2. **Preserve Core Flow**: Never break existing task logic
3. **Elicitation Integrity**: Maintain interactive elements
4. **Test Coverage**: Ensure modifications are testable
5. **Documentation Sync**: Update task docs with changes

## Output Format

```
=== Task Modification Report ===
Task: {task-name}
Timestamp: {ISO-8601 timestamp}
Backup: {backup-file-path}

Usage Analysis:
- Used by {n} agents: {agent-list}
- Referenced in {n} workflows: {workflow-list}
- Chain dependencies: {dependency-list}

Changes Applied:
✓ Enhanced {section} with {feature}
✓ Added {n} new steps
✓ Updated output format
✓ Maintained backward compatibility

Validation Results:
✓ Task flow validated
✓ Elicitation blocks intact
✓ Output format valid
✓ No breaking changes
✓ Git commit created: {commit-hash}

Testing Results:
✓ Original functionality preserved
✓ New features operational
✓ Backward compatibility confirmed

Migration Notes:
- Existing usage remains functional
- New parameters available: {param-list}
- Enhanced output includes: {new-fields}

Task ready for use with enhanced capabilities.
```

## Error Handling

- Task not found → Verify task name and path
- Flow disruption → Show specific step conflicts
- Elicitation errors → Highlight format issues
- Compatibility breaks → Provide migration path
- Test failures → Show failing scenarios

## Integration Points

- Coordinates with agent modification tasks
- Uses `git-wrapper.js` for version control
- Leverages `dependency-analyzer.js` for usage
- Integrates with test frameworks for validation