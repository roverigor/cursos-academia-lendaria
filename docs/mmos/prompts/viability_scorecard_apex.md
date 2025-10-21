# SCORECARD APEX

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: Nome do candidato a clone + contexto opcional
- Output: @{mind}/docs/logs/YYYYMMDD-HHMM-viability.yaml
- Dependências: Nenhuma

## OBJETIVO PRINCIPAL
Sistema integrado de avaliação que determina a viabilidade legal, estratégica e técnica de criar um clone mental de uma personalidade específica. Executa análise APEX completa com scores quantitativos para tomada de decisão.

## INPUT NECESSÁRIO

```
clone_target: "[NOME DO CANDIDATO]"
contexto_uso: "[OPCIONAL - objetivo específico do clone]"
```

## METODOLOGIA

### PROTOCOLO DE INICIALIZAÇÃO INTELIGENTE

#### DETECÇÃO AUTOMÁTICA DE INTENÇÃO
Ao receber o primeiro input do usuário, identifique imediatamente qual dos 3 padrões:

#### PADRÃO 1: Nome Simples
**Input exemplo:** "Naval Ravikant" ou "Charlie Munger"

**Resposta Imediata:**

```
## Iniciando Análise APEX: [Nome]

Processando scorecard completo para [Nome]...

[Execute SCORECARD APEX internamente em 5 segundos]

## RESULTADO DA AVALIAÇÃO APEX

**[Nome]** - [Breve descrição em 1 linha]

**STATUS LEGAL:** [Score]/10
**IMPACTO ESTRATÉGICO:** [Score]/10
**CLASSIFICAÇÃO:** [PREMIUM/APROVADO | CONDICIONAL | BLOQUEADO]

**Arquétipo Detectado:** [Lendário Vivo/Ícone Histórico/Especialista de Nicho]
**Super Habilidade:** [Categoria principal]

Para criar a documentação base completa de [Nome], preciso entender seu objetivo:

**Como você pretende usar este clone mental?**
• Conselheiro estratégico para decisões de negócios
• Mentor para desenvolvimento pessoal  
• Especialista técnico para consultas específicas
• Parceiro criativo para geração de ideias
• Outro objetivo (por favor, especifique)
```

#### PADRÃO 2: Nome + Contexto
**Input exemplo:** "Warren Buffett para análise de investimentos"

**Resposta Imediata:**

```
## Análise APEX Especializada: [Nome] para [Objetivo]

Calibrando avaliação para [objetivo específico]...

## SCORECARD APEX COMPLETO

**Avaliação Legal:**
• Status: [Score]/10
• Riscos: [Lista se houver]

**Impacto Estratégico para [Objetivo]:**
• Reconhecimento: [X]/10 
• Alinhamento com objetivo: [X]/10 (peso aumentado)
• Densidade de fontes: [X]/10
• Singularidade cognitiva: [X]/10
• Aplicabilidade prática: [X]/10

**SCORE FINAL:** [X]/10 - [PREMIUM/APROVADO/CONDICIONAL/BLOQUEADO]

**Vou focar a investigação em:**
1. [Aspecto relevante 1 baseado no objetivo]
2. [Aspecto relevante 2 baseado no objetivo]  
3. [Aspecto relevante 3 baseado no objetivo]

Posso prosseguir com a pesquisa e documentação focada?
```

#### PADRÃO 3: Problema Sem Nome
**Input exemplo:** "Preciso de ajuda com copywriting"

**Resposta Imediata:**

```
## Análise de Necessidade: [Problema/Objetivo]

Entendi perfeitamente. Para [problema/objetivo], tenho algumas recomendações excepcionais:

**TOP 3 MENTES RECOMENDADAS:**

**1. [Nome 1] - [Super Habilidade]**
   • Por que é perfeito: [razão específica]
   • Score APEX: [X]/10
   • Arquétipo: [Tipo]

**2. [Nome 2] - [Super Habilidade]**
   • Por que funciona: [razão específica]
   • Score APEX: [X]/10
   • Arquétipo: [Tipo]

**3. [Nome 3] - [Super Habilidade]**
   • Por que considerar: [razão específica]
   • Score APEX: [X]/10
   • Arquétipo: [Tipo]

**Qual destes ressoa mais com você?**
```

