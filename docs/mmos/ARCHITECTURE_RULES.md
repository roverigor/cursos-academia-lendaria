# MMOS Architecture Rules

**Version:** 1.0
**Last Updated:** 2025-10-16
**Purpose:** Enforce architectural boundaries and prevent common mistakes

---

## 🚨 CRITICAL RULES

### Rule 1: docs/mmos/ = SYSTEM-LEVEL ONLY

**✅ ALLOWED in docs/mmos/:**
- System-wide reports (executive summaries, version comparisons)
- MMOS epics and stories
- MMOS architecture documentation
- Cross-mind benchmarks (debates between multiple minds)
- MMOS database and logs
- System-level documentation (PRD, workflows)

**❌ FORBIDDEN in docs/mmos/:**
- **NEVER** create folders named after specific minds (`/joao_lozano/`, `/pedro_valerio/`)
- **NEVER** create mind-specific documents (validations, migrations) here
- **NEVER** store individual mind outputs (analysis, synthesis, prompts)

---

### Rule 2: docs/minds/{slug}/ = INDIVIDUAL MIND OUTPUTS ONLY

**✅ ALLOWED in docs/minds/{slug}/:**
- All pipeline outputs for THIS mind
- Mind-specific validation docs
- Mind-specific migration progress
- Mind-specific logs and sessions

**❌ FORBIDDEN in docs/minds/{slug}/:**
- System-level documentation
- Cross-mind comparisons
- MMOS process documentation
- Shared templates or checklists

---

### Rule 3: expansion-packs/mmos-mind-mapper/ = SCRIPTS ONLY

**✅ ALLOWED in expansion pack:**
- Agents, tasks, workflows
- Templates, checklists (reusable)
- Libraries, utilities
- Configuration files

**❌ FORBIDDEN in expansion pack:**
- Output files (minds, reports, benchmarks)
- Execution logs
- Mind-specific data

---

## 📋 Decision Tree

When creating a new file, ask:

### "Is this about a SPECIFIC mind?"
- **YES** → `docs/minds/{slug}/docs/` or `docs/minds/{slug}/logs/`
- **NO** → Continue to next question

### "Is this a script/task/template?"
- **YES** → `expansion-packs/mmos-mind-mapper/`
- **NO** → Continue to next question

### "Is this about MMOS system as a whole?"
- **YES** → `docs/mmos/reports/` or appropriate system folder
- **NO** → You're probably doing something wrong, ask for review

---

## 🔍 Common Mistakes & Corrections

### Mistake 1: Creating `/docs/mmos/validations/{mind_name}/`

**❌ Wrong:**
```
docs/mmos/validations/pedro-valerio-checklist.md
```

**✅ Correct:**
```
docs/minds/pedro_valerio/docs/validation-checklist.md
```

**Why:** Validation is SPECIFIC to that mind, not a system-level concern.

---

### Mistake 2: Creating `/docs/mmos/migrations/{mind_name}/`

**❌ Wrong:**
```
docs/mmos/migrations/joao-lozano-progress.md
```

**✅ Correct:**
```
docs/minds/joao_lozano/docs/migration-progress.md
```

**Why:** Migration progress is SPECIFIC to that mind.

---

### Mistake 3: Storing outputs in expansion pack

**❌ Wrong:**
```
expansion-packs/mmos-mind-mapper/benchmarks/debate-123.yaml
```

**✅ Correct:**
```
docs/mmos/qa/benchmarks/debate-123.yaml
```

**Why:** Benchmarks are OUTPUTS, not scripts. Expansion pack = execution only.

---

### Mistake 4: Putting system docs in a mind folder

**❌ Wrong:**
```
docs/minds/pedro_valerio/MMOS_ARCHITECTURE.md
```

**✅ Correct:**
```
docs/mmos/architecture/MMOS_ARCHITECTURE.md
```

**Why:** Architecture is SYSTEM-LEVEL, not mind-specific.

---

## 🛡️ Enforcement Mechanisms

