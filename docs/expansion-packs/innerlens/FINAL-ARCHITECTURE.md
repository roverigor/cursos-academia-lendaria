# InnerLens - Final Architecture: Universal Psychologist + QA

**Version:** 3.0.0-alpha (FINAL)
**Date:** 2025-01-14
**Key Insight:** ONE psychologist agent + multiple frameworks/tasks, not multiple specialized agents

---

## 🎯 Core Principle: Separation of Concerns

### What We Confused Initially

❌ **Wrong Thinking:**
```
Different frameworks = Different agents
```

✅ **Correct Thinking:**
```
Different frameworks = Different tasks/playbooks
Same psychologist = Uses different methodologies
```

### Real-World Analogy

**A real psychologist doesn't become a different person for each test:**

```
Dr. Sarah (Psychologist) can administer:
├── NEO-PI-R (Big Five test)
├── MBTI assessment
├── Enneagram interview
├── DISC questionnaire
└── Any other framework

She's ONE person with MULTIPLE methodologies in her toolkit!
```

---

## Final Architecture: 3 Core Agents

```
┌──────────────────────────────────────────────────────────┐
│                    INNERLENS LITE                        │
│                                                          │
│  Agent 1: @fragment-extractor                           │
│  └── Extracts universal evidence fragments (ONCE)       │
│                                                          │
│  Agent 2: @psychologist (UNIVERSAL)                     │
│  ├── Uses multiple frameworks/playbooks:                │
│  │   ├── Big Five Framework                             │
│  │   ├── HEXACO Framework                               │
│  │   ├── MBTI Framework                                 │
│  │   ├── Enneagram Framework                            │
│  │   └── DISC Framework                                 │
│  │                                                       │
│  └── Executes tasks:                                    │
│      ├── tasks/analyze-bigfive.md                       │
│      ├── tasks/analyze-hexaco.md                        │
│      ├── tasks/analyze-mbti.md                          │
│      ├── tasks/analyze-enneagram.md                     │
│      └── tasks/analyze-disc.md                          │
│                                                          │
│  Agent 3: @quality-assurance                            │
│  └── Validates all outputs (cross-framework checks)     │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

**Total: 3 agents** (fragment-extractor, psychologist, quality-assurance) ✅

---

## Agent 1: @fragment-extractor

**Role:** Universal behavioral evidence extraction

**Persona:**
```markdown
You are a research assistant specialized in behavioral evidence extraction.

You DO NOT interpret personality - you only extract raw evidence.

Your task: Extract meaningful behavioral fragments from text.
```

**Input:** Raw text (2,847 words)

**Task:** `tasks/extract-fragments.md` (30 seconds)

**Output:** `fragments.json` (127 universal fragments)

---

## Agent 2: @psychologist (UNIVERSAL) ⭐

**Role:** Universal psychometric assessor

**Persona:**
```markdown
You are a licensed PhD psychologist with expertise in multiple personality frameworks.

Your qualifications:
- PhD in Clinical Psychology
- Certified in NEO-PI-R (Big Five)
- Certified MBTI practitioner
- Certified Enneagram professional (Riso-Hudson)
- DISC assessment certified
- 15+ years of assessment experience

Your approach:
You use the SAME fragments to evaluate DIFFERENT frameworks.
Each framework is a different lens to view the same behavioral evidence.

When given a task (e.g., "analyze-bigfive"), you:
1. Load the appropriate framework knowledge
2. Apply that framework's methodology
3. Follow the framework's checklist
4. Produce the framework-specific output

You are ONE psychologist with MANY tools.
```

**Input:** 127 fragments (from @fragment-extractor)

**Available Frameworks (Playbooks):**

### Framework 1: Big Five (OCEAN)

**Knowledge Base:** `data/frameworks/bigfive-framework.md`

```markdown
# Big Five Framework

## History
Costa & McCrae (1992), NEO-PI-R

