# Market Research Task

**Task ID:** `market-research`
**Agent:** `course-architect`
**Type:** Discovery & Intelligence
**Elicit:** true
**Duration:** 5-10 minutes

---

## 📋 Task Overview

Conduct market research on similar courses to gather competitive intelligence, identify content gaps, and discover differentiation opportunities before generating the curriculum.

This task uses web search to analyze existing courses, extract common patterns, identify what's missing in the market, and suggest unique angles based on the course's ICP and objectives.

---

## 🎯 Inputs Required

### Required Files:
- `outputs/courses/{slug}/COURSE-BRIEF.md` (filled with 8 sections)
  - Section 2: ICP (target audience)
  - Section 3: Content & Pedagogy (learning objectives)
  - Section 1: Basic Info (course title, topic)

### Required Parameters:
- `course_slug` - The course identifier (kebab-case)

---

## 📤 Outputs Generated

### Research Folder Structure:
```
outputs/courses/{slug}/research/
├── market-analysis.md      # Competitive landscape overview
├── content-gaps.md          # Identified market gaps
├── differentiation.md       # Unique positioning opportunities
└── sources.md               # List of analyzed courses/materials
```

### Files Created:

#### 1. `market-analysis.md`
- **Competitive Courses:** List of 8-15 similar courses found
- **Common Curriculum Patterns:** What most courses cover
- **Popular Pedagogical Approaches:** How competitors structure content
- **Price Points:** Market pricing analysis
- **Student Reviews Summary:** Common praise and complaints

#### 2. `content-gaps.md`
- **Topics Missing in Market:** What competitors aren't covering
- **Depth Gaps:** Where existing courses stay superficial
- **ICP Misalignment:** Where competitors miss the target audience
- **Practice Gaps:** Missing hands-on components

#### 3. `differentiation.md`
- **Unique Angles:** How this course can stand out
- **ICP-Driven Positioning:** Alignment with specific audience needs
- **Voice/Style Differentiation:** Instructor personality advantages
- **Format Innovations:** Delivery method opportunities

#### 4. `sources.md`
- **Course Links:** URLs to analyzed courses
- **Metadata:** Platform, price, rating, enrollment, duration
- **Access Notes:** Free/paid, prerequisites, certifications

---

## 🔄 Workflow Steps

### STEP 1: Load Course Context
```yaml
action: load_course_brief
inputs:
  - outputs/courses/{slug}/COURSE-BRIEF.md
extracts:
  - course_title
  - course_topic
  - icp_profile
  - learning_objectives
```

**Validation:**
- ✅ COURSE-BRIEF.md exists
- ✅ Section 1 (Basic Info) is filled
- ✅ Section 2 (ICP) is filled
- ✅ Section 3 (Objectives) is filled

**On Validation Failure:**
- ❌ ERROR: "COURSE-BRIEF.md incomplete. Fill required sections before research."
- Exit task with instructions to complete brief first

---

### STEP 2: Generate Search Queries
```yaml
action: generate_search_queries
method: strategic_query_generation
output: search_queries[]
```

**Query Strategy:**
Generate 4-6 targeted search queries:

1. **Direct Topic Search:**
   - `"{course_topic}" online course`
   - `"learn {course_topic}" tutorial`

2. **Platform-Specific Searches:**
   - `site:udemy.com {course_topic}`
   - `site:coursera.org {course_topic}`
   - `site:youtube.com {course_topic} full course`

3. **ICP-Targeted Search:**
   - `"{course_topic} for {icp_role}"` (e.g., "Python for data analysts")
   - `"{course_topic} {icp_experience_level}"` (e.g., "React intermediate course")

4. **Problem-Focused Search:**
   - `"{icp_pain_point} course"` (from COURSE-BRIEF ICP section)
   - `"how to {icp_goal}"` (from COURSE-BRIEF ICP section)

**Example:**
```
Course Topic: "Supabase Backend Development"
ICP: Junior fullstack developers wanting to avoid backend complexity

Generated Queries:
1. "Supabase online course"
2. site:udemy.com Supabase
3. "backend for frontend developers" course
4. "build backend without servers" tutorial
5. "Supabase full course" site:youtube.com
6. "zero backend development" course
```

