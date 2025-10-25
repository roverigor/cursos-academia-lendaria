# AIOS Git Hooks

**Version:** 1.0
**Purpose:** Automated quality and architecture checks

---

## Available Hooks

### 1. MMOS Architecture Guard (`pre-commit-mmos-guard.sh`)

**Purpose:** Prevent architectural violations in MMOS file placement

**Checks:**
- ✅ No mind-specific folders in `docs/mmos/`
- ✅ No output files in `expansion-packs/`
- ✅ Proper `outputs/minds/{slug}/` structure
- ✅ No mind-specific files in wrong locations

**What it prevents:**
- ❌ `docs/mmos/validations/pedro-valerio/` (wrong)
- ❌ `docs/mmos/migrations/joao-lozano/` (wrong)
- ❌ `expansion-packs/mmos/benchmarks/` (wrong)

---

## Installation

### Option 1: Install All Hooks (Recommended)

```bash
# From project root
.aios-core/hooks/install-hooks.sh
```

### Option 2: Install Specific Hook

```bash
# Link MMOS architecture guard
ln -sf ../../.aios-core/hooks/pre-commit-mmos-guard.sh .git/hooks/pre-commit
```

### Option 3: Manual Test (No Installation)

```bash
# Run manually before commit
.aios-core/hooks/pre-commit-mmos-guard.sh
```

---

## Usage

Once installed, hooks run automatically:

```bash
# Stage files
git add .

# Commit (hook runs automatically)
git commit -m "feat: add new feature"

# If violations found:
❌ COMMIT REJECTED: 1 architectural violation(s) found

# Fix violations, then retry
```

---

## Bypassing Hooks (Use with Caution)

**Only bypass if you're absolutely sure:**

```bash
# Skip all hooks (NOT recommended)
git commit --no-verify -m "message"
```

**Note:** CI/CD will still catch violations even if you bypass local hooks.

---

## Adding New Hooks

1. Create hook script in `.aios-core/hooks/`
2. Make it executable: `chmod +x .aios-core/hooks/your-hook.sh`
3. Add to `install-hooks.sh`
4. Document in this README
5. Update `.claude/CLAUDE.md` and `.cursor/global-rules.md` if needed

---

## Hook Development Guidelines

### Script Header Template

```bash
#!/bin/bash
# Hook Name - Description
# Version: 1.0
# Purpose: What this hook checks

set -e

echo "🛡️  Running Hook Name..."
# ... hook logic ...
```

### Exit Codes

- `0` - Success (allow commit)
- `1` - Failure (reject commit)

### Output Format

- Use colors for visibility
- Clear error messages
- Provide fix suggestions
- Show examples of correct usage

---

## Troubleshooting

### Hook Not Running

```bash
# Check if hook is installed
ls -la .git/hooks/pre-commit

# Reinstall
.aios-core/hooks/install-hooks.sh
```

### Hook Fails Incorrectly

```bash
# Test manually
.aios-core/hooks/pre-commit-mmos-guard.sh

# Check git status
git status
git diff --cached --name-only
```

### Permission Issues

```bash
# Make hooks executable
chmod +x .aios-core/hooks/*.sh
chmod +x .git/hooks/pre-commit
```

---

## Related Documentation

- **Architecture Rules:** `docs/mmos/ARCHITECTURE_RULES.md`
- **Architecture Checklist:** `.aios-core/checklists/mmos-architecture-guard.md`
- **IDE Rules:** `.claude/CLAUDE.md`, `.cursor/global-rules.md`

---

**Maintained By:** AIOS Core Team
**Last Updated:** 2025-10-16
