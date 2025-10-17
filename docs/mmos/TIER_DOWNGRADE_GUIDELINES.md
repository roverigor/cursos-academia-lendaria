# MMOS Tier Downgrade Guidelines

**Version:** 1.0
**Created:** 2025-10-16
**Owner:** Product Owner (Sarah)
**Purpose:** Clear criteria for when to downgrade from LEGEND → PREMIUM → BASIC

---

## 🎯 Philosophy: "Aim for LEGEND, Justify Downgrades"

**Default mindset:** Every clone starts as LEGEND candidate.
**Downgrade only when:** Constraints clearly justify it AND quality won't suffer unacceptably.

---

## ⚠️ Red Flags: When Over-Engineering Happens

### Signs You're Over-Engineering (Consider Downgrade):

**❌ LEGEND is over-engineering when:**
- Sources insufficient for Cognitive Biases (< 10 sources with depth)
- No evident public/private contradictions in source material
- Timeline pressure creates rushed implementation (better PREMIUM done well than LEGEND done poorly)
- Client explicitly doesn't value 95%+ authenticity (satisfied with 85%)
- Budget hard cap prevents quality LEGEND execution

**❌ PREMIUM is over-engineering when:**
- Persona is genuinely single-dimensional (no Theatre of Agents needed)
- Sources show no context-dependent behavior (no Engagement Modes needed)
- Simple operational role (no multi-perspective thinking evident)
- BASIC would deliver 70%+ authenticity sufficiently for use case

---

## ✅ Downgrade Decision Matrix

### LEGEND → PREMIUM: When to Downgrade

| Criterion | LEGEND Required | PREMIUM Acceptable | Decision |
|-----------|----------------|-------------------|----------|
| **Public/Private Contradictions** | Clearly evident in sources | Not evident or minimal | If not evident → PREMIUM |
| **Cognitive Biases** | 3+ documented biases in sources | < 3 biases or unclear | If < 3 → PREMIUM |
| **Sources Depth** | 20+ deep sources | 10-19 sources | If < 20 → PREMIUM |
| **Timeline** | 14-20 days available | 7-10 days max | If < 14 days → PREMIUM |
| **Budget** | 6x baseline approved | Only 3x approved | If 3x max → PREMIUM |
| **Client Value** | Requires 95%+ authenticity | 85% acceptable | If 85% ok → PREMIUM |

**Downgrade Formula:**
```
IF (public_private_contradictions == "not evident") OR
   (cognitive_biases < 3) OR
   (sources_depth < 20) OR
   (timeline < 14 days) OR
   (budget_max == 3x) OR
   (client_satisfied_with_85%):
   → DOWNGRADE to PREMIUM
```

**Key Question:** "Will LEGEND features be used and valued, or are we building features that won't deliver ROI?"

---

### PREMIUM → BASIC: When to Downgrade

| Criterion | PREMIUM Required | BASIC Acceptable | Decision |
|-----------|-----------------|------------------|----------|
| **Multi-Perspective Thinking** | Evident in sources (Theatre needed) | Single perspective | If single → BASIC |
| **Context-Dependent Behavior** | Adapts modes in sources | Consistent behavior | If consistent → BASIC |
| **Persona Complexity (APEX)** | Score ≥ 40 | Score < 40 | If < 40 → BASIC |
| **Sources Quality** | 10+ sources with depth | < 10 sources | If < 10 → BASIC |
| **Timeline** | 7-10 days available | 3-4 days max | If < 7 days → BASIC |
| **Budget** | 3x baseline approved | Only 1x approved | If 1x max → BASIC |

**Downgrade Formula:**
```
IF (multi_perspective_thinking == "not evident") OR
   (context_dependent_behavior == "not evident") OR
   (apex_score < 40) OR
   (sources_quality < 10) OR
   (timeline < 7 days) OR
   (budget_max == 1x):
   → DOWNGRADE to BASIC
```

**Key Question:** "Does this persona genuinely think through multiple perspectives, or is it direct/operational?"

---

## 🚦 Traffic Light System

### 🟢 GREEN: Stay at Current Tier (No Downgrade)

**For LEGEND:**
- ✅ 20+ sources with deep self-reflection
- ✅ Public/private contradictions clearly documented
- ✅ 3+ cognitive biases evident
- ✅ 14-20 days timeline available
- ✅ 6x budget approved
- ✅ Client values 95%+ authenticity

