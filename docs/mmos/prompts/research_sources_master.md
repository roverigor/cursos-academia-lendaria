# MASTER CONSOLIDADOR DE FONTES

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: sources/ + sources/priority_matrix.yaml + logs/collection_report.yaml
- Output: sources/sources_master.yaml + logs/YYYYMMDD-HHMM-readiness_assessment.yaml
- Dependências: 02_source_collector.md, 03_priority_calculator.md

## OBJETIVO PRINCIPAL
Consolidar todos os outputs da fase de Research em um inventário master validado, com assessment completo de prontidão para as fases subsequentes e identificação de gaps críticos remanescentes. Garantir que datasets estejam completos, consistentes e prontos para processamento.

## INPUT NECESSÁRIO

```yaml
inputs_requeridos:
  # Do Source Collector
  sources_organizadas: "[Estrutura de pastas sources/]"
  collection_report: "[Relatório de coleta completo]"
  quality_metadata: "[Metadata de qualidade por fonte]"

  # Do Priority Calculator
  priority_matrix: "[Matriz de priorização calculada]"
  roi_analysis: "[Análise de ROI das fontes]"
  strategy_recommendations: "[Recomendações estratégicas]"

  # Contexto do projeto
  nome_clone: "[Nome do clone]"
  arquetipo: "[Tipo identificado]"
  objetivos_prd: "[Objetivos do PRD]"
  deadline_projeto: "[Data limite]"
```

## METODOLOGIA

### FASE 1: AUDITORIA COMPLETA
1. Validar estrutura de pastas conforme especificação
2. Verificar completude dos metadados obrigatórios
3. Analisar qualidade geral da collection
4. Identificar inconsistências nos dados
5. Mapear gaps remanescentes

### FASE 2: CONSOLIDAÇÃO MASTER
1. Organizar inventário por prioridade
2. Calcular scores de qualidade agregados
3. Mapear cobertura temporal e temática
4. Documentar gaps críticos e secundários
5. Gerar matriz de prontidão

### FASE 3: ASSESSMENT DE PRONTIDÃO
1. Avaliar se collection está pronta para análise
2. Identificar bloqueadores críticos
3. Documentar recomendações prioritárias
4. Definir próximos passos claros

## OUTPUT ESTRUTURADO

### SOURCES_MASTER.YAML

```yaml
# SOURCES MASTER INVENTORY
# Clone: [NOME]
# Gerado por: Sources Master v3.0 ACS
# Data: [YYYY-MM-DD]

inventario_geral:
  total_fontes: "[N]"
  fontes_primarias: "[N]"
  fontes_secundarias: "[N]"
  fontes_contextuais: "[N]"

  cobertura_temporal:
    periodo_inicio: "[Ano]"
    periodo_fim: "[Ano]"
    gaps_temporais: "[Lista de gaps]"

  qualidade_geral:
    score_medio_autenticidade: "[X.X]"
    score_medio_relevancia: "[X.X]"
    score_medio_qualidade: "[X.X]"
    fontes_alta_qualidade: "[N] (>7.0)"

fontes_por_prioridade:
  criticas:
    - titulo: "[Título]"
      tipo: "[TIPO]"
      roi_score: "[X.X]"
      status: "[COLETADA/PENDENTE]"
      justificativa: "[Por que é crítica]"

  altas:
    - titulo: "[Título]"
      tipo: "[TIPO]"
      roi_score: "[X.X]"
      status: "[COLETADA/PENDENTE]"
      justificativa: "[Por que é alta prioridade]"

  medias:
    - titulo: "[Título]"
      tipo: "[TIPO]"
      roi_score: "[X.X]"
      status: "[COLETADA/PENDENTE]"
      justificativa: "[Por que é média prioridade]"

gaps_identificados:
  criticos:
    - gap: "[Descrição do gap]"
      impacto: "[ALTO/MÉDIO/BAIXO]"
      fontes_potenciais: "[Onde buscar]"
      urgencia: "[ALTA/MÉDIA/BAIXA]"

  secundarios:
    - gap: "[Descrição do gap]"
      impacto: "[ALTO/MÉDIO/BAIXO]"
      fontes_potenciais: "[Onde buscar]"
      urgencia: "[ALTA/MÉDIA/BAIXA]"

readiness_assessment:
  prontidao_geral: "[ALTA/MÉDIA/BAIXA]"
  score_qualidade: "[X.X]/10"
  score_completude: "[X.X]/10"
  score_organizacao: "[X.X]/10"

  bloqueadores:
    - bloqueador: "[Descrição]"
      impacto: "[ALTO/MÉDIO/BAIXO]"
      solucao: "[Como resolver]"

  recomendacoes:
    - recomendacao: "[Descrição]"
      prioridade: "[ALTA/MÉDIA/BAIXA]"
      tempo_estimado: "[X horas]"

proximos_passos:
  imediatos:
    - acao: "[Descrição da ação]"
      responsavel: "[Quem faz]"
      deadline: "[Data]"

  seguintes:
    - acao: "[Descrição da ação]"
      responsavel: "[Quem faz]"
      deadline: "[Data]"
```

