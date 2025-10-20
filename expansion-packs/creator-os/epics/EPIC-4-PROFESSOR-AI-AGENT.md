# EPIC 4: Professor AI Agent Generation for SuperAgentes Integration

**Epic ID:** EPIC-4
**Status:** 🔴 DISCOVERY (Awaiting Requirements Refinement)
**Priority:** TBD
**Owner:** Product Owner (Sarah)
**Created:** 2025-10-19
**Target Release:** TBD

---

## 📋 Epic Goal

Generate a personalized AI professor agent at the end of course generation that:
1. **Captures the instructor's personality and communication style** with 90%+ fidelity
2. **Contains complete course knowledge** from all generated materials
3. **Integrates with SuperAgentes platform** for student interaction

---

## 🎯 Business Value

### Problem Statement
Currently, CreatorOS generates excellent course content but lacks a **live mentorship component**. Students who complete courses have no way to:
- Ask clarifying questions about course content
- Get personalized feedback on exercises
- Interact with the instructor's teaching style after course completion

### Proposed Solution
Auto-generate a **Professor AI Agent prompt** that:
- Uses the MMOS persona voice (or extracted voice from transcripts)
- Has complete access to all course materials as knowledge base
- Can be deployed instantly to SuperAgentes platform
- Provides authentic instructor experience at scale

### Expected Outcomes
- **For Students:** 24/7 access to AI professor with authentic personality
- **For Creators:** Automated mentorship scaling without manual effort
- **For Platform:** Differentiated value proposition (course + AI mentor bundle)

---

## 🚧 OPEN QUESTIONS (Requires User Input)

### 1️⃣ **MMOS Persona Integration**
The "personality of the professor" refers to:

- [ ] **Option A:** Use MMOS persona already selected in `init_course.py`?
  - Example: Adriano de Marqui, Naval Ravikant, etc.
  - ✅ Pro: Already integrated, 90%+ fidelity guaranteed
  - ⚠️ Con: Requires MMOS persona to be selected upfront

- [ ] **Option B:** Extract voice from `sources/transcripts/`?
  - Uses `voice_extractor.py` to analyze instructor's speech patterns
  - ✅ Pro: Works for any brownfield course with transcripts
  - ⚠️ Con: Lower fidelity (~70-80%) without full MMOS pipeline

- [ ] **Option C:** New configuration step for agent personality?
  - Separate from course instructor voice
  - ⚠️ Con: Adds complexity, may confuse users

**❓ USER DECISION NEEDED:** Which approach should we implement?

---

### 2️⃣ **Knowledge Base - Content Scope**

"All texts generated during course creation" should include:

**Core Content:**
- [ ] All lessons (`lessons/*.md`) ← Confirmed?
- [ ] Assessments (quizzes, projects) ← Include?
- [ ] Resources (templates, checklists) ← Include?
- [ ] COURSE-BRIEF.md + curriculum.yaml ← Include?

**Source Materials:**
- [ ] Original transcripts in `sources/transcripts/` ← Include?
- [ ] ICP documents ← Include?
- [ ] Instructor profile ← Include?

**Derived Content:**
- [ ] GPS validation reports ← Include?
- [ ] Didática Lendária scoring ← Include?

**❓ USER DECISION NEEDED:** Check which content types to include in knowledge base.

---

### 3️⃣ **Output Format & Location**

**File Format:**
- [ ] **Option A:** Markdown (`.md`) - Human-readable, easy to edit
- [ ] **Option B:** YAML (`.yaml`) - Structured, machine-parseable
- [ ] **Option C:** JSON (`.json`) - API-friendly
- [ ] **Option D:** SuperAgentes native format - Direct integration

**File Location:**
```
outputs/courses/{slug}/
├── COURSE-BRIEF.md
├── curriculum.yaml
├── lessons/
├── assessments/
├── resources/
├── sources/
└── PROFESSOR-PROMPT.md ← Should it go here?
   OR
└── professor-agent/
    ├── system-prompt.md
    ├── knowledge-base.yaml
    └── metadata.json
```

**❓ USER DECISION NEEDED:** Preferred format and location?

---

### 4️⃣ **SuperAgentes Platform - Integration Details**

**Critical Missing Information:**

1. **Does SuperAgentes exist already?**
   - [ ] Yes, it's live → Need API docs / integration format
   - [ ] No, it's planned → Define ideal format for future integration
   - [ ] It's a 3rd-party platform → Which one? (e.g., Botpress, Voiceflow, Custom)

2. **What format does SuperAgentes expect?**
   - [ ] System prompt (plain text)
   - [ ] System prompt + embedded knowledge (RAG-style)
   - [ ] API payload (JSON schema needed)
   - [ ] Chat platform integration (Discord, Slack, WhatsApp?)

3. **Integration Method:**
   - [ ] **Manual:** User copies generated prompt to SuperAgentes
   - [ ] **Semi-automated:** CLI command uploads to SuperAgentes API
   - [ ] **Fully automated:** `generate_course.py` auto-deploys agent
   - [ ] **File export:** Generate file compatible with SuperAgentes import

**❓ USER DECISION NEEDED:** Provide SuperAgentes documentation or describe ideal integration flow.

---

### 5️⃣ **Professor Agent - Functional Capabilities**

What should the AI professor agent DO in SuperAgentes?

**Teaching Capabilities:**
- [ ] Answer student questions about course content
- [ ] Explain concepts in different ways (re-teaching)
- [ ] Provide examples and analogies
- [ ] Reference specific lessons/modules

