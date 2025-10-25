# MMOS Pipeline v3.5 Architecture
## Hybrid: Granularity v2.0 + Intelligence v3.0

**Version:** 3.5.0
**Created:** 2025-10-20
**Status:** 🟡 DESIGN APPROVED - PENDING IMPLEMENTATION
**Architect:** Winston
**Product Owner:** Sarah

---

## 🎯 Executive Summary

MMOS Pipeline v3.5 combines the **granular precision of v2.0** (51 atomic prompts) with the **intelligent orchestration of v3.0** (task-based workflow), delivering maximum quality with optimal maintainability.

### Key Innovation

**Tasks as Orchestrators, Prompts as Executors**

```
Task v3.0 (orchestration logic)
    ↓ invokes
Prompt v2.0 (detailed instructions - 8,800 lines)
    ↓ generates
Artifact (validated output)
    ↓ validated by
Checklist (quality gate)
```

---

## 📊 Architecture Comparison

| Aspect | v2.0 Legacy | v3.0 Modern | v3.5 Hybrid |
|--------|-------------|-------------|-------------|
| **Prompts** | 51 atomic files | Embedded in tasks | 51 atomic files (reused) |
| **Tasks** | None (prompts.yaml) | 13 orchestrators | 13 orchestrators |
| **Artifacts** | 20+ YAML | 14 (10 YAML + 4 MD) | 20+ YAML (configurable) |
| **Granularity** | Maximum | Medium | Maximum |
| **Orchestration** | YAML dependencies | Task modes | Task modes + prompt refs |
| **Maintainability** | Low (51 files) | High (13 files) | High (centralized) |
| **Rastreabilidade** | High | Medium | Maximum |
| **Human Checkpoints** | Manual | Strategic | Strategic + granular |
| **Lines of Instructions** | ~8,800 | ~3,500 | ~8,800 |

**Winner:** v3.5 = Best of Both Worlds ✅

---

## 🏗️ System Architecture

### Layer 1: Orchestration (Tasks v3.0)

**Location:** `expansion-packs/mmos/tasks/`

**Tasks:**
1. `cognitive-analysis.md` - Orchestrates 12 analysis prompts
2. `synthesis-compilation.md` - Orchestrates 7 synthesis prompts
3. `system-prompt-creation.md` - Orchestrates 4 implementation prompts
4. `viability-assessment.md` - Orchestrates 5 viability prompts
5. `research-collection.md` - Orchestrates 6 research prompts
6. `mind-validation.md` - Orchestrates 6 testing prompts

**Total:** 13 tasks → 40+ prompts orchestrated

### Layer 2: Execution (Prompts v2.0)

**Location:** `expansion-packs/mmos/prompts/`

**Categories:**
- **Analysis (18 prompts):** behavioral, beliefs, cognitive architecture, contradictions, obsessions, decision, immune system, limitations, linguistic, mental models, psychometric, quotes, recognition, routine, source reading, timeline, unique algorithm, values
- **Synthesis (7 prompts):** contradictions, extract core, frameworks, KB chunker, phrases miner, specialist recommender, template extractor
- **Implementation (9 prompts):** extract core, extract patterns, generalista compiler, identity core, instructions core, meta axioms, neural flow, operational manual, specialist creator, testing protocol
- **Research (6 prompts):** ETL Q&A, priority calculator, source collector, source discovery, sources master, temporal mapper
- **Testing (6 prompts):** edge cases, final report, knowledge tester, personality validator, readme generator, test generator
- **Viability (5 prompts):** dependencies mapper, ICP match score, PRD generator, scorecard APEX, TODO initializer

**Total:** 51 prompts (~8,800 lines of expert instructions)

### Layer 3: Outputs (Artifacts)

**Location:** `outputs/minds/{mind_slug}/artifacts/`

