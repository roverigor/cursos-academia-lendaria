# /modify-agent Task

When this command is used, execute the following task:

# Modify Agent Task

## Purpose

To safely modify existing agent definitions while preserving their structure, maintaining compatibility, and providing rollback capabilities. This task enables the meta-agent to evolve agent capabilities through targeted modifications with comprehensive validation.

## Prerequisites

- Target agent must exist in `aios-core/agents/`
- User must provide modification intent or specific changes
- Backup system must be available for rollback
- Git must be initialized for version tracking

## Task Execution

### 1. Agent Analysis and Backup

- Load target agent from `aios-core/agents/{agent-name}.md`
- Parse YAML header and markdown content separately
- Create timestamped backup: `aios-core/agents/.backups/{agent-name}.md.{timestamp}`
- Extract current structure:
  - Agent metadata (name, id, title, icon, whenToUse)
  - Dependencies (tasks, templates, checklists, data)
  - Commands and their descriptions
  - Persona configuration
  - Customization rules

### 2. Modification Intent Processing

If user provides high-level intent (e.g., "add memory integration capability"):
- Analyze current agent capabilities
- Determine required changes:
  - New dependencies to add
  - Commands to introduce
  - Persona adjustments needed
  - Documentation updates

If user provides specific changes:
- Validate change format and targets
- Check for conflicts with existing structure
- Ensure changes maintain agent consistency

### 3. Dependency Resolution

For new dependencies being added:
- Verify files exist in respective directories
- Check for circular dependencies
- Validate dependency compatibility
- Add dependencies in correct sections:
  - tasks → `dependencies.tasks`
  - templates → `dependencies.templates`
  - checklists → `dependencies.checklists`
  - data → `dependencies.data`

### 4. Generate Modification Diff

Create a visual diff showing:
```diff
@@ Agent: {agent-name} @@
--- Current Version
+++ Modified Version

@@ Dependencies @@
  tasks:
    - existing-task.md
+   - new-capability-task.md
    
@@ Commands @@
  - help: Show available commands
+ - new-command: Description of new capability

@@ Persona @@
  role: Current role description
- focus: Old focus area
+ focus: Updated focus area with new capabilities
```

### 5. Validation Pipeline

Run comprehensive validation checks:
- YAML syntax validation
- Markdown structure integrity
- Dependency existence verification
- Command format validation
- No breaking changes to existing commands
- Customization rules compatibility

### 6. User Approval Flow

Present to user:
1. Summary of changes
2. Visual diff
3. Impact analysis:
   - New capabilities added
   - Potential conflicts
   - Dependencies introduced
4. Rollback instructions

Request explicit approval before applying changes.

### 7. Apply Modifications

Upon approval:
1. Write modified content to agent file
2. Update component metadata registry
3. Create git commit with descriptive message
4. Log modification in history
5. Update any dependent components

### 8. Post-Modification Validation

- Test agent loading
- Verify all dependencies resolve
- Check command accessibility
- Validate persona consistency
- Run basic agent interaction test

### 9. Rollback Capability

If issues detected or user requests rollback:
1. Restore from timestamped backup
2. Revert git commit
3. Update metadata registry
4. Log rollback action

## Safety Measures

1. **Backup Before Modify**: Always create backup before changes
2. **Validation First**: Never apply unvalidated modifications
3. **User Approval**: Require explicit approval for all changes
4. **Atomic Operations**: All-or-nothing modification approach
5. **Git Integration**: Every change tracked in version control

## Output Format

```
=== Agent Modification Report ===
Agent: {agent-name}
Timestamp: {ISO-8601 timestamp}
Backup: {backup-file-path}

Changes Applied:
✓ Added {n} new dependencies
✓ Modified {n} commands
✓ Updated persona configuration
✓ Enhanced capabilities for {feature}

Validation Results:
✓ YAML syntax valid
✓ All dependencies exist
✓ No breaking changes
✓ Git commit created: {commit-hash}

New Capabilities:
- {capability-1}
- {capability-2}

Agent ready for use with enhanced capabilities.
```

## Error Handling

- File not found → Check agent name and path
- Invalid YAML → Show syntax error location
- Missing dependencies → List unavailable files
- Git errors → Provide manual recovery steps
- Validation failures → Show specific issues

## Integration Points

- Uses `component-metadata.js` for registry updates
- Integrates with `git-wrapper.js` for version control
- Leverages `yaml-validator.js` for syntax checking
- Coordinates with `rollback-handler.js` for recovery