**For PREMIUM:**
- ✅ 10+ sources showing multi-perspective thinking
- ✅ Context-dependent behavior evident
- ✅ APEX score ≥ 40
- ✅ 7-10 days timeline available
- ✅ 3x budget approved
- ✅ Theatre of Agents will be used

**For BASIC:**
- ✅ Foundation (Stories 2.1 + 2.2) sufficient
- ✅ 3-4 days timeline
- ✅ 1x budget
- ✅ 70% authenticity meets needs

---

### 🟡 YELLOW: Consider Downgrade (Borderline)

**For LEGEND → PREMIUM:**
- ⚠️ 15-19 sources (borderline depth)
- ⚠️ Some contradictions but not clearly public/private
- ⚠️ 2 cognitive biases evident (need 3)
- ⚠️ 12-13 days timeline (tight)
- ⚠️ 5x budget (slightly under 6x)
- ⚠️ Client unsure if 95% vs 85% matters

**Decision:** Consult with team. If 2+ yellow flags → DOWNGRADE to PREMIUM

**For PREMIUM → BASIC:**
- ⚠️ 8-9 sources (borderline)
- ⚠️ Some perspective shifts but not clear Theatre needed
- ⚠️ APEX score 38-42 (borderline)
- ⚠️ 6 days timeline (tight)
- ⚠️ 2.5x budget (slightly under 3x)
- ⚠️ Client unsure if 85% vs 70% matters

**Decision:** Consult with team. If 2+ yellow flags → DOWNGRADE to BASIC

---

### 🔴 RED: Downgrade Immediately (Clear Signals)

**For LEGEND → PREMIUM:**
- ❌ < 15 sources
- ❌ No public/private contradictions
- ❌ < 2 cognitive biases
- ❌ < 12 days timeline
- ❌ < 5x budget
- ❌ Client explicitly doesn't need 95%

**Decision:** If 2+ red flags → **MANDATORY DOWNGRADE** to PREMIUM

**For PREMIUM → BASIC:**
- ❌ < 8 sources
- ❌ No multi-perspective thinking evident
- ❌ APEX score < 38
- ❌ < 6 days timeline
- ❌ < 2.5x budget
- ❌ Client explicitly doesn't need 85%

**Decision:** If 2+ red flags → **MANDATORY DOWNGRADE** to BASIC

---

## 📋 Downgrade Justification Template

**Use this when downgrading from recommended tier:**

```markdown
# Tier Downgrade Justification

**Clone:** [Persona name]
**Date:** [YYYY-MM-DD]
**Analyst:** [Your name]

---

## Recommended Tier (from APEX algorithm)
**APEX Score:** [ ] / 100
**Sources Score:** [ ] / 100
**Algorithm Recommendation:** [ LEGEND / PREMIUM / BASIC ]
**Confidence:** [ ]%

---

## Actual Tier Selected
**Selected Tier:** [ LEGEND / PREMIUM / BASIC ]

---

## Downgrade Rationale (if Selected < Recommended)

### Traffic Light Assessment

**🟢 GREEN Criteria (Stay at recommended):**
- [ ] List any green criteria met

**🟡 YELLOW Criteria (Borderline):**
- [ ] List any yellow criteria (if 2+, consider downgrade)

**🔴 RED Criteria (Downgrade immediately):**
- [ ] List any red criteria (if 2+, mandatory downgrade)

**Total Red Flags:** [ ] (if ≥ 2 → downgrade mandatory)

---

### Specific Constraints Forcing Downgrade

**Budget Constraint:**
- [ ] Client approved only $_____ (max tier: _____)
- [ ] Justification: _______________

**Timeline Constraint:**
- [ ] Launch date: _____ (max tier: _____)
- [ ] Justification: _______________

**Sources Constraint:**
- [ ] Only ___ sources available (insufficient for recommended tier)
- [ ] Missing: _______________ (what data is lacking)

**Persona Constraint:**
- [ ] Feature not needed: _______________ (e.g., no Theatre of Agents needed)
- [ ] Justification: _______________

**Client Request:**
- [ ] Client explicitly requested lower tier
- [ ] Reason: _______________

---

### Quality Impact Assessment

**What we lose by downgrading:**
- [ ] Theatre of Agents (multi-perspective processing)
- [ ] Engagement Modes (context adaptation)
- [ ] Cognitive Biases (authentic limitations)
- [ ] Public/Private Contradictions (contextual personas)

**Impact on authenticity:**
- Recommended tier target: ____%
- Selected tier target: ____%
- **Authenticity gap:** ___% (acceptable because: _______)

**Mitigation:**
- How we'll compensate for lost features: _______________
- Plan to upgrade later if needed: [ YES / NO ]

---

## Approval

**Analyst Recommendation:** Downgrade justified
**PO Decision:** [ ] Approved  [ ] Needs review  [ ] Rejected

**PO Comments:**
_______________

**Approved by:** _______________
**Date:** _______________
```

