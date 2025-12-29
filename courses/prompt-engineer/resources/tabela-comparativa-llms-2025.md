# Tabela Comparativa de LLMs - Outubro 2025

**⚠️ AVISO PEDAGÓGICO IMPORTANTE**

> **Rafael, leia isso com atenção:**
>
> Esta tabela está atualizada para **outubro de 2025**. Mas olha só...
>
> **No mundo de IA, isso aqui muda RÁPIDO.**
>
> Tipo: semana que vem pode lançar um modelo novo. Mês que vem os preços podem cair pela metade (já caíram 90% em 2024-2025). Ano que vem pode surgir um modelo que ninguém imaginava.
>
> **Então por que você tá aprendendo isso?**
>
> Porque **a LÓGICA é a mesma**:
> - Você sempre vai precisar escolher modelo certo pra tarefa certa
> - Você sempre vai precisar calcular custo × performance
> - Você sempre vai precisar justificar escolha pro cliente
>
> **O que muda:** Nomes dos modelos, preços, números
>
> **O que NÃO muda:** Como você pensa, como você decide, como você precifica
>
> Use esta tabela como REFERÊNCIA de raciocínio. Quando você for aplicar isso com clientes reais, **SEMPRE confira preços atualizados** em:
> - OpenRouter: https://openrouter.ai/models
> - Anthropic: https://docs.anthropic.com/pricing
> - OpenAI: https://openai.com/api/pricing
> - Google: https://ai.google.dev/pricing
>
> **Simples assim.**

---

## 📊 TABELA COMPLETA - MODELOS MAIS USADOS (OUT 2025)

### Legenda de Uso
- 🎯 **Executivo:** Tarefas críticas, zero margem de erro (agendamentos, dados sensíveis)
- 💼 **Produção:** Uso geral confiável, bom custo-benefício
- ⚡ **Alto Volume:** Milhares de interações/dia, custo baixo prioritário
- 🎨 **Criativo:** Geração de conteúdo, brainstorming, rascunhos
- 🔬 **Código:** Desenvolvimento, debugging, code review

---

| Modelo | Provider | Input ($/M) | Output ($/M) | Custo/Interação* | Custo/Interação (BRL) | Uso Recomendado | Performance |
|--------|----------|-------------|--------------|------------------|----------------------|-----------------|-------------|
| **GPT-5** | OpenAI | $1.25 | $10.00 | $0.0056 | R$ 0.028 | 🎯 Executivo crítico | ⭐⭐⭐⭐⭐ |
| **GPT-5 mini** | OpenAI | $0.25 | $2.00 | $0.0011 | R$ 0.0055 | 💼 Produção geral | ⭐⭐⭐⭐ |
| **GPT-5 nano** | OpenAI | $0.05 | $0.40 | $0.0002 | R$ 0.001 | ⚡ Alto volume | ⭐⭐⭐ |
| **Claude Sonnet 4.5** | Anthropic | $3.00 | $15.00 | $0.009 | R$ 0.045 | 🎯 Executivo premium | ⭐⭐⭐⭐⭐ |
| **Claude Haiku 4.5** | Anthropic | $1.00 | $5.00 | $0.003 | R$ 0.015 | 💼 Produção eficiente | ⭐⭐⭐⭐ |
| **Gemini 2.0 Flash** | Google | $0.10 | $0.40 | $0.00025 | R$ 0.00125 | ⚡ Alto volume rápido | ⭐⭐⭐⭐ |
| **Gemini 2.5 Pro** | Google | $2.50 | $10.00 | $0.00625 | R$ 0.031 | 🎨 Criativo avançado | ⭐⭐⭐⭐⭐ |
| **DeepSeek V3** | DeepSeek | $0.028 | $0.112 | $0.00007 | R$ 0.00035 | ⚡ Ultra volume | ⭐⭐⭐⭐ |
| **DeepSeek V3.2 Exp** | DeepSeek | $0.028 | $0.112 | $0.00007 | R$ 0.00035 | ⚡ Experimental | ⭐⭐⭐⭐ |
| **Mistral Medium 3** | Mistral | $0.40 | $2.00 | $0.0012 | R$ 0.006 | 💼 Produção balanceada | ⭐⭐⭐⭐ |
| **Mistral Small 3** | Mistral | $0.10 | $0.30 | $0.0002 | R$ 0.001 | ⚡ Volume eficiente | ⭐⭐⭐ |
| **Codestral** | Mistral | $0.30 | $0.90 | $0.0006 | R$ 0.003 | 🔬 Código especializado | ⭐⭐⭐⭐ |
| **Llama 4 Maverick** | Meta | Grátis** | Grátis** | $0.00 | R$ 0.00 | 🎨 Experimental/Testes | ⭐⭐⭐ |
| **Qwen 3 (80B/3B)*** | Alibaba | $0.20 | $0.60 | $0.0004 | R$ 0.002 | 💼 Open source chinês | ⭐⭐⭐⭐ |

