# CreatorOS - Unified Database Integration Design

**Product:** CreatorOS (AIOS CreatorOS - The Operating System for Digital Creators)
**Version:** 2.0.0
**Date:** 2025-10-27 (Originally: 2025-10-14)
**Author:** Academia Lendar[IA] (Alan Nicolas)
**Status:** Implemented (Schema defined and tables created)

---

## Executive Summary

CreatorOS will integrate with the existing unified database (`outputs/database/mmos.db`) to:
1. **Store content projects, campaigns, and generated pieces** with full traceability
2. **Track performance metrics** and learning loops
3. **Link content to minds** (MMOS clones as personas)
4. **Index content frameworks** (pedagogical, storytelling, marketing)
5. **Enable systematic content recommendation** ("Best mind for copywriting blog post")

This document defines the database schema extension, integration points, and the **Project Manager Agent** that orchestrates everything.

---

## Database Schema Extension

### New Tables for CreatorOS

```sql
-- ═══════════════════════════════════════════════════════════
-- CONTENT FRAMEWORKS (Pedagogical, Storytelling, Marketing)
-- ═══════════════════════════════════════════════════════════

CREATE TABLE content_frameworks (
  id TEXT PRIMARY KEY, -- 'blooms_taxonomy', 'hero_journey', 'aida'
  name TEXT NOT NULL, -- 'Bloom''s Taxonomy', 'Hero''s Journey', 'AIDA'
  category TEXT NOT NULL CHECK(category IN (
    'pedagogical',      -- Learning frameworks (Bloom, ADDIE, Kolb)
    'storytelling',     -- Narrative structures (Hero's Journey, Case Study)
    'marketing',        -- Marketing frameworks (AIDA, PAS, 4Ps)
    'seo',              -- SEO best practices
    'readability',      -- Readability standards (Flesch-Kincaid)
    'other'
  )),
  description TEXT NOT NULL,

  -- Framework Structure
  structure TEXT NOT NULL, -- JSON: Framework components
  -- Example Bloom: {"levels": ["Remember", "Understand", "Apply", "Analyze", "Evaluate", "Create"]}
  -- Example AIDA: {"stages": ["Attention", "Interest", "Desire", "Action"]}

  -- Application
  applicable_formats TEXT, -- JSON array: ["blog", "course", "social", "video"]
  usage_guidelines TEXT, -- Markdown: How to apply this framework

  -- Examples
  example_applications TEXT, -- JSON: Real examples using this framework

  -- References
  source_citation TEXT, -- Academic/industry reference
  source_url TEXT,

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  version TEXT DEFAULT '1.0'
);

CREATE INDEX idx_frameworks_category ON content_frameworks(category);

-- ═══════════════════════════════════════════════════════════
-- CONTENT PROJECTS (Workspace for content creation)
-- ═══════════════════════════════════════════════════════════

CREATE TABLE content_projects (
  id TEXT PRIMARY KEY, -- UUID: 'proj_a3f2b1c4-...'

  -- Identity
  project_slug TEXT NOT NULL UNIQUE, -- 'academia-lendaria-blog'
  display_name TEXT NOT NULL, -- 'Academia Lendária Blog'
  description TEXT,

  -- Owner
  owner_user_id TEXT, -- User ID (future: multi-user support)
  owner_mind_id INTEGER REFERENCES minds(id), -- If project belongs to a mind

  -- Default Configuration
  default_persona_id INTEGER REFERENCES minds(id), -- Default writer persona
  default_audience_profile_id TEXT REFERENCES audience_profiles(id), -- Default reader ICP

  -- Content Strategy
  content_goals TEXT, -- JSON array: ["thought_leadership", "lead_generation", "education"]
  target_frequency TEXT, -- '3 posts/week', '1 course/month'

  -- Status
  status TEXT DEFAULT 'active' CHECK(status IN (
    'active', 'paused', 'completed', 'archived'
  )),

  -- Statistics (computed)
  total_pieces_generated INTEGER DEFAULT 0,
  total_pieces_published INTEGER DEFAULT 0,
  avg_performance_score REAL, -- 0.0-1.0 (engagement, conversion)

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT -- Soft delete
);

CREATE INDEX idx_projects_owner ON content_projects(owner_mind_id);
CREATE INDEX idx_projects_status ON content_projects(status);
CREATE INDEX idx_projects_deleted ON content_projects(deleted_at) WHERE deleted_at IS NULL;

-- ═══════════════════════════════════════════════════════════
-- AUDIENCE PROFILES (ICP for content targeting)
-- ═══════════════════════════════════════════════════════════

CREATE TABLE audience_profiles (
  id TEXT PRIMARY KEY, -- UUID: 'aud_a3f2b1c4-...'
  project_id TEXT NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,

  -- Identity
  profile_slug TEXT NOT NULL, -- 'tech-founders', 'corporate-leaders'
  display_name TEXT NOT NULL, -- 'Tech Founders Brasileiros'
  description TEXT,

  -- Demographics
  demographics TEXT, -- JSON: {"age_range": "28-45", "location": ["Brasil", "Portugal"]}

  -- Psychographics (optional InnerLens integration)
  psychographic_profile_id TEXT, -- Link to InnerLens psychometric profile (future)
  big_five_scores TEXT, -- JSON: {"openness": 85, "conscientiousness": 72, ...}
  values TEXT, -- JSON array: ["autonomy", "impact", "continuous_learning"]
  pain_points TEXT, -- JSON array: ["time_scarcity", "complex_decisions"]
  goals TEXT, -- JSON array: ["scale_startup", "lead_better", "learn_fast"]

  -- Content Preferences
  tone_preference TEXT, -- 'conversational_deep', 'formal_academic', 'casual_friendly'
  complexity_preference TEXT CHECK(complexity_preference IN (
    'simple', 'moderate', 'high'
  )),
  length_preference TEXT, -- 'short_form', 'long_form', 'mixed'
  format_preferences TEXT, -- JSON array: ["blog", "newsletter", "twitter_threads"]

  -- Status
  is_default INTEGER DEFAULT 0 CHECK(is_default IN (0, 1)),

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT,

  UNIQUE(project_id, profile_slug)
);

CREATE INDEX idx_audience_project ON audience_profiles(project_id);
CREATE INDEX idx_audience_default ON audience_profiles(is_default) WHERE is_default = 1;

-- ═══════════════════════════════════════════════════════════
-- CONTENT PIECES (Generated content artifacts)
-- ═══════════════════════════════════════════════════════════

CREATE TABLE content_pieces (
  id TEXT PRIMARY KEY, -- UUID: 'content_a3f2b1c4-...'
  project_id TEXT NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,

  -- Identity
  piece_slug TEXT NOT NULL, -- 'blog-001-deep-work', 'linkedin-post-027'
  title TEXT NOT NULL,

  -- Classification
  content_type TEXT NOT NULL CHECK(content_type IN (
    'blog_post',
    'social_post_linkedin',
    'social_post_twitter',
    'social_post_instagram',
    'video_script',
    'newsletter',
    'course_outline',
    'course_lesson',
    'other'
  )),
  format_subtype TEXT, -- 'how_to', 'case_study', 'listicle', 'interview'

  -- Input Context
  topic TEXT NOT NULL,
  keywords TEXT, -- JSON array: ["deep work", "focus", "productivity"]
  target_audience_id TEXT REFERENCES audience_profiles(id),

  -- Persona (who wrote it)
  persona_mind_id INTEGER REFERENCES minds(id), -- MMOS clone used
  persona_type TEXT CHECK(persona_type IN (
    'mmos_clone',       -- From MMOS Mind Mapper
    'custom_persona',   -- User-defined persona
    'brand_voice'       -- Company brand voice
  )),
  persona_config TEXT, -- JSON: Custom persona parameters (if not MMOS)

  -- Content
  content_markdown TEXT NOT NULL, -- Full content in Markdown
  content_metadata TEXT, -- JSON: Meta description, CTA, related links, etc.

  -- Frameworks Applied
  frameworks_used TEXT, -- JSON array: ["blooms_taxonomy", "hero_journey", "aida"]

  -- Quality Scores
  fidelity_score REAL CHECK(fidelity_score BETWEEN 0.00 AND 1.00), -- Voice consistency
  seo_score REAL CHECK(seo_score BETWEEN 0.00 AND 1.00), -- SEO quality
  readability_score REAL CHECK(readability_score BETWEEN 0.00 AND 1.00), -- Flesch-Kincaid

  -- Fidelity Evidence (if MMOS clone used)
  fidelity_report TEXT, -- JSON: Vocabulary, syntax, style analysis

  -- Generation Metadata
  generation_version TEXT, -- 'v1.0', 'v2.5'
  llm_model TEXT, -- 'claude-sonnet-4', 'gpt-4o'
  generation_cost_usd REAL,
  generation_duration_seconds INTEGER,
  regeneration_count INTEGER DEFAULT 0, -- How many times regenerated

  -- Lifecycle
  status TEXT DEFAULT 'draft' CHECK(status IN (
    'draft',          -- Generated, not reviewed
    'reviewed',       -- User reviewed, ready to publish
    'published',      -- Live
    'archived'        -- No longer active
  )),
  published_at TEXT, -- ISO8601: When published
  published_url TEXT, -- Where published

  -- Performance Tracking
  performance_metrics_id TEXT REFERENCES content_performance(id),

  -- File Storage
  file_path TEXT, -- 'creator-os-workspace/projects/academia-lendaria-blog/content/blog-posts/001-deep-work/final.md'

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT,

  UNIQUE(project_id, piece_slug)
);

CREATE INDEX idx_content_project ON content_pieces(project_id);
CREATE INDEX idx_content_type ON content_pieces(content_type);
CREATE INDEX idx_content_persona ON content_pieces(persona_mind_id);
CREATE INDEX idx_content_audience ON content_pieces(target_audience_id);
CREATE INDEX idx_content_status ON content_pieces(status);
CREATE INDEX idx_content_published ON content_pieces(published_at) WHERE published_at IS NOT NULL;

-- ═══════════════════════════════════════════════════════════
-- CONTENT PERFORMANCE (Post-publish metrics)
-- ═══════════════════════════════════════════════════════════

CREATE TABLE content_performance (
  id TEXT PRIMARY KEY, -- UUID
  content_piece_id TEXT NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,

  -- Metrics (manual or API-collected)
  views INTEGER DEFAULT 0,
  unique_visitors INTEGER DEFAULT 0,
  avg_time_on_page_seconds INTEGER,
  bounce_rate REAL CHECK(bounce_rate BETWEEN 0.00 AND 1.00),

  -- Engagement
  likes INTEGER DEFAULT 0,
  comments INTEGER DEFAULT 0,
  shares INTEGER DEFAULT 0,
  saves INTEGER DEFAULT 0,
  engagement_rate REAL CHECK(engagement_rate BETWEEN 0.00 AND 1.00),

  -- Conversion
  clicks INTEGER DEFAULT 0,
  ctr REAL CHECK(ctr BETWEEN 0.00 AND 1.00), -- Click-through rate
  conversions INTEGER DEFAULT 0,
  conversion_rate REAL CHECK(conversion_rate BETWEEN 0.00 AND 1.00),

  -- SEO
  search_impressions INTEGER DEFAULT 0,
  search_clicks INTEGER DEFAULT 0,
  avg_search_position REAL,

  -- Audience Insights
  top_traffic_sources TEXT, -- JSON array: ["twitter", "linkedin", "google_search"]
  audience_demographics TEXT, -- JSON: Gender, age, location breakdown

  -- Performance vs Baseline
  performance_vs_baseline TEXT, -- JSON: {"views": "+120%", "engagement": "+45%"}

  -- Learnings (AI-extracted insights)
  key_learnings TEXT, -- JSON array: ["Personal stories resonate", "Long-form works"]
  suggested_improvements TEXT, -- JSON array: ["Add more examples", "Simplify intro"]

  -- Data Collection
  data_source TEXT, -- 'manual', 'google_analytics', 'buffer', 'linkedin_api'
  last_updated_at TEXT, -- ISO8601: When metrics last updated

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,

  UNIQUE(content_piece_id)
);

CREATE INDEX idx_performance_content ON content_performance(content_piece_id);
CREATE INDEX idx_performance_engagement ON content_performance(engagement_rate);
CREATE INDEX idx_performance_conversion ON content_performance(conversion_rate);

-- ═══════════════════════════════════════════════════════════
-- CONTENT CAMPAIGNS (Group related content pieces)
-- ═══════════════════════════════════════════════════════════

CREATE TABLE content_campaigns (
  id TEXT PRIMARY KEY, -- UUID
  project_id TEXT NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,

  -- Identity
  campaign_slug TEXT NOT NULL,
  display_name TEXT NOT NULL, -- 'Q4 2025 Thought Leadership'
  description TEXT,

  -- Goals
  primary_goal TEXT CHECK(primary_goal IN (
    'brand_awareness', 'lead_generation', 'education',
    'engagement', 'conversion', 'other'
  )),
  target_metrics TEXT, -- JSON: {"views": 10000, "conversions": 50}

  -- Timeline
  start_date TEXT, -- ISO8601
  end_date TEXT,

  -- Status
  status TEXT DEFAULT 'planning' CHECK(status IN (
    'planning', 'active', 'completed', 'paused', 'cancelled'
  )),

  -- Performance (aggregated from content_pieces)
  total_pieces INTEGER DEFAULT 0,
  total_views INTEGER DEFAULT 0,
  total_engagement INTEGER DEFAULT 0,
  total_conversions INTEGER DEFAULT 0,
  goal_completion_percentage REAL, -- 0.00-1.00

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT,

  UNIQUE(project_id, campaign_slug)
);

CREATE INDEX idx_campaigns_project ON content_campaigns(project_id);
CREATE INDEX idx_campaigns_status ON content_campaigns(status);
CREATE INDEX idx_campaigns_dates ON content_campaigns(start_date, end_date);

-- ═══════════════════════════════════════════════════════════
-- CONTENT CAMPAIGN PIECES (Many-to-Many)
-- ═══════════════════════════════════════════════════════════

CREATE TABLE content_campaign_pieces (
  campaign_id TEXT NOT NULL REFERENCES content_campaigns(id) ON DELETE CASCADE,
  content_piece_id TEXT NOT NULL REFERENCES content_pieces(id) ON DELETE CASCADE,
  sequence_order INTEGER, -- Order within campaign
  added_at TEXT DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (campaign_id, content_piece_id)
);

CREATE INDEX idx_campaign_pieces_campaign ON content_campaign_pieces(campaign_id);
CREATE INDEX idx_campaign_pieces_content ON content_campaign_pieces(content_piece_id);

-- ═══════════════════════════════════════════════════════════
-- CONTENT LEARNINGS (Captured insights for improvement)
-- ═══════════════════════════════════════════════════════════

CREATE TABLE content_learnings (
  id TEXT PRIMARY KEY, -- UUID
  project_id TEXT NOT NULL REFERENCES content_projects(id) ON DELETE CASCADE,

  -- Context
  content_piece_id TEXT REFERENCES content_pieces(id), -- Optional: specific piece
  campaign_id TEXT REFERENCES content_campaigns(id), -- Optional: specific campaign

  -- Learning
  learning_type TEXT CHECK(learning_type IN (
    'what_worked',      -- Success pattern
    'what_didnt_work',  -- Failed pattern
    'audience_insight', -- Audience behavior
    'framework_insight',-- Framework effectiveness
    'persona_insight',  -- Persona effectiveness
    'other'
  )),
  learning_text TEXT NOT NULL,
  evidence TEXT, -- JSON: Data supporting this learning

  -- Application
  actionable_recommendation TEXT, -- What to do next time
  applied_to_pieces TEXT, -- JSON array: Content piece IDs where applied

  -- Metadata
  confidence REAL CHECK(confidence BETWEEN 0.00 AND 1.00), -- How confident in this learning
  source TEXT, -- 'ai_analysis', 'user_observation', 'performance_data'
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT
);

CREATE INDEX idx_learnings_project ON content_learnings(project_id);
CREATE INDEX idx_learnings_type ON content_learnings(learning_type);
CREATE INDEX idx_learnings_confidence ON content_learnings(confidence);

-- ═══════════════════════════════════════════════════════════
-- TRIGGERS
-- ═══════════════════════════════════════════════════════════

CREATE TRIGGER trigger_projects_updated_at
AFTER UPDATE ON content_projects
FOR EACH ROW
BEGIN
  UPDATE content_projects SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER trigger_audience_updated_at
AFTER UPDATE ON audience_profiles
FOR EACH ROW
BEGIN
  UPDATE audience_profiles SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER trigger_content_updated_at
AFTER UPDATE ON content_pieces
FOR EACH ROW
BEGIN
  UPDATE content_pieces SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER trigger_performance_updated_at
AFTER UPDATE ON content_performance
FOR EACH ROW
BEGIN
  UPDATE content_performance SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER trigger_campaigns_updated_at
AFTER UPDATE ON content_campaigns
FOR EACH ROW
BEGIN
  UPDATE content_campaigns SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- ═══════════════════════════════════════════════════════════
-- VIEWS (Analytics & Reporting)
-- ═══════════════════════════════════════════════════════════

CREATE VIEW v_content_overview AS
SELECT
  cp.id as project_id,
  cp.project_slug,
  cp.display_name as project_name,
  cp.status as project_status,

  -- Content Statistics
  COUNT(DISTINCT c.id) as total_pieces,
  COUNT(DISTINCT CASE WHEN c.status = 'published' THEN c.id END) as published_pieces,
  COUNT(DISTINCT CASE WHEN c.status = 'draft' THEN c.id END) as draft_pieces,

  -- Performance Aggregates
  AVG(p.engagement_rate) as avg_engagement_rate,
  AVG(p.conversion_rate) as avg_conversion_rate,
  SUM(p.views) as total_views,
  SUM(p.conversions) as total_conversions,

  -- Top Persona
  (SELECT m.display_name
   FROM content_pieces c2
   JOIN minds m ON c2.persona_mind_id = m.id
   WHERE c2.project_id = cp.id
   GROUP BY m.id
   ORDER BY COUNT(*) DESC
   LIMIT 1) as most_used_persona,

  -- Quality Scores
  AVG(c.fidelity_score) as avg_fidelity,
  AVG(c.seo_score) as avg_seo,
  AVG(c.readability_score) as avg_readability,

  -- Metadata
  cp.created_at,
  cp.updated_at

FROM content_projects cp
LEFT JOIN content_pieces c ON cp.id = c.project_id AND c.deleted_at IS NULL
LEFT JOIN content_performance p ON c.id = p.content_piece_id
WHERE cp.deleted_at IS NULL
GROUP BY cp.id, cp.project_slug, cp.display_name, cp.status, cp.created_at, cp.updated_at;

CREATE VIEW v_persona_content_performance AS
SELECT
  m.id as mind_id,
  m.slug as mind_slug,
  m.display_name as mind_name,

  -- Content Statistics
  COUNT(DISTINCT c.id) as pieces_generated,
  COUNT(DISTINCT CASE WHEN c.status = 'published' THEN c.id END) as pieces_published,

  -- Performance Metrics
  AVG(p.engagement_rate) as avg_engagement,
  AVG(p.conversion_rate) as avg_conversion,
  AVG(c.fidelity_score) as avg_fidelity,

  -- Formats
  GROUP_CONCAT(DISTINCT c.content_type) as content_types_used,

  -- Best Performing Piece
  (SELECT c2.title
   FROM content_pieces c2
   JOIN content_performance p2 ON c2.id = p2.content_piece_id
   WHERE c2.persona_mind_id = m.id
   ORDER BY p2.engagement_rate DESC
   LIMIT 1) as best_performing_piece

FROM minds m
LEFT JOIN content_pieces c ON m.id = c.persona_mind_id AND c.deleted_at IS NULL
LEFT JOIN content_performance p ON c.id = p.content_piece_id
GROUP BY m.id, m.slug, m.display_name;
```

