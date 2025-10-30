# Technical Design: Story 1.3 - Brownfield Incremental Assistant

**Author:** @architect Winston (AIOS)
**Date:** 2025-10-06
**Status:** Approved
**Related Story:** [Story 1.3](../docs/stories/story-1.3-brownfield-assistant.md)

---

## Overview

The Brownfield Incremental Assistant automates the detection, planning, and execution tracking of incremental updates to existing minds. It eliminates manual diffing, reduces errors in workflow execution, and provides structured rollback capabilities.

**Core Philosophy**: Preserve what works. Improve incrementally. Test obsessively. Document everything.

---

## Architecture

### System Components

```
brownfield/
├── __init__.py
├── diff_detector.py          # AC1: Source diff detection
├── plan_generator.py          # AC2: Incremental plan generation
├── workflow_executor.py       # AC3: BROWNFIELD_WORKFLOW execution
├── regression_tester.py       # AC4: Regression test orchestration
├── rollback_manager.py        # AC5: Rollback guidance & execution
├── cli.py                     # CLI interface (Click)
└── requirements.txt           # Dependencies (shared with launcher/board)
```

### Data Flow

```
1. DETECT
   sources/ directory → DiffDetector → brownfield-diff.yaml

2. PLAN
   brownfield-diff.yaml → PlanGenerator → brownfield-plan.yaml

3. EXECUTE
   brownfield-plan.yaml → WorkflowExecutor → brownfield-execution.yaml
                                          ↓
                                   launcher (for prompts)
                                          ↓
                                   launcher-history.yaml

4. TEST
   brownfield-execution.yaml → RegressionTester → regression-test.yaml

5. ROLLBACK (if needed)
   regression-test.yaml → RollbackManager → brownfield-rollback.yaml
```

---

## Component Specifications

### 1. DiffDetector (`diff_detector.py`)

**Purpose**: Detect differences between sources/ directory and sources_master.yaml

**Key Classes**:

```python
@dataclass
class SourceDiff:
    path: str
    type: str  # 'new' | 'modified' | 'missing'
    details: Dict[str, Any]
    priority: str  # 'high' | 'medium' | 'low'

class DiffDetector:
    def __init__(self, mind_dir: Path):
        self.mind_dir = mind_dir
        self.sources_dir = mind_dir / "sources"
        self.master_file = self.sources_dir / "sources_master.yaml"

    def detect(self) -> Dict[str, List[SourceDiff]]:
        """
        Scan sources/ and compare with sources_master.yaml

        Returns:
            {
                'new_sources': [...],
                'modified_sources': [...],
                'missing_sources': [...]
            }
        """

    def _scan_directory(self) -> Dict[str, SourceInfo]:
        """Recursively scan sources/ directory"""

    def _load_master_yaml(self) -> Dict[str, SourceInfo]:
        """Load and parse sources_master.yaml"""

    def _compare(self, disk_sources, master_sources) -> Dict[str, List[SourceDiff]]:
        """Compare disk vs master, identify new/modified/missing"""

    def save_report(self, diff_result: Dict, output_path: Path):
        """Save diff report to YAML"""
```

**Algorithm**:

1. Scan `sources/` recursively, collecting all files
2. For each file, compute metadata: path, type (book/interview/article), size, hash
3. Load `sources_master.yaml` and parse entries
4. Compare:
   - **New**: File on disk but not in master
   - **Modified**: File in both but size/hash differs
   - **Missing**: Entry in master but file not on disk
5. Assign priority based on type and recency
6. Save to `docs/logs/YYYYMMDD-HHMM-brownfield-diff.yaml`

**Performance**: <30s for 100 sources (using file stats, not full content hash)

---

### 2. PlanGenerator (`plan_generator.py`)

**Purpose**: Generate incremental execution plan based on diff report

**Key Classes**:

