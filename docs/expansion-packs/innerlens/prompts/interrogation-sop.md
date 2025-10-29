# PROTOCOLO COMPLETO DE INTERROGAÇÃO

## Cognitive Clone Interview Protocol v1.0

**Versão:** 1.0  
**Data:** 2025-01-15  
**Autor:** MMOS Research Team  
**Propósito:** Extração sistemática de conhecimento para criação de clones cognitivos de alta fidelidade

-----

## ÍNDICE

- [Visão Geral](#visão-geral)
- [Instruções de Uso](#instruções-de-uso)
- [Módulo 1: História de Vida e Formação](#módulo-1-história-de-vida-e-formação)
- [Módulo 2: Sistemas de Pensamento](#módulo-2-sistemas-de-pensamento)
- [Módulo 3: Domínio e Expertise](#módulo-3-domínio-e-expertise)
- [Módulo 4: Comunicação e Expressão](#módulo-4-comunicação-e-expressão)
- [Módulo 5: Valores e Princípios](#módulo-5-valores-e-princípios)
- [Módulo 6: Contexto e Perspectiva](#módulo-6-contexto-e-perspectiva)
- [Módulo 7: Testes de Consistência](#módulo-7-testes-de-consistência)
- [Módulo 8: Validação Contra Fontes](#módulo-8-validação-contra-fontes)
- [Métricas de Qualidade](#métricas-de-qualidade)

-----

## VISÃO GERAL

Este protocolo contém **87 perguntas** organizadas em **8 módulos** para extrair conhecimento profundo sobre uma pessoa e criar um clone cognitivo autêntico.

### Estatísticas do Protocolo

- **Total de perguntas principais:** 34
- **Total de follow-ups:** 53
- **Duração estimada (interrogação):** 90-120 minutos
- **Duração estimada (research):** 20-40 horas
- **Módulos críticos:** M2, M3, M5 (requerem 80%+ coverage)
- **Fragmentos esperados:** 150-300

### Tipos de Perguntas

|Tipo             |Quantidade|Descrição                           |
|-----------------|----------|------------------------------------|
|**Factual**      |8         |Informações objetivas e verificáveis|
|**Analytical**   |9         |Análise de processos e métodos      |
|**Philosophical**|7         |Crenças, valores, worldview         |
|**Behavioral**   |5         |Padrões de ação e decisão           |
|**Stylistic**    |3         |Comunicação e expressão             |
|**Test**         |8         |Validação e consistência            |

-----

## INSTRUÇÕES DE USO

### Para o Researcher (Fase de Coleta)

1. **Processe sequencialmente** cada pergunta dos Módulos 1-6 e 8
1. Para cada pergunta:
- Use os **keywords** para buscar nas fontes
- Explore os **related_concepts** para buscas complementares
- Extraia fragmentos que cobram os **required_elements**
- Catalogue no formato YAML especificado
1. **Módulo 7** é apenas para o Detective (não pesquisar)
1. Marque **confidence level** honestamente
1. Identifique **gaps** explicitamente

### Para o Detective (Fase de Interrogação)

1. **Módulos 1-6 e 8:** Use perguntas preparadas pelo Researcher
1. **Módulo 7:** Execute testes ao vivo durante interrogação
1. Para cada resposta:
- Avalie profundidade (1-10)
- Teste consistência com respostas anteriores
- Faça follow-ups dinâmicos conforme necessário
1. Gere score final de autenticidade (0-100%)

### Códigos de Prioridade

- 🔴 **CRITICAL** - Informação essencial, clone inviável sem ela
- 🟡 **HIGH** - Informação importante, qualidade reduzida sem ela
- 🟢 **MEDIUM** - Informação desejável, adiciona nuance
- ⚪ **LOW** - Informação secundária, bom-ter

-----

## MÓDULO 1: História de Vida e Formação

**Duração:** 15-20 minutos  
**Prioridade:** 🟡 HIGH  
**Objetivo:** Mapear trajetória biográfica, experiências formativas e influências fundamentais

-----

### M1.Q1 - História Completa de Vida

**ID:** M1.Q1  
**Código:** `1.1_vida_completa`  
**Tipo:** Narrative  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Conte-me a história completa da vida de **{person_name}**, desde a infância até o momento presente. Não pule fases importantes.

#### Keywords

`childhood`, `education`, `career`, `life story`, `biography`, `timeline`, `family`, `upbringing`, `milestones`

#### Related Concepts

- Formative experiences
- Pivotal moments
- Life phases
- Personal evolution
- Family dynamics
- Cultural context

#### Elementos Requeridos

- [ ] **Infância e família de origem** - Onde nasceu, contexto familiar, primeiros anos
- [ ] **Educação formal e informal** - Escolas, universidades, aprendizados autodidatas
- [ ] **Momentos de virada críticos** - Decisões ou eventos que mudaram trajetória
- [ ] **Progressão de carreira** - Como chegou onde está
- [ ] **Eventos pessoais significativos** - Casamentos, filhos, perdas, mudanças

#### Follow-ups

1. “Que eventos específicos da infância moldaram fundamentalmente quem {person_name} se tornou?”
1. “Como foi a relação com os pais? Isso influenciou suas escolhas posteriores?”
1. “Houve algum momento de virada decisivo? Descreva-o em detalhes.”
1. “O que {person_name} estava fazendo aos 15, 25, 35 e 45 anos?”

#### Tipos de Fragmentos Esperados

- `biographical_facts` - Datas, lugares, eventos verificáveis
- `personal_anecdotes` - Histórias pessoais narradas
- `timeline_events` - Sequência cronológica
- `relationship_descriptions` - Dinâmicas familiares e sociais

#### Métricas de Qualidade

- **Completude:** Cobre todas as décadas da vida?
- **Especificidade:** Detalhes concretos vs generalidades?
- **Conexões:** Liga eventos à pessoa atual?
- **Autenticidade:** Tom pessoal vs biografia formal?

-----

### M1.Q2 - Educação e Formação

**ID:** M1.Q2  
**Código:** `1.2_educacao_formacao`  
**Tipo:** Factual  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Descreva o caminho educacional de **{person_name}**. O que estudou, onde, com quem?

#### Keywords

`education`, `study`, `school`, `university`, `learning`, `teachers`, `mentors`, `degree`, `training`

#### Related Concepts

- Intellectual development
- Academic influences
- Learning style
- Educational philosophy
- Autodidacticism

#### Elementos Requeridos

- [ ] **Instituições frequentadas** - Escolas, universidades, programas
- [ ] **Áreas de estudo** - Majors, especializações, focos
- [ ] **Mentores e influências acadêmicas** - Professores importantes, orientadores
- [ ] **Educação autodidata** - Aprendizado fora do formal
- [ ] **Método de aprendizado** - Como aprende melhor

#### Follow-ups

1. “Quem foram os mentores ou professores mais influentes?”
1. “Que livros ou ideias mudaram fundamentalmente sua forma de pensar?”
1. “Houve alguma educação formal que {person_name} rejeitou ou abandonou? Por quê?”
1. “Como {person_name} aprende coisas novas? Qual seu método?”

#### Tipos de Fragmentos Esperados

- `educational_facts` - Graus, instituições, datas
- `mentor_influences` - Quem ensinou o quê
- `learning_methods` - Como adquire conhecimento
- `intellectual_influences` - Livros, ideias, teorias importantes

-----

### M1.Q3 - Experiências Transformadoras

**ID:** M1.Q3  
**Código:** `1.3_experiencias_formativas`  
**Tipo:** Analytical  
**Profundidade Esperada:** Deep  
**Tempo:** 4 minutos

#### Pergunta Principal

> Quais foram as 3-5 experiências mais transformadoras na vida de **{person_name}**?

#### Keywords

`transformation`, `pivotal`, `turning point`, `change`, `impact`, `formative`, `crisis`, `breakthrough`

#### Related Concepts

- Personal growth
- Life lessons
- Crisis moments
- Breakthrough experiences
- Character formation

#### Elementos Requeridos

- [ ] **Lista de experiências** - 3-5 momentos transformadores identificados
- [ ] **Impacto específico** - Como cada um mudou a pessoa
- [ ] **Lições extraídas** - O que aprendeu
- [ ] **Mudanças comportamentais** - Ações diferentes resultantes
- [ ] **Padrões através das experiências** - Temas recorrentes

#### Follow-ups

1. “O que exatamente tornou cada experiência tão impactante?”
1. “Como {person_name} era antes versus depois de cada experiência?”
1. “Existem fracassos ou falhas que foram formativos? Descreva-os.”
1. “Que padrões você vê através dessas experiências?”

#### Tipos de Fragmentos Esperados

- `transformative_events` - Descrições de momentos de mudança
- `failure_stories` - Fracassos que ensinaram
- `breakthrough_moments` - Insights ou realizações
- `lessons_learned` - Takeaways explícitos

-----

### M1.Q4 - Influências Pessoais

**ID:** M1.Q4  
**Código:** `1.4_influencias`  
**Tipo:** Relational  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Quem são as pessoas que mais influenciaram **{person_name}**? Por quê?

#### Keywords

`influence`, `mentor`, `inspiration`, `role model`, `teacher`, `guide`, `hero`

#### Related Concepts

- Intellectual lineage
- Professional influences
- Personal relationships
- Mentorship
- Inspirational figures

#### Elementos Requeridos

- [ ] **Lista de influências** - Nomes e contexto
- [ ] **Tipo de influência** - Intelectual, pessoal, profissional, espiritual
- [ ] **Aprendizados específicos** - O que cada um ensinou
- [ ] **Manifestação atual** - Como aparecem no trabalho/vida hoje
- [ ] **Influências rejeitadas** - Quem superou ou discordou

#### Follow-ups

1. “O que especificamente {person_name} aprendeu com cada influência?”
1. “Existem influências que {person_name} rejeitou ou superou?”
1. “Como essas influências aparecem no trabalho de {person_name} hoje?”

#### Tipos de Fragmentos Esperados

- `influence_descriptions` - Quem e como influenciou
- `relationship_impacts` - Efeito de relações importantes
- `intellectual_lineage` - Linhagem de pensamento

-----

## MÓDULO 2: Sistemas de Pensamento

**Duração:** 20-25 minutos  
**Prioridade:** 🔴 CRITICAL  
**Objetivo:** Entender frameworks mentais, processos cognitivos e filosofia fundamental

-----

### M2.Q1 - Filosofia Fundamental

**ID:** M2.Q1  
**Código:** `2.1_filosofia_core`  
**Tipo:** Philosophical  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Qual é a filosofia fundamental que guia **{person_name}**? O sistema de crenças no núcleo de tudo?

#### Keywords

`philosophy`, `worldview`, `beliefs`, `principles`, `core`, `fundamental`, `axioms`, `foundation`

#### Related Concepts

- Epistemology (como conhece)
- Ontology (o que é real)
- Ethics (o que é certo)
- Metaphysics (natureza da realidade)
- First principles

#### Elementos Requeridos

- [ ] **Descrição da filosofia** - O framework central
- [ ] **Origens** - De onde veio essa filosofia
- [ ] **Evolução** - Como mudou ao longo do tempo
- [ ] **Aplicações práticas** - Como se manifesta
- [ ] **Consequências e trade-offs** - O que requer ou exige

#### Follow-ups

1. “De onde veio essa filosofia? Foi construída ou descoberta?”
1. “Essa filosofia já mudou radicalmente? Quando e por quê?”
1. “Como {person_name} aplicaria essa filosofia a um problema totalmente novo?”
1. “Que trade-offs ou sacrifícios essa filosofia exige?”

#### Tipos de Fragmentos Esperados

- `philosophical_statements` - Declarações de crenças fundamentais
- `belief_system` - Sistema de crenças articulado
- `principle_articulations` - Princípios expressos
- `worldview_descriptions` - Como vê a realidade

-----

### M2.Q2 - Processo de Pensamento

**ID:** M2.Q2  
**Código:** `2.2_processo_pensamento`  
**Tipo:** Cognitive  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Como **{person_name}** pensa sobre problemas complexos? Descreva o processo mental passo a passo.

#### Keywords

`thinking`, `analysis`, `problem-solving`, `mental process`, `cognition`, `reasoning`, `logic`

#### Related Concepts

- Reasoning patterns
- Logic systems
- Intuition role
- Mental frameworks
- Cognitive strategies

#### Elementos Requeridos

- [ ] **Processo passo a passo** - Sequência do pensamento
- [ ] **Primeiro movimento** - O que faz primeiro ao analisar
- [ ] **Frameworks utilizados** - Modelos mentais recorrentes
- [ ] **Critérios de priorização** - Como decide o que importa
- [ ] **Mecanismos de validação** - Como sabe se está certo

#### Follow-ups

1. “Quando enfrenta um problema novo, qual é o primeiro movimento mental?”
1. “Como {person_name} distingue entre problemas importantes e triviais?”
1. “Que frameworks mentais {person_name} usa repetidamente?”
1. “Como {person_name} sabe quando está certo versus errado?”

#### Tipos de Fragmentos Esperados

- `thinking_process` - Descrições do processo cognitivo
- `problem_solving_examples` - Exemplos de análise
- `mental_frameworks` - Modelos mentais usados
- `validation_methods` - Como verifica conclusões

-----

### M2.Q3 - Tomada de Decisão

**ID:** M2.Q3  
**Código:** `2.3_tomada_decisao`  
**Tipo:** Behavioral  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Como **{person_name}** toma decisões importantes? Qual o processo?

#### Keywords

`decision`, `choice`, `process`, `criteria`, `judgment`, `trade-off`, `priority`

#### Related Concepts

- Decision-making frameworks
- Trade-off analysis
- Risk assessment
- Uncertainty management
- Intuition vs analysis

#### Elementos Requeridos

- [ ] **Processo de decisão** - Como chega à decisão
- [ ] **Fatores priorizados** - O que pesa mais
- [ ] **Gestão de incerteza** - Como lida com informação incompleta
- [ ] **Papel intuição vs análise** - Equilíbrio entre os dois
- [ ] **Exemplos de decisões** - Casos concretos

#### Follow-ups

1. “Que fatores {person_name} prioriza em decisões difíceis?”
1. “Como {person_name} lida com incerteza e informação incompleta?”
1. “Existe um padrão nas decisões que {person_name} se arrepende?”
1. “Como intuição versus análise entram nas decisões?”

#### Tipos de Fragmentos Esperados

- `decision_processes` - Como decide
- `decision_criteria` - O que prioriza
- `decision_examples` - Decisões específicas
- `regret_analysis` - Decisões ruins e por quê

-----

### M2.Q4 - Resolução de Problemas Impossíveis

**ID:** M2.Q4  
**Código:** `2.4_resolucao_problemas`  
**Tipo:** Behavioral  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Quando **{person_name}** enfrenta um problema impossível, como aborda?

#### Keywords

`impossible`, `difficult`, `challenge`, `approach`, `solution`, `breakthrough`, `stuck`

#### Related Concepts

- Problem-solving strategies
- Creative thinking
- Persistence vs pivot
- Reframing techniques
- Innovation methods

#### Elementos Requeridos

- [ ] **Abordagem geral** - Estratégia para problemas difíceis
- [ ] **Técnicas específicas** - Métodos únicos usados
- [ ] **Exemplo concreto** - Problema impossível que resolveu
- [ ] **Estratégias de reframing** - Como reformula o problema
- [ ] **Respostas a bloqueios** - O que faz quando travado

#### Follow-ups

1. “Dê um exemplo específico de um problema ‘impossível’ que resolveu.”
1. “Que técnicas ou métodos {person_name} usa que outros não usam?”
1. “Como {person_name} reformula problemas para torná-los solucionáveis?”
1. “O que {person_name} faz quando completamente travado?”

#### Tipos de Fragmentos Esperados

- `problem_solving_stories` - Casos de problemas resolvidos
- `techniques_used` - Técnicas específicas
- `reframing_examples` - Como reformula problemas
- `breakthrough_moments` - Como chegou à solução

-----

### M2.Q5 - Aprendizado e Evolução

**ID:** M2.Q5  
**Código:** `2.5_aprendizado_evolucao`  
**Tipo:** Meta-cognitive  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Como **{person_name}** aprende e evolui suas ideias ao longo do tempo?

#### Keywords

`learning`, `evolution`, `change`, `growth`, `adaptation`, `mind-changing`, `update`

#### Related Concepts

- Intellectual growth
- Mind-changing process
- Feedback integration
- Iterative thinking
- Bayesian updating

#### Elementos Requeridos

- [ ] **Processo de aprendizado** - Como adquire novos conhecimentos
- [ ] **Exemplos de mudança** - Ideias que mudou completamente
- [ ] **Gestão de feedback** - Como integra críticas
- [ ] **Critérios para descartar** - Quando abandona ideias antigas
- [ ] **Velocidade de atualização** - Quão rápido muda de opinião

#### Follow-ups

1. “Que ideias {person_name} mudou completamente nos últimos 10 anos?”
1. “Como {person_name} decide quando uma ideia antiga precisa ser descartada?”
1. “Qual foi a última vez que {person_name} disse ‘eu estava completamente errado sobre isso’?”
1. “Como {person_name} integra feedback ou críticas?”

#### Tipos de Fragmentos Esperados

- `learning_methods` - Como aprende
- `mind_changing_examples` - Mudanças de opinião
- `feedback_integration` - Como usa críticas
- `intellectual_evolution` - Trajetória de pensamento

-----

## MÓDULO 3: Domínio e Expertise

**Duração:** 20-25 minutos  
**Prioridade:** 🔴 CRITICAL  
**Objetivo:** Mapear conhecimento especializado, contribuições e metodologias características

-----

### M3.Q1 - Área de Expertise

**ID:** M3.Q1  
**Código:** `3.1_area_expertise`  
**Tipo:** Factual  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Qual é exatamente a área de expertise de **{person_name}**? Defina com precisão.

#### Keywords

`expertise`, `specialization`, `knowledge`, `domain`, `field`, `mastery`, `competence`

#### Related Concepts

- Professional identity
- Core competence
- Unique knowledge
- Field boundaries
- Depth vs breadth

#### Elementos Requeridos

- [ ] **Definição precisa** - Limites da expertise
- [ ] **Conhecimento único** - O que sabe que outros não sabem
- [ ] **Caminho de desenvolvimento** - Como chegou a essa expertise
- [ ] **Aspectos controversos** - Partes contra-intuitivas
- [ ] **Barreiras de entrada** - O que é necessário para alcançar

#### Follow-ups

1. “O que {person_name} sabe que 99% das pessoas no campo não sabem?”
1. “Como {person_name} desenvolveu esse conhecimento único?”
1. “Que partes dessa expertise são contraintuitivas ou controversas?”
1. “Se alguém quisesse alcançar essa expertise, qual seria o caminho?”

#### Tipos de Fragmentos Esperados

- `expertise_descriptions` - Definições do campo
- `unique_knowledge` - Conhecimento distintivo
- `field_definition` - Escopo da área
- `skill_development` - Como desenvolveu expertise

-----

### M3.Q2 - Principais Trabalhos

**ID:** M3.Q2  
**Código:** `3.2_principais_trabalhos`  
**Tipo:** Factual  
**Profundidade Esperada:** Medium  
**Tempo:** 4 minutos

#### Pergunta Principal

> Quais são os trabalhos ou contribuições mais importantes de **{person_name}**?

#### Keywords

`work`, `contribution`, `achievement`, `creation`, `project`, `output`, `legacy`

#### Related Concepts

- Body of work
- Impact assessment
- Innovation contribution
- Creative output
- Professional legacy

#### Elementos Requeridos

- [ ] **Lista de trabalhos** - Principais criações/contribuições
- [ ] **Objetivo de cada** - O que cada trabalho tentava fazer
- [ ] **Conexões** - Como se relacionam entre si
- [ ] **Trabalhos falhos** - O que não funcionou
- [ ] **Retrospectiva** - Como vê os trabalhos hoje

#### Follow-ups

1. “O que cada trabalho tentava resolver ou alcançar?”
1. “Como cada trabalho se conecta aos outros? Qual o fio condutor?”
1. “Que trabalhos falharam ou foram abandonados? Por quê?”
1. “Se {person_name} pudesse refazer um trabalho, qual seria e como?”

#### Tipos de Fragmentos Esperados

- `work_descriptions` - Descrições de projetos
- `contribution_analysis` - Impacto avaliado
- `project_retrospectives` - Reflexões sobre trabalhos
- `failure_analysis` - Análise de falhas

-----

### M3.Q3 - Metodologia Característica

**ID:** M3.Q3  
**Código:** `3.3_metodologia`  
**Tipo:** Analytical  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Qual é a metodologia ou abordagem característica de **{person_name}**?

#### Keywords

`methodology`, `approach`, `method`, `process`, `technique`, `style`, `way`

#### Related Concepts

- Working style
- Problem-solving approach
- Signature methods
- Process optimization
- Systematic thinking

#### Elementos Requeridos

- [ ] **Descrição da metodologia** - Como trabalha
- [ ] **Diferenças do convencional** - O que faz diferente
- [ ] **Casos de uso** - Quando funciona melhor
- [ ] **Limitações** - Quando não funciona
- [ ] **Exemplo de aplicação** - Caso concreto

#### Follow-ups

1. “Como essa metodologia é diferente das abordagens convencionais?”
1. “Quando essa metodologia funciona melhor? E quando falha?”
1. “Pode dar um exemplo de aplicar essa metodologia a um problema específico?”
1. “Como {person_name} desenvolveu essa metodologia?”

#### Tipos de Fragmentos Esperados

- `methodology_descriptions` - Como trabalha
- `approach_examples` - Aplicações práticas
- `technique_explanations` - Técnicas específicas
- `comparative_analysis` - Vs outras abordagens

-----

### M3.Q4 - Controvérsias e Discordâncias

**ID:** M3.Q4  
**Código:** `3.4_controversias`  
**Tipo:** Analytical  
**Profundidade Esperada:** Deep  
**Tempo:** 4 minutos

#### Pergunta Principal

> Em que **{person_name}** discorda fortemente do consenso do campo?

#### Keywords

`disagreement`, `controversy`, `contrarian`, `consensus`, `debate`, `dissent`

#### Related Concepts

- Intellectual independence
- Controversial positions
- Field debates
- Paradigm challenges
- Heterodox views

#### Elementos Requeridos

- [ ] **Posições contrárias** - Onde discorda do consenso
- [ ] **Raciocínio** - Por que discorda
- [ ] **Evidências** - O que sustenta a posição
- [ ] **Gestão de resistência** - Como lida com oposição
- [ ] **Evolução de posições** - Mudanças ao longo do tempo

#### Follow-ups

1. “Por que {person_name} acredita que a maioria está errada?”
1. “Que evidências ou raciocínio sustentam essa posição contrária?”
1. “Como {person_name} lida com resistência a essas ideias?”
1. “Já mudou de opinião em alguma dessas controvérsias?”

#### Tipos de Fragmentos Esperados

- `controversial_positions` - Posições polêmicas
- `contrarian_arguments` - Argumentos contra consenso
- `debate_participation` - Participação em debates
- `position_evolution` - Mudanças de posição

-----

### M3.Q5 - Fronteiras do Conhecimento

**ID:** M3.Q5  
**Código:** `3.5_fronteiras_conhecimento`  
**Tipo:** Meta-cognitive  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Onde estão as fronteiras do conhecimento de **{person_name}**? O que ainda não sabe?

#### Keywords

`limits`, `boundaries`, `unknown`, `uncertainty`, `gaps`, `frontier`, `humility`

#### Related Concepts

- Intellectual humility
- Knowledge boundaries
- Unknown unknowns
- Epistemic limits
- Areas of ignorance

#### Elementos Requeridos

- [ ] **Limites conhecidos** - Onde a expertise termina
- [ ] **Perguntas em aberto** - O que ainda quer entender
- [ ] **Áreas evitadas** - O que deliberadamente não faz
- [ ] **Incertezas** - O que reconhece não saber
- [ ] **Humildade intelectual** - Como expressa limites

#### Follow-ups

1. “Que perguntas {person_name} considera mais importantes e ainda não resolvidas?”
1. “O que {person_name} gostaria de entender mas ainda não entende?”
1. “Que áreas {person_name} deliberadamente evita ou considera fora de sua expertise?”

#### Tipos de Fragmentos Esperados

- `knowledge_boundaries` - Limites expressos
- `open_questions` - Perguntas sem resposta
- `intellectual_humility` - Reconhecimento de limites
- `uncertainty_acknowledgment` - Admissões de não-saber

-----

## MÓDULO 4: Comunicação e Expressão

**Duração:** 15-20 minutos  
**Prioridade:** 🟡 HIGH  
**Objetivo:** Capturar estilo comunicacional, linguagem característica e pedagogia

-----

### M4.Q1 - Estilo de Comunicação

**ID:** M4.Q1  
**Código:** `4.1_estilo_comunicacao`  
**Tipo:** Stylistic  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Como **{person_name}** comunica ideias complexas? Qual seu estilo característico?

#### Keywords

`communication`, `style`, `expression`, `explanation`, `articulation`, `rhetoric`

#### Related Concepts

- Rhetorical style
- Pedagogy
- Clarity vs complexity
- Persuasion techniques
- Audience adaptation

#### Elementos Requeridos

- [ ] **Estilo geral** - Características marcantes
- [ ] **Metáforas recorrentes** - Analogias que usa sempre
- [ ] **Adaptação de audiência** - Como muda para diferentes públicos
- [ ] **Marcas reconhecíveis** - O que as pessoas identificam
- [ ] **Técnicas de simplificação** - Como torna complexo simples

#### Follow-ups

1. “Que metáforas, analogias ou frameworks {person_name} usa repetidamente?”
1. “Como o estilo muda dependendo da audiência?”
1. “Que aspectos da comunicação de {person_name} as pessoas mais reconhecem?”
1. “Como {person_name} simplifica sem perder nuance?”

#### Tipos de Fragmentos Esperados

- `communication_examples` - Exemplos de explicações
- `metaphors_used` - Metáforas específicas
- `style_descriptions` - Análises do estilo
- `audience_adaptation` - Mudanças por contexto

-----

### M4.Q2 - Linguagem e Vocabulário

**ID:** M4.Q2  
**Código:** `4.2_linguagem_vocabulario`  
**Tipo:** Linguistic  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Que palavras, frases ou conceitos **{person_name}** usa constantemente?

#### Keywords

`vocabulary`, `language`, `words`, `phrases`, `terminology`, `jargon`, `lexicon`

#### Related Concepts

- Linguistic signature
- Catchphrases
- Verbal tics
- Neologisms
- Lexical patterns

#### Elementos Requeridos

- [ ] **Palavras frequentes** - Vocabulário característico
- [ ] **Frases assinatura** - Expressões marcantes
- [ ] **Termos criados** - Neologismos ou redefinições
- [ ] **Linguagem evitada** - Palavras que não usa
- [ ] **Evolução vocabular** - Mudanças ao longo do tempo

#### Follow-ups

1. “Existem termos que {person_name} criou ou redefiniu?”
1. “Que linguagem {person_name} evita ou rejeita usar?”
1. “Como o vocabulário de {person_name} evoluiu ao longo do tempo?”
1. “Cite 10 palavras ou frases que são ‘assinaturas’ de {person_name}.”

#### Tipos de Fragmentos Esperados

- `signature_phrases` - Frases icônicas
- `vocabulary_analysis` - Análise lexical
- `neologisms` - Termos inventados
- `language_patterns` - Padrões linguísticos

-----

### M4.Q3 - Modo de Ensino

**ID:** M4.Q3  
**Código:** `4.3_modo_ensino`  
**Tipo:** Pedagogical  
**Profundidade Esperada:** Medium  
**Tempo:** 4 minutos

#### Pergunta Principal

> Se **{person_name}** estivesse ensinando alguém, como seria? Qual a pedagogia?

#### Keywords

`teaching`, `pedagogy`, `education`, `instruction`, `learning`, `mentorship`

#### Related Concepts

- Teaching philosophy
- Knowledge transfer
- Mentorship style
- Learning facilitation
- Educational approach

#### Elementos Requeridos

- [ ] **Estilo pedagógico** - Como ensina
- [ ] **Técnicas de diagnóstico** - Como identifica problemas de entendimento
- [ ] **Tipos de exemplos** - Que exemplos usa
- [ ] **Gestão de dificuldades** - Como ajuda quem não entende
- [ ] **Diferenciação** - Diferença entre ensinar iniciantes vs avançados

#### Follow-ups

1. “Como {person_name} diagnostica o que o aluno não está entendendo?”
1. “Que tipos de exemplos ou exercícios {person_name} usaria?”
1. “Como {person_name} lida com um aluno que não está progredindo?”
1. “Qual a diferença entre como {person_name} ensina iniciantes versus avançados?”

#### Tipos de Fragmentos Esperados

- `teaching_examples` - Casos de ensino
- `pedagogical_approach` - Filosofia educacional
- `mentorship_stories` - Histórias de mentoria
- `educational_philosophy` - Crenças sobre aprendizado

-----

### M4.Q4 - Argumentação

**ID:** M4.Q4  
**Código:** `4.4_argumentacao`  
**Tipo:** Rhetorical  
**Profundidade Esperada:** Deep  
**Tempo:** 4 minutos

#### Pergunta Principal

> Como **{person_name}** constrói e defende argumentos?

#### Keywords

`argument`, `reasoning`, `rhetoric`, `persuasion`, `debate`, `logic`

#### Related Concepts

- Logical structure
- Evidence usage
- Counterargument handling
- Persuasive techniques
- Dialectic method

#### Elementos Requeridos

- [ ] **Estrutura de argumento** - Como organiza argumentos
- [ ] **Gestão de objeções** - Como responde a contrapontos
- [ ] **Tipos de evidência** - O que considera convincente
- [ ] **Concessões vs defesa** - Quando cede vs quando mantém posição
- [ ] **Estilo de debate** - Como debate/discute

#### Follow-ups

1. “Qual a estrutura típica de um argumento de {person_name}?”
1. “Como {person_name} lida com objeções ou contrapontos?”
1. “Que tipo de evidência {person_name} considera mais convincente?”
1. “Quando {person_name} concederia um ponto versus defenderia até o fim?”

#### Tipos de Fragmentos Esperados

- `argument_structures` - Estruturas argumentativas
- `debate_examples` - Exemplos de debates
- `evidence_usage` - Como usa evidências
- `counterargument_handling` - Como lida com oposição

-----

### M4.Q5 - Humor e Personalidade

**ID:** M4.Q5  
**Código:** `4.5_humor_personalidade`  
**Tipo:** Stylistic  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Como o humor e a personalidade de **{person_name}** aparecem na comunicação?

#### Keywords

`humor`, `personality`, `tone`, `emotion`, `character`, `wit`, `warmth`

#### Related Concepts

- Emotional expression
- Wit and sarcasm
- Personal warmth
- Tonal variation
- Character expression

#### Elementos Requeridos

- [ ] **Tipo de humor** - Estilo de humor (se usa)
- [ ] **Uso de histórias** - Como usa anedotas pessoais
- [ ] **Tom emocional** - Tom característico (otimista/cético/etc)
- [ ] **Equilíbrio sério/leve** - Como balanceia
- [ ] **Expressão de personalidade** - Como personalidade aparece

#### Follow-ups

1. “Que tipo de humor {person_name} usa? Quando?”
1. “Como {person_name} usa histórias pessoais ou exemplos?”
1. “Existe um tom emocional característico? (Otimista? Cético? Provocativo?)”
1. “Como {person_name} equilibra seriedade e leveza?”

#### Tipos de Fragmentos Esperados

- `humor_examples` - Exemplos de humor
- `personal_stories` - Anedotas usadas
- `tone_analysis` - Análise de tom
- `emotional_expression` - Como expressa emoção

-----

## MÓDULO 5: Valores e Princípios

**Duração:** 15-20 minutos  
**Prioridade:** 🔴 CRITICAL  
**Objetivo:** Identificar valores fundamentais, framework ético e senso de propósito

-----

### M5.Q1 - Valores Fundamentais

**ID:** M5.Q1  
**Código:** `5.1_valores_fundamentais`  
**Tipo:** Values  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Quais são os 3-5 valores absolutamente inegociáveis para **{person_name}**?

#### Keywords

`values`, `principles`, `ethics`, `non-negotiable`, `core`, `sacred`, `integrity`

#### Related Concepts

- Moral framework
- Integrity
- Core commitments
- Value hierarchy
- Ethical boundaries

#### Elementos Requeridos

- [ ] **Lista de valores** - 3-5 valores identificados claramente
- [ ] **Origem** - De onde vem cada valor
- [ ] **Exemplos de teste** - Situações onde foram testados
- [ ] **Resolução de conflitos** - Como resolve quando valores colidem
- [ ] **Evolução** - Como valores mudaram ao longo da vida

#### Follow-ups

1. “De onde vêm esses valores? Como foram formados?”
1. “Houve situações onde esses valores foram testados? O que aconteceu?”
1. “Como {person_name} age quando valores entram em conflito?”
1. “Esses valores mudaram ao longo da vida? Como?”

#### Tipos de Fragmentos Esperados

- `value_statements` - Declarações de valores
- `value_origin_stories` - Como valores foram formados
- `value_testing_examples` - Momentos de teste
- `value_evolution` - Mudanças ao longo do tempo

-----

### M5.Q2 - Framework Ético

**ID:** M5.Q2  
**Código:** `5.2_etica_moral`  
**Tipo:** Philosophical  
**Profundidade Esperada:** Deep  
**Tempo:** 5 minutos

#### Pergunta Principal

> Qual é o framework ético ou moral que guia **{person_name}**?

#### Keywords

`ethics`, `morality`, `right`, `wrong`, `framework`, `moral philosophy`, `principles`

#### Related Concepts

- Moral philosophy
- Ethical principles
- Moral reasoning
- Consequentialism vs deontology
- Virtue ethics

#### Elementos Requeridos

- [ ] **Framework ético** - Sistema moral usado
- [ ] **Processo de decisão moral** - Como decide certo vs errado
- [ ] **Absolutismo vs relativismo** - Onde é absoluto/relativo
- [ ] **Gestão de dilemas** - Como resolve dilemas éticos
- [ ] **Críticas morais** - O que critica na sociedade

#### Follow-ups

1. “Como {person_name} decide o que é certo versus errado?”
1. “Existem áreas onde {person_name} é mais relativista? Mais absolutista?”
1. “Como {person_name} lida com dilemas éticos sem resposta clara?”
1. “Que princípios morais {person_name} vê sendo violados na sociedade?”

#### Tipos de Fragmentos Esperados

- `ethical_framework` - Sistema ético
- `moral_reasoning` - Raciocínio moral
- `ethical_dilemmas` - Dilemas enfrentados
- `moral_criticism` - Críticas morais feitas

-----

### M5.Q3 - Propósito e Missão

**ID:** M5.Q3  
**Código:** `5.3_proposito_missao`  
**Tipo:** Motivational  
**Profundidade Esperada:** Deep  
**Tempo:** 4 minutos

#### Pergunta Principal

> Qual é o propósito ou missão que move **{person_name}**?

#### Keywords

`purpose`, `mission`, `calling`, `drive`, `motivation`, `ikigai`, `telos`, `meaning`

#### Related Concepts

- Life purpose
- Ikigai (reason for being)
- Telos (ultimate aim)
- Vocation
- Meaningful work

#### Elementos Requeridos

- [ ] **Descrição do propósito** - O que move a pessoa
- [ ] **Momento de descoberta** - Quando percebeu
- [ ] **Manifestações práticas** - Como aparece no dia-a-dia
- [ ] **Sacrifícios feitos** - O que sacrificou pelo propósito
- [ ] **Métricas de progresso** - Como mede sucesso

#### Follow-ups

1. “Quando {person_name} percebeu esse propósito?”
1. “Como esse propósito se manifesta no trabalho diário?”
1. “O que {person_name} sacrificou ou sacrificaria por esse propósito?”
1. “Como {person_name} mede progresso em direção a esse propósito?”

#### Tipos de Fragmentos Esperados

- `purpose_statements` - Declarações de propósito
- `mission_descriptions` - Descrições de missão
- `sacrifice_stories` - Sacrifícios feitos
- `progress_metrics` - Como mede sucesso

-----

### M5.Q4 - Legado Desejado

**ID:** M5.Q4  
**Código:** `5.4_legado`  
**Tipo:** Aspirational  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> O que **{person_name}** quer deixar como legado?

#### Keywords

`legacy`, `impact`, `remember`, `contribution`, `lasting`, `imprint`, `mark`

#### Related Concepts

- Long-term impact
- Remembrance
- Contribution to humanity
- Generational influence
- Immortality through ideas

#### Elementos Requeridos

- [ ] **Visão de legado** - Como quer ser lembrado
- [ ] **Impacto desejado** - Mudanças que quer causar
- [ ] **Problemas a resolver** - Que problemas espera ajudar a resolver
- [ ] **Reconhecimento vs impacto** - Como pensa sobre fama vs efeito real
- [ ] **Trabalhos subestimados** - O que construiu que não recebe atenção

#### Follow-ups

1. “Daqui a 100 anos, o que {person_name} quer que seja lembrado?”
1. “Que problemas {person_name} espera ter ajudado a resolver?”
1. “Como {person_name} pensa sobre impacto versus reconhecimento?”
1. “Existe algo que {person_name} construiu que considera subestimado?”

#### Tipos de Fragmentos Esperados

- `legacy_statements` - Visões de legado
- `impact_aspirations` - Impactos desejados
- `long_term_vision` - Visão de longo prazo

-----

## MÓDULO 6: Contexto e Perspectiva

**Duração:** 10-15 minutos  
**Prioridade:** 🟢 MEDIUM  
**Objetivo:** Entender worldview, posicionamento social e visão de futuro

-----

### M6.Q1 - Worldview

**ID:** M6.Q1  
**Código:** `6.1_visao_mundo`  
**Tipo:** Philosophical  
**Profundidade Esperada:** Deep  
**Tempo:** 4 minutos

#### Pergunta Principal

> Como **{person_name}** vê o mundo? Qual a worldview fundamental?

#### Keywords

`worldview`, `reality`, `nature`, `universe`, `existence`, `cosmology`, `ontology`

#### Related Concepts

- Metaphysics
- Ontology
- Cosmology
- Nature of reality
- Order vs chaos

#### Elementos Requeridos

- [ ] **Worldview geral** - Como vê a realidade
- [ ] **Ordem vs caos** - Mundo é ordenado ou caótico?
- [ ] **Natureza humana** - Humanos são bons ou precisam restrições?
- [ ] **Visão de progresso** - Progresso é inevitável/possível/ilusório?
- [ ] **Indivíduo vs coletivo** - Onde está o primado?

#### Follow-ups

1. “O mundo é fundamentalmente ordenado ou caótico para {person_name}?”
1. “Humanos são basicamente bons ou precisam de restrições?”
1. “Progresso é inevitável, possível, ou ilusório?”
1. “Como {person_name} vê o papel do indivíduo versus coletivo?”

#### Tipos de Fragmentos Esperados

- `worldview_statements` - Declarações sobre realidade
- `philosophical_positions` - Posições filosóficas
- `ontological_views` - Visões sobre natureza do ser

-----

### M6.Q2 - Sociedade e Cultura

**ID:** M6.Q2  
**Código:** `6.2_sociedade_cultura`  
**Tipo:** Social  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Como **{person_name}** vê a sociedade e cultura contemporânea?

#### Keywords

`society`, `culture`, `contemporary`, `social`, `civilization`, `zeitgeist`

#### Related Concepts

- Social criticism
- Cultural analysis
- Current affairs
- Societal diagnosis
- Cultural commentary

#### Elementos Requeridos

- [ ] **Visão da sociedade** - Como vê sociedade atual
- [ ] **Problemas urgentes** - Que problemas sociais prioriza
- [ ] **Cultura ideal** - Como seria uma cultura melhor
- [ ] **Tendências avaliadas** - Que tendências celebra/lamenta
- [ ] **Posicionamento** - Relação com status quo

#### Follow-ups

1. “Que problemas sociais {person_name} considera mais urgentes?”
1. “Como a cultura atual difere da ideal para {person_name}?”
1. “Que tendências culturais {person_name} celebra versus lamenta?”
1. “Como {person_name} se posiciona em relação ao status quo?”

#### Tipos de Fragmentos Esperados

- `social_commentary` - Comentários sociais
- `cultural_criticism` - Críticas culturais
- `societal_analysis` - Análises da sociedade

-----

### M6.Q3 - Visão de Futuro

**ID:** M6.Q3  
**Código:** `6.3_futuro`  
**Tipo:** Predictive  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Como **{person_name}** pensa sobre o futuro?

#### Keywords

`future`, `prediction`, `forecast`, `tomorrow`, `trend`, `optimism`, `pessimism`

#### Related Concepts

- Futurism
- Optimism/pessimism
- Forecasting
- Trend analysis
- Scenario planning

#### Elementos Requeridos

- [ ] **Orientação geral** - Otimista ou pessimista?
- [ ] **Previsões específicas** - Que desenvolvimentos vê como inevitáveis
- [ ] **Futuros desejados/evitados** - Que futuros tenta criar ou evitar
- [ ] **Gestão de incerteza** - Como lida com incerteza sobre futuro
- [ ] **Horizontes temporais** - Pensa em que escala de tempo

#### Follow-ups

1. “Otimista ou pessimista? Em quais aspectos?”
1. “Que desenvolvimentos futuros {person_name} considera inevitáveis?”
1. “Que futuros possíveis {person_name} está tentando criar ou evitar?”
1. “Como {person_name} lida com incerteza sobre o futuro?”

#### Tipos de Fragmentos Esperados

- `future_predictions` - Previsões
- `optimism_pessimism` - Orientação geral
- `trend_analysis` - Análises de tendências

-----

### M6.Q4 - Papel no Mundo

**ID:** M6.Q4  
**Código:** `6.4_papel_pessoal`  
**Tipo:** Reflective  
**Profundidade Esperada:** Medium  
**Tempo:** 3 minutos

#### Pergunta Principal

> Como **{person_name}** vê seu próprio papel no mundo?

#### Keywords

`role`, `responsibility`, `position`, `contribution`, `place`, `agency`

#### Related Concepts

- Self-perception
- Agency
- Responsibility
- Stewardship
- Influence sphere

#### Elementos Requeridos

- [ ] **Autopercepção de papel** - Como se vê no mundo
- [ ] **Responsabilidades** - Que responsabilidades sente
- [ ] **Ambição vs contribuição** - Como equilibra
- [ ] **Limitações reconhecidas** - Que limites reconhece
- [ ] **Definição de sucesso** - Como define sucesso pessoal

#### Follow-ups

1. “Que responsabilidades {person_name} sente que tem?”
1. “Como {person_name} equilibra ambição pessoal e contribuição social?”
1. “Que limitações {person_name} reconhece em si mesmo?”
1. “Como {person_name} define sucesso para si mesmo?”

#### Tipos de Fragmentos Esperados

- `self_perception` - Autopercepção
- `responsibility_statements` - Senso de responsabilidade
- `success_definitions` - Definições de sucesso

-----

## MÓDULO 7: Testes de Consistência

**Duração:** 10-15 minutos  
**Prioridade:** 🟡 HIGH  
**Objetivo:** Validar consistência interna, profundidade real e autenticidade

**NOTA IMPORTANTE:** Este módulo é executado pelo **DETECTIVE** durante interrogação do clone. O **RESEARCHER** não prepara respostas para estas perguntas.

-----

### M7.Q1 - Cenários Hipotéticos

**ID:** M7.Q1  
**Código:** `7.1_cenarios_hipotetivos`  
**Tipo:** Situational Test  
**Execução:** Detective Only  
**Tempo:** 4 minutos

#### Pergunta Principal

> Vou apresentar cenários hipotéticos. Como **{person_name}** responderia?

#### Cenários de Teste

1. **Conselho de carreira**
   “Um jovem talentoso pede conselho de carreira. O que {person_name} diria?”
1. **Gestão de crítica**
   “Alguém critica duramente o trabalho de {person_name}. Como reage?”
1. **Conflito de valores**
   “Uma oportunidade lucrativa conflita com valores. O que fazer?”
1. **Erro fundamental**
   “Descobriu estar errado sobre algo fundamental. Como procede?”
1. **Risco vs recompensa**
   “Tem chance de resolver um grande problema mas com alto risco. Tenta?”

#### Critérios de Avaliação

- Consistência com valores expressos anteriormente
- Profundidade vs superficialidade da resposta
- Especificidade vs generalização vaga
- Autenticidade vs resposta “correta” genérica

-----

### M7.Q2 - Dilemas Éticos

**ID:** M7.Q2  
**Código:** `7.2_dilemas`  
**Tipo:** Dilemmatic Test  
**Execução:** Detective Only  
**Tempo:** 3 minutos

#### Pergunta Principal

> Como **{person_name}** resolveria estes dilemas?

#### Dilemas de Teste

1. **Verdade vs gentileza:** “Quando cada um prevalece?”
1. **Curto vs longo prazo:** “Como decidir entre os dois?”
1. **Individual vs coletivo:** “Onde traçar a linha?”
1. **Tradição vs inovação:** “Como equilibrar?”
1. **Simplicidade vs complexidade:** “Quando usar cada uma?”

#### Critérios de Avaliação

- Consistência com framework ético expresso
- Nuance na resolução (não simplesmente “sempre X”)
- Exemplos concretos dados
- Reconhecimento de trade-offs

-----

### M7.Q3 - Cross-Check de Consistência

**ID:** M7.Q3  
**Código:** `7.3_crosscheck`  
**Tipo:** Consistency Validation  
**Execução:** Detective Only  
**Tempo:** 3 minutos

#### Pergunta Principal

> Vou fazer perguntas sobre coisas que você já disse. Suas respostas vão permanecer consistentes?

#### Padrões de Validação

1. **Contradição direta**
   “Antes você disse X, mas isso não contradiz Y que disse depois?”
1. **Relação entre conceitos**
   “Como essa posição se relaciona com aquilo que disse sobre Z?”
1. **Reexpressão**
   “Você pode dar mais um exemplo dessa mesma ideia mas em contexto diferente?”
1. **Reformulação**
   “Se eu perguntasse de outra forma: [reformulação], a resposta seria a mesma?”

#### Critérios de Avaliação

- Respostas permanecem consistentes sob reformulação
- Não contradiz afirmações anteriores
- Consegue dar múltiplos exemplos do mesmo princípio
- Explica aparentes contradições adequadamente

-----

### M7.Q4 - Probes de Profundidade

**ID:** M7.Q4  
**Código:** `7.4_depth_probes`  
**Tipo:** Depth Test  
**Execução:** Detective Only  
**Tempo:** 4 minutos

#### Pergunta Principal

> Vou aprofundar em áreas específicas para testar compreensão real versus superficial.

#### Tipos de Probes

1. **Explicação infantil**
   “Explique isso para uma criança de 10 anos.”
1. **Explicação expert**
   “Explique isso para um PhD no campo.”
1. **Compressão variável**
   “Qual é a versão de 30 segundos? E a de 30 minutos?”
1. **Misconceptions**
   “Quais são os 3 maiores equívocos sobre essa ideia?”
1. **Steel-man contrário**
   “Se você tivesse que provar que está errado, como faria?”

#### Critérios de Avaliação

- Consegue explicar em múltiplos níveis
- Demonstra profundidade real vs conhecimento superficial
- Identifica nuances e edge cases
- Reconhece limitações e incertezas

-----

## MÓDULO 8: Validação Contra Fontes

**Duração:** 5-10 minutos  
**Prioridade:** 🟡 HIGH  
**Objetivo:** Validar respostas contra material fonte conhecido

**NOTA:** Módulo híbrido - Researcher prepara material, Detective executa validação

-----

### M8.Q1 - Citações Conhecidas

**ID:** M8.Q1  
**Código:** `8.1_citacoes_conhecidas`  
**Tipo:** Source Validation  
**Tempo:** 3 minutos

#### Pergunta Principal

> Vou citar coisas que **{person_name}** disse. Explique o contexto e significado completo.

#### Preparação do Researcher

- [ ] Extrair 10-20 citações famosas/importantes
- [ ] Documentar contexto completo de cada citação
- [ ] Preparar variações e paráfrases para testar reconhecimento
- [ ] Incluir citações erroneamente atribuídas (teste negativo)

#### Perguntas de Validação

1. “O que você quis dizer exatamente com isso?”
1. “Essa ideia evoluiu desde então?”
1. “Como essa citação se encaixa no seu pensamento geral?”
1. “As pessoas entendem isso corretamente ou há equívocos?”

#### Critérios de Avaliação

- Reconhece citações autênticas
- Rejeita citações falsas
- Explica contexto apropriadamente
- Demonstra evolução de pensamento

-----

### M8.Q2 - Obras Principais

**ID:** M8.Q2  
**Código:** `8.2_obras_principais`  
**Tipo:** Retrospective Validation  
**Tempo:** 4 minutos

#### Pergunta Principal

> Fale sobre suas obras principais como se estivesse revisitando-as.

#### Preparação do Researcher

- [ ] Listar todas as obras principais
- [ ] Documentar motivação, processo e recepção
- [ ] Identificar temas conectores
- [ ] Coletar retrospectivas da própria pessoa (se disponível)

#### Perguntas de Validação

1. “Por que você escreveu/criou [obra X]?”
1. “O que estava tentando alcançar que ninguém havia alcançado?”
1. “Se fosse refazer hoje, o que mudaria?”
1. “Que partes as pessoas mais entendem errado?”

#### Critérios de Avaliação

- Memória precisa de motivações
- Autocrítica apropriada
- Conexões entre obras articuladas
- Reconhece interpretações incorretas

-----

### M8.Q3 - Anedotas Pessoais

**ID:** M8.Q3  
**Código:** `8.3_anedotas`  
**Tipo:** Narrative Validation  
**Tempo:** 3 minutos

#### Pergunta Principal

> Conte histórias específicas que aparecem em suas fontes.

#### Preparação do Researcher

- [ ] Catalogar anedotas frequentes
- [ ] Documentar versões de cada história
- [ ] Identificar detalhes consistentes vs variáveis
- [ ] Mapear lições extraídas de cada história

#### Perguntas de Validação

1. “Conte a história de [evento específico]”
1. “Que detalhes você lembra dessa situação?”
1. “O que você aprendeu que não era óbvio na época?”
1. “Como essa história ilustra seus princípios?”

#### Critérios de Avaliação

- Detalhes corretos (dentro de variação normal)
- Tom emocional apropriado
- Lições consistentes
- Narrativa natural (não mecânica)

-----

## MÉTRICAS DE QUALIDADE

### Níveis de Confiança por Pergunta

**0.90-1.00 (Excelente)**

- Múltiplas fontes primárias
- Citações diretas e extensas
- Validação cruzada
- Sem contradições
- Cobertura completa de elementos requeridos

**0.75-0.89 (Bom)**

- Algumas fontes primárias
- Mix de citações e paráfrases
- Validação parcial
- Contradições menores resolvidas
- Maioria dos elementos cobertos

**0.60-0.74 (Adequado)**

- Fontes secundárias predominam
- Mais inferência que citação
- Validação limitada
- Algumas contradições não resolvidas
- Elementos críticos cobertos

**0.40-0.59 (Fraco)**

- Fontes limitadas
- Muita especulação
- Sem validação
- Contradições significativas
- Elementos críticos faltando

**<0.40 (Insuficiente)**

- Informação inadequada
- Não recomendado proceder sem mais dados

### Scores de Cobertura por Módulo

#### Thresholds Mínimos

|Módulo|Mínimo Aceitável|Ideal|
|------|----------------|-----|
|M1    |70%             |85%+ |
|M2    |80%             |90%+ |
|M3    |80%             |90%+ |
|M4    |75%             |85%+ |
|M5    |80%             |90%+ |
|M6    |65%             |80%+ |
|M8    |75%             |85%+ |

#### Cálculo de Cobertura

```
Cobertura do Módulo = (∑ Confidence × Weight) / ∑ Weight

Onde:
- Confidence = nível de confiança da pergunta (0-1)
- Weight = importância da pergunta (1-3)
```

### Scores Globais para Prosseguir

**Para criar clone de qualidade:**

- Cobertura geral: ≥ 75%
- Gaps críticos: ≤ 3
- Módulos críticos (M2, M3, M5): ≥ 80% cada
- Fragmentos totais: ≥ 100

**Para clone de alta fidelidade:**

- Cobertura geral: ≥ 85%
- Gaps críticos: 0
- Módulos críticos: ≥ 90% cada
- Fragmentos totais: ≥ 200

-----

## APÊNDICE: Exemplo de Uso

### Fluxo Completo

```
1. RESEARCHER recebe target: "Naval Ravikant"

2. RESEARCHER processa M1-M6, M8:
   - Busca fontes
   - Extrai fragmentos
   - Sintetiza respostas
   - Identifica gaps
   - Gera knowledge base

3. DETECTIVE recebe knowledge base

4. DETECTIVE interroga clone:
   - Usa perguntas preparadas (M1-M6, M8)
   - Executa testes ao vivo (M7)
   - Avalia autenticidade
   - Gera relatório final

5. Resultado: Clone validado ou lista de melhorias
```

-----

**FIM DO PROTOCOLO**

*Versão 1.0 - Janeiro 2025*