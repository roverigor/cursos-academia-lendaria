# Epic 3: Taxonomy Normalization & Migration

**Epic ID:** MMOS-EPIC-003
**Status:** Draft
**Priority:** High
**Owner:** Academia Lendar[IA]
**Created:** October 12, 2025
**Target Start:** After Epic 2 completion
**Estimated Duration:** 11-14 weeks (7-9 weeks normalization + 4-5 weeks cognitive profiling)

---

## Epic Goal

Normalize and standardize the entire MMOS taxonomy system across 22+ existing minds, establishing consistent naming conventions, directory structures, schema standards, cognitive profiling systems, specialization scoring, and governance policies to enable scalable growth, intelligent mind recommendations, and comparative analytics.

---

## Problem Statement

### Current State (Pain Points)

**1. Inconsistent Structure Across Minds**
- Different minds have different directory layouts
- Some have `artifacts/`, others have `analysis/`, `synthesis/` at root
- System prompts not versioned consistently
- No standard `metadata.yaml` files

**2. No Centralized Cataloging**
- Sources scattered across directories without master inventory
- No `sources_master.yaml` for most minds
- ETL questions in various formats (JSON, JSONL, markdown)
- No pipeline progress tracking

**3. Naming Convention Chaos**
- Mix of camelCase, PascalCase, snake_case, kebab-case
- Inconsistent versioning (some use dates, some use v1.0, some none)
- Ambiguous filenames without entity prefixes
- No standard for timestamps

**4. Relationship Mapping Missing**
- Sources not mapped to layers they contribute to
- Artifacts not linked to prompts that generated them
- No tagging system for cross-cutting concerns
- ETL questions not correlated with each other

**5. Schema Drift**
- Each mind evolved its own metadata format
- No validation of required fields
- Breaking changes introduced without migration path
- Documentation out of sync with reality

**6. No Cognitive Profiling System**
- Personality assessments (DISC, MBTI, Enneagram) not tracked
- No specialization taxonomy (copywriter, entrepreneur, etc.)
- No skill-level scoring (hooks: 95, offers: 98, etc.)
- Can't answer "who is best for X task?"
- No correlation analysis between minds
- No comparative analytics across domains

### Impact

**Developer Experience:**
- Hard to onboard new contributors (no consistency)
- Difficult to find files (no standard structure)
- Risky to refactor (unknown dependencies)
- Manual work to understand each mind's structure

**System Maintenance:**
- Can't write generic tooling (every mind is different)
- Migration scripts fail on edge cases
- Database population requires custom parsers per mind
- Quality checks can't be automated

**Scalability Blockers:**
- Can't add new minds efficiently (no template)
- Brownfield updates fragile (structure changes)
- API development blocked (no standard schemas)
- Analytics impossible (inconsistent data)

**Business Risk:**
- 22+ minds with accumulated technical debt
- Knowledge locked in tribal knowledge
- Hard to productionize (no consistency guarantees)
- Future migrations increasingly expensive

---

## Success Criteria

### Primary Goals

1. **✅ All 22+ existing minds conform to standard taxonomy**
   - Validation: `npm run validate:all` passes for all minds
   - Metric: 100% compliance with naming conventions

2. **✅ Zero breaking changes to existing functionality**
   - Validation: All system prompts still loadable
   - Metric: Regression test suite passes

3. **✅ File-based structure mirrors database schema**
   - Validation: Round-trip export/import succeeds
   - Metric: Zero data loss in conversion

4. **✅ Migration completed in 4-6 weeks**
   - Validation: All 4 phases completed
   - Metric: Timeline adherence

5. **✅ Documentation 100% up-to-date**
   - Validation: Taxonomy document reflects reality
   - Metric: No discrepancies in audit

### Secondary Goals

- Generic tooling works across all minds (no special cases)
- New mind onboarding takes <2 hours
- Validation CI/CD catches violations automatically
- Developer velocity increases (measured via feature delivery time)

---

## Scope

### In Scope

**Phase 1: Backward Compatible Additions (Week 1)**
- Create `metadata.yaml` for all 22+ minds
- Generate `sources_master.yaml` from existing sources
- Add `pipeline_progress.yaml` based on current state
- Initialize `etl_questions.yaml` (empty for old minds)
- Reorganize `system_prompts/` with versioning

**Phase 2: Artifacts Reorganization (Week 2)**
- Create `artifacts/layer_{1-8}/` subdirectories
- Move artifacts to layer-based structure
- Create `artifacts/synthesis/` for non-layer artifacts
- Update internal references (if any)

**Phase 3: Database Migration (Week 3-4)**
- Populate SQLite database from normalized files
- Validate data integrity (foreign keys, constraints)
- Export database back to files (verify round-trip)
- Keep files as source of truth initially

**Phase 4: Deprecation & Cleanup (Week 5-6)**
- Mark old locations as deprecated
- Update all documentation
- Run comprehensive test suite
- Delete deprecated files after safety period
- Switch to database as primary source of truth

**Tooling & Governance:**
- Migration scripts for all 4 phases
- Validation tools (naming, schema, integrity)
- CI/CD integration
- Rollback procedures
- Documentation updates

### Out of Scope

- ❌ Changing database schema (Epic 2 already defines it)
- ❌ Creating new features (focus is normalization only)
- ❌ Reprocessing minds through pipeline (brownfield updates separate)
- ❌ UI/dashboard development (board already covered in Epic 1)
- ❌ API development (future epic)

### Dependencies

**Blockers:**
- ✅ Epic 2 (Database System) must be completed first
- ✅ Taxonomy document must be approved

**Parallel Work:**
- Can proceed alongside Epic 1 (Orchestration Board) as it's read-only

---

## Implementation Stories

### Story 3.1: Backward Compatible Additions

**Goal:** Add new structure without breaking existing files

**Acceptance Criteria:**
- [ ] Script `migrate_add_metadata.sh` creates `metadata.yaml` for all minds
- [ ] Script `migrate_catalog_sources.sh` generates `sources_master.yaml`
- [ ] Script `migrate_add_progress.sh` creates `pipeline_progress.yaml`
- [ ] Script `migrate_init_etl.sh` initializes `etl_questions.yaml`
- [ ] Script `migrate_version_prompts.sh` reorganizes `system_prompts/`
- [ ] All scripts idempotent (can run multiple times safely)
- [ ] Old files remain untouched (backward compatibility)
- [ ] Validation script confirms new files match schema
- [ ] Documentation updated with new file locations

