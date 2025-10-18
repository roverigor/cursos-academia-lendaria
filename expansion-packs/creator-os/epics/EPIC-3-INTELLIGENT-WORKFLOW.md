# Epic 3: CreatorOS Intelligent Workflow System

**Epic ID:** EPIC-3
**Component:** CreatorOS Expansion Pack
**Status:** 🟡 Planning
**Priority:** P0 (Critical)
**Owner:** Expansion Creator Agent
**Created:** 2025-10-17
**Target Completion:** 2025-10-24

---

## 🎯 Epic Vision

Transform CreatorOS from a template-based course generator into an **intelligent workflow orchestrator** that adapts to user context (greenfield/brownfield scenarios), automatically organizes legacy materials, performs gap analysis, and minimizes manual input through smart elicitation.

### Success Criteria

- ✅ System detects and handles 6+ course creation scenarios automatically
- ✅ Reduces manual brief filling time from 90min to <15min (brownfield scenarios)
- ✅ Automatically organizes loose files with 95%+ accuracy
- ✅ Voice fidelity extraction from transcripts achieves 85%+ accuracy
- ✅ Zero errors in file structure validation
- ✅ User approval checkpoints before all major content generation
- ✅ Full backward compatibility with existing courses

---

## 🧭 Strategic Context

### Problem Statement

**Current State (v2.0):**
- Workflow assumes greenfield (empty folder)
- No intelligence for brownfield (existing materials)
- Forces users to manually fill ALL brief sections (90 min)
- Doesn't leverage existing files (ICP, transcripts, profiles)
- No automatic file organization
- Workflows execute with missing validation steps

**Pain Points:**
1. **User Frustration:** "I already have materials, why retype everything?"
2. **Wasted Effort:** Valuable data (transcripts, ICP docs) ignored
3. **Workflow Breaks:** Missing curriculum.yaml, skipped approvals
4. **File Chaos:** Loose files (ICP.md, profiles) scattered in wrong places
5. **Version Misalignment:** Agent v1.0 executing Task v2.0 logic

**Impact:**
- 🔴 Poor UX: Users abandon workflow after 30+ min of repetitive data entry
- 🔴 Low Accuracy: Manual typing introduces errors vs. reading existing files
- 🔴 Wasted Intelligence: AI can extract voice/ICP but doesn't
- 🔴 Technical Debt: Workarounds proliferate instead of fixing root cause

### Desired State (v3.0)

**Intelligent, Context-Aware Workflow:**
```
┌─────────────────────────────────────────────────────────────┐
│  User: *generate-course                                      │
│  System: "Slug?" → "dominando-obsidian"                      │
│  System: "Greenfield or Brownfield?" → "Brownfield"          │
│                                                               │
│  🧠 AI ANALYZES EXISTING FOLDER:                              │
│  ✓ Found 38 transcripts → Extract voice patterns            │
│  ✓ Found ICP.md → Parse demographics/psychographics         │
│  ✓ Found Adriano profile → Load instructor persona          │
│  ✓ Loose files detected → Auto-organize structure           │
│                                                               │
│  📋 COURSE-BRIEF.md GENERATED:                                │
│  - 🟢 Section 2 (ICP): 100% complete (from ICP.md)          │
│  - 🟢 Section 4 (Voice): 100% complete (from transcripts)   │
│  - 🟡 Section 3 (Objectives): 80% inferred (needs review)   │
│  - 🔴 Section 6 (Commercial): 0% (user must fill)           │
│                                                               │
│  ✋ HALT: "15 min to finish brief, then *continue-course"    │
└─────────────────────────────────────────────────────────────┘
```

**Key Innovations:**
1. **Scenario Detection:** Auto-detect greenfield/brownfield/hybrid
2. **Intelligent Extraction:** Parse existing materials (voice, ICP, objectives)
3. **Auto-Organization:** Fix folder structure before proceeding
4. **Gap Analysis:** Ask ONLY what's truly missing
5. **Prefilled Briefs:** 60-90% pre-populated in brownfield scenarios
6. **Validation Gates:** Curriculum approval, lesson checkpoint reviews
7. **Version Alignment:** Agent/Task compatibility checks

---

## 📊 Complete Scenario Matrix

### **Scenario 1: Greenfield - Empty Folder**
**Context:** Brand new course, no existing materials
**Folder State:** `outputs/courses/{slug}/` doesn't exist
**User Journey:**
1. User: `*generate-course` → "my-new-course" → "Greenfield"
2. System: Creates empty folder structure
3. System: Copies blank COURSE-BRIEF.md template
4. System: HALTS - "Fill all 8 sections (~60-90 min)"
5. User: Fills brief manually
6. User: `*continue-course my-new-course`
7. System: Generates course from brief

**Brief Pre-fill:** 0% (all manual)
**Time Estimate:** 90 minutes

---

### **Scenario 2: Brownfield - Legacy Course Upgrade**
**Context:** Existing course with transcripts/materials
**Folder State:** `outputs/courses/{slug}/` exists with:
- `/legado/` folder (transcripts, videos)
- ICP.md (loose file in root)
- Instructor profile (loose file in root)

**User Journey:**
1. User: `*generate-course` → "dominando-obsidian" → "Brownfield"
2. System: Detects existing folder, reads ALL files
3. System: **Organizes loose files:**
   - ICP.md stays in legado/ (or moves to /docs/)
   - Adriano profile stays in legado/
   - Creates /resources/, /assessments/ if missing
4. System: **Extracts intelligence:**
   - Voice analysis from transcripts (tone, phrases, style)
   - ICP demographics/psychographics from ICP.md
   - Infers learning objectives from legacy lesson titles
5. System: **Generates COURSE-BRIEF.md with prefilled sections:**
   - 🟢 Section 1 (Basic Info): Title, slug, category (inferred)
   - 🟢 Section 2 (ICP): Complete from ICP.md
   - 🟡 Section 3 (Content): Objectives inferred, framework TBD
   - 🟢 Section 4 (Voice): Complete from transcript analysis
   - 🟡 Section 5 (Format): Duration inferred from legacy count
   - 🔴 Section 6 (Commercial): Empty (user input required)
   - 🟢 Section 7 (Context): References to /legado/ materials
   - 🟡 Section 8 (Checklist): Partial
