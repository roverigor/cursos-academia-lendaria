---
task-id: validate-reformed-brief
name: Validate Reformed Course Brief
type: atomic
responsibility: Validate COURSE-BRIEF.md AFTER market research reformulation
duration: 30-45 seconds
agent: course-architect

token-estimation:
  input: 8000              # Read COURSE-BRIEF + research reports
  processing: 4000         # Integration analysis
  output: 2000             # Validation report
  total_min: 12000
  total_max: 16000
  factors:
    - "Research integration quality"
    - "Differentiation strategy application"
    - "Brief evolution analysis"
    - "Alignment preservation check"
  alternatives:
    subagent_savings: "N/A (atomic task)"

user-confirmation-required: false
---

# Task: Validate Reformed Course Brief

**Type:** Atomic Task
**Responsibility:** Validate COURSE-BRIEF.md quality AFTER reformulation with market research insights
**Duration:** 30-45 seconds

---

## Purpose

**POST-RESEARCH QUALITY CHECK:** Ensure market research insights were APPLIED (not just appended) to COURSE-BRIEF before curriculum generation.

**Prevents:**
- Generic research copy-paste (insights listed but not integrated)
- Differentiation strategy ignored in course design
- Gap topics added to Section 9 but missing from outline
- Research done but wasted (not actionable)

**Economics:**
- ✅ Validates reformed brief: ~15K tokens (~$0.15)
- ❌ Skip validation, bad integration: Waste 300K tokens on misaligned curriculum (~$3.00)
- **ROI:** 2,000% cost savings per integration failure caught

---

## When to Execute

**MANDATORY checkpoint:**
1. **After reformulate-course-brief task:** BEFORE generate-curriculum
2. **Manual request:** User runs `*validate-reformed-brief {slug}`

**DO NOT execute:**
- Before market research (use `validate-course-brief` instead)
- During brownfield mode (different validation logic)

---

## Inputs

- `slug` (required) - Course identifier
- `--compare` (optional) - Show diff between original and reformed brief
- `--verbose` (optional) - Show detailed integration analysis

---

## Validation Checks

### 1. Research Integration Quality
**Target:** ≥80/100 (Gap topics INTEGRATED, not just listed)

**Validates:**

**Gap Topics Integration (40 pts):**
- ✅ Gap topics from `content-gaps.md` appear in Section 3.3 (Outline)
- ✅ Gap topics have lessons/modules assigned (not just mentioned)
- ✅ Gap priorities respected (P0/P1 topics prioritized)
- ❌ Gaps only in Section 9 summary (not integrated)
- ❌ All gaps listed but none in outline

**Example GOOD Integration:**
```markdown
## Section 3.3: Outline Preliminar

MÓDULO 1: Fundamentos
  1.1 - Introdução ao Clone IA
  1.2 - Configuração de Ambiente
  1.3 - Primeiros Prompts Efetivos ← GAP TOPIC (from research)

MÓDULO 2: Construção
  2.1 - Arquitetura do Clone
  2.2 - Coleta de Dados Pessoais ← GAP TOPIC (from research)
  ...
```

**Example BAD Integration:**
```markdown
## Section 9: Market Research Summary
Gap Topics to Include:
- Primeiros prompts efetivos (P0)
- Coleta de dados pessoais (P1)

## Section 3.3: Outline Preliminar
[... outline unchanged, gaps NOT added to lessons ...]
```

**Differentiation Application (30 pts):**
- ✅ Positioning statement from `differentiation.md` reflected in subtitle/tagline
- ✅ Unique angles applied to teaching style (Section 4)
- ✅ Differentiation embedded in content strategy (not just commercial section)
- ❌ Differentiation only in Section 9 (not applied)

**Market Insights Application (30 pts):**
- ✅ Competitive pricing informed by `market-analysis.md`
- ✅ Format/delivery adjusted based on market patterns
- ✅ ICP refined based on underserved segments identified
- ❌ Research copied but brief unchanged

**Scoring:**
```
integration_score = gap_integration + differentiation_app + insights_app
```

**Thresholds:**
- ✅ EXCELLENT: ≥90/100
- ✅ GOOD: 80-89/100
- ⚠️ MARGINAL: 70-79/100 (research done but weakly applied)
- ❌ POOR: <70/100 (research wasted, not integrated)

---

