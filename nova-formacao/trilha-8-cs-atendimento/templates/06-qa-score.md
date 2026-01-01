# Template: Sistema de QA Score

## Trilha 8 - CS e Atendimento | Modulo 5

---

## 1. FORMULA DE QA SCORE

### Seus Criterios (5-7)

| # | Criterio | Peso | Nota 10 | Nota 5 | Nota 0 |
|---|----------|------|---------|--------|--------|
| 1 | | ___% | | | |
| 2 | | ___% | | | |
| 3 | | ___% | | | |
| 4 | | ___% | | | |
| 5 | | ___% | | | |
| 6 | | ___% | | | |
| 7 | | ___% | | | |
| | **TOTAL** | **100%** | | | |

### Sugestao de Criterios

| Criterio | Peso Sugerido | O que Avalia |
|----------|---------------|--------------|
| Tempo de Resposta | 15% | Velocidade da 1a resposta |
| Resolucao | 25% | Resolveu o problema? |
| Precisao | 15% | Informacao correta? |
| Clareza | 10% | Facil de entender? |
| Tom e Empatia | 15% | Profissional e humano? |
| Proatividade | 10% | Foi alem do minimo? |
| Procedimento | 10% | Seguiu protocolo? |

---

## 2. FAIXAS DE QUALIDADE

| Faixa | Score | Acao | Frequencia |
|-------|-------|------|------------|
| Excelente | 90-100 | Reconhecer, documentar | Imediato |
| Bom | 80-89 | Feedback positivo | Semanal |
| Regular | 60-79 | Coaching | Semanal |
| Precisa Melhorar | 0-59 | Treinamento urgente | Imediato |

---

## 3. PLANILHA DE AVALIACAO

### Template de Registro

| Data | Ticket # | Atendente | Cat | C1 | C2 | C3 | C4 | C5 | QA | CSAT | Obs |
|------|----------|-----------|-----|----|----|----|----|----|----|------|-----|
| | | | | | | | | | | | |
| | | | | | | | | | | | |
| | | | | | | | | | | | |
| | | | | | | | | | | | |
| | | | | | | | | | | | |
| | | | | | | | | | | | |
| | | | | | | | | | | | |
| | | | | | | | | | | | |
| | | | | | | | | | | | |
| | | | | | | | | | | | |

### Formula de Calculo (Excel/Sheets)

```
QA Score = (C1*peso1) + (C2*peso2) + (C3*peso3) + (C4*peso4) + (C5*peso5)

Exemplo:
= (E2*0.15) + (F2*0.25) + (G2*0.15) + (H2*0.10) + (I2*0.15) + (J2*0.10) + (K2*0.10)
```

---

## 4. PESQUISA CSAT

### Configuracao

| Campo | Valor |
|-------|-------|
| Pergunta principal | Como voce avalia o atendimento? |
| Escala | 1-5 estrelas |
| Pergunta aberta | O que poderiamos melhorar? |
| Momento de envio | Apos ticket fechado |
| Ferramenta | |

### Template de Pesquisa

```
PESQUISA DE SATISFACAO

Obrigado por entrar em contato!
Queremos saber como foi sua experiencia.

Como voce avalia o atendimento que recebeu?
⭐⭐⭐⭐⭐

[Opcional]
O que poderiamos ter feito melhor?
________________________________

Obrigado pelo feedback!
```

---

## 5. AVALIACAO DE 20 ATENDIMENTOS

### Registro Completo

| # | Ticket | Atend | C1 | C2 | C3 | C4 | C5 | QA | Faixa | Obs |
|---|--------|-------|----|----|----|----|----|----|-------|-----|
| 1 | | | | | | | | | | |
| 2 | | | | | | | | | | |
| 3 | | | | | | | | | | |
| 4 | | | | | | | | | | |
| 5 | | | | | | | | | | |
| 6 | | | | | | | | | | |
| 7 | | | | | | | | | | |
| 8 | | | | | | | | | | |
| 9 | | | | | | | | | | |
| 10 | | | | | | | | | | |
| 11 | | | | | | | | | | |
| 12 | | | | | | | | | | |
| 13 | | | | | | | | | | |
| 14 | | | | | | | | | | |
| 15 | | | | | | | | | | |
| 16 | | | | | | | | | | |
| 17 | | | | | | | | | | |
| 18 | | | | | | | | | | |
| 19 | | | | | | | | | | |
| 20 | | | | | | | | | | |

### Resumo

| Metrica | Valor |
|---------|-------|
| QA Score medio | /100 |
| CSAT medio | % |
| Excelentes (90+) | |
| Bons (80-89) | |
| Regulares (60-79) | |
| Precisa Melhorar (<60) | |

---

## 6. ANALISE POR ATENDENTE

| Atendente | QA Medio | CSAT | Avaliados | Faixa | Acao |
|-----------|----------|------|-----------|-------|------|
| | | | | | |
| | | | | | |
| | | | | | |
| | | | | | |

---

## 7. ANALISE POR CATEGORIA

| Categoria | QA Medio | CSAT | Volume | Problema? |
|-----------|----------|------|--------|-----------|
| | | | | Sim/Nao |
| | | | | Sim/Nao |
| | | | | Sim/Nao |
| | | | | Sim/Nao |

---

## 8. PADROES IDENTIFICADOS

### Pontos Fortes

1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

### Pontos de Melhoria

1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

### Criterio Mais Fraco

```
Criterio: _______________
Score medio: ___
Causa provavel: _______________
Acao: _______________
```

---

## 9. PROMPT DE IA PARA AVALIAR

```
Avalie este atendimento usando os criterios:

ATENDIMENTO:
[Cole a conversa]

CRITERIOS:
1. [Seu criterio 1] (___%)
2. [Seu criterio 2] (___%)
3. [Seu criterio 3] (___%)
4. [Seu criterio 4] (___%)
5. [Seu criterio 5] (___%)

Para cada criterio:
- De nota 0-10
- Justifique em 1 linha

Ao final:
- Calcule QA Score (0-100)
- Classifique faixa
- Identifique ponto forte
- Identifique ponto de melhoria
```

---

## 10. CHECKLIST DE VALIDACAO

- [ ] 5-7 criterios definidos
- [ ] Pesos somam 100%
- [ ] Escala clara (0-10)
- [ ] Pesquisa CSAT configurada
- [ ] Planilha funcionando
- [ ] 20 atendimentos avaliados
- [ ] Analise por atendente feita
- [ ] Analise por categoria feita
- [ ] Padroes identificados

---

**Data da criacao:** ___/___/___
**Proxima revisao:** ___/___/___
