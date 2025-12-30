# Recomendações de Melhoria: Trilha 3 - Dados e Performance

**Data:** 2025-12-29
**Baseado em:** Pesquisa de mercado + Análise da ementa atual

---

## Resumo Executivo

A Trilha 3 está **bem posicionada** no mercado. A estrutura é sólida e os diferenciais são claros. As recomendações abaixo são **melhorias incrementais** para aumentar competitividade, não mudanças estruturais.

| Tipo | Quantidade |
|------|------------|
| 🔴 Crítico (deve mudar) | 2 |
| 🟡 Importante (deveria mudar) | 5 |
| 🟢 Desejável (poderia mudar) | 4 |

---

# 🔴 MUDANÇAS CRÍTICAS (Deve Fazer)

## 1. Definir Stack Tecnológica Única

### Problema Atual
A ementa menciona várias ferramentas de forma vaga:
- "Google Sheets, Notion, Supabase + Vibe Coding"
- "Metabase, Looker Studio, Sheets"
- "n8n, Zapier, ou script simples"

### Por Que É Crítico
- ICP é **iniciante técnico** → Escolha gera paralisia
- Concorrentes ensinam UMA ferramenta → Foco gera domínio
- "Ou isso ou aquilo" = aluno não faz nenhum

### Recomendação
Definir **stack canônica** (pode ter alternativas, mas com hierarquia clara):

```
STACK PRINCIPAL (o que ensinamos em vídeo):
├── Banco de Dados → Google Sheets (já conhece) ou Supabase (mais power)
├── Coleta Automática → n8n (gratuito, visual)
├── Dashboard → Looker Studio (gratuito Google) OU Metabase (self-hosted)
└── IA → Claude (melhor para análise técnica) com fallback ChatGPT

ALTERNATIVAS (mencionadas, não ensinadas):
├── Banco → Notion (simples), Airtable (middle)
├── Automação → Make (pago), Zapier (caro)
└── Dashboard → Power BI (se já tem licença)
```

### Mudança na Ementa
**Módulo 2, linha 233:**
```diff
- | **4. Ferramentas simples** | 5 min | Google Sheets, Notion, Supabase + Vibe Coding |
+ | **4. Ferramentas (Stack Lendária)** | 5 min | Google Sheets → n8n → Looker Studio (100% gratuito) |
```

---

## 2. Adicionar Tutorial Prático de Alerta via WhatsApp

### Problema Atual
Módulo 3 menciona "conectar ao WhatsApp/Slack" mas não ensina como.

### Por Que É Crítico
- WhatsApp é o canal #1 do empresário brasileiro
- É o diferencial mais **tangível** da trilha
- Sem isso, o alerta é "mais um email que ninguém lê"

### Recomendação
Adicionar **mini-tutorial** (15 min) de:
1. Criar grupo WhatsApp "Alertas do Negócio"
2. Conectar n8n → WhatsApp via Evolution API ou Z-API
3. Configurar template de mensagem com emojis de status

### Mudança na Ementa
**Módulo 3, Conteúdo (nova etapa):**
```diff
| **4. Configurando alertas** | 5 min | n8n, Zapier, ou script simples |
+ | **4b. Conectando WhatsApp** | 15 min | n8n + Evolution API/Z-API (tutorial passo-a-passo) |
```

**Ajuste de tempo:** Reduzir Build Sprint de 45 para 30 min.

---

# 🟡 MUDANÇAS IMPORTANTES (Deveria Fazer)

## 3. Especificar Claude como IA Padrão para Análise

### Problema Atual
Módulo 4 usa prompts genéricos sem especificar qual IA.

### Por Que É Importante
- Pesquisa Domo: "IA para análise técnica" é diferente de "IA para criação"
- Claude é **superior** para análise de dados e documentos longos
- ChatGPT é melhor para criação de conteúdo (não é o caso aqui)

### Recomendação
```diff
- Voce e meu analista de dados de negocio.
+ Voce e meu analista de dados de negocio (use Claude para melhor resultado).
+
+ POR QUE CLAUDE:
+ - Melhor em análise técnica e dados estruturados
+ - Janela de contexto maior (pode colar tabelas grandes)
+ - Menos "viés positivo" (ChatGPT tende a ser otimista demais)
+
+ FALLBACK: ChatGPT funciona, mas reduzir tamanho dos dados colados.
```

---

## 4. Adicionar Seção "Por Que Não Power BI?"

