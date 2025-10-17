# AIOS-FULLSTACK Development Rules for Claude Code

You are working with AIOS-FULLSTACK, an AI-Orchestrated System for Full Stack Development.

## Core Framework Understanding

AIOS-FULLSTACK is a meta-framework that orchestrates AI agents to handle complex development workflows. Always recognize and work within this architecture.

## Agent System

### Agent Activation
- Agents are activated with @agent-name syntax: @dev, @qa, @architect, @pm, @po, @sm, @analyst
- The master agent is activated with @aios-master
- Agent commands use the * prefix: *help, *create-story, *task, *exit

### Agent Context
When an agent is active:
- Follow that agent's specific persona and expertise
- Use the agent's designated workflow patterns
- Maintain the agent's perspective throughout the interaction

## Development Methodology

### Story-Driven Development
1. **Work from stories** - All development starts with a story in `docs/stories/` (development stories)
2. **Update progress** - Mark checkboxes as tasks complete: [ ] → [x]
3. **Track changes** - Maintain the File List section in the story
4. **Follow criteria** - Implement exactly what the acceptance criteria specify

### Code Standards
- Write clean, self-documenting code
- Follow existing patterns in the codebase
- Include comprehensive error handling
- Add unit tests for all new functionality
- Use TypeScript/JavaScript best practices

### Testing Requirements
- Run all tests before marking tasks complete
- Ensure linting passes: `npm run lint`
- Verify type checking: `npm run typecheck`
- Add tests for new features
- Test edge cases and error scenarios

## AIOS Framework Structure

```
aios-core/
├── agents/         # Agent persona definitions (YAML/Markdown)
├── tasks/          # Executable task workflows
├── workflows/      # Multi-step workflow definitions
├── templates/      # Document and code templates
├── checklists/     # Validation and review checklists
└── rules/          # Framework rules and patterns

docs/
├── stories/        # Development stories
├── prd/            # Product requirement documents
├── architecture/   # System architecture documentation
├── guides/         # User and developer guides
└── mmos/           # MMOS system documentation

outputs/
├── courses/        # Generated courses (CreatorOS)
└── minds/          # Processed minds (MMOS Mind Mapper)
```

## Workflow Execution

### Task Execution Pattern
1. Read the complete task/workflow definition
2. Understand all elicitation points
3. Execute steps sequentially
4. Handle errors gracefully
5. Provide clear feedback

### Interactive Workflows
- Workflows with `elicit: true` require user input
- Present options clearly
- Validate user responses
- Provide helpful defaults

## Best Practices

### When implementing features:
- Check existing patterns first
- Reuse components and utilities
- Follow naming conventions
- Keep functions focused and testable
- Document complex logic

### When working with agents:
- Respect agent boundaries
- Use appropriate agent for each task
- Follow agent communication patterns
- Maintain agent context

### When handling errors:
```javascript
try {
  // Operation
} catch (error) {
  console.error(`Error in ${operation}:`, error);
  // Provide helpful error message
  throw new Error(`Failed to ${operation}: ${error.message}`);
}
```

## Git & GitHub Integration

### Commit Conventions
- Use conventional commits: `feat:`, `fix:`, `docs:`, `chore:`, etc.
- Reference story ID: `feat: implement IDE detection [Story 2.1]`
- Keep commits atomic and focused

### GitHub CLI Usage
- Ensure authenticated: `gh auth status`
- Use for PR creation: `gh pr create`
- Check org access: `gh api user/memberships`

## AIOS-Specific Patterns

### Working with Templates
```javascript
const template = await loadTemplate('template-name');
const rendered = await renderTemplate(template, context);
```

### Agent Command Handling
```javascript
if (command.startsWith('*')) {
  const agentCommand = command.substring(1);
  await executeAgentCommand(agentCommand, args);
}
```

### Story Updates
```javascript
// Update story progress
const story = await loadStory(storyId);
story.updateTask(taskId, { status: 'completed' });
await story.save();
```

## Environment Setup

### Required Tools
- Node.js 18+ 
- GitHub CLI
- Git
- Your preferred package manager (npm/yarn/pnpm)

### Configuration Files
- `.aios/config.yaml` - Framework configuration
- `.env` - Environment variables
- `aios.config.js` - Project-specific settings

## Common Commands

### AIOS Master Commands
- `*help` - Show available commands
- `*create-story` - Create new story
- `*task {name}` - Execute specific task
- `*workflow {name}` - Run workflow

### Development Commands
- `npm run dev` - Start development
- `npm test` - Run tests
- `npm run lint` - Check code style
- `npm run build` - Build project

## Debugging

### Enable Debug Mode
```bash
export AIOS_DEBUG=true
```

### View Agent Logs
```bash
tail -f .aios/logs/agent.log
```

### Trace Workflow Execution
```bash
npm run trace -- workflow-name
```

