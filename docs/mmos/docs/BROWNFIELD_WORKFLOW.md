# BROWNFIELD WORKFLOW - Atualização de Minds Existentes

**Versão:** 1.0
**Data:** 04/10/2025
**Inspirado em:** AIOS Brownfield Strategy

---

## 🎯 Objetivo

Este workflow é para **atualizar minds já existentes** com novas fontes, corrigir gaps, ou refinar arquiteturas cognitivas.

**Diferença-chave do Greenfield:**
- **Greenfield:** Mind novo (começar do zero)
- **Brownfield:** Mind existente (trabalhar com material já produzido)

---

## 📋 Quando Usar Brownfield

✅ **Use Brownfield quando:**
- Descobriu nova fonte importante para mind existente
- Identificou gap de cobertura temporal
- Detectou inconsistência na arquitetura cognitiva
- Recebeu feedback de usuário sobre comportamento incorreto
- Quer adicionar novo specialist a mind generalista
- Precisa atualizar knowledge base com novo material

❌ **NÃO use Brownfield quando:**
- Criar mind de pessoa diferente (use Greenfield)
- Diferenças são tão grandes que é melhor começar do zero

---

## 🔍 Fase 0: Assessment (Antes de Começar)

### 1. Documentar Estado Atual

```bash
cd minds/[mind_name]

# Criar snapshot do estado atual
cp -r . ../BACKUP_[mind_name]_$(date +%Y%m%d)

# Documentar em log
cat > docs/logs/$(date +%Y%m%d-%H%M)-brownfield_start.md <<EOF
# Brownfield Start - [Razão]

## Estado Atual
- System Prompt Version: vX.Y
- KB Chunks: [número]
- Last Update: [data]
- Specialists: [lista]

## Objetivo da Atualização
[Descrever o que vai mudar e por quê]

## Fontes Novas
1. [Fonte 1]
2. [Fonte 2]

## Gaps Identificados
- [Gap 1]
- [Gap 2]
EOF
```

### 2. Ler Documentação Existente

**Leitura obrigatória antes de modificar:**

- `/docs/README.md` - Entender contexto do mind
- `/docs/PRD.md` ou `MIND_BRIEF.md` - Objetivo original
- `/artifacts/cognitive_architecture.yaml` - Arquitetura atual
- `/docs/LIMITATIONS.md` - Limitações conhecidas
- `/docs/logs/` - Últimas mudanças

### 3. Criar Plano de Atualização

```yaml
# brownfield_plan.yaml
update_scope:
  type: "incremental" # incremental | refactoring | major_overhaul
  impact: "low" # low | medium | high

areas_affected:
  - sources: true
  - artifacts: false
  - kb: true
  - system_prompts: false
  - specialists: false

new_sources:
  - title: ""
    type: ""
    priority: "high"

validation_required:
  - "Test persona consistency"
  - "Validate no regression"
  - "Compare before/after responses"
```

---

## 🔄 Workflow Brownfield (6 Passos)

### PASSO 1: Incremental Research

**Objetivo:** Adicionar novas fontes SEM reprocessar tudo

#### 1.1 Adicionar Novas Fontes

```bash
# Adicionar fonte nova à biblioteca
cp [nova_fonte] sources/[categoria]/

# Atualizar sources_master.yaml
# Adicionar entry para nova fonte
```

#### 1.2 Quick Analysis (Não Full Pipeline)

**NÃO execute todo 3_analysis novamente.**

Execute apenas:
- `01_source_reading.md` - Ler nova fonte
- `01_quote_extraction.md` - Extrair citações
- `02_behavioral_patterns.md` - **SOMENTE** da nova fonte

#### 1.3 Merge com Análise Existente

```bash
# Comparar novos padrões com existentes
diff artifacts/behavioral_patterns.md artifacts/NEW_behavioral_patterns.md

# Merge manual - adicionar APENAS novos insights
# NÃO sobrescrever análise anterior
```

---

### PASSO 2: Incremental Synthesis

**Objetivo:** Atualizar KB sem recriar tudo do zero

#### 2.1 Criar Novos Chunks

```bash
# Gerar chunks APENAS da nova fonte
cd kb/
# Último chunk existente: chunk_042.md
# Novos chunks começam em: chunk_043.md
```

#### 2.2 Atualizar Communication Templates (Opcional)

Se nova fonte trouxe **novos** templates:

