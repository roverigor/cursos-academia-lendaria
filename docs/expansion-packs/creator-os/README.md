# Creator-OS Documentation

**Expansion Pack:** Creator-OS v2.0.0
**Purpose:** Course generation system documentation
**Last Updated:** 2025-10-27

---

## 📁 Documentation Structure

```
expansion-packs/creator-os/docs/
├── README.md                          # This file
├── BROWNFIELD-STATUS-AND-AGENT.md     # Brownfield workflow status
├── BROWNFIELD-WORKFLOW-GUIDE.md       # How brownfield detection works
├── COURSE-GENERATION-REQUIREMENTS.md  # Technical requirements
├── DATABASE-INTEGRATION.md            # Database schema integration
├── EPIC-3-COMPLETE.md                 # Epic 3 completion report
├── MMOS-CONFIG-GUIDE.md               # MMOS integration configuration
├── MMOS-DATA-LOADING-ANALYSIS.md      # Mind loading analysis
├── MMOS-LOADING-SIMPLE.md             # Simplified MMOS loading
├── MODULARITY-ANALYSIS.md             # System modularity review
├── NAMING-DECISION.md                 # File naming conventions
├── QA-REPORT-COURSE-FRAMEWORK.md      # QA analysis of course framework
├── TECHNICAL-LESSON-DETECTION-LOGIC.md # Lesson classification algorithm
├── TECHNICAL-RESEARCH-STRATEGY.md     # Research methodology
├── WORKFLOW-PRINCIPLES.md             # Course workflow principles
├── WORKFLOW-USAGE-GUIDE.md            # How to use the workflow
│
└── course/                            # Course workflow documentation
    ├── README.md                      # Course docs guide
    ├── workflows/                     # Workflow documentation (3 files)
    ├── implementation/                # Implementation guides (1 file)
    ├── framework/                     # Framework documentation (1 file)
    ├── qa/                            # QA reports (2 files)
    ├── future/                        # Future improvements (2 files)
    └── archive/                       # Historical/verification docs (1 file)
```

---

## 📚 Key Documents

### System Overview

| Document | Purpose |
|----------|---------|
| `EPIC-3-COMPLETE.md` | Complete Epic 3 implementation summary |
| `WORKFLOW-PRINCIPLES.md` | Core workflow principles |
| `WORKFLOW-USAGE-GUIDE.md` | User guide for the workflow |
| `COURSE-GENERATION-REQUIREMENTS.md` | Technical requirements |

### Integration Guides

| Document | Purpose |
|----------|---------|
| `MMOS-CONFIG-GUIDE.md` | How to integrate MMOS minds |
| `DATABASE-INTEGRATION.md` | Database schema integration |
| `BROWNFIELD-WORKFLOW-GUIDE.md` | Brownfield detection system |

### Technical Documentation

| Document | Purpose |
|----------|---------|
| `TECHNICAL-LESSON-DETECTION-LOGIC.md` | Lesson classification algorithm |
| `TECHNICAL-RESEARCH-STRATEGY.md` | Research methodology |
| `MODULARITY-ANALYSIS.md` | System modularity review |

### Quality Assurance

| Document | Purpose |
|----------|---------|
| `QA-REPORT-COURSE-FRAMEWORK.md` | QA analysis of framework |
| `course/qa/QA-REVIEW-COURSE-WORKFLOW-V2.md` | Workflow v2 QA review |
| `course/qa/PO-WORKFLOW-EVALUATION.md` | Product owner evaluation |

---

## 📂 Course Workflow Docs (course/)

### Structure

```
course/
├── workflows/           # Workflow documentation
│   ├── course-creation-workflow.md
│   ├── COURSE-WORKFLOW-DIAGRAM.md
│   └── WORKFLOW-IMPROVEMENTS-V2.md
│
├── implementation/      # Implementation guides
│   └── COURSE-WORKFLOW-V2-IMPLEMENTATION.md
│
├── framework/           # Framework documentation
│   └── course-research-framework.md
│
├── qa/                  # Quality assurance reports
│   ├── QA-REVIEW-COURSE-WORKFLOW-V2.md
│   └── PO-WORKFLOW-EVALUATION.md
│
├── future/              # Future improvements
│   ├── WORKFLOW-IMPROVEMENT-RECOMMENDATIONS.md
│   └── MELHORIAS-FUTURAS-RESUMO.md
│
└── archive/             # Historical/verification docs
    └── OUTPUTS-MIGRATION-VERIFICATION.md
```

### Key Course Documents

| Category | Files |
|----------|-------|
| **Workflows** | Creation workflow, diagram, v2 improvements |
| **Implementation** | V2 implementation guide |
| **Framework** | Research framework |
| **QA** | QA review, PO evaluation |
| **Future** | Improvement recommendations (12 opportunities) |
| **Archive** | Migration verification, deprecated docs |

---

## 🗂️ What's NOT Here

### Execution Logs → `docs/logs/`

Test results and execution logs have been moved to root `docs/logs/`:
- `docs/logs/2025-10-27-creator-os-integration-tests.md`
- `docs/logs/2025-10-27-creator-os-v2-manual-tests.md`
- `docs/logs/2025-10-15-creator-os-sprint-1.md`

### Code & Scripts → `expansion-packs/creator-os/`

Operational files remain in pack root:
- `lib/` - Python modules
- `scripts/` - Executable entry points
- `tasks/` - Task definitions
- `agents/` - Agent definitions
- `templates/` - Content templates
- `config.yaml` - Pack configuration

---

## 🔍 Finding What You Need

**Want to...** | **See...**
---|---
Understand the system | `EPIC-3-COMPLETE.md`, `WORKFLOW-PRINCIPLES.md`
Use the workflow | `WORKFLOW-USAGE-GUIDE.md`
Integrate MMOS | `MMOS-CONFIG-GUIDE.md`
Integrate database | `DATABASE-INTEGRATION.md`
Work with brownfield | `BROWNFIELD-WORKFLOW-GUIDE.md`
See course workflow | `course/workflows/COURSE-WORKFLOW-DIAGRAM.md`
Improve the system | `course/future/WORKFLOW-IMPROVEMENT-RECOMMENDATIONS.md`
Check quality | `course/qa/QA-REVIEW-COURSE-WORKFLOW-V2.md`

---

## 📝 Maintenance

**When to update this README:**
- New top-level docs added
- Structure changes
- New categories created

**Last cleanup:** 2025-10-27
- Moved execution logs to `docs/logs/`
- Removed deprecated tasks
- Consolidated Epic 3 docs
- Organized course/ with subfolders

---

**Creator-OS Documentation v2.0.0**
**Expansion Pack:** Self-contained documentation structure
