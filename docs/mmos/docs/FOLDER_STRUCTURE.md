# ESTRUTURA DE PASTAS - ACS V3.0

**Versão:** 3.0
**Data:** 29/09/2025
**Status:** ✅ OFICIAL

---

## FILOSOFIA

Estrutura **minimalista e funcional** com 5-6 pastas máximo:
- **Simples de navegar** - Poucos lugares para procurar
- **Clara separação** - O que é fonte vs processo vs produto
- **Fácil de usar** - kb/ tem tudo que sobe (drag & drop)
- **FLAT sempre** - Sem subpastas em artifacts/ e kb/
- **Semântica preservada** - sources/ é corpus cognitivo, não apenas backup

---

## ESTRUTURA COMPLETA

```
minds/{mind_name}/
├── sources/              # Biblioteca semântica da mente (fontes primárias)
├── artifacts/            # Artefatos do processo (FLAT)
├── docs/
│   ├── logs/            # Relatórios timestamped
│   └── README.md        # Documentação do mind
├── kb/                  # Knowledge Base (upload) FLAT
├── system_prompts/      # Prompts gerados finais
└── specialists/         # [OPCIONAL] Versões especializadas
```

---

## PASTA: `sources/`

### PROPÓSITO
**Biblioteca semântica da mente** - Fontes primárias que capturam como a pessoa pensa, fala, decide e age. Não é apenas backup, é o **corpus completo da expressão cognitiva** do clone alvo.

### CONTEÚDO
**Tudo que captura a expressão autêntica da mente:**

✅ **Livros autorais** - Pensamento estruturado e profundo
✅ **Artigos e essays** - Posicionamentos e reflexões
✅ **Transcrições de vídeos** - Linguagem e energia natural
✅ **Transcrições de podcasts** - Pensamento em conversação
✅ **Entrevistas** - Respostas espontâneas e padrões
✅ **Posts de blog/social media** - Voz autêntica não editada
✅ **Threads de Twitter/X** - Micro-pensamentos e obsessões
✅ **E-mails e cartas** - Comunicação real e privada
✅ **Transcrições de palestras** - Performance e persuasão
✅ **Diários e notas** - Pensamento íntimo e verdadeiro
✅ **Código-fonte (se dev)** - Padrões de resolução de problemas
✅ **Decisões documentadas** - Como escolhe e por quê
✅ **Qualquer artefato** que revele padrões cognitivos autênticos

**Critério de inclusão:** Captura como a pessoa **realmente** pensa, não como outros falam sobre ela.

### ORGANIZAÇÃO
```
sources/
├── books/
│   ├── Livro_1.pdf
│   ├── Livro_2.epub
│   └── Livro_3.pdf
├── articles/
│   ├── Artigo_A.pdf
│   ├── Artigo_B.md
│   └── Artigo_C.pdf
├── videos/
│   ├── Video_1_transcript.txt
│   ├── Video_2_transcript.txt
│   └── Video_3_transcript.txt
├── podcasts/
│   ├── Podcast_Ep1_transcript.txt
│   └── Podcast_Ep2_transcript.txt
└── interviews/
    ├── Interview_2020.txt
    └── Interview_2023.txt
```

### REGRAS
- ✅ Pode ter subpastas para organização
- ✅ Mantém arquivos originais intocados
- ✅ **Fontes PRIMÁRIAS** - Da própria pessoa, não sobre ela
- ✅ **Corpus semântico** - Captura expressão cognitiva autêntica
- ❌ Não processar aqui (apenas armazenar e preservar)
- ❌ Não incluir biografias escritas por terceiros (a menos que com quotes diretas extensas)
- ❌ Não incluir análises ou comentários sobre a pessoa

---

## PASTA: `artifacts/`

### PROPÓSITO
**Artefatos intermediários** do processo de extração de DNA - tudo interno.

### CONTEÚDO
✅ Outputs das 6 etapas do MMOS pipeline
✅ Arquivos YAML de análise
✅ Arquivos MD de síntese
✅ Metadados de processo
✅ Análises intermediárias
✅ Templates em desenvolvimento
✅ Frameworks extraídos
✅ Tudo que **não** sube para o mind

### ORGANIZAÇÃO
**FLAT** - Todos os arquivos na raiz (sem subpastas):

