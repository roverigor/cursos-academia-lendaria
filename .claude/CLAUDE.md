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
│   └── mmos-prd.md
├── methodology/            # Process frameworks and methodologies
│   ├── dna-mental.md
│   ├── prompt-engineering.md
│   ├── tools-guide.md
│   └── mmos-templates/
├── guides/                 # User and developer guides
│   ├── folder-structure.md
│   ├── outputs-guide.md
│   ├── integration-etl-mmos.md
│   └── mmos-stage-guides/
├── architecture/           # System architecture documentation
├── stories/                # Development stories
│   └── mmos-legacy/        # Historical MMOS stories
├── logs/                   # Execution logs (versioned, not outputs!)
│   └── YYYY-MM-DD-*.md
└── mmos/                   # MMOS-specific documentation
    ├── workflows/          # Step-by-step workflows
    ├── epics/              # MMOS development epics
    ├── stories/            # MMOS stories
    ├── reports/            # Executive reports
    ├── qa/                 # Quality assurance
    └── taxonomy/           # Trait taxonomies

outputs/                    # 🎯 Generated artifacts (NOT versioned)
├── courses/                # Generated courses (CreatorOS)
├── minds/                  # Processed minds (MMOS Mind Mapper)
└── database/               # SQLite database files
    └── SQLite legado (migrado para Supabase em 2025-10)

expansion-packs/            # 🔌 Modular system extensions
├── creator-os/             # Course generation system
├── mmos/       # Cognitive clone creation
├── innerlens/              # Psychometric profiling
└── etl-data-collector/     # Data collection tools
```

### Framework vs Project Separation

**CRITICAL: Never modify `.aios-core/` - it's the AIOS framework base**

- `.aios-core/` = Framework (read-only, never touch)
- `expansion-packs/` = Project extensions (your custom code)
- `docs/` = Project documentation
- `outputs/` = Generated artifacts

All project-specific code, configuration, and utilities must go in `expansion-packs/` or `docs/`, never in `.aios-core/`.

### Expansion Pack Sync Architecture

**IMPORTANT: `.claude/commands/` is auto-generated - DO NOT edit directly**

The AIOS system maintains two parallel structures for expansion pack content:

```
expansion-packs/{pack-name}/     # 🎯 SOURCE OF TRUTH
├── agents/                      # Agent definitions (YAML)
├── tasks/                       # Task workflows (Markdown)
├── templates/                   # Document templates
├── checklists/                  # Validation checklists
└── workflows/                   # Multi-step workflows

