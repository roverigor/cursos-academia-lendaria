# InnerLens Expansion Pack - Design Decisions & Trade-offs

**Version:** 1.0.0
**Date:** 2025-01-14
**Status:** Approved
**Owner:** Alan Nicolas (Academia Lendar[IA])

---

## Executive Summary

This document captures all critical design decisions made for the InnerLens Expansion Pack, including the rationale, alternatives considered, and trade-offs accepted.

**Key Decision:** InnerLens Expansion Pack is positioned as **"InnerLens Lite"** - a fast, Big Five-focused analysis tool for AIOS workflows, complementing (not competing with) InnerLens Professional (v3.0 standalone app).

---

## Decision 1: Positioning - Lite vs Professional

### Context

Two InnerLens products exist:
1. **InnerLens Professional** - Full app (v3.0) with 120 traits, 300-500 evidence fragments, 60-90min pipeline
2. **InnerLens Expansion Pack** - AIOS integration (this project)

**Question:** Should expansion pack replicate full app features or be a simplified version?

### Decision: Expansion Pack = "InnerLens Lite"

**Chosen Approach:**
```
InnerLens Lite (Expansion Pack)
├── Framework: Big Five only
├── Speed: <2 minutes
├── Cost: ~$0.20 per profile
├── Output: Scores + simple evidence quotes
├── Use case: Quick screening, AIOS automation
└── Pricing: Free for AIOS users

InnerLens Professional (v3.0 App)
├── Frameworks: 120 psychological traits
├── Speed: 60-90 minutes
├── Cost: ~$3.50 per profile
├── Output: Fragments, causality graph, PDF export
├── Use case: Deep "Self Model" analysis
└── Pricing: $500/month (unlimited profiles)
```

### Rationale

1. **Expansion packs should be focused** - AIOS philosophy: "Keep Core Lean"
2. **Different user needs** - AIOS users need fast automation, CEOs need deep analysis
3. **Clear differentiation** - No market confusion
4. **Natural upsell** - Lite → Professional upgrade path
5. **Lower maintenance** - Don't duplicate 8-stage pipeline complexity

### Alternatives Considered

| Alternative | Pros | Cons | Why Rejected |
|-------------|------|------|--------------|
| **A: Full replication** | Feature parity | Duplicates code, high maintenance | Violates "Keep Core Lean" |
| **B: CLI wrapper** | Reuses app v3.0 code | Requires app running, API dependency | Too coupled |
| **C: MMOS-only focus** | Clear niche | Ignores universal psychometric market | Too narrow |

### Trade-offs Accepted

✅ **Accepted:**
- Lower depth (Big Five only vs 120 traits)
- Lower accuracy (75% vs 90%+)
- Simpler evidence (quotes vs fragments)

❌ **Rejected:**
- Reimplementing fragments (too complex)
- 8-stage pipeline (too slow for AIOS)
- Multiple frameworks in MVP (scope creep)

---

## Decision 2: MVP Scope - Big Five Only

### Context

Original PRD proposed 5 frameworks:
1. Big Five (OCEAN)
2. HEXACO (adds Honesty-Humility)
3. VIA Character Strengths (24 strengths)
4. Schwartz Values (10 universal values)
5. Reiss 16 Basic Desires

**Question:** Should MVP include all 5 frameworks or start with Big Five?

### Decision: Big Five Only (MVP v1.0)

**Chosen Scope:**
```markdown
## MVP v1.0 (Weeks 1-2)
- ✅ Big Five framework
- ✅ Linguistic marker detection
- ✅ Basic multimodal analysis (WhatsApp, email patterns)
- ✅ Simple evidence quotes (top 3 per trait)
- ✅ MMOS integration hook

## Future (v1.1+)
- ⏳ HEXACO (Honesty-Humility)
- ⏳ Schwartz Values
- ⏳ VIA Strengths
- ⏳ Triangulation engine (cross-framework validation)
```

### Rationale

1. **Big Five is most validated** - 50+ years research, 50+ countries
2. **Covers 80% of use cases** - Personality basics sufficient for screening
3. **Faster to market** - 2 weeks vs 8 weeks
4. **Lower cost** - $0.20/profile vs $0.50+ with multiple frameworks
5. **Proof of concept** - Validate demand before expanding

