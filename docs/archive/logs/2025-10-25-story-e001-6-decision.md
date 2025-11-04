# Story E001.6 Decision: Simple vs Complex Approach

**Date:** 2025-10-25
**Context:** Fixing workflow execution bug in MMOS pipeline
**Decision:** APPROVED E001.6-SIMPLE (Rejected E001.6 for overengineering)

---

## Executive Summary

After comprehensive QA analysis, we identified that the initial proposed solution (Story E001.6) was 70-80% overengineered. We created a simplified alternative (E001.6-SIMPLE) that:

- **Reduces effort:** 24-34h → 4-8h (75-80% reduction)
- **Reduces code:** 800-1200 lines → 200-300 lines (70-80% reduction)
- **Reduces risk:** Medium-High → Low
- **Follows proven patterns:** AIOS task execution + CreatorOS orchestration

---

## The Problem

**Root Cause:**
```python
# expansion-packs/mmos/lib/map_mind.py (line 233)
def _execute_workflow(...):
    # TODO: Actual workflow execution
    print("⚠️ Placeholder")
    return {}  # NEVER ACTUALLY EXECUTES
```

**Impact:** 100% of workflow executions broken. AI creates manual simulations bypassing documented architecture.

**User Experience:**
```bash
*map Thiago Finch
# Expected: Execute greenfield-mind.yaml → tasks → modules
# Actual: AI creates manual simulation using Gemini API, bypassing architecture
```

---

## Proposed Solutions Comparison

### Story E001.6 (REJECTED - Overengineered)

**Approach:** Build formal executor/runner infrastructure

**Components:**
- `workflow_executor.py` (~400-600 lines)
  - Parse workflow sequences
  - Execute phases
  - Handle checkpoints
  - Track results

- `task_runner.py` (~400-600 lines)
  - Load task markdown
  - Parse frontmatter
  - Extract instructions
  - Handle elicitation
  - Execute instructions
  - Generate outputs

**Total:** 800-1200 lines, 24-34 hours

**Why Rejected:**
1. **Reinvents AI's native capabilities**
   - AI already executes markdown tasks (proven by AIOS `.aios-core/tasks/`)
   - AI already parses YAML frontmatter
   - AI already handles `elicit: true` (uses AskUserQuestion tool)
   - AI already interprets instructions

2. **Complex abstractions unnecessary**
   - Formal executor/runner pattern adds layers
   - More code = more bugs, more maintenance
   - Over-abstracts simple sequencing

3. **High risk**
   - New patterns to establish
   - Complex testing requirements
   - 4 new test files needed

---

### Story E001.6-SIMPLE (APPROVED)

**Approach:** Simple orchestrator leveraging AI's native task execution

**Component:**
- `workflow_orchestrator.py` (~250 lines)
  - Load workflow YAML
  - Sequence phases
  - For each phase with task:
    - Load task markdown
    - Print to AI ("EXECUTE TASK: {name}")
    - AI reads and executes autonomously
  - Handle checkpoints
  - Track progress

**Total:** 200-300 lines, 4-8 hours

**Why Approved:**
1. **Leverages existing capabilities**
   - AI already knows how to execute markdown tasks
   - No need to parse/interpret in Python
   - Simple "print and let AI execute" pattern

2. **Proven patterns**
   - AIOS: AI executes `.aios-core/tasks/*.md` directly
   - CreatorOS: Simple orchestrator (~500 lines in `generate_course.py`)
   - Pattern: Load → Print → AI executes

3. **Low risk**
   - Simple, readable code
   - Easy to test
   - Easy to maintain
   - 2 test files (vs 4)

---

## Architecture Pattern

### Simple Orchestration (APPROVED)