```bash
# Adicionar ao artifacts/communication_templates.md
# Marcar claramente: "Added from [source] on [date]"
```

#### 2.3 Update Index

```bash
# Se existe kb/index.md, atualizar com novos chunks
# Manter organização por tema/fonte
```

---

### PASSO 3: Validation Against Existing

**Objetivo:** Garantir que mudanças não quebraram consistência

#### 3.1 Consistency Check

```yaml
# consistency_check.yaml

checks:
  - name: "Core values unchanged"
    status: "pass" # pass | fail | warning
    notes: ""

  - name: "Cognitive architecture compatible"
    status: "pass"
    notes: ""

  - name: "No contradictions with previous sources"
    status: "warning"
    notes: "Nova fonte sugere X, mas fonte antiga dizia Y. Resolver em paradoxos."
```

#### 3.2 Regression Testing

**Testes críticos:**

1. **Personality Test:** Responder mesmo prompt que versão anterior
2. **Knowledge Test:** Verificar se respostas antigas ainda corretas
3. **Edge Cases:** Testar casos extremos documentados

```bash
# Criar arquivo de teste
cat > docs/logs/$(date +%Y%m%d-%H%M)-regression_test.md <<EOF
# Regression Test - v[old] → v[new]

## Test 1: Personality Consistency
**Prompt:** [prompt de teste]
**v[old] Response:** [resposta antiga]
**v[new] Response:** [resposta nova]
**Status:** ✅ Consistent | ⚠️ Slight Change | ❌ Regression

## Test 2: Knowledge Retention
...
EOF
```

---

### PASSO 4: Selective Prompt Update

**Objetivo:** Atualizar system prompt APENAS se necessário

#### 4.1 Decide: Update ou Não?

**Update System Prompt SE:**
- ✅ Nova fonte mudou core obsession
- ✅ Descobriu novo mental model crítico
- ✅ Corrigiu erro significativo na arquitetura

**NÃO Update SE:**
- ❌ Apenas adicionou exemplos/citações (vai pro KB)
- ❌ Mudança é superficial/estilística
- ❌ Nova fonte confirma o que já sabia

#### 4.2 Incremental Update (Se necessário)

```bash
# NÃO criar prompt novo do zero
# Editar prompt existente com changelog

# Exemplo:
## CHANGELOG
### v1.2 - 2025-10-04
- Added: Recognition pattern "X" from [source]
- Updated: Core obsession #2 intensity (7→9)
- Fixed: Contradiction in decision criteria
```

#### 4.3 Version Bump

```bash
# Versão anterior: 20250928-1800-v1.1-generalista.md
# Nova versão:    20251004-2100-v1.2-generalista.md

# Manter versão antiga para rollback
```

---

### PASSO 5: Documentation Update

**Objetivo:** Manter docs sincronizados com mudanças

#### 5.1 Atualizar Docs Afetados

```bash
# docs/README.md
# - Atualizar "Last Update"
# - Adicionar nota sobre nova fonte

# docs/LIMITATIONS.md
# - Remover gaps que foram preenchidos
# - Adicionar novos gaps descobertos

# docs/TODO.md
# - Marcar itens concluídos
# - Adicionar novos action items
```

#### 5.2 Brownfield Log Entry

```bash
cat >> docs/logs/$(date +%Y%m%d-%H%M)-brownfield_complete.md <<EOF
# Brownfield Update Complete

## What Changed
- Sources: +2 interviews (2015-2018 gap filled)
- KB: +12 chunks (total: 54)
- Artifacts: behavioral_patterns.md updated
- System Prompt: v1.1 → v1.2 (added pattern X)

## Tests Passed
- ✅ Personality consistency
- ✅ Knowledge retention
- ✅ No regressions detected

## Remaining Gaps
- [Gap 1 ainda existe]
- [Gap 2 descoberto]
EOF
```

---

### PASSO 6: Human Checkpoint

**Decisão final antes de production:**

```yaml
# brownfield_checkpoint.yaml

reviewer: "[Nome]"
date: "YYYY-MM-DD"

review_areas:
  - area: "Source quality"
    status: "approved" # approved | changes_requested | rejected
    notes: ""

  - area: "Consistency maintained"
    status: "approved"
    notes: ""

  - area: "No regressions"
    status: "approved"
    notes: ""

decision: "approved" # approved | revise | rollback
```

