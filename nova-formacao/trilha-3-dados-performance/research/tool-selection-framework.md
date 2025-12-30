# Framework de Seleção de Ferramentas - Trilha 3

**Filosofia:** Mostrar alternativas, explicar escolha, nunca forçar ferramenta.

---

## Princípio Central

> **"Não ensinamos ferramenta. Ensinamos a resolver problema. A ferramenta é só o veículo."**

### Estrutura de Apresentação (Cada Módulo)

```
1. O PROBLEMA que precisamos resolver
2. CRITÉRIOS de escolha para esse problema
3. ALTERNATIVAS disponíveis (comparativo honesto)
4. NOSSA ESCOLHA e POR QUÊ
5. QUANDO escolher diferente
```

---

# MÓDULO 1: Mapa de Dados

## O Problema
Documentar onde cada dado do negócio vive e qual decisão ele informa.

## Critérios de Escolha
| Critério | Peso | Por Quê |
|----------|------|---------|
| Facilidade de edição | Alto | Vai atualizar frequentemente |
| Compartilhável | Médio | Time precisa ver |
| Colaborativo | Médio | Mais de uma pessoa edita |
| Visual | Baixo | É documento, não dashboard |

## Alternativas

| Ferramenta | Facilidade | Compartilhável | Colaborativo | Quando Usar |
|------------|------------|----------------|--------------|-------------|
| **Google Sheets** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Padrão, todo mundo tem |
| **Notion** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Se já usa Notion no dia-a-dia |
| **Airtable** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Se quer relações entre dados |
| **Excel** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | Se empresa é 100% Microsoft |
| **Miro/FigJam** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Se quer visual (mapa mental) |

## Nossa Escolha: Google Sheets

### Por Que Sheets e Não Outro?

| Razão | Explicação |
|-------|------------|
| **Zero fricção** | 99% dos alunos já tem conta Google |
| **Colaboração nativa** | Múltiplas pessoas editam ao mesmo tempo |
| **Base para próximos módulos** | Looker Studio conecta direto |
| **Gratuito sempre** | Não depende de plano pago |
| **Mobile** | Edita no celular se precisar |

### Quando Escolher Diferente

| Se você... | Use... | Por quê |
|------------|--------|---------|
| Já tem tudo no Notion | Notion | Manter ecossistema |
| Empresa é Microsoft | Excel + SharePoint | Compatibilidade |
| Quer visual bonito | Miro | Apresentação para time |
| Precisa de relações complexas | Airtable | Banco de dados relacional |

---

# MÓDULO 2: Dashboard Automatizado

## O Problema
Visualizar 5-7 métricas em tempo real, com atualização automática.

## Critérios de Escolha
| Critério | Peso | Por Quê |
|----------|------|---------|
| Custo | Alto | ICP não quer pagar R$ 60/mês |
| Curva de aprendizado | Alto | ICP é iniciante técnico |
| Atualização automática | Alto | Não pode ser manual |
| Acesso mobile | Médio | Empresário olha no celular |
| Integrações | Médio | Precisa conectar fontes |

## Alternativas

| Ferramenta | Custo | Curva | Auto-update | Mobile | Integrações |
|------------|-------|-------|-------------|--------|-------------|
| **Looker Studio** | Grátis | 2-4h | ✅ | ✅ Web | 730+ |
| **Metabase** | Grátis* | 6-8h | ✅ | ✅ Web | 20+ |
| **Power BI** | R$ 60/mês | 20-40h | ✅ | ✅ App | 200+ |
| **Tableau** | R$ 400+/mês | 40h+ | ✅ | ✅ App | 100+ |
| **Google Sheets** | Grátis | 1h | 🟡 Manual | ✅ App | Via script |
| **Notion** | Grátis | 2h | 🟡 Limitado | ✅ App | Via API |

*Metabase é grátis mas precisa hospedar (Render, Railway = R$ 0-30/mês)

## Nossa Escolha: Looker Studio

### Por Que Looker Studio e Não Outro?

| Razão | Explicação |
|-------|------------|
| **100% gratuito** | Sem pegadinha, sem trial, sem limite |
| **Conecta com Google Sheets** | Já usamos no Módulo 1 |
| **Curva de 2-4 horas** | ICP consegue em uma tarde |
| **730+ conectores** | Google Analytics, Ads, BigQuery, MySQL, etc |
| **Compartilha por link** | Não precisa instalar nada |
| **Roda em qualquer OS** | Mac, Windows, Linux, Chromebook |

