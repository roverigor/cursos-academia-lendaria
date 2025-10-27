# 🔄 SESSION CONTEXT - Database Architecture

**Last Updated:** 2025-10-26
**Session:** Database Architecture & Supabase Migration
**Status:** ⚠️ **BLOCKED** - 2 Critical Bugs Found (P0)
**Progress:** 95% Complete - Ready for Production After Fixes

---

## 📍 WHERE WE ARE

### Current State:
- ✅ Complete unified database schema (0.6.sql - 823 lines)
- ✅ Comprehensive smoke test (0.6_smoke_test.sql - 594 lines)
- ✅ Full DDL audit completed (0.6_DDL_AUDIT.md)
- ⚠️ **2 CRITICAL BUGS** identified - blocking production deployment

### Grade: **B+ (8.0/10)**
- Excellent architecture
- Strong foundation
- 2 critical bugs to fix
- 3 important improvements (non-blocking)

---

## 🗂️ KEY FILES

```
expansion-packs/fragments/docs/db-draft/

📦 PRODUCTION SCHEMA:
├── 0.6.sql ──────────────── ✅ All-in-one DDL (33 tables, 9 views, 18 RLS policies)

🧪 VALIDATION:
├── 0.6_smoke_test.sql ───── ✅ Complete test suite (8 test suites, 50+ tests)
├── 0.6_DDL_AUDIT.md ─────── ✅ Production readiness audit (Grade B+)

📖 DOCUMENTATION:
├── 0.6_ANALYSIS-unified.md ─ Analysis of 0.4→0.6 evolution
├── 0.6_README_UNIFIED_DATABASE.md ─ User guide
└── CONTEXT.md ──────────── 📌 THIS FILE (session context)

📜 HISTORICAL:
├── 0.3.sql ─────────────── MMOS + InnerLens + Fragments (baseline)
├── 004_creatorOS_cores.sql ─ CreatorOS KISS version
└── 005_auth_supabase.sql ── Auth patterns (reference)
```

---

## 🔴 CRITICAL BUGS (P0 - BLOCKING)

### Bug #1: `provision_user_profile()` - Slug Collision

**File:** 0.6.sql (lines 667-689)

**Problem:**
```sql
-- Current (WRONG):
v_slug := split_part(NEW.email, '@', 1);  -- alan@gmail.com → "alan"

INSERT INTO minds (slug, ...) VALUES (v_slug, ...)
ON CONFLICT (slug) DO NOTHING;  -- ⚠️ Silent failure!
```

**Scenario:**
```
1. alan@gmail.com signs up → mind slug='alan' created ✅
2. alan@outlook.com signs up → slug='alan' conflicts → REUSES first user's mind ❌
```

**Impact:** 🔥 Data corruption - users share same mind!

**Fix:** Add suffix for uniqueness (alan → alan_2 → alan_3)

**Time:** 30 minutes

**Reference:** 0.6_DDL_AUDIT.md lines 408-507

---

### Bug #2: `fragments.mind_id` - Wrong DEFAULT

**File:** 0.6.sql (line 696)

**Problem:**
```sql
-- Current (WRONG):
ALTER TABLE fragments ALTER COLUMN mind_id SET DEFAULT current_mind_id();
```

**Why Wrong:**
```
fragment.mind_id MUST EQUAL source.mind_id (ALWAYS!)
≠ current_mind_id() (current user)
```

**Hierarchy Rule:**
```
mind (Naval Ravikant - id: 'naval-123')
  ↓ HAS
source (Almanack book - mind_id: 'naval-123')
  ↓ CONTAINS
fragment (quote - mind_id: MUST BE 'naval-123', NOT current user!)
```

**Scenario:**
```javascript
// User A (mind_id='user-a') is researching Naval

// 1. Create source for Naval's book
const source = await supabase.from('sources').insert({
  mind_id: 'naval-123',  // Naval's mind
  title: 'Almanack of Naval'
})

// 2. Create fragment
const fragment = await supabase.from('fragments').insert({
  source_id: source.id,
  content: 'Seek wealth...'
})

// ❌ BUG: fragment.mind_id = 'user-a' (current_user)
//         source.mind_id = 'naval-123'
//         HIERARCHY BROKEN!

// ✅ SHOULD: fragment.mind_id = 'naval-123' (from source)
```

