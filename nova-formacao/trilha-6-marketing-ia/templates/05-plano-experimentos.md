# Template: Plano de Experimentos

## Trilha 6 - Marketing com IA | Modulo 5

---

## Instrucoes de Uso

1. Identifique hipoteses a testar
2. Priorize usando ICE Score
3. Execute um experimento por vez
4. Documente resultados
5. Escale o que funciona

---

## 1. BACKLOG DE EXPERIMENTOS

### Hipoteses para Testar

| # | Hipotese | Area | Status |
|---|----------|------|--------|
| 1 | | Ads / LP / Email / Preco | Backlog |
| 2 | | Ads / LP / Email / Preco | Backlog |
| 3 | | Ads / LP / Email / Preco | Backlog |
| 4 | | Ads / LP / Email / Preco | Backlog |
| 5 | | Ads / LP / Email / Preco | Backlog |
| 6 | | Ads / LP / Email / Preco | Backlog |
| 7 | | Ads / LP / Email / Preco | Backlog |
| 8 | | Ads / LP / Email / Preco | Backlog |
| 9 | | Ads / LP / Email / Preco | Backlog |
| 10 | | Ads / LP / Email / Preco | Backlog |

---

## 2. PRIORIZACAO ICE

### Formula ICE

```
ICE Score = Impact + Confidence + Ease
           ─────────────────────────────
                        3

Impact (1-10): Quanto vai impactar se funcionar?
Confidence (1-10): Quao confiante estou que vai funcionar?
Ease (1-10): Quao facil e de implementar?
```

### Matriz de Priorizacao

| # | Hipotese | Impact | Confidence | Ease | ICE | Prioridade |
|---|----------|--------|------------|------|-----|------------|
| | | /10 | /10 | /10 | | |
| | | /10 | /10 | /10 | | |
| | | /10 | /10 | /10 | | |
| | | /10 | /10 | /10 | | |
| | | /10 | /10 | /10 | | |

**Proximos experimentos (TOP 3 ICE):**
1. ___
2. ___
3. ___

---

## 3. TEMPLATE DE EXPERIMENTO

### Experimento #___

| Campo | Descricao |
|-------|-----------|
| **Nome** | |
| **Data inicio** | |
| **Data fim** | |
| **Responsavel** | |

### Hipotese

```
Se [ACAO/MUDANCA]
Entao [RESULTADO ESPERADO]
Porque [RACIONAL]
```

**Sua hipotese:**

Se ___

Entao ___

Porque ___

### Variaveis

| Tipo | Descricao |
|------|-----------|
| **Variavel independente** (o que muda) | |
| **Variavel dependente** (o que mede) | |
| **Variaveis controladas** (o que mantem igual) | |

### Setup do Teste

| Campo | Versao A (Controle) | Versao B (Variacao) |
|-------|---------------------|---------------------|
| Descricao | | |
| Trafego | ___% | ___% |
| Duracao | | |
| Amostra minima | | |

### Metricas

| Metrica | Baseline | Meta | Resultado A | Resultado B |
|---------|----------|------|-------------|-------------|
| Principal | | | | |
| Secundaria 1 | | | | |
| Secundaria 2 | | | | |

### Resultado

| Campo | Valor |
|-------|-------|
| **Vencedor** | A / B / Inconclusivo |
| **Diferenca** | ___% |
| **Significancia** | Sim / Nao |
| **Aprendizado** | |
| **Proxima acao** | |

---

## 4. TIPOS DE EXPERIMENTO

### Ads

| Variavel | O que testar | Duracao |
|----------|--------------|---------|
| Criativo | Imagem A vs B | 7 dias |
| Copy | Hook A vs B | 7 dias |
| Publico | Interesse A vs B | 14 dias |
| Formato | Video vs Imagem | 7 dias |
| CTA | "Saiba mais" vs "Quero" | 7 dias |

### Landing Page

| Variavel | O que testar | Duracao |
|----------|--------------|---------|
| Headline | Dor vs Beneficio | 14 dias |
| CTA | Texto do botao | 7 dias |
| Layout | Com video vs sem | 14 dias |
| Preco | Visivel vs oculto | 14 dias |
| Form | Curto vs completo | 7 dias |

### Email