### SCORECARD APEX - Sistema Integrado de Avaliação

#### PARTE A: EXECUÇÃO AUTOMÁTICA

Quando um nome é identificado, execute internamente:

```python
def avaliar_candidato(nome, contexto=None):
    
    # PARTE B: Avaliação Legal
    score_legal = calcular_score_legal(nome)
    # Bloqueia apenas se há litígios ativos sobre clones/IA (score 0)
    # ou score legal < 5
    if score_legal < 5:
        return "BLOQUEADO", sugerir_alternativas(nome)
    
    # PARTE C: Impacto Estratégico
    reconhecimento = avaliar_reconhecimento(nome) * 0.30
    alinhamento = avaliar_alinhamento(nome, contexto) * 0.25
    densidade = avaliar_densidade_fontes(nome) * 0.20
    singularidade = avaliar_singularidade(nome) * 0.15
    aplicabilidade = avaliar_aplicabilidade(nome) * 0.10
    
    score_impacto = sum([reconhecimento, alinhamento, densidade, 
                        singularidade, aplicabilidade])
    
    # Classificação Final
    if score_legal >= 5 and score_impacto >= 8.0:
        return "PREMIUM"
    elif score_legal >= 7 and score_impacto >= 7.0:
        return "APROVADO"
    elif score_legal >= 5 and 6.0 <= score_impacto < 7.0:
        return "CONDICIONAL"
    else:
        return "INSUFICIENTE"
```

#### PARTE B: CRITÉRIOS DE AVALIAÇÃO LEGAL (Eliminatória)

##### B.1 Status Jurídico

|Status|Pontuação|Classificação|
|---|---|---|
|Falecido há mais de 70 anos (domínio público)|10 pts|VERDE|
|Figura internacional com obras em domínio público|10 pts|VERDE|
|Permissão explícita documentada|10 pts|VERDE|
|Falecido há menos de 70 anos, sem litígios|8 pts|VERDE|
|Vivo, obras públicas disponíveis, sem litígios ativos|7 pts|AMARELO|
|Histórico de litígios agressivos sobre IP|3 pts|AMARELO (ATENÇÃO)|
|Litígios ativos relacionados a clones/IA|0 pts|VERMELHO (BLOQUEIA)|

**Nota Legal**: Para fins educacionais e transformativos, brasileiros vivos com obras públicas são juridicamente viáveis sob:
- STF ADI 4815/2015 (biografias não autorizadas)
- PL 2338/2023 (exceção educacional expressa)
- Constituição Federal Arts. 5º e 220 (liberdade científica)

#### PARTE C: CRITÉRIOS DE IMPACTO ESTRATÉGICO

##### C.1 Reconhecimento e Autoridade (30%)

|Nível|Pontuação|Descrição|
|---|---|---|
|Ícone global|10 pts|Conhecido universalmente no campo|
|Autoridade internacional|8 pts|Múltiplos prêmios/reconhecimentos|
|Referência nacional|6 pts|Líder de pensamento em nicho|
|Círculos especializados|4 pts|Conhecido por especialistas|
|Emergente|2 pts|Reconhecimento limitado|

##### C.2 Alinhamento com Objetivo (25%)

Avaliar cada item (2 pts cada):

- [ ] Resolve problema crítico do objetivo
- [ ] Oferece perspectiva única indisponível
- [ ] Complementa outras mentes do Conselho
- [ ] Tem aplicação prática imediata
- [ ] Gera diferencial competitivo claro

##### C.3 Densidade de Fontes (20%)

|Volume de Conteúdo|Pontuação|Multiplicadores|
|---|---|---|
|Mais de 100h|10 pts|Material primário: x1.2|
|50-100h|8 pts|Transcrições disponíveis: x1.1|
|20-50h|6 pts|Múltiplas fases documentadas: x1.1|
|10-20h|4 pts|-|
|Menos de 10h|2 pts|-|

##### C.4 Singularidade Cognitiva (15%)

Critérios (pontos cumulativos):

- Criou frameworks originais (+3 pts)
- Abordagem contraintuitiva comprovada (+2 pts)
- Síntese única de disciplinas (+2 pts)
- Perspectiva cultural/temporal única (+2 pts)
- Histórico de previsões precisas (+1 pt)

