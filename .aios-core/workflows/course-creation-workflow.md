# Course Creation Workflow

**Version:** 1.0
**Purpose:** End-to-end workflow for creating high-quality educational courses
**Owner:** Product Owner (PO) + Course Creator
**Total Duration:** 8-12 hours (for 2-hour course) | 15-25 hours (for 5-hour course)

---

## 🎯 Workflow Overview

This workflow covers the complete course creation lifecycle from ideation to launch.

**Phases:**
1. **Discovery & Validation** (10% of time) - Research, brief, go/no-go
2. **Content Creation** (60% of time) - Lessons, assessments, resources
3. **Quality Assurance** (20% of time) - QA, revisions, optimization
4. **Launch Preparation** (10% of time) - Marketing, platform setup, beta

**Key Principle:** Each phase has a **checkpoint** that must be passed before proceeding.

---

## 📊 Time Estimation Guide

| Course Duration | Discovery | Creation | QA | Launch Prep | **Total** |
|----------------|-----------|----------|----|-----------|----|
| 2-hour course | 1h | 6h | 2h | 1h | **10h** |
| 5-hour course | 2h | 12h | 4h | 2h | **20h** |
| 10-hour course | 3h | 24h | 8h | 4h | **39h** |

**Note:** Times assume experienced creator. First course may take 1.5-2x longer.

---

## 🔍 Phase 1: Discovery & Validation

**Goal:** Validate market need and prepare comprehensive course brief
**Duration:** 1-3 hours
**Output:** Course Brief + Pre-Creation Research Report

### **Step 1.1: Pre-Creation Research (30-45 min)**

**Action:** Execute Pre-Creation Research from Course Research Framework

**Workflow:**
```bash
# Navigate to research framework
.aios-core/workflows/course-research-framework.md

# Execute Phase 1: Pre-Creation Research
# - 5 searches (market, pedagogy, competition, tools, engagement)
# - Document findings in PRE-CREATION-RESEARCH.md
```

**Deliverable:** `docs/courses/[course-name]/PRE-CREATION-RESEARCH.md`

**Checkpoint 1.1:**
- [ ] All 5 research areas completed
- [ ] Market pain points identified (minimum 3)
- [ ] Competitive differentiation clear
- [ ] Tools validated as current
- [ ] Engagement tactics selected

**If FAIL:** Re-research or pivot to different course topic

---

### **Step 1.2: Course Brief Creation (30-45 min)**

**Action:** Create comprehensive course brief using template

**Template:** `.aios-core/templates/course-brief.md`

**What to Define:**
- **Target Audience** - Who, age, background, current struggle
- **Learning Outcomes** - What they'll be able to do after
- **Course Structure** - Modules, lessons, assessments
- **Unique Angle** - How this differs from competitors
- **Commercial Model** - Pricing, platform, upsells
- **Success Metrics** - Completion %, NPS, revenue targets

**Deliverable:** `docs/courses/[course-name]/COURSE-BRIEF.md`

**Checkpoint 1.2:**
- [ ] Target audience clearly defined
- [ ] Learning outcomes measurable and achievable
- [ ] Course structure logical and progressive
- [ ] Unique angle compelling
- [ ] Commercial viability validated

**If FAIL:** Revise brief until stakeholders approve

---

### **Step 1.3: Go/No-Go Decision (15 min)**

**Decision Criteria:**

| Criterion | Threshold | Status |
|-----------|-----------|--------|
| Market demand evident | 3+ pain points found | ✅/❌ |
| Competitive differentiation | Clear unique angle | ✅/❌ |
| Technical feasibility | Tools accessible & current | ✅/❌ |
| Commercial viability | Price point validated | ✅/❌ |
| Instructor expertise | Can teach authentically | ✅/❌ |

**Decision:**
- **GO (5/5 ✅)** → Proceed to content creation
- **PIVOT (3-4/5 ✅)** → Adjust brief, re-validate
- **NO-GO (<3/5 ✅)** → Abandon or fundamentally rethink

---

## ✍️ Phase 2: Content Creation

**Goal:** Create all course content (lessons, assessments, resources)
**Duration:** 6-24 hours (depending on course length)
**Output:** Complete course content ready for QA

### **Step 2.1: Curriculum Outline (1-2 hours)**

**Action:** Create detailed outline with learning objectives per lesson

