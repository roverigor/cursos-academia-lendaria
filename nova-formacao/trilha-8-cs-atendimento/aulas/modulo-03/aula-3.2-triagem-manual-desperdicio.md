# Aula 3.2: Por Que Triagem Manual E Desperdicio

## Trilha 8 - CS e Atendimento | Modulo 3

---

> **Duracao:** 8 minutos
> **Tipo:** Teoria (Conscientizacao)
> **Entregavel:** Entendimento do Problema
> **Linha do DRE:** Custo de Triagem

---

## ROTEIRO DE FALA

### ABERTURA (45 segundos)

```
[OLHAR PARA CAMERA - TOM DIRETO]

"Seu atendente recebe um ticket.
O que ele faz primeiro?

Le.
Entende.
Decide pra onde vai.
So DEPOIS comeca a resolver.

Esse processo - ler, entender, decidir -
e a TRIAGEM.

E ela consome tempo ANTES de qualquer valor ser entregue.

Hoje vou te mostrar quanto isso custa.
E por que e puro desperdicio."
```

---

### O CUSTO ESCONDIDO DA TRIAGEM (2 minutos)

```
[MOSTRAR CALCULO]

"Vamos fazer a conta.

Tempo medio de triagem: 1-2 minutos por ticket.
Vamos usar 1.5 minutos.

[MOSTRAR CALCULOS]

Se voce recebe 50 tickets por dia:
50 x 1.5 min = 75 minutos de triagem

75 minutos por dia.
6 horas e 15 minutos por semana.
25 horas por mes.

[MOSTRAR CUSTO]

Se atendente custa R$ 15/hora:
25 horas x R$ 15 = R$ 375/mes

So pra LER ticket e decidir pra onde vai.
Ainda nem respondeu nada.

[MOSTRAR ESCALA]

E se voce tem 3 atendentes fazendo isso?
R$ 1.125/mes em triagem.

Dinheiro gasto ANTES de qualquer valor.
Isso e desperdicio puro."
```

---

### O QUE ACONTECE NA TRIAGEM MANUAL (2 minutos)

```
[MOSTRAR FLUXO]

"Vamos ver o que acontece na triagem manual.

[MOSTRAR ETAPAS]

1. TICKET CHEGA
   - Notificacao
   - Atendente para o que ta fazendo

2. ATENDENTE LE
   - Le o texto completo
   - Tenta entender o que cliente quer
   - Identifica palavras-chave

3. ATENDENTE DECIDE
   - Qual categoria?
   - E urgente?
   - Eu resolvo ou passo pra alguem?
   - Precisa de mais info?

4. ATENDENTE AGE
   - Comeca a responder
   - OU passa pra outro
   - OU pede mais dados

[MOSTRAR PROBLEMA]

Problema 1: INCONSISTENCIA
- Atendente A acha urgente
- Atendente B acha normal
- Mesma situacao, decisoes diferentes

Problema 2: FADIGA
- Apos 50 tickets, atendente cansa
- Triagem fica pior no fim do dia
- Erros aumentam

Problema 3: GARGALO
- Se atendente ta ocupado, ticket espera
- Triagem vira fila
- SLA ja comeca atrasado"
```

---

### O QUE IA FAZ DIFERENTE (2 minutos)

```
[MOSTRAR COMPARATIVO]

"Agora olha o que IA faz:

[MOSTRAR TABELA]

| Aspecto | Triagem Manual | Triagem IA |
|---------|----------------|------------|
| Tempo | 1-2 min | 2 segundos |
| Consistencia | Varia por pessoa | Sempre igual |
| Fadiga | Piora com volume | Nao existe |
| Disponibilidade | Horario comercial | 24/7 |
| Custo | R$ 375+/mes | Centavos |

[MOSTRAR FLUXO IA]

Com IA:

1. TICKET CHEGA
   - IA le instantaneamente

2. IA CLASSIFICA
   - Categoria
   - Urgencia
   - Risco
   - Proxima acao

3. TICKET JA CHEGA PRONTO
   - Atendente recebe classificado
   - Ja sabe o que fazer
   - Pula direto pra resolver

[MOSTRAR ECONOMIA]

Tempo de triagem: de 1.5 min pra 0.
Economia: 25 horas/mes por atendente.
Consistencia: 100%.
Custo: quase zero."
```

