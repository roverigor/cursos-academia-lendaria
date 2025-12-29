# Course Outline: Prompt Engineering - Arquitetura de Agentes Executivos

**Instructor:** José Carlos Amorim
**Duration:** 3 horas (aulas) + 10-14h (hands-on)
**Level:** Fundamento 1 de 4 da Formação Gestor de IA
**Format:** Problem-Based Learning (PBL)
**Tools:** n8n + OpenRouter (acesso unificado a múltiplas LLMs)
**ICP:** Rafael - Futuro Gestor de IA que completou Challenge Experience

---

## Course Philosophy

> "Prompt engineering não é 'escrever bonito para IA'. É arquitetar sistemas que FUNCIONAM em produção, com clientes reais pagando dinheiro real. É a diferença entre hobby e profissão."

---

## Learning Journey Map

```
FUNDAÇÃO DO GESTOR DE IA

┌──────────────────┐
│ CHALLENGE        │
│ EXPERIENCE       │ → Você VIU IA funcionando
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ FUNDAMENTO 1     │
│ (VOCÊ ESTÁ AQUI) │ → Você vai ARQUITETAR agentes
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ FUNDAMENTO 2     │
│ (RAG)            │ → Você vai dar MEMÓRIA aos agentes
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ FUNDAMENTO 3     │
│ (Vibe Coding)    │ → Você vai criar INTERFACES visuais
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ FUNDAMENTO 4     │
│ (Infraestrutura) │ → Você vai ESCALAR para produção
└────────┬─────────┘
         │
         ▼
    🎓 Gestor de IA
```

---

## Module Structure

### MÓDULO 1: O TESTE DE REALIDADE (45 min)

**Barreira Mental a Quebrar:**
> "Você não precisa de mais um curso de 'como escrever prompts bonitos'. Você precisa entender como AGENTES DE IA pensam, decidem e executam."

**Problem:**
"Por que meu agente não funciona consistentemente?"

**Problema Real do Cliente:**
> "José, construí um agente de atendimento, mas às vezes ele responde certinho, outras vezes inventa informação que não existe. O que tá acontecendo?"

**Learning Objectives:**
- Identificar quando o problema é o MODELO (não o prompt)
- Escolher LLM certo baseado em custo, velocidade e precisão
- Precificar serviço baseado na escolha técnica

**Lessons:**

#### Lesson 1.1: O Mesmo Prompt, 4 Cérebros Diferentes (30 min)
- **Case prático:** Agente de agendamento executando 4 tarefas idênticas
- **Observação:** Gemini inventa, GPT-4 é preciso mas caro, DeepSeek trava em datas
- **Decisão:** Quando usar cada modelo em produção
- **Deliverable:** Tabela comparativa de 4 LLMs via OpenRouter

#### Lesson 1.2: A Conta que o Cliente Não Vê (15 min)
- **Case prático:** Cliente quer agente que processa 10.000 msgs/mês
- **Cálculo:** Gemini ($15) vs GPT-4 ($300) vs Híbrido ($80)
- **Proposta:** 3 pacotes técnicos justificados
- **Deliverable:** Calculadora de precificação

---

### MÓDULO 2: ARQUITETURA GEODÉSICA DE PROMPTS (75 min)

**Barreira Mental a Quebrar:**
> "A diferença entre um prompt que funciona 80% das vezes e um que funciona 98% não é 'escrever melhor'. É ARQUITETURA."

**Problem:**
"Como estruturo um prompt que funcione em produção?"

**Problema Real do Cliente:**
> "Meu agente funciona 80% das vezes. Nos outros 20%, ele faz besteira e eu não sei por quê. Como eu garanto consistência?"

**Learning Objectives:**
- Estruturar prompts com os 6 componentes profissionais (Geodésia)
- Identificar qual parte do prompt está falhando (debug estratégico)
- Adaptar prompt para necessidades específicas do cliente

**Lessons:**

