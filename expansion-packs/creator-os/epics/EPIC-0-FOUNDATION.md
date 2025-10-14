# Epic 0: Foundation - Core Infrastructure & Blog Generation MVP

**Epic ID:** EPIC-0
**Product:** CreatorOS (AIOS CreatorOS - The Operating System for Digital Creators)
**Status:** 📋 Planning
**Priority:** P0 (MUST HAVE)
**Timeline:** Weeks 1-2
**Story Points:** 18
**Owner:** Dev Lead

---

## Epic Overview

**Goal:** Establish core CreatorOS expansion pack infrastructure with persona-driven blog post generation working end-to-end.

**Why This Matters:** Foundation for all content formats. Blog posts are the highest-value P0 use case (TAM $42B), require moderate complexity (SEO, structure, voice), and demonstrate core capability (persona → authentic content). Success here validates the entire product vision.

**Success Criteria:**
- ✅ User can run `@content-orchestrator` and `*generate-blog-post`
- ✅ Blog post (1500-2500 words) generated with 80%+ fidelity (if using MMOS clone)
- ✅ SEO-optimized (keywords, meta, headings)
- ✅ Complete generation in <30 minutes
- ✅ Integration with MMOS Mind Mapper working (read persona from clone)

---

## Stories (5 stories, 18 points)

### Story 0.1: Expansion Pack Structure & Configuration (3 points)

**As a** developer
**I want** the expansion pack properly structured following AIOS standards
**So that** it integrates seamlessly with AIOS-FULLSTACK framework

**Acceptance Criteria:**
- [x] `config.yaml` created with all metadata
  - name: "creator-os"
  - version: "1.0.0"
  - description: CreatorOS - The Operating System for Digital Creators
  - 10 agents defined (content-pm, orchestrator, specialists for all formats)
  - 12 tasks listed (blog, social, video, course, marketing features)
  - Dependencies: MMOS (optional), InnerLens (optional), ETL (optional)
  - Installation message clear and compelling with CreatorOS branding
- [ ] `README.md` with:
  - Quick start guide
  - Architecture overview
  - Use cases (5 formats)
  - Integration guide (MMOS + custom personas)
  - Examples with screenshots
- [ ] `PRD.md` (already created, validate completeness)
- [ ] Directory structure:
  - `agents/` (content-orchestrator.md, blog-writer.md)
  - `tasks/` (generate-blog-post.md, validate-clone-fidelity.md)
  - `templates/` (blog-post.md, persona-custom.json)
  - `checklists/` (content-quality-checklist.md, clone-fidelity-checklist.md)
  - `data/` (content-formats-kb.md, platform-specs.yaml)
  - `epics/` (this file)
  - `docs/` (integration-guide.md)
- [ ] `.gitignore` for local configs, temp files, API keys

**Definition of Done:**
- Expansion pack loads in AIOS without errors
- `@content-orchestrator` activates successfully
- All required directories exist
- Documentation is clear and comprehensive

**Technical Notes:**
- Follow structure from `mmos-mind-mapper` and `innerlens`
- Ensure `slashPrefix: creator` is unique
- Reference MMOS integration pattern from InnerLens
- CreatorOS branding applied throughout all documentation

---

### Story 0.2: Content Orchestrator Agent (5 points)

**As a** user
**I want** a master orchestrator agent that guides me through content creation workflows
**So that** I can easily generate blog posts, social media, and other formats

**Acceptance Criteria:**
- [ ] `agents/content-orchestrator.md` created (600+ lines)
- [ ] Persona defined: creative strategist, patient guide, quality-focused
- [ ] Commands implemented:
  - [ ] `*generate-blog-post` - SEO-optimized blog (1500-2500 words)
  - [ ] `*generate-social-content` - LinkedIn, Twitter, Instagram (placeholder for Phase 1)
  - [ ] `*generate-video-script` - YouTube, TikTok scripts (placeholder for Phase 1)
  - [ ] `*validate-fidelity` - Check voice consistency vs persona
  - [ ] `*help` - Show available commands
  - [ ] `*chat-mode` - Conversational content strategy
  - [ ] `*exit` - Deactivate agent
- [ ] Elicitation wizard (4 steps):
  1. **Content Type:** Blog, social, video, newsletter, course?
  2. **Persona:** MMOS clone or custom persona?
  3. **Topic:** What to write about? Keywords?
  4. **Audience:** Who's reading? What's their context?
