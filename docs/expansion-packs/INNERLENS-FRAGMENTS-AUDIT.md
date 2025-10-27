# InnerLens & Fragments - Audit Log
# Unificação InnerLens v2.0

**Date:** 2025-10-27
**Purpose:** Audit all files to plan InnerLens v2.0 unified structure
**Goal:** 1 pack (InnerLens) with 2 modules (fragments + psychometrics)

---

## DECISION SUMMARY

**Architecture:** 1 Pack, 2 Modules

```
expansion-packs/innerlens/
├── README.md (updated v2.0)
├── config.yaml (merged)
│
├── fragments/                   # MODULE 1: Fragment Extraction Engine
│   ├── README.md
│   ├── agents/
│   ├── tasks/
│   ├── checklists/
│   ├── docs/
│   │   ├── taxonomy/
│   │   └── research/
│   └── scripts/ (Python)
│
├── psychometrics/               # MODULE 2: Psychometric Analysis
│   ├── README.md
│   ├── agents/
│   ├── tasks/
│   ├── checklists/
│   ├── frameworks/
│   │   ├── big_five/
│   │   ├── hexaco/ (future)
│   │   └── via/ (future)
│   └── scripts/ (Python)
│
├── workflows/                   # INTEGRATED: Cross-module workflows
│   ├── extract-analyze-save.md
│   └── full-analysis.md
│
├── testing/
├── docs/                        # TOP-LEVEL: System docs
└── scripts/                     # SHARED: Cross-module utilities
```

---

## AUDIT: InnerLens (Current)

### ✅ KEEP - Production Ready

| File | Category | Action | New Location | Notes |
|------|----------|--------|--------------|-------|
| `README.md` | Core Doc | **UPDATE** | `README.md` | Update to v2.0 architecture |
| `config.yaml` | Config | **MERGE** | `config.yaml` | Merge with Fragments config |
| `PRD.md` | Product Doc | **KEEP** | `docs/PRD.md` | Move to docs/ |
| `DESIGN_DECISIONS.md` | Architecture | **KEEP** | `docs/DESIGN_DECISIONS.md` | |

### ✅ KEEP - Agents (AIOS Compliant)

| File | Module | Action | New Location |
|------|--------|--------|--------------|
| `agents/innerlens-orchestrator.md` | Top-level | **KEEP** | `agents/innerlens-orchestrator.md` |
| `agents/fragment-extractor.md` | Fragments | **MOVE** | `fragments/agents/fragment-extractor.md` |
| `agents/psychologist.md` | Psychometrics | **MOVE** | `psychometrics/agents/psychologist.md` |
| `agents/quality-assurance.md` | Shared | **KEEP** | `agents/quality-assurance.md` |

### ✅ KEEP - Tasks (AIOS Compliant)

| File | Module | Action | New Location |
|------|--------|--------|--------------|
| `tasks/extract-fragments.md` | Fragments | **MOVE** | `fragments/tasks/extract-fragments.md` |
| `tasks/validate-mius.md` | Fragments | **MOVE** | `fragments/tasks/validate-mius.md` |
| `tasks/analyze-bigfive.md` | Psychometrics | **MOVE** | `psychometrics/tasks/analyze-bigfive.md` |
| `tasks/save-fragments-to-mmos.md` | Shared | **KEEP** | `tasks/save-fragments-to-mmos.md` |
| `tasks/detect-traits-quick.md` | Integrated | **KEEP** | `tasks/detect-traits-quick.md` |

### ✅ KEEP - Checklists (Quality Gates)

| File | Module | Action | New Location |
|------|--------|--------|--------------|
| `checklists/miu-quality.md` | Fragments | **MOVE** | `fragments/checklists/miu-quality.md` |
| `checklists/bigfive-quality.md` | Psychometrics | **MOVE** | `psychometrics/checklists/bigfive-quality.md` |

### ✅ KEEP - Workflows

| File | Type | Action | New Location |
|------|------|--------|--------------|
| `workflows/extract-analyze-save.md` | Integrated | **KEEP** | `workflows/extract-analyze-save.md` |

