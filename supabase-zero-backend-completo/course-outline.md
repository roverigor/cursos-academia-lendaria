# Course Outline: Supabase do Zero

**Instrutor:** José Amorim
**Duração Total:** 12-14 horas
**Total de Aulas:** 52 aulas
**Média por Aula:** 10-15 minutos (microlearning)
**Framework Pedagógico:** Espiral Expansiva + Anti-Impostor Design

---

## MÓDULO 0: ONBOARDING E FUNDAÇÃO
**Duração:** 30 minutos | 3 aulas
**Objetivo:** Eliminar síndrome do impostor e criar base conceitual

### 00.1 Você NÃO Precisa Ser Programador (12 min) [Understand]
**Objetivo:** Quebrar a crença limitante "preciso ser programador"
**Bloom Level:** Understand
**Conteúdo:**
- Por que você NÃO precisa saber programar
- A diferença entre "usar tecnologia" e "escrever código"
- Supabase como interface visual + IA como copiloto
- Histórias de founders não-técnicos que criaram startups de sucesso
- **Gancho:** "Sabe aquele medo de 'não sou técnico o suficiente'? E se eu te disser que esse é o medo ERRADO?"

### 00.2 Por Que Supabase e Quando Usar (8 min) [Remember]
**Objetivo:** Entender o posicionamento do Supabase no ecossistema
**Bloom Level:** Remember
**Conteúdo:**
- O que é Supabase (Firebase open-source com PostgreSQL)
- Quando usar Supabase vs outras soluções (Airtable, Firebase, backend custom)
- Limitações e casos de uso ideais
- **Metáfora:** "Supabase é como LEGO programável - peças prontas que você combina do seu jeito"

### 00.3 HTTP e Web Requests Desmistificados (10 min) [Understand]
**Objetivo:** Entender conceitos fundamentais de web sem jargão
**Bloom Level:** Understand
**Conteúdo:**
- Cliente e servidor: metáfora do restaurante
- GET, POST, PUT, DELETE desmistificados
- APIs como "cardápio" que você consulta
- **Anti-Impostor:** "Isso parece complicado, mas você já usa isso TODO DIA sem saber"

---

## MÓDULO 1: PRIMEIROS PASSOS
**Duração:** 36 minutos + quiz (5 min) | 4 aulas
**Objetivo:** Primeiro contato sem medo, primeira vitória

### 01.1 O Que É Banco de Dados (Spoiler: É Excel Vitaminado) (10 min) [Understand]
**Objetivo:** Desmistificar banco de dados com metáfora acessível
**Bloom Level:** Understand
**Conteúdo:**
- Banco de dados = planilha Excel com superpoderes
- Linhas, colunas, células → registros, campos, valores
- Por que não usar Excel para tudo?
- **Metáfora Visual:** "Pensa numa biblioteca gigante onde cada livro sabe exatamente onde está"

### 01.2 Criando Conta e Primeiro Projeto (8 min) [Apply]
**Objetivo:** Primeiro passo prático - conta ativa
**Bloom Level:** Apply
**Conteúdo:**
- Sign up no Supabase (tier free)
- Criar primeiro projeto
- Entender "organization" vs "project"
- Onde encontrar credenciais (API URL, anon key)
- **Primeira Vitória:** "Você acabou de criar seu primeiro backend em 3 cliques"

### 01.3 Tour pelo Dashboard (Onde Fica o Quê) (10 min) [Remember]
**Objetivo:** Navegar com confiança pelo dashboard
**Bloom Level:** Remember
**Conteúdo:**
- Table Editor (onde passa 80% do tempo)
- Authentication, Storage, SQL Editor, API Docs
- Onde procurar ajuda (docs, exemplos, community)
- **Anti-Impostor:** "Se você se perder, é porque a interface tem MUITA coisa. Normal. Você vai usar 20% disso 80% do tempo."

### 01.4 Sua Primeira Tabela em 3 Minutos (8 min) [Apply]
**Objetivo:** Criar primeira tabela - vitória técnica
**Bloom Level:** Apply
**Conteúdo:**
- Criar tabela "tasks" do zero
- Adicionar 3 campos simples (id, title, completed)
- Inserir primeiro registro manualmente
- Visualizar na interface
- **Celebração:** "Parabéns. Você acabou de criar um banco de dados funcional."

