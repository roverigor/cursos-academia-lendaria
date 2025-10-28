# InnerLens v2.0 - Plano de Migração Final
# 🚨 REVISÃO MANUAL OBRIGATÓRIA

**Date:** 2025-10-27
**Status:** ⏳ AGUARDANDO APROVAÇÃO
**Author:** Winston (Architect Agent)

---

## ⚠️ INSTRUÇÕES

**NÃO EXECUTAR NADA AINDA!**

Este arquivo contém o plano COMPLETO de migração. Você deve:
1. ✅ Revisar cada seção abaixo
2. ✅ Marcar checkboxes para aprovar
3. ✅ Comentar qualquer item que precise mudança
4. ✅ Só depois disso eu executo a migração

**Regra:** NADA será deletado sem sua aprovação explícita.

---

## 📊 RESUMO EXECUTIVO

### O Que Será Feito

**🔑 COMPREENSÃO CORRETA:**
- **Fragments** = Versão **KISS OTIMIZADA** da parte de EXTRACTION do InnerLens
- **InnerLens** = Pack completo (extraction + analysis)
- **Migração** = Substituir extraction do InnerLens pelas otimizações KISS do Fragments

**Unificação:**
- Aplicar otimizações KISS do `fragments/` na parte de extraction do `innerlens/`
- Criar estrutura modular: `innerlens/fragments/` (com KISS) + `innerlens/psychometrics/`
- **CRÍTICO:** Usar taxonomies v5.0 do Fragments (KISS) e **DESCARTAR** versões antigas do InnerLens

**Método:**
- Copiar KISS optimizations do Fragments → InnerLens v2.0
- Arquivar versão antiga (não otimizada) do InnerLens extraction
- Arquivos originais vão para `*-v1-ARCHIVE/` (não deletados!)
- Testar InnerLens v2.0 com KISS optimizations
- Só depois de validar, remover archives

**Impacto:**
- ✅ Zero breaking changes (contratos mantidos)
- ✅ Zero perda de dados (tudo arquivado)
- ✅ Rollback fácil (só renomear pastas)
- ✅ **Extraction agora usa KISS optimizations** (mais eficiente!)

---

## 💡 O QUE ISSO SIGNIFICA NA PRÁTICA

### Antes da Migração

**InnerLens (v1.x):**
- Tinha extraction code (versão original, menos otimizada)
- Tinha analysis code (Big Five)
- Extraction rules possivelmente mais complexas

**Fragments (KISS):**
- Versão OTIMIZADA da extraction
- Taxonomies v5.0 simplificadas
- Regras de segmentação KISS
- Método KISS aplicado

### Depois da Migração (InnerLens v2.0)

**innerlens/fragments/ module:**
- Usa **KISS optimizations** do Fragments ✅
- Taxonomies v5.0 (simplificadas)
- Regras de segmentação otimizadas
- Scripts de extraction otimizados

**innerlens/psychometrics/ module:**
- Mantém Big Five analysis (não mudou)
- Future: HEXACO, VIA

### O Que Será SUBSTITUÍDO

**Extraction old (InnerLens v1) → Extraction KISS (Fragments):**
- ❌ Taxonomies antigas do InnerLens → ✅ Taxonomies v5.0 KISS
- ❌ Regras antigas → ✅ Regras KISS otimizadas
- ❌ Scripts menos eficientes → ✅ Scripts KISS otimizados

**Exemplo concreto:**
```
ANTES:
innerlens/extraction/old_taxonomy.md (complexo)

DEPOIS:
innerlens/fragments/docs/taxonomy/fragment_taxonomy_v5.0.md (KISS)
```

### Benefícios da Migração

1. **Extraction mais eficiente** - Usa KISS optimizations
2. **Taxonomies simplificadas** - v5.0 do Fragments
3. **Mantém analysis intacto** - Big Five não muda
4. **Estrutura modular clara** - Separação extraction/analysis

---

## 🏗️ NOVA ESTRUTURA InnerLens v2.0

