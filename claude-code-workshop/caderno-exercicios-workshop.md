# 📘 CADERNO DE EXERCÍCIOS PRÁTICOS - Workshop Claude Code

## **EXERCÍCIOS MÓDULO 1: PRIMEIROS PASSOS**

### **Exercício 1.1: Seu Primeiro Comando**
**Objetivo:** Familiarizar-se com a interface do Claude Code

**Tarefa:**
```
claude
"Olá Claude! Me conte 3 coisas que você pode fazer para ajudar meu negócio"
```

**Resultado Esperado:**
- Claude responde com lista personalizada
- Você entende a interface básica
- Primeira interação bem-sucedida ✅

---

### **Exercício 1.2: Criando Seu Primeiro Arquivo**
**Objetivo:** Aprender a criar e manipular arquivos

**Tarefa:**
```
"Claude, crie um arquivo chamado ideias-automacao.txt com 10 ideias 
de como posso automatizar tarefas no meu trabalho"
```

**Verificação:**
- Arquivo criado no diretório atual
- Conteúdo relevante e aplicável
- Ideias específicas para seu contexto

---

## **EXERCÍCIOS MÓDULO 2: AUTOMAÇÃO BÁSICA**

### **Exercício 2.1: Organizador de Despesas**
**Cenário:** Você tem uma planilha bagunçada de despesas

**Arquivo de Entrada:** despesas.csv
```csv
data,descricao,valor,categoria
01/10/2025,Almoço,45.00,
02/10/2025,Gasolina,200.00,
03/10/2025,Internet,99.90,
```

**Comando:**
```
"Claude, organize o arquivo despesas.csv:
1. Preencha categorias vazias baseado na descrição
2. Ordene por data
3. Calcule total por categoria
4. Crie resumo mensal
5. Gere arquivo organizado"
```

**Entrega:**
- despesas_organizado.csv
- resumo_mensal.txt
- grafico_categorias.html

---

### **Exercício 2.2: Gerador de Orçamentos**
**Cenário:** Você precisa criar orçamentos personalizados rapidamente

**Comando:**
```
"Claude, crie um gerador de orçamentos que:
1. Pergunte dados do cliente
2. Liste serviços disponíveis
3. Calcule valores com desconto
4. Gere PDF profissional
5. Salve histórico"
```

**Teste Prático:**
- Execute o gerador
- Crie 3 orçamentos diferentes
- Verifique cálculos automáticos

---

## **EXERCÍCIOS MÓDULO 3: ANÁLISE DE DADOS**

### **Exercício 3.1: Análise de Vendas**
**Dados de Exemplo:** vendas_outubro.csv

**Comando Completo:**
```
"Claude, analise vendas_outubro.csv e me diga:
1. Top 5 produtos mais vendidos
2. Dia com maior faturamento
3. Ticket médio por cliente
4. Tendência de vendas (crescendo/caindo)
5. Previsão para próximo mês
6. 3 ações recomendadas"
```

**Perguntas de Reflexão:**
- Que insights você não tinha percebido?
- Como isso muda sua estratégia?
- Quanto tempo economizou?

---

### **Exercício 3.2: Análise de Concorrência**
**Objetivo:** Entender melhor seu mercado

**Comando:**
```
"Claude, pesquise sobre [nome do concorrente] e crie:
1. Tabela comparativa de preços
2. Análise de pontos fortes/fracos
3. Estratégias de diferenciação
4. Oportunidades identificadas"
```

**Aplique para 3 Concorrentes:**
1. Concorrente Principal: _______
2. Concorrente Secundário: _______
3. Concorrente Emergente: _______

---

## **EXERCÍCIOS MÓDULO 4: CRIAÇÃO DE CONTEÚDO**

### **Exercício 4.1: Campanha de Email Marketing**
**Briefing:** Lançamento de novo produto/serviço

**Comando Estruturado:**
```
"Claude, crie campanha de email para lançamento de [produto]:

Público-alvo: [descrever]
Tom de voz: [profissional/casual/entusiasmado]
Objetivo: [vendas/conscientização/engajamento]

Criar:
1. Email teaser (3 dias antes)
2. Email de lançamento
3. Email de benefícios
4. Email de urgência
5. Email de última chance

Incluir:
- Linhas de assunto com 60+ taxa de abertura
- CTAs persuasivos
- Storytelling envolvente"
```

