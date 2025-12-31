# Aula 2.4: O Motor de Resposta - Prompt Unico

## Trilha 8 - CS e Atendimento | Modulo 2

---

> **Duracao:** 8 minutos
> **Tipo:** Teoria (Framework)
> **Entregavel:** Prompt Motor de Resposta
> **Linha do DRE:** Automacao de Respostas

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM REVELACAO]

"A KB e o combustivel.
O Motor de Resposta e o motor.

Voce pode ter a melhor gasolina do mundo.
Sem motor, carro nao anda.

O Motor de Resposta e UM prompt.
Um unico prompt que pega qualquer ticket,
consulta sua KB, e gera a resposta certa.

Vou te mostrar esse prompt agora.
E como ele funciona."
```

---

### A ANATOMIA DO PROMPT (2 minutos)

```
[MOSTRAR PROMPT NA TELA]

"O Motor de Resposta tem 5 partes:

[MOSTRAR ESTRUTURA]

1. PAPEL
   'Voce e um atendente da [EMPRESA]...'

2. REGRAS
   'Siga essas diretrizes...'

3. BASE DE CONHECIMENTO
   '[Sua KB completa]'

4. TICKET
   '[Ticket do cliente]'

5. INSTRUCAO
   'Gere a resposta seguindo...'

[MOSTRAR FLUXO]

Quando ticket chega:
1. Atendente cola o ticket no prompt
2. IA le a KB
3. IA aplica as regras
4. IA gera resposta no tom certo
5. Atendente revisa e envia

Tempo total: 30 segundos.
Qualidade: consistente.
Custo: quase zero."
```

---

### O PROMPT COMPLETO (3 minutos)

```
[MOSTRAR PROMPT COMPLETO]

"Aqui esta o prompt completo. Anota ou tira print.

---

Voce e um agente de atendimento da [NOME DA EMPRESA].

SUAS DIRETRIZES:
- Seja cordial, objetivo e resolutivo
- Ofereca solucao antes de desculpa
- Se precisar de mais informacao, faca MAX 2 perguntas especificas
- Nunca prometa o que nao esta na politica
- Se for caso de risco (financeiro, juridico, reclamacao grave), indique 'ESCALAR PARA HUMANO'

TOM DE VOZ:
[Cole sua secao de Tom de Voz]

BASE DE CONHECIMENTO:
[Cole suas FAQs, Politicas e How-Tos]

---

TICKET DO CLIENTE:
[Cole o ticket aqui]

---

INSTRUCOES:
1. Identifique a categoria do ticket (duvida, problema, financeiro, etc)
2. Consulte a KB para encontrar a resposta
3. Gere uma resposta no tom definido
4. Se nao encontrar na KB, diga 'Vou verificar e retorno em [SLA]'
5. Termine com proximo passo claro

Responda agora:

---

[MOSTRAR RESULTADO]

Isso e o Motor.
Voce cola o ticket, IA gera resposta.
Pronto."
```

---

### QUANDO ESCALAR (1.5 minutos)

```
[TOM DE ATENCAO]

"Parte importante: quando NAO responder.

O prompt tem uma regra:
'Se for caso de risco, indique ESCALAR PARA HUMANO'

[MOSTRAR CASOS DE ESCALAR]

Casos que SEMPRE escalam:

- Reembolso acima de [valor]
- Ameaca de processo
- Cliente menciona Procon/advogado
- Reclamacao grave (palavrao, ofensa)
- Bug que afeta dados do cliente
- Qualquer coisa que voce nao tem certeza

[MOSTRAR COMO FUNCIONA]

A IA vai responder algo assim:

'[ESCALAR PARA HUMANO]
Motivo: Cliente menciona processo judicial
Recomendacao: Encaminhar para gestor/juridico
Resposta sugerida para ganhar tempo:
Entendo sua preocupacao e levo isso muito a serio.
Vou encaminhar seu caso para nosso time especializado
que entrara em contato em ate 2 horas.'

