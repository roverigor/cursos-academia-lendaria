# 🏗️ Database Migration Architecture (Design Document)

**Status:** 📋 **DESIGN PHASE** - Awaiting approval before implementation
**Date:** 2025-10-26
**Author:** Winston (@architect) + architect-first skill
**Version:** 1.0

---

## 📊 Executive Summary

This document defines the complete architecture for transitioning database management from **ad-hoc draft files** to a **production-grade migration system** with:

- ✅ **Absolute Control** - Every change tracked, every state preserved
- ✅ **Automatic Snapshots** - Pre-migration backups for instant rollback
- ✅ **Supabase Native** - Full integration with Supabase CLI
- ✅ **Timestamp Versioning** - Chronological order guaranteed
- ✅ **Complete Traceability** - Git + docs + snapshots

---

## 🎯 Goals & Non-Goals

### Goals (Must Have)
- ✅ Organize database artifacts in production-grade structure
- ✅ Enable safe migrations with automatic snapshots
- ✅ Maintain complete history and traceability
- ✅ Support rollback to any previous state
- ✅ Integrate with Supabase CLI natively
- ✅ Zero data loss (preserve all historical files)

### Non-Goals (Out of Scope)
- ❌ Multi-database support (PostgreSQL only)
- ❌ Automated CI/CD pipelines (Phase 2)
- ❌ Performance optimization (focus on correctness)
- ❌ Schema diffing tools (Phase 2)

---

## 🗺️ Current State Mapping

### Existing Structure (Before)

```
expansion-packs/fragments/docs/db-draft/
├── 0.1.sql (13K) - Historical: First draft
├── 0.2.sql (21K) - Historical: Second iteration
├── 0.3.sql (27K) - Historical: MMOS + InnerLens + Fragments
├── 0.3_README_MMOS_Database.md (8K)
├── 0.3_VALIDATION-REPORT.md (13K)
├── 0.4_creatorOS_cores.sql (5.5K) - Historical: CreatorOS KISS
├── 0.4_creatorOS.sql (21K) - Historical: CreatorOS full
├── 0.5_auth_supabase.sql (13K) - Historical: Auth patterns
├── 0.6.sql (33K) - Historical: Unified all-in-one (WITH BUGS)
├── 0.6_*.md (multiple docs)
├── 0.7.sql (30K) - ⭐ CURRENT BASELINE (bugs fixed)
├── 0.8_collaboration.sql (12K) - ⭐ FUTURE FEATURE (prepared)
├── CONTEXT.md (9.7K) - Session context
├── README.md (11K)
└── smoke_test.sql (7.5K)
```

**Issues with Current Structure:**
- ⚠️ No migrations directory (files scattered)
- ⚠️ No version control strategy
- ⚠️ No snapshot/rollback mechanism
- ⚠️ Mixed draft + production files
- ⚠️ Located in expansion-pack (should be central)
- ⚠️ No automated testing workflow

---

## 🏗️ Target Architecture (After)

### Directory Structure

