# Story 1.2: Orchestration Board - Technical Design

**Author:** Winston (Architect)
**Date:** 2025-10-06
**Story:** 1.2 - Orchestration Board & Telemetria
**Status:** 📐 Design Review

---

## 🏗️ Architecture Overview

### System Context

```
┌─────────────────────────────────────────────────────────┐
│                  Existing System                        │
│  ┌─────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │   CLI       │→ │ Launcher     │→ │ History File  │  │
│  │ (cli.py)    │  │ Components   │  │ (YAML)        │  │
│  └─────────────┘  └──────────────┘  └───────────────┘  │
└─────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────┐
│                  New System (Story 1.2)                 │
│  ┌──────────────┐  ┌───────────────┐  ┌──────────────┐ │
│  │  Board CLI   │→ │  Board Engine │→ │  Renderers   │ │
│  │  Commands    │  │  (Analytics)  │  │  (Markdown)  │ │
│  └──────────────┘  └───────────────┘  └──────────────┘ │
│         ↑                                               │
│         └────── Reads launcher-history.yaml ────────────┘
└─────────────────────────────────────────────────────────┘
```

### Design Principles

1. **Read-Only Consumer**: Board ONLY reads from `launcher-history.yaml`
2. **No Schema Breaking**: Extends schema backward-compatibly
3. **Performance**: Sub-second rendering for 1000+ executions
4. **Modularity**: Reusable components for future dashboards

---

## 📊 Data Model

### Extended Schema (`launcher-history.yaml`)

```yaml
schema_version: '1.1'  # Increment version

# EXISTING: Execution logs (unchanged)
executions:
  - timestamp: '2025-10-06T00:06:20.779586'
    mind: nassim_taleb
    phase: viability
    prompt_id: viability_scorecard_apex
    prompt_title: SCORECARD APEX
    agent: analyst
    user: oalanicolas
    output_path: minds/nassim_taleb/docs/logs/20251006-0006-viability.yaml
    parallelizable: false
    context_shown: false
    dry_run: false
    duration_ms: 23

# NEW: Checkpoint validations
checkpoints:
  - timestamp: '2025-10-06T00:35:00.123456'
    mind: nassim_taleb
    checkpoint_num: 1
    phase: viability
    status: approved  # approved | rejected | pending
    validator: oalanicolas
    notes: "All viability outputs validated successfully"
    executions_reviewed: 5  # Number of prompts validated
```

### Backward Compatibility

- If `checkpoints` key missing → assume empty array
- Old launchers (schema 1.0) continue to work
- Board gracefully handles both schema versions

---

## 🧩 Component Architecture

### 1. Board Engine (`board/board_engine.py`)

**Responsibility**: Core analytics and data aggregation

