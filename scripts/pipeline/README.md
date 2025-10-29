# Supabase Pipeline (Migration in Progress)

> The legacy SQLite automation (`SQLite legado (migrado para Supabase em 2025-10)`) has been fully retired. All ingestion now targets the Supabase production database described in `docs/database/README.md`.

---

## What Changed (2025-10-29)

- Removed all SQLite-oriented scripts (`db-integration-v3.sh`, `populate-sources.js`, `import-analysis.js`, `validate-integration.js`, `extract-fragments.js`).
- Archived the `SQLite legado (migrado para Supabase em 2025-10)` workflow. Supabase schema v0.8.2 is the single source of truth.
- Established Supabase-native ingestion patterns (see examples below).

---

## Current Ingestion Options

| Use Case | Script / Guide | Notes |
|----------|----------------|-------|
| InnerLens MIU fragments → Supabase | `expansion-packs/innerlens/scripts/save_fragments_to_supabase.py` | Uses `psycopg2` + JSONB metadata |
| Minds bootstrap (slugs/display names) | `scripts/database/populate_supabase_minds.js` | Connects with `SUPABASE_DB_URL` |
| Custom SQL / migrations | `supabase/migrations/` + `supabase/scripts/*.sh` | Leverage Supabase CLI + psql |
| CreatorOS persistence | `expansion-packs/creator-os/lib/db_persister.py` | Uses official Supabase Python client |

---

## Working with Supabase

```bash
# 1. Load environment (service role or local tunnel)
export SUPABASE_DB_URL="postgresql://postgres:XXX@db.YOUR-REF.supabase.co:5432/postgres?sslmode=require"

# 2. Quick smoke test
psql "$SUPABASE_DB_URL" -c "select current_schema(), current_setting('server_version');"

# 3. Run ad-hoc SQL (example: list minds)
psql "$SUPABASE_DB_URL" -c "select slug, display_name, updated_at from minds order by updated_at desc limit 10;"
```

**Recommended client libraries**
- Node.js: `pg` or `@supabase/postgrest-js`
- Python: `psycopg2` or `supabase-py`
- Bash: `psql` via Supabase CLI tunnel

---

## Migration Roadmap

1. **Supabase ingestion CLI** – rebuild Story 2.4 pipeline with `pg` and Supabase RPC (WIP).
2. **Validation suite** – port legacy checks to Supabase views/tests.
3. **Fragments automation** – integrate InnerLens v1.1 fragment scoring directly in Supabase.
4. **Telemetry & observability** – store ingestion runs in `ingestion_batches` + dashboards.

Progress is tracked in `docs/mmos/epics/ROADMAP.md` (Story 2.4 follow-ups).

---

## Need Help?

- 📚 Schema reference: `docs/database/README.md`
- 🧪 Tests & migrations: `supabase/tests/`, `supabase/migrations/`
- 🤖 Ask `/db-sage` (Supabase context) for architectural guidance
- 📨 Database team on ClickUp / Discord (`#supabase-core`)

Supabase is now the canonical datastore—design new tooling with that assumption.***
