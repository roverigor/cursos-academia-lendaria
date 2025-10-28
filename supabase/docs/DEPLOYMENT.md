# 🚀 Database Deployment Guide

Complete guide for deploying database migrations safely to staging and production.

---

## 📋 Prerequisites

### Required Tools
- [x] psql (PostgreSQL client)
- [x] Supabase CLI (optional, for `supabase link`)
- [x] Git (for tracking changes)

### Required Environment Variables
```bash
# Set your database connection URL
export SUPABASE_DB_URL="postgresql://postgres:[PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres"

# Or use alias in ~/.bashrc:
alias supabase-staging="export SUPABASE_DB_URL='postgresql://...@db.STAGING-REF.supabase.co...'"
alias supabase-prod="export SUPABASE_DB_URL='postgresql://...@db.PROD-REF.supabase.co...'"
```

---

## 🎯 Quick Start

### First-Time Setup (v0.7.0 Baseline)

```bash
# 1. Set database URL (staging first!)
export SUPABASE_DB_URL="postgresql://postgres:[PASS]@db.[STAGING-REF].supabase.co:5432/postgres"

# 2. Apply baseline migration
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql

# 3. Apply seed data
./scripts/db-migrate.sh supabase/migrations/20251026213000_v0_7_0_seed.sql

# 4. Run smoke test (when test file exists)
./scripts/db-test.sh v0.7.0

# 5. Verify manually
psql $SUPABASE_DB_URL
\dt  -- List tables (expect ~30)
\df  -- List functions (expect 4)
SELECT * FROM categories;  -- Should have 5 rows
```

---

## 📊 Deployment Workflow

### Phase 1: Local Testing (Optional)

```bash
# 1. Start local PostgreSQL
docker run --name postgres-local -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres:16

# 2. Set local URL
export SUPABASE_DB_URL="postgresql://postgres:postgres@localhost:5432/postgres"

# 3. Apply migrations
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql
./scripts/db-migrate.sh supabase/migrations/20251026213000_v0_7_0_seed.sql

# 4. Test
./scripts/db-test.sh v0.7.0
```

---

### Phase 2: Staging Deployment

```bash
# 1. Switch to staging
supabase-staging  # Or manually set SUPABASE_DB_URL

# 2. Verify connection
psql $SUPABASE_DB_URL -c "SELECT version();"

# 3. Apply baseline
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql

# OUTPUT:
# 📸 Creating snapshot: schemas/v0_7_0_..._before.sql
# ⏳ Applying migration...
# ✅ Migration applied
# 📸 Creating snapshot: schemas/v0_7_0_..._after.sql
# ✅ Complete!

# 4. Apply seed
./scripts/db-migrate.sh supabase/migrations/20251026213000_v0_7_0_seed.sql

# 5. Run smoke test
./scripts/db-test.sh v0.7.0

# 6. Manual validation
psql $SUPABASE_DB_URL <<EOF
-- Test Magic Link signup (via Supabase UI)
-- Then verify:
SELECT * FROM user_profiles;
SELECT * FROM minds;

-- Test fragment trigger
INSERT INTO sources (mind_id, title, type, published_date, quality)
VALUES (
  (SELECT id FROM minds LIMIT 1),
  'Test Source',
  'article',
  CURRENT_DATE,
  'primary'
);

INSERT INTO fragments (
  source_id, category_id, location, type, relevance,
  content, context, insight
)
SELECT
  (SELECT id FROM sources ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM categories WHERE code='COG'),
  'test',
  'principle',
  7,
  'Test content',
  'Test context',
  'Test insight';

-- Verify mind_id was auto-filled from source
SELECT f.id, f.mind_id AS fragment_mind, s.mind_id AS source_mind
FROM fragments f
JOIN sources s ON s.id = f.source_id
ORDER BY f.created_at DESC LIMIT 1;
-- fragment_mind should equal source_mind ✅
EOF

# 7. Update MIGRATIONS.md
# Add deployment info (date, time, deployed by, test results)
```

---

### Phase 3: Production Deployment

**⚠️ CRITICAL: Only deploy to production after staging validation!**

