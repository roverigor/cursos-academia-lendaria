# Aula 1.5: Mapa de Metricas e Eventos ao Vivo

## Metadados

| Campo | Valor |
|-------|-------|
| **Modulo** | 1 - Dados, Tracking e Metas |
| **Aula** | 1.5 |
| **Tipo** | Demo |
| **Duracao** | 15 minutos |
| **Conceitos** | 1 (Execucao pratica) |
| **Formato** | Demonstracao ao vivo |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, voce vai ter visto o Mapa de Metricas sendo criado do ZERO ao COMPLETO em um caso real.**
>
> Nao e teoria. E pratica. Voce vai ver cada passo.

---

## 🗺️ P - POSITION (Origem)

> Voce conhece CAC, ROAS, Funil, GA4.
>
> Agora e hora de ver tudo junto na pratica.
>
> Eu vou criar o Mapa de Metricas de uma consultoria de marketing.
>
> Presta atencao nos detalhes — porque daqui a pouco e sua vez.

---

## 🛤️ S - STEPS (Rota)

### O Caso

**Contexto:**
- Consultoria de Marketing Digital
- Faturamento: R$ 50.000/mes
- Time: 2 pessoas
- Modelo: Servico recorrente (mensalidade)

**O que vamos fazer:**
- Mapear funil completo
- Definir KPIs e metas
- Identificar eventos necessarios

---

### [DEMO AO VIVO]

**[Momento 1 - Abrindo o Template] (~2 min)**

> "Primeiro, eu abro o Template de Mapa de Metricas..."
>
> "Ele tem 3 abas: Funil, Eventos, Dashboard"

**Estrutura do Template:**

```
┌─────────────────────────────────────────────────────────────────┐
│  MAPA DE METRICAS - Template                                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ABA 1: FUNIL                                                   │
│  - Etapas do funil                                              │
│  - Volume atual                                                 │
│  - Taxa de conversao                                            │
│  - Meta de taxa                                                 │
│                                                                 │
│  ABA 2: EVENTOS                                                 │
│  - Evento GA4                                                   │
│  - Descricao                                                    │
│  - Como medir                                                   │
│  - Status (configurado/pendente)                                │
│                                                                 │
│  ABA 3: DASHBOARD                                               │
│  - KPI                                                          │
│  - Valor atual                                                  │
│  - Meta                                                         │
│  - Tendencia                                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

**[Momento 2 - Mapeando o Funil] (~5 min)**

> "Vou comecar definindo as etapas do funil dessa consultoria..."

**Preenchendo o Funil:**

| Etapa | Volume Mes | Taxa | Meta |
|-------|------------|------|------|
| Visitantes (site) | 2.000 | 100% | - |
| Leads (form contato) | 60 | 3% | 5% |
| Qualificados (respondeu) | 18 | 30% | 40% |
| Reuniao (agendou) | 9 | 50% | 60% |
| Proposta (recebeu) | 6 | 67% | 75% |
| Cliente (fechou) | 2 | 33% | 40% |

> "Olha isso: de 2.000 visitantes, viram 2 clientes."
>
> "A taxa geral e 0,1%. Parece pouco, mas e normal pra B2B."
>
> "A pergunta e: onde melhorar?"

**Identificando o Gargalo:**

> "Visitante → Lead: 3% — abaixo do ideal (5%)"
>
> "ESSE e o maior gargalo. Se dobrar pra 6%, dobra tudo."

---

**[Momento 3 - Definindo Eventos] (~4 min)**

> "Agora vou listar os eventos que preciso no GA4..."

**Eventos Necessarios:**

| Etapa | Evento GA4 | Como Trackear |
|-------|------------|---------------|
| Visitante | `page_view` | Automatico |
| Lead | `form_submit` | GTM - trigger form |
| Qualificado | `lead_qualified` | Webhook do CRM |
| Reuniao | `meeting_scheduled` | Calendly webhook |
| Proposta | `proposal_sent` | Manual ou CRM |
| Cliente | `purchase` | Stripe webhook |

> "Percebe que nem tudo e no site?"
>
> "Qualificado, Reuniao, Proposta... vem do CRM."
>
> "Por isso precisa de integracao. Make ou n8n resolvem."

---

**[Momento 4 - Calculando KPIs] (~2 min)**

> "Agora os KPIs macro..."

**Dashboard de KPIs:**

| KPI | Valor Atual | Meta | Status |
|-----|-------------|------|--------|
| CAC | R$ 1.250 | R$ 1.000 | ⚠️ Alto |
| LTV | R$ 15.000 | - | - |
| LTV/CAC | 12x | > 3x | ✅ Otimo |
| ROAS | 4x | 3x | ✅ Bom |
| Taxa Funil | 0,1% | 0,2% | ⚠️ Baixo |

> "LTV/CAC de 12x e excelente."
>
> "Mas CAC ainda pode cair se melhorar a LP."

---

**[Momento 5 - Resultado Final] (~2 min)**

```
MAPA DE METRICAS COMPLETO

Funil: 6 etapas mapeadas
Eventos: 6 eventos identificados
KPIs: 5 metricas calculadas
Gargalo: Visitante → Lead (3%, meta 5%)

Proximo passo:
- Configurar tracking no GA4/GTM
- Integrar CRM via Make
- Otimizar LP (maior impacto)
```

---

### 🤔 Pergunta Reflexiva

> "Qual parte voce achou mais dificil acompanhar?"
>
> Anota. Na proxima aula, voce vai fazer — e pode pausar quantas vezes precisar.

---

## 💡 Revisao

**O Insight:**
- Ver alguem fazendo e diferente de ler sobre. Agora voce sabe que e possivel.

**A Transformacao:**
- **Antes:** "Parece complicado mapear tudo"
- **Depois:** "Sao 3 abas, 15 minutos, qualquer um faz"

---

## ⚡ ACAO RAPIDA (2 min)

**Faca agora:**
1. Anote as 6 etapas do funil que viu
2. Marque qual parece mais desafiador pra voce
3. Prepare seu ambiente pra proxima aula

**Funcionou se:** Voce tem as etapas anotadas e sabe o que preparar.

---

## 🎬 HOOK - Proxima Aula

> Voce viu. Agora e sua vez.
>
> Na proxima aula, voce vai preencher o Mapa de Metricas com SEUS dados.
>
> Vai ser guiado, passo a passo, com cronometro.
>
> 20 minutos. Sem desculpas.
>
> **Proxima aula: 1.6 - Seu Turno: Mapa de Metricas**

---

*Aula 1.5 - Trilha 6 - Marketing com IA e Automacoes - Academia Lendaria*
