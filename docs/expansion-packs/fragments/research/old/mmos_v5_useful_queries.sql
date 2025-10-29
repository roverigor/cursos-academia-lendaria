-- =====================================================================
-- MMOS v5.0 - Useful SQL Queries Collection
-- Practical queries for daily operations and optimization
-- =====================================================================

-- =====================================================================
-- 1. DAILY OPERATIONS
-- =====================================================================

-- Check today's processing status
SELECT 
    pb.batch_code,
    pb.model_name,
    pb.batch_status,
    pb.total_sources,
    pb.total_fragments_generated,
    pb.estimated_cost_usd,
    pb.processing_duration_minutes
FROM processing_batches pb
WHERE DATE(pb.started_at) = CURRENT_DATE
ORDER BY pb.started_at DESC;

-- View current queue
SELECT 
    pq.id,
    s.source_code,
    s.title,
    pq.priority,
    pq.queue_status,
    pq.attempts,
    pq.scheduled_for
FROM processing_queue pq
JOIN sources s ON pq.source_id = s.id
WHERE pq.queue_status IN ('waiting', 'processing')
ORDER BY pq.priority DESC, pq.created_at ASC;

-- Sources pending extraction
SELECT 
    s.id,
    s.source_code,
    s.title,
    s.source_type,
    s.quality,
    s.extraction_priority,
    s.created_at,
    CURRENT_DATE - DATE(s.created_at) as days_waiting
FROM sources s
WHERE s.extraction_status = 'pending'
ORDER BY 
    CASE s.extraction_priority
        WHEN 'CRITICAL' THEN 1
        WHEN 'VERY_HIGH' THEN 2
        WHEN 'HIGH' THEN 3
        WHEN 'MEDIUM' THEN 4
        WHEN 'LOW' THEN 5
    END,
    s.created_at;

-- =====================================================================
-- 2. MODEL OPTIMIZATION QUERIES
-- =====================================================================

-- Compare model performance for specific source type
SELECT 
    mp.model_name,
    COUNT(DISTINCT mp.source_id) as sources_tested,
    ROUND(AVG(mp.extraction_quality_avg), 2) as avg_quality,
    ROUND(AVG(mp.cost_per_fragment), 4) as avg_cost_per_frag,
    ROUND(AVG(mp.time_per_fragment_seconds), 2) as avg_time_seconds,
    ROUND(AVG(mp.fragments_extracted), 1) as avg_fragments,
    ROUND(AVG(mp.extraction_quality_avg) / AVG(mp.cost_per_fragment), 2) as quality_per_dollar
FROM model_performance mp
JOIN sources s ON mp.source_id = s.id
WHERE s.source_type = 'interview'  -- Change as needed
GROUP BY mp.model_name
ORDER BY quality_per_dollar DESC;

-- Find sweet spot for each source type
WITH model_stats AS (
    SELECT 
        s.source_type,
        mp.model_name,
        AVG(mp.extraction_quality_avg) as avg_quality,
        AVG(mp.cost_per_fragment) as avg_cost,
        COUNT(*) as test_count
    FROM model_performance mp
    JOIN sources s ON mp.source_id = s.id
    GROUP BY s.source_type, mp.model_name
    HAVING AVG(mp.extraction_quality_avg) >= 7.0  -- Quality threshold
),
ranked_models AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY source_type 
            ORDER BY avg_cost ASC
        ) as cost_rank
    FROM model_stats
)
SELECT 
    source_type,
    model_name as recommended_model,
    ROUND(avg_quality, 2) as quality_score,
    ROUND(avg_cost, 4) as cost_per_fragment,
    test_count as tests_performed
FROM ranked_models
WHERE cost_rank = 1
ORDER BY source_type;

-- Model cost savings analysis
WITH baseline AS (
    SELECT AVG(cost_per_fragment) as baseline_cost
    FROM model_performance
    WHERE model_name = 'gpt-4'
)
SELECT 
    mp.model_name,
    ROUND(AVG(mp.cost_per_fragment), 4) as avg_cost,
    ROUND(AVG(mp.extraction_quality_avg), 2) as avg_quality,
    ROUND((b.baseline_cost - AVG(mp.cost_per_fragment)) / b.baseline_cost * 100, 1) as savings_percent,
    ROUND((b.baseline_cost - AVG(mp.cost_per_fragment)) * 1000, 2) as savings_per_1k_fragments
FROM model_performance mp, baseline b
GROUP BY mp.model_name, b.baseline_cost
ORDER BY savings_percent DESC;

-- =====================================================================
-- 3. QUALITY ASSURANCE
-- =====================================================================

-- Low confidence fragments that need review
SELECT 
    f.fragment_code,
    f.category,
    f.relevance,
    f.confidence,
    s.source_code,
    s.title,
    f.content
