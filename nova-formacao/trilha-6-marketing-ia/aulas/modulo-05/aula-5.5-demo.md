# Aula 5.5: Plano de Experimentos ao Vivo

## Metadados

| Campo | Valor |
|-------|-------|
| **Modulo** | 5 - Otimizacao com IA |
| **Aula** | 5.5 |
| **Tipo** | Demo |
| **Duracao** | 15 minutos |
| **Conceitos** | 1 (Execucao pratica) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, voce vai ter visto um plano de experimentos sendo criado do zero com IA.**

---

## 🗺️ P - POSITION (Origem)

> Voce conhece ICE e os prompts.
>
> Agora vou montar um plano completo ao vivo.

---

## 🛤️ S - STEPS (Rota)

### O Caso

**Contexto:**
- E-commerce de cosmeticos
- CAC atual: R$ 85
- Meta: CAC R$ 50
- Funil: Trafego → LP → Lead → Compra

**Dados:**
- CTR: 1.8%
- LP: 12%
- Lead → Compra: 3%

---

### [DEMO AO VIVO]

**[Momento 1 - Diagnostico] (~3 min)**

> "Primeiro, diagnostico com IA..."

```
Prompt: Diagnostico de Funil

Dados:
- Visitantes: 50.000
- Cliques: 900 (CTR 1.8%)
- Leads: 108 (LP 12%)
- Compras: 3 (3%)
- CAC: R$ 85

Resposta IA:
- CTR 1.8% → OK (benchmark 1-2%)
- LP 12% → OK (benchmark 10-15%)
- Lead→Compra 3% → PROBLEMA (benchmark 5-10%)

GARGALO: Conversao Lead → Compra
```

---

**[Momento 2 - Gerar Hipoteses] (~3 min)**

> "Agora, hipoteses para o gargalo..."

```
Hipoteses geradas pela IA:
1. Sequencia de email fraca (nao gera urgencia)
2. Preco percebido alto (falta ancoragem)
3. Prova social insuficiente (sem reviews visíveis)
4. Follow-up lento (leads esfriando)
5. Oferta nao clara (confusao no checkout)
```

---

**[Momento 3 - Avaliar ICE] (~4 min)**

> "Avaliando com ICE..."

| Hipotese | I | C | E | ICE |
|----------|---|---|---|-----|
| Nova sequencia email | 8 | 7 | 6 | **7.0** |
| Adicionar ancoragem | 6 | 6 | 8 | 6.7 |
| Adicionar reviews | 7 | 8 | 7 | **7.3** |
| Acelerar follow-up | 7 | 7 | 5 | 6.3 |
| Simplificar checkout | 8 | 5 | 4 | 5.7 |

**Top 2: Reviews (7.3) + Emails (7.0)**

---

**[Momento 4 - Montar Experimentos] (~3 min)**

> "Definindo os experimentos..."

```
EXPERIMENTO 1: Adicionar Reviews
- Hipotese: +30% conversao com prova social
- Acao: Integrar Trustpilot na pagina de produto
- Metrica: Taxa Lead → Compra
- Duracao: 7 dias
- Sucesso: Taxa > 4%

EXPERIMENTO 2: Nova Sequencia Email
- Hipotese: +25% conversao com urgencia
- Acao: 5 emails com countdown + escassez
- Metrica: Taxa de abertura + conversao
- Duracao: 14 dias
- Sucesso: Open > 35%, Conversao > 4%
```

---

**[Momento 5 - Cronograma] (~2 min)**

> "Organizando no tempo..."

```
SEMANA 1:
- Dia 1-2: Implementar reviews
- Dia 3-7: Rodar experimento reviews

SEMANA 2:
- Dia 8: Analisar reviews + lancar emails
- Dia 9-14: Rodar experimento emails

SEMANA 3:
- Dia 15: Analisar ambos
- Dia 16+: Escalar o que funcionou
```

---

### Plano Final

```
┌─────────────────────────────────────────────────────────────────┐
│                 PLANO DE EXPERIMENTOS - 2 SEMANAS               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   META: CAC R$ 85 → R$ 50                                       │
│   GARGALO: Lead → Compra (3% → meta 5%+)                        │
│                                                                 │
│   EXPERIMENTO 1: Reviews (ICE 7.3)                              │
│   - Semana 1                                                    │
│   - Sucesso: Taxa > 4%                                          │
│                                                                 │
│   EXPERIMENTO 2: Emails (ICE 7.0)                               │
│   - Semana 2                                                    │
│   - Sucesso: Conversao > 4%                                     │
│                                                                 │
│   RESULTADO ESPERADO: CAC ~R$ 55-60                             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 💡 Revisao

**O Insight:**
- Diagnostico + ICE + Plano em 15 minutos. IA como seu estrategista.

---

## ⚡ ACAO RAPIDA (2 min)

**Faca agora:**
1. Anote a estrutura do plano
2. Identifique seu gargalo principal
3. Prepare dados pro exercicio

**Funcionou se:** Voce sabe como vai montar seu plano.

---

## 🎬 HOOK - Proxima Aula

> Sua vez de criar.
>
> **Proxima aula: 5.6 - Criar Seu Plano de Experimentos**

---

*Aula 5.5 - Trilha 6 - Marketing com IA e Automacoes - Academia Lendaria*
