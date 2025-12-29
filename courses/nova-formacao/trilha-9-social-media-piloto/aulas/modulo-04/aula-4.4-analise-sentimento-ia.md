# Aula 4.4: Analise de Sentimento com IA

## Trilha 9 - Social Media em Piloto | Modulo 4

---

> **Duracao:** 10 minutos
> **Tipo:** Teoria
> **Conceito:** Usando IA para classificar mencoes automaticamente

---

## GANCHO DE ABERTURA

**"IA pode ler 1.000 comentarios em 1 minuto e te dizer se sao positivos, negativos ou neutros. Voce leva horas. Veja como usar isso."**

---

## O QUE E ANALISE DE SENTIMENTO

### Definicao

Classificar automaticamente mencoes em:
- **Positivo** - Elogios, recomendacoes, satisfacao
- **Negativo** - Reclamacoes, criticas, insatisfacao
- **Neutro** - Perguntas, informacoes, mencoes neutras

### Por Que Importa

| Sentimento | Acao Recomendada |
|------------|------------------|
| Positivo | Agradecer, repostar, pedir case |
| Negativo | Responder rapido, resolver, escalar se grave |
| Neutro | Informar, educar, engajar |

---

## PROMPT PRINCIPAL DE ANALISE

### Prompt Basico

```
Analise o sentimento destas mencoes sobre [sua marca]:

MENCOES:
1. [Cole mencao 1]
2. [Cole mencao 2]
3. [Cole mencao 3]
...

PARA CADA MENCAO, CLASSIFIQUE:
1. Sentimento: Positivo / Negativo / Neutro
2. Intensidade: Baixa / Media / Alta
3. Urgencia: Responder agora / Pode esperar / Ignorar
4. Acao sugerida: [acao especifica]

RESUMO GERAL:
- Total positivos: X
- Total negativos: X
- Total neutros: X
- Sentimento predominante: [qual]
- Acao prioritaria: [qual]
```

### Prompt Avancado

```
Voce e um analista de social listening com expertise em [seu nicho].

CONTEXTO:
- Marca: [sua marca]
- Produtos: [seus produtos]
- ICP: [seu cliente ideal]
- Tom de voz: [seu tom]

MENCOES PARA ANALISAR:
[Cole todas as mencoes]

ANALISE DETALHADA:
Para cada mencao, forneca:

| # | Sentimento | Score (-10 a +10) | Urgencia | Topico | Acao |
|---|------------|-------------------|----------|--------|------|

INSIGHTS:
1. Temas recorrentes nas mencoes positivas
2. Temas recorrentes nas mencoes negativas
3. Oportunidades de conteudo identificadas
4. Riscos de reputacao detectados
5. Leads potenciais identificados

PRIORIDADES:
- Top 3 mencoes para responder primeiro
- Mencao com maior potencial de viralizar (positivo ou negativo)

SUGESTOES DE RESPOSTA:
Para as 3 mencoes prioritarias, sugira uma resposta.
```

---

## FLUXO DE TRABALHO COM IA

### Processo Semanal

```
1. COLETAR (15 min)
   Google Alerts → Email
   Busca manual → Planilha

2. CONSOLIDAR (5 min)
   Todas mencoes → Um documento

3. ANALISAR COM IA (5 min)
   Documento → ChatGPT/Claude
   Resposta → Dashboard

4. AGIR (20 min)
   Prioridades → Respostas
   Insights → Conteudo

TOTAL: 45 min/semana
```

---

## CATEGORIAS DE RESPOSTA

### Por Sentimento

| Sentimento | Resposta Tipo | Exemplo |
|------------|---------------|---------|
| Positivo | Agradecer + Ampliar | "Muito obrigado! Posso compartilhar seu feedback?" |
| Negativo | Reconhecer + Resolver | "Sinto muito por isso. Me chama no DM que resolvo." |
| Neutro | Informar + Engajar | "Boa pergunta! [resposta]. O que mais posso ajudar?" |

### Por Urgencia

| Urgencia | Tempo de Resposta | Acao |
|----------|-------------------|------|
| Alta | < 1 hora | Responder imediatamente |
| Media | < 24 horas | Responder no mesmo dia |
| Baixa | < 72 horas | Responder quando possivel |

---

## PROMPT IA: GERAR RESPOSTAS

```
Gere respostas para estas mencoes baseado no sentimento.

MENCOES E SENTIMENTOS:
1. [Mencao positiva] → Agradecer
2. [Mencao negativa] → Resolver
3. [Mencao neutra] → Informar

MEU TOM DE VOZ: [profissional/casual/amigavel]
MINHA MARCA: [nome]

PARA CADA RESPOSTA:
- Mantenha meu tom de voz
- Seja conciso (max 2 frases)
- Inclua CTA quando apropriado
- Personalize com nome se disponivel

FORMATO:
Mencao: [texto]
Sentimento: [classificacao]
Resposta sugerida: [resposta]
```

---

## METRICAS DE SENTIMENTO

### Dashboard Semanal

| Metrica | Esta Semana | Semana Anterior | Tendencia |
|---------|-------------|-----------------|-----------|
| Total mencoes | | | ↑↓→ |
| % Positivas | | | ↑↓→ |
| % Negativas | | | ↑↓→ |
| % Neutras | | | ↑↓→ |
| Tempo resposta (media) | | | ↑↓→ |
| Taxa resolucao negativas | | | ↑↓→ |

### Metas Recomendadas

- **70%+ positivas** = Marca saudavel
- **<10% negativas** = Sob controle
- **100% negativas respondidas em 24h**
- **Taxa resolucao > 80%**

---

## INSIGHT PRINCIPAL

> **"IA nao substitui sua empatia. Ela acelera a triagem. Voce ainda precisa responder como humano - mas agora sabe por onde comecar."**

---

## EXERCICIO RAPIDO

Pegue 3 comentarios reais do seu Instagram e:
1. Cole no ChatGPT com o prompt basico
2. Veja a classificacao
3. Use a resposta sugerida (ou adapte)

---

## CONEXAO COM PROXIMA AULA

Agora que voce sabe analisar sentimento, na proxima aula vamos criar seu Dashboard de Social Listening completo.

**Proxima Aula:** 4.5 - Template: Dashboard de Social Listening

---

**Tempo real:** 10 minutos
**Conceito:** IA para Analise de Sentimento