### Comparison Matrix

| Framework | Scientific Validity | Implementation Complexity | Use Case Coverage | MVP Priority |
|-----------|---------------------|---------------------------|-------------------|--------------|
| **Big Five** | ⭐⭐⭐⭐⭐ (gold standard) | ⭐⭐ (moderate) | 80% | **P0 - MVP** |
| **HEXACO** | ⭐⭐⭐⭐ (validated) | ⭐⭐⭐ (6th dimension) | +5% (ethics) | P1 - v1.1 |
| **VIA Strengths** | ⭐⭐⭐⭐ (positive psych) | ⭐⭐⭐⭐ (24 strengths) | +10% (character) | P2 - v1.2 |
| **Schwartz Values** | ⭐⭐⭐⭐ (cross-cultural) | ⭐⭐⭐ (10 values) | +15% (motivations) | P2 - v1.2 |
| **Reiss 16** | ⭐⭐⭐ (specialized) | ⭐⭐⭐⭐ (16 desires) | +5% (niche) | P3 - v2.0 |

### Trade-offs Accepted

✅ **Accepted:**
- No Honesty-Humility dimension (added by HEXACO)
- No character strengths (VIA)
- No values/motivations depth (Schwartz, Reiss)
- Lower confidence without triangulation

❌ **Rejected:**
- Multi-framework in MVP (too complex)
- Academic-level rigor (overkill for lite version)

---

## Decision 3: Agent Architecture - 3 Universal Agents (Task-Driven Design)

### Context

After analyzing user decision patterns and applying real-world validation, the agent architecture went through multiple iterations:

**Iteration 1:** 23 specialized agents (one per trait - rejected)
**Iteration 2:** 7 framework experts (one per framework - rejected)
**Iteration 3:** 3 universal agents (APPROVED)

**Question:** How many agents do we need, and how should they be structured?

### Decision: 3 Universal Agents with Task-Driven Design

**Chosen Architecture:**
```markdown
## 3-Agent Architecture (Final)

Agent 1: @fragment-extractor
  Role: Extract universal behavioral fragments
  Output: fragments.json (127 fragments)
  Cost: ~$0.05 per extraction
  Time: ~30 seconds
  Key: Framework-agnostic extraction (reusable across ALL frameworks)

Agent 2: @psychologist (UNIVERSAL)
  Role: Analyze personality using multiple frameworks via tasks
  Frameworks: Uses tasks/knowledge bases, not separate agents
    - tasks/analyze-bigfive.md (MVP)
    - tasks/analyze-hexaco.md (v1.1)
    - tasks/analyze-mbti.md (v1.2)
  Knowledge Bases: data/frameworks/bigfive-framework.md
  Output: bigfive-raw.yaml
  Cost: ~$0.12 per analysis
  Time: ~90 seconds

Agent 3: @quality-assurance
  Role: Independent validation and consistency checking
  Checklists: checklists/bigfive-quality.md
  Output: bigfive-profile.yaml (final validated version)
  Cost: ~$0.03 per validation
  Time: ~30 seconds

Total: 3 agents (vs 7 in iteration 2, vs 23 in iteration 1)
Total Time: 150 seconds (30s + 90s + 30s)
Total Cost: $0.20 per profile
```

### Rationale

1. **Real-World Validation** - "How does a real psychologist work?"
   - One psychologist doesn't become different people for different tests
   - One psychologist uses multiple methodologies
   - Therefore: ONE @psychologist agent, MULTIPLE framework tasks

2. **Fragment-First Architecture** - Extract evidence ONCE, reuse MANY times
   - Fragments are framework-agnostic
   - Big Five, HEXACO, MBTI, Enneagram can all use same fragments
   - Cost efficiency: $0.05 extraction + 5×$0.12 analysis = $0.65 (vs $1.00 without reuse)
   - Time efficiency: Parallel analysis possible (max time, not sum)

3. **Task-Driven Design** - Scalability through configuration, not multiplication
   - Frameworks = DATA (knowledge bases in data/frameworks/)
   - Analysis workflows = TASKS (in tasks/)
   - Quality gates = CHECKLISTS (in checklists/)
   - Adding new framework = Add task + knowledge base (NOT new agent)