### Por Que NÃO Power BI?

| Objeção Comum | Nossa Resposta |
|---------------|----------------|
| "Power BI é o padrão do mercado" | Sim, para empresas com analista de BI. Para PME, é overkill. |
| "Tem mais recursos" | Você vai usar 5% dos recursos. Looker tem os 5% que importam. |
| "Minha empresa já tem licença" | Ótimo! Use Power BI então. O conceito é o mesmo. |
| "DAX é mais poderoso" | Você precisa de cálculos complexos ou de ver 5-7 métricas? |

### Quando Escolher Diferente

| Se você... | Use... | Por quê |
|------------|--------|---------|
| Empresa já paga Power BI | Power BI | Não pague duas ferramentas |
| Quer hospedar seus dados | Metabase | Controle total |
| Precisa de SQL avançado | Metabase | Melhor para queries complexas |
| Time é 100% Microsoft | Power BI | Integração nativa |
| Quer embed no seu sistema | Metabase | Mais flexível para devs |

### Comparativo Visual (Mostrar no Vídeo)

```
CENÁRIO: Dashboard com 5 métricas de vendas

LOOKER STUDIO:
- Setup: 30 minutos
- Custo: R$ 0
- Curva: Assisti 1 vídeo de 10 min
- Resultado: Dashboard funcionando

POWER BI:
- Setup: 2 horas (baixar, instalar, configurar)
- Custo: R$ 60/mês
- Curva: Precisa entender DAX básico
- Resultado: Dashboard funcionando (mais bonito, menos prático)

CONCLUSÃO: Para 5-7 métricas, Looker resolve em menos tempo e custo zero.
```

---

# MÓDULO 3: Alertas Inteligentes

## O Problema
Receber notificação automática quando métrica sair do esperado.

## Critérios de Escolha
| Critério | Peso | Por Quê |
|----------|------|---------|
| Notificação WhatsApp | Alto | Canal #1 do empresário brasileiro |
| Custo | Alto | ICP não quer pagar |
| Facilidade de configurar | Alto | ICP é iniciante |
| Confiabilidade | Alto | Não pode falhar |
| Flexibilidade de triggers | Médio | Diferentes tipos de alerta |

## Alternativas

| Ferramenta | WhatsApp | Custo | Facilidade | Confiável | Flexível |
|------------|----------|-------|------------|-----------|----------|
| **n8n** | ✅ Via API | Grátis* | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Make (Integromat)** | ✅ Via API | R$ 50+/mês | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Zapier** | ✅ Via API | R$ 100+/mês | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Power Automate** | ❌ | R$ 75/mês | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Metabase Alerts** | ❌ Email só | Grátis | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Google Apps Script** | ❌ | Grátis | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |

*n8n self-hosted é grátis. n8n cloud tem plano grátis limitado.

## Nossa Escolha: n8n

### Por Que n8n e Não Outro?

| Razão | Explicação |
|-------|------------|
| **Gratuito (self-hosted)** | Roda no Render/Railway de graça |
| **Open source** | Sem lock-in, sem pegadinha |
| **Visual (no-code)** | Arrastar e soltar, não precisa programar |
| **WhatsApp via Evolution/Z-API** | Integração real, não gambiarra |
| **Comunidade ativa** | Muitos templates prontos |
| **Mais flexível que Zapier** | Loops, condicionais, sub-workflows |

### Por Que NÃO Zapier?

| Zapier | n8n |
|--------|-----|
| R$ 100+/mês para uso real | Grátis (self-hosted) |
| Paga por "task" (execução) | Ilimitado |
| Mais simples | Mais flexível |
| Empresa americana (suporte em inglês) | Comunidade BR crescendo |

### Por Que NÃO Make (Integromat)?

| Make | n8n |
|------|-----|
| Melhor UX que n8n | Open source |
| R$ 50+/mês | Grátis |
| Paga por operação | Ilimitado |

**Resumo:** Make é mais bonito, n8n é mais barato e flexível.

### Quando Escolher Diferente