FROM fragments f
JOIN sources s ON f.source_id = s.id
WHERE f.confidence < 0.5
    AND f.verified = FALSE
    AND f.relevance >= 7
ORDER BY f.relevance DESC, f.confidence ASC
LIMIT 50;

-- Find contradicting fragments
SELECT 
    f1.fragment_code as fragment_1,
    f2.fragment_code as fragment_2,
    f1.category,
    f1.content as content_1,
    f2.content as content_2,
    fr.confidence as contradiction_confidence
FROM fragment_relationships fr
JOIN fragments f1 ON fr.fragment_id = f1.id
JOIN fragments f2 ON fr.related_fragment_id = f2.id
WHERE fr.relationship_type = 'contradicts'
    AND fr.confidence > 0.7
ORDER BY fr.confidence DESC;

-- Category coverage analysis
WITH category_stats AS (
    SELECT 
        category,
        COUNT(*) as fragment_count,
        AVG(relevance) as avg_relevance,
        AVG(confidence) as avg_confidence,
        COUNT(DISTINCT source_id) as source_diversity,
        SUM(CASE WHEN verified THEN 1 ELSE 0 END) as verified_count
    FROM fragments
    GROUP BY category
),
expected_categories AS (
    SELECT unnest(ARRAY[
        'Biographical', 'Cognitive', 'Communicative',
        'Behavioral', 'Values and Beliefs', 'Social',
        'Emotional', 'Meta-cognitive'
    ]) as category
)
SELECT 
    e.category,
    COALESCE(c.fragment_count, 0) as fragments,
    COALESCE(ROUND(c.avg_relevance, 2), 0) as avg_relevance,
    COALESCE(ROUND(c.avg_confidence, 2), 0) as avg_confidence,
    COALESCE(c.source_diversity, 0) as sources,
    COALESCE(c.verified_count, 0) as verified,
    CASE 
        WHEN COALESCE(c.fragment_count, 0) = 0 THEN 'MISSING'
        WHEN COALESCE(c.fragment_count, 0) < 10 THEN 'CRITICAL'
        WHEN COALESCE(c.fragment_count, 0) < 25 THEN 'LOW'
        WHEN COALESCE(c.fragment_count, 0) < 50 THEN 'MODERATE'
        ELSE 'GOOD'
    END as coverage_status
FROM expected_categories e
LEFT JOIN category_stats c ON e.category = c.category
ORDER BY fragment_count ASC;

-- =====================================================================
-- 4. COST TRACKING
-- =====================================================================

-- Daily cost breakdown
SELECT 
    DATE(pb.started_at) as date,
    pb.model_provider,
    pb.model_name,
    COUNT(*) as batches,
    SUM(pb.total_fragments_generated) as fragments,
    ROUND(SUM(pb.estimated_cost_usd), 2) as total_cost,
    ROUND(AVG(pb.estimated_cost_usd), 2) as avg_batch_cost
FROM processing_batches pb
WHERE pb.started_at >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY DATE(pb.started_at), pb.model_provider, pb.model_name
ORDER BY date DESC, total_cost DESC;

-- Monthly cost trends
SELECT 
    DATE_TRUNC('month', pb.started_at) as month,
    SUM(pb.estimated_cost_usd) as total_cost,
    SUM(pb.total_fragments_generated) as total_fragments,
    ROUND(SUM(pb.estimated_cost_usd) / NULLIF(SUM(pb.total_fragments_generated), 0), 4) as avg_cost_per_fragment,
    COUNT(DISTINCT pb.model_name) as models_used,
    COUNT(DISTINCT sp.source_id) as sources_processed
FROM processing_batches pb
LEFT JOIN source_processing sp ON pb.id = sp.batch_id
WHERE pb.started_at >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY DATE_TRUNC('month', pb.started_at)
ORDER BY month DESC;

-- Cost per source quality level
SELECT 
    s.quality,
    COUNT(DISTINCT s.id) as source_count,
    SUM(pb.total_fragments_generated) as total_fragments,
    ROUND(SUM(pb.estimated_cost_usd), 2) as total_cost,
    ROUND(AVG(pb.estimated_cost_usd), 2) as avg_cost_per_source,
    ROUND(SUM(pb.estimated_cost_usd) / NULLIF(SUM(pb.total_fragments_generated), 0), 4) as cost_per_fragment
FROM sources s
JOIN source_processing sp ON s.id = sp.source_id
JOIN processing_batches pb ON sp.batch_id = pb.id
GROUP BY s.quality
ORDER BY 
    CASE s.quality
        WHEN 'primary' THEN 1
        WHEN 'secondary' THEN 2
        WHEN 'tertiary' THEN 3
    END;

