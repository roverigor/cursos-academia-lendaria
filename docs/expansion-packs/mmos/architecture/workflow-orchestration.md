# Workflow Orchestration Architecture

**Version:** 1.0
**Created:** 2025-10-25
**Story:** E001.6-SIMPLE - Workflow Orchestrator (Simplified)

---

## Overview

The MMOS Workflow Orchestrator implements a **simple orchestration pattern** that sequences workflow phases and presents tasks to AI for autonomous execution. This architecture leverages AI's native markdown task execution capabilities (proven by AIOS/CreatorOS patterns) instead of building complex executor/runner infrastructure.

**Key Principle:** Python sequences, AI executes.

---

## Architecture Pattern

### Simple Orchestration (Not Complex Execution)

```
┌─────────────────────────────────────────────────────────────┐
│                    Workflow Orchestrator                    │
│                                                             │
│  ┌─────────────┐   ┌──────────────┐   ┌────────────────┐ │
│  │   Load      │   │   Sequence   │   │    Track       │ │
│  │  Workflow   │──→│    Phases    │──→│   Progress     │ │
│  │    YAML     │   │              │   │                │ │
│  └─────────────┘   └──────────────┘   └────────────────┘ │
│                           │                                │
│                           ▼                                │
│              ┌────────────────────────┐                    │
│              │   For Each Phase:      │                    │
│              │   1. Load task.md      │                    │
│              │   2. Print to stdout   │                    │
│              │   3. AI executes       │                    │
│              └────────────────────────┘                    │
└─────────────────────────────────────────────────────────────┘
```

**What Orchestrator Does:**
- ✅ Load workflow YAML
- ✅ Iterate through phases
- ✅ Load task markdown files
- ✅ Present tasks to AI (via print)
- ✅ Handle checkpoints
- ✅ Track progress
- ✅ Update metadata.yaml

**What Orchestrator Does NOT Do:**
- ❌ Parse task frontmatter (AI does this)
- ❌ Interpret instructions (AI does this)
- ❌ Handle elicitation (AI uses AskUserQuestion tool)
- ❌ Execute task logic (AI does this)

---

## Components

### 1. WorkflowOrchestrator Class

**Location:** `expansion-packs/mmos/lib/workflow_orchestrator.py`

**Responsibilities:**
- Load preprocessed workflow (from workflow_preprocessor)
- Sequence phases in order
- Load task markdown for each phase
- Present tasks to AI for execution
- Handle human checkpoints
- Track execution state
- Update metadata.yaml for resume capability

**Key Methods:**

```python
class WorkflowOrchestrator:
    def orchestrate_workflow(workflow: Dict, context: Dict) -> Dict:
        """
        Main orchestration function.
        Returns: {'status': str, 'phases_executed': List, 'outputs': Dict}
        """

    def _execute_task(task_name: str, phase: Dict, context: Dict):
        """
        Load task markdown and present to AI.
        AI sees printed output and executes autonomously.
        """

    def _handle_checkpoint(phase: Dict, results: Dict, context: Dict):
        """
        Present human checkpoint to user.
        Returns: {'decision': 'APPROVE'|'REJECT'|'ABORT'|'REVISE'}
        """

    def _should_skip_phase(phase: Dict, context: Dict, results: Dict):
        """
        Evaluate skip_if condition.
        Returns: bool
        """

    def _update_phase_status(slug: str, phase: str, status: str):
        """
        Update metadata.yaml with phase completion.
        Enables resume after failure/abort.
        """
```

### 2. Integration with map_mind.py

**Location:** `expansion-packs/mmos/lib/map_mind.py`

**Flow:**
```python
def _execute_workflow(...):
    # 1. Load and preprocess workflow YAML
    preprocessed = preprocess_workflow(workflow_path)
    expanded_workflow = preprocessed.get('workflow', preprocessed)

    # 2. Prepare execution context
    context = {
        'slug': slug,
        'mode': mode,
        'person_name': person_name,
        'materials_path': materials_path,
        'decision_log': decision_log
    }

    # 3. Initialize metadata manager (for state persistence)
    metadata_manager = MetadataManager(minds_dir)

    # 4. Create orchestrator and execute
    orchestrator = WorkflowOrchestrator(workflows_dir, tasks_dir, metadata_manager)
    result = orchestrator.orchestrate_workflow(expanded_workflow, context)

    # 5. Return result
    return result
```

### 3. State Persistence (MetadataManager)

**Location:** `expansion-packs/mmos/lib/metadata_manager.py`

**Purpose:** Enable resume capability after failures or user aborts.

**Mechanism:**
- Updates `outputs/minds/{slug}/metadata.yaml` after each phase
- Stores phase status, timestamps, outputs
- Allows workflow to resume from last completed phase

