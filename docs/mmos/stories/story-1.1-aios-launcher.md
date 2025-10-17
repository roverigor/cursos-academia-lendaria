# Story 1.1: AIOS Launcher v1

**Story ID:** MMOS-1.1
**Epic:** Epic 1 - MMOS AIOS-first Orchestration
**Priority:** High
**Status:** Ready for Development
**Estimate:** 3-4 days
**Owner:** TBD
**Created:** October 12, 2025

---

## User Story

**As a** pipeline operator
**I want** a launcher AIOS that maps prompt→agent and injects automatic context for each MMOS execution
**So that** orchestration occurs with zero manual friction and standardized logging

---

## Business Value

### Problem Statement

Currently, pipeline execution is manual and dispersed:
- Operators manually consult AIOS agents ad-hoc
- Prompts are copied manually without context injection
- Outputs are registered manually in ACS directories
- No standardized logging or traceability
- Average preparation time per prompt: ~15-20 minutes

### Impact

- **Time Savings**: Reduce prompt preparation from 15-20min to <5min (≥60% reduction)
- **Quality Improvement**: Standardized context injection ensures consistent agent inputs
- **Traceability**: 100% logging of all prompt executions with timestamps and agents
- **Onboarding**: New operators can execute prompts with minimal training

### Success Metrics

- Average preparation time per prompt: <5 minutes (target: 3 minutes)
- Zero manual context lookup required
- 100% logging compliance
- Operator satisfaction: 8+/10

---

## Acceptance Criteria

### AC1: CLI/Terminal Accepts Execution Parameters
```bash
# Command structure
mmos-launcher execute \
  --mind <mind_name> \
  --stage <phase> \
  --prompt <prompt_id> \
  [--agent <agent_override>]

# Example
mmos-launcher execute \
  --mind sam_altman \
  --stage analysis \
  --prompt analysis_core_obsessions
```

**Verification:**
- [ ] Command accepts `mind_name`, `stage`, `prompt_id` parameters
- [ ] Validates mind exists in `/minds/` directory
- [ ] Validates stage is valid (viability, research, analysis, synthesis, implementation, testing)
- [ ] Validates prompt exists in `/docs/mmos/prompts/`
- [ ] Identifies corresponding agent from `prompts.yaml` mapping
- [ ] Allows optional agent override for testing

### AC2: Displays Summarized Context Before Agent Call

**Context Injection:**
```yaml
context_summary:
  mind:
    name: "Sam Altman"
    status: "analysis" # Current pipeline phase
    apex_score: 8.5
    icp_match: "high"

  prompt:
    id: "analysis_core_obsessions"
    title: "Core Obsessions"
    phase: "analysis"
    agent: "analyst"
    dependencies: ["analysis_belief_system", "analysis_values_hierarchy"]

  relevant_sources:
    count: 12
    priority_sources:
      - "lex-fridman-419-gpt5-board-saga-agi"
      - "congressional-testimony-2023-05-16"
      - "sam-altman-blog-moores-law-ai"

  recent_artifacts:
    - "beliefs_core.yaml" (created: 2025-10-10)
    - "values_hierarchy.yaml" (created: 2025-10-10)

  checkpoints:
    pending: ["Layer 6 validation", "Layer 7 validation"]

  output_destination:
    path: "outputs/minds/sam_altman/artifacts/core_obsessions.yaml"
    suggested_filename: "20251012-1430-core-obsessions.yaml"
```

**Verification:**
- [ ] Displays mind metadata (name, status, APEX, ICP)
- [ ] Shows prompt details (ID, title, phase, assigned agent)
- [ ] Lists relevant sources (top 3-5 priority sources)
- [ ] Shows recent artifacts from dependent prompts
- [ ] Highlights pending checkpoints
- [ ] Suggests official output destination
- [ ] Pauses for user confirmation before agent call

### AC3: Suggests Official Output Destination

