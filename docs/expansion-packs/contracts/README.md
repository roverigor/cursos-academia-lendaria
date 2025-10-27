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

## Active Contracts (4 Total)

### MMOS Pipeline (Orquestrador de Clonagem)
| Contract | Version | Service | Orchestrator | Type | Status | Created |
|----------|---------|---------|--------------|------|--------|---------|
| [**MMOS → ETL**](./mmos-etl-v1.0.0.yaml) | 1.0.0 | ETL Data Collector | MMOS | Request | ✅ Stable | 2025-10-27 |
| [**MMOS → InnerLens**](./mmos-innerlens-v1.0.0.yaml) | 1.0.0 | InnerLens | MMOS | Request | ✅ Stable | 2025-10-27 |

### CreatorOS Pipeline (Orquestrador de Conteúdo)
| Contract | Version | Service | Orchestrator | Type | Status | Created |
|----------|---------|---------|--------------|------|--------|---------|
| [**CreatorOS → MMOS**](./creator-os-mmos-v1.0.0.yaml) | 1.0.0 | MMOS | CreatorOS | Request | ✅ Stable | 2025-10-27 |
| [**CreatorOS → InnerLens**](./creator-os-innerlens-v1.0.0.yaml) | 1.0.0 | InnerLens | CreatorOS | RAG Query | ✅ Stable | 2025-10-27 |

---

## Contract Summaries

### MMOS → ETL (v1.0.0)
**Purpose:** MMOS orquestra coleta de fontes no processo de clonagem
**Integration:** MMOS invoca ETL → ETL coleta sources → retorna outputs/minds/{slug}/sources/
**Key features:**
- Request/response schema para orquestração
- File naming convention: `{type}_{identifier}_{date}.{ext}`
- Supported formats: `.md`, `.txt`, `.pdf`, `.html`, `.json`
- COLLECTION_SUMMARY.yaml com stats
- Error handling: partial collections, network failures

### MMOS → InnerLens (v1.0.0)
**Purpose:** MMOS orquestra análise psicométrica no processo de clonagem
**Integration:** MMOS invoca InnerLens → InnerLens extrai fragments + Big Five → salva no DB
**Key features:**
- Database tables: `sources`, `fragments`, `big_five_profiles`
- MIU fragments: Framework-agnostic behavioral units
- Quality gate BLOCKING (min 10 MIUs)
- Big Five scores: 0-100 range with confidence
- Fidelity boost: +2-3% (94% → 96-97%)

### CreatorOS → MMOS (v1.0.0)
**Purpose:** CreatorOS solicita MMOS criar versão "professor" para ensino
**Integration:** CreatorOS solicita → MMOS gera professor.md → CreatorOS usa para lições
**Key features:**
- **professor.md** - Sistema prompt especializado para ensino
- Integração InnerLens: Big Five contextualizado para pedagogia
- Voice fidelity: 96%+ (vs 92% com generalista)
- Filosofia de ensino do frameworks.md
- Request-based: on-demand generation

### CreatorOS → InnerLens (v1.0.0)
**Purpose:** CreatorOS consulta fragmentos via RAG durante geração de conteúdo
**Integration:** CreatorOS query → InnerLens busca fragments → retorna top-k relevantes
**Key features:**
- RAG query para contextual enrichment
- Keyword search (current) + semantic search (future)
- Relevance scoring (0.0-1.0)
- Top-k fragments com source attribution
- Fidelity boost: +8% (90% → 98% com RAG)

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
