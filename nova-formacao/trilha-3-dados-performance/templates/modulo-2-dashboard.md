# Template: Dashboard Automatizado

## Instruções de Uso

1. Escolha suas 5-7 métricas (use o prompt de IA se precisar)
2. Defina metas para cada métrica
3. Configure as fontes de dados no Looker Studio
4. Aplique as regras de cores (verde/amarelo/vermelho)
5. Compartilhe o link com seu time

---

## Passo 1: Escolha suas Métricas

### As 7 Métricas Universais

| # | Métrica | Categoria | Você Precisa? | Sua Meta |
|---|---------|-----------|---------------|----------|
| 1 | Faturamento | Financeiro | ⬜ Sim ⬜ Não | R$ _____ /mês |
| 2 | Margem/Lucro | Financeiro | ⬜ Sim ⬜ Não | _____% |
| 3 | Leads | Comercial | ⬜ Sim ⬜ Não | _____ /mês |
| 4 | Taxa de Conversão | Comercial | ⬜ Sim ⬜ Não | _____% |
| 5 | Ticket Médio | Comercial | ⬜ Sim ⬜ Não | R$ _____ |
| 6 | Churn/Retenção | Cliente | ⬜ Sim ⬜ Não | <_____% |
| 7 | NPS/CSAT | Cliente | ⬜ Sim ⬜ Não | >_____ |

### Métricas Adicionais por Tipo de Negócio

**Se você é SaaS/Recorrência:**
| Métrica | Incluir? | Meta |
|---------|----------|------|
| MRR (Monthly Recurring Revenue) | ⬜ | R$ _____ |
| ARR (Annual Recurring Revenue) | ⬜ | R$ _____ |
| LTV (Lifetime Value) | ⬜ | R$ _____ |
| CAC (Custo de Aquisição) | ⬜ | R$ _____ |
| LTV/CAC Ratio | ⬜ | >_____ |

**Se você é E-commerce:**
| Métrica | Incluir? | Meta |
|---------|----------|------|
| ROAS (Return on Ad Spend) | ⬜ | _____x |
| Taxa de Recompra | ⬜ | _____% |
| Carrinho Abandonado | ⬜ | <_____% |
| Custo por Pedido | ⬜ | R$ _____ |

**Se você é Serviços B2B:**
| Métrica | Incluir? | Meta |
|---------|----------|------|
| Propostas Enviadas | ⬜ | _____ /mês |
| Taxa de Fechamento | ⬜ | _____% |
| Ciclo de Venda (dias) | ⬜ | _____ dias |
| Pipeline Total | ⬜ | R$ _____ |

**Se você é Agência:**
| Métrica | Incluir? | Meta |
|---------|----------|------|
| Receita por Cliente | ⬜ | R$ _____ |
| Horas Faturáveis | ⬜ | _____h/mês |
| Utilização do Time | ⬜ | _____% |
| NPS de Clientes | ⬜ | >_____ |

---

## Passo 2: Defina suas Métricas Finais

**Minhas 5-7 métricas escolhidas:**

| # | Métrica | Fonte | Meta | Verde | Amarelo | Vermelho |
|---|---------|-------|------|-------|---------|----------|
| 1 | | | | ≥ | ≥ | < |
| 2 | | | | ≥ | ≥ | < |
| 3 | | | | ≥ | ≥ | < |
| 4 | | | | ≥ | ≥ | < |
| 5 | | | | ≥ | ≥ | < |
| 6 | | | | ≥ | ≥ | < |
| 7 | | | | ≥ | ≥ | < |

---

## Passo 3: Estrutura do Dashboard

### Layout Recomendado