**Métricas para Acompanhar:**
- Taxa de abertura
- Taxa de cliques
- Conversões

---

### **Exercício 4.2: Conteúdo para Redes Sociais**
**Desafio:** Criar conteúdo para 1 semana completa

**Comando:**
```
"Claude, crie calendário de conteúdo para próxima semana:

Plataformas: Instagram, LinkedIn, Facebook
Tema: [seu tema]
Objetivo: [engajamento/vendas/branding]

Para cada dia criar:
- Post principal com copy
- Stories (3 por dia)
- Hashtags relevantes
- Horário ideal de postagem
- Call to action"
```

**Organize em Tabela:**
| Dia | Plataforma | Tipo | Conteúdo | Horário | Hashtags |
|-----|------------|------|----------|---------|----------|
| Seg | Instagram  | Post | ...      | 19h     | #...     |

---

## **EXERCÍCIOS MÓDULO 5: FERRAMENTAS PERSONALIZADAS**

### **Exercício 5.1: Criando Comando de Relatório Diário**
**Objetivo:** Automatizar relatório que você faz todo dia

**Passo 1:** Criar pasta
```bash
mkdir -p .claude/commands
```

**Passo 2:** Criar arquivo `.claude/commands/relatorio.md`
```markdown
Gere relatório diário com:
1. Resumo de vendas de hoje
2. Comparação com ontem
3. Tarefas pendentes
4. Prioridades para amanhã
5. Alertas importantes
```

**Passo 3:** Usar comando
```
/relatorio
```

**Personalize para Seu Negócio:**
- Que informações são cruciais?
- Que análises você precisa?
- Que formato prefere?

---

### **Exercício 5.2: Assistente de Atendimento**
**Criar FAQ Inteligente:**

**Comando Base:**
```
"Claude, crie assistente que:
1. Responda perguntas frequentes
2. Colete dados do cliente
3. Agende reuniões
4. Envie materiais
5. Escalone quando necessário"
```

**Teste com 5 Cenários:**
1. Cliente pergunta sobre preços
2. Cliente tem problema técnico
3. Cliente quer agendar reunião
4. Cliente solicita reembolso
5. Cliente quer indicação

---

## **EXERCÍCIOS MÓDULO 6: INTEGRAÇÃO COM MCP**

### **Exercício 6.1: Conectando Google Drive**
**Instalação:**
```bash
claude mcp add gdrive -- npx @modelcontextprotocol/server-gdrive
```

**Comandos Práticos:**
```
"Claude, organize todos os documentos da pasta Projetos por:
1. Cliente
2. Data
3. Status (ativo/concluído)
4. Crie índice mestre"
```

---

### **Exercício 6.2: Automação com Planilhas**
**Conectar Planilhas Google:**
```
"Claude, monitore a planilha de vendas e:
1. Alerte quando meta diária não for atingida
2. Calcule comissões automaticamente
3. Gere relatório semanal
4. Identifique oportunidades de upsell"
```

---

## **EXERCÍCIOS MÓDULO 7: PROJETOS COMPLETOS**

### **Projeto 1: Sistema de Propostas Comerciais**
**Objetivo:** Criar sistema completo de geração de propostas

**Requisitos:**
```
1. Interface para inserir dados do cliente
2. Templates para diferentes serviços
3. Cálculo automático de valores
4. Descontos por volume
5. Prazo de validade automático
6. Geração de PDF
7. Envio por email
8. Registro em planilha
```

**Comando Inicial:**
```
"Claude, crie sistema completo de propostas comerciais 
com os requisitos acima. Use HTML para interface e 
JavaScript para lógica"
```

---

### **Projeto 2: Dashboard de Métricas**
**Objetivo:** Painel de controle visual do negócio

**Especificações:**
```
"Claude, crie dashboard interativo que:
1. Mostre vendas em tempo real
2. Compare com metas
3. Exiba gráficos de tendência
4. Calcule ROI de campanhas
5. Mostre ranking de produtos
6. Seja responsivo
7. Atualize automaticamente"
```

---

### **Projeto 3: Chatbot para Site**
**Objetivo:** Assistente virtual para seu site

**Desenvolvimento:**
```
"Claude, desenvolva chatbot que:
1. Cumprimente visitantes
2. Responda sobre produtos/serviços
3. Colete informações de contato
4. Agende demonstrações
5. Integre com WhatsApp
6. Salve conversas
7. Gere leads qualificados"
```

