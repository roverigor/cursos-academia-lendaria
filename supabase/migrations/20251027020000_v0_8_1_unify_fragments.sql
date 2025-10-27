-- =========================================================
-- v0.8.1 — Unified Fragments Schema (RAG-Ready)
-- =========================================================
-- Purpose: Extend fragments table to support both:
--   - Small atomic fragments (50-200 words)
--   - Large semantic chunks (500-1000 words)
--   - RAG/Vector search for LLM context
-- =========================================================

-- ==============
-- EXTEND FRAGMENTS TABLE
-- ==============

-- Add fields for KB chunks / larger fragments
ALTER TABLE fragments ADD COLUMN IF NOT EXISTS title TEXT;
ALTER TABLE fragments ADD COLUMN IF NOT EXISTS tags TEXT[];
ALTER TABLE fragments ADD COLUMN IF NOT EXISTS related_fragments TEXT[];
ALTER TABLE fragments ADD COLUMN IF NOT EXISTS word_count INT;
ALTER TABLE fragments ADD COLUMN IF NOT EXISTS metadata JSONB DEFAULT '{}'::jsonb;

-- Add vector embedding for RAG (OpenAI text-embedding-3-small: 1536 dimensions)
-- Note: Requires pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

ALTER TABLE fragments ADD COLUMN IF NOT EXISTS embedding vector(1536);

-- Make category_id optional (was NOT NULL in v0.7.0)
-- Reason: KB chunks don't always map to categories
ALTER TABLE fragments ALTER COLUMN category_id DROP NOT NULL;

-- Make source_id optional (some fragments are synthesized, not extracted)
ALTER TABLE fragments ALTER COLUMN source_id DROP NOT NULL;

-- Add computed column for easy filtering
ALTER TABLE fragments ADD COLUMN IF NOT EXISTS is_large_chunk BOOLEAN
  GENERATED ALWAYS AS (word_count > 400) STORED;

-- ==============
-- INDEXES FOR RAG PERFORMANCE
-- ==============

-- Vector similarity search (IVFFlat for cosine distance)
CREATE INDEX IF NOT EXISTS idx_fragments_embedding
  ON fragments USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);

-- Tag-based filtering
CREATE INDEX IF NOT EXISTS idx_fragments_tags
  ON fragments USING gin(tags);

-- Metadata queries
CREATE INDEX IF NOT EXISTS idx_fragments_metadata
  ON fragments USING gin(metadata);

-- Related fragments (chain retrieval)
CREATE INDEX IF NOT EXISTS idx_fragments_related
  ON fragments USING gin(related_fragments);

-- Word count filtering (small vs large)
CREATE INDEX IF NOT EXISTS idx_fragments_word_count
  ON fragments(word_count);

-- Type + mind composite (common query pattern)
CREATE INDEX IF NOT EXISTS idx_fragments_type_mind
  ON fragments(type, mind_id);

-- Layer + confidence (DNA Mental quality filtering)
CREATE INDEX IF NOT EXISTS idx_fragments_layer_confidence
  ON fragments(layer, confidence);

-- ==============
-- RAG SEARCH FUNCTION
-- ==============

-- Function: match_fragments
-- Purpose: Vector similarity search with metadata filtering
-- Usage: SELECT * FROM match_fragments(query_embedding, 'alan_nicolas', 0.75, 10)

