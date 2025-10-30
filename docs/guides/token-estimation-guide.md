# Token Estimation & Resource Planning Guide

**ARCHIVED FROM CLAUDE.md** - Reference guide for token estimation in AIOS-FULLSTACK

This document was moved from `.claude/CLAUDE.md` to reduce initialization token overhead. It remains valid guidance for expansion pack agents and complex operations.

---

## CRITICAL RULE: Pre-Execution Token Estimation

**BEFORE executing ANY multi-step operation (>2 sequential steps), TODO workflow, or expansion pack workflow, you MUST:**

1. **Calculate Token Estimate** - Break down into INPUT + PROCESSING + OUTPUT
2. **Present Estimate to User** - Use standardized format below
3. **Offer 3 Mitigation Paths** - Continue, subagent, or new window
4. **Wait for Explicit Confirmation** - User must choose option (1/2/3)

## When Estimation is Required

Estimate tokens for operations that meet ANY of these criteria:
- Multi-step workflow (3+ sequential steps)
- TODO list with multiple items
- Any command marked with `user-confirmation-required: true` in task metadata
- Operations that read/analyze >5 files
- Operations that generate >3 output files
- Web research with >3 queries
- Any expansion pack pipeline execution (*map, *new, *execute, etc.)

## Skip Estimation For

- Single-file reads (< 1K tokens)
- Simple grep/search operations
- Help commands (*help, *status, *list)
- Git operations (commit, push, status)
- Checkpoint-only operations

## Standardized Presentation Format

```
📊 ESTIMATIVA DE TOKENS: {operation_name}

INPUT (Leitura/Research):
  {item_1}:                ~{tokens}K tokens
  {item_2}:                ~{tokens}K tokens
  {item_3}:                ~{tokens}K tokens
  ─────────────────────────────────────────────────────────
  TOTAL INPUT:             ~{total}K tokens

PROCESSING (Análise/Síntese):
  {processing_1}:          ~{tokens}K tokens
  {processing_2}:          ~{tokens}K tokens
  ─────────────────────────────────────────────────────────
  TOTAL PROCESSING:        ~{total}K tokens

OUTPUT (Geração):
  {output_1}:              ~{tokens}K tokens
  {output_2}:              ~{tokens}K tokens
  ─────────────────────────────────────────────────────────
  TOTAL OUTPUT:            ~{total}K tokens

───────────────────────────────────────────────────────────
TOTAL ESTIMADO:            ~{grand_total}K tokens

Estado Projetado:
  Atual:  {current}K tokens ({current_pct}%)
  Após:   {after}K tokens ({after_pct}%)
  Livre:  {remaining}K tokens ({remaining_pct}% buffer)

Status: {status_indicator}

OPÇÕES:
1. Continuar nesta janela
   • Usa contexto atual
   • {risk_description}

2. Task/Subagent (contexto isolado) [RECOMENDADO se >70%]
   • Contexto separado (não soma ao atual)
   • Retorna apenas resultado final (~{reduced}K tokens)
   • Redução: {savings_pct}% de economia de contexto

3. Prompt para nova janela (fresh start)
   • Zero impacto no contexto atual
   • Documentação completa será fornecida
   • Copie e execute em nova janela ou após /clear

{agent_custom_option}

Sua escolha (1/2/3{/4})?
```

## Status Indicators

Use these indicators based on projected context usage:

- **✅ SEGURO** - Projected usage <70% of window
  - Safe to continue in current window
  - Mention option 2 as alternative for context savings

- **⚠️ APERTADO MAS VIÁVEL** - Projected usage 70-85% of window
  - Can continue but tight
  - **STRONGLY RECOMMEND option 2** (subagent)
  - Explain risks of continuing in current window

- **🚨 RISCO DE ESTOURO** - Projected usage >85% of window
  - **BLOCK option 1** (mark as unavailable)
  - **REQUIRE option 2 or 3**
  - Explain that continuing will likely cause context overflow

## Mitigation Strategies

### Option 1: Continue in Current Window
- User accepts the token cost
- Execute normally in current context
- Log decision for future reference
- **Automatically blocked if >85% projected usage**

### Option 2: Task/Subagent (Isolated Context) [RECOMMENDED >70%]

Execute using the Task tool with appropriate subagent:

```javascript
Task(
  subagent_type="general-purpose",  // or "Plan" for research
  description="Brief description",
  prompt="Complete operation prompt with all context needed"
)
```

