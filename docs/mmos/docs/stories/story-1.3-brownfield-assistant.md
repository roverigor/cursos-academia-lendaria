# Story 1.3: Brownfield Incremental Assistant

**Epic:** 1 - MMOS AIOS-first Orchestration
**Status:** Approved
**Priority:** High
**Estimated Effort:** 5 days

---

## User Story

*As a brownfield maintainer, I want an incremental assistant that compares sources/artifacts and suggests reexecutions, so that we can update existing minds without reprocessing the entire pipeline.*

---

## Context

Currently, the 22 existing minds have **825 lines of TODOs** and require updates when:
- New sources are discovered (interviews, books, articles)
- Gaps in temporal coverage are identified
- Inconsistencies in cognitive architecture are detected
- User feedback reveals incorrect behaviors
- New specialists need to be added

The manual brownfield process (documented in `BROWNFIELD_WORKFLOW.md`) requires:
1. Manual diff of sources vs sources_master.yaml
2. Decision of which prompts to rerun (analysis/synthesis only)
3. Manual tracking through 6-step workflow
4. Regression testing with before/after comparison
5. Rollback if consistency breaks

This is error-prone, time-consuming, and lacks the orchestration benefits that Launcher + Board provide for greenfield minds.

---

## Acceptance Criteria

### AC1: Source Diff Detection
**Given** a mind with existing `sources_master.yaml`
**When** I run `brownfield detect --mind <name>`
**Then** the tool:
- Scans `minds/<name>/sources/` for all files
- Compares with entries in `sources_master.yaml`
- Identifies:
  - ✅ New sources not in master (need processing)
  - ⚠️ Modified sources (by file size/hash)
  - ❌ Missing sources (in master but not in directory)
- Outputs diff report to `docs/logs/YYYYMMDD-HHMM-brownfield-diff.yaml`

**Validation:**
```yaml
# brownfield-diff.yaml
schema_version: '1.0'
scan_timestamp: '2025-10-06T01:00:00'
mind: nassim_taleb

new_sources:
  - path: sources/interviews/Naval_Podcast_2023.md
    type: interview
    size: 45892
    priority: high

modified_sources:
  - path: sources/books/Antifragile.md
    old_size: 123456
    new_size: 125000
    priority: medium

missing_sources:
  - path: sources/articles/Edge_2020.md
    status: not_found
```

---

### AC2: Incremental Plan Generation
**Given** a brownfield diff report
**When** I run `brownfield plan --mind <name> [--diff-file <path>]`
**Then** the tool:
- Reads diff report (or auto-detects latest)
- Analyzes which prompts need reexecution:
  - New sources → `analysis_source_reading`, `analysis_quote_extraction`, `analysis_behavioral_patterns` (targeted)
  - Modified sources → Re-analyze affected artifacts only
  - Determines synthesis impact (new KB chunks, template updates)
- Generates execution plan with:
  - List of prompts to rerun (with dependencies)
  - Estimated time
  - Risk level (low/medium/high)
  - Backup recommendation
- Outputs plan to `docs/logs/YYYYMMDD-HHMM-brownfield-plan.yaml`

**Validation:**
```yaml
# brownfield-plan.yaml
schema_version: '1.0'
plan_timestamp: '2025-10-06T01:15:00'
mind: nassim_taleb
diff_source: docs/logs/20251006-0100-brownfield-diff.yaml

update_scope:
  type: incremental
  impact: medium
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
    parallelizable: true
    estimated_duration: 180s

  - prompt_id: analysis_quote_extraction
    phase: analysis
    agent: analyst
    depends_on: [analysis_source_reading]
    reason: new_source
    parallelizable: false
    estimated_duration: 120s

  - prompt_id: synthesis_kb_chunker
    phase: synthesis
    agent: dev
    reason: new_content_available
    parallelizable: true
    estimated_duration: 90s

backup_required: true
regression_tests_required: true

pre_execution_checklist:
  - Create backup: cp -r minds/nassim_taleb minds/BACKUP_nassim_taleb_20251006
  - Read LIMITATIONS.md
  - Document baseline behavior
```

---

