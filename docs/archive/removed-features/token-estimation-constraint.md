# Token Estimation Constraint (REMOVED)

**Date Removed:** 2025-11-04
**Reason:** Blocking workflow execution, ceremony over pragmatism

## Original Content from CLAUDE.md

```markdown
## Token Estimation & Resource Planning

For complex multi-step operations, expansion pack pipelines, and resource-intensive workflows, token estimation is critical to prevent context overflow.

**Full guide:** See `docs/guides/token-estimation-guide.md`

**Quick reference:**
- Multi-step operations (>3 steps): Estimate required
- Large operations (>70% projected usage): Use Task/subagent recommended
- Critical operations (>85% projected usage): Must use subagent or new window
```

## Original Content from mind-mapper.md activation-instructions

```yaml
- STEP 7.5 TOKEN ESTIMATION (CRITICAL): BEFORE executing any multi-step command (*map, *phase, etc.), you MUST:
  1. Read task metadata (token-estimation section from task file)
  2. Calculate token estimate using formulas from CLAUDE.md (INPUT + PROCESSING + OUTPUT)
  3. Present estimate using standardized format from CLAUDE.md section "Token Estimation & Resource Planning"
  4. Show 3 options: (1) Continue in current window, (2) Task/subagent (context isolated), (3) Prompt for new window, plus optional (4) Agent custom option
  5. Wait for user choice (1/2/3/4) - DO NOT proceed without explicit selection
  6. If user selects option 2: Use Task tool with subagent_type="general-purpose"
  7. If user selects option 3: Generate complete standalone prompt with all context
  8. Log decision in YAML format (operation, estimated_tokens, user_choice, timestamp)
  9. BLOCK option 1 if projected usage >85% of context window
  10. STRONGLY RECOMMEND option 2 if projected usage >70%
```

## Why Removed

Alan's feedback: "quero remover essa limitação, vamos comentar ela do sistema"

The token estimation requirement was:
- Blocking workflow execution with mandatory user interaction
- Adding ceremony before execution
- Against AIOS principle: "Meta-rule: These rules should be economical. If anything becomes ceremony, delete it."

## Related Files (for restoration if needed)

- `.claude/CLAUDE.md` - Lines ~309-318
- `expansion-packs/mmos/agents/mind-mapper.md` - STEP 7.5 in activation-instructions
- `.claude/commands/MMOS/agents/mind-mapper.md` - STEP 7.5 (synced copy)
- `docs/guides/token-estimation-guide.md` - Full implementation guide
- `docs/qa/gates/token-estimation-implementation.yaml` - QA gate
- `docs/qa/test-results/token-estimation-tests-2025-10-28.md` - Test results

## Restoration Command

If needed to restore:
```bash
git log --all --full-history -- "**/*token-estimation*"
git show <commit-hash>:path/to/file
```
