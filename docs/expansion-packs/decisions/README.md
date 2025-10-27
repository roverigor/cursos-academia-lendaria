# Architecture Decision Records (ADRs)

**Important architectural decisions affecting expansion packs**

---

## Purpose

Architecture Decision Records (ADRs) document:
- ✅ **Why** we made architectural choices
- ✅ **What** alternatives were considered
- ✅ **Consequences** of the decision
- ✅ **Context** at the time of decision

---

## When to Create ADR

Create an ADR when deciding:
- System architecture patterns
- Integration approaches
- Database design choices
- Contract versioning strategies
- Cross-pack communication methods
- Technology selections

**Examples:**
- "Why single database instead of per-pack databases?"
- "Why file-based contracts instead of REST APIs?"
- "Why monorepo instead of separate repos?"

---

## ADR Template

**Filename:** `ADR-XXX-title.md`

```markdown
# ADR-XXX: [Decision Title]

**Status:** Proposed | Accepted | Superseded by ADR-YYY | Deprecated
**Date:** YYYY-MM-DD
**Deciders:** [Names/Roles]

---

## Context

[What's the situation? What problem are we solving? What constraints exist?]

**Background:**
- [Relevant background information]

**Drivers:**
- [What's driving this decision]

---

## Decision

[What did we decide?]

**Chosen Approach:**
[Describe the solution]

**Reasoning:**
[Why did we choose this approach?]

---

## Alternatives Considered

### Alternative 1: [Name]

**Description:**
[What is this alternative?]

**Pros:**
- [Pro 1]
- [Pro 2]

**Cons:**
- [Con 1]
- [Con 2]

**Why Not Chosen:**
[Specific reasons]

---

### Alternative 2: [Name]

...

---

## Consequences

### Positive
- [Benefit 1]
- [Benefit 2]

### Negative
- [Drawback 1]
- [Drawback 2]

### Neutral
- [Tradeoff 1]
- [Tradeoff 2]

---

## Implementation

**Packs Affected:**
- [Pack 1]: [What changes]
- [Pack 2]: [What changes]

**Timeline:**
- [When to implement]

**Migration Plan:**
- [How to migrate from previous approach, if applicable]

---

## Compliance

**How to verify compliance:**
- [ ] Check 1
- [ ] Check 2

**Tools:**
- [Linters, tests, etc. to enforce decision]

---

## References

- [Related ADRs]
- [External documentation]
- [Research papers, blog posts]

---

## Revision History

| Date | Change | Author |
|------|--------|--------|
| YYYY-MM-DD | Initial decision | [Name] |
```

---

## ADR Lifecycle

### Proposed
- Decision is being discussed
- Not yet finalized

### Accepted
- Decision is finalized
- Should be followed in new development

### Superseded
- A newer ADR replaces this one
- Link to successor ADR
- Historical reference only

### Deprecated
- Decision no longer applies
- Don't use in new development

---

## Active ADRs

| ADR | Title | Status | Date | Packs |
|-----|-------|--------|------|-------|
| ADR-001 | [Example] | Accepted | 2025-10-27 | All |

---

## ADR Index by Topic

### Architecture Patterns
- (none yet)

### Integration Approaches
- (none yet)

### Database Design
- (none yet)

### Security
- (none yet)

---

## Important Decisions to Document

**Candidates for ADRs:**

1. **Single Database vs Per-Pack Databases**
   - Why: Unified data model, referential integrity
   - Tradeoff: Increased coupling

2. **File-Based Contracts vs REST APIs**
   - Why: Simplicity, git versioning
   - Tradeoff: No real-time updates

3. **Monorepo vs Multi-Repo**
   - Why: Atomic commits, easier dependency management
   - Tradeoff: Single point of failure

4. **Optional Dependencies Pattern**
   - Why: Graceful degradation
   - Tradeoff: More complexity in integration logic

5. **AIOS Compliance Requirement**
   - Why: Consistent UX, reusable infrastructure
   - Tradeoff: Must follow AIOS patterns

---

## How to Propose ADR

1. **Identify decision** needing documentation
2. **Create ADR** using template
3. **Set status** to "Proposed"
4. **Discuss** with System Architect + Pack Maintainers
5. **Revise** based on feedback
6. **Accept** once consensus reached
7. **Update** ADR index

---

**See also:**
- [Architecture](../architecture.md) - Current architecture
- [Governance](../governance.md) - Decision process
- [Michael Nygard's ADR article](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions) - ADR origin
