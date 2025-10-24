# Create Workflow

## Purpose
To create a new workflow definition that orchestrates multiple agents and tasks for complex multi-step processes in AIOS-FULLSTACK.

## Prerequisites
- User authorization verified
- Clear understanding of workflow goals
- Knowledge of participating agents and tasks
- Memory layer client initialized

## Interactive Elicitation Process

### Step 1: Workflow Overview
```
ELICIT: Workflow Basic Information
1. What is the workflow name? (e.g., "feature-development", "bug-fix")
2. What is the primary goal of this workflow?
3. What type of project is this for? (greenfield/brownfield, UI/service/fullstack)
4. What is the expected outcome?
```

### Step 2: Workflow Stages
```
ELICIT: Workflow Stages and Flow
1. What are the main stages/phases? (e.g., "planning", "implementation", "testing")
2. What is the sequence of these stages?
3. Are there any parallel activities?
4. Are there decision points or conditional flows?
5. What are the exit criteria for each stage?
```

### Step 3: Agent Orchestration
```
ELICIT: Agent Participation
For each stage:
1. Which agent(s) are involved?
2. What are their specific responsibilities?
3. How do agents hand off work between stages?
4. Are there any approval requirements?
```

### Step 4: Resource Requirements
```
ELICIT: Resources and Dependencies
1. What templates are needed?
2. What data files are required?
3. Are there external dependencies?
4. What are the input requirements?
5. What outputs are produced?
```

## Implementation Steps

1. **Validate Workflow Design**
   - Check for circular dependencies
   - Validate agent availability
   - Ensure logical flow progression
   - Verify all resources exist

2. **Generate Workflow Structure**
   ```yaml
   workflow:
     id: {workflow-name}
     name: {Workflow Display Name}
     description: {Purpose and overview}
     type: {greenfield|brownfield}
     scope: {ui|service|fullstack}
     
   stages:
     - id: stage-1
       name: {Stage Name}
       agent: {agent-id}
       tasks:
         - {task-name}
       outputs:
         - {output-description}
       next: stage-2
       
   transitions:
     - from: stage-1
       to: stage-2
       condition: {optional condition}
       
   resources:
     templates:
       - {template-name}
     data:
       - {data-file}
       
   validation:
     checkpoints:
       - stage: {stage-id}
         criteria: {validation-criteria}
   ```

3. **Add Security Controls**
   - Stage authorization requirements
   - Data access restrictions
   - Audit logging points
   - Approval workflows

4. **Create Workflow File**
   - Generate path: `{root}/workflows/{workflow-name}.yaml`
   - Write structured YAML definition
   - Include comprehensive documentation

5. **Update Memory Layer**
   ```javascript
   await memoryClient.addMemory({
     type: 'workflow_created',
     name: workflowName,
     path: workflowPath,
     creator: currentUser,
     timestamp: new Date().toISOString(),
     metadata: {
       type: workflowType,
       stages: stageList,
       agents: involvedAgents
     }
   });
   ```

6. **Generate Documentation**
   - Create workflow diagram (text-based)
   - Document each stage's purpose
   - List all handoff points
   - Include troubleshooting guide

## Validation Checklist
- [ ] Workflow name is unique and valid
- [ ] All stages have clear purposes
- [ ] Agent assignments are valid
- [ ] No circular dependencies
- [ ] All resources exist
- [ ] Transitions are logical
- [ ] Security controls defined
- [ ] Memory layer updated

## Error Handling
- If workflow exists: Offer versioning or update
- If agents missing: List required agents
- If circular dependency: Show cycle and suggest fix
- If resources missing: List and offer to create

## Success Output
```
✅ Workflow '{workflow-name}' created successfully!
📁 Location: {root}/workflows/{workflow-name}.yaml
📊 Workflow Summary:
   - Stages: {stage-count}
   - Agents: {agent-list}
   - Type: {workflow-type}
🚀 To use: Select workflow when starting new project
```

## Workflow Execution Notes
- Workflows are selected during project initialization
- Each stage execution is logged in memory
- Progress tracking available through memory queries
- Agents automatically receive stage-specific context 