# Story 2: Workflow Consolidation (4 → 2 + Modules)

**Story ID:** MMOS-S002
**Epic:** MMOS-E001 (Workflow Auto-Detection & Consolidation)
**Created:** 2025-10-25
**Status:** 🔴 To Do
**Priority:** P0
**Effort:** 12 hours
**Assignee:** TBD

---

## 📖 User Story

**As a** MMOS developer
**I want** workflows consolidados em 2 orquestradores + 7 modules compartilhados
**So that** manutenção seja trivial e duplicação seja zero

---

## 🎯 Acceptance Criteria

###  AC1: Modules Criados
- [ ] 7 modules criados em `workflows/modules/`:
  - `analysis-foundation.yaml` (Layers 1-5)
  - `analysis-critical.yaml` (Layers 6-8 + checkpoints)
  - `synthesis-knowledge.yaml` (Frameworks, communication, signatures)
  - `synthesis-kb.yaml` (KB chunking + specialists)
  - `implementation-identity.yaml` (Identity core)
  - `implementation-prompt.yaml` (System prompt + manual)
  - `validation-complete.yaml` (Testing & fidelity)

### AC2: greenfield-mind.yaml Consolidado
- [ ] `greenfield-mind.yaml` contém:
  - Modes: `public`, `no-public-interviews`, `no-public-materials`
  - Phases 0-1 inline (únicas)
  - Phases 2-7 importam modules
  - ~200 linhas (vs ~600 antes)

### AC3: brownfield-mind.yaml Consolidado
- [ ] `brownfield-mind.yaml` contém:
  - Modes: `public-update`, `no-public-incremental`, `no-public-migration`
  - Phases 0-1 inline (únicas)
  - Phases 2-7 importam mesmos modules que greenfield
  - ~200 linhas (vs ~600 antes)

### AC4: Workflows Obsoletos Deletados
- [ ] `private-individual.yaml` deletado (merged into greenfield)
- [ ] `brownfield-private.yaml` deletado (merged into brownfield)

### AC5: Zero Duplicação Verificada
- [ ] Code analysis confirma: código compartilhado em modules
- [ ] Atualizar Layer 8 = editar 1 arquivo (`modules/analysis-critical.yaml`)
- [ ] Validação via grep: `rg "Layer 6|Layer 7|Layer 8" workflows/*.yaml` retorna 0 resultados (apenas em modules/)
- [ ] Manual: Nenhum código aparece tanto em modules/ quanto em workflows/

### AC6: Imports Funcionando
- [ ] Workflows conseguem importar modules corretamente
- [ ] YAML processor suporta `import:` directive (AIOS built-in)
- [ ] Module paths resolvem corretamente (relative to workflow file)
- [ ] Test validates imports: `test_workflow_imports_resolve()` passa (ver Test Cases section)

### AC7: README Atualizado
- [ ] `workflows/README.md` atualizado com:
  - Matriz 2×2 (public/no-public × greenfield/brownfield)
  - Sistema de modules explicado
  - Nomenclatura public vs no-public

---

## 📋 Tasks

### Task 2.0: Pesquisar YAML Import Mechanism
- [ ] Verificar se AIOS suporta `import:` directive nativamente
- [ ] Consultar `.aios-core/workflows/` para examples de imports
- [ ] Se não suportar: planejar preprocessor YAML customizado
- [ ] Documentar sintaxe exata e path resolution

**Effort:** 0.5 hours

### Task 2.1: Criar pasta modules/
- [ ] `mkdir workflows/modules`
- [ ] Adicionar README.md explicando propósito

**Effort:** 0.5 hours

### Task 2.2: Extrair analysis-foundation.yaml
- [ ] Extrair Layers 1-5 dos workflows atuais
- [ ] Criar `modules/analysis-foundation.yaml`
- [ ] Validar conteúdo idêntico entre greenfield/brownfield

**Effort:** 1.5 hours

### Task 2.3: Extrair analysis-critical.yaml
- [ ] Extrair Layers 6-8 + checkpoints humanos
- [ ] Criar `modules/analysis-critical.yaml`
- [ ] Incluir cognitive architecture synthesis