-- =====================================================================
-- 5. PERFORMANCE METRICS
-- =====================================================================

-- Processing speed by model
SELECT 
    pb.model_name,
    COUNT(*) as batch_count,
    AVG(pb.processing_duration_minutes) as avg_duration_min,
    AVG(pb.total_fragments_generated) as avg_fragments,
    ROUND(AVG(pb.total_fragments_generated::NUMERIC / NULLIF(pb.processing_duration_minutes, 0)), 2) as fragments_per_minute,
    MIN(pb.processing_duration_minutes) as fastest_batch,
    MAX(pb.processing_duration_minutes) as slowest_batch
FROM processing_batches pb
WHERE pb.batch_status = 'completed'
    AND pb.processing_duration_minutes IS NOT NULL
GROUP BY pb.model_name
ORDER BY fragments_per_minute DESC;

-- Success rate by model
SELECT 
    pb.model_name,
    COUNT(*) as total_attempts,
    SUM(CASE WHEN pb.batch_status = 'completed' THEN 1 ELSE 0 END) as successful,
    SUM(CASE WHEN pb.batch_status = 'failed' THEN 1 ELSE 0 END) as failed,
    ROUND(
        SUM(CASE WHEN pb.batch_status = 'completed' THEN 1 ELSE 0 END)::NUMERIC / 
        COUNT(*) * 100, 2
    ) as success_rate
FROM processing_batches pb
GROUP BY pb.model_name
ORDER BY success_rate DESC;

-- Queue processing efficiency
SELECT 
    DATE(pq.created_at) as date,
    COUNT(*) as items_queued,
    SUM(CASE WHEN pq.queue_status = 'completed' THEN 1 ELSE 0 END) as completed,
    SUM(CASE WHEN pq.queue_status = 'failed' THEN 1 ELSE 0 END) as failed,
    SUM(CASE WHEN pq.queue_status = 'waiting' THEN 1 ELSE 0 END) as still_waiting,
    ROUND(AVG(pq.attempts), 2) as avg_attempts,
    ROUND(
        SUM(CASE WHEN pq.queue_status = 'completed' THEN 1 ELSE 0 END)::NUMERIC / 
        NULLIF(COUNT(*), 0) * 100, 2
    ) as completion_rate
FROM processing_queue pq
WHERE pq.created_at >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY DATE(pq.created_at)
ORDER BY date DESC;

-- =====================================================================
-- 6. FRAGMENT ANALYSIS
-- =====================================================================

-- Most common tags
SELECT 
    t.tag_name,
    t.tag_category,
    COUNT(ft.fragment_id) as usage_count,
    ROUND(AVG(f.relevance), 2) as avg_relevance,
    ROUND(AVG(f.confidence), 2) as avg_confidence
FROM tags t
JOIN fragment_tags ft ON t.id = ft.tag_id
JOIN fragments f ON ft.fragment_id = f.id
GROUP BY t.tag_name, t.tag_category
ORDER BY usage_count DESC
LIMIT 50;

-- High-value fragments (relevance >= 9)
SELECT 
    f.fragment_code,
    f.category,
    f.relevance,
    f.confidence,
    s.source_code,
    s.title,
    LEFT(f.content, 100) || '...' as content_preview,
    f.insight
FROM fragments f
JOIN sources s ON f.source_id = s.id
WHERE f.relevance >= 9
ORDER BY f.relevance DESC, f.confidence DESC
LIMIT 20;

-- Fragment distribution by type
SELECT 
    f.fragment_type,
    COUNT(*) as count,
    ROUND(AVG(f.relevance), 2) as avg_relevance,
    ROUND(AVG(f.confidence), 2) as avg_confidence,
    COUNT(DISTINCT f.source_id) as source_diversity
FROM fragments f
GROUP BY f.fragment_type
ORDER BY count DESC;

-- =====================================================================
-- 7. DATA QUALITY CHECKS
-- =====================================================================

-- Duplicate content detection
WITH duplicate_check AS (
    SELECT 
        content,
        COUNT(*) as duplicate_count,
        ARRAY_AGG(fragment_code) as fragment_codes,
        ARRAY_AGG(source_id) as source_ids
    FROM fragments
    GROUP BY content
    HAVING COUNT(*) > 1
)
SELECT 
    LEFT(content, 100) || '...' as content_preview,
    duplicate_count,
    fragment_codes,
    source_ids
FROM duplicate_check
ORDER BY duplicate_count DESC
LIMIT 20;

-- Incomplete fragments (potential MIU violations)
SELECT 
    f.fragment_code,
    f.category,
    s.source_code,
    LENGTH(f.content) as content_length,
    f.content