### 2. Positioning Clarity Check
**Target:** Clear, actionable positioning statement

**Validates:**

**Positioning Statement Quality:**
- ✅ Exists in Section 9 (Market Research Summary)
- ✅ Specific (not "better/faster than competition")
- ✅ Rooted in differentiation insights
- ✅ Actionable for curriculum design
- ✅ Reflected in course subtitle/tagline

**Example GOOD Positioning:**
```
"Unlike lecture-heavy competitors, this course is 80% hands-on with real
client scenarios. Students build 3 production clones by end, not just
understand theory. Designed for busy founders who need results in days,
not weeks."
```

**Example BAD Positioning:**
```
"This course is better and more comprehensive than others."
(Vague, generic, not actionable)
```

**Check:**
- Positioning statement present? (Yes/No)
- Specific and differentiated? (Yes/No)
- Actionable for design? (Yes/No)
- Reflected in brief? (Yes/No)

**Scoring:**
- All 4: ✅ CLEAR
- 3/4: ⚠️ ACCEPTABLE
- <3: ❌ UNCLEAR

---

### 3. Brief Evolution Analysis
**Target:** Reformed brief is IMPROVED (not just longer)

**Validates:**

**Meaningful Changes:**
- ✅ Outline has new modules/lessons (gap topics added)
- ✅ Subtitle/tagline updated with differentiation
- ✅ Teaching style refined (Section 4)
- ✅ Commercial positioning sharpened (Section 6)
- ❌ Only Section 9 added (no changes to Sections 1-6)

**Quality Improvement:**
- ✅ ICP more specific (market insights applied)
- ✅ Objectives refined (gap topics integrated)
- ✅ Differentiation angles visible throughout
- ❌ Brief just longer, not better

**Check Original vs. Reformed:**
```yaml
changes:
  section_1_basic_info:
    changed: true
    improvement: "Subtitle updated with unique positioning"

  section_3_outline:
    changed: true
    improvement: "3 gap topics added as new lessons (2.2, 3.1, 3.4)"

  section_4_voice:
    changed: true
    improvement: "Teaching style emphasizes hands-on (differentiation)"

  section_6_commercial:
    changed: true
    improvement: "Pricing positioned vs. market (mid-tier, value-focused)"

  section_9_research:
    changed: true
    improvement: "Added comprehensive market summary"
```

**Scoring:**
- ≥4 sections meaningfully improved: ✅ EVOLVED
- 2-3 sections improved: ⚠️ PARTIAL
- <2 sections improved: ❌ STAGNANT

---

### 4. Alignment Preservation Check
**Target:** Core vision preserved (not lost in research)

**Validates:**

**Core Elements Intact:**
- ✅ Original ICP core maintained (refinements OK, but not replaced)
- ✅ Original learning objectives still present (additions OK)
- ✅ Original transformation vision preserved
- ❌ Original brief completely overwritten (vision lost)

**Example GOOD Preservation:**
```
ORIGINAL ICP: "Busy founders, 35-45, seeking AI automation"
REFORMED ICP: "Busy founders, 35-45, in SaaS/consulting, seeking AI
automation to scale without hiring" ← REFINED, not replaced
```

**Example BAD Preservation:**
```
ORIGINAL ICP: "Busy founders, 35-45, seeking AI automation"
REFORMED ICP: "Students and hobbyists learning AI for fun" ← REPLACED!
```

**Check:**
- ICP core preserved? (Yes/No)
- Objectives preserved? (Yes/No)
- Transformation vision intact? (Yes/No)

**Scoring:**
- All 3: ✅ PRESERVED
- 2/3: ⚠️ PARTIALLY PRESERVED
- <2: ❌ VISION LOST

---

### 5. Gap Priority Respect
**Target:** P0/P1 gaps addressed, P2 gaps optional

**Validates:**

**Priority Handling:**
- ✅ All P0 (Must address) gaps integrated into outline
- ✅ Most P1 (Should address) gaps integrated
- ✅ P2 (Nice to have) gaps considered but optional
- ❌ P0 gap ignored (critical miss)

**Read from `content-gaps.md`:**
```yaml
gaps:
  - topic: "Error handling strategies"
    priority: P0  # MUST be in outline
    integrated: true  # ✅ Found in Module 2

  - topic: "Advanced prompt optimization"
    priority: P1  # SHOULD be in outline
    integrated: true  # ✅ Found in Module 3

  - topic: "Multi-language support"
    priority: P2  # NICE TO HAVE
    integrated: false  # OK, not critical
```

