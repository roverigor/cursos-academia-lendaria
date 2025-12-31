# Aula 3.8: Teste e Validacao

## Trilha 8 - CS e Atendimento | Modulo 3

---

> **Duracao:** 12 minutos
> **Tipo:** Validacao (Checklist + Acao)
> **Entregavel:** Fluxo Validado + Acao 48h
> **Linha do DRE:** Sistema de Triagem Aprovado

---

## ROTEIRO DE FALA

### ABERTURA (30 segundos)

```
[OLHAR PARA CAMERA - TOM DE FECHAMENTO]

"Voce construiu o fluxo de triagem.
Testou com 20 tickets.
Agora vamos validar que ta pronto pra producao.

Checklist completo.
Analise de resultados.
Acao de 48 horas.

Vamos la."
```

---

### CHECKLIST DE COMPLETUDE (3 minutos)

```
[MOSTRAR CHECKLIST NA TELA]

"Primeiro: completude.

[LER CADA ITEM]

□ CATEGORIAS
  - 6-10 categorias definidas? ___
  - Cada uma com definicao clara? ___
  - Sem sobreposicao? ___

□ RISCO
  - Criterios de normal definidos? ___
  - Criterios de atencao definidos? ___
  - Criterios de critico definidos? ___
  - Lista de palavras de alerta? ___

□ ROTEAMENTO
  - Regras para AUTO? ___
  - Regras para L1? ___
  - Regras para L2? ___
  - Regras para GESTOR? ___

□ PROMPT
  - Prompt completo montado? ___
  - Todas as secoes preenchidas? ___
  - Formato de retorno definido? ___

□ TESTE
  - 20 tickets testados? ___
  - Taxa >= 90% de acerto? ___
  - Erros documentados? ___

[MOSTRAR RESULTADO]

Se marcou tudo: fluxo completo.
Se faltou algo: pause e complete."
```

---

### ANALISE DOS RESULTADOS (3 minutos)

```
[MOSTRAR ANALISE]

"Vamos analisar seus resultados de teste.

[MOSTRAR PERGUNTAS]

1. TAXA DE ACERTO
   Quantos dos 20 foram corretos?

   >= 90% (18+): Pronto pra producao
   80-89% (16-17): Ajustes menores
   < 80%: Revisar estrutura

2. PADROES DE ERRO
   Onde a IA errou mais?

   - Categoria errada: definicoes ambiguas
   - Risco subestimado: faltam palavras de alerta
   - Destino errado: regras de roteamento fracas

3. DISTRIBUICAO DE DESTINOS
   Como ficou a distribuicao?

   Ideal:
   - AUTO: 30-40%
   - L1: 20-30%
   - L2: 20-30%
   - GESTOR: 5-15%

   Se GESTOR > 20%: regras muito rigidas
   Se AUTO < 20%: regras muito conservadoras

[MOSTRAR ACAO]

Pra cada padrao de erro, uma acao:
- Erro de categoria → refinar definicoes
- Erro de risco → adicionar palavras de alerta
- Erro de destino → ajustar regras"
```

---

### METRICAS BASELINE (2 minutos)

```
[MOSTRAR TABELA DE METRICAS]

"Terceiro: seu baseline de triagem.

[MOSTRAR TABELA]

ANTES (triagem manual):
- Tempo medio por ticket: ___ min
- Tickets/dia: ___
- Tempo total triagem/dia: ___ min
- Custo mensal triagem: R$ ___

DEPOIS (triagem automatica):
- Tempo medio por ticket: ~0 (IA faz)
- Economia diaria: ___ min
- Economia mensal: ___ horas
- Economia em R$: R$ ___

[MOSTRAR CALCULO]

Exemplo:
- 50 tickets/dia x 1.5 min = 75 min/dia manual
- Com IA: 0 min/dia
- Economia: 75 min/dia = 25h/mes = R$ 375/mes

[MOSTRAR COMPROMISSO]

Anota seu baseline.
Daqui 30 dias, compara."
```

---

### DEFININDO ACAO DE 48H (2.5 minutos)

```
[ENERGIA ALTA - COMPROMISSO]

"Sua acao de 48 horas.

[MOSTRAR OPCOES]

OPCAO 1: USAR EM PRODUCAO
Se >= 90% de acerto:
- Ativa o fluxo nos proximos 50 tickets
- Humano ainda valida antes de agir
- Coleta feedback

OPCAO 2: REFINAR PROMPT
Se 80-89% de acerto:
- Identifica os 2-3 padroes de erro
- Ajusta definicoes/regras
- Retesta com mais 10 tickets

OPCAO 3: TREINAR EQUIPE
Se voce tem time:
- Mostra o fluxo pra equipe
- Explica os destinos
- Define quem monitora

OPCAO 4: INTEGRAR COM FERRAMENTA
Se voce usa Zendesk, Freshdesk, etc:
- Pesquisa como conectar IA
- Ou cria macro manual
- Ou documenta processo

[MOSTRAR COMPROMISSO]

Qual voce vai fazer?
Anota. Coloca alarme. 48 horas."
```