6. System: **Smart Elicitation (3-5 questions only):**
   - "Pedagogical framework: Bloom/ADDIE/Microlearning/Auto?"
   - "Assessment types: Quiz/Project/Mix?"
   - "Confirm inferred objectives or redefine?"
   - "Commercial details (pricing, launch strategy)?"
7. System: HALTS - "15 min to review/complete brief"
8. User: Reviews 🟡 sections, fills 🔴 section (~15 min)
9. User: `*continue-course dominando-obsidian`
10. System: Generates upgraded course

**Brief Pre-fill:** 70-85% (intelligent extraction)
**Time Estimate:** 15-20 minutes

---

### **Scenario 3: Hybrid - Partial Materials**
**Context:** Some materials exist, but incomplete
**Folder State:** `outputs/courses/{slug}/` exists with:
- Scattered PDFs, docs (no clear structure)
- Maybe ICP doc OR instructor notes (not both)
- No transcripts

**User Journey:**
1. User: `*generate-course` → "marketing-mastery" → "Brownfield"
2. System: Detects folder, inventories files
3. System: **Finds:** ICP notes (partial), some PDF resources
4. System: **Missing:** Instructor voice, transcripts, structured lessons
5. System: **Organizes:**
   - Creates /resources/ → moves PDFs
   - Extracts partial ICP data
6. System: **Generates brief with mixed prefill:**
   - 🟢 Section 2 (ICP): 60% complete (partial data)
   - 🔴 All other sections: Empty or minimal
7. System: **Smart Elicitation (10-12 questions):**
   - Asks for missing ICP details
   - Asks about instructor voice (no transcripts to analyze)
   - Full content/pedagogy questions
8. System: HALTS - "45 min to complete brief"
9. User: Fills remaining ~50% of brief
10. User: `*continue-course marketing-mastery`

**Brief Pre-fill:** 30-50% (partial extraction)
**Time Estimate:** 45 minutes

---

### **Scenario 4: MMOS-Powered - Expert Persona Available**
**Context:** Course with MMOS mind as instructor
**Folder State:** Empty OR minimal
**Special:** `outputs/minds/{instructor-slug}/` exists

**User Journey:**
1. User: `*generate-course` → "python-bootcamp" → "Greenfield"
2. System: Asks - "Use MMOS instructor persona? (joao_lozano/pedro_valerio available)"
3. User: Selects "joao_lozano"
4. System: **Loads MMOS persona:**
   - Reads `outputs/minds/joao_lozano/system_prompts/generalista.md`
   - Extracts identity-core, cognitive-spec, communication-style
5. System: **Pre-fills brief Section 4 (Voice) from MMOS:**
   - Tone, style, catchphrases, values
   - Teaching philosophy, interaction patterns
6. System: **Elicits remaining sections** (ICP, content, etc.)
7. System: HALTS - "60 min to complete brief"
8. User: Fills ICP and content sections (voice already done)
9. User: `*continue-course python-bootcamp`
10. System: Generates lessons **in João's voice** (fidelity target: 90%+)

**Brief Pre-fill:** 20-30% (voice section complete)
**Time Estimate:** 60 minutes
**Unique Feature:** Voice fidelity validation using MMOS benchmarks

---

### **Scenario 5: Re-run - Course Already Exists (Error Recovery)**
**Context:** User accidentally re-runs `*generate-course` on existing course
**Folder State:** Full course already generated (lessons, curriculum.yaml, etc.)

**User Journey:**
1. User: `*generate-course` → "dominando-obsidian"
2. System: **Detects existing course structure:**
   - ✓ COURSE-BRIEF.md exists
   - ✓ curriculum.yaml exists
   - ✓ /lessons/ folder has content
3. System: **ERROR with recovery options:**
   ```
   ⚠️ Course "dominando-obsidian" already exists!

   Found:
   - COURSE-BRIEF.md (filled)
   - curriculum.yaml (22 lessons)
   - lessons/ (12 lessons generated)

   What would you like to do?
   1. [REGENERATE] Delete and start fresh (⚠️ DESTRUCTIVE)
   2. [RESUME] Continue from where it stopped (12/22 lessons)
   3. [UPDATE] Modify COURSE-BRIEF.md and re-generate
   4. [CANCEL] Exit without changes
   ```
4. User: Selects option (2, 3, or 4 recommended)
5. System: Executes chosen action safely

**Brief Pre-fill:** 100% (already exists)
**Time Estimate:** 0 minutes (recovery flow)

---

### **Scenario 6: Import - External Course Migration**
**Context:** Migrating from other platform (Teachable, Hotmart, Udemy)
**Folder State:** User exported files (transcripts, slides, etc.)

**User Journey:**
1. User: Manually creates `outputs/courses/imported-course/import/` folder
2. User: Dumps exported files (whatever format) into /import/
3. User: `*generate-course` → "imported-course" → "Brownfield"
4. System: Detects /import/ folder
5. System: **Smart Import Analysis:**
   - Identifies file types (video, transcript, PDF, SCORM, etc.)
   - Extracts metadata (lesson names, durations from filenames)
   - OCR PDFs for text content if needed
   - Transcribes videos if no transcripts (optional, costly)
6. System: **Organizes imports:**
   - Transcripts → /legado/transcripts/
   - Videos → /legado/videos/
   - Slides/PDFs → /resources/
7. System: **Proceeds as Scenario 2 (Brownfield)**
8. System: Generates brief with extracted intelligence

**Brief Pre-fill:** 40-70% (depends on import quality)
**Time Estimate:** 30-60 minutes
**Unique Feature:** Multi-format import intelligence

---

## 🏗️ Architecture - Intelligent Decision Tree