### ✅ KEEP - Scripts (Python)

| File | Module | Action | New Location |
|------|--------|--------|--------------|
| `scripts/extract_mius_llm.py` | Fragments | **MOVE** | `fragments/scripts/extract_mius_llm.py` |
| `scripts/run_workflow_extract_analyze_save.py` | Integrated | **KEEP** | `scripts/run_workflow.py` |
| `scripts/save_fragments_to_mmos.py` | Shared | **KEEP** | `scripts/save_fragments_to_mmos.py` |
| `scripts/save_fragments_to_supabase.py` | Shared | **KEEP** | `scripts/save_fragments_to_supabase.py` |
| `scripts/save_to_database.py` | Shared | **KEEP** | `scripts/save_to_database.py` |

### ✅ KEEP - Testing

| File | Action | New Location |
|------|--------|--------------|
| `testing/scripts/analyze_performance.py` | **KEEP** | `testing/scripts/analyze_performance.py` |
| `testing/scripts/calculate_accuracy.py` | **KEEP** | `testing/scripts/calculate_accuracy.py` |
| `testing/scripts/validate_from_yaml.py` | **KEEP** | `testing/scripts/validate_from_yaml.py` |
| `testing/TESTING-PLAN-EPIC-0.md` | **KEEP** | `testing/plans/epic-0.md` |
| `testing/MVP-TESTING-GUIDE.md` | **KEEP** | `testing/MVP-TESTING-GUIDE.md` |

### 🗄️ ARCHIVE - Useful Reference (Keep for History)

| File | Reason | Action | New Location |
|------|--------|--------|--------------|
| `docs/UNIVERSAL-FRAGMENTS-ARCHITECTURE.md` | Architecture doc | **ARCHIVE** | `docs/archive/v1/UNIVERSAL-FRAGMENTS-ARCHITECTURE.md` |
| `docs/MIU-FRAGMENT-ARCHITECTURE.md` | Architecture doc | **ARCHIVE** | `docs/archive/v1/MIU-FRAGMENT-ARCHITECTURE.md` |
| `docs/FRAGMENTS-ARCHITECTURE.md` | Architecture doc | **ARCHIVE** | `docs/archive/v1/FRAGMENTS-ARCHITECTURE.md` |
| `docs/FINAL-ARCHITECTURE.md` | Architecture doc | **ARCHIVE** | `docs/archive/v1/FINAL-ARCHITECTURE.md` |
| `docs/ARCHITECTURE-COMPARISON.md` | Architecture doc | **ARCHIVE** | `docs/archive/v1/ARCHITECTURE-COMPARISON.md` |
| `docs/DECISION-PRINCIPLES.md` | Decision log | **ARCHIVE** | `docs/archive/v1/DECISION-PRINCIPLES.md` |
| `docs/PDR.md` | Old PRD | **ARCHIVE** | `docs/archive/v1/PDR.md` |
| `docs/Conversa-Fragmentos.md` | Discussion log | **ARCHIVE** | `docs/archive/v1/Conversa-Fragmentos.md` |
| `docs/epics/EPIC-0-FOUNDATION.md` | Completed epic | **ARCHIVE** | `docs/archive/epics/EPIC-0-FOUNDATION.md` |
| `docs/epics/EPIC-1-ENHANCED-ANALYSIS.md` | Completed epic | **ARCHIVE** | `docs/archive/epics/EPIC-1-ENHANCED-ANALYSIS.md` |

### 🗄️ ARCHIVE - Old Architectures (No Longer Relevant)

| File | Reason | Action |
|------|--------|--------|
| `docs/archive/AGENT-FRAMEWORK-MAPPING.md` | Superseded | **KEEP IN ARCHIVE** |
| `docs/archive/WORKFLOW-ARCHITECTURE.md` | Superseded | **KEEP IN ARCHIVE** |
| `docs/archive/CORRECT-ARCHITECTURE.md` | Superseded | **KEEP IN ARCHIVE** |
| `docs/archive/ZERO-INFERENCE-FRAGMENTS.md` | Superseded | **KEEP IN ARCHIVE** |
| `docs/archive/README.md` | Archive index | **UPDATE** |

