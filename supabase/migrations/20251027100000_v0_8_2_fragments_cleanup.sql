BEGIN;

-- Drop dependent view before altering columns
DROP VIEW IF EXISTS v_cost_per_fragment;

-- Remove legacy indexes that referenced layer/relevance_10
DROP INDEX IF EXISTS idx_frag_layer;
DROP INDEX IF EXISTS idx_frag_rel10;
DROP INDEX IF EXISTS idx_frag_mind_rel10_desc;
DROP INDEX IF EXISTS idx_frag_source_created;

-- Remove obsolete columns and replace score representation
ALTER TABLE fragments DROP COLUMN IF EXISTS layer;
ALTER TABLE fragments DROP COLUMN IF EXISTS relevance;
ALTER TABLE fragments ADD COLUMN IF NOT EXISTS relevance SMALLINT;

-- Backfill from legacy relevance_10 if still present
DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name   = 'fragments'
      AND column_name  = 'relevance_10'
  ) THEN
    EXECUTE 'UPDATE fragments SET relevance = COALESCE(relevance_10, 0)';
  END IF;
END
$$;

-- Ensure no NULLs remain before enforcing constraint
UPDATE fragments SET relevance = 0 WHERE relevance IS NULL;

ALTER TABLE fragments DROP CONSTRAINT IF EXISTS fragments_relevance_range;
ALTER TABLE fragments ALTER COLUMN relevance SET NOT NULL;
ALTER TABLE fragments ADD CONSTRAINT fragments_relevance_range CHECK (relevance BETWEEN 0 AND 10);

ALTER TABLE fragments DROP COLUMN IF EXISTS relevance_10;

-- Flexible metadata bucket for upcoming signals
ALTER TABLE fragments
  ADD COLUMN IF NOT EXISTS metadata JSONB NOT NULL DEFAULT '{}'::jsonb;

-- Rebuild indexes with new column name
CREATE INDEX IF NOT EXISTS idx_frag_relevance
  ON fragments (relevance);

CREATE INDEX IF NOT EXISTS idx_frag_mind_relevance_desc
  ON fragments (mind_id, relevance DESC)
  INCLUDE (id, content, created_at);

CREATE INDEX IF NOT EXISTS idx_frag_source_created
  ON fragments (source_id, created_at DESC)
  INCLUDE (id, content, relevance);

-- Restore cost view referencing canonical relevance column
CREATE OR REPLACE VIEW v_cost_per_fragment AS
SELECT
  f.id                 AS fragment_id,
  f.mind_id,
  f.source_id,
  f.relevance,
  je.llm_provider,
  je.llm_model,
  je.tokens_prompt,
  je.tokens_completion,
  je.tokens_total,
  je.cost_usd,
  je.latency_ms,
  pq.batch_id,
  je.created_at       AS executed_at
FROM fragments f
LEFT JOIN job_executions je ON je.id = f.generation_execution_id
LEFT JOIN processing_queue pq ON pq.id = je.queue_id;

COMMIT;

