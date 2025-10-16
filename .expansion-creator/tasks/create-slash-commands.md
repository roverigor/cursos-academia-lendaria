# Create Slash Commands Task

## Purpose

Create slash command structure in `.claude/commands/{PackName}/` for an expansion pack, following the EXACT universal pattern: `agents/` and `tasks/` directories ONLY, verified against ANY existing expansion pack.

## Critical Rules

**STRUCTURE VALIDATION:**
- ✅ ONLY create `agents/` and `tasks/` directories
- ❌ DO NOT create README.md, config.yaml, or any other files
- ✅ Directory name MUST be PascalCase (derived from pack name)
- ✅ Each agent/task file is a standalone command activation file
- ✅ Structure MUST match universal pattern (inspect ANY existing pack as reference)

## Inputs

- Expansion pack config.yaml (for pack name and slashPrefix)
- Expansion pack agents/ directory (source)
- Expansion pack tasks/ directory (source)
- ANY existing `.claude/commands/` directory as pattern reference

## Workflow Steps

### 1. Validate Existing Pattern

**CRITICAL: Inspect ANY existing slash command directory FIRST**

```bash
# Find any existing expansion command directory
EXAMPLE_DIR=$(find .claude/commands -mindepth 1 -maxdepth 1 -type d | head -1)

# Examine its structure
ls -la "$EXAMPLE_DIR"
```

**Expected structure (UNIVERSAL PATTERN):**
```
.claude/commands/{PackName}/
├── agents/
│   └── *.md files (command activation files)
└── tasks/
    └── *.md files (task command files)

NOTHING ELSE:
- NO README.md
- NO config.yaml
- NO subdirectories beyond agents/ and tasks/
- NO documentation files
```

**Validation command:**
```bash
# Count items in directory (should be exactly 2: agents/ and tasks/)
ls -la .claude/commands/{AnyExistingPack}/ | grep -E '^d' | wc -l
# Expected output: 2 (plus . and ..)
```

### 2. Determine Directory Name

**Pattern Rule:**
- Read `slashPrefix` from `expansion-packs/{pack}/config.yaml`
- Use **PascalCase** conversion of slashPrefix for directory name
- Examples:
  - `slashPrefix: mmos` → Directory: `MMOS`
  - `slashPrefix: creator` → Directory: `CreatorOS` (if pack name is creator-os)
  - `slashPrefix: legalAssistant` → Directory: `LegalAssistant`

**Algorithm:**
1. Get pack name from config: `name: {pack-name}`
2. Convert to PascalCase (capitalize each word, remove hyphens)
3. Use as directory name: `.claude/commands/{PascalCaseName}/`

### 3. Create Directory Structure

```bash
mkdir -p .claude/commands/{PackName}/agents
mkdir -p .claude/commands/{PackName}/tasks
```

**VALIDATION CHECKPOINT:**
```bash
# Structure should match UNIVERSAL PATTERN:
.claude/commands/{PackName}/
├── agents/     # empty for now
└── tasks/      # empty for now

# Verify structure matches ANY existing pack:
EXAMPLE_PACK=$(find .claude/commands -mindepth 1 -maxdepth 1 -type d | head -1)
diff <(ls "$EXAMPLE_PACK" | sort) <(ls .claude/commands/{PackName} | sort)
# Output should be empty OR show only different file names, NOT different directories

# Count items (must be exactly 2):
ls -la .claude/commands/{PackName}/ | grep -E '^d' | wc -l
# Expected: 2 (agents/ and tasks/)
```

### 4. Convert Agents to Slash Commands

For each agent in `expansion-packs/{pack}/agents/`:

**Read source agent:**
```
expansion-packs/{pack}/agents/{agent-id}.md
```

**Create slash command:**
```
.claude/commands/{PackName}/agents/{agent-id}.md
```

**Command file structure:**
```markdown
# /{agent-id} Command

When this command is used, adopt the following agent persona:

# {agent-id}

ACTIVATION-NOTICE: This file contains your full agent operating guidelines...

[Copy ENTIRE content from source agent file]
```

**Key transformations:**
- Keep ALL content from source (YAML, persona, commands, dependencies)
- Update IDE-FILE-RESOLUTION paths if needed
- Ensure activation instructions are preserved

