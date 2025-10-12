# MMOS Stories

This directory contains all detailed story specifications for the MMOS (Mind Mapper OS) project.

## Story Organization

Stories are organized by Epic and follow the naming convention: `story-{epic}.{number}-{name}.md`

---

## Epic 1: AIOS-first Orchestration

**Goal:** Automate and orchestrate the MMOS pipeline execution using AIOS agents.

### Story 1.1: AIOS Launcher ✅ COMPLETE
**File:** `story-1.1-aios-launcher.md`
**Status:** Ready for Development
**Estimate:** 3-4 days

CLI launcher that maps prompts to agents and injects automatic context for MMOS executions.

**Key Features:**
- CLI accepts mind_name, stage, prompt_id
- Displays context summary before execution
- Suggests output destinations
- Registers invocation logs
- Supports concurrent launches

---

### Story 1.2: Orchestration Board & Telemetry
**File:** `story-1.2-orchestration-board.md`
**Status:** Ready for Development
**Estimate:** 4-5 days

Visual board showing pipeline progress with telemetry and checkpoints.

**Key Features:**
- Progress visualization per mind (59 prompts tracked)
- Checkpoint logging (6 validation gates)
- Telemetry dashboard (performance, bottlenecks)
- Auto-refresh mode (--watch)
- Export snapshots

---

### Story 1.3: Brownfield Assistant
**File:** `story-1.3-brownfield-assistant.md`
**Status:** Ready for Development
**Estimate:** 5-6 days

Intelligent assistant for re-executing prompts on existing minds (brownfield updates).

**Key Features:**
- Detects prompts needing re-execution
- Diff analysis (before/after)
- Rollback capabilities
- Batch brownfield updates
- Validation checkpoints

---

### Story 1.4: Auto-Execution Engine
**File:** `story-1.4-auto-execution-engine.md`
**Status:** Ready for Development
**Estimate:** 6-7 days

Fully automated pipeline execution from viability to testing.

**Key Features:**
- Automatic agent invocation
- Dependency resolution
- Parallel execution where possible
- Error recovery
- Quality gates

---

## Epic 3: Taxonomy Normalization & Migration

**Goal:** Normalize and standardize taxonomy across all 32+ minds.

### Story 3.1: Backward Compatible Additions ✅ PILOT COMPLETE
**File:** `story-3.1-backward-compatible-additions.md`
**Status:** ✅ PILOT COMPLETE (1/28 minds migrated: sam_altman)
**Estimate:** 3-4 days
**Pilot Completed:** October 12, 2025

Add standardized metadata files to all minds without breaking existing structure.

**Pilot Deliverables:**
- 5 migration scripts + 4 utility libraries
- Tested successfully on sam_altman mind
- All 5 new files created (metadata.yaml, sources_master.yaml, pipeline_progress.yaml, etl_questions.yaml, versioned system_prompts)
- Ready for Epic 2 database testing

**Full Rollout:** Story 3.1.1 (pending - 27 remaining minds)

**Key Features:**
- Creates `metadata.yaml` for all minds
- Generates `sources_master.yaml` catalog
- Creates `pipeline_progress.yaml` tracking
- Initializes `kb/etl_questions.yaml` template
- Reorganizes `system_prompts/` with versioning

**Deliverables:**
- ✅ 5 migration scripts implemented
- ✅ Orchestration script (`migrate_story_3.1.sh`)
- ✅ 4 utility libraries
- ✅ Tested on sam_altman mind
- ✅ All scripts idempotent and backward compatible

**Usage:**
```bash
# Single mind
bash scripts/migration/migrate_story_3.1.sh docs/minds/sam_altman

# All minds
bash scripts/migration/migrate_story_3.1.sh --all

# Dry run
bash scripts/migration/migrate_story_3.1.sh --dry-run sam_altman
```

---

### Story 3.2: Artifacts Layer Reorganization
**Status:** Pending
**Estimate:** 2-3 days

Organize artifacts by DNA Mental™ layers (layer_1/ through layer_8/).

---

### Story 3.3: Database Population & Validation
**Status:** Pending
**Estimate:** 5-7 days

Populate SQLite database from normalized files with validation.

---

### Story 3.4: Export Tools & Round-Trip Validation
**Status:** Pending
**Estimate:** 3-4 days

Ensure database can export back to files losslessly.

---

### Story 3.5: Validation Tooling & CI/CD
**Status:** Pending
**Estimate:** 4-5 days

Automate taxonomy compliance validation with CI/CD integration.

---

### Story 3.6: Migration Scripts & Rollback
**Status:** Pending
**Estimate:** 5-6 days

Complete migration tooling with safety guarantees and rollback.

---

### Story 3.7: Documentation & Governance
**Status:** Pending
**Estimate:** 3-4 days

Complete documentation and establish governance policies.

---

### Story 3.8: Cognitive Profiling System
**Status:** Pending
**Estimate:** 4-5 days

Implement personality assessment tracking (DISC, MBTI, Enneagram, Big Five).

---

### Story 3.9: Specialization Taxonomy & Database
**Status:** Pending
**Estimate:** 5-6 days

Create complete specialization hierarchy (413 proficiencies across 6 domains).

---

### Story 3.10: Mind Scoring System
**Status:** Pending
**Estimate:** 6-7 days

Implement evidence-based scoring across specializations/skills/proficiencies.

---

### Story 3.11: Mind Recommendation Engine
**Status:** Pending
**Estimate:** 4-5 days

Query system for finding best minds for specific tasks/domains.

---

### Story 3.12: Cognitive Profiling Data Migration
**Status:** Pending
**Estimate:** 8-10 days

Populate cognitive profiles and scores for existing minds.

---

### Story 3.13: Profiling Analytics & Visualization
**Status:** Pending
**Estimate:** 3-4 days

Create analytics tools for profiling data visualization.

---

## Story Status Legend

- ✅ **COMPLETE** - Implementation finished, tested, and committed
- 🚧 **IN PROGRESS** - Currently being implemented
- 📋 **READY FOR DEVELOPMENT** - Specification complete, ready to start
- 📝 **DRAFT** - Specification in progress
- ⏸️ **PENDING** - Not yet started

---

## Epic Timeline

### Epic 1: AIOS Orchestration
- **Duration:** 4-6 weeks
- **Stories:** 4 (1.1-1.4)
- **Status:** Story 1.1 complete

### Epic 3: Taxonomy Normalization
- **Duration:** 11-14 weeks
- **Stories:** 13 (3.1-3.13)
- **Status:** Story 3.1 complete (8% of epic)

---

## References

- **Epics:** `docs/mmos/epics/`
- **Architecture:** `docs/mmos/architecture/`
- **PRD:** `docs/mmos/docs/PRD.md`
- **Migration Scripts:** `scripts/migration/`

---

## Contributing

When creating new stories:

1. Follow naming convention: `story-{epic}.{number}-{name}.md`
2. Include all sections: User Story, Acceptance Criteria, Technical Design, Testing Strategy
3. Add entry to this README
4. Link to parent Epic
5. Commit with message: `docs: create Story X.Y - {name}`

---

**Last Updated:** October 12, 2025
**Total Stories:** 17 (2 complete, 15 pending)
