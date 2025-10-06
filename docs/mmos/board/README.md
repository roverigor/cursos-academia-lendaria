# AIOS Board - Orchestration Board & Telemetria

**Visualization and telemetry for MMOS pipeline execution.**

Provides real-time progress tracking, telemetry dashboards, and checkpoint management for MMOS mind creation.

---

## Features

✅ **Per-Mind Progress View** - See exactly where each mind is in the 59-prompt pipeline
✅ **Multi-Mind Overview** - Track multiple minds in parallel
✅ **Telemetry Dashboard** - Performance metrics, bottlenecks, success rates
✅ **Checkpoint Management** - Log human validations at 6 critical gates
✅ **Auto-Refresh Mode** - Live monitoring with `--watch`
✅ **Export Snapshots** - Save board state for historical tracking

---

## Installation

Board uses the same virtual environment as the Launcher:

```bash
source docs/mmos/launcher/.venv/bin/activate
```

Dependencies are already installed from Launcher (Click + PyYAML).

---

## Commands

### 1. View Progress (Single Mind)

```bash
python3 -m docs.mmos.board.cli view --mind nassim_taleb
```

**Output**:
```
# 🧠 MMOS Pipeline: nassim_taleb
━━━━━━━━━━━━━━━━━━ 12/59 (20%)

✅ PHASE 1: VIABILITY (5/5 prompts)
├─ ✅ viability_scorecard_apex (analyst, 23ms)
└─ ✅ viability_prd_generator (pm, 156ms)
🚦 CHECKPOINT #1: ✅ APPROVED

🟡 PHASE 2: RESEARCH (2/6 prompts)
├─ ✅ research_source_discovery (analyst, 234ms)
└─ ⏳ research_source_collector (pending)
🚦 CHECKPOINT #2: ⏸️  PENDING
...
```

**With Auto-Refresh**:
```bash
python3 -m docs.mmos.board.cli view --mind nassim_taleb --watch
# Refreshes every 10 seconds (Ctrl+C to stop)
```

**Custom Refresh Interval**:
```bash
python3 -m docs.mmos.board.cli view --mind nassim_taleb --watch --refresh-interval 5
# Refreshes every 5 seconds
```

---

### 2. Overview (All Minds)

```bash
python3 -m docs.mmos.board.cli overview
```

**Output**:
```
# 🧠 MMOS Pipeline Overview

| Mind | Phase | Progress | Last Updated | Checkpoints | Status |
|------|-------|----------|--------------|-------------|--------|
| nassim_taleb | research | 12/59 (20%) | 5min ago | 1/6 ✅ | 🟢 Active |
| charlie_munger | viability | 3/59 (5%) | 2h ago | 0/6 ⏸️  | 🟡 Stalled |
| ray_dalio | analysis | 28/59 (47%) | 30min ago | 3/6 ✅ | 🟢 Active |

## Global Statistics
- Total minds: 3
- Active minds: 2
```

---

### 3. Telemetry Dashboard

```bash
python3 -m docs.mmos.board.cli telemetry
```

**Output**:
```
# 📊 MMOS Telemetry Dashboard

## Performance by Phase (All Minds, All Time)

| Phase | Avg Duration | Min | Max | Executions | Success Rate |
|-------|--------------|-----|-----|------------|--------------|
| Viability | 342ms | 24ms | 1.2s | 15 | 100% |
| Research | 892ms | 234ms | 3.5s | 12 | 100% |
| Analysis | 1.4s | 456ms | 8.2s | 36 | 97% |
...

## Slowest Prompts (Top 10)

1. **analysis_cognitive_architecture**: 8.2s max (6.5s avg, 1 executions)
2. **analysis_psychometric_analysis**: 5.6s max (4.2s avg, 2 executions)
3. **research_source_collector**: 3.5s max (2.1s avg, 3 executions)
...
```

---

### 4. Log Checkpoint Validation

**Approve Checkpoint**:
```bash
python3 -m docs.mmos.board.cli checkpoint \
  --mind nassim_taleb \
  --phase viability \
  --approve \
  --notes "All viability outputs validated successfully"
```

**Reject Checkpoint**:
```bash
python3 -m docs.mmos.board.cli checkpoint \
  --mind nassim_taleb \
  --phase research \
  --reject \
  --notes "Insufficient sources, need 2 more books"
```

**Output**:
```
✅ Checkpoint #1 (viability) APPROVED
   Mind: nassim_taleb
   Validator: oalanicolas
   Notes: All viability outputs validated successfully

✅ Logged to launcher-history.yaml
```

---

### 5. Export Snapshot

**Auto-generated filename**:
```bash
python3 -m docs.mmos.board.cli export --mind nassim_taleb
# Saves to: docs/mmos/logs/20251006-1530-nassim_taleb-board.md
```

**Custom filename**:
```bash
python3 -m docs.mmos.board.cli export --mind nassim_taleb --output reports/nassim_progress.md
```

---

## Use Cases

### Daily Standup

```bash
# Quick overview of all minds
python3 -m docs.mmos.board.cli overview
```

### Monitor Active Mind

```bash
# Watch nassim_taleb progress in real-time
python3 -m docs.mmos.board.cli view --mind nassim_taleb --watch
```

