# Design System Migration Pitfalls & Anti-Patterns

**Purpose:** Document common mistakes and how to avoid them
**Audience:** Brad (Design System Architect) + future maintainers
**Status:** Living document - add new pitfalls as discovered

---

## CRITICAL PITFALLS (High Impact)

### 1. Line Number Corruption from Read Tool Output

**What Happened:**
During Sprint 4 Tailwind utilities migration (Hackathon-Hub, 2025-11-03), migration script used Read tool output with line numbers as source for find/replace operations. Line numbers were accidentally prepended to class names.

**Example:**
```tsx
// Source file (Read tool output with line numbers):
// 7484→  <div className="border-destructive/30 bg-destructive/10">

// After broken find/replace:
<div className="7484border-destructive/30 7600bg-destructive/10">
// Invalid classes - Tailwind ignores them
```

**Impact:**
- 274 corrupted classes across 26 files
- All hover/focus states broken
- Buttons, cards, badges non-interactive
- Silent failure (no build errors)

**Root Cause:**
Used Read tool output directly in regex without stripping line number prefixes.

**Prevention:**
1. **Never** copy Read tool output directly into find/replace
2. Use Grep (not Read) to find target patterns
3. Use Edit tool with specific old_string/new_string
4. Always run post-migration validation (migration-validation-checklist.md)
5. Add automated check:
   ```bash
   grep -rE '\d{4,}(bg-|text-|border-|hover:)' src/
   # Should return 0 results
   ```

**Fix Script:**
Created `scripts/fix-corrupted-classnames.cjs` to remove line number prefixes.

**Detection Pattern:**
```regex
\d{4,}(bg-|text-|border-|hover:|focus:|active:|group-hover:)
```

---

### 2. Over-Aggressive Pattern Matching

**What Happened:**
Migration script replaced color utilities too broadly, changing intentionally specific colors to generic semantic tokens.

**Example:**
```tsx
// Before (intentional lime-500 for specific branding)
<Badge className="bg-lime-500 text-lime-950">

// After (incorrectly mapped to success)
<Badge className="bg-success text-success-foreground">
// Lost specific brand color intention
```

**Impact:**
- Brand-specific colors lost
- Visual identity changed unintentionally
- Requires manual review and rollback

**Prevention:**
1. **Manual review** of all proposed mappings before execution
2. **Context-aware** replacements (check surrounding code)
3. **Allowlist exceptions** for brand colors
4. Document intentional non-semantic colors in code comments:
   ```tsx
   // Intentionally lime-500 (brand color, not semantic)
   <Badge className="bg-lime-500">
   ```

---

### 3. Incomplete Variant Coverage

**What Happened:**
Migration script handled base utilities (`bg-red-500`) but missed variant prefixes (`hover:bg-red-500`, `focus:bg-red-500`).

**Example:**
```tsx
// Before
<Button className="bg-red-500 hover:bg-red-600 focus:ring-red-500">

// After (incomplete migration)
<Button className="bg-destructive hover:bg-red-600 focus:ring-red-500">
// Base migrated, variants missed
```

**Impact:**
- Inconsistent hover/focus states
- Some states use old colors, some use new tokens
- Mixed semantic levels

**Prevention:**
1. **Comprehensive regex** covering all variants:
   ```javascript
   const variants = [
     '', // base
     'hover:', 'focus:', 'active:',
     'group-hover:', 'peer-focus:',
     'dark:', 'dark:hover:',
     // etc.
   ];
   ```
2. Test variant coverage in dry-run output
3. Validate interactive states after migration

---

### 4. Conflicting ESLint/Prettier Auto-Fixes

**What Happened:**
Migration script writes changes, then ESLint/Prettier auto-format on save, causing unexpected modifications.

**Example:**
```tsx
// Migration script output
<div className="border-destructive/30 bg-destructive/10">

// After Prettier auto-format (class order changed)
<div className="bg-destructive/10 border-destructive/30">
// Functional but git diff messy
```

**Impact:**
- Git diff shows more changes than expected
- Hard to review actual semantic changes
- Confusion about what script did vs formatter

**Prevention:**
1. **Disable auto-format** during migration execution
2. Run formatter AFTER migration, BEFORE validation
3. Commit in sequence:
   ```bash
   node migrate.cjs --execute  # Migration only
   npm run format              # Format separately
   git add -A && git commit    # Clear separation
   ```

---

### 5. Missing Opacity Modifiers

**What Happened:**
Migration mapped colors but didn't preserve opacity modifiers.

**Example:**
```tsx
// Before
<div className="bg-red-500/20">  // 20% opacity

// After (broken)
<div className="bg-destructive">  // Lost opacity
```

