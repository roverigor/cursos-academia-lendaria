
# PROTOCOLO DE INTERROGAÇÃO - Arquivo Estruturado

## interrogation_protocol.yaml

```yaml
protocol_version: "1.0"
protocol_name: "Cognitive Clone Interrogation Protocol"
total_modules: 8
total_questions: 87
estimated_duration: "90-120 minutes"

modules:
  - id: "M1"
    name: "História de Vida e Formação"
    duration: "15-20 min"
    priority: "high"
    description: "Mapear trajetória biográfica, experiências formativas e influências"
    
    questions:
      - id: "M1.Q1"
        code: "1.1_vida_completa"
        question: "Conte-me a história completa da vida de {person_name}, desde a infância até o momento presente. Não pule fases importantes."
        type: "narrative"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["childhood", "education", "career", "life story", "biography", "timeline"]
        related_concepts: ["formative experiences", "pivotal moments", "life phases"]
        
        followups:
          - "Que eventos específicos da infância moldaram fundamentalmente quem {person_name} se tornou?"
          - "Como foi a relação com os pais? Isso influenciou suas escolhas posteriores?"
          - "Houve algum momento de virada decisivo? Descreva-o em detalhes."
          - "O que {person_name} estava fazendo aos 15, 25, 35 e 45 anos?"
        
        required_elements:
          - "Infância e família de origem"
          - "Educação formal e informal"
          - "Momentos de virada críticos"
          - "Progressão de carreira"
          - "Eventos pessoais significativos"
        
        fragment_types:
          - "biographical_facts"
          - "personal_anecdotes"
          - "timeline_events"
          - "relationship_descriptions"

      - id: "M1.Q2"
        code: "1.2_educacao_formacao"
        question: "Descreva o caminho educacional de {person_name}. O que estudou, onde, com quem?"
        type: "factual"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["education", "study", "school", "university", "learning", "teachers", "mentors"]
        related_concepts: ["intellectual development", "academic influences", "learning style"]
        
        followups:
          - "Quem foram os mentores ou professores mais influentes?"
          - "Que livros ou ideias mudaram fundamentalmente sua forma de pensar?"
          - "Houve alguma educação formal que {person_name} rejeitou ou abandonou? Por quê?"
          - "Como {person_name} aprende coisas novas? Qual seu método?"
        
        required_elements:
          - "Instituições frequentadas"
          - "Áreas de estudo"
          - "Mentores e influências acadêmicas"
          - "Educação autodidata"
          - "Método de aprendizado"
        
        fragment_types:
          - "educational_facts"
          - "mentor_influences"
          - "learning_methods"
          - "intellectual_influences"

      - id: "M1.Q3"
        code: "1.3_experiencias_formativas"
        question: "Quais foram as 3-5 experiências mais transformadoras na vida de {person_name}?"
        type: "analytical"
        expected_depth: "deep"
        time_allocation: "4 min"
        keywords: ["transformation", "pivotal", "turning point", "change", "impact", "formative"]
        related_concepts: ["personal growth", "life lessons", "crisis", "breakthrough"]
        
        followups:
          - "O que exatamente tornou cada experiência tão impactante?"
          - "Como {person_name} era antes versus depois de cada experiência?"
          - "Existem fracassos ou falhas que foram formativos? Descreva-os."
          - "Que padrões você vê através dessas experiências?"
        
        required_elements:
          - "Lista de experiências transformadoras"
          - "Impacto específico de cada uma"
          - "Lições extraídas"
          - "Mudanças comportamentais resultantes"
        
        fragment_types:
          - "transformative_events"
          - "failure_stories"
          - "breakthrough_moments"
          - "lessons_learned"

      - id: "M1.Q4"
        code: "1.4_influencias"
        question: "Quem são as pessoas que mais influenciaram {person_name}? Por quê?"
        type: "relational"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["influence", "mentor", "inspiration", "role model", "teacher"]
        related_concepts: ["intellectual lineage", "professional influences", "personal relationships"]
        
        followups:
          - "O que especificamente {person_name} aprendeu com cada influência?"
          - "Existem influências que {person_name} rejeitou ou superou?"
          - "Como essas influências aparecem no trabalho de {person_name} hoje?"
        
        required_elements:
          - "Lista de influências principais"
          - "Tipo de influência (intelectual/pessoal/profissional)"
          - "Aprendizados específicos"
          - "Manifestação atual dessas influências"
        
        fragment_types:
          - "influence_descriptions"
          - "relationship_impacts"
          - "intellectual_lineage"

  - id: "M2"
    name: "Sistemas de Pensamento"
    duration: "20-25 min"
    priority: "critical"
    description: "Entender frameworks mentais, processos cognitivos e filosofia fundamental"
    
    questions:
      - id: "M2.Q1"
        code: "2.1_filosofia_core"
        question: "Qual é a filosofia fundamental que guia {person_name}? O sistema de crenças no núcleo de tudo?"
        type: "philosophical"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["philosophy", "worldview", "beliefs", "principles", "core", "fundamental"]
        related_concepts: ["epistemology", "ontology", "ethics", "metaphysics"]
        
        followups:
          - "De onde veio essa filosofia? Foi construída ou descoberta?"
          - "Essa filosofia já mudou radicalmente? Quando e por quê?"
          - "Como {person_name} aplicaria essa filosofia a um problema totalmente novo?"
          - "Que trade-offs ou sacrifícios essa filosofia exige?"
        
        required_elements:
          - "Descrição da filosofia fundamental"
          - "Origens dessa filosofia"
          - "Evolução ao longo do tempo"
          - "Aplicações práticas"
          - "Consequências e trade-offs"
        
        fragment_types:
          - "philosophical_statements"
          - "belief_system"
          - "principle_articulations"
          - "worldview_descriptions"

      - id: "M2.Q2"
        code: "2.2_processo_pensamento"
        question: "Como {person_name} pensa sobre problemas complexos? Descreva o processo mental passo a passo."
        type: "cognitive"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["thinking", "analysis", "problem-solving", "mental process", "cognition"]
        related_concepts: ["reasoning", "logic", "intuition", "frameworks"]
        
        followups:
          - "Quando enfrenta um problema novo, qual é o primeiro movimento mental?"
          - "Como {person_name} distingue entre problemas importantes e triviais?"
          - "Que frameworks mentais {person_name} usa repetidamente?"
          - "Como {person_name} sabe quando está certo versus errado?"
        
        required_elements:
          - "Processo passo a passo"
          - "Primeiro movimento cognitivo"
          - "Frameworks utilizados"
          - "Critérios de priorização"
          - "Mecanismos de validação"
        
        fragment_types:
          - "thinking_process"
          - "problem_solving_examples"
          - "mental_frameworks"
          - "validation_methods"

      - id: "M2.Q3"
        code: "2.3_tomada_decisao"
        question: "Como {person_name} toma decisões importantes? Qual o processo?"
        type: "behavioral"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["decision", "choice", "process", "criteria", "judgment"]
        related_concepts: ["decision-making", "trade-offs", "risk", "uncertainty"]
        
        followups:
          - "Que fatores {person_name} prioriza em decisões difíceis?"
          - "Como {person_name} lida com incerteza e informação incompleta?"
          - "Existe um padrão nas decisões que {person_name} se arrepende?"
          - "Como intuição versus análise entram nas decisões?"
        
        required_elements:
          - "Processo de decisão"
          - "Fatores priorizados"
          - "Gestão de incerteza"
          - "Papel da intuição vs análise"
          - "Exemplos de decisões"
        
        fragment_types:
          - "decision_processes"
          - "decision_criteria"
          - "decision_examples"
          - "regret_analysis"

      - id: "M2.Q4"
        code: "2.4_resolucao_problemas"
        question: "Quando {person_name} enfrenta um problema impossível, como aborda?"
        type: "behavioral"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["impossible", "difficult", "challenge", "approach", "solution"]
        related_concepts: ["problem-solving", "creativity", "persistence", "reframing"]
        
        followups:
          - "Dê um exemplo específico de um problema 'impossível' que resolveu."
          - "Que técnicas ou métodos {person_name} usa que outros não usam?"
          - "Como {person_name} reformula problemas para torná-los solucionáveis?"
          - "O que {person_name} faz quando completamente travado?"
        
        required_elements:
          - "Abordagem geral"
          - "Técnicas específicas"
          - "Exemplo concreto"
          - "Estratégias de reframing"
          - "Respostas a bloqueios"
        
        fragment_types:
          - "problem_solving_stories"
          - "techniques_used"
          - "reframing_examples"
          - "breakthrough_moments"

      - id: "M2.Q5"
        code: "2.5_aprendizado_evolucao"
        question: "Como {person_name} aprende e evolui suas ideias ao longo do tempo?"
        type: "meta-cognitive"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["learning", "evolution", "change", "growth", "adaptation"]
        related_concepts: ["intellectual growth", "mind-changing", "feedback", "iteration"]
        
        followups:
          - "Que ideias {person_name} mudou completamente nos últimos 10 anos?"
          - "Como {person_name} decide quando uma ideia antiga precisa ser descartada?"
          - "Qual foi a última vez que {person_name} disse 'eu estava completamente errado sobre isso'?"
          - "Como {person_name} integra feedback ou críticas?"
        
        required_elements:
          - "Processo de aprendizado"
          - "Exemplos de mudança de opinião"
          - "Gestão de feedback"
          - "Critérios para descartar ideias"
        
        fragment_types:
          - "learning_methods"
          - "mind_changing_examples"
          - "feedback_integration"
          - "intellectual_evolution"

  - id: "M3"
    name: "Domínio e Expertise"
    duration: "20-25 min"
    priority: "critical"
    description: "Mapear conhecimento especializado, contribuições e metodologias"
    
    questions:
      - id: "M3.Q1"
        code: "3.1_area_expertise"
        question: "Qual é exatamente a área de expertise de {person_name}? Defina com precisão."
        type: "factual"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["expertise", "specialization", "knowledge", "domain", "field"]
        related_concepts: ["professional identity", "core competence", "unique knowledge"]
        
        followups:
          - "O que {person_name} sabe que 99% das pessoas no campo não sabem?"
          - "Como {person_name} desenvolveu esse conhecimento único?"
          - "Que partes dessa expertise são contraintuitivas ou controversas?"
          - "Se alguém quisesse alcançar essa expertise, qual seria o caminho?"
        
        required_elements:
          - "Definição precisa da área"
          - "Conhecimento único"
          - "Caminho de desenvolvimento"
          - "Aspectos controversos"
          - "Barreiras de entrada"
        
        fragment_types:
          - "expertise_descriptions"
          - "unique_knowledge"
          - "field_definition"
          - "skill_development"

      - id: "M3.Q2"
        code: "3.2_principais_trabalhos"
        question: "Quais são os trabalhos ou contribuições mais importantes de {person_name}?"
        type: "factual"
        expected_depth: "medium"
        time_allocation: "4 min"
        keywords: ["work", "contribution", "achievement", "creation", "project"]
        related_concepts: ["legacy", "impact", "innovation", "body of work"]
        
        followups:
          - "O que cada trabalho tentava resolver ou alcançar?"
          - "Como cada trabalho se conecta aos outros? Qual o fio condutor?"
          - "Que trabalhos falharam ou foram abandonados? Por quê?"
          - "Se {person_name} pudesse refazer um trabalho, qual seria e como?"
        
        required_elements:
          - "Lista de trabalhos principais"
          - "Objetivo de cada trabalho"
          - "Conexões entre trabalhos"
          - "Trabalhos falhos"
          - "Retrospectiva crítica"
        
        fragment_types:
          - "work_descriptions"
          - "contribution_analysis"
          - "project_retrospectives"
          - "failure_analysis"

      - id: "M3.Q3"
        code: "3.3_metodologia"
        question: "Qual é a metodologia ou abordagem característica de {person_name}?"
        type: "analytical"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["methodology", "approach", "method", "process", "technique"]
        related_concepts: ["working style", "problem-solving approach", "signature methods"]
        
        followups:
          - "Como essa metodologia é diferente das abordagens convencionais?"
          - "Quando essa metodologia funciona melhor? E quando falha?"
          - "Pode dar um exemplo de aplicar essa metodologia a um problema específico?"
          - "Como {person_name} desenvolveu essa metodologia?"
        
        required_elements:
          - "Descrição da metodologia"
          - "Diferenças do convencional"
          - "Casos de uso ideais"
          - "Limitações conhecidas"
          - "Exemplo de aplicação"
        
        fragment_types:
          - "methodology_descriptions"
          - "approach_examples"
          - "technique_explanations"
          - "comparative_analysis"

      - id: "M3.Q4"
        code: "3.4_controversias"
        question: "Em que {person_name} discorda fortemente do consenso do campo?"
        type: "analytical"
        expected_depth: "deep"
        time_allocation: "4 min"
        keywords: ["disagreement", "controversy", "contrarian", "consensus", "debate"]
        related_concepts: ["intellectual independence", "controversial positions", "field debates"]
        
        followups:
          - "Por que {person_name} acredita que a maioria está errada?"
          - "Que evidências ou raciocínio sustentam essa posição contrária?"
          - "Como {person_name} lida com resistência a essas ideias?"
          - "Já mudou de opinião em alguma dessas controvérsias?"
        
        required_elements:
          - "Posições contrárias ao consenso"
          - "Raciocínio para cada posição"
          - "Evidências de suporte"
          - "Gestão de resistência"
          - "Evolução de posições"
        
        fragment_types:
          - "controversial_positions"
          - "contrarian_arguments"
          - "debate_participation"
          - "position_evolution"

      - id: "M3.Q5"
        code: "3.5_fronteiras_conhecimento"
        question: "Onde estão as fronteiras do conhecimento de {person_name}? O que ainda não sabe?"
        type: "meta-cognitive"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["limits", "boundaries", "unknown", "uncertainty", "gaps"]
        related_concepts: ["intellectual humility", "knowledge boundaries", "unknown unknowns"]
        
        followups:
          - "Que perguntas {person_name} considera mais importantes e ainda não resolvidas?"
          - "O que {person_name} gostaria de entender mas ainda não entende?"
          - "Que áreas {person_name} deliberadamente evita ou considera fora de sua expertise?"
        
        required_elements:
          - "Limites conhecidos"
          - "Perguntas em aberto"
          - "Áreas evitadas"
          - "Incertezas reconhecidas"
        
        fragment_types:
          - "knowledge_boundaries"
          - "open_questions"
          - "intellectual_humility"
          - "uncertainty_acknowledgment"

  - id: "M4"
    name: "Comunicação e Expressão"
    duration: "15-20 min"
    priority: "high"
    description: "Capturar estilo comunicacional, linguagem e pedagogia"
    
    questions:
      - id: "M4.Q1"
        code: "4.1_estilo_comunicacao"
        question: "Como {person_name} comunica ideias complexas? Qual seu estilo característico?"
        type: "stylistic"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["communication", "style", "expression", "explanation", "articulation"]
        related_concepts: ["rhetoric", "pedagogy", "clarity", "persuasion"]
        
        followups:
          - "Que metáforas, analogias ou frameworks {person_name} usa repetidamente?"
          - "Como o estilo muda dependendo da audiência?"
          - "Que aspectos da comunicação de {person_name} as pessoas mais reconhecem?"
          - "Como {person_name} simplifica sem perder nuance?"
        
        required_elements:
          - "Descrição do estilo geral"
          - "Metáforas recorrentes"
          - "Adaptação de audiência"
          - "Marcas reconhecíveis"
          - "Técnicas de simplificação"
        
        fragment_types:
          - "communication_examples"
          - "metaphors_used"
          - "style_descriptions"
          - "audience_adaptation"

      - id: "M4.Q2"
        code: "4.2_linguagem_vocabulario"
        question: "Que palavras, frases ou conceitos {person_name} usa constantemente?"
        type: "linguistic"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["vocabulary", "language", "words", "phrases", "terminology"]
        related_concepts: ["linguistic signature", "jargon", "catchphrases", "verbal tics"]
        
        followups:
          - "Existem termos que {person_name} criou ou redefiniu?"
          - "Que linguagem {person_name} evita ou rejeita usar?"
          - "Como o vocabulário de {person_name} evoluiu ao longo do tempo?"
          - "Cite 10 palavras ou frases que são 'assinaturas' de {person_name}."
        
        required_elements:
          - "Palavras frequentes"
          - "Frases assinatura"
          - "Termos criados/redefinidos"
          - "Linguagem evitada"
          - "Evolução vocabular"
        
        fragment_types:
          - "signature_phrases"
          - "vocabulary_analysis"
          - "neologisms"
          - "language_patterns"

      - id: "M4.Q3"
        code: "4.3_modo_ensino"
        question: "Se {person_name} estivesse ensinando alguém, como seria? Qual a pedagogia?"
        type: "pedagogical"
        expected_depth: "medium"
        time_allocation: "4 min"
        keywords: ["teaching", "pedagogy", "education", "instruction", "learning"]
        related_concepts: ["mentorship", "knowledge transfer", "educational philosophy"]
        
        followups:
          - "Como {person_name} diagnostica o que o aluno não está entendendo?"
          - "Que tipos de exemplos ou exercícios {person_name} usaria?"
          - "Como {person_name} lida com um aluno que não está progredindo?"
          - "Qual a diferença entre como {person_name} ensina iniciantes versus avançados?"
        
        required_elements:
          - "Estilo pedagógico"
          - "Técnicas de diagnóstico"
          - "Tipos de exemplos"
          - "Gestão de dificuldades"
          - "Diferenciação por nível"
        
        fragment_types:
          - "teaching_examples"
          - "pedagogical_approach"
          - "mentorship_stories"
          - "educational_philosophy"

      - id: "M4.Q4"
        code: "4.4_argumentacao"
        question: "Como {person_name} constrói e defende argumentos?"
        type: "rhetorical"
        expected_depth: "deep"
        time_allocation: "4 min"
        keywords: ["argument", "reasoning", "rhetoric", "persuasion", "debate"]
        related_concepts: ["logical structure", "evidence use", "counterarguments"]
        
        followups:
          - "Qual a estrutura típica de um argumento de {person_name}?"
          - "Como {person_name} lida com objeções ou contrapontos?"
          - "Que tipo de evidência {person_name} considera mais convincente?"
          - "Quando {person_name} concederia um ponto versus defenderia até o fim?"
        
        required_elements:
          - "Estrutura de argumento"
          - "Gestão de objeções"
          - "Tipos de evidência preferidos"
          - "Concessões vs defesa"
        
        fragment_types:
          - "argument_structures"
          - "debate_examples"
          - "evidence_usage"
          - "counterargument_handling"

      - id: "M4.Q5"
        code: "4.5_humor_personalidade"
        question: "Como o humor e a personalidade de {person_name} aparecem na comunicação?"
        type: "stylistic"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["humor", "personality", "tone", "emotion", "character"]
        related_concepts: ["emotional expression", "wit", "sarcasm", "warmth"]
        
        followups:
          - "Que tipo de humor {person_name} usa? Quando?"
          - "Como {person_name} usa histórias pessoais ou exemplos?"
          - "Existe um tom emocional característico? (Otimista? Cético? Provocativo?)"
          - "Como {person_name} equilibra seriedade e leveza?"
        
        required_elements:
          - "Tipo de humor"
          - "Uso de histórias pessoais"
          - "Tom emocional"
          - "Equilíbrio sério/leve"
        
        fragment_types:
          - "humor_examples"
          - "personal_stories"
          - "tone_analysis"
          - "emotional_expression"

  - id: "M5"
    name: "Valores e Princípios"
    duration: "15-20 min"
    priority: "critical"
    description: "Identificar valores fundamentais, ética e propósito"
    
    questions:
      - id: "M5.Q1"
        code: "5.1_valores_fundamentais"
        question: "Quais são os 3-5 valores absolutamente inegociáveis para {person_name}?"
        type: "values"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["values", "principles", "ethics", "non-negotiable", "core"]
        related_concepts: ["moral framework", "integrity", "commitments"]
        
        followups:
          - "De onde vêm esses valores? Como foram formados?"
          - "Houve situações onde esses valores foram testados? O que aconteceu?"
          - "Como {person_name} age quando valores entram em conflito?"
          - "Esses valores mudaram ao longo da vida? Como?"
        
        required_elements:
          - "Lista de 3-5 valores"
          - "Origem de cada valor"
          - "Exemplos de teste"
          - "Resolução de conflitos"
          - "Evolução dos valores"
        
        fragment_types:
          - "value_statements"
          - "value_origin_stories"
          - "value_testing_examples"
          - "value_evolution"

      - id: "M5.Q2"
        code: "5.2_etica_moral"
        question: "Qual é o framework ético ou moral que guia {person_name}?"
        type: "philosophical"
        expected_depth: "deep"
        time_allocation: "5 min"
        keywords: ["ethics", "morality", "right", "wrong", "framework"]
        related_concepts: ["moral philosophy", "ethical principles", "moral reasoning"]
        
        followups:
          - "Como {person_name} decide o que é certo versus errado?"
          - "Existem áreas onde {person_name} é mais relativista? Mais absolutista?"
          - "Como {person_name} lida com dilemas éticos sem resposta clara?"
          - "Que princípios morais {person_name} vê sendo violados na sociedade?"
        
        required_elements:
          - "Framework ético"
          - "Processo de decisão moral"
          - "Absolutismo vs relativismo"
          - "Gestão de dilemas"
          - "Críticas morais da sociedade"
        
        fragment_types:
          - "ethical_framework"
          - "moral_reasoning"
          - "ethical_dilemmas"
          - "moral_criticism"

      - id: "M5.Q3"
        code: "5.3_proposito_missao"
        question: "Qual é o propósito ou missão que move {person_name}?"
        type: "motivational"
        expected_depth: "deep"
        time_allocation: "4 min"
        keywords: ["purpose", "mission", "calling", "drive", "motivation"]
        related_concepts: ["life purpose", "ikigai", "telos", "vocation"]
        
        followups:
          - "Quando {person_name} percebeu esse propósito?"
          - "Como esse propósito se manifesta no trabalho diário?"
          - "O que {person_name} sacrificou ou sacrificaria por esse propósito?"
          - "Como {person_name} mede progresso em direção a esse propósito?"
        
        required_elements:
          - "Descrição do propósito"
          - "Momento de descoberta"
          - "Manifestações práticas"
          - "Sacrifícios feitos"
          - "Métricas de progresso"
        
        fragment_types:
          - "purpose_statements"
          - "mission_descriptions"
          - "sacrifice_stories"
          - "progress_metrics"

      - id: "M5.Q4"
        code: "5.4_legado"
        question: "O que {person_name} quer deixar como legado?"
        type: "aspirational"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["legacy", "impact", "remember", "contribution", "lasting"]
        related_concepts: ["long-term impact", "remembrance", "contribution"]
        
        followups:
          - "Daqui a 100 anos, o que {person_name} quer que seja lembrado?"
          - "Que problemas {person_name} espera ter ajudado a resolver?"
          - "Como {person_name} pensa sobre impacto versus reconhecimento?"
          - "Existe algo que {person_name} construiu que considera subestimado?"
        
        required_elements:
          - "Visão de legado"
          - "Impacto desejado"
          - "Problemas a resolver"
          - "Reconhecimento vs impacto"
          - "Trabalhos subestimados"
        
        fragment_types:
          - "legacy_statements"
          - "impact_aspirations"
          - "long_term_vision"

  - id: "M6"
    name: "Contexto e Perspectiva"
    duration: "10-15 min"
    priority: "medium"
    description: "Entender worldview, visão social e posicionamento contextual"
    
    questions:
      - id: "M6.Q1"
        code: "6.1_visao_mundo"
        question: "Como {person_name} vê o mundo? Qual a worldview fundamental?"
        type: "philosophical"
        expected_depth: "deep"
        time_allocation: "4 min"
        keywords: ["worldview", "reality", "nature", "universe", "existence"]
        related_concepts: ["metaphysics", "ontology", "cosmology"]
        
        followups:
          - "O mundo é fundamentalmente ordenado ou caótico para {person_name}?"
          - "Humanos são basicamente bons ou precisam de restrições?"
          - "Progresso é inevitável, possível, ou ilusório?"
          - "Como {person_name} vê o papel do indivíduo versus coletivo?"
        
        required_elements:
          - "Worldview geral"
          - "Visão de ordem/caos"
          - "Visão da natureza humana"
          - "Visão de progresso"
          - "Indivíduo vs coletivo"
        
        fragment_types:
          - "worldview_statements"
          - "philosophical_positions"
          - "ontological_views"

      - id: "M6.Q2"
        code: "6.2_sociedade_cultura"
        question: "Como {person_name} vê a sociedade e cultura contemporânea?"
        type: "social"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["society", "culture", "contemporary", "social", "civilization"]
        related_concepts: ["social criticism", "cultural analysis", "current affairs"]
        
        followups:
          - "Que problemas sociais {person_name} considera mais urgentes?"
          - "Como a cultura atual difere da ideal para {person_name}?"
          - "Que tendências culturais {person_name} celebra versus lamenta?"
          - "Como {person_name} se posiciona em relação ao status quo?"
        
        required_elements:
          - "Visão da sociedade atual"
          - "Problemas urgentes"
          - "Visão de cultura ideal"
          - "Tendências avaliadas"
          - "Posicionamento ao status quo"
        
        fragment_types:
          - "social_commentary"
          - "cultural_criticism"
          - "societal_analysis"

      - id: "M6.Q3"
        code: "6.3_futuro"
        question: "Como {person_name} pensa sobre o futuro?"
        type: "predictive"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["future", "prediction", "forecast", "tomorrow", "trend"]
        related_concepts: ["futurism", "optimism/pessimism", "forecasting"]
        
        followups:
          - "Otimista ou pessimista? Em quais aspectos?"
          - "Que desenvolvimentos futuros {person_name} considera inevitáveis?"
          - "Que futuros possíveis {person_name} está tentando criar ou evitar?"
          - "Como {person_name} lida com incerteza sobre o futuro?"
        
        required_elements:
          - "Orientação geral (otimista/pessimista)"
          - "Previsões específicas"
          - "Futuros desejados/evitados"
          - "Gestão de incerteza"
        
        fragment_types:
          - "future_predictions"
          - "optimism_pessimism"
          - "trend_analysis"

      - id: "M6.Q4"
        code: "6.4_papel_pessoal"
        question: "Como {person_name} vê seu próprio papel no mundo?"
        type: "reflective"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["role", "responsibility", "position", "contribution", "place"]
        related_concepts: ["self-perception", "agency", "responsibility"]
        
        followups:
          - "Que responsabilidades {person_name} sente que tem?"
          - "Como {person_name} equilibra ambição pessoal e contribuição social?"
          - "Que limitações {person_name} reconhece em si mesmo?"
          - "Como {person_name} define sucesso para si mesmo?"
        
        required_elements:
          - "Autopercepção de papel"
          - "Responsabilidades sentidas"
          - "Equilíbrio ambição/contribuição"
          - "Limitações reconhecidas"
          - "Definição de sucesso"
        
        fragment_types:
          - "self_perception"
          - "responsibility_statements"
          - "success_definitions"

  - id: "M7"
    name: "Testes de Consistência"
    duration: "10-15 min"
    priority: "high"
    description: "Validar consistência, profundidade e autenticidade"
    note: "Este módulo é executado DURANTE a interrogação pelo Detective, não pelo Researcher"
    
   ```yaml
      - id: "M7.Q1"
        code: "7.1_cenarios_hipotetivos"
        question: "Vou apresentar cenários hipotéticos. Como {person_name} responderia?"
        type: "situational"
        expected_depth: "medium"
        time_allocation: "4 min"
        keywords: ["scenario", "hypothetical", "situation", "response", "reaction"]
        related_concepts: ["applied thinking", "practical wisdom", "situational judgment"]
        note: "Executado pelo Detective durante interrogação, não preparado pelo Researcher"
        
        scenarios:
          - "Um jovem talentoso pede conselho de carreira. O que {person_name} diria?"
          - "Alguém critica duramente o trabalho de {person_name}. Como reage?"
          - "Uma oportunidade lucrativa conflita com valores. O que fazer?"
          - "Descobriu estar errado sobre algo fundamental. Como procede?"
          - "Tem chance de resolver um grande problema mas com alto risco. Tenta?"
        
        fragment_types:
          - "hypothetical_responses"
          - "situational_reactions"
          - "applied_values"

      - id: "M7.Q2"
        code: "7.2_dilemas"
        question: "Como {person_name} resolveria estes dilemas?"
        type: "dilemmatic"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["dilemma", "conflict", "trade-off", "choice", "tension"]
        related_concepts: ["value conflicts", "hard choices", "priorities"]
        note: "Executado pelo Detective durante interrogação"
        
        dilemmas:
          - "Verdade versus gentileza: quando cada um prevalece?"
          - "Curto prazo versus longo prazo: como decidir?"
          - "Individual versus coletivo: onde traçar a linha?"
          - "Tradição versus inovação: como equilibrar?"
          - "Simplicidade versus complexidade: quando cada uma?"
        
        fragment_types:
          - "dilemma_resolutions"
          - "priority_hierarchies"
          - "trade_off_decisions"

      - id: "M7.Q3"
        code: "7.3_crosscheck"
        question: "Vou fazer perguntas sobre coisas que você já disse. Suas respostas vão permanecer consistentes?"
        type: "consistency_test"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["consistency", "cross-reference", "validation", "verify"]
        related_concepts: ["internal consistency", "contradiction detection"]
        note: "Executado pelo Detective, compara com respostas anteriores"
        
        validation_patterns:
          - "Antes você disse X, mas isso não contradiz Y que disse depois?"
          - "Como essa posição se relaciona com aquilo que disse sobre Z?"
          - "Você pode dar mais um exemplo dessa mesma ideia mas em contexto diferente?"
          - "Se eu perguntasse de outra forma: [reformulação], a resposta seria a mesma?"
        
        fragment_types:
          - "consistency_checks"
          - "cross_references"

      - id: "M7.Q4"
        code: "7.4_depth_probes"
        question: "Vou aprofundar em áreas específicas para testar compreensão real."
        type: "depth_test"
        expected_depth: "deep"
        time_allocation: "4 min"
        keywords: ["depth", "understanding", "expertise", "mastery"]
        related_concepts: ["deep knowledge", "surface vs depth", "expertise validation"]
        note: "Executado pelo Detective para testar profundidade real"
        
        probe_types:
          - "Explique isso para uma criança de 10 anos."
          - "Explique isso para um PhD no campo."
          - "Qual é a versão de 30 segundos? E a de 30 minutos?"
          - "Quais são os 3 maiores equívocos sobre essa ideia?"
          - "Se você tivesse que provar que está errado, como faria?"
        
        fragment_types:
          - "depth_demonstrations"
          - "multi_level_explanations"
          - "metacognitive_awareness"

  - id: "M8"
    name: "Validação Contra Fontes"
    duration: "5-10 min"
    priority: "high"
    description: "Validar respostas contra material fonte conhecido"
    note: "Híbrido: Researcher prepara material, Detective executa validação"
    
    questions:
      - id: "M8.Q1"
        code: "8.1_citacoes_conhecidas"
        question: "Vou citar coisas que {person_name} disse. Explique o contexto e significado completo."
        type: "validation"
        expected_depth: "deep"
        time_allocation: "3 min"
        keywords: ["quote", "citation", "statement", "said", "wrote"]
        related_concepts: ["source validation", "contextual understanding"]
        
        researcher_prep:
          - action: "Extrair 10-20 citações famosas/importantes da pessoa"
          - action: "Documentar contexto completo de cada citação"
          - action: "Preparar variações e paráfrases para testar reconhecimento"
        
        validation_questions:
          - "O que você quis dizer exatamente com isso?"
          - "Essa ideia evoluiu desde então?"
          - "Como essa citação se encaixa no seu pensamento geral?"
        
        fragment_types:
          - "famous_quotes"
          - "quote_contexts"
          - "quote_evolution"

      - id: "M8.Q2"
        code: "8.2_obras_principais"
        question: "Fale sobre suas obras principais como se estivesse revisitando-as."
        type: "retrospective"
        expected_depth: "deep"
        time_allocation: "4 min"
        keywords: ["work", "creation", "project", "book", "paper", "product"]
        related_concepts: ["body of work", "creative output", "contributions"]
        
        researcher_prep:
          - action: "Listar todas as obras principais da pessoa"
          - action: "Documentar motivação, processo e recepção de cada obra"
          - action: "Identificar temas conectores entre obras"
        
        validation_questions:
          - "Por que você escreveu/criou [obra X]?"
          - "O que estava tentando alcançar que ninguém havia alcançado?"
          - "Se fosse refazer hoje, o que mudaria?"
          - "Que partes as pessoas mais entendem errado?"
        
        fragment_types:
          - "work_retrospectives"
          - "creative_motivations"
          - "work_critiques"

      - id: "M8.Q3"
        code: "8.3_anedotas"
        question: "Conte histórias específicas que aparecem em suas fontes."
        type: "narrative"
        expected_depth: "medium"
        time_allocation: "3 min"
        keywords: ["story", "anecdote", "event", "experience", "incident"]
        related_concepts: ["biographical events", "memorable moments", "personal stories"]
        
        researcher_prep:
          - action: "Catalogar anedotas frequentes nas fontes"
          - action: "Documentar versões de cada história"
          - action: "Identificar detalhes consistentes vs variáveis"
        
        validation_questions:
          - "Conte a história de [evento específico]"
          - "Que detalhes você lembra dessa situação?"
          - "O que você aprendeu que não era óbvio na época?"
          - "Como essa história ilustra seus princípios?"
        
        fragment_types:
          - "personal_anecdotes"
          - "story_retellings"
          - "anecdote_lessons"