```
*generate-course invoked
    ↓
Q1: "Course slug?"
    ↓
Q2: "Greenfield (new) or Brownfield (existing)?"
    ↓
┌───────────────────────────────────┬─────────────────────────────┐
│ GREENFIELD                        │ BROWNFIELD                  │
├───────────────────────────────────┼─────────────────────────────┤
│ Check: Does folder exist?         │ Check: Does folder exist?   │
│   NO  → Create empty structure    │   NO  → ERROR (contradiction)
│   YES → Scenario 5 (Error)        │   YES → Proceed ✓           │
│                                   │                             │
│ Q3: Use MMOS instructor?          │ Inventory ALL files:        │
│   YES → Load MMOS persona         │   - Transcripts?            │
│   NO  → Skip                      │   - ICP docs?               │
│                                   │   - Instructor profiles?    │
│ Copy blank COURSE-BRIEF.md        │   - Lesson materials?       │
│ HALT: "Fill all sections"         │   - /import/ folder?        │
│ Time: 60-90 min                   │                             │
│                                   │ Organize loose files        │
│                                   │ Extract intelligence        │
│                                   │ Generate prefilled brief    │
│                                   │ Smart elicitation (gaps)    │
│                                   │ HALT: "Review/complete"     │
│                                   │ Time: 15-60 min (adaptive)  │
└───────────────────────────────────┴─────────────────────────────┘
                    ↓
         User fills/reviews COURSE-BRIEF.md
                    ↓
         *continue-course {slug}
                    ↓
         Read COURSE-BRIEF.md (validation)
                    ↓
         Generate course-outline.md
                    ↓
         Generate curriculum.yaml
                    ↓
         📋 CHECKPOINT: Present curriculum for approval
                    ↓
         User approves? (YES/NO)
                    ↓
         ┌─────────┴─────────┐
         YES                 NO
         ↓                   ↓
  Generate lessons      Return to brief editing
  (1.1, 1.2, ...)       (iterate)
         ↓
  Validation checks
  (pedagogy, voice, completeness)
         ↓
  ✅ Course complete!
```

---

## 📦 Story Breakdown

### Story 3.1: Greenfield/Brownfield Detection System
**Priority:** P0
**Complexity:** M (Medium)
**Story Points:** 8

**As a** course creator
**I want** the system to automatically detect if I'm creating a new course or upgrading an existing one
**So that** I'm not asked irrelevant questions and the workflow adapts to my context

