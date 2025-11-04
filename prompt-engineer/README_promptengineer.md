# Prompt Engineering - Arquitetura de Agentes Executivos

**Instrutor:** José Carlos Amorim  
**Duração:** 3 horas  
**Nível:** Fundamento 1 de 4 da Formação Gestor de IA  
**Ferramentas:** n8n + OpenRouter (acesso unificado a múltiplas LLMs)  

---

## 🎯 Para Quem é Este Curso

**Rafael, este é o FUNDAMENTO 1 da sua jornada como Gestor de IA.**

Você está aqui porque:
- ✅ Já completou o **Challenge Experience** (viu IA funcionando no WhatsApp)
- 😤 Sabe que IA "faz coisas incríveis", mas não sabe COMO CONTROLAR o resultado
- 🤔 Não entende por que o mesmo prompt funciona diferente em cada IA
- 💰 Precisa aprender a ARQUITETAR agentes que resolvem problemas REAIS de clientes
- ⏰ Está preparado para conteúdo técnico aplicado (não é mais "introdução")

**Barreira Mental que Vamos Quebrar:**
> "Você não precisa de mais um curso de 'como escrever prompts bonitos'. Você precisa entender como AGENTES DE IA pensam, decidem e executam. É a diferença entre saber dirigir um carro (ChatGPT) e saber gerenciar uma frota de caminhões autônomos (Sistemas Agênticos)."

**Conexão com sua jornada:**
- **Challenge Experience** → Você VIU IA funcionando
- **Fundamento 1 (AQUI)** → Você vai ARQUITETAR agentes profissionais
- **Fundamento 2 (RAG)** → Você vai dar MEMÓRIA aos agentes
- **Fundamento 3 (Vibe Coding)** → Você vai criar INTERFACES visuais
- **Fundamento 4 (Infraestrutura)** → Você vai ESCALAR para produção

---

## 🎁 O Que Você Vai Conquistar

Ao final deste Fundamento, você terá:

✅ **1 agente funcional de agendamento** rodando com 4 LLMs diferentes via OpenRouter  
✅ **Clareza total** de quando usar Gemini vs ChatGPT vs DeepSeek vs Grok  
✅ **Framework de Arquitetura Geodésica** para estruturar prompts profissionais  
✅ **Domínio técnico** de temperature, top_p, top_k aplicado em casos reais  
✅ **Template vendável** de agente precificável em R$ 3.500-8.000  
✅ **Vocabulário profissional** para justificar investimento com clientes  

**Resultado Comercial Esperado:**  
Você sai daqui sabendo oferecer "Agente de Agendamento Inteligente" por R$ 3.500-8.000 de setup + R$ 800-1.500/mês de manutenção.

**Por que OpenRouter?**
- ✅ **1 API Key, 4+ LLMs** → Sem precisar gerenciar múltiplas contas
- ✅ **Custo otimizado** → Paga só pelo que usa, sem mínimo de crédito
- ✅ **Comparação direta** → Troca de modelo mudando 1 linha de código
- ✅ **Produção real** → Mesma ferramenta que você vai usar com clientes

---

## 📚 Estrutura do Curso

### **MÓDULO 1: O TESTE DE REALIDADE** (45 min)
*Problem: "Por que meu agente não funciona consistentemente?"*

**Problema Real do Cliente:**
> "José, construí um agente de atendimento, mas às vezes ele responde certinho, outras vezes inventa informação que não existe. O que tá acontecendo?"

**O que você vai aprender a resolver:**
- Identificar quando o problema é o MODELO (não o prompt)
- Escolher LLM certo baseado em custo, velocidade e precisão
- Precificar serviço baseado na escolha técnica

- **Lesson 1.1:** O Mesmo Prompt, 4 Cérebros Diferentes (30 min)
  - **Case prático:** Agente de agendamento executando 4 tarefas idênticas
  - **Observação:** Gemini inventa, GPT-4 é preciso mas caro, DeepSeek trava em datas
  - **Decisão:** Quando usar cada modelo em produção

