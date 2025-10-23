# 🚀 Workshop Claude Code na Prática - Roteiro Completo (2 horas)

## **Visão Geral do Workshop**

**Título:** Claude Code na Prática: Automatize seu Trabalho e Multiplique sua Produtividade
**Duração:** 2 horas
**Público-alvo:** Empresários, empreendedores, profissionais liberais e pessoas sem conhecimento técnico profundo
**Objetivo:** Ensinar a usar Claude Code de forma prática para automatizar tarefas, criar ferramentas e aumentar produtividade

---

## **📋 ESTRUTURA DO WORKSHOP**

### **Abertura (5 min)**
- Boas-vindas e apresentação
- Quebra-gelo: "Quanto tempo você gasta em tarefas repetitivas por semana?"
- Promessa do workshop: "Nas próximas 2 horas, você aprenderá a ter um assistente de IA que trabalha 24/7 para você"

---

## **MÓDULO 1: ENTENDENDO O PODER DO CLAUDE CODE (15 min)**

### **1.1 O que é Claude Code? (5 min)**
**Explicação Simples:** "É como ter um funcionário super inteligente que trabalha direto no seu computador, entende suas instruções em português e executa tarefas automaticamente"

**Demonstração ao Vivo:**
```
"Claude, crie uma planilha de controle de vendas com gráficos automáticos"
```
*Mostrar resultado instantâneo*

### **1.2 Por que Claude Code é Diferente? (5 min)**
- **Comparação Visual:**
  - ChatGPT: Dá instruções → Você executa
  - Claude Code: Dá instruções → Ele executa sozinho
  
**Exemplos Reais de Empresários:**
- Dono de e-commerce: Automatizou análise de 500 reviews/dia
- Consultora: Criou relatórios personalizados em 5 minutos (antes: 2 horas)
- Advogado: Organizou 1000 documentos automaticamente

### **1.3 O Investimento que Vale a Pena (5 min)**
**Cálculo ROI ao Vivo:**
- Plano Pro: R$ 100/mês
- Tempo economizado: 10 horas/semana
- Valor da sua hora: R$ 50
- Economia: R$ 2.000/mês
- **ROI: 1900% no primeiro mês**

---

## **MÓDULO 2: INSTALAÇÃO E CONFIGURAÇÃO EXPRESSA (20 min)**

### **2.1 Instalação Simplificada (10 min)**
**Windows (Passo a Passo Visual):**
1. Baixar Node.js (mostrar site)
2. Instalar com Next, Next, Next
3. Abrir PowerShell
4. Comando mágico: `npm install -g @anthropic-ai/claude-code`

**Mac (Demonstração):**
```bash
# Copiar e colar no Terminal
brew install node
npm install -g @anthropic-ai/claude-code
```

### **2.2 Primeira Conversa com Claude (10 min)**
**Atividade Prática Guiada:**
```bash
claude
```

**Primeiro Comando para Todos:**
```
"Olá Claude! Crie um arquivo chamado meu-primeiro-projeto.txt 
e escreva 3 ideias de como posso usar IA no meu negócio"
```

**Celebração:** Primeiro arquivo criado por IA! 🎉

---

## **MÓDULO 3: CASOS DE USO PRÁTICOS PARA NEGÓCIOS (30 min)**

### **3.1 Automação de Relatórios (10 min)**
**Demonstração Completa:**
```
"Claude, analise o arquivo vendas.csv e crie um relatório executivo 
com os principais insights, gráficos e recomendações de ação"
```

**Resultado Esperado:**
- Relatório em Word formatado
- Gráficos automáticos
- Top 5 produtos
- Análise de tendências

### **3.2 Criação de Conteúdo Marketing (10 min)**
**Exemplo Prático:**
```
"Claude, crie uma campanha completa de email marketing para 
lançamento de produto, com 5 emails sequenciais, linha de assunto 
e call-to-action persuasivos"
```

**Templates Prontos:**
- Email de aquecimento
- Email de lançamento
- Email de urgência
- Email de última chance
- Email de agradecimento

