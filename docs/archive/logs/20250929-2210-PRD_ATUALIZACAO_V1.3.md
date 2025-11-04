# Log de Atualização: PRD v1.0 → v1.3

**Data:** 29 de Setembro de 2025, 22:10
**Arquivo:** `clone_system/docs/PRD.md`
**Versões:** v1.0 → v1.3
**Tipo:** Breaking changes + feature additions

---

## 📋 Sumário Executivo

Atualização crítica do PRD para refletir descobertas em arquivos oficiais do sistema:
- Sistema possui **42 prompts** (não 41)
- **Dupla avaliação sequencial**: APEX Score + ICP Match Score
- **Nomenclatura obrigatória**: underscores (`_`) não hyphens (`-`)
- **Outputs em** `/clones/` (não `/clone_system/outputs/`)
- **Implementação faseada**: Fase 1 (local) → Fase 2 (cloud)

---

## 🔍 Descobertas que Motivaram Atualização

### 1. Análise de `OUTPUTS_GUIDE.md`

**Evidência encontrada:**
```markdown
## ETAPA 1: VIABILITY
|Prompt|Output|Destino|Sequência|
|---|---|---|---|
|`01_scorecard_apex.md`|`viability_assessment.yaml`|`logs/YYYYMMDD-HHMM-viability.yaml`|1º (obrigatório)|
|`02_icp_match_score.md`|`icp_match.yaml`|`logs/YYYYMMDD-HHMM-icp_match.yaml`|2º (se APEX ≥6.0)|
```

**Impacto:**
- Confirmado **42 prompts** (novo `02_icp_match_score.md` adicionado)
- Fluxo sequencial: APEX primeiro, ICP apenas se APEX ≥ 6.0
- Economia de 40% de tokens quando APEX < 6.0

### 2. Análise de `clones/README.md`

**Evidência encontrada:**
```markdown
## 📋 CONVENÇÃO DE NOMENCLATURA OFICIAL
**PADRÃO OBRIGATÓRIO: UNDERSCORES (`_`)**

✅ CORRETO:
personality_profile.json
system_prompts/

❌ INCORRETO:
personality-profile.json (hyphens)
system-prompts/ (hyphens)
```

**Impacto:**
- Nomenclatura underscore é **obrigatória** em todo o sistema
- Exceções: timestamps (`YYYYMMDD-HHMM`) e versões (`v1.0`)
- Rationale: Consistência Python/YAML, maior legibilidade

### 3. Estrutura de Outputs Descoberta

**Evidência encontrada:**
```
nome_do_clone/  # em /clones/
├── system_prompts/  # underscores
├── analysis/
│   ├── personality_profile.json
│   └── behavioral_patterns.md
└── specialists/
```

**Impacto:**
- Outputs vão para `/clones/[nome_clone]/` (não `/clone_system/outputs/`)
- Separação clara: outputs vs código do sistema

---

## ✅ Mudanças Aplicadas ao PRD

### 1. Metadados Atualizados

**Antes (v1.0):**
```markdown
**Versão:** 1.0
**Data:** 29 de Setembro de 2025
**Autor:** John, Product Manager (AIOS)
```

**Depois (v1.3):**
```markdown
**Versão:** 1.3
**Data:** 29 de Setembro de 2025
**Autor:** John, Product Manager (AIOS)
**Atualização:** v1.3 - Sistema de dupla avaliação (APEX + ICP), nomenclatura underscore, 42 prompts
```

### 2. Background Context Expandido

**Adicionado:**
- Menção a **42 prompts especializados**
- 6 etapas do pipeline (Viability → Testing)
- Sistema de **dupla avaliação sequencial**
- APEX Score (viabilidade técnica 0-10)
- ICP Match Score (relevância estratégica 0-10)

### 3. Epic 0 Story 0.1 Completamente Reescrito

**Antes:**
```markdown
**0.1: Classificação do Arquétipo do Clone:** Como usuário, quero ser guiado
para definir as características do clone (vivo/histórico, fontes, etc.), para
que o sistema selecione o workflow ideal.
```

