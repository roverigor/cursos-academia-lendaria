-- ══════════════════════════════════════════════════════════════
-- MMOS + InnerLens: Unified Database Schema
-- Version: 3.0 FINAL
-- Date: October 12, 2025
-- Database: SQLite 3.35+ (PostgreSQL-compatible)
-- Total Tables: 15 core + 2 scoring
-- ══════════════════════════════════════════════════════════════

-- Enable foreign keys (SQLite)
PRAGMA foreign_keys = ON;


-- ══════════════════════════════════════════════════════════════
-- SECTION 1: CORE MIND SYSTEM (3 tables)
-- ══════════════════════════════════════════════════════════════

-- TABLE: minds
-- Central registry of all minds (MMOS + InnerLens unified)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS minds (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT NOT NULL UNIQUE,
  display_name TEXT NOT NULL,

  -- Identity
  subject_type TEXT CHECK(subject_type IN ('public_figure', 'private_user', NULL)),
  privacy_level TEXT DEFAULT 'public' CHECK(privacy_level IN ('public', 'private', 'anonymized')),

  -- Classification
  category TEXT,
  primary_domain TEXT, -- Reference to domains.id (FK added later)

  -- Biographical
  birth_year INTEGER,
  nationality TEXT,
  known_aliases TEXT, -- JSON array: ["Alan", "Al"]

  -- Processing Status
  status TEXT DEFAULT 'active' CHECK(status IN ('active', 'inactive', 'completed', 'archived')),
  current_phase TEXT, -- 'viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing'

  -- Quality Metrics (unified MMOS + InnerLens)
  apex_score REAL DEFAULT 0.0 CHECK(apex_score BETWEEN 0.0 AND 10.0),
  icp_match TEXT CHECK(icp_match IN ('low', 'medium', 'high', NULL)),
  quality_grade TEXT, -- 'A', 'A-', 'B+', etc.
  completeness REAL CHECK(completeness BETWEEN 0.00 AND 1.00),
  confidence_avg REAL CHECK(confidence_avg BETWEEN 0.00 AND 1.00),

  -- Processing Costs
  total_tokens_used INTEGER DEFAULT 0,
  total_cost_usd REAL DEFAULT 0.00,
  processing_started_at TEXT, -- ISO8601: '2025-01-10T14:30:00Z'
  processing_completed_at TEXT,
  processing_duration_seconds INTEGER,

  -- Pipeline Version
  pipeline_version TEXT, -- '2.0', '3.1', etc.
  agent_versions TEXT, -- JSON: {"discovery": "2.2", "extraction": "2.0", "trait_mapping": "1.5"}

  -- Metadata
  version TEXT DEFAULT 'v1.0.0',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  created_by TEXT, -- User ID or agent name
  deleted_at TEXT -- Soft delete
);

CREATE INDEX idx_minds_slug ON minds(slug);
CREATE INDEX idx_minds_status ON minds(status);
CREATE INDEX idx_minds_category ON minds(category);
CREATE INDEX idx_minds_primary_domain ON minds(primary_domain);
CREATE INDEX idx_minds_deleted ON minds(deleted_at) WHERE deleted_at IS NULL;


-- TABLE: sources
-- Source materials (unified MMOS sources + InnerLens documents)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS sources (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,

  -- Identity
  source_id TEXT NOT NULL UNIQUE, -- 'sam_altman_podcast_001'
  title TEXT,

  -- Location
  file_path TEXT NOT NULL, -- Relative path: 'outputs/minds/sam_altman/sources/podcast_001.txt'
  source_url TEXT, -- Original URL if web source

  -- Classification
  type TEXT NOT NULL CHECK(type IN (
    'interview', 'article', 'book', 'essay', 'podcast_transcript',
    'video_transcript', 'speech', 'social_media', 'email', 'conversation', 'other'
  )),
  platform TEXT, -- 'YouTube', 'Medium', 'Blog', 'Twitter', etc.
  author TEXT, -- If different from mind
  date_published TEXT, -- ISO8601: '2024-03-15'

  -- Content
  raw_content TEXT, -- Original, uncleaned text
  clean_content TEXT, -- After cleaning agent processing
  word_count INTEGER,
  char_count INTEGER,

  -- Cognitive Layer (DNA Mental™)
  layer_relevance INTEGER CHECK(layer_relevance BETWEEN 1 AND 8),

  -- Metadata
  metadata TEXT, -- JSON: {"duration_minutes": 90, "interviewer": "Lex Fridman"}
  structural_format TEXT, -- 'interview_format', 'essay_format', 'q_and_a', etc.

  -- Discovery & Prioritization (InnerLens)
  tier INTEGER CHECK(tier BETWEEN 1 AND 4), -- 1=highest priority
  priority_score REAL CHECK(priority_score BETWEEN 0.00 AND 1.00),
  priority_reasoning TEXT,
  pre_eval_decision TEXT CHECK(pre_eval_decision IN ('MUST_PROCESS', 'SHOULD_PROCESS', 'SKIP', NULL)),
  pre_eval_reasoning TEXT,
  expected_yield INTEGER, -- Estimated fragment count

  -- Processing Status
  status TEXT DEFAULT 'discovered' CHECK(status IN (
    'discovered', 'validated', 'skipped', 'cleaned', 'extracted', 'failed'
  )),
  processed_at TEXT, -- ISO8601

  -- Quality Metrics (InnerLens)
  actual_yield INTEGER, -- Actual fragments extracted
  avg_fragment_layer REAL,
  high_layer_percentage REAL, -- Percentage of layer 5+ fragments

  -- Pipeline Versions
  pipeline_version TEXT,
  cleaning_version TEXT,
  extraction_version TEXT,

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT -- Soft delete
);

