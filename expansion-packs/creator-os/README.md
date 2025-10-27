# CreatorOS - The Operating System for Digital Creators

**Version:** 2.0.0 (Epic 3 Complete)
**Status:** ✅ Production Ready
**Author:** Academia Lendar[IA] (Alan Nicolas)

> "Create, convert, scale — with AI personality cloning"

---

## 🎯 What is CreatorOS?

**CreatorOS** (AIOS CreatorOS) is an AI-orchestrated expansion pack for AIOS-FULLSTACK that transforms you into a content creation machine. Generate educational courses, blog posts, social media content, video scripts, and marketing campaigns — all while preserving your authentic voice through AI personality cloning.

### The Problem We Solve

- ⏰ **Time:** Creators spend 10-20 hours/week creating content
- 🤖 **Generic AI:** Tools like ChatGPT generate bland, voiceless content
- 🎭 **Consistency:** Maintaining voice across formats is manual and painful
- 📚 **Education:** Course creation requires complex pedagogical structuring
- 📊 **Marketing:** A/B testing, funnels, and attribution are disconnected from content

### The CreatorOS Solution

CreatorOS is your **complete operating system** for content creation and growth:

✅ **Multi-format generation** - Courses, blogs, social, video, newsletters
✅ **Voice preservation** - 90%+ fidelity using MMOS AI clones
✅ **Marketing intelligence** - Funnels, A/B tests, SEO, attribution
✅ **Pedagogical rigor** - GPS Framework + Didática Lendária (7 Elements)
✅ **Project management** - Campaigns, audiences, performance tracking
✅ **Unified database** - Full traceability from idea to conversion

---

## 🚀 Quick Start (Multiple Workflows)

**⚡ NEW: Intelligent context detection - System adapts to your workflow!**

### Workflow 1: Create Course from Scratch

```bash
# 1. Initialize course
@course-architect
*new meu-curso

# 2. Fill COURSE-BRIEF.md manually
vim outputs/courses/meu-curso/COURSE-BRIEF.md

# 3. System auto-detects filled brief and continues
#    → Market research (automatic)
#    → COURSE-BRIEF reformulation (automatic)
#    → Review → Approve curriculum → Generate lessons
```

**Time:** 45-75 minutes | **Output:** Complete course with market intelligence

---

### Workflow 2: Pre-Created Brief (Your Workflow!) 🆕

```bash
# 1. Create COURSE-BRIEF.md externally (Claude app, Google Docs, etc.)
#    Save to: outputs/courses/meu-curso/COURSE-BRIEF.md

# 2. (Optional) Add support materials
#    Add to: outputs/courses/meu-curso/sources/

# 3. Run *new command - System detects and adapts!
@course-architect
*new meu-curso

# System automatically detects:
#   ✅ COURSE-BRIEF is 85% complete
#   ✅ Found 3 files in /sources/
#   ✅ Skipping manual filling
#   ✅ Proceeding to market research

# 4. Review reformulated brief → Approve → Done!
```

**Time:** 20-40 minutes | **Output:** Complete course (skips manual steps!)

**Benefits:**
- ✅ Create brief in your preferred tool (Claude app, Docs, Notion)
- ✅ Add PDFs, links, references to `/sources/` for context
- ✅ System intelligently skips unnecessary steps
- ✅ Faster workflow (no context switching)

---

### Workflow 3: Upgrade Existing Course

```bash
# 1. Place legacy materials in folder
mkdir -p outputs/courses/meu-curso/sources/
# Add transcripts, videos, PDFs to /sources/

# 2. Run brownfield upgrade
@course-architect
*upgrade meu-curso

# System auto-extracts:
#   → ICP from materials
#   → Voice from transcripts
#   → Converts /sources/videos into MP3 + transcripts (lesson1, lesson2…)
#   → Objectives from content
#   → Runs market research
#   → Generates optimized curriculum

> ℹ️ Video automation requires `ffmpeg` plus an AssemblyAI API key.
> Configure `ASSEMBLYAI_API_KEY` in your `.env` and the brownfield upgrade
> will automatically convert and transcribe every video in `/sources/videos/`.
```

**Time:** 30-60 minutes | **Output:** Modernized course with market intelligence

📖 **Full Guide:** See [QUICK-START.md](./QUICK-START.md) for detailed instructions

---

## 📚 Course Generation Features (Epic 3)

### ✅ **Competitive Intelligence & Market Research** (Implemented)

CreatorOS includes **automated market research** to create strategically superior courses:

