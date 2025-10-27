# Epic: User-Friendly DB Sage Workflows

**Epic ID:** SA-Epic-1
**Status:** 📋 READY FOR DEVELOPMENT
**Priority:** HIGH
**Timeline:** October 27 - November 3, 2025 (7 days)
**Owner:** DB Sage Team

---

## Epic Goal

Transform DB Sage from a technical command-line tool (29 commands) into a user-friendly workflow system with 7 goal-oriented workflows that guide non-experts through complex database operations safely and systematically.

---

## Strategic Context

### Problem

**Current State:**
- ❌ DB Sage exposes 29 technical commands directly (`*rls-audit`, `*impersonate`, `*verify-order`)
- ❌ No structured workflows - users don't know where to start
- ❌ Overwhelming for non-database experts
- ❌ No guided processes for common goals (setup, migration, import)
- ❌ KISS Gate exists but not integrated into user workflow

**Pain Points:**
- User asks: *"I want to add database to creator-os"* → No clear entry point
- User asks: *"How do I import my CSV data?"* → Must know `db-load-csv`, `db-run-sql`, staging concepts
- User asks: *"I need to migrate local to Supabase"* → Must orchestrate 10+ commands manually

### Solution

**Create 7 Goal-Oriented Workflows:**

1. **Setup New Database** → `setup-database.yaml`
2. **Analyze Expansion Pack** → `analyze-expansion-pack.yaml` (KISS Gate)
3. **Migrate to Supabase** → `migrate-to-supabase.yaml`
4. **Import Data** → `import-data.yaml`
5. **Configure Security** → `configure-security.yaml` (RLS)
6. **Optimize Performance** → `optimize-performance.yaml`
7. **Deploy Production** → `deploy-production.yaml`

**Each workflow:**
- ✅ Guides user step-by-step
- ✅ Calls technical tasks internally (hidden complexity)
- ✅ Includes validation gates (HALT points for user review)
- ✅ Provides rollback procedures
- ✅ Based on industry best practices (Supabase, PostgreSQL 2024)

### Impact

**User Experience:**
- ⏱️ **Time to first database:** 30 min → **5 min** (setup workflow)
- 📊 **KISS Gate prevention:** Blocks 90%+ over-engineering attempts
- 🛡️ **Zero data loss:** Migration workflow with mandatory backups
- 🚀 **Non-expert friendly:** Frontend devs can use DB Sage

**Technical Benefits:**
- 29 tasks remain (reused by workflows)
- Expert users can access via `*advanced`
- Workflows follow industry standards (Supabase CLI, Prisma patterns)
- Version-controlled workflows (YAML in git)

---

## Success Criteria

### Must Have (MVP):
- ✅ 7 workflow YAML files created (`expansion-packs/super-agentes/workflows/`)
- ✅ Each workflow documented with:
  - Sequence (agent → task → outputs)
  - Validation gates (HALT points)
  - Rollback procedures
  - Example usage
- ✅ db-sage menu updated:
  - `*help` → Show 7 workflows
  - `*advanced` → Show 29 technical commands
- ✅ KISS Gate workflow integrated (expansion pack analysis)
- ✅ All workflows tested with real use case (creator-os example)

### Should Have:
- 🎯 Flow diagrams for each workflow (Mermaid)
- 🎯 Research document published (`docs/research/db-workflows-research-2024.md`) ✅ **DONE**
- 🎯 Integration with existing tasks (no duplication)
- 🎯 User guide: "How to choose the right workflow"

### Could Have:
- ⏳ Interactive workflow selector (`*choose-workflow` command)
- ⏳ Workflow execution history (logs)
- ⏳ Workflow templates for common expansion packs
- ⏳ CI/CD integration (GitHub Actions workflows)

---

## Stories

### Story 1.1: Setup New Database Workflow ⏳ PENDING
**Status:** ⏳ Pending
**Story Points:** 5
**Estimate:** 1 day
**File:** `docs/stories/story-1.1-setup-database-workflow.md`

**Goal:** Create workflow for setting up new Supabase database from scratch (greenfield).

