# Expansion Packs - Governance Model

**Centralized coordination for evolution across all expansion packs**

---

## Purpose

This governance model ensures:
- ✅ **Coordinated evolution** - Changes across packs are planned together
- ✅ **Clear ownership** - Each pack has maintainers, but system has architects
- ✅ **Contract stability** - Integration points have versioned, stable contracts
- ✅ **Maximum integration** - Cross-pack features are identified and prioritized
- ✅ **Prevent duplication** - Similar features are consolidated, not duplicated

---

## Governance Structure

### Roles

| Role | Responsibility | Scope |
|------|----------------|-------|
| **System Architect** | Cross-pack architecture, integration design | All packs |
| **Pack Maintainer** | Pack-specific features, quality, documentation | Single pack |
| **Integration Owner** | Specific integration point contracts | 2+ packs |
| **Database Owner** | Schema design, migrations, data model | Database |

### Current Assignments

| Role | Assignee | Packs/Integrations |
|------|----------|-------------------|
| System Architect | *To be assigned* | All |
| MMOS Maintainer | *To be assigned* | MMOS |
| CreatorOS Maintainer | *To be assigned* | CreatorOS |
| InnerLens Maintainer | *To be assigned* | InnerLens |
| ETL Maintainer | *To be assigned* | ETL Data Collector |
| SuperAgentes Maintainer | *To be assigned* | SuperAgentes |
| Database Owner | *To be assigned* | Database |
| ETL→MMOS Integration Owner | *To be assigned* | ETL, MMOS |
| MMOS→CreatorOS Integration Owner | *To be assigned* | MMOS, CreatorOS |

---

## Planning Framework

### Epic Classification

**System-Level Epic** (`docs/expansion-packs/epics/`)
- Affects 2+ expansion packs
- Creates/modifies integration points
- Changes database schema
- Architectural changes

