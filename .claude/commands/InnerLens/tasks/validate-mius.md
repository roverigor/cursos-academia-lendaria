# /validate-mius Task

Quality validation and consistency checking for personality profiles.

**Task ID:** validate-mius
**Agent:** @quality-assurance
**Version:** 1.0.0

---

## Purpose

Independent quality validation of personality profiles before delivery to users.

**Validation Levels:**
- VALIDATED_HIGH (75%+ confidence, 5+ evidence per trait)
- VALIDATED_MEDIUM (60-74% confidence, 3-4 evidence per trait)
- PROVISIONAL (50-59% confidence, requires more data)
- REJECTED (low quality, do not use)

---

## Inputs

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `profile` | path | Yes | Path to raw profile (e.g., bigfive-raw.yaml) |
| `framework` | string | Yes | Framework to validate (bigfive, hexaco, etc.) |
| `output` | path | Yes | Where to save validated profile |

---

## Workflow Steps

1. **Load Profile** - Read raw profile from @psychologist
2. **Load Checklist** - Load framework-specific quality checklist
3. **Statistical Validation** - Check mean, std dev, outliers
4. **Consistency Checks** - Verify facet-trait alignment
5. **Evidence Quality** - Validate sufficiency and diversity
6. **Assign Outcome** - VALIDATED_HIGH/MEDIUM/PROVISIONAL/REJECTED
7. **Generate Final Profile** - Output validated YAML

---

## Success Criteria

- [ ] All quality checks passed
- [ ] Validation outcome assigned
- [ ] Final profile generated
- [ ] Evidence quality validated
- [ ] Confidence calibration verified

---

**Full Task Specification:** `expansion-packs/innerlens/tasks/validate-mius.md`
