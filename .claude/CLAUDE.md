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

## Working with Alan - Core Principles

### Priority Check Framework

```python
def validate_before_action():
    # Check against Technical Philosophy (see below)
    # Check against Anti-Patterns (see below)
    # If any violation: STOP and present options
    return "PROCEED" or "SHOW_OPTIONS"
```

### Communication Protocol

**Executive Summary Pattern:**
- Start with 2-4 sentence summary
- Details available below if needed
- No fluff or unnecessary context

**Interaction Rules:**
- Map context BEFORE executing ("where is this defined?")
- Present 2-3 options with tradeoffs, let Alan decide
- English for code/comments, PT-BR for discussion when appropriate
- No emojis unless Alan uses them first
- Adapt immediately when Alan pivots (don't continue old task)

### Workflow Execution

**Before Implementation:**
1. Show structure/flow first
2. Ask: "Where should this live?"
3. Present: "Which approach fits your workflow?"
4. Validate: "Does this match your actual scenario?"

**During Development:**
- Strategic checkpoints: "Where are we? What's next?"
- Incremental validation: Prove with 1 example before scaling
- Show working demo before continuing
- Fail fast: Hours/days iteration, not weeks/months

### Technical Philosophy

```yaml
architecture:
  data_location: database  # not files for structured data
  configuration: YAML/JSON  # not hardcoded
  integration: connected    # no isolated systems
  validation: real_data    # not lorem ipsum
  documentation: after_proof  # not before

principles:
  language: English  # all code, variables, functions, comments
  reusability: DRY  # extract once, use N times
  scope: clear_boundaries  # lite vs pro features
  flexibility: config_over_code  # change without recompiling
```

### Anti-Patterns to Avoid

```python
REJECT = [
    "ceremony_blocking_mvp",
    "vanity_metrics",
    "isolated_systems",
    "fake_test_data",
    "rigid_automations",
    "implementing_without_context",
    "verbose_without_summary",
    "hardcoded_values",
    "theoretical_validation",
    "ignoring_pivot"
]
```

## Development Methodology

### Story-Driven Development
1. **Work from stories** - All development starts with a story in `docs/stories/`
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
- Test edge cases and real scenarios
- Document test scenarios in story files

## AIOS Framework Structure

```
.aios-core/
├── agents/         # Agent persona definitions (YAML/Markdown)
├── tasks/          # Executable task workflows
├── workflows/      # Multi-step workflow definitions
├── templates/      # Document and code templates
├── checklists/     # Validation and review checklists
├── tools/          # MCP tools, CLI tools, local tools
└── rules/          # Framework rules and patterns

docs/                       # 📚 All documentation (versioned)
├── README.md               # Master documentation navigation
├── prd/                    # Product requirement documents
├── methodology/            # Process frameworks and methodologies
├── guides/                 # User and developer guides
├── architecture/           # System architecture documentation
├── stories/                # Development stories
├── logs/                   # Execution logs (versioned, not outputs!)
└── mmos/                   # MMOS-specific documentation

outputs/                    # 🎯 Generated artifacts (NOT versioned)
├── courses/                # Generated courses (CreatorOS)
├── minds/                  # Processed minds (MMOS Mind Mapper)
└── database/               # SQLite database files

expansion-packs/            # 🔌 Modular system extensions
├── creator-os/             # Course generation system
├── mmos/                   # Cognitive clone creation
├── innerlens/              # Psychometric profiling
└── etl-data-collector/     # Data collection tools
```

### Framework vs Project Separation

**CRITICAL: Never modify `.aios-core/` - it's the AIOS framework base**

- `.aios-core/` = Framework (read-only, never touch)
- `expansion-packs/` = Project extensions (your custom code)
- `docs/` = Project documentation
- `outputs/` = Generated artifacts

### Expansion Pack Sync Architecture

**IMPORTANT: `.claude/commands/` is auto-generated - DO NOT edit directly**

```
expansion-packs/{pack-name}/     # 🎯 SOURCE OF TRUTH
.claude/commands/{PackName}/     # 🔄 AUTO-SYNCED (read-only)
```

**Pre-commit Hook** (`.aios-core/hooks/pre-commit-sync.sh`):
- Automatically runs on every `git commit`
- Syncs content from `expansion-packs/` → `.claude/commands/`
- Creates both `.md` and `.mdc` versions

**Development Workflow:**
1. Edit source in `expansion-packs/`
2. Commit (auto-sync happens)
3. Never edit `.claude/commands/` directly

## Best Practices

### Version Control
- **Use Git for versioning** - Never create multiple backup files (e.g., CLAUDE-backup.md)
- **Commit before major changes** - Create checkpoint commits before refactoring
- **Clean working directory** - No temporary or backup files, Git handles history
- **Meaningful commits** - Clear messages about what changed and why

### When implementing features:
- Check existing patterns first
- Reuse components and utilities
- Follow naming conventions
- Keep functions focused and testable

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
- Batch tool calls when possible for better performance
- Use parallel execution for independent operations
- Cache frequently accessed data in memory during sessions

### Tool Usage Guidelines
- Always use the Grep tool for searching, never `grep` or `rg` in bash
- Use the Task tool for complex multi-step operations
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

### Decision Rule:

Ask: **"Is this about a SPECIFIC mind?"**
- **YES** → `outputs/minds/{mind_slug}/`
- **NO** → Continue...

Ask: **"Is it a script/template for MMOS?"**
- **YES** → `expansion-packs/mmos/`
- **NO** → Continue...

Ask: **"Is it about MMOS system/process?"**
- **YES** → `docs/mmos/`
- **NO** → Continue...

Ask: **"Is it a methodology/framework?"**
- **YES** → `docs/methodology/`
- **NO** → Continue...

Ask: **"Is it a user/developer guide?"**
- **YES** → `docs/guides/`
- **NO** → ⚠️ STOP - Review architecture rules

### Enforcement:

Pre-commit hook will automatically reject architectural violations.
Run manually: `.aios-core/hooks/pre-commit-mmos-guard.sh`

---

## Quick Reference: Where Files Go

| File Type | Location | Example |
|-----------|----------|---------|
| Product requirements | `docs/prd/` | `mmos-prd.md` |
| Methodologies | `docs/methodology/` | `dna-mental.md` |
| User guides | `docs/guides/` | `outputs-guide.md` |
| Architecture docs | `docs/architecture/` | `system-design.md` |
| Development stories | `docs/stories/` | `story-2.1.md` |
| Execution logs | `docs/logs/` | `2025-10-17-session.md` |
| MMOS workflows | `docs/mmos/workflows/` | `brownfield-workflow.md` |
| MMOS epics | `docs/mmos/epics/` | `epic-2-database.md` |
| MMOS reports | `docs/mmos/reports/` | `executive-summary.md` |
| Mind-specific docs | `outputs/minds/{slug}/docs/` | `validation-checklist.md` |
| Generated courses | `outputs/courses/{slug}/` | `curriculum.yaml` |
| Database files | `outputs/database/` | `minds.db` |
| MMOS scripts | `expansion-packs/mmos/` | `pipeline.py` |

---

**Meta-rule:** These rules should be economical. If anything becomes ceremony, delete it.

---
*AIOS-FULLSTACK Claude Code Configuration v4.0*
*Last Updated: 2025-10-30 - Consolidated to remove all redundancies*