# Module 2 Optimization Plan: AI Sales Machine
## Marketing IA ROI Optimization Course

**Date:** December 3, 2025
**Status:** Implementation Ready
**Target:** 6 lessons, 72-90 min total (12-15 min each)

---

## EXECUTIVE SUMMARY

### Problem Statement

**Current State:**
- 20+ existing scripts with wildly inconsistent lengths (114-2,958 words)
- New scripts TOO LONG (2,075 words = 18+ min, violating microlearning)
- No clear Bloom's Taxonomy progression
- Unclear mapping between 9 available workflows and lesson structure
- curriculum.yaml requires 6 lessons, but content is fragmented across 20+ files

**Impact:**
- Students overwhelmed by excessive content
- Microlearning violated (>15 min lessons)
- Poor pedagogical structure (no clear skill progression)
- Inefficient use of available workflows

### Recommended Solution

**6-Lesson Structure:**
1. **Lesson 2.1:** AI Sales Machine Overview + Setup (APPLY - 12 min)
2. **Lesson 2.2:** Google Maps Lead Generation (APPLY - 13 min)
3. **Lesson 2.3:** LinkedIn + Apollo Enrichment (ANALYZE - 14 min)
4. **Lesson 2.4:** Lead Scoring + Qualification (ANALYZE - 13 min)
5. **Lesson 2.5:** Multi-Channel Sequences (EVALUATE - 12 min)
6. **Lesson 2.6:** Dashboard + Optimization (CREATE - 14 min)

**Total Duration:** 78 minutes (within 72-90 min target)

**Key Changes:**
- Consolidate 20+ scripts into 6 optimized lessons
- Cut 40-60% of redundant/theoretical content
- Map each lesson to specific n8n workflow
- Apply Bloom's Taxonomy progression (Apply → Analyze → Evaluate → Create)
- Enforce strict word count limits (1,200-1,500 words = 12-15 min)

---

## PART 1: OPTIMAL MODULE 2 STRUCTURE

### Lesson 2.1: AI Sales Machine Overview + Setup
**Duration:** 12 min (1,200 words)
**Bloom Level:** APPLY
**Workflow:** `track-pipedrive-deals-in-google-sheets-for-sales-pipeline-reporting.json`

**Learning Objective:**
Understand the complete AI Sales Machine architecture (Prospector → SDR → Closer) and set up basic pipeline tracking.

**Why This First:**
- Provides system overview before diving into specific components
- Simplest workflow (Pipedrive → Google Sheets sync)
- Builds confidence with immediate visual results
- Sets foundation for understanding 3-role architecture

**Content Focus:**
- [00:00-01:00] Hook: R$ 58k/month turnaround case study
- [01:00-03:00] 3-Role Architecture: Prospector, SDR, Closer
- [03:00-08:00] Demo: Basic pipeline tracking workflow
- [08:00-11:00] ROI: Cost savings vs manual team (R$ 24k → R$ 6k)
- [11:00-12:00] Next steps: Setting up lead sources

---

### Lesson 2.2: Google Maps Lead Generation
**Duration:** 13 min (1,300 words)
**Bloom Level:** APPLY
**Workflow:** `scrape-&-enrich-google-maps-leads-with-decodo-api-and-gemini-2.5-flash.json`

**Learning Objective:**
Implement automated local business prospecting using Google Maps + AI enrichment.

**Why This Second:**
- Builds on Lesson 2.1 (now adding lead sources)
- Local prospecting = high volume, easier to understand
- Visual results (Google Maps interface familiar)
- Perfect for B2C and local B2B

**Content Focus:**
- [00:00-01:00] Hook: 1,800 agencies vs 500 on LinkedIn
- [01:00-03:00] Why Google Maps (B2C, local, volume)
- [03:00-08:00] Demo: Outscraper + n8n + Gemini enrichment
- [08:00-11:00] Filtering strategies (rating, reviews, website)
- [11:00-13:00] ROI: 800 leads/month at R$ 200 cost

---

### Lesson 2.3: LinkedIn + Apollo Enrichment
**Duration:** 14 min (1,400 words)
**Bloom Level:** ANALYZE
**Workflows:**
- `lead-generation-automate-on-linkedin-personalisation-enrichment.json`
- `automate-cold-outreach-with-apollo,-linkedin-&-gmail-using-gpt-4.json`

**Learning Objective:**
Analyze and enrich B2B leads using LinkedIn data + Apollo API, understanding data quality differences.

**Why This Third:**
- Transitions from local (Lesson 2.2) to B2B prospecting
- Introduces data enrichment concept (not just scraping)
- Requires understanding API integrations (more complex)
- Bloom progression: Apply → Analyze (comparing data sources)

**Content Focus:**
- [00:00-01:00] Hook: 15-20% LinkedIn reply rate vs 2-5% email
- [01:00-03:00] LinkedIn vs Email comparison + why B2B prefers LinkedIn
- [03:00-08:00] Demo: Phantom Buster + Apollo enrichment flow
- [08:00-11:00] Data quality analysis (email accuracy, tech stack, funding)
- [11:00-14:00] ROI: 500 LinkedIn leads + 95% email accuracy

---

