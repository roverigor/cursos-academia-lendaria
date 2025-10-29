# 🗄️ Database Documentation

> **Central hub for database architecture, schema, and operations**

---

## 📋 Quick Reference

```yaml
# DATABASE METADATA (Machine-readable for DB Sage and other tools)
database:
  technology: supabase
  engine: postgresql
  version: "17.6"

  current_schema:
    version: "v0.8.2"
    migration: "../../supabase/migrations/20251027100000_v0_8_2_fragments_cleanup.sql"
    documentation: "evolution/0.8_README.md"
    snapshot: "../../supabase/schemas/v0_8_2_20251027_after.sql"
    deployed_date: "2025-10-27"
    last_audit: "2025-10-28"
    audit_report: "../../supabase/docs/schema-audit-20251028.md"

  pending_migrations:
    - version: "v0.9.0"
      file: "../../supabase/migrations/20251028_v0_9_0_agent_scans.sql"
      description: "Agent scans platform - NOT APPROVED YET"
      status: "awaiting approval"

  evolution:
    history: "evolution/README.md"
    versions:
      - version: "v0.8.0"
        date: "2025-10-27"
        migration: "20251027012200_v0_8_0_taxonomy_data.sql"
        changes: "MMOS taxonomy (domains, specializations, skills, traits)"
      - version: "v0.7.0"
        date: "2025-10-26"
        migration: "20251026211500_v0_7_0_baseline.sql"
        changes: "Production baseline - unified schema with RLS, auth, CreatorOS"
      - version: "v0.6.0"
        date: "2025-10-26"
        migration: "draft"
        changes: "Unified all-in-one (had critical bugs)"

  structure:
    migrations: "../../supabase/migrations/"
    schemas: "../../supabase/schemas/"
    tests: "../../supabase/tests/"
    rollback: "../../supabase/rollback/"
    docs: "../../supabase/docs/"
```

---

## 🎯 Current Schema

**Version:** v0.8.2 (Fragments Cleanup)
**Status:** ✅ Deployed and stable
**Deployed:** 2025-10-27
**Last Audit:** 2025-10-28 (Score: 85/100 - Production Ready)

**Documentation:** [Schema Evolution 0.8](evolution/0.8_README.md)
**Audit Report:** [Schema Audit 2025-10-28](../../supabase/docs/schema-audit-20251028.md)
**Migration:** [20251027100000_v0_8_2_fragments_cleanup.sql](../../supabase/migrations/20251027100000_v0_8_2_fragments_cleanup.sql)
**Snapshot:** [v0_8_2_20251027_after.sql](../../supabase/schemas/v0_8_2_20251027_after.sql)

### Architecture Overview

- **34 tables** organized around mind-centric architecture
- **3 views** for analytics and reporting
- **5 functions** for RLS and utilities
- **16 RLS policies** for row-level security

### Changes in v0.8.x (from v0.7.0)

**v0.8.0 - MMOS Taxonomy:**
- `domains` - Knowledge areas taxonomy
- `specializations` - Sub-domains
- `skills` - Specific skills
- `mind_proficiencies` - Mind skill tracking with evidence

**v0.8.2 - Fragments Cleanup:**
- `fragments.relevance_10` → `fragments.relevance` (SMALLINT 0-10)
- Added `fragments.metadata` (JSONB for flexible future signals)
- Removed `fragments.layer` (obsolete column)
- Rebuilt indexes for new column structure

**Why:** Simplifies fragment scoring, adds flexibility for future enhancements

### Core Components

1. **Knowledge Core**: `minds → sources → fragments`
2. **Enrichments**: `tags`, `relationships`, `taxonomies`, `profiles`
3. **Operations**: `ingestion_batches → processing_queue → job_executions`
4. **CreatorOS**: `content_projects → content_pieces → campaigns → performance`
5. **Auth & RLS**: Passwordless magic link + `user_profiles` mapping

---

## 📚 Documentation Index

### Schema Documentation
- **[Current Schema (v0.7.0)](evolution/0.6_README_UNIFIED_DATABASE.md)** - Complete schema with rationale
- **[Migration Architecture](MIGRATION-ARCHITECTURE.md)** - How migrations work
- **[Schema Evolution](evolution/README.md)** - History of schema changes
- **[Schema Comparison](../architecture/db-sage/SCHEMA-COMPARISON-SQLITE-SUPABASE.md)** - SQLite vs Supabase

### Operations Documentation
- **[Supabase README](../../supabase/README.md)** - Quick start and operations
- **[Migrations Log](../../supabase/docs/MIGRATIONS.md)** - Migration history
- **[Deployment Guide](../../supabase/docs/DEPLOYMENT.md)** - How to deploy safely

### Design & Planning
- **[Feedback & Improvements](FEEDBACK-IMPROVEMENTS.md)** - Collected feedback and future improvements

---

## 🚀 Quick Start

### For Users

```bash
# Check database connection
export SUPABASE_DB_URL="postgresql://postgres:[PASS]@db.[PROJECT].supabase.co:5432/postgres"
psql $SUPABASE_DB_URL -c "SELECT version();"
```

### For DB Sage (AI Agent)

When DB Sage activates, it automatically:
1. Reads this README to discover current schema
2. Loads the schema documentation (evolution/0.6_README_UNIFIED_DATABASE.md)
3. Reads the latest schema snapshot for current structure
4. Uses this context for all schema decisions