FROM fragments f
JOIN sources s ON f.source_id = s.id
WHERE 
    -- Check for potential incomplete references
    f.content LIKE '%there%' 
    OR f.content LIKE '%that%'
    OR f.content LIKE '%this%'
    OR f.content LIKE '%it%'
    AND LENGTH(f.content) < 100
ORDER BY LENGTH(f.content) ASC
LIMIT 50;

-- Sources with extraction anomalies
SELECT 
    s.id,
    s.source_code,
    s.title,
    COUNT(DISTINCT pb.id) as processing_attempts,
    MIN(pb.total_fragments_generated) as min_fragments,
    MAX(pb.total_fragments_generated) as max_fragments,
    ROUND(AVG(pb.total_fragments_generated), 1) as avg_fragments,
    ROUND(STDDEV(pb.total_fragments_generated), 2) as fragment_stddev
FROM sources s
JOIN source_processing sp ON s.id = sp.source_id
JOIN processing_batches pb ON sp.batch_id = pb.id
GROUP BY s.id
HAVING COUNT(DISTINCT pb.id) > 1
    AND STDDEV(pb.total_fragments_generated) > 10
ORDER BY fragment_stddev DESC;

-- =====================================================================
-- 8. MAINTENANCE QUERIES
-- =====================================================================

-- Table sizes and growth
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as total_size,
    pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) as table_size,
    pg_size_pretty(pg_indexes_size(schemaname||'.'||tablename)) as indexes_size,
    (SELECT COUNT(*) FROM pg_stat_user_tables WHERE schemaname||'.'||tablename = schemaname||'.'||tablename) as row_count
FROM pg_tables
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Slow queries (requires pg_stat_statements extension)
/*
SELECT 
    substring(query, 1, 100) as query_preview,
    calls,
    ROUND(total_exec_time::numeric, 2) as total_time_ms,
    ROUND(mean_exec_time::numeric, 2) as mean_time_ms,
    ROUND(stddev_exec_time::numeric, 2) as stddev_time_ms
FROM pg_stat_statements
WHERE query NOT LIKE '%pg_stat_statements%'
ORDER BY mean_exec_time DESC
LIMIT 20;
*/

-- Index usage statistics
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan as index_scans,
    idx_tup_read as tuples_read,
    idx_tup_fetch as tuples_fetched,
    pg_size_pretty(pg_relation_size(indexrelid)) as index_size
FROM pg_stat_user_indexes
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY idx_scan DESC;

-- =====================================================================
-- 9. REPORTING QUERIES
-- =====================================================================

-- Executive summary for the last 30 days
WITH summary AS (
    SELECT 
        COUNT(DISTINCT s.id) as sources_processed,
        COUNT(DISTINCT pb.id) as processing_runs,
        SUM(pb.total_fragments_generated) as total_fragments,
        ROUND(SUM(pb.estimated_cost_usd), 2) as total_cost,
        COUNT(DISTINCT pb.model_name) as models_tested
    FROM sources s
    JOIN source_processing sp ON s.id = sp.source_id
    JOIN processing_batches pb ON sp.batch_id = pb.id
    WHERE pb.started_at >= CURRENT_DATE - INTERVAL '30 days'
),
quality_stats AS (
    SELECT 
        ROUND(AVG(relevance), 2) as avg_relevance,
        ROUND(AVG(confidence), 2) as avg_confidence,
        SUM(CASE WHEN verified THEN 1 ELSE 0 END) as verified_fragments
    FROM fragments
    WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
)
SELECT 
    s.sources_processed,
    s.processing_runs,
    s.total_fragments,
    s.total_cost,
    s.models_tested,
    q.avg_relevance,
    q.avg_confidence,
    q.verified_fragments,
    ROUND(s.total_cost / NULLIF(s.total_fragments, 0), 4) as cost_per_fragment
FROM summary s, quality_stats q;

-- Weekly progress report
SELECT 
    DATE_TRUNC('week', pb.started_at) as week,
    COUNT(DISTINCT sp.source_id) as sources,
    COUNT(DISTINCT pb.id) as batches,
    SUM(pb.total_fragments_generated) as fragments,
    ROUND(SUM(pb.estimated_cost_usd), 2) as cost,
    ROUND(AVG(f.relevance), 2) as avg_relevance,
    ROUND(AVG(f.confidence), 2) as avg_confidence
FROM processing_batches pb
JOIN source_processing sp ON pb.id = sp.batch_id
LEFT JOIN fragments f ON pb.id = f.batch_id
WHERE pb.started_at >= CURRENT_DATE - INTERVAL '8 weeks'
GROUP BY DATE_TRUNC('week', pb.started_at)
ORDER BY week DESC;

-- =====================================================================
-- END OF QUERIES COLLECTION
-- =====================================================================