```
supabase/                                    # ⭐ NEW: Production database structure
├── config.toml                              # Supabase project configuration
│
├── migrations/                              # ⭐ MIGRATIONS: Version-controlled changes
│   ├── 20251026211500_v0_7_0_baseline.sql  # Init: Complete 0.7 schema
│   ├── 20251026213000_v0_7_0_seed.sql      # Seed: Essential lookups
│   ├── 20251027140000_v0_8_0_collaboration.sql  # Future: Collaboration
│   └── README.md                            # Migration guide
│
├── schemas/                                 # ⭐ SNAPSHOTS: Complete state at each point
│   ├── v0.7.0_20251026211500.sql           # Snapshot after baseline
│   ├── v0.7.0_20251026213000.sql           # Snapshot after seed
│   └── README.md                            # Snapshot usage guide
│
├── tests/                                   # ⭐ TESTS: Automated validation
│   ├── v0.7.0_smoke_test.sql              # Validates 0.7 deployment
│   ├── v0.8.0_smoke_test.sql              # Validates 0.8 deployment
│   └── README.md                            # Test execution guide
│
├── rollback/                                # ⭐ ROLLBACK: Emergency procedures
│   ├── 20251026211500_rollback.sql         # Undo baseline
│   ├── 20251026213000_rollback.sql         # Undo seed
│   └── README.md                            # Rollback procedures
│
└── docs/                                    # ⭐ DOCS: Complete documentation
    ├── MIGRATIONS.md                        # Migration history tracker
    ├── DEPLOYMENT.md                        # Deployment procedures
    ├── ARCHITECTURE.md                      # This document
    └── TROUBLESHOOTING.md                   # Common issues

docs/database/                               # ⭐ MOVED: Central documentation
├── MIGRATION-ARCHITECTURE.md                # This file
├── evolution/                               # Historical evolution
│   ├── 0.1.sql → 0.6.sql                   # Preserved history
│   ├── 0.6_DDL_AUDIT.md                    # Bug analysis
│   ├── CONTEXT.md                           # Session context
│   └── README.md                            # Evolution narrative
└── README.md                                # Database docs index

scripts/                                     # ⭐ AUTOMATION: Safe operations
├── db-migrate.sh                            # Migration wrapper (with snapshot)
├── db-rollback.sh                           # Rollback wrapper
├── db-test.sh                               # Test runner
└── README.md                                # Scripts documentation

expansion-packs/fragments/docs/db-draft/     # ⚠️ DEPRECATED (keep as history)
└── README.md → "Moved to supabase/. See docs/database/evolution/"
```

---

## 🔧 Architecture Components

### 1. Migration Naming Convention

**Format:** `YYYYMMDDHHmmss_v<major>_<minor>_<patch>_<description>.sql`

**Examples:**
```
20251026211500_v0_7_0_baseline.sql
20251026213000_v0_7_0_seed.sql
20251027140000_v0_8_0_collaboration.sql
```

**Rationale:**
- ✅ **Timestamp prefix** - Chronological order guaranteed (no conflicts)
- ✅ **Semantic version** - Understand impact at a glance
- ✅ **Description** - Self-documenting purpose
- ✅ **Supabase compatible** - Works with `supabase db push`

---

### 2. Snapshot Strategy

**When:** Automatic snapshot **before** each migration
**Format:** `v<major>_<minor>_<patch>_<timestamp>.sql`
**Tool:** `pg_dump --schema-only`

**Example:**
```bash
# Before applying migration 20251026211500:
pg_dump $DB_URL --schema-only > schemas/v0.7.0_20251026211500.sql
```

**Storage:**
```
schemas/
├── v0.7.0_20251026211500.sql  # Before: Empty database
├── v0.7.0_20251026211500_after.sql  # After: Baseline applied
├── v0.7.0_20251026213000.sql  # Before: Baseline only
└── v0.7.0_20251026213000_after.sql  # After: Baseline + seed
```

**Retention:** Keep all snapshots (disk is cheap, data loss is expensive)

---

### 3. Rollback Mechanism

**Two strategies:**

#### **A) Snapshot Restore (Recommended for emergencies)**
```bash
# Total rollback to previous snapshot
psql $DB_URL -f schemas/v0.7.0_20251026211500.sql
```

**Pros:** ✅ Guaranteed consistent state
**Cons:** ⚠️ Loses all changes after snapshot

#### **B) Migration Rollback (Selective undo)**
```bash
# Run specific rollback script
psql $DB_URL -f rollback/20251026213000_rollback.sql
```

**Pros:** ✅ Surgical removal of specific change
**Cons:** ⚠️ Requires manual rollback script creation

---

### 4. Test Strategy

**Levels:**

1. **Syntax Validation** (Pre-deploy)
   ```bash
   psql $DB_URL --dry-run -f migration.sql
   ```

