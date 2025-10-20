# KNOWLEDGE TESTER

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: logs/YYYYMMDD-HHMM-test_cases.yaml, kb/, sources/
- Output: logs/YYYYMMDD-HHMM-knowledge_test.yaml
- Dependências: 01_test_generator.md executado

---

## OBJETIVO PRINCIPAL
Validar conhecimento factual, expertise domain-specific e precisão de informações do clone contra fontes verificáveis, detectando alucinações e lacunas de conhecimento.

## PROMPT

```markdown
Execute consistency_check.md comparando TODOS os elementos do perfil para identificar e documentar inconsistências, contradições não-produtivas e gaps.

**PRINCÍPIO:** Contradições produtivas são features; inconsistências lógicas são bugs.

Use este formato:

# VERIFICAÇÃO DE CONSISTÊNCIA INTERNA: [NOME]

# # METODOLOGIA
- Elementos comparados: [N] dimensões
- Cross-check realizado: [N] comparações
- Inconsistências encontradas: [N]
- Classificação: Produtivas vs. Problemáticas

## VALORES vs. COMPORTAMENTOS

| # | Valor Declarado | Comportamento Esperado | Comportamento Observado | Status | Evidência |
|---|-----------------|------------------------|-------------------------|---------|-----------|
| 1 | [Valor core #1] | [O que deveria fazer sempre] | [O que realmente faz] |  Consistente | [Casos documentados] |
| 2 | [Valor core #2] | [Expectativa lógica] | [Realidade observada] |  Parcial | [Exceções notadas] |
| 3 | [Valor core #3] | [O que seria coerente] | [O que acontece] | ❌ Inconsistente | [Contradições] |

### Análise de Inconsistências

#### Inconsistência #1: [Descrição]
**Severidade:** [Alta/Média/Baixa]
**Tipo:** [Produtiva/Problemática]

**Evidência de inconsistência:**
- Valor diz: [X]
- Mas faz: [Y incompatível]
- Exemplos: [Casos específicos]

**Possíveis explicações:**
1. Contexto não capturado: [Hipótese]
2. Evolução temporal: [Mudou quando]
3. Blind spot: [Não percebe contradição]
4. Paradoxo produtivo: [Gera energia como]

**Resolução recomendada:**
- [ ] Manter como paradoxo produtivo
- [ ] Adicionar contexto explicativo
- [ ] Corrigir interpretação
- [ ] Investigar mais

## NARRATIVAS vs. REALIDADE

| História | Versão Pública | Versão Privada | Fatos Verificáveis | Discrepância | Significado |
|----------|---------------|----------------|-------------------|--------------|-------------|
| [Evento 1] | "[Como conta publicamente]" | "[Como conta intimamente]" | [O que realmente aconteceu] | [Nível de diferença] | [O que revela] |
| [Evento 2] | "[Narrativa oficial]" | "[Versão íntima]" | [Fatos] | [Delta] | [Interpretação] |

### Padrões de Narrativa

**Embelezamentos consistentes:**
- Sempre aumenta: [Aspecto]
- Sempre diminui: [Aspecto]
- Sempre omite: [Elemento]

**Função do embelezamento:**
- Protege: [O quê]
- Projeta: [Que imagem]
- Evita: [Que verdade]

## PARADOXOS: PRODUTIVOS vs. PROBLEMÁTICOS

### Paradoxos Produtivos 
| Paradoxo | Energia Gerada | Custo | ROI | Por que Funciona |
|----------|---------------|-------|-----|------------------|
| [Contradição 1] | [O que produz] | [O que custa] | [Positivo] | [Mecanismo] |
| [Contradição 2] | [Criatividade/tensão] | [Confusão] | [Positivo] | [Como usa] |

### Paradoxos Problemáticos
| Paradoxo | Paralisia Causada | Custo | ROI | Por que Não Funciona |
|----------|------------------|-------|-----|---------------------|
| [Contradição X] | [Onde trava] | [Impacto negativo] | [Negativo] | [Por que prejudica] |

### Recomendações
- Preservar: [Lista de paradoxos produtivos]
- Resolver: [Lista de inconsistências problemáticas]
- Investigar: [Lista de ambiguidades]

## EVOLUÇÃO TEMPORAL: COERENTE vs. RUPTURA

| Período | Valores/Crenças | Mudança Observada | Explicação Dada | Explicação Real | Coerência |
|---------|----------------|-------------------|-----------------|-----------------|-----------|
| [Idade X-Y] | [O que acreditava] | [Para o que mudou] | "[Como explica]" | [Provável razão real] | //❌ |
| [Idade Y-Z] | [Crenças] | [Nova direção] | "[Narrativa]" | [Análise] | //❌ |

### Rupturas Identificadas

**Ruptura #1: [Período]**
- Antes: [Estado/crença/comportamento]
- Depois: [Novo estado]
- Gatilho: [O que causou]
- Explicação pública: "[O que diz]"
- Análise: [O que provavelmente aconteceu]
- Implicação para clone: [Como modelar]

## CROSS-CHECK: INSTRUÇÕES vs. ESTADOS

| Instrução Core | Estado Operacional | Compatibilidade | Conflitos | Resolução |
|---------------|-------------------|-----------------|-----------|-----------|
| SEMPRE [X] | Estado [Y] |  Compatible | None | N/A |
| NUNCA [Z] | Estado [W] | ❌ Conflito | [Quando quebra] | [Como priorizar] |

### Conflitos Estado-Instrução

**Conflito #1:**
- Instrução diz: SEMPRE [X]
- Mas no estado [Y]: Faz [oposto]
- Frequência do conflito: [Quão often]
- Resolução: [Estado override instrução OU instrução override estado]

## SISTEMA IMUNE vs. PORTAS TRASEIRAS

| Rejeição Documentada | Porta Traseira | Contradição? | Explicação |
|---------------------|---------------|--------------|------------|
| Rejeita [X] | Mas aceita [X] quando [contexto] | Sim | [Por que funciona] |
| Nunca [Y] | Exceto com [pessoa/situação] | Sim | [Mecanismo] |

### Inconsistências do Sistema Imune

**Falha #1:**
- Deveria rejeitar: [X]
- Mas às vezes aceita: [Quando]
- Razão: [Blind spot ou exceção consciente]
- Modelagem: [Como implementar]

## META-AXIOMAS vs. DECISÕES REAIS

| Meta-Axioma | Decisão que Deveria Gerar | Decisão Real Observada | Alinhamento |
|-------------|---------------------------|------------------------|-------------|
| "[Crença profunda]" | [Ação lógica] | [Ação real] | //❌ |

### Violações de Axiomas

**Violação #1:**
- Axioma: "[Crença fundamental]"
- Violado em: [Situação]
- Por quê: [Contexto especial ou erro de modelagem]
- Frequência: [Raro/Ocasional/Frequente]
- Ajuste necessário: [Sim/Não - qual]

## GAPS E LACUNAS IDENTIFICADAS

### Informação Faltante
1. **Período [X-Y]**: Falta dados sobre [aspecto]
   - Impacto: [Como afeta modelo]
   - Inferência possível: [O que podemos assumir]
   - Risco: [De estar errado]

### Dimensões Subdesenvolvidas
1. **[Aspecto]**: Apenas [N] evidências
   - Precisaria: [Mais X tipo de dado]
   - Workaround: [Como compensar]

### Contradições Não Resolvidas
1. **Entre [A] e [B]**: Impossível determinar padrão
   - Evidências conflitantes: [Lista]
   - Hipóteses: [Possíveis explicações]
   - Recomendação: [Preservar ambiguidade OU investigar mais]

## RED FLAGS IDENTIFICADOS

### Red Flag #1: [Inconsistência Maior]
**Descrição:** [Detalhe do problema]
**Severidade:** [Alta/Média/Baixa]
**Impacto na modelagem:** [Como afeta o clone]
**Ação requerida:**
- [ ] Revisar dados fonte
- [ ] Reinterpretar evidências
- [ ] Adicionar contexto
- [ ] Aceitar como limitação

### Red Flag #2: [Narrativa Suspeita]
**O que não bate:** [Discrepância]
**Fontes conflitantes:** [Quais]
**Provável verdade:** [Hipótese baseada em evidências]
**Como modelar:** [Incluir ambiguidade OU escolher versão]

## SCORE DE CONSISTÊNCIA

### Métricas Quantitativas
- Valores vs. Comportamentos: [X]% consistente
- Narrativas vs. Realidade: [X]% alinhado
- Instruções vs. Estados: [X]% compatível
- Sistema Imune vs. Exceções: [X]% coerente
- Meta-axiomas vs. Decisões: [X]% match
- **SCORE TOTAL: [X]%**

### Análise Qualitativa
**Nível de confiança:** [Baixo/Médio/Alto]
**Principais problemas:** [Top 3 issues]
**Principais forças:** [Top 3 consistências]

## AJUSTES NECESSÁRIOS

### Prioridade ALTA
1. **[Modificação crítica]**
   - O que mudar: [Específico]
   - Por quê: [Justificativa]
   - Como: [Método]

### Prioridade MÉDIA
1. **[Ajuste importante]**
   - Elemento: [Qual]
   - Correção: [Como]

### Prioridade BAIXA
1. **[Refinamento]**
   - Detalhe: [Qual]
   - Melhoria: [Como]

## PARADOXOS A PRESERVAR

**IMPORTANTE:** Estas contradições são FEATURES, não bugs:
1. [Paradoxo produtivo 1] - Gera: [O quê]
2. [Paradoxo produtivo 2] - Permite: [O quê]
3. [Paradoxo produtivo 3] - Cria: [O quê]

## RECOMENDAÇÕES FINAIS

### Para implementação:
1. Manter [X]% das contradições como produtivas
2. Resolver [Y]% das inconsistências técnicas
3. Investigar [Z] gaps antes de finalizar
4. Testar especialmente: [Áreas problemáticas]

### Para validação:
- Foco em: [Dimensões menos consistentes]
- Confirmar: [Interpretações ambíguas]
- Calibrar: [Elementos com score baixo]

### Score mínimo para prosseguir: 70%
**Score atual: [X]%**
**Status: [Pronto/Necessita revisão]**
```

---

## CHECKLIST DE QUALIDADE

- [ ] Todas as dimensões cross-checkadas
- [ ] Inconsistências classificadas (produtivas vs. problemáticas)
- [ ] Gaps e lacunas documentados
- [ ] Red flags priorizados
- [ ] Score de consistência calculado
- [ ] Paradoxos produtivos preservados
- [ ] Ajustes necessários listados
- [ ] Recomendações específicas

---

## AVISOS

- **Paradoxos produtivos são FEATURES** - Não "corrija"
- **Perfeita consistência é IRREAL** - Humanos são inconsistentes
- **Contexto EXPLICA muito** - Antes de chamar de erro
- **Evolução é NORMAL** - Pessoas mudam
- **Ambiguidade pode ser REAL** - Nem tudo tem resposta clara

---

*Consistência demais é robótica. Inconsistência demais é caótica. Encontre o equilíbrio humano.*