### Problema Atual
A ementa não endereça a objeção mais comum: "Por que não usar Power BI que é 'o padrão'?"

### Por Que É Importante
- 80% dos cursos de BI ensinam Power BI
- Empresário pode achar que está "aprendendo a ferramenta errada"
- Endereçar objeção = aumentar confiança na compra

### Recomendação
Adicionar box no **início do Módulo 2**:

```markdown
> **"Mas e o Power BI?"**
>
> Power BI é excelente — para empresas com analista de BI dedicado.
>
> | Power BI | Stack Lendária |
> |----------|----------------|
> | Licença R$ 60/mês/usuário | 100% gratuito |
> | Requer Windows | Roda no navegador |
> | Curva de aprendizado alta | Curva de 90 minutos |
> | Ótimo para dashboards complexos | Perfeito para 5-7 métricas |
>
> Se você já tem Power BI e alguém que sabe usar: ótimo!
> Se não tem: não precisa. O que ensinamos aqui resolve.
```

---

## 5. Customizar Métricas por Tipo de Negócio

### Problema Atual
As "7 Métricas Universais" são genéricas. Funcionam, mas não são específicas.

### Por Que É Importante
- SaaS tem métricas diferentes de e-commerce
- Serviços B2B diferente de varejo
- Customização = "isso é pra mim"

### Recomendação
Adicionar **variações** após as 7 universais:

```markdown
### Métricas por Modelo de Negócio

| Modelo | Trocar Por | Adicionar |
|--------|------------|-----------|
| **SaaS/Recorrência** | - | MRR, ARR, LTV |
| **E-commerce** | NPS → Taxa de Recompra | CAC, ROAS |
| **Serviços B2B** | Leads → Propostas | Ciclo de Venda |
| **Infoproduto** | Churn → Taxa de Reembolso | Custo de Aquisição |
| **Varejo Físico** | - | Ticket por m², Giro de Estoque |

> **Dica:** Use o Prompt de Definição de Métricas para calibrar para seu negócio específico.
```

---

## 6. Adicionar "Casos de Sucesso" ou Exemplos Concretos

### Problema Atual
A ementa tem templates e checklists, mas poucos exemplos reais.

### Por Que É Importante
- "Antes/Depois" gera identificação
- Concorrentes têm case studies (mesmo inventados)
- Tangibiliza a promessa

### Recomendação
Adicionar **3 mini-cases** no início da ementa:

```markdown
## Exemplos de Transformação

### Case 1: Agência de Marketing Digital
- **Antes:** 4h/semana juntando dados de clientes manualmente
- **Depois:** Dashboard atualiza sozinho, alerta quando cliente vai cancelar
- **Resultado:** 80% menos tempo + 3 clientes retidos (R$ 15K/mês)

### Case 2: E-commerce de Moda
- **Antes:** Descobria produto parado 30 dias depois
- **Depois:** Alerta no dia 7 de estoque parado
- **Resultado:** R$ 50K liberados em capital de giro

### Case 3: Consultoria B2B
- **Antes:** Proposta ficava "parada" sem follow-up
- **Depois:** Alerta se proposta > 5 dias sem resposta
- **Resultado:** +25% taxa de fechamento
```

---

## 7. Criar "Kit de Sobrevivência" para Quem Não Termina

### Problema Atual
Se aluno não completar todos os 5 módulos, não tem nada.

### Por Que É Importante
- Taxa de conclusão típica: 30-50%
- Quem faz só Módulo 1-2 ainda deveria ter valor
- Reduz frustração e aumenta NPS

### Recomendação
Adicionar **entregável mínimo viável** por módulo:

```markdown
## Entregável Mínimo por Módulo

| Módulo | Se fizer TUDO | Se fizer SÓ O MÍNIMO |
|--------|---------------|---------------------|
| 1 | Mapa de Dados completo | Lista de 5 fontes de dados |
| 2 | Dashboard 7 métricas | Planilha com 3 métricas |
| 3 | 5 alertas configurados | 1 alerta no email |
| 4 | 4 prompts calibrados | 1 prompt genérico funcionando |
| 5 | Rotina de 15 min | Bloco de 15 min no calendário |

> **Regra:** Mesmo o mínimo é melhor que zero. Melhor 1 alerta funcionando do que 5 planejados.
```

---

# 🟢 MUDANÇAS DESEJÁVEIS (Poderia Fazer)

