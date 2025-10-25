# Story 5: Testing & Documentation

**Story ID:** MMOS-S005
**Epic:** MMOS-E001 (Workflow Auto-Detection & Consolidation)
**Created:** 2025-10-25
**Status:** 🔴 To Do
**Priority:** P1
**Effort:** 6 hours
**Assignee:** TBD

---

## 📖 User Story

**As a** MMOS team member
**I want** testes completos e documentação atualizada
**So that** o sistema é confiável, manutenível e fácil de usar

---

## 🎯 Acceptance Criteria

### AC1: Testes Unitários (Auto-Detection)
- [ ] **GIVEN** auto-detection engine
      **WHEN** testes unitários executam
      **THEN** 10+ cenários cobertos:
  - Greenfield detection (pasta não existe)
  - Greenfield detection (metadata não existe)
  - Greenfield detection (pipeline incompleto)
  - Brownfield detection (pipeline completo)
  - Public detection (web search success)
  - No-public-materials detection
  - No-public-interviews (user input)
  - Brownfield context-aware
  - Edge cases (ambiguidade)
  - Error scenarios

### AC2: Testes Integração (End-to-End)
- [ ] **GIVEN** comando `*map`
      **WHEN** testes E2E executam
      **THEN** 5+ cenários funcionam end-to-end:
  - Cenário 1: Public figure greenfield completo
  - Cenário 2: No-public interviews greenfield completo
  - Cenário 3: No-public materials greenfield completo
  - Cenário 4: Brownfield update (public)
  - Cenário 5: Brownfield update (no-public)

### AC3: Testes Regressão (Brownfield)
- [ ] **GIVEN** clones existentes (pre-refactoring)
      **WHEN** novos workflows executam
      **THEN** não quebra clones existentes:
  - Metadata existente ainda funciona
  - Brownfield update não corrompe dados
  - Backward compatibility garantida

### AC4: README.md Atualizado
- [ ] **GIVEN** workflows refatorados
      **WHEN** README é lido
      **THEN** contém:
  - Matriz 2×2 documentada (public/no-public × greenfield/brownfield)
  - Sistema de modules explicado com exemplos
  - Comando `*map` usage e examples
  - Decision tree para usuários
  - Troubleshooting common issues

### AC5: Lógica Auto-Detection Documentada
- [ ] **GIVEN** sistema de detecção
      **WHEN** docs são consultadas
      **THEN** lógica transparente explicada:
  - Flowchart de detecção
  - Exemplos de cada path
  - Como sistema toma decisões

### AC6: Examples Práticos
- [ ] **GIVEN** novos usuários
      **WHEN** consultam documentação
      **THEN** encontram 5+ examples reais:
  - Example: Clonar Daniel Kahneman (public)
  - Example: Clonar Pedro Valério (no-public interviews)
  - Example: Atualizar clone existente
  - Example: Migrar de outro sistema
  - Example: Override manual de mode

---

## 📋 Tasks

### Task 5.1: Escrever testes unitários (auto-detection)
- [ ] Criar `tests/test_auto_detection.py` ou similar
- [ ] 10+ test cases cobrindo todos os paths
- [ ] Mock web search API
- [ ] Mock filesystem operations
- [ ] Validar todos os retornos esperados

**Effort:** 2 hours

### Task 5.2: Escrever testes integração (*map E2E)
- [ ] Criar `tests/test_map_command_e2e.py`
- [ ] 5+ cenários end-to-end
- [ ] Setup/teardown de clones de teste
- [ ] Validar outputs completos

**Effort:** 2 hours

### Task 5.3: Testes regressão brownfield
- [ ] Validar clones existentes ainda funcionam
- [ ] Testar backward compatibility metadata.yaml
- [ ] Verificar brownfield update não corrompe

**Effort:** 0.5 hours

### Task 5.4: Atualizar workflows/README.md
- [ ] Documentar matriz 2×2
- [ ] Explicar sistema de modules
- [ ] Adicionar usage de `*map`
- [ ] Criar decision tree visual
- [ ] Troubleshooting section

