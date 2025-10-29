# Story 2.4: Pipeline Integration with Database v3.0.0

**Story ID:** MMOS-2.4
**Epic:** Epic 2 - Database & Backend Foundation
**Priority:** HIGH
**Status:** 📋 Ready for Development
**Estimate:** 2-3 days
**Scope:** MMOS pipeline only (InnerLens in Story 4.2)
**Dependencies:**
- Story 2.1 ✅ (Database schema design)
- Story 2.2 ✅ (Specialization taxonomy population)
- Story 2.3 ✅ (Core minds population)
- Story 3.1 ✅ (Pilot migration - for testing with sam_altman)

---

## User Story

**As a** MMOS developer
**I want** the collection pipeline to populate the database v3.0.0 directly
**So that** new mind processing automatically creates sources, fragments, analysis, and proficiency scores

---

## Context

Currently, the MMOS pipeline generates YAML files:
- `sources_master.yaml`
- `cognitive-spec.yaml`
- `discovery_report.yaml`

But these files are **not connected to the database v3.0.0** (MMOS + InnerLens + Specialization).

We need to update the pipeline to:
1. Still generate YAML files (backward compatibility)
2. **Also populate the database in real-time**
3. Generate fragments from cognitive analysis
4. **[REMOVED]** ~~Score proficiencies~~ (moved to Story 4.3 - manual pilot first)
5. **[REMOVED]** ~~Create fragment tags~~ (moved to Story 4.3)
6. Support re-processing existing minds (UPDATE mode)

**Out of Scope:**
- InnerLens 120-trait analysis (Story 4.2)
- Automated proficiency scoring (Story 4.3)
- Fragment tags generation (Story 4.3)

---

## Acceptance Criteria

### AC0: Re-processing Strategy

**Decision:** Support both fresh insert and update modes

**Modes:**
- `--mode fresh`: Delete existing data first, then insert
- `--mode update`: Update existing records, insert new ones (ON CONFLICT)
- `--mode skip`: Skip if data already exists (default safe mode)

**Implementation:**
```bash
# Fresh re-process (clean slate)
bash scripts/pipeline/db-integration-v3.sh --mind sam_altman --mode fresh

# Update existing data
bash scripts/pipeline/db-integration-v3.sh --mind sam_altman --mode update

# Skip if exists (safe default)
bash scripts/pipeline/db-integration-v3.sh --mind sam_altman --mode skip
```

### AC1: Source Population Module

**File:** `scripts/pipeline/populate-sources.js`

**Function:**
- Reads `sources_master.yaml` from a mind directory
- Parses YAML sources list
- Inserts into `sources` table with proper foreign keys
- Maps source types: `blog → blog`, `youtube → video`, `pdf → document`
- Handles duplicates (ON CONFLICT)

**Success:**
```bash
node scripts/pipeline/populate-sources.js \
  --mind sam_altman \
  --file outputs/minds/sam_altman/sources/sources_master.yaml \
  --db SQLite legado (migrado para Supabase em 2025-10)

# Output:
# ✓ Inserted 35 new sources
# ✓ Updated 3 existing sources
# ✓ Total sources for sam_altman: 38
```

### AC2: Fragments Extraction Module

**File:** `scripts/pipeline/extract-fragments.js`

**Function:**
- Reads `cognitive-spec.yaml`
- Parses all 8 layers
- Extracts every `evidence` block with quotes
- Creates fragment for each evidence piece
- Links fragment to source via source_id
- Generates UUID for each fragment
- Sets cognitive_theme from layer context

**Fragment types mapping:**
- Blog evidence → `written_thought`
- Interview evidence → `dialogue`
- Testimony evidence → `statement`
- Observation from analysis → `meta_pattern`

**Success:**
```bash
node scripts/pipeline/extract-fragments.js \
  --mind sam_altman \
  --cognitive-spec outputs/minds/sam_altman/analysis/cognitive-spec.yaml \
  --db SQLite legado (migrado para Supabase em 2025-10)

# Output:
# ✓ Extracted 142 fragments from cognitive-spec
# ✓ Layer 1: 12 fragments
# ✓ Layer 2: 15 fragments
# ✓ Layer 3: 18 fragments
# ✓ Layer 4: 22 fragments
# ✓ Layer 5: 14 fragments
# ✓ Layer 6: 25 fragments
# ✓ Layer 7: 16 fragments
# ✓ Layer 8: 20 fragments
```

### AC3: Analysis Import Module

**File:** `scripts/pipeline/import-analysis.js`

**Function:**
- Reads complete `cognitive-spec.yaml`
- Stores entire YAML as JSON in `analysis` table
- Sets `analysis_type = 'dna_mental_cognitive_architecture'`
- Extracts confidence scores per layer
- Sets overall confidence_score

