# Product Requirements Document (PRD)
## InnerLens Psychological Analysis System v3.0

| **Status** | **Author** | **Last Updated** | **Version** |
|:-----------|:-----------|:-----------------|:------------|
| **FINAL DRAFT** | PM + AI Research Team | 2025-10-13 | **3.0** |
| **Reviewers** | CTO, Research Lead, Ethics Officer | **Approval Target** | 2025-10-15 |

---

## 📑 Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Background & Strategic Context](#2-background--strategic-context)
3. [Goals & Success Metrics](#3-goals--success-metrics)
4. [User Personas & Use Cases](#4-user-personas--use-cases)
5. [System Architecture](#5-system-architecture)
6. [Database Schema](#6-database-schema)
7. [The 8 Agents (Core Intelligence)](#7-the-8-agents-core-intelligence)
8. [API Specification](#8-api-specification)
9. [Epic Breakdown](#9-epic-breakdown)
10. [Technical Stack](#10-technical-stack)
11. [Security & Privacy](#11-security--privacy)
12. [Testing Strategy](#12-testing-strategy)
13. [Deployment Strategy](#13-deployment-strategy)
14. [Budget & Resources](#14-budget--resources)
15. [Timeline & Milestones](#15-timeline--milestones)
16. [Risks & Mitigations](#16-risks--mitigations)
17. [Open Questions & Decisions](#17-open-questions--decisions)
18. [Appendices](#18-appendices)

---

## 1. Executive Summary

### 1.1 The Problem

**Current State:**
- Psychological assessment is expensive ($500-2000 per person), slow (weeks), and non-scalable
- Traditional methods (Big Five, MBTI) capture only 5-16 dimensions with no causal depth
- No rastreability: scores provided without evidence trail
- No temporal analysis: snapshots only, evolution ignored
- Manual analysis required: 40-80 hours per profile

**Market Gap:**
- AI companies need realistic personality profiles for agent development
- Researchers need scalable psychological analysis for longitudinal studies  
- Individuals want deep self-understanding beyond surface-level tests
- No existing solution provides: depth (120 traits) + causality + auditability + self-improvement

### 1.2 Our Solution

**InnerLens v3.0: Fragment-Based Psychological Profiling System**

A multi-agent AI system that analyzes public/private content to construct:
- **120-trait psychological profiles** (vs. 5 in Big Five)
- **Hierarchical causality** (fundamental traits → derived traits)
- **100% auditability** (every score traces to textual evidence)
- **Temporal evolution** (how person changed over years)
- **Automated quality control** (self-critique at every stage)

**Processing:**
- Time: 60-90 minutes per profile
- Cost: $3-5 per profile (target: $2)
- Input: Public content OR private data (meetings, chats, journals)
- Output: Executive summary + narrative + structured JSON + evidence

### 1.3 Core Innovation: FRAGMENTS Architecture

**Key Architectural Decision:**

Instead of rigid Q&A format, we extract **FRAGMENTS** - flexible evidence units:

```
FRAGMENT = Any textual unit revealing psychology
  Types:
  ├─ qa_interview (Q&A from interviews)
  ├─ statement (declarations without questions)
  ├─ dialogue (peer-to-peer conversations)
  ├─ behavior_described (actions narrated)
  ├─ observation (third-party descriptions)
  ├─ chat_message (casual communications)
  └─ biographical_fact (objective life events)
```

**Why This Matters:**
- 1 podcast → 80 Q&As + 25 statements + 10 behaviors + 5 observations = **120 fragments**
- Old architecture: 1 podcast → 80 Q&As only = **50% less data**
- Enables private data: meetings, WhatsApp, emails (previously impossible)

### 1.4 First Application: Validation via Public Figures

**MVP Strategy:**
1. Process 20 public figures (Naval, Elon, etc.) using public content
2. Validate profiles with expert psychologists (target: 80%+ agreement)
3. Create "archetype library" (The Pragmatic Idealist, The Impatient Visionary, etc.)
4. Use as benchmarks + synthetic personas for AI development

**Post-MVP:**
5. Launch private user tier (analyze your own meetings, chats, journals)
6. Enterprise tier (team dynamics, hiring augmentation)

### 1.5 Key Metrics

| Metric | MVP Target | v1.0 Target |
|--------|-----------|-------------|
| **Profile Quality Grade** | 80% Grade B+ | 90% Grade A-/B+ |
| **Expert Agreement** | N/A (no baseline) | 80%+ agreement |
| **Processing Time** | <90min | <60min |
| **Cost per Profile** | <$5 | <$3 |
| **Traits Validated** | 85% | 90% |
| **Domain Coverage** | 8/10 domains | 10/10 domains |
| **API Uptime** | 99% | 99.5% |

### 1.6 Differentiators

| Competitor | Traits | Causality | Auditability | Temporal | Private Data | Cost |
|-----------|--------|-----------|--------------|----------|--------------|------|
| **Big Five Tests** | 5 | ❌ | ❌ | ❌ | ✅ | $0-50 |
| **MBTI** | 16 | ❌ | ❌ | ❌ | ✅ | $50 |
| **Full Psych Eval** | 30-50 | Partial | Partial | ❌ | ✅ | $500-2000 |
| **InnerLens v3.0** | **120** | **✅** | **✅** | **✅** | **✅** | **$3-5** |

### 1.7 Timeline & Investment

**6-Month MVP:** $204K investment
- Month 1-2: Foundation (schema, discovery, pre-eval)
- Month 3-4: Extraction & mapping
- Month 5: Validation & synthesis
- Month 6: API + 20 public figure profiles

**12-Month v1.0:** $380K total investment
- Month 7-9: Private data tier
- Month 10-12: Refinement + scale to 500 profiles

**Break-even:** ~50 profiles/month at $50-100 per profile

---

## 2. Background & Strategic Context

### 2.1 Market Context

**Personality Assessment Market: $4.2B/year (2024)**

Segments:
1. **Corporate Hiring:** $1.8B (MBTI, StrengthsFinder, etc.)
2. **Clinical Psychology:** $1.2B (MMPI, NEO-PI-R, etc.)
3. **Consumer/Self-Discovery:** $800M (online tests, apps)
4. **Academic Research:** $400M (custom instruments)

**Growth Drivers:**
- AI agent development needs realistic personas (new market, ~$200M/year by 2026)
- Remote work → need for async personality insights
- Mental health awareness → individuals seek deeper understanding
- LLM capabilities → enable analysis previously requiring humans

**Market Problems:**
1. **Existing tests are shallow:** Big Five = 5 dimensions, real humans have 100+
2. **No causality:** Tests don't explain WHY person has trait X
3. **Static snapshots:** No temporal evolution analysis
4. **Not auditable:** Scores without evidence = not actionable
5. **Expensive at depth:** Clinical evals cost $500-2000 per person

### 2.2 Competitive Landscape

**Direct Competitors:**

1. **Traditional Assessment Companies**
   - **Hogan Assessments:** $200/assessment, 7 scales, validated for hiring
   - **CliftonStrengths:** $50, 34 strengths, popular in corporate
   - **MBTI (Myers-Briggs):** $50-150, 16 types, widely criticized scientifically
   
   **Our Advantage:** 120 traits, causality, auditability, 10x cheaper

2. **AI Personality Analysis Startups**
   - **Crystal (crystal.com):** LinkedIn analysis → DISC profile, $50/mo
   - **Humantic AI:** Sales personality insights, $25/person
   
   **Our Advantage:** Depth (120 vs 4 traits), transparency, private data support

3. **Research Instruments**
   - **NEO-PI-R:** Gold standard, 240 items, $45 + manual scoring
   - **HEXACO:** 6 factors, free, research-focused
   
   **Our Advantage:** No self-report bias, longitudinal analysis, automated

**Indirect Competitors:**

1. **AI Coaching Apps** (Replika, Pi, Inflection)
   - Build relationship with user → implicit personality model
   - **Our Advantage:** Explicit analysis, faster, no long interaction needed

2. **HR Analytics Platforms** (Culture Amp, Lattice)
   - Team analytics from surveys
   - **Our Advantage:** Individual depth, not just aggregate

### 2.3 Strategic Pivot: API-First Approach

**Original Plan (Rejected):**
- Build consumer app first
- Try to acquire users
- Figure out if personality engine works later
- **Problem:** Massive risk - what if engine doesn't work?

**New Plan (Current):**
- Build personality engine first (the hard part)
- Validate with public figures (ground truth)
- Expose via API (monetize immediately)
- Build UI later (when engine proven)

**Why API-First:**
1. **De-risks:** Validates core technology before UI investment
2. **Revenue faster:** API customers pay more, have clearer ROI
3. **Feedback quality:** Developers give better feedback than consumers
4. **Multiple surfaces:** API enables web, mobile, enterprise, research
5. **Defensibility:** Hard-to-build engine > easy-to-copy UI

### 2.4 Why Now?

**Technology Enablers:**
1. **LLM Capabilities (2024):**
   - Claude Sonnet 4: 200K context, excellent reasoning
   - Cost: $3/M input tokens (down from $15 in 2023)
   - Quality: Can extract nuanced psychological insights

2. **Transcription Quality:**
   - Whisper: 95%+ accuracy
   - Cost: $0.006/minute (essentially free)
   - Enables podcast/video content at scale

3. **Data Availability:**
   - 100M+ hours of podcast content
   - Public figures have 10-100 hours each
   - Private users: Zoom, Slack, WhatsApp APIs

**Market Timing:**
1. **AI Agent Boom:** Companies need realistic personas (NOW)
2. **Remote Work:** Personality insights matter more (async teams)
3. **Mental Health:** $5B invested in 2023, growing 40% YoY

### 2.5 Previous Iterations & Learnings

**v1.0 (Rejected - Q&A Only):**
- Hardcoded Q&A extraction
- Only worked for podcasts
- 40% of sources unusable (essays, biographies, etc.)
- **Learning:** Need flexible architecture

**v2.0 (Rejected - Multiple Specialized Agents):**
- 5 discoverers (interview, essay, biography, social, private)
- 5 extractors (one per type)
- **Problem:** Complexity overhead, wrong assumption (1 source = 1 type)
- **Learning:** Sources contain MULTIPLE fragment types

**v3.0 (Current - Fragments Architecture):**
- Unified discoverer (finds quality sources, type-agnostic)
- Unified extractor (extracts ALL fragment types from any source)
- JSONB content field (flexible per type)
- **Result:** 85%+ sources processable (vs 40%), simpler architecture

---

## 3. Goals & Success Metrics

### 3.1 Primary Goals (MVP - 6 months)

**GOAL 1: Validate Psychological Engine**
- **What:** Prove we can build accurate 120-trait profiles
- **How:** Process 20 public figures, validate with experts
- **Success:** 80%+ agreement with expert psychologists on major traits

**GOAL 2: Create Archetype Library**
- **What:** Identify 6-8 personality archetypes from 20 profiles
- **How:** Cluster analysis + qualitative analysis
- **Success:** Archetypes are recognizable, useful for AI agent development

**GOAL 3: Deliver Production API**
- **What:** Stable API for profile generation
- **How:** 3 endpoints, 99% uptime, <500ms p95
- **Success:** 3-5 early partners using API successfully

**GOAL 4: Establish Technical Foundation**
- **What:** Scalable pipeline + schema for future growth
- **How:** Modular agents, versioned prompts, flexible schema
- **Success:** Can add private data tier in Months 7-9 without rewrite

### 3.2 Secondary Goals (v1.0 - 12 months)

**GOAL 5: Private Data Tier**
- **What:** Enable users to analyze own meetings, chats, journals
- **How:** Integrations with Zoom, Slack, WhatsApp, Google Drive
- **Success:** 50 private users processed, GDPR compliant

**GOAL 6: Scale & Optimize**
- **What:** 500 profiles, cost <$3, time <60min
- **How:** Prompt optimization, caching, batch processing
- **Success:** Unit economics work at scale

### 3.3 Success Metrics (Detailed)

#### 3.3.1 Quality Metrics (Core)

| Metric | Definition | Measurement | MVP Target | v1.0 Target |
|--------|-----------|-------------|-----------|-------------|
| **Profile Quality Grade** | Meta-Eval Agent score (A-F) | Automated scoring | 80% Grade B+ | 90% Grade A-/B+ |
| **Trait Validation Rate** | % traits passing cross-validation | Cross-Val Agent | 85% validated | 90% validated |
| **Expert Agreement** | Inter-rater reliability with psychologists | Cohen's Kappa | N/A (no baseline) | κ > 0.70 |
| **Fragment Redundancy** | % duplicate insights | Meta-Eval detection | <20% | <15% |
| **Domain Coverage** | Of 10 domains, how many covered | Meta-Eval analysis | 8/10 | 10/10 |
| **Layer Distribution** | % fragments Layer 5+ (deep) | Extraction stats | >60% | >70% |
| **False Positive Rate** | Traits detected but not real | Expert review | <10% | <5% |
| **Confidence Calibration** | Do confidence scores match accuracy? | Empirical validation | N/A (MVP) | RMSE <0.10 |

#### 3.3.2 Performance Metrics

| Metric | Definition | Measurement | MVP Target | v1.0 Target |
|--------|-----------|-------------|-----------|-------------|
| **Processing Time** | Minutes from start to profile | End-to-end timing | <90min | <60min |
| **Cost per Profile** | Total token cost (LLM calls) | Token tracking | <$5 | <$3 |
| **Token Efficiency** | Fragments per 100K tokens | Extraction yield | 25-30 | 35-40 |
| **API Latency (p95)** | 95th percentile response time | Monitoring | <500ms | <300ms |
| **API Uptime** | % time API available | Uptime monitoring | 99.0% | 99.5% |
| **Early Stopping Rate** | % sources stopped early (low quality) | Orchestrator logs | 15-25% | 20-30% |

#### 3.3.3 Business Metrics

| Metric | Definition | Measurement | 6mo Target | 12mo Target |
|--------|-----------|-------------|-----------|-------------|
| **Profiles Completed** | Total profiles generated | Database count | 50 | 500 |
| **Public vs Private** | Mix of profile types | Subject_type field | 100% public | 80% public, 20% private |
| **API Users** | Unique API key holders | Auth system | 3-5 | 20-50 |
| **MRR (Monthly Recurring Revenue)** | Revenue per month | Billing system | $0 (MVP free) | $5-10K |
| **Cost per User** | Infra + LLM costs / user | Cost tracking | N/A | <30% revenue |
| **Churn Rate** | % users who stop using | Usage tracking | N/A | <5%/month |

#### 3.3.4 Research Metrics

| Metric | Definition | Measurement | Target |
|--------|-----------|-------------|--------|
| **Trait Correlation with Big Five** | Do our 120 traits map to known dimensions? | Statistical analysis | r > 0.60 for mapped traits |
| **Test-Retest Reliability** | Same person, different sources → similar profile? | Correlation | r > 0.75 |
| **Predictive Validity** | Do traits predict behavior? | Follow-up studies | Future research |
| **Convergent Validity** | Agreement with other assessments | Cross-method comparison | r > 0.65 |

### 3.4 Non-Goals (Explicitly Out of Scope)

**MVP Does NOT Include:**
1. ❌ Consumer web app (API only)
2. ❌ Mobile app
3. ❌ Real-time analysis (batch processing only)
4. ❌ Video/audio input directly (transcripts only)
5. ❌ Multilingual (English only for MVP)
6. ❌ Clinical diagnosis (not a medical tool)
7. ❌ Predictive modeling (descriptive only)
8. ❌ Social media scraping (manual input or integrations only)

**v1.0 Does NOT Include:**
1. ❌ Team dynamics analysis (individual only)
2. ❌ Hiring recommendations (insights only, no decisions)
3. ❌ Personality "matching" (dating, hiring, etc.)
4. ❌ Real-time chatbot interface
5. ❌ Fine-tuned models (use foundation models only)

---

## 4. User Personas & Use Cases

### 4.1 Primary Personas (MVP)

#### Persona 1: AI Research Lead (Marcus)

**Demographics:**
- Role: Lead ML Engineer at AI agent startup
- Age: 32
- Location: San Francisco
- Budget: $500-2000/month

**Background:**
- Building AI agent for sales conversations
- Needs realistic persona for agent personality
- Tried GPT-4 system prompts but agents feel "robotic"
- Heard about personality profiling from Y Combinator network

**Goals:**
- Get 3-5 personality archetypes to model agents after
- Understand psychological causality (why traits exist)
- Iterate quickly on agent personality

**Pain Points:**
- Generic "friendly assistant" personality is boring
- Users complain agents feel "uncanny valley"
- No way to systematically create depth
- Tried MBTI but too simplistic (16 types, no nuance)

**Use Case with InnerLens:**
1. Signs up for API ($100/month tier)
2. Requests profiles of 5 people (3 public figures + 2 custom from content)
3. Gets 120-trait profiles with causality
4. Uses top 10 traits per archetype to build system prompts
5. Users report 30% increase in engagement with "personality-full" agents
6. Becomes reference customer

**Success Criteria:**
- Profile generation <2 hours
- Traits are actionable (can translate to prompts)
- Cost is predictable ($50-100 per profile)

---

#### Persona 2: Academic Researcher (Dr. Sarah)

**Demographics:**
- Role: Associate Professor, Psychology Department
- Age: 41
- Location: Boston
- Budget: Grant-funded ($5K research budget)

**Background:**
- Studies evolution of thought leaders' ideas over time
- Manually coded 50 podcast transcripts (took 6 months)
- Wants to scale to 500 transcripts
- Familiar with NLP but not engineering

**Goals:**
- Analyze 100 public intellectuals longitudinally
- Publish paper on "Evolution of Tech Thought Leaders"
- Reproducible methodology for peer review
- Statistical analysis of personality patterns

**Pain Points:**
- Manual coding is slow (3-4 hours per interview)
- Inter-rater reliability issues (multiple coders disagree)
- Cannot scale beyond small N
- Need auditability for peer review

**Use Case with InnerLens:**
1. Gets research access (academic pricing: $25/profile)
2. Provides list of 100 people + known sources
3. Batch processes over 2 weeks
4. Downloads profiles + evidence trails as CSV
5. Performs statistical analysis in R
6. Cites InnerLens in paper methodology
7. Publishes, other researchers adopt

**Success Criteria:**
- Can process 100 profiles in <1 month
- Evidence trails are complete (for peer review)
- Replicability (same input → same output)
- Academic pricing ($25-30/profile)

---

#### Persona 3: Self-Improvement Enthusiast (Alex)

**Demographics:**
- Role: Product Manager at tech company
- Age: 29
- Location: Austin
- Budget: $50-200 one-time

**Background:**
- Takes MBTI annually (INTJ)
- Feels it's too simplistic
- Wants to understand blind spots
- Has 2 years of Zoom meetings recorded
- Journals in Notion

**Goals:**
- Deep self-understanding beyond MBTI
- Identify blind spots (what I don't see about myself)
- Track evolution (am I changing?)
- Actionable insights for personal growth

**Pain Points:**
- MBTI is 16 types, doesn't feel accurate
- Therapist is expensive ($200/session)
- No quantitative self-knowledge
- Hard to know if making progress

**Use Case with InnerLens:**
1. Signs up for private tier ($99 one-time)
2. Uploads:
   - 20 Zoom recordings (1-on-1 meetings)
   - 6 months of journal entries
   - 500 Slack messages (work context)
3. Gets profile in 24 hours
4. Discovers:
   - High agreeableness (blind spot: avoids conflict)
   - Idealism score 0.91, pragmatism 0.45 (imbalance)
   - Patern: systematically avoids discussing emotions
5. Shares with therapist, works on blind spots
6. Re-analyzes 6 months later to track change

**Success Criteria:**
- Privacy guaranteed (GDPR compliant)
- Insights are genuinely surprising (not just confirmation)
- Profile is understandable (not just numbers)
- Can track change over time

---

### 4.2 Use Cases (Detailed)

#### Use Case 1: Create AI Agent Persona

**Actor:** AI company (Marcus)

**Preconditions:**
- Has API key
- Identified public figure to model after (e.g., "Naval Ravikant")

**Flow:**
1. **Request profile via API:**
   ```bash
   POST /api/v1/profiles
   {
     "person_name": "Naval Ravikant",
     "subject_type": "public_figure",
     "target_quality": "high",
     "priority_domains": ["values", "motivation", "communication_style"]
   }
   ```

2. **System processes (60-90min):**
   - Discovery finds 8 sources (3 podcasts, 2 essays, 1 biography, 2 interviews)
   - Pre-eval validates sources
   - Extraction generates 287 fragments
   - Mapping detects 38 traits
   - Cross-validation confirms 35 traits
   - Synthesis generates profile

3. **API returns:**
   ```json
   {
     "status": "complete",
     "profile": {
       "core_identity": {
         "summary": "Fundamentally driven by autonomy (0.93)...",
         "central_traits": [
           {
             "trait_code": 71,
             "trait_name": "Self-direction",
             "score": 0.93,
             "confidence": 0.92
           }
         ]
       }
     }
   }
   ```

4. **Marcus uses profile to build agent:**
   - Takes top 10 traits
   - Translates to system prompt:
     ```
     You are an AI assistant with these core traits:
     - Extremely high self-direction (values autonomy)
     - Low materialism (money is tool, not goal)
     - High truth-seeking (values accuracy > social harmony)
     ...
     ```

5. **Agent performs better:**
   - Users report "feels more real"
   - Engagement up 30%
   - NPS increases 15 points

**Postconditions:**
- Profile stored in database
- Marcus charged $50-100
- Can request refinements or additional profiles

**Success Metrics:**
- Time to profile: <2 hours
- Cost: <$100
- Profile quality: Grade B+
- Actionability: Can translate to prompts

---

#### Use Case 2: Academic Research Study

**Actor:** Psychology researcher (Dr. Sarah)

**Preconditions:**
- Research grant approved
- IRB approval (if needed)
- List of 100 public figures prepared

**Flow:**
1. **Request batch processing:**
   ```bash
   POST /api/v1/batch_profiles
   {
     "subjects": [
       {"name": "Person A", "known_sources": [...]},
       {"name": "Person B", "known_sources": [...]},
       ...
     ],
     "target_quality": "high",
     "academic_pricing": true
   }
   ```

2. **System processes over 7-10 days:**
   - 3-5 profiles processed simultaneously (rate limiting)
   - Progress updates via webhook

3. **Download results:**
   ```bash
   GET /api/v1/batch_profiles/{batch_id}/export
   Returns: CSV with all 100 profiles + evidence trails
   ```

4. **Dr. Sarah analyzes in R:**
   ```r
   profiles <- read.csv("innerlens_batch_123.csv")
   
   # Analyze temporal evolution
   cor(profiles$year, profiles$trait_71_score)
   
   # Cluster analysis
   kmeans(profiles[,trait_columns], centers=5)
   ```

5. **Publishes paper:**
   - Methods section cites InnerLens
   - Includes inter-rater reliability with InnerLens vs manual coding
   - Other researchers can replicate

**Postconditions:**
- 100 profiles in database
- Dr. Sarah charged $2500 (academic pricing)
- Data exported for analysis
- Citation in published paper

**Success Metrics:**
- Batch completion: <2 weeks
- Cost: <$30/profile (academic)
- Replicability: Same input → same output
- Quality: Comparable to manual coding

---

#### Use Case 3: Personal Self-Analysis

**Actor:** Individual (Alex)

**Preconditions:**
- Has private data to upload (meetings, journals, chats)
- Willing to pay $99
- Consents to data processing

**Flow:**

1. **Sign up for private tier:**
   - Creates account
   - Selects "Analyze My Own Data" ($99 one-time)

2. **Uploads data:**
   - 20 Zoom recordings (via upload or Zoom integration)
   - 6 months of journal entries (Notion export)
   - 500 Slack messages (manual selection, privacy-filtered)

3. **System processes (24-48 hours):**
   - Transcript generation (Zoom → text)
   - Extraction from all sources (meetings, journal, chat)
   - Privacy: Only Alex's content analyzed, others anonymized
   - Generates 342 fragments total

4. **Receives profile:**
   ```
   EXECUTIVE SUMMARY:
   You are fundamentally driven by achievement (0.87) and 
   harmony-seeking (0.82). This creates internal tension: 
   you want success but avoid conflict necessary to get it.
   
   BLIND SPOTS DETECTED:
   - Systematically avoid expressing disagreement (20 instances)
   - High agreeableness (0.88) masks frustration
   - Pattern: Say "that makes sense" even when disagree
   
   STRENGTHS:
   - Idealism (0.91): You genuinely care about making impact
   - Conscientiousness (0.85): Follow-through is excellent
   
   GROWTH AREAS:
   - Learn to express disagreement constructively
   - Balance idealism with pragmatism (current: 0.91 vs 0.45)
   ```

5. **Alex acts on insights:**
   - Shares with therapist
   - Practices assertiveness in 1-on-1s
   - Re-analyzes 6 months later to see change

**Postconditions:**
- Private profile created
- Data encrypted and deletable anytime
- Alex can download profile + evidence
- GDPR compliant (right to deletion works)

**Success Metrics:**
- Privacy: Zero data leaks
- Surprise factor: 80%+ users report "learned something new"
- Actionability: 70%+ users make 1+ behavioral change
- Satisfaction: NPS >50

---

## 5. System Architecture

### 5.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         API GATEWAY                              │
│  (Vercel) - Authentication, Rate Limiting, Routing              │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ REST API
                         │
        ┌────────────────┴────────────────┐
        │                                 │
        ▼                                 ▼
┌──────────────┐                 ┌──────────────┐
│  SUPABASE    │◄────────────────┤ ORCHESTRATOR │
│  (Postgres)  │  Read/Write     │    WORKER    │
│              │                 │  (Railway)   │
└──────────────┘                 └──────┬───────┘
                                        │
                                        │ Coordinates
                                        │
        ┌───────────────────────────────┼───────────────────────────┐
        │                               │                           │
        ▼                               ▼                           ▼
┌──────────────┐              ┌──────────────┐           ┌──────────────┐
│   STAGE 1    │              │   STAGE 2    │           │   STAGE 3    │
│  DISCOVERY   │──────────────►│  EXTRACTION  │───────────►│  SYNTHESIS   │
│              │   Sources    │              │  Fragments │              │
└──────────────┘              └──────────────┘           └──────────────┘
        │                               │                           │
        │                               │                           │
        ▼                               ▼                           ▼
┌──────────────┐              ┌──────────────┐           ┌──────────────┐
│   PRE-EVAL   │              │ TRAIT MAPPING│           │   PROFILE    │
│    Agent     │              │    Agent     │           │   COMPLETE   │
└──────────────┘              └──────────────┘           └──────────────┘
        │                               │
        │                               │
        ▼                               ▼
┌──────────────┐              ┌──────────────┐
│   CLEANING   │              │  META-EVAL   │
│    Agent     │              │  CROSS-VAL   │
└──────────────┘              └──────────────┘
```

### 5.2 Component Responsibilities

#### 5.2.1 API Gateway (Vercel)

**Responsibilities:**
- Authentication (API key validation)
- Rate limiting (100 req/min, 1000 req/day)
- Request routing
- CORS handling
- Response compression

**Tech Stack:**
- Vercel Serverless Functions (Node.js)
- Redis for rate limiting
- JWT for sessions

**Endpoints:**
```
POST   /api/v1/profiles              Create profile job
GET    /api/v1/profiles/{id}         Get profile
GET    /api/v1/profiles/{id}/evidence/{trait}  Get evidence
GET    /api/v1/jobs/{id}             Job status
DELETE /api/v1/profiles/{id}         Delete profile
```

---

#### 5.2.2 Orchestrator Worker (Railway)

**Responsibilities:**
- Receive jobs from queue
- Coordinate 8 agents in correct sequence
- Make strategic decisions (which agent to call, when to stop)
- Update job status
- Handle errors and retries

**Tech Stack:**
- Node.js + TypeScript
- BullMQ for job queue
- Redis for queue storage

**Core Loop:**
```typescript
async function processProfile(job: ProfileJob): Promise<Profile> {
  // 1. Discovery
  const sources = await discoveryAgent.discover(job.person_name);
  
  // 2. Pre-eval (top 10 sources)
  const validatedSources = await preEvalAgent.evaluateBatch(sources.slice(0, 10));
  
  // 3. Extraction loop
  for (const source of validatedSources) {
    if (shouldStopEarly(currentState)) break;
    
    const cleaned = await cleaningAgent.clean(source);
    const fragments = await extractionAgent.extract(cleaned);
    
    // 4. Meta-eval every 50 fragments
    if (fragments.length % 50 === 0) {
      const metaEval = await metaEvalAgent.evaluate(allFragments);
      if (metaEval.grade >= 'B+' && domainsCovered) break;
    }
  }
  
  // 5. Trait mapping
  const traits = await traitMappingAgent.mapBatch(allFragments);
  
  // 6. Cross-validation
  const validated = await crossValidationAgent.validate(traits);
  
  // 7. Synthesis
  const profile = await synthesisAgent.synthesize(validated);
  
  return profile;
}
```

---

#### 5.2.3 Agent Implementations

Each agent is:
- **Stateless function** (no memory between calls)
- **Versioned** (v2.0, v2.1, etc.)
- **Testable** (unit tests for each)
- **Observable** (logs all decisions)

**Agent Template:**
```typescript
interface Agent {
  name: string;
  version: string;
  
  process(input: AgentInput): Promise<AgentOutput>;
  
  // Optional overrides
  validate?(input: AgentInput): ValidationResult;
  estimateCost?(input: AgentInput): number; // tokens
}
```

---

#### 5.2.4 Database (Supabase Postgres)

**Responsibilities:**
- Store all data (subjects, documents, fragments, traits, profiles)
- Row-level security (privacy)
- Real-time subscriptions (job progress)
- Backups and versioning

**Key Features:**
- Postgres 15
- pgvector for embeddings (future)
- Full-text search
- JSONB for flexible data

---

### 5.3 Data Flow (End-to-End)

```
USER REQUEST
│
├─ POST /api/v1/profiles
│  {
│    "person_name": "Naval Ravikant",
│    "subject_type": "public_figure"
│  }
│
▼
API GATEWAY (Vercel)
│
├─ Validate API key
├─ Rate limit check
├─ Create job in queue
│
▼
JOB QUEUE (Redis + BullMQ)
│
├─ Job: { id: "job_123", person_name: "Naval", status: "queued" }
│
▼
ORCHESTRATOR WORKER (Railway)
│
├─ Picks up job
├─ Updates status: "processing"
│
▼
AGENT 1: DISCOVERY
│
├─ Input: "Naval Ravikant"
├─ LLM Call: Search strategy + execute
├─ Output: 47 sources found
├─ Writes to: documents table (status: discovered)
│
▼
AGENT 2: PRE-EVAL
│
├─ Input: Top 10 sources
├─ LLM Calls: 10 evaluations
├─ Output: 7 SHOULD_PROCESS, 3 SKIP
├─ Writes to: documents table (status: validated / skipped)
│
▼
AGENT 3: CLEANING (for each validated source)
│
├─ Input: Raw transcript
├─ LLM Call: Clean and structure
├─ Output: Clean text + structural_format
├─ Writes to: documents table (status: cleaned, clean_text field)
│
▼
AGENT 4: EXTRACTION (for each chunk of cleaned text)
│
├─ Input: Chunk (2000-3000 words)
├─ LLM Call: Unified extraction (all fragment types)
├─ Self-Critique: 10 tests per fragment
├─ Output: 8-15 fragments (multi-type)
├─ Writes to: fragments table
│
▼
AGENT 5: META-EVAL (every 50 fragments)
│
├─ Input: All fragments so far (0-50, 51-100, etc.)
├─ LLM Call: Evaluate collection
├─ Output: Grade + gaps + recommendations
├─ Decision: Continue or stop early?
│
▼
AGENT 6: TRAIT MAPPING (after extraction complete)
│
├─ Input: All fragments (batch of 20-30 at a time)
├─ LLM Calls: Detect traits in each fragment
├─ Output: Trait detections with intensity/confidence
├─ Writes to: fragment_trait_detections table
│
▼
AGENT 7: CROSS-VALIDATION (for traits with 5+ evidences)
│
├─ Input: 1 trait + all its evidences
├─ LLM Call: Validate consistency
├─ Output: VALIDATED / NOT_VALIDATED + adjusted scores
├─ Writes to: trait_validations table (new)
│
▼
AGENT 8: SYNTHESIS
│
├─ Input: All validated traits + context
├─ LLM Call: Generate 3-level profile
├─ Output: Executive summary + narrative + JSON
├─ Writes to: profiles table
│
▼
ORCHESTRATOR
│
├─ Job status: "complete"
├─ Notify via webhook (if configured)
│
▼
API RESPONSE
│
├─ GET /api/v1/profiles/{subject_id}
├─ Returns full profile JSON
```

---

### 5.4 Scaling Architecture

#### 5.4.1 Horizontal Scaling

```
┌─────────────┐
│ API Gateway │
│  (Vercel)   │ → Autoscales automatically
└─────────────┘

┌─────────────────────────────────────┐
│    Orchestrator Workers (Railway)   │
│                                     │
│  Worker 1  Worker 2  Worker 3      │ → Scale to N workers
│    ↓          ↓          ↓          │
│  Profile A Profile B Profile C      │
└─────────────────────────────────────┘

┌─────────────┐
│  Supabase   │ → Connection pooling
│  (Postgres) │ → Read replicas (future)
└─────────────┘
```

#### 5.4.2 Caching Strategy

**Level 1: Source Discovery Cache**
- Key: `discovery:{person_name}:{date}`
- TTL: 7 days
- Saves: 5-10K tokens per re-run

**Level 2: Cleaned Documents Cache**
- Key: `cleaned:{document_id}:{cleaning_version}`
- TTL: 30 days
- Saves: Re-processing same source

**Level 3: Fragment Cache**
- Key: `fragments:{document_id}:{extraction_version}`
- TTL: 90 days
- Saves: Most expensive operation

**Level 4: Trait Mappings Cache**
- Key: `traits:{fragment_id}:{mapping_version}`
- TTL: 90 days
- Saves: Re-mapping same fragments

**Implementation:**
```typescript
async function getCachedOrProcess<T>(
  key: string,
  processor: () => Promise<T>,
  ttl: number
): Promise<T> {
  const cached = await redis.get(key);
  if (cached) return JSON.parse(cached);
  
  const result = await processor();
  await redis.setex(key, ttl, JSON.stringify(result));
  return result;
}
```

---

### 5.5 Error Handling & Resilience

#### 5.5.1 Retry Strategy

```typescript
const RETRY_CONFIG = {
  // LLM API errors
  llm_api_error: {
    maxRetries: 3,
    backoff: 'exponential',
    initialDelay: 1000,
    maxDelay: 10000
  },
  
  // Rate limits
  rate_limit: {
    maxRetries: 5,
    backoff: 'exponential',
    initialDelay: 5000,
    maxDelay: 60000
  },
  
  // Database errors
  db_error: {
    maxRetries: 3,
    backoff: 'exponential',
    initialDelay: 500,
    maxDelay: 5000
  }
};
```

#### 5.5.2 Circuit Breaker

```typescript
class CircuitBreaker {
  private failureCount = 0;
  private lastFailure: Date | null = null;
  private state: 'closed' | 'open' | 'half_open' = 'closed';
  
  async execute<T>(fn: () => Promise<T>): Promise<T> {
    if (this.state === 'open') {
      if (this.shouldAttemptReset()) {
        this.state = 'half_open';
      } else {
        throw new Error('Circuit breaker is open');
      }
    }
    
    try {
      const result = await fn();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }
  
  private onSuccess() {
    this.failureCount = 0;
    this.state = 'closed';
  }
  
  private onFailure() {
    this.failureCount++;
    this.lastFailure = new Date();
    
    if (this.failureCount >= 5) {
      this.state = 'open';
    }
  }
}
```

#### 5.5.3 Graceful Degradation

**If Discovery fails:**
- Fallback to known_sources (user-provided)
- If none, return error with clear message

**If Pre-Eval fails:**
- Process all discovered sources (no filtering)
- May result in lower quality but completes

**If Extraction fails on 1 source:**
- Skip that source, continue with others
- Log error for investigation
- Still generate profile if 3+ sources succeed

**If Trait Mapping fails:**
- Retry with simpler prompt
- If still fails, mark trait as "detection_failed"
- Continue with traits that worked

**If Synthesis fails:**
- Return structured JSON only (skip narrative)
- User still gets data, just not pretty

---

## 6. Database Schema

### 6.1 Complete Schema (Postgres + Supabase)

```sql
-- ══════════════════════════════════════════════════════════════
-- INNERLENS DATABASE SCHEMA v3.0
-- Last Updated: 2025-10-13
-- ══════════════════════════════════════════════════════════════

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enable pgcrypto for encryption
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ══════════════════════════════════════════════════════════════
-- ENUMS
-- ══════════════════════════════════════════════════════════════

CREATE TYPE subject_type AS ENUM (
  'public_figure',
  'private_user'
);

CREATE TYPE privacy_level AS ENUM (
  'public',
  'private',
  'anonymized'
);

CREATE TYPE processing_status AS ENUM (
  'pending',
  'processing',
  'complete',
  'failed',
  'cancelled'
);

CREATE TYPE source_status AS ENUM (
  'discovered',
  'validated',
  'skipped',
  'cleaned',
  'extracted',
  'failed'
);

CREATE TYPE fragment_type AS ENUM (
  'qa_interview',
  'statement',
  'monologue',
  'dialogue',
  'group_discussion',
  'observation',
  'biographical_fact',
  'behavior_described',
  'written_thought',
  'chat_message',
  'reaction',
  'meta_pattern'
);

CREATE TYPE evidence_type AS ENUM (
  'explicit_statement',
  'implicit_reveal',
  'behavioral_pattern',
  'third_party_observation'
);

CREATE TYPE trait_hierarchy AS ENUM (
  'fundamental',
  'derived'
);

-- ══════════════════════════════════════════════════════════════
-- TABLE: subjects
-- The people being analyzed
-- ══════════════════════════════════════════════════════════════

CREATE TABLE subjects (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  
  -- Identity
  person_name TEXT NOT NULL,
  subject_type subject_type NOT NULL,
  privacy_level privacy_level NOT NULL DEFAULT 'public',
  
  -- Metadata
  known_aliases TEXT[],
  primary_domain TEXT, -- 'tech', 'philosophy', etc.
  birth_year INTEGER,
  nationality TEXT,
  
  -- Processing
  status processing_status DEFAULT 'pending',
  processing_started_at TIMESTAMPTZ,
  processing_completed_at TIMESTAMPTZ,
  processing_duration_seconds INTEGER,
  
  -- Quality
  quality_grade TEXT, -- 'A', 'A-', 'B+', etc.
  completeness NUMERIC(3,2), -- 0.00-1.00
  confidence_avg NUMERIC(3,2),
  
  -- Costs
  total_tokens_used INTEGER DEFAULT 0,
  total_cost_usd NUMERIC(10,4) DEFAULT 0.00,
  
  -- Pipeline
  pipeline_version TEXT NOT NULL,
  agent_versions JSONB, -- {"discovery": "2.2", "extraction": "2.0", ...}
  
  -- Audit
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  created_by UUID, -- user_id from auth.users
  deleted_at TIMESTAMPTZ,
  
  -- Constraints
  CONSTRAINT valid_completeness CHECK (completeness BETWEEN 0 AND 1),
  CONSTRAINT valid_confidence CHECK (confidence_avg BETWEEN 0 AND 1)
);

CREATE INDEX idx_subjects_person_name ON subjects(person_name);
CREATE INDEX idx_subjects_type ON subjects(subject_type);
CREATE INDEX idx_subjects_status ON subjects(status);
CREATE INDEX idx_subjects_created_by ON subjects(created_by);

-- ══════════════════════════════════════════════════════════════
-- TABLE: documents
-- Source materials (transcripts, essays, books)
-- ══════════════════════════════════════════════════════════════

CREATE TABLE documents (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject_id UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
  
  -- Source info
  source_url TEXT,
  source_type TEXT NOT NULL, -- 'podcast_transcript', 'essay', etc.
  title TEXT,
  platform TEXT, -- 'YouTube', 'Medium', etc.
  author TEXT, -- If different from subject
  date_published DATE,
  
  -- Content
  raw_content TEXT, -- Original, uncleaned
  clean_content TEXT, -- After cleaning agent
  word_count INTEGER,
  char_count INTEGER,
  
  -- Metadata
  metadata JSONB, -- {duration_minutes, interviewer, etc.}
  structural_format TEXT, -- From cleaning: 'interview_format', etc.
  
  -- Discovery scoring
  tier INTEGER CHECK (tier BETWEEN 1 AND 4),
  priority_score NUMERIC(3,2),
  priority_reasoning TEXT,
  
  -- Pre-eval decision
  pre_eval_decision TEXT, -- 'MUST_PROCESS', 'SHOULD_PROCESS', 'SKIP'
  pre_eval_reasoning TEXT,
  expected_yield INTEGER, -- Estimated fragments
  
  -- Processing
  status source_status DEFAULT 'discovered',
  processed_at TIMESTAMPTZ,
  
  -- Quality
  actual_yield INTEGER, -- Actual fragments extracted
  avg_fragment_layer NUMERIC(3,2),
  high_layer_percentage NUMERIC(3,2), -- % layer 5+
  
  -- Pipeline
  pipeline_version TEXT,
  cleaning_version TEXT,
  extraction_version TEXT,
  
  -- Audit
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_documents_subject ON documents(subject_id);
CREATE INDEX idx_documents_status ON documents(status);
CREATE INDEX idx_documents_priority ON documents(priority_score DESC);
CREATE INDEX idx_documents_date ON documents(date_published);

-- ══════════════════════════════════════════════════════════════
-- TABLE: fragments
-- Core evidence units (replaces old 'qas' table)
-- ══════════════════════════════════════════════════════════════

CREATE TABLE fragments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject_id UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
  document_id UUID NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  
  -- Type and content
  fragment_type fragment_type NOT NULL,
  content JSONB NOT NULL, -- Flexible structure per type
  
  -- Psychology
  psychological_theme TEXT,
  layer INTEGER CHECK (layer BETWEEN 1 AND 8),
  domains TEXT[], -- ['motivation', 'values', ...]
  
  -- Markers
  emotional_markers TEXT[],
  evasion_detected BOOLEAN DEFAULT FALSE,
  evasion_details TEXT,
  signature_concepts TEXT[],
  
  -- Quality
  confidence NUMERIC(3,2) CHECK (confidence BETWEEN 0.00 AND 1.00),
  why_significant TEXT NOT NULL,
  evidence_type evidence_type,
  trait_hierarchy trait_hierarchy,
  derives_from_traits INTEGER[],
  
  -- Traceability
  raw_excerpt TEXT NOT NULL,
  source_timestamp TEXT, -- "01:23:45" or "page 42"
  char_start INTEGER,
  char_end INTEGER,
  
  -- Processing
  extraction_method TEXT NOT NULL,
  extraction_version TEXT NOT NULL,
  pipeline_version TEXT NOT NULL,
  
  -- Self-critique
  self_critique_passed BOOLEAN DEFAULT TRUE,
  critique_log JSONB,
  refinements_applied TEXT[],
  
  -- Audit
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ,
  
  -- Constraints
  CHECK (
    (fragment_type != 'meta_pattern') OR 
    (content->>'evidence_fragment_ids' IS NOT NULL)
  )
);

CREATE INDEX idx_fragments_subject ON fragments(subject_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_fragments_type ON fragments(fragment_type) WHERE deleted_at IS NULL;
CREATE INDEX idx_fragments_layer ON fragments(layer) WHERE deleted_at IS NULL AND layer >= 5;
CREATE INDEX idx_fragments_document ON fragments(document_id);
CREATE INDEX idx_fragments_confidence ON fragments(confidence) WHERE confidence >= 0.70;
CREATE INDEX idx_fragments_content_gin ON fragments USING GIN (content);
CREATE INDEX idx_fragments_signatures ON fragments USING GIN (signature_concepts);
CREATE INDEX idx_fragments_domains ON fragments USING GIN (domains);

-- ══════════════════════════════════════════════════════════════
-- TABLE: traits
-- Master table of 120 psychological traits
-- ══════════════════════════════════════════════════════════════

CREATE TABLE traits (
  code INTEGER PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT NOT NULL,
  domain TEXT NOT NULL, -- 'cognitive', 'emotional', etc.
  subdomain TEXT,
  
  -- Measurement
  scale_min_label TEXT, -- "Low autonomy"
  scale_max_label TEXT, -- "High autonomy"
  
  -- Validation
  related_big_five TEXT[], -- Map to Big Five if applicable
  inverse_of INTEGER REFERENCES traits(code),
  
  -- Metadata
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  version TEXT DEFAULT '1.0'
);

CREATE INDEX idx_traits_domain ON traits(domain);

-- ══════════════════════════════════════════════════════════════
-- TABLE: fragment_trait_detections
-- Raw trait detections from Trait Mapping Agent
-- ══════════════════════════════════════════════════════════════

CREATE TABLE fragment_trait_detections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  fragment_id UUID NOT NULL REFERENCES fragments(id) ON DELETE CASCADE,
  subject_id UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
  trait_code INTEGER NOT NULL REFERENCES traits(code),
  
  -- Detection
  intensity NUMERIC(3,2) NOT NULL CHECK (intensity BETWEEN 0.00 AND 1.00),
  confidence NUMERIC(3,2) NOT NULL CHECK (confidence BETWEEN 0.00 AND 1.00),
  evidence_text TEXT NOT NULL,
  reasoning TEXT NOT NULL,
  
  -- Hierarchy
  hierarchy trait_hierarchy,
  derives_from INTEGER REFERENCES traits(code),
  
  -- Processing
  mapping_version TEXT NOT NULL,
  detected_at TIMESTAMPTZ DEFAULT NOW(),
  
  -- Validation (updated by Cross-Val Agent)
  validated BOOLEAN,
  validation_status TEXT, -- 'pending', 'confirmed', 'rejected'
  validation_reasoning TEXT,
  
  UNIQUE(fragment_id, trait_code)
);

CREATE INDEX idx_detections_fragment ON fragment_trait_detections(fragment_id);
CREATE INDEX idx_detections_trait ON fragment_trait_detections(trait_code);
CREATE INDEX idx_detections_subject ON fragment_trait_detections(subject_id);
CREATE INDEX idx_detections_validated ON fragment_trait_detections(validated);

-- ══════════════════════════════════════════════════════════════
-- TABLE: trait_scores
-- Aggregated, validated trait scores per subject
-- ══════════════════════════════════════════════════════════════

CREATE TABLE trait_scores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject_id UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
  trait_code INTEGER NOT NULL REFERENCES traits(code),
  
  -- Aggregated score
  final_score NUMERIC(3,2) NOT NULL CHECK (final_score BETWEEN 0.00 AND 1.00),
  confidence NUMERIC(3,2) NOT NULL CHECK (confidence BETWEEN 0.00 AND 1.00),
  consistency NUMERIC(3,2), -- Cross-source consistency
  
  -- Evidence
  evidence_count INTEGER NOT NULL, -- How many fragments support this
  detection_ids UUID[], -- Array of fragment_trait_detections.id
  
  -- Temporal
  earliest_evidence_date DATE,
  latest_evidence_date DATE,
  evolution_detected BOOLEAN DEFAULT FALSE,
  evolution_description TEXT,
  
  -- Hierarchy
  is_central_trait BOOLEAN DEFAULT FALSE, -- Top 5-10 traits
  hierarchy trait_hierarchy,
  causes_traits INTEGER[], -- Trait codes this fundamental trait influences
  
  -- Metadata
  calculated_at TIMESTAMPTZ DEFAULT NOW(),
  pipeline_version TEXT,
  
  UNIQUE(subject_id, trait_code)
);

CREATE INDEX idx_scores_subject ON trait_scores(subject_id);
CREATE INDEX idx_scores_trait ON trait_scores(trait_code);
CREATE INDEX idx_scores_central ON trait_scores(is_central_trait) WHERE is_central_trait = TRUE;
CREATE INDEX idx_scores_hierarchy ON trait_scores(hierarchy);

-- ══════════════════════════════════════════════════════════════
-- TABLE: meta_evaluations
-- Periodic quality assessments during extraction
-- ══════════════════════════════════════════════════════════════

CREATE TABLE meta_evaluations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject_id UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
  
  -- Timing
  evaluated_at TIMESTAMPTZ DEFAULT NOW(),
  fragments_count_at_eval INTEGER,
  
  -- Grade
  overall_grade TEXT, -- 'A', 'B+', etc.
  layer_distribution JSONB, -- {1: 5, 2: 10, ..., 8: 20}
  domain_coverage JSONB, -- {motivation: 0.85, values: 0.90, ...}
  
  -- Issues
  redundancy_percentage NUMERIC(3,2),
  redundant_fragments UUID[],
  gaps_identified TEXT[],
  
  -- Recommendations
  should_continue BOOLEAN,
  recommended_actions TEXT[],
  
  -- Agent
  agent_version TEXT,
  reasoning TEXT
);

CREATE INDEX idx_meta_evals_subject ON meta_evaluations(subject_id);
CREATE INDEX idx_meta_evals_date ON meta_evaluations(evaluated_at DESC);

-- ══════════════════════════════════════════════════════════════
-- TABLE: profiles
-- Final synthesized profiles
-- ══════════════════════════════════════════════════════════════

CREATE TABLE profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject_id UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
  
  -- Content (3 levels)
  executive_summary TEXT NOT NULL, -- 250-350 words
  narrative_full TEXT NOT NULL, -- 1500-2500 words
  structured_json JSONB NOT NULL, -- Technical details
  
  -- Metadata
  synthesis_version TEXT NOT NULL,
  generated_at TIMESTAMPTZ DEFAULT NOW(),
  
  -- Quality
  quality_grade TEXT,
  completeness NUMERIC(3,2),
  limitations TEXT[],
  
  UNIQUE(subject_id) -- One profile per subject
);

CREATE INDEX idx_profiles_subject ON profiles(subject_id);

-- ══════════════════════════════════════════════════════════════
-- TABLE: jobs
-- Processing jobs queue
-- ══════════════════════════════════════════════════════════════

CREATE TABLE jobs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject_id UUID REFERENCES subjects(id) ON DELETE SET NULL,
  
  -- Job info
  job_type TEXT NOT NULL, -- 'profile_generation'
  status processing_status DEFAULT 'pending',
  priority INTEGER DEFAULT 0,
  
  -- Input
  input_params JSONB NOT NULL,
  
  -- Progress
  current_stage TEXT, -- 'discovery', 'extraction', etc.
  progress_percentage INTEGER DEFAULT 0,
  estimated_duration_seconds INTEGER,
  
  -- Output
  result JSONB,
  error_message TEXT,
  error_stack TEXT,
  
  -- Timing
  created_at TIMESTAMPTZ DEFAULT NOW(),
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  
  -- Retries
  retry_count INTEGER DEFAULT 0,
  max_retries INTEGER DEFAULT 3
);

CREATE INDEX idx_jobs_status ON jobs(status);
CREATE INDEX idx_jobs_priority ON jobs(priority DESC);
CREATE INDEX idx_jobs_created ON jobs(created_at DESC);

-- ══════════════════════════════════════════════════════════════
-- TABLE: api_keys
-- API authentication
-- ══════════════════════════════════════════════════════════════

CREATE TABLE api_keys (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL, -- From auth.users
  
  -- Key
  key_hash TEXT NOT NULL UNIQUE, -- bcrypt hash
  key_prefix TEXT NOT NULL, -- First 8 chars for display
  name TEXT, -- User-provided name
  
  -- Permissions
  scopes TEXT[] DEFAULT ARRAY['read', 'write'],
  rate_limit_per_minute INTEGER DEFAULT 100,
  rate_limit_per_day INTEGER DEFAULT 1000,
  
  -- Usage
  last_used_at TIMESTAMPTZ,
  total_requests INTEGER DEFAULT 0,
  
  -- Lifecycle
  created_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ,
  revoked_at TIMESTAMPTZ
);

CREATE INDEX idx_api_keys_hash ON api_keys(key_hash);
CREATE INDEX idx_api_keys_user ON api_keys(user_id);

-- ══════════════════════════════════════════════════════════════
-- TABLE: usage_metrics
-- Track API usage for billing
-- ══════════════════════════════════════════════════════════════

CREATE TABLE usage_metrics (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL,
  api_key_id UUID REFERENCES api_keys(id),
  
  -- Usage
  endpoint TEXT NOT NULL,
  method TEXT NOT NULL,
  status_code INTEGER,
  
  -- Costs
  tokens_used INTEGER DEFAULT 0,
  cost_usd NUMERIC(10,4) DEFAULT 0.00,
  
  -- Timing
  response_time_ms INTEGER,
  timestamp TIMESTAMPTZ DEFAULT NOW(),
  
  -- Metadata
  subject_id UUID REFERENCES subjects(id),
  user_agent TEXT,
  ip_address INET
);

CREATE INDEX idx_usage_user ON usage_metrics(user_id);
CREATE INDEX idx_usage_timestamp ON usage_metrics(timestamp DESC);
CREATE INDEX idx_usage_subject ON usage_metrics(subject_id);

-- ══════════════════════════════════════════════════════════════
-- VIEWS (Convenience)
-- ══════════════════════════════════════════════════════════════

-- View: High-quality fragments only
CREATE VIEW fragments_high_quality AS
SELECT *
FROM fragments
WHERE deleted_at IS NULL
  AND confidence >= 0.70
  AND layer >= 5
  AND self_critique_passed = TRUE;

-- View: Fragments by type count
CREATE VIEW fragments_by_type AS
SELECT 
  subject_id,
  fragment_type,
  COUNT(*) as count,
  AVG(confidence) as avg_confidence,
  AVG(layer) as avg_layer
FROM fragments
WHERE deleted_at IS NULL
GROUP BY subject_id, fragment_type;

-- View: Trait scores with trait details
CREATE VIEW trait_scores_detailed AS
SELECT 
  ts.*,
  t.name as trait_name,
  t.description as trait_description,
  t.domain as trait_domain
FROM trait_scores ts
JOIN traits t ON ts.trait_code = t.code;

-- View: Subject processing summary
CREATE VIEW subject_summary AS
SELECT 
  s.id,
  s.person_name,
  s.status,
  s.quality_grade,
  COUNT(DISTINCT d.id) as document_count,
  COUNT(DISTINCT f.id) as fragment_count,
  COUNT(DISTINCT ts.trait_code) as trait_count,
  s.processing_duration_seconds,
  s.total_cost_usd
FROM subjects s
LEFT JOIN documents d ON s.id = d.subject_id AND d.deleted_at IS NULL
LEFT JOIN fragments f ON s.id = f.subject_id AND f.deleted_at IS NULL
LEFT JOIN trait_scores ts ON s.id = ts.subject_id
GROUP BY s.id;

-- ══════════════════════════════════════════════════════════════
-- FUNCTIONS (Helpers)
-- ══════════════════════════════════════════════════════════════

-- Function: Update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Auto-update updated_at
CREATE TRIGGER update_subjects_updated_at BEFORE UPDATE ON subjects
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_documents_updated_at BEFORE UPDATE ON documents
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_fragments_updated_at BEFORE UPDATE ON fragments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_traits_updated_at BEFORE UPDATE ON traits
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ══════════════════════════════════════════════════════════════
-- ROW LEVEL SECURITY (Privacy)
-- ══════════════════════════════════════════════════════════════

-- Enable RLS on all tables
ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE fragments ENABLE ROW LEVEL SECURITY;
ALTER TABLE fragment_trait_detections ENABLE ROW LEVEL SECURITY;
ALTER TABLE trait_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Policy: Public figures are readable by all
CREATE POLICY "Public figures are viewable by everyone"
  ON subjects FOR SELECT
  USING (subject_type = 'public_figure');

-- Policy: Private users only see own data
CREATE POLICY "Users can only see own private data"
  ON subjects FOR SELECT
  USING (
    subject_type = 'private_user' AND 
    created_by = auth.uid()
  );

-- Policy: Users can delete own private data
CREATE POLICY "Users can delete own private data"
  ON subjects FOR DELETE
  USING (
    subject_type = 'private_user' AND 
    created_by = auth.uid()
  );

-- Similar policies for related tables...
-- (Cascade via foreign keys)

-- ══════════════════════════════════════════════════════════════
-- SEED DATA: 120 Traits
-- ══════════════════════════════════════════════════════════════

-- This would be populated from traits_table.json
-- Example:
INSERT INTO traits (code, name, description, domain, subdomain) VALUES
(1, 'Openness to Experience', 'Willingness to try new things, curiosity', 'cognitive', 'intellectual'),
(2, 'Conscientiousness', 'Organization, dependability, discipline', 'behavioral', 'self_control'),
-- ... 118 more traits
(120, 'Shadow Integration', 'Awareness and integration of denied aspects', 'psychological', 'self_awareness');

-- ══════════════════════════════════════════════════════════════
-- END OF SCHEMA
-- ══════════════════════════════════════════════════════════════
```

---

### 6.2 Schema Diagrams

#### 6.2.1 Core Entities

```
┌─────────────┐
│  SUBJECTS   │
│  (People)   │
└──────┬──────┘
       │ 1
       │
       │ N
┌──────┴──────┐       ┌──────────────┐
│  DOCUMENTS  │       │   PROFILES   │
│  (Sources)  │       │   (Output)   │
└──────┬──────┘       └──────────────┘
       │ 1
       │
       │ N
┌──────┴──────┐
│  FRAGMENTS  │
│  (Evidence) │
└──────┬──────┘
       │ 1
       │
       │ N
┌──────┴────────────────┐
│ FRAGMENT_TRAIT_       │
│ DETECTIONS            │
│ (Raw trait detections)│
└──────┬────────────────┘
       │ N
       │
       │ 1
┌──────┴──────┐
│ TRAIT_SCORES│
│ (Aggregated)│
└─────────────┘
```

#### 6.2.2 Data Flow

```
INPUT
  ↓
subjects (created, status: pending)
  ↓
documents (discovered)
  ↓
documents (cleaned)
  ↓
fragments (extracted, multi-type)
  ↓
fragment_trait_detections (mapped)
  ↓
fragment_trait_detections (validated)
  ↓
trait_scores (aggregated)
  ↓
profiles (synthesized)
  ↓
subjects (status: complete)
```

---

## 7. The 8 Agents (Core Intelligence)

### 7.1 Agent Registry

| # | Agent Name | Input | Output | Avg Cost | Avg Time |
|---|-----------|-------|--------|----------|----------|
| 1 | **Discovery** | person_name | 20-50 sources | 2K tokens | 30s |
| 2 | **Pre-Evaluation** | source metadata | go/no-go | 1.5K/source | 20s/source |
| 3 | **Cleaning** | raw transcript | clean text | 2K tokens | 15s |
| 4 | **Unified Extraction** | clean chunk | 8-15 fragments | 4K tokens | 45s |
| 5 | **Trait Mapping** | fragment | 3-8 trait detections | 3K tokens | 30s |
| 6 | **Meta-Evaluation** | all fragments (batch) | grade + gaps | 5K tokens | 60s |
| 7 | **Cross-Validation** | trait + evidences | validated score | 3K tokens | 30s |
| 8 | **Synthesis** | all validated traits | profile (3 levels) | 8K tokens | 120s |

**Total Pipeline:** 350-500K tokens, 60-90 minutes

---

### 7.2 Agent 1: Discovery Agent (Detailed)

**Version:** 2.2  
**Purpose:** Find high-quality sources for fragment extraction  
**Key Innovation:** Type-agnostic (doesn't predict fragment types)

**Full Prompt:** [Already provided in previous message - Discovery Agent v2.2]

**Implementation:**
```typescript
class DiscoveryAgent {
  version = '2.2';
  
  async discover(input: {
    person_name: string;
    subject_type: 'public_figure' | 'private_user';
    target_quality: 'high' | 'medium' | 'exploratory';
    priority_domains?: string[];
  }): Promise<DiscoveryResult> {
    
    // 1. Signature research
    const signature = await this.analyzeSignature(input.person_name);
    
    // 2. Multi-tier search
    const tier1 = await this.searchConversations(input.person_name, signature);
    const tier2 = await this.searchWritten(input.person_name, signature);
    const tier3 = await this.searchProfiles(input.person_name);
    // tier4 (social) commented out
    
    // 3. Merge and score
    const allSources = [...tier1, ...tier2, ...tier3];
    const scored = this.scoreWithRecency(allSources, signature);
    
    // 4. Portfolio balance
    const balanced = this.balancePortfolio(scored, input.priority_domains);
    
    return {
      signature,
      sources: balanced,
      portfolio_analysis: this.analyzePortfolio(balanced)
    };
  }
  
  private scoreWithRecency(sources: Source[], signature: Signature): Source[] {
    return sources.map(source => {
      let score = source.base_quality_score;
      
      // Recency bonus (last 4 years = 60-70%)
      const age = 2025 - source.year;
      if (age <= 2) score += 0.10;      // 2023-2025
      else if (age <= 4) score += 0.05; // 2021-2022
      // else no bonus
      
      return { ...source, priority_score: Math.min(1.0, score) };
    });
  }
}
```

**Tests:**
```typescript
describe('Discovery Agent v2.2', () => {
  test('finds 20+ sources for well-known figure', async () => {
    const result = await discoveryAgent.discover({
      person_name: 'Naval Ravikant',
      subject_type: 'public_figure',
      target_quality: 'high'
    });
    
    expect(result.sources.length).toBeGreaterThanOrEqual(20);
    expect(result.sources[0].tier).toBeLessThanOrEqual(2);
  });
  
  test('prioritizes recent content (60-70% last 4 years)', async () => {
    const result = await discoveryAgent.discover({
      person_name: 'Naval Ravikant',
      subject_type: 'public_figure',
      target_quality: 'high'
    });
    
    const recent = result.sources.filter(s => 
      2025 - s.metadata.date.getFullYear() <= 4
    );
    
    const recentPercent = recent.length / result.sources.length;
    expect(recentPercent).toBeGreaterThanOrEqual(0.60);
    expect(recentPercent).toBeLessThanOrEqual(0.75);
  });
  
  test('balances evidence types (70% self, 30% third-party)', async () => {
    const result = await discoveryAgent.discover({
      person_name: 'Naval Ravikant',
      subject_type: 'public_figure',
      target_quality: 'high'
    });
    
    const selfReport = result.sources.filter(s => 
      s.coverage.evidence_type === 'self_report'
    );
    
    const selfPercent = selfReport.length / result.sources.length;
    expect(selfPercent).toBeGreaterThanOrEqual(0.65);
    expect(selfPercent).toBeLessThanOrEqual(0.85);
  });
});
```

---

### 7.3 Agent 2: Pre-Evaluation Agent

# Product Requirements Document (PRD) - Continuation
## InnerLens Psychological Analysis System v3.0

---

### 7.3 Agent 2: Pre-Evaluation Agent (Detailed)

**Version:** 2.0  
**Purpose:** Validate discovered sources before expensive extraction  
**Key Function:** Early filtering to optimize token budget

**Philosophy:**
Pre-evaluation is the "bouncer" of the pipeline. Discovery found 50 sources, but we can only afford to process 10-15 deeply. Pre-Eval's job: pick the winners.

**Decision Framework:**

The agent makes one of three decisions per source:

1. **MUST_PROCESS** (Priority 1)
   - Rare, exceptional sources (5-10% of sources)
   - Example: 3-hour Lex Fridman interview from 2024
   - Always processed first
   - Expected yield: 100+ fragments, avg layer 6.5+

2. **SHOULD_PROCESS** (Priority 2)
   - Good sources worth processing (60-70% of sources)
   - Example: 1500-word essay, 45-min podcast
   - Processed if budget allows
   - Expected yield: 30-80 fragments, avg layer 5.5+

3. **SKIP** (Priority 3)
   - Low-value sources (20-30% of sources)
   - Example: 10-min promotional interview, generic profile
   - Not processed unless desperate
   - Expected yield: <20 fragments, avg layer <5.0

**Full Prompt:**

```markdown
═══════════════════════════════════════════════════════════════════
PRE-EVALUATION AGENT v2.0
Strategic Source Validation for Token Budget Optimization
═══════════════════════════════════════════════════════════════════

MISSION:
You are a source quality evaluator. Your job: predict which sources 
will yield high-quality psychological fragments, and which will waste 
tokens on shallow content.

Think: venture capitalist reviewing startup pitches. Most look good 
on paper, but only 10-20% are truly worth investment.

═══════════════════════════════════════════════════════════════════
SYSTEM CONTEXT
═══════════════════════════════════════════════════════════════════

BUDGET CONSTRAINTS:
- Total token budget: 500K tokens per profile
- Discovery used: ~2K
- Remaining: ~498K
- Average source cost: 30-50K tokens (cleaning + extraction + mapping)
- Therefore: Can deeply process 10-15 sources MAX

YOUR IMPACT:
- If you approve bad source: waste 40K tokens, get 10 shallow fragments
- If you reject good source: miss 80 deep fragments
- Precision matters more than recall (better to be conservative)

DOWNSTREAM AGENTS:
- Cleaning Agent will clean whatever you approve
- Extraction Agent will extract from cleaned text
- You are the ONLY filter before major token spend

═══════════════════════════════════════════════════════════════════
INPUT SPECIFICATION
═══════════════════════════════════════════════════════════════════

You receive ONE source at a time with metadata from Discovery Agent:

{
  "source": {
    "url": "https://...",
    "title": "Lex Fridman Podcast - Naval Ravikant",
    "source_type": "podcast_transcript",
    "tier": 1,
    "metadata": {
      "date": "2023-01-15",
      "duration_minutes": 177,
      "platform": "YouTube",
      "interviewer": "Lex Fridman",
      "word_count_estimated": 26000,
      "participants": ["Lex Fridman", "Naval Ravikant"]
    },
    "quality_signals": {
      "duration_score": 0.95,
      "interviewer_skill": "high",
      "person_comfort_level": "high",
      "vulnerability_signals": ["discusses failure", "long pauses"],
      "marketing_mode_risk": "low",
      "specificity_level": "high",
      "depth_indicators": ["personal stories", "formative experiences"]
    },
    "coverage": {
      "temporal_phase": "recent",
      "context": "professional_philosophical",
      "evidence_type": "self_report",
      "domains_present": ["motivation", "values", "decision_process"]
    },
    "expected_yield": {
      "total_fragments_estimated": 140,
      "high_layer_percentage": 0.68,
      "avg_layer_estimated": 6.3
    },
    "priority_score": 0.94,
    "priority_reasoning": "Tier 1 source. 3h duration..."
  },
  "context": {
    "person_name": "Naval Ravikant",
    "sources_already_approved": 3,
    "budget_remaining_tokens": 380000,
    "domains_covered_so_far": ["motivation: 0.60", "values: 0.50"],
    "gaps": ["fears/anxieties", "relationship_patterns"]
  }
}

═══════════════════════════════════════════════════════════════════
EVALUATION DIMENSIONS (Score 0.00-1.00 each)
═══════════════════════════════════════════════════════════════════

Evaluate each source on 8 dimensions:

1. DEPTH POTENTIAL (Weight: 0.25)
   "Will this source reveal Layer 5+ psychology?"
   
   HIGH (0.8-1.0):
   ✓ Long duration/length (90min+ / 2000+ words)
   ✓ Person goes deep (discusses struggles, formative experiences)
   ✓ Vulnerability present (admits failures, uncertainties)
   ✓ Specific examples (names, dates, concrete situations)
   
   MEDIUM (0.5-0.79):
   ✓ Moderate length (30-90min / 1000-2000 words)
   ✓ Some depth but not consistent
   ✓ Mix of shallow and deep moments
   
   LOW (0.0-0.49):
   ✗ Short (<30min / <1000 words)
   ✗ Stays surface-level throughout
   ✗ Generic, could be anyone
   ✗ No specific examples

2. PSYCHOLOGICAL RICHNESS (Weight: 0.20)
   "Does this cover multiple psychological domains?"
   
   HIGH (0.8-1.0):
   ✓ 5+ domains visible (motivation, values, fears, formative experiences, etc.)
   ✓ Internal conflicts discussed
   ✓ Evolution/change over time mentioned
   ✓ Shadow aspects (denied traits) visible
   
   MEDIUM (0.5-0.79):
   ✓ 3-4 domains covered
   ✓ Mostly straightforward (no contradictions)
   
   LOW (0.0-0.49):
   ✗ 1-2 domains only
   ✗ One-dimensional portrayal

3. AUTHENTICITY (Weight: 0.20)
   "Is person being genuine or performing?"
   
   HIGH (0.8-1.0):
   ✓ Comfortable setting (friend/peer conversation)
   ✓ Long pauses (thinking, not rehearsed)
   ✓ Admits uncertainty ("I don't know", "I'm still figuring this out")
   ✓ Discusses failures openly
   ✓ Low marketing mode risk
   
   MEDIUM (0.5-0.79):
   ✓ Professional but open
   ✓ Some guardedness but generally honest
   
   LOW (0.0-0.49):
   ✗ Pure marketing mode (product launch, PR)
   ✗ Scripted, rehearsed answers
   ✗ Defensive, evasive
   ✗ Corporate speak, platitudes

4. FRAGMENT YIELD POTENTIAL (Weight: 0.15)
   "How many fragments can we extract?"
   
   HIGH (0.8-1.0):
   ✓ 80+ fragments expected
   ✓ Dense content (many insights per minute/paragraph)
   ✓ Mix of Q&A, statements, behaviors, observations
   
   MEDIUM (0.5-0.79):
   ✓ 30-79 fragments expected
   ✓ Moderate density
   
   LOW (0.0-0.49):
   ✗ <30 fragments expected
   ✗ Sparse content

5. SPECIFICITY (Weight: 0.10)
   "Concrete examples vs. vague generalizations?"
   
   HIGH (0.8-1.0):
   ✓ Names real people, dates, events
   ✓ Tells full stories (setup, conflict, resolution)
   ✓ Quantifies ("10 years", "$1M", "every morning")
   
   MEDIUM (0.5-0.79):
   ✓ Some examples, but also generalizations
   
   LOW (0.0-0.49):
   ✗ All generalizations ("hard work is important")
   ✗ No concrete examples

6. TEMPORAL RELEVANCE (Weight: 0.05)
   "How recent is this content?"
   
   HIGH (0.8-1.0):
   ✓ Last 2 years (2023-2025)
   
   MEDIUM (0.5-0.79):
   ✓ 3-4 years ago (2021-2022)
   
   LOW (0.0-0.49):
   ✗ 5+ years ago (pre-2020)
   
   EXCEPTION: Old content gets HIGH if:
   - Discusses formative period (childhood, early career)
   - Person explicitly reflects on evolution ("Back then I believed X, now Y")
   - Historical significance (major life event)

7. GAP FILLING (Weight: 0.03)
   "Does this cover domains we're missing?"
   
   HIGH (0.8-1.0):
   ✓ Covers 2+ under-represented domains
   ✓ Uniquely addresses gap (only source that does)
   
   MEDIUM (0.5-0.79):
   ✓ Covers 1 gap domain
   
   LOW (0.0-0.49):
   ✗ Covers already well-represented domains

8. EVIDENCE TYPE BALANCE (Weight: 0.02)
   "Self-report vs. third-party?"
   
   HIGH (0.8-1.0):
   ✓ Third-party source (biography, profile) when we need more
   ✓ Self-report when we're below 70%
   
   MEDIUM (0.5-0.79):
   ✓ Doesn't hurt balance
   
   LOW (0.0-0.49):
   ✗ Would skew balance (e.g., 9th self-report source when we have 0 third-party)

═══════════════════════════════════════════════════════════════════
SCORING FORMULA
═══════════════════════════════════════════════════════════════════

WEIGHTED SCORE = 
  (depth_potential × 0.25) +
  (psychological_richness × 0.20) +
  (authenticity × 0.20) +
  (fragment_yield × 0.15) +
  (specificity × 0.10) +
  (temporal_relevance × 0.05) +
  (gap_filling × 0.03) +
  (evidence_balance × 0.02)

DECISION THRESHOLDS:

MUST_PROCESS:  weighted_score >= 0.85
SHOULD_PROCESS: 0.65 <= weighted_score < 0.85
SKIP: weighted_score < 0.65

OVERRIDE RULES:

AUTOMATIC MUST_PROCESS if:
- Tier 1 source + duration 120min+ + recent (last 2 years)
- Biography by credible author + 200+ pages + direct access to subject
- Person's own book (autobiography, memoir) + 300+ pages

AUTOMATIC SKIP if:
- Duration <15min or wordcount <500
- Pure promotional content (product launch, press release)
- Marketing mode risk = "high"
- Source is duplicate (same interview, different platform)
- Behind paywall and unavailable

═══════════════════════════════════════════════════════════════════
OUTPUT FORMAT
═══════════════════════════════════════════════════════════════════

For EACH source, return:

{
  "decision": "MUST_PROCESS",  // or SHOULD_PROCESS or SKIP
  
  "scores": {
    "depth_potential": 0.92,
    "psychological_richness": 0.85,
    "authenticity": 0.88,
    "fragment_yield": 0.90,
    "specificity": 0.87,
    "temporal_relevance": 0.95,
    "gap_filling": 0.60,
    "evidence_balance": 0.70,
    "weighted_total": 0.88
  },
  
  "reasoning": "MUST_PROCESS: Tier 1 source with exceptional signals. 
                3-hour duration with skilled interviewer (Lex Fridman) 
                known for depth. Person highly comfortable (laughs, long 
                pauses). Low marketing mode. Discusses formative experiences, 
                failures, and decision-making explicitly. Estimated 140 
                fragments with 68% layer 5+. Recent (2023). Covers priority 
                domains (motivation, values). High specificity throughout.",
  
  "expected_outcomes": {
    "fragments_total": 140,
    "fragments_layer_5_plus": 95,
    "avg_layer": 6.3,
    "domains_covered": ["motivation", "values", "decision_process", 
                        "formative_experiences", "philosophy"],
    "fragment_types": ["qa_interview", "statement", "behavior_described"],
    "estimated_token_cost": 42000,
    "estimated_processing_time_minutes": 35
  },
  
  "risk_factors": [
    // If any
    "Slight concern: interviewer occasionally interrupts (but minor)"
  ],
  
  "comparison_to_alternatives": "Higher priority than 45-min podcast 
                                  from 2019 due to: (1) 3x longer, 
                                  (2) more recent, (3) deeper vulnerability 
                                  signals. Lower priority than person's 
                                  autobiography would be, but no autobiography 
                                  exists.",
  
  "override_applied": null  // or "automatic_must_process_tier1_120min"
}

═══════════════════════════════════════════════════════════════════
STRATEGIC THINKING REQUIRED
═══════════════════════════════════════════════════════════════════

PORTFOLIO OPTIMIZATION:
Don't evaluate sources in isolation. Consider:

- "We have 3 MUST_PROCESS sources already. Should I be stricter now?"
- "We're light on third-party observation. This biography is valuable even 
   if slightly lower quality than self-report sources."
- "We've covered motivation and values well. This source on fears/anxieties 
   is strategically important even if medium quality."

OPPORTUNITY COST:
Every source you approve costs ~40K tokens. That's:
- 1-2 other sources we could process instead
- Or headroom for Meta-Eval, Cross-Val, Synthesis

Ask: "Is THIS source worth that cost vs. alternatives?"

BATCH PROCESSING:
You evaluate sources in order of Discovery's priority_score.
- First 3-5 sources: Be permissive (probably high quality)
- Sources 6-10: Be balanced
- Sources 11+: Be strict (only if truly exceptional or fill gaps)

DIMINISHING RETURNS:
After 10 sources processed:
- Redundancy increases (same insights repeated)
- Incremental value decreases
- Meta-Eval might trigger early stop anyway

So for sources 11-15: MUST_PROCESS threshold becomes 0.90 (not 0.85)

═══════════════════════════════════════════════════════════════════
FAILURE MODES TO AVOID
═══════════════════════════════════════════════════════════════════

FAILURE MODE 1: "Everything looks good"
Symptom: Approving 15+ sources
Problem: Not being selective enough
Result: Waste tokens on mediocre sources

FAILURE MODE 2: "Nothing is perfect"
Symptom: Rejecting even Tier 1 sources
Problem: Perfectionism, no source is perfect
Result: Miss valuable content

FAILURE MODE 3: "Following Discovery's scores blindly"
Symptom: Your scores match Discovery's exactly
Problem: Not adding value, just rubber-stamping
Result: You're not needed

FAILURE MODE 4: "Ignoring context"
Symptom: Same decision regardless of what's already processed
Problem: Not considering portfolio balance
Result: Redundant or unbalanced profile

═══════════════════════════════════════════════════════════════════
CALIBRATION EXAMPLES
═══════════════════════════════════════════════════════════════════

EXAMPLE 1: Clear MUST_PROCESS

Source: 3-hour Lex Fridman podcast, Naval Ravikant, 2024
- Duration: 180min (depth_potential: 0.95)
- Discusses childhood, failures, philosophy (psych_richness: 0.90)
- Comfortable, vulnerable (authenticity: 0.90)
- Estimated 150 fragments (yield: 0.95)
- Many specific examples (specificity: 0.85)
- Recent (temporal: 1.0)
→ Decision: MUST_PROCESS (0.92 weighted)

EXAMPLE 2: Clear SKIP

Source: 10-min YouTube interview, 2018, promoting book
- Duration: 10min (depth_potential: 0.30)
- Only discusses book content (psych_richness: 0.40)
- Marketing mode, guarded (authenticity: 0.25)
- Estimated 8 fragments (yield: 0.20)
- Generic answers (specificity: 0.30)
- Old (temporal: 0.40)
→ Decision: SKIP (0.32 weighted)

EXAMPLE 3: Borderline → Context matters

Source: 1500-word essay, 2022, personal blog
Base scores suggest SHOULD_PROCESS (0.72 weighted)

SCENARIO A: We have 0 essays so far (8 podcasts, 0 written)
→ Upgrade to MUST_PROCESS (diversity valuable)

SCENARIO B: We have 5 essays already (good coverage)
→ Keep SHOULD_PROCESS (not critical)

SCENARIO C: Essay discusses fear/anxiety domain (gap)
→ Upgrade to MUST_PROCESS (fills gap)

═══════════════════════════════════════════════════════════════════
CRITICAL REMINDERS
═══════════════════════════════════════════════════════════════════

1. PRECISION > RECALL
   Better to miss a decent source than waste tokens on bad one

2. CONTEXT MATTERS
   Same source might be MUST_PROCESS or SKIP depending on what's already approved

3. PORTFOLIO THINKING
   Not just "is this good?" but "does this help the portfolio?"

4. OPPORTUNITY COST
   Every approval costs 40K tokens = 1-2 alternatives

5. BE STRICT AFTER 10 SOURCES
   Diminishing returns kick in, raise bar

6. TRUST BUT VERIFY
   Discovery did good work, but you're the final check

7. SPECIFICITY IS KING
   Vague generalizations are worthless, even if long

8. AUTHENTICITY BEATS LENGTH
   Prefer 30min genuine conversation over 90min marketing mode

═══════════════════════════════════════════════════════════════════
END OF PRE-EVALUATION AGENT v2.0
═══════════════════════════════════════════════════════════════════
```

**Decision Logic Summary:**

The agent essentially asks 3 questions:
1. **Quality:** Is this source intrinsically high quality? (depth, authenticity, richness)
2. **Strategic Fit:** Does it help the portfolio? (gaps, balance, diversity)
3. **Efficiency:** Is it worth the token cost vs. alternatives?

Only if all 3 are YES → MUST_PROCESS
If 2/3 are YES → SHOULD_PROCESS
If <2 are YES → SKIP

---

### 7.4 Agent 3: Cleaning Agent (Detailed)

**Version:** 2.1  
**Purpose:** Transform raw transcripts into clean, structured text for extraction  
**Key Innovation:** Identifies structural format to guide extraction strategy

**Why Cleaning Matters:**

Raw transcripts have:
- Speaker labels inconsistent: "Lex:" vs "Lex Fridman:" vs "LF:"
- Timestamps everywhere: "[00:01:23]"
- Transcription artifacts: "[inaudible]", "[music]", "[laughter]"
- Filler words: "um", "uh", "like", "you know"
- Incomplete sentences, false starts
- No paragraph structure

These artifacts:
- Confuse extraction LLM (wastes tokens parsing timestamps)
- Reduce fragment quality (incomplete sentences)
- Make evidence less readable

**Cleaning Goals:**

1. **Standardize speakers:** Pick one format, stick to it
2. **Remove noise:** Timestamps, artifacts, excessive fillers
3. **Preserve content:** Keep every substantive word
4. **Add structure:** Paragraph breaks, speaker changes clear
5. **Identify format:** Interview? Monologue? Dialogue?

**Full Prompt:**

```markdown
═══════════════════════════════════════════════════════════════════
CLEANING AGENT v2.1
Transcript Preparation for Fragment Extraction
═══════════════════════════════════════════════════════════════════

MISSION:
Transform raw, messy transcripts into clean, extraction-ready text.

Think: editor preparing manuscript for publication. Remove distractions,
preserve substance, make readable.

═══════════════════════════════════════════════════════════════════
INPUT SPECIFICATION
═══════════════════════════════════════════════════════════════════

{
  "document_id": "uuid",
  "raw_content": "The messy transcript...",
  "metadata": {
    "source_type": "podcast_transcript",
    "participants": ["Lex Fridman", "Naval Ravikant"],
    "platform": "YouTube",
    "duration_minutes": 177
  }
}

═══════════════════════════════════════════════════════════════════
CLEANING OPERATIONS
═══════════════════════════════════════════════════════════════════

OPERATION 1: STANDARDIZE SPEAKER LABELS

BEFORE:
Lex: How did you...
LF: Follow up question
Lex Fridman: Another question

AFTER:
Lex: How did you...
Lex: Follow up question
Lex: Another question

RULES:
- Pick shortest common form (usually first name)
- Be consistent throughout
- Format: "Name: " (with colon and space)
- If monologue (one speaker), remove all speaker labels

───────────────────────────────────────────────────────────────────

OPERATION 2: REMOVE TIMESTAMPS

BEFORE:
[00:01:23] Lex: How did you...
[00:01:45] Naval: Well, I think...

AFTER:
Lex: How did you...
Naval: Well, I think...

RULES:
- Remove all timestamp formats: [HH:MM:SS], (01:23), etc.
- Preserve in metadata only (for traceability later)

───────────────────────────────────────────────────────────────────

OPERATION 3: CLEAN TRANSCRIPTION ARTIFACTS

REMOVE ENTIRELY:
- [inaudible]
- [crosstalk]
- [music]
- [applause]
- [laughter] (unless contextually important)
- [pause] (unless very long, then keep)
- [background noise]

KEEP IF MEANINGFUL:
- [long pause] → This signals thinking, keep
- [laughs] → If followed by "no seriously though...", context matters
- [sigh] → Emotional signal, keep

RULES:
- When in doubt, keep emotional/contextual markers
- Remove technical artifacts

───────────────────────────────────────────────────────────────────

OPERATION 4: REDUCE FILLER WORDS (Conservative)

BEFORE:
So, um, I think, you know, like, what I'm trying to say is, um, 
basically, happiness is, uh, freedom from wanting things.

AFTER:
I think what I'm trying to say is happiness is freedom from wanting things.

RULES:
- Remove only EXCESSIVE fillers (3+ in one sentence)
- Keep some fillers for authenticity (shows person thinking)
- Never remove if it changes meaning
- Keep: "I mean", "I think", "I believe" (these signal perspective)

───────────────────────────────────────────────────────────────────

OPERATION 5: FIX INCOMPLETE SENTENCES

BEFORE:
Naval: So happiness is... well, actually, let me back up. 
Happiness is freedom from—I mean, what I really mean is...

AFTER:
Naval: Let me back up. Happiness is freedom from wanting. 
I mean, happiness is not getting what you want, it's not wanting 
in the first place.

RULES:
- Complete abandoned thoughts if speaker circles back
- Remove false starts that lead nowhere
- Use ellipses (...) if truly incomplete
- Never invent words person didn't say

───────────────────────────────────────────────────────────────────

OPERATION 6: ADD PARAGRAPH STRUCTURE

BEFORE:
Naval: Happiness is freedom. You're free when you don't want anything. 
Most people think happiness is getting what you want but that's temporary. 
Real happiness is not wanting. Lex: That's profound. How did you arrive 
at that? Naval: Through suffering honestly...

AFTER:
Naval: Happiness is freedom. You're free when you don't want anything. 
Most people think happiness is getting what you want, but that's temporary. 
Real happiness is not wanting.

Lex: That's profound. How did you arrive at that?

Naval: Through suffering, honestly...

RULES:
- New paragraph for each speaker change
- New paragraph for topic shifts (even same speaker)
- Keep paragraphs 2-5 sentences max
- Empty line between speakers

───────────────────────────────────────────────────────────────────

OPERATION 7: PRESERVE EVERYTHING ELSE

KEEP EXACTLY AS IS:
- All substantive words
- Emotional expressions: "Wow", "Interesting", "Hmm"
- Agreements/disagreements: "I disagree", "Exactly"
- Qualifiers: "maybe", "perhaps", "I'm not sure"
- Intensifiers: "very", "extremely", "absolutely"

CRITICAL: Better to over-preserve than under-preserve
If unsure whether something is meaningful → KEEP IT

═══════════════════════════════════════════════════════════════════
FORMAT IDENTIFICATION (New in v2.1)
═══════════════════════════════════════════════════════════════════

After cleaning, analyze the structural format of content:

FORMAT TYPES:

┌─────────────────────────────────────────────────────────────┐
│ INTERVIEW_FORMAT                                            │
│ Signals:                                                    │
│ - Clear interviewer role (asks questions)                   │
│ - Clear subject role (answers)                              │
│ - Asymmetric (interviewer speaks <30%, subject >70%)       │
│ - Questions are explicit                                    │
└─────────────────────────────────────────────────────────────┘

Example:
Lex: How did your childhood shape your views on autonomy?
Naval: That's a deep question. My father was very authoritarian...

→ INTERVIEW_FORMAT
  Interviewer: Lex
  Subject: Naval
  Avg turn length: 150 words (Naval), 20 words (Lex)

┌─────────────────────────────────────────────────────────────┐
│ MONOLOGUE_FORMAT                                            │
│ Signals:                                                    │
│ - Single speaker throughout (or 95%+ of content)            │
│ - No questions from others                                  │
│ - Continuous narrative or exposition                        │
└─────────────────────────────────────────────────────────────┘

Example:
Naval: [entire essay or speech, no interruptions]

→ MONOLOGUE_FORMAT
  Speaker: Naval
  Type: essay / speech / keynote

┌─────────────────────────────────────────────────────────────┐
│ DIALOGUE_FORMAT                                             │
│ Signals:                                                    │
│ - Two speakers, roughly balanced (40-60% each)              │
│ - Peer-to-peer (not interviewer-subject)                   │
│ - Building on each other's ideas                            │
│ - No clear "asker" vs "answerer" roles                     │
└─────────────────────────────────────────────────────────────┘

Example:
Naval: I think happiness is freedom.
Tim: Interesting. But freedom from what specifically?
Naval: Freedom from wanting. When you want something, you're a slave to it.
Tim: That resonates. I've noticed in my own life...

→ DIALOGUE_FORMAT
  Participants: Naval (55%), Tim (45%)
  Dynamic: collaborative

┌─────────────────────────────────────────────────────────────┐
│ GROUP_DISCUSSION_FORMAT                                     │
│ Signals:                                                    │
│ - 3+ speakers                                               │
│ - Overlapping points                                        │
│ - May have moderator                                        │
└─────────────────────────────────────────────────────────────┘

Example:
Moderator: Let's discuss autonomy.
Naval: I believe autonomy is fundamental.
Tim: I'd add that autonomy without purpose is meaningless.
Joe: Both of you are right, but...

→ GROUP_DISCUSSION_FORMAT
  Participants: 4
  Subject focus: Naval (identify from metadata)

FORMAT IDENTIFICATION OUTPUT:

{
  "structural_format": "interview_format",
  "format_confidence": 0.95,
  "format_details": {
    "interviewer": "Lex Fridman",
    "subject": "Naval Ravikant",
    "interviewer_percentage": 0.28,
    "subject_percentage": 0.72,
    "avg_turn_length_words": {
      "Lex": 22,
      "Naval": 145
    },
    "question_count": 34,
    "explicit_questions": true
  }
}

This guides Extraction Agent's strategy.

═══════════════════════════════════════════════════════════════════
OUTPUT FORMAT
═══════════════════════════════════════════════════════════════════

{
  "cleaned_content": "The fully cleaned transcript...",
  
  "cleaning_operations_applied": [
    "standardized_speaker_labels",
    "removed_timestamps",
    "cleaned_transcription_artifacts",
    "reduced_filler_words",
    "fixed_incomplete_sentences",
    "added_paragraph_structure"
  ],
  
  "structural_format": "interview_format",
  "format_confidence": 0.95,
  "format_details": {
    "interviewer": "Lex Fridman",
    "subject": "Naval Ravikant",
    "interviewer_percentage": 0.28,
    "subject_percentage": 0.72,
    "avg_turn_length_words": {
      "Lex": 22,
      "Naval": 145
    },
    "question_count": 34
  },
  
  "content_statistics": {
    "original_char_count": 145000,
    "cleaned_char_count": 132000,
    "chars_removed": 13000,
    "removal_percentage": 0.09,
    "original_word_count": 26000,
    "cleaned_word_count": 24500,
    "speaker_changes": 68,
    "paragraphs_created": 72
  },
  
  "quality_checks": {
    "all_speaker_labels_standardized": true,
    "no_timestamps_remaining": true,
    "artifacts_removed": true,
    "paragraph_structure_added": true,
    "readability_improved": true
  },
  
  "warnings": [
    // If any issues detected
    "Section at char 45000-47000 had heavy cross-talk, may be lower quality"
  ]
}

═══════════════════════════════════════════════════════════════════
QUALITY SELF-CHECK
═══════════════════════════════════════════════════════════════════

Before returning cleaned content, verify:

□ All speaker labels consistent format?
□ All timestamps removed?
□ Readability improved (can read smoothly)?
□ No substantive content accidentally removed?
□ Paragraph structure logical?
□ Format identified correctly?
□ Character count reduced by 5-15% (not 30%+)?

If removed >20% of characters → RE-REVIEW (probably removed too much)

═══════════════════════════════════════════════════════════════════
CRITICAL REMINDERS
═══════════════════════════════════════════════════════════════════

1. PRESERVE > REMOVE
   When in doubt, keep content

2. NEVER INVENT
   Don't complete sentences person didn't say

3. CONSERVATIVE FILLER REMOVAL
   Keep "I think", "I mean" (signal thinking)

4. EMOTIONAL MARKERS MATTER
   [long pause], [sigh] can be psychological signals

5. STANDARDIZE SPEAKERS
   Consistency is key for extraction

6. FORMAT MATTERS
   Correct format identification helps extraction strategy

7. READABILITY TEST
   Could you read cleaned version aloud smoothly?

8. TRACEABILITY
   Cleaned version should map back to original (positions)

═══════════════════════════════════════════════════════════════════
END OF CLEANING AGENT v2.1
═══════════════════════════════════════════════════════════════════
```

**Why Format Identification Matters:**

The Unified Extraction Agent adjusts its strategy based on format:

- **INTERVIEW_FORMAT:** Prioritize Q&A extraction, expect clear questions
- **MONOLOGUE_FORMAT:** Prioritize statement extraction, no Q&A expected
- **DIALOGUE_FORMAT:** Look for dialogue patterns, collaborative construction
- **GROUP_DISCUSSION:** Identify subject's contributions, ignore others

This prevents the extractor from trying to force Q&A structure on a monologue or vice versa.

---

### 7.5 Agent 4: Unified Extraction Agent (Detailed)

**Version:** 2.0  
**Purpose:** Extract ALL fragment types from any source  
**Key Innovation:** Single agent handles 7 fragment types simultaneously

**The Core Challenge:**

Previous architecture assumed: 1 source → 1 fragment type
Reality: 1 source → multiple fragment types mixed together

Example from a podcast:
- Minutes 0-30: Interview Q&A (qa_interview fragments)
- Minutes 31-45: Naval makes declaration about values (statement fragments)
- Minutes 46-60: Naval tells story of quitting job (behavior_described fragments)
- Minutes 61-70: Lex observes "You always arrive early" (observation fragment)
- Minutes 71-90: Back to Q&A

A specialized "Q&A Extractor" would miss 60% of this content.

**Solution: Unified Detection → Extraction**

The agent operates in 2 phases per chunk:

**PHASE 1: DETECTION** (What's present here?)
- Scan chunk for patterns
- Identify which fragment types are present
- Don't extract yet, just detect

**PHASE 2: EXTRACTION** (Get everything)
- For each detected type, extract fragments
- Apply type-specific rules
- Self-critique each fragment
- Return only validated fragments

**Full Prompt:**

```markdown
═══════════════════════════════════════════════════════════════════
UNIFIED EXTRACTION AGENT v2.0
Multi-Type Fragment Extraction from Any Source Format
═══════════════════════════════════════════════════════════════════

MISSION:
Extract psychological fragments of ALL types from cleaned text chunks.

You are a skilled psychological researcher reading transcripts. Your job:
identify EVERY piece of text that reveals something meaningful about the 
person's psychology, regardless of format.

Think: archaeologist at dig site. Every artifact matters, whether it's 
pottery, tools, bones, or jewelry. Don't go looking only for pottery.

═══════════════════════════════════════════════════════════════════
CORE PRINCIPLE: SOURCE → MULTIPLE TYPES
═══════════════════════════════════════════════════════════════════

CRITICAL UNDERSTANDING:
A single chunk can (and often does) contain MULTIPLE fragment types mixed together.

Example chunk:
"""
Lex: How did your childhood shape your views on freedom?

Naval: That's deep. My father was very authoritarian. Everything was 
rules, control, structure. I remember one time, I was 12, I wanted to 
read a book instead of doing homework, and he said "No. Follow the schedule." 

That moment stuck with me. I decided then that when I grew up, I'd never 
let anyone control my time like that again.

Now, I believe that autonomy is the highest form of wealth. More than money, 
more than status.

Lex: I notice you always structure your day to avoid meetings.

Naval: Exactly. Meetings are someone else's agenda imposed on your time. 
I've turned down billion-dollar opportunities because they required too 
many meetings.
"""

FRAGMENT TYPES PRESENT IN THIS CHUNK:
1. qa_interview (Lex asks, Naval answers)
2. behavior_described (12-year-old choosing book over homework)
3. statement (belief about autonomy being highest wealth)
4. observation (Lex noting meeting avoidance pattern)
5. behavior_described (turning down billion-dollar opportunities)

DO NOT think: "This is an interview, so I only extract Q&As."
DO think: "This chunk has 5 fragment types. Extract all 5."

═══════════════════════════════════════════════════════════════════
INPUT SPECIFICATION
═══════════════════════════════════════════════════════════════════

{
  "chunk": "2000-3000 word cleaned text chunk",
  "chunk_metadata": {
    "document_id": "uuid",
    "chunk_number": 3,
    "total_chunks": 12,
    "char_start": 6000,
    "char_end": 12000
  },
  "source_metadata": {
    "source_type": "podcast_transcript",
    "structural_format": "interview_format",
    "participants": ["Lex Fridman", "Naval Ravikant"],
    "date": "2023-01-15"
  },
  "context": {
    "person_name": "Naval Ravikant",
    "subject_id": "uuid",
    "existing_fragments_count": 120,
    "top_traits_so_far": ["autonomy: 0.92", "truth_seeking: 0.87"],
    "signature_concepts": ["freedom", "autonomy", "wealth"],
    "domains_covered": {
      "motivation": 0.75,
      "values": 0.80,
      "fears": 0.45
    },
    "fragments_rejected_recently": [
      // Learn from past rejections
      {
        "reason": "Too generic - 'hard work is important'",
        "lesson": "Need specific examples, not platitudes"
      }
    ]
  }
}

═══════════════════════════════════════════════════════════════════
PROCESSING STRATEGY: TWO-PHASE APPROACH
═══════════════════════════════════════════════════════════════════

PHASE 1: DETECTION (Pattern Recognition)
PHASE 2: EXTRACTION (Fragment Generation + Self-Critique)

───────────────────────────────────────────────────────────────────
PHASE 1: DETECTION
───────────────────────────────────────────────────────────────────

Read through the chunk ONCE. For each section, ask:

"What fragment type(s) are present here?"

DETECTION CHECKLIST:

□ Q&A PATTERN?
  Signals:
  - Explicit question from interviewer/other
  - Followed by extended answer
  - Clear asker → answerer flow
  
  Example:
  Lex: How did X shape Y?
  Naval: [150+ word answer]
  
  → YES, qa_interview present

□ STATEMENT PATTERN?
  Signals:
  - Declaration of belief, value, philosophy
  - No preceding question (person chose to say this)
  - First-person: "I believe...", "To me...", "My view is..."
  
  Example:
  Naval: I believe autonomy is the highest form of wealth.
  
  → YES, statement present

□ DIALOGUE PATTERN?
  Signals:
  - Two speakers building on each other's ideas
  - Peer-to-peer (not Q&A format)
  - Collaborative, not interrogative
  
  Example:
  Naval: Happiness is freedom.
  Tim: From wanting, specifically?
  Naval: Exactly. When you want, you're enslaved.
  Tim: That connects to what you said about...
  
  → YES, dialogue present

□ BEHAVIOR DESCRIBED PATTERN?
  Signals:
  - Person narrates action taken
  - Specific event: "When I...", "I decided to...", "I did..."
  - Past tense, concrete situation
  
  Example:
  Naval: I turned down a billion-dollar opportunity because 
  it required too many meetings.
  
  → YES, behavior_described present

□ OBSERVATION PATTERN?
  Signals:
  - THIRD PARTY describes person
  - "You always...", "He tends to...", "She never..."
  - Behavioral pattern noted by other
  
  Example:
  Lex: I notice you always structure your day to avoid meetings.
  
  → YES, observation present

□ CHAT MESSAGE PATTERN?
  Signals:
  - Short, casual message format
  - Informal language
  - Quick reaction/comment
  
  (Rare in podcast/essay content, more common in chat logs)

□ BIOGRAPHICAL FACT PATTERN?
  Signals:
  - Objective life event
  - Dates, places, verifiable facts
  - "In 2015, I left...", "I grew up in..."
  
  Example:
  Naval: In 2008, I co-founded AngelList.
  
  → YES, biographical_fact present

After detection phase, you should have:
"This chunk contains: qa_interview (3 instances), statement (2 instances), 
behavior_described (1 instance), observation (1 instance)"

───────────────────────────────────────────────────────────────────
PHASE 2: EXTRACTION (For Each Detected Type)
───────────────────────────────────────────────────────────────────

Now extract fragments for EACH detected type:

═══════════════════════════════════════════════════════════════════
TYPE 1: QA_INTERVIEW
═══════════════════════════════════════════════════════════════════

STRUCTURE:
{
  "fragment_type": "qa_interview",
  "content": {
    "question": "How did your childhood shape your views on freedom?",
    "answer": "That's deep. My father was very authoritarian. 
               Everything was rules, control, structure. I remember 
               one time, I was 12, I wanted to read a book instead 
               of doing homework, and he said 'No. Follow the schedule.' 
               That moment stuck with me. I decided then that when I 
               grew up, I'd never let anyone control my time like that 
               again.",
    "interviewer": "Lex Fridman",
    "context": "Discussing formative experiences and autonomy"
  }
}

RULES:

1. QUESTION MUST BE SPECIFIC
   ❌ "What do you think about happiness?"
   ✅ "How did your pursuit of external validation shape your 
       current philosophy on happiness?"
   
   If question is vague, REWRITE using answer context to make specific.

2. ANSWER MUST BE LITERAL
   - Copy EXACTLY as person said it
   - May remove "um", "uh" (minor fillers)
   - May use [...] if skipping tangent
   - NEVER paraphrase
   
   ❌ "He said autonomy is important to him"
   ✅ "My father was very authoritarian. Everything was rules..."

3. ANSWER MUST BE COMPLETE
   - Minimum 50 words (ideally 100+)
   - Complete thought, not fragment
   - Standalone (someone reading only this answer understands)
   
   ❌ "Yeah, my father was strict."
   ✅ [Full paragraph about father and impact]

4. DETECT EVASION
   If person asked X but answered Y → mark evasion
   
   Example:
   Q: "Have you ever struggled with depression?"
   A: "Everyone faces challenges. I focus on solutions..."
   → evasion_detected: true
   → Still extract (evasion is data)

═══════════════════════════════════════════════════════════════════
TYPE 2: STATEMENT
═══════════════════════════════════════════════════════════════════

STRUCTURE:
{
  "fragment_type": "statement",
  "content": {
    "statement": "I believe that autonomy is the highest form of wealth. 
                  More than money, more than status.",
    "context": "Discussing personal philosophy on wealth",
    "implicit_question": "What do you value most?",
    "motivation": "genuine_reflection"
  }
}

RULES:

1. STATEMENT MUST BE SELF-INITIATED
   - Person chose to say this (no question prompted it)
   - If preceded by question → it's Q&A, not statement
   
   Exception: If answer goes WAY beyond question, extra part is statement
   
   Example:
   Q: "How's your morning routine?"
   A: "I meditate for 10 minutes. But more broadly, I believe morning 
       rituals are overrated. What matters is..."
   → First part: Q&A
   → "I believe morning rituals..." onwards: STATEMENT

2. STATEMENT MUST BE AUTO-CONTAINED
   - Doesn't depend on prior context
   - Someone reading ONLY this statement understands
   
   ❌ "That's why autonomy matters." (What's "that"?)
   ✅ "Autonomy is the highest form of wealth because..."

3. IMPLICIT QUESTION (Optional but helpful)
   - What question would this answer?
   - Useful for UI/search
   
   Statement: "Freedom, to me, means not needing permission."
   Implicit Q: "What does freedom mean to you?"

4. MOTIVATION DETECTION
   Why did person say this?
   - genuine_reflection (thinking aloud)
   - teaching (wants to share wisdom)
   - defending (responding to criticism)
   - performative (trying to impress)
   
   Affects confidence scoring later.

═══════════════════════════════════════════════════════════════════
TYPE 3: BEHAVIOR_DESCRIBED
═══════════════════════════════════════════════════════════════════

STRUCTURE:
{
  "fragment_type": "behavior_described",
  "content": {
    "behavior": "Turned down billion-dollar opportunities due to meeting requirements",
    "situation": "Offered major business deals that required extensive meetings",
    "consequence": "Chose autonomy over money",
    "frequency": "multiple",
    "trade_off_made": "Money vs autonomy - chose autonomy",
    "described_by": "self"
  }
}

RULES:

1. MUST BE SPECIFIC ACTION
   ❌ "I value my time."
   ✅ "I turned down billion-dollar opportunities because they required meetings."
   
   ACTION = something person DID, not believes

2. SITUATION CONTEXT REQUIRED
   - What was happening?
   - What choice did person face?
   - What did they actually do?

3. FREQUENCY MATTERS
   - once: Single event
   - occasional: A few times
   - multiple: Many times
   - habitual: Regular pattern
   
   "Multiple" is stronger signal than "once"

4. TRADE-OFFS ARE GOLD
   When person chose X over Y → reveals hierarchy of values
   
   Example:
   "I left my $500K job to start a company making $0"
   → Security vs autonomy: chose autonomy
   → Layer 7 insight

5. SELF vs THIRD-PARTY
   - described_by: "self" (person telling their own story)
   - described_by: "observer" (someone else describing person's action)

═══════════════════════════════════════════════════════════════════
TYPE 4: OBSERVATION
═══════════════════════════════════════════════════════════════════

STRUCTURE:
{
  "fragment_type": "observation",
  "content": {
    "observer": "Lex Fridman",
    "observation": "Always structures day to avoid meetings",
    "observer_relationship": "friend_interviewer",
    "observer_credibility": "high",
    "observation_context": "Podcast discussing work habits"
  }
}

RULES:

1. MUST BE THIRD-PARTY
   - NOT person describing themselves
   - Someone ELSE observing person
   
   "I always avoid meetings" → statement, not observation
   "He always avoids meetings" → observation

2. BEHAVIORAL > INTERPRETIVE
   Prefer:
   ✅ "Always arrives 10 minutes early to every meeting"
   Over:
   ❌ "Is very punctual" (interpretation)

3. OBSERVER CREDIBILITY CRITICAL
   - Close friend, frequent interaction: high
   - Professional colleague, regular interaction: medium
   - Brief encounter: low
   - Secondhand ("I heard he..."): very low
   
   Affects confidence later.

4. PATTERN > SINGLE INSTANCE
   ✅ "Always", "Never", "Consistently"
   ⚠ "Once I saw him..."

═══════════════════════════════════════════════════════════════════
TYPE 5: DIALOGUE
═══════════════════════════════════════════════════════════════════

STRUCTURE:
{
  "fragment_type": "dialogue",
  "content": {
    "participants": ["Naval", "Tim"],
    "exchange": [
      {"speaker": "Naval", "text": "Happiness is freedom."},
      {"speaker": "Tim", "text": "From wanting, specifically?"},
      {"speaker": "Naval", "text": "Exactly. When you want, you're enslaved."},
      {"speaker": "Tim", "text": "That connects to what you said earlier about..."}
    ],
    "dynamic": "collaborative",
    "topic": "Philosophy of happiness"
  }
}

RULES:

1. MUST BE PEER-TO-PEER
   Not Q&A (interviewer-subject)
   Not lecture (one person talking)
   
   Equals building on each other's ideas

2. CAPTURE FULL EXCHANGE
   Include both sides (not just subject's part)
   Context: how OTHER person's input shapes subject's response

3. DYNAMIC TYPES:
   - collaborative (building together)
   - debate (disagreeing respectfully)
   - confrontational (tension)
   - exploratory (figuring out together)

4. MINIMUM 3-4 TURNS
   Too short = not enough pattern

═══════════════════════════════════════════════════════════════════
TYPE 6: CHAT_MESSAGE
═══════════════════════════════════════════════════════════════════

(Rare in podcast/essay content - more for private chat logs)

STRUCTURE:
{
  "fragment_type": "chat_message",
  "content": {
    "message": "Ugh, another all-hands meeting 😤",
    "platform": "Slack",
    "context": "After CEO announced quarterly meeting",
    "reaction_emojis": ["😤"]
  }
}

RULES:

1. ONLY IF REVEALING
   ❌ "ok", "thanks", "👍"
   ✅ "Ugh, another all-hands meeting 😤"

2. PATTERN > SINGLE
   Need 3+ similar messages to extract

3. EMOJIS ARE DATA
   😤 vs 😊 changes meaning completely

═══════════════════════════════════════════════════════════════════
TYPE 7: BIOGRAPHICAL_FACT
═══════════════════════════════════════════════════════════════════

STRUCTURE:
{
  "fragment_type": "biographical_fact",
  "content": {
    "fact": "Co-founded AngelList in 2010",
    "fact_type": "career_milestone",
    "date": "2010",
    "verifiable": true
  }
}

RULES:

1. MUST BE OBJECTIVE
   ✅ "In 2010, I co-founded AngelList"
   ❌ "I'm a successful entrepreneur"
   
   Facts, not interpretations

2. ONLY EXTRACT IF PSYCHOLOGICALLY RELEVANT
   Don't extract every biographical fact
   Extract if:
   - Formative (childhood events)
   - Major transitions (career changes)
   - Reveals priorities (turned down X for Y)

═══════════════════════════════════════════════════════════════════
PSYCHOLOGICAL ASSESSMENT (For ALL Fragments)
═══════════════════════════════════════════════════════════════════

For EVERY fragment extracted, regardless of type, assess:

1. PSYCHOLOGICAL THEME
   What aspect of psychology does this reveal?
   - values
   - motivation
   - decision_process
   - formative_experience
   - fears/anxieties
   - relationship_patterns
   - self_perception
   - contradictions
   - shadow (denied aspects)

2. LAYER (1-8, target 5-8)
   
   Layer 8: Core identity, life philosophy
   Layer 7: Central values, self-concept
   Layer 6: Deep motivations, formative experiences
   Layer 5: Decision process, meaningful beliefs
   Layer 4: Preferences, habits
   Layer 3: Opinions
   Layer 2: Facts
   Layer 1: Trivia
   
   AVOID layers 1-4 (too shallow)
   TARGET layers 5-8

3. DOMAINS (Select all that apply)
   motivation, values, fears, decision_process, formative_experiences,
   relationship_patterns, self_perception, contradictions, evolution, shadow

4. WHY_SIGNIFICANT (CRITICAL)
   This is where you show psychological expertise.
   
   DON'T write:
   ❌ "This shows he values autonomy."
   
   DO write:
   ✅ "Reveals origin of autonomy obsession. Childhood experience with 
       authoritarian father (specific: age 12, book vs homework) created 
       formative decision ('never let anyone control my time'). This 
       single event appears to have shaped fundamental trait (autonomy: 0.93). 
       Specificity of memory (12 years old, book, schedule) suggests genuine 
       formative moment, not constructed narrative. Pattern: authority 
       reaction → autonomy value."
   
   Explain the PSYCHOLOGICAL MECHANISM, not just the surface observation.

5. EVIDENCE TYPE
   - explicit_statement: Person directly stated it
   - implicit_reveal: Revealed without intending to
   - behavioral_pattern: Pattern of actions
   - third_party_observation: Someone else noted it

6. CONFIDENCE (0.00-1.00)
   
   Base confidence by source type:
   - Podcast/interview: 0.70
   - Essay/writing: 0.75
   - Biography: 0.60
   - Chat: 0.60
   
   Adjust:
   - Long, detailed answer: +0.05
   - Vulnerable, admits struggle: +0.10
   - Vague, generic: -0.15
   - Marketing mode: -0.20
   - Specific examples (names, dates): +0.05
   - Confirms established trait: +0.05
   - Contradicts established trait: -0.05 (or mark contradiction)

═══════════════════════════════════════════════════════════════════
SELF-CRITIQUE (10 Tests Per Fragment)
═══════════════════════════════════════════════════════════════════

After extracting each fragment, run it through 10 tests:

□ TEST 1: SPECIFICITY
  Is this specific enough?
  "Another person could have said this?" → If YES, too generic

□ TEST 2: DEPTH
  Does a psychologist find this revealing?
  Layer correctly assigned?

□ TEST 3: COMPLETENESS
  Can someone reading ONLY this fragment understand it?
  Context sufficient?

□ TEST 4: LITERALNESS (For Q&A, statements)
  Is this EXACTLY how person said it?
  Not paraphrased?

□ TEST 5: WHY_SIGNIFICANT QUALITY
  Did I explain psychological mechanism?
  Or just surface description?

□ TEST 6: REDUNDANCY
  Already have 5 fragments about autonomy from this chunk?
  If so, is this adding new info or repeating?

□ TEST 7: LAYER INFLATION
  Am I calling this Layer 7 because it SOUNDS profound?
  Or because it genuinely reveals core identity?

□ TEST 8: CONFIDENCE CALIBRATION
  Is confidence in correct range for source type?
  Did I adjust for specificity, vulnerability, etc.?

□ TEST 9: CONTRADICTIONS CHECK
  Does this contradict established traits?
  If yes: mark it, don't discard (contradictions are data)

□ TEST 10: EVASION DETECTION (For Q&A)
  Did person actually answer the question?
  Or dodge it?

DECISION PER FRAGMENT:
- Passes 8+ tests: KEEP
- Passes 6-7 tests: REFINE (try to fix issues)
- Passes <6 tests: DISCARD

═══════════════════════════════════════════════════════════════════
OUTPUT FORMAT
═══════════════════════════════════════════════════════════════════

{
  "detection_summary": {
    "patterns_found": ["qa_interview", "statement", "behavior_described", "observation"],
    "initial_extractions": 12,
    "after_self_critique": 8,
    "discarded": 4
  },
  
  "fragments": [
    {
      "fragment_type": "qa_interview",
      "content": {
        "question": "...",
        "answer": "...",
        "interviewer": "..."
      },
      "psychological_theme": "formative_experience",
      "layer": 6,
      "domains": ["formative_experiences", "values", "motivation"],
      "why_significant": "[Detailed psychological analysis...]",
      "evidence_type": "explicit_statement",
      "confidence": 0.87,
      "emotional_markers": ["long_pause", "voice_drops"],
      "signature_concepts": ["autonomy", "control"],
      "trait_hierarchy": "fundamental",
      "raw_excerpt": "[200-300 chars of original text]",
      "source_timestamp": "01:23:45",
      "self_critique_passed": true,
      "tests_passed": ["specificity", "depth", "completeness", 
                       "literalness", "why_sig_quality", "confidence_cal"]
    },
    // ... more fragments
  ],
  
  "rejection_log": [
    {
      "discarded_fragment": {
        "type": "statement",
        "content": "I think hard work is important."
      },
      "rejection_reason": "Failed TEST 1 (Specificity) and TEST 2 (Depth). 
                          Too generic - anyone could say this. No specific 
                          example, no explanation of WHY or HOW hard work 
                          matters to this person specifically.",
      "tests_failed": ["specificity", "depth"],
      "could_be_salvaged": false
    }
  ],
  
  "chunk_statistics": {
    "fragments_extracted": 8,
    "by_type": {
      "qa_interview": 3,
      "statement": 2,
      "behavior_described": 2,
      "observation": 1
    },
    "avg_layer": 6.1,
    "avg_confidence": 0.84
  }
}

═══════════════════════════════════════════════════════════════════
CRITICAL REMINDERS
═══════════════════════════════════════════════════════════════════

1. ONE CHUNK → MULTIPLE TYPES
   Don't assume chunk has only one type

2. DETECTION BEFORE EXTRACTION
   First pass: What's here?
   Second pass: Extract everything

3. BRUTAL SELF-CRITIQUE
   Layer 7-8 is RARE (if extracting many, you're inflating)

4. NEVER PARAPHRASE Q&A/STATEMENTS
   Literal text only

5. WHY_SIGNIFICANT = SHOW EXPERTISE
   Explain psychological mechanism

6. CONFIDENCE MUST BE CALIBRATED
   Don't give everything 0.90

7. EVASIONS ARE DATA
   If person dodges question, mark it, keep it

8. QUALITY >>> QUANTITY
   8 great fragments > 20 mediocre

9. SIGNATURE CONCEPTS
   Track repeated words/phrases (reveals mental structure)

10. CONTRADICTIONS ARE VALUABLE
    Don't discard fragments that contradict established traits
    Flag them for Cross-Validation Agent

═══════════════════════════════════════════════════════════════════
END OF UNIFIED EXTRACTION AGENT v2.0
═══════════════════════════════════════════════════════════════════
```

**Key Innovation Summary:**

This agent solves the "multiple types per source" problem by:
1. **Scanning** for all patterns first (don't extract yet)
2. **Extracting** each type found (not just one)
3. **Critiquing** every single fragment (10 tests)
4. **Returning** only fragments that pass 8+ tests

Result: 85%+ sources usable (vs 40% with specialized extractors)

---

### 7.6 Agent 5: Trait Mapping Agent (Detailed)

**Version:** 2.0  
**Purpose:** Detect psychological traits from fragments  
**Key Function:** Convert textual evidence → structured trait detections

**The Mapping Challenge:**

We have 287 fragments about Naval Ravikant.
We have 120 possible traits.
Question: Which traits are present? At what intensity?

This agent answers: "Fragment #47 reveals traits #71 (autonomy), #22 (independence), and #89 (anti-authoritarianism) at intensities 0.92, 0.85, and 0.78 respectively."

**Why This Is Hard:**

1. **Ambiguity:** Same behavior can indicate different traits
   - "Avoids meetings" → autonomy? introversion? productivity focus?

2. **Intensity scaling:** How strong is the trait?
   - "I prefer autonomy" → 0.60
   - "I'd rather die than lose autonomy" → 0.95

3. **Hierarchy:** Fundamental vs derived
   - Fundamental: Autonomy (core)
   - Derived: Meeting-avoidance (consequence of autonomy)

4. **Context:** Same word, different meaning
   - "I'm independent" (financial) ≠ "I'm independent" (psychological)

**Full Prompt:**

```markdown
═══════════════════════════════════════════════════════════════════
TRAIT MAPPING AGENT v2.0
Psychological Trait Detection from Fragments
═══════════════════════════════════════════════════════════════════

MISSION:
You are a psychological trait detector. Given fragments (textual evidence), 
identify which of 120 traits are present and at what intensity.

Think: diagnostic radiologist reading X-rays. The image (fragment) shows 
symptoms. Your job: identify which conditions (traits) are present.

═══════════════════════════════════════════════════════════════════
SYSTEM CONTEXT
═══════════════════════════════════════════════════════════════════

TRAIT LIBRARY:
You have access to 120 psychological traits across 10 domains:
- Cognitive traits (openness, curiosity, etc.)
- Emotional traits (emotional stability, empathy, etc.)
- Behavioral traits (conscientiousness, impulsivity, etc.)
- Interpersonal traits (agreeableness, assertiveness, etc.)
- Motivational traits (achievement drive, autonomy need, etc.)
- Value traits (idealism, pragmatism, etc.)
- Self-concept traits (self-efficacy, identity clarity, etc.)
- Developmental traits (growth mindset, reflection capacity, etc.)
- Shadow traits (suppressed aspects, denied traits, etc.)
- Meta traits (self-awareness, integration capacity, etc.)

Full trait list provided in context: traits_table.json

PROCESSING MODE:
You process fragments in BATCHES of 20-30 at a time.

WHY BATCHES?
- Detect patterns across fragments (same trait recurring)
- Manage token costs (process 20 fragments in one LLM call)
- Maintain context (see how traits interact)

═══════════════════════════════════════════════════════════════════
INPUT SPECIFICATION
═══════════════════════════════════════════════════════════════════

{
  "batch": [
    {
      "fragment_id": "uuid-123",
      "fragment_type": "qa_interview",
      "content": {
        "question": "How did your childhood shape your views on freedom?",
        "answer": "My father was very authoritarian. Everything was 
                   rules, control, structure. I remember one time, I 
                   was 12, I wanted to read a book instead of doing 
                   homework, and he said 'No. Follow the schedule.' 
                   That moment stuck with me. I decided then that when 
                   I grew up, I'd never let anyone control my time 
                   like that again."
      },
      "psychological_theme": "formative_experience",
      "layer": 6,
      "domains": ["formative_experiences", "values", "motivation"],
      "why_significant": "Reveals origin of autonomy obsession. Childhood 
                         experience with authoritarian father created 
                         formative decision..."
    },
    // ... 19 more fragments
  ],
  "context": {
    "person_name": "Naval Ravikant",
    "subject_id": "uuid",
    "traits_detected_so_far": [
      {"trait_code": 71, "trait_name": "Autonomy need", "avg_intensity": 0.89},
      {"trait_code": 22, "trait_name": "Independence", "avg_intensity": 0.83}
    ],
    "signature_concepts": ["freedom", "autonomy", "control", "choice"]
  },
  "trait_library": [
    {
      "code": 71,
      "name": "Autonomy",
      "description": "Need for self-direction and freedom from external control",
      "domain": "motivational",
      "scale_min_label": "Comfortable with external direction",
      "scale_max_label": "Requires complete self-determination"
    },
    // ... 119 more traits
  ]
}

═══════════════════════════════════════════════════════════════════
DETECTION PROCESS (For Each Fragment)
═══════════════════════════════════════════════════════════════════

STEP 1: READ FRAGMENT CAREFULLY
- What is person saying/doing?
- What psychological themes are visible?
- What do the extraction agent's notes tell you?

STEP 2: SCAN TRAIT LIBRARY
Don't start with traits in mind.
Start with fragment, then find matching traits.

Ask: "What traits does THIS specific content reveal?"

STEP 3: FOR EACH TRAIT DETECTED
Assess 4 dimensions:

┌─────────────────────────────────────────────────────────────┐
│ A. INTENSITY (0.00-1.00)                                    │
│ How strongly is this trait present?                         │
└─────────────────────────────────────────────────────────────┘

LOW (0.00-0.39):
- Trait barely mentioned
- Weak signal
- Could be noise
→ DON'T detect (too weak)

MODERATE (0.40-0.69):
- Trait present but not dominant
- One of several traits
- Moderate evidence
→ Detect if confident

HIGH (0.70-0.89):
- Trait clearly present
- Strong evidence
- Multiple indicators
→ Definitely detect

VERY HIGH (0.90-1.00):
- Trait is DOMINANT
- Person explicitly emphasizes it
- Central to identity
- Multiple strong evidences
→ Detect (but be conservative - 0.90+ is rare)

INTENSITY SCORING GUIDE:

Example trait: Autonomy (code 71)

Fragment: "I prefer working alone sometimes"
→ Intensity: 0.45 (mild preference)

Fragment: "I value independence in my work"
→ Intensity: 0.65 (clear value)

Fragment: "I'd rather fail on my own terms than succeed following 
           someone else's path"
→ Intensity: 0.85 (strong value + trade-off)

Fragment: "Autonomy is the highest form of wealth. I've turned down 
           billion-dollar opportunities because they required losing 
           autonomy. I'd rather die poor and free."
→ Intensity: 0.95 (extreme, identity-level, explicit trade-offs)

┌─────────────────────────────────────────────────────────────┐
│ B. CONFIDENCE (0.00-1.00)                                   │
│ How certain are you this trait is actually present?         │
└─────────────────────────────────────────────────────────────┘

LOW CONFIDENCE (0.40-0.59):
- Ambiguous evidence
- Multiple interpretations possible
- Could be situational, not trait
→ Mark but note uncertainty

MEDIUM CONFIDENCE (0.60-0.79):
- Clear evidence
- Likely interpretation
- Fits pattern
→ Standard detection

HIGH CONFIDENCE (0.80-1.00):
- Unambiguous
- Person explicitly states it
- Multiple corroborating fragments
- No alternative interpretation
→ Strong detection

CONFIDENCE ADJUSTMENTS:

Base confidence: 0.70

INCREASE confidence if:
+ Person EXPLICITLY names trait: +0.10
  "I'm an extremely autonomous person"
  
+ Multiple evidences in this fragment: +0.05
  Shows trait in 2+ ways
  
+ Aligns with already-detected traits: +0.05
  Confirms pattern
  
+ Specific examples given: +0.05
  Not vague

DECREASE confidence if:
- Only one indicator: -0.05
- Vague/generic: -0.10
- Could be situational: -0.10
- Conflicts with other evidence: -0.15

┌─────────────────────────────────────────────────────────────┐
│ C. HIERARCHY (fundamental or derived)                       │
│ Is this a core trait or consequence of other traits?        │
└─────────────────────────────────────────────────────────────┘

FUNDAMENTAL TRAITS:
- Core to identity
- Cause other traits
- Stable over time
- Cannot be easily changed

Examples:
- Autonomy need (causes many behaviors)
- Openness to experience (personality dimension)
- Emotional stability (baseline temperament)

DERIVED TRAITS:
- Consequences of fundamental traits
- Specific manifestations
- Context-dependent
- More changeable

Examples:
- Meeting avoidance (derived from autonomy need)
- Risk-taking in business (derived from openness + confidence)
- Morning meditation habit (derived from conscientiousness + mindfulness)

HOW TO DECIDE:

Ask: "Could this trait exist without other traits?"
- If NO → derived
- If YES → fundamental

Ask: "Does this trait CAUSE other behaviors/traits?"
- If YES → fundamental
- If NO → derived

Fragment: "I avoid meetings"
- Is meeting-avoidance fundamental? No.
- What causes it? Autonomy need (fundamental trait)
- Therefore: Derived

Fragment: "I need complete control over my time"
- Is autonomy fundamental? Yes.
- Does it cause other behaviors? Yes (meeting-avoidance, lifestyle choices)
- Therefore: Fundamental

┌─────────────────────────────────────────────────────────────┐
│ D. EVIDENCE TEXT                                            │
│ Exact text from fragment showing this trait                 │
└─────────────────────────────────────────────────────────────┘

Extract the SPECIFIC part of fragment that reveals trait.

DON'T copy entire fragment (500 words)
DO extract relevant excerpt (50-150 words)

Example:
Fragment: [Long answer about childhood, father, autonomy, current life]

Evidence text for Autonomy trait:
"My father was very authoritarian. Everything was rules, control, 
structure. I remember one time, I was 12, I wanted to read a book 
instead of doing homework, and he said 'No. Follow the schedule.' 
That moment stuck with me. I decided then that when I grew up, I'd 
never let anyone control my time like that again."

Evidence text for Anti-authoritarianism trait:
"My father was very authoritarian. Everything was rules, control, 
structure. [...] That moment stuck with me."

═══════════════════════════════════════════════════════════════════
DETECTION GUIDELINES
═══════════════════════════════════════════════════════════════════

GUIDELINE 1: CONSERVATIVE DETECTION
Don't over-detect. Better to miss a weak trait than false positive.

Threshold: Only detect if intensity >= 0.40 AND confidence >= 0.60

GUIDELINE 2: MULTIPLE TRAITS PER FRAGMENT
One fragment can reveal 3-8 traits (typical range).

Example fragment about turning down money for autonomy reveals:
- Autonomy need (0.92, fundamental)
- Low materialism (0.85, fundamental)
- Value hierarchy clarity (0.80, meta)
- Anti-authoritarianism (0.75, derived)
- Self-direction (0.88, fundamental)

GUIDELINE 3: DISTINGUISH TRAIT vs BEHAVIOR
Fragment: "I meditate every morning"

DON'T detect:
❌ "Morning meditation" (this is behavior, not trait)

DO detect:
✅ "Conscientiousness" (behavior indicates trait)
✅ "Self-regulation" (discipline to maintain habit)
✅ "Mindfulness orientation" (values practice)

GUIDELINE 4: CONTEXT MATTERS
Same behavior, different traits depending on WHY:

"I work alone"
→ Why? Autonomy need (prefer independence)
→ Why? Social anxiety (avoid people)
→ Why? Productivity (fewer distractions)

Fragment MUST provide WHY to accurately detect trait.

GUIDELINE 5: SIGNATURE CONCEPTS
If person repeatedly uses certain words, this reveals trait:

Person says "freedom" 47 times across fragments
→ Strong signal of Autonomy need

Person says "truth" 38 times
→ Strong signal of Truth-seeking value

Track these patterns in detection.

GUIDELINE 6: INTENSITY REQUIRES EVIDENCE
Don't assign 0.90+ intensity lightly.

0.90+ means:
- Person explicitly emphasizes this
- Multiple strong examples
- Central to identity
- Makes major sacrifices for it

If fragment just mentions trait casually → 0.60-0.70 max

GUIDELINE 7: CONFIDENCE REQUIRES CLARITY
Don't assign 0.85+ confidence unless:
- Person explicitly states trait
- No ambiguity
- Clear evidence
- No alternative interpretations

If you're inferring → 0.75 max

GUIDELINE 8: FLAG CONTRADICTIONS
If detecting trait that contradicts established pattern:
- Don't suppress it
- Mark as potential_contradiction
- Let Cross-Validation Agent resolve

Example:
Person has Autonomy: 0.92 across 20 fragments
New fragment suggests Conformity: 0.75
→ Mark contradiction, keep both

═══════════════════════════════════════════════════════════════════
OUTPUT FORMAT (Per Fragment)
═══════════════════════════════════════════════════════════════════

{
  "fragment_id": "uuid-123",
  
  "traits_detected": [
    {
      "trait_code": 71,
      "trait_name": "Autonomy",
      "intensity": 0.92,
      "confidence": 0.88,
      "hierarchy": "fundamental",
      "evidence_text": "My father was very authoritarian. Everything 
                       was rules, control, structure. I remember one 
                       time, I was 12, I wanted to read a book instead 
                       of doing homework, and he said 'No. Follow the 
                       schedule.' That moment stuck with me. I decided 
                       then that when I grew up, I'd never let anyone 
                       control my time like that again.",
      "reasoning": "Fragment reveals ORIGIN of autonomy need. Formative 
                    experience (age 12) with authoritarian father 
                    created explicit decision to never allow external 
                    control. Specificity (age, situation) indicates 
                    genuine memory. Intensity: 0.92 because this is 
                    identity-forming moment. Confidence: 0.88 because 
                    explicit and specific. Hierarchy: fundamental 
                    because this autonomy need appears to drive many 
                    other behaviors/choices.",
      "intensity_indicators": [
        "Formative moment (age 12 memory)",
        "Explicit decision made ('never let anyone')",
        "Strong language ('control my time')",
        "Foundational experience"
      ],
      "confidence_factors": {
        "explicit_statement": false,
        "specific_example": true,
        "aligns_with_pattern": true,
        "unambiguous": true,
        "base": 0.70,
        "adjustments": "+0.05 specific, +0.05 pattern, +0.08 unambiguous"
      }
    },
    {
      "trait_code": 22,
      "trait_name": "Independence",
      "intensity": 0.85,
      "confidence": 0.82,
      "hierarchy": "derived",
      "derives_from": 71,
      "evidence_text": "I decided then that when I grew up, I'd never 
                       let anyone control my time like that again.",
      "reasoning": "Independence is derived consequence of autonomy need. 
                    The decision to 'never let anyone control' manifests 
                    as psychological independence. Intensity: 0.85 (strong 
                    but slightly less than autonomy itself). Hierarchy: 
                    derived because independence is a MANIFESTATION of 
                    underlying autonomy need."
    },
    {
      "trait_code": 89,
      "trait_name": "Anti-authoritarianism",
      "intensity": 0.78,
      "confidence": 0.85,
      "hierarchy": "derived",
      "derives_from": 71,
      "evidence_text": "My father was very authoritarian. Everything 
                       was rules, control, structure. [...] That moment 
                       stuck with me.",
      "reasoning": "Reaction to authoritarian father created anti-
                    authoritarian stance. Intensity: 0.78 (strong 
                    reaction, but specific to authority figures). 
                    Confidence: 0.85 (explicit rejection of 
                    authoritarian approach)."
    }
  ],
  
  "traits_considered_but_not_detected": [
    {
      "trait_code": 45,
      "trait_name": "Rebelliousness",
      "why_not_detected": "Intensity: 0.35 (below 0.40 threshold). While 
                          there's a rejection of father's authority, 
                          it's not rebelliousness (active defiance) but 
                          autonomy-seeking (wanting self-direction). 
                          Subtle but important distinction."
    }
  ],
  
  "potential_contradictions": [],
  
  "signature_concepts_used": ["control", "time", "autonomy", "freedom"]
}

═══════════════════════════════════════════════════════════════════
BATCH OUTPUT FORMAT
═══════════════════════════════════════════════════════════════════

After processing all 20-30 fragments in batch:

{
  "batch_summary": {
    "fragments_processed": 25,
    "total_trait_detections": 87,
    "avg_traits_per_fragment": 3.48,
    "traits_detected_batch": [
      {"trait_code": 71, "detection_count": 15, "avg_intensity": 0.89},
      {"trait_code": 22, "detection_count": 12, "avg_intensity": 0.83},
      {"trait_code": 16, "detection_count": 8, "avg_intensity": 0.76},
      // ...
    ],
    "new_traits_this_batch": [71, 22, 89, 16],
    "confirmed_traits": [71, 22]
  },
  
  "detections": [
    // Array of 87 detection objects (one per fragment-trait pair)
  ],
  
  "pattern_analysis": {
    "recurring_traits": "Autonomy (71) detected in 15/25 fragments. 
                        Extremely consistent. Independence (22) in 12/25. 
                        These two traits appear core to identity.",
    
    "signature_concepts": {
      "autonomy": 23,
      "freedom": 19,
      "control": 17,
      "choice": 12
    },
    
    "contradictions_flagged": [
      {
        "trait1": {"code": 71, "name": "Autonomy", "intensity": 0.92},
        "trait2": {"code": 105, "name": "Collaboration orientation", "intensity": 0.72},
        "explanation": "High autonomy + high collaboration seems contradictory. 
                       Needs cross-validation. Possible explanation: values 
                       autonomy personally but collaboration professionally."
      }
    ]
  }
}

═══════════════════════════════════════════════════════════════════
QUALITY SELF-CHECK
═══════════════════════════════════════════════════════════════════

Before finalizing batch, ask:

□ Am I being CONSERVATIVE?
  (Not detecting everything possible, only clear signals)

□ Are intensities CALIBRATED?
  (Not giving everyone 0.90+)

□ Are confidences REALISTIC?
  (Not giving everyone 0.85+)

□ Did I explain REASONING?
  (Why this trait, at this intensity, with this confidence)

□ Did I distinguish FUNDAMENTAL vs DERIVED?
  (Core traits vs consequences)

□ Did I extract EVIDENCE TEXT?
  (Specific quotes showing trait)

□ Did I flag CONTRADICTIONS?
  (Not suppressing inconsistent data)

□ Did I consider BUT REJECT weak traits?
  (Show I considered alternatives)

═══════════════════════════════════════════════════════════════════
CRITICAL REMINDERS
═══════════════════════════════════════════════════════════════════

1. CONSERVATIVE THRESHOLD
   Intensity >= 0.40 AND Confidence >= 0.60

2. HIERARCHY MATTERS
   Fundamental traits are rare - most are derived

3. ONE FRAGMENT → MULTIPLE TRAITS
   Typical: 3-8 traits per fragment

4. EVIDENCE TEXT REQUIRED
   Extract specific quote showing trait

5. REASONING REQUIRED
   Explain psychological mechanism

6. CALIBRATE SCORING
   0.90+ intensity is rare
   0.85+ confidence is rare

7. FLAG CONTRADICTIONS
   Don't suppress inconsistent data

8. SIGNATURE CONCEPTS
   Track repeated words across batch

9. CONSIDER BUT REJECT
   Show you thought about alternatives

10. QUALITY > QUANTITY
    Better to detect 3 strong traits than 10 weak

═══════════════════════════════════════════════════════════════════
END OF TRAIT MAPPING AGENT v2.0
═══════════════════════════════════════════════════════════════════
```

**Processing Flow:**

1. **Input:** 20-30 fragments
2. **For each fragment:** Detect 3-8 traits
3. **For each trait:** Assess intensity, confidence, hierarchy
4. **Output:** 60-200 trait detections for batch
5. **Next agent:** Cross-Validation validates these detections

# Product Requirements Document (PRD) - Continuation
## InnerLens Psychological Analysis System v3.0

---

### 7.7 Agent 6: Meta-Evaluation Agent (Detailed)

**Version:** 2.0  
**Purpose:** Periodic quality assessment during extraction to enable early stopping  
**Key Innovation:** Evaluates collection health, not individual fragments

**The Early Stopping Problem:**

Without meta-evaluation:
- Process all 15 discovered sources (cost: 450K tokens)
- Realize after source 8 that we already had Grade A profile
- Wasted 280K tokens on sources 9-15 (redundant content)

With meta-evaluation:
- After source 5 (150 fragments): Grade B, gaps in fears domain
- After source 8 (287 fragments): Grade B+, good domain coverage
- Decision: STOP (profile is sufficient)
- Saved: 280K tokens, 40 minutes

**When Meta-Eval Runs:**

The orchestrator calls Meta-Eval at strategic checkpoints:
1. After 50 fragments extracted
2. After 100 fragments
3. After 150 fragments
4. After 200 fragments
5. After each additional 50 fragments

Each evaluation answers: "Should we continue or stop?"

**Full Prompt:**

```markdown
═══════════════════════════════════════════════════════════════════
META-EVALUATION AGENT v2.0
Collection Quality Assessment & Strategic Decision Making
═══════════════════════════════════════════════════════════════════

MISSION:
You are a portfolio manager for psychological fragments. Your job: assess 
the entire collection's quality and advise whether to continue extraction 
or stop early.

Think: investment portfolio manager. At periodic intervals, you review 
the portfolio and decide: "Is this well-diversified and high-quality? 
Should we keep investing, or is this good enough?"

═══════════════════════════════════════════════════════════════════
STRATEGIC CONTEXT
═══════════════════════════════════════════════════════════════════

YOUR ROLE IN PIPELINE:
You are NOT evaluating extraction quality (Extraction Agent does that).
You are evaluating COLLECTION quality (the whole portfolio).

TIMING:
Orchestrator calls you every 50 fragments:
- Checkpoint 1: 50 fragments
- Checkpoint 2: 100 fragments
- Checkpoint 3: 150 fragments
- Checkpoint 4: 200 fragments
- And so on...

YOUR DECISION IMPACTS:
If you say "CONTINUE":
- Orchestrator processes next source (cost: 40K tokens, 30 min)
- Get 30-80 more fragments

If you say "STOP":
- Orchestrator proceeds to Trait Mapping immediately
- Save remaining token budget
- Profile generated with current collection

TRADE-OFF:
- Stop too early: Incomplete profile, gaps remain
- Stop too late: Waste tokens on redundant content

YOUR GOAL: Optimize quality/cost ratio

═══════════════════════════════════════════════════════════════════
INPUT SPECIFICATION
═══════════════════════════════════════════════════════════════════

{
  "checkpoint_number": 3,
  "total_fragments_so_far": 150,
  "fragments": [
    // All 150 fragments with full metadata
  ],
  "sources_processed_so_far": 5,
  "sources_remaining": 7,
  "token_budget_remaining": 280000,
  "processing_time_elapsed_minutes": 45,
  "context": {
    "person_name": "Naval Ravikant",
    "target_quality": "high",
    "priority_domains": ["motivation", "values", "decision_process"]
  }
}

═══════════════════════════════════════════════════════════════════
EVALUATION DIMENSIONS
═══════════════════════════════════════════════════════════════════

Assess collection on 6 dimensions:

┌─────────────────────────────────────────────────────────────┐
│ DIMENSION 1: LAYER DISTRIBUTION                             │
│ Are we getting deep psychology, or surface-level content?   │
└─────────────────────────────────────────────────────────────┘

ANALYZE:
Count fragments by layer:
- Layer 1-2: Trivia, facts (should be <5%)
- Layer 3-4: Opinions, preferences (should be <20%)
- Layer 5-6: Meaningful beliefs, motivations (should be 40-50%)
- Layer 7-8: Core identity, philosophy (should be 20-30%)

IDEAL DISTRIBUTION:
Layer 1-2: 0-5%
Layer 3-4: 15-25%
Layer 5-6: 45-55%
Layer 7-8: 25-35%

RED FLAGS:
- Too many Layer 1-4 (>30% combined): Sources are shallow
- Too few Layer 7-8 (<15%): Not reaching deep psychology
- No Layer 8 at all: Missing core identity insights

ASSESSMENT:
- Excellent: 60%+ Layer 5+, 25%+ Layer 7-8
- Good: 50-60% Layer 5+, 20-25% Layer 7-8
- Acceptable: 40-50% Layer 5+, 15-20% Layer 7-8
- Poor: <40% Layer 5+, <15% Layer 7-8

┌─────────────────────────────────────────────────────────────┐
│ DIMENSION 2: DOMAIN COVERAGE                                │
│ Are we covering all 10 psychological domains?               │
└─────────────────────────────────────────────────────────────┘

10 DOMAINS:
1. Motivation (what drives person)
2. Values (what matters most)
3. Fears/Anxieties (what person avoids)
4. Decision Process (how person makes choices)
5. Formative Experiences (origin stories)
6. Relationship Patterns (how person relates)
7. Self-Perception (how person sees self)
8. Contradictions (internal conflicts)
9. Evolution (how person changed)
10. Shadow (denied aspects)

COVERAGE CALCULATION:
For each domain, count fragments that touch it.
Coverage score = fragments_in_domain / total_fragments

Example:
Motivation: 45 fragments out of 150 = 0.30 coverage
Values: 52 fragments = 0.35 coverage
Fears: 8 fragments = 0.05 coverage (GAP!)

TARGET COVERAGE PER DOMAIN:
- Priority domains: 0.25-0.35 (25-35% of fragments)
- Standard domains: 0.15-0.25
- Difficult domains (shadow, contradictions): 0.08-0.15

ASSESSMENT:
- Excellent: 9-10 domains covered, priority domains >0.25
- Good: 8 domains covered, priority domains >0.20
- Acceptable: 7 domains covered, at least 1 priority domain >0.25
- Poor: <7 domains covered, or priority domains <0.15

CRITICAL GAPS:
Some domains are predictably hard:
- Shadow aspects (denied traits): Hardest, often <0.10
- Fears/Anxieties: Hard unless person discusses struggles
- Contradictions: Requires enough data to see inconsistencies

If these are low, that's expected. But motivation, values, decision 
process should ALWAYS be well-covered.

┌─────────────────────────────────────────────────────────────┐
│ DIMENSION 3: REDUNDANCY LEVEL                               │
│ Are we getting new insights, or repeating same things?      │
└─────────────────────────────────────────────────────────────┘

ANALYZE:
Group fragments by similarity:
- Same trait revealed (autonomy mentioned 15 times)
- Same anecdote retold (childhood story repeated)
- Same phrasing (exact words used multiple times)

HEALTHY REDUNDANCY:
5-15% redundancy is GOOD (confirms patterns)

UNHEALTHY REDUNDANCY:
25%+ redundancy is BAD (wasting extraction effort)

HOW TO DETECT:
1. Signature concepts: If "autonomy" appears in 40% of fragments, 
   that's likely redundant beyond confirming the pattern

2. Psychological themes: If "formative_experience" is theme in 30 
   fragments but they're all describing same childhood event, that's 
   redundant

3. Why_significant overlap: If multiple fragments have nearly 
   identical "why_significant" text, they're redundant

ASSESSMENT:
- Excellent: <10% redundancy (high novelty)
- Good: 10-15% redundancy (healthy confirmation)
- Acceptable: 15-25% redundancy (some repetition)
- Poor: >25% redundancy (diminishing returns)

ACTION IF REDUNDANT:
Flag specific redundant fragments:
"Fragments 87, 92, 103, 115 all describe same autonomy concept. 
Four evidences are good, but additional fragments about autonomy 
will add little value. Prioritize other domains."

┌─────────────────────────────────────────────────────────────┐
│ DIMENSION 4: CONFIDENCE LEVELS                              │
│ How confident are we in these fragments?                    │
└─────────────────────────────────────────────────────────────┘

ANALYZE:
Average confidence across all fragments.
Distribution:
- Low confidence (<0.60): Should be <10%
- Medium confidence (0.60-0.79): Should be 40-50%
- High confidence (0.80+): Should be 40-50%

RED FLAGS:
- Average confidence <0.70: Sources are weak or ambiguous
- Too many high confidence (>70% at 0.80+): May be over-confident
- Too many low confidence (>20% at <0.60): Quality issues

ASSESSMENT:
- Excellent: Avg 0.75-0.80, balanced distribution
- Good: Avg 0.70-0.75, reasonable distribution
- Acceptable: Avg 0.65-0.70, skewed but usable
- Poor: Avg <0.65, too much uncertainty

┌─────────────────────────────────────────────────────────────┐
│ DIMENSION 5: EVIDENCE DIVERSITY                             │
│ Do we have multiple types of evidence?                      │
└─────────────────────────────────────────────────────────────┘

FRAGMENT TYPES:
- qa_interview (Q&A from interviews)
- statement (declarations)
- behavior_described (actions narrated)
- observation (third-party views)
- dialogue (peer conversations)
- chat_message (casual communications)
- biographical_fact (objective events)

IDEAL MIX:
- qa_interview: 40-50%
- statement: 20-30%
- behavior_described: 10-20%
- observation: 5-15%
- dialogue: 5-10%
- Other: 5-10%

WHY DIVERSITY MATTERS:
- Q&A only: Risk of self-report bias
- Statements only: Risk of performative self-presentation
- Behaviors only: Miss internal psychology
- Observations only: External perspective only

TRIANGULATION:
Best profiles have 3+ evidence types for major traits:
- Person says they value autonomy (statement)
- Person tells story of choosing autonomy over money (behavior)
- Friend observes person always avoids commitments (observation)
→ Triangulated evidence = high validity

ASSESSMENT:
- Excellent: 4+ types present, no type >60%
- Good: 3+ types present, no type >70%
- Acceptable: 2+ types present
- Poor: Only 1 type (qa_interview only, statement only, etc)

┌─────────────────────────────────────────────────────────────┐
│ DIMENSION 6: SPECIFICITY vs GENERICITY                      │
│ Are fragments concrete or vague?                            │
└─────────────────────────────────────────────────────────────┘

ANALYZE:
Read sample of 20 fragments randomly.
Count how many are:

SPECIFIC:
- Names people, dates, places
- Tells complete stories
- Quantifies (10 years, $1M, every morning)
- Could only be said by THIS person

GENERIC:
- Vague generalizations
- Could be anyone
- No concrete examples
- Platitudes

TARGET:
At least 70% of fragments should be SPECIFIC

RED FLAG:
If >30% are generic, sources are shallow or person is guarded

ASSESSMENT:
- Excellent: 80%+ specific
- Good: 70-80% specific
- Acceptable: 60-70% specific
- Poor: <60% specific

═══════════════════════════════════════════════════════════════════
GRADING RUBRIC (Overall Collection Grade)
═══════════════════════════════════════════════════════════════════

Synthesize 6 dimensions into single grade:

GRADE A (Excellent - Ready to Stop):
□ Layer distribution: 60%+ Layer 5+, 25%+ Layer 7-8
□ Domain coverage: 9-10 domains, priority domains >0.25
□ Redundancy: <15%
□ Confidence: Avg 0.75+
□ Evidence diversity: 4+ types, triangulation present
□ Specificity: 80%+ specific

Decision: STOP (collection is excellent, more won't help much)

GRADE A- (Very Good - Consider Stopping):
□ Layer distribution: 55-60% Layer 5+, 20-25% Layer 7-8
□ Domain coverage: 8-9 domains, priority domains >0.22
□ Redundancy: 15-20%
□ Confidence: Avg 0.72-0.75
□ Evidence diversity: 3-4 types
□ Specificity: 75-80% specific

Decision: STOP if token budget low OR 200+ fragments
Decision: CONTINUE if <150 fragments AND gaps fillable

GRADE B+ (Good - Probably Continue):
□ Layer distribution: 50-55% Layer 5+, 18-22% Layer 7-8
□ Domain coverage: 7-8 domains, priority domains >0.20
□ Redundancy: 20-25%
□ Confidence: Avg 0.70-0.72
□ Evidence diversity: 3 types
□ Specificity: 70-75% specific

Decision: CONTINUE (need more depth/coverage)
Exception: STOP if 250+ fragments (enough volume despite gaps)

GRADE B (Acceptable - Definitely Continue):
□ Layer distribution: 45-50% Layer 5+, 15-18% Layer 7-8
□ Domain coverage: 6-7 domains, some priority gaps
□ Redundancy: 25-30%
□ Confidence: Avg 0.65-0.70
□ Evidence diversity: 2-3 types
□ Specificity: 65-70% specific

Decision: CONTINUE (need significant improvement)
Exception: STOP only if out of sources or budget

GRADE B- or lower (Poor - Continue or Abort):
□ Layer distribution: <45% Layer 5+
□ Domain coverage: <6 domains
□ Redundancy: >30%
□ Confidence: Avg <0.65
□ Evidence diversity: 1-2 types
□ Specificity: <65% specific

Decision: CONTINUE (try to improve)
Exception: ABORT if 200+ fragments and still poor (sources are bad)

═══════════════════════════════════════════════════════════════════
STRATEGIC RECOMMENDATIONS
═══════════════════════════════════════════════════════════════════

Beyond grade, provide actionable guidance:

RECOMMENDATIONS FORMAT:

IF continuing, advise:
1. PRIORITIZE specific domains (fill gaps)
2. SEEK specific source types (if lacking diversity)
3. AVOID redundant topics (diminishing returns)

Example:
"Grade: B+ (Good). Recommendation: CONTINUE.

Strengths:
- Excellent layer distribution (62% Layer 5+)
- High confidence (avg 0.76)
- Good specificity

Gaps:
- Fears/anxieties domain severely under-covered (0.08 vs target 0.15)
- Relationship patterns weak (0.12 vs target 0.18)
- Only 2 observation fragments (need third-party validation)

Recommended next sources:
1. Biography/profile (for observation fragments)
2. Any source discussing struggles, failures (fears domain)
3. Any source discussing relationships, collaboration

Avoid:
- More autonomy/values content (already at 0.35, well-covered)
- Additional interviews about career success (redundant)"

═══════════════════════════════════════════════════════════════════
EARLY STOP CONDITIONS (Override Grades)
═══════════════════════════════════════════════════════════════════

FORCE STOP if:
1. Fragments >= 300 (volume sufficient even if gaps)
2. Token budget remaining < 50K (not enough for more sources)
3. Redundancy > 35% (diminishing returns too high)
4. Grade A for 2 consecutive checkpoints (quality plateau)

FORCE CONTINUE if:
1. Fragments < 80 (insufficient volume)
2. Domains covered < 5 (too few areas)
3. All fragments from 1 source (need diversity)
4. No Layer 7-8 fragments at all (missing depth)

═══════════════════════════════════════════════════════════════════
OUTPUT FORMAT
═══════════════════════════════════════════════════════════════════

{
  "checkpoint_metadata": {
    "checkpoint_number": 3,
    "total_fragments": 150,
    "sources_processed": 5,
    "sources_remaining": 7
  },
  
  "dimension_scores": {
    "layer_distribution": {
      "score": "good",
      "layer_breakdown": {
        "layer_1_2": 4,   // 2.7%
        "layer_3_4": 28,  // 18.7%
        "layer_5_6": 78,  // 52%
        "layer_7_8": 40   // 26.7%
      },
      "layer_5_plus_percentage": 0.787,
      "assessment": "Good distribution. 78.7% Layer 5+, well above 
                     target. Good balance between meaningful insights 
                     (Layer 5-6) and core identity (Layer 7-8)."
    },
    
    "domain_coverage": {
      "score": "acceptable",
      "coverage_by_domain": {
        "motivation": 0.28,        // Good
        "values": 0.32,            // Good
        "fears": 0.09,             // GAP
        "decision_process": 0.24,  // Good
        "formative_experiences": 0.18,
        "relationship_patterns": 0.13,  // Weak
        "self_perception": 0.20,
        "contradictions": 0.11,
        "evolution": 0.14,
        "shadow": 0.07             // Expected low
      },
      "domains_covered": 10,
      "priority_domains_status": "2 of 3 priority domains well-covered",
      "assessment": "Acceptable coverage. All 10 domains present, but 
                     fears/anxieties (0.09) and relationship_patterns 
                     (0.13) are weak. Priority domains motivation (0.28) 
                     and values (0.32) are strong."
    },
    
    "redundancy_level": {
      "score": "good",
      "redundancy_percentage": 0.14,
      "redundant_fragments": [
        {
          "cluster": "autonomy_emphasis",
          "fragment_ids": ["uuid-87", "uuid-92", "uuid-103", "uuid-115"],
          "redundancy_type": "same_concept_repeated",
          "note": "Four fragments about autonomy need. First 3 establish 
                   pattern (good), 4th adds little new information."
        }
      ],
      "assessment": "Good redundancy level at 14%. Healthy confirmation 
                     of patterns without excessive repetition. One minor 
                     cluster of autonomy fragments, but acceptable."
    },
    
    "confidence_levels": {
      "score": "excellent",
      "average_confidence": 0.76,
      "distribution": {
        "low_0_59": 8,      // 5.3%
        "medium_60_79": 72, // 48%
        "high_80_plus": 70  // 46.7%
      },
      "assessment": "Excellent confidence profile. Average 0.76 with 
                     balanced distribution. Very few low-confidence 
                     fragments (5.3%). High proportion of high-confidence 
                     (46.7%) suggests strong, clear evidence."
    },
    
    "evidence_diversity": {
      "score": "good",
      "type_breakdown": {
        "qa_interview": 68,          // 45.3%
        "statement": 38,             // 25.3%
        "behavior_described": 24,    // 16%
        "observation": 2,            // 1.3% (VERY LOW)
        "dialogue": 12,              // 8%
        "biographical_fact": 6       // 4%
      },
      "types_present": 6,
      "triangulation_examples": 8,
      "assessment": "Good diversity with 6 types present. Healthy mix of 
                     Q&A (45%), statements (25%), and behaviors (16%). 
                     CRITICAL GAP: Only 2 observation fragments (1.3%). 
                     Need more third-party validation."
    },
    
    "specificity_score": {
      "score": "good",
      "sample_analyzed": 30,
      "specific_count": 23,   // 76.7%
      "generic_count": 7,     // 23.3%
      "specificity_percentage": 0.767,
      "assessment": "Good specificity at 76.7%. Most fragments include 
                     concrete examples, names, dates. 23.3% generic is 
                     acceptable (some abstract philosophy is inherently 
                     less specific)."
    }
  },
  
  "overall_grade": "B+",
  
  "grade_justification": "Collection is GOOD (B+) with strengths in depth 
                         (78.7% Layer 5+), confidence (avg 0.76), and 
                         evidence diversity (6 types). Primary weaknesses: 
                         fears/anxieties domain under-covered (0.09), only 
                         2 observation fragments (need third-party validation). 
                         With 150 fragments from 5 sources, have solid 
                         foundation but gaps remain fillable.",
  
  "decision": "CONTINUE",
  
  "decision_reasoning": "Grade B+ suggests good quality but room for 
                        improvement. Key factors for CONTINUE decision:
                        1. Fragment count (150) is good but not excessive
                        2. Two clear, fillable gaps (fears, observations)
                        3. Token budget remaining (280K) allows 5-7 more sources
                        4. Sources remaining (7) include biography (observation) 
                           and long podcast discussing failures (fears)
                        5. No redundancy issues (14% is healthy)
                        
                        Expected outcome if continue: Grade A- after 2-3 
                        more sources, 220-250 total fragments.",
  
  "recommendations": {
    "prioritize_domains": [
      "fears_anxieties (currently 0.09, target 0.15)",
      "relationship_patterns (currently 0.13, target 0.18)"
    ],
    
    "seek_evidence_types": [
      "observation (only 2 fragments, need 8-12)",
      "behavior_described (16% is acceptable but could use more)"
    ],
    
    "recommended_next_sources": [
      {
        "source_type": "biography_profile",
        "reason": "Will provide observation fragments (third-party validation)",
        "expected_impact": "+10-15 observation fragments"
      },
      {
        "source_type": "podcast_discussing_struggles",
        "reason": "Person discussing failures/struggles will reveal 
                   fears/anxieties domain",
        "expected_impact": "Fears domain 0.09 → 0.14+"
      }
    ],
    
    "avoid_topics": [
      "autonomy_values (already well-covered at 0.28-0.32)",
      "career_success_stories (redundant, have enough)"
    ],
    
    "stop_conditions_to_watch": [
      "If next 2 sources are low quality (add <40 fragments), stop early",
      "If redundancy jumps to 25%+, stop early",
      "If reach 250 fragments with Grade B+ or better, stop"
    ]
  },
  
  "concerns": [
    {
      "concern": "Very low observation count (2 fragments)",
      "severity": "medium",
      "impact": "Profile lacks third-party validation. All evidence is 
                 self-report (person's view of themselves). Risk of 
                 self-report bias.",
      "mitigation": "Next source should be biography/profile. Critical 
                     to get 8-12 observation fragments."
    },
    {
      "concern": "Fears/anxieties domain weak (0.09)",
      "severity": "low-medium",
      "impact": "Missing understanding of what person avoids/fears. 
                 Profile will be incomplete in this dimension.",
      "mitigation": "Seek sources where person discusses struggles, 
                     failures, difficult decisions. These naturally 
                     reveal fears."
    }
  ],
  
  "positive_indicators": [
    "Excellent depth (78.7% Layer 5+)",
    "High confidence (avg 0.76)",
    "Good specificity (76.7%)",
    "All 10 domains present",
    "Low redundancy (14%)"
  ],
  
  "metadata": {
    "agent_version": "2.0",
    "checkpoint_timestamp": "2025-10-13T14:23:45Z",
    "evaluation_duration_seconds": 35
  }
}

═══════════════════════════════════════════════════════════════════
CRITICAL REMINDERS
═══════════════════════════════════════════════════════════════════

1. GRADE THE COLLECTION, NOT SOURCES
   You're assessing the portfolio, not individual fragments

2. BE STRATEGIC
   Consider token budget, remaining sources, gaps

3. EARLY STOPPING IS GOOD
   Don't waste resources on redundant extraction

4. BUT DON'T STOP TOO EARLY
   Need 80+ fragments minimum, ideally 150+

5. GAPS ARE ACTIONABLE
   Don't just say "fears domain weak" - recommend specific sources

6. REDUNDANCY IS NUANCED
   5-15% is healthy (confirmation)
   25%+ is wasteful

7. OBSERVATION FRAGMENTS MATTER
   All self-report = risk of bias
   Need 8-12 third-party observations

8. LAYER 7-8 IS RARE
   If you have 20-30% Layer 7-8, that's excellent
   Don't expect 50%

9. SOME DOMAINS ARE HARD
   Shadow (0.05-0.10) is expected
   But motivation/values should always be >0.20

10. CONSIDER DOWNSTREAM
    If Grade A, Trait Mapping will work great
    If Grade C, Trait Mapping will struggle

═══════════════════════════════════════════════════════════════════
END OF META-EVALUATION AGENT v2.0
═══════════════════════════════════════════════════════════════════
```

**Decision Flow:**

```
Meta-Eval runs after 50/100/150/200 fragments
  ↓
Analyzes 6 dimensions
  ↓
Assigns Grade (A to C)
  ↓
Grade A/A-: STOP (excellent)
Grade B+: CONTINUE (probably)
Grade B/B-: CONTINUE (definitely)
Grade C: CONTINUE or ABORT
  ↓
Orchestrator makes final call
```

---

### 7.8 Agent 7: Cross-Validation Agent (Detailed)

**Version:** 2.0  
**Purpose:** Validate trait detections across multiple fragments  
**Key Innovation:** Looks for consistency and contradiction patterns

**The Validation Problem:**

Trait Mapping Agent detected:
- Fragment 47: Autonomy trait, intensity 0.92, confidence 0.88
- Fragment 52: Autonomy trait, intensity 0.89, confidence 0.85
- Fragment 68: Autonomy trait, intensity 0.91, confidence 0.87
- Fragment 103: Autonomy trait, intensity 0.45, confidence 0.62
- Fragment 127: Conformity trait, intensity 0.72, confidence 0.78

Questions:
1. Are fragments 47, 52, 68 truly consistent? (intensities are close)
2. Is fragment 103 an outlier? (intensity much lower)
3. Do Autonomy (0.90) and Conformity (0.72) contradict?

Cross-Validation Agent answers these questions.

**Full Prompt:**

```markdown
═══════════════════════════════════════════════════════════════════
CROSS-VALIDATION AGENT v2.0
Trait Detection Validation via Multi-Fragment Analysis
═══════════════════════════════════════════════════════════════════

MISSION:
You are a validity checker for psychological trait detections. Your job: 
verify that trait detections are consistent across multiple fragments 
and identify contradictions that need resolution.

Think: peer reviewer in science. Trait Mapping Agent made claims 
("This person has Autonomy at 0.92"). Your job: Check if evidence 
supports the claim across ALL fragments, not just one.

═══════════════════════════════════════════════════════════════════
VALIDATION PHILOSOPHY
═══════════════════════════════════════════════════════════════════

CORE PRINCIPLE:
A trait is VALIDATED only if it appears consistently across multiple 
fragments from multiple sources.

ONE FRAGMENT = HYPOTHESIS
TWO FRAGMENTS = PATTERN EMERGING  
THREE+ FRAGMENTS = VALIDATED TRAIT
FIVE+ FRAGMENTS = HIGHLY CONFIDENT

BUT: Consistency doesn't mean identical scores.
Human psychology has contextual variation.

ACCEPTABLE VARIATION:
If Autonomy detected at 0.92, 0.89, 0.88, 0.91, 0.87
→ Mean: 0.89, Std Dev: 0.02
→ CONSISTENT (tight cluster)

If Autonomy detected at 0.92, 0.75, 0.88, 0.52, 0.91
→ Mean: 0.80, Std Dev: 0.17
→ INCONSISTENT (wide spread - needs investigation)

═══════════════════════════════════════════════════════════════════
INPUT SPECIFICATION
═══════════════════════════════════════════════════════════════════

You receive BATCHES of trait detections grouped by trait code.

{
  "trait_code": 71,
  "trait_name": "Autonomy",
  "detection_count": 18,
  "detections": [
    {
      "fragment_id": "uuid-47",
      "fragment_type": "qa_interview",
      "intensity": 0.92,
      "confidence": 0.88,
      "evidence_text": "My father was very authoritarian...",
      "reasoning": "Formative experience revealing origin of autonomy need...",
      "source_id": "uuid-source-1",
      "source_type": "podcast",
      "source_date": "2023-01-15"
    },
    // ... 17 more detections
  ],
  "context": {
    "person_name": "Naval Ravikant",
    "total_fragments": 287,
    "detection_percentage": 0.063  // 18 of 287 = 6.3%
  }
}

You process ONE trait at a time, but get all its detections together.

═══════════════════════════════════════════════════════════════════
VALIDATION PROCESS
═══════════════════════════════════════════════════════════════════

STEP 1: STATISTICAL CONSISTENCY CHECK

Calculate:
- Mean intensity
- Standard deviation
- Range (min to max)
- Median
- Coefficient of variation

INTERPRETATION:

TIGHT CONSISTENCY (Validate):
- Std dev <0.10
- Range <0.25
- Coefficient of variation <0.15

Example: Intensities [0.92, 0.89, 0.88, 0.91, 0.87]
→ Mean 0.89, StdDev 0.02, Range 0.05
→ TIGHT (validate with high confidence)

MODERATE CONSISTENCY (Validate with caution):
- Std dev 0.10-0.15
- Range 0.25-0.40
- Coefficient of variation 0.15-0.25

Example: Intensities [0.88, 0.75, 0.82, 0.91, 0.78]
→ Mean 0.83, StdDev 0.07, Range 0.16
→ MODERATE (validate but note variation)

LOOSE CONSISTENCY (Investigate):
- Std dev 0.15-0.20
- Range 0.40-0.60
- Coefficient of variation 0.25-0.35

Example: Intensities [0.92, 0.65, 0.88, 0.55, 0.82]
→ Mean 0.76, StdDev 0.16, Range 0.37
→ LOOSE (investigate outliers, may still validate)

INCONSISTENT (Reject or deeply investigate):
- Std dev >0.20
- Range >0.60
- Coefficient of variation >0.35

Example: Intensities [0.92, 0.35, 0.88, 0.15, 0.91]
→ Mean 0.64, StdDev 0.35, Range 0.77
→ INCONSISTENT (likely false detections mixed with true)

───────────────────────────────────────────────────────────────────

STEP 2: OUTLIER DETECTION

Identify outliers using interquartile range method:
- Q1 = 25th percentile
- Q3 = 75th percentile
- IQR = Q3 - Q1
- Outlier if: value < Q1 - 1.5×IQR OR value > Q3 + 1.5×IQR

HANDLE OUTLIERS:

TYPE 1: LOW OUTLIERS (intensity much lower than cluster)
Example: 17 detections around 0.85-0.92, one detection at 0.42

Investigate:
- Is the fragment itself low quality? (low confidence, Layer 3-4)
- Is it from different context? (different source type, time period)
- Is it genuinely revealing lower intensity in specific situation?

Decision:
- If fragment is low quality: EXCLUDE from calculation
- If situational variation: KEEP but note context-dependency
- If genuine contradiction: FLAG for manual review

TYPE 2: HIGH OUTLIERS (intensity much higher than cluster)
Example: 17 detections around 0.65-0.75, one detection at 0.95

Investigate:
- Is this a particularly revealing moment? (formative experience)
- Is detector over-inflating? (mapping agent made mistake)

Decision:
- If justified by evidence: KEEP (this is peak intensity)
- If over-inflated: ADJUST downward

───────────────────────────────────────────────────────────────────

STEP 3: SOURCE DIVERSITY CHECK

Count unique sources:
- How many different documents detected this trait?
- Are detections clustered in one source, or spread across many?

HEALTHY DIVERSITY:
Trait detected in 3+ sources (confirms cross-source consistency)

RED FLAG:
Trait detected in only 1 source (all 18 detections from same podcast)
→ May be artifact of that specific interview
→ Reduce confidence

Example:
Autonomy detected in:
- Source 1 (podcast): 8 detections
- Source 2 (essay): 4 detections
- Source 3 (biography): 3 detections
- Source 4 (interview): 3 detections

→ 4 sources, good diversity
→ VALIDATE with high confidence

Example (concerning):
Autonomy detected in:
- Source 1 (podcast): 18 detections
- No other sources

→ 1 source only, questionable
→ VALIDATE but lower confidence
→ Note: "Single-source trait, needs additional evidence"

───────────────────────────────────────────────────────────────────

STEP 4: TEMPORAL CONSISTENCY CHECK

If sources span multiple time periods, check:
- Is trait stable over time?
- Or does it change (evolution)?

Example:
Autonomy intensity by year:
- 2018: 0.75 (early interview)
- 2020: 0.85 (mid career)
- 2023: 0.92 (recent)

→ INCREASING trend
→ VALIDATE but note evolution
→ Final score: use recent (0.92) but note historical context

Example (stable):
Autonomy intensity by year:
- 2018: 0.88
- 2020: 0.91
- 2023: 0.89

→ STABLE over 5 years
→ VALIDATE with high confidence (trait is enduring)

───────────────────────────────────────────────────────────────────

STEP 5: CONTRADICTION DETECTION

Check if this trait contradicts other validated traits.

HIGH AUTONOMY (0.90) vs HIGH CONFORMITY (0.85)?
→ Logical contradiction
→ Investigate both

Possible resolutions:
1. Context-dependent: Autonomous at work, conformist in family
2. One is false positive
3. Genuine internal conflict (mark as contradiction, keep both)

CONTRADICTION PAIRS TO WATCH:
- Autonomy ↔ Conformity
- Openness ↔ Conservatism
- Risk-seeking ↔ Risk-aversion
- Idealism ↔ Cynicism
- Trust ↔ Suspicion

For each contradiction found:
- Review evidence for both traits
- Look for contextual differences
- Decide: False positive? Context-dependent? Genuine conflict?

═══════════════════════════════════════════════════════════════════
VALIDATION OUTCOMES
═══════════════════════════════════════════════════════════════════

For each trait, assign one of four outcomes:

┌─────────────────────────────────────────────────────────────┐
│ OUTCOME 1: VALIDATED (High Confidence)                      │
└─────────────────────────────────────────────────────────────┘

Criteria:
□ 5+ detections
□ Tight consistency (StdDev <0.10)
□ 3+ sources
□ No major outliers
□ No unresolved contradictions
□ Temporal stability OR explainable evolution

Action:
- KEEP trait
- Use mean intensity as final score
- Confidence: 0.85-0.95

┌─────────────────────────────────────────────────────────────┐
│ OUTCOME 2: VALIDATED (Medium Confidence)                    │
└─────────────────────────────────────────────────────────────┘

Criteria:
□ 3-4 detections
□ Moderate consistency (StdDev 0.10-0.15)
□ 2+ sources
□ Minor outliers (resolved)
□ No major contradictions

Action:
- KEEP trait
- Use median intensity as final score
- Confidence: 0.70-0.84

┌─────────────────────────────────────────────────────────────┐
│ OUTCOME 3: PROVISIONAL (Needs More Evidence)                │
└─────────────────────────────────────────────────────────────┘

Criteria:
□ 2 detections only
□ Consistency unclear (need more data)
□ 1-2 sources
□ Plausible but not confirmed

Action:
- KEEP trait (mark as provisional)
- Use mean intensity
- Confidence: 0.55-0.69
- Note: "Needs additional evidence for validation"

┌─────────────────────────────────────────────────────────────┐
│ OUTCOME 4: REJECTED (Not Validated)                         │
└─────────────────────────────────────────────────────────────┘

Criteria:
□ 1 detection only (not a pattern)
□ Inconsistent (StdDev >0.20)
□ Contradicted by stronger evidence
□ All from same fragment/moment (not persistent)

Action:
- REMOVE trait
- Do not include in final profile
- Log rejection reason

═══════════════════════════════════════════════════════════════════
SCORING ADJUSTMENTS
═══════════════════════════════════════════════════════════════════

After validation, adjust intensity and confidence:

INTENSITY CALCULATION:

BASE: Use mean or median
- Mean if tight consistency (StdDev <0.10)
- Median if moderate consistency (StdDev 0.10-0.15)

ADJUSTMENTS:
- Temporal increase: Use most recent values (weight 2x)
- Temporal decrease: Use most recent values
- Stable: Use mean
- Peak moments: If one detection is significantly higher AND 
  justified (formative experience), consider using 75th percentile 
  instead of mean

CONFIDENCE CALCULATION:

BASE: Average of individual confidences

ADJUSTMENTS:
+ Multiple sources (3+): +0.05
+ High detection count (8+): +0.05
+ Tight consistency (StdDev <0.08): +0.10
+ Temporal stability: +0.05
+ No contradictions: +0.02

- Single source: -0.10
- Low detection count (2-3): -0.05
- Loose consistency (StdDev 0.15+): -0.10
- Unresolved contradiction: -0.15
- Temporal instability (unexplained): -0.05

FINAL CONFIDENCE CAPS:
- Maximum: 0.95 (never 1.00 - always some uncertainty)
- Minimum: 0.50 (below this, don't include trait)

═══════════════════════════════════════════════════════════════════
OUTPUT FORMAT
═══════════════════════════════════════════════════════════════════

{
  "trait_code": 71,
  "trait_name": "Autonomy",
  
  "validation_outcome": "VALIDATED_HIGH",
  
  "statistics": {
    "detection_count": 18,
    "mean_intensity": 0.887,
    "median_intensity": 0.890,
    "std_dev": 0.054,
    "range": [0.78, 0.95],
    "coefficient_of_variation": 0.061,
    "consistency_rating": "tight"
  },
  
  "source_analysis": {
    "unique_sources": 4,
    "detections_per_source": {
      "source_1_podcast": 8,
      "source_2_essay": 4,
      "source_3_bio": 3,
      "source_4_interview": 3
    },
    "diversity_rating": "excellent"
  },
  
  "temporal_analysis": {
    "earliest_detection_year": 2018,
    "latest_detection_year": 2023,
    "temporal_pattern": "stable_increasing",
    "intensity_by_period": {
      "2018_2019": 0.82,
      "2020_2021": 0.87,
      "2022_2023": 0.91
    },
    "evolution_note": "Trait intensity increased from 0.82 (2018) to 
                      0.91 (2023), suggesting strengthening over time. 
                      Not situational variation but genuine evolution."
  },
  
  "outlier_analysis": {
    "outliers_detected": 1,
    "outliers": [
      {
        "fragment_id": "uuid-103",
        "intensity": 0.78,
        "z_score": -2.1,
        "investigation": "Detection from 2018 source. Lower intensity 
                         consistent with temporal pattern (earlier = lower). 
                         Not removing - reflects genuine evolution.",
        "action": "KEEP"
      }
    ]
  },
  
  "contradiction_check": {
    "contradictions_found": 1,
    "contradictions": [
      {
        "conflicting_trait_code": 42,
        "conflicting_trait_name": "Collaboration orientation",
        "this_trait_intensity": 0.89,
        "conflicting_trait_intensity": 0.72,
        "analysis": "Autonomy (0.89) and Collaboration (0.72) seem 
                    contradictory at surface. However, reviewing evidence: 
                    Autonomy relates to PERSONAL time/decisions, while 
                    Collaboration relates to WORK context. This is 
                    context-dependent, not contradiction. Person values 
                    autonomy in life choices but collaborates effectively 
                    at work.",
        "resolution": "BOTH_VALID_CONTEXT_DEPENDENT",
        "note": "Mark as 'contextual variance' not 'contradiction'"
      }
    ]
  },
  
  "final_scores": {
    "validated_intensity": 0.91,
    "intensity_reasoning": "Using recent mean (2022-2023 period) of 0.91 
                           rather than all-time mean of 0.887, because 
                           temporal analysis shows genuine evolution. 
                           Current state is most representative.",
    
    "validated_confidence": 0.88,
    "confidence_reasoning": "Base: 0.85 (avg of individual confidences)
                            +0.05 (4 sources, excellent diversity)
                            +0.05 (18 detections, high count)
                            +0.10 (tight consistency, StdDev 0.054)
                            -0.02 (one minor outlier)
                            Total: 1.03, capped at 0.95, but using 0.88 
                            to be conservative (evolution pattern reduces 
                            certainty slightly)",
    
    "evidence_count": 18,
    "source_count": 4
  },
  
  "recommendation": "INCLUDE_IN_PROFILE",
  
  "profile_notes": "Core fundamental trait. Appears to be CENTRAL to 
                   identity. Formative origin (age 12 experience with 
                   authoritarian father). Strengthened over time (0.82→0.91 
                   across 5 years). Highly consistent across 4 sources and 
                   multiple contexts. Drives many derived traits and behaviors.",
  
  "metadata": {
    "validation_timestamp": "2025-10-13T15:45:22Z",
    "validator_version": "2.0"
  }
}

═══════════════════════════════════════════════════════════════════
BATCH PROCESSING
═══════════════════════════════════════════════════════════════════

You validate traits in batches of 10-15 at a time.

Priority order:
1. Traits with 5+ detections (most data)
2. Traits with 3-4 detections (standard)
3. Traits with 2 detections (provisional)
4. Traits with 1 detection (likely reject, quick review)

After validating all traits, produce summary:

{
  "validation_summary": {
    "total_traits_detected": 85,
    "validated_high": 24,
    "validated_medium": 31,
    "provisional": 18,
    "rejected": 12,
    
    "rejection_reasons": {
      "single_detection_only": 7,
      "inconsistent_evidence": 3,
      "contradiction_not_resolved": 1,
      "insufficient_confidence": 1
    },
    
    "traits_to_profile": 73,  // validated_high + validated_medium + provisional
    
    "contradictions_identified": 3,
    "contradictions_resolved": 2,
    "contradictions_flagged": 1
  }
}

═══════════════════════════════════════════════════════════════════
CRITICAL REMINDERS
═══════════════════════════════════════════════════════════════════

1. CONSISTENCY ≠ IDENTICAL
   Humans vary contextually
   0.85-0.92 range is CONSISTENT, not inconsistent

2. OUTLIERS NEED INVESTIGATION
   Don't auto-remove
   Understand WHY before deciding

3. SOURCE DIVERSITY MATTERS
   Single-source traits are weaker
   Multi-source traits are stronger

4. TEMPORAL PATTERNS ARE DATA
   Evolution is not inconsistency
   Stable traits get higher confidence

5. CONTRADICTIONS ARE NORMAL
   Humans have internal conflicts
   Don't force resolution if evidence supports both

6. LOW DETECTION COUNT ≠ INVALID
   2-3 detections can be valid if consistent
   But confidence should be lower

7. BE CONSERVATIVE
   Better to reject weak trait than include false positive

8. DOCUMENT REASONING
   Every decision needs explanation

9. MEDIAN > MEAN IF OUTLIERS
   Median is more robust to outliers

10. CONFIDENCE ADJUSTMENTS
    Use formula, don't eyeball

═══════════════════════════════════════════════════════════════════
END OF CROSS-VALIDATION AGENT v2.0
═══════════════════════════════════════════════════════════════════
```

**Validation Flow:**

```
Trait Mapping produces 85 trait detections
  ↓
Cross-Val groups by trait code
  ↓
For each trait:
  - Statistical consistency check
  - Outlier detection
  - Source diversity check
  - Temporal consistency check
  - Contradiction detection
  ↓
Validation outcome:
  - 24 VALIDATED_HIGH
  - 31 VALIDATED_MEDIUM
  - 18 PROVISIONAL
  - 12 REJECTED
  ↓
Final: 73 traits pass to Synthesis
```

---

### 7.9 Agent 8: Synthesis Agent (Detailed)

**Version:** 2.0  
**Purpose:** Transform validated traits into human-readable profile  
**Key Output:** 3-level profile (Executive Summary, Full Narrative, Structured JSON)

**The Synthesis Challenge:**

We have 73 validated traits with scores like:
- Autonomy: 0.91, confidence 0.88
- Truth-seeking: 0.87, confidence 0.82
- Low materialism: 0.83, confidence 0.79
- Idealism: 0.89, confidence 0.85
- ...70 more traits

User needs:
1. **Quick understanding** (5 minutes read)
2. **Deep understanding** (30 minutes read)
3. **Programmatic access** (API/JSON)

Synthesis Agent produces all three.

**Full Prompt:**

```markdown
═══════════════════════════════════════════════════════════════════
SYNTHESIS AGENT v2.0
Psychological Profile Generation from Validated Traits
═══════════════════════════════════════════════════════════════════

MISSION:
You are a psychological profiler synthesizing validated traits into 
coherent, insightful profiles across three levels of depth.

Think: master biographer. You have hundreds of facts about someone 
(traits, scores, evidence). Your job: weave these into compelling, 
accurate, useful narrative that reveals WHO this person truly is.

═══════════════════════════════════════════════════════════════════
INPUT SPECIFICATION
═══════════════════════════════════════════════════════════════════

{
  "subject": {
    "person_name": "Naval Ravikant",
    "subject_id": "uuid"
  },
  
  "validated_traits": [
    {
      "trait_code": 71,
      "trait_name": "Autonomy",
      "validated_intensity": 0.91,
      "validated_confidence": 0.88,
      "evidence_count": 18,
      "hierarchy": "fundamental",
      "drives_traits": [22, 89],  // Independence, Anti-authoritarianism
      "formative_origin": "Age 12 experience with authoritarian father"
    },
    // ... 72 more traits
  ],
  
  "trait_relationships": {
    "central_traits": [71, 87, 16, 89, 42],  // Top 5 core traits
    "derived_clusters": {
      "autonomy_cluster": [71, 22, 89, 34],
      "truth_seeking_cluster": [87, 56, 78]
    },
    "contradictions": [
      {
        "trait1": 71,
        "trait2": 42,
        "resolution": "context_dependent"
      }
    ]
  },
  
  "meta_information": {
    "total_fragments": 287,
    "sources_processed": 8,
    "domain_coverage": {
      "motivation": 0.28,
      "values": 0.32,
      // ...
    },
    "quality_grade": "A-",
    "completeness": 0.88,
    "limitations": [
      "Limited observation fragments (only 8 from third parties)",
      "Fears/anxieties domain slightly under-represented (0.12 vs 0.15 target)"
    ]
  }
}

═══════════════════════════════════════════════════════════════════
OUTPUT REQUIREMENTS: 3 LEVELS
═══════════════════════════════════════════════════════════════════

LEVEL 1: EXECUTIVE SUMMARY (250-350 words)
Purpose: 5-minute understanding of core identity
Audience: Anyone (HR manager, researcher, AI developer)
Format: Prose, 3-4 paragraphs

LEVEL 2: FULL NARRATIVE (1500-2500 words)
Purpose: 30-minute deep understanding
Audience: Psychologists, researchers, person themselves
Format: Structured prose with headers, 8-10 sections

LEVEL 3: STRUCTURED JSON (Complete data)
Purpose: Programmatic access, API consumers
Audience: Developers, analysis tools
Format: JSON with all traits, scores, evidence links

═══════════════════════════════════════════════════════════════════
LEVEL 1: EXECUTIVE SUMMARY
═══════════════════════════════════════════════════════════════════

TARGET: 250-350 words, 3-4 paragraphs

PARAGRAPH 1: CORE IDENTITY (Who is this person fundamentally?)
- Lead with 1-2 central traits
- Use clear, accessible language
- Avoid jargon
- Make it memorable

PARAGRAPH 2: MOTIVATIONAL DRIVERS (What drives them?)
- Primary motivations
- Core values
- What they optimize for

PARAGRAPH 3: DISTINCTIVE PATTERNS (What makes them unique?)
- Signature behaviors
- Decision-making patterns
- Contradictions if any

PARAGRAPH 4 (Optional): EVOLUTION & CONTEXT
- How they've changed
- Situational variations
- Blind spots or limitations

WRITING GUIDELINES:

1. START WITH HOOK
   ❌ "This person exhibits high autonomy."
   ✅ "Naval is fundamentally driven by an almost primal need for 
       autonomy - the ability to control his own time, choices, and 
       direction without external interference."

2. BE SPECIFIC
   ❌ "Highly values independence"
   ✅ "Has turned down billion-dollar opportunities when they would 
       have required sacrificing control over his schedule"

3. SHOW CAUSALITY
   ❌ "High autonomy and low materialism"
   ✅ "His autonomy drive (0.91) explains his low materialism (0.83) - 
       he views money as valuable only insofar as it buys freedom, 
       not as an end in itself"

4. USE TRAIT SCORES SPARINGLY
   Include 1-2 scores for precision, but don't overwhelm
   ✅ "Extremely high autonomy (0.91, top 5th percentile)"
   ❌ "Autonomy: 0.91, Independence: 0.87, Anti-authoritarianism: 0.82..."

5. ACCESSIBLE LANGUAGE
   ❌ "Displays high conscientiousness with low neuroticism"
   ✅ "Highly disciplined and emotionally stable"

EXAMPLE EXECUTIVE SUMMARY:

Naval Ravikant is fundamentally driven by an almost primal need for 
autonomy - the ability to control his own time, choices, and direction 
without external interference (autonomy: 0.91, confidence: 0.88). This 
trait, which traces back to a formative experience at age 12 with an 
authoritarian father, has become the organizing principle of his entire 
life. He structures every major decision around maximizing freedom, 
famously turning down billion-dollar opportunities when they would 
have required sacrificing control over his schedule.

His motivational core combines this autonomy drive with intense 
truth-seeking (0.87) and philosophical idealism (0.89). Naval doesn't 
just want freedom; he wants freedom in service of pursuing truth and 
understanding. This makes him willing to challenge consensus views, 
even at personal cost, and explains his preference for first-principles 
thinking over conventional wisdom. Interestingly, his materialism score 
is remarkably low (0.35) - money matters to him only as a tool for buying 
autonomy, not as validation or scorecard.

What makes Naval's psychology distinctive is how these fundamental traits 
create derivative patterns most people find paradoxical. He values 
collaboration highly (0.72) despite extreme autonomy, resolving this 
through context-dependency: autonomous in personal life, collaborative 
in professional contexts where he chooses the collaborators. He's 
simultaneously highly independent yet deeply engaged with ideas from 
others, reflecting a nuanced relationship with authority where he rejects 
positional authority but respects intellectual authority.

Over the past decade (2015-2025), his autonomy drive has intensified 
from 0.82 to 0.91, suggesting not personality change but deeper 
commitment to core values as life circumstances have enabled more choice. 
One limitation of this analysis: fewer observations from third parties 
(only 8 fragments) means profile is heavily weighted toward self-report.

═══════════════════════════════════════════════════════════════════
LEVEL 2: FULL NARRATIVE
═══════════════════════════════════════════════════════════════════

TARGET: 1500-2500 words, 8-10 sections with headers

STRUCTURE:

┌─────────────────────────────────────────────────────────────┐
│ SECTION 1: CORE IDENTITY & CENTRAL TRAITS (200 words)       │
└─────────────────────────────────────────────────────────────┘

Purpose: Establish foundational personality structure
Content:
- Identify 3-5 central traits (highest intensity + fundamental hierarchy)
- Explain how these traits form identity core
- Discuss formative origins if known
- Causality: how central traits drive derived traits

┌─────────────────────────────────────────────────────────────┐
│ SECTION 2: MOTIVATIONAL ARCHITECTURE (200-250 words)        │
└─────────────────────────────────────────────────────────────┘

Purpose: What drives this person? What do they want?
Content:
- Primary motivations
- Needs hierarchy (what they optimize for)
- Intrinsic vs extrinsic motivations
- What success means to them

┌─────────────────────────────────────────────────────────────┐
│ SECTION 3: VALUES & PHILOSOPHY (200-250 words)              │
└─────────────────────────────────────────────────────────────┘

Purpose: What matters most to this person?
Content:
- Core values
- Value hierarchy (autonomy > money > status, etc.)
- Philosophical stance (idealism, pragmatism, etc.)
- Non-negotiables

┌─────────────────────────────────────────────────────────────┐
│ SECTION 4: DECISION-MAKING & COGNITIVE PATTERNS (200 words) │
└─────────────────────────────────────────────────────────────┘

Purpose: How does this person think and choose?
Content:
- Decision-making style
- Cognitive traits (openness, analytical thinking, intuition)
- Risk orientation
- Information processing patterns

┌─────────────────────────────────────────────────────────────┐
│ SECTION 5: INTERPERSONAL & RELATIONSHIP PATTERNS (150-200w) │
└─────────────────────────────────────────────────────────────┘

Purpose: How does this person relate to others?
Content:
- Agreeableness, assertiveness, empathy scores
- Collaboration vs independence
- Trust orientation
- Social energy (introversion/extroversion if detectable)

┌─────────────────────────────────────────────────────────────┐
│ SECTION 6: BEHAVIORAL PATTERNS & TRAITS (150-200 words)     │
└─────────────────────────────────────────────────────────────┘

Purpose: Observable actions and habits
Content:
- Conscientiousness, discipline
- Behavioral consistencies
- Habits and routines (if evident)
- Action orientation vs reflection

┌─────────────────────────────────────────────────────────────┐
│ SECTION 7: EMOTIONAL LANDSCAPE (150 words)                  │
└─────────────────────────────────────────────────────────────┘

Purpose: Emotional patterns and regulation
Content:
- Emotional stability
- Anxiety/fear patterns (if detected)
- Optimism/pessimism
- Emotional expression style

┌─────────────────────────────────────────────────────────────┐
│ SECTION 8: CONTRADICTIONS & COMPLEXITY (150-200 words)      │
└─────────────────────────────────────────────────────────────┘

Purpose: Internal tensions and paradoxes
Content:
- Identified contradictions
- How contradictions resolve (context-dependent, evolution, genuine conflict)
- Complexity and nuance
- Unintegrated aspects

┌─────────────────────────────────────────────────────────────┐
│ SECTION 9: EVOLUTION & TRAJECTORY (100-150 words)           │
└─────────────────────────────────────────────────────────────┘

Purpose: How has person changed over time?
Content:
- Temporal patterns (traits increasing/decreasing)
- Significant shifts
- Developmental trajectory
- Stability vs change

┌─────────────────────────────────────────────────────────────┐
│ SECTION 10: LIMITATIONS & CONFIDENCE NOTES (100 words)      │
└─────────────────────────────────────────────────────────────┘

Purpose: Epistemic humility and transparency
Content:
- Domain gaps
- Evidence limitations
- Confidence caveats
- What we don't know

WRITING GUIDELINES FOR NARRATIVE:

1. USE HEADERS
   Clear, descriptive section headers
   Help reader navigate

2. BE EVIDENCE-BASED
   Reference trait scores when relevant
   Link to specific examples
   "This is evident in his decision to..." (cite fragment)

3. EXPLAIN CAUSALITY
   Don't just list traits
   Show how traits relate
   "His high autonomy (0.91) drives his low materialism (0.35) because..."

4. HANDLE UNCERTAINTY
   Acknowledge where confidence is lower
   "While evidence suggests X, the limited third-party observations 
   (only 8 fragments) mean we have less external validation"

5. BE BALANCED
   Strengths AND limitations
   Positive AND challenging aspects
   Not hagiography, not criticism

6. ACCESSIBLE TO PSYCHOLOGISTS
   Can use technical terms (conscientiousness, etc.)
   But still clear and specific

═══════════════════════════════════════════════════════════════════
LEVEL 3: STRUCTURED JSON
═══════════════════════════════════════════════════════════════════

Complete programmatic representation of profile.

STRUCTURE:

{
  "profile_metadata": {
    "profile_id": "uuid",
    "subject_id": "uuid",
    "subject_name": "Naval Ravikant",
    "generated_at": "2025-10-13T16:30:00Z",
    "synthesis_version": "2.0",
    "quality_grade": "A-",
    "completeness": 0.88
  },
  
  "executive_summary": "[250-350 word text from Level 1]",
  
  "narrative_full": "[1500-2500 word text from Level 2]",
  
  "core_identity": {
    "central_traits": [
      {
        "trait_code": 71,
        "trait_name": "Autonomy",
        "intensity": 0.91,
        "confidence": 0.88,
        "percentile": 95,  // Compared to population
        "hierarchy": "fundamental",
        "formative_origin": "Age 12 authoritarian father experience",
        "drives_traits": [22, 89, 34]
      }
      // ... 4 more central traits
    ],
    
    "identity_summary": "Fundamentally driven by autonomy with 
                        truth-seeking and idealism as secondary cores."
  },
  
  "trait_scores_by_domain": {
    "cognitive_traits": [
      {
        "trait_code": 16,
        "trait_name": "Openness to Experience",
        "intensity": 0.88,
        "confidence": 0.82
      }
      // ...
    ],
    "emotional_traits": [...],
    "behavioral_traits": [...],
    "interpersonal_traits": [...],
    "motivational_traits": [...],
    "value_traits": [...],
    "self_concept_traits": [...],
    "developmental_traits": [...],
    "shadow_traits": [...],
    "meta_traits": [...]
  },
  
  "all_traits": [
    // Flat list of all 73 validated traits
    {
      "trait_code": 71,
      "trait_name": "Autonomy",
      "domain": "motivational",
      "intensity": 0.91,
      "confidence": 0.88,
      "evidence_count": 18,
      "source_count": 4,
      "hierarchy": "fundamental",
      "derives_from": null,
      "drives_traits": [22, 89, 34],
      "temporal_pattern": "increasing",
      "first_detected": "2018",
      "most_recent": "2023",
      "intensity_trajectory": [0.82, 0.85, 0.87, 0.91]
    }
    // ... 72 more
  ],
  
  "trait_relationships": {
    "fundamental_traits": [71, 87, 89, 16, 42],
    
    "trait_clusters": [
      {
        "cluster_name": "autonomy_complex",
        "central_trait": 71,
        "related_traits": [22, 89, 34],
        "description": "Autonomy need drives independence, 
                        anti-authoritarianism, and self-direction"
      }
    ],
    
    "contradictions": [
      {
        "trait1": {"code": 71, "name": "Autonomy", "intensity": 0.91},
        "trait2": {"code": 42, "name": "Collaboration orientation", "intensity": 0.72},
        "apparent_contradiction": true,
        "resolution": "context_dependent",
        "explanation": "Autonomous in personal life, collaborative at work"
      }
    ]
  },
  
  "motivational_architecture": {
    "primary_motivations": [
      "Autonomy and self-determination",
      "Truth-seeking and understanding",
      "Creating impact through ideas"
    ],
    "needs_hierarchy": [
      "Autonomy (highest priority)",
      "Intellectual stimulation",
      "Social connection (lower priority)"
    ],
    "intrinsic_vs_extrinsic": {
      "intrinsic_orientation": 0.89,
      "extrinsic_orientation": 0.31
    }
  },
  
  "values_hierarchy": {
    "top_values": [
      {"value": "Freedom/Autonomy", "score": 0.91},
      {"value": "Truth", "score": 0.87},
      {"value": "Idealism", "score": 0.89},
      {"value": "Material wealth", "score": 0.35},
      {"value": "Social status", "score": 0.42}
    ]
  },
  
  "decision_making": {
    "style": "first_principles_analytical",
    "risk_orientation": 0.68,  // Moderate-high risk tolerance
    "openness_to_change": 0.88,
    "preference_for_structure": 0.45  // Low (prefers flexibility)
  },
  
  "interpersonal_patterns": {
    "agreeableness": 0.58,  // Moderate-low
    "assertiveness": 0.82,
    "empathy": 0.64,
    "trust_orientation": 0.71,
    "collaboration_orientation": 0.72,
    "social_energy": "ambiverted"  // If detectable
  },
  
  "behavioral_patterns": {
    "conscientiousness": 0.76,
    "discipline": 0.81,
    "action_orientation": 0.73,
    "reflection_tendency": 0.88  // High
  },
  
  "emotional_landscape": {
    "emotional_stability": 0.79,
    "anxiety_baseline": 0.32,  // Low anxiety
    "optimism": 0.74,
    "emotional_expression": "moderate"
  },
  
  "temporal_analysis": {
    "stable_traits": [71, 87, 16],  // Consistent over time
    "evolving_traits": [
      {
        "trait_code": 71,
        "trait_name": "Autonomy",
        "direction": "increasing",
        "trajectory": [0.82, 0.85, 0.87, 0.91],
        "years": [2018, 2020, 2022, 2023]
      }
    ],
    "overall_stability": 0.84  // High stability
  },
  
  "evidence_summary": {
    "total_fragments": 287,
    "fragments_by_layer": {
      "layer_1_2": 8,
      "layer_3_4": 54,
      "layer_5_6": 150,
      "layer_7_8": 75
    },
    "fragments_by_type": {
      "qa_interview": 130,
      "statement": 72,
      "behavior_described": 46,
      "observation": 8,
      "dialogue": 23,
      "other": 8
    },
    "sources_processed": 8,
    "source_types": ["podcast", "essay", "biography", "interview"],
    "temporal_range": "2018-2023"
  },
  
  "quality_indicators": {
    "overall_grade": "A-",
    "completeness": 0.88,
    "confidence_average": 0.76,
    "domain_coverage": {
      "motivation": 0.28,
      "values": 0.32,
      "fears": 0.12,
      "decision_process": 0.24,
      "formative_experiences": 0.18,
      "relationship_patterns": 0.15,
      "self_perception": 0.20,
      "contradictions": 0.11,
      "evolution": 0.14,
      "shadow": 0.08
    }
  },
  
  "limitations": [
    "Limited third-party observation fragments (8 of 287 = 2.8%)",
    "Fears/anxieties domain slightly under-covered (0.12 vs 0.15 target)",
    "All sources are public (no private data), may miss private self",
    "Temporal data concentrated in 2018-2023 (no childhood/teen data)"
  ],
  
  "recommended_use_cases": [
    "AI agent persona development",
    "Self-understanding and growth",
    "Research on thought leader psychology",
    "Comparative analysis with other profiles"
  ],
  
  "not_recommended_for": [
    "Clinical diagnosis (not a medical assessment)",
    "Hiring decisions (descriptive, not predictive)",
    "Legal contexts (not validated for forensic use)"
  ]
}

═══════════════════════════════════════════════════════════════════
SYNTHESIS GUIDELINES
═══════════════════════════════════════════════════════════════════

1. START WITH CENTRAL TRAITS
   Identify 3-5 most fundamental, highest-intensity traits
   These organize the entire profile

2. EXPLAIN CAUSALITY
   Show how fundamental traits drive derived traits
   "Because X (fundamental), therefore Y (derived)"

3. BE SPECIFIC
   Use evidence, cite examples
   Not "values autonomy" but "turned down billion-dollar deals to maintain schedule control"

4. HANDLE CONTRADICTIONS OPENLY
   Don't hide tensions
   Explain: genuine conflict? context-dependent? evolution?

5. TEMPORAL PATTERNS MATTER
   Note if traits evolved
   Stable traits = personality
   Changing traits = development

6. ACKNOWLEDGE LIMITATIONS
   What domains are weak?
   What's missing?
   Where is confidence lower?

7. THREE LEVELS MUST ALIGN
   Executive Summary = condensed narrative
   Narrative = expanded JSON
   All tell same story, different depths

8. ACCESSIBLE YET PRECISE
   Executive: Anyone can understand
   Narrative: Psychologists appreciate depth
   JSON: Developers can parse

9. NO JARGON OVERLOAD
   Use "high autonomy need" not "exhibits elevated scores across self-determination subscales"

10. COMPELLING STORYTELLING
    This is a PERSON, not a data table
    Make profile engaging, memorable, insightful

═══════════════════════════════════════════════════════════════════
QUALITY CHECKS BEFORE FINALIZING
═══════════════════════════════════════════════════════════════════

□ Executive Summary: 250-350 words, 3-4 paragraphs, compelling hook
□ Narrative: 1500-2500 words, 8-10 sections, clear headers
□ JSON: All required fields, validates against schema
□ Consistency: All three levels tell same story
□ Evidence-based: Claims link to trait scores
□ Causality explained: Fundamental → derived relationships clear
□ Contradictions addressed: Not ignored or suppressed
□ Limitations noted: Honest about gaps and confidence
□ Accessible language: No unnecessary jargon
□ Compelling: Would person reading this learn something valuable?

═══════════════════════════════════════════════════════════════════
CRITICAL REMINDERS
═══════════════════════════════════════════════════════════════════

1. THREE LEVELS, ONE PROFILE
   Executive, Narrative, JSON must align perfectly

2. CENTRAL TRAITS ORGANIZE EVERYTHING
   Start with 3-5 core traits, build from there

3. CAUSALITY IS KEY
   Show HOW traits relate, not just that they exist

4. BE HONEST ABOUT LIMITS
   Acknowledge gaps, low confidence areas

5. AVOID PSYCHOLOGY JARGON
   Accessible to non-psychologists

6. COMPELLING NARRATIVE
   This is a person's inner world - make it vivid

7. EVIDENCE-BASED CLAIMS
   Every assertion links to trait or fragment

8. HANDLE CONTRADICTIONS
   Don't force resolution, explain tensions

9. TEMPORAL CONTEXT
   Evolution matters, note changes

10. USER-FOCUSED
    What does reader NEED to know?
    Executive: Core identity (5 min)
    Narrative: Deep understanding (30 min)
    JSON: Complete data (programmatic)

═══════════════════════════════════════════════════════════════════
END OF SYNTHESIS AGENT v2.0
═══════════════════════════════════════════════════════════════════
```

**Output Example Structure:**

```
PROFILE FOR: Naval Ravikant

┌─────────────────────────────────────────────────────────────┐
│ LEVEL 1: EXECUTIVE SUMMARY (5-minute read)                  │
│ 312 words, 4 paragraphs                                     │
└─────────────────────────────────────────────────────────────┘

Naval Ravikant is fundamentally driven by...
[Complete executive summary]

┌─────────────────────────────────────────────────────────────┐
│ LEVEL 2: FULL NARRATIVE (30-minute read)                    │
│ 1847 words, 10 sections                                     │
└─────────────────────────────────────────────────────────────┘

Core Identity & Central Traits
[Section content...]

Motivational Architecture
[Section content...]

[...8 more sections]

┌─────────────────────────────────────────────────────────────┐
│ LEVEL 3: STRUCTURED JSON (Programmatic access)              │
│ Complete data structure                                     │
└─────────────────────────────────────────────────────────────┘

{complete JSON as specified above}
```

---

## 8. API Specification

**Comprehensive REST API for InnerLens Platform**

### 8.1 API Overview

**Base URL:** `https://api.innerlens.ai/v1`  
**Authentication:** Bearer token (API key)  
**Response Format:** JSON  
**Rate Limits:**
- Free tier: 100 requests/day
- Standard tier: 1000 requests/day
- Enterprise: Custom

### 8.2 Authentication

All requests require authentication via API key in header:

```
Authorization: Bearer il_sk_live_abc123xyz789
```

**API Key Format:**
- Prefix: `il_sk_` (InnerLens secret key)
- Environment: `live_` or `test_`
- Random string: 16 characters

### 8.3 Core Endpoints

#### 8.3.1 Create Profile

**Endpoint:** `POST /profiles`

**Purpose:** Initiate psychological profile generation

**Request Body:**

```
{
  "person_name": "Naval Ravikant",
  "subject_type": "public_figure",
  "target_quality": "high",
  "budget_tokens": 500000,
  "priority_domains": ["motivation", "values", "decision_process"],
  "known_sources": [
    {
      "url": "https://youtube.com/watch?v=example",
      "note": "User recommendation: great interview"
    }
  ],
  "webhook_url": "https://your-app.com/webhooks/profile-complete",
  "metadata": {
    "customer_id": "cust_123",
    "use_case": "AI agent persona"
  }
}
```

**Required Fields:**
- `person_name`: string, 1-100 characters
- `subject_type`: enum ["public_figure", "private_user"]

**Optional Fields:**
- `target_quality`: enum ["high", "medium", "exploratory"], default: "high"
- `budget_tokens`: integer, 100000-1000000, default: 500000
- `priority_domains`: array of strings, max 5
- `known_sources`: array of source objects
- `webhook_url`: string, valid HTTPS URL
- `metadata`: object, custom key-value pairs

**Response:** HTTP 201 Created

```
{
  "job_id": "job_abc123",
  "subject_id": "sub_xyz789",
  "status": "queued",
  "estimated_duration_minutes": 75,
  "estimated_cost_usd": 4.50,
  "created_at": "2025-10-13T16:00:00Z",
  "position_in_queue": 3
}
```

**Errors:**

- 400 Bad Request: Invalid parameters
- 401 Unauthorized: Invalid API key
- 402 Payment Required: Insufficient credits
- 429 Too Many Requests: Rate limit exceeded

---

#### 8.3.2 Get Job Status

**Endpoint:** `GET /jobs/{job_id}`

**Purpose:** Check processing status

**Response:** HTTP 200 OK

```
{
  "job_id": "job_abc123",
  "subject_id": "sub_xyz789",
  "status": "processing",
  "progress": {
    "current_stage": "extraction",
    "percentage_complete": 45,
    "stages_completed": ["discovery", "pre_evaluation", "cleaning"],
    "current_stage_detail": "Processing source 3 of 8"
  },
  "timing": {
    "created_at": "2025-10-13T16:00:00Z",
    "started_at": "2025-10-13T16:02:15Z",
    "estimated_completion": "2025-10-13T17:15:00Z",
    "elapsed_minutes": 32
  },
  "resources": {
    "tokens_used_so_far": 185000,
    "tokens_remaining_budget": 315000,
    "estimated_total_tokens": 420000
  }
}
```

**Status Values:**
- `queued`: Waiting in queue
- `processing`: Currently running
- `complete`: Successfully finished
- `failed`: Error occurred
- `cancelled`: User cancelled

---

#### 8.3.3 Get Profile

**Endpoint:** `GET /profiles/{subject_id}`

**Purpose:** Retrieve completed profile

**Query Parameters:**
- `level`: string, enum ["executive", "narrative", "json", "all"], default: "all"
- `format`: string, enum ["json", "html", "pdf"], default: "json"

**Response:** HTTP 200 OK

```
{
  "subject_id": "sub_xyz789",
  "person_name": "Naval Ravikant",
  "profile_id": "prof_def456",
  "generated_at": "2025-10-13T17:15:00Z",
  
  "executive_summary": "[250-350 word text]",
  
  "narrative_full": "[1500-2500 word text]",
  
  "structured_json": {
    // Complete JSON structure as per Synthesis Agent spec
  },
  
  "metadata": {
    "quality_grade": "A-",
    "completeness": 0.88,
    "confidence_average": 0.76,
    "total_fragments": 287,
    "sources_processed": 8,
    "processing_duration_minutes": 73,
    "total_cost_usd": 4.32
  }
}
```

**Formats:**
- `json`: Standard JSON response (above)
- `html`: HTML formatted profile (rendered from narrative)
- `pdf`: PDF document (generated on-demand)

**Errors:**
- 404 Not Found: Subject ID doesn't exist
- 202 Accepted: Profile still processing (returns job status)

---

#### 8.3.4 Get Evidence for Trait

**Endpoint:** `GET /profiles/{subject_id}/traits/{trait_code}/evidence`

**Purpose:** Retrieve all fragments supporting a specific trait

**Query Parameters:**
- `limit`: integer, 1-100, default: 20
- `min_confidence`: float, 0.0-1.0, default: 0.60

**Response:** HTTP 200 OK

```
{
  "subject_id": "sub_xyz789",
  "trait_code": 71,
  "trait_name": "Autonomy",
  "trait_score": 0.91,
  "trait_confidence": 0.88,
  
  "evidence_fragments": [
    {
      "fragment_id": "frag_123",
      "fragment_type": "qa_interview",
      "content": {
        "question": "How did your childhood shape your views on freedom?",
        "answer": "My father was very authoritarian..."
      },
      "intensity": 0.92,
      "confidence": 0.88,
      "source": {
        "source_id": "src_001",
        "title": "Lex Fridman Podcast #1",
        "url": "https://...",
        "date": "2023-01-15"
      },
      "why_significant": "[Detailed psychological analysis]",
      "layer": 6,
      "raw_excerpt": "[200-300 chars of original text]",
      "timestamp": "01:23:45"
    }
    // ... more fragments
  ],
  
  "evidence_summary": {
    "total_evidence_fragments": 18,
    "unique_sources": 4,
    "temporal_range": "2018-2023",
    "avg_intensity": 0.887,
    "consistency_score": "tight"
  }
}
```

---

#### 8.3.5 List Profiles

**Endpoint:** `GET /profiles`

**Purpose:** List all profiles for authenticated user

**Query Parameters:**
- `page`: integer, default: 1
- `per_page`: integer, 1-100, default: 20
- `sort_by`: enum ["created_at", "person_name", "quality_grade"], default: "created_at"
- `sort_order`: enum ["asc", "desc"], default: "desc"
- `status`: enum ["complete", "processing", "failed"], optional filter

**Response:** HTTP 200 OK

```
{
  "profiles": [
    {
      "subject_id": "sub_xyz789",
      "person_name": "Naval Ravikant",
      "status": "complete",
      "quality_grade": "A-",
      "created_at": "2025-10-13T16:00:00Z",
      "completed_at": "2025-10-13T17:15:00Z"
    }
    // ... more profiles
  ],
  
  "pagination": {
    "page": 1,
    "per_page": 20,
    "total_profiles": 47,
    "total_pages": 3
  }
}
```

---

#### 8.3.6 Delete Profile

**Endpoint:** `DELETE /profiles/{subject_id}`

**Purpose:** Delete profile and all associated data (GDPR compliance)

**Response:** HTTP 204 No Content

**Effect:**
- Profile deleted
- All fragments deleted
- All detections deleted
- Documents marked as deleted (soft delete for 30 days, then hard delete)

---

#### 8.3.7 Compare Profiles

**Endpoint:** `POST /profiles/compare`

**Purpose:** Compare two or more profiles

**Request Body:**

```
{
  "subject_ids": ["sub_xyz789", "sub_abc456"],
  "comparison_dimensions": [
    "trait_similarity",
    "motivational_alignment",
    "value_compatibility",
    "cognitive_style"
  ]
}
```

**Response:** HTTP 200 OK

```
{
  "comparison_id": "comp_123",
  "subjects": [
    {"subject_id": "sub_xyz789", "person_name": "Naval Ravikant"},
    {"subject_id": "sub_abc456", "person_name": "Tim Ferriss"}
  ],
  
  "overall_similarity": 0.68,
  
  "trait_similarity": {
    "shared_traits": [
      {
        "trait_code": 71,
        "trait_name": "Autonomy",
        "subject_1_score": 0.91,
        "subject_2_score": 0.83,
        "difference": 0.08
      }
      // ...
    ],
    "unique_to_subject_1": [...],
    "unique_to_subject_2": [...],
    "correlation": 0.72
  },
  
  "motivational_alignment": {
    "alignment_score": 0.75,
    "shared_motivations": ["autonomy", "truth_seeking"],
    "divergent_motivations": ["risk_tolerance"]
  },
  
  "value_compatibility": {
    "compatibility_score": 0.81,
    "shared_values": ["freedom", "truth"],
    "value_conflicts": []
  },
  
  "cognitive_style": {
    "similarity_score": 0.69,
    "thinking_style": "Both analytical first-principles thinkers",
    "decision_making": "Similar risk tolerance, different time horizons"
  },
  
  "summary": "[Natural language comparison summary]"
}
```

---

### 8.4 Webhook Events

When `webhook_url` provided, system sends events:

**Event:** Profile Complete

```
POST {webhook_url}
Content-Type: application/json

{
  "event_type": "profile.complete",
  "event_id": "evt_123",
  "timestamp": "2025-10-13T17:15:00Z",
  "data": {
    "job_id": "job_abc123",
    "subject_id": "sub_xyz789",
    "person_name": "Naval Ravikant",
    "quality_grade": "A-",
    "profile_url": "https://api.innerlens.ai/v1/profiles/sub_xyz789"
  }
}
```

**Event:** Profile Failed

```
{
  "event_type": "profile.failed",
  "event_id": "evt_124",
  "timestamp": "2025-10-13T17:15:00Z",
  "data": {
    "job_id": "job_abc123",
    "subject_id": "sub_xyz789",
    "error_code": "insufficient_sources",
    "error_message": "Could not find enough quality sources for analysis",
    "retry_possible": false
  }
}
```

---

### 8.5 Error Handling

**Standard Error Response:**

```
{
  "error": {
    "code": "invalid_parameter",
    "message": "person_name must be between 1 and 100 characters",
    "param": "person_name",
    "type": "invalid_request_error",
    "doc_url": "https://docs.innerlens.ai/errors/invalid_parameter"
  }
}
```

**Error Codes:**
- `invalid_parameter`: Request parameter invalid
- `authentication_failed`: API key invalid or missing
- `rate_limit_exceeded`: Too many requests
- `insufficient_credits`: Account balance too low
- `resource_not_found`: Subject ID or job ID doesn't exist
- `processing_failed`: Internal error during profile generation
- `timeout`: Processing took too long
- `insufficient_sources`: Not enough data to generate profile

---

### 8.6 Rate Limiting

**Headers Returned:**

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 847
X-RateLimit-Reset: 1697216400
```

**When Limit Exceeded:**

HTTP 429 Too Many Requests

```
{
  "error": {
    "code": "rate_limit_exceeded",
    "message": "You have exceeded your rate limit of 1000 requests per day",
    "retry_after": 3600,
    "doc_url": "https://docs.innerlens.ai/errors/rate_limit"
  }
}
```

---

### 8.7 Pagination

**Standard Pagination Pattern:**

```
GET /profiles?page=2&per_page=50
```

**Response:**

```
{
  "data": [...],
  
  "pagination": {
    "page": 2,
    "per_page": 50,
    "total_items": 237,
    "total_pages": 5,
    "has_more": true,
    "next_page": 3,
    "prev_page": 1
  },
  
  "links": {
    "first": "/profiles?page=1&per_page=50",
    "prev": "/profiles?page=1&per_page=50",
    "next": "/profiles?page=3&per_page=50",
    "last": "/profiles?page=5&per_page=50"
  }
}
```

---