```
expansion-packs/innerlens/
├── README.md                        # ✅ Novo (v2.0 unified)
├── config.yaml                      # ✅ Merged (innerlens + fragments)
├── expansion.yaml                   # ✅ Merged
│
├── agents/                          # TOP-LEVEL (orchestrator + shared)
│   ├── innerlens-orchestrator.md   # From innerlens/
│   └── quality-assurance.md        # From innerlens/
│
├── fragments/                       # 🆕 MODULE 1: Fragment Extraction
│   ├── README.md                   # From fragments/README.md
│   ├── agents/
│   │   └── fragment-extractor.md  # From innerlens/agents/
│   ├── tasks/
│   │   ├── extract-fragments.md   # From innerlens/tasks/
│   │   └── validate-mius.md       # From innerlens/tasks/
│   ├── checklists/
│   │   └── miu-quality.md         # From innerlens/checklists/
│   ├── docs/
│   │   ├── taxonomy/              # 🔴 CRITICAL: KISS optimizations
│   │   │   ├── fragment_taxonomy_v5.0.md
│   │   │   ├── segmentation_rules_v5.0.md
│   │   │   ├── source_taxonomy_v5.0.md
│   │   │   └── application_guide_v5.0.md
│   │   └── research/
│   │       ├── manual_extraction_example/
│   │       └── old/ (archived old research)
│   └── scripts/
│       ├── extract_mius_llm.py    # From innerlens/scripts/
│       └── validate_fragments.py   # From fragments/research/
│
├── psychometrics/                   # 🆕 MODULE 2: Personality Analysis
│   ├── README.md                   # ✅ New
│   ├── agents/
│   │   └── psychologist.md        # From innerlens/agents/
│   ├── tasks/
│   │   └── analyze-bigfive.md     # From innerlens/tasks/
│   ├── checklists/
│   │   └── bigfive-quality.md     # From innerlens/checklists/
│   ├── frameworks/
│   │   └── big_five/              # Framework-specific knowledge
│   └── scripts/
│       └── analyze_bigfive.py     # (to be created or moved)
│
├── workflows/                       # INTEGRATED (cross-module)
│   └── extract-analyze-save.md    # From innerlens/workflows/
│
├── tasks/                           # SHARED (cross-module)
│   ├── save-fragments-to-mmos.md  # From innerlens/tasks/
│   └── detect-traits-quick.md     # From innerlens/tasks/
│
├── scripts/                         # SHARED utilities
│   ├── run_workflow.py            # From innerlens/scripts/run_workflow_extract_analyze_save.py
│   ├── save_fragments_to_mmos.py  # From innerlens/scripts/
│   └── save_fragments_to_supabase.py  # From innerlens/scripts/
│
├── testing/
│   ├── scripts/
│   ├── plans/
│   └── MVP-TESTING-GUIDE.md
│
└── docs/
    ├── PRD.md                      # From innerlens/PRD.md
    ├── DESIGN_DECISIONS.md         # From innerlens/DESIGN_DECISIONS.md
    ├── QUICKSTART.md               # From innerlens/QUICKSTART.md
    └── archive/
        ├── v1/                     # InnerLens v1 architecture docs
        └── fragments_v1/           # Fragments old research
```

---

## 📋 PLANO DE AÇÃO DETALHADO

### FASE 0: Backup Completo

**Antes de QUALQUER coisa:**

- [ ] **APROVADO:** Criar backup completo
  ```bash
  cp -r expansion-packs/innerlens expansion-packs/innerlens-backup-20251027
  cp -r expansion-packs/fragments expansion-packs/fragments-backup-20251027
  ```

---

### FASE 1: Criar Estrutura Base

**Ações:**
- [ ] **APROVADO:** Criar diretórios do InnerLens v2.0
  ```bash
  mkdir -p expansion-packs/innerlens-v2
  mkdir -p expansion-packs/innerlens-v2/{agents,fragments,psychometrics,workflows,tasks,scripts,testing,docs}
  mkdir -p expansion-packs/innerlens-v2/fragments/{agents,tasks,checklists,docs/taxonomy,docs/research,scripts}
  mkdir -p expansion-packs/innerlens-v2/psychometrics/{agents,tasks,checklists,frameworks/big_five,scripts}
  mkdir -p expansion-packs/innerlens-v2/docs/archive/{v1,fragments_v1}
  ```

---

### FASE 2: Migrar Fragments KISS (CRÍTICO!)

**🔴 ATENÇÃO:** Estas são as otimizações que você mencionou - DEVEM ser preservadas!

#### Files to Migrate:

| Source | Destination | Status |
|--------|-------------|--------|
| `fragments/docs/research/fragment_taxonomy_mmos_v5.0_english.md` | `innerlens-v2/fragments/docs/taxonomy/fragment_taxonomy_v5.0.md` | [ ] APROVADO |
| `fragments/docs/research/fragment_segmentation_rules_mmos_v5_0.md` | `innerlens-v2/fragments/docs/taxonomy/segmentation_rules_v5.0.md` | [ ] APROVADO |
| `fragments/docs/research/source_taxonomy_mmos_v5.0_english.md` | `innerlens-v2/fragments/docs/taxonomy/source_taxonomy_v5.0.md` | [ ] APROVADO |
| `fragments/docs/research/taxonomy_application_guide_mmos_v5.0_english.md` | `innerlens-v2/fragments/docs/taxonomy/application_guide_v5.0.md` | [ ] APROVADO |

