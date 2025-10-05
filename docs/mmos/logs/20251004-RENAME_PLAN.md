# Plano de Renomeação: clone_system → mmos | clones → minds

**Data**: 04/10/2025
**Objetivo**: Renomear sistematicamente todas as referências no projeto

---

## ✅ STATUS: Concluído

### Passos Executados:

1. ✅ Pastas renomeadas via git mv
2. ✅ 38 arquivos .md atualizados
3. ✅ 1 arquivo .sh atualizado
4. ✅ .gitignore atualizado
5. ✅ Validação completa

---

## 📋 Substituições Realizadas

### Pattern 1: Paths absolutos
```
clone_system/ → mmos/
clones/ → minds/
```

### Pattern 2: Referências textuais
```
"clone_system" → "mmos"
"Clone System" → "MMOS"
"mind_os" → "mmos"
"MindOS" → "MMOS"
"sistema de clones" → "sistema de minds"
```

### Pattern 3: Conceitos
```
"clone" → "mind" (quando apropriado)
"Clone" → "Mind" (quando apropriado)
```

---

## 📁 Arquivos Atualizados (38 .md + 1 .sh)

### Arquivos Críticos
- [x] README.md
- [x] .claude/CLAUDE.md
- [x] .gitignore

### Logs (38 arquivos)
- [x] logs/20251004-2054-CONSELHO_DOS_CLONES_NOMENCLATURA.md
- [x] logs/20251004-2041-ANALISE_BOAS_PRATICAS_AIOS.md
- [x] logs/20251004-1854-DESCOBERTA_CRITICA_AIOS.md
- [x] logs/20250929-2347-MIGRACAO_CLONES_COMPLETA.md
- [x] logs/20250929-2328-REORGANIZACAO_ETAPA3_COMPLETA.md
- [x] logs/20250929-2306-ANALISE_CRITICA_ALINHAMENTO.md
- [x] logs/20250929-2243-RESUMO_MUDANCAS_ESTRUTURA.md
- [x] logs/20250929-2240-DIVERGENCIAS_DNA_MENTAL.md
- [x] logs/20250929-2230-REORGANIZACAO_METODOLOGIA_COMPLETA.md
- [x] logs/20250929-2215-ANALISE_DOCS_JOAO.md
- [x] logs/20250929-2210-PRD_ATUALIZACAO_V1.3.md
- [x] logs/20250929-2156-CONFORMIDADE_CLONES_README.md
- [x] logs/20250929-2150-RELATORIO_FINAL_SESSAO.md
- [x] logs/20250929-2146-NAMING_CONVENTION_PADRONIZADA.md
- [x] logs/20250929-2127-PRD_REVISAO_COMPLETA.md
- [x] logs/20250929-2057-PADRONIZACAO_SYNTHESIS_PROMPTS.md
- [x] logs/20250929-2006-CRITICAL_PROMPTS_IMPLEMENTED.md
- [x] logs/20250928-2342-PLANO_RECUPERACAO_OTIMIZADO.md
- [x] logs/20250928-2317-INTEGRACAO_JOAO_LOZANO_COMPLETA.md
- [x] logs/20250928-2258-WORKSPACE_DELETADO.md
- [x] logs/20250928-2238-CLONES_PASTA_LIMPA.md
- [x] logs/20250928-2236-SCRIPTS_ORGANIZADOS.md
- [x] logs/20250928-2222-SISTEMA_LOGS_IMPLEMENTADO.md
- [x] logs/20250928-2220-LOGS_ORGANIZACAO.md
- [x] logs/20250928-2218-PADRONIZACAO_COMPLETA.md
- [x] logs/20250928-2218-ANALISE_ESTRUTURAL_CLONES.md

### MMOS Documentation
- [x] mmos/README.md
- [x] mmos/docs/AIOS_WORKFLOW.md
- [x] mmos/docs/DNA_MENTAL_METHODOLOGY.md
- [x] mmos/docs/FOLDER_STRUCTURE.md
- [x] mmos/docs/PRD.md
- [x] mmos/docs/PROMPT_ENGINEERING_GUIDE.md
- [x] mmos/1_viability/prompts/01_scorecard_apex.md

### Minds Documentation
- [x] minds/README.md
- [x] minds/naval_ravikant/docs/TODO.md
- [x] minds/pedro_valério/artifacts/Grok4Fast.md

### Scripts
- [x] mmos/scripts/universal/validate-logs.sh
- [x] mmos/scripts/universal/create-mind-structure.sh
- [x] mmos/scripts/universal/validate-mind.sh

---

## 🔍 Validações Pendentes

### 1. Links Internos
```bash
# Verificar se todos os links markdown funcionam
grep -r "\[.*\](.*clone_system\|.*clones/)" . --include="*.md"
```
✅ Concluído

### 2. Scripts Shell
```bash
# Verificar paths hardcoded em scripts
grep -r "clone_system\|clones/\|mind_os" . --include="*.sh"
```
✅ Concluído

### 3. Git Status
```bash
git status
# Verificar se mudanças foram staged corretamente
```
✅ Concluído

### 4. Estrutura de Pastas
```bash
ls -la | grep -E "(clone|mind)"
# Deve mostrar apenas mmos e minds
```
✅ Concluído - Mostra apenas mmos/ e minds/

---

## 🚨 Casos Especiais

### Preservados (NÃO renomeados):
- Nomes de arquivos de log históricos (20250928-CLONES_PASTA_LIMPA.md)
- Conteúdo de citações literais
- URLs externas
- Nomes próprios de pessoas

### Contexto-dependente:
- "clone" como verbo (clonar, clonagem) → mantido
- "clone" como conceito de IA → renomeado para "mind"
- "Clone System" como nome do sistema → "MMOS"
- "MindOS" → "MMOS"

---

## ✅ Checklist Final

- [x] Pastas físicas renomeadas (git mv)
- [x] README.md atualizado
- [x] .claude/CLAUDE.md atualizado
- [x] .gitignore atualizado
- [x] Todos os .md atualizados (40+ arquivos)
- [x] Scripts .sh atualizados (3 arquivos)
- [x] Links validados
- [x] Git status verificado
- [x] Commits criados (múltiplos)
- [x] Push para GitHub

---

## 📝 Execução Final

1. ✅ Validação de links internos
2. ✅ Scripts testados e atualizados
3. ✅ Git status verificado
4. ✅ Commits criados:
   - `73c421e` - Padronizar nomenclatura português → inglês
   - `9cab450` - Renomear pedro_valério → pedro_valerio
   - `7f4cda2` - Eliminar terminologia "clone" → "mind"
   - `b5707ec` - Atualizar últimas referências "clone" → "mind" em docs MMOS
5. ✅ Push para GitHub concluído

---

**Plano criado**: 04/10/2025
**Execução**: ✅ **CONCLUÍDO**
**Última atualização**: 04/10/2025
