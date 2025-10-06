# AIOS Launcher MVP

Command-line tool for MMOS Pipeline Orchestration.

## Overview

The AIOS Launcher maps prompts to agents, injects context, and logs executions for the MMOS (Mind Mapper OS) pipeline.

**Success Criteria**: ≥30% time reduction (5min → ≤3.5min per prompt)

## Installation

1. Create a virtual environment:
```bash
python3 -m venv docs/mmos/launcher/.venv
source docs/mmos/launcher/.venv/bin/activate
```

2. Install dependencies:
```bash
pip install -r docs/mmos/launcher/requirements.txt
```

## Usage

### Basic Command

```bash
source docs/mmos/launcher/.venv/bin/activate
python3 -m docs.mmos.launcher.cli \
  --mind MIND_NAME \
  --phase PHASE \
  --prompt PROMPT_ID
```

### Example

```bash
python3 -m docs.mmos.launcher.cli \
  --mind steve_jobs \
  --phase analysis \
  --prompt analysis_mental_models
```

### Options

| Option | Description |
|--------|-------------|
| `--mind` | Mind name (e.g., `steve_jobs`) - **Required** |
| `--phase` | Phase name (e.g., `analysis`) - **Required** |
| `--prompt` | Prompt ID (e.g., `analysis_mental_models`) - **Required** |
| `--show-context` | Display loaded context files |
| `--show-deps` | Display dependency check results |
| `--dry-run` | Dry run (do not log execution) |

### Available Phases

- `viability` - Initial assessment and PRD generation
- `research` - Source discovery and collection
- `analysis` - Deep behavioral and cognitive analysis
- `synthesis` - Template extraction and framework synthesis
- `implementation` - System prompt compilation
- `testing` - Validation and quality assurance

## Output

The launcher displays:

- ✅ Prompt metadata (title, agent, phase)
- ✅ Expected output paths (with resolved timestamps)
- ✅ Dependency status
- ✅ Context loading status
- ✅ Next steps for execution

### Example Output

```
🔍 Loading prompt: analysis_mental_models

============================================================
📋 Prompt: Mental Models
🔖 ID: analysis_mental_models
📍 Phase: analysis
🤖 Agent: @analyst
⚡ Parallelizable: Yes
============================================================

📄 Prompt file: docs/mmos/prompts/analysis_mental_models.md

📤 Expected outputs:
   • minds/steve_jobs/artifacts/mental_models.md
     (Modelo mental)

🚀 Next steps:
   1. Open prompt file: docs/mmos/prompts/analysis_mental_models.md
   2. Activate agent: @analyst
   3. Copy prompt content to Claude
   4. Review loaded context (MIND_BRIEF, PRD, sources)
   5. Execute the prompt

✅ Execution logged to launcher-history.yaml
⏱️  Duration: 23ms
```

## Execution History

All executions are logged to `docs/mmos/launcher-history.yaml`:

```yaml
schema_version: '1.0'
executions:
- timestamp: '2025-10-05T23:51:57.832603'
  mind: steve_jobs
  phase: analysis
  prompt_id: analysis_mental_models
  prompt_title: Mental Models
  agent: analyst
  user: oalanicolas
  output_path: minds/steve_jobs/artifacts/mental_models.md
  parallelizable: true
  context_shown: false
  dry_run: false
  duration_ms: 23
```

## Architecture

```
launcher/
├── __init__.py             # Package initialization
├── cli.py                  # Click CLI entrypoint
├── prompt_loader.py        # Load prompts from prompts.yaml
├── context_loader.py       # Load MIND_BRIEF, PRD, sources
├── path_resolver.py        # Resolve {mind}, {timestamp} templates
├── logger.py               # Execution logging
├── deps_checker.py         # Check dependencies completion
├── requirements.txt        # Python dependencies
└── README.md               # This file
```

## Technical Details

- **Language**: Python 3.11+
- **Framework**: Click (CLI)
- **Data Format**: YAML
- **Source of Truth**: `docs/mmos/prompts.yaml` (59 prompts)
- **Read-Only**: minds/ directory (never modifies existing files)

## See Also

- [Launcher Spec](../architecture/launcher-spec.md) - Complete technical specification
- [PRD](../docs/PRD.md) - Product requirements document
- [Prompts Catalog](../prompts.yaml) - All 59 MMOS prompts

---

**AIOS Launcher MVP v0.1.0** | Part of the MMOS Pipeline