4. **Separation of Concerns**
   - @fragment-extractor: WHAT happened (evidence)
   - @psychologist: WHAT it MEANS (trait analysis)
   - @quality-assurance: IS it VALID (validation)

5. **Quality as First-Class Concern**
   - Independent QA agent prevents bias
   - Cross-framework consistency checks (future)
   - Quality validation non-negotiable

### Decision Principles Applied

From DECISION-PRINCIPLES.md:
- ✅ **Real-World Validation** (Principle 4): Models how real psychologists work
- ✅ **Configuration Over Duplication** (Principle 5): Tasks/frameworks are data, not agents
- ✅ **Challenge Complexity** (Principle 8): 3 agents vs 23 (87% reduction)
- ✅ **Smart Reusability** (Principle 3): Fragment-first architecture

Mental Frameworks Applied:
- **First Principles**: "What's the simplest way to model a psychologist using multiple tests?"
- **Essentialism**: "What's essential? One expert. What's not? Micro-specialization."
- **Maximum Modularization**: Agents, tasks, frameworks, checklists are independent modules

### Alternatives Considered and Rejected

| Alternative | Agent Count | Rationale | Why Rejected |
|-------------|-------------|-----------|--------------|
| **Iteration 1: Micro-Specialization** | 23 agents | One agent per trait (openness-expert, type5-expert, etc.) | Doesn't match reality - no psychologist has 23 specialists for one evaluation |
| **Iteration 2: Framework Experts** | 7 agents | One agent per framework (bigfive-expert, mbti-expert, etc.) | Still duplicates "expert" concept unnecessarily - one psychologist uses multiple frameworks |
| **Alternative A: Monolithic** | 1 agent | One agent does everything | Poor separation of concerns, can't parallelize |
| **Alternative B: Pipeline** | 5+ agents | Extract → Clean → Analyze → Validate → Format | Over-engineered for lite version |

### Comparison Matrix

| Architecture | Agent Count | Fragments Extracted | Analysis Time | Scalability | Complexity |
|--------------|-------------|---------------------|---------------|-------------|------------|
| **Iteration 1 (Rejected)** | 23 agents | 23 times (per trait) | 23 × 60s = 23min | Hard (23× agents) | VERY HIGH |
| **Iteration 2 (Rejected)** | 7 agents | 7 times (per framework) | 7 × 90s = 10.5min | Medium (7× agents) | HIGH |
| **Iteration 3 (FINAL)** | 3 agents | 1 time (universal) | 150s total | Easy (add tasks) | LOW |

### Fragment Reuse Benefit

**Without Fragment-First (Iteration 2):**
```
Big Five Analysis:    Extract (30s) + Analyze (90s) = 120s, $0.20
HEXACO Analysis:      Extract (30s) + Analyze (90s) = 120s, $0.20
MBTI Analysis:        Extract (30s) + Analyze (90s) = 120s, $0.20
Total:                360s, $0.60
```

**With Fragment-First (Iteration 3):**
```
Fragment Extraction:  Extract ONCE (30s) = 30s, $0.05
Big Five Analysis:    Analyze fragments (90s) = 90s, $0.12
HEXACO Analysis:      Analyze fragments (90s) = 90s, $0.12
MBTI Analysis:        Analyze fragments (90s) = 90s, $0.12
Total (sequential):   300s, $0.41 (32% savings)
Total (parallel):     120s, $0.41 (67% time savings)
```

### Task-Driven Scalability Example

**Adding MBTI Framework:**

❌ **Without Task-Driven Design:**
```markdown
1. Create new agent: agents/mbti-expert.md (500 lines)
2. Update config.yaml agents section
3. Create task: tasks/detect-mbti.md
4. Update orchestrator to route to new agent
5. Test new agent activation
6. Update 10+ integration points
```

✅ **With Task-Driven Design:**
```markdown
1. Create task: tasks/analyze-mbti.md (300 lines)
2. Create knowledge base: data/frameworks/mbti-framework.md (400 lines)
3. Create checklist: checklists/mbti-quality.md (200 lines)
4. Done. @psychologist can now execute MBTI analysis.
```

**Result:** 70% less work, no new agents, infinitely scalable.

### Trade-offs Accepted

