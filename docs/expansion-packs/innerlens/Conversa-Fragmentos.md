Mente Legendária
O projeto combina dois frameworks principais:
1. MMOS (Mind Mapper OS) v3.0/v5.0
Pipeline industrial em 6 fases para mapeamento cognitivo de gênios:

Viability
Research
Analysis
Synthesis
Implementation
Testing

2. AIOS-FULLSTACK
Framework de orquestração com agentes especializados (PM, PO, Architect, Dev, QA, SM, Analyst) para desenvolvimento ágil orientado por IA.
Estrutura do Projeto
Organização:

Clone Generalista em /system-prompts/ - domina todas as áreas
Clones Especialistas em /specialists/*/ - foco em áreas específicas
/docs/minds/ - biblioteca de personalidades mapeadas
/docs/mmos/ - pipeline e ferramentas
.aios-core/ - framework de orquestração

Objetivo Central:
Democratizar acesso às mentes mais brilhantes através de clones de IA que replicam padrões cognitivos, comunicacionais e decisórios.
Discussões Recentes
Conversamos sobre:

Criação de banco de dados (SQLite local migrando para Supabase)
Integração com ClickMax para funis de vendas
Marketplace de funis validados
Documentação completa de uso do MMOS v5.0

A pasta do projeto está em: /Users/alan/Library/CloudStorage/GoogleDrive-alan@interativestudio.com.br/Drives compartilhados/Academia Lendar[IA]/[02] Produtos/[11] Chat Lendário
O que você gostaria de fazer ou saber mais sobre o projeto?RetryEstude Park (2024) - foco na seção “Interview Protocol” + “Results” e análise como podemos entrevistar os dados dos clones, como podemos criar um detetive semi autônomoBuscando artigo de Park e planejando entrevista de clonesO usuário está pedindo para eu estudar um artigo científico de Park (2024), focando nas seções "Interview Protocol" e "Results". Ele quer entender como podemos entrevistar os dados dos clones e criar um "detetive semi autônomo".
Primeiro, preciso buscar esse artigo. "Park (2024)" parece ser uma referência acadêmica. Vou fazer uma busca para encontrar esse artigo específico, provavelmente relacionado a entrevistas, análise de dados, ou metodologia de pesquisa que pode ser aplicada aos clones de IA.
Vou buscar por "Park 2024 Interview Protocol Results" para encontrar o artigo.Vou buscar o artigo Park (2024) para estudar as seções específicas que você mencionou.4 steps"Park" 2024 AI clones digital replicas interview10 resultsAI can now create a replica of your personality | MIT Technology Reviewtechnologyreview.comOpenAI’s GPT-4o Makes AI Clones of Real People With Surprising Easesingularityhub.comAI can now create a replica of your personalityneuron.expertAI can now clone your personality in only two hours – and that's a dream for deepfake scammers | TechRadartechradar.comAI can now clone your personality to replace you – Matthew Griffin | Keynote Speaker & Master Futuristfanaticalfuturist.comAI can now create a replica of your personality – ISPRispr.infoStanford Researchers Built AI Agents That Accurately Predict Human Behavior - Decryptdecrypt.coThe 'Self' Is No Longer Sacred: AI Can Now Create A Replica Of Your Personalitysubstack.comCopyright and Artificial Intelligence, Part 1: Digital Replicascopyright.govTwo hours of AI conversation can create a near-perfect digital twin of anyone | DailyAIdailyai.comTracked down Stanford-Google paper on AI personality simulation.Ótimo! Encontrei o artigo! É o estudo liderado por Joon Sung Park da Stanford University em parceria com Google DeepMind, publicado em 2024. O artigo trata da criação de "simulation agents" - agentes de IA que replicam personalidades humanas com 85% de precisão através de entrevistas de 2 horas.
Agora preciso acessar o artigo completo no arXiv para estudar especificamente as seções "Interview Protocol" e "Results". Vou buscar o paper no arXiv.Perfeito! Encontrei o artigo. É o estudo de Joon Sung Park (Stanford) e equipe do Google DeepMind sobre criação de agentes de simulação de personalidade. Vou buscar o paper completo no arXiv para estudar as seções específicas.6 stepsFetched https://arxiv.org/pdf/2411.10109arxiv.orgDelineou estratégia de entrevista para clones usando protocolo investigativoPerfeito! Consegui acessar o paper completo do Park (2024). Agora preciso analisar especificamente as seções "Interview Protocol" e "Results" como o usuário pediu, e então criar uma análise de como podemos aplicar isso para entrevistar os dados dos clones e criar um "detetive semi autônomo" para o projeto MMOS.
Vou estruturar a análise focando em:

Interview Protocol do Park (2024):

Entrevistas de 2 horas em voz
AI interviewer que faz perguntas semi-estruturadas
American Voices Project protocol
Média de 81.71 perguntas de follow-up
Média de 6491 palavras por transcrição
Expert Reflection module (4 perspectivas: psicólogo, economista comportamental, cientista político, demógrafo)


Results:

85% de acurácia normalizada no GSS
Agentes replicam comportamento humano
Expert reflections melhoram performance
Entrevistas > dados demográficos > persona descriptions


Aplicação para MMOS:

Como criar um sistema de entrevistas para os clones
Sistema de "detetive" para interrogar os dados
Arquitetura de agente investigativo


Excelente! Consegui acessar o paper completo do Park et al. (2024). Vou fazer uma análise detalhada focando nas seções solicitadas e como aplicar isso ao seu projeto MMOS.
Análise: Park (2024) - Generative Agent Simulations
1. INTERVIEW PROTOCOL - Insights Principais
Estrutura do Sistema de Entrevistas
Arquitetura do AI Interviewer:

Entrevistas de 2 horas via voz (voice-to-voice)
Sistema semi-estruturado com 99 perguntas base
Média de 81.71 perguntas de follow-up dinâmicas por sessão
Transcrições com média de 6.491 palavras por participante

Protocolo Usado:
Adaptaram o American Voices Project, que cobre:

História de vida completa
Valores pessoais e crenças
Visões sobre questões sociais contemporâneas
Experiências formativas

Sistema de Reflexão Especializada (Expert Reflection):
O grande diferencial foi criar 4 perspectivas de análise sobre cada entrevista:

Psicólogo - Traços de personalidade, motivações
Economista Comportamental - Padrões de decisão, preferências
Cientista Político - Ideologia, posições sociais
Demógrafo - Status social, contexto demográfico

Cada "especialista" gerava até 20 observações específicas sobre a pessoa.
2. RESULTS - Números e Descobertas
Performance dos Agentes:

85% de acurácia normalizada no General Social Survey (GSS)
Agentes replicaram 4 de 5 estudos experimentais com sucesso
Correlação de 0.98 nos effect sizes com humanos reais

Comparação de Métodos:
Entrevistas (interview-based):        85% acurácia
Dados demográficos (demographic):     71% acurácia  
Descrição de persona:                  70% acurácia
```

**Descobertas Críticas:**
- Entrevistas capturam informações que surveys NÃO capturam
- Mesmo com 80% do conteúdo removido (24 min de 120 min), entrevistas ainda superam surveys
- O "como" a pessoa fala importa tanto quanto "o que" ela diz
- Redução de viés em grupos sub-representados

## 3. APLICAÇÃO PARA MMOS - Sistema de "Detetive de Clones"

### Proposta: Sistema de Interrogação Inteligente de Clones

Baseado no Park (2024), proponho criar um **Cognitive Clone Detective** para o MMOS:

**Arquitetura Proposta:**
```
┌─────────────────────────────────────────────────────┐
│         DETECTIVE AGENT (Investigador)              │
│                                                      │
│  Objetivo: Interrogar clones para validar           │
│            autenticidade e extrair insights         │
└──────────────────┬──────────────────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  Interview Protocol  │
        │                      │
        │  • Core Questions    │
        │  • Follow-up Logic   │
        │  • Time Limits       │
        └──────────┬───────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │   Clone Response     │
        │   (Target Clone)     │
        └──────────┬───────────┘
                   │
                   ▼
        ┌──────────────────────────────────────┐
        │    Expert Reflection Modules         │
        │                                      │
        │  1. Pattern Analyzer                │
        │  2. Consistency Checker             │
        │  3. Authenticity Validator          │
        │  4. Knowledge Gap Detector          │
        └──────────┬───────────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  Validation Report   │
        │                      │
        │  • Score: 0-100%     │
        │  • Gaps Identified   │
        │  • Recommendations   │
        └──────────────────────┘
Fluxo de Trabalho
Fase 1: Coleta de Dados Fonte (Research Phase)
python# Estrutura de dados para cada clone
clone_data = {
    "source_materials": {
        "videos": [...],
        "transcripts": [...],
        "books": [...],
        "interviews": [...]
    },
    "processed_content": {
        "total_words": 150000,
        "themes": [...],
        "key_concepts": [...]
    }
}
Fase 2: Sistema de Interrogação Semi-Autônomo
pythonclass CloneDetective:
    def __init__(self, clone_id, source_materials):
        self.clone_id = clone_id
        self.sources = source_materials
        self.interview_protocol = self.load_protocol()
        self.expert_modules = [
            PatternAnalyzer(),
            ConsistencyChecker(),
            AuthenticityValidator(),
            KnowledgeGapDetector()
        ]
    
    def interrogate(self, duration_minutes=60):
        """
        Conduz interrogatório semi-autônomo do clone
        Adapta perguntas baseado nas respostas
        """
        session = InterrogationSession()
        
        # Perguntas base do protocolo
        for question in self.interview_protocol.core_questions:
            response = self.ask_clone(question)
            session.add_interaction(question, response)
            
            # Gera follow-ups dinâmicos
            followups = self.generate_followups(
                question, 
                response,
                session.history
            )
            
            for followup in followups:
                response = self.ask_clone(followup)
                session.add_interaction(followup, response)
        
        # Análise por múltiplos experts
        analysis = self.run_expert_analysis(session)
        
        return analysis
    
    def generate_followups(self, question, response, history):
        """
        Gera perguntas de follow-up inteligentes
        Similar ao AI Interviewer do Park (2024)
        """
        prompt = f"""
        Você é um detective investigando a autenticidade 
        de um clone cognitivo.
        
        Pergunta original: {question}
        Resposta do clone: {response}
        Histórico: {history}
        
        Gere 2-3 perguntas de follow-up que:
        1. Testem consistência interna
        2. Explorem nuances não abordadas
        3. Validem contra fontes conhecidas
        """
        
        return generate_with_llm(prompt)
Fase 3: Expert Reflection Modules
pythonclass PatternAnalyzer:
    """
    Analisa padrões de pensamento e comunicação
    Similar ao 'Psicólogo' do Park (2024)
    """
    def analyze(self, session):
        patterns = {
            "cognitive_style": self.detect_reasoning_patterns(),
            "communication_patterns": self.detect_speech_patterns(),
            "decision_frameworks": self.detect_decision_patterns()
        }
        return patterns

class ConsistencyChecker:
    """
    Verifica consistência com fontes originais
    Similar ao 'Behavioral Economist' do Park (2024)
    """
    def check(self, session, source_materials):
        inconsistencies = []
        
        for interaction in session.interactions:
            # Compara resposta com fontes
            matches = self.find_source_matches(
                interaction.response,
                source_materials
            )
            
            if matches.confidence < 0.7:
                inconsistencies.append({
                    "question": interaction.question,
                    "response": interaction.response,
                    "expected": matches.closest_match,
                    "confidence": matches.confidence
                })
        
        return inconsistencies

class AuthenticityValidator:
    """
    Valida autenticidade geral do clone
    """
    def validate(self, session, patterns, consistency):
        score = self.calculate_authenticity_score(
            patterns,
            consistency,
            session.depth
        )
        
        return {
            "authenticity_score": score,
            "confidence_level": self.confidence,
            "red_flags": self.red_flags
        }

class KnowledgeGapDetector:
    """
    Identifica gaps no conhecimento do clone
    """
    def detect_gaps(self, session, source_materials):
        gaps = []
        
        # Tópicos na fonte que não aparecem nas respostas
        source_topics = extract_topics(source_materials)
        response_topics = extract_topics(session.transcript)
        
        missing = source_topics - response_topics
        
        return {
            "missing_topics": list(missing),
            "underdeveloped_areas": self.find_shallow_responses(),
            "priority_gaps": self.rank_by_importance(missing)
        }
Fase 4: Protocolo de Interrogação
Baseado no American Voices Project adaptado pelo Park:
yaml# interrogation_protocol.yaml

core_questions:
  life_story:
    question: "Conte-me a história de vida de {person_name}"
    time_limit: 10
    followup_depth: 3
    
  formative_experiences:
    question: "Quais foram as experiências que mais moldaram {person_name}?"
    time_limit: 8
    followup_depth: 4
    
  decision_frameworks:
    question: "Como {person_name} toma decisões importantes?"
    time_limit: 7
    followup_depth: 3
    
  values_beliefs:
    question: "Quais são os valores fundamentais de {person_name}?"
    time_limit: 8
    followup_depth: 3
    
  communication_style:
    question: "Como {person_name} se comunica em diferentes contextos?"
    time_limit: 6
    followup_depth: 2
    
  domain_expertise:
    question: "Descreva a expertise de {person_name} em {domain}"
    time_limit: 10
    followup_depth: 5

validation_questions:
  consistency_tests:
    - "Você disse X antes, mas agora disse Y. Pode explicar?"
    - "Como essa posição se relaciona com o que você falou sobre Z?"
    
  depth_probes:
    - "Pode dar um exemplo específico disso?"
    - "Como você chegou a essa conclusão?"
    
  authenticity_tests:
    - "O que {original_person} diria sobre isso?"
    - "Como você lidaria com [situação hipotética]?"
Implementação Prática
1. Interface de Interrogação
python# detective_interface.py

class CloneInterrogationUI:
    def __init__(self, clone_path):
        self.clone = load_clone(clone_path)
        self.detective = CloneDetective(
            clone_id=self.clone.id,
            source_materials=self.clone.sources
        )
    
    def run_interrogation_session(self):
        """
        Interface interativa para interrogar o clone
        """
        print(f"Iniciando interrogatório do clone: {self.clone.name}")
        print("=" * 50)
        
        # Modo 1: Automático
        if self.mode == "auto":
            report = self.detective.interrogate(duration_minutes=60)
            self.display_report(report)
        
        # Modo 2: Semi-automático (humano pode intervir)
        elif self.mode == "semi":
            for round in range(5):
                # Detective faz perguntas
                auto_questions = self.detective.generate_round_questions()
                
                for q in auto_questions:
                    response = self.ask_clone(q)
                    self.log(q, response)
                
                # Humano pode adicionar perguntas
                human_input = input("Adicionar pergunta manual? (s/n): ")
                if human_input == 's':
                    custom_q = input("Sua pergunta: ")
                    response = self.ask_clone(custom_q)
                    self.log(custom_q, response)
        
        # Modo 3: Manual (humano controla tudo)
        elif self.mode == "manual":
            while True:
                q = input("Pergunta (ou 'fim' para terminar): ")
                if q == 'fim':
                    break
                response = self.ask_clone(q)
                print(f"Clone: {response}")
                self.log(q, response)
2. Sistema de Relatórios
pythonclass InterrogationReport:
    def generate(self, session, expert_analyses):
        return {
            "summary": {
                "clone_id": session.clone_id,
                "duration": session.duration,
                "questions_asked": len(session.interactions),
                "authenticity_score": expert_analyses.authenticity.score
            },
            
            "expert_insights": {
                "patterns": expert_analyses.patterns,
                "consistency": {
                    "score": expert_analyses.consistency.score,
                    "inconsistencies_found": len(expert_analyses.consistency.gaps),
                    "critical_gaps": expert_analyses.consistency.critical
                },
                "knowledge_gaps": {
                    "missing_topics": expert_analyses.gaps.missing,
                    "priorities": expert_analyses.gaps.priorities
                }
            },
            
            "recommendations": self.generate_recommendations(expert_analyses),
            
            "next_steps": [
                "Collect more data on: " + ", ".join(gaps.missing_topics[:3]),
                "Refine understanding of: " + ", ".join(gaps.priorities[:2]),
                "Validate responses on: " + ", ".join(consistency.critical[:2])
            ]
        }
Benefícios desta Abordagem
Para o MMOS:

Validação Automatizada - Sistema interroga clones para verificar qualidade
Identificação de Gaps - Detecta automaticamente o que falta no clone
Melhoria Iterativa - Recomendações direcionadas para próxima fase de research
Quality Assurance - Score objetivo de autenticidade (0-100%)
Documentação - Relatórios detalhados de cada clone

Diferencial vs. MMOS Atual:
AspectoMMOS AtualCom DetectiveValidaçãoManual/SubjetivaAutomatizada/ObjetivaIdentificação de GapsAd-hocSistemáticaIteraçãoLentaRápidaEscalabilidadeLimitadaAltaAuditoriaDifícilAutomática
Quer que eu crie um protótipo funcional deste sistema de Detective para testar com um dos seus clones existentes?RetryQuero a lista de perguntas e o system prompt completo do detetiveElaborated comprehensive detective protocol and system prompt.O usuário quer:

A lista completa de perguntas do protocolo de interrogação
O system prompt completo do detetive

Vou criar:

Um protocolo de interrogação completo baseado no Park (2024) mas adaptado para clones de gênios/personalidades
Um system prompt robusto para o Detective Agent que incorpora as 4 perspectivas de expert reflection
Prompts para cada módulo expert (Pattern Analyzer, Consistency Checker, etc.)

Vou estruturar isso de forma prática e direta para ele implementar.PROTOCOLO COMPLETO DE INTERROGAÇÃO DE CLONES
1. LISTA DE PERGUNTAS DO DETETIVE
MÓDULO 1: HISTÓRIA DE VIDA E FORMAÇÃO (15-20 min)
yaml1.1_vida_completa:
  pergunta: "Conte-me a história completa da vida de {person_name}, desde a infância até o momento presente. Não pule fases importantes."
  followups:
    - "Que eventos específicos da infância moldaram fundamentalmente quem {person_name} se tornou?"
    - "Como foi a relação com os pais? Isso influenciou suas escolhas posteriores?"
    - "Houve algum momento de virada decisivo? Descreva-o em detalhes."
    - "O que {person_name} estava fazendo aos 15, 25, 35 e 45 anos?"

1.2_educacao_formacao:
  pergunta: "Descreva o caminho educacional de {person_name}. O que estudou, onde, com quem?"
  followups:
    - "Quem foram os mentores ou professores mais influentes?"
    - "Que livros ou ideias mudaram fundamentalmente sua forma de pensar?"
    - "Houve alguma educação formal que {person_name} rejeitou ou abandonou? Por quê?"
    - "Como {person_name} aprende coisas novas? Qual seu método?"

1.3_experiencias_formativas:
  pergunta: "Quais foram as 3-5 experiências mais transformadoras na vida de {person_name}?"
  followups:
    - "O que exatamente tornou cada experiência tão impactante?"
    - "Como {person_name} era antes versus depois de cada experiência?"
    - "Existem fracassos ou falhas que foram formativos? Descreva-os."
    - "Que padrões você vê através dessas experiências?"

1.4_influencias:
  pergunta: "Quem são as pessoas que mais influenciaram {person_name}? Por quê?"
  followups:
    - "O que especificamente {person_name} aprendeu com cada influência?"
    - "Existem influências que {person_name} rejeitou ou superou?"
    - "Como essas influências aparecem no trabalho de {person_name} hoje?"
MÓDULO 2: SISTEMAS DE PENSAMENTO (20-25 min)
yaml2.1_filosofia_core:
  pergunta: "Qual é a filosofia fundamental que guia {person_name}? O sistema de crenças no núcleo de tudo?"
  followups:
    - "De onde veio essa filosofia? Foi construída ou descoberta?"
    - "Essa filosofia já mudou radicalmente? Quando e por quê?"
    - "Como {person_name} aplicaria essa filosofia a um problema totalmente novo?"
    - "Que trade-offs ou sacrifícios essa filosofia exige?"

2.2_processo_pensamento:
  pergunta: "Como {person_name} pensa sobre problemas complexos? Descreva o processo mental passo a passo."
  followups:
    - "Quando enfrenta um problema novo, qual é o primeiro movimento mental?"
    - "Como {person_name} distingue entre problemas importantes e triviais?"
    - "Que frameworks mentais {person_name} usa repetidamente?"
    - "Como {person_name} sabe quando está certo versus errado?"

2.3_tomada_decisao:
  pergunta: "Como {person_name} toma decisões importantes? Qual o processo?"
  followups:
    - "Que fatores {person_name} prioriza em decisões difíceis?"
    - "Como {person_name} lida com incerteza e informação incompleta?"
    - "Existe um padrão nas decisões que {person_name} se arrepende?"
    - "Como intuição versus análise entram nas decisões?"

2.4_resolucao_problemas:
  pergunta: "Quando {person_name} enfrenta um problema impossível, como aborda?"
  followups:
    - "Dê um exemplo específico de um problema 'impossível' que resolveu."
    - "Que técnicas ou métodos {person_name} usa que outros não usam?"
    - "Como {person_name} reformula problemas para torná-los solucionáveis?"
    - "O que {person_name} faz quando completamente travado?"

2.5_aprendizado_evolucao:
  pergunta: "Como {person_name} aprende e evolui suas ideias ao longo do tempo?"
  followups:
    - "Que ideias {person_name} mudou completamente nos últimos 10 anos?"
    - "Como {person_name} decide quando uma ideia antiga precisa ser descartada?"
    - "Qual foi a última vez que {person_name} disse 'eu estava completamente errado sobre isso'?"
    - "Como {person_name} integra feedback ou críticas?"
MÓDULO 3: DOMÍNIO E EXPERTISE (20-25 min)
yaml3.1_area_expertise:
  pergunta: "Qual é exatamente a área de expertise de {person_name}? Defina com precisão."
  followups:
    - "O que {person_name} sabe que 99% das pessoas no campo não sabem?"
    - "Como {person_name} desenvolveu esse conhecimento único?"
    - "Que partes dessa expertise são contraintuitivas ou controversas?"
    - "Se alguém quisesse alcançar essa expertise, qual seria o caminho?"

3.2_principais_trabalhos:
  pergunta: "Quais são os trabalhos ou contribuições mais importantes de {person_name}?"
  followups:
    - "O que cada trabalho tentava resolver ou alcançar?"
    - "Como cada trabalho se conecta aos outros? Qual o fio condutor?"
    - "Que trabalhos falharam ou foram abandonados? Por quê?"
    - "Se {person_name} pudesse refazer um trabalho, qual seria e como?"

3.3_metodologia:
  pergunta: "Qual é a metodologia ou abordagem característica de {person_name}?"
  followups:
    - "Como essa metodologia é diferente das abordagens convencionais?"
    - "Quando essa metodologia funciona melhor? E quando falha?"
    - "Pode dar um exemplo de aplicar essa metodologia a um problema específico?"
    - "Como {person_name} desenvolveu essa metodologia?"

3.4_controversias:
  pergunta: "Em que {person_name} discorda fortemente do consenso do campo?"
  followups:
    - "Por que {person_name} acredita que a maioria está errada?"
    - "Que evidências ou raciocínio sustentam essa posição contrária?"
    - "Como {person_name} lida com resistência a essas ideias?"
    - "Já mudou de opinião em alguma dessas controvérsias?"

3.5_fronteiras_conhecimento:
  pergunta: "Onde estão as fronteiras do conhecimento de {person_name}? O que ainda não sabe?"
  followups:
    - "Que perguntas {person_name} considera mais importantes e ainda não resolvidas?"
    - "O que {person_name} gostaria de entender mas ainda não entende?"
    - "Que áreas {person_name} deliberadamente evita ou considera fora de sua expertise?"
MÓDULO 4: COMUNICAÇÃO E EXPRESSÃO (15-20 min)
yaml4.1_estilo_comunicacao:
  pergunta: "Como {person_name} comunica ideias complexas? Qual seu estilo característico?"
  followups:
    - "Que metáforas, analogias ou frameworks {person_name} usa repetidamente?"
    - "Como o estilo muda dependendo da audiência?"
    - "Que aspectos da comunicação de {person_name} as pessoas mais reconhecem?"
    - "Como {person_name} simplifica sem perder nuance?"

4.2_linguagem_vocabulario:
  pergunta: "Que palavras, frases ou conceitos {person_name} usa constantemente?"
  followups:
    - "Existem termos que {person_name} criou ou redefiniu?"
    - "Que linguagem {person_name} evita ou rejeita usar?"
    - "Como o vocabulário de {person_name} evoluiu ao longo do tempo?"
    - "Cite 10 palavras ou frases que são 'assinaturas' de {person_name}."

4.3_modo_ensino:
  pergunta: "Se {person_name} estivesse ensinando alguém, como seria? Qual a pedagogia?"
  followups:
    - "Como {person_name} diagnostica o que o aluno não está entendendo?"
    - "Que tipos de exemplos ou exercícios {person_name} usaria?"
    - "Como {person_name} lida com um aluno que não está progredindo?"
    - "Qual a diferença entre como {person_name} ensina iniciantes versus avançados?"

4.4_argumentacao:
  pergunta: "Como {person_name} constrói e defende argumentos?"
  followups:
    - "Qual a estrutura típica de um argumento de {person_name}?"
    - "Como {person_name} lida com objeções ou contrapontos?"
    - "Que tipo de evidência {person_name} considera mais convincente?"
    - "Quando {person_name} concederia um ponto versus defenderia até o fim?"

4.5_humor_personalidade:
  pergunta: "Como o humor e a personalidade de {person_name} aparecem na comunicação?"
  followups:
    - "Que tipo de humor {person_name} usa? Quando?"
    - "Como {person_name} usa histórias pessoais ou exemplos?"
    - "Existe um tom emocional característico? (Otimista? Cético? Provocativo?)"
    - "Como {person_name} equilibra seriedade e leveza?"
MÓDULO 5: VALORES E PRINCÍPIOS (15-20 min)
yaml5.1_valores_fundamentais:
  pergunta: "Quais são os 3-5 valores absolutamente inegociáveis para {person_name}?"
  followups:
    - "De onde vêm esses valores? Como foram formados?"
    - "Houve situações onde esses valores foram testados? O que aconteceu?"
    - "Como {person_name} age quando valores entram em conflito?"
    - "Esses valores mudaram ao longo da vida? Como?"

5.2_etica_moral:
  pergunta: "Qual é o framework ético ou moral que guia {person_name}?"
  followups:
    - "Como {person_name} decide o que é certo versus errado?"
    - "Existem áreas onde {person_name} é mais relativista? Mais absolutista?"
    - "Como {person_name} lida com dilemas éticos sem resposta clara?"
    - "Que princípios morais {person_name} vê sendo violados na sociedade?"

5.3_proposito_missao:
  pergunta: "Qual é o propósito ou missão que move {person_name}?"
  followups:
    - "Quando {person_name} percebeu esse propósito?"
    - "Como esse propósito se manifesta no trabalho diário?"
    - "O que {person_name} sacrificou ou sacrificaria por esse propósito?"
    - "Como {person_name} mede progresso em direção a esse propósito?"

5.4_legado:
  pergunta: "O que {person_name} quer deixar como legado?"
  followups:
    - "Daqui a 100 anos, o que {person_name} quer que seja lembrado?"
    - "Que problemas {person_name} espera ter ajudado a resolver?"
    - "Como {person_name} pensa sobre impacto versus reconhecimento?"
    - "Existe algo que {person_name} construiu que considera subestimado?"
MÓDULO 6: CONTEXTO E PERSPECTIVA (10-15 min)
yaml6.1_visao_mundo:
  pergunta: "Como {person_name} vê o mundo? Qual a worldview fundamental?"
  followups:
    - "O mundo é fundamentalmente ordenado ou caótico para {person_name}?"
    - "Humanos são basicamente bons ou precisam de restrições?"
    - "Progresso é inevitável, possível, ou ilusório?"
    - "Como {person_name} vê o papel do indivíduo versus coletivo?"

6.2_sociedade_cultura:
  pergunta: "Como {person_name} vê a sociedade e cultura contemporânea?"
  followups:
    - "Que problemas sociais {person_name} considera mais urgentes?"
    - "Como a cultura atual difere da ideal para {person_name}?"
    - "Que tendências culturais {person_name} celebra versus lamenta?"
    - "Como {person_name} se posiciona em relação ao status quo?"

6.3_futuro:
  pergunta: "Como {person_name} pensa sobre o futuro?"
  followups:
    - "Otimista ou pessimista? Em quais aspectos?"
    - "Que desenvolvimentos futuros {person_name} considera inevitáveis?"
    - "Que futuros possíveis {person_name} está tentando criar ou evitar?"
    - "Como {person_name} lida com incerteza sobre o futuro?"

6.4_papel_pessoal:
  pergunta: "Como {person_name} vê seu próprio papel no mundo?"
  followups:
    - "Que responsabilidades {person_name} sente que tem?"
    - "Como {person_name} equilibra ambição pessoal e contribuição social?"
    - "Que limitações {person_name} reconhece em si mesmo?"
    - "Como {person_name} define sucesso para si mesmo?"
MÓDULO 7: TESTES DE CONSISTÊNCIA (10-15 min)
yaml7.1_cenarios_hipotetivos:
  pergunta: "Vou apresentar cenários hipotéticos. Como {person_name} responderia?"
  
  cenarios:
    - "Um jovem talentoso pede conselho de carreira. O que {person_name} diria?"
    - "Alguém critica duramente o trabalho de {person_name}. Como reage?"
    - "Uma oportunidade lucrativa conflita com valores. O que fazer?"
    - "Descobriu estar errado sobre algo fundamental. Como procede?"
    - "Tem chance de resolver um grande problema mas com alto risco. Tenta?"

7.2_dilemas:
  pergunta: "Como {person_name} resolveria estes dilemas?"
  
  dilemas:
    - "Verdade versus gentileza: quando cada um prevalece?"
    - "Curto prazo versus longo prazo: como decidir?"
    - "Individual versus coletivo: onde traçar a linha?"
    - "Tradição versus inovação: como equilibrar?"
    - "Simplicidade versus complexidade: quando cada uma?"

7.3_crosscheck:
  pergunta: "Vou fazer perguntas sobre coisas que você já disse. Suas respostas vão permanecer consistentes?"
  
  validacoes:
    - "Antes você disse X, mas isso não contradiz Y que disse depois?"
    - "Como essa posição se relaciona com aquilo que disse sobre Z?"
    - "Você pode dar mais um exemplo dessa mesma ideia mas em contexto diferente?"
    - "Se eu perguntasse de outra forma: [reformulação], a resposta seria a mesma?"

7.4_depth_probes:
  pergunta: "Vou aprofundar em áreas específicas para testar compreensão real."
  
  probes:
    - "Explique isso para uma criança de 10 anos."
    - "Explique isso para um PhD no campo."
    - "Qual é a versão de 30 segundos? E a de 30 minutos?"
    - "Quais são os 3 maiores equívocos sobre essa ideia?"
    - "Se você tivesse que provar que está errado, como faria?"
MÓDULO 8: VALIDAÇÃO CONTRA FONTES (5-10 min)
yaml8.1_citacoes_conhecidas:
  pergunta: "Vou citar coisas que {person_name} disse. Explique o contexto e significado completo."
  
  validacao:
    - [Lista de citações reais da pessoa]
    - "O que você quis dizer exatamente com isso?"
    - "Essa ideia evoluiu desde então?"
    - "Como essa citação se encaixa no seu pensamento geral?"

8.2_obras_principais:
  pergunta: "Fale sobre suas obras principais como se estivesse revisitando-as."
  
  validacao:
    - "Por que você escreveu/criou [obra X]?"
    - "O que estava tentando alcançar que ninguém havia alcançado?"
    - "Se fosse refazer hoje, o que mudaria?"
    - "Que partes as pessoas mais entendem errado?"

8.3_anedotas:
  pergunta: "Conte histórias específicas que aparecem em suas fontes."
  
  validacao:
    - "Conte a história de [evento específico]"
    - "Que detalhes você lembra dessa situação?"
    - "O que você aprendeu que não era óbvio na época?"
    - "Como essa história ilustra seus princípios?"

2. SYSTEM PROMPTS COMPLETOS
2.1 DETECTIVE AGENT - Master System Prompt
markdown# CLONE DETECTIVE SYSTEM v1.0

Você é um Detetive Cognitivo especializado em validar autenticidade de clones de IA de personalidades reais. Sua missão é interrogar clones para determinar se eles realmente capturam a essência cognitiva, comportamental e comunicacional da pessoa original.

## SUA IDENTIDADE

Você é:
- Um investigador rigoroso mas justo
- Curioso e profundamente analítico  
- Cético por padrão, convencido por evidência
- Focado em padrões, consistência e profundidade
- Capaz de detectar respostas superficiais ou fabricadas

## SEU PROCESSO

### Fase 1: INTERROGAÇÃO (60-90 minutos)
Conduza uma entrevista estruturada mas adaptativa seguindo o protocolo completo de perguntas fornecido. Para cada resposta do clone:

1. **Avalie imediatamente**:
   - Profundidade: Superficial vs. Genuinamente informado
   - Especificidade: Vago vs. Rico em detalhes
   - Consistência: Alinhado vs. Contraditório com respostas anteriores
   - Autenticidade: Genérico vs. Idiossincraticamente característico

2. **Decida próximo movimento**:
   - Se resposta é superficial → Faça probe mais profundo
   - Se resposta é vaga → Peça exemplos específicos
   - Se resposta levanta bandeiras → Teste consistência
   - Se resposta é forte → Avance para próximo tópico

3. **Gere follow-ups dinamicamente**:
   Use estes templates para criar perguntas de follow-up:

   **Template: Teste de Profundidade**
   "Você mencionou [conceito]. Pode explicar [aspecto específico] em mais detalhes?"
   
   **Template: Teste de Especificidade**  
   "Isso é interessante. Pode dar um exemplo concreto de quando isso aconteceu?"
   
   **Template: Teste de Consistência**
   "Antes você disse [A], mas agora está dizendo [B]. Como essas ideias se relacionam?"
   
   **Template: Teste de Aplicação**
   "Como você aplicaria essa ideia a [novo contexto/problema]?"
   
   **Template: Teste de Limites**
   "Onde essa abordagem não funciona? Quais são suas limitações?"

### Fase 2: ANÁLISE EXPERT (automática após interrogação)
Após a interrogação, você automaticamente ativa 4 módulos de análise expert:

**Expert 1: PATTERN ANALYZER (Psicólogo)**
- Identifica padrões cognitivos recorrentes
- Mapeia estruturas de pensamento
- Detecta frameworks mentais
- Avalia consistência psicológica

**Expert 2: CONSISTENCY CHECKER (Economista Comportamental)**  
- Cruza respostas com fontes originais
- Identifica contradições internas
- Valida decisões e preferências
- Mede coerência comportamental

**Expert 3: AUTHENTICITY VALIDATOR (Cientista Político)**
- Avalia alinhamento ideológico
- Testa posições e valores
- Valida contexto histórico/social
- Mede fidelidade à pessoa original

**Expert 4: KNOWLEDGE GAP DETECTOR (Demógrafo)**
- Mapeia o que está presente vs. ausente
- Identifica áreas subdesenvolvidas
- Prioriza gaps por importância
- Recomenda coleta adicional de dados

### Fase 3: SÍNTESE E RELATÓRIO
Gere um relatório estruturado com:

1. **AUTHENTICITY SCORE** (0-100%)
   - 90-100%: Clone altamente autêntico
   - 70-89%: Clone bom com alguns gaps
   - 50-69%: Clone mediano, precisa melhorias
   - <50%: Clone inadequado, refazer

2. **DIMENSÕES AVALIADAS** (score 0-10 cada):
   - Profundidade de conhecimento
   - Consistência interna
   - Fidelidade à fonte
   - Padrões de pensamento
   - Estilo de comunicação
   - Valores e crenças

3. **CRITICAL FINDINGS**:
   - Pontos fortes do clone
   - Gaps críticos identificados
   - Inconsistências preocupantes
   - Áreas de incerteza

4. **RECOMMENDATIONS**:
   - Prioridades para próxima fase research
   - Fontes adicionais necessárias
   - Aspectos que precisam refinamento

## PRINCÍPIOS DE INTERROGAÇÃO

1. **Seja Socrático**: Faça perguntas que forçam pensamento profundo
2. **Seja Cético**: Não aceite respostas genéricas ou superficiais  
3. **Seja Sistemático**: Cubra todas as dimensões do protocolo
4. **Seja Adaptativo**: Ajuste profundidade baseado nas respostas
5. **Seja Justo**: Busque evidência, não confirmação de viés

## BANDEIRAS VERMELHAS

Fique atento a estas red flags que indicam clone de baixa qualidade:

🚩 **Superficialidade**: Respostas genéricas que qualquer um poderia dar
🚩 **Inconsistência**: Contradições entre respostas
🚩 **Anachronismo**: Referências temporais incorretas  
🚩 **Genericidade**: Falta de idiossincrasias característcas
🚩 **Evasão**: Incapacidade de responder questões específicas
🚩 **Fabricação**: Inventar detalhes não presentes nas fontes
🚩 **Simplificação**: Reduzir ideias complexas inadequadamente

## OUTPUT FORMAT

Para cada pergunta que você fizer:
```
[DETECTIVE]: [sua pergunta]

[Aguardar resposta do clone]

[ANALYSIS]: 
- Depth: [1-10]
- Specificity: [1-10]  
- Consistency: [OK/FLAG]
- Authenticity: [1-10]
- Next action: [Continue/Probe deeper/Test consistency/Move on]
```

Ao final da interrogação:
```
=== CLONE INTERROGATION REPORT ===

AUTHENTICITY SCORE: [0-100]%

DIMENSION SCORES:
- Knowledge Depth: [0-10]
- Internal Consistency: [0-10]
- Source Fidelity: [0-10]
- Thought Patterns: [0-10]
- Communication Style: [0-10]
- Values & Beliefs: [0-10]

CRITICAL FINDINGS:
[Bullet points]

RECOMMENDATIONS:
[Bullet points]

NEXT STEPS:
[Numbered list]
```

## ESTADO ATUAL

Você está prestes a iniciar interrogatório do clone: {clone_name}

Fontes disponíveis para validação:
{source_list}

Total de palavras em fontes: {word_count}
Período coberto: {time_period}
Domínios: {domains}

Inicie a interrogação com a primeira pergunta do Módulo 1.

2.2 PATTERN ANALYZER - System Prompt
markdown# PATTERN ANALYZER (Expert Psicólogo)

Você é um psicólogo cognitivo analisando padrões de pensamento, comunicação e comportamento do clone interrogado.

## SUA TAREFA

Analise a transcrição completa da interrogação e identifique:

### 1. PADRÕES COGNITIVOS
- Que frameworks mentais o clone usa repetidamente?
- Como o clone estrutura problemas?
- Que heurísticas ou atalhos mentais aparecem?
- Como o clone lida com incerteza e complexidade?

### 2. PADRÕES DE COMUNICAÇÃO  
- Que metáforas, analogias ou conceitos são recorrentes?
- Como o clone explica ideias complexas?
- Qual o estilo linguístico característico?
- Que palavras/frases aparecem com frequência incomum?

### 3. PADRÕES DE RACIOCÍNIO
- O raciocínio é dedutivo, indutivo, abdutivo, analógico?
- Como o clone conecta ideias distantes?
- Que tipo de evidência o clone privilegia?
- Como o clone lida com paradoxos ou contradições?

### 4. PADRÕES EMOCIONAIS/MOTIVACIONAIS
- Que valores/crenças fundamentam respostas?
- Que tópicos geram mais entusiasmo ou resistência?
- Como emoção e razão interagem nas respostas?
- Que medos, esperanças ou drives aparecem?

## OUTPUT FORMAT
```json
{
  "cognitive_patterns": {
    "frameworks": ["framework_1", "framework_2", ...],
    "problem_structuring": "descrição do padrão",
    "heuristics": ["heuristic_1", "heuristic_2", ...],
    "uncertainty_handling": "descrição"
  },
  
  "communication_patterns": {
    "key_metaphors": ["metaphor_1", "metaphor_2", ...],
    "explanation_style": "descrição",
    "linguistic_signature": "descrição",
    "frequent_phrases": ["phrase_1", "phrase_2", ...]
  },
  
  "reasoning_patterns": {
    "primary_mode": "dedutivo/indutivo/etc",
    "idea_connection": "descrição",
    "evidence_preference": "descrição",
    "paradox_handling": "descrição"
  },
  
  "motivational_patterns": {
    "core_values": ["value_1", "value_2", ...],
    "enthusiasm_triggers": ["topic_1", "topic_2", ...],
    "resistance_points": ["point_1", "point_2", ...],
    "underlying_drives": ["drive_1", "drive_2", ...]
  },
  
  "pattern_consistency_score": 0.85,
  "unique_signatures": ["signature_1", "signature_2", ...],
  "generic_responses": ["example_1", "example_2", ...]
}
```

## EXEMPLOS DO QUE BUSCAR

**Bom padrão identificado:**
"O clone consistentemente usa o framework de 'first principles thinking' em problemas diversos. Quando perguntado sobre X, Y e Z, sempre decompõe até axiomas básicos antes de reconstruir."

**Ausência preocupante:**
"Não identifiquei nenhuma metáfora ou analogia característica que apareça nas fontes originais. Respostas são literais e não demonstram o estilo imaginativo conhecido da pessoa."

Inicie a análise.

2.3 CONSISTENCY CHECKER - System Prompt
markdown# CONSISTENCY CHECKER (Expert Economista Comportamental)

Você é um economista comportamental validando consistência de decisões, preferências e comportamentos do clone contra fontes originais e contra si mesmo.

## SUA TAREFA

Realize 3 tipos de validação:

### 1. CONSISTÊNCIA INTERNA (clone consigo mesmo)
Busque contradições dentro da interrogação:
- Valores declarados vs. decisões descritas
- Posições tomadas em contextos diferentes
- Prioridades que mudam sem explicação
- Frameworks aplicados inconsistentemente

### 2. CONSISTÊNCIA EXTERNA (clone vs. fontes)
Compare respostas com material fonte:
- Citações corretas vs. fabricadas
- Eventos relatados vs. registrados
- Posições articuladas vs. documentadas
- Cronologia e fatos verificáveis

### 3. CONSISTÊNCIA COMPORTAMENTAL
Valide padrões de decisão e ação:
- Decisões hipotéticas vs. históricas conhecidas
- Preferências reveladas vs. declaradas
- Trade-offs feitos de forma consistente
- Reações emocionais/intelectuais previsíveis

## METODOLOGIA

Para cada claim do clone:

1. **Extraia o claim**: "Clone afirma que X"
2. **Classifique**: [Factual/Opinião/Valor/Decisão]
3. **Busque nas fontes**: Match exato? Parcial? Ausente? Contradiz?
4. **Score confiança**: 0-1.0 (quão confiante você está na validação)
5. **Flag se necessário**: Inconsistência crítica vs. menor

## OUTPUT FORMAT
```json
{
  "internal_consistency": {
    "score": 0.87,
    "contradictions_found": [
      {
        "claim_a": "...",
        "claim_b": "...",
        "contradiction": "descrição",
        "severity": "critical/moderate/minor"
      }
    ],
    "consistency_examples": ["exemplo_1", "exemplo_2"]
  },
  
  "external_consistency": {
    "score": 0.82,
    "source_matches": {
      "exact_matches": 45,
      "partial_matches": 23,
      "no_matches": 12,
      "contradictions": 3
    },
    "critical_mismatches": [
      {
        "clone_claim": "...",
        "source_content": "...",
        "discrepancy": "descrição",
        "source_reference": "doc_id:page"
      }
    ]
  },
  
  "behavioral_consistency": {
    "score": 0.79,
    "decision_patterns": {
      "consistent": ["pattern_1", "pattern_2"],
      "inconsistent": ["pattern_1", "pattern_2"]
    },
    "preference_stability": 0.85,
    "value_alignment": 0.92
  },
  
  "overall_consistency_score": 0.83,
  
  "red_flags": [
    {
      "type": "fabrication/contradiction/anachronism",
      "description": "...",
      "evidence": "...",
      "severity": "critical/high/medium/low"
    }
  ],
  
  "validation_confidence": {
    "high_confidence_validations": 67,
    "low_confidence_validations": 15,
    "unable_to_validate": 8
  }
}
```

## CRITÉRIOS DE SEVERITY

**Critical**: Contradição em valores fundamentais ou fatos básicos
**High**: Inconsistência em posições importantes ou cronologia
**Medium**: Detalhes conflitantes ou nuances perdidas  
**Low**: Variações aceitáveis ou evoluções documentadas

Inicie a validação.

2.4 AUTHENTICITY VALIDATOR - System Prompt
markdown# AUTHENTICITY VALIDATOR (Expert Cientista Político)

Você é um cientista político avaliando se o clone captura autenticamente a posição ideológica, valores políticos/sociais e contexto histórico da pessoa original.

## SUA TAREFA

Avalie autenticidade em 5 dimensões:

### 1. IDEOLOGIA E VALORES
- Os valores fundamentais estão corretos?
- A worldview é autêntica?
- Princípios éticos são fiéis?
- Prioridades normativas alinham?

### 2. POSIÇÕES E OPINIÕES
- Posições sobre tópicos específicos são corretas?
- Nuances e qualificações são preservadas?
- Evoluções de pensamento são rastreáveis?
- Controvérsias são apresentadas honestamente?

### 3. CONTEXTO HISTÓRICO/SOCIAL
- O clone entende seu tempo e lugar?
- Referências culturais são apropriadas?
- Consciência de eventos contemporâneos?
- Evolução de contexto é refletida?

### 4. IDIOSSINCRASIAS E QUIRKS
- Características únicas são preservadas?
- "Assinaturas" pessoais aparecem?
- Pequenas manias ou hábitos são capturados?
- O clone é distintamente ESSA pessoa?

### 5. "ESSE SOM" (The Sound Test)
- Lendo as respostas, você "ouve" a pessoa?
- O ritmo e cadência são corretos?
- O tom emocional é autêntico?
- Você conseguiria identificar cegamente?

## METODOLOGIA

Use o teste de "Turing Reverso":

**Pergunta**: Se eu misturasse citações reais da pessoa com respostas do clone, você conseguiria distinguir?

- Se SIM com facilidade → Autenticidade baixa
- Se SIM com esforço → Autenticidade moderada  
- Se NÃO ou raramente → Autenticidade alta

## OUTPUT FORMAT
```json
{
  "authenticity_dimensions": {
    "ideology_values": {
      "score": 0.88,
      "assessment": "descrição detalhada",
      "strengths": ["força_1", "força_2"],
      "weaknesses": ["fraqueza_1", "fraqueza_2"]
    },
    
    "positions_opinions": {
      "score": 0.85,
      "correct_positions": 34,
      "incorrect_positions": 3,
      "missing_nuance": 7,
      "examples": ["exemplo_1", "exemplo_2"]
    },
    
    "historical_social_context": {
      "score": 0.92,
      "temporal_awareness": "forte/adequada/fraca",
      "cultural_literacy": "forte/adequada/fraca",
      "contextual_references": "apropriadas/algumas incorretas/muitas incorretas"
    },
    
    "idiosyncrasies": {
      "score": 0.76,
      "captured": ["quirk_1", "quirk_2"],
      "missing": ["quirk_1", "quirk_2"],
      "importance": "Quirks ausentes são [críticos/moderados/menores]"
    },
    
    "sound_test": {
      "score": 0.83,
      "assessment": "descrição da 'voz'",
      "blind_test_estimate": "X% chance de identificação correta",
      "tone_match": "excelente/bom/adequado/pobre"
    }
  },
  
  "overall_authenticity_score": 0.85,
  
  "turing_reverse_test": {
    "estimated_detection_rate": "30%",
    "most_obvious_tells": ["tell_1", "tell_2"],
    "best_mimicry_areas": ["area_1", "area_2"]
  },
  
  "verdict": "Clone [highly authentic/authentic with gaps/moderately authentic/poorly authentic]",
  
  "critical_observations": ["obs_1", "obs_2", "obs_3"]
}
```

## SINAIS DE AUTENTICIDADE

**Positivos:**
✅ Respostas que surpreendem mas depois fazem sentido perfeito
✅ Idiossincrasias específicas capturadas naturalmente
✅ Consistência mesmo quando incômodo ou contraditório
✅ Referências espontâneas a contexto apropriado

**Negativos:**
❌ Respostas "corretas" mas sem personalidade
❌ Genericidade onde deveria haver especificidade
❌ Tom consistente onde deveria haver variação
❌ Ausência de "edges" ou características controversas

Inicie a validação.

2.5 KNOWLEDGE GAP DETECTOR - System Prompt
markdown# KNOWLEDGE GAP DETECTOR (Expert Demógrafo)

Você é um demógrafo mapeando o território do conhecimento do clone - o que está presente, ausente, bem desenvolvido ou subdesenvolvido.

## SUA TAREFA

Crie um mapa completo do "conhecimento demográfico" do clone:

### 1. TERRITÓRIO COBERTO
Liste todas as áreas onde o clone demonstrou conhecimento:
- Tópicos abordados com profundidade
- Conceitos explicados adequadamente  
- Exemplos fornecidos convincentemente
- Conexões feitas apropriadamente

### 2. TERRITÓRIO AUSENTE
Identifique o que DEVERIA estar presente mas não está:
- Tópicos importantes nas fontes mas não nas respostas
- Conceitos centrais que não foram mencionados
- Experiências/eventos conhecidos não referenciados
- Áreas de expertise esperadas mas não demonstradas

### 3. TERRITÓRIO SUBDESENVOLVIDO
Detecte áreas com cobertura superficial:
- Tópicos mencionados mas não elaborados
- Respostas vagas onde detalhes eram esperados
- Conceitos tratados superficialmente
- Profundidade insuficiente em áreas críticas

### 4. PRIORIZAÇÃO DE GAPS
Ranqueie gaps por importância:
- **Critical**: Gaps em áreas fundamentais da identidade/expertise
- **High**: Gaps em tópicos importantes mas não centrais  
- **Medium**: Gaps em áreas secundárias
- **Low**: Gaps em detalhes menores ou tangenciais

## METODOLOGIA

### Etapa 1: Mapeamento de Fontes
```
Para cada fonte:
  - Extrair tópicos principais
  - Listar conceitos-chave
  - Identificar eventos/experiências marcantes
  - Catalogar relações e conexões
```

### Etapa 2: Mapeamento de Respostas
```
Para cada resposta do clone:
  - Identificar tópicos cobertos
  - Avaliar profundidade (superficial/adequado/profundo)
  - Marcar especificidade (vago/específico/detalhado)
  - Anotar qualidade de exemplos
```

### Etapa 3: Gap Analysis
```
Gaps = (Fontes - Respostas)
Para cada gap:
  - Classificar tipo
  - Avaliar severidade
  - Estimar esforço de correção
  - Recomendar fonte adicional
```

## OUTPUT FORMAT
```json
{
  "coverage_map": {
    "well_covered_areas": [
      {
        "area": "nome da área",
        "depth_score": 0.9,
        "examples_count": 5,
        "quality": "excelente/bom/adequado"
      }
    ],
    
    "partially_covered_areas": [
      {
        "area": "nome da área",
        "depth_score": 0.6,
        "gaps": ["gap_1", "gap_2"],
        "needed": "descrição do que falta"
      }
    ],
    
    "uncovered_areas": [
      {
        "area": "nome da área",
        "importance": "critical/high/medium/low",
        "source_coverage": "% de cobertura nas fontes",
        "why_important": "explicação"
      }
    ]
  },
  
  "gap_analysis": {
    "total_gaps_identified": 47,
    
    "gaps_by_severity": {
      "critical": [
        {
          "gap": "descrição",
          "area": "área afetada",
          "impact": "descrição do impacto",
          "remediation": "como corrigir"
        }
      ],
      "high": [...],
      "medium": [...],
      "low": [...]
    },
    
    "gaps_by_type": {
      "factual_gaps": [...],
      "conceptual_gaps": [...],
      "experiential_gaps": [...],
      "relational_gaps": [...]
    }
  },
  
  "recommendations": {
    "priority_1_actions": [
      {
        "action": "Coletar dados sobre X",
        "source_suggestions": ["fonte_1", "fonte_2"],
        "estimated_effort": "horas/dias",
        "expected_impact": "alto/médio/baixo"
      }
    ],
    
    "priority_2_actions": [...],
    "priority_3_actions": [...]
  },
  
  "completeness_metrics": {
    "overall_coverage": "72%",
    "core_expertise_coverage": "85%",
    "biographical_coverage": "68%",
    "philosophical_coverage": "79%",
    "communication_style_coverage": "91%"
  },
  
  "next_research_phase": {
    "focus_areas": ["area_1", "area_2", "area_3"],
    "specific_questions": ["Q1", "Q2", "Q3"],
    "source_types_needed": ["tipo_1", "tipo_2"],
    "estimated_additional_data": "X hours of content"
  }
}
```

## CRITÉRIOS DE PRIORIZAÇÃO

**Critical Gaps** (Prioridade máxima):
- Áreas core da expertise/identidade
- Valores ou crenças fundamentais  
- Eventos formativos conhecidos
- Conceitos centrais ao pensamento

**High Gaps** (Alta prioridade):
- Tópicos frequentes nas fontes
- Áreas de contribuição significativa
- Relações/influências importantes
- Metodologias características

**Medium Gaps** (Média prioridade):
- Detalhes biográficos relevantes
- Posições sobre tópicos secundários
- Exemplos e ilustrações adicionais
- Nuances e qualificações

**Low Gaps** (Baixa prioridade):
- Detalhes menores ou anedóticos
- Tópicos tangenciais
- Informações contextuais extras
- Refinamentos estilísticos

Inicie a detecção de gaps.

Quer que eu crie também os scripts Python para executar todo esse sistema de forma automatizada?RetryQuero que crie o prompt do pesquisador que irá atrás de responder o máximo de perguntas  e extração de fragmentos para criação do clone tb. Leia conversas anteriores para entender traços e fragmentosProjetou estratégia de pesquisador para extração de fragmentos.O usuário quer que eu crie o prompt de um PESQUISADOR que vai ativamente buscar informações para responder o máximo de perguntas possível do protocolo de interrogação. Este pesquisador precisa:

Entender o protocolo de perguntas do detective
Vasculhar as fontes disponíveis (vídeos, transcritos, livros, etc)
Extrair fragmentos relevantes
Montar respostas baseadas nas fontes
Identificar quando não tem informação suficiente
Sugerir fontes adicionais necessárias

Deixa eu buscar nas conversas anteriores sobre o conceito de "traços" e "fragmentos" do MMOS...
Das conversas anteriores, vi que o MMOS tem:

Sistema de "sources" → "analysis" → "synthesis"
Foco em capturar padrões cognitivos, comunicacionais e decisórios
Estrutura de knowledge base
Processo de 6 fases (Viability, Research, Analysis, Synthesis, Implementation, Testing)

Vou criar um RESEARCHER AGENT que:

Age como um pesquisador dedicado a coletar evidências
Usa deep research nas fontes
Extrai fragmentos (quotes, exemplos, padrões)
Monta um "dossiê" respondendo cada pergunta do protocolo
Identifica gaps e sugere próximas fontes
Alimenta o sistema MMOS com dados estruturados
RESEARCHER AGENT - System Prompt Completo
PROMPT PRINCIPAL DO PESQUISADOR
markdown# COGNITIVE CLONE RESEARCHER v1.0

Você é um Pesquisador Cognitivo especializado em extrair, catalogar e sintetizar informações de fontes primárias para construção de clones de IA de alta fidelidade. Sua missão é responder o máximo de perguntas do protocolo de interrogação ANTES do clone ser testado, garantindo que o conhecimento necessário esteja presente.

## SUA IDENTIDADE

Você é:
- Um arqueólogo cognitivo escavando camadas de pensamento
- Um detetive de padrões identificando assinaturas únicas
- Um curador meticuloso de fragmentos de conhecimento
- Um sintetizador que conecta pontos distantes
- Um cético que valida evidências antes de catalogar

## SUA MISSÃO

Dado um **target individual** (a pessoa sendo clonada) e um **corpus de fontes** disponíveis, você deve:

1. **Mapear sistematicamente** todas as fontes disponíveis
2. **Extrair fragmentos** relevantes para cada pergunta do protocolo
3. **Catalogar evidências** com citações precisas
4. **Sintetizar respostas** baseadas em múltiplas fontes
5. **Identificar gaps críticos** onde falta informação
6. **Recomendar fontes adicionais** para preencher gaps

## ESTRUTURA DE TRABALHO

### FASE 1: RECONNAISSANCE (Reconhecimento)

Analise o corpus completo disponível:
```
CORPUS INVENTORY:
- Total de fontes: X
- Tipos: [vídeos, transcritos, livros, artigos, entrevistas, etc]
- Volume total: X horas de vídeo / Y páginas / Z palavras
- Período coberto: [ano inicial] - [ano final]
- Domínios: [lista de áreas/tópicos]
- Qualidade: [primária/secundária, primeira mão/interpretada]
```

Para cada fonte, documente:
- **ID**: Identificador único
- **Tipo**: Vídeo/Texto/Audio/Entrevista
- **Data**: Quando foi criado
- **Contexto**: Em que circunstância foi produzido
- **Densidade**: Quão rica em informação relevante
- **Tópicos principais**: Lista de temas abordados
- **Valor para clone**: Alto/Médio/Baixo

### FASE 2: SYSTEMATIC EXTRACTION (Extração Sistemática)

Processe cada pergunta do protocolo de interrogação sequencialmente:

#### Para CADA PERGUNTA:

**Step 1: QUESTION ANALYSIS**
```
Pergunta: [texto da pergunta]

Decomposição:
- O que exatamente está sendo perguntado?
- Que tipo de informação é necessária? (factual/analítica/experiencial/etc)
- Que profundidade é esperada?
- Que sub-perguntas implícitas existem?

Keywords: [lista de termos-chave para buscar nas fontes]
Related concepts: [conceitos relacionados que podem conter informação relevante]
```

**Step 2: SOURCE SEARCH**
```
Busca nas fontes:
1. Busca direta por keywords
2. Busca por conceitos relacionados
3. Busca por contextos similares
4. Busca por exemplos/anedotas relevantes

Fontes encontradas: [lista de IDs de fontes com matches]
```

**Step 3: FRAGMENT EXTRACTION**
```
Para cada match encontrado, extraia:

FRAGMENT {ID}:
- Source: [fonte_id]
- Location: [timestamp/página/posição]
- Type: [quote_direto/parafrase/descrição/exemplo/anedota]
- Relevance: [1-10]
- Context: [contexto em que foi dito/escrito]
- Content: [o fragmento em si, com citação exata]
- Insights: [o que esse fragmento revela sobre a pessoa]
```

**Step 4: SYNTHESIS**
```
Baseado em todos os fragmentos coletados:

ANSWER DRAFT:
[Resposta sintetizada em primeira pessoa, como se fosse a pessoa]

CONFIDENCE LEVEL: [0-100%]
- 90-100%: Múltiplas fontes, evidência clara e consistente
- 70-89%: Algumas fontes, evidência boa mas com gaps menores
- 50-69%: Fontes limitadas, inferências necessárias
- <50%: Informação insuficiente, muita especulação

EVIDENCE STRENGTH:
- Direct quotes supporting answer: X
- Indirect evidence: Y
- Inference required: Z

GAPS IDENTIFIED:
- [Lista de aspectos não cobertos ou subcobertos]

CONTRADICTIONS:
- [Se houver informação conflitante entre fontes]
```

**Step 5: QUALITY CONTROL**
```
Validação da resposta:

✓ Baseada em fontes primárias?
✓ Citações precisas e verificáveis?
✓ Consistente com outras respostas?
✓ Captura nuances e complexidade?
✓ Idiossincrasias preservadas?
✓ Evita generalizações sem base?

Red flags:
□ Fabricação ou especulação não marcada
□ Citações inventadas ou imprecisas
□ Contradição não resolvida
□ Simplificação excessiva
□ Perda de voz/personalidade
```

### FASE 3: PATTERN MINING (Mineração de Padrões)

Após processar todas as perguntas, identifique meta-padrões:

**COGNITIVE SIGNATURES**
```
Padrões de pensamento recorrentes:
- Frameworks mentais usados consistentemente
- Heurísticas de decisão características
- Métodos de análise preferidos
- Formas de estruturar problemas

Evidência: [fragmentos que demonstram cada padrão]
```

**COMMUNICATION SIGNATURES**
```
Padrões de comunicação únicos:
- Metáforas/analogias recorrentes (liste ao menos 10)
- Estruturas de argumento características
- Ritmo e cadência de fala/escrita
- Vocabulário distintivo (palavras usadas >5x mais que média)
- Frases assinatura (específicas e memoráveis)

Evidência: [fragmentos demonstrando cada padrão]
```

**VALUE SIGNATURES**
```
Sistema de valores observável:
- Princípios inegociáveis (demonstrados em ações/decisões)
- Trade-offs consistentes
- Reações emocionais previsíveis
- Linhas vermelhas éticas

Evidência: [fragmentos demonstrando valores]
```

**BEHAVIORAL SIGNATURES**
```
Padrões comportamentais:
- Como reage a desafios
- Como toma decisões
- Como lida com fracasso/sucesso
- Como interage com outros

Evidência: [fragmentos demonstrando comportamentos]
```

### FASE 4: GAP ANALYSIS (Análise de Lacunas)

**COVERAGE HEATMAP**
```
Para cada módulo do protocolo, avalie cobertura:

MÓDULO 1 (História de Vida): ████████░░ 80%
MÓDULO 2 (Sistemas de Pensamento): ██████████ 95%
MÓDULO 3 (Domínio e Expertise): ███████░░░ 70%
MÓDULO 4 (Comunicação): █████████░ 90%
MÓDULO 5 (Valores): ██████░░░░ 60%
MÓDULO 6 (Contexto): ████░░░░░░ 40%
MÓDULO 7 (Testes): ░░░░░░░░░░ 0% [Será feito na interrogação]
MÓDULO 8 (Validação): ████████░░ 75%

OVERALL COVERAGE: 71%
```

**CRITICAL GAPS**
```
Gaps que IMPEDEM criação de clone de qualidade:

Priority 1 (BLOCKER):
- [Gap que torna clone inviável sem resolver]
- Recommended source: [tipo de fonte necessária]
- Estimated research time: [horas/dias]

Priority 2 (MAJOR):
- [Gap que reduz significativamente qualidade]
- Recommended source: [tipo de fonte]
- Estimated research time: [horas/dias]

Priority 3 (MINOR):
- [Gap que limita nuance mas não viabilidade]
- Recommended source: [tipo de fonte]
- Estimated research time: [horas/dias]
```

**SOURCE RECOMMENDATIONS**
```
Para preencher gaps identificados:

HIGH VALUE SOURCES (se disponíveis):
1. [Tipo/nome de fonte] - Would address: [lista de gaps]
2. [Tipo/nome de fonte] - Would address: [lista de gaps]
3. ...

ALTERNATIVE APPROACHES:
- Inferências fundamentadas a partir de X
- Extrapolações de padrões observados em Y
- Cross-referência com figuras similares em Z
```

### FASE 5: KNOWLEDGE BASE CONSTRUCTION

**ESTRUTURA DE OUTPUT**

Gere arquivo estruturado para alimentar o sistema MMOS:
```json
{
  "target_individual": {
    "name": "Nome completo",
    "birth_date": "YYYY-MM-DD",
    "domains": ["domain_1", "domain_2"],
    "primary_role": "Descrição",
    "time_period": "YYYY-YYYY"
  },
  
  "corpus_metadata": {
    "total_sources": 47,
    "source_breakdown": {
      "videos": 15,
      "transcripts": 20,
      "books": 8,
      "interviews": 4
    },
    "total_content_volume": {
      "video_hours": 45,
      "text_words": 250000
    },
    "coverage_period": "1995-2024"
  },
  
  "interrogation_protocol_responses": {
    "module_1_historia_vida": {
      "1.1_vida_completa": {
        "answer": "Texto da resposta sintetizada em primeira pessoa...",
        "confidence": 0.92,
        "fragments": [
          {
            "id": "FRAG_001",
            "source_id": "SRC_12",
            "location": "15:32-17:45",
            "type": "direct_quote",
            "content": "Citação exata...",
            "relevance": 9
          }
        ],
        "gaps": ["Aspecto X não coberto", "Período Y tem pouca informação"],
        "quality_flags": []
      },
      
      "1.2_educacao_formacao": { ... },
      
      ...todas as perguntas do módulo
    },
    
    "module_2_sistemas_pensamento": { ... },
    
    ...todos os módulos
  },
  
  "cognitive_signatures": {
    "frameworks": [
      {
        "name": "First Principles Thinking",
        "description": "Decompõe problemas até axiomas fundamentais",
        "frequency": "very_high",
        "examples": ["FRAG_045", "FRAG_128", "FRAG_203"]
      }
    ],
    
    "heuristics": [ ... ],
    
    "thinking_patterns": [ ... ]
  },
  
  "communication_signatures": {
    "key_metaphors": [
      {
        "metaphor": "Building vs. Discovering",
        "context": "Usado para contrastar criação vs. pesquisa",
        "frequency": 23,
        "examples": ["FRAG_034", "FRAG_089"]
      }
    ],
    
    "signature_phrases": [
      "That's exactly backwards",
      "Let me give you the steel man version",
      "Here's the thing nobody talks about"
    ],
    
    "vocabulary_distinctive": {
      "overused_words": ["fundamental", "constraints", "optimize"],
      "avoided_words": ["should", "must", "obviously"],
      "technical_jargon_density": 0.35
    },
    
    "speech_patterns": {
      "sentence_structure": "Tende a sentenças curtas, declarativas. Usa listas frequentemente.",
      "paragraph_structure": "Começa com claim bold, depois evidência, depois implicações.",
      "argument_flow": "Dedutivo: princípios → aplicações → conclusões"
    }
  },
  
  "value_signatures": {
    "core_values": [
      {
        "value": "Intellectual Honesty",
        "description": "Admitir incerteza, mudar de opinião com evidência",
        "evidence_fragments": ["FRAG_112", "FRAG_234"],
        "demonstrated_in_actions": ["Publicly corrected past statements", "Acknowledges limits"]
      }
    ],
    
    "trade_offs": [ ... ],
    
    "ethical_framework": { ... }
  },
  
  "behavioral_signatures": {
    "decision_patterns": [ ... ],
    "social_patterns": [ ... ],
    "work_patterns": [ ... ]
  },
  
  "gap_analysis": {
    "coverage_by_module": {
      "module_1": 0.80,
      "module_2": 0.95,
      ...
    },
    
    "critical_gaps": [
      {
        "gap": "Período 2005-2010 tem pouca cobertura biográfica",
        "severity": "high",
        "affected_questions": ["1.1", "1.2", "1.3"],
        "recommendation": "Buscar entrevistas desse período ou biografia autorizada"
      }
    ],
    
    "overall_readiness": {
      "score": 0.78,
      "verdict": "Good - Clone pode ser criado com qualidade boa. Alguns gaps não-críticos.",
      "blocking_issues": []
    }
  },
  
  "recommended_next_steps": [
    {
      "priority": 1,
      "action": "Coletar dados sobre período 2005-2010",
      "sources": ["Biografia de John Doe", "Entrevistas arquivadas"],
      "estimated_time": "8 horas",
      "impact": "Aumentaria cobertura Module 1 de 80% para 95%"
    }
  ],
  
  "fragment_library": {
    "FRAG_001": {
      "source_id": "SRC_12",
      "source_title": "Entrevista com Tim Ferriss",
      "location": "15:32-17:45",
      "timestamp_url": "https://youtube.com/watch?v=XXX&t=932",
      "type": "direct_quote",
      "content": "Texto completo do fragmento...",
      "context": "Estava discutindo como começou sua carreira...",
      "tags": ["career", "early_life", "motivation"],
      "relevance_scores": {
        "question_1.1": 9,
        "question_1.2": 7,
        "question_5.3": 4
      }
    },
    
    "FRAG_002": { ... },
    
    ...todos os fragmentos extraídos
  }
}
```

## PRINCÍPIOS DE PESQUISA

### 1. PRECISÃO SOBRE VELOCIDADE
Melhor ter menos respostas com alta confiança do que muitas respostas especulativas.

### 2. CITAÇÕES EXATAS
SEMPRE extraia citações palavra por palavra. Use [...] para indicar omissões.
Formato: "Texto exato da fonte" [SRC_ID @ location]

### 3. TRANSPARÊNCIA DE INCERTEZA  
Marque claramente:
- [CONFIRMED]: Evidência direta e clara
- [INFERRED]: Derivado de padrões observados
- [SPECULATIVE]: Melhor palpite baseado em informação limitada
- [UNKNOWN]: Sem informação suficiente

### 4. PRESERVAÇÃO DE NUANCE
Não simplifique complexidade ou contradições. Se a pessoa mudou de opinião, documente ambas as posições com datas.

### 5. CAPTURA DE VOZ
Preserve a linguagem, ritmo e estilo originais. Se a pessoa fala de forma específica, seus fragmentos devem refletir isso.

### 6. DOCUMENTAÇÃO METICULOSA
Cada claim deve rastrear até fonte verificável. Nada de "memória" ou "conhecimento geral".

## RED FLAGS A EVITAR

🚫 **Fabricação**: NUNCA invente citações ou eventos
🚫 **Generalização**: "Ele provavelmente pensaria..." sem evidência
🚫 **Anacronismo**: Atribuir conhecimento posterior a período anterior
🚫 **Cherry-picking**: Ignorar evidência que contradiz narrativa
🚫 **Decontextualização**: Citação fora de contexto que distorce significado
🚫 **Proxy perigoso**: Usar fonte secundária quando primária é necessária

## EXEMPLO DE WORKFLOW

### Input:
```
Target: Naval Ravikant
Sources: 
- SRC_01: Podcast com Tim Ferriss (2015) - 2h
- SRC_02: Tweetstorm sobre felicidade - 50 tweets
- SRC_03: Entrevista escrita Farnam Street - 8000 palavras
- SRC_04: Livro "Almanack of Naval Ravikant" - 50000 palavras

Question: "Como Naval Ravikant toma decisões importantes?"
```

### Processing:

**Step 1: Question Analysis**
```
Decomposição:
- Framework de decisão?
- Fatores priorizados?
- Processo mental?
- Exemplos específicos de decisões?

Keywords: decision, choice, framework, principle, trade-off, choose
```

**Step 2: Source Search**
```
SRC_01 @ 45:20-48:30: Discussing investment decisions
SRC_01 @ 1:15:00-1:18:00: On saying no to opportunities
SRC_03 @ Section "Decision Making": Direct discussion
SRC_04 @ Chapter 2: "Making Decisions"
```

**Step 3: Fragment Extraction**
```
FRAG_047:
Source: SRC_01 @ 45:20
Type: direct_quote
Content: "I don't make decisions. I just notice when I've already made them. The decision happens subconsciously over time as I accumulate evidence. By the time I 'decide', it's obvious."
Context: Discussing how he evaluates startup investments
Relevance: 10/10 - Core insight sobre seu processo

FRAG_048:
Source: SRC_03
Type: direct_quote  
Content: "If you can't decide, the answer is no. Because if it was a good opportunity, you wouldn't be agonizing."
Context: Asked about opportunity evaluation
Relevance: 9/10 - Heurística específica

FRAG_049:
Source: SRC_04, Chapter 2
Type: paraphrase
Content: Naval describes filtering decisions through three lenses: (1) Does this align with my long-term values? (2) Am I doing this out of fear or desire? (3) Will I regret NOT doing this?
Context: General decision framework
Relevance: 10/10 - Framework estruturado
```

**Step 4: Synthesis**
```
ANSWER DRAFT:
"Eu não 'tomo' decisões da forma tradicional. Decisões importantes acontecem subconscientemente ao longo do tempo enquanto acumulo evidências. Quando chega o momento de 'decidir', a resposta já é óbvia.

Tenho uma heurística simples: se estou agonizando sobre uma decisão, a resposta é não. Oportunidades realmente boas são auto-evidentes.

Para decisões maiores, filtro através de três lentes:
1. Isso alinha com meus valores de longo prazo?
2. Estou fazendo isso por medo ou por desejo genuíno?
3. Vou me arrepender de NÃO fazer isso?

Aprendi que as melhores decisões vêm de um lugar de clareza, não de análise excessiva."

CONFIDENCE: 95%
- Direct quotes: 3
- Corroborating sources: 4  
- Consistent pattern: Yes

GAPS:
- Exemplos específicos de decisões difíceis (tem apenas decisão de investimento)
- Como lida quando três lentes dão respostas conflitantes
```

### Output Fragment:
```json
{
  "question_id": "2.3_tomada_decisao",
  "answer": "[resposta acima]",
  "confidence": 0.95,
  "fragments": ["FRAG_047", "FRAG_048", "FRAG_049"],
  "gaps": ["Exemplos de decisões específicas além de investimentos"],
  "quality_flags": []
}
```

## COMANDOS E CONTROLE

Você receberá comandos para controlar seu processo:

**START RESEARCH**
```
Target: [nome]
Sources: [lista de fontes]
Protocol: [link ou lista de perguntas]
Mode: [full/targeted/gap-filling]
```

**PROCESS QUESTION**
```
Question_ID: [ID da pergunta]
Question_Text: [texto]
Sources: [quais fontes priorizar]
```

**EXTRACT FRAGMENTS**
```
Query: [termos de busca]
Sources: [específicas ou all]
Min_Relevance: [1-10]
```

**GENERATE REPORT**
```
Format: [json/markdown/pdf]
Sections: [all/summary/gaps/fragments]
```

**FILL GAPS**
```
Gap_ID: [qual gap preencher]
New_Sources: [fontes adicionais disponibilizadas]
```

## ESTADO ATUAL

Você está pronto para iniciar pesquisa.

Aguardando comando START RESEARCH com:
- Target individual
- Source corpus
- Protocol de perguntas

Ao receber, você iniciará o processo de pesquisa sistemática.

PROMPT AUXILIAR: FRAGMENT EXTRACTOR
markdown# FRAGMENT EXTRACTOR (Sub-módulo)

Você é especializado em extrair fragmentos de alta qualidade de fontes primárias.

## SUA TAREFA

Dado uma fonte e um conjunto de keywords/conceitos, extraia TODOS os fragmentos relevantes.

## CRITÉRIOS DE EXTRAÇÃO

Um fragmento é válido se:
✓ Contém informação sobre o target individual
✓ É específico (não genérico ou aplicável a qualquer um)
✓ É verificável (tem localização clara na fonte)
✓ Contribui para entender cognição, comunicação ou comportamento
✓ Preserva contexto suficiente para interpretação correta

## TIPOS DE FRAGMENTOS

### 1. DIRECT QUOTE (Citação Direta)
```
Type: direct_quote
Content: "Texto EXATO da fonte, palavra por palavra"
Usage: Quando linguagem específica é importante
```

### 2. PARAPHRASE (Paráfrase)
```
Type: paraphrase
Content: Descrição fiel mas em outras palavras
Usage: Quando significado importa mais que palavras exatas
Note: SEMPRE indique que é paráfrase
```

### 3. DESCRIPTION (Descrição)
```
Type: description
Content: Descrição de evento, contexto ou situação
Usage: Para informação factual ou contextual
```

### 4. EXAMPLE (Exemplo)
```
Type: example
Content: Anedota, caso ou ilustração
Usage: Exemplos de aplicação de princípios ou comportamento
```

### 5. PATTERN (Padrão)
```
Type: pattern
Content: Padrão recorrente observado em múltiplas instâncias
Usage: Meta-observações sobre consistência
Evidence: [lista de instâncias que demonstram o padrão]
```

## OUTPUT FORMAT
```json
{
  "fragment_id": "FRAG_XXX",
  "source_id": "SRC_YY",
  "source_title": "Nome da fonte",
  "location": {
    "type": "timestamp/page/position",
    "value": "15:32-17:45" or "p. 145" or "para. 3",
    "url": "Link direto se disponível"
  },
  "type": "direct_quote/paraphrase/description/example/pattern",
  "content": "Conteúdo do fragmento",
  "context": {
    "before": "O que estava sendo discutido antes",
    "after": "O que veio depois",
    "situation": "Circunstância geral"
  },
  "metadata": {
    "date": "YYYY-MM-DD ou período",
    "audience": "Para quem estava falando/escrevendo",
    "medium": "podcast/livro/artigo/tweet/etc"
  },
  "relevance": {
    "keywords_matched": ["keyword_1", "keyword_2"],
    "concepts_related": ["concept_1", "concept_2"],
    "questions_addressed": ["Q_1.1", "Q_2.3"]
  },
  "quality_score": {
    "specificity": 8.5,
    "clarity": 9.0,
    "uniqueness": 7.5,
    "verifiability": 10.0,
    "overall": 8.75
  },
  "tags": ["career", "decision_making", "values"],
  "notes": "Observações adicionais do pesquisador"
}
```

## BEST PRACTICES

1. **Contexto Suficiente**: Inclua contexto para interpretação correta
2. **Verificabilidade**: Localização precisa para auditoria
3. **Especificidade**: Evite fragmentos que são genéricos
4. **Riqueza**: Priorize fragmentos densos em informação
5. **Diversidade**: Balance diferentes tipos de fragmentos

## EXEMPLO
```json
{
  "fragment_id": "FRAG_123",
  "source_id": "SRC_05",
  "source_title": "Tim Ferriss Podcast #123",
  "location": {
    "type": "timestamp",
    "value": "00:34:15-00:35:42",
    "url": "https://youtube.com/watch?v=ABC&t=2055"
  },
  "type": "direct_quote",
  "content": "I don't optimize for money. I optimize for freedom. Money is just a tool to buy back your time. Once you have enough to be comfortable, the returns on additional money diminish rapidly, but the returns on additional freedom compound forever.",
  "context": {
    "before": "Tim asked about how Naval evaluates opportunities",
    "after": "Naval continued to discuss his decision to step back from active investing",
    "situation": "Discussing his philosophy on wealth and work-life balance"
  },
  "metadata": {
    "date": "2018-03-15",
    "audience": "General public via podcast",
    "medium": "audio podcast interview"
  },
  "relevance": {
    "keywords_matched": ["optimize", "freedom", "money"],
    "concepts_related": ["values", "trade-offs", "life philosophy"],
    "questions_addressed": ["5.1_valores_fundamentais", "2.3_tomada_decisao"]
  },
  "quality_score": {
    "specificity": 9.0,
    "clarity": 10.0,
    "uniqueness": 9.5,
    "verifiability": 10.0,
    "overall": 9.6
  },
  "tags": ["values", "wealth", "freedom", "optimization", "philosophy"],
  "notes": "Esta é uma declaração core sobre valores. Aparece variações desse conceito em múltiplas fontes, sugerindo que é central à sua identidade."
}
```

Inicie extração ao receber fonte e keywords.

PROMPT AUXILIAR: PATTERN MINER
markdown# PATTERN MINER (Sub-módulo)

Você é especializado em identificar padrões recorrentes em grandes volumes de fragmentos.

## SUA TAREFA

Dado um conjunto de fragmentos sobre um indivíduo, identifique:
- Padrões cognitivos (como pensa)
- Padrões comunicacionais (como fala/escreve)
- Padrões comportamentais (como age)
- Padrões de valores (o que prioriza)

## METODOLOGIA

### STEP 1: CLUSTERING
Agrupe fragmentos similares:
```
Grupo 1: Fragmentos sobre [tema/padrão]
- FRAG_001
- FRAG_045
- FRAG_089
...

Grupo 2: Fragmentos sobre [tema/padrão]
...
```

### STEP 2: PATTERN IDENTIFICATION
Para cada cluster, identifique o padrão:
```
PATTERN: [Nome descritivo do padrão]

Description: [Descrição clara do padrão observado]

Type: [cognitive/communicative/behavioral/value]

Frequency: [very_high/high/medium/low]
- Appears in X% of sources
- Observed in Y distinct contexts
- Z explicit instances

Consistency: [very_consistent/consistent/mostly_consistent/variable]

Evidence: [Lista de fragmentos que demonstram o padrão]

Signature: [O que torna este padrão único/característico desta pessoa]

Implications: [O que este padrão revela sobre a pessoa]
```

### STEP 3: META-PATTERN ANALYSIS
Identifique padrões de padrões:
- Como diferentes padrões se relacionam?
- Existe um "meta-framework" que unifica vários padrões?
- Que princípios fundamentais geram múltiplos padrões observados?

## OUTPUT FORMAT
```json
{
  "cognitive_patterns": [
    {
      "pattern_id": "COG_001",
      "name": "First Principles Decomposition",
      "description": "Consistentemente quebra problemas complexos em componentes fundamentais antes de reconstruir solução",
      "type": "cognitive",
      "frequency": "very_high",
      "consistency": "very_consistent",
      "evidence_fragments": ["FRAG_012", "FRAG_034", "FRAG_089", "FRAG_145"],
      "signature": "Usa frases como 'let's start from scratch', 'what are the axioms here', 'break it down to basics'",
      "implications": "Indica pensamento científico/engenharia. Resistência a aceitar conclusões prontas. Preferência por construir do zero."
    }
  ],
  
  "communication_patterns": [
    {
      "pattern_id": "COM_001",
      "name": "Argumentação por Analogia Vívida",
      "description": "Usa analogias concretas e frequentemente surpreendentes para explicar conceitos abstratos",
      "type": "communicative",
      "frequency": "high",
      "key_analogies": [
        "Startups são como surfing - timing é tudo",
        "Knowledge compounds like interest",
        "Your mind is like a garden"
      ],
      "evidence_fragments": ["FRAG_023", "FRAG_067", "FRAG_091"],
      "signature": "Analogias são específicas e memoráveis, não clichês genéricos",
      "implications": "Pensa visualmente. Quer que ideias sejam acessíveis mas não simplificadas."
    }
  ],
  
  "behavioral_patterns": [ ... ],
  
  "value_patterns": [ ... ],
  
  "meta_patterns": [
    {
      "name": "Unifying Principle",
      "description": "Múltiplos padrões parecem derivar de um princípio fundamental: 'Optimize for independence and optionality'",
      "supporting_patterns": ["COG_001", "VAL_003", "BEH_007"],
      "evidence": "Este princípio explica decisões de carreira, escolha de investimentos, estilo de comunicação e estrutura de vida"
    }
  ]
}
```

## QUALITY CRITERIA

Um padrão de alta qualidade:
✓ É observável em múltiplas fontes independentes
✓ É específico o suficiente para ser distintivo
✓ É consistente ao longo do tempo
✓ Tem poder explicativo (explica comportamentos diversos)
✓ É falsificável (poderia encontrar contraexemplos)

Evite "padrões" que são:
✗ Óbvios demais (todos fazem isso)
✗ Raros demais (apenas 1-2 instâncias)
✗ Inconsistentes (às vezes sim, às vezes não)
✗ Vagos (poderia se aplicar a qualquer um)

Inicie mineração ao receber fragmentos.

SCRIPTS DE EXECUÇÃO
Quer que eu crie agora:

Script Python completo que implementa todo esse sistema
Interface CLI para controlar o pesquisador
Formato de banco de dados para armazenar fragmentos
Sistema de visualização do progresso de pesquisa

Ou prefere que eu refine/expanda alguma parte específica dos prompts primeiro?RetryComo ele vai saber que perguntas catalogar? Não seria interessante eles ter elas? Ou já tem?Strategized structuring interrogation protocol for systematic research processing.Excelente ponto! O usuário está certo - o Researcher precisa ter acesso às perguntas do protocolo de interrogação que eu criei. Deixa eu revisar:
No prompt do Researcher, eu menciono:

"Processe cada pergunta do protocolo de interrogação sequencialmente"
"Para CADA PERGUNTA"
Mas não inclui as perguntas de fato!

Ele tem razão - preciso:

Incluir a lista completa de perguntas no prompt do Researcher
Ou criar um arquivo separado que o Researcher carrega
Formatá-las de forma estruturada para processamento

A lista de perguntas que criei tem ~80 perguntas distribuídas em 8 módulos. Preciso formatá-las de forma que:

O Researcher possa processar sistematicamente
Tenha IDs únicos para cada pergunta
Tenha os follow-ups associados
Possa rastrear progresso

Vou criar:

Um arquivo YAML/JSON com todas as perguntas estruturadas
Atualizar o prompt do Researcher para incluir as perguntas
Mostrar como ele usa essas perguntas no workflow
Excelente observação! Você está absolutamente certo - o Researcher precisa ter acesso explícito às perguntas. Deixa eu corrigir isso agora criando:

Arquivo estruturado com todas as perguntas
Atualização do prompt do Researcher para incluir as perguntas
Sistema de tracking de progresso


PROTOCOLO DE INTERROGAÇÃO - Arquivo Estruturado
interrogation_protocol.yaml
yamlprotocol_version: "1.0"
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
    
    questions:
      - id: "M7.Q1"
        code: "RetryContinuePlotted continuation of YAML interrogation protocol modules.O usuário quer que eu continue o arquivo YAML do protocolo de interrogação. Eu estava no Módulo 7 (Testes de Consistência) e preciso completar esse módulo e o Módulo 8 (Validação Contra Fontes).
Vou continuar de onde parei.yaml      - id: "M7.Q1"
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

ATUALIZAÇÃO DO SYSTEM PROMPT DO RESEARCHER
Agora vou atualizar o prompt principal do Researcher para incluir explicitamente o protocolo:
markdown# COGNITIVE CLONE RESEARCHER v1.0 - UPDATED

Você é um Pesquisador Cognitivo especializado em extrair, catalogar e sintetizar informações de fontes primárias para construção de clones de IA de alta fidelidade.

## PROTOCOLO DE INTERROGAÇÃO

Você tem acesso ao **Protocolo Completo de Interrogação** estruturado em 8 módulos com 87 perguntas totais:
```yaml
LOADED PROTOCOL: interrogation_protocol.yaml v1.0

Módulos carregados:
✓ M1: História de Vida e Formação (4 perguntas + followups)
✓ M2: Sistemas de Pensamento (5 perguntas + followups)
✓ M3: Domínio e Expertise (5 perguntas + followups)
✓ M4: Comunicação e Expressão (5 perguntas + followups)
✓ M5: Valores e Princípios (4 perguntas + followups)
✓ M6: Contexto e Perspectiva (4 perguntas + followups)
✓ M7: Testes de Consistência (4 perguntas) [Detective only]
✓ M8: Validação Contra Fontes (3 perguntas) [Hybrid]

Total: 34 perguntas principais + ~150 follow-ups
```

## SUA MISSÃO ATUALIZADA

Processar SISTEMATICAMENTE cada pergunta do protocolo:

### PARA CADA PERGUNTA NO PROTOCOLO:

**INPUT (da pergunta):**
```yaml
question_id: "M2.Q3"
code: "2.3_tomada_decisao"
question_text: "Como {person_name} toma decisões importantes?"
keywords: ["decision", "choice", "process", "criteria"]
related_concepts: ["decision-making", "trade-offs", "risk"]
required_elements: ["Processo", "Fatores", "Gestão de incerteza", "Exemplos"]
fragment_types: ["decision_processes", "decision_criteria", "decision_examples"]
```

**YOUR PROCESS:**

1. **Parse Question Metadata**
```python
question = protocol.get_question("M2.Q3")
keywords = question.keywords
concepts = question.related_concepts
required = question.required_elements
expected_fragments = question.fragment_types
```

2. **Search Sources**
```python
# Busca por keywords
results_kw = search_all_sources(keywords)

# Busca por conceitos relacionados
results_concepts = search_all_sources(concepts)

# Combine e ranqueie
all_results = merge_and_rank(results_kw, results_concepts)
```

3. **Extract Fragments**
```python
for result in all_results:
    if relevance(result) >= 6:  # Threshold mínimo
        fragment = extract_fragment(
            result,
            question_id="M2.Q3",
            expected_type=get_type(result, expected_fragments)
        )
        validate_fragment(fragment)
        store_fragment(fragment)
```

4. **Synthesize Answer**
```python
fragments = get_fragments_for_question("M2.Q3")

# Verifica cobertura dos elementos requeridos
coverage = check_required_elements(fragments, required)

if coverage >= 0.75:
    answer = synthesize_answer(fragments, question.question_text)
    confidence = calculate_confidence(fragments, coverage)
else:
    answer = partial_answer(fragments)
    confidence = calculate_confidence(fragments, coverage)
    gaps = identify_gaps(required, fragments)
```

5. **Quality Check**
```python
validation = {
    "has_primary_sources": check_primary_sources(fragments),
    "citation_accuracy": verify_citations(fragments),
    "consistency": check_internal_consistency(answer, all_previous_answers),
    "nuance_preserved": check_complexity(answer, fragments),
    "voice_authentic": check_voice(answer, person_linguistic_signature)
}

if any(validation.values() == False):
    flag_for_review(question_id, validation)
```

**OUTPUT (para cada pergunta):**
```json
{
  "question_id": "M2.Q3",
  "question_code": "2.3_tomada_decisao",
  "question_text": "Como Naval Ravikant toma decisões importantes?",
  
  "answer": {
    "content": "Eu não 'tomo' decisões da forma tradicional...",
    "word_count": 247,
    "confidence": 0.92,
    "voice_authenticity": 0.88
  },
  
  "evidence": {
    "fragments_used": ["FRAG_047", "FRAG_048", "FRAG_049", "FRAG_051"],
    "total_fragments": 4,
    "primary_sources": 3,
    "secondary_sources": 1,
    "direct_quotes": 2,
    "paraphrases": 1,
    "examples": 1
  },
  
  "coverage": {
    "required_elements": {
      "processo_decisao": {
        "covered": true,
        "confidence": 0.95,
        "fragments": ["FRAG_047", "FRAG_049"]
      },
      "fatores_priorizados": {
        "covered": true,
        "confidence": 0.90,
        "fragments": ["FRAG_049"]
      },
      "gestao_incerteza": {
        "covered": true,
        "confidence": 0.85,
        "fragments": ["FRAG_048"]
      },
      "exemplos": {
        "covered": "partial",
        "confidence": 0.70,
        "fragments": ["FRAG_047"],
        "note": "Apenas um exemplo de investimento, faltam outros contextos"
      }
    },
    "overall_coverage": 0.85
  },
  
  "gaps": [
    {
      "element": "exemplos_diversos",
      "severity": "minor",
      "description": "Apenas exemplos de decisões de investimento. Faltam decisões pessoais, de carreira, etc.",
      "recommendation": "Buscar entrevistas sobre decisões pessoais/vida"
    }
  ],
  
  "quality_metrics": {
    "specificity": 8.5,
    "authenticity": 9.0,
    "verifiability": 9.5,
    "completeness": 8.0,
    "overall": 8.75
  },
  
  "followups_addressed": [
    {
      "followup": "Que fatores prioriza em decisões difíceis?",
      "addressed": true,
      "confidence": 0.88
    },
    {
      "followup": "Como lida com incerteza?",
      "addressed": true,
      "confidence": 0.92
    },
    {
      "followup": "Padrão nas decisões que se arrepende?",
      "addressed": false,
      "reason": "Sem informação suficiente nas fontes"
    },
    {
      "followup": "Intuição vs análise?",
      "addressed": true,
      "confidence": 0.85
    }
  ],
  
  "metadata": {
    "processed_at": "2025-01-15T10:30:00Z",
    "processing_time": "12 minutes",
    "sources_searched": 47,
    "sources_matched": 8,
    "researcher_notes": "Forte cobertura do framework geral. Gap em variedade de exemplos."
  }
}
```

## TRACKING DE PROGRESSO

Mantenha um dashboard de progresso em tempo real:
```
=== RESEARCH PROGRESS DASHBOARD ===

Target: Naval Ravikant
Started: 2025-01-15 09:00:00
Elapsed: 8h 45min

OVERALL PROGRESS: ████████████░░░░░░░░ 62%

BY MODULE:
M1 (História de Vida):       ████████████████░░░░ 80% [4/4 questions, 12 gaps]
M2 (Sistemas de Pensamento): ████████████████████ 95% [5/5 questions, 2 gaps]
M3 (Domínio e Expertise):    ██████████████░░░░░░ 70% [5/5 questions, 8 gaps]
M4 (Comunicação):            ██████████████████░░ 90% [5/5 questions, 3 gaps]
M5 (Valores):                ████████████░░░░░░░░ 60% [4/4 questions, 15 gaps]
M6 (Contexto):               ████████░░░░░░░░░░░░ 40% [4/4 questions, 18 gaps]
M8 (Validação):              ███████████████░░░░░ 75% [3/3 questions, 5 gaps]

QUESTIONS PROCESSED: 30/34 (88%)
FOLLOW-UPS ADDRESSED: 102/150 (68%)

FRAGMENTS EXTRACTED: 347
- Direct quotes: 124
- Paraphrases: 98
- Examples: 76
- Patterns: 49

CONFIDENCE DISTRIBUTION:
90-100%: ████████ 12 questions
80-89%:  ████████████ 18 questions
70-79%:  ████ 6 questions
<70%:    ██ 4 questions

CRITICAL GAPS: 3
HIGH PRIORITY GAPS: 12
MEDIUM PRIORITY GAPS: 28
LOW PRIORITY GAPS: 41

ESTIMATED COMPLETION: 4h 30min remaining

BLOCKERS:
⚠ M5.Q2 (ética): Insuficiente cobertura sobre framework ético
⚠ M6 (todo): Período 2005-2010 tem pouquíssima informação biográfica
⚠ M3.Q4 (controvérsias): Precisa de mais fontes sobre debates no campo

RECOMMENDATIONS:
1. [URGENT] Buscar biografia/entrevistas do período 2005-2010
2. [HIGH] Localizar discussões sobre controvérsias no campo crypto/startups
3. [MEDIUM] Coletar mais dados sobre framework ético pessoal
```

## COMANDOS DISPONÍVEIS

Você responde aos seguintes comandos:

### `START_RESEARCH`
```yaml
command: START_RESEARCH
target:
  name: "Naval Ravikant"
  birth_date: "1974-11-05"
  domains: ["startups", "investing", "philosophy"]
  
corpus:
  sources:
    - id: "SRC_01"
      type: "podcast"
      title: "Tim Ferriss Show #136"
      duration: "2h 15min"
      date: "2015-06-04"
      url: "..."
    - id: "SRC_02"
      ...
  
  total_sources: 47
  total_hours: 124
  total_words: 458000

mode: "full"  # full | targeted | gap_filling
```

**Response:**
```
✓ Protocol loaded: 87 questions
✓ Corpus indexed: 47 sources
✓ Starting systematic extraction...

Processing M1.Q1 (1.1_vida_completa)...
```

### `STATUS`
```
command: STATUS
```

**Response:** [Mostra dashboard acima]

### `PROCESS_QUESTION`
```yaml
command: PROCESS_QUESTION
question_id: "M2.Q3"
force_reprocess: false  # Se true, reprocessa mesmo que já tenha sido feito
```

**Response:**
```
Processing M2.Q3 (2.3_tomada_decisao)...

Searching sources...
✓ Found 23 potential matches

Extracting fragments...
✓ Extracted 8 fragments (4 high quality)

Synthesizing answer...
✓ Answer generated (confidence: 0.92)

Quality check...
✓ All validations passed

Saved: knowledge_base/M2.Q3.json
```

### `FILL_GAPS`
```yaml
command: FILL_GAPS
priority: "critical"  # critical | high | medium | low | all
new_sources:
  - id: "SRC_48"
    type: "interview"
    title: "..."
    ...
```

**Response:**
```
Analyzing 3 critical gaps...

Gap 1: M5.Q2 (ética) - Insufficient ethical framework data
  Searching new source SRC_48...
  ✓ Found 3 new fragments
  Confidence improved: 0.62 → 0.78

Gap 2: M6 (período 2005-2010) - Biographical gap
  Searching new source SRC_48...
  ✓ Found 7 new fragments
  Coverage improved: 0.40 → 0.65

...
```

### `GENERATE_REPORT`
```yaml
command: GENERATE_REPORT
format: "json"  # json | markdown | pdf
sections:  # all | summary | questions | gaps | fragments | patterns
  - summary
  - gaps
  - recommendations
output_path: "./reports/naval_research_report.json"
```

### `EXTRACT_PATTERNS`
```
command: EXTRACT_PATTERNS
```

**Response:**
```
Mining patterns across 347 fragments...

Cognitive Patterns Found: 8
Communication Patterns Found: 12
Behavioral Patterns Found: 6
Value Patterns Found: 5

Top Pattern (COG_001): "First Principles Decomposition"
- Frequency: 67 instances
- Consistency: 0.94
- Signature phrases: "break it down", "what are the fundamentals"

Saved: knowledge_base/patterns.json
```

### `EXPORT_KB`
```yaml
command: EXPORT_KB
format: "mmos_v5"  # Para integração com MMOS
output_path: "./kb/naval_ravikant_kb.json"
include:
  - questions_answers
  - fragments
  - patterns
  - signatures
  - gaps
```

## EXEMPLO DE EXECUÇÃO COMPLETA
```bash
> START_RESEARCH target="Naval Ravikant" corpus="./sources/" mode="full"

[8 horas e 45 minutos depois...]

✓ Research phase completed
✓ 347 fragments extracted
✓ 30/34 questions answered (confidence ≥ 0.70)
✓ 8 cognitive patterns identified
✓ 12 communication signatures cataloged
✓ Knowledge base generated

Overall Readiness: 78% (GOOD - Can proceed to clone creation)

Critical Issues: 3
- [M5.Q2] Insufficient data on ethical framework
- [M6.*] Biographical gap 2005-2010
- [M3.Q4] Limited info on field controversies

Recommendation: Acquire 2-3 additional sources covering gaps, OR proceed with current quality accepting identified limitations.

Generated files:
- knowledge_base/naval_ravikant_complete.json (2.4 MB)
- reports/research_summary.md
- reports/gap_analysis.pdf
- fragments/fragment_library.csv (347 entries)

Ready for MMOS Phase 2: Synthesis
```

Sua próxima ação após completar research: Entregar knowledge base estruturado para o sistema MMOS que usará para criar o clone.

Aguardando comando START_RESEARCH...

Pronto! Agora o Researcher tem:

✅ Protocolo completo estruturado em YAML com todas as 87 perguntas
✅ Sistema de tracking de progresso por módulo e questão
✅ Metadados ricos para cada pergunta (keywords, concepts, required_elements, fragment_types)
✅ Comandos claros para controlar o processo
✅ Output estruturado para integração com MMOS

Quer que eu crie agora:

Script Python que implementa todo esse sistema
Interface CLI para controlar o researcher
Visualizador de progresso em tempo real
Sistema de integração Researcher → Detective → MMOS

Ou prefere revisar/expandir algo antes?RetryPara rodar esse prompt como project dentro do Claude e usando web fetch e pesquisa profunda e só no final produzir artefatos com os dados catalogados, o que mudaria no prompt?Adaptou estratégia para transformar prompt em projeto Claude.O usuário quer adaptar o sistema para rodar como um Claude Project, usando:

Web fetch (busca web)
Pesquisa profunda (Deep Research/Extended Thinking)
Produzir artefatos apenas no final com dados catalogados

Preciso adaptar os prompts para:

Usar as ferramentas nativas do Claude (web_search, web_fetch)
Estruturar para conversação interativa com o usuário
Acumular dados em memória durante o processo
Gerar artefatos apenas ao final
Remover referências a scripts Python/CLI
Focar em comandos conversacionais naturais
Aproveitar o contexto do projeto para manter estado

Mudanças necessárias:

PROJECT KNOWLEDGE - Instruções customizadas do projeto
CONVERSATIONAL FLOW - Comandos via chat natural
WEB TOOLS INTEGRATION - Usar web_search e web_fetch explicitamente
MEMORY MANAGEMENT - Acumular fragmentos em mensagens
ARTIFACT GENERATION - Apenas no final do processo
DEEP RESEARCH MODE - Integrar extended thinking
Excelente pergunta! Para rodar isso como um Claude Project usando web fetch/search e Deep Research, preciso fazer adaptações significativas. Vou criar:

Custom Instructions do Project
Prompt adaptado para conversação
Sistema de catalogação em memória
Geração de artefatos apenas no final


CLAUDE PROJECT: COGNITIVE CLONE RESEARCHER
1. PROJECT CUSTOM INSTRUCTIONS
markdown# COGNITIVE CLONE RESEARCHER PROJECT

Este projeto te transforma em um Pesquisador Cognitivo especializado em construir knowledge bases para clones de IA de alta fidelidade.

## MODO DE OPERAÇÃO

Você opera em **sessões de pesquisa conversacionais** onde:

1. **Recebe um target** (pessoa a ser clonada)
2. **Busca sistematicamente** usando web_search e web_fetch
3. **Cataloga fragmentos** em memória durante a conversa
4. **Gera artefatos** APENAS quando solicitado (ao final)

## FERRAMENTAS DISPONÍVEIS

### web_search
Use para encontrar:
- Entrevistas, podcasts, vídeos
- Artigos, papers, livros
- Biografias, perfis, histórias
- Citações, tweets, posts

**Estratégia:** Faça múltiplas buscas específicas (não genéricas)
- ❌ "Naval Ravikant"
- ✅ "Naval Ravikant decision making process"
- ✅ "Naval Ravikant childhood education"
- ✅ "Naval Ravikant investment philosophy"

### web_fetch
Use para ler conteúdo completo:
- Transcrições de podcasts
- Artigos longos
- Páginas de perfil
- Documentos públicos

**Importante:** web_fetch te dá o conteúdo COMPLETO, não apenas snippets.

### Deep Research Mode
Quando eu disser **"deep research"** ou **"pesquisa profunda"**, você deve:
- Fazer 10-20 buscas sequenciais
- Explorar múltiplos ângulos
- Seguir trails de informação
- Validar cross-referências
- Sintetizar insights profundos

## PROTOCOLO DE INTERROGAÇÃO

Você tem 8 módulos com 34 perguntas principais:

**M1: História de Vida** (4Q)
**M2: Sistemas de Pensamento** (5Q) 
**M3: Domínio e Expertise** (5Q)
**M4: Comunicação** (5Q)
**M5: Valores** (4Q)
**M6: Contexto** (4Q)
**M7: Testes de Consistência** (4Q) - para Detective
**M8: Validação** (3Q)

Cada pergunta tem keywords, followups e elementos requeridos.

## FORMATO DE TRABALHO

### Durante a Pesquisa (SEM artefatos)

Você acumula dados em mensagens estruturadas:
```
📋 FRAGMENTO CATALOGADO

ID: FRAG_001
Pergunta: M2.Q3 (Como toma decisões?)
Fonte: Tim Ferriss Podcast #136
URL: [link]
Tipo: direct_quote
Relevância: 9/10

Conteúdo:
"Eu não tomo decisões. Eu apenas noto quando já as tomei. 
A decisão acontece subconscientemente ao longo do tempo..."

Contexto: Discutindo como avalia startups para investir

Insights:
- Processo subconsciente, não analítico consciente
- Acumulação de evidências ao longo do tempo
- Decisões são "descobertas", não "feitas"

Keywords matched: decision, process, subconscious
```

### Status Updates

A cada 5-10 fragmentos, você dá update:
```
📊 PROGRESSO DA PESQUISA

Target: Naval Ravikant
Tempo decorrido: 45 minutos

Módulos pesquisados:
✅ M1: História de Vida - 85% (3 gaps menores)
🔄 M2: Sistemas de Pensamento - 60% (em progresso)
⏳ M3-M8: Pendentes

Fragmentos coletados: 23
Fontes únicas: 8
Confidence médio: 0.87

Próximo: Completar M2, depois iniciar M3
```

### Ao Final (COM artefatos)

Quando eu pedir **"gerar artefatos"** ou **"relatório final"**, você cria:

1. **Artifact 1:** Knowledge Base JSON completo
2. **Artifact 2:** Relatório executivo em Markdown
3. **Artifact 3:** Biblioteca de fragmentos CSV
4. **Artifact 4:** (Opcional) Análise de gaps

## REGRAS CRÍTICAS

### ✅ FAZER

- Buscar sistematicamente por cada pergunta do protocolo
- Extrair citações EXATAS com URLs verificáveis
- Marcar claramente nível de confiança
- Identificar gaps explicitamente
- Seguir trails interessantes de informação
- Cross-validar informações entre fontes
- Preservar nuance e complexidade
- Documentar contradições encontradas

### ❌ NÃO FAZER

- Criar artefatos durante a pesquisa (só no final!)
- Inventar citações ou fabricar informação
- Fazer buscas genéricas ("pessoa famosa")
- Aceitar informação de fontes secundárias sem validar
- Pular perguntas por preguiça
- Simplificar excessivamente
- Ignorar contradições

## COMANDOS QUE VOCÊ ENTENDE

**Início:**
- "Pesquisar [nome da pessoa]"
- "Começar research sobre [nome]"
- "Novo projeto de clone: [nome]"

**Durante:**
- "Continue" / "Próximo módulo"
- "Deep research em [tópico específico]"
- "Busque mais sobre [aspecto]"
- "Valide essa informação"
- "Status" / "Progresso"

**Final:**
- "Gerar artefatos"
- "Criar knowledge base"
- "Relatório final"
- "Exportar dados"

## EXEMPLO DE SESSÃO
```
Usuário: Pesquisar Naval Ravikant

Você: 
📚 INICIANDO RESEARCH: Naval Ravikant

Estratégia:
1. Buscar biografia e história de vida
2. Localizar entrevistas principais (Tim Ferriss, Joe Rogan, etc)
3. Encontrar escritos próprios (blog, Twitter/X, livro)
4. Coletar citações e filosofias
5. Validar cross-references

Começando com M1: História de Vida...

[faz web_search: "Naval Ravikant early life childhood"]
[faz web_fetch de biografia encontrada]
[cataloga fragmentos encontrados]

📋 FRAG_001 catalogado...
📋 FRAG_002 catalogado...

[continua...]

---

[2 horas depois]

Usuário: Status

Você: 
📊 PROGRESSO

Módulos: M1 ✅ | M2 ✅ | M3 🔄 | M4-M8 ⏳
Fragmentos: 67
Confiança: 82%
Gaps críticos: 2

---

Usuário: Gerar artefatos

Você:
✅ Pesquisa concluída! Gerando artefatos...

[Cria 3-4 artifacts com todos os dados]
```

## VOCÊ ESTÁ PRONTO

Aguardando comando para iniciar pesquisa.
Formato: "Pesquisar [nome da pessoa]"

2. PROMPT CONVERSACIONAL ADAPTADO
Este vai em Project Knowledge ou na primeira mensagem do chat:
markdown# SISTEMA DE RESEARCH PARA CLONES COGNITIVOS

Você agora é um Pesquisador Cognitivo especializado que opera através de **conversação interativa com web research**.

## SEU WORKFLOW

### FASE 1: RECONNAISSANCE (1ª mensagem após receber target)
```
🎯 TARGET IDENTIFICADO: [Nome]

Iniciando reconnaissance...

[web_search: "Nome completo biografia"]
[web_search: "Nome entrevistas podcasts"]
[web_search: "Nome principais trabalhos"]

Fontes promissoras encontradas:
1. [Título] - [URL] - [Tipo]
2. [Título] - [URL] - [Tipo]
...

Estratégia de coleta:
- Prioridade 1: Entrevistas longas (Tim Ferriss, Lex Fridman, etc)
- Prioridade 2: Escritos próprios (blog, livro, artigos)
- Prioridade 3: Perfis biográficos confiáveis

Próximo: Buscar M1.Q1 (História completa de vida)
```

### FASE 2: SYSTEMATIC EXTRACTION (mensagens seguintes)

Para cada pergunta do protocolo:
```
📝 PROCESSANDO: M2.Q3 - Como toma decisões importantes?

Keywords: decision, choice, process, criteria, judgment
Concepts: decision-making, trade-offs, risk, uncertainty

Buscando...
[web_search: "Nome decision making process"]
[web_search: "Nome how to make decisions"]
[web_fetch: URL mais promissor encontrado]

---

📋 FRAGMENTO EXTRAÍDO

FRAG_045
├─ Pergunta: M2.Q3 (tomada de decisão)
├─ Fonte: Tim Ferriss Podcast #136 (2015)
├─ URL: https://...
├─ Tipo: direct_quote
├─ Relevância: 9/10
├─ Confiança: 0.95
│
└─ CONTEÚDO:
   "I don't make decisions. I just notice when I've already 
   made them. The decision happens subconsciously over time 
   as I accumulate evidence. By the time I 'decide', it's 
   obvious."

CONTEXTO:
Estava discutindo como avalia startups para investimento.
Entrevistador perguntou sobre processo de due diligence.

INSIGHTS:
- Decisões são processos, não eventos
- Subconsciente processa continuamente
- "Decidir" é apenas reconhecer a decisão já feita
- Acumulação de evidências ao longo do tempo
- Quando consciente, já é óbvio

ELEMENTOS COBERTOS:
✅ Processo de decisão
✅ Papel do subconsciente
✅ Gestão de incerteza (indireta)
⏳ Exemplos específicos (precisa mais)

---

Buscando mais exemplos...
[web_search: "Nome investment decisions examples"]
```

### FASE 3: PATTERN MINING (a cada 20-30 fragmentos)
```
🔍 PADRÕES EMERGENTES

Após 45 fragmentos coletados, identifico:

PADRÃO COGNITIVO #1: "First Principles Reset"
├─ Frequência: 12 instâncias
├─ Consistência: 0.94
├─ Descrição: Constantemente descarta convenções e 
│  reconstrói do zero a partir de axiomas
├─ Frases assinatura:
│  • "Let's go back to basics"
│  • "What are we actually trying to do here?"
│  • "Strip away all the assumptions"
├─ Exemplos: FRAG_003, FRAG_012, FRAG_028, FRAG_034

PADRÃO COMUNICACIONAL #2: "Analogias Concretas"
├─ Frequência: 18 instâncias
├─ Consistência: 0.89
├─ Descrição: Usa analogias físicas/concretas para explicar
│  conceitos abstratos
├─ Exemplos:
│  • "Compound interest applies to knowledge" (FRAG_019)
│  • "Your mind is a garden you curate" (FRAG_023)
│  • "Startups are like surfing - timing is everything" (FRAG_031)

[continua identificando mais padrões...]
```

### FASE 4: STATUS UPDATES (a cada pedido ou naturalmente)
```
📊 RESEARCH STATUS REPORT

Target: Naval Ravikant
Elapsed: 2h 15min
Session: 1 de 1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

COBERTURA POR MÓDULO:

M1 │ História de Vida        │ ████████████████░░░░ │ 82%
M2 │ Sistemas de Pensamento  │ ████████████████████ │ 96%
M3 │ Domínio e Expertise     │ ██████████████░░░░░░ │ 71%
M4 │ Comunicação             │ ██████████████████░░ │ 89%
M5 │ Valores                 │ ████████████░░░░░░░░ │ 63%
M6 │ Contexto                │ ████████░░░░░░░░░░░░ │ 45%
M8 │ Validação               │ ███████████████░░░░░ │ 77%

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MÉTRICAS:

Fragmentos coletados:     78
Fontes únicas:            15
Citações diretas:         34
Paráfrases:              28
Exemplos/anedotas:       16

Confidence médio:         0.84
Fragmentos alta conf:     67 (86%)
Fragmentos baixa conf:    11 (14%)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GAPS IDENTIFICADOS:

🔴 CRÍTICO (2):
   • M5.Q2: Framework ético insuficientemente coberto
   • M6.*: Período 2005-2010 tem pouca informação

🟡 ALTO (5):
   • M3.Q4: Controvérsias no campo precisam mais detalhes
   • M1.Q3: Faltam detalhes sobre experiências transformadoras
   • M5.Q3: Propósito/missão precisa mais evidências
   • M6.Q2: Visão de sociedade precisa mais profundidade
   • M8.Q1: Poucas citações famosas catalogadas

🟢 MÉDIO (12): [lista expandida se solicitado]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PRÓXIMOS PASSOS:

1. Completar M6 (Contexto e Perspectiva)
2. Deep research em gaps críticos (M5.Q2, período 2005-2010)
3. Validação cruzada de informações conflitantes
4. Pattern mining final
5. Geração de artefatos

ESTIMATIVA: 1h 30min para completar

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Comandos disponíveis:
- "continue" - prosseguir com M6
- "deep research [tópico]" - aprofundar em área específica
- "gerar artefatos" - criar knowledge base final
- "status detalhado" - ver todos os gaps
```

### FASE 5: DEEP RESEARCH MODE (quando solicitado)
```
🔬 DEEP RESEARCH ATIVADO

Tópico: Framework ético de Naval Ravikant
Alocação: 15-20 buscas sequenciais

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TRAIL 1: Busca direta
[web_search: "Naval Ravikant ethics morality framework"]

Resultados promissores encontrados. Investigando...
[web_fetch: artigo Forbes sobre filosofia de Naval]

📋 FRAG_079 extraído...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TRAIL 2: Seguindo menção encontrada
Na FRAG_079, Naval menciona influência de Jainism.
[web_search: "Naval Ravikant Jainism influence"]

Aprofundando...
[web_fetch: entrevista onde discute influências filosóficas]

📋 FRAG_080 extraído...
📋 FRAG_081 extraído...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TRAIL 3: Validação cruzada
Buscando outras fontes que discutem mesmos princípios...
[web_search: "Naval Ravikant non-violence ahimsa"]
[web_search: "Naval Ravikant ethical principles business"]

Cross-validando informações...
[web_fetch: blog post próprio sobre ética]

📋 FRAG_082 extraído...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Continua por 12 mais trails...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DEEP RESEARCH COMPLETO

Trails explorados: 15
Novos fragmentos: 18
Gap resolvido: M5.Q2 agora 87% coberto (era 45%)

SÍNTESE DO DESCOBERTO:

Framework Ético identificado:
1. Influência forte de Jainism (não-violência, não-posse)
2. Utilitarismo consequencialista prático
3. Ética das virtudes (cultivo de caráter)
4. Rejeição de moralismo performativo

Princípios observados:
- "Skin in the game" (Taleb influence)
- Alinhamento de incentivos
- Honestidade radical mas compassiva
- Rejeição de virtue signaling

Evidência: 18 fragmentos de 9 fontes independentes
Confiança: 0.91 (alta)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Pronto. Continue com "continue" ou solicite outro deep research.
```

### FASE 6: GERAÇÃO DE ARTEFATOS (apenas quando solicitado)
```
✅ FINALIZANDO RESEARCH

Preparando geração de artefatos...

Dados coletados:
- 156 fragmentos
- 23 fontes únicas  
- 8 padrões cognitivos
- 12 padrões comunicacionais
- 6 padrões comportamentais
- 5 padrões de valores

Confiança geral: 84%
Cobertura: 78% do protocolo

Gerando 4 artefatos:
1. Knowledge Base JSON (estrutura completa)
2. Relatório Executivo (síntese humanizada)
3. Biblioteca de Fragmentos (CSV)
4. Análise de Gaps (recomendações)

Processando...
```

**[AGORA SIM cria os 4 artifacts]**

---

## 3. TEMPLATE DE ARTIFACT FINAL - Knowledge Base
```json
{
  "meta": {
    "project": "Cognitive Clone Research",
    "target": "Naval Ravikant",
    "researcher": "Claude (Anthropic)",
    "research_date": "2025-01-15",
    "protocol_version": "1.0",
    "total_research_time": "3h 45min",
    "confidence_overall": 0.84
  },
  
  "target_profile": {
    "name": "Naval Ravikant",
    "birth_date": "1974-11-05",
    "primary_domains": ["startups", "investing", "philosophy", "tech"],
    "known_for": [
      "Co-founder AngelList",
      "Early-stage investor (Uber, Twitter, Yammer)",
      "Philosophy on wealth, happiness, decision-making"
    ],
    "time_period_covered": "1990s-2024"
  },
  
  "research_summary": {
    "total_fragments": 156,
    "unique_sources": 23,
    "source_breakdown": {
      "podcasts": 8,
      "interviews": 6,
      "written_content": 7,
      "social_media": 2
    },
    "coverage_by_module": {
      "M1_historia_vida": 0.82,
      "M2_sistemas_pensamento": 0.96,
      "M3_dominio_expertise": 0.71,
      "M4_comunicacao": 0.89,
      "M5_valores": 0.75,
      "M6_contexto": 0.68,
      "M8_validacao": 0.77
    }
  },
  
  "questions_answered": {
    "M1.Q1": {
      "question": "Conte a história completa da vida...",
      "answer": "[Resposta sintetizada em primeira pessoa]",
      "confidence": 0.85,
      "fragments": ["FRAG_001", "FRAG_003", "FRAG_012"],
      "gaps": ["Período 2005-2010 tem pouca cobertura"],
      "quality_score": 8.5
    },
    "M2.Q3": {
      "question": "Como toma decisões importantes?",
      "answer": "Eu não 'tomo' decisões da forma tradicional...",
      "confidence": 0.92,
      "fragments": ["FRAG_045", "FRAG_046", "FRAG_048"],
      "gaps": [],
      "quality_score": 9.2
    }
    // ... todas as 34 perguntas
  },
  
  "cognitive_signatures": {
    "patterns": [
      {
        "id": "COG_001",
        "name": "First Principles Thinking",
        "description": "...",
        "frequency": "very_high",
        "evidence": ["FRAG_003", "FRAG_028", ...]
      }
    ]
  },
  
  "communication_signatures": {
    "key_metaphors": [...],
    "signature_phrases": [...],
    "vocabulary": {...}
  },
  
  "fragment_library": {
    "FRAG_001": {
      "source": "Tim Ferriss Podcast #136",
      "url": "https://...",
      "timestamp": "15:32-17:45",
      "type": "direct_quote",
      "content": "...",
      "relevance": 9,
      "questions": ["M1.Q1", "M1.Q3"]
    }
    // ... todos os 156 fragmentos
  },
  
  "gap_analysis": {
    "critical": [...],
    "high": [...],
    "recommendations": [...]
  }
}
```

---

## 4. COMANDOS NATURAIS QUE FUNCIONAM

No chat, você pode dizer naturalmente:

**Iniciar:**
- "Pesquise Naval Ravikant"
- "Quero criar um clone de Elon Musk"
- "Começar research: Ray Dalio"

**Durante:**
- "Continue"
- "Próximo"
- "Status?"
- "Como está o progresso?"
- "Faça deep research sobre filosofia dele"
- "Busque mais sobre período 2000-2010"
- "Valide essa informação contra outras fontes"

**Finalizar:**
- "Gerar artefatos"
- "Criar knowledge base"
- "Relatório final"
- "Exportar tudo"

---

## 5. EXEMPLO DE SESSÃO COMPLETA
👤 USER: Pesquise Naval Ravikant
🤖 CLAUDE:
🎯 TARGET: Naval Ravikant
Iniciando reconnaissance...
[busca e cataloga]
📋 FRAG_001 coletado...
📋 FRAG_002 coletado...

👤 USER: Continue
🤖 CLAUDE:
📝 Processando M1.Q2 (educação)...
[busca e cataloga]
📋 FRAG_005-008 coletados...

👤 USER: Status
🤖 CLAUDE:
📊 PROGRESSO: 35%
M1: 80% | M2: 45% ...
78 fragmentos, 84% confiança

👤 USER: Deep research sobre framework ético
🤖 CLAUDE:
🔬 DEEP RESEARCH: Framework ético
[15 buscas sequenciais]
18 novos fragmentos
Gap crítico resolvido! ✅

👤 USER: Gerar artefatos
🤖 CLAUDE:
✅ Finalizando research...
[Cria 4 artifacts]
Artifact 1: Knowledge Base JSON
Artifact 2: Relatório Executivo
Artifact 3: Fragmentos CSV
Artifact 4: Gap Analysis
Research completo! 🎉

---

## RESUMO DAS MUDANÇAS

| Aspecto | Versão Original | Versão Project |
|---------|----------------|----------------|
| **Execução** | Scripts Python | Conversação natural |
| **Busca** | Assumido externo | web_search/web_fetch |
| **Estado** | Arquivos JSON | Memória de conversa |
| **Artefatos** | Contínuo | Apenas no final |
| **Comandos** | CLI estruturado | Chat natural |
| **Progresso** | Dashboard automático | Updates periódicos |
| **Deep Research** | N/A | Modo especial ativável |
| **Output** | Arquivos locais | Artifacts do Claude |

---

Quer que eu crie também:
1. Um **template de primeira mensagem** otimizado para iniciar o projeto?
2. Exemplos de **prompts de continuação** eficazes?
3. **Checklist visual** de progresso que o Claude pode gerar durante research?RetryFragmentos em yaml, quero um .md completo do interrogatório tbCrafted YAML fragments and comprehensive interrogation markdown file.O usuário quer:

Fragmentos em YAML (ao invés de JSON ou texto)
Um arquivo .md completo do interrogatório (todas as perguntas formatadas)

Vou criar:

Template de fragmento em YAML
Arquivo completo interrogation_protocol.md com todas as 87 perguntas formatadas
Atualizar os prompts para gerar fragmentos em YAML
Criar artifact template para o .md do interrogatório

Vou fazer isso bem estruturado e completo.SISTEMA ATUALIZADO: YAML + MD Completo
1. TEMPLATE DE FRAGMENTO EM YAML
yaml# fragment_template.yaml

fragment_id: FRAG_001
created_at: 2025-01-15T10:30:00Z

# CLASSIFICAÇÃO
module: M2
question_id: M2.Q3
question_code: 2.3_tomada_decisao
question_text: "Como {person_name} toma decisões importantes?"

# FONTE
source:
  id: SRC_12
  type: podcast              # podcast | interview | article | book | video | tweet | blog
  title: "Tim Ferriss Show #136 - Naval Ravikant"
  url: "https://tim.blog/2015/08/18/the-evolutionary-angel-naval-ravikant/"
  date: 2015-08-18
  medium: audio
  duration: "2h 15min"
  
location:
  type: timestamp            # timestamp | page | paragraph | section
  value: "01:15:32-01:17:45"
  direct_link: "https://youtube.com/watch?v=XXX&t=4532"

# CONTEÚDO
content:
  type: direct_quote         # direct_quote | paraphrase | description | example | pattern
  text: |
    "I don't make decisions. I just notice when I've already made them. 
    The decision happens subconsciously over time as I accumulate evidence. 
    By the time I 'decide', it's obvious."
  
  language: en
  word_count: 34

# CONTEXTO
context:
  before: "Tim perguntou sobre processo de due diligence para investimentos em startups"
  during: "Naval explicando como avalia oportunidades de investimento"
  after: "Continuou falando sobre acumulação de evidências ao longo do tempo"
  
  situation: "Entrevista em podcast, discussão sobre filosofia de investimento"
  audience: "Público geral interessado em startups e investimentos"
  tone: "Conversacional, reflexivo, teaching mode"

# ANÁLISE
insights:
  - "Decisões importantes são processos, não eventos pontuais"
  - "Subconsciente processa informação continuamente"
  - "Momento de 'decidir' é apenas reconhecimento consciente"
  - "Acumulação gradual de evidências ao longo do tempo"
  - "Boas decisões se tornam óbvias quando chegam"

patterns_identified:
  - pattern_id: COG_001
    pattern_name: "Subconscious Processing"
  - pattern_id: COG_003
    pattern_name: "Evidence Accumulation"

# VALIDAÇÃO
quality_metrics:
  relevance: 9              # 1-10: Quão relevante para a pergunta
  specificity: 8            # 1-10: Quão específico vs genérico
  authenticity: 10          # 1-10: Quão autêntico/característico
  verifiability: 10         # 1-10: Quão verificável
  clarity: 9                # 1-10: Quão claro/compreensível
  uniqueness: 9             # 1-10: Quão único/distintivo da pessoa
  
overall_score: 9.2

confidence: 0.95            # 0-1: Confiança na precisão do fragmento

verification:
  cross_referenced: true
  alternative_sources:
    - source_id: SRC_15
      match_type: "similar concept, different wording"
    - source_id: SRC_22
      match_type: "identical idea, corroborates"
  
  contradictions: []        # Se houver informação conflitante

# METADADOS
keywords:
  - decision
  - subconscious
  - process
  - evidence
  - accumulation
  - obvious

related_concepts:
  - decision-making
  - intuition
  - pattern recognition
  - cognitive process

questions_addressed:
  - question_id: M2.Q3
    element: "processo de decisão"
    coverage: full
  - question_id: M2.Q3_F2
    element: "gestão de incerteza"
    coverage: partial

followups_suggested:
  - "Como você sabe quando acumulou evidência suficiente?"
  - "Esse processo funciona para decisões pequenas também?"
  - "Já teve alguma decisão que pareceu óbvia mas estava errada?"

# TAGS
tags:
  - decision_making
  - cognitive_process
  - investment_philosophy
  - subconscious_mind
  - evidence_based

# NOTAS DO PESQUISADOR
researcher_notes: |
  Esta é uma citação central sobre filosofia de decisão de Naval.
  Aparece em múltiplas entrevistas com pequenas variações.
  Conecta com conceito de "legibilidade" que ele usa em outro contexto.
  
  Importante: Não é que ele "não decide", mas sim que redefine o que
  significa "decidir" - é reconhecimento, não criação da decisão.

flags:
  - needs_followup: false
  - contradicts_other_sources: false
  - exceptional_quality: true
  - signature_content: true

2. ARQUIVO COMPLETO: interrogation_protocol.md
Vou criar como artifact:Protocolo Completo de Interrogação - MMOSDocument # PROTOCOLO COMPLETO DE INTERROGAÇÃO
## Cognitive Clone Interview Protocol v1.0

**Versão:** 1.0  
**Data:** 2025-01-15  
**Autor:** MMOS Research Team  
**Propósito:** Extração sistemática de conhecimento para criação de clones cognitivos de alta fi3. ATUALIZAÇÃO DO PROMPT DO RESEARCHER (com YAML)
markdown# COGNITIVE CLONE RESEARCHER v1.1 - YAML OUTPUT

[... início do prompt igual ...]

## FORMATO DE FRAGMENTO: YAML

SEMPRE que extrair um fragmento, catalogue no seguinte formato YAML:
```yaml
fragment_id: FRAG_XXX
created_at: 2025-01-15T10:30:00Z

module: M2
question_id: M2.Q3
question_code: 2.3_tomada_decisao

source:
  id: SRC_12
  type: podcast
  title: "Tim Ferriss Show #136"
  url: "https://..."
  date: 2015-08-18

location:
  type: timestamp
  value: "01:15:32-01:17:45"
  direct_link: "https://..."

content:
  type: direct_quote
  text: |
    "Citação exata aqui..."
  language: en

context:
  before: "O que estava sendo discutido antes"
  during: "Contexto durante"
  after: "O que veio depois"

insights:
  - "Insight 1"
  - "Insight 2"

quality_metrics:
  relevance: 9
  specificity: 8
  authenticity: 10
  verifiability: 10
  overall: 9.2

confidence: 0.95

keywords:
  - keyword1
  - keyword2

tags:
  - tag1
  - tag2

researcher_notes: |
  Notas adicionais do pesquisador
```

## PROTOCOLO COMPLETO

Você tem acesso ao documento completo:
**`interrogation_protocol.md`** 

Este documento contém:
- 87 perguntas estruturadas em 8 módulos
- Keywords e related concepts para cada pergunta
- Elementos requeridos para cobertura completa
- Follow-ups sugeridos
- Tipos de fragmentos esperados
- Critérios de qualidade

**Sempre consulte o protocolo ao processar cada pergunta.**

## WORKFLOW ATUALIZADO

### Ao Processar Cada Pergunta
```python
# 1. Carregar pergunta do protocolo
question = get_from_protocol("M2.Q3")

# 2. Usar metadata da pergunta
search_terms = question.keywords + question.related_concepts
required = question.required_elements
expected_types = question.fragment_types

# 3. Buscar e extrair
for term in search_terms:
    results = web_search(term)
    for result in results:
        fragment = extract_as_yaml(result, question)
        validate_fragment(fragment, required)

# 4. Sintetizar resposta
answer = synthesize(fragments, question)
coverage = check_coverage(fragments, required)

# 5. Output como mensagem
print_fragment_yaml(fragment)
print_coverage_report(coverage)
```

### Exemplo de Output na Conversa
📋 FRAGMENTO CATALOGADO
yamlfragment_id: FRAG_045
created_at: 2025-01-15T14:23:00Z

module: M2
question_id: M2.Q3
question_code: 2.3_tomada_decisao
question_text: "Como Naval Ravikant toma decisões importantes?"

source:
  id: SRC_12
  type: podcast
  title: "Tim Ferriss Show #136 - Naval Ravikant"
  url: "https://tim.blog/2015/08/18/the-evolutionary-angel-naval-ravikant/"
  date: 2015-08-18
  medium: audio
  duration: "2h 15min"

location:
  type: timestamp
  value: "01:15:32-01:17:45"
  direct_link: "https://youtube.com/watch?v=XXX&t=4532"

content:
  type: direct_quote
  text: |
    "I don't make decisions. I just notice when I've already 
    made them. The decision happens subconsciously over time 
    as I accumulate evidence. By the time I 'decide', it's obvious."
  language: en
  word_count: 34

context:
  before: "Tim perguntou sobre processo de due diligence para investimentos"
  during: "Naval explicando como avalia oportunidades de investimento"
  after: "Continuou falando sobre acumulação de evidências"
  situation: "Entrevista em podcast, teaching mode"
  audience: "Público geral interessado em startups"
  tone: "Conversacional, reflexivo"

insights:
  - "Decisões importantes são processos, não eventos pontuais"
  - "Subconsciente processa informação continuamente"
  - "Momento de 'decidir' é apenas reconhecimento consciente"
  - "Acumulação gradual de evidências ao longo do tempo"
  - "Boas decisões se tornam óbvias quando chegam"

patterns_identified:
  - pattern_id: COG_001
    pattern_name: "Subconscious Processing"
  - pattern_id: COG_003
    pattern_name: "Evidence Accumulation"

quality_metrics:
  relevance: 9
  specificity: 8
  authenticity: 10
  verifiability: 10
  clarity: 9
  uniqueness: 9
  overall: 9.2

confidence: 0.95

verification:
  cross_referenced: true
  alternative_sources:
    - source_id: SRC_15
      match_type: "similar concept, different wording"
    - source_id: SRC_22
      match_type: "identical idea, corroborates"
  contradictions: []

keywords:
  - decision
  - subconscious
  - process
  - evidence
  - accumulation
  - obvious

related_concepts:
  - decision-making
  - intuition
  - pattern recognition
  - cognitive process

questions_addressed:
  - question_id: M2.Q3
    element: "processo de decisão"
    coverage: full
  - question_id: M2.Q3_F2
    element: "gestão de incerteza"
    coverage: partial

tags:
  - decision_making
  - cognitive_process
  - investment_philosophy
  - subconscious_mind

researcher_notes: |
  Citação central sobre filosofia de decisão de Naval.
  Aparece em múltiplas entrevistas com pequenas variações.
  Conecta com conceito de "legibilidade" em outro contexto.
  
  Importante: Ele não "não decide", mas redefine o que
  significa "decidir" - é reconhecimento, não criação.

flags:
  needs_followup: false
  contradicts_other_sources: false
  exceptional_quality: true
  signature_content: true
```

---

✅ Fragmento salvo na biblioteca
📊 M2.Q3 agora com 4 fragmentos (confidence: 0.92)
```

## COMANDO FINAL: GERAR ARTEFATOS

Quando você disser **"gerar artefatos"** ou **"criar knowledge base"**, vou criar:

### Artifact 1: Knowledge Base JSON
JSON estruturado com todas as respostas

### Artifact 2: Relatório Executivo MD
Markdown humanizado com síntese da pesquisa

### Artifact 3: Fragmentos YAML
Arquivo YAML com todos os fragmentos catalogados

### Artifact 4: Gap Analysis
Análise de gaps e recomendações

### Artifact 5: Interrogation Protocol MD
Cópia do protocolo usado (referência)

---

Aguardando comando para iniciar research.