**Comando:**
```bash
cp "expansion-packs/fragments/docs/research/fragment_taxonomy_mmos_v5.0_english.md" \
   "expansion-packs/innerlens-v2/fragments/docs/taxonomy/fragment_taxonomy_v5.0.md"

cp "expansion-packs/fragments/docs/research/fragment_segmentation_rules_mmos_v5_0.md" \
   "expansion-packs/innerlens-v2/fragments/docs/taxonomy/segmentation_rules_v5.0.md"

cp "expansion-packs/fragments/docs/research/source_taxonomy_mmos_v5.0_english.md" \
   "expansion-packs/innerlens-v2/fragments/docs/taxonomy/source_taxonomy_v5.0.md"

cp "expansion-packs/fragments/docs/research/taxonomy_application_guide_mmos_v5.0_english.md" \
   "expansion-packs/innerlens-v2/fragments/docs/taxonomy/application_guide_v5.0.md"
```

---

### FASE 3: Migrar Agents

#### Module: Fragments

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/agents/fragment-extractor.md` | `innerlens-v2/fragments/agents/fragment-extractor.md` | [ ] APROVADO |

#### Module: Psychometrics

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/agents/psychologist.md` | `innerlens-v2/psychometrics/agents/psychologist.md` | [ ] APROVADO |

#### Top-Level (Shared)

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/agents/innerlens-orchestrator.md` | `innerlens-v2/agents/innerlens-orchestrator.md` | [ ] APROVADO |
| `innerlens/agents/quality-assurance.md` | `innerlens-v2/agents/quality-assurance.md` | [ ] APROVADO |

---

### FASE 4: Migrar Tasks

#### Module: Fragments

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/tasks/extract-fragments.md` | `innerlens-v2/fragments/tasks/extract-fragments.md` | [ ] APROVADO |
| `innerlens/tasks/validate-mius.md` | `innerlens-v2/fragments/tasks/validate-mius.md` | [ ] APROVADO |

#### Module: Psychometrics

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/tasks/analyze-bigfive.md` | `innerlens-v2/psychometrics/tasks/analyze-bigfive.md` | [ ] APROVADO |

#### Shared (Cross-Module)

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/tasks/save-fragments-to-mmos.md` | `innerlens-v2/tasks/save-fragments-to-mmos.md` | [ ] APROVADO |
| `innerlens/tasks/detect-traits-quick.md` | `innerlens-v2/tasks/detect-traits-quick.md` | [ ] APROVADO |

---

### FASE 5: Migrar Checklists

#### Module: Fragments

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/checklists/miu-quality.md` | `innerlens-v2/fragments/checklists/miu-quality.md` | [ ] APROVADO |

#### Module: Psychometrics

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/checklists/bigfive-quality.md` | `innerlens-v2/psychometrics/checklists/bigfive-quality.md` | [ ] APROVADO |

---

### FASE 6: Migrar Workflows

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/workflows/extract-analyze-save.md` | `innerlens-v2/workflows/extract-analyze-save.md` | [ ] APROVADO |

---

### FASE 7: Migrar Scripts

#### Module: Fragments

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/scripts/extract_mius_llm.py` | `innerlens-v2/fragments/scripts/extract_mius_llm.py` | [ ] APROVADO |
| `fragments/docs/research/exemplo.../validate_fragments.py` | `innerlens-v2/fragments/scripts/validate_fragments.py` | [ ] APROVADO |

#### Shared

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/scripts/run_workflow_extract_analyze_save.py` | `innerlens-v2/scripts/run_workflow.py` | [ ] APROVADO |
| `innerlens/scripts/save_fragments_to_mmos.py` | `innerlens-v2/scripts/save_fragments_to_mmos.py` | [ ] APROVADO |
| `innerlens/scripts/save_fragments_to_supabase.py` | `innerlens-v2/scripts/save_fragments_to_supabase.py` | [ ] APROVADO |
| `innerlens/scripts/save_to_database.py` | `innerlens-v2/scripts/save_to_database.py` | [ ] APROVADO |

---

### FASE 8: Migrar Testing

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/testing/scripts/` (all) | `innerlens-v2/testing/scripts/` | [ ] APROVADO |
| `innerlens/testing/*.md` (all guides) | `innerlens-v2/testing/` | [ ] APROVADO |

