# Mapeamento Completo: 63 Prompts → 8 Camadas DNA Mental™

**Data:** 29/09/2025 23:15
**Problema:** DNA_MENTAL_METHODOLOGY.md mapeia apenas ~14 prompts, mas sistema tem 63
**Objetivo:** Mapear TODOS os 63 prompts nas 8 camadas

---

## 🚨 DESCOBERTA CRÍTICA

**Contagem Real:**
- Total de arquivos .md em /prompts/: **63**
- Prompts deprecated/backup: **4**
- **Prompts ativos:** 59

**DNA Mental V2.0 mapeia:** ~14 prompts (~24% do sistema!)

**GAP:** 45 prompts (76%) NÃO estão mapeados nas 8 camadas!

---

## 📊 CONTAGEM POR ETAPA

```
ETAPA 1 - VIABILITY:     6 prompts (1 deprecated)
ETAPA 2 - RESEARCH:      6 prompts
ETAPA 3 - ANALYSIS:     14 prompts (+ 10 backup)
ETAPA 4 - SYNTHESIS:     7 prompts
ETAPA 5 - IMPLEMENTATION: 10 prompts (1 deprecated)
ETAPA 6 - TESTING:       6 prompts
---
TOTAL ATIVO:            49 prompts
DEPRECATED/BACKUP:      14 prompts
TOTAL ARQUIVOS:         63 prompts
```

---

## 🔍 ANÁLISE: ONDE ESTÃO OS 45 PROMPTS FALTANDO?

### ETAPA 1 - VIABILITY (5 ativos)
❌ **NENHUM mapeado nas 8 camadas**

```
01_scorecard_apex.md           → ❌ Não mapeado
02_icp_match_score.md          → ❌ Não mapeado
02_prd_generator.md            → ❌ Não mapeado
02_dependencies_mapper.md      → ❌ Não mapeado
03_todo_initializer.md         → ❌ Não mapeado
```

**Razão:** Viability é PRÉ-extração, não captura DNA Mental

---

### ETAPA 2 - RESEARCH (6 ativos)
❌ **NENHUM mapeado nas 8 camadas**

```
01_source_discovery.md         → ❌ Não mapeado
02_source_collector.md         → ❌ Não mapeado
03_temporal_mapper.md          → ❌ Não mapeado
03_priority_calculator.md      → ❌ Não mapeado
04_sources_master.md           → ❌ Não mapeado
05_etl_q&a.md                  → ❌ Não mapeado
```

**Razão:** Research é coleta de matéria-prima, não extração de camadas

---

### ETAPA 3 - ANALYSIS (14 ativos)
✅ **~11 mapeados** (79%)
❌ **3 NÃO mapeados** (21%)

**✅ Mapeados:**
```
01_source_reading.md           → ✅ C1: Extração Base
01_quote_extraction.md         → ✅ C1: Extração Base
01_timeline_mapping.md         → ✅ C1: Extração Base

02_linguistic_forensics.md     → ✅ C2: Superfície Linguística
02_behavioral_patterns.md      → ✅ C3: Padrões Comportamentais

03_values_hierarchy.md         → ✅ C4: Hierarquia de Valores
03_belief_system.md            → ✅ C5: Sistema de Crenças
03_contradictions_map.md       → ✅ C6: Paradoxos Produtivos

06_cognitive_architecture.md   → ✅ C7: Arquitetura Cognitiva
06_psychometric_analysis.md    → ✅ C8: Singularidade Cognitiva
06_limitations_doc.md          → ✅ Documentação (não é camada)
```

**❌ NÃO Mapeados:**
```
01_rotine.md                   → ❌ Não mencionado no DNA Mental
03_decision_architecture.md    → ❌ Não mencionado (mas DEVERIA ser C7!)
03_immune_system.md            → ❌ Não mencionado no DNA Mental
```

**PROBLEMA:** 
- `02_decision_analysis.md` foi **REMOVIDO** e virou `03_decision_architecture.md`
- DNA Mental ainda referencia arquivo antigo!
- `03_immune_system.md` captura padrões de defesa (parte de C3 ou C6?)

---

### ETAPA 4 - SYNTHESIS (7 ativos)
✅ **4 mapeados** (57%)
❌ **3 NÃO mapeados** (43%)

