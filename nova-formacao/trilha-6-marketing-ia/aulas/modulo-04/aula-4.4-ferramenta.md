# Aula 4.4: Make/n8n - A Central de Automacao

## Metadados

| Campo | Valor |
|-------|-------|
| **Modulo** | 4 - Automacoes do Funil |
| **Aula** | 4.4 |
| **Tipo** | Ferramenta |
| **Duracao** | 10 minutos |
| **Conceitos** | 2 (Make vs n8n + Modulos essenciais) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, voce vai conhecer os modulos essenciais do Make/n8n para automacao de funil.**

---

## 🗺️ P - POSITION (Origem)

> Make e n8n sao como LEGO de automacao.
>
> Voce conecta blocos e cria fluxos sem codigo.

---

## 🛤️ S - STEPS (Rota)

### Make vs n8n

| Criterio | Make | n8n |
|----------|------|-----|
| Facilidade | Mais facil | Mais tecnico |
| Preco | Gratis limitado, pago | Open source gratis |
| Hospedagem | Cloud | Cloud ou self-host |
| Integrações | 1000+ apps | 300+ apps |

**Recomendacao:** Comece com Make. Migre pra n8n se precisar de mais.

---

### Modulos Essenciais

| Modulo | Funcao | Exemplo |
|--------|--------|---------|
| **Webhook** | Receber dados externos | Form preenchido |
| **HTTP** | Chamar APIs | Enviar pra CRM |
| **Router** | Dividir fluxo | Score > 60? |
| **Filter** | Filtrar dados | So leads com email |
| **Set Variable** | Calcular valores | Score = 45 |
| **Google Sheets** | Salvar dados | Planilha de leads |
| **Slack/Email** | Notificar | Alerta de lead |

---

### Estrutura do Fluxo de Funil

```
[Webhook]
    ↓
[Set Variable: calcular score]
    ↓
[Google Sheets: salvar lead]
    ↓
[Router: por score]
    ↓
┌───────────────────┬──────────────────┐
│ Score < 60        │ Score >= 60      │
│       ↓           │       ↓          │
│ [Email: nurturing]│ [Slack: alerta]  │
│                   │ [Email: SDR]     │
└───────────────────┴──────────────────┘
```

---

### Dicas de Implementacao

1. **Sempre salve antes de rotear** — se der erro, voce tem o dado
2. **Use nomes claros** — "Webhook_LP_Principal" melhor que "Webhook1"
3. **Teste com dados reais** — use seu proprio email primeiro
4. **Monitore erros** — ative alertas de falha

---

## 💡 Revisao

**Os 2 Insights:**
1. **Make e mais facil, n8n e mais flexivel** — escolha por momento
2. **7 modulos cobrem 90% dos casos** — nao precisa ser expert

---

## ⚡ ACAO RAPIDA (2 min)

**Faca agora:**
1. Crie conta no Make.com
2. Explore os modulos citados
3. Crie cenario vazio com webhook

**Funcionou se:** Voce tem cenario criado no Make.

---

## 🎬 HOOK - Proxima Aula

> Na proxima: vou criar a automacao completa ao vivo.
>
> **Proxima aula: 4.5 - Automacao Captura->Qualificacao->Follow-up**

---

*Aula 4.4 - Trilha 6 - Marketing com IA e Automacoes - Academia Lendaria*
