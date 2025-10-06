# Story 1.2: Orchestration Board & Telemetria

**Epic:** 1 - MMOS AIOS-first Orchestration
**Priority:** High (enables Story 1.5)
**Estimated Effort:** 2-3 days
**Status:** 📋 Ready for Development
**Dependencies:** Story 1.1 (Launcher MVP) ✅

---

## User Story

*As a product manager, I want an orchestration board and telemetry that shows progress, triggered agents, blockages, and checkpoints, so that the team has end-to-end visibility and decisions can be made quickly.*

---

## Business Context

### Current State (Post Story 1.1)
- ✅ Launcher logs all executions to `launcher-history.yaml`
- ✅ Each execution tracked with: mind, phase, prompt, agent, duration, timestamp
- ❌ **No visualization**: Can't see overall progress at a glance
- ❌ **No telemetry**: Don't know avg time per phase, slowest prompts, etc
- ❌ **No checkpoint tracking**: Manual validation not logged

### Desired State
- ✅ Visual board showing status of all 6 phases per mind
- ✅ Real-time progress: X/59 prompts completed
- ✅ Telemetry dashboard: avg duration, success rate, bottlenecks
- ✅ Checkpoint status: which gates passed/pending/failed
- ✅ Multi-mind view: track 5+ minds in parallel

### Value Proposition
- **Visibility**: Know exactly where each mind is in pipeline
- **Debugging**: Identify stuck/slow prompts immediately
- **Planning**: Predict completion time based on telemetry
- **Quality**: Track checkpoint approval rates

---

## Acceptance Criteria

### AC1: Mind Progress Board (Per Mind View)
**Given** a mind has had prompts executed via launcher
**When** operator runs `aios-board view --mind nassim_taleb`
**Then** the system displays:

```markdown
# 🧠 MMOS Pipeline: nassim_taleb

## Overall Progress
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 12/59 (20%)

## Phase Status

### ✅ PHASE 1: VIABILITY (5/5 prompts)
├─ ✅ viability_scorecard_apex (analyst, 24ms, 2025-10-06 00:06)
├─ ✅ viability_icp_match_score (analyst, 28ms, 2025-10-06 00:12)
├─ ✅ viability_prd_generator (pm, 156ms, 2025-10-06 00:20)
├─ ✅ viability_dependencies_mapper (architect, 45ms, 2025-10-06 00:25)
└─ ✅ viability_todo_initializer (pm, 89ms, 2025-10-06 00:30)
🚦 CHECKPOINT #1: ✅ APPROVED (2025-10-06 00:35)

### 🟡 PHASE 2: RESEARCH (2/6 prompts)
├─ ✅ research_source_discovery (analyst, 234ms, 2025-10-06 01:00)
├─ ✅ research_source_collector (analyst, 1.2s, 2025-10-06 01:15)
├─ ⏳ research_temporal_mapper (pending)
├─ ⏳ research_priority_calculator (pending)
├─ ⏳ research_sources_master (pending)
└─ ⏳ research_etl_q_a (pending)
🚦 CHECKPOINT #2: ⏸️  PENDING

### ⏸️  PHASE 3: ANALYSIS (0/18 prompts)
🚦 CHECKPOINT #3: ⏸️  PENDING

### ⏸️  PHASE 4: SYNTHESIS (0/7 prompts)
🚦 CHECKPOINT #4: ⏸️  PENDING

### ⏸️  PHASE 5: IMPLEMENTATION (0/9 prompts)
🚦 CHECKPOINT #5: ⏸️  PENDING

### ⏸️  PHASE 6: TESTING (0/2 prompts)
🚦 CHECKPOINT #6: ⏸️  PENDING

## Telemetry
- Total execution time: 2.8s
- Avg prompt duration: 139ms
- Slowest prompt: research_source_collector (1.2s)
- Success rate: 100% (7/7)
- Checkpoints passed: 1/6
```

### AC2: All Minds Overview (Multi-Mind View)
**Given** multiple minds are in progress
**When** operator runs `aios-board overview`
**Then** the system displays:

```markdown
# 🧠 MMOS Pipeline Overview

## Minds In Progress

| Mind | Phase | Progress | Last Updated | Checkpoints | Status |
|------|-------|----------|--------------|-------------|--------|
| nassim_taleb | research | 12/59 (20%) | 5min ago | 1/6 ✅ | 🟢 Active |
| charlie_munger | viability | 3/59 (5%) | 2h ago | 0/6 ⏸️  | 🟡 Stalled |
| ray_dalio | analysis | 28/59 (47%) | 30min ago | 3/6 ✅ | 🟢 Active |

## Global Telemetry
- Total minds: 3
- Total prompts executed: 43
- Avg time per mind: 2.5h
- Success rate: 98% (42/43)
```