**Tasks:**
1. Extract metadata from README.md/PRD.md → `metadata.yaml`
2. Scan `sources/` directory → populate `sources_master.yaml`
3. Infer pipeline completion from existing artifacts → `pipeline_progress.yaml`
4. Create empty `kb/etl_questions.yaml` with schema template
5. Move system prompts to `system_prompts/generalista/v1.0.0.md`
6. Create symlinks `latest.md` → current version
7. Run validation on 5 sample minds
8. Fix issues and run on all 22+ minds
9. Commit changes with detailed migration notes

**Estimate:** 3-4 days
**Risk:** Medium (metadata extraction may need manual review)

---

### Story 3.2: Artifacts Layer Reorganization

**Goal:** Organize artifacts by DNA Mental™ layers

**Acceptance Criteria:**
- [ ] Script `migrate_reorganize_artifacts.sh` creates layer directories
- [ ] All artifacts moved to appropriate `layer_{1-8}/` subdirectories
- [ ] Synthesis artifacts moved to `artifacts/synthesis/`
- [ ] Layer mapping documented in `artifacts/README.md`
- [ ] Old `artifacts/` root files remain (deprecated marker added)
- [ ] No broken references in system prompts
- [ ] Validation script confirms all artifacts accounted for
- [ ] Visual diagram of new structure added to docs

**Layer Mapping Rules:**

| Layer | Directory | Artifacts |
|-------|-----------|-----------|
| 1 | `layer_1/` | quotes_database.yaml, life_timeline.yaml |
| 2 | `layer_2/` | writing_style.md, signature_phrases.md |
| 3 | `layer_3/` | behavioral_patterns.md, routine_analysis.md |
| 4 | `layer_4/` | values_hierarchy.yaml, decision_patterns.yaml |
| 5 | `layer_5/` | beliefs_core.yaml, immune_system.md |
| 6 | `layer_6/` | mental_models.md, recognition_patterns.yaml |
| 7 | `layer_7/` | unique_algorithm.yaml, cognitive_architecture.yaml |
| 8 | `layer_8/` | contradictions.yaml, identity_core.yaml |
| N/A | `synthesis/` | communication_templates.md, frameworks_synthesized.md |

**Tasks:**
1. Create layer directory structure for all minds
2. Build artifact→layer mapping table (manual review needed)
3. Copy artifacts to new locations (not move, safety first)
4. Create `DEPRECATED.md` in old locations
5. Scan all system prompts for artifact references
6. Update references if hardcoded paths found
7. Create `artifacts/README.md` with mapping guide
8. Validate all artifacts present in new structure
9. Generate visual directory tree diagram

**Estimate:** 2-3 days
**Risk:** Low (copying, not moving; reversible)

---

### Story 3.3: Database Population & Validation

**Goal:** Populate SQLite database from normalized files

**Acceptance Criteria:**
- [ ] Script `migrate_populate_database.py` reads all normalized files
- [ ] All minds inserted into `minds` table with correct metadata
- [ ] All sources catalogued in `sources` table with foreign keys
- [ ] All system prompts loaded into `system_prompts` table
- [ ] All ETL questions imported into `etl_questions` table
- [ ] Tags normalized and populated in `tags` table
- [ ] Foreign key constraints validated (no orphans)
- [ ] Round-trip export/import succeeds (no data loss)
- [ ] Performance benchmarks met (<50ms queries)
- [ ] Database integrity checks pass

**Database Validation Checks:**

```sql
-- Check 1: All minds have metadata
SELECT COUNT(*) FROM minds WHERE display_name IS NULL;
-- Expected: 0

-- Check 2: No orphaned sources
SELECT COUNT(*) FROM sources WHERE mind_id NOT IN (SELECT id FROM minds);
-- Expected: 0

-- Check 3: All system prompts have valid mind_id
SELECT COUNT(*) FROM system_prompts WHERE mind_id NOT IN (SELECT id FROM minds);
-- Expected: 0

-- Check 4: Pipeline progress exists for all minds
SELECT COUNT(*) FROM minds WHERE id NOT IN (SELECT mind_id FROM pipeline_progress);
-- Expected: 0

-- Check 5: Tags properly normalized (no duplicates)
SELECT tag_name, COUNT(*) FROM tags GROUP BY tag_name HAVING COUNT(*) > 1;
-- Expected: 0 rows
```

**Tasks:**
1. Implement database population script (Python + SQLAlchemy)
2. Parse all `metadata.yaml` → minds table
3. Parse all `sources_master.yaml` → sources table
4. Parse all `system_prompts/` → system_prompts table
5. Parse all `etl_questions.yaml` → etl_questions + tags tables
6. Run foreign key validation
7. Export database back to YAML/JSON
8. Compare exported files vs original (diff)
9. Fix discrepancies and re-run until zero diff
10. Run performance benchmarks
11. Document any manual fixes needed

**Estimate:** 5-7 days
**Risk:** High (data integrity critical; needs thorough testing)

---

### Story 3.4: Export Tools & Round-Trip Validation

**Goal:** Ensure database can export back to file format losslessly

**Acceptance Criteria:**
- [ ] Script `export_mind_to_files.py` exports single mind from database
- [ ] Script `export_all_minds.py` exports entire database
- [ ] Exported files match original schema exactly
- [ ] Round-trip test: files → DB → files produces identical output
- [ ] Validation script confirms zero data loss
- [ ] Export includes all relationships (tags, relations, etc.)
- [ ] Export performance: <30 seconds per mind
- [ ] Backward compatibility: old tools can read exported files

**Export Targets:**

| Table | Export Format | Filename |
|-------|---------------|----------|
| minds | YAML | `metadata.yaml` |
| sources | YAML | `sources_master.yaml` |
| system_prompts | Markdown + frontmatter | `system_prompts/{type}/v{version}.md` |
| etl_questions | YAML | `kb/etl_questions.yaml` |
| tags | YAML (embedded) | `kb/etl_questions.yaml` |
| pipeline_progress | YAML | `docs/pipeline_progress.yaml` |

**Tasks:**
1. Implement SQLAlchemy → YAML exporter
2. Implement SQLAlchemy → Markdown exporter (with frontmatter)
3. Build round-trip test harness
4. Run round-trip test on 5 sample minds
5. Fix any data loss or formatting issues
6. Run on all 22+ minds
7. Generate diff reports for manual review
8. Optimize export performance (batching, caching)
9. Document export procedures