---

## Integration with Existing MMOS Database

### How CreatorOS Links to MMOS

**1. Persona → Mind**
- `content_pieces.persona_mind_id` → `minds.id`
- CreatorOS reads `minds` table to list available personas (MMOS clones)
- When generating content, fetches persona details from:
  - `profiles.structured_json` (personality profile)
  - `system_prompts.content` (voice/style)
  - `fragments` (examples of writing style)

**2. Audience → Traits (Optional InnerLens)**
- `audience_profiles.psychographic_profile_id` → Future InnerLens profile
- When InnerLens is integrated, audience profiles can reference psychometric profiles
- Enables persona-audience matching (e.g., "High Openness writer → High Openness reader")

**3. Content Frameworks → Taxonomy**
- `content_frameworks` is independent but complementary to:
  - `domains` (business domains)
  - `specializations` (expertise areas)
- Example: Copywriter specialization → Best frameworks: "AIDA", "PAS", "Hook-Story-Close"

**4. Performance → Evidence**
- Content performance can inform mind rankings:
  - If Nassim Taleb persona generates 10 blog posts with 90% avg engagement
  - His `mind_specialization_rankings.overall_score` for "Content Creation" increases
  - Evidence: Links to `content_pieces` with high performance

---

## Project Manager Agent

### Agent Specification