### 1. Pre-commit Hook (TODO)
```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check for mind-specific folders in docs/mmos/
if git diff --cached --name-only | grep -E "docs/mmos/(validations|migrations)/[a-z_-]+"; then
    echo "❌ ERROR: Mind-specific files in docs/mmos/ detected!"
    echo "Move to docs/minds/{slug}/docs/ instead"
    exit 1
fi
```

### 2. CI/CD Check (TODO)
```yaml
# .github/workflows/architecture-guard.yml
name: Architecture Guard

on: [pull_request]

jobs:
  check-architecture:
    runs-on: ubuntu-latest
    steps:
      - name: Check docs/mmos/ structure
        run: |
          # Fail if mind-specific folders exist
          if ls docs/mmos/validations/ 2>/dev/null; then
            echo "❌ Mind-specific validations/ folder should not exist"
            exit 1
          fi
```

### 3. IDE Rules (.claude/CLAUDE.md & .cursor/global-rules.md)

**Already implemented:**
```markdown
## MMOS-Specific Rules

### docs/minds/ Directory - OUTPUT ONLY

**CRITICAL:** `docs/minds/` contains ONLY the direct output of the MMOS pipeline.

**DO NOT create process documentation in docs/minds/**

#### Decision Rule:
"Is this file the DIRECT OUTPUT of the MMOS pipeline for this specific mind?"
- YES → `docs/minds/{mind_slug}/`
- NO → Appropriate `docs/mmos/` subfolder
```

---

## 📊 Allowed Directory Structure

### docs/mmos/ (System-Level)
```
docs/mmos/
├── architecture/         ✅ System architecture
├── database/             ✅ MMOS database
├── docs/                 ✅ System documentation (PRD, workflows)
├── epics/                ✅ MMOS epics
├── logs/                 ✅ System-wide logs
├── qa/benchmarks/        ✅ Cross-mind benchmarks
├── reports/              ✅ Executive reports, version comparisons
├── stories/              ✅ MMOS stories
├── taxonomy/             ✅ System taxonomy
└── mmos.db               ✅ Database file
```

### docs/minds/{slug}/ (Individual Mind)
```
docs/minds/{slug}/
├── sources/              ✅ Collected materials
├── analysis/             ✅ Cognitive analysis
├── synthesis/            ✅ Synthesis artifacts
├── implementation/       ✅ System prompt creation
├── system_prompts/       ✅ Final prompts
├── kb/                   ✅ Knowledge base chunks
├── docs/                 ✅ Mind-specific docs (validations, migrations, reports)
└── logs/                 ✅ Mind-specific execution logs
```

### expansion-packs/mmos-mind-mapper/ (Scripts)
```
expansion-packs/mmos-mind-mapper/
├── agents/               ✅ Agent definitions
├── tasks/                ✅ Task workflows
├── templates/            ✅ Reusable templates
├── checklists/           ✅ Reusable checklists
├── lib/                  ✅ Utility libraries
├── config/               ✅ Configuration
└── README.md             ✅ Documentation
```

---

## 🚦 Review Checklist

Before creating ANY new file, verify:

- [ ] **Is this mind-specific?** → Use `docs/minds/{slug}/`
- [ ] **Is this a script/template?** → Use `expansion-packs/mmos-mind-mapper/`
- [ ] **Is this system-level?** → Use `docs/mmos/`
- [ ] **Does the path follow the allowed structure above?**
- [ ] **Am I creating a new subfolder in docs/mmos/?** → STOP and review this doc

---

## 🔧 Migration Guide

If you find violations:

1. **Identify** the incorrectly placed files
2. **Determine** correct location using decision tree
3. **Move** files to correct location
4. **Update** any references/imports
5. **Delete** empty incorrect folders
6. **Commit** with message: `fix: correct architecture violation - move {file} to proper location`

---

## 📝 Amendment Process

To change these rules:

1. Create PR with proposed changes to this file
2. Get approval from MMOS architecture owner
3. Update IDE configs (.claude/CLAUDE.md, .cursor/global-rules.md)
4. Update enforcement mechanisms (hooks, CI/CD)
5. Communicate changes to team

---

**Enforcement Level:** CRITICAL
**Violations:** Will be rejected in code review
**Automated Checks:** TODO (pre-commit hook, CI/CD)
