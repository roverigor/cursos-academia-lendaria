# 🎯 Proposta de Reorganização

## Estrutura AFTER (Proposta)

```
mente_lendaria/
│
├── docs/                          ← DOCUMENTAÇÃO SOURCE
│   ├── README.md                    📄 Índice master de docs
│   ├── architecture/                🏗️ Arquitetura geral
│   │   ├── system-overview.md
│   │   ├── expansion-packs.md
│   │   ├── data-flow.md
│   │   └── brownfield-analysis.md  (mover de raiz)
│   ├── guides/                      📚 User & dev guides
│   │   ├── getting-started.md
│   │   ├── developer-guide.md
│   │   └── contributor-guide.md
│   ├── prd/                         📋 Product requirements
│   │   ├── mmos-prd.md           (extrair de docs/mmos/docs/)
│   │   ├── creator-os-prd.md
│   │   └── innerlens-prd.md
│   ├── methodology/                 🧠 Metodologias
│   │   ├── dna-mental.md         (extrair de docs/mmos/docs/)
│   │   ├── prompt-engineering.md (extrair de docs/mmos/docs/)
│   │   └── cognitive-mapping.md
│   ├── stories/                     📖 Development stories
│   │   ├── epic-1-aios-core.md
│   │   ├── story-1.1-launcher.md
│   │   └── ... (stories gerais AIOS)
│   └── mmos/                        🧬 MMOS System Docs
│       ├── README.md                  Índice MMOS
│       ├── architecture/              System architecture
│       ├── database/                  DB schema & migrations
│       ├── design/                    Design decisions
│       ├── epics/                     MMOS-specific epics
│       ├── reports/                   Executive reports
│       ├── taxonomy/                  Classification systems
│       ├── validations/               Validation checklists
│       ├── qa/                        Quality benchmarks
│       └── workflows/                 MMOS workflows
│           ├── aios-workflow.md
│           ├── brownfield-workflow.md
│           ├── parallel-collection.md
│           └── private-individual.md
│
├── outputs/                       ← ARTEFATOS GERADOS
│   ├── README.md
│   ├── courses/                     📚 Cursos gerados (CreatorOS)
│   ├── minds/                       🧠 Minds processados (MMOS)
│   ├── debates/                     💬 Debates gerados
│   ├── swipe/                       📱 Swipe copy
│   ├── database/                    🗄️ Databases gerados
│   │   └── SQLite legado (migrado para Supabase em 2025-10)               (mover de docs/mmos/)
│   └── logs/                        📊 Logs de execução
│       └── mmos/                  (mover de docs/mmos/logs/)
│
├── expansion-packs/               ← EXPANSION PACKS
│   ├── creator-os/
│   ├── mmos/
│   ├── etl-data-collector/
│   └── innerlens/
│
├── .aios-core/                    ← AIOS FRAMEWORK
│   ├── agents/
│   ├── tasks/
│   ├── workflows/
│   ├── templates/
│   ├── checklists/
│   └── utils/
│
├── scripts/                       ← OPERATIONAL SCRIPTS
│   ├── database/
│   ├── pipeline/
│   └── migration/
│
└── README.md                      ← Project README
```

---
