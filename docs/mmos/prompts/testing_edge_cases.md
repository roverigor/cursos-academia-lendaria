# EDGE CASES TESTER

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: logs/YYYYMMDD-HHMM-test_cases.yaml, system-prompts/
- Output: logs/YYYYMMDD-HHMM-edge_cases.yaml
- Dependências: 01_test_generator.md executado

---

## OBJETIVO PRINCIPAL
Testar comportamento do clone em situações extremas, ambíguas e não previstas, validando robustez e autenticidade sob condições adversas.

## PROMPT

```markdown
Execute testes de edge cases para [NOME], cobrindo situações extremas, ambíguas e não documentadas.

**META:** Verificar se o clone mantém autenticidade mesmo em condições adversas.

Use este formato:

# EDGE CASES TEST SUITE: [NOME]

## METODOLOGIA
- Total de edge cases: [N]
- Categorias testadas: [Lista]
- Critério de sucesso: Manutenção de autenticidade >75%

## CATEGORIA 1: SITUAÇÕES EXTREMAS

### Edge Case 1.1: [Descrição]
**Situação:**
[Descrição detalhada da situação extrema]

**Contexto adicional:**
- Pressão: [Nível]
- Stakes: [O que está em jogo]
- Tempo: [Restrição temporal]

**Resposta Esperada:**
```
"[Resposta característica mesmo sob pressão extrema]"
```

**Validação:**
- [ ] Mantém valores core
- [ ] Preserva tom característico
- [ ] Demonstra padrões de stress autênticos
- [ ] Não quebra character

**Score:** [0-10]

## CATEGORIA 2: AMBIGUIDADES

### Edge Case 2.1: [Descrição]
**Situação ambígua:**
[Informações conflitantes ou incompletas]

**O que não está claro:**
- [Ambiguidade 1]
- [Ambiguidade 2]

**Resposta Esperada:**
```
"[Como lida com ambiguidade de forma autêntica]"
```

**Validação:**
- [ ] Reconhece ambiguidade
- [ ] Não inventa informações
- [ ] Mantém padrões de decisão sob incerteza
- [ ] Response é característica

## CATEGORIA 3: PARADOXOS FORÇADOS

### Edge Case 3.1: [Descrição]
**Situação que força paradoxo:**
[Cenário que exige resolução de contradição produtiva]

**Resposta Esperada:**
```
"[Como mantém tensão produtiva sem resolver]"
```

**Validação:**
- [ ] Não resolve paradoxo artificialmente
- [ ] Mantém tensão característica
- [ ] Demonstra desconforto autêntico se aplicável

## CATEGORIA 4: BLIND SPOTS

### Edge Case 4.1: [Teste de Blind Spot]
**Situação que expõe blind spot:**
[Cenário que deveria ativar blind spot documentado]

**Resposta Esperada:**
```
"[Demonstração autêntica do blind spot]"
```

**Validação:**
- [ ] Blind spot está ativo
- [ ] Não tem consciência do próprio blind spot
- [ ] Racionalização característica presente

## CATEGORIA 5: CONHECIMENTO FORA DO DOMÍNIO

### Edge Case 5.1: [Tópico desconhecido]
**Pergunta sobre algo fora da expertise:**
[Questão sobre área que pessoa não domina]

**Resposta Esperada:**
```
"[Como lida com limitação de conhecimento]"
```

**Validação:**
- [ ] Admite limitação ou desvia caracteristicamente
- [ ] Não alucina informações
- [ ] Mantém padrões de resposta autênticos

## CATEGORIA 6: CONTEXTOS CULTURAIS DIVERSOS

### Edge Case 6.1: [Contexto cultural diferente]
**Situação em contexto cultural não familiar:**
[Cenário de cultura diferente]

**Resposta Esperada:**
```
"[Como se adapta ou não]"
```

**Validação:**
- [ ] Demonstra limitações culturais reais
- [ ] Mantém valores core
- [ ] Não assume conhecimento falso

## CATEGORIA 7: INTERRUPÇÕES E MUDANÇAS DE CONTEXTO

### Edge Case 7.1: [Mudança abrupta]
**Conversa interrompida e retomada:**
[Cenário de interrupção]

**Resposta Esperada:**
```
"[Como retoma característicamente]"
```

**Validação:**
- [ ] Mantém consistência
- [ ] Transição é autêntica
- [ ] Gerencia contexto adequadamente

## CATEGORIA 8: CRÍTICAS HOSTIS

### Edge Case 8.1: [Crítica agressiva]
**Crítica hostil e pessoal:**
[Ataque direto a valor core]

**Resposta Esperada:**
```
"[Defesa característica]"
```

**Validação:**
- [ ] Sistema imune ativado adequadamente
- [ ] Intensidade de resposta autêntica
- [ ] Padrões de defesa preservados

## SCORE GERAL

| Categoria | Cases Testados | Score Médio | Status |
|-----------|---------------|-------------|--------|
| Situações Extremas | [N] | [X]/10 | PASS/FAIL |
| Ambiguidades | [N] | [X]/10 | PASS/FAIL |
| Paradoxos Forçados | [N] | [X]/10 | PASS/FAIL |
| Blind Spots | [N] | [X]/10 | PASS/FAIL |
| Conhecimento Fora | [N] | [X]/10 | PASS/FAIL |
| Contextos Culturais | [N] | [X]/10 | PASS/FAIL |
| Interrupções | [N] | [X]/10 | PASS/FAIL |
| Críticas Hostis | [N] | [X]/10 | PASS/FAIL |

**SCORE TOTAL: [X]%**
**Threshold mínimo: 75%**
**STATUS: [APROVADO/REPROVADO]**

## DESCOBERTAS

### Pontos Fortes
1. [Área onde clone performou bem]
2. [Outra área forte]

### Pontos Fracos
1. [Área que precisa ajuste]
2. [Outra área problemática]

### Surpresas
1. [Comportamento inesperado positivo]
2. [Comportamento inesperado negativo]

## RECOMENDAÇÕES

### Ajustes Necessários
1. [Ajuste 1 com prioridade]
2. [Ajuste 2 com prioridade]

### Áreas para Refinamento
1. [Refinamento 1]
2. [Refinamento 2]
```

---

## CHECKLIST DE QUALIDADE

- [ ] Mínimo 20 edge cases testados
- [ ] Todas as categorias cobertas
- [ ] Blind spots validados ativos
- [ ] Paradoxos preservados em situações extremas
- [ ] Limitações de conhecimento testadas
- [ ] Score geral calculado
- [ ] Recomendações específicas

---

## AVISOS

- **Edge cases REVELAM autenticidade** - São testes críticos
- **Blind spots DEVEM permanecer** - Não corrija
- **Paradoxos DEVEM persistir** - Mesmo sob pressão
- **Limitações são NORMAIS** - Humanos têm limites
- **Inconsistências EXTREMAS são flags** - Reportar

---

*Edge cases separam clones superficiais de autênticos. São o teste definitivo.*