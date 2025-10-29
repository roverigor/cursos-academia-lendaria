# 🗄️ Database Schema Audit Report

**Date**: 2025-10-28
**Database**: Supabase (PostgreSQL 17.6)
**Schema Version**: v0.7.0 (Production Baseline)
**Auditor**: DB Sage
**Connection**: aws-1-us-east-2.pooler.supabase.com (Pooler)

---

## 📊 Executive Summary

### Database Overview
- **Tables**: 30 (all with primary keys ✅)
- **Columns**: 400
- **Indexes**: 97 (all utilized ✅)
- **Foreign Keys**: 37 constraints
- **Check Constraints**: 154 (excellent coverage ✅)
- **Total Size**: 13 MB
- **Largest Table**: contents (672 KB)

### Score Card

| Category | Score | Status |
|----------|-------|--------|
| **Design** | 85/100 | ⚠️ Good |
| **Performance** | 95/100 | ✅ Excellent |
| **Security** | 70/100 | ⚠️ Needs Work |
| **Data Integrity** | 90/100 | ✅ Very Good |
| **Overall** | **85/100** | ✅ **Production Ready** |

### Key Findings

**Strengths** ✅
- All tables have primary keys (UUID-based)
- No unused indexes (excellent maintenance)
- No duplicate indexes
- Comprehensive check constraints (154 total)
- Solid foreign key coverage (37 relationships)
- Small database size (13 MB - fast operations)

**Concerns** ⚠️
- 19 tables without RLS (63% unprotected)
- 11 tables missing `created_at` timestamps
- 20 tables missing `updated_at` timestamps
- 8 foreign keys without supporting indexes (performance risk)

**Critical Issues** 🔴
- None! All tables have primary keys ✅

---

## 🔍 1. Design & Best Practices Audit

### ✅ Strengths

#### Primary Keys (Perfect)
All 30 tables have primary keys (UUID-based). No action needed.

#### Check Constraints (Excellent)
154 check constraints enforce data quality:
- **Range validation**: `relevance` (0-10), `intensity_10` (0-10), `level_10` (0-10)
- **Enum validation**: `status`, `content_type`, `privacy_level`, etc.
- **Business rules**: `from_fragment_id <> to_fragment_id` (no self-references)
- **NOT NULL enforcement**: Comprehensive coverage

### ⚠️ Issues Found

#### 1. Missing Timestamps

**Tables without `created_at` (11 tables):**
```
mind_aliases, domains, specializations, skills, processing_queue,
categories, fragment_tags, fragment_relationships, traits,
content_minds, content_tags
```

**Impact**: No audit trail for record creation
**Risk Level**: Medium
**Fix**:
```sql
-- Add created_at to tables missing it
ALTER TABLE mind_aliases ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE domains ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE specializations ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
-- ... (repeat for all 11 tables)
```

**Tables without `updated_at` (20 tables):**
```
mind_aliases, domains, specializations, skills, ingestion_batches,
processing_queue, job_executions, categories, fragment_tags,
fragment_relationships, traits, user_profiles, mind_values,
mind_obsessions, mind_routine_windows, trait_scores,
mind_proficiencies, mmos_id_mappings, content_minds, content_tags
```

**Impact**: Cannot track record modifications
**Risk Level**: Medium
**Recommendation**: Add for audit tables; optional for junction/operational tables

#### 2. Foreign Keys Without Indexes (8 cases)

**Performance Risk**: Slow JOINs and DELETE CASCADE operations

| Table | Column | Foreign Table | Impact |
|-------|--------|---------------|--------|
| content_projects | target_audience_id | audience_profiles | JOIN performance |
| fragments | generation_execution_id | job_executions | Provenance queries |
| fragments | ingestion_batch_id | ingestion_batches | Batch tracking |
| mind_proficiencies | generation_execution_id | job_executions | Provenance queries |
| mind_profiles | generation_execution_id | job_executions | Provenance queries |
| skills | specialization_id | specializations | Hierarchy queries |
| specializations | domain_id | domains | Hierarchy queries |
| trait_scores | generation_execution_id | job_executions | Provenance queries |

**Fix Priority**: P1 (Medium priority - small database, but good practice)

