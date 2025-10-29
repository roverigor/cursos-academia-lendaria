# 🗄️ DB Sage Best Practices - Mente Lendária Project

**Document Purpose:** Capture lessons learned, common issues, and solutions for database operations in this project.

**Last Updated:** 2025-10-27
**Project:** Mente Lendária (MMOS + Supabase Migration)
**DB Sage Version:** v1.1.0

---

## 🚨 Critical Issues & Solutions

### Issue #1: .env SUPABASE_DB_URL Line Break Error

**Problem Found:** 2025-10-27

**Symptom:**
```bash
.env:69: command not found: gres
psql: erro: a conexão com o servidor no soquete "/tmp/.s.PGSQL.5432" falhou
```

**Root Cause:**
- Connection string was broken across two lines (68-69):
  ```bash
  # Line 68
  SUPABASE_DB_URL=postgresql://...postgres
  # Line 69
      gres  # ← This line breaks everything!
  ```
- When sourcing `.env`, shell tried to execute `gres` as a command
- `psql` tried to connect to local socket instead of remote Supabase

**Solution:**
1. ✅ Remove broken URL (lines 68-69)
2. ✅ Keep single complete URL at line ~217
3. ✅ Add `sslmode=require` for security
4. ✅ Comment duplicates

**Final Configuration:**
```bash
# Database Connection String (PostgreSQL via Session Pooler + SSL)
SUPABASE_DB_URL=postgresql://postgres.{project-ref}:{password}@aws-1-us-east-2.pooler.supabase.com:5432/postgres?sslmode=require
```

**Prevention:**
- ⚠️ **NEVER** break connection strings across lines in `.env`
- ⚠️ Always use full URL in single line
- ✅ Always add `?sslmode=require` for production
- ✅ Use pooler URL (`pooler.supabase.com:5432`) not direct (`supabase.co:6543`)

---

### Issue #2: Environment Variables Not Exported

**Problem:**
- Variables exist in `.env` but not available in shell
- `test -n "$SUPABASE_DB_URL"` fails even though file has it

**Solution:**
```bash
# Don't use:
export $(grep SUPABASE_DB_URL .env | xargs)  # ❌ Fails with special chars

# Use instead:
source .env  # ✅ Works correctly
# or
export SUPABASE_DB_URL="$(grep '^SUPABASE_DB_URL=' .env | tail -1 | cut -d'=' -f2-)"
```

**Best Practice:**
- Always `source .env` before database operations
- Use `tail -1` when there might be duplicates
- Quote the variable expansion: `"$SUPABASE_DB_URL"`

---

## ✅ Pre-Operation Checklist

Before ANY database operation, run:

```bash
# 1. Check environment
source .env && echo "✓ .env loaded"

# 2. Validate connection string
echo "$SUPABASE_DB_URL" | grep -q "sslmode=require" && echo "✓ SSL configured"
echo "$SUPABASE_DB_URL" | grep -q "pooler" && echo "✓ Using pooler"

# 3. Test connection
psql "$SUPABASE_DB_URL" -t -c "SELECT current_database(), current_user;"

# 4. Create snapshot before changes
psql "$SUPABASE_DB_URL" -t -c "SELECT current_timestamp;" > supabase/schemas/pre_$(date +%Y%m%d_%H%M%S).txt
```

Or use DB Sage: `*env-check`

---

## 🏗️ Migration Architecture

### Current Status

**✅ Phase 1 Complete: Taxonomy**
- domains: 6 rows (SQLite → Supabase)
- specializations: 22 rows
- skills: 73 rows
- traits: 40 rows (Supabase), 35 rows (SQLite) - needs reconciliation

**🔄 Phase 2 Pending: Core Entities**
- minds: 28 rows (SQLite) → 0 rows (Supabase)
- sources: 39 rows (SQLite) → 0 rows (Supabase)

**⏳ Phase 3 Pending: Fragments**
- fragments: 74 rows (SQLite) → 0 rows (Supabase)
- High complexity - see SCHEMA-COMPARISON doc

### Hybrid Architecture Decision

**Supabase (Cloud):**
- Core fields only
- Public-facing data
- Multi-user access
- RLS policies active

**SQLite (Local):**
- Rich metadata (MMOS-specific)
- Large content (raw_content, clean_content)
- Pipeline execution tracking
- Reference taxonomies

**Why Hybrid?**
1. 🔴 **Cost:** Supabase charges per GB - avoid storing large content
2. 🔴 **Compatibility:** SQLite has 40+ fields per table, Supabase has 8-10
3. 🟢 **Performance:** Local content access faster for MMOS pipeline
4. 🟢 **Separation:** Keep MMOS internals separate from public API

---

## 📋 Common Operations

### Safe Migration Pattern