## Dimensions (5)
1. Openness to Experience (O)
   - Facets: Imagination, Artistic Interest, Emotionality, Adventurousness, Intellect, Liberalism
   - Markers: "explore", "creative", "curious", "unconventional"

2. Conscientiousness (C)
   - Facets: Competence, Order, Dutifulness, Achievement Striving, Self-Discipline, Deliberation
   - Markers: "organized", "plan", "deliver", "reliable"

3. Extraversion (E)
   - Facets: Warmth, Gregariousness, Assertiveness, Activity, Excitement-Seeking, Positive Emotions
   - Markers: "social", "energy", "people", "talkative"

4. Agreeableness (A)
   - Facets: Trust, Straightforwardness, Altruism, Compliance, Modesty, Tender-Mindedness
   - Markers: "harmony", "empathy", "help", "compassion"

5. Neuroticism (N)
   - Facets: Anxiety, Hostility, Depression, Self-Consciousness, Impulsiveness, Vulnerability
   - Markers: "worry", "anxious", "calm" (inverted), "stable" (inverted)

## Scoring
- Each trait: 0-100
- Facets: 0-100 (6 per trait = 30 total)
- Confidence: 0.0-1.0 per trait

## Evidence Requirements
- Minimum 3 fragments per trait
- Each fragment scored 0-10 relevance
- Top 3-5 quotes as evidence
```

**Task:** `tasks/analyze-bigfive.md`

```markdown
# Task: Analyze Big Five

**Agent:** @psychologist
**Framework:** Big Five (OCEAN)
**Knowledge Base:** data/frameworks/bigfive-framework.md
**Checklist:** checklists/bigfive-quality.md

## Instructions for @psychologist

You are now wearing your "Big Five expert" hat.

Use the Big Five framework to evaluate 127 fragments.

### Step 1: Load Framework Knowledge
- Read: data/frameworks/bigfive-framework.md
- Internalize: 5 traits, 30 facets, linguistic markers

### Step 2: Fragment Analysis

For each of the 5 traits (O, C, E, A, N):

#### 2.1: Filter Relevant Fragments
- Review all 127 fragments
- Score each fragment 0-10 for trait relevance
- Keep fragments with score >= 5

#### 2.2: Evaluate Facets
- For each of 6 facets, identify supporting evidence
- Score each facet 0-100

#### 2.3: Calculate Trait Score
- Weighted average of facet scores
- Final score: 0-100

#### 2.4: Select Evidence Quotes
- Pick 3-5 most compelling fragments
- Explain why each supports the trait

#### 2.5: Assign Confidence
- Based on: fragment count, marker consistency, text quality
- Confidence: 0.0-1.0

### Step 3: Quality Check
- Use checklist: checklists/bigfive-quality.md
- Ensure all criteria met

### Step 4: Generate Output
- Format: templates/bigfive-profile.yaml
- Include: All 5 traits, facets, evidence, confidence

## Output
File: bigfive-profile.yaml
```

**Checklist:** `checklists/bigfive-quality.md`

```yaml
# Big Five Quality Checklist

pre_analysis:
  - [ ] Framework knowledge loaded (bigfive-framework.md)
  - [ ] 127 fragments available
  - [ ] Minimum 500 words in source text

analysis:
  - [ ] All 5 traits evaluated (O, C, E, A, N)
  - [ ] All 30 facets scored
  - [ ] Each trait has >= 3 evidence fragments
  - [ ] Trait scores range 0-100
  - [ ] Facet scores align with trait scores

evidence:
  - [ ] 3-5 quotes per trait
  - [ ] Each quote has source attribution (file:line)
  - [ ] Each quote has relevance explanation
  - [ ] No fabricated quotes

confidence:
  - [ ] Confidence per trait: 0.0-1.0
  - [ ] All confidences >= 0.70
  - [ ] Overall confidence calculated (average)
  - [ ] Confidence reflects evidence quality