```python
class BoardEngine:
    """
    Central analytics engine for MMOS pipeline data.
    Aggregates executions, calculates telemetry, tracks checkpoints.
    """

    def __init__(self, history_file: str = "docs/mmos/launcher-history.yaml"):
        self.history_file = Path(history_file)
        self._cache = None
        self._cache_mtime = None

    # --- Data Loading ---

    def _load_data(self) -> Dict:
        """Load and cache history file (reload if modified)"""
        current_mtime = self.history_file.stat().st_mtime

        if self._cache is None or self._cache_mtime != current_mtime:
            with open(self.history_file, 'r') as f:
                self._cache = yaml.safe_load(f)
                self._cache_mtime = current_mtime

        return self._cache

    # --- Mind-Specific Queries ---

    def get_mind_progress(self, mind: str) -> MindProgress:
        """
        Calculate progress for a specific mind.

        Returns:
            MindProgress with:
            - total_prompts: 59 (from prompts.yaml)
            - completed_prompts: X
            - phases: {phase: {completed: X, total: Y, prompts: [...]}}
            - checkpoints: {1: status, 2: status, ...}
        """
        pass

    def get_mind_executions(self, mind: str) -> List[Dict]:
        """Get all executions for a mind, sorted by timestamp"""
        data = self._load_data()
        executions = data.get('executions', [])
        return [e for e in executions if e.get('mind') == mind]

    def get_mind_checkpoints(self, mind: str) -> List[Dict]:
        """Get all checkpoint validations for a mind"""
        data = self._load_data()
        checkpoints = data.get('checkpoints', [])
        return [c for c in checkpoints if c.get('mind') == mind]

    # --- Multi-Mind Queries ---

    def get_all_minds(self) -> List[str]:
        """Get list of unique minds from executions"""
        data = self._load_data()
        executions = data.get('executions', [])
        return sorted(set(e.get('mind') for e in executions if e.get('mind')))

    def get_overview(self) -> Dict[str, MindSummary]:
        """Get summary for all minds"""
        minds = {}
        for mind in self.get_all_minds():
            minds[mind] = self.get_mind_summary(mind)
        return minds

    # --- Telemetry Queries ---

    def calculate_phase_telemetry(self) -> Dict[str, PhaseStats]:
        """
        Calculate statistics per phase across all minds.

        Returns:
            {
                'viability': PhaseStats(avg_duration=342, min=24, max=1200, ...),
                'research': PhaseStats(...),
                ...
            }
        """
        pass

    def find_slowest_prompts(self, limit: int = 10) -> List[PromptStat]:
        """Identify slowest prompts by max duration"""
        pass

    def calculate_success_rates(self) -> Dict:
        """Calculate success rates per phase/prompt"""
        pass

    # --- Data Classes ---

    @dataclass
    class MindProgress:
        mind: str
        total_prompts: int
        completed_prompts: int
        completion_pct: float
        phases: Dict[str, PhaseProgress]
        checkpoints: Dict[int, CheckpointStatus]
        last_updated: datetime

    @dataclass
    class PhaseProgress:
        phase: str
        total: int
        completed: int
        prompts: List[PromptExecution]
        checkpoint_status: str  # approved | pending | rejected

    @dataclass
    class PromptExecution:
        prompt_id: str
        prompt_title: str
        status: str  # completed | pending | failed
        agent: str
        duration_ms: Optional[int]
        timestamp: Optional[datetime]
```

### 2. Renderers (`board/renderers/`)

**Responsibility**: Format data for display

#### `markdown_renderer.py`

```python
class MarkdownRenderer:
    """Renders board data as formatted Markdown for terminal display"""

    def render_mind_progress(self, progress: MindProgress) -> str:
        """
        Render per-mind progress view.

        Output format:
        # 🧠 MMOS Pipeline: {mind}
        ━━━━━━━━━━━━━━ {X}/59 ({pct}%)

        ✅ PHASE 1: VIABILITY (5/5)
        ├─ ✅ viability_scorecard_apex (analyst, 24ms)
        └─ ✅ viability_prd_generator (pm, 156ms)
        🚦 CHECKPOINT #1: ✅ APPROVED
        ...
        """
        lines = []

        # Header
        lines.append(f"# 🧠 MMOS Pipeline: {progress.mind}\n")

        # Progress bar
        bar_width = 40
        filled = int(bar_width * progress.completion_pct / 100)
        bar = "━" * filled + "─" * (bar_width - filled)
        lines.append(f"## Overall Progress")
        lines.append(f"{bar} {progress.completed_prompts}/{progress.total_prompts} ({progress.completion_pct:.0f}%)\n")

        # Phases
        lines.append(f"## Phase Status\n")
        for phase_name, phase_data in progress.phases.items():
            lines.extend(self._render_phase(phase_name, phase_data))

        return "\n".join(lines)

    def _render_phase(self, phase_name: str, phase: PhaseProgress) -> List[str]:
        """Render a single phase"""
        lines = []

        # Phase header
        icon = self._get_phase_icon(phase)
        lines.append(f"### {icon} PHASE {phase.order}: {phase_name.upper()} ({phase.completed}/{phase.total} prompts)")

        # Prompts
        for prompt in phase.prompts:
            icon = "✅" if prompt.status == "completed" else "⏳"
            duration = f"{prompt.duration_ms}ms" if prompt.duration_ms else "pending"
            lines.append(f"├─ {icon} {prompt.prompt_id} ({prompt.agent}, {duration})")

        # Checkpoint
        checkpoint_icon = self._get_checkpoint_icon(phase.checkpoint_status)
        lines.append(f"🚦 CHECKPOINT #{phase.checkpoint_num}: {checkpoint_icon} {phase.checkpoint_status.upper()}\n")

        return lines

    def render_overview(self, overview: Dict[str, MindSummary]) -> str:
        """Render multi-mind overview table"""
        pass

    def render_telemetry(self, telemetry: Dict) -> str:
        """Render telemetry dashboard"""
        pass
```