**Acceptance Criteria:**
- [ ] Workflow YAML created: `workflows/setup-database.yaml`
- [ ] Sequence defined:
  1. Environment check (`db-env-check.md`)
  2. Bootstrap structure (`db-bootstrap.md`)
  3. Supabase setup (`supabase-setup.md`)
  4. Initial migration (`db-apply-migration.md`)
  5. Smoke test (`db-smoke-test.md`)
- [ ] Validation gates:
  - HALT after env-check (user must fix env vars)
  - HALT after Supabase link (verify connection)
- [ ] Rollback: Not applicable (greenfield)
- [ ] Example usage tested with new project
- [ ] Documentation: README with "When to use" section

**Dependencies:** Research document ✅ Complete

---

### Story 1.2: Analyze Expansion Pack Workflow (KISS Gate) ⏳ PENDING
**Status:** ⏳ Pending
**Story Points:** 3
**Estimate:** 0.5 day
**File:** `docs/stories/story-1.2-analyze-expansion-pack.md`

**Goal:** Create workflow that runs KISS Gate validation before proposing database changes to expansion packs.

**Acceptance Criteria:**
- [ ] Workflow YAML created: `workflows/analyze-expansion-pack.yaml`
- [ ] Sequence defined:
  1. Load KISS validation checklist (`db-kiss-validation-checklist.md`)
  2. STEP 1: Reality Check (system works?)
  3. STEP 2: Pain Validation (ask user)
  4. STEP 3: Existing Schema Check
  5. STEP 4: Minimum Proposal (0 > 1 field > 1 table)
  6. STEP 5: Trade-Offs (present options)
- [ ] Red flags enforced (block if triggered)
- [ ] Output: KISS validation report + recommendation
- [ ] Integration with `*expansion-pack-check` command ✅ **DONE**
- [ ] Tested with creator-os example
- [ ] Documentation: "Why KISS Gate prevents over-engineering"

**Dependencies:**
- KISS checklist ✅ Complete
- KISS template ✅ Complete

---

### Story 1.3: Migrate to Supabase Workflow ⏳ PENDING
**Status:** ⏳ Pending
**Story Points:** 8
**Estimate:** 1.5 days
**File:** `docs/stories/story-1.3-migrate-to-supabase.md`

**Goal:** Create workflow for safely migrating local database to Supabase cloud (local → staging → prod).

**Acceptance Criteria:**
- [ ] Workflow YAML created: `workflows/migrate-to-supabase.yaml`
- [ ] Sequence defined:
  1. Pre-migration checklist (size, version, extensions)
  2. Backup creation (`db-snapshot.md`)
  3. Environment setup (staging vs prod)
  4. Schema migration (`db-apply-migration.md`)
  5. Data migration (optional)
  6. Smoke tests (`db-smoke-test.md`)
  7. Cutover plan
- [ ] Two modes supported:
  - **Maintenance Window:** Full control, 15-60 min downtime
  - **Blue/Green:** Zero downtime (advanced)
- [ ] Validation gates:
  - HALT after backup (verify backup exists)
  - HALT after staging test (user validates)
- [ ] Rollback procedures documented for each step
- [ ] Example: Migrate creator-os local SQLite → Supabase
- [ ] Documentation: "Choosing migration strategy"

**Dependencies:** Research document ✅ Complete

---

### Story 1.4: Import Data Workflow ⏳ PENDING
**Status:** ⏳ Pending
**Story Points:** 5
**Estimate:** 1 day
**File:** `docs/stories/story-1.4-import-data-workflow.md`

**Goal:** Create workflow for safely importing CSV/JSON data to PostgreSQL (staging → production pattern).

**Acceptance Criteria:**
- [ ] Workflow YAML created: `workflows/import-data.yaml`
- [ ] Sequence defined:
  1. File format detection (CSV vs JSON)
  2. Schema validation (columns match table)
  3. Create staging table
  4. COPY to staging (`db-load-csv.md`)
  5. Validate staging data (counts, nulls, duplicates)
  6. Merge to production (with deduplication)
  7. Cleanup staging