```python
@dataclass
class PromptTask:
    prompt_id: str
    phase: str
    agent: str
    target: Optional[str]  # specific source if applicable
    reason: str
    depends_on: List[str]
    parallelizable: bool
    estimated_duration_ms: int

@dataclass
class BrownfieldPlan:
    mind: str
    diff_source: str
    update_scope: Dict
    areas_affected: Dict[str, bool]
    prompts_to_rerun: List[PromptTask]
    backup_required: bool
    regression_tests_required: bool
    pre_execution_checklist: List[str]

class PlanGenerator:
    def __init__(self, prompts_db: Path):
        self.prompts = self._load_prompts_yaml(prompts_db)
        self.workflow_steps = self._load_brownfield_workflow()

    def generate(self, diff_report: Dict) -> BrownfieldPlan:
        """
        Generate execution plan from diff report

        Logic:
        - New sources → analysis prompts (targeted)
        - Modified sources → re-analyze affected artifacts
        - Impact synthesis (new KB chunks, template updates)
        """

    def _map_source_to_prompts(self, source_diff: SourceDiff) -> List[PromptTask]:
        """Map a source change to relevant prompts"""

    def _resolve_dependencies(self, tasks: List[PromptTask]) -> List[PromptTask]:
        """Order tasks respecting dependencies"""

    def _estimate_time(self, tasks: List[PromptTask]) -> str:
        """Estimate total execution time"""

    def _assess_risk(self, tasks: List[PromptTask], scope: str) -> str:
        """Assess risk level (low/medium/high)"""

    def save_plan(self, plan: BrownfieldPlan, output_path: Path):
        """Save plan to YAML"""
```

**Mapping Rules** (source → prompts):

```python
SOURCE_TO_PROMPTS = {
    'new_source': [
        'analysis_source_reading',
        'analysis_quote_extraction',
        'analysis_behavioral_patterns',  # targeted to new source only
        'synthesis_kb_chunker'
    ],
    'modified_source': [
        'analysis_source_reading',  # re-read
        # then re-analyze only artifacts derived from this source
    ]
}
```

**Dependency Resolution**:

```python
DEPENDENCIES = {
    'analysis_quote_extraction': ['analysis_source_reading'],
    'analysis_behavioral_patterns': ['analysis_source_reading'],
    'synthesis_kb_chunker': ['analysis_*'],  # after all analysis
}
```

**Performance**: <1min for any scope (reads prompts.yaml once, cached)

---

### 3. WorkflowExecutor (`workflow_executor.py`)

**Purpose**: Execute BROWNFIELD_WORKFLOW.md steps with tracking

**Key Classes**:

```python
@dataclass
class ExecutionStep:
    step: str
    timestamp: str
    details: Optional[Dict]
    status: str  # 'completed' | 'failed' | 'skipped'

class WorkflowExecutor:
    def __init__(self, mind_dir: Path, plan: BrownfieldPlan):
        self.mind_dir = mind_dir
        self.plan = plan
        self.execution_id = self._generate_execution_id()
        self.execution_log = []

    def execute(self):
        """
        Execute brownfield workflow:
        1. Validate prerequisites
        2. Execute each prompt task (via launcher)
        3. Track progress with checkpoints
        4. Support resume if interrupted
        """

    def _validate_prerequisites(self):
        """Check backup exists, docs read, etc."""

    def _execute_prompt_task(self, task: PromptTask):
        """
        Execute a single prompt task using launcher

        Integration:
        python3 -m docs.mmos.launcher.cli \
            --mind {mind} \
            --phase {phase} \
            --prompt {prompt_id} \
            [--target {source_file}]
        """

    def _track_progress(self, step: ExecutionStep):
        """Append step to execution log"""

    def _checkpoint(self):
        """Save current state for resume capability"""

    def save_execution_log(self, output_path: Path):
        """Save execution log to YAML"""
```

**Launcher Integration**:

```python
def _execute_prompt_task(self, task: PromptTask):
    cmd = [
        'python3', '-m', 'docs.mmos.launcher.cli',
        '--mind', self.plan.mind,
        '--phase', task.phase,
        '--prompt', task.prompt_id
    ]

    if task.target:
        cmd.extend(['--target', task.target])

    result = subprocess.run(cmd, capture_output=True, text=True)

    # Record step
    step = ExecutionStep(
        step='prompt_executed',
        timestamp=datetime.now().isoformat(),
        details={
            'prompt_id': task.prompt_id,
            'agent': task.agent,
            'launcher_log_ref': f'launcher-history.yaml:line_{self._get_last_launcher_entry()}'
        },
        status='completed' if result.returncode == 0 else 'failed'
    )

    self._track_progress(step)
```

**Resume Capability**:

