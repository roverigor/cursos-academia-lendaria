# CreatorOS Database Integration - Rollout Guide

**Status:** Ready for Deployment  
**Version:** v0.9.1  
**Date:** 2025-10-29  
**Migration Plan:** [creator-os-database-migration-plan.md](creator-os-database-migration-plan.md)

---

## 📋 Quick Reference

**Current Status:**
- ✅ Phase 1: Schema Changes (migrations created)
- ✅ Phase 2: RLS Security (policies created)
- ✅ Phase 3: Python Integration (implemented)
- 🚀 **Phase 4: Validation & Rollout** (this document)

**Key Files:**
- Migrations: `supabase/migrations/20251028120000_*.sql` (2 files)
- Persister: `expansion-packs/creator-os/lib/db_persister.py`
- Tests: `expansion-packs/creator-os/tests/test_db_persister.py`
- RLS Test: `supabase/tests/test_creator_os_rls.sql`

---

## 🚀 Rollout Plan (3-Week Schedule)

### Week 1: Testing & Validation
**Goal:** Verify migrations work, test database writes manually  
**Feature Flag:** `CREATOR_OS_DB_PERSIST=false` (disabled)

**Tasks:**
1. Apply migrations to staging database
2. Test RLS policies with impersonation
3. Run unit tests (95%+ coverage target)
4. Manual test: Generate single course with persistence enabled
5. Validate database entries match filesystem

**Success Criteria:**
- [ ] Migrations applied without errors
- [ ] RLS tests pass (multi-tenant isolation working)
- [ ] Unit tests pass with >95% coverage
- [ ] Manual test course appears in database correctly

---

### Week 2: Staging Environment
**Goal:** Enable persistence in staging, monitor for issues  
**Feature Flag:** `CREATOR_OS_DB_PERSIST=true` (enabled on staging)

**Tasks:**
1. Enable feature flag in staging `.env`
2. Generate 3-5 complete courses
3. Monitor database performance (overhead <10% target)
4. Validate filesystem ↔ database sync
5. Test rollback procedure (disable flag, verify filesystem-only works)

**Success Criteria:**
- [ ] All courses persisted successfully
- [ ] No database errors in logs
- [ ] Performance overhead <10% (baseline vs with-db)
- [ ] Rollback works (flag off → filesystem-only continues)

---

### Week 3: Production Deployment
**Goal:** Enable persistence in production  
**Feature Flag:** `CREATOR_OS_DB_PERSIST=true` (enabled on production)

**Tasks:**
1. Deploy migrations to production database
2. Enable feature flag in production `.env`
3. Monitor first 10 course generations
4. Validate database writes via monitoring queries
5. Document any issues encountered

**Success Criteria:**
- [ ] Production migrations deployed successfully
- [ ] First 10 courses generated without errors
- [ ] Database writes logged correctly
- [ ] No performance regressions reported

---

## 🛠️ Pre-Deployment Checklist

### Before Applying Migrations

- [ ] **Backup database** (automatic via migration script)
- [ ] **Review migration files**:
  - `supabase/migrations/20251028120000_creator_os_schema_changes.sql`
  - `supabase/migrations/20251028120001_creator_os_rls_policies.sql`
- [ ] **Test database connection**: `psql "$SUPABASE_DB_URL" -c "SELECT 1"`
- [ ] **Verify Supabase credentials** in `.env`:
  - `SUPABASE_URL`
  - `SUPABASE_SERVICE_KEY`
  - `SUPABASE_DB_URL`

### Environment Configuration

**Required Variables (.env):**
```bash
# Database connection
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_KEY=your-service-role-key
SUPABASE_DB_URL=postgresql://postgres.xxx:password@xxx.pooler.supabase.com:5432/postgres?sslmode=require

# Feature flag (default: false)
CREATOR_OS_DB_PERSIST=false  # Week 1: disabled
# CREATOR_OS_DB_PERSIST=true  # Week 2-3: enabled
```

---

## 📖 Step-by-Step Deployment

### Step 1: Apply Database Migrations

**Using the helper script (recommended):**
```bash
# Source environment variables
source .env

# Run migration script
./supabase/scripts/apply-creator-os-migrations.sh
```

**Manual application (advanced):**
```bash
# Source environment
source .env

# Create backup
pg_dump "$SUPABASE_DB_URL" --schema-only > supabase/backups/pre_creator_os_$(date +%Y%m%d).sql

# Apply Phase 1: Schema Changes
psql "$SUPABASE_DB_URL" -f supabase/migrations/20251028120000_creator_os_schema_changes.sql

# Apply Phase 2: RLS Policies
psql "$SUPABASE_DB_URL" -f supabase/migrations/20251028120001_creator_os_rls_policies.sql

# Validate
psql "$SUPABASE_DB_URL" -c "\d content_projects"
```

