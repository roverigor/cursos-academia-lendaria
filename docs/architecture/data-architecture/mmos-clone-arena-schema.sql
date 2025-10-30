-- ============================================================
-- CLONE ARENA DATABASE SCHEMA v1.0
-- Purpose: Social platform for cognitive clone debates
-- ============================================================

-- ============================================================
-- CORE TABLES
-- ============================================================

-- Users (platform users who create/watch debates)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    display_name VARCHAR(100),
    avatar_url TEXT,
    bio TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),

    -- Stats
    debates_created INTEGER DEFAULT 0,
    debates_watched INTEGER DEFAULT 0,
    followers_count INTEGER DEFAULT 0,
    following_count INTEGER DEFAULT 0,

    -- Preferences
    favorite_clone_id INTEGER,
    notification_preferences JSONB DEFAULT '{"email": true, "push": true}',

    -- Status
    is_active BOOLEAN DEFAULT true,
    is_verified BOOLEAN DEFAULT false,
    role VARCHAR(20) DEFAULT 'user' -- user, moderator, admin
);

CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at);

-- ============================================================

-- Clones (cognitive clones from minds repository)
CREATE TABLE clones (
    id SERIAL PRIMARY KEY,
    mind_name VARCHAR(100) UNIQUE NOT NULL, -- e.g., "sam_altman"
    display_name VARCHAR(100) NOT NULL,     -- e.g., "Sam Altman"
    version VARCHAR(20) NOT NULL,           -- e.g., "2.3"
    description TEXT,
    avatar_url TEXT,
    domain VARCHAR(50),                     -- e.g., "AI Safety", "Entrepreneurship"

    -- Metadata
    system_prompt_tokens INTEGER,
    kb_tokens INTEGER,
    fidelity_level DECIMAL(5,2),           -- e.g., 88.60
    last_validated TIMESTAMP,

    -- Stats (computed from debates)
    total_debates INTEGER DEFAULT 0,
    total_wins INTEGER DEFAULT 0,
    total_losses INTEGER DEFAULT 0,
    win_rate DECIMAL(5,2) DEFAULT 0.00,
    avg_score DECIMAL(5,2) DEFAULT 0.00,

    -- Rankings
    global_rank INTEGER,
    rank_updated_at TIMESTAMP,

    -- Status
    is_active BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),

    CONSTRAINT check_fidelity_range CHECK (fidelity_level >= 0 AND fidelity_level <= 100),
    CONSTRAINT check_win_rate_range CHECK (win_rate >= 0 AND win_rate <= 100)
);

CREATE INDEX idx_clones_mind_name ON clones(mind_name);
CREATE INDEX idx_clones_global_rank ON clones(global_rank);
CREATE INDEX idx_clones_win_rate ON clones(win_rate DESC);
CREATE INDEX idx_clones_total_debates ON clones(total_debates DESC);

-- ============================================================

-- Debate Frameworks (reusable debate structures)
CREATE TABLE debate_frameworks (
    id SERIAL PRIMARY KEY,
    framework_id VARCHAR(50) UNIQUE NOT NULL, -- e.g., "oxford_debate"
    name VARCHAR(100) NOT NULL,               -- e.g., "Oxford Debate"
    description TEXT,

    -- Configuration
    config JSONB NOT NULL, -- {rounds: 5, roles: ["proposer", "opposer"], ...}

    -- Scoring weights
    scoring_weights JSONB DEFAULT '{
        "framework_application": 0.25,
        "style_consistency": 0.20,
        "knowledge_depth": 0.20,
        "argument_coherence": 0.20,
        "personality_fidelity": 0.15
    }',

    -- Stats
    times_used INTEGER DEFAULT 0,
    avg_quality_rating DECIMAL(3,2) DEFAULT 0.00,

    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_frameworks_times_used ON debate_frameworks(times_used DESC);

-- ============================================================