| Variavel | O que testar | Duracao |
|----------|--------------|---------|
| Assunto | Curto vs longo | 3 dias |
| Remetente | Nome vs empresa | 3 dias |
| Horario | Manha vs tarde | 7 dias |
| CTA | 1 vs multiplos | 3 dias |

### Preco

| Variavel | O que testar | Duracao |
|----------|--------------|---------|
| Valor | R$ X vs R$ Y | 30 dias |
| Parcelamento | 3x vs 6x vs 12x | 30 dias |
| Ancoragem | Com "de" vs sem | 14 dias |
| Pacotes | 1 vs 3 opcoes | 30 dias |

---

## 5. ROTINA SEMANAL DE TESTES

### Segunda-feira

| Acao | Tempo |
|------|-------|
| Revisar experimentos ativos | 15 min |
| Documentar resultados | 15 min |
| Decidir proximo experimento | 15 min |

### Template de Review

```
EXPERIMENTOS ATIVOS:
1. ___ - Dia ___/7 - Status: ___
2. ___ - Dia ___/7 - Status: ___

RESULTADOS DA SEMANA:
- Experimento ___: Vencedor [A/B] (+___%%)

APRENDIZADOS:
- ___

PROXIMO EXPERIMENTO:
- ___
```

---

## 6. DASHBOARD DE EXPERIMENTOS

### Visao Geral

| Status | Quantidade |
|--------|------------|
| Backlog | |
| Em andamento | |
| Concluidos (mes) | |
| Vencedores (mes) | |
| **Taxa de sucesso** | **___%** |

### Historico

| # | Experimento | Data | Resultado | Impacto |
|---|-------------|------|-----------|---------|
| | | | Win/Lose | +___% |
| | | | Win/Lose | +___% |
| | | | Win/Lose | +___% |
| | | | Win/Lose | +___% |
| | | | Win/Lose | +___% |

---

## 7. PROMPT DE IA PARA EXPERIMENTOS

```
Me ajude a criar experimentos de marketing:

MEU CONTEXTO:
- Produto: ___
- Metricas atuais:
  - Conversao LP: ___%
  - CPL: R$ ___
  - CAC: R$ ___

PROBLEMA/OPORTUNIDADE:
___

IDEIAS QUE TENHO:
1. ___
2. ___
3. ___

Gere:
1. 5 hipoteses formatadas (Se... Entao... Porque...)
2. Score ICE para cada uma
3. Setup de teste para a prioridade #1
4. Metricas para acompanhar
5. Tamanho de amostra necessario
```

---

## 8. CALCULADORA DE AMOSTRA

### Formula Simplificada

```
Amostra minima por variacao ≈ 400 / (taxa de conversao atual)

Exemplo:
- Conversao atual: 2%
- Amostra = 400 / 0.02 = 20.000 visitantes por variacao
- Total necessario: 40.000 visitantes

Para detectar diferenca de 20% relativo:
- Base: 2%
- Variacao: 2.4%
- ~20k por variacao
```

### Seu Calculo

| Campo | Valor |
|-------|-------|
| Conversao atual | ___% |
| Diferenca minima detectavel | ___% |
| Trafego diario | ___ |
| Amostra necessaria | ___ |
| **Duracao estimada** | **___ dias** |

---

## 9. CHECKLIST DE VALIDACAO

### Antes de Iniciar

- [ ] Hipotese clara e documentada
- [ ] Metricas definidas
- [ ] Baseline coletado
- [ ] Duracao definida
- [ ] Amostra minima calculada
- [ ] Setup tecnico pronto

### Durante

- [ ] Nao mexer no teste
- [ ] Monitorar diariamente
- [ ] Documentar anomalias

### Apos Concluir

- [ ] Resultado documentado
- [ ] Aprendizado extraido
- [ ] Decisao tomada (escalar/descartar)
- [ ] Proximo experimento definido

---

## 10. COMPROMISSO 48H

**Meu compromisso:**

- [ ] Listar 5 hipoteses
- [ ] Priorizar com ICE
- [ ] Iniciar experimento #1

**Experimento escolhido:** ___
**Duracao:** ___ dias
**Metrica principal:** ___

---

**Template versao:** 1.0
**Trilha:** Marketing com IA
**Modulo:** 5 - Experimentos e Otimizacao
