# Guia Rápido de Prompts - NotebookLM

## Prompts Essenciais

### 🔍 EXTRAÇÃO

```
Liste todas as [estatísticas/empresas/pessoas/ferramentas] mencionadas

Extraia os passos do processo descrito

Quais são os [números/dados/métricas] mais importantes?
```

### 📝 SÍNTESE

```
Resuma em 3 parágrafos: contexto, pontos principais, conclusões

Quais são os 5 pontos-chave deste documento?

Condense as recomendações em uma lista de ações
```

### ⚖️ COMPARAÇÃO

```
Compare as abordagens de [Source A] e [Source B] sobre [tema]

Onde os autores concordam? Onde discordam?

Quais são as diferenças entre os modelos descritos?
```

### 🎯 APLICAÇÃO

```
Como posso aplicar isso no meu [contexto específico]?

Crie um plano de ação baseado nas recomendações

Adapte essa estratégia para [situação específica]
```

### 🧠 ANÁLISE CRÍTICA

```
Quais são os pontos fracos do argumento?

O que está faltando nesta análise?

Quais premissas o autor assume sem provar?
```

---

## Prompts para Outputs

### 🎧 AUDIO OVERVIEW

```
Focus on practical applications for [público]

Tone should be [formal/casual/investigative]

Emphasize [aspecto específico], skip [o que evitar]

Create for [beginner/advanced] audience
```

### 📊 EXECUTIVE SUMMARY

```
Create an executive summary (1 page):
1. SITUATION (2-3 sentences)
2. KEY FINDINGS (3-5 bullets)
3. IMPLICATIONS (2-3 bullets)
4. RECOMMENDATIONS (2-3 bullets)
5. BOTTOM LINE (1 sentence)
```

### 🗺️ MIND MAP

```
Create a 3-level mind map:
Level 1: Main themes (3-5)
Level 2: Key concepts
Level 3: Details

Format as indented bullet points
```

### ❓ FAQ

```
Generate 15 FAQ questions:
- 5 basic (what, who, when)
- 5 conceptual (why, how)
- 5 application (how to use)

Format:
Q: [Question]
A: [2-3 sentence answer]
```

### 📚 STUDY GUIDE

```
Create study guide:
1. Learning Objectives (5-7)
2. Key Concepts (10-15 definitions)
3. Topic Summaries (1 paragraph each)
4. Review Questions (10 with answers)
5. Quick Reference (1-page cheat sheet)
```

### 🃏 FLASHCARDS

```
Create 20 flashcards:
---
FRONT: [Term or question]
BACK: [Definition or answer]
CATEGORY: [Topic]
---

For Anki export:
Format as CSV: question;answer;tags
```

### 📑 APRESENTAÇÃO

```
Create presentation outline (10-12 slides):

For each slide:
- TITLE
- KEY POINTS (3-4 bullets max)
- SPEAKER NOTES (2-3 sentences)
- VISUAL SUGGESTION
```

---

## Prompts para Casos de Uso

### 🔎 INTELIGÊNCIA COMPETITIVA

```
Analyze [Competitor]'s positioning:
1. Target Audience
2. Value Proposition
3. Key Messages
4. Tone & Personality
5. Gaps/Weaknesses
```

### ✍️ CRIAÇÃO DE CONTEÚDO

```
Generate 20 content ideas:
- HEADLINE: Compelling title
- ANGLE: Unique perspective
- FORMAT: Best format (article, video, etc)
- HOOK: Opening line
```

### 🎬 ANÁLISE DE VÍDEO

```
Create structured summary:
1. Overview (topic, speakers, context)
2. Key Points (in order)
3. Memorable Quotes
4. Actionable Takeaways
5. Related Topics to Explore
```

---

## Ajustes Rápidos

### Tom e Estilo

```
Make more formal → "Rewrite in formal corporate language"
Make more casual → "Rewrite as if explaining to a friend"
Make shorter → "Condense to [X] words without losing key points"
Make more detailed → "Expand with specific examples"
```

### Público

```
For executives → "Focus on strategic implications and ROI"
For beginners → "Explain simply, avoid jargon"
For technical audience → "Add technical depth and terminology"
```

### Formato

```
As bullet points → "Format as bullet points"
As table → "Present as comparison table"
As checklist → "Convert to actionable checklist"
As timeline → "Organize chronologically"
```

---

## Template Universal

```
[ACTION] about [TOPIC] from these sources.

Structure:
[DESIRED STRUCTURE]

Audience: [WHO]
Tone: [HOW]
Length: [HOW MUCH]

Include: [WHAT TO ADD]
Avoid: [WHAT TO SKIP]
```

**Exemplo completo:**
```
Create an executive briefing about market trends.

Structure:
- Overview (2 paragraphs)
- Key Trends (5 bullets with data)
- Implications (3 bullets)
- Recommended Actions (3 bullets)

Audience: Marketing leadership
Tone: Professional but accessible
Length: 2 pages maximum

Include: Statistics and specific examples
Avoid: Technical jargon, speculation
```

---

## Dicas de Ouro

1. **Seja específico** → Quanto mais detalhado o prompt, melhor o output

2. **Use inglês** → Prompts em inglês geralmente funcionam melhor

3. **Itere** → Não gostou? Refine e peça novamente

4. **Salve os bons** → Mantenha arquivo com prompts que funcionaram

5. **Combine** → Misture tipos para outputs mais ricos

---

**Quick Reference Card** 📋

```
EXTRAÇÃO   → "Liste/Extraia/Quais são..."
SÍNTESE    → "Resuma/Condense/Pontos-chave..."
COMPARAÇÃO → "Compare/Diferenças/Concordam..."
APLICAÇÃO  → "Como aplicar/Plano de ação..."
ANÁLISE    → "Pontos fracos/Faltando/Premissas..."
```