**Example metadata update:**
```yaml
pipeline_phases:
  phase_viability:
    status: completed
    updated_at: "2025-10-25T18:30:00Z"
    completed_at: "2025-10-25T18:30:00Z"
  phase_research:
    status: in_progress
    updated_at: "2025-10-25T18:35:00Z"
```

---

## AI Task Execution Pattern

### How AI Executes Tasks

**1. Orchestrator loads task markdown:**
```python
task_path = tasks_dir / f"{task_name}.md"
task_content = task_path.read_text()
```

**2. Orchestrator prints task to stdout:**
```
================================================================================
🤖 TASK EXECUTION: viability-assessment
================================================================================

Task File: expansion-packs/mmos/tasks/viability-assessment.md
Agent: analyst
Phase: viability

────────────────────────────────────────────────────────────────────────────────
TASK CONTENT:
────────────────────────────────────────────────────────────────────────────────

---
task-id: viability-assessment
agent: analyst
elicit: true
inputs:
  - name: mind_name
    type: string
    required: true
---

# Viability Assessment Task

## Instructions

1. Calculate APEX score...
2. If score >= 75: Auto-approve
3. If score 50-74: Elicit user decision
...

────────────────────────────────────────────────────────────────────────────────

📦 EXECUTION CONTEXT:
{
  "slug": "thiago_finch",
  "mode": "public",
  "person_name": "Thiago Finch"
}

================================================================================
⚡ EXECUTE TASK ABOVE ⚡
================================================================================
```

**3. AI reads output and executes task autonomously:**
- Reads task markdown
- Parses frontmatter YAML (extracts metadata)
- Reads instructions section
- Validates context has required inputs
- Executes instructions
- If `elicit: true`, uses AskUserQuestion tool
- Creates output files (Write tool)
- Reports completion

**4. Orchestrator continues to next phase**

---

## Workflow YAML Structure

**Example (greenfield-mind.yaml):**

```yaml
workflow:
  id: greenfield-mind
  name: Greenfield Mind Clone Creation
  modes: [public, no-public-interviews, no-public-materials]

sequence:
  # Phase with task
  - agent: analyst
    phase: viability
    task: viability-assessment
    skip_if: "mode != 'public'"
    outputs:
      - outputs/minds/{slug}/docs/viability.yaml
    human_checkpoint: true
    checkpoint_type: GO_NO-GO_DECISION

  # Phase with module import
  - import: "modules/analysis-foundation.yaml"

  # Phase with checkpoint
  - agent: implementer
    phase: implementation
    task: system-prompt-creation
    human_checkpoint: true
    checkpoint_type: REVIEW
```

**Key Directives:**
- `task:` - Task markdown to execute
- `skip_if:` - Condition to skip phase (e.g., `mode != 'public'`)
- `import:` - Import module (expanded by preprocessor)
- `human_checkpoint:` - Trigger user review/decision
- `outputs:` - Expected outputs (tracked but not enforced)

---

## Checkpoint System

**Types of Checkpoints:**
- `GO_NO-GO_DECISION` - Continue or abort
- `REVIEW` - Review outputs before continuing
- `DECISION` - Make strategic decision
- `APPROVAL` - Approve deliverable

**Checkpoint Flow:**
```python
if phase.get('human_checkpoint'):
    print("🚦 HUMAN CHECKPOINT: {type}")
    print("Progress summary...")
    print("Decision required: APPROVE | REJECT | ABORT | REVISE")

    # AI uses AskUserQuestion tool here
    decision = get_user_decision()

    if decision == 'ABORT':
        results['status'] = 'aborted'
        return results  # Stop workflow
```

**Current Implementation:** Auto-approves (returns 'APPROVE')
**Future:** Full checkpoint system with AskUserQuestion integration

---

## Error Handling

### Error Scenarios

**1. Missing Workflow File:**
```python
except FileNotFoundError:
    return {
        'status': 'failed',
        'error': 'Workflow file not found: {path}'
    }
```

**2. Missing Task File:**
```python
if not task_path.exists():
    raise FileNotFoundError(f"Task file not found: {task_path}")
```

**3. Invalid YAML:**
```python
except yaml.YAMLError as e:
    return {
        'status': 'failed',
        'error': f'Invalid YAML: {e}'
    }
```

**4. Task Execution Failure:**
```python
except Exception as e:
    print(f"❌ Task execution failed: {task_name}")
    results['status'] = 'failed'
    results['error'] = f"Task {task_name} failed: {e}"
    return results
```

**5. User Abort:**
```python
if checkpoint_result['decision'] == 'ABORT':
    results['status'] = 'aborted'
    results['aborted_at'] = datetime.now().isoformat()
    return results
```

### Graceful Degradation

