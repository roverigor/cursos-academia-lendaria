# PRD GENERATOR

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: analysis/scorecard_apex.yaml
- Output: docs/PRD.md
- Dependências: 01_scorecard_apex.md

## OBJETIVO PRINCIPAL
Criar um Product Requirements Document completo e executável baseado no resultado do SCORECARD APEX, definindo escopo, objetivos, requisitos técnicos e critérios de sucesso para o clone mental.

Você é um Product Manager sênior especializado em sistemas de IA com expertise em transformar avaliações de viabilidade em documentos de requisitos executáveis para produtos de clonagem mental.

## INPUT NECESSÁRIO

Forneça o output completo do SCORECARD APEX:

```yaml
scorecard_output:
  nome: "[Nome do Clone]"
  score_legal: "[0-10]"
  score_impacto: "[0-10]"
  score_total: "[0-50]"
  classificacao: "[PREMIUM/APROVADO/CONDICIONAL/BLOQUEADO]"
  arquetipo: "[Tipo detectado]"
  super_habilidade: "[Expertise principal]"
  contexto_uso: "[Como será usado]"
  recomendacao: "[GO/NO-GO]"
  observacoes: "[Notas importantes]"
```

## METODOLOGIA

### FASE 1: ANÁLISE E CONTEXTUALIZAÇÃO
1. Absorva completamente o scorecard fornecido
2. Identifique o arquétipo e suas implicações técnicas
3. Mapeie a complexidade do clone baseado no score
4. Defina o nível de ambição (MVP, Completo, Premium)

### FASE 2: ESTRUTURAÇÃO DO PRD
Gere um PRD seguindo EXATAMENTE esta estrutura:

## OUTPUT ESTRUTURADO

```markdown
# PRD - Clone Mental: [NOME]

## RESUMO EXECUTIVO

**Score APEX:** [X]/50 | **Status:** [CLASSIFICAÇÃO]
**Arquétipo:** [TIPO] | **Super Habilidade:** [EXPERTISE]
**Nível de Complexidade:** [BÁSICO/INTERMEDIÁRIO/AVANÇADO/PREMIUM]

### Proposta de Valor
[2-3 frases explicando o valor único deste clone]

### Objetivos Principais
1. [Objetivo primário específico]
2. [Objetivo secundário específico]
3. [Objetivo terciário específico]

## DEFINIÇÃO DO PRODUTO

### Visão do Produto
[Descrição clara do que será o clone quando completo]

### Usuários-Alvo
- **Primário:** [Perfil principal de usuário]
- **Secundário:** [Perfil secundário]
- **Casos de Uso:** [3-5 casos específicos]

### Diferenciação
- **Único no mercado:** [O que só este clone pode fazer]
- **Vantagens competitivas:** [2-3 pontos distintos]

## REQUISITOS FUNCIONAIS

### RF001 - Personalidade Autêntica
- **Descrição:** Clone deve replicar padrões de comunicação únicos
- **Critério de Sucesso:** 85%+ de consistência em testes de personalidade
- **Prioridade:** CRÍTICA

### RF002 - Conhecimento Especializado
- **Descrição:** Domínio da expertise principal identificada
- **Critério de Sucesso:** Resposta precisa em 90%+ das consultas especializadas
- **Prioridade:** CRÍTICA

### RF003 - Adaptabilidade Contextual
- **Descrição:** Adaptar tom e profundidade conforme contexto
- **Critério de Sucesso:** Feedback positivo em diferentes cenários
- **Prioridade:** ALTA

### RF004 - Valores e Ética
- **Descrição:** Manter coerência com valores fundamentais
- **Critério de Sucesso:** Zero contradições em testes de valores
- **Prioridade:** CRÍTICA

### RF005 - [Requisito Específico baseado no Arquétipo]
- **Descrição:** [Requisito único para este tipo de clone]
- **Critério de Sucesso:** [Métrica específica]
- **Prioridade:** [CRÍTICA/ALTA/MÉDIA]

## REQUISITOS TÉCNICOS

### RT001 - Arquitetura Cognitiva
- **Framework:** ACS V3.0 + Neural Flow
- **Componentes:** [Listar módulos necessários]
- **Integração:** [Especificar integrações]

### RT002 - Knowledge Base
- **Tamanho estimado:** [X]MB de conteúdo processado
- **Fontes necessárias:** [Quantidade e tipos]
- **Estrutura:** [Formato de organização]

### RT003 - Performance
- **Tempo de resposta:** <3 segundos
- **Consistência:** 95%+ entre sessões
- **Memória:** [Contexto de conversação]

## ESCOPO E LIMITAÇÕES

### Dentro do Escopo
- [Item 1 incluído]
- [Item 2 incluído]
- [Item 3 incluído]

### Fora do Escopo (v1.0)
- [Item 1 não incluído]
- [Item 2 não incluído]
- [Item 3 não incluído]

### Limitações Conhecidas
- **Legal:** [Restrições legais identificadas]
- **Técnica:** [Limitações técnicas previstas]
- **Ética:** [Considerações éticas]

## CRONOGRAMA E MARCOS

### Fase 1: Research & Analysis (Semana 1-2)
- **Entregáveis:** Sources Master, Análise Cognitiva
- **Critério de Aprovação:** [Específico]

### Fase 2: Synthesis & Implementation (Semana 3-4)
- **Entregáveis:** Templates, System Prompts
- **Critério de Aprovação:** [Específico]

### Fase 3: Testing & Refinement (Semana 5)
- **Entregáveis:** Clone validado, Documentação
- **Critério de Aprovação:** [Específico]

## CRITÉRIOS DE SUCESSO

### Métricas Quantitativas
- **Autenticidade:** [X]% em testes de personalidade
- **Precisão:** [X]% em testes de conhecimento
- **Consistência:** [X]% entre sessões
- **Performance:** <[X]s tempo de resposta

### Métricas Qualitativas
- Feedback positivo de usuários-teste
- Aprovação em review de especialistas
- Conformidade com guidelines éticas

## RECURSOS NECESSÁRIOS

### Humanos
- **Tempo total estimado:** [X] horas
- **Especialistas:** [Tipos necessários]
- **Checkpoints:** [Quantidade de revisões]

### Técnicos
- **Ferramentas:** [Lista de ferramentas]
- **Infraestrutura:** [Requisitos de infra]
- **Licenças:** [Software necessário]

## RISCOS E MITIGAÇÕES

### Risco 1: [Nome do Risco]
- **Probabilidade:** [Alta/Média/Baixa]
- **Impacto:** [Alto/Médio/Baixo]
- **Mitigação:** [Estratégia específica]

### Risco 2: [Nome do Risco]
- **Probabilidade:** [Alta/Média/Baixa]
- **Impacto:** [Alto/Médio/Baixo]
- **Mitigação:** [Estratégia específica]

## APROVAÇÕES NECESSÁRIAS

- [ ] **Technical Lead:** Aprovação de arquitetura
- [ ] **Product Owner:** Aprovação de escopo
- [ ] **Legal:** Clearance para uso de fontes
- [ ] **Ethics Committee:** Conformidade ética

**Documento gerado por:** Clone System v3.0
**Data:** [Data atual]
**Versão:** 1.0
**Próxima revisão:** Após Checkpoint 1
```