### ✅ Quiz 1: Validação de Conceitos Básicos (5 min)
**10 questões de múltipla escolha**
- O que é banco de dados?
- Diferença entre linha e coluna
- Onde fica Table Editor no dashboard?
- O que é um "projeto" no Supabase?

---

## MÓDULO 2: MODELAGEM SEM DRAMA
**Duração:** 52 minutos + exercício (10 min) | 4 aulas
**Objetivo:** Entender normalização sem trauma

### 02.1 Por Que Normalização Parece Difícil Mas Não É (8 min) [Understand]
**Objetivo:** Desmistificar normalização antes de ensinar
**Bloom Level:** Understand
**Conteúdo:**
- Por que o nome "normalização" assusta
- O problema da duplicação de dados (exemplo visual)
- Normalização = organizar armário bagunçado
- **Gancho Emocional:** "Sabe quando você repete o mesmo cliente em 50 linhas da planilha e depois tem que mudar TUDO? É isso que normalização resolve."

### 02.2 Normalização: De Bagunça para Organização Visual (15 min) [Apply]
**Objetivo:** Aplicar normalização na prática com diagrama
**Bloom Level:** Apply
**Conteúdo:**
- Tabela denormalizada (exemplo: pedidos com tudo misturado)
- Separar em 3 tabelas (clientes, pedidos, produtos)
- Diagrama visual: setas conectando tabelas
- **Metáfora:** "É como separar roupas por gavetas em vez de tudo numa mala"

### 02.3 Chaves Primárias e Estrangeiras (CPF das Tabelas) (15 min) [Understand]
**Objetivo:** Entender relacionamentos entre tabelas
**Bloom Level:** Understand
**Conteúdo:**
- Chave primária = CPF único de cada registro
- Chave estrangeira = referência ao "CPF" de outra tabela
- Tipos de relacionamento: 1-para-muitos, muitos-para-muitos
- **Metáfora:** "Chave primária é seu CPF. Chave estrangeira é quando você escreve o CPF da sua mãe num formulário."

### 02.4 Conectando Tabelas na Prática (14 min) [Apply]
**Objetivo:** Criar relacionamentos reais no Supabase
**Bloom Level:** Apply
**Conteúdo:**
- Criar tabela "users" e "posts"
- Adicionar foreign key (user_id em posts)
- Testar inserção respeitando relacionamento
- Ver erro quando tenta relacionamento inválido
- **Aplicação:** "Agora você vai conectar suas próprias tabelas"

### 📝 Exercício: Normalizar Tabela de Agendamentos (10 min)
**Prática guiada:**
- Tabela bagunçada: agendamentos com cliente, serviço, profissional tudo junto
- Separar em 3 tabelas normalizadas
- Criar relacionamentos
- Gabarito fornecido

---

## MÓDULO 3: CRIANDO TABELAS DE VERDADE
**Duração:** 64 minutos + mini-projeto (15 min) | 5 aulas
**Objetivo:** Dominar criação de estruturas de dados

### 03.1 Tipos de Dados: Gavetas de Tamanhos Diferentes (12 min) [Understand]
**Objetivo:** Entender tipos de dados sem decoreba
**Bloom Level:** Understand
**Conteúdo:**
- text, integer, boolean, timestamp, json
- Por que o tipo importa (validação automática)
- Quando usar cada um
- **Metáfora:** "Gavetas de tamanhos diferentes - não dá pra guardar sofá em gaveta de meia"

### 03.2 UUID: Por Que Esse Código Estranho Importa (8 min) [Understand]
**Objetivo:** Entender UUIDs vs integers como ID
**Bloom Level:** Understand
**Conteúdo:**
- O que é UUID (código tipo "550e8400-e29b-41d4-a716-446655440000")
- UUID vs auto-increment integer
- Quando usar UUID (padrão Supabase)
- **Desmistificação:** "Parece código de hacker, mas é só um CPF super único que nunca repete"

### 03.3 Criando Tabela Completa Passo a Passo (15 min) [Apply]
**Objetivo:** Criar tabela production-ready
**Bloom Level:** Apply
**Conteúdo:**
- Planejar estrutura (papel e caneta primeiro)
- Criar tabela "products" com 8 campos
- Escolher tipos adequados
- Adicionar descrições nos campos
- **Hands-On:** "Pause e crie sua tabela junto comigo"

