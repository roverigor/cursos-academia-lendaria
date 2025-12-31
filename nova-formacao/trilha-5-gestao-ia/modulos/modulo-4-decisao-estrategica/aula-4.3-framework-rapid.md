# Aula 4.3: Framework RAPID: Quem Decide O Quê

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 4 - Decisão Estratégica com IA |
| **Aula** | 4.3 |
| **Tipo** | Conceitual |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Framework RAPID + Aplicação prática) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai conhecer o framework RAPID — e saber definir papéis claros em qualquer decisão.**
>
> Quem decide, quem dá input, quem executa.

---

## 🗺️ P - POSITION (Origem)

> "Todo mundo opina, mas ninguém decide."
>
> Esse é um problema de PAPEL, não de pessoas.
>
> RAPID define claramente quem faz o quê.
>
> Chega de reuniões em loop.

---

## 🛤️ S - STEPS (Rota)

### O Framework RAPID

```
[DIAGRAMA: RAPID Explicado]

┌─────────────────────────────────────────────────────┐
│                      RAPID                          │
│                                                     │
│  R = RECOMMEND (Recomenda)                          │
│      Quem pesquisa e propõe opções                  │
│      "Eu analisei e sugiro X porque..."            │
│                                                     │
│  A = AGREE (Concorda/Veta)                          │
│      Quem pode vetar (mas não decidir)              │
│      "Eu preciso concordar para seguir"            │
│                                                     │
│  P = PERFORM (Executa)                              │
│      Quem implementa após decisão                   │
│      "Eu vou fazer acontecer"                      │
│                                                     │
│  I = INPUT (Dá opinião)                             │
│      Quem é consultado antes da decisão             │
│      "Minha perspectiva é..."                      │
│                                                     │
│  D = DECIDE (Decide)                                │
│      Quem bate o martelo                            │
│      "A decisão final é..."                        │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

### Cada Papel em Detalhe

| Papel | O que faz | Quantos |
|-------|-----------|---------|
| **R - Recommend** | Pesquisa, analisa, propõe opções | 1 pessoa |
| **A - Agree** | Pode vetar (mas raramente usa) | 0-2 pessoas |
| **P - Perform** | Executa após decisão tomada | 1+ pessoas |
| **I - Input** | Dá opinião quando perguntado | 0-5 pessoas |
| **D - Decide** | Toma a decisão final | 1 pessoa (sempre) |

**Regra de ouro:** D é sempre 1 pessoa. Nunca um grupo.

---

### Por Que Funciona

```
[DIAGRAMA: Sem RAPID vs Com RAPID]

SEM RAPID:
┌────────────────────────────────────────────────────┐
│                                                    │
│   "O que acham?"        "Todo mundo concorda?"     │
│          │                      │                  │
│          ▼                      ▼                  │
│   ┌──────────┐           ┌──────────┐             │
│   │ Opiniões │ ────────► │  Debate  │ ───────┐    │
│   │ diversas │           │  longo   │        │    │
│   └──────────┘           └──────────┘        │    │
│                                              │    │
│                          ┌───────────────────┘    │
│                          ▼                        │
│                   ❌ Ninguém decide               │
│                      "Vamos pensar mais"          │
│                                                    │
└────────────────────────────────────────────────────┘

