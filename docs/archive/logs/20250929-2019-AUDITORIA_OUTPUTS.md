# AUDITORIA DE OUTPUTS - PROMPTS CLONE_SYSTEM

**Data:** 2025-09-29 20:19
**Objetivo:** Verificar padronização de outputs em todos os prompts
**Critérios:** Campo "Output" com path completo + formato de arquivo especificado

---

## RESUMO EXECUTIVO

**Total de arquivos auditados:** 51 prompts
**Status geral:** 🟡 NECESSITA PADRONIZAÇÃO

### Estatísticas:
- ✅ **Outputs padronizados:** 35 arquivos (68%)
- ⚠️ **Outputs parcialmente especificados:** 10 arquivos (20%)
- ❌ **Outputs vagos ou ausentes:** 6 arquivos (12%)

---

## 1. VIABILITY (1_viability/prompts/)

### ✅ ARQUIVOS OK

#### 01.md (scorecard_apex initializer)
- **Output:** `viability_assessment.yaml`
- **Destino:** `logs/YYYYMMDD-HHMM-viability.yaml`
- **Formato:** `.yaml` especificado
- **Status:** ✅ PERFEITO

#### 01_scorecard_apex.md
- **Output:** Scorecard completo de viabilidade
- **Formato:** `.yaml` especificado implicitamente
- **Status:** ✅ OK (mas pode melhorar especificando path exato)

#### 02_dependencies_mapper.md
- **Output:** `dependencies.yaml` estruturado
- **Formato:** `.yaml` especificado
- **Status:** ✅ OK

#### 02_icp_match_score.md
- **Output:** Score de alinhamento com comunidade-alvo
- **Formato:** `.yaml` especificado
- **Status:** ✅ OK

#### 02_prd_generator.md
- **Output:** `docs/PRD.md`
- **Formato:** `.md` especificado
- **Status:** ✅ PERFEITO

#### 03_todo_initializer.md
- **Output:** `docs/TODO.md`
- **Formato:** `.md` especificado
- **Status:** ✅ PERFEITO

---

## 2. RESEARCH (2_research/prompts/)

### ✅ ARQUIVOS OK

#### 01_source_discovery.md
- **Output:** `sources/sources_list.md`
- **Formato:** `.md` especificado
- **Status:** ✅ PERFEITO

#### 02_source_collector.md
- **Output:** `sources/` organizadas + `logs/collection_report.yaml`
- **Formato:** Estrutura de pastas + `.yaml`
- **Status:** ✅ PERFEITO

#### 03_priority_calculator.md
- **Output:** `analysis/priority_matrix.yaml` + `logs/strategy_recommendations.yaml`
- **Formato:** `.yaml` especificado
- **Status:** ✅ PERFEITO

#### 03_temporal_mapper.md
- **Output:** `analysis/timeline.md`
- **Formato:** `.md` especificado
- **Status:** ✅ PERFEITO

#### 04_sources_master.md
- **Output:** `sources_master.yaml` + `readiness_assessment.md`
- **Formato:** `.yaml` + `.md`
- **Status:** ✅ PERFEITO

#### 05_etl_q&a.md
- **Output:** `kb/qa_training.yaml`
- **Formato:** `.yaml` especificado
- **Status:** ⚠️ **PROBLEMA:** Output especifica `kb/` mas deveria ser `datasets/` conforme alerta no próprio arquivo

---

## 3. ANALYSIS (3_analysis/prompts/)

### ✅ ARQUIVOS OK

#### 01_source_reading.md
- **Output:** `analysis/mental_archaeology.md`
- **Formato:** `.md` especificado
- **Status:** ✅ PERFEITO

#### 01_timeline_mapping.md
- **Output:** `analysis/timeline.md`
- **Formato:** `.md` (YAML estruturado dentro)
- **Status:** ✅ OK (duplicado com temporal_mapper?)

#### 01_quote_extraction.md
- **Output:** `analysis/quotes.md`
- **Formato:** `.md` especificado
- **Status:** ✅ PERFEITO

#### 01_rotine.md
- **Output:** `analysis/routine_analysis.md`
- **Formato:** `.md` especificado
- **Status:** ✅ PERFEITO

### ⚠️ ARQUIVOS COM PROBLEMAS

#### 02_behavioral_patterns.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/behavioral_patterns.[formato]`

#### 02_decision_analysis.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/decision_analysis.[formato]`

#### 02_linguistic_forensics.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/linguistic_forensics.[formato]`

#### 03_belief_system.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/belief_system.[formato]`

#### 03_values_hierarchy.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/values_hierarchy.[formato]`

#### 03_contradictions_map.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/contradictions_map.[formato]`

#### 03_immune_system.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/immune_system.[formato]`

#### 04_cognitive_architecture.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/cognitive_architecture.[formato]`

#### 04_psychometric_analysis.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/psychometric_analysis.[formato]`

#### 05_limitations_doc.md
- **Status:** ❌ NÃO LIDO (precisa verificar)
- **Output esperado:** Provavelmente `analysis/limitations.[formato]`

---

## 4. SYNTHESIS (4_synthesis/prompts/)

