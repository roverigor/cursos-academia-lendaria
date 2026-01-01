# Template: Workflow de Automacao

## Trilha 6 - Marketing com IA | Modulo 4

---

## Instrucoes de Uso

1. Escolha o tipo de automacao
2. Mapeie o fluxo
3. Configure na ferramenta (Make/n8n)
4. Teste antes de ativar
5. Monitore e otimize

---

## 1. TIPOS DE AUTOMACAO

### Automacoes Essenciais

| Tipo | Descricao | Prioridade |
|------|-----------|------------|
| Lead Capture | Capturar lead → CRM → Notificacao | Alta |
| Welcome | Novo lead → Email/WhatsApp boas-vindas | Alta |
| Follow-up | Lead nao converteu → Sequencia | Alta |
| Nurturing | Envio periodico de conteudo | Media |
| Reengajamento | Lead frio → Campanha de reativacao | Media |

---

## 2. FLUXO: LEAD CAPTURE

### Visao Geral

```
[TRIGGER]              [ACOES]                    [RESULTADO]
─────────              ───────                    ──────────
Form LP     ──────►    Criar lead CRM   ──────►   Lead no CRM
  ou                   Enviar WhatsApp            + Boas-vindas
API Ads                Notificar vendedor         + Notificacao
```

### Configuracao Detalhada

| Etapa | Ferramenta | Configuracao |
|-------|------------|--------------|
| **Trigger** | Webhook | URL: ___ |
| **Criar Lead** | CRM | Campos: nome, email, telefone, origem |
| **Enviar WhatsApp** | Evolution API | Template: boas-vindas |
| **Notificar** | Slack/Email | Canal: #leads |

### Campos do Lead

| Campo | Obrigatorio | Exemplo |
|-------|-------------|---------|
| nome | Sim | |
| email | Sim | |
| telefone | Sim | |
| origem | Sim | meta_ads, google, organico |
| utm_source | Nao | |
| utm_campaign | Nao | |
| data_captura | Auto | |

---

## 3. FLUXO: WELCOME SEQUENCE

### Visao Geral

```
[TRIGGER]           [SEQUENCIA]                   [RESULTADO]
─────────           ───────────                   ──────────
Novo Lead  ──────►  Msg 1 (imediato)   ──────►   Lead aquecido
                    Msg 2 (+1h)                  + pronto para
                    Msg 3 (+24h)                   contato
                    Msg 4 (+48h)
                    Msg 5 (+72h)
```

### Configuracao de Delays

| Mensagem | Delay | Canal | Conteudo |
|----------|-------|-------|----------|
| 1 | 0 min | WhatsApp | Boas-vindas + entrega |
| 2 | 1h | WhatsApp | Dica de valor |
| 3 | 24h | WhatsApp | Prova social |
| 4 | 48h | WhatsApp | Quebra de objecao |
| 5 | 72h | WhatsApp | CTA final |

---

## 4. FLUXO: FOLLOW-UP AUTOMATICO

### Visao Geral

```
[TRIGGER]              [CONDICAO]              [ACAO]
─────────              ──────────              ─────
Lead criado  ──────►   Nao converteu  ──────►  Sequencia
ha X dias              em 7 dias               follow-up

Lead respondeu ──────► Interesse  ──────►      Notificar vendedor
                       detectado
```

### Regras de Follow-up

| Situacao | Tempo | Acao |
|----------|-------|------|
| Lead novo, sem resposta | 24h | Msg de check-in |
| Lead respondeu com duvida | Imediato | Notificar vendedor |
| Lead nao converteu | 7 dias | Sequencia reengajamento |
| Lead disse "nao agora" | 30 dias | Msg de retorno |

---

## 5. TEMPLATE MAKE/N8N

### Estrutura JSON (n8n)

```json
{
  "name": "Lead Capture Flow",
  "nodes": [
    {
      "name": "Webhook",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "httpMethod": "POST",
        "path": "lead-capture"
      }
    },
    {
      "name": "Criar Lead CRM",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "method": "POST",
        "url": "{{$env.CRM_API}}/leads",
        "body": {
          "nome": "={{$json.nome}}",
          "email": "={{$json.email}}",
          "telefone": "={{$json.telefone}}"
        }
      }
    },
    {
      "name": "Enviar WhatsApp",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "method": "POST",
        "url": "{{$env.EVOLUTION_API}}/message/send",
        "body": {
          "number": "={{$json.telefone}}",
          "text": "Oi {{$json.nome}}! Bem-vindo..."
        }
      }
    }
  ]
}
```

