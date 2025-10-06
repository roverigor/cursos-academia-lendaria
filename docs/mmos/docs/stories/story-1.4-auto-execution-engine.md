# Story 1.4: Auto-Execution Engine (Full Automation with Parallel + Quality)

**Epic:** 1 - MMOS AIOS-first Orchestration
**Status:** Draft
**Priority:** High (blocks scalability)
**Estimated Effort:** 6-8 days

---

## User Story

**As a** pipeline operator,
**I want** a complete auto-execution engine that runs prompts efficiently (parallel when possible) and validates quality automatically,
**so that** I can automate the entire pipeline in ~4.5h (vs 47 manual commands over days) while maintaining quality gates.

---

## Context

### Current State (with Launcher MVP - Story 1.1)
- ✅ Launcher executes individual prompts
- ✅ Context injection working
- ✅ Logging to launcher-history.yaml
- ❌ **Still manual**: Operator runs 47 prompts one-by-one
- ❌ **No automation**: Each prompt requires manual command
- ❌ **Slow**: Full pipeline takes days of manual work

### Desired State (Story 1.4 - Full Auto-Execution)
- ✅ Operator runs 1 command for entire pipeline
- ✅ Engine executes prompts **intelligently** (parallel when safe, sequential when needed)
- ✅ Human validates at 6 checkpoints (end of each phase)
- ✅ **Quality automation**: Auto-flag poor outputs for review
- ✅ **Fast**: Complete pipeline in ~4.5h (vs days manual)
- ✅ **Smart error handling**: Retry, log, continue

### Full Scope (Story 1.4)
- ✅ Intelligent execution (parallel when possible via `parallelizable: true`)
- ✅ Dependency resolution (respect `depends_on`)
- ✅ Human checkpoints (approve/reject/retry)
- ✅ Quality scoring (auto-validate, flag poor outputs)
- ✅ Error handling (retry 3x, exponential backoff)
- ✅ Context injection (reuse Story 1.1)
- ✅ Simple config (YAML)

### Business Value
- **Automation**: Eliminate 47 manual commands per mind
- **Speed**: 40% faster (parallel execution where safe)
- **Quality**: Auto-flag poor outputs at checkpoints
- **Consistency**: Same execution flow every time
- **Scalability**: Enable batch creation of multiple minds

### Integration with Existing Stories
- **Story 1.1 (Launcher)**: ✅ Required - auto-executor uses launcher for prompt execution
- **Story 1.2 (Board)**: Optional - enhanced visibility into auto-execution progress
- **Story 1.3 (Brownfield)**: Independent - different use case

---

## Acceptance Criteria

### AC1: Intelligent Phase Execution (Sequential + Parallel)
**Given** a mind directory exists with required context
**When** operator runs `aios-pipeline execute-phase --mind <name> --phase <phase_name>`
**Then** the system:
1. Loads all prompts for that phase from `prompts.yaml`
2. Resolves execution order based on `depends_on` and `order` fields
3. For prompts with same `order` and `parallelizable: true`: executes concurrently (max 3)
4. For prompts with `parallelizable: false` or different orders: executes sequentially
5. Calls Anthropic API with appropriate prompt + context for each
6. Saves outputs to correct paths (resolved from output_template)
7. Logs each execution to `launcher-history.yaml`
8. Stops at end of phase and displays checkpoint validation prompt

**Validation (Parallel Execution):**
```bash
[Phase: Analysis] Order 2 (3 parallelizable prompts)
  ⏳ analysis_quote_extraction (started 14:30:15)
  ⏳ analysis_behavioral_patterns (started 14:30:15)
  ⏳ analysis_timeline_mapping (started 14:30:15)
  ✅ analysis_quote_extraction (45s)
  ✅ analysis_timeline_mapping (52s)
  ✅ analysis_behavioral_patterns (58s)
⚡ Time saved: ~1.5min (sequential: 155s, parallel: 58s)
```

