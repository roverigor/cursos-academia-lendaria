# Extract Design Tokens from Consolidated Patterns

> Task ID: brad-extract-tokens
> Agent: Brad (Design System Architect)
> Version: 1.0.0

## Description

Generate design token system from consolidated patterns. Produce 3-layer token architecture (core → semantic → component) with OKLCH values, W3C DTCG-compliant JSON, and companion exports (YAML, JSON, CSS custom properties, Tailwind config, SCSS).

## Prerequisites

- Consolidation completed (*consolidate command run successfully)
- .state.yaml contains consolidation data
- Consolidated pattern files exist (color-clusters.txt, spacing-consolidation.txt, etc)

## Workflow

### Interactive Elicitation

This task uses interactive elicitation to configure token generation.

1. **Review Consolidation Results**
   - Display consolidation summary (colors, buttons, spacing, typography)
   - Confirm token generation from these patterns
   - Ask for naming preferences (kebab-case default)

2. **Select Export Formats**
   - Ask which formats to export (YAML, JSON, CSS, Tailwind, SCSS, DTCG JSON, all)
   - Confirm output directory
   - Check for existing token files (overwrite warning)

3. **Validate Token Coverage**
   - Show coverage percentage (tokens cover X% of original usage)
   - Target: >95% coverage
   - Ask for approval before generating

### Steps

1. **Load Consolidation Data**
   - Read .state.yaml consolidation section
   - Load consolidated pattern files
   - Validate consolidation phase completed
   - Validation: Consolidation data exists and complete

2. **Extract Color Tokens**
   - Read color-clusters.txt
   - Generate semantic names (primary, primary-dark, error, success, etc)
   - Detect relationships (hover states, light/dark variants)
   - Create color token structure
   - Validation: All consolidated colors have token names

3. **Extract Spacing Tokens**
   - Read spacing-consolidation.txt
   - Map spacing values to semantic scale (xs, sm, md, lg, xl, 2xl, 3xl)
   - Generate both padding and margin tokens
   - Validation: Complete spacing scale created

4. **Extract Typography Tokens**
   - Read typography-consolidation.txt
   - Create font-family tokens
   - Create font-size tokens with semantic names
   - Create font-weight tokens
   - Create line-height tokens (calculated from sizes)
   - Validation: Complete typography system

5. **Extract Button Tokens**
   - Read button-consolidation.txt
   - Generate button variant tokens (primary, secondary, destructive)
   - Generate button size tokens (sm, md, lg)
   - Map colors and spacing to button tokens
   - Validation: Button tokens reference color/spacing tokens

6. **Generate tokens.yaml (Source of Truth)**
   - Create YAML with metadata (dtcg_spec, color space, coverage metrics)
   - Organize layers: `core` primitives, `semantic` aliases, `component` mappings
   - Ensure OKLCH color values (fallback to hex only with justification)
   - Validation: Schema aligns with template and references resolve

7. **Produce W3C DTCG JSON**
   - Convert YAML layers to tokens.dtcg.json
   - Inject `$type`, `$value`, `$description`, `{}` references
   - Validate with official DTCG CLI/validator
   - Validation: No schema violations

8. **Export to JSON**
   - Convert tokens.yaml to tokens.json
   - Provide flattened map for direct JS/TS imports
   - Validation: Valid JSON, importable by JS/TS

9. **Export to CSS Custom Properties**
   - Generate tokens.css with `:root` + `[data-theme="dark"]` scopes
   - Map semantic tokens to CSS variables (`--color-primary`)
   - Validation: CSS parses, contrast verified

10. **Export to Tailwind Config (@theme-ready)**
    - Generate tokens.tailwind.js with Oxide-friendly structure
    - Map tokens to `@theme` variables and container query helpers
    - Validation: Tailwind v4 build passes with config

11. **Export to SCSS Variables**
    - Generate tokens.scss with `$token-name` variables
    - Preserve comments for component usage
    - Validation: Valid SCSS syntax

12. **Validate Token Coverage**
    - Calculate how many original patterns are covered
    - Target: >95% coverage + parity in dark mode
    - Report any gaps with remediation plan
    - Validation: Coverage meets threshold

13. **Update State File**
    - Add tokens section to .state.yaml
    - Record token counts, formats, validator results
    - Update phase to "tokenize_complete"
    - Validation: State updated, ready for Atlas or migration

## Output