**✅ Mapeados:**
```
01_template_extractor.md       → ✅ C2: Superfície (refino)
01_phrases_miner.md            → ✅ C2: Superfície (refino)
01_frameworks_identifier.md    → ✅ C7: Arquitetura (refino)
# patterns_synthesizer.md REMOVIDO!
```

**❌ NÃO Mapeados:**
```
01_extract_core.md             → ❌ Não mencionado
01_contradictions.md           → ❌ Não mencionado (mas refina C6!)
02_kb_chunker.md               → ❌ Não mencionado
03_specialist_recommender.md   → ❌ Não mencionado
```

**PROBLEMA:**
- DNA Mental menciona `01_patterns_synthesizer.md` mas arquivo não existe!
- `01_contradictions.md` claramente refina Camada 6 mas não está mapeado

---

### ETAPA 5 - IMPLEMENTATION (9 ativos)
❌ **NENHUM mapeado nas 8 camadas**

```
01_extract_patterns.md         → ❌ Não mapeado
01_extract_core.md             → ❌ Não mapeado
02_identity_core.md            → ❌ Não mapeado
02_meta_axioms.md              → ❌ Não mapeado
02_instructions_core.md        → ❌ Não mapeado
03_generalista_compiler.md     → ❌ Não mapeado
04_specialist_creator.md       → ❌ Não mapeado
05_operational_manual.md       → ❌ Não mapeado
05_testing_protocol.md         → ❌ Não mapeado
```

**Razão:** Implementation INTEGRA as 8 camadas, não captura camadas individuais

---

### ETAPA 6 - TESTING (6 ativos)
❌ **NENHUM mapeado nas 8 camadas**

```
01_test_generator.md           → ❌ Não mapeado
02_personality_validator.md    → ❌ Não mapeado
02_knowledge_tester.md         → ❌ Não mapeado
02_edge_cases.md               → ❌ Não mapeado
03_final_report.md             → ❌ Não mapeado
04_readme_generator.md         → ❌ Não mapeado
```

**Razão:** Testing VALIDA as 8 camadas, não captura camadas individuais

---

## 📊 RESUMO ESTATÍSTICO

### Prompts por Função:

| Função | Quantidade | % do Total |
|--------|------------|------------|
| **Captura DNA** (Etapas 3-4) | 21 prompts | 43% |
| **Preparação** (Etapas 1-2) | 11 prompts | 22% |
| **Integração** (Etapa 5) | 9 prompts | 18% |
| **Validação** (Etapa 6) | 6 prompts | 12% |
| **Deprecated** | 2 prompts | 4% |

### Cobertura nas 8 Camadas:

| Camada | Prompts Mapeados | % Cobertura |
|--------|------------------|-------------|
| C1: Extração Base | 3 prompts | ✅ 100% |
| C2: Superfície | 3 prompts (1+2 refino) | ✅ 100% |
| C3: Padrões | 1-2 prompts | ⚠️ 50% (falta immune_system?) |
| C4: Valores | 1 prompt | ✅ 100% |
| C5: Crenças | 1 prompt | ✅ 100% |
| C6: Paradoxos | 1 prompt | ⚠️ 50% (falta refino contradictions?) |
| C7: Arquitetura | 2-3 prompts | ⚠️ 67% (falta decision_architecture?) |
| C8: Singularidade | 1 prompt | ✅ 100% |

---

## 🚨 PROBLEMAS CRÍTICOS ENCONTRADOS

### PROBLEMA #1: Arquivos Renomeados/Removidos

**DNA Mental menciona:**
```
02_decision_analysis.md → decision_patterns.yaml
01_patterns_synthesizer.md → decision_patterns.md
```

**Realidade atual:**
```
02_decision_analysis.md → ❌ NÃO EXISTE (foi renomeado?)
03_decision_architecture.md → ✅ EXISTE mas não mapeado!
01_patterns_synthesizer.md → ❌ NÃO EXISTE
```

**Impacto:** DNA Mental referencia 2 arquivos inexistentes!

---

### PROBLEMA #2: Novos Prompts Não Mapeados

**Prompts existentes mas não mapeados:**
```
ETAPA 3:
  - 01_rotine.md
  - 03_decision_architecture.md
  - 03_immune_system.md

ETAPA 4:
  - 01_extract_core.md
  - 01_contradictions.md
  - 02_kb_chunker.md
  - 03_specialist_recommender.md
```

**Impacto:** 7 prompts (14% do total) não têm lugar na metodologia!

