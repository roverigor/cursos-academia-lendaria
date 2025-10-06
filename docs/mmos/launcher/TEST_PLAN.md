# AIOS Launcher - Test Plan

## Test Environment Setup

```bash
source docs/mmos/launcher/.venv/bin/activate
```

## Test Suite

### 1. Basic Functionality Tests

#### 1.1 Valid Prompt Execution
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_scorecard_apex \
  --dry-run
```
**Expected**: ✅ Displays prompt info, no errors

#### 1.2 Show Context Flag
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_mental_models \
  --show-context \
  --dry-run
```
**Expected**: ✅ Displays context loading status (MIND_BRIEF, PRD, sources)

#### 1.3 Show Dependencies Flag
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_mental_models \
  --show-deps \
  --dry-run
```
**Expected**: ✅ Displays dependency check results (warnings for missing deps)

#### 1.4 All Flags Combined
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase synthesis \
  --prompt synthesis_extract_core \
  --show-context \
  --show-deps \
  --dry-run
```
**Expected**: ✅ Displays all information correctly

### 2. Error Handling Tests

#### 2.1 Invalid Prompt ID
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt invalid_prompt_123 \
  --dry-run
```
**Expected**: ❌ Error message with suggestions

#### 2.2 Wrong Phase for Prompt
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase synthesis \
  --prompt analysis_mental_models \
  --dry-run
```
**Expected**: ⚠️ Warning but continues (prompt belongs to different phase)

#### 2.3 Non-existent Mind
```bash
python3 -m docs.mmos.launcher.cli \
  --mind fake_mind_999 \
  --phase analysis \
  --prompt analysis_mental_models \
  --dry-run
```
**Expected**: ❌ Error: Mind directory not found

### 3. Phase Coverage Tests

Test one prompt from each phase:

#### 3.1 Viability Phase
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_scorecard_apex \
  --show-deps \
  --dry-run
```
**Expected**: ✅ No dependencies (first prompt)

#### 3.2 Research Phase
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase research \
  --prompt research_source_discovery \
  --show-deps \
  --dry-run
```
**Expected**: ✅ Depends on viability_prd_generator

#### 3.3 Analysis Phase
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_source_reading \
  --show-deps \
  --dry-run
```
**Expected**: ✅ Depends on research_sources_master

#### 3.4 Synthesis Phase
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase synthesis \
  --prompt synthesis_extract_core \
  --show-deps \
  --dry-run
```
**Expected**: ✅ Depends on analysis_core_obsessions

#### 3.5 Implementation Phase
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase implementation \
  --prompt implementation_generalista_compiler \
  --show-deps \
  --dry-run
```
**Expected**: ✅ Depends on multiple implementation prompts

#### 3.6 Testing Phase
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase testing \
  --prompt testing_test_generator \
  --show-deps \
  --dry-run
```
**Expected**: ✅ Depends on implementation_testing_protocol

### 4. Dependency Chain Tests

#### 4.1 Prompt with No Dependencies
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_scorecard_apex \
  --show-deps \
  --dry-run
```
**Expected**: ✅ "No dependencies"

#### 4.2 Prompt with Single Dependency
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_icp_match_score \
  --show-deps \
  --dry-run
```
**Expected**: ⚠️ Missing 1 dependency: viability_scorecard_apex

#### 4.3 Prompt with Multiple Dependencies
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_mental_models \
  --show-deps \
  --dry-run
```
**Expected**: ⚠️ Missing 3 dependencies

### 5. Path Resolution Tests

#### 5.1 Simple Path (no placeholders)
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_prd_generator \
  --dry-run
```
**Expected**: ✅ Output path: minds/steve_jobs/docs/PRD.md

#### 5.2 Path with {mind} placeholder
```bash
python3 -m docs.mmos.launcher.cli \
  --mind naval_ravikant \
  --phase viability \
  --prompt viability_dependencies_mapper \
  --dry-run
```
**Expected**: ✅ Output path: minds/naval_ravikant/metadata/dependencies.yaml

