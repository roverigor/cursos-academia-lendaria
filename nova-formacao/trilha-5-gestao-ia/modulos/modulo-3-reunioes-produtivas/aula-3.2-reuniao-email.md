# Aula 3.2: A Reunião que Deveria Ser um Email

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 3 - Reuniões Produtivas com IA |
| **Aula** | 3.2 |
| **Tipo** | Conceitual |
| **Duração** | 10 minutos |
| **Conceitos** | 2 (Critérios de necessidade + Alternativas) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai saber decidir quando uma reunião é necessária — e quando deveria ser outra coisa.**
>
> Você vai ter critérios claros para filtrar reuniões.

---

## 🗺️ P - POSITION (Origem)

> "Como sei se a reunião é mesmo necessária?"
>
> Boa pergunta.
>
> Existe um framework simples.
>
> A maioria das reuniões falha no primeiro critério.

---

## 🛤️ S - STEPS (Rota)

### Os 3 Critérios da Reunião Necessária

```
[DIAGRAMA: Filtro de Reunião]

        ┌───────────────────────────────────────┐
        │        PRECISA DE REUNIÃO?            │
        └───────────────────────────────────────┘
                          │
        ┌─────────────────┼─────────────────┐
        ▼                 ▼                 ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│ CRITÉRIO 1   │  │ CRITÉRIO 2   │  │ CRITÉRIO 3   │
│              │  │              │  │              │
│ Precisa de   │  │ Precisa de   │  │ Requer       │
│ DIÁLOGO?     │  │ múltiplas    │  │ decisão      │
│              │  │ PESSOAS      │  │ AGORA?       │
│              │  │ juntas?      │  │              │
└──────────────┘  └──────────────┘  └──────────────┘
        │                 │                 │
        ▼                 ▼                 ▼
   SE NÃO:           SE NÃO:           SE NÃO:
   → Email           → 1:1             → Agendar
   → Documento       → Mensagem        → para depois
   → Loom            → Assíncrono      → ou cancelar
```

**Regra:** Os 3 critérios precisam ser SIM. Se qualquer um for NÃO, não é reunião.

---

### Critério 1: Precisa de Diálogo?

| Situação | Precisa de diálogo? | Alternativa |
|----------|---------------------|-------------|
| Informar resultados do mês | ❌ Não | Email + dashboard |
| Debater estratégia de preço | ✅ Sim | Reunião |
| Atualizar status de projeto | ❌ Não | Mensagem no Slack |
| Resolver conflito entre áreas | ✅ Sim | Reunião |
| Compartilhar documento novo | ❌ Não | Loom de 5 min |

**Teste rápido:** Se você pode resolver escrevendo, não precisa de reunião.

---

### Critério 2: Precisa de Múltiplas Pessoas Juntas?

| Situação | Precisa de todos juntos? | Alternativa |
|----------|-------------------------|-------------|
| Feedback individual | ❌ Não | 1:1 |
| Alinhamento de equipe | ✅ Sim | Reunião |
| Discussão sobre sua meta | ❌ Não | 1:1 |
| Planejamento trimestral | ✅ Sim | Reunião |
| Aprovar budget | ❌ Não (só decisor) | Documento + aprovação |

**Teste rápido:** Se só 2 pessoas são essenciais, é 1:1, não reunião.

---

### Critério 3: Requer Decisão Agora?

| Situação | Urgente? | Alternativa |
|----------|----------|-------------|
| Crise com cliente | ✅ Sim | Reunião imediata |
| Planejamento do trimestre | ❌ Pode esperar | Agendar com antecedência |
| "Só para alinhar" | ❌ Quase nunca urgente | Cancelar |
| Definir preço de proposta | ✅ Cliente esperando | Reunião |

**Teste rápido:** Se pode esperar 24h, provavelmente não precisa de reunião.

---

### A Árvore de Decisão Completa

```
[DIAGRAMA: Fluxo de Decisão]

                    TÓPICO A TRATAR
                          │
                          ▼
              ┌───────────────────────┐
              │ Precisa de DIÁLOGO?   │
              └───────────────────────┘
                    │           │
                   SIM         NÃO
                    │           │
                    ▼           └──► EMAIL/LOOM/DOC
              ┌───────────────────────┐
              │ Precisa de MÚLTIPLAS  │
              │ pessoas juntas?       │
              └───────────────────────┘
                    │           │
                   SIM         NÃO
                    │           │
                    ▼           └──► 1:1 ou MENSAGEM
              ┌───────────────────────┐
              │ Precisa ser AGORA?    │
              └───────────────────────┘
                    │           │
                   SIM         NÃO
                    │           │
                    ▼           └──► AGENDAR DEPOIS
                                     (ou nem fazer)
               ✅ REUNIÃO
               NECESSÁRIA
```

---

### Alternativas à Reunião

| Em vez de... | Use... | Quando |
|--------------|--------|--------|
| Reunião de status | Mensagem + dashboard | Atualizações rotineiras |
| Reunião de alinhamento | Documento compartilhado | Sem decisão necessária |
| Reunião de apresentação | Loom (vídeo gravado) | Informação unilateral |
| Reunião de aprovação | Comentário em doc | Só precisa de "ok" |
| Reunião "para discutir" | Thread no Slack | Ideias iniciais |

---

### Os 5 Tipos de Reunião Inútil

```
1. "REUNIÃO DE STATUS"
   └── Cada um fala 5 min, ninguém presta atenção
   └── Solução: Dashboard + mensagem assíncrona

2. "REUNIÃO PARA ALINHAR"
   └── Ninguém sabe o objetivo
   └── Solução: Definir decisão antes ou cancelar

3. "REUNIÃO RECORRENTE POR TRADIÇÃO"
   └── Existe há 2 anos, ninguém sabe por quê
   └── Solução: Questionar. Se não tem objetivo, cancelar

4. "REUNIÃO COM 15 PESSOAS"
   └── 3 falam, 12 assistem
   └── Solução: Reduzir para essenciais

5. "REUNIÃO SEM PAUTA"
   └── "Vamos ver o que surge"
   └── Solução: Sem pauta = sem reunião
```

---

### 🤔 Pergunta Reflexiva

> "Das suas reuniões da semana passada..."
>
> "...quantas passariam nos 3 critérios?"
>
> Se menos de metade, você está desperdiçando tempo.

---

## 💡 Revisão

**Os 2 Insights:**

1. **3 critérios = 1 filtro** — Diálogo + Múltiplas pessoas + Urgente. Os 3 precisam ser SIM.

2. **Alternativas existem** — Email, Loom, 1:1, documento. Use antes de agendar reunião.

**A Transformação:**
- **Antes:** "Agenda reunião por padrão"
- **Depois:** "Só agenda se passar nos 3 critérios"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Olhe sua próxima reunião na agenda
2. Aplique os 3 critérios
3. Se não passar, considere cancelar ou substituir

**Funcionou se:** Você questionou pelo menos 1 reunião.

---

## 🎬 HOOK - Próxima Aula

> Você sabe quando NÃO ter reunião.
>
> Mas quais reuniões DEVEM existir?
>
> Na próxima aula, vou te apresentar o ritmo certo: Daily, Weekly e Monthly — cada uma com propósito claro.
>
> **Próxima aula: 3.3 - Daily, Weekly, Monthly - O Ritmo Certo**

---

*Aula 3.2 - Trilha 5 - Academia Lendária*