```yaml
agent:
  name: "ContentPM"
  id: content-pm
  title: "Content Project Manager"
  icon: 📊
  whenToUse: Project creation, campaign planning, content strategy, performance tracking

persona:
  role: Strategic Content Project Manager
  style: Organized, data-driven, strategic, collaborative
  identity: Orchestrates content projects end-to-end with database-backed tracking
  focus: Project setup, content strategy, performance analysis, continuous improvement

commands:
  - help: Show all available commands
  - create-project: Initialize new content project
  - list-projects: Show all projects (with stats)
  - select-project: Set active project context
  - add-persona: Add persona (MMOS clone or custom) to project
  - add-audience: Define audience profile (ICP)
  - create-campaign: Plan content campaign with goals
  - generate-content: Delegate to content-orchestrator for piece generation
  - track-performance: Log metrics for published content
  - analyze-learnings: Extract insights from performance data
  - export-report: Generate project report (PDF, YAML)
  - exit: Deactivate agent

workflows:
  - project-setup: 5-step wizard (name, goals, persona, audience, strategy)
  - campaign-planning: Define campaign (goals, timeline, content types, frequency)
  - performance-review: Weekly/monthly dashboard (views, engagement, conversions)
  - learning-extraction: Analyze patterns → actionable recommendations
```

