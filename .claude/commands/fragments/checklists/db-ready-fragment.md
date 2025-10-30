# DB-Ready Fragment Checklist

Complete this checklist before formatting fragments for Supabase insertion.

## Required Fields
- [ ] `mind_id` (UUID) present in every fragment
- [ ] `source_id` (UUID) present and matches run context
- [ ] `category_id` resolved via taxonomy lookup
- [ ] `location` unique per `source_id`
- [ ] `type` one of (`direct_quote`, `paraphrase`, `description`, `example`, `pattern`, `anecdote`, `analysis`, `synthesis`)
- [ ] `relevance` integer between 0 and 10
- [ ] `content`, `context`, `insight` non-empty strings
- [ ] `metadata` JSONB includes taxonomy + structure + processing info

## Optional Fields (fill when available)
- [ ] `ingestion_batch_id` recorded for bulk jobs
- [ ] `generation_execution_id` references extraction job
- [ ] `metadata.confidence` contains score + rationale
- [ ] `metadata.tags` populated with snake_case taxonomy tags

## Consistency Checks
- [ ] Metadata taxonomy matches resolved `category_id`
- [ ] No duplicate fragments (hash of `content` + `location` unique)
- [ ] Warning list empty or acknowledged in `format_summary.md`
- [ ] Insights reflect fragment relevance without adding inference

## Final Verification
- [ ] `fragments_supabase.json` validated against schema
- [ ] (If generating SQL) `insert_fragments.sql` uses UPSERT with `(source_id, location)`
- [ ] `format_summary.md` reviewed and approved
