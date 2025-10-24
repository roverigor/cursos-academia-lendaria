# Create Task

## Purpose
To create a new task file that defines executable workflows for agents, with proper structure, elicitation steps, and validation.

## Prerequisites
- User authorization verified
- Task purpose clearly defined
- Understanding of task workflow requirements

## Interactive Elicitation Process

### Step 1: Task Definition
```
ELICIT: Task Basic Information
1. What is the task name? (e.g., "validate-api", "generate-report")
2. What is the primary purpose of this task?
3. What agent(s) will use this task?
4. What are the prerequisites for running this task?
```

### Step 2: Task Workflow
```
ELICIT: Task Workflow Steps
1. Does this task require user interaction? (yes/no)
2. What are the main steps in this task? (numbered list)
3. What inputs does the task need?
4. What outputs does the task produce?
5. Are there decision points requiring user input?
```

### Step 3: Elicitation Requirements
```
ELICIT: Interactive Elements (if applicable)
1. What information needs to be collected from users?
2. How should prompts be structured?
3. What validation is needed for user inputs?
4. Are there default values or suggestions?
```

### Step 4: Dependencies and Integration
```
ELICIT: Task Dependencies
1. Does this task depend on other tasks?
2. What templates does it use (if any)?
3. Does it need memory layer access?
4. What files/resources does it need to access?
```

## Implementation Steps

1. **Validate Task Name**
   - Check name doesn't already exist
   - Validate format (lowercase, hyphens)
   - Ensure descriptive and clear naming

2. **Structure Task Content**
   ```markdown
   # {Task Title}
   
   ## Purpose
   {Clear description of what the task accomplishes}
   
   ## Prerequisites
   {List of requirements before task execution}
   
   ## Interactive Elicitation Process
   {If elicit=true, define all prompts and user interactions}
   
   ## Implementation Steps
   {Numbered steps for task execution}
   
   ## Validation Checklist
   {Checklist items to verify task completion}
   
   ## Error Handling
   {How to handle common errors}
   
   ## Success Output
   {What user sees on successful completion}
   ```

3. **Add Security Considerations**
   - Input validation rules
   - File access restrictions
   - Safe command execution
   - Output sanitization

4. **Create Task File**
   - Generate path: `{root}/tasks/{task-name}.md`
   - Write formatted task definition
   - Ensure proper markdown structure

5. **Update Memory Layer**
   ```javascript
   await memoryClient.addMemory({
     type: 'task_created',
     name: taskName,
     path: taskPath,
     creator: currentUser,
     timestamp: new Date().toISOString(),
     metadata: {
       purpose: taskPurpose,
       agents: associatedAgents,
       interactive: hasElicitation
     }
   });
   ```

6. **Generate Usage Examples**
   - Show how to reference in agent files
   - Provide command examples
   - Document expected outputs

## Validation Checklist
- [ ] Task name is unique and valid
- [ ] Purpose clearly stated
- [ ] Steps are numbered and clear
- [ ] Elicitation prompts well-defined
- [ ] Error handling included
- [ ] Success criteria defined
- [ ] Memory layer updated

## Error Handling
- If task exists: Offer to update or create variant
- If validation fails: Show specific issues
- If dependencies missing: List required files
- If write fails: Check permissions

## Success Output
```
✅ Task '{task-name}' created successfully!
📁 Location: {root}/tasks/{task-name}.md
📝 Integration example:
   dependencies:
     tasks:
       - {task-name}.md
🔗 Agents using this task: {agent-list}
``` 