```
artifacts/
├── viability_assessment.yaml
├── icp_score.yaml
├── quotes.md
├── timeline.md
├── source_annotations.md
├── behavioral_patterns.md
├── recognition_patterns.yaml
├── linguistic_profile.md
├── values_hierarchy.yaml
├── belief_system.yaml
├── decision_patterns.yaml
├── mental_models.md
├── immune_system.md
├── core_obsessions.yaml
├── contradictions.yaml
├── unique_algorithm.yaml
├── cognitive_architecture.yaml
├── personality_profile.json
├── limitations.md
├── frameworks_synthesized.md
├── templates_extracted.md
├── patterns_synthesized.md
├── identity_core.yaml
└── [outros artefatos de processo]
```

### CONVENÇÃO DE NOMES
```
<etapa>_<output_name>.<ext>

Exemplos:
- viability_assessment.yaml
- quotes.md
- behavioral_patterns.md
- cognitive_architecture.yaml
- identity_core.yaml
```

### REGRAS
- ✅ SEMPRE FLAT (sem subpastas)
- ✅ Nomes descritivos em snake_case
- ✅ Extensões apropriadas (.yaml, .md, .json)
- ❌ Não colocar aqui outputs finais (vão para kb/)
- ❌ Não colocar logs (vão para docs/logs/)

---

## PASTA: `docs/`

### PROPÓSITO
Documentação do clone e relatórios de processo.

### ESTRUTURA
```
docs/
├── logs/                           # Relatórios timestamped
│   ├── 20250928-2220-ANALISE_X.md
│   ├── 20250929-2306-CRITICA_Y.md
│   └── 20250929-2328-REORG_Z.md
├── README.md                       # Documentação principal do clone
├── CHANGELOG.md                    # Histórico de versões
└── INSTRUCTIONS.md                 # Instruções específicas de uso
```

### CONTEÚDO

#### `logs/`
**Relatórios de execução** - O que aconteceu durante o processo:
- ✅ Análises estruturais
- ✅ Relatórios de conformidade
- ✅ Status de etapas
- ✅ Decisões tomadas
- ✅ Problemas encontrados
- ✅ Validações executadas

**Formato:** `YYYYMMDD-HHMM-NOME_DO_LOG.md`

**Exemplos:**
```
20250928-2218-ANALISE_ESTRUTURAL.md
20250928-2220-CONFORMIDADE_TOTAL.md
20250929-2306-ANALISE_CRITICA_ALINHAMENTO.md
20250929-2328-REORGANIZACAO_ETAPA3_COMPLETA.md
```

#### `README.md`
Documentação principal do clone:
- Nome e descrição
- Período de análise
- Fontes utilizadas
- Características principais
- Instruções de uso
- Limitações conhecidas

#### `CHANGELOG.md`
Histórico de versões:
- v1.0: Release inicial
- v1.1: Ajustes de tone
- v2.0: Adição de specialist X
- etc.

### REGRAS
- ✅ logs/ sempre com timestamp
- ✅ README.md obrigatório
- ✅ CHANGELOG.md recomendado
- ❌ Não colocar artefatos de processo aqui

---

## PASTA: `kb/`

### PROPÓSITO
**Knowledge Base** - Tudo que **sobe para o mind** (drag & drop).

### CONTEÚDO
✅ Análises cognitivas processadas
✅ Estruturas mentais formatadas
✅ Padrões comportamentais finais
✅ Frameworks sintetizados
✅ Análise linguística final
✅ Q&A datasets gerados
✅ Livros curados em formato Q&A
✅ Material de contexto essencial
✅ Exemplos de interações
✅ Tudo que o mind precisa SABER

### ORGANIZAÇÃO
**FLAT** - Todos os arquivos na raiz (sem subpastas):

```
kb/
├── cognitive_architecture_final.md
├── behavioral_patterns_final.md
├── mental_models_final.md
├── values_and_beliefs_final.md
├── linguistic_style_final.md
├── decision_framework_final.md
├── qa_dataset_general.md
├── qa_dataset_business.md
├── qa_dataset_personal.md
├── book_qa_livro1.md
├── examples_interactions.md
├── context_essential.md
└── [outros materiais para upload]
```

### CONVENÇÃO DE NOMES
```
<tipo>_<descrição>_final.<ext>

Exemplos:
- cognitive_architecture_final.md
- qa_dataset_general.md
- book_qa_steve_jobs.md
```

**Sufixo `_final`:** Indica que é versão processada para o clone (não artefato intermediário)

