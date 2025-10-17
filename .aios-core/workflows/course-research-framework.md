# Course Research Framework

**Version:** 1.0
**Purpose:** Systematic research workflow for creating data-driven, market-validated courses
**Owner:** Product Owner (PO) + Course Creator
**Duration:** Pre-creation (30-45 min) | Mid-creation (20 min) | Post-creation (30-45 min)

---

## 🎯 Framework Overview

This framework provides **three research workflows** aligned to the course creation lifecycle:

1. **Pre-Creation Research** - Market validation, pedagogy best practices, competitive analysis
2. **Mid-Creation Research** - Technical validation, trend checking, tool updates
3. **Post-Creation Research** - Engagement optimization, completion tactics, market feedback

Each workflow includes:
- ✅ **Search queries** (what to search, exact phrases)
- ✅ **Analysis framework** (how to interpret findings)
- ✅ **Application template** (how to use insights)
- ✅ **Time estimates** (realistic research durations)

---

## 🔍 Phase 1: Pre-Creation Research

**When:** Before creating any course content
**Duration:** 30-45 minutes
**Goal:** Validate market need, understand pedagogy, analyze competition

### **Research Areas (5 Searches)**

#### **Search 1: Market Demand & Pain Points**
**Query Template:**
```
"[topic] course" "struggling" OR "difficult" OR "hard to learn" 2024 OR 2025
```

**Example:**
```
"no-code development course" "struggling" OR "difficult" OR "hard to learn" 2024 OR 2025
```

**What to Look For:**
- Common complaints about existing courses
- Specific pain points students express
- Gaps in current offerings
- Language students use (for marketing copy)

**Documentation Template:**
```markdown
### Market Pain Points Found:
1. [Pain point 1] - Source: [URL]
2. [Pain point 2] - Source: [URL]
3. [Pain point 3] - Source: [URL]

### Student Language Patterns:
- "[Quote showing how students describe their struggle]"
- "[Quote showing desired outcome]"

### Gaps in Existing Courses:
- [Gap 1]
- [Gap 2]
```

---

#### **Search 2: Pedagogy Best Practices**
**Query Template:**
```
"[topic] teaching" best practices pedagogy 2024 OR 2025
```

**Example:**
```
"programming teaching" best practices pedagogy 2025
```

**What to Look For:**
- Proven teaching methodologies for this domain
- Scaffolding strategies
- Common misconceptions to address
- Effective metaphors or analogies

**Documentation Template:**
```markdown
### Pedagogy Insights:
1. **Methodology:** [e.g., "Concrete before abstract"]
   - Source: [URL]
   - Application: [How to use in course]

2. **Scaffolding:** [e.g., "See-Do-Teach progression"]
   - Source: [URL]
   - Application: [How to structure lessons]

3. **Misconceptions:** [e.g., "Students think X but reality is Y"]
   - Source: [URL]
   - How to Address: [Strategy]
```

---

#### **Search 3: Competitive Analysis**
**Query Template:**
```
best "[topic]" courses 2024 OR 2025 reviews
```

**Example:**
```
best "no-code app development" courses 2025 reviews
```

**What to Look For:**
- What students love about competitors
- What students hate about competitors
- Price points
- Unique differentiators

**Documentation Template:**
```markdown
### Competitor Analysis:

| Course | Price | Duration | What Students Love | What Students Hate | Differentiation Opportunity |
|--------|-------|----------|-------------------|-------------------|----------------------------|
| [Name] | [Price] | [Hours] | [Strength] | [Weakness] | [How we can be different] |
| [Name] | [Price] | [Hours] | [Strength] | [Weakness] | [How we can be different] |

### Our Differentiation Strategy:
- [Unique angle 1]
- [Unique angle 2]
- [Unique angle 3]
```

---

#### **Search 4: Tool/Platform Currency**
**Query Template:**
```
"[tool/platform name]" best practices 2025 OR latest OR "what's new"
```

**Example:**
```
"Bolt.new" best practices 2025 OR "Lovable.dev" tutorials
```

**What to Look For:**
- Latest features or updates
- Current best practices
- Common gotchas or limitations
- Alternative tools gaining traction

**Documentation Template:**
```markdown
### Tool Currency Check:

**[Tool Name]:**
- Latest Version: [X.X.X]
- Recent Updates: [What changed]
- Best Practices 2025: [Key insights]
- Limitations: [Known issues to address in course]
- Alternatives: [Other tools students might ask about]

### Teaching Implications:
- [What to update in curriculum]
- [New features to showcase]
- [Deprecated features to avoid]
```

