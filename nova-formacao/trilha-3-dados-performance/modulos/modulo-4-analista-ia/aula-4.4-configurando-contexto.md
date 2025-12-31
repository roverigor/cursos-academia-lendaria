# Aula 4.4: Claude/ChatGPT - Configurando Contexto

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 4 - Analista de Dados com IA |
| **Aula** | 4.4 |
| **Tipo** | Ferramenta |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Contexto de negócio + Prompt base) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter seu contexto de negócio configurado — e a IA vai entender exatamente quem você é e o que importa.**
>
> Sem contexto = respostas genéricas. Com contexto = respostas úteis.

---

## 🗺️ P - POSITION (Origem)

> "Toda vez que pergunto pra IA, ela dá respostas muito genéricas."
>
> Normal. Ela não conhece seu negócio.
>
> É como pedir conselho pra um estranho.
>
> Vou te mostrar como "apresentar" seu negócio pra IA.

---

## 🛤️ S - STEPS (Rota)

### A Analogia do Consultor

> Imagine que você contratou um consultor.
>
> Ele chega no primeiro dia e pergunta:
>
> - "Qual seu negócio?"
> - "Quais suas metas?"
> - "O que você considera sucesso?"
> - "Quais métricas você acompanha?"
>
> **A IA precisa das mesmas informações.**

---

### O Template de Contexto

**Copie e preencha:**

```
## CONTEXTO DO MEU NEGÓCIO

### Sobre a Empresa
- Nome: [sua empresa]
- Segmento: [ex: SaaS, E-commerce, Serviços]
- Modelo: [ex: Recorrência, Venda única, Projeto]
- Tempo no mercado: [X anos/meses]

### Números Atuais
- Faturamento médio mensal: R$ [X]
- Ticket médio: R$ [X]
- Quantidade de clientes ativos: [X]
- CAC (Custo de Aquisição): R$ [X]
- Churn mensal: [X]%
- Taxa de conversão: [X]%

### Metas do Período
- Meta mensal de faturamento: R$ [X]
- Meta de novos clientes: [X]
- Meta de churn máximo: [X]%
- Meta de conversão: [X]%

### Métricas que Acompanho
- Faturamento (diário/semanal/mensal)
- [Métrica 2]
- [Métrica 3]
- [Métrica 4]
- [Métrica 5]

### O Que Considero Crítico
- Se [métrica] < [valor], é alerta vermelho
- Se [métrica] cai por [X dias], investigo
- Se meta está abaixo de [X]% no dia [X], ajusto estratégia

### Meu Papel
- Eu sou [dono/gestor/marketing/etc]
- Tomo decisões sobre [área]
- Preciso de análises [diárias/semanais/mensais]
```

---

### Exemplo Preenchido

```
## CONTEXTO DO MEU NEGÓCIO

### Sobre a Empresa
- Nome: TechFlow Solutions
- Segmento: SaaS B2B
- Modelo: Recorrência mensal
- Tempo no mercado: 3 anos

### Números Atuais
- Faturamento médio mensal: R$ 85.000
- Ticket médio: R$ 500/mês
- Quantidade de clientes ativos: 170
- CAC: R$ 400
- Churn mensal: 3%
- Taxa de conversão (trial→pago): 12%

### Metas do Período
- Meta mensal de faturamento: R$ 100.000
- Meta de novos clientes: 25
- Meta de churn máximo: 2%
- Meta de conversão: 15%

### Métricas que Acompanho
- Faturamento (diário)
- MRR (Monthly Recurring Revenue)
- Churn
- Conversão trial→pago
- NPS

### O Que Considero Crítico
- Se faturamento diário < R$2K, é alerta
- Se churn > 2 clientes/dia por 3 dias, investigo
- Se dia 15 com <50% da meta, ajusto

### Meu Papel
- CEO e responsável por crescimento
- Decisões sobre produto, marketing e vendas
- Análises semanais e alertas diários
```

---

### Como Usar o Contexto

**Opção 1: Custom Instructions (ChatGPT)**
1. Vá em Configurações → Custom Instructions
2. Cole seu contexto na seção "O que você gostaria que eu soubesse?"
3. Toda conversa vai ter esse contexto

**Opção 2: Projeto (Claude)**
1. Crie um novo Projeto
2. Cole o contexto como "Knowledge"
3. Toda conversa nesse projeto terá o contexto

**Opção 3: Início de Conversa**
1. Comece a conversa com: "Aqui está o contexto do meu negócio: [cole o template]"
2. Depois faça suas perguntas

---

### 🤔 Pergunta Reflexiva

> "Se você fosse explicar seu negócio pra alguém em 2 minutos..."
>
> "...o que NÃO poderia faltar?"
>
> Isso é o que vai no contexto.

---

### Dica: Atualize Regularmente

```
[DIAGRAMA: Ciclo de Atualização]

┌───────────────────────────────────────────┐
│                                           │
│    📅 TODO INÍCIO DE MÊS                  │
│    Atualize os números no contexto        │
│                                           │
│    📊 Faturamento atual                   │
│    👥 Clientes ativos                     │
│    📉 Churn do mês anterior               │
│    🎯 Meta do novo mês                    │
│                                           │
└───────────────────────────────────────────┘
        │
        ▼
    Contexto sempre atualizado
        │
        ▼
    Análises sempre precisas
```

---

## 💡 Revisão

**Os 2 Insights:**

1. **Contexto = qualidade da resposta** — Quanto mais contexto, menos genérica a análise.

2. **Uma vez configurado, funciona sempre** — Vale o esforço inicial de preencher.

**A Transformação:**
- **Antes:** "IA dá respostas genéricas"
- **Depois:** "IA entende meu negócio e dá análises específicas"

---

## ⚡ AÇÃO RÁPIDA (3 min)

**Faça agora:**
1. Copie o template de contexto
2. Preencha pelo menos as seções "Sobre a Empresa" e "Números Atuais"
3. Salve num documento para usar depois

**Funcionou se:** Você tem seu contexto escrito e salvo.

---

## 🎬 HOOK - Próxima Aula

> Você tem o contexto.
>
> Agora precisa dos PROMPTS certos.
>
> Na próxima aula, vou te mostrar como criar 4 prompts de análise — um pra cada tipo.
>
> Performance. Investigação. Previsão. Comparação.
>
> **Próxima aula: 4.5 - Criando 4 Prompts de Análise**

---

*Aula 4.4 - Trilha 3 - Academia Lendária*