```python
def orchestrate_workflow(workflow, context):
    """
    Simple orchestrator - no complex infrastructure needed.
    Leverages AI's native markdown task execution.
    """
    results = {'status': 'in_progress', 'phases_executed': []}

    for phase in workflow['sequence']:
        if 'task' in phase:
            # Load task markdown
            task_path = Path(f"tasks/{phase['task']}.md")
            task_content = task_path.read_text()

            # Present to AI (AI sees this output and executes)
            print(f"\n{'='*80}")
            print(f"TASK: {phase['task']}")
            print(f"{'='*80}\n")
            print(task_content)
            print(f"\nContext: {json.dumps(context, indent=2)}")
            print(f"\n{'='*80}")
            print(f"EXECUTE ABOVE TASK")
            print(f"{'='*80}\n")

            # AI executes task autonomously
            # - Reads frontmatter
            # - Follows instructions
            # - Elicits if needed (AskUserQuestion tool)
            # - Creates outputs (Write tool)

            # Track completion
            results['phases_executed'].append({
                'phase': phase['phase'],
                'task': phase['task'],
                'status': 'completed'
            })

        if phase.get('human_checkpoint'):
            decision = handle_checkpoint(phase, results)
            if decision == 'ABORT':
                results['status'] = 'aborted'
                return results

    results['status'] = 'completed'
    return results
```

**Key Insight:** Python doesn't need to understand tasks, just sequence them and present to AI.

---

## Evidence: AI Already Executes Tasks

### AIOS Pattern

**Example:** `.aios-core/tasks/create-doc.md`

```markdown
---
elicit: true
params:
  - template_name
  - output_path
---

# Create Documentation Task

## Instructions

1. Load template YAML from templates/{template_name}.yaml
2. IF elicit: true → Present options to user (1-9 format)
3. WAIT FOR USER RESPONSE
4. Render template with user inputs
5. Write to {output_path}
```

**How it works:**
1. AIOS master agent presents task markdown to AI
2. AI reads frontmatter: `elicit: true`
3. AI reads instructions
4. AI uses AskUserQuestion tool for elicitation
5. AI uses Write tool for output
6. AI reports completion

**No Python executor needed** - AI does it all.

---

### CreatorOS Pattern

**Example:** `expansion-packs/creator-os/scripts/generate_course.py` (~500 lines)

```python
class CourseGenerationWorkflow:
    def run(self):
        # Simple orchestration
        brief = BriefParser.parse(self.brief_path)
        curriculum = self.generate_curriculum(brief)  # AI call
        approved = run_curriculum_approval_checkpoint(curriculum)  # User interaction
        if approved:
            lessons = self.generate_lessons(curriculum)  # AI call
            self.save_outputs(lessons)
```

**Pattern:**
- Python sequences steps
- Python calls AI for generation
- Python handles checkpoints
- Python saves results

**No complex executor/runner** - Simple orchestration.

---

## Metrics Comparison

| Metric | E001.6 (Complex) | E001.6-SIMPLE | Winner |
|--------|------------------|---------------|--------|
| **Lines of Code** | 800-1200 | 200-300 | SIMPLE (70-80% less) |
| **Effort (hours)** | 24-34 | 4-8 | SIMPLE (75-80% less) |
| **Components** | 2 | 1 | SIMPLE (50% less) |
| **Test Files** | 4 | 2 | SIMPLE (50% less) |
| **Complexity** | High | Low | SIMPLE |
| **Risk** | Medium-High | Low | SIMPLE |
| **Maintenance** | High | Low | SIMPLE |
| **Follows Patterns** | No (new) | Yes (AIOS/CreatorOS) | SIMPLE |
| **Leverages AI** | No (reimplements) | Yes (native) | SIMPLE |

**Overall Winner:** E001.6-SIMPLE (wins on all metrics)

---

## Decision Rationale

### Why E001.6-SIMPLE is Correct

1. **Follows proven patterns**
   - AIOS already uses AI markdown task execution
   - CreatorOS already uses simple orchestration
   - No need to reinvent

2. **Leverages AI's strengths**
   - AI excels at interpreting markdown
   - AI already has task execution skills
   - AI already handles elicitation (AskUserQuestion)

3. **Simplicity = Reliability**
   - Less code = fewer bugs
   - Clear, readable implementation
   - Easy to maintain and extend

