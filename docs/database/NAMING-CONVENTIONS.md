# 🏷️ Database Naming Conventions & Rules

**Last Updated:** 2025-10-28
**Status:** Production Standard
**Enforcement:** Automated + Manual Review

---

## 🎯 Core Principle

**Table names in production MUST NOT contain version suffixes or backup indicators.**

```
✅ Good: users, content_pieces, fragments
❌ Bad:  users_v0_7_0, content_backup, fragments_old
```

**Why?**
- Schema versioning belongs in migration history, NOT table names
- Backup tables clutter the database and cause confusion
- Version suffixes make queries brittle and error-prone

---

## ✅ Naming Rules

### Tables

**Format:** `snake_case`, singular or plural based on convention

**✅ Correct:**
```sql
CREATE TABLE minds (...);
CREATE TABLE content_pieces (...);
CREATE TABLE fragment_relationships (...);
CREATE TABLE user_profiles (...);
```

**❌ FORBIDDEN:**
```sql
-- Version suffixes
CREATE TABLE minds_v0_7_0 (...);        -- ❌ NO!
CREATE TABLE content_v1_0_0 (...);      -- ❌ NO!

-- Backup indicators
CREATE TABLE users_backup (...);        -- ❌ NO!
CREATE TABLE fragments_old (...);       -- ❌ NO!
CREATE TABLE minds_copy (...);          -- ❌ NO!
CREATE TABLE content_20251028 (...);    -- ❌ NO!

-- Temporary indicators (use temp schema instead)
CREATE TABLE temp_users (...);          -- ❌ NO!
CREATE TABLE users_tmp (...);           -- ❌ NO!
```

---

### Columns

**Format:** `snake_case`

**✅ Correct:**
```sql
id              -- Primary key
created_at      -- Timestamp
updated_at      -- Timestamp
mind_id         -- Foreign key
display_name    -- Descriptive field
is_active       -- Boolean
```

**❌ Avoid:**
```sql
ID              -- Use lowercase: id
createdAt       -- Use snake_case: created_at
MindId          -- Use snake_case: mind_id
active          -- Prefer is_active for booleans
```

---

### Indexes

**Format:** `idx_{table}_{columns}`

**✅ Correct:**
```sql
idx_minds_slug
idx_fragments_mind_id_relevance
idx_sources_published_date
```

**❌ Avoid:**
```sql
index_minds_slug           -- Too verbose
minds_slug_idx             -- Wrong order
idx_v0_minds_slug          -- No version suffixes!
```

---

### Views

**Format:** `v_{descriptive_name}`

**✅ Correct:**
```sql
v_job_mind_attribution
v_batch_costs
v_mind_latest_profiles
```

**❌ Avoid:**
```sql
job_mind_attribution_view  -- Use v_ prefix
view_batch_costs           -- Use v_ prefix
v_costs_v0_7_0             -- No version suffixes!
```

---

### Functions

**Format:** `{verb}_{noun}` or `{noun}_{verb}`

**✅ Correct:**
```sql
current_mind_id()
calculate_cost(...)
get_latest_profile(...)
```

**❌ Avoid:**
```sql
CurrentMindId()            -- Use snake_case
calcCost(...)              -- Too abbreviated
get_latest_profile_v2(...) -- No version suffixes!
```

---

## 🚫 What NOT To Do

### 1. **Never Create Versioned Tables**

```sql
-- ❌ WRONG
CREATE TABLE minds AS SELECT * FROM minds_v0_7_0;
ALTER TABLE minds RENAME TO minds_v0_8_0;
CREATE TABLE minds AS ...;

-- ✅ CORRECT
-- Use migrations to evolve schema
-- Old schema → Migration → New schema
-- No intermediate versioned tables!
```

### 2. **Never Create Backup Tables**

```sql
-- ❌ WRONG
CREATE TABLE users_backup AS SELECT * FROM users;
-- Then do risky operation on users

-- ✅ CORRECT
-- Use pg_dump for backups:
pg_dump "$SUPABASE_DB_URL" -t users > users_backup_20251028.sql

-- Or use a separate backup schema:
CREATE SCHEMA IF NOT EXISTS backups;
CREATE TABLE backups.users_20251028 AS SELECT * FROM public.users;
```

### 3. **Never Use Date Suffixes**

```sql
-- ❌ WRONG
CREATE TABLE logs_2025_01 (...);
CREATE TABLE events_20250128 (...);

-- ✅ CORRECT
-- Use partitioning if needed:
CREATE TABLE logs (...) PARTITION BY RANGE (created_at);
CREATE TABLE logs_2025_q1 PARTITION OF logs
  FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');
```

---

## ✅ What TO Do Instead

### For Schema Evolution

Use **migrations** with proper versioning:

```bash
# Migration filename format:
supabase/migrations/YYYYMMDD_VERSION_description.sql

# Examples:
20251028_0.8.0_add_collaboration_tables.sql
20251029_0.8.1_add_mind_members.sql
```

### For Backups

Use one of these methods:

**Option 1: pg_dump (recommended)**
```bash
pg_dump "$SUPABASE_DB_URL" > backup_20251028.sql
pg_dump "$SUPABASE_DB_URL" -t specific_table > table_backup.sql
```

**Option 2: Separate backup schema**
```sql
CREATE SCHEMA IF NOT EXISTS backups;
CREATE TABLE backups.minds_20251028 AS SELECT * FROM public.minds;
```

