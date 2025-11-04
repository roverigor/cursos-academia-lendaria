# Documentation Rules - Preventing Future Entropy

**Purpose:** Maintain clean, discoverable, and consistent documentation across the Mente Lendária project.

**Last Updated:** 2025-11-04

---

## 1. Status Headers Required

Every epic, pack README, and major feature document MUST have a status header:

```markdown
**Status:** [Choose one]
  - ✅ PRODUCTION - Fully implemented and tested
  - 🚧 IN PROGRESS - Active development
  - 🚧 RESEARCH - Exploration phase
  - ⏸️ NOT STARTED - Planned but not begun
  - ❌ DEPRECATED - No longer maintained

**Version:** vX.Y.Z (if applicable)
**Last Updated:** YYYY-MM-DD
```

### Examples

**Production Pack:**
```markdown
**Status:** ✅ PRODUCTION
**Version:** v2.0.0
**Last Updated:** 2025-11-04
```

**Research Pack:**
```markdown
**Status:** 🚧 RESEARCH - Not Production Ready
**Version:** v0.1.0-alpha
**Last Updated:** 2025-11-04
```

**Future Epic:**
```markdown
**Status:** ⏸️ NOT STARTED - Vision Document
**Priority:** Future
**Blocked By:** Epic 2 completion
```

---

## 2. Single Source of Truth

Each type of information has ONE authoritative location:

| Information Type | Single Source | Update Frequency |
|-----------------|---------------|------------------|
| **System Status** | `docs/STATUS-SNAPSHOT.md` | Weekly |
| **Roadmap & Priorities** | `docs/MASTER-ROADMAP.md` | Sprint planning |
| **System Architecture** | `docs/expansion-packs/architecture.md` | On structural changes |
| **Integration Map** | `docs/expansion-packs/dependency-graph.md` | When integrations change |
| **Database Schema** | `docs/database/README.md` | After migrations |
| **Pack Status** | Pack's own `README.md` | On version release |

### Rule: Don't Duplicate, Link

❌ **DON'T:** Copy status information to multiple documents
✅ **DO:** Link to the single source

Example:
```markdown
For current system status, see [STATUS-SNAPSHOT.md](../docs/STATUS-SNAPSHOT.md)
```

---

## 3. Archival Policy

### When to Archive

Archive documentation when it's 2+ versions behind current:

- **Database schemas:** When current is v0.8.2, archive v0.6.x and older
- **Execution logs:** Archive monthly to `docs/archive/logs/YYYY-MM/`
- **Deprecated features:** Move to `docs/archive/deprecated/` immediately
- **Old epic plans:** Archive when epic is completed or abandoned

### Archive Structure

```
docs/archive/
├── database-history/     # Historical schemas
├── logs/                 # Execution logs by month
├── deprecated/           # Deprecated features
└── epic-history/         # Completed/abandoned epics
```

### How to Archive

```bash
# Example: Archiving old database schema
mkdir -p docs/archive/database-history
mv docs/database/evolution/0.6*.{md,sql} docs/archive/database-history/

# Add README to archive directory
echo "# Archive: Database v0.6" > docs/archive/database-history/README.md
echo "Archived on: $(date)" >> docs/archive/database-history/README.md
```

---

## 4. Epic Documentation

### Epic Status Lifecycle

Epics move through these states:

1. **⏸️ NOT STARTED** - Vision/planning document only
2. **🚧 IN PROGRESS** - Active development
3. **✅ COMPLETED** - All stories delivered
4. **❌ ABANDONED** - No longer pursuing

### Epic Header Template

```markdown
# Epic N: [Epic Name]

**Status:** [Status from above]
**Progress:** X% (Y/Z stories)
**Owner:** [Team/Person]
**Blocked By:** [Dependencies if any]
**Last Updated:** YYYY-MM-DD

## Vision
[Keep vision in future tense if not started]

## Current State
[Only if IN PROGRESS or COMPLETED]
```