CREATE INDEX idx_sources_mind ON sources(mind_id);
CREATE INDEX idx_sources_status ON sources(status);
CREATE INDEX idx_sources_type ON sources(type);
CREATE INDEX idx_sources_tier ON sources(tier);
CREATE INDEX idx_sources_layer ON sources(layer_relevance);
CREATE INDEX idx_sources_date ON sources(date_published);
CREATE INDEX idx_sources_deleted ON sources(deleted_at) WHERE deleted_at IS NULL;


-- TABLE: tags
-- Shared taxonomy for tagging (domains, layers, concepts, emotions, etc.)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  tag_name TEXT NOT NULL UNIQUE, -- 'layer-7', 'autonomy', 'copywriting', 'urgency'
  category TEXT NOT NULL CHECK(category IN (
    'domain', 'layer', 'concept', 'emotion', 'specialization',
    'psychological_trait', 'framework', 'skill', 'other'
  )),
  description TEXT,
  parent_tag_id INTEGER REFERENCES tags(id), -- Hierarchical tags
  usage_count INTEGER DEFAULT 0, -- Auto-incremented by trigger
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_tags_category ON tags(category);
CREATE INDEX idx_tags_parent ON tags(parent_tag_id);
CREATE INDEX idx_tags_usage ON tags(usage_count);


-- ══════════════════════════════════════════════════════════════
-- SECTION 2: FRAGMENT & EVIDENCE SYSTEM (3 tables)
-- ══════════════════════════════════════════════════════════════

