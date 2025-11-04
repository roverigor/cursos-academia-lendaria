# Sistemas Modulares de Limpeza de Conteúdo Web

**Data:** 2025-10-04
**Contexto:** Após audit da coleta Naval Ravikant, descobrimos 13/28 arquivos com problemas
**Solução:** 3 scripts modulares + 1 pipeline completo

---

## 🔍 PROBLEMAS IDENTIFICADOS

### Audit Report (Naval Ravikant)
- **Total arquivos:** 28 markdown
- **Arquivos com problemas:** 13 (46%)
- **Tipos de problemas:**
  - JavaScript/CSS inline (1 arquivo)
  - HTML entities não convertidos (6 arquivos)
  - Tags HTML preservadas (4 arquivos)
  - Arquivos muito pequenos/vazios (2 arquivos)

### Exemplos de Problemas

#### Problema 1: JavaScript/CSS Inline
```html
var gform;gform||(document.addEventListener(...
<style>.wp-block-navigation{position:relative;...
```
❌ Arquivo totalmente inutilizável

#### Problema 2: HTML Entities
```
We&#8217;re going to talk...
"How to Get Rich&#8221;...
&nbsp;&nbsp;
```
⚠️ Dificulta leitura e processamento

#### Problema 3: Tags HTML
```
<p><strong>Naval:</strong> The how to get rich...</p>
<div class="content">...</div>
```
⚠️ Deveria ser Markdown

#### Problema 4: Arquivos Vazios
```
# Meaning

**Source:** nav.al/meaning

---
[200 bytes total - sem conteúdo real]
```
❌ Extração falhou completamente

---

## 🛠️ SISTEMAS MODULARES CRIADOS

### Sistema 1: extract-main-content.sh

**Função:** Extrair apenas conteúdo principal do HTML

**Estratégias (em ordem):**
1. Procura tag `<article>`
2. Procura tag `<main>`
3. Procura classes comuns (`.entry-content`, `.post-content`)
4. Fallback: extrai todos `<p>` (parágrafos)

**Uso:**
```bash
./mmos/scripts/universal/extract-main-content.sh input.html output.html
```

**Output:** HTML limpo (sem nav, header, footer, sidebar)

**Quando usar:**
- Páginas com muito HTML estrutural
- Blogs com navegação complexa
- Sites com muitos sidebars

---

### Sistema 2: clean-html-content.sh

**Função:** Converter HTML limpo em Markdown e remover lixo

**Pipeline de Limpeza:**
1. **Remove scripts/styles** - JavaScript, CSS inline
2. **Converte tags para MD** - `<h1>` → `#`, `<strong>` → `**`
3. **Limpa entities** - `&#8217;` → `'`, `&nbsp;` → espaço
4. **Formata whitespace** - Remove linhas vazias excessivas

**Uso:**
```bash
./mmos/scripts/universal/clean-html-content.sh input.html output.md
```

**Output:** Markdown limpo e formatado

**Quando usar:**
- Após extrair conteúdo principal
- HTML já sem navegação mas com tags
- Qualquer HTML→MD conversion

---

### Sistema 3: html-to-md.sh

**Função:** Conversão HTML→MD simples (já existia, mantido)

**Diferença vs clean-html-content.sh:**
- **html-to-md.sh:** Simples, rápido, sem extração inteligente
- **clean-html-content.sh:** Completo, remove JS/CSS, verifica qualidade

**Uso:**
```bash
./mmos/scripts/universal/html-to-md.sh input.html output.md
```

**Quando usar:**
- HTML já limpo
- Conversão rápida
- Não precisa de validação

---

### Sistema 4: fetch-and-clean.sh (PIPELINE COMPLETO)

**Função:** Download + Extração + Limpeza + Metadata em um comando

**Pipeline Completo:**
```
URL → curl → extract-main-content → clean-html-content → add metadata → output.md
```

**Uso:**
```bash
./mmos/scripts/universal/fetch-and-clean.sh \
  "https://tim.blog/transcript/" \
  "transcript.md" \
  "Tim Ferriss Transcript"
```

