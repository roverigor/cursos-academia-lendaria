# MMOS Mind Mapper - Templates & Checklists

**Created:** 2025-10-06
**Version:** 1.0
**Purpose:** Comprehensive template and checklist system for DNA Mental™ methodology

---

## Overview

This document catalogs all templates and checklists created for the MMOS Mind Mapper expansion pack. These tools support the complete pipeline from viability assessment through production deployment.

---

## TEMPLATES (10 total)

Located in: `expansion-packs/mmos-mind-mapper/templates/`

### 1. viability_output.yaml
**Purpose:** APEX + ICP assessment results
**Contents:**
- 6 APEX dimensions (Availability, Personality, Evolution, eXpertise, Legal)
- ICP score (Recognition, Alignment, Density, Singularity, Applicability)
- GO/NO-GO decision matrix
- Strategic considerations
**Format:** YAML
**Usage:** Stage 1 - Viability Assessment output

### 2. prd_template.md
**Purpose:** Mind Product Requirements Document
**Contents:**
- Personality overview
- Use cases and requirements
- Technical specifications
- DNA Mental™ layer requirements
- Quality standards
**Format:** Markdown
**Usage:** Stage 1 - Created after viability approval

### 3. cognitive_spec.yaml
**Purpose:** 8-layer cognitive specification
**Contents:**
- Complete DNA Mental™ 8-layer mapping
- Evidence tracking per layer
- Confidence levels
- Implementation notes
**Format:** YAML (structured data)
**Usage:** Stage 3 - Analysis output, blueprint for implementation

### 4. mind_brief.md
**Purpose:** Single source of truth for mind development
**Contents:**
- Objectives and use cases
- Viability scores
- Core essence and obsessions
- Source inventory
- Roadmap and checkpoints
**Format:** Markdown
**Usage:** All stages - Central coordination document

### 5. sources_master.yaml
**Purpose:** Complete source inventory and tracking
**Contents:**
- Tiered sources (1-4)
- Temporal coverage mapping
- DNA Mental™ layer coverage per source
- Gaps and acquisition strategy
**Format:** YAML
**Usage:** Stage 2 - Research phase primary output

### 6. personality_profile.json
**Purpose:** Psychometric analysis (Big 5, DISC, Enneagram, MBTI, Stratification)
**Contents:**
- All major personality frameworks
- Integrative synthesis
- Evidence quality tracking
**Format:** JSON
**Usage:** Stage 3 - Analysis artifact

### 7. system_prompt_generalista.md
**Purpose:** Full cognitive architecture system prompt
**Contents:**
- All 8 DNA Mental™ layers integrated
- Communication style
- Paradoxes and contradictions
- Interaction guidelines
**Format:** Markdown
**Usage:** Stage 5 - Implementation (primary prompt)

### 8. system_prompt_specialist.md
**Purpose:** Domain-specific specialist prompt
**Contents:**
- Focused layer emphasis
- Domain expertise integration
- Specialist workflows
- Scope boundaries
**Format:** Markdown
**Usage:** Stage 5 - Implementation (specialist variants)

### 9. validation_report.yaml
**Purpose:** Fidelity testing results
**Contents:**
- Layer-by-layer fidelity scores
- Personality consistency tests
- Edge case validation
- Production readiness assessment
**Format:** YAML
**Usage:** Stage 6 - Testing output

### 10. brownfield_plan.yaml
**Purpose:** Incremental update strategy for existing minds
**Contents:**
- Change impact assessment
- Layer-by-layer update plan
- Regression testing strategy
- Rollback procedures
**Format:** YAML
**Usage:** Post-production - Brownfield updates

---

## CHECKLISTS (6 total)

Located in: `expansion-packs/mmos-mind-mapper/checklists/`

### 1. viability_checklist.md
**Purpose:** Pre-pipeline validation
**Sections:**
- APEX scorecard evaluation (5 dimensions)
- ICP score evaluation (5 weighted criteria)
- Decision matrix application
- Strategic considerations
- Human checkpoint preparation
**Gates:** GO/NO-GO decision
**Critical Items:** Legal status, source availability, ROI
**Usage:** Stage 1 - Before committing to full pipeline

### 2. research_quality_checklist.md
**Purpose:** Source quality validation
**Sections:**
- Source inventory completeness
- Content volume assessment
- Source quality per tier
- Temporal coverage validation
- DNA Mental™ layer coverage
- Triangulation readiness
**Gates:** PROCEED/NEEDS WORK/STOP
**Critical Items:** Minimum 15 sources, 60% temporal coverage, all layers have good+ coverage
**Usage:** Stage 2 - Before analysis begins

### 3. analysis_completeness_checklist.md
**Purpose:** 8-layer coverage verification with triangulation
**Sections:**
- Layer-by-layer completeness (all 8)
- Triangulation validation (3+ sources per trait)
- Psychometric analysis completeness
- COGNITIVE_SPEC.md validation
- Gaps documentation
**Gates:** GO/CONDITIONAL/NO-GO for synthesis
**Critical Items:** All layers GOOD+, triangulation ≥70%, all artifacts created
**Usage:** Stage 3 - Before synthesis