### Validate Checkpoint

```bash
# 1. Review outputs manually
ls minds/nassim_taleb/docs/logs/

# 2. Approve checkpoint
python3 -m docs.mmos.board.cli checkpoint \
  --mind nassim_taleb \
  --phase viability \
  --approve \
  --notes "APEX score 42/50, ICP match 8/10 - approved"
```

### Weekly Report

```bash
# Export snapshots for all minds
for mind in nassim_taleb charlie_munger ray_dalio; do
  python3 -m docs.mmos.board.cli export --mind $mind
done

# View telemetry for team review
python3 -m docs.mmos.board.cli telemetry > weekly-telemetry-report.md
```

---

## Data Source

Board reads **read-only** from:
- `docs/mmos/launcher-history.yaml` - Execution logs + checkpoint validations

Schema:
```yaml
schema_version: '1.1'

executions:  # Written by Launcher
  - timestamp: ...
    mind: nassim_taleb
    phase: viability
    prompt_id: viability_scorecard_apex
    # ... more fields

checkpoints:  # Written by Board
  - timestamp: ...
    mind: nassim_taleb
    checkpoint_num: 1
    phase: viability
    status: approved  # approved | rejected | pending
    validator: oalanicolas
    notes: "All good!"
    executions_reviewed: 5
```

---

## Architecture

```
board/
├── __init__.py
├── board_engine.py          # Core analytics + data aggregation
├── checkpoint_manager.py    # Checkpoint logging (thread-safe)
├── cli.py                   # Click CLI commands
├── renderers/
│   └── markdown_renderer.py # Terminal formatting
└── requirements.txt
```

**Key Components**:

- **BoardEngine**: Loads history, calculates progress, generates telemetry
- **CheckpointManager**: Logs validations with file locking (concurrent safe)
- **MarkdownRenderer**: Formats data for beautiful terminal output
- **CLI**: 5 commands (view, overview, telemetry, checkpoint, export)

---

## Performance

- **File loading**: <50ms for 1000 executions (cached)
- **Board rendering**: <100ms
- **Total**: <500ms (well below target)

**Caching**: Board caches parsed history and only reloads if file modified.

---

## Integration with Launcher

Board and Launcher share the same data file (`launcher-history.yaml`):

```
Launcher (Story 1.1)  →  logs executions  →  launcher-history.yaml
                                                      ↓
Board (Story 1.2)     →  reads + visualizes  ←  (read-only)
                      →  logs checkpoints    →  (append-only)
```

**Backward Compatible**:
- Old schema 1.0 (Launcher only) still works
- Schema 1.1 adds `checkpoints` key (Board)
- Launcher continues to work without Board

---

## Example Session

```bash
# Activate env
source docs/mmos/launcher/.venv/bin/activate

# Create new mind
mkdir -p docs/minds/nassim_taleb/{sources,artifacts,kb,docs/logs,system_prompts}

# Run first prompt
python3 -m docs.mmos.launcher.cli \
  --mind nassim_taleb \
  --phase viability \
  --prompt viability_scorecard_apex

# Check progress
python3 -m docs.mmos.board.cli view --mind nassim_taleb

# Run more prompts...
# (repeat launcher commands)

# View progress in real-time
python3 -m docs.mmos.board.cli view --mind nassim_taleb --watch

# Approve checkpoint after phase completes
python3 -m docs.mmos.board.cli checkpoint \
  --mind nassim_taleb \
  --phase viability \
  --approve \
  --notes "Phase 1 complete, proceeding to research"

# Export snapshot
python3 -m docs.mmos.board.cli export --mind nassim_taleb
```

---

## Troubleshooting

### "ModuleNotFoundError: No module named 'click'"

**Solution**: Activate the virtual environment first:
```bash
source docs/mmos/launcher/.venv/bin/activate
```

### "FileNotFoundError: prompts.yaml not found"

**Solution**: Run from project root, not from `docs/mmos/`:
```bash
cd /path/to/mente_lendaria
python3 -m docs.mmos.board.cli view --mind nassim_taleb
```

### Board shows 0/59 prompts but I ran some

**Solution**: Check if executions have `dry_run: true` (dry-run executions are not counted):
```bash
grep "dry_run: false" docs/mmos/launcher-history.yaml
```

---

## Roadmap

**Current (v0.1.0)**:
- ✅ Terminal-based Markdown rendering
- ✅ All 5 commands working
- ✅ Checkpoint logging
- ✅ Auto-refresh mode

**Future (v0.2.0)**:
- HTML dashboard (web UI)
- Email/Slack notifications on checkpoint ready
- Historical trends (progress over time)
- Estimated completion time prediction

---

## See Also

- [Launcher README](../launcher/README.md) - Execute prompts
- [Story 1.2 Spec](../../docs/stories/story-1.2-orchestration-board.md) - Requirements
- [Technical Design](../../architecture/story-1.2-technical-design.md) - Architecture details
- [AIOS Workflow](../../docs/AIOS_WORKFLOW.md) - Pipeline overview

---

**AIOS Board v0.1.0** | Part of MMOS Pipeline | Story 1.2 Complete ✅
