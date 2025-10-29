# 🧠 Migration Plan: Minds (SQLite → Supabase)

**Created:** 2025-10-27
**Author:** DB Sage
**Status:** 📋 PLANNING
**Phase:** Phase 2 - Core Entities

---

## 📊 Current State Analysis

### Legacy SQLite Backup
- **Status:** Archived (read-only reference)
- **Table:** `minds`
- **Total Rows:** 28
- **Active Rows:** 28 (deleted_at IS NULL)
- **Deleted Rows:** 0

### Supabase Database
- **Table:** `minds`
- **Current Rows:** 0 (empty)
- **Ready:** ✅ Schema created (v0.7.0 baseline)

---

## 🔍 Schema Comparison

### SQLite Schema (18+ fields)
```sql
CREATE TABLE minds (
  id INTEGER PRIMARY KEY AUTOINCREMENT,  -- ⚠️ INTEGER
  slug TEXT NOT NULL UNIQUE,              -- ✅ Compatible
  display_name TEXT NOT NULL,             -- ✅ Compatible

  -- SQLite-only fields (will store in JSONB)
  subject_type TEXT,
  category TEXT,
  primary_domain TEXT,
  birth_year INTEGER,
  nationality TEXT,
  known_aliases TEXT,
  status TEXT,
  current_phase TEXT,
  icp_match TEXT,
  quality_grade TEXT,
  completeness REAL,
  confidence_avg REAL,
  total_tokens_used INTEGER,
  total_cost_usd REAL,
  processing_started_at TEXT,
  processing_completed_at TEXT,
  processing_duration_seconds INTEGER,
  pipeline_version TEXT,
  agent_versions TEXT,
  version TEXT,

  -- Metadata
  privacy_level TEXT DEFAULT 'public',    -- ✅ Compatible
  apex_score REAL DEFAULT 0.0,            -- ⚠️ Scale: 0-10 → 0-1
  created_at TEXT,                        -- ⚠️ TEXT → TIMESTAMPTZ
  updated_at TEXT,                        -- ⚠️ TEXT → TIMESTAMPTZ
  created_by TEXT,                        -- ✅ Compatible
  deleted_at TEXT                         -- ❌ Soft delete (filter out)
)
```

### Supabase Schema (10 fields)
```sql
CREATE TABLE minds (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- ⚠️ UUID
  slug TEXT NOT NULL UNIQUE,
  display_name TEXT NOT NULL,
  primary_language CHAR(2),              -- ⚠️ Supabase-only
  short_bio TEXT,                        -- ⚠️ Supabase-only
  privacy_level TEXT NOT NULL DEFAULT 'public',
  apex_score NUMERIC(3,2),               -- ⚠️ 0.00-1.00 scale
  created_by TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
)
```

---

## 🎯 Field Mapping Strategy

| SQLite Field | Supabase Field | Transformation | Notes |
|--------------|----------------|----------------|-------|
| **id** | id | Generate UUID | Create mapping table |
| **slug** | slug | Direct copy | ✅ Unique constraint |
| **display_name** | display_name | Direct copy | ✅ |
| **privacy_level** | privacy_level | Direct copy | ✅ Default 'public' |
| **apex_score** | apex_score | Divide by 10 | 0-10 → 0-1 scale |
| **created_at** | created_at | Parse TEXT → TIMESTAMPTZ | ISO8601 format |
| **updated_at** | updated_at | Parse TEXT → TIMESTAMPTZ | ISO8601 format |
| **created_by** | created_by | Direct copy | ✅ |
| **subject_type** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **category** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **primary_domain** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **birth_year** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **nationality** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **known_aliases** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **status** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **current_phase** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **quality_grade** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **completeness** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **confidence_avg** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **pipeline_version** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **agent_versions** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **version** | (mmos_metadata) | Store in JSONB | SQLite-only |
| **deleted_at** | ❌ SKIP | Filter WHERE IS NULL | Soft deletes not migrated |
| ❌ | **primary_language** | Default 'pt' | Supabase-only (assume Portuguese) |
| ❌ | **short_bio** | NULL | Supabase-only (can fill later) |