## 8. Adicionar ROI Calculator Interativo

### Problema Atual
A tabela de "Impacto no DRE" é estática.

### Por Que É Desejável
- Empresário quer saber "quanto isso me dá?"
- Calculator gera engajamento e compartilhamento
- Prova o valor antes de começar

### Recomendação
Criar calculadora simples (Google Sheets ou Notion):

```
INPUTS:
- Faturamento mensal: R$ ___
- Horas/semana juntando dados: ___
- Quanto custa 1 decisão errada: R$ ___

OUTPUTS:
- Economia de tempo: ___ h/mês (valor: R$ ___)
- Redução de decisões erradas: R$ ___
- ROI da trilha: ___x em 30 dias
```

---

## 9. Adicionar Seção de "Armadilhas Comuns"

### Problema Atual
A ementa ensina o que fazer, não o que evitar.

### Por Que É Desejável
- Empresário vai cometer erros previsíveis
- Antecipar erros = valor percebido
- Reduz frustração e pedido de suporte

### Recomendação
Adicionar **box de armadilhas** por módulo:

```markdown
### ⚠️ Armadilhas do Módulo 2

| Armadilha | Por Que Acontece | Como Evitar |
|-----------|------------------|-------------|
| Dashboard com 20 métricas | "Quanto mais melhor" | Máximo 7, deletar resto |
| Só métricas de vaidade | Likes, views, followers | Focar em R$ e conversão |
| Dashboard que ninguém olha | Bonito mas inútil | Colocar na rotina diária |
| Dados desatualizados | Esqueceu de automatizar | Começar com 2 fontes automáticas |
```

---

## 10. Adicionar Certificado + Entregável

### Problema Atual
A ementa critica certificados ("Você não tem um certificado. Você tem um sistema rodando.") mas muitos alunos querem certificado para LinkedIn/RH.

### Por Que É Desejável
- Não custa nada oferecer
- Diferencial para funcionários (que precisa provar para chefe)
- Aumenta valor percebido

### Recomendação
Oferecer **ambos**:

```markdown
## Ao Final da Trilha, Você Terá:

1. **5 Entregáveis Funcionando** (o que realmente importa)
2. **Certificado Academia Lendária** (para seu LinkedIn e RH)

> A diferença? Concorrentes dão certificado de que você ASSISTIU.
> Nós damos certificado de que você IMPLEMENTOU.
> (Só libera certificado quem submete os 5 entregáveis)
```

---

## 11. Adicionar Comunidade/Suporte

### Problema Atual
Não menciona suporte ou comunidade.

### Por Que É Desejável
- Empresário precisa de ajuda na implementação
- Comunidade gera retenção e upsell
- É expectativa padrão de mercado

### Recomendação
```markdown
## Suporte e Comunidade

| Recurso | O Que É |
|---------|---------|
| **Comunidade WhatsApp** | Grupo com outros empresários da trilha |
| **Plantão de Dúvidas** | Semanal, 30 min, tira-dúvidas ao vivo |
| **Templates Compartilhados** | Dashboards e alertas de outros alunos |

> Acesso por 12 meses após matrícula.
```

---

# Resumo de Mudanças na Ementa

## Mudanças por Módulo

| Módulo | Mudança |
|--------|---------|
| **Geral** | Adicionar Stack Lendária, Cases, ROI Calculator |
| **1** | Mínimo viável, armadilhas |
| **2** | "Por que não Power BI?", métricas por negócio |
| **3** | Tutorial WhatsApp (15 min), armadilhas |
| **4** | Especificar Claude, armadilhas |
| **5** | Mínimo viável, armadilhas |
| **Final** | Certificado + Entregável, Comunidade |

## Impacto em Duração

| Atual | Proposto | Delta |
|-------|----------|-------|
| 7.5h (5 x 90 min) | ~8h | +30 min |

A adição do tutorial de WhatsApp (15 min) e pequenos ajustes não mudam significativamente a duração.

---

# Próximos Passos

1. **Validar prioridades** com stakeholder (quais implementar primeiro?)
2. **Atualizar ementa** com mudanças aprovadas
3. **Criar assets adicionais** (ROI calculator, cases, templates de armadilhas)
4. **Testar stack** (n8n → WhatsApp funciona mesmo?)

---

**Documento elaborado por:** Course Architect Agent
**Baseado em:** market-analysis.md, content-gaps.md, differentiation.md
**Versão:** 1.0
