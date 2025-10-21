---
task-id: frameworks-identifier-analysis
name: Mental Frameworks Identification & Latticework Construction
agent: synthesis-expert
version: 3.5.0
purpose: Extract mental models from cognitive analysis and synthesize them into interconnected framework latticework using Munger methodology

workflow-mode: interactive
elicit: false
elicitation-type: none

prerequisites:
  - Phase 3 (Analysis) completed with all artifacts
  - cognitive-architecture.yaml exists
  - behavioral-patterns.yaml exists
  - values-hierarchy.yaml exists (Layer 6)
  - mental-models.yaml exists (Layer 5)
  - decision-architecture.yaml exists

inputs:
  - name: mind_name
    type: string
    required: true

  - name: cognitive_architecture_path
    type: file_path
    default: "outputs/minds/{mind_name}/artifacts/cognitive-architecture.yaml"

  - name: behavioral_patterns_path
    type: file_path
    default: "outputs/minds/{mind_name}/artifacts/behavioral-patterns.yaml"

  - name: values_hierarchy_path
    type: file_path
    default: "outputs/minds/{mind_name}/artifacts/values-hierarchy.yaml"

  - name: mental_models_path
    type: file_path
    default: "outputs/minds/{mind_name}/artifacts/mental-models.yaml"

  - name: minimum_frameworks
    type: integer
    default: 8
    description: Minimum frameworks for solid latticework

outputs:
  - path: "outputs/minds/{mind_name}/synthesis/frameworks-synthesized.yaml"
    description: Complete mental framework latticework with cross-domain validation
    format: yaml
    template: frameworks-synthesized.yaml

validation:
  success-criteria:
    - "Minimum 8 distinct frameworks extracted from source data"
    - "Each framework validated across 2+ domains"
    - "First-principles decomposition performed for all frameworks"
    - "Latticework map shows interconnections between frameworks"
    - "Context boundaries defined (when works vs fails)"
    - "Cross-domain applications validated"
    - "Inversion thinking applied to each framework"

  warning-conditions:
    - "Only 5-7 frameworks identified (borderline latticework)"
    - "Single-domain frameworks without cross-validation"
    - "Missing first-principles decomposition"

  failure-conditions:
    - "Less than 5 frameworks identified"
    - "Frameworks are isolated (no interconnections)"
    - "No cross-domain validation"
    - "No context boundaries defined"

estimated-duration: "4-6 hours for complete latticework construction"
critical-success-factor: "Latticework quality > framework quantity - interconnections matter more than count"
---

# Frameworks Identifier Analysis Task

## Purpose

Extract mental models from cognitive analysis and synthesize them into an interconnected **latticework of frameworks** using Charlie Munger's multi-disciplinary methodology.

**Not a list of frameworks** - a **living knowledge architecture** where models support, contradict, and enhance each other.

**Munger Principle:** *"You need a latticework of mental models in your head. If facts don't hang together on a latticework of theory, you don't have them in a usable form"*

---

## Charlie Munger's Latticework Method

### Core Philosophy

1. **80-90 Models Suffice:** A handful of truly powerful models from major disciplines carry 90% of cognitive freight
2. **Cross-Pollination Gold:** Best insights come from applying Model X from Domain A to Problem Y in Domain B
3. **Inversion Power:** Ask "how would this fail catastrophically?" not just "how does this work?"
4. **Circle of Competence:** Know what you know deeply vs what you've only memorized
5. **Lollapalooza Effects:** Multiple frameworks acting together create extreme outcomes

### The 5-Step Framework Identification Process

```yaml
munger_framework_extraction:
  step_1: Pattern Hunting (find repeating structures)
  step_2: Cross-Domain Mapping (test in 2+ domains)
  step_3: First-Principles Decomposition (reduce to atoms)
  step_4: Interconnection Building (weave latticework)
  step_5: Usability Testing (validate predictive power)
```

---

## Execution Steps

### Phase 1: Pattern Hunting - Raw Framework Extraction (90 min)

**Goal:** Scan cognitive analysis for repeating mental structures

**Method:** Munger's Pattern Recognition