| Se você... | Use... | Por quê |
|------------|--------|---------|
| Não quer hospedar nada | Make ou Zapier | Managed service |
| Time já usa Zapier | Zapier | Manter ecossistema |
| Quer máxima simplicidade | Make | UX mais intuitiva |
| Empresa é Microsoft | Power Automate | Integração nativa |
| Só precisa email | Metabase Alerts | Mais simples |

### Conexão com WhatsApp (Detalhar no Curso)

| Opção | Custo | Facilidade | Oficial |
|-------|-------|------------|---------|
| **Evolution API** | Grátis (self-hosted) | ⭐⭐⭐ | Não oficial |
| **Z-API** | R$ 50-100/mês | ⭐⭐⭐⭐⭐ | Não oficial |
| **WhatsApp Business API** | R$ 200+/mês | ⭐⭐ | Oficial |
| **Twilio** | Pay-per-message | ⭐⭐⭐ | Via Twilio |

**Nossa escolha:** Evolution API (grátis) ou Z-API (pago mas mais fácil)

---

# MÓDULO 4: Analista de Dados com IA

## O Problema
Interpretar dados automaticamente e gerar insights acionáveis.

## Critérios de Escolha
| Critério | Peso | Por Quê |
|----------|------|---------|
| Qualidade de análise | Alto | Precisa ser útil, não genérico |
| Janela de contexto | Alto | Precisa colar tabelas grandes |
| Custo | Médio | ICP aceita pagar ~R$ 100/mês |
| Facilidade de uso | Alto | ICP é iniciante |
| Disponibilidade no Brasil | Alto | Precisa funcionar aqui |

## Alternativas

| IA | Qualidade Análise | Contexto | Custo | Brasil |
|----|-------------------|----------|-------|--------|
| **Claude** | ⭐⭐⭐⭐⭐ | 200K tokens | R$ 100/mês | ✅ |
| **ChatGPT (GPT-4)** | ⭐⭐⭐⭐ | 128K tokens | R$ 100/mês | ✅ |
| **ChatGPT (GPT-3.5)** | ⭐⭐⭐ | 16K tokens | Grátis | ✅ |
| **Gemini** | ⭐⭐⭐⭐ | 1M tokens | Grátis/Pago | ✅ |
| **Copilot** | ⭐⭐⭐ | Limitado | Grátis | ✅ |
| **Perplexity** | ⭐⭐⭐ | Médio | Grátis/Pago | ✅ |

## Nossa Escolha: Claude (com fallback ChatGPT)

### Por Que Claude e Não ChatGPT?

| Aspecto | Claude | ChatGPT |
|---------|--------|---------|
| **Análise técnica** | Superior | Bom |
| **Dados estruturados** | Excelente | Bom |
| **Viés de resposta** | Mais neutro | Tende a ser otimista |
| **Tabelas grandes** | 200K tokens | 128K tokens |
| **Seguir instruções** | Mais preciso | Às vezes "escorrega" |
| **Criatividade** | Bom | Superior |

**Para análise de dados de negócio:** Claude > ChatGPT

### Por Que Ter Fallback ChatGPT?

- Mais pessoas já conhecem ChatGPT
- Se Claude estiver fora, ChatGPT funciona
- Prompts funcionam em ambos (com ajustes)

### Quando Escolher Diferente

| Se você... | Use... | Por quê |
|------------|--------|---------|
| Não quer pagar nada | ChatGPT Free ou Gemini | Grátis |
| Tabelas ENORMES (1M+ linhas) | Gemini | Maior contexto |
| Já paga ChatGPT Plus | ChatGPT | Não pague duas vezes |
| Quer integrar com Microsoft | Copilot | Integração nativa |
| Precisa de pesquisa web junto | Perplexity | Busca + análise |

### Comparativo de Prompt (Mostrar no Vídeo)

```
MESMO PROMPT EM CLAUDE VS CHATGPT:

"Analise estes dados de vendas e me diga o que está errado:
[tabela com 500 linhas]"

CLAUDE:
- Identifica 3 anomalias específicas
- Sugere causas prováveis com percentuais
- Recomenda ações priorizadas
- Tom: direto, analítico

CHATGPT:
- Identifica 2-3 pontos gerais
- Sugere causas em tom positivo
- "Você está no caminho certo!"
- Tom: encorajador, menos específico

PARA ANÁLISE DE NEGÓCIO: Claude é mais útil.
```

