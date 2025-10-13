# Story 3.1.1: Full Migration Rollout (27 Minds)

**Story ID:** MMOS-3.1.1
**Epic:** Epic 3 - Taxonomy Normalization & Migration
**Priority:** Medium (after Epic 2 validation)
**Status:** 📋 Ready for Development
**Estimate:** 1-2 days
**Dependencies:**
- Story 3.1 ✅ (Pilot Complete)
- Story 2.4 (recommended - validates database integration with sam_altman first)

---

## User Story

**As a** MMOS developer
**I want** to migrate the remaining 27 minds using the validated Story 3.1 scripts
**So that** all minds have standardized structure for database population

---

## Context

Story 3.1 successfully migrated **sam_altman** as a pilot. All scripts are:
- ✅ Implemented and tested
- ✅ Idempotent
- ✅ Backward compatible

Story 2.4 will use sam_altman to validate the database integration before full rollout.

---

## Acceptance Criteria

### AC1: Migrate Remaining 27 Minds

**Command:**
```bash
bash scripts/migration/migrate_story_3.1.sh --all --skip sam_altman
```

**Expected Output:**
- 27 minds migrated successfully
- 135 new files created (5 per mind)
- Migration log generated

**Minds to migrate:**
```
alan_nicolas       dan_koe            kapil_gupta        peter_thiel        tim_ferriss
alex_hormozi       daniel_kahneman    leonardo_da_vinci  ricky_and_morty    walt_disney
andrej_karpathy    elon_musk          mark_manson        russel_brunson     yuval_harari
brad_frost         eugene_schwartz    nassim_taleb       seth_godin
dan_kennedy        gary_vee           naval_ravikant     steve_jobs
                   jesus_cristo       paul_graham        steven_pinker
                                      pedro_valerio
```

### AC2: Validation Suite Implementation

Create validation scripts:

**File:** `scripts/validation/validate_minds.js`
```javascript
// Validates all metadata.yaml files
// Checks: schema compliance, required fields, enum values
```

**File:** `scripts/validation/validate_sources.js`
```javascript
// Validates all sources_master.yaml files
// Checks: source files exist, valid types, layer_relevance range
```

**Package.json updates:**
```json
{
  "scripts": {
    "validate:minds": "node scripts/validation/validate_minds.js",
    "validate:sources": "node scripts/validation/validate_sources.js",
    "validate:all": "npm run validate:minds && npm run validate:sources"
  }
}
```

### AC3: Run Validation and Fix Errors

```bash
npm run validate:all
```

**Expected:**
- Generate validation report (JSON + Markdown)
- List all minds with issues
- Fix errors (likely README format variations)
- Re-run until 100% pass

### AC4: Documentation Updates

Update 3 documentation files:

1. **`docs/mmos/architecture/taxonomy-system.md`**
   - Add "Story 3.1 Implementation" section
   - Document metadata.yaml schema
   - Show before/after directory structure

2. **`docs/mmos/guides/mind-onboarding.md`**
   - Update with new required files
   - Add metadata.yaml template
   - Include validation checklist

3. **`README.md`** (project root)
   - Update file tree example
   - Add "MMOS Taxonomy v2.0" section
   - Note Story 3.1 completion

---

## Success Metrics

- ✅ All 28 minds have metadata.yaml
- ✅ All 28 minds have sources_master.yaml
- ✅ All 28 minds have pipeline_progress.yaml
- ✅ All 28 minds have kb/etl_questions.yaml
- ✅ All 28 minds have versioned system_prompts/
- ✅ Validation suite passes 100%
- ✅ Migration completes in <5 minutes
- ✅ Documentation updated

---

## Timeline

**Day 1 (4-5 hours):**
- Morning: Run full migration (30 min)
- Morning: Create validation scripts (2-3 hours)
- Afternoon: Run validation, fix errors (1-2 hours)

**Day 2 (2-3 hours):**
- Morning: Update documentation (2 hours)
- Afternoon: Final validation + commit (1 hour)

---

## Risks

1. **Varied README formats** - Some minds may have non-standard READMEs
   - Mitigation: Default values + manual review flags

2. **Missing sources directories** - Some minds may not have sources/
   - Mitigation: Scripts handle gracefully (create empty sources_master.yaml)

3. **Performance** - 27 minds may take longer than expected
   - Mitigation: Scripts are fast (<10s per mind), ~5 min total

---

## Next Steps After Completion

1. ✅ All 28 minds normalized
2. → Database population can scale to all 28 minds
3. → Story 3.2 (Artifacts Reorganization) can proceed
4. → Validation CI/CD can be implemented

---

**Created:** October 12, 2025
**Last Updated:** October 13, 2025 (Fixed dependency reference)
**To be scheduled:** After Story 2.4 validation