**Output Path Rules:**
```yaml
output_paths:
  viability:
    - "outputs/minds/{mind}/docs/logs/{timestamp}-viability.yaml"
    - "outputs/minds/{mind}/docs/logs/{timestamp}-icp_match.yaml"
    - "outputs/minds/{mind}/docs/PRD.md"

  research:
    - "outputs/minds/{mind}/sources/sources_master.yaml"
    - "outputs/minds/{mind}/metadata/temporal_context.yaml"
    - "outputs/minds/{mind}/kb/qa_dataset_{topic}.jsonl"

  analysis:
    - "outputs/minds/{mind}/artifacts/quotes_database.yaml" (Layer 1)
    - "outputs/minds/{mind}/artifacts/writing_style.md" (Layer 2)
    - "outputs/minds/{mind}/artifacts/behavioral_patterns.md" (Layer 3)
    - "outputs/minds/{mind}/artifacts/values_hierarchy.yaml" (Layer 4)
    - "outputs/minds/{mind}/artifacts/beliefs_core.yaml" (Layer 5)
    - "outputs/minds/{mind}/artifacts/mental_models.md" (Layer 6)
    - "outputs/minds/{mind}/artifacts/unique_algorithm.yaml" (Layer 7)
    - "outputs/minds/{mind}/artifacts/contradictions.yaml" (Layer 8)

  synthesis:
    - "outputs/minds/{mind}/artifacts/communication_templates.md"
    - "outputs/minds/{mind}/artifacts/signature_phrases.md"
    - "outputs/minds/{mind}/kb/chunk_{index}.md"

  implementation:
    - "outputs/minds/{mind}/system_prompts/{timestamp}-v{version}-generalista.md"
    - "outputs/minds/{mind}/specialists/{specialist}/system_prompts/{timestamp}-v{version}.md"

  testing:
    - "outputs/minds/{mind}/docs/logs/{timestamp}-test_cases.yaml"
    - "outputs/minds/{mind}/docs/logs/{timestamp}-personality_validation.md"
```

**Verification:**
- [ ] Suggests correct path based on prompt phase and type
- [ ] Includes timestamp in format `YYYYMMDD-HHMM`
- [ ] Follows ACS v3.0 structure
- [ ] Creates directory if it doesn't exist
- [ ] Guides user to save output in suggested location
- [ ] Validates output was saved before marking complete

### AC4: Registers Invocation Log

**Log Entry Format:**
```yaml
# File: docs/mmos/logs/launcher-history.yaml
invocations:
  - id: "inv-001"
    timestamp: "2025-10-12T14:30:00Z"
    mind: "sam_altman"
    prompt_id: "analysis_core_obsessions"
    prompt_title: "Core Obsessions"
    phase: "analysis"
    agent: "analyst"
    user: "operator_name"
    context_injected:
      sources_count: 12
      dependencies_met: true
      checkpoint_pending: false
    output:
      path: "outputs/minds/sam_altman/artifacts/core_obsessions.yaml"
      saved: true
      verified: true
    duration_seconds: 420
    status: "completed"
    notes: "Layer 6 analysis completed, evidence triangulated from 3 sources"
```

**Verification:**
- [ ] Creates log entry with unique ID
- [ ] Records timestamp (ISO8601 format)
- [ ] Logs mind name and prompt details
- [ ] Records agent used (actual, not just suggested)
- [ ] Logs authenticated user (if available)
- [ ] Records context summary (sources, dependencies, checkpoints)
- [ ] Logs output path and verification status
- [ ] Records duration (start → completion)
- [ ] Captures final status (completed, failed, aborted)
- [ ] Allows optional notes field

### AC5: Supports Multiple Concurrent Launches

**Concurrent Execution Requirements:**
```yaml
concurrency:
  max_parallel_launches: 5
  lock_mechanism: "file-based" # .lock files per mind
  temp_file_strategy: "uuid-based" # Unique temp files

  example:
    mind: "sam_altman"
    concurrent_prompts:
      - "analysis_linguistic_forensics" (Agent: analyst, Temp: /tmp/launcher-uuid1.tmp)
      - "analysis_behavioral_patterns" (Agent: analyst, Temp: /tmp/launcher-uuid2.tmp)
      - "analysis_recognition_patterns" (Agent: analyst, Temp: /tmp/launcher-uuid3.tmp)
```