# METADATA DO PROTOCOLO

coverage_requirements:
  minimum_questions_answered: 60  # De 87 totais (excluindo M7 que é teste)
  minimum_confidence_per_module:
    M1: 0.70
    M2: 0.80  # Crítico
    M3: 0.80  # Crítico
    M4: 0.75
    M5: 0.80  # Crítico
    M6: 0.65
    M8: 0.75
  
  minimum_fragments_per_question:
    factual: 2
    analytical: 3
    philosophical: 4
    behavioral: 3
    narrative: 2

quality_thresholds:
  fragment_relevance_minimum: 6  # Em escala 1-10
  confidence_to_proceed: 0.75  # 75% overall
  critical_gaps_tolerance: 3  # Máximo de gaps críticos aceitáveis

research_phases:
  phase_1_reconnaissance:
    duration: "2-4 hours"
    output: "Source inventory and initial mapping"
  
  phase_2_systematic_extraction:
    duration: "20-40 hours"
    output: "Complete fragment library"
  
  phase_3_pattern_mining:
    duration: "4-8 hours"
    output: "Cognitive signatures catalog"
  
  phase_4_gap_analysis:
    duration: "2-4 hours"
    output: "Gap report and recommendations"
  
  phase_5_kb_construction:
    duration: "4-8 hours"
    output: "Structured knowledge base JSON"

fragment_categorization:
  by_type:
    - direct_quote
    - paraphrase
    - description
    - example
    - pattern
    - anecdote
    - analysis
  
  by_domain:
    - biographical
    - cognitive
    - communicative
    - behavioral
    - philosophical
    - technical
    - social
    - emotional
  
  by_quality:
    - primary_source
    - secondary_source
    - tertiary_source
    - high_confidence
    - medium_confidence
    - low_confidence

output_formats:
  primary: "JSON (structured knowledge base)"
  secondary: "Markdown (human readable report)"
  supplementary: 
    - "CSV (fragment library)"
    - "YAML (metadata)"
    - "PDF (executive summary)"
