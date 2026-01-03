# Aula 2.3: Construindo 3 Automacoes

## Tipo: Exercicio | Duracao: 20 minutos

---

## GPS

### Goal (30s)
Construir 3 automacoes funcionais que voce pode usar no seu negocio hoje.

### Position (60s)
Uma automacao e curiosidade. Tres automacoes e sistema. Vamos construir seu primeiro sistema.

### Steps
1. Automacao 1: Captura de Lead (7 min)
2. Automacao 2: Notificacao (6 min)
3. Automacao 3: Integracao (7 min)

---

## Automacao 1: Captura de Lead

**Fluxo:** Form → Planilha + Notificacao

```
[Webhook] → [Google Sheets] → [Slack/Email]
```

### Passo a Passo

1. **Trigger: Webhook**
   - Adicione node Webhook
   - Metodo: POST
   - Copie a URL

2. **Acao 1: Google Sheets**
   - Adicione node Google Sheets
   - Operacao: Append Row
   - Conecte sua conta Google
   - Selecione planilha
   - Mapeie campos:
     - Nome: `{{ $json.nome }}`
     - Email: `{{ $json.email }}`
     - Data: `{{ $now.format('yyyy-MM-dd HH:mm') }}`

3. **Acao 2: Notificacao**
   - Adicione node Slack ou Email
   - Mensagem: "Novo lead: {{ $json.nome }} - {{ $json.email }}"

4. **Teste**
   - Use Postman ou curl:
   ```bash
   curl -X POST [SUA_URL] \
     -H "Content-Type: application/json" \
     -d '{"nome":"Teste","email":"teste@email.com"}'
   ```

---

## Automacao 2: Notificacao Agendada

**Fluxo:** Schedule → Consulta → Notificacao

```
[Schedule] → [Google Sheets] → [IF] → [Slack]
```

### Passo a Passo

1. **Trigger: Schedule**
   - Adicione node Schedule
   - Todo dia as 9h: `0 9 * * *`

2. **Consulta: Google Sheets**
   - Operacao: Read Rows
   - Filtre por status = "pendente"

3. **Condicao: IF**
   - Condicao: `{{ $json.length > 0 }}`

4. **Acao: Slack**
   - Mensagem: "Voce tem {{ $json.length }} tarefas pendentes"

---

## Automacao 3: Integracao Entre Sistemas

**Fluxo:** App A → Transformacao → App B

```
[Trigger App] → [Set] → [HTTP Request]
```

### Exemplo: Novo cliente → CRM

1. **Trigger: Google Sheets**
   - Quando nova linha e adicionada

2. **Transformacao: Set**
   - Formate os dados para o CRM:
   ```json
   {
     "name": "{{ $json.nome }}",
     "email": "{{ $json.email }}",
     "source": "planilha"
   }
   ```

3. **Acao: HTTP Request**
   - Metodo: POST
   - URL: API do seu CRM
   - Body: dados formatados

---

## Template de Documentacao

Para cada automacao, documente:

| Campo | Automacao 1 | Automacao 2 | Automacao 3 |
|-------|-------------|-------------|-------------|
| **Nome** | | | |
| **Trigger** | | | |
| **Acoes** | | | |
| **Resultado** | | | |
| **Status** | Funcionando / Erro | | |

---

## Ideias de Automacoes por Area

| Area | Automacao |
|------|-----------|
| **Vendas** | Lead → CRM → Notificacao vendedor |
| **Marketing** | Post agendado → Redes sociais |
| **Atendimento** | Ticket → Classificacao → Roteamento |
| **Financeiro** | NF emitida → Planilha → Alerta |
| **RH** | Candidato → Triagem → Email |

---

## Troubleshooting

| Problema | Solucao |
|----------|---------|
| Webhook nao recebe | Verificar se workflow esta ativo |
| Dados nao aparecem | Checar mapeamento de campos |
| Erro de autenticacao | Reconectar credenciais |
| Timeout | Aumentar limite ou otimizar |

---

## Checklist

- [ ] Automacao 1 funcionando (Captura)
- [ ] Automacao 2 funcionando (Notificacao)
- [ ] Automacao 3 funcionando (Integracao)
- [ ] Todas documentadas
- [ ] Pelo menos 1 com dados reais

---

## Proximo Passo

Validar suas automacoes e definir qual vai para producao primeiro.
