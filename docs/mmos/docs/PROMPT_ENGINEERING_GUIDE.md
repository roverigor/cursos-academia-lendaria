# PROMPT ENGINEERING GUIDE – MMOS v3.0

## PURPOSE
Establish a standardized format for all 42 MMOS (Mind Mapper OS) prompts, aligned with the **DNA Mental™** methodology (8 Cognitive Layers). Ensure each prompt captures the correct layers of cognitive depth according to README.md and OUTPUTS_GUIDE.md.

## NAMING CONVENTION

### Mandatory Pattern
```
NN_functional_name.md

Where:
- NN: execution order (01, 02, 03…)
- functional_name: clear descriptive name in English
```

### Valid Examples (current system)
```
✅ 01_scorecard_apex.md
✅ 02_prd_generator.md
✅ 02_dependencies_mapper.md
✅ 03_todo_initializer.md
✅ 01_source_discovery.md
✅ 02_source_collector.md
✅ 03_temporal_mapper.md
✅ 03_priority_calculator.md
✅ 04_sources_master.md
```

### Numbering System
Indicates execution order and parallelization opportunities:
```
01_xxx.md              → Runs first (sequential)
02_aaa.md, 02_bbb.md   → Can run in parallel
03_xxx.md              → Wait for all 02_ prompts
04_xxx.md              → Runs last
```

## REQUIRED TEMPLATE
```markdown
# [FUNCTIONAL NAME]

## METADATA
- Version: 3.0 ACS DNA Mental
- DNA Mental Layers: [Which layers this prompt covers: 1-8]
- Input: [specific inputs per OUTPUTS_GUIDE.md]
- Output: [specific outputs per OUTPUTS_GUIDE.md]
- Dependencies: [previous prompts or "None"]

## PRIMARY OBJECTIVE
[Clear description in English of what the prompt does]

## REQUIRED INPUT
[Detailed input structure – use YAML when applicable]

## METHODOLOGY
[Phased structure as needed – no emojis or time estimates]

## STRUCTURED OUTPUT
[Specific formats per OUTPUTS_GUIDE.md – include YAML/MD templates]

## QUALITY CHECKLIST
[Minimum validations to ensure output correctness]

## CRITICAL ALERTS
[Limitations, caveats, required human validation]
```

## MANDATORY RULES

### ❌ PROHIBITED
- Emojis, icons, decorative Unicode of any kind
- Speculative deadlines without historical data
- Unnecessary fields like “Responsible”, “Forced Type”
- Decorative headers with symbols
- Excessive or non-essential formatting

### ✅ REQUIRED
- Follow the template exactly
- Outputs must match OUTPUTS_GUIDE.md
- Input/Output paths must exist and be precise
- Clear English, ASCII headers
- Ensure UTF-8 encoding with no corrupted characters
- Dependencies must reference real prompts

## ALIGNMENT WITH EXISTING SYSTEM

### Consistency Check
Before writing a prompt, consult:
1. **README.md** – overall structure and naming
2. **OUTPUTS_GUIDE.md** – exact inputs/outputs
3. Prompts in the same stage – observe existing patterns

### Valid Inputs/Outputs
Use ONLY paths documented in OUTPUTS_GUIDE.md:
```
✅ sources/
✅ analysis/personality_profile.json
✅ docs/PRD.md
✅ metadata/dependencies.yaml
✅ logs/YYYYMMDD-HHMM-*.yaml

❌ Inventing new paths without documentation
❌ Vague references to “config files”
```

## STRUCTURE BY STAGE

### STAGE 1: VIABILITY
- Focus: Initial evaluation and specification
- Outputs: PRD.md, TODO.md, dependencies.yaml

### STAGE 2: RESEARCH
- Focus: Source collection and organization
- Outputs: sources/, temporal_context.yaml, priority_matrix.yaml

### STAGE 3: ANALYSIS ⭐ DNA MENTAL CORE
- Focus: Extraction of the 8 cognitive layers
- Layers 1-2: Surface and patterns
- Layers 3-5: Models, decisions, values
- Layers 6-8: Obsessions, uniqueness, paradoxes
- Outputs: personality_profile.json, cognitive_architecture.yaml, contradictions.yaml

### STAGE 4: SYNTHESIS
- Focus: Templates and knowledge base
- Outputs: templates/, frameworks/, kb/

### STAGE 5: IMPLEMENTATION
- Focus: Functional system prompts
- Outputs: system-prompts/, specialists/

