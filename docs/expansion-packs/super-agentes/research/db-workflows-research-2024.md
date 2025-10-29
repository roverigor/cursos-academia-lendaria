# Database Workflows Research - Industry Best Practices 2024

**Research Date:** 2025-10-27
**Purpose:** Inform user-friendly workflow design for DB Sage expansion pack
**Sources:** Supabase official docs, PostgreSQL community, industry tools (Prisma, Hasura)

---

## Executive Summary

Research into database workflow best practices reveals **7 distinct user-facing workflows** that should be exposed to users, with technical tasks orchestrated behind the scenes. Current DB Sage has 29 technical commands but no structured workflows, making it overwhelming for non-experts.

**Key Finding:** Industry-leading tools (Supabase CLI, Prisma, Hasura) follow a **goal-oriented workflow pattern** rather than exposing low-level commands directly to users.

---

## 1. Database Setup Workflow

### Industry Standard Pattern (Supabase 2024)

**Workflow Steps:**
1. **Initialize** → `supabase init` (creates config.toml, migrations folder)
2. **Link to project** → `supabase link --project-ref $ID`
3. **Pull remote schema** → `supabase db pull` (sync cloud → local)
4. **Start local** → `supabase start` (local dev environment)
5. **Validate** → Check connection, run test query

**Key Best Practices:**
- **Multi-environment strategy:** local → staging → prod
- **Version control first:** All schema changes in git
- **Environment variables:** Store secrets in .env (SUPABASE_ACCESS_TOKEN, SUPABASE_DB_PASSWORD, SUPABASE_PROJECT_ID)
- **Never modify production directly:** Always go through migrations

**Supabase CLI Workflow:**
```bash
# Step 1: Initialize
supabase init

# Step 2: Link
supabase login
supabase link --project-ref <project-id>

# Step 3: Pull existing schema
supabase db pull

# Step 4: Start local dev
supabase start
```

**Common Gotchas:**
- Skipping environment variable setup
- Not pulling remote schema before starting (causes conflicts)
- Missing GitHub CLI auth (breaks CI/CD later)

---

## 2. Expansion Pack Analysis Workflow (KISS Gate)

### Context

Before adding database to an expansion pack (creator-os, mmos, innerlens), must validate if database is actually needed.

**Workflow Steps:**
1. **Reality Check** → Does system work today? (filesystem/API/memory)
2. **Pain Validation** → Ask user explicitly: "What breaks?"
3. **Existing Schema Check** → Can current tables solve the problem?
4. **Minimum Proposal** → 0 changes > 1 field > 1 table > multiple tables
5. **Trade-Offs** → Present filesystem vs database (let user decide)

**Red Flags (Block if ANY):**
- Proposing 3+ tables without explicit user request
- Proposing 10+ fields without validated pain
- Assuming analytics/tracking needed without evidence
- Designing for "future needs" vs current pain
- Not checking existing schema first

**Industry Parallel:** Hasura vs Prisma decision framework
- Hasura: Instant GraphQL (real-time needed, auth built-in)
- Prisma: Type-safe ORM (custom logic, multiple DBs)
- Decision: Based on **validated requirements**, not assumptions

**Output:** KISS validation report + recommendation (keep filesystem OR minimal DB)

---

## 3. Migration Workflow (Local → Cloud)

### Industry Standard Pattern

**Pre-Migration Checklist:**
1. Database size check
2. PostgreSQL version compatibility
3. Installed extensions inventory
4. Active connections audit
5. **Backup verification** (critical)

**Migration Methods (by use case):**

#### Method A: Maintenance Window (Full Control)
```bash
# Step 1: Set source to read-only
ALTER DATABASE mydb SET default_transaction_read_only = on;

# Step 2: Create snapshot
supabase db dump -f backup.sql

# Step 3: Apply migrations
supabase db push

# Step 4: Smoke test
# (run smoke test suite)

# Step 5: Cutover
# (update connection strings)
```

**Duration:** 15-60 minutes downtime
**Best for:** Non-critical apps, dev → staging

#### Method B: Blue/Green Deployment (Zero Downtime)
```bash
# Step 1: Create blue environment (clone)
# Step 2: Apply migrations to blue
# Step 3: Set up logical replication (green → blue)
# Step 4: Validate blue environment
# Step 5: Switch traffic (DNS/load balancer)
# Step 6: Keep green as rollback (24-48h)
```

**Duration:** 0 downtime
**Best for:** Production, critical apps

**Rollback Strategies:**
1. **Transaction Rollback** (within session) → SAVEPOINT
2. **Point-in-Time Recovery (PITR)** (hours/days back) → WAL replay
3. **Blue/Green Failback** (instant) → DNS switch