---

## 5. Acceptable vs Unacceptable Duplication

### ✅ Acceptable Duplication

These cases of duplication are OK:

- **Pack README + System README** - Different audiences, different depth
- **Quick Start + Full Guide** - Progressive disclosure of complexity
- **Current Schema + Historical Schemas** - Archived separately
- **Vision (future) + Status (current)** - Different temporal states

### ❌ Unacceptable Duplication

Never duplicate:

- **Status information** - Use STATUS-SNAPSHOT.md only
- **Version numbers** - Single source per component
- **Database schema** - One current schema only
- **Integration contracts** - One version per integration
- **Conflicting information** - Never have contradictory data

### Conflict Resolution

When you find conflicting information:

1. Identify which is the designated "single source"
2. Update the single source with correct information
3. Replace duplicates with links to single source
4. Document the resolution in commit message

---

## 6. Documentation Quality Checklist

Before committing documentation:

- [ ] **Status header present?** (for major docs)
- [ ] **No contradictions?** (check version numbers, status)
- [ ] **Links working?** (relative paths preferred)
- [ ] **Old versions archived?** (not deleted)
- [ ] **Single source respected?** (no unauthorized duplication)

---

## 7. File Naming Conventions

### Standard Patterns

- **Epics:** `epic-N-short-name.md` (e.g., `epic-4-clone-arena.md`)
- **Stories:** `story-N.M-short-name.md` (e.g., `story-2.4-pipeline-integration.md`)
- **Archives:** Include version (e.g., `v0.6_schema.sql`)
- **Logs:** Include date (e.g., `2025-11-04-session.md`)

### Case Convention

- **Files:** lowercase with hyphens (`my-document.md`)
- **Directories:** lowercase with hyphens (`database-history`)
- **Constants:** UPPERCASE (`README.md`, `STATUS-SNAPSHOT.md`)

---

## 8. Preventing Future Entropy

### Weekly Maintenance Tasks

1. **Update STATUS-SNAPSHOT.md** - Reflect current state
2. **Check for contradictions** - Scan for version mismatches
3. **Archive old logs** - Move execution logs monthly
4. **Update epic progress** - Mark completed stories

### Sprint Planning Tasks

1. **Update MASTER-ROADMAP.md** - Adjust priorities
2. **Review epic statuses** - Move from NOT STARTED → IN PROGRESS
3. **Archive completed work** - Move finished epics to archive

### Monthly Cleanup

1. **Archive old schemas** - Move outdated database versions
2. **Consolidate logs** - Compress and archive by month
3. **Review documentation** - Check for accuracy
4. **Update pack versions** - After releases

---

## 9. Enforcement

### Pre-commit Checks

Consider adding git hooks to check:
- Status headers present
- No version conflicts
- No duplicate STATUS information
- Links are valid

### Code Review

Reviewers should verify:
- Documentation follows these rules
- No unauthorized duplication
- Status headers accurate
- Archival policy followed

---

## 10. Quick Reference

### Where Things Go

| Content Type | Location |
|-------------|----------|
| Current status | `docs/STATUS-SNAPSHOT.md` |
| Roadmap | `docs/MASTER-ROADMAP.md` |
| Architecture | `docs/expansion-packs/architecture.md` |
| Pack docs | `expansion-packs/{pack}/README.md` |
| Historical | `docs/archive/` |
| Epic plans | `docs/mmos/epics/` (with status headers) |
| Stories | `docs/mmos/stories/` or `docs/stories/` |
| Guides | `docs/guides/` |

### Status Indicators

- ✅ = Production/Complete
- 🚧 = In Progress/Research
- ⏸️ = Not Started/Paused
- ❌ = Deprecated/Abandoned
- 🟡 = Warning/Needs Attention

---

**Remember:** The goal is clarity and discoverability, not perfection. When in doubt, link to the single source of truth rather than duplicating information.