🔍 **Automated Competitive Analysis**
- Analyzes 10-15 competitive courses automatically (5-10 min)
- Identifies curriculum patterns, pricing strategies, student feedback
- Generates 4 comprehensive reports (market analysis, gaps, differentiation, sources)

🎯 **Strategic Gap Identification**
- Prioritizes content gaps (P0/P1/P2)
- Finds topics competitors miss or cover superficially
- Identifies ICP-specific opportunities

💡 **Intelligent COURSE-BRIEF Reformulation**
- Integrates research insights into initial course brief
- Preserves original vision + adds market intelligence
- Auto-generates Section 9: Market Research Summary
- Transparent research annotations throughout

📊 **Differentiation Strategy**
- Creates unique positioning statement
- Identifies 3+ competitive advantages
- Recommends pricing based on market analysis

**Result:** Courses that are **strategically differentiated**, not generic copies.

**Example:** Building a Supabase course? Research shows:
- ✅ Gap: No course for frontend → fullstack transition (P0 opportunity)
- ✅ Gap: Only 2/12 courses cover production deployment
- ✅ Differentiation: ICP-specific examples (React context) vs generic tutorials
- ✅ Pricing: $79 (mid-tier quality positioning)

**Integration:** ✅ Available for both greenfield and brownfield workflows via `python scripts/run_market_research.py`.

---

### What Gets Generated

✅ **Pedagogically Sound Lessons**
- GPS Framework (Goal → Position → Steps)
- Didática Lendária (7 Elements)
- Automatic validation & retry (90%+ quality guaranteed)

✅ **Complete Course Structure**
- curriculum.yaml (modules + lessons)
- course-outline.md
- Assessments (quizzes + final project)
- **✅ AVAILABLE:** Market research reports (4 markdown files)

✅ **Voice Fidelity** (Optional MMOS Integration)
- 90%+ instructor voice preservation
- Fallback to rule-based extraction if API fails

### Intelligent Workflows

**Greenfield** (From Scratch)

**INTELLIGENT CONTEXT DETECTION:** System detects 3 scenarios automatically!

**Scenario A: Greenfield Pure** (No pre-existing brief)
1. Fill COURSE-BRIEF.md manually (8 sections) ⏸️ **HALT for manual filling**
2. **✅ Automated market research** (competitive intelligence)
3. **✅ COURSE-BRIEF reformulation** (integrates research + preserves vision)
4. Review reformulated brief (user approval checkpoint)
5. AI generates curriculum (based on optimized brief)
6. Approve curriculum → Generate lessons
7. GPS + DL validation ensures transformational learning

**Scenario B: Pre-Created Brief** 🆕 **YOUR WORKFLOW!**
1. ✅ **SKIP manual filling** (COURSE-BRIEF detected as 70%+ complete)
2. ✅ **Detect /sources/ materials** (optional support files)
3. **✅ Auto-proceed to market research** (no manual halt)
4. **✅ COURSE-BRIEF reformulation** (integrates research)
5. Review reformulated brief (user approval checkpoint)
6. AI generates curriculum → Approve → Generate lessons
7. GPS + DL validation

**Benefits:** 40% faster (20-40 min vs 45-75 min)

**Scenario C: Legacy Materials Detected**
- System detects `/sources/` but no COURSE-BRIEF
- ⚠️ Recommends switching to brownfield mode: `*upgrade {slug}`
- User decides: brownfield vs manual greenfield

**Brownfield** (Migrate Existing Course)
1. Auto-organize files (transcripts, videos, docs)
2. Auto-extract ICP, voice patterns, learning objectives
3. Gap analysis skips 60-80% of manual questions
4. **✅ Market research** (compares legacy with market leaders)
5. **✅ COURSE-BRIEF reformulation** (legacy + research insights)
6. Review reformulated brief → Generate curriculum
7. Preserves instructor voice + modernizes content

---

## 🛠️ Advanced Usage

### Resume Interrupted Generation

```bash
# CTRL+C during generation? No problem!
python scripts/generate_course.py meu-curso --resume

```bash
@content-pm
> Welcome to CreatorOS! Let's set up your first project.

*create-project
> Project name: My Awesome Blog
> Goals: thought_leadership, lead_generation
> Default persona: Naval Ravikant (MMOS clone)
> Audience: Tech founders, 28-45, high openness
> ✅ Project created: proj_a3f2b1c4

*generate-blog-post
> Topic: "How to build leverage in your career"
> Persona: Naval Ravikant (default)
> Audience: Tech founders (default)
> Generating... (30 seconds)
> ✅ Blog post ready!
> - Title: "Build Infinite Leverage: The Naval Ravikant Guide"
> - Words: 2,347
> - Fidelity: 92% (sounds exactly like Naval)
> - SEO score: 88%
> - File: creator-os-workspace/projects/my-awesome-blog/content/blog-001.md

