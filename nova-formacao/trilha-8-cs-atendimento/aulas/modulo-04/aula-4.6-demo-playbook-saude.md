# Aula 4.6: Demo - Playbook de Saude Funcionando

## Trilha 8 - CS e Atendimento | Modulo 4

---

> **Duracao:** 10 minutos
> **Tipo:** Demo (Exemplo Real)
> **Entregavel:** Referencia do Sistema Completo
> **Linha do DRE:** Prova de Conceito

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM EMPOLGADO]

"Hora de ver tudo junto.

Health Score calculado.
Faixas identificadas.
Intervencoes acionadas.

Vou rodar 5 clientes reais
e mostrar o que o sistema faz
do inicio ao fim."
```

---

### O SETUP DO SISTEMA (1.5 minutos)

```
[COMPARTILHAR TELA - PLANILHA/SISTEMA]

"Primeiro, o setup.

[MOSTRAR ESTRUTURA]

Tenho uma planilha com:

COLUNAS DE DADOS:
- Cliente
- Logins ultimos 7 dias
- Ultimo NPS
- Ticket aberto?
- Respondeu ultimo email?
- Pagamento em dia?

COLUNAS CALCULADAS:
- Score Engajamento
- Score Satisfacao
- Score Adocao
- Score Relacionamento
- Score Financeiro
- HEALTH SCORE TOTAL
- FAIXA
- ACAO RECOMENDADA

[MOSTRAR FORMULA]

Formula do Health Score:

=SE(E2>0;10;0) + SE(E2>3;10;0) + SE(E2>7;10;0)   [Engajamento]
+SE(F2>=9;25;SE(F2>=7;15;0))                      [Satisfacao]
+SE(G2='Nao';10;0) + 10                           [Adocao]
+SE(H2='Sim';10;0) + 5                            [Relacionamento]
+SE(I2='Sim';10;0)                                [Financeiro]

Isso da um score de 0 a 100."
```

---

### CLIENTE 1: VERDE - EXPANDIR (1.5 minutos)

```
[MOSTRAR CLIENTE 1]

"Primeiro cliente: Maria.

[MOSTRAR DADOS]

DADOS:
- Logins ultimos 7 dias: 12
- Ultimo NPS: 9
- Ticket aberto: Nao
- Respondeu email: Sim
- Pagamento: Em dia

CALCULO:
- Engajamento: 30/30 (loga todo dia)
- Satisfacao: 25/25 (NPS 9)
- Adocao: 20/20 (usa features)
- Relacionamento: 15/15 (responde)
- Financeiro: 10/10 (paga em dia)

HEALTH SCORE: 100/100 🟢

FAIXA: SAUDAVEL

[MOSTRAR ACAO]

ACAO AUTOMATICA:
- Email de check-in enviado
- Sugestao de upgrade Pro agendada
- Pedido de indicacao na fila

Maria e cliente pra crescer, nao pra manter."
```

---

### CLIENTE 2: AMARELO LEVE - MONITORAR (1.5 minutos)

```
[MOSTRAR CLIENTE 2]

"Segundo cliente: Joao.

[MOSTRAR DADOS]

DADOS:
- Logins ultimos 7 dias: 4
- Ultimo NPS: 8
- Ticket aberto: Nao
- Respondeu email: Nao
- Pagamento: Em dia

CALCULO:
- Engajamento: 20/30 (uso bom, nao otimo)
- Satisfacao: 15/25 (NPS 8, nao promotor)
- Adocao: 20/20 (usa bem)
- Relacionamento: 5/15 (nao respondeu ultimo email)
- Financeiro: 10/10 (ok)

HEALTH SCORE: 70/100 🟡

FAIXA: ATENCAO

[MOSTRAR ACAO]

ACAO RECOMENDADA:
- Tarefa criada pro CS
- Prazo: 7 dias
- Template: 'Tudo bem por ai?'
- Objetivo: re-engajar

Joao nao ta em risco grave.
Mas precisa de um toque."
```

---

### CLIENTE 3: AMARELO GRAVE - INTERVIR (1.5 minutos)

```
[MOSTRAR CLIENTE 3]

"Terceiro cliente: Pedro.

[MOSTRAR DADOS]

DADOS:
- Logins ultimos 7 dias: 1
- Ultimo NPS: 6
- Ticket aberto: Sim (nao resolvido)
- Respondeu email: Nao
- Pagamento: Em dia

CALCULO:
- Engajamento: 10/30 (uso minimo)
- Satisfacao: 0/25 (NPS 6 = detrator)
- Adocao: 10/20 (usa pouco)
- Relacionamento: 0/15 (nao responde)
- Financeiro: 10/10 (paga, por enquanto)

HEALTH SCORE: 45/100 🟡

FAIXA: ATENCAO GRAVE

[MOSTRAR ACAO]

ACAO URGENTE:
- Resolver ticket HOJE
- Contato proativo AMANHA
- Oferecer call de suporte
- Monitorar proximos 14 dias

Pedro ta a caminho do vermelho.
Janela de intervencao: CURTA."
```

---

### CLIENTE 4: VERMELHO - EMERGENCIA (1.5 minutos)

```
[MOSTRAR CLIENTE 4]

"Quarto cliente: Ana.

[MOSTRAR DADOS]

DADOS:
- Logins ultimos 7 dias: 0
- Ultimo NPS: 4 (detrator)
- Ticket aberto: Sim (reclamacao grave)
- Respondeu email: Nao
- Pagamento: Atrasado

CALCULO:
- Engajamento: 0/30 (zerado)
- Satisfacao: 0/25 (detrator)
- Adocao: 0/20 (nao usa)
- Relacionamento: 0/15 (sumiu)
- Financeiro: 0/10 (atrasado)