-- TABLE: fragments
-- UNIVERSAL EVIDENCE UNITS (atomic units for ALL cognitive mapping)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS fragments (
  id TEXT PRIMARY KEY, -- UUID: 'frag_a3f2b1c4-...'
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  source_id INTEGER NOT NULL REFERENCES sources(id) ON DELETE CASCADE,

  -- ─────────────────────────────────────────────────────────────
  -- TYPE & CONTENT
  -- ─────────────────────────────────────────────────────────────
  fragment_type TEXT NOT NULL CHECK(fragment_type IN (
    'qa_interview',        -- Question & Answer from interview
    'statement',           -- Direct declaration/claim
    'monologue',           -- Extended solo speech
    'dialogue',            -- Two-person conversation
    'group_discussion',    -- Multi-party discussion
    'observation',         -- Third-party description
    'biographical_fact',   -- Objective life event
    'behavior_described',  -- Actions/behaviors narrated
    'written_thought',     -- Essay, blog, written reflection
    'chat_message',        -- Casual communication
    'reaction',            -- Response to external stimulus
    'meta_pattern'         -- Pattern across multiple fragments
  )),

  content TEXT NOT NULL, -- JSON: Flexible structure per type
  -- Example for qa_interview: {"question": "...", "answer": "..."}
  -- Example for statement: {"statement": "...", "context": "..."}
  -- Example for meta_pattern: {"pattern": "...", "evidence_fragment_ids": [...]}

  -- ─────────────────────────────────────────────────────────────
  -- COGNITIVE CLASSIFICATION
  -- ─────────────────────────────────────────────────────────────
  cognitive_theme TEXT NOT NULL, -- 'autonomy_preference', 'core_belief_progress', 'communication_style_analogies'
  layer INTEGER CHECK(layer BETWEEN 1 AND 8), -- DNA Mental™ cognitive layer
  domains TEXT, -- JSON array: ["motivation", "values", "beliefs", "communication"]

  -- ─────────────────────────────────────────────────────────────
  -- MARKERS & SIGNALS
  -- ─────────────────────────────────────────────────────────────
  emotional_markers TEXT, -- JSON array: ["excitement", "conviction", "vulnerability"]
  evasion_detected INTEGER DEFAULT 0 CHECK(evasion_detected IN (0, 1)), -- Boolean
  evasion_details TEXT, -- Why evasion detected
  signature_concepts TEXT, -- JSON array: ["first principles", "scale", "iteration"]

  -- ─────────────────────────────────────────────────────────────
  -- QUALITY & EVIDENCE
  -- ─────────────────────────────────────────────────────────────
  confidence REAL CHECK(confidence BETWEEN 0.00 AND 1.00), -- AI confidence in extraction
  why_significant TEXT NOT NULL, -- Why this fragment matters
  evidence_type TEXT CHECK(evidence_type IN (
    'explicit_statement',       -- Direct statement
    'implicit_reveal',          -- Inferred from behavior/context
    'behavioral_pattern',       -- Repeated behavior
    'third_party_observation'   -- Someone else's observation
  )),

  -- ─────────────────────────────────────────────────────────────
  -- HIERARCHY & RELATIONSHIPS
  -- ─────────────────────────────────────────────────────────────
  hierarchy TEXT CHECK(hierarchy IN ('fundamental', 'derived')),
  derives_from TEXT, -- JSON array of fragment IDs: ["frag_001", "frag_045"]
  related_fragments TEXT, -- JSON array: [{"fragment_id": "frag_089", "relation_type": "contradicts", "notes": "..."}]

  -- ─────────────────────────────────────────────────────────────
  -- TRACEABILITY (back to source)
  -- ─────────────────────────────────────────────────────────────
  raw_excerpt TEXT NOT NULL, -- Exact text from source
  source_timestamp TEXT, -- "01:23:45" (video/audio) or "page 42" (book)
  char_start INTEGER, -- Character offset in clean_content
  char_end INTEGER,

  -- ─────────────────────────────────────────────────────────────
  -- PROCESSING
  -- ─────────────────────────────────────────────────────────────
  extraction_method TEXT NOT NULL, -- 'manual', 'gpt4_extraction', 'claude_extraction'
  extraction_version TEXT NOT NULL, -- 'v2.0', 'v3.1'
  pipeline_version TEXT NOT NULL,

  -- ─────────────────────────────────────────────────────────────
  -- VALIDATION
  -- ─────────────────────────────────────────────────────────────
  self_critique_passed INTEGER DEFAULT 1 CHECK(self_critique_passed IN (0, 1)),
  critique_log TEXT, -- JSON: AI self-critique reasoning
  refinements_applied TEXT, -- JSON array: ["removed_redundancy", "clarified_significance"]
  validated INTEGER CHECK(validated IN (0, 1, NULL)), -- External validation
  validation_status TEXT CHECK(validation_status IN ('pending', 'confirmed', 'rejected', NULL)),
  validation_reasoning TEXT,

  -- ─────────────────────────────────────────────────────────────
  -- TEMPORAL
  -- ─────────────────────────────────────────────────────────────
  temporal_context TEXT, -- When in mind's timeline: '2019', 'early_career', 'post_ipo'
  evolution_marker INTEGER DEFAULT 0 CHECK(evolution_marker IN (0, 1)), -- Does this show change?

  -- ─────────────────────────────────────────────────────────────
  -- METADATA
  -- ─────────────────────────────────────────────────────────────
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT -- Soft delete
);