**Scoring:**
- All P0 + ≥80% P1 integrated: ✅ RESPECTED
- All P0 + ≥50% P1: ⚠️ ACCEPTABLE
- Any P0 missing: ❌ VIOLATED

---

### 6. Actionability Check
**Target:** Reformulated brief ready for curriculum generation

**Validates:**

**Ready for Next Step:**
- ✅ Outline complete with gap topics
- ✅ Differentiation strategy clear
- ✅ Positioning informs curriculum design
- ✅ No contradictions introduced by research
- ✅ Research summary actionable (not just data dump)

**Example ACTIONABLE Research Summary:**
```markdown
## 9. Market Research Summary

### Differentiation Strategy:
"80% hands-on vs. 30% industry average" ← ACTIONABLE for lesson design

### Gap Topics to Include:
- Module 2: Error handling (P0) ← SPECIFIC placement
- Module 3: Prompt optimization (P1) ← SPECIFIC placement

### Competitive Advantages:
- Real client scenarios (source: founder's 50+ deployments)
- Production-ready templates (not toy examples)
```

**Example NOT ACTIONABLE:**
```markdown
## 9. Market Research Summary

We found 15 competitive courses. Some are expensive, some are cheap.
Topics vary. We should differentiate somehow.
← Vague, not actionable!
```

**Scoring:**
- All 5 elements actionable: ✅ READY
- 3-4 elements: ⚠️ NEEDS WORK
- <3 elements: ❌ NOT READY

---

## Output Report

### Example Output (PASS):

```
📊 REFORMED BRIEF VALIDATION REPORT
Course: clone-ia-express
Reformed: 2025-10-28 14:45
Original Brief: COURSE-BRIEF-ORIGINAL.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ RESEARCH INTEGRATION QUALITY
   Score: 88/100 (GOOD)

   Gap Integration: 38/40 ✅
     - 4/4 P0 gaps integrated into outline
     - 3/3 P1 gaps integrated
     - Gaps have specific lesson assignments

   Differentiation Application: 28/30 ✅
     - Positioning in subtitle: ✅ "80% hands-on, production-ready clones"
     - Teaching style updated: ✅ Section 4 emphasizes real scenarios
     - Format adjusted: ✅ Microlearning based on market insights

   Market Insights Application: 22/30 ⚠️
     - Pricing informed: ✅ R$297 (mid-tier positioning)
     - ICP refined: ✅ Added "SaaS/consulting founders"
     - Format: ⚠️ Could apply more market patterns

✅ POSITIONING CLARITY
   Status: ✅ CLEAR

   Positioning Statement:
   "Unlike lecture-heavy competitors (avg 30% practice), this course
   is 80% hands-on with real client scenarios from 50+ deployments.
   Build 3 production clones in 3h, not just theory. For busy founders
   who need results in days, not weeks."

   ✅ Specific and differentiated
   ✅ Actionable for curriculum design
   ✅ Reflected in subtitle and teaching style

✅ BRIEF EVOLUTION ANALYSIS
   Status: ✅ EVOLVED

   Meaningful changes: 5/6 sections improved
     ✅ Section 1: Subtitle updated with differentiation
     ✅ Section 3: 4 gap topics added to outline (2.2, 2.3, 3.1, 3.4)
     ✅ Section 4: Teaching style emphasizes hands-on approach
     ✅ Section 6: Pricing positioned vs. market (mid-tier value)
     ✅ Section 9: Comprehensive market summary added
     ⏭️  Section 2: ICP refined (minor improvement)

✅ ALIGNMENT PRESERVATION
   Status: ✅ PRESERVED

   Core elements intact:
     ✅ ICP core: "Busy founders, 35-45" maintained (refined, not replaced)
     ✅ Objectives: All 8 original objectives preserved + 2 added
     ✅ Transformation: "Clone in 3h" vision intact

✅ GAP PRIORITY RESPECT
   Status: ✅ RESPECTED

   Gap handling:
     ✅ 4/4 P0 gaps integrated (100%)
     ✅ 3/3 P1 gaps integrated (100%)
     ⏭️  1/2 P2 gaps integrated (50% - optional, OK)

✅ ACTIONABILITY CHECK
   Status: ✅ READY

   Ready for curriculum generation:
     ✅ Outline complete with gap topics
     ✅ Differentiation strategy clear
     ✅ Positioning informs design
     ✅ No new contradictions
     ✅ Research summary actionable

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 OVERALL RESULT: ✅ PASS

📊 INTEGRATION SCORE: 88/100 (GOOD)

✅ SAFE TO PROCEED with curriculum generation.

📋 RECOMMENDATIONS:
  1. Consider applying more market format patterns (e.g., cohort-based if competitors lack it)
  2. Brief is solid - proceed with confidence

📊 CHANGES SUMMARY:
  - Gap topics integrated: 7/7 (100%)
  - Sections improved: 5/6
  - Positioning clarity: CLEAR
  - Original vision: PRESERVED

💾 Report saved: outputs/courses/clone-ia-express/validation-reformed-brief-report.md
```