### 03.4 Constraints: Regras que Protegem seus Dados (12 min) [Apply]
**Objetivo:** Adicionar validações automáticas
**Bloom Level:** Apply
**Conteúdo:**
- NOT NULL (campo obrigatório)
- UNIQUE (não permite duplicados)
- DEFAULT (valor padrão)
- CHECK (validação customizada)
- **Metáfora:** "Constraints são os seguranças da sua boate de dados"

### 03.5 CASCADE: O Que Acontece Quando Deleta (12 min) [Analyze]
**Objetivo:** Entender delete cascade e restrict
**Bloom Level:** Analyze
**Conteúdo:**
- ON DELETE CASCADE (deleta em cascata)
- ON DELETE RESTRICT (bloqueia deleção)
- ON DELETE SET NULL (limpa referência)
- Quando usar cada um
- **Problema Real:** "Se você deleta um cliente, o que acontece com os pedidos dele?"

### 🏗️ Mini-Projeto: Sistema de Clientes e Pedidos (15 min)
**Projeto guiado:**
- Criar 3 tabelas relacionadas (clients, orders, order_items)
- Aplicar constraints
- Configurar cascade rules
- Inserir dados de teste
- Testar deleções

---

## MÓDULO 4: SQL ESSENCIAL COM IA
**Duração:** 76 minutos + projeto (20 min) | 6 aulas
**Objetivo:** Usar SQL sem medo, com ajuda de IA

### 04.1 SQL é Literalmente Inglês Estruturado (10 min) [Understand]
**Objetivo:** Quebrar medo de SQL
**Bloom Level:** Understand
**Conteúdo:**
- SELECT = "mostre-me"
- FROM = "de onde"
- WHERE = "onde condição é verdadeira"
- SQL como frases em inglês
- **Desmistificação:** "Se você fala inglês básico, você consegue ler SQL"

### 04.2 SELECT: Buscando Dados (12 min) [Apply]
**Objetivo:** Dominar queries de leitura
**Bloom Level:** Apply
**Conteúdo:**
- SELECT * (tudo)
- SELECT campos específicos
- WHERE com condições
- ORDER BY, LIMIT
- **Prática:** "Vamos buscar dados de 10 jeitos diferentes"

### 04.3 INSERT: Adicionando Dados (12 min) [Apply]
**Objetivo:** Inserir registros via SQL
**Bloom Level:** Apply
**Conteúdo:**
- INSERT INTO básico
- Inserir múltiplos registros de uma vez
- RETURNING (retornar o que foi inserido)
- **Anti-Impostor:** "Você já fez isso pela interface. Agora vai fazer por SQL. Mesma coisa, jeito diferente."

### 04.4 UPDATE: Atualizando Registros (12 min) [Apply]
**Objetivo:** Modificar dados existentes
**Bloom Level:** Apply
**Conteúdo:**
- UPDATE com WHERE (SEMPRE COM WHERE!)
- Perigo do UPDATE sem WHERE
- Atualizar múltiplos campos
- **Aviso:** "Esqueceu o WHERE? Você acabou de atualizar 10.000 registros. Respira."

### 04.5 DELETE: Removendo com Cuidado (10 min) [Apply]
**Objetivo:** Deletar dados com segurança
**Bloom Level:** Apply
**Conteúdo:**
- DELETE com WHERE (SEMPRE!)
- Soft delete vs hard delete
- TRUNCATE (deleta tudo - perigo!)
- **Regra de Ouro:** "Sempre faça SELECT antes de fazer DELETE"

### 04.6 ChatGPT/Claude: Seu Gerador de SQL Pessoal (15 min) [Apply]
**Objetivo:** Usar IA para escrever SQL
**Bloom Level:** Apply
**Conteúdo:**
- Como fazer bons prompts para SQL
- Exemplos: "crie SQL que busca X onde Y"
- Validar e testar SQL gerado
- Debugging com IA
- **Transformação:** "Você não precisa decorar SQL. Você precisa saber PEDIR SQL pra IA."

### 🚀 Projeto: CRUD Completo do seu Negócio (20 min)
**Projeto aplicado:**
- Criar tabela do seu caso de uso real
- Escrever 10 queries com ajuda de IA
- SELECT, INSERT, UPDATE, DELETE
- Testar no SQL Editor
- **Celebração:** "Você acabou de fazer CRUD completo. Você É dev backend agora."