- [ ] Integration points documented:
  - MMOS (read `personality-profile.json`, `system-prompt-generalista.md`)
  - Custom personas (upload JSON with voice parameters)
  - InnerLens (optional - audience adaptation)
- [ ] 2 complete walkthroughs:
  - Standalone (custom persona)
  - MMOS integration (use existing clone)

**Definition of Done:**
- Agent activates: `@content-orchestrator`
- Help command shows all available commands
- Elicitation wizard guides user to blog generation
- Test with mock user: completes `*generate-blog-post` successfully
- Documentation includes video walkthrough

**Technical Notes:**
- Study `mmos-mind-mapper/agents/mind-mapper.md` for orchestration patterns
- Keep tone encouraging and creative (not robotic)
- Always show preview before finalizing content
- Offer regeneration options if user not satisfied

---

### Story 0.3: Blog Writer Agent - SEO & Storytelling Expert (5 points)

**As a** user
**I want** a specialized agent that understands blog writing, SEO, and storytelling
**So that** my blog posts are engaging, well-structured, and discoverable

**Acceptance Criteria:**
- [ ] `agents/blog-writer.md` created (400+ lines)
- [ ] Persona: professional content marketer, SEO expert, storytelling coach
- [ ] Commands:
  - [ ] `*write-blog` - Generate blog post from outline
  - [ ] `*optimize-seo` - Add keywords, meta tags, headings
  - [ ] `*improve-hook` - Strengthen first paragraph
  - [ ] `*add-examples` - Enrich with stories/case studies
  - [ ] `*check-readability` - Flesch-Kincaid score
  - [ ] `*suggest-cta` - Call-to-action recommendations