---

### Example Output (FAIL):

```
📊 REFORMED BRIEF VALIDATION REPORT
Course: marketing-digital
Reformed: 2025-10-28 15:10
Original Brief: COURSE-BRIEF-ORIGINAL.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❌ RESEARCH INTEGRATION QUALITY
   Score: 42/100 (POOR)

   Gap Integration: 8/40 ❌
     ❌ 1/4 P0 gaps missing from outline (critical miss!)
     ❌ 0/3 P1 gaps integrated
     ⚠️  Gaps only listed in Section 9, NOT in outline

   Issues:
     🚨 P0 Gap "Instagram Reels strategy" - Listed in Section 9 but
        NO LESSON added to outline
     🚨 P0 Gap "TikTok growth tactics" - Missing entirely
     ⚠️  All gaps in Section 9 summary but outline unchanged

❌ POSITIONING CLARITY
   Status: ❌ UNCLEAR

   Positioning Statement (Section 9):
   "We offer a comprehensive marketing course that covers everything."

   ❌ Generic, not differentiated
   ❌ Not actionable ("comprehensive" means what?)
   ❌ NOT reflected in subtitle (unchanged)

⚠️  BRIEF EVOLUTION ANALYSIS
   Status: ❌ STAGNANT

   Meaningful changes: 1/6 sections
     ⏭️  Section 1: Unchanged
     ⏭️  Section 3: Outline unchanged (gaps NOT added)
     ⏭️  Section 4: Unchanged
     ⏭️  Section 6: Unchanged
     ✅ Section 9: Research summary added

   🚨 Brief is just LONGER, not BETTER!
   🚨 Research done but NOT APPLIED to course design

✅ ALIGNMENT PRESERVATION
   Status: ✅ PRESERVED

   (Original vision intact, but that's because nothing changed!)

❌ GAP PRIORITY RESPECT
   Status: ❌ VIOLATED

   Gap handling:
     ❌ 2/4 P0 gaps missing (50% - CRITICAL!)
     ❌ 0/3 P1 gaps integrated (0%)
     ⏭️  P2 gaps: N/A

   Missing P0 gaps:
     1. Instagram Reels strategy
     2. TikTok growth tactics

❌ ACTIONABILITY CHECK
   Status: ❌ NOT READY

   Issues blocking curriculum generation:
     ❌ Gap topics not integrated
     ❌ Positioning too vague
     ❌ Research summary is data dump (not actionable)
     ❌ Differentiation strategy unclear

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 OVERALL RESULT: ❌ FAIL

📊 INTEGRATION SCORE: 42/100 (POOR)

🚨 CANNOT PROCEED - Research done but NOT applied to brief.

📋 CRITICAL ACTIONS REQUIRED:
  1. ✅ Add P0 gap "Instagram Reels strategy" as lesson in Module 2 or 3
  2. ✅ Add P0 gap "TikTok growth tactics" as lesson in Module 2 or 3
  3. ✅ Integrate all 3 P1 gaps into outline
  4. ✅ Rewrite positioning statement (be specific, not generic)
  5. ✅ Update subtitle/tagline to reflect differentiation
  6. ✅ Apply differentiation insights to teaching style (Section 4)
  7. ✅ Make Section 9 summary actionable (not just data dump)

💡 RECOMMENDATIONS:
  - Don't just copy research to Section 9 - APPLY it!
  - Gap topics must appear in Section 3.3 Outline (not just Section 9)
  - Positioning: "We cover everything" → Be specific about what's different
  - Consider using reformulate-course-brief task again with better prompts

⏱️  ESTIMATED TIME TO FIX: 20-40 minutes

When fixed, re-run: @course-architect *validate-reformed-brief marketing-digital
```

