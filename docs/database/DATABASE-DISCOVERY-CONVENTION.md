# 📍 Database Discovery Convention

> **How DB Sage discovers schema documentation dynamically**

---

## 🎯 Goal

Enable DB Sage to discover and load database schema documentation in a **technology-agnostic**, **version-agnostic**, and **project-agnostic** way.

---

## 🔄 Discovery Cascade

```
┌──────────────────────┐
│   README.md (root)   │  ← STEP 3.1: Find database docs link
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│ docs/database/       │  ← STEP 3.2: Extract current_schema metadata
│   README.md          │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│ Schema Documentation │  ← STEP 3.3: Load schema docs + snapshot
│ + Schema Snapshot    │
└──────────────────────┘
```

---

## 📋 Implementation Checklist

### ✅ Step 1: Add Database Section to Root README.md

**Location:** `README.md` (project root)

**Add this section** (after Components, before Documentation):

```markdown
## 🗄️ Database

**Technology:** {Supabase|PostgreSQL|MySQL|SQLite|MongoDB|etc}
**Current Version:** {vX.Y.Z}
**Documentation:** [docs/database/README.md](docs/database/README.md)

Brief description of database architecture (2-3 sentences).

📚 **[Complete Database Documentation →](docs/database/README.md)**
```

**Example:**

```markdown
## 🗄️ Database

**Technology:** Supabase (PostgreSQL 16+)
**Current Version:** v0.7.0
**Documentation:** [docs/database/README.md](docs/database/README.md)

The project uses Supabase as backend with unified schema supporting MMOS, CreatorOS, and Auth/RLS.

📚 **[Complete Database Documentation →](docs/database/README.md)**
```

---

### ✅ Step 2: Create docs/database/README.md

**Location:** `docs/database/README.md`

**Must include YAML metadata block:**

```yaml
# Quick Reference at the top of the file

```yaml
# DATABASE METADATA (Machine-readable for DB Sage)
database:
  technology: {supabase|postgresql|mysql|sqlite|mongodb}
  engine: {postgresql|mysql|sqlite} # optional
  version: "16.x" # optional

  current_schema:
    version: "v0.7.0"
    documentation: "relative/path/to/schema-doc.md"
    snapshot: "relative/path/to/schema.sql" # optional
    deployed_date: "2025-10-26" # optional

  structure: # optional
    migrations: "path/to/migrations/"
    schemas: "path/to/schemas/"
```
\`\`\`

**Full template available:** [docs/database/README.md](README.md) ← This file

---

### ✅ Step 3: Create Schema Documentation

**Location:** Path specified in `current_schema.documentation`

**Should contain:**
- Complete schema overview
- Tables with purpose and relationships
- Design philosophy and rationale
- Common queries and usage examples
- Migration history
- Troubleshooting guide

**Example:**
```markdown
# Database Schema v0.7.0

## Overview
- 30 tables organized around mind-centric architecture
- Mind → Sources → Fragments provenance chain
- RLS with DEFAULT current_mind_id()

## Tables
### minds
- Purpose: Central entity representing a cognitive profile
- Relationships: sources, fragments, profiles
...
```

---

### ✅ Step 4: (Optional) Provide Schema Snapshot

**Location:** Path specified in `current_schema.snapshot`

**Should be:**
- Latest production schema DDL
- SQL dump or migration file
- Updated on each deployment

**Example locations:**
- `supabase/schemas/v0_7_0_YYYYMMDD_after.sql`
- `database/schema.sql`
- `migrations/current_schema.sql`

---

## 🔍 How DB Sage Uses This

### On Activation

```
1. Read README.md → Find database section → Extract link
2. Read docs/database/README.md → Parse YAML metadata
3. Load schema documentation (full file)
4. Load schema snapshot (first 100 lines)
5. Store in memory for session
```

### During Work

```
- Before schema changes → Reference loaded context
- When designing tables → Check existing schema
- When running migrations → Understand current state
- When auditing → Compare against documentation
```

---

## 🌍 Examples for Different Technologies

### Supabase Project

```yaml
database:
  technology: supabase
  engine: postgresql
  version: "16.x"
  current_schema:
    version: "v0.7.0"
    documentation: "evolution/0.6_README_UNIFIED_DATABASE.md"
    snapshot: "../../supabase/schemas/v0_7_0_20251026224030_after.sql"