- [ ] Three size modes:
  - Small (<50 MB): Dashboard import
  - Medium (50MB-1GB): CLI COPY
  - Large (>1GB): Direct psql COPY
- [ ] Validation gates:
  - HALT after staging load (user validates data quality)
  - HALT before production merge (confirm)
- [ ] Rollback: Transaction-wrapped (auto-rollback on error)
- [ ] Example: Import users.csv to Supabase
- [ ] Documentation: "Staging → Production pattern"

**Dependencies:**
- `db-load-csv.md` task ✅ Exists
- Research document ✅ Complete

---

### Story 1.5: Configure Security Workflow (RLS) ⏳ PENDING
**Status:** ⏳ Pending
**Story Points:** 5
**Estimate:** 1 day
**File:** `docs/stories/story-1.5-configure-security.md`

**Goal:** Create workflow for implementing Row Level Security (RLS) policies systematically.

**Acceptance Criteria:**
- [ ] Workflow YAML created: `workflows/configure-security.yaml`
- [ ] Sequence defined:
  1. RLS audit (`db-rls-audit.md`) - identify tables without RLS
  2. Choose policy pattern:
     - User-based isolation (simple)
     - Team/multi-tenant
     - Role-based (admin + owner)
  3. Apply policies (`db-policy-apply.md`)
  4. Test policies (`db-impersonate.md` - positive + negative cases)
  5. Performance optimization (subquery caching)
  6. Store policies in migration
- [ ] Three policy templates provided:
  - KISS policy (simple user isolation)
  - Granular policies (CRUD separation)
  - Multi-tenant policy
- [ ] Validation gates:
  - HALT after policy creation (user reviews SQL)
  - HALT after testing (verify allowed/denied scenarios)
- [ ] Rollback: Disable RLS, drop policies
- [ ] Example: Secure creator-os courses table
- [ ] Documentation: "RLS patterns and performance"

**Dependencies:**
- `db-rls-audit.md` task ✅ Exists
- `db-policy-apply.md` task ✅ Exists
- `db-impersonate.md` task ✅ Exists
- Research document ✅ Complete

---

### Story 1.6: Optimize Performance Workflow ⏳ PENDING
**Status:** ⏳ Pending
**Story Points:** 5
**Estimate:** 1 day
**File:** `docs/stories/story-1.6-optimize-performance.md`

**Goal:** Create systematic workflow for optimizing slow PostgreSQL queries.

**Acceptance Criteria:**
- [ ] Workflow YAML created: `workflows/optimize-performance.yaml`
- [ ] Sequence defined:
  1. **Phase 1: Baseline** → Identify slow queries (`db-analyze-hotpaths.md`)
  2. **Phase 2: Analyze** → Run EXPLAIN ANALYZE (`db-explain.md`)
  3. **Phase 3: Diagnose:**
     - Sequential Scans → Add indexes
     - Row count mismatches → ANALYZE table
     - Buffer cache misses → Increase shared_buffers
     - N+1 queries → Use JOINs
  4. **Phase 4: Apply** → Create indexes, run ANALYZE
  5. **Phase 5: Validate** → Re-run EXPLAIN, compare before/after
- [ ] Four optimization patterns:
  - Missing indexes (80% of cases)
  - Stale statistics
  - Query rewrite (JOINs vs subqueries)
  - Partitioning (large tables)
- [ ] Validation gates:
  - HALT after diagnosis (user approves optimization plan)
- [ ] Rollback: Drop indexes if performance degrades
- [ ] Example: Optimize creator-os lesson queries
- [ ] Documentation: "Performance optimization checklist"

**Dependencies:**
- `db-analyze-hotpaths.md` task ✅ Exists
- `db-explain.md` task ✅ Exists
- Research document ✅ Complete

---

### Story 1.7: Deploy Production Workflow ⏳ PENDING
**Status:** ⏳ Pending
**Story Points:** 8
**Estimate:** 1.5 days
**File:** `docs/stories/story-1.7-deploy-production.md`

**Goal:** Create workflow for safely deploying database changes to production with rollback plan.