**Structure v3.5:**
```
artifacts/
├── # ANALYSIS (12 YAML)
├── behavioral_patterns.yaml           (analysis_behavioral_patterns.md)
├── beliefs_core.yaml                  (analysis_belief_system.md)
├── cognitive_architecture.yaml        (analysis_cognitive_architecture.md)
├── contradictions.yaml                (analysis_contradictions_map.md)
├── core_obsessions.yaml               (analysis_core_obsessions.md)
├── decision_architecture.yaml         (analysis_decision_architecture.md)
├── linguistic_patterns.yaml           (analysis_linguistic_forensics.md)
├── mental_models.yaml                 (analysis_mental_models.md)
├── psychometric_profile.yaml          (analysis_psychometric_analysis.md)
├── recognition_patterns.yaml          (analysis_recognition_patterns.md)
├── unique_algorithm.yaml              (analysis_unique_algorithm.md)
├── values_hierarchy.yaml              (analysis_values_hierarchy.md)
│
├── # SYNTHESIS (7 YAML/MD)
├── communication_templates.yaml       (synthesis_template_extractor.md)
├── frameworks_synthesized.yaml        (synthesis_frameworks_identifier.md)
├── signature_phrases.yaml             (synthesis_phrases_miner.md)
├── contradictions_synthesized.yaml    (synthesis_contradictions.md)
│
├── # IMPLEMENTATION (3 YAML)
├── identity_core.yaml                 (implementation_identity_core.md)
├── meta_axioms.yaml                   (implementation_meta_axioms.md)
├── instructions_core.yaml             (implementation_instructions_core.md)
│
└── # METADATA
    ├── quotes_database.yaml           (analysis_quote_extraction.md)
    ├── life_timeline.yaml             (analysis_timeline_mapping.md)
    └── limitations.md                 (analysis_limitations_doc.md)
```

**Total Artifacts:** 22+ files (configurable based on mind complexity)

### Layer 4: Validation (Checklists)

**Location:** `expansion-packs/mmos/checklists/`

**Checklists v3.5:**
- `analysis-completeness-checklist.md` - Updated for 12 YAML artifacts
- `synthesis-quality-checklist.md` - 7 synthesis outputs
- `implementation-validation-checklist.md` - 3 implementation artifacts
- `artifact-by-artifact-validation.md` - **NEW** - Individual prompt output validation

---

## 🔄 Execution Flow

### Phase 3: Cognitive Analysis (Example)

```yaml
Task: cognitive-analysis.md
Mode: full

Execution Sequence:
  1. layer_1_behavioral:
     - Load: prompts/analysis_behavioral_patterns.md
     - Execute: Against sources/ directory
     - Validate: Against template + checklist
     - Output: artifacts/behavioral_patterns.yaml
     - Checkpoint: Auto-validation (no human required)

  2. layer_2_linguistic:
     - Load: prompts/analysis_linguistic_forensics.md
     - Execute: Against sources/
     - Validate: Template + checklist
     - Output: artifacts/linguistic_patterns.yaml
     - Checkpoint: Auto-validation

  3. layer_3_routine:
     - Load: prompts/analysis_rotine.md
     - Execute: Against sources/
     - Validate: Template + checklist
     - Output: artifacts/routine_analysis.yaml
     - Checkpoint: Auto-validation

  [... continue for all 12 analysis prompts ...]

  12. psychometric:
      - Load: prompts/analysis_psychometric_analysis.md
      - Execute: Against all previous artifacts
      - Validate: Template + checklist
      - Output: artifacts/psychometric_profile.yaml
      - Checkpoint: 🔴 HUMAN VALIDATION (critical)

Final Step:
  - Synthesize: cognitive_architecture.yaml (integrates all 12)
  - Checkpoint: 🔴 HUMAN VALIDATION
```

**Key Principle:** Each prompt execution is **atomic, validated, and traceable**.

---

## 📐 Design Patterns

### Pattern 1: Task-Prompt-Artifact Trinity

```yaml
pattern: task_prompt_artifact_trinity
description: Every artifact has explicit lineage

components:
  task:
    role: Orchestrator
    location: expansion-packs/mmos/tasks/
    responsibilities:
      - Sequence management
      - Dependency resolution
      - Human checkpoint coordination
      - Error handling

  prompt:
    role: Executor
    location: expansion-packs/mmos/prompts/
    responsibilities:
      - Detailed instructions (100-1000 lines)
      - Expert methodology
      - Output format specification
      - Quality criteria

  artifact:
    role: Output
    location: outputs/minds/{mind}/artifacts/
    responsibilities:
      - Store validated results
      - Provide lineage metadata
      - Enable downstream consumption

lineage_tracking:
  artifact_metadata:
    generated_by_task: cognitive-analysis.md
    generated_by_prompt: analysis_behavioral_patterns.md
    prompt_version: 2.0
    task_version: 3.5
    validation_checklist: layer-1-validation.md
    human_validated: false
    confidence_score: 0.95
```

