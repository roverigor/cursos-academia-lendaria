# Architecture Documents Archive

**Archive Date:** 2025-01-14
**Reason:** Superseded by final 3-agent architecture
**Current Architecture:** See `FINAL-ARCHITECTURE.md`

---

## Archived Documents

### 1. WORKFLOW-ARCHITECTURE.md
**Status:** ❌ Superseded
**Date Created:** 2025-01-14 (initial exploration)
**Reason Archived:** Initial 5-agent parallel design rejected during architecture refinement

**What it proposed:**
- 5 parallel specialized agents
- Framework-specific extraction
- Complex orchestration

**Why rejected:**
- Over-engineered for lite version
- Didn't match real-world psychologist model
- User feedback led to simplification

---

### 2. AGENT-FRAMEWORK-MAPPING.md
**Status:** ❌ Superseded
**Date Created:** 2025-01-14 (Iteration 1)
**Reason Archived:** 23-agent micro-specialization rejected by user

**What it proposed:**
- 23 specialized agents (one per trait/type)
- Examples:
  - @openness-expert
  - @conscientiousness-expert
  - @type5-expert (Enneagram)
  - @ISTJ-expert (MBTI)

**Why rejected:**
- **User feedback:** "We don't have 23 different psychologists in reality"
- Violates real-world validation principle
- Over-complexity (23× agents to maintain)
- Micro-specialization doesn't match domain expertise

**User quote:**
> "pensa em um teste ou em humano avaliador, nao tem um avalaidor para cada tipo de eneagrama é um valiador para o eneagrama todo"
>
> Translation: "Think about a test or human evaluator - there isn't one evaluator for each Enneagram type, there's ONE evaluator for the whole Enneagram"

---

### 3. CORRECT-ARCHITECTURE.md
**Status:** ❌ Superseded
**Date Created:** 2025-01-14 (Iteration 2)
**Reason Archived:** 7-agent framework expert design replaced by final 3-agent task-driven design

**What it proposed:**
- 7 framework expert agents:
  - @bigfive-expert
  - @hexaco-expert
  - @mbti-expert
  - @enneagram-expert
  - @disc-expert
  - @values-expert
  - @quality-validator

**Why rejected:**
- **User feedback:** "Maybe we just need ONE psychologist agent that has the framework, playbook, tasks and checklists"
- Still duplicates "expert" concept unnecessarily
- One psychologist uses multiple frameworks in reality
- Not scalable (adding framework = adding agent)

**User quote:**
> "talvez podemos ter só um agente psicologo que tem o framework, playbook, tasks e checklists e com isso consegue avaliar todos"
>
> Translation: "Maybe we can have just one psychologist agent that has the framework, playbook, tasks and checklists and with this can evaluate everything"

---

### 4. ZERO-INFERENCE-FRAGMENTS.md
**Status:** ❌ Superseded
**Date Created:** 2025-01-14 (Iteration 3A - Fragment refinement)
**Reason Archived:** Replaced by MIU-FRAGMENT-ARCHITECTURE.md (interpretability over atomicity)

**What it proposed:**
- Zero-inference fragments (NO categorization)
- Framework-agnostic evidence extraction
- Minimal context preservation
- "6-Year-Old Test" for observability

**Why superseded (not rejected - evolved):**
- **User insight:** "ele deve ser o atomo" (it must be the atom)
- **User critical correction:** "don't just agree, let's discuss this, bring other analyses"
- Critical analysis revealed: "Atomic" fragments too small (not interpretable)
- Evolution to **MIU (Minimal Interpretable Unit)** - preserves causal/temporal relationships
- Zero-inference principle PRESERVED in MIU (all good ideas kept)

**Key difference:**
- **ZERO-INFERENCE**: Fragment = "I avoid delegating" + separate "I've been burned before" (loses causality)
- **MIU**: Fragment = "I avoid delegating because I've been burned before" (preserves WHY)