```python
def resume(self, execution_log_path: Path):
    """Resume from interrupted execution"""
    self.execution_log = self._load_execution_log(execution_log_path)
    completed_prompts = {s.details['prompt_id'] for s in self.execution_log if s.step == 'prompt_executed'}
    remaining_tasks = [t for t in self.plan.prompts_to_rerun if t.prompt_id not in completed_prompts]

    for task in remaining_tasks:
        self._execute_prompt_task(task)
```

**Performance**: <100ms overhead per prompt (logging only)

---

### 4. RegressionTester (`regression_tester.py`)

**Purpose**: Orchestrate regression tests and compare before/after

**Key Classes**:

```python
@dataclass
class RegressionTest:
    test_id: str
    category: str  # 'personality' | 'knowledge' | 'new_content' | 'edge_case'
    prompt: str
    baseline_response: str
    updated_response: str
    status: str  # 'pass' | 'warning' | 'critical'
    similarity_score: float
    notes: str

class RegressionTester:
    def __init__(self, mind_dir: Path, execution_id: str):
        self.mind_dir = mind_dir
        self.execution_id = execution_id
        self.baseline_version = self._get_baseline_version()
        self.updated_version = self._get_current_version()

    def run_tests(self) -> List[RegressionTest]:
        """
        Run regression test suite:
        1. Personality consistency tests
        2. Knowledge retention tests
        3. New content tests
        4. Edge case tests
        """

    def _run_personality_test(self, prompt: str) -> RegressionTest:
        """Test personality consistency"""

    def _run_knowledge_test(self, prompt: str) -> RegressionTest:
        """Test knowledge retention"""

    def _run_new_content_test(self, prompt: str) -> RegressionTest:
        """Test new content integration"""

    def _compare_responses(self, baseline: str, updated: str) -> float:
        """
        Compute similarity score using:
        - Semantic similarity (embeddings)
        - Tone/style similarity
        - Factual consistency

        Returns: 0.0-1.0 (1.0 = identical)
        """

    def _determine_status(self, similarity: float, category: str) -> str:
        """
        Thresholds:
        - personality: >0.90 = pass, 0.80-0.90 = warning, <0.80 = critical
        - knowledge: >0.95 = pass, 0.90-0.95 = warning, <0.90 = critical
        - new_content: any = pass (expected to change)
        """

    def save_results(self, tests: List[RegressionTest], output_path: Path):
        """Save regression test results to YAML"""
```

**Test Suite Definition**:

```python
DEFAULT_TEST_SUITE = {
    'personality': [
        "What's your view on randomness in markets?",
        "How do you approach decision-making under uncertainty?",
        "What's your communication style?"
    ],
    'knowledge': [
        "What's the ludic fallacy?",
        "Explain antifragility in one sentence.",
        "What are your core mental models?"
    ],
    'new_content': [
        # Generated based on new sources
        "What did you say in the [new source title]?"
    ],
    'edge_case': [
        # Loaded from LIMITATIONS.md or previous test logs
    ]
}
```

**Similarity Computation**:

```python
def _compare_responses(self, baseline: str, updated: str) -> float:
    # Simple approach (v1): Use difflib
    import difflib
    similarity = difflib.SequenceMatcher(None, baseline, updated).ratio()

    # Advanced approach (future): Use embeddings
    # baseline_emb = get_embedding(baseline)
    # updated_emb = get_embedding(updated)
    # similarity = cosine_similarity(baseline_emb, updated_emb)

    return similarity
```

**Performance**: <5min for 12 tests (depends on LLM response time)

---

### 5. RollbackManager (`rollback_manager.py`)

**Purpose**: Provide rollback guidance and execution

**Key Classes**:

```python
@dataclass
class RollbackStep:
    action: str
    command: str
    status: str  # 'pending' | 'completed' | 'failed'

class RollbackManager:
    def __init__(self, execution_log_path: Path):
        self.execution_log = self._load_execution_log(execution_log_path)
        self.backup_location = self._extract_backup_location()

    def generate_rollback_plan(self, reason: str) -> List[RollbackStep]:
        """
        Generate rollback steps based on execution log

        Steps:
        1. Restore sources/
        2. Restore artifacts/
        3. Restore kb/
        4. Restore docs/ (except preserve logs)
        5. Restore system_prompts/ (if updated)
        """

    def execute_rollback(self, plan: List[RollbackStep], dry_run: bool = False):
        """
        Execute rollback with confirmation

        If dry_run=True: Only show commands, don't execute
        """

    def _preserve_logs(self):
        """Ensure brownfield logs are not deleted during rollback"""

    def save_rollback_log(self, reason: str, plan: List[RollbackStep], output_path: Path):
        """Save rollback log to YAML"""
```

