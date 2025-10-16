# 📚 Requisitos - Funcionalidade de Geração de Cursos

**Data:** 2025-10-14
**Status:** 🟡 Aguardando Preenchimento
**Responsável:** Alan Nicolas
**PO:** Sarah

---

## 📋 Instruções de Preenchimento

Por favor, preencha este documento respondendo às perguntas abaixo. Você pode:
- Marcar checkboxes com `[x]`
- Escrever respostas livres
- Selecionar opções (A, B, C, D)
- Adicionar notas/comentários em qualquer seção

**Quando concluir, avise-me para ler suas respostas e prosseguir com o design da task!**

---

## 1. Escopo & Modelo de Produto

### 1.1. Qual o modelo de curso que você quer suportar?

- [ ] Cursos auto-guiados (self-paced) - aluno segue no seu ritmo
- [ ] Cursos com datas/cohorts - turmas com início/fim definidos
- [X] Híbrido - suporta ambos os modelos
- [ ] Outro modelo: _________________________________

**Notas:** Cursos auto-guiados (self-paced) - aluno segue no seu ritmo


---

### 1.2. Qual a granularidade da estrutura?

**Selecione a opção preferida:**

```
[ ] Opção A: Curso → Módulos → Aulas → Conteúdo
[ ] Opção B: Curso → Seções → Lições → Atividades
[X] Opção C: Personalizável (usuário define a hierarquia)
[ ] Opção D: Outra hierarquia (descreva abaixo)
```

**Se escolheu D, descreva a hierarquia:**


**Notas:**


---

### 1.3. Tamanho típico dos cursos?

Marque os tamanhos que você quer suportar:

- [ ] Mini-curso: 3-5 aulas (1-2h total)
- [ ] Curso padrão: 8-15 aulas (4-8h total)
- [ ] Curso extenso: 20-40 aulas (15-30h total)
- [ ] Masterclass: 50+ aulas (40h+ total)
- [X] Flexível (todos os tamanhos acima)

**Tamanho prioritário para MVP:** Mini-curso: 3-5 aulas (1-2h total)


**Notas:**


---

## 2. Formatos de Entrega & Mídia

### 2.1. Quais formatos de conteúdo de aula?

Marque todos os formatos que devem ser suportados:

- [ ] Texto/Markdown (artigos escritos, ebooks)
- [ ] Scripts de vídeo (roteiros para gravar aulas em vídeo)
- [ ] Áudio/Podcast (scripts de áudio-aulas)
- [ ] Slides/Apresentações (estrutura de slides com talking points)
- [ ] Screencasts (tutoriais técnicos passo-a-passo)
- [ ] Webinars ao vivo (outline + talking points)
- [ ] Híbrido (combina múltiplos formatos na mesma aula)
- [ ] Outros: _________________________________
- [X] Todas opções.

**Formato prioritário para MVP:** Texto/Markdown (artigos escritos, ebooks)


**Notas:** Modo descritivo da aula, que será usado como base pelo professor e também já como descrição da aula abaixo do vídeo, ou onde pudermos colocar. Logo deve manter também o estilo de comunicação, pensamento e escrita do professor (mind) que vamos usar.


---

### 2.2. A task deve gerar apenas a estrutura ou o conteúdo completo?

**Selecione:**

```
[ ] Opção A: Apenas outline/estrutura (usuário preenche conteúdo depois)
[ ] Opção B: Conteúdo completo escrito (aulas prontas para publicar)
[ ] Opção C: Conteúdo parcial (introdução + outline detalhado + exemplos)
[X] Opção D: Configurável (usuário escolhe o nível de detalhamento)
```

**Nível de detalhamento preferido para MVP:**


**Notas:**


---

## 3. Elementos Pedagógicos & Didáticos

### 3.1. Quais componentes pedagógicos são obrigatórios?

Marque os componentes que DEVEM ser incluídos automaticamente:

- [X] Objetivos de aprendizagem (por módulo e por aula)
- [X] Pré-requisitos e nivelamento (o que o aluno precisa saber antes)
- [ ] Conteúdo instrucional (teoria, conceitos, explicações)
- [ ] Exemplos práticos (cases, demos, walkthroughs)
- [ ] Atividades práticas / exercícios
- [ ] Quizzes / avaliações formativas (durante o curso)
- [ ] Avaliações somativas (provas, exames finais)
- [ ] Projetos / trabalhos práticos (capstone projects)
- [X] Recursos complementares (leituras, ferramentas, links)
- [X] Resumos / recapitulações (final de cada módulo)
- [ ] Certificação (critérios para conclusão e certificado)
- [ ] Outros: _________________________________

**Componentes prioritários para MVP (top 3-5):**

1. 
2.
3.
4.
5.

**Notas:**


---

### 3.2. Frameworks pedagógicos a serem aplicados?

Marque os frameworks que a task deve aplicar automaticamente:

- [ ] **Bloom's Taxonomy** - 6 níveis de conhecimento (Lembrar → Entender → Aplicar → Analisar → Avaliar → Criar)
- [ ] **ADDIE** - Analysis, Design, Development, Implementation, Evaluation
- [ ] **Kolb's Learning Cycle** - Experiência concreta → Observação reflexiva → Conceituação abstrata → Experimentação ativa
- [ ] **Gagne's 9 Events of Instruction** - Gain attention, inform objectives, stimulate recall, present content, guide learning, elicit performance, provide feedback, assess performance, enhance retention
- [ ] **Backward Design** - Começar pelos objetivos finais e trabalhar de trás para frente
- [ ] **Microlearning** - Aulas curtas (5-10 min), focadas em um conceito
- [ ] **Flipped Classroom** - Conteúdo teórico antes, prática durante
- [ ] **Mastery Learning** - Aluno só avança após dominar tópico
- [ ] Nenhum framework específico (abordagem livre)
- [ ] Outros: _________________________________