```bash
# 1. Snapshot before change
*snapshot "pre_migration_$(date +%Y%m%d)"

# 2. Dry run first
*dry-run supabase/migrations/20251027_new_migration.sql

# 3. Apply migration
*apply-migration supabase/migrations/20251027_new_migration.sql

# 4. Smoke test
*smoke-test v0.8.0

# 5. Rollback if needed
*rollback supabase/schemas/v0_8_0_20251027_before.sql
```

### Connecting to Supabase

```bash
# Load environment
source .env

# Direct query
psql "$SUPABASE_DB_URL" -c "SELECT * FROM minds LIMIT 5;"

# Interactive session
psql "$SUPABASE_DB_URL"
```

### Exportando Dados Legados (Histórico)

> Nota: o SQLite local foi descontinuado em 2025-10. Para consultar o backup histórico, acesse `supabase/backups/` e utilize ferramentas de análise offline. Não execute comandos SQLite nos pipelines atuais.

---

## 🔐 Security Best Practices

### Connection Strings

✅ **DO:**
- Use pooler URL for production
- Always add `?sslmode=require`
- Store in `.env` (gitignored)
- Use `%40` for `@` in passwords
- Use environment variables in scripts

❌ **DON'T:**
- Hard-code credentials in files
- Use direct connection (port 6543) for production
- Share `.env` file
- Commit connection strings to git
- Break URLs across multiple lines

### RLS Policies

Current status:
- ⚠️ RLS not yet configured (v0.7.0 baseline)
- 🔄 Need to add before production
- Use: `*rls-audit` to check coverage
- Use: `*policy-apply minds kiss` for quick setup

---

## 🐛 Troubleshooting

### "Connection to socket /tmp/.s.PGSQL.5432 failed"

**Cause:** psql trying local connection instead of remote

**Fix:**
```bash
# Check if URL is set correctly
echo "$SUPABASE_DB_URL" | head -c 50

# Re-export
source .env

# Try again
psql "$SUPABASE_DB_URL" -c "SELECT 1;"
```

### "command not found: gres"

**Cause:** Line break in `.env` file

**Fix:** See Issue #1 above - consolidate URL to single line

### "relation does not exist"

**Cause:** Table not created yet or wrong schema

**Fix:**
```bash
# List tables
psql "$SUPABASE_DB_URL" -c "\dt"

# Check if migrations applied
psql "$SUPABASE_DB_URL" -c "SELECT * FROM supabase_migrations.schema_migrations;"

# Apply migrations
*apply-migration supabase/migrations/20251026211500_v0_7_0_baseline.sql
```

### "UUID type mismatch"

**Cause:** SQLite uses INTEGER PKs, Supabase uses UUID

**Solution:**
- Create `uuid_mapping` table during migration
- Use Phase 2 migration scripts (see SCHEMA-COMPARISON doc)

---

## 📚 Related Documentation

- [SCHEMA-COMPARISON-SQLITE-SUPABASE.md](./SCHEMA-COMPARISON-SQLITE-SUPABASE.md) - Detailed schema analysis
- [DB-SAGE-IMPLEMENTATION-GUIDE.md](./DB-SAGE-IMPLEMENTATION-GUIDE.md) - DB Sage setup
- [supabase/README.md](../../supabase/README.md) - Supabase project structure
- [supabase/docs/MIGRATIONS.md](../../supabase/docs/MIGRATIONS.md) - Migration guide

---

## 🎯 Quick Reference

### DB Sage Commands Used in This Session

```bash
*help                  # List all commands
*env-check            # Validate environment (used to find .env issue)
*snapshot baseline    # Create backup before migration
*apply-migration      # Apply schema changes
*smoke-test          # Validate database health
```

### Useful psql Commands

```bash
\dt                   # List tables
\d minds              # Describe table
\l                    # List databases
\conninfo             # Show connection info
\x                    # Toggle expanded display
\q                    # Quit
```

### Connection String Format

```
postgresql://USER:PASSWORD@HOST:PORT/DATABASE?sslmode=require

USER:     postgres.{project-ref}
PASSWORD: {url-encoded}  # @ → %40, etc.
HOST:     aws-1-us-east-2.pooler.supabase.com
PORT:     5432 (pooler) or 6543 (direct)
DATABASE: postgres
```

---

## 🔄 Next Steps

1. ✅ Complete Phase 2: Migrate minds + sources data
2. ⚠️ Reconcile traits (40 in Supabase, 35 in SQLite)
3. 🔄 Set up uuid_mapping table
4. 🔄 Phase 3: Migrate fragments (complex!)
5. 🔐 Configure RLS policies
6. 📊 Set up monitoring/observability

---

**🗄️ DB Sage says:** "Correctness before speed - get it right first, optimize second!"

---

*This document is a living document. Update as new issues are discovered and solved.*