HEALTH SCORE: 0/100 🔴

FAIXA: RISCO CRITICO

[MOSTRAR ACAO]

ACAO IMEDIATA:
- Notificacao URGENTE pro gestor
- Ligar HOJE
- Resolver ticket na hora
- Oferecer pausa de cobranca
- 3 tentativas em 7 dias

Ana ja ta com um pe fora.
Ultima chance."
```

---

### CLIENTE 5: RECUPERADO - CASO DE SUCESSO (1 minuto)

```
[MOSTRAR CLIENTE 5]

"Quinto cliente: Carlos.

[MOSTRAR HISTORICO]

HISTORICO:
- Mes passado: Score 35 (vermelho)
- Intervencao: call com gestor
- Problema: nao sabia usar feature X
- Solucao: treinamento personalizado
- Resultado: voltou a usar

HOJE:
- Logins: 8
- NPS: 9
- Ticket: Nenhum
- Pagamento: Em dia

HEALTH SCORE: 85/100 🟢

[MOSTRAR LICAO]

LICAO:
Carlos ia cancelar.
Sistema detectou.
Intervimos a tempo.
Hoje e promotor.

Esse e o poder do Health Score."
```

---

### RESUMO DA DEMO (1 minuto)

```
[MOSTRAR DASHBOARD]

"Resumo dos 5 clientes:

| Cliente | Score | Faixa | Acao |
|---------|-------|-------|------|
| Maria | 100 | Verde | Expandir |
| Joao | 70 | Amarelo | Check-in |
| Pedro | 45 | Amarelo | Intervir |
| Ana | 0 | Vermelho | Emergencia |
| Carlos | 85 | Verde | Recuperado |

DISTRIBUICAO:
- Verde: 40% (2)
- Amarelo: 40% (2)
- Vermelho: 20% (1)

[MOSTRAR INSIGHT]

Em 5 clientes:
- 2 pra crescer
- 2 pra cuidar
- 1 pra salvar

Voce sabe exatamente o que fazer."
```

---

### FECHAMENTO (30 segundos)

```
[OLHAR DIRETO PARA CAMERA]

"Isso e um sistema de Health Score funcionando.

Calculo automatico.
Faixas claras.
Acoes definidas.

Na proxima aula, voce vai construir o SEU.
30 minutos de exercicio pratico.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Estrutura da Planilha de Health Score

| Coluna | Tipo | Exemplo |
|--------|------|---------|
| A: Cliente | Texto | Maria Silva |
| B: Logins 7 dias | Numero | 12 |
| C: Ultimo NPS | Numero | 9 |
| D: Ticket aberto | Sim/Nao | Nao |
| E: Respondeu email | Sim/Nao | Sim |
| F: Pagamento | Status | Em dia |
| G: Score Eng | Calculado | 30 |
| H: Score Sat | Calculado | 25 |
| I: Score Ado | Calculado | 20 |
| J: Score Rel | Calculado | 15 |
| K: Score Fin | Calculado | 10 |
| L: TOTAL | Calculado | 100 |
| M: FAIXA | Calculado | Verde |
| N: ACAO | Calculado | Expandir |

### Formulas de Calculo (Google Sheets/Excel)

```
ENGAJAMENTO (G):
=SE(B2>7;30;SE(B2>3;20;SE(B2>0;10;0)))

SATISFACAO (H):
=SE(C2>=9;25;SE(C2>=7;15;0)) - SE(D2="Sim";5;0)

ADOCAO (I):
=SE(B2>0;10;0) + 10

RELACIONAMENTO (J):
=SE(E2="Sim";10;0) + 5

FINANCEIRO (K):
=SE(F2="Em dia";10;SE(F2="Atrasado";0;5))

TOTAL (L):
=G2+H2+I2+J2+K2

FAIXA (M):
=SE(L2>=80;"Verde";SE(L2>=40;"Amarelo";"Vermelho"))

ACAO (N):
=SE(M2="Verde";"Expandir";SE(M2="Amarelo";"Intervir";"Emergencia"))
```

### Resumo da Demo

| Cliente | Score | Faixa | Sinais | Acao |
|---------|-------|-------|--------|------|
| Maria | 100 | Verde | Tudo positivo | Upgrade + indicacao |
| Joao | 70 | Amarelo | Nao respondeu email | Check-in 7 dias |
| Pedro | 45 | Amarelo | NPS baixo, ticket aberto | Resolver + call |
| Ana | 0 | Vermelho | Zerado em tudo | Emergencia HOJE |
| Carlos | 85 | Verde | Recuperado de vermelho | Manter |

---

## PROMPT DE IA PARA ANALISE

```
Analise esta base de clientes e identifique acoes:

BASE DE CLIENTES:
[Cole tabela com colunas: Cliente, Logins, NPS, Ticket, Email, Pagamento]

Para cada cliente:
1. Calcule o Health Score (0-100)
2. Classifique a faixa (verde/amarelo/vermelho)
3. Identifique o principal sinal de risco
4. Recomende acao especifica
5. Defina prazo de intervencao

Ao final, gere:
- Distribuicao por faixa
- Clientes mais urgentes
- Acao prioritaria do dia
```

---

## CHECKPOINT

- [ ] Vi o sistema de Health Score funcionando
- [ ] Entendi como os dados viram score
- [ ] Vi exemplos de cada faixa
- [ ] Entendi as acoes automaticas
- [ ] Vi um caso de recuperacao

---

## CONEXAO COM PROXIMA AULA

> Demo completa. Agora e sua vez de construir seu Playbook de Saude.

**Proxima:** Aula 4.7 - Exercicio: Seu Playbook de Saude

---

**Tempo real:** 10 minutos
**Impacto DRE:** Prova de conceito do sistema completo