---

## MÓDULO 5: VIEWS E QUERIES AVANÇADAS
**Duração:** 48 minutos | 4 aulas
**Objetivo:** Simplificar complexidade com views

### 05.1 Views: Atalhos Inteligentes para Dados (12 min) [Analyze]
**Objetivo:** Entender o que são views e quando usar
**Bloom Level:** Analyze
**Conteúdo:**
- View = query salva que parece tabela
- Quando criar views (queries repetitivas)
- Diferença entre view e tabela
- **Metáfora:** "View é como criar um atalho no desktop - o arquivo tá em outro lugar, mas você acessa rápido"

### 05.2 JOINs Sem Pânico (Com Diagramas) (15 min) [Analyze]
**Objetivo:** Conectar múltiplas tabelas em queries
**Bloom Level:** Analyze
**Conteúdo:**
- INNER JOIN (interseção)
- LEFT JOIN (tudo da esquerda + match da direita)
- Diagramas visuais de Venn
- **Metáfora:** "JOIN é como juntar duas planilhas pela coluna em comum"

### 05.3 Agregações: Somas, Médias, Contagens (12 min) [Apply]
**Objetivo:** Calcular estatísticas dos dados
**Bloom Level:** Apply
**Conteúdo:**
- COUNT, SUM, AVG, MIN, MAX
- GROUP BY (agrupar antes de calcular)
- HAVING (filtrar depois de agregar)
- **Prática:** "Calcular total de vendas por cliente"

### 05.4 Criando Dashboard com Views (9 min) [Create]
**Objetivo:** Criar views para dashboards
**Bloom Level:** Create
**Conteúdo:**
- View "vendas_resumo" com totais
- View "top_clientes" com ranking
- Conectar views ao front-end
- **Transformação:** "Você acabou de criar um mini-BI"

---

## MÓDULO 6: AUTENTICAÇÃO DESCOMPLICADA
**Duração:** 78 minutos + mini-projeto (20 min) | 6 aulas
**Objetivo:** Auth completo e funcional

### 06.1 Por Que Auth Parece Complicado Mas Não É (8 min) [Understand]
**Objetivo:** Desmistificar autenticação
**Bloom Level:** Understand
**Conteúdo:**
- O que auth faz (identifica quem é quem)
- JWT tokens explicados sem jargão
- Supabase cuida do difícil
- **Gancho:** "Auth parece a parte mais complexa. É mentira. Supabase deixa em 5 cliques."

### 06.2 Setup de Autenticação em 5 Cliques (12 min) [Apply]
**Objetivo:** Ativar auth no projeto
**Bloom Level:** Apply
**Conteúdo:**
- Habilitar Email Provider
- Configurar email templates
- Testar signup via dashboard
- **Primeira Vitória:** "Você acabou de criar sistema de autenticação enterprise-grade"

### 06.3 Login e Signup Funcionando (15 min) [Apply]
**Objetivo:** Implementar fluxo completo
**Bloom Level:** Apply
**Conteúdo:**
- Sign up com email/senha
- Login (sign in)
- Verificar usuário logado
- Logout
- **Hands-On:** "Crie 3 usuários de teste agora"

### 06.4 Recuperação de Senha Automática (10 min) [Apply]
**Objetivo:** Reset password flow
**Bloom Level:** Apply
**Conteúdo:**
- Botão "Esqueci minha senha"
- Email de recuperação automático
- Reset password form
- **Anti-Impostor:** "Isso costuma levar 2 dias de dev. Você fez em 10 minutos."

### 06.5 OAuth: Login com Google em 3 Passos (12 min) [Apply]
**Objetivo:** Social login funcionando
**Bloom Level:** Apply
**Conteúdo:**
- Habilitar Google Provider
- Configurar credenciais OAuth
- Testar login social
- **Celebração:** "Login com Google = feito. Facebook, GitHub = mesmo processo."

### 06.6 Protegendo Rotas e Páginas (15 min) [Analyze]
**Objetivo:** Implementar proteção de acesso
**Bloom Level:** Analyze
**Conteúdo:**
- Middleware de autenticação
- Redirect se não logado
- Proteção no front-end
- **Segurança:** "Se não proteger, qualquer um acessa. Vamos blindar."

