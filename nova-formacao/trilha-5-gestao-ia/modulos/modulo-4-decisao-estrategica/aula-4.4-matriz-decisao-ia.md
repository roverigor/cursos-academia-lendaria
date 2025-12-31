# Aula 4.4: Matriz de Decisão + IA como Analista

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 4 - Decisão Estratégica com IA |
| **Aula** | 4.4 |
| **Tipo** | Ferramenta |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Matriz de decisão + Prompt de análise IA) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter uma matriz de decisão estruturada — e um prompt de IA para analisar cenários antes de decidir.**
>
> Ferramentas prontas para usar.

---

## 🗺️ P - POSITION (Origem)

> "Como comparo opções de forma objetiva?"
>
> Com matriz de decisão.
>
> E a IA pode te ajudar a ver ângulos que você não viu.
>
> Vou te dar as duas ferramentas.

---

## 🛤️ S - STEPS (Rota)

### A Matriz de Decisão

```
[DIAGRAMA: Estrutura da Matriz]

                  OPÇÃO A    OPÇÃO B    OPÇÃO C
                    │          │          │
                    ▼          ▼          ▼
┌────────────────┬──────────┬──────────┬──────────┐
│ CRITÉRIO 1     │   Nota   │   Nota   │   Nota   │
│ (Peso: X)      │   1-5    │   1-5    │   1-5    │
├────────────────┼──────────┼──────────┼──────────┤
│ CRITÉRIO 2     │   Nota   │   Nota   │   Nota   │
│ (Peso: X)      │   1-5    │   1-5    │   1-5    │
├────────────────┼──────────┼──────────┼──────────┤
│ CRITÉRIO 3     │   Nota   │   Nota   │   Nota   │
│ (Peso: X)      │   1-5    │   1-5    │   1-5    │
├────────────────┼──────────┼──────────┼──────────┤
│ CRITÉRIO 4     │   Nota   │   Nota   │   Nota   │
│ (Peso: X)      │   1-5    │   1-5    │   1-5    │
├────────────────┼──────────┼──────────┼──────────┤
│ TOTAL          │   Soma   │   Soma   │   Soma   │
│ PONDERADO      │ ponderada│ ponderada│ ponderada│
└────────────────┴──────────┴──────────┴──────────┘
                                │
                                ▼
                    OPÇÃO COM MAIOR NOTA VENCE
```

---

### Template de Matriz de Decisão

```markdown
# MATRIZ DE DECISÃO: [Título]

**Decisão:** [O que precisa ser decidido?]
**Deadline:** [Quando?]
**Decisor (D):** [Quem bate o martelo?]

---

## CRITÉRIOS DE AVALIAÇÃO

| # | Critério | Peso (1-3) | Descrição |
|---|----------|------------|-----------|
| 1 | ____________ | ___ | ____________ |
| 2 | ____________ | ___ | ____________ |
| 3 | ____________ | ___ | ____________ |
| 4 | ____________ | ___ | ____________ |
| 5 | ____________ | ___ | ____________ |

*Peso: 3 = muito importante | 2 = importante | 1 = secundário*

---

## OPÇÕES

| Opção | Descrição resumida |
|-------|-------------------|
| A: ________ | ____________ |
| B: ________ | ____________ |
| C: ________ | ____________ |

---

## AVALIAÇÃO (nota 1-5 por critério)

| Critério | Peso | Opção A | Opção B | Opção C |
|----------|------|---------|---------|---------|
| 1. ________ | ___ | ___ | ___ | ___ |
| 2. ________ | ___ | ___ | ___ | ___ |
| 3. ________ | ___ | ___ | ___ | ___ |
| 4. ________ | ___ | ___ | ___ | ___ |
| 5. ________ | ___ | ___ | ___ | ___ |

---

## CÁLCULO (Peso × Nota)

| Critério | Peso | A (P×N) | B (P×N) | C (P×N) |
|----------|------|---------|---------|---------|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |
| **TOTAL** | | **___** | **___** | **___** |

---

## RESULTADO

**Opção vencedora:** [A/B/C]
**Pontuação:** [X] pontos
**Decisão final:** [Confirmar ou ajustar?]
```

---

### Exemplo Preenchido

**Decisão:** Qual CRM adotar?

| Critério | Peso | HubSpot | Pipedrive | RD Station |
|----------|------|---------|-----------|------------|
| Custo mensal | 3 | 2 | 4 | 3 |
| Facilidade de uso | 3 | 4 | 5 | 4 |
| Integrações | 2 | 5 | 3 | 4 |
| Suporte | 1 | 4 | 3 | 5 |
| Escalabilidade | 2 | 5 | 3 | 4 |