### REGRAS
- ✅ SEMPRE FLAT (sem subpastas)
- ✅ Fácil drag & drop para upload
- ✅ Apenas conteúdo final processado
- ✅ Formato otimizado para LLM (Markdown)
- ❌ Não colocar artefatos intermediários
- ❌ Não colocar logs ou metadados de processo
- ❌ Não colocar livros brutos completos (só se curados)

### CRITÉRIO DE INCLUSÃO
**Pergunta-chave:** "O mind precisa saber/usar isso para responder bem?"
- ✅ SIM → vai para kb/
- ❌ NÃO → fica em artifacts/ ou sources/

---

## PASTA: `system_prompts/`

### PROPÓSITO
**System prompts finais** gerados e prontos para uso.

### CONTEÚDO
✅ System prompt principal (versão completa)
✅ System prompt resumido (versão curta)
✅ Variações por contexto (se houver)
✅ Versões testadas e validadas

### ORGANIZAÇÃO
```
system_prompts/
├── main_prompt_v1.0.md
├── main_prompt_v1.1.md
├── main_prompt_v2.0.md           # Versão atual
├── short_prompt_v2.0.md          # Versão resumida
├── context_business_v2.0.md      # Variação para negócios
├── context_personal_v2.0.md      # Variação para uso pessoal
└── VERSIONS.md                   # Tracking de versões
```

### CONVENÇÃO DE NOMES
```
<tipo>_prompt_v<versão>.md

Exemplos:
- main_prompt_v2.0.md
- short_prompt_v2.0.md
- context_business_v2.0.md
```

### REGRAS
- ✅ Versionamento semântico (v1.0, v1.1, v2.0)
- ✅ Manter versões antigas para rollback
- ✅ VERSIONS.md documenta mudanças
- ✅ main_prompt = versão completa e oficial

---

## PASTA: `specialists/` [OPCIONAL]

### PROPÓSITO
**Versões especializadas** do clone para contextos específicos.

### CONTEÚDO
✅ Variações do clone otimizadas para domínios específicos
✅ Cada specialist = subpasta com estrutura própria

### ORGANIZAÇÃO
```
specialists/
├── business_coach/
│   ├── kb/
│   ├── system_prompts/
│   └── docs/
├── content_creator/
│   ├── kb/
│   ├── system_prompts/
│   └── docs/
└── strategic_advisor/
    ├── kb/
    ├── system_prompts/
    └── docs/
```

### REGRAS
- ✅ Cada specialist = subpasta isolada
- ✅ Replica estrutura mínima (kb/, system_prompts/, docs/)
- ✅ Pode compartilhar sources/ do clone principal
- ❌ Não duplicar artifacts/ (só gerar o necessário)

---

## FLUXO DE TRABALHO

### 1️⃣ SETUP INICIAL
```bash
mkdir minds/{mind_name}
cd minds/{mind_name}
mkdir sources artifacts kb system_prompts
mkdir -p docs/logs
```

### 2️⃣ COLETA DE FONTES (Biblioteca Semântica)
```
Colocar APENAS fontes primárias em sources/
- Livros autorais da pessoa
- Transcrições de vídeos/podcasts da pessoa
- Artigos escritos pela pessoa
- Entrevistas onde a pessoa fala
- Posts/threads da pessoa
- Qualquer artefato que capture a voz/mente autêntica

Organizar em subpastas (books/, articles/, videos/, etc.)

❌ NÃO incluir:
- Biografias de terceiros
- Análises sobre a pessoa
- Comentários de outros
- Materiais que não sejam da voz original
```

### 3️⃣ EXECUÇÃO DO MMOS PIPELINE

**Etapa 1: Viability**
```
Input:  sources/
Output: artifacts/viability_assessment.yaml
        artifacts/icp_score.yaml
```

**Etapa 2: Research**
```
Input:  sources/
Output: artifacts/quotes.md
        artifacts/timeline.md
        artifacts/source_annotations.md
```

**Etapa 3: Analysis**
```
Input:  artifacts/quotes.md, timeline.md, etc.
Output: artifacts/behavioral_patterns.md
        artifacts/recognition_patterns.yaml
        artifacts/values_hierarchy.yaml
        artifacts/mental_models.md
        artifacts/core_obsessions.yaml
        artifacts/unique_algorithm.yaml
        artifacts/cognitive_architecture.yaml
        artifacts/personality_profile.json
        artifacts/limitations.md
        [+ outros 10 arquivos]
```