### Lesson 2.4: Lead Scoring + Qualification
**Duration:** 13 min (1,300 words)
**Bloom Level:** ANALYZE
**Workflow:** Custom (extends Lesson 2.3 workflow with GPT-4 scoring)

**Learning Objective:**
Analyze lead quality using multi-dimensional scoring (Fit + Intent + Timing + Behavior).

**Why This Fourth:**
- Now have 1,300 leads (Google Maps 800 + LinkedIn 500)
- Need prioritization system (can't contact all at once)
- Introduces AI decision-making (GPT-4 scoring)
- Deepens Bloom ANALYZE: comparing leads, identifying patterns

**Content Focus:**
- [00:00-01:00] Hook: 1,500 leads but which 100 to contact first?
- [01:00-03:00] 4-Dimension Scoring: Fit + Intent + Timing + Behavior
- [03:00-08:00] Demo: GPT-4 scoring workflow in n8n
- [08:00-11:00] Routing logic: High score → human, low → AI
- [11:00-13:00] ROI: 3x conversion rate by prioritizing right leads

---

### Lesson 2.5: Multi-Channel Sequences
**Duration:** 12 min (1,200 words)
**Bloom Level:** EVALUATE
**Workflows:**
- `personalized-email-outreach-with-linkedin-and-crunchbase-data-and-gemini-ai-review.json`
- Custom multi-channel logic

**Learning Objective:**
Evaluate and design optimal outreach sequences across email, LinkedIn, and WhatsApp.

**Why This Fifth:**
- Have leads (Lessons 2.2-2.3), have scoring (Lesson 2.4)
- Now need outreach strategy
- Bloom EVALUATE: comparing channels, choosing optimal approach
- Teaches A/B testing and optimization thinking

**Content Focus:**
- [00:00-01:00] Hook: Single channel = 5% response, multi-channel = 20%
- [01:00-03:00] Channel comparison: Email vs LinkedIn vs WhatsApp
- [03:00-08:00] Demo: 4-touch sequence (Day 0, 3, 7, 14)
- [08:00-11:00] Personalization using Gemini AI + Crunchbase data
- [11:00-12:00] ROI: 4x response rate vs single-channel

---

### Lesson 2.6: Dashboard + Continuous Optimization
**Duration:** 14 min (1,400 words)
**Bloom Level:** CREATE
**Workflow:** `track-pipedrive-deals-in-google-sheets-for-sales-pipeline-reporting.json` (extended)

**Learning Objective:**
Create real-time ROI dashboard tracking CAC, conversion rates, and system performance.

**Why This Sixth (Final):**
- Complete system now operational (Lessons 2.1-2.5)
- Need measurement and optimization
- Bloom CREATE: building custom dashboard, defining own metrics
- Closes loop: Implement → Measure → Optimize

**Content Focus:**
- [00:00-01:00] Hook: "You can't improve what you don't measure"
- [01:00-03:00] Key metrics: CAC, conversion rate, response rate, ROI
- [03:00-08:00] Demo: Building Google Sheets dashboard
- [08:00-11:00] A/B testing strategies for continuous improvement
- [11:00-14:00] ROI: Month-over-month optimization (20% improvement)

---

## PART 2: CONTENT OPTIMIZATION STRATEGIES

### Word Count Analysis (Current State)

| Script | Current Words | Status | Target |
|--------|--------------|--------|---------|
| 2.1 Sales Machine | 2,958 | TOO LONG | 1,200 |
| 2.3 Google Maps | 1,020 | PERFECT | 1,300 |
| 2.12 LinkedIn | 1,834 | GOOD | 1,400 |
| 2.13 WhatsApp | 1,748 | GOOD | (merge into 2.5) |
| 2.14 Follow-up | 2,396 | TOO LONG | (merge into 2.5) |
| 2.19 Closer | 533 | TOO SHORT | (merge into 2.6) |
| 2.20 Proposta | 2,003 | LONG | (merge into 2.6) |

### Optimization Actions Per Lesson

#### Lesson 2.1: AI Sales Machine Overview + Setup

**Source Material:**
- Primary: `2.1-ROTEIRO-TELEPROMPTER-sales-machine.md` (2,958 words)
- Supporting: `2.1-ai-sales-machine-completa.md`

**Optimization Strategy:**

**Current Issues:**
- [x] Too long (2,958 words → needs 60% cut)
- [ ] Too much detail on all 3 roles (should be overview only)
- [ ] Multiple ROI calculations (redundant)
- [ ] Too many examples (confusing for Lesson 1)

**Actions:**
1. **CUT 60% (1,758 words):**
   - Remove detailed Prospector section (moves to Lessons 2.2-2.3)
   - Remove detailed SDR section (moves to Lesson 2.4)
   - Remove detailed Closer section (moves to Lesson 2.6)
   - Keep ONLY architecture overview + basic setup
   - Remove 2.11-2.20 template mentions (too much detail)

2. **KEEP (1,200 words):**
   - Hook: R$ 58k turnaround story (100 words)
   - 3-Role Architecture diagram (200 words)
   - Basic Pipedrive → Google Sheets workflow demo (500 words)
   - ROI comparison table (200 words)
   - Next steps preview (200 words)

3. **ADD:**
   - Clear "What you'll build in Module 2" roadmap
   - Link to curriculum (Lessons 2.2-2.6 preview)

**Target Length:** 1,200 words (12 min)

**Bloom Level:** APPLY (set up basic tracking)

---

#### Lesson 2.2: Google Maps Lead Generation

**Source Material:**
- Primary: `2.3-ROTEIRO-TELEPROMPTER-prospeccao-google-maps.md` (1,020 words) ✅ EXCELLENT!
- Workflow: `scrape-&-enrich-google-maps-leads-with-decodo-api-and-gemini-2.5-flash.json`

**Optimization Strategy:**

**Current Issues:**
- [ ] Slightly short (needs +280 words)
- [ ] Missing AI enrichment step (only shows Outscraper)
- [ ] No Gemini integration (workflow has it)

**Actions:**
1. **KEEP 100% of existing script** (1,020 words - great structure!)
   - Hook is perfect
   - Demo flow is clear
   - ROI calculation specific

2. **ADD 280 words:**
   - [06:00-07:30] Gemini enrichment step (after Outscraper extraction)
     - Why enrich? (Google Maps missing emails)
     - How Gemini analyzes company data
     - Example: Company description → ICP fit score
   - [10:30-11:30] Combined ROI (Outscraper + Gemini)

3. **MERGE with:**
   - Workflow #7 (Decodo + Gemini) - already aligned!

**Target Length:** 1,300 words (13 min)

**Bloom Level:** APPLY (implement workflow)

---

#### Lesson 2.3: LinkedIn + Apollo Enrichment

**Source Material:**
- Primary: `2.12-ROTEIRO-TELEPROMPTER-linkedin-outreach-completo.md` (1,834 words)
- Supporting: `2.4-ROTEIRO-TELEPROMPTER-linkedin-phantom.md` (532 words)
- Supporting: `2.5-ROTEIRO-TELEPROMPTER-apollo.md` (359 words)
- Workflows: LinkedIn enrichment + Apollo cold outreach

**Optimization Strategy:**

**Current Issues:**
- [x] 2.12 too long (1,834 words → needs 23% cut)
- [x] Focuses only on LinkedIn (needs Apollo integration)
- [x] Missing data quality comparison (LinkedIn vs Apollo)
- [ ] Three separate scripts need merging

**Actions:**
1. **CUT 434 words from 2.12:**
   - Remove redundant "why LinkedIn" section (covered in hook)
   - Consolidate 4-touch sequence examples (too detailed for this lesson)
   - Remove Phantom Buster pricing details (link to docs instead)
   - Reduce template examples (2 instead of 5)

2. **ADD Apollo section (from 2.5):**
   - [08:00-10:00] Apollo enrichment demo
   - Data quality comparison table
   - When to use LinkedIn vs Apollo

3. **MERGE:**
   - 70% from 2.12 (LinkedIn extraction)
   - 30% from 2.5 (Apollo enrichment)
   - Result: Unified LinkedIn → Apollo → n8n flow

**Target Length:** 1,400 words (14 min)

**Bloom Level:** ANALYZE (compare data sources, understand quality)

---

#### Lesson 2.4: Lead Scoring + Qualification

**Source Material:**
- Primary: `2.6-lead-scoring-inteligente.md` (full lesson file)
- Supporting: `2.6-ROTEIRO-TELEPROMPTER-lead-scoring.md` (493 words) - TOO SHORT
- Workflow: Extend Lesson 2.3 workflow with GPT-4 scoring node

**Optimization Strategy:**

**Current Issues:**
- [x] Teleprompter script TOO SHORT (493 words → needs +807 words)
- [ ] Full lesson file exists but not in teleprompter format
- [ ] Missing visual examples of scoring in action
- [ ] No routing logic (high score → human, low → AI)

**Actions:**
1. **CONVERT full lesson to teleprompter format:**
   - Use structure from `2.6-lead-scoring-inteligente.md`
   - Adapt to 15-min video format
   - Add screencast timestamps

2. **ADD missing content:**
   - [00:00-01:00] Hook: "1,500 leads, which 100 first?"
   - [06:00-08:00] Live GPT-4 scoring demo (show 3 real leads scored)
   - [10:00-11:00] Routing logic n8n node
   - [11:00-13:00] ROI: 3x conversion from prioritization

3. **STRUCTURE:**
   - Fit Score (0-40) - 3 min
   - Intent Score (0-30) - 2 min
   - Timing + Behavior (0-30) - 2 min
   - GPT-4 implementation - 3 min
   - Routing + ROI - 3 min

**Target Length:** 1,300 words (13 min)

**Bloom Level:** ANALYZE (lead analysis, pattern recognition)

---

#### Lesson 2.5: Multi-Channel Sequences

**Source Material:**
- Primary: `2.7-sequencias-multi-canal.md` (full lesson)
- Supporting: `2.13-ROTEIRO-TELEPROMPTER-whatsapp-completo.md` (1,748 words)
- Supporting: `2.14-ROTEIRO-TELEPROMPTER-follow-up-inteligente-completo.md` (2,396 words)
- Workflow: `personalized-email-outreach-with-linkedin-and-crunchbase-data-and-gemini-ai-review.json`

**Optimization Strategy:**

**Current Issues:**
- [x] Three separate scripts totaling 4,144 words
- [x] WhatsApp (1,748) + Follow-up (2,396) too detailed individually
- [x] Need unified multi-channel approach
- [ ] Missing channel comparison framework

**Actions:**
1. **MERGE 3 scripts into 1 unified lesson:**
   - Extract best 400 words from 2.13 (WhatsApp strategy)
   - Extract best 400 words from 2.14 (Follow-up timing)
   - Extract best 400 words from 2.7 (Multi-channel logic)
   - NEW: 400 words comparing channels (table + decision framework)

2. **CUT ruthlessly:**
   - Remove platform-specific setup details (WhatsApp Business API)
   - Remove excessive follow-up examples (show 1 complete sequence, not 5)
   - Remove redundant "why follow-up" explanations
   - Focus on STRATEGY, not execution details

3. **UNIFIED STRUCTURE:**
   - [00:00-01:00] Hook: 5% single vs 20% multi-channel
   - [01:00-03:00] Channel comparison framework
   - [03:00-08:00] Demo: 4-touch sequence (Email → LinkedIn → WhatsApp → Email)
   - [08:00-11:00] Personalization using Gemini + Crunchbase
   - [11:00-12:00] ROI + A/B testing approach

**Target Length:** 1,200 words (12 min)

**Bloom Level:** EVALUATE (compare channels, choose optimal strategy)

---

#### Lesson 2.6: Dashboard + Optimization

**Source Material:**
- Primary: `2.9-dashboard-metricas.md` (full lesson)
- Supporting: `2.8-ROTEIRO-TELEPROMPTER-testes-ab.md` (328 words)
- Supporting: `2.19-ROTEIRO-TELEPROMPTER-closer-objecao.md` (533 words)
- Supporting: `2.20-ROTEIRO-TELEPROMPTER-proposta-auto-completo.md` (2,003 words)
- Workflow: `track-pipedrive-deals-in-google-sheets-for-sales-pipeline-reporting.json` (extended)

**Optimization Strategy:**

**Current Issues:**
- [x] Four separate scripts (2.8, 2.9, 2.19, 2.20) covering different topics
- [x] 2.20 too long (2,003 words) on proposal generation
- [x] Missing unified "measurement + optimization" theme
- [ ] No clear ROI calculation tying everything together

**Actions:**
1. **MERGE into unified "Results" lesson:**
   - 40% from 2.9 (Dashboard metrics - CAC, conversion, ROI)
   - 20% from 2.8 (A/B testing framework)
   - 20% from 2.19 (Objection handling as optimization signal)
   - 20% from 2.20 (Proposal automation as final conversion metric)

2. **CUT heavily:**
   - Remove deep dive into closer techniques (not optimization focus)
   - Remove proposal template details (use 1 example, not 5)
   - Remove redundant metric explanations
   - Focus on TRACKING and OPTIMIZATION, not execution

3. **UNIFIED STRUCTURE:**
   - [00:00-01:00] Hook: "You can't improve what you don't measure"
   - [01:00-03:00] 5 Key Metrics: Leads → MQL → SQL → Opportunity → Closed
   - [03:00-08:00] Demo: Google Sheets dashboard build
   - [08:00-11:00] A/B testing: Subject lines, channels, timing
   - [11:00-14:00] Month-over-month optimization case study

**Target Length:** 1,400 words (14 min)

**Bloom Level:** CREATE (build custom dashboard, define optimization strategy)

---

## PART 3: MICROLEARNING STRUCTURE TEMPLATE

### Universal Structure (All 6 Lessons)

```markdown
[00:00-01:00] Hook + Problem (60 sec max)
├─ Statistical comparison or case study
├─ Clear problem statement
└─ Preview of solution

[01:00-03:00] Why This Matters (2 min)
├─ Market context (Brazilian stats when possible)
├─ Comparison to alternatives
└─ When to use (and when NOT to use)

[03:00-08:00] Demo/Implementation (5 min)
├─ Screen share: n8n workflow
├─ Step-by-step setup
├─ Live execution + results
└─ ONE complete example (not 3+)

[08:00-11:00] ROI Calculation (3 min)
├─ Specific cost breakdown
├─ Time savings calculation
├─ Revenue impact (when applicable)
└─ Comparison table (before/after)

[11:00-12:00] Next Steps (1 min)
├─ 3 action items for student
├─ Preview of next lesson
└─ How this connects to overall system

[12:00-13:00] Wrap-up (1 min)
├─ Key takeaways (3 bullets max)
├─ Common pitfalls warning
└─ Q&A prompt
```

### Word Count Targets (Strict)

| Section | Words | Time |
|---------|-------|------|
| Hook | 100-150 | 1 min |
| Context | 200-300 | 2 min |
| Demo | 500-700 | 5 min |
| ROI | 200-300 | 3 min |
| Next Steps | 100-150 | 1 min |
| Wrap | 100-150 | 1 min |
| **TOTAL** | **1,200-1,500** | **12-15 min** |

### Content Cutting Rules

**❌ ALWAYS CUT:**
1. Lengthy introductions ("Hi everyone, today we're going to...")
2. Theoretical explanations without immediate application
3. Multiple similar examples (show 1 complete, not 3 partial)
4. Platform history/background (just show how to use it)
5. Excessive "why this is important" justification
6. Redundant transitions ("So now that we've covered X...")
7. Academic references or studies (unless directly support ROI)

**✅ ALWAYS KEEP:**
1. Specific ROI numbers (R$ amounts, percentages, time savings)
2. Brazilian market context (stats, company examples, pricing in BRL)
3. Visual comparisons (tables, before/after, side-by-side)
4. Screen recordings showing actual workflows running
5. Common pitfalls/warnings (saves student time)
6. Decision frameworks (when to use X vs Y)
7. Actionable next steps

---

## PART 4: WORKFLOW MAPPING

### Workflow-to-Lesson Alignment

| Lesson | Primary Workflow | Secondary Workflows |
|--------|-----------------|---------------------|
| **2.1** | `track-pipedrive-deals-in-google-sheets-for-sales-pipeline-reporting.json` | None (intro) |
| **2.2** | `scrape-&-enrich-google-maps-leads-with-decodo-api-and-gemini-2.5-flash.json` | None |
| **2.3** | `lead-generation-automate-on-linkedin-personalisation-enrichment.json` | `automate-cold-outreach-with-apollo,-linkedin-&-gmail-using-gpt-4.json` |
| **2.4** | Custom GPT-4 scoring (extends 2.3 workflow) | None |
| **2.5** | `personalized-email-outreach-with-linkedin-and-crunchbase-data-and-gemini-ai-review.json` | `automated-b2b-prospecting-with-rapidapi,-hunter.io,-gpt-&-gmail.json` |
| **2.6** | `track-pipedrive-deals-in-google-sheets-for-sales-pipeline-reporting.json` (extended dashboard) | None |

### Unused Workflows (Reserve for Module 3/4)

- `discover-decision-makers-by-responsibilities-(not-titles)-with-octave-&-airtable.json` → Module 3
- `extract-emails,-phones-&-social-links-from-websites-with-apify-and-google-sheets.json` → Module 3
- `ai-powered-lead-generation-system-with-email-personalization-and-linkedin.json` → Module 4 (advanced)

---

## PART 5: BLOOM'S TAXONOMY PROGRESSION

### Module 2 Cognitive Journey

```
LESSON 2.1 (APPLY - Basic)
└─ Action: Set up pipeline tracking
   └─ Skill: Follow instructions, configure basic workflow
      └─ Assessment: Can student run pre-built workflow?

LESSON 2.2 (APPLY - Intermediate)
└─ Action: Implement Google Maps scraping
   └─ Skill: Configure APIs, filter data, understand scraping
      └─ Assessment: Can student customize search parameters?

LESSON 2.3 (ANALYZE - Basic)
└─ Action: Compare LinkedIn vs Apollo data quality
   └─ Skill: Evaluate data sources, understand enrichment
      └─ Assessment: Can student explain which source for which use case?

LESSON 2.4 (ANALYZE - Advanced)
└─ Action: Analyze lead quality using multi-dimensional scoring
   └─ Skill: Pattern recognition, data-driven prioritization
      └─ Assessment: Can student modify scoring criteria for their ICP?

LESSON 2.5 (EVALUATE)
└─ Action: Evaluate channel effectiveness and design sequence
   └─ Skill: Strategic thinking, optimization mindset
      └─ Assessment: Can student justify channel choices with data?

LESSON 2.6 (CREATE)
└─ Action: Create custom ROI dashboard and optimization plan
   └─ Skill: Synthesis, original work, strategic measurement
      └─ Assessment: Does student's dashboard track business-critical metrics?
```

### Assessment Checkpoints

**Lesson 2.1 Quiz:**
- Q1: What are the 3 roles in AI Sales Machine? (Knowledge)
- Q2: Connect the Pipedrive → Google Sheets workflow (Application)

**Lesson 2.2 Quiz:**
- Q1: When is Google Maps better than LinkedIn? (Comprehension)
- Q2: Configure Outscraper to find "dental clinics in São Paulo" (Application)

**Lesson 2.3 Project:**
- Compare 10 leads from LinkedIn vs Apollo
- Document data quality differences
- Recommend which source for your business

**Lesson 2.4 Project:**
- Score 20 leads using provided framework
- Explain why top 5 are high-priority
- Modify 1 scoring criteria for your ICP

**Lesson 2.5 Project:**
- Design 4-touch sequence for your product
- Justify channel choices with market data
- Write 2 personalized message templates

**Lesson 2.6 Final Project:**
- Build complete Google Sheets dashboard
- Track 50 leads through system
- Present 3 optimization recommendations with ROI

---

## PART 6: IMPLEMENTATION CHECKLIST

### Phase 1: Script Consolidation (Week 1)

**Lesson 2.1:**
- [x] Identify source materials (2.1 teleprompter + full)
- [ ] Cut 60% (2,958 → 1,200 words)
- [ ] Remove detailed role sections
- [ ] Keep architecture overview + basic demo
- [ ] Add roadmap to Lessons 2.2-2.6
- [ ] Test recording time (should be 12 min)

**Lesson 2.2:**
- [x] Identify source (2.3 teleprompter - ALREADY GOOD)
- [ ] Add 280 words (Gemini enrichment section)
- [ ] Integrate Decodo + Gemini workflow
- [ ] Test recording time (should be 13 min)

**Lesson 2.3:**
- [x] Identify sources (2.12, 2.4, 2.5)
- [ ] Cut 434 words from 2.12
- [ ] Merge Apollo section from 2.5
- [ ] Add data quality comparison table
- [ ] Test recording time (should be 14 min)

**Lesson 2.4:**
- [x] Identify sources (2.6 full + teleprompter)
- [ ] Convert full lesson to teleprompter format
- [ ] Add live scoring demo (3 real leads)
- [ ] Add routing logic section
- [ ] Test recording time (should be 13 min)

**Lesson 2.5:**
- [x] Identify sources (2.7, 2.13, 2.14)
- [ ] Extract 400 words from each source
- [ ] Create unified 4-touch sequence example
- [ ] Add channel comparison framework
- [ ] Test recording time (should be 12 min)

**Lesson 2.6:**
- [x] Identify sources (2.8, 2.9, 2.19, 2.20)
- [ ] Merge into unified "measurement + optimization" theme
- [ ] Build dashboard demo (Google Sheets)
- [ ] Add A/B testing section
- [ ] Test recording time (should be 14 min)

### Phase 2: Workflow Integration (Week 2)

- [ ] Test all 6 workflows locally
- [ ] Document API requirements per lesson
- [ ] Create setup guides (API keys, accounts)
- [ ] Record workflow demos (screen capture)
- [ ] Prepare sample data for demos
- [ ] Test end-to-end flow (Lesson 2.1 → 2.6)

### Phase 3: Quality Assurance (Week 3)

**Per-Lesson QA:**
- [ ] Word count within 1,200-1,500 range
- [ ] Recording time within 12-15 min
- [ ] Bloom level correctly applied
- [ ] ROI calculation specific and accurate
- [ ] Workflow matches lesson content
- [ ] Brazilian context present
- [ ] Action items clear
- [ ] Next lesson teased

**Module-Level QA:**
- [ ] Total duration 72-90 min (target: 78 min)
- [ ] Clear progression (Apply → Analyze → Evaluate → Create)
- [ ] No redundant content across lessons
- [ ] Consistent voice and energy
- [ ] All workflows tested and working
- [ ] Assessment checkpoints ready

### Phase 4: Recording (Week 4)

**Recording Order:**
1. Lesson 2.2 (simplest, build confidence)
2. Lesson 2.1 (overview, references 2.2)
3. Lesson 2.3 (builds on 2.2)
4. Lesson 2.4 (builds on 2.3)
5. Lesson 2.5 (uses leads from 2.2-2.4)
6. Lesson 2.6 (references all previous lessons)

**Per-Lesson Recording Checklist:**
- [ ] Teleprompter loaded
- [ ] Screen share ready (browser tabs open)
- [ ] Workflows pre-tested (no live failures)
- [ ] Sample data loaded
- [ ] Visual assets ready (tables, diagrams)
- [ ] Recording in 1080p
- [ ] Audio quality checked
- [ ] Energy level: HIGH (empresário apressado!)

---

## PART 7: PRIORITY RANKING

### Ready to Use (Minimal Edits)
**Est. Time: 2-4 hours total**

1. **Lesson 2.2: Google Maps** ⭐⭐⭐
   - Current: 1,020 words (EXCELLENT)
   - Needed: +280 words (Gemini section)
   - Effort: 2 hours (record new section, splice)
   - Priority: HIGH (can ship this week)

### Quick Fix (Cuts + Mergers)
**Est. Time: 8-12 hours total**

2. **Lesson 2.3: LinkedIn + Apollo** ⭐⭐
   - Current: 1,834 words (2.12) + 359 words (2.5)
   - Needed: Cut 434 from 2.12, merge Apollo
   - Effort: 4 hours (editing + re-recording transitions)
   - Priority: HIGH (core lesson)

3. **Lesson 2.5: Multi-Channel** ⭐⭐
   - Current: 1,748 (2.13) + 2,396 (2.14) + 449 (2.7) = 4,593 words
   - Needed: Cut 73% (4,593 → 1,200)
   - Effort: 6 hours (major merger)
   - Priority: MEDIUM (more complex)

### Needs Rewrite
**Est. Time: 16-24 hours total**

4. **Lesson 2.1: Overview** ⭐
   - Current: 2,958 words
   - Needed: Cut 60% (→ 1,200 words)
   - Effort: 6 hours (major structural rewrite)
   - Priority: HIGH (sets tone for module)

5. **Lesson 2.4: Lead Scoring** ⭐
   - Current: 493 words (teleprompter) + full lesson (not teleprompter format)
   - Needed: Convert + expand to 1,300 words
   - Effort: 5 hours (format conversion + demos)
   - Priority: MEDIUM (complex concept)

6. **Lesson 2.6: Dashboard** ⭐
   - Current: 2,864 words total (2.8 + 2.9 + 2.19 + 2.20)
   - Needed: Merge 4 scripts, cut 50%
   - Effort: 7 hours (major reorganization)
   - Priority: MEDIUM (final lesson, less urgent)

### Recommended Implementation Order

**Week 1: Quick Wins**
1. Lesson 2.2 (2 hours) - Ship immediately
2. Lesson 2.3 (4 hours) - Core content
3. **CHECKPOINT:** Have 2 lessons ready (26 min of 78 min)

**Week 2: Critical Path**
4. Lesson 2.1 (6 hours) - Must set module tone
5. Lesson 2.4 (5 hours) - Key differentiation (AI scoring)
6. **CHECKPOINT:** Have 4 lessons ready (52 min of 78 min)

**Week 3: Finalize**
7. Lesson 2.5 (6 hours) - Complex merger
8. Lesson 2.6 (7 hours) - Capstone
9. **CHECKPOINT:** All 6 lessons complete (78 min)

**Week 4: QA + Recording**
10. End-to-end QA
11. Record final versions
12. **SHIP MODULE 2**

**Total Estimated Effort:** 36 hours (1 week full-time or 4 weeks part-time)

---

## PART 8: QUALITY VERIFICATION CHECKLIST

### Per-Lesson Verification (Use Before Recording)

#### Content Quality
- [ ] Word count: 1,200-1,500 words
- [ ] Hook: Compelling stat or case study (under 100 words)
- [ ] ROI calculation: Specific numbers (R$ amounts, percentages, time)
- [ ] Demo: ONE complete example (not 3+ partial)
- [ ] No redundancy with other lessons
- [ ] Brazilian context present (pricing in BRL, local examples)
- [ ] Actionable next steps (3 specific items)

#### Pedagogical Quality
- [ ] Bloom level correctly applied (see progression chart)
- [ ] Builds on previous lesson
- [ ] Previews next lesson
- [ ] Assessment checkpoint defined
- [ ] Cognitive load balanced (max 5 new concepts)
- [ ] Learning objective clear and measurable

#### Technical Quality
- [ ] Workflow tested and working
- [ ] API credentials documented
- [ ] Setup guide ready
- [ ] Sample data prepared
- [ ] Screen recording planned (which tabs, which flow)
- [ ] Visual assets ready (tables, diagrams)

#### Recording Quality
- [ ] Teleprompter script readable
- [ ] Energy level: HIGH (empresário apressado tone)
- [ ] Pacing: 100 words/min (1,200 words = 12 min)
- [ ] No "umms" or long pauses
- [ ] Transitions smooth
- [ ] Closes with clear CTA

### Module-Level Verification (Use After All 6 Lessons)

#### Duration Compliance
- [ ] Total duration: 72-90 min (target: 78 min)
- [ ] No lesson under 12 min
- [ ] No lesson over 15 min
- [ ] Even pacing across module

#### Pedagogical Progression
- [ ] Lessons 2.1-2.2: APPLY (implement workflows)
- [ ] Lessons 2.3-2.4: ANALYZE (understand, compare, prioritize)
- [ ] Lesson 2.5: EVALUATE (choose optimal strategies)
- [ ] Lesson 2.6: CREATE (build custom system)
- [ ] Clear skill building (each lesson enables next)

#### Content Cohesion
- [ ] No contradictions between lessons
- [ ] Consistent terminology
- [ ] Consistent voice (Joaninha's profile)
- [ ] Brazilian context throughout
- [ ] ROI story builds across module (R$ 6k cost → R$ 45k revenue)

#### Workflow Integration
- [ ] All 6 workflows integrated
- [ ] End-to-end flow works (2.1 → 2.6)
- [ ] No missing steps between lessons
- [ ] Sample data flows through complete system

#### Assessment Readiness
- [ ] 6 lesson quizzes/projects ready
- [ ] Final Module 2 project defined
- [ ] Rubric for grading projects
- [ ] Success criteria clear (what does "completed Module 2" mean?)

---

## PART 9: SCRIPTS TO RETIRE

### Scripts Being Merged (Not Standalone Lessons)

**Moving INTO Lesson 2.1:**
- `2.1-ai-sales-machine-completa.md` (background material)

**Moving INTO Lesson 2.3:**
- `2.4-prospeccao-linkedin-phantom.md`
- `2.5-apollo-search-enrich.md`

**Moving INTO Lesson 2.4:**
- `2.6-lead-scoring-inteligente.md` (convert to teleprompter)

**Moving INTO Lesson 2.5:**
- `2.7-sequencias-multi-canal.md`
- `2.11-cold-email-gpt4.md`
- `2.12-linkedin-outreach.md`
- `2.13-whatsapp-business-auto.md`
- `2.14-follow-up-inteligente.md`
- `2.15-reply-detection-routing.md`
- `2.16-meeting-booking-auto.md`
- `2.17-reativacao-leads.md`
- `2.18-nurture-sequences.md`

**Moving INTO Lesson 2.6:**
- `2.8-testes-ab-automaticos.md`
- `2.9-dashboard-metricas.md`
- `2.10-integracao-crm.md`
- `2.19-closer-ai-objecao-handling.md`
- `2.20-closer-proposta-auto.md`

### Scripts REMOVED (Out of Scope for Module 2)

**Moving to Module 3 (Conteúdo & Engajamento):**
- `2.21-template-saas-b2b.md`
- `2.22-template-agencia.md`
- `2.23-template-ecommerce.md`
- `2.24-template-infoprodutos.md`
- `2.25-template-consultoria.md`
- `2.26-template-imobiliaria.md`
- `2.27-template-saude-clinicas.md`
- `2.28-template-educacao.md`
- `2.29-customizacao-local-business.md`

**Rationale:** These are industry-specific templates, better suited for Module 3's content focus, not Module 2's acquisition focus.

---

## PART 10: SUCCESS METRICS

### Course Quality Metrics (From curriculum.yaml)

**Alignment Score:** >= 90%
- Each lesson maps to curriculum.yaml topics
- Learning objectives match course objectives
- Workflows deliver on course promises

**Completeness Score:** 100%
- All 6 lessons present
- Total duration 72-90 min
- All workflows tested and working
- All assessment checkpoints defined

**Voice Fidelity:** >= 85%
- Matches Joaninha's empresarial but accessible tone
- High energy throughout
- Data-driven (stats, ROI, concrete numbers)
- Zero academic fluff

**Cognitive Load:** Balanced
- Max 5 new concepts per lesson
- Clear build-up from simple (2.1) to complex (2.6)
- No overwhelming walls of information
- Visual aids for complex concepts

### Learner Outcome Metrics

**Module 2 Completion Criteria:**
- Student can set up basic AI Sales Machine (Lessons 2.1-2.2)
- Student can implement lead scoring (Lesson 2.4)
- Student can design multi-channel sequences (Lesson 2.5)
- Student can build ROI dashboard (Lesson 2.6)
- Student completes final Module 2 project

**Module 2 Final Project:**
**Deliverable:** Functional AI Sales Machine with 50 leads
- Demonstrate 50 leads collected (Google Maps or LinkedIn)
- Show lead scoring in action (with scores visible)
- Execute 4-touch sequence (with timestamps)
- Present dashboard tracking key metrics (screenshot)
- Calculate actual ROI (cost vs projected revenue)

**Success Threshold:** >= 70% of students complete final project

---

## APPENDIX A: RESOURCES NEEDED

### Recording Equipment
- Screen recording software (OBS, ScreenFlow, Loom)
- 1080p webcam (picture-in-picture)
- Quality microphone (clear audio is critical)
- Teleprompter software or tablet

### Technical Infrastructure
- n8n instance (cloud or local)
- API accounts:
  - Outscraper (R$ 200/mês)
  - Apollo.io (R$ 499/mês)
  - Phantom Buster (R$ 299/mês)
  - OpenAI (GPT-4)
  - Google Gemini
  - Pipedrive trial
- Sample datasets:
  - 100 Google Maps leads
  - 100 LinkedIn profiles
  - 50 Apollo enriched leads

### Visual Assets
- Comparison tables (Email vs LinkedIn vs WhatsApp)
- System architecture diagrams (3-role AI Sales Machine)
- Before/after ROI tables
- Workflow screenshots (all 6 workflows)
- Dashboard mockups (Google Sheets)

### Support Materials
- API setup guides (step-by-step)
- Workflow import instructions
- Troubleshooting FAQs
- Sample data files (CSV/JSON)

---

## APPENDIX B: API COST BREAKDOWN

### Monthly Operational Costs (Per Student)

| Service | Free Tier | Paid Tier | Module 2 Usage |
|---------|-----------|-----------|----------------|
| **Outscraper** | 100 credits | R$ 200/mês (5k credits) | 800 leads = R$ 32 |
| **Phantom Buster** | 7-day trial | R$ 299/mês | 500 leads = R$ 299 |
| **Apollo.io** | 50 credits | R$ 499/mês (10k credits) | 200 enrichments = R$ 10 |
| **OpenAI GPT-4** | None | ~R$ 0.15/lead | 100 scorings = R$ 15 |
| **Google Gemini** | Limited | ~R$ 0.05/lead | 800 enrichments = R$ 40 |
| **Pipedrive** | 14-day trial | R$ 99/mês | Free (trial sufficient) |

**Total Monthly Cost:** ~R$ 396/mês for 1,500 leads
**Cost Per Lead:** R$ 0.26

**ROI for Course:**
- Module 2 teaches system worth R$ 396/mês operational cost
- Projected revenue: R$ 45k/mês (from curriculum case study)
- **ROI: 11,300%**

### Recommendations for Students

1. **Start with free tiers** (Week 1-2)
   - Outscraper: 100 free credits
   - Phantom Buster: 7-day trial
   - Apollo: 50 free credits
   - Pipedrive: 14-day trial

2. **Upgrade strategically** (Week 3-4)
   - Pay for most critical service first (Phantom Buster for B2B)
   - Use free alternatives where possible (Apify instead of Outscraper)

3. **Group discounts** (Course-wide)
   - Negotiate 20% off Apollo for course students
   - Bulk Outscraper credits
   - Extended Phantom Buster trials

---

## NEXT STEPS

1. **Review this plan** with João and instructional design team
2. **Approve lesson structure** (6 lessons as outlined)
3. **Prioritize implementation** (recommend: 2.2 → 2.3 → 2.1 → 2.4 → 2.5 → 2.6)
4. **Allocate resources** (36 hours effort over 3-4 weeks)
5. **Begin Phase 1** (Script Consolidation - Week 1)

**Questions? Need clarification on any lesson?**
Ready to begin implementation when you give the green light.

---

*Generated: December 3, 2025*
*Version: 1.0*
*Status: Ready for Review*
