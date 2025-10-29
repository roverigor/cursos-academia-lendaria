# Fragment Segmentation Rules - MMOS v5.0
**MIU-Based Segmentation Guidelines for Cognitive Clone Development**

Version: 5.0  
Last Updated: 2025-01-26  
Status: Production  
Scope: Fragment Extraction Standards

---

## Core Principle

> **"A fragment must be the SMALLEST COMPLETE and SELF-CONTAINED unit that enables psychological interpretation WITHOUT external context."**

This ensures each fragment in the knowledge base is a true Minimal Interpretable Unit (MIU).

---

## 1. COMPLETENESS RULES

### Rule 1.1: Reference Resolution
**All references must be resolved within the fragment**

```
❌ INCOMPLETE (dangling reference):
"I spent little time there, only until I was two years old"
# "there" = undefined. Not interpretable.

✅ COMPLETE:
"I was born in Maricá, but I spent little time there, only until I was two years old"
# "there" = Maricá. Fully interpretable.
```

### Rule 1.2: Pronoun Antecedents
**Pronouns must have clear antecedents within the fragment**

```
❌ INCOMPLETE:
"He tends to overthink every decision"
# "He" = undefined. Who?

✅ COMPLETE:
"Alan tends to overthink every decision"
# OR with clear context:
"When asked about his brother, Pedro said: 'He tends to overthink every decision'"
# "He" = brother (clear from context)
```

### Rule 1.3: Essential Context
**Include temporal/spatial context when required for interpretation**

```
❌ INCOMPLETE:
"After that incident, I never delegated important tasks again"
# "that incident" = undefined. What happened?

✅ COMPLETE:
"After my team missed a critical deadline, I never delegated important tasks again"
# Complete causal understanding
```

---

## 2. PRESERVATION RULES

### Rule 2.1: Causal Chains
**ALWAYS keep cause-effect relationships together**

```
✅ PRESERVE AS ONE FRAGMENT:
"I micromanage my team because I've been burned before when delegating critical tasks"

WHY: The "because" clause explains the behavior
- Splitting loses the psychological motivation
- Both parts needed for trait inference
```

**Causal markers to preserve**: because, since, as, due to, therefore, so, thus, hence, consequently, which is why, that's why

### Rule 2.2: Temporal Dependencies
**ALWAYS keep trigger-response sequences together**

```
✅ PRESERVE AS ONE FRAGMENT:
"When I receive negative feedback, I initially get defensive, then I process it privately, and eventually I integrate the valid points"

WHY: Complete behavioral sequence
- Shows full response pattern
- Splitting loses the psychological process
```

**Temporal markers to preserve**: when, whenever, after, before, while, during, as soon as, until, once

### Rule 2.3: Essential Elaborations
**ALWAYS keep clarifying elaborations that define meaning**

```
✅ PRESERVE AS ONE FRAGMENT:
"I'm a systems thinker - I can't solve a problem without first mapping all the interconnections and dependencies"

WHY: The elaboration defines what "systems thinker" means for this person
- Without it, the label is too vague
- Together they form one complete insight
```

**Elaboration markers**: which means, that is, namely, specifically, in other words, meaning, for example (when defining, not listing)

---

## 3. SEPARATION RULES

### Rule 3.1: Contrasts and Oppositions
**ALWAYS split contrasting or opposing ideas**

```
❌ DO NOT KEEP TOGETHER:
"I love brainstorming creative solutions, but I also need structured processes"

✅ SPLIT INTO TWO FRAGMENTS:
Fragment 1: "I love brainstorming creative solutions"
Fragment 2: "I need structured processes"

WHY: Independent, potentially contradictory traits
- Fragment 1 → high Openness
- Fragment 2 → high Conscientiousness
```

**Contrast markers requiring split**: but, however, although, though, yet, on the other hand, whereas, while (when contrastive), nevertheless

### Rule 3.2: Topic Changes
**ALWAYS split when subject matter changes**

