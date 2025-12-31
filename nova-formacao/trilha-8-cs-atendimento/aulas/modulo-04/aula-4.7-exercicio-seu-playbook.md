# Aula 4.7: Exercicio - Seu Playbook de Saude

## Trilha 8 - CS e Atendimento | Modulo 4

---

> **Duracao:** 30 minutos
> **Tipo:** Pratica (Build Sprint)
> **Entregavel:** Playbook de Saude Completo
> **Linha do DRE:** Sistema de Retencao Pronto

---

## ROTEIRO DE FALA

### ABERTURA (1 minuto)

```
[OLHAR PARA CAMERA - ENERGIA ALTA]

"30 minutos pra construir seu Playbook de Saude.

Voce vai sair com:
- Formula de Health Score personalizada
- Planilha de calculo funcionando
- Top 20 clientes classificados
- Intervencoes definidas por faixa
- Primeira acao agendada

Vamos la. Passo a passo."
```

---

### PASSO 1: DEFINIR INDICADORES (5 minutos)

```
[MOSTRAR TEMPLATE]

"Primeiro: seus indicadores.

[MOSTRAR ESTRUTURA]

Escolha 5-8 indicadores que voce CONSEGUE medir:

ENGAJAMENTO (peso sugerido: 30%)
□ Logins/acessos ultimos 7 dias
□ Tempo de sessao
□ Features usadas
□ Outro: _______________

SATISFACAO (peso sugerido: 25%)
□ Ultimo NPS/CSAT
□ Ticket aberto sem resolver
□ Reclamacao recente
□ Outro: _______________

ADOCAO (peso sugerido: 20%)
□ Onboarding completo
□ Feature principal usada
□ Multiplas features
□ Outro: _______________

RELACIONAMENTO (peso sugerido: 15%)
□ Respondeu ultimo email
□ Abriu newsletter
□ Teve call recente
□ Outro: _______________

FINANCEIRO (peso sugerido: 10%)
□ Pagamento em dia
□ Sem contestacao
□ Renovacao confirmada
□ Outro: _______________

[MOSTRAR DICA]

Dica: escolha indicadores que voce JA TEM dados.
Nao inventa indicador que voce nao consegue medir.

PAUSE E ESCOLHA SEUS INDICADORES.
5 minutos."
```

---

### PASSO 2: CRIAR FORMULA (5 minutos)

```
[MOSTRAR FORMULA]

"Segundo: sua formula.

[MOSTRAR TEMPLATE]

Para cada indicador, defina a pontuacao:

INDICADOR 1: _______________
- Criterio positivo: +___ pontos
- Criterio negativo: ___ pontos

INDICADOR 2: _______________
- Criterio positivo: +___ pontos
- Criterio negativo: ___ pontos

[... ate indicador 5-8]

[MOSTRAR VALIDACAO]

Valide:
- Soma maxima = 100 pontos? ___
- Pesos fazem sentido pro seu negocio? ___
- Consegue coletar todos os dados? ___

[MOSTRAR EXEMPLO]

Minha formula:
1. Logins > 5 na semana: +20
2. Logins 1-4 na semana: +10
3. NPS >= 9: +25 | NPS 7-8: +15 | NPS < 7: 0
4. Ticket sem resolver: -10
5. Respondeu email: +15
6. Pagamento em dia: +10
7. Feature principal usada: +10
8. Onboarding completo: +10

Max: 20+25+0+15+10+10+10 = 90 (ajusto +10 base)

PAUSE E CRIE SUA FORMULA.
5 minutos."
```

---

### PASSO 3: MONTAR PLANILHA (5 minutos)

