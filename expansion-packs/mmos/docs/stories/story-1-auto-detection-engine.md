# Story 1: Auto-Detection Engine

**Story ID:** MMOS-S001
**Epic:** MMOS-E001 (Workflow Auto-Detection & Consolidation)
**Created:** 2025-10-25
**Status:** 🔴 To Do
**Priority:** P0
**Effort:** 8 hours
**Assignee:** TBD

---

## 📖 User Story

**As a** MMOS user
**I want** the system to automatically detect which workflow to execute
**So that** I only need to type `*map {nome}` without knowing internal architecture

---

## 🎯 Acceptance Criteria

### AC1: Greenfield vs Brownfield Detection
- [ ] **GIVEN** `outputs/minds/{slug}/` não existe
      **WHEN** `*map {slug}` é executado
      **THEN** sistema detecta `workflow_type = "greenfield"`

- [ ] **GIVEN** `outputs/minds/{slug}/metadata.yaml` não existe
      **WHEN** `*map {slug}` é executado
      **THEN** sistema detecta `workflow_type = "greenfield"` (continuar interrompido)

- [ ] **GIVEN** `metadata.yaml` existe **AND** `pipeline_status < "completed"`
      **WHEN** `*map {slug}` é executado
      **THEN** sistema detecta `workflow_type = "greenfield"` (continuar em progresso)

- [ ] **GIVEN** `metadata.yaml` existe **AND** `pipeline_status == "completed"`
      **WHEN** `*map {slug}` é executado
      **THEN** sistema detecta `workflow_type = "brownfield"`

### AC2: Public vs No-Public Detection (Greenfield)
- [ ] **GIVEN** workflow_type == "greenfield" **AND** quick web search encontra conteúdo
      **WHEN** auto-detection executa
      **THEN** mode = "public"

- [ ] **GIVEN** workflow_type == "greenfield" **AND** web search não encontra **AND** `sources/` tem arquivos
      **WHEN** auto-detection executa
      **THEN** mode = "no-public-materials"

- [ ] **GIVEN** workflow_type == "greenfield" **AND** web search não encontra **AND** `sources/` vazio
      **WHEN** auto-detection executa
      **THEN** sistema PERGUNTA ao usuário: "1. Interviews 2. Materials"

### AC3: Context-Aware Brownfield Detection
- [ ] **GIVEN** workflow_type == "brownfield"
      **WHEN** auto-detection lê `metadata.yaml`
      **THEN** extrai `source_type` (public | no-public-interviews | no-public-materials)

- [ ] **GIVEN** source_type == "public"
      **WHEN** brownfield mode é determinado
      **THEN** mode = "public-update"

- [ ] **GIVEN** source_type == "no-public-interviews" **OR** "no-public-materials"
      **WHEN** brownfield mode é determinado
      **THEN** mode = "no-public-incremental"

### AC4: Logging & Transparency
- [ ] **GIVEN** auto-detection executa
      **WHEN** decisões são tomadas
      **THEN** logs mostram: "Detected: greenfield + public (web content found)"

- [ ] **GIVEN** auto-detection executa
      **WHEN** ambiguidade é resolvida perguntando usuário
      **THEN** logs mostram: "No web content found. Asking user for input method."

---

## 📋 Tasks

### Task 1.1: Criar task auto-detect-workflow.md
- [ ] Criar `tasks/auto-detect-workflow.md`
- [ ] Definir inputs: `person_slug`
- [ ] Definir outputs: `workflow_type`, `mode`
- [ ] Documentar decision tree completo

**Effort:** 2 hours

### Task 1.2: Implementar detection logic (greenfield vs brownfield)
- [ ] Check if `outputs/minds/{slug}/` exists
- [ ] Check if `metadata.yaml` exists
- [ ] Read `pipeline_status` if metadata exists
- [ ] Retornar `"greenfield"` ou `"brownfield"`

**Effort:** 1 hour

### Task 1.3: Implementar quick web search
- [ ] Pesquisar solução (Google Custom Search API / Bing API / simple scraping)
- [ ] Implementar search function: `quick_search(person_name) -> bool`
- [ ] Cache resultados (evitar chamadas redundantes)
- [ ] Fallback se API falhar (perguntar usuário)

**Effort:** 2 hours

### Task 1.4: Implementar source_type detection (public vs no-public)
- [ ] If web search found content → `mode = "public"`
- [ ] If no web content BUT `sources/` has files → `mode = "no-public-materials"`
- [ ] If neither → Ask user (interviews vs materials)

**Effort:** 1 hour

### Task 1.5: Implementar brownfield context-aware
- [ ] Read `metadata.yaml` → extract `source_type`
- [ ] Map source_type to brownfield mode:
  - `public` → `public-update`
  - `no-public-*` → `no-public-incremental`

**Effort:** 1 hour

### Task 1.6: Testes unitários
- [ ] Test: greenfield detection (pasta não existe)
- [ ] Test: greenfield detection (metadata não existe)
- [ ] Test: greenfield detection (pipeline incomplete)
- [ ] Test: brownfield detection (pipeline completed)
- [ ] Test: public detection (web search success)
- [ ] Test: no-public-materials detection (sources/ exists)
- [ ] Test: no-public-interviews (user input)
- [ ] Test: brownfield context-aware (lê metadata)

**Effort:** 1 hour

---

## 🔧 Implementation Details

### Auto-Detection Algorithm