**Effort:** 1 hour

### Task 5.5: Documentar auto-detection logic
- [ ] Criar flowchart de detecção
- [ ] Explicar cada decision point
- [ ] Examples de cada path

**Effort:** 0.5 hours

### Task 5.6: Criar examples práticos
- [ ] 5+ examples reais documentados
- [ ] Step-by-step screenshots/logs
- [ ] Casos de uso comuns

**Effort:** 0.5 hours

---

## 🔧 Test Structure

### Test Suite 1: Auto-Detection Unit Tests

```python
# tests/test_auto_detection.py

import pytest
from tasks.auto_detect_workflow import auto_detect_workflow

def test_greenfield_no_folder():
    """Test: Pasta não existe → greenfield"""
    slug = "test_nonexistent"
    cleanup(slug)

    workflow_type, mode = auto_detect_workflow(slug)

    assert workflow_type == "greenfield"
    # mode depends on web search (mocked)


def test_greenfield_no_metadata():
    """Test: Pasta existe, mas sem metadata → greenfield"""
    slug = "test_no_metadata"
    create_folder(f"outputs/minds/{slug}")

    workflow_type, mode = auto_detect_workflow(slug)

    assert workflow_type == "greenfield"


def test_greenfield_incomplete_pipeline():
    """Test: Metadata existe, pipeline incompleto → greenfield"""
    slug = "test_incomplete"
    create_metadata(slug, pipeline_status="research")

    workflow_type, mode = auto_detect_workflow(slug)

    assert workflow_type == "greenfield"


def test_brownfield_completed():
    """Test: Metadata existe, pipeline completo → brownfield"""
    slug = "test_completed"
    create_metadata(slug, pipeline_status="completed")

    workflow_type, mode = auto_detect_workflow(slug)

    assert workflow_type == "brownfield"


def test_public_detection():
    """Test: Web search encontra conteúdo → public"""
    slug = "daniel_kahneman"
    mock_web_search(slug, found=True)

    workflow_type, mode = auto_detect_workflow(slug)

    assert mode == "public"


def test_no_public_materials():
    """Test: Sem web content, mas sources/ existe → no-public-materials"""
    slug = "test_materials"
    create_folder(f"outputs/minds/{slug}/sources/")
    add_file(f"outputs/minds/{slug}/sources/interview.md")
    mock_web_search(slug, found=False)

    workflow_type, mode = auto_detect_workflow(slug)

    assert mode == "no-public-materials"


def test_brownfield_context_aware():
    """Test: Brownfield lê source_type do metadata"""
    slug = "test_context"
    create_metadata(slug,
                   pipeline_status="completed",
                   source_type="no-public-interviews")

    workflow_type, mode = auto_detect_workflow(slug)

    assert workflow_type == "brownfield"
    assert mode == "no-public-incremental"


# ... 3+ more edge case tests
```

### Test Suite 2: Integration Tests (E2E)

```python
# tests/test_map_command_e2e.py

import pytest
from tasks.map_mind import map_mind

def test_e2e_public_figure_greenfield():
    """
    E2E Test: Public figure greenfield completo
    """
    slug = "test_public_e2e"
    cleanup(slug)
    mock_web_search("test_public_e2e", found=True)

    # Execute
    result = map_mind("test_public_e2e")

    # Validate
    assert result.status == "completed"
    assert os.path.exists(f"outputs/minds/{slug}/metadata.yaml")
    assert os.path.exists(f"outputs/minds/{slug}/system_prompts/")
    assert os.path.exists(f"outputs/minds/{slug}/artifacts/cognitive_architecture.yaml")

    # Validate metadata
    metadata = read_metadata(slug)
    assert metadata['mind']['source_type'] == "public"
    assert metadata['mind']['pipeline_status'] == "completed"


def test_e2e_no_public_interviews():
    """
    E2E Test: No-public interviews greenfield
    """
    slug = "test_interviews_e2e"
    cleanup(slug)
    mock_web_search(slug, found=False)
    mock_user_input("1")  # Choose interviews

    # Execute
    result = map_mind(slug)

    # Validate
    assert result.mode == "no-public-interviews"
    metadata = read_metadata(slug)
    assert metadata['mind']['source_type'] == "no-public-interviews"


def test_e2e_brownfield_update():
    """
    E2E Test: Brownfield update de clone existente
    """
    slug = "test_update_e2e"

    # Setup: Create existing clone
    create_complete_clone(slug, source_type="public")

    # Execute update
    result = map_mind(slug)

    # Validate
    assert result.workflow == "brownfield-mind"
    assert result.mode == "public-update"

    # Check history appended
    metadata = read_metadata(slug)
    assert len(metadata['workflow_history']) == 2  # Initial + update
```