### AC3: Telemetry Dashboard
**Given** historical data exists in `launcher-history.yaml`
**When** operator runs `aios-board telemetry`
**Then** the system displays:

```markdown
# 📊 MMOS Telemetry Dashboard

## Performance by Phase (All Minds, All Time)

| Phase | Avg Duration | Min | Max | Executions | Success Rate |
|-------|--------------|-----|-----|------------|--------------|
| Viability | 342ms | 24ms | 1.2s | 15 | 100% |
| Research | 892ms | 234ms | 3.5s | 12 | 100% |
| Analysis | 1.4s | 456ms | 8.2s | 36 | 97% |
| Synthesis | 756ms | 123ms | 2.1s | 14 | 100% |
| Implementation | 1.1s | 234ms | 4.5s | 18 | 100% |
| Testing | 445ms | 123ms | 1.2s | 4 | 100% |

## Slowest Prompts (Top 5)

1. analysis_cognitive_architecture: 8.2s (1 execution)
2. analysis_psychometric_analysis: 5.6s (2 executions)
3. research_source_collector: 3.5s (3 executions)
4. implementation_generalista_compiler: 4.5s (2 executions)
5. synthesis_kb_chunker: 2.1s (1 execution)

## Most Re-executed Prompts

1. analysis_mental_models: 3 retries (dependency issues)
2. research_source_discovery: 2 retries (timeout)

## Checkpoint Approval Rates

| Checkpoint | Approvals | Rejections | Approval Rate |
|------------|-----------|------------|---------------|
| #1 Viability | 5 | 0 | 100% |
| #2 Research | 4 | 1 | 80% |
| #3 Analysis | 3 | 0 | 100% |
| #4 Synthesis | 2 | 0 | 100% |
| #5 Implementation | 1 | 1 | 50% |
| #6 Testing | 1 | 0 | 100% |
```

### AC4: Auto-Refresh Mode (Live Monitoring)
**Given** board is displayed
**When** operator runs `aios-board view --mind nassim_taleb --watch`
**Then** the system:
1. Updates board every 10 seconds automatically
2. Highlights new prompts completed since last refresh
3. Shows real-time duration counter for in-progress prompts
4. Alerts when checkpoint validation is ready

### AC5: Export to File
**Given** board data exists
**When** operator runs `aios-board export --mind nassim_taleb`
**Then** the system:
1. Generates snapshot: `docs/mmos/logs/20251006-0130-nassim_taleb-board.md`
2. Includes full progress, telemetry, checkpoint status
3. Can be committed to git for historical tracking
4. Can be shared with stakeholders

### AC6: Checkpoint Logging
**Given** a phase has completed and operator validates checkpoint
**When** operator runs `aios-board checkpoint --mind nassim_taleb --phase viability --approve`
**Then** the system:
1. Logs checkpoint validation to `launcher-history.yaml`:
   ```yaml
   - timestamp: '2025-10-06T00:35:00'
     mind: nassim_taleb
     checkpoint: 1
     phase: viability
     status: approved
     validator: oalanicolas
     notes: "All viability prompts look good, proceeding to research"
   ```
2. Updates board to show ✅ APPROVED
3. Unlocks next phase for execution

---

## Integration Verification

### IV1: Read-Only Data Source
- ✅ Board reads ONLY from `launcher-history.yaml`
- ✅ No new folder structure required
- ✅ No modifications to existing logs

### IV2: Checkpoint Validation Required
- ✅ Checkpoints remain manual (not auto-approved)
- ✅ Board highlights when validation is needed
- ✅ Operator explicitly approves/rejects

### IV3: No Performance Degradation
- ✅ Board generation takes <500ms for 100+ prompts
- ✅ Does not slow down launcher execution
- ✅ Success rate remains >95%

---

## Technical Design (High-Level)

### New Components

#### 1. `board_generator.py`
```python
class BoardGenerator:
    def __init__(self, history_file: str):
        self.history = self._load_history(history_file)

    def view_mind(self, mind: str) -> str:
        """Generate per-mind progress board (Markdown)"""
        pass

    def overview(self) -> str:
        """Generate multi-mind overview board"""
        pass

    def telemetry(self) -> str:
        """Generate telemetry dashboard"""
        pass
```