### ❓ REVIEW NEEDED - Unclear Purpose

| File | Action | Question |
|------|--------|----------|
| `docs/prompts/discovery-sourcers.md` | **REVIEW** | Still used? |
| `docs/prompts/as.md` | **REVIEW** | What is "as"? |
| `docs/prompts/interrogation-sop.md` | **REVIEW** | Active prompt? |
| `docs/prompts/interrogation_protocol.yaml` | **REVIEW** | Active protocol? |
| `docs/prompts/prompt1.md` ... `prompt8.md` | **REVIEW** | Generic names - what are these? |
| `README 2.md` | **DELETE** | Duplicate README? |
| `docs/archive/README 2.md` | **DELETE** | Duplicate? |

### ❌ DELETE - Duplicates / Obsolete

| File | Reason | Action |
|------|--------|--------|
| `README 2.md` | Duplicate | **DELETE** |
| `docs/archive/README 2.md` | Duplicate | **DELETE** |

---

## AUDIT: Fragments (Current)

### ✅ MIGRATE - KISS Optimizations (PRESERVE!)

| File | Type | Action | New Location |
|------|------|--------|--------------|
| `docs/research/fragment_taxonomy_mmos_v5.0_english.md` | **CRITICAL** | **MIGRATE** | `fragments/docs/taxonomy/fragment_taxonomy_v5.0.md` |
| `docs/research/fragment_segmentation_rules_mmos_v5_0.md` | **CRITICAL** | **MIGRATE** | `fragments/docs/taxonomy/segmentation_rules_v5.0.md` |
| `docs/research/source_taxonomy_mmos_v5.0_english.md` | **CRITICAL** | **MIGRATE** | `fragments/docs/taxonomy/source_taxonomy_v5.0.md` |
| `docs/research/taxonomy_application_guide_mmos_v5.0_english.md` | **CRITICAL** | **MIGRATE** | `fragments/docs/taxonomy/application_guide_v5.0.md` |

**Rationale:** Estas são as otimizações KISS que você mencionou! DEVEM ser preservadas.

### ✅ MIGRATE - Research Examples

| File | Type | Action | New Location |
|------|------|--------|--------------|
| `docs/research/exemplo de extração manual com Claude App/` | **Examples** | **MIGRATE** | `fragments/docs/research/manual_extraction_example/` |
| `docs/research/exemplo.../EXTRACTION_REPORT.md` | Report | **MIGRATE** | `fragments/docs/research/manual_extraction_example/EXTRACTION_REPORT.md` |
| `docs/research/exemplo.../mmos-fragments/` | Examples | **MIGRATE** | `fragments/docs/research/manual_extraction_example/kapil-gupta-fragments/` |
| `docs/research/exemplo.../validate_fragments.py` | Script | **MIGRATE** | `fragments/scripts/validate_fragments.py` |

### 🗄️ ARCHIVE - Old Research

| File | Reason | Action | New Location |
|------|--------|--------|--------------|
| `docs/research/old/README_MMOS_Database.md` | Old database docs | **ARCHIVE** | `docs/archive/fragments_v1/old_research/` |
| `docs/research/old/mmos_v5_database_guide.md` | Old database docs | **ARCHIVE** | `docs/archive/fragments_v1/old_research/` |
| `docs/research/mmos_v5_model_optimizer.py` | Old script | **ARCHIVE** | `docs/archive/fragments_v1/old_research/` |

### ✅ MIGRATE - Root Files

| File | Type | Action | New Location |
|------|------|--------|--------------|
| `README.md` | Doc | **MIGRATE** | `fragments/README.md` (as module README) |
| `expansion.yaml` | Config | **MERGE** | Merge into InnerLens `config.yaml` |

---

## MIGRATION PLAN

### Phase 1: Prepare InnerLens v2.0 Structure

