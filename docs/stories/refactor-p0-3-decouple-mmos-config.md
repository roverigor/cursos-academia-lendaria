# Story: Decouple MMOS Config from AIOS Core

**Epic:** Architecture Refactoring
**Status:** 📋 NOT STARTED
**Priority:** P0 - CRITICAL
**Estimated Effort:** 2-3 days
**Category:** Architecture / Separation of Concerns

---

## User Story

*As a framework architect, I want MMOS-specific configuration moved out of AIOS core, so that the core framework is expansion-pack agnostic and MMOS can be disabled/removed without affecting the core.*

---

## Context

**Current State - Architectural Violation**:

Analysis of `docs/brownfield-architecture.md` identified:

**Problem File**: `.aios-core/mmos-config.yaml`

```yaml
# MMOS-Specific AIOS Configuration
# Override for MMOS-related work

markdownExploder: true
qa:
  qaLocation: docs/mmos/qa
prd:
  prdFile: docs/mmos/prd.md
  prdSharded: true
  prdShardedLocation: docs/mmos/prd
architecture:
  architectureFile: docs/mmos/architecture.md
slashPrefix: MMOS
epicLocation: docs/mmos/epics
boardLocation: docs/mmos/board
devStoryLocation: docs/mmos/stories
# ... more MMOS-specific config
```

**🚨 Architectural Violation**:
1. **Core framework has knowledge of MMOS** - Breaks separation of concerns
2. **Tight coupling** - Core cannot function without MMOS config
3. **Cannot disable MMOS** - Config hardcoded in core
4. **Blocks other packs** - Other expansion packs can't override core behavior

**Expected Architecture**:
- Core = **framework-agnostic** (no knowledge of expansion packs)
- Expansion packs = **self-contained** (own configs)
- Core discovers configs **dynamically** from packs

---

## Acceptance Criteria

### AC1: Move MMOS Config to Pack

**Given** `.aios-core/mmos-config.yaml` exists
**When** moving to expansion pack
**Then** must:

**Create**: `expansion-packs/mmos-mind-mapper/aios-integration.yaml`

```yaml
# MMOS AIOS Integration Configuration
# Loaded dynamically by core when MMOS pack is active

pack_name: mmos-mind-mapper
integration_type: core_override

# Core behavior overrides (when MMOS active)
markdownExploder: true

qa:
  qaLocation: docs/mmos/qa

prd:
  prdFile: docs/mmos/prd.md
  prdVersion: v1
  prdSharded: true
  prdShardedLocation: docs/mmos/prd
  epicFilePattern: EPIC-{n}*.md

architecture:
  architectureFile: docs/mmos/architecture.md
  architectureVersion: v1
  architectureSharded: true
  architectureShardedLocation: docs/mmos/architecture

customTechnicalDocuments:
  - docs/mmos/board/README.md
  - docs/mmos/pipeline/dna-mental-schema.yaml

devLoadAlwaysFiles:
  - docs/mmos/architecture/pipeline-overview.md
  - docs/mmos/pipeline/dna-mental-schema.yaml

devDebugLog: .ai/mmos-debug-log.md
devStoryLocation: docs/mmos/stories

slashPrefix: MMOS
epicLocation: docs/mmos/epics
boardLocation: docs/mmos/board
```

**Delete**: `.aios-core/mmos-config.yaml`

**Validation**:
- [ ] aios-integration.yaml created in MMOS pack
- [ ] Contains ALL config from mmos-config.yaml
- [ ] mmos-config.yaml deleted from core
- [ ] No references to mmos-config.yaml in code

---

### AC2: Implement Dynamic Config Discovery

**Given** expansion packs with aios-integration.yaml
**When** core initializes
**Then** must discover configs dynamically:

**Create**: `.aios-core/utils/config-loader.js`