**Framework principal para MVP:** Não sei. Considere o ICP para recomendar na hora de criar.


**Notas:**


---

### 3.3. Como lidar com diferentes níveis de conhecimento?

**Selecione:**

```
[X] Opção A: Um curso = um nível fixo (iniciante OU intermediário OU avançado)
[ ] Opção B: Curso adaptativo (caminhos diferentes por nível de conhecimento)
[ ] Opção C: Módulos opcionais (iniciantes fazem módulo básico, avançados pulam)
[ ] Opção D: Não diferenciar níveis (assume público homogêneo)
```

**Abordagem preferida:** Considere o ICP para recomendar na hora de criar.
 

**Notas:**


---

## 4. Personalização & Voz

### 4.1. Integração com MMOS (personality cloning)?

**Selecione:**

```
[ ] SIM - Usar minds do MMOS como "instrutores virtuais"
    Exemplo: "Curso de filosofia estóica no estilo Nassim Taleb"

[ ] SIM - Apenas para tom/voz (não conteúdo técnico especializado)
    Exemplo: Usar voice parameters mas não expertise técnica do clone

[ ] NÃO - Voz neutra/profissional padrão

[X] OPCIONAL - Usuário decide se quer usar persona ou não
```

**Preferência para MVP:**


**Se SIM, como validar fidelidade?**
- [X] Aplicar fidelity score (mesma métrica do blog post)
- [ ] Validação simplificada (apenas checagem básica de voz)
- [ ] Não validar (confiar na geração)

**Notas:**


---

### 4.2. Tom/estilo de ensino padrão?

Marque os estilos que devem ser suportados:

- [ ] Acadêmico/Formal (estilo universitário, rigoroso)
- [ ] Conversacional/Casual (amigável, como um mentor)
- [ ] Prático/Hands-on (foco em fazer, pouca teoria)
- [ ] Inspiracional/Motivacional (storytelling, transformacional)
- [ ] Socrático (baseado em perguntas e descoberta guiada)
- [ ] Técnico/Direto (objetivo, sem floreios)
- [X] Configurável por curso (usuário escolhe)
- [ ] Outros: _________________________________

**Estilo padrão para MVP:** Conversacional/Casual (amigável, como um mentor)


**Notas:** 


---

## 5. Estrutura de Saída & Arquivos

### 5.1. Como organizar os arquivos gerados?

**Selecione a estrutura preferida:**

```
[ ] Opção A: Estrutura multi-arquivo (um arquivo por aula)
/creator-os-workspace/courses/{course-slug}/
  ├── README.md                  # Visão geral do curso
  ├── curriculum.yaml            # Estrutura completa + metadata
  ├── module-01-foundations/
  │   ├── lesson-01-introduction.md
  │   ├── lesson-02-core-concepts.md
  │   ├── quiz-01.yaml
  │   └── resources/
  │       └── templates/
  ├── module-02-advanced/
  │   ├── lesson-01-deep-dive.md
  │   └── project-01.md
  └── assessments/
      └── final-exam.yaml

[ ] Opção B: Arquivo único consolidado
/creator-os-workspace/courses/{course-slug}/
  ├── course-complete.md         # Todo o conteúdo em um arquivo
  └── assets/
      └── images/

[ ] Opção C: Híbrido (outline único + aulas separadas)
/creator-os-workspace/courses/{course-slug}/
  ├── course-outline.md          # Estrutura completa
  ├── lessons/
  │   ├── 01-introduction.md
  │   ├── 02-foundations.md
  │   └── 03-advanced.md
  └── resources/

[ ] Opção D: Outra estrutura (descreva abaixo)

[X] Opção do Alan
/docs/courses/{course-slug}/
  |── course-outline.md          # Estrutura completa
  ├── README.md                  # Visão geral do curso
  ├── PRD.md                     # PRD Completo
  ├── curriculum.yaml            # Estrutura completa + metadata
  ├── lessons/
  │   ├── 1.1-nome-da-aula.md
  │   ├── 1.2-lesson.md
  │   ├── 2.1-lesson.md         # Quero os módulos separados por numeros e lessons depois o .
  │   ├── quiz-01.yaml
  │   └── resources/
  │       └── templates/
  ├── module-02-advanced/
  │   ├── lesson-01-deep-dive.md
  │   └── project-01.md
  └── assessments/
      └── final-exam.yaml
```

**Estrutura preferida:** a minha.


**Se escolheu D, descreva:** Eu quero algo flat, vamos ter banco de dados também então não preciasamos exagerar 


**Notas:**


---

### 5.2. Formato dos arquivos de aula?

Marque os formatos de arquivo que devem ser gerados:

- [X] **Markdown** (.md) - Fácil de editar, versionável, legível
- [X] **YAML** (.yaml) - Estruturado, fácil de parsear programaticamente
- [X] **JSON** (.json) - Para integração com APIs e plataformas
- [ ] **HTML** (.html) - Pronto para publicar em web
- [ ] **PDF** (.pdf) - Pronto para distribuir (geração via markdown → PDF)
- [ ] **SCORM** (pacote .zip) - Para LMS (Learning Management Systems)
- [ ] Múltiplos formatos (exportar para vários simultaneamente)

**Formato prioritário para MVP:** Vamos manter simples.


