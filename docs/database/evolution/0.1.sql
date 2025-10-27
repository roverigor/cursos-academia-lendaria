-- =========================================================
-- MMOS Database — KISS v1 + Operacional (PostgreSQL 16+)
-- =========================================================
-- Requisitos:
--   - Extensão pgcrypto para gen_random_uuid()
-- Observação:
--   - Usamos FTS nativo (to_tsvector); sem pg_trgm neste primeiro momento.

-- ==============
-- EXTENSIONS
-- ==============
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- =========================================================
-- ENTIDADES-BASE
-- =========================================================

-- 1) Mentes (quem estamos “upando”)
CREATE TABLE IF NOT EXISTS minds (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL,       -- ex: 'naval-ravikant'
  display_name TEXT NOT NULL,      -- ex: 'Naval Ravikant'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2) Lotes de ingestão/processamento (metadados LLM/pipeline)
CREATE TABLE IF NOT EXISTS ingestion_batches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pipeline_version TEXT NOT NULL,          -- ex: 'innerlens.v1.0'
  llm_provider TEXT,                       -- 'openai','anthropic','google',...
  llm_model TEXT,                          -- 'gpt-5','claude-4.1-sonnet',...
  llm_version TEXT,                        -- ex: '2025-10-10'
  prompt_hash TEXT,                        -- hash do prompt/orquestração
  params JSONB,                            -- extras (temperature, top_p, seed, etc.)
  created_by TEXT,                         -- operador/agente
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 3) Fontes (timeline)
CREATE TABLE IF NOT EXISTS sources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  type TEXT NOT NULL,                      -- 'book','podcast','interview',...
  author TEXT,
  published_date DATE NOT NULL,
  url TEXT,
  language TEXT CHECK (char_length(language)=2),
  quality TEXT NOT NULL,                   -- 'primary','secondary','tertiary'
  publisher TEXT,
  isbn TEXT,
  page_count INT,
  duration TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_sources_published_date ON sources (published_date);
CREATE INDEX IF NOT EXISTS idx_sources_type           ON sources (type);
CREATE INDEX IF NOT EXISTS idx_sources_author         ON sources (author);

-- 4) Categorias (lookup)
CREATE TABLE IF NOT EXISTS categories (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,               -- 'COG','BIO','VAL',...
  name TEXT NOT NULL,
  description TEXT
);

-- =========================================================
-- NÚCLEO: FRAGMENTS
-- =========================================================
CREATE TABLE IF NOT EXISTS fragments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  mind_id UUID NOT NULL REFERENCES minds(id) ON DELETE RESTRICT,
  source_id UUID NOT NULL REFERENCES sources(id) ON DELETE RESTRICT,
  category_id BIGINT NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
  ingestion_batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,

  layer SMALLINT,                                        -- 0..8 (opcional)
  location TEXT NOT NULL,
  type TEXT NOT NULL,                                    -- 'direct_quote','framework','principle',...

  -- Relevância em décimos (0..10) + coluna derivada 0.0..1.0
  relevance_10 SMALLINT NOT NULL CHECK (relevance_10 BETWEEN 0 AND 10),
  relevance NUMERIC(2,1) GENERATED ALWAYS AS (relevance_10/10.0) STORED,

  content TEXT NOT NULL,
  context TEXT NOT NULL,
  insight TEXT NOT NULL,

  -- Execução que gerou este fragmento (para métricas de tokens/custo)
  generation_execution_id UUID,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  UNIQUE (source_id, location),

  CONSTRAINT fk_frag_generation_exec
    FOREIGN KEY (generation_execution_id) REFERENCES job_executions(id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
);
-- Observação: a FK acima referencia job_executions que será criada mais abaixo.
-- Em PostgreSQL é permitido definir a FK depois; aqui marcamos DEFERRABLE para facilitar carga inicial.

-- FTS (coluna gerada) + índice GIN
ALTER TABLE fragments
  ADD COLUMN IF NOT EXISTS tsv tsvector;