- **Lesson 1.2:** A Conta que o Cliente Não Vê (15 min)
  - **Case prático:** Cliente quer agente que processa 10.000 msgs/mês
  - **Cálculo:** Gemini ($15) vs GPT-4 ($300) vs Híbrido ($80)
  - **Proposta:** 3 pacotes técnicos justificados

---

### **MÓDULO 2: ARQUITETURA GEODÉSICA DE PROMPTS** (75 min)
*Problem: "Como estruturo um prompt que funcione em produção?"*

**Problema Real do Cliente:**
> "Meu agente funciona 80% das vezes. Nos outros 20%, ele faz besteira e eu não sei por quê. Como eu garanto consistência?"

**O que você vai aprender a resolver:**
- Estruturar prompts com os 6 componentes profissionais
- Identificar qual parte do prompt está falhando (debug estratégico)
- Adaptar prompt para necessidades específicas do cliente

- **Lesson 2.1:** A Arquitetura Invisível dos Prompts (20 min)
  - **Case prático:** Prompt "ruim" vs "profissional" - mesma tarefa, resultados opostos
  - **Revelação:** Diferença não é "escrever melhor", é ARQUITETURA
  - **Framework:** Introdução aos 6 Poliedros da Geodésia

- **Lesson 2.2:** Os 6 Poliedros da Geodésia Aplicada (25 min)
  - **Poliedro 1 - Identidade:** Quem é o agente, onde opera, qual papel
  - **Poliedro 2 - Ferramentas:** Quais capacidades tem acesso
  - **Poliedro 3 - Workflow:** Sequência de decisões (ETAPA 1 → 2 → 3)
  - **Poliedro 4 - Erros:** Como lidar com falhas e loops
  - **Poliedro 5 - Output:** Como comunicar resultados
  - **Poliedro 6 - Restrições:** Limites e validações obrigatórias
  - **Mapeamento:** Onde cada poliedro aparece no prompt real

- **Lesson 2.3:** ChatGPT vs Agente: Mundos Diferentes (15 min)
  - **Case prático:** "Marque reunião com João terça 14h"
  - **ChatGPT:** Responde com texto, não FAZ nada
  - **Agente:** EXECUTA tool_calling, CRIA evento, CONFIRMA
  - **Diferença técnica:** Conversa vs Execução

- **Lesson 2.4:** Adaptando para o Cliente (15 min)
  - **Template comentado:** Zonas Editáveis vs Zonas Fixas
  - **Case prático:** Cliente quer confirmação dupla antes de agendar
  - **Customização:** Mexer no Poliedro 3 (Workflow) sem quebrar o agente

---

### **MÓDULO 3: OS 3 NÍVEIS DE COMPLEXIDADE** (60 min)
*Problem: "Como evoluo de um agente simples para um sistema completo?"*

**Problema Real do Cliente:**
> "Comecei com agendamento básico. Agora o cliente quer que o agente também gerencie tarefas, envie lembretes e crie relatórios. Como adiciono isso sem quebrar tudo?"

**O que você vai aprender a resolver:**
- Progressão estruturada: 3 → 5 → 7 ferramentas
- Identificar quais Poliedros mudam quando adiciona complexidade
- Testar e validar cada nível antes de escalar

- **Lesson 3.1:** Nível Iniciante - 3 Ferramentas Google (20 min)
  - **Ferramentas:** Gmail + Calendar (Get) + Calendar (Create)
  - **Poliedros ativos:** 1, 2, 3, 4, 5, 6 (todos, mas simples)
  - **5 Testes práticos:** Enviar email → Verificar agenda → Criar evento → Verificar e agendar → Workflow completo
  - **Prompt pronto comentado:** Copy/paste funcional

