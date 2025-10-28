# AIOS IDE Sync System

**Version:** 1.0.0
**Last Updated:** 2025-10-28

## Overview

The **AIOS IDE Sync System** automatically synchronizes agents, tasks, checklists, and workflows from expansion packs to IDE-specific configuration directories (`.claude/`, `.cursor/`, `.windsurf/`, etc.).

This ensures that all AI coding assistants have access to the same agents and capabilities, with proper formatting for each IDE.

## Key Features

- ✅ **Automatic Sync on Commit** - Git pre-commit hook syncs before every commit
- ✅ **Multi-IDE Support** - Claude Code, Cursor, Windsurf, Trae, and more
- ✅ **Format Conversion** - Auto-converts `.md` → `.mdc` for Cursor
- ✅ **Wrapper Templates** - Adds IDE-specific headers/wrappers
- ✅ **Dry-Run Mode** - Preview changes before applying
- ✅ **Selective Sync** - Sync to specific IDE only
- ✅ **Logging** - All operations logged to `.aios-sync.log`
- ✅ **Safe Backups** - Creates `.bak` files before overwriting

## Architecture

```
Source of Truth (expansion-packs/)
    ↓
.aios-sync.yaml (configuration)
    ↓
sync-to-ides.sh (sync script)
    ↓
IDE Directories (.claude/, .cursor/, etc.)
```

### Files

```
.aios-sync.yaml                              # Configuration
expansion-packs/super-agentes/scripts/
  └── sync-to-ides.sh                        # Sync script
.git/hooks/
  └── pre-commit                             # Git hook (auto-runs sync)
.aios-sync.log                               # Sync operation log
```

## Configuration (.aios-sync.yaml)

### Active IDEs

Configure which IDEs to sync to:

```yaml
active_ides:
  - claude    # Claude Code
  - cursor    # Cursor IDE
  # - windsurf  # Uncomment when active
  # - trae      # Uncomment when active
```

### Sync Mappings

Defines source → destination mappings:

```yaml
sync_mappings:
  aios_core_agents:
    source: ".aios-core/agents/"
    destinations:
      claude:
        - path: ".claude/commands/AIOS/agents/"
          format: "md"
          wrapper: "slash-command"
      cursor:
        - path: ".cursor/rules/"
          format: "mdc"
          wrapper: "cursor-rule"
```

**Key Fields:**
- `source`: Source directory (relative to project root)
- `path`: Destination directory
- `format`: File format (`md` or `mdc`)
- `wrapper`: Template to apply (`slash-command`, `cursor-rule`, or `none`)

### Wrappers

Wrapper templates add IDE-specific headers:

**slash-command** (Claude Code):
```markdown
# /command-name Command

When this command is used, adopt the following agent persona:

{original content}
```

**cursor-rule** (Cursor IDE):
```markdown
---
description: Agent Title
globs: []
alwaysApply: false
---

{original content}
```

## Usage

### Manual Sync

Sync all active IDEs:
```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh
```

Preview changes (dry-run):
```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --dry-run
```

Sync to specific IDE:
```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --ide=claude
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --ide=cursor
```

Verbose output:
```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --verbose
```

### Automatic Sync (Git Hook)

The sync runs **automatically** before every commit via the git pre-commit hook.