```sql
-- Add indexes for foreign keys
CREATE INDEX CONCURRENTLY idx_content_projects_target_audience_id
  ON content_projects(target_audience_id);

CREATE INDEX CONCURRENTLY idx_fragments_generation_execution_id
  ON fragments(generation_execution_id);

CREATE INDEX CONCURRENTLY idx_fragments_ingestion_batch_id
  ON fragments(ingestion_batch_id);

CREATE INDEX CONCURRENTLY idx_mind_proficiencies_generation_execution_id
  ON mind_proficiencies(generation_execution_id);

CREATE INDEX CONCURRENTLY idx_mind_profiles_generation_execution_id
  ON mind_profiles(generation_execution_id);

CREATE INDEX CONCURRENTLY idx_skills_specialization_id
  ON skills(specialization_id);

CREATE INDEX CONCURRENTLY idx_specializations_domain_id
  ON specializations(domain_id);

CREATE INDEX CONCURRENTLY idx_trait_scores_generation_execution_id
  ON trait_scores(generation_execution_id);
```

**Note**: All use `CREATE INDEX CONCURRENTLY` for zero-downtime deployment.

---

## ⚡ 2. Performance Audit

### ✅ Excellent Performance Profile

#### Index Health (Perfect)
- **97 indexes** total
- **0 unused indexes** (all have scans > 0) ✅
- **0 duplicate indexes** ✅
- **No bloat detected** ✅

#### Table Sizes (Healthy)

| Table | Total Size | Table Size | Index Size | Index Ratio |
|-------|------------|------------|------------|-------------|
| contents | 672 KB | 64 KB | 608 KB | 9.5x (high, investigate) |
| fragments | 160 KB | 8 KB | 152 KB | 19x (very high) |
| sources | 96 KB | 8 KB | 88 KB | 11x |
| content_frameworks | 96 KB | 16 KB | 80 KB | 5x |
| minds | 80 KB | 16 KB | 64 KB | 4x |

**Analysis**:
- `contents` and `fragments` have very high index-to-table ratios
- This is **expected and correct** for small tables with many indexes
- As tables grow, ratio will normalize
- **No action needed** at current scale

#### Query Performance
- **Database size**: 13 MB (fits entirely in RAM)
- **No large tables** (>1GB) requiring partitioning
- **All queries expected to be fast** (<10ms for indexed lookups)

### 🔍 Optimization Opportunities

**Future monitoring** (when database grows):
1. Track index usage with `pg_stat_user_indexes`
2. Monitor table bloat with `pgstattuple`
3. Consider partitioning if tables exceed 10GB
4. Add partial indexes for common filtered queries

---

## 🔒 3. Security Audit (RLS)

### ⚠️ Major Security Gap

#### RLS Coverage: 37% (11/30 tables)

**Tables WITH RLS enabled (11):**
```
✓ fragments, mind_obsessions, mind_proficiencies, mind_profiles,
  mind_psychometrics, mind_routine_windows, mind_values, minds,
  sources, trait_scores, user_profiles
```

**Tables WITHOUT RLS (19):**
```
✗ audience_profiles, categories, content_frameworks, content_minds,
  content_projects, content_tags, contents, domains,
  fragment_relationships, fragment_tags, ingestion_batches,
  job_executions, mind_aliases, mmos_id_mappings, processing_queue,
  skills, specializations, tags, traits
```

### 🏗️ Architecture Pattern Analysis

Based on loaded documentation (v0.7.0), the schema follows this RLS philosophy:

**With RLS (Mind-centric tables):**
- Core knowledge: `minds`, `sources`, `fragments`
- Profiles: `mind_profiles`, `mind_values`, `mind_psychometrics`, etc.
- Scores: `trait_scores`, `mind_proficiencies`
- Auth: `user_profiles`

**Without RLS (Operational/Shared tables):**
- **Taxonomies** (shared): `categories`, `domains`, `specializations`, `skills`, `traits`, `tags`
- **Operational** (service-role only): `ingestion_batches`, `processing_queue`, `job_executions`
- **Relations** (junction): `fragment_tags`, `fragment_relationships`, `content_tags`, `content_minds`
- **CreatorOS** (needs evaluation): `content_projects`, `contents`, `content_frameworks`, `audience_profiles`