---

### FASE 9: Migrar Documentation

#### Top-Level Docs

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/PRD.md` | `innerlens-v2/docs/PRD.md` | [ ] APROVADO |
| `innerlens/DESIGN_DECISIONS.md` | `innerlens-v2/docs/DESIGN_DECISIONS.md` | [ ] APROVADO |
| `innerlens/QUICKSTART.md` | `innerlens-v2/docs/QUICKSTART.md` | [ ] APROVADO |

#### Module-Specific Docs

| Source | Destination | Status |
|--------|-------------|--------|
| `fragments/README.md` | `innerlens-v2/fragments/README.md` | [ ] APROVADO |
| `fragments/docs/research/exemplo.../` (all) | `innerlens-v2/fragments/docs/research/manual_extraction_example/` | [ ] APROVADO |

---

### FASE 10: Arquivar Old Architecture Docs

**NÃO DELETAR - apenas mover para archive/**

#### InnerLens v1 Architecture Docs

| Source | Destination | Status |
|--------|-------------|--------|
| `innerlens/docs/UNIVERSAL-FRAGMENTS-ARCHITECTURE.md` | `innerlens-v2/docs/archive/v1/` | [ ] APROVADO |
| `innerlens/docs/MIU-FRAGMENT-ARCHITECTURE.md` | `innerlens-v2/docs/archive/v1/` | [ ] APROVADO |
| `innerlens/docs/FRAGMENTS-ARCHITECTURE.md` | `innerlens-v2/docs/archive/v1/` | [ ] APROVADO |
| `innerlens/docs/FINAL-ARCHITECTURE.md` | `innerlens-v2/docs/archive/v1/` | [ ] APROVADO |
| `innerlens/docs/ARCHITECTURE-COMPARISON.md` | `innerlens-v2/docs/archive/v1/` | [ ] APROVADO |
| `innerlens/docs/DECISION-PRINCIPLES.md` | `innerlens-v2/docs/archive/v1/` | [ ] APROVADO |
| `innerlens/docs/PDR.md` | `innerlens-v2/docs/archive/v1/` | [ ] APROVADO |
| `innerlens/docs/Conversa-Fragmentos.md` | `innerlens-v2/docs/archive/v1/` | [ ] APROVADO |
| `innerlens/docs/epics/EPIC-0-FOUNDATION.md` | `innerlens-v2/docs/archive/v1/epics/` | [ ] APROVADO |
| `innerlens/docs/epics/EPIC-1-ENHANCED-ANALYSIS.md` | `innerlens-v2/docs/archive/v1/epics/` | [ ] APROVADO |
| `innerlens/docs/archive/` (all existing) | `innerlens-v2/docs/archive/v1/old/` | [ ] APROVADO |

#### Fragments v1 Old Research

| Source | Destination | Status |
|--------|-------------|--------|
| `fragments/docs/research/old/` (all) | `innerlens-v2/docs/archive/fragments_v1/old_research/` | [ ] APROVADO |
| `fragments/docs/research/mmos_v5_model_optimizer.py` | `innerlens-v2/docs/archive/fragments_v1/` | [ ] APROVADO |

---

### FASE 11: Criar Novos Arquivos

#### README.md (InnerLens v2.0)

- [ ] **APROVADO:** Criar novo README.md unificado
  - Documenta arquitetura 1 pack, 2 modules
  - Explica fragments/ vs psychometrics/
  - Usage examples
  - Migration notes

#### config.yaml (Merged)

- [ ] **APROVADO:** Merge configs de innerlens + fragments
  - Agents: 4 total (orchestrator, fragment-extractor, psychologist, quality-assurance)
  - Tasks: 5 total
  - Workflows: 1 integrated
  - Version: 2.0.0

#### psychometrics/README.md

- [ ] **APROVADO:** Criar README do módulo psychometrics
  - Big Five framework docs
  - Future: HEXACO, VIA
  - How to add new frameworks

---

## ⚠️ ARQUIVOS A REVISAR (NÃO DELETAR AINDA!)

**Preciso que você me diga o que fazer com estes arquivos:**

### Prompts (Unclear Purpose)

| File | Question | Your Decision |
|------|----------|---------------|
| `innerlens/docs/prompts/prompt1.md` | O que é? Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/prompt2.md` | O que é? Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/prompt3.md` | O que é? Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/prompt4.md` | O que é? Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/prompt5.md` | O que é? Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/prompt6.md` | O que é? Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/prompt7.md` | O que é? Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/prompt8.md` | O que é? Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/interrogation-sop.md` | Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/interrogation_protocol.yaml` | Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/as.md` | O que é "as"? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/prompts/discovery-sourcers.md` | Ainda usado? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |

