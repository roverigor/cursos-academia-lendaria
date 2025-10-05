# 🔧 WORKFLOW COM AIOS-FULLSTACK

## 📋 Visão Geral

Este documento mapeia **como usar agentes AIOS como assistentes consultivos** durante a execução do clone_system.

### ⚠️ Importante: AIOS é Metodologia Conversacional

- **NÃO é:** Automação via CLI com comandos executáveis
- **É:** Framework de agentes especializados para assistência via chat
- **Uso:** Conversar com agentes para obter orientação, templates e validação
- **Execução:** Permanece manual com checkpoints humanos

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

**Prompts:** `clone_system/1_viability/prompts/`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| Avaliação SCORECARD APEX | Analyst | "Avalie viabilidade de [NOME] seguindo SCORECARD APEX" |
| Criação de PRD | PM | "Crie PRD baseado neste scorecard: [dados]" |
| Mapeamento de influências | Architect | "Mapeie influências intelectuais de [NOME]" |
| Roadmap inicial (TODO.md) | PM/PO | "Gere roadmap do projeto de clone" |

**Outputs:**
- `clones/[nome]/docs/logs/YYYYMMDD-HHMM-viability.yaml`
- `clones/[nome]/docs/PRD.md`
- `clones/[nome]/metadata/dependencies.yaml`
- `clones/[nome]/docs/TODO.md`

**✅ Checkpoint #1:** Aprovar viabilidade (score ≥ 35) e prosseguir

---

### ETAPA 2: RESEARCH

**Prompts:** `clone_system/2_research/prompts/`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| Descoberta de fontes | Analyst | "Liste fontes primárias de [NOME]: livros, palestras, entrevistas" |
| Coleta e organização | Analyst | "Organize fontes em sources/[tipo]/ - apenas material PRIMÁRIO" |
| Mapeamento temporal | Analyst | "Mapeie timeline: fases da carreira e evolução do pensamento" |
| Priorização (ROI) | Analyst | "Calcule ROI das fontes: relevância, profundidade, unicidade" |
| Inventário mestre | Analyst | "Consolide em sources_master.yaml com metadados completos" |

**Outputs:**
- `clones/[nome]/sources/*/` (books, interviews, speeches, etc.)
- `clones/[nome]/metadata/temporal_context.yaml`
- `clones/[nome]/metadata/priority_matrix.yaml`
- `clones/[nome]/sources/sources_master.yaml`

**✅ Checkpoint #2:** Validar suficiência (mínimo 5 fontes primárias de qualidade)

---

### ETAPA 3: ANALYSIS (DNA Mental™ 8 Camadas)

**Prompts:** `clone_system/3_analysis/prompts/` - Organizados em 6 níveis

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
- `clones/[nome]/artifacts/cognitive_architecture.yaml` (síntese de 3000+ palavras)
- `clones/[nome]/artifacts/personality_profile.json` (análise de 5000+ palavras)
- `clones/[nome]/artifacts/recognition_patterns.yaml`
- `clones/[nome]/artifacts/core_obsessions.yaml`
- `clones/[nome]/artifacts/unique_algorithm.py`
- `clones/[nome]/docs/LIMITATIONS.md`

**✅ Checkpoint #3:** Validar se essência cognitiva foi capturada

---

### ETAPA 4: SYNTHESIS

**Prompts:** `clone_system/4_synthesis/prompts/`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| Templates de comunicação | Analyst | "Extraia templates de como [NOME] comunica ideias" |
| Frases signature | Analyst | "Identifique frases, metáforas e conceitos únicos" |
| Knowledge base (chunks) | Analyst/Dev | "Organize conhecimento em chunks de 500-1000 palavras" |
| Frameworks e metodologias | Architect | "Extraia frameworks e processos criados por [NOME]" |

**Outputs:**
- `clones/[nome]/artifacts/communication_templates.md`
- `clones/[nome]/artifacts/signature_phrases.md`
- `clones/[nome]/kb/chunk_001.md` até `chunk_NNN.md` (FLAT)
- `clones/[nome]/artifacts/frameworks.yaml`

**✅ Checkpoint #4:** Validar completude do knowledge base

---

### ETAPA 5: IMPLEMENTATION

**Prompts:** `clone_system/5_implementation/prompts/`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| System Prompt Generalista | Architect/PM | "Compile system prompt usando todos os artifacts/" |
| Specialists (opcional) | Architect | "Crie clones especializados para [área específica]" |
| Config e metadados | Dev | "Configure config.yaml com parâmetros do clone" |
| Manual operacional | PM | "Documente como usar o clone em docs/operational_manual.md" |

**Outputs:**
- `clones/[nome]/system_prompts/YYYYMMDD-HHMM-v1.0-generalista-initial.md`
- `clones/[nome]/system_prompts/config.yaml`
- `clones/[nome]/specialists/*/system_prompts/` (se aplicável)
- `clones/[nome]/docs/operational_manual.md`

**✅ Checkpoint #5:** Revisar system prompt e aprovar para testes

---

### ETAPA 6: TESTING

**Prompts:** `clone_system/6_testing/prompts/`

| Tarefa | Agente | Como Consultar |
|--------|--------|----------------|
| Protocolo de validação | QA | "Defina testes de personalidade, conhecimento e consistência" |
| Execução de testes | QA | "Execute bateria completa de testes" |
| Análise de resultados | QA/Analyst | "Analise gaps e inconsistências encontradas" |
| Refinamento iterativo | PM/Architect | "Priorize ajustes baseados nos resultados" |
| Aprovação final | PM | "Documente versão 1.0 como production-ready" |

**Outputs:**
- `clones/[nome]/docs/logs/YYYYMMDD-HHMM-test-results.yaml`
- `clones/[nome]/docs/logs/YYYYMMDD-HHMM-refinement-plan.md`
- Clone aprovado para produção ✅

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

**Referência completa:** `clone_system/README.md`

---

## 💡 Como Usar AIOS na Prática

### Exemplo: Criar Clone de Naval Ravikant

**1. Iniciar conversa com Analyst:**
```
Você: "Preciso avaliar a viabilidade de criar um clone mental de Naval Ravikant.
      Siga o SCORECARD APEX em clone_system/1_viability/prompts/01_scorecard_apex.md"

Analyst: [Fornece análise estruturada com scores]

Você: [Copia resultado para clones/naval_ravikant/docs/logs/20251004-1900-viability.yaml]
```

**2. Consultar PM para PRD:**
```
Você: "Baseado neste scorecard [colar], crie PRD completo seguindo template
      em 02_prd_generator.md. Clone será usado como mentor de startups."

PM: [Fornece PRD estruturado]

Você: [Salva em clones/naval_ravikant/docs/PRD.md]
```

**3. E assim por diante...**
- Cada prompt do clone_system → conversa com agente apropriado
- Agente fornece output → você valida e salva no local correto
- Checkpoints humanos garantem qualidade em cada etapa

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

- **clone_system/README.md** - Pipeline completo de 47 prompts
- **aios-fullstack/README.md** - Framework AIOS
- **aios-fullstack/aios-core/user-guide.md** - Guia de uso dos agentes
- **clone_system/docs/OUTPUTS_GUIDE.md** - Especificação de outputs

---

**Última atualização:** 04/10/2025
**Versão:** 2.0 (Metodologia Conversacional)