```
[COMPARTILHAR TELA - PLANILHA]

"Terceiro: planilha de calculo.

[MOSTRAR ESTRUTURA]

Colunas:
A: Cliente (nome)
B-H: Seus indicadores (dados brutos)
I-M: Scores por pilar (calculado)
N: HEALTH SCORE TOTAL
O: FAIXA (Verde/Amarelo/Vermelho)
P: ACAO RECOMENDADA

[MOSTRAR FORMULAS]

Formulas base:

FAIXA (coluna O):
=SE(N2>=80;'Verde';SE(N2>=40;'Amarelo';'Vermelho'))

ACAO (coluna P):
=SE(O2='Verde';'Expandir';SE(O2='Amarelo';'Intervir 7d';'URGENTE HOJE'))

FORMATACAO CONDICIONAL:
- Verde: fundo verde
- Amarelo: fundo amarelo
- Vermelho: fundo vermelho

[MOSTRAR DICA]

Dica: pode comecar no Google Sheets.
Depois migra pra sistema se quiser.

PAUSE E MONTE SUA PLANILHA.
5 minutos."
```

---

### PASSO 4: CLASSIFICAR TOP 20 (10 minutos)

```
[MOSTRAR PROCESSO]

"Quarto: classificar seus clientes.

[MOSTRAR INSTRUCAO]

1. Liste seus 20 maiores clientes
   (por receita ou importancia estrategica)

2. Preencha os dados de cada um
   (seus indicadores definidos no Passo 1)

3. Calcule o Health Score

4. Ordene do menor pro maior score

[MOSTRAR TABELA]

| # | Cliente | Score | Faixa |
|---|---------|-------|-------|
| 1 | | | |
| 2 | | | |
| 3 | | | |
... ate 20

[MOSTRAR ANALISE]

Depois de preencher, responda:
- Quantos em VERDE? ___
- Quantos em AMARELO? ___
- Quantos em VERMELHO? ___

Se > 20% em vermelho: voce tem problema serio.
Se > 50% em verde: voce ta bem, foca em expandir.

PAUSE E CLASSIFIQUE SEUS TOP 20.
10 minutos."
```

---

### PASSO 5: DEFINIR INTERVENCOES (4 minutos)

```
[MOSTRAR PLAYBOOK]

"Quinto: intervencoes por faixa.

[MOSTRAR TEMPLATE]

FAIXA VERDE (80-100):
- Acao padrao: _______________
- Frequencia: ___ dias
- Canal: _______________
- Objetivo: _______________

FAIXA AMARELA (40-79):
- Acao padrao: _______________
- Prazo: ___ dias
- Canal: _______________
- Objetivo: _______________

FAIXA VERMELHA (0-39):
- Acao padrao: _______________
- Prazo: _______________
- Responsavel: _______________
- Ofertas possiveis: _______________

[MOSTRAR EXEMPLO]

Meu playbook:
- Verde: email check-in mensal, oferta upgrade trimestral
- Amarelo: WhatsApp em 7 dias, oferecer call
- Vermelho: gestor liga HOJE, pausa cobranca se precisar

PAUSE E DEFINA SUAS INTERVENCOES.
4 minutos."
```

---

### FECHAMENTO (1 minuto)

```
[OLHAR DIRETO PARA CAMERA]

"Se voce seguiu os passos, agora tem:

- Formula de Health Score personalizada
- Planilha funcionando
- Top 20 clientes classificados
- Intervencoes por faixa

Na proxima aula, vamos validar seu playbook
e definir sua acao de 48 horas.

Te vejo la."
```

---

## MATERIAL DE APOIO

### Checklist de Construcao

```
PASSO 1: INDICADORES (5 min)
- [ ] 5-8 indicadores escolhidos
- [ ] Todos sao mensuraveis
- [ ] Pesos definidos (soma = 100%)

PASSO 2: FORMULA (5 min)
- [ ] Pontuacao por indicador definida
- [ ] Soma maxima = 100
- [ ] Formula faz sentido

PASSO 3: PLANILHA (5 min)
- [ ] Colunas de dados criadas
- [ ] Colunas de calculo funcionando
- [ ] Faixa automatica (Verde/Amarelo/Vermelho)
- [ ] Formatacao condicional aplicada

PASSO 4: TOP 20 (10 min)
- [ ] 20 clientes listados
- [ ] Dados preenchidos
- [ ] Score calculado
- [ ] Ordenado por score
- [ ] Distribuicao analisada

PASSO 5: INTERVENCOES (4 min)
- [ ] Acao para Verde definida
- [ ] Acao para Amarelo definida
- [ ] Acao para Vermelho definida
- [ ] Prazos claros
```