- **Lesson 3.2:** Nível Intermediário - 5 Ferramentas (20 min)
  - **Novas ferramentas:** + Google Tasks + Google Sheets
  - **Poliedros que mudaram:** 2 (mais ferramentas), 3 (workflow expandido), 4 (novos erros)
  - **5 Testes práticos:** Criar task → Registrar em sheet → Workflow com decisão (email OU task) → Relatório mensal → Debug de falha
  - **Prompt comentado:** Zonas que mudaram destacadas

- **Lesson 3.3:** Nível Avançado - 7 Ferramentas + APIs Externas (20 min)
  - **Novas ferramentas:** + SerpAPI + Google Contacts
  - **Poliedros que mudaram:** 2 (APIs externas), 3 (workflow condicional complexo), 4 (rate limits), 6 (restrições de API)
  - **5 Testes práticos:** Buscar info na web → Validar contato → Workflow multi-agente → Orquestração → Produção simulada
  - **Prompt comentado:** Comparação completa Nível 1 → 3

---

### **MÓDULO 4: OS BOTÕES SECRETOS DA IA** (40 min)
*Problem: "Como controlo se a IA é criativa ou precisa?"*

**Problema Real do Cliente:**
> "Meu agente de atendimento às vezes é 'amigável demais' e inventa informação. Como faço ele seguir EXATAMENTE o script?"

**O que você vai aprender a resolver:**
- Controlar determinismo vs criatividade (temperature)
- Limitar vocabulário do agente (top_p, top_k)
- Configurações por tipo de agente (atendimento, análise, criativo)

- **Lesson 4.1:** Temperature - O Controle de Determinismo (15 min)
  - **Case prático:** Mesmo prompt, 3 temperatures (0.0 / 0.7 / 1.5)
  - **Observação:** 0.0 = robótico, 0.7 = natural, 1.5 = caos
  - **Regra aplicada:** Agentes executivos (0.0-0.3), Atendimento (0.6-0.8), Criativo (0.9+)

- **Lesson 4.2:** Top_P e Top_K - Filtros de Vocabulário (15 min)
  - **Metáfora:** Top_P = "use só 10% das palavras mais prováveis"
  - **Metáfora:** Top_K = "escolha entre essas 50 palavras apenas"
  - **Case prático:** Agente formal (top_k=20) vs Agente casual (top_k=80)

- **Lesson 4.3:** Receitas por Caso de Uso (10 min)
  - **Template 1:** Agente de Agendamento (temp 0.2, top_p 0.5, top_k 20)
  - **Template 2:** Agente de Atendimento (temp 0.7, top_p 0.9, top_k 50)
  - **Template 3:** Agente de Análise (temp 0.1, top_p 0.3, top_k 10)
  - **Template 4:** Agente Criativo (temp 0.9, top_p 0.95, top_k 80)

---

## 🛠️ Ferramentas Necessárias

**Obrigatórias:**
- **n8n Cloud** (gratuito para testar, $20/mês para produção)
- **OpenRouter API Key** ($5 inicial - acessa Gemini, GPT-4, DeepSeek, Grok, Claude)
- **Google Calendar API** (gratuito)
- **Gmail API** (gratuito)
- **Uazapi** (WhatsApp - R$ 27/mês) - já usado no Challenge Experience

**Opcionais para Nível 3:**
- **SerpAPI** ($5/mês - 100 buscas grátis)
- **Supabase** (banco de dados - gratuito)

**Por que OpenRouter?**
```
SEM OpenRouter:
- Gemini API Key ($) + crédito mínimo
- ChatGPT API Key ($5 mínimo)
- DeepSeek API Key (cadastro separado)
- Grok API Key (precisa X Premium)
- Claude API Key ($5 mínimo)
= 5 contas, 5 cobranças, complexidade

COM OpenRouter:
- 1 API Key ($5 inicial)
- Acesso a 100+ modelos
- 1 dashboard, 1 cobrança
- Troca de modelo = 1 linha de código
= Simplicidade profissional
```

---