**Effort:** 1.5 hours

### Task 2.4: Extrair synthesis modules
- [ ] Criar `modules/synthesis-knowledge.yaml` (frameworks, communication, signatures)
- [ ] Criar `modules/synthesis-kb.yaml` (KB chunking + specialists)

**Effort:** 1.5 hours

### Task 2.5: Extrair implementation modules
- [ ] Criar `modules/implementation-identity.yaml` (identity core)
- [ ] Criar `modules/implementation-prompt.yaml` (system prompt + manual)

**Effort:** 1.5 hours

### Task 2.6: Extrair validation module
- [ ] Criar `modules/validation-complete.yaml` (testing, fidelity, approval)
- [ ] Incluir mode variants (public: simulated, no-public: direct validation)

**Effort:** 1.5 hours

### Task 2.7: Refatorar greenfield-mind.yaml
- [ ] Consolidar greenfield + private-individual
- [ ] Adicionar modes (public, no-public-interviews, no-public-materials)
- [ ] Manter Phases 0-1 inline
- [ ] Importar modules para Phases 2-7

**Effort:** 2 hours

### Task 2.8: Refatorar brownfield-mind.yaml
- [ ] Consolidar brownfield + brownfield-private
- [ ] Adicionar modes (public-update, no-public-incremental, no-public-migration)
- [ ] Manter Phases 0-1 inline
- [ ] Importar mesmos modules

**Effort:** 2 hours

### Task 2.9: Deletar workflows obsoletos
- [ ] `git rm private-individual.yaml`
- [ ] `git rm brownfield-private.yaml`
- [ ] Verificar nenhuma referência quebrada

**Effort:** 0.5 hours

### Task 2.10: Atualizar README.md
- [ ] Documentar matriz 2×2
- [ ] Explicar sistema de modules
- [ ] Atualizar decision tree

**Effort:** 1 hour

---

## 🔧 Implementation Details

### YAML Import Mechanism

**How Module Imports Work:**

AIOS workflows support module imports via the `import:` directive. When the workflow processor encounters an import, it expands the module's content inline at that point in the sequence.

**Syntax:**
```yaml
sequence:
  - import: "modules/module-name.yaml"
    # Module's phases are expanded here inline
```

**Path Resolution:**
- Paths are relative to the workflow file location
- `workflows/greenfield-mind.yaml` importing `modules/foo.yaml` → resolves to `workflows/modules/foo.yaml`
- Absolute paths not supported (use relative only)

**Module Format:**
Modules MUST follow this structure:
```yaml
module:
  id: module-id
  name: Module Name
  description: What this module does

phases:
  - agent: analyst
    phase: analysis
    # ... (normal workflow phase syntax)
```

**Import Expansion:**
When imported, only the `phases:` section is expanded. The `module:` metadata is used for logging but not executed.

**Reference Implementation:**
- AIOS native support: See `.aios-core/workflows/examples/workflow-with-imports.yaml`
- CreatorOS example: `expansion-packs/creator-os/workflows/greenfield-course.yaml` (uses context detection, similar pattern)