### 3. Checkpoint Manager (`board/checkpoint_manager.py`)

**Responsibility**: Log and query checkpoint validations

```python
class CheckpointManager:
    """Manages checkpoint validation logging and queries"""

    def __init__(self, history_file: str = "docs/mmos/launcher-history.yaml"):
        self.history_file = Path(history_file)

    def log_checkpoint(
        self,
        mind: str,
        checkpoint_num: int,
        phase: str,
        status: str,
        validator: str,
        notes: str = ""
    ):
        """
        Log a checkpoint validation.

        Args:
            mind: Mind name
            checkpoint_num: 1-6
            phase: Phase name
            status: 'approved' | 'rejected' | 'pending'
            validator: OS username
            notes: Optional notes from validator

        Thread-safe: Uses file locking for concurrent writes
        """
        import fcntl

        with open(self.history_file, 'r+') as f:
            # Lock file for atomic write
            fcntl.flock(f.fileno(), fcntl.LOCK_EX)

            data = yaml.safe_load(f)

            # Ensure checkpoints key exists
            if 'checkpoints' not in data:
                data['checkpoints'] = []

            # Add new checkpoint
            checkpoint_record = {
                'timestamp': datetime.now().isoformat(),
                'mind': mind,
                'checkpoint_num': checkpoint_num,
                'phase': phase,
                'status': status,
                'validator': validator,
                'notes': notes,
                'executions_reviewed': self._count_phase_executions(data, mind, phase)
            }

            data['checkpoints'].append(checkpoint_record)

            # Write back
            f.seek(0)
            yaml.dump(data, f, allow_unicode=True, sort_keys=False)
            f.truncate()

            fcntl.flock(f.fileno(), fcntl.LOCK_UN)

    def get_checkpoint_status(self, mind: str, checkpoint_num: int) -> Optional[str]:
        """Get status of a specific checkpoint (approved/rejected/pending)"""
        with open(self.history_file, 'r') as f:
            data = yaml.safe_load(f)
            checkpoints = data.get('checkpoints', [])

            # Find most recent status for this checkpoint
            for checkpoint in reversed(checkpoints):
                if (checkpoint.get('mind') == mind and
                    checkpoint.get('checkpoint_num') == checkpoint_num):
                    return checkpoint.get('status')

            return 'pending'  # Default if no record found
```

### 4. CLI Extension (`board/cli.py`)

**Responsibility**: Command-line interface for board

