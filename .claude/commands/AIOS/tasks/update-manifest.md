# /update-manifest Task

When this command is used, execute the following task:

# Update Manifest

## Purpose
To safely update team manifest files with new agent entries while maintaining YAML integrity and preventing corruption.

## Prerequisites
- User authorization verified
- Agent file already created
- Backup capability available
- YAML parser loaded

## Interactive Elicitation Process

### Step 1: Manifest Selection
```
ELICIT: Target Manifest
1. Which team manifest to update? 
   - team-all.yaml (all agents)
   - team-fullstack.yaml (full stack development)
   - team-no-ui.yaml (backend only)
   - team-ide-minimal.yaml (minimal IDE setup)
2. Is this the correct manifest for the agent's purpose?
```

### Step 2: Agent Categorization
```
ELICIT: Agent Classification
1. What category does this agent belong to?
   - development (coding, implementation)
   - planning (PM, PO, architecture)
   - quality (QA, testing, validation)
   - specialty (UX, data, security)
   - meta (framework, tooling)
2. What tags should be applied? (comma-separated)
3. Any special notes or restrictions?
```

### Step 3: Team Composition
```
ELICIT: Team Integration
1. Should this agent be included by default? (yes/no)
2. Are there any agent dependencies?
3. Should this replace an existing agent?
4. Any incompatible agents?
```

## Implementation Steps

1. **Backup Current Manifest**
   ```javascript
   const backupPath = `${manifestPath}.backup-${Date.now()}`;
   await fs.copy(manifestPath, backupPath);
   console.log(`✅ Backup created: ${backupPath}`);
   ```

2. **Load and Parse Manifest**
   ```javascript
   const manifestContent = await fs.readFile(manifestPath, 'utf8');
   const manifest = yaml.load(manifestContent);
   
   // Validate structure
   if (!manifest.team || !manifest.agents) {
     throw new Error('Invalid manifest structure');
   }
   ```

3. **Check for Duplicates**
   ```javascript
   const agentExists = manifest.agents.some(a => 
     a.id === agentId || a.file === agentFile
   );
   
   if (agentExists) {
     // Prompt: Update existing or create new entry?
   }
   ```

4. **Add Agent Entry**
   ```yaml
   agents:
     - id: {agent-id}
       file: agents/{agent-name}.md
       name: {Agent Display Name}
       category: {category}
       tags:
         - {tag1}
         - {tag2}
       whenToUse: {description}
       defaultIncluded: {true|false}
   ```

5. **Validate Updated Manifest**
   ```javascript
   // Validate YAML syntax
   try {
     yaml.load(yaml.dump(manifest));
   } catch (error) {
     console.error('❌ Invalid YAML generated');
     // Restore from backup
   }
   
   // Validate agent references
   for (const agent of manifest.agents) {
     const agentPath = path.join(root, agent.file);
     if (!await fs.exists(agentPath)) {
       console.warn(`⚠️ Agent file not found: ${agent.file}`);
     }
   }
   ```

6. **Write Updated Manifest**
   ```javascript
   const updatedYaml = yaml.dump(manifest, {
     indent: 2,
     lineWidth: -1,
     noRefs: true,
     sortKeys: false
   });
   
   await fs.writeFile(manifestPath, updatedYaml, 'utf8');
   ```

7. **Update Memory Layer**
   ```javascript
   await memoryClient.addMemory({
     type: 'manifest_updated',
     manifest: manifestName,
     action: 'agent_added',
     agent: agentId,
     backup: backupPath,
     timestamp: new Date().toISOString(),
     user: currentUser
   });
   ```

8. **Verify Manifest Integrity**
   - Attempt to load the updated manifest
   - Check all agent references are valid
   - Ensure no corruption occurred
   - Test with actual agent activation

## Validation Checklist
- [ ] Backup created successfully
- [ ] Manifest structure preserved
- [ ] No duplicate entries
- [ ] YAML syntax valid
- [ ] All agent files exist
- [ ] Memory layer updated
- [ ] Manifest loads correctly

## Error Handling
- If backup fails: Abort operation
- If parse fails: Show error, don't proceed
- If duplicate found: Offer options
- If write fails: Restore from backup
- If validation fails: Restore and report

## Rollback Procedure
```javascript
if (errorOccurred) {
  console.log('🔄 Rolling back changes...');
  try {
    await fs.copy(backupPath, manifestPath);
    
    // Verify rollback success
    const rolledBackContent = await fs.readFile(manifestPath, 'utf8');
    const rolledBackManifest = yaml.load(rolledBackContent);
    
    if (rolledBackManifest && rolledBackManifest.agents) {
      console.log('✅ Rollback complete - manifest restored');
    } else {
      console.error('❌ Rollback verification failed - manual intervention required');
      console.error(`Backup location: ${backupPath}`);
    }
  } catch (rollbackError) {
    console.error('❌ CRITICAL: Rollback failed!', rollbackError);
    console.error(`Manual restore required from: ${backupPath}`);
  }
}
```

## Success Output
```
✅ Manifest updated successfully!
📁 Manifest: {manifest-name}
🤖 Agent added: {agent-name}
📂 Backup saved: {backup-path}
🔍 Verification:
   - YAML syntax: ✓
   - Agent files: ✓
   - No duplicates: ✓
📝 Next steps:
   1. Test agent activation
   2. Verify team composition
   3. Commit changes
```

## Security Notes
- Always create backup before modification
- Validate all paths to prevent traversal
- Log all manifest changes
- Require authorization for manifest updates
- Keep audit trail of all modifications