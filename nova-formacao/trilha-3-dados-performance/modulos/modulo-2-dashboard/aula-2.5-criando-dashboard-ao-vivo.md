# Aula 2.5: Criando Seu Dashboard ao Vivo

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 2 - Dashboard Automatizado |
| **Aula** | 2.5 |
| **Tipo** | Demo |
| **Duração** | 15 minutos |
| **Conceitos** | 1 (Construção completa) |
| **Formato** | Screencast ao vivo |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter visto a criação completa de um dashboard — do zero ao funcional em 15 minutos.**
>
> Você vai poder replicar cada passo.

---

## 🗺️ P - POSITION (Origem)

> Se você nunca usou Looker Studio, pode parecer intimidador.
>
> "São muitos botões. Onde clico?"
>
> Calma. Vou mostrar exatamente onde clicar.
>
> E você vai ver que é mais fácil do que parece.

---

## 🛤️ S - STEPS (Rota)

### Setup (1 min)

**[TELA: Looker Studio aberto]**

> "Vou criar um dashboard pra mesma agência do Módulo 1."
>
> "5 métricas: Faturamento, Leads, Conversão, Ticket, Churn."
>
> "Cronômetro ligado. 15 minutos."

---

### Parte 1: Conectando os Dados (2 min)

**[TELA: Conectando Google Sheets]**

> "Primeiro, conecto minha planilha de dados."

1. Clique "Adicionar dados"
2. Selecione "Google Sheets"
3. Escolha a planilha "Dados Agência"
4. Selecione a aba "Métricas Mensais"

> "Pronto. Dados conectados."
>
> "Agora o Looker Studio sabe onde buscar os números."

---

### Parte 2: Criando os Scorecards (4 min)

**[TELA: Adicionando scorecards]**

> "Primeiro elemento: Scorecards com os números principais."

**Scorecard 1: Faturamento**
1. Inserir → Scorecard
2. Métrica: "Faturamento"
3. Título: "💰 Faturamento"
4. Formato: Moeda

**Scorecard 2: Leads**
1. Duplicar o primeiro (Ctrl+D)
2. Trocar métrica: "Leads"
3. Título: "📈 Leads"

**Scorecard 3-5:** Conversão, Ticket, Churn
> "Mesmo processo. Duplicar e trocar."

```
[DIAGRAMA: Layout dos Scorecards]

┌──────────┬──────────┬──────────┬──────────┬──────────┐
│    💰    │    📈    │    📊    │    💵    │    📉    │
│  R$150K  │   120    │   8,5%   │  R$2.8K  │   3,2%   │
│ Faturamento│  Leads  │ Conversão│  Ticket  │  Churn   │
└──────────┴──────────┴──────────┴──────────┴──────────┘
```

---

### Parte 3: Gráfico de Tendência (3 min)

**[TELA: Adicionando gráfico de linha]**

> "Agora o gráfico de linha pra ver tendência."

1. Inserir → Gráfico de série temporal
2. Dimensão: "Mês"
3. Métrica: "Faturamento"
4. Adicionar métrica: "Meta"

> "Coloquei meta junto pra comparar."

**Configurando cores:**
- Faturamento: Azul
- Meta: Verde pontilhado

```
[DIAGRAMA: Gráfico de Linha]

R$ ─┐
    │     Meta (verde)
150K├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
    │   ╱╲    ╱╲    ╱
100K├──╱──╲──╱──╲──╱  Faturamento (azul)
    │ ╱    ╲╱    ╲╱
 50K├╱
    └─────────────────────
      Jan Feb Mar Abr Mai
```

---

### Parte 4: Cores Condicionais (3 min)

**[TELA: Configurando cores]**

> "A parte mais importante: cores que indicam ação."

**No Scorecard de Conversão:**
1. Selecionar → Estilo
2. Formatação condicional
3. Regras:
   - < 5% → 🔴 Vermelho
   - 5-8% → 🟡 Amarelo
   - > 8% → 🟢 Verde

> "Agora, quando conversão cair, o número fica vermelho automaticamente."
>
> "Não preciso pensar 'isso é bom ou ruim?'. A cor me diz."

---

### Parte 5: Filtro de Período (2 min)

**[TELA: Adicionando controle]**

> "Último elemento: filtro de data."

1. Inserir → Controle de intervalo de datas
2. Posicionar no topo
3. Período padrão: "Últimos 30 dias"

> "Agora posso ver mês atual, trimestre, ano..."
>
> "Tudo dinâmico."

---

### Resultado Final

**[TELA: Dashboard completo]**

```
[DIAGRAMA: Dashboard Final]

┌─────────────────────────────────────────────────────┐
│  📊 DASHBOARD - AGÊNCIA XYZ                         │
│  [Filtro de data: Últimos 30 dias ▼]                │
├─────────────────────────────────────────────────────┤
│                                                     │
│  💰 R$148K    📈 95     📊 6,2%    💵 R$2.9K   📉 4,1% │
│  Faturamento   Leads   🟡Conversão  Ticket    🔴Churn │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  📈 Faturamento vs Meta (Últimos 6 meses)          │
│  [Gráfico de linha mostrando tendência]             │
│                                                     │
└─────────────────────────────────────────────────────┘
```

> "15 minutos. Dashboard pronto."
>
> "Conectado aos dados. Atualiza sozinho. Cores indicam ação."

---

## 💡 Revisão

**O Insight:**
- Um dashboard funcional não precisa ser complexo. 5 scorecards + 1 gráfico + cores = 80% do valor.

**A Transformação:**
- **Antes:** "Dashboards são complicados de fazer"
- **Depois:** "Consigo fazer um dashboard em 15 minutos"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Pause e tente criar 1 scorecard
2. Conecte sua planilha
3. Adicione uma métrica

**Funcionou se:** Você vê um número do seu negócio no Looker Studio.

---

## 🎬 HOOK - Próxima Aula

> Você viu como fazer.
>
> Agora é SUA VEZ construir o seu.
>
> Na próxima aula, vou te guiar passo a passo enquanto você cria seu próprio dashboard.
>
> Reserve 20 minutos. É tudo que você precisa.
>
> **Próxima aula: 2.6 - Seu Turno: Monte Seu Dashboard**

---

*Aula 2.5 - Trilha 3 - Academia Lendária*