### AC3: BROWNFIELD_WORKFLOW.md Execution Tracking
**Given** a brownfield plan
**When** I run `brownfield execute --mind <name> --plan <path>`
**Then** the tool:
- Validates backup exists (fails if not)
- Executes each step from BROWNFIELD_WORKFLOW.md
- Records timestamp for each completed step
- Updates progress in `docs/logs/YYYYMMDD-HHMM-brownfield-execution.yaml`
- Supports resume if interrupted
- Integrates with launcher for prompt execution

**Validation:**
```yaml
# brownfield-execution.yaml
schema_version: '1.0'
execution_id: brownfield_nassim_taleb_20251006_0130
mind: nassim_taleb
plan_file: docs/logs/20251006-0115-brownfield-plan.yaml
status: in_progress

steps_completed:
  - step: backup_created
    timestamp: '2025-10-06T01:30:15'
    details: minds/BACKUP_nassim_taleb_20251006

  - step: prompt_executed
    timestamp: '2025-10-06T01:32:45'
    prompt_id: analysis_source_reading
    agent: analyst
    launcher_log_ref: launcher-history.yaml:line_156

  - step: prompt_executed
    timestamp: '2025-10-06T01:35:12'
    prompt_id: analysis_quote_extraction
    agent: analyst
    launcher_log_ref: launcher-history.yaml:line_157

steps_pending:
  - synthesis_kb_chunker
  - regression_testing
  - human_checkpoint

can_resume: true
last_checkpoint: '2025-10-06T01:35:12'
```

---

### AC4: Regression Test Orchestration
**Given** brownfield execution completed prompts
**When** I run `brownfield test --mind <name> --execution <id>`
**Then** the tool:
- Generates regression test suite from `BROWNFIELD_WORKFLOW.md` requirements
- Runs focused tests (personality consistency, knowledge retention, edge cases)
- Compares before/after responses
- Saves results to `docs/logs/YYYYMMDD-HHMM-regression-test.yaml`
- Flags regressions with severity (critical/warning/info)

**Validation:**
```yaml
# regression-test.yaml
schema_version: '1.0'
test_timestamp: '2025-10-06T02:00:00'
mind: nassim_taleb
execution_id: brownfield_nassim_taleb_20251006_0130

baseline_version:
  system_prompt: 20251001-1200-v1.1-generalista.md
  kb_chunks: 42
  last_update: '2025-10-01T12:00:00'

updated_version:
  system_prompt: 20251001-1200-v1.1-generalista.md  # unchanged
  kb_chunks: 54  # +12
  last_update: '2025-10-06T01:35:12'

tests:
  - test_id: personality_consistency_001
    category: personality
    prompt: "What's your view on randomness in markets?"
    baseline_response: "[previous response]"
    updated_response: "[new response]"
    status: pass
    similarity_score: 0.96
    notes: "Consistent tone and framework usage"

  - test_id: knowledge_retention_001
    category: knowledge
    prompt: "What's the ludic fallacy?"
    baseline_response: "[previous response]"
    updated_response: "[new response]"
    status: pass
    similarity_score: 1.0
    notes: "Exact match - no regression"

  - test_id: new_knowledge_001
    category: new_content
    prompt: "What did you say in the 2023 Naval podcast?"
    baseline_response: "[no knowledge]"
    updated_response: "[accurate response from new source]"
    status: pass
    notes: "New content successfully integrated"

summary:
  total_tests: 12
  passed: 11
  warnings: 1
  critical: 0
  recommendation: approve
```

---

### AC5: Rollback Guidance
**Given** regression tests showing failures
**When** I run `brownfield rollback --mind <name> --execution <id>`
**Then** the tool:
- Identifies backup location from execution log
- Provides step-by-step rollback instructions
- Optionally executes rollback automatically (with confirmation)
- Documents rollback reason in logs
- Preserves failed execution logs for debugging

**Validation:**
```yaml
# brownfield-rollback.yaml
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

  - action: restore_kb
    command: cp -r minds/BACKUP_nassim_taleb_20251006/kb minds/nassim_taleb/
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
  - Adjust plan and retry with different approach
```

---

### AC6: ACS v3.0 Compatibility
**Given** any brownfield operation
**When** executing on legacy minds
**Then** the tool:
- Preserves directory structure (sources/, artifacts/, kb/, docs/, system_prompts/, specialists/)
- Maintains naming conventions (snake_case, YYYYMMDD-HHMM timestamps)
- Does not modify unrelated files
- Operates on minds created before AIOS-first tooling
- Backwards compatible with manual workflow outputs

