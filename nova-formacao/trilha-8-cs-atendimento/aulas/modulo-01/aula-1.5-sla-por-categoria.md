# Aula 1.5: SLA Por Categoria - A Regra de Ouro

## Trilha 8 - CS e Atendimento | Modulo 1

---

> **Duracao:** 7 minutos
> **Tipo:** Template (Framework Pratico)
> **Entregavel:** Tabela de SLAs Definida
> **Linha do DRE:** Eficiencia Operacional

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM DIRETO]

"SLA. Service Level Agreement.
Acordo de Nivel de Servico.

Em portugues claro: QUANTO TEMPO voce promete responder.

A maioria dos empresarios nao tem SLA definido.
Resultado: tudo e urgente, nada e urgente.
Atendente nao sabe o que priorizar.
Cliente nao sabe quando vai ter resposta.

Hoje vamos definir SEU SLA por categoria.
Isso muda completamente como voce gerencia atendimento."
```

---

### OS 2 TIPOS DE SLA (1.5 minutos)

```
[MOSTRAR DIAGRAMA]

"Existem 2 SLAs que voce precisa definir:

1. SLA de PRIMEIRA RESPOSTA
   Quanto tempo ate o cliente receber a primeira mensagem?
   Pode ser automatica.
   'Recebemos sua mensagem, vamos analisar.'

2. SLA de RESOLUCAO
   Quanto tempo ate o problema estar RESOLVIDO?
   Essa e a que importa pro cliente.

[MOSTRAR EXEMPLO]

Se cliente manda ticket as 9h:
- SLA 1a resposta: 1 hora → responde ate 10h
- SLA resolucao: 4 horas → resolve ate 13h

[MOSTRAR ERRO COMUM]

Erro comum: so medir primeira resposta.
'Respondemos rapido!'
Mas demora 3 dias pra resolver.

Cliente nao quer resposta rapida.
Quer SOLUCAO rapida."
```

---

### SLA POR CATEGORIA (2 minutos)

```
[MOSTRAR TABELA NA TELA]

"Cada categoria merece SLA diferente.

[MOSTRAR TABELA]

| Categoria | SLA 1a Resposta | SLA Resolucao |
|-----------|-----------------|---------------|
| Duvida | 2h | 4h |
| Problema Tecnico | 1h | 24h |
| Financeiro | 1h | 48h |
| Onboarding | 30min | 2h |
| Status | Automatico | Automatico |
| Reclamacao | 30min | 24h |

[EXPLICAR LOGICA]

Por que reclamacao tem 30 minutos?
Porque cliente irritado que espera fica MAIS irritado.
Cada hora de espera aumenta chance de Reclame Aqui.

Por que problema tecnico tem 24h de resolucao?
Porque exige diagnostico, teste, as vezes envolver dev.
Nao da pra prometer 2 horas.

Por que status e automatico?
Porque NAO DEVERIA SER TICKET.
Sistema notifica. Cliente nao precisa perguntar."
```

---

### COMO DEFINIR SEU SLA (1.5 minutos)

```
[MOSTRAR FRAMEWORK]

"Use essa formula pra definir seu SLA:

1. Qual a EXPECTATIVA do cliente?
   (pesquisa ou bom senso)

2. Qual sua CAPACIDADE atual?
   (quantos tickets/hora sua equipe resolve)

3. Qual o RISCO de demorar?
   (cliente cancela? reclama publico? processo?)

[MOSTRAR EXEMPLO]

Exemplo: ticket de reembolso

1. Expectativa: cliente quer resposta no mesmo dia
2. Capacidade: financeiro resolve 5 casos/dia
3. Risco: alto (chargeback, Reclame Aqui)

SLA definido:
- 1a resposta: 1 hora (mostra que recebeu)
- Resolucao: 48 horas (tempo real pra analisar)

[MOSTRAR DICA]

Dica: e melhor prometer 48h e entregar em 24h
do que prometer 24h e entregar em 48h.

Under-promise, over-deliver."
```

---

### O QUE FAZER QUANDO ESTOURA (1 minuto)

```
[TOM DE ALERTA]

"SLA vai estourar. E normal.
O que importa e o que voce faz quando estoura.

[MOSTRAR PROTOCOLO]

Protocolo de estouro:

1. ALERTAR antes de estourar
   Se falta 1 hora pro SLA, escala.
   Nao espera estourar.