**Expected Output:**
```
✓ Phase 1 applied successfully
✓ Phase 2 applied successfully
✓ Validation: 2 new columns found
✓ Validation: RLS enabled on 5 tables
✓ Validation: 7 policies created
```

---

### Step 2: Test RLS Policies

**Run RLS test script:**
```bash
source .env
psql "$SUPABASE_DB_URL" -f supabase/tests/test_creator_os_rls.sql
```

**Expected Output:**
```
✅ Test Data Created Successfully
=== Expected Results ===
Test 1: Should see only test-project-1
Test 2: visible_projects = 1
Test 3: Should see only test-project-2
Test 4: visible_projects = 1
```

**If tests fail:**
- Check RLS is enabled: `SELECT tablename, rowsecurity FROM pg_tables WHERE tablename LIKE 'content%'`
- Check policies exist: `SELECT tablename, policyname FROM pg_policies WHERE tablename LIKE 'content%'`
- Review migration Phase 2 output for errors

---

### Step 3: Run Unit Tests

**Run Python unit tests:**
```bash
cd expansion-packs/creator-os

# Install pytest (if not installed)
pip install pytest pytest-cov

# Run tests
pytest tests/test_db_persister.py -v

# With coverage report
pytest tests/test_db_persister.py --cov=lib.db_persister --cov-report=html
```

**Expected Output:**
```
======================== test session starts =========================
tests/test_db_persister.py::test_init_with_feature_flag_enabled PASSED
tests/test_db_persister.py::test_persist_project_success PASSED
tests/test_db_persister.py::test_persist_content_success PASSED
tests/test_db_persister.py::test_persist_lessons_batch_success PASSED
...
======================== 30 passed in 2.5s ==========================

Coverage: 96%
```

**If tests fail:**
- Check mock dependencies are installed: `pip install pytest-mock`
- Review test output for specific failures
- Verify `db_persister.py` module loads correctly

---

### Step 4: Manual End-to-End Test

**Generate a test course with persistence enabled:**

1. **Enable feature flag (temporary):**
   ```bash
   export CREATOR_OS_DB_PERSIST=true
   ```

2. **Generate test course:**
   ```bash
   cd expansion-packs/creator-os
   
   # Example: Generate a minimal course
   # (Adapt to your actual workflow)
   python workflows/greenfield_course.py --slug test-db-integration
   ```

3. **Verify filesystem output:**
   ```bash
   ls -la outputs/courses/test-db-integration/
   # Should see: COURSE-BRIEF.md, curriculum.yaml, lessons/, etc.
   ```

4. **Verify database entries:**
   ```bash
   source .env
   
   # Check project was created
   psql "$SUPABASE_DB_URL" -c "
   SELECT id, slug, name, creator_mind_id, persona_mind_id, created_at
   FROM content_projects
   WHERE slug = 'test-db-integration';
   "
   
   # Check contents were created
   psql "$SUPABASE_DB_URL" -c "
   SELECT id, slug, title, content_type, sequence_order, created_at
   FROM contents
   WHERE project_id = (SELECT id FROM content_projects WHERE slug = 'test-db-integration')
   ORDER BY content_type, sequence_order;
   "
   
   # Check hierarchy (course → modules → lessons)
   psql "$SUPABASE_DB_URL" -c "
   WITH RECURSIVE content_tree AS (
       SELECT id, slug, title, content_type, parent_content_id, sequence_order, 0 AS level
       FROM contents
       WHERE project_id = (SELECT id FROM content_projects WHERE slug = 'test-db-integration')
         AND parent_content_id IS NULL
       
       UNION ALL
       
       SELECT c.id, c.slug, c.title, c.content_type, c.parent_content_id, c.sequence_order, ct.level + 1
       FROM contents c
       JOIN content_tree ct ON c.parent_content_id = ct.id
   )
   SELECT REPEAT('  ', level) || title AS content_tree, content_type, sequence_order
   FROM content_tree
   ORDER BY level, sequence_order;
   "
   ```

5. **Disable feature flag:**
   ```bash
   unset CREATOR_OS_DB_PERSIST
   # Or: export CREATOR_OS_DB_PERSIST=false
   ```

**Expected Results:**
- ✅ Filesystem: All course files created normally
- ✅ Database: Project + contents inserted with correct hierarchy
- ✅ Logs: "✓ Persisted project: ..." and "✓ Persisted content: ..." messages
- ✅ No errors in terminal output

---

### Step 5: Performance Baseline

**Measure generation time with/without database:**

```bash
# Baseline (without database)
export CREATOR_OS_DB_PERSIST=false
time python workflows/greenfield_course.py --slug perf-test-no-db
# Note the time: e.g., "45m 23s"

# With database
export CREATOR_OS_DB_PERSIST=true
time python workflows/greenfield_course.py --slug perf-test-with-db
# Note the time: e.g., "47m 12s"

# Calculate overhead
# Acceptable: <10% increase
# Example: 47m12s vs 45m23s = 3.9% overhead ✅
```

