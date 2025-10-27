# Reformulate COURSE-BRIEF Task

**Task ID:** `reformulate-course-brief`
**Agent:** `course-architect`
**Type:** Strategic Optimization
**Elicit:** false (automated reformulation with manual review checkpoint)
**Duration:** 3-5 minutes

---

## 📋 Task Overview

Reformulate the COURSE-BRIEF.md file by integrating market research insights to create a strategically optimized course design. This task enriches the initial course brief with competitive intelligence, gap analysis, and differentiation strategy.

**Key Principle:** The initial COURSE-BRIEF represents the user's vision. Market research adds strategic context. Reformulation synthesizes both into an optimized final brief that preserves vision while maximizing competitive advantage.

---

## 🎯 Inputs Required

### Required Files:
- `outputs/courses/{slug}/COURSE-BRIEF.md` (initial version, 8 sections filled)
- `outputs/courses/{slug}/research/market-analysis.md` (competitive landscape)
- `outputs/courses/{slug}/research/content-gaps.md` (gap analysis with priorities)
- `outputs/courses/{slug}/research/differentiation.md` (positioning strategy)

### Required Parameters:
- `course_slug` - The course identifier (kebab-case)
- `mode` - Workflow mode (greenfield | brownfield)

---

## 📤 Outputs Generated

### Files Created/Modified:

#### 1. `COURSE-BRIEF-ORIGINAL.md` (Backup)
- Exact copy of original COURSE-BRIEF.md
- Preserved for reference and rollback
- Never modified after creation

#### 2. `COURSE-BRIEF.md` (Reformulated)
- Original 8 sections enhanced with market insights
- New Section 9: Market Research Summary
- Inline annotations showing research-driven changes
- Ready for curriculum generation

---

## 🔄 Workflow Steps

### STEP 1: Backup Original Brief
```yaml
action: create_backup
inputs:
  - outputs/courses/{slug}/COURSE-BRIEF.md
outputs:
  - outputs/courses/{slug}/COURSE-BRIEF-ORIGINAL.md
```

**Process:**
1. Read COURSE-BRIEF.md
2. Write exact copy to COURSE-BRIEF-ORIGINAL.md
3. Verify backup successful (file exists, same size)

**Purpose:** Preserve user's initial vision for comparison and potential rollback

---

### STEP 2: Load Research Insights
```yaml
action: load_research_data
inputs:
  - outputs/courses/{slug}/research/market-analysis.md
  - outputs/courses/{slug}/research/content-gaps.md
  - outputs/courses/{slug}/research/differentiation.md
extracts:
  market_insights:
    - competitive_patterns
    - pricing_analysis
    - pedagogical_approaches
    - student_feedback_patterns
  content_gaps:
    - gap_topics (with priorities: P0, P1, P2)
    - depth_gaps
    - icp_gaps
    - practice_gaps
  differentiation:
    - positioning_statement
    - unique_angles
    - competitive_advantages
    - differentiation_dimensions
```

**Validation:**
- ✅ All 3 research files exist
- ✅ Each file has required sections
- ✅ At least 3 gap topics identified (P0/P1)
- ✅ Positioning statement present

**On Validation Failure:**
```
❌ ERROR: Incomplete market research

Missing/incomplete files:
  - {missing_file_1}
  - {missing_file_2}

Action Required:
1. Run @course-architect → *market-research {slug}
2. Ensure research completes successfully
3. Re-run reformulate-course-brief

Cannot reformulate without complete market intelligence.
```

---

### STEP 3: Reformulate Each COURSE-BRIEF Section

**General Reformulation Strategy:**
- **Preserve:** User's original vision, core ideas, initial objectives
- **Enhance:** Add competitive context, gap topics, differentiation insights
- **Annotate:** Mark research-driven additions with `<!-- RESEARCH: ... -->`
- **Integrate:** Seamlessly blend research into existing content (not just append)

---

#### **Section 1: Basic Info**