**Create new directory structure:**
```bash
mkdir -p expansion-packs/innerlens-v2/{fragments,psychometrics,workflows}
mkdir -p expansion-packs/innerlens-v2/fragments/{agents,tasks,checklists,docs/taxonomy,docs/research,scripts}
mkdir -p expansion-packs/innerlens-v2/psychometrics/{agents,tasks,checklists,frameworks/big_five,scripts}
mkdir -p expansion-packs/innerlens-v2/{testing,docs/archive}
```

### Phase 2: Migrate Fragments KISS Optimizations (CRITICAL!)

**Priority 1: Preserve KISS work**
```bash
# Migrate taxonomy files (CRITICAL - Don't lose this!)
cp fragments/docs/research/fragment_taxonomy_mmos_v5.0_english.md \
   innerlens-v2/fragments/docs/taxonomy/fragment_taxonomy_v5.0.md

cp fragments/docs/research/fragment_segmentation_rules_mmos_v5_0.md \
   innerlens-v2/fragments/docs/taxonomy/segmentation_rules_v5.0.md

cp fragments/docs/research/source_taxonomy_mmos_v5.0_english.md \
   innerlens-v2/fragments/docs/taxonomy/source_taxonomy_v5.0.md

cp fragments/docs/research/taxonomy_application_guide_mmos_v5.0_english.md \
   innerlens-v2/fragments/docs/taxonomy/application_guide_v5.0.md
```

### Phase 3: Migrate InnerLens Core

**Agents:**
```bash
cp innerlens/agents/fragment-extractor.md innerlens-v2/fragments/agents/
cp innerlens/agents/psychologist.md innerlens-v2/psychometrics/agents/
cp innerlens/agents/quality-assurance.md innerlens-v2/agents/
cp innerlens/agents/innerlens-orchestrator.md innerlens-v2/agents/
```

**Tasks:**
```bash
cp innerlens/tasks/extract-fragments.md innerlens-v2/fragments/tasks/
cp innerlens/tasks/validate-mius.md innerlens-v2/fragments/tasks/
cp innerlens/tasks/analyze-bigfive.md innerlens-v2/psychometrics/tasks/
cp innerlens/tasks/save-fragments-to-mmos.md innerlens-v2/tasks/
cp innerlens/tasks/detect-traits-quick.md innerlens-v2/tasks/
```

**Scripts:**
```bash
cp innerlens/scripts/extract_mius_llm.py innerlens-v2/fragments/scripts/
cp innerlens/scripts/save_fragments_to_mmos.py innerlens-v2/scripts/
cp innerlens/scripts/run_workflow_extract_analyze_save.py innerlens-v2/scripts/run_workflow.py
```

### Phase 4: Archive Old Docs

```bash
# Archive old architecture docs
mkdir -p innerlens-v2/docs/archive/v1
cp innerlens/docs/UNIVERSAL-FRAGMENTS-ARCHITECTURE.md innerlens-v2/docs/archive/v1/
cp innerlens/docs/MIU-FRAGMENT-ARCHITECTURE.md innerlens-v2/docs/archive/v1/
# ... etc
```

### Phase 5: Create New Docs

**New README.md:**
```markdown
# InnerLens v2.0

**Unified psychometric analysis platform**

## Architecture

InnerLens v2.0 combines two specialized modules:

### Module 1: Fragments (MIU Extraction Engine)
- Framework-agnostic behavioral unit extraction
- KISS-optimized taxonomy (v5.0)
- Zero-inference principle
- LLM-based extraction (Claude Sonnet 4)

### Module 2: Psychometrics (Personality Analysis)
- Big Five (OCEAN) analysis
- Future: HEXACO, VIA Strengths
- Evidence-based scoring
- Multi-framework reusability

## Usage

### Full Pipeline
```bash
*workflow extract-analyze-save \\
  --mind alan_nicolas \\
  --source text.txt
```

### Module-Specific

**Fragments only:**
```bash
*extract-fragments alan_nicolas text.txt
```

**Psychometrics only:**
```bash
*analyze-bigfive alan_nicolas fragments.json
```
```