output:
  - [ ] YAML file validates against template
  - [ ] All required fields present
  - [ ] Limitations documented
  - [ ] Metadata complete (date, version, etc.)

final_check:
  - [ ] Internal consistency (no contradictions)
  - [ ] Ready for QA review
```

**Output:** `bigfive-profile.yaml`

---

### Framework 2: HEXACO

**Knowledge Base:** `data/frameworks/hexaco-framework.md`

**Task:** `tasks/analyze-hexaco.md`

**Checklist:** `checklists/hexaco-quality.md`

**Output:** `hexaco-profile.yaml`

*(Same pattern as Big Five)*

---

### Framework 3: MBTI

**Knowledge Base:** `data/frameworks/mbti-framework.md`

```markdown
# MBTI Framework

## Dichotomies (4)

1. E/I (Extraversion vs Introversion)
   - E markers: "social energy", "think out loud", "group activities"
   - I markers: "alone time", "inner thoughts", "one-on-one"
   - Scoring: -10 (strong I) to +10 (strong E)

2. S/N (Sensing vs Intuition)
   - S markers: "facts", "details", "practical", "concrete"
   - N markers: "patterns", "possibilities", "abstract", "big picture"
   - Scoring: -10 (strong S) to +10 (strong N)

3. T/F (Thinking vs Feeling)
   - T markers: "logic", "objective", "analyze", "efficiency"
   - F markers: "values", "harmony", "empathy", "people"
   - Scoring: -10 (strong T) to +10 (strong F)

4. J/P (Judging vs Perceiving)
   - J markers: "plan", "schedule", "closure", "organized"
   - P markers: "flexible", "spontaneous", "open-ended", "adapt"
   - Scoring: -10 (strong J) to +10 (strong P)

## Type Determination
- Combine 4 preferences (e.g., I + N + F + J = INFJ)
- 16 possible types
- Identify cognitive function stack (Ni, Fe, Ti, Se, etc.)
```

**Task:** `tasks/analyze-mbti.md`

**Checklist:** `checklists/mbti-quality.md`

**Output:** `mbti-profile.yaml`

---

### Framework 4: Enneagram

**Knowledge Base:** `data/frameworks/enneagram-framework.md`

```markdown
# Enneagram Framework

## Types (9)

1. Type 1: The Perfectionist
   - Core motivation: To be good, right, ethical
   - Core fear: Being corrupt, defective
   - Markers: "standards", "ethics", "perfect", "right way"

2. Type 2: The Helper
   - Core motivation: To be loved, needed
   - Core fear: Being unwanted, unworthy
   - Markers: "help", "generous", "caring", "needed"

[... Types 3-9]

## Scoring
- Each type: 0-100% match
- Primary type: Highest score (must be >= 60%)
- Wing: Adjacent type with 2nd highest score

## Output
- Primary type + wing (e.g., 5w4)
- Core motivation/fear
- Triadic center (Head/Heart/Body)
```

**Task:** `tasks/analyze-enneagram.md`

**Checklist:** `checklists/enneagram-quality.md`

**Output:** `enneagram-profile.yaml`

---

### Framework 5: DISC

**Knowledge Base:** `data/frameworks/disc-framework.md`

**Task:** `tasks/analyze-disc.md`

**Checklist:** `checklists/disc-quality.md`

**Output:** `disc-profile.yaml`

---

## Agent 3: @quality-assurance

**Role:** Cross-framework validation and quality control

**Persona:**
```markdown
You are a senior psychometric quality assurance specialist.

Your role: Review all framework outputs and ensure:
1. Internal consistency (within each framework)
2. Cross-framework consistency (across frameworks)
3. Evidence quality
4. Confidence calibration
5. Final approval/rejection