**Original Fields:**
- Course Title
- Course Subtitle
- Estimated Total Duration
- Prerequisites
- Certification/Credential

**Reformulation Actions:**

**1.1. Refine Subtitle (if needed):**
```markdown
Before: "Learn Supabase for backend development"
After:  "Build production backends without server complexity - for frontend developers"
         <!-- RESEARCH: Subtitle emphasizes ICP (frontend devs) and differentiation (no server complexity) -->
```

**Logic:**
- IF differentiation.md has unique angle → Incorporate into subtitle
- IF market shows all competitors use generic language → Make subtitle ICP-specific
- ELSE → Keep original subtitle

**1.2. Adjust Duration (if needed):**
```markdown
Before: 12 hours
After:  8 hours
        <!-- RESEARCH: Market analysis shows 8-10h is sweet spot. Competitors at 15h+ get completion complaints. -->
```

**Logic:**
- IF market-analysis shows duration pattern → Validate against user's estimate
- IF significantly different (>25% variance) → Suggest adjustment with rationale
- ELSE → Keep original duration

**1.3. Add Competitive Context to Prerequisites:**
```markdown
Before:
  - Basic JavaScript knowledge
  - Familiarity with React

After:
  - Basic JavaScript knowledge
  - Familiarity with React
  - **NO backend experience required** <!-- RESEARCH: Competitors assume backend knowledge - gap opportunity -->
```

---

#### **Section 2: ICP (Ideal Customer Profile)**

**Original Fields:**
- Demographics
- Psychographics
- Pain Points
- Goals
- Archetypes (if defined)

**Reformulation Actions:**

**2.1. Add Competitive Context:**
```markdown
## 2. ICP - Ideal Customer Profile

### Target Audience Positioning
<!-- RESEARCH: Unlike competitors who target generic "developers", we specifically target frontend developers transitioning to fullstack. This is an underserved segment (0/12 competitive courses). -->

**Primary Archetype:** Frontend Developer → Fullstack Transition
```

**2.2. Validate Pain Points Against Market:**
```markdown
### Pain Points
1. Backend complexity overwhelming
   <!-- RESEARCH: Validated - 8/12 courses mention this in reviews but don't address it -->

2. Don't want to learn DevOps/servers
   <!-- RESEARCH: NEW - Gap identified. No competitor explicitly positions as "serverless backend" -->

3. Need production-ready patterns, not toy examples
   <!-- RESEARCH: Validated - #1 complaint in competitor reviews (7/12 courses) -->
```

**Logic:**
- VALIDATE each original pain point against student feedback in market-analysis.md
- ADD new pain points from content-gaps.md (ICP gaps section)
- ANNOTATE which are validated vs. new from research

**2.3. Refine Goals Based on Gap Analysis:**
```markdown
### Goals
1. Build production Supabase backends
2. Ship fullstack apps without backend complexity
3. **Understand when to use Supabase vs. traditional backend**
   <!-- RESEARCH: Gap topic (P1) - No competitor teaches decision framework -->
```

---

#### **Section 3: Content & Pedagogy**