- [ ] Knowledge base references:
  - SEO best practices (keyword density, meta tags, heading structure)
  - Storytelling frameworks (Hero's Journey, Problem-Solution, Case Study)
  - Readability standards (Flesch-Kincaid 60+, 8th grade level)
  - Blog structure (Hook, Body, Conclusion, CTA)
- [ ] Voice consistency validation:
  - Vocabulary matching (signature words from persona)
  - Syntax similarity (sentence complexity)
  - Style markers (metaphors, examples, tone)
- [ ] Example outputs (3 blog posts in different voices)

**Definition of Done:**
- Agent activates: `@blog-writer`
- Can generate 1500-2500 word blog post
- SEO optimization working (keywords, meta, headings)
- Test: Blog passes readability check (Flesch-Kincaid 60+)
- Fidelity test: 80%+ match to persona voice

**Technical Notes:**
- Use Claude Sonnet 4 for long-form generation
- Implement streaming for user feedback (show generation progress)
- Store SEO patterns in `data/platform-specs.yaml`
- Reference storytelling frameworks in `data/content-formats-kb.md`

---

### Story 0.4: Generate Blog Post Task - End-to-End Pipeline (4 points)

**As a** user
**I want** to generate a complete blog post from a topic and persona
**So that** I can save 8-10 hours of manual writing time

**Acceptance Criteria:**
- [ ] `tasks/generate-blog-post.md` workflow created (600+ lines)
- [ ] Input validation:
  - Topic (required): Clear topic statement or keywords
  - Persona (required): MMOS clone path OR custom persona JSON
  - Audience (optional): Target reader profile
  - Keywords (optional): SEO keywords (3-5 recommended)
  - Length (optional): Word count (default 2000 words)
- [ ] Processing pipeline:
  - [ ] **Step 1: Persona Loading**
    - If MMOS clone: Read `minds/{mind_name}/synthesis/personality-profile.json`
    - Extract voice parameters: tone, complexity, style, examples
    - If custom: Parse JSON with voice parameters
  - [ ] **Step 2: Research & Outline**
    - Generate blog outline (5-7 H2 headings)
    - Identify key points, examples, transitions
    - SEO keyword placement strategy
  - [ ] **Step 3: Content Generation**
    - Write hook (first paragraph, scroll-stopper)
    - Write body (3-5 sections, 300-500 words each)
    - Write conclusion (recap + CTA)
    - Add meta description (150 chars)
  - [ ] **Step 4: SEO Optimization**
    - Keyword density check (1-2%)
    - Heading structure (H1, H2, H3)
    - Meta tags (title 60 chars, description 150 chars)
    - Internal link suggestions (3-5 related topics)
  - [ ] **Step 5: Fidelity Validation**
    - Compare vocabulary with persona samples
    - Check syntax similarity
    - Validate style markers (metaphors, examples)
    - Generate fidelity score (0-100%)
- [ ] Output: `blog-post.md` with:
  - Title (SEO-optimized, 60 chars)
  - Meta description (150 chars)
  - Body (1500-2500 words, Markdown formatted)
  - Headings (H2, H3 with keywords)
  - CTA (clear next step)
  - Fidelity report (score + evidence)
- [ ] Performance: <30 minutes for 2000 words
- [ ] Error handling:
  - Persona not found → clear error + instructions
  - API failures → retry with exponential backoff
  - Invalid topic → ask clarifying questions

**Definition of Done:**
- Task executes: `*generate-blog-post --topic "deep work" --mind cal_newport`
- Generates `blog-post.md` + `fidelity-report.yaml`
- Quality test: Blog passes SEO checklist (10/10 criteria)
- Fidelity test: 80%+ score (if using MMOS clone)
- Performance test: <30min on 2000 words

**Technical Notes:**
- Use prompt caching for persona context (90% cost savings)
- Store blog templates in `templates/blog-post.md`
- Handle errors gracefully (persona not found, API rate limits)
- Cost target: ~$0.50 per blog post
- LLM: Claude Sonnet 4 (primary), GPT-4o (fallback)

---

### Story 0.5: Templates & Knowledge Base (1 point)

**As a** developer
**I want** structured templates and knowledge bases
**So that** content generation is consistent and high-quality

**Acceptance Criteria:**
- [ ] `templates/blog-post.md` - Blog post structure
  ```markdown
  ---
  title: "{{TITLE}}"
  meta_description: "{{META_DESCRIPTION}}"
  keywords: [{{KEYWORD_1}}, {{KEYWORD_2}}, {{KEYWORD_3}}]
  author: "{{AUTHOR}}"
  date: "{{DATE}}"
  ---

  # {{TITLE}}

  {{HOOK}}

  ## {{H2_HEADING_1}}
  {{SECTION_1}}

  ## {{H2_HEADING_2}}
  {{SECTION_2}}

  ...

  ## Conclusion
  {{CONCLUSION}}

  {{CTA}}

  ---
  Related posts: {{RELATED_1}}, {{RELATED_2}}, {{RELATED_3}}
  ```
- [ ] `templates/persona-custom.json` - Custom persona format
  ```json
  {
    "name": "Custom Persona",
    "voice_parameters": {
      "tone": "professional | conversational | academic | casual",
      "complexity": "simple | moderate | complex",
      "sentence_length": "short | medium | long",
      "vocabulary_level": "everyday | business | technical | academic"
    },
    "style_markers": {
      "metaphor_frequency": "rare | occasional | frequent",
      "example_types": ["personal stories", "case studies", "research"],
      "signature_phrases": ["first principles", "skin in the game"]
    },
    "writing_samples": ["sample1.txt", "sample2.txt"]
  }
  ```
- [ ] `templates/fidelity-report.yaml` - Fidelity validation output
- [ ] `data/content-formats-kb.md` - Knowledge base (300+ lines):
  - Blog post best practices
  - SEO fundamentals (keywords, meta, headings)
  - Storytelling frameworks (Hero's Journey, Problem-Solution)
  - Readability standards (Flesch-Kincaid, grade level)
  - Voice consistency guidelines
- [ ] `data/platform-specs.yaml` - Platform-specific requirements
  - Blog platforms (Medium, WordPress, Ghost)
  - Character limits, formatting rules

**Definition of Done:**
- All templates render without errors
- Can be parsed by standard libraries
- Documentation for each template field
- Knowledge base is comprehensive and actionable

**Technical Notes:**
- Use YAML for structured data, Markdown for content
- Include validation rules (Zod schema if using TypeScript)
- Provide filled examples for each template

---

## Dependencies

### External Dependencies
- **AIOS-FULLSTACK 4.0+** - Core framework
- **Anthropic Claude Sonnet 4 API** - LLM for content generation
- **MMOS Mind Mapper** (optional) - Persona source (clones)
- **InnerLens** (optional) - Audience adaptation (future)

### Internal Dependencies
- None (this is the foundation epic)

### Blockers
- [ ] API keys for Claude Sonnet 4
- [ ] Test personas (3 MMOS clones + 2 custom personas)
- [ ] Ground truth samples (5 blog posts per persona for fidelity testing)

---

## Risks & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| **Low fidelity (<80%)** | Medium | High | Start with well-documented personas (MMOS clones), use extensive prompting, validate with ground truth |
| **Performance (>30 min)** | Low | Medium | Use streaming responses, optimize prompts, cache persona context |
| **Poor SEO quality** | Medium | Medium | Implement SEO checklist, validate with tools (Yoast, SEMrush) |
| **Generic content (sounds like AI)** | High | High | Persona-driven generation, fidelity validation, human-in-loop review |
| **MMOS integration breaks** | Low | Medium | Version pinning, backward compatibility, fallback to custom personas |

---

## Testing Strategy

### Unit Tests
- [ ] Template parsing (valid/invalid inputs)
- [ ] Persona loading (MMOS clone vs custom JSON)
- [ ] SEO validation (keyword density, meta tags, headings)
- [ ] Readability scoring (Flesch-Kincaid calculation)

### Integration Tests
- [ ] End-to-end: Topic + Persona → Blog post
- [ ] Agent activation and command execution
- [ ] MMOS integration (read persona from clone)
- [ ] Fidelity validation (vocabulary, syntax, style)

### Validation Tests
- [ ] Fidelity comparison (N=5 personas)
  - Generate 3 blog posts per persona
  - Compare with original writing samples (ground truth)
  - Compute fidelity score (target: 80%+ average)
- [ ] SEO quality check
  - Run generated blog through Yoast SEO
  - Validate: keyword density, meta tags, readability
  - Target: 8/10 SEO score
- [ ] User acceptance (N=5 beta testers)
  - "Would you publish this?" (Yes: 80%+)
  - "How much editing needed?" (Target: <30 min)
  - NPS score (Target: 8+)

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Fidelity** | 80%+ average | Vocabulary, syntax, style comparison (N=5 personas) |
| **Performance** | <30 minutes | Time from input to output (2000 words) |
| **SEO Quality** | 8/10 score | Yoast SEO or similar tool |
| **Publishing Rate** | 80%+ | Beta testers: "Would you publish this?" |
| **Time Savings** | 80% | 2h with AI vs 10h manually |
| **Usability** | 8+ NPS | Beta tester feedback (N=5) |
| **Completion Rate** | 100% | All 5 stories done |

---

## Rollout Plan

### Week 1: Infrastructure (Stories 0.1, 0.2, 0.5)
- **Day 1-2:** Expansion pack structure + config.yaml
- **Day 3-4:** Content Orchestrator agent
- **Day 5:** Templates + Knowledge Base

### Week 2: Core Functionality (Stories 0.3, 0.4)
- **Day 1-2:** Blog Writer agent
- **Day 3-4:** Generate Blog Post task (pipeline implementation)
- **Day 5:** Testing and validation (5 personas, 15 blog posts)

### Week 2 End: Demo
- Record 5-min video walkthrough
- Generate 3 sample blog posts (different voices)
- Share with AIOS community (Discord)
- Recruit 5 beta testers

---

## Definition of Done (Epic Level)

- [ ] All 5 stories completed and tested
- [ ] `@content-orchestrator` activates without errors
- [ ] `*generate-blog-post` generates valid blog post
- [ ] Fidelity validation: 80%+ average (N=5 personas)
- [ ] SEO validation: 8/10 average score
- [ ] Performance test: <30min on 2000 words
- [ ] 5 beta testers complete walkthrough
- [ ] Publishing rate: 80%+ ("Would you publish this?")
- [ ] NPS 8+ from beta testers
- [ ] Demo video published (YouTube or Loom)
- [ ] README updated with examples

---

## Next Epic

**Epic 1: Multi-Format Generator (Weeks 3-6)**
- Social Media Specialist agent (LinkedIn, Twitter, Instagram)
- Video Script Writer agent (YouTube, TikTok, Explainer)
- Newsletter Generator (curated content + commentary)
- Content Strategy Generator (30-day calendar)
- Fidelity validation for all formats (85%+ target)

---

**Epic Status:** 📋 Ready to Start
**Last Updated:** 2025-10-14
**Owner:** Dev Lead