### 🔐 Mini-Projeto: Sistema de Login Completo (20 min)
**Projeto aplicado:**
- Página de signup
- Página de login
- Recuperação de senha
- Página protegida
- Logout funcionando

---

## MÓDULO 7: SEGURANÇA (RLS) SEM PARANOIA
**Duração:** 63 minutos | 5 aulas
**Objetivo:** Implementar segurança real sem complexidade

### 07.1 RLS = Regras de Quem Vê o Quê (10 min) [Understand]
**Objetivo:** Entender Row Level Security
**Bloom Level:** Understand
**Conteúdo:**
- O que é RLS (filtro automático por usuário)
- Por que é ESSENCIAL
- Metáfora da parede invisível
- **Gancho:** "Sem RLS, qualquer usuário vê TUDO de TODOS. Vamos consertar isso."

### 07.2 Políticas de Segurança na Prática (15 min) [Apply]
**Objetivo:** Criar policies funcionais
**Bloom Level:** Apply
**Conteúdo:**
- Política "usuário só vê próprios dados"
- Habilitar RLS na tabela
- Testar com 2 usuários diferentes
- **Transformação:** "Agora seu app é seguro de verdade"

### 07.3 Testando se Está Seguro Mesmo (12 min) [Analyze]
**Objetivo:** Validar segurança
**Bloom Level:** Analyze
**Conteúdo:**
- Testar acesso não autorizado
- Verificar logs de tentativas
- Simular ataque
- **Segurança:** "Paranoia controlada é saudável"

### 07.4 Erros Comuns de Segurança (e Como Evitar) (12 min) [Evaluate]
**Objetivo:** Evitar vulnerabilidades clássicas
**Bloom Level:** Evaluate
**Conteúdo:**
- Esqueceu de habilitar RLS
- Policy muito permissiva
- Expor credenciais
- **Top 5 Erros:** "Todos cometem. Você não vai."

### 07.5 Auditoria: Quem Fez o Quê e Quando (14 min) [Apply]
**Objetivo:** Rastrear mudanças
**Bloom Level:** Apply
**Conteúdo:**
- Campos created_at, updated_at
- Campo created_by (user_id)
- Trigger de auditoria
- **Aplicação:** "Agora você sabe quem bagunçou o banco"

---

## MÓDULO 8: STORAGE E ARQUIVOS
**Duração:** 46 minutos | 4 aulas
**Objetivo:** Gerenciar uploads e arquivos

### 08.1 Upload de Arquivos Simplificado (12 min) [Apply]
**Objetivo:** Upload básico funcionando
**Bloom Level:** Apply
**Conteúdo:**
- Criar bucket de storage
- Upload via interface
- Upload via código
- **Primeira Vitória:** "Você acabou de criar AWS S3 gratuito"

### 08.2 Organizando Buckets e Pastas (10 min) [Apply]
**Objetivo:** Estruturar storage
**Bloom Level:** Apply
**Conteúdo:**
- Buckets públicos vs privados
- Estrutura de pastas (users/user_id/avatar.jpg)
- Naming conventions
- **Metáfora:** "Bucket = caixa, pastas = gavetas"

### 08.3 Servindo Imagens e Downloads (12 min) [Apply]
**Objetivo:** URLs públicas e downloads
**Bloom Level:** Apply
**Conteúdo:**
- Gerar URL pública
- URL assinada (temporária)
- Download programático
- **Aplicação:** "Agora suas imagens carregam no app"

### 08.4 Políticas de Acesso a Arquivos (12 min) [Analyze]
**Objetivo:** Segurança de storage
**Bloom Level:** Analyze
**Conteúdo:**
- RLS para storage
- Usuário só vê próprios arquivos
- Upload apenas para autenticados
- **Segurança:** "Protegendo arquivos como protegeu dados"

---

## MÓDULO 9: REALTIME E WEBSOCKETS
**Duração:** 48 minutos | 4 aulas
**Objetivo:** Criar apps em tempo real

### 09.1 O Que É Realtime e Quando Usar (10 min) [Understand]
**Objetivo:** Entender comunicação em tempo real
**Bloom Level:** Understand
**Conteúdo:**
- HTTP vs WebSockets
- Casos de uso (chat, notificações, collaborative)
- **Metáfora:** "HTTP = correio. WebSocket = telefone sempre aberto"

