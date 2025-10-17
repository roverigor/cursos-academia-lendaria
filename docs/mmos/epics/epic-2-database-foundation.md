# Epic 2: Database & Backend Foundation

**Epic ID:** MMOS-Epic-2
**Status:** 🚧 75% Complete (3/4 stories done)
**Priority:** HIGH
**Timeline:** October 12-20, 2025
**Owner:** Backend Team + Database Architect

---

## Epic Goal

Create a unified database foundation that stores all mind data (MMOS + InnerLens + Specialization taxonomy) with complete referential integrity and evidence-based scoring capabilities.

---

## Strategic Context

**Problem:**
Mind data was scattered across YAML files with no centralized query capability, making it impossible to:
- Score minds across specializations
- Find best mind for a specific task
- Track evidence chains for claims
- Compare minds systematically

**Solution:**
Build a unified SQLite database (v3.0.0) that integrates:
- MMOS cognitive architecture (DNA Mental™ 8 layers)
- InnerLens psychological profiling (120 traits)
- Specialization taxonomy (6 domains → 320 proficiencies)

**Impact:**
- ✅ Query any mind by domain/skill/proficiency
- ✅ Evidence-based scoring with traceability
- ✅ Systematic mind comparison and recommendations
- ✅ Foundation for all future analytics

---

## Success Criteria

### Must Have:
- ✅ Unified schema supporting MMOS + InnerLens + Specialization
- ✅ 17+ core tables with referential integrity
- ✅ Complete specialization taxonomy (6 domains, 320 proficiencies)
- ✅ All 28 minds in database with basic metadata
- ✅ Pipeline integration scripts (sources, fragments, analysis)
- ✅ Validation tooling for data integrity

### Should Have:
- 🎯 Sample data for 1 mind (sam_altman) fully populated
- 🎯 Performance benchmarks (<5 min per mind integration)
- 🎯 Backup/restore procedures

### Could Have:
- ⏳ Real-time sync (file changes → database updates)
- ⏳ Migration from v2.x databases (if any exist)

---

## Stories

### Story 2.1: Database Schema Design ✅ COMPLETED
**Status:** ✅ Completed October 12, 2025
**Story Points:** 8
**Commit:** `0be8803`

**Deliverables:**
- ✅ `schema_complete.sql` (989 lines)
- ✅ 17 core tables (minds, sources, fragments, analysis, etc.)
- ✅ 4 taxonomy tables (domains, specializations, skills, proficiencies)
- ✅ 10 triggers (auto-timestamps, validation)
- ✅ 4 views (analytics, reporting)
- ✅ Complete foreign key constraints

**Technical Highlights:**
- Unified schema (no separate InnerLens tables)
- Fragments as universal evidence units
- Evidence traceability (all scores link to fragments)
- Support for both public figures and private users
- SQLite 3.35+ with PostgreSQL-compatible design

---

### Story 2.2: Specialization Taxonomy Population ✅ COMPLETED
**Status:** ✅ Completed October 12, 2025
**Story Points:** 5
**Commit:** `0be8803`

**Deliverables:**
- ✅ `seed_specialization_taxonomy.sql` (595 lines)
- ✅ 6 domains populated
- ✅ 22 specializations populated
- ✅ 73 skills populated
- ✅ 320 proficiencies populated
- ✅ Total: 421 taxonomy items

**Domains:**
1. Business & Entrepreneurship (52 proficiencies)
2. Marketing & Sales (78 proficiencies)
3. Technology & Engineering (62 proficiencies)
4. Creative & Content (49 proficiencies)
5. Strategy & Consulting (35 proficiencies)
6. Personal Development (44 proficiencies)

**Validation:**
- ✅ 100% referential integrity
- ✅ All proficiencies link to valid skills
- ✅ All skills link to valid specializations
- ✅ All specializations link to valid domains
- ✅ No orphaned records

---

### Story 2.3: Core Minds Population ✅ COMPLETED
**Status:** ✅ Completed October 12, 2025
**Story Points:** 3
**Commit:** `0be8803`

**Deliverables:**
- ✅ `populate_minds.sh` script
- ✅ `populate_minds.js` (Node.js version - needs better-sqlite3)
- ✅ 28 minds inserted into database

**Minds Populated:**
Alan Nicolas, Alex Hormozi, Andrej Karpathy, Brad Frost, Dan Kennedy, Dan Koe, Daniel Kahneman, Elon Musk, Eugene Schwartz, Gary Vee, Jesus Cristo, Kapil Gupta, Leonardo Da Vinci, Mark Manson, Nassim Taleb, Naval Ravikant, Paul Graham, Pedro Valerio, Peter Thiel, Ricky And Morty, Russel Brunson, Sam Altman, Seth Godin, Steve Jobs, Steven Pinker, Tim Ferriss, Walt Disney, Yuval Harari

**Data Quality:**
- ✅ All slugs unique
- ✅ All display_names set
- ✅ All timestamps valid
- ✅ Default values: status=active, privacy_level=public, subject_type=public_figure

---

### Story 2.4: Pipeline Integration 📋 READY FOR DEVELOPMENT
**Status:** 📋 Ready for Development (renamed from Story 4.1)
**Story Points:** 8
**Estimate:** 2-3 days
**File:** `story-2.4-pipeline-v3-integration.md`

**Goal:** Integrate MMOS collection pipeline with database v3.0.0 so that processing a mind automatically populates sources, fragments, and analysis tables.