```python
import click
from .board_engine import BoardEngine
from .renderers.markdown_renderer import MarkdownRenderer
from .checkpoint_manager import CheckpointManager

@click.group()
def board():
    """MMOS Pipeline Orchestration Board"""
    pass

@board.command()
@click.option('--mind', required=True, help='Mind name')
@click.option('--watch', is_flag=True, help='Auto-refresh every 10s')
@click.option('--refresh-interval', default=10, help='Refresh interval in seconds')
def view(mind: str, watch: bool, refresh_interval: int):
    """View progress for a specific mind"""
    engine = BoardEngine()
    renderer = MarkdownRenderer()

    if watch:
        import time
        while True:
            click.clear()
            progress = engine.get_mind_progress(mind)
            output = renderer.render_mind_progress(progress)
            click.echo(output)
            time.sleep(refresh_interval)
    else:
        progress = engine.get_mind_progress(mind)
        output = renderer.render_mind_progress(progress)
        click.echo(output)

@board.command()
def overview():
    """View overview of all minds"""
    engine = BoardEngine()
    renderer = MarkdownRenderer()

    overview = engine.get_overview()
    output = renderer.render_overview(overview)
    click.echo(output)

@board.command()
def telemetry():
    """View telemetry dashboard"""
    engine = BoardEngine()
    renderer = MarkdownRenderer()

    telemetry = {
        'phase_stats': engine.calculate_phase_telemetry(),
        'slowest_prompts': engine.find_slowest_prompts(10),
        'success_rates': engine.calculate_success_rates()
    }

    output = renderer.render_telemetry(telemetry)
    click.echo(output)

@board.command()
@click.option('--mind', required=True)
@click.option('--phase', required=True)
@click.option('--approve', 'action', flag_value='approve')
@click.option('--reject', 'action', flag_value='reject')
@click.option('--notes', default='', help='Validation notes')
def checkpoint(mind: str, phase: str, action: str, notes: str):
    """Log checkpoint validation"""
    import os

    # Map phase to checkpoint number
    phase_to_checkpoint = {
        'viability': 1,
        'research': 2,
        'analysis': 3,
        'synthesis': 4,
        'implementation': 5,
        'testing': 6
    }

    checkpoint_num = phase_to_checkpoint.get(phase)
    if not checkpoint_num:
        click.echo(f"❌ Invalid phase: {phase}", err=True)
        return

    manager = CheckpointManager()
    status = 'approved' if action == 'approve' else 'rejected'
    validator = os.getenv('USER', 'unknown')

    manager.log_checkpoint(
        mind=mind,
        checkpoint_num=checkpoint_num,
        phase=phase,
        status=status,
        validator=validator,
        notes=notes
    )

    icon = "✅" if status == 'approved' else "❌"
    click.echo(f"{icon} Checkpoint #{checkpoint_num} ({phase}) {status.upper()} by {validator}")

@board.command()
@click.option('--mind', required=True)
@click.option('--output', help='Output file path')
def export(mind: str, output: Optional[str]):
    """Export board snapshot to file"""
    from datetime import datetime

    engine = BoardEngine()
    renderer = MarkdownRenderer()

    progress = engine.get_mind_progress(mind)
    content = renderer.render_mind_progress(progress)

    if not output:
        timestamp = datetime.now().strftime("%Y%m%d-%H%M")
        output = f"docs/mmos/logs/{timestamp}-{mind}-board.md"

    Path(output).parent.mkdir(parents=True, exist_ok=True)
    Path(output).write_text(content)

    click.echo(f"✅ Board exported to: {output}")

if __name__ == '__main__':
    board()
```

---

## 📁 File Structure

```
docs/mmos/
├── launcher/                   # Existing (Story 1.1)
│   ├── cli.py
│   ├── prompt_loader.py
│   ├── logger.py
│   └── ...
├── board/                      # NEW (Story 1.2)
│   ├── __init__.py
│   ├── cli.py                  # Board CLI commands
│   ├── board_engine.py         # Core analytics engine
│   ├── checkpoint_manager.py   # Checkpoint logging
│   ├── renderers/
│   │   ├── __init__.py
│   │   └── markdown_renderer.py
│   └── requirements.txt
└── launcher-history.yaml       # Extended schema
```

---

## 🔄 Integration Points

### With Launcher (Story 1.1)

- **Data Flow**: Launcher writes → Board reads
- **Schema**: Board extends schema v1.0 → v1.1 (backward compatible)
- **No Breaking Changes**: Old launcher continues to work