```javascript
/**
 * Dynamic Expansion Pack Config Loader
 * Discovers and loads aios-integration.yaml from active packs
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

class ConfigLoader {
  /**
   * Discover all expansion packs with AIOS integration
   */
  discoverPacks(packsDir = 'expansion-packs') {
    const packs = [];
    const packDirs = fs.readdirSync(packsDir);

    for (const packDir of packDirs) {
      const integrationFile = path.join(packsDir, packDir, 'aios-integration.yaml');

      if (fs.existsSync(integrationFile)) {
        const config = yaml.load(fs.readFileSync(integrationFile, 'utf8'));
        packs.push({
          name: packDir,
          config: config
        });
      }
    }

    return packs;
  }

  /**
   * Load configuration for active pack
   */
  loadPackConfig(packName) {
    const integrationFile = `expansion-packs/${packName}/aios-integration.yaml`;

    if (!fs.existsSync(integrationFile)) {
      return null;
    }

    return yaml.load(fs.readFileSync(integrationFile, 'utf8'));
  }

  /**
   * Merge pack configs with core defaults
   */
  mergeConfigs(coreConfig, packConfigs) {
    // Deep merge strategy
    // Pack configs override core defaults
    return { ...coreConfig, ...packConfigs };
  }
}

module.exports = new ConfigLoader();
```

**Validation**:
- [ ] ConfigLoader class created
- [ ] Discovers packs with aios-integration.yaml
- [ ] Loads pack config dynamically
- [ ] Merges configs correctly (pack overrides core)

---

### AC3: Update Core to Use Dynamic Configs

**Given** dynamic config loader
**When** core needs configuration
**Then** must:

**Modify**: `.aios-core/index.js` (or core initialization file)

```javascript
const configLoader = require('./utils/config-loader');

// OLD (hardcoded):
// const mmosConfig = require('./mmos-config.yaml');

// NEW (dynamic):
const activePack = process.env.AIOS_ACTIVE_PACK || 'mmos-mind-mapper';
const packConfig = configLoader.loadPackConfig(activePack);
const coreConfig = require('./core-config.yaml');
const config = configLoader.mergeConfigs(coreConfig, packConfig);

// Use merged config throughout core
```

**Validation**:
- [ ] Core uses dynamic config loading
- [ ] No hardcoded references to MMOS
- [ ] Works with MMOS pack active
- [ ] Works with other packs (fallback to core-config.yaml)
- [ ] Environment variable controls active pack

---

### AC4: Enable Pack Activation/Deactivation

**Given** dynamic config system
**When** switching between packs
**Then** must support:

**Environment Variable**:
```bash
# Activate MMOS
export AIOS_ACTIVE_PACK=mmos-mind-mapper

# Activate Creator OS
export AIOS_ACTIVE_PACK=creator-os

# Deactivate all (core only)
unset AIOS_ACTIVE_PACK
```

**CLI Command** (optional):
```bash
# aios config --pack mmos-mind-mapper
# Updates .env with AIOS_ACTIVE_PACK=mmos-mind-mapper
```

**Validation**:
- [ ] AIOS_ACTIVE_PACK environment variable works
- [ ] Core behaves differently with different packs
- [ ] Core works without any pack active (fallback)
- [ ] No errors when switching packs

---

### AC5: Document Integration Pattern

**Given** new dynamic config system
**When** documenting
**Then** must create:

**File**: `.expansion-creator/docs/AIOS_INTEGRATION.md`

```markdown
# AIOS Integration for Expansion Packs

## Purpose

Allow expansion packs to override core AIOS behavior without modifying core files.

## How It Works

1. **Core discovers packs** - Scans expansion-packs/ for aios-integration.yaml
2. **Pack config loads** - AIOS_ACTIVE_PACK determines which pack is active
3. **Config merges** - Pack config overrides core-config.yaml defaults
4. **Core uses merged config** - Behavior adapts to active pack

## Creating aios-integration.yaml

```yaml
# expansion-packs/{pack-name}/aios-integration.yaml

pack_name: my-pack
integration_type: core_override

# Override any core configuration
qa:
  qaLocation: docs/my-pack/qa

prd:
  prdFile: docs/my-pack/prd.md

slashPrefix: MyPack
devStoryLocation: docs/my-pack/stories
```

## Activation

bash
export AIOS_ACTIVE_PACK=my-pack
```

## Testing

bash
# Test with pack
AIOS_ACTIVE_PACK=my-pack npm test

# Test without pack (core only)
npm test
```
```

**Validation**:
- [ ] Documentation created
- [ ] Pattern explained clearly
- [ ] Examples provided
- [ ] Testing instructions included