**Formatos secundários (se aplicável):**


**Notas:**


---

### 5.3. Metadados a serem incluídos?

Marque os metadados que devem ser gerados automaticamente:

- [X] Duração estimada (por aula e total do curso)
- [X] Nível de dificuldade (iniciante/intermediário/avançado)
- [X] Tags/categorias (ex: "python", "data-science", "hands-on")
- [X] Dependências entre aulas (aula X requer aula Y)
- [X] Objetivos de aprendizagem (por módulo e aula)
- [X] Pré-requisitos (conhecimento prévio necessário)
- [X] Tracking de progresso (campos para % completo)
- [X] SEO metadata (title, description, keywords - se publicar online)
- [X] Versão/última atualização
- [X] Autor/instrutor
- [ ] Licença (CC, proprietary, etc.)
- [ ] Outros: _________________________________

**Metadados essenciais para MVP:**


**Notas:**


---

## 6. Interatividade & Engajamento

### 6.1. Elementos de gamificação?

**Selecione:**

```
[ ] SIM - Incluir sistema de gamificação
    Marque os elementos desejados:
    [ ] Sistema de pontos/XP
    [ ] Badges/conquistas (milestones)
    [ ] Leaderboards (rankings entre alunos)
    [ ] Desafios progressivos (aumenta dificuldade)
    [ ] Unlocks (desbloquear conteúdo ao atingir meta)
    [ ] Streaks (dias consecutivos estudando)

[ ] NÃO - Curso tradicional sem gamificação

[X] OPCIONAL - Usuário decide se quer gamificação ou não
```

**Preferência para MVP:** Para o MVP não precisa.


**Notas:**


---

### 6.2. Elementos de comunidade/social?

Marque os elementos sociais/comunitários que devem ser incluídos:

- [ ] Fóruns de discussão (prompts para discussão ao final de cada módulo)
- [ ] Peer review (alunos avaliam trabalhos uns dos outros)
- [ ] Projetos colaborativos (trabalhos em grupo)
- [ ] Sessões de Q&A ao vivo (agendadas ou ad-hoc)
- [ ] Grupos de estudo (small groups)
- [ ] Não aplicável (estudo 100% solo)
- [ ] Outros: _________________________________

**Elementos prioritários para MVP:**


**Notas:** Não entendi onde isso se aplicaria.


---

## 7. Plataforma de Entrega & Integração

### 7.1. Onde os cursos serão hospedados/publicados?

Marque as plataformas que você pretende usar:

- [ ] **Plataforma própria** (website customizado, self-hosted)
- [ ] **LMS comercial**: Teachable, Thinkific, Kajabi, Podia
- [ ] **Marketplaces**: Udemy, Coursera, edX, Skillshare
- [ ] **Vídeo**: YouTube, Vimeo
- [ ] **Docs/Knowledge base**: Notion, GitBook, Confluence
- [ ] **Email**: Drip campaign (aulas por email)
- [ ] **Membership**: Patreon, Circle, Discord
- [ ] Múltiplas plataformas (exportar para várias)
- [X] Ainda não decidido
- [ ] Outras: _________________________________

**Plataforma principal para MVP:** Por enquanto vamos entregar apenas o resultado final e salvar isso no banco de dados.


**Notas:**


---

### 7.2. Precisa de integração técnica específica?

Marque as integrações necessárias:

- [ ] **SCORM** (padrão para LMS - Moodle, Canvas, Blackboard)
- [ ] **xAPI/Tin Can** (tracking avançado de aprendizagem)
- [ ] **API REST** (integrar com plataforma customizada)
- [ ] **Webhooks** (automações e notificações)
- [ ] **Zapier/Make** (integrações no-code)
- [ ] **Stripe/Gumroad** (pagamentos)
- [ ] **Mailchimp/ConvertKit** (email marketing)
- [X] Não - apenas arquivos estáticos (markdown, PDF, etc.)
- [ ] Outras: _________________________________

**Integrações essenciais para MVP:**


**Notas:**


---

## 8. Workflow de Criação

### 8.1. Qual o input inicial do usuário?

**Selecione a abordagem preferida:**

```
[ ] Opção A: Tópico livre (elicitação automática)
    Exemplo de comando:
    > *generate-course "Python para Data Science"

    A task faz todo o design instrucional automaticamente
    (define objetivos, público, duração, estrutura)

[ ] Opção B: Brief detalhado (formulário estruturado)
    Usuário preenche campos:
    - Título do curso
    - Público-alvo
    - Objetivos de aprendizagem
    - Duração desejada
    - Tópicos a cobrir
    - Nível de conhecimento

    A task estrutura com base no brief fornecido

[X] Opção C: Elicitação interativa guiada
    A task faz perguntas ao usuário:
    "Qual o título do curso?"
    "Quem é o público-alvo?"
    "Quantas horas deve durar?"
    "Que framework pedagógico usar?"

    Workflow conversacional passo-a-passo

[ ] Opção D: Upload de conteúdo existente
    Usuário fornece materiais (slides, notas, vídeos, docs)
    Task analisa e estrutura em curso pedagógico

[ ] Opção E: Híbrido (combina abordagens acima)
```

**Abordagem preferida para MVP:** Precisa também poder receber aulas que já foram criadas.


**Notas:**


---

### 8.2. Iteração e refinamento?

**Selecione o workflow preferido:**