**Acceptance Criteria:**
- [ ] Workflow YAML created: `workflows/deploy-production.yaml`
- [ ] Sequence defined:
  1. **Pre-Deployment:**
     - Checklist validation (`dba-predeploy-checklist.md`)
     - Create rollback point (`db-snapshot.md`)
     - Tag deployment (git tag)
  2. **Deploy Migration:**
     - Apply via CI/CD (GitHub Actions)
     - Monitor logs real-time
     - Run smoke tests (`db-smoke-test.md`)
  3. **Post-Deployment:**
     - Validate query performance
     - Monitor error rates
     - Check replication lag
  4. **Monitor for 24h:**
     - Keep rollback option ready
- [ ] Three rollback methods:
  - Transaction rollback (immediate)
  - Revert migration (< 1 hour)
  - PITR (1 hour - 7 days)
  - Blue/Green failback (instant, zero downtime)
- [ ] Rollback triggers defined:
  - Error rate > 1%
  - Query performance degraded > 50%
  - Replication lag > 10s
- [ ] Validation gates:
  - HALT after pre-deployment checklist
  - HALT after smoke tests
- [ ] Example: Deploy creator-os database changes
- [ ] Documentation: "Production deployment checklist"

**Dependencies:**
- `dba-predeploy-checklist.md` ✅ Exists
- `db-snapshot.md` task ✅ Exists
- `db-smoke-test.md` task ✅ Exists
- Research document ✅ Complete

---

## Technical Architecture

### Workflow File Structure

```
expansion-packs/super-agentes/
├── workflows/
│   ├── setup-database.yaml              # Story 1.1
│   ├── analyze-expansion-pack.yaml      # Story 1.2 (KISS Gate)
│   ├── migrate-to-supabase.yaml         # Story 1.3
│   ├── import-data.yaml                 # Story 1.4
│   ├── configure-security.yaml          # Story 1.5 (RLS)
│   ├── optimize-performance.yaml        # Story 1.6
│   └── deploy-production.yaml           # Story 1.7
├── tasks/                              # 29 existing tasks (reused)
├── templates/                          # RLS, migration templates
├── checklists/                         # Validation checklists
└── docs/
    ├── epics/
    │   └── epic-db-sage-workflows.md   # This file
    ├── stories/
    │   ├── story-1.1-setup-database-workflow.md
    │   ├── story-1.2-analyze-expansion-pack.md
    │   ├── story-1.3-migrate-to-supabase.md
    │   ├── story-1.4-import-data-workflow.md
    │   ├── story-1.5-configure-security.md
    │   ├── story-1.6-optimize-performance.md
    │   └── story-1.7-deploy-production.md
    └── research/
        └── db-workflows-research-2024.md ✅ DONE
```

### Workflow YAML Format (Standard)

```yaml
workflow:
  id: setup-database
  name: Setup New Database
  description: >-
    Initialize new Supabase database from scratch with best practices.
  type: greenfield

  sequence:
    - agent: db-sage
      creates: environment-validation
      task: db-env-check.md
      outputs:
        - Environment variables validated
      notes: |
        Check SUPABASE_ACCESS_TOKEN, SUPABASE_DB_PASSWORD, etc.

    - manual_halt:
      action: fix_environment_variables
      duration: 5-10 minutes
      notes: |
        ✋ WORKFLOW HALTED - Fix Environment Variables

        Required:
        - SUPABASE_ACCESS_TOKEN=...
        - SUPABASE_DB_PASSWORD=...
        - SUPABASE_PROJECT_ID=...

        When fixed, continue with:
          *bootstrap
```

---

## Risk Assessment

### Technical Risks

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Workflows too complex for non-experts | HIGH | MEDIUM | User testing with frontend devs, simplify language |
| Existing 29 tasks break | HIGH | LOW | No modifications to tasks, only orchestration |
| KISS Gate blocks valid use cases | MEDIUM | LOW | Red flags tuned based on research (90%+ accuracy) |
| Rollback procedures fail | HIGH | LOW | Test rollback in all workflows, document thoroughly |