#### 5.3 Path with {timestamp} placeholder
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_scorecard_apex \
  --dry-run
```
**Expected**: ✅ Output path includes current timestamp (YYYYMMDD-HHMM format)

### 6. Logging Tests

#### 6.1 Dry Run (No Logging)
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_scorecard_apex \
  --dry-run
```
**Expected**: ✅ "Dry run - execution NOT logged"

#### 6.2 Actual Execution (With Logging)
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_prd_generator
```
**Expected**: ✅ "Execution logged to launcher-history.yaml"

#### 6.3 Verify History File
```bash
cat docs/mmos/launcher-history.yaml
```
**Expected**: ✅ YAML structure with execution records

### 7. Context Loading Tests

#### 7.1 Mind with MIND_BRIEF
```bash
# TODO: Find a mind with MIND_BRIEF.md
python3 -m docs.mmos.launcher.cli \
  --mind <mind_with_brief> \
  --phase analysis \
  --prompt analysis_mental_models \
  --show-context \
  --dry-run
```
**Expected**: ✅ "📄 MIND_BRIEF.md found"

#### 7.2 Mind without MIND_BRIEF
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_mental_models \
  --show-context \
  --dry-run
```
**Expected**: ⚠️ "MIND_BRIEF.md NOT FOUND"

#### 7.3 Mind with PRD
```bash
# TODO: Check which minds have PRD
python3 -m docs.mmos.launcher.cli \
  --mind <mind_with_prd> \
  --phase analysis \
  --prompt analysis_mental_models \
  --show-context \
  --dry-run
```
**Expected**: ✅ "📄 PRD.md found"

#### 7.4 Mind with Sources
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_mental_models \
  --show-context \
  --dry-run
```
**Expected**: ✅ "📚 X source file(s) loaded"

### 8. Parallelization Flag Tests

#### 8.1 Parallelizable Prompt
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_mental_models \
  --dry-run
```
**Expected**: ✅ "⚡ Parallelizable: Yes"

#### 8.2 Non-Parallelizable Prompt
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase viability \
  --prompt viability_scorecard_apex \
  --dry-run
```
**Expected**: ✅ "⚡ Parallelizable: No"

### 9. Performance Tests

#### 9.1 Execution Duration
```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_mental_models \
  --dry-run
```
**Expected**: ✅ Duration < 100ms (target: ~23ms)

#### 9.2 Multiple Sequential Executions
```bash
for i in {1..5}; do
  python3 -m docs.mmos.launcher.cli \
    --mind steve_jobs \
    --phase viability \
    --prompt viability_scorecard_apex \
    --dry-run
done
```
**Expected**: ✅ All executions complete successfully, consistent duration

## Test Results

| Test ID | Description | Status | Notes |
|---------|-------------|--------|-------|
| 1.1 | Valid prompt execution | ⏳ | |
| 1.2 | Show context flag | ⏳ | |
| 1.3 | Show dependencies flag | ⏳ | |
| 1.4 | All flags combined | ⏳ | |
| 2.1 | Invalid prompt ID | ⏳ | |
| 2.2 | Wrong phase for prompt | ⏳ | |
| 2.3 | Non-existent mind | ⏳ | |
| 3.1-3.6 | All phases covered | ⏳ | |
| 4.1-4.3 | Dependency chains | ⏳ | |
| 5.1-5.3 | Path resolution | ⏳ | |
| 6.1-6.3 | Logging | ⏳ | |
| 7.1-7.4 | Context loading | ⏳ | |
| 8.1-8.2 | Parallelization flags | ⏳ | |
| 9.1-9.2 | Performance | ⏳ | |

## Success Criteria

- ✅ All basic functionality tests pass
- ✅ Error handling works correctly (graceful failures)
- ✅ All 6 phases work correctly
- ✅ Dependency checking identifies missing deps
- ✅ Path resolution works for all placeholder types
- ✅ Logging structure is valid YAML
- ✅ Context loading detects all file types
- ✅ Performance: <100ms per execution
- ✅ No crashes or data corruption