\* **Custo por interação:** Assume 500 tokens input + 500 tokens output = 1000 tokens total (interação média)
\** **Grátis:** Modelos open-source podem ser rodados localmente (custo = infraestrutura própria)
\*** **Qwen:** Modelo MoE (Mixture of Experts) - 80B parâmetros, apenas 3B ativos por vez

**Taxa de conversão:** $1 USD = R$ 5,00 BRL (outubro 2025)

---

## 💰 CÁLCULO DE CUSTO MENSAL POR VOLUME

### Cenário 1: E-commerce (5.000 interações/mês)

| Modelo | Custo Mensal (USD) | Custo Mensal (BRL) | Economia vs GPT-5 |
|--------|-------------------|-------------------|-------------------|
| GPT-5 | $28.00 | R$ 140.00 | - |
| GPT-5 mini | $5.50 | R$ 27.50 | 80% |
| Claude Haiku 4.5 | $15.00 | R$ 75.00 | 46% |
| Gemini 2.0 Flash | $1.25 | R$ 6.25 | 96% |
| DeepSeek V3 | $0.35 | R$ 1.75 | 99% |
| Mistral Medium 3 | $6.00 | R$ 30.00 | 79% |

**Recomendação:** Gemini 2.0 Flash ou DeepSeek V3 (tarefas simples), Mistral Medium 3 (equilíbrio)

---

### Cenário 2: Agente de Agendamento (1.000 interações/mês - PRECISÃO CRÍTICA)

| Modelo | Custo Mensal (USD) | Custo Mensal (BRL) | Confiabilidade |
|--------|-------------------|-------------------|----------------|
| GPT-5 | $5.60 | R$ 28.00 | 99.5% ✅ |
| Claude Sonnet 4.5 | $9.00 | R$ 45.00 | 99.8% ✅ |
| Claude Haiku 4.5 | $3.00 | R$ 15.00 | 98.5% ✅ |
| Gemini 2.0 Flash | $0.25 | R$ 1.25 | 92.0% ⚠️ |
| DeepSeek V3 | $0.07 | R$ 0.35 | 95.0% ⚠️ |

**Recomendação:** Claude Haiku 4.5 (melhor custo-benefício pra precisão) ou GPT-5 mini

---

### Cenário 3: Atendimento WhatsApp (10.000 interações/mês)

| Modelo | Custo Mensal (USD) | Custo Mensal (BRL) | Velocidade |
|--------|-------------------|-------------------|------------|
| GPT-5 | $56.00 | R$ 280.00 | 3-5s |
| Gemini 2.0 Flash | $2.50 | R$ 12.50 | <1s ⚡ |
| DeepSeek V3 | $0.70 | R$ 3.50 | 1-2s ⚡ |
| Mistral Small 3 | $2.00 | R$ 10.00 | 1-3s |

**Recomendação:** Gemini 2.0 Flash (velocidade + custo) ou DeepSeek V3 (custo mínimo)

---

### Cenário 4: Sistema Híbrido (10.000 interações/mês)

**Estratégia:** 80% triagem simples (modelo barato) + 20% casos complexos (modelo premium)

| Combinação | Custo Mensal (USD) | Custo Mensal (BRL) |
|------------|-------------------|-------------------|
| Gemini Flash (80%) + GPT-5 (20%) | $13.20 | R$ 66.00 |
| DeepSeek (80%) + Claude Haiku (20%) | $6.56 | R$ 32.80 |
| Mistral Small (80%) + Claude Sonnet (20%) | $34.00 | R$ 170.00 |

**Recomendação:** DeepSeek V3 (triagem) + Claude Haiku 4.5 (complexos) = melhor ROI

---

## 🎯 MATRIZ DE DECISÃO RÁPIDA

### Por Tipo de Tarefa

