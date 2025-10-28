# AIOS IDE Sync Migration Guide

**Version:** 1.0.0
**Target Version:** IDE Sync System v1.0.0+
**Breaking Changes:** Requires `yq` installation

---

## Overview

The AIOS IDE Sync System (introduced in commit `efed04b3`) automatically syncs agents, tasks, and templates from expansion packs to IDE configurations. This migration guide helps you upgrade your environment to use this new system.

---

## ⚠️ Breaking Changes

### New Dependency: yq

The sync system requires `yq` (YAML processor) to parse configuration files.

**Platforms Affected:** macOS, Linux, Windows

---

## Pre-Migration Checklist

Before upgrading, ensure:

- [ ] You have admin/sudo access to install packages
- [ ] You have 5-10 minutes for installation and validation
- [ ] Your git working directory is clean (`git status`)
- [ ] You've reviewed what will be synced (see Configuration section)

---

## Installation Instructions

### macOS

```bash
# Using Homebrew (recommended)
brew install yq

# Verify installation
yq --version
# Expected output: yq (https://github.com/mikefarah/yq/) version X.X.X
```

### Linux

#### Ubuntu/Debian
```bash
# Using snap
sudo snap install yq

# OR using wget (standalone binary)
VERSION=v4.35.1
BINARY=yq_linux_amd64
sudo wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O /usr/bin/yq
sudo chmod +x /usr/bin/yq

# Verify installation
yq --version
```

#### Fedora/RHEL/CentOS
```bash
# Using wget
VERSION=v4.35.1
BINARY=yq_linux_amd64
sudo wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O /usr/bin/yq
sudo chmod +x /usr/bin/yq

# Verify installation
yq --version
```

### Windows

#### Using Chocolatey
```powershell
choco install yq

# Verify installation
yq --version
```

#### Using Scoop
```powershell
scoop install yq

# Verify installation
yq --version
```

#### Manual Installation
1. Download the latest release from https://github.com/mikefarah/yq/releases
2. Extract `yq_windows_amd64.exe` and rename to `yq.exe`
3. Add to PATH or place in a directory already in PATH
4. Verify: `yq --version`

---

## Migration Steps

### Step 1: Install yq

Follow the installation instructions for your platform above.

### Step 2: Verify Installation

```bash
yq --version
```

You should see output like: `yq (https://github.com/mikefarah/yq/) version 4.35.1`

### Step 3: Review Configuration

```bash
# Review what will be synced
cat .aios-sync.yaml
```

Key configuration:
- **active_ides**: Which IDEs are enabled (claude, cursor, etc.)
- **pack_aliases**: How expansion packs are named in commands
- **sync_mappings**: What gets synced where

### Step 4: Run Dry-Run Sync

**IMPORTANT:** Always run a dry-run first to preview changes:

```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --dry-run --verbose
```

This shows what would be synced WITHOUT making changes.

**Review the output carefully:**
- Check file paths look correct
- Verify pack aliases are correct
- Ensure no unexpected files are being synced

### Step 5: Run Initial Sync

```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh
```

**Expected output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  AIOS IDE Sync
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ℹ  Processing: expansion_pack_agents
✓ Synced: design-system.md
✓ Synced: design-system.mdc
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Sync complete!
ℹ  Files synced: XXX
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Step 6: Validate Synced Files

```bash
# Check Claude Code synced files
ls .claude/commands/SA/agents/
ls .claude/commands/CreatorOS/agents/
ls .claude/commands/MMOS/agents/

# Check Cursor synced files (if enabled)
ls .cursor/rules/ | grep -E "\.mdc$"

# Verify a sample file looks correct
cat .claude/commands/SA/agents/design-system.md | head -20
```

**Validation checklist:**
- [ ] Files exist in expected locations
- [ ] File content looks correct (not corrupted)
- [ ] Wrappers applied correctly (for slash-command format)
- [ ] Format conversion works (.md → .mdc for Cursor)

### Step 7: Test in Your IDE

**Claude Code:**
1. Restart Claude Code (if running)
2. Try using an agent: `/SA:agents:design-system`
3. Verify agent loads correctly

**Cursor:**
1. Check that rules appear in Cursor settings
2. Verify rules are loaded

### Step 8: Verify Pre-Commit Hook

The sync runs automatically before commits. Test it:

```bash
# Make a small change to test
echo "# Test" >> test-file.md
git add test-file.md
git commit -m "test: verify pre-commit hook"

# You should see:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PRE-COMMIT: Syncing agents to IDE configurations...
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ...

# Clean up
git reset HEAD~1
rm test-file.md
```

---

## Rollback Procedures

### Emergency: Disable Auto-Sync

If the sync is causing issues, disable it temporarily:

```bash
# Option 1: Bypass for single commit
git commit --no-verify -m "your message"

# Option 2: Disable in config
# Edit .aios-sync.yaml and set:
# behavior:
#   auto_sync_on_commit: false
```

### Restore from Backup

The sync creates `.bak` files before overwriting. To restore:

```bash
# Find backup files
find .claude -name "*.bak"
find .cursor -name "*.bak"

# Restore a specific file
cp .claude/commands/SA/agents/design-system.md.bak .claude/commands/SA/agents/design-system.md

# Restore all backups in a directory
for file in .claude/commands/SA/agents/*.bak; do
    cp "$file" "${file%.bak}"
done
```