CREATE INDEX idx_fragments_mind ON fragments(mind_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_fragments_type ON fragments(fragment_type) WHERE deleted_at IS NULL;
CREATE INDEX idx_fragments_layer ON fragments(layer) WHERE deleted_at IS NULL;
CREATE INDEX idx_fragments_source ON fragments(source_id);
CREATE INDEX idx_fragments_confidence ON fragments(confidence) WHERE confidence >= 0.70;
CREATE INDEX idx_fragments_hierarchy ON fragments(hierarchy);
CREATE INDEX idx_fragments_validated ON fragments(validated);
CREATE INDEX idx_fragments_evolution ON fragments(evolution_marker) WHERE evolution_marker = 1;


-- TABLE: fragment_tags
-- M:N relationship between fragments and tags
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS fragment_tags (
  fragment_id TEXT NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  tag_id INTEGER NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  added_at TEXT DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (fragment_id, tag_id)
);

CREATE INDEX idx_fragment_tags_fragment ON fragment_tags(fragment_id);
CREATE INDEX idx_fragment_tags_tag ON fragment_tags(tag_id);


-- TABLE: analysis
-- High-level cognitive analysis artifacts (synthesized from fragments)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS analysis (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,

  -- Classification
  analysis_type TEXT NOT NULL CHECK(analysis_type IN (
    'beliefs',              -- Core beliefs system
    'mental_models',        -- Thinking frameworks
    'frameworks',           -- Structured methodologies
    'communication',        -- Communication patterns
    'knowledge',            -- Knowledge base entries
    'values',               -- Value system
    'worldview',            -- Worldview summary
    'personality',          -- Personality synthesis
    'expertise',            -- Professional expertise summary
    'other'
  )),
  layer INTEGER CHECK(layer BETWEEN 1 AND 8),
  phase TEXT, -- MMOS phase where this was created

  -- Content
  title TEXT NOT NULL,
  content TEXT NOT NULL, -- Markdown or plain text
  structured_data TEXT, -- JSON: Structured representation

  -- Evidence (traceability to fragments)
  source_fragment_ids TEXT, -- JSON array: ["frag_001", "frag_023", ...]

  -- Quality
  confidence REAL CHECK(confidence BETWEEN 0.00 AND 1.00),
  completeness REAL CHECK(completeness BETWEEN 0.00 AND 1.00),

  -- Processing
  agent_name TEXT, -- 'analyst', 'synthesizer', 'curator'
  agent_version TEXT,

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  deleted_at TEXT
);

CREATE INDEX idx_analysis_mind ON analysis(mind_id);
CREATE INDEX idx_analysis_type ON analysis(analysis_type);
CREATE INDEX idx_analysis_layer ON analysis(layer);
CREATE INDEX idx_analysis_deleted ON analysis(deleted_at) WHERE deleted_at IS NULL;


-- ══════════════════════════════════════════════════════════════
-- SECTION 3: KNOWLEDGE SYSTEM (3 tables)
-- ══════════════════════════════════════════════════════════════

-- TABLE: traits
-- Master taxonomy of psychological/behavioral traits (120 traits)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS traits (
  code INTEGER PRIMARY KEY, -- 1, 2, 3, ..., 120
  name TEXT NOT NULL UNIQUE, -- 'Epistemic Curiosity', 'Autonomy', 'Risk Tolerance'
  description TEXT NOT NULL,
  domain TEXT NOT NULL CHECK(domain IN (
    'cognitive', 'emotional', 'motivation', 'social',
    'behavioral', 'values', 'other'
  )),
  subdomain TEXT, -- 'learning_drive', 'agency', 'relationships'

  -- Measurement
  scale_min_label TEXT, -- 'Low autonomy', 'Risk averse'
  scale_max_label TEXT, -- 'High autonomy', 'Risk seeking'

  -- Relationships
  related_frameworks TEXT, -- JSON array: ["Big Five: Openness", "MBTI: INTJ"]
  inverse_of INTEGER REFERENCES traits(code), -- Trait code of inverse trait

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  version TEXT DEFAULT '1.0'
);

CREATE INDEX idx_traits_domain ON traits(domain);


-- TABLE: trait_scores
-- Aggregated, validated trait scores per mind (derived from fragments)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS trait_scores (
  id TEXT PRIMARY KEY, -- UUID
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  trait_code INTEGER NOT NULL REFERENCES traits(code),

  -- Score
  final_score REAL NOT NULL CHECK(final_score BETWEEN 0.00 AND 1.00),
  confidence REAL NOT NULL CHECK(confidence BETWEEN 0.00 AND 1.00),
  consistency REAL CHECK(consistency BETWEEN 0.00 AND 1.00), -- Cross-source consistency

  -- Evidence (traceability to fragments)
  evidence_count INTEGER NOT NULL, -- How many fragments support this
  evidence_fragment_ids TEXT, -- JSON array: ["frag_001", "frag_045", ...]

  -- Temporal
  earliest_evidence_date TEXT, -- ISO8601: When first evidence appeared
  latest_evidence_date TEXT,
  evolution_detected INTEGER DEFAULT 0 CHECK(evolution_detected IN (0, 1)),
  evolution_description TEXT, -- How trait changed over time

  -- Hierarchy
  is_central_trait INTEGER DEFAULT 0 CHECK(is_central_trait IN (0, 1)), -- Top 5-10 traits
  hierarchy TEXT CHECK(hierarchy IN ('fundamental', 'derived')),
  influences_traits TEXT, -- JSON array of trait codes: [15, 23, 42]

  -- Metadata
  calculated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  pipeline_version TEXT,

  UNIQUE(mind_id, trait_code)
);

CREATE INDEX idx_scores_mind ON trait_scores(mind_id);
CREATE INDEX idx_scores_trait ON trait_scores(trait_code);
CREATE INDEX idx_scores_central ON trait_scores(is_central_trait) WHERE is_central_trait = 1;
CREATE INDEX idx_scores_hierarchy ON trait_scores(hierarchy);


-- TABLE: profiles
-- Final synthesized cognitive profiles (psychological + professional)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS profiles (
  id TEXT PRIMARY KEY, -- UUID
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,

  -- Content (3 levels of detail)
  executive_summary TEXT NOT NULL, -- 250-350 words
  narrative_full TEXT NOT NULL, -- 1500-2500 words
  structured_json TEXT NOT NULL, -- JSON: Complete technical profile

  -- Metadata
  synthesis_version TEXT NOT NULL, -- 'v3.0'
  generated_at TEXT DEFAULT CURRENT_TIMESTAMP,

  -- Quality
  quality_grade TEXT, -- 'A', 'A-', 'B+', etc.
  completeness REAL CHECK(completeness BETWEEN 0.00 AND 1.00),
  limitations TEXT, -- JSON array: ["Limited data on early career", "Few sources post-2020"]

  UNIQUE(mind_id) -- One profile per mind
);

CREATE INDEX idx_profiles_mind ON profiles(mind_id);


-- ══════════════════════════════════════════════════════════════
-- SECTION 4: OUTPUT SYSTEM (2 tables)
-- ══════════════════════════════════════════════════════════════

-- TABLE: system_prompts
-- Versioned system prompts per mind
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS system_prompts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,

  -- Version (semantic versioning)
  version_tag TEXT NOT NULL, -- 'v1.0', 'v2.5', 'v3.1-beta'
  version_major INTEGER,
  version_minor INTEGER,

  -- Type & Purpose
  prompt_type TEXT NOT NULL CHECK(prompt_type IN (
    'generalista',    -- General-purpose mind clone
    'specialist',     -- Specialized by domain
    'qa',             -- Q&A focused
    'coach',          -- Coaching/advisory
    'analyst',        -- Analysis focused
    'other'
  )),
  specialist_domain TEXT, -- If specialist: 'copywriting', 'engineering', etc.

  -- Content
  content TEXT NOT NULL, -- Full system prompt text

  -- Status
  status TEXT DEFAULT 'draft' CHECK(status IN ('draft', 'testing', 'production', 'archived')),

  -- Location
  file_path TEXT, -- 'outputs/minds/sam_altman/system_prompts/v1.0-generalista.md'

  -- Metrics
  token_count INTEGER,
  usage_count INTEGER DEFAULT 0, -- Auto-incremented by trigger

  -- Quality
  validated INTEGER DEFAULT 0 CHECK(validated IN (0, 1)),
  validation_score REAL CHECK(validation_score BETWEEN 0.00 AND 1.00),

  -- Flags
  is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
  is_default INTEGER DEFAULT 0 CHECK(is_default IN (0, 1)),

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,

  UNIQUE(mind_id, version_tag, prompt_type)
);