| Tipo de Tarefa | Modelo Recomendado | Justificativa |
|----------------|-------------------|---------------|
| **Agendamento/Calendário** | Claude Haiku 4.5 | Precisão alta, segue instruções à risca |
| **Atendimento Simples** | Gemini 2.0 Flash | Velocidade + custo ultra baixo |
| **Análise de Dados** | GPT-5 mini | Raciocínio lógico confiável |
| **Geração de Código** | Codestral ou GPT-5 | Especialização em código |
| **Brainstorming** | Gemini 2.5 Pro | Criatividade alta |
| **Sumarização** | DeepSeek V3 | Custo baixíssimo, boa qualidade |
| **Tradução** | Mistral Medium 3 | Multilingual forte |
| **FAQ Básico** | DeepSeek V3 ou Mistral Small 3 | Ultra barato, suficiente |

---

### Por Volume Mensal

| Volume/Mês | 1ª Escolha | 2ª Escolha | 3ª Escolha |
|------------|-----------|-----------|-----------|
| **< 1.000** | GPT-5 mini | Claude Haiku 4.5 | Mistral Medium 3 |
| **1.000 - 5.000** | Claude Haiku 4.5 | Gemini 2.0 Flash | Mistral Medium 3 |
| **5.000 - 20.000** | Gemini 2.0 Flash | DeepSeek V3 | Mistral Small 3 |
| **> 20.000** | DeepSeek V3 | Gemini 2.0 Flash | GPT-5 nano |

---

### Por Budget Mensal

| Budget (BRL) | Volume Máximo | Modelo Recomendado |
|-------------|--------------|-------------------|
| **< R$ 50** | ~1.000 msgs | Claude Haiku 4.5 ou GPT-5 mini |
| **R$ 50-200** | ~5.000 msgs | Gemini 2.0 Flash ou Mistral Medium 3 |
| **R$ 200-500** | ~20.000 msgs | Gemini 2.0 Flash (alta velocidade) |
| **> R$ 500** | >30.000 msgs | DeepSeek V3 (custo imbatível) |

---

## 🔄 RECURSOS ESPECIAIS POR MODELO

### Cache/Prompt Caching (Economia 50-90%)

| Modelo | Cache Disponível? | Economia | Ideal Para |
|--------|------------------|----------|------------|
| GPT-5 | ✅ Sim (90%) | Até 90% | Prompts longos repetitivos |
| Claude Sonnet 4.5 | ✅ Sim (90%) | Até 90% | System prompts grandes |
| Gemini 2.0 | ✅ Sim (contexto 1M) | Variável | Documentos grandes |
| DeepSeek V3 | ✅ Sim (90%) | Até 90% | Alto volume com contexto |

**Como funciona:** Tokens do system prompt/contexto que se repetem custam 90% menos após primeira chamada.

---

### Context Window (Tamanho Máximo)

| Modelo | Context Window | Ideal Para |
|--------|---------------|------------|
| Gemini 2.0 Flash | 1.000.000 tokens | Análise de documentos massivos |
| Claude Sonnet 4.5 | 200.000 tokens | Contratos, livros, relatórios |
| GPT-5 | 128.000 tokens | Uso geral confiável |
| DeepSeek V3 | 64.000 tokens | Uso padrão |
| Mistral Medium 3 | 32.000 tokens | Conversas normais |

---

### Multimodalidade (Texto + Imagem + Áudio)

| Modelo | Texto | Imagem | Áudio | Vídeo |
|--------|-------|--------|-------|-------|
| Gemini 2.5 Pro | ✅ | ✅ | ✅ | ✅ |
| GPT-5 | ✅ | ✅ | ✅ | ❌ |
| Claude Sonnet 4.5 | ✅ | ✅ | ❌ | ❌ |
| DeepSeek V3 | ✅ | ❌ | ❌ | ❌ |
| Mistral | ✅ | ⚠️ (limitado) | ❌ | ❌ |

---

## 💡 CASOS DE USO REAIS COM PRECIFICAÇÃO

### Caso 1: Agente de Confirmação de Consultas (Clínica Médica)

**Requisitos:**
- 2.000 confirmações/mês
- ZERO margem de erro (dados sensíveis de saúde)
- Integração WhatsApp

**Escolha:** Claude Haiku 4.5
- Custo API: 2.000 × R$ 0.015 = R$ 30/mês
- n8n: R$ 100/mês
- Uazapi: R$ 27/mês
- **Custo total:** R$ 157/mês

**Precificação cliente:**
- Setup: R$ 5.000
- Mensal: R$ 500 (markup 3.2x)
- **Lucro ano 1:** R$ 9.116

---

### Caso 2: FAQ Automático (E-commerce)

**Requisitos:**
- 15.000 perguntas/mês
- Respostas rápidas (<2s)
- Custo baixo prioritário