```
┌─────────────────────────────────────────────────────────────┐
│  📊 DASHBOARD - [NOME DO NEGÓCIO]                           │
│  Última atualização: [automático]                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  💰 FINANCEIRO                                              │
│  ┌───────────────┐  ┌───────────────┐                      │
│  │   R$ XX.XXX   │  │     XX%       │                      │
│  │  Faturamento  │  │    Margem     │                      │
│  │   🟢 Meta: X  │  │   🟡 Meta: X  │                      │
│  │   ↑ +5% vs ant│  │   ↓ -2% vs ant│                      │
│  └───────────────┘  └───────────────┘                      │
│                                                             │
│  📈 COMERCIAL                                               │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐   │
│  │     XXX       │  │     X.X%      │  │   R$ X.XXX    │   │
│  │    Leads      │  │   Conversão   │  │    Ticket     │   │
│  │   🟡 Meta: X  │  │   🔴 Meta: X  │  │   🟢 Meta: X  │   │
│  └───────────────┘  └───────────────┘  └───────────────┘   │
│                                                             │
│  👥 CLIENTE                                                 │
│  ┌───────────────┐  ┌───────────────┐                      │
│  │     X.X%      │  │      XX       │                      │
│  │    Churn      │  │     NPS       │                      │
│  │   🟡 Meta: X  │  │   🟢 Meta: X  │                      │
│  └───────────────┘  └───────────────┘                      │
│                                                             │
│  📅 PERÍODO: [Seletor: Hoje | Semana | Mês | Trimestre]    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Passo 4: Configuração no Looker Studio

### 4.1 Criar Fonte de Dados

1. Acesse: [lookerstudio.google.com](https://lookerstudio.google.com)
2. Clique em "Criar" → "Fonte de dados"
3. Escolha "Google Sheets"
4. Selecione sua planilha de dados
5. Clique em "Conectar"

### 4.2 Criar Dashboard

1. Clique em "Criar" → "Relatório"
2. Selecione sua fonte de dados
3. Adicione elementos:
   - **Cartão de Métricas** → Para números grandes
   - **Gráfico de Barras** → Para comparativos
   - **Gráfico de Linha** → Para tendências
   - **Tabela** → Para detalhamento

### 4.3 Configurar Atualização Automática

1. Na fonte de dados, clique em "Editar conexão"
2. Em "Atualização de dados", selecione frequência
3. Opções: A cada hora, diariamente, semanalmente

### 4.4 Configurar Cores Condicionais

Para cada métrica:
1. Clique no elemento
2. Vá em "Estilo"
3. Ative "Formatação condicional"
4. Configure:
   - 🟢 Verde: ≥ meta
   - 🟡 Amarelo: ≥ 80% da meta
   - 🔴 Vermelho: < 80% da meta

---

## Passo 5: Planilha Base de Dados

### Estrutura Recomendada

Crie uma planilha Google Sheets com esta estrutura:

**Aba: Dados_Diarios**
| Data | Faturamento | Leads | Conversões | Vendas | Ticket | Cancelamentos |
|------|-------------|-------|------------|--------|--------|---------------|
| 01/01/2025 | 5200 | 12 | 1 | 2500 | 2500 | 0 |
| 02/01/2025 | 4800 | 15 | 2 | 5100 | 2550 | 1 |
| ... | ... | ... | ... | ... | ... | ... |

**Aba: Metas**
| Métrica | Meta_Mensal | Meta_Diária |
|---------|-------------|-------------|
| Faturamento | 100000 | 3333 |
| Leads | 400 | 13 |
| Conversão | 10% | 10% |
| Ticket | 2500 | 2500 |
| Churn | 3% | - |
| NPS | 50 | 50 |

**Aba: Calculado**
| Métrica | Hoje | Semana | Mês | Meta | Status |
|---------|------|--------|-----|------|--------|
| Faturamento | =fórmula | =fórmula | =fórmula | =ref | =SE() |
| ... | ... | ... | ... | ... | ... |

---

## Prompt IA: Definir Métricas

```
Meu negócio:
- Tipo: [ex: agência de marketing digital]
- Faturamento: [ex: R$ 150K/mês]
- Modelo de receita: [ex: recorrência mensal]
- Número de clientes: [ex: 25 ativos]
- Maior desafio atual: [ex: reduzir churn]

Me ajude a definir as 5-7 métricas do meu dashboard:

1. Quais métricas são CRÍTICAS para meu tipo de negócio?
2. Para cada métrica:
   - Meta realista (baseada em benchmarks do setor)
   - Frequência ideal de atualização
   - Fórmula de cálculo simples
   - Valor que indica "verde", "amarelo" e "vermelho"
3. Qual a ordem de prioridade para implementar?
4. Alguma métrica que eu provavelmente esqueci?

Seja específico para meu tipo de negócio.
```

---

## Checklist de Validação

- [ ] Escolhi entre 5 e 7 métricas (não mais)
- [ ] Cada métrica tem meta definida
- [ ] Configurei cores condicionais (verde/amarelo/vermelho)
- [ ] Pelo menos 2 métricas atualizam automaticamente
- [ ] Dashboard abre em menos de 5 segundos
- [ ] Consigo acessar no celular
- [ ] Compartilhei link com quem precisa ver
- [ ] Testei se os dados estão corretos

---

## Troubleshooting Comum

| Problema | Solução |
|----------|---------|
| Dados não atualizam | Verificar conexão com Sheets, reconectar fonte |
| Números errados | Checar fórmulas na planilha base |
| Carrega lento | Reduzir período de dados, simplificar gráficos |
| Não aparece no celular | Usar "Modo de visualização" responsivo |
| Cores não funcionam | Verificar formatação condicional |

---

## Próxima Ação (48h)

**Tarefa:** Conectar pelo menos mais 1 fonte de dados automática

**Qual fonte vou conectar?** ______________________

**Como vou fazer?** ______________________

**Prazo:** ______________________

---

*Template Trilha 3 - Módulo 2*
*Academia Lendária*