**Validation (History Log):**
```yaml
# launcher-history.yaml (extended schema)
- execution_id: exec_nassim_taleb_analysis_20251006_1430
  mind: nassim_taleb
  phase: analysis
  mode: auto
  execution_strategy: parallel  # NEW: indicates parallel execution used
  prompts_executed:
    - prompt_id: analysis_quote_extraction
      status: completed
      duration_ms: 45230
      started_at: '2025-10-06T14:30:15'
      parallel_group: order_2  # NEW: indicates parallel execution group
      quality_score: excellent  # NEW: quality scoring
      output_path: docs/minds/nassim_taleb/artifacts/quotes.yaml
    - prompt_id: analysis_behavioral_patterns
      status: completed
      duration_ms: 58120
      started_at: '2025-10-06T14:30:15'
      parallel_group: order_2
      quality_score: good
      output_path: docs/minds/nassim_taleb/artifacts/behavioral_patterns.yaml
  checkpoint_status: awaiting_approval
  checkpoint_timestamp: '2025-10-06T14:31:13'
  time_saved_ms: 97110  # NEW: parallel time savings
```

---

### AC2: Human Checkpoint Validation (with Quality Highlights)
**Given** a phase has completed execution
**When** the checkpoint validation prompt is displayed
**Then** the system:
1. Shows summary of all outputs created in this phase
2. **Highlights poor quality outputs** for focused review
3. Lists files for human to review (with quality scores)
4. Shows checkpoint criteria (from AIOS_WORKFLOW.md)
5. Waits for human input: `approve`, `reject`, or `retry <prompt_id>`
6. If **approved**: proceeds to next phase (or completes if final phase)
7. If **rejected**: stops execution, logs rejection reason, preserves all outputs
8. If **retry**: re-executes specified prompt and re-validates checkpoint

**Validation:**
```bash
=== CHECKPOINT: Analysis Phase ===

Outputs Created:
✅ analysis_quote_extraction (excellent) - artifacts/quotes.yaml (12.3KB)
✅ analysis_behavioral_patterns (good) - artifacts/patterns.yaml (8.1KB)
⚠️  analysis_timeline_mapping (poor) - artifacts/timeline.yaml (1.2KB)  👈 REVIEW

⚠️ Quality Issues Detected (1):
  - analysis_timeline_mapping: Low word count (320 words, expected >500)

Checkpoint Criteria (from AIOS_WORKFLOW.md):
- All key quotes extracted
- Behavioral patterns identified
- Timeline mapped

Action: [approve/reject/retry <prompt_id>]
> retry analysis_timeline_mapping

♻️  Re-executing analysis_timeline_mapping...
✅ analysis_timeline_mapping (excellent) - artifacts/timeline.yaml (5.8KB)

All outputs now excellent/good. Proceed? [yes/no]
> yes

✅ Analysis phase approved. Proceeding to Synthesis phase...
```

---

### AC3: Dependency Resolution
**Given** a prompt has dependencies listed in `depends_on`
**When** the auto-execution engine processes it
**Then** the system:
1. Checks if all dependencies exist in `launcher-history.yaml` for this mind
2. If **missing**: warns operator, marks as `skipped` (not error), logs reason
3. If **present**: executes normally
4. Logs dependency check result in execution log

**Validation:**
```yaml
# Example: synthesis_kb_chunker depends on analysis_source_reading
- prompt_id: synthesis_kb_chunker
  status: skipped
  reason: dependency_missing
  missing_dependencies:
    - analysis_source_reading
  timestamp: '2025-10-06T15:20:00'
```

---

### AC4: Error Handling & Resilience
**Given** an API call fails (timeout, rate limit, 5xx error)
**When** the error occurs
**Then** the system:
1. Logs the error with full context (prompt_id, mind, phase, error_type)
2. Retries up to 3 times with exponential backoff (1s, 2s, 4s)
3. If still failing: marks prompt as `failed`, shows error to operator
4. Continues with remaining prompts (does not halt entire phase)
5. At checkpoint: highlights failed prompts for human review/retry

