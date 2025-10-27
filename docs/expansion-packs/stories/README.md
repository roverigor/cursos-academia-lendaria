# Cross-Pack Stories

**Stories that span multiple expansion packs**

---

## What Goes Here

Create cross-pack stories when implementation requires:

✅ **Changes in 2+ packs** - Cannot be completed by single pack
✅ **Integration point creation/modification** - New contract or contract update
✅ **Coordinated development** - Implementation must be synchronized

---

## Story vs Epic

**Story:** Small, implementable unit (3-8 points)
**Epic:** Collection of stories (15-40+ points)

**Example:**
- Epic: "Voice Fidelity Boost" (25 points)
  - Story 1: Export enhanced prompts (MMOS, 5 points)
  - Story 2: Import personality data (CreatorOS, 3 points)
  - Story 3: Integration validation (2 points)

---

## Story Template

```markdown
# Story: [Name]

**ID:** STORY-XXX
**Type:** Cross-Pack
**Epic:** [EPIC-XXX] or Standalone
**Status:** Backlog | In Progress | Done
**Created:** YYYY-MM-DD

## User Story

As a [user type],
I want [capability],
So that [benefit].

## Acceptance Criteria

- [ ] Criterion 1 (testable)
- [ ] Criterion 2 (testable)
- [ ] Criterion 3 (testable)

## Pack Breakdown

### [Pack Name 1] Sub-Story

**Title:** [Sub-story title]
**Owner:** [Pack Maintainer]
**Effort:** X points
**Status:** Backlog | In Progress | Done

**Tasks:**
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

**Technical Details:**
[Implementation approach]

**Files Changed:**
- `file1.js`
- `file2.yaml`

---

### [Pack Name 2] Sub-Story

**Title:** [Sub-story title]
**Owner:** [Pack Maintainer]
**Effort:** X points
**Status:** Backlog | In Progress | Done

**Tasks:**
- [ ] Task 1
- [ ] Task 2

**Technical Details:**
[Implementation approach]

**Files Changed:**
- `file3.md`

---

## Integration Sub-Story

**Title:** Validate [Pack1] → [Pack2] integration
**Owner:** [Integration Owner]
**Effort:** 2 points
**Status:** Backlog | In Progress | Done

**Tasks:**
- [ ] Create integration test
- [ ] Validate contract compliance
- [ ] Update integration guide
- [ ] Test end-to-end workflow

**Test File:** `tests/integration/pack1-pack2.test.js`

---

## Contract Changes

**Affected Contracts:**
- `[contract-name-v1.0.0.yaml]` → `v1.1.0`

**Changes:**
- [List contract changes]

**Backward Compatible:** Yes | No

---

## Database Changes

**Affected Tables:**
- [table_name]: [changes]

**Migration:** `YYYYMMDD-HHMMSS-description.sql`

---

## Testing Strategy

**Unit Tests:**
- Pack 1: [test files]
- Pack 2: [test files]

**Integration Tests:**
- [test file]: [what it validates]

**E2E Tests:**
- [workflow test]: [complete user journey]

---

## Total Effort

**Estimated:** X points (breakdown: Pack1=X, Pack2=X, Integration=X)
**Actual:** X points (update when done)

## Definition of Done

- [ ] All acceptance criteria met
- [ ] All sub-stories completed
- [ ] Integration tests pass
- [ ] Contract validated
- [ ] Documentation updated
- [ ] Code reviewed
- [ ] Merged to main

---

## Dependencies

**Depends On:**
- [ ] STORY-YYY: [description]

**Blocks:**
- STORY-ZZZ: [description]

---

## Notes

[Implementation notes, gotchas, decisions made during development]

---

**Created By:** [Name]
**Assigned To:** [Pack Maintainers]
**Integration Owner:** [Name]
**Target Sprint:** [Sprint number]
```

---

## Active Stories

| ID | Name | Packs | Epic | Status | Points |
|----|------|-------|------|--------|--------|
| STORY-001 | [Example] | MMOS, CreatorOS | EPIC-001 | Backlog | 8 |

---

## Completed Stories

| ID | Name | Packs | Completed | Outcome |
|----|------|-------|-----------|---------|
| - | (none yet) | - | - | - |

---

## Story Lifecycle

1. **Backlog** - Story created, awaiting prioritization
2. **Ready** - Story prioritized, ready for development
3. **In Progress** - Sub-stories being implemented
4. **Review** - Code review, testing
5. **Done** - All criteria met, merged

---

## Estimation Guide

**1-2 points:** Trivial (1-2 hours)
- Update documentation
- Minor config change

**3-5 points:** Small (0.5-1 day)
- Add new optional field to contract
- Simple integration test

**5-8 points:** Medium (1-2 days)
- Implement new task
- Create new integration point

**13+ points:** Large (3+ days)
- Major feature
- Should be broken down into smaller stories

---

**See also:**
- [Epics](../epics/) - Parent epics for these stories
- [Governance](../governance.md) - Story planning process
