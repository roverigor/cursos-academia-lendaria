# Aula 2.8: Teste e Validacao

## Trilha 8 - CS e Atendimento | Modulo 2

---

> **Duracao:** 12 minutos
> **Tipo:** Validacao (Teste Pratico)
> **Entregavel:** KB Validada + Acao de 48h
> **Linha do DRE:** Sistema Testado e Aprovado

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM PRATICO]

"Voce construiu a KB.
Agora vamos testar se funciona.

Vou te guiar pra rodar 10 tickets reais
no seu Motor de Resposta.

Se 8 de 10 sairem bons, sua KB ta aprovada.
Se menos de 8, a gente identifica o que ajustar.

Pega 10 tickets reais do seu atendimento.
Vamos testar."
```

---

### PASSO 1: SELECIONAR 10 TICKETS (2 minutos)

```
[MOSTRAR CRITERIOS]

"Primeiro: escolhe 10 tickets pra testar.

[MOSTRAR CRITERIOS]

Criterios de selecao:
- Tickets REAIS (nao invente)
- Variedade de categorias
- Pelo menos 1 de cada tipo:
  - 3 duvidas simples
  - 2 duvidas de politica
  - 2 problemas tecnicos
  - 2 financeiros
  - 1 reclamacao

[MOSTRAR ONDE ACHAR]

Onde achar:
- Ultimos emails de suporte
- Historico do WhatsApp
- Sistema de helpdesk

[MOSTRAR DICA]

Dica: escolhe tickets que JA foram respondidos.
Assim voce compara resposta humana vs IA.

PAUSE E SELECIONE 10 TICKETS.
2 minutos."
```

---

### PASSO 2: RODAR NO MOTOR (4 minutos)

```
[COMPARTILHAR TELA - CHATGPT]

"Agora vamos rodar cada ticket.

[MOSTRAR PROCESSO]

Processo:
1. Abre o ChatGPT/Claude
2. Cola seu Motor de Resposta (com KB)
3. Cola o primeiro ticket
4. Envia
5. Avalia a resposta
6. Anota: BOM ou AJUSTE NECESSARIO
7. Repete pro proximo ticket

[MOSTRAR EXEMPLO]

Vou fazer com voce os 2 primeiros.

TICKET 1: [mostra ticket simples]
[Cola no Motor]
[Mostra resposta]

Avaliacao:
- Tom: OK
- Info: Correta
- Proximo passo: Claro
Veredicto: BOM ✓

TICKET 2: [mostra ticket de politica]
[Cola no Motor]
[Mostra resposta]

Avaliacao:
- Tom: OK
- Info: Faltou prazo de estorno
- Proximo passo: OK
Veredicto: AJUSTE (adicionar info na KB)

[MOSTRAR INSTRUCAO]

Agora faz os outros 8.
Anota em uma tabela: ticket | veredicto | ajuste

PAUSE E RODE OS 10 TICKETS.
4 minutos."
```

---

### PASSO 3: AVALIAR RESULTADOS (2 minutos)

```
[MOSTRAR TABELA DE AVALIACAO]

"Terminou de rodar? Vamos avaliar.

[MOSTRAR CRITERIOS]

Conta quantos foram BOM vs AJUSTE:

| Resultado | Significado |
|-----------|-------------|
| 8-10 BOM | KB aprovada, pronta pra usar |
| 6-7 BOM | KB ok, precisa de refinamentos |
| < 6 BOM | KB precisa de trabalho |

[MOSTRAR ANALISE]

Se teve AJUSTE, identifica o padrao:

'Faltou info' → Adiciona na KB
'Tom errado' → Ajusta Tom de Voz
'Resposta incompleta' → Expande FAQ
'Deveria escalar' → Ajusta regra de escalar
'Escalou errado' → Refina criterio

[MOSTRAR EXEMPLO]

Exemplo de analise:
- 3 tickets faltou info sobre prazo → Adicionar prazos em todas FAQs
- 2 tickets tom muito formal → Ajustar Tom de Voz
- 1 ticket nao escalou quando deveria → Adicionar regra

Isso e o refinamento. Normal na v1."
```

---

### PASSO 4: FAZER AJUSTES (2 minutos)

```
[MOSTRAR PROCESSO DE AJUSTE]

"Agora vamos ajustar.

[MOSTRAR PRIORIDADE]

Prioridade de ajuste:
1. Info errada → Corrigir AGORA
2. Info faltando → Adicionar
3. Tom inadequado → Ajustar
4. Regra de escalar → Refinar

[MOSTRAR COMO AJUSTAR]

Como ajustar:
- Abre sua KB
- Faz a correcao
- Roda novamente os tickets que falharam
- Confirma que agora funciona

[MOSTRAR CICLO]

Esse ciclo e continuo:
Ticket → Teste → Ajuste → Teste → Aprovado

Quanto mais usa, mais afinado fica.

PAUSE E FACA OS AJUSTES.
2 minutos."
```

---

### PASSO 5: DEFINIR ACAO DE 48H (1 minuto)

```
[ENERGIA ALTA - COMPROMISSO]

