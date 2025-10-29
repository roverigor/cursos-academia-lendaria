-- =====================================================================
-- MMOS v5.0 DATABASE SCHEMA
-- Cognitive Clone Fragment Management System
-- =====================================================================
-- Version: 5.0
-- Last Updated: 2025-01-26
-- Database: PostgreSQL (recommended) / MySQL compatible
-- =====================================================================

-- Clean slate (use with caution in production)
-- DROP SCHEMA IF EXISTS mmos CASCADE;
-- CREATE SCHEMA mmos;
-- SET search_path TO mmos;

-- =====================================================================
-- 1. SOURCES TABLE
-- Stores all source materials (interviews, podcasts, books, etc.)
-- =====================================================================

CREATE TABLE sources (
    -- Primary identification
    id SERIAL PRIMARY KEY,
    source_code VARCHAR(50) UNIQUE NOT NULL, -- e.g., 'SRC_001', 'SRC_PODCAST_EP45'
    
    -- Basic metadata
    title VARCHAR(500) NOT NULL,
    source_type VARCHAR(50) NOT NULL CHECK (source_type IN (
        'interview', 'podcast', 'video', 'book', 'article', 
        'social_media', 'email', 'document', 'observation', 
        'conversation', 'presentation', 'workshop', 'webinar'
    )),
    quality VARCHAR(20) NOT NULL CHECK (quality IN ('primary', 'secondary', 'tertiary')),
    
    -- Source details
    author VARCHAR(255),
    url TEXT,
    source_date DATE,
    language VARCHAR(10) DEFAULT 'en',
    
    -- Content metadata
    duration_minutes INTEGER, -- for audio/video
    page_count INTEGER, -- for documents
    word_count INTEGER,
    file_path TEXT, -- local storage path
    file_hash VARCHAR(64), -- SHA-256 for deduplication
    
    -- Processing metadata
    extraction_priority VARCHAR(20) CHECK (extraction_priority IN 
        ('CRITICAL', 'VERY_HIGH', 'HIGH', 'MEDIUM', 'LOW')
    ),
    extraction_status VARCHAR(20) DEFAULT 'pending' CHECK (extraction_status IN 
        ('pending', 'in_progress', 'completed', 'reviewed', 'failed')
    ),
    
    -- Quality metrics (0.0 to 10.0)
    content_richness DECIMAL(3,1) CHECK (content_richness >= 0 AND content_richness <= 10),
    relevance_score DECIMAL(3,1) CHECK (relevance_score >= 0 AND relevance_score <= 10),
    clarity_score DECIMAL(3,1) CHECK (clarity_score >= 0 AND clarity_score <= 10),
    depth_score DECIMAL(3,1) CHECK (depth_score >= 0 AND depth_score <= 10),
    authenticity_score DECIMAL(3,1) CHECK (authenticity_score >= 0 AND authenticity_score <= 10),
    
    -- Tracking
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    
    -- Indexes for performance
    INDEX idx_source_type (source_type),
    INDEX idx_quality (quality),
    INDEX idx_extraction_status (extraction_status),
    INDEX idx_priority (extraction_priority),
    INDEX idx_created_at (created_at)
);

-- =====================================================================
-- 2. PROCESSING_BATCHES TABLE
-- Tracks each processing run (who, when, what model, what settings)
-- =====================================================================