```
❌ DO NOT KEEP TOGETHER:
"I graduated from MIT in 2018, and my favorite programming language is Python"

✅ SPLIT INTO TWO FRAGMENTS:
Fragment 1: "I graduated from MIT in 2018"
Fragment 2: "My favorite programming language is Python"

WHY: Completely independent information
```

### Rule 3.3: Multiple Attributions
**ALWAYS split different sources of information**

```
❌ DO NOT KEEP TOGETHER:
"I see myself as highly organized, but my colleagues say I'm actually quite chaotic"

✅ SPLIT INTO TWO FRAGMENTS:
Fragment 1: "I see myself as highly organized" [self-perception]
Fragment 2: "My colleagues say I'm actually quite chaotic" [external perception]

WHY: Different perspectives that may conflict
```

---

## 4. VALIDATION CHECKLIST

Before approving any fragment, verify:

### Structural Completeness
- [ ] Clear subject (WHO is acting/speaking?)
- [ ] Complete predicate (WHAT was said/done?)
- [ ] All references resolved (no dangling "it", "that", "there")
- [ ] All pronouns have antecedents

### Semantic Completeness
- [ ] Interpretable without any external context
- [ ] Clear psychological meaning
- [ ] No critical information missing
- [ ] Single, coherent idea (or properly linked ideas)

### Boundary Check
- [ ] No separable contrasts within fragment
- [ ] No independent topics mixed together
- [ ] No multiple attributions combined
- [ ] Causal/temporal chains preserved if present

---

## 5. PRACTICAL EXAMPLES

### Example 1: Complex Biography

```
ORIGINAL TEXT:
"Well, I was born in Maricá, but I spent little time there, only until 
I was two years old. There I lived with my mother, father, and older brother."

ANALYSIS:
- "but" appears to be contrastive
- "there" (first instance) refers to Maricá
- "There" (second instance) also refers to Maricá
- However, the contrast is minimal and all parts are about early childhood location/family

CORRECT FRAGMENTATION:
[KEEP AS ONE FRAGMENT - the reference chain requires it stay together]

RESULTING FRAGMENT:
{
  "content": "Well, I was born in Maricá, but I spent little time there, only until I was two years old. There I lived with my mother, father, and older brother.",
  "type": "direct_quote",
  "context": "Describing family origins and early childhood",
  "insight": "Born in Maricá (RJ), nuclear family with older brother, early mobility - left hometown at age 2"
}
```

### Example 2: Behavioral Pattern

```
ORIGINAL TEXT:
"Whenever I start a new project, I get completely obsessed, work 16-18 hours 
a day, burn out after three weeks, abandon it, feel guilty for a few days, 
then find something new to obsess over."

ANALYSIS:
- Complete temporal sequence (trigger → behaviors → cycle)
- All parts needed to understand the pattern
- "Whenever" indicates this is a recurring pattern

CORRECT FRAGMENTATION:
[KEEP AS ONE FRAGMENT - it's a single behavioral pattern]

RESULTING FRAGMENT:
{
  "content": "Whenever I start a new project, I get completely obsessed, work 16-18 hours a day, burn out after three weeks, abandon it, feel guilty for a few days, then find something new to obsess over.",
  "type": "direct_quote",
  "context": "Describing work patterns and project engagement style",
  "insight": "Shows cyclical pattern of obsession-burnout-guilt-renewal, suggesting high initial enthusiasm but poor sustained engagement"
}
```

### Example 3: Mixed Topics