**Impact:** 🔥 Breaks research workflow, data integrity violated

**Fix:**
1. Remove `DEFAULT current_mind_id()`
2. Add trigger to derive from `source.mind_id`
3. Validate consistency

**Time:** 20 minutes

**Reference:** 0.6_DDL_AUDIT.md lines 679-768

---

## ✅ CORRECT DEFAULTS (For Reference)

```sql
-- ✅ CORRECT: User creates for THEIR OWN mind
ALTER TABLE sources ALTER COLUMN mind_id SET DEFAULT current_mind_id();
ALTER TABLE mind_profiles ALTER COLUMN mind_id SET DEFAULT current_mind_id();
ALTER TABLE content_projects ALTER COLUMN creator_mind_id SET DEFAULT current_mind_id();

-- ❌ WRONG: Must derive from parent entity
ALTER TABLE fragments ALTER COLUMN mind_id SET DEFAULT current_mind_id();  -- FIX THIS!
```

---

## 🎯 NEXT STEPS (Priority Order)

### 1. Fix P0 Bugs (CRITICAL - 50 min)
- [ ] Fix `provision_user_profile()` slug collision → 30 min
- [ ] Fix `fragments.mind_id` DEFAULT → 20 min

### 2. Create Seed Data (IMPORTANT - 30 min)
- [ ] Create `0.7_seed_data.sql`
  - Categories: BIO, COG, VAL, PHI, PRO
  - Traits: Big Five (openness, conscientiousness, etc)
  - Frameworks: GPS, AIDA, PAS, Bloom's Taxonomy
  - Domains/Skills: Basic taxonomy

### 3. Add Missing RLS (IMPORTANT - 10 min)
- [ ] Add RLS policy to `audience_profiles`

### 4. Deploy & Test (15 min)
- [ ] Deploy 0.6.sql to Supabase
- [ ] Run 0.6_smoke_test.sql
- [ ] Test Magic Link signup (verify fixes)
- [ ] Validate RLS isolation

### 5. Documentation (Optional - 30 min)
- [ ] Add COMMENT ON statements to tables/columns
- [ ] Update README with deployment instructions

**Total Estimated Time:** ~2h 30min to production-ready

---

## 🏗️ ARCHITECTURE OVERVIEW

### Schema Inventory:
```
📦 Extensions: 1 (pgcrypto)
🔧 Functions: 4 (set_updated_at, snap_to_tenth, current_mind_id, provision_user_profile)
📋 Tables: 33
👁️ Views: 9 (analytics)
🔒 RLS Policies: 18
🔗 Indexes: 45+
🎯 Triggers: 16
```

### Tables by Module:
| Module | Tables | Key Entities |
|--------|--------|--------------|
| **Core** | 8 | minds, sources, fragments, categories, tags |
| **Operational** | 3 | batches, queue, executions (LLM telemetry) |
| **MMOS** | 9 | profiles, values, routines, obsessions |
| **InnerLens** | 7 | traits, scores, proficiencies, domains |
| **CreatorOS** | 7 | projects, content, campaigns, performance |
| **Auth** | 1 | user_profiles (maps auth.users → minds) |

---

## 🔑 CRITICAL CONCEPTS

### 1. Entity Hierarchy (IMMUTABLE!)
```
mind (ROOT entity)
  ↓ owns
sources (books, articles, podcasts)
  ↓ contains
fragments (extracted quotes, insights)
```

**RULE:** `fragment.mind_id = source.mind_id` (ALWAYS!)

### 2. Research Mode
- Users can create sources for OTHER minds (public figures)
- User A can map Naval Ravikant's content
- Fragments belong to Naval's mind, not User A's mind

### 3. Auth Flow (Passwordless)
```
1. User enters email → Magic Link sent
2. User clicks link → auth.users created
3. TRIGGER fires → provision_user_profile()
   - Creates mind (slug from email)
   - Creates user_profile (links auth.users → mind)
4. User logged in with mind_id
```

