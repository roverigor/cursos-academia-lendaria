---
# Project Metadata
project_id: "{uuid}"
project_title: "{project_title}"
project_type: "capstone | module_project | exercise"
course: "{course_title}"
module: {module_id or "final"}
instructor: "{instructor_name}"

# Project Details
duration_hours: {estimated_hours}
difficulty: "beginner | intermediate | advanced"
is_required: true | false
passing_score: 70

# Prerequisites
prerequisites:
  - "Completed Modules 1-{X}"
  - "{Other prerequisites}"

# Learning Objectives
learning_objectives:
  - "{objective_1}"
  - "{objective_2}"

# Timestamps
created_at: "{timestamp}"
version: "1.0"
---

# {project_title}

**Tipo:** {Capstone Project | Module Project | Practical Exercise}
**Duração Estimada:** {hours} horas
**Nível:** {difficulty}
**Obrigatório:** {Sim | Não}

---

## 🎯 Objetivo do Projeto

{1-2 paragraphs describing what the student will build and why it matters}

{Example:}
{Neste projeto final, você vai criar seu primeiro clone de IA funcional e monetizável. Você aplicará todos os conceitos do curso - desde a coleta de dados até o deployment - para construir um assistente que resolve um problema real do seu nicho. Ao final, você terá não apenas um projeto de portfólio, mas uma ferramenta que pode gerar renda imediatamente.}

---

## 📋 O Que Você Vai Criar