**Assessment Capabilities:**
- [ ] Correct quiz answers with explanations
- [ ] Review project submissions and give feedback
- [ ] Suggest improvements to student work
- [ ] Assign additional practice exercises

**Mentorship Capabilities:**
- [ ] Simulate Socratic dialogue (ask guiding questions)
- [ ] Adapt teaching style to student's learning pace
- [ ] Motivate and encourage students (using instructor's voice)
- [ ] Track student progress (if integrated with LMS)

**Other:**
- [ ] {{User specifies additional capabilities}}

**❓ USER DECISION NEEDED:** Check all capabilities the agent should have.

---

### 6️⃣ **Generation Timing & Workflow**

**When should the professor prompt be generated?**

- [ ] **Option A:** At end of `generate_course.py` (automatic)
  - ✅ Pro: One-click course + agent generation
  - ⚠️ Con: Slower course generation (adds processing time)

- [ ] **Option B:** Separate command `generate_professor_prompt.py`
  - ✅ Pro: User controls when to generate agent
  - ⚠️ Con: Extra step, may be forgotten

- [ ] **Option C:** Incremental updates (after each lesson generation)
  - ✅ Pro: Agent evolves with course
  - ⚠️ Con: Complex implementation, frequent re-generation

**Can it be regenerated?**
- [ ] Yes, regenerate if course content changes (e.g., new lessons added)
- [ ] No, one-time generation only

**❓ USER DECISION NEEDED:** Preferred generation workflow?

---

## 🚨 Identified Blockers & Risks

### Blocker 1: SuperAgentes Format Unknown
**Impact:** Cannot design output format without knowing target platform
**Mitigation:** User provides SuperAgentes docs or defines ideal structure
**Owner:** User (Alan)

### Blocker 2: Knowledge Base Size Limits
**Impact:** Large courses (50+ lessons) may exceed prompt token limits
**Example:** GPT-4 context = 128K tokens. A 50-lesson course could be 200K+ tokens.
**Mitigation Options:**
- Summarize lessons instead of full text
- Use RAG (Retrieval-Augmented Generation) with vector DB
- Chunk knowledge into retrievable segments
**Owner:** To be determined based on SuperAgentes capabilities

### Blocker 3: Voice Fidelity Without MMOS
**Impact:** If no MMOS persona selected, voice extraction may be <80% fidelity
**Mitigation:** Make MMOS persona mandatory for professor agent generation?
**Owner:** PO decision needed

---

## 📦 Preliminary Story Breakdown (Subject to Change)

**Once requirements are clarified, epic will likely consist of:**

### Story 4.1: Professor System Prompt Generation
- Extract instructor personality from MMOS persona or transcripts
- Generate authentic system prompt with teaching directives
- Validate voice fidelity (90%+ target)

### Story 4.2: Course Knowledge Base Compilation
- Aggregate all course materials (lessons, assessments, resources)
- Structure knowledge for efficient retrieval
- Handle large courses (summarization or chunking strategy)

### Story 4.3: SuperAgentes Integration Format
- Package prompt + knowledge in SuperAgentes-compatible format
- Add metadata (course slug, instructor name, version)
- Provide export or API upload mechanism

### Story 4.4: `generate_professor_prompt.py` CLI Tool
- Standalone script to generate professor agent
- Integrate into `generate_course.py` workflow (optional flag)
- Add validation and error handling

### Story 4.5: (Optional) SuperAgentes Auto-Deploy
- API integration for automatic agent deployment
- Authentication and error handling
- Deployment status tracking

---

## ✅ Definition of Done (Epic Level)

**This epic is complete when:**

1. [ ] All open questions above are answered by user
2. [ ] Stories are refined with detailed acceptance criteria
3. [ ] Professor prompt generation is tested with real course
4. [ ] Voice fidelity validated (≥90% if using MMOS, ≥70% if extracted)
5. [ ] Knowledge base correctly includes all specified content
6. [ ] Output format is compatible with SuperAgentes platform
7. [ ] Integration workflow is documented and tested
8. [ ] No regression in existing `generate_course.py` functionality

---

## 🔄 Next Steps

**Immediate Actions:**

1. **User (Alan):** Review and answer all ❓ questions in sections 1-6
2. **User (Alan):** Provide SuperAgentes documentation/specs (if available)
3. **PO (Sarah):** Once answers received, refine epic and create detailed stories
4. **PO (Sarah):** Estimate complexity and assign story points
5. **SM:** Schedule refined stories into sprint backlog

**Dependencies:**
- Requires understanding of SuperAgentes platform architecture
- May require collaboration with SuperAgentes team (if 3rd-party)
- Depends on existing MMOS integration (if using persona voice)

---

## 📚 Related Documentation

- **MMOS Integration:** `expansion-packs/creator-os/stories/STORY-3.7-mmos-persona-integration.md`
- **Voice Extraction:** `expansion-packs/creator-os/lib/voice_extractor.py`
- **Course Generation:** `expansion-packs/creator-os/scripts/generate_course.py`
- **Knowledge Base:** All files in `outputs/courses/{slug}/`

---

## 📝 Change Log

| Date | Change | Author |
|------|--------|--------|
| 2025-10-19 | Epic created with open questions for refinement | Sarah (PO) |

---

**STATUS:** 🔴 **BLOCKED - Awaiting user input on open questions above**

Once requirements are clarified, this epic will be promoted to **READY FOR REFINEMENT** and stories will be created.