### 09.2 Broadcast: Mensagens para Todos (12 min) [Apply]
**Objetivo:** Enviar mensagens broadcast
**Bloom Level:** Apply
**Conteúdo:**
- Setup de broadcast channel
- Enviar mensagem para todos conectados
- Receber mensagens
- **Aplicação:** "Crie um chat básico em 10 linhas"

### 09.3 Presence: Quem Está Online (12 min) [Apply]
**Objetivo:** Rastrear usuários online
**Bloom Level:** Apply
**Conteúdo:**
- Presence channel
- Lista de usuários online
- Detectar entrou/saiu
- **Aplicação:** "Indicador de 'online' verde funcionando"

### 09.4 Postgres Changes: Atualizações Automáticas (14 min) [Apply]
**Objetivo:** Escutar mudanças no banco
**Bloom Level:** Apply
**Conteúdo:**
- Subscribe em INSERT, UPDATE, DELETE
- Atualizar UI automaticamente
- **Transformação:** "Seu app atualiza sozinho. Sem F5."

---

## MÓDULO 10: FUNCTIONS E AUTOMAÇÃO
**Duração:** 52 minutos | 4 aulas
**Objetivo:** Automatizar processos backend

### 10.1 Edge Functions: Código Sem Servidor (12 min) [Understand]
**Objetivo:** Entender serverless functions
**Bloom Level:** Understand
**Conteúdo:**
- O que são Edge Functions
- Quando usar (lógica complexa, integrações)
- Deno vs Node.js
- **Metáfora:** "Function = empregado que executa tarefa específica quando você chama"

### 10.2 Database Functions: SQL Turbinado (14 min) [Apply]
**Objetivo:** Criar stored procedures
**Bloom Level:** Apply
**Conteúdo:**
- CREATE FUNCTION em PostgreSQL
- Parâmetros e retorno
- Chamar function via API
- **Aplicação:** "Lógica complexa protegida no banco"

### 10.3 Triggers: Ações Automáticas (12 min) [Apply]
**Objetivo:** Automatizar com triggers
**Bloom Level:** Apply
**Conteúdo:**
- Trigger BEFORE vs AFTER
- Trigger em INSERT, UPDATE, DELETE
- Casos de uso (auditoria, validação, notificação)
- **Transformação:** "Agora o banco trabalha por você"

### 10.4 Cron Jobs: Tarefas Agendadas (14 min) [Apply]
**Objetivo:** Agendar tarefas recorrentes
**Bloom Level:** Apply
**Conteúdo:**
- pg_cron extension
- Agendar function diária
- Monitorar execuções
- **Aplicação:** "Email diário automático funcionando"

---

## MÓDULO 11: INTEGRAÇÃO E DEPLOY
**Duração:** 72 minutos | 5 aulas
**Objetivo:** Conectar tudo e publicar

### 11.1 Conectando com Next.js/React (15 min) [Apply]
**Objetivo:** Integração com frameworks React
**Bloom Level:** Apply
**Conteúdo:**
- Instalar @supabase/supabase-js
- Configurar client
- Primeiro fetch de dados
- **Hands-On:** "Dados do Supabase renderizando no React"

### 11.2 Integração com FlutterFlow/Bubble (15 min) [Apply]
**Objetivo:** No-code integration
**Bloom Level:** Apply
**Conteúdo:**
- Conectar FlutterFlow ao Supabase
- Conectar Bubble ao Supabase
- CRUD no-code
- **Democratização:** "Zero código, 100% funcional"

### 11.3 APIs REST Prontas para Usar (12 min) [Apply]
**Objetivo:** Usar APIs auto-geradas
**Bloom Level:** Apply
**Conteúdo:**
- PostgREST API automática
- Testar no Postman/Insomnia
- Autenticação nas APIs
- **Revelação:** "Sua API REST já tá pronta. Supabase gerou automaticamente."

### 11.4 Variáveis de Ambiente e Segurança (10 min) [Apply]
**Objetivo:** Proteger credenciais
**Bloom Level:** Apply
**Conteúdo:**
- .env e .env.local
- NUNCA commitar credenciais
- Usar variáveis no Vercel/Netlify
- **Segurança:** "Uma credencial vazada = seu app hackeado"