---

### MAS E SE A IA ERRAR? (1 minuto)

```
[TOM DE OBJECAO]

"Voce pode estar pensando:
'Mas e se a IA classificar errado?'

[MOSTRAR RESPOSTA]

Otima pergunta. Tres pontos:

1. IA ACERTA 90-95%
   Com prompt bem feito, erro e raro.
   E quando erra, erra pra lado seguro (escala).

2. HUMANO TAMBEM ERRA
   Atendente cansado erra.
   Atendente novo erra.
   IA pelo menos erra CONSISTENTE.

3. HUMANO SUPERVISIONA
   IA classifica, humano valida.
   Se discordar, corrige.
   Feedback melhora a IA.

[MOSTRAR CONCLUSAO]

Nao e IA vs Humano.
E IA + Humano sendo mais eficiente."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Triagem manual e desperdicio.

Tempo gasto antes de qualquer valor.
Inconsistente. Cansativo. Caro.

IA faz em 2 segundos.
Consistente. Incansavel. Barato.

Na proxima aula, vou te ensinar
como montar a classificacao automatica completa.
Categoria, urgencia, risco - tudo automatico.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Calculo do Custo de Triagem Manual

```
FORMULA:
Custo Mensal = (Tickets/dia) x (Tempo triagem) x (Dias uteis) x (Custo/hora)

EXEMPLO:
50 tickets x 1.5 min x 22 dias x R$ 15/hora
= 50 x 0.025h x 22 x 15
= R$ 412,50/mes

POR ATENDENTE.
```

### Comparativo: Manual vs IA

| Aspecto | Manual | IA | Vantagem |
|---------|--------|-----|----------|
| Tempo/ticket | 1-2 min | 2 seg | IA 60x mais rapido |
| Consistencia | 70-80% | 95%+ | IA mais consistente |
| Disponibilidade | 8h/dia | 24h | IA sempre disponivel |
| Custo mensal | R$ 400+ | R$ 5-10 | IA 40x mais barato |
| Escala | Linear | Constante | IA escala infinito |

### Problemas da Triagem Manual

| Problema | Causa | Consequencia |
|----------|-------|--------------|
| Inconsistencia | Pessoas diferentes | Prioridades erradas |
| Fadiga | Volume alto | Erros no fim do dia |
| Gargalo | Atendente ocupado | SLA estourado |
| Custo | Tempo humano | Dinheiro desperdicado |

---

## PROMPT DE IA PARA CALCULAR SEU CUSTO

```
Calcule quanto estou gastando em triagem manual:

MEUS DADOS:
- Tickets por dia: [X]
- Tempo medio de triagem: [X] minutos
- Dias uteis por mes: 22
- Custo hora do atendente: R$ [X]
- Numero de atendentes: [X]

Calcule:
1. Horas gastas em triagem por mes
2. Custo total mensal de triagem
3. Economia se automatizar 90%
4. ROI de implementar IA (custo IA ~R$ 50/mes)
```

---

## CHECKPOINT

- [ ] Entendi o custo escondido da triagem
- [ ] Calculei quanto gasto em triagem manual
- [ ] Entendi por que IA e mais eficiente
- [ ] Sei que IA + humano e a solucao
- [ ] Quero aprender a classificacao automatica

---

## CONEXAO COM PROXIMA AULA

> Entendeu o problema. Agora vamos construir a solucao: classificacao automatica completa.

**Proxima:** Aula 3.3 - Classificacao Automatica: Categoria + Urgencia

---

**Tempo real:** 8 minutos
**Impacto DRE:** Conscientizacao sobre desperdicio atual