**Option 3: Supabase snapshots**
```bash
# Using our script:
./supabase/scripts/db-snapshot.sh v0.8.0
```

### For Testing

Use a **separate database** or **test schema**:

```sql
-- Test schema
CREATE SCHEMA IF NOT EXISTS test;
CREATE TABLE test.minds AS SELECT * FROM public.minds WHERE id < 100;

-- Or use a test database
export TEST_DB_URL="postgresql://...test-db..."
psql "$TEST_DB_URL" -f migration.sql
```

---

## 🛡️ Enforcement

### Automated Detection

Run this script to detect violations:

```bash
./supabase/scripts/detect-versioned-tables.sh
```

**This script checks for:**
- Tables with `_v0_`, `_v1_`, `_v2_`, etc.
- Tables with `_backup`, `_old`, `_copy`
- Any other suspicious naming patterns

### Pre-Commit Hook

Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
# Check for versioned tables before commit
if ./supabase/scripts/detect-versioned-tables.sh; then
    echo "✓ No versioned tables detected"
else
    echo "✗ Versioned tables detected - fix before committing"
    exit 1
fi
```

### CI/CD Check

Add to your CI pipeline:

```yaml
- name: Check for versioned tables
  run: |
    source .env
    ./supabase/scripts/detect-versioned-tables.sh
```

---

## 📋 Checklist for Database Changes

Before creating/modifying tables:

- [ ] Table name is `snake_case`
- [ ] No version suffixes (`_v0_`, `_v1_`, etc.)
- [ ] No backup indicators (`_backup`, `_old`, `_copy`)
- [ ] No date suffixes (`_2025`, `_20251028`)
- [ ] No temporary indicators (`_tmp`, `_temp`)
- [ ] Follows established naming patterns
- [ ] Documented in schema documentation
- [ ] Migration script created (if schema change)
- [ ] Detection script passes

---

## 🚨 If You Find Versioned Tables

**Don't panic. Follow this process:**

### Step 1: Detect
```bash
./supabase/scripts/detect-versioned-tables.sh
```

### Step 2: Investigate
```sql
-- Check if table has data
SELECT COUNT(*) FROM table_name_v0_7_0;

-- Check if it's referenced anywhere
SELECT * FROM pg_constraint
WHERE confrelid = 'table_name_v0_7_0'::regclass;
```

### Step 3: Create Cleanup Migration
```sql
-- supabase/migrations/YYYYMMDD_cleanup_versioned_tables.sql
BEGIN;

-- Drop the versioned tables
DROP TABLE IF EXISTS table_name_v0_7_0 CASCADE;

-- Verify
DO $$
DECLARE
    remaining INTEGER;
BEGIN
    SELECT COUNT(*) INTO remaining
    FROM pg_tables
    WHERE schemaname = 'public' AND tablename LIKE '%_v0_%';

    IF remaining > 0 THEN
        RAISE WARNING 'Still % versioned tables!', remaining;
    END IF;
END $$;

COMMIT;
```

### Step 4: Apply
```bash
psql "$SUPABASE_DB_URL" -f supabase/migrations/YYYYMMDD_cleanup.sql
```

### Step 5: Verify
```bash
./supabase/scripts/detect-versioned-tables.sh
# Should show: ✓ No versioned tables found
```

---

## 📚 Examples

### ✅ Good Schema Evolution

```sql
-- Migration: 20251028_0.8.0_add_collaboration.sql
BEGIN;

-- Add new table
CREATE TABLE mind_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mind_id UUID NOT NULL REFERENCES minds(id),
    user_id UUID NOT NULL REFERENCES auth.users(id),
    role TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Modify existing table
ALTER TABLE minds ADD COLUMN is_shared BOOLEAN DEFAULT false;

COMMIT;
```

### ❌ Bad Schema Evolution

```sql
-- DON'T DO THIS!
CREATE TABLE minds_v0_8_0 AS SELECT * FROM minds;
ALTER TABLE minds_v0_8_0 ADD COLUMN is_shared BOOLEAN;
DROP TABLE minds;
ALTER TABLE minds_v0_8_0 RENAME TO minds;
```

---

## 🎓 Why This Matters

### The Problem (What Happened)

Someone created tables like:
- `audience_profiles_v0_7_0`
- `content_pieces_v0_7_0`
- `content_projects_v0_7_0`

**Impact:**
- Database cluttered with 7 unnecessary tables
- Confusion about which tables are "real"
- Wasted storage space
- Risk of queries using wrong table
- Schema documentation inconsistent

### The Solution (What We Did)

1. ✅ Deleted all 7 versioned tables
2. ✅ Created detection script
3. ✅ Documented naming conventions
4. ✅ Added to safeguards

### The Prevention (What We'll Do)

1. ✅ Run detection script regularly
2. ✅ Add to pre-commit hooks
3. ✅ Review all migrations
4. ✅ Train team on conventions

---

## 🔗 Related Documentation

- **Migration Guide:** `docs/database/MIGRATION-ARCHITECTURE.md`
- **Schema Documentation:** `docs/database/README.md`
- **Detection Script:** `supabase/scripts/detect-versioned-tables.sh`
- **Troubleshooting:** `docs/database/TROUBLESHOOTING.md`

---

**Status:** ✅ Enforced
**Owner:** Database Team
**Review:** Quarterly

