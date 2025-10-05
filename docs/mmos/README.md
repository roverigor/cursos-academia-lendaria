# 🧬 MMOS - Mind Mapper OS v3.0 (AIOS-first)

> **Pipeline industrial para mapeamento e emulação de arquiteturas cognitivas de gênios em IA**
>
> *Mind Mapper Operating System - Sistema que extrai e mapeia padrões cognitivos únicos para replicação em LLMs*

## 📋 Convenções de Nomenclatura Oficial

**PADRÃO OBRIGATÓRIO: UNDERSCORES (`_`)**

- arquivos/pastas: `personality_profile.json`, `system_prompts/`
- timestamps: `YYYYMMDD-HHMM`
- versionamento: `v1.0`, `v2.5`

## 🎯 Visão Geral

Sistema completo e estruturado para capturar e replicar padrões cognitivos, comportamentais e comunicacionais de indivíduos específicos em LLMs.

## 🏗️ Estrutura Atual (AIOS-first)

```
mmos/
├── README.md                   # Visão geral AIOS-first (este arquivo)
├── prompts.yaml                # Catálogo único de prompts (metadados)
├── prompts/                    # Todos os prompts do pipeline (flat)
│   ├── viability_*.md
│   ├── research_*.md
│   ├── analysis_*.md
│   ├── synthesis_*.md
│   ├── implementation_*.md
│   └── testing_*.md
├── docs/
│   ├── OUTPUTS_GUIDE.md        # Guia detalhado de outputs por etapa
│   ├── BROWNFIELD_WORKFLOW.md
│   ├── PARALLEL_COLLECTION_GUIDE.md
│   ├── PRD.md                  # Product Requirements Document
│   ├── DNA_MENTAL_METHODOLOGY.md
│   ├── PROMPT_ENGINEERING_GUIDE.md
│   ├── TOOLS_GUIDE.md
│   └── stage-guides/           # Guias específicos por estágio
│       ├── viability.md
│       ├── research.md
│       │   ├── examples.md
│       │   ├── quickstart.md
│       │   └── workflow.md
│       └── analysis.md
├── templates/                  # Templates organizados por estágio
│   ├── viability/
│   ├── research/
│   ├── analysis/
│   ├── synthesis/
│   ├── implementation/
│   └── testing/
├── logs/                       # Logs operacionais (launcher, board, etc.)
├── scripts/
│   ├── aios-launcher.sh        # Script AIOS-first (Story 1.1)
│   ├── board-generator.sh      # Futuro board/telemetria
│   ├── brownfield-assistant.sh # Futuro assistente incremental
│   └── universal/              # Utilitários existentes
└── orchestration/
    ├── INDEX.md                # Visão integrada do pipeline AIOS-first
    ├── workflow.md
    ├── checkpoints.md
    └── execution_guide.md
```

**➤ prompts.yaml** é a fonte de verdade. Toda automação AIOS-first (launcher, board, etc.) consome este catálogo para saber:
- fase, ordem, dependências e paralelização
- agente AIOS responsável
- outputs esperados e caminhos padrão

## 🔄 Pipeline (visão metadados)

Sequenciamento e paralelização são definidos via `prompts.yaml`. Exemplo de entrada:

```yaml
- id: viability_scorecard_apex
  file: prompts/viability_scorecard_apex.md
  phase: viability
  agent: analyst
  order: 1
  parallelizable: false
  outputs:
    - path: "minds/{mind}/docs/logs/{timestamp}-viability.yaml"
      description: "Avaliação APEX completa"
  depends_on: []
```

## 🤖 Execução AIOS-first

1. **Launcher (`scripts/aios-launcher.sh`)** lê o catálogo, resolve o próximo prompt elegível, injeta contexto (PRD, logs, fontes) e sugere destino de output.
2. **Agentes AIOS** executam/parceiros a tarefa conforme designado (PM, Analyst, Architect, QA, Dev…).
3. **Board/telemetria** consolida progresso e métricas a partir dos mesmo metadados + logs gerados.
4. **Checkpoints humanos** permanecem obrigatórios (ver `docs/orchestration/checkpoints.md`).

## 📚 Documentação

- **Guides globais**: `docs/` (outputs, workflow brownfield, metodologia, tools…)
- **Guias por estágio**: `docs/stage-guides/`
- **Templates**: `templates/<fase>/`

## ✅ Convenções e Anti-padrões

- prompt files: sempre em `prompts/` com prefixo `fase_nome.md`
- qualquer novo prompt **precisa** ser registrado em `prompts.yaml`
- não criar subpastas adicionais sem refletir no catálogo
- manter `templates/` flat por fase; nada em `docs/mmos/` deve referenciar pastas antigas (`1_viability`, etc.)

## 🚀 Próximos Passos (Stories v1.5)

1. **Story 1.1** – Implementar `aios-launcher.sh` usando `prompts.yaml`
2. **Story 1.2** – Board de orquestração com telemetria
3. **Story 1.3** – Assistente brownfield incremental
4. **Story 1.4** – Engine de notas/handoffs entre agentes

Todos os scripts/automação devem usar `prompts.yaml` como a única fonte de metadados para prompts.

---
Última atualização: 05/10/2025 (AIOS-first migration)
