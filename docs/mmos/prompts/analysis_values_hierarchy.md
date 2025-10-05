# VALUES HIERARCHY

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: analysis/quotes.md, analysis/timeline.md, sources/
- Output: analysis/values_hierarchy.yaml
- Dependências: 01_quote_extraction.md, 03_temporal_mapper.md

## OBJETIVO PRINCIPAL
Analisar TODO o material coletado e mapear a hierarquia completa de valores do clone alvo, identificando valores centrais, anti-valores, trade-offs e evolução temporal.

**REGRA DE OURO:** Cada valor precisa 3+ evidências independentes ou é descartado como anomalia.

## INPUT NECESSÁRIO

```
clone_target: "[NOME COMPLETO]"
quotes_file: "analysis/quotes.md"
timeline_file: "analysis/timeline.md"
sources_path: "sources/"
```

## METODOLOGIA

### FASE 1: IDENTIFICAÇÃO DE VALORES
1. Analisar sacrifícios e escolhas difíceis
2. Mapear conflitos e defesas consistentes
3. Triangular evidências de múltiplas fontes
4. Validar com mínimo 3 evidências independentes

### FASE 2: HIERARQUIZAÇÃO
1. Rankear por intensidade e imutabilidade
2. Documentar contextos de violação/preservação
3. Mapear trade-offs recorrentes
4. Identificar valores supremos vs. contextuais

## OUTPUT ESTRUTURADO

Use este formato:

# HIERARQUIA DE VALORES: [NOME]

## METODOLOGIA
- Fontes analisadas: [N] documentos/horas
- Comportamentos catalogados: [N] decisões significativas
- Período coberto: [X] anos
- Método de validação: Triangulação entre palavras, ações e consequências aceitas

## HIERARQUIA CORE (TOP 15)

### VALOR SUPREMO #1: [NOME DO VALOR]
**Intensidade:** 10/10
**Imutabilidade:** [Nunca violado / Raras exceções / Contextual]

**EVIDÊNCIAS COMPORTAMENTAIS:**
1. **[Data/Contexto]**: Escolheu [X] sacrificando [Y]
   - Custo real: [O que perdeu]
   - Benefício: [O que ganhou]
   - Quote: "[O que disse sobre isso]"
   - Fonte: [Onde está documentado]

2. **[Data/Contexto]**: Recusou [Oportunidade] porque violaria este valor
   - Valor da oportunidade: [$$$ ou importância]
   - Justificativa: "[Como explicou]"
   - Consequências: [O que aconteceu depois]
   - Fonte: [Onde está documentado]

3. **[Data/Contexto]**: Conflito com [Pessoa] sobre este valor
   - Issue: [Qual era o problema]
   - Posição tomada: [O que defendeu]
   - Resultado: [Rompimento/Resolução]
   - Fonte: [Onde está documentado]

**LINGUAGEM REVELADORA:**
- Palavras associadas: [Termos que usa quando fala disso]
- Metáforas: [Como conceptualiza]
- Tom emocional: [Como muda quando toca no assunto]

**TESTE EXTREMO:**
- Situação limite documentada: [Quando foi ao extremo]
- Escolheria morrer por isso? [S/N baseado em evidência]
- Violações documentadas: [0 / Quantidade e contexto]

**TENSÕES GERADAS:**
- Conflita com: [Outros valores]
- Conflita com: [Pessoas/grupos]
- Preço recorrente: [O que sempre paga]

**ORIGEM PROVÁVEL:**
- Evento formativo: [Experiência que criou/reforçou]
- Influência: [Pessoa/filosofia que inspirou]
- Idade de cristalização: [Quando se tornou central]

---

### VALOR #2: [NOME DO VALOR]
**Intensidade:** 9.5/10
[Continue mesmo formato completo...]

### VALOR #3: [NOME DO VALOR]
**Intensidade:** 9/10
[Continue mesmo formato completo...]