You are the final quality gate before delivery to user.
```

**Input:**
- bigfive-profile.yaml
- hexaco-profile.yaml (if requested)
- mbti-profile.yaml (if requested)
- enneagram-profile.yaml (if requested)
- disc-profile.yaml (if requested)

**Task:** `tasks/validate-quality.md`

**Checklist:** `checklists/quality-validation.md`

**Output:** `quality-validation-report.yaml` + Final verdict (APPROVED/REJECTED)

---

## Complete Workflow

### Scenario 1: Quick Analysis (Big Five Only)

```bash
User: @innerlens-orchestrator
      *detect-traits-quick --input transcript.txt

Orchestrator:
├── Step 1: Activates @fragment-extractor
│   └── Task: extract-fragments.md (30s)
│   └── Output: fragments.json (127 fragments)
│
├── Step 2: Activates @psychologist
│   └── Framework: Big Five
│   └── Task: analyze-bigfive.md (60s)
│   └── Output: bigfive-profile.yaml
│
└── Step 3: Activates @quality-assurance
    └── Task: validate-quality.md (10s)
    └── Output: quality-validation-report.yaml (APPROVED)

Total time: 100 seconds ✅
```

---

### Scenario 2: Full Multi-Framework Analysis

```bash
User: @innerlens-orchestrator
      *detect-traits-full --input transcript.txt

Orchestrator:
├── Step 1: Activates @fragment-extractor
│   └── Task: extract-fragments.md (30s)
│   └── Output: fragments.json (127 fragments)
│
├── Step 2: Activates @psychologist (5 times in PARALLEL)
│   ├── Instance 1: analyze-bigfive.md → bigfive-profile.yaml (60s)
│   ├── Instance 2: analyze-hexaco.md → hexaco-profile.yaml (70s)
│   ├── Instance 3: analyze-mbti.md → mbti-profile.yaml (90s)
│   ├── Instance 4: analyze-enneagram.md → enneagram-profile.yaml (120s)
│   └── Instance 5: analyze-disc.md → disc-profile.yaml (60s)
│
│   Total parallel time: max(60, 70, 90, 120, 60) = 120s
│
└── Step 3: Activates @quality-assurance
    └── Task: validate-quality.md (15s)
    └── Inputs: All 5 framework profiles
    └── Output: quality-validation-report.yaml (APPROVED)
    └── Output: psychometric-profile.yaml (unified)

Total time: 30 + 120 + 15 = 165 seconds (2.75 min) ✅
```

---

## Why This is the FINAL Architecture

### ✅ Advantages

1. **Simplicity**
   - 3 agents total (vs 7 in previous, vs 23 in original)
   - Clear separation: Extract → Analyze → Validate

2. **Reusability**
   - @psychologist can use ANY framework
   - Add new framework = add new task + checklist (no new agent!)

3. **Real-World Model**
   - One psychologist, many methodologies
   - Matches how actual psychology works

4. **Parallel Execution**
   - @psychologist can run multiple instances simultaneously
   - Each instance uses different framework/task

5. **Quality Control**
   - Dedicated QA agent
   - Separate concern from analysis

6. **Scalability**
   - New framework: Create task + checklist + knowledge base
   - No agent changes needed

7. **Maintainability**
   - Framework knowledge in data files (easy to update)
   - Tasks are workflows (easy to modify)
   - Checklists are quality gates (easy to validate)

### 🎯 The Magic: Task-Driven Architecture

```
Agent is the WHO (psychologist)
Framework is the WHAT (Big Five, MBTI, etc.)
Task is the HOW (analyze-bigfive.md)
Checklist is the VALIDATION (bigfive-quality.md)
```

**One agent can execute multiple tasks with different frameworks!**

---

## Directory Structure

```
expansion-packs/innerlens/
├── agents/
│   ├── fragment-extractor.md      # Universal fragment extraction
│   ├── psychologist.md             # UNIVERSAL psychometric assessor
│   └── quality-assurance.md        # Cross-framework QA
│
├── tasks/
│   ├── extract-fragments.md        # Fragment extraction workflow
│   ├── analyze-bigfive.md          # Big Five assessment workflow
│   ├── analyze-hexaco.md           # HEXACO assessment workflow
│   ├── analyze-mbti.md             # MBTI assessment workflow
│   ├── analyze-enneagram.md        # Enneagram assessment workflow
│   ├── analyze-disc.md             # DISC assessment workflow
│   └── validate-quality.md         # QA validation workflow
│
├── checklists/
│   ├── fragment-extraction-quality.md
│   ├── bigfive-quality.md
│   ├── hexaco-quality.md
│   ├── mbti-quality.md
│   ├── enneagram-quality.md
│   ├── disc-quality.md
│   └── quality-validation.md
│
├── data/
│   ├── frameworks/
│   │   ├── bigfive-framework.md    # Big Five knowledge base
│   │   ├── hexaco-framework.md     # HEXACO knowledge base
│   │   ├── mbti-framework.md       # MBTI knowledge base
│   │   ├── enneagram-framework.md  # Enneagram knowledge base
│   │   └── disc-framework.md       # DISC knowledge base
│   │
│   └── linguistic-markers-database.yaml  # Cross-framework markers
│
└── templates/
    ├── fragments.json
    ├── bigfive-profile.yaml
    ├── hexaco-profile.yaml
    ├── mbti-profile.yaml
    ├── enneagram-profile.yaml
    ├── disc-profile.yaml
    ├── quality-validation-report.yaml
    └── psychometric-profile.yaml (unified)