Isso protege voce.
IA nao decide coisa seria.
Humano decide."
```

---

### REFINANDO O PROMPT (1 minuto)

```
[TOM PRATICO]

"O prompt inicial e 80% bom.
Os outros 20% voce ajusta com uso.

[MOSTRAR PROCESSO]

Depois de 10 tickets:
- Quais respostas precisaram de ajuste?
- O que estava faltando na KB?
- O tom estava certo?

[MOSTRAR AJUSTES COMUNS]

Ajustes comuns:
- 'Seja mais direto' → adiciona na diretriz
- 'Faltou info sobre X' → adiciona na KB
- 'Tom muito formal' → ajusta Tom de Voz
- 'Nao entendeu contexto' → adiciona exemplo

O Motor melhora com feedback.
Quanto mais usa, mais afinado fica."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Agora voce tem o Motor.

KB + Motor = Sistema de Resposta.

Na proxima aula, vou te dar o template completo
da Base de Conhecimento.
Formato pronto pra voce preencher.

Depois, vou mostrar tudo funcionando junto.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Prompt Motor de Resposta (Completo)

```
Voce e um agente de atendimento da [NOME DA EMPRESA].

SUAS DIRETRIZES:
- Seja cordial, objetivo e resolutivo
- Ofereca solucao antes de desculpa
- Se precisar de mais informacao, faca MAX 2 perguntas especificas
- Nunca prometa o que nao esta na politica
- Se for caso de risco (financeiro, juridico, reclamacao grave), indique '[ESCALAR PARA HUMANO]' com motivo

TOM DE VOZ:
[Cole sua secao de Tom de Voz da KB]

BASE DE CONHECIMENTO:
[Cole suas FAQs]
[Cole suas Politicas]
[Cole seus How-Tos]

---

TICKET DO CLIENTE:
[Cole o ticket aqui]

---

INSTRUCOES:
1. Identifique a categoria do ticket
2. Consulte a KB para encontrar a resposta
3. Gere resposta no tom definido
4. Se nao encontrar na KB: "Vou verificar e retorno em [SLA]"
5. Termine com proximo passo claro para o cliente

Responda:
```

### Casos de Escalar para Humano

| Caso | Motivo | Acao |
|------|--------|------|
| Reembolso alto | Decisao financeira | Gestor decide |
| Ameaca juridica | Risco legal | Juridico/gestor |
| Cliente agressivo | Emocional | Humano com empatia |
| Bug critico | Tecnico complexo | Dev/tech lead |
| Incerteza | Nao esta na KB | Humano pesquisa |

### Checklist de Refinamento

Apos 10 tickets, verifique:
- [ ] Respostas estao no tom certo?
- [ ] Informacoes estao completas?
- [ ] Algo faltou na KB?
- [ ] IA escalou quando deveria?
- [ ] IA respondeu quando deveria escalar?

---

## PROMPT DE IA PARA TESTAR

```
Teste este Motor de Resposta:

MEU PROMPT MOTOR:
[Cole seu prompt]

TICKET DE TESTE:
[Cole um ticket real]

Avalie:
1. A resposta esta adequada?
2. O tom esta certo?
3. A informacao esta correta?
4. Deveria ter escalado?
5. O que precisa ajustar no prompt?
```

---

## CHECKPOINT

- [ ] Entendi a estrutura do Motor de Resposta
- [ ] Copiei o prompt modelo
- [ ] Sei quando IA deve escalar
- [ ] Entendi processo de refinamento
- [ ] Pronto pra montar minha KB

---

## CONEXAO COM PROXIMA AULA

> Temos o Motor. Agora vamos ver o template completo da KB pra voce preencher.

**Proxima:** Aula 2.5 - Template: Sua Base de Conhecimento

---

**Tempo real:** 8 minutos
**Impacto DRE:** Mecanismo de geracao automatica de respostas