**Rollback Algorithm**:

```python
def generate_rollback_plan(self, reason: str) -> List[RollbackStep]:
    steps = []

    # Determine what was modified
    modified_areas = self._get_modified_areas_from_log()

    if 'sources' in modified_areas:
        steps.append(RollbackStep(
            action='restore_sources',
            command=f'cp -r {self.backup_location}/sources {self.mind_dir}/',
            status='pending'
        ))

    if 'artifacts' in modified_areas:
        steps.append(RollbackStep(
            action='restore_artifacts',
            command=f'cp -r {self.backup_location}/artifacts {self.mind_dir}/',
            status='pending'
        ))

    # ... similar for kb, system_prompts

    return steps
```

**Safety Measures**:

1. **Dry-run mode**: Show commands without executing
2. **Confirmation prompts**: Require user confirmation before each step
3. **Log preservation**: Never delete brownfield logs (keep for post-mortem)
4. **Backup verification**: Validate backup exists and is complete before rollback

**Performance**: <2min for full restore (depends on mind size)

---

### 6. CLI (`cli.py`)

**Purpose**: Command-line interface for all brownfield operations

**Commands**:

```python
import click

@click.group()
def brownfield():
    """Brownfield Incremental Assistant"""
    pass

@brownfield.command()
@click.option('--mind', required=True)
@click.option('--output', default=None)
def detect(mind: str, output: str):
    """Detect source differences (AC1)"""

@brownfield.command()
@click.option('--mind', required=True)
@click.option('--diff-file', default=None)
@click.option('--output', default=None)
def plan(mind: str, diff_file: str, output: str):
    """Generate incremental plan (AC2)"""

@brownfield.command()
@click.option('--mind', required=True)
@click.option('--plan', required=True)
@click.option('--resume', is_flag=True)
def execute(mind: str, plan: str, resume: bool):
    """Execute brownfield workflow (AC3)"""

@brownfield.command()
@click.option('--mind', required=True)
@click.option('--execution', default=None)
def test(mind: str, execution: str):
    """Run regression tests (AC4)"""

@brownfield.command()
@click.option('--mind', required=True)
@click.option('--execution', required=True)
@click.option('--reason', default='')
@click.option('--dry-run', is_flag=True)
def rollback(mind: str, execution: str, reason: str, dry_run: bool):
    """Rollback to backup (AC5)"""

@brownfield.command()
@click.option('--mind', required=True)
def status(mind: str):
    """Show current brownfield status"""

@brownfield.command()
@click.option('--mind', required=True)
@click.option('--execution', required=True)
def complete(mind: str, execution: str):
    """Mark brownfield update as complete, archive backup"""
```

**Usage Examples**:

```bash
# Detect changes
python3 -m docs.mmos.brownfield.cli detect --mind nassim_taleb

# Generate plan
python3 -m docs.mmos.brownfield.cli plan --mind nassim_taleb

# Execute plan
python3 -m docs.mmos.brownfield.cli execute --mind nassim_taleb --plan <path>

# Run tests
python3 -m docs.mmos.brownfield.cli test --mind nassim_taleb

# Rollback (dry-run)
python3 -m docs.mmos.brownfield.cli rollback --mind nassim_taleb --execution <id> --dry-run

# Complete update
python3 -m docs.mmos.brownfield.cli complete --mind nassim_taleb --execution <id>
```

---

## Data Schemas

### brownfield-diff.yaml

```yaml
schema_version: '1.0'
scan_timestamp: '2025-10-06T01:00:00'
mind: nassim_taleb

new_sources:
  - path: sources/interviews/Naval_Podcast_2023.md
    type: interview
    size: 45892
    hash: sha256:abc123...
    priority: high

modified_sources:
  - path: sources/books/Antifragile.md
    old_size: 123456
    new_size: 125000
    old_hash: sha256:def456...
    new_hash: sha256:ghi789...
    priority: medium

missing_sources:
  - path: sources/articles/Edge_2020.md
    status: not_found
    last_seen: '2025-09-15T10:00:00'
```