2. **Smoke Test** (Post-deploy)
   ```bash
   psql $DB_URL -f tests/v0.7.0_smoke_test.sql
   ```
   - Validates tables created
   - Validates RLS policies
   - Validates functions/triggers
   - Validates seed data

3. **Integration Test** (Manual)
   - Magic Link signup
   - Fragment creation (trigger test)
   - RLS isolation (multi-user)
   - Research mode (cross-mind data)

---

### 5. Automation Scripts

#### **`scripts/db-migrate.sh`**

**Purpose:** Safe migration execution with automatic snapshot

**Flow:**
```
1. Extract version from filename
2. Create pre-migration snapshot
3. Apply migration
4. Create post-migration snapshot
5. Generate rollback script
6. Verify tables/policies
7. Report success
```

**Usage:**
```bash
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql
```

**Output:**
```
🚀 Migration: 20251026211500_v0_7_0_baseline.sql
📸 Snapshot: schemas/v0.7.0_20251026211500.sql
⏳ Applying migration...
✅ Migration applied
📝 Rollback: rollback/20251026211500_rollback.sql
🔍 Verifying...
✅ Complete!
```

#### **`scripts/db-rollback.sh`**

**Purpose:** Safe rollback with confirmation

**Flow:**
```
1. List available snapshots
2. Confirm rollback (destructive!)
3. Backup current state
4. Restore snapshot
5. Verify restoration
6. Report success
```

**Usage:**
```bash
./scripts/db-rollback.sh v0.7.0_20251026211500
```

#### **`scripts/db-test.sh`**

**Purpose:** Run smoke tests for specific version

**Usage:**
```bash
./scripts/db-test.sh v0.7.0
```

---

## 📋 Migration History Tracking

### `supabase/docs/MIGRATIONS.md` Format

```markdown
# Migration History

## v0.7.0 - Baseline (2025-10-26)

### 20251026211500_v0_7_0_baseline.sql
**Status:** ✅ Applied
**Date:** 2025-10-26 21:15:00
**Environment:** staging, production
**Snapshot:** schemas/v0.7.0_20251026211500.sql
**Rollback:** rollback/20251026211500_rollback.sql

**Changes:**
- FIX P0: provision_user_profile() slug collision
- FIX P0: fragments.mind_id trigger
- FIX P1: audience_profiles RLS
- CREATE: 30 tables, 3 views, 16 RLS policies

**Tested:** ✅ smoke_test passed
**Issues:** None

**Deployed by:** Alan
**Migration time:** 2.3 seconds

---

### 20251026213000_v0_7_0_seed.sql
**Status:** ✅ Applied
...
```

---

## 🔐 Security & Safety

### Pre-Deployment Checklist

- [ ] ✅ Migration tested in local database
- [ ] ✅ Migration tested in staging
- [ ] ✅ Snapshot created before deployment
- [ ] ✅ Rollback script prepared
- [ ] ✅ Smoke test passes
- [ ] ✅ Manual validation complete
- [ ] ✅ Team notified of deployment window
- [ ] ✅ Monitoring enabled

### Deployment Windows

**Staging:** Anytime (no restrictions)
**Production:** Off-peak hours (e.g., 2-4 AM UTC)

### Rollback Criteria

**Immediate rollback if:**
- ❌ Smoke test fails
- ❌ Production errors > baseline
- ❌ Data corruption detected
- ❌ Performance degradation > 50%
- ❌ User-facing features broken

---

## 📊 Metrics & Monitoring

### Track:
- Migration execution time
- Table count (expect 30 for v0.7.0)
- Policy count (expect 16 for v0.7.0)
- Function count (expect 4 for v0.7.0)
- Schema size (pg_database_size)

### Alerts:
- Migration takes > 30 seconds
- Table count mismatch
- Policy count mismatch
- Function missing

---

## 🚀 Deployment Workflow

### Phase 1: Staging