**Key Best Practices:**
- **Never skip environments:** local → staging → production (always)
- **Run from cloud VM:** Same region as source/target (not local machine)
- **Test before cutover:** Production-level load testing
- **Automate via CI/CD:** GitHub Actions, not manual deploys

---

## 4. Data Import Workflow

### Industry Standard Pattern (CSV/JSON → PostgreSQL)

**Import Methods (by size):**

| File Size | Method | Tool | Speed |
|-----------|--------|------|-------|
| < 50 MB | Table Editor UI | Supabase Dashboard | Slow (manual) |
| 50 MB - 1 GB | CLI COPY command | `supabase db execute` | Fast (scripted) |
| > 1 GB | Direct psql COPY | `psql` with COPY | Fastest (bulk) |

**Production-Grade Import Workflow:**

```sql
-- Step 1: Create staging table (same schema as target)
CREATE TABLE staging_users (LIKE users INCLUDING ALL);

-- Step 2: COPY to staging (fast, no constraints)
COPY staging_users FROM '/path/to/users.csv'
  WITH (FORMAT csv, HEADER true);

-- Step 3: Validate staging data
SELECT
  COUNT(*) as total_rows,
  COUNT(DISTINCT email) as unique_emails,
  COUNT(*) - COUNT(email) as missing_emails
FROM staging_users;

-- Step 4: Merge to production (with deduplication)
BEGIN;
INSERT INTO users
SELECT * FROM staging_users
ON CONFLICT (email) DO UPDATE SET
  name = EXCLUDED.name,
  updated_at = now();
COMMIT;

-- Step 5: Cleanup staging
DROP TABLE staging_users;
```

**Key Best Practices:**
- **Staging → Production pattern:** Never import directly to production tables
- **Validation before merge:** Check counts, nulls, duplicates
- **Idempotent imports:** Use ON CONFLICT to handle re-runs
- **Transaction wrapping:** Rollback on error
- **Timeout handling:** Adjust statement_timeout for large imports

**Automation:**
- Store COPY scripts in `supabase/seeds/` folder
- Version control seed files
- Automate via CI/CD (GitHub Actions)

---

## 5. Security Configuration Workflow (RLS)

### Industry Standard Pattern (Supabase RLS 2024)

**RLS Implementation Workflow:**

```sql
-- Step 1: Enable RLS on table
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Step 2: Create policies (CRUD)
-- SELECT policy (users see own posts)
CREATE POLICY "Users can view own posts"
  ON posts FOR SELECT
  USING (auth.uid() = user_id);

-- INSERT policy
CREATE POLICY "Users can create posts"
  ON posts FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- UPDATE policy
CREATE POLICY "Users can update own posts"
  ON posts FOR UPDATE
  USING (auth.uid() = user_id);

-- DELETE policy
CREATE POLICY "Users can delete own posts"
  ON posts FOR DELETE
  USING (auth.uid() = user_id);

-- Step 3: Test with impersonation
SET request.jwt.claims = '{"sub": "user-id-123"}';
SELECT * FROM posts; -- Should see only user-id-123 posts
```

**Common RLS Patterns:**

#### Pattern 1: User-Based Isolation (Simple)
```sql
-- Every row belongs to one user
USING (auth.uid() = user_id)
```

#### Pattern 2: Team/Multi-Tenant
```sql
-- User must be member of team that owns data
USING (
  auth.uid() IN (
    SELECT user_id FROM team_members
    WHERE team_id = posts.team_id
  )
)
```

#### Pattern 3: Role-Based (Admin + Owner)
```sql
-- Admin sees all, users see own
USING (
  auth.jwt()->>'role' = 'admin'
  OR auth.uid() = user_id
)
```

**Performance Optimization:**
- **Wrap auth.uid() in subquery:** Postgres caches result per-statement
  ```sql
  USING (user_id = (SELECT auth.uid()))
  ```
- **Add explicit filters:** Even if redundant with policy
  ```sql
  SELECT * FROM posts WHERE user_id = auth.uid(); -- Better query plan
  ```

**Key Best Practices:**
- **Store policies in migrations:** `supabase/migrations/*.sql`
- **Test with positive/negative cases:** Allowed + denied scenarios
- **Audit coverage:** All tables with user data should have RLS
- **Service role caution:** Bypasses RLS (use only in admin tools)

**RLS Audit Workflow:**
```sql
-- Find tables without RLS
SELECT tablename FROM pg_tables
WHERE schemaname = 'public'
AND tablename NOT IN (
  SELECT tablename FROM pg_policies
)
AND rowsecurity = false;
```

