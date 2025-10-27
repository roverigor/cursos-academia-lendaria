# Migration History

**Project:** Mente Lendária - Database Migrations
**Strategy:** Timestamp-based migrations with automatic snapshots
**Rollback:** Snapshot restore + manual rollback scripts

---

## 📋 How to Update This File

After applying a migration, add an entry with:
- Migration file name
- Date/time applied
- Environment (staging/production)
- Snapshot locations
- Changes summary
- Test results
- Deployment time

---

## v0.7.0 - Baseline (PENDING)

### 20251026211500_v0_7_0_baseline.sql
**Status:** ⏳ Pending deployment
**Planned Date:** 2025-10-26
**Environments:** staging → production

**Changes:**
- ✅ FIX P0: `provision_user_profile()` slug collision (alan→alan_2)
- ✅ FIX P0: `fragments.mind_id` trigger (inherits from source)
- ✅ FIX P1: `audience_profiles` RLS policy added
- ✅ CREATE: 30 tables (minds, sources, fragments, profiles, content, etc.)
- ✅ CREATE: 3 analytics views
- ✅ CREATE: 16 RLS policies
- ✅ CREATE: 4 functions (set_updated_at, snap_to_tenth, current_mind_id, provision_user_profile, set_fragment_mind_id)

**Dependencies:** None (baseline)

**Tested:** ⏳ Pending

**Deployment Command:**
```bash
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql
```

**Rollback:**
```bash
./scripts/db-rollback.sh v0_7_0
```

---

### 20251026213000_v0_7_0_seed.sql
**Status:** ⏳ Pending deployment
**Planned Date:** 2025-10-26 (after baseline)
**Environments:** staging → production

**Changes:**
- ✅ SEED: 5 categories (BIO, COG, VAL, PHI, PRO)
- ✅ SEED: 5 traits (Big Five: openness, conscientiousness, extraversion, agreeableness, neuroticism)
- ✅ SEED: 4 content_frameworks (GPS, AIDA, PAS, Bloom's Taxonomy)

**Dependencies:** Requires 20251026211500_v0_7_0_baseline.sql

**Tested:** ⏳ Pending

**Deployment Command:**
```bash
./scripts/db-migrate.sh supabase/migrations/20251026213000_v0_7_0_seed.sql
```

**Rollback:**
```bash
./scripts/db-rollback.sh v0_7_0
# OR delete seed data manually:
DELETE FROM categories; DELETE FROM traits; DELETE FROM content_frameworks;
```

---

## v0.8.0 - Collaboration (FUTURE)

### Status: Not created yet
**When:** When collaboration becomes a requirement
**What:** mind_members table + can_edit_mind() + can_view_mind() functions + updated RLS policies

**To create:**
See design in `/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria/docs/database/MIGRATION-ARCHITECTURE.md`

---

## Migration Guidelines

### Pre-Deployment Checklist
- [ ] Migration tested in local database
- [ ] Migration tested in staging
- [ ] Smoke test passes
- [ ] Manual validation complete
- [ ] Team notified

### Deployment Windows
**Staging:** Anytime
**Production:** Off-peak hours (2-4 AM UTC recommended)

### Rollback Criteria
Immediate rollback if:
- Smoke test fails
- Production errors > baseline
- Data corruption detected
- Performance degradation > 50%

---

## Template for New Entries

```markdown
### YYYYMMDDHHmmss_vX_Y_Z_description.sql
**Status:** ✅ Applied / ⏳ Pending / ❌ Failed
**Date:** YYYY-MM-DD HH:MM:SS
**Environment:** staging / production / both
**Snapshot:** schemas/vX_Y_Z_YYYYMMDDHHmmss_before.sql
**Rollback:** rollback/YYYYMMDDHHmmss_vX_Y_Z_description_rollback.sql

**Changes:**
- List of changes

**Tested:** ✅ Passed / ❌ Failed
**Issues:** None / Description of issues

**Deployment time:** X seconds
**Deployed by:** Name
```

---

**Last Updated:** 2025-10-26
**Maintained by:** Database Team