**Structure:**
```yaml
modules:
  - id: module-1
    title: "Module Title"
    duration: "30 minutes"
    objective: "Students will be able to [action verb] [skill/concept]"
    lessons:
      - id: 1.1
        title: "Lesson Title"
        duration: "10 minutes"
        objective: "Students will [specific outcome]"
        activities:
          - type: "explanation"
            content: "Metaphor introduction"
          - type: "demonstration"
            content: "Hands-on example"
          - type: "practice"
            content: "Student does it"
      - id: 1.2
        [...]
```

**Deliverable:** `docs/courses/[course-name]/curriculum.yaml`

**Checkpoint 2.1:**
- [ ] All modules have clear objectives
- [ ] Lessons follow logical progression (easy → hard)
- [ ] Activities balance theory/practice (20/80 or 30/70)
- [ ] Duration estimates realistic

---

### **Step 2.2: Lesson Content Creation (4-18 hours)**

**Action:** Write lesson content using instructor's voice

**Per Lesson Process:**
1. **Start with metaphor** - Concrete analogy to introduce concept
2. **Explain theory** - Minimal, just enough to understand
3. **Demonstrate** - Show it working (code, screenshots, video script)
4. **Student practice** - Step-by-step hands-on exercise
5. **Checkpoint** - Quiz or micro-project to validate understanding
6. **Transition** - Connect to next lesson

**Voice Guidelines:**
- Write as instructor would speak
- Use "you" (direct address)
- Include instructor's signature phrases
- Tell stories or give real-world examples
- Celebrate small wins
- Acknowledge struggles

**Deliverable:** `docs/courses/[course-name]/lessons/[X.Y-lesson-name].md`

**Checkpoint 2.2 (Per Lesson):**
- [ ] Learning objective achieved by end
- [ ] Hands-on practice included
- [ ] Voice sounds like instructor (not AI)
- [ ] Technical accuracy verified
- [ ] Troubleshooting section present

**Quality Bar:** Don't move to next lesson until current lesson passes checkpoint

---

### **Step 2.3: Mid-Creation Research Checkpoint (15-20 min)**

**When:** After ~50% of lessons complete

**Action:** Execute Mid-Creation Research from Course Research Framework

**Focus:**
- Validate technical approach still current
- Check for tool updates that affect content
- Identify common confusion patterns from students

**Deliverable:** `docs/courses/[course-name]/MID-CREATION-RESEARCH.md`

**Checkpoint 2.3:**
- [ ] No breaking changes in tools discovered
- [ ] Technical approach validated
- [ ] Adjustments made to existing lessons if needed

---

### **Step 2.4: Assessment Creation (1-2 hours)**

**Action:** Create quizzes and final project

**Quiz Design (Per Module):**
- 5-10 questions
- Mix of multiple choice, true/false, fill-in-blank
- Questions test application, not just recall
- Include answer explanations (why correct, why incorrect)

**Final Project Design:**
- Authentic real-world scenario
- Combines all skills learned
- Clear rubric or success criteria
- Estimated completion time stated

**Deliverable:**
- `docs/courses/[course-name]/assessments/quiz-module-[X].yaml`
- `docs/courses/[course-name]/assessments/projeto-final.md`

**Checkpoint 2.4:**
- [ ] All modules have assessments
- [ ] Questions aligned to learning objectives
- [ ] Final project is achievable within time
- [ ] Rubrics/answer keys provided

---

### **Step 2.5: Resource Creation (1-3 hours)**

**Action:** Create supporting materials

**Common Resources:**
- **Setup Checklist** - Tool installation/configuration
- **Cheat Sheet** - Quick reference for syntax/commands
- **Template Library** - Reusable code/prompts
- **Troubleshooting Guide** - Common errors + solutions
- **Further Learning** - Books, articles, communities

**Deliverable:** `docs/courses/[course-name]/resources/[resource-name].md`

**Checkpoint 2.5:**
- [ ] Minimum 3 resources created
- [ ] Resources directly support course content
- [ ] Resources are actionable (not just links)

---

### **Step 2.6: README & Course Outline (30-60 min)**

**Action:** Create student-facing course overview

**README Contents:**
- Course description & outcomes
- Target audience
- Prerequisites
- Course structure (modules/lessons)
- Tools required
- How to use the course
- Instructor bio
- Support/community info

**Deliverable:**
- `docs/courses/[course-name]/README.md`
- `docs/courses/[course-name]/course-outline.md`

**Checkpoint 2.6:**
- [ ] README clearly explains value proposition
- [ ] Course structure visible at a glance
- [ ] Prerequisites stated
- [ ] Next steps clear ("Start with Lesson 1.1")

---

