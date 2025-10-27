# MMOS Development Guide for Claude Code

**Project:** Mente Lendária - Mind Mapper OS (MMOS)
**Purpose:** AI-orchestrated cognitive cloning platform
**Tech:** Python 3, Node.js, Bash | SQLite + Supabase | Claude + Gemini APIs

**Core Capability:** `*map {name}` → 6-phase pipeline → production-ready cognitive clone

---

## 1. Alan's Working Rules (Priority #1)

### Process Mental (Validate Before Action)

```python
def validate_before_action():
    # Foundation
    if not matches_real_world(): return "REJECT"
    if is_over_engineered(): return "SIMPLIFY"
    if has_duplication(): return "EXTRACT & REUSE"
    if violates_KISS(): return "REMOVE COMPLEXITY"

    # Execution
    if not backed_by_data(): return "GET DATA FIRST"
    if builds_in_isolation(): return "INTEGRATE"
    if bypasses_database(): return "PERSIST IT"
    if cant_demo_in_5min(): return "BUILD PROOF FIRST"
    if no_human_checkpoints(): return "ADD VALIDATION POINTS"

    return "PROCEED"
```

### Communication Style

**DO:**
- Be direct and economical (no fluff)
- Map context BEFORE executing (show structure first)
- Present options, let Alan decide
- Use English for code, PT-BR for discussion
- Executive summary at top, details below

**DON'T:**
- Long explanations without being asked
- Implement without showing structure first
- Decide for Alan (show options instead)
- Use emojis unless Alan does
- Hardcode when config file works
- Continue old task if Alan pivots (adapt fast)

### Technical Preferences

```yaml
philosophy: KISS (Keep It Simple, Stupid)
data_location: database (not files)
configuration: YAML/JSON (not hardcoded)
integration: systems must connect (no silos)
validation: real data (not lorem ipsum)
documentation: after proving it works
```

### Workflow Pattern

**Before Implementation:**
1. Show structure/flow first
2. Ask: "where should this live?"
3. Present: "3 approaches - which one?"
4. Validate: "does this match your workflow?"

**During Development:**
- Strategic checkpoints (where are we? where next?)
- Incremental validation (prove with 1 example first)
- Config over duplication (1 flexible > N rigid)
- Database-centric (important data = persisted)
- Time tracking for heavy work (estimate + metrics)