### brownfield-plan.yaml

```yaml
schema_version: '1.0'
plan_timestamp: '2025-10-06T01:15:00'
mind: nassim_taleb
diff_source: docs/logs/20251006-0100-brownfield-diff.yaml

update_scope:
  type: incremental  # incremental | refactoring | major_overhaul
  impact: medium     # low | medium | high
  estimated_time: 2-3 hours

areas_affected:
  sources: true
  artifacts: true
  kb: true
  system_prompts: false
  specialists: false

prompts_to_rerun:
  - prompt_id: analysis_source_reading
    phase: analysis
    agent: analyst
    target: sources/interviews/Naval_Podcast_2023.md
    reason: new_source
    depends_on: []
    parallelizable: true
    estimated_duration_ms: 180000

  - prompt_id: analysis_quote_extraction
    phase: analysis
    agent: analyst
    target: sources/interviews/Naval_Podcast_2023.md
    reason: new_source
    depends_on: [analysis_source_reading]
    parallelizable: false
    estimated_duration_ms: 120000

backup_required: true
regression_tests_required: true

pre_execution_checklist:
  - "Create backup: cp -r minds/nassim_taleb minds/BACKUP_nassim_taleb_$(date +%Y%m%d)"
  - "Read docs/LIMITATIONS.md"
  - "Document baseline behavior"
```

### brownfield-execution.yaml

```yaml
schema_version: '1.0'
execution_id: brownfield_nassim_taleb_20251006_0130
mind: nassim_taleb
plan_file: docs/logs/20251006-0115-brownfield-plan.yaml
status: in_progress  # in_progress | completed | failed

steps_completed:
  - step: backup_created
    timestamp: '2025-10-06T01:30:15'
    details:
      backup_location: minds/BACKUP_nassim_taleb_20251006

  - step: prompt_executed
    timestamp: '2025-10-06T01:32:45'
    details:
      prompt_id: analysis_source_reading
      agent: analyst
      launcher_log_ref: launcher-history.yaml:line_156
    status: completed

steps_pending:
  - synthesis_kb_chunker
  - regression_testing
  - human_checkpoint

can_resume: true
last_checkpoint: '2025-10-06T01:35:12'
```

### regression-test.yaml

```yaml
schema_version: '1.0'
test_timestamp: '2025-10-06T02:00:00'
mind: nassim_taleb
execution_id: brownfield_nassim_taleb_20251006_0130

baseline_version:
  system_prompt: 20251001-1200-v1.1-generalista.md
  kb_chunks: 42
  last_update: '2025-10-01T12:00:00'

updated_version:
  system_prompt: 20251001-1200-v1.1-generalista.md
  kb_chunks: 54
  last_update: '2025-10-06T01:35:12'

tests:
  - test_id: personality_consistency_001
    category: personality
    prompt: "What's your view on randomness in markets?"
    baseline_response: |
      [previous response]
    updated_response: |
      [new response]
    status: pass
    similarity_score: 0.96
    notes: "Consistent tone and framework usage"

summary:
  total_tests: 12
  passed: 11
  warnings: 1
  critical: 0
  recommendation: approve  # approve | revise | rollback
```

### brownfield-rollback.yaml

```yaml
schema_version: '1.0'
rollback_timestamp: '2025-10-06T02:15:00'
mind: nassim_taleb
execution_id: brownfield_nassim_taleb_20251006_0130
reason: critical_regression_detected

backup_source: minds/BACKUP_nassim_taleb_20251006

rollback_steps:
  - action: restore_sources
    command: cp -r minds/BACKUP_nassim_taleb_20251006/sources minds/nassim_taleb/
    status: completed

  - action: restore_artifacts
    command: cp -r minds/BACKUP_nassim_taleb_20251006/artifacts minds/nassim_taleb/
    status: completed

rollback_successful: true

preserved_logs:
  - docs/logs/20251006-0115-brownfield-plan.yaml
  - docs/logs/20251006-0130-brownfield-execution.yaml
  - docs/logs/20251006-0200-regression-test.yaml
  - docs/logs/20251006-0215-brownfield-rollback.yaml

next_steps:
  - Review regression test failures
  - Analyze why new source caused inconsistency
  - Adjust plan and retry
```