4. **Fast to implement**
   - 4-8 hours vs 24-34 hours
   - 75-80% time savings
   - Lower risk of delays

5. **Future-proof**
   - Simple code adapts easily
   - AI improves over time (benefits our approach)
   - No complex abstractions to maintain

---

## Implementation Plan (E001.6-SIMPLE)

### Phase 1: Create Orchestrator (2-3 hours)
- [ ] Create `workflow_orchestrator.py` (~250 lines)
- [ ] Implement `orchestrate_workflow()` function
- [ ] Implement `load_task_markdown()` function
- [ ] Implement `handle_checkpoint()` function
- [ ] Add error handling and logging

### Phase 2: Integrate with map_mind.py (1-2 hours)
- [ ] Update `_execute_workflow()` to remove TODO
- [ ] Call preprocessor to expand modules
- [ ] Call orchestrator to execute workflow
- [ ] Remove placeholder print statements

### Phase 3: Testing (1-2 hours)
- [ ] Create unit tests for orchestrator
- [ ] Create integration test for end-to-end execution
- [ ] Test checkpoint handling
- [ ] Test error scenarios

### Phase 4: Documentation (1 hour)
- [ ] Create `workflow-orchestration.md` architecture doc
- [ ] Update `workflows/README.md`
- [ ] Update agent instructions

**Total:** 4-8 hours (vs 24-34 hours for E001.6)

---

## References

**Analysis Documents:**
- Root Cause: `docs/logs/2025-10-25-qa-root-cause-analysis.md`
- Overengineering Analysis: `docs/logs/2025-10-25-qa-story-analysis.md`
- This Decision: `docs/logs/2025-10-25-story-e001-6-decision.md`

**Stories:**
- REJECTED: `expansion-packs/mmos/docs/stories/story-6-workflow-executor.md`
- APPROVED: `expansion-packs/mmos/docs/stories/story-6-simple-workflow-orchestrator.md`

**Proven Patterns:**
- AIOS Tasks: `.aios-core/tasks/`
- CreatorOS: `expansion-packs/creator-os/scripts/generate_course.py`

**Related Files:**
- Bug Location: `expansion-packs/mmos/lib/map_mind.py` (line 233)
- Will Create: `expansion-packs/mmos/lib/workflow_orchestrator.py`

---

## Lessons Learned

### 1. Don't Reinvent AI's Native Capabilities

**Anti-Pattern (E001.6):**
```python
# task_runner.py - UNNECESSARY
def execute_task(task_name, context):
    frontmatter = parse_yaml_frontmatter(task_md)  # AI already does this
    instructions = extract_instructions(task_md)   # AI already does this
    if frontmatter.get('elicit'):
        user_input = elicit_from_user(...)         # AI already does this (AskUserQuestion)
    result = execute_instructions(instructions)     # AI already does this
```

**Correct Pattern (E001.6-SIMPLE):**
```python
# workflow_orchestrator.py - SIMPLE
task_content = load_task_markdown(task_name)
print(f"EXECUTE TASK: {task_name}\n{task_content}")
# AI sees this and executes autonomously
```

### 2. Simple Orchestration > Complex Infrastructure

**When building AI workflows:**
- ✅ Load data, sequence steps, track progress
- ✅ Let AI interpret instructions
- ✅ Let AI handle elicitation
- ❌ Don't parse/interpret in Python
- ❌ Don't build execution engines
- ❌ Don't over-abstract

### 3. Look for Proven Patterns First

**Before building:**
1. Check if similar pattern exists (AIOS, CreatorOS)
2. Check if AI already has capability
3. Start with simplest solution
4. Add complexity only if needed

---

## Decision

**APPROVED:** Story E001.6-SIMPLE
**REJECTED:** Story E001.6 (Overengineered)

**Rationale:** 70-80% simpler, follows proven patterns, leverages AI's native capabilities.

**Next Steps:** Implement E001.6-SIMPLE (4-8 hours)

---

**Decision Made By:** Quinn (QA) + Claude Code
**Approved By:** Alan (User)
**Date:** 2025-10-25
**Status:** ✅ FINAL
