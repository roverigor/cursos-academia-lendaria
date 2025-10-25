# MMOS Mind Mapper Workflows

**Purpose:** AIOS-compliant executable workflows for mind clone creation and maintenance

---

## 📊 MMOS Workflow Matrix (2×2)

MMOS supports **4 distinct workflows** based on two dimensions:
1. **Source Type:** Public Figure (web scraping) vs Private Individual (interviews/materials)
2. **Starting Point:** Greenfield (new) vs Brownfield (existing)

```
┌─────────────────┬──────────────────────────────┬──────────────────────────────┐
│                 │   GREENFIELD (New)           │   BROWNFIELD (Existing)      │
├─────────────────┼──────────────────────────────┼──────────────────────────────┤
│ PÚBLICO         │  Workflow A                  │  Workflow C                  │
│ (Web Scraping)  │  greenfield-mind.yaml        │  brownfield-mind.yaml        │
│                 │  [Example: Sam Altman]       │  [Example: Rare]             │
│                 │  8-12 days | 2-3M tokens     │  2-5 days | 500K-1M tokens   │
├─────────────────┼──────────────────────────────┼──────────────────────────────┤
│ PRIVADO         │  Workflow B                  │  Workflow D                  │
│ (Interviews)    │  private-individual.yaml     │  brownfield-private.yaml     │
│                 │  [Example: José, Alan]       │  [Example: João Lozano]      │
│                 │  15-20h | 1-2M tokens        │  10-19h | 300K-500K tokens   │
└─────────────────┴──────────────────────────────┴──────────────────────────────┘
```

---

## 📋 Available Workflows

### Workflow A: Public + Greenfield ✅
**File:** `greenfield-mind.yaml`
**Example:** Sam Altman, Naval Ravikant
**Duration:** 8-12 days | **Tokens:** 2-3M

**Use when:**
- Creating clone of public figure from scratch
- Abundant web content available
- No direct access to person

**Process:**
1. Viability (APEX scoring)
2. Web scraping (50+ sources)
3. DNA Mental™ 8-layer analysis
4. Synthesis & system prompt
5. Validation (simulated)

**Key Features:**
- Automated research collection
- Cross-source triangulation
- 6 human checkpoints
- Parallel execution optimization

---

### Workflow B: Private + Greenfield ✅
**File:** `private-individual.yaml`
**Example:** José Amorim, Alan Nicolas, Pedro Valério
**Duration:** 15-20 hours | **Tokens:** 1-2M

**Use when:**
- Creating clone of private individual
- Person has no public content
- Person available for interviews

**Process:**
1. Modified viability (interview availability)
2. 5 structured interview sessions (8-12h)
3. DNA Mental™ 8-layer analysis
4. Synthesis & system prompt
5. Direct validation with person (Session 5)

**Key Features:**
- Interview-first methodology
- Higher source quality (direct from person)
- Direct validation loop
- Privacy & consent protocols

**Critical for Creator-OS:** Team member cloning at scale

---

### Workflow C: Public + Brownfield ⚠️
**File:** `brownfield-mind.yaml`
**Example:** Rare (hypothetical migration)
**Duration:** 2-5 days | **Tokens:** 500K-1M

**Use when:**
- Updating existing public figure clone
- Adding new sources to existing mind
- Refining architecture
- Fixing gaps or inconsistencies

**Process:**
1. Backup original
2. Incremental source addition
3. Differential analysis
4. Consistency validation
5. Selective prompt update

**Key Features:**
- Automatic backup + rollback
- Regression testing
- Version management
- 60-75% faster than greenfield

---

### Workflow D: Private + Brownfield 🆕 ⚡
**File:** `brownfield-private.yaml`
**Example:** João Lozano (Neural Flow → MMOS)
**Duration:** 10-19 hours | **Tokens:** 300K-500K

**⚡ FASTEST & MOST EFFICIENT WORKFLOW!**

**Use when:**
- Migrating existing clone from another system
- Person created own clone/documentation
- Original quality is high
- Format conversion needed