**Depois:**
```markdown
**0.1: Sistema de Dupla Avaliação (APEX + ICP):** Como sistema, quero avaliar
clones em duas dimensões sequenciais (viabilidade técnica e relevância estratégica)
para rejeitar automaticamente clones inviáveis e economizar tokens.

**AC:**
- Executar `01_scorecard_apex.md` primeiro (APEX Score 0-10)
- Se APEX < 6.0 → REJEITAR automaticamente (economia 40% tokens)
- Se APEX ≥ 6.0 → Executar `02_icp_match_score.md` (ICP Score 0-10)
- Decisões automáticas baseadas em ICP:
    - ICP < 6.0 → BUSCAR ALTERNATIVA
    - ICP 6.0-7.9 → CLONE CONDICIONAL
    - ICP 8.0-8.9 → CLONE RECOMENDADO
    - ICP ≥ 9.0 + APEX ≥ 9.0 → CLONE PRIORITÁRIO (P0)
- Priorização combinada: (APEX × 0.4) + (ICP × 0.6)
```

**Rationale:**
- Documenta fluxo crítico de decisão automática
- Explicita economia de tokens (40% quando APEX < 6.0)
- Define thresholds objetivos para aprovação de clones

### 4. Story 2.2 - Workers Especializados

**Antes:**
```markdown
**2.2: Implementação de Ferramentas de Extração:** Como worker, quero ter
acesso a um conjunto de ferramentas especializadas (PDF Parser, Web Scraper,
Transcritor de Vídeo, OCR)...
```

**Depois:**
```markdown
**2.2: Implementação de Workers Especializados por Etapa:** Como orquestrador,
quero workers mapeados para cada um dos 42 prompts do sistema, organizados por
etapa do pipeline.

**AC:** Sistema possui workers especializados:
- **Viability Workers (5):**
    - `viability-apex` → executa `01_scorecard_apex.md`
    - `viability-icp` → executa `02_icp_match_score.md`
    - `viability-prd` → executa `02_prd_generator.md`
    - `viability-dependencies` → executa `02_dependencies_mapper.md`
    - `viability-todo` → executa `03_todo_initializer.md`
- **Research Workers (7):** discovery, collector, temporal, priority, master
- **Analysis Workers (14):** reading, quotes, timeline, forensics, behavioral...
- **Synthesis Workers (7):** templates, phrases, frameworks, patterns...
- **Implementation Workers (5):** extract-patterns, identity, compiler...
- **Testing Workers (4):** validator, knowledge, edge-cases, final-report
```

**Rationale:**
- Lista completa de 42 workers mapeados para 42 prompts
- Organização por etapa facilita compreensão
- Adiciona novo worker `viability-icp` descoberto

### 5. Epic 3.1 - Sistema de Outputs

**Antes:**
```markdown
**3.1: Worker de Síntese (Geração Final):** Como sistema, quero um worker que
receba os caminhos de múltiplos arquivos de análise como input e execute o
prompt de geração final...
```

**Depois:**
```markdown
**3.1: Sistema de Output Estruturado:** Como sistema, quero organizar todos os
outputs em estrutura padronizada usando nomenclatura underscore.

**AC:**
- Todos os outputs vão para `/clones/[nome_do_clone]/`
- Estrutura obrigatória com underscores:
    - `/clones/nome_clone/docs/` - PRD.md, TODO.md, README.md, operational_manual.md
    - `/clones/nome_clone/logs/` - YYYYMMDD-HHMM-*.yaml
    - `/clones/nome_clone/sources/` - books/, interviews/, articles/, etc.
    - `/clones/nome_clone/analysis/` - personality_profile.json, writing_style.md...
    - `/clones/nome_clone/templates/` - communication_templates.md...
    - `/clones/nome_clone/frameworks/` - signature_frameworks.md...
    - `/clones/nome_clone/kb/` - knowledge base chunks
    - `/clones/nome_clone/system_prompts/` - YYYYMMDD-HHMM-vX.Y-generalista-descriptor.md
    - `/clones/nome_clone/specialists/[area]/` - KB e system_prompts especializados
- NUNCA usar hyphens em nomes de arquivo (exceto timestamps)
- Sistema valida nomenclatura antes de salvar
```