### 11.5 Deploy: Do Local para Produção (20 min) [Create]
**Objetivo:** Publicar app completo
**Bloom Level:** Create
**Conteúdo:**
- Deploy front-end (Vercel)
- Conectar com Supabase production
- Testar em produção
- **Celebração:** "Seu app está NO AR. Link real funcionando."

---

## MÓDULO 12: PROJETO FINAL E CONCLUSÃO
**Duração:** 60 minutos | 4 aulas
**Objetivo:** Consolidar aprendizado e nova identidade

### 12.1 Projeto Final: App Completo Parte 1 (20 min) [Create]
**Objetivo:** Criar app do zero - parte 1
**Bloom Level:** Create
**Conteúdo:**
- Planejar app (papel e caneta)
- Criar schema de banco
- Implementar auth
- Criar primeiras tabelas

### 12.2 Projeto Final: App Completo Parte 2 (20 min) [Create]
**Objetivo:** Criar app do zero - parte 2
**Bloom Level:** Create
**Conteúdo:**
- Implementar CRUD
- Adicionar segurança (RLS)
- Integrar storage
- Deploy

### 12.3 Melhores Práticas e Performance (12 min) [Evaluate]
**Objetivo:** Otimizar e profissionalizar
**Bloom Level:** Evaluate
**Conteúdo:**
- Indexes para performance
- Query optimization
- Backup strategies
- Monitoramento
- **Pro Tips:** "Como devs sênior fazem"

### 12.4 Você É Um Founder Tech Agora (8 min) [Create]
**Objetivo:** Transformação de identidade completa
**Bloom Level:** Create
**Conteúdo:**
- Recapitulação da jornada
- O que você conquistou
- Próximos passos (roadmap)
- **Celebração Final:** "Você não é mais 'não-técnico'. Você é founder tech."

---

## ASSESSMENTS & PROJETOS

### Quizzes (5 total)
- Quiz 1: Conceitos Básicos (Módulo 1)
- Quiz 2: Modelagem (Módulo 2)
- Quiz 3: SQL (Módulo 4)
- Quiz 4: Autenticação (Módulo 6)
- Quiz 5: Segurança (Módulo 7)

### Exercícios Práticos (8 total)
- Exercício: Normalizar Tabela de Agendamentos (Módulo 2)
- Mini-Projeto: Sistema de Clientes e Pedidos (Módulo 3)
- Projeto: CRUD Completo do seu Negócio (Módulo 4)
- Mini-Projeto: Sistema de Login Completo (Módulo 6)
- Exercício: Políticas RLS (Módulo 7)
- Exercício: Upload de Imagens (Módulo 8)
- Exercício: Chat Realtime (Módulo 9)
- Exercício: Trigger de Auditoria (Módulo 10)

### Projeto Final (1 total)
- App Completo do Zero ao Deploy (Módulo 12)

---

## RECURSOS INCLUÍDOS

### Templates
1. Esquema Visual de Banco (PDF interativo)
2. Template de Autenticação (código pronto)
3. Snippets para CRUD (todas operações)

### Cheat Sheets
1. SQL com Prompts IA (Notion template)
2. Troubleshooting Guide (erros comuns)
3. Calculadora ROI Supabase (vs. contratar dev)

### Roadmap
1. Roadmap Pós-Curso (próximos passos)

---

## PROGRESSÃO PEDAGÓGICA

### Bloom's Taxonomy Distribution:
- **Remember (Level 1):** 4 aulas (8%)
- **Understand (Level 2):** 12 aulas (23%)
- **Apply (Level 3):** 28 aulas (54%)
- **Analyze (Level 4):** 6 aulas (12%)
- **Evaluate (Level 5):** 2 aulas (4%)
- **Create (Level 6):** 4 aulas (8%)

### Teoria vs Prática:
- **Teoria:** 30% (conceitos, metáforas, contexto)
- **Prática:** 70% (hands-on, exercícios, projetos)

### Cognitive Load:
- Máximo 3-4 conceitos novos por aula
- Check-ins frequentes
- Microlearning (10-15 min)
- Recapitulação no final de cada aula

---

**Total:** 52 aulas + 5 quizzes + 8 exercícios + 1 projeto final = **12-14 horas de transformação**

*Outline gerado pelo CreatorOS v3.0*
*Framework: Espiral Expansiva + Anti-Impostor Design*
*Instrutor: José Amorim*
