# Aula 2.4: Looker Studio - A Ferramenta Gratuita

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 2 - Dashboard Automatizado |
| **Aula** | 2.4 |
| **Tipo** | Ferramenta |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Ferramenta principal + Alternativas) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai conhecer o Looker Studio e entender quando usar ele (ou uma alternativa).**
>
> Você vai saber criar sua conta e configurar a conexão básica.

---

## 🗺️ P - POSITION (Origem)

> Se você está pensando "não sou técnico, isso vai ser difícil"...
>
> Relaxa. Se você sabe usar Google Sheets, você sabe usar Looker Studio.
>
> A interface é visual. Arrasta e solta.
>
> E o melhor: é de graça.

---

## 🛤️ S - STEPS (Rota)

### Por Que Looker Studio?

**A Analogia do Canivete Suíço**

> Looker Studio é como um canivete suíço de dashboards:
>
> - Gratuito (não paga nada)
> - Conecta com tudo (Sheets, Analytics, BigQuery)
> - Atualiza sozinho (automático)
> - Compartilha fácil (link ou embed)
>
> Não é o mais poderoso do mercado. Mas é o melhor custo-benefício pra quem está começando.

---

### Comparativo de Ferramentas

| Ferramenta | Preço | Dificuldade | Melhor pra |
|------------|-------|-------------|------------|
| **Looker Studio** | Grátis | ⭐⭐ Fácil | PMEs, Google Sheets |
| **Power BI** | $10/mês | ⭐⭐⭐ Médio | Quem usa Microsoft |
| **Metabase** | Grátis (self-host) | ⭐⭐⭐⭐ Difícil | Startups técnicas |
| **Tableau** | $70/mês | ⭐⭐⭐ Médio | Empresas grandes |
| **Notion** | Grátis-$10 | ⭐ Fácil | Dashboards simples |

**Minha recomendação:**
- Usa Google Sheets? → **Looker Studio**
- Usa Excel? → **Power BI**
- Quer o mais simples possível? → **Notion**
- Tem time técnico? → **Metabase**

---

### Configurando Looker Studio (5 min)

**Passo 1: Acessar**
1. Acesse: lookerstudio.google.com
2. Faça login com sua conta Google

**Passo 2: Criar Relatório**
1. Clique em "Criar" → "Relatório"
2. Escolha nome: "Dashboard [Seu Negócio]"

**Passo 3: Conectar Dados**
1. "Adicionar dados" → "Google Sheets"
2. Selecione sua planilha de dados
3. Escolha a aba com suas métricas

```
[DIAGRAMA: Fluxo de Conexão]

┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Google     │────▶│   Looker    │────▶│  Dashboard  │
│  Sheets     │     │   Studio    │     │  Visual     │
│  (dados)    │     │  (conexão)  │     │  (gráficos) │
└─────────────┘     └─────────────┘     └─────────────┘
      │                                        │
      └── Atualiza ───────────────────────────┘
           automaticamente
```

---

### 🤔 Pergunta Reflexiva

> "Seus dados estão em Google Sheets?"
>
> Se sim, Looker Studio é a escolha óbvia.
>
> Se não, qual ferramenta faz mais sentido pro seu contexto?

---

### O Básico da Interface

**4 áreas principais:**

```
[DIAGRAMA: Interface Looker Studio]

┌─────────────────────────────────────────┐
│  📊 BARRA DE FERRAMENTAS                │
│  [Adicionar gráfico] [Adicionar controle]│
├─────────────────────────────────────────┤
│                          │  📋 DADOS    │
│                          │  - Planilha  │
│   📈 CANVAS              │  - Campos    │
│   (onde monta o dash)    │  - Métricas  │
│                          │              │
│                          ├──────────────┤
│                          │  🎨 ESTILO   │
│                          │  - Cores     │
│                          │  - Fontes    │
└──────────────────────────┴──────────────┘
```

**Tipos de gráficos mais úteis:**
- **Scorecard** → Número grande (faturamento)
- **Gráfico de linha** → Tendência ao longo do tempo
- **Gráfico de barras** → Comparação entre categorias
- **Tabela** → Dados detalhados

---

### 🤔 Pergunta Reflexiva

> "Das suas 5-7 métricas definidas na aula anterior..."
>
> "Qual tipo de gráfico faz mais sentido pra cada uma?"
>
> Número que importa valor absoluto → Scorecard
> Número que importa tendência → Linha
> Número que importa comparação → Barras

---

## 💡 Revisão

**Os 2 Insights:**

1. **Looker Studio é grátis e suficiente** — Não precisa pagar pra ter um dashboard profissional.

2. **Alternativas existem** — Power BI pra Microsoft, Notion pra simplicidade, Metabase pra técnicos.

**A Transformação:**
- **Antes:** "Dashboards são caros e complicados"
- **Depois:** "Posso criar um dashboard profissional de graça em 1 hora"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Acesse lookerstudio.google.com
2. Faça login
3. Crie um relatório vazio chamado "Dashboard [Seu Negócio]"

**Funcionou se:** Você está vendo a tela em branco do Looker Studio.

---

## 🎬 HOOK - Próxima Aula

> Você tem a ferramenta aberta.
>
> Agora vem a parte prática: criar seu dashboard ao vivo.
>
> Na próxima aula, você vai me ver construindo um dashboard completo — do zero aos gráficos configurados — em 15 minutos.
>
> Você pode fazer junto ou assistir e depois replicar.
>
> **Próxima aula: 2.5 - Criando Seu Dashboard ao Vivo**

---

*Aula 2.4 - Trilha 3 - Academia Lendária*