**Verification:**
- [ ] Supports up to 5 concurrent launcher instances
- [ ] No temp file collisions (UUID-based naming)
- [ ] No log entry collisions (atomic writes with file locking)
- [ ] No output path collisions (validates uniqueness)
- [ ] Clear error messages if concurrency limit exceeded
- [ ] Graceful degradation if file locks fail

### AC6: Maintains Naming Conventions and ACS Structure

**Convention Compliance:**
```yaml
naming_conventions:
  files:
    - snake_case for all filenames ✅
    - timestamps: YYYYMMDD-HHMM ✅
    - no spaces in filenames ✅
    - extensions: .md, .yaml, .json, .jsonl (NEVER .txt) ✅

  directories:
    - snake_case for all directories ✅
    - plural nouns (sources/, artifacts/, specialists/) ✅

  acs_structure:
    - sources/ (research materials) ✅
    - artifacts/ (FLAT - analysis outputs) ✅
    - kb/ (FLAT - knowledge base chunks) ✅
    - docs/ (PRD, README, logs/) ✅
    - system_prompts/ (versioned prompts) ✅
    - specialists/ (domain-specific prompts) ✅
```

**Verification:**
- [ ] All generated files use snake_case
- [ ] All timestamps use YYYYMMDD-HHMM format
- [ ] No .txt files created (only .md, .yaml, .json, .jsonl)
- [ ] Respects ACS v3.0 structure (sources/, artifacts/, kb/, docs/, system_prompts/, specialists/)
- [ ] Never modifies existing file structure
- [ ] Creates missing directories following conventions

---

## Integration Verification

### IV1: Launcher Reads Existing Files Without Modifying Them

**Non-Invasive Reading:**
```bash
# Files read (read-only):
- /docs/mmos/prompts.yaml (prompt→agent mapping)
- /outputs/minds/{mind}/metadata.yaml (mind metadata - Epic 3)
- /outputs/minds/{mind}/docs/PRD.md (requirements context)
- /outputs/minds/{mind}/sources/sources_master.yaml (available sources)
- /outputs/minds/{mind}/artifacts/* (dependency artifacts)
- /docs/mmos/logs/launcher-history.yaml (execution history)

# Verification:
- File modification timestamps unchanged ✅
- File contents unchanged (hash verification) ✅
- No accidental overwrites ✅
```

**Test:**
```bash
# Before launcher execution
find /outputs/minds/sam_altman -type f -exec md5sum {} \; > checksums_before.txt

# Execute launcher
mmos-launcher execute --mind sam_altman --stage analysis --prompt analysis_core_obsessions

# After launcher execution
find /outputs/minds/sam_altman -type f -exec md5sum {} \; > checksums_after.txt

# Verify only NEW files created (no modifications to existing files)
diff checksums_before.txt checksums_after.txt
```

### IV2: New Logs Written Without Overwriting Previous Records

**Append-Only Logging:**
```yaml
# launcher-history.yaml structure
schema_version: "1.1"
invocations: [] # APPEND-ONLY array

# Write strategy:
1. Read existing launcher-history.yaml
2. Parse YAML
3. Append new invocation to array
4. Write back (atomic operation with file locking)
5. Verify write succeeded

# Never:
- Truncate file ❌
- Replace entire file without reading first ❌
- Modify existing invocation entries ❌
```

**Test:**
```bash
# Count invocations before
BEFORE=$(yq '.invocations | length' docs/mmos/logs/launcher-history.yaml)

# Execute launcher
mmos-launcher execute --mind sam_altman --stage analysis --prompt analysis_core_obsessions

# Count invocations after
AFTER=$(yq '.invocations | length' docs/mmos/logs/launcher-history.yaml)

# Verify exactly 1 new entry
[ $((AFTER - BEFORE)) -eq 1 ] && echo "✅ PASS" || echo "❌ FAIL"
```

### IV3: Average Preparation Time Reduced ≥30% vs Manual Execution

**Baseline (Manual Execution):**
```
Manual steps:
1. Find prompt file (2 min)
2. Read prompt requirements (3 min)
3. Locate relevant sources (5 min)
4. Check dependencies (2 min)
5. Find output destination (1 min)
6. Identify correct agent (1 min)
7. Manually invoke agent (1 min)
Total: ~15 minutes
```