---

## 6. Performance Optimization Workflow

### Industry Standard Pattern (PostgreSQL 2024)

**Systematic Optimization Workflow:**

**Phase 1: Establish Baseline**
```sql
-- Step 1: Enable pg_stat_statements
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Step 2: Identify slow queries
SELECT
  query,
  calls,
  mean_exec_time,
  total_exec_time,
  stddev_exec_time
FROM pg_stat_statements
WHERE mean_exec_time > 500 -- queries > 500ms
ORDER BY total_exec_time DESC
LIMIT 20;
```

**Phase 2: Analyze Query Plans**
```sql
-- Step 3: Run EXPLAIN ANALYZE
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM posts WHERE user_id = '123';

-- Key metrics to check:
-- - Sequential Scans (bad) vs Index Scans (good)
-- - Actual rows vs Estimated rows (mismatches = bad stats)
-- - Buffers: shared hit (cache) vs read (disk)
```

**Phase 3: Apply Optimizations**

#### Issue 1: Sequential Scan (Missing Index)
```sql
-- Problem: Seq Scan on posts (cost=0.00..1234.56)
-- Solution: Add index
CREATE INDEX idx_posts_user_id ON posts(user_id);
ANALYZE posts; -- Update stats
```

#### Issue 2: Row Count Mismatch (Stale Stats)
```sql
-- Problem: Estimated rows=10, Actual rows=10000
-- Solution: Analyze table
ANALYZE posts;
-- Or automate: Set autovacuum more aggressive
```

#### Issue 3: Buffer Cache Misses (I/O Bound)
```sql
-- Problem: Buffers: shared read=1000 (disk reads)
-- Solution: Increase shared_buffers, or partition table
ALTER SYSTEM SET shared_buffers = '4GB';
```

#### Issue 4: N+1 Queries (Multiple Round Trips)
```sql
-- Problem: 1 query for posts, N queries for comments
-- Solution: Use JOIN or lateral join
SELECT p.*, array_agg(c.*) as comments
FROM posts p
LEFT JOIN comments c ON c.post_id = p.id
GROUP BY p.id;
```

**Phase 4: Validate Improvements**
```bash
# Re-run EXPLAIN ANALYZE
# Compare: Before vs After execution time
# Monitor: pg_stat_statements over 24-48h
```

**Key Best Practices:**
- **Regular VACUUM/ANALYZE:** Weekly for active tables
- **Index maintenance:** Monitor unused indexes (pg_stat_user_indexes)
- **Partitioning:** For tables > 10M rows
- **Connection pooling:** Use Supabase Pooler (6543 port)

**Optimization Priorities:**
1. **IO Inefficiency** (80% of issues) → Indexes, partitioning
2. **CPU Inefficiency** (15%) → Query rewrite, denormalization
3. **Network** (5%) → Connection pooling, batching

---

## 7. Production Deployment Workflow

### Industry Standard Pattern (PostgreSQL Production 2024)

**Pre-Deployment Checklist:**

#### Infrastructure
- [ ] Primary-replica setup (HA)
- [ ] Automated backups enabled (PITR)
- [ ] Monitoring: slow queries, replication lag, disk usage
- [ ] Alerting: PagerDuty/Slack for critical issues
- [ ] Connection pooling configured (pgBouncer/Supabase Pooler)

#### Security
- [ ] RLS enabled on all user-facing tables
- [ ] RLS policies tested (positive + negative cases)
- [ ] Service role usage audited
- [ ] SSL enforced (sslmode=require)
- [ ] IP allowlisting (if applicable)

#### Performance
- [ ] Indexes validated (no missing, no unused)
- [ ] VACUUM/ANALYZE scheduled
- [ ] Query performance baseline established
- [ ] Load testing completed (production-level traffic)

#### Disaster Recovery
- [ ] Backup restoration tested (at least once)
- [ ] Rollback plan documented
- [ ] Blue/green deployment option available
- [ ] Point-in-Time Recovery (PITR) configured

**Deployment Workflow:**

```yaml
# Step 1: Pre-deployment validation
- Run smoke tests on staging
- Run load tests (simulate production traffic)
- Validate all RLS policies
- Check migration safety (no data loss risk)

# Step 2: Create rollback point
- Snapshot current schema (supabase db dump)
- Tag deployment in git (git tag v1.2.3)
- Document rollback procedure

# Step 3: Deploy migration
- Apply migration via CI/CD (GitHub Actions)
- Monitor logs in real-time
- Run smoke tests on production

# Step 4: Post-deployment validation
- Check replication lag (should be < 1s)
- Run query performance checks
- Monitor error rates (should be 0)
- Verify application functionality

# Step 5: Monitor for 24h
- Watch slow query logs
- Monitor disk usage
- Check for error spikes
- Keep rollback option ready
```