---

## Validation Levels

### ✅ PASS (Integration Score ≥ 80)
**Criteria:**
- Research Integration: ≥80/100
- Positioning: CLEAR
- Brief Evolution: EVOLVED (≥4 sections improved)
- Alignment: PRESERVED
- Gap Priorities: RESPECTED (all P0 + ≥80% P1)
- Actionability: READY

**Action:** ✅ Proceed to generate-curriculum

---

### ⚠️ MARGINAL PASS (Integration Score 70-79)
**Criteria:**
- Research Integration: 70-79/100
- Positioning: ACCEPTABLE
- Brief Evolution: PARTIAL (2-3 sections improved)
- Gap Priorities: ACCEPTABLE (all P0 + ≥50% P1)

**Action:**
- ⚠️ Can proceed but curriculum may lack differentiation
- Recommend fixing gaps first
- User decides: fix now or accept weaker positioning

---

### ❌ FAIL (Integration Score < 70)
**Criteria:**
- Research Integration: <70/100
- Positioning: UNCLEAR
- Brief Evolution: STAGNANT (<2 sections improved)
- Gap Priorities: VIOLATED (P0 gaps missing)
- Actionability: NOT READY

**Action:**
- 🚨 BLOCK workflow progression
- Provide actionable fix list
- Re-run reformulate-course-brief if needed

---

## Execution

### Script Location
```bash
expansion-packs/creator-os/scripts/validate_reformed_brief.py
```

### Command
```bash
python expansion-packs/creator-os/scripts/validate_reformed_brief.py "$slug" ${compare:+--compare} ${verbose:+--verbose}
```

### Exit Codes
- `0` - PASS (integration ≥80)
- `1` - FAIL (integration <70)
- `2` - MARGINAL PASS (integration 70-79)
- `3` - Error (file not found, parsing error)

---

## Integration with Workflow

### Greenfield Workflow Integration

**BEFORE (current):**
```
market-research → reformulate-course-brief → generate-curriculum
                   ↓
                   (No validation - bad integration wastes 300K tokens)
```

**AFTER (proposed):**
```
market-research
  ↓
reformulate-course-brief
  ↓
🔍 validate-reformed-brief (15K tokens)
  ↓
❌ FAIL - "Gaps not integrated, positioning unclear"
  ↓
User fixes (10-20 min) OR re-runs reformulate with better context
  ↓
🔍 validate-reformed-brief
  ↓
✅ PASS - Proceed to generate-curriculum
```

**Savings:** 285K tokens per bad reformulation caught = **$2.85**

---

## Error Handling

### Research Files Missing
```
❌ Error: Market research files not found

Expected files:
  - outputs/courses/meu-curso/research/content-gaps.md
  - outputs/courses/meu-curso/research/differentiation.md
  - outputs/courses/meu-curso/research/market-analysis.md

Run market research first: @course-architect *market-research meu-curso
```

### Original Brief Missing
```
❌ Error: COURSE-BRIEF-ORIGINAL.md not found

Expected at: outputs/courses/meu-curso/COURSE-BRIEF-ORIGINAL.md

This file should be created automatically by reformulate-course-brief task.
If missing, reformulation may not have been run correctly.
```

---

## Success Criteria

- ✅ Validation completes in <60 seconds
- ✅ Integration quality scored (0-100)
- ✅ Gap topics verified in outline (not just Section 9)
- ✅ Differentiation application checked
- ✅ Original vision preservation validated
- ✅ Clear pass/fail with actionable fixes
- ✅ Report saved to course folder

---

## Notes

**Why this matters:**
- Research is expensive (50K tokens) - must be APPLIED, not wasted
- Common failure: Copy gaps to Section 9 but don't integrate into outline
- Bad reformulation → Curriculum misses differentiation → Commodity course
- **Economics:** 15K validation saves 285K curriculum regeneration

**When to skip:**
- Never! This is MANDATORY post-research check
- Exception: Brownfield mode (different validation)

---

**Status:** ✅ Ready (needs script implementation)
**Created:** 2025-10-28
**Version:** 1.0