**Target (Launcher Execution):**
```
Launcher steps:
1. Run command (10 sec)
2. Review context summary (2 min)
3. Confirm and execute (10 sec)
4. Save output to suggested path (1 min)
Total: ~4 minutes

Reduction: (15-4)/15 = 73% ✅ (exceeds 30% target)
```

**Measurement:**
```yaml
# Track for 10 prompt executions
test_executions:
  - prompt: "analysis_core_obsessions"
    manual_time: 16 min
    launcher_time: 4 min
    reduction: 75%

  - prompt: "analysis_linguistic_forensics"
    manual_time: 14 min
    launcher_time: 3 min
    reduction: 79%

  # ... 8 more tests

  average_manual_time: 15.2 min
  average_launcher_time: 3.8 min
  average_reduction: 75% ✅
```

---

## Technical Design

### Architecture

```
┌─────────────────────────────────────────────────┐
│           MMOS LAUNCHER CLI                      │
├─────────────────────────────────────────────────┤
│                                                  │
│  ┌──────────────┐       ┌──────────────┐        │
│  │   Parser     │──────▶│  Validator   │        │
│  │ (args/flags) │       │ (mind/prompt)│        │
│  └──────────────┘       └──────────────┘        │
│         │                       │                │
│         ▼                       ▼                │
│  ┌──────────────────────────────────┐           │
│  │     Context Injector             │           │
│  │  - Load mind metadata            │           │
│  │  - Find relevant sources         │           │
│  │  - Check dependencies            │           │
│  │  - Suggest output path           │           │
│  └──────────────────────────────────┘           │
│         │                                         │
│         ▼                                         │
│  ┌──────────────────────────────────┐           │
│  │     Agent Invoker                │           │
│  │  - Map prompt → agent            │           │
│  │  - Display context summary       │           │
│  │  - Await user confirmation       │           │
│  │  - Execute agent call            │           │
│  └──────────────────────────────────┘           │
│         │                                         │
│         ▼                                         │
│  ┌──────────────────────────────────┐           │
│  │     Logger                       │           │
│  │  - Generate invocation log       │           │
│  │  - Append to launcher-history    │           │
│  │  - Verify output saved           │           │
│  └──────────────────────────────────┘           │
│                                                  │
└─────────────────────────────────────────────────┘
```

### Data Flow

```
1. USER INPUT:
   mmos-launcher execute --mind sam_altman --stage analysis --prompt analysis_core_obsessions

2. PARSING & VALIDATION:
   ✓ mind=sam_altman → /outputs/minds/sam_altman exists
   ✓ stage=analysis → valid phase
   ✓ prompt=analysis_core_obsessions → /docs/mmos/prompts/analysis_core_obsessions.md exists

3. PROMPT → AGENT MAPPING:
   Read /docs/mmos/prompts.yaml:
     - analysis_core_obsessions → agent: analyst ✓

4. CONTEXT INJECTION:
   Load:
   - /outputs/minds/sam_altman/metadata.yaml (APEX, ICP, status)
   - /outputs/minds/sam_altman/sources/sources_master.yaml (12 sources)
   - /outputs/minds/sam_altman/artifacts/beliefs_core.yaml (dependency)
   - /outputs/minds/sam_altman/artifacts/values_hierarchy.yaml (dependency)

   Generate context summary → Display to user

5. USER CONFIRMATION:
   [y/N] Execute analysis_core_obsessions with analyst agent? y

6. AGENT EXECUTION:
   (User manually interacts with agent in AIOS)
   Agent produces output → user saves to suggested path

7. LOGGING:
   Append to /docs/mmos/logs/launcher-history.yaml:
     - timestamp, mind, prompt, agent, output_path, duration, status

8. COMPLETION:
   ✓ Invocation logged
   ✓ Output verified at: outputs/minds/sam_altman/artifacts/core_obsessions.yaml
```

### File Structure

