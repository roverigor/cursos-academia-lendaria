# Course QA Checklist

**Version:** 1.0
**Purpose:** Comprehensive quality assurance checklist for educational course content
**When to Use:** After course content is created, before launch
**Owner:** Product Owner (PO)

---

## 📋 How to Use This Checklist

1. **Run after content is complete** - All lessons, assessments, and resources created
2. **Score each dimension** - Use the scoring rubric below (0-20 points each)
3. **Document issues found** - Categorize as Critical/High/Medium/Low
4. **Generate QA Report** - Use template at `.aios-core/templates/course-qa-report.md`
5. **Decide launch readiness** - 80+ = Ready, 70-79 = Fix critical issues first, <70 = Major revision needed

---

## 🎯 Quality Dimensions (100 Points Total)

### **1. Pedagogical Quality (20 points)**

**Evaluate:**
- [ ] **Learning Objectives** - Clear, measurable, achievable for target audience
- [ ] **Scaffolding** - Progressive complexity (easy → intermediate → advanced)
- [ ] **Bloom's Taxonomy Alignment** - Activities match cognitive levels (Remember → Create)
- [ ] **Engagement Techniques** - Stories, examples, hands-on practice integrated
- [ ] **Knowledge Retention** - Spaced repetition, summaries, checkpoints present

**Scoring Rubric:**
- **18-20:** Exceptional pedagogy, follows best practices flawlessly
- **15-17:** Strong pedagogy, minor gaps in scaffolding or engagement
- **12-14:** Adequate pedagogy, some lessons lack clarity or progression
- **9-11:** Weak pedagogy, significant gaps in structure or objectives
- **0-8:** Poor pedagogy, needs major restructuring

**Score:** ___/20

**Issues Found:**
- [ ] Critical: _______________
- [ ] High: _______________
- [ ] Medium: _______________
- [ ] Low: _______________

---

### **2. Voice & Tone Fidelity (20 points)**

**Evaluate:**
- [ ] **Instructor Voice Consistency** - Writing matches instructor's natural speaking style
- [ ] **Tone Appropriateness** - Matches target audience expectations (professional/casual/playful)
- [ ] **Personality Presence** - Instructor's unique traits visible throughout
- [ ] **Authenticity** - Feels genuine, not AI-generated or templated
- [ ] **Engagement Language** - Uses "you", stories, direct address effectively

**Scoring Rubric:**
- **18-20:** 90%+ voice fidelity, indistinguishable from instructor's natural style
- **15-17:** 80-89% fidelity, mostly authentic with occasional generic sections
- **12-14:** 70-79% fidelity, voice present but inconsistent across lessons
- **9-11:** 60-69% fidelity, frequently feels templated or generic
- **0-8:** <60% fidelity, lacks instructor personality

**Score:** ___/20

**Voice Fidelity by Lesson:**
- Lesson 1.1: ___%
- Lesson 1.2: ___%
- Lesson 2.1: ___%
- (Continue for all lessons)

**Issues Found:**
- [ ] Critical: _______________
- [ ] High: _______________
- [ ] Medium: _______________
- [ ] Low: _______________

---

### **3. Technical Accuracy (20 points)**

**Evaluate:**
- [ ] **Code Examples** - All code snippets are correct, tested, and functional
- [ ] **Tool Instructions** - Step-by-step instructions are accurate (buttons, menus, workflows)
- [ ] **Version Currency** - Tools/APIs/libraries are current (2025 standards)
- [ ] **Error Handling** - Common errors anticipated and troubleshooting provided
- [ ] **Links & Resources** - All external links work, resources are accessible

**Scoring Rubric:**
- **18-20:** 0 technical errors, all examples tested and current
- **15-17:** 1-2 minor errors (typos, outdated UI references)
- **12-14:** 3-5 errors, some examples untested but likely work
- **9-11:** 6-10 errors, significant issues that block student progress
- **0-8:** 10+ errors, code broken or outdated

**Score:** ___/20

**Technical Issues Found:**
- [ ] Critical (blocks progress): _______________
- [ ] High (confusing/frustrating): _______________
- [ ] Medium (minor inaccuracy): _______________
- [ ] Low (typo/cosmetic): _______________

---

### **4. Assessment Quality (20 points)**

**Evaluate:**
- [ ] **Alignment to Objectives** - Quiz/project questions test stated learning outcomes
- [ ] **Difficulty Progression** - Assessments match lesson complexity
- [ ] **Actionability** - Projects are clear, specific, achievable within time constraints
- [ ] **Feedback Mechanisms** - Answer explanations or rubrics provided
- [ ] **Authenticity** - Assessments mimic real-world application