-- Recria a expressão gerada se coluna não estiver definida como gerada
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name='fragments' AND column_name='tsv' AND is_generated='NEVER'
  ) THEN
    ALTER TABLE fragments DROP COLUMN tsv;
    ALTER TABLE fragments
      ADD COLUMN tsv tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('simple', coalesce(content,'')), 'A') ||
        setweight(to_tsvector('simple', coalesce(context,'')), 'B') ||
        setweight(to_tsvector('simple', coalesce(insight,'')), 'C')
      ) STORED;
  ELSIF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name='fragments' AND column_name='tsv'
  ) THEN
    ALTER TABLE fragments
      ADD COLUMN tsv tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('simple', coalesce(content,'')), 'A') ||
        setweight(to_tsvector('simple', coalesce(context,'')), 'B') ||
        setweight(to_tsvector('simple', coalesce(insight,'')), 'C')
      ) STORED;
  END IF;
END$$;

CREATE INDEX IF NOT EXISTS idx_frag_tsv     ON fragments USING GIN (tsv);
CREATE INDEX IF NOT EXISTS idx_frag_mind    ON fragments (mind_id);
CREATE INDEX IF NOT EXISTS idx_frag_source  ON fragments (source_id);
CREATE INDEX IF NOT EXISTS idx_frag_category ON fragments (category_id);
CREATE INDEX IF NOT EXISTS idx_frag_rel10   ON fragments (relevance_10);
CREATE INDEX IF NOT EXISTS idx_frag_type    ON fragments (type);
CREATE INDEX IF NOT EXISTS idx_frag_layer   ON fragments (layer);

-- =========================================================
-- TAGGING
-- =========================================================
CREATE TABLE IF NOT EXISTS tags (
  id BIGSERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,               -- case-sensitive
  tag_type TEXT NOT NULL,                  -- 'domain','theme'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_tags_type ON tags (tag_type);

CREATE TABLE IF NOT EXISTS fragment_tags (
  fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  tag_id BIGINT NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (fragment_id, tag_id)
);
CREATE INDEX IF NOT EXISTS idx_ft_tag   ON fragment_tags (tag_id) INCLUDE (fragment_id);
CREATE INDEX IF NOT EXISTS idx_ft_frag  ON fragment_tags (fragment_id) INCLUDE (tag_id);

-- =========================================================
-- RELACIONAMENTOS ENTRE FRAGMENTS
-- =========================================================
-- Regra: 'related' é NÃO-dirigido (canônico); 'supports'/'contradicts' são dirigidos (A→B)
CREATE TABLE IF NOT EXISTS fragment_relationships (
  from_fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  to_fragment_id   UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  relationship_type TEXT NOT NULL DEFAULT 'related',      -- 'related','supports','contradicts'
  PRIMARY KEY (from_fragment_id, to_fragment_id),
  CHECK (from_fragment_id <> to_fragment_id)
);
CREATE INDEX IF NOT EXISTS idx_rel_from ON fragment_relationships (from_fragment_id);
CREATE INDEX IF NOT EXISTS idx_rel_to   ON fragment_relationships (to_fragment_id);
CREATE INDEX IF NOT EXISTS idx_rel_type ON fragment_relationships (relationship_type);

-- Evita duplicidade A–B / B–A só para 'related'
CREATE UNIQUE INDEX IF NOT EXISTS ux_related_canonical
  ON fragment_relationships (
    LEAST(from_fragment_id, to_fragment_id),
    GREATEST(from_fragment_id, to_fragment_id)
  )
  WHERE relationship_type = 'related';

-- =========================================================
-- MÓDULO OPERACIONAL (fila → execuções → métricas)
-- =========================================================

-- 1) FILA
CREATE TABLE IF NOT EXISTS processing_queue (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  batch_id UUID REFERENCES ingestion_batches(id) ON DELETE SET NULL,
  job_type TEXT NOT NULL,        -- 'ingest_source','chunk','extract_fragments','enrich',...
  scope_type TEXT NOT NULL,      -- 'source','mind','url','file','fragment'
  scope_id UUID,                 -- id alvo (sources.id, minds.id, etc.)
  priority SMALLINT NOT NULL DEFAULT 5 CHECK (priority BETWEEN 1 AND 9),
  status TEXT NOT NULL DEFAULT 'queued',    -- 'queued','running','done','error','retry'
  attempts SMALLINT NOT NULL DEFAULT 0,
  scheduled_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  started_at TIMESTAMPTZ,
  finished_at TIMESTAMPTZ,
  last_error TEXT
);
CREATE INDEX IF NOT EXISTS idx_pq_status_prio ON processing_queue (status, priority, scheduled_at);
CREATE INDEX IF NOT EXISTS idx_pq_batch       ON processing_queue (batch_id);
CREATE INDEX IF NOT EXISTS idx_pq_scope       ON processing_queue (scope_type, scope_id);