## Claude Code Specific Configuration

### Performance Optimization
- Prefer batched tool calls when possible for better performance
- Use parallel execution for independent operations
- Cache frequently accessed data in memory during sessions

### Tool Usage Guidelines
- Always use the Grep tool for searching, never `grep` or `rg` in bash
- Use the Task tool for complex multi-step operations
- Batch file reads/writes when processing multiple files
- Prefer editing existing files over creating new ones

### Session Management
- Track story progress throughout the session
- Update checkboxes immediately after completing tasks
- Maintain context of the current story being worked on
- Save important state before long-running operations

### Error Recovery
- Always provide recovery suggestions for failures
- Include error context in messages to user
- Suggest rollback procedures when appropriate
- Document any manual fixes required

### Testing Strategy
- Run tests incrementally during development
- Always verify lint and typecheck before marking complete
- Test edge cases for each new feature
- Document test scenarios in story files

### Documentation
- Update relevant docs when changing functionality
- Include code examples in documentation
- Keep README synchronized with actual behavior
- Document breaking changes prominently

## MMOS-Specific Rules

### CRITICAL: Use Architecture Guard Checklist

**Before creating ANY file in docs/mmos/ or outputs/minds/:**
→ Review `.aios-core/checklists/mmos-architecture-guard.md`

### outputs/minds/ Directory - OUTPUT ONLY

**CRITICAL:** `outputs/minds/` contains ONLY the direct output of the MMOS pipeline.

#### ✅ What BELONGS in outputs/minds/{mind_slug}/:
- `sources/` - Source materials collected
- `analysis/` - Phase 3 outputs (identity-core.yaml, cognitive-spec.yaml)
- `synthesis/` - Phase 4 outputs (frameworks.md, communication-style.md, etc.)
- `implementation/` - Phase 5 outputs (tools.md, system-prompt-generalista.md)
- `system_prompts/` - Final system prompts
- `kb/` - Knowledge base chunks
- `docs/` - **Mind-specific process docs** (validations, migrations, reports)
- `logs/` - **Mind-specific execution logs**

#### ❌ What DOES NOT belong in outputs/minds/:
- System-level documentation → `docs/mmos/`
- Cross-mind comparisons → `docs/mmos/reports/`
- MMOS process documentation → `docs/mmos/`

### docs/mmos/ Directory - SYSTEM ONLY

**CRITICAL:** `docs/mmos/` contains ONLY system-level MMOS content.

#### ✅ What BELONGS in docs/mmos/:
- `architecture/` - MMOS system architecture
- `docs/` - System documentation (PRD, workflows)
- `design/` - MMOS design documentation
- `epics/` - MMOS development epics
- `reports/` - Executive reports, version comparisons
- `qa/benchmarks/` - Cross-mind benchmarks
- `database/` - MMOS database files

#### ❌ What DOES NOT belong in docs/mmos/:
- **NEVER** create folders named after minds (`/joao_lozano/`, `/pedro_valerio/`)
- **NEVER** create `validations/` or `migrations/` subfolders with mind names
- Mind-specific documents → `outputs/minds/{slug}/docs/`

### Decision Rule:

Ask: **"Is this about a SPECIFIC mind (name appears in content)?"**
- **YES** → `outputs/minds/{mind_slug}/docs/` or `outputs/minds/{mind_slug}/logs/`
- **NO** → Is it a script/template?
  - **YES** → `expansion-packs/mmos-mind-mapper/`
  - **NO** → Is it about MMOS system?
    - **YES** → `docs/mmos/{appropriate-folder}/`
    - **NO** → ⚠️ STOP - Review architecture rules

### Examples:

**✅ Correct:**
- `outputs/minds/joao_lozano/docs/validation-checklist.md` (mind-specific)
- `outputs/minds/pedro_valerio/docs/migration-progress.md` (mind-specific)
- `outputs/minds/pedro_valerio/logs/20251016-validation-session.md` (mind-specific log)
- `docs/mmos/reports/EXECUTIVE_SUMMARY_FOR_PO.md` (system-level)
- `docs/mmos/epics/epic-2-clone-auth.md` (system-level)

**❌ Wrong:**
- `docs/mmos/validations/pedro-valerio-checklist.md` → Use `outputs/minds/pedro_valerio/docs/validation-checklist.md`
- `docs/mmos/migrations/joao-lozano-progress.md` → Use `outputs/minds/joao_lozano/docs/migration-progress.md`
- `expansion-packs/mmos-mind-mapper/benchmarks/debate.yaml` → Use `docs/mmos/qa/benchmarks/debate.yaml`

### Enforcement:

Pre-commit hook will automatically reject architectural violations.
Run manually: `.aios-core/hooks/pre-commit-mmos-guard.sh`

---
*AIOS-FULLSTACK Claude Code Configuration v2.1*