**Acceptance Criteria:**
- [ ] System asks "Greenfield or Brownfield?" as first question after slug
- [ ] If user selects Greenfield, system checks folder doesn't exist (error if exists)
- [ ] If user selects Brownfield, system checks folder exists (error if doesn't)
- [ ] Decision persisted in COURSE-BRIEF.md frontmatter (`creation_mode: greenfield|brownfield`)
- [ ] Error messages provide clear recovery instructions
- [ ] Works correctly for all 6 scenarios in matrix

**Dependencies:** None
**Blockers:** None

---

### Story 3.2: Intelligent File Inventory & Organization
**Priority:** P0
**Complexity:** L (Large)
**Story Points:** 13

**As a** course creator with existing materials
**I want** the system to automatically organize my loose files into proper structure
**So that** I don't waste time manually organizing before starting

**Acceptance Criteria:**
- [ ] System recursively scans `outputs/courses/{slug}/` for all files
- [ ] Categorizes files by type:
  - Transcripts (`.txt`, `.srt`, `.vtt`)
  - Videos (`.mp4`, `.mov`, `.avi`)
  - Documents (`.pdf`, `.docx`, `.md`)
  - Images (`.png`, `.jpg`, `.svg`)
  - ICP files (contains "ICP", "audience", "avatar" in name/content)
  - Instructor profiles (contains "instructor", "professor", person name)
  - Structured data (COURSE-BRIEF.md, curriculum.yaml, etc.)
- [ ] Automatically organizes into canonical structure:
  - Transcripts → `/legado/transcripts/` (create if needed)
  - Videos → `/legado/videos/`
  - ICP docs → Keep in `/legado/` (accessible for extraction)
  - Profiles → Keep in `/legado/`
  - Resources → `/resources/`
  - Preserves `/lessons/`, `/assessments/` if exist
- [ ] Logs all file movements to `organization-log.md` for audit
- [ ] Handles edge cases:
  - Duplicate filenames (append `-1`, `-2` suffixes)
  - Unknown file types (create `/legado/other/`)
  - Circular symlinks (skip with warning)
- [ ] Never deletes files, only moves/copies
- [ ] Provides summary: "Organized 42 files: 38 transcripts, 2 ICP docs, 2 profiles"

**Dependencies:** Story 3.1
**Blockers:** None

---

### Story 3.3: ICP Extraction Engine
**Priority:** P0
**Complexity:** M
**Story Points:** 8

**As a** course creator with existing ICP documentation
**I want** the system to extract demographics, psychographics, and pain points automatically
**So that** I don't retype information I already have

**Acceptance Criteria:**
- [ ] System searches for ICP-related files (case-insensitive):
  - Filenames: `*icp*.md`, `*avatar*.md`, `*audience*.md`, `*persona*.md`
  - Content keywords: "ideal customer", "target audience", "buyer persona"
- [ ] Parses structured sections (Markdown headers):
  - Demographics (age, location, occupation, income)
  - Psychographics (values, fears, desires, moment of life)
  - Pain points / frustrations
  - Goals / aspirations
  - Archetypes (if mentioned)
- [ ] Extracts to structured format:
  ```yaml
  icp_extracted:
    demographics:
      age_range: "35-45"
      location: "Brasil"
      occupation: ["Empreendedor Digital", "Executivo"]
    psychographics:
      moment_of_life: "Transição consciente..."
      mental_state: "Saturado, buscando clareza"
    pain_points:
      - "Sobrecarga cognitiva"
      - "Infinite consumption loop"
    goals:
      - "Executar com foco"
      - "Sistema sustentável"
  ```
- [ ] Prefills Section 2 of COURSE-BRIEF.md with extracted data
- [ ] Marks section as 🟢 (complete) or 🟡 (review) based on completeness:
  - 🟢 Complete: All 4 subsections filled (demo, psycho, pain, goals)
  - 🟡 Review: 2-3 subsections filled
  - 🔴 Missing: <2 subsections
- [ ] Handles multiple ICP files (merge strategy: first file wins, log conflicts)
- [ ] Gracefully handles malformed Markdown (skip unparseable sections)

**Dependencies:** Story 3.2
**Blockers:** None

---

### Story 3.4: Voice & Persona Extraction from Transcripts
**Priority:** P0
**Complexity:** L
**Story Points:** 13

**As a** course creator upgrading a legacy course with transcripts
**I want** the system to analyze instructor voice patterns automatically
**So that** the regenerated course maintains authentic voice fidelity

**Acceptance Criteria:**
- [ ] System detects transcript files in `/legado/` or `/transcripts/`
- [ ] Samples diverse transcripts (algorithm):
  - If ≤5 transcripts: Analyze all
  - If 6-20: Analyze first, middle, last + 2 random
  - If >20: Analyze first, last + 3 random from middle third
- [ ] Extracts voice patterns using AI analysis:
  - **Greeting signature** (first 3 sentences of each transcript)
  - **Tone** (formal/casual, warm/professional, etc.)
  - **Recurring phrases** (frequency analysis, top 10)
  - **Teaching style** (theory-first vs. practice-first, uses analogies, etc.)
  - **Interaction patterns** (questions to audience, rhetorical devices)
  - **Personality markers** (humor, empathy, authority)
- [ ] Generates structured voice profile:
  ```yaml
  voice_profile:
    instructor_name: "Adriano de Marqui" (detected from content)
    signature_greeting: "Fala, lendário!"
    tone: "Warm, conversational, peer-to-peer mentor"
    style: "Practical-first, 80/20 principle, anticipates concerns"
    recurring_phrases:
      - "Olha só..." (38 occurrences)
      - "Então vamos lá..." (27 occurrences)
      - "Mão na massa" (19 occurrences)
      - "Tá?" (52 occurrences)
    teaching_approach: "WHY before HOW, acknowledges alternatives"
    personality_traits:
      - "Builds confidence"
      - "Addresses objections proactively"
      - "Uses real-world examples"
  ```
- [ ] Prefills Section 4 (Voice & Personality) of COURSE-BRIEF.md
- [ ] Marks as 🟢 if ≥3 transcripts analyzed, 🟡 if 1-2
- [ ] Provides confidence score (0-100%) for voice fidelity potential
- [ ] Handles errors gracefully:
  - Corrupted transcripts: Skip and log warning
  - Non-text files: Skip silently
  - Empty transcripts: Skip and log warning

**Dependencies:** Story 3.2
**Blockers:** None
**Technical Notes:**
- Uses AI model for semantic analysis (GPT-4 mini or equivalent)
- Caches analysis results in `/legado/.voice-analysis-cache.yaml`
- Budget: ~$0.10-0.50 per analysis (acceptable for UX gain)

---

### Story 3.5: Learning Objectives Inference Engine
**Priority:** P1 (High)
**Complexity:** M
**Story Points:** 8

**As a** course creator with legacy lesson materials
**I want** the system to infer learning objectives from existing content
**So that** I have a starting point instead of blank fields

**Acceptance Criteria:**
- [ ] System analyzes legacy lesson titles/filenames for intent
- [ ] Applies pattern matching to common pedagogical structures:
  - "Instalação X" → "Install and configure X successfully"
  - "Conceitos de Y" → "Understand core concepts of Y"
  - "Workshop Z" → "Apply Z to real-world scenario"
  - "Porque usar X" → "Evaluate benefits and trade-offs of X"
- [ ] Maps to Bloom's Taxonomy levels:
  - Remember: "Understand", "Identify", "Recall"
  - Understand: "Explain", "Summarize", "Interpret"
  - Apply: "Use", "Implement", "Execute"
  - Analyze: "Evaluate", "Compare", "Troubleshoot"
  - Create: "Design", "Build", "Develop"
- [ ] Generates draft objectives (3-5 per course):
  ```yaml
  inferred_objectives:
    - level: "Apply"
      objective: "Build a functional second brain in Obsidian"
      source: "Lessons 10-15 (instalação, configuração)"
    - level: "Understand"
      objective: "Organize knowledge with sustainable systems"
      source: "Lessons 28-31 (tags, pastas, propriedades)"
    - level: "Create"
      objective: "Integrate AI to supercharge productivity"
      source: "Lessons 32-35 (IA modules)"
  ```
- [ ] Prefills Section 3.2 (Learning Objectives) of COURSE-BRIEF.md
- [ ] Marks as 🟡 (needs review) - always requires human validation
- [ ] Provides annotation: "Inferred from N legacy lessons - please review/refine"
- [ ] Falls back gracefully if no lessons found (leaves empty with helpful prompt)

**Dependencies:** Story 3.2
**Blockers:** None

---

### Story 3.6: Gap Analysis & Smart Elicitation
**Priority:** P0
**Complexity:** L
**Story Points:** 13

**As a** course creator
**I want** the system to ask ONLY what's truly missing from my brief
**So that** I don't waste time answering questions about data already extracted

**Acceptance Criteria:**
- [ ] System performs completeness check on all 8 COURSE-BRIEF.md sections:
  ```yaml
  section_1_basic_info:
    title: 🟡 (inferred from folder/legacy, needs confirmation)
    slug: 🟢 (user provided)
    category: 🔴 (unknown)
    duration: 🟡 (inferred from legacy lesson count)
  section_2_icp:
    demographics: 🟢 (extracted from ICP.md)
    psychographics: 🟢 (extracted)
    pain_points: 🟢 (extracted)
  section_3_content:
    objectives: 🟡 (inferred, needs review)
    framework: 🔴 (unknown)
  section_4_voice:
    tone: 🟢 (extracted from transcripts)
    style: 🟢 (extracted)
    phrases: 🟢 (extracted)
  section_5_format:
    lesson_duration: 🟡 (inferred)
    assessment_types: 🔴 (unknown)
  section_6_commercial:
    pricing: 🔴 (unknown)
    launch: 🔴 (unknown)
  section_7_context:
    references: 🟢 (auto-generated links to /legado/)
  section_8_checklist:
    status: 🟡 (auto-populated)
  ```
- [ ] Generates targeted elicitation questions ONLY for 🔴 and 🟡 items:
  - 🟢 Sections: Skipped (already complete)
  - 🟡 Sections: Confirmation question ("Is this correct or needs adjustment?")
  - 🔴 Sections: Full elicitation question
- [ ] Adaptive question flow:
  - Greenfield (no extraction): Ask 15-20 questions (full brief)
  - Brownfield (good extraction): Ask 3-8 questions (gaps only)
  - Hybrid: Ask 8-12 questions (adaptive)
- [ ] Presents extracted data for validation:
  ```
  I analyzed your existing materials and pre-filled these sections:

  🟢 ICP (Section 2): Complete
     - Demographics: 35-45 anos, Empreendedor/Executivo
     - Pain: Sobrecarga cognitiva, infinite loop
     ✓ Looks good? (yes/no/edit)

  🟡 Learning Objectives (Section 3): Inferred from 38 legacy lessons
     - Build functional second brain
     - Organize with sustainable systems
     - Integrate AI for productivity
     ✓ Confirm or redefine? (confirm/edit)

  🔴 Assessment Types (Section 5): Unknown
     → What assessment types fit this course?
        [ ] Quiz (knowledge checks)
        [ ] Project (hands-on deliverable)
        [ ] Workshop (guided practice)
        [ ] Case Study (scenario analysis)
        [ ] Mix (combination)
  ```
- [ ] Persists all answers back to COURSE-BRIEF.md
- [ ] Updates section statuses (🟡 → 🟢 after confirmation, 🔴 → 🟢 after filling)
- [ ] Final validation: All sections must be 🟢 before HALT

**Dependencies:** Stories 3.3, 3.4, 3.5
**Blockers:** None

---

### Story 3.7: MMOS Persona Integration
**Priority:** P1
**Complexity:** M
**Story Points:** 8

**As a** course creator using MMOS cognitive clones
**I want** to load instructor voice from existing MMOS minds
**So that** I can generate courses in the authentic voice of experts

**Acceptance Criteria:**
- [ ] System detects available MMOS minds in `outputs/minds/*/`
- [ ] During greenfield flow, asks: "Use MMOS instructor persona?"
  - Lists available minds: "joao_lozano", "pedro_valerio", "None (generic)"
- [ ] If user selects MMOS mind:
  - Loads `outputs/minds/{slug}/system_prompts/generalista.md`
  - Parses identity-core, cognitive-spec, communication-style
  - Extracts voice patterns (tone, style, values, catchphrases)
- [ ] Maps MMOS data to COURSE-BRIEF Section 4:
  ```yaml
  voice_source: "mmos"
  mmos_mind: "joao_lozano"
  voice_profile:
    tone: [from identity-core]
    style: [from communication-style]
    values: [from cognitive-spec]
    teaching_philosophy: [synthesized from frameworks.md]
  ```
- [ ] Marks Section 4 as 🟢 (complete from MMOS)
- [ ] During lesson generation (`*continue-course`):
  - Loads full MMOS system prompt
  - Injects into generation context
  - Validates voice fidelity against MMOS benchmarks
- [ ] Handles errors:
  - Mind doesn't exist: Graceful fallback to manual voice definition
  - Corrupted system prompt: Error with recovery instructions
- [ ] Documents MMOS source in course metadata for future regeneration

**Dependencies:** Story 3.6
**Blockers:** None
**Integration Points:** Requires MMOS Mind Mapper expansion pack

---

### Story 3.8: Curriculum Approval Checkpoint
**Priority:** P0
**Complexity:** S (Small)
**Story Points:** 5

**As a** course creator
**I want** to review and approve the curriculum before lessons are generated
**So that** I don't waste time/cost generating content I'll have to redo

**Acceptance Criteria:**
- [ ] After generating `curriculum.yaml`, `*continue-course` MUST pause
- [ ] System presents curriculum summary:
  ```
  📋 CURRICULUM GENERATED

  Course: Dominando Obsidian
  Total: 22 lessons in 6 modules (12-15 hours)

  Module 1: Fundamentos (4 lessons)
    1.1 - Por Que Segundo Cérebro (20 min)
    1.2 - Por Que Obsidian (15 min)
    1.3 - Instalação Multi-Plataforma (25 min)
    1.4 - Configurações Essenciais (15 min)

  Module 2: Escrita e Formatação (3 lessons)
    2.1 - Markdown Essencial (30 min)
    ...

  [Full outline shown or link to curriculum.yaml]

  ---

  ⏸️  CHECKPOINT: Approve curriculum?

  Options:
  1. ✅ APPROVE - Generate all 22 lessons (~$15-25 cost, 30-45 min)
  2. ✏️  EDIT - Modify curriculum.yaml manually, then continue
  3. 🔄 REGENERATE - Go back to COURSE-BRIEF.md and adjust
  4. ❌ CANCEL - Stop workflow

  Your choice (1-4):
  ```
- [ ] If user selects:
  - **1 (Approve):** Proceed to Story 3.9 (lesson generation)
  - **2 (Edit):** Provide instructions, wait for user to edit curriculum.yaml, then re-validate and re-prompt
  - **3 (Regenerate):** Return to COURSE-BRIEF.md editing, re-run outline/curriculum generation
  - **4 (Cancel):** Exit gracefully with message
- [ ] Validation on re-entry (after edit):
  - Check curriculum.yaml syntax (valid YAML)
  - Check lesson numbering sequence (no gaps, duplicates)
  - Check module structure (at least 1 module, lessons per module reasonable)
  - Warn if total duration changed significantly (>20% from brief)
- [ ] Log approval decision to `generation-log.md` for audit
- [ ] Never auto-approve (always require human decision)

**Dependencies:** Story 3.6
**Blockers:** None
**UI Note:** This is a critical "spend money" checkpoint - must be explicit

---

### Story 3.9: Lesson Generation with Progress Tracking
**Priority:** P0
**Complexity:** L
**Story Points:** 13

**As a** course creator
**I want** to see real-time progress as lessons are generated
**So that** I know the system is working and can estimate completion time

**Acceptance Criteria:**
- [ ] After curriculum approval, system generates lessons sequentially
- [ ] Naming convention: `{module}.{lesson}-{slug}.md`
  - Example: `1.1-por-que-segundo-cerebro.md`
  - NOT folder-based (no `modulo-1/` directories)
- [ ] Progress display (live updates):
  ```
  🎬 Generating Course: Dominando Obsidian

  Progress: ████████░░░░░░░░░░░░░░ 8/22 lessons (36%)

  ✅ 1.1 - Por Que Segundo Cérebro (completed in 47s)
  ✅ 1.2 - Por Que Obsidian (completed in 52s)
  ✅ 1.3 - Instalação Multi-Plataforma (completed in 1m 15s)
  ✅ 1.4 - Configurações Essenciais (completed in 43s)
  ✅ 2.1 - Markdown Essencial (completed in 1m 8s)
  ✅ 2.2 - Tipos de Notas (completed in 56s)
  ✅ 2.3 - Arquivos e Anexos (completed in 49s)
  🔄 3.1 - Pastas Minimalistas (generating... 23s elapsed)
  ⏳ 3.2 - Tags e Hierarquias (queued)
  ⏳ 3.3 - Properties (queued)
  ...

  Estimated completion: 18 minutes
  Estimated cost: $12.50
  ```
- [ ] Each lesson generation:
  - Loads COURSE-BRIEF context + curriculum entry
  - Loads voice profile (from brief or MMOS)
  - Generates lesson content using pedagogical framework
  - Validates output (non-empty, has learning objectives, etc.)
  - Writes to `lessons/{module}.{lesson}-{slug}.md`
  - Updates progress display
- [ ] Error handling:
  - Generation failure: Retry up to 2 times
  - After 2 retries: Mark lesson as 🔴 FAILED, continue to next
  - At end, report failures: "20/22 lessons succeeded, 2 failed (see details)"
- [ ] Completion summary:
  ```
  ✅ Course Generation Complete!

  Generated: 22/22 lessons (100%)
  Total time: 24 minutes
  Total cost: $13.75

  Output:
  - Curriculum: outputs/courses/dominando-obsidian/curriculum.yaml
  - Lessons: outputs/courses/dominando-obsidian/lessons/ (22 files)
  - Outline: outputs/courses/dominando-obsidian/course-outline.md

  Next steps:
  1. Review generated lessons for quality
  2. Run validation: *validate-course dominando-obsidian
  3. Generate assessments: *generate-assessments dominando-obsidian
  ```
- [ ] Graceful interruption (user cancels mid-generation):
  - Save progress state: `generation-state.yaml`
  - Allow resume: `*continue-course dominando-obsidian --resume`
  - Pick up from last completed lesson

**Dependencies:** Story 3.8
**Blockers:** None
**Performance Target:** <90s per lesson on average

---

### Story 3.10: Version Alignment & Compatibility Checks
**Priority:** P1
**Complexity:** S
**Story Points:** 3

**As a** system maintainer
**I want** agents and tasks to validate version compatibility
**So that** mismatches like v1.0 agent + v2.0 task don't cause silent failures

**Acceptance Criteria:**
- [ ] All tasks declare version in frontmatter:
  ```yaml
  task_version: "3.0"
  required_agent_version: ">=3.0"
  ```
- [ ] All agents declare version in frontmatter:
  ```yaml
  agent_version: "3.0"
  compatible_task_versions: ["3.0"]
  ```
- [ ] On task invocation, system checks compatibility:
  - Agent version ≥ required version: ✅ Proceed
  - Agent version < required version: ❌ Error with upgrade instructions
- [ ] Error message format:
  ```
  ❌ VERSION MISMATCH

  Task: generate-course (v3.0)
  Agent: course-architect (v1.0)

  The current agent is outdated and incompatible with this task.

  Required: course-architect v3.0+
  Installed: course-architect v1.0

  Actions:
  1. Update agent: Copy expansion-packs/creator-os/agents/course-architect-v3.md
  2. Or use compatible task: *generate-course-v1 (deprecated)

  Docs: docs/guides/version-management.md
  ```
- [ ] Backward compatibility mode (optional):
  - If task supports `backward_compatible: ["2.0"]`
  - System can auto-adapt workflow to older agent version
  - Logs warning: "Running in compatibility mode (degraded features)"
- [ ] Version check bypas (debug only):
  - Flag: `*generate-course --force-version`
  - Logs warning: "Version check bypassed (expect errors)"

**Dependencies:** None
**Blockers:** None
**Impact:** Prevents 80% of workflow execution errors

---

### Story 3.11: Error Recovery & Resume System
**Priority:** P1
**Complexity:** M
**Story Points:** 8

**As a** course creator
**I want** to resume course generation if it fails or I cancel mid-process
**So that** I don't lose progress and waste time/money regenerating completed lessons

**Acceptance Criteria:**
- [ ] System saves state at each major checkpoint:
  - After folder organization: `state-1-organized.yaml`
  - After brief completion: `state-2-brief-complete.yaml`
  - After curriculum approval: `state-3-curriculum-approved.yaml`
  - Every 5 lessons: `state-4-lessons-progress.yaml`
- [ ] State file format:
  ```yaml
  checkpoint: "lesson_generation"
  timestamp: "2025-10-17T14:23:45Z"
  course_slug: "dominando-obsidian"
  progress:
    lessons_completed: 12
    lessons_total: 22
    last_completed: "2.3-arquivos-anexos.md"
    next_pending: "3.1-pastas-minimalistas.md"
  context:
    brief_path: "outputs/courses/dominando-obsidian/COURSE-BRIEF.md"
    curriculum_path: "outputs/courses/dominando-obsidian/curriculum.yaml"
    voice_profile: [cached voice data]
  ```
- [ ] On failure/cancellation:
  - Detect interruption (error thrown or user CTRL+C)
  - Save current state immediately
  - Display recovery instructions:
    ```
    ⚠️  Generation interrupted at 12/22 lessons.

    Progress saved to: state-4-lessons-progress.yaml

    To resume:
    *continue-course dominando-obsidian --resume

    To start fresh (⚠️ deletes progress):
    *continue-course dominando-obsidian --force
    ```
- [ ] Resume logic:
  - Load state file
  - Validate context still valid (files not deleted/corrupted)
  - Skip completed lessons (based on `lessons_completed` list)
  - Continue from `next_pending`
  - Update progress display to show resumed state
- [ ] State cleanup:
  - After successful completion: Delete all state files
  - After 7 days: Auto-delete old state files (configurable)
  - Manual cleanup: `*cleanup-states` command
- [ ] Handles edge cases:
  - Curriculum changed during interruption: Warn user, offer regenerate option
  - Brief changed: Warn user, validate changes compatible
  - Lesson files manually deleted: Detect and re-generate those lessons
- [ ] Resumption idempotency:
  - Re-running resume command multiple times is safe
  - Does not duplicate work or corrupt state

**Dependencies:** Story 3.9
**Blockers:** None
**User Value:** Saves hours of regeneration time and $$$ on failures

---

### Story 3.12: Comprehensive Validation & Quality Checks
**Priority:** P1
**Complexity:** M
**Story Points:** 8

**As a** course creator
**I want** the system to validate generated content for quality and completeness
**So that** I catch issues early before publishing

**Acceptance Criteria:**
- [ ] New task: `*validate-course {slug}`
- [ ] Validation categories:

  **1. Structural Validation:**
  - [ ] All lessons exist (no gaps in numbering)
  - [ ] File naming convention correct (`M.L-slug.md`)
  - [ ] Folder structure matches spec (no legacy `modulo-1/` folders)
  - [ ] Required files present (COURSE-BRIEF, curriculum.yaml, course-outline.md)

  **2. Content Completeness:**
  - [ ] Each lesson has:
    - Learning objectives (at least 1)
    - Introduction section
    - Main content (>500 words for standard lessons)
    - Conclusion/summary
    - Practice exercise or reflection prompt
  - [ ] Curriculum.yaml matches generated lessons (no orphans)

  **3. Pedagogical Alignment:**
  - [ ] Learning objectives use Bloom's Taxonomy verbs
  - [ ] Objectives aligned with assessments (if generated)
  - [ ] Cognitive load balanced (no 3+ consecutive "Create" level lessons)
  - [ ] Dependency flow logical (Lesson N doesn't reference concepts from Lesson N+1)

  **4. Voice Fidelity (if instructor voice defined):**
  - [ ] Sample 3-5 random lessons
  - [ ] Check for signature phrases (from voice profile)
  - [ ] Validate tone consistency (formal vs. casual)
  - [ ] Calculate fidelity score (0-100%)
    - 90-100%: Excellent ✅
    - 75-89%: Good 🟡
    - <75%: Poor 🔴 (needs revision)

  **5. Accessibility & Formatting:**
  - [ ] All Markdown valid (no syntax errors)
  - [ ] Images have alt text
  - [ ] Links functional (internal links resolve)
  - [ ] Code blocks have language specified

- [ ] Validation report format:
  ```
  📊 VALIDATION REPORT: dominando-obsidian
  Generated: 2025-10-17 14:45:30

  ✅ PASSED (18/20 checks)
  🟡 WARNINGS (2)

  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  📁 Structure: ✅ PASS
     ✓ 22/22 lessons present
     ✓ File naming correct
     ✓ Required files exist

  📝 Content: 🟡 WARNING
     ✓ All lessons >500 words
     ✓ Learning objectives present
     ⚠️  Lesson 3.2: Missing practice exercise
     ⚠️  Lesson 5.4: Conclusion section too brief (<50 words)

  🎓 Pedagogy: ✅ PASS
     ✓ Bloom's verbs used correctly
     ✓ Cognitive load balanced
     ✓ Dependencies logical

  🎭 Voice Fidelity: ✅ EXCELLENT (92%)
     ✓ Signature phrases present in 4/5 samples
     ✓ Tone consistent (warm, conversational)
     ✓ Style matches profile

  ♿ Accessibility: ✅ PASS
     ✓ Markdown valid
     ✓ Alt text present
     ✓ Links functional

  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  🔧 RECOMMENDED ACTIONS:
  1. Add practice exercise to Lesson 3.2
  2. Expand conclusion in Lesson 5.4

  Report saved: outputs/courses/dominando-obsidian/validation-report-20251017.md
  ```
- [ ] Validation stored in course folder for future reference
- [ ] Can be re-run anytime (idempotent)
- [ ] Integrates with CI/CD (returns exit code 0 = pass, 1 = warnings, 2 = errors)

**Dependencies:** Story 3.9
**Blockers:** None
**User Value:** Ensures course quality before launch

---

## 🎯 Success Metrics & KPIs

### User Experience Metrics
- **Brief Completion Time:**
  - Greenfield: Target <60 min (baseline: N/A)
  - Brownfield (good extraction): Target <15 min (baseline: 90 min)
  - Hybrid: Target <45 min (baseline: 90 min)

- **User Satisfaction:**
  - Post-workflow survey: "How satisfied are you?" (1-5 scale)
  - Target: ≥4.5/5.0 for brownfield scenarios

- **Error Rate:**
  - Workflow failures: Target <5% (baseline: unknown)
  - Version mismatch errors: Target 0% after Story 3.10

### System Performance Metrics
- **Extraction Accuracy:**
  - ICP extraction: Target ≥90% field accuracy (manual validation)
  - Voice extraction: Target ≥85% fidelity score (MMOS benchmark)
  - Objectives inference: Target ≥70% relevance (user approval rate)

- **Organization Accuracy:**
  - File movements: Target 0% data loss
  - Structure compliance: Target 100% (validated by tests)

- **Generation Quality:**
  - Validation pass rate: Target ≥90% (after Story 3.12)
  - Voice fidelity: Target ≥85% for MMOS, ≥80% for transcript-based

### Business Metrics
- **Cost Efficiency:**
  - Brownfield cost savings: Target 70% reduction (less re-typing → less tokens)
  - Resume feature adoption: Target 60% of interrupted workflows (vs. re-start)

- **Adoption:**
  - % of courses using brownfield mode: Track over time
  - % of MMOS persona usage: Track over time

---

## 🚧 Technical Architecture Notes

### File Organization Algorithm
```python
def organize_course_files(course_slug: str):
    base_path = f"outputs/courses/{course_slug}/"

    # Scan all files recursively
    all_files = scan_directory(base_path, recursive=True)

    # Categorize
    transcripts = [f for f in all_files if is_transcript(f)]
    videos = [f for f in all_files if is_video(f)]
    icp_docs = [f for f in all_files if is_icp_doc(f)]
    profiles = [f for f in all_files if is_instructor_profile(f)]
    resources = [f for f in all_files if is_resource(f)]

    # Organize
    create_folder_if_missing(f"{base_path}/legado/transcripts/")
    move_files(transcripts, f"{base_path}/legado/transcripts/")

    create_folder_if_missing(f"{base_path}/legado/videos/")
    move_files(videos, f"{base_path}/legado/videos/")

    # ICP and profiles stay in /legado/ root for easy access
    move_files(icp_docs, f"{base_path}/legado/")
    move_files(profiles, f"{base_path}/legado/")

    create_folder_if_missing(f"{base_path}/resources/")
    move_files(resources, f"{base_path}/resources/")

    # Log all movements
    log_organization_audit(base_path, all_movements)
```

### Voice Extraction Pipeline
```python
def extract_voice_profile(transcripts: List[str]) -> VoiceProfile:
    # Sample strategy
    samples = sample_transcripts(transcripts, strategy="diverse")

    # Extract patterns
    greetings = [extract_first_n_sentences(t, n=3) for t in samples]
    phrases = extract_frequent_phrases(samples, min_frequency=3)
    tone = analyze_tone(samples)  # AI call
    style = analyze_teaching_style(samples)  # AI call

    return VoiceProfile(
        greeting=most_common(greetings),
        tone=tone,
        style=style,
        recurring_phrases=phrases[:10],
        confidence_score=calculate_confidence(samples)
    )
```

### Gap Analysis Logic
```python
def analyze_brief_gaps(brief: CourseBrief, extracted_data: ExtractedData) -> GapAnalysis:
    gaps = {}

    for section in brief.sections:
        status = "complete"  # 🟢

        if section.fields_empty_count > 0:
            if section.id in extracted_data:
                # We have data to prefill
                status = "review"  # 🟡
            else:
                # No data, user must fill
                status = "missing"  # 🔴

        gaps[section.id] = {
            "status": status,
            "fields_missing": section.empty_fields,
            "prefill_source": extracted_data.get(section.id, {}).get("source")
        }

    return GapAnalysis(gaps)
```

---

## 📚 Dependencies & Integration Points

### Internal Dependencies
- **MMOS Mind Mapper:** Story 3.7 requires MMOS system prompts
- **CreatorOS Core:** All stories extend existing CreatorOS framework
- **AIOS Agents:** course-architect agent must be updated to v3.0

### External Dependencies
- **AI Model:** GPT-4 or equivalent for voice/content analysis
- **File System:** Reliable access to `outputs/` directory
- **YAML Parser:** For curriculum.yaml validation

### Breaking Changes
- ⚠️ **Folder Structure:** Moving from `modulo-1/` to `1.1-lesson.md` format
  - **Migration:** Provide `*migrate-course-structure {slug}` command
- ⚠️ **Agent Version:** course-architect v1.0 → v3.0
  - **Migration:** Documentation + version check (Story 3.10)

---

## 🧪 Testing Strategy

### Unit Tests
- [ ] File categorization logic (is_transcript, is_icp_doc, etc.)
- [ ] YAML parsing and validation
- [ ] Lesson numbering sequence validation
- [ ] Voice profile extraction (mock transcripts)

### Integration Tests
- [ ] End-to-end greenfield workflow
- [ ] End-to-end brownfield workflow (with mock legacy files)
- [ ] Resume workflow after simulated failure
- [ ] MMOS integration (with test mind)

### User Acceptance Tests
- [ ] Real course migration (dominando-obsidian)
- [ ] Greenfield course creation (test case)
- [ ] Voice fidelity validation (manual review)
- [ ] Brief prefill accuracy (manual validation)

---

## 🗓️ Implementation Plan

### Phase 1: Foundation (Week 1)
- Story 3.1: Detection System
- Story 3.2: File Inventory & Organization
- Story 3.10: Version Alignment

### Phase 2: Intelligence (Week 2)
- Story 3.3: ICP Extraction
- Story 3.4: Voice Extraction
- Story 3.5: Objectives Inference
- Story 3.6: Gap Analysis & Elicitation

### Phase 3: Generation (Week 3)
- Story 3.7: MMOS Integration
- Story 3.8: Curriculum Approval
- Story 3.9: Lesson Generation

### Phase 4: Quality (Week 4)
- Story 3.11: Error Recovery
- Story 3.12: Validation System
- Testing & refinement

---

## 📖 Documentation Requirements

### User Documentation
- [ ] Guide: "Upgrading a Legacy Course (Brownfield Workflow)"
- [ ] Guide: "Creating a New Course (Greenfield Workflow)"
- [ ] Guide: "Using MMOS Personas as Instructors"
- [ ] FAQ: "What file formats are supported?"
- [ ] Tutorial: "Organizing Your Course Materials Before Upload"

### Developer Documentation
- [ ] Architecture: "Intelligent Workflow System Design"
- [ ] API: "Extraction Engine Interfaces"
- [ ] Patterns: "Gap Analysis & Smart Elicitation"
- [ ] Migration: "v2.0 → v3.0 Upgrade Guide"

---

## 🎓 Learning & Innovation

### Novel Approaches
1. **Context-Aware Workflows:** Most course generators assume greenfield; we adapt to user reality
2. **Voice Extraction:** Analyzing transcripts to preserve instructor authenticity (unique!)
3. **Gap-Driven Elicitation:** Ask only what's missing (reduces friction by 70%+)
4. **Resume-Anywhere:** State persistence at every checkpoint (industry best practice)

### Risks & Mitigations
| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Voice extraction accuracy <85% | Medium | Medium | Manual override option, confidence scores |
| File organization errors (data loss) | High | Low | Never delete, only move; full audit logs |
| MMOS integration breaks | Medium | Low | Graceful fallback to manual voice definition |
| User rejects inferred data | Low | High | Always mark as 🟡 "needs review" |
| Curriculum changes mid-generation | Medium | Medium | State validation on resume, warn user |

---

## 🎉 Expected Outcomes

### For Users
- ⚡ **10x Faster Brownfield Workflows:** 90 min → 15 min
- 🎯 **Higher Quality:** AI extracts data more accurately than humans retype
- 😊 **Better UX:** No repetitive questions, intelligent assistance
- 💰 **Cost Savings:** Less token usage (read files vs. regenerate from scratch)

### For Product
- 🚀 **Competitive Edge:** Only course generator with brownfield intelligence
- 📈 **Adoption:** Removes friction for users with existing content
- 🔧 **Extensibility:** Extraction engines reusable for other workflows
- 🏆 **Quality:** Validation system ensures professional output

---

**Epic Owner:** @course-architect-agent
**Stakeholders:** All CreatorOS users, AIOS-FULLSTACK community
**Review Cadence:** Weekly sync on Fridays
**Launch Target:** 2025-10-24

---

*This epic represents the evolution of CreatorOS from a tool to an intelligent partner.*