CREATE INDEX idx_prompts_mind ON system_prompts(mind_id);
CREATE INDEX idx_prompts_active ON system_prompts(is_active) WHERE is_active = 1;
CREATE INDEX idx_prompts_type ON system_prompts(prompt_type);
CREATE INDEX idx_prompts_status ON system_prompts(status);


-- TABLE: specialists
-- Specialized mind clones per domain
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS specialists (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,

  -- Identity
  specialist_slug TEXT NOT NULL UNIQUE, -- 'sam-altman-copywriting', 'sam-altman-engineering'
  display_name TEXT NOT NULL, -- 'Sam Altman - Copywriting Expert'

  -- Specialization (link to taxonomy)
  specialization_id TEXT, -- FK added after specializations table created
  domain TEXT NOT NULL, -- 'marketing_sales', 'technology_engineering'
  subdomain TEXT, -- 'copywriting', 'software_engineering'

  -- System Prompt
  system_prompt_id INTEGER REFERENCES system_prompts(id),

  -- Configuration (LLM parameters)
  temperature REAL DEFAULT 0.7 CHECK(temperature BETWEEN 0.0 AND 2.0),
  max_tokens INTEGER DEFAULT 2000,

  -- Status
  is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),

  -- Usage
  usage_count INTEGER DEFAULT 0,
  last_used_at TEXT, -- ISO8601

  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_specialists_mind ON specialists(mind_id);
CREATE INDEX idx_specialists_specialization ON specialists(specialization_id);
CREATE INDEX idx_specialists_domain ON specialists(domain);
CREATE INDEX idx_specialists_active ON specialists(is_active) WHERE is_active = 1;


-- ══════════════════════════════════════════════════════════════
-- SECTION 5: SPECIALIZATION TAXONOMY (4 tables)
-- ══════════════════════════════════════════════════════════════

