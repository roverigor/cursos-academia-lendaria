# 📜 Database Evolution History

This directory contains the historical evolution of the database schema from draft to production-ready.

---

## 🗺️ Evolution Timeline

### v0.1 → v0.3: Initial Iterations (Drafts)
- **0.1.sql** - First draft: Basic minds + fragments
- **0.2.sql** - Second iteration: Added MMOS profiles
- **0.3.sql** - Third iteration: InnerLens integration

### v0.6: Unified All-in-One (WITH BUGS ❌)
- **0.6.sql** - Complete unified schema  
- **0.6_DDL_AUDIT.md** - Bug analysis (CRITICAL)

**BUGS:** provision_user_profile slug collision + fragments.mind_id wrong DEFAULT

### v0.7: Production-Ready Baseline ✅
- **0.7.sql** - Fixed all P0 bugs
- **Location:** `supabase/migrations/20251026211500_v0_7_0_baseline.sql`

---

## ⚠️ Do Not Use These Files Directly

These files are **HISTORICAL ONLY**.

**For current migrations, use:** `supabase/migrations/`

---

**Preserved:** 2025-10-26
**Original:** expansion-packs/fragments/docs/db-draft/
