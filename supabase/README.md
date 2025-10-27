# 🗄️ Supabase Database Management

Production-grade database migration system with automatic snapshots and rollback.

---

## 📂 Structure

```
supabase/
├── migrations/     # Version-controlled schema changes
├── schemas/        # Automatic snapshots (before/after each migration)
├── tests/          # Smoke tests for validation
├── rollback/       # Emergency rollback scripts
└── docs/           # Migration history & deployment guides
```

---

## 🚀 Quick Start

### Deploy Baseline (v0.7.0)

```bash
# 1. Set database URL
export SUPABASE_DB_URL="postgresql://postgres:[PASS]@db.[PROJECT].supabase.co:5432/postgres"

# 2. Apply baseline
./scripts/db-migrate.sh supabase/migrations/20251026211500_v0_7_0_baseline.sql

# 3. Apply seed
./scripts/db-migrate.sh supabase/migrations/20251026213000_v0_7_0_seed.sql

# 4. Test (when test file exists)
./scripts/db-test.sh v0.7.0
```

---

## 📚 Documentation

- **[MIGRATIONS.md](docs/MIGRATIONS.md)** - Migration history tracker
- **[DEPLOYMENT.md](docs/DEPLOYMENT.md)** - How to deploy safely
- **[../docs/database/MIGRATION-ARCHITECTURE.md](../docs/database/MIGRATION-ARCHITECTURE.md)** - Architecture design

---

## 🔧 Scripts

Located in `scripts/`:
- **db-migrate.sh** - Apply migration with automatic snapshot
- **db-rollback.sh** - Rollback to previous snapshot
- **db-test.sh** - Run smoke tests

---

## 📸 Snapshots

Automatic snapshots created before/after each migration:
```
schemas/
├── v0_7_0_20251026211500_before.sql   # Before baseline
├── v0_7_0_20251026211500_after.sql    # After baseline
└── ...
```

**Rollback:** `./scripts/db-rollback.sh v0_7_0`

---

## ✅ Current Version

**v0.7.0** - Production Baseline
- 30 tables
- 3 views
- 5 functions
- 16 RLS policies

**Status:** Ready for deployment
**Next:** v0.8.0 (collaboration - when needed)

---

**Maintained by:** Database Team
**Last Updated:** 2025-10-26