### Workflow: Project Setup (5 Steps)

```
1. **Project Identity**
   - Name: "Academia Lendária Blog"
   - Description: "Thought leadership blog for tech founders"
   - Goals: ["brand_awareness", "lead_generation", "education"]

2. **Default Persona Selection**
   - Option A: Use MMOS clone (list available minds)
   - Option B: Create custom persona (upload voice parameters)
   - Option C: Define brand voice (company style guide)
   → User selects: Nassim Taleb (MMOS clone)

3. **Audience Profile Definition**
   - Name: "Tech Founders Brasileiros"
   - Demographics: Age 28-45, Brazil/Portugal/USA, Founder/CTO/Tech Lead
   - Psychographics: High Openness (85), values autonomy/impact/learning
   - Pain points: Time scarcity, complex decisions, imposter syndrome
   - Content preferences: Conversational deep, long-form (2000+ words)
   → Optional: Run InnerLens if available

4. **Content Strategy**
   - Target frequency: "3 blog posts/week"
   - Primary formats: ["blog", "newsletter", "twitter_threads"]
   - Content frameworks: ["blooms_taxonomy", "hero_journey", "aida"]
   - Distribution channels: ["Medium", "LinkedIn", "Twitter"]

5. **Database Creation**
   - Insert into `content_projects`
   - Insert default audience into `audience_profiles`
   - Create project directory structure
   - Generate `config.yaml`
   → Project ID: `proj_a3f2b1c4-...`
   → Ready for content generation
```