---

#### **Search 5: Engagement & Completion Tactics**
**Query Template:**
```
online course completion rates strategies 2024 OR 2025
```

**What to Look For:**
- Proven tactics to boost completion (Course Buddy, gamification, etc.)
- Industry benchmarks (average completion %)
- Psychological triggers (accountability, progress visibility)
- Platform features that help (discussion forums, progress bars)

**Documentation Template:**
```markdown
### Engagement Tactics:

| Tactic | Impact | Effort | Priority | Application in Our Course |
|--------|--------|--------|----------|--------------------------|
| Course Buddy | +504% completion | Low | HIGH | [How we'll implement] |
| Gamification | +20-30% engagement | Medium | MEDIUM | [How we'll implement] |
| Mobile-first | +45% speed | Low | HIGH | [How we'll implement] |

### Industry Benchmarks:
- Average completion: [X%]
- Top quartile: [Y%]
- Our target: [Z%]
```

---

### **Pre-Creation Research Deliverable**

Consolidate all findings into:

**File:** `outputs/courses/[course-name]/PRE-CREATION-RESEARCH.md`

**Structure:**
```markdown
# Pre-Creation Research: [Course Name]

**Date:** [Date]
**Researched By:** [Name]

## Market Validation
[Pain points, student language, gaps]

## Pedagogy Strategy
[Methodologies, scaffolding, misconceptions]

## Competitive Positioning
[Competitor analysis table, differentiation]

## Technical Currency
[Tool updates, best practices, limitations]

## Engagement Strategy
[Tactics to implement, benchmarks]

## Go/No-Go Decision
- [ ] Market demand validated
- [ ] Pedagogy approach defined
- [ ] Differentiation clear
- [ ] Tools current and accessible
- [ ] Engagement plan ready

**Decision:** GO / NO-GO / PIVOT

**If GO, Next Steps:**
1. Create course brief
2. Begin content creation
3. Schedule mid-creation research checkpoint
```

---

## 🔄 Phase 2: Mid-Creation Research

**When:** After ~50% of content is created (e.g., after Module 1 of 2-module course)
**Duration:** 15-20 minutes
**Goal:** Validate technical accuracy, check for tool updates, adjust based on emerging trends

### **Research Areas (3 Searches)**

#### **Search 1: Technical Validation**
**Query Template:**
```
"[specific technical topic from course]" [year] best practices OR tutorial OR guide
```

**Example:**
```
"Supabase Row Level Security" 2025 best practices
```

**What to Look For:**
- Confirm your approach is current
- Identify any new best practices emerged
- Check for security or performance considerations

**Action:** Update lesson if significant new info found

---

#### **Search 2: Tool Updates Check**
**Query Template:**
```
"[tool name]" changelog OR "release notes" OR updates [last 30 days]
```

**Example:**
```
"Bolt.new" changelog OR updates January 2025
```

**What to Look For:**
- Breaking changes that affect your tutorial
- New features worth mentioning
- Bug fixes that resolve issues you warned about

**Action:** Add note to lesson if relevant update found

---

#### **Search 3: Student Feedback on Similar Content**
**Query Template:**
```
"[topic]" tutorial reddit OR forum "confusing" OR "unclear"
```

**Example:**
```
"Bolt.new tutorial" reddit "confusing" OR "unclear"
```

**What to Look For:**
- Common points where students get stuck
- Language that confuses (jargon)
- Missing context or assumptions made

**Action:** Add troubleshooting or clarification to your content

---

### **Mid-Creation Research Deliverable**

**File:** `outputs/courses/[course-name]/MID-CREATION-RESEARCH.md`

**Structure:**
```markdown
# Mid-Creation Research: [Course Name]

**Date:** [Date]
**Progress:** [X% complete]

## Technical Validation Results
- [Finding 1] → Action: [Update lesson X]
- [Finding 2] → Action: [No change needed]

## Tool Updates
- [Tool]: [Update] → Action: [Add note to lesson Y]

## Student Confusion Patterns
- [Pattern 1] → Action: [Add troubleshooting to lesson Z]

## Adjustments Made:
- [ ] Lesson 1.1: [What changed]
- [ ] Lesson 2.1: [What changed]

**Continue Creation:** YES / PIVOT
```

---

## ✨ Phase 3: Post-Creation Research

**When:** After all content is created, before launch
**Duration:** 30-45 minutes
**Goal:** Identify optimization opportunities based on latest engagement research

### **Research Areas (5 Searches)**