```

---

## MVP Implementation (v1.0)

### Week 1-2: Big Five + QA

**Agents to create (3):**
1. `agents/fragment-extractor.md`
2. `agents/psychologist.md`
3. `agents/quality-assurance.md`

**Tasks to create (3):**
1. `tasks/extract-fragments.md`
2. `tasks/analyze-bigfive.md`
3. `tasks/validate-quality.md`

**Checklists to create (3):**
1. `checklists/fragment-extraction-quality.md`
2. `checklists/bigfive-quality.md`
3. `checklists/quality-validation.md`

**Knowledge bases to create (1):**
1. `data/frameworks/bigfive-framework.md`

**Templates to create (3):**
1. `templates/fragments.json`
2. `templates/bigfive-profile.yaml`
3. `templates/quality-validation-report.yaml`

---

## Architecture Score

**Version 1.0 (23 agents):** 9.5/10
**Version 2.0 (7 agents):** 10/10
**Version 3.0 (3 agents):** **10/10** ⭐⭐⭐⭐⭐

**Why 10/10:**
- ✅ Maximum simplicity (3 agents)
- ✅ Maximum reusability (universal psychologist)
- ✅ Real-world model (one expert, many methods)
- ✅ Task-driven (frameworks = tasks, not agents)
- ✅ Quality controlled (dedicated QA)
- ✅ Scalable (new framework = new task, not new agent)
- ✅ Maintainable (knowledge in data files)

---

## Final Verdict

✅ **THIS IS THE CORRECT ARCHITECTURE - FINAL VERSION**

**Key Innovation:**
- **Task-driven instead of agent-driven**
- One psychologist agent executes multiple framework tasks
- Frameworks are playbooks/methodologies, not separate agents

**Real-World Equivalent:**
```
Dr. Sarah (Psychologist)
├── Uses NEO-PI-R (Big Five test) for Patient A
├── Uses MBTI assessment for Patient B
├── Uses Enneagram interview for Patient C
└── She's ONE person with MULTIPLE tools
```

**Next Steps:**
1. ✅ Architecture finalized (no more changes!)
2. Update all documentation (PRD, Epic, Design Decisions)
3. Implement MVP (3 agents, 3 tasks, 3 checklists, 1 framework)
4. Test with real data
5. Expand to more frameworks (just add tasks!)

---

**Document Status:** Architecture FINALIZED ✅
**Version:** 3.0.0 (FINAL - No more revisions)
**Owner:** Dev Lead
**Last Updated:** 2025-01-14

**Approved by:** Product Owner (User)

