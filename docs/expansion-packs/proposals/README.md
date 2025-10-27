# Epic Proposals

**Proposed system-level epics awaiting review**

---

## Purpose

This directory contains **proposed epics** that:
- Have not yet been reviewed by System Architect
- Are being discussed by stakeholders
- Need feasibility assessment

---

## Proposal Lifecycle

```
proposals/ → (review) → epics/ (approved)
           ↘ (reject) → proposals/rejected/
```

1. **Submitted** - Proposal created in `proposals/`
2. **Under Review** - System Architect + Pack Maintainers reviewing
3. **Approved** - Moved to `epics/`, planning begins
4. **Rejected** - Moved to `proposals/rejected/` with reason

---

## Proposal Template

**Filename:** `YYYYMMDD-epic-name.md`

```markdown
# Epic Proposal: [Name]

**Submitted:** YYYY-MM-DD
**Submitter:** [Name]
**Status:** Submitted | Under Review | Approved | Rejected

---

## Problem Statement

[What problem are we solving?]

**Context:**
- [Background information]
- [Why this is important now]

**Current Pain:**
- [Specific pain points]

---

## Proposed Solution

[High-level solution approach]

**Benefits:**
- [Benefit 1]
- [Benefit 2]

**Success Metrics:**
- [How we'll measure success]

---

## Packs Affected

### [Pack Name 1]
**Changes Required:**
- [Change 1]
- [Change 2]

**Estimated Effort:** X-Y points

### [Pack Name 2]
**Changes Required:**
- [Change 1]

**Estimated Effort:** X-Y points

---

## Integration Points

### New Integrations
- **[Provider → Consumer]**: [Description]
  - Type: File | Database | Directory
  - Interface: [Format]

### Modified Integrations
- **[Provider → Consumer]**: [What changes]
  - Current version: vX.X.X
  - Proposed version: vY.Y.Y (MAJOR | MINOR)

---

## Database Changes

**New Tables:**
- `[table_name]`: [Purpose, key columns]

**Modified Tables:**
- `[table_name]`: [Changes]

**Migrations Required:** Yes | No

---

## Alternatives Considered

### Alternative 1: [Approach Name]
**Pros:**
- [Pro 1]

**Cons:**
- [Con 1]

**Why Not Chosen:**
- [Reason]

### Alternative 2: [Approach Name]
...

---

## Risks & Mitigation

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| [Risk 1] | High/Medium/Low | High/Medium/Low | [How to address] |

---

## Estimated Effort

**Total:** XX-YY points

**Breakdown:**
- [Pack 1]: X-Y points
- [Pack 2]: X-Y points
- Integration: X-Y points

**Timeline:** X-Y weeks

---

## Dependencies

**Requires:**
- [Dependency 1]
- [Dependency 2]

**Blocks:**
- [What this would unblock]

---

## Questions for Review

1. [Question 1 for reviewers]
2. [Question 2 for reviewers]

---

## Discussion

### Comments

**[Name] - YYYY-MM-DD:**
[Comment or question]

**[Name] - YYYY-MM-DD:**
[Response]

---

## Review Decision

**Date:** YYYY-MM-DD
**Decision:** Approved | Rejected | Needs More Info

**Reasoning:**
[Why this decision was made]

**Next Steps:**
- [If approved: move to epics/, begin planning]
- [If rejected: move to proposals/rejected/, document reason]
- [If more info: what additional info needed]

---

**Reviewers:**
- [ ] System Architect: [Name]
- [ ] [Pack 1] Maintainer: [Name]
- [ ] [Pack 2] Maintainer: [Name]
- [ ] Database Owner: [Name]
```

---

## How to Submit Proposal

1. **Create file:** `YYYYMMDD-epic-name.md`
2. **Fill template** above
3. **Notify reviewers** (Slack/Discord/GitHub)
4. **Await review** (target: 1 week)

---

## Active Proposals

| Proposal | Submitted | Submitter | Status |
|----------|-----------|-----------|--------|
| (none yet) | - | - | - |

---

## Recent Decisions

### Approved
| Proposal | Date | Now Epic |
|----------|------|----------|
| (none yet) | - | - |

### Rejected
| Proposal | Date | Reason |
|----------|------|--------|
| (none yet) | - | - |

---

**See also:**
- [Epics](../epics/) - Approved epics
- [Governance](../governance.md) - Review process