**Estimate:** 3-4 days
**Risk:** Medium (edge cases in YAML/Markdown serialization)

---

### Story 3.5: Validation Tooling & CI/CD

**Goal:** Automate taxonomy compliance validation

**Acceptance Criteria:**
- [ ] Command `npm run validate:minds` checks all mind metadata
- [ ] Command `npm run validate:sources` checks sources_master integrity
- [ ] Command `npm run validate:database` checks schema compliance
- [ ] Command `npm run validate:naming` checks file naming conventions
- [ ] Command `npm run validate:artifacts` checks layer mapping
- [ ] Command `npm run validate:all` runs full validation suite
- [ ] CI/CD runs validation on every PR
- [ ] Validation failures block merge
- [ ] Detailed error reports generated
- [ ] Performance: validation completes in <2 minutes

**Validation Rules:**

```javascript
// minds validation
- metadata.yaml exists
- required fields present (id, display_name, status, version)
- id matches directory name
- version follows semver
- apex_score is float 0-10
- timestamps are ISO8601

// sources validation
- sources_master.yaml exists
- all source files referenced actually exist
- no orphaned source files (not in master)
- required fields present (id, type, title, status)
- source types are valid enum values
- layer_relevance only contains 1-8

// naming validation
- all files use snake_case
- no spaces in filenames
- timestamps use ISO8601 or YYYYMMDD
- versioned files use v{major}.{minor}.{patch}
- directories are plural nouns

// database validation
- foreign keys valid
- no NULL in required fields
- CHECK constraints pass
- unique constraints enforced
```

**Tasks:**
1. Build validation framework (Node.js)
2. Implement mind metadata validator
3. Implement sources validator
4. Implement naming convention checker
5. Implement database integrity checker
6. Implement artifact layer validator
7. Create unified CLI interface
8. Generate detailed error reports (JSON + Markdown)
9. Integrate into CI/CD (GitHub Actions)
10. Write validation documentation

**Estimate:** 4-5 days
**Risk:** Low (straightforward rule checking)

---

### Story 3.6: Migration Scripts & Rollback

**Goal:** Complete migration tooling with safety guarantees

**Acceptance Criteria:**
- [ ] Script `migrate_phase1.sh` runs Phase 1 migration
- [ ] Script `migrate_phase2.sh` runs Phase 2 migration
- [ ] Script `migrate_phase3.sh` runs Phase 3 migration
- [ ] Script `migrate_phase4.sh` runs Phase 4 cleanup
- [ ] Each script validates before proceeding
- [ ] Each script creates backup before changes
- [ ] Script `rollback_migration.sh {phase}` reverts changes
- [ ] Rollback tested and confirmed working
- [ ] Migration logs detailed (what changed, why)
- [ ] Dry-run mode available (--dry-run flag)

**Migration Phases:**

```bash
# Phase 1: Backward Compatible Additions
./scripts/migrate_phase1.sh
# - Creates metadata.yaml
# - Generates sources_master.yaml
# - Adds pipeline_progress.yaml
# - Initializes etl_questions.yaml
# - Reorganizes system_prompts/
# Validation: validate:minds, validate:sources

# Phase 2: Artifacts Reorganization
./scripts/migrate_phase2.sh
# - Creates layer directories
# - Copies artifacts to new structure
# - Adds DEPRECATED markers
# - Updates references
# Validation: validate:artifacts

# Phase 3: Database Population
./scripts/migrate_phase3.sh
# - Populates SQLite from files
# - Validates foreign keys
# - Runs round-trip test
# - Keeps files as source of truth
# Validation: validate:database, validate:all

# Phase 4: Deprecation & Cleanup
./scripts/migrate_phase4.sh --confirm
# - Deletes deprecated files (requires --confirm)
# - Switches to DB as source of truth
# - Final validation sweep
# Validation: validate:all
```

**Rollback Strategy:**

```bash
# Automatic backups before each phase
backups/
├── pre_phase1_{timestamp}.tar.gz
├── pre_phase2_{timestamp}.tar.gz
├── pre_phase3_{timestamp}.tar.gz
└── pre_phase4_{timestamp}.tar.gz

# Rollback command
./scripts/rollback_migration.sh 3
# Restores from pre_phase3 backup
# Reverts git commits
# Drops database changes
# Validates rollback successful
```

**Tasks:**
1. Build migration orchestration framework
2. Implement backup creation (tar.gz)
3. Implement Phase 1 migration script
4. Implement Phase 2 migration script
5. Implement Phase 3 migration script
6. Implement Phase 4 cleanup script
7. Build rollback mechanism
8. Add dry-run mode (simulate without changes)
9. Create detailed migration logs
10. Test rollback on sample minds
11. Document migration procedures

**Estimate:** 5-6 days
**Risk:** High (system-wide changes; thorough testing critical)

---

### Story 3.7: Documentation & Governance

**Goal:** Complete documentation and establish governance

**Acceptance Criteria:**
- [ ] Taxonomy document (taxonomy-system.md) 100% accurate
- [ ] Migration guide written with step-by-step instructions
- [ ] Governance policy documented (schema evolution process)
- [ ] API reference updated (if applicable)
- [ ] Developer onboarding guide updated
- [ ] Video walkthrough recorded (optional but recommended)
- [ ] FAQ document addresses common issues
- [ ] Changelog documents all breaking changes

**Documentation Deliverables:**

1. **taxonomy-system.md** (already created)
   - Complete taxonomy reference
   - Entity-relationship model
   - Naming conventions
   - Schema standards
   - Directory structure
   - Migration strategy
   - Governance policy

2. **migration-guide.md**
   - Step-by-step migration instructions
   - Troubleshooting common issues
   - Rollback procedures
   - Validation checklist
   - Before/after examples

3. **governance-policy.md**
   - Schema evolution process
   - Change approval workflow
   - Backward compatibility requirements
   - Deprecation policy
   - Review & maintenance schedule

4. **developer-guide.md**
   - How to add a new mind
   - How to update existing mind
   - How to use validation tools
   - How to run migrations
   - Code examples

5. **CHANGELOG.md**
   - All breaking changes documented
   - Migration paths for each version
   - Deprecation warnings

