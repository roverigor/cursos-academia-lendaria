# 1. Goals and Background Context

* **Goals:**
    * Industrializar o **MMOS (Mind Mapper OS)** - pipeline de ponta-a-ponta para mapeamento e emulação de arquiteturas cognitivas de gênios em IA
    * Reduzir tempo de criação de mind de semanas para 3-5 dias através de orquestração AIOS-first e paralelização assistida
    * Implementar **Document-Centric Workflow** com templates reutilizáveis (MIND_BRIEF.md, COGNITIVE_SPEC.md)
    * Garantir consistência e qualidade através de **Human Checkpoints**, telemetria e Notes System (agent-to-agent communication)
    * Suportar tanto **Greenfield** (mind novo) quanto **Brownfield** (atualização incremental) sem reprocessar pipeline completo
    * Criar fundação escalável para crescer biblioteca de 22+ para 100+ minds e habilitar integração futura com galeria pública

* **Background Context:**
    O Lendário.ai possui MMOS (Mind Mapper OS) - sistema validado de "arqueologia cognitiva" composto por **47 prompts especializados** organizados em 6 etapas (Viability, Research, Analysis, Synthesis, Implementation, Testing). Utiliza **DNA Mental™** (8 layers) alcançando 94% de precisão vs. 30% de LLMs tradicionais. Sistema inclui **dupla avaliação** (APEX + ICP Score) para rejeitar automaticamente minds inviáveis, economizando 40% de tokens.

    Historicamente, o pipeline foi executado de forma manual: operadores humanos consultavam os agentes AIOS de modo ad-hoc, copiavam prompts e registravam saídas manualmente nos diretórios ACS. Essa abordagem confirmou a metodologia, mas criou gargalos de ativação, paralelização limitada (~20%), pouca rastreabilidade e um backlog crescente de atualizações brownfield (825 linhas de TODO dentro dos 22 minds atuais).

    **Mudança crítica (v1.5):** O pipeline deixa de depender de execução manual dispersa e passa a operar em modo **AIOS-first**, onde os agentes coordenam cada prompt com contexto automatizado, telemetria e colaboração estruturada. O framework permanece conversacional, mas agora serve como camada de orquestração oficial.

    Estrutura atual: `mmos/` (pipeline), `minds/` (22 minds produção), nomenclatura underscore obrigatória, documentação completa em `docs/mmos/**` e logs consolidados em `docs/mmos/logs/`.