### Workflow: Content Generation Delegation

```
User: *generate-content

ContentPM: "Which project?"
User: "Academia Lendária Blog"

ContentPM: "What content type?"
1. Blog Post (1500-2500 words)
2. LinkedIn Post (300-1200 words)
3. Twitter Thread (5-10 tweets)
4. Video Script (5-15 min)
5. Newsletter (500-1000 words)

User: "1"

ContentPM: "Topic/Keywords?"
User: "Deep work and focus strategies"

ContentPM: "Which persona?"
1. Nassim Taleb (default)
2. Cal Newport
3. Custom...

User: "2"

ContentPM: "Which audience?"
1. Tech Founders (default)
2. Corporate Leaders
3. Custom...

User: "1"

ContentPM:
✅ Project: Academia Lendária Blog (proj_a3f2b1c4)
✅ Persona: Cal Newport (mind_id: 42)
✅ Audience: Tech Founders (aud_xyz123)
✅ Type: Blog Post
✅ Topic: Deep work and focus strategies

Delegating to @content-orchestrator...
[Calls content-orchestrator agent with context]

[After generation]
ContentPM: Blog post generated!
- Title: "The Science of Deep Work: 5 Strategies..."
- Word count: 2,347
- Fidelity score: 89%
- SEO score: 92%
- File: creator-os-workspace/.../final.md
- Database ID: content_a3f2b1c4-...

Actions:
1. *review - Review content
2. *publish - Mark as published and track URL
3. *regenerate - Try again with different approach
4. *edit - Open for manual editing
```

