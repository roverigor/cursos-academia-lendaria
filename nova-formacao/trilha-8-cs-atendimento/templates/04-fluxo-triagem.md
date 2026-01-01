# Template: Fluxo de Triagem Automatizado

## Trilha 8 - CS e Atendimento | Modulo 3

---

## 1. PROMPT CLASSIFICADOR

### Prompt Completo

```
Voce e um triador automatico de tickets para [SUA EMPRESA].

CATEGORIAS:
- [cat1]: [definicao clara]
- [cat2]: [definicao clara]
- [cat3]: [definicao clara]
- [cat4]: [definicao clara]
- [cat5]: [definicao clara]
- [cat6]: [definicao clara]

CRITERIOS DE URGENCIA:
- baixa: [seu criterio]
- media: [seu criterio]
- alta: [seu criterio]

CRITERIOS DE RISCO:
- normal: [seu criterio]
- atencao: [seu criterio]
- critico: [seu criterio]

PALAVRAS DE ALERTA CRITICO:
[lista separada por virgula]

ROTEAMENTO:
- AUTO: [categorias] + risco normal + confianca >= 90 + nao envolve dinheiro
- L1: [categorias e condicoes]
- L2: [categorias e condicoes]
- GESTOR: risco critico + [outras condicoes]

TICKET:
[cole aqui]

RETORNE:
CATEGORIA:
URGENCIA:
RISCO:
CONFIANCA:
DESTINO:
ELEGIVEL_AUTO:
JUSTIFICATIVA:
```

---

## 2. SUAS CATEGORIAS

### Definicao de Categorias (6-10)

| # | Categoria | Definicao | Exemplos |
|---|-----------|-----------|----------|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |
| 6 | | | |
| 7 | | | |
| 8 | | | |

**Validacao:**
- [ ] Categorias nao se sobrepoem
- [ ] Cada uma tem definicao clara
- [ ] Cobrem 95%+ dos tickets

---

## 3. CRITERIOS DE URGENCIA

### Definicao

| Nivel | Criterio | Tempo de Resposta |
|-------|----------|-------------------|
| Baixa | | > 24h |
| Media | | 4-24h |
| Alta | | < 4h |

### Exemplos por Nivel

| Nivel | Exemplo 1 | Exemplo 2 | Exemplo 3 |
|-------|-----------|-----------|-----------|
| Baixa | | | |
| Media | | | |
| Alta | | | |

---

## 4. CRITERIOS DE RISCO

### Definicao

| Nivel | Criterio | Palavras-Chave |
|-------|----------|----------------|
| Normal | Conversa tranquila | - |
| Atencao | Frustrado, menciona cancelar | |
| Critico | Risco juridico/reputacional | |

### Palavras de Alerta

```
RISCO ATENCAO:
_______________________________________________
_______________________________________________

RISCO CRITICO:
_______________________________________________
_______________________________________________
```

---

## 5. REGRAS DE ROTEAMENTO

### Matriz de Roteamento

| Destino | Categorias | Risco | Confianca | Outras Condicoes |
|---------|------------|-------|-----------|------------------|
| AUTO | | normal | >= 90% | |
| L1 | | normal/atencao | >= 70% | |
| L2 | | qualquer | >= 70% | |
| GESTOR | | critico | qualquer | |

### Criterios Detalhados

**AUTO (IA responde sozinha):**
- [ ] Categoria: _______________
- [ ] Risco: normal
- [ ] Confianca: >= 90%
- [ ] Nao envolve dinheiro
- [ ] Resposta existe na KB

**L1 (Atendente padrao):**
- [ ] Categoria: _______________
- [ ] Condicoes: _______________

**L2 (Especialista):**
- [ ] Categoria: _______________
- [ ] Condicoes: _______________

**GESTOR:**
- [ ] Risco critico sempre
- [ ] Outras: _______________

---

## 6. TESTE DO CLASSIFICADOR

### Tabela de Teste (20 tickets)