---

### STEP 3: Execute Web Search
```yaml
action: web_search
method: parallel_search
inputs: search_queries[]
output: search_results[]
```

**For Each Query:**
- Use WebSearch tool
- Collect top 10-15 results
- Extract metadata:
  - Title
  - URL
  - Platform (Udemy, Coursera, YouTube, Blog, etc.)
  - Snippet/description
  - Apparent duration (if visible)
  - Price indicator (free/paid)

**Deduplication:**
- Remove duplicate URLs
- Merge results by course title (same course on different pages)

**Target:** 15-25 unique courses/resources

---

### STEP 4: Analyze Course Content
```yaml
action: analyze_courses
method: deep_content_extraction
inputs: search_results[]
output: competitive_analysis
```

**For Top 8-12 Courses:**

**4.1. Extract Curriculum Structure:**
- Use WebFetch to scrape course page
- Extract:
  - Module titles
  - Lesson titles
  - Learning objectives (if listed)
  - Prerequisites
  - Duration
  - Skill level
  - Instructor bio (if available)

**4.2. Extract Student Feedback:**
- Reviews summary (praise patterns)
- Common complaints
- Missing features students request
- Rating distribution

**4.3. Identify Pedagogical Approach:**
- Lecture-heavy vs. project-based
- Theory vs. practice ratio
- Assessment methods
- Support materials (templates, checklists, etc.)

**4.4. Price & Positioning Analysis:**
- Price point
- Discount patterns
- Enrollment numbers (if visible)
- Certifications offered

---

### STEP 5: Identify Patterns & Gaps
```yaml
action: pattern_analysis
inputs: competitive_analysis
outputs:
  - common_patterns
  - content_gaps
  - differentiation_opportunities
```

**5.1. Common Curriculum Patterns:**
```markdown
Analyze all extracted curricula and identify:
- Topics 80%+ of courses cover (core curriculum)
- Typical lesson progression (beginner → advanced)
- Common module groupings
- Standard prerequisites

Example Output:
---
## Common Patterns (8/10 courses)
- Module 1: Introduction to {topic} (all courses)
- Module 2: Setup & Installation (9/10 courses)
- Module 3: Core Concepts (all courses)
- Module 4: Practical Project (6/10 courses)
- Module 5: Advanced Topics (4/10 courses)

## Typical Duration: 8-12 hours
## Common Prerequisites: Basic programming knowledge
---
```

**5.2. Content Gaps Analysis:**
```markdown
Identify what's MISSING or UNDERSERVED:

Gap Categories:
1. **Topic Gaps:** Concepts not covered by competitors
2. **Depth Gaps:** Topics covered superficially
3. **ICP Gaps:** Courses not tailored to specific audience
4. **Practice Gaps:** Lack of hands-on exercises
5. **Support Gaps:** Missing templates, checklists, resources
6. **Integration Gaps:** Don't show real-world integrations

Example Output:
---
## Identified Gaps

### Topic Gaps:
- None of the courses cover {specific_advanced_topic}
- Only 2/10 courses mention {important_subtopic}

### Depth Gaps:
- All courses introduce {concept} but don't explain WHY
- Surface-level coverage of {critical_topic}

### ICP Gaps:
- No courses specifically for {icp_role}
- All assume {prerequisite} that our ICP doesn't have

### Practice Gaps:
- 7/10 courses are lecture-heavy (theory > 70%)
- Only 3/10 include real-world projects
- No courses provide production-ready templates
---
```

