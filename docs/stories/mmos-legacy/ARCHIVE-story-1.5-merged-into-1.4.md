# ⚠️ ARCHIVED: Story 1.5 (Merged into Story 1.4)

**Archive Date:** 2025-10-06
**Reason:** Merged with Story 1.4 for simplicity ("simplicidade sempre")
**Decision:** Splitting into MVP + Full added unnecessary overhead
**New Story:** See `story-1.4-auto-execution-engine.md` v2.0 (merged version)

---

# Story 1.5: Auto-Execution Full (Parallel + Quality Scoring)

**Epic:** 1 - MMOS AIOS-first Orchestration
**Priority:** High (performance optimization)
**Estimated Effort:** 3-4 days
**Status:** ❌ MERGED INTO 1.4 (v2.0)
**Depends On:** ~~Story 1.4 (Auto-Execution MVP)~~ N/A - merged

---

## User Story

*As a pipeline operator, I want parallel execution and quality scoring added to the auto-execution engine (Story 1.4), so that I can reduce pipeline time from ~8h to ~4.5h (40% faster) while maintaining quality gates with automated validation.*

---

## Business Context

### Current State (with Story 1.4 MVP)
- ✅ Auto-execution working (sequential)
- ✅ Checkpoints validated (approve/reject/retry)
- ✅ Manual intervention eliminated (47 commands → 6 checkpoints)
- ⚠️ **Sequential execution**: Full pipeline takes ~7.5 hours
- ⚠️ **No quality automation**: Human must review all outputs manually

### Desired State (Story 1.5 - Full)
- ✅ **Parallel execution**: Up to 3 prompts concurrent
- ✅ **Quality scoring**: Auto-flag poor outputs at checkpoints
- ✅ **40% faster**: ~7.5h → ~4.5h pipeline time
- ✅ **Smarter checkpoints**: Highlight what needs review

### What Story 1.5 Adds (on top of 1.4)
1. **Parallel Execution** (AC5 from old 1.5)
   - Execute parallelizable prompts concurrently
   - 40% time reduction

2. **Quality Scoring** (AC7 from old 1.5)
   - Auto-validate outputs (excellent/good/acceptable/poor)
   - Highlight poor quality at checkpoints

### Value Proposition (Incremental)
- **Performance**: 40% faster pipeline (8h → 4.5h)
- **Quality**: Automated output validation
- **Focus**: Human reviews only flagged outputs

---

## Acceptance Criteria (Enhancements to Story 1.4)

**Given** Story 1.4 provides sequential execution
**When** prompts in same order have `parallelizable: true`
**Then** the system (enhanced from 1.4):
1. Executes parallelizable prompts **concurrently** (up to 3 simultaneous)
2. Waits for all to complete before next order level
3. Logs execution start/end for each
4. Reports time saved vs sequential

**Validation:**
```
[Phase: Analysis] Order 2 (3 parallelizable prompts)
  ⏳ analysis_quote_extraction (started 14:30:15)
  ⏳ analysis_behavioral_patterns (started 14:30:15)
  ⏳ analysis_timeline_mapping (started 14:30:15)
  ✅ analysis_quote_extraction (45s)
  ✅ analysis_timeline_mapping (52s)
  ✅ analysis_behavioral_patterns (58s)
Time saved: ~1.5min (sequential: 155s, parallel: 58s)
```

**Given** a prompt execution completes
**When** output is saved
**Then** the system (enhanced from 1.4):
1. Runs quality check:
   - Structure validation (valid YAML/Markdown?)
   - Completeness (word count ≥ threshold)
   - Format compliance (expected sections/keys?)
2. Assigns score: `excellent` (90-100%), `good` (70-89%), `acceptable` (50-69%), `poor` (<50%)
3. Logs score in launcher-history.yaml
4. **At checkpoint**: Highlights `poor` outputs for review

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
