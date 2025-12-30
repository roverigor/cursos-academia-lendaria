# Template: Alertas Inteligentes

## Instruções de Uso

1. Preencha os 5 alertas críticos para seu negócio
2. Configure os triggers no n8n
3. Conecte ao WhatsApp via Evolution API ou Z-API
4. Teste cada alerta com uma simulação
5. Defina responsável para cada alerta

---

## Passo 1: Defina seus 5 Alertas Críticos

### Alerta 1: Limite Crítico de Faturamento

| Campo | Preencha |
|-------|----------|
| **Nome do Alerta** | Faturamento Diário Baixo |
| **Métrica** | Faturamento do dia |
| **Trigger** | Se < R$ _______ (60% da média diária) |
| **Frequência de Verificação** | Todo dia às _____h |
| **Canal** | ⬜ WhatsApp ⬜ Email ⬜ Slack |
| **Quem Recebe** | |
| **Mensagem** | 🔴 ALERTA: Faturamento hoje R$ [X] (abaixo do esperado) |
| **Ação Imediata** | |

### Alerta 2: Tendência Negativa

| Campo | Preencha |
|-------|----------|
| **Nome do Alerta** | Tendência de Queda |
| **Métrica** | |
| **Trigger** | Se _____ dias seguidos de queda |
| **Frequência de Verificação** | Diário |
| **Canal** | ⬜ WhatsApp ⬜ Email ⬜ Slack |
| **Quem Recebe** | |
| **Mensagem** | 🟡 ATENÇÃO: [X] dias de queda consecutiva em [métrica] |
| **Ação Imediata** | |

### Alerta 3: Anomalia

| Campo | Preencha |
|-------|----------|
| **Nome do Alerta** | |
| **Métrica** | |
| **Trigger** | Se > _____% acima/abaixo do normal |
| **Frequência de Verificação** | |
| **Canal** | ⬜ WhatsApp ⬜ Email ⬜ Slack |
| **Quem Recebe** | |
| **Mensagem** | ⚠️ ANOMALIA: [métrica] em [X] (normal seria [Y]) |
| **Ação Imediata** | |

### Alerta 4: Oportunidade

| Campo | Preencha |
|-------|----------|
| **Nome do Alerta** | |
| **Métrica** | |
| **Trigger** | Se [condição positiva] por mais de _____ |
| **Frequência de Verificação** | |
| **Canal** | ⬜ WhatsApp ⬜ Email ⬜ Slack |
| **Quem Recebe** | |
| **Mensagem** | 🔥 OPORTUNIDADE: [descrição] |
| **Ação Imediata** | |

### Alerta 5: Prazo/Meta em Risco

| Campo | Preencha |
|-------|----------|
| **Nome do Alerta** | Meta em Risco |
| **Métrica** | % da meta atingida |
| **Trigger** | Se dia _____ do mês e < _____% da meta |
| **Frequência de Verificação** | Dia específico |
| **Canal** | ⬜ WhatsApp ⬜ Email ⬜ Slack |
| **Quem Recebe** | |
| **Mensagem** | 🎯 META EM RISCO: [X]% atingido, faltam [Y] dias |
| **Ação Imediata** | |

---

## Passo 2: Resumo dos Alertas

| # | Nome | Trigger | Canal | Responsável |
|---|------|---------|-------|-------------|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |

---

## Passo 3: Configuração Técnica

### Opção A: n8n + Evolution API (Gratuito)

