# MMOS Architecture Guard Checklist

**Version:** 1.0
**Purpose:** Prevent architectural violations in MMOS file placement
**When to use:** Before creating ANY new file in docs/mmos/ or outputs/minds/

---

## Pre-File Creation Checklist

### Question 1: What type of content is this?

- [ ] **Mind-specific content** (validation, migration, analysis for ONE mind)
  - ✅ Action: Use `outputs/minds/{slug}/docs/` or `outputs/minds/{slug}/logs/`
  - ❌ NEVER use `docs/mmos/validations/` or `docs/mmos/migrations/`

- [ ] **System-level content** (reports, epics, architecture about MMOS itself)
  - ✅ Action: Use `docs/mmos/reports/`, `docs/mmos/epics/`, etc.
  - ❌ NEVER create mind-specific folders in docs/mmos/

- [ ] **Executable script/task/template** (reusable across all minds)
  - ✅ Action: Use `expansion-packs/mmos-mind-mapper/`
  - ❌ NEVER put outputs in expansion pack

---

## Critical Decision Tree

```
Is this about a SPECIFIC mind (name appears in content)?
├─ YES → outputs/minds/{slug}/
│   ├─ Pipeline output? → analysis/, synthesis/, implementation/
│   ├─ Process doc? → docs/
│   └─ Execution log? → logs/
│
├─ NO → Is this a script/template?
│   ├─ YES → expansion-packs/mmos-mind-mapper/
│   └─ NO → Is this about MMOS system?
│       ├─ YES → docs/mmos/{appropriate-folder}/
│       └─ NO → ⚠️ STOP - Review with team
```

---

## Red Flags (Auto-Reject)

### 🚨 NEVER Create These Patterns:

- [ ] ❌ `docs/mmos/validations/{mind_name}/`
  - **Why:** Validations are mind-specific
  - **Correct:** `outputs/minds/{mind_name}/docs/validation-*.md`

- [ ] ❌ `docs/mmos/migrations/{mind_name}/`
  - **Why:** Migrations are mind-specific
  - **Correct:** `outputs/minds/{mind_name}/docs/migration-*.md`

- [ ] ❌ `expansion-packs/mmos-mind-mapper/benchmarks/`
  - **Why:** Benchmarks are outputs, not scripts
  - **Correct:** `docs/mmos/qa/benchmarks/`

- [ ] ❌ `outputs/minds/{slug}/MMOS_PROCESS.md`
  - **Why:** Process docs are system-level
  - **Correct:** `docs/mmos/docs/`

---

## Allowed Directory Structure

### ✅ docs/mmos/ (System Only)
```
architecture/     # MMOS system architecture
database/         # MMOS database files
docs/             # System documentation (PRD, workflows)
epics/            # MMOS development epics
logs/             # System-wide execution logs
qa/benchmarks/    # Cross-mind benchmarks
reports/          # Executive reports, version comparisons
stories/          # MMOS development stories
taxonomy/         # System taxonomy
```

### ✅ outputs/minds/{slug}/ (Individual Mind)
```
sources/          # Collected materials
analysis/         # Phase 3 outputs
synthesis/        # Phase 4 outputs
implementation/   # Phase 5 outputs
system_prompts/   # Final prompts
kb/               # Knowledge base
docs/             # 📋 Mind-specific process docs (validations, migrations)
logs/             # 📊 Mind-specific execution logs
```

### ✅ expansion-packs/mmos-mind-mapper/ (Scripts)
```
agents/           # Agent definitions
tasks/            # Task workflows
templates/        # Reusable templates
checklists/       # Reusable checklists
lib/              # Utility libraries
config/           # Configuration
```

---

## Common Violations & Fixes

### Violation 1: Validation docs in docs/mmos/

**❌ Wrong:**
```
docs/mmos/validations/pedro-valerio-checklist.md
```

**✅ Correct:**
```
outputs/minds/pedro_valerio/docs/validation-checklist.md
```

---

### Violation 2: Migration docs in docs/mmos/

**❌ Wrong:**
```
docs/mmos/migrations/joao-lozano-progress.md
```

**✅ Correct:**
```
outputs/minds/joao_lozano/docs/migration-progress.md
```

---

### Violation 3: Output files in expansion pack

**❌ Wrong:**
```
expansion-packs/mmos-mind-mapper/outputs/debate.yaml
```

**✅ Correct:**
```
docs/mmos/qa/benchmarks/debate.yaml
```

---

## Pre-Commit Validation

Before committing, verify:

- [ ] No mind-specific folders in `docs/mmos/`
- [ ] No process docs in `outputs/minds/{slug}/` root (use `docs/` subfolder)
- [ ] No output files in `expansion-packs/`
- [ ] Path follows allowed structure above
- [ ] File naming convention followed (kebab-case, descriptive)

---

## Enforcement

**Level:** CRITICAL - Violations will be auto-rejected

**Automated checks:**
- Pre-commit hook (see `.aios-core/hooks/pre-commit-mmos-guard.sh`)
- CI/CD pipeline check
- IDE warnings (via .claude/CLAUDE.md and .cursor/global-rules.md)

---

## Need Help?

If unsure about placement:

1. Check this checklist
2. Review `docs/mmos/ARCHITECTURE_RULES.md`
3. Ask in PR review
4. Contact MMOS architecture owner

---

**Checklist Version:** 1.0
**Last Updated:** 2025-10-16
**Owner:** AIOS Core Team