**Priority Handling:**
- Alan context-switches fast (adapt, don't resist)
- Vertical mastery (1 thing working > 5 mediocre)
- Show don't sell (working demo > promises)
- Fail fast loops (hours/days, not weeks/months)

### Red Flags to Avoid
- Implementing before understanding context
- Long explanations without executive summary
- Hardcoded solutions when config works
- Continuing old task when Alan has pivoted
- Theory without real-world validation
- Over-engineering simple problems
- No time estimate for programming/heavy tools

---

## 2. MMOS Quick Reference

**What it does:**
- `*map {name}` → Auto-detects workflow → 6-phase pipeline → AI clone
- Uses DNA Mental™ methodology for cognitive profiling
- Outputs production-ready system prompts (94% fidelity)

**Expansion Packs:**
- `mmos/` - Cognitive cloning pipeline
- `creator-os/` - Course generation from clones
- `etl-data-collector/` - Multimodal data collection
- `innerlens/` - Psychometric profiling
- `super-agentes/` - Advanced agent orchestration
- `fragments/` - Knowledge fragment extraction

**Key Directories:**
- `.aios-core/` - AI orchestration framework (agents, tasks, workflows)
- `expansion-packs/` - Modular system extensions
- `docs/` - Documentation (versioned)
- `outputs/` - Generated artifacts (NOT versioned)
- `supabase/` - Database migrations + schemas
- `scripts/` - Automation (db-migrate, pipeline, validation)

**Full structure:** See `docs/guides/folder-structure.md`

---

## 3. Commands That Actually Work

### MMOS Mind Mapping
```bash
*map {name}                    # Auto-detect + full pipeline
*map daniel_kahneman           # Public figure (web scraping)
*map pedro_valerio             # Private (materials-based)
```

### Database Operations
```bash
# Set environment first
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export SUPABASE_DB_URL="postgresql://..."

# Run operations
./scripts/db-migrate.sh supabase/migrations/{file}.sql
./scripts/db-rollback.sh supabase/migrations/{file}.sql
./scripts/db-test.sh
```

### NPM Commands (Real)
```bash
npm test                       # Jest test suite
npm run test:watch            # Watch mode
npm run test:coverage         # Coverage report
npm run validate:minds        # Validate minds
npm run validate:sources      # Validate sources
npm run validate:all          # All validations
```

### Data Pipeline
```bash
node scripts/pipeline/import-analysis.js
node scripts/pipeline/validate-integration.js
node scripts/pipeline/populate-sources.js
```

---

## 4. MMOS Architecture Rules (CRITICAL)

### File Organization Decision Tree

**Before creating ANY file:**

1. **"Is this about a SPECIFIC mind (name in content)?"**
   - **YES** → `outputs/minds/{mind_slug}/docs/` or `outputs/minds/{mind_slug}/logs/`
   - **NO** → Continue...

2. **"Is this documentation/code for a specific expansion-pack?"**
   - **YES** → `expansion-packs/{pack-name}/docs/` (docs stay WITH the pack)
   - **NO** → Continue...

3. **"Is it a script/template for an expansion-pack?"**
   - **YES** → `expansion-packs/{pack-name}/`
   - **NO** → Continue...

4. **"Is it about MMOS system/process (core MMOS only)?"**
   - **YES** → `docs/mmos/{workflows|epics|stories|reports|qa}/`
   - **NO** → Continue...

5. **"Is it a methodology/framework?"**
   - **YES** → `docs/methodology/`
   - **NO** → Continue...

6. **"Is it a user/developer guide (cross-system)?"**
   - **YES** → `docs/guides/`
   - **NO** → Continue...

7. **"Is it a product requirement?"**
   - **YES** → `docs/prd/`
   - **NO** → Continue...

8. **"Is it an execution log?"**
   - **YES** → `docs/logs/` (versioned docs!)
   - **NO** → ⚠️ STOP - Review architecture

### What Goes Where (Quick Reference)

| Type | Location | Example |
|------|----------|---------|
| Product requirements | `docs/prd/` | `mmos-prd.md` |
| Methodologies | `docs/methodology/` | `dna-mental.md` |
| User guides (cross-system) | `docs/guides/` | `outputs-guide.md` |
| Architecture docs | `docs/architecture/` | `system-design.md` |
| Development stories | `docs/stories/` | `story-2.1.md` |
| Execution logs | `docs/logs/` | `2025-10-17-session.md` |
| MMOS workflows | `docs/mmos/workflows/` | `brownfield-workflow.md` |
| MMOS epics | `docs/mmos/epics/` | `epic-2-database.md` |
| MMOS reports | `docs/mmos/reports/` | `executive-summary.md` |
| **Expansion-pack docs** | `expansion-packs/{pack}/docs/` | `creator-os/docs/workflow-principles.md` |
| **Expansion-pack scripts** | `expansion-packs/{pack}/` | `creator-os/lib/brief_parser.py` |
| Mind-specific docs | `outputs/minds/{slug}/docs/` | `validation-checklist.md` |
| Mind-specific logs | `outputs/minds/{slug}/logs/` | `20251016-session.md` |
| Generated courses | `outputs/courses/{slug}/` | `curriculum.yaml` |
| Database files | `outputs/database/` | `mmos.db` |

### Examples

**✅ Correct:**
```
# Mind-specific
outputs/minds/joao_lozano/docs/validation-checklist.md
outputs/minds/pedro_valerio/logs/20251016-session.md

# Expansion-pack docs (stay with the pack!)
expansion-packs/creator-os/docs/course/workflow-principles.md
expansion-packs/mmos/docs/pipeline-architecture.md
expansion-packs/super-agentes/docs/integration-patterns.md

# Core system docs
docs/mmos/workflows/brownfield-workflow.md
docs/prd/mmos-prd.md
docs/methodology/dna-mental.md
docs/logs/2025-10-27-session.md
```

**❌ Wrong:**
```
# Mind-specific content in system docs
docs/mmos/validations/pedro-valerio-checklist.md
  → Use: outputs/minds/pedro_valerio/docs/validation-checklist.md

# Methodology in wrong place
docs/mmos/DNA_MENTAL.md
  → Use: docs/methodology/dna-mental.md

# Logs outside docs/
outputs/logs/session.md
  → Use: docs/logs/2025-10-27-session.md (logs are docs!)

# Expansion-pack docs in root docs/
docs/creator-os/workflow-principles.md
  → Use: expansion-packs/creator-os/docs/workflow-principles.md (docs stay WITH pack!)

docs/guides/super-agentes-integration.md
  → Use: expansion-packs/super-agentes/docs/integration.md (pack-specific = pack location)
```

### outputs/minds/{slug}/ Structure (OUTPUT ONLY)
- `sources/` - Source materials collected
- `analysis/` - Phase 3 (identity-core.yaml, cognitive-spec.yaml)
- `synthesis/` - Phase 4 (frameworks.md, communication-style.md)
- `implementation/` - Phase 5 (system-prompt-*.md)
- `system_prompts/` - Final prompts
- `kb/` - Knowledge base chunks
- `docs/` - Mind-specific process docs
- `logs/` - Mind-specific logs

### docs/mmos/ (SYSTEM ONLY)
- `workflows/` - MMOS workflows
- `epics/` - Development epics
- `stories/` - MMOS stories
- `reports/` - Executive reports
- `qa/benchmarks/` - Cross-mind benchmarks
- `taxonomy/` - Trait taxonomies

**NEVER** in docs/mmos/:
- Folders named after minds
- Mind-specific validations/migrations
- Individual mind documentation

### expansion-packs/{pack}/ (SELF-CONTAINED)

**Structure (each pack):**
- `lib/` - Python/JS modules
- `scripts/` - Executable entry points
- `tasks/` - Task definitions
- `agents/` - Agent definitions
- `templates/` - Content templates
- `docs/` - **Pack-specific documentation (stays WITH the pack!)**
- `config.yaml` - Pack configuration
- `README.md` - Pack overview

**Rule:** Docs about a specific expansion-pack live IN that expansion-pack, NOT in root `docs/`.

**Examples:**
- ✅ `expansion-packs/creator-os/docs/workflow-principles.md`
- ✅ `expansion-packs/super-agentes/docs/integration-patterns.md`
- ❌ `docs/guides/creator-os-workflow.md` (pack-specific = wrong location)
- ❌ `docs/creator-os/` (never create pack folders in root docs/)

**Exception:** Cross-system integration guides that span multiple packs → `docs/guides/`

---

## 5. Development Workflow

### Story-Driven Development
1. Work from stories in `docs/stories/`
2. Mark checkboxes: `[ ]` → `[x]`
3. Maintain File List section
4. Follow acceptance criteria exactly

### Code Standards
```python
philosophy = "KISS"              # Simplest solution
language = "English"             # Code, vars, comments
structure = "clear_scope"        # System boundaries
reusability = "extract_once"     # Use N times
validation = "real_world"        # Actual scenarios

avoid = [
    "ceremony_blocking_mvp",
    "isolated_systems",
    "fake_test_data",
    "unnecessary_complexity",
    "hardcoded_values"
]
```

### Git Conventions
```bash
feat: add brownfield detection to pipeline
fix: correct migration rollback script
docs: update architecture with supabase
chore: cleanup legacy scripts
```

Format: `type: description`
Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`

### Testing
```bash
npm test                  # Before marking complete
npm run test:coverage    # Coverage report
npm run validate:all     # All validations
./scripts/db-test.sh     # Database tests
```

---

## 6. Claude Code Specific

### Tool Usage

**DO:**
- Use Grep tool (NOT bash `grep`/`rg`)
- Use Task tool for multi-step operations
- Batch file reads/writes
- Edit existing files (don't create new)
- Run independent tools in parallel

**DON'T:**
- Use bash for file operations (use Read/Write/Edit)
- Use echo/printf for communication
- Create files unnecessarily
- Use emojis (unless Alan does)

### Performance
- Batch tool calls
- Parallel execution for independent ops
- Cache in memory during session
- Use Explore agent for codebase searches

### Time Tracking (Heavy Work Required)

**Heavy work = cronômetro obrigatório:**
- Multiple files/scripts
- Dataset processing
- Implementations > 5min
- Any programming task

**Pattern:**
```python
# Before: estimate + start
estimate = "~X minutes"
start = now()

# After: show metrics
{
  "estimativa": estimate,
  "tempo_real": elapsed,
  "diferença": delta
}
```

---

## 7. Configuration

**Root configs:**
- `.aios-core/core-config.yaml` - Root AIOS config
- `.aios-core/mmos-config.yaml` - MMOS overrides
- `package.json` - Node.js (v3.0.0)
- `.env` - API keys (NOT versioned)

**Expansion pack configs:**
- `expansion-packs/mmos/config.yaml`
- `expansion-packs/creator-os/config.yaml`
- `expansion-packs/etl-data-collector/config.yaml`
- `expansion-packs/innerlens/config.yaml`

**Read configs dynamically - don't hardcode values.**

---

## 8. Getting Data Dynamically

**Status/metrics → get from source:**

```bash
# Mind count
ls outputs/minds/ | wc -l

# Course count
ls outputs/courses/ | wc -l

# Database version
psql "$SUPABASE_DB_URL" -c "SELECT version FROM migrations ORDER BY applied_at DESC LIMIT 1"

# Expansion packs
ls expansion-packs/

# Latest logs
ls -t docs/logs/ | head -5
```

**Don't hardcode data that changes.**

---

## Meta-Rule

**These rules themselves should be economical. If something here becomes ceremony, delete it.**

**When in doubt:**
1. Map context first
2. Show structure before changing
3. Present options, let Alan decide
4. KISS principle (simplest solution)
5. Validate with real scenario
6. Adapt fast if Alan pivots

**For details, read the actual docs:**
- Full structure: `docs/guides/folder-structure.md`
- MMOS workflows: `docs/mmos/workflows/`
- Architecture: `docs/architecture/`
- PRD: `docs/prd/mmos-prd.md`
- DNA Mental™: `docs/methodology/dna-mental.md`

---

**MMOS Claude Code Configuration v3.2 (KISS Edition)**
**Last Updated:** 2025-10-27
**Principle:** Link to docs, don't duplicate. Get data, don't hardcode.
**Key Update:** Expansion-pack docs stay WITH the pack (self-contained).