"Ultima parte: sua acao de 48 horas.

[MOSTRAR OPCOES]

Escolhe UMA:

OPCAO 1: USAR EM PRODUCAO
Se 8+ tickets passaram:
- Use o Motor nos proximos 10 atendimentos reais
- Anote o que precisou ajustar

OPCAO 2: EXPANDIR KB
Se faltou muita info:
- Adicione mais 10 FAQs
- Documente mais 1 politica
- Crie mais 2 how-tos

OPCAO 3: TREINAR EQUIPE
Se voce tem time:
- Mostre o Motor pra equipe
- Faca eles testarem
- Colete feedback

OPCAO 4: REFINAR TOM
Se o tom estava errado:
- Reescreva secao Tom de Voz
- Adicione mais exemplos
- Teste novamente

[MOSTRAR COMPROMISSO]

Qual voce vai fazer?
Anota. Coloca alarme. 48 horas."
```

---

### FECHAMENTO DO MODULO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA - CELEBRACAO]

"Voce completou o Modulo 2!

Agora voce tem:
- Base de Conhecimento v1
- Motor de Resposta funcionando
- Sistema testado com tickets reais
- Acao de 48h definida

No proximo modulo, vamos automatizar a TRIAGEM.

Sabe aquele tempo que se perde LENDO ticket
antes de saber o que fazer com ele?

Vamos eliminar isso.
IA vai classificar, priorizar e rotear automaticamente.

Descansa. Executa sua acao.
Te vejo no Modulo 3."
```

---

## MATERIAL DE APOIO

### Tabela de Teste dos 10 Tickets

| # | Ticket (resumo) | Categoria | Veredicto | Ajuste Necessario |
|---|-----------------|-----------|-----------|-------------------|
| 1 | | | BOM / AJUSTE | |
| 2 | | | BOM / AJUSTE | |
| 3 | | | BOM / AJUSTE | |
| 4 | | | BOM / AJUSTE | |
| 5 | | | BOM / AJUSTE | |
| 6 | | | BOM / AJUSTE | |
| 7 | | | BOM / AJUSTE | |
| 8 | | | BOM / AJUSTE | |
| 9 | | | BOM / AJUSTE | |
| 10 | | | BOM / AJUSTE | |

**TOTAL BOM:** ___ / 10

### Criterios de Avaliacao

| Aspecto | BOM | AJUSTE |
|---------|-----|--------|
| Tom | Adequado a marca | Formal/informal demais |
| Info | Correta e completa | Errada ou incompleta |
| Proximo passo | Claro | Vago ou ausente |
| Escalar | Escalou quando devia | Escalou errado |

### Interpretacao dos Resultados

| BOM | Status | Acao |
|-----|--------|------|
| 8-10 | Aprovada | Usar em producao |
| 6-7 | Ok | Refinamentos pontuais |
| 4-5 | Regular | Revisar estrutura |
| < 4 | Insuficiente | Reconstruir KB |

### Padroes Comuns de Ajuste

| Problema | Causa | Solucao |
|----------|-------|---------|
| Faltou info | FAQ incompleta | Expandir respostas |
| Info errada | KB desatualizada | Corrigir dados |
| Tom errado | Tom de Voz vago | Adicionar exemplos |
| Nao escalou | Criterio frouxo | Adicionar regras |
| Escalou demais | Criterio rigido | Relaxar regras |

---

## PROMPT DE IA PARA ANALISE

```
Analise os resultados do meu teste de KB:

TICKETS TESTADOS:
[Liste os 10 com veredicto]

PADROES DE AJUSTE IDENTIFICADOS:
[Liste o que deu errado]

Perguntas:
1. Minha KB esta boa ou precisa de trabalho?
2. Qual o padrao mais comum de erro?
3. O que devo priorizar no ajuste?
4. Preciso de mais FAQs ou de melhorar as existentes?
5. Meu Tom de Voz esta adequado?
```

---

## CHECKPOINT FINAL DO MODULO

- [ ] 10 tickets testados no Motor
- [ ] Pelo menos 8/10 aprovados (ou ajustes feitos)
- [ ] Padroes de erro identificados
- [ ] Ajustes implementados na KB
- [ ] Acao de 48h definida

---

## ENTREGAVEL DO MODULO 2

**KB v1 + Motor de Resposta** contendo:
- 20-40 FAQs organizadas por categoria
- 3+ politicas documentadas
- 5+ how-tos com passo a passo
- Tom de Voz definido
- Prompt Motor de Resposta montado
- Testado com 10 tickets reais
- Taxa de aprovacao >= 80%

---

## CONEXAO COM PROXIMO MODULO

> **Modulo 3: Triagem e Automacao**
>
> Voce vai automatizar a classificacao de tickets:
> categoria, urgencia, risco, roteamento.
> IA vai decidir pra onde cada ticket vai
> ANTES de humano precisar ler.
>
> Pre-requisito: KB funcionando (este modulo)

---

**Tempo real:** 12 minutos
**Impacto DRE:** Sistema de resposta validado e pronto

---

**FIM DO MODULO 2**