## 💰 Potencial de Monetização

**Este Fundamento te habilita a vender:**

### **Serviço 1: Agente de Agendamento**
- **Setup:** R$ 3.500 (Nível 1) | R$ 5.000 (Nível 2) | R$ 8.000 (Nível 3)
- **Manutenção:** R$ 800-1.500/mês
- **Tempo de dev:** 4-6 horas (Nível 1), 8-12 horas (Nível 3)
- **Lucro primeiro ano:** R$ 10.000-20.000 por cliente

### **Variações Possíveis:**
- Agente de Confirmação de Consultas (clínicas): R$ 5.000 + R$ 1.200/mês
- Agente de Follow-up de Vendas: R$ 8.000 + R$ 2.000/mês
- Agente de Triagem de Atendimento: R$ 6.500 + R$ 1.500/mês

### **Framework de Precificação:**
```
NÍVEL 1 (3 ferramentas):
- Gemini only: R$ 3.500 setup + R$ 800/mês
- GPT-4 only: R$ 5.500 setup + R$ 1.500/mês

NÍVEL 2 (5 ferramentas):
- Híbrido (Gemini triagem + GPT-4 crítico): R$ 5.000 + R$ 1.200/mês

NÍVEL 3 (7 ferramentas + APIs):
- Multi-modelo otimizado: R$ 8.000 + R$ 2.000/mês
```

**Justificativa técnica usando Geodésia:**
> "São 6 componentes arquiteturais (Poliedros), 7 ferramentas integradas, 4 LLMs configurados. Isso não é 'um prompt', é um sistema engenheirado."

---

## 🎤 Sobre o Instrutor

**José Carlos Amorim** - Gestor de IA Generativa e fundador da Agência Lendária

**Experiência Relevante:**
- 50+ agentes de IA construídos e entregues para clientes reais
- R$ 250.000+ faturados com serviços de IA em 2024
- Especialista em n8n, OpenRouter, RAG, e sistemas multi-agentes
- Professor de 200+ alunos na Formação Gestor de IA

**Formação:**
- Leaders of Learning - Harvard
- AI for Business - IBM
- AI Fluency - Anthropic
- Técnico em Mecatrônica (Gillette - Engenharia de Qualidade)

**Filosofia:**
> "Prompt engineering não é 'escrever bonito para IA'. É arquitetar sistemas que FUNCIONAM em produção, com clientes reais pagando dinheiro real. É a diferença entre hobby e profissão."

---

## 🎯 Metodologia: Problem-Based Learning

**Este curso segue PBL (Problem-Based Learning):**

### **Estrutura de Cada Módulo:**
1. **PROBLEMA REAL** → Cliente traz situação do mercado
2. **INVESTIGAÇÃO** → Você testa, compara, analisa
3. **SOLUÇÃO APLICADA** → Você constrói a resposta técnica
4. **VALIDAÇÃO** → 5 testes práticos provam que funciona
5. **COMERCIALIZAÇÃO** → Como vender essa solução

### **Exemplo - Módulo 1:**
- **Problema:** "Por que meu agente funciona diferente a cada vez?"
- **Investigação:** Testar 4 LLMs com mesmo prompt
- **Solução:** Escolher modelo baseado em caso de uso
- **Validação:** 4 tarefas × 4 modelos = 16 testes
- **Comercialização:** 3 pacotes técnicos precificados

### **Você não vai:**
❌ Assistir aulas teóricas sobre "o que é prompt"  
❌ Decorar definições de temperature sem contexto  
❌ Ver slides bonitos sem aplicação prática  

### **Você vai:**
✅ Resolver problemas reais que clientes trazem  
✅ Construir soluções testáveis e validáveis  
✅ Sair com templates comercializáveis  

---

## 📂 Arquivos do Curso