#### 2. `checkpoint_manager.py`
```python
class CheckpointManager:
    def log_checkpoint(
        self,
        mind: str,
        phase: str,
        status: str,
        validator: str,
        notes: str
    ):
        """Log checkpoint validation to history"""
        pass

    def get_checkpoint_status(self, mind: str, checkpoint_num: int) -> dict:
        """Get status of specific checkpoint"""
        pass
```

#### 3. `telemetry_analyzer.py`
```python
class TelemetryAnalyzer:
    def analyze_phase_performance(self) -> dict:
        """Calculate avg/min/max duration per phase"""
        pass

    def identify_bottlenecks(self) -> list:
        """Find slowest prompts"""
        pass

    def calculate_success_rates(self) -> dict:
        """Success rate per phase/prompt"""
        pass
```

### CLI Extension
```bash
# View single mind progress
aios-board view --mind nassim_taleb

# View all minds
aios-board overview

# Telemetry dashboard
aios-board telemetry

# Live monitoring (auto-refresh)
aios-board view --mind nassim_taleb --watch

# Export snapshot
aios-board export --mind nassim_taleb

# Log checkpoint validation
aios-board checkpoint --mind nassim_taleb --phase viability --approve --notes "Looks good"
```

---

## Data Model Extension

### `launcher-history.yaml` Schema Extension
```yaml
schema_version: '1.0'

executions:
  - timestamp: '2025-10-06T00:06:00'
    mind: nassim_taleb
    phase: viability
    prompt_id: viability_scorecard_apex
    # ... existing fields ...

# NEW: Checkpoint validations
checkpoints:
  - timestamp: '2025-10-06T00:35:00'
    mind: nassim_taleb
    checkpoint: 1
    phase: viability
    status: approved  # approved | rejected | pending
    validator: oalanicolas
    notes: "All viability prompts validated"
```

---

## Success Metrics

### Functional
- ✅ Board displays all 6 phases correctly
- ✅ Telemetry calculates metrics accurately
- ✅ Checkpoints logged with validator + timestamp
- ✅ Multi-mind view shows all active minds

### Performance
- ✅ Board generation: <500ms for 100 prompts
- ✅ Auto-refresh: ≤10s interval
- ✅ Export file: <1MB for 1000 executions

### Usability
- ✅ Operator can understand status in <10 seconds
- ✅ Identifies bottlenecks immediately
- ✅ Checkpoint validation clear and obvious

---

## Dependencies

### Blocking
- ✅ Story 1.1 (Launcher MVP) - COMPLETE
- ✅ `launcher-history.yaml` format - DEFINED

### Non-Blocking
- Story 1.5 (Auto-Execution) - will benefit from board visibility

---

## Risks & Mitigations

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Large history file slows parsing | Medium | Medium | Cache parsed data, only reload on changes |
| Markdown formatting breaks in terminal | Low | Low | Test on multiple terminals (iTerm, Terminal.app) |
| Concurrent writes to history file | Low | High | File locking or append-only mode |

---

## Open Questions

1. **Output Format**: Terminal (Markdown) or HTML dashboard?
   - **Recommendation**: Start with Markdown (simpler), upgrade to HTML later if needed
2. **Refresh Interval**: 10s default for `--watch` mode?
   - **Recommendation**: 10s default, configurable via `--refresh-interval`
3. **Checkpoint CLI**: Separate command or integrated into board?
   - **Recommendation**: Separate `aios-board checkpoint` command for clarity

---

## Next Steps

1. **@architect** (Winston): Review technical design
2. **@dev**: Implement `board_generator.py`, `checkpoint_manager.py`
3. **@qa**: Test with multiple minds, large history files
4. **@pm** (John): Validate board UI meets stakeholder needs

---

**Author**: John (PM)
**Reviewers**: TBD
**Last Updated**: 2025-10-06

---

## Definition of Done

- [ ] `aios-board view --mind X` displays complete progress
- [ ] `aios-board overview` shows multi-mind status
- [ ] `aios-board telemetry` calculates accurate metrics
- [ ] `aios-board checkpoint` logs validations
- [ ] `aios-board export` creates shareable snapshot
- [ ] All tests pass (unit + integration)
- [ ] Documentation updated (README, AIOS_WORKFLOW.md)
- [ ] Deployed and validated with at least 2 real minds
