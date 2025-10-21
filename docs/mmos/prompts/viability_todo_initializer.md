# TODO INITIALIZER

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: @{mind}/docs/PRD.md, @{mind}/metadata/dependencies.yaml, @{mind}/artifacts/scorecard_apex.yaml
- Output: @{mind}/docs/TODO.md
- Dependências: 01_scorecard_apex.md, 02_prd_generator.md, 02_dependencies_mapper.md

## OBJETIVO PRINCIPAL
Criar um TODO.md dinâmico, específico e executável que servirá como roadmap principal para toda a execução do projeto de clonagem mental, baseado no PRD e mapa de dependências gerados anteriormente.

Você é um Project Manager especializado em projetos de IA e clonagem mental com expertise em transformar especificações e dependências em roadmaps executáveis e dinâmicos.

## INPUT NECESSÁRIO

```yaml
inputs_requeridos:
  # Do PRD
  nome_clone: "[Nome do clone]"
  score_apex: "[0-50]"
  classificacao: "[PREMIUM/APROVADO/CONDICIONAL]"
  arquetipo: "[Tipo identificado]"
  cronograma_prd: "[Semanas estimadas]"
  requisitos_criticos: "[Lista do PRD]"

  # Do Dependencies Map
  influencias_mapeadas: "[Quantidade]"
  fontes_primarias: "[Tipos e quantidades]"
  gaps_identificados: "[Lista de gaps]"
  prioridades_pesquisa: "[Ordem definida]"

  # Contexto adicional
  recursos_disponiveis: "[Tempo/Equipe disponível]"
  deadline_projeto: "[Se houver]"
```

## METODOLOGIA

### FASE 1: ANÁLISE CONTEXTUAL
1. Absorva todos os inputs fornecidos
2. Calcule o nível de complexidade baseado no score APEX
3. Estime esforço realista considerando recursos disponíveis
4. Identifique pontos críticos do pipeline
5. Defina marcos principais baseado no cronograma do PRD

### FASE 2: ESTRUTURAÇÃO DO TODO
Gere um TODO seguindo EXATAMENTE esta estrutura markdown detalhada com cronograma executável, checkpoints e métricas específicas baseadas nos inputs fornecidos.

## OUTPUT ESTRUTURADO

Gerar arquivo TODO.md completo com cronograma executável, marcos específicos e checkpoints mensuráveis baseados nos inputs recebidos.

## CHECKLIST DE QUALIDADE

Antes de finalizar o TODO, verificar:

- [ ] Todas as datas são realistas e específicas
- [ ] Entregáveis estão claramente definidos
- [ ] Dependências entre tarefas estão mapeadas
- [ ] Checkpoints têm critérios objetivos
- [ ] Riscos são específicos do projeto
- [ ] Métricas são mensuráveis
- [ ] Responsabilidades estão distribuídas
- [ ] Timeline reflete a complexidade real

## ALERTAS CRÍTICOS
- Este TODO será o guia central durante toda a execução
- Clareza e precisão determinam fluidez da execução
- Todos os outputs devem ser validados contra OUTPUTS_GUIDE.md
- Cronograma deve considerar dependências reais entre etapas