[Continue até VALOR #15]

## ANTI-VALORES (REJEIÇÕES VISCERAIS)

### ANTI-VALOR #1: [O QUE MAIS REJEITA]
**Intensidade da Rejeição:** 10/10

**MANIFESTAÇÕES:**
- Como identifica: [Sinais que procura]
- Resposta física: [Reações corporais documentadas]
- Resposta verbal: "[Frases típicas de rejeição]"
- Resposta comportamental: [O que faz quando encontra]

**PESSOAS QUE REPRESENTAM:**
- [Nome]: "[Por que os vê como embodiment]"
- [Nome]: "[Por que os vê como embodiment]"

**ENERGIA GASTA COMBATENDO:**
- Horas por semana: [Estimativa baseada em evidência]
- % do discurso público: [Quanto fala sobre]
- Recursos investidos: [Dinheiro/tempo/atenção]

**CUSTO DA REJEIÇÃO:**
- Oportunidades perdidas: [O que deixou de ganhar]
- Relacionamentos perdidos: [Quem afastou]
- Energia desperdiçada: [Que poderia usar para criar]

**EXCEÇÕES DOCUMENTADAS:**
- [Situação onde tolerou]: Por quê: [Razão]

---

### ANTI-VALOR #2: [PRÓXIMA REJEIÇÃO]
[Continue mesmo formato...]

## TRADE-OFFS DOCUMENTADOS

### TRADE-OFF #1
**Sempre escolhe [A] sobre [B]**
- Exemplo 1: [Situação específica com data]
- Exemplo 2: [Situação específica com data]
- Exemplo 3: [Situação específica com data]
- Racionalização: "[Como justifica]"
- Exceções: [Se existem, quando ocorreram]

### TRADE-OFF #2
**Nunca escolheria [X] mesmo que significasse [Y]**
- Teste real: [Quando foi testado]
- Custo aceito: [O que perdeu]
- Sem arrependimento: [Evidência que não se arrepende]

[Continue com mais trade-offs...]

## EVOLUÇÃO DOS VALORES

### FASE 1: [Idade X-Y]
**Valores Dominantes:**
1. [Valor]: Intensidade [N]/10
2. [Valor]: Intensidade [N]/10
3. [Valor]: Intensidade [N]/10

**Evento de Transição:** [O que mudou tudo]

### FASE 2: [Idade Y-Z]
**Valores Dominantes:**
1. [Valor]: Intensidade [N]/10
2. [Valor]: Intensidade [N]/10
3. [Valor]: Intensidade [N]/10

**Evento de Transição:** [O que mudou tudo]

### FASE ATUAL: [Idade Z+]
**Valores Dominantes:**
1. [Valor]: Intensidade [N]/10
2. [Valor]: Intensidade [N]/10
3. [Valor]: Intensidade [N]/10

## HIERARQUIA SITUACIONAL

### No Trabalho
1. [Valor prioritário] - Por quê: [Evidência]
2. [Segundo valor] - Por quê: [Evidência]
3. [Terceiro valor] - Por quê: [Evidência]

### Em Família
1. [Valor prioritário] - Por quê: [Evidência]
2. [Segundo valor] - Por quê: [Evidência]
3. [Terceiro valor] - Por quê: [Evidência]

### Em Crise
1. [Valor prioritário] - Por quê: [Evidência]
2. [Segundo valor] - Por quê: [Evidência]
3. [Terceiro valor] - Por quê: [Evidência]

### Em Abundância
1. [Valor prioritário] - Por quê: [Evidência]
2. [Segundo valor] - Por quê: [Evidência]
3. [Terceiro valor] - Por quê: [Evidência]

## VALORES PERFORMADOS vs. REAIS

### Valores que DIZ ter (mas evidência não suporta)
1. **[Valor]**:
   - Claim: "[O que diz]"
   - Contra-evidência: [Comportamentos opostos]
   - Função da performance: [Por que finge ter]

### Valores que TEM (mas não admite)
1. **[Valor]**:
   - Evidência comportamental: [Ações consistentes]
   - Por que não admite: [Razão provável]
   - Como mascara: [Estratégia]

## SISTEMA DE VALORES COMO ALGORITMO

```python
def decidir(situacao):
    # Hierarquia de decisão baseada em valores

    if viola(valor_supremo_1):
        return "NUNCA"

    elif promove(valor_supremo_1):
        return "SEMPRE"

    elif conflito(valor_2, valor_3):
        if contexto == "profissional":
            return escolher(valor_2)
        else:
            return escolher(valor_3)

    elif envolve(anti_valor_1):
        return "REJEITAR_VISCERALMENTE"

    else:
        return avaliar_caso_a_caso()
```

## VALIDAÇÃO EXTERNA

### O que aliados confirmam
- [Valor]: "[Quote de confirmação]" - [Fonte]

### O que críticos admitem
- [Valor]: "[Quote reluctante]" - [Fonte]

### O que neutros observam
- [Valor]: "[Observação]" - [Fonte]

## PONTOS DE PRESSÃO

### Valor mais fácil de comprometer
**[Valor]**: Sob condições de [contexto]
- Evidência: [Quando comprometeu]

### Valor impossível de comprometer
**[Valor]**: Nem mesmo sob [condição extrema]
- Evidência: [Quando foi testado ao limite]

## FÓRMULA DE VALOR PESSOAL

Como [NOME] calcula valor/prioridade:

```
Valor = [Métrica primária] × [Multiplicador contextual] / [Custo percebido]

Onde:
- Métrica primária = [Ex: Impacto, Inovação, Lucro]
- Multiplicador = [Ex: Alinhamento com missão]
- Custo = [Ex: Tempo, energia, compromissos]

Threshold de ação = [Valor mínimo para agir]
```

## IMPLICAÇÕES PARA CLONE

**Valores que DEVEM estar no core:**
1. [Valor] - Peso: MÁXIMO
2. [Valor] - Peso: MÁXIMO
3. [Valor] - Peso: MÁXIMO

**Anti-valores que DEVEM gerar rejeição:**
1. [Anti-valor] - Reação: VISCERAL
2. [Anti-valor] - Reação: VISCERAL

**Trade-offs que DEVEM ser preservados:**
1. Sempre [A] sobre [B]
2. Nunca [X] mesmo que [Y]

**Conflitos que NÃO devem ser resolvidos:**
1. Entre [Valor A] e [Valor B] - manter tensão

## TESTE DE VALIDAÇÃO

**Pergunta crítica:** Quando forçados a escolher, qual valor SEMPRE vence?
- Resposta baseada em evidências: [Valor supremo]

**Cenário de teste:**
[Situação que força escolha entre top 3 valores]
- Predição baseada nesta hierarquia: [Como agiria]
- Evidência que suporta: [Comportamento passado similar]
```

## CHECKLIST DE QUALIDADE

- [ ] Top 15 valores identificados com evidências
- [ ] Cada valor tem 3+ evidências independentes
- [ ] Anti-valores mapeados com manifestações
- [ ] Trade-offs documentados com exemplos
- [ ] Evolução temporal traçada
- [ ] Valores performados vs. reais diferenciados
- [ ] Algoritmo de decisão criado
- [ ] Validação externa incluída
- [ ] Fórmula de valor pessoal identificada

## ALERTAS CRÍTICOS

- Anti-valores são features, não bugs - Preserve-os
- Não force coerência - Humanos têm valores conflitantes
- Evidence-based only - Sem 3+ evidências, descarte
- Preserve hierarquia - Ordem importa tanto quanto conteúdo
- Contexto modifica mas não elimina - Valores core persistem
- Arquivo values_hierarchy.md deve estar em analysis/ conforme OUTPUTS_GUIDE.md
- Valores determinam tudo - Este arquivo é o coração do clone cognitivo