### Duplicates

| File | Question | Your Decision |
|------|----------|---------------|
| `innerlens/README 2.md` | Duplicate do README.md? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |
| `innerlens/docs/archive/README 2.md` | Duplicate? | [ ] KEEP [ ] ARCHIVE [ ] DELETE |

**Ação para os marcados como KEEP:** Mover para local apropriado
**Ação para os marcados como ARCHIVE:** Mover para `docs/archive/v1/prompts/`
**Ação para os marcados como DELETE:** Deletar (mas só depois de você confirmar!)

---

## 🔄 FASE 12: Rename & Activate

**Só executar depois de testar InnerLens v2.0:**

- [ ] **APROVADO:** Renomear old packs para archive
  ```bash
  mv expansion-packs/innerlens expansion-packs/innerlens-v1-ARCHIVE
  mv expansion-packs/fragments expansion-packs/fragments-v1-ARCHIVE
  ```

- [ ] **APROVADO:** Ativar InnerLens v2.0
  ```bash
  mv expansion-packs/innerlens-v2 expansion-packs/innerlens
  ```

---

## ✅ FASE 13: Testing

**Antes de considerar completo:**

- [ ] **APROVADO:** Test fragments module
  ```bash
  cd expansion-packs/innerlens
  pytest fragments/tests/ -v
  ```

- [ ] **APROVADO:** Test psychometrics module
  ```bash
  pytest psychometrics/tests/ -v
  ```

- [ ] **APROVADO:** Test integrated workflow
  ```bash
  python scripts/run_workflow.py test_mind test.txt
  ```

- [ ] **APROVADO:** Verify MMOS integration (contract compliance)
  ```bash
  python scripts/test_mmos_integration.py
  ```

---

## 📋 CHECKLIST DE APROVAÇÃO FINAL

### Geral

- [ ] **Li e entendi** todas as fases do plano
- [ ] **Revisei** todos os files a migrar
- [ ] **Decidi** o que fazer com arquivos em "A Revisar"
- [ ] **Confirmo** que NADA será deletado permanentemente
- [ ] **Confirmo** que posso fazer rollback facilmente (só renomear pastas)

### Crítico

- [ ] **Confirmo** que as 4 taxonomy files KISS serão preservadas
- [ ] **Confirmo** que todos scripts Python serão migrados
- [ ] **Confirmo** que agents/tasks AIOS serão mantidos

### Próximos Passos

- [ ] **APROVADO PARA EXECUÇÃO:** Winston pode executar Fases 1-11
- [ ] **AGUARDAR:** Não execute ainda, tenho dúvidas
- [ ] **MODIFICAR:** Preciso mudar algumas coisas primeiro

---

## 🚨 ROLLBACK PLAN

**Se algo der errado:**

1. **Método 1: Restore backups**
   ```bash
   rm -rf expansion-packs/innerlens
   rm -rf expansion-packs/fragments
   cp -r expansion-packs/innerlens-backup-20251027 expansion-packs/innerlens
   cp -r expansion-packs/fragments-backup-20251027 expansion-packs/fragments
   ```

2. **Método 2: Rename archives**
   ```bash
   rm -rf expansion-packs/innerlens
   mv expansion-packs/innerlens-v1-ARCHIVE expansion-packs/innerlens
   mv expansion-packs/fragments-v1-ARCHIVE expansion-packs/fragments
   ```

**Tempo estimado de rollback:** < 1 minuto

---

## 📊 IMPACTO ESTIMADO

**Tempo de execução:** 30-45 minutos
**Risk level:** 🟢 BAIXO (tudo arquivado, rollback fácil)
**Breaking changes:** ❌ NENHUM (contratos mantidos)
**Data loss risk:** ❌ ZERO (nada deletado permanentemente)

---

## ✍️ SUA APROVAÇÃO

**Data de revisão:** _______________
**Status:** [ ] APROVADO [ ] MODIFICAR [ ] REJEITAR

**Comentários/Modificações:**
```
[Escreva aqui qualquer mudança que você quer]
```

**Aprovado por:** _______________

---

**DEPOIS DE APROVAR:**
- Eu executo Fases 1-11
- Testo InnerLens v2.0
- Reporto resultados
- Você aprova Fase 12 (rename & activate)
- Só então consideramos completo

---

**AGUARDANDO SUA REVISÃO! ✅**
