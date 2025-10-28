# P1 Architecture - Executive Summary

**Author**: Winston (Architect)
**Date**: 2025-10-28
**Priority**: P1 (Critical)
**Effort**: ~11 hours over 3-4 days
**Risk**: LOW (reversible, backward compatible)

---

## TL;DR

**Problem**: Brad can't handle multiple design contexts (curso + dashboard) and workflows don't talk to each other.

**Solution P1**:
1. **Project isolation** - Each design context gets its own namespace
2. **Workflow unification** - Single `*consolidate` works for both brownfield + artifacts

**ROI**: 4x faster incremental scans, 67% token reduction, zero context pollution.

---

## What You Get

### Before P1 (Current - Broken)

```bash
# Scenario: 5 curso artifacts + want to add 8 dashboard artifacts

*scan {dashboard-001}  # Goes to SAME registry as curso
*scan {dashboard-002}  # Mixed with curso
# ...
*scan {dashboard-008}

*consolidate  # Processes ALL 13 (curso + dashboard mixed)
# Result: Frankenstein tokens (educational orange + admin blue)
# UNUSABLE for both contexts

Time: 2 hours
Tokens: ~95K
Risk: HIGH (context pollution)
```

### After P1 (Fixed)

```bash
# Isolated contexts

*new-project dashboard --type=admin
*scan {dashboard-001}  # Goes to dashboard project ONLY
# ...
*scan {dashboard-008}

*consolidate --project=dashboard  # Processes ONLY dashboard (8)
# Result: Clean admin tokens (blue/gray)

Time: 30 min (incremental only)
Tokens: ~25K (67% reduction)
Risk: ZERO (isolated)

# Curso untouched
*use-project curso
*consolidate  # Still processes only curso's 5 artifacts
```

---

## Problems Solved

| Problem | Current State | After P1 |
|---------|---------------|----------|
| **Context Mixing** | Mix 13 artifacts → unusable tokens | Isolated projects → clean tokens |
| **Incremental Updates** | Add 10 → reprocess all 15 (2 hrs) | Add 10 → process only 10 (30 min) |
| **Workflow Confusion** | "No audit found" error after *scan | Auto-detects, just works |
| **Token Waste** | 75K tokens for full reprocess | 25K tokens incremental |
| **Scalability** | Breaks at ~15+ artifacts | Scales to 100+ per project |

---

## Architecture Components

### 1. Project Scope System

```
expansion-packs/super-agentes/scan-system/
└── projects/
    ├── .project-index.yaml      # Global catalog
    ├── curso-claude-code/
    │   ├── registry.yaml         # 5 artifacts
    │   ├── config.yaml           # Educational context
    │   └── .state.yaml
    └── dashboard-admin/
        ├── registry.yaml         # 8 artifacts
        ├── config.yaml           # Admin context
        └── .state.yaml

docs/design-system/
└── projects/
    ├── curso-claude-code/
    │   ├── analysis/
    │   ├── tokens/               # Educational tokens
    │   └── components/
    └── dashboard-admin/
        ├── analysis/
        ├── tokens/               # Admin tokens
        └── components/
```

**New Commands**:
- `*new-project {name} --type={type}` - Create isolated project
- `*list-projects` - Show all projects
- `*use-project {name}` - Switch context
- `*project-info` - Current project details

**Backward Compatible**: Existing data auto-migrates to "curso-claude-code" project.

### 2. Workflow Unification

```javascript
// Before: *consolidate only worked with brownfield
function consolidate() {
  const state = readYAML(".state.yaml");  // Hardcoded
  process(state);
}

// After: Auto-detects source
function consolidate() {
  const source = detectWorkflowSource(current_project);

  if (source.type === 'brownfield') {
    patterns = loadBrownfieldPatterns(source.source);
  } else if (source.type === 'artifacts') {
    patterns = loadArtifactPatterns(source.source);
  }

  // Rest is identical
  cluster(patterns);
  generateTokens(patterns);
}
```

**User Impact**: Commands "just work" regardless of workflow.

---

## Migration Path

### Phase 0: Backup (You - 5 min)

```bash
# Copy current state
cp registry.yaml backups/
cp -r docs/design-system/analysis backups/
```

### Phase 1: Core Infrastructure (Winston - 3 hrs)

- Create project index system
- Migrate existing 5 artifacts to "curso-claude-code" project
- Implement workflow detection
- Update consolidate task

### Phase 2: Commands (Winston - 3 hrs)

- Add project management commands
- Update Brad agent definition
- Create utilities

### Phase 3: Testing (Winston + You - 2 hrs)

- Unit tests
- Integration tests
- User acceptance test

### Phase 4: Docs (Winston - 1 hr)

- Migration guide
- User guide
- README updates

**Total**: ~11 hours spread over 3-4 days

---

## Risk Assessment