**Validation:**
```yaml
- prompt_id: analysis_behavioral_patterns
  status: failed
  error_type: api_timeout
  retry_count: 3
  last_error: "Request timeout after 120s"
  timestamp: '2025-10-06T15:45:00'
```

**Checkpoint Display:**
```
⚠️ Failed Prompts (1):
  - analysis_behavioral_patterns (api_timeout, 3 retries)

Action: [approve/reject/retry analysis_behavioral_patterns]
```

---

### AC5: Quality Scoring (Auto-Validation)
**Given** a prompt execution completes successfully
**When** output is saved to the target path
**Then** the system:
1. Runs automated quality check:
   - **Structure validation**: Valid YAML/Markdown format?
   - **Completeness**: Word count ≥ expected threshold (configurable per prompt type)
   - **Format compliance**: Expected sections/keys present?
2. Assigns quality score: `excellent` (90-100%), `good` (70-89%), `acceptable` (50-69%), `poor` (<50%)
3. Logs score and metrics in `launcher-history.yaml`
4. At checkpoint: **Highlights `poor` and `acceptable` outputs** for human review

**Validation:**
```yaml
# launcher-history.yaml - quality scoring
- prompt_id: analysis_quote_extraction
  status: completed
  quality_score: excellent
  quality_metrics:
    structure_valid: true
    word_count: 2845
    expected_sections_found: 8/8
    completeness_pct: 98
  timestamp: '2025-10-06T14:30:00'

- prompt_id: analysis_timeline_mapping
  status: completed
  quality_score: poor
  quality_metrics:
    structure_valid: true
    word_count: 320
    expected_sections_found: 2/4
    completeness_pct: 45
  quality_issues:
    - "Word count below threshold (320 < 500)"
    - "Missing sections: timeline_events, sources_timeline"
  timestamp: '2025-10-06T14:30:45'
```

---

### AC6: Context Injection
**Given** a prompt is being executed
**When** the system prepares the API call
**Then** it injects the following context (in order of priority):

1. **Mind Brief** (highest priority)
   - Path: `docs/minds/{mind}/MIND_BRIEF.md`
   - If missing: ⚠️ warning logged, continue

2. **PRD** (if exists)
   - Path: `docs/minds/{mind}/docs/PRD.md`
   - If missing: skip silently

3. **Recent Sources** (up to 5 most recent by modification time)
   - From: `docs/minds/{mind}/sources/`
   - Filter: `.md`, `.txt`, `.yaml` files
   - Sort: by `st_mtime` descending

4. **Recent Logs** (up to 3 most recent)
   - From: `docs/minds/{mind}/docs/logs/`
   - Filter: current phase or previous phase
   - Sort: by timestamp descending

5. **Previous Phase Outputs** (if applicable)
   - Example: For research phase → inject viability.yaml
   - For analysis → inject research_plan.yaml

**Validation:**
```yaml
# API Request Context (logged)
context_injected:
  mind_brief: docs/minds/nassim_taleb/MIND_BRIEF.md (2.3KB)
  prd: docs/minds/nassim_taleb/docs/PRD.md (5.1KB)
  sources:
    - sources/interviews/Naval_Podcast_2023.md (15KB)
    - sources/books/Antifragile.md (45KB)
    - sources/articles/Edge_2020.md (8KB)
  logs:
    - docs/logs/20251006-1430-icp_match.yaml
    - docs/logs/20251006-1431-temporal_coverage.yaml
  previous_phase_output:
    - docs/logs/20251006-1432-viability.yaml
total_context_size: 75.4KB
```

---

## Integration Verifications