**Output:** Markdown pronto com:
- Header metadata (URL, data, título)
- Conteúdo limpo
- Footer com info de processamento
- Verificação de qualidade

**Quando usar:**
- Coletar qualquer conteúdo web
- Automação completa
- Garantir qualidade desde início

---

## 📋 MATRIZ DE DECISÃO

| Cenário | Ferramenta | Por Quê |
|---------|-----------|---------|
| Download + clean tudo | fetch-and-clean.sh | Pipeline completo |
| Já tem HTML, só extrair conteúdo | extract-main-content.sh | Extração inteligente |
| HTML limpo, converter p/ MD | clean-html-content.sh | Limpeza + conversão |
| HTML simples, conversão rápida | html-to-md.sh | Rápido e direto |
| HTML com muito JS/CSS | extract-main → clean-html | Remoção agressiva |
| Múltiplos URLs | Loop com fetch-and-clean | Batch processing |

---

## 🔧 ARQUITETURA MODULAR

### Por Que Modular?

**Problema Anterior:**
- Script monolítico faz tudo
- Difícil debugar onde falha
- Não reutilizável
- Difícil testar

**Solução Modular:**
```
fetch-and-clean.sh (orchestrator)
    ↓
    ├─> curl (download)
    ├─> extract-main-content.sh (extraction)
    ├─> clean-html-content.sh (cleaning)
    └─> metadata addition
```

**Benefícios:**
1. **Testável** - Cada módulo isolado
2. **Debugável** - Vê output intermediário
3. **Reutilizável** - Combina de formas diferentes
4. **Manutenível** - Atualiza um módulo sem quebrar outros

### Exemplo de Composição

```bash
# Uso 1: Pipeline completo
./fetch-and-clean.sh URL output.md "Title"

# Uso 2: Apenas extração (já tem HTML)
./extract-main-content.sh page.html main.html
./clean-html-content.sh main.html output.md

# Uso 3: Batch com múltiplos URLs
for url in "${urls[@]}"; do
  ./fetch-and-clean.sh "$url" "output_$(basename $url).md"
done

# Uso 4: Custom pipeline
curl -s "$URL" > raw.html
./extract-main-content.sh raw.html main.html
# [processar main.html com outro script]
./clean-html-content.sh main.html final.md
```

---

## 🧪 TESTES E VALIDAÇÃO

### Testes Implementados

Cada script faz auto-validação:

**extract-main-content.sh:**
```bash
if [ $size -lt 100 ]; then
    echo "⚠️  Extraction failed - content too small"
    exit 1
fi
```

**clean-html-content.sh:**
```bash
if grep -q '<script\|<style\|var gform' "$output"; then
    echo "⚠️  WARNING: Output still contains HTML/JS"
    exit 1
fi
```

**fetch-and-clean.sh:**
```bash
# Verification
if grep -q '<script\|var gform' "$OUTPUT"; then
    echo "⚠️  WARNING: Still contains JS - manual review needed"
elif [ $final_size -lt 1000 ]; then
    echo "⚠️  WARNING: Very small file - may need review"
else
    echo "✅ Quality check passed"
fi
```

### Casos de Teste

| Entrada | Esperado | Script | Status |
|---------|----------|--------|--------|
| tim.blog (JS heavy) | MD limpo | fetch-and-clean | ✅ Passa |
| nav.al (simples) | MD limpo | fetch-and-clean | ✅ Passa |
| HTML com entities | MD sem entities | clean-html-content | ✅ Passa |
| Página vazia | Exit code 1 | extract-main-content | ✅ Passa |

---

## 📊 COMPARAÇÃO: ANTES vs DEPOIS

### Antes (Coleta Inicial Naval)

**Processo:**
```
curl → sed simples → output
```

**Resultado:**
- 46% arquivos com problemas
- JavaScript inline preservado
- HTML entities não tratados
- Sem validação

### Depois (Sistema Modular)

**Processo:**
```
curl → extract-main → clean-html → validate → output
```

**Resultado Esperado:**
- 0% arquivos com JS/CSS
- 0% HTML entities
- 0% tags HTML preservadas
- 100% validados