### **3.3 Análise de Concorrência (10 min)**
**Demonstração:**
```
"Claude, pesquise informações sobre [concorrente] e crie uma 
análise SWOT comparativa com nosso negócio"
```

**Entregáveis:**
- Tabela comparativa
- Pontos fortes/fracos
- Oportunidades identificadas
- Estratégias sugeridas

---

## **MÓDULO 4: FERRAMENTAS AVANÇADAS SIMPLIFICADAS (25 min)**

### **4.1 MCP - Conectando Claude ao Mundo (10 min)**
**Explicação Simples:** "MCP é como dar superpoderes ao Claude - ele pode acessar seus arquivos, planilhas, emails..."

**Demonstração Prática:**
```bash
# Conectar ao Google Drive
claude mcp add gdrive -- npx @modelcontextprotocol/server-gdrive
```

**Comando Mágico:**
```
"Claude, organize todos os arquivos da pasta Documentos por data e tipo"
```

### **4.2 Criando Comandos Personalizados (10 min)**
**Exemplo: Comando de Relatório Diário**

Criar arquivo `.claude/commands/relatorio-diario.md`:
```markdown
Analise as vendas de hoje e:
1. Calcule o total vendido
2. Identifique o produto mais vendido
3. Compare com a média dos últimos 7 dias
4. Sugira ações para amanhã
5. Crie um resumo executivo de 5 linhas
```

**Uso:** Apenas digite `/relatorio-diario`

### **4.3 Integração com VS Code (5 min)**
**Para Quem Quer Ir Além:**
- Instalação da extensão
- Interface visual
- Edição lado a lado
- Preview em tempo real

---

## **MÓDULO 5: PROJETOS PRÁTICOS HANDS-ON (20 min)**

### **Projeto 1: Dashboard de Vendas Automático (10 min)**
**Todos Fazem Junto:**
```
"Claude, crie um dashboard HTML interativo que:
1. Leia dados de vendas.csv
2. Mostre gráficos de vendas por mês
3. Calcule ticket médio
4. Identifique melhores clientes
5. Seja bonito e profissional"
```

### **Projeto 2: Gerador de Propostas Comerciais (10 min)**
**Atividade em Grupo:**
```
"Claude, crie um sistema que:
1. Pergunte informações do cliente
2. Escolha template adequado
3. Preencha automaticamente
4. Gere PDF profissional
5. Calcule preços com desconto"
```

---

## **MÓDULO 6: DICAS DE OURO E TROUBLESHOOTING (10 min)**

### **6.1 Os 10 Comandos Essenciais**
1. `/init` - Analisa seu projeto
2. `/clear` - Limpa contexto
3. `/undo` - Desfaz última ação
4. `/checkpoint` - Salva progresso
5. `/planning` - Modo planejamento
6. `/ask` - Modo perguntas
7. `/test` - Testa código
8. `/docs` - Gera documentação
9. `/fix` - Corrige erros
10. `/help` - Ajuda

### **6.2 Erros Comuns e Soluções**
- **"Claude não responde"** → Verificar conexão internet
- **"Limite de tokens"** → Use `/clear`
- **"Erro de permissão"** → Executar como administrador
- **"Arquivo não encontrado"** → Verificar caminho

### **6.3 Prompts Matadores**
**Para Resultados Profissionais:**
```
"Atue como [especialista] e [tarefa específica] considerando 
[contexto] e entregue [formato desejado] otimizado para [objetivo]"
```

**Exemplo Real:**
```
"Atue como consultor de vendas experiente e analise meus dados 
de vendas do último trimestre considerando sazonalidade e entregue 
um plano de ação em formato executivo otimizado para apresentação 
à diretoria"
```

---

## **MÓDULO 7: CRIANDO SEU PRIMEIRO AGENTE DE IA (15 min)**

### **7.1 Conceito de Agente Especialista (5 min)**
**Explicação:** "É como contratar um especialista virtual que conhece profundamente seu negócio"