**Validation:**
- Run on alan_nicolas mind (pre-AIOS)
- Verify structure unchanged
- Verify only targeted files modified
- Verify logs written to correct locations

---

## Integration Verifications

### IV1: Updates Preserve Structure and ACS Conventions
**Verification:**
```bash
# Before brownfield
ls -la minds/nassim_taleb/
# sources/ artifacts/ kb/ docs/ system_prompts/ specialists/

# Run brownfield assistant
python3 -m docs.mmos.brownfield.cli detect --mind nassim_taleb
python3 -m docs.mmos.brownfield.cli plan --mind nassim_taleb
python3 -m docs.mmos.brownfield.cli execute --mind nassim_taleb --plan <path>

# After brownfield
ls -la minds/nassim_taleb/
# sources/ artifacts/ kb/ docs/ system_prompts/ specialists/ (unchanged structure)

# Verify naming conventions
ls minds/nassim_taleb/docs/logs/
# 20251006-0115-brownfield-plan.yaml (correct format)
```

---

### IV2: Differences Recorded with Pre/Post Comparisons
**Verification:**
```bash
# Check diff report
cat docs/logs/20251006-0100-brownfield-diff.yaml
# Contains: new_sources, modified_sources, missing_sources

# Check execution log
cat docs/logs/20251006-0130-brownfield-execution.yaml
# Contains: steps_completed with timestamps, references to launcher logs

# Check regression tests
cat docs/logs/20251006-0200-regression-test.yaml
# Contains: baseline_version, updated_version, before/after comparisons
```

---

### IV3: Brownfield Execution Does Not Increase Total Pipeline Time by >10%
**Verification:**
```bash
# Baseline: Manual brownfield update
# - Diff sources manually: 15min
# - Plan prompts manually: 20min
# - Execute prompts: 2h
# - Test manually: 30min
# Total: ~3h 5min

# With Brownfield Assistant:
# - Diff detection: <30s
# - Plan generation: <1min
# - Execute prompts: 2h (same)
# - Automated testing: <5min
# Total: ~2h 6min (32% reduction, well under +10% increase)

# Tool overhead target: <2 minutes total
# Actual overhead: ~90 seconds (diff + plan + test orchestration)
```

---

## Technical Notes

### Architecture Components

1. **DiffDetector** (`brownfield/diff_detector.py`)
   - Scans sources/ directory
   - Parses sources_master.yaml
   - Computes diffs (new/modified/missing)
   - Generates diff report

2. **PlanGenerator** (`brownfield/plan_generator.py`)
   - Reads diff report
   - Maps sources to relevant prompts (using prompts.yaml metadata)
   - Determines dependencies
   - Estimates time and risk
   - Generates execution plan

3. **WorkflowExecutor** (`brownfield/workflow_executor.py`)
   - Validates prerequisites (backup, docs read)
   - Executes BROWNFIELD_WORKFLOW.md steps
   - Integrates with launcher for prompt execution
   - Tracks progress with checkpoints
   - Supports resume

4. **RegressionTester** (`brownfield/regression_tester.py`)
   - Defines test suite (personality, knowledge, edge cases)
   - Executes tests (via AIOS agents or automated)
   - Compares baseline vs updated responses
   - Generates test report with recommendations

5. **RollbackManager** (`brownfield/rollback_manager.py`)
   - Locates backup from execution log
   - Generates rollback commands
   - Executes rollback (with confirmation)
   - Preserves logs for post-mortem

6. **CLI** (`brownfield/cli.py`)
   - Commands: `detect`, `plan`, `execute`, `test`, `rollback`, `status`
   - Integration with launcher and board

### Data Flow

```
sources/ (new files)
    ↓
DiffDetector → brownfield-diff.yaml
    ↓
PlanGenerator → brownfield-plan.yaml
    ↓
WorkflowExecutor → brownfield-execution.yaml
    ↓                    ↓
    ↓              launcher-history.yaml (via launcher)
    ↓
RegressionTester → regression-test.yaml
    ↓
[Pass] → Complete
[Fail] → RollbackManager → brownfield-rollback.yaml
```

### Performance Targets