- **tokens.yaml**: Layered source of truth (core / semantic / component)
- **tokens.dtcg.json**: W3C Design Tokens export (v2025.10)
- **tokens.json**: JavaScript/TypeScript import format
- **tokens.css**: CSS custom properties (light + dark)
- **tokens.tailwind.js**: Tailwind v4 `@theme` helper
- **tokens.scss**: SCSS variables format
- **token-coverage-report.txt**: Coverage analysis
- **.state.yaml**: Updated with token metadata

### Output Format

```yaml
# tokens.yaml (excerpt)
metadata:
  version: "1.0.0"
  generated_by: "Brad (Design System Architect)"
  generated_at: "2025-10-27T13:00:00Z"
  dtcg_spec: "2025.10"
  color_space: "oklch"

layers:
  core:
    color:
      "$type": "color"
      neutral-50:
        "$value": "oklch(0.97 0.01 235)"
      accent-primary:
        "$value": "oklch(0.59 0.19 238)"
    spacing:
      "$type": "dimension"
      base-unit:
        "$value": "4px"
      md:
        "$value": "16px"
  semantic:
    color:
      "$type": "color"
      background:
        "$value": "{layers.core.color.neutral-50}"
      foreground:
        "$value": "oklch(0.15 0.01 260)"
      primary:
        "$value": "{layers.core.color.accent-primary}"
      primary-hover:
        "$value": "oklch(0.52 0.19 238)"
  component:
    button:
      "$type": "object"
      primary:
        background:
          "$value": "{layers.semantic.color.primary}"
        text:
          "$value": "{layers.semantic.color.background}"
        padding-inline:
          "$value": "{layers.core.spacing.lg}"
```

## Success Criteria

- [ ] All consolidated patterns converted to layered tokens
- [ ] Semantic naming follows conventions (kebab-case & aliases)
- [ ] Hover/disabled states detected automatically
- [ ] All 6 export formats generated successfully (YAML/JSON/CSS/Tailwind/SCSS/DTCG)
- [ ] Token coverage >95% of original patterns and dark mode parity logged
- [ ] Colors expressed in OKLCH with documented fallbacks
- [ ] DTCG validation passes with zero warnings
- [ ] State file updated with locations, validator status, coverage metrics

## Error Handling

- **No consolidation data**: Exit with message to run *consolidate first
- **Invalid consolidated patterns**: Log which patterns failed, continue with valid ones
- **Export format error**: Validate syntax, report errors, fix or skip format
- **Low coverage (<95%)**: Warn user, suggest additional consolidation
- **DTCG validation failed**: Provide validator output, regenerate with fixed references
- **Missing OKLCH support**: Document browsers/constraints and capture fallback rationale

## Security Considerations

- Validate color values (hex, rgb, hsl formats only)
- Sanitize token names (alphanumeric, hyphens, underscores only)
- Prevent code injection in exported files
- Validate YAML/JSON syntax before writing

## Examples

### Example 1: Full Token Generation

```bash
*tokenize
```

Output:
```
🔍 Brad: Extracting tokens from consolidated patterns...

🎨 Color tokens: 12 created
📏 Spacing tokens: 7 created
📝 Typography tokens: 10 created
🔘 Button variant tokens: 3 created

📊 Token Coverage: 96.3% of original patterns

✅ Exported to 5 formats:
  - tokens.yaml (source of truth)
  - tokens.json (JavaScript)
  - tokens.css (CSS custom properties)
  - tokens.tailwind.js (Tailwind config)
  - tokens.scss (SCSS variables)

✅ State updated: outputs/design-system/my-app/.state.yaml

Ready for Atlas to build components or generate migration strategy.
```

### Example 2: CSS Output Preview

```css
/* tokens.css */
:root {
  /* Colors */
  --color-primary: #0066CC;
  --color-primary-dark: #0052A3;
  --color-error: #DC2626;

  /* Spacing */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;

  /* Typography */
  --font-base: Inter, system-ui, sans-serif;
  --font-size-base: 16px;
  --font-weight-normal: 400;
}
```

## Notes

- tokens.yaml is the single source of truth - all exports generated from it
- Semantic naming > descriptive naming (use "primary" not "blue-500")
- Hover states auto-detected by "-dark" suffix
- Coverage <95% means some patterns weren't consolidated
- Export formats stay in sync - update tokens.yaml and regenerate all
- Brad recommends: Run *migrate next to create migration strategy
- For component generation, hand off to Atlas: *agent atlas