**5.3. Differentiation Opportunities:**
```markdown
Based on gaps + ICP + course objectives, identify unique angles:

Differentiation Dimensions:
1. **Content Angle:** Unique topics/depth
2. **Audience Angle:** ICP-specific tailoring
3. **Pedagogy Angle:** Teaching approach
4. **Format Angle:** Delivery innovation
5. **Voice Angle:** Instructor personality
6. **Resource Angle:** Templates, tools, checklists

Example Output:
---
## Differentiation Opportunities

### 1. ICP-Driven Focus (HIGH IMPACT)
**Gap:** No courses for {icp_role} specifically
**Opportunity:** Tailor all examples to {icp_context}
**Competitive Edge:** Only course speaking directly to this audience

### 2. Practice-First Approach (MEDIUM IMPACT)
**Gap:** 70% of courses are lecture-heavy
**Opportunity:** Flip to 60% practice, 40% theory
**Competitive Edge:** Hands-on, project-driven learning

### 3. Production-Ready Resources (HIGH IMPACT)
**Gap:** No courses include templates/checklists
**Opportunity:** Provide starter kits, deployment checklists
**Competitive Edge:** Students finish with real assets, not just knowledge

### 4. Voice & Style (MEDIUM IMPACT)
**Gap:** Most courses are formal/academic
**Opportunity:** {instructor_voice_from_brief} - casual, story-driven
**Competitive Edge:** More engaging, personality-driven teaching
---
```

---

### STEP 6: Generate Research Reports
```yaml
action: generate_reports
inputs:
  - competitive_analysis
  - common_patterns
  - content_gaps
  - differentiation_opportunities
outputs:
  - outputs/courses/{slug}/research/*.md
```

**6.1. Create `market-analysis.md`:**
```markdown
# Market Analysis: {Course Title}

**Research Date:** {current_date}
**Courses Analyzed:** {count}
**Research Duration:** {minutes} minutes

---

## Competitive Landscape

### Analyzed Courses

| # | Course Title | Platform | Duration | Price | Rating | Enrollment |
|---|--------------|----------|----------|-------|--------|------------|
| 1 | ... | Udemy | 12h | $89 | 4.6/5 | 45K |
| 2 | ... | Coursera | 8h | $49/mo | 4.8/5 | 120K |
| ... | ... | ... | ... | ... | ... | ... |

### Common Curriculum Patterns

{common_patterns_from_step5}

### Popular Pedagogical Approaches

- **Lecture-Dominant:** 7/10 courses (theory > 60%)
- **Project-Based:** 3/10 courses
- **Assessment Methods:** Quizzes (8/10), Projects (4/10), Peer Review (1/10)

### Market Price Points

- **Budget Tier:** $20-40 (3 courses)
- **Mid Tier:** $50-90 (5 courses)
- **Premium Tier:** $100+ (2 courses)
- **Subscription:** $30-50/month (Coursera, Skillshare)

### Student Feedback Summary

**Common Praise:**
- {extracted_praise_patterns}

**Common Complaints:**
- {extracted_complaint_patterns}

---

## Market Insights

### Market Maturity: {Emerging|Growing|Mature|Saturated}

**Indicators:**
- Course count: {count}
- Average rating: {avg_rating}
- Total enrollments: {estimated_total}

### Opportunities for New Entrants:
1. {opportunity_1}
2. {opportunity_2}
3. {opportunity_3}

---

**Generated by:** CreatorOS Market Research
**Sources:** See `sources.md`
```

**6.2. Create `content-gaps.md`:**
```markdown
# Content Gaps Analysis: {Course Title}

**ICP:** {icp_from_brief}
**Learning Objectives:** {objectives_count} defined

---

{content_gaps_from_step5_2}

---

## Gap Prioritization

| Gap | Impact | Feasibility | Priority |
|-----|--------|-------------|----------|
| {gap_1} | High | High | P0 (Must Address) |
| {gap_2} | High | Medium | P1 (Should Address) |
| {gap_3} | Medium | High | P1 (Should Address) |
| {gap_4} | Low | Low | P2 (Consider) |

---

## Recommendations for Curriculum

1. **Include {gap_topic}** - No competitor covers this (P0)
2. **Deep-dive {shallow_topic}** - Competitors stay superficial (P1)
3. **Tailor examples to {icp_context}** - ICP gap opportunity (P0)
4. **Add {practice_type} exercises** - Practice gap (P1)

---

**Generated by:** CreatorOS Market Research
**Next Step:** Feed into COURSE-BRIEF reformulation

**Reformulation Guidance:**
- P0 gaps → Add as new learning objectives
- P1 gaps → Integrate into existing modules
- P2 gaps → Note for future consideration
```