*publish
> Published URL: https://mysite.com/blog/build-infinite-leverage
> ✅ Tracking performance...
```

---

## 🏗️ Architecture

### System Overview

```
┌─────────────────────────────────────────────────────────────┐
│              CreatorOS (AIOS CreatorOS)                      │
│              The Operating System for Digital Creators       │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   Agents     │  │    Tasks     │  │  Templates   │     │
│  │   (5)        │  │    (21)      │  │    (17)      │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│         │                  │                  │             │
│         └──────────────────┴──────────────────┘             │
│                          │                                  │
│                          ▼                                  │
│              ┌───────────────────────┐                      │
│              │  Content Pipeline     │                      │
│              │  (Persona Loading +   │                      │
│              │   Generation +        │                      │
│              │   Fidelity Check)     │                      │
│              └───────────────────────┘                      │
│                          │                                  │
└──────────────────────────┼──────────────────────────────────┘
                           │
           ┌───────────────┼───────────────┐
           │               │               │
           ▼               ▼               ▼
    ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
    │ MMOS Mind   │ │ InnerLens   │ │ Custom      │
    │ Mapper      │ │ (Optional)  │ │ Persona     │
    │ (Optional)  │ │             │ │ (JSON)      │
    └─────────────┘ └─────────────┘ └─────────────┘
```

### Specialized Agents

**Core Agents (Implemented):**

| Agent | Role | When to Use | Status |
|-------|------|-------------|--------|
| **@content-orchestrator** | Master Content Generation Coordinator | Multi-format content generation | ✅ Available |
| **@blog-writer** | SEO-Optimized Blog Writing Specialist | 1500-2500 word blog posts | ✅ Available |
| **@course-architect** | Pedagogical Course Design Expert | Full course creation (outline → assessments) | ✅ Available |

**Planned Agents (Phase 2-3):**

| Agent | Role | When to Use | ETA |
|-------|------|-------------|-----|
| **@content-pm** | Project Manager & Strategy Orchestrator | Project setup, campaign planning | Phase 2 (Weeks 5-8) |
| **@funnel-architect** | Conversion Funnel Strategy Specialist | TOFU → MOFU → BOFU funnels | Phase 3 (Weeks 9-12) |

### Core Tasks

**Course Generation (Greenfield/Brownfield):**
- `*new {slug}` - 🆕 Create new course from scratch (greenfield workflow)
- `*upgrade {slug}` - 🆕 Upgrade existing course (brownfield workflow)
- `*market-research {slug}` - ✅ Competitive market research (10-15 courses analyzed)
- `*reformulate-course-brief {slug}` - ✅ Integrate research insights into brief
- `*generate-curriculum {slug}` - Generate curriculum.yaml from COURSE-BRIEF
- `*generate-lessons {slug}` - Generate all lessons (GPS + Didática Lendária)
- `*validate-course {slug}` - Comprehensive quality validation

**Course Generation (Atomic Tasks):**
- `*init-course-greenfield` - Initialize new course structure
- `*init-course-brownfield` - Initialize brownfield course structure
- `*organize-files` - Organize legacy course files
- `*extract-icp` - Extract ICP from legacy materials
- `*extract-voice` - Extract instructor voice profile
- `*infer-objectives` - Infer learning objectives (Bloom's Taxonomy)
- `*analyze-gaps` - Analyze COURSE-BRIEF gaps after extraction

**Content Generation (Planned):**
- `*generate-blog-post` - SEO blog (1500-2500 words)

**Quality:**
- `*validate-fidelity` - Check voice consistency (85-95%)

---

## 📊 Database Integration

CreatorOS integrates with the unified AIOS database (`outputs/database/mmos.db`):

### 13 Tables

**Core (8 tables):**
- `content_frameworks` - Pedagogical, storytelling, marketing frameworks
- `content_projects` - Workspace for content creation
- `audience_profiles` - ICP for content targeting
- `content_pieces` - Generated content artifacts
- `content_performance` - Post-publish metrics
- `content_campaigns` - Group related content pieces
- `content_campaign_pieces` - Many-to-many campaign/content
- `content_learnings` - Captured insights for improvement

**Extended (5 tables - "Marketing" features now core):**
- `content_funnels` - Conversion funnel definitions
- `ab_tests` - A/B test configurations and results
- `distribution_channels` - Multi-platform distribution tracking
- `content_attribution` - Multi-touch attribution data
- `content_seo_tracking` - SEO performance over time

### Full Traceability

```
Content Piece → Persona → Mind → Fragments → Sources
              ↓
         Performance → Learnings → Future Content