**Etapa 4: Synthesis**
```
Input:  artifacts/* (todos os analysis)
Output: artifacts/frameworks_synthesized.md
        artifacts/templates_extracted.md
        artifacts/patterns_synthesized.md
        artifacts/identity_core.yaml
```

**Etapa 5: Implementation**
```
Input:  artifacts/* (todos os synthesis)
Output: system_prompts/main_prompt_v1.0.md
        kb/cognitive_architecture_final.md
        kb/behavioral_patterns_final.md
        kb/mental_models_final.md
        kb/qa_dataset_general.md
        [+ outros arquivos finais para kb/]
```

**Etapa 6: Testing**
```
Input:  system_prompts/*, kb/*
Output: docs/logs/YYYYMMDD-HHMM-TESTE_VALIDACAO.md
        system_prompts/main_prompt_v1.1.md (se ajustes)
```

### 4️⃣ DEPLOY
```
1. Subir kb/* para sistema de LLM
2. Usar system_prompts/main_prompt_v1.0.md como system prompt
3. Testar e iterar
```

---

## CONVENÇÕES GERAIS

### NOMES DE ARQUIVOS
- **snake_case** para todos os arquivos
- **Descritivos e específicos**
- **Sem espaços ou caracteres especiais**
- **Extensões apropriadas** (.md, .yaml, .json, .txt, .pdf)

**Exemplos bons:**
```
✅ cognitive_architecture.yaml
✅ behavioral_patterns_final.md
✅ qa_dataset_business.md
✅ main_prompt_v2.0.md
```

**Exemplos ruins:**
```
❌ Cognitive Architecture.yaml  (espaços)
❌ behavioral-patterns.md       (hífen)
❌ QA Dataset Business.md       (espaços + PascalCase)
❌ mainPromptV2.md              (camelCase)
```

### LOGS
**Formato obrigatório:** `YYYYMMDD-HHMM-NOME_DESCRITIVO.md`

**Exemplos:**
```
✅ 20250928-2218-ANALISE_ESTRUTURAL.md
✅ 20250929-2306-CRITICA_ALINHAMENTO.md
✅ 20250929-2328-REORGANIZACAO_ETAPA3.md
```

### VERSIONAMENTO
**System prompts:** `v<major>.<minor>`
- Major: Mudanças significativas (v1.0 → v2.0)
- Minor: Ajustes e refinamentos (v2.0 → v2.1)

**Exemplos:**
```
main_prompt_v1.0.md  → Release inicial
main_prompt_v1.1.md  → Ajuste de tone
main_prompt_v1.2.md  → Correção de bug
main_prompt_v2.0.md  → Reestruturação completa
```

---

## ANTI-PADRÕES (O QUE NÃO FAZER)

### ❌ Subpastas em artifacts/
```
❌ artifacts/
   ├── analysis/
   ├── synthesis/
   └── metadata/

✅ artifacts/
   ├── valores.yaml
   ├── padroes.md
   └── modelos.md
```

### ❌ Subpastas em kb/
```
❌ kb/
   ├── cognitive/
   ├── behavioral/
   └── datasets/

✅ kb/
   ├── cognitive_final.md
   ├── behavioral_final.md
   └── dataset_qa.md
```

### ❌ Arquivos de log fora de docs/logs/
```
❌ artifacts/LOG_ANALISE.md
❌ kb/STATUS_CLONE.md
❌ RELATORIO_CONFORMIDADE.md

✅ docs/logs/20250929-2306-ANALISE.md
✅ docs/logs/20250929-2328-STATUS.md
✅ docs/logs/20250928-2220-CONFORMIDADE.md
```

### ❌ Artefatos intermediários em kb/
```
❌ kb/raw_quotes.md
❌ kb/timeline.md
❌ kb/contradictions.yaml

✅ artifacts/quotes.md
✅ artifacts/timeline.md
✅ artifacts/contradictions.yaml

✅ kb/cognitive_architecture_final.md  (processado)
✅ kb/qa_dataset_general.md           (final)
```

### ❌ Misturar inglês e português em nomes
```
❌ cognitive_arquitetura.yaml
❌ padroes_behaviors.md
❌ mental_modelos.md

✅ cognitive_architecture.yaml
✅ behavioral_patterns.md
✅ mental_models.md
```

---

## CHECKLIST DE ESTRUTURA