**Tasks:**
1. Review taxonomy-system.md for accuracy
2. Write comprehensive migration guide
3. Document governance policy
4. Update developer onboarding guide
5. Create before/after comparison diagrams
6. Write FAQ based on common issues
7. Generate CHANGELOG from git history
8. Record video walkthrough (optional)
9. Review all docs with team
10. Publish to docs site

**Estimate:** 3-4 days
**Risk:** Low (documentation only)

---

### Story 3.8: Cognitive Profiling System

**Goal:** Implement personality assessment tracking (DISC, MBTI, Enneagram, Big Five)

**Acceptance Criteria:**
- [ ] Database tables created: `cognitive_profiles`
- [ ] Support for multiple profile types (DISC, MBTI, Enneagram, Big Five, etc.)
- [ ] Profile data stored as JSON with validation schema
- [ ] Evidence tracking for each assessment
- [ ] Confidence scoring (high/medium/low)
- [ ] CLI command: `aios-mind profile --mind {name} --type {disc|mbti|enneagram|big_five}`
- [ ] Export profile to YAML: `cognitive_profiles.yaml`
- [ ] Import from YAML to database
- [ ] Validation: profile data matches schema

**Profile Types Supported:**

```yaml
# DISC Profile
disc_profile:
  D: {score: 0-100}  # Dominance
  I: {score: 0-100}  # Influence
  S: {score: 0-100}  # Steadiness
  C: {score: 0-100}  # Conscientiousness
  primary_type: "D"
  profile_code: "Di"

# MBTI Profile
mbti_profile:
  type: "ENTJ"  # 16 types
  dimensions:
    E_I: "E"  # Extraversion vs Introversion
    S_N: "N"  # Sensing vs Intuition
    T_F: "T"  # Thinking vs Feeling
    J_P: "J"  # Judging vs Perceiving

# Enneagram Profile
enneagram_profile:
  core_type: 8          # 1-9
  wing: "8w7"
  triadic_center: "gut" # gut/heart/head

# Big Five (OCEAN)
big_five_profile:
  openness: 95          # 0-100
  conscientiousness: 85
  extraversion: 60
  agreeableness: 30
  neuroticism: 25
```

**Tasks:**
1. Create `cognitive_profiles` table schema
2. Implement profile JSON schema validators
3. Build profile CRUD operations (SQLAlchemy models)
4. Create CLI commands for profile management
5. Implement YAML import/export
6. Add validation rules for each profile type
7. Test with 3 sample minds (Alex Hormozi, Sam Altman, Elon Musk)
8. Document profiling methodology
9. Create profile templates

**Estimate:** 4-5 days
**Risk:** Medium (JSON schema validation complexity)

---

### Story 3.9: Specialization Taxonomy & Database

**Goal:** Create complete specialization hierarchy (domains → specializations → skills → proficiencies)

**Acceptance Criteria:**
- [ ] Database tables: `domains`, `specializations`, `skills`, `proficiencies`
- [ ] Seed data for 6 domains populated
- [ ] 15+ specializations defined (copywriter, entrepreneur, marketer, etc.)
- [ ] 50+ skills catalogued
- [ ] 200+ proficiencies mapped
- [ ] Hierarchical relationships enforced (foreign keys)
- [ ] CLI command: `aios-taxonomy list --level {domain|specialization|skill|proficiency}`
- [ ] CLI command: `aios-taxonomy export --format {yaml|json|csv}`
- [ ] Documentation: complete taxonomy reference

**Domain Structure:**

```
1. Business & Entrepreneurship
   ├── Entrepreneur
   │   ├── Business Strategy
   │   │   ├── Market Analysis
   │   │   ├── Competitive Positioning
   │   │   └── Business Model Design
   │   └── Scaling Operations
   │       ├── Hiring Systems
   │       └── Process Optimization

2. Marketing & Sales
   ├── Copywriter
   │   ├── Direct Response Copywriting
   │   │   ├── Hooks
   │   │   ├── Offers
   │   │   ├── Headlines
   │   │   └── Storytelling
   │   └── Persuasion Psychology
   │       ├── Scarcity
   │       ├── Urgency
   │       └── Social Proof

3. Technology & Engineering
4. Creative & Content
5. Strategy & Consulting
6. Personal Development
```

**Tasks:**
1. Design taxonomy hierarchy schema
2. Create database tables with foreign keys
3. Write seed data SQL (domains, specializations, skills, proficiencies)
4. Implement taxonomy CRUD operations
5. Build CLI for taxonomy exploration
6. Create export tools (YAML, JSON, CSV)
7. Validate hierarchy integrity
8. Document taxonomy structure
9. Add icons/metadata for UI (future)

**Estimate:** 5-6 days
**Risk:** Medium (large seed data requires curation)

---

### Story 3.10: Mind Scoring System

**Goal:** Implement evidence-based scoring for minds across specializations/skills/proficiencies

**Acceptance Criteria:**
- [ ] Database tables: `mind_scores`, `score_evidence`, `mind_specializations`
- [ ] Multi-level scoring (domain, specialization, skill, proficiency)
- [ ] Score range: 0-100 with validation
- [ ] Confidence tracking (high/medium/low)
- [ ] Evidence linkage to sources
- [ ] Weight-based evidence (1-10)
- [ ] Automatic aggregation (proficiency → skill → specialization → domain)
- [ ] CLI command: `aios-mind score --mind {name} --proficiency {id} --score {0-100} --evidence "{text}"`
- [ ] CLI command: `aios-mind scores --mind {name} --level {domain|specialization|skill|proficiency}`
- [ ] Export: `mind_scores.yaml`

**Scoring Schema:**

```yaml
# Example: Alex Hormozi scoring
mind_scores:
  - mind_id: alex_hormozi
    proficiency_id: offers
    score: 99
    confidence: high
    evidence:
      - source_id: "100m_offers_book"
        evidence_type: "publication"
        content: "Published '$100M Offers', proven $100M+ attributed sales"
        weight: 10
      - source_id: "gym_launch_case_study"
        evidence_type: "metric"
        content: "$46M generated using offer methodology"
        weight: 9
```

**Aggregation Formula:**

```
Skill Score = Σ(proficiency_score × evidence_weight) / Σ(evidence_weight)
Specialization Score = Σ(skill_score × proficiency_count) / Σ(proficiency_count)
Domain Score = Σ(specialization_score × skill_count) / Σ(skill_count)

See: docs/mmos/architecture/cognitive-profiling-system.md Section 3.2
```

