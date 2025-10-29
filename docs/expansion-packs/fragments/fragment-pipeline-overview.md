# Fragment Extraction Pipeline Overview

This document summarizes the four core tasks that compose the Fragments expansion pipeline and shows how they connect into a single end-to-end workflow aligned with the Supabase `fragments` table.

## Task Catalog

### 1. `prepare-run`
- **Goal:** Collect and validate all run parameters before extraction.
- **Key duties:**
  - Capture Supabase identifiers (`mind_id`, `source_id`, optional batch IDs).
  - Verify source document path, type, and language hints.
  - Load taxonomy resources and the category lookup table.
  - Emit `run_context.json` with normalized metadata for downstream reuse.

### 2. `extract-fragments`
- **Goal:** Use `@fragment-extractor` (Claude Sonnet 4) to segment raw text into MIUs.
- **Key duties:**
  - Load the run context and analyze the source document.
  - Build the LLM prompt embedding segmentation rules and zero-inference constraints.
  - Invoke the LLM and normalize the response into `fragments_raw.json`.
  - Generate audit artifacts (`prompt_extract.txt`, `fragments_raw_response.txt`, `fragments_raw_summary.md`).

### 3. `validate-fragment-batch`
- **Goal:** Apply MIU quality checks and Supabase schema validation.
- **Key duties:**
  - Load `fragments_raw.json` and the taxonomy lookup table.
  - Enforce MIU rules (completeness, attribution, zero-inference, length, duplicates).
  - Map taxonomy slugs to `category_id` and flag gaps.
  - Produce `fragments_validated.json` plus a human-readable report with warnings/action items.

### 4. `format-fragments-for-db`
- **Goal:** Generate Supabase-ready insertion payloads.
- **Key duties:**
  - Filter out invalid fragments (unless explicitly allowed).
  - Assemble rows matching the `fragments` table schema, including metadata JSONB.
  - Output `fragments_supabase.json`, optional `insert_fragments.sql`, and `format_summary.md`.

## End-to-End Workflow

```
prepare-run
   ↓ (run_context.json)
extract-fragments
   ↓ (fragments_raw.json)
validate-fragment-batch
   ↓ (fragments_validated.json)
format-fragments-for-db
   ↓
Supabase ingestion (manual or automated)
```

### Execution Notes
- All tasks operate inside `outputs/fragments/<mind_id>/<source_id>/` for traceability.
- Each handoff file (`run_context.json`, `fragments_raw.json`, `fragments_validated.json`, `fragments_supabase.json`) is versioned and auditable.
- Validation reports should be reviewed before inserting into Supabase, especially when warnings or invalid fragments are reported.
- The pipeline is deterministic when using temperature `0.0`, ensuring reproducible MIU boundaries.

### Suggested Command Flow
1. `prepare-run --mind <uuid> --source <uuid> --document <path>`
2. `extract-fragments --run-context outputs/.../run_context.json`
3. `validate-fragment-batch --input outputs/.../fragments_raw.json`
4. `format-fragments-for-db --input outputs/.../fragments_validated.json`
5. Optional: `supabase db remote commit` or custom ETL script to load the generated payload.

By following this sequence, teams ensure every fragment entering the Supabase database adheres to the MMOS v5.0 taxonomy, zero-inference principles, and the live schema contracts.