### Test Suite 3: Regression Tests

```python
# tests/test_brownfield_regression.py

def test_existing_clone_still_works():
    """
    Regression: Clones criados antes da refatoração ainda funcionam
    """
    # Setup: Clone antigo (sem metadata.yaml novo schema)
    create_legacy_clone("test_legacy")

    # Execute
    result = map_mind("test_legacy")

    # Should not fail, should migrate gracefully
    assert result.status in ["completed", "migrated"]


def test_metadata_backward_compatible():
    """
    Regression: metadata.yaml antigo ainda é lido corretamente
    """
    slug = "test_old_metadata"
    create_old_format_metadata(slug)

    # Should read and upgrade gracefully
    metadata = read_metadata(slug)
    assert metadata is not None
```

---

## 📚 README.md Updates

### Section: MMOS Workflow Matrix (2×2)

```markdown
## 📊 MMOS Workflow Matrix

MMOS supports **4 workflow combinations** via 2 workflows + auto-detection:

```
┌─────────────┬─────────────────────┬────────────────────────┐
│             │   GREENFIELD        │   BROWNFIELD           │
├─────────────┼─────────────────────┼────────────────────────┤
│ PUBLIC      │  Auto-detected      │  Auto-detected         │
│ (Web)       │  `*map {name}`      │  `*map {name}`         │
│             │  8-12 days          │  2-5 days              │
├─────────────┼─────────────────────┼────────────────────────┤
│ NO-PUBLIC   │  Auto-detected      │  Auto-detected         │
│ (No Web)    │  User guided        │  Context-aware         │
│             │  15-20h             │  10-19h                │
└─────────────┴─────────────────────┴────────────────────────┘
```

**You just type:** `*map {name}` - System handles the rest!
```

### Section: Command Usage

```markdown
## 🚀 Quick Start

### Create New Clone
```bash
*map daniel_kahneman          # Auto-detects: public (web scraping)
*map pedro_valerio            # Auto-detects: no-public (asks: interviews/materials)
```

### Update Existing Clone
```bash
*map pedro_valerio            # Auto-detects: brownfield (reads metadata)
```

### Advanced (Override)
```bash
*map {name} --force-mode=public
*map {name} --materials-path=./sources/
```

System automatically detects and executes the right workflow!
```

---

## ✅ Definition of Done

Story is complete when:
- [ ] 10+ testes unitários (auto-detection) passando
- [ ] 5+ testes integração (E2E) passando
- [ ] Testes regressão (brownfield) passando
- [ ] README.md completamente atualizado
- [ ] Matriz 2×2 documentada
- [ ] Auto-detection logic explicada
- [ ] 5+ examples práticos documentados
- [ ] Flowchart de detecção criado
- [ ] Troubleshooting section completa
- [ ] Code coverage ≥ 80%

---

## 📚 References

- **Epic:** `epics/epic-workflow-auto-detection.md`
- **All Stories:** Dependencies for testing
- **Current README:** `workflows/README.md` (to be updated)

---

**Story Owner:** MMOS Team
**Dependencies:** All other stories (testing é final)
**Blockers:** None
**Last Updated:** 2025-10-25