2. COMUNICAR o cliente
   'Ainda estamos trabalhando no seu caso.
   Previsao atualizada: [nova data].'

3. REGISTRAR por que estourou
   Volume alto? Caso complexo? Falta de gente?
   Sem dado, nao melhora.

4. COMPENSAR se necessario
   Desconto, brinde, pedido de desculpas.
   Cliente valoriza honestidade.

[MOSTRAR METRICA]

Metrica pra acompanhar:
% de tickets dentro do SLA

Meta: >90%
Atencao: 80-90%
Critico: <80%"
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Agora voce tem os 2 SLAs definidos.
Primeira resposta e resolucao.
Por categoria.

Isso muda o jogo.
Sua equipe sabe o que priorizar.
Seu cliente sabe quando esperar resposta.
Voce sabe quando ta falhando.

Na proxima aula, vou te mostrar como isso tudo
se junta no Funil de Suporte Instrumentado.
Com exemplo real preenchido.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Tabela de SLA Recomendado

| Categoria | SLA 1a Resposta | SLA Resolucao | Nivel |
|-----------|-----------------|---------------|-------|
| Duvida | 2h | 4h | L1 |
| Problema Tecnico | 1h | 24h | L2 |
| Financeiro | 1h | 48h | L2 |
| Onboarding | 30min | 2h | L1 |
| Status | Automatico | Automatico | Auto |
| Reclamacao | 30min | 24h | L2 |

### Template: Seu SLA

| Categoria | SLA 1a Resposta | SLA Resolucao | Quem Resolve |
|-----------|-----------------|---------------|--------------|
| Duvida | ___ | ___ | ___ |
| Problema Tecnico | ___ | ___ | ___ |
| Financeiro | ___ | ___ | ___ |
| Onboarding | ___ | ___ | ___ |
| Status | ___ | ___ | ___ |
| Reclamacao | ___ | ___ | ___ |

### Formula para Definir SLA

```
SLA = Expectativa do Cliente + Capacidade Interna + Nivel de Risco
```

| Fator | Pergunta |
|-------|----------|
| Expectativa | Quanto o cliente espera? |
| Capacidade | Quantos resolvemos por hora? |
| Risco | O que acontece se demorar? |

### Protocolo de Estouro de SLA

```
1. ALERTAR: 1h antes do estouro, escala
2. COMUNICAR: Avisa cliente com nova previsao
3. REGISTRAR: Documenta motivo do estouro
4. COMPENSAR: Se necessario, oferece algo
```

### Metricas de SLA

| Metrica | Meta | Atencao | Critico |
|---------|------|---------|---------|
| % dentro SLA | >90% | 80-90% | <80% |
| Tempo medio 1a resposta | <SLA | SLA | >SLA |
| Tempo medio resolucao | <SLA | SLA | >SLA |

---

## PROMPT DE IA PARA DEFINIR SLA

```
Ajude-me a definir SLAs para meu atendimento:

MEU NEGOCIO: [descreva]

VOLUME DIARIO DE TICKETS: [numero]

EQUIPE DE ATENDIMENTO: [quantas pessoas]

HORARIO DE ATENDIMENTO: [ex: 8h-18h]

CATEGORIAS E VOLUME:
[cole sua tabela de categorias]

Para cada categoria, sugira:
1. SLA de primeira resposta (realista pra minha estrutura)
2. SLA de resolucao
3. Quem deveria resolver (L1, L2, especialista)
4. O que acontece se estourar SLA

Considere:
- Expectativa do cliente
- Minha capacidade atual
- Risco de cada categoria
```

---

## CHECKPOINT

- [ ] Entendi diferenca entre SLA 1a resposta e resolucao
- [ ] Defini SLA por categoria
- [ ] Sei o que fazer quando SLA estoura
- [ ] Tenho meta de % dentro do SLA
- [ ] Sei quem resolve cada categoria (L1/L2)

---

## CONEXAO COM PROXIMA AULA

> Temos todas as pecas: canais, volume, categorias, SLAs. Agora vou mostrar tudo junto no Funil de Suporte.

**Proxima:** Aula 1.6 - Demo: Funil de Suporte Preenchido

---

**Tempo real:** 7 minutos
**Impacto DRE:** Eficiencia operacional e previsibilidade