```

---

## 🎨 What You Can Create

### 📝 Content Formats

| Format | Output | Time | Use Case |
|--------|--------|------|----------|
| **Blog Post** | 1500-2500 words, SEO-optimized | 30 min | Thought leadership, SEO traffic |
| **Social Media** | LinkedIn (300-1200w), Twitter threads, Instagram | 15 min | Engagement, brand awareness |
| **Video Script** | YouTube (5-15min), TikTok (60s), Explainer (3min) | 1 hour | Video content, education |
| **Newsletter** | 500-1000 words, curated links + commentary | 1 hour | Audience nurturing, retention |
| **Course** | Full curriculum (10h course = 40 lessons + assessments) | 4 hours | Education, lead generation |

### 🎯 Marketing Features

- **Conversion Funnels** - TOFU → MOFU → BOFU content strategy
- **A/B Testing** - Test titles, hooks, CTAs, formats
- **SEO Optimization** - Keyword research, rankings, backlinks
- **Attribution Tracking** - Multi-touch (first-touch, last-touch, linear)
- **Channel Management** - Multi-platform distribution
- **Performance Analytics** - Views, engagement, conversions

### 📚 Pedagogical Frameworks

- **Bloom's Taxonomy** - 6 cognitive levels (Remember → Create)
- **ADDIE Model** - Analysis → Design → Development → Implementation → Evaluation
- **Kolb's Learning Cycle** - Experience → Reflect → Conceptualize → Experiment

### 📖 Storytelling Frameworks

- **Hero's Journey** - Transformation narrative (Joseph Campbell)
- **Problem-Solution** - Identify pain → Agitate → Solve
- **Case Study** - Subject → Challenge → Solution → Results
- **AIDA** - Attention → Interest → Desire → Action
- **PAS** - Problem → Agitate → Solve

---

## 🧬 AI Personality Cloning (MMOS Integration)

CreatorOS preserves your **authentic voice** through optional MMOS Mind Mapper integration:

### How It Works

1. **Use existing MMOS clone** (e.g., Naval Ravikant, Nassim Taleb)
2. **Train custom persona** from your writing samples (ETL Data Collector)
3. **Define brand voice** (company style guide)

### Voice Fidelity: 90%+

CreatorOS validates voice consistency across 4 dimensions:

- **Vocabulary (30%)** - Signature words, richness, domain terminology
- **Syntax (20%)** - Sentence complexity, clause structure, punctuation
- **Style (25%)** - Metaphors, examples, rhetorical devices
- **Thinking (25%)** - Argumentation style, reasoning depth, contrarian vs consensus

**Example:** Generate blog post in Nassim Taleb's voice → 92% fidelity score

---

## 🎯 Use Cases

### 1. Course Creator - Sofia

**Context:** Creates online courses on productivity (5K students)
**Pain:** 40h to create 10h course, pedagogical structuring is complex
**Solution:** `*generate-course` → 10 modules, 40 lessons, 20 exercises, 10 quizzes in 4h
**ROI:** 90% time savings

### 2. Content Marketer - Bruno

**Context:** CMO of SaaS B2B ($5M ARR), manages blog + LinkedIn + newsletter
**Pain:** Team spends 10h/week, brand voice inconsistent
**Solution:** Generate 4 blog posts + 20 LinkedIn posts + 4 newsletters/month
**ROI:** 80% time savings, consistent brand voice

### 3. Thought Leader - Dr. Rafael

**Context:** Academic with 50K LinkedIn followers, wants to scale presence
**Pain:** No time for content, ghostwriters don't capture voice
**Solution:** MMOS clone of himself → 3 LinkedIn posts/week with 90%+ fidelity
**ROI:** Maintains presence without 5h/week investment

### 4. Solopreneur - Lucas

**Context:** YouTuber (100K subs) creating educational videos on philosophy
**Pain:** Scriptwriting takes 8h/video, research is deep but slow
**Solution:** `*generate-video-script` → 15min script with research notes in 1h
**ROI:** 87.5% time savings per video

---

## 📦 Optional Integrations

### MMOS Mind Mapper

**What:** AI personality cloning system (94% fidelity)
**Use:** Clone yourself or thought leaders as content personas
**Install:** `npm run install:expansion mmos`

**Example Minds:**
- Naval Ravikant, Nassim Taleb, Paul Graham
- Cal Newport, Tim Ferriss, Ryan Holiday
- +25 thought leaders available

### InnerLens

**What:** Psychometric audience profiling (Big Five + 120 traits)
**Use:** Adapt content to reader psychology (high/low openness, etc.)
**Install:** `npm run install:expansion innerlens`

**Example:** "High Openness writer → High Openness reader" = better engagement

### ETL Data Collector

**What:** Multimodal data collection (WhatsApp, emails, code, social)
**Use:** Train custom personas from existing content
**Install:** `npm run install:expansion etl-data-collector`

---

## 🎓 Documentation

### Core Docs

- **README.md** (this file) - Quick start and overview
- **PRD.md** - Product requirements document
- **DATABASE-INTEGRATION.md** - Unified database design (13 tables)
- **MODULARITY-ANALYSIS.md** - Why we chose unified CreatorOS (not split)
- **NAMING-DECISION.md** - CreatorOS naming rationale

### Epics & Stories

- **EPIC-0-FOUNDATION.md** - MVP implementation plan (Weeks 1-2, 18 points)

### Guides (Coming Soon)

- Agent usage guides (10 agents)
- Task walkthroughs (12 tasks)
- Integration guides (MMOS, InnerLens, ETL)
- Best practices & examples

---

## 🛣️ Roadmap

### Phase 0: Foundation (Weeks 1-2) ✅ DONE

- ✅ Expansion pack structure
- ✅ Config.yaml with 10 agents, 12 tasks
- ✅ Database integration (13 tables)
- ✅ Complete documentation

### Phase 1: MVP - Blog Generation (Weeks 3-4)

- [ ] `@content-pm` agent
- [ ] `@content-orchestrator` agent
- [ ] `@blog-writer` agent
- [ ] `*generate-blog-post` task
- [ ] MMOS integration (read persona from clone)
- [ ] Fidelity validation (80%+ target)

### Phase 2: Multi-Format Generator (Weeks 5-8)

- [ ] Social media specialist
- [ ] Video script writer
- [ ] Newsletter generator
- [ ] Course architect
- [ ] Fidelity validation for all formats (85%+ target)

### Phase 3: Marketing Intelligence (Weeks 9-12)

- [ ] Funnel architect
- [ ] A/B test manager
- [ ] SEO optimizer
- [ ] Growth analyst
- [ ] Performance tracking + learning loops

### Phase 4: Advanced Features (Weeks 13-16)

- [ ] Multi-persona collaboration
- [ ] Content repurposing engine
- [ ] InnerLens integration (audience adaptation)
- [ ] API access (RESTful + webhooks)

---

## 💡 Design Principles

1. **Voice Consistency** - Content must sound like creator, not generic AI
2. **Learning-First** - Education > Marketing (even for marketing content)
3. **Actionable Output** - Publishing-ready content (not drafts requiring 5h editing)
4. **Transparent Fidelity** - Always report fidelity score (85-95%)
5. **Creator Empowerment** - AI amplifies creativity, doesn't replace expertise

---

## 🎯 Success Metrics (Year 1)

| Metric | Target | Current |
|--------|--------|---------|
| **Adoption** | 300 active creators | 0 (Planning) |
| **Content Generated** | 10,000+ pieces | 0 |
| **Time Savings** | 80% reduction (2h vs 10h/content) | - |
| **Fidelity Score** | 90%+ (authentic voice maintained) | - |
| **Revenue** | $30K ARR (B2C + B2B) | 0 |

---

## 🤝 Contributing

CreatorOS is part of the AIOS-FULLSTACK framework. Contributions welcome!

### How to Contribute

1. **Test and provide feedback** - Try CreatorOS and share insights
2. **Add frameworks** - Contribute new pedagogical/storytelling/marketing frameworks
3. **Create templates** - Share content templates for new formats
4. **Improve agents** - Enhance agent personas and workflows
5. **Build integrations** - Connect CreatorOS to new platforms

### Community

- **GitHub:** https://github.com/academia-lendaria/aios-fullstack
- **Discord:** https://discord.gg/aios-community
- **Docs:** https://docs.aios.dev/creator-os

---

## 📄 License

Part of AIOS-FULLSTACK framework.
**License:** MIT
**Author:** Academia Lendar[IA] (Alan Nicolas)

---

## 🙏 Acknowledgments

CreatorOS stands on the shoulders of giants:

- **MMOS Mind Mapper** - AI personality cloning foundation
- **InnerLens** - Psychometric profiling insights
- **AIOS-FULLSTACK** - Agent orchestration framework
- **Bloom, Campbell, Lewis** - Pedagogical and storytelling frameworks

---

**CreatorOS v2.0.0**
*"Your OS for digital creation and growth"*

Last Updated: 2025-10-27