**Pré-requisitos:**
- Conta no [Render](https://render.com) ou [Railway](https://railway.app)
- WhatsApp com número dedicado para alertas
- Planilha Google Sheets com dados

**Fluxo no n8n:**

```
[Trigger: Schedule]
      │
      ▼
[Google Sheets: Ler dados]
      │
      ▼
[IF: Condição do alerta]
      │
      ├── TRUE ──▶ [Evolution API: Enviar WhatsApp]
      │
      └── FALSE ─▶ [Fim]
```

**Configuração do Schedule Trigger:**
```json
{
  "rule": {
    "interval": [{"field": "hours", "value": 1}]
  }
}
```

**Configuração do IF (exemplo faturamento):**
```json
{
  "conditions": {
    "number": [
      {
        "value1": "={{$json.faturamento_hoje}}",
        "operation": "smaller",
        "value2": 3000
      }
    ]
  }
}
```

**Configuração do Evolution API:**
```json
{
  "number": "5511999999999",
  "text": "🔴 ALERTA: Faturamento hoje R$ {{$json.faturamento_hoje}} (abaixo do esperado)"
}
```

### Opção B: n8n + Z-API (Pago, mais fácil)

**Pré-requisitos:**
- Conta Z-API (R$ 50-100/mês)
- Token da API

**Configuração Z-API no n8n:**
```json
{
  "method": "POST",
  "url": "https://api.z-api.io/instances/SUA_INSTANCIA/token/SEU_TOKEN/send-text",
  "body": {
    "phone": "5511999999999",
    "message": "🔴 ALERTA: Faturamento hoje R$ {{$json.faturamento_hoje}}"
  }
}
```

### Opção C: Make (Integromat) - Sem hospedar

1. Criar conta em [make.com](https://make.com)
2. Criar Scenario
3. Adicionar módulos:
   - Google Sheets → Watch Rows
   - Filter → Condição
   - WhatsApp Business → Send Message

---

## Passo 4: Templates de Mensagem

### Mensagem de Limite Crítico
```
🔴 ALERTA URGENTE

📊 Métrica: Faturamento Diário
📉 Valor Atual: R$ 2.100
📍 Esperado: R$ 3.500
⚠️ Status: 40% ABAIXO

🔍 Ação Sugerida:
• Verificar vendas do dia
• Checar se há pedidos travados
• Analisar funil de vendas

👤 Responsável: @nome
⏰ Verificado: 20:00
```

### Mensagem de Tendência
```
🟡 ATENÇÃO: TENDÊNCIA NEGATIVA

📊 Métrica: Leads Diários
📉 Situação: 3 dias consecutivos de queda
📈 Dia 1: 15 leads
📉 Dia 2: 12 leads
📉 Dia 3: 8 leads

🔍 Ação Sugerida:
• Revisar campanhas ativas
• Verificar orçamento de mídia
• Analisar qualidade do tráfego

👤 Responsável: @nome
```

### Mensagem de Anomalia
```
⚠️ ANOMALIA DETECTADA

📊 Métrica: Taxa de Churn
📈 Valor Atual: 6%
📍 Valor Normal: 3%
⚡ Variação: +100%

🔍 Ação Sugerida:
• Listar cancelamentos da semana
• Identificar padrão comum
• Contato imediato com CS

👤 Responsável: @nome
```

### Mensagem de Oportunidade
```
🔥 OPORTUNIDADE DETECTADA

📊 Lead Quente Parado
👤 Nome: João Silva
⭐ Score: 85/100
⏰ Sem contato há: 48 horas

🔍 Ação Sugerida:
• Contato imediato
• Priorizar na fila

👤 SDR Responsável: @nome
📞 Telefone: (11) 99999-9999
```

### Mensagem de Meta em Risco
```
🎯 META EM RISCO

📊 Faturamento Mensal
📍 Meta: R$ 100.000
📈 Atingido: R$ 65.000 (65%)
📅 Dia do mês: 20/30
⏰ Faltam: 10 dias

📉 Para bater a meta:
• Precisa faturar R$ 3.500/dia
• Ou fechar [X] vendas

🔍 Ação Sugerida:
• Reunião emergencial de vendas
• Revisar pipeline
• Ações de recuperação

👤 Reunião agendada: Amanhã 9h
```

---

## Passo 5: Planilha de Monitoramento

### Estrutura da Aba "Alertas_Log"

| Data/Hora | Alerta | Valor | Trigger | Notificado | Ação Tomada | Resultado |
|-----------|--------|-------|---------|------------|-------------|-----------|
| 15/01 20:00 | Faturamento Baixo | R$ 2.100 | <R$ 3.000 | João | Ligou para 3 clientes | 1 venda fechada |
| 16/01 09:00 | Lead Quente | Score 85 | >80 há 48h | Maria | Enviou proposta | Aguardando |
| ... | ... | ... | ... | ... | ... | ... |

---

## Prompt IA: Definir Alertas

```
Minhas métricas principais do dashboard:
[Lista as métricas]

Meus maiores problemas que já tive por descobrir tarde:
[Lista 3-5 situações]

Meu canal preferido de notificação: [WhatsApp/Email/Slack]

Me ajude a criar 5 alertas críticos:

Para cada alerta:
1. Nome claro e objetivo
2. Trigger específico (condição numérica exata)
3. Frequência de verificação ideal
4. Mensagem formatada com emojis
5. Ação imediata sugerida
6. Prioridade (crítico/importante/informativo)

Considere:
- Alertas de limite (valor mínimo/máximo)
- Alertas de tendência (X dias seguidos)
- Alertas de anomalia (fora do padrão)
- Alertas de oportunidade (ação positiva)
- Alertas de prazo (meta em risco)
```

---

## Checklist de Validação

- [ ] Defini 5 alertas com triggers claros
- [ ] Cada alerta tem responsável definido
- [ ] Mensagens estão formatadas e claras
- [ ] Ações sugeridas são específicas
- [ ] n8n (ou alternativa) está configurado
- [ ] WhatsApp está conectado
- [ ] Testei cada alerta com simulação
- [ ] Log de alertas está funcionando

---

## Troubleshooting Comum

| Problema | Solução |
|----------|---------|
| Alerta não dispara | Verificar trigger, testar condição manualmente |
| WhatsApp não recebe | Verificar token da API, testar conexão |
| Muitos alertas (spam) | Ajustar thresholds, adicionar cooldown |
| Alerta atrasado | Verificar schedule do n8n |
| Erro no n8n | Ver logs de execução, verificar credenciais |

---

## Próxima Ação (48h)

**Tarefa:** Ter pelo menos 1 alerta funcionando no WhatsApp

**Qual alerta vou configurar primeiro?** ______________________

**Até quando?** ______________________

---

*Template Trilha 3 - Módulo 3*
*Academia Lendária*