-- 2) EXECUÇÕES (uma linha por tentativa)
CREATE TABLE IF NOT EXISTS job_executions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  queue_id UUID NOT NULL REFERENCES processing_queue(id) ON DELETE CASCADE,

  -- LLM efetivamente usado nesta tentativa
  llm_provider TEXT,          -- 'anthropic','openai','google',...
  llm_model TEXT,             -- 'claude-4.1-sonnet','gpt-5','gemini-2.5',...
  llm_version TEXT,           -- ex: '2025-10-10'
  params JSONB,               -- temperature, top_p, seed, etc.

  -- MÉTRICAS
  tokens_prompt INT,
  tokens_completion INT,
  tokens_total INT GENERATED ALWAYS AS (
    COALESCE(tokens_prompt,0) + COALESCE(tokens_completion,0)
  ) STORED,
  cost_usd NUMERIC(12,6),
  latency_ms INT,
  input_bytes INT,
  output_bytes INT,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_exec_queue   ON job_executions (queue_id);
CREATE INDEX IF NOT EXISTS idx_exec_created ON job_executions (created_at);
CREATE INDEX IF NOT EXISTS idx_exec_model   ON job_executions (llm_provider, llm_model);

-- Agora que job_executions existe, ajusta a FK de fragments (se necessário)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.table_constraints tc
    WHERE tc.table_name='fragments' AND tc.constraint_name='fk_frag_generation_exec'
  ) THEN
    ALTER TABLE fragments
      ADD CONSTRAINT fk_frag_generation_exec
      FOREIGN KEY (generation_execution_id) REFERENCES job_executions(id) ON DELETE SET NULL;
  END IF;
END$$;

-- =========================================================
-- TRIGGERS updated_at (simples)
-- =========================================================
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger AS $$
BEGIN NEW.updated_at := now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_minds_updated') THEN
    CREATE TRIGGER trg_minds_updated BEFORE UPDATE ON minds
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_sources_updated') THEN
    CREATE TRIGGER trg_sources_updated BEFORE UPDATE ON sources
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_fragments_updated') THEN
    CREATE TRIGGER trg_fragments_updated BEFORE UPDATE ON fragments
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='trg_tags_updated') THEN
    CREATE TRIGGER trg_tags_updated BEFORE UPDATE ON tags
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END$$;

-- =========================================================
-- FUNÇÕES UTILITÁRIAS
-- =========================================================
-- Snap de score para décimos (≥ 0,08 sobe o dígito)
CREATE OR REPLACE FUNCTION snap_to_tenth(score NUMERIC)
RETURNS SMALLINT
LANGUAGE plpgsql IMMUTABLE AS $$
DECLARE
  t NUMERIC := score * 10;  i INT := floor(t);  r NUMERIC := t - i;
BEGIN
  IF score <= 0 THEN RETURN 0; END IF;
  IF score >= 1 THEN RETURN 10; END IF;
  IF r >= 0.8 THEN RETURN LEAST(i+1,10); ELSE RETURN GREATEST(i,0); END IF;
END $$;

-- =========================================================
-- VIEWS DE CONTROLE/MÉTRICA
-- =========================================================

-- A) Custo/tokens por fragmento
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

-- B) Agregado por lote/modelo
CREATE OR REPLACE VIEW v_batch_costs AS
SELECT
  pq.batch_id,
  je.llm_provider,
  je.llm_model,
  COUNT(DISTINCT f.id)                 AS fragments_generated,
  SUM(je.tokens_total)                 AS tokens_total,
  SUM(je.cost_usd)                     AS cost_total_usd,
  AVG(je.latency_ms)                   AS avg_latency_ms,
  MIN(je.created_at)                   AS first_exec_at,
  MAX(je.created_at)                   AS last_exec_at
FROM job_executions je
JOIN processing_queue pq ON pq.id = je.queue_id
LEFT JOIN fragments f ON f.generation_execution_id = je.id
GROUP BY pq.batch_id, je.llm_provider, je.llm_model;