**Success:**
```bash
node scripts/pipeline/import-analysis.js \
  --mind sam_altman \
  --file outputs/minds/sam_altman/analysis/cognitive-spec.yaml \
  --db SQLite legado (migrado para Supabase em 2025-10)

# Output:
# ✓ Imported DNA Mental™ analysis
# ✓ Overall confidence: 0.90
# ✓ Layers analyzed: 8
# ✓ Total evidence points: 142
```

### AC4: Validation Module

**File:** `scripts/pipeline/validate-integration.js`

**Function:**
- Validates referential integrity
- Checks data completeness
- Identifies orphaned records
- Generates validation report

**Checks:**
1. All fragments link to valid source_id
2. All fragments link to valid mind_id
3. All sources link to valid mind_id
4. All analysis entries have valid mind_id
5. No orphaned records
6. Fragment content is valid JSON
7. Analysis content is valid JSON

**Success:**
```bash
node scripts/pipeline/validate-integration.js \
  --mind sam_altman \
  --db SQLite legado (migrado para Supabase em 2025-10)

# Output:
# ✓ Checking referential integrity...
# ✓ All 38 sources link to valid mind
# ✓ All 142 fragments link to valid source
# ✓ All 142 fragments link to valid mind
# ✓ Analysis entry links to valid mind
# ✓ No orphaned records found
# ✓ All fragment content is valid JSON
# ✓ Analysis content is valid JSON
#
# 📊 Validation Summary:
# • Total checks: 7
# • Passed: 7
# • Failed: 0
# • Status: ✅ PASS
```

### AC5: Integration Script

**File:** `scripts/pipeline/db-integration-v3.sh`

**Function:**
- Orchestrates all 4 modules sequentially
- Validates database state before/after
- Generates integration report
- Supports modes: `full`, `sources-only`, `analysis-only`
- Supports re-processing: `fresh`, `update`, `skip`

**Success:**
```bash
bash scripts/pipeline/db-integration-v3.sh --mind sam_altman --mode full

# Output:
# [INFO] Starting database integration for: sam_altman
# [INFO] Mode: full
# [SUCCESS] Found mind in database (ID: 22)
#
# [INFO] Phase 1: Populating sources...
# [SUCCESS] Sources populated successfully
#
# [INFO] Phase 2: Extracting fragments from analysis...
# [SUCCESS] Fragments extracted successfully
#
# [INFO] Phase 3: Importing DNA Mental™ analysis...
# [SUCCESS] Analysis imported successfully
#
# [INFO] Phase 4: Validating integration...
# 📊 Integration Report for: sam_altman
#
# • Sources: 38
# • Fragments: 142
# • Analysis entries: 1
# • Validation: ✅ PASS
#
# [SUCCESS] Database integration complete for: sam_altman
```

### AC6: Pipeline Update Task

**File:** `.claude/commands/MMOS/tasks/cognitive-analysis.md`

**Update:** Add database integration step at the end:

```markdown
## Passos
1. Carregar notas de discovery e outputs do ETL
2. Para cada camada selecionada, preencher seções em `analysis/layers/{layer}.md`
3. Gerar `cognitive-spec.yaml` completo
4. **[NEW]** Executar integração com banco de dados:
   ```bash
   bash scripts/pipeline/db-integration-v3.sh \
     --mind {mind_slug} \
     --mode analysis-only
   ```
5. Registrar lacunas e evidências adicionais necessárias
6. Atualizar `STATUS.md` com progresso da análise
```

---

## Success Metrics

**Per Mind Integration:**
- ✅ All sources from sources_master.yaml imported (100%)
- ✅ 50-200 fragments extracted from cognitive-spec
- ✅ 1 DNA Mental™ analysis stored
- ✅ 100% referential integrity validated
- ✅ Re-processing modes working (fresh/update/skip)

**Code Quality:**
- ✅ All scripts have error handling
- ✅ All scripts support dry-run mode
- ✅ All scripts generate detailed logs
- ✅ All scripts are idempotent (safe to re-run)

**Performance:**
- ⏱️ Source population: <30 seconds per mind
- ⏱️ Fragment extraction: <2 minutes per mind
- ⏱️ Analysis import: <30 seconds per mind
- ⏱️ Validation: <30 seconds per mind
- ⏱️ Total integration: <5 minutes per mind

---

## Implementation Plan

### Day 1 (3-4 hours)

**Morning:**
1. Create `populate-sources.js` (1 hour)
2. Create `import-analysis.js` (45 min)
3. Create `extract-fragments.js` (1.5 hours)

**Afternoon:**
4. Create `validate-integration.js` (45 min)

### Day 2 (2-3 hours)