**Process:**
1. Assessment & mapping (original → MMOS)
2. Preservation (80% - keep what's excellent)
3. Format conversion (15% - adapt structure)
4. Enhancement (5% - fill critical gaps only)
5. Innovation extraction (improve MMOS!)
6. Validation with person

**Key Features:**
- **Preservation-first philosophy**
- Extract innovations to improve MMOS
- Minimal creation (mostly adaptation)
- Person validation included
- 50-70% faster than any greenfield

**Philosophy:** "Preserve excellence, enhance gaps, extract innovations"

---

## 🎯 Workflow Selection Guide

### Decision Tree

```
❓ Do you have an existing mind to update?
├─ YES → Use brownfield-mind.yaml
│  └─ 60-75% faster, incremental changes
│
└─ NO → Use greenfield-mind.yaml
   ├─ Public figure? → Public Figure Mode
   │  └─ Full pipeline with web scraping
   │
   └─ Private individual? → Private Individual Mode
      └─ Use provided materials, skip viability
```

---

## 🔧 How to Use Workflows (AIOS)

### Method 1: Agent-Based Execution (Recommended)

```bash
# Activate MMOS agent
@mind-mapper

# Request workflow execution
"Execute greenfield-mind workflow for [person_name]"
"Execute brownfield-mind workflow to update [existing_mind]"
```

The agent will:
1. Load workflow YAML
2. Execute sequence step-by-step
3. Pause at human checkpoints
4. Track progress and outputs

### Method 2: Task-Based Execution

```bash
# Use AIOS task system
*task execute-mmos-pipeline [mind_name] --workflow=greenfield
*task execute-mmos-pipeline [mind_name] --workflow=brownfield
```

### Method 3: Manual Step Execution

Read the workflow YAML and execute each sequence step manually:

1. Review workflow structure
2. Execute each agent/task in sequence
3. Validate prerequisites before each step
4. Create outputs as specified
5. Pause at human checkpoints

---

## 📊 Workflow Comparison

| Feature | Greenfield | Brownfield |
|---------|-----------|-----------|
| **Use Case** | New mind clone | Update existing |
| **Duration** | 8-12 days | 2-5 days |
| **Tokens** | 2-3M | 500K-1M |
| **Risk** | Low (clean start) | Medium (may break) |
| **Backup** | Not needed | MANDATORY |
| **Testing** | Initial validation | Regression + new |
| **Phases** | 6 complete phases | Selective steps |
| **Rollback** | N/A | Always available |

---

## 🏗️ Workflow Structure (AIOS Standard)

All workflows follow this YAML structure:

```yaml
workflow:
  id: workflow-name
  name: Human-Readable Name
  description: What this workflow does
  type: greenfield | brownfield
  project_types: [list]

  sequence:
    - agent: agent-name
      phase: phase-name
      creates: output-description
      task: task-file-name
      prerequisites: [list]
      outputs: [paths]
      human_checkpoint: true/false
      checkpoint_type: TYPE
      notes: |
        Detailed instructions...
```

### Workflow Components

**Agent:** Which AIOS agent executes this step
- `analyst` - Research, analysis, data work
- `architect` - System design, architecture
- `qa` - Quality assurance, testing
- `pm` - Product management, documentation

**Phase:** Logical grouping of steps
- `viability` - Assessment
- `research` - Source collection
- `analysis` - DNA Mental™ layers
- `synthesis` - Knowledge compilation
- `implementation` - System prompt creation
- `testing` - Validation

**Task:** References to `../tasks/*.md` files
- Each task is a reusable operation
- Tasks can be executed independently
- Tasks have their own documentation

**Human Checkpoint:** Quality gates requiring approval
- Decision points that need human judgment
- Cannot be automated
- Workflow pauses until user approves

---

## ✅ Success Criteria

### Greenfield Workflow Success
- [ ] Viability validated (APEX ≥ 50 OR private mode)
- [ ] Sources adequate (≥15 total, ≥5 high-confidence)
- [ ] 8 DNA Mental™ layers complete
- [ ] All 6 human checkpoints approved
- [ ] System prompt v1.0 generated
- [ ] Fidelity ≥ 94% (or documented reasons)
- [ ] Production approval received

### Brownfield Workflow Success
- [ ] Backup created before changes
- [ ] Plan documented and approved
- [ ] Differential analysis complete
- [ ] Consistency checks passed
- [ ] Regression tests passed
- [ ] Fidelity stable or improved
- [ ] Documentation updated
- [ ] Rollback tested and available

---

## 🚨 Common Pitfalls

### Greenfield Mistakes
- ❌ Skipping human checkpoints (leads to low quality)
- ❌ Insufficient sources (<15 total)
- ❌ Rushing through Layer 8 paradoxes (critical!)
- ❌ Not validating triangulation (Layers 5-8)
- ❌ Deploying with <94% fidelity without documentation

### Brownfield Mistakes
- ❌ No backup created (no rollback possible)
- ❌ Regenerating from scratch (defeats purpose)
- ❌ Skipping regression tests (breaks production)
- ❌ Overwriting without versioning (loses history)
- ❌ Deploying without approval (risky changes)

---

## 📚 Related Documentation

### Expansion Pack Structure
```
expansion-packs/mmos/
├── workflows/           ← YOU ARE HERE
│   ├── greenfield-mind.yaml
│   ├── brownfield-mind.yaml
│   └── README.md
├── tasks/              ← Reusable operations
├── agents/             ← Agent personas
├── templates/          ← Document templates
├── checklists/         ← Validation checklists
└── README.md           ← Main pack documentation
```

### Documentation
- **Main Pack:** `../README.md` - Complete MMOS documentation
- **Tasks:** `../tasks/` - Individual task definitions
- **Agents:** `../agents/` - Agent personas and capabilities
- **Templates:** `../templates/` - Output templates
- **Methodology:** `docs/methodology/dna-mental.md` - 8-layer framework

### System Documentation
- **Architecture:** `docs/mmos/architecture/` - System design
- **Guides:** `docs/guides/` - User guides
- **PRD:** `docs/prd/mmos-prd.md` - Product vision

---

## 🔄 Workflow Lifecycle

### 1. Selection
Choose appropriate workflow (greenfield vs brownfield)

### 2. Planning
- Review prerequisites
- Gather required materials
- Estimate resources (time, tokens)

### 3. Execution
- Follow sequence steps
- Execute with appropriate agents
- Validate outputs at each step
- Pause at human checkpoints

### 4. Validation
- Run quality checks
- Execute test protocols
- Review fidelity scores
- Approve/reject for production

### 5. Deployment
- Finalize documentation
- Update catalogs
- Archive outputs
- Document learnings

---

## 💡 Best Practices

### Workflow Execution
1. **Read entire workflow** before starting
2. **Prepare prerequisites** in advance
3. **Execute sequentially** (respect dependencies)
4. **Validate at each step** (don't rush)
5. **Document decisions** at checkpoints
6. **Test thoroughly** before production

### Quality Management
- **Never skip** human checkpoints
- **Always validate** triangulation (Layers 5-8)
- **Test regressions** in brownfield updates
- **Document everything** (logs, decisions, changes)
- **Maintain backups** (brownfield) or snapshots (greenfield)

### Efficiency Tips
- **Use parallel execution** where indicated
- **Reuse existing tasks** (don't reinvent)
- **Leverage templates** for consistency
- **Automate validation** (use checklists)
- **Track token usage** (optimize as you go)

---

## 🎓 Learning Resources

### Understanding DNA Mental™
The 8-layer methodology is core to MMOS:

1. **Layer 1:** Behavioral Patterns (observable actions)
2. **Layer 2:** Communication Style (linguistic patterns)
3. **Layer 3:** Routine & Habits (temporal patterns)
4. **Layer 4:** Recognition Patterns (mental radars)
5. **Layer 5:** Mental Models (frameworks)
6. **Layer 6:** Values Hierarchy (principles)
7. **Layer 7:** Core Obsessions (driving forces)
8. **Layer 8:** Productive Paradoxes (complexity)

**Layer 8 is the differentiator** - what makes clones feel authentically human vs robotic.

See: `docs/methodology/dna-mental.md`

### AIOS Integration
- Workflows integrate with AIOS agent system
- Use `@mind-mapper` for MMOS workflows
- Use `*task` commands for specific operations
- Leverage AIOS memory for context retention

See: `.aios-core/` and AIOS documentation

---

## 🔧 Customization

### Creating Custom Workflows

Follow AIOS workflow YAML structure:

1. Copy existing workflow as template
2. Modify sequence for your use case
3. Update outputs to match your needs
4. Define custom checkpoints
5. Document prerequisites clearly
6. Test thoroughly before production use

### Extending Workflows

Add custom steps to existing workflows:

1. Identify insertion point in sequence
2. Define new step with proper structure
3. Specify prerequisites and outputs
4. Update validation criteria
5. Document changes in workflow notes

---

## ⚙️ Technical Specifications

### Workflow Metadata
- **Format:** YAML (`.yaml`)
- **Schema:** AIOS workflow schema v3.0
- **Encoding:** UTF-8
- **Line endings:** LF (Unix-style)

### Execution Environment
- **Runtime:** AIOS framework
- **Agents:** analyst, architect, qa, pm
- **Tasks:** `../tasks/*.md`
- **Templates:** `../templates/*.md` or `.yaml`
- **Checklists:** `../checklists/*.md`

### Output Specifications
- **Minds location:** `outputs/minds/{slug}/`
- **Not versioned:** Outputs are gitignored
- **Structure:** Follows MMOS architecture rules
- **Format:** Markdown, YAML, plain text

---

## 📝 Version History

### v3.0 - 2025-10-25 (Current)
- ✅ Converted to AIOS workflow YAML format
- ✅ Moved from `docs/mmos/workflows/` to expansion pack
- ✅ Added greenfield-mind.yaml (complete pipeline)
- ✅ Added brownfield-mind.yaml (incremental updates)
- ✅ Full AIOS compliance with CreatorOS pattern
- ✅ Added private individual mode support
- ✅ Enhanced human checkpoint documentation

### v2.0 - 2025-10-17 (Deprecated)
- Markdown-based workflows in `docs/mmos/workflows/`
- Non-executable, reference documentation only
- Moved to expansion pack for AIOS compliance

### v1.0 - 2025-10-04 (Legacy)
- Original workflow documentation
- Archived

---

## 🆘 Troubleshooting

### Workflow won't start
- ✅ Check prerequisites are met
- ✅ Verify AIOS agent is available
- ✅ Ensure required tasks exist in `../tasks/`
- ✅ Validate input parameters

### Human checkpoint stuck
- ✅ Review checkpoint criteria
- ✅ Examine validation results
- ✅ Check for missing outputs
- ✅ Consult checkpoint documentation

### Outputs not generating
- ✅ Verify output path is correct
- ✅ Check directory permissions
- ✅ Ensure prerequisites completed
- ✅ Review agent execution logs

### Fidelity score too low
- ✅ Review Layer 8 (paradoxes) - most common issue
- ✅ Check source quality and quantity
- ✅ Validate triangulation on Layers 5-8
- ✅ Re-execute analysis with more depth

---

## 📞 Support

### Questions?
- Read workflow YAML `notes` sections (detailed instructions)
- Check `../tasks/` for task-specific documentation
- Review `../README.md` for expansion pack overview
- Consult `docs/methodology/dna-mental.md` for methodology

### Issues?
- Document in `docs/logs/` with timestamp
- Update TODO.md with action items
- Report structural issues to architect
- Update this README if patterns found

---

**Workflow System Version:** 3.0 (AIOS-compliant)
**Last Updated:** 2025-10-25
**Maintained By:** MMOS Mind Mapper Team