```
[ ] Opção A: Geração completa + revisão final
    - Task gera curso completo de uma vez
    - Usuário revisa e pede ajustes no final
    - Edições pontuais via comandos

[ ] Opção B: Geração incremental com aprovação
    - Task gera módulo por módulo
    - Usuário aprova cada módulo antes de prosseguir
    - Permite ajustes contínuos

[X] Opção C: Preview + confirmação + geração
    - Task gera outline completo
    - Usuário aprova estrutura
    - Task gera conteúdo completo após aprovação

[ ] Opção D: Outro workflow (descreva abaixo)
```

**Workflow preferido:** VAMos começar com um formato bem Human in the loop para depois passar para YOLO, pois preciasamos no começo interagir muito e fazer ajustes nos prompts possívelmente.


**Se escolheu D, descreva:**


**Notas:**


---

## 9. Validação & Qualidade

### 9.1. Como validar qualidade pedagógica?

Marque as validações que devem ser aplicadas automaticamente:

- [X] **Checklist de design instrucional** (ADDIE, Bloom's, etc.)
- [X] **Alignment check** (objetivos ↔ conteúdo ↔ avaliações estão alinhados?)
- [X] **Carga cognitiva balanceada** (não sobrecarregar aluno com info)
- [X] **Progressão lógica** (dependências respeitadas, dificuldade crescente)
- [X] **Fidelity score** (se usar MMOS persona, validar voice consistency)
- [X] **Completeness check** (todos os componentes obrigatórios presentes?)
- [ ] **Accessibility check** (legível, navegável, inclusivo)
- [X] **Duração realista** (estimativas de tempo são viáveis?)
- [ ] Outras: _________________________________

**Validações essenciais para MVP:**


**Notas:**


---

### 9.2. Critérios de sucesso para a task?

**Defina métricas de sucesso:**

**Tempo de geração:**
- [ ] Curso completo gerado em < 10 minutos
- [ ] Curso completo gerado em < 30 minutos
- [ ] Curso completo gerado em < 1 hora
- [X] Tempo não é crítico

**Qualidade do output:**
- [X] Requer menos de 20% de edição manual
- [ ] Requer menos de 50% de edição manual
- [ ] Pronto para publicar sem edições
- [ ] Outro critério: _________________________________

**Alignment pedagógico:**
- [X] Alignment score > 90% (objetivos ↔ conteúdo ↔ avaliações)
- [ ] Alignment score > 80%
- [ ] Não medir (validação manual)

**Feedback do usuário:**
- [X] Usuário aprova estrutura sem grandes mudanças
- [ ] Usuário economiza 80%+ do tempo vs criação manual
- [ ] Curso é pedagogicamente sólido (validação externa)
- [ ] Outros: _________________________________

**Notas:**


---

## 10. Casos de Uso Prioritários

### 10.1. Qual o caso de uso #1 (MVP)?

**Selecione o cenário prioritário:**

```
[X] Creator solo criando curso técnico
    Exemplo: "Python para Data Science", "React Avançado"
    Foco: Conteúdo técnico preciso, exemplos de código, hands-on

[X] Empresa criando onboarding para funcionários
    Exemplo: "Onboarding Engenharia", "Cultura e Valores"
    Foco: Padronização, tracking de progresso, compliance

[X] Educador criando curso acadêmico
    Exemplo: "Introdução à Filosofia", "Cálculo I"
    Foco: Rigor pedagógico, referências, avaliações formais

[X] Coach criando programa de transformação
    Exemplo: "Produtividade para Founders", "Liderança Consciente"
    Foco: Storytelling, exercícios reflexivos, comunidade

[X] Marketer criando curso-produto (lead gen)
    Exemplo: "SEO para Startups", "Growth Hacking"
    Foco: SEO, conversão, upsell para produto principal

[ ] Outro: _________________________________
```

**Caso de uso #1 (MVP):** Todas e outras que nem listou.


**Notas:**


---

### 10.2. Exemplos concretos de cursos a serem gerados

Por favor, forneça **2-3 exemplos reais** de cursos que você gostaria de criar com esta task:

---

#### **Exemplo 1:**

**Título do curso:**


**Público-alvo:**


**Duração esperada:**


**Formato principal:** (texto, vídeo, híbrido)


**Objetivos principais:**
1.
2.
3.

**Componentes essenciais:**
- [ ] Teoria
- [ ] Exemplos práticos
- [ ] Exercícios
- [ ] Projeto final
- [ ] Quizzes
- [ ] Outros: _________________________________

**Persona MMOS (se aplicável):**


**Notas adicionais:**


---

#### **Exemplo 2:**

**Título do curso:**  Clone IA Express
Curso legado: /Users/oalanicolas/Documents/Code/mente_lendaria/docs/creatoros/courses/clones/legacy

**Público-alvo:**

O ICP DA COMUNIDADE LENDÁRIA
A Frase Que Define Nosso ICP:
"É o profissional experiente que já tentou de tudo, está cansado de promessas vazias, reconhece que o problema é falta de sistema e foco (não informação), entende que IA é o divisor de águas, e busca uma tribo de executores sérios para finalmente transformar seus anos de cicatrizes em vantagem competitiva imbatível."
Demografia Psicográfica (mais importante que idade/gênero):
Idade: 35-45 anos (núcleo), com forte presença 30-50 
Experiência: 15-20 anos de bagagem profissional sólida 
Momento: Em transição consciente e urgente (não mais negando) 
Estado mental: Saturado de promessas vazias, busca substância real
A Dor Central (O Que Realmente Os Move):
Superficial: "Quero automatizar com IA e ganhar mais"
Real: "Quero provar que ainda tenho valor e não desperdicei meu potencial"
Profunda: "Preciso construir algo próprio antes que seja tarde demais"

Estado Mental Atual:
Saturado de promessas vazias: Já comprou cursos demais, já ouviu guru demais, já tentou fórmula mágica demais. Agora quer substância, não mais um "método revolucionário".


Em transição consciente: Sabe que precisa mudar algo fundamental, não só otimizar o que já faz. Sente que está operando em 30% do seu potencial e isso o corrói por dentro.


Impaciente com mediocridade: Não aguenta mais reunião improdutiva, processo burocrático, gente que fala muito e faz pouco. Tem alergia a "enrolação".


Características Comportamentais:
Early adopter pragmático: Não usa IA porque é moda, usa porque já viu que quem não usar vai ficar para trás. Já tem ChatGPT, Claude, talvez Perplexity. Já tentou automatizar algo.


Executor frustrado: Tem mais ideias do que tempo. Começa muita coisa, termina pouca. Não por falta de disciplina, mas por falta de clareza sobre o que realmente importa.


Aprendiz compulsivo: Lê livro, ouve podcast, assiste YouTube, mas não pelo entretenimento. Está genuinamente buscando a peça que falta no quebra-cabeça da sua evolução.


Valores Fundamentais:
Autonomia > Segurança: Prefere o risco da liberdade à prisão do salário garantido.


Impacto > Status: Quer ser lembrado pelo que construiu, não pelo cargo que ocupou.


Verdade > Conforto: Prefere o soco na cara da realidade ao cafuné da mentira conveniente.


Velocidade > Perfeição: Entende que done is better than perfect, mas não confunde isso com fazer qualquer coisa.


Dores Latentes:
Sobrecarga cognitiva: Sabe que tem potencial mas se perde na execução. Muita informação, pouca clareza.


Isolamento do diferente: Se sente sozinho porque pensa diferente da maioria. Precisa de uma tribo que "fale sua língua".


Desperdício de potencial: A sensação de que o tempo está passando e não está criando o impacto que poderia.


Falta de sistema: Trabalha muito mas não escala. Cada dia é uma nova batalha ao invés de construir sobre o que já fez.


O que o move:
Ver resultado rápido e tangível, não teoria bonita
Estar cercado de gente que também está construindo algo
Ter acesso direto a quem já fez o caminho
Liberdade para experimentar e errar sem julgamento
Ferramentas que multiplicam sua capacidade, não mais tarefas
Red Flags (quem NÃO queremos):
Quem busca fórmula mágica ou resultado sem esforço
Quem quer que façam por ele ao invés de aprender a fazer
Quem reclama mais do que executa
Quem ainda acredita que IA é modinha ou perigo
Quem prefere a validação social à transformação real
Green Flags (indicadores de fit perfeito):
Já usa IA mas sabe que está subutilizando
Tem clareza de que o problema não é falta de informação, é falta de sistema
Valoriza mais a implementação do que a certificação
Entende que investir em si mesmo é o melhor ROI
Busca pares, não gurus

Em resumo:
Nosso ICP é o construtor frustrado que já tem consciência e ferramentas, mas falta clareza e comunidade. Alguém que não precisa ser convencido de que precisa mudar, só precisa do ambiente e sistema certos para sua transformação acontecer.

Qual o nível de consciência do avatar?

Desejo
Qual a uma coisa que o avatar mais deseja?
Porque o avatar merece conseguir seu desejo? O que ele tem/passou que o faz merecedor?
O que pessoas inferiores ao avatar estão conseguindo?


Problemas & Erros

Problema
Qual problema que o avatar está passando porque ele não tem o que deseja?
O que vai acontecer se ele não conseguir o que deseja?
Qual o principal motivo que o avatar diz porque ele não consegue o que deseja?

Problema central: Está preso no loop de consumir infinito conhecimento sem conseguir transformar em oferta vendável - sabe demais, executa de menos, foca em nada.
Consequências se não resolver:
Chegará aos 60 ainda dependente de salário/CLT
Família perderá respeito após tantas promessas não cumpridas
Morrerá com potencial desperdiçado, apenas "mais um"
Será substituído por alguém 20 anos mais novo usando IA básica
Motivo que alega: "Falta tempo", "preciso aprender mais", "meu nicho é diferente", "não sou técnico o suficiente


Erros
O que ele tenta fazer para conseguir o seu principal desejo?
Porque ele acredita que isso é o que deve ser feito?
Porque o que ele faz não funciona?
Porque isso não é culpa dele?
Então de quem é a culpa?

O que tenta:
Compra mais cursos (média 5-10 por ano)
Testa todas as ferramentas de IA (gasta 3h/dia experimentando)
Abre múltiplos projetos simultaneamente (5-10 WIP)
Planeja excessivamente sem executar (meses criando "estratégia perfeita")

Por que acredita nisso: Mercado digital vende a ideia de que "a próxima ferramenta" ou "método revolucionário" resolverá tudo. Confunde movimento com progresso.

Por que não funciona: Sem sistema claro, KPIs definidos e foco único, dispersa energia. Cada nova tentativa reseta o progresso anterior.

Por que não é culpa dele: O ecossistema digital foi desenhado para vender novidade, não resultado. Ninguém ensinou WIP=1 e execução disciplinada.

De quem é a culpa: Do sistema de incentivos perversos do mercado digital que lucra com FOMO e complexidade desnecessária.


1) O EMPREENDEDOR DIGITAL TRAVADO
Desejo declarado: escalar com previsibilidade (1 oferta que cresce todo mês).
Problema – o que ele vive por não ter o que deseja
Receita oscilando, sem motor comercial repetível.