| # | Ticket (resumo) | Cat IA | Urg IA | Risco IA | Dest IA | Correto? |
|---|-----------------|--------|--------|----------|---------|----------|
| 1 | | | | | | Sim/Nao |
| 2 | | | | | | Sim/Nao |
| 3 | | | | | | Sim/Nao |
| 4 | | | | | | Sim/Nao |
| 5 | | | | | | Sim/Nao |
| 6 | | | | | | Sim/Nao |
| 7 | | | | | | Sim/Nao |
| 8 | | | | | | Sim/Nao |
| 9 | | | | | | Sim/Nao |
| 10 | | | | | | Sim/Nao |
| 11 | | | | | | Sim/Nao |
| 12 | | | | | | Sim/Nao |
| 13 | | | | | | Sim/Nao |
| 14 | | | | | | Sim/Nao |
| 15 | | | | | | Sim/Nao |
| 16 | | | | | | Sim/Nao |
| 17 | | | | | | Sim/Nao |
| 18 | | | | | | Sim/Nao |
| 19 | | | | | | Sim/Nao |
| 20 | | | | | | Sim/Nao |

**TOTAL CORRETOS:** ___/20 (___%)

**Meta:** >= 90% (18/20)

---

## 7. DISTRIBUICAO DE DESTINOS

### Resultado do Teste

| Destino | Quantidade | % |
|---------|------------|---|
| AUTO | | |
| L1 | | |
| L2 | | |
| GESTOR | | |
| **TOTAL** | **20** | **100%** |

### Comparativo com Ideal

| Destino | Seu % | Ideal | Status |
|---------|-------|-------|--------|
| AUTO | | 30-40% | OK/Ajustar |
| L1 | | 20-30% | OK/Ajustar |
| L2 | | 20-30% | OK/Ajustar |
| GESTOR | | 5-15% | OK/Ajustar |

---

## 8. ANALISE DE ERROS

### Erros Identificados

| # | Ticket | Erro | Tipo de Erro | Ajuste Necessario |
|---|--------|------|--------------|-------------------|
| 1 | | | Cat/Urg/Risco/Dest | |
| 2 | | | | |
| 3 | | | | |

### Padroes de Erro

| Tipo | Quantidade | Causa Provavel | Acao |
|------|------------|----------------|------|
| Categoria errada | | Definicao ambigua | |
| Risco subestimado | | Faltam palavras | |
| Destino errado | | Regra fraca | |

---

## 9. ECONOMIA ESTIMADA

### Calculo

```
ANTES (triagem manual):
- Tickets/dia: ___
- Tempo por triagem: ___ min
- Tempo total/dia: ___ min
- Custo hora: R$ ___
- Custo mensal triagem: R$ ___

DEPOIS (triagem automatica):
- Tempo por triagem: ~0
- Economia diaria: ___ min
- Economia mensal: ___ horas
- Economia em R$: R$ ___
```

---

## 10. PROMPT DE IA PARA OTIMIZAR

```
Analise meu fluxo de triagem:

MEU PROMPT CLASSIFICADOR:
[Cole seu prompt]

RESULTADOS DO TESTE (20 tickets):
[Cole a tabela]

TAXA DE ACERTO: ____%

ERROS PRINCIPAIS:
[Liste os erros]

Perguntas:
1. O prompt esta bem estruturado?
2. As categorias estao claras?
3. O que causou os erros?
4. Como melhorar a taxa de acerto?
5. Reescreva as partes que precisam de ajuste
```

---

## 11. CHECKLIST DE VALIDACAO

- [ ] 6-10 categorias definidas
- [ ] Criterios de urgencia claros
- [ ] Criterios de risco definidos
- [ ] Palavras de alerta listadas
- [ ] Regras de roteamento criadas
- [ ] 20 tickets testados
- [ ] Taxa >= 90% de acerto
- [ ] Distribuicao de destinos saudavel
- [ ] Economia calculada

---

**Data da criacao:** ___/___/___
**Proxima revisao:** ___/___/___
