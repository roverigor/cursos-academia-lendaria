# Create Agent Task

## Purpose
To create a new agent definition file following AIOS-FULLSTACK standards using the template system with progressive disclosure elicitation.

## Prerequisites
- User authorization verified
- Template system initialized
- Component generator available
- Memory layer client initialized

## Implementation Method
This task now uses the enhanced template system with progressive disclosure:

```javascript
const ComponentGenerator = require('../utils/component-generator');
const generator = new ComponentGenerator({
  rootPath: process.cwd()
});

// Generate agent using elicitation workflow
const result = await generator.generateComponent('agent', {
  saveSession: true,  // Save progress
  force: false        // Don't overwrite existing
});
```

## Interactive Elicitation Process
The elicitation workflow is now handled by `aios-core/elicitation/agent-elicitation.js` with:

1. **Basic Agent Information** - Name, title, icon, usage
2. **Agent Persona & Style** - Role, communication, identity, focus
3. **Agent Commands** - Standard and custom commands
4. **Dependencies & Resources** - Tasks, templates, checklists, tools
5. **Security & Access Control** - Permissions and logging
6. **Advanced Options** - Memory layer, principles, activation

### Progressive Disclosure Features:
- **Smart Defaults**: Auto-generates values based on previous answers
- **Contextual Help**: Shows help text for complex steps
- **Conditional Steps**: Shows/hides steps based on choices
- **Session Saving**: Can pause and resume creation
- **Validation**: Real-time input validation with security checks

## Implementation Steps

1. **Validate Inputs**
   - Check agent name doesn't already exist
   - Validate name format (lowercase, hyphens only)
   - Ensure no path traversal in name

2. **Generate Agent File**
   - Use standard agent template structure
   - Include all elicited information
   - Add security controls if specified
   - Include memory layer integration if needed

3. **Security Validation**
   - No eval() or dynamic code execution
   - Validate all YAML syntax
   - Check for malicious patterns
   - Sanitize all user inputs

4. **Create File**
   - Generate path: `{root}/agents/{agent-name}.md`
   - Write agent definition with proper formatting
   - Set appropriate file permissions

5. **Update Memory Layer**
   ```javascript
   await memoryClient.addMemory({
     type: 'agent_created',
     name: agentName,
     path: agentPath,
     creator: currentUser,
     timestamp: new Date().toISOString(),
     metadata: {
       role: agentRole,
       commands: agentCommands
     }
   });
   ```

6. **Post-Creation Tasks**
   - Prompt user to update team manifest
   - Suggest creating related task files
   - Document in project changelog

## Validation Checklist
- [ ] Agent name is unique and valid
- [ ] All required sections included
- [ ] YAML syntax is valid
- [ ] Security controls implemented
- [ ] No malicious patterns detected
- [ ] Memory layer updated
- [ ] File created successfully

## Error Handling
- If agent already exists: Prompt for different name or update existing
- If validation fails: Show specific errors and allow correction
- If file write fails: Check permissions and path
- If memory update fails: Log error but continue (non-blocking)

## Success Output
```
✅ Agent '{agent-name}' created successfully!
📁 Location: {root}/agents/{agent-name}.md
📝 Next steps:
   1. Run *update-manifest to add agent to team
   2. Test agent with /{agent-name} command
   3. Create any needed task dependencies
``` 