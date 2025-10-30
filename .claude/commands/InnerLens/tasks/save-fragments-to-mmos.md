# Task: Save Fragments to Supabase Database

**Task ID:** save-fragments-to-mmos  
**Agent:** @data-integrator (or manual execution)  
**Version:** 2.0.0  
**Dependencies:** MIU `fragments.json`, Supabase connection (`SUPABASE_DB_URL`)

---

## Purpose

Persist InnerLens MIU fragments into the Supabase production database so that MMOS, CreatorOS and future expansion packs share the same evidence trail.

**Why It Matters**
- MIUs become canonical evidence for traits, skills and personas
- Supabase guarantees auditability (sources → fragments → profiles)
- Downstream systems (MMOS, CreatorOS) can reuse the data immediately

---

## Inputs

| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `mind_slug` | string | ✅ | Mind identifier (slug) | `"alan_nicolas"` |
| `fragments_file` | path | ✅ | Path to MIU JSON file | `"testing/results/alan_fragments.json"` |
| `source_file` | path | ✅ | Path to source text | `"testing/data/alan_text.txt"` |
| `source_title` | string | ✅ | Human readable title | `"Estilo Escrita Provocativa"` |
| `source_type` | enum | ✅ | Source type (`self_analysis`, `blog_post`, `podcast_transcript`, …) |

---

## Preconditions

- [ ] `.env` (or environment) exports `SUPABASE_DB_URL` with service-role key and `sslmode=require`
- [ ] Python deps installed: `pip install -r expansion-packs/innerlens/requirements.txt`
- [ ] Fragments JSON validated (`python -m json.tool {file}`)
- [ ] Source file accessible and UTF-8 encoded

---

## Steps

### 1. Prepare Environment

```bash
source .env
cd expansion-packs/innerlens/scripts
```

### 2. Execute Supabase Saver

```bash
python save_fragments_to_supabase.py \
  --mind "$mind_slug" \
  --fragments "$fragments_file" \
  --source "$source_file" \
  --title "$source_title" \
  --type "$source_type"
```

**Script Responsibilities**
1. Fetch/create mind in Supabase (`minds` table)
2. Create/update source entry (`sources` table)
3. Insert MIU fragments into `fragments` with JSONB metadata
4. Commit in batches, logging progress

### 3. Validate Results

```bash
psql "$SUPABASE_DB_URL" \
  -c "SELECT COUNT(*) FROM fragments WHERE metadata->>'fragment_id' LIKE 'f_${mind_slug}_%';"
```

Expected count matches fragment total in JSON file.

---

## Failure Recovery

| Failure | Cause | Resolution |
|---------|-------|------------|
| Authentication failure | Invalid or missing `SUPABASE_DB_URL` | Re-source `.env`, confirm credentials |
| Duplicate fragments skipped | Records already persisted | Confirm counts; the script is idempotent |
| Source insert conflict | Title already used for the mind | Provide unique title or append suffix |

---

## Outputs Checklist

- [ ] `minds` table contains/updated `mind_slug`
- [ ] `sources` table has corresponding source row
- [ ] `fragments` table stores MIUs with metadata
- [ ] Verification query returns expected count

---

## References

- Script: `expansion-packs/innerlens/scripts/save_fragments_to_supabase.py`
- Workflow: `expansion-packs/innerlens/workflows/extract-analyze-save.md`
- Supabase schema docs: `docs/database/README.md`
