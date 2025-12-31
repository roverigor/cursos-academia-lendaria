# Aula 3.3: Classificacao Automatica - Categoria + Urgencia

## Trilha 8 - CS e Atendimento | Modulo 3

---

> **Duracao:** 10 minutos
> **Tipo:** Teoria (Framework)
> **Entregavel:** Prompt Classificador Completo
> **Linha do DRE:** Automacao de Triagem

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM TECNICO]

"A classificacao automatica tem 4 dimensoes:

1. CATEGORIA - que tipo de ticket e?
2. URGENCIA - quao rapido responder?
3. RISCO - tem perigo envolvido?
4. CONFIANCA - IA tem certeza?

Quando voce define bem essas 4 dimensoes,
a IA classifica 95% dos tickets corretamente.

Vou te ensinar cada uma agora."
```

---

### DIMENSAO 1: CATEGORIA (2.5 minutos)

```
[MOSTRAR LISTA DE CATEGORIAS]

"Primeira dimensao: CATEGORIA.

Voce ja definiu isso no Modulo 1.
Agora vamos ensinar pra IA.

[MOSTRAR CATEGORIAS]

Categorias padrao:
- duvida: pergunta sobre produto/servico
- problema_tecnico: erro, bug, nao funciona
- financeiro: pagamento, reembolso, cobranca
- onboarding: acesso, como comecar
- status: onde ta meu pedido
- reclamacao: insatisfacao, critica

[MOSTRAR COMO ENSINAR IA]

Pra IA entender, voce define assim:

'CATEGORIAS DISPONIVEIS:
- duvida: cliente pergunta sobre caracteristicas, precos, funcionamento
- problema_tecnico: cliente relata erro, bug, sistema nao funciona
- financeiro: envolve dinheiro - reembolso, cobranca, cancelamento
- onboarding: cliente novo, primeiro acesso, como comecar
- status: acompanhamento de pedido, entrega, processo
- reclamacao: insatisfacao, critica, ameaca'

[MOSTRAR DICA]

Dica: use SUAS categorias do Funil de Suporte.
Nao precisa ser as genericas.
Quanto mais especifico pro seu negocio, melhor."
```

---

### DIMENSAO 2: URGENCIA (2 minutos)

```
[MOSTRAR NIVEIS DE URGENCIA]

"Segunda dimensao: URGENCIA.

Tres niveis: baixa, media, alta.

[MOSTRAR CRITERIOS]

URGENCIA BAIXA:
- Duvida generica
- Nao afeta uso do produto
- Cliente nao expressa pressa
- Pode responder em horas

URGENCIA MEDIA:
- Problema que atrapalha uso
- Cliente mostra frustração leve
- Precisa resolver no dia
- SLA padrao

URGENCIA ALTA:
- Sistema parado
- Cliente muito irritado
- Menciona dinheiro perdido
- Ameaca sair/processar
- Responder AGORA

[MOSTRAR COMO ENSINAR]

Pra IA:

'CRITERIOS DE URGENCIA:
- baixa: duvida informativa, sem impacto imediato
- media: problema real mas sem risco, cliente frustrado
- alta: sistema parado, perda financeira, ameaca juridica/cancelamento'

[MOSTRAR REGRA]

Regra: se categoria = reclamacao, urgencia MINIMA = media.
Nunca deixa reclamacao como baixa."
```

---

### DIMENSAO 3: RISCO (2.5 minutos)

```
[MOSTRAR NIVEIS DE RISCO]

"Terceira dimensao: RISCO.

Isso e o que PROTEGE voce.

[MOSTRAR NIVEIS]

RISCO NORMAL:
- Conversa tranquila
- Sem mencao a problemas graves
- Cliente cooperativo

RISCO ATENCAO:
- Cliente frustrado
- Menciona cancelamento
- Pede reembolso
- Compara com concorrente

RISCO CRITICO:
- Menciona Procon, advogado, processo
- Ameaca Reclame Aqui
- Tom agressivo (capslock, palavrao)
- Menciona prejuizo financeiro alto
- Ja reclamou antes sem solucao

[MOSTRAR PALAVRAS DE ALERTA]

Palavras que disparam RISCO CRITICO:
- 'procon', 'processo', 'advogado'
- 'reclame aqui', 'reclameaqui'
- 'danos morais', 'indenizacao'
- 'nunca mais', 'absurdo', 'vergonha'
- 'terceira vez', 'ninguem resolve'

[MOSTRAR REGRA]

Regra: se RISCO = critico, SEMPRE escala.
IA nao responde sozinha. Humano assume."
```

---

### DIMENSAO 4: CONFIANCA (1.5 minutos)

```
[MOSTRAR ESCALA DE CONFIANCA]

"Quarta dimensao: CONFIANCA.

De 0 a 100, quao certa a IA esta?

[MOSTRAR FAIXAS]

90-100: Alta confianca
- Ticket claro
- Categoria obvia
- Pode auto-responder

70-89: Media confianca
- Ticket um pouco ambiguo
- Melhor pedir confirmacao
- Humano valida antes

< 70: Baixa confianca
- Ticket confuso
- Multiplas categorias possiveis
- ESCALAR para humano

[MOSTRAR REGRA]

Regra:
- Confianca < 80 = nao auto-responde
- Confianca < 70 = escala direto