```bash
# 1. Link staging project
supabase link --project-ref <staging-ref>

# 2. Apply baseline migration
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql

# 3. Apply seed migration
./scripts/db-migrate.sh supabase/migrations/20251026213000_v0_7_0_seed.sql

# 4. Run smoke test
./scripts/db-test.sh v0.7.0

# 5. Manual validation
# - Magic Link signup
# - Create fragment (trigger test)
# - Verify RLS isolation
```

### Phase 2: Production

```bash
# Same commands, different project
supabase link --project-ref <prod-ref>
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql
./scripts/db-migrate.sh supabase/migrations/20251026213000_v0_7_0_seed.sql
./scripts/db-test.sh v0.7.0
```

---

## 🔄 Zero Coupling Validation

### Principle
Database structure must be **independent** from expansion packs, but **support** all of them.

### Validation
```bash
# Check for hardcoded expansion-pack dependencies
grep -r "expansion-packs" supabase/migrations/
# Expected: No results

# Check for coupling to specific minds
grep -r "naval\|pedro\|joao" supabase/migrations/
# Expected: Only in tests/seeds, not schema
```

### Compliance
✅ **PASS** - Schema is generic, expansion packs consume it

---

## 📝 Documentation Requirements

### Required Docs (Before Implementation)
- [x] This architecture document
- [ ] Migration scripts documentation
- [ ] Snapshot strategy guide
- [ ] Rollback procedures
- [ ] Troubleshooting guide

### Required Docs (After Implementation)
- [ ] Post-deployment report
- [ ] Performance benchmarks
- [ ] Lessons learned

---

## ⚠️ Risks & Mitigations

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Migration fails mid-execution | Low | High | Automatic snapshot + transaction |
| Snapshot creation fails | Low | High | Verify disk space before migration |
| Rollback script incorrect | Medium | High | Manual review + staging test |
| Supabase CLI bug | Low | Medium | Document psql alternative |
| Disk space exhausted | Low | High | Monitor before deployment |

---

## ✅ Acceptance Criteria

### This design is approved when:

- [ ] ✅ User validates directory structure
- [ ] ✅ User validates naming conventions
- [ ] ✅ User validates snapshot strategy
- [ ] ✅ User validates rollback approach
- [ ] ✅ User validates automation scripts design

### Implementation is complete when:

- [ ] ✅ All directories created
- [ ] ✅ All migrations files created
- [ ] ✅ All scripts working
- [ ] ✅ All documentation complete
- [ ] ✅ Staging deployment successful
- [ ] ✅ Smoke tests passing

---

## 🎯 Next Steps (After Approval)

1. **Create directory structure** (5 min)
2. **Copy/adapt migration files** (10 min)
3. **Create automation scripts** (15 min)
4. **Create documentation** (15 min)
5. **Test locally** (10 min)
6. **Deploy to staging** (15 min)
7. **Validate** (10 min)

**Total:** ~80 minutes

---

## 📞 Decision Points Requiring User Approval

### 🟡 **DECISION 1: Directory Structure**
**Proposed:** `supabase/migrations/`, `supabase/schemas/`, `supabase/tests/`, etc.
**Alternative:** Different folder names?
**Your decision:** ___________

### 🟡 **DECISION 2: Snapshot Frequency**
**Proposed:** Before EVERY migration
**Alternative:** Only major versions?
**Your decision:** ___________

### 🟡 **DECISION 3: Historical Files**
**Proposed:** Move to `docs/database/evolution/` (keep as history)
**Alternative:** Delete old drafts?
**Your decision:** ___________

### 🟡 **DECISION 4: 0.8 Collaboration**
**Proposed:** Prepare file now, apply later
**Alternative:** Create when needed?
**Your decision:** ___________

---

**Status:** 📋 AWAITING APPROVAL
**Next Action:** User reviews and approves design
**Then:** Implementation phase begins

---

**Document Version:** 1.0
**Last Updated:** 2025-10-26
**Author:** Winston (@architect) + architect-first skill