**Tasks:**
1. Create scoring tables schema
2. Implement scoring CRUD operations
3. Build evidence tracking system
4. Implement score aggregation using formulas above (bottom-up calculation)
5. Create scoring CLI commands
6. Build validation rules (0-100 range, required evidence)
7. Test with Alex Hormozi full profile (20+ scores)
8. Implement YAML export/import
9. Document scoring methodology

**Estimate:** 6-7 days
**Risk:** High (aggregation logic complex, evidence validation critical)

---

### Story 3.11: Mind Recommendation Engine

**Goal:** Query system for finding best minds for specific tasks/domains

**Acceptance Criteria:**
- [ ] Query: Find top N minds by proficiency
- [ ] Query: Find top N minds by specialization
- [ ] Query: Find top N minds by domain
- [ ] Query: Find minds similar to X (correlation analysis)
- [ ] Query: Build dream team (best per role)
- [ ] Query: Gap analysis (what skills does mind X need?)
- [ ] CLI command: `aios-mind recommend --task "write offer copy" --top 5`
- [ ] CLI command: `aios-mind similar --mind alex_hormozi --top 5`
- [ ] CLI command: `aios-mind gaps --mind sam_altman --target-role operator`
- [ ] CLI command: `aios-mind dream-team --domain marketing_sales --size 3`
- [ ] Performance: queries <100ms

**Example Queries:**

```sql
-- Find best for specific proficiency
SELECT m.display_name, ms.score
FROM minds m
JOIN mind_scores ms ON m.id = ms.mind_id
WHERE ms.proficiency_id = 'offers'
ORDER BY ms.score DESC, ms.confidence DESC
LIMIT 5;

-- Mind similarity analysis
WITH hormozi_profile AS (
    SELECT proficiency_id, score
    FROM mind_scores
    WHERE mind_id = 'alex_hormozi'
)
SELECT
    m.display_name,
    100 - ROUND(AVG(ABS(hp.score - ms.score)), 2) AS similarity_score
FROM minds m
JOIN mind_scores ms ON m.id = ms.mind_id
JOIN hormozi_profile hp ON ms.proficiency_id = hp.proficiency_id
WHERE m.id != 'alex_hormozi'
GROUP BY m.id
ORDER BY similarity_score DESC
LIMIT 5;
```

**Tasks:**
1. Design query patterns for common use cases
2. Create database views for performance
3. Implement recommendation algorithms
4. Build similarity calculation (correlation)
5. Implement gap analysis logic
6. Create CLI interface for all queries
7. Optimize query performance (<100ms)
8. Test with 22+ minds dataset
9. Document query patterns

**Estimate:** 4-5 days
**Risk:** Medium (performance optimization needed)

---

### Story 3.12: Cognitive Profiling Data Migration

**Goal:** Populate cognitive profiles and scores for existing minds

**Acceptance Criteria:**
- [ ] Cognitive profiles extracted for 5+ high-priority minds
- [ ] Specialization scores assigned to 5+ minds
- [ ] Evidence documented for all scores
- [ ] Validation: all scores backed by evidence
- [ ] High-priority minds: Alex Hormozi, Sam Altman, Elon Musk, Eugene Schwartz, Naval Ravikant
- [ ] Export profiles to `{mind}/cognitive_profiles.yaml`
- [ ] Export scores to `{mind}/scores.yaml`
- [ ] Documentation: profiling methodology guide

**Manual Curation Required:**

```yaml
# For each mind, curate:
1. DISC profile (analyze sources for D/I/S/C traits)
2. MBTI type (infer from cognitive patterns)
3. Enneagram core type (identify fears/desires)
4. Big Five scores (assess OCEAN dimensions)

5. Specializations (what roles do they excel at?)
6. Skills (what competencies do they have?)
7. Proficiencies (granular capabilities with evidence)
```

**Tasks:**
1. Create profiling methodology guide
2. Analyze sources for Alex Hormozi (complete profile)
3. Analyze sources for Sam Altman (complete profile)
4. Analyze sources for Elon Musk (complete profile)
5. Analyze sources for Eugene Schwartz (complete profile)
6. Analyze sources for Naval Ravikant (complete profile)
7. Validate evidence quality (triangulation where needed)
8. Import profiles to database
9. Generate comparison reports

**Estimate:** 8-10 days (2 days per mind)
**Risk:** High (manual curation time-intensive, requires deep analysis)

---

### Story 3.13: Profiling Analytics & Visualization

**Goal:** Create analytics tools for profiling data

**Acceptance Criteria:**
- [ ] Command: `aios-mind analytics --mind {name}` (full profile summary)
- [ ] Command: `aios-mind compare --mind1 {name} --mind2 {name}` (side-by-side)
- [ ] Command: `aios-mind correlate --minds {list}` (correlation matrix)
- [ ] Command: `aios-mind leaderboard --specialization {id}` (ranking)
- [ ] Export: JSON, YAML, CSV formats
- [ ] Performance: analytics generation <2 seconds
- [ ] Visualization-ready data (for future dashboard)

**Analytics Outputs:**

```yaml
# Full Profile Summary
analytics:
  mind: alex_hormozi

  cognitive_profile:
    disc: "Di (D:95, I:70, S:20, C:65)"
    mbti: "ENTJ"
    enneagram: "8w7"

  top_domains:
    - {domain: "Business & Entrepreneurship", score: 93}
    - {domain: "Marketing & Sales", score: 92}

  top_specializations:
    - {role: "Entrepreneur", score: 93}
    - {role: "Copywriter", score: 92}

  signature_proficiencies:
    - {proficiency: "Offers", score: 99}
    - {proficiency: "Hooks", score: 98}
    - {proficiency: "Hiring Systems", score: 98}

  comparable_minds:
    - {mind: "Dan Kennedy", similarity: 87%}
    - {mind: "Russell Brunson", similarity: 83%}

# Correlation Matrix
correlation_matrix:
  minds: [alex_hormozi, eugene_schwartz, dan_kennedy]
  shared_proficiencies: 12
  score_correlations:
    - {proficiency: "offers", scores: [99, 95, 92]}
    - {proficiency: "hooks", scores: [98, 96, 90]}
```

**Tasks:**
1. Design analytics data structures
2. Implement profile summary generator
3. Implement comparison engine
4. Build correlation matrix calculator
5. Create leaderboard generator
6. Implement multi-format export
7. Optimize analytics performance
8. Create visualization-ready JSON
9. Test with full dataset