### Pattern 2: Incremental Validation

```yaml
pattern: incremental_validation
description: Validate each artifact immediately after generation

workflow:
  1. Execute prompt → Generate artifact
  2. Auto-validate → Run checklist
  3. Score confidence → 0-100%
  4. If confidence < 80% → Flag for human review
  5. If critical layer (6, 7, 8) → Always human review
  6. Continue to next prompt

benefits:
  - Early error detection
  - Prevents cascading failures
  - Granular quality control
  - Clear responsibility
```

### Pattern 3: Parallel Execution Where Possible

```yaml
pattern: parallel_execution
description: Execute independent prompts in parallel

analysis_phase:
  sequential:
    - quotes_extraction (source reading)
    - timeline_mapping (source reading)

  parallel_batch_1: # After source reading
    - behavioral_patterns
    - linguistic_forensics
    - routine_analysis
    - recognition_patterns

  parallel_batch_2: # After batch 1
    - mental_models
    - values_hierarchy
    - beliefs_core

  sequential_critical:
    - core_obsessions (requires values + beliefs)
    - contradictions (requires all above)
    - cognitive_architecture (final synthesis)

estimated_speedup: 40-50% vs pure sequential
```

---

## 🎯 Quality Gates & Human Checkpoints

### Automated Validation (No Human Required)

**Layers 1-5:**
- Behavioral Patterns
- Linguistic Forensics
- Routine Analysis
- Recognition Patterns
- Mental Models

**Validation Method:**
- Template compliance check
- Triangulation score ≥ 70%
- Minimum evidence count met
- Format validation passed

### Human Validation Required 🔴

**Layer 6: Values Hierarchy**
- **Why:** Core identity - errors cascade
- **Validation:** User reviews ranked values
- **Decision:** APPROVE / REVISE / RE-ANALYZE

**Layer 7: Core Obsessions**
- **Why:** Drives all behavior
- **Validation:** User confirms obsessions are accurate
- **Decision:** APPROVE / REVISE / RE-ANALYZE

**Layer 8: Contradictions (Productive Paradoxes)**
- **Why:** Most critical for authenticity
- **Validation:** User validates paradoxes feel true
- **Decision:** APPROVE / REVISE / RE-ANALYZE

**System Prompt Review**
- **Why:** Final deliverable
- **Validation:** User tests prompt outputs
- **Decision:** APPROVE / ITERATE / MAJOR_REVISION

---

## 📦 Deliverables

### For Each Mind (Pedro Valério Example)

```
outputs/minds/pedro_valerio/
├── artifacts/                         # 22+ files
│   ├── [12 analysis YAML]
│   ├── [7 synthesis YAML/MD]
│   ├── [3 implementation YAML]
│   └── metadata files
│
├── system_prompts/
│   └── system-prompt-generalista.md  # Final deliverable
│
├── docs/
│   ├── LIMITATIONS.md
│   ├── operational_manual.md
│   └── logs/
│       ├── execution_log_v3.5.md
│       ├── validation_reports/
│       └── human_checkpoints/
│
├── metadata.yaml                      # Pipeline v3.5 record
└── sources/                           # 60+ sources
```

### Documentation & Traceability

**Execution Log:**
```yaml
execution_log:
  pipeline_version: 3.5.0
  mind_slug: pedro_valerio
  start_time: 2025-10-20T15:00:00Z

  phases:
    analysis:
      prompts_executed: 12
      artifacts_generated: 12
      human_checkpoints: 3
      duration_hours: 8

  artifacts_lineage:
    behavioral_patterns.yaml:
      task: cognitive-analysis.md
      prompt: analysis_behavioral_patterns.md
      prompt_lines: 370
      sources_analyzed: 60
      triangulation_score: 0.92
      human_validated: false
      auto_validated: true
```

---

## 🚀 Implementation Plan

### Phase 1: Update Tasks (2-3 hours)

**Files to Update:**
1. `expansion-packs/mmos/tasks/cognitive-analysis.md`
2. `expansion-packs/mmos/tasks/synthesis-compilation.md`
3. `expansion-packs/mmos/tasks/system-prompt-creation.md`

**Changes:**
- Add `prompt_source` field to each mode
- Reference prompts/{prompt_name}.md (relative path within expansion pack)
- Update output expectations (22 artifacts vs 14)