---

### FECHAMENTO DO MODULO (1 minuto)

```
[OLHAR DIRETO PARA CAMERA - CELEBRACAO]

"Voce completou o Modulo 3!

Agora voce tem:
- Classificacao automatica funcionando
- Roteamento inteligente configurado
- Criterios de auto-resposta definidos
- Fluxo testado e validado

[MOSTRAR IMPACTO]

Impacto:
- Triagem manual: ZERO
- Tempo economizado: 25+ horas/mes
- Ticket chega na pessoa certa
- Casos criticos vao pro gestor automaticamente

[MOSTRAR CONEXAO]

No proximo modulo, vamos fazer CS PROATIVO.

Nao esperar ticket chegar.
PREVENIR que ticket aconteca.
Identificar cliente em risco ANTES de ele reclamar.

Descansa. Executa sua acao.
Te vejo no Modulo 4."
```

---

## MATERIAL DE APOIO

### Checklist de Completude

```
□ CATEGORIAS
  □ 6-10 definidas
  □ Definicoes claras
  □ Sem sobreposicao

□ RISCO
  □ Criterios normal/atencao/critico
  □ Palavras de alerta

□ ROTEAMENTO
  □ Regras AUTO/L1/L2/GESTOR
  □ Logica clara

□ PROMPT
  □ Completo e formatado
  □ Retorno estruturado

□ TESTE
  □ 20 tickets testados
  □ >= 90% acerto
```

### Interpretacao dos Resultados

| Taxa de Acerto | Status | Acao |
|----------------|--------|------|
| >= 90% | Pronto | Usar em producao |
| 80-89% | Quase la | Ajustes menores |
| 70-79% | Precisa trabalho | Revisar estrutura |
| < 70% | Insuficiente | Reconstruir |

### Distribuicao Ideal de Destinos

| Destino | % Ideal | Se Muito Alto | Se Muito Baixo |
|---------|---------|---------------|----------------|
| AUTO | 30-40% | Revisar criterios | Afrouxar regras |
| L1 | 20-30% | - | - |
| L2 | 20-30% | - | - |
| GESTOR | 5-15% | Afrouxar regras | Apertar risco |

### Calculo de Economia

```
ECONOMIA MENSAL:

Tickets/dia: [X]
Tempo triagem manual: [Y] min/ticket
Dias uteis: 22

Tempo total manual = X * Y * 22 = [Z] minutos/mes
Horas economizadas = Z / 60 = [H] horas
Valor economizado = H * [custo hora] = R$ [V]
```

---

## PROMPT DE IA PARA ANALISE FINAL

```
Analise os resultados do meu teste de triagem:

RESULTADOS DOS 20 TICKETS:
[Cole sua tabela de teste]

TAXA DE ACERTO: ___/20 (___%)

ERROS IDENTIFICADOS:
[Liste os erros]

Perguntas:
1. Meu fluxo esta pronto pra producao?
2. Qual o padrao principal de erro?
3. O que ajustar primeiro?
4. A distribuicao de destinos esta boa?
5. Qual minha economia estimada por mes?
```

---

## CHECKPOINT FINAL DO MODULO

- [ ] Fluxo de triagem COMPLETO
- [ ] Checklist de completude passou
- [ ] 20 tickets testados
- [ ] Taxa >= 90% de acerto
- [ ] Baseline de economia calculado
- [ ] Acao de 48h definida

---

## ENTREGAVEL DO MODULO 3

**Fluxo de Triagem Automatizado** contendo:
- Prompt classificador personalizado
- 6-10 categorias com definicoes
- Criterios de risco (normal/atencao/critico)
- Lista de palavras de alerta
- Regras de roteamento (AUTO/L1/L2/GESTOR)
- Criterios de auto-resposta
- Testado com 20 tickets (>= 90% acerto)
- Economia estimada calculada

---

## CONEXAO COM PROXIMO MODULO

> **Modulo 4: CS Proativo e Anti-Churn**
>
> Voce vai criar sistema de Health Score
> que identifica cliente em risco ANTES
> de ele abrir ticket ou cancelar.
>
> Pre-requisito: Fluxo de Triagem (este modulo)

---

**Tempo real:** 12 minutos
**Impacto DRE:** Sistema de triagem validado e pronto

---

**FIM DO MODULO 3**