### 4. Security Pattern
```
DEFAULT current_mind_id() on columns
   +
RLS USING (mind_id = current_mind_id())
   =
Double protection (even if RLS has bug, DEFAULT prevents manipulation)
```

---

## 📊 COVERAGE

### Expansion Packs Supported:
- ✅ **MMOS** (Mind Mapping) - 100%
- ✅ **InnerLens** (Psychometrics) - 100%
- ✅ **CreatorOS** (Content Creation) - 100%
- ✅ **Fragments** (Core System) - 100%

### RLS Coverage:
- ✅ 18/33 tables have RLS (55%)
- ✅ All user-facing tables protected
- ✅ Operational tables (batches, queue, executions) = service-role only

### Performance Features:
- ✅ Hot path indexes (index-only scans)
- ✅ FTS with GIN index (full-text search)
- ✅ Covering indexes (INCLUDE clause)
- ✅ Canonical graph indexes (LEAST/GREATEST pattern)

---

## 🚀 DEPLOYMENT CHECKLIST

### Pre-Deploy:
- [ ] Fix 2 P0 bugs
- [ ] Create seed data
- [ ] Add missing RLS

### Deploy:
```bash
# 1. Connect to Supabase
psql "postgresql://postgres:[PASS]@db.[PROJECT].supabase.co:5432/postgres"

# 2. Deploy schema
\i 0.6.sql

# 3. Deploy seed data
\i 0.7_seed_data.sql

# 4. Run smoke test
\i 0.6_smoke_test.sql
```

### Post-Deploy:
- [ ] Configure Magic Link auth (Supabase Dashboard)
- [ ] Test signup flow
- [ ] Verify RLS isolation
- [ ] Run EXPLAIN ANALYZE on hot queries

---

## 💡 KEY DECISIONS MADE

### 1. All-in-One vs Modular
**Decision:** Single file (0.6.sql)
**Rationale:** Easier deployment, less duplication, atomic updates

### 2. RLS Strategy
**Decision:** 1 policy FOR ALL per table
**Rationale:** KISS, consistent, easier to maintain (vs 4 policies per table)

### 3. Provenance
**Decision:** Full LLM telemetry (batches → queue → executions → artifacts)
**Rationale:** Cost tracking, debugging, auditing, reproducibility

### 4. DEFAULTS Pattern
**Decision:** Use `DEFAULT current_mind_id()` on owner columns
**Rationale:** Security (client can't manipulate), simplicity (frontend doesn't send mind_id)

**Exception:** `fragments.mind_id` derives from `source.mind_id` (hierarchy!)

### 5. Idempotent DDL
**Decision:** All objects use IF NOT EXISTS / CREATE OR REPLACE
**Rationale:** CI/CD friendly, re-runnable, zero-downtime migrations

---

## 🔗 QUICK LINKS

**Audit Issues:**
- Issue #3 (P0): provision_user_profile slug collision → lines 408-507
- Issue #10 (P0): fragments.mind_id DEFAULT wrong → lines 679-768
- Full audit: 0.6_DDL_AUDIT.md

**Fixes Needed:**
- P0 fixes: 0.6_DDL_AUDIT.md lines 925-933
- P1 improvements: lines 935-943

**Architecture:**
- Complete analysis: 0.6_ANALYSIS-unified.md
- User guide: 0.6_README_UNIFIED_DATABASE.md

---

## 📝 NOTES FOR NEXT SESSION

### What to do first:
1. Read this file (5 min)
2. Review P0 bug fixes (0.6_DDL_AUDIT.md lines 408-507, 679-768)
3. Start with Bug #2 (fragments.mind_id) - cleaner fix
4. Then Bug #1 (provision_user_profile) - more complex

### Questions to ask user:
- [ ] Ready to fix bugs and deploy?
- [ ] Want to review fixes before applying?
- [ ] Need help with Supabase project setup?

### Context restored in:
- Session ID: 2025-10-26-database-architecture
- Architect: Winston (@architect)
- Total time invested: ~8 hours
- Files created: 15+
- Lines of SQL: 823 (schema) + 594 (tests) = 1,417 lines

---

**Status:** ⚠️ **READY FOR FIXES** - Clear path to production (2.5h work remaining)