```
scripts/
└── launcher/
    ├── mmos-launcher.sh               # Main CLI entry point
    ├── lib/
    │   ├── parser.sh                  # Argument parsing
    │   ├── validator.sh               # Input validation
    │   ├── context_injector.sh        # Context loading & summarization
    │   ├── agent_invoker.sh           # Agent mapping & execution
    │   ├── logger.sh                  # Invocation logging
    │   └── utils.sh                   # Common utilities
    └── config/
        ├── prompts_mapping.yaml       # Symlink to /docs/mmos/prompts.yaml
        └── output_paths_template.yaml # Output path rules

docs/mmos/logs/
└── launcher-history.yaml              # Execution log (append-only)
```

---

## Implementation Plan

### Phase 1: Core Infrastructure (Day 1)

**Tasks:**
1. Create launcher script structure
2. Implement argument parser
3. Implement validators (mind exists, stage valid, prompt exists)
4. Test with sample inputs

**Deliverables:**
- `mmos-launcher.sh` accepts arguments
- Validation works for valid/invalid inputs

### Phase 2: Context Injection (Day 1-2)

**Tasks:**
1. Implement mind metadata loader
2. Implement sources loader (read sources_master.yaml)
3. Implement dependency checker (read artifact files)
4. Implement output path suggester
5. Format context summary display

**Deliverables:**
- Context summary displays all required information
- Output path suggestions follow conventions

### Phase 3: Agent Mapping & Execution (Day 2)

**Tasks:**
1. Load prompts.yaml
2. Map prompt_id → agent
3. Display context summary
4. Prompt user confirmation
5. Guide agent execution (instructions to user)

**Deliverables:**
- Correct agent identified for each prompt
- User can execute agent with full context

### Phase 4: Logging System (Day 2-3)

**Tasks:**
1. Design invocation log schema
2. Implement append-only logger
3. Add file locking for concurrent writes
4. Implement output verification
5. Test concurrent executions

**Deliverables:**
- launcher-history.yaml populated correctly
- Concurrent executions don't collide
- Logs are append-only (never overwrite)

### Phase 5: Testing & Validation (Day 3-4)

**Tasks:**
1. Test all 59 prompts (sampling)
2. Test concurrent executions (up to 5 parallel)
3. Verify no existing files modified
4. Verify naming conventions followed
5. Measure time savings vs manual execution

**Deliverables:**
- All acceptance criteria pass
- All integration verifications pass
- Performance target met (≥30% time reduction)

---

## Testing Strategy

### Unit Tests

```bash
# Test 1: Argument parsing
./mmos-launcher.sh execute --mind sam_altman --stage analysis --prompt analysis_core_obsessions
# Expected: Arguments parsed correctly

# Test 2: Mind validation (invalid mind)
./mmos-launcher.sh execute --mind invalid_mind --stage analysis --prompt analysis_core_obsessions
# Expected: Error "Mind 'invalid_mind' not found"

# Test 3: Stage validation (invalid stage)
./mmos-launcher.sh execute --mind sam_altman --stage invalid_stage --prompt analysis_core_obsessions
# Expected: Error "Invalid stage 'invalid_stage'"

# Test 4: Prompt validation (invalid prompt)
./mmos-launcher.sh execute --mind sam_altman --stage analysis --prompt invalid_prompt
# Expected: Error "Prompt 'invalid_prompt' not found"

# Test 5: Agent mapping
./mmos-launcher.sh execute --mind sam_altman --stage analysis --prompt analysis_core_obsessions
# Expected: Identifies agent as "analyst"
```

### Integration Tests

```bash
# Test 6: Full execution (happy path)
./mmos-launcher.sh execute --mind sam_altman --stage analysis --prompt analysis_core_obsessions
# Expected:
# 1. Context summary displayed
# 2. User confirms
# 3. Agent instructions shown
# 4. Output saved
# 5. Log entry created

# Test 7: Concurrent executions (3 parallel)
./mmos-launcher.sh execute --mind sam_altman --stage analysis --prompt analysis_linguistic_forensics &
./mmos-launcher.sh execute --mind sam_altman --stage analysis --prompt analysis_behavioral_patterns &
./mmos-launcher.sh execute --mind sam_altman --stage analysis --prompt analysis_recognition_patterns &
wait
# Expected: All 3 complete without collisions

# Test 8: File integrity check
# Before: md5sum all files
# Execute: launcher
# After: md5sum all files
# Expected: Only NEW files created (no modifications to existing)

# Test 9: Log append verification
# Count entries before
# Execute launcher
# Count entries after
# Expected: Exactly 1 new entry
```

