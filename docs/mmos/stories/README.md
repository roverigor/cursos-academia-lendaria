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

## Epic 2: Database & Backend Foundation

**Goal:** Create unified database foundation storing all mind data with referential integrity.

### Story 2.1: Database Schema Design ✅ COMPLETED
**File:** `docs/mmos/database/schema_complete.sql`
**Status:** ✅ COMPLETED
**Completed:** October 12, 2025
**Commit:** `0be8803`

Design and implement unified database schema (v3.0.0) integrating MMOS + InnerLens + Specialization.

**Deliverables:**
- ✅ 989-line SQL schema with 17 core tables
- ✅ 10 triggers for auto-timestamps and validation
- ✅ 4 views for analytics and reporting
- ✅ Complete foreign key constraints
- ✅ Support for evidence-based scoring

---

### Story 2.2: Specialization Taxonomy Population ✅ COMPLETED
**File:** `docs/mmos/database/seed_specialization_taxonomy.sql`
**Status:** ✅ COMPLETED
**Completed:** October 12, 2025
**Commit:** `0be8803`

Populate complete specialization taxonomy (6 domains → 320 proficiencies).

**Deliverables:**
- ✅ 6 domains populated
- ✅ 22 specializations populated
- ✅ 73 skills populated
- ✅ 320 proficiencies populated
- ✅ Total: 421 taxonomy items with 100% referential integrity

**Domains:**
1. Business & Entrepreneurship (52 proficiencies)
2. Marketing & Sales (78 proficiencies)
3. Technology & Engineering (62 proficiencies)
4. Creative & Content (49 proficiencies)
5. Strategy & Consulting (35 proficiencies)
6. Personal Development (44 proficiencies)

---

### Story 2.3: Core Minds Population ✅ COMPLETED
**File:** `scripts/database/populate_minds.sh`
**Status:** ✅ COMPLETED
**Completed:** October 12, 2025
**Commit:** `0be8803`

Populate minds table with all 28 minds from outputs/minds/ directory.

**Deliverables:**
- ✅ Bash + Node.js scripts for mind population
- ✅ 28 minds inserted into database
- ✅ All with display_name, slug, status=active
- ✅ Default values: privacy_level=public, subject_type=public_figure

**Usage:**
```bash
# Bash version
bash scripts/database/populate_minds.sh

# Node.js version (requires better-sqlite3)
node scripts/database/populate_minds.js
```

---

### Story 2.4: Pipeline Integration 📋 READY FOR DEVELOPMENT
**File:** `story-2.4-pipeline-v3-integration.md`
**Status:** 📋 Ready for Development
**Estimate:** 2-3 days (8 story points)

Integrate MMOS collection pipeline with database v3.0.0 so processing a mind automatically populates sources, fragments, and analysis tables.

**Key Features:**
- Source population from sources_master.yaml
- Fragment extraction from cognitive-spec.yaml
- DNA Mental™ analysis import
- Validation module (referential integrity checks)
- Re-processing modes (fresh/update/skip)

**Dependencies:**
- Story 2.1 ✅
- Story 2.2 ✅
- Story 2.3 ✅
- Story 3.1 ✅ (for testing with sam_altman)

**Deliverables:**
- `populate-sources.js` - Read YAML, insert sources
- `import-analysis.js` - Store cognitive-spec as JSON
- `extract-fragments.js` - Extract evidence from layers
- `validate-integration.js` - Check data integrity
- `db-integration-v3.sh` - Orchestrate all modules

**Success Metrics:**
- <5 min total integration per mind
- 100% referential integrity
- 50-200 fragments extracted per mind
- All 3 re-processing modes working

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
bash scripts/migration/migrate_story_3.1.sh outputs/minds/sam_altman

# All minds
bash scripts/migration/migrate_story_3.1.sh --all

# Dry run
bash scripts/migration/migrate_story_3.1.sh --dry-run sam_altman
```

---

### Story 3.1.1: Full Migration Rollout (27 Minds) 📋 READY FOR DEVELOPMENT
**File:** `story-3.1.1-full-rollout.md`
**Status:** 📋 Ready for Development
**Estimate:** 1-2 days

Migrate remaining 27 minds using validated Story 3.1 scripts.

**Dependencies:**
- Story 3.1 ✅
- Story 2.4 (recommended - validates database integration first)

**Key Features:**
- Migrate 27 remaining minds (all except sam_altman)
- Validation suite implementation (validate_minds.js, validate_sources.js)
- 100% compliance checks
- Documentation updates (taxonomy-system.md, mind-onboarding.md, README.md)

**Success Metrics:**
- ✅ All 28 minds have metadata.yaml
- ✅ All 28 minds have sources_master.yaml
- ✅ All 28 minds have pipeline_progress.yaml
- ✅ Validation suite passes 100%
- ✅ Migration completes in <5 minutes

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
- **Status:** Story 1.1 complete (25% of epic)

### Epic 2: Database & Backend Foundation
- **Duration:** 9 days (October 12-20, 2025)
- **Stories:** 4 (2.1-2.4)
- **Status:** 75% complete (Stories 2.1-2.3 done, Story 2.4 in progress)

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

**Last Updated:** October 13, 2025
**Total Stories:** 21 (5 complete, 16 pending)
**Epic Sequence:** Epic 1 → Epic 2 → Epic 3 → Epic 4