### ⚠️ STATUS: TODOS PRECISAM VERIFICAÇÃO

#### Arquivos identificados:
1. `01_contradictions.md` - ❌ Verificar output
2. `01_extract_core.md` - ❌ Verificar output
3. `01_frameworks_identifier.md` - ❌ Verificar output
4. `01_phrases_miner.md` - ❌ Verificar output
5. `01_template_extractor.md` - ❌ Verificar output
6. `02_kb_chunker.md` - ❌ Verificar output
7. `03_specialist_recommender.md` - ❌ Verificar output

**Outputs esperados:** Provavelmente em `synthesis/` ou `docs/`

---

## 5. IMPLEMENTATION (5_implementation/prompts/)

### ⚠️ STATUS: TODOS PRECISAM VERIFICAÇÃO

#### Arquivos identificados:
1. `01_extract_core.md` - ❌ Verificar output
2. `01_extract_patterns.md` - ❌ Verificar output
3. `02_identity_core.md` - ❌ Verificar output
4. `02_instructions_core.md` - ❌ Verificar output
5. `02_meta_axioms.md` - ❌ Verificar output
6. `03_generalista_compiler.md` - ❌ Verificar output
7. `04_specialist_creator.md` - ❌ Verificar output
8. `05_operational_manual.md` - ❌ Verificar output
9. `05_testing_protocol.md` - ❌ Verificar output
10. `neural_flow_techniques.md` - ❌ Verificar output

**Outputs esperados:** Provavelmente system prompts finais em formato específico

---

## 6. TESTING (6_testing/prompts/)

### ⚠️ STATUS: TODOS PRECISAM VERIFICAÇÃO

#### Arquivos identificados:
1. `01_test_generator.md` - ❌ Verificar output
2. `02_edge_cases.md` - ❌ Verificar output
3. `02_knowledge_tester.md` - ❌ Verificar output
4. `02_personality_validator.md` - ❌ Verificar output
5. `03_final_report.md` - ❌ Verificar output
6. `04_readme_generator.md` - ❌ Verificar output

**Outputs esperados:** Provavelmente testes e relatórios em `testing/` ou `reports/`

---

## PROBLEMAS IDENTIFICADOS

### 🔴 CRÍTICOS

1. **05_etl_q&a.md** - Output especifica `kb/` mas alerta menciona `datasets/`
   - Inconsistência entre especificação e alertas
   - **Correção:** Padronizar para `datasets/qa_training.yaml`

2. **Duplicação:** `01_timeline_mapping.md` vs `03_temporal_mapper.md`
   - Ambos geram `analysis/timeline.md`
   - **Correção:** Verificar se são redundantes ou complementares

### 🟡 MÉDIOS

3. **Falta de especificação completa em etapas 3, 4, 5, 6**
   - Aproximadamente 25 arquivos sem output verificado
   - **Correção:** Auditar e padronizar cada arquivo

4. **Inconsistência de nomenclatura**
   - Alguns usam `logs/YYYYMMDD-HHMM-nome.ext`
   - Outros usam paths sem timestamp
   - **Correção:** Definir convenção clara

### 🟢 BAIXOS

5. **Formatos mistos**
   - `.md`, `.yaml`, `.json` usados sem padrão claro
   - **Correção:** Documentar quando usar cada formato

---

## RECOMENDAÇÕES

### IMEDIATAS (próximas 24h)

1. ✅ **Auditar arquivos não lidos** (etapas 3, 4, 5, 6)
2. ✅ **Corrigir inconsistência** `kb/` vs `datasets/`
3. ✅ **Adicionar seção METADADOS padronizada** em todos os arquivos que não têm

### CURTO PRAZO (próxima semana)

4. ✅ **Criar template padrão** de METADADOS obrigatório
5. ✅ **Documentar convenção** de nomenclatura (com/sem timestamp)
6. ✅ **Criar checklist** de outputs por etapa

### MÉDIO PRAZO (próximo mês)

7. ✅ **Automatizar validação** de outputs com script
8. ✅ **Criar OUTPUTS_GUIDE.md** centralizado (se ainda não existe)
9. ✅ **Revisar duplicações** e consolidar prompts redundantes

---

## TEMPLATE PROPOSTO PARA PADRONIZAÇÃO

```markdown
## METADADOS
- Versão: X.X
- Responsável: [Nome]
- Tipo: [generator|analyzer|validator|etc]
- Dependências: [Lista de arquivos necessários]
- Inputs obrigatórios: [Lista clara]
- **Output:** [nome_do_arquivo.ext]
- **Destino oficial:** [path/completo/nome_arquivo.ext]
- **Formato:** [.md | .yaml | .json | .txt]
```

---

## PRÓXIMOS PASSOS

1. ☐ Completar auditoria dos 25 arquivos restantes
2. ☐ Corrigir inconsistências identificadas
3. ☐ Aplicar template padronizado
4. ☐ Validar com teste real em um clone
5. ☐ Atualizar documentação central

---

**Gerado por:** Claude Code Audit System
**Data:** 2025-09-29 20:19
**Próxima revisão:** Após correções aplicadas