### Setup Inicial
- [ ] Pasta sources/ criada
- [ ] Pasta artifacts/ criada
- [ ] Pasta docs/ criada
- [ ] Pasta docs/logs/ criada
- [ ] Pasta kb/ criada
- [ ] Pasta system_prompts/ criada
- [ ] docs/README.md criado

### Durante Processo
- [ ] Todas as fontes em sources/
- [ ] Artefatos intermediários em artifacts/ (FLAT)
- [ ] Logs em docs/logs/ (com timestamp)
- [ ] Nenhuma subpasta em artifacts/
- [ ] Nenhuma subpasta em kb/

### Pré-Deploy
- [ ] kb/ tem apenas arquivos finais
- [ ] system_prompts/ tem prompt versionado
- [ ] docs/README.md atualizado
- [ ] docs/logs/ documentou processo
- [ ] Estrutura validada (sem anti-padrões)

---

## EXEMPLOS PRÁTICOS

### Exemplo 1: Clone Steve Jobs

```
steve_jobs/
├── sources/
│   ├── books/
│   │   ├── Steve_Jobs_Biografia_Walter_Isaacson.pdf
│   │   ├── Becoming_Steve_Jobs.pdf
│   │   └── Inside_Apple.pdf
│   ├── interviews/
│   │   ├── Interview_AllThingsD_2007.txt
│   │   ├── Interview_WSJ_1993.txt
│   │   └── Stanford_Commencement_2005.txt
│   └── videos/
│       ├── iPhone_Launch_2007_transcript.txt
│       └── WWDC_Keynotes_transcript.txt
│
├── artifacts/
│   ├── viability_assessment.yaml
│   ├── icp_score.yaml
│   ├── quotes.md
│   ├── timeline.md
│   ├── behavioral_patterns.md
│   ├── recognition_patterns.yaml
│   ├── values_hierarchy.yaml
│   ├── mental_models.md
│   ├── core_obsessions.yaml
│   ├── contradictions.yaml
│   ├── unique_algorithm.yaml
│   ├── cognitive_architecture.yaml
│   └── personality_profile.json
│
├── docs/
│   ├── logs/
│   │   ├── 20250901-1430-VIABILITY_APPROVED.md
│   │   ├── 20250902-1020-RESEARCH_COMPLETE.md
│   │   ├── 20250903-1545-ANALYSIS_ETAPA3.md
│   │   └── 20250904-0930-SYNTHESIS_DONE.md
│   ├── README.md
│   └── CHANGELOG.md
│
├── kb/
│   ├── cognitive_architecture_final.md
│   ├── behavioral_patterns_final.md
│   ├── mental_models_final.md
│   ├── values_and_beliefs_final.md
│   ├── obsessions_and_drives_final.md
│   ├── decision_framework_final.md
│   ├── qa_dataset_product_design.md
│   ├── qa_dataset_leadership.md
│   ├── qa_dataset_innovation.md
│   ├── examples_keynotes.md
│   └── context_apple_history.md
│
├── system_prompts/
│   ├── main_prompt_v1.0.md
│   ├── main_prompt_v1.1.md
│   ├── main_prompt_v2.0.md
│   ├── short_prompt_v2.0.md
│   └── VERSIONS.md
│
└── specialists/
    ├── product_designer/
    │   ├── kb/
    │   ├── system_prompts/
    │   └── docs/
    └── startup_advisor/
        ├── kb/
        ├── system_prompts/
        └── docs/
```

### Exemplo 2: Clone Gary Vee

```
gary_vee/
├── sources/
│   ├── books/
│   │   ├── Crush_It.pdf
│   │   ├── Jab_Jab_Jab_Right_Hook.pdf
│   │   └── Twelve_And_A_Half.pdf
│   ├── podcasts/
│   │   ├── GaryVee_Audio_Experience_Ep001-100.txt
│   │   └── Marketing_For_The_Now_Episodes.txt
│   ├── videos/
│   │   ├── DailyVee_Best_Of.txt
│   │   └── Keynotes_2015-2024.txt
│   └── social_media/
│       ├── Twitter_Threads_Compilation.txt
│       └── LinkedIn_Posts_2020-2024.txt
│
├── artifacts/
│   ├── viability_assessment.yaml
│   ├── quotes.md
│   ├── timeline.md
│   ├── behavioral_patterns.md
│   ├── linguistic_profile.md
│   ├── values_hierarchy.yaml
│   ├── mental_models.md
│   ├── core_obsessions.yaml
│   └── [outros artefatos...]
│
├── docs/
│   ├── logs/
│   │   └── [logs timestamped...]
│   └── README.md
│
├── kb/
│   ├── cognitive_architecture_final.md
│   ├── behavioral_energy_final.md
│   ├── mental_models_final.md
│   ├── qa_dataset_entrepreneurship.md
│   ├── qa_dataset_social_media.md
│   ├── qa_dataset_marketing.md
│   └── examples_typical_responses.md
│
└── system_prompts/
    ├── main_prompt_v3.0.md
    ├── short_prompt_v3.0.md
    └── VERSIONS.md
```