### IV1: Backwards Compatibility with Launcher MVP
**Verification:**
- ✅ Launcher CLI (Story 1.1) continues to work for manual execution
- ✅ Auto-execution engine uses same modules (`prompt_loader`, `context_loader`, etc.)
- ✅ Same `launcher-history.yaml` format (extended with new fields)
- ✅ Manual and auto executions can be mixed (e.g., auto viability, manual research)

**Test:**
```bash
# Manual execution (Story 1.1)
python3 -m docs.mmos.launcher.cli --mind test --phase viability --prompt viability_icp_match

# Auto execution (Story 1.4)
python3 -m docs.mmos.pipeline.cli execute-phase --mind test --phase viability

# Both should log to same launcher-history.yaml
```

---

### IV2: Read-Only on Minds (No Destructive Operations)
**Verification:**
- ✅ Never modifies existing artifacts
- ✅ Only creates new outputs as specified in `prompts.yaml` output templates
- ✅ Maintains ACS v3.0 structure (sources/, artifacts/, kb/, docs/, system_prompts/, specialists/)
- ✅ Checkpoints can be rejected without data loss

**Test:**
```bash
# Before execution
ls -la docs/minds/test/artifacts/

# Run auto-execution
python3 -m docs.mmos.pipeline.cli execute-phase --mind test --phase analysis

# Reject at checkpoint
> reject

# Verify: No files deleted, only new files created in artifacts/ and docs/logs/
ls -la docs/minds/test/artifacts/
```

---

### IV3: Performance Targets (Parallel + Sequential)
**Verification:**
- ✅ Phase execution completes without hanging
- ✅ System handles API rate limits gracefully (exponential backoff, no data loss)
- ✅ Total pipeline (all 6 phases) completes in ≤5 hours (with parallel execution)
- ✅ Parallel execution achieves ≥40% time savings vs sequential

**Expected Performance (Parallel Execution):**
| Phase | Prompts | Sequential | Parallel | Savings |
|-------|---------|-----------|----------|---------|
| Viability | 5 | ~30min | ~20min | 33% |
| Research | 6 | ~60min | ~40min | 33% |
| Analysis | 18 | ~180min | ~90min | 50% |
| Synthesis | 7 | ~70min | ~45min | 36% |
| Implementation | 9 | ~90min | ~60min | 33% |
| Testing | 2 | ~20min | ~15min | 25% |
| **Total** | **47** | **~7.5h** | **~4.5h** | **40%** |

**Note**: Parallel execution happens when prompts have `parallelizable: true` and same `order`

---

## Tasks / Subtasks

- [ ] **Task 1: Implement PhaseExecutor (Sequential + Parallel)** (AC1, AC3)
  - [ ] Create `pipeline/phase_executor.py`
  - [ ] Implement `execute_phase()` main orchestration method
  - [ ] Implement dependency resolution logic (topological sort)
  - [ ] Implement **parallel execution** for `parallelizable: true` prompts (asyncio)
  - [ ] Implement **sequential execution** for dependent prompts
  - [ ] Integrate with launcher for individual prompt execution
  - [ ] Add parallel execution logging (time saved metrics)

- [ ] **Task 2: Implement CheckpointValidator (with Quality Highlights)** (AC2, AC5)
  - [ ] Create `pipeline/checkpoint_validator.py`
  - [ ] Implement checkpoint criteria loading (from AIOS_WORKFLOW.md)
  - [ ] Implement output summary display **with quality scores**
  - [ ] **Highlight poor/acceptable quality outputs** for review
  - [ ] Implement human input prompt (approve/reject/retry)
  - [ ] Implement retry logic (re-execute specific prompt)
  - [ ] Implement checkpoint logging

- [ ] **Task 3: Implement APIClient** (AC4, AC6)
  - [ ] Create `pipeline/api_client.py`
  - [ ] Implement Anthropic API integration
  - [ ] Implement context injection logic (AC6)
  - [ ] Implement retry mechanism with exponential backoff
  - [ ] Implement rate limit handling
  - [ ] Implement error logging