**Scope:**
- ✅ Source population from sources_master.yaml
- ✅ Fragment extraction from cognitive-spec.yaml
- ✅ Analysis import (DNA Mental™ 8-layer spec)
- ✅ Validation module (referential integrity checks)
- ✅ Re-processing modes (fresh/update/skip)

**Out of Scope (Story 4.2+):**
- InnerLens 120-trait integration
- Automated proficiency scoring
- Fragment tags generation

**Dependencies:**
- Story 2.1 ✅
- Story 2.2 ✅
- Story 2.3 ✅
- Story 3.1 ✅ (for testing with sam_altman data)

**Deliverables:**
1. `populate-sources.js` - Read YAML, insert sources
2. `import-analysis.js` - Store cognitive-spec as JSON
3. `extract-fragments.js` - Extract evidence from layers
4. `validate-integration.js` - Check data integrity
5. `db-integration-v3.sh` - Orchestrate all modules

**Success Metrics:**
- <5 min total integration per mind
- 100% referential integrity
- 50-200 fragments extracted per mind
- All 3 re-processing modes working

---

## Dependencies

### Epic 2 Depends On:
- Epic 1 Story 1.1 ✅ (AIOS Launcher - provides agent context)

### Epics That Depend On Epic 2:
- **Epic 3:** Story 3.1.1 (Full rollout - needs database to store 27 minds)
- **Epic 4:** All pipeline automation (needs database foundation)

---

## Technical Architecture

### Database Design Principles:

1. **Single Source of Truth**
   - One unified database (not multiple)
   - All systems share same tables
   - Fragments are universal evidence

2. **Evidence-Based Everything**
   - Every score links to fragments
   - Every fragment links to source
   - Every source links to mind
   - Complete audit trail

3. **Privacy by Design**
   - Support for private users
   - Configurable privacy levels
   - Consent tracking (future)

4. **Performance First**
   - Indexes on all foreign keys
   - Views for common queries
   - <5 min integration target
   - Batch operations supported

### Key Tables:

**Core:**
- `minds` - 28 minds (basic metadata)
- `sources` - Original content (blogs, videos, PDFs)
- `fragments` - Evidence units (quotes, observations)
- `analysis` - Cognitive specs (DNA Mental™)

**Taxonomy:**
- `domains` - 6 top-level domains
- `specializations` - 22 specializations
- `skills` - 73 skills
- `proficiencies` - 320 proficiencies

**Scoring:**
- `mind_proficiency_scores` - Evidence-based scores
- `mind_specialization_rankings` - Aggregated rankings

---

## Risks & Mitigations

**Risk 1: Data migration complexity**
- **Mitigation:** ✅ Scripts are idempotent, support re-runs
- **Status:** Addressed via Story 2.4 re-processing modes

**Risk 2: Performance degradation at scale**
- **Mitigation:** 🎯 Batch inserts, indexes, async processing
- **Status:** To be validated in Story 2.4

**Risk 3: Referential integrity violations**
- **Mitigation:** ✅ Database constraints + validation module
- **Status:** Story 2.4 includes validate-integration.js

**Risk 4: Breaking existing YAML-based workflows**
- **Mitigation:** ✅ Backward compatibility maintained
- **Status:** Pipeline still generates YAMLs + populates DB

---

## Success Metrics (Epic Level)

### Completed (Stories 2.1-2.3):
- ✅ Database created: 508KB, 20 tables
- ✅ 421 taxonomy items loaded
- ✅ 28 minds in database
- ✅ 100% referential integrity validated

### Remaining (Story 2.4):
- 🎯 1 mind fully integrated (sam_altman pilot)
- 🎯 50-200 fragments extracted
- 🎯 <5 min integration time
- 🎯 All validation checks pass

### Epic Complete When:
- ✅ All 4 stories done
- ✅ Pilot mind (sam_altman) fully integrated
- ✅ Integration scripts tested and documented
- ✅ Ready for Epic 3 (full 27-mind rollout)

---

## Timeline

**Sprint 1 (Oct 12-13):** ✅ Stories 2.1, 2.2, 2.3 completed
**Sprint 2 (Oct 14-16):** 🎯 Story 2.4 implementation
**Sprint 3 (Oct 17-18):** 🎯 Story 2.4 testing and validation
**Sprint 4 (Oct 19-20):** 🎯 Documentation and Epic 3 preparation

**Total Duration:** 9 days (Oct 12-20)

---

## Related Documentation

- **Schema:** `docs/mmos/database/schema_complete.sql`
- **Seed Data:** `docs/mmos/database/seed_specialization_taxonomy.sql`
- **Database:** `outputs/database/mmos.db`
- **Story 2.4:** `docs/mmos/stories/story-2.4-pipeline-v3-integration.md`
- **Audit Report:** `docs/mmos/EPIC-AUDIT-REPORT.md`

---

## Team & Ownership

**Epic Owner:** Database Architect + Backend Team
**Stories:**
- 2.1: Database Architect (completed)
- 2.2: Data Engineer (completed)
- 2.3: Backend Developer (completed)
- 2.4: Full Stack Developer (in progress)

**Stakeholders:**
- Product Owner (Sarah) - Epic tracking
- AI Research Team - Taxonomy validation
- MMOS Pipeline Team - Integration testing

---

**Created:** October 13, 2025
**Last Updated:** October 13, 2025
**Status:** 75% Complete (3/4 stories done)
**Next:** Story 2.4 implementation