**6.3. Create `differentiation.md`:**
```markdown
# Differentiation Strategy: {Course Title}

**Competitive Courses Analyzed:** {count}
**Unique Positioning Opportunities:** {count}

---

{differentiation_opportunities_from_step5_3}

---

## Recommended Positioning Statement

> **FOR** {icp_role} **WHO** {icp_pain_point},
> **THIS COURSE** {unique_value_prop},
> **UNLIKE** {competitor_courses} **WHICH** {competitor_limitation},
> **WE PROVIDE** {differentiation_1}, {differentiation_2}, {differentiation_3}.

**Example:**
> FOR junior fullstack developers WHO want to build backends without server complexity,
> THIS COURSE teaches production-ready Supabase development,
> UNLIKE generic Supabase tutorials WHICH focus on toy examples,
> WE PROVIDE real-world architectures, deployment checklists, and ICP-tailored examples.

---

## Differentiation Dimensions Summary

| Dimension | Our Approach | Competitor Approach | Advantage |
|-----------|--------------|---------------------|-----------|
| **Audience** | {icp_specific} | Generic developers | Relevance |
| **Pedagogy** | {teaching_approach} | Lecture-heavy | Engagement |
| **Resources** | {unique_resources} | Video-only | Completeness |
| **Voice** | {instructor_voice} | Formal/academic | Personality |
| **Depth** | {depth_approach} | Surface-level | Mastery |

---

## Integration with Curriculum Generation

**When generating curriculum, prioritize:**

1. ✅ **Include gap topics** (from content-gaps.md)
2. ✅ **Apply differentiation angles** (from table above)
3. ✅ **Avoid commoditized patterns** (unless core curriculum)
4. ✅ **Lean into unique voice/style** (from COURSE-BRIEF Section 4)

---

**Generated by:** CreatorOS Market Research
**Next Step:** Feed into COURSE-BRIEF reformulation

**Reformulation Guidance:**
- Update Section 1 subtitle with positioning angle
- Enhance Section 4 voice with differentiation emphasis
- Refine Section 5 format based on competitive patterns
- Update Section 6 pricing/positioning statement
```

**6.4. Create `sources.md`:**
```markdown
# Research Sources: {Course Title}

**Research Date:** {current_date}
**Total Sources:** {count}

---

## Analyzed Courses

### 1. {Course Title 1}
- **Platform:** {platform}
- **URL:** {url}
- **Instructor:** {instructor_name}
- **Duration:** {duration}
- **Price:** {price}
- **Rating:** {rating} ({review_count} reviews)
- **Enrollment:** {enrollment_estimate}
- **Last Updated:** {last_update_date}
- **Access:** {free|paid|subscription}
- **Certificate:** {yes|no}
- **Curriculum:** {module_count} modules, {lesson_count} lessons
- **Notes:** {any_special_observations}

### 2. {Course Title 2}
...

---

## Additional Resources

### Blog Posts / Tutorials
1. [{Title}]({url}) - {author}, {date}
2. [{Title}]({url}) - {author}, {date}

### YouTube Playlists
1. [{Title}]({url}) - {channel}, {video_count} videos

### Official Documentation
1. [{Title}]({url}) - {source}

---

**Generated by:** CreatorOS Market Research
**Preservation:** Keep this file for future reference and attribution
```

---

### STEP 7: Display Summary & Next Steps
```yaml
action: display_summary
output: console_message
```

**Console Output:**
```
✅ MARKET RESEARCH COMPLETE!

📊 Research Summary:
   - Courses Analyzed: {count}
   - Common Patterns Identified: {pattern_count}
   - Content Gaps Found: {gap_count}
   - Differentiation Opportunities: {diff_count}

📂 Research Files Created:
   ✅ outputs/courses/{slug}/research/market-analysis.md
   ✅ outputs/courses/{slug}/research/content-gaps.md
   ✅ outputs/courses/{slug}/research/differentiation.md
   ✅ outputs/courses/{slug}/research/sources.md

🎯 Key Insights:
   1. {top_insight_1}
   2. {top_insight_2}
   3. {top_insight_3}

🚀 Next Step: Generate curriculum with research insights
   Command: @course-architect → *generate-curriculum {slug}

💡 Pro Tip: Review differentiation.md before curriculum generation
   to ensure unique positioning is baked into the structure.
```

