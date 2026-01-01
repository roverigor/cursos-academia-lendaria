# Template: Workflow de Follow-up Automatizado

## Trilha 7 - Vendas com IA | Modulo 3

---

## Instrucoes de Uso

1. Defina sua cadencia de toques
2. Crie mensagens para cada etapa
3. Configure automacao (n8n/Make)
4. Monitore taxas de resposta
5. Otimize continuamente

---

## 1. CADENCIA MULTICANAL

### Visao Geral (14-21 dias)

| Dia | Canal | Tipo | Objetivo |
|-----|-------|------|----------|
| 0 | WhatsApp | Boas-vindas | Entrega + conexao |
| 1 | WhatsApp | Valor | Dica util |
| 3 | Email | Conteudo | Educacao |
| 5 | WhatsApp | Check-in | Engajamento |
| 7 | Telefone | Call | Qualificacao |
| 10 | Email | Case | Prova social |
| 12 | WhatsApp | Objecao | Quebrar barreiras |
| 14 | Telefone | Call | Segunda tentativa |
| 17 | Email | Ultimo | Fechamento |
| 21 | WhatsApp | Despedida | Ultima chance |

---

## 2. MENSAGENS POR CANAL

### WHATSAPP

#### Dia 0: Boas-vindas

```
Oi [NOME]! 👋

Aqui e [SEU NOME] da [EMPRESA].

Vi que voce se interessou em [OFERTA/CONTEUDO].

[ENTREGA - link, material, etc]

Posso te fazer uma pergunta rapida sobre [TEMA]?
```

#### Dia 1: Valor

```
[NOME], bom dia!

Uma dica que sempre funciona pra [PROBLEMA DO ICP]:

[DICA VALIOSA EM 2-3 LINHAS]

Isso faz sentido pra sua situacao?
```

#### Dia 5: Check-in

```
E ai [NOME], tudo bem?

Conseguiu dar uma olhada no [MATERIAL/LINK]?

Se tiver qualquer duvida, pode mandar aqui. 🙂
```

#### Dia 12: Objecao

```
[NOME], uma coisa que sempre me perguntam:

"[OBJECAO COMUM]"

O que descobri e que [RESPOSTA + EXEMPLO].

Voce ja pensou nisso?
```

#### Dia 21: Despedida

```
[NOME], ultima mensagem!

Nao quero te incomodar, entao vou parar de escrever.

Se em algum momento [SOLUCAO] fizer sentido,
e so me chamar aqui.

Sucesso! 🙂
```

---

### EMAIL

#### Dia 3: Conteudo Educativo

**Assunto:** [NOME], sobre [PROBLEMA]...

```
Oi [NOME],

Muita gente que [DESCRICAO DO ICP] tem dificuldade com [PROBLEMA].

O que funciona:
1. [PONTO 1]
2. [PONTO 2]
3. [PONTO 3]

[LINK PARA CONTEUDO/MATERIAL]

Isso faz sentido pra voce?

Abraco,
[SEU NOME]
```

#### Dia 10: Case/Prova Social

**Assunto:** Como [CLIENTE] resolveu [PROBLEMA]

```
[NOME],

O [CLIENTE] tinha o mesmo desafio:
[DESCRICAO DO PROBLEMA]

Depois de [SUA SOLUCAO]:
- [RESULTADO 1]
- [RESULTADO 2]
- [RESULTADO 3]

"[DEPOIMENTO]"
— [NOME DO CLIENTE]

Quer saber como funcionaria pra voce?

[CTA]

[SEU NOME]
```

#### Dia 17: Ultimo Contato

**Assunto:** [NOME], posso encerrar?

```
[NOME],

Tentei te contatar algumas vezes sobre [TEMA].

Como nao tive retorno, vou assumir que nao e prioridade agora.

Sem problema! Se mudar, estou a disposicao.

Se eu entendi errado e voce quer conversar,
e so responder "Sim" que agendo uma call.

Abraco,
[SEU NOME]
```

---

### TELEFONE

#### Dia 7: Primeira Call