### With prompts.yaml

- Board needs total prompt count per phase → reads from prompts.yaml
- Uses `prompt_loader.py` from Story 1.1 (DRY principle)

### With Future Stories

- **Story 1.5 (Auto-Execution)**: Board provides progress visibility during execution
- **Story 1.4 (Notes)**: Could integrate notes into board view

---

## ⚡ Performance Considerations

### Caching Strategy

```python
# Cache parsed YAML, reload only if file modified
if file_mtime != cached_mtime:
    reload()
```

### Indexing

```python
# Pre-index executions by mind for O(1) lookups
{
    'nassim_taleb': [exec1, exec2, ...],
    'steve_jobs': [exec3, exec4, ...]
}
```

### Lazy Loading

```python
# Load full data only when needed
def get_mind_progress(mind):
    # Only parse executions for THIS mind
    # Not all minds
```

**Expected Performance**:
- File load: <50ms for 1000 executions
- Board render: <100ms
- Total: <500ms (well below target)

---

## 🧪 Testing Strategy

### Unit Tests

```python
# test_board_engine.py
def test_get_mind_progress_calculates_completion():
    engine = BoardEngine('test-history.yaml')
    progress = engine.get_mind_progress('test_mind')
    assert progress.completion_pct == 20.0  # 12/59

# test_markdown_renderer.py
def test_render_includes_all_phases():
    renderer = MarkdownRenderer()
    output = renderer.render_mind_progress(mock_progress)
    assert 'PHASE 1: VIABILITY' in output
    assert 'CHECKPOINT #1' in output
```

### Integration Tests

```python
# test_cli_integration.py
def test_view_command_with_real_data():
    result = runner.invoke(board, ['view', '--mind', 'nassim_taleb'])
    assert result.exit_code == 0
    assert 'nassim_taleb' in result.output
```

### Manual Testing

1. Create test data with 3 minds in different phases
2. Run all CLI commands
3. Verify output formatting
4. Test watch mode (auto-refresh)
5. Test checkpoint logging

---

## 📋 Implementation Plan

### Day 1: Core Engine (6-8h)
- [ ] Create `board/` module structure
- [ ] Implement `BoardEngine` class
- [ ] Implement data loading + caching
- [ ] Implement mind-specific queries
- [ ] Unit tests for engine

### Day 2: Rendering + CLI (6-8h)
- [ ] Implement `MarkdownRenderer`
- [ ] Implement `CheckpointManager`
- [ ] Create CLI commands (view, overview, telemetry)
- [ ] Integration tests

### Day 3: Polish + Docs (4-6h)
- [ ] Implement export command
- [ ] Implement watch mode
- [ ] Write README
- [ ] Manual testing with real data
- [ ] Performance testing
- [ ] Documentation

---

## ✅ Acceptance Checklist

- [ ] AC1: `aios-board view --mind X` displays complete progress
- [ ] AC2: `aios-board overview` shows multi-mind table
- [ ] AC3: `aios-board telemetry` calculates accurate metrics
- [ ] AC4: `aios-board view --watch` auto-refreshes
- [ ] AC5: `aios-board export` creates file
- [ ] AC6: `aios-board checkpoint` logs validations
- [ ] IV1: Board reads launcher-history.yaml without modifications
- [ ] IV2: Checkpoints require manual validation
- [ ] IV3: Board generation < 500ms

---

## 🚨 Risk Mitigation

| Risk | Mitigation |
|------|------------|
| File locking conflicts | Use `fcntl` for atomic writes |
| Large file performance | Implement caching + lazy loading |
| Terminal width issues | Test on 80-char terminals, add truncation |
| Concurrent writes | File locking + append-only checkpoints |

---

**Status**: ✅ Ready for Implementation
**Next Step**: Begin Day 1 implementation

---

*Winston (Architect) - 2025-10-06*
