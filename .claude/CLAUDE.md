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
    └── mmos.db

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

### CRITICAL RULE: Pre-Execution Token Estimation

**BEFORE executing ANY multi-step operation (>2 sequential steps), TODO workflow, or expansion pack workflow, you MUST:**

1. **Calculate Token Estimate** - Break down into INPUT + PROCESSING + OUTPUT
2. **Present Estimate to User** - Use standardized format below
3. **Offer 3 Mitigation Paths** - Continue, subagent, or new window
4. **Wait for Explicit Confirmation** - User must choose option (1/2/3)

### When Estimation is Required

Estimate tokens for operations that meet ANY of these criteria:
- Multi-step workflow (3+ sequential steps)
- TODO list with multiple items
- Any command marked with `user-confirmation-required: true` in task metadata
- Operations that read/analyze >5 files
- Operations that generate >3 output files
- Web research with >3 queries
- Any expansion pack pipeline execution (*map, *new, *execute, etc.)

### Skip Estimation For

- Single-file reads (< 1K tokens)
- Simple grep/search operations
- Help commands (*help, *status, *list)
- Git operations (commit, push, status)
- Checkpoint-only operations

### Standardized Presentation Format

```
📊 ESTIMATIVA DE TOKENS: {operation_name}

INPUT (Leitura/Research):
  {item_1}:                ~{tokens}K tokens
  {item_2}:                ~{tokens}K tokens
  {item_3}:                ~{tokens}K tokens
  ─────────────────────────────────────────────────────────
  TOTAL INPUT:             ~{total}K tokens

PROCESSING (Análise/Síntese):
  {processing_1}:          ~{tokens}K tokens
  {processing_2}:          ~{tokens}K tokens
  ─────────────────────────────────────────────────────────
  TOTAL PROCESSING:        ~{total}K tokens

OUTPUT (Geração):
  {output_1}:              ~{tokens}K tokens
  {output_2}:              ~{tokens}K tokens
  ─────────────────────────────────────────────────────────
  TOTAL OUTPUT:            ~{total}K tokens

───────────────────────────────────────────────────────────
TOTAL ESTIMADO:            ~{grand_total}K tokens

Estado Projetado:
  Atual:  {current}K tokens ({current_pct}%)
  Após:   {after}K tokens ({after_pct}%)
  Livre:  {remaining}K tokens ({remaining_pct}% buffer)

Status: {status_indicator}

OPÇÕES:
1. Continuar nesta janela
   • Usa contexto atual
   • {risk_description}

2. Task/Subagent (contexto isolado) [RECOMENDADO se >70%]
   • Contexto separado (não soma ao atual)
   • Retorna apenas resultado final (~{reduced}K tokens)
   • Redução: {savings_pct}% de economia de contexto

3. Prompt para nova janela (fresh start)
   • Zero impacto no contexto atual
   • Documentação completa será fornecida
   • Copie e execute em nova janela ou após /clear

{agent_custom_option}

Sua escolha (1/2/3{/4})?
```

### Status Indicators

Use these indicators based on projected context usage:

- **✅ SEGURO** - Projected usage <70% of window
  - Safe to continue in current window
  - Mention option 2 as alternative for context savings

- **⚠️ APERTADO MAS VIÁVEL** - Projected usage 70-85% of window
  - Can continue but tight
  - **STRONGLY RECOMMEND option 2** (subagent)
  - Explain risks of continuing in current window

- **🚨 RISCO DE ESTOURO** - Projected usage >85% of window
  - **BLOCK option 1** (mark as unavailable)
  - **REQUIRE option 2 or 3**
  - Explain that continuing will likely cause context overflow

### Mitigation Strategies

#### Option 1: Continue in Current Window
- User accepts the token cost
- Execute normally in current context
- Log decision for future reference
- **Automatically blocked if >85% projected usage**

#### Option 2: Task/Subagent (Isolated Context) [RECOMMENDED >70%]

Execute using the Task tool with appropriate subagent:

