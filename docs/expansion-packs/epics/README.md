# System-Level Epics

**Epics that affect multiple expansion packs**

---

## What Goes Here

Create system-level epics in this directory when:

✅ **Feature affects 2+ expansion packs**
- Example: Voice fidelity boost requires changes in MMOS + CreatorOS

✅ **New integration point created**
- Example: InnerLens → CreatorOS direct integration

✅ **Database schema changes**
- Example: Add Big Five columns to minds table

✅ **Architectural changes**
- Example: Migrate from file contracts to API contracts

---

## Epic Template

Use this template for new epics:

```markdown
# Epic: [Name]

**ID:** EPIC-XXX
**Status:** Proposed | Planning | In Progress | Completed
**Created:** YYYY-MM-DD
**Packs Affected:** [List packs]

## Problem Statement

[What problem are we solving? Why now?]

## Proposed Solution

[High-level solution approach]

## Packs Breakdown

### [Pack Name 1]

**Changes Required:**
- [Change 1]
- [Change 2]

**Estimated Effort:** X points

### [Pack Name 2]

**Changes Required:**
- [Change 1]

**Estimated Effort:** X points

## Integration Points

### New Integrations
- [Provider → Consumer]: [Description]

### Modified Integrations
- [Provider → Consumer]: [Changes to v1.0.0 contract]

## Database Changes

**New Tables:**
- [table_name]: [description]

**Modified Tables:**
- [table_name]: [changes]

**Migrations:**
- [migration_name.sql]: [description]

## Contracts Affected

- `[contract-name-v1.0.0.yaml]` → `v1.1.0` (MINOR: new optional field)
- `[contract-name-v2.0.0.yaml]` → `v2.0.0` (MAJOR: breaking change)

## Stories

### System-Level Stories
- [ ] Story 1: [Cross-pack story]

### Pack-Level Stories

**[Pack Name 1]:**
- [ ] Story 2: [Pack-specific]

**[Pack Name 2]:**
- [ ] Story 3: [Pack-specific]

## Acceptance Criteria

- [ ] All integration tests pass
- [ ] Contracts validated
- [ ] Documentation updated
- [ ] Migration applied successfully

## Total Effort

**Estimated:** XX points
**Actual:** XX points (update when complete)

## Risks & Mitigation

**Risk 1:** [Description]
**Mitigation:** [How to address]

## Dependencies

**Blocks:**
- [Epic XXX]

**Blocked By:**
- [Epic YYY]

## Timeline

**Start:** YYYY-MM-DD
**Target:** YYYY-MM-DD
**Actual:** YYYY-MM-DD (update when complete)

---

**Owner:** [System Architect]
**Contributors:** [Pack Maintainers]
```

---

## Active Epics

| ID | Name | Packs | Status | Owner |
|----|------|-------|--------|-------|
| EPIC-001 | [Example Epic] | MMOS, CreatorOS | Proposed | TBD |

---

## Completed Epics

| ID | Name | Packs | Completed | Result |
|----|------|-------|-----------|--------|
| - | (none yet) | - | - | - |

---

## Epic Lifecycle

1. **Proposed** - Epic created in `proposals/`
2. **Planning** - System Architect + Pack Maintainers break down into stories
3. **In Progress** - Stories being implemented
4. **Completed** - All stories done, epic closed

---

**See also:**
- [Governance Model](../governance.md) - Epic planning process
- [Proposals](../proposals/) - Proposed epics awaiting review
