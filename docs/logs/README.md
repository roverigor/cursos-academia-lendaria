# Execution Logs

**Purpose:** Process execution logs and session documentation (versioned)

---

## 📁 Structure

This directory contains **execution logs** that document:
- MMOS pipeline executions
- Refactoring sessions
- Architecture decisions
- Data migrations
- Quality assurance sessions

**Note:** Unlike `outputs/`, logs here are **versioned** as they serve as process documentation and historical record.

---

## 📝 Log Types

### Process Logs
- Pipeline execution logs
- Workflow execution records
- Agent interaction logs
- Task completion logs

### Decision Logs
- Architecture decision records
- Migration documentation
- Refactoring session logs
- Quality assurance reports

### Session Logs
- Development session notes
- Debugging sessions
- Analysis sessions
- Validation sessions

---

## 📚 Naming Convention

### Format
```
YYYY-MM-DD-description.md
```

### Examples
- `2025-10-16-brownfield-architecture.md` - Architecture analysis session
- `20251005-CORRECOES_DOCUMENTAIS.md` - Document corrections session
- `20250928-2218-ANALISE_ESTRUTURAL_CLONES.md` - Clone structure analysis

---

## 🎯 When to Create Logs

Create logs for:
1. **Major refactorings** - Document what changed and why
2. **Architecture decisions** - Record decision rationale
3. **Data migrations** - Track migration process and results
4. **Quality issues** - Document problems found and fixes applied
5. **Long sessions** - Record significant development sessions

Do NOT create logs for:
- Routine commits (use commit messages)
- Minor edits (use git history)
- Temporary debugging (delete after fixing)

---

## 📚 Related Documentation

- **Architecture:** `docs/architecture/` - System design documents
- **Stories:** `docs/stories/` - Development stories and tasks
- **Outputs:** `outputs/` - Generated artifacts (not versioned)
- **MMOS Reports:** `docs/mmos/reports/` - Executive reports

---

## ✍️ Log Template

```markdown
# [Brief Title]

**Date:** YYYY-MM-DD
**Type:** [Process/Decision/Session]
**Participants:** [Names or "Solo"]
**Duration:** [Approximate time]

---

## Context

Why was this session needed?

## Objectives

What were we trying to accomplish?

## Actions Taken

What did we do? (step by step)

## Results

What was accomplished?

## Issues Found

Any problems discovered?

## Next Steps

What needs to happen next?

---

**Status:** [Completed/Ongoing/Blocked]
**Follow-up:** [Links to related docs or tasks]
```

---

## 🔍 Searching Logs

### Find logs by topic
```bash
grep -r "keyword" docs/logs/
```

### List recent logs
```bash
ls -lt docs/logs/*.md | head -10
```

### Find logs by date
```bash
ls docs/logs/2025-10-* | sort
```

---

**Created:** 2025-10-17
**Location:** `docs/logs/`
**Versioned:** Yes (committed to git)