#### Lesson 2.1: A Arquitetura Invisível dos Prompts (20 min)
- **Case prático:** Prompt "ruim" vs "profissional" - mesma tarefa, resultados opostos
- **Revelação:** Diferença não é "escrever melhor", é ARQUITETURA
- **Framework:** Introdução aos 6 Poliedros da Geodésia

#### Lesson 2.2: Os 6 Poliedros da Geodésia Aplicada (25 min)
- **Poliedro 1 - Identidade:** Quem é o agente, onde opera, qual papel
- **Poliedro 2 - Ferramentas:** Quais capacidades tem acesso
- **Poliedro 3 - Workflow:** Sequência de decisões (ETAPA 1 → 2 → 3)
- **Poliedro 4 - Erros:** Como lidar com falhas e loops
- **Poliedro 5 - Output:** Como comunicar resultados
- **Poliedro 6 - Restrições:** Limites e validações obrigatórias
- **Deliverable:** Mapeamento visual dos 6 Poliedros

#### Lesson 2.3: ChatGPT vs Agente: Mundos Diferentes (15 min)
- **Case prático:** "Marque reunião com João terça 14h"
- **ChatGPT:** Responde com texto, não FAZ nada
- **Agente:** EXECUTA tool_calling, CRIA evento, CONFIRMA
- **Diferença técnica:** Conversa vs Execução

#### Lesson 2.4: Adaptando para o Cliente (15 min)
- **Template comentado:** Zonas Editáveis vs Zonas Fixas
- **Case prático:** Cliente quer confirmação dupla antes de agendar
- **Customização:** Mexer no Poliedro 3 (Workflow) sem quebrar o agente

---

### MÓDULO 3: OS 3 NÍVEIS DE COMPLEXIDADE (60 min)

**Barreira Mental a Quebrar:**
> "Você não adiciona ferramentas aleatoriamente. Você EVOLUI a arquitetura de forma estruturada."

**Problem:**
"Como evoluo de um agente simples para um sistema completo?"

**Problema Real do Cliente:**
> "Comecei com agendamento básico. Agora o cliente quer que o agente também gerencie tarefas, envie lembretes e crie relatórios. Como adiciono isso sem quebrar tudo?"

**Learning Objectives:**
- Progressão estruturada: 3 → 5 → 7 ferramentas
- Identificar quais Poliedros mudam quando adiciona complexidade
- Testar e validar cada nível antes de escalar

**Lessons:**

#### Lesson 3.1: Nível Iniciante - 3 Ferramentas Google (20 min)
- **Ferramentas:** Gmail + Calendar (Get) + Calendar (Create)
- **Poliedros ativos:** 1, 2, 3, 4, 5, 6 (todos, mas simples)
- **5 Testes práticos:** Enviar email → Verificar agenda → Criar evento → Verificar e agendar → Workflow completo
- **Deliverable:** Workflow n8n funcional + Prompt comentado

#### Lesson 3.2: Nível Intermediário - 5 Ferramentas (20 min)
- **Novas ferramentas:** + Google Tasks + Google Sheets
- **Poliedros que mudaram:** 2 (mais ferramentas), 3 (workflow expandido), 4 (novos erros)
- **5 Testes práticos:** Criar task → Registrar em sheet → Workflow com decisão → Relatório mensal → Debug de falha
- **Deliverable:** Workflow n8n expandido + Diff dos prompts (v1 → v2)

#### Lesson 3.3: Nível Avançado - 7 Ferramentas + APIs Externas (20 min)
- **Novas ferramentas:** + SerpAPI + Google Contacts
- **Poliedros que mudaram:** 2 (APIs externas), 3 (workflow condicional), 4 (rate limits), 6 (restrições API)
- **5 Testes práticos:** Buscar info na web → Validar contato → Workflow multi-agente → Orquestração → Produção simulada
- **Deliverable:** Sistema completo comercializável

---

### MÓDULO 4: OS BOTÕES SECRETOS DA IA (40 min)

**Barreira Mental a Quebrar:**
> "Temperature, top_p, top_k não são 'configurações avançadas opcionais'. São CONTROLES FUNDAMENTAIS de comportamento do agente."