### Workflow: Performance Tracking

```
User: *track-performance

ContentPM: "Which content piece?"
[Lists recent published pieces]

User: "Blog Post: The Science of Deep Work"

ContentPM: "Performance data source?"
1. Manual entry
2. Google Analytics API (if configured)
3. LinkedIn API (if configured)
4. Import CSV

User: "1" (Manual for MVP)

ContentPM: "Enter metrics:"
- Views: 5420
- Unique visitors: 4230
- Avg time: 8m 32s
- Bounce rate: 35%
- Likes: 342
- Comments: 28
- Shares: 156
- Clicks (CTA): 215
- Conversions: 43

ContentPM: Calculating...
✅ Engagement rate: 12% (+45% vs baseline)
✅ Conversion rate: 8% (+80% vs baseline)
✅ Performance grade: A+ (top 10% of project)

Insights detected:
- Personal stories section had 3x engagement
- Long-form worked (8min read vs 5min target)
- CTA placement: mid-post outperformed end-post (2x conversions)

Recommendations:
1. Use more personal stories in future blog posts
2. Maintain long-form format (2000+ words)
3. Place primary CTA mid-content (after section 2)

Save learnings to database? [Y/n]
```

---

## Content Frameworks - Initial Seed Data

### Pedagogical Frameworks

```sql
INSERT INTO content_frameworks VALUES
('blooms_taxonomy', 'Bloom''s Taxonomy', 'pedagogical',
 'Hierarchical framework for learning objectives across 6 cognitive levels',
 '{"levels": ["Remember", "Understand", "Apply", "Analyze", "Evaluate", "Create"]}',
 '["course", "lesson", "blog"]',
 '# Usage: Structure learning progression from basic recall to creative application',
 '{"course_example": "Module 1: Define deep work → Module 5: Create deep work system"}',
 'Bloom, B. S. (1956). Taxonomy of Educational Objectives',
 'https://en.wikipedia.org/wiki/Bloom%27s_taxonomy',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');

INSERT INTO content_frameworks VALUES
('addie', 'ADDIE Model', 'pedagogical',
 '5-phase instructional design model: Analysis, Design, Development, Implementation, Evaluation',
 '{"phases": ["Analysis", "Design", "Development", "Implementation", "Evaluation"]}',
 '["course"]',
 '# Usage: Full course design from needs analysis to post-launch evaluation',
 '{"course_example": "Analyze learner needs → Design objectives → Develop content → Launch → Evaluate"}',
 'Dick, W., & Carey, L. (1996). The Systematic Design of Instruction',
 'https://en.wikipedia.org/wiki/ADDIE_Model',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');

INSERT INTO content_frameworks VALUES
('kolb', 'Kolb''s Learning Cycle', 'pedagogical',
 'Experiential learning cycle: Experience, Reflect, Conceptualize, Experiment',
 '{"stages": ["Concrete Experience", "Reflective Observation", "Abstract Conceptualization", "Active Experimentation"]}',
 '["lesson", "course"]',
 '# Usage: Design lessons with hands-on → reflection → theory → practice cycle',
 '{"lesson_example": "Watch demo video (CE) → Discuss what you noticed (RO) → Read theory (AC) → Try yourself (AE)"}',
 'Kolb, D. A. (1984). Experiential Learning',
 'https://en.wikipedia.org/wiki/Kolb%27s_experiential_learning',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');
```