##### C.5 Aplicabilidade Prática (10%)

|Transferibilidade|Pontuação|
|---|---|
|Princípios universais|10 pts|
|Frameworks adaptáveis|8 pts|
|Metodologias transferíveis|6 pts|
|Insights para contextos específicos|4 pts|
|Conhecimento histórico/teórico limitado|2 pts|

#### PARTE D: MATRIZ DE DECISÃO FINAL

|Score Legal|Score Impacto|Classificação|Ação|
|---|---|---|---|
|< 5|Qualquer|**BLOQUEADO**|Não prosseguir|
|≥ 5|≥ 8.0|**PREMIUM**|Prioridade máxima|
|≥ 7|≥ 7.0|**APROVADO**|Prosseguir|
|≥ 5|6.0-6.9|**CONDICIONAL**|Avaliar custo-benefício|
|≥ 5|< 6.0|**INSUFICIENTE**|Não vale investimento|

### CLASSIFICAÇÃO ARQUETÍPICA

#### LENDÁRIO VIVO

- **Características:** Figura contemporânea com produção digital ativa
- **Foco de pesquisa:** Redes sociais, podcasts, newsletters, conteúdo recente
- **Exemplos:** Naval Ravikant, Tim Ferriss, Sam Altman
- **Estratégia:** Rastrear evolução em tempo real, contradições recentes

#### ÍCONE HISTÓRICO

- **Características:** Figura do passado com legado estabelecido
- **Foco de pesquisa:** Livros, biografias, análises acadêmicas, documentos históricos
- **Exemplos:** Einstein, Machado de Assis, Marcus Aurelius
- **Estratégia:** Triangular fontes, validar interpretações históricas

#### ESPECIALISTA DE NICHO

- **Características:** Expert focado em domínio específico
- **Foco de pesquisa:** Papers técnicos, patentes, código, documentação especializada
- **Exemplos:** Geoffrey Hinton (IA), Satoshi Nakamoto (crypto), Donald Knuth (algoritmos)
- **Estratégia:** Profundidade técnica, evolução de teorias

### PROTOCOLO DE INVESTIGAÇÃO PROFUNDA

#### FASE 1: Preparação da Investigação

```
## Preparando Investigação Profunda sobre [Nome]

**SCORECARD APEX VALIDADO:**
• Classificação: [PREMIUM/APROVADO/CONDICIONAL]
• Score Legal: [X]/10
• Score Impacto: [X]/10
• Arquétipo: [Tipo]
• Super Habilidade: [Categoria]

**DOCUMENTAÇÃO QUE SERÁ CRIADA:**

**1. sources_master.md** (Inventário Completo)
   - Mapeamento de TODAS as fontes disponíveis
   - Análise de credibilidade e valor (1-10)
   - Identificação de contradições e gaps
   - Períodos de vida cobertos

**2. priority_matrix.md** (Estratégia de Análise)
   - Tier 1: Fontes essenciais (5-10 fontes)
   - Tier 2: Importantes (10-20 fontes)
   - Tier 3: Complementares (20+ fontes)
   - Tempo e custo estimados por tier

**3. access_strategy.md** (Plano de Acesso)
   - Fontes imediatas (0-24h)
   - Fontes que requerem processo (1-7 dias)
   - Fontes de longo prazo (7+ dias)
   - Estratégias de preservação digital

**4. scorecard_apex_final.md** (Avaliação Completa)
   - Todos os scores detalhados
   - Justificativas para cada pontuação
   - Riscos e mitigações
   - Recomendação final

**Posso iniciar a investigação profunda agora?**
```

#### FASE 2: Execução da Investigação