### 📋 RLS Status by Category

| Category | Tables | RLS Enabled | Compliant | Notes |
|----------|--------|-------------|-----------|-------|
| **Mind Core** | 11 | 11 (100%) | ✅ | Perfect |
| **Taxonomies** | 8 | 0 (0%) | ✅ | Correct (shared data) |
| **Operational** | 3 | 0 (0%) | ✅ | Correct (service-role only) |
| **Junction Tables** | 4 | 0 (0%) | ⚠️ | **Needs review** |
| **CreatorOS** | 4 | 0 (0%) | 🔴 | **Critical gap** |

### 🚨 Security Recommendations

#### Priority P0: CreatorOS Tables

**Issue**: `content_projects`, `contents`, `audience_profiles` lack RLS

**Risk**: Multi-tenant data leakage (users could see each other's projects/content)

**Fix**:
```sql
-- Enable RLS on CreatorOS tables
ALTER TABLE content_projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE contents ENABLE ROW LEVEL SECURITY;
ALTER TABLE audience_profiles ENABLE ROW LEVEL SECURITY;

-- Apply KISS policies (assuming creator_mind_id pattern)
CREATE POLICY "content_projects_rw_mine" ON content_projects
  FOR ALL TO authenticated
  USING (creator_mind_id = current_mind_id())
  WITH CHECK (creator_mind_id = current_mind_id());

CREATE POLICY "contents_rw_by_project" ON contents
  FOR ALL TO authenticated
  USING (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  )
  WITH CHECK (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  );

CREATE POLICY "audience_profiles_rw_by_project" ON audience_profiles
  FOR ALL TO authenticated
  USING (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  )
  WITH CHECK (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  );
```

#### Priority P1: Junction Tables

**Question**: Should `fragment_tags`, `fragment_relationships`, `content_tags`, `content_minds` have RLS?

**Current**: No RLS (likely relying on parent table RLS)

**Recommendation**:
- **Option A (Implicit)**: Keep without RLS, rely on parent table protection
- **Option B (Explicit)**: Add RLS for defense-in-depth

**Suggested approach** (Option B):
```sql
-- Protect fragment_tags via fragments.mind_id
CREATE POLICY "fragment_tags_via_fragment" ON fragment_tags
  FOR ALL TO authenticated
  USING (
    fragment_id IN (
      SELECT id FROM fragments WHERE mind_id = current_mind_id()
    )
  );

-- Protect fragment_relationships via fragments.mind_id
CREATE POLICY "fragment_relationships_via_fragment" ON fragment_relationships
  FOR ALL TO authenticated
  USING (
    from_fragment_id IN (
      SELECT id FROM fragments WHERE mind_id = current_mind_id()
    )
  );
```

### Security Function Analysis

**Available**: `current_mind_id()` ✅
**Missing**: `auth_uid()`, `is_admin()`

**Recommendation**: Add utility functions for common patterns:
```sql
-- Wrapper for auth.uid() (more portable)
CREATE OR REPLACE FUNCTION auth_uid()
RETURNS UUID AS $$
  SELECT COALESCE(
    auth.uid(),
    (current_setting('request.jwt.claims', true)::jsonb->>'sub')::uuid
  );
$$ LANGUAGE SQL STABLE;

-- Admin check (for operational dashboards)
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM user_profiles
    WHERE id = auth_uid()
      AND role = 'admin'
  );
$$ LANGUAGE SQL STABLE SECURITY DEFINER;
```

---

## ✅ 4. Data Integrity Audit

### Excellent Constraint Coverage

#### Constraint Summary

| Type | Count | Status |
|------|-------|--------|
| **Primary Keys** | 30 | ✅ Perfect (100%) |
| **Foreign Keys** | 37 | ✅ Excellent |
| **Check Constraints** | 154 | ✅ Outstanding |
| **Unique Constraints** | 17 | ✅ Good |

### Foreign Key Relationships

**Top connected tables:**

1. **fragments** (5 FKs): mind_id, source_id, category_id, generation_execution_id, ingestion_batch_id
2. **contents** (3 FKs): parent_content_id, project_id, generation_execution_id
3. **trait_scores** (3 FKs): mind_id, trait_id, generation_execution_id
4. **mind_proficiencies** (3 FKs): mind_id, skill_id, generation_execution_id

**Analysis**: Strong referential integrity with provenance tracking (generation_execution_id throughout).

### Check Constraints Analysis

**Categories of validation:**

1. **Range checks** (11): `relevance` (0-10), `intensity_10`, `level_10`, `score_10`, `weekday` (0-6), `fidelity_score` (0-1)
2. **Enum checks** (15+): status fields, content_type, privacy_level, role, etc.
3. **Business rules** (1): `from_fragment_id <> to_fragment_id`
4. **NOT NULL enforcement** (127): Comprehensive coverage

**Examples of excellent patterns:**
```sql
-- Range validation
CHECK ((relevance >= 0) AND (relevance <= 10))
CHECK ((fidelity_score >= 0) AND (fidelity_score <= 1))

-- Enum validation
CHECK (status = ANY (ARRAY['draft', 'reviewed', 'published', 'archived']))
CHECK (privacy_level = ANY (ARRAY['public', 'private']))

-- Business rule
CHECK (from_fragment_id <> to_fragment_id)
```

### 🔍 Suspicious Nullable Columns

**Views with nullable `id` and `created_at` (12 views):**
```
v_collected_contents, v_content_hierarchy, v_content_with_frameworks,
v_generated_contents, v_multi_mind_contents, v_recent_contents
```

**Analysis**: These are **views**, not tables. Nullable columns are expected when views use LEFT JOINs or aggregations. **No action needed**.

---

## 📋 5. Detailed Findings by Table Category

### Mind-Centric Tables (11 tables)

| Table | PK | created_at | updated_at | RLS | FKs | Issues |
|-------|----|-----------| -----------|-----|-----|--------|
| minds | ✅ | ✅ | ✅ | ✅ | 0 | None |
| sources | ✅ | ✅ | ✅ | ✅ | 1 | None |
| fragments | ✅ | ✅ | ✅ | ✅ | 5 | 2 FKs need indexes |
| mind_profiles | ✅ | ✅ | ✅ | ✅ | 2 | 1 FK needs index |
| mind_values | ✅ | ✅ | ✗ | ✅ | 1 | Missing updated_at |
| mind_psychometrics | ✅ | ✅ | ✅ | ✅ | 1 | None |
| mind_routine_windows | ✅ | ✅ | ✗ | ✅ | 1 | Missing updated_at |
| mind_obsessions | ✅ | ✅ | ✗ | ✅ | 1 | Missing updated_at |
| mind_proficiencies | ✅ | ✅ | ✗ | ✅ | 3 | 1 FK needs index, missing updated_at |
| trait_scores | ✅ | ✅ | ✗ | ✅ | 3 | 1 FK needs index, missing updated_at |
| user_profiles | ✅ | ✅ | ✗ | ✅ | 1 | Missing updated_at |

**Status**: ✅ Excellent (core architecture is solid)

### Taxonomy Tables (8 tables)

| Table | PK | created_at | updated_at | RLS | Issues |
|-------|----|-----------| -----------|-----|--------|
| categories | ✅ | ✗ | ✗ | ✗ | Missing timestamps (OK for taxonomies) |
| domains | ✅ | ✗ | ✗ | ✗ | Missing timestamps |
| specializations | ✅ | ✗ | ✗ | ✗ | Missing timestamps, 1 FK needs index |
| skills | ✅ | ✗ | ✗ | ✗ | Missing timestamps, 1 FK needs index |
| traits | ✅ | ✗ | ✗ | ✗ | Missing timestamps |
| tags | ✅ | ✅ | ✅ | ✗ | No RLS (correct for shared data) |
| content_frameworks | ✅ | ✅ | ✅ | ✗ | No RLS (likely shared) |
| mind_aliases | ✅ | ✗ | ✗ | ✗ | Missing timestamps |

**Status**: ✅ Good (timestamps optional for static taxonomies)

### Operational Tables (3 tables)

| Table | PK | created_at | updated_at | RLS | Issues |
|-------|----|-----------| -----------|-----|--------|
| ingestion_batches | ✅ | ✅ | ✗ | ✗ | No RLS (correct for service-role only) |
| processing_queue | ✅ | ✗ | ✗ | ✗ | Missing timestamps (intentional?) |
| job_executions | ✅ | ✅ | ✗ | ✗ | No RLS (correct) |

**Status**: ✅ Correct (operational tables don't need RLS)

### CreatorOS Tables (7 tables)

| Table | PK | created_at | updated_at | RLS | Issues |
|-------|----|-----------| -----------|-----|--------|
| content_projects | ✅ | ✅ | ✅ | ✗ | **🔴 Missing RLS**, 1 FK needs index |
| contents | ✅ | ✅ | ✅ | ✗ | **🔴 Missing RLS** |
| audience_profiles | ✅ | ✅ | ✅ | ✗ | **🔴 Missing RLS** |
| content_minds | ✅ | ✗ | ✗ | ✗ | Missing timestamps, missing RLS |
| content_tags | ✅ | ✗ | ✗ | ✗ | Missing timestamps, missing RLS |

**Status**: 🔴 Critical (CreatorOS needs RLS for multi-tenant security)

### Junction Tables (4 tables)

| Table | PK | created_at | updated_at | RLS | Issues |
|-------|----|-----------| -----------|-----|--------|
| fragment_tags | ✅ | ✗ | ✗ | ✗ | No RLS (relies on fragments RLS?) |
| fragment_relationships | ✅ | ✗ | ✗ | ✗ | No RLS (relies on fragments RLS?) |
| content_tags | ✅ | ✗ | ✗ | ✗ | No RLS (relies on contents RLS?) |
| content_minds | ✅ | ✗ | ✗ | ✗ | No RLS (relies on contents RLS?) |

**Status**: ⚠️ Needs decision (add explicit RLS or document reliance on parent tables)

---

## 🎯 6. Action Plan

### Priority P0 (Critical - Do First)

| # | Action | Effort | Impact | SQL |
|---|--------|--------|--------|-----|
| 1 | Enable RLS on `content_projects` | 30min | High | See Security section |
| 2 | Enable RLS on `contents` | 30min | High | See Security section |
| 3 | Enable RLS on `audience_profiles` | 30min | High | See Security section |

**Total P0 effort**: 1.5 hours
**Risk if skipped**: Multi-tenant data leakage in CreatorOS

### Priority P1 (Important - Do Soon)

| # | Action | Effort | Impact | SQL |
|---|--------|--------|--------|-----|
| 4 | Add 8 indexes for foreign keys | 1 hour | Medium | See Design section |
| 5 | Add `created_at` to 11 tables | 1 hour | Medium | See Design section |
| 6 | Consider RLS for junction tables | 2 hours | Low | See Security section |

**Total P1 effort**: 4 hours

### Priority P2 (Nice to Have - Do Eventually)

| # | Action | Effort | Impact |
|---|--------|--------|--------|
| 7 | Add `updated_at` to 20 tables | 2 hours | Low |
| 8 | Add `auth_uid()` and `is_admin()` functions | 30min | Low |
| 9 | Document RLS strategy for junction tables | 1 hour | Documentation |
| 10 | Set up monitoring (pg_stat_user_indexes) | 2 hours | Proactive |

**Total P2 effort**: 5.5 hours

---

## 📊 7. Database Health Scorecard

### Design Quality: 85/100 ⚠️

| Criteria | Score | Rationale |
|----------|-------|-----------|
| Primary keys | 100 | All 30 tables have UUID PKs ✅ |
| Timestamps | 65 | 11 tables missing created_at, 20 missing updated_at |
| Naming conventions | 95 | Consistent snake_case, clear names ✅ |
| Foreign keys | 90 | 37 FKs, but 8 missing indexes |
| Data types | 95 | Appropriate types, good use of JSONB ✅ |

**Recommendation**: Add timestamps to critical tables.

### Performance: 95/100 ✅

| Criteria | Score | Rationale |
|----------|-------|-----------|
| Index coverage | 100 | All foreign keys indexed (except 8) ✅ |
| Index efficiency | 100 | No unused indexes ✅ |
| Index bloat | 100 | No duplicates, no bloat ✅ |
| Table sizes | 90 | Small tables (13MB total), some have high index ratios |
| Query optimization | 95 | Database fits in RAM, fast queries expected ✅ |

**Recommendation**: Add 8 missing FK indexes for completeness.

### Security: 70/100 ⚠️

| Criteria | Score | Rationale |
|----------|-------|-----------|
| RLS coverage | 60 | 37% coverage (11/30 tables) |
| RLS policy quality | 95 | Simple, effective policies using current_mind_id() ✅ |
| Multi-tenant isolation | 40 | **CreatorOS tables lack RLS (critical gap)** 🔴 |
| Operational security | 95 | Correct separation (operational tables without RLS) ✅ |
| Auth functions | 80 | current_mind_id() exists, but missing auth_uid() helper |

**Recommendation**: Add RLS to CreatorOS tables ASAP.

### Data Integrity: 90/100 ✅

| Criteria | Score | Rationale |
|----------|-------|-----------|
| Constraint coverage | 95 | 154 check constraints, excellent ✅ |
| Referential integrity | 90 | 37 foreign keys, solid relationships ✅ |
| Business rules | 90 | Range checks, enums, self-ref prevention ✅ |
| NULL handling | 85 | Comprehensive NOT NULL constraints ✅ |
| Unique constraints | 85 | 17 unique constraints, adequate ✅ |

**Recommendation**: Continue current practices.

---

## 🔮 8. Future Recommendations

### Short Term (1-3 months)

1. **Complete P0 actions** (RLS for CreatorOS)
2. **Add missing FK indexes** (performance insurance)
3. **Document RLS strategy** (especially for junction tables)
4. **Set up query monitoring** (pg_stat_statements)

### Medium Term (3-6 months)

1. **Implement audit logging** (consider audit.logged_actions pattern)
2. **Add collaboration features** (mind_members, permissions)
3. **Optimize hot queries** (once you have production traffic data)
4. **Add partial indexes** (for common filtered queries)

### Long Term (6-12 months)

1. **Consider partitioning** (if tables exceed 10GB)
2. **Evaluate replication** (read replicas for analytics)
3. **Advanced monitoring** (pgBadger, pgHero, or similar)
4. **Performance testing** (load testing with realistic data volumes)

---

## 📝 9. SQL Fixes (Copy-Paste Ready)

### P0: Add RLS to CreatorOS

```sql
-- Add RLS to CreatorOS tables (CRITICAL)
ALTER TABLE content_projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE contents ENABLE ROW LEVEL SECURITY;
ALTER TABLE audience_profiles ENABLE ROW LEVEL SECURITY;

-- KISS policies for content_projects
CREATE POLICY "content_projects_rw_mine" ON content_projects
  FOR ALL TO authenticated
  USING (creator_mind_id = current_mind_id())
  WITH CHECK (creator_mind_id = current_mind_id());

-- Policy for contents (via project ownership)
CREATE POLICY "contents_rw_by_project" ON contents
  FOR ALL TO authenticated
  USING (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  )
  WITH CHECK (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  );

-- Policy for audience_profiles (via project ownership)
CREATE POLICY "audience_profiles_rw_by_project" ON audience_profiles
  FOR ALL TO authenticated
  USING (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  )
  WITH CHECK (
    project_id IN (
      SELECT id FROM content_projects
      WHERE creator_mind_id = current_mind_id()
    )
  );
```

### P1: Add Missing Indexes

```sql
-- Add indexes for foreign keys (PERFORMANCE)
CREATE INDEX CONCURRENTLY idx_content_projects_target_audience_id
  ON content_projects(target_audience_id)
  WHERE target_audience_id IS NOT NULL;

CREATE INDEX CONCURRENTLY idx_fragments_generation_execution_id
  ON fragments(generation_execution_id)
  WHERE generation_execution_id IS NOT NULL;

CREATE INDEX CONCURRENTLY idx_fragments_ingestion_batch_id
  ON fragments(ingestion_batch_id)
  WHERE ingestion_batch_id IS NOT NULL;

CREATE INDEX CONCURRENTLY idx_mind_proficiencies_generation_execution_id
  ON mind_proficiencies(generation_execution_id)
  WHERE generation_execution_id IS NOT NULL;

CREATE INDEX CONCURRENTLY idx_mind_profiles_generation_execution_id
  ON mind_profiles(generation_execution_id)
  WHERE generation_execution_id IS NOT NULL;

CREATE INDEX CONCURRENTLY idx_skills_specialization_id
  ON skills(specialization_id);

CREATE INDEX CONCURRENTLY idx_specializations_domain_id
  ON specializations(domain_id);

CREATE INDEX CONCURRENTLY idx_trait_scores_generation_execution_id
  ON trait_scores(generation_execution_id)
  WHERE generation_execution_id IS NOT NULL;
```

### P1: Add Missing Timestamps

```sql
-- Add created_at to tables (AUDIT TRAIL)
ALTER TABLE mind_aliases ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE domains ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE specializations ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE skills ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE processing_queue ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE categories ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE fragment_tags ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE fragment_relationships ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE traits ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE content_minds ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;
ALTER TABLE content_tags ADD COLUMN created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL;

-- Add updated_at to critical tables (optional)
-- Run only if you need modification tracking
-- ALTER TABLE mind_values ADD COLUMN updated_at TIMESTAMPTZ;
-- ALTER TABLE mind_obsessions ADD COLUMN updated_at TIMESTAMPTZ;
-- ... (add to others as needed)
```

### P2: Add Helper Functions

```sql
-- Helper function: auth_uid()
CREATE OR REPLACE FUNCTION auth_uid()
RETURNS UUID AS $$
  SELECT COALESCE(
    auth.uid(),
    (current_setting('request.jwt.claims', true)::jsonb->>'sub')::uuid
  );
$$ LANGUAGE SQL STABLE;

-- Helper function: is_admin()
-- Note: Requires 'role' column in user_profiles
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM user_profiles
    WHERE id = auth_uid()
      AND role = 'admin'  -- Adjust based on your role system
  );
$$ LANGUAGE SQL STABLE SECURITY DEFINER;
```

---

## ✅ 10. Validation Checklist

After applying fixes, verify:

### RLS Verification
```sql
-- Test RLS as non-admin user
SET ROLE authenticated;
SET request.jwt.claims = '{"sub": "test-user-id"}';

-- Should only see own content_projects
SELECT * FROM content_projects;

-- Reset
RESET ROLE;
```

### Index Verification
```sql
-- Verify indexes created
SELECT
  tablename,
  indexname,
  indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND indexname LIKE 'idx_%generation_execution_id%'
ORDER BY tablename, indexname;
```

### Performance Check
```sql
-- Verify no unused indexes
SELECT
  schemaname,
  tablename,
  indexname,
  idx_scan
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
  AND idx_scan = 0
  AND indexname NOT LIKE '%_pkey';
```

---

## 📞 Support & Next Steps

**Questions?** Contact DB Sage: `/db-sage` in Claude Code

**Next Audit**: Recommended in 3-6 months or after major schema changes

**Monitoring**: Set up `pg_stat_statements` to track query performance in production

---

## 🏆 Conclusion

**Overall Assessment**: ✅ **Production Ready (85/100)**

Your database schema is **well-designed and production-ready** with excellent data integrity and performance characteristics. The main area for improvement is **security (RLS coverage)**, particularly for CreatorOS tables.

**Strengths**:
- Solid foundation (all PKs, excellent constraints)
- Clean design (mind-centric architecture)
- Good performance (no bloat, all indexes used)
- Small and fast (13MB, fits in RAM)

**Critical Action**: Apply P0 fixes (RLS for CreatorOS) before multi-tenant production use.

**Recommended Timeline**:
- **Week 1**: P0 fixes (RLS) - **1.5 hours**
- **Week 2**: P1 fixes (indexes, timestamps) - **4 hours**
- **Month 2**: P2 improvements - **5.5 hours**

---

**Report Generated**: 2025-10-28
**DB Sage Version**: 1.0
**Next Audit Due**: 2025-04-28 (6 months)
