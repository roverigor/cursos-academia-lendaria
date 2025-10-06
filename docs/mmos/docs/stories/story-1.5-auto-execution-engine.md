# Story 1.5: Auto-Execution Engine with Human Checkpoints

**Epic:** 1 - MMOS AIOS-first Orchestration
**Priority:** High (blocks scalability)
**Estimated Effort:** 5-8 days
**Status:** 📋 Draft (awaiting approval)

---

## User Story

*As a pipeline operator, I want an auto-execution engine that runs all prompts within each phase automatically and pauses at the 6 mandatory human checkpoints, so that I can create complete minds in 3-5 days with minimal manual intervention while maintaining quality gates.*

---

## Business Context

### Current State (with Launcher MVP)
- ✅ Launcher maps prompt→agent correctly
- ✅ Context injection working
- ✅ Logging structured
- ❌ **Still manual**: Operator runs 59 prompts one-by-one
- ❌ **Time intensive**: ~5-10 minutes per prompt = ~5-10 hours total human time

### Desired State (with Auto-Execution Engine)
- ✅ Operator runs 1 command per phase
- ✅ IA executes all prompts in phase automatically
- ✅ Human validates only at 6 checkpoints (not 59 times)
- ✅ **Total human time**: ~1-2 hours across 6 checkpoints
- ✅ **Time reduction**: 80-90% less human effort

### Value Proposition
- **Scalability**: Create 10+ minds in parallel
- **Consistency**: Same execution logic for all minds
- **Traceability**: Every AI decision logged
- **Quality**: Human validates at critical gates only

---

## Acceptance Criteria

### AC1: Phase Auto-Execution
**Given** a mind directory exists with required context
**When** operator runs `aios-pipeline execute-phase --mind <name> --phase <viability|research|analysis|synthesis|implementation|testing>`
**Then** the system:
1. Loads all prompts for that phase from `prompts.yaml`
2. Executes prompts in dependency order (respecting `depends_on`)
3. Calls Anthropic API with appropriate prompt + context for each
4. Saves outputs to correct paths (resolved templates)
5. Logs each execution to `launcher-history.yaml`
6. Handles parallelizable prompts concurrently (if marked `parallelizable: true`)
7. Stops at end of phase and displays checkpoint validation prompt

### AC2: Human Checkpoint Validation
**Given** a phase has completed execution
**When** the checkpoint validation prompt is displayed
**Then** the system:
1. Shows summary of all outputs created in this phase
2. Lists files for human to review
3. Shows checkpoint criteria (from AIOS_WORKFLOW.md)
4. Waits for human approval (`approve`, `reject`, `retry <prompt_id>`)
5. If approved: proceeds to next phase
6. If rejected: stops execution, logs rejection reason
7. If retry: re-executes specified prompt and re-validates

### AC3: Dependency Resolution
**Given** a prompt has dependencies listed in `depends_on`
**When** the auto-execution engine processes it
**Then** the system:
1. Checks if all dependencies exist in `launcher-history.yaml` for this mind
2. If missing: warns operator and marks as `skipped` (not error)
3. If present: executes normally
4. Logs dependency check result

### AC4: Error Handling & Resilience
**Given** an API call fails (timeout, rate limit, etc)
**When** the error occurs
**Then** the system:
1. Logs the error with full context
2. Retries up to 3 times with exponential backoff
3. If still failing: marks prompt as `failed`, shows error to operator
4. Continues with remaining prompts (does not halt entire phase)
5. At checkpoint: highlights failed prompts for human review

### AC5: Parallel Execution
**Given** multiple prompts in same phase with `parallelizable: true` and same `order`
**When** auto-execution reaches that order level
**Then** the system:
1. Executes all parallelizable prompts concurrently (up to 3 simultaneous)
2. Waits for all to complete before proceeding to next order level
3. Logs execution start/end for each
4. Reports total time saved via parallelization

### AC6: Context Injection
**Given** a prompt is being executed
**When** the system prepares the API call
**Then** it injects:
1. MIND_BRIEF.md (if exists, warning if missing)
2. docs/PRD.md (if exists)
3. Recent sources from sources/ (up to 5 most recent)
4. Recent logs from docs/logs/ (up to 3 most recent)
5. Previous phase outputs (e.g., viability.yaml for research phase)

### AC7: Quality Scoring (Auto-Validation)
**Given** a prompt execution completes
**When** output is saved
**Then** the system:
1. Runs a lightweight quality check (word count, structure validation)
2. Assigns a quality score: `excellent`, `good`, `acceptable`, `poor`
3. Logs score in `launcher-history.yaml`
4. At checkpoint: highlights `poor` quality outputs for human review

---

## Integration Verification

### IV1: Backwards Compatibility
- ✅ Launcher MVP (Story 1.1) continues to work for manual execution
- ✅ Auto-execution engine uses same modules (prompt_loader, context_loader, etc.)
- ✅ Same `launcher-history.yaml` format (extended with auto-execution fields)