### What Could Go Wrong?

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Data loss during migration | LOW | HIGH | Backups + validation |
| Breaking existing workflow | LOW | HIGH | Backward compatibility mode |
| Path resolution bugs | MEDIUM | MEDIUM | Extensive testing |
| User confusion | LOW | MEDIUM | Clear docs + migration guide |

**Overall Risk**: **LOW**
- All changes are additive (not destructive)
- Backward compatibility maintained
- Easy rollback (restore backups)
- Incremental deployment possible

---

## Success Metrics

```yaml
After 1 week:
  metric: "Can create 2+ projects without issues"
  target: "100% success rate"

After 2 weeks:
  metric: "Token savings on incremental scans"
  target: "60%+ reduction vs full reprocess"

After 1 month:
  metric: "Context pollution incidents"
  target: "Zero reports of mixed design contexts"
```

---

## Files Created/Modified

### Created (~15 new files)

```
expansion-packs/super-agentes/
├── scan-system/projects/
│   └── .project-index.yaml                  # NEW
├── tasks/
│   └── project-manager.md                   # NEW
├── utils/
│   └── workflow-detector.md                 # NEW
└── templates/
    └── project-config-tmpl.yaml             # NEW

docs/design-system/
├── architecture/
│   ├── project-scope-system.md              # NEW (this proposal)
│   ├── workflow-unification.md              # NEW
│   ├── P1-migration-plan.md                 # NEW
│   └── P1-EXECUTIVE-SUMMARY.md              # NEW
├── guides/
│   └── project-system.md                    # NEW
└── migration/
    └── to-p1-projects.md                    # NEW
```

### Modified (~5 existing files)

```
expansion-packs/super-agentes/
├── agents/
│   └── design-system.md                     # MODIFIED (add commands)
└── tasks/
    ├── consolidate-patterns.md              # MODIFIED (add detection)
    ├── extract-tokens.md                    # MODIFIED (project-aware)
    ├── ds-scan-artifact.md                  # MODIFIED (save original HTML)
    └── build-component.md                   # MODIFIED (project-aware)
```

---

## Decision Points

### You Need to Decide:

1. **Approve P1 as-is?**
   - YES → Winston implements Phase 1 starting tomorrow
   - NO → What needs changing?

2. **Migration timing?**
   - Option A: Migrate now (11 hours over 3-4 days)
   - Option B: Defer (continue with current system, migrate later)
   - Option C: Partial (just workflow unification, skip projects)

3. **Backward compatibility requirement?**
   - Option A: Must work with zero breaking changes (current plan)
   - Option B: Can break legacy workflow if documented
   - Recommendation: A (safer)

4. **Testing depth?**
   - Option A: Full test suite (2 hours)
   - Option B: Minimal smoke tests (30 min)
   - Recommendation: A (catch issues early)

---

## Recommendations

### Winston's Assessment

**Proceed with P1 implementation**: ✅ YES

**Reasoning**:
1. **High ROI**: 4x faster + 67% token savings + zero context pollution
2. **Low Risk**: Backward compatible, reversible, well-tested
3. **Future-Proof**: Scales to 10+ projects without refactor
4. **Urgency**: Current system already blocked you (consolidate failed)

**Recommended Approach**:
- **Timing**: Start Phase 1 after your approval
- **Schedule**: 3-4 hours/day for 3 days (not blocking, can pause/resume)
- **Testing**: Full test suite (catch issues before production)
- **Rollout**: Incremental (Phase 1 → validate → Phase 2 → validate → ...)

---

## Questions?

### Common Questions Answered

**Q: Will this break my current work?**
A: No. Existing data auto-migrates, all commands work as before.

**Q: Can I rollback if issues found?**
A: Yes. Simple restore from backups (5 min).

**Q: Do I need to learn new commands?**
A: No for basics. Optional: learn `*new-project`, `*use-project` for multi-context work.

**Q: What if I just want workflow unification, not projects?**
A: Can deploy Phase 1 (detection + unification) without projects. But 90% of value is in projects.

**Q: How long until I can use it?**
A: Phase 1 (~3 hrs) makes consolidate work. Full features after Phase 2 (~6 hrs total).

---

## Next Steps

**Your Action**:
1. Read this summary (5 min) ✓
2. Review detailed docs if needed:
   - `project-scope-system.md` (design)
   - `workflow-unification.md` (design)
   - `P1-migration-plan.md` (implementation)
3. **Decision**: Approve / Request Changes / Defer

**If Approved**:
- Winston implements Phase 1 (3 hours)
- You test Phase 1 (30 min)
- Iterate until Phase 4 complete
- Total: ~11 hours Winston, ~1 hour you (testing)

---

## Approval

**Approved**: [ ]
**Changes Requested**: [ ]
**Deferred**: [ ]

**Notes**:
_[Your feedback here]_

---

**Status**: Awaiting your decision
**Contact**: Winston (this conversation)
**References**:
- Architecture docs in `docs/design-system/architecture/`
- Migration plan in `P1-migration-plan.md`