**Original Fields:**
- Learning Objectives (Bloom's Taxonomy)
- Preliminary Course Outline
- Pedagogical Framework
- Assessment Strategy

**Reformulation Actions:**

**3.1. Add Gap Topics to Learning Objectives:**
```markdown
### Learning Objectives

**Core Objectives (Original):**
1. Build authentication with Supabase Auth
2. Design scalable database schemas
3. Implement real-time features with Supabase Realtime

**New Objectives (From Gap Analysis):**
4. **Deploy production Supabase apps with CI/CD**
   <!-- RESEARCH: Gap topic (P0) - Only 2/12 courses cover deployment. Top student request in reviews. -->

5. **Architect row-level security policies**
   <!-- RESEARCH: Gap topic (P1) - Mentioned in 4/12 courses but always superficial (depth gap). -->

6. **Optimize Supabase performance at scale**
   <!-- RESEARCH: Gap topic (P1) - No competitor covers this. Identified in student "what's missing" reviews. -->
```

**Logic:**
- KEEP all original objectives (user's vision)
- ADD P0 gap topics as new objectives (must address)
- ADD P1 gap topics if space allows (should address)
- SKIP P2 gap topics (consider later)
- ANNOTATE each new objective with research source

**3.2. Enhance Preliminary Outline:**
```markdown
### Preliminary Course Outline

**Module 1: Fundamentals**
- Lesson 1.1: What is Supabase (and when to use it)
  <!-- RESEARCH: Added "when to use it" - decision framework gap (P1) -->
- Lesson 1.2: Setup & First Project
- Lesson 1.3: **Understanding the Supabase Architecture**
  <!-- RESEARCH: NEW lesson - Depth gap. Competitors jump straight to code without explaining architecture. -->

**Module 2: Core Features**
[... existing lessons ...]

**Module 3: Production Deployment (NEW MODULE)**
<!-- RESEARCH: New module to address P0 gap (deployment). No competitor has dedicated module for this. -->
- Lesson 3.1: Deployment strategies
- Lesson 3.2: CI/CD with GitHub Actions
- Lesson 3.3: Monitoring & debugging production issues
```

**Logic:**
- ENHANCE existing modules with gap topics
- ADD new modules for P0 gaps (if substantial content)
- REORDER if research shows better pedagogical flow
- ANNOTATE additions/changes with research rationale

**3.3. Refine Pedagogical Framework (if needed):**
```markdown
### Pedagogical Framework

**Primary:** GPS (Goal → Position → Steps) + Didática Lendária

**Differentiation Approach:**
<!-- RESEARCH: 7/10 competitive courses are lecture-heavy (theory > 60%). We flip to practice-first (60% hands-on, 40% theory) to address top student complaint. -->

- **Practice-First:** Every concept taught through building
- **Production Focus:** No toy examples - all projects production-ready
- **Fullstack Context:** All examples in React/Next.js context (ICP-tailored)
```

---

#### **Section 4: Voice & Personality**

**Original Fields:**
- Tone & Style
- Teaching Approach
- Signature Phrases/Patterns
- Use of Humor/Stories

**Reformulation Actions:**

**4.1. Emphasize Voice Differentiation:**
```markdown
### Voice & Personality

**Tone:** Casual, approachable mentor (not academic/formal)
<!-- RESEARCH: Differentiation opportunity - 9/12 competitors use formal/corporate tone. Students prefer approachable style (review analysis). -->

**Teaching Approach:** Story-driven, example-heavy
- Start with real problem (student can relate)
- Build solution step-by-step
- Explain "why" not just "how"
<!-- RESEARCH: Storytelling approach is differentiator - only 2/12 competitors use this. -->

**Signature Style Elements:**
- Frequent use of analogies (complex → simple)
  <!-- RESEARCH: Analogies differentiate from technical-only competitors -->
- "Let's build together" collaborative tone
- Celebrate wins, normalize struggles
```

---

#### **Section 5: Format & Delivery**

**Original Fields:**
- Course Structure (modules, lessons)
- Lesson Format
- Content Types (video, text, exercises)
- Time Estimates

**Reformulation Actions:**

**5.1. Adjust Format Based on Market Insights:**
```markdown
### Format & Delivery

**Lesson Structure:**
- **60% Hands-On Practice** (building, coding, debugging)
- **40% Theory** (concepts, architecture, best practices)
<!-- RESEARCH: Inverted from market norm (competitors: 70% theory, 30% practice). Addresses #1 student complaint. -->

**Content Formats:**
- Video lessons (5-10 min each) - Microlearning approach
- **Starter templates** for each module
  <!-- RESEARCH: Differentiation - No competitor provides templates. High student demand (reviews). -->
- **Deployment checklists**
  <!-- RESEARCH: Gap resource - Students want production guidance, no competitor provides it. -->
- Code repositories (GitHub)
```

---

#### **Section 6: Commercial**

**Original Fields:**
- Pricing Model
- Revenue Targets
- Positioning Statement
- Competitive Landscape

**Reformulation Actions:**

**6.1. Update Pricing Based on Market Analysis:**
```markdown
### Commercial

**Pricing Strategy:**
- **Target Price:** $79 (one-time payment)
<!-- RESEARCH: Market analysis shows:
     - Budget tier: $20-40 (low quality, toy examples)
     - Mid tier: $50-90 (our tier - quality positioning)
     - Premium: $100+ (enterprise/certification)
     Positioning at $79 signals quality while remaining accessible to ICP (frontend devs). -->

**Competitive Positioning:**
- More expensive than Udemy toy courses ($20-30)
- Less expensive than enterprise bootcamps ($200+)
- Justified by production focus + templates + ICP-tailored content
```

**6.2. Refine Positioning Statement:**
```markdown
### Positioning Statement

**FOR** frontend developers **WHO** want to become fullstack without backend complexity,
**THIS COURSE** teaches production-ready Supabase development with deployment-ready templates,
**UNLIKE** generic Supabase tutorials **WHICH** use toy examples and assume backend knowledge,
**WE PROVIDE** ICP-tailored examples (React context), production patterns, and deployment checklists.

<!-- RESEARCH: Positioning derived from differentiation.md. Emphasizes 3 key differentiators:
     1. ICP-specific (frontend → fullstack)
     2. Production-ready (not toys)
     3. Deployment support (gap topic P0) -->
```

---

#### **Section 7: Success Metrics**

**Original Fields:**
- Student Outcomes (skills acquired)
- Completion Rate Targets
- Satisfaction Targets (NPS, ratings)
- Business KPIs

**Reformulation Actions:**

**7.1. Add Differentiation KPIs:**
```markdown
### Success Metrics

**Student Outcomes:**
- 90% can build & deploy production Supabase app independently
- 80% successfully ship fullstack app within 1 week of course completion
- **85% report course is "more practical than other Supabase courses"**
  <!-- RESEARCH: Differentiation KPI - Tracks practice-first positioning -->

**Satisfaction Targets:**
- Course Rating: ≥ 4.7/5.0
- NPS: ≥ 50
- **Completion Rate: ≥ 70%**
  <!-- RESEARCH: Market avg completion rate is 45%. Our microlearning + practice-first aims for 70%. -->

**Differentiation Validation:**
- **"Production-ready templates saved me hours"** - Target: 75%+ agreement
  <!-- RESEARCH: Tracks unique value prop (templates differentiation) -->
- **"Perfect for frontend devs like me"** - Target: 80%+ agreement
  <!-- RESEARCH: Tracks ICP alignment -->
```

---

#### **Section 8: Constraints**

**Original Fields:**
- Time Constraints
- Budget Constraints
- Technology Constraints
- Scope Limitations

**Reformulation Actions:**

**8.1. Note Competitive Advantages to Preserve:**
```markdown
### Constraints

**Scope Boundaries:**
- Focus: Supabase only (not Firebase, AWS Amplify, or other BaaS)
- Context: Frontend dev → fullstack (not backend expert → BaaS)
<!-- RESEARCH: Narrow scope is competitive advantage. Competing "all BaaS platforms" courses are too shallow. -->

**Competitive Advantages to Preserve:**
- **ICP Specificity:** All examples in React/Next.js context (don't dilute with Vue/Angular)
  <!-- RESEARCH: Generic examples weaken positioning. Competitors try to serve everyone, serve no one well. -->
- **Practice Density:** Maintain 60/40 practice/theory ratio (don't add theory-heavy modules)
  <!-- RESEARCH: Practice-first is differentiator. Resist temptation to "cover more concepts". -->
- **Production Focus:** No toy examples allowed (every project must be production-viable)
  <!-- RESEARCH: Quality over quantity. Competitors have 40 lessons of toys. We have 20 lessons of real apps. -->
```

---

### STEP 4: Add New Section 9 - Market Research Summary

**Append this section to COURSE-BRIEF.md:**

```markdown
---

## 9. Market Research Summary (Auto-Generated)

**Research Date:** {YYYY-MM-DD}
**Competitive Courses Analyzed:** {count}
**Research Duration:** {minutes} minutes

---

### 📊 Key Market Insights

1. **{insight_1}**
   Example: "8/12 courses are lecture-heavy (>60% theory) - students complain 'not practical enough'"

2. **{insight_2}**
   Example: "Only 2/12 courses cover production deployment - top requested feature in reviews"

3. **{insight_3}**
   Example: "No courses specifically target frontend → fullstack transition (underserved ICP)"

---

### 🎯 Differentiation Strategy

**Positioning Statement:**
{positioning_statement_from_differentiation_md}

**Differentiation Dimensions:**

| Dimension | Our Approach | Competitor Approach | Advantage |
|-----------|--------------|---------------------|-----------|
| **Audience** | Frontend devs → fullstack | Generic "all developers" | Relevance & ICP fit |
| **Practice** | 60% hands-on, 40% theory | 70% theory, 30% practice | Practicality |
| **Resources** | Templates + checklists | Video-only | Completeness |
| **Voice** | Casual, story-driven | Formal, lecture-style | Engagement |
| **Scope** | Production-ready patterns | Toy examples | Real-world value |

---

### 🔍 Content Gaps Identified (Integrated into Course)

**P0 Gaps (Must Address):**
- ✅ {gap_topic_1} → Added to Module {X}, Lesson {Y}
- ✅ {gap_topic_2} → New Module {Z} created

**P1 Gaps (Should Address):**
- ✅ {gap_topic_3} → Enhanced Lesson {A} with deeper coverage
- ✅ {gap_topic_4} → Added to Learning Objectives

**P2 Gaps (Future Consideration):**
- ⏳ {gap_topic_5} → Noted for v2.0 expansion

---

### 💪 Competitive Advantages

1. **{advantage_1}**
   Source: {market-analysis | content-gaps | differentiation}.md

2. **{advantage_2}**
   Source: {market-analysis | content-gaps | differentiation}.md

3. **{advantage_3}**
   Source: {market-analysis | content-gaps | differentiation}.md

---

### 📈 Market Positioning

**Market Maturity:** {Emerging | Growing | Mature | Saturated}
**Competitive Intensity:** {Low | Medium | High}
**Opportunity Rating:** {Low | Medium | High}

**Recommended Price Point:** ${amount}
**Justification:** {rationale_from_market_analysis}

---

### 🔗 Full Research Reports

📄 **Detailed Analysis:** outputs/courses/{slug}/research/
  - market-analysis.md - Competitive landscape (12 courses analyzed)
  - content-gaps.md - Gap analysis with priorities (P0/P1/P2)
  - differentiation.md - Positioning strategy & unique angles
  - sources.md - Course references & URLs

---

**Research Quality Metrics:**
- Courses Analyzed: {count} ✅ (target: ≥8)
- Content Gaps Found: {count} ✅ (target: ≥3)
- Differentiation Angles: {count} ✅ (target: ≥3)
- Positioning Statement: Created ✅

---

*This section was auto-generated by market-research task and integrated by reformulate-course-brief task.*
```

---

### STEP 5: Generate Change Summary & Save

**5.1. Calculate Diff Summary:**
```yaml
action: calculate_changes
compare:
  - COURSE-BRIEF-ORIGINAL.md
  - COURSE-BRIEF.md (reformulated, not yet saved)
output: change_summary
```

**Change Summary Format:**
```markdown
📊 COURSE-BRIEF Reformulation Summary

**Sections Modified:**
- ✅ Section 1 (Basic Info): Subtitle refined, competitive context added
- ✅ Section 2 (ICP): Pain points validated, 1 new pain point added
- ✅ Section 3 (Content): 3 gap topics added, 1 new module created
- ✅ Section 4 (Voice): Differentiation emphasis added
- ✅ Section 5 (Format): Practice/theory ratio inverted (market insight)
- ✅ Section 6 (Commercial): Pricing refined ($89 → $79), positioning statement updated
- ✅ Section 7 (Success Metrics): 3 differentiation KPIs added
- ✅ Section 8 (Constraints): Competitive advantages noted
- 🆕 Section 9 (Market Research): New section created (auto-generated)

**Key Changes:**
- 📈 Learning Objectives: 3 → 6 (added 3 gap topics)
- 📈 Modules: 2 → 3 (added production deployment module)
- 📈 Differentiation: Positioning statement refined
- 📈 Pricing: $89 → $79 (market-informed adjustment)
- 📈 Competitive Context: Added throughout (12 research annotations)

**Preserved:**
- ✅ Original vision & core objectives
- ✅ User's teaching approach & voice
- ✅ Initial ICP definition (validated & enhanced)
```

**5.2. Save Reformulated COURSE-BRIEF:**
```yaml
action: save_file
file_path: outputs/courses/{slug}/COURSE-BRIEF.md
content: {reformulated_course_brief_with_section_9}
```

**5.3. Display Summary to User:**
```
✅ COURSE-BRIEF REFORMULATED!

📄 Files:
  ✅ COURSE-BRIEF.md (reformulated - ready for curriculum)
  ✅ COURSE-BRIEF-ORIGINAL.md (backup - preserved)

📊 Changes Made:
  - 9 sections total (8 original + 1 new research summary)
  - 3 gap topics integrated into objectives
  - 1 new module created (production deployment)
  - Positioning statement refined
  - 12 research annotations added

🔍 Review:
  - Open outputs/courses/{slug}/COURSE-BRIEF.md
  - Compare with COURSE-BRIEF-ORIGINAL.md
  - Validate all changes align with your vision

✅ Ready for next step: Generate Curriculum
```

---

## 🎛️ Reformulation Modes

### Mode: Greenfield

**Focus:** Enhance initial vision with market intelligence

**Specific Actions:**
- Validate user's objectives against market gaps
- Add gap topics to preliminary outline
- Refine positioning based on competitive analysis
- Suggest duration/pricing adjustments

**Preserves:**
- User's core vision
- Original teaching approach
- Initial ICP definition

---

### Mode: Brownfield

**Focus:** Modernize legacy course with market insights + legacy comparison

**Specific Actions:**
- Compare legacy structure with competitive patterns
- Identify modernization opportunities
- Validate auto-extracted ICP against market
- Highlight legacy advantages (unique topics)

**Additional Section 9 Content:**
```markdown
### Legacy vs. Market Comparison

**Topics in Legacy but NOT in Competitors (Unique Advantages):**
- {legacy_topic_1} - PRESERVE (competitive advantage)
- {legacy_topic_2} - PRESERVE (students value this)

**Topics in Competitors but NOT in Legacy (Gaps to Add):**
- {gap_topic_1} (P0) - ADD during modernization
- {gap_topic_2} (P1) - CONSIDER adding

**Modernization Opportunities:**
- {modernization_1} - Update teaching approach (legacy is lecture-heavy)
- {modernization_2} - Add hands-on exercises (legacy lacks practice)
- {modernization_3} - Include production deployment (new market expectation)
```

---

## 🔧 Error Handling

### Error 1: Research Files Missing
```
❌ ERROR: Market research incomplete

Missing files:
  - outputs/courses/{slug}/research/content-gaps.md

Action Required:
1. Run @course-architect → *market-research {slug}
2. Ensure all 4 reports are generated
3. Re-run reformulate-course-brief

Cannot reformulate without complete market intelligence.
```

### Error 2: COURSE-BRIEF Invalid Format
```
❌ ERROR: COURSE-BRIEF.md format invalid

Issues detected:
  - Missing Section 3 (Content & Pedagogy)
  - Section 2 (ICP) is empty

Action Required:
1. Complete all 8 sections of COURSE-BRIEF.md
2. Validate required fields are filled
3. Re-run reformulate-course-brief

Cannot reformulate incomplete brief.
```

### Error 3: No Gap Topics Found
```
⚠️ WARNING: No gap topics identified in research

This may indicate:
  - Highly saturated market (no differentiation opportunities)
  - Research depth too shallow (increase to "Deep Dive")
  - Course topic very niche (blue ocean scenario)

Proceeding with reformulation but differentiation may be limited.
Recommend manual review of positioning strategy.
```

---

## 📊 Success Criteria

### Reformulation Quality:

**Content Integration:**
- ✅ ≥ 3 gap topics integrated into Section 3 (objectives/outline)
- ✅ Positioning statement refined in Section 6
- ✅ ≥ 10 research annotations (`<!-- RESEARCH: ... -->`) throughout
- ✅ Section 9 complete with all subsections

**Preservation:**
- ✅ All original objectives preserved (can add, not remove)
- ✅ User's voice/style maintained in Section 4
- ✅ Core ICP definition intact (can enhance, not replace)

**Strategic Optimization:**
- ✅ Competitive context added (how we differ)
- ✅ Market-informed pricing/duration
- ✅ Differentiation dimensions clear
- ✅ Gap topics prioritized (P0/P1 integrated)

---

## 📝 Example Output Comparison

### Before Reformulation (Original):

```markdown
## 3. Content & Pedagogy

### Learning Objectives
1. Build authentication with Supabase Auth
2. Design database schemas
3. Implement real-time features

### Preliminary Outline
- Module 1: Fundamentals (3 lessons)
- Module 2: Core Features (5 lessons)
```

### After Reformulation:

```markdown
## 3. Content & Pedagogy

### Learning Objectives

**Core Objectives (Original):**
1. Build authentication with Supabase Auth
2. Design database schemas
3. Implement real-time features

**New Objectives (From Gap Analysis):**
4. **Deploy production Supabase apps with CI/CD**
   <!-- RESEARCH: Gap topic (P0) - Only 2/12 courses cover deployment. Top student request. -->

5. **Architect row-level security policies**
   <!-- RESEARCH: Gap topic (P1) - Mentioned in 4/12 courses but always superficial. -->

### Preliminary Outline

**Module 1: Fundamentals** (3 lessons)
- 1.1: What is Supabase **(and when to use it)**
  <!-- RESEARCH: Added decision framework - gap (P1) -->
- 1.2: Setup & First Project
- 1.3: **Understanding Supabase Architecture**
  <!-- RESEARCH: NEW - Depth gap. Competitors skip architecture explanation. -->

**Module 2: Core Features** (5 lessons)
[... existing lessons ...]

**Module 3: Production Deployment** (NEW)
<!-- RESEARCH: New module for P0 gap. No competitor has dedicated deployment module. -->
- 3.1: Deployment strategies
- 3.2: CI/CD with GitHub Actions
- 3.3: Monitoring & production debugging
```

---

## 🔗 Integration Points

### Called By:
- `greenfield-course.yaml` (after market-research, before generate-curriculum)
- `brownfield-course.yaml` (after market-research, before generate-curriculum)

### Requires:
- `COURSE-BRIEF.md` (initial version, 8 sections)
- `research/` folder (4 markdown reports)

### Feeds Into:
- `generate-curriculum` task (uses reformulated COURSE-BRIEF.md)
- User manual review (checkpoint before curriculum)

---

**End of Task Definition**

*Filename: `expansion-packs/creator-os/tasks/reformulate-course-brief.md`*
*Version: 1.0.0*
*Last Updated: 2025-10-20*
*Author: CreatorOS Team*