**SE APPROVED:**
```bash
# Deploy nova versão
# Mover backup para archive
# Atualizar production
```

**SE REVISE:**
```bash
# Voltar ao passo com problema
# Corrigir e re-testar
```

**SE ROLLBACK:**
```bash
# Restaurar do backup
# Documentar por que falhou
# Re-planejar abordagem
```

---

## 📊 Brownfield vs Greenfield - Comparison

| Aspecto | Greenfield (Novo) | Brownfield (Update) |
|---------|-------------------|---------------------|
| **Tempo** | 10-20 dias | 2-5 dias |
| **Escopo** | Pipeline completo | Steps seletivos |
| **Risk** | Baixo (começar limpo) | Médio (quebrar existente) |
| **Testing** | Validação inicial | Regression + New |
| **Docs** | Criar do zero | Merge incremental |
| **Backup** | Não necessário | **OBRIGATÓRIO** |

---

## ⚠️ Armadilhas Comuns (Evite)

### ❌ DON'T: Reprocessar Tudo

```bash
# ❌ ERRADO - Vai perder trabalho anterior
rm -rf artifacts/
rm -rf kb/
# Executar pipeline do zero
```

```bash
# ✅ CORRETO - Incremental
# Apenas adicionar/modificar arquivos específicos
# Manter histórico e versionamento
```

### ❌ DON'T: Ignorar Testes de Regressão

```bash
# ❌ ERRADO - Deploye sem testar
# "Parece ok, vou subir"
```

```bash
# ✅ CORRETO - Sempre teste antes/depois
# Documente mudanças de comportamento
# Valide com casos de teste anteriores
```

### ❌ DON'T: Sobrescrever Sem Backup

```bash
# ❌ ERRADO
cp new_file.md artifacts/critical_file.md
# Se der errado, perdeu tudo
```

```bash
# ✅ CORRETO
cp artifacts/critical_file.md artifacts/critical_file.md.bak
cp new_file.md artifacts/critical_file.md
# Agora tem rollback
```

---

## 🎯 Checklist Brownfield

### Pre-Update
- [ ] Backup completo criado
- [ ] Docs existentes lidos
- [ ] Plano de atualização escrito
- [ ] Escopo definido (incremental/refactor/overhaul)

### During Update
- [ ] Novas fontes adicionadas a `/sources/`
- [ ] `sources_master.yaml` atualizado
- [ ] Análise incremental (não full)
- [ ] KB chunks numerados corretamente
- [ ] Artifacts mergeados (não sobrescritos)

### Testing
- [ ] Regression tests rodados
- [ ] Consistency check passou
- [ ] Comparação before/after documentada
- [ ] Edge cases re-testados

### Finalization
- [ ] System prompt versionado (se atualizado)
- [ ] Docs atualizados
- [ ] Changelog completo
- [ ] Human checkpoint aprovado

---

## 📚 Exemplo Prático

### Cenário: Adicionar Nova Entrevista a Mind Existente

```bash
# 1. BACKUP
cp -r minds/naval_ravikant minds/BACKUP_naval_20251004

# 2. ADD SOURCE
cp "Naval_Podcast_2023.md" minds/naval_ravikant/sources/interviews/

# 3. UPDATE INVENTORY
# Edit sources_master.yaml - add new interview

# 4. INCREMENTAL ANALYSIS
# Execute APENAS:
# - 01_source_reading.md (nova entrevista)
# - 01_quote_extraction.md (nova entrevista)
# - Compare com behavioral_patterns.md existente

# 5. UPDATE KB
# Criar chunks 043-048 com novo material
# Atualizar kb/index.md

# 6. REGRESSION TEST
# Testar mesmas perguntas que v1.1
# Documentar se comportamento mudou

# 7. DECISION
# Se consistente → Aprovar
# Se quebrou → Rollback e revisar

# 8. DEPLOY
# Se aprovado, mover backup para archive
```

---

## 🔗 Referências

- **Greenfield Workflow:** `mmos/README.md` (pipeline completo)
- **Testing Protocol:** `mmos/6_testing/`
- **MIND_BRIEF Template:** `mmos/docs/templates/MIND_BRIEF.md`
- **COGNITIVE_SPEC Template:** `mmos/docs/templates/COGNITIVE_SPEC.md`

---

**Filosofia Brownfield:** *"Preserve o que funciona. Melhore incrementalmente. Teste obsessivamente. Documente tudo."*