CREATE TABLE processing_batches (
    id SERIAL PRIMARY KEY,
    batch_code VARCHAR(100) UNIQUE NOT NULL, -- e.g., 'BATCH_2025_01_26_001'
    
    -- Processing configuration
    model_provider VARCHAR(50) NOT NULL, -- 'openai', 'anthropic', 'google', etc.
    model_name VARCHAR(100) NOT NULL, -- 'gpt-4', 'claude-3', etc.
    model_version VARCHAR(50), -- specific version if applicable
    temperature DECIMAL(3,2) DEFAULT 0.7,
    max_tokens INTEGER,
    
    -- Processing metadata
    processor_name VARCHAR(255), -- who/what initiated this batch
    processing_type VARCHAR(50) DEFAULT 'extraction' CHECK (processing_type IN 
        ('extraction', 'enrichment', 'validation', 'synthesis', 're-extraction')
    ),
    
    -- Batch statistics
    total_sources INTEGER DEFAULT 0,
    total_fragments_generated INTEGER DEFAULT 0,
    successful_extractions INTEGER DEFAULT 0,
    failed_extractions INTEGER DEFAULT 0,
    
    -- Timing
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    processing_duration_minutes INTEGER GENERATED ALWAYS AS 
        (EXTRACT(EPOCH FROM (completed_at - started_at)) / 60) STORED,
    
    -- Cost tracking
    total_input_tokens INTEGER DEFAULT 0,
    total_output_tokens INTEGER DEFAULT 0,
    estimated_cost_usd DECIMAL(10,4),
    
    -- Status
    batch_status VARCHAR(20) DEFAULT 'running' CHECK (batch_status IN 
        ('queued', 'running', 'completed', 'failed', 'cancelled')
    ),
    error_message TEXT,
    
    -- Configuration snapshot (JSON)
    processing_config JSONB, -- Store prompts, rules, parameters
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    
    INDEX idx_batch_status (batch_status),
    INDEX idx_model (model_provider, model_name),
    INDEX idx_batch_created (created_at)
);

-- =====================================================================
-- 3. SOURCE_PROCESSING TABLE
-- Links sources to processing batches (many-to-many)
-- =====================================================================

CREATE TABLE source_processing (
    id SERIAL PRIMARY KEY,
    source_id INTEGER NOT NULL REFERENCES sources(id) ON DELETE CASCADE,
    batch_id INTEGER NOT NULL REFERENCES processing_batches(id) ON DELETE CASCADE,
    
    -- Processing details
    processing_status VARCHAR(20) DEFAULT 'pending' CHECK (processing_status IN 
        ('pending', 'processing', 'completed', 'failed', 'skipped')
    ),
    fragments_extracted INTEGER DEFAULT 0,
    
    -- Timing
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    processing_seconds INTEGER GENERATED ALWAYS AS 
        (EXTRACT(EPOCH FROM (completed_at - started_at))) STORED,
    
    -- Token usage for this specific source
    input_tokens INTEGER,
    output_tokens INTEGER,
    
    -- Quality metrics for this extraction
    extraction_quality_score DECIMAL(3,1), -- 0-10 score
    confidence_level DECIMAL(3,2), -- 0.00-1.00
    
    error_message TEXT,
    retry_count INTEGER DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(source_id, batch_id),
    INDEX idx_source_processing (source_id),
    INDEX idx_batch_processing (batch_id),
    INDEX idx_processing_status (processing_status)
);

-- =====================================================================
-- 4. FRAGMENTS TABLE
-- The actual extracted fragments with full MIU compliance
-- =====================================================================

CREATE TABLE fragments (
    id SERIAL PRIMARY KEY,
    fragment_code VARCHAR(50) UNIQUE NOT NULL, -- e.g., 'FRAG_BIO_001'
    
    -- Source linkage
    source_id INTEGER NOT NULL REFERENCES sources(id) ON DELETE CASCADE,
    batch_id INTEGER NOT NULL REFERENCES processing_batches(id),
    
    -- Fragment classification
    category VARCHAR(100) NOT NULL,
    fragment_type VARCHAR(50) NOT NULL CHECK (fragment_type IN (
        'direct_quote', 'paraphrase', 'description', 'example', 
        'pattern', 'anecdote', 'analysis', 'synthesis'
    )),
    
    -- Content
    content TEXT NOT NULL, -- The actual fragment text (MIU-compliant)
    location_in_source TEXT NOT NULL, -- Where in source this was found
    
    -- Interpretation
    context TEXT NOT NULL, -- Situational context
    insight TEXT NOT NULL, -- Key takeaway/interpretation
    
    -- Relevance and confidence
    relevance INTEGER NOT NULL CHECK (relevance >= 1 AND relevance <= 10),
    confidence DECIMAL(3,2) CHECK (confidence >= 0 AND confidence <= 1),
    
    -- Verification
    verified BOOLEAN DEFAULT FALSE,
    verified_by VARCHAR(255),
    verified_at TIMESTAMP,
    
    -- MIU compliance tracking
    is_complete BOOLEAN DEFAULT TRUE, -- Has all references resolved?
    has_clean_boundaries BOOLEAN DEFAULT TRUE, -- Properly segmented?
    
    -- Metadata
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Full-text search
    search_vector tsvector GENERATED ALWAYS AS (
        to_tsvector('english', 
            coalesce(content, '') || ' ' || 
            coalesce(context, '') || ' ' || 
            coalesce(insight, '')
        )
    ) STORED,
    
    INDEX idx_fragment_source (source_id),
    INDEX idx_fragment_batch (batch_id),
    INDEX idx_fragment_category (category),
    INDEX idx_fragment_type (fragment_type),
    INDEX idx_fragment_relevance (relevance),
    INDEX idx_fragment_search USING GIN (search_vector),
    INDEX idx_fragment_created (created_at)
);