```python
def auto_detect_workflow(person_slug: str) -> tuple[str, str]:
    """
    Detecta automaticamente workflow_type e mode.

    Returns:
        (workflow_type, mode)
        workflow_type: "greenfield" | "brownfield"
        mode: "public" | "no-public-interviews" | "no-public-materials" |
              "public-update" | "no-public-incremental" | "no-public-migration"
    """
    mind_path = f"outputs/minds/{person_slug}"

    # STEP 1: Detect Greenfield vs Brownfield
    workflow_type = _detect_workflow_type(mind_path)

    # STEP 2: Detect Mode
    if workflow_type == "greenfield":
        mode = _detect_greenfield_mode(person_slug, mind_path)
    else:  # brownfield
        mode = _detect_brownfield_mode(mind_path)

    # STEP 3: Log decision
    log(f"Auto-detected: {workflow_type} + {mode}")

    return workflow_type, mode


def _detect_workflow_type(mind_path: str) -> str:
    """Greenfield vs Brownfield"""
    if not os.path.exists(mind_path):
        return "greenfield"

    metadata_path = f"{mind_path}/metadata.yaml"
    if not os.path.exists(metadata_path):
        return "greenfield"  # Interrompido anteriormente

    metadata = yaml.load(metadata_path)
    pipeline_status = metadata.get('pipeline_status', 'not_started')

    if pipeline_status == 'completed':
        return "brownfield"
    else:
        return "greenfield"  # Continuar pipeline


def _detect_greenfield_mode(person_slug: str, mind_path: str) -> str:
    """Public vs No-Public"""
    # Try web search
    has_web_content = quick_web_search(person_slug)

    if has_web_content:
        return "public"

    # Check if materials provided
    sources_path = f"{mind_path}/sources/"
    if os.path.exists(sources_path) and _has_files(sources_path):
        return "no-public-materials"

    # Ask user
    print("No public content found for {person_slug}.")
    print("How would you like to create this clone?")
    print("1. Conduct interviews (8-12 hours)")
    print("2. I have materials (transcripts, docs)")

    choice = input("Type 1 or 2: ")

    if choice == "1":
        return "no-public-interviews"
    elif choice == "2":
        return "no-public-materials"
    else:
        raise ValueError("Invalid choice")


def _detect_brownfield_mode(mind_path: str) -> str:
    """Context-aware based on existing metadata"""
    metadata_path = f"{mind_path}/metadata.yaml"
    metadata = yaml.load(metadata_path)

    source_type = metadata.get('source_type')

    if source_type == "public":
        return "public-update"
    elif source_type in ["no-public-interviews", "no-public-materials"]:
        return "no-public-incremental"
    else:
        # Edge case: migration from another system
        return "no-public-migration"


def quick_web_search(person_name: str) -> bool:
    """
    Quick web search to check if person has public content.
    Returns True if content found, False otherwise.
    """
    # Option 1: Google Custom Search API
    # Option 2: Bing Search API
    # Option 3: Simple scraping (DuckDuckGo Instant Answer API)

    # Simplified placeholder
    try:
        # API call here
        results = search_api(f"{person_name} blog podcast interview")
        return len(results) > 0
    except Exception as e:
        log(f"Web search failed: {e}. Falling back to ask user.")
        return False
```

---

## ✅ Definition of Done

Story is complete when:
- [ ] Todas as Acceptance Criteria validadas
- [ ] Todas as tasks completadas
- [ ] Auto-detection funciona em 10+ cenários de teste
- [ ] Quick web search implementado (com fallback)
- [ ] Logs transparentes implementados
- [ ] Testes unitários passando (8+ casos)
- [ ] Code review aprovado
- [ ] Documentação atualizada em README

---

## 🧪 Test Cases

### Test Case 1: Greenfield Public
```python
def test_greenfield_public():
    # Setup
    delete_folder("outputs/minds/daniel_kahneman")
    mock_web_search("daniel_kahneman", returns=True)

    # Execute
    workflow_type, mode = auto_detect_workflow("daniel_kahneman")

    # Assert
    assert workflow_type == "greenfield"
    assert mode == "public"
```

### Test Case 2: Greenfield No-Public Materials
```python
def test_greenfield_no_public_materials():
    # Setup
    create_folder("outputs/minds/pedro_valerio/sources/")
    add_files("outputs/minds/pedro_valerio/sources/", ["interview1.md"])
    mock_web_search("pedro_valerio", returns=False)

    # Execute
    workflow_type, mode = auto_detect_workflow("pedro_valerio")

    # Assert
    assert workflow_type == "greenfield"
    assert mode == "no-public-materials"
```

### Test Case 3: Brownfield Context-Aware
```python
def test_brownfield_context_aware():
    # Setup
    create_metadata("outputs/minds/joao_lozano/metadata.yaml", {
        'pipeline_status': 'completed',
        'source_type': 'no-public-interviews'
    })

    # Execute
    workflow_type, mode = auto_detect_workflow("joao_lozano")

    # Assert
    assert workflow_type == "brownfield"
    assert mode == "no-public-incremental"
```

---

## 📚 References

- **Epic:** `epics/epic-workflow-auto-detection.md`
- **CreatorOS Pattern:** `expansion-packs/creator-os/workflows/greenfield-course.yaml` (context detection example)
- **Current Detection:** None (manual selection required)

---

**Story Owner:** MMOS Team
**Dependencies:** None (foundation story)
**Blockers:** None
**Last Updated:** 2025-10-25