Energia diluída em muitos projetos; nada atinge massa crítica.


Excesso de consumo e execução parcial (WIP > 1).


Se não conseguir o que deseja (consequências)
Burnout leve + culpa crônica (“eu não rendo”).


Reputação de “começa e não termina” → menos parcerias.


Perde timing de oportunidades e fica refém de fluxo de caixa curto.


O motivo que ele diz para não conseguir
“Falta tempo/equipe/ferramentas certas”; “o algoritmo mudou”; “tráfego caro”.


Erros (padrões de tentativa)
O que ele tenta: compra mais cursos, abre novos projetos, troca de tática a cada 2–4 semanas, empilha automações sem ICP/Oferta.


Por que acredita nisso: todos os pares parecem “lançar algo novo” (prova social); novidade dá sensação de progresso.


Por que não funciona: dispersa foco, não fecha ciclo (teste → ajuste → escala); não cria cadência de vendas.


Por que não é culpa dele: o ecossistema premia novidade, não consistência; quase ninguém ensinou WIP=1 e priorização.


Então de quem é a culpa: do sistema de incentivos (conteúdo/shiny objects) e de métodos que vendem complexidade em vez de execução simples com métrica de escala.



2) O EXECUTIVO EXAUSTO
Desejo declarado: transição para um modelo de trabalho rentável e leve (tempo, saúde, família).
Problema – o que ele vive por não ter o que deseja
Rotina inviável (agenda lotada, pouca autonomia).