**Rationale:**
- Documenta estrutura completa de outputs
- Reforça convenção underscore obrigatória
- Explicita localização correta em `/clones/`

### 6. Technical Assumptions - Implementação Faseada

**Antes:**
```markdown
* **Repositório:** Monorepo.
* **Backend:** Python com FastAPI.
* **Processamento Assíncrono:** Celery para gerenciar a execução dos prompts.
* **Frontend:** React (Next.js) para a interface de monitoramento.
* **Banco de Dados:** PostgreSQL para metadados, estado e o Data Warehouse Cognitivo.
```

**Depois:**
```markdown
* **Implementação em Fases:**
    * **Fase 1 (MVP):** Automação local via Claude Code + AIOS-FULLSTACK
        * Execução manual/assistida dos 42 prompts
        * Outputs salvos em `/clones/[nome_clone]/`
        * Sem infraestrutura cloud (sem FastAPI, PostgreSQL, Celery)
        * Validação do pipeline completo end-to-end
    * **Fase 2 (Escala):** Integração cloud com ClickUp
        * Backend: Python com FastAPI
        * Processamento: Workers especializados
        * Database: PostgreSQL para Data Warehouse
        * Integração: ClickUp API para gestão de tarefas
* **Convenções Críticas:**
    * **Nomenclatura:** Underscores obrigatórios
    * **Outputs:** Sempre em `/clones/` (NUNCA em `/clone_system/outputs/`)
    * **Timestamps:** Formato `YYYYMMDD-HHMM` para logs
```

**Rationale:**
- Reflete realidade: sistema atual é manual, não cloud
- Fase 1 valida pipeline antes de investir em infraestrutura
- Fase 2 mantém visão de escala futura
- Documenta convenções críticas descobertas

### 7. Next Steps Reformulado

**Adicionado:**
- **Fase 1:** Validação local com AIOS-FULLSTACK (5 passos)
- **Fase 2:** Automação e escala (5 passos)
- **Exemplos práticos** de estrutura de outputs esperada

### 8. Changelog v1.3 Completo

**Adicionado:**
```markdown
## 6. Changelog

### v1.3 (29/09/2025)
**BREAKING CHANGES:**
- ✅ Adicionado sistema de dupla avaliação sequencial (APEX + ICP Score)
- ✅ Atualizado de 41 para 42 prompts (novo `02_icp_match_score.md`)
- ✅ Mudança obrigatória de nomenclatura: hyphens → underscores
- ✅ Outputs movidos de `/clone_system/outputs/` para `/clones/`
- ✅ Implementação faseada: Fase 1 (local) → Fase 2 (cloud)

**Detalhes:**
- Epic 0.1 expandido com fluxo APEX → ICP e decisões automáticas
- Story 2.2 atualizada com lista completa de 42 workers
- Epic 3.1 reescrito com estrutura de outputs padronizada
- Technical Assumptions reformulado para refletir abordagem faseada
- Adicionados exemplos práticos de estrutura de outputs

**Rationale:**
- APEX < 6.0 economiza 40% de tokens ao rejeitar clones inviáveis automaticamente
- ICP Score garante relevância estratégica além de viabilidade técnica
- Underscores seguem convenção Python/YAML (melhor legibilidade)
- Separação `/clones/` vs `/clone_system/` mantém outputs separados do código
```

---

## 📊 Comparação: v1.0 vs v1.3

| Aspecto | v1.0 | v1.3 |
|---------|------|------|
| **Número de prompts** | 19+ (vago) | 42 (específico) |
| **Avaliação** | Arquétipo do clone | APEX + ICP Score sequencial |
| **Nomenclatura** | Não especificada | Underscores obrigatórios |
| **Outputs** | Não especificado | `/clones/[nome]/` estruturado |
| **Implementação** | Cloud-first | Faseada (local → cloud) |
| **Workers** | Genéricos | 42 mapeados por prompt |
| **Decisão automática** | Manual | Thresholds objetivos |
| **Economia de tokens** | Não mencionada | 40% quando APEX < 6.0 |