1. **Read all analysis artifacts** with framework detector active:
   - `cognitive-architecture.yaml` - top-level thinking patterns
   - `behavioral-patterns.yaml` - decision rules in action
   - `mental-models.yaml` - explicit models mentioned
   - `values-hierarchy.yaml` - value-based decision frameworks
   - `decision-architecture.yaml` - choice heuristics

2. **Hunt for 6 framework types:**

   **a) Cause-Effect Frameworks** (A → B → C)
   ```
   Example: "First-principles thinking"
   - Break problem to atomic truths
   - Rebuild from ground up
   - Ignore analogies to existing solutions
   Evidence: Appears in 8+ sources when solving technical problems
   ```

   **b) Decision Frameworks** (If X then Y)
   ```
   Example: "2x2 Decision Matrix"
   - High impact + Low effort = Do now
   - High impact + High effort = Plan carefully
   - Low impact + Low effort = Delegate
   - Low impact + High effort = Eliminate
   Evidence: Used in business decisions across 5+ scenarios
   ```

   **c) Constraint Frameworks** (Limits define possibilities)
   ```
   Example: "Working backwards from constraints"
   - Identify non-negotiable constraints first
   - Design solution within boundaries
   - Challenge constraints second, not first
   Evidence: Mentioned as "design within reality" in 7 sources
   ```

   **d) Optimization Frameworks** (Maximize X while minimizing Y)
   ```
   Example: "80/20 Leverage Finding"
   - Find 20% of inputs creating 80% of outcomes
   - Double down on high-leverage activities
   - Systematically eliminate low-leverage work
   Evidence: Appears in time management, learning, business
   ```

   **e) Pattern-Recognition Frameworks** (This resembles that)
   ```
   Example: "Biological Systems as Organizational Model"
   - Organizations = living systems
   - Apply evolution, adaptation, ecosystem thinking
   - Resilience through diversity
   Evidence: Used to explain company culture in 4+ contexts
   ```

   **f) Heuristics** (Mental shortcuts for repeated situations)
   ```
   Example: "Strong opinions, weakly held"
   - Commit fully to current best answer
   - Update instantly when new evidence appears
   - Avoid fence-sitting indecision
   Evidence: Behavioral pattern in debates across 6+ scenarios
   ```

3. **Document each framework discovery:**
   ```yaml
   framework_candidate:
     name: "[Descriptive Name]"
     type: "[cause-effect/decision/constraint/optimization/pattern/heuristic]"
     description: "[How it works in 2-3 sentences]"
     evidence:
       - source: "[File/context]"
         example: "[Specific usage]"
       - source: "[Another file]"
         example: "[Another usage]"
     frequency: "[How often used: constant/high/medium]"
   ```

4. **Frequency threshold:** Discard frameworks with <3 documented usages (noise, not signal)

**Output Phase 1:** List of 15-25 framework candidates with evidence

---

### Phase 2: Cross-Domain Mapping - Latticework Validation (60 min)

