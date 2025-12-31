# Aula 4.5: Tomando uma Decisão Estratégica ao Vivo

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 4 - Decisão Estratégica com IA |
| **Aula** | 4.5 |
| **Tipo** | Demo |
| **Duração** | 15 minutos |
| **Conceitos** | 2 (Processo completo + Validação com IA) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter visto uma decisão estratégica sendo tomada do zero — com RAPID, matriz e validação por IA.**
>
> Você vai saber exatamente como fazer.

---

## 🗺️ P - POSITION (Origem)

> "Entendi as ferramentas. Mas como usar tudo junto?"
>
> Vou te mostrar.
>
> Vou tomar uma decisão real ao vivo.
>
> Do contexto à decisão final.

---

## 🛤️ S - STEPS (Rota)

### Contexto: A Decisão

**Empresa:** SaaS Analytics Pro (mesmo exemplo)
**Decisão:** Devo abrir um programa de parcerias ou focar em vendas diretas?

**Por que é importante:**
- Parceiros podem acelerar crescimento
- Mas consomem tempo e margem
- Time comercial já está no limite
- Meta de conversão do Q1 em risco

**Deadline:** Preciso decidir até sexta (5 dias)

---

### Passo 1: Definir RAPID (2 min)

| Papel | Quem | Por quê |
|-------|------|---------|
| **R** | Head Comercial (João) | Conhece o mercado |
| **I** | Head de Produto (Maria) | Perspectiva de produto |
| **I** | Financeiro (Pedro) | Visão de margem |
| **A** | Nenhum | Decisão é só do CEO |
| **D** | CEO (Eu) | Decisão estratégica |
| **P** | Head Comercial | Implementa |

**Definido:** João pesquisa, eu decido.

---

### Passo 2: Coletar Inputs (3 min)

**Input de Maria (Produto):**
> "Parceiros podem ajudar a vender, mas precisamos de material de onboarding. Hoje não temos. Estimo 2 semanas de trabalho."

**Input de Pedro (Financeiro):**
> "Se dermos 20% de comissão para parceiros, margem cai de 19% para ~15% nessas vendas. Mas se gerar volume, pode valer."

**Input de João (Comercial - também é R):**
> "Vi 3 opções: A) Foco total em vendas diretas; B) Programa de parcerias piloto com 3 parceiros; C) Programa completo com 10+ parceiros."

---

### Passo 3: Montar Matriz (5 min)

**Critérios definidos:**

| # | Critério | Peso | Descrição |
|---|----------|------|-----------|
| 1 | Impacto no faturamento | 3 | Potencial de receita |
| 2 | Esforço de implementação | 3 | Tempo/recurso necessário |
| 3 | Risco | 2 | O que pode dar errado |
| 4 | Velocidade de resultado | 2 | Quando vejo resultado |
| 5 | Impacto na margem | 2 | Efeito na rentabilidade |

**Avaliação (1-5, onde 5 é melhor):**

| Critério | Peso | A: Diretas | B: Piloto 3 | C: 10+ parceiros |
|----------|------|------------|-------------|-----------------|
| Impacto faturamento | 3 | 3 | 4 | 5 |
| Esforço implementação | 3 | 5 | 3 | 1 |
| Risco | 2 | 4 | 3 | 2 |
| Velocidade resultado | 2 | 4 | 3 | 2 |
| Impacto margem | 2 | 5 | 3 | 2 |

**Cálculo:**

| Critério | Peso | A | B | C |
|----------|------|---|---|---|
| Faturamento | 3 | 9 | 12 | 15 |
| Esforço | 3 | 15 | 9 | 3 |
| Risco | 2 | 8 | 6 | 4 |
| Velocidade | 2 | 8 | 6 | 4 |
| Margem | 2 | 10 | 6 | 4 |
| **TOTAL** | | **50** | **39** | **30** |

**Resultado inicial:** Opção A (Diretas) vence com 50 pontos.

---

### Passo 4: Validar com IA (3 min)

**Prompt enviado:**

