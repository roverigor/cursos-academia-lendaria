# AIOS-FULLSTACK Development Rules for Claude Code

You are working with AIOS-FULLSTACK, an AI-Orchestrated System for Full Stack Development.

## 🎯 Priority Check (Execute BEFORE Any Action)

```python
def validate_before_action():
    # Context & Design
    if not mapped_context(): return "MAP FIRST - where is this defined?"
    if not showed_structure_first(): return "SHOW STRUCTURE - let user decide"
    if is_over_engineered(): return "SIMPLIFY"

    # Implementation
    if not backed_by_real_data(): return "USE REAL SCENARIO"
    if has_hardcoded_values(): return "USE CONFIG FILE"
    if bypasses_database(): return "PERSIST IMPORTANT DATA"
    if builds_in_isolation(): return "INTEGRATE SYSTEMS"
    if no_human_checkpoints(): return "ADD VALIDATION POINTS"

    return "PROCEED"
```

## 📋 Communication Protocol

**DO:**
- **Executive summary first** (details available below if needed)
- **Present 2-3 options** (let Alan decide, don't choose for him)
- **Map context before executing** ("this is defined in X", "affects Y")
- **Direct and economical** (no fluff, no ceremony)
- **English for code**, PT-BR for discussion
- **Adapt fast** (if Alan pivots, follow immediately)

**DON'T:**
- Long explanations without executive summary
- Decide for the user (always show options)
- Implement before showing structure/approach
- Use emojis unless user does first
- Continue old task when user context-switches
- Theoretical validation (use real workflow scenarios)

## 🏗️ Technical Preferences

```yaml
architecture:
  data_storage: "database for important data (not files)"
  configuration: "YAML/JSON (not hardcoded)"
  integration: "systems must connect (no silos)"
  validation: "real data from actual workflow"

workflow:
  before_implementation: "show structure → get approval → implement"
  checkpoints: "strategic (where are we? where next?)"
  validation: "incremental (prove with 1 example first)"
  mastery: "vertical (1 thing working > 5 mediocre)"

code:
  language: "English (variables, functions, comments)"
  reusability: "extract once, use N times"
  tests: "real scenarios (not lorem ipsum)"
```

**Decision Framework:**
1. Map context ("where is this defined?")
2. Identify real scenario (Alan's actual workflow)
3. Present options (2-3 approaches)
4. Validate pragmatically (solves the case?)
5. Decide quickly, pivot if needed

## 🚫 Anti-Patterns (Red Flags)

```python
REJECT = [
    "implementing_without_mapping_context",
    "deciding_for_user_without_showing_options",
    "hardcoded_values_when_config_works",
    "long_responses_without_executive_summary",
    "continuing_old_task_when_user_pivoted",
    "theoretical_validation_without_real_data",
    "ceremony_blocking_mvp",
    "isolated_systems_not_integrated"
]
```

## 🎯 AIOS Framework Essentials

### Core Architecture

```
.aios-core/           # Framework (READ-ONLY - never modify)
expansion-packs/      # Project extensions (your code lives here)
docs/                 # Documentation (versioned)
outputs/              # Generated artifacts (not versioned)
```

**CRITICAL:** Never modify `.aios-core/` - it's the framework base. All project code goes in `expansion-packs/` or `docs/`.

**Full structure details:** See `docs/guides/folder-structure.md`

### Agent System

- Activate agents: `@dev`, `@qa`, `@architect`, `@pm`, `@po`, `@sm`, `@analyst`
- Master agent: `@aios-master`
- Agent commands: `*help`, `*create-story`, `*task`, `*exit`
- Follow agent's persona and workflows when active

### Story-Driven Development

1. **Work from stories** (`docs/stories/`) - all development starts here
2. **Update progress** - mark checkboxes as complete: `[ ]` → `[x]`
3. **Track changes** - maintain File List section
4. **Follow criteria** - implement exactly what acceptance criteria specify

### Code Standards

- Clean, self-documenting code
- Follow existing patterns (check first, then reuse)
- Comprehensive error handling
- Unit tests for all new functionality
- TypeScript/JavaScript best practices

### Testing Requirements

- Run tests before marking complete
- Verify: `npm run lint` && `npm run typecheck`
- Test edge cases and real scenarios
- Document test scenarios in story files

## 🛠️ Claude Code Specific

### Tool Usage
- **Search:** Use Grep tool (never `grep`/`rg` in bash)
- **Exploration:** Use Task tool with subagent_type=Explore
- **Parallel execution:** Multiple independent tool calls in single message
- **File ops:** Read/Edit/Write tools (not cat/sed/echo)

### Performance
- Batch tool calls when possible
- Parallel execution for independent operations
- Prefer editing existing files over creating new ones

### Session Management
- Track story progress throughout session
- Update checkboxes immediately after completing tasks
- Maintain context of current story
- Save state before long-running operations

**Full Claude Code guidelines:** See system prompt tools section

## 📊 Workflow Patterns

### Before Implementation
```
1. Map context (where defined? what affects?)
2. Show structure/approach options (2-3 choices)
3. Ask: "where should this live?"
4. Get approval → then implement
```

### During Development
```
1. Strategic checkpoints (progress check, next steps)
2. Incremental validation (1 working example first)
3. Config over duplication (flexible > rigid)
4. Database-centric (important data = persisted)
5. Integration required (systems must connect)
```

### Priority Handling
```
- Fast context-switching (adapt immediately when user pivots)
- Vertical mastery (complete 1 thing before starting next)
- Fail fast loops (hours/days, not weeks/months)
- Show don't sell (working demo > promises)
```

## 🔌 Expansion Pack System

**Source of truth:** `expansion-packs/{pack-name}/`

**Auto-synced to:** `.claude/commands/{PackName}/` (read-only, don't edit)

**Sync mechanism:** Pre-commit hook runs automatically

**Active packs:**
- `creator-os/` - Course generation system
- `mmos/` - Cognitive clone creation (Mind Mapper)
- `innerlens/` - Psychometric profiling

**Development workflow:**
1. Edit source in `expansion-packs/`
2. Commit (auto-sync happens)
3. Never edit `.claude/commands/` directly

**Full sync details:** See `docs/guides/expansion-pack-sync.md` (if exists) or lines 107-192 of old CLAUDE.md

## 📦 Project-Specific Rules

### MMOS System
- Architecture guard: Review `.aios-core/checklists/mmos-architecture-guard.md` before creating files
- Mind-specific content: `outputs/minds/{slug}/`
- System-level content: `docs/mmos/`
- **Full MMOS rules:** See `expansion-packs/mmos/README.md`

### Token Management
- Multi-step ops (>3 steps): Estimate required
- Large ops (>70% usage): Use Task/subagent recommended
- Critical ops (>85% usage): Must use subagent or new window
- **Full guide:** `docs/guides/token-estimation-guide.md`

### Git & GitHub
- Conventional commits: `feat:`, `fix:`, `docs:`, `chore:`
- Reference stories: `feat: implement X [Story 2.1]`
- Atomic, focused commits

## 🎯 Success Metrics

```python
good_interaction = {
    "mapped_context_first": True,
    "presented_options": True,
    "executive_summary": True,
    "direct_communication": True,
    "configurable_output": True,
    "validated_with_real_scenario": True,
    "integrated_with_systems": True
}

bad_interaction = {
    "implemented_without_mapping": True,
    "decided_without_showing_options": True,
    "verbose_without_summary": True,
    "hardcoded_solution": True,
    "theoretical_validation": True,
    "forced_linearity_when_user_pivoted": True
}
```

## 📚 Reference Documentation

**Full guides available in `docs/`:**
- `docs/guides/folder-structure.md` - Complete directory structure
- `docs/guides/token-estimation-guide.md` - Token management strategies
- `docs/guides/outputs-guide.md` - Generated artifacts organization
- `docs/methodology/dna-mental.md` - Core methodology framework
- `docs/prd/mmos-prd.md` - MMOS product requirements

**Quick reference:** `docs/README.md` - Master documentation navigation

---

**Meta-rule:** These rules should be economical. If anything becomes ceremony, delete it.

---
*AIOS-FULLSTACK Claude Code Configuration v3.0*
*Optimized for Alan's workflow - Direct, Economical, Database-First*
*Last Updated: 2025-10-30*