-- Debates (individual debate sessions)
CREATE TABLE debates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Basic info
    title VARCHAR(255) NOT NULL,
    topic TEXT NOT NULL,
    framework_id INTEGER REFERENCES debate_frameworks(id),

    -- Participants
    clone1_id INTEGER REFERENCES clones(id),
    clone1_role VARCHAR(50), -- e.g., "proposer", "pro", "thesis"
    clone1_version VARCHAR(20),

    clone2_id INTEGER REFERENCES clones(id),
    clone2_role VARCHAR(50), -- e.g., "opposer", "con", "antithesis"
    clone2_version VARCHAR(20),

    -- Creator
    created_by UUID REFERENCES users(id),

    -- Execution
    status VARCHAR(20) DEFAULT 'pending', -- pending, running, completed, failed
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    duration_seconds INTEGER,

    -- Results
    transcript_path TEXT,
    winner_clone_id INTEGER REFERENCES clones(id),
    win_margin DECIMAL(5,2), -- Point difference

    -- Scores
    clone1_scores JSONB, -- {framework_application: 88, style_consistency: 92, ...}
    clone2_scores JSONB,
    clone1_overall_score DECIMAL(5,2),
    clone2_overall_score DECIMAL(5,2),

    -- Engagement
    view_count INTEGER DEFAULT 0,
    like_count INTEGER DEFAULT 0,
    comment_count INTEGER DEFAULT 0,
    share_count INTEGER DEFAULT 0,
    quality_rating DECIMAL(3,2) DEFAULT 0.00, -- User ratings (1-5)
    quality_votes INTEGER DEFAULT 0,

    -- Features
    is_featured BOOLEAN DEFAULT false,
    is_public BOOLEAN DEFAULT true,

    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_debates_status ON debates(status);
CREATE INDEX idx_debates_created_at ON debates(created_at DESC);
CREATE INDEX idx_debates_view_count ON debates(view_count DESC);
CREATE INDEX idx_debates_quality_rating ON debates(quality_rating DESC);
CREATE INDEX idx_debates_clone1 ON debates(clone1_id);
CREATE INDEX idx_debates_clone2 ON debates(clone2_id);
CREATE INDEX idx_debates_creator ON debates(created_by);
CREATE INDEX idx_debates_framework ON debates(framework_id);

-- ============================================================

-- Debate Rounds (individual rounds within a debate)
CREATE TABLE debate_rounds (
    id SERIAL PRIMARY KEY,
    debate_id UUID REFERENCES debates(id) ON DELETE CASCADE,
    round_number INTEGER NOT NULL,
    round_type VARCHAR(50), -- e.g., "opening", "rebuttal", "closing"

    -- Clone 1 contribution
    clone1_argument TEXT,
    clone1_tokens INTEGER,
    clone1_generation_time_ms INTEGER,

    -- Clone 2 contribution
    clone2_argument TEXT,
    clone2_tokens INTEGER,
    clone2_generation_time_ms INTEGER,

    -- Scoring (per round)
    clone1_round_score DECIMAL(5,2),
    clone2_round_score DECIMAL(5,2),

    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE(debate_id, round_number)
);

CREATE INDEX idx_rounds_debate ON debate_rounds(debate_id);

-- ============================================================

