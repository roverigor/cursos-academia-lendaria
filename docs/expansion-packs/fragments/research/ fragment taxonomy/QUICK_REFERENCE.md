# FRAGMENT TAXONOMY - QUICK REFERENCE CARD
# Cheat Sheet de Uma Página - Imprima e Mantenha à Mão!

version: 1.0 | MMOS v5.0 | 2025-01-26

## ⚡ CATEGORIAS (8)

```
BIO     História/formação        M1    exemplo: "Nasci em Maricá"
COG     Como pensa/decide        M2    exemplo: "Decisões são processos"
COM     Como comunica            M3    exemplo: "Usa metáforas técnicas"
BEH     O que faz (ações)        M4    exemplo: "Acorda às 5h"
VAL     Valores/crenças          M5    exemplo: "Honestidade > conforto"
SOC     Relacionamentos          M6    exemplo: "Mentor: Feynman"
META    Contradições/evolução    M7    exemplo: "Mudou de ideia sobre X"
VAL_SRC Validação de fontes      M8    exemplo: "Citação famosa"
```

## 📝 TIPOS DE CONTEÚDO (8)

```
QUOTE      "Palavras exatas"           Precisa aspas + fonte
PARA       Mesma ideia, suas palavras  Sem aspas
DESC       Alguém descrevendo          Terceiros
EXAMPLE    Caso específico             Ilustração
PATTERN    Observado múltiplas vezes   Síntese
ANECDOTE   História narrada            Evento
ANALYSIS   Você analisa                Interpretação
SYNTHESIS  Múltiplas fontes            Consolidação
```

## 📊 PROFUNDIDADE (4)

```
SURFACE  ═══  Fatos básicos    exemplo: "CEO da empresa X"
    ↓
INTERMEDIATE ═══  Contexto     exemplo: "Fundou após 3 anos pesquisando"
    ↓
DEEP     ═══  Insights         exemplo: "Motivação veio de trauma anterior"
    ↓
CORE     ═══  Identidade       exemplo: "No centro, acredita que..."
```

## 🎯 ESPECIFICIDADE (4)

```
GENERIC          Qualquer pessoa
CHARACTERISTIC   Característico mas não único
SIGNATURE        Quase único desta pessoa
UNIQUE           Completamente único
```

## 📚 FONTE (3)

```
PRIMARY    (1.0)  Pessoa falando/escrevendo  → alta confiança
SECONDARY  (0.8)  Fonte confiável sobre      → média confiança
TERTIARY   (0.6)  Compilação                 → baixa confiança
```

## 🧮 FÓRMULAS

### Confidence (0.0-1.0)
```
C = (Source×0.4) + (Verif×0.3) + (Consist×0.2) + (Espec×0.1)

Exemplo:
  PRIMARY (1.0) + Corroborado (0.9) + Consistente (0.8) + SIGNATURE (0.9)
  = (1.0×0.4) + (0.9×0.3) + (0.8×0.2) + (0.9×0.1)
  = 0.4 + 0.27 + 0.16 + 0.09
  = 0.92  ← ALTA ✓
```

### Overall Quality (1.0-10.0)
```
Q = Mean([Relevance, Specificity, Authenticity, Verifiability])

Thresholds:
  ≥ 8.5  EXCEPTIONAL ★★★  (salvar + marcar)
  ≥ 7.0  GOOD       ★★   (salvar)
  ≥ 6.0  ACCEPTABLE ★    (revisar depois)
  < 6.0  POOR       ✗    (melhorar ou descartar)
```

## ✅ CAMPOS OBRIGATÓRIOS (12)

```
[ ] fragment_id          FRAG_XXX_###
[ ] created_at           ISO 8601
[ ] primary_category     BIO|COG|COM|BEH|VAL|SOC|META|VAL_SRC
[ ] content_type         QUOTE|PARA|DESC|EXAMPLE|etc
[ ] source.source_id     SRC_###
[ ] source.quality       PRIMARY|SECONDARY|TERTIARY
[ ] content.text         (>10 palavras)
[ ] insights             (≥1)
[ ] quality_metrics      (all 4 + overall)
[ ] confidence           (0.0-1.0)
[ ] keywords             (≥2)
[ ] tags                 (≥1)
```

## 🚦 QUALITY GATES

