# Aula 2.7: Automatização e Próximos Passos

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 2 - Dashboard Automatizado |
| **Aula** | 2.7 |
| **Tipo** | Validação |
| **Duração** | 5 minutos |
| **Conceitos** | 2 (Automatização básica + Transição) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai saber como manter seus dados atualizados automaticamente — e estar pronto pro próximo nível: Alertas.**
>
> Dashboard sem dados atualizados = decoração.

---

## 🗺️ P - POSITION (Origem)

> "Tá, fiz o dashboard. Mas tenho que preencher a planilha todo dia?"
>
> Não necessariamente.
>
> Vou te mostrar 3 níveis de automação — do simples ao avançado.
>
> Escolha o que faz sentido pro seu momento.

---

## 🛤️ S - STEPS (Rota)

### 3 Níveis de Automação

```
[DIAGRAMA: Escada de Automação]

NÍVEL 3: FULL AUTO ────────────────────┐
├── CRM → Sheets → Dashboard (zero trabalho)│
└──────────────────────────────────────────┘
                    ↑
NÍVEL 2: SEMI-AUTO ────────────────────┐
├── Importação semanal (5 min/semana)  │
└──────────────────────────────────────┘
                    ↑
NÍVEL 1: MANUAL ORGANIZADO ────────────┐
├── Preenchimento diário (5 min/dia)   │
└──────────────────────────────────────┘
```

---

### Nível 1: Manual Organizado (Mais Simples)

**O que é:** Você preenche a planilha manualmente, mas de forma organizada.

**Como fazer:**
- Defina horário fixo (ex: 9h toda manhã)
- Preencha os números do dia anterior
- Dashboard atualiza automaticamente

**Tempo:** 5 min/dia

**Bom pra:** Quem está começando ou tem poucos dados.

---

### Nível 2: Semi-Automático (Intermediário)

**O que é:** Você importa dados de outros sistemas semanalmente.

**Como fazer:**
1. Exporte CSV do CRM/ERP/Sistema
2. Cole na planilha (área específica)
3. Fórmulas fazem o resto

**Ferramentas úteis:**
- Google Sheets: IMPORTDATA() ou IMPORTRANGE()
- Zapier/Make: Conecta sistemas

**Tempo:** 5 min/semana

**Bom pra:** Quem tem sistemas mas não quer integração complexa.

---

### Nível 3: Full Automático (Avançado)

**O que é:** Dados fluem automaticamente dos sistemas pro dashboard.

**Como fazer:**
1. Conecte CRM → Google Sheets (via API ou Zapier)
2. Configure atualização automática
3. Dashboard sempre atualizado

**Integrações comuns:**
| Sistema | Ferramenta de conexão |
|---------|----------------------|
| Pipedrive | Zapier, API nativa |
| RD Station | Zapier, Google Sheets Add-on |
| Stripe/Asaas | Zapier |
| Shopify | Google Sheets Add-on |

**Tempo:** 0 min/dia (após setup)

**Bom pra:** Quem tem volume e quer escalar.

---

### 🤔 Pergunta Reflexiva

> "Qual nível faz sentido pra você AGORA?"
>
> Não precisa ir pro Nível 3 imediatamente.
>
> Nível 1 funcional > Nível 3 nunca implementado.

---

### Checklist de Validação do Módulo 2

| Critério | ✅ / ❌ |
|----------|--------|
| Dashboard criado no Looker Studio | |
| 5-7 métricas visualizadas | |
| Pelo menos 3 com cores condicionais | |
| 1 gráfico de tendência | |
| Dados conectados (mesmo que manual) | |
| Link salvo nos favoritos | |

**Resultado:**
- 6/6 ✅ → **COMPLETO** - Parabéns!
- 4-5/6 ✅ → **QUASE** - Finalize o que falta
- <4/6 ✅ → **INCOMPLETO** - Volte nas aulas anteriores

---

## 💡 Revisão do Módulo 2

**Os 3 Insights do Módulo:**

1. **Menos é mais** — 5-7 métricas > 50 métricas

2. **Cores aceleram decisão** — Verde/Amarelo/Vermelho elimina dúvida

3. **Automação é progressiva** — Comece manual, automatize depois

**Entregável Completo:**
- ✅ Dashboard funcional
- ✅ Métricas com metas e cores
- ✅ Plano de atualização (manual ou automático)

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Decida seu nível de automação (1, 2 ou 3)
2. Se Nível 1: Defina o horário diário de preenchimento
3. Se Nível 2/3: Anote qual integração explorar depois

**Funcionou se:** Você tem um plano claro de como manter os dados atualizados.

---

## 🎬 HOOK - Próximo Módulo

> Você tem um dashboard.
>
> Mas dashboard você precisa ABRIR pra ver.
>
> E se os problemas viessem até VOCÊ?
>
> No Módulo 3, vamos criar **Alertas Inteligentes**.
>
> Quando algo sair do normal, você recebe uma mensagem no WhatsApp.
>
> Sem precisar abrir nada. O problema vem até você.
>
> **Próximo: Módulo 3 - Alertas Inteligentes**

---

## 📊 Resumo do Módulo 2

| Aula | Duração | O que você fez |
|------|---------|----------------|
| 2.1 | 5 min | Entendeu por que dashboards falham |
| 2.2 | 10 min | Viu o custo de não visualizar |
| 2.3 | 10 min | Definiu suas 5-7 métricas |
| 2.4 | 10 min | Conheceu Looker Studio |
| 2.5 | 15 min | Viu a demo |
| 2.6 | 20 min | Construiu seu dashboard |
| 2.7 | 5 min | Planejou automatização |
| **TOTAL** | **75 min** | **Dashboard completo e funcional** |

---

*Aula 2.7 - Trilha 3 - Academia Lendária*
*Fim do Módulo 2*