**Benefits:**
- Separate context window (doesn't add to current)
- Returns only final result (~5-10K tokens)
- **Saves 80-90% of context usage**
- Can run in parallel with other work

**When to use:**
- Projected usage >70%
- Heavy research operations
- Large file generation
- Any operation where final summary is sufficient

### Option 3: New Window Prompt (Fresh Start)

Generate a complete standalone prompt containing:

1. **Operation Context**
   - What needs to be done
   - Why it's being done
   - Success criteria

2. **Required Documentation**
   - Relevant file contents
   - Configuration details
   - Dependencies and references

3. **Inputs Prepared**
   - All data needed to execute
   - Pre-processed information
   - File paths and locations

4. **Execution Instructions**
   - Step-by-step workflow
   - Validation checklist
   - Output specifications

5. **Handoff Instructions**
   - How to return results
   - What format to use
   - Where to save outputs

Present prompt in a code block for easy copying:

```markdown
# {Operation Name} - Standalone Execution Prompt

[Complete prompt with all sections above]

---
WHEN COMPLETE: Save results to {location} and notify user
```

**Benefits:**
- Zero impact on current context
- User can execute later or in fresh session
- All context preserved in prompt
- Can be saved for future use

**When to use:**
- Projected usage >85% (required)
- User wants to defer execution
- Operation is non-urgent
- Context preservation is critical

### Option 4: Agent Custom Path (Dynamic)

Agents can propose operation-specific alternatives:

- **Sharding**: Break into smaller sequential operations
- **Preview Mode**: Execute lightweight version first
- **Partial Execution**: Run critical phases only, defer others
- **Incremental**: Execute with checkpoints, allow user to pause/resume

Example:
```
4. Modo Preview (viabilidade only)
   • Executa apenas fase de assessment
   • ~50K tokens, 30 minutos
   • Decide se vale continuar com pipeline completo
```

## Token Estimation Formulas

### Base Rates

- **File read**: 1K tokens per 1,000 words (avg 4 chars/token)
- **Web search**: 5K tokens per query (including results analysis)
- **Document generation**: 2K tokens per 1,000 words output
- **Artifact analysis**: 3K tokens per artifact/document analyzed
- **Code generation**: 1.5K tokens per 100 lines of code

### Overhead Multipliers

- Context management: +20% for multi-step operations
- Error handling: +10% for operations with validation
- Interactive workflows: +15% for elicitation steps
- Parallel operations: +5% per additional concurrent operation

### Operation-Specific Estimates

**MMOS Operations:**
- `*map {name}` (greenfield full pipeline): 2.0M - 2.5M tokens
- `*map {name}` (brownfield update): 500K - 1M tokens
- `*viability {name}`: 50K tokens
- `*phase research {name}`: 500K - 800K tokens
- `*phase analysis {name}`: 800K tokens
- `*phase synthesis {name}`: 300K tokens

**CreatorOS Operations:**
- `*new {slug}` (full course): 200K - 500K tokens
- `*upgrade {slug}`: 100K - 300K tokens
- `*market-research {slug}`: 50K tokens
- `*curriculum {slug}`: 100K tokens
- `*generate-blog-post`: 30K - 50K tokens

**InnerLens Operations:**
- Full psychometric profile: 100K - 200K tokens
- Fragment extraction: 20K - 40K tokens per session
- Quality assurance review: 30K - 50K tokens

## Implementation Requirements for Expansion Pack Agents

All expansion pack agents MUST include token estimation in their `activation-instructions`:

```yaml
activation-instructions:
  - [... existing steps ...]
  - TOKEN ESTIMATION (CRITICAL): Before executing multi-step commands:
    1. Read task metadata (token-estimation section)
    2. Calculate estimate using formulas from CLAUDE.md
    3. Present using standardized format
    4. Wait for user choice (1/2/3/4)
    5. If option 2: Use Task tool with subagent
    6. If option 3: Generate complete standalone prompt
    7. Log decision and proceed
```

## Task Metadata Requirements

All multi-step tasks in expansion packs MUST include `token-estimation` in frontmatter:

```yaml
---
task-id: example-task
name: Example Task Name

token-estimation:
  input: 50000              # Tokens for reading/research
  processing: 100000        # Tokens for analysis/synthesis
  output: 30000             # Tokens for generation
  total_min: 150000         # Minimum estimate
  total_max: 200000         # Maximum estimate
  factors:                  # What drives the estimate
    - "Number of files to analyze (10-15 files)"
    - "Web research queries (5-8 queries)"
    - "Document generation (5,000 words)"
  alternatives:
    subagent_savings: "85%"  # Context saved with subagent
    sharding_option: "Break into 3 sequential phases"
    preview_mode: "Viability check only (50K tokens)"

user-confirmation-required: true
---
```

## Validation and Logging

After user selects an option, log the decision:

```yaml
token_estimation_log:
  operation: "{task_name}"
  estimated_tokens: {tokens}
  projected_usage: "{pct}%"
  status: "{SEGURO|APERTADO|RISCO}"
  user_choice: {1|2|3|4}
  timestamp: "{iso_timestamp}"
  rationale: "{user_explanation_if_provided}"
```

## Examples

### Example 1: Safe Operation

```
📊 ESTIMATIVA DE TOKENS: Generate Blog Post

INPUT (Leitura):
  Course outline:          ~5K tokens
  SEO keywords:            ~2K tokens
  ─────────────────────────────────────
  TOTAL INPUT:             ~7K tokens

PROCESSING (Geração):
  Content writing:         ~30K tokens
  SEO optimization:        ~5K tokens
  ─────────────────────────────────────
  TOTAL PROCESSING:        ~35K tokens

OUTPUT (Formatação):
  Final markdown:          ~8K tokens
  ─────────────────────────────────────
  TOTAL OUTPUT:            ~8K tokens

──────────────────────────────────────
TOTAL ESTIMADO:            ~50K tokens

Estado Projetado:
  Atual:  25K tokens (12%)
  Após:   75K tokens (37%)
  Livre:  125K tokens (63% buffer)

Status: ✅ SEGURO

OPÇÕES:
1. Continuar nesta janela
   • Usa contexto atual
   • Ainda teremos 63% de buffer livre

2. Task/Subagent (contexto isolado)
   • Retorna apenas post final (~8K tokens)
   • Redução: 84% de economia de contexto

3. Prompt para nova janela
   • Zero impacto no contexto atual

Sua escolha (1/2/3)?
```

### Example 2: Tight Operation

```
📊 ESTIMATIVA DE TOKENS: Full Course Generation

INPUT (Research):
  Market research:         ~50K tokens
  Competitor analysis:     ~40K tokens
  Audience profiling:      ~30K tokens
  ─────────────────────────────────────
  TOTAL INPUT:             ~120K tokens

PROCESSING (Criação):
  Curriculum design:       ~100K tokens
  Module breakdowns:       ~150K tokens
  Assessment creation:     ~50K tokens
  ─────────────────────────────────────
  TOTAL PROCESSING:        ~300K tokens

OUTPUT (Documentação):
  Course files:            ~80K tokens
  ─────────────────────────────────────
  TOTAL OUTPUT:            ~80K tokens

──────────────────────────────────────
TOTAL ESTIMADO:            ~500K tokens

Estado Projetado:
  Atual:  100K tokens (50%)
  Após:   600K tokens (300% - ESTOURO!)
  Livre:  -400K tokens

Status: 🚨 RISCO DE ESTOURO

OPÇÕES:
1. ❌ Continuar nesta janela (BLOQUEADO - estouro garantido)

2. ✅ Task/Subagent (contexto isolado) [RECOMENDADO]
   • Contexto separado (não soma aos 100K atuais)
   • Retorna apenas curso final (~50K tokens)
   • Redução: 90% de economia de contexto

3. ✅ Prompt para nova janela
   • Zero impacto no contexto atual
   • Documentação completa será fornecida

4. Modo Incremental (3 fases sequenciais)
   • Fase 1: Market research (120K tokens)
   • Fase 2: Curriculum design (200K tokens)
   • Fase 3: Module creation (200K tokens)
   • Permite checkpoints entre fases

Recomendação: Opção 2 (subagent) ou Opção 3 (nova janela)

Sua escolha (2/3/4)?
```

### Example 3: MMOS Pipeline

```
📊 ESTIMATIVA DE TOKENS: *map joao_lozano (greenfield)

INPUT (Research):
  Mode detection:          ~5K tokens
  Viability assessment:    ~50K tokens
  Source collection:       ~100K tokens
  Research (web + files):  ~800K tokens
  ─────────────────────────────────────
  TOTAL INPUT:             ~955K tokens

PROCESSING (Analysis):
  Layer 1-8 analysis:      ~800K tokens
  Synthesis frameworks:    ~300K tokens
  KB generation:           ~150K tokens
  ─────────────────────────────────────
  TOTAL PROCESSING:        ~1,250K tokens

OUTPUT (System Prompts):
  Prompt creation:         ~200K tokens
  Validation tests:        ~150K tokens
  Documentation:           ~50K tokens
  ─────────────────────────────────────
  TOTAL OUTPUT:            ~400K tokens

──────────────────────────────────────
TOTAL ESTIMADO:            ~2,605K tokens

Estado Projetado:
  Atual:  30K tokens (15%)
  Após:   2,635K tokens (131% - ESTOURO!)
  Livre:  -635K tokens

Status: 🚨 RISCO DE ESTOURO

OPÇÕES:
1. ❌ Continuar nesta janela (BLOQUEADO - estouro garantido)

2. ✅ Task/Subagent (contexto isolado) [RECOMENDADO]
   • Executa pipeline em contexto separado
   • Retorna apenas resumo + system prompt (~80K tokens)
   • Redução: 97% de economia de contexto

3. ✅ Prompt para nova janela
   • Zero impacto no contexto atual
   • Prompt completo com todas instruções

4. Modo Preview (viabilidade only)
   • Executa apenas viability assessment
   • ~50K tokens, 30 minutos
   • Decide se vale prosseguir com pipeline completo
   • Após GO: pode escolher opção 2 ou 3 para full pipeline

Recomendação: Opção 4 (preview) seguido de Opção 2 (subagent)

Sua escolha (2/3/4)?
```

## Enforcement

This rule is **MANDATORY** for:
- All expansion pack agents (mind-mapper, course-architect, psychologist, etc.)
- All multi-step workflows
- All operations marked `user-confirmation-required: true`

Agents that skip token estimation without valid reason will be considered non-compliant with AIOS-FULLSTACK standards.

---

**NOTE:** This guide should be referenced by expansion pack agents when implementing token estimation. The main CLAUDE.md now includes only a brief reference to this guide to reduce initialization overhead.
