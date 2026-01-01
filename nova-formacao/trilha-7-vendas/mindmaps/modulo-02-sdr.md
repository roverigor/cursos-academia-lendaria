# Mindmap - Módulo 2: Playbook SDR com IA

```
                         ┌─────────────────────────────────────┐
                         │        MÓDULO 2: SDR + IA           │
                         │     Playbook de Qualificação        │
                         │           55 min                    │
                         └─────────────────┬───────────────────┘
                                           │
         ┌─────────────────┬───────────────┴───────────────┬─────────────────┐
         │                 │                               │                 │
         ▼                 ▼                               ▼                 ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│   2.1 QUICK WIN │ │   2.2 TEORIA    │ │  2.3 EXERCÍCIO  │ │  2.4 VALIDAÇÃO  │
│     10 min      │ │     15 min      │ │     20 min      │ │     10 min      │
│                 │ │                 │ │                 │ │                 │
│ Qualifique Lead │ │    BANT e       │ │ Crie Playbook   │ │ Qualifique 5    │
│   em 2 Minutos  │ │    Scoring      │ │ Qualificação    │ │     Leads       │
└────────┬────────┘ └────────┬────────┘ └────────┬────────┘ └────────┬────────┘
         │                   │                   │                   │
         ▼                   ▼                   ▼                   ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│ • Prompt IA     │ │ • Budget        │ │ • Template      │ │ • 5 leads       │
│ • Análise       │ │ • Authority     │ │   perguntas     │ │   qualificados  │
│   automática    │ │ • Need          │ │ • Prompt        │ │ • Scores        │
│ • Score BANT    │ │ • Timeline      │ │   customizado   │ │   calculados    │
│                 │ │ • Scoring 1-5   │ │ • Régua         │ │ • Priorização   │
└─────────────────┘ └─────────────────┘ └─────────────────┘ └─────────────────┘
```

---

## Framework BANT

```
┌────────────────────────────────────────────────────────────────────────────┐
│                                  BANT                                       │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐ │
│   │   BUDGET    │    │  AUTHORITY  │    │    NEED     │    │  TIMELINE   │ │
│   │             │    │             │    │             │    │             │ │
│   │  Orçamento  │    │  Decisor?   │    │ Dor clara?  │    │  Urgência?  │ │
│   │  aprovado?  │    │ Influência? │    │ Prioridade? │    │  Prazo?     │ │
│   │             │    │             │    │             │    │             │ │
│   │   1 - 5     │    │   1 - 5     │    │   1 - 5     │    │   1 - 5     │ │
│   └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘ │
│                                                                             │
│                         SCORE TOTAL: ___/20                                │
│                                                                             │
│                         Mínimo para avançar: 12                            │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘
```

---

## Sistema de Scoring

```
┌────────────────────────────────────────────────────────────────────────────┐
│                           RÉGUA DE PRIORIZAÇÃO                             │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   SCORE 16-20  ──────▶  🔥 HOT       ──────▶  Contato em 24h              │
│                                                                             │
│   SCORE 12-15  ──────▶  🟡 WARM      ──────▶  Contato em 48h              │
│                                                                             │
│   SCORE 8-11   ──────▶  🔵 COLD      ──────▶  Nurturing                   │
│                                                                             │
│   SCORE 0-7    ──────▶  ❌ DESCARTE  ──────▶  Não qualificado             │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘
```

---

## Prompt de Qualificação IA

```
┌────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  "Analise este lead e dê um score BANT de 1-5 para cada critério:         │
│                                                                             │
│   Lead: [nome, cargo, empresa]                                             │
│   Contexto: [como chegou, o que disse]                                     │
│                                                                             │
│   Avalie:                                                                   │
│   - BUDGET: Tem orçamento? Valor compatível?                               │
│   - AUTHORITY: É decisor? Tem influência?                                  │
│   - NEED: Dor clara? Prioridade alta?                                      │
│   - TIMELINE: Urgência? Prazo definido?                                    │
│                                                                             │
│   Formato: Score por critério + total + recomendação (HOT/WARM/COLD)"     │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘
```

---

## Fluxo de Qualificação

```
┌────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│   LEAD ENTRA ───▶ COLETA INFO ───▶ PROMPT IA ───▶ SCORE ───▶ AÇÃO        │
│                                                                             │
│       │              │               │            │           │            │
│       ▼              ▼               ▼            ▼           ▼            │
│   Formulário      LinkedIn        ChatGPT      16-20?      Agendar        │
│   Site            Site empresa    Claude       12-15?      Follow-up      │
│   Indicação       Contexto        Análise      8-11?       Nurturing      │
│   Evento          conversa        automática   0-7?        Descartar      │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘
```

---

## Entregável do Módulo

```
┌────────────────────────────────────────────────────────────────┐
│                    PLAYBOOK DE QUALIFICAÇÃO                    │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ✅ Template de perguntas BANT                                 │
│  ✅ Prompt customizado para IA                                 │
│  ✅ Régua de priorização (HOT/WARM/COLD)                       │
│  ✅ Critérios de score por perfil                              │
│  ✅ 5 leads qualificados como teste                            │
│                                                                 │
│  COMPROMISSO 48H: Usar IA em todas as qualificações            │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## Nível Bloom: APLICAR

```
┌────────────────────────────────────────────────────────────────┐
│                                                                 │
│  O aluno ao final do módulo deve ser capaz de:                 │
│                                                                 │
│  • Aplicar o framework BANT em qualquer lead                   │
│  • Usar prompts de IA para análise automatizada                │
│  • Calcular scores e priorizar leads                           │
│  • Criar playbook customizado para seu ICP                     │
│  • Tomar decisões baseadas em dados (não feeling)              │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```
