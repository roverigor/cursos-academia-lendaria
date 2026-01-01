# Aula 4.3: Cada Lead no Caminho Certo

## Metadados

| Campo | Valor |
|-------|-------|
| **Modulo** | 4 - Automacoes do Funil |
| **Aula** | 4.3 |
| **Tipo** | Conceito |
| **Duracao** | 10 minutos |
| **Conceitos** | 2 (Roteamento + Automacao condicional) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, voce vai saber como rotear leads automaticamente baseado no score.**

---

## 🗺️ P - POSITION (Origem)

> Lead quente e lead frio nao podem ter o mesmo tratamento.
>
> Roteamento inteligente envia cada um pro caminho certo.

---

## 🛤️ S - STEPS (Rota)

### Logica de Roteamento

```
┌─────────────────────────────────────────────────────────────────┐
│                    ROTEAMENTO POR SCORE                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Lead entra                                                    │
│       ↓                                                         │
│   Calcula Score                                                 │
│       ↓                                                         │
│   ┌─────────────────────────────────────────────┐               │
│   │ Score < 30    → Nurturing automatico        │               │
│   │ Score 30-60   → SDR contacta em 24h         │               │
│   │ Score 61-80   → SDR contacta em 4h          │               │
│   │ Score > 80    → Alerta imediato + ligacao   │               │
│   └─────────────────────────────────────────────┘               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### Acoes por Temperatura

| Temperatura | Score | Acao Automatica | Acao Humana |
|-------------|-------|-----------------|-------------|
| FRIO | 0-30 | Sequencia email 7 dias | Nenhuma |
| MORNO | 31-60 | Sequencia + alerta SDR | Contato em 24h |
| QUENTE | 61-80 | Alerta prioritario | Contato em 4h |
| MUITO QUENTE | 81+ | Alerta + Slack | Ligacao imediata |

---

### Implementacao no Make/n8n

```
[Webhook] → [Calcular Score] → [Router]
                                  ↓
                    ┌─────────────┼─────────────┐
                    ↓             ↓             ↓
              [Email Auto]   [Alerta SDR]  [Alerta Urgente]
```

---

### Canais de Alerta

| Temperatura | Canal | Formato |
|-------------|-------|---------|
| Morno | Email | "Novo lead morno: [nome]" |
| Quente | Slack | "@vendedor Lead quente!" |
| Muito Quente | WhatsApp + Ligacao | "LIGAR AGORA: [telefone]" |

---

## 💡 Revisao

**Os 2 Insights:**
1. **Automacao decide, humano executa** — roteamento e automatico
2. **Velocidade importa** — lead quente esfria rapido

---

## ⚡ ACAO RAPIDA (2 min)

**Faca agora:**
1. Defina seus 4 niveis de score
2. Defina a acao para cada nivel
3. Escolha os canais de alerta

**Funcionou se:** Voce tem a logica de roteamento definida.

---

## 🎬 HOOK - Proxima Aula

> Voce sabe a logica. Na proxima: a ferramenta.
>
> **Proxima aula: 4.4 - Make/n8n para Automacao de Funil**

---

*Aula 4.3 - Trilha 6 - Marketing com IA e Automacoes - Academia Lendaria*
