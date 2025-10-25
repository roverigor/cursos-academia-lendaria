# MMOS Practical Examples

> **Real-world scenarios showing how to use MMOS**

**Epic:** MMOS-E001  
**Last Updated:** 2025-10-25

---

## 📚 Table of Contents

1. [Example 1: Clone Daniel Kahneman (Public Figure)](#example-1-clone-daniel-kahneman-public-figure)
2. [Example 2: Clone Pedro Valério (Private - Interviews)](#example-2-clone-pedro-valério-private---interviews)
3. [Example 3: Clone José Amorim (Private - Materials)](#example-3-clone-josé-amorim-private---materials)
4. [Example 4: Update Existing Clone](#example-4-update-existing-clone-incremental-improvement)
5. [Example 5: Override Auto-Detection](#example-5-override-auto-detection-manual-control)
6. [Example 6: Resume Interrupted Clone](#example-6-resume-interrupted-clone)
7. [Example 7: Migrate from Another System](#example-7-migrate-from-another-system)

---

## Example 1: Clone Daniel Kahneman (Public Figure)

### Scenario
You want to create a cognitive clone of **Daniel Kahneman**, Nobel Prize-winning psychologist with extensive public content.

### Command
```bash
*map daniel_kahneman
```

### What Happens

**Step 1: Auto-Detection**
```
🔍 Detecting workflow for: daniel_kahneman

Checking directory: outputs/minds/daniel_kahneman/
❌ Directory not found
→ Workflow type: greenfield (new clone)

Performing quick web search for: Daniel Kahneman
🌐 Searching...
✅ Found substantial public content:
   - Wikipedia entry: Yes
   - Biography: Yes
   - Related topics: 47 found

→ Mode: public (web scraping)

📊 Detection Summary:
   Workflow: greenfield-mind.yaml
   Mode: public
   Estimated timeline: 8-12 days
   Estimated tokens: 2-3M
```

**Step 2: Execution**
```
🚀 Starting MMOS Pipeline: greenfield-mind (public mode)

Phase 0: Initialization
├─ Creating directory structure...
├─ Initializing metadata.yaml...
└─ ✅ Complete

Phase 1: Research & Viability
├─ Collecting web sources...
│  ├─ Wikipedia (EN): ✅ 15,000 words
│  ├─ Interviews: ✅ 23 transcripts
│  ├─ Books: ✅ 3 major works
│  ├─ Papers: ✅ 127 academic papers
│  └─ Videos: ✅ 18 lectures
├─ Viability assessment...
│  └─ Score: 98/100 (Excellent)
└─ ✅ Complete | 2h elapsed

Phase 2-3: DNA Mental™ Analysis
├─ Layer 1: Identity Foundation...
├─ Layer 2: Behavioral Patterns...
├─ Layer 3: Cognitive Architecture...
├─ Layer 4: Knowledge Systems...
├─ Layer 5: Communication Style...
├─ 🛑 Checkpoint: Layer 6 (Values & Worldview)
│  └─ [Human review required]
├─ 🛑 Checkpoint: Layer 7 (Contradictions)
│  └─ [Human review required]
├─ 🛑 Checkpoint: Layer 8 (Core Essence)
│  └─ [Human review required]
└─ ✅ Complete | 6 days elapsed

Phase 4: Synthesis
├─ Frameworks identification...
│  └─ Found: System 1/System 2, Prospect Theory, Anchoring, etc.
├─ Communication style extraction...
├─ Knowledge base chunking...
│  └─ Created: 238 KB chunks
└─ ✅ Complete | 1 day elapsed

Phase 5: Implementation
├─ System prompt generation (generalista)...
├─ Identity core configuration...
└─ ✅ Complete | 1 day elapsed

Phase 6: Validation
├─ Fidelity testing...
│  ├─ Personality match: 98%
│  ├─ Knowledge accuracy: 95%
│  └─ Style consistency: 95%
├─ Overall fidelity: 96%
└─ ✅ Complete | 1 day elapsed

✅ Pipeline completed successfully!
📊 Total time: 10 days, 4 hours
📊 Total tokens: 2,145,000

📂 Output: outputs/minds/daniel_kahneman/
```

### Output Structure
```
outputs/minds/daniel_kahneman/
├── metadata.yaml                        # State tracking
├── sources/                             # Original materials
│   ├── web/
│   ├── books/
│   └── interviews/
├── analysis/                            # DNA Mental™ layers
│   ├── identity-core.yaml
│   ├── behavioral-patterns.yaml
│   ├── cognitive-architecture.yaml
│   └── ...
├── synthesis/                           # Processed outputs
│   ├── frameworks.md
│   ├── communication-style.md
│   └── signature-phrases.md
├── implementation/                      # Ready-to-use
│   ├── system-prompt-generalista.md
│   └── identity-core.yaml
├── kb/                                  # Knowledge base
│   ├── chunk_001.txt
│   ├── chunk_002.txt
│   └── ...
└── system_prompts/                      # Final prompts
    ├── generalista.md
    └── debate.md
```

### Key Takeaways
- ✅ **Zero configuration** - Just the name
- ✅ **Auto-detected public mode** - Web scraping
- ✅ **10 days** - Typical timeline for public figures
- ✅ **96% fidelity** - High-quality cognitive clone

---

## Example 2: Clone Pedro Valério (Private - Interviews)

### Scenario
You want to clone **Pedro Valério**, a private individual with no substantial public presence. You'll conduct interviews.

### Command
```bash
*map pedro_valerio
```

### What Happens

**Step 1: Auto-Detection**
```
🔍 Detecting workflow for: pedro_valerio

Checking directory: outputs/minds/pedro_valerio/
❌ Directory not found
→ Workflow type: greenfield (new clone)

Performing quick web search for: Pedro Valério
🌐 Searching...
❌ No substantial public content found

🔍 No public content found.
How should we create this clone?

  1. Interviews (I'll conduct interviews)
  2. Materials (I have documents/transcripts)

Select option (1 or 2): 1

→ Mode: no-public-interviews

📊 Detection Summary:
   Workflow: greenfield-mind.yaml
   Mode: no-public-interviews
   Estimated timeline: 15-20h
   Estimated tokens: 1-2M
```

**Step 2: Execution**
```
🚀 Starting MMOS Pipeline: greenfield-mind (no-public-interviews mode)

Phase 1: Interview Protocol
┌─────────────────────────────────────────────────┐
│  MMOS Interview Guide                           │
│  Target: 8-12 sessions, 60-90 min each         │
│  Focus: DNA Mental™ Layers 1-8                 │
└─────────────────────────────────────────────────┘

📋 Interview Session 1: Identity Foundation
   Topics: Life story, formative experiences, key decisions
   Duration: 90 minutes
   Status: ⏳ Pending

   [Press Enter when session completed and transcript ready]

   ✅ Session 1 completed
   📄 Transcript uploaded: sources/interview_01_identity.md

📋 Interview Session 2: Behavioral Patterns
   [... 10 more sessions ...]

✅ All interviews completed | 12 sessions | 18h total

Phase 2-6: Analysis & Synthesis
[... same as public example, but using interview transcripts ...]

✅ Pipeline completed successfully!
📊 Total time: 19 hours
📊 Total tokens: 1,850,000
```

### Key Takeaways
- ✅ **Guided interview process** - 8-12 structured sessions
- ✅ **DNA Mental™ focused** - Questions target each layer
- ✅ **19 hours** - Typical for no-public interviews
- ✅ **High fidelity** - Direct source, personal insights

---

## Example 3: Clone José Amorim (Private - Materials)

### Scenario
You have documents, transcripts, and materials about **José Amorim** but he's not publicly known.

### Command
```bash
*map jose_amorim --materials-path=./sources/jose/
```

### What Happens

**Step 1: Override Detection**
```
🔧 Materials provided: ./sources/jose/

Validating materials path...
✅ Path exists: ./sources/jose/
✅ Found 47 files:
   - 12 PDFs
   - 23 text documents
   - 8 transcripts
   - 4 videos (transcripts)

→ Mode: no-public-materials (forced)
→ Workflow type: greenfield

📊 Detection Summary:
   Workflow: greenfield-mind.yaml
   Mode: no-public-materials
   Materials: ./sources/jose/ (47 files)
   Estimated timeline: 15-18h
   Estimated tokens: 1.5-2M
```

**Step 2: Execution**
```
🚀 Starting MMOS Pipeline: greenfield-mind (no-public-materials mode)

Phase 1: Materials Processing
├─ Copying materials to outputs/minds/jose_amorim/sources/...
├─ Processing PDFs...
│  └─ Extracted: 125,000 words
├─ Processing transcripts...
│  └─ Extracted: 78,000 words
├─ Total content: 203,000 words
└─ ✅ Complete | 2h elapsed

Phase 2-6: Analysis & Synthesis
[... same as other examples ...]

✅ Pipeline completed successfully!
📊 Total time: 17 hours
📊 Total tokens: 1,720,000
```

### Key Takeaways
- ✅ **Pre-loaded materials** - No interview needed
- ✅ **Auto-processes** - PDFs, text, transcripts
- ✅ **17 hours** - Fastest for substantial content
- ✅ **High quality** - Rich source material

---

## Example 4: Update Existing Clone (Incremental Improvement)

### Scenario
You created **Pedro Valério's** clone months ago. Now you have 3 new interview sessions to add.

### Command
```bash
*map pedro_valerio
```

### What Happens

**Step 1: Auto-Detection**
```
🔍 Detecting workflow for: pedro_valerio

Checking directory: outputs/minds/pedro_valerio/
✅ Directory exists

Checking metadata: outputs/minds/pedro_valerio/metadata.yaml
✅ Metadata found

Reading pipeline status...
✅ Pipeline status: completed (v1.0)

→ Workflow type: brownfield (update existing)

Reading source_type from metadata...
📖 Source type: no-public-interviews

→ Mode: no-public-incremental

📊 Detection Summary:
   Workflow: brownfield-mind.yaml
   Mode: no-public-incremental
   Current version: v1.0 → v1.1
   Estimated timeline: 10-12h
   Estimated tokens: 400K-500K
```

**Step 2: Execution**
```
🚀 Starting MMOS Pipeline: brownfield-mind (no-public-incremental mode)

Phase 0: Assessment & Backup
├─ Creating backup: outputs/minds/pedro_valerio_v1.0_backup/
├─ Analyzing current state...
│  ├─ Version: v1.0
│  ├─ Sources: 12 interviews
│  ├─ Fidelity: 94%
│  └─ Last updated: 2025-07-15
├─ Detecting changes...
│  └─ ✅ 3 new interview transcripts found
└─ ✅ Complete | 30min elapsed

Phase 1: Incremental Research
├─ Processing new interviews...
│  ├─ interview_13_recent_experiences.md
│  ├─ interview_14_new_frameworks.md
│  └─ interview_15_updated_values.md
├─ Total new content: 45,000 words
└─ ✅ Complete | 1h elapsed

Phase 2: Delta Analysis
├─ Comparing with v1.0...
├─ Identifying affected layers...
│  ├─ Layer 4 (Knowledge): ⚠️ Requires update
│  ├─ Layer 6 (Values): ⚠️ Minor shifts detected
│  └─ Layer 8 (Core): ✅ Stable
└─ ✅ Complete | 2h elapsed

Phase 3-7: Selective Re-execution
├─ Updating Layer 4 (Knowledge Systems)...
├─ Updating Layer 6 (Values)...
├─ Merging with existing layers...
├─ Re-generating system prompt...
└─ ✅ Complete | 8h elapsed

Phase 8: Regression Testing
├─ Fidelity comparison...
│  ├─ v1.0: 94%
│  ├─ v1.1: 96% (+2%)
│  └─ ✅ Improvement detected
├─ Contradiction check...
│  └─ ✅ No new contradictions
└─ ✅ Complete | 1h elapsed

Phase 9: Commit Decision
┌─────────────────────────────────────────────────┐
│  Update Summary                                 │
│  ─────────────────────────────────────────────  │
│  Version: v1.0 → v1.1                          │
│  Changes: 3 new interviews                     │
│  Layers updated: 4, 6                          │
│  Fidelity: 94% → 96%                          │
│  Recommendation: ✅ Commit                     │
└─────────────────────────────────────────────────┘

Commit changes? (yes/no): yes

✅ Changes committed!
✅ Version updated: v1.1
📊 Total time: 12 hours
📊 Total tokens: 450,000
```

### Key Takeaways
- ✅ **Automatic brownfield detection** - Reads metadata
- ✅ **Selective updates** - Only affected layers
- ✅ **Version tracking** - v1.0 → v1.1
- ✅ **Backup & rollback** - Safe updates

---

## Example 5: Override Auto-Detection (Manual Control)

### Scenario
Auto-detection is failing or you know the best mode.

### Commands

#### Force Public Mode
```bash
*map person_name --force-mode=public
```

#### Force No-Public Interviews
```bash
*map person_name --force-mode=no-public-interviews
```

#### Force Brownfield Update
```bash
*map person_name --force-mode=public-update
```

### What Happens
```
🔧 Force mode: public (skipping auto-detection)

→ Workflow type: greenfield
→ Mode: public

⚠️  Auto-detection skipped by user override

📊 Detection Summary:
   Workflow: greenfield-mind.yaml
   Mode: public (forced)
   [... execution continues ...]
```

### When to Use
- ❌ Auto-detection fails
- ❌ Web search returns false negative
- ❌ You know the correct mode
- ❌ Testing specific workflows

---

## Example 6: Resume Interrupted Clone

### Scenario
Your clone creation was interrupted at Phase 3.

### Command
```bash
*map person_name
```

### What Happens
```
🔍 Detecting workflow for: person_name

Checking directory: outputs/minds/person_name/
✅ Directory exists

Checking metadata: outputs/minds/person_name/metadata.yaml
✅ Metadata found

Reading pipeline status...
⚠️  Pipeline status: analysis (interrupted)

→ Workflow type: greenfield (resume)

📊 Detection Summary:
   Workflow: greenfield-mind.yaml
   Mode: public
   Resume from: Phase 3 (Layer 4)
   Estimated remaining: 5 days

🚀 Resuming MMOS Pipeline from Phase 3...

Phase 3: DNA Mental™ Layer 4
[... continues where left off ...]
```

### Key Takeaways
- ✅ **Smart resume** - Reads pipeline_status
- ✅ **No data loss** - Continues from checkpoint
- ✅ **Automatic detection** - Knows it's interrupted

---

## Example 7: Migrate from Another System

### Scenario
You have a cognitive model from another system and want to migrate to MMOS.

### Command
```bash
*map person_name --materials-path=./legacy_system_export/
```

### What Happens
```
🔧 Materials provided: ./legacy_system_export/

Validating materials path...
✅ Path exists
✅ Found legacy system export:
   - profile.json
   - personality_traits.yaml
   - knowledge_base.txt
   - conversation_logs/

→ Mode: no-public-materials (migration)

🔄 Migration Mode Detected
   Importing from legacy system...
   Mapping to DNA Mental™ framework...

[... execution continues with migration logic ...]
```

### Key Takeaways
- ✅ **Flexible input** - Accepts various formats
- ✅ **Migration support** - Maps to DNA Mental™
- ✅ **Quality improvement** - Re-analyzes with MMOS methodology

---

## 🎯 Summary of Examples

| Example | Scenario | Command | Timeline | Tokens |
|---------|----------|---------|----------|--------|
| 1 | Public figure | `*map daniel_kahneman` | 10 days | 2.1M |
| 2 | Private (interviews) | `*map pedro_valerio` | 19h | 1.85M |
| 3 | Private (materials) | `*map jose_amorim --materials-path=./sources/jose/` | 17h | 1.72M |
| 4 | Update existing | `*map pedro_valerio` | 12h | 450K |
| 5 | Force mode | `*map person --force-mode=public` | Varies | Varies |
| 6 | Resume interrupted | `*map person_name` | Remaining | Remaining |
| 7 | Migrate system | `*map person --materials-path=./legacy/` | 18h | 1.5M |

---

## 📚 Related Documentation

- **README:** `expansion-packs/mmos/README.md`
- **Auto-Detection:** `docs/mmos/workflows/auto-detection-system.md`
- **Epic E001:** `docs/epics/epic-workflow-auto-detection.md`

---

**Practical Examples v1.0**  
**Last Updated:** 2025-10-25  
**Status:** ✅ Complete