```
docs/courses/fundamento-1-prompt-engineering/
├── README.md                          # Este arquivo
├── course-outline.md                  # Estrutura completa
├── lessons/
│   ├── 1.1-mesmo-prompt-4-cerebros.md
│   ├── 1.2-conta-que-cliente-nao-ve.md
│   ├── 2.1-arquitetura-invisivel-prompts.md
│   ├── 2.2-6-poliedros-geodesia.md
│   ├── 2.3-chatgpt-vs-agente.md
│   ├── 2.4-adaptando-para-cliente.md
│   ├── 3.1-nivel-iniciante-3-ferramentas.md
│   ├── 3.2-nivel-intermediario-5-ferramentas.md
│   ├── 3.3-nivel-avancado-7-ferramentas.md
│   ├── 4.1-temperature-determinismo.md
│   ├── 4.2-top-p-top-k-filtros.md
│   └── 4.3-receitas-caso-uso.md
├── templates/
│   ├── n8n-agente-nivel-1.json           # Workflow 3 ferramentas
│   ├── n8n-agente-nivel-2.json           # Workflow 5 ferramentas
│   ├── n8n-agente-nivel-3.json           # Workflow 7 ferramentas
│   ├── prompt-nivel-1-comentado.md       # Template com zonas editáveis
│   ├── prompt-nivel-2-comentado.md
│   ├── prompt-nivel-3-comentado.md
│   ├── openrouter-setup-guide.md         # Como configurar OpenRouter
│   ├── proposta-comercial-agente.docx    # Documento de venda
│   └── checklist-antes-entregar.md       # Validação pré-cliente
├── assessments/
│   ├── teste-1-enviar-email-simples.md
│   ├── teste-2-verificar-agenda.md
│   ├── teste-3-criar-evento-calendario.md
│   ├── teste-4-verificar-e-agendar.md
│   ├── teste-5-workflow-completo.md
│   └── projeto-final-agente-vendavel.md
└── resources/
    ├── tabela-comparativa-llms-openrouter.pdf
    ├── calculadora-precificacao.xlsx
    ├── mapa-geodesia-visual.pdf
    ├── script-venda-com-geodesia.md
    ├── troubleshooting-openrouter.md
    └── biblioteca-prompts-profissionais.md
```

---

## 🚀 Como Usar Este Fundamento

**RAFAEL, VOCÊ ESTÁ NO FUNDAMENTO 1 DE 4:**

### **Pré-requisito:**
✅ Challenge Experience completo (você já viu IA funcionando)

### **Sequência de Estudo:**
1. **Setup Inicial (20 min):** 
   - Crie conta OpenRouter ($5 inicial)
   - Configure n8n Cloud (gratuito)
   - Conecte Google Calendar + Gmail

2. **Módulo 1 (45 min):** 
   - Construa o agente básico
   - Teste com 4 LLMs via OpenRouter
   - Compare resultados e custos
   - **FAÇA, não só assista**

3. **Módulo 2 (75 min):** 
   - Aprenda Arquitetura Geodésica
   - Mapeie os 6 Poliedros no prompt
   - Customize para caso específico
   - **Quebre o agente de propósito pra aprender**

4. **Módulo 3 (60 min):** 
   - Progrida: Nível 1 → 2 → 3
   - Execute os 5 testes em cada nível
   - Identifique quais Poliedros mudaram
   - **Celebre cada nível funcionando**

5. **Módulo 4 (40 min):** 
   - Domine temperature, top_p, top_k
   - Teste as 4 receitas prontas
   - **Sinta a diferença no comportamento**

6. **Projeto Final:** 
   - Construa 1 agente comercializável
   - Prepare proposta de venda
   - Demonstre em vídeo 2 min

### **Próximos Fundamentos:**
- **Fundamento 2 (RAG):** Dar memória ao agente (documentos, banco de dados)
- **Fundamento 3 (Vibe Coding):** Criar interface visual pro agente
- **Fundamento 4 (Infraestrutura):** Escalar pra 10.000 requisições/dia