**Entregável Principal:**
{Clear description of what they'll produce}

**Componentes do Projeto:**

- [ ] {Component 1 - e.g., "Dataset de treinamento (mínimo 30 exemplos)"}
- [ ] {Component 2 - e.g., "Clone configurado e treinado"}
- [ ] {Component 3 - e.g., "Documentação de uso"}
- [ ] {Component 4 - e.g., "Casos de teste validados"}
- [ ] {Component 5 - e.g., "Plano de monetização"}

---

## 🎓 Objetivos de Aprendizagem

Ao completar este projeto, você terá demonstrado domínio de:

- {Learning objective 1}
- {Learning objective 2}
- {Learning objective 3}
- {Learning objective 4}

---

## ✅ Pré-requisitos

Antes de começar este projeto, certifique-se de que você:

- [ ] Completou os Módulos 1-{X}
- [ ] Entende o framework CODE
- [ ] Tem acesso às ferramentas necessárias: {list tools}
- [ ] Definiu um nicho/problema específico para resolver

---

## 🚀 Fases do Projeto

### Fase 1: Planejamento & Definição (2 horas)

**Objetivo:** Definir escopo claro e viável do seu clone

**Tarefas:**

1. **Escolha Seu Nicho**
   - Identifique um problema específico que você resolve frequentemente
   - Valide que é repetitivo (não único toda vez)
   - Exemplo: "Responder perguntas sobre SEO para pequenos negócios"

2. **Defina o Propósito do Clone**
   - Use o template: "Meu clone ajuda [público] a [ação] para que [resultado]"
   - Exemplo: "Meu clone ajuda donos de e-commerce a otimizar títulos de produtos para que vendam mais no Google"

3. **Estabeleça Métricas de Sucesso**
   - Como você saberá que funciona?
   - Exemplo: "80% das respostas não precisam de edição" ou "Economiza 5h/semana"

**Entregável Fase 1:**
- Documento de 1 página com nicho, propósito e métricas

**Templates:**
- [📄 Template: Project Brief](../resources/template-project-brief.yaml)

---

### Fase 2: Captura de Dados (4 horas)

**Objetivo:** Coletar 30+ exemplos reais de alta qualidade

**Tarefas:**

1. **Colete Exemplos Reais**
   - Mínimo 30 exemplos (ideal 50+)
   - Variados (diferentes cenários do mesmo domínio)
   - Incluir contexto quando relevante

2. **Documente Cada Exemplo**
   - Input (pergunta, cenário, prompt)
   - Output (sua resposta/solução ideal)
   - Notas (por que essa abordagem, considerações)

3. **Organize em Estrutura Padrão**
   - Use formato consistente (YAML, JSON ou MD)
   - Exemplo:
     ```yaml
     example_1:
       input: "Como otimizar título de produto de tênis?"
       context: "E-commerce de calçados, público 25-35 anos"
       output: "Use fórmula: [Marca] [Tipo] [Característica] | [Benefício]..."
       notes: "Sempre priorizar palavra-chave principal no início"
     ```

**Entregável Fase 2:**
- Dataset de 30+ exemplos em formato estruturado

**Templates:**
- [📄 Template: Training Dataset](../resources/template-training-dataset.yaml)

---

### Fase 3: Organização & Destilação (3 horas)

**Objetivo:** Categorizar dados e extrair padrões

**Tarefas:**

1. **Categorize Seus Exemplos**
   - Agrupe por tema/tipo
   - Identifique as 3-5 categorias principais
   - Exemplo: "SEO On-Page" (40%), "SEO Técnico" (30%), "Link Building" (30%)

2. **Extraia Padrões de Voz**
   - Como você explica conceitos?
   - Que tipo de exemplos usa? (analogias, casos reais, dados)
   - Tom: formal, casual, técnico?

3. **Identifique Edge Cases**
   - Situações atípicas ou exceções
   - Como você lida com perguntas fora do escopo?
   - Erros comuns a evitar

**Entregável Fase 3:**
- Documento de análise: categorias, padrões, edge cases

**Templates:**
- [📄 Template: Data Analysis Report](../resources/template-data-analysis.md)

---

### Fase 4: Construção do Clone (4 horas)

**Objetivo:** Treinar e configurar o clone de IA

**Tarefas:**

1. **Configure a Ferramenta**
   - Use {tool recommendation: ChatGPT Custom GPTs, Claude Projects, or similar}
   - Insira system prompt baseado nos padrões identificados
   - Upload dataset de treinamento

2. **System Prompt Structure**
   ```
   Você é um especialista em [seu nicho].

   Seu propósito: [propósito do clone]

   Tom de voz: [baseado na análise]

   Formato de resposta:
   - [estrutura típica]

   Sempre inclua:
   - [elementos obrigatórios]

   Nunca:
   - [o que evitar]
   ```

3. **Iteração Inicial**
   - Teste com 5 perguntas do seu dataset
   - Compare output do clone vs. suas respostas originais
   - Ajuste system prompt se necessário

**Entregável Fase 4:**
- Clone configurado e funcional
- System prompt finalizado

**Templates:**
- [📄 Template: System Prompt](../resources/template-system-prompt.md)

---

### Fase 5: Testes & Validação (3 horas)

**Objetivo:** Garantir qualidade e confiabilidade

**Tarefas:**

1. **Teste Sistemático**
   - Crie 10 perguntas novas (não no dataset de treino)
   - Avalie respostas do clone:
     - ✅ Correto e completo (não precisa edição)
     - ⚠️ Correto mas precisa refinamento
     - ❌ Incorreto ou fora do escopo

2. **Calcule Taxa de Sucesso**
   - Meta: 70%+ respostas ✅ (sem edição)
   - Se < 70%: revise system prompt e dataset

3. **Teste Edge Cases**
   - Perguntas ambíguas
   - Perguntas fora do escopo
   - Perguntas complexas

4. **Documente Limitações**
   - O que o clone faz bem?
   - O que ainda precisa intervenção humana?
   - Quando NÃO usar o clone?

**Entregável Fase 5:**
- Relatório de testes (10 casos + taxa de sucesso)
- Documentação de limitações

---

### Fase 6: Deployment & Uso (2 horas)

**Objetivo:** Colocar o clone em produção

**Tarefas:**

1. **Crie Guia de Uso**
   - Como acessar o clone?
   - Quando usar vs. quando não usar?
   - Exemplos de prompts eficazes

2. **Defina Workflow de Produção**
   - Onde o clone se encaixa no seu dia-a-dia?
   - Como integrar com ferramentas existentes?
   - Exemplo: "Todo email de cliente passa pelo clone primeiro, depois eu reviso"

3. **Estabeleça Processo de Melhoria**
   - Como coletar novos exemplos?
   - Com que frequência retreinar/atualizar?
   - Como medir impacto (tempo economizado, qualidade)?

**Entregável Fase 6:**
- Guia de uso (1-2 páginas)
- Workflow documentado

---

### Fase 7: Monetização (2 horas) - OPCIONAL

**Objetivo:** Transformar o clone em receita

**Tarefas:**

1. **Identifique Modelo de Monetização**
   - Vender acesso ao clone (SaaS)
   - Usar clone para escalar serviços (você + clone = mais clientes)
   - Licenciar clone para outros profissionais
   - Criar produto digital usando o clone (ebook, curso, templates)

2. **Calcule Proposta de Valor**
   - Quanto tempo o clone economiza?
   - Qual o valor dessa economia? (R$/hora * horas economizadas)
   - Preço sugerido: 20-30% do valor economizado

3. **Defina Go-to-Market**
   - Quem compraria isso? (ICP)
   - Onde eles estão? (canais de distribuição)
   - Como provar valor? (demo, teste gratuito, caso de uso)

**Entregável Fase 7:**
- Plano de monetização (1 página)

---

## 📦 Entrega Final

### O Que Submeter

Crie um repositório/pasta com:

```
meu-clone-ia/
├── README.md              # Visão geral do projeto
├── project-brief.md       # Fase 1: Nicho, propósito, métricas
├── dataset/
│   └── training-data.yaml # Fase 2: 30+ exemplos
├── analysis/
│   └── data-analysis.md   # Fase 3: Padrões e categorias
├── clone/
│   ├── system-prompt.md   # Fase 4: Prompt finalizado
│   └── config.yaml        # Configurações
├── testing/
│   └── test-report.md     # Fase 5: Resultados dos testes
├── docs/
│   ├── user-guide.md      # Fase 6: Como usar
│   └── workflow.md        # Fase 6: Integração no dia-a-dia
└── monetization/
    └── business-plan.md   # Fase 7 (opcional): Plano de monetização
```

### Formatos Aceitos

- **Repositório GitHub** (preferível)
- **Google Drive/Dropbox** (pasta compartilhada)
- **Notion** (workspace público)
- **ZIP file** (se offline)

### Checklist de Entrega

Antes de submeter, verifique:

- [ ] Todos os 6 entregáveis obrigatórios presentes
- [ ] README explica o projeto claramente
- [ ] Dataset tem mínimo 30 exemplos
- [ ] Taxa de sucesso nos testes ≥ 70%
- [ ] Clone está acessível (link ou instruções de acesso)
- [ ] Documentação completa (uso + limitações)

---

## 📊 Critérios de Avaliação

Seu projeto será avaliado em 5 dimensões:

### 1. Qualidade do Dataset (20 pontos)

| Critério | Excelente (18-20) | Bom (15-17) | Satisfatório (12-14) | Insuficiente (<12) |
|----------|-------------------|-------------|----------------------|-------------------|
| Quantidade | 50+ exemplos | 40-49 | 30-39 | <30 |
| Variedade | Alta (cobre 80%+ casos) | Média (60-79%) | Baixa (50-59%) | Muito baixa |
| Qualidade | Detalhados, contextualizados | Completos | Básicos | Incompletos |
| Formatação | Perfeitamente consistente | Consistente | Pequenas inconsistências | Inconsistente |

### 2. Configuração do Clone (20 pontos)

| Critério | Excelente (18-20) | Bom (15-17) | Satisfatório (12-14) | Insuficiente (<12) |
|----------|-------------------|-------------|----------------------|-------------------|
| System Prompt | Claro, específico, eficaz | Claro e específico | Funcional | Vago/genérico |
| Voice Match | 90%+ fidelidade à sua voz | 80-89% | 70-79% | <70% |
| Edge Cases | Trata bem exceções | Trata a maioria | Trata parcialmente | Não trata |

### 3. Testes & Validação (25 pontos)

| Critério | Excelente (23-25) | Bom (20-22) | Satisfatório (17-19) | Insuficiente (<17) |
|----------|-------------------|-------------|----------------------|-------------------|
| Taxa de Sucesso | 85%+ sem edição | 75-84% | 70-74% | <70% |
| Cobertura de Testes | 15+ casos variados | 10-14 casos | 5-9 casos | <5 casos |
| Documentação de Limitações | Completa e honesta | Boa | Básica | Insuficiente |

### 4. Documentação (20 pontos)

| Critério | Excelente (18-20) | Bom (15-17) | Satisfatório (12-14) | Insuficiente (<12) |
|----------|-------------------|-------------|----------------------|-------------------|
| User Guide | Claro, exemplos práticos | Claro | Básico | Confuso |
| Workflow Integration | Bem definido | Definido | Vago | Ausente |
| README | Profissional | Completo | Básico | Incompleto |

### 5. Aplicação Prática & Impacto (15 pontos)

| Critério | Excelente (14-15) | Bom (12-13) | Satisfatório (10-11) | Insuficiente (<10) |
|----------|-------------------|-------------|----------------------|-------------------|
| Utilidade Real | Resolve problema significativo | Resolve problema | Utilidade limitada | Teórico/não prático |
| Viabilidade | Pronto para uso imediato | Quase pronto | Precisa ajustes | Não viável |
| Potencial de Impacto | Alto (economiza 5h+/semana) | Médio (2-5h) | Baixo (1-2h) | Mínimo |

### Pontuação Total: 100 pontos

- **90-100:** A+ (Excepcional - pronto para monetizar)
- **80-89:** A (Excelente - deploy imediato)
- **70-79:** B (Bom - pequenos ajustes)
- **60-69:** C (Satisfatório - precisa refinamento)
- **<60:** Refazer (não atingiu padrão mínimo)

**Nota de Corte:** 70 pontos

---

## 💡 Dicas de Sucesso

### Do's ✅

- **Comece pequeno:** Clone com 1 propósito claro > clone genérico
- **Qualidade > Quantidade:** 30 exemplos excelentes > 100 medianos
- **Teste cedo, teste sempre:** Não espere terminar para testar
- **Documente conforme faz:** Anote insights durante o processo
- **Seja honesto sobre limitações:** Clone bom tem escopo definido

### Don'ts ❌

- **Não tente abranger tudo:** "Clone de marketing" é vago demais
- **Não invente exemplos:** Use apenas casos reais
- **Não ignore edge cases:** Eles vão acontecer em produção
- **Não pule a fase de testes:** Taxa de sucesso <70% = retrabalho
- **Não exagere capacidades:** Clone é ferramenta, não mágica

---

## 🎓 Recursos de Apoio

### Templates Obrigatórios

- [📄 Project Brief Template](../resources/template-project-brief.yaml)
- [📄 Training Dataset Template](../resources/template-training-dataset.yaml)
- [📄 System Prompt Template](../resources/template-system-prompt.md)

### Guias de Referência

- [📘 Guia: Como Escolher Seu Nicho](../resources/guide-choosing-niche.md)
- [📘 Guia: Coleta de Dados de Alta Qualidade](../resources/guide-data-collection.md)
- [📘 Guia: Writing Effective System Prompts](../resources/guide-system-prompts.md)

### Exemplos Inspiradores

- [🎯 Exemplo 1: Clone de SEO para E-commerce](../resources/example-seo-clone.md)
- [🎯 Exemplo 2: Clone de Atendimento para Consultoria](../resources/example-support-clone.md)
- [🎯 Exemplo 3: Clone de Copywriting para Redes Sociais](../resources/example-copywriting-clone.md)

### Ferramentas Recomendadas

- **Para criar clone:** ChatGPT Custom GPTs, Claude Projects, Poe
- **Para organizar dados:** Notion, Airtable, Google Sheets
- **Para testes:** Template de teste (fornecido)
- **Para documentação:** Markdown, Notion, Google Docs

---

## ❓ FAQ

### P: Quanto tempo realmente leva?

**R:** Com foco total, 12-20 horas divididas em 1-2 semanas. Mas você pode ir mais devagar.

### P: E se meu clone não atingir 70% de taxa de sucesso?

**R:** Não avance! Revise:
1. Dataset (exemplos ruins?)
2. System prompt (instruções claras?)
3. Testes (perguntas fora do escopo?)

### P: Posso trabalhar em dupla?

**R:** Sim, mas cada pessoa deve submeter projeto individual (nichos diferentes).

### P: Preciso programar?

**R:** Não! Usamos ferramentas no-code (ChatGPT, Claude). Zero código necessário.

### P: E se eu não tiver 30 exemplos ainda?

**R:** Não comece o projeto ainda. Volte e colete dados do seu dia-a-dia por 1-2 semanas primeiro.

### P: Posso mudar de nicho no meio do caminho?

**R:** Pode, mas recomendo validar viabilidade antes (Fase 1 é rápida, valide bem).

---

## 🚀 Próximos Passos Após o Projeto

Parabéns por completar! Agora:

1. **Use o clone por 1 semana** - Colete feedback real
2. **Atualize dataset** - Adicione novos exemplos baseados no uso
3. **Melhore iterativamente** - Clone evolui com uso
4. **Considere monetização** - Se economiza 5h+/semana, tem valor
5. **Compartilhe na comunidade** - Inspire outros, receba feedback

---

**Curso:** {course_title}
**Instrutor:** {instructor_name}
**Tempo Estimado:** {hours} horas
**Nota de Corte:** 70 pontos

---

*Gerado com CreatorOS - The Operating System for Digital Creators*
*Versão 1.0 | Última atualização: {timestamp}*