---

## MIGRAÇÃO DE MINDS EXISTENTES

Se você tem minds na estrutura antiga, siga este processo:

### 1. Backup
```bash
cp -r minds/{mind_name} minds/{mind_name}_BACKUP_20250929
```

### 2. Criar nova estrutura
```bash
cd minds/{mind_name}
mkdir sources artifacts kb system_prompts
mkdir -p docs/logs
```

### 3. Migrar arquivos

**Fontes → sources/**
```bash
mv dataset/livros/* sources/books/
mv dataset/artigos/* sources/articles/
mv dataset/transcricoes/* sources/videos/
```

**Artefatos → artifacts/**
```bash
mv inferencias/*.yaml artifacts/
mv inferencias/*.md artifacts/
mv metadata/* artifacts/
# Achatar tudo (mover de subpastas para raiz)
```

**Finais → kb/**
```bash
mv inferencias/*_final.md kb/
mv inferencias/qa_*.md kb/
# Apenas outputs finais processados
```

**Logs → docs/logs/**
```bash
mv *.md docs/logs/  # Mover logs soltos
# Renomear com timestamp se necessário
```

**Prompts → system_prompts/**
```bash
mv system_prompt*.md system_prompts/
# Renomear com versionamento
```

### 4. Limpar estrutura antiga
```bash
rm -rf dataset/ inferencias/ metadata/
```

### 5. Validar
```bash
# Verificar FLAT
find artifacts/ -mindepth 2 -type f  # Deve estar vazio
find kb/ -mindepth 2 -type f         # Deve estar vazio

# Verificar convenções
ls artifacts/ | grep " "  # Não deve ter espaços
ls kb/ | grep " "         # Não deve ter espaços
```

---

## MANUTENÇÃO

### Limpeza periódica

**artifacts/:**
- Manter apenas artefatos da versão atual
- Arquivar versões antigas se necessário

**kb/:**
- Manter apenas arquivos ativamente usados
- Remover redundâncias

**docs/logs/:**
- Pode crescer indefinidamente (histórico)
- Criar subpastas por ano se necessário: logs/2025/, logs/2026/

**system_prompts/:**
- Manter últimas 3-5 versões
- Arquivar versões muito antigas

### Organização crescente

Se pasta crescer muito (>50 arquivos):

**artifacts/:** Manter FLAT mas pode prefixar por etapa:
```
1_viability_assessment.yaml
2_quotes.md
3_behavioral_patterns.md
4_frameworks.md
5_identity_core.yaml
6_test_results.yaml
```

**kb/:** Manter FLAT mas pode prefixar por tipo:
```
arch_cognitive_final.md
arch_behavioral_final.md
data_qa_general.md
data_qa_business.md
exam_interactions.md
```

---

## RESUMO EXECUTIVO

### ✅ FAZER
- 5-6 pastas máximo (sources, artifacts, docs, kb, system_prompts, specialists)
- FLAT em artifacts/ e kb/ (sem subpastas)
- snake_case em tudo
- Logs com timestamp em docs/logs/
- Versionamento em system_prompts/
- Separar: fonte (sources) vs processo (artifacts) vs produto (kb)
- sources/ = **biblioteca semântica da mente** (corpus cognitivo primário)

### ❌ NÃO FAZER
- Subpastas em artifacts/ ou kb/
- Logs fora de docs/logs/
- Artefatos intermediários em kb/
- Misturar inglês e português
- Espaços ou caracteres especiais em nomes
- Mais de 6 pastas na raiz (sem specialists)

### 🎯 CRITÉRIO-CHAVE
**"O mind precisa saber isso?"**
- SIM → kb/
- NÃO → artifacts/ ou sources/

---

**Versão:** 3.0
**Última atualização:** 29/09/2025
**Status:** ✅ OFICIAL E IMPLEMENTÁVEL