#### **Search 1: Latest Engagement Tactics**
**Query Template:**
```
online course engagement tactics 2025 OR "course completion" strategies
```

**What to Look For:**
- New psychological triggers discovered
- Platform features you haven't used
- Case studies with concrete metrics

---

#### **Search 2: Accessibility & Inclusion**
**Query Template:**
```
course accessibility best practices 2025 OR inclusive online learning
```

**What to Look For:**
- Alternative text for images
- Screen reader compatibility
- Neurodivergent-friendly formatting
- Language inclusivity

---

#### **Search 3: Monetization Strategies**
**Query Template:**
```
online course monetization models 2025 OR pricing strategies
```

**What to Look For:**
- Current price points for similar courses
- Bundling strategies
- Upsell/cross-sell tactics
- Freemium vs. paid approaches

---

#### **Search 4: Launch Tactics**
**Query Template:**
```
course launch strategies 2025 OR "course marketing" tactics
```

**What to Look For:**
- Pre-launch hype tactics
- Beta tester programs
- Early bird pricing psychology
- Social proof collection

---

#### **Search 5: Retention & Community**
**Query Template:**
```
student retention online courses 2025 OR community building strategies
```

**What to Look For:**
- Discussion forum best practices
- Office hours formats
- Peer learning structures
- Alumni engagement

---

### **Post-Creation Research Deliverable**

**File:** `outputs/courses/[course-name]/POST-CREATION-RESEARCH.md`

**Structure:**
```markdown
# Post-Creation Research: [Course Name]

**Date:** [Date]
**Course Status:** Content complete, pre-launch

## Engagement Optimization
[Tactics found, priority ranking, implementation plan]

## Accessibility Improvements
[Checklist of accessibility standards, what we have, what's missing]

## Pricing & Monetization
[Market rates, our positioning, bundling ideas]

## Launch Strategy
[Pre-launch tactics, beta program plan, social proof plan]

## Community Plan
[Forum structure, peer learning, alumni engagement]

## Implementation Priority

### Phase 1: Pre-Launch (Must Do)
1. [Tactic] - [X min] - [Expected impact]
2. [Tactic] - [X min] - [Expected impact]

### Phase 2: Post-Launch (Should Do)
1. [Tactic] - [X min] - [Expected impact]

### Phase 3: V1.1 (Nice to Have)
1. [Tactic] - [X min] - [Expected impact]

**Launch Readiness:** READY / OPTIMIZE FIRST
```

---

## 📊 Research Analysis Framework

### **How to Evaluate Research Findings**

For each finding, ask:

1. **Relevance:** Does this apply to our course/audience? (Score 1-5)
2. **Impact:** How much will this improve outcomes? (Score 1-5)
3. **Effort:** How hard is it to implement? (Score 1-5, lower = easier)
4. **Urgency:** Must have pre-launch or nice-to-have? (Critical/High/Medium/Low)

**Priority Formula:**
```
Priority Score = (Relevance × Impact) / Effort
```

**Priority Ranking:**
- **>4.0:** HIGH - Implement immediately
- **2.0-4.0:** MEDIUM - Implement if time allows
- **<2.0:** LOW - Defer to post-launch

---

## 🎯 Research Quality Checklist

Before considering research "complete":

- [ ] All searches documented with sources
- [ ] Findings analyzed using framework above
- [ ] Priority scores calculated
- [ ] Implementation plan created
- [ ] Time estimates provided
- [ ] Expected impact quantified (when possible)
- [ ] Stakeholders informed of key findings

---

## 📚 Related Resources

- **Course QA Checklist:** `.aios-core/checklists/course-qa-checklist.md`
- **Course Creation Workflow:** `.aios-core/workflows/course-creation-workflow.md`
- **QA Report Template:** `expansion-packs/creator-os/templates/course-qa-report.md`

---

## 💡 Pro Tips

**Time Management:**
- Set timer for each search (5-7 min max)
- Use incognito mode to avoid personalized results
- Save URLs immediately to avoid losing sources
- Don't over-research - 80/20 rule applies

**Search Operators:**
- `"exact phrase"` for precision
- `OR` for alternatives
- `site:reddit.com` for specific platforms
- `after:2024-01-01` for recency

**Red Flags (Stop & Pivot):**
- No market pain points found (no demand)
- 10+ competitors with identical approach (oversaturated)
- Tools are deprecated or unstable (tech risk)
- Negative reviews dominate (concept doesn't work)

---

*Course Research Framework v1.0 | Product Owner Framework | AIOS-FULLSTACK*
