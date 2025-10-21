# MMOS Configuration Guide

**Document:** Quick guide to customize MMOS mind loading in CreatorOS
**Created:** 2025-10-20
**Config File:** `expansion-packs/creator-os/config/mmos-paths.yaml`

---

## 🎯 Purpose

The `mmos-paths.yaml` configuration file allows you to **customize which files** the CreatorOS loads from MMOS minds when integrating instructor personas into course generation.

**Why this matters:**
- Support different MMOS versions (v2.x, v3.0, custom structures)
- Adapt to your specific mind organization
- Change extraction priorities without modifying code
- Adjust confidence scoring weights
- Add new tone mappings

---

## 📍 File Location

```
expansion-packs/creator-os/config/mmos-paths.yaml
```

**Loaded by:** `lib/mmos_integrator.py` (automatically)

**Fallback:** If config file not found, uses hardcoded defaults (MMOS v3.0 structure)

---

## 🔧 Common Customizations

### **1. Change File Paths (Support MMOS v2.x)**

**Use case:** Your minds still use old structure (`analysis/` instead of `artifacts/`)

**Edit this section:**
```yaml
paths:
  identity_core:
    paths:
      - "analysis/identity-core.yaml"     # v2.x FIRST (higher priority)
      - "artifacts/identity_core.yaml"    # v3.0 fallback
```

**How priority works:**
- Integrator checks paths **in order**
- First existing file wins
- No file found? Uses fallback values

---

### **2. Add Custom Voice Files**

**Use case:** You store voice profiles in a custom location

**Edit this section:**
```yaml
paths:
  communication_style:
    paths:
      - "custom/my-voice-profile.md"               # Your custom path
      - "artifacts/communication_templates.md"      # Standard fallback
      - "kb/communication_style_final.md"          # Final fallback
```

---

### **3. Change Extraction Limits**

**Use case:** You want more/fewer recurring phrases or language patterns

**Edit this section:**
```yaml
extraction:
  max_items:
    language_patterns: 10       # Default: 5
    recurring_phrases: 20       # Default: 10
    core_values: 10            # Default: 5
    worldview_items: 5         # Default: 3
    teaching_philosophy_bullets: 10  # Default: 5
```

**Result:** COURSE-BRIEF will include more/fewer items

---

### **4. Add New Tone Mappings**

**Use case:** Your minds have Portuguese traits not yet mapped

**Edit this section:**
```yaml
tone_mapping:
  "Humorístico": "Humorous, witty"
  "Sério": "Serious, formal"
  "Minimalista": "Minimalist, concise"
  "Detalhista": "Detail-oriented, thorough"
  # Add more as needed
```

**Result:** Tone extraction will recognize new traits

---

### **5. Change YAML Field Names**

**Use case:** Your MMOS minds use different field names

**Edit this section:**
```yaml
extraction:
  yaml_fields:
    identity_core:
      name: "full_name"           # Default: "nome_completo"
      traits: "personality_traits"  # Default: "tracos_personalidade"
      values: "core_values"        # Default: "valores_centrais"
      worldview: "world_view"      # Default: "visao_de_mundo"

    cognitive_architecture:
      personality_summary: "summary"    # Default: "resumo_personalidade"
      communication_style: "comm_style"  # Default: "estilo_comunicacao"
```

**Result:** Integrator will look for your custom field names

---

### **6. Adjust Confidence Scoring**

**Use case:** You want to weight certain data more/less

**Edit this section:**
```yaml
confidence_scoring:
  weights:
    identity_core: 40           # Default: 30 (increased importance)
    cognitive_architecture: 30  # Default: 30
    communication_style: 20     # Default: 30 (decreased importance)
    frameworks: 10              # Default: 10 (bonus)
```

**Constraint:** Total should be ≤100

**Result:** Minds with better identity data score higher

---

### **7. Change Minimum Content Lengths**

**Use case:** You have shorter/longer files and want different thresholds

**Edit this section:**
```yaml
extraction:
  min_lengths:
    communication_style: 1000   # Default: 500 chars
    frameworks: 500             # Default: 200 chars
    teaching_philosophy: 200    # Default: 100 chars
```

**Result:** Confidence scoring uses new thresholds

---

### **8. Add Custom Markdown Section Patterns**

**Use case:** Your communication style uses different section headers

**Edit this section:**
```yaml
paths:
  communication_style:
    sections:
      recurring_phrases:
        - "##\\s*Frases Recorrentes"
        - "##\\s*Catchphrases"
        - "##\\s*Meus Bordões"          # Your custom header
        - "##\\s*Signature Lines"       # Another custom header
```

**Result:** Integrator will find phrases under custom headers

---

## 📊 Configuration Structure Overview

```yaml
version: "1.0"                    # Config file version
mmos_version: "3.0"               # Target MMOS structure version

paths:                            # File path definitions
  identity_core: {...}
  cognitive_architecture: {...}
  communication_style: {...}
  frameworks: {...}
  system_prompts: {...}
  metadata: {...}

extraction:                       # Extraction parameters
  max_items: {...}                # List limits
  min_lengths: {...}              # Minimum content lengths
  yaml_fields: {...}              # Field name mappings

confidence_scoring:               # Scoring weights
  weights: {...}
  min_confidence: 40              # Minimum valid score

tone_mapping:                     # Trait → English tone
  "Inspirador": "Inspirational, motivational"
  # ...

fallbacks:                        # Default values
  tone: "Professional, clear"
  style: "Clear and engaging"
  # ...
```