- [ ] **Task 4: Implement QualityChecker** (AC5)
  - [ ] Create `pipeline/quality_checker.py`
  - [ ] Implement structure validation (YAML/Markdown parsing)
  - [ ] Implement completeness check (word count, section detection)
  - [ ] Implement quality scoring algorithm (excellent/good/acceptable/poor)
  - [ ] Integrate with phase executor (auto-score after each prompt)
  - [ ] Log quality metrics to launcher-history.yaml

- [ ] **Task 5: Extend Launcher History Schema** (AC1)
  - [ ] Update `launcher_logger.py` to support auto-execution fields
  - [ ] Add `mode` field (manual/auto)
  - [ ] Add `checkpoint_status` field
  - [ ] Add `quality_score` and `quality_metrics` fields
  - [ ] Ensure backwards compatibility with Story 1.1 logs

- [ ] **Task 6: Implement Pipeline CLI** (AC1, AC2)
  - [ ] Create `pipeline/cli.py`
  - [ ] Implement `execute-phase` command
  - [ ] Implement `create-mind` command (runs all 6 phases sequentially with checkpoints)
  - [ ] Add Click framework integration
  - [ ] Add help documentation

- [ ] **Task 7: Integration Testing** (IV1, IV2, IV3)
  - [ ] Test single phase execution (viability - sequential)
  - [ ] **Test parallel execution** (analysis phase with 3 concurrent prompts)
  - [ ] Test multi-phase execution with checkpoints
  - [ ] Test retry mechanism (reject → retry → approve)
  - [ ] Test error handling (simulate API failures)
  - [ ] Test backwards compatibility with Launcher MVP
  - [ ] **Validate quality scoring** (excellent/good/poor outputs)
  - [ ] **Validate parallel time savings** (≥40% improvement)

- [ ] **Task 8: Documentation**
  - [ ] Create technical design document
  - [ ] Update AIOS_WORKFLOW.md with auto-execution guidance
  - [ ] Create operator guide for running auto-execution
  - [ ] Document CLI commands and options

---

## Dev Notes

### Configuration

**File**: `.aios/pipeline-config.yaml` (simple YAML)

```yaml
api:
  model: claude-sonnet-4-5-20250929  # Claude Code Sonnet 4.5
  max_tokens: 100000

execution:
  max_concurrent: 3
  retry_max: 3

budget:
  max_cost_per_mind: 15.0  # USD
```

**API Key**: Environment variable `ANTHROPIC_API_KEY`
- If missing: fail fast with clear error message
- Never logged

### Security

**Input Validation**:
- Mind name: alphanumeric + underscore only
- Prompt ID: must exist in prompts.yaml
- Phase name: must be valid phase (viability|research|analysis|synthesis|implementation|testing)

**No Command Injection**:
- Use launcher CLI with list args (not shell)
- Sanitize all paths

**Cost Control**:
- Stop if exceeds budget (default: $15/mind)
- Show estimate before execution

### Relevant Architecture Components

#### Existing (from Story 1.1 - Launcher)
- `launcher/prompt_loader.py` - Loads prompts.yaml and resolves templates
- `launcher/context_loader.py` - Injects context into prompts
- `launcher/launcher_logger.py` - Logs executions to launcher-history.yaml
- `launcher/cli.py` - Manual execution interface

#### New (Story 1.4)
- `pipeline/phase_executor.py` - Phase-level orchestration (sequential + parallel)
- `pipeline/checkpoint_validator.py` - Human approval gates with quality highlights
- `pipeline/api_client.py` - Anthropic API integration
- `pipeline/quality_checker.py` - Quality scoring and validation
- `pipeline/cli.py` - Auto-execution interface