```javascript
Task(
  subagent_type="general-purpose",  // or "Plan" for research
  description="Brief description",
  prompt="Complete operation prompt with all context needed"
)
```

**Benefits:**
- Separate context window (doesn't add to current)
- Returns only final result (~5-10K tokens)
- **Saves 80-90% of context usage**
- Can run in parallel with other work

**When to use:**
- Projected usage >70%
- Heavy research operations
- Large file generation
- Any operation where final summary is sufficient

#### Option 3: New Window Prompt (Fresh Start)

Generate a complete standalone prompt containing:

1. **Operation Context**
   - What needs to be done
   - Why it's being done
   - Success criteria

2. **Required Documentation**
   - Relevant file contents
   - Configuration details
   - Dependencies and references

3. **Inputs Prepared**
   - All data needed to execute
   - Pre-processed information
   - File paths and locations

4. **Execution Instructions**
   - Step-by-step workflow
   - Validation checklist
   - Output specifications

5. **Handoff Instructions**
   - How to return results
   - What format to use
   - Where to save outputs

Present prompt in a code block for easy copying:

```markdown
# {Operation Name} - Standalone Execution Prompt

[Complete prompt with all sections above]

---
WHEN COMPLETE: Save results to {location} and notify user
```

**Benefits:**
- Zero impact on current context
- User can execute later or in fresh session
- All context preserved in prompt
- Can be saved for future use

**When to use:**
- Projected usage >85% (required)
- User wants to defer execution
- Operation is non-urgent
- Context preservation is critical

#### Option 4: Agent Custom Path (Dynamic)

Agents can propose operation-specific alternatives:

- **Sharding**: Break into smaller sequential operations
- **Preview Mode**: Execute lightweight version first
- **Partial Execution**: Run critical phases only, defer others
- **Incremental**: Execute with checkpoints, allow user to pause/resume

Example:
```
4. Modo Preview (viabilidade only)
   • Executa apenas fase de assessment
   • ~50K tokens, 30 minutos
   • Decide se vale continuar com pipeline completo
```

### Token Estimation Formulas

#### Base Rates

- **File read**: 1K tokens per 1,000 words (avg 4 chars/token)
- **Web search**: 5K tokens per query (including results analysis)
- **Document generation**: 2K tokens per 1,000 words output
- **Artifact analysis**: 3K tokens per artifact/document analyzed
- **Code generation**: 1.5K tokens per 100 lines of code

#### Overhead Multipliers

- Context management: +20% for multi-step operations
- Error handling: +10% for operations with validation
- Interactive workflows: +15% for elicitation steps
- Parallel operations: +5% per additional concurrent operation

#### Operation-Specific Estimates

**MMOS Operations:**
- `*map {name}` (greenfield full pipeline): 2.0M - 2.5M tokens
- `*map {name}` (brownfield update): 500K - 1M tokens
- `*viability {name}`: 50K tokens
- `*phase research {name}`: 500K - 800K tokens
- `*phase analysis {name}`: 800K tokens
- `*phase synthesis {name}`: 300K tokens

**CreatorOS Operations:**
- `*new {slug}` (full course): 200K - 500K tokens
- `*upgrade {slug}`: 100K - 300K tokens
- `*market-research {slug}`: 50K tokens
- `*curriculum {slug}`: 100K tokens
- `*generate-blog-post`: 30K - 50K tokens

**InnerLens Operations:**
- Full psychometric profile: 100K - 200K tokens
- Fragment extraction: 20K - 40K tokens per session
- Quality assurance review: 30K - 50K tokens

### Implementation Requirements for Expansion Pack Agents

All expansion pack agents MUST include token estimation in their `activation-instructions`:

```yaml
activation-instructions:
  - [... existing steps ...]
  - TOKEN ESTIMATION (CRITICAL): Before executing multi-step commands:
    1. Read task metadata (token-estimation section)
    2. Calculate estimate using formulas from CLAUDE.md
    3. Present using standardized format
    4. Wait for user choice (1/2/3/4)
    5. If option 2: Use Task tool with subagent
    6. If option 3: Generate complete standalone prompt
    7. Log decision and proceed
```

### Task Metadata Requirements

All multi-step tasks in expansion packs MUST include `token-estimation` in frontmatter:

```yaml
---
task-id: example-task
name: Example Task Name

token-estimation:
  input: 50000              # Tokens for reading/research
  processing: 100000        # Tokens for analysis/synthesis
  output: 30000             # Tokens for generation
  total_min: 150000         # Minimum estimate
  total_max: 200000         # Maximum estimate
  factors:                  # What drives the estimate
    - "Number of files to analyze (10-15 files)"
    - "Web research queries (5-8 queries)"
    - "Document generation (5,000 words)"
  alternatives:
    subagent_savings: "85%"  # Context saved with subagent
    sharding_option: "Break into 3 sequential phases"
    preview_mode: "Viability check only (50K tokens)"

user-confirmation-required: true
---
```

### Validation and Logging

After user selects an option, log the decision:

```yaml
token_estimation_log:
  operation: "{task_name}"
  estimated_tokens: {tokens}
  projected_usage: "{pct}%"
  status: "{SEGURO|APERTADO|RISCO}"
  user_choice: {1|2|3|4}
  timestamp: "{iso_timestamp}"
  rationale: "{user_explanation_if_provided}"
```

### Examples

#### Example 1: Safe Operation

```
📊 ESTIMATIVA DE TOKENS: Generate Blog Post

INPUT (Leitura):
  Course outline:          ~5K tokens
  SEO keywords:            ~2K tokens
  ─────────────────────────────────────
  TOTAL INPUT:             ~7K tokens

PROCESSING (Geração):
  Content writing:         ~30K tokens
  SEO optimization:        ~5K tokens
  ─────────────────────────────────────
  TOTAL PROCESSING:        ~35K tokens

OUTPUT (Formatação):
  Final markdown:          ~8K tokens
  ─────────────────────────────────────
  TOTAL OUTPUT:            ~8K tokens

──────────────────────────────────────
TOTAL ESTIMADO:            ~50K tokens

Estado Projetado:
  Atual:  25K tokens (12%)
  Após:   75K tokens (37%)
  Livre:  125K tokens (63% buffer)

Status: ✅ SEGURO

OPÇÕES:
1. Continuar nesta janela
   • Usa contexto atual
   • Ainda teremos 63% de buffer livre

2. Task/Subagent (contexto isolado)
   • Retorna apenas post final (~8K tokens)
   • Redução: 84% de economia de contexto

3. Prompt para nova janela
   • Zero impacto no contexto atual

Sua escolha (1/2/3)?
```

#### Example 2: Tight Operation

```
📊 ESTIMATIVA DE TOKENS: Full Course Generation

INPUT (Research):
  Market research:         ~50K tokens
  Competitor analysis:     ~40K tokens
  Audience profiling:      ~30K tokens
  ─────────────────────────────────────
  TOTAL INPUT:             ~120K tokens

PROCESSING (Criação):
  Curriculum design:       ~100K tokens
  Module breakdowns:       ~150K tokens
  Assessment creation:     ~50K tokens
  ─────────────────────────────────────
  TOTAL PROCESSING:        ~300K tokens

OUTPUT (Documentação):
  Course files:            ~80K tokens
  ─────────────────────────────────────
  TOTAL OUTPUT:            ~80K tokens

──────────────────────────────────────
TOTAL ESTIMADO:            ~500K tokens

Estado Projetado:
  Atual:  100K tokens (50%)
  Após:   600K tokens (300% - ESTOURO!)
  Livre:  -400K tokens

Status: 🚨 RISCO DE ESTOURO

OPÇÕES:
1. ❌ Continuar nesta janela (BLOQUEADO - estouro garantido)

2. ✅ Task/Subagent (contexto isolado) [RECOMENDADO]
   • Contexto separado (não soma aos 100K atuais)
   • Retorna apenas curso final (~50K tokens)
   • Redução: 90% de economia de contexto

3. ✅ Prompt para nova janela
   • Zero impacto no contexto atual
   • Documentação completa será fornecida

4. Modo Incremental (3 fases sequenciais)
   • Fase 1: Market research (120K tokens)
   • Fase 2: Curriculum design (200K tokens)
   • Fase 3: Module creation (200K tokens)
   • Permite checkpoints entre fases

Recomendação: Opção 2 (subagent) ou Opção 3 (nova janela)

Sua escolha (2/3/4)?
```

#### Example 3: MMOS Pipeline

```
📊 ESTIMATIVA DE TOKENS: *map joao_lozano (greenfield)

INPUT (Research):
  Mode detection:          ~5K tokens
  Viability assessment:    ~50K tokens
  Source collection:       ~100K tokens
  Research (web + files):  ~800K tokens
  ─────────────────────────────────────
  TOTAL INPUT:             ~955K tokens

PROCESSING (Analysis):
  Layer 1-8 analysis:      ~800K tokens
  Synthesis frameworks:    ~300K tokens
  KB generation:           ~150K tokens
  ─────────────────────────────────────
  TOTAL PROCESSING:        ~1,250K tokens

OUTPUT (System Prompts):
  Prompt creation:         ~200K tokens
  Validation tests:        ~150K tokens
  Documentation:           ~50K tokens
  ─────────────────────────────────────
  TOTAL OUTPUT:            ~400K tokens

──────────────────────────────────────
TOTAL ESTIMADO:            ~2,605K tokens

Estado Projetado:
  Atual:  30K tokens (15%)
  Após:   2,635K tokens (131% - ESTOURO!)
  Livre:  -635K tokens

Status: 🚨 RISCO DE ESTOURO

OPÇÕES:
1. ❌ Continuar nesta janela (BLOQUEADO - estouro garantido)

2. ✅ Task/Subagent (contexto isolado) [RECOMENDADO]
   • Executa pipeline em contexto separado
   • Retorna apenas resumo + system prompt (~80K tokens)
   • Redução: 97% de economia de contexto

3. ✅ Prompt para nova janela
   • Zero impacto no contexto atual
   • Prompt completo com todas instruções

4. Modo Preview (viabilidade only)
   • Executa apenas viability assessment
   • ~50K tokens, 30 minutos
   • Decide se vale prosseguir com pipeline completo
   • Após GO: pode escolher opção 2 ou 3 para full pipeline

Recomendação: Opção 4 (preview) seguido de Opção 2 (subagent)

Sua escolha (2/3/4)?
```

### Enforcement

This rule is **MANDATORY** for:
- All expansion pack agents (mind-mapper, course-architect, psychologist, etc.)
- All multi-step workflows
- All operations marked `user-confirmation-required: true`

Agents that skip token estimation without valid reason will be considered non-compliant with AIOS-FULLSTACK standards.

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
- `outputs/database/mmos.db` (generated database)

**❌ Wrong:**
- `docs/mmos/validations/pedro-valerio-checklist.md` → Use `outputs/minds/pedro_valerio/docs/validation-checklist.md`
- `docs/mmos/migrations/joao-lozano-progress.md` → Use `outputs/minds/joao_lozano/docs/migration-progress.md`
- `expansion-packs/mmos/benchmarks/debate.yaml` → Use `docs/mmos/qa/benchmarks/debate.yaml`
- `docs/mmos/docs/PRD.md` → Use `docs/prd/mmos-prd.md`
- `docs/mmos/DNA_MENTAL.md` → Use `docs/methodology/dna-mental.md`
- `outputs/logs/session.md` → Use `docs/logs/2025-10-17-session.md` (logs are docs!)
- `docs/mmos/mmos.db` → Use `outputs/database/mmos.db`

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
| Database files | `outputs/database/` | `mmos.db` |
| MMOS scripts | `expansion-packs/mmos/` | `pipeline.py` |

---
*AIOS-FULLSTACK Claude Code Configuration v2.3*
*Last Updated: 2025-10-23 - AIOS upstream sync (v4.31.0+main-8d5d3d2)*