### **7.2 Criando um Agente de Atendimento (10 min)**
**Passo a Passo:**
```bash
claude agents create
```

**Configuração:**
```
Nome: assistente-vendas
Descrição: Especialista em atendimento e vendas da nossa empresa
Conhecimento: produtos.txt, precos.csv, faq.md
Personalidade: Profissional, empático, focado em conversão
```

**Teste ao Vivo:**
```
"@assistente-vendas, um cliente perguntou sobre prazo de entrega 
para São Paulo. Como devo responder?"
```

---

## **🎯 ENCERRAMENTO E PLANO DE AÇÃO (10 min)**

### **Recapitulação dos Aprendizados**
✅ Instalação e configuração
✅ Comandos essenciais
✅ Automação de tarefas
✅ Criação de ferramentas
✅ Integração com seu negócio

### **Desafio dos 7 Dias**
**Dia 1:** Instalar e criar primeiro arquivo
**Dia 2:** Automatizar uma tarefa repetitiva
**Dia 3:** Criar relatório automatizado
**Dia 4:** Conectar uma ferramenta (MCP)
**Dia 5:** Criar comando personalizado
**Dia 6:** Desenvolver mini-ferramenta
**Dia 7:** Criar agente especialista

### **Recursos de Apoio**
- Grupo no WhatsApp exclusivo
- Material de apoio em PDF
- Biblioteca de prompts
- Vídeos de referência
- Suporte por 30 dias

### **Call to Action Final**
"Quem vai começar a automatizar ainda hoje? 
Compartilhe no chat qual será sua primeira automação!"

---

## **📊 MATERIAIS DE APOIO**

### **Biblioteca de Prompts Prontos**

**1. E-commerce:**
```
"Analise reviews de produtos e identifique os 3 principais 
pontos de melhoria com sugestões específicas de ação"
```

**2. Consultoria:**
```
"Crie uma proposta comercial completa com escopo, cronograma, 
investimento e garantias para [tipo de serviço]"
```

**3. Marketing:**
```
"Desenvolva calendário de conteúdo para 30 dias com posts 
para Instagram, LinkedIn e blog sobre [tema]"
```

**4. Jurídico:**
```
"Organize documentos por data, tipo e relevância, criando 
índice searchable e resumo executivo de cada documento"
```

**5. Finanças:**
```
"Analise fluxo de caixa, identifique padrões de gastos e 
sugira 5 oportunidades de economia com impacto calculado"
```

### **Checklist de Implementação**

#### **Semana 1: Fundação**
- [ ] Instalar Claude Code
- [ ] Configurar ambiente
- [ ] Primeiro projeto teste
- [ ] Automatizar 1 tarefa

#### **Semana 2: Expansão**
- [ ] Conectar 2 ferramentas
- [ ] Criar 3 comandos personalizados
- [ ] Desenvolver 1 ferramenta
- [ ] Treinar equipe

#### **Semana 3: Otimização**
- [ ] Criar agente especialista
- [ ] Integrar com fluxo trabalho
- [ ] Medir resultados
- [ ] Documentar processos

#### **Semana 4: Escala**
- [ ] Expandir para outras áreas
- [ ] Criar biblioteca prompts
- [ ] Estabelecer métricas
- [ ] Planejar próximos passos

---

## **💰 CALCULADORA DE ROI**

### **Modelo de Cálculo:**
```
Horas economizadas/semana: _____ 
x Valor da hora: R$ _____
x 4 semanas: _____
= Economia mensal: R$ _____

Investimento Claude Code: R$ 100
ROI = (Economia - Investimento) / Investimento x 100
```

### **Exemplos Reais de ROI:**
- **Agência Marketing:** 40h/mês → R$ 8.000 economia
- **E-commerce:** 25h/mês → R$ 3.750 economia  
- **Consultoria:** 30h/mês → R$ 6.000 economia
- **Escritório:** 20h/mês → R$ 4.000 economia

---

## **🔥 BONUS: Scripts Prontos para Começar**

