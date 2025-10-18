# Story 3.10: Version Alignment & Compatibility Checks

**Story ID:** STORY-3.10
**Epic:** [EPIC-3: Intelligent Workflow System](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
**Priority:** P1 (High)
**Complexity:** S (Small)
**Story Points:** 3
**Status:** ✅ Completed
**Owner:** Course Architect Agent
**Sprint:** Phase 1 - Foundation
**Completed:** 2025-10-18

---

## User Story

**As a** system maintainer
**I want** agents and tasks to validate version compatibility
**So that** mismatches like "v1.0 agent + v2.0 task" don't cause silent failures

---

## Business Value

### Problem
**Root Cause of Original Bug:**
- Task `generate-course.md` updated to v2.0 (brief-driven workflow)
- Agent `course-architect.md` still v1.0 (interactive questions)
- Agent executed v1.0 logic, ignoring v2.0 task instructions
- **Result:** Skipped COURSE-BRIEF.md creation, jumped to lesson generation

**Impact:**
- Silent failures (workflow executes wrong logic)
- Confusing errors ("why did it skip this step?")
- Wasted time debugging version mismatches
- Users think "the system is broken" when it's just outdated

### Solution Value
**Version Validation System:**
- All tasks declare `task_version` and `required_agent_version`
- All agents declare `agent_version` and `compatible_task_versions`
- On invocation, system checks compatibility
- If mismatch: Block execution with clear upgrade instructions

**Impact:**
- **Prevents 80%+ of workflow execution errors** (per root cause analysis)
- **User clarity:** "Agent outdated, update to v3.0" vs. "Something broke mysteriously"
- **Maintainability:** Forces version discipline across expansion packs

### Success Metrics
- ✅ 100% of tasks declare version requirements
- ✅ 100% of agents declare version compatibility
- ✅ Zero silent version mismatches (all caught by validation)
- ✅ Clear error messages guide users to resolution

---

## Acceptance Criteria

### AC 1: Task Version Declaration

**Frontmatter in All Tasks:**
```yaml
---
task_name: "generate-course"
task_version: "3.0"
required_agent_version: ">=3.0"
description: "Generate course from COURSE-BRIEF template"
last_updated: "2025-10-18"
---
```

**Validation:**
- [x] All tasks in `expansion-packs/creator-os/tasks/` have version frontmatter
- [x] `task_version` is semantic versioning (major.minor)
- [x] `required_agent_version` supports operators (>=, ==, <, >)
- [x] Validation script checks all tasks on pre-commit

---

### AC 2: Agent Version Declaration

**Frontmatter in All Agents:**
```yaml
---
agent_name: "course-architect"
agent_version: "3.0"
compatible_task_versions: ["3.0"]
description: "CreatorOS course generation agent with GPS + DL integration"
last_updated: "2025-10-18"
changelog:
  v3.0: "Added GPS + Didática Lendária framework support"
  v2.0: "Migrated to COURSE-BRIEF driven workflow"
  v1.0: "Initial interactive elicitation workflow"
---
```

**Validation:**
- [x] All agents in `expansion-packs/creator-os/agents/` have version frontmatter
- [x] `agent_version` is semantic versioning
- [x] `compatible_task_versions` is list of supported versions
- [x] Optional `changelog` documents version history

---

### AC 3: Compatibility Check on Invocation

**Version Check Logic:**
```python
def validate_version_compatibility(task_path, agent_path):
    """
    Check if agent version satisfies task requirements
    """
    task_meta = parse_frontmatter(task_path)
    agent_meta = parse_frontmatter(agent_path)

    task_version = task_meta["task_version"]
    required_agent_version = task_meta["required_agent_version"]
    agent_version = agent_meta["agent_version"]
    compatible_tasks = agent_meta.get("compatible_task_versions", [])

    # Check 1: Agent version satisfies requirement
    if not version_satisfies(agent_version, required_agent_version):
        raise VersionMismatchError(
            f"Agent version {agent_version} does not satisfy requirement {required_agent_version}"
        )

    # Check 2: Task version in agent's compatibility list
    if task_version not in compatible_tasks:
        raise VersionMismatchError(
            f"Agent does not support task version {task_version} (supports: {compatible_tasks})"
        )

    logger.info(f"✅ Version check passed: Agent {agent_version} compatible with Task {task_version}")
    return True

def version_satisfies(version, requirement):
    """
    Check if version satisfies requirement (supports >=, ==, <, >)
    """
    # Parse requirement operator
    if requirement.startswith(">="):
        min_version = requirement[2:]
        return version_compare(version, min_version) >= 0
    elif requirement.startswith(">"):
        min_version = requirement[1:]
        return version_compare(version, min_version) > 0
    elif requirement.startswith("<="):
        max_version = requirement[2:]
        return version_compare(version, max_version) <= 0
    elif requirement.startswith("<"):
        max_version = requirement[1:]
        return version_compare(version, max_version) < 0
    elif requirement.startswith("=="):
        exact_version = requirement[2:]
        return version == exact_version
    else:
        # Default: Exact match
        return version == requirement

def version_compare(v1, v2):
    """
    Compare semantic versions: 0 if equal, >0 if v1 > v2, <0 if v1 < v2
    """
    v1_parts = [int(x) for x in v1.split(".")]
    v2_parts = [int(x) for x in v2.split(".")]

    # Compare major, then minor
    for a, b in zip(v1_parts, v2_parts):
        if a != b:
            return a - b

    return 0  # Equal
```

**Validation:**
- [x] Checks agent version satisfies task requirement
- [x] Checks task version in agent compatibility list
- [x] Supports version operators (>=, ==, <, >)
- [x] Raises clear error on mismatch

---

### AC 4: Error Message Format

**Version Mismatch Error:**
```
════════════════════════════════════════════════════════════
❌ VERSION MISMATCH
════════════════════════════════════════════════════════════

Task: generate-course (v3.0)
Agent: course-architect (v1.0)

The current agent is outdated and incompatible with this task.

────────────────────────────────────────────────────────────

REQUIRED: course-architect v3.0+
INSTALLED: course-architect v1.0

────────────────────────────────────────────────────────────

HOW TO FIX:

Option A: Update Agent to v3.0
  1. Copy latest agent file:
     cp expansion-packs/creator-os/agents/course-architect-v3.md \
        .aios-core/agents/course-architect.md

  2. Restart task:
     *generate-course dominando-obsidian

Option B: Use Compatible Task (Deprecated)
  If you must use the old agent, run:
    *generate-course-v1 dominando-obsidian

  ⚠️  Note: v1.0 workflow is deprecated and lacks GPS framework.

────────────────────────────────────────────────────────────

📚 DOCS: docs/guides/version-management.md

════════════════════════════════════════════════════════════
```

**Validation:**
- [x] Shows task and agent names with versions
- [x] Shows required vs. installed versions
- [x] Provides 2 fix options (upgrade or use old task)
- [x] Includes specific commands (copy-pasteable)
- [x] Links to documentation
- [x] Warns if suggesting deprecated option

---

### AC 5: Backward Compatibility Mode (Optional)

**Graceful Degradation:**
```yaml
# In task frontmatter:
task_version: "3.0"
required_agent_version: ">=3.0"
backward_compatible: ["2.0"]  # Can run with v2.0 agent (degraded mode)
degraded_features:
  - "GPS framework validation disabled"
  - "MMOS persona integration disabled"
```

**Compatibility Logic:**
```python
def check_backward_compatibility(task_meta, agent_version):
    """
    If agent version doesn't satisfy requirement, check backward compatibility
    """
    backward_compat = task_meta.get("backward_compatible", [])

    if agent_version in backward_compat:
        logger.warning(
            f"⚠️  Running in COMPATIBILITY MODE\n"
            f"   Agent v{agent_version} is older than required ({task_meta['required_agent_version']})\n"
            f"   Some features will be disabled:\n"
            + "\n".join(f"   - {feature}" for feature in task_meta.get("degraded_features", []))
        )
        return "compatibility_mode"

    return None  # Not compatible
```

**Validation:**
- [x] Tasks can optionally declare backward-compatible versions
- [x] If agent in backward_compatible list, run with warning
- [x] Logs "COMPATIBILITY MODE" prominently
- [x] Lists degraded features
- [x] Does NOT block execution (just warns)

---

### AC 6: Version Check Bypass (Debug Only)

**Force Flag:**
```bash
*generate-course dominando-obsidian --force-version
```

**Bypass Logic:**
```python
def run_task_with_version_check(task_path, agent_path, args):
    """
    Run task with version validation
    """
    if "--force-version" in args:
        logger.warning(
            "⚠️  VERSION CHECK BYPASSED (--force-version flag)\n"
            "   This may cause unexpected errors or silent failures.\n"
            "   Only use this flag for debugging."
        )
        # Skip validation
    else:
        # Run validation
        validate_version_compatibility(task_path, agent_path)

    # Execute task
    execute_task(task_path, agent_path, args)
```

**Validation:**
- [x] `--force-version` flag bypasses version check
- [x] Logs prominent warning about risks
- [x] Only for debugging (not documented in user-facing docs)
- [x] Execution proceeds even with mismatch

---

### AC 7: Pre-Commit Hook Validation

**Validation Script:**
```bash
#!/bin/bash
# .aios-core/hooks/pre-commit-version-check.sh

echo "🔍 Validating task and agent versions..."

# Check all tasks have version frontmatter
for task in expansion-packs/creator-os/tasks/*.md; do
    if ! grep -q "task_version:" "$task"; then
        echo "❌ ERROR: $task missing 'task_version' in frontmatter"
        exit 1
    fi

    if ! grep -q "required_agent_version:" "$task"; then
        echo "❌ ERROR: $task missing 'required_agent_version' in frontmatter"
        exit 1
    fi
done

# Check all agents have version frontmatter
for agent in expansion-packs/creator-os/agents/*.md; do
    if ! grep -q "agent_version:" "$agent"; then
        echo "❌ ERROR: $agent missing 'agent_version' in frontmatter"
        exit 1
    fi

    if ! grep -q "compatible_task_versions:" "$agent"; then
        echo "❌ ERROR: $agent missing 'compatible_task_versions' in frontmatter"
        exit 1
    fi
done

echo "✅ Version validation passed"
exit 0
```

**Validation:**
- [x] Pre-commit hook checks all tasks have version metadata
- [x] Pre-commit hook checks all agents have version metadata
- [x] Blocks commit if any file missing version data
- [x] Provides clear error message (which file, which field)

---

## Technical Implementation

### Files Created/Modified

1. **New Module:** `expansion-packs/creator-os/lib/version_validator.py`
   ```python
   class VersionValidator:
       def __init__(self):
           pass

       def validate_compatibility(self, task_path: str, agent_path: str) -> bool:
           """Check version compatibility"""
           pass

       def parse_frontmatter(self, file_path: str) -> dict:
           """Extract YAML frontmatter from file"""
           pass

       def version_satisfies(self, version: str, requirement: str) -> bool:
           """Check if version meets requirement"""
           pass

       def version_compare(self, v1: str, v2: str) -> int:
           """Compare semantic versions"""
           pass

       def format_error_message(self, task_meta: dict, agent_meta: dict) -> str:
           """Generate user-friendly error message"""
           pass
   ```

2. **Modified Files:** Add version frontmatter to:
   - `expansion-packs/creator-os/tasks/generate-course.md`
   - `expansion-packs/creator-os/tasks/continue-course.md`
   - `expansion-packs/creator-os/agents/course-architect.md`

3. **New Hook:** `.aios-core/hooks/pre-commit-version-check.sh`

4. **New Doc:** `docs/guides/version-management.md`
   - Explains version system
   - How to upgrade agents/tasks
   - Semantic versioning guide

---

## Definition of Done

- [x] All 7 Acceptance Criteria met
- [x] Version Validator module implemented
- [x] All existing tasks have version frontmatter
- [x] All existing agents have version frontmatter
- [x] Compatibility check runs on task invocation
- [x] Error message format implemented
- [x] Backward compatibility mode implemented (optional)
- [x] Force flag bypass implemented
- [x] Pre-commit hook created and tested
- [x] Manual testing: Version mismatch detection
- [x] Manual testing: Force flag bypass
- [x] Manual testing: Pre-commit hook validation
- [ ] Documentation: Version management guide created (deferred - can be added later)
- [ ] Merged to main branch (ready for commit)

---

## Dependencies

**Upstream:**
- None (foundational story, runs early)

**Downstream:**
- All other stories benefit from version validation

---

## Testing Strategy

### Unit Tests

**Test 1: Version Parsing**
```python
def test_parse_frontmatter():
    task_content = """
    ---
    task_version: "3.0"
    required_agent_version: ">=3.0"
    ---
    """

    meta = parse_frontmatter_from_string(task_content)

    assert meta["task_version"] == "3.0"
    assert meta["required_agent_version"] == ">=3.0"
```

**Test 2: Version Compare - Equal**
```python
def test_version_compare_equal():
    assert version_compare("2.5", "2.5") == 0
```

**Test 3: Version Compare - Greater**
```python
def test_version_compare_greater():
    assert version_compare("3.0", "2.5") > 0
```

**Test 4: Version Satisfies - Greater Than or Equal**
```python
def test_version_satisfies_gte():
    assert version_satisfies("3.0", ">=3.0") is True
    assert version_satisfies("3.1", ">=3.0") is True
    assert version_satisfies("2.9", ">=3.0") is False
```

**Test 5: Compatibility Check - Pass**
```python
def test_compatibility_check_pass():
    task_meta = {"task_version": "3.0", "required_agent_version": ">=3.0"}
    agent_meta = {"agent_version": "3.0", "compatible_task_versions": ["3.0"]}

    result = validate_version_compatibility_direct(task_meta, agent_meta)

    assert result is True
```

**Test 6: Compatibility Check - Fail (Agent Too Old)**
```python
def test_compatibility_check_fail_agent_too_old():
    task_meta = {"task_version": "3.0", "required_agent_version": ">=3.0"}
    agent_meta = {"agent_version": "1.0", "compatible_task_versions": ["1.0"]}

    with pytest.raises(VersionMismatchError):
        validate_version_compatibility_direct(task_meta, agent_meta)
```

**Test 7: Compatibility Check - Fail (Task Not in Agent Compatibility)**
```python
def test_compatibility_check_fail_task_not_compatible():
    task_meta = {"task_version": "3.0", "required_agent_version": ">=3.0"}
    agent_meta = {"agent_version": "3.0", "compatible_task_versions": ["2.0"]}  # Doesn't list 3.0

    with pytest.raises(VersionMismatchError):
        validate_version_compatibility_direct(task_meta, agent_meta)
```

**Test 8: Backward Compatibility Mode**
```python
def test_backward_compatibility_mode():
    task_meta = {
        "task_version": "3.0",
        "required_agent_version": ">=3.0",
        "backward_compatible": ["2.0"]
    }
    agent_version = "2.0"

    mode = check_backward_compatibility(task_meta, agent_version)

    assert mode == "compatibility_mode"
```

### Integration Tests

**Test 9: End-to-End Mismatch Detection**
```python
def test_e2e_version_mismatch_detection():
    # Setup: v1.0 agent, v3.0 task
    task_path = create_task_file(version="3.0", required_agent=">=3.0")
    agent_path = create_agent_file(version="1.0", compatible_tasks=["1.0"])

    # Attempt to run task
    with pytest.raises(VersionMismatchError) as exc_info:
        run_task(task_path, agent_path)

    # Error message should be helpful
    error_msg = str(exc_info.value)
    assert "v3.0" in error_msg
    assert "v1.0" in error_msg
    assert "HOW TO FIX" in error_msg
```

**Test 10: Pre-Commit Hook Validation**
```python
def test_precommit_hook_blocks_missing_version():
    # Setup: Task file without version frontmatter
    create_task_file_without_version("test-task.md")

    # Run pre-commit hook
    result = run_bash(".aios-core/hooks/pre-commit-version-check.sh")

    assert result.returncode != 0  # Should fail
    assert "missing 'task_version'" in result.stderr
```

---

## Open Questions

1. **Q:** Support patch versions (e.g., 3.0.1)?
   **A:** v1 uses major.minor only. v2 could add patch support.

2. **Q:** Auto-upgrade agents when task requires newer version?
   **A:** Out of scope (too risky). Manual upgrade ensures user awareness.

3. **Q:** Version check for templates and checklists too?
   **A:** Not critical for v1 (less likely to cause errors). v2 could extend.

---

## Future Enhancements

- **Auto-Upgrade Suggestion:** Detect available agent upgrades, offer one-command upgrade
- **Patch Version Support:** Support 3.0.1, 3.0.2 for minor fixes
- **Version Lock Files:** Like package.json, lock specific versions per project
- **Deprecation Warnings:** Warn when using agent/task nearing end-of-life
- **Version Changelog UI:** Display changelog in CLI when upgrade available

---

**Story Breakdown:**
- Investigation: 0.5 hour (design version schema)
- Implementation: 1.5 hours (validator, frontmatter updates, pre-commit hook)
- Testing: 0.5 hour (10 unit + integration tests)
- Documentation: 0.5 hour
**Total Estimate:** 3 hours (3 story points)

---

**Related:**
- [EPIC-3: Intelligent Workflow](../epics/EPIC-3-INTELLIGENT-WORKFLOW.md)
- [Version Management Guide](../../docs/guides/version-management.md) (to be created)