**Metadata Update Failures:**
- Logged as warning
- Workflow continues (doesn't block execution)

**Skip Condition Errors:**
- Logged as warning
- Phase is NOT skipped (safe default)

---

## Comparison: Simple vs Complex

### ❌ Complex Approach (E001.6 - REJECTED)

```
Workflow Executor (400-600 lines)
    ├── Parse workflow YAML
    ├── Execute phases
    └── Handle checkpoints

Task Runner (400-600 lines)
    ├── Load task markdown
    ├── Parse frontmatter (Python YAML parser)
    ├── Extract instructions (regex/parsing)
    ├── Elicitation handler (custom UI)
    ├── Instruction interpreter (execute logic)
    └── Output generator (create files)

Total: 800-1200 lines, 24-34 hours
```

**Problems:**
- Reinvents AI's native capabilities
- Complex abstractions
- High maintenance burden
- More bugs

### ✅ Simple Approach (E001.6-SIMPLE - APPROVED)

```
Workflow Orchestrator (316 lines)
    ├── Load workflow YAML
    ├── Sequence phases
    ├── For each phase:
    │   ├── Load task.md
    │   └── Print to AI (AI executes)
    ├── Handle checkpoints
    └── Track progress

Total: 316 lines, 4-8 hours
```

**Benefits:**
- Leverages AI's native capabilities
- Simple, readable code
- Easy to maintain
- Proven patterns (AIOS/CreatorOS)

---

## Testing Strategy

### Unit Tests (test_workflow_orchestrator.py)

**Coverage:** 22 tests, ≥85% coverage

**Test Categories:**
- Initialization
- Basic orchestration
- Phase skipping (`skip_if`)
- Task execution
- Checkpoint handling
- Error scenarios
- Result tracking
- Metadata persistence

### Integration Tests (test_integration_orchestrator.py)

**Coverage:** 13 tests

**Test Categories:**
- Real task loading (viability-assessment.md, etc.)
- Workflow preprocessor integration
- Mode-specific workflows (public vs no-public)
- Checkpoint flow
- Error handling
- Metadata updates

**Key Tests:**
- Load all 21 existing task files ✅
- Preprocess greenfield + brownfield workflows ✅
- Execute minimal workflow ✅
- Skip conditions work correctly ✅

---

## Performance Characteristics

**Overhead:** < 1% (simple Python sequencing)

**Token Usage:**
- Task markdown: ~500-2000 tokens per task
- Context: ~200-500 tokens
- Total per phase: ~700-2500 tokens

**Execution Time:**
- Orchestration overhead: ~10ms per phase
- Task execution: Depends on AI (2-30 seconds per task)
- Total: Dominated by AI execution time

---

## Future Enhancements

### Planned

1. **Full Checkpoint System**
   - Integrate AskUserQuestion tool
   - Support all checkpoint types
   - Checkpoint history tracking

2. **Resume from Failure**
   - Read metadata.yaml on start
   - Skip completed phases
   - Resume from last checkpoint

3. **Parallel Phase Execution**
   - Detect independent phases
   - Execute in parallel where safe
   - Aggregate results

### Considered but Deferred

- **Workflow Validation:** Validate YAML structure before execution
- **Dry Run Mode:** Show what would execute without executing
- **Execution Replay:** Replay past executions for debugging

---

## Related Documentation

**Code:**
- `expansion-packs/mmos/lib/workflow_orchestrator.py` - Main implementation
- `expansion-packs/mmos/lib/map_mind.py` - Integration point
- `expansion-packs/mmos/lib/workflow_preprocessor.py` - Module expansion
- `expansion-packs/mmos/lib/metadata_manager.py` - State persistence

**Workflows:**
- `expansion-packs/mmos/workflows/greenfield-mind.yaml` - Greenfield workflow
- `expansion-packs/mmos/workflows/brownfield-mind.yaml` - Brownfield workflow
- `expansion-packs/mmos/workflows/modules/` - Shared workflow modules

**Tasks:**
- `expansion-packs/mmos/tasks/*.md` - 21 task markdown files

**Tests:**
- `expansion-packs/mmos/tests/test_workflow_orchestrator.py` - Unit tests
- `expansion-packs/mmos/tests/test_integration_orchestrator.py` - Integration tests

**Stories:**
- `expansion-packs/mmos/docs/stories/story-6-simple-workflow-orchestrator.md` - This implementation
- `expansion-packs/mmos/docs/stories/story-6-workflow-executor.md` - Rejected complex approach

**Analysis:**
- `docs/logs/2025-10-25-qa-root-cause-analysis.md` - Root cause analysis
- `docs/logs/2025-10-25-qa-story-analysis.md` - Overengineering analysis
- `docs/logs/2025-10-25-story-e001-6-decision.md` - Decision rationale

---

**Document Status:** Complete
**Last Updated:** 2025-10-25
**Author:** James (Dev Agent) + Quinn (QA)