```
Sou CEO de um SaaS B2B (R$120K/mês, 12 pessoas).

Preciso decidir: abrir programa de parcerias ou focar em vendas diretas?

CONTEXTO:
- Time comercial no limite
- Meta de conversão 8%→15% no Q1
- Margem atual: 19%

OPÇÕES:
A) Foco total em vendas diretas
B) Piloto com 3 parceiros
C) Programa completo com 10+ parceiros

Fiz uma matriz e A venceu (50 pontos vs 39 de B e 30 de C).

Analise criticamente:
1. Estou ponderando os critérios corretamente?
2. Qual ponto cego posso estar deixando de ver?
3. Se eu escolher A agora, quando deveria reconsiderar B?
4. Qual pergunta-chave devo me fazer?

Seja direto.
```

**Resposta da IA:**

> "Sua análise faz sentido para o momento atual. Pontos a considerar:
>
> 1. **Critério de esforço pode estar superponderado.** Se o time já está no limite, talvez parceiros *aliviem* carga no médio prazo.
>
> 2. **Ponto cego:** Você não considerou que parceiros podem trazer leads que você não alcançaria. Volume pode compensar margem menor.
>
> 3. **Reconsiderar B quando:** Conversão atingir 12% e time estiver com folga. Aí faz sentido pilotar.
>
> 4. **Pergunta-chave:** Você está otimizando para o Q1 ou para o ano? Para Q1, A é certo. Para o ano, B pode ser melhor."

---

### Passo 5: Decidir (2 min)

**Reflexão pós-IA:**

A pergunta-chave da IA é boa. Estou focando no Q1 porque tenho OKR de conversão. Faz sentido priorizar diretas agora.

**Decisão Final:**

```
DECISÃO: Opção A - Foco total em vendas diretas

JUSTIFICATIVA:
- Time está no limite; parceiros consumiriam tempo agora
- Q1 é crítico para converter melhor
- Margem precisa subir, não cair
- Podemos reconsiderar B no Q2 se atingirmos 12% de conversão

PRÓXIMOS PASSOS:
1. Comunicar time que parcerias estão pausadas (não canceladas)
2. João foca 100% em diretas
3. Criar critério de revisão: Se conversão >12% em abril, reavaliamos B

RESPONSÁVEL: João (P)
DEADLINE REVISÃO: 15/04/2025
```

---

### Resultado: Documento Final

```
[DIAGRAMA: Decisão Documentada]

┌─────────────────────────────────────────────────────┐
│                                                     │
│  DECISÃO: Programa de Parcerias                    │
│  DATA: 10/01/2025                                  │
│                                                     │
│  ┌───────────────────────────────────────────────┐ │
│  │ RESULTADO: OPÇÃO A - VENDAS DIRETAS           │ │
│  └───────────────────────────────────────────────┘ │
│                                                     │
│  RAPID:                                            │
│  • R: João    • I: Maria, Pedro                   │
│  • D: CEO     • P: João                           │
│                                                     │
│  CRITÉRIOS: Faturamento, Esforço, Risco,          │
│            Velocidade, Margem                      │
│                                                     │
│  SCORE: A(50) > B(39) > C(30)                     │
│                                                     │
│  VALIDAÇÃO IA: Confirma. Sugeriu revisar em Q2    │
│                se conversão >12%                   │
│                                                     │
│  PRÓXIMA REVISÃO: 15/04/2025                      │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

### 🤔 Pergunta Reflexiva

> "Você consegue ver como saímos de 'não sei' para 'decisão documentada' em 15 minutos?"
>
> O processo cria clareza.
>
> Sem processo, ficamos em loop.

---

## 💡 Revisão

**Os 2 Insights:**

1. **Processo > intuição** — RAPID + Matriz + IA = decisão estruturada.

2. **Decisão inclui revisão** — Quando vou reconsiderar? Documentar isso evita arrependimento.

**A Transformação:**
- **Antes:** "Fico semanas pensando"
- **Depois:** "Decido em 1 hora com processo"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Revise sua matriz (da aula anterior)
2. Rode o prompt de validação com IA
3. Anote a pergunta-chave que a IA fizer

**Funcionou se:** Você tem feedback da IA sobre sua decisão.

---

## 🎬 HOOK - Próxima Aula

> Você viu como se faz.
>
> Agora é SUA VEZ.
>
> Na próxima aula, você vai usar tudo para resolver uma decisão que está pendente há tempo.
>
> **Próxima aula: 4.6 - Seu Turno: Resolva uma Decisão Pendente**

---

*Aula 4.5 - Trilha 5 - Academia Lendária*