---

## 🎯 Impacto das Mudanças

### Para Desenvolvimento (Fase 1)

**Positivo:**
- ✅ Clareza sobre 42 prompts exatos a implementar
- ✅ Critérios objetivos de aprovação de clones
- ✅ Estrutura de outputs bem definida
- ✅ Fase 1 validável sem infraestrutura cloud

**Atenção:**
- ⚠️ Migração de nomenclatura hyphen → underscore necessária
- ⚠️ Validação de outputs deve verificar convenção underscore
- ⚠️ Sistema deve implementar skip automático se APEX < 6.0

### Para Escala (Fase 2)

**Positivo:**
- ✅ Visão clara de arquitetura futura mantida
- ✅ Separação outputs/código facilita integração cloud
- ✅ Workers mapeados 1:1 com prompts facilita automação

**Atenção:**
- ⚠️ Integração ClickUp deve respeitar estrutura `/clones/`
- ⚠️ Data Warehouse deve parsear nomenclatura underscore
- ⚠️ API deve servir dados de `/clones/` não `/clone_system/outputs/`

---

## 🔄 Próximos Passos Recomendados

### Imediato (Esta Semana)

1. ✅ **PRD atualizado** - CONCLUÍDO
2. ⏳ **Validar com stakeholders** - aprovar mudanças breaking
3. ⏳ **Atualizar prompts existentes** - garantir nomenclatura underscore
4. ⏳ **Criar estrutura base** em `/clones/[clone_teste]/`
5. ⏳ **Executar teste end-to-end** com 42 prompts

### Curto Prazo (Próximas 2 Semanas)

1. ⏳ **Implementar validação** de nomenclatura underscore
2. ⏳ **Documentar fluxo APEX → ICP** em guia operacional
3. ⏳ **Criar scripts** para criação automática de estrutura `/clones/`
4. ⏳ **Testar economia de tokens** com clones rejeitados em APEX

### Médio Prazo (Próximo Mês)

1. ⏳ **Validar Fase 1** com 3-5 clones reais
2. ⏳ **Documentar gaps** para Fase 2
3. ⏳ **Preparar handoff** para arquiteto (Winston)
4. ⏳ **Iniciar design** arquitetura cloud (Fase 2)

---

## 📚 Arquivos Referenciados

### Documentos Consultados

1. **`clone_system/OUTPUTS_GUIDE.md`**
   - Fonte: Fluxo APEX → ICP
   - Fonte: 42 prompts com `02_icp_match_score.md`
   - Fonte: Estrutura de outputs por etapa

2. **`clones/README.md`**
   - Fonte: Convenção underscore obrigatória
   - Fonte: Estrutura de pastas `/clones/[nome]/`
   - Fonte: Status do sistema ACS V3.0

3. **`clone_system/README.md`**
   - Fonte: Arquitetura completa do sistema
   - Fonte: 42 prompts organizados em 6 etapas
   - Fonte: Fluxo de desenvolvimento

### Documento Atualizado

- **`clone_system/docs/PRD.md`** (v1.0 → v1.3)
  - Linhas alteradas: ~50% do documento
  - Seções novas: Changelog, exemplos práticos
  - Breaking changes: 5 principais documentados

---

## ✍️ Assinaturas

**Atualização realizada por:** Claude Code (Sonnet 4.5)
**Aprovação pendente de:** Product Manager (John), Arquiteto (Winston)
**Data de criação:** 29/09/2025 22:10
**Localização:** `/logs/20250929-2210-PRD_ATUALIZACAO_V1.3.md`

---

## 🔖 Tags

`#prd` `#v1.3` `#breaking-changes` `#apex-score` `#icp-score` `#nomenclatura-underscore` `#fase-1` `#fase-2` `#42-prompts` `#atualizacao-critica`

---

**Fim do Log**