**Rollback Triggers (immediate rollback if):**
- Error rate > 1%
- Query performance degraded > 50%
- Replication lag > 10s
- Disk usage spiked unexpectedly
- Application errors related to DB

**Rollback Methods:**

#### Method 1: Transaction Rollback (immediate)
```sql
-- If migration is still in transaction
ROLLBACK;
```

#### Method 2: Revert Migration (< 1 hour)
```bash
# Apply rollback script
supabase db execute -f supabase/migrations/rollback/20241027_revert.sql
```

#### Method 3: PITR (1 hour - 7 days)
```bash
# Restore to point before deployment
# (requires downtime)
```

#### Method 4: Blue/Green Failback (instant)
```bash
# Switch DNS/load balancer back to green
# (zero downtime)
```

**Key Best Practices:**
- **Zero-downtime as goal:** Use blue/green for critical apps
- **Test rollback procedure:** At least once per quarter
- **Automate deployment:** GitHub Actions, not manual
- **Monitor aggressively:** First 24h after deployment
- **Keep old environment:** 24-48h for quick failback

---

## Industry Tool Comparison

### Supabase vs Prisma vs Hasura (Workflow Philosophy)

| Aspect | Supabase | Prisma | Hasura |
|--------|----------|---------|---------|
| **Workflow** | CLI-driven migrations | Schema-first (declarative) | Dashboard-driven (then export) |
| **Target User** | Full-stack devs | Backend devs | Frontend devs (GraphQL) |
| **Learning Curve** | Medium | Low | Low |
| **Production-Ready** | Built-in HA, backups | Requires setup | Built-in HA |
| **RLS** | Native Postgres RLS | Application-level | GraphQL permissions |
| **Real-time** | Built-in (Postgres CDC) | Manual setup | Built-in (subscriptions) |

**Workflow Pattern Insights:**

1. **Supabase:** Multi-environment (local → staging → prod) + Git-based migrations
2. **Prisma:** Schema-first (prisma.schema) → generate migrations → apply
3. **Hasura:** Dashboard-driven (rapid prototyping) → export metadata → CI/CD

**Common Pattern:** All tools follow **Goal-Oriented Workflows** (not command-oriented)

---

## Recommendations for DB Sage

### Current State (Problems)
- ❌ 29 technical commands exposed directly
- ❌ No structured workflows
- ❌ Users don't know where to start
- ❌ Expert knowledge required

### Proposed Structure

**User-Facing Workflows (7):**
1. Setup New Database
2. Analyze Expansion Pack (KISS Gate)
3. Migrate to Supabase
4. Import Data
5. Configure Security (RLS)
6. Optimize Performance
7. Deploy to Production

**Technical Tasks (29):**
- Keep existing, but hide behind workflows
- Expose via `*advanced` menu for experts

**Menu Structure:**
```
*help → Show 7 workflows
*advanced → Show 29 technical commands
```

### Success Criteria
- Non-expert can setup database (< 5 min)
- KISS Gate prevents over-engineering (blocks 90%+ cases)
- Migration workflow has 0 data loss incidents
- Performance workflow improves slow queries (measurable)

---

## Sources

1. **Supabase Official Docs** (2024)
   - Local development: https://supabase.com/docs/guides/local-development/overview
   - Database migrations: https://supabase.com/docs/guides/deployment/database-migrations
   - Row Level Security: https://supabase.com/docs/guides/database/postgres/row-level-security

2. **PostgreSQL Official Docs** (v18)
   - Performance tips: https://www.postgresql.org/docs/current/performance-tips.html
   - EXPLAIN: https://www.postgresql.org/docs/current/sql-explain.html

3. **Industry Tools**
   - Prisma: https://www.prisma.io/docs
   - Hasura: https://hasura.io/docs
   - Comparison: https://hasura.io/blog/hasura-vs-prisma-9ffc7271eda8

4. **Community Best Practices**
   - DEV Community: Supabase workflows, RLS patterns
   - Medium: PostgreSQL optimization, migration strategies
   - Stack Overflow: Production deployment checklists

---

**Next Steps:**
1. Create Epic: "User-Friendly DB Sage Workflows"
2. Create 7 Stories (one per workflow)
3. Implement workflows in `expansion-packs/super-agentes/workflows/`
4. Update db-sage menu to expose workflows (hide technical commands)