---

### PROBLEMA #3: Etapas 1-2-5-6 Não Mapeadas

**32 prompts (65% do sistema) não aparecem nas 8 camadas!**

**Razão válida?**
- Etapas 1-2: Preparação (antes da extração)
- Etapas 5-6: Integração/Validação (depois da extração)

**MAS:** DNA Mental não explica isso claramente!

---

## 💡 SOLUÇÕES PROPOSTAS

### OPÇÃO A: Mapear TODOS os 49 Prompts

Expandir DNA Mental para incluir:
- **Preparação** (Etapas 1-2): Como preparamos para extrair
- **Extração** (Etapas 3-4): As 8 camadas
- **Integração** (Etapa 5): Como integramos as camadas
- **Validação** (Etapa 6): Como validamos as camadas

**Vantagem:** Metodologia completa
**Desvantagem:** Perde foco nas "8 camadas"

---

### OPÇÃO B: Clarificar Escopo das 8 Camadas

Adicionar seção no DNA Mental:

```markdown
## 🎯 ESCOPO DAS 8 CAMADAS

As 8 Camadas DNA Mental™ se referem especificamente à **EXTRAÇÃO** 
(Etapas 3-4: Analysis + Synthesis).

**O sistema completo tem 6 etapas:**
1. Viability (5 prompts) - PRÉ-extração
2. Research (6 prompts) - PRÉ-extração
3. Analysis (14 prompts) - ⭐ Captura Camadas 1-8
4. Synthesis (7 prompts) - ⭐ Refina Camadas 2-7
5. Implementation (9 prompts) - PÓS-extração (integração)
6. Testing (6 prompts) - PÓS-extração (validação)

Total: 49 prompts ativos
Camadas DNA: 21 prompts (43% do sistema)
```

**Vantagem:** Mantém foco nas 8 camadas, mas contextualiza
**Desvantagem:** Ainda não mapeia 100%

---

### OPÇÃO C: Corrigir Referências + Mapear Faltantes

**Correções urgentes:**
1. `02_decision_analysis.md` → `03_decision_architecture.md`
2. `01_patterns_synthesizer.md` → REMOVER (não existe)
3. Adicionar prompts faltantes:
   - `03_decision_architecture.md` → Camada 7
   - `03_immune_system.md` → Camada 3 ou 6?
   - `01_contradictions.md` → Camada 6 (refino)
   - `01_rotine.md` → Camada 1 (suporte?)

**Vantagem:** Correção técnica precisa
**Desvantagem:** Ainda não resolve questão filosófica do escopo

---

## 🎯 RECOMENDAÇÃO FINAL

**Combinação de B + C:**

1. ✅ **Clarificar escopo** - 8 camadas = extração (21 prompts)
2. ✅ **Corrigir referências** - Arquivos que não existem
3. ✅ **Mapear faltantes** - 7 prompts não mapeados
4. ✅ **Adicionar contexto** - Onde ficam outros 28 prompts

**Resultado:**
- DNA Mental continua focado em "8 Camadas"
- Mas explica onde estão os outros 28 prompts
- Corrige referências quebradas
- Mapeia 100% dos prompts de extração (21/21)

---

## 📋 CHECKLIST DE CORREÇÕES

### DNA_MENTAL_METHODOLOGY.md:

- [ ] Corrigir: `02_decision_analysis.md` → `03_decision_architecture.md`
- [ ] Remover: `01_patterns_synthesizer.md` (não existe)
- [ ] Adicionar: `03_immune_system.md` (Camada 3 ou 6?)
- [ ] Adicionar: `01_rotine.md` (suporte Camada 1?)
- [ ] Adicionar: `01_contradictions.md` (refino Camada 6)
- [ ] Adicionar seção: "Escopo das 8 Camadas vs. Sistema Completo"
- [ ] Adicionar tabela: "Mapeamento Completo dos 49 Prompts"

### OUTPUTS_GUIDE.md:

- [ ] Verificar se menciona `02_decision_analysis.md`
- [ ] Atualizar para `03_decision_architecture.md`
- [ ] Verificar se lista TODOS os 49 prompts ativos

---

**Próximo Passo:** Você escolhe qual opção seguir (A, B, C, ou B+C)?

**Impacto:** CRÍTICO - Afeta integridade da metodologia
**Esforço:** Médio - ~1h para correção completa