**Cálculo:**

| Critério | Peso | HubSpot | Pipedrive | RD Station |
|----------|------|---------|-----------|------------|
| Custo | 3 | 6 | 12 | 9 |
| Usabilidade | 3 | 12 | 15 | 12 |
| Integrações | 2 | 10 | 6 | 8 |
| Suporte | 1 | 4 | 3 | 5 |
| Escalabilidade | 2 | 10 | 6 | 8 |
| **TOTAL** | | **42** | **42** | **42** |

**Empate!** Nesse caso, critério de desempate: facilidade de uso. **Pipedrive vence.**

---

### Prompt de IA para Análise de Decisão

**Cole no Claude/ChatGPT antes de decidir:**

```
Sou dono de [TIPO DE NEGÓCIO] e preciso tomar uma decisão importante.

DECISÃO: [Descrever a decisão]

CONTEXTO:
- Situação atual: [descrever]
- Por que preciso decidir: [motivo]
- Deadline: [quando]

OPÇÕES QUE ESTOU CONSIDERANDO:
- Opção A: [descrever]
- Opção B: [descrever]
- Opção C: [descrever] (se houver)

MEUS CRITÉRIOS:
1. [Critério 1]
2. [Critério 2]
3. [Critério 3]

Analise como um consultor estratégico:

1. PONTOS CEGOS: O que posso não estar enxergando em cada opção?

2. CENÁRIOS: Para cada opção, descreva:
   - Melhor cenário (se tudo der certo)
   - Cenário base (resultado provável)
   - Pior cenário (se der errado)

3. RISCOS: Qual o maior risco de cada opção?

4. REVERSIBILIDADE: Quão fácil é reverter se der errado?

5. RECOMENDAÇÃO: Se você fosse eu, qual escolheria e por quê?

6. PERGUNTA-CHAVE: Qual pergunta eu deveria me fazer antes de decidir?

Seja direto e crítico. Prefiro honestidade a validação.
```

---

### O Que Esperar da IA

| Tipo de Insight | Exemplo |
|-----------------|---------|
| **Ponto cego** | "Você não considerou o custo de treinamento da equipe" |
| **Cenário** | "No pior caso, migração pode levar 3 meses, não 1" |
| **Risco** | "A opção A tem dependência de 1 fornecedor" |
| **Reversibilidade** | "Trocar de CRM depois custa 3x mais que fazer certo agora" |
| **Recomendação** | "B parece melhor para seu estágio, mas A escala melhor" |
| **Pergunta-chave** | "Você está otimizando para custo ou para crescimento?" |

---

### Quando Usar Matriz vs IA

| Situação | Ferramenta |
|----------|------------|
| Comparar opções objetivamente | Matriz de Decisão |
| Ver ângulos que não considerei | Prompt de IA |
| Decisão complexa com muitos fatores | Ambos |
| Decisão simples com 2 opções | Só matriz |
| Validar intuição | Prompt de IA |

**Recomendação:** Use os dois. Matriz primeiro, IA depois para validar.

---

### 🤔 Pergunta Reflexiva

> "Você já decidiu algo importante sem critérios definidos?"
>
> Sem critério, qualquer opção parece boa — ou ruim.
>
> Critérios transformam opinião em análise.

---

## 💡 Revisão

**Os 2 Insights:**

1. **Matriz objetiva a decisão** — Critérios + pesos + notas = comparação justa.

2. **IA revela pontos cegos** — Ela vê ângulos que você não pensou.

**A Transformação:**
- **Antes:** "Decido pelo feeling"
- **Depois:** "Decido por análise estruturada"

---

## ⚡ AÇÃO RÁPIDA (3 min)

**Faça agora:**
1. Copie o template de matriz
2. Preencha com sua decisão pendente
3. Defina 3-5 critérios

**Funcionou se:** Você tem matriz criada para sua decisão.

---

## 🎬 HOOK - Próxima Aula

> Você tem as ferramentas.
>
> Agora vai me ver USANDO.
>
> Na próxima aula, vou tomar uma decisão estratégica ao vivo — do contexto à decisão final.
>
> **Próxima aula: 4.5 - Tomando uma Decisão Estratégica ao Vivo**

---

*Aula 4.4 - Trilha 5 - Academia Lendária*