**User decision:**
- Question: "What's more expensive - fragment too small (not interpretable) or too large (multiple ideas)?"
- Answer: **Too small is worse** (Error A > Error B)
- Example: Long causal chain → User chose **1 large MIU** over 4 atomic fragments

**What carried forward to MIU:**
- ✅ Zero inference (no categorization, no trait labels)
- ✅ Framework-agnostic (100-year reusability)
- ✅ Observable facts only (structure.words, structure.verbs, etc.)
- ✅ "6-Year-Old Test" validation
- ✅ Separation of evidence (fragments) from interpretation (detectors)

**What changed in MIU:**
- ✅ Variable fragment size (1-3 clauses vs always 1 clause)
- ✅ Preserve causal relationships ("because", "since", "so that")
- ✅ Preserve temporal relationships ("when", "while", "after")
- ✅ Split on contrasts ("but", "however") - still preserved
- ✅ "Psychologist Test": Can fragment be interpreted in isolation? (94% pass rate)

**User quote:**
> "sim para todas" (yes to all - when asked if storage efficiency, elegance, uniformity all matter)
> "Erro A" (Error A is more expensive - too small fragments)
> "1" (Option 1 - keep entire causal chain as ONE fragment)

**Evolution status:** ✅ EVOLVED (not rejected)
**Current specification:** `/docs/MIU-FRAGMENT-ARCHITECTURE.md`

---

## Evolution Timeline

```
Iteration 1: 23 Agents (Micro-Specialization)
├── One agent per trait/type
├── User: "We don't have 23 psychologists"
└── ❌ Rejected

Iteration 2: 7 Agents (Framework Experts)
├── One agent per framework
├── User: "A psychologist doesn't become different people for different tests"
└── ❌ Rejected

Iteration 3: 3 Agents (Universal + Task-Driven) ✅ APPROVED
├── @fragment-extractor: Universal extraction
├── @psychologist: Universal analyst (uses tasks/frameworks)
├── @quality-assurance: Universal validator
└── Frameworks = tasks/knowledge bases (not agents)
```

---

## Key Learnings

### Learning 1: Real-World Validation
**Principle:** If the architecture doesn't mirror how things work in the real world, it's probably wrong.

**Application:** One psychologist, multiple methodologies → ONE @psychologist agent, MULTIPLE framework tasks

---

### Learning 2: Configuration Over Duplication
**Principle:** One flexible component > Many rigid components

**Application:**
- ❌ Different frameworks = Different agents
- ✅ Different frameworks = Different tasks for same agent

---

### Learning 3: Challenge Complexity
**Principle:** Default to skepticism of complexity. Simple solutions are preferred.

**Application:**
- 23 agents → 7 agents → 3 agents (87% reduction)
- 46 files to maintain → 14 files → 3 + N tasks (scalable)

---

## Current Architecture (Final)

See: `/docs/FINAL-ARCHITECTURE.md`

**Summary:**
```markdown
Agent 1: @fragment-extractor
  └── Extracts universal behavioral fragments (ONCE)

Agent 2: @psychologist (UNIVERSAL)
  ├── Uses multiple frameworks via tasks:
  │   ├── tasks/analyze-bigfive.md
  │   ├── tasks/analyze-hexaco.md
  │   ├── tasks/analyze-mbti.md
  │   └── tasks/analyze-enneagram.md
  └── Knowledge bases: data/frameworks/

Agent 3: @quality-assurance
  └── Validates outputs (cross-framework consistency)

Total: 3 agents (vs 23, vs 7)
Scalability: Infinite (add task, not agent)
```

---

## Decision Principles Reference

These decisions are documented in `/docs/DECISION-PRINCIPLES.md`:

- **Principle 4:** Real-World Validation
- **Principle 5:** Configuration Over Duplication
- **Principle 8:** Challenge Complexity

Mental frameworks applied:
- First Principles Thinking
- Essentialism
- Maximum Modularization

---

**Archive Maintainer:** Dev Lead
**Last Updated:** 2025-01-14
**Purpose:** Historical record of architecture evolution and decision-making process