### Full Rollback

To completely remove synced files:

```bash
# WARNING: This removes all synced IDE configurations

# Remove Claude Code synced files
rm -rf .claude/commands/SA/
rm -rf .claude/commands/CreatorOS/
rm -rf .claude/commands/MMOS/
rm -rf .claude/commands/InnerLens/
rm -rf .claude/commands/ETL/
rm -rf .claude/commands/fragments/

# Remove Cursor synced files (if you enabled it)
rm -rf .cursor/rules/*.mdc

# Note: You can also restore from git
git checkout .claude/commands/
git checkout .cursor/rules/
```

---

## Troubleshooting

### Issue: "yq: command not found"

**Solution:**
```bash
# Verify yq is installed
which yq

# If not found, install using instructions above
# For macOS:
brew install yq

# Verify
yq --version
```

### Issue: "No directories match pattern"

**Cause:** No expansion packs found in `expansion-packs/*/agents/`

**Solution:**
```bash
# Check expansion packs exist
ls expansion-packs/

# Each pack should have an agents/ directory
ls expansion-packs/*/agents/
```

### Issue: "Permission denied" when syncing

**Solution:**
```bash
# Make sync script executable
chmod +x expansion-packs/super-agentes/scripts/sync-to-ides.sh

# Check IDE directories are writable
ls -la .claude/
ls -la .cursor/
```

### Issue: Synced files look wrong

**Solution:**
```bash
# Run sync with verbose mode to debug
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --dry-run --verbose

# Check the log for errors
tail -50 .aios-sync.log

# Verify config is valid YAML
yq eval '.active_ides' .aios-sync.yaml
```

### Issue: Pre-commit hook fails

**Solution:**
```bash
# Check if sync script is executable
chmod +x expansion-packs/super-agentes/scripts/sync-to-ides.sh

# Test sync manually
./expansion-packs/super-agentes/scripts/sync-to-ides.sh

# Bypass hook temporarily (emergency only)
git commit --no-verify -m "your message"
```

### Issue: Backup files accumulating

**Solution:**
```bash
# Clean up old backup files
find .claude -name "*.bak" -delete
find .cursor -name "*.bak" -delete

# Note: .bak files are already in .gitignore
```

---

## Performance Considerations

### Initial Sync

First sync processes all files (~344 files currently):
- **Expected time:** 5-15 seconds
- **Disk space:** ~2-3 MB

### Subsequent Syncs (Pre-Commit)

Each commit triggers a sync:
- **Expected time:** 2-5 seconds
- **Impact:** Adds latency to git commits

**Optimization tips:**
1. Sync only runs if expansion pack files changed (future enhancement)
2. Use `--ide=claude` to sync to specific IDE only
3. Disable auto-sync if it slows workflow: set `auto_sync_on_commit: false`

---

## Configuration Customization

### Sync Only to Specific IDE

```bash
# Sync only to Claude Code
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --ide=claude

# Sync only to Cursor
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --ide=cursor
```

### Disable IDE

Edit `.aios-sync.yaml`:
```yaml
active_ides:
  - claude
  # - cursor  # Commented out = disabled
```

### Add Custom Pack Alias

Edit `.aios-sync.yaml`:
```yaml
pack_aliases:
  my-custom-pack: MyPack
```

Then sync will create `.claude/commands/MyPack/` instead of `.claude/commands/my-custom-pack/`.

---

## CI/CD Considerations

If running in CI/CD:

### GitHub Actions

```yaml
- name: Install yq
  run: |
    sudo wget https://github.com/mikefarah/yq/releases/download/v4.35.1/yq_linux_amd64 -O /usr/bin/yq
    sudo chmod +x /usr/bin/yq

- name: Run IDE Sync
  run: ./expansion-packs/super-agentes/scripts/sync-to-ides.sh
```

### GitLab CI

```yaml
before_script:
  - wget https://github.com/mikefarah/yq/releases/download/v4.35.1/yq_linux_amd64 -O /usr/bin/yq
  - chmod +x /usr/bin/yq
```

---

## Post-Migration

After successful migration:

- [ ] ✅ yq installed and verified
- [ ] ✅ Initial sync completed successfully
- [ ] ✅ Synced files validated in IDEs
- [ ] ✅ Pre-commit hook tested
- [ ] ✅ Team members notified of new system
- [ ] ✅ Documentation bookmarked

**You're all set!** The IDE sync system will now automatically keep your IDE configurations in sync with expansion packs.

---

## Getting Help

- **Documentation:** `docs/guides/ide-sync-guide.md`
- **Logs:** Check `.aios-sync.log` for detailed operation logs
- **Dry-run:** Always test with `--dry-run` first
- **Verbose mode:** Use `--verbose` for debugging

---

## Version History

- **v1.0.0** (2025-10-28): Initial migration guide for IDE sync system

---

**Related Documentation:**
- [IDE Sync System Guide](./ide-sync-guide.md)
- [AIOS Development Rules](../.claude/CLAUDE.md)
- [Expansion Packs Structure](./folder-structure.md)