---

## 🛠️ Migration Strategy: Hybrid with JSONB Extension

### Step 1: Extend Supabase Schema

Add `mmos_metadata` column to store SQLite-specific fields:

```sql
-- Add JSONB column for MMOS-specific metadata
ALTER TABLE minds
ADD COLUMN IF NOT EXISTS mmos_metadata JSONB DEFAULT '{}'::jsonb;

-- Add index for JSONB queries
CREATE INDEX IF NOT EXISTS idx_minds_mmos_metadata
ON minds USING GIN (mmos_metadata);

-- Add comment
COMMENT ON COLUMN minds.mmos_metadata IS
'MMOS-specific metadata: category, quality_grade, completeness, pipeline_version, etc.';
```

### Step 2: Create UUID Mapping Table

Track INTEGER id → UUID id mapping:

```sql
-- Create mapping table
CREATE TABLE IF NOT EXISTS mmos_id_mapping (
  entity_type TEXT NOT NULL,           -- 'mind', 'source', 'fragment'
  sqlite_id INTEGER NOT NULL,          -- Original SQLite id
  supabase_uuid UUID NOT NULL,         -- Generated Supabase UUID
  migrated_at TIMESTAMPTZ DEFAULT now(),
  PRIMARY KEY (entity_type, sqlite_id)
);

CREATE INDEX idx_mmos_mapping_uuid ON mmos_id_mapping(supabase_uuid);

COMMENT ON TABLE mmos_id_mapping IS
'Mapping table for SQLite INTEGER PKs to Supabase UUIDs (used for migration)';
```

### Step 3: Export Supabase Data (reference snapshot)

```bash
# Export current minds table to CSV (requires SUPABASE_DB_URL)
psql "$SUPABASE_DB_URL" -c "COPY minds TO STDOUT WITH CSV HEADER" \
  > supabase/data/minds_export_$(date +%Y%m%d).csv

echo "✅ Exported minds snapshot to supabase/data/minds_export_$(date +%Y%m%d).csv"
```

### Step 4: Migration SQL Script