### **Script 1: Analisador de Vendas**
```javascript
// Salvar como: analisar-vendas.js
"Claude, crie um script que:
1. Leia arquivo CSV de vendas
2. Calcule métricas principais
3. Identifique tendências
4. Gere relatório visual
5. Envie por email"
```

### **Script 2: Gerador de Conteúdo**
```javascript
// Salvar como: gerar-conteudo.js
"Claude, desenvolva ferramenta que:
1. Receba tema do usuário
2. Pesquise informações relevantes
3. Crie 10 posts para redes sociais
4. Adicione hashtags relevantes
5. Salve em formato editável"
```

### **Script 3: Organizador de Arquivos**
```javascript
// Salvar como: organizar-arquivos.js
"Claude, crie sistema que:
1. Escaneie pasta de downloads
2. Organize por tipo e data
3. Renomeie com padrão lógico
4. Crie backup automático
5. Gere log de mudanças"
```

---

## **📚 LEITURAS E RECURSOS COMPLEMENTARES**

### **Documentação Essencial:**
- [Guia Oficial Claude Code](https://docs.claude.com/claude-code)
- [Biblioteca de MCP Servers](https://github.com/modelcontextprotocol)
- [Exemplos de Projetos](https://github.com/anthropic-cookbook)

### **Comunidades de Apoio:**
- Discord Claude Developers
- Reddit r/ClaudeAI
- Stack Overflow tag: claude-code

### **Próximos Passos:**
1. **Workshop Avançado:** Claude Code + APIs
2. **Masterclass:** Criando SaaS com Claude
3. **Bootcamp:** 30 dias de Automação

---

## **📝 NOTAS DO INSTRUTOR**

### **Dicas para Apresentação:**
- Use exemplos do dia a dia dos participantes
- Faça demonstrações ao vivo, não slides
- Permita erros - eles são oportunidades de aprendizado
- Celebre cada pequena vitória
- Mantenha linguagem simples e acessível

### **Momentos de Interação:**
- **Minuto 15:** Enquete sobre maiores dores
- **Minuto 30:** Primeira automação em grupo
- **Minuto 60:** Compartilhar resultados
- **Minuto 90:** Desafio em duplas
- **Minuto 110:** Apresentação de projetos

### **Material Necessário:**
- Computador com internet
- Projetor/TV grande
- Arquivos de exemplo (CSV, TXT)
- Backup de demonstrações gravadas
- Premiação simbólica para participação

---

## **🎯 MÉTRICAS DE SUCESSO DO WORKSHOP**

### **Objetivos Mensuráveis:**
- [ ] 100% dos participantes com Claude instalado
- [ ] 80% criaram primeira automação
- [ ] 70% identificaram uso para seu negócio
- [ ] 60% comprometidos com implementação
- [ ] 50% interessados em workshop avançado

### **Follow-up Pós-Workshop:**
- **24 horas:** Email com materiais e gravação
- **3 dias:** Check-in sobre implementação
- **7 dias:** Sessão tira-dúvidas online
- **15 dias:** Casos de sucesso e troubleshooting
- **30 dias:** Convite para comunidade avançada

---

## **🚀 CONCLUSÃO**

Este workshop foi desenvolvido para ser 100% prático e aplicável. Cada participante sai com:
- Claude Code funcionando
- Pelo menos 3 automações criadas
- Biblioteca de prompts
- Plano de implementação
- Suporte contínuo

**Lembre-se:** O objetivo não é formar programadores, mas capacitar empreendedores e profissionais a multiplicarem sua produtividade usando IA de forma prática e acessível.

**Mensagem Final:**
"Você não precisa entender como o motor do carro funciona para dirigir. 
Da mesma forma, não precisa ser programador para usar Claude Code. 
Precisa apenas saber para onde quer ir e dar as instruções certas."

---

*Workshop desenvolvido com base em casos reais de sucesso e metodologia hands-on.
Atualizado para Claude Sonnet 4.5 e últimas features de 2025.*