---

## 🎯 APLICAÇÃO PRÁTICA

### Reprocessar Naval Ravikant

```bash
# Arquivos que precisam reprocessamento:
REPROCESS=(
  "tim_ferriss_788_full_transcript.md"
  "tim_ferriss_473_preview.md"
  "tim_ferriss_788_preview.md"
  "how_to_be_happy.md"
  "how_to_get_rich_compiled.md"
  "how_to_get_rich_full_transcript.md"
)

for file in "${REPROCESS[@]}"; do
  # Reconstrói URL original (se disponível em metadata)
  # Ou processa HTML baixado novamente
  ./fetch-and-clean.sh "$URL" "minds/naval_ravikant/sources/..." "$TITLE"
done
```

### Para Próximos Minds

**Agent Tasks devem incluir:**
```markdown
Instructions:
1. Search for sources
2. Download using fetch-and-clean.sh:
   ./mmos/scripts/universal/fetch-and-clean.sh URL output.md "Title"
3. Verify output (no JS/HTML)
4. Return file list with sizes
```

**Resultado:**
- Zero problemas de limpeza
- 100% markdown limpo
- Pronto para análise imediata

---

## 📚 DOCUMENTAÇÃO COMPLETA

### Localização dos Scripts

```
mmos/scripts/universal/
├── fetch-and-clean.sh          # Pipeline completo (USAR ESTE)
├── extract-main-content.sh      # Extração inteligente
├── clean-html-content.sh        # Limpeza + conversão
├── html-to-md.sh               # Conversão simples
├── convert-txt-to-md.sh        # TXT→MD
├── create-mind-structure.sh    # Criar estrutura
└── validate-mind.sh            # Validar conformidade
```

### Dependências

- `bash` 4.0+
- `curl`
- `sed`
- `grep`

Todos disponíveis por padrão em macOS/Linux.

### Permissões

```bash
chmod +x mmos/scripts/universal/*.sh
```

---

## 🚀 PRÓXIMOS PASSOS

### 1. Atualizar PARALLEL_COLLECTION_GUIDE.md
Adicionar seção sobre sistemas de limpeza

### 2. Reprocessar Arquivos Naval
Usar fetch-and-clean.sh para os 13 arquivos problemáticos

### 3. Criar Tests
Script de teste automatizado para validar pipelines

### 4. Agent Templates
Atualizar templates de agents para usar fetch-and-clean.sh

### 5. Monitoring
Script de audit contínuo para detectar problemas

---

## 💡 LIÇÕES APRENDIDAS

### Lição #1: Sempre Validar Output
**Antes:** Assumir que sed funcionou
**Depois:** Verificar tamanho, buscar padrões ruins

### Lição #2: Modularidade > Monólitos
**Antes:** Um script faz tudo
**Depois:** Múltiplos scripts compostos

### Lição #3: Exit Codes Importam
**Antes:** Scripts sempre retornam 0
**Depois:** exit 1 quando falha = automação detecta

### Lição #4: Estratégias Múltiplas
**Antes:** Um método de extração
**Depois:** 4 estratégias em fallback

### Lição #5: Self-Documenting Code
**Antes:** Comentários explicam o que faz
**Depois:** Nomes de funções são auto-explicativos

---

## 📈 MÉTRICAS DE SUCESSO

### Objetivos

- [ ] 0% arquivos com JavaScript inline
- [ ] 0% arquivos com HTML entities
- [ ] 0% arquivos com tags HTML
- [ ] 100% arquivos >1KB (conteúdo real)
- [ ] 100% arquivos validados automaticamente

### Como Medir

```bash
# Audit automático
./mmos/scripts/universal/audit-sources.sh mind_name

# Output:
# ✅ Clean files: 28/28 (100%)
# ❌ Problems: 0
# 📊 Average size: 45KB
# ✅ All files validated
```

---

**Criado:** 2025-10-04
**Status:** Sistemas prontos, pendente reprocessamento
**Próximo:** Atualizar guide e reprocessar Naval