-- TABLE: domains
-- Top-level professional domains (6 total)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS domains (
  id TEXT PRIMARY KEY, -- 'business_entrepreneurship', 'marketing_sales', etc.
  name TEXT NOT NULL, -- 'Business & Entrepreneurship', 'Marketing & Sales'
  description TEXT,
  icon TEXT, -- Emoji or icon identifier: '💼', '📣'
  sort_order INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- TABLE: specializations
-- Professional roles/specializations (22 total)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS specializations (
  id TEXT PRIMARY KEY, -- 'copywriter', 'entrepreneur', 'software_engineer'
  domain_id TEXT NOT NULL REFERENCES domains(id) ON DELETE CASCADE,
  name TEXT NOT NULL, -- 'Copywriter', 'Entrepreneur', 'Software Engineer'
  description TEXT,
  icon TEXT, -- '✍️', '🚀', '👨‍💻'
  sort_order INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_specializations_domain ON specializations(domain_id);


-- TABLE: skills
-- Specific competencies within specializations (78 total)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS skills (
  id TEXT PRIMARY KEY, -- 'direct_response_copywriting', 'programming', 'business_strategy'
  specialization_id TEXT NOT NULL REFERENCES specializations(id) ON DELETE CASCADE,
  name TEXT NOT NULL, -- 'Direct Response Copywriting', 'Programming'
  description TEXT,
  sort_order INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_skills_specialization ON skills(specialization_id);


-- TABLE: proficiencies
-- Granular capabilities within skills (413 total)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS proficiencies (
  id TEXT PRIMARY KEY, -- 'hooks', 'python', 'market_analysis'
  skill_id TEXT NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
  name TEXT NOT NULL, -- 'Hooks', 'Python', 'Market Analysis'
  description TEXT,
  benchmark_description TEXT, -- What does mastery look like?
  sort_order INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_proficiencies_skill ON proficiencies(skill_id);


-- ══════════════════════════════════════════════════════════════
-- SECTION 6: SPECIALIZATION SCORING (2 tables)
-- ══════════════════════════════════════════════════════════════

-- TABLE: mind_proficiency_scores
-- Evidence-based proficiency scores per mind (derived from fragments)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS mind_proficiency_scores (
  id TEXT PRIMARY KEY, -- UUID
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  proficiency_id TEXT NOT NULL REFERENCES proficiencies(id),

  -- Score
  score REAL NOT NULL CHECK(score BETWEEN 0.00 AND 1.00),
  confidence REAL NOT NULL CHECK(confidence BETWEEN 0.00 AND 1.00),

  -- Evidence (traceability to fragments)
  evidence_count INTEGER NOT NULL,
  evidence_fragment_ids TEXT, -- JSON array: ["frag_001", "frag_045", ...]

  -- Context
  evidence_summary TEXT, -- Short summary of why this score

  -- Temporal
  earliest_evidence_date TEXT,
  latest_evidence_date TEXT,

  -- Metadata
  calculated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  calculation_method TEXT CHECK(calculation_method IN (
    'manual',           -- Manually assigned
    'ai_inferred',      -- AI-inferred from fragments
    'fragment_based',   -- Aggregated from fragment analysis
    'hybrid'            -- Combination
  )),
  pipeline_version TEXT,

  UNIQUE(mind_id, proficiency_id)
);

CREATE INDEX idx_prof_scores_mind ON mind_proficiency_scores(mind_id);
CREATE INDEX idx_prof_scores_proficiency ON mind_proficiency_scores(proficiency_id);
CREATE INDEX idx_prof_scores_score ON mind_proficiency_scores(score);


-- TABLE: mind_specialization_rankings
-- Aggregate specialization rankings (which specializations this mind excels at)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS mind_specialization_rankings (
  id TEXT PRIMARY KEY, -- UUID
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,
  specialization_id TEXT NOT NULL REFERENCES specializations(id),

  -- Aggregate Scores
  overall_score REAL NOT NULL CHECK(overall_score BETWEEN 0.00 AND 1.00),
  proficiency_count INTEGER NOT NULL, -- How many proficiencies scored
  avg_proficiency_score REAL,
  top_3_proficiencies TEXT, -- JSON array: [{"proficiency_id": "hooks", "score": 0.95}, ...]

  -- Ranking
  percentile REAL CHECK(percentile BETWEEN 0.00 AND 1.00), -- Where does this mind rank?
  rank_among_all_minds INTEGER, -- 1, 2, 3, ... (1 = best)

  -- Evidence
  total_evidence_fragments INTEGER,

  -- Metadata
  calculated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  pipeline_version TEXT,

  UNIQUE(mind_id, specialization_id)
);

CREATE INDEX idx_spec_rankings_mind ON mind_specialization_rankings(mind_id);
CREATE INDEX idx_spec_rankings_specialization ON mind_specialization_rankings(specialization_id);
CREATE INDEX idx_spec_rankings_score ON mind_specialization_rankings(overall_score);
CREATE INDEX idx_spec_rankings_rank ON mind_specialization_rankings(rank_among_all_minds);


-- ══════════════════════════════════════════════════════════════
-- SECTION 7: SYSTEM (1 table)
-- ══════════════════════════════════════════════════════════════

-- TABLE: pipeline_progress
-- Unified pipeline tracking (MMOS + InnerLens + Specialization + all future systems)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS pipeline_progress (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mind_id INTEGER NOT NULL REFERENCES minds(id) ON DELETE CASCADE,

  -- Pipeline Stage
  pipeline_name TEXT NOT NULL, -- 'mmos', 'innerlens', 'specialist_creation', 'proficiency_scoring'
  phase TEXT NOT NULL, -- 'viability', 'research', 'analysis', 'synthesis', 'implementation', 'testing'
  stage TEXT NOT NULL, -- Specific stage within phase: 'source_reading', 'fragment_extraction', etc.

  -- Status
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending', 'in_progress', 'completed', 'failed', 'skipped'
  )),

  -- Agent
  agent_name TEXT, -- 'analyst', 'extraction_v2', 'trait_mapper'
  agent_version TEXT, -- 'v2.0', 'v3.1'

  -- Output
  output_path TEXT, -- 'outputs/minds/sam_altman/artifacts/beliefs_core.yaml'
  output_type TEXT, -- 'markdown', 'json', 'yaml', 'sql'

  -- Timing
  started_at TEXT, -- ISO8601
  completed_at TEXT,
  duration_seconds INTEGER,

  -- Validation
  validated INTEGER DEFAULT 0 CHECK(validated IN (0, 1)),
  validation_passed INTEGER DEFAULT 0 CHECK(validation_passed IN (0, 1)),
  validation_notes TEXT,

  -- Metadata
  checkpoint_id TEXT, -- Reference to external checkpoint system
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_pipeline_mind ON pipeline_progress(mind_id);
CREATE INDEX idx_pipeline_status ON pipeline_progress(status);
CREATE INDEX idx_pipeline_phase ON pipeline_progress(phase);
CREATE INDEX idx_pipeline_name ON pipeline_progress(pipeline_name);


-- ══════════════════════════════════════════════════════════════
-- FOREIGN KEY CONSTRAINTS (deferred to avoid circular dependencies)
-- ══════════════════════════════════════════════════════════════

-- Add FK from specialists to specializations (after specializations table exists)
-- Note: This would be executed in a migration script, not here
-- ALTER TABLE specialists ADD FOREIGN KEY (specialization_id) REFERENCES specializations(id);


-- ══════════════════════════════════════════════════════════════
-- TRIGGERS (automation)
-- ══════════════════════════════════════════════════════════════

-- Trigger: Auto-update updated_at timestamp
CREATE TRIGGER IF NOT EXISTS trigger_minds_updated_at
AFTER UPDATE ON minds
FOR EACH ROW
BEGIN
  UPDATE minds SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS trigger_sources_updated_at
AFTER UPDATE ON sources
FOR EACH ROW
BEGIN
  UPDATE sources SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS trigger_fragments_updated_at
AFTER UPDATE ON fragments
FOR EACH ROW
BEGIN
  UPDATE fragments SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS trigger_analysis_updated_at
AFTER UPDATE ON analysis
FOR EACH ROW
BEGIN
  UPDATE analysis SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS trigger_system_prompts_updated_at
AFTER UPDATE ON system_prompts
FOR EACH ROW
BEGIN
  UPDATE system_prompts SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS trigger_specialists_updated_at
AFTER UPDATE ON specialists
FOR EACH ROW
BEGIN
  UPDATE specialists SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;


-- Trigger: Auto-increment tag usage count
CREATE TRIGGER IF NOT EXISTS trigger_tags_increment_usage
AFTER INSERT ON fragment_tags
FOR EACH ROW
BEGIN
  UPDATE tags SET usage_count = usage_count + 1 WHERE id = NEW.tag_id;
END;

CREATE TRIGGER IF NOT EXISTS trigger_tags_decrement_usage
AFTER DELETE ON fragment_tags
FOR EACH ROW
BEGIN
  UPDATE tags SET usage_count = usage_count - 1 WHERE id = OLD.tag_id;
END;


-- Trigger: Auto-increment system prompt usage count
CREATE TRIGGER IF NOT EXISTS trigger_prompts_increment_usage
AFTER UPDATE ON system_prompts
FOR EACH ROW
WHEN NEW.last_used_at IS NOT NULL AND NEW.last_used_at != OLD.last_used_at
BEGIN
  UPDATE system_prompts SET usage_count = usage_count + 1 WHERE id = NEW.id;
END;


-- Trigger: Auto-increment specialist usage count
CREATE TRIGGER IF NOT EXISTS trigger_specialists_increment_usage
AFTER UPDATE ON specialists
FOR EACH ROW
WHEN NEW.last_used_at IS NOT NULL AND NEW.last_used_at != OLD.last_used_at
BEGIN
  UPDATE specialists SET usage_count = usage_count + 1 WHERE id = NEW.id;
END;


-- ══════════════════════════════════════════════════════════════
-- VIEWS (convenience queries)
-- ══════════════════════════════════════════════════════════════

-- View: High-quality fragments only
CREATE VIEW IF NOT EXISTS v_fragments_high_quality AS
SELECT *
FROM fragments
WHERE deleted_at IS NULL
  AND confidence >= 0.70
  AND layer >= 5
  AND self_critique_passed = 1
  AND (validated IS NULL OR validated = 1);


-- View: Fragment statistics by mind
CREATE VIEW IF NOT EXISTS v_fragment_statistics AS
SELECT
  m.id as mind_id,
  m.slug,
  m.display_name,
  COUNT(DISTINCT f.id) as total_fragments,
  AVG(f.confidence) as avg_confidence,
  AVG(f.layer) as avg_layer,
  COUNT(DISTINCT CASE WHEN f.hierarchy = 'fundamental' THEN f.id END) as fundamental_count,
  COUNT(DISTINCT CASE WHEN f.hierarchy = 'derived' THEN f.id END) as derived_count,
  COUNT(DISTINCT CASE WHEN f.evolution_marker = 1 THEN f.id END) as evolution_markers,
  COUNT(DISTINCT CASE WHEN f.layer >= 7 THEN f.id END) as high_layer_count
FROM minds m
LEFT JOIN fragments f ON m.id = f.mind_id AND f.deleted_at IS NULL
GROUP BY m.id, m.slug, m.display_name;


-- View: Complete cognitive profile summary
CREATE VIEW IF NOT EXISTS v_cognitive_profiles AS
SELECT
  m.id as mind_id,
  m.slug,
  m.display_name,
  m.quality_grade,
  m.completeness,
  m.apex_score,

  -- Sources
  COUNT(DISTINCT s.id) as source_count,
  SUM(s.word_count) as total_words,

  -- Fragments
  COUNT(DISTINCT f.id) as fragment_count,
  AVG(f.confidence) as avg_fragment_confidence,

  -- Psychological Traits
  COUNT(DISTINCT ts.trait_code) as trait_count,
  (SELECT GROUP_CONCAT(t.name, ', ')
   FROM trait_scores ts2
   JOIN traits t ON ts2.trait_code = t.code
   WHERE ts2.mind_id = m.id AND ts2.is_central_trait = 1
   LIMIT 5) as central_traits,

  -- Professional Specializations
  COUNT(DISTINCT msr.specialization_id) as specialization_count,
  (SELECT GROUP_CONCAT(sp.name, ', ')
   FROM mind_specialization_rankings msr2
   JOIN specializations sp ON msr2.specialization_id = sp.id
   WHERE msr2.mind_id = m.id
   ORDER BY msr2.overall_score DESC
   LIMIT 3) as top_specializations,

  -- Analysis
  COUNT(DISTINCT a.id) as analysis_count,

  -- System Prompts
  COUNT(DISTINCT spr.id) as system_prompt_count,

  -- Profile
  p.executive_summary,
  p.generated_at as profile_generated_at

FROM minds m
LEFT JOIN sources s ON m.id = s.mind_id AND s.deleted_at IS NULL
LEFT JOIN fragments f ON m.id = f.mind_id AND f.deleted_at IS NULL
LEFT JOIN trait_scores ts ON m.id = ts.mind_id
LEFT JOIN mind_specialization_rankings msr ON m.id = msr.mind_id
LEFT JOIN analysis a ON m.id = a.mind_id AND a.deleted_at IS NULL
LEFT JOIN system_prompts spr ON m.id = spr.mind_id AND spr.is_active = 1
LEFT JOIN profiles p ON m.id = p.mind_id
WHERE m.deleted_at IS NULL
GROUP BY m.id, m.slug, m.display_name, m.quality_grade, m.completeness, m.apex_score, p.executive_summary, p.generated_at;


-- View: Pipeline status summary
CREATE VIEW IF NOT EXISTS v_pipeline_status AS
SELECT
  m.slug,
  m.display_name,
  pp.pipeline_name,
  pp.phase,
  pp.stage,
  pp.status,
  pp.agent_name,
  pp.started_at,
  pp.completed_at,
  pp.duration_seconds,
  pp.validated,
  pp.validation_passed
FROM pipeline_progress pp
JOIN minds m ON pp.mind_id = m.id
WHERE m.deleted_at IS NULL
ORDER BY m.slug, pp.pipeline_name, pp.phase, pp.created_at;


-- ══════════════════════════════════════════════════════════════
-- SCHEMA METADATA
-- ══════════════════════════════════════════════════════════════

-- Store schema version for migration tracking
CREATE TABLE IF NOT EXISTS schema_version (
  version TEXT PRIMARY KEY,
  applied_at TEXT DEFAULT CURRENT_TIMESTAMP,
  description TEXT
);

INSERT OR IGNORE INTO schema_version (version, description) VALUES
  ('3.0.0', 'Unified MMOS + InnerLens + Specialization Schema');


-- ══════════════════════════════════════════════════════════════
-- END OF SCHEMA
-- ══════════════════════════════════════════════════════════════

-- Total Tables: 17 (15 core + 2 scoring)
-- Total Indexes: 60+
-- Total Triggers: 9
-- Total Views: 4

-- To create the database:
-- sqlite3 mmos.db < schema_complete.sql

-- To verify:
-- SELECT name, type FROM sqlite_master WHERE type IN ('table', 'view', 'trigger') ORDER BY type, name;