**Estimate:** 3-4 days
**Risk:** Low (data aggregation, straightforward)

---

## Technical Specifications

### Migration Script Architecture

```
scripts/migration/
├── lib/
│   ├── backup.js           # Backup creation/restoration
│   ├── validator.js        # Validation rules engine
│   ├── parser.js           # YAML/Markdown parsers
│   ├── exporter.js         # Database → Files
│   ├── importer.js         # Files → Database
│   └── logger.js           # Structured logging
│
├── migrate_phase1.sh       # Phase 1 orchestration
├── migrate_phase2.sh       # Phase 2 orchestration
├── migrate_phase3.sh       # Phase 3 orchestration
├── migrate_phase4.sh       # Phase 4 orchestration
├── rollback_migration.sh   # Rollback handler
│
├── validate_minds.js       # Mind metadata validation
├── validate_sources.js     # Sources validation
├── validate_database.js    # DB integrity checks
├── validate_naming.js      # Naming convention checks
├── validate_artifacts.js   # Artifact layer checks
└── validate_all.js         # Unified validation
```

### Validation Rule Engine

```javascript
// Example: Mind metadata validation
const mindValidationRules = {
  required_fields: ['id', 'display_name', 'status', 'version', 'created_at'],
  field_types: {
    id: 'string',
    display_name: 'string',
    status: 'enum',
    version: 'semver',
    apex_score: 'float',
    created_at: 'iso8601'
  },
  enum_values: {
    status: ['draft', 'mapping', 'completed', 'archived']
  },
  constraints: {
    apex_score: (value) => value >= 0 && value <= 10,
    id: (value, context) => value === context.directory_name,
    version: (value) => /^v\d+\.\d+\.\d+$/.test(value)
  }
};

// Validate mind
const result = validate('minds/sam_altman/metadata.yaml', mindValidationRules);
if (!result.valid) {
  console.error(result.errors);
  process.exit(1);
}
```

### Database Import Pipeline

```python
# migration/importer.py
from sqlalchemy import create_engine
from models import Mind, Source, SystemPrompt, ETLQuestion, Tag
import yaml

class MigrationImporter:
    def __init__(self, db_path):
        self.engine = create_engine(f'sqlite:///{db_path}')

    def import_mind(self, mind_path):
        """Import single mind from files to database"""
        # 1. Parse metadata.yaml
        metadata = self.parse_metadata(f'{mind_path}/metadata.yaml')
        mind = Mind(**metadata)
        self.session.add(mind)

        # 2. Parse sources_master.yaml
        sources = self.parse_sources(f'{mind_path}/sources/sources_master.yaml')
        for source_data in sources:
            source = Source(mind_id=mind.id, **source_data)
            self.session.add(source)

        # 3. Parse system prompts
        prompts = self.parse_prompts(f'{mind_path}/system_prompts/')
        for prompt_data in prompts:
            prompt = SystemPrompt(mind_id=mind.id, **prompt_data)
            self.session.add(prompt)

        # 4. Parse ETL questions
        questions = self.parse_etl_questions(f'{mind_path}/kb/etl_questions.yaml')
        for q_data in questions:
            question = ETLQuestion(mind_id=mind.id, **q_data)
            self.session.add(question)

            # Handle tags (M:N relationship)
            for tag_name in q_data.get('tags', []):
                tag = self.get_or_create_tag(tag_name)
                question.tags.append(tag)

        # 5. Commit transaction
        self.session.commit()

        # 6. Validate foreign keys
        self.validate_relationships(mind.id)

        return mind
```

### Performance Requirements

| Operation | Target | Max |
|-----------|--------|-----|
| Validate single mind | <500ms | <1s |
| Migrate single mind (Phase 1-2) | <2s | <5s |
| Import mind to database | <1s | <3s |
| Export mind from database | <2s | <5s |
| Full validation (22 minds) | <1min | <2min |
| Complete migration (22 minds) | <15min | <30min |
| Rollback operation | <1min | <3min |

---

## Timeline & Milestones

### Week 1: Phase 1 - Backward Compatible Additions
- **Days 1-2:** Story 3.1 implementation
- **Days 3-4:** Validation on sample minds
- **Day 5:** Run on all 22+ minds, fix issues

**Milestone:** ✅ All minds have new structure (old structure intact)

### Week 2: Phase 2 - Artifacts Reorganization
- **Days 1-2:** Story 3.2 implementation
- **Days 3-4:** Validation and reference updates
- **Day 5:** Documentation updates

**Milestone:** ✅ All artifacts organized by layers

### Week 3-4: Phase 3 - Database Population
- **Days 1-3:** Story 3.3 database import
- **Days 4-5:** Story 3.4 export tools
- **Days 6-7:** Round-trip validation
- **Days 8-10:** Bug fixes and optimization

**Milestone:** ✅ Database populated and validated

### Week 5: Phase 4 - Deprecation & Cleanup
- **Days 1-2:** Story 3.6 migration scripts
- **Days 3-4:** Cleanup old files (after safety period)
- **Day 5:** Final validation

**Milestone:** ✅ Migration complete, old structure removed

### Week 6: Validation & Documentation
- **Days 1-2:** Story 3.5 validation tooling
- **Days 3-5:** Story 3.7 documentation

**Milestone:** ✅ Epic 3 complete, fully documented

---

## Risks & Mitigation

### High Risks

**Risk 1: Data Loss During Migration**
- **Impact:** Critical (lose cognitive analysis work)
- **Probability:** Low (with proper testing)
- **Mitigation:**
  - Backups before each phase
  - Copy, don't move files (Phase 2)
  - Round-trip validation (Phase 3)
  - 2-week safety period before deletions
  - Rollback procedures tested

**Risk 2: Schema Validation Failures**
- **Impact:** High (blocks database population)
- **Probability:** Medium (edge cases in 22+ minds)
- **Mitigation:**
  - Validate on 5 sample minds first
  - Manual review of edge cases
  - Schema flexibility for legacy data
  - Grandfather clause for old minds (optional fields)

**Risk 3: Performance Degradation**
- **Impact:** Medium (slower operations)
- **Probability:** Low (SQLite is fast)
- **Mitigation:**
  - Performance benchmarks before/after
  - Database indexes on foreign keys
  - Query optimization
  - Caching frequently accessed data

### Medium Risks

