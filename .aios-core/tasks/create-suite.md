# Task: Create Component Suite

**Agent:** aios-developer  
**Version:** 1.0  
**Command:** *create-suite

## Description
Creates multiple related components in a single batch operation with dependency resolution and transaction support.

## Context Required
- Project structure understanding
- Component relationships
- Existing components for dependency resolution

## Prerequisites
- aios-developer agent is active
- Template system is configured
- team-manifest.yaml exists

## Interactive Elicitation
1. Suite type selection (agent package, workflow suite, task collection, custom)
2. Component configuration based on suite type
3. Dependency validation
4. Preview of all components to be created
5. Confirmation before batch creation

## Workflow Steps

### 1. Suite Type Selection
- **Action:** Choose from predefined suite types or custom
- **Validation:** Ensure suite type is supported

### 2. Configure Components
- **Action:** Gather configuration for each component in suite
- **Validation:** Validate naming conventions and dependencies

### 3. Analyze Dependencies
- **Action:** Build dependency graph between components
- **Validation:** Check for circular dependencies

### 4. Preview Suite
- **Action:** Show preview of all components to be created
- **Validation:** User confirmation required

### 5. Create Components
- **Action:** Create components in dependency order
- **Validation:** Each component must be created successfully

### 6. Update Manifest
- **Action:** Update team-manifest.yaml with all new components
- **Validation:** Manifest must remain valid YAML

## Error Handling
- **Missing Dependencies:** Prompt to create or select existing
- **Name Conflicts:** Show existing components and suggest alternatives
- **Creation Failures:** Offer rollback of entire transaction
- **Manifest Errors:** Show diff and allow manual correction

## Output
- Success/failure status for each component
- Transaction ID for potential rollback
- Updated manifest with all new components
- Summary of created files and locations

## Security Considerations
- All generated code is validated by SecurityChecker
- File paths are sanitized to prevent traversal
- Transaction log is write-protected

## Notes
- Supports atomic creation (all or nothing)
- Transaction log enables rollback functionality
- Dependency resolution ensures correct creation order
- Preview functionality helps prevent mistakes 