## ✅ Phase 3: Quality Assurance

**Goal:** Validate quality, fix issues, optimize for engagement
**Duration:** 2-8 hours
**Output:** QA Report + Optimized Content

### **Step 3.1: Post-Creation Research (30-45 min)**

**Action:** Execute Post-Creation Research from Course Research Framework

**Focus:**
- Latest engagement tactics
- Accessibility best practices
- Pricing validation
- Launch strategies

**Deliverable:** `docs/courses/[course-name]/POST-CREATION-RESEARCH.md`

**Checkpoint 3.1:**
- [ ] Priority engagement tactics identified
- [ ] Accessibility gaps documented
- [ ] Pricing validated against market
- [ ] Launch plan drafted

---

### **Step 3.2: Course QA Execution (1-2 hours)**

**Action:** Execute Course QA Checklist

**Workflow:**
```bash
# Use QA checklist
.aios-core/checklists/course-qa-checklist.md

# Evaluate all 5 dimensions:
# 1. Pedagogical Quality (20 pts)
# 2. Voice & Tone Fidelity (20 pts)
# 3. Technical Accuracy (20 pts)
# 4. Assessment Quality (20 pts)
# 5. Commercial Viability (20 pts)
```

**Deliverable:** `docs/courses/[course-name]/QA-REPORT.md`

**Checkpoint 3.2:**
- [ ] QA Report generated
- [ ] Overall score calculated
- [ ] All issues categorized (Critical/High/Medium/Low)
- [ ] Launch decision made

**Quality Bar:**
- **90-100:** Launch immediately
- **80-89:** Launch with minor post-launch fixes
- **70-79:** Fix critical/high issues first
- **<70:** Major revision required

---

### **Step 3.3: Issue Resolution (1-4 hours)**

**Action:** Fix critical and high-priority issues from QA Report

**Prioritization:**
1. **Critical** - Fix all (blocks student progress)
2. **High** - Fix all (significantly degrades experience)
3. **Medium** - Fix if time allows (minor degradation)
4. **Low** - Defer to post-launch (nice-to-have)

**Deliverable:** Updated lesson files

**Checkpoint 3.3:**
- [ ] All critical issues resolved
- [ ] All high issues resolved
- [ ] Medium/low issues documented for post-launch

**Quality Bar:** Re-run QA if significant changes made (aim for 90+ score)

---

### **Step 3.4: Optimization Implementation (30-90 min)**

**Action:** Implement high-priority optimizations from Post-Creation Research

**Common Optimizations:**
- Add Course Buddy section (accountability)
- Add gamification (achievements, progress tracking)
- Add mobile guidance (when to use mobile vs. desktop)
- Add alternative tool references (Bolt alternatives)
- Enhance accessibility (alt text, clear headings)

**Deliverable:** Updated README and lesson files

**Checkpoint 3.4:**
- [ ] Priority 1 optimizations implemented
- [ ] Expected impact documented
- [ ] No regressions introduced

---

## 🚀 Phase 4: Launch Preparation

**Goal:** Prepare for successful course launch
**Duration:** 1-4 hours
**Output:** Launch-ready course + marketing assets

### **Step 4.1: Platform Setup (30-60 min)**

**Action:** Configure course on delivery platform

**Tasks:**
- Upload all content
- Configure lesson sequencing
- Set up assessments/quizzes
- Test student flow (enroll → complete → certificate)
- Set pricing and payment
- Create landing page

**Deliverable:** Live course on platform (unpublished)

**Checkpoint 4.1:**
- [ ] All content uploaded correctly
- [ ] Student flow tested end-to-end
- [ ] Payment processing tested
- [ ] Mobile experience verified

---

### **Step 4.2: Marketing Asset Creation (30-60 min)**

**Action:** Create launch assets

**Assets:**
- Course thumbnail/cover image
- Course trailer (video script or recording)
- Landing page copy
- Email sequence (welcome, lesson reminders, completion)
- Social media posts (launch announcement)

**Deliverable:** `docs/courses/[course-name]/marketing/`

**Checkpoint 4.2:**
- [ ] All assets created
- [ ] Copy matches course voice
- [ ] CTAs clear and compelling

---

### **Step 4.3: Beta Testing (Optional, 2-4 hours)**

**Action:** Run with 3-5 beta students

**Process:**
1. Recruit beta testers (ideal students)
2. Give free access
3. Collect feedback (survey + interview)
4. Identify confusion points
5. Make final adjustments

**Deliverable:** Beta feedback report + final adjustments

