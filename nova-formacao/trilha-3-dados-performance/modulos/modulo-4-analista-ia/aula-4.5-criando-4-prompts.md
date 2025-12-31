# Aula 4.5: Criando 4 Prompts de Análise

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 4 - Analista de Dados com IA |
| **Aula** | 4.5 |
| **Tipo** | Demo |
| **Duração** | 15 minutos |
| **Conceitos** | 2 (4 prompts base + Estrutura de prompt) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter 4 prompts prontos — um pra cada tipo de análise que você precisa.**
>
> Você vai poder copiar, colar e usar imediatamente.

---

## 🗺️ P - POSITION (Origem)

> "Como faço pra IA analisar meus dados?"
>
> Com prompts bem estruturados.
>
> Vou te dar os 4 que uso.
>
> Você vai adaptar pro seu negócio.

---

## 🛤️ S - STEPS (Rota)

### Estrutura de um Bom Prompt

```
[DIAGRAMA: Anatomia do Prompt]

┌─────────────────────────────────────────────────┐
│  1. CONTEXTO                                    │
│  "Você é um analista de dados especializado..." │
├─────────────────────────────────────────────────┤
│  2. DADOS                                       │
│  "Aqui estão os dados: [dados]"                 │
├─────────────────────────────────────────────────┤
│  3. TAREFA                                      │
│  "Analise e me diga..."                         │
├─────────────────────────────────────────────────┤
│  4. FORMATO                                     │
│  "Responda em formato X com Y itens"            │
└─────────────────────────────────────────────────┘
```

---

### Prompt 1: Análise de Performance

**Quando usar:** Diariamente ou semanalmente, pra saber se está no caminho da meta.

```
## PROMPT: ANÁLISE DE PERFORMANCE

Você é meu analista de performance.

DADOS DO PERÍODO:
[Cole seus dados - faturamento, conversão, etc.]

META DO PERÍODO:
- Faturamento: R$ [X]
- [Outras metas]

ANALISE:
1. Qual o % da meta atingido até agora?
2. Estou no ritmo pra bater a meta até o fim do período?
3. Se não, quanto preciso melhorar?
4. Qual métrica está mais distante do esperado?

FORMATO:
- Resumo executivo (3 frases)
- Diagnóstico detalhado (bullets)
- 1 ação prioritária
```

**Exemplo de resposta esperada:**
> "Você está em 62% da meta no dia 18. Ritmo atual: 77% do necessário. Se mantiver esse ritmo, fecha em R$77K (meta R$100K). Prioridade: aumentar conversão de trial em 3 pontos percentuais."

---

### Prompt 2: Análise Investigativa

**Quando usar:** Quando algo deu errado e você quer entender por quê.

```
## PROMPT: ANÁLISE INVESTIGATIVA

Você é meu analista investigativo.

O PROBLEMA:
[Descreva o que aconteceu - ex: "churn dobrou essa semana"]

DADOS RELEVANTES:
[Cole dados do período atual e anterior]

INVESTIGUE:
1. Quais são as possíveis causas?
2. O que mudou em relação ao período anterior?
3. Qual causa é mais provável baseado nos dados?
4. Que informação adicional eu precisaria pra confirmar?

FORMATO:
- 3-5 hipóteses ranqueadas por probabilidade
- Evidências que suportam cada uma
- Próximos passos pra validar
```

**Exemplo de resposta esperada:**
> "Hipótese 1 (70% provável): Mudança de preço impactou renovações. Evidência: 80% dos churns são de clientes no plano que aumentou. Validação: checar se clientes citaram preço no cancelamento."

---

### Prompt 3: Análise Preditiva

**Quando usar:** Pra projetar futuro e planejar.

```
## PROMPT: ANÁLISE PREDITIVA

Você é meu analista de projeções.

DADOS HISTÓRICOS:
[Cole dados dos últimos 3-6 meses]

CENÁRIO ATUAL:
[Dados do mês atual até agora]

PROJETE:
1. Qual a projeção de fechamento do mês?
2. Qual a probabilidade de bater a meta?
3. Se eu [ação específica], como muda a projeção?
4. Qual o cenário otimista, realista e pessimista?

FORMATO:
- Projeção base com % de confiança
- 3 cenários (otimista, realista, pessimista)
- 1 alavanca que mais impacta o resultado
```

**Exemplo de resposta esperada:**
> "Projeção base: R$82K (82% da meta). Confiança: 75%. Cenário otimista: R$95K (se conversão subir 5pp). Alavanca principal: número de trials. +20 trials = +R$12K potenciais."

---

### Prompt 4: Análise Comparativa

**Quando usar:** Pra entender evolução e tendências.

```
## PROMPT: ANÁLISE COMPARATIVA

Você é meu analista de tendências.

PERÍODO 1 (ANTERIOR):
[Dados do período anterior]

PERÍODO 2 (ATUAL):
[Dados do período atual]

COMPARE:
1. Quais métricas melhoraram e quanto?
2. Quais métricas pioraram e quanto?
3. Qual a tendência geral (melhorando, estagnando, piorando)?
4. O que explica as maiores mudanças?

FORMATO:
- Tabela comparativa (antes/depois/variação %)
- Top 3 melhorias
- Top 3 pioras
- Diagnóstico de tendência
```

**Exemplo de resposta esperada:**
> "Faturamento: +15% (ótimo). Ticket médio: -8% (preocupante). Tendência geral: crescimento com perda de qualidade. Explicação: mais vendas de plano básico diluíram o ticket."

---

### 🤔 Pergunta Reflexiva

> "Qual desses 4 prompts você mais precisa usar amanhã?"
>
> Comece por esse. Os outros podem esperar.

---

### Dica: Salve Seus Prompts

```
[DIAGRAMA: Biblioteca de Prompts]

┌─────────────────────────────────────────────────┐
│  📁 PASTA: Prompts de Análise                   │
├─────────────────────────────────────────────────┤
│  📄 01-performance.txt                          │
│  📄 02-investigativa.txt                        │
│  📄 03-preditiva.txt                            │
│  📄 04-comparativa.txt                          │
│  📄 00-contexto-negocio.txt                     │
└─────────────────────────────────────────────────┘

→ Sempre começar colando o contexto
→ Depois colar o prompt específico
→ Por fim, os dados
```

---

## 💡 Revisão

**Os 2 Insights:**

1. **4 prompts cobrem 90% das análises** — Performance, Investigativa, Preditiva, Comparativa.

2. **Estrutura importa mais que criatividade** — Contexto + Dados + Tarefa + Formato = resposta útil.

**A Transformação:**
- **Antes:** "Não sei como perguntar pra IA"
- **Depois:** "Tenho prompts prontos pra cada situação"

---

## ⚡ AÇÃO RÁPIDA (3 min)

**Faça agora:**
1. Escolha 1 dos 4 prompts
2. Copie e adapte pro seu negócio
3. Salve num arquivo .txt ou Google Doc

**Funcionou se:** Você tem pelo menos 1 prompt salvo e adaptado.

---

## 🎬 HOOK - Próxima Aula

> Você tem os prompts.
>
> Agora precisa CALIBRAR.
>
> Na próxima aula, você vai testar seus prompts com dados reais e ajustar até funcionarem perfeitamente.
>
> **Próxima aula: 4.6 - Seu Turno: Calibre Seus Prompts**

---

*Aula 4.5 - Trilha 3 - Academia Lendária*