---

## Integration Points

### With Launcher (Story 1.1)

**Integration**: WorkflowExecutor calls launcher CLI to execute prompts

```python
# brownfield/workflow_executor.py
def _execute_prompt_task(self, task: PromptTask):
    cmd = [
        'python3', '-m', 'docs.mmos.launcher.cli',
        '--mind', self.plan.mind,
        '--phase', task.phase,
        '--prompt', task.prompt_id
    ]

    subprocess.run(cmd, check=True)
```

**Shared Data**: `launcher-history.yaml` (read-only for brownfield)

---

### With Board (Story 1.2)

**Integration**: Board can display brownfield execution status

```python
# Future enhancement: board/board_engine.py
def get_brownfield_status(self, mind: str) -> Optional[BrownfieldStatus]:
    """Load latest brownfield execution log and show status"""
    execution_logs = glob(f'docs/mmos/logs/*brownfield-execution.yaml')
    # ... parse and display
```

**Shared Data**: All brownfield YAML logs in `docs/mmos/logs/`

---

### With BROWNFIELD_WORKFLOW.md

**Integration**: WorkflowExecutor uses BROWNFIELD_WORKFLOW.md as source of truth

```python
class WorkflowExecutor:
    def __init__(self, ...):
        self.workflow_steps = self._parse_brownfield_workflow()

    def _parse_brownfield_workflow(self) -> List[str]:
        """
        Parse BROWNFIELD_WORKFLOW.md and extract steps:
        - PASSO 1: Incremental Research
        - PASSO 2: Incremental Synthesis
        - PASSO 3: Validation Against Existing
        - PASSO 4: Selective Prompt Update
        - PASSO 5: Documentation Update
        - PASSO 6: Human Checkpoint
        """
```

---

## Error Handling

### Missing sources_master.yaml

```python
class DiffDetector:
    def detect(self):
        if not self.master_file.exists():
            # Fallback: Generate master from current sources
            print("[WARN] sources_master.yaml not found, generating from current state")
            self._generate_master_from_disk()
            print("[INFO] Created sources_master.yaml, all sources marked as 'existing'")
            return {'new_sources': [], 'modified_sources': [], 'missing_sources': []}
```

### Interrupted Execution

```python
class WorkflowExecutor:
    def execute(self):
        try:
            for task in self.plan.prompts_to_rerun:
                self._execute_prompt_task(task)
                self._checkpoint()  # Save after each task
        except KeyboardInterrupt:
            print("[INFO] Execution interrupted, progress saved")
            print(f"[INFO] Resume with: brownfield execute --mind {self.plan.mind} --resume")
```

### Regression Test Failures

```python
class RegressionTester:
    def run_tests(self):
        results = []
        for test in self.test_suite:
            try:
                result = self._run_test(test)
                results.append(result)
            except Exception as e:
                results.append(RegressionTest(
                    ...,
                    status='critical',
                    notes=f'Test failed with error: {e}'
                ))

        # Determine overall recommendation
        critical_count = sum(1 for r in results if r.status == 'critical')
        if critical_count > 0:
            recommendation = 'rollback'
        elif warning_count > 3:
            recommendation = 'revise'
        else:
            recommendation = 'approve'
```

---

## Performance Targets

| Operation | Target | Measurement |
|-----------|--------|-------------|
| Diff detection | <30s | 100 sources |
| Plan generation | <1min | Any scope |
| Execution tracking overhead | <100ms | Per prompt |
| Regression testing | <5min | 12 tests |
| Rollback | <2min | Full restore |

**Optimization Strategies**:

1. **Diff detection**: Use file stats (size, mtime) before computing hash
2. **Plan generation**: Cache prompts.yaml parse
3. **Execution**: Async logging (non-blocking)
4. **Regression testing**: Parallel test execution (if applicable)
5. **Rollback**: Use `rsync` for large directories

---

## Testing Strategy

### Unit Tests