### Template: Formula de Health Score

```
MEU HEALTH SCORE:

PILAR 1: ENGAJAMENTO (___%)
- Indicador: _______________
  Criterio: se ___, +___ pontos

- Indicador: _______________
  Criterio: se ___, +___ pontos

PILAR 2: SATISFACAO (___%)
- Indicador: _______________
  Criterio: se ___, +___ pontos

PILAR 3: ADOCAO (___%)
- Indicador: _______________
  Criterio: se ___, +___ pontos

PILAR 4: RELACIONAMENTO (___%)
- Indicador: _______________
  Criterio: se ___, +___ pontos

PILAR 5: FINANCEIRO (___%)
- Indicador: _______________
  Criterio: se ___, +___ pontos

TOTAL MAXIMO: 100 pontos
```

### Template: Classificacao Top 20

| # | Cliente | Ind.1 | Ind.2 | Ind.3 | Ind.4 | Ind.5 | Score | Faixa |
|---|---------|-------|-------|-------|-------|-------|-------|-------|
| 1 | | | | | | | | |
| 2 | | | | | | | | |
| 3 | | | | | | | | |
| 4 | | | | | | | | |
| 5 | | | | | | | | |
| 6 | | | | | | | | |
| 7 | | | | | | | | |
| 8 | | | | | | | | |
| 9 | | | | | | | | |
| 10 | | | | | | | | |
| 11 | | | | | | | | |
| 12 | | | | | | | | |
| 13 | | | | | | | | |
| 14 | | | | | | | | |
| 15 | | | | | | | | |
| 16 | | | | | | | | |
| 17 | | | | | | | | |
| 18 | | | | | | | | |
| 19 | | | | | | | | |
| 20 | | | | | | | | |

**DISTRIBUICAO:**
- Verde (80-100): ___ clientes (__%)
- Amarelo (40-79): ___ clientes (__%)
- Vermelho (0-39): ___ clientes (__%)

### Template: Playbook de Intervencao

```
FAIXA VERDE (80-100):
Acao: _______________
Frequencia: _______________
Canal: _______________
Template: _______________

FAIXA AMARELA (40-79):
Acao: _______________
Prazo maximo: _______________
Canal: _______________
Template: _______________

FAIXA VERMELHA (0-39):
Acao: _______________
Prazo: HOJE
Responsavel: _______________
Ofertas: _______________
Template: _______________
```

---

## PROMPT DE IA PARA VALIDAR

```
Valide meu Playbook de Saude:

MINHA FORMULA:
[Cole sua formula com indicadores e pesos]

MEUS TOP 20 CLIENTES:
[Cole a tabela com scores]

MINHAS INTERVENCOES:
[Cole as acoes por faixa]

Perguntas:
1. A formula esta equilibrada?
2. A distribuicao dos clientes esta saudavel?
3. As intervencoes estao adequadas?
4. O que ajustar primeiro?
5. Qual acao priorizar HOJE?
```

---

## CHECKPOINT

- [ ] Formula de Health Score criada
- [ ] Planilha funcionando
- [ ] Top 20 clientes classificados
- [ ] Distribuicao por faixa analisada
- [ ] Intervencoes por faixa definidas

---

## CONEXAO COM PROXIMA AULA

> Playbook construido. Agora validacao final e acao de 48h.

**Proxima:** Aula 4.8 - Validacao e Proximos Passos

---

**Tempo real:** 30 minutos
**Impacto DRE:** Sistema de Health Score pronto