---

## 🧪 Testing Your Configuration

### **1. Validate Configuration**

```bash
cd expansion-packs/creator-os

# Test MMOS integrator with your config
python lib/mmos_integrator.py
```

**Expected output:**
```
✓ Loaded MMOS config from /path/to/mmos-paths.yaml
MMOS Integrator - Testing Mode

Scanning for MMOS minds...

✓ Found 3 MMOS minds:

  - João Lozano (joao_lozano)
    Version: 3.0
    Has system prompt: ✅
    Has frameworks: ✅
    System prompt: /path/to/system_prompts/generalista.md
```

### **2. Check Detected Paths**

The test output shows which files were found for each mind. Verify:
- ✅ All expected files are detected
- ✅ Priority order is correct (right files chosen)
- ✅ Confidence scores are reasonable

### **3. Inspect Voice Profile**

Select a mind during testing to see extracted data:

```
✓ Voice Profile Extracted:
  - Tone: Practical, no-nonsense, Direct
  - Style: Clear and engaging
  - Recurring phrases: 10
  - Core values: 5
  - Confidence: 95%
```

Verify:
- ✅ Tone matches expected traits
- ✅ Counts match your max_items settings
- ✅ Confidence score is reasonable

---

## 🎯 Real-World Examples

### **Example 1: Support Both MMOS v2.x and v3.0**

```yaml
paths:
  identity_core:
    paths:
      # Try both versions in priority order
      - "artifacts/identity_core.yaml"    # v3.0 primary
      - "analysis/identity-core.yaml"     # v2.x fallback

  cognitive_architecture:
    paths:
      - "artifacts/cognitive_architecture.yaml"  # v3.0
      - "analysis/cognitive-spec.yaml"           # v2.x

  communication_style:
    paths:
      - "artifacts/communication_templates.md"  # v3.0
      - "synthesis/communication-style.md"      # v2.x
```

**Result:** Works with minds from any version

---

### **Example 2: Prioritize Frameworks**

You want teaching philosophy to have more weight in confidence scoring:

```yaml
confidence_scoring:
  weights:
    identity_core: 25          # Reduced from 30
    cognitive_architecture: 25  # Reduced from 30
    communication_style: 30    # Unchanged
    frameworks: 20             # Increased from 10 (bonus → core)
```

**Result:** Minds with detailed frameworks score higher

---

### **Example 3: Custom Mind Structure**

Your minds use a completely different structure:

```yaml
paths:
  identity_core:
    paths:
      - "profile/identity.yaml"      # Your custom path

  cognitive_architecture:
    paths:
      - "profile/cognitive.yaml"     # Your custom path

  communication_style:
    paths:
      - "voice/style.md"             # Your custom path

  frameworks:
    paths:
      - "teaching/philosophy.md"     # Your custom path

extraction:
  yaml_fields:
    identity_core:
      name: "instructor_name"        # Your field names
      traits: "traits"
      values: "values"
      worldview: "beliefs"
```

**Result:** Integrator works with your custom structure

---

## ⚙️ Advanced: Config Hot Reload

**Currently:** Config is loaded when `MMOSIntegrator` is initialized

**To reload config:**
1. Edit `mmos-paths.yaml`
2. Restart the script/workflow using MMOS integration

**Future enhancement:** Add config watcher for automatic reload

---

## 🐛 Troubleshooting

### **Problem: Config not loading**

**Symptom:**
```
⚠️  MMOS config not found at /path/to/mmos-paths.yaml, using defaults
```

**Solution:**
1. Verify file exists: `ls expansion-packs/creator-os/config/mmos-paths.yaml`
2. Check file permissions: `chmod 644 expansion-packs/creator-os/config/mmos-paths.yaml`
3. Validate YAML syntax: `python -c "import yaml; yaml.safe_load(open('expansion-packs/creator-os/config/mmos-paths.yaml'))"`

---

### **Problem: No minds detected**

**Symptom:**
```
❌ No MMOS minds found in outputs/minds/
```

**Solution:**
1. Check `outputs/minds/` exists and has subdirectories
2. Verify paths in config match your mind structure
3. Run test: `python lib/mmos_integrator.py` to see validation details

---

### **Problem: Low confidence scores**

**Symptom:** All minds show 30-40% confidence

**Solution:**
1. Check if files are actually being loaded (test output shows file paths)
2. Verify YAML field names match your minds (edit `extraction.yaml_fields`)
3. Adjust minimum lengths if your files are shorter (`extraction.min_lengths`)

---

### **Problem: Wrong data extracted**

**Symptom:** Tone is "Professional, clear" (fallback) instead of actual traits

**Solution:**
1. Verify YAML field names: `extraction.yaml_fields.identity_core.traits`
2. Check tone_mapping includes your traits
3. Inspect `identity_core.yaml` manually: does field name match config?

---

## 📚 Related Documentation

- **MMOS Data Loading Analysis:** `docs/MMOS-DATA-LOADING-ANALYSIS.md`
- **MMOS Integration Code:** `lib/mmos_integrator.py`
- **Config File:** `config/mmos-paths.yaml`

---

## 🔄 Changelog

**v1.0 (2025-10-20):**
- Initial configuration system
- Support for MMOS v3.0 structure
- Fallback support for v2.x
- Customizable paths, field names, extraction limits
- Configurable confidence scoring

---

**Last Updated:** 2025-10-20
**Maintained By:** CreatorOS Team
**Status:** ✅ Active