-- =====================================================================
-- 5. FRAGMENT_TAGS TABLE
-- Many-to-many relationship for fragment tagging
-- =====================================================================

CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    tag_name VARCHAR(100) UNIQUE NOT NULL,
    tag_category VARCHAR(50), -- 'cognitive', 'behavioral', 'emotional', etc.
    usage_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_tag_name (tag_name),
    INDEX idx_tag_category (tag_category)
);

CREATE TABLE fragment_tags (
    fragment_id INTEGER NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
    tag_id INTEGER NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (fragment_id, tag_id),
    INDEX idx_fragment_tags (fragment_id),
    INDEX idx_tag_fragments (tag_id)
);

-- =====================================================================
-- 6. FRAGMENT_RELATIONSHIPS TABLE
-- Tracks relationships between fragments
-- =====================================================================

CREATE TABLE fragment_relationships (
    id SERIAL PRIMARY KEY,
    fragment_id INTEGER NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
    related_fragment_id INTEGER NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
    relationship_type VARCHAR(50) NOT NULL CHECK (relationship_type IN (
        'supports', 'contradicts', 'elaborates', 'evolves_from', 
        'related_to', 'depends_on', 'conflicts_with'
    )),
    confidence DECIMAL(3,2) DEFAULT 0.5,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(fragment_id, related_fragment_id, relationship_type),
    INDEX idx_fragment_rel (fragment_id),
    INDEX idx_related_fragment (related_fragment_id),
    INDEX idx_relationship_type (relationship_type)
);

-- =====================================================================
-- 7. MODEL_PERFORMANCE TABLE
-- Track model performance for optimization
-- =====================================================================

CREATE TABLE model_performance (
    id SERIAL PRIMARY KEY,
    model_provider VARCHAR(50) NOT NULL,
    model_name VARCHAR(100) NOT NULL,
    source_id INTEGER REFERENCES sources(id) ON DELETE SET NULL,
    batch_id INTEGER REFERENCES processing_batches(id) ON DELETE CASCADE,
    
    -- Performance metrics
    fragments_extracted INTEGER,
    extraction_quality_avg DECIMAL(3,1), -- Average quality score
    relevance_score_avg DECIMAL(3,1), -- Average relevance of fragments
    
    -- Cost efficiency
    cost_per_fragment DECIMAL(10,6),
    tokens_per_fragment DECIMAL(10,2),
    time_per_fragment_seconds DECIMAL(10,2),
    
    -- Comparison metrics
    baseline_model VARCHAR(100), -- What we're comparing against
    quality_delta DECIMAL(5,2), -- % difference in quality
    cost_delta DECIMAL(5,2), -- % difference in cost
    speed_delta DECIMAL(5,2), -- % difference in speed
    
    evaluation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    evaluator VARCHAR(255),
    notes TEXT,
    
    INDEX idx_model_perf (model_provider, model_name),
    INDEX idx_model_source (source_id),
    INDEX idx_model_batch (batch_id)
);

-- =====================================================================
-- 8. PROCESSING_QUEUE TABLE
-- Manage processing queue for sources
-- =====================================================================