```
ABERTURA:
"Oi [NOME], aqui e [SEU NOME] da [EMPRESA].
Te mandei algumas mensagens sobre [TEMA].
Posso tomar 2 minutos do seu tempo?"

SE SIM:
"Vi que voce [ACAO DO LEAD]. Me conta,
qual seu maior desafio com [AREA] hoje?"

[QUALIFICAR COM BANT]

FECHAMENTO:
"Pelo que me contou, acho que faz sentido
conversarmos mais. Que tal uma call de 30 min?"
```

#### Dia 14: Segunda Tentativa

```
"Oi [NOME], [SEU NOME] novamente.

Sei que esta corrido, mas queria muito entender
se [SOLUCAO] faz sentido pra voce.

Tem 5 minutos agora ou prefere que eu ligue
em outro horario?"
```

---

## 3. REGRAS DE SAIDA

### Quando Parar o Follow-up

| Situacao | Acao |
|----------|------|
| Lead respondeu positivo | Mover para proxima etapa |
| Lead pediu para parar | Remover da cadencia |
| Lead disse "nao agora" | Agendar recontato em 30d |
| 10 toques sem resposta | Encerrar cadencia |
| Lead converteu | Remover da cadencia |

---

## 4. AUTOMACAO

### Fluxo n8n/Make

```
TRIGGER: Novo lead no CRM
         │
         ▼
    [Dia 0] WhatsApp boas-vindas
         │
         ▼
    [Wait 1 dia]
         │
         ▼
    [Dia 1] WhatsApp valor
         │
         ▼
    [Wait 2 dias]
         │
         ▼
    [Dia 3] Email conteudo
         │
         ▼
    [Verificar: Respondeu?]
         │
    ┌────┴────┐
   SIM       NAO
    │         │
    ▼         ▼
  Parar    Continuar
cadencia   cadencia
```

### Configuracao

| Etapa | Ferramenta | Trigger |
|-------|------------|---------|
| WhatsApp | Evolution API | Webhook + delay |
| Email | SendGrid/Mailgun | Webhook + delay |
| CRM Update | API do CRM | Apos cada acao |
| Notificacao | Slack/Email | Se lead responder |

---

## 5. METRICAS DA CADENCIA

### Dashboard

| Metrica | Dia 0 | Dia 1 | Dia 3 | Dia 5 | Dia 7 | Dia 10 | Dia 12 | Dia 14 | Dia 17 | Dia 21 |
|---------|-------|-------|-------|-------|-------|--------|--------|--------|--------|--------|
| Enviados | | | | | | | | | | |
| Entregues | | | | | | | | | | |
| Abertos | | | | | | | | | | |
| Respondidos | | | | | | | | | | |

### Taxas por Canal

| Canal | Enviados | Taxa Resposta | Meta |
|-------|----------|---------------|------|
| WhatsApp | | ___% | > 15% |
| Email | | ___% | > 5% |
| Telefone | | ___% | > 10% |

---

## 6. PROMPT DE IA PARA MENSAGENS

```
Crie sequencia de follow-up:

MEU PRODUTO: ___
ICP: ___
PRINCIPAL DOR: ___
PRINCIPAL BENEFICIO: ___

CONTEXTO DO LEAD:
- Origem: ___
- Interesse demonstrado: ___
- Informacoes coletadas: ___

Gere:
1. 5 mensagens WhatsApp (dias 0, 1, 5, 12, 21)
2. 3 emails (dias 3, 10, 17)
3. 2 scripts de telefone (dias 7, 14)

Tom: [Profissional / Casual / Urgente]
Tamanho: WhatsApp curto, Email medio
```

---

## 7. CHECKLIST DE VALIDACAO

- [ ] Cadencia de 10+ toques definida
- [ ] Mensagens de todos os canais criadas
- [ ] Regras de saida configuradas
- [ ] Automacao implementada
- [ ] Metricas sendo coletadas
- [ ] Time treinado

---

## 8. COMPROMISSO 48H

**Meu compromisso:**

- [ ] Criar 10 mensagens de follow-up
- [ ] Configurar 1 sequencia automatizada
- [ ] Ativar para novos leads

**Ferramenta:** n8n / Make / Manual
**Status:** ___

---

**Template versao:** 1.0
**Trilha:** Vendas com IA
**Modulo:** 3 - Follow-up Automatizado