---

# MÓDULO 5: Rotina de Decisão

## O Problema
Criar hábito de olhar dados todo dia e tomar decisões baseadas neles.

## Critérios de Escolha
| Critério | Peso | Por Quê |
|----------|------|---------|
| Facilidade de manter | Alto | Hábito precisa ser fácil |
| Integração com calendário | Alto | Bloquear tempo |
| Acesso rápido | Alto | Não pode demorar para abrir |
| Histórico | Médio | Ver decisões passadas |

## Alternativas

| Ferramenta | Manter | Calendário | Rápido | Histórico |
|------------|--------|------------|--------|-----------|
| **Notion** | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Google Sheets** | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Obsidian** | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Papel + Caneta** | ⭐⭐⭐⭐⭐ | ⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| **Todoist/TickTick** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |

## Nossa Escolha: Google Sheets (ou Notion)

### Por Quê?

| Razão | Explicação |
|-------|------------|
| **Já está usando** | Continuidade do Módulo 1 |
| **Zero ferramenta nova** | Menos fricção |
| **Histórico automático** | Todas as decisões ficam salvas |
| **Acessível de qualquer lugar** | Mobile, desktop |

### Quando Escolher Diferente

| Se você... | Use... | Por quê |
|------------|--------|---------|
| Já usa Notion no dia-a-dia | Notion | Manter ecossistema |
| Prefere escrever à mão | Papel + foto | Funciona igual |
| Quer lembretes automáticos | Todoist | Melhor para hábitos |
| Time usa Slack | Slack + bot | Onde já estão |

---

# Resumo: Stack Recomendada vs Alternativas

## Stack Principal (Ensinada em Vídeo)

| Módulo | Ferramenta | Custo |
|--------|------------|-------|
| 1. Mapa de Dados | Google Sheets | Grátis |
| 2. Dashboard | Looker Studio | Grátis |
| 3. Alertas | n8n + Evolution API | Grátis |
| 4. IA | Claude | ~R$ 100/mês |
| 5. Rotina | Google Sheets | Grátis |

**Custo total:** ~R$ 100/mês (só a IA)

## Alternativas por Perfil

### Perfil "Zero Custo"
| Módulo | Alternativa |
|--------|-------------|
| 4. IA | ChatGPT Free ou Gemini |

**Custo total:** R$ 0

### Perfil "Já Uso Microsoft"
| Módulo | Alternativa |
|--------|-------------|
| 1 | Excel + SharePoint |
| 2 | Power BI |
| 3 | Power Automate |
| 4 | Copilot |
| 5 | Excel |

### Perfil "Quero Máximo Controle"
| Módulo | Alternativa |
|--------|-------------|
| 1 | Notion ou Airtable |
| 2 | Metabase (self-hosted) |
| 3 | n8n (self-hosted) |
| 4 | Claude API |
| 5 | Obsidian |

---

# Template para Cada Vídeo

## Estrutura de Apresentação de Ferramenta (5 min por módulo)

```markdown
## Escolhendo a Ferramenta Certa

### 1. O que precisamos resolver?
[Problema em 1 frase]

### 2. O que importa para escolher?
- Critério 1: [Por quê]
- Critério 2: [Por quê]
- Critério 3: [Por quê]

### 3. Opções no mercado
| Ferramenta | Critério 1 | Critério 2 | Critério 3 |
|------------|-----------|-----------|-----------|
| Opção A    | ⭐⭐⭐     | ⭐⭐⭐⭐⭐  | ⭐⭐       |
| Opção B    | ⭐⭐⭐⭐⭐  | ⭐⭐⭐     | ⭐⭐⭐⭐   |
| Opção C    | ⭐⭐       | ⭐⭐⭐⭐   | ⭐⭐⭐⭐⭐ |

### 4. Nossa escolha: [Ferramenta X]
**Por quê?**
- Razão 1
- Razão 2
- Razão 3

### 5. Quando escolher diferente?
- Se [situação A] → Use [alternativa]
- Se [situação B] → Use [alternativa]

### 6. Vamos implementar!
[Começa tutorial prático]
```

---

**Documento elaborado por:** Course Architect Agent
**Para:** Definição de stack tecnológica Trilha 3
**Versão:** 1.0