### Phase 2: Create Templates (1-2 hours)

**New Templates:**
1. `templates/analysis/layer-*.yaml` (12 templates)
2. `templates/synthesis/*.yaml` (7 templates)
3. `templates/implementation/*.yaml` (3 templates)

**Purpose:** Validation schemas for each artifact

### Phase 3: Update Checklists (1 hour)

**Files to Update:**
1. `checklists/analysis-completeness-checklist.md` ✅ DONE
2. `checklists/synthesis-quality-checklist.md` (create new)
3. `checklists/artifact-validation-matrix.md` (create new)

### Phase 4: Test Execution (6-10 hours)

**Dry Run with Pedro Valério:**
1. Execute Phase 3 (Analysis) → 12 artifacts
2. Validate quality vs Jesus Cristo baseline
3. Execute Phase 4 (Synthesis) → 7 artifacts
4. Execute Phase 5 (Implementation) → System prompt
5. Final validation

### Phase 5: Documentation (1 hour)

**Create:**
1. Execution guide for v3.5
2. Troubleshooting guide
3. Rollback procedures

---

## ✅ Success Criteria

**Pipeline v3.5 is successful when:**

- [ ] All 51 prompts v2.0 integrated into tasks v3.0
- [ ] 22+ artifacts generated for Pedro Valério
- [ ] Quality matches or exceeds Jesus Cristo (v2.0)
- [ ] Execution time ≤ v2.0 (with parallelization)
- [ ] Human checkpoints = 4 (same as v3.0)
- [ ] Traceability = 100% (prompt → artifact lineage)
- [ ] Maintainability > v2.0 (centralized tasks)
- [ ] Documentation complete and clear

---

## 📊 Metrics & KPIs

**Quality Metrics:**
- Artifact count: 22+ (vs 14 in v3.0, 20+ in v2.0)
- Prompt instruction lines: ~8,800 (same as v2.0)
- Triangulation score: ≥ 70% (same as v3.0)
- Human validation layers: 3 (same as v3.0)

**Efficiency Metrics:**
- Execution time: 10-14 hours (vs 12-16h v2.0)
- Parallel execution: 40% speedup
- Human checkpoint count: 4 (vs 6+ manual in v2.0)

**Maintainability Metrics:**
- Tasks to maintain: 13 (vs 51 prompts in v2.0)
- Central orchestration: Yes
- Versioning: Git-based
- Rollback capability: Artifact-level

---

## 🔐 Risk Mitigation

### Risk 1: Prompt-Task Integration Complexity

**Mitigation:**
- Clear interfaces defined
- Template validation
- Dry run with one layer first

### Risk 2: Quality Degradation

**Mitigation:**
- Baseline comparison with Jesus Cristo
- Incremental validation
- Human checkpoints on critical layers

### Risk 3: Execution Time Increase

**Mitigation:**
- Parallel execution where possible
- Caching of intermediate results
- Skip re-analysis of unchanged sources

---

## 📚 References

**Legacy Documentation:**
- Jesus Cristo artifacts: `outputs/minds/jesus_cristo/`
- Prompts v2.0: `expansion-packs/mmos/prompts/` (restored from git, moved to expansion pack)
- prompts.yaml: `expansion-packs/mmos/prompts/prompts.yaml`

**Modern Documentation:**
- José Amorim artifacts: `outputs/minds/jose_amorim/`
- Tasks v3.0: `expansion-packs/mmos/tasks/`
- Checklists: `expansion-packs/mmos/checklists/`

**Architecture:**
- This document: `docs/mmos/architecture/PIPELINE-V3.5-ARCHITECTURE.md`
- Mapping matrix: `docs/mmos/architecture/PROMPT-TASK-ARTIFACT-MATRIX.md` (next)

---

## 🎯 Next Steps

1. ✅ Architecture documented (this file)
2. ⏳ Create complete mapping matrix
3. ⏳ Update checklists for v3.5
4. ⏳ User review & approval
5. ⏳ Execute for Pedro Valério

---

**Status:** 🟡 AWAITING USER APPROVAL
**Next Action:** Create mapping matrix and checklists
**Estimated Time to Execute:** 12-16 hours for full pipeline

---

*Architecture v3.5 - Best of Both Worlds*
*Designed by Winston (Architect) & Sarah (PO)*
*2025-10-20*