**Escolha:** Gemini 2.0 Flash
- Custo API: 15.000 × R$ 0.00125 = R$ 18.75/mês
- n8n Pro: R$ 250/mês (>1000 exec/dia)
- Uazapi Pro: R$ 97/mês
- **Custo total:** R$ 365.75/mês

**Precificação cliente:**
- Setup: R$ 4.500
- Mensal: R$ 900 (markup 2.5x)
- **Lucro ano 1:** R$ 10.909

---

### Caso 3: Agente Híbrido de Vendas

**Requisitos:**
- 8.000 triagens simples/mês (FAQ, dúvidas básicas)
- 2.000 negociações complexas/mês (propostas, objeções)
- Integração CRM

**Escolha:** DeepSeek V3 (triagem) + GPT-5 mini (complexo)
- DeepSeek (8.000): 8.000 × R$ 0.00035 = R$ 2.80/mês
- GPT-5 mini (2.000): 2.000 × R$ 0.0055 = R$ 11.00/mês
- n8n Pro: R$ 250/mês
- Uazapi Pro: R$ 97/mês
- **Custo total:** R$ 360.80/mês

**Precificação cliente:**
- Setup: R$ 8.000 (complexidade híbrida)
- Mensal: R$ 1.500 (markup 4.2x)
- **Lucro ano 1:** R$ 21.670

---

## ⚠️ ARMADILHAS COMUNS

### ❌ Erro 1: Escolher por Preço Sem Analisar Requisito

**Errado:** "Vou usar DeepSeek em tudo porque é mais barato"

**Problema:** Cliente médico precisa ZERO erro. DeepSeek tem 95% de precisão, Claude Haiku tem 98.5%.

**Resultado:** 5% de 2.000 confirmações = 100 erros/mês = Cliente cancela contrato.

**Certo:** "Vou usar Claude Haiku porque requisito é PRECISÃO, não custo."

---

### ❌ Erro 2: Não Testar Antes de Prometer

**Errado:** "Vou usar Gemini porque a tabela diz que é rápido"

**Problema:** No caso específico do cliente (integração complexa com CRM legado), Gemini trava 15% das vezes.

**Resultado:** Sistema instável, cliente insatisfeito.

**Certo:** "Vou testar Gemini + Claude + GPT-5 mini com dados REAIS do cliente antes de decidir."

---

### ❌ Erro 3: Esquecer Custo de Infraestrutura

**Errado:** "API custa R$ 50/mês, vou cobrar R$ 150/mês"

**Problema:** Esqueceu n8n (R$ 100), Uazapi (R$ 27), buffer pra picos = Custo real R$ 200/mês.

**Resultado:** Prejuízo de R$ 50/mês.

**Certo:** "Custo API + infra = R$ 177. Markup 2.5x + buffer 20% = R$ 531. Cobro R$ 550/mês."

---

## 📅 ATUALIZAÇÃO DESTA TABELA

**Última atualização:** Outubro 2025

**Próxima revisão:** Janeiro 2026

**Como acompanhar mudanças:**
1. OpenRouter newsletter: https://openrouter.ai/updates
2. Anthropic blog: https://www.anthropic.com/news
3. OpenAI pricing page: https://openai.com/api/pricing
4. Google AI Studio: https://aistudio.google.com

**Dica:** Configure alerta mensal pra revisar preços. Modelos mudam RÁPIDO.

---

## 🎯 CHECKLIST DE USO

Antes de escolher um modelo pro seu projeto:

- [ ] Identifiquei requisito principal (precisão, velocidade, custo, multimodal)?
- [ ] Calculei volume mensal estimado?
- [ ] Testei pelo menos 2 modelos com dados reais?
- [ ] Calculei custo total (API + infraestrutura)?
- [ ] Apliquei markup adequado (2.5-4x)?
- [ ] Justifiquei escolha pro cliente (usando Geodésia)?
- [ ] Conferi preços atualizados nas fontes oficiais?

---

**Quando a tabela ficar desatualizada (e VAI ficar), você sabe EXATAMENTE o que fazer:**

1. Acesse OpenRouter ou API oficial
2. Confira preços atuais
3. Refaça cálculos com nova realidade
4. **Mas a LÓGICA de escolha permanece a mesma**

**Simples assim.**

---

*Tabela criada para Fundamento 1 - Prompt Engineering | Formação Gestor de IA*
*Instrutor: José Carlos Amorim | CreatorOS v3.0*
