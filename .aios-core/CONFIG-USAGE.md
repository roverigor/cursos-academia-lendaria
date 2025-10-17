# AIOS Configuration Usage

## Multiple Configuration Files

This project uses different AIOS configurations depending on the context:

### 1. **core-config.yaml** (Default - AIOS General)
**When to use:** AIOS framework development, general infrastructure work

**Story Location:** `docs/stories/`

**Epic Pattern:** `epic-{n}*.md`

**Usage:**
```bash
# Automatically used for AIOS-related work
*create-story
```

### 2. **mmos-config.yaml** (MMOS-Specific)
**When to use:** MMOS pipeline development, mind cloning features

**Story Location:** `docs/mmos/stories/`

**Epic Pattern:** `EPIC-{n}*.md`

**Epic Location:** `docs/mmos/epics/`

**Usage:**
To activate MMOS config, use the MMOS slash prefix:
```bash
/MMOS:create-story
/MMOS:agents:dev
```

Or specify explicitly in agent commands when working on MMOS features.

---

## File Structure

### AIOS (General):
```
docs/
├── stories/           # AIOS framework stories
├── prd/               # AIOS PRD
└── architecture/      # AIOS architecture
```

### MMOS (Specific):
```
docs/
└── mmos/
    ├── stories/       # MMOS stories (Story 1.1, 1.2, etc.)
    ├── epics/         # MMOS epics (EPIC-1, EPIC-2, etc.)
    ├── board/         # Orchestration board
    ├── pipeline/      # Pipeline documentation
    └── architecture/  # MMOS-specific architecture
```

---

## IDE Configuration

Both Cursor and Claude Code are configured to recognize both paths:

### .cursor/global-rules.md
```markdown
1. **Always work from a story file** in docs/mmos/stories/ (MMOS-specific)
   or docs/stories/ (AIOS-general)
```

### .claude/CLAUDE.md
```markdown
1. **Work from stories** - All development starts with a story in
   `docs/mmos/stories/` (MMOS-specific) or `docs/stories/` (AIOS-general)
```

---

## How to Know Which Config to Use

### Work on MMOS? → Use `docs/mmos/stories/`
- Mind cloning pipeline
- DNA Mental™ features
- System prompt generation
- Mind validation
- MMOS orchestration board

### Work on AIOS? → Use `docs/stories/`
- AIOS framework core
- Agent system
- Workflow engine
- General infrastructure

---

## Epic Naming Convention

### AIOS:
```
docs/stories/epic-1-feature-name.md
docs/stories/epic-2-another-feature.md
```

### MMOS:
```
docs/mmos/epics/EPIC-1-orchestration-board.md
docs/mmos/epics/EPIC-2-clone-authenticity.md
```

Note the uppercase "EPIC" for MMOS to distinguish from AIOS epics.

---

## Common Mistakes to Avoid

### ❌ Wrong:
```bash
# Creating MMOS story in wrong location
touch docs/stories/story-2.1-clone-auth.md
```

### ✅ Correct:
```bash
# MMOS story in correct location
touch docs/mmos/stories/story-2.1-clone-auth.md
```

### ❌ Wrong:
```bash
# Using lowercase epic for MMOS
touch docs/mmos/epics/epic-2-auth.md
```

### ✅ Correct:
```bash
# Uppercase EPIC for MMOS
touch docs/mmos/epics/EPIC-2-clone-authenticity.md
```

---

## Configuration Override

If you need to temporarily override config, you can:

1. **Environment Variable:**
```bash
export AIOS_CONFIG=mmos-config.yaml
```

2. **Command Flag:**
```bash
aios-cli --config=mmos-config.yaml create-story
```

3. **Context Detection:**
The system should auto-detect based on:
- Current working directory
- Story file path being edited
- Slash command prefix (/MMOS vs /AIOS)

---

## Summary

| Aspect | AIOS | MMOS |
|--------|------|------|
| **Config File** | core-config.yaml | mmos-config.yaml |
| **Story Path** | docs/stories/ | docs/mmos/stories/ |
| **Epic Path** | docs/stories/ | docs/mmos/epics/ |
| **Epic Pattern** | epic-{n}-name.md | EPIC-{n}-name.md |
| **Slash Prefix** | /AIOS | /MMOS |
| **Use Case** | Framework dev | Mind cloning |

---

**Last Updated:** 2025-10-16
**Maintainer:** AIOS Core Team