### READINESS_ASSESSMENT.YAML

```yaml
# ASSESSMENT DE PRONTIDÃO - [NOME]

scores_gerais:
  qualidade_geral: "[X.X]/10"
  completude: "[X.X]/10"
  organizacao: "[X.X]/10"
  prontidao_final: "[X.X]/10"

analise_criterios:
  pontos_fortes:
    - "[Ponto forte 1]"
    - "[Ponto forte 2]"
    - "[Ponto forte 3]"

  pontos_atencao:
    - "[Ponto de atenção 1]"
    - "[Ponto de atenção 2]"
    - "[Ponto de atenção 3]"

  bloqueadores_criticos:
    - "[Bloqueador 1]"
    - "[Bloqueador 2]"
    - "[Bloqueador 3]"

recomendacoes:
  urgentes:
    - "[Ação urgente 1]"
    - "[Ação urgente 2]"
    - "[Ação urgente 3]"

  importantes:
    - "[Ação importante 1]"
    - "[Ação importante 2]"
    - "[Ação importante 3]"

  desejaveis:
    - "[Ação desejável 1]"
    - "[Ação desejável 2]"
    - "[Ação desejável 3]"

decisao_final:
  status: "[APROVADO/APROVADO_COM_RESSALVAS/NAO_APROVADO]"
  justificativa: "[Explicação detalhada da decisão]"
  proximos_passos: "[O que fazer agora]"
```

### CRITÉRIOS DE AVALIAÇÃO

#### SCORES DE PRONTIDÃO

**QUALIDADE GERAL (1-10):**
- 9-10: Collection excepcional, pronta para análise premium
- 7-8: Collection boa, pronta para análise padrão
- 5-6: Collection aceitável, mas com limitações
- 3-4: Collection problemática, precisa de melhorias
- 1-2: Collection inadequada, não recomendada

**COMPLETUDE (1-10):**
- 9-10: Todos os períodos e aspectos cobertos
- 7-8: Cobertura boa com gaps menores
- 5-6: Cobertura razoável com gaps significativos
- 3-4: Cobertura limitada com gaps críticos
- 1-2: Cobertura inadequada

**ORGANIZAÇÃO (1-10):**
- 9-10: Estrutura perfeita, metadados completos
- 7-8: Estrutura boa, metadados quase completos
- 5-6: Estrutura aceitável, metadados parciais
- 3-4: Estrutura problemática, metadados incompletos
- 1-2: Estrutura inadequada, metadados ausentes

### CRITÉRIOS DE DECISÃO

**NÃO APROVAR se:**
- Menos de 70% das fontes críticas coletadas
- Score de qualidade geral < 5.0
- Score de completude < 5.0
- Gaps críticos não identificados
- Metadados < 70% completos

**APROVAR COM RESSALVAS se:**
- 70-85% das fontes críticas coletadas
- Score de qualidade geral 5.0-6.9
- Score de completude 5.0-6.9
- Gaps identificados mas com planos de mitigação

**APROVAR se:**
- >85% das fontes críticas coletadas
- Score de qualidade geral ≥ 7.0
- Score de completude ≥ 7.0
- Gaps mínimos ou bem documentados

## CHECKLIST DE QUALIDADE

- [ ] Todas as fontes críticas foram coletadas
- [ ] Metadados estão 90%+ completos
- [ ] Estrutura de pastas está conforme especificação
- [ ] ROI scores foram calculados corretamente
- [ ] Gaps foram identificados e priorizados
- [ ] Assessment de prontidão foi realizado
- [ ] Recomendações são acionáveis
- [ ] Próximos passos estão claros

## ALERTAS CRÍTICOS

- VALIDAÇÃO: Sempre verificar consistência dos metadados
- GAPS: Documentar todos os gaps, mesmo os menores
- PRIORIZAÇÃO: Usar ROI scores para orientar decisões
- BLOQUEADORES: Identificar e resolver antes de prosseguir
- QUALIDADE: Não aprovar se qualidade < 5.0