**Risk 4: Breaking Changes to Existing Tools**
- **Impact:** Medium (disrupts workflows)
- **Probability:** Medium (path changes)
- **Mitigation:**
  - Symlinks for backward compatibility
  - Deprecation warnings, not hard failures
  - Update scripts to handle both old/new paths
  - Document breaking changes clearly

**Risk 5: Timeline Overrun**
- **Impact:** Medium (delays other epics)
- **Probability:** Medium (22+ minds is large scope)
- **Mitigation:**
  - Buffer time in estimates (4-6 weeks, not 4)
  - Parallelize Phase 1-2 work (per-mind operations)
  - Incremental rollout (validate 5, then 10, then all)
  - Daily progress tracking

### Low Risks

**Risk 6: Team Resistance to New Standards**
- **Impact:** Low (governance adoption)
- **Probability:** Low (clear benefits)
- **Mitigation:**
  - Clear documentation of rationale
  - Show before/after comparisons
  - Automated validation (makes compliance easy)
  - Onboarding guide for new standards

---

## Success Metrics

### Quantitative

- **100%** minds conform to taxonomy (validate:all passes)
- **0** data loss in migration (round-trip validation)
- **<2 min** full validation time (22 minds)
- **<30 min** complete migration time (all phases)
- **0** rollback operations needed (thorough testing prevents)

### Qualitative

- Developers report easier navigation
- New mind onboarding <2 hours (was ~1 day)
- Generic tooling works across all minds
- Confidence in data integrity high
- Documentation comprehensive and accurate

### Before/After Comparison

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| New mind setup time | ~8h | <2h | 75% faster |
| Find artifact time | ~5min | <30s | 90% faster |
| Validation coverage | 0% | 100% | ∞ |
| Standard compliance | ~30% | 100% | 70% increase |
| Developer confidence | Low | High | Qualitative |

---

## Dependencies & Blockers

### Prerequisites

- ✅ Epic 2 (Database System) completed
- ✅ Taxonomy document approved
- ✅ Team alignment on standards

### External Dependencies

- None (self-contained epic)

### Internal Dependencies

- Database schema from Epic 2 (done)
- File structure conventions (defined in taxonomy doc)
- Validation rules (defined in taxonomy doc)

---

## Rollout Plan

### Pre-Migration Checklist

- [ ] Epic 2 database schema validated
- [ ] Taxonomy document reviewed and approved
- [ ] Migration scripts tested on 5 sample minds
- [ ] Validation tools working correctly
- [ ] Rollback procedure tested successfully
- [ ] Full backup of all minds created
- [ ] Team trained on new standards
- [ ] Documentation finalized

### Migration Execution

**Day 1: Phase 1 (Backward Compatible)**
- Run `migrate_phase1.sh` on all minds
- Validate with `validate:minds` and `validate:sources`
- Fix issues, re-run if needed
- Commit changes to git (branch: `migration-phase1`)

**Day 8: Phase 2 (Artifacts Reorganization)**
- Run `migrate_phase2.sh` on all minds
- Validate with `validate:artifacts`
- Review artifact mapping for accuracy
- Commit changes (branch: `migration-phase2`)

**Day 15: Phase 3 (Database Population)**
- Run `migrate_phase3.sh` to populate database
- Validate with `validate:database`
- Run round-trip export/import test
- Fix discrepancies, re-run until clean
- Commit database and updated files

**Day 29: Phase 4 (Cleanup)**
- **2-week safety period** (Days 22-29)
- Monitor for issues, no problems reported
- Run `migrate_phase4.sh --confirm` to delete deprecated files
- Final validation with `validate:all`
- Merge all migration branches to main
- Tag release: `v2.0.0-taxonomy-normalized`

### Post-Migration

- Monitor for 1 week (any issues?)
- Gather team feedback
- Update troubleshooting docs based on issues
- Conduct retrospective
- Plan Epic 4 (next improvements)

---

## Resources Required

### People

- **1 Senior Developer** (migration scripts, database work)
- **1 Developer** (validation tools, testing)
- **1 DevOps Engineer** (CI/CD integration, backup strategy)
- **1 Technical Writer** (documentation)
- **1 Product Owner** (governance policy, acceptance)

### Technology

- SQLite 3.35+ (already required by Epic 2)
- Python 3.8+ with SQLAlchemy 2.0
- Node.js 18+ (validation scripts)
- GitHub Actions (CI/CD)
- Git (version control, rollback)

### Budget

- **Personnel:** ~6 person-weeks total
- **Infrastructure:** $0 (using existing tools)
- **Contingency:** 1 week buffer for issues

**Total Cost:** ~6-7 person-weeks

---

## Acceptance Criteria (Epic Level)

### Functional

- [ ] All 22+ minds conform to standard taxonomy
- [ ] `npm run validate:all` passes for all minds
- [ ] Database populated from files with zero errors
- [ ] Round-trip export/import produces identical files
- [ ] Migration completes in <30 minutes
- [ ] Rollback tested and confirmed working
- [ ] All stories completed and accepted

### Non-Functional

- [ ] Performance targets met (see table above)
- [ ] Zero data loss validated
- [ ] Backward compatibility maintained
- [ ] Documentation 100% complete and accurate
- [ ] CI/CD integration working
- [ ] Team trained on new standards

### Governance

- [ ] Schema evolution policy documented
- [ ] Change approval workflow established
- [ ] Validation tools integrated into workflow
- [ ] Deprecation policy clear
- [ ] Maintenance schedule defined

---

## Handoff to Story Manager

### Story Breakdown

**Phase 1: Taxonomy Normalization (7 stories, 4-6 weeks)**
- Story 3.1: Backward Compatible Additions (3-4 days)
- Story 3.2: Artifacts Layer Reorganization (2-3 days)
- Story 3.3: Database Population & Validation (5-7 days)
- Story 3.4: Export Tools & Round-Trip Validation (3-4 days)
- Story 3.5: Validation Tooling & CI/CD (4-5 days)
- Story 3.6: Migration Scripts & Rollback (5-6 days)
- Story 3.7: Documentation & Governance (3-4 days)

**Phase 2: Cognitive Profiling & Scoring (6 stories, 3-4 weeks)**
- Story 3.8: Cognitive Profiling System (4-5 days)
- Story 3.9: Specialization Taxonomy & Database (5-6 days)
- Story 3.10: Mind Scoring System (6-7 days)
- Story 3.11: Mind Recommendation Engine (4-5 days)
- Story 3.12: Cognitive Profiling Data Migration (8-10 days)
- Story 3.13: Profiling Analytics & Visualization (3-4 days)