### IV2: Read-Only on Minds
- ✅ Never modifies existing artifacts
- ✅ Only creates new outputs as specified in `prompts.yaml`
- ✅ Maintains ACS v3.0 structure

### IV3: Performance
- ✅ Phase execution completes in ≤2 hours (for phases with 10+ prompts)
- ✅ Parallelization achieves ≥40% time reduction vs sequential
- ✅ System handles rate limits gracefully (no data loss)

---

## Technical Design (High-Level)

### New Components

#### 1. `phase_executor.py`
```python
class PhaseExecutor:
    def execute_phase(self, mind: str, phase: str) -> PhaseResult:
        # Load all prompts for phase
        # Execute in dependency order
        # Handle parallelization
        # Save outputs
        # Return summary for checkpoint
```

#### 2. `checkpoint_validator.py`
```python
class CheckpointValidator:
    def validate_checkpoint(self, phase: str, outputs: List[str]) -> bool:
        # Display checkpoint criteria
        # List outputs for review
        # Prompt for human approval
        # Return approved/rejected
```

#### 3. `api_client.py`
```python
class AnthropicAPIClient:
    def execute_prompt(self, prompt_text: str, context: dict) -> str:
        # Call Anthropic API
        # Handle retries
        # Return completion
```

#### 4. `quality_checker.py`
```python
class QualityChecker:
    def check_output(self, output_path: str, expected_format: str) -> QualityScore:
        # Validate structure
        # Check completeness
        # Return score
```

### CLI Extension
```bash
# New command
aios-pipeline execute-phase --mind nassim_taleb --phase viability

# Full pipeline (all 6 phases with checkpoints)
aios-pipeline create-mind nassim_taleb
```

---

## Risks & Mitigations

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| API rate limits halt execution | High | Medium | Exponential backoff + queue system |
| Poor quality outputs propagate | Medium | High | Auto quality scoring + checkpoint validation |
| Context too large (>200K tokens) | Medium | Medium | Smart context truncation + prioritization |
| Parallel execution race conditions | Low | High | Proper async handling + locking |
| Cost overruns (59 prompts × 10K tokens) | Medium | Medium | Cost estimation before execution + budget alerts |

---

## Success Metrics

### Functional
- ✅ All 6 phases executable via auto-execution
- ✅ 0 data loss incidents
- ✅ ≥95% checkpoint approval rate (indicates quality)
- ✅ Human can retry/rollback any prompt

### Performance
- ✅ Viability phase: ≤30 min (5 prompts)
- ✅ Research phase: ≤60 min (6 prompts)
- ✅ Analysis phase: ≤90 min (18 prompts, parallelized)
- ✅ Synthesis phase: ≤45 min (7 prompts)
- ✅ Implementation phase: ≤60 min (9 prompts)
- ✅ Testing phase: ≤30 min (2 prompts)
- **Total**: ≤5 hours machine time + 1-2 hours human checkpoints

### Business
- ✅ Create 1 complete mind in 3-5 days (vs. 2-3 weeks manual)
- ✅ ≥80% reduction in human effort
- ✅ Enable parallel creation of 5+ minds simultaneously

---

## Dependencies

### Blocking (must have before implementation)
- ✅ Story 1.1 (Launcher MVP) - **COMPLETE**
- ⚠️ Anthropic API key configured
- ⚠️ Budget/quota allocated

### Non-Blocking (can implement in parallel)
- Story 1.2 (Board & Telemetria) - helpful for monitoring but not required
- Story 1.3 (Brownfield Assistant) - different use case

---

## Open Questions

1. **API Model**: Use Claude 3.5 Sonnet or Claude 3 Opus? (cost vs quality trade-off)
2. **Cost Budget**: What's acceptable cost per mind? (~$3-10 USD estimated)
3. **Parallelization Limit**: Max 3 concurrent? Or configurable?
4. **Checkpoint Mode**: Interactive CLI or dashboard UI?
5. **Retry Limit**: 3 retries per prompt or configurable?

---

## Next Steps (If Approved)

1. **@architect** (Winston): Design detailed technical architecture
2. **@dev**: Implement `phase_executor.py`, `api_client.py`
3. **@qa**: Create test plan for all 6 phases
4. **@pm** (John): Update PRD v1.5 → v1.6 with Story 1.5

---

**Author**: John (PM)
**Reviewers**: TBD
**Last Updated**: 2025-10-06

---

## Story Sequencing Decision

### Option A: Do Story 1.5 NOW (before 1.2, 1.3, 1.4)
**Pros**:
- Immediate scalability unlock
- Validates end-to-end pipeline faster
- Highest business value

**Cons**:
- No telemetry yet (harder to debug)
- No brownfield support yet

### Option B: Do Stories 1.2, 1.3, 1.4 FIRST
**Pros**:
- Build foundation (telemetry, board)
- More robust when auto-execution launches

**Cons**:
- Delays scalability
- Manual execution burden continues

**Recommendation**: **Option A** - Do Story 1.5 NOW for maximum impact, then retrofit 1.2-1.4 for enhanced observability.