---

## **🎯 DESAFIOS BÔNUS**

### **Desafio 1: Economize 10 Horas**
**Meta:** Identificar e automatizar tarefas que somem 10h/semana

**Planilha de Controle:**
| Tarefa | Tempo Antes | Tempo Depois | Economia |
|--------|-------------|--------------|----------|
| Relatórios | 3h | 10min | 2h50min |
| Emails | 2h | 20min | 1h40min |
| ... | ... | ... | ... |
**Total:** _____ horas economizadas

---

### **Desafio 2: ROI de 1000%**
**Meta:** Gerar retorno 10x maior que investimento

**Cálculo:**
- Investimento: R$ 100/mês
- Meta de retorno: R$ 1.000/mês
- Como alcançar?
  - Economia de tempo: R$ ____
  - Novos clientes via automação: R$ ____
  - Redução de erros: R$ ____
  - Aumento de produtividade: R$ ____

---

### **Desafio 3: Crie e Venda uma Ferramenta**
**Meta:** Desenvolver ferramenta que outros pagariam para usar

**Ideias:**
1. Gerador de legendas para Instagram
2. Analisador de reviews de produtos
3. Criador de propostas comerciais
4. Organizador de documentos fiscais
5. Assistente de email marketing

**Passos:**
1. Identificar dor do mercado
2. Criar MVP com Claude
3. Testar com 5 pessoas
4. Refinar baseado em feedback
5. Lançar versão beta
6. Precificar e vender

---

## **📊 TABELA DE ACOMPANHAMENTO DE PROGRESSO**

### **Semana 1:**
- [ ] Instalação completa
- [ ] 10 comandos básicos executados
- [ ] 3 arquivos criados
- [ ] 1 automação implementada

### **Semana 2:**
- [ ] MCP configurado
- [ ] 5 comandos personalizados
- [ ] 1 projeto completo
- [ ] 20h de economia identificadas

### **Semana 3:**
- [ ] 3 ferramentas criadas
- [ ] 1 agente especialista
- [ ] Dashboard funcionando
- [ ] ROI calculado

### **Semana 4:**
- [ ] Sistema em produção
- [ ] Equipe treinada
- [ ] Processos documentados
- [ ] Próximos passos definidos

---

## **💡 DICAS DE OURO PARA CADA EXERCÍCIO**

### **Regra dos 3 Ps:**
1. **Preparação:** Tenha dados organizados
2. **Precisão:** Seja específico nos comandos
3. **Persistência:** Refine até ficar perfeito

### **Framework CRIAR:**
- **C**ontexto: Explique a situação
- **R**esultado: Descreva o que quer
- **I**nstruções: Dê passos claros
- **A**juste: Peça formato específico
- **R**evisão: Solicite verificação

### **Técnica do Funil:**
1. Comece com pedido amplo
2. Refine com mais detalhes
3. Ajuste formato e estilo
4. Polir resultado final

---

## **🚀 PRÓXIMOS PASSOS APÓS O WORKSHOP**

### **Dia 1-7: Fundação**
- Pratique exercícios básicos diariamente
- Crie primeira automação útil
- Compartilhe progresso no grupo

### **Dia 8-14: Expansão**
- Implemente 3 automações
- Conecte 1 ferramenta externa
- Meça tempo economizado

### **Dia 15-21: Especialização**
- Desenvolva ferramenta personalizada
- Crie agente para sua área
- Documente processos

### **Dia 22-30: Maestria**
- Integre completamente ao fluxo
- Treine outra pessoa
- Calcule ROI real

---

## **📝 NOTAS FINAIS**

**Lembre-se:**
- Cada exercício pode ser adaptado
- Comece simples, evolua gradualmente  
- Erros são oportunidades de aprendizado
- Celebre cada automação criada
- Compartilhe sucessos com a comunidade

**Suporte Contínuo:**
- Grupo WhatsApp: [link]
- Email suporte: [email]
- Calls semanais: Quintas 19h
- Material atualizado: [portal]

---

*"A melhor hora para plantar uma árvore foi 20 anos atrás. 
A segunda melhor hora é agora. 
Comece sua jornada de automação hoje!"*

---

**Caderno de Exercícios v2.0**
*Atualizado para Claude Sonnet 4.5 - Outubro 2025*
