# Tasks Not Used in Workflows - Reference List

**Date:** 2025-10-27
**Context:** DB Sage workflows implementation analysis
**Related Log:** 2025-10-27-db-sage-task-usage-analysis.md

---

## 📋 Complete List: Tasks NOT in Workflows

### 1. db-bootstrap

**File:** `expansion-packs/super-agentes/tasks/db-bootstrap.md`

**Used Via:** Direct command `*bootstrap`

**Purpose:** Scaffold supabase/ project structure (migrations, seeds, tests, rollback, docs)

**Why Not in Workflow:**
- **Frequency:** Once per project (initial setup)
- **Nature:** One-time scaffolding operation
- **Complexity:** Simple directory creation, doesn't need multi-step workflow

**When to Use:** 
- Starting new database project
- Need to create standard folder structure
- Setting up Supabase project from scratch

---

### 2. db-domain-modeling

**File:** `expansion-packs/super-agentes/tasks/db-domain-modeling.md`

**Used Via:** Direct command `*model-domain`

**Purpose:** Domain-driven schema design (understand business before modeling data)

**Why Not in Workflow:**
- **Frequency:** As needed (pre-implementation phase)
- **Nature:** Design/planning activity, not operational
- **Complexity:** Interactive design session, highly user-driven

**When to Use:**
- Designing new database schema
- Modeling business domain
- Before creating tables (design-first approach)

---

### 3. db-impersonate

**File:** `expansion-packs/super-agentes/tasks/db-impersonate.md`

**Used Via:** Direct command `*impersonate {user_id}`

**Purpose:** Set session claims to emulate a user for RLS testing

**Why Not in Workflow:**
- **Frequency:** Ad-hoc (during RLS debugging)
- **Nature:** Testing/debugging utility
- **Complexity:** Single command, doesn't need workflow wrapper

**When to Use:**
- Testing RLS policies
- Debugging user-specific data access
- Verifying permission boundaries
- QA testing with specific user roles

---

### 4. db-policy-apply

**File:** `expansion-packs/super-agentes/tasks/db-policy-apply.md`

**Used Via:** Direct command `*policy-apply {table} {mode}`

**Purpose:** Install standard KISS policy or granular policy set

**Why Not in Workflow:**
- **Frequency:** As needed (when adding RLS to tables)
- **Nature:** Manual decision (which policy strategy to use)
- **Complexity:** Template application, user decides which pattern

**When to Use:**
- Adding RLS policies to existing tables
- Applying standard policy patterns
- Quick policy scaffolding

---

### 5. db-schema-audit

**File:** `expansion-packs/super-agentes/tasks/db-schema-audit.md`

**Used Via:** Direct command `*audit-schema`

**Purpose:** Comprehensive schema quality audit

**Why Not in Workflow:**
- **Frequency:** Periodic (weekly/monthly audits)
- **Nature:** Comprehensive analysis, not routine operation
- **Complexity:** Extensive checks, generates reports

**When to Use:**
- Regular schema health checks
- Before major releases
- Compliance audits
- Finding schema quality issues

---

### 6. db-supabase-setup

**File:** `expansion-packs/super-agentes/tasks/db-supabase-setup.md`

**Used Via:** Direct command `*setup-supabase`

**Purpose:** Interactive Supabase project setup guide

**Why Not in Workflow:**
- **Frequency:** Once per project
- **Nature:** Initial configuration/onboarding
- **Complexity:** Interactive Q&A, highly variable

**When to Use:**
- Setting up new Supabase project
- First-time Supabase users
- Need guided setup process

---

### 7. db-query-optimization (DUPLICATE)

**File:** `expansion-packs/super-agentes/tasks/db-query-optimization.md`

**Status:** ❌ **DUPLICATE of query-optimization.md**

**Used Via:** N/A (not referenced anywhere)

**Why Not in Workflow:**
- **Reason:** 100% identical to `query-optimization.md` (566 lines)
- **Impact:** Zero (workflows use `query-optimization` without db- prefix)

**Recommendation:** 🗑️ **REMOVE THIS FILE**

**Verification:**
```bash
cd expansion-packs/super-agentes/tasks
diff db-query-optimization.md query-optimization.md
# Output: (empty) - files are identical
```

---

## 📊 Summary Statistics

| Category | Count | Tasks |
|----------|-------|-------|
| **One-time Setup** | 2 | db-bootstrap, db-supabase-setup |
| **Design/Planning** | 1 | db-domain-modeling |
| **Testing/Debugging** | 1 | db-impersonate |
| **Manual Operations** | 1 | db-policy-apply |
| **Periodic Audits** | 1 | db-schema-audit |
| **Duplicates** | 1 | db-query-optimization |
| **TOTAL** | **7** | |

---

## 🎯 Design Principles: Why Separate?

### Workflows Are For:
✅ **Repeatable** multi-step processes
✅ **Common** operations (daily/weekly usage)
✅ **Automated** sequences with validation
✅ **Safety-critical** operations needing checks

Examples: setup, query, migrate, analyze, backup, tune

### Direct Commands Are For:
✅ **One-time** or infrequent operations
✅ **Specialized** tasks requiring expert decision
✅ **Simple** operations (single step)
✅ **Interactive** design/planning activities

Examples: bootstrap, impersonate, audit, domain modeling

---

## ✅ Conclusion

**All 7 tasks serve valid purposes:**
- 6 are specialized commands used as needed
- 1 is duplicate (should be removed)

**No orphaned tasks** - excellent architecture\!

**Action Item:** Remove `db-query-optimization.md` (duplicate)

---

## Related Documents

- Main Log: docs/logs/2025-10-27-db-sage-task-usage-analysis.md
- Technical Analysis: /tmp/claude/db-sage-qa-analysis.md
- Tasks Directory: expansion-packs/super-agentes/tasks/

---

*Reference list created by DB Sage on 2025-10-27*
