# 🔧 WORKFLOW COM AIOS-FULLSTACK (AIOS-first)

## 📋 Visão Geral

Este documento descreve **como executar o pipeline MMOS** usando o catálogo `prompts.yaml`, o launcher AIOS e os agentes especializados.

### ⚠️ Importante: AIOS-first

- **Metadados centralizados:** `docs/mmos/prompts.yaml` define ordem, dependências, agente e outputs.
- **Launcher:** `docs/mmos/scripts/aios-launcher.sh` gera briefing, injeta contexto e registra logs.
- **Execução híbrida:** agentes permanecem conversacionais, mas são acionados com briefing padronizado.
- **Checkpoints humanos** continuam obrigatórios ao final de cada fase.

---

## 🎯 Agentes AIOS Disponíveis

### Meta Agentes
- **aios-orchestrator**: Coordenador mestre de workflows
- **aios-master**: Agente universal (todas as capacidades)

### Agentes Especializados
- **analyst**: Pesquisa, análise e mapeamento de dados
- **pm**: Product Management (PRDs, roadmaps)
- **architect**: Arquitetura de sistemas e estruturas complexas
- **dev**: Implementação e desenvolvimento
- **qa**: Quality assurance e validação
- **po**: Product Owner (backlog, épicos)
- **ux-expert**: Design de experiência

---

## 📊 Mapeamento: Clone System → Agentes AIOS

### ETAPA 1: VIABILITY

**Prompts (IDs):** `viability_*`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| Avaliação SCORECARD APEX | Analyst | "Avalie viabilidade de [NOME] seguindo SCORECARD APEX" |
| Criação de PRD | PM | "Crie PRD baseado neste scorecard: [dados]" |
| Mapeamento de influências | Architect | "Mapeie influências intelectuais de [NOME]" |
| Roadmap inicial (TODO.md) | PM/PO | "Gere roadmap do projeto de clone" |

**Outputs:**
- `minds/[nome]/docs/logs/YYYYMMDD-HHMM-viability.yaml`
- `minds/[nome]/docs/PRD.md`
- `minds/[nome]/metadata/dependencies.yaml`
- `minds/[nome]/docs/TODO.md`

**✅ Checkpoint #1:** Aprovar viabilidade (score ≥ 35) e prosseguir

---

### ETAPA 2: RESEARCH

**Prompts (IDs):** `research_*`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| Descoberta de fontes | Analyst | "Liste fontes primárias de [NOME]: livros, palestras, entrevistas" |
| Coleta e organização | Analyst | "Organize fontes em sources/[tipo]/ - apenas material PRIMÁRIO" |
| Mapeamento temporal | Analyst | "Mapeie timeline: fases da carreira e evolução do pensamento" |
| Priorização (ROI) | Analyst | "Calcule ROI das fontes: relevância, profundidade, unicidade" |
| Inventário mestre | Analyst | "Consolide em sources_master.yaml com metadados completos" |

**Outputs:**
- `minds/[nome]/sources/*/` (books, interviews, speeches, etc.)
- `minds/[nome]/metadata/temporal_context.yaml`
- `minds/[nome]/metadata/priority_matrix.yaml`
- `minds/[nome]/sources/sources_master.yaml`

**✅ Checkpoint #2:** Validar suficiência (mínimo 5 fontes primárias de qualidade)

---

### ETAPA 3: ANALYSIS (DNA Mental™ 8 Camadas)

**Prompts (IDs):** `analysis_*` (ordem/níveis em `prompts.yaml`)

#### Estrutura de Paralelização

**Níveis executados em ordem, prompts dentro do nível podem ser consultados em paralelo:**

**NÍVEL 1: Extração Base** (3 prompts paralelos)
- Source Reading, Quote Extraction, Timeline Mapping
- **Agente:** Analyst

**NÍVEL 2: Camadas 1-2 DNA Mental** (4 prompts paralelos)
- Recognition Patterns, Linguistic Forensics, Behavioral Patterns, Rotine
- **Agente:** Analyst

**NÍVEL 3: Camadas 3-5 DNA Mental** (5 prompts paralelos)
- Mental Models, Values Hierarchy, Belief System, Decision Architecture, Immune System
- **Agentes:** Analyst + Architect

**NÍVEL 4: Camada 6 DNA Mental** (1 prompt sequencial)
- Core Obsessions (aguardar Nível 3)
- **Agente:** Analyst

**NÍVEL 5: Camada 7 DNA Mental** (2 prompts paralelos)
- Unique Algorithm, Contradictions Map
- **Agentes:** Architect + Analyst

**NÍVEL 6: Camada 8 DNA Mental** (3 prompts sequenciais)
- Cognitive Architecture, Psychometric Analysis, Limitations Doc
- **Agentes:** Architect + Analyst

**Outputs chave:**
- `minds/[nome]/artifacts/cognitive_architecture.yaml` (síntese de 3000+ palavras)
- `minds/[nome]/artifacts/personality_profile.json` (análise de 5000+ palavras)
- `minds/[nome]/artifacts/recognition_patterns.yaml`
- `minds/[nome]/artifacts/core_obsessions.yaml`
- `minds/[nome]/artifacts/unique_algorithm.py`
- `minds/[nome]/docs/LIMITATIONS.md`

**✅ Checkpoint #3:** Validar se essência cognitiva foi capturada