✅ **Accepted:**
- Agents must be designed for multi-framework use (more complex individual agents)
- Fragment schema must be framework-agnostic (requires careful design)
- Tasks must be well-documented (can't rely on agent-specific hardcoding)

❌ **Rejected:**
- Micro-specialization (23 agents)
- Framework-specific agents (7 agents)
- Monolithic agent (1 agent doing everything)
- Framework-specific fragment extraction (no reuse)

### Implementation Impact

**Files Created:**
- `agents/fragment-extractor.md`
- `agents/psychologist.md`
- `agents/quality-assurance.md`
- `tasks/analyze-bigfive.md`
- `data/frameworks/bigfive-framework.md`
- `checklists/bigfive-quality.md`

**Files NOT Created (avoided complexity):**
- ❌ `agents/openness-expert.md` (× 5 traits)
- ❌ `agents/bigfive-expert.md` (× 7 frameworks)
- ❌ `agents/type1-expert.md` (× 9 Enneagram types)
- ❌ 18+ additional agent files avoided

**Maintenance Burden:**
- Iteration 1: Maintain 23 agents + 23 tasks = 46 files
- Iteration 2: Maintain 7 agents + 7 tasks = 14 files
- Iteration 3: Maintain 3 agents + N tasks = 3 + N files (scalable)

---

## Decision 4: Speed vs Accuracy

### Context

**Speed options:**
- Fast: <2 minutes (lightweight LLM analysis)
- Medium: 10-20 minutes (multiple LLM passes)
- Slow: 60-90 minutes (full pipeline like app v3.0)

**Accuracy options:**
- Basic: 70-75% correlation with ground truth
- Good: 80-85% correlation
- Excellent: 90%+ correlation (requires triangulation)

### Decision: Optimize for Speed (<2min), Accept 75%+ Accuracy

**Chosen Approach:**
```markdown
## Speed Target: <2 minutes
- Single LLM pass (Claude Sonnet 4)
- Prompt caching (system instructions)
- Parallel processing (traits analyzed together)
- Minimal preprocessing

## Accuracy Target: 75%+
- Sufficient for screening/automation
- Good enough for AIOS workflows
- Not diagnostic (disclaimer required)
- Clear confidence scores shown
```

### Rationale

1. **AIOS users need fast feedback** - 2min fits workflow, 60min doesn't
2. **75% accuracy is actionable** - Better than guessing, sufficient for non-critical decisions
3. **Lower cost** - Single LLM pass (~$0.20) vs multiple passes (~$3.50)
4. **Natural upsell** - "Need 90%+ accuracy? Use InnerLens Professional"

### Speed-Accuracy Curve

```
Accuracy
   100% │                                    ╱─ App v3.0 (90min)
        │                               ╱───
    90% │                          ╱───
        │                     ╱───
    80% │                ╱───
        │           ╱───
    75% │      ╱───  ← Expansion Pack (2min)
        │  ╱───
    70% │─────────────────────────────────────────
        └────────────────────────────────────────→ Time
           2min    10min   30min   60min   90min
```

### Trade-offs Accepted

✅ **Accepted:**
- 75-80% accuracy (vs 90%+ in app)
- No triangulation (single framework)
- Simpler evidence (quotes vs fragments)
- Higher error rate (25% vs 10%)

❌ **Rejected:**
- 90%+ accuracy requirement (requires multi-framework)
- Clinical-level rigor (not the use case)
- Real-time (<30sec) speed (sacrifices too much accuracy)

---

## Decision 4: Evidence Type - Quotes vs Fragments

### Context

**InnerLens Professional uses "fragments":**
```yaml
fragment_id: "FRAG-001"
text: "Alan avoids projects when they don't progress at his preferred pace"
correlated_traits:
  - code: 12 (Low Patience)
  - code: 45 (High Autonomy)
  - code: 78 (Emotional Protection)
source: "meeting-2024-10-12.txt:L142"
confidence: 0.87
processing_stage: 4
llm_analysis: "Shows pattern of..."
```

**Question:** Should expansion pack replicate fragment extraction?

### Decision: Simple Evidence Quotes (Not Fragments)

**Chosen Approach:**
```yaml
# Lite Evidence Format
trait: "Openness to Experience"
score: 85
level: "HIGH"
confidence: 0.78

evidence_quotes:
  - quote: "I love exploring new ideas and unconventional approaches"
    source: "transcript.txt:L42"
    relevance: "Direct expression of openness"

  - quote: "The status quo bores me - I'm always looking for what's next"
    source: "email-thread.txt:L156"
    relevance: "Novelty-seeking behavior"

  - quote: "I read across 10+ disciplines just to find connections"
    source: "interview.txt:L89"
    relevance: "Intellectual curiosity"
```

### Rationale

1. **Fragments require 8-stage pipeline** - Too complex for lite version
2. **Fragments need trait correlation matrix** - 120 traits × 120 traits mapping
3. **Quotes are sufficient for screening** - Users can validate conclusions
4. **Lower cost** - Single-pass extraction vs multi-stage processing
5. **Faster output** - <2min vs 60-90min

### Comparison

| Feature | Fragments (App v3.0) | Quotes (Expansion Pack) |
|---------|----------------------|-------------------------|
| **Depth** | Multi-trait correlation | Single-trait evidence |
| **Quantity** | 300-500 per profile | 3-5 per trait (15-25 total) |
| **Processing** | 8 stages, 60-90min | 1 stage, <2min |
| **Cost** | $3.50 per profile | $0.20 per profile |
| **Validation** | Graph visualization | Simple list |
| **Use case** | Deep self-model | Quick screening |

### Trade-offs Accepted

✅ **Accepted:**
- No trait correlation mapping
- No causality graph
- Lower evidence quantity (15-25 quotes vs 300-500 fragments)
- No cross-fragment validation

❌ **Rejected:**
- Reimplementing fragments (too complex)
- Fragment-level APIs (out of scope)

---

## Decision 5: Multimodal Analysis Depth

### Context

**Multimodal sources available:**
1. WhatsApp exports (message patterns, timing, emoji)
2. Email threads (formality, structure, response time)
3. Code repositories (comments, naming, architecture)
4. Calendar data (time management, meeting patterns)
5. Meeting transcripts (speech patterns, leadership)

**Question:** How deep should multimodal analysis be in lite version?

### Decision: Basic Patterns Only (Not Deep Analysis)

**Chosen Depth:**
```markdown
## Lite Multimodal Analysis

### WhatsApp
- ✅ Message frequency (per day average)
- ✅ Response time median
- ✅ Emoji usage patterns
- ❌ Conversation dynamics
- ❌ Topic modeling
- ❌ Relationship mapping

### Email
- ✅ Formality score (simple NLP)
- ✅ Message length average
- ✅ Response time
- ❌ Network analysis
- ❌ Sentiment over time
- ❌ Thread complexity

### Code (basic)
- ✅ Comment density
- ✅ Function naming style
- ❌ Architecture patterns
- ❌ Collaboration style
- ❌ Refactoring frequency

### Calendar
- ✅ Meeting load (hours/week)
- ✅ Focus time blocks
- ❌ Network centrality
- ❌ Meeting types clustering
```

### Rationale

1. **Basic patterns sufficient for Big Five** - Deep analysis overkill
2. **Speed target <2min** - Complex analysis too slow
3. **ETL Data Collector optional** - Should work with simple text input
4. **Lower cost** - Fewer API calls
5. **Natural upsell** - "Need deeper analysis? Use Professional"

### Trade-offs Accepted

✅ **Accepted:**
- Surface-level patterns only
- No advanced NLP (topic modeling, sentiment trends)
- No network analysis (social graphs)
- Manual data preparation (no auto-parsing)

❌ **Rejected:**
- Auto-parsing WhatsApp/email formats (too brittle)
- Deep code analysis (AST parsing, complexity metrics)
- Calendar intelligence (meeting type classification)

---

## Decision 6: Privacy Implementation

### Context

**Privacy requirements:**
- GDPR compliance (EU)
- LGPD compliance (Brazil)
- User data ownership
- Right to deletion
- Consent management

**Question:** How comprehensive should privacy implementation be in MVP?

### Decision: Privacy Framework (4-Level Classification)

**Chosen Implementation:**
```yaml
## 4-Level Privacy Classification

Level 1: PUBLIC
  - Description: Shareable, non-sensitive
  - Examples: Big Five scores, work style preferences
  - Handling: Open sharing with consent
  - Storage: Plain text OK

Level 2: PRIVATE
  - Description: Personal but non-clinical
  - Examples: Communication patterns, values
  - Handling: Encrypted storage, consent required
  - Storage: AES-256 encryption

Level 3: SENSITIVE
  - Description: Requires explicit consent
  - Examples: Emotional regulation, conflict styles
  - Handling: Double encryption, granular consent
  - Storage: AES-256 + key rotation

Level 4: CLINICAL
  - Description: Regulated (HIPAA/LGPD)
  - Examples: Mental health indicators, diagnoses
  - Handling: NOT STORED - out of scope
  - Storage: N/A
```

### Rationale

1. **GDPR/LGPD compliance mandatory** - Not optional
2. **4-level system balances UX and security** - Granular without overwhelming
3. **"Not a diagnostic tool" disclaimer** - Avoids clinical regulation
4. **User data ownership** - Builds trust, competitive advantage

### Privacy Features

| Feature | MVP | v1.1+ |
|---------|-----|-------|
| **Data minimization** | ✅ Only Big Five relevant fields | ✅ |
| **Purpose limitation** | ✅ Clear use case disclosure | ✅ |
| **Storage limitation** | ✅ User-defined retention | ✅ |
| **Data portability** | ✅ Export to YAML/JSON | ✅ PDF export |
| **Right to deletion** | ✅ Cascade delete | ✅ |
| **Privacy by design** | ✅ Classification built-in | ✅ |
| **Consent management** | ⏳ Basic checkbox | ✅ Granular per-field |
| **Audit trail** | ⏳ Basic logs | ✅ Complete trail |

### Trade-offs Accepted

✅ **Accepted:**
- Basic consent (checkbox) in MVP
- Manual classification (not auto-detected)
- Simple audit logs (not forensic-level)

❌ **Rejected:**
- No consent management (non-compliant)
- Auto-classification (too error-prone)
- Storing clinical data (legal liability)

---

## Decision 7: MMOS Integration Depth

### Context

**MMOS Mind Mapper pipeline:**
```
Phase 1: Viability → Phase 2: Research → Phase 3: Analysis
→ Phase 4: Synthesis → Phase 5: Implementation → Phase 6: Testing
```

**InnerLens could integrate at:**
- **Post-Research (Phase 2):** Analyze collected sources
- **Post-Analysis (Phase 3):** Enhance cognitive-spec.yaml
- **Post-Synthesis (Phase 4):** Enrich system prompt

**Question:** Where should InnerLens integrate?

### Decision: Post-Analysis Integration (Phase 3 Hook)

**Chosen Integration Point:**
```markdown
## MMOS Integration Flow

1. MMOS completes Phase 1-3
   - Viability check passed
   - Sources collected (Research)
   - cognitive-spec.yaml generated (Analysis)

2. User runs: *integrate-with-mmos --mind naval_ravikant

3. InnerLens reads: minds/naval_ravikant/sources/downloads/

4. InnerLens generates:
   minds/naval_ravikant/analysis/psychometric-profile.yaml

5. MMOS Phase 4 (Synthesis) merges:
   - cognitive-spec.yaml (DNA Mental™ 8 layers)
   - psychometric-profile.yaml (Big Five)

6. Result: Enhanced system prompt (94% → 96%+ fidelity)
```

### Rationale

1. **Post-Analysis timing is optimal** - Data collected but not yet synthesized
2. **Non-breaking integration** - MMOS works fine without InnerLens
3. **Additive value** - Enhances fidelity, doesn't replace existing analysis
4. **Optional hook** - Users choose to run InnerLens
5. **Clear output format** - Matches MMOS YAML conventions

### Integration Scope

| Feature | Included | Excluded |
|---------|----------|----------|
| **Read MMOS sources** | ✅ | |
| **Generate psychometric-profile.yaml** | ✅ | |
| **Merge with cognitive-spec.yaml** | ❌ (MMOS does this) | Manual merge |
| **Enhance system prompt** | ❌ (MMOS does this) | Auto-injection |
| **Validate fidelity improvement** | ⏳ v1.1 | Turing test |

### Trade-offs Accepted

✅ **Accepted:**
- Manual integration (not automatic)
- MMOS does the merging (InnerLens just outputs)
- No direct system prompt editing
- Fidelity improvement assumed (not validated in MVP)

❌ **Rejected:**
- Auto-injection into MMOS pipeline (too coupled)
- Direct system prompt modification (risky)
- Fidelity validation (requires Turing tests, out of MVP scope)

---

## Decision 8: Cost Model & Pricing

### Context

**Cost factors:**
- LLM API calls (Claude Sonnet 4)
- Prompt caching (90% savings)
- Processing time
- Infrastructure

**Question:** What should cost/pricing model be?

### Decision: Free for AIOS Users, Upsell to Professional

**Chosen Model:**
```markdown
## Pricing Strategy

### InnerLens Lite (Expansion Pack)
- **Price to end user:** FREE (included with AIOS)
- **Cost per profile:** ~$0.20
  - Claude Sonnet 4: $0.15
  - Infrastructure: $0.05
- **Funded by:** Professional app revenue + open source

### InnerLens Professional (App v3.0)
- **Price to end user:** $500/month (unlimited profiles)
- **Cost per profile:** ~$3.50
- **Margin:** ~99% at scale ($500 revenue, ~$3.50 COGS per user)

### Upsell Path
- Lite user needs deeper analysis
- "Upgrade to Professional for 120 traits, fragments, graph"
- Conversion target: 5% (10 users Year 1)
- Indirect revenue: $30K ARR from upgrades
```

### Rationale

1. **Expansion packs are typically free** - AIOS ecosystem model
2. **$0.20 cost is sustainable** - Can absorb for community value
3. **Upsell generates revenue** - Main monetization strategy
4. **Strategic value** - MMOS ecosystem integration, brand building
5. **Open source contribution** - Grows AIOS community

### Cost Breakdown

| Component | Cost per Profile | Annual (1K profiles) |
|-----------|------------------|----------------------|
| **Claude Sonnet 4** | $0.15 | $150 |
| **Infrastructure** | $0.05 | $50 |
| **Total COGS** | $0.20 | $200 |
| **Revenue (direct)** | $0 | $0 |
| **Revenue (indirect)** | $30 avg | $30,000 |
| **Net Margin** | $29.80 | $29,800 |

### Trade-offs Accepted

✅ **Accepted:**
- No direct revenue from expansion pack
- Dependency on Professional app for monetization
- Community/strategic value over immediate profit

❌ **Rejected:**
- Paid expansion pack (breaks AIOS ecosystem norms)
- Freemium with paywalls (poor UX)
- Ads or data selling (privacy violation)

---

## Decision 9: Testing & Validation Strategy

### Context

**Testing levels needed:**
- Unit tests (individual functions)
- Integration tests (end-to-end workflows)
- Validation tests (accuracy vs ground truth)
- User acceptance tests (beta users)

**Question:** What level of testing is required for MVP?

### Decision: Validation-First, Tests-Second

**Chosen Strategy:**
```markdown
## Testing Priority (MVP)

### P0: Validation Tests (MUST HAVE)
1. Ground truth comparison (N=10 known personalities)
   - Collect self-reported Big Five scores
   - Run InnerLens on their writings
   - Compute Pearson correlation (target: r > 0.75)

2. Cross-rater reliability
   - 2 independent psychologists score same text
   - Compare to InnerLens output
   - Inter-rater agreement >70%

### P1: Integration Tests (SHOULD HAVE)
1. End-to-end workflow
   - Text input → Big Five output
   - MMOS integration hook
   - Error handling

### P2: Unit Tests (NICE TO HAVE)
1. YAML parsing
2. Linguistic marker extraction
3. Confidence scoring logic
```

### Rationale

1. **Accuracy is core value prop** - Must validate first
2. **Unit tests less critical for LLM-heavy system** - Integration matters more
3. **Real users = best test** - Beta program validates UX
4. **Time constraint** - 2 weeks for MVP, prioritize ruthlessly

### Validation Plan

| Test Type | Sample Size | Target Metric | Timeline |
|-----------|-------------|---------------|----------|
| **Ground truth** | N=10 personalities | r > 0.75 (Pearson) | Week 2 |
| **Cross-rater** | N=5 texts | Agreement >70% | Week 2 |
| **Beta users** | N=5 users | NPS 7+ | Week 3 |
| **Performance** | 10 runs | <2min average | Week 2 |

### Trade-offs Accepted

✅ **Accepted:**
- Limited unit test coverage (<50%)
- Manual validation (not automated)
- Small sample size (N=10)
- Qualitative feedback over quantitative

❌ **Rejected:**
- 80% code coverage requirement (too much for MVP)
- Large-scale validation (N=100+, too expensive)
- Automated accuracy regression tests (v1.1+)

---

## Decision 10: Documentation Language & Tone

### Context

**Audience:**
- Developers (technical)
- AIOS users (semi-technical)
- End users (non-technical)

**Question:** What language and tone for documentation?

### Decision: English, Professional Yet Accessible

**Chosen Guidelines:**
```markdown
## Documentation Standards

### Language: English (US)
- All code, comments, metadata in English
- All documentation in English
- READMEs, PRDs, Epics, Stories in English

### Tone: Professional Yet Accessible
- Avoid jargon without explanation
- Use examples liberally
- Assume "smart but unfamiliar" reader
- Balance technical accuracy with readability

### Format: Markdown
- GitHub-flavored Markdown
- YAML for structured data
- Mermaid for diagrams
- Code blocks with syntax highlighting
```

### Rationale

1. **English is AIOS standard** - Ecosystem consistency
2. **Global collaboration** - Open source contributors worldwide
3. **Professional credibility** - Scientific frameworks require precision
4. **User-friendly** - Balance technical depth with accessibility

### Examples

❌ **Bad (too technical):**
> "Implement psychometric trait extraction via NLP-enhanced transformer models with few-shot prompting for Big Five OCEAN dimensions using Costa & McCrae's NEO-PI-R validated constructs"

✅ **Good (accessible):**
> "Analyze text to detect Big Five personality traits (Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism) using AI. Based on 50+ years of psychology research."

---

## Summary of Key Decisions

| # | Decision | Chosen Path | Alternative Rejected | Impact |
|---|----------|-------------|----------------------|--------|
| **1** | Positioning | InnerLens Lite (quick Big Five) | Full feature parity with app | Clear differentiation |
| **2** | MVP Scope | Big Five only | 5 frameworks | Faster to market (2 weeks) |
| **3** | Agent Architecture | 3 universal agents (task-driven) | 23 specialized agents, 7 framework experts | 87% complexity reduction, infinite scalability |
| **4** | Speed vs Accuracy | <2min, 75%+ accuracy | 90%+ accuracy, 60min | AIOS workflow fit |
| **5** | Evidence Type | Simple quotes | Full fragments | Lower complexity |
| **6** | Multimodal Depth | Basic patterns | Deep analysis | Cost/speed optimization |
| **7** | Privacy | 4-level classification | Binary (public/private) | GDPR/LGPD compliant |
| **8** | MMOS Integration | Post-Analysis hook | Auto-injection | Non-breaking |
| **9** | Pricing | Free (upsell to Pro) | Paid expansion pack | Ecosystem fit |
| **10** | Testing | Validation-first | Unit tests-first | Accuracy focus |
| **11** | Documentation | English, accessible | Portuguese, technical | Global reach |

---

## Open Questions (To Be Decided Later)

### Q1: Multi-Language Support
- **Question:** Should Lite support non-English analysis (pt-BR, es-ES)?
- **Decision by:** v1.1 planning
- **Dependency:** Professional app already has pt-BR support

### Q2: API Access
- **Question:** Should Lite expose REST/GraphQL API for external integrations?
- **Decision by:** After MVP validation
- **Dependency:** User demand signal

### Q3: Real-time Analysis
- **Question:** Should Lite support streaming analysis (<30sec) for live meetings?
- **Decision by:** v2.0 planning
- **Dependency:** WebSocket infrastructure

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0.0 | 2025-01-14 | Alan Nicolas | Initial design decisions document |

---

**Document Status:** ✅ Approved
**Next Review:** After MVP completion (Week 2)
**Owner:** Alan Nicolas
**Approvers:** Alan Nicolas (Product), Dev Lead (Technical)

---

_Last Updated: 2025-01-14_
_Status: 🎯 Canonical Source of Truth_