### Storytelling Frameworks

```sql
INSERT INTO content_frameworks VALUES
('hero_journey', 'Hero''s Journey', 'storytelling',
 'Joseph Campbell''s monomyth: Hero faces challenge, transforms, returns with wisdom',
 '{"stages": ["Ordinary World", "Call to Adventure", "Refusal", "Mentor", "Threshold", "Tests", "Ordeal", "Reward", "Return", "Transformation"]}',
 '["blog", "video", "course"]',
 '# Usage: Structure narrative around transformation (before → challenge → after)',
 '{"blog_example": "I struggled with focus (Ordinary) → Discovered deep work (Call) → Now I work 4h/day with 10x output (Return)"}',
 'Campbell, J. (1949). The Hero with a Thousand Faces',
 'https://en.wikipedia.org/wiki/Hero%27s_journey',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');

INSERT INTO content_frameworks VALUES
('problem_solution', 'Problem-Solution', 'storytelling',
 'Simple 3-part structure: Identify problem, agitate pain, present solution',
 '{"parts": ["Problem", "Agitation", "Solution"]}',
 '["blog", "social", "video"]',
 '# Usage: Address reader pain point directly before offering solution',
 '{"blog_example": "Problem: Distraction kills productivity. Agitation: You work 10h but achieve 2h of output. Solution: Deep work framework"}',
 'Classic copywriting structure',
 'https://copyblogger.com/problem-agitate-solve/',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');

INSERT INTO content_frameworks VALUES
('case_study', 'Case Study', 'storytelling',
 'Evidence-based narrative: Subject, challenge, solution, results',
 '{"sections": ["Subject Introduction", "Challenge/Problem", "Solution Implemented", "Results/Impact", "Learnings"]}',
 '["blog", "video", "newsletter"]',
 '# Usage: Demonstrate concept via real-world example with measurable outcomes',
 '{"blog_example": "How Company X implemented deep work: 4-day workweek, 40% productivity increase, 90% employee satisfaction"}',
 'Business case study methodology',
 'https://blog.hubspot.com/marketing/case-study-templates',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');
```

### Marketing Frameworks

```sql
INSERT INTO content_frameworks VALUES
('aida', 'AIDA', 'marketing',
 'Classic marketing funnel: Attention, Interest, Desire, Action',
 '{"stages": ["Attention", "Interest", "Desire", "Action"]}',
 '["blog", "social", "video", "newsletter"]',
 '# Usage: Structure content to move reader through funnel (hook → value → want → CTA)',
 '{"blog_example": "Attention: Bold title. Interest: Surprising statistic. Desire: Success story. Action: Download free guide"}',
 'Lewis, E. St. Elmo (1898). AIDA model',
 'https://en.wikipedia.org/wiki/AIDA_(marketing)',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');

INSERT INTO content_frameworks VALUES
('pas', 'PAS (Problem-Agitate-Solve)', 'marketing',
 'Copywriting formula: State problem, agitate emotion, present solution',
 '{"steps": ["Problem", "Agitate", "Solve"]}',
 '["social", "blog", "newsletter"]',
 '# Usage: Emotional copywriting that resonates with reader pain before solution',
 '{"social_example": "Problem: You work 60h/week. Agitate: Missing kids'' bedtime, health declining. Solve: 4-hour workweek system"}',
 'Classic direct response copywriting',
 'https://copyhackers.com/2016/04/problem-agitate-solve/',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');
```

### SEO Frameworks

```sql
INSERT INTO content_frameworks VALUES
('seo_best_practices', 'SEO Best Practices', 'seo',
 'On-page SEO optimization checklist: keywords, meta tags, headings, readability',
 '{"checklist": ["Title 60 chars", "Meta description 150 chars", "H1 + 5 H2s", "Keyword density 1-2%", "Alt text", "Internal links", "Readability 60+", "Mobile-friendly"]}',
 '["blog"]',
 '# Usage: Validate blog post against SEO checklist before publishing',
 '{"blog_example": "Title: How to Master Deep Work (52 chars). Meta: Learn 5 proven strategies... (148 chars). Keywords: deep work appears 12x in 2000 words (0.6%)"}',
 'Google SEO Starter Guide + Yoast SEO standards',
 'https://developers.google.com/search/docs/beginner/seo-starter-guide',
 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '1.0');
```

---

## Integration Scripts

### 1. Initialize CreatorOS in Database