.claude/commands/{PackName}/     # 🔄 AUTO-SYNCED (read-only)
├── agents/                      # ← synced from expansion-packs
├── tasks/                       # ← synced from expansion-packs
├── templates/                   # ← synced from expansion-packs
└── checklists/                  # ← synced from expansion-packs
```

#### Why This Duplication Exists

1. **Claude Code Integration**: `.claude/commands/` is where Claude Code discovers slash commands and agents
2. **Modular Development**: `expansion-packs/` keeps each system's code isolated and maintainable
3. **IDE Support**: Allows both `.mdc` (Claude) and `.md` (standard) formats to coexist
4. **Version Control**: Only `expansion-packs/` is the source of truth for git

#### How Sync Works

**Pre-commit Hook** (`.aios-core/hooks/pre-commit-sync.sh`):
- Automatically runs on every `git commit`
- Syncs content from `expansion-packs/` → `.claude/commands/`
- Creates both `.md` and `.mdc` versions
- Logs sync operations to `.aios-sync.log`

**What Gets Synced:**
- ✅ `agents/*.md` → `.claude/commands/{Pack}/agents/*.{md,mdc}`
- ✅ `tasks/*.md` → `.claude/commands/{Pack}/tasks/*.{md,mdc}`
- ✅ `templates/*.md` → `.claude/commands/{Pack}/templates/*.{md,mdc}`
- ✅ `checklists/*.md` → `.claude/commands/{Pack}/checklists/*.{md,mdc}`
- ✅ `workflows/*.yaml` → `.claude/commands/{Pack}/workflows/*.{yaml,mdc}`

#### Development Workflow

**✅ CORRECT:**
```bash
# 1. Edit source in expansion-packs
vim expansion-packs/creator-os/tasks/new-task.md

# 2. Commit (auto-sync happens)
git add expansion-packs/creator-os/tasks/new-task.md
git commit -m "feat(creator-os): add new task"

# 3. Sync runs automatically, updates .claude/commands/
# 4. Both files committed together
```

**❌ WRONG:**
```bash
# DON'T edit .claude/commands/ directly
vim .claude/commands/CreatorOS/tasks/new-task.md  # ❌

# Changes will be OVERWRITTEN on next sync!
```

#### Backup Files (.bak)

During sync, `.bak` files are created temporarily:
- `.claude/commands/{Pack}/tasks/example.md.bak`
- These are safe to delete (not needed after successful sync)
- Consider adding `*.bak` to `.gitignore`

#### Manual Sync

If needed, you can manually trigger sync:
```bash
.aios-core/hooks/pre-commit-sync.sh
```

#### Key Rules

1. **NEVER modify `.claude/commands/` directly** - changes will be lost
2. **ALWAYS edit `expansion-packs/`** - it's the source of truth
3. **Let the pre-commit hook handle sync** - it's automatic
4. **Review `.aios-sync.log`** if sync issues occur

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

## Token Estimation & Resource Planning

For complex multi-step operations, expansion pack pipelines, and resource-intensive workflows, token estimation is critical to prevent context overflow.

**Full guide:** See `docs/guides/token-estimation-guide.md` for:
- When estimation is required vs when to skip
- Standardized presentation format
- Token calculation formulas
- Mitigation strategies (continue/subagent/new window)
- Implementation requirements for expansion pack agents
- Task metadata requirements
- Detailed examples

**Quick reference:**
- Multi-step operations (>3 steps): Estimate required
- Large operations (>70% projected usage): Use Task/subagent recommended
- Critical operations (>85% projected usage): Must use subagent or new window

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
- `workflows/` - MMOS workflow documentation (step-by-step processes)
- `architecture/` - MMOS system architecture
- `design/` - MMOS design documentation
- `epics/` - MMOS development epics
- `stories/` - MMOS development stories
- `reports/` - Executive reports, version comparisons
- `qa/benchmarks/` - Cross-mind benchmarks
- `taxonomy/` - Trait and personality taxonomies
- `validations/` - System-level validation checklists

#### ✅ What BELONGS in docs/ (root categories):
- `prd/` - Product requirements (mmos-prd.md, etc.)
- `methodology/` - Methodologies and frameworks (dna-mental.md, etc.)
- `guides/` - User/developer guides (outputs-guide.md, etc.)
- `architecture/` - General system architecture
- `logs/` - Execution logs (versioned documentation!)
- `stories/` - Development stories

#### ❌ What DOES NOT belong in docs/mmos/:
- **NEVER** create folders named after minds (`/joao_lozano/`, `/pedro_valerio/`)
- **NEVER** create `validations/` or `migrations/` subfolders with mind names
- Mind-specific documents → `outputs/minds/{slug}/docs/`

### Decision Rule:

Ask: **"Is this about a SPECIFIC mind (name appears in content)?"**
- **YES** → `outputs/minds/{mind_slug}/docs/` or `outputs/minds/{mind_slug}/logs/`
- **NO** → Continue...

Ask: **"Is it a script/template for MMOS?"**
- **YES** → `expansion-packs/mmos/`
- **NO** → Continue...

Ask: **"Is it about MMOS system/process?"**
- **YES** → `docs/mmos/{workflows|epics|stories|reports|qa}/`
- **NO** → Continue...

Ask: **"Is it a methodology/framework?"**
- **YES** → `docs/methodology/`
- **NO** → Continue...

Ask: **"Is it a user/developer guide?"**
- **YES** → `docs/guides/`
- **NO** → Continue...

Ask: **"Is it a product requirement?"**
- **YES** → `docs/prd/`
- **NO** → Continue...

Ask: **"Is it an execution log?"**
- **YES** → `docs/logs/` (versioned documentation!)
- **NO** → ⚠️ STOP - Review architecture rules

### Examples:

**✅ Correct:**
- `outputs/minds/joao_lozano/docs/validation-checklist.md` (mind-specific)
- `outputs/minds/pedro_valerio/docs/migration-progress.md` (mind-specific)
- `outputs/minds/pedro_valerio/logs/20251016-validation-session.md` (mind-specific log)
- `docs/mmos/reports/EXECUTIVE_SUMMARY_FOR_PO.md` (MMOS system-level)
- `docs/mmos/epics/epic-2-clone-auth.md` (MMOS system-level)
- `docs/mmos/workflows/brownfield-workflow.md` (MMOS workflow)
- `docs/prd/mmos-prd.md` (product requirement)
- `docs/methodology/dna-mental.md` (methodology)
- `docs/guides/outputs-guide.md` (user guide)
- `docs/logs/2025-10-17-docs-reorganization.md` (execution log - versioned!)
- `SQLite legado (migrado para Supabase em 2025-10)` (generated database)

**❌ Wrong:**
- `docs/mmos/validations/pedro-valerio-checklist.md` → Use `outputs/minds/pedro_valerio/docs/validation-checklist.md`
- `docs/mmos/migrations/joao-lozano-progress.md` → Use `outputs/minds/joao_lozano/docs/migration-progress.md`
- `expansion-packs/mmos/benchmarks/debate.yaml` → Use `docs/mmos/qa/benchmarks/debate.yaml`
- `docs/mmos/docs/PRD.md` → Use `docs/prd/mmos-prd.md`
- `docs/mmos/DNA_MENTAL.md` → Use `docs/methodology/dna-mental.md`
- `outputs/logs/session.md` → Use `docs/logs/2025-10-17-session.md` (logs are docs!)
- `docs/mmos/SQLite legado (migrado para Supabase em 2025-10)` → Use `SQLite legado (migrado para Supabase em 2025-10)`

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
| Database files | `outputs/database/` | `SQLite legado (migrado para Supabase em 2025-10)` |
| MMOS scripts | `expansion-packs/mmos/` | `pipeline.py` |

---
*AIOS-FULLSTACK Claude Code Configuration v2.3*
*Last Updated: 2025-10-23 - AIOS upstream sync (v4.31.0+main-8d5d3d2)*