```

### Plain PostgreSQL

```yaml
database:
  technology: postgresql
  version: "14.x"
  current_schema:
    version: "v2.3.0"
    documentation: "schema/v2.3.0-schema.md"
    snapshot: "schema/current.sql"
```

### MySQL Project

```yaml
database:
  technology: mysql
  version: "8.0"
  current_schema:
    version: "v1.5.2"
    documentation: "database-schema.md"
    snapshot: "schema.sql"
```

### SQLite Project

```yaml
database:
  technology: sqlite
  version: "3.x"
  current_schema:
    version: "v0.3.0"
    documentation: "docs/schema.md"
    snapshot: "database/app.db.schema"
```

### MongoDB Project

```yaml
database:
  technology: mongodb
  version: "6.0"
  current_schema:
    version: "v1.0.0"
    documentation: "schema/collections.md"
    # No snapshot needed for NoSQL
```

---

## ✅ Benefits

### For Projects
- ✅ **Clear documentation entry point** - Always know where to find database docs
- ✅ **Version tracking** - Clear history of schema evolution
- ✅ **Technology agnostic** - Works for any database
- ✅ **Machine readable** - Tools can parse and use

### For DB Sage
- ✅ **Automatic discovery** - No hardcoded paths
- ✅ **Context awareness** - Always knows current schema
- ✅ **Informed decisions** - References existing architecture
- ✅ **KISS enforcement** - Checks if changes are truly needed

### For Developers
- ✅ **Single source of truth** - One place for all database info
- ✅ **Easy onboarding** - New devs find schema quickly
- ✅ **Safe migrations** - Understand current state before changing
- ✅ **Rollback support** - Version history preserved

---

## 🚨 Common Pitfalls to Avoid

### ❌ Don't Hardcode Version Numbers

**Bad:**
```markdown
## Database
Using Supabase v0.7.0, see docs/database/evolution/0.6_README_UNIFIED_DATABASE.md
```

**Good:**
```markdown
## Database
**Documentation:** [docs/database/README.md](docs/database/README.md)
(Let the database README handle version tracking)
```

### ❌ Don't Scatter Documentation

**Bad:**
- README.md mentions schema
- docs/ARCHITECTURE.md has some tables
- supabase/README.md has other info
- No clear entry point

**Good:**
- README.md → points to docs/database/README.md
- docs/database/README.md → central hub with all links
- Single source of truth

### ❌ Don't Forget to Update

**Bad:**
- Schema evolves to v0.8.0
- docs/database/README.md still says v0.7.0
- Stale documentation confuses everyone

**Good:**
- Update docs/database/README.md `current_schema` on every migration
- Include version update in migration checklist
- Automate if possible

---

## 📝 Migration Checklist

When deploying new schema version:

- [ ] Apply migration to database
- [ ] Update `current_schema.version` in docs/database/README.md
- [ ] Update `current_schema.documentation` path if new doc created
- [ ] Update `current_schema.snapshot` path to latest snapshot
- [ ] Update root README.md "Current Version" if shown there
- [ ] Test DB Sage activation to confirm discovery works
- [ ] Commit all documentation changes with migration

---

## 🤝 Contributing

To improve this convention:

1. **Test on different projects** - Does it work for your stack?
2. **Provide feedback** - What's missing? What's confusing?
3. **Submit examples** - Show how you implemented it
4. **Report issues** - If DB Sage fails to discover, tell us why

---

## 📚 Related Documentation

- [Database README](README.md) - Example implementation
- [DB Sage Agent](../../expansion-packs/super-agentes/agents/db-sage.md) - How it's consumed
- [Schema Evolution](evolution/README.md) - Version history

---

**Last Updated:** 2025-10-27
**Version:** 1.0.0
**Status:** ✅ Active Convention
