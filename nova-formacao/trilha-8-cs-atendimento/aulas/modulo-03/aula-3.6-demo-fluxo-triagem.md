# Aula 3.6: Demo - Fluxo de Triagem Completo

## Trilha 8 - CS e Atendimento | Modulo 3

---

> **Duracao:** 10 minutos
> **Tipo:** Demo (Exemplo Real)
> **Entregavel:** Referencia do Fluxo Funcionando
> **Linha do DRE:** Prova de Conceito

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM EMPOLGADO]

"Hora de ver tudo junto.

Classificacao + Roteamento + Auto-resposta.
Um fluxo completo de triagem.

Vou rodar 5 tickets diferentes.
Voce vai ver como cada um e tratado.
Do inicio ao fim."
```

---

### O PROMPT COMPLETO (1.5 minutos)

```
[COMPARTILHAR TELA - PROMPT]

"Primeiro, o prompt completo que vamos usar:

[MOSTRAR]

---
Voce e um triador automatico de tickets.

CATEGORIAS:
- duvida: pergunta sobre produto/servico
- problema_tecnico: erro, bug, nao funciona
- financeiro: pagamento, reembolso, cobranca
- onboarding: acesso, como comecar
- status: onde ta meu pedido
- reclamacao: insatisfacao, critica

RISCO:
- normal: conversa tranquila
- atencao: frustrado, menciona cancelar
- critico: procon, advogado, agressivo

ROTEAMENTO:
- AUTO: duvida/onboarding/status + risco normal + confianca >= 90
- L1: duvidas gerais, onboarding
- L2: tecnico, financeiro, reclamacao leve
- GESTOR: risco critico, reclamacao grave

TICKET:
[ticket]

RETORNE:
CATEGORIA:
URGENCIA: [baixa | media | alta]
RISCO: [normal | atencao | critico]
CONFIANCA: [0-100]
DESTINO: [AUTO | L1 | L2 | GESTOR]
ELEGIVEL_AUTO: [TRUE | FALSE]
JUSTIFICATIVA: [1 linha]
---

Esse e o prompt. Vamos testar."
```

---

### TICKET 1: FAQ SIMPLES (1.5 minutos)

```
[MOSTRAR TICKET 1]

"Primeiro ticket:

'Ola, qual o horario de funcionamento de voces?'

[COLAR NO PROMPT]

Resposta:

CATEGORIA: duvida
URGENCIA: baixa
RISCO: normal
CONFIANCA: 98
DESTINO: AUTO
ELEGIVEL_AUTO: TRUE
JUSTIFICATIVA: FAQ simples, resposta direta na KB

[ANALISAR]

Perfeito.
- E uma duvida simples ✓
- Risco normal ✓
- Confianca 98% ✓
- Vai pra AUTO ✓

Se tivesse resposta na KB, seria enviada automaticamente.
Humano nem veria esse ticket."
```

---

### TICKET 2: PROBLEMA TECNICO (1.5 minutos)

```
[MOSTRAR TICKET 2]

"Segundo ticket:

'Quando tento fazer login aparece erro 500.
Ja tentei em outro navegador e nao funciona.
Preciso acessar urgente pra uma reuniao.'

[COLAR NO PROMPT]

Resposta:

CATEGORIA: problema_tecnico
URGENCIA: alta
RISCO: normal
CONFIANCA: 95
DESTINO: L2
ELEGIVEL_AUTO: FALSE
JUSTIFICATIVA: Problema tecnico requer diagnostico, urgente por reuniao

[ANALISAR]

Correto.
- Problema tecnico → L2 sempre ✓
- Urgencia alta (menciona urgente) ✓
- Nao e auto porque precisa diagnostico ✓
- Vai direto pro time tecnico"
```

---

### TICKET 3: FINANCEIRO COM RISCO (1.5 minutos)

```
[MOSTRAR TICKET 3]

"Terceiro ticket:

'Fui cobrado duas vezes no cartao esse mes.
Quero o estorno imediato da cobranca duplicada.
Se nao resolverem, vou contestar no cartao.'

[COLAR NO PROMPT]

Resposta:

CATEGORIA: financeiro
URGENCIA: alta
RISCO: atencao
CONFIANCA: 97
DESTINO: L2
ELEGIVEL_AUTO: FALSE
JUSTIFICATIVA: Cobranca duplicada com ameaca de contestacao, requer atencao financeiro

[ANALISAR]

Olha o risco: ATENCAO.
- Menciona contestar (chargeback) → risco
- Vai pra L2 financeiro, nao L1
- Nunca seria auto (envolve dinheiro)"
```

---

### TICKET 4: RECLAMACAO CRITICA (1.5 minutos)

```
[MOSTRAR TICKET 4]

"Quarto ticket:

'ABSURDO! E a terceira vez que reclamo e ninguem
resolve. Vou registrar no Procon e no Reclame Aqui.
Vou processar por danos morais. Me devolvam o dinheiro!'