[MOSTRAR PORQUE]

Por que isso importa?

IA sendo honesta sobre incerteza
e melhor que IA fingindo certeza.

Quando IA diz '65% de confianca',
ela ta dizendo: 'nao tenho certeza, deixa humano ver'."
```

---

### O PROMPT COMPLETO (1 minuto)

```
[MOSTRAR PROMPT FINAL]

"Agora juntando tudo no prompt:

---
Classifique este ticket:

CATEGORIAS:
[suas categorias com definicao]

URGENCIA:
- baixa: [criterio]
- media: [criterio]
- alta: [criterio]

RISCO:
- normal: sem alerta
- atencao: frustrado, menciona cancelar
- critico: juridico, Procon, agressivo

PALAVRAS DE ALERTA CRITICO:
procon, advogado, processo, reclame aqui, absurdo

REGRAS:
- Se RISCO = critico → escalar_gestor
- Se CONFIANCA < 80 → escalar_l2
- Se CATEGORIA = reclamacao → URGENCIA minima = media

TICKET:
[ticket]

Retorne:
CATEGORIA:
URGENCIA:
RISCO:
CONFIANCA:
PROXIMA_ACAO: [auto_responder | pedir_dados | escalar_l2 | escalar_gestor]
---"
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Agora voce tem as 4 dimensoes:
Categoria, Urgencia, Risco, Confianca.

Com elas, IA classifica qualquer ticket
em 2 segundos. Com 95% de acerto.

Na proxima aula, vamos ver o ROTEAMENTO.
Depois que IA classifica, pra onde o ticket vai?
L1? L2? Especialista? Auto-resposta?

Te vejo la."
```

---

## MATERIAL DE APOIO

### As 4 Dimensoes da Classificacao

| Dimensao | Valores | Uso |
|----------|---------|-----|
| Categoria | duvida, tecnico, financeiro, etc | Tipo do ticket |
| Urgencia | baixa, media, alta | Velocidade de resposta |
| Risco | normal, atencao, critico | Nivel de perigo |
| Confianca | 0-100 | Certeza da IA |

### Template: Definicao de Categorias

```
CATEGORIAS:
- duvida: [sua definicao]
- problema_tecnico: [sua definicao]
- financeiro: [sua definicao]
- onboarding: [sua definicao]
- status: [sua definicao]
- reclamacao: [sua definicao]
- [sua categoria]: [definicao]
```

### Palavras de Alerta por Risco

| Risco | Palavras |
|-------|----------|
| ATENCAO | cancelar, desistir, frustrado, decepcionado |
| CRITICO | procon, advogado, processo, reclame aqui, absurdo, vergonha |

### Regras de Classificacao

```
SE RISCO = critico → ESCALAR_GESTOR
SE CONFIANCA < 80 → ESCALAR_L2
SE CONFIANCA < 70 → ESCALAR_GESTOR
SE CATEGORIA = reclamacao → URGENCIA >= media
```

---

## PROMPT CLASSIFICADOR COMPLETO

```
Classifique este ticket de atendimento:

CATEGORIAS DISPONIVEIS:
- duvida: pergunta sobre produto, preco, funcionamento
- problema_tecnico: erro, bug, sistema nao funciona
- financeiro: pagamento, reembolso, cobranca, cancelamento
- onboarding: primeiro acesso, como comecar, configuracao inicial
- status: acompanhamento de pedido, entrega, processo
- reclamacao: insatisfacao, critica, ameaca

CRITERIOS DE URGENCIA:
- baixa: duvida informativa, sem impacto imediato
- media: problema real, cliente frustrado, precisa resolver no dia
- alta: sistema parado, perda financeira, ameaca juridica/cancelamento

CRITERIOS DE RISCO:
- normal: conversa tranquila, sem alertas
- atencao: frustrado, menciona cancelar, compara concorrente
- critico: juridico (procon, advogado), Reclame Aqui, tom agressivo

PALAVRAS DE ALERTA CRITICO:
procon, advogado, processo, reclame aqui, absurdo, vergonha, terceira vez, ninguem resolve

REGRAS:
- Se RISCO = critico → PROXIMA_ACAO = escalar_gestor
- Se CONFIANCA < 80 → PROXIMA_ACAO = escalar_l2
- Se CATEGORIA = reclamacao → URGENCIA minima = media

TICKET:
[Cole o ticket aqui]

Retorne:
CATEGORIA:
URGENCIA:
RISCO:
CONFIANCA:
PROXIMA_ACAO: [auto_responder | pedir_dados | escalar_l2 | escalar_gestor]
JUSTIFICATIVA: [1 linha explicando]
```

---

## CHECKPOINT

- [ ] Entendi as 4 dimensoes de classificacao
- [ ] Defini minhas categorias com criterios
- [ ] Sei os niveis de urgencia e quando usar
- [ ] Conheço as palavras de alerta de risco
- [ ] Tenho o prompt classificador completo

---

## CONEXAO COM PROXIMA AULA

> Classificou. Agora pra onde vai? Vamos ver o roteamento inteligente.

**Proxima:** Aula 3.4 - Roteamento Inteligente: L1, L2, Especialista

---

**Tempo real:** 10 minutos
**Impacto DRE:** Sistema de classificacao automatica