### For Developers

```bash
# Apply migration
./scripts/db-migrate.sh supabase/migrations/YYYYMMDD_VERSION_description.sql

# Create snapshot
./scripts/db-snapshot.sh v0.8.0

# Rollback
./scripts/db-rollback.sh v0.7.0

# Run tests
./scripts/db-test.sh v0.7.0
```

---

## 🏗️ Schema Philosophy

Our database follows these principles:

1. **Mind-Centric Architecture** - Everything anchors to `minds` table
2. **Provenance Tracking** - Full lineage from sources → fragments → artifacts
3. **RLS by Default** - Security with `DEFAULT current_mind_id()`
4. **KISS Principles** - Avoid premature optimization
5. **JSONB-First** - Flexible profiles/metadata
6. **Operational Separation** - Operational tables without RLS (service-role only)

📚 **[Complete Philosophy →](evolution/0.6_README_UNIFIED_DATABASE.md#1-visão-geral-mental-model)**

---

## 🔄 Schema Evolution

### Version History

| Version | Date | Description | Migration | Docs |
|---------|------|-------------|-----------|------|
| v0.8.2 | 2025-10-27 | **CURRENT** - Fragments cleanup (relevance, metadata JSONB) | [20251027100000](../../supabase/migrations/20251027100000_v0_8_2_fragments_cleanup.sql) | [0.8_README](evolution/0.8_README.md) |
| v0.8.0 | 2025-10-27 | MMOS taxonomy (domains, skills, proficiencies) | [20251027012200](../../supabase/migrations/20251027012200_v0_8_0_taxonomy_data.sql) | [0.8_README](evolution/0.8_README.md) |
| v0.7.0 | 2025-10-26 | Production baseline - 30 tables, RLS, auth | [20251026211500](../../supabase/migrations/20251026211500_v0_7_0_baseline.sql) | [Audit](../../supabase/docs/schema-audit-20251028.md) |
| v0.6.0 | 2025-10-26 | Unified schema (had bugs, deprecated) | draft | [0.6_README](evolution/0.6_README_UNIFIED_DATABASE.md) |

### Pending Migrations (Awaiting Approval)

| Version | Description | Migration | Status |
|---------|-------------|-----------|--------|
| v0.9.0 | Agent scans platform (new `agent_scans` table) | [20251028_v0_9_0](../../supabase/migrations/20251028_v0_9_0_agent_scans.sql) | ⏸️ Not approved |

📚 **[Full Evolution History →](evolution/README.md)**

---

## 🛠️ Tools & Scripts

### Migration Tools
- `./scripts/db-migrate.sh` - Apply migration with automatic snapshot
- `./scripts/db-rollback.sh` - Rollback to previous snapshot
- `./scripts/db-test.sh` - Run smoke tests

### Schema Tools
- `./scripts/db-snapshot.sh` - Create schema snapshot
- `./scripts/db-diff.sh` - Compare two schemas

### Analysis Tools
- `./scripts/db-analyze.sh` - Analyze query performance
- `./scripts/db-audit.sh` - Security and quality audit

---

## 🔐 Security

### RLS Policies
- **Client tables**: `FOR ALL USING (mind_id = current_mind_id())`
- **Operational tables**: No RLS (service-role only)
- **Magic Link**: Passwordless authentication

### Connection Security
- **Production**: Use Pooler with SSL (`db.PROJECT.supabase.co:6543`)
- **Development**: Direct connection acceptable
- **Service Role**: Never expose in client code

---

## 📊 Monitoring & Analytics

### Views Available
- `v_job_mind_attribution` - Execution attribution by mind
- `v_batch_costs` - Cost tracking per batch
- `v_cost_per_fragment` - Per-fragment cost analysis
- `v_mind_latest_profiles` - Latest profile versions
- `v_project_content_stats` - CreatorOS statistics

---

## 🆘 Troubleshooting

### Common Issues

**INSERT denied?**
→ Check RLS policy and `current_mind_id()` context

**SELECT returns empty?**
→ Verify `auth.uid()` is set (JWT token valid)

**Service role in client?**
→ Never! Use `anon` key in client, `service` only in backend

📚 **[Full Troubleshooting Guide →](evolution/0.6_README_UNIFIED_DATABASE.md#13-troubleshooting-rápido)**

---

## 🔮 Future Plans

### v0.8.0 (Next)
- [ ] Collaboration features (`mind_members`, `mind_invitations`)
- [ ] Enhanced audit logging
- [ ] Performance optimizations based on production metrics

### v0.9.0 (Future)
- [ ] Multi-language support (i18n)
- [ ] Advanced search (full-text + vector)
- [ ] Real-time subscriptions

---

## 🤝 Contributing

When making database changes:

1. **Always run KISS Gate validation** (`*validate-kiss` in DB Sage)
2. **Create migration with rollback script**
3. **Test on staging first**
4. **Update this README with new version info**
5. **Document rationale in schema evolution docs**

---

## 📞 Support

**DB Sage Agent:** Run `/db-sage` in Claude Code for interactive database assistance

**Documentation:** All docs in this directory

**Issues:** Report database issues with `[DB]` prefix in issue tracker

---

**Last Updated:** 2025-10-27
**Maintained By:** Database Team
**Current Version:** v0.7.0
