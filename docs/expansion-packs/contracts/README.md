# Integration Contracts

**Versioned contracts defining interfaces between expansion packs**

---

## What Are Contracts?

A **contract** is a versioned specification of how two expansion packs communicate:

- **Data format** - YAML, JSON, Markdown, SQL
- **Location** - File paths, database tables
- **Required fields** - What must be present
- **Optional fields** - What may be present
- **Versioning** - Semantic versioning (MAJOR.MINOR.PATCH)
- **Backward compatibility** - What's guaranteed

---

## Active Contracts

| Contract | Version | Provider | Consumer | Status |
|----------|---------|----------|----------|--------|
| ETL → MMOS | [1.0.0](./etl-mmos-v1.0.0.yaml) | ETL Data Collector | MMOS | ✅ Stable |
| InnerLens → MMOS | [1.0.0](./innerlens-mmos-v1.0.0.yaml) | InnerLens | MMOS | ✅ Stable |
| MMOS → CreatorOS | [1.0.0](./mmos-creator-os-v1.0.0.yaml) | MMOS | CreatorOS | ✅ Stable |

---

## Contract Template

**Filename:** `{provider}-{consumer}-v{version}.yaml`

```yaml
contract:
  name: "Provider → Consumer Integration"
  version: "1.0.0"
  status: "experimental | stable | deprecated | retired"
  provider: "Pack Name"
  consumer: "Pack Name"
  created_date: "YYYY-MM-DD"
  last_updated: "YYYY-MM-DD"

  description: |
    Brief description of what this contract defines.

  interface:
    type: "file | database | directory"
    format: "YAML | Markdown | JSON | SQL"
    location: "path/to/interface"
    encoding: "UTF-8"

    # For file-based contracts
    required_sections:
      - name: "Section Name"
        format: "Markdown heading | YAML field"
        description: "What this section contains"

    optional_sections:
      - name: "Optional Section"
        format: "Markdown heading | YAML field"
        description: "What this section contains"
        added_in: "1.0.0"

    # For database contracts
    tables:
      - name: "table_name"
        required_columns:
          - column_name: "type"
        optional_columns:
          - column_name: "type"

  schema:
    # Example data structure
    example: |
      field1: value
      field2: value

  validation:
    # How to validate contract compliance
    rules:
      - "Required fields must be present"
      - "Values must match type constraints"

  backward_compatibility:
    guarantees:
      - "What will not change in MINOR versions"
      - "Deprecation policy for MAJOR versions"

  versioning:
    current: "1.0.0"
    breaking_changes_history:
      - version: "1.0.0"
        date: "YYYY-MM-DD"
        change: "Initial contract definition"

  usage_example:
    provider_code: |
      # How provider writes data
      await writeContract(...)

    consumer_code: |
      # How consumer reads data
      await readContract(...)

  testing:
    test_file: "tests/contracts/provider-consumer.test.js"
    validation_command: "*validate-contract provider-consumer-v1.0.0.yaml"

  owners:
    provider_maintainer: "[Name]"
    consumer_maintainer: "[Name]"
    integration_owner: "[Name]"
```

---

## Contract Lifecycle

### 1. Experimental
- **Status:** Under development
- **Stability:** May change frequently
- **Use in production:** No

### 2. Stable
- **Status:** Production-ready
- **Stability:** Follows semver
- **Use in production:** Yes

### 3. Deprecated
- **Status:** Scheduled for removal
- **Stability:** No new features
- **Use in production:** Migrate away
- **Sunset date:** Specified

### 4. Retired
- **Status:** No longer supported
- **Stability:** N/A
- **Use in production:** No

---

## Semantic Versioning

**MAJOR.MINOR.PATCH**

### MAJOR (Breaking Changes)
- Remove required field
- Change data type
- Change file location
- Incompatible with previous version

**Example:** `v1.0.0` → `v2.0.0`

### MINOR (Backward Compatible)
- Add optional field
- Add new section
- Extend existing functionality

**Example:** `v1.0.0` → `v1.1.0`

### PATCH (Bug Fixes)
- Clarify documentation
- Fix examples
- No functional changes

**Example:** `v1.0.0` → `v1.0.1`

---

## Creating New Contract

1. **Copy template** to `{provider}-{consumer}-v1.0.0.yaml`
2. **Fill in details** (interface, schema, validation)
3. **Add example** (provider code, consumer code)
4. **Create test** in `tests/contracts/`
5. **Get approval** from Integration Owner
6. **Document** in pack READMEs

---

## Updating Existing Contract

### MINOR Update (Backward Compatible)

1. Copy `v1.0.0` → `v1.1.0`
2. Add new optional fields
3. Update `breaking_changes_history`
4. No consumer changes required

### MAJOR Update (Breaking Change)

1. Copy `v1.0.0` → `v2.0.0`
2. Make breaking changes
3. Create migration guide
4. Update both provider and consumer
5. Deprecate `v1.0.0` (set sunset date)
6. Coordinate release with both packs

---

## Contract Testing

**Test file:** `tests/contracts/{provider}-{consumer}.test.js`

```javascript
describe('Contract: ETL → MMOS v1.0.0', () => {
  it('should validate compliant data', async () => {
    const data = await ETL.collectSources('test');
    const contract = await loadContract('etl-mmos-v1.0.0.yaml');
    const result = await validateContract(data, contract);
    expect(result.valid).toBe(true);
  });

  it('should reject missing required fields', async () => {
    const invalidData = { /* missing required */ };
    const contract = await loadContract('etl-mmos-v1.0.0.yaml');
    const result = await validateContract(invalidData, contract);
    expect(result.valid).toBe(false);
  });
});
```

---

## Questions?

- **When to create new contract?** - When creating new integration point
- **Who owns contract?** - Integration Owner (coordinates both packs)
- **How to propose changes?** - Create proposal in `proposals/` directory

---

**See also:**
- [Governance Model](../governance.md#contract-management)
- [Dependency Graph](../dependency-graph.md#integration-points)