### STAGE 6: TESTING
- Focus: Validation and final documentation
- Outputs: test_results.yaml, README.md

## DNA MENTAL™ ALIGNMENT

### Layer Mapping per Stage
Each prompt captures specific DNA Mental™ layers:
```yaml
02_linguistic_forensics.md → Layer 1 (Surface Linguistics)
02_behavioral_patterns.md  → Layer 2 (Recognition Patterns)
01_frameworks_identifier.md → Layer 3 (Mental Models)
02_decision_analysis.md    → Layer 4 (Decision Architecture)
03_values_hierarchy.yaml   → Layer 5 (Value Hierarchy)
03_belief_system.md        → Layer 6 (Core Obsessions)
04_cognitive_architecture.yaml → Layer 7 (Cognitive Uniqueness)
03_contradictions_map.md   → Layer 8 (Productive Paradoxes)
```

### Implementation Stage
- System prompts must integrate all 8 layers
- Specialists focus on the layers relevant to their domain

### Testing Stage
- Validate each layer separately
- Final test: Layer 8 (paradoxes functioning correctly)

### Depth Validation
When creating/reviewing prompts, confirm:
- [ ] Layers 1-3: Necessary but not sufficient (≈50% effectiveness)
- [ ] Layers 4-6: Minimum for a functional mind (≈70%)
- [ ] Layers 7-8: Required for high fidelity (≈94%)

⚠️ Layers 5-8 require mandatory human validation due to inference risk.

## MAINTENANCE

### Updates
- Whenever DNA_MENTAL_METHODOLOGY.md evolves
- Whenever README.md or OUTPUTS_GUIDE.md change
- When new patterns emerge from real usage
- Based on implementation feedback

### Consistency
- This guide reflects the DNA Mental™ methodology
- Documents existing patterns, does not invent new ones
- Prioritizes clarity and practicality

## EXAMPLES

### ✅ WELL-FORMATTED PROMPT
```markdown
# SOURCE DISCOVERY

## METADATA
- Version: 3.0 ACS Neural Flow
- Input: PRD.md, dependencies.yaml
- Output: Source list maintained in memory
- Dependencies: 01_scorecard_apex.md

## PRIMARY OBJECTIVE
Systematically discover all available sources for the target mind.
```

### ❌ POORLY FORMATTED PROMPT
```markdown
# 🔍 SOURCE DISCOVERY – RESEARCH MASTER

## 📊 METADATA
- Version: 3.0 ACS Neural Flow
- Estimated time: 30-45 minutes
- Responsible: Research Team
- Type: extractor
```

## VALIDATION CHECKLIST
Before committing any prompt:

### Naming
- [ ] Follows NN_functional_name.md
- [ ] Numbering aligns with execution flow
- [ ] Name is clear and specific

### Template
- [ ] Follows template exactly
- [ ] All required fields filled
- [ ] No prohibited fields present

### Content
- [ ] Inputs match OUTPUTS_GUIDE.md
- [ ] Outputs match OUTPUTS_GUIDE.md
- [ ] Dependencies reference existing prompts
- [ ] Methodology is clear and executable

### Formatting
- [ ] UTF-8, no corrupted characters
- [ ] No emojis or decorations
- [ ] Clear English
- [ ] Paths valid and accurate

## PROCESS FOR NEW PROMPTS
1. **Consult Documentation**
   - Review README.md for context
   - Check OUTPUTS_GUIDE.md for IO specifications
   - Analyze similar prompts in the same stage

2. **Follow Template**
   - Copy the standard template
   - Fill every required field
   - Validate against the checklist

3. **Update System**
   - If new outputs: update OUTPUTS_GUIDE.md FIRST
   - If new stage: update README.md
   - Maintain terminology consistency

4. **Validate Integration**
   - Ensure inputs are available
   - Confirm outputs are consumed correctly
   - Verify dependencies execute in order

## PROMPT ENGINEERING AND DNA MENTAL™

Maintaining fidelity requires attention to the eight layers. Missing a layer reduces the authenticity/consistency of the mind map; failing to capture layers 6-8 often leads to flat or generic behavior.

### Final Notes
- This guide is an operational document, not theory.
- Execute prompts exactly as described unless the system documentation is updated.
- Share improvements via documented PRs.

---
**Last updated:** 2025-10-04 – Aligned with DNA Mental™
**Status:** Operational – Official methodology documented
**Reference:** `/mmos/docs/DNA_MENTAL_METHODOLOGY.md`