Medo de perder padrão de vida sem um plano com clientes reais.


Identidade presa ao cargo; oferta própria nebulosa.


Se não conseguir o que deseja (consequências)
Burnout e piora de saúde; distanciamento familiar.


Cinismo profissional; estagnação de carreira.


Perde janela de transição (mercado e energia mudam).


O motivo que ele diz para não conseguir
“Tenho responsabilidades/contas”; “não domino o digital”; “não posso arriscar”.


Erros (padrões de tentativa)
O que ele tenta: planejar demais, fazer MBAs/cursos longos, esperar “o momento perfeito”, abrir negócio genérico sem validação.


Por que acredita nisso: cultura corporativa valoriza certificação e planejamento exaustivo.


Por que não funciona: sem pipeline e oferta de alto valor, a transição fica teórica; a energia acaba antes da validação.


Por que não é culpa dele: foi treinado para grandes estruturas, não para go-to-market enxuto.


Então de quem é a culpa: do condicionamento corporativo (avesso a iterar no mercado) e de conselhos “seguros” que não geram conversas comerciais.



3) O TÉCNICO VISIONÁRIO
Desejo declarado: monetizar sua tecnologia com reconhecimento e ticket alto.
Problema – o que ele vive por não ter o que deseja
Brilha tecnicamente, mas não converte em contratos.


Apresentações cheias de jargão e sem outcomes de negócio.


Perfeccionismo atrasa ir ao mercado (espera “ficar pronto”).


Se não conseguir o que deseja (consequências)
Frustração ao ver “palestrinha” vendendo mais.


Caixa curto e dependência de freelas por hora.


Desânimo para inovar (vira feature factory).


O motivo que ele diz para não conseguir
“O mercado não entende”, “falta vendedor”, “preciso terminar antes”.


Erros (padrões de tentativa)
O que ele tenta: construir mais features/POCs; abrir open-source sem roteiro comercial; precificar por hora.


Por que acredita nisso: credo “produto bom vende sozinho”; ética do craft > venda.


Por que não funciona: decisor compra resultado (tempo/dinheiro/risco), não tecnologia em si; demo sem dor não fecha.


Por que não é culpa dele: formação técnica não inclui narrativa de valor e sales discovery.


Então de quem é a culpa: do desalinhamento entre educação técnica e mercado, e de modelos de venda que não traduzem ROI.



4) O VETERANO DESPREZADO
Desejo declarado: recuperar relevância e transformar experiência em produto/mentoria.
Problema – o que ele vive por não ter o que deseja
Sente-se subvalorizado e intimidado por ferramentas novas.


Sabe muito, mas não productiza; mensagem confusa.


Evita se expor por medo de julgamento etarista.


Se não conseguir o que deseja (consequências)
Isolamento, ticket baixo e autoestima profissional ferida.


Dependência de terceiros; agonia de “ficar para trás”.


Perde a chance de legado pago.


O motivo que ele diz para não conseguir
“Não entendo IA/redes”; “já estou velho para isso”; “não sei por onde começar”.


Erros (padrões de tentativa)
O que ele tenta: acumular cursos de ferramenta, terceirizar tudo sem clareza de oferta, tentar ensinar “tudo” que sabe.


Por que acredita nisso: acha que precisa “dominar a tecnologia” antes de vender; valoriza exatidão e completude.


Por que não funciona: a curva de ferramenta é longa; sem proposta clara e prova simples não há vendas.


Por que não é culpa dele: há ageísmo real e plataformas pensadas para nativos digitais.


Então de quem é a culpa: da cultura etarista do mercado e de um ensino de IA centrado em ferramenta — não em productização do know‑how sênior.



5) O MULTIPOTENCIAL ANSIOSO
Desejo declarado: encontrar um projeto unificador que gere resultado consistente.
Problema – o que ele vive por não ter o que deseja
Mil ideias, pouca entrega completa; rotina irregular.


Alterna hiperfoco e paralisia → renda instável.


Culpa por “não manter constância”.


Se não conseguir o que deseja (consequências)
Ciclos de autossabotagem e desistência prematura.