**Problem:**
"Como controlo se a IA é criativa ou precisa?"

**Problema Real do Cliente:**
> "Meu agente de atendimento às vezes é 'amigável demais' e inventa informação. Como faço ele seguir EXATAMENTE o script?"

**Learning Objectives:**
- Controlar determinismo vs criatividade (temperature)
- Limitar vocabulário do agente (top_p, top_k)
- Configurações por tipo de agente (atendimento, análise, criativo)

**Lessons:**

#### Lesson 4.1: Temperature - O Controle de Determinismo (15 min)
- **Case prático:** Mesmo prompt, 3 temperatures (0.0 / 0.7 / 1.5)
- **Observação:** 0.0 = robótico, 0.7 = natural, 1.5 = caos
- **Regra aplicada:** Agentes executivos (0.0-0.3), Atendimento (0.6-0.8), Criativo (0.9+)

#### Lesson 4.2: Top_P e Top_K - Filtros de Vocabulário (15 min)
- **Metáfora:** Top_P = "use só 10% das palavras mais prováveis"
- **Metáfora:** Top_K = "escolha entre essas 50 palavras apenas"
- **Case prático:** Agente formal (top_k=20) vs Agente casual (top_k=80)

#### Lesson 4.3: Receitas por Caso de Uso (10 min)
- **Template 1:** Agente de Agendamento (temp 0.2, top_p 0.5, top_k 20)
- **Template 2:** Agente de Atendimento (temp 0.7, top_p 0.9, top_k 50)
- **Template 3:** Agente de Análise (temp 0.1, top_p 0.3, top_k 10)
- **Template 4:** Agente Criativo (temp 0.9, top_p 0.95, top_k 80)
- **Deliverable:** Cheat sheet de configurações

---

## Assessments

### Progressive Testing (Throughout Course)
- **Teste 1:** Enviar email simples (Módulo 3.1)
- **Teste 2:** Verificar agenda (Módulo 3.1)
- **Teste 3:** Criar evento no calendário (Módulo 3.1)
- **Teste 4:** Verificar e agendar (Módulo 3.1)
- **Teste 5:** Workflow completo (Módulo 3.1)

### Final Project
**Agente Comercializável Completo**
- Construir 1 agente nos 3 níveis de complexidade
- Preparar proposta comercial usando vocabulário Geodésico
- Demonstrar em vídeo (2 min) agente funcionando
- Justificar escolhas técnicas (modelo, temperature, ferramentas)

---

## Success Criteria

**Para avançar para o Fundamento 2 (RAG), você precisa:**

✅ Completar os 4 módulos
✅ Construir 1 agente funcional nos 3 níveis
✅ Executar os 15 testes práticos (5 por nível)
✅ Submeter 1 proposta comercial usando Geodésia
✅ Demonstrar em vídeo (2 min) agente funcionando

**Badge conquistado:**
🏆 **"Arquiteto de Agentes de IA - Nível 1"**

---

## Differentiation

**Você não "participou de aula sobre prompts".**
**Você construiu sistema profissional vendável.**

---

## Monetization Potential

### Serviço Habilitado por Este Curso

**Agente de Agendamento:**
- **Setup:** R$ 3.500 (Nível 1) | R$ 5.000 (Nível 2) | R$ 8.000 (Nível 3)
- **Manutenção:** R$ 800-1.500/mês
- **Tempo de dev:** 4-6 horas (Nível 1), 8-12 horas (Nível 3)
- **Lucro primeiro ano:** R$ 10.000-20.000 por cliente

**Justificativa técnica usando Geodésia:**
> "São 6 componentes arquiteturais (Poliedros), 7 ferramentas integradas, 4 LLMs configurados. Isso não é 'um prompt', é um sistema engenheirado."

---

**Pronto para começar?** → Vá para `lessons/1.1-mesmo-prompt-4-cerebros.md`

---

*Course outline gerado via CreatorOS com voz de José Carlos Amorim (MMOS)*
*Fidelidade de voz: 90%+ (MMOS benchmark)*