CREATE TABLE processing_queue (
    id SERIAL PRIMARY KEY,
    source_id INTEGER NOT NULL REFERENCES sources(id) ON DELETE CASCADE,
    priority INTEGER DEFAULT 5 CHECK (priority >= 1 AND priority <= 10),
    processing_type VARCHAR(50) NOT NULL,
    scheduled_for TIMESTAMP,
    
    -- Queue management
    queue_status VARCHAR(20) DEFAULT 'waiting' CHECK (queue_status IN 
        ('waiting', 'processing', 'completed', 'failed', 'cancelled')
    ),
    attempts INTEGER DEFAULT 0,
    max_attempts INTEGER DEFAULT 3,
    
    -- Assignment
    assigned_to VARCHAR(255), -- Worker/processor ID
    assigned_at TIMESTAMP,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_queue_status (queue_status),
    INDEX idx_queue_priority (priority DESC, created_at ASC),
    INDEX idx_queue_source (source_id)
);

-- =====================================================================
-- 9. VIEWS FOR COMMON QUERIES
-- =====================================================================

-- View: Source processing summary
CREATE VIEW v_source_processing_summary AS
SELECT 
    s.id,
    s.source_code,
    s.title,
    s.source_type,
    s.quality,
    s.extraction_status,
    COUNT(DISTINCT sp.batch_id) as processing_runs,
    COUNT(DISTINCT f.id) as total_fragments,
    AVG(f.relevance) as avg_fragment_relevance,
    AVG(f.confidence) as avg_fragment_confidence,
    MAX(pb.completed_at) as last_processed
FROM sources s
LEFT JOIN source_processing sp ON s.id = sp.source_id
LEFT JOIN fragments f ON s.id = f.source_id
LEFT JOIN processing_batches pb ON sp.batch_id = pb.id
GROUP BY s.id;

-- View: Model comparison
CREATE VIEW v_model_comparison AS
SELECT 
    mp.model_provider,
    mp.model_name,
    COUNT(DISTINCT mp.source_id) as sources_processed,
    AVG(mp.fragments_extracted) as avg_fragments,
    AVG(mp.extraction_quality_avg) as avg_quality,
    AVG(mp.cost_per_fragment) as avg_cost_per_fragment,
    AVG(mp.time_per_fragment_seconds) as avg_time_per_fragment,
    MIN(mp.evaluation_date) as first_evaluation,
    MAX(mp.evaluation_date) as last_evaluation
FROM model_performance mp
GROUP BY mp.model_provider, mp.model_name
ORDER BY avg_quality DESC, avg_cost_per_fragment ASC;

-- View: Fragment coverage by category
CREATE VIEW v_fragment_coverage AS
SELECT 
    f.category,
    COUNT(*) as fragment_count,
    AVG(f.relevance) as avg_relevance,
    AVG(f.confidence) as avg_confidence,
    COUNT(DISTINCT f.source_id) as source_diversity,
    SUM(CASE WHEN f.verified THEN 1 ELSE 0 END) as verified_count
FROM fragments f
GROUP BY f.category
ORDER BY fragment_count DESC;

-- =====================================================================
-- 10. HELPER FUNCTIONS
-- =====================================================================