**Scoring Rubric:**
- **18-20:** Exceptional assessments, perfectly aligned and realistic
- **15-17:** Strong assessments, minor gaps in feedback or alignment
- **12-14:** Adequate assessments, some questions vague or off-target
- **9-11:** Weak assessments, significant misalignment or unclear expectations
- **0-8:** Poor assessments, not testing right skills or too vague

**Score:** ___/20

**Assessment Issues:**
- [ ] Critical: _______________
- [ ] High: _______________
- [ ] Medium: _______________
- [ ] Low: _______________

---

### **5. Commercial Viability (20 points)**

**Evaluate:**
- [ ] **Value Proposition** - Clear ROI/outcomes communicated (what students gain)
- [ ] **Competitive Differentiation** - Unique angle or approach vs. existing courses
- [ ] **Pricing Alignment** - Content quality matches intended price point
- [ ] **Marketing Hooks** - Compelling stories, stats, or social proof present
- [ ] **Completion Optimization** - Engagement tactics to drive high completion rates

**Scoring Rubric:**
- **18-20:** Highly marketable, strong hooks, clear differentiation
- **15-17:** Marketable, good value prop, minor gaps in hooks
- **12-14:** Adequate marketability, value prop present but not compelling
- **9-11:** Weak marketability, unclear differentiation or value
- **0-8:** Poor marketability, no clear reason to buy

**Score:** ___/20

**Commercial Issues:**
- [ ] Critical: _______________
- [ ] High: _______________
- [ ] Medium: _______________
- [ ] Low: _______________

---

## 📊 Total Score Calculation

| Dimension | Score | Weight | Weighted Score |
|-----------|-------|--------|----------------|
| Pedagogical Quality | ___/20 | 1.0 | ___ |
| Voice & Tone Fidelity | ___/20 | 1.0 | ___ |
| Technical Accuracy | ___/20 | 1.0 | ___ |
| Assessment Quality | ___/20 | 1.0 | ___ |
| Commercial Viability | ___/20 | 1.0 | ___ |
| **TOTAL** | **___/100** | | |

---

## 🚦 Launch Decision Matrix

| Score Range | Decision | Action Required |
|-------------|----------|-----------------|
| **90-100** | ✅ READY TO LAUNCH | Launch immediately, exceptional quality |
| **80-89** | ✅ READY TO LAUNCH | Launch with minor post-launch optimizations |
| **70-79** | ⚠️ FIX CRITICAL ISSUES | Fix all critical/high issues before launch |
| **60-69** | ⚠️ MAJOR REVISION NEEDED | Significant rework required, do not launch |
| **<60** | 🛑 DO NOT LAUNCH | Complete redesign needed |

---

## 🔍 Issue Categorization Guide

**Critical (Must Fix Before Launch):**
- Broken code that blocks student progress
- Factually incorrect information that misleads
- Missing core content (lessons, key assessments)
- Security vulnerabilities in code examples

**High (Should Fix Before Launch):**
- Confusing instructions that frustrate students
- Voice inconsistency in multiple lessons
- Assessment misalignment with objectives
- Weak value proposition or unclear outcomes

**Medium (Fix Post-Launch or in V1.1):**
- Minor pedagogical gaps (missing summary, weak transition)
- Voice inconsistency in single lesson/section
- Non-critical typos or formatting issues
- Suboptimal engagement tactics

**Low (Nice to Have):**
- Cosmetic improvements (better images, formatting)
- Additional examples or bonus content
- Enhanced marketing copy
- Minor optimizations

---

## 📝 QA Report Template

After completing this checklist, generate a QA Report using:

**Template:** `.aios-core/templates/course-qa-report.md`

**Include:**
1. Executive Summary (Overall Score, Launch Readiness)
2. Dimension-by-Dimension Analysis
3. Issues Found (categorized by severity)
4. Recommendations (prioritized)
5. Exceptional Elements (what's working brilliantly)

---

## ✅ Final Checklist

Before declaring QA complete:

- [ ] All 5 dimensions scored
- [ ] All issues documented with severity
- [ ] Total score calculated
- [ ] Launch decision made (Ready/Fix/Revise/Stop)
- [ ] QA Report generated from template
- [ ] Stakeholders informed of findings
- [ ] Action plan created for identified issues

---

## 📚 Related Resources

- **QA Report Template:** `.aios-core/templates/course-qa-report.md`
- **Course Creation Workflow:** `.aios-core/workflows/course-creation-workflow.md`
- **Research Framework:** `.aios-core/workflows/course-research-framework.md`

---

*Course QA Checklist v1.0 | Product Owner Framework | AIOS-FULLSTACK*