```bash
git add expansion-packs/super-agentes/agents/design-system.md
git commit -m "feat: add scan command to design-system"

# Output:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PRE-COMMIT: Syncing agents to IDE configurations...
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# ℹ  Processing: aios_core_agents
# ✓ Synced: architect.md
# ✓ Synced: architect.mdc
# ℹ  Processing: super_agentes
# ✓ Synced: design-system.md
# ✓ Synced: design-system.mdc
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ✓ Sync complete!
# ℹ  Files synced: 4
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Bypass sync** (emergency only):
```bash
git commit --no-verify
```

## What Gets Synced?

### 1. AIOS Core Agents

**Source:** `.aios-core/agents/*.md`

**Destinations:**
- `.claude/commands/AIOS/agents/*.md` (with slash-command wrapper)
- `.cursor/rules/*.mdc` (with cursor-rule wrapper)

**Example:**
```
.aios-core/agents/architect.md
  → .claude/commands/AIOS/agents/architect.md
  → .cursor/rules/architect.mdc
```

### 2. Super Agentes (Expansion Pack)

**Source:** `expansion-packs/super-agentes/agents/*.md`

**Destinations:**
- `.claude/commands/SA/agents/*.md` (no wrapper)
- `.cursor/rules/*.mdc` (with cursor-rule wrapper)

**Example:**
```
expansion-packs/super-agentes/agents/design-system.md
  → .claude/commands/SA/agents/design-system.md
  → .cursor/rules/design-system.mdc
```

### 3. Tasks, Workflows, Checklists

**Source:** `expansion-packs/*/tasks/*.md`, `expansion-packs/*/workflows/*.md`, etc.

**Destinations:** Configured per IDE in `.aios-sync.yaml`

## Adding a New IDE

To add support for a new IDE (e.g., Windsurf):

### 1. Update .aios-sync.yaml

Uncomment or add the IDE to `active_ides`:

```yaml
active_ides:
  - claude
  - cursor
  - windsurf  # ← Add this
```

### 2. Add Destination Mappings

Add destination configuration to each sync mapping:

```yaml
sync_mappings:
  aios_core_agents:
    source: ".aios-core/agents/"
    destinations:
      # ... existing ...
      windsurf:
        - path: ".windsurf/agents/"
          format: "md"
          wrapper: "none"
```

### 3. Run Sync

```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --ide=windsurf
```

### 4. Verify

```bash
ls .windsurf/agents/
# Should contain synced agent files
```

## Troubleshooting

### Sync fails with "yq not found"

**Solution:**
```bash
brew install yq  # macOS
```

### Files not syncing

**Check:**
1. Is the IDE active in `.aios-sync.yaml`?
2. Does the source file exist?
3. Is it excluded (e.g., `README.md`)?
4. Run with `--verbose` to see debug info

### Want to see what would sync without changing files

```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --dry-run --verbose
```

### Sync log not showing operations

Check `.aios-sync.log`:
```bash
tail -f .aios-sync.log
```

### Need to restore from backup

Backups are created as `.bak` files:
```bash
cp .cursor/rules/design-system.mdc.bak .cursor/rules/design-system.mdc
```

## Rollback & Recovery

### Emergency: Disable Auto-Sync

If the sync is causing issues during commits:

```bash
# Option 1: Bypass for single commit
git commit --no-verify -m "your message"

# Option 2: Disable in config
# Edit .aios-sync.yaml and set:
# behavior:
#   auto_sync_on_commit: false
```

### Restore Individual Files

Restore a single file from backup:

```bash
# Find backup files
find .claude -name "*.bak"
find .cursor -name "*.bak"

# Restore specific file
cp .claude/commands/SA/agents/design-system.md.bak .claude/commands/SA/agents/design-system.md
```

### Restore All Files in Directory

Restore all backups in a directory:

```bash
# Restore all Claude Code backups
for file in .claude/commands/SA/agents/*.bak; do
    cp "$file" "${file%.bak}"
done

# Restore all Cursor backups
for file in .cursor/rules/*.bak; do
    cp "$file" "${file%.bak}"
done
```

### Full Rollback

To completely remove all synced IDE configurations:

```bash
# WARNING: This removes all synced files!

# Remove Claude Code synced files
rm -rf .claude/commands/SA/
rm -rf .claude/commands/CreatorOS/
rm -rf .claude/commands/MMOS/
rm -rf .claude/commands/InnerLens/
rm -rf .claude/commands/ETL/
rm -rf .claude/commands/fragments/

# Remove Cursor synced files (if enabled)
rm -rf .cursor/rules/*.mdc

# Alternative: Restore from git
git checkout .claude/commands/
git checkout .cursor/rules/
```

### Recover from Failed Sync

If a sync fails mid-operation:

```bash
# 1. Check the log for errors
tail -50 .aios-sync.log

# 2. Restore from backups if needed (see above)

# 3. Fix the issue (install yq, fix permissions, etc.)

# 4. Run sync again with dry-run first
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --dry-run

# 5. Run actual sync
./expansion-packs/super-agentes/scripts/sync-to-ides.sh
```

### Clean Up Backup Files

Remove old backup files to save space:

```bash
# Find all backup files
find .claude -name "*.bak"
find .cursor -name "*.bak"

# Delete all backups (CAREFUL!)
find .claude -name "*.bak" -delete
find .cursor -name "*.bak" -delete
```

**Note:** `.bak` files are already in `.gitignore` and won't be committed.

For detailed migration and rollback procedures, see:
- [IDE Sync Migration Guide](./ide-sync-migration-guide.md)

## Best Practices

### 1. Always Edit Source Files

✅ **DO:**
- Edit `expansion-packs/super-agentes/agents/design-system.md`
- Let sync propagate changes to IDEs

❌ **DON'T:**
- Edit `.claude/commands/SA/agents/design-system.md` directly
- Changes will be overwritten on next sync

### 2. Test with Dry-Run First

Before syncing major changes:
```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --dry-run
```

### 3. Review Sync Log

Check what was synced:
```bash
tail -20 .aios-sync.log
```

### 4. Commit Synced Files Together

```bash
git add expansion-packs/super-agentes/agents/design-system.md
git add .claude/commands/SA/agents/design-system.md
git add .cursor/rules/design-system.mdc
git commit -m "feat(design-system): add scan command"
```

The pre-commit hook will re-sync and stage any changes.

## Advanced Configuration

### Exclude Specific Files

Edit `.aios-sync.yaml`:

```yaml
exclusions:
  - "*.bak"
  - "*.tmp"
  - "*-test.md"
  - "INTERNAL-*.md"
  - "my-secret-agent.md"  # ← Add here
```

### Change Wrapper Templates

Customize wrappers in `.aios-sync.yaml`:

```yaml
wrappers:
  my-custom-wrapper:
    prepend: |
      <!-- Custom Header -->
      {content}
```

### Disable Auto-Sync on Commit

Edit `.aios-sync.yaml`:

```yaml
behavior:
  auto_sync_on_commit: false  # ← Change to false
```

Then manually sync when needed.

## File Structure Reference

```
project-root/
├── .aios-sync.yaml              # Sync configuration
├── .aios-sync.log               # Sync operations log
├── .git/hooks/
│   └── pre-commit               # Auto-runs sync
├── expansion-packs/
│   ├── super-agentes/
│   │   ├── agents/              # ← Source of truth
│   │   │   ├── design-system.md
│   │   │   └── db-sage.md
│   │   ├── tasks/
│   │   ├── workflows/
│   │   ├── checklists/
│   │   └── scripts/
│   │       └── sync-to-ides.sh  # Sync script
├── .aios-core/
│   └── agents/                  # ← AIOS core agents
│       └── architect.md
├── .claude/
│   └── commands/
│       ├── AIOS/agents/         # ← Synced from .aios-core
│       └── SA/agents/           # ← Synced from super-agentes
└── .cursor/
    └── rules/                   # ← Synced (all agents as .mdc)
```

## FAQ

### Q: Do I need to manually sync after editing an agent?

**A:** No, the git pre-commit hook automatically syncs before commits.

### Q: What if I want to sync without committing?

**A:** Run the script manually:
```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh
```

### Q: Can I sync to only one IDE?

**A:** Yes:
```bash
./expansion-packs/super-agentes/scripts/sync-to-ides.sh --ide=claude
```

### Q: How do I add a new agent?

**A:**
1. Create `expansion-packs/super-agentes/agents/my-agent.md`
2. Commit (sync runs automatically)
3. Agent is now available in all active IDEs

### Q: What's the difference between .md and .mdc?

**A:**
- `.md` = Standard markdown (Claude Code, Windsurf, etc.)
- `.mdc` = Cursor-specific format with YAML frontmatter

The sync script auto-converts between formats.

### Q: Can I customize the sync behavior?

**A:** Yes, edit `.aios-sync.yaml` to customize:
- Active IDEs
- Destination paths
- Wrappers
- Exclusions
- Behavior settings

---

**Need Help?**

- Check `.aios-sync.log` for detailed operation logs
- Run with `--verbose` for debug output
- Use `--dry-run` to preview without changes
- Review this guide: `docs/guides/ide-sync-guide.md`

**Version History:**
- v1.0.0 (2025-10-28): Initial release with Claude/Cursor support