COM RAPID:
┌────────────────────────────────────────────────────┐
│                                                    │
│   R: "Analisei e recomendo X"                      │
│          │                                         │
│          ▼                                         │
│   I: "Minha opinião é Y"                           │
│          │                                         │
│          ▼                                         │
│   A: "Não vejo impedimento"                        │
│          │                                         │
│          ▼                                         │
│   D: "Decisão: vamos com X"                        │
│          │                                         │
│          ▼                                         │
│   P: "Vou implementar"                             │
│          │                                         │
│          ▼                                         │
│   ✅ DECISÃO TOMADA E EXECUTADA                    │
│                                                    │
└────────────────────────────────────────────────────┘
```

---

### Exemplo Prático

**Decisão:** Trocar de fornecedor de software

| Papel | Quem | Por quê |
|-------|------|---------|
| **R** | Head de Ops | Conhece o dia a dia |
| **I** | Time comercial | Usa o sistema |
| **I** | Financeiro | Sabe o budget |
| **A** | CTO | Precisa validar segurança |
| **D** | CEO | Decide investimento |
| **P** | Head de Ops + TI | Implementam |

**Fluxo:**
1. Head de Ops pesquisa opções, monta comparativo
2. Consulta comercial e financeiro (Input)
3. CTO valida questões técnicas (Agree)
4. CEO decide com base na análise
5. Head de Ops + TI implementam

---

### Erros Comuns

| Erro | Problema | Solução |
|------|----------|---------|
| D é um grupo | Ninguém se responsabiliza | D sempre é 1 pessoa |
| Muitos A | Tudo é vetado | Max 2 pessoas com veto |
| Confundir I com D | Quem opina acha que decide | Deixar claro que I apenas opina |
| R não pesquisa | Decisão sem dados | R precisa trazer análise |
| P não definido | Ninguém executa | Sempre definir quem implementa |

---

### Quando Usar RAPID

| Situação | Usar RAPID? |
|----------|-------------|
| Decisão operacional do dia a dia | ❌ Exagero |
| Decisão estratégica importante | ✅ Essencial |
| Decisão que envolve múltiplas áreas | ✅ Essencial |
| Decisão que já travou uma vez | ✅ Essencial |
| Compra ou investimento significativo | ✅ Essencial |

---

### Template de RAPID

```markdown
# DECISÃO: [Título da decisão]

**Contexto:** [Por que essa decisão precisa ser tomada?]

**Deadline:** [Quando precisa estar decidido?]

---

## PAPÉIS RAPID

| Papel | Nome | Responsabilidade |
|-------|------|------------------|
| **R** | ________ | Pesquisar, analisar, propor |
| **I** | ________ | Dar opinião sobre ________ |
| **A** | ________ | Validar ________ |
| **D** | ________ | Tomar decisão final |
| **P** | ________ | Implementar decisão |

---

## OPÇÕES (preenchido por R)

| Opção | Prós | Contras |
|-------|------|---------|
| A: | | |
| B: | | |
| C: | | |

## RECOMENDAÇÃO (de R)

[R recomenda qual opção e por quê]

## INPUTS (de I)

[Opiniões coletadas]

## VALIDAÇÃO (de A)

☐ Aprovado | ☐ Vetado (motivo: ________)

## DECISÃO (de D)

[Decisão final e justificativa]

## EXECUÇÃO (por P)

| Ação | Responsável | Prazo |
|------|-------------|-------|
| | | |
```

---

### 🤔 Pergunta Reflexiva

> "Na sua última decisão travada..."
>
> "...estava claro quem era o D?"
>
> Se não estava claro, não é paralisia. É falta de estrutura.

---

## 💡 Revisão

**Os 2 Insights:**

1. **D é sempre 1 pessoa** — Grupo não decide. Uma pessoa decide.

2. **5 papéis cobrem tudo** — Recommend, Agree, Perform, Input, Decide.

**A Transformação:**
- **Antes:** "Todo mundo opina, ninguém decide"
- **Depois:** "Cada pessoa sabe seu papel no processo"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Pegue sua decisão pendente
2. Preencha: Quem é R? Quem é D?
3. Se D é você: defina deadline de 48h

**Funcionou se:** Você sabe quem pesquisa e quem decide.

---

## 🎬 HOOK - Próxima Aula

> Você sabe quem decide.
>
> Agora precisa de uma ferramenta para analisar opções.
>
> Na próxima aula, vou te dar uma Matriz de Decisão — e um prompt de IA para te ajudar a avaliar cenários.
>
> **Próxima aula: 4.4 - Matriz de Decisão + IA como Analista**

---

*Aula 4.3 - Trilha 5 - Academia Lendária*