**Morning:**
5. Create `db-integration-v3.sh` orchestrator (1 hour)
6. Test with sam_altman (pilot validation) (1 hour)

**Afternoon:**
7. Fix bugs and edge cases (30-60 min)
8. Update MMOS task files (30 min)

### Day 3 (OPTIONAL - if issues found)

**Extended Testing:**
9. Run integration on 3 additional minds (1 hour)
10. Performance optimization if needed (1 hour)

---

## Technical Design

### Database Schema Mapping

```
YAML Files                    →  Database Tables
─────────────────────────────────────────────────────────
sources_master.yaml           →  sources
  ├─ id                       →    id (UUID or slug)
  ├─ type                     →    source_type
  ├─ title                    →    title
  ├─ url                      →    url
  ├─ file_path                →    file_path
  ├─ word_count               →    word_count
  └─ confidence               →    confidence

cognitive-spec.yaml           →  fragments + analysis
  ├─ layer_N.evidence         →    fragments
  │    ├─ source             →      source_id (FK)
  │    ├─ quote              →      content (JSON)
  │    └─ description        →      why_significant
  ├─ full spec               →    analysis (JSON)
  └─ confidence              →    confidence_score

**Note:** Proficiency scoring moved to Story 4.3
```

### Fragment Content JSON Structure

```json
{
  "text": "Trust the exponential, be patient, and be pleasantly surprised.",
  "context": "Layer 1 - Sensory Inputs - Preferred Inputs",
  "source_context": "Blog post: How To Be Successful",
  "layer": 1,
  "layer_name": "Sensory Inputs & Context"
}
```

### Re-processing Strategy

```
Mode: fresh
1. DELETE FROM fragments WHERE mind_id = ?
2. DELETE FROM sources WHERE mind_id = ?
3. DELETE FROM analysis WHERE mind_id = ?
4. INSERT new data

Mode: update
1. INSERT ... ON CONFLICT(unique_key) DO UPDATE

Mode: skip
1. Check if data exists
2. Skip if found
3. Insert only new records
```

---

## Risks & Mitigations

**Risk 1: YAML parsing errors**
- **Mitigation:** Use robust YAML parsers (js-yaml), validate schema, graceful degradation

**Risk 2: Fragment duplication**
- **Mitigation:** Content hashing, check before insert, unique constraints

**Risk 3: Re-processing data corruption**
- **Mitigation:** Always backup before `--mode fresh`, transaction rollback on error

**Risk 4: Performance degradation**
- **Mitigation:** Batch inserts, database indexes, async processing

**Risk 5: Breaking existing pipeline**
- **Mitigation:** Backward compatibility (keep YAML generation), test with sam_altman pilot

---

## Testing Strategy

### Unit Tests
- ✅ YAML parsing (malformed files)
- ✅ Fragment extraction (various layer structures)
- ✅ Re-processing modes (fresh/update/skip)
- ✅ Database transactions (rollback on error)

### Integration Tests
- ✅ Full pipeline with sam_altman
- ✅ Validate referential integrity
- ✅ Check data completeness
- ✅ Performance benchmarks

### Edge Cases
- ✅ Mind with 0 sources
- ✅ Mind with empty cognitive-spec
- ✅ Mind with only 1-2 evidence pieces
- ✅ Mind with partial cognitive-spec (layers 1-4 only)
- ✅ Re-running integration (all 3 modes)

---

## Next Steps After Completion

1. ✅ Story 2.4 complete: MMOS pipeline integrated with database
2. → **Story 3.1.1**: Full rollout to remaining 27 minds
3. → **Epic 4 Story 4.1**: InnerLens 120-trait analysis integration
4. → **Epic 4 Story 4.2**: Automated proficiency scoring + fragment tags
5. → **Epic 4 Story 4.3**: Real-time sync (watch files → auto-update DB)

---

**Created:** October 12, 2025
**Last Updated:** October 13, 2025 (Moved from Story 4.1 to Epic 2)
**Author:** Mary (Business Analyst) + Dev Team
**Epic:** Epic 2 - Database & Backend Foundation
**Story Points:** 8 (Fibonacci - reduced after scope cut)

---

## Checklist

### Phase 1: Core Scripts
- [ ] populate-sources.js
- [ ] import-analysis.js (moved before fragments)
- [ ] extract-fragments.js
- [ ] validate-integration.js

### Phase 2: Integration
- [ ] db-integration-v3.sh
- [ ] Update MMOS tasks
- [ ] Test with sam_altman

### Phase 3: Validation
- [ ] Referential integrity check
- [ ] Data quality validation
- [ ] Performance benchmarks
- [ ] Documentation complete

### Phase 4: Rollout
- [ ] Process andrej_karpathy
- [ ] Process 5 more incomplete minds
- [ ] Full 28-mind validation