Reputação de “inconstante”; oportunidades escapam.


Ansiedade crônica; projetos semi‑acabados sem valor.


O motivo que ele diz para não conseguir
“Tenho TDAH”, “falta foco/sistema”, “me entedio rápido”.


Erros (padrões de tentativa)
O que ele tenta: começar 3–5 frentes ao mesmo tempo (curso, canal, produto), experimentar 10 ferramentas, pivotar semanalmente.


Por que acredita nisso: confunde diversificação com progresso; FOMO de perder “a ideia certa”.


Por que não funciona: dilui energia, não cria repetição; sem ciclos curtos com entrega e venda, nada valida.


Por que não é culpa dele: neurodiversidade real + plataformas desenhadas para dopamina (novidade constante).


Então de quem é a culpa: do design do ecossistema (shiny object + métricas de vaidade) e da falta de métodos adaptados (sprints curtas, WIP=1, recompensa imediata).



Observação final
Repare como todos esbarram em sistemas ruins (ou inexistentes) e incentivos tortos. O antídoto muda de rótulo por arquétipo, mas quase sempre combina:
Oferta clara (dor → promessa → prova → preço);


Cadência curta de execução/validação;


Métrica única que guia a semana;


Ambiente que reforça foco e cobra entrega (e não novidade).









Pesquisa de Persona Completa 
Data da Análise: Setembro 2025
Base de Dados: 150+ apresentações de membros na comunidade.
Dados Estatísticos Consolidados - Fonte da Verdade
Base Definitiva: 150+ apresentações analisadas
📊 Estatísticas Demográficas Oficiais
Distribuição Etária Definitiva
18-25 anos: 5%
26-35 anos: 25%
36-45 anos: 35% (maior concentração)
46-55 anos: 25%
56-69 anos: 10%
Média de idade: ~40 anos
Geografia Consolidada
São Paulo: 45%
Rio de Janeiro: 10%
Santa Catarina: 8%
Minas Gerais: 8%
Rio Grande do Sul: 7%
Paraná: 5%
Distrito Federal: 5%
Outros estados: 10%
Internacional: 2%
Formação Acadêmica Final
Engenharias: 30%
Administração/Marketing: 25%
Tecnologia/Computação: 15%
Direito: 10%
Saúde: 10%
Design/Comunicação: 10%
Qualificação:
95% com formação superior
40% com pós-graduação/MBA
🎯 Distribuição dos Arquétipos
O Empreendedor Digital Travado: 30%
O Executivo Exausto: 25%
O Técnico Visionário: 20%
O Veterano Desprezado: 15%
O Multipotencial Ansioso: 10%
📈 Estatísticas de Dores
Dores Primárias
Tempo sugado por tarefas repetitivas: 80%
Burnout/exaustão mental: 60%
Renda estagnada: 55%
Medo de ficar obsoleto: 50%
Dores Secundárias
Muitas ideias, pouca execução: 65%
Conhecimento desorganizado: 60%
Dificuldade em escalar sozinho: 55%
Falta de clareza na direção: 50%
🗣️ Frequência de Termos (Top 10)
Construir: 127 menções
Desenvolver: 98 menções
Automatizar/Automação: 95 menções
Soluções: 89 menções
IA/Inteligência Artificial: 87 menções
Criar: 85 menções
Escalar: 72 menções
Processos: 68 menções
Transição: 65 menções
Networking/Conexão: 61 menções
💰 Segmentos de Mercado
Career Transitioners: 35%
Quick Money Makers: 30%
Business Scalers: 25%
Legacy Builders: 10%


**Sobre o Especialista:**

Autoridade
Especialista
Quais títulos e qualificações o especialista possui?
Quais os resultados somados que os alunos já conseguiram com a ajuda do especialista?
O que o especialista acredita e defende?
Qual é a personalidade do especialista?

Especialista - Alan Nicolas
Títulos e qualificações:
Empresário desde 2014
Palestrante e escritor
Especialista em IA aplicada aos negócios
Criador do conceito "Segundo Cérebro com IA" no Brasil
Múltiplos prêmios Monetizze e Hotmart
Resultados somados:
Faturamento pessoal: R$200+ milhões
20.000+ alunos formados
Alunos faturando centenas de milhares em 4 meses
Presença em 40+ países
98% retenção primeiras 48h
O que acredita e defende:
"Geração de abundância para pessoas ao redor"
"Tecnologia como crescimento exponencial"
"Mais importante que o porquê é o COM QUEM"
"Preparar o mundo para pós-AGI"
Personalidade:
Visionário (sabático revelador)
Profundo (anos de estudo)
Generoso (desenvolvimento coletivo)
Prático (conhecimento em negócios lucrativos)
Visão Sistêmica do Especialista:
Alan Nicolas - O Hacker de Consciências
Quem é (sem máscaras): Ex-menino de Guajuviras que hackeou o sistema. Não o sistema tecnológico apenas, mas o sistema mental que prende pessoas em loops de mediocridade. Construiu império de 200 milhões não por amor ao dinheiro, mas para provar que era possível. Agora usa IA para libertar mentes, não escravizar atenção.
O que fez (que importa): Criou o conceito de Segundo Cérebro com IA no Brasil porque sua mente TDAH precisava. Transformou 20 mil inadaptados corporativos em construtores de realidade. Dispensou clientes de 88 mil quando percebeu que não fazia sentido para eles. Escolheu impacto sobre impressão, clareza sobre crescimento.
Como opera (a verdade nua): Desmonta sistemas para reconstruir melhor. Lê papers de IA às 3h da manhã por obsessão, não obrigação. Ensina com analogias de videogame porque entende que complexidade sem aplicação é masturbação intelectual. Some por semanas, volta com insights que mudam paradigmas.
O que defende (sem filtros corporativos): "Use IA para recuperar sua vida, não para fingir produtividade" "Clareza é poder, ruído é escravidão" "Seu segundo cérebro deve libertar seu primeiro" "Use o artificial para viver o natural”.
Personalidade (as contradições que importam): Intenso que busca paz. Multimilionário que prefere ócio criativo a reuniões. Professor que detesta ensinar o óbvio. Líder de 20 mil que prefere sua caverna. 8 ou 80 que encontrou forma de ser os dois. Cientista maluco disfarçado de empresário, ou talvez o contrário.
A promessa real: "Não vou te transformar em expert em IA. Vou te ensinar a pensar com clareza suficiente para usar IA como extensão da sua genialidade, não muleta para sua mediocridade. Se você quer templates e prompts mágicos, procure outro. Se quer reconstruir sua mente para o mundo que está nascendo, vamos conversar."
Credencial que importa: Não são os prêmios Hotmart ou os milhões. É ter criado uma tribo de pessoas que finalmente encontraram permissão para serem intensas, contraditórias e geniais. Pessoas que, como Alan, se recusam a caber no molde corporativo tradicional.
O que diferencia Alan: O que diferencia Alan não é o que ele sabe sobre IA. É que ele usa IA como pretexto para despertar consciências. Seu produto real nunca foi conhecimento técnico, foi permissão para transcender limitações mentais autoimpostas.