### 4. system_prompt_validation_checklist.md
**Purpose:** Fidelity testing criteria
**Sections:**
- Layer-by-layer fidelity testing (test cases per layer)
- Personality fidelity (communication, paradoxes)
- Blind testing (optional)
- Consistency testing
- Edge case validation
**Gates:** PASS/CONDITIONAL/FAIL (85%+ required)
**Critical Items:** Layer 4 (values) ≥90%, communication ≥90%, zero critical issues
**Usage:** Stage 6 - Before production deployment

### 5. production_readiness_checklist.md
**Purpose:** Final QA before deployment
**Sections:**
- Pipeline completion (all 6 stages)
- File structure validation (ACS v3.0)
- Naming convention compliance
- Documentation quality
- Fidelity metrics validation
- Issue resolution
- Deployment checklist
- Post-deployment monitoring
**Gates:** DEPLOY/HOLD/CANCEL
**Critical Items:** All stages complete, fidelity ≥85%, all approvals obtained
**Usage:** Stage 6 - Production deployment gate

### 6. brownfield_safety_checklist.md
**Purpose:** Update safety and rollback verification
**Sections:**
- Pre-update safety (backup verification)
- Change impact assessment
- Safety gates (values protection)
- Testing requirements
- Incremental execution
- Rollback procedures
- Monitoring and alerts
- Success criteria
**Gates:** PROCEED/HOLD/ROLLBACK
**Critical Items:** Backup verified, values protected, rollback tested
**Usage:** Post-production - Brownfield updates

---

## Quality Standards

### Template Standards
- All templates follow YAML/Markdown format as appropriate
- Clear placeholder instructions
- Reference DNA Mental™ methodology
- Include validation criteria
- Version controlled

### Checklist Standards
- Comprehensive with specific criteria
- Pass/fail indicators for each section
- Quality thresholds defined
- Human checkpoint requirements
- Audit trail support

---

## Integration with Pipeline

### Stage 1: Viability
- **Templates:** viability_output.yaml, prd_template.md, mind_brief.md
- **Checklists:** viability_checklist.md

### Stage 2: Research
- **Templates:** sources_master.yaml
- **Checklists:** research_quality_checklist.md

### Stage 3: Analysis
- **Templates:** cognitive_spec.yaml, personality_profile.json
- **Checklists:** analysis_completeness_checklist.md

### Stage 4: Synthesis
- **Templates:** (uses artifacts from Stage 3)
- **Checklists:** (quality embedded in Stage 3 checklist)

### Stage 5: Implementation
- **Templates:** system_prompt_generalista.md, system_prompt_specialist.md
- **Checklists:** (preparation for Stage 6)

### Stage 6: Testing
- **Templates:** validation_report.yaml
- **Checklists:** system_prompt_validation_checklist.md, production_readiness_checklist.md

### Post-Production: Brownfield
- **Templates:** brownfield_plan.yaml
- **Checklists:** brownfield_safety_checklist.md

---

## Usage Guidelines

### For New Minds (Greenfield)
1. Start with viability_checklist.md
2. Use viability_output.yaml to document decision
3. Progress through pipeline with appropriate checklists at each stage
4. Use templates to structure all outputs
5. Complete production_readiness_checklist.md before deployment

### For Existing Minds (Brownfield)
1. Use brownfield_plan.yaml to plan update
2. Follow brownfield_safety_checklist.md for safe execution
3. Re-run relevant analysis/synthesis as needed
4. Always verify values protection
5. Test rollback before making changes

### Quality Gates
- Each checklist has clear PASS/FAIL criteria
- Human checkpoints required at critical stages
- Triangulation requirements enforced (3+ sources)
- Fidelity thresholds defined (85%+)
- Safety mechanisms for brownfield updates

---

## File Naming Conventions

### Templates
- Format: `{descriptor}.{ext}`
- Examples: `viability_output.yaml`, `prd_template.md`
- Use snake_case throughout

### Checklists
- Format: `{stage}_checklist.md`
- Examples: `viability_checklist.md`, `research_quality_checklist.md`
- Use snake_case throughout

### Output Files (when using templates)
- Format: `YYYYMMDD-HHMM-{descriptor}.{ext}`
- Examples: `20251006-1400-viability.yaml`
- Store in appropriate mind directory

---

## Maintenance

### Version Control
- Templates version: 1.0
- Checklists version: 1.0
- Update version when making changes
- Document changes in this file

### Feedback Loop
- Collect lessons learned from usage
- Update templates based on real-world needs
- Refine checklists for clarity
- Add examples where helpful

---

## Related Documentation

- `/expansion-packs/mmos-mind-mapper/README.md` - Expansion pack scripts and tasks
- `/docs/mmos/` - MMOS outputs (minds, reports, benchmarks, validations)
- `/docs/minds/` - Individual mind outputs (sources, analysis, synthesis, system-prompts)

---

**Last Updated:** 2025-10-06
**Maintained By:** MMOS Mind Mapper Team
**Version:** 1.0