**AVISOS IMPORTANTES:**
- ⚠️ **NÃO pule o Módulo 2** - Arquitetura Geodésica é o CORE de tudo
- ⚠️ **NÃO só leia** - Cada teste tem que rodar no SEU n8n
- ⚠️ **NÃO tenha medo de errar** - Agente vai falhar, é parte do aprendizado
- ⚠️ **NÃO pule para Fundamento 2** - Sem dominar prompts, RAG não faz sentido

**TEMPO TOTAL ESTIMADO:**
- Aulas: 3h40min
- Prática hands-on: 6-8 horas
- Projeto final: 4-6 horas
- **Total: 2-3 dias intensos ou 2 semanas tranquilas**

---

## 📞 Suporte & Comunidade

**Travou em alguma parte?**
- 📖 `resources/troubleshooting-openrouter.md` - Erros comuns
- 💬 **Comunidade Lendária (Circle)** - Grupo exclusivo do Gestor de IA
- 🆘 **Pronto Socorro (10h e 18h30)** - José Carlos ao vivo

**Quer mostrar seu agente?**
- Poste no Circle com #fundamento1-concluido
- Os melhores casos viram estudos de caso oficiais

**Dúvida sobre OpenRouter?**
- Setup completo em `templates/openrouter-setup-guide.md`
- Comparação de custos em `resources/tabela-comparativa-llms-openrouter.pdf`

---

## 🎓 Conclusão do Fundamento 1

**Para avançar para o Fundamento 2 (RAG), você precisa:**

✅ Completar os 4 módulos  
✅ Construir 1 agente funcional nos 3 níveis  
✅ Executar os 15 testes práticos (5 por nível)  
✅ Submeter 1 proposta comercial usando Geodésia  
✅ Demonstrar em vídeo (2 min) agente funcionando  

**Badge conquistado:**
🏆 **"Arquiteto de Agentes de IA - Nível 1"**

**Diferencial:**
Você não "participou de aula sobre prompts". Você **construiu sistema profissional vendável**.

---

## 🔥 MENSAGEM FINAL

**Rafael, você está no FUNDAMENTO 1 de uma jornada de 4 etapas.**

**O que você já tem:**
✅ Challenge Experience → Viu IA funcionando na prática

**O que você vai conquistar AQUI:**
✅ Fundamento 1 → Arquitetar agentes profissionais

**O que vem depois:**
- Fundamento 2 (RAG) → Dar contexto/memória aos agentes
- Fundamento 3 (Vibe Coding) → Criar interfaces visuais
- Fundamento 4 (Infraestrutura) → Escalar pra produção
- **Vivência Prática** → 1 semana na Agência Lendária
- **Diploma** → Gestor de IA certificado

**Você vai sair daqui sabendo:**

1. ✅ Estruturar prompts com Arquitetura Geodésica (6 Poliedros)
2. ✅ Escolher LLM certo via OpenRouter (custo × precisão × velocidade)
3. ✅ Controlar comportamento do agente (temperature, top_p, top_k)
4. ✅ Progredir complexidade (3 → 5 → 7 ferramentas)
5. ✅ Vender agente justificando preço com vocabulário técnico
6. ✅ Debugar identificando qual Poliedro falhou

**Você NÃO vai mais:**

❌ Ficar perdido entre "qual modelo usar"  
❌ Achar que "prompt bom" é sobre escrever bonito  
❌ Travar quando cliente perguntar sobre arquitetura  
❌ Ter vergonha de cobrar R$ 6.000+  
❌ Sentir que "não é técnico o suficiente"  

**Este é o fundamento. O alicerce. A base de tudo.**

Domine isso e os próximos 3 Fundamentos fazem sentido total.

Pule isso e você vai estar construindo casa sem base.

---

**Pronto para começar?** → Vá para `lessons/1.1-mesmo-prompt-4-cerebros.md`

---

*Fundamento 1 criado em 2025-10-17 | Formação Gestor de IA | Versão 1.0*