```bash
# 1. Backup production (extra safety)
pg_dump $PROD_DB_URL > backups/prod_backup_$(date +%Y%m%d_%H%M%S).sql

# 2. Switch to production
supabase-prod  # Or manually set SUPABASE_DB_URL

# 3. Schedule during off-peak hours (2-4 AM UTC recommended)

# 4. Apply migrations (same commands as staging)
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql
./scripts/db-migrate.sh supabase/migrations/20251026213000_v0_7_0_seed.sql

# 5. Run smoke test
./scripts/db-test.sh v0.7.0

# 6. Monitor errors
psql $SUPABASE_DB_URL -c "SELECT COUNT(*) FROM pg_stat_activity WHERE state = 'active';"

# 7. Update MIGRATIONS.md with production deployment info
```

---

## 🔄 Rollback Procedures

### Snapshot Rollback (Recommended)

```bash
# 1. List available snapshots
ls -lht supabase/schemas/ | grep v0_7_0

# 2. Restore snapshot
./scripts/db-rollback.sh v0_7_0

# OUTPUT:
# ⚠️  WARNING: DESTRUCTIVE OPERATION!
# Type 'ROLLBACK' to confirm: ROLLBACK
# 📸 Backing up current state...
# ⏳ Restoring snapshot...
# ✅ Rollback complete!

# 3. Verify
./scripts/db-test.sh v0_7_0
```

### Manual Rollback (Specific Migration)

```bash
# If rollback script exists:
psql $SUPABASE_DB_URL -f supabase/rollback/20251026213000_v0_7_0_seed_rollback.sql

# Or manually:
psql $SUPABASE_DB_URL <<EOF
DELETE FROM categories;
DELETE FROM traits;
DELETE FROM content_frameworks;
EOF
```

---

## 📊 Monitoring & Validation

### Post-Deployment Checks

```bash
# 1. Table count
psql $SUPABASE_DB_URL -c "SELECT COUNT(*) FROM pg_tables WHERE schemaname='public';"
# Expected: ~30

# 2. RLS policies
psql $SUPABASE_DB_URL -c "SELECT COUNT(*) FROM pg_policies WHERE schemaname='public';"
# Expected: ~16

# 3. Functions
psql $SUPABASE_DB_URL -c "SELECT COUNT(*) FROM pg_proc WHERE pronamespace=(SELECT oid FROM pg_namespace WHERE nspname='public');"
# Expected: ~4-5

# 4. Seed data
psql $SUPABASE_DB_URL -c "SELECT COUNT(*) FROM categories;"  # Expected: 5
psql $SUPABASE_DB_URL -c "SELECT COUNT(*) FROM traits;"  # Expected: 5
psql $SUPABASE_DB_URL -c "SELECT COUNT(*) FROM content_frameworks;"  # Expected: 4
```

---

## 🚨 Troubleshooting

### Migration Fails Mid-Execution

**Problem:** Migration script errors out
**Solution:**
```bash
# 1. Check error message
# 2. Restore pre-migration snapshot
ls -lh supabase/schemas/ | grep "_before"
./scripts/db-rollback.sh v0_7_0

# 3. Fix migration file
# 4. Re-run
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql
```

### Snapshot Creation Fails

**Problem:** Disk space exhausted
**Solution:**
```bash
# 1. Check disk space
df -h

# 2. Clean old snapshots
rm supabase/schemas/*_before.sql  # Keep only latest

# 3. Re-run migration
```

### RLS Blocking Operations

**Problem:** `new row violates row-level security policy`
**Solution:**
```bash
# Use service role key (has RLS bypass)
# OR temporarily disable RLS for testing:
psql $SUPABASE_DB_URL -c "ALTER TABLE fragments DISABLE ROW LEVEL SECURITY;"
# Test...
psql $SUPABASE_DB_URL -c "ALTER TABLE fragments ENABLE ROW LEVEL SECURITY;"
```

---

## 📝 Best Practices

### DO:
✅ Test in staging first
✅ Deploy during off-peak hours
✅ Create snapshots before migrations
✅ Update MIGRATIONS.md immediately after deployment
✅ Monitor for 24h after production deployment

### DON'T:
❌ Deploy directly to production
❌ Skip smoke tests
❌ Delete snapshots (disk is cheap, data loss is expensive)
❌ Run migrations during peak hours
❌ Skip manual validation

---

## 🔗 Related Documents

- [MIGRATIONS.md](./MIGRATIONS.md) - Migration history tracker
- [MIGRATION-ARCHITECTURE.md](../../docs/database/MIGRATION-ARCHITECTURE.md) - Architecture design
- [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) - Common issues

---

**Last Updated:** 2025-10-26
**Maintained by:** Database Team