```bash
# scripts/creator-os/init-database.sh
#!/bin/bash

DB_PATH="outputs/database/mmos.db"

echo "Initializing CreatorOS tables in mmos.db..."

# Execute schema
sqlite3 "$DB_PATH" < expansion-packs/creator-os/database/schema.sql

# Seed frameworks
sqlite3 "$DB_PATH" < expansion-packs/creator-os/database/seed_frameworks.sql

echo "✅ CreatorOS database initialized"
echo ""
echo "Tables created:"
echo "- content_frameworks (8 frameworks)"
echo "- content_projects"
echo "- audience_profiles"
echo "- content_pieces"
echo "- content_performance"
echo "- content_campaigns"
echo "- content_campaign_pieces"
echo "- content_learnings"
echo ""
echo "Ready for use: @content-pm"
```

### 2. Create Project (Node.js Module)

```javascript
// scripts/creator-os/create-project.js
const Database = require('better-sqlite3');
const { v4: uuidv4 } = require('uuid');
const fs = require('fs');
const path = require('path');

async function createProject(config) {
  const db = new Database('outputs/database/mmos.db');

  const projectId = `proj_${uuidv4()}`;

  // Insert project
  db.prepare(`
    INSERT INTO content_projects (id, project_slug, display_name, description,
      default_persona_id, content_goals, target_frequency, status)
    VALUES (?, ?, ?, ?, ?, ?, ?, 'active')
  `).run(
    projectId,
    config.slug,
    config.name,
    config.description,
    config.defaultPersonaId, // mind_id from MMOS
    JSON.stringify(config.goals),
    config.targetFrequency
  );

  // Insert default audience
  const audienceId = `aud_${uuidv4()}`;
  db.prepare(`
    INSERT INTO audience_profiles (id, project_id, profile_slug, display_name,
      demographics, values, pain_points, goals, tone_preference,
      complexity_preference, is_default)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)
  `).run(
    audienceId,
    projectId,
    config.audience.slug,
    config.audience.name,
    JSON.stringify(config.audience.demographics),
    JSON.stringify(config.audience.values),
    JSON.stringify(config.audience.painPoints),
    JSON.stringify(config.audience.goals),
    config.audience.tonePreference,
    config.audience.complexityPreference
  );

  // Create directory structure
  const projectDir = path.join(
    'creator-os-workspace/projects',
    config.slug
  );

  fs.mkdirSync(`${projectDir}/personas`, { recursive: true });
  fs.mkdirSync(`${projectDir}/audiences`, { recursive: true });
  fs.mkdirSync(`${projectDir}/content/blog-posts`, { recursive: true });
  fs.mkdirSync(`${projectDir}/content/social-posts`, { recursive: true });
  fs.mkdirSync(`${projectDir}/content/video-scripts`, { recursive: true });
  fs.mkdirSync(`${projectDir}/strategy`, { recursive: true });

  // Save config.yaml
  const configYaml = `
project_id: ${projectId}
project_slug: ${config.slug}
display_name: ${config.name}
created_at: ${new Date().toISOString()}

default_persona_id: ${config.defaultPersonaId}
default_audience_id: ${audienceId}

content_goals: ${JSON.stringify(config.goals)}
target_frequency: "${config.targetFrequency}"
  `;

  fs.writeFileSync(`${projectDir}/config.yaml`, configYaml.trim());

  db.close();

  console.log(`✅ Project created: ${projectId}`);
  console.log(`📁 Directory: ${projectDir}`);
  console.log(`👤 Default persona: ${config.defaultPersonaId}`);
  console.log(`🎯 Default audience: ${audienceId}`);

  return { projectId, audienceId, projectDir };
}

module.exports = { createProject };
```

---

## Recommended Epic Update

Given this database integration, **Epic 0 should be updated** to include:

### New Story 0.6: Database Integration & Project Manager Agent (8 points)

**Goal:** Integrate CreatorOS with unified database and create Project Manager agent

**Deliverables:**
1. Database schema extension (8 new tables)
2. Seed data (8 content frameworks)
3. Integration scripts (init-database.sh, create-project.js)
4. Project Manager agent (`agents/content-pm.md`)
5. Database integration tests

**Success Criteria:**
- All tables created without errors
- Project creation workflow end-to-end
- ContentPM agent can list MMOS minds as personas
- Content piece stored with full traceability

---

**Total Epic 0 Story Points:** 18 → **26 points** (adds 8 pts for database integration)
**Timeline:** 2 weeks → **2.5 weeks** (adds 3-4 days)

---

## Summary

This integration gives CreatorOS:
1. ✅ **Unified database** (no separate data stores)
2. ✅ **Full traceability** (content → persona → mind → fragments)
3. ✅ **Performance tracking** with learning loops
4. ✅ **Content frameworks** indexed and queryable
5. ✅ **Project Manager Agent** orchestrating everything
6. ✅ **Analytics & reporting** via database views
7. ✅ **Scalability** (supports thousands of projects/pieces)

**Next Steps:**
1. Review and approve this design
2. Update Epic 0 with Story 0.6 (Database Integration)
3. Create `schema.sql` and `seed_frameworks.sql` files
4. Implement ContentPM agent
5. Test integration with sam_altman MMOS clone

Ready to proceed?