**Goal:** Test if frameworks work across multiple domains (Munger's acid test)

**Method:** Domain Translation Challenge

For each framework candidate from Phase 1:

1. **Identify original domain:**
   ```
   Example: "First-principles thinking"
   Original domain: Engineering/Physics
   ```

2. **Test in 2+ different domains:**
   ```
   Domain Translation Test:

   Engineering → Philosophy:
   - Does first-principles thinking work for ethics?
   - Can you decompose "what is good?" to atomic truths?
   → YES: Socratic method is first-principles ethics

   Engineering → Business:
   - Does it work for market analysis?
   - Can you rebuild industry assumptions from scratch?
   → YES: Elon Musk rebuilding rocket cost structure

   VERDICT: Cross-domain validated ✅
   ```

3. **Document domain applicability map:**
   ```yaml
   framework:
     name: "First-Principles Thinking"
     cross_domain_validation:
       original_domain: "Engineering"
       tested_domains:
         - domain: "Philosophy"
           works: true
           example: "Socratic method"
         - domain: "Business"
           works: true
           example: "Cost structure rebuilding"
         - domain: "Psychology"
           works: partially
           example: "Behavioral assumptions can be questioned"
           limitations: "Emotions aren't always rational"
   ```

4. **Boundary testing:** Where does framework break down?
   ```
   First-Principles Limits:
   - Doesn't work well for: Emergent phenomena (consciousness, culture)
   - Fails when: System complexity > decomposition ability
   - Context-dependent: Better for physics than sociology
   ```

**Munger Filter:** If framework only works in one domain, it's not a framework - it's domain-specific knowledge. Discard or reclassify.

**Output Phase 2:** 8-15 cross-domain validated frameworks with applicability maps

---

### Phase 3: First-Principles Decomposition - Atomic Truth Extraction (45 min)

**Goal:** Break each framework to irreducible components

**Method:** Munger's "Remove All Context" Test

For each validated framework:

1. **Question all assumptions:**
   ```
   Framework: "80/20 Pareto Principle"

   Question 1: WHY does 80/20 emerge?
   → Answer: Power law distributions in complex systems

   Question 2: What MUST be true for this to work?
   → Answer 1: Inputs are NOT equal in impact
   → Answer 2: Distribution follows exponential not linear pattern
   → Answer 3: System has feedback loops amplifying small differences

   Question 3: What's left when we remove the numbers?
   → Core Axiom: "Unequal distribution of impact is natural law"
   ```

2. **Strip domain-specific language:**
   ```
   Domain-specific: "80/20 rule in sales productivity"
   Abstracted: "Concentration of outcomes in minority of inputs"

   Domain-specific: "Focus on high-leverage activities"
   Abstracted: "Optimize by identifying disproportionate impact factors"
   ```

3. **Inversion test** (Munger's favorite):
   ```
   Normal: "How does 80/20 help me succeed?"
   Inverted: "How would IGNORING 80/20 guarantee failure?"

   Failure Modes:
   - Treating all inputs as equal → wasted effort on trivial 80%
   - No measurement of impact → blind to what matters
   - Democratic resource allocation → spread thin

   Insight: Inversion reveals critical dependency on measurement
   ```

4. **Document atomic structure:**
   ```yaml
   framework:
     name: "Pareto Principle (80/20)"
     first_principles_decomposition:
       core_axioms:
         - "Unequal distribution is natural in complex systems"
         - "Small causes can have disproportionate effects"
         - "Feedback loops amplify initial advantages"

       necessary_conditions:
         - "Inputs must be measurable"
         - "System must have heterogeneous elements"
         - "Sufficient complexity for power law emergence"

       inversion_insights:
         failure_mode: "Equal treatment of unequal inputs"
         critical_dependency: "Measurement and tracking"
         false_assumption: "Democracy in resource allocation"
   ```

**Output Phase 3:** Each framework reduced to 3-5 core axioms with logical structure

---

### Phase 4: Interconnection Building - Weaving the Latticework (60 min)

**Goal:** Map how frameworks support, enhance, or contradict each other

**Method:** Munger's Latticework Construction

**NOT a list** - build a **knowledge web**:

1. **Complementary Pairing:** Which frameworks work better together?
   ```
   Pair: First-Principles + Inversion

   Synergy:
   - First-principles finds atomic truths
   - Inversion finds catastrophic failure modes
   - Together: Build from truth, avoid known disasters

   Enhanced Power: 1 + 1 = 3 (lollapalooza effect)
   ```

2. **Contradiction Mapping:** Which frameworks conflict?
   ```
   Conflict: "Move Fast Break Things" vs "Measure Twice Cut Once"

   Contradiction Analysis:
   - Both can't be true simultaneously...or can they?
   - Meta-framework: Speed vs accuracy is CONTEXT-DEPENDENT
   - Resolution: "Move fast in low-risk exploration, measure twice in high-risk execution"

   Synthesis: Context-switching rules elevate contradiction to wisdom
   ```

3. **Sequential Dependency:** Which must be understood before which?
   ```
   Dependency Chain:
   1. Circle of Competence (know what you know)
   2. First-Principles (decompose within competence)
   3. Cross-Domain Transfer (apply outside competence with care)

   Teaching Order: Must learn #1 before attempting #3
   ```

4. **Domain Bridging:** Which frameworks connect disparate fields?
   ```
   Bridge: "Evolution/Natural Selection"

   Connects:
   - Biology → Business (competitive markets select for fitness)
   - Economics → Culture (memes compete like genes)
   - Psychology → AI (neural networks evolve through selection)

   Power: Universal pattern recognition across all domains
   ```

5. **Build latticework map:**
   ```yaml
   framework_latticework:
     nodes:
       - id: "first_principles"
         name: "First-Principles Thinking"

       - id: "inversion"
         name: "Inversion"

       - id: "pareto"
         name: "80/20 Pareto"

     edges:
       - from: "first_principles"
         to: "inversion"
         relationship: "complementary_pair"
         synergy: "Build from truth + avoid failure = robust solutions"

       - from: "pareto"
         to: "first_principles"
         relationship: "sequential_dependency"
         note: "Must identify the vital 20% using first-principles analysis"

       - from: "inversion"
         to: "pareto"
         relationship: "validation_check"
         note: "Inverting Pareto: what if all inputs were equal? System would be linear not exponential"
   ```

**Munger Wisdom:** *"You've got to have models in your head and you've got to array your experience—both vicarious and direct—on this latticework of models"*

**Output Phase 4:** Complete latticework map showing framework relationships

---

### Phase 5: Usability Testing - Predictive Power Validation (45 min)

**Goal:** Ensure frameworks generate insights, not just explain known facts

**Method:** Munger's "Does it predict or just describe?" test

For each framework:

1. **Prediction Test:** Apply to novel situation not in source data
   ```
   Framework: "Skin in the Game"

   Known fact it explains: "Why investors who risk own money outperform"

   Novel prediction: "Will a consultant with no equity stake give same advice as one with 10% ownership?"
   → Prediction: No. Aligned incentives change recommendations.

   Test: Find example in real world...
   → Validated: McKinsey consultant (no skin) recommended expansion
   → Validated: Board member (20% equity) recommended consolidation

   VERDICT: Framework has predictive power ✅
   ```

2. **Explanation Test:** Does it explain previously mysterious patterns?
   ```
   Framework: "Lollapalooza Effects (multiple biases compound)"

   Mystery: Why do bubbles get so extreme before popping?

   Explanation using framework:
   - Social proof (everyone buying)
   - Authority bias (experts saying it's different this time)
   - Commitment/consistency (can't admit mistake)
   - Incentive (brokers earn on transactions)

   ALL acting together = 10x effect (not 4x)

   VERDICT: Previously inexplicable now makes sense ✅
   ```

3. **Action Guidance Test:** Does it suggest non-obvious actions?
   ```
   Framework: "Inversion (solve by avoiding failure)"

   Common approach: "How to build great company?"
   Inversion approach: "How to destroy company quickly?"

   Inverted Insights:
   - Hire for credentials not character → toxic culture
   - Optimize for quarterly earnings → sacrifice long-term
   - Avoid all risk → miss all opportunities

   Non-obvious actions:
   → Explicitly design failure-prevention systems
   → Hire slow (avoid #1), fire fast (fix #1 mistakes)
   → Define "unacceptable" before defining "desirable"

   VERDICT: Generates actionable insights ✅
   ```

4. **Error Reduction Test:** Does it prevent known failure modes?
   ```
   Framework: "Circle of Competence"

   Known failure mode: Experts confidently wrong outside their domain

   Prevention mechanism:
   - Explicitly mark competence boundaries
   - Acknowledge "I don't know" outside circle
   - Defer to domain experts when venturing out

   Example:
   - Buffett: "I don't understand tech, so I avoid it"
   - Result: Avoided dot-com bubble in 2000

   VERDICT: Directly prevents overconfidence errors ✅
   ```

5. **Document usability validation:**
   ```yaml
   framework:
     name: "Skin in the Game"
     usability_validation:
       prediction_test:
         novel_scenario: "Consultant advice with vs without equity"
         predicted_outcome: "Advice differs based on incentive alignment"
         real_world_validation: "Validated in multiple cases"
         result: PASS

       explanation_test:
         mystery: "Why do agency problems persist?"
         framework_explanation: "Misaligned incentives create perverse outcomes"
         explanatory_power: HIGH
         result: PASS

       action_guidance:
         situation: "Hiring advisors/consultants"
         framework_recommendation: "Ensure skin in game via equity/performance fees"
         non_obviousness: MEDIUM
         result: PASS

       error_prevention:
         failure_mode: "Bad advice from low-accountability advisors"
         prevention_mechanism: "Require aligned incentives"
         effectiveness: HIGH
         result: PASS
   ```

**Munger Standard:** If framework only describes, it's historical trivia. If it predicts and guides action, it's usable wisdom.

**Output Phase 5:** Validated frameworks with proven predictive and action-guidance power

---

## Output Format

Use template: `templates/frameworks-synthesized.yaml`

**Critical Sections:**

```yaml
frameworks_latticework:
  metadata:
    mind_name: ""
    analyst: "synthesis-expert"
    methodology: "Munger Latticework Construction"

  frameworks:  # 8-15 frameworks
    - framework_id: "fw_01"
      name: ""
      type: "[cause-effect/decision/constraint/optimization/pattern/heuristic]"

      description:
        summary: "[2-3 sentence explanation]"
        when_to_use: "[Contexts where applicable]"
        when_not_to_use: "[Known failure contexts]"

      cross_domain_validation:
        original_domain: ""
        validated_domains: []
        applicability_map: {}
        boundary_conditions: []

      first_principles:
        core_axioms: []
        necessary_conditions: []
        inversion_insights: {}

      latticework_connections:
        complements: []  # Which frameworks enhance this
        contradicts: []  # Which frameworks conflict
        prerequisites: []  # What must be known first
        enhances: []  # What this framework enhances

      usability:
        prediction_power: "[HIGH/MEDIUM/LOW]"
        explanation_power: "[HIGH/MEDIUM/LOW]"
        action_guidance: "[HIGH/MEDIUM/LOW]"
        error_prevention: "[HIGH/MEDIUM/LOW]"

  latticework_map:
    nodes: []  # Framework IDs
    edges: []  # Relationships between frameworks

  meta_insights:
    dominant_framework_types: []
    cross_domain_champions: []  # Frameworks that work everywhere
    context_sensitive: []  # Frameworks that need careful boundary management
    lollapalooza_combinations: []  # Which frameworks compound together
```

---

## Validation Checklist

After completion, execute: `*validate-synthesis`

Munger Quality Gates:
- [ ] **GATE 1:** Are frameworks interconnected (latticework) not isolated (list)?
- [ ] **GATE 2:** Has first-principles decomposition been performed rigorously?
- [ ] **GATE 3:** Have cross-domain applications been validated?
- [ ] **GATE 4:** Do frameworks have predictive power (not just descriptive)?
- [ ] **GATE 5:** Is inversion thinking applied to each framework?
- [ ] **GATE 6:** Are context boundaries clearly defined (when works vs fails)?
- [ ] **GATE 7:** Have lollapalooza combinations been identified?
- [ ] **GATE 8:** Does this enable multi-model thinking (not single-lens analysis)?

---

## Common Pitfalls

❌ **Listing famous frameworks without extraction**
- ✅ Solution: Extract frameworks FROM the mind's actual usage, don't impose external lists

❌ **Single-discipline frameworks**
- ✅ Solution: Every framework must validate across 2+ domains

❌ **Skipping first-principles decomposition**
- ✅ Solution: No framework accepted without atomic axiom extraction

❌ **Isolated frameworks (no latticework)**
- ✅ Solution: Build interconnection map showing relationships

❌ **Descriptive-only frameworks**
- ✅ Solution: Test prediction and action-guidance power

❌ **Ignoring inversion**
- ✅ Solution: Ask "how would this fail?" for every framework

---

**Munger's Final Wisdom:**

*"You may have noticed students who just try to remember and pound back what is remembered. Well, they fail in school and in life. You've got to hang experience on a latticework of models in your head."*

---

**Status:** Ready for execution
**Agent:** synthesis-expert (Charlie)
**Next Task:** communication-templates-extraction.md