**Checkpoint 4.3:**
- [ ] Beta feedback collected
- [ ] Critical issues fixed
- [ ] Testimonials collected (for marketing)

---

### **Step 4.4: Final Launch Checklist (15 min)**

**Pre-Launch Checklist:**
- [ ] QA score 80+ (ideally 90+)
- [ ] All critical/high issues resolved
- [ ] Course uploaded to platform
- [ ] Payment processing tested
- [ ] Landing page live
- [ ] Email sequences configured
- [ ] Social media scheduled
- [ ] Support/community channel ready
- [ ] Instructor available for launch week
- [ ] Analytics tracking configured

**Launch Decision:** GO / DELAY

**If GO:** Publish course and execute launch plan

---

## 📊 Definition of Done

A course is considered **"Done"** when:

1. **Content Complete:**
   - [ ] All lessons written and reviewed
   - [ ] All assessments created with rubrics
   - [ ] All resources provided
   - [ ] README and outline finalized

2. **Quality Validated:**
   - [ ] QA score 80+ (90+ preferred)
   - [ ] All critical/high issues resolved
   - [ ] Voice fidelity 85%+ across lessons
   - [ ] Technical accuracy verified (all code tested)

3. **Research-Driven:**
   - [ ] Pre-creation research completed
   - [ ] Mid-creation research completed
   - [ ] Post-creation research completed
   - [ ] Optimizations implemented

4. **Launch-Ready:**
   - [ ] Platform configured
   - [ ] Marketing assets created
   - [ ] Payment processing live
   - [ ] Support channel ready

5. **Stakeholder Approved:**
   - [ ] Instructor sign-off
   - [ ] PO sign-off
   - [ ] Beta feedback positive (if applicable)

---

## 🔄 Workflow Checkpoints Summary

| Phase | Checkpoint | Pass Criteria | If Fail |
|-------|-----------|---------------|---------|
| 1.1 | Research Complete | 5/5 research areas done | Re-research gaps |
| 1.2 | Brief Approved | All sections complete, stakeholder sign-off | Revise brief |
| 1.3 | Go/No-Go | 5/5 criteria met | Pivot or abandon |
| 2.1 | Curriculum Valid | Logical progression, clear objectives | Restructure |
| 2.2 | Lesson Quality | Each lesson passes 5-point check | Revise lesson |
| 2.3 | Mid-Creation | No blockers found | Adjust content |
| 2.4 | Assessments Aligned | Questions test objectives | Rewrite questions |
| 2.5 | Resources Useful | Minimum 3 actionable resources | Create more |
| 2.6 | README Clear | Students understand course value | Clarify copy |
| 3.1 | Post-Research | Optimizations identified | N/A |
| 3.2 | QA Score | 80+ (90+ preferred) | Fix issues |
| 3.3 | Issues Resolved | All critical/high fixed | Continue fixing |
| 3.4 | Optimizations Done | Priority 1 implemented | Implement more |
| 4.1 | Platform Ready | Student flow tested | Fix config |
| 4.2 | Marketing Ready | Assets created | Create missing |
| 4.3 | Beta Positive | No critical feedback | Address issues |
| 4.4 | Launch Checklist | All items checked | Fix blockers |

---

## 💡 Pro Tips

**Efficiency:**
- Batch similar tasks (write all lesson intros, then all hands-on sections)
- Use templates religiously (don't reinvent structure)
- Set timers to avoid perfectionism (80/20 rule)

**Quality:**
- Read lessons aloud to check voice
- Test all code/instructions yourself
- Get second pair of eyes on technical content

**Engagement:**
- Front-load value (first lesson must deliver win)
- Celebrate progress visibly (checkboxes, achievements)
- Reduce friction (clear next steps, troubleshooting)

**Common Pitfalls:**
- ❌ Skipping research (creates misaligned course)
- ❌ Writing all content before QA (costly revisions)
- ❌ Ignoring voice consistency (feels generic)
- ❌ Launching without beta (miss critical confusion points)

---

## 📚 Related Resources

- **Course Brief Template:** `.aios-core/templates/course-brief.md`
- **QA Checklist:** `.aios-core/checklists/course-qa-checklist.md`
- **QA Report Template:** `.aios-core/templates/course-qa-report.md`
- **Research Framework:** `.aios-core/workflows/course-research-framework.md`
- **Retrospective Template:** `.aios-core/templates/course-retrospective.md`

---

*Course Creation Workflow v1.0 | Product Owner Framework | AIOS-FULLSTACK*
