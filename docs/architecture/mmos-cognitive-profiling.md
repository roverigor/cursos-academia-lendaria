# MMOS Cognitive Profiling & Specialization System

**Version:** 1.0.0
**Date:** October 12, 2025
**Status:** Architecture Document
**Owner:** Academia Lendar[IA]

---

## Executive Summary

This document defines the comprehensive cognitive profiling and specialization scoring system for MMOS minds. It enables precise categorization, skill assessment, and correlation analysis across personality types, professional domains, and cognitive competencies.

**Key Capabilities:**
- Multi-dimensional personality profiling (DISC, MBTI, Enneagram, Big Five, etc.)
- Specialization scoring across domains (copywriting, entrepreneurship, strategy, etc.)
- Skill-level granularity (hooks, offers, positioning, etc.)
- Correlation engine for mind recommendations
- Comparative analytics across minds

---

## Table of Contents

1. [Cognitive Profiling Framework](#1-cognitive-profiling-framework)
2. [Specialization Taxonomy](#2-specialization-taxonomy)
3. [Scoring System](#3-scoring-system)
4. [Database Schema](#4-database-schema)
5. [Use Cases](#5-use-cases)
6. [Implementation Examples](#6-implementation-examples)

---

## 1. Cognitive Profiling Framework

### 1.1 Personality Assessment Systems

MMOS integrates **multiple personality frameworks** for comprehensive profiling:

#### A. DISC Profile

**Dimensions:**
```yaml
disc_profile:
  D: {score: 0-100}  # Dominance (results-oriented, direct, forceful)
  I: {score: 0-100}  # Influence (enthusiastic, optimistic, outgoing)
  S: {score: 0-100}  # Steadiness (calm, patient, supportive)
  C: {score: 0-100}  # Conscientiousness (analytical, precise, systematic)

  primary_type: "D"   # Dominant trait
  secondary_type: "I" # Secondary trait
  profile_code: "Di"  # Combined notation

  behavioral_tendencies:
    - Direct communication
    - Fast decision-making
    - Results-focused

  stress_patterns:
    - Becomes more demanding under pressure
    - May overlook details when rushed
```

**Example: Alex Hormozi**
```yaml
disc_profile:
  D: 95  # Extremely dominant
  I: 70  # High influence
  S: 20  # Low steadiness
  C: 65  # Moderate conscientiousness
  primary_type: "D"
  secondary_type: "I"
  profile_code: "Di"
```

#### B. Myers-Briggs Type Indicator (MBTI)

**Dimensions:**
```yaml
mbti_profile:
  type: "ENTJ"  # 16 personality types

  dimensions:
    E_I: "E"     # Extraversion (75) vs Introversion (25)
    S_N: "N"     # Sensing (30) vs Intuition (70)
    T_F: "T"     # Thinking (85) vs Feeling (15)
    J_P: "J"     # Judging (80) vs Perceiving (20)

  scores:
    extraversion: 75
    intuition: 70
    thinking: 85
    judging: 80

  cognitive_functions:
    dominant: "Te"      # Extraverted Thinking
    auxiliary: "Ni"     # Introverted Intuition
    tertiary: "Se"      # Extraverted Sensing
    inferior: "Fi"      # Introverted Feeling

  archetype: "The Commander"

  strengths:
    - Strategic thinking
    - Decisive leadership
    - Efficient execution

  weaknesses:
    - May overlook emotions
    - Can be overly critical
    - Impatient with inefficiency
```

**Example: Sam Altman**
```yaml
mbti_profile:
  type: "INTJ"
  dimensions:
    E_I: "I"
    S_N: "N"
    T_F: "T"
    J_P: "J"
  archetype: "The Architect"
```

#### C. Enneagram

**Dimensions:**
```yaml
enneagram_profile:
  core_type: 8          # 1-9 (The Challenger)
  wing: "8w7"           # With wing

  triadic_center: "gut" # gut/heart/head

  integration_point: 2  # Growth direction (8 → 2)
  disintegration_point: 5  # Stress direction (8 → 5)

  core_fear: "Being controlled or harmed"
  core_desire: "To protect self and control own destiny"
  core_motivation: "Autonomy and strength"

  healthy_traits:
    - Protective of others
    - Decisive and confident
    - Natural leader

  average_traits:
    - Confrontational
    - Domineering
    - Impatient

  unhealthy_traits:
    - Ruthless
    - Vengeful
    - Tyrannical

  growth_path:
    - Learn vulnerability
    - Develop empathy
    - Balance power with care
```

**Example: Elon Musk**
```yaml
enneagram_profile:
  core_type: 5
  wing: "5w6"
  triadic_center: "head"
  core_fear: "Being useless or incompetent"
  core_desire: "Competence and understanding"
```

#### D. Big Five (OCEAN)

**Dimensions:**
```yaml
big_five_profile:
  openness: 95          # 0-100 (high = creative, curious)
  conscientiousness: 85 # 0-100 (high = organized, disciplined)
  extraversion: 60      # 0-100 (high = outgoing, energetic)
  agreeableness: 30     # 0-100 (high = compassionate, cooperative)
  neuroticism: 25       # 0-100 (high = anxious, moody)

  facets:
    openness:
      imagination: 98
      artistic_interests: 70
      emotionality: 40
      adventurousness: 90
      intellect: 99
      liberalism: 85

    conscientiousness:
      self_efficacy: 95
      orderliness: 70
      dutifulness: 80
      achievement_striving: 99
      self_discipline: 90
      cautiousness: 60
```

#### E. Additional Frameworks

**Cognitive Styles:**
```yaml
cognitive_styles:
  thinking_style:
    - "Systems thinking"
    - "First principles reasoning"
    - "Analogical reasoning"

  learning_style:
    - "Visual"
    - "Kinesthetic"
    - "Reading/Writing"

  decision_making:
    - "Intuitive-rational hybrid"
    - "Data-driven"
    - "Fast and decisive"

  communication_style:
    - "Direct and blunt"
    - "Storytelling"
    - "Analogies and metaphors"
```

**Motivational Drivers:**
```yaml
motivational_drivers:
  primary:
    - name: "Impact"
      score: 95
      description: "Drive to make significant change"

  secondary:
    - name: "Mastery"
      score: 90
      description: "Pursuit of excellence"

    - name: "Autonomy"
      score: 85
      description: "Control over own destiny"

  tertiary:
    - name: "Legacy"
      score: 80
      description: "Building something lasting"
```

---

## 2. Specialization Taxonomy

### 2.1 Domain Hierarchy

```
DOMAINS (Top-level categories)
├── SPECIALIZATIONS (Professional roles)
│   └── SKILLS (Specific competencies)
│       └── PROFICIENCIES (Granular capabilities)
```

### 2.2 Complete Domain Taxonomy

#### Domain 1: BUSINESS & ENTREPRENEURSHIP

```yaml
domain:
  id: business_entrepreneurship
  name: "Business & Entrepreneurship"

  specializations:
    - id: entrepreneur
      name: "Entrepreneur"
      skills:
        - id: business_strategy
          name: "Business Strategy"
          proficiencies:
            - {id: market_analysis, name: "Market Analysis"}
            - {id: competitive_positioning, name: "Competitive Positioning"}
            - {id: business_model_design, name: "Business Model Design"}
            - {id: strategic_planning, name: "Strategic Planning"}

        - id: fundraising
          name: "Fundraising"
          proficiencies:
            - {id: pitch_creation, name: "Pitch Creation"}
            - {id: investor_relations, name: "Investor Relations"}
            - {id: valuation_negotiation, name: "Valuation Negotiation"}
            - {id: term_sheet_navigation, name: "Term Sheet Navigation"}

        - id: scaling_operations
          name: "Scaling Operations"
          proficiencies:
            - {id: hiring_systems, name: "Hiring Systems"}
            - {id: process_optimization, name: "Process Optimization"}
            - {id: delegation, name: "Delegation"}
            - {id: org_design, name: "Organizational Design"}

    - id: operator
      name: "Operator/CEO"
      skills:
        - id: leadership
          name: "Leadership"
          proficiencies:
            - {id: team_building, name: "Team Building"}
            - {id: culture_design, name: "Culture Design"}
            - {id: performance_management, name: "Performance Management"}
            - {id: conflict_resolution, name: "Conflict Resolution"}

        - id: execution
          name: "Execution"
          proficiencies:
            - {id: prioritization, name: "Prioritization"}
            - {id: decision_velocity, name: "Decision Velocity"}
            - {id: accountability_systems, name: "Accountability Systems"}
            - {id: problem_solving, name: "Problem Solving"}

    - id: investor
      name: "Investor"
      skills:
        - id: deal_evaluation
          name: "Deal Evaluation"
          proficiencies:
            - {id: due_diligence, name: "Due Diligence"}
            - {id: founder_assessment, name: "Founder Assessment"}
            - {id: market_sizing, name: "Market Sizing"}
            - {id: risk_assessment, name: "Risk Assessment"}
```

#### Domain 2: MARKETING & SALES

```yaml
domain:
  id: marketing_sales
  name: "Marketing & Sales"

  specializations:
    - id: copywriter
      name: "Copywriter"
      skills:
        - id: direct_response_copywriting
          name: "Direct Response Copywriting"
          proficiencies:
            - {id: hooks, name: "Hooks"}
            - {id: headlines, name: "Headlines"}
            - {id: offers, name: "Offers"}
            - {id: guarantees, name: "Guarantees"}
            - {id: calls_to_action, name: "Calls to Action"}
            - {id: bullets, name: "Bullets"}
            - {id: fascinations, name: "Fascinations"}
            - {id: storytelling, name: "Storytelling"}

        - id: sales_letters
          name: "Sales Letters"
          proficiencies:
            - {id: long_form_sales_letters, name: "Long-form Sales Letters"}
            - {id: vsl_scripts, name: "VSL Scripts"}
            - {id: email_sequences, name: "Email Sequences"}
            - {id: landing_pages, name: "Landing Pages"}

        - id: persuasion_psychology
          name: "Persuasion Psychology"
          proficiencies:
            - {id: scarcity, name: "Scarcity"}
            - {id: urgency, name: "Urgency"}
            - {id: social_proof, name: "Social Proof"}
            - {id: authority, name: "Authority"}
            - {id: reciprocity, name: "Reciprocity"}
            - {id: commitment_consistency, name: "Commitment & Consistency"}

    - id: marketer
      name: "Marketer"
      skills:
        - id: growth_marketing
          name: "Growth Marketing"
          proficiencies:
            - {id: funnel_design, name: "Funnel Design"}
            - {id: conversion_optimization, name: "Conversion Optimization"}
            - {id: retention_strategies, name: "Retention Strategies"}
            - {id: viral_loops, name: "Viral Loops"}

        - id: positioning
          name: "Positioning"
          proficiencies:
            - {id: brand_positioning, name: "Brand Positioning"}
            - {id: messaging, name: "Messaging"}
            - {id: differentiation, name: "Differentiation"}
            - {id: category_creation, name: "Category Creation"}

    - id: salesperson
      name: "Salesperson"
      skills:
        - id: closing
          name: "Closing"
          proficiencies:
            - {id: objection_handling, name: "Objection Handling"}
            - {id: trial_closes, name: "Trial Closes"}
            - {id: assumptive_closing, name: "Assumptive Closing"}
            - {id: price_anchoring, name: "Price Anchoring"}
```

#### Domain 3: TECHNOLOGY & ENGINEERING

```yaml
domain:
  id: technology_engineering
  name: "Technology & Engineering"

  specializations:
    - id: software_engineer
      name: "Software Engineer"
      skills:
        - id: programming
          name: "Programming"
          proficiencies:
            - {id: python, name: "Python"}
            - {id: javascript, name: "JavaScript"}
            - {id: typescript, name: "TypeScript"}
            - {id: rust, name: "Rust"}
            - {id: go, name: "Go"}

        - id: architecture
          name: "System Architecture"
          proficiencies:
            - {id: distributed_systems, name: "Distributed Systems"}
            - {id: scalability, name: "Scalability"}
            - {id: microservices, name: "Microservices"}
            - {id: api_design, name: "API Design"}

    - id: ai_researcher
      name: "AI Researcher"
      skills:
        - id: machine_learning
          name: "Machine Learning"
          proficiencies:
            - {id: deep_learning, name: "Deep Learning"}
            - {id: nlp, name: "Natural Language Processing"}
            - {id: computer_vision, name: "Computer Vision"}
            - {id: reinforcement_learning, name: "Reinforcement Learning"}

    - id: product_manager
      name: "Product Manager"
      skills:
        - id: product_strategy
          name: "Product Strategy"
          proficiencies:
            - {id: roadmap_planning, name: "Roadmap Planning"}
            - {id: user_research, name: "User Research"}
            - {id: feature_prioritization, name: "Feature Prioritization"}
            - {id: metrics_analytics, name: "Metrics & Analytics"}
```

#### Domain 4: CREATIVE & CONTENT

```yaml
domain:
  id: creative_content
  name: "Creative & Content"

  specializations:
    - id: writer
      name: "Writer"
      skills:
        - id: writing_styles
          name: "Writing Styles"
          proficiencies:
            - {id: non_fiction, name: "Non-Fiction"}
            - {id: fiction, name: "Fiction"}
            - {id: technical_writing, name: "Technical Writing"}
            - {id: journalism, name: "Journalism"}

        - id: content_creation
          name: "Content Creation"
          proficiencies:
            - {id: blog_posts, name: "Blog Posts"}
            - {id: essays, name: "Essays"}
            - {id: books, name: "Books"}
            - {id: scripts, name: "Scripts"}

    - id: speaker
      name: "Speaker/Presenter"
      skills:
        - id: public_speaking
          name: "Public Speaking"
          proficiencies:
            - {id: keynote_speeches, name: "Keynote Speeches"}
            - {id: storytelling_on_stage, name: "Storytelling on Stage"}
            - {id: audience_engagement, name: "Audience Engagement"}
            - {id: presentation_design, name: "Presentation Design"}
```

#### Domain 5: STRATEGY & CONSULTING

```yaml
domain:
  id: strategy_consulting
  name: "Strategy & Consulting"

  specializations:
    - id: strategist
      name: "Strategist"
      skills:
        - id: strategic_thinking
          name: "Strategic Thinking"
          proficiencies:
            - {id: scenario_planning, name: "Scenario Planning"}
            - {id: competitive_analysis, name: "Competitive Analysis"}
            - {id: trend_forecasting, name: "Trend Forecasting"}
            - {id: systems_thinking, name: "Systems Thinking"}

        - id: frameworks
          name: "Strategic Frameworks"
          proficiencies:
            - {id: swot_analysis, name: "SWOT Analysis"}
            - {id: porters_five_forces, name: "Porter's Five Forces"}
            - {id: blue_ocean_strategy, name: "Blue Ocean Strategy"}
            - {id: jobs_to_be_done, name: "Jobs to Be Done"}

    - id: consultant
      name: "Consultant"
      skills:
        - id: problem_diagnosis
          name: "Problem Diagnosis"
          proficiencies:
            - {id: root_cause_analysis, name: "Root Cause Analysis"}
            - {id: data_analysis, name: "Data Analysis"}
            - {id: hypothesis_testing, name: "Hypothesis Testing"}
            - {id: recommendation_synthesis, name: "Recommendation Synthesis"}
```

#### Domain 6: PERSONAL DEVELOPMENT

```yaml
domain:
  id: personal_development
  name: "Personal Development"

  specializations:
    - id: life_coach
      name: "Life Coach"
      skills:
        - id: coaching
          name: "Coaching"
          proficiencies:
            - {id: active_listening, name: "Active Listening"}
            - {id: powerful_questions, name: "Powerful Questions"}
            - {id: goal_setting, name: "Goal Setting"}
            - {id: accountability, name: "Accountability"}

    - id: philosopher
      name: "Philosopher"
      skills:
        - id: philosophy
          name: "Philosophy"
          proficiencies:
            - {id: ethics, name: "Ethics"}
            - {id: epistemology, name: "Epistemology"}
            - {id: metaphysics, name: "Metaphysics"}
            - {id: logic, name: "Logic"}
```

---

## 3. Scoring System

### 3.1 Scoring Scales

**Domain-Level Score:**
- Range: 0-100
- Calculated as weighted average of specializations
- Represents overall mastery in that domain

**Specialization-Level Score:**
- Range: 0-100
- Calculated as weighted average of skills
- Represents role mastery

**Skill-Level Score:**
- Range: 0-100
- Calculated as weighted average of proficiencies
- Represents specific skill competency

**Proficiency-Level Score:**
- Range: 0-100
- Granular capability assessment
- Based on evidence from sources

### 3.2 Score Aggregation Formula

**Bottom-Up Calculation (Proficiency → Skill → Specialization → Domain):**

```
Skill Score = Σ(proficiency_score_i × evidence_weight_i) / Σ(evidence_weight_i)

Where:
- proficiency_score_i = Individual proficiency score (0-100)
- evidence_weight_i = Total evidence weight for that proficiency (sum of all evidence weights, typically 1-30)
- Default weight = 1 if no evidence specified

Example:
direct_response_copywriting_score =
  (hooks:98 × 28) + (offers:99 × 30) + (headlines:95 × 25) + (storytelling:90 × 18)
  ----------------------------------------------------------------
  28 + 30 + 25 + 18

  = (2744 + 2970 + 2375 + 1620) / 101
  = 9709 / 101
  = 96.13 ≈ 96
```

**Specialization Score:**
```
Specialization Score = Σ(skill_score_i × proficiency_count_i) / Σ(proficiency_count_i)

Where:
- skill_score_i = Calculated skill score (from formula above)
- proficiency_count_i = Number of proficiencies in that skill (represents breadth)

Example:
copywriter_score =
  (direct_response:96 × 8) + (sales_letters:88 × 5) + (persuasion_psych:93 × 8)
  --------------------------------------------------------------------------
  8 + 5 + 8

  = (768 + 440 + 744) / 21
  = 1952 / 21
  = 92.95 ≈ 93
```

**Domain Score:**
```
Domain Score = Σ(specialization_score_i × skill_count_i) / Σ(skill_count_i)

Where:
- specialization_score_i = Calculated specialization score
- skill_count_i = Number of skills in that specialization

Example:
marketing_sales_score =
  (copywriter:93 × 4) + (marketer:85 × 4) + (salesperson:78 × 4)
  ---------------------------------------------------------------
  4 + 4 + 4

  = (372 + 340 + 312) / 12
  = 1024 / 12
  = 85.33 ≈ 85
```

**Confidence Weighting (Optional):**

When aggregating, confidence levels can be used as additional weights:
```
confidence_multiplier:
  high: 1.0
  medium: 0.75
  low: 0.5

weighted_score = (score × confidence_multiplier × evidence_weight) / (confidence_multiplier × evidence_weight)
```

**SQL Implementation:**
```sql
-- Skill-level aggregation
SELECT
    s.id AS skill_id,
    s.name AS skill_name,
    ROUND(
        SUM(ms.score * se.total_evidence_weight) /
        SUM(se.total_evidence_weight),
        2
    ) AS skill_score
FROM skills s
JOIN proficiencies p ON p.skill_id = s.id
JOIN mind_scores ms ON ms.proficiency_id = p.id
JOIN (
    SELECT score_id, SUM(weight) AS total_evidence_weight
    FROM score_evidence
    GROUP BY score_id
) se ON se.score_id = ms.id
WHERE ms.mind_id = 'alex_hormozi'
GROUP BY s.id;

-- Specialization-level aggregation
SELECT
    sp.id AS specialization_id,
    sp.name AS specialization_name,
    ROUND(
        SUM(skill_scores.score * skill_scores.proficiency_count) /
        SUM(skill_scores.proficiency_count),
        2
    ) AS specialization_score
FROM specializations sp
JOIN skills s ON s.specialization_id = sp.id
JOIN (
    SELECT
        s.id AS skill_id,
        ROUND(AVG(ms.score), 2) AS score,
        COUNT(p.id) AS proficiency_count
    FROM skills s
    JOIN proficiencies p ON p.skill_id = s.id
    JOIN mind_scores ms ON ms.proficiency_id = p.id
    WHERE ms.mind_id = 'alex_hormozi'
    GROUP BY s.id
) skill_scores ON skill_scores.skill_id = s.id
GROUP BY sp.id;
```

### 3.2 Evidence-Based Scoring

Each score must be backed by evidence:

```yaml
proficiency_score:
  proficiency_id: "hooks"
  score: 95
  confidence: "high"

  evidence:
    - source_id: "100m_offers_book"
      quote: "The offer is so good people feel stupid saying no"
      weight: 10

    - source_id: "youtube_ad_breakdown"
      observation: "Analyzed 47 hooks, 89% conversion rate"
      weight: 8

    - source_id: "gym_launch_sales_data"
      metric: "$100M in sales attributed to hook methodology"
      weight: 10

  benchmarks:
    - "Top 1% of copywriters"
    - "Published methodology used by 10,000+ businesses"

  validation:
    method: "triangulation"
    sources_count: 3
    expert_review: true
```

### 3.3 Scoring Rubrics

**Score Interpretation:**

| Score | Level | Description | Evidence Required |
|-------|-------|-------------|-------------------|
| 0-20 | Novice | Basic awareness, limited application | 1-2 mentions in sources |
| 21-40 | Beginner | Some practice, developing competency | 3-5 examples of application |
| 41-60 | Intermediate | Regular application, proven results | 6-10 documented successes |
| 61-80 | Advanced | Expert-level execution, teaching others | 10+ successes + teaching/publishing |
| 81-100 | Master | Industry-leading, innovative contributions | Published methodology + proven impact at scale |

**Example: Alex Hormozi - Copywriting Scores**

```yaml
specialization: copywriter
overall_score: 92

skills:
  direct_response_copywriting:
    score: 95
    proficiencies:
      hooks:
        score: 98
        evidence: "Created '$100M Offers' framework, taught 10K+ students"

      offers:
        score: 99
        evidence: "Published book '100M Offers', proven $100M+ in attributed sales"

      guarantees:
        score: 95
        evidence: "Risk reversal methodology used across portfolio companies"

      storytelling:
        score: 90
        evidence: "YouTube content with 50M+ views, narrative-driven sales"

  sales_letters:
    score: 88
    proficiencies:
      vsl_scripts:
        score: 92
        evidence: "Multiple 8-figure VSL campaigns"

      email_sequences:
        score: 85
        evidence: "High-converting email sequences documented"

  persuasion_psychology:
    score: 93
    proficiencies:
      scarcity:
        score: 95
        evidence: "Scarcity tactics in Gym Launch generated $46M in 3 years"

      value_stacking:
        score: 98
        evidence: "Value equation framework (Dream Outcome, Perceived Likelihood, Time Delay, Effort & Sacrifice)"
```

### 3.4 Comparative Scoring

**Mind-to-Mind Comparison:**

```yaml
comparison:
  domain: "marketing_sales"
  specialization: "copywriter"
  skill: "direct_response_copywriting"

  minds:
    - mind_id: "alex_hormozi"
      score: 95
      strength: "Offers and value stacking"

    - mind_id: "eugene_schwartz"
      score: 98
      strength: "Mass desire and market sophistication"

    - mind_id: "dan_kennedy"
      score: 96
      strength: "Direct mail and info-product funnels"

  ranking:
    1. eugene_schwartz (98)
    2. dan_kennedy (96)
    3. alex_hormozi (95)

  insights:
    - "Schwartz excels at deep market psychology"
    - "Hormozi strongest at modern offer creation"
    - "Kennedy best for multi-step sequences"
```

---

## 4. Database Schema

### 4.1 Core Tables

```sql
-- Cognitive Profiles
CREATE TABLE IF NOT EXISTS cognitive_profiles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mind_id TEXT NOT NULL,
    profile_type TEXT NOT NULL,  -- 'disc', 'mbti', 'enneagram', 'big_five', etc.
    profile_data JSON NOT NULL,  -- Full profile as JSON
    confidence TEXT DEFAULT 'medium',
    evidence JSON,               -- Supporting evidence
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (mind_id) REFERENCES minds(id) ON DELETE CASCADE,
    UNIQUE(mind_id, profile_type)
);

-- Domains (Top-level categories)
CREATE TABLE IF NOT EXISTS domains (
    id TEXT PRIMARY KEY,         -- 'business_entrepreneurship'
    name TEXT NOT NULL,          -- 'Business & Entrepreneurship'
    description TEXT,
    icon TEXT,                   -- Icon/emoji for UI
    sort_order INTEGER DEFAULT 0
);

-- Specializations (Professional roles)
CREATE TABLE IF NOT EXISTS specializations (
    id TEXT PRIMARY KEY,         -- 'copywriter'
    domain_id TEXT NOT NULL,
    name TEXT NOT NULL,          -- 'Copywriter'
    description TEXT,
    icon TEXT,
    sort_order INTEGER DEFAULT 0,
    FOREIGN KEY (domain_id) REFERENCES domains(id) ON DELETE CASCADE
);

-- Skills (Specific competencies)
CREATE TABLE IF NOT EXISTS skills (
    id TEXT PRIMARY KEY,         -- 'direct_response_copywriting'
    specialization_id TEXT NOT NULL,
    name TEXT NOT NULL,          -- 'Direct Response Copywriting'
    description TEXT,
    sort_order INTEGER DEFAULT 0,
    FOREIGN KEY (specialization_id) REFERENCES specializations(id) ON DELETE CASCADE
);

-- Proficiencies (Granular capabilities)
CREATE TABLE IF NOT EXISTS proficiencies (
    id TEXT PRIMARY KEY,         -- 'hooks'
    skill_id TEXT NOT NULL,
    name TEXT NOT NULL,          -- 'Hooks'
    description TEXT,
    sort_order INTEGER DEFAULT 0,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

-- Mind Scores (Individual assessments)
CREATE TABLE IF NOT EXISTS mind_scores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mind_id TEXT NOT NULL,

    -- Score can be at any level
    domain_id TEXT,              -- NULL if more granular
    specialization_id TEXT,      -- NULL if domain-level or more granular
    skill_id TEXT,               -- NULL if less granular
    proficiency_id TEXT,         -- NULL if less granular

    score INTEGER NOT NULL CHECK(score BETWEEN 0 AND 100),
    confidence TEXT DEFAULT 'medium',  -- 'high', 'medium', 'low'

    evidence JSON,               -- Supporting evidence
    benchmarks JSON,             -- Comparative benchmarks
    notes TEXT,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (mind_id) REFERENCES minds(id) ON DELETE CASCADE,
    FOREIGN KEY (domain_id) REFERENCES domains(id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES specializations(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
    FOREIGN KEY (proficiency_id) REFERENCES proficiencies(id) ON DELETE CASCADE,

    -- Ensure at least one level is specified
    CHECK (
        domain_id IS NOT NULL OR
        specialization_id IS NOT NULL OR
        skill_id IS NOT NULL OR
        proficiency_id IS NOT NULL
    )
);

-- Mind Specializations (Primary roles)
CREATE TABLE IF NOT EXISTS mind_specializations (
    mind_id TEXT NOT NULL,
    specialization_id TEXT NOT NULL,
    is_primary INTEGER DEFAULT 0,  -- 0 or 1 (boolean)
    rank INTEGER,                   -- 1, 2, 3... (priority order)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (mind_id, specialization_id),
    FOREIGN KEY (mind_id) REFERENCES minds(id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES specializations(id) ON DELETE CASCADE
);

-- Score Evidence (Detailed proof)
CREATE TABLE IF NOT EXISTS score_evidence (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    score_id INTEGER NOT NULL,
    source_id INTEGER,           -- Reference to sources table
    evidence_type TEXT NOT NULL, -- 'quote', 'observation', 'metric', 'publication'
    content TEXT NOT NULL,
    weight INTEGER DEFAULT 5 CHECK(weight BETWEEN 1 AND 10),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (score_id) REFERENCES mind_scores(id) ON DELETE CASCADE,
    FOREIGN KEY (source_id) REFERENCES sources(id) ON DELETE SET NULL
);
```

### 4.2 Views for Analytics

```sql
-- View: Mind Domain Scores (Aggregated)
CREATE VIEW mind_domain_scores AS
SELECT
    m.id AS mind_id,
    m.display_name,
    d.id AS domain_id,
    d.name AS domain_name,
    ROUND(AVG(ms.score), 2) AS avg_score,
    COUNT(DISTINCT ms.specialization_id) AS specializations_count,
    COUNT(ms.id) AS total_scores
FROM minds m
JOIN mind_scores ms ON m.id = ms.mind_id
JOIN domains d ON ms.domain_id = d.id OR ms.specialization_id IN (
    SELECT id FROM specializations WHERE domain_id = d.id
)
GROUP BY m.id, d.id;

-- View: Mind Specialization Scores (Aggregated)
CREATE VIEW mind_specialization_scores AS
SELECT
    m.id AS mind_id,
    m.display_name,
    s.id AS specialization_id,
    s.name AS specialization_name,
    d.name AS domain_name,
    ROUND(AVG(ms.score), 2) AS avg_score,
    COUNT(ms.id) AS skills_scored
FROM minds m
JOIN mind_scores ms ON m.id = ms.mind_id
JOIN specializations s ON ms.specialization_id = s.id
JOIN domains d ON s.domain_id = d.id
GROUP BY m.id, s.id;

-- View: Top Minds by Specialization
CREATE VIEW top_minds_by_specialization AS
SELECT
    s.id AS specialization_id,
    s.name AS specialization_name,
    m.id AS mind_id,
    m.display_name AS mind_name,
    ROUND(AVG(ms.score), 2) AS avg_score,
    RANK() OVER (PARTITION BY s.id ORDER BY AVG(ms.score) DESC) AS rank
FROM specializations s
JOIN mind_scores ms ON ms.specialization_id = s.id
JOIN minds m ON ms.mind_id = m.id
GROUP BY s.id, m.id;

-- View: Mind Correlation Matrix
CREATE VIEW mind_correlation_matrix AS
SELECT
    m1.display_name AS mind_1,
    m2.display_name AS mind_2,
    COUNT(DISTINCT CASE WHEN ms1.proficiency_id = ms2.proficiency_id THEN ms1.proficiency_id END) AS shared_proficiencies,
    ROUND(AVG(ABS(ms1.score - ms2.score)), 2) AS avg_score_difference
FROM minds m1
JOIN mind_scores ms1 ON m1.id = ms1.mind_id
JOIN minds m2 ON m2.id != m1.id
JOIN mind_scores ms2 ON m2.id = ms2.mind_id AND ms1.proficiency_id = ms2.proficiency_id
GROUP BY m1.id, m2.id;
```

---

## 5. Use Cases

### Use Case 1: Find Best Mind for Specific Task

**Query: "Who is the best mind for writing offer copy?"**

```sql
SELECT
    m.display_name,
    ms.score AS offer_score,
    se.content AS evidence_sample
FROM minds m
JOIN mind_scores ms ON m.id = ms.mind_id
JOIN proficiencies p ON ms.proficiency_id = p.id
LEFT JOIN score_evidence se ON ms.id = se.score_id
WHERE p.id = 'offers'
ORDER BY ms.score DESC, ms.confidence DESC
LIMIT 5;
```

**Result:**
```
1. Alex Hormozi (99) - "Published '100M Offers', $100M+ attributed sales"
2. Eugene Schwartz (95) - "Breakthrough Advertising offer frameworks"
3. Dan Kennedy (92) - "Info-product offer architecture"
```

### Use Case 2: Mind Similarity Analysis

**Query: "Which minds are most similar to Alex Hormozi?"**

```sql
WITH hormozi_profile AS (
    SELECT proficiency_id, score
    FROM mind_scores
    WHERE mind_id = 'alex_hormozi'
)
SELECT
    m.display_name,
    COUNT(DISTINCT ms.proficiency_id) AS shared_proficiencies,
    ROUND(AVG(ABS(hp.score - ms.score)), 2) AS avg_diff,
    100 - ROUND(AVG(ABS(hp.score - ms.score)), 2) AS similarity_score
FROM minds m
JOIN mind_scores ms ON m.id = ms.mind_id
JOIN hormozi_profile hp ON ms.proficiency_id = hp.proficiency_id
WHERE m.id != 'alex_hormozi'
GROUP BY m.id
ORDER BY similarity_score DESC
LIMIT 5;
```

**Result:**
```
1. Dan Kennedy (87% similar) - Direct response, sales systems
2. Russell Brunson (83% similar) - Funnels, offers, continuity
3. Eugene Schwartz (79% similar) - Copywriting fundamentals
```

### Use Case 3: Gap Analysis for Mind Development

**Query: "What skills should Sam Altman develop to become a better operator?"**

```sql
WITH sam_scores AS (
    SELECT s.id AS skill_id, s.name, COALESCE(ms.score, 0) AS sam_score
    FROM skills s
    LEFT JOIN mind_scores ms ON s.id = ms.skill_id AND ms.mind_id = 'sam_altman'
    WHERE s.specialization_id = 'operator'
),
benchmark_scores AS (
    SELECT
        s.id AS skill_id,
        ROUND(AVG(ms.score), 2) AS avg_score
    FROM skills s
    JOIN mind_scores ms ON s.id = ms.skill_id
    WHERE s.specialization_id = 'operator'
    GROUP BY s.id
)
SELECT
    ss.name AS skill,
    ss.sam_score,
    bs.avg_score AS industry_avg,
    bs.avg_score - ss.sam_score AS gap
FROM sam_scores ss
JOIN benchmark_scores bs ON ss.skill_id = bs.skill_id
WHERE bs.avg_score - ss.sam_score > 10
ORDER BY gap DESC;
```

**Result:**
```
Skill                    Sam  Avg  Gap
--------------------------------------
Performance Management    60   85   25
Conflict Resolution       55   78   23
Delegation               65   82   17
```

### Use Case 4: Build Dream Team

**Query: "Recommend 3 minds to build a complete marketing team"**

```sql
WITH marketing_roles AS (
    SELECT id, name
    FROM specializations
    WHERE domain_id = 'marketing_sales'
),
best_per_role AS (
    SELECT
        s.name AS role,
        m.display_name AS mind,
        AVG(ms.score) AS avg_score,
        RANK() OVER (PARTITION BY s.id ORDER BY AVG(ms.score) DESC) AS rank
    FROM specializations s
    JOIN mind_scores ms ON ms.specialization_id = s.id
    JOIN minds m ON ms.mind_id = m.id
    WHERE s.id IN (SELECT id FROM marketing_roles)
    GROUP BY s.id, m.id
)
SELECT role, mind, ROUND(avg_score, 2) AS score
FROM best_per_role
WHERE rank = 1
ORDER BY role;
```

**Result:**
```
Role          Mind              Score
---------------------------------------
Copywriter    Alex Hormozi       95
Marketer      Russell Brunson    92
Salesperson   Grant Cardone      88
```

### Use Case 5: Personality-Based Recommendations

**Query: "Find minds with DISC profile similar to mine (Di)"**

```sql
SELECT
    m.display_name,
    json_extract(cp.profile_data, '$.profile_code') AS disc_profile,
    json_extract(cp.profile_data, '$.D') AS dominance,
    json_extract(cp.profile_data, '$.I') AS influence
FROM minds m
JOIN cognitive_profiles cp ON m.id = cp.mind_id
WHERE cp.profile_type = 'disc'
    AND json_extract(cp.profile_data, '$.profile_code') LIKE 'D%'
ORDER BY
    ABS(json_extract(cp.profile_data, '$.D') - 95) +
    ABS(json_extract(cp.profile_data, '$.I') - 70)
LIMIT 5;
```

---

## 6. Implementation Examples

### 6.1 Complete Mind Profile: Alex Hormozi

```yaml
mind:
  id: alex_hormozi
  display_name: Alex Hormozi

  # Cognitive Profiles
  cognitive_profiles:
    disc:
      D: 95
      I: 70
      S: 20
      C: 65
      profile_code: "Di"
      primary_type: "D"

    mbti:
      type: "ENTJ"
      archetype: "The Commander"

    enneagram:
      core_type: 8
      wing: "8w7"
      triadic_center: "gut"

    big_five:
      openness: 85
      conscientiousness: 90
      extraversion: 75
      agreeableness: 40
      neuroticism: 20

  # Primary Specializations
  primary_specializations:
    - id: entrepreneur
      rank: 1
      is_primary: true

    - id: copywriter
      rank: 2
      is_primary: false

    - id: operator
      rank: 3
      is_primary: false

  # Domain Scores
  domain_scores:
    business_entrepreneurship: 93
    marketing_sales: 92
    strategy_consulting: 85

  # Detailed Specialization Scores
  specialization_scores:
    entrepreneur:
      overall: 93
      skills:
        business_strategy:
          score: 90
          proficiencies:
            market_analysis: 88
            business_model_design: 95
            strategic_planning: 87

        scaling_operations:
          score: 96
          proficiencies:
            hiring_systems: 98
            process_optimization: 95
            delegation: 94

    copywriter:
      overall: 92
      skills:
        direct_response_copywriting:
          score: 95
          proficiencies:
            hooks: 98
            offers: 99
            guarantees: 95
            storytelling: 90

        persuasion_psychology:
          score: 93
          proficiencies:
            scarcity: 95
            value_stacking: 98
            social_proof: 90

    operator:
      overall: 88
      skills:
        leadership:
          score: 90
          proficiencies:
            team_building: 92
            culture_design: 88
            performance_management: 90

        execution:
          score: 95
          proficiencies:
            prioritization: 98
            decision_velocity: 96
            problem_solving: 93

  # Evidence Summary
  evidence_summary:
    total_sources: 47
    books_authored: 2  # "$100M Offers", "$100M Leads"
    companies_built: 5
    proven_revenue: "$200M+"
    students_taught: "10,000+"
```

### 6.2 Correlation Analysis Example

**Alex Hormozi vs Eugene Schwartz:**

```yaml
correlation_analysis:
  mind_1: alex_hormozi
  mind_2: eugene_schwartz

  shared_specializations:
    - copywriter

  shared_proficiencies:
    count: 12
    list:
      - hooks
      - headlines
      - offers
      - storytelling
      - persuasion_psychology
      # ... etc

  score_comparison:
    - proficiency: "offers"
      hormozi: 99
      schwartz: 95
      difference: +4
      winner: "hormozi"
      note: "Modern offer creation methodology"

    - proficiency: "mass_desire"
      hormozi: 85
      schwartz: 99
      difference: -14
      winner: "schwartz"
      note: "Deep market psychology mastery"

    - proficiency: "hooks"
      hormozi: 98
      schwartz: 96
      difference: +2
      winner: "hormozi"
      note: "Modern social media hooks"

  overall_similarity: 79%

  complementary_strengths:
    - "Schwartz: Market sophistication theory"
    - "Hormozi: Modern scaling systems"
    - "Schwartz: Mass desire manipulation"
    - "Hormozi: Offer value stacking"

  recommended_use_cases:
    hormozi:
      - "Creating modern offers"
      - "Scaling service businesses"
      - "Building growth systems"

    schwartz:
      - "Deep market research"
      - "Long-form sales letters"
      - "Understanding buyer psychology"
```

---

## Appendix A: Seed Data - Domains & Specializations

```sql
-- Insert Domains
INSERT INTO domains (id, name, sort_order) VALUES
('business_entrepreneurship', 'Business & Entrepreneurship', 1),
('marketing_sales', 'Marketing & Sales', 2),
('technology_engineering', 'Technology & Engineering', 3),
('creative_content', 'Creative & Content', 4),
('strategy_consulting', 'Strategy & Consulting', 5),
('personal_development', 'Personal Development', 6);

-- Insert Specializations
INSERT INTO specializations (id, domain_id, name, sort_order) VALUES
('entrepreneur', 'business_entrepreneurship', 'Entrepreneur', 1),
('operator', 'business_entrepreneurship', 'Operator/CEO', 2),
('investor', 'business_entrepreneurship', 'Investor', 3),
('copywriter', 'marketing_sales', 'Copywriter', 1),
('marketer', 'marketing_sales', 'Marketer', 2),
('salesperson', 'marketing_sales', 'Salesperson', 3),
('software_engineer', 'technology_engineering', 'Software Engineer', 1),
('ai_researcher', 'technology_engineering', 'AI Researcher', 2),
('product_manager', 'technology_engineering', 'Product Manager', 3),
('writer', 'creative_content', 'Writer', 1),
('speaker', 'creative_content', 'Speaker/Presenter', 2),
('strategist', 'strategy_consulting', 'Strategist', 1),
('consultant', 'strategy_consulting', 'Consultant', 2),
('life_coach', 'personal_development', 'Life Coach', 1),
('philosopher', 'personal_development', 'Philosopher', 2);
```

---

## Appendix B: CLI Commands for Profiling

```bash
# View mind cognitive profile
aios-mind profile --mind alex_hormozi --type disc

# View mind specialization scores
aios-mind scores --mind alex_hormozi --specialization copywriter

# Compare two minds
aios-mind compare --mind1 alex_hormozi --mind2 eugene_schwartz

# Find best mind for task
aios-mind recommend --task "write offer copy" --top 5

# Analyze mind gaps
aios-mind gaps --mind sam_altman --target-role operator

# Export full profile
aios-mind export --mind alex_hormozi --format yaml --output hormozi_profile.yaml

# Import scores from CSV
aios-mind import-scores --file scores.csv --mind alex_hormozi

# Generate correlation matrix
aios-mind correlate --minds alex_hormozi,eugene_schwartz,dan_kennedy --output matrix.csv
```

---

**END OF DOCUMENT**

*This profiling system enables precise mind categorization, skill assessment, and intelligent recommendations across the MMOS ecosystem.*