```
ORIGINAL TEXT:
"I love teaching AI to entrepreneurs, it energizes me, but I hate 
administrative tasks, and my wife thinks I should delegate more."

ANALYSIS:
- Three distinct ideas:
  1. Love of teaching (with elaboration)
  2. Hatred of admin tasks (contrast)
  3. Wife's opinion about delegation

CORRECT FRAGMENTATION:
Fragment 1: "I love teaching AI to entrepreneurs, it energizes me"
Fragment 2: "I hate administrative tasks"  
Fragment 3: "My wife thinks I should delegate more"

RESULTING FRAGMENTS:
{
  "content": "I love teaching AI to entrepreneurs, it energizes me",
  "type": "direct_quote",
  "context": "Discussing professional preferences",
  "insight": "Passionate about teaching, specifically AI to entrepreneurs - finds it energizing"
}

{
  "content": "I hate administrative tasks",
  "type": "direct_quote",
  "context": "Discussing professional preferences",
  "insight": "Strong aversion to administrative work"
}

{
  "content": "My wife thinks I should delegate more",
  "type": "direct_quote",
  "context": "External feedback on work habits",
  "insight": "Spouse observes delegation issues - external perspective on control tendencies"
}
```

---

## 6. DECISION FLOWCHART

```
Start with text segment
    ↓
[Check references] → Any undefined pronouns/references? 
    ↓ No                 ↓ Yes → Expand to include antecedents
    ↓
[Check relationships] → Contains because/when/after clauses?
    ↓ No                 ↓ Yes → Keep together
    ↓
[Check contrasts] → Contains but/however/although?
    ↓ No              ↓ Yes → Split at contrast
    ↓
[Check topics] → Multiple independent topics?
    ↓ No           ↓ Yes → Split by topic
    ↓
[Check attribution] → Multiple sources/perspectives?
    ↓ No                ↓ Yes → Split by source
    ↓
[Validate] → Is it complete and self-contained?
    ↓ Yes              ↓ No → Review and adjust
    ↓
✅ Valid Fragment
```

---

## 7. INTEGRATION WITH EXISTING SCHEMA

These rules work within the existing MMOS v5.0 fragment structure:

```yaml
# No new fields needed - rules guide the "content" field extraction
fragment:
  id: "FRAG_XXX_001"
  category: "[appropriate category]"
  source: "[source ID]"
  location: "[location in source]"
  type: "[direct_quote|paraphrase|etc]"
  relevance: [1-10]
  content: "[COMPLETE, SELF-CONTAINED TEXT following all rules above]"
  context: "[situation/topic being discussed]"
  insight: "[what this reveals about the person]"
  tags: ["relevant", "tags"]
  metadata:
    notes: "[Can note fragmentation decisions here if needed]"
    # Example: "Kept causal chain together despite length"
    # Example: "Split from larger quote at contrast marker"
```

---

## 8. COMMON ERRORS TO AVOID

### Error 1: Over-Fragmentation
❌ **Wrong**: Splitting "I love coffee because it helps me focus"  
✅ **Right**: Keep together (causal relationship)

### Error 2: Under-Fragmentation  
❌ **Wrong**: Keeping "I'm organized but my desk is always messy"  
✅ **Right**: Split at contrast (contradictory signals)

### Error 3: Dangling References
❌ **Wrong**: "This approach works best for me"  
✅ **Right**: Include what "this approach" refers to

### Error 4: Mixed Attributions
❌ **Wrong**: "I'm creative and my boss agrees"  
✅ **Right**: Split into self-perception and external validation

### Error 5: Lost Context
❌ **Wrong**: "Not anymore" (as complete fragment)  
✅ **Right**: Include the question/statement it responds to

---

## 9. QUALITY METRICS

Track these metrics to ensure fragmentation quality:

- **Completeness Rate**: % of fragments that pass all validation checks
- **Average Fragment Length**: Should vary based on content, not arbitrary limits
- **Reference Resolution**: 100% of fragments should have resolved references
- **Causal Preservation**: 100% of causal chains should be kept intact
- **Clean Separations**: 100% of contrasts should be properly split

---

## 10. FINAL NOTES

Remember: The goal is to create fragments that a psychologist could interpret in isolation to understand personality traits, behavioral patterns, and cognitive styles. Each fragment should be a complete thought that stands alone while preserving the natural structure of human expression.

When in doubt, ask: "If this were the ONLY piece of information about this person, could I make a meaningful psychological inference?" If no, the fragment needs expansion or context. If yes, check if it contains separable ideas that should be split.

---

*End of Fragment Segmentation Rules - MMOS v5.0*