### Prompts.yaml Schema (Existing)
```yaml
pipeline:
  - name: viability
    prompts:
      - id: viability_icp_match
        order: 1
        agent: analyst
        parallelizable: false
        depends_on: []
        output_template: "docs/minds/{mind}/docs/logs/{timestamp}-icp_match.yaml"
```

### Launcher History Schema Extension (v1.1)
```yaml
# Existing fields (v1.0 from Story 1.1)
- timestamp: '2025-10-06T14:30:00'
  mind: nassim_taleb
  phase: viability
  prompt_id: viability_icp_match
  agent: analyst
  status: completed
  output_path: docs/minds/nassim_taleb/docs/logs/20251006-1430-icp_match.yaml

  # NEW fields (v1.1 for Story 1.4)
  execution_mode: auto  # auto or manual
  execution_id: exec_nassim_taleb_viability_20251006_1430
  quality_score: excellent
  quality_metrics:
    structure_valid: true
    word_count: 2845
    completeness_pct: 95
  retry_count: 0
  dependencies_satisfied: true
```

### Performance Optimization Strategies
1. **Parallel Execution**: Use `asyncio` to execute parallelizable prompts concurrently
2. **Context Caching**: Cache loaded context (MIND_BRIEF, PRD) to avoid re-reading
3. **Smart Context Truncation**: If context exceeds 150K tokens, prioritize recent sources
4. **Rate Limit Awareness**: Track API usage, pause if approaching limits

### Error Scenarios to Handle
- API timeout (retry with backoff)
- API rate limit (wait and retry)
- Invalid API key (fail immediately with clear error)
- Missing dependencies (skip, log warning)
- Invalid output format (mark as poor quality, log warning)
- Checkpoint rejection (stop gracefully, preserve state)

### Test Data

**Mock prompts.yaml**:
```yaml
pipeline:
  - name: test_phase
    prompts:
      - id: test_prompt_1
        order: 1
        agent: analyst
        parallelizable: false
        depends_on: []
        output_template: "docs/minds/{mind}/docs/logs/{timestamp}-test1.yaml"
```

**Fixture mind**: `tests/fixtures/test_mind/` with MIND_BRIEF.md, sources/, docs/

### Testing Standards

#### Test File Location
- Unit tests: `tests/pipeline/test_phase_executor.py`
- Integration tests: `tests/integration/test_auto_execution.py`