---

## 🎯 Decision Flowchart

```
START: APEX + Sources recommends tier X

├─ Is timeline sufficient for tier X?
│  ├─ NO → RED FLAG #1 → Consider downgrade
│  └─ YES → Continue
│
├─ Is budget sufficient for tier X?
│  ├─ NO → RED FLAG #2 → Consider downgrade
│  └─ YES → Continue
│
├─ Are sources sufficient for tier X features?
│  ├─ NO → RED FLAG #3 → Consider downgrade
│  └─ YES → Continue
│
├─ Does persona complexity justify tier X?
│  ├─ NO → RED FLAG #4 → Consider downgrade
│  └─ YES → Continue
│
├─ Will tier X features be used/valued?
│  ├─ NO → RED FLAG #5 → Consider downgrade
│  └─ YES → Continue
│
└─ RED FLAGS count:
   ├─ 0-1 flags → STAY at recommended tier ✅
   ├─ 2 flags → BORDERLINE → Consult team, likely downgrade ⚠️
   └─ 3+ flags → MANDATORY DOWNGRADE 🔴
```

---

## 📊 Real-World Examples

### Example 1: LEGEND → PREMIUM (Justified Downgrade)

**Persona:** Senior Product Manager
**APEX Score:** 65
**Sources Score:** 55
**Algorithm Recommendation:** LEGEND (80% confidence)

**Downgrade Decision:** PREMIUM

**Rationale:**
- 🔴 Only 12 sources available (need 20+ for LEGEND)
- 🔴 No public/private contradictions evident in sources
- 🟡 Only 2 cognitive biases documented (need 3)
- ✅ Timeline: 14 days (sufficient)
- ✅ Budget: 6x approved

**Red Flags:** 2 (sources + contradictions)
**Decision:** MANDATORY DOWNGRADE to PREMIUM

**Impact:** 85% vs 95% authenticity (-10%) - acceptable because contradictions/biases features won't be usable with current sources.

---

### Example 2: PREMIUM → BASIC (Unjustified - REJECTED)

**Persona:** Software Architect
**APEX Score:** 72
**Sources Score:** 68
**Algorithm Recommendation:** LEGEND

**Proposed Downgrade:** BASIC (due to timeline constraint)

**PO Decision:** REJECTED - Stay at PREMIUM minimum

**Rationale:**
- ✅ 15+ sources showing multi-perspective thinking (Theatre of Agents needed)
- ✅ Context-dependent behavior evident (Engagement Modes needed)
- ✅ APEX 72 (well above BASIC threshold)
- 🔴 Only 5 days timeline (constraint)
- ✅ Budget: 3x approved

**Analysis:** Downgrade to BASIC would lose Theatre of Agents + Engagement Modes, which are essential for this architect persona. Timeline constraint is not sufficient justification to lose critical features.

**Alternative:** Negotiate 7-day timeline for PREMIUM, or accept BASIC knowing quality will be insufficient.

---

### Example 3: LEGEND → LEGEND (Stay at Recommended)

**Persona:** CEO/Founder (Sam Altman type)
**APEX Score:** 90
**Sources Score:** 85
**Algorithm Recommendation:** LEGEND (95% confidence)

**Decision:** STAY at LEGEND ✅

**Rationale:**
- ✅ 50+ sources (books, interviews, podcasts)
- ✅ Clear public/private contradictions (LinkedIn vs internal)
- ✅ 4+ cognitive biases documented
- ✅ Timeline: 20 days (ample)
- ✅ Budget: 6x approved
- ✅ Flagship product - 95%+ required

**Red Flags:** 0
**Decision:** No downgrade justified - proceed with LEGEND

