# Aula 2.2: n8n Essencial

## Tipo: Teoria | Duracao: 15 minutos

---

## GPS

### Goal (30s)
Entender os conceitos fundamentais do n8n para criar qualquer automacao.

### Position (60s)
A primeira automacao foi simples. Agora voce vai entender a logica por tras para criar coisas mais poderosas.

### Steps
1. Anatomia de um workflow (4 min)
2. Tipos de triggers (3 min)
3. Nodes essenciais (4 min)
4. Debug e erros (4 min)

---

## Anatomia de um Workflow

```
[TRIGGER] → [NODE 1] → [NODE 2] → [NODE 3]
                ↓
           [CONDICAO]
           ↙       ↘
      [SIM]       [NAO]
```

### Componentes

| Componente | Funcao | Exemplo |
|------------|--------|---------|
| **Trigger** | Inicia o fluxo | Webhook, Schedule, Evento |
| **Node** | Executa acao | Enviar email, salvar dado |
| **Conexao** | Liga nodes | Linha entre nodes |
| **Condicao** | Decide caminho | IF/Switch |

---

## Tipos de Triggers

| Trigger | Quando Usar | Exemplo |
|---------|-------------|---------|
| **Webhook** | Evento externo | Form enviado, API chamada |
| **Schedule** | Tempo fixo | Todo dia 9h, toda segunda |
| **App Trigger** | Evento em app | Novo email, nova linha planilha |
| **Manual** | Teste | Clicar "Execute" |

### Schedule (Cron)

| Expressao | Significado |
|-----------|-------------|
| `0 9 * * *` | Todo dia as 9h |
| `0 9 * * 1` | Toda segunda as 9h |
| `*/15 * * * *` | A cada 15 minutos |
| `0 0 1 * *` | Dia 1 de cada mes |

---

## Nodes Essenciais

### Dados

| Node | Funcao |
|------|--------|
| **Set** | Define variaveis |
| **Code** | JavaScript customizado |
| **HTTP Request** | Chama APIs |
| **Merge** | Junta dados de 2 fontes |
| **Split** | Divide em varios itens |

### Logica

| Node | Funcao |
|------|--------|
| **IF** | Condicao simples (sim/nao) |
| **Switch** | Multiplas condicoes |
| **Loop** | Repete para cada item |
| **Wait** | Pausa X tempo |

### Integracoes Comuns

| Categoria | Nodes |
|-----------|-------|
| **Comunicacao** | Gmail, Slack, WhatsApp, Telegram |
| **Dados** | Google Sheets, Airtable, Supabase |
| **CRM** | HubSpot, Pipedrive, RD Station |
| **Pagamento** | Stripe, PagSeguro |
| **IA** | OpenAI, Claude, Gemini |

---

## Variaveis e Expressoes

### Acessar Dados

```javascript
// Dado do node anterior
{{ $json.campo }}

// Dado de node especifico
{{ $node["NomeDoNode"].json.campo }}

// Dado do trigger
{{ $input.first().json.email }}
```

### Expressoes Uteis

```javascript
// Data atual
{{ $now.format('yyyy-MM-dd') }}

// Texto em maiusculo
{{ $json.nome.toUpperCase() }}

// Condicao
{{ $json.valor > 100 ? "alto" : "baixo" }}
```

---

## Debug e Erros

### Como Debugar

1. **Execute manualmente**: Clique em "Execute Workflow"
2. **Veja os dados**: Clique em cada node para ver entrada/saida
3. **Pin data**: Fixe dados para testar sem trigger real

### Tratando Erros

| Configuracao | O que faz |
|--------------|-----------|
| **Continue on fail** | Continua mesmo com erro |
| **Retry on fail** | Tenta de novo X vezes |
| **Error Workflow** | Executa outro workflow se falhar |

### Erros Comuns

| Erro | Causa | Solucao |
|------|-------|---------|
| "No data" | Node anterior vazio | Verificar conexao |
| "Invalid JSON" | Formato errado | Validar dados |
| "Timeout" | API demorou | Aumentar timeout |
| "Auth failed" | Credencial errada | Reconectar conta |

---

## Boas Praticas

1. **Nomeie os nodes** - "Enviar Email Cliente" vs "Send Email"
2. **Use notas** - Explique logicas complexas
3. **Teste incrementalmente** - Node por node
4. **Salve versoes** - Antes de mudancas grandes
5. **Monitore** - Ative notificacoes de erro

---

## Checklist de Entendimento

- [ ] Sei o que e trigger, node e conexao
- [ ] Conheco os principais tipos de trigger
- [ ] Sei usar IF e Switch
- [ ] Consigo acessar dados com {{ $json }}
- [ ] Sei como debugar um workflow

---

## Proximo Passo

Agora vamos colocar em pratica: construir 3 automacoes reais.