```
MINIMUM (Gate 1):
  ✓ Campos obrigatórios preenchidos
  ✓ Overall ≥ 6.0
  ✓ Confidence ≥ 0.40

GOOD (Gate 2):
  ✓ Passa Gate 1
  ✓ Overall ≥ 7.0
  ✓ Confidence ≥ 0.70
  ✓ Cross-referenced

EXCEPTIONAL (Gate 3):
  ✓ Passa Gate 2
  ✓ Overall ≥ 8.5
  ✓ Confidence ≥ 0.85
  ✓ Specificity ≥ SIGNATURE
```

## 🌳 DECISION TREE (30s)

```
Sobre o QUÊ?
├─ Vida/história? → BIO
├─ Como pensa? → COG
├─ Como fala? → COM
├─ O que faz? → BEH
├─ Em que acredita? → VAL
├─ Relações? → SOC
├─ Contradição? → META
└─ Validar? → VAL_SRC

COMO obtive?
├─ Palavras EXATAS? → QUOTE
├─ Vi MÚLTIPLAS? → PATTERN
├─ Várias FONTES? → SYNTHESIS
├─ Estou ANALISANDO? → ANALYSIS
├─ É HISTÓRIA? → ANECDOTE
├─ CASO específico? → EXAMPLE
├─ Alguém DESCREVENDO? → DESC
└─ Senão → PARA
```

## 💡 DICAS RÁPIDAS

```
✅ FAÇA:
  • Valide ENQUANTO cria
  • Use templates prontos
  • Capture contexto completo
  • Extraia 3+ insights
  • Cross-referencie
  
❌ NÃO FAÇA:
  • Inventar informação
  • Salvar Overall < 6.0
  • Keywords genéricos
  • Esquecer localização
  • Ignorar contradições
```

## 📈 BENCHMARKS

```
POR FRAGMENTO:
  Target: Overall ≥ 7.5, Confidence ≥ 0.75

POR KB:
  Cobertura:     70+ / 87 questions (80%+)
  Qualidade:     Average overall ≥ 7.5
  Confiança:     Average confidence ≥ 0.75
  Padrões:       15+ cognitive signatures
  Detective:     Score ≥ 85%
```

## ⏱️ TEMPO ESTIMADO

```
1 Entrevista (2h):     4-6h    → 15-25 fragments
1 Livro (200p):        20-30h  → 50-100 fragments
1 Artigo curto:        1-2h    → 5-10 fragments
Validação Detective:   2-3h    → Report completo
```

## 🆘 TROUBLESHOOTING

```
Confidence baixa?
  → Revise fórmula, aceite se fonte fraca

Overall < 6.0?
  → Adicione contexto + insights OU descarte

Gaps não diminuem?
  → Busque fontes "ricas" nos gaps específicos

Não sei categoria?
  → Use decision tree acima (30s)
```

## 📚 DOCUMENTOS

```
executive_summary.md      ⭐ Comece aqui (10 min)
practical_guide.md        ⭐ Workflows (30 min)
fragment_templates.yaml   ⭐ Templates (20 min)
validation_checklist.md   ⭐ Validação (20 min)
fragment_taxonomy.yaml    ⭐ Spec completa (60 min)
```

## 🎯 EXEMPLO MÍNIMO

```yaml
fragment_id: FRAG_BIO_001
created_at: 2025-01-26T14:00:00Z
classification:
  primary_category: BIO
  subcategory: origem_familia
  content_type: QUOTE
  depth_level: SURFACE
  specificity: CHARACTERISTIC
source:
  source_id: SRC_001
  quality: PRIMARY
content:
  type: QUOTE
  text: "Nasci em Maricá..."
insights:
  - "Nascimento em Maricá (RJ)"
quality_metrics:
  overall: 8.75
confidence: 0.95
keywords: [origem, maricá]
tags: [origem, família_nuclear]
```

## 🚀 PRÓXIMOS PASSOS

```
1. Copie template de fragment_templates.yaml
2. Preencha campos obrigatórios (12)
3. Valide com checklist (pass ≥ 80%)
4. Salve e continue!
```

---

**v5.0 | Production Ready | Alan @ Academia Lendár[IA] | 2025-01-26**

*Imprima este cartão e mantenha visível enquanto trabalha!*