CREATE OR REPLACE FUNCTION match_fragments(
  query_embedding vector(1536),
  filter_mind_slug text DEFAULT NULL,
  match_threshold float DEFAULT 0.75,
  match_count int DEFAULT 10,
  filter_min_layer int DEFAULT NULL,
  filter_min_confidence float DEFAULT NULL
)
RETURNS TABLE (
  id uuid,
  mind_id uuid,
  mind_slug text,
  type text,
  title text,
  content text,
  layer smallint,
  confidence numeric,
  tags text[],
  word_count int,
  related_fragments text[],
  similarity float
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    f.id,
    f.mind_id,
    m.slug as mind_slug,
    f.type,
    f.title,
    f.content,
    f.layer,
    f.confidence,
    f.tags,
    f.word_count,
    f.related_fragments,
    1 - (f.embedding <=> query_embedding) as similarity
  FROM fragments f
  INNER JOIN minds m ON m.id = f.mind_id
  WHERE
    f.embedding IS NOT NULL
    AND (filter_mind_slug IS NULL OR m.slug = filter_mind_slug)
    AND (filter_min_layer IS NULL OR f.layer >= filter_min_layer)
    AND (filter_min_confidence IS NULL OR f.confidence >= filter_min_confidence)
    AND 1 - (f.embedding <=> query_embedding) > match_threshold
  ORDER BY f.embedding <=> query_embedding
  LIMIT match_count;
END;
$$;

-- ==============
-- HYBRID SEARCH FUNCTION (Vector + Full-Text)
-- ==============

-- Function: hybrid_search_fragments
-- Purpose: Combines vector similarity with full-text search
-- Usage: SELECT * FROM hybrid_search_fragments(embedding, 'clareza valores', 'alan_nicolas', 10)

CREATE OR REPLACE FUNCTION hybrid_search_fragments(
  query_embedding vector(1536),
  query_text text,
  filter_mind_slug text DEFAULT NULL,
  match_count int DEFAULT 10,
  vector_weight float DEFAULT 0.7,  -- 70% vector, 30% full-text
  text_weight float DEFAULT 0.3
)
RETURNS TABLE (
  id uuid,
  mind_slug text,
  type text,
  title text,
  content text,
  layer smallint,
  confidence numeric,
  tags text[],
  word_count int,
  vector_score float,
  text_score float,
  hybrid_score float
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    f.id,
    m.slug as mind_slug,
    f.type,
    f.title,
    f.content,
    f.layer,
    f.confidence,
    f.tags,
    f.word_count,
    (1 - (f.embedding <=> query_embedding)) as vector_score,
    ts_rank(f.tsv, websearch_to_tsquery('portuguese', query_text)) as text_score,
    (
      vector_weight * (1 - (f.embedding <=> query_embedding)) +
      text_weight * ts_rank(f.tsv, websearch_to_tsquery('portuguese', query_text))
    ) as hybrid_score
  FROM fragments f
  INNER JOIN minds m ON m.id = f.mind_id
  WHERE
    f.embedding IS NOT NULL
    AND (filter_mind_slug IS NULL OR m.slug = filter_mind_slug)
  ORDER BY hybrid_score DESC
  LIMIT match_count;
END;
$$;

-- ==============
-- CHAIN RETRIEVAL FUNCTION
-- ==============

-- Function: get_fragment_chain
-- Purpose: Get fragment + all related fragments (recursive)
-- Usage: SELECT * FROM get_fragment_chain('fragment-uuid', 2)

CREATE OR REPLACE FUNCTION get_fragment_chain(
  start_fragment_id uuid,
  max_depth int DEFAULT 2
)
RETURNS TABLE (
  id uuid,
  type text,
  title text,
  content text,
  layer smallint,
  confidence numeric,
  word_count int,
  depth int
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  WITH RECURSIVE fragment_chain AS (
    -- Base case: starting fragment
    SELECT
      f.id,
      f.type,
      f.title,
      f.content,
      f.layer,
      f.confidence,
      f.word_count,
      0 as depth,
      f.related_fragments
    FROM fragments f
    WHERE f.id = start_fragment_id

    UNION ALL

    -- Recursive case: related fragments
    SELECT
      f.id,
      f.type,
      f.title,
      f.content,
      f.layer,
      f.confidence,
      f.word_count,
      fc.depth + 1,
      f.related_fragments
    FROM fragments f
    INNER JOIN fragment_chain fc ON f.id = ANY(fc.related_fragments)
    WHERE fc.depth < max_depth
  )
  SELECT
    fc.id,
    fc.type,
    fc.title,
    fc.content,
    fc.layer,
    fc.confidence,
    fc.word_count,
    fc.depth
  FROM fragment_chain fc
  ORDER BY fc.depth, fc.confidence DESC;
END;
$$;

-- ==============
-- HELPER VIEWS
-- ==============

-- View: fragments_with_minds
-- Purpose: Easy join with mind info
CREATE OR REPLACE VIEW fragments_with_minds AS
SELECT
  f.id,
  f.mind_id,
  m.slug as mind_slug,
  m.display_name as mind_name,
  f.source_id,
  f.type,
  f.title,
  f.content,
  f.layer,
  f.confidence,
  f.tags,
  f.word_count,
  f.is_large_chunk,
  f.related_fragments,
  f.metadata,
  f.created_at,
  f.updated_at
FROM fragments f
INNER JOIN minds m ON m.id = f.mind_id;

-- View: large_chunks_summary
-- Purpose: Quick stats on large semantic chunks
CREATE OR REPLACE VIEW large_chunks_summary AS
SELECT
  m.slug as mind_slug,
  COUNT(*) as chunk_count,
  AVG(f.word_count) as avg_word_count,
  SUM(f.word_count) as total_words,
  AVG(f.confidence) as avg_confidence,
  COUNT(f.embedding) as chunks_with_embeddings
FROM fragments f
INNER JOIN minds m ON m.id = f.mind_id
WHERE f.word_count > 400
GROUP BY m.slug
ORDER BY chunk_count DESC;

-- ==============
-- COMMENTS
-- ==============

COMMENT ON COLUMN fragments.title IS 'Optional: descriptive title for larger chunks (e.g., "Identity Core", "GPS Framework")';
COMMENT ON COLUMN fragments.tags IS 'Array of semantic tags for filtering and categorization';
COMMENT ON COLUMN fragments.related_fragments IS 'Array of fragment IDs for chain retrieval';
COMMENT ON COLUMN fragments.word_count IS 'Approximate word count (computed during insertion)';
COMMENT ON COLUMN fragments.metadata IS 'Flexible JSONB for additional metadata (chunk_id, priority, use_cases, etc.)';
COMMENT ON COLUMN fragments.embedding IS 'Vector embedding for RAG (1536d from OpenAI text-embedding-3-small)';
COMMENT ON COLUMN fragments.is_large_chunk IS 'Computed: TRUE if word_count > 400 (semantic chunk vs atomic fragment)';

COMMENT ON FUNCTION match_fragments IS 'Vector similarity search for RAG retrieval with optional filtering';
COMMENT ON FUNCTION hybrid_search_fragments IS 'Hybrid search combining vector similarity (70%) and full-text search (30%)';
COMMENT ON FUNCTION get_fragment_chain IS 'Recursive retrieval of fragment + all related fragments up to max_depth';

COMMENT ON VIEW fragments_with_minds IS 'Fragments joined with mind info for easy querying';
COMMENT ON VIEW large_chunks_summary IS 'Statistics on large semantic chunks (>400 words) per mind';

-- ==============
-- VALIDATION
-- ==============

DO $$
BEGIN
  -- Verify pgvector extension
  IF NOT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'vector') THEN
    RAISE EXCEPTION 'pgvector extension not installed - run: CREATE EXTENSION vector;';
  END IF;

  -- Verify columns added
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'fragments' AND column_name = 'embedding'
  ) THEN
    RAISE EXCEPTION 'embedding column not added to fragments table';
  END IF;

  RAISE NOTICE '✅ Unified fragments schema ready for RAG!';
  RAISE NOTICE '   - Vector embeddings: 1536 dimensions';
  RAISE NOTICE '   - Flexible size: 50-1000+ words';
  RAISE NOTICE '   - RAG functions: match_fragments, hybrid_search_fragments, get_fragment_chain';
END $$;