- Diff detection: <30s for 100 sources
- Plan generation: <1min for any scope
- Execution tracking: <100ms overhead per prompt
- Regression testing: <5min for standard suite (12 tests)
- Rollback: <2min for full restore

### Integration Points

- **Launcher**: Execute prompts from plan using launcher CLI
- **Board**: View brownfield execution status alongside greenfield minds
- **Prompts.yaml**: Metadata about which prompts apply to which artifacts
- **BROWNFIELD_WORKFLOW.md**: Source of truth for workflow steps

---

## Success Metrics

1. **Time Savings**: Brownfield updates 30-40% faster than manual workflow
2. **Error Reduction**: 95% fewer missed steps (automated checklist)
3. **Rollback Rate**: <5% of brownfield updates require rollback
4. **Coverage**: 100% of 22 existing minds can use brownfield assistant
5. **Adoption**: 90% of brownfield updates use assistant within 1 month

---

## Dependencies

- **Story 1.1 (Launcher)**: Required for prompt execution
- **Story 1.2 (Board)**: Optional, for unified visibility
- **prompts.yaml**: Required for prompt metadata
- **BROWNFIELD_WORKFLOW.md**: Required for workflow definition

---

## Non-Goals (Out of Scope)

- ❌ Automatic decision to approve/reject (human checkpoint required)
- ❌ Automatic source collection (only detection/recommendation)
- ❌ Full pipeline reprocessing (greenfield only)
- ❌ System prompt generation (only recommendations)
- ❌ Specialist creation (future story)

---

## Risks and Mitigations

### Risk 1: Diff detection fails on legacy minds
**Mitigation**: Fallback to manual mode if sources_master.yaml missing/malformed

### Risk 2: Regression tests are too brittle
**Mitigation**: Use similarity scoring (not exact match), human review required

### Risk 3: Rollback corrupts data
**Mitigation**: Dry-run mode, confirmation prompts, backup verification before rollback

### Risk 4: Plan generator recommends wrong prompts
**Mitigation**: Human review of plan before execution, conservative recommendations

---

## Future Enhancements (Post-v1)

- AI-powered diff analysis (detect semantic changes, not just file changes)
- Integration with Board for live brownfield progress tracking
- Automated regression test generation based on mind personality
- Brownfield templates for common update patterns
- Multi-mind brownfield updates (batch processing)

---

## Appendix: Example Session

```bash
# 1. Detect changes
python3 -m docs.mmos.brownfield.cli detect --mind nassim_taleb
# Output: Found 2 new sources, 1 modified
# Saved to: docs/logs/20251006-0100-brownfield-diff.yaml

# 2. Generate plan
python3 -m docs.mmos.brownfield.cli plan --mind nassim_taleb
# Output: Plan generated with 5 prompts to rerun
# Estimated time: 2-3 hours
# Saved to: docs/logs/20251006-0115-brownfield-plan.yaml

# 3. Review plan (human decision)
cat docs/logs/20251006-0115-brownfield-plan.yaml

# 4. Execute (after creating backup)
cp -r minds/nassim_taleb minds/BACKUP_nassim_taleb_20251006
python3 -m docs.mmos.brownfield.cli execute --mind nassim_taleb --plan docs/logs/20251006-0115-brownfield-plan.yaml
# Output: Executing 5 prompts... (uses launcher internally)
# Saved to: docs/logs/20251006-0130-brownfield-execution.yaml

# 5. Run regression tests
python3 -m docs.mmos.brownfield.cli test --mind nassim_taleb
# Output: 11/12 tests passed, 1 warning
# Saved to: docs/logs/20251006-0200-regression-test.yaml

# 6. Review results
cat docs/logs/20251006-0200-regression-test.yaml

# 7a. If approved: Complete
python3 -m docs.mmos.brownfield.cli complete --mind nassim_taleb --execution brownfield_nassim_taleb_20251006_0130
# Output: Brownfield update complete, backup archived

# 7b. If rejected: Rollback
python3 -m docs.mmos.brownfield.cli rollback --mind nassim_taleb --execution brownfield_nassim_taleb_20251006_0130
# Output: Rolled back to backup, logs preserved
```

---

**Story 1.3 Status**: Ready for Implementation
**Next Step**: Technical Design Document