**Impact:**
- Overlay backgrounds too opaque
- Ghost buttons lost transparency
- Visual weight changes

**Prevention:**
1. **Regex capture groups** for opacity:
   ```javascript
   const pattern = /bg-red-500(\/\d+)?/g;
   // Captures "/20" modifier
   ```
2. Preserve modifiers in replacement:
   ```javascript
   content.replace(pattern, (match, opacity) =>
     `bg-destructive${opacity || ''}`
   );
   ```

---

## MODERATE PITFALLS (Medium Impact)

### 6. Token Coverage Gaps

**What Happened:**
Migration assumes all colors have semantic tokens, but some utility colors don't map cleanly.

**Example:**
```tsx
// No clear semantic token for info/brand blues
bg-blue-500 → ??? (no bg-info token defined)
```

**Prevention:**
1. **Audit token coverage** before migration
2. Create missing semantic tokens first
3. Document "keep as-is" utilities in mapping:
   ```javascript
   const KEEP_AS_IS = [
     'bg-blue-500',  // No semantic equivalent
     'text-purple-400', // Brand highlight color
   ];
   ```

---

### 7. Dark Mode Inconsistencies

**What Happened:**
Migration mapped light mode colors but broke dark mode variants.

**Example:**
```tsx
// Before
<div className="bg-red-500 dark:bg-red-800">

// After (broken dark mode)
<div className="bg-destructive dark:bg-red-800">
// Inconsistent: semantic + hardcoded
```

**Prevention:**
1. **Include dark: prefix** in variant patterns
2. Test both light and dark modes after migration
3. Use semantic tokens that auto-adapt:
   ```tsx
   className="bg-destructive"  // Auto dark mode via tokens
   ```

---

### 8. String Interpolation Edge Cases

**What Happened:**
Dynamic class names broke after migration due to template literal issues.

**Example:**
```tsx
// Before
<div className={`border-${type === 'error' ? 'red' : 'green'}-500`}>

// After (broken)
<div className={`border-${type === 'error' ? 'destructive' : 'success'}-500`}>
// Invalid: border-destructive-500 doesn't exist
```

**Prevention:**
1. **Full token names** in conditional logic:
   ```tsx
   className={type === 'error' ? 'border-destructive' : 'border-success'}
   ```
2. Avoid string interpolation for utilities
3. Use variant-based styling instead (cva pattern)

---

## LOW IMPACT PITFALLS (Polish Issues)

### 9. Inconsistent Naming Conventions

**What Happened:**
Some files use old names, some use new tokens, even after migration.

**Prevention:**
- Enforce naming in code review
- Add ESLint rule to catch old utilities
- Document token naming conventions

---

### 10. Stale Documentation

**What Happened:**
Docs still reference old utility classes after migration.

**Prevention:**
- Include docs/ in migration scope
- Update README, CONTRIBUTING, style guide
- Search for old class names in markdown:
  ```bash
  grep -r 'bg-red-500' docs/
  ```

---

## VALIDATION WORKFLOW

For every migration:

1. ✅ **Pre-migration:** Review mapping + scope
2. ✅ **Dry-run:** Check output samples
3. ✅ **Execute:** Run migration script
4. ✅ **Validate:** Use migration-validation-checklist.md
5. ✅ **Test:** Visual regression check
6. ✅ **Commit:** With detailed message

---

## AUTOMATION RECOMMENDATIONS

**Add to CI/CD:**

```yaml
# .github/workflows/design-system-validation.yml
name: Design System Validation

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Check for corrupted classes
        run: |
          CORRUPTED=$(grep -rE '\d{4,}(bg-|text-|border-)' src/ | wc -l)
          if [ $CORRUPTED -gt 0 ]; then
            echo "Found corrupted classes with line number prefixes"
            grep -rE '\d{4,}(bg-|text-|border-)' src/
            exit 1
          fi

      - name: Check for non-semantic colors
        run: |
          # Allowlist specific cases
          grep -rE 'bg-(red|green|blue|yellow)-(400|500|600)' src/ \
            | grep -v "# intentional" \
            && echo "Found non-semantic color utilities" && exit 1 \
            || echo "All colors are semantic or documented"
```

---

## LESSONS LEARNED

1. **Read tool output != clean source** - Always strip metadata
2. **Automation requires validation** - Scripts can fail silently
3. **Visual testing is mandatory** - Build passing ≠ UI working
4. **Document exceptions** - Not everything should be migrated
5. **Checklists save time** - 5 min validation saves hours debugging

---

**Maintained by:** Brad (Design System Architect)
**Last incident:** 2025-11-03 (Line number corruption, Sprint 4)
**Next review:** After each major migration