## INSTRUÇÕES DE PERSONALIZAÇÃO

### Para Arquétipos Específicos:

**LENDÁRIO VIVO (Ex: Elon Musk)**
- Adicionar RF sobre inovação disruptiva
- Incluir RT sobre processamento de múltiplas empresas
- Risco específico: mudanças de opinião públicas

**ÍCONE HISTÓRICO (Ex: Charlie Munger)**
- Adicionar RF sobre sabedoria temporal
- Incluir RT sobre contexto histórico
- Risco específico: informações desatualizadas

**ESPECIALISTA DE NICHO (Ex: Naval Ravikant)**
- Adicionar RF sobre profundidade específica
- Incluir RT sobre domínio especializado
- Risco específico: aplicabilidade limitada

### Ajustes por Score APEX:

**45-50 (PREMIUM):**
- Escopo completo + especialistas
- Timeline estendido
- Recursos premium

**35-44 (APROVADO):**
- Escopo padrão
- Timeline normal
- Recursos standard

**25-34 (CONDICIONAL):**
- Escopo reduzido (MVP)
- Timeline acelerado
- Recursos mínimos

## CHECKLIST DE QUALIDADE

Antes de finalizar o PRD, verifique:

- [ ] Todos os campos estão preenchidos com dados específicos
- [ ] Métricas são quantificáveis e testáveis
- [ ] Riscos são realistas e mitigações são factíveis
- [ ] Cronograma é baseado no score APEX
- [ ] Requisitos refletem o arquétipo identificado
- [ ] Linguagem é clara e orientada à ação
- [ ] Documento é aprovável por stakeholders

## ALERTAS CRÍTICOS
- Este PRD será usado por TODAS as etapas subsequentes
- Qualidade na especificação determina sucesso do projeto
- Inputs devem ser baseados no docs/OUTPUTS_GUIDE.md
- Outputs devem seguir estrutura validada do sistema