**Alternative (if AIOS doesn't support natively):**
If `import:` is not built-in, Task 2.0 will implement a YAML preprocessor:
```python
def preprocess_workflow(workflow_file):
    """Expand imports before execution"""
    workflow = yaml.load(workflow_file)

    for i, step in enumerate(workflow['sequence']):
        if 'import' in step:
            module_path = resolve_path(step['import'])
            module = yaml.load(module_path)
            workflow['sequence'][i] = module['phases']

    return workflow
```

---

### Module Structure Example

```yaml
# workflows/modules/analysis-critical.yaml

module:
  id: analysis-critical
  name: DNA Mental™ Critical Layers (6-8) + Checkpoints
  description: >-
    Layers that require human validation and define core identity.
    This is THE critical differentiation - what makes clones feel human.

phases:
  # LAYER 6: Values Hierarchy
  - agent: analyst
    phase: analysis
    creates: values-hierarchy
    task: cognitive-analysis
    task_mode: layer_6
    outputs:
      - outputs/minds/{slug}/artifacts/values_hierarchy.yaml
    triangulation: required
    human_checkpoint: true
    checkpoint_type: LAYER_6_VALIDATION
    notes: |
      Extract ranked core values:
      - What they prioritize above all
      - Demonstrated vs stated values
      - Value trade-offs and conflicts

      HUMAN CHECKPOINT: Values hierarchy is CRITICAL for authenticity.
      User must validate before proceeding.

  # LAYER 7: Core Obsessions
  - agent: analyst
    phase: analysis
    creates: core-obsessions
    task: cognitive-analysis
    task_mode: layer_7
    outputs:
      - outputs/minds/{slug}/artifacts/core_obsessions.yaml
    triangulation: required
    human_checkpoint: true
    checkpoint_type: LAYER_7_VALIDATION
    notes: |
      Identify 2-3 core obsessions:
      - Topics appearing obsessively
      - Questions driving their work
      - Problems consuming attention

  # LAYER 8: Productive Paradoxes (THE GOLD LAYER)
  - agent: analyst
    phase: analysis
    creates: productive-paradoxes
    task: cognitive-analysis
    task_mode: layer_8
    outputs:
      - outputs/minds/{slug}/artifacts/contradictions.yaml
    triangulation: required
    human_checkpoint: true
    checkpoint_type: LAYER_8_VALIDATION
    notes: |
      THE DIFFERENTIATOR - what makes clones feel authentically human.

      Identify productive contradictions:
      - Simultaneous opposing beliefs
      - Context-dependent positions
      - "Both/and" thinking patterns

      Without Layer 8, clones feel "uncanny valley."

  # SYNTHESIS: Cognitive Architecture
  - agent: architect
    phase: analysis
    creates: cognitive-architecture
    task: cognitive-analysis
    task_mode: architecture
    outputs:
      - outputs/minds/{slug}/artifacts/cognitive_architecture.yaml
      - outputs/minds/{slug}/docs/LIMITATIONS.md
    notes: |
      Synthesize all 8 layers into unified cognitive architecture.
      Document known limitations honestly.
```

### greenfield-mind.yaml (Refatorado)

```yaml
# workflows/greenfield-mind.yaml

workflow:
  id: greenfield-mind
  name: Greenfield Mind Clone Creation
  modes:
    - public: Web scraping + automated research
    - no-public-interviews: 5-session interview protocol
    - no-public-materials: Provided materials processing

  sequence:
    # === PHASE 0: INITIALIZATION (mode detection) ===
    - phase: initialization
      creates: mode-detection
      # ... (inline unique logic)

    # === PHASE 1: VIABILITY & RESEARCH (mode-specific) ===
    - phase: viability
      skip_if: "mode == 'no-public-materials'"
      execute_variant: "{mode}_viability"
      # ... (inline unique logic)

    - phase: research
      execute_variant: "{mode}_research"
      # ... (inline unique logic)

    # === PHASES 2-7: SHARED (import modules) ===
    - import: "modules/analysis-foundation.yaml"
      # Layers 1-5 (shared across all modes)

    - import: "modules/analysis-critical.yaml"
      # Layers 6-8 + checkpoints (shared across all modes)

    - import: "modules/synthesis-knowledge.yaml"
      # Frameworks, communication, signatures (shared)

    - import: "modules/synthesis-kb.yaml"
      # KB chunking + specialists (shared)

    - import: "modules/implementation-identity.yaml"
      # Identity core (shared)

    - import: "modules/implementation-prompt.yaml"
      # System prompt + manual (shared)

    - import: "modules/validation-complete.yaml"
      mode_variants:
        public: simulated_validation
        no-public-interviews: direct_person_validation
        no-public-materials: direct_person_validation
      # Testing & fidelity (mode variants for validation method)

    # === PHASE 8: FINALIZATION ===
    - phase: finalization
      creates: pipeline-summary
      # ... (inline logic)
```

---

## 🧪 Test Cases

### Test Case 1: Module Import Resolution
```python
def test_workflow_imports_resolve():
    """
    Validate that module imports work correctly.
    Ensures YAML import mechanism is functioning.
    """
    # Load workflow
    workflow = load_workflow("workflows/greenfield-mind.yaml")

    # Check that imports are present in sequence
    assert workflow is not None
    assert 'sequence' in workflow

    # Verify modules were expanded (should have > 20 phases after expansion)
    # Greenfield inline: ~10 phases
    # 7 modules × ~5 phases each = ~35 phases
    # Total: ~45 phases
    assert len(workflow['sequence']) > 40, "Modules not imported/expanded"

    # Verify specific module content present
    phase_creates = [step.get('creates') for step in workflow['sequence']]
    assert 'values-hierarchy' in phase_creates, "analysis-critical module not imported"
    assert 'frameworks' in phase_creates, "synthesis-knowledge module not imported"


def test_module_path_resolution():
    """
    Validate that module paths resolve correctly.
    """
    from pathlib import Path

    # Module should exist at expected path
    module_path = Path("workflows/modules/analysis-critical.yaml")
    assert module_path.exists(), f"Module not found: {module_path}"

    # Load module and validate structure
    module = yaml.load(module_path)
    assert 'module' in module
    assert 'phases' in module
    assert module['module']['id'] == 'analysis-critical'


def test_zero_duplication():
    """
    Validate that there is ZERO code duplication between modules and workflows.
    """
    import subprocess

    # Search for Layer 6/7/8 in workflow files (should be 0)
    result = subprocess.run(
        ['rg', 'Layer 6|Layer 7|Layer 8', 'workflows/*.yaml', '--count'],
        capture_output=True,
        text=True
    )

    # If rg returns 0, no matches found (good!)
    # If rg returns 1, matches found (bad!)
    assert result.returncode == 1, "Found Layer 6/7/8 in workflows (should only be in modules)"

    # Verify layers ARE in modules (sanity check)
    result_modules = subprocess.run(
        ['rg', 'Layer 6|Layer 7|Layer 8', 'workflows/modules/*.yaml', '--count'],
        capture_output=True,
        text=True
    )
    assert result_modules.returncode == 0, "Layers not found in modules (sanity check failed)"


def test_greenfield_brownfield_use_same_modules():
    """
    Validate that greenfield and brownfield import the SAME modules.
    This ensures zero duplication between the two workflows.
    """
    greenfield = load_workflow("workflows/greenfield-mind.yaml")
    brownfield = load_workflow("workflows/brownfield-mind.yaml")

    # Extract imports
    greenfield_imports = [
        step['import'] for step in greenfield['sequence']
        if 'import' in step
    ]
    brownfield_imports = [
        step['import'] for step in brownfield['sequence']
        if 'import' in step
    ]

    # Should import the same 7 modules
    assert len(greenfield_imports) == 7
    assert len(brownfield_imports) == 7
    assert set(greenfield_imports) == set(brownfield_imports), \
        "Greenfield and brownfield must import same modules"
```

---

## ✅ Definition of Done

Story is complete when:
- [ ] YAML import mechanism pesquisado e documentado (Task 2.0)
- [ ] 7 modules criados e populados
- [ ] greenfield-mind.yaml refatorado (~200 linhas)
- [ ] brownfield-mind.yaml refatorado (~200 linhas)
- [ ] private-individual.yaml deletado
- [ ] brownfield-private.yaml deletado
- [ ] Imports funcionando corretamente
- [ ] Code reduction verificado: 2400 → 890 linhas
- [ ] Zero duplicação confirmada via grep + manual review
- [ ] Test cases passando (4 test cases)
- [ ] README.md atualizado
- [ ] Workflows testados end-to-end (integration tests in Story 5)

---

## 📚 References

- **Epic:** `epics/epic-workflow-auto-detection.md`
- **Current Workflows:** `workflows/*.yaml` (4 arquivos atuais)
- **CreatorOS Pattern:** `expansion-packs/creator-os/workflows/` (reference)

---

**Story Owner:** MMOS Team
**Dependencies:** Story 4 (Metadata - para criar metadata.yaml)
**Blockers:** None
**Last Updated:** 2025-10-25 (Revised post-validation)
