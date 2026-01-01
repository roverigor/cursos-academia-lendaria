# Aula 1.4: O Painel de Controle do Seu Marketing

## Metadados

| Campo | Valor |
|-------|-------|
| **Modulo** | 1 - Dados, Tracking e Metas |
| **Aula** | 1.4 |
| **Tipo** | Ferramenta |
| **Duracao** | 10 minutos |
| **Conceitos** | 2 (GA4 + Eventos de Conversao) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, voce vai saber como configurar o GA4 para trackear cada etapa do seu funil.**
>
> Na proxima aula, voce vai me ver fazendo. Nesta, voce entende a logica.

---

## 🗺️ P - POSITION (Origem)

> Se voce ja tentou entrar no Google Analytics e desistiu porque parecia complicado...
>
> GA4 e diferente. Mais simples. Mais visual.
>
> E a base para ter dados reais do seu funil.
>
> Voce nao precisa ser tecnico. So precisa entender o que configurar.

---

## 🛤️ S - STEPS (Rota)

### Visao Geral do GA4

```
┌─────────────────────────────────────────────────────────────────┐
│                    GOOGLE ANALYTICS 4                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   O QUE FAZ:                                                    │
│   ─────────                                                     │
│   Coleta dados de navegacao e acoes no seu site/app             │
│                                                                 │
│   ESTRUTURA BASICA:                                             │
│   ─────────────────                                             │
│                                                                 │
│   ┌────────────┐    ┌────────────┐    ┌────────────┐           │
│   │  EVENTOS   │ → │  CONVERSOES │ → │ RELATORIOS │           │
│   │(acoes user)│    │(eventos key)│    │ (visao)    │           │
│   └────────────┘    └────────────┘    └────────────┘           │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### O Que Sao Eventos no GA4

**Eventos = Acoes do usuario que queremos medir**

| Categoria | Exemplos |
|-----------|----------|
| **Automaticos** | page_view, session_start, first_visit |
| **Recomendados** | login, sign_up, purchase |
| **Customizados** | form_submit, button_click, video_complete |

---

### Eventos Essenciais para Seu Funil

| Etapa do Funil | Evento GA4 | Como Configurar |
|----------------|------------|-----------------|
| Visitante | `page_view` | Automatico |
| Lead | `generate_lead` ou `form_submit` | GTM ou codigo |
| Engajamento | `scroll`, `click`, `video_progress` | Enhanced Measurement |
| Venda | `purchase` | Codigo ou GTM |

---

### Marcando Eventos como Conversao

```
┌─────────────────────────────────────────────────────────────────┐
│                    CONFIGURAR CONVERSAO                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   1. Admin > Eventos                                            │
│   2. Encontre o evento (ex: generate_lead)                      │
│   3. Toggle "Marcar como conversao" = ON                        │
│                                                                 │
│   Por que isso importa?                                         │
│   ────────────────────────                                      │
│   - Conversoes aparecem nos relatorios principais               │
│   - Podem ser usadas para otimizar campanhas de ads             │
│   - Permitem calcular ROI automaticamente                       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### Formas de Instalar o GA4

| Metodo | Complexidade | Quando Usar |
|--------|--------------|-------------|
| **Tag direto no site** | Facil | Site simples, sem muitos eventos |
| **Google Tag Manager (GTM)** | Media | Precisa de eventos customizados |
| **Plugin/Integracao** | Facil | WordPress, Shopify, etc |
| **Via codigo** | Avancado | Apps, SPAs, situacoes especificas |

**Recomendacao:** Use GTM. E mais flexivel e nao exige programador pra cada mudanca.

---

### Os 5 Eventos que Voce PRECISA Ter

| # | Evento | O que Mede | Prioridade |
|---|--------|------------|------------|
| 1 | `page_view` | Visitantes | Automatico |
| 2 | `generate_lead` | Novos leads | CRITICA |
| 3 | `qualified_lead` | Leads qualificados | ALTA |
| 4 | `purchase` | Vendas | CRITICA |
| 5 | `button_click` | Engajamento | MEDIA |

---

### 🤔 Pergunta Reflexiva

> "Voce sabe quantos leads entraram no seu site essa semana?"
>
> Se a resposta for "nao" ou "mais ou menos"...
>
> Voce nao tem tracking. E sem tracking, nao tem otimizacao.

---

### Checklist de Tracking Minimo

```
[ ] GA4 instalado e recebendo dados
[ ] Evento de lead configurado
[ ] Evento de venda configurado
[ ] Eventos marcados como conversao
[ ] Painel de visao diaria configurado
```

---

## 💡 Revisao

**Os 2 Insights:**
1. **GA4 trabalha com eventos** — cada acao importante vira um evento
2. **Conversoes sao eventos especiais** — marcados para aparecer nos relatorios

**A Transformacao:**
- **Antes:** "Analytics e muito complicado"
- **Depois:** "Preciso de 5 eventos basicos, e simples configurar"

---

## ⚡ ACAO RAPIDA (2 min)

**Faca agora:**
1. Acesse seu GA4 (analytics.google.com)
2. Va em Admin > Eventos
3. Veja quais eventos ja existem
4. Anote: "Tenho _____ eventos, faltam _____"

**Funcionou se:** Voce sabe quais eventos ja existem no seu GA4.

---

## 🎬 HOOK - Proxima Aula

> Voce conhece a teoria do GA4.
>
> Mas ver e diferente de fazer.
>
> Na proxima aula, vou configurar o Mapa de Metricas e eventos de um caso REAL.
>
> Voce vai ver cada clique, cada configuracao.
>
> **Proxima aula: 1.5 - Mapa de Metricas e Eventos na Pratica**

---

*Aula 1.4 - Trilha 6 - Marketing com IA e Automacoes - Academia Lendaria*