---

## 6. CHECKLIST DE CONFIGURACAO

### Pre-Setup

- [ ] Conta Make/n8n criada
- [ ] API do CRM configurada
- [ ] Evolution API (WhatsApp) ativa
- [ ] Webhooks testados

### Por Fluxo

| Fluxo | Criado | Testado | Ativo |
|-------|--------|---------|-------|
| Lead Capture | ✅ ❌ | ✅ ❌ | ✅ ❌ |
| Welcome | ✅ ❌ | ✅ ❌ | ✅ ❌ |
| Follow-up | ✅ ❌ | ✅ ❌ | ✅ ❌ |
| Nurturing | ✅ ❌ | ✅ ❌ | ✅ ❌ |
| Reengajamento | ✅ ❌ | ✅ ❌ | ✅ ❌ |

---

## 7. METRICAS DE AUTOMACAO

### Dashboard

| Metrica | Semana 1 | Semana 2 | Semana 3 | Semana 4 |
|---------|----------|----------|----------|----------|
| Leads capturados | | | | |
| Msgs enviadas | | | | |
| Taxa entrega | | | | |
| Taxa resposta | | | | |
| Leads qualificados | | | | |
| Erros/falhas | | | | |

### Benchmarks

| Metrica | Meta | Atencao | Critico |
|---------|------|---------|---------|
| Taxa entrega WhatsApp | > 95% | < 90% | < 80% |
| Taxa abertura email | > 20% | < 15% | < 10% |
| Taxa resposta | > 10% | < 5% | < 2% |

---

## 8. TROUBLESHOOTING

### Problemas Comuns

| Problema | Causa Provavel | Solucao |
|----------|----------------|---------|
| Lead nao chega no CRM | Webhook mal configurado | Testar URL, verificar payload |
| WhatsApp nao envia | Numero invalido ou API offline | Validar formato do numero |
| Delay nao funciona | Configuracao de timer | Verificar unidade (min/h/d) |
| Duplicidade | Falta de verificacao | Adicionar check de email unico |

---

## 9. PROMPT DE IA PARA CRIAR FLUXO

```
Me ajude a criar automacao de marketing:

OBJETIVO: ___

TRIGGER: ___
(ex: form preenchido, lead criado, tag adicionada)

ACOES DESEJADAS:
1. ___
2. ___
3. ___

FERRAMENTAS:
- CRM: ___
- WhatsApp: ___
- Email: ___
- Automacao: Make / n8n

CONDICOES/REGRAS:
- ___
- ___

Gere:
1. Fluxograma visual (em texto)
2. Passo a passo de configuracao
3. Mensagens/templates necessarios
4. Metricas para acompanhar
```

---

## 10. SEGURANCA E BOAS PRATICAS

### Regras

- [ ] Nao armazenar senhas em nodes (usar variaveis de ambiente)
- [ ] Limitar tentativas de retry (max 3)
- [ ] Logar erros para debug
- [ ] Backup dos fluxos (exportar JSON)
- [ ] Testar em ambiente separado antes de produzir

### LGPD

- [ ] Consentimento para WhatsApp
- [ ] Opcao de opt-out em todas as msgs
- [ ] Dados armazenados com seguranca
- [ ] Politica de privacidade atualizada

---

## 11. CHECKLIST DE VALIDACAO

- [ ] Fluxo principal funcionando
- [ ] Todas as mensagens criadas
- [ ] Delays configurados corretamente
- [ ] Notificacoes ativas
- [ ] Metricas sendo coletadas
- [ ] Backup do fluxo exportado

---

## 12. COMPROMISSO 48H

**Meu compromisso:**

- [ ] Configurar fluxo de Lead Capture
- [ ] Testar com lead de teste
- [ ] Ativar em producao

**Ferramenta escolhida:** Make / n8n
**Status:** ___

---

**Template versao:** 1.0
**Trilha:** Marketing com IA
**Modulo:** 4 - Automacao