### Performance Tests

```bash
# Test 10: Time measurement
time ./mmos-launcher.sh execute --mind sam_altman --stage analysis --prompt analysis_core_obsessions
# Expected: <5 minutes total (including user interaction)

# Test 11: Comparison with manual execution
# Manual: 15 minutes average
# Launcher: <5 minutes average
# Expected: ≥60% time reduction
```

---

## Dependencies

### Prerequisites

- ✅ `/docs/mmos/prompts.yaml` exists (59 prompts with agent mappings)
- ✅ `/outputs/minds/{mind}/` directories exist for all minds
- ✅ AIOS agents are available (@analyst, @architect, @pm, @qa, @dev)
- ⚠️ `/outputs/minds/{mind}/metadata.yaml` (Epic 3 Story 3.1 - can work without it initially)

### Blocked By

- None (can start immediately)

### Blocks

- Story 1.2 (Orchestration Board) - needs launcher-history.yaml logs
- Story 1.3 (Brownfield Assistant) - uses launcher for reexecution

---

## Risks & Mitigation

### Risk 1: Concurrent Write Conflicts
- **Risk**: Multiple launchers writing to launcher-history.yaml simultaneously
- **Impact**: Log corruption or lost entries
- **Probability**: Medium
- **Mitigation**:
  - Implement file locking (flock)
  - Atomic writes (write to temp, then move)
  - Retry logic with exponential backoff

### Risk 2: Missing Dependencies
- **Risk**: Prompt depends on artifacts that don't exist yet
- **Impact**: Incomplete context injection
- **Probability**: Low
- **Mitigation**:
  - Check if dependency artifacts exist
  - Warn user if dependencies missing
  - Allow proceeding with warning (non-blocking)

### Risk 3: Agent Mapping Errors
- **Risk**: prompts.yaml has incorrect agent mappings
- **Impact**: Wrong agent invoked
- **Probability**: Low
- **Mitigation**:
  - Manual review of prompts.yaml before launch
  - Allow agent override flag (--agent)
  - Log actual agent used (not just suggested)

### Risk 4: Output Path Conflicts
- **Risk**: Two executions try to save to same path
- **Impact**: File overwrite
- **Probability**: Low
- **Mitigation**:
  - Include timestamp in filename (YYYYMMDD-HHMM)
  - Add sequential suffix if file exists (e.g., -v2)
  - Warn user before overwriting

---

## Future Enhancements (Out of Scope)

1. **Auto-execution**: Launcher automatically invokes agent (not just guides user)
2. **Parallel orchestration**: Launcher identifies parallelizable prompts and executes in batch
3. **Checkpoint automation**: Launcher validates checkpoints automatically
4. **Web UI**: Browser-based launcher interface
5. **Rollback**: Launcher can rollback failed executions

---

## Definition of Done

- [ ] All acceptance criteria (AC1-AC6) pass
- [ ] All integration verifications (IV1-IV3) pass
- [ ] Unit tests pass (10/10)
- [ ] Integration tests pass (11/11)
- [ ] Performance test passes (≥60% time reduction)
- [ ] Code reviewed and approved
- [ ] Documentation updated (`AIOS_WORKFLOW.md`, `README.md`)
- [ ] Tested with 5+ different prompts across all phases
- [ ] Concurrent execution tested (3-5 parallel)
- [ ] Deployed to production (available in PATH)
- [ ] Operator training completed

---

## References

- **PRD**: `/docs/prd/mmos-prd.md` Section 4, Story 1.1
- **Epic 1**: `/docs/mmos/epics/epic-1-aios-orchestration.md`
- **Prompts Registry**: `/docs/mmos/prompts.yaml` (59 prompts)
- **ACS v3.0 Spec**: `/docs/mmos/docs/ACS_V3_SPEC.md`

---

**Story Created:** October 12, 2025
**Last Updated:** October 12, 2025
**Next Story:** Story 1.2 - Orchestration Board & Telemetria