```sql
-- ================================================================
-- Migration: SQLite Minds → Supabase
-- Phase 2: Core Entities
-- ================================================================

BEGIN;

-- Load CSV data into temporary table
CREATE TEMP TABLE temp_sqlite_minds (
  sqlite_id INTEGER,
  slug TEXT,
  display_name TEXT,
  subject_type TEXT,
  privacy_level TEXT,
  category TEXT,
  primary_domain TEXT,
  birth_year INTEGER,
  nationality TEXT,
  known_aliases TEXT,
  status TEXT,
  current_phase TEXT,
  apex_score NUMERIC,
  quality_grade TEXT,
  completeness NUMERIC,
  confidence_avg NUMERIC,
  total_tokens_used INTEGER,
  total_cost_usd NUMERIC,
  processing_started_at TEXT,
  processing_completed_at TEXT,
  processing_duration_seconds INTEGER,
  pipeline_version TEXT,
  agent_versions TEXT,
  version TEXT,
  created_at TEXT,
  updated_at TEXT,
  created_by TEXT
);

-- Copy CSV data
\COPY temp_sqlite_minds FROM 'data/sqlite_minds_export.csv' WITH (FORMAT csv, HEADER true);

-- Verify import
DO $$
DECLARE
  imported_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO imported_count FROM temp_sqlite_minds;
  RAISE NOTICE '✅ Imported % rows into temp table', imported_count;
END $$;

-- Insert into minds with UUID generation
INSERT INTO minds (
  id,
  slug,
  display_name,
  primary_language,
  short_bio,
  privacy_level,
  apex_score,
  created_by,
  created_at,
  updated_at,
  mmos_metadata
)
SELECT
  gen_random_uuid(),                    -- Generate new UUID
  slug,
  display_name,
  'pt'::CHAR(2),                        -- Default: Portuguese
  NULL,                                 -- No bio yet
  COALESCE(privacy_level, 'public'),
  CASE
    WHEN apex_score IS NOT NULL THEN (apex_score / 10.0)::NUMERIC(3,2)
    ELSE 0.00
  END,                                  -- Scale: 0-10 → 0-1
  created_by,
  COALESCE(created_at::TIMESTAMPTZ, now()),
  COALESCE(updated_at::TIMESTAMPTZ, now()),
  jsonb_build_object(
    'subject_type', subject_type,
    'category', category,
    'primary_domain', primary_domain,
    'birth_year', birth_year,
    'nationality', nationality,
    'known_aliases', known_aliases,
    'status', status,
    'current_phase', current_phase,
    'quality_grade', quality_grade,
    'completeness', completeness,
    'confidence_avg', confidence_avg,
    'total_tokens_used', total_tokens_used,
    'total_cost_usd', total_cost_usd,
    'processing_started_at', processing_started_at,
    'processing_completed_at', processing_completed_at,
    'processing_duration_seconds', processing_duration_seconds,
    'pipeline_version', pipeline_version,
    'agent_versions', agent_versions,
    'version', version
  )                                     -- Store SQLite-only fields
FROM temp_sqlite_minds
ON CONFLICT (slug) DO NOTHING;          -- Skip if slug exists

-- Store UUID mappings
INSERT INTO mmos_id_mapping (entity_type, sqlite_id, supabase_uuid)
SELECT
  'mind',
  t.sqlite_id,
  m.id
FROM temp_sqlite_minds t
JOIN minds m ON m.slug = t.slug;

-- Verify migration
DO $$
DECLARE
  migrated_count INTEGER;
  mapping_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO migrated_count FROM minds;
  SELECT COUNT(*) INTO mapping_count FROM mmos_id_mapping WHERE entity_type = 'mind';

  RAISE NOTICE '✅ Migrated % minds to Supabase', migrated_count;
  RAISE NOTICE '✅ Created % UUID mappings', mapping_count;

  IF migrated_count != mapping_count THEN
    RAISE WARNING '⚠️ Count mismatch: minds=%, mappings=%', migrated_count, mapping_count;
  END IF;
END $$;

-- Cleanup
DROP TABLE temp_sqlite_minds;

COMMIT;
```

---

## ✅ Validation Queries

### 1. Count Validation
```sql
-- Expect: 28 minds in Supabase
SELECT COUNT(*) as total_minds FROM minds;

-- Expect: 28 mappings
SELECT COUNT(*) as total_mappings
FROM mmos_id_mapping
WHERE entity_type = 'mind';
```

### 2. Data Integrity Checks
```sql
-- Check all slugs migrated
SELECT
  'SQLite' as source,
  COUNT(DISTINCT slug) as unique_slugs
FROM temp_export
UNION ALL
SELECT
  'Supabase' as source,
  COUNT(DISTINCT slug) as unique_slugs
FROM minds;

-- Check apex_score scaling
SELECT
  slug,
  mmos_metadata->>'apex_score_original' as sqlite_score,
  apex_score as supabase_score,
  (apex_score * 10)::NUMERIC(3,1) as converted_back
FROM minds
WHERE apex_score > 0
LIMIT 5;

-- Check JSONB metadata stored
SELECT
  slug,
  mmos_metadata ? 'category' as has_category,
  mmos_metadata ? 'status' as has_status,
  mmos_metadata ? 'pipeline_version' as has_pipeline_version
FROM minds
LIMIT 5;
```

### 3. UUID Mapping Validation
```sql
-- Check mapping coverage
SELECT
  m.slug,
  map.sqlite_id,
  map.supabase_uuid,
  m.id as minds_uuid,
  map.supabase_uuid = m.id as uuid_matches
FROM mmos_id_mapping map
JOIN minds m ON m.slug = (
  SELECT slug FROM temp_export WHERE id = map.sqlite_id
)
WHERE map.entity_type = 'mind'
LIMIT 10;
```