```python
# tests/test_diff_detector.py
def test_detect_new_sources():
    # Given: sources/ has new file
    # When: DiffDetector.detect()
    # Then: new_sources contains the file

def test_detect_modified_sources():
    # Given: sources_master.yaml has old size, disk has new size
    # When: DiffDetector.detect()
    # Then: modified_sources contains the file

# tests/test_plan_generator.py
def test_map_new_source_to_prompts():
    # Given: diff report with new interview
    # When: PlanGenerator.generate()
    # Then: plan includes analysis_source_reading, quote_extraction, etc.

# tests/test_workflow_executor.py
def test_execute_prompt_task():
    # Given: PromptTask with prompt_id
    # When: WorkflowExecutor._execute_prompt_task()
    # Then: launcher CLI called correctly

# tests/test_regression_tester.py
def test_compare_responses():
    # Given: identical responses
    # When: RegressionTester._compare_responses()
    # Then: similarity_score = 1.0
```

### Integration Tests

```python
# tests/integration/test_brownfield_flow.py
def test_end_to_end_brownfield():
    # 1. Create test mind with sources_master.yaml
    # 2. Add new source to sources/
    # 3. Run detect → verify diff report
    # 4. Run plan → verify plan generated
    # 5. Run execute → verify launcher called
    # 6. Run test → verify regression tests run
    # 7. Verify all logs created correctly
```

### Real-World Test

```bash
# Test on actual mind (alan_nicolas or nassim_taleb)
# 1. Create backup
# 2. Add fake new source
# 3. Run full brownfield workflow
# 4. Verify results
# 5. Rollback
```

---

## Security Considerations

### Backup Integrity

- **Verification**: Check backup completeness before rollback
- **Isolation**: Store backups outside mind directory to prevent accidental modification

### Command Injection

```python
# VULNERABLE
os.system(f'cp {backup_location} {mind_dir}')  # DON'T

# SAFE
subprocess.run(['cp', '-r', backup_location, mind_dir], check=True)  # DO
```

### File Permissions

- Brownfield tool runs with same permissions as user
- No elevation required
- Respects existing file permissions

---

## Migration Path

### For Existing Minds

1. **First brownfield run**: If `sources_master.yaml` missing, generate from current state
2. **All sources marked as existing** (not "new")
3. **Future runs**: Normal diff detection works

### Backward Compatibility

- Works with minds created before AIOS-first tooling
- Does not require launcher or board to function
- Standalone tool (optional integration)

---

## Future Enhancements

### v2.0 Features

1. **AI-powered diff analysis**: Detect semantic changes, not just file changes
2. **Board integration**: Live brownfield progress in board view
3. **Auto-test generation**: Generate regression tests based on mind personality
4. **Brownfield templates**: Common update patterns (add specialist, update KB, etc.)
5. **Multi-mind updates**: Batch brownfield for multiple minds

### Advanced Rollback

1. **Partial rollback**: Rollback only specific artifacts
2. **Point-in-time recovery**: Rollback to any previous state (versioning)
3. **Diff preview**: Show exactly what will change before rollback

---

## Appendix: Algorithm Pseudocode

### DiffDetector.detect()

```
function detect():
    disk_sources = scan_directory(sources/)
    master_sources = load_master_yaml()

    new = []
    modified = []
    missing = []

    for path in disk_sources:
        if path not in master_sources:
            new.append(path)
        elif disk_sources[path].size != master_sources[path].size:
            modified.append(path)

    for path in master_sources:
        if path not in disk_sources:
            missing.append(path)

    return {new, modified, missing}
```

### PlanGenerator.generate()

```
function generate(diff_report):
    tasks = []

    for source in diff_report.new_sources:
        tasks.extend([
            PromptTask('analysis_source_reading', target=source),
            PromptTask('analysis_quote_extraction', depends_on=['analysis_source_reading']),
            PromptTask('analysis_behavioral_patterns', depends_on=['analysis_source_reading'])
        ])

    tasks.append(PromptTask('synthesis_kb_chunker', depends_on=all_analysis_tasks))

    tasks = resolve_dependencies(tasks)

    return BrownfieldPlan(
        prompts_to_rerun=tasks,
        estimated_time=estimate_time(tasks),
        risk=assess_risk(tasks)
    )
```

### WorkflowExecutor.execute()

```
function execute(plan):
    validate_backup_exists()

    for task in plan.prompts_to_rerun:
        execute_launcher(task)
        log_step(task)
        checkpoint()

    return execution_log
```

---

**Status**: Technical Design Approved ✅
**Next Step**: Implementation