---

### ETAPA 4: SYNTHESIS

**Prompts (IDs):** `synthesis_*`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| Templates de comunicação | Analyst | "Extraia templates de como [NOME] comunica ideias" |
| Frases signature | Analyst | "Identifique frases, metáforas e conceitos únicos" |
| Knowledge base (chunks) | Analyst/Dev | "Organize conhecimento em chunks de 500-1000 palavras" |
| Frameworks e metodologias | Architect | "Extraia frameworks e processos criados por [NOME]" |

**Outputs:**
- `minds/[nome]/artifacts/communication_templates.md`
- `minds/[nome]/artifacts/signature_phrases.md`
- `minds/[nome]/kb/chunk_001.md` até `chunk_NNN.md` (FLAT)
- `minds/[nome]/artifacts/frameworks.yaml`

**✅ Checkpoint #4:** Validar completude do knowledge base

---

### ETAPA 5: IMPLEMENTATION

**Prompts (IDs):** `implementation_*`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| System Prompt Generalista | Architect/PM | "Compile system prompt usando todos os artifacts/" |
| Specialists (opcional) | Architect | "Crie clones especializados para [área específica]" |
| Config e metadados | Dev | "Configure config.yaml com parâmetros do clone" |
| Manual operacional | PM | "Documente como usar o clone em docs/operational_manual.md" |

**Outputs:**
- `minds/[nome]/system_prompts/YYYYMMDD-HHMM-v1.0-generalista-initial.md`
- `minds/[nome]/system_prompts/config.yaml`
- `minds/[nome]/specialists/*/system_prompts/` (se aplicável)
- `minds/[nome]/docs/operational_manual.md`

**✅ Checkpoint #5:** Revisar system prompt e aprovar para testes

---

### ETAPA 6: TESTING

**Prompts (IDs):** `testing_*`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| Protocolo de validação | QA | "Defina testes de personalidade, conhecimento e consistência" |
| Execução de testes | QA | "Execute bateria completa de testes" |
| Análise de resultados | QA/Analyst | "Analise gaps e inconsistências encontradas" |
| Refinamento iterativo | PM/Architect | "Priorize ajustes baseados nos resultados" |
| Aprovação final | PM | "Documente versão 1.0 como production-ready" |

**Outputs:**
- `minds/[nome]/docs/logs/YYYYMMDD-HHMM-test-results.yaml`
- `minds/[nome]/docs/logs/YYYYMMDD-HHMM-refinement-plan.md`
- Mind aprovado para produção ✅

**✅ Checkpoint #6:** Aprovar clone como production-ready (80%+ consistência)

---

## 🎓 Metodologia DNA Mental™ (Referência)

**8 Camadas de Análise Cognitiva:**

1. **Inputs Sensoriais** - Como percebe o mundo
2. **Recognition Patterns** - Radares mentais (o que detecta)
3. **Mental Models** - Frameworks de interpretação
4. **Belief System** - Crenças e valores fundamentais
5. **Decision Architecture** - Como toma decisões
6. **Core Obsessions** - 2-3 motores primários
7. **Unique Algorithm** - Algoritmo cognitivo singular
8. **Integrative Synthesis** - Síntese completa

**Referência completa:** `docs/mmos/README.md`

---

## 💡 Como Usar AIOS na Prática

### Exemplo AIOS-first: minds/naval_ravikant

1. **Briefing automátic**o:
   ```bash
   cd docs/mmos
   ./scripts/aios-launcher.sh --prompt viability_scorecard_apex --mind naval_ravikant
   ```
   - O launcher mostra dependências, outputs alvo, agente e salva log em `docs/mmos/logs/`.

2. **Execução com o agente**:
   - Copie o briefing exibido e acione `#analyst` com esse contexto.
   - Salve o output no caminho recomendado (por exemplo, `minds/naval_ravikant/docs/logs/<timestamp>-viability.yaml`).

3. **Próximos prompts**:
   - Continue chamando o launcher com os IDs seguintes (`viability_icp_match_score`, `viability_prd_generator` etc.).
   - Siga as dependências (`depends_on`) exibidas; após cada fase, realize o checkpoint humano.

---

## 🚫 O Que AIOS NÃO Faz

❌ Executar comandos automatizados via CLI
❌ Rodar DAG engines com workflows YAML
❌ Processar arquivos automaticamente
❌ Gerar outputs sem interação humana
❌ Medir métricas e tempos automaticamente

---

## ✅ O Que AIOS Faz

✅ Fornecer expertise especializada via agentes
✅ Orientar na estruturação de documentos
✅ Validar qualidade e consistência
✅ Sugerir melhorias e alternativas
✅ Aplicar metodologia Agile AI ao processo

---

## 📚 Referências

- **docs/mmos/README.md** - Visão AIOS-first e estrutura do pipeline
- **docs/mmos/prompts.yaml** - Catálogo oficial de prompts
- **scripts/aios-launcher.sh** - Briefing automático + logging
- **docs/guides/outputs-guide.md** - Especificação de outputs por etapa
- **aios-fullstack/README.md** - Framework AIOS
- **aios-fullstack/aios-core/user-guide.md** - Guia de uso dos agentes
- **docs/guides/outputs-guide.md** - Especificação de outputs

---

**Última atualização:** 04/10/2025
**Versão:** 2.0 (Metodologia Conversacional)