-- Function: Get next fragment code
CREATE OR REPLACE FUNCTION get_next_fragment_code(p_category VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
    v_prefix VARCHAR;
    v_next_num INTEGER;
    v_code VARCHAR;
BEGIN
    -- Map category to prefix
    v_prefix := CASE 
        WHEN p_category LIKE '%Biograph%' THEN 'BIO'
        WHEN p_category LIKE '%Cognitiv%' THEN 'COG'
        WHEN p_category LIKE '%Communicat%' THEN 'COM'
        WHEN p_category LIKE '%Behavior%' THEN 'BEH'
        WHEN p_category LIKE '%Value%' THEN 'VAL'
        WHEN p_category LIKE '%Social%' THEN 'SOC'
        WHEN p_category LIKE '%Emotion%' THEN 'EMO'
        WHEN p_category LIKE '%Meta%' THEN 'META'
        ELSE 'GEN'
    END;
    
    -- Get next number
    SELECT COALESCE(MAX(
        CAST(SUBSTRING(fragment_code FROM '[0-9]+$') AS INTEGER)
    ), 0) + 1
    INTO v_next_num
    FROM fragments
    WHERE fragment_code LIKE 'FRAG_' || v_prefix || '_%';
    
    -- Format code
    v_code := 'FRAG_' || v_prefix || '_' || LPAD(v_next_num::TEXT, 3, '0');
    
    RETURN v_code;
END;
$$ LANGUAGE plpgsql;

-- Function: Calculate source processing efficiency
CREATE OR REPLACE FUNCTION calculate_processing_efficiency(p_batch_id INTEGER)
RETURNS TABLE(
    efficiency_score DECIMAL,
    fragments_per_minute DECIMAL,
    cost_efficiency DECIMAL,
    quality_score DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ROUND(
            (pb.successful_extractions::DECIMAL / NULLIF(pb.total_sources, 0)) * 
            (1 - (pb.estimated_cost_usd / NULLIF(pb.total_fragments_generated, 0)::DECIMAL)) * 
            100, 2
        ) as efficiency_score,
        ROUND(
            pb.total_fragments_generated::DECIMAL / 
            NULLIF(pb.processing_duration_minutes, 0), 2
        ) as fragments_per_minute,
        ROUND(
            pb.total_fragments_generated::DECIMAL / 
            NULLIF(pb.estimated_cost_usd, 0), 2
        ) as cost_efficiency,
        ROUND(
            AVG(f.relevance * f.confidence), 2
        ) as quality_score
    FROM processing_batches pb
    LEFT JOIN fragments f ON f.batch_id = pb.id
    WHERE pb.id = p_batch_id
    GROUP BY pb.id;
END;
$$ LANGUAGE plpgsql;

-- =====================================================================
-- 11. TRIGGERS
-- =====================================================================

-- Trigger: Update source extraction status
CREATE OR REPLACE FUNCTION update_source_extraction_status()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE sources 
    SET extraction_status = 
        CASE 
            WHEN EXISTS (
                SELECT 1 FROM source_processing 
                WHERE source_id = NEW.source_id 
                AND processing_status = 'completed'
            ) THEN 'completed'
            WHEN EXISTS (
                SELECT 1 FROM source_processing 
                WHERE source_id = NEW.source_id 
                AND processing_status = 'processing'
            ) THEN 'in_progress'
            ELSE 'pending'
        END,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.source_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_source_status
AFTER INSERT OR UPDATE ON source_processing
FOR EACH ROW
EXECUTE FUNCTION update_source_extraction_status();

-- Trigger: Update batch statistics
CREATE OR REPLACE FUNCTION update_batch_statistics()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE processing_batches
    SET 
        total_fragments_generated = (
            SELECT COUNT(*) FROM fragments WHERE batch_id = NEW.batch_id
        ),
        successful_extractions = (
            SELECT COUNT(*) FROM source_processing 
            WHERE batch_id = NEW.batch_id AND processing_status = 'completed'
        ),
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.batch_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_batch_stats
AFTER INSERT OR UPDATE ON fragments
FOR EACH ROW
EXECUTE FUNCTION update_batch_statistics();

-- Trigger: Auto-update timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_sources_updated_at BEFORE UPDATE ON sources
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_fragments_updated_at BEFORE UPDATE ON fragments
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =====================================================================
-- 12. INDEXES FOR OPTIMIZATION
-- =====================================================================

-- Composite indexes for common queries
CREATE INDEX idx_fragments_source_category ON fragments(source_id, category);
CREATE INDEX idx_fragments_batch_relevance ON fragments(batch_id, relevance DESC);
CREATE INDEX idx_source_proc_composite ON source_processing(source_id, batch_id, processing_status);

-- Partial indexes for common filters
CREATE INDEX idx_pending_sources ON sources(id) WHERE extraction_status = 'pending';
CREATE INDEX idx_high_relevance_fragments ON fragments(id) WHERE relevance >= 8;
CREATE INDEX idx_unverified_fragments ON fragments(id) WHERE verified = FALSE;

-- =====================================================================
-- END OF SCHEMA
-- =====================================================================