---

## 🎓 Training Scenarios

### Scenario 1: Budget Pressure
**Situation:** Client approved only 3x budget, but APEX recommends LEGEND.

**Question:** Downgrade to PREMIUM or negotiate?

**Answer:**
1. Check other red flags (sources, timeline, features)
2. If 0-1 other red flags → Negotiate budget (show value of LEGEND)
3. If 2+ other red flags → Accept PREMIUM (justified downgrade)
4. Document in downgrade template

---

### Scenario 2: Timeline Crunch
**Situation:** Launch in 7 days, APEX recommends LEGEND.

**Question:** Rush LEGEND or downgrade to PREMIUM?

**Answer:**
- ❌ NEVER rush LEGEND (quality will suffer)
- ✅ Downgrade to PREMIUM (can be done well in 7 days)
- Document timeline as RED FLAG
- Offer to upgrade to LEGEND post-launch if valuable

---

### Scenario 3: Insufficient Sources
**Situation:** Only 8 sources, APEX recommends PREMIUM.

**Question:** Proceed with PREMIUM or downgrade to BASIC?

**Answer:**
1. Check if multi-perspective thinking is evident in 8 sources
2. If YES → Attempt PREMIUM with caveat (may be 80% vs 85%)
3. If NO → Downgrade to BASIC (PREMIUM features not usable)
4. Collect more sources before upgrading later

---

## ✅ Quality Assurance Checklist

**Before approving any downgrade, verify:**

- [ ] **Downgrade justification template** completed
- [ ] **Red flags** counted (if < 2, reconsider downgrade)
- [ ] **Quality impact** assessed and acceptable
- [ ] **Alternative solutions** considered (negotiate budget/timeline?)
- [ ] **Client informed** of authenticity gap
- [ ] **Mitigation plan** documented
- [ ] **PO approval** obtained
- [ ] **Documented in tier selection** record

---

## 🔄 Post-Implementation Review

**After clone delivered, assess if downgrade was correct:**

```markdown
# Downgrade Decision Review

**Clone:** [Persona name]
**Recommended Tier:** [ ]
**Actual Tier:** [ ]
**Downgrade Rationale:** [Brief summary]

---

## Results

**Authenticity Achieved:** ____%
**Target for Selected Tier:** ____%
**Gap:** ____%

**Client Satisfaction:** [ ] / 10
**Features Used:** [ ] All / [ ] Most / [ ] Some / [ ] Few

---

## Was Downgrade Correct?

- [ ] ✅ **Correct** - Downgrade was justified, quality met needs
- [ ] ⚠️ **Should have stayed** - Downgrade was unnecessary, higher tier would have been better
- [ ] ⚠️ **Should have downgraded more** - Still over-engineered

**Lessons Learned:**
_______________

**Adjustments for Next Time:**
_______________
```

---

## 📚 Related Documentation

- **Tier Comparison:** `CLONE_AUTHENTICITY_TIERS.md`
- **EPIC 2 Specification:** `EPIC-2-Clone-Authenticity-Improvements.md`
- **APEX Algorithm:** `CLONE_AUTHENTICITY_TIERS.md` (Automatic Recommendation section)

---

**Document Version:** 1.0
**Status:** Active - Use for all tier downgrade decisions
**Maintained by:** Product Owner (Sarah)
**Last Updated:** 2025-10-16

---

## Quick Reference: Downgrade Decision Card

```
┌────────────────────────────────────────────────────────────┐
│              DOWNGRADE DECISION CARD                       │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  RED FLAGS (count them):                                   │
│  🔴 Timeline insufficient                                  │
│  🔴 Budget insufficient                                    │
│  🔴 Sources insufficient                                   │
│  🔴 Features won't be used                                 │
│  🔴 Persona not complex enough                             │
│                                                            │
│  DECISION RULE:                                            │
│  • 0-1 flags → STAY at recommended tier ✅                 │
│  • 2 flags → BORDERLINE → Consult team ⚠️                  │
│  • 3+ flags → MANDATORY DOWNGRADE 🔴                       │
│                                                            │
│  KEY QUESTION:                                             │
│  "Will higher tier features deliver ROI?"                  │
│                                                            │
├────────────────────────────────────────────────────────────┤
│  When in doubt → Consult PO before downgrading            │
└────────────────────────────────────────────────────────────┘
```