**Total:** 13 stories, 50-66 days (7-9 weeks with buffer)

### Technical Context

- Database schema defined in Epic 2
- Taxonomy system documented in `docs/mmos/architecture/taxonomy-system.md`
- 22+ existing minds need migration
- Backward compatibility critical (no breaking changes)

### Priorities

1. **Data integrity** (zero loss non-negotiable)
2. **Backward compatibility** (don't break existing workflows)
3. **Timeline adherence** (complete in 4-6 weeks)
4. **Documentation quality** (comprehensive and accurate)

### Open Questions

1. Should we migrate all 22 minds at once or in batches?
   - **Recommendation:** Batch migration (5 sample → 10 more → remaining)

2. Database as source of truth from Day 1 or after validation period?
   - **Recommendation:** Files remain source of truth through Phase 3, switch in Phase 4

3. Grandfather clause for old minds with incomplete data?
   - **Recommendation:** Yes, allow optional fields for legacy minds (document in LIMITATIONS.md)

---

## Appendix A: File Structure Before/After

### Before (Inconsistent)

```
outputs/minds/sam_altman/
├── system_prompts/
│   ├── System_Prompt.md              # No version
│   └── generalista.md                # Naming inconsistent
├── artifacts/
│   ├── cognitive_architecture.yaml   # Flat structure
│   ├── mental_models.md
│   └── contradictions.yaml
└── sources/
    ├── books/                        # No sources_master.yaml
    └── interviews/
```

### After (Standardized)

```
outputs/minds/sam_altman/
├── metadata.yaml                     # NEW: Structured metadata
├── system_prompts/
│   ├── generalista/
│   │   ├── v1.0.0.md
│   │   └── latest.md -> v1.0.0.md  # Symlink
│   └── specialists/
│       └── business_consultant_v1.0.0.md
├── artifacts/
│   ├── README.md                     # NEW: Layer mapping guide
│   ├── layer_6/
│   │   └── mental_models.md
│   ├── layer_7/
│   │   └── cognitive_architecture.yaml
│   └── layer_8/
│       └── contradictions.yaml
├── sources/
│   ├── sources_master.yaml           # NEW: Central inventory
│   ├── books/
│   └── interviews/
├── kb/
│   └── etl_questions.yaml            # NEW: ETL tracking
└── docs/
    └── pipeline_progress.yaml        # NEW: Progress tracking
```

---

## Appendix B: Validation Examples

### Mind Metadata Validation

```yaml
# ✅ VALID metadata.yaml
mind:
  id: sam_altman
  display_name: Sam Altman
  status: completed
  version: v1.0.0
  apex_score: 8.5
  icp_match: high
  created_at: 2025-10-01T10:00:00Z
  updated_at: 2025-10-10T15:30:00Z

# ❌ INVALID metadata.yaml
mind:
  id: SamAltman              # Should be snake_case
  display_name: null         # Required field missing
  status: done               # Invalid enum value
  version: 1.0               # Should be v1.0.0
  apex_score: 15             # Out of range (0-10)
```

### Source Master Validation

```yaml
# ✅ VALID sources_master.yaml
sources:
  - id: lex-fridman-419
    mind_id: sam_altman
    type: interview
    title: "Lex Fridman #419: GPT-5, Board Saga, Elon, Ilya, Power & AGI"
    url: "https://youtube.com/watch?v=..."
    status: processed
    priority: critical
    layer_relevance: [4, 5, 6, 7, 8]
    confidence: high

# ❌ INVALID sources_master.yaml
sources:
  - id: lex-fridman-419
    # Missing mind_id (required)
    type: podcast             # Should be "interview"
    title: null               # Required field
    status: done              # Invalid enum value
    layer_relevance: [1, 9]   # 9 is invalid (only 1-8)
```

---

## Appendix C: Migration Script Example

```bash
#!/bin/bash
# migrate_phase1.sh - Backward compatible additions

set -e  # Exit on error

MINDS_DIR="docs/minds"
BACKUP_DIR="backups/pre_phase1_$(date +%Y%m%d_%H%M%S)"

echo "========================================="
echo "MMOS MIGRATION - PHASE 1"
echo "Backward Compatible Additions"
echo "========================================="

# 1. Create backup
echo "Creating backup..."
mkdir -p "$BACKUP_DIR"
cp -r "$MINDS_DIR" "$BACKUP_DIR/"
echo "✓ Backup created: $BACKUP_DIR"

# 2. Validate environment
echo "Validating environment..."
command -v python3 >/dev/null 2>&1 || { echo "Error: python3 required"; exit 1; }
command -v node >/dev/null 2>&1 || { echo "Error: node required"; exit 1; }
echo "✓ Environment ready"

# 3. Run migration for each mind
for mind_dir in "$MINDS_DIR"/*; do
    if [ -d "$mind_dir" ]; then
        mind_name=$(basename "$mind_dir")
        echo ""
        echo "Migrating: $mind_name"

        # Create metadata.yaml
        python3 scripts/migration/extract_metadata.py "$mind_dir"
        echo "  ✓ Created metadata.yaml"

        # Generate sources_master.yaml
        python3 scripts/migration/catalog_sources.py "$mind_dir"
        echo "  ✓ Generated sources_master.yaml"

        # Create pipeline_progress.yaml
        python3 scripts/migration/infer_progress.py "$mind_dir"
        echo "  ✓ Created pipeline_progress.yaml"

        # Initialize etl_questions.yaml
        python3 scripts/migration/init_etl_questions.py "$mind_dir"
        echo "  ✓ Initialized etl_questions.yaml"

        # Reorganize system_prompts
        bash scripts/migration/version_prompts.sh "$mind_dir"
        echo "  ✓ Reorganized system_prompts/"
    fi
done

# 4. Validate results
echo ""
echo "Validating migration..."
npm run validate:minds || { echo "Validation failed"; exit 1; }
npm run validate:sources || { echo "Validation failed"; exit 1; }

echo ""
echo "========================================="
echo "✓ PHASE 1 COMPLETE"
echo "========================================="
echo "Backup: $BACKUP_DIR"
echo "To rollback: ./scripts/rollback_migration.sh 1"
```

---

**END OF EPIC 3**

**Next Steps:**
1. Review and approve this epic
2. Story Manager breaks down into detailed stories
3. Assign to development team
4. Begin implementation after Epic 2 completion