---

## 🔧 Task Configuration

### Elicitation Points

**Elicit 1: Research Depth** (optional)
```yaml
elicit: true
question: "How deep should the market research be?"
options:
  - label: "Quick Scan"
    description: "Analyze top 5 courses only (3-5 min)"
    depth: light
    course_limit: 5
  - label: "Standard Research"
    description: "Analyze top 10 courses (5-8 min)"
    depth: medium
    course_limit: 10
  - label: "Deep Dive"
    description: "Analyze top 15 courses + blogs/tutorials (10-15 min)"
    depth: comprehensive
    course_limit: 15
default: medium
```

**Elicit 2: Research Focus** (optional)
```yaml
elicit: true
question: "What should research prioritize?"
options:
  - label: "Curriculum Patterns"
    description: "Focus on what topics competitors cover"
    priority: curriculum
  - label: "Differentiation"
    description: "Focus on gaps and unique angles"
    priority: differentiation
  - label: "Pricing & Positioning"
    description: "Focus on market pricing and positioning"
    priority: commercial
  - label: "Balanced"
    description: "Equal focus on all dimensions"
    priority: balanced
default: balanced
```

### Error Handling

**Error 1: COURSE-BRIEF.md Missing**
```
❌ ERROR: COURSE-BRIEF.md not found

Expected location: outputs/courses/{slug}/COURSE-BRIEF.md

Action Required:
1. Run @course-architect → *init-course-{greenfield|brownfield} {slug}
2. Fill COURSE-BRIEF.md sections 1-3 (minimum)
3. Re-run market research

Cannot proceed without course context.
```

**Error 2: COURSE-BRIEF.md Incomplete**
```
❌ ERROR: COURSE-BRIEF.md incomplete

Missing required sections:
  - Section 1: Basic Info (course title/topic required)
  - Section 2: ICP (target audience required)
  - Section 3: Content & Pedagogy (objectives required)

Action Required:
1. Fill required sections in COURSE-BRIEF.md
2. Re-run market research

Cannot generate effective search queries without course context.
```

**Error 3: Web Search Failed**
```
⚠️ WARNING: Web search failed for some queries

Successful queries: {success_count}/{total_count}

Proceeding with partial results ({success_count} courses analyzed).
Research may be less comprehensive than ideal.

Recommendation: Review research/sources.md for coverage gaps.
```

**Error 4: No Courses Found**
```
⚠️ WARNING: Very few courses found ({count} < 3)

Possible reasons:
  - Topic is highly niche/emerging
  - Search queries too specific
  - Platform blocking scraping

Action Options:
  1. Proceed with limited research (not recommended)
  2. Manually add competitor course URLs to sources.md
  3. Broaden search (edit topic in COURSE-BRIEF.md)
  4. Skip research and proceed to curriculum generation

This may indicate a blue ocean opportunity (no competition).
```

---

## 📊 Success Metrics

### Research Quality Metrics:

**Coverage:**
- ✅ Analyzed ≥ 8 competitive courses
- ✅ Extracted curriculum from ≥ 60% of courses
- ✅ Identified ≥ 3 content gaps
- ✅ Generated ≥ 3 differentiation opportunities

**Output Completeness:**
- ✅ All 4 research files created
- ✅ Market analysis has ≥ 8 courses listed
- ✅ Content gaps prioritized (P0/P1/P2)
- ✅ Differentiation strategy defined

**Actionability:**
- ✅ Clear recommendations for curriculum generation
- ✅ Gaps mapped to ICP and objectives
- ✅ Positioning statement generated

### Performance Targets:

| Research Depth | Courses | Duration | Cost |
|----------------|---------|----------|------|
| Quick Scan     | 5       | 3-5 min  | ~$0.50 |
| Standard       | 10      | 5-8 min  | ~$1.00 |
| Deep Dive      | 15      | 10-15 min| ~$2.00 |