[COLAR NO PROMPT]

Resposta:

CATEGORIA: reclamacao
URGENCIA: alta
RISCO: critico
CONFIANCA: 99
DESTINO: GESTOR
ELEGIVEL_AUTO: FALSE
JUSTIFICATIVA: Menciona Procon, Reclame Aqui, processo - risco juridico maximo

[ANALISAR]

RISCO CRITICO.
- Palavras de alerta: Procon, Reclame Aqui, processar
- Vai DIRETO pro GESTOR
- Ninguem mais toca esse ticket
- Prioridade maxima

Isso protege a empresa."
```

---

### TICKET 5: ONBOARDING AUTO (1.5 minutos)

```
[MOSTRAR TICKET 5]

"Quinto ticket:

'Oi! Acabei de comprar o curso.
Como faco pra acessar as aulas?'

[COLAR NO PROMPT]

Resposta:

CATEGORIA: onboarding
URGENCIA: media
RISCO: normal
CONFIANCA: 96
DESTINO: AUTO
ELEGIVEL_AUTO: TRUE
JUSTIFICATIVA: Onboarding padrao, resposta existe na KB

[ANALISAR]

AUTO novamente.
- Onboarding comum ✓
- Risco normal ✓
- Confianca 96% ✓

Se a KB tiver o how-to de acesso,
IA manda automaticamente.
Cliente recebe resposta em segundos."
```

---

### RESUMO DA DEMO (1 minuto)

```
[MOSTRAR TABELA RESUMO]

"Recapitulando os 5 tickets:

| # | Tipo | Destino | Tempo |
|---|------|---------|-------|
| 1 | FAQ | AUTO | 2 seg |
| 2 | Tecnico | L2 | 2 seg |
| 3 | Financeiro | L2 | 2 seg |
| 4 | Reclamacao | GESTOR | 2 seg |
| 5 | Onboarding | AUTO | 2 seg |

[MOSTRAR RESULTADO]

5 tickets triados em 10 segundos total.
Sem triagem manual, seria 5-10 minutos.

2 foram pra AUTO (40%)
2 foram pra L2 (40%)
1 foi pro GESTOR (20%)

Distribuicao realista.
Sistema funcionando."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Voce viu o fluxo completo.

Classificacao instantanea.
Roteamento automatico.
Auto-resposta quando seguro.
Escalamento quando necessario.

Na proxima aula, voce vai construir o SEU fluxo.
30 minutos de exercicio pratico.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Prompt Completo de Triagem

```
Voce e um triador automatico de tickets.

CATEGORIAS:
- duvida: pergunta sobre produto/servico
- problema_tecnico: erro, bug, nao funciona
- financeiro: pagamento, reembolso, cobranca
- onboarding: acesso, como comecar
- status: onde ta meu pedido
- reclamacao: insatisfacao, critica

CRITERIOS DE URGENCIA:
- baixa: informativo, sem impacto
- media: problema real, precisa resolver no dia
- alta: urgente, perda financeira, risco juridico

CRITERIOS DE RISCO:
- normal: conversa tranquila
- atencao: frustrado, menciona cancelar/contestar
- critico: procon, advogado, processo, reclame aqui, agressivo

ROTEAMENTO:
- AUTO: duvida/onboarding/status + risco normal + confianca >= 90 + nao envolve dinheiro
- L1: duvidas gerais, onboarding com supervisao
- L2: tecnico, financeiro, reclamacao leve
- GESTOR: risco critico, reclamacao grave, excecao

TICKET:
[Cole aqui]

RETORNE:
CATEGORIA:
URGENCIA:
RISCO:
CONFIANCA:
DESTINO:
ELEGIVEL_AUTO:
JUSTIFICATIVA:
```

### Resumo da Demo

| Ticket | Categoria | Urgencia | Risco | Destino |
|--------|-----------|----------|-------|---------|
| Horario funcionamento | duvida | baixa | normal | AUTO |
| Erro 500 login | problema_tecnico | alta | normal | L2 |
| Cobranca duplicada | financeiro | alta | atencao | L2 |
| Procon/processo | reclamacao | alta | critico | GESTOR |
| Como acessar | onboarding | media | normal | AUTO |

---

## CHECKPOINT

- [ ] Vi o prompt completo funcionando
- [ ] Entendi como cada ticket foi tratado
- [ ] Vi AUTO funcionando corretamente
- [ ] Vi escalamento para GESTOR em risco critico
- [ ] Pronto pra construir meu fluxo

---

## CONEXAO COM PROXIMA AULA

> Demo completa. Agora e sua vez de construir seu fluxo de triagem.

**Proxima:** Aula 3.7 - Exercicio: Seu Fluxo de Triagem

---

**Tempo real:** 10 minutos
**Impacto DRE:** Prova de conceito do fluxo completo