---

### AC6: Create Other Pack Integration Configs

**Given** pattern established
**When** enabling other packs
**Then** must create (optional, minimal):

**File**: `expansion-packs/creator-os/aios-integration.yaml`

```yaml
pack_name: creator-os
integration_type: core_override

slashPrefix: CreatorOS
devStoryLocation: docs/stories/creator-os
```

**File**: `expansion-packs/innerlens/aios-integration.yaml`

```yaml
pack_name: innerlens
integration_type: core_override

slashPrefix: InnerLens
devStoryLocation: docs/stories/innerlens
```

**Validation**:
- [ ] All 4 packs have aios-integration.yaml (even if minimal)
- [ ] Each pack can be activated independently
- [ ] No conflicts between pack configs

---

## Success Metrics

1. **Decoupling**: Zero MMOS references in `.aios-core/` (except config-loader)
2. **Flexibility**: Can activate/deactivate MMOS without code changes
3. **Extensibility**: Other packs can override core behavior
4. **Maintainability**: Core doesn't know about specific packs
5. **Backwards Compatibility**: MMOS functionality unchanged

---

## Technical Notes

### Config Merge Strategy

**Priority Order** (highest to lowest):
1. Pack-specific config (aios-integration.yaml)
2. Environment variables (AIOS_*)
3. Core defaults (core-config.yaml)

**Example Merge**:
```javascript
// core-config.yaml:
{ devStoryLocation: 'docs/stories' }

// aios-integration.yaml (MMOS):
{ devStoryLocation: 'docs/mmos/stories' }

// Merged (when MMOS active):
{ devStoryLocation: 'docs/mmos/stories' }  // Pack wins
```

### Rollback Plan

If dynamic config breaks existing functionality:
```bash
# 1. Restore mmos-config.yaml to core
git checkout HEAD -- .aios-core/mmos-config.yaml

# 2. Revert config-loader.js
git checkout HEAD -- .aios-core/utils/config-loader.js

# 3. Revert core initialization
git checkout HEAD -- .aios-core/index.js
```

### Testing Strategy

```javascript
// Test core with MMOS
process.env.AIOS_ACTIVE_PACK = 'mmos-mind-mapper';
const config = configLoader.loadPackConfig('mmos-mind-mapper');
expect(config.devStoryLocation).toBe('docs/mmos/stories');

// Test core without pack
delete process.env.AIOS_ACTIVE_PACK;
const coreConfig = configLoader.loadPackConfig('nonexistent');
expect(coreConfig).toBeNull();
```

---

## Dependencies

- js-yaml (already installed)
- None (uses existing infrastructure)

---

## Non-Goals (Out of Scope)

- ❌ Multiple packs active simultaneously (future)
- ❌ Pack dependency resolution (future)
- ❌ Hot-swapping packs without restart
- ❌ Pack versioning/compatibility checks

---

## Risks and Mitigations

### Risk 1: Config merge breaks MMOS functionality
**Mitigation**: Comprehensive tests, keep MMOS config identical initially

### Risk 2: Other code hardcodes MMOS paths
**Mitigation**: Search codebase for "docs/mmos" hardcoded strings

### Risk 3: Environment variable not set
**Mitigation**: Default to MMOS for backwards compatibility initially

---

## File List

**Created**:
- `expansion-packs/mmos-mind-mapper/aios-integration.yaml`
- `expansion-packs/creator-os/aios-integration.yaml`
- `expansion-packs/innerlens/aios-integration.yaml`
- `expansion-packs/etl-data-collector/aios-integration.yaml`
- `.aios-core/utils/config-loader.js`
- `.expansion-creator/docs/AIOS_INTEGRATION.md`

**Modified**:
- `.aios-core/index.js` (or core init file)
- `.aios-core/core-config.yaml` (document overridable fields)

**Deleted**:
- `.aios-core/mmos-config.yaml`

---

## Story Status

**Status**: 📋 NOT STARTED
**Source**: brownfield-architecture.md Section 3.5, Problem #3
**Blocked By**: None
**Blocks**: Adding new expansion packs (they can't override core)

---

**Priority Justification**: P0 - Architectural violation. Core should be pack-agnostic. Blocks expansion pack ecosystem growth.