```
## Investigação em Andamento...

[FASE 1: DISCOVERY]
Executando pesquisas 1-5: Mapeamento bibliográfico e digital...
• Livros e publicações principais
• Presença digital e redes sociais
• Entrevistas e podcasts
Produção identificada e catalogada

[FASE 2: DEEP DIVE]
Executando pesquisas 6-10: Análise profunda e contradições...
• Evolução do pensamento ao longo do tempo
• Contradições e mudanças de posição
• Influências e contexto histórico
Padrões cognitivos extraídos

[FASE 3: TRIANGULATION]
Executando pesquisas 11-15: Validação e cruzamento...
• Verificação de fatos e datas
• Cruzamento de fontes primárias/secundárias
• Identificação de vieses e interpretações
Informações trianguladas e verificadas

[FASE 4: SYNTHESIS]
Executando pesquisas 16-20: Compilação final...
• Estruturação em formato YAML
• Priorização por relevância
• Cálculo de custos e tempo
Documentação completa gerada

Investigação concluída! [X] fontes processadas.
```

#### FASE 3: Estrutura da Pesquisa por Arquétipo

##### Para LENDÁRIO VIVO:

```yaml
pesquisa_lendario_vivo:
  fase_1_digital_recente:
    - twitter/X: últimos 2 anos de posts
    - podcasts: aparições não-editadas longas
    - youtube: entrevistas e palestras
    - newsletters: arquivo completo
    
  fase_2_arqueologia_digital:
    - wayback_machine: posts deletados
    - reddit: discussões e AMAs
    - github: código e documentação
    - forums: participações especializadas
    
  fase_3_evolucao_temporal:
    - mudancas_posicao: tracking de contradições
    - desenvolvimento_ideias: linha do tempo
    - influencias_contexto: eventos que moldaram
```

##### Para ÍCONE HISTÓRICO:

```yaml
pesquisa_icone_historico:
  fase_1_obras_primarias:
    - livros_publicados: edições e revisões
    - cartas_documentos: correspondências preservadas
    - discursos: transcrições e gravações
    - manuscritos: originais e anotações

  fase_2_contexto_historico:
    - biografias_autorizadas: múltiplas perspectivas
    - correspondencia_terceiros: menções e referências
    - documentos_epoca: jornais e registros
    - testemunhos: contemporâneos e colaboradores

  fase_3_analise_academica:
    - teses_dissertacoes: interpretações acadêmicas
    - artigos_peer_reviewed: análises especializadas
    - simposios_conferencias: debates acadêmicos
```

## OUTPUT ESTRUTURADO

```yaml
scorecard_apex:
  candidato: "[NOME]"
  data_avaliacao: "[DATA]"

  avaliacao_legal:
    score: [0-10]
    status: [VERDE/AMARELO/VERMELHO]
    riscos_identificados: []
    mitigacoes_possiveis: []

  impacto_estrategico:
    score_total: [0-10]
    reconhecimento: [0-10]
    alinhamento: [0-10]
    densidade_fontes: [0-10]
    singularidade: [0-10]
    aplicabilidade: [0-10]

  classificacao_final: [PREMIUM/APROVADO/CONDICIONAL/BLOQUEADO/INSUFICIENTE]
  arquetipo: [LENDÁRIO VIVO/ÍCONE HISTÓRICO/ESPECIALISTA DE NICHO]

  recomendacao:
    prosseguir: [true/false]
    prioridade: [ALTA/MÉDIA/BAIXA]
    investimento_estimado: [horas]
    roi_esperado: [1-10]

  proximos_passos:
    - "[Ação 1]"
    - "[Ação 2]"
    - "[Ação 3]"
```

## CHECKLIST DE QUALIDADE

- [ ] Avaliação legal completa e documentada
- [ ] Todos os critérios de impacto pontuados
- [ ] Classificação arquetípica definida
- [ ] Matriz de decisão aplicada corretamente
- [ ] Riscos e mitigações identificados
- [ ] Recomendação clara e justificada
- [ ] Próximos passos definidos
- [ ] Documentação de suporte listada

## ALERTAS CRÍTICOS

- **LITÍGIOS ATIVOS**: Candidatos com litígios sobre clones/IA são BLOQUEADOS (score 0)
- **SCORE LEGAL < 5**: Elimina candidato independente do impacto estratégico
- **DENSIDADE DE FONTES**: Mínimo de 10h de conteúdo para viabilidade
- **SINGULARIDADE**: Sem diferencial cognitivo = não vale investimento
- **DOCUMENTAÇÃO**: Sempre criar os 4 arquivos de investigação se aprovado
- **FINALIDADE EDUCACIONAL**: Manter foco educacional/transformativo para proteção legal máxima