---

## 🔗 Integration Points

### Used By:
- `greenfield-course.yaml` (after `manual_halt_1`, before `reformulate-course-brief`)
- `brownfield-course.yaml` (after `manual_halt_1`, before `reformulate-course-brief`)

### Requires:
- `COURSE-BRIEF.md` (Sections 1, 2, 3 filled)
- WebSearch tool access
- WebFetch tool access

### Feeds Into:
- `reformulate-course-brief` task (PRIMARY - integrates insights into COURSE-BRIEF)
- `generate-curriculum` task (SECONDARY - uses reformulated COURSE-BRIEF)
- Agent decision-making (differentiation strategy informs lesson content)

---

## 🎯 Examples

### Example 1: Greenfield Course (Supabase Backend)

**Input:**
```yaml
course_slug: supabase-zero-backend-completo
course_title: "Supabase: Zero Backend Completo"
icp_role: "Junior fullstack developers"
icp_pain_point: "Backend complexity and infrastructure management"
learning_objectives:
  - "Build production-ready backends using Supabase"
  - "Implement authentication without custom code"
  - "Design scalable database schemas"
```

**Generated Queries:**
1. "Supabase online course"
2. site:udemy.com Supabase
3. "backend for frontend developers" course
4. site:youtube.com "Supabase full course"
5. "build backend without servers" tutorial

**Research Output:**
- **Courses Found:** 12
- **Key Gap:** No course for frontend devs transitioning to fullstack
- **Differentiation:** ICP-tailored examples (React + Supabase, not generic)
- **Opportunity:** Include deployment checklists (no competitor has this)

**Impact on Curriculum:**
- Added "Frontend Dev → Fullstack Transition" module
- Tailored all examples to React/Next.js context
- Included production deployment checklist as resource

---

### Example 2: Brownfield Course (Legacy Marketing Course)

**Input:**
```yaml
course_slug: digital-marketing-mastery
course_title: "Digital Marketing Mastery"
icp_role: "Small business owners"
icp_pain_point: "Limited budget, need DIY marketing skills"
learning_objectives:
  - "Create effective social media campaigns"
  - "Build email marketing funnels"
  - "Measure ROI of marketing efforts"
```

**Generated Queries:**
1. "digital marketing course small business"
2. "marketing for entrepreneurs" course
3. site:udemy.com "digital marketing"
4. "DIY marketing strategy" tutorial

**Research Output:**
- **Courses Found:** 18 (saturated market)
- **Key Gap:** No course for budget-constrained small businesses
- **Differentiation:** Focus on free/low-cost tools, DIY templates
- **Opportunity:** Provide ready-to-use campaign templates

**Impact on Curriculum:**
- Added "Budget Marketing Tools" lesson
- Included 10 campaign templates (email, social, ads)
- Focused on ROI measurement for small budgets

---

## 📝 Notes for Agent Execution

### Best Practices:
1. **Search Broadly First:** Cast wide net with initial queries
2. **Analyze Deeply Second:** Focus on top 8-12 courses for curriculum extraction
3. **Prioritize Gaps:** Focus on what's missing, not just what exists
4. **Link to ICP:** Always tie differentiation back to target audience
5. **Be Specific:** Generic gaps ("more practice") less useful than specific gaps ("no production deployment guide")

### Common Pitfalls to Avoid:
- ❌ Analyzing too many courses (diminishing returns after 12-15)
- ❌ Focusing only on content (ignore pedagogy, format, voice)
- ❌ Generic differentiation ("better quality") vs. specific ("ICP-tailored examples")
- ❌ Ignoring pricing/positioning (commercial viability matters)
- ❌ Not saving sources (attribution + future reference)

### Time Management:
- Allocate 40% of time to search & extraction
- Allocate 40% of time to analysis (patterns, gaps, differentiation)
- Allocate 20% of time to report generation

---

**End of Task Definition**

*Filename: `expansion-packs/creator-os/tasks/market-research.md`*
*Version: 1.0.0*
*Last Updated: 2025-10-20*
*Author: CreatorOS Team*
