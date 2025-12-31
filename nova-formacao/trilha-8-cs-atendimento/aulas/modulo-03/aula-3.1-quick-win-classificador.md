# Aula 3.1: Quick Win - Classificador Express

## Trilha 8 - CS e Atendimento | Modulo 3

---

> **Duracao:** 5 minutos
> **Tipo:** Quick Win (Exercicio Guiado)
> **Entregavel:** Classificador de Ticket Funcionando
> **Linha do DRE:** Tempo de Triagem

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - ENERGIA ALTA]

"Quanto tempo sua equipe gasta LENDO ticket
antes de saber o que fazer com ele?

1 minuto? 2 minutos?
Por ticket. Por dia. Todo dia.

E se a IA fizesse isso em 2 SEGUNDOS?

Nos proximos 5 minutos, voce vai criar
um classificador automatico de tickets.

Abre o ChatGPT. Vamos la."
```

---

### PASSO 1: O PROMPT CLASSIFICADOR (2 minutos)

```
[MOSTRAR PROMPT NA TELA]

"Copia esse prompt:

---
Classifique este ticket de atendimento:

TICKET:
[Cole o ticket aqui]

Retorne em formato estruturado:

CATEGORIA: [duvida | problema_tecnico | financeiro | onboarding | status | reclamacao]
URGENCIA: [baixa | media | alta]
RISCO: [normal | atencao | critico]
PROXIMA_ACAO: [auto_responder | pedir_dados | escalar_l2 | escalar_gestor]
CONFIANCA: [0-100]

Se RISCO = critico OU CONFIANCA < 80, PROXIMA_ACAO deve ser escalar.
---

[EXPLICAR]

Esse prompt faz 5 coisas:
1. Identifica a CATEGORIA (tipo de ticket)
2. Define URGENCIA (quao rapido responder)
3. Avalia RISCO (tem perigo?)
4. Sugere PROXIMA ACAO (o que fazer)
5. Da uma CONFIANCA (certeza da IA)

E tudo em 2 segundos."
```

---

### PASSO 2: TESTAR COM TICKET REAL (1.5 minutos)

```
[MOSTRAR TESTE]

"Agora testa.

Pega um ticket real do seu atendimento.
Cola no lugar indicado.
Envia pro ChatGPT.

[MOSTRAR EXEMPLO]

Meu teste:

TICKET: 'Oi, comprei ontem mas nao chegou o email
com o acesso. Ja olhei no spam. Me ajuda?'

RESPOSTA DA IA:

CATEGORIA: onboarding
URGENCIA: media
RISCO: normal
PROXIMA_ACAO: auto_responder
CONFIANCA: 95

[ANALISAR]

Em 2 segundos a IA disse:
- E um ticket de onboarding
- Urgencia media (nao e emergencia)
- Sem risco
- Pode auto-responder
- 95% de certeza

Seu atendente levaria 1-2 minutos pra chegar nisso.
IA fez em 2 segundos."
```

---

### PASSO 3: VER A MAGICA (1 minuto)

```
[MOSTRAR OUTRO EXEMPLO]

"Agora olha um ticket mais complicado:

TICKET: 'ABSURDO! Terceira vez que reclamo e ninguem
resolve. Vou no Procon e no Reclame Aqui se nao
me devolverem o dinheiro HOJE.'

RESPOSTA DA IA:

CATEGORIA: reclamacao
URGENCIA: alta
RISCO: critico
PROXIMA_ACAO: escalar_gestor
CONFIANCA: 98

[DESTACAR]

Olha so:
- IA identificou RISCO CRITICO (Procon, Reclame Aqui)
- Urgencia ALTA
- Acao: ESCALAR PRA GESTOR

Isso protege voce.
IA nao vai tentar responder sozinha.
Ela sabe que e perigoso.

Essa e a triagem automatica."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Em 5 minutos voce viu:

IA classificando ticket automaticamente.
Categoria, urgencia, risco, proxima acao.
Em 2 segundos. Com 95% de acerto.

Imagina isso rodando em CADA ticket.
Antes de qualquer humano ler.

Na proxima aula, vou te mostrar
por que triagem manual e puro desperdicio.
E como montar o fluxo completo de automacao.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Prompt Classificador Express

```
Classifique este ticket de atendimento:

TICKET:
[Cole o ticket aqui]

Retorne em formato estruturado:

CATEGORIA: [duvida | problema_tecnico | financeiro | onboarding | status | reclamacao]
URGENCIA: [baixa | media | alta]
RISCO: [normal | atencao | critico]
PROXIMA_ACAO: [auto_responder | pedir_dados | escalar_l2 | escalar_gestor]
CONFIANCA: [0-100]

Regras:
- Se RISCO = critico, PROXIMA_ACAO = escalar_gestor
- Se CONFIANCA < 80, PROXIMA_ACAO = escalar_l2
- Se CATEGORIA = reclamacao, URGENCIA minima = media
```

### Significado de Cada Campo

| Campo | Valores | Significado |
|-------|---------|-------------|
| CATEGORIA | duvida, problema_tecnico, financeiro, onboarding, status, reclamacao | Tipo do ticket |
| URGENCIA | baixa, media, alta | Velocidade de resposta |
| RISCO | normal, atencao, critico | Nivel de perigo |
| PROXIMA_ACAO | auto_responder, pedir_dados, escalar_l2, escalar_gestor | O que fazer |
| CONFIANCA | 0-100 | Certeza da classificacao |

### Exemplos de Classificacao

| Ticket | Categoria | Urgencia | Risco | Acao |
|--------|-----------|----------|-------|------|
| "Como acesso o curso?" | duvida | baixa | normal | auto_responder |
| "Sistema dando erro" | problema_tecnico | media | normal | pedir_dados |
| "Quero reembolso" | financeiro | media | atencao | escalar_l2 |
| "Vou no Procon" | reclamacao | alta | critico | escalar_gestor |

---

## PROMPT DE IA PARA TESTE MULTIPLO

```
Classifique estes 5 tickets:

TICKET 1: [cole]
TICKET 2: [cole]
TICKET 3: [cole]
TICKET 4: [cole]
TICKET 5: [cole]

Para cada um, retorne:
- CATEGORIA
- URGENCIA
- RISCO
- PROXIMA_ACAO
- CONFIANCA

Formato tabela.
```

---

## CHECKPOINT

- [ ] Copiei o prompt classificador
- [ ] Testei com ticket real
- [ ] Vi classificacao automatica funcionando
- [ ] Entendi os campos retornados
- [ ] Quero aprender o fluxo completo

---

## CONEXAO COM PROXIMA AULA

> Viu funcionando. Agora vamos entender por que triagem manual e desperdicio - e como montar o fluxo completo.

**Proxima:** Aula 3.2 - Por Que Triagem Manual E Desperdicio

---

**Tempo real:** 5 minutos
**Impacto DRE:** Prova de conceito de triagem automatica