#### Test Standards
- Use `pytest` framework
- Mock Anthropic API calls (don't hit live API in tests)
- Test all AC scenarios (approve, reject, retry)
- Test error handling (timeouts, failures)
- Validate performance targets with mock timings

#### Testing Frameworks
- `pytest` - test runner
- `pytest-mock` - mocking
- `pytest-asyncio` - async test support

#### Specific Testing Requirements
- **AC1**: Test both sequential and parallel execution with mock prompts
- **AC2**: Test checkpoint actions (approve/reject/retry) with quality highlights
- **AC3**: Test dependency ordering with topological sort
- **AC4**: Test retry logic with controlled failures
- **AC5**: Test quality scoring with various output qualities (excellent to poor)
- **AC6**: Test context injection (all 5 priority levels)

---

## Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-10-06 | 1.0 | Initial story creation (MVP - sequential only) | Sarah (PO Agent) |
| 2025-10-06 | 1.1 | Added config, security, test data | Sarah (PO Agent) |
| 2025-10-06 | 2.0 | **MERGED with Story 1.5** - Added parallel execution + quality scoring for simplicity | Sarah (PO Agent) |

---

## Dev Agent Record

### Agent Model Used
*To be populated during implementation*

### Debug Log References
*To be populated during implementation*

### Completion Notes
*To be populated during implementation*

### File List
*To be populated during implementation*

---

## QA Results

*To be populated after implementation and testing*

---

## Success Metrics

### Functional
- ✅ All 6 phases executable via auto-execution (sequential + parallel)
- ✅ 0 data loss incidents during execution
- ✅ Human can retry/reject at any checkpoint
- ✅ Checkpoint workflow validated with real users
- ✅ Quality scoring accuracy ≥80% (matches human assessment)

### Performance
- ✅ Full pipeline completes in ≤5 hours (with parallel execution)
- ✅ Parallel execution achieves ≥40% time savings vs sequential
- ✅ No hanging or infinite loops
- ✅ Error handling works (retry 3x, exponential backoff)

### Business
- ✅ Eliminate 47 manual prompt commands per mind
- ✅ Reduce pipeline time from days to ~4.5 hours
- ✅ Auto-flag poor quality outputs (reduce human review time)
- ✅ Enable batch creation of 5+ minds simultaneously

---

## Dependencies

### Blocking (must have before implementation)
- ✅ **Story 1.1 (Launcher MVP)** - COMPLETE (required for prompt execution)
- ⚠️ **Anthropic API key configured** - Required for live execution
- ⚠️ **Budget/quota allocated** - Estimated $3-10 per mind

### Non-Blocking (can implement in parallel)
- **Story 1.2 (Board)** - Helpful for monitoring but not required
- **Story 1.3 (Brownfield)** - Independent use case

### Enables (future stories)
- Multi-mind batch execution
- Advanced telemetry and observability
- AI-powered checkpoint validation

---

## Risks & Mitigations

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| API rate limits halt execution | High | Medium | Exponential backoff + queue system + rate limit tracking |
| Poor quality outputs propagate to next phase | Medium | High | Auto quality scoring + checkpoint validation before proceeding |
| Context exceeds 200K token limit | Medium | Medium | Smart context truncation + prioritization of recent/relevant sources |
| Parallel execution race conditions | Low | High | Proper async handling + file locking for shared resources |
| Cost overruns (47 prompts × avg 50K tokens) | Medium | Medium | Cost estimation before execution + budget alerts + configurable limits |
| Checkpoint fatigue (humans approve without reviewing) | Low | High | Clear checkpoint criteria + highlight failed/poor quality prompts |

---

## Future Enhancements (Post-1.4)

**Advanced Features**:
- AI-powered checkpoint validation (auto-approve good phases)
- Resume from failure (continue after interruption)
- Multi-mind batch execution (run 5+ minds in parallel)
- Advanced telemetry dashboard (real-time progress)
- Cost optimization (prompt caching, smart context truncation)
- Integration with Board (Story 1.2) for unified monitoring

---

## Implementation Decisions

1. **API Model**: Claude Sonnet 4.5 (claude-sonnet-4-5-20250929) - latest model
2. **Cost Budget**: $15 USD per mind (configurable)
3. **Parallelization**: Max 3 concurrent (configurable in config.yaml)
4. **Checkpoint UI**: Interactive CLI (v1.0), web dashboard later
5. **Retry Limit**: 3 retries (configurable in config.yaml)
6. **Context Size**: Hard limit 180K tokens, truncate oldest sources if exceeded

---

**Story 1.4 Status**: ✅ Ready for Implementation (Full Auto-Execution)
**Next Step**: Implement Task 1 (PhaseExecutor - Sequential + Parallel)
**Estimated Delivery**: 6-8 days

---

## Implementation Philosophy

**What's IN (Story 1.4)**:
- ✅ Intelligent execution (parallel when safe, sequential when needed)
- ✅ Dependency resolution (respect depends_on)
- ✅ Human checkpoints (approve/reject/retry)
- ✅ Quality scoring (auto-flag poor outputs)
- ✅ Error handling (retry 3x, exponential backoff)
- ✅ Context injection (reuse Story 1.1)
- ✅ Simple config (YAML)

**Philosophy**:
- Build **complete automation** that eliminates manual work
- Optimize for **speed** (40% faster via parallel execution)
- Maintain **quality** (auto-validate outputs)
- Preserve **human control** (checkpoints at critical gates)
- Keep it **simple** (no overengineering)