**Pack-Level Epic** (within pack's `docs/epics/`)
- Entirely within one expansion pack
- No new integration points
- Doesn't affect other packs

**Integration Epic** (`docs/expansion-packs/epics/integrations/`)
- Focuses on specific integration point
- May touch multiple packs but limited scope

### Decision Tree: Where to Create Epic?

```
Is this feature...
│
├─ Entirely within one pack?
│  └─> Pack-Level Epic (pack's docs/epics/)
│
├─ Affects 2+ packs?
│  │
│  ├─ Creates NEW integration?
│  │  └─> System-Level Epic (docs/expansion-packs/epics/)
│  │
│  ├─ Modifies EXISTING integration?
│  │  └─> Integration Epic (docs/expansion-packs/epics/integrations/)
│  │
│  └─ Changes database schema?
│     └─> System-Level Epic (docs/expansion-packs/epics/)
│
└─ Architectural change?
   └─> System-Level Epic (docs/expansion-packs/epics/)
```

---

## Epic Planning Process

### 1. Proposal Phase

**Who:** Anyone can propose system-level epic

**What to include:**
```markdown
# Epic Proposal: [Name]

## Problem
[What problem are we solving?]

## Packs Affected
- MMOS: [changes needed]
- CreatorOS: [changes needed]

## Integration Points
- New: [list new integrations]
- Modified: [list modified integrations]

## Database Changes
[Schema changes, new tables, migrations]

## Alternatives Considered
[Other approaches, why not chosen]

## Estimated Effort
[Story points across packs]
```

**Where:** Create in `docs/expansion-packs/proposals/YYYYMMDD-epic-name.md`

### 2. Review Phase

**Who:** System Architect + affected Pack Maintainers

**Process:**
1. System Architect reviews proposal
2. Affected Pack Maintainers provide feedback
3. Integration Owners assess contract changes
4. Database Owner reviews schema changes

**Outcome:** Approved → Planning | Rejected → Archived

### 3. Planning Phase

**Who:** System Architect with Pack Maintainers

**Process:**
1. Break epic into stories
2. Assign stories to packs
3. Define contract versions
4. Create migration plan (if database changes)
5. Estimate effort per pack

**Output:** Epic document in `docs/expansion-packs/epics/EPIC-XXX-name.md`

### 4. Implementation Phase

**Who:** Pack Maintainers

**Process:**
1. Pack Maintainers implement their stories
2. Integration Owners validate contract compliance
3. System Architect reviews cross-pack alignment
4. Database Owner applies migrations

**Coordination:** Weekly sync between affected packs

### 5. Validation Phase

**Who:** System Architect + QA

**Process:**
1. Integration tests across packs
2. Contract validation
3. Documentation review
4. Migration rollback testing

**Outcome:** Approved → Merge | Issues → Fix

---

## Contract Management

### What is a Contract?

A **contract** defines the interface between two expansion packs:
- Data format (YAML, JSON, file structure)
- Location (file paths, database tables)
- Required vs optional fields
- Versioning strategy
- Backward compatibility guarantees

### Contract Versioning

**Semantic Versioning:** `MAJOR.MINOR.PATCH`

- **MAJOR:** Breaking changes (consumer must update)
- **MINOR:** New optional fields (backward compatible)
- **PATCH:** Bug fixes, clarifications (fully compatible)

**Example:**
```yaml
# docs/expansion-packs/contracts/mmos-creator-os-v1.0.0.yaml
contract:
  name: "MMOS → CreatorOS Voice Integration"
  version: "1.0.0"
  status: "stable"
  provider: MMOS
  consumer: CreatorOS

  interface:
    format: "Markdown file"
    location: "outputs/minds/{slug}/system_prompts/generalista.md"
    encoding: "UTF-8"

    required_sections:
      - name: "Cognitive Patterns"
        format: "Markdown heading level 2"
        content: "DNA Mental analysis output"

      - name: "Communication Style"
        format: "Markdown heading level 2"
        content: "Synthesis phase output"

    optional_sections:
      - name: "Big Five Profile"
        format: "YAML frontmatter or markdown section"
        content: "InnerLens Big Five scores"
        added_in: "1.0.0"

  backward_compatibility:
    guarantees:
      - "Required sections will not be removed"
      - "Section order can change (consumers must not assume order)"
      - "New optional sections can be added in MINOR versions"

  breaking_changes_history:
    - version: "1.0.0"
      date: "2025-10-27"
      change: "Initial contract definition"
```

### Contract Lifecycle

1. **Draft** - Proposed contract, not yet implemented
2. **Experimental** - Implemented, may change frequently
3. **Stable** - Production-ready, follows semver
4. **Deprecated** - Scheduled for removal
5. **Retired** - No longer supported

### Contract Repository

All contracts live in: `docs/expansion-packs/contracts/`

**Naming convention:** `{provider}-{consumer}-v{version}.yaml`

**Examples:**
- `mmos-creator-os-v1.0.0.yaml`
- `innerlens-mmos-v1.0.0.yaml`
- `etl-mmos-v1.0.0.yaml`

---

## Cross-Pack Stories

### When to Create Cross-Pack Story

A story is **cross-pack** when:
- Implementation requires changes in 2+ packs
- Story cannot be completed by single pack alone
- Integration point is created or modified

### Cross-Pack Story Structure

```markdown
# Story: [Name]

**Type:** Cross-Pack
**Packs:** MMOS, CreatorOS
**Epic:** EPIC-005-voice-fidelity-boost

## User Story
As a [user], I want [capability], so that [benefit].

## Acceptance Criteria
- [ ] MMOS exports enhanced system prompt
- [ ] CreatorOS imports and validates system prompt
- [ ] Voice fidelity score ≥ 92%
- [ ] Integration tests pass

## Pack Breakdown

### MMOS Sub-Story
**Title:** Export enhanced system prompt with personality
**Owner:** MMOS Maintainer
**Effort:** 5 points

**Tasks:**
- [ ] Integrate InnerLens Big Five data into synthesis
- [ ] Generate enhanced system prompt format
- [ ] Export to standard location
- [ ] Update MMOS → CreatorOS contract to v1.1.0

### CreatorOS Sub-Story
**Title:** Import and apply personality-enhanced prompts
**Owner:** CreatorOS Maintainer
**Effort:** 3 points

**Tasks:**
- [ ] Read system prompt from MMOS output
- [ ] Parse Big Five section
- [ ] Apply personality adaptations during generation
- [ ] Validate fidelity score ≥ 92%

## Integration Story
**Title:** Validate MMOS → CreatorOS personality flow
**Owner:** Integration Owner
**Effort:** 2 points

**Tasks:**
- [ ] Create integration test
- [ ] Validate contract compliance
- [ ] Document usage in integration guide

## Total Effort
10 points (5 MMOS + 3 CreatorOS + 2 Integration)
```

---

## Database Governance

### Schema Changes

**Rule:** All schema changes go through Database Owner

**Process:**
1. Pack proposes schema change
2. Database Owner reviews
3. If approved, Database Owner creates migration
4. Migration tested in staging
5. Migration applied to production
6. All packs notified of schema change

### Migration Strategy

**Location:** `db/migrations/`

**Naming:** `YYYYMMDD-HHMMSS-description.sql`

**Example:**
```sql
-- db/migrations/20251027-143000-add-big-five-to-minds.sql
-- Epic: EPIC-005-voice-fidelity-boost
-- Packs affected: MMOS, InnerLens

BEGIN TRANSACTION;

-- Add Big Five columns to minds table
ALTER TABLE minds ADD COLUMN openness INTEGER;
ALTER TABLE minds ADD COLUMN conscientiousness INTEGER;
ALTER TABLE minds ADD COLUMN extraversion INTEGER;
ALTER TABLE minds ADD COLUMN agreeableness INTEGER;
ALTER TABLE minds ADD COLUMN neuroticism INTEGER;

-- Record migration
INSERT INTO migrations (version, description, applied_at)
VALUES ('20251027-143000', 'Add Big Five traits to minds table', datetime('now'));

COMMIT;
```

### Database Contract

**Current Schema Version:** 1.0.0

**Tables by Pack:**

| Pack | Tables Owned | Description |
|------|-------------|-------------|
| MMOS | `minds`, `cognitive_specs`, `mind_fragments` | Mind data |
| InnerLens | `sources`, `fragments`, `big_five_profiles` | Personality analysis |
| CreatorOS | `courses`, `lessons`, `content_pieces`, `content_projects` | Content generation |
| SuperAgentes | *(none, operates on all)* | Database operations |
| Shared | `metadata`, `migrations` | System metadata |

---

## Quality Standards

### Integration Testing

**Requirement:** All cross-pack features must have integration tests

**Location:** `tests/integration/`

**Example:**
```javascript
// tests/integration/mmos-creator-os-voice.test.js
describe('MMOS → CreatorOS Voice Integration', () => {
  it('should preserve 90%+ voice fidelity', async () => {
    // 1. Create mind with MMOS
    const mind = await MMOS.createMind('naval');

    // 2. Generate course with CreatorOS
    const course = await CreatorOS.generateCourse({
      slug: 'test-course',
      mind: mind
    });

    // 3. Validate fidelity
    const fidelity = await CreatorOS.validateFidelity(course);
    expect(fidelity).toBeGreaterThanOrEqual(0.90);
  });
});
```

### Documentation Requirements

**For System-Level Epics:**
- [ ] Epic document in `docs/expansion-packs/epics/`
- [ ] Contract definitions for new/modified integrations
- [ ] Integration guide in `docs/expansion-packs/guides/`
- [ ] Update `dependency-graph.md`
- [ ] Update affected pack READMEs

**For Pack-Level Features:**
- [ ] Epic document in pack's `docs/epics/`
- [ ] Update pack README
- [ ] Update pack's usage guide
- [ ] API documentation (if applicable)

---

## Decision Records

### Architecture Decision Records (ADRs)

**Location:** `docs/expansion-packs/decisions/`

**Format:**
```markdown
# ADR-XXX: [Decision Title]

**Status:** Proposed | Accepted | Superseded
**Date:** YYYY-MM-DD
**Deciders:** [Names/Roles]

## Context
[What's the problem? Why do we need to decide?]

## Decision
[What did we decide? Why?]

## Alternatives Considered
[What other options did we evaluate?]

## Consequences
- Positive: [benefits]
- Negative: [drawbacks]
- Neutral: [tradeoffs]

## Implementation
[How will this be implemented? Which packs affected?]
```

**Example Topics:**
- Single database vs per-pack databases
- Contract versioning strategy
- Epic classification criteria
- Integration testing approach

---

## Communication

### Regular Syncs

**System Architecture Review** - Monthly
- **Attendees:** System Architect + all Pack Maintainers
- **Agenda:** Roadmap, cross-pack epics, contract changes

**Integration Sync** - Weekly (during cross-pack development)
- **Attendees:** System Architect + affected Pack Maintainers
- **Agenda:** Integration progress, blockers, contract validation

**Database Review** - Bi-weekly
- **Attendees:** Database Owner + Pack Maintainers
- **Agenda:** Schema changes, migrations, performance

### Async Communication

**Channels:**
- System-level discussions: `docs/expansion-packs/discussions/`
- Pack-specific: GitHub Issues in pack directories
- Urgent: Slack/Discord #expansion-packs channel

---

## Evolution Process

### Adding New Expansion Pack

1. **Proposal Phase**
   - Create proposal in `docs/expansion-packs/proposals/`
   - System Architect reviews

2. **Planning Phase**
   - Define pack scope
   - Identify integration points with existing packs
   - Create contracts
   - Assign Pack Maintainer

3. **Implementation Phase**
   - Develop pack in `expansion-packs/{pack-name}/`
   - Implement integration contracts
   - Add to pack registry
   - Update dependency graph

4. **Validation Phase**
   - Integration tests
   - Documentation review
   - System Architect approval

5. **Launch**
   - Update `docs/expansion-packs/README.md`
   - Announce to team
   - Monitor adoption

### Deprecating Expansion Pack

1. **Deprecation Notice** (3 months before)
   - Announce deprecation
   - Provide migration path
   - Update status in registry

2. **Migration Phase** (3 months)
   - Help users migrate to alternatives
   - Maintain critical bug fixes only

3. **Retirement**
   - Archive pack
   - Remove from registry
   - Update dependency graph

---

## Questions & Escalation

### When to Escalate

Escalate to System Architect when:
- ❌ Cannot agree on contract format
- ❌ Uncertain if feature is system-level or pack-level
- ❌ Integration point blocked
- ❌ Database schema conflict
- ❌ Cross-pack breaking change needed

### Decision Authority

| Scope | Decision Maker |
|-------|----------------|
| Pack-specific feature | Pack Maintainer |
| Integration contract | Integration Owner (with both Pack Maintainers) |
| Database schema | Database Owner |
| Cross-pack epic | System Architect (with Pack Maintainers) |
| Architectural change | System Architect |

---

**Last Updated:** 2025-10-27
**Status:** Living document - update as governance evolves
**Next Review:** 2025-11-27