---

## 🔄 Rollback Script

```sql
-- ================================================================
-- Rollback: Delete migrated minds
-- ================================================================

BEGIN;

-- Backup count
SELECT COUNT(*) as minds_before_rollback FROM minds;

-- Delete UUID mappings
DELETE FROM mmos_id_mapping WHERE entity_type = 'mind';

-- Delete minds (cascade will handle relationships)
DELETE FROM minds WHERE id IN (
  SELECT supabase_uuid
  FROM mmos_id_mapping
  WHERE entity_type = 'mind'
);

-- Verify rollback
SELECT COUNT(*) as minds_after_rollback FROM minds;
SELECT COUNT(*) as mappings_remaining FROM mmos_id_mapping WHERE entity_type = 'mind';

COMMIT;
```

---

## 📋 Execution Checklist

### Pre-Migration
- [ ] ✅ Source .env to load SUPABASE_DB_URL
- [ ] ✅ Test Supabase connection (`psql "$SUPABASE_DB_URL" -c "SELECT 1;"`)
- [ ] ✅ Create snapshot: `*snapshot pre_minds_migration_$(date +%Y%m%d)`
- [ ] ✅ Verify SQLite has 28 active minds
- [ ] ✅ Verify Supabase minds table is empty (0 rows)

### Migration Steps
1. [ ] Add `mmos_metadata` column to Supabase `minds` table
2. [ ] Create `mmos_id_mapping` table in Supabase
3. [ ] Export SQLite data to CSV
4. [ ] Review CSV data (spot check)
5. [ ] Run migration SQL script
6. [ ] Run validation queries
7. [ ] Check for errors in PostgreSQL logs

### Post-Migration
- [ ] Validate counts match (SQLite 28 = Supabase 28)
- [ ] Spot check 5 random minds
- [ ] Verify UUID mappings created
- [ ] Test JSONB metadata queries
- [ ] Run smoke test: `*smoke-test v0_8_0`
- [ ] Create post-migration snapshot

### Rollback (if needed)
- [ ] Run rollback script
- [ ] Restore pre-migration snapshot
- [ ] Verify Supabase back to 0 minds
- [ ] Document issue and fix

---

## ⏱️ Estimated Timeline

| Step | Duration | Risk |
|------|----------|------|
| Schema extension (mmos_metadata) | 5 min | 🟢 Low |
| Create mapping table | 5 min | 🟢 Low |
| Export CSV | 2 min | 🟢 Low |
| Review CSV | 5 min | 🟢 Low |
| Run migration SQL | 10 min | 🟡 Medium |
| Validation | 10 min | 🟢 Low |
| Smoke tests | 5 min | 🟢 Low |
| **Total** | **~45 min** | **🟢 Low-Medium** |

---

## 🚨 Known Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| UUID generation fails | 🔴 High | Use gen_random_uuid() (built-in) |
| Timestamp parsing fails | 🟡 Medium | Use COALESCE(parse, now()) |
| apex_score scale error | 🟡 Medium | Validate in test query first |
| JSONB size limit | 🟢 Low | MMOS metadata ~2KB per mind (well under 1MB limit) |
| Duplicate slugs | 🟢 Low | ON CONFLICT DO NOTHING |

---

## 📊 Success Criteria

✅ **Migration is successful when:**
1. Supabase has exactly 28 minds
2. All 28 slugs match SQLite
3. All 28 UUID mappings created
4. apex_score scaled correctly (spot check 5 minds)
5. mmos_metadata JSONB populated for all minds
6. No errors in PostgreSQL logs
7. Smoke tests pass

---

## 🎯 Next Phase

After successful minds migration:
- **Phase 2b:** Migrate `sources` (39 rows)
- **Phase 3:** Migrate `fragments` (74 rows) - High complexity

---

**Ready to execute?** Type `*execute-plan` or review sections for adjustments.

---

*🗄️ DB Sage - "Snapshot before change, validate after commit"*