Depoimentos
Quais depoimentos mostram os melhores resultados?
Quais depoimentos mostram as principais situações?
Quais depoimentos resolvem as principais objeções?

Pertencimento:
"Sensação de pertencimento absurdo" - Lucas
"Como se tivesse encontrado minha tribo" - Lucas
"Estar no lugar certo na hora certa" - KR
Qualidade/Profundidade:
"Transparência e profundidade do Alan" - Luiz
"Seriedade e compromisso genuíno" - Solange
"Entregam muito mais do que prometem" - Cristina
Transformação:
"Segundo cérebro foi fora de série" - KR
"PS destrava o que você está travado" - Raphael
"Entrei pra aprender IA, aprendi sobre mim" - Rodrigo


**Duração esperada:** 3h


**Formato principal:**


**Objetivos principais:**
1.
2.
3.

**Componentes essenciais:**


**Persona MMOS (se aplicável):**


**Notas adicionais:**


---

#### **Exemplo 3 (opcional):**

**Título do curso:**


**Público-alvo:**


**Duração esperada:**


**Formato principal:**


**Objetivos principais:**


**Componentes essenciais:**


**Persona MMOS (se aplicável):**


**Notas adicionais:**


---

## 11. Priorização & Roadmap

### 11.1. O que DEVE estar no MVP (versão 1.0)?

Liste os 5-7 recursos/funcionalidades absolutamente essenciais para a primeira versão:


  Exemplos do que eu imagino (você pode ajustar):
  1. Elicitação interativa guiada (perguntas ao usuário)
  2. Geração de outline completo (estrutura do curso)
  3. Geração de aulas em Markdown com voice fidelity
  4. Validação pedagógica (alignment check, completeness)
  5. Export para arquivos (MD, YAML, JSON)
  6. Database logging (salvar no mmos.db)
  7. Preview antes de gerar conteúdo completo


---

### 11.2. O que pode ser iteração futura (v1.1, v1.2, etc.)?

Liste funcionalidades desejáveis mas não críticas para MVP:

- Analise de product-market-fit
- Documentação para estruturação do marketing
- Futuramente poderá ser gerado automaticamente vídeos, audios, PDFs e apresentações completas.

---

### 11.3. O que NÃO deve ser incluído (out of scope)?

Liste funcionalidades que definitivamente NÃO fazem parte do escopo desta task:

- Não sei.
-
-

---

## 12. Outras Considerações

### 12.1. Há algum requisito técnico/limitação que devo considerar?

(Ex: tamanho máximo de arquivos, limite de API calls, compatibilidade com ferramentas específicas)


---

### 12.2. Há referências/inspirações de outras ferramentas/cursos?

(Ex: "Quero algo similar ao Teachable mas com mais pedagogia", "Inspirado nos cursos do Coursera")

Cursos do Coursera são muito bons, mas gostaria de uma base maior de referências. Gosto também da mindvalley e masterclass, contudo mais voltados para prática.
---

### 12.3. Outras notas/comentários/requisitos não cobertos acima?

Deve conter uma base sólida dos valores, história e de preferência um deck de cultura da entidade que está sendo solicitado um novo curso.
Precisamos mapear melhor quais são inputs ideias para criar um curso de qualidade, a ideia é criar algo realmente útil, personalizado e de altíssima qualidade.
---

## ✅ Confirmação de Conclusão

**Quando terminar de preencher, marque abaixo e me avise!**

- [ ] Documento completo e revisado
- [X] Pronto para Sarah (PO) revisar e projetar a task

---

**Próximos passos após revisão:**
1. Sarah analisa respostas
2. Define escopo preciso da task `generate-course`
3. Cria workflow de elicitação
4. Especifica templates e estruturas de saída
5. Define critérios de validação pedagógica
6. Gera task definition file completo
7. Cria exemplos de uso

---

_Documento criado em 2025-10-14 por Sarah (PO) para elicitação de requisitos da funcionalidade de geração de cursos do CreatorOS._