### 5. Convert Tasks to Slash Commands

For each task in `expansion-packs/{pack}/tasks/`:

**Read source task:**
```
expansion-packs/{pack}/tasks/{task-id}.md
```

**Create slash command:**
```
.claude/commands/{PackName}/tasks/{task-id}.md
```

**Command file structure:**
```markdown
# /{task-id} Task

[Brief description of task purpose]

```yaml
purpose: "..."
prerequisites:
  - ...
interactive: true/false
estimated_time: "..."
```

## Elicitação
```
[List interactive prompts if applicable]
```

## Passos
[Concise workflow steps - NOT full spec]

## Success Criteria
[Validation checkboxes]

## Integration
[Notes about integration with other expansion packs or databases, if applicable]

---

**Full Task Specification:** `expansion-packs/{pack}/tasks/{task-id}.md`
```

**Key transformations:**
- SIMPLIFIED version (not full 40KB spec)
- Link to full spec at bottom
- Focus on: purpose, elicitation, steps, success criteria

### 6. Final Validation

**MANDATORY CHECKS:**

```bash
# 1. Structure matches universal pattern
find .claude/commands/{PackName} -type f | wc -l  # Should be agents + tasks count only

# 2. NO extra files (CRITICAL)
ls -la .claude/commands/{PackName}/  # Should show ONLY agents/ and tasks/
# Count: exactly 2 directories (+ . and ..)

# 3. Compare with ANY existing pack
EXAMPLE_PACK=$(find .claude/commands -mindepth 1 -maxdepth 1 -type d | head -1)
diff <(find "$EXAMPLE_PACK" -type d | sed "s|$EXAMPLE_PACK|PACK|" | sort) \
     <(find .claude/commands/{PackName} -type d | sed 's|.claude/commands/[^/]*|PACK|' | sort)
# Output should be empty (structure identical)

# 4. Verify agent files are valid
head -20 .claude/commands/{PackName}/agents/*.md
# Each should start with "# /{agent-id} Command"

# 5. Verify task files are valid
head -20 .claude/commands/{PackName}/tasks/*.md
# Each should start with "# /{task-id} Task"

# 6. Final count check
test $(ls -la .claude/commands/{PackName}/ | grep -E '^d' | wc -l) -eq 2 && echo "✅ PASS" || echo "❌ FAIL"
# Must output: ✅ PASS
```

**If validation fails:**
- Delete `.claude/commands/{PackName}/`
- Inspect structure of ANY existing expansion pack
- Identify what differs from universal pattern
- Restart from step 1

## Common Mistakes to Avoid

❌ **DO NOT:**
- Create README.md in `.claude/commands/{PackName}/`
- Create config.yaml or any config files
- Copy full 40KB task specs (use simplified version)
- Add package.json, node_modules, or other project files
- Create subdirectories beyond agents/ and tasks/

✅ **DO:**
- Match EXACTLY the universal pattern (agents/ + tasks/ only)
- Use PascalCase for directory name (from pack name)
- Preserve all agent YAML configuration
- Link to full specs for tasks
- Verify structure against ANY existing pack before finalizing

## Output

```
.claude/commands/{PackName}/
├── agents/
│   ├── agent-1.md
│   ├── agent-2.md
│   └── agent-n.md
└── tasks/
    ├── task-1.md
    ├── task-2.md
    └── task-n.md
```

**NOTHING ELSE. NO README. NO CONFIG.**

## Success Criteria

- [ ] Directory name is PascalCase (derived from pack name)
- [ ] ONLY agents/ and tasks/ directories exist
- [ ] NO README.md in `.claude/commands/{PackName}/`
- [ ] NO config files or any other files
- [ ] All agent files start with `# /{agent-id} Command`
- [ ] All task files start with `# /{task-id} Task`
- [ ] Structure identical to universal pattern (verified against ANY existing pack)
- [ ] Count check passes: exactly 2 subdirectories (agents/ and tasks/)

---

**Task Version:** 1.1
**Last Updated:** 2025-10-16
**Critical Pattern:** UNIVERSAL - agents/ and tasks/ directories ONLY, nothing else