### User Adoption Risks

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Users bypass workflows, use commands directly | MEDIUM | MEDIUM | Hide commands behind `*advanced`, educate on workflows |
| Workflows don't match real-world use cases | HIGH | LOW | Based on industry research (Supabase, Prisma, community) |
| Documentation incomplete | MEDIUM | MEDIUM | Each workflow has README with "When to use" section |

---

## Definition of Done

### Epic Complete When:
- [ ] All 7 workflow YAML files created and tested
- [ ] db-sage menu updated (`*help` → workflows, `*advanced` → commands)
- [ ] All 7 story files created with detailed acceptance criteria
- [ ] Research document published ✅ **DONE**
- [ ] Integration tested with creator-os example
- [ ] Documentation complete for each workflow
- [ ] User guide: "Choosing the right workflow"
- [ ] No regression in existing 29 commands

### Story Complete When:
- [ ] Workflow YAML file created
- [ ] All acceptance criteria met
- [ ] Flow diagram included (Mermaid)
- [ ] Example usage tested
- [ ] Documentation README created
- [ ] Code review approved
- [ ] Synced to `.claude/` and `.cursor/` ✅

---

## Dependencies

### Research (Complete ✅)
- ✅ Supabase CLI best practices 2024
- ✅ PostgreSQL migration strategies
- ✅ CSV import patterns (staging → production)
- ✅ RLS implementation patterns
- ✅ Query performance optimization systematic approach
- ✅ Production deployment checklists
- ✅ Industry tool comparison (Prisma, Hasura)

### Existing Infrastructure (Complete ✅)
- ✅ 29 technical tasks (`expansion-packs/super-agentes/tasks/`)
- ✅ KISS Gate validation (`db-kiss-validation-checklist.md`)
- ✅ KISS template (`db-analysis-template.yaml`)
- ✅ db-sage agent definition (`agents/db-sage.md`)
- ✅ RLS, migration, seed templates

---

## Timeline

| Day | Focus | Stories | Deliverables |
|-----|-------|---------|--------------|
| **Day 1** | Setup + KISS | 1.1, 1.2 | setup-database.yaml, analyze-expansion-pack.yaml |
| **Day 2** | Migration | 1.3 | migrate-to-supabase.yaml |
| **Day 3** | Data Ops | 1.4 | import-data.yaml |
| **Day 4** | Security | 1.5 | configure-security.yaml |
| **Day 5** | Performance | 1.6 | optimize-performance.yaml |
| **Day 6** | Deployment | 1.7 | deploy-production.yaml |
| **Day 7** | Integration + Testing | All | End-to-end testing with creator-os |

**Total Effort:** 39 story points (~7 days)

---

## Success Metrics

### Quantitative:
- ⏱️ Time to setup database: **30 min → 5 min** (83% reduction)
- 🎯 KISS Gate blocks over-engineering: **≥90%** of invalid requests
- 🛡️ Data loss incidents: **0** (via mandatory backups)
- 📊 User satisfaction: **≥4.5/5** (survey after 2 weeks)

### Qualitative:
- ✅ Non-database experts can use DB Sage
- ✅ Workflows feel intuitive (no manual reading needed)
- ✅ Rollback procedures work reliably
- ✅ Documentation clarity: "I understood without asking"

---

## References

- **Research Document:** `expansion-packs/super-agentes/docs/research/db-workflows-research-2024.md` ✅
- **AIOS Workflows:** `.aios-core/workflows/` (greenfield-service.yaml, brownfield-ui.yaml)
- **KISS Gate System:** `checklists/db-kiss-validation-checklist.md`, `templates/db-analysis-template.yaml`
- **Industry Standards:**
  - Supabase Docs: https://supabase.com/docs/guides/local-development
  - PostgreSQL Performance: https://www.postgresql.org/docs/current/performance-tips.html
  - RLS Patterns: https://supabase.com/docs/guides/database/postgres/row-level-security

---

**Epic Created:** 2025-10-27
**Last Updated:** 2025-10-27
**Status:** 📋 READY FOR DEVELOPMENT