-- Comments (user comments on debates)
CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    debate_id UUID REFERENCES debates(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,

    -- Content
    content TEXT NOT NULL,
    parent_comment_id UUID REFERENCES comments(id), -- For threaded replies

    -- Engagement
    like_count INTEGER DEFAULT 0,
    reply_count INTEGER DEFAULT 0,

    -- Moderation
    is_edited BOOLEAN DEFAULT false,
    is_deleted BOOLEAN DEFAULT false,
    is_flagged BOOLEAN DEFAULT false,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_comments_debate ON comments(debate_id, created_at DESC);
CREATE INDEX idx_comments_user ON comments(user_id);
CREATE INDEX idx_comments_parent ON comments(parent_comment_id);

-- ============================================================

-- Votes (user votes on debates - who won?)
CREATE TABLE votes (
    id SERIAL PRIMARY KEY,
    debate_id UUID REFERENCES debates(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,

    voted_for_clone_id INTEGER REFERENCES clones(id),
    vote_type VARCHAR(20) DEFAULT 'winner', -- winner, quality
    vote_value INTEGER, -- For quality: 1-5 stars

    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE(debate_id, user_id, vote_type)
);

CREATE INDEX idx_votes_debate ON votes(debate_id);
CREATE INDEX idx_votes_user ON votes(user_id);

-- ============================================================

-- Follows (users following clones)
CREATE TABLE clone_follows (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    clone_id INTEGER REFERENCES clones(id) ON DELETE CASCADE,

    notification_enabled BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE(user_id, clone_id)
);

CREATE INDEX idx_follows_user ON clone_follows(user_id);
CREATE INDEX idx_follows_clone ON clone_follows(clone_id);

-- ============================================================

-- User Follows (users following other users)
CREATE TABLE user_follows (
    id SERIAL PRIMARY KEY,
    follower_id UUID REFERENCES users(id) ON DELETE CASCADE,
    following_id UUID REFERENCES users(id) ON DELETE CASCADE,

    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE(follower_id, following_id),
    CHECK (follower_id != following_id)
);

CREATE INDEX idx_user_follows_follower ON user_follows(follower_id);
CREATE INDEX idx_user_follows_following ON user_follows(following_id);

-- ============================================================

-- Topics (debate topics for categorization)
CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,

    -- Stats
    debate_count INTEGER DEFAULT 0,
    follower_count INTEGER DEFAULT 0,

    is_trending BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_topics_slug ON topics(slug);
CREATE INDEX idx_topics_trending ON topics(is_trending, debate_count DESC);

-- ============================================================

-- Debate Topics (many-to-many between debates and topics)
CREATE TABLE debate_topics (
    debate_id UUID REFERENCES debates(id) ON DELETE CASCADE,
    topic_id INTEGER REFERENCES topics(id) ON DELETE CASCADE,

    PRIMARY KEY (debate_id, topic_id)
);

CREATE INDEX idx_debate_topics_debate ON debate_topics(debate_id);
CREATE INDEX idx_debate_topics_topic ON debate_topics(topic_id);

-- ============================================================

-- Notifications (user notifications)
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,

    type VARCHAR(50) NOT NULL, -- debate_started, debate_completed, new_follower, etc.
    title VARCHAR(255) NOT NULL,
    message TEXT,
    link_url TEXT,

    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_notifications_user ON notifications(user_id, created_at DESC);
CREATE INDEX idx_notifications_unread ON notifications(user_id, is_read) WHERE is_read = false;

-- ============================================================
-- ANALYTICS TABLES
-- ============================================================

-- Clone Performance History (track evolution over time)
CREATE TABLE clone_performance_history (
    id SERIAL PRIMARY KEY,
    clone_id INTEGER REFERENCES clones(id),
    version VARCHAR(20),

    -- Snapshot date
    snapshot_date DATE NOT NULL,

    -- Metrics
    total_debates INTEGER,
    wins INTEGER,
    losses INTEGER,
    win_rate DECIMAL(5,2),
    avg_fidelity_score DECIMAL(5,2),

    -- Rankings
    global_rank INTEGER,
    rank_change INTEGER, -- +/- from previous snapshot

    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE(clone_id, snapshot_date)
);

CREATE INDEX idx_performance_clone_date ON clone_performance_history(clone_id, snapshot_date DESC);

-- ============================================================

-- User Activity Log (for analytics)
CREATE TABLE user_activity_log (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,

    activity_type VARCHAR(50) NOT NULL, -- view_debate, create_debate, comment, vote, etc.
    debate_id UUID REFERENCES debates(id) ON DELETE SET NULL,

    metadata JSONB, -- Additional context

    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_activity_user ON user_activity_log(user_id, created_at DESC);
CREATE INDEX idx_activity_type ON user_activity_log(activity_type);
CREATE INDEX idx_activity_created ON user_activity_log(created_at DESC);

-- Partition by month for scalability
CREATE TABLE user_activity_log_y2025m10 PARTITION OF user_activity_log
    FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');

-- ============================================================
-- VIEWS FOR COMMON QUERIES
-- ============================================================

-- Clone Leaderboard View
CREATE VIEW vw_clone_leaderboard AS
SELECT
    c.id,
    c.mind_name,
    c.display_name,
    c.version,
    c.total_debates,
    c.total_wins,
    c.total_losses,
    c.win_rate,
    c.avg_score,
    c.global_rank,
    c.fidelity_level,
    COUNT(DISTINCT cf.user_id) as follower_count,
    COUNT(DISTINCT d.id) FILTER (WHERE d.created_at > NOW() - INTERVAL '30 days') as debates_last_30d
FROM clones c
LEFT JOIN clone_follows cf ON c.id = cf.clone_id
LEFT JOIN debates d ON (c.id = d.clone1_id OR c.id = d.clone2_id)
WHERE c.is_active = true
GROUP BY c.id
ORDER BY c.global_rank ASC NULLS LAST;

-- ============================================================

-- Trending Debates View
CREATE VIEW vw_trending_debates AS
SELECT
    d.id,
    d.title,
    d.topic,
    d.status,
    d.created_at,
    d.view_count,
    d.like_count,
    d.comment_count,
    d.quality_rating,
    c1.display_name as clone1_name,
    c2.display_name as clone2_name,
    u.username as creator_username,
    -- Engagement score (weighted formula)
    (d.view_count * 1 + d.like_count * 5 + d.comment_count * 10 + d.quality_rating * 100) as engagement_score
FROM debates d
JOIN clones c1 ON d.clone1_id = c1.id
JOIN clones c2 ON d.clone2_id = c2.id
JOIN users u ON d.created_by = u.id
WHERE d.is_public = true
  AND d.status = 'completed'
  AND d.created_at > NOW() - INTERVAL '7 days'
ORDER BY engagement_score DESC
LIMIT 50;

-- ============================================================

-- User Stats View
CREATE VIEW vw_user_stats AS
SELECT
    u.id,
    u.username,
    u.display_name,
    u.debates_created,
    u.debates_watched,
    u.followers_count,
    u.following_count,
    COUNT(DISTINCT c.id) as total_comments,
    COUNT(DISTINCT v.id) as total_votes,
    AVG(d.quality_rating) as avg_debate_quality
FROM users u
LEFT JOIN comments c ON u.id = c.user_id AND c.is_deleted = false
LEFT JOIN votes v ON u.id = v.user_id
LEFT JOIN debates d ON u.id = d.created_by AND d.status = 'completed'
GROUP BY u.id;

-- ============================================================
-- TRIGGERS
-- ============================================================

-- Update clone stats after debate completion
CREATE OR REPLACE FUNCTION update_clone_stats_after_debate()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
        -- Update clone1
        UPDATE clones SET
            total_debates = total_debates + 1,
            total_wins = total_wins + CASE WHEN NEW.winner_clone_id = NEW.clone1_id THEN 1 ELSE 0 END,
            total_losses = total_losses + CASE WHEN NEW.winner_clone_id = NEW.clone2_id THEN 1 ELSE 0 END,
            avg_score = (avg_score * total_debates + NEW.clone1_overall_score) / (total_debates + 1),
            win_rate = (total_wins::DECIMAL + CASE WHEN NEW.winner_clone_id = NEW.clone1_id THEN 1 ELSE 0 END) / (total_debates + 1) * 100,
            updated_at = NOW()
        WHERE id = NEW.clone1_id;

        -- Update clone2
        UPDATE clones SET
            total_debates = total_debates + 1,
            total_wins = total_wins + CASE WHEN NEW.winner_clone_id = NEW.clone2_id THEN 1 ELSE 0 END,
            total_losses = total_losses + CASE WHEN NEW.winner_clone_id = NEW.clone1_id THEN 1 ELSE 0 END,
            avg_score = (avg_score * total_debates + NEW.clone2_overall_score) / (total_debates + 1),
            win_rate = (total_wins::DECIMAL + CASE WHEN NEW.winner_clone_id = NEW.clone2_id THEN 1 ELSE 0 END) / (total_debates + 1) * 100,
            updated_at = NOW()
        WHERE id = NEW.clone2_id;

        -- Update framework stats
        UPDATE debate_frameworks SET
            times_used = times_used + 1
        WHERE id = NEW.framework_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_clone_stats
AFTER UPDATE ON debates
FOR EACH ROW
EXECUTE FUNCTION update_clone_stats_after_debate();

-- ============================================================

-- Update user stats on follow
CREATE OR REPLACE FUNCTION update_follow_counts()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE users SET followers_count = followers_count + 1 WHERE id = NEW.following_id;
        UPDATE users SET following_count = following_count + 1 WHERE id = NEW.follower_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE users SET followers_count = followers_count - 1 WHERE id = OLD.following_id;
        UPDATE users SET following_count = following_count - 1 WHERE id = OLD.follower_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_user_follow_counts
AFTER INSERT OR DELETE ON user_follows
FOR EACH ROW
EXECUTE FUNCTION update_follow_counts();

-- ============================================================
-- INITIAL DATA
-- ============================================================

-- Insert default debate frameworks
INSERT INTO debate_frameworks (framework_id, name, description, config) VALUES
('oxford_debate', 'Oxford Debate', 'Classic pro/con format with opening statements, rebuttals, and closing arguments',
 '{"rounds": 5, "roles": ["proposer", "opposer"], "round_types": ["opening", "rebuttal", "rebuttal", "rebuttal", "closing"]}'),

('socratic_dialogue', 'Socratic Dialogue', 'Question-driven exploration to reveal deeper truths through inquiry',
 '{"rounds": 7, "roles": ["questioner", "responder"], "round_types": ["question", "answer", "question", "answer", "question", "answer", "synthesis"]}'),

('steel_man', 'Steel Man Debate', 'Each side presents the strongest version of the opponent''s argument before defending their own',
 '{"rounds": 4, "roles": ["advocate_a", "advocate_b"], "round_types": ["steel_man_opponent", "steel_man_opponent", "defend_own", "defend_own"]}'),

('devils_advocate', 'Devil''s Advocate', 'One clone proposes ideas while the other challenges every premise',
 '{"rounds": 6, "roles": ["proposer", "challenger"], "round_types": ["proposal", "challenge", "defense", "challenge", "defense", "synthesis"]}'),

('hegelian_dialectic', 'Hegelian Dialectic', 'Thesis, antithesis, synthesis approach to arrive at higher truth',
 '{"rounds": 3, "roles": ["thesis", "antithesis"], "round_types": ["thesis", "antithesis", "synthesis"]}');

-- ============================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================

-- Composite indexes for common queries
CREATE INDEX idx_debates_featured_recent ON debates(is_featured, created_at DESC) WHERE is_featured = true;
CREATE INDEX idx_debates_public_completed ON debates(is_public, status, created_at DESC) WHERE is_public = true AND status = 'completed';
CREATE INDEX idx_clones_active_rank ON clones(is_active, global_rank) WHERE is_active = true;

-- Full-text search indexes
CREATE INDEX idx_debates_title_trgm ON debates USING gin(title gin_trgm_ops);
CREATE INDEX idx_debates_topic_trgm ON debates USING gin(topic gin_trgm_ops);

-- ============================================================
-- COMMENTS
-- ============================================================

COMMENT ON TABLE debates IS 'Individual debate sessions between two cognitive clones';
COMMENT ON TABLE clones IS 'Cognitive clones loaded from minds repository with performance tracking';
COMMENT ON TABLE debate_frameworks IS 'Reusable debate structures (Oxford, Socratic, etc.)';
COMMENT ON TABLE users IS 'Platform users who create and watch debates';
COMMENT ON TABLE comments IS 'User comments on debates with threading support';
COMMENT ON TABLE votes IS 'User votes on debate winners and quality ratings';
COMMENT ON TABLE clone_performance_history IS 'Historical tracking of clone performance for analytics';

-- ============================================================
-- END OF SCHEMA
-- ============================================================