### Phase 6: Merge Configs

**Merge `expansion.yaml` from both packs:**
```yaml
name: "innerlens"
version: "2.0.0"
description: "Unified psychometric analysis with MIU extraction"

modules:
  - name: "fragments"
    description: "Framework-agnostic behavioral unit extraction"
    version: "2.0.0"

  - name: "psychometrics"
    description: "Multi-framework personality analysis"
    version: "2.0.0"
    frameworks:
      - "big_five"
      # Future: hexaco, via

agents:
  - innerlens-orchestrator
  - fragment-extractor  # fragments module
  - psychologist        # psychometrics module
  - quality-assurance   # shared

tasks:
  - extract-fragments   # fragments
  - validate-mius       # fragments
  - analyze-bigfive     # psychometrics
  - save-fragments-to-mmos  # shared
  - detect-traits-quick     # integrated

workflows:
  - extract-analyze-save  # integrated pipeline
```

### Phase 7: Rename & Replace

```bash
# Rename old packs
mv expansion-packs/innerlens expansion-packs/innerlens-v1-ARCHIVE
mv expansion-packs/fragments expansion-packs/fragments-v1-ARCHIVE

# Rename new pack
mv expansion-packs/innerlens-v2 expansion-packs/innerlens
```

### Phase 8: Update Contracts

**Update contract:** `mmos-innerlens-v1.0.0.yaml`
- Note: InnerLens v2.0 maintains same interface
- No breaking changes to MMOS integration
- Internal reorganization only

### Phase 9: Testing

```bash
# Test fragments module
cd expansion-packs/innerlens
pytest fragments/tests/

# Test psychometrics module
pytest psychometrics/tests/

# Test integrated workflow
python scripts/run_workflow.py alan_nicolas test.txt
```

---

## CRITICAL FILES TO PRESERVE

### 🔴 **TOP PRIORITY - KISS Optimizations**

These files contain the optimized taxonomy you worked hard on:

1. `fragment_taxonomy_mmos_v5.0_english.md` ⚠️ **CRITICAL**
2. `fragment_segmentation_rules_mmos_v5_0.md` ⚠️ **CRITICAL**
3. `source_taxonomy_mmos_v5.0_english.md` ⚠️ **CRITICAL**
4. `taxonomy_application_guide_mmos_v5.0_english.md` ⚠️ **CRITICAL**

**Action:** These MUST be migrated to `fragments/docs/taxonomy/`

---

## FILES TO REVIEW WITH YOU

**Before deleting, need your confirmation:**

1. `docs/prompts/prompt1.md` through `prompt8.md` - What are these?
2. `docs/prompts/interrogation-sop.md` - Still used?
3. `docs/prompts/as.md` - What is "as"?
4. `README 2.md` - Delete duplicate?

---

## BENEFITS OF UNIFICATION

### ✅ Clarity
- No confusion between Fragments vs InnerLens
- Clear module separation (extraction vs analysis)
- Single entry point: `@innerlens-orchestrator`

### ✅ Maintainability
- Single version number (v2.0.0)
- Single config.yaml
- Unified testing
- Single README

### ✅ Extensibility
- Easy to add new psychometric frameworks (HEXACO, VIA)
- Fragments module reusable across frameworks
- Clear separation of concerns

### ✅ User Experience
```bash
# Before (confusing):
@fragments *extract
@innerlens *analyze

# After (unified):
@innerlens *workflow extract-analyze-save
# or module-specific:
@innerlens *extract-fragments
@innerlens *analyze-bigfive
```

---

## NEXT STEPS

1. **Review** this audit log
2. **Confirm** files to delete (prompts/, README 2.md)
3. **Execute** migration (Phases 1-9)
4. **Test** InnerLens v2.0
5. **Update** documentation
6. **Deprecate** old packs

---

**Estimated Time:** 2-3 hours for full migration
**Risk Level:** LOW (keeping archives of everything)
**Breaking Changes:** NONE (same interface to MMOS)

---

**Ready to proceed with migration?**