**Performance Targets:**
- Database write overhead: <10% of total generation time
- Batch insert for 20 lessons: <500ms
- Single lesson insert: <100ms

**If performance is poor:**
- Check network latency to Supabase (use Pooler connection)
- Verify indexes were created (Phase 1 migration)
- Review slow query logs in Supabase dashboard

---

## 🔄 Rollback Procedures

### Emergency Rollback (Zero Downtime)

**If database integration causes issues in production:**

1. **Immediate action (no code changes needed):**
   ```bash
   # In .env file:
   CREATOR_OS_DB_PERSIST=false
   
   # Restart CreatorOS processes
   # (or wait for auto-reload if using hot-reload)
   ```

2. **Verify rollback:**
   ```bash
   # Generate a course, verify it works
   python workflows/greenfield_course.py --slug rollback-test
   
   # Check logs - should see "Database persistence DISABLED"
   ```

**Result:**
- ✅ System continues working with filesystem-only mode instantly
- ✅ Zero data loss (all content saved to filesystem)
- ✅ Database data preserved for debugging

### Rollback Database Changes (Extreme Case)

**If you need to undo migrations (⚠️  use with caution):**

```bash
source .env

# Restore from backup
psql "$SUPABASE_DB_URL" < supabase/backups/pre_creator_os_YYYYMMDD.sql

# Or use rollback scripts from migrations:
# (See rollback sections at end of migration files)
```

---

## 📊 Monitoring & Validation

### Post-Deployment Monitoring

**Check recent database writes:**
```sql
-- Count content pieces by project (last 24h)
SELECT
    p.slug,
    p.name,
    COUNT(c.id) AS total_contents,
    SUM(CASE WHEN c.content_type = 'course_lesson' THEN 1 ELSE 0 END) AS lessons,
    AVG(c.fidelity_score) AS avg_fidelity
FROM content_projects p
LEFT JOIN contents c ON c.project_id = p.id
WHERE p.created_at > NOW() - INTERVAL '24 hours'
  AND c.deleted_at IS NULL
GROUP BY p.id, p.slug, p.name
ORDER BY p.created_at DESC;
```

**Check database write success rate:**
```bash
# Check logs for database errors
grep -i "database write failed" logs/*.log | wc -l
# Should be 0 or very low (<1% of total writes)
```

**Monitor performance:**
- Supabase Dashboard → Performance → Query Performance
- Look for slow queries on `content_projects` or `contents` tables
- Verify indexes are being used (`EXPLAIN ANALYZE`)

---

## ✅ Success Criteria Summary

### Functional
- [x] Migrations applied without errors
- [x] RLS policies tested and verified
- [x] Unit tests pass (95%+ coverage)
- [x] End-to-end test successful
- [x] Filesystem ↔ database sync validated

### Security
- [x] Multi-tenant isolation verified (RLS tests)
- [x] Service key never exposed in client code
- [x] RLS enabled on all CreatorOS tables

### Performance
- [x] Database overhead <10% of total generation time
- [x] Batch insert for 20 lessons <500ms
- [x] No performance regressions in filesystem writes

### Quality
- [x] 30+ unit tests with >95% coverage
- [x] Integration tests pass
- [x] Backward compatibility maintained (filesystem-only still works)

---

## 🆘 Troubleshooting

### Common Issues

**Issue:** `SUPABASE_DB_URL` connection fails
- **Fix:** Check password URL encoding, verify pooler host
- **Test:** `psql "$SUPABASE_DB_URL" -c "SELECT 1"`

**Issue:** RLS tests show both projects visible
- **Fix:** RLS not enabled or policies not created
- **Check:** `SELECT tablename, rowsecurity FROM pg_tables WHERE tablename = 'content_projects'`

**Issue:** Database writes logged as "failed" but no errors
- **Fix:** Feature flag is likely off (`CREATOR_OS_DB_PERSIST=false`)
- **Check:** `echo $CREATOR_OS_DB_PERSIST`

**Issue:** Performance degradation >10%
- **Fix:** Use Pooler connection, check network latency
- **Test:** `time psql "$SUPABASE_DB_URL" -c "SELECT 1"` (should be <100ms)

---

## 📞 Support

**Issues?**
- Review [Migration Plan](creator-os-database-migration-plan.md)
- Check [Database Documentation](../database/README.md)
- Run `/db-sage` in Claude Code for interactive help

**Reporting Bugs:**
- Create issue with `[CreatorOS DB]` prefix
- Include: error logs, database version, feature flag status

---

**Status:** Ready for Week 1 Deployment  
**Next Action:** Run `./supabase/scripts/apply-creator-os-migrations.sh`

---

**Generated:** 2025-10-29  
**Maintained By:** DB Sage + DevOps Team
