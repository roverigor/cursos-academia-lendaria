# Aula 3.5: Configurando Seu Primeiro Alerta

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 3 - Alertas Inteligentes |
| **Aula** | 3.5 |
| **Tipo** | Demo |
| **Duração** | 15 minutos |
| **Conceitos** | 2 (Configuração n8n + Disparo WhatsApp) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter visto o passo a passo completo de configurar um alerta — do zero ao recebimento no WhatsApp.**
>
> Você vai saber exatamente o que fazer na sua vez.

---

## 🗺️ P - POSITION (Origem)

> "Parece complicado..."
>
> Eu sei que olhar uma ferramenta nova assusta.
>
> Mas vou fazer na tela, passo a passo.
>
> Você só precisa assistir e entender a lógica.
>
> Na próxima aula, você faz a sua versão.

---

## 🛤️ S - STEPS (Rota)

### O Que Vamos Criar

**Alerta simples:**
> "Se faturamento diário < R$1.000, me avise no WhatsApp."

**Componentes:**
1. Fonte de dados (Google Sheets)
2. Verificação (n8n)
3. Envio (Evolution API → WhatsApp)

---

### Passo 1: Configurando a Fonte de Dados

**No Google Sheets:**
1. Tenha uma planilha com coluna "Faturamento" e "Data"
2. Anote o ID da planilha (URL depois de /d/)
3. Certifique-se que os dados estão atualizados

```
[DIAGRAMA: Planilha Exemplo]

┌─────────────────────────────────────────────┐
│         📊 Planilha de Dados                │
├──────────┬──────────────┬───────────────────┤
│   Data   │  Faturamento │      Status       │
├──────────┼──────────────┼───────────────────┤
│ 01/01    │   R$ 1.500   │      ✅ OK        │
│ 02/01    │   R$ 800     │   ⚠️ ALERTA!     │
│ 03/01    │   R$ 2.100   │      ✅ OK        │
└──────────┴──────────────┴───────────────────┘
                    │
                    ▼
              n8n verifica
```

---

### Passo 2: Criando o Workflow no n8n

**Acesse n8n.io e crie novo workflow.**

**Nó 1: Trigger (Quando executar)**
- Escolha: Schedule Trigger
- Configure: Todo dia às 9h
- Ou: A cada hora

**Nó 2: Google Sheets (Buscar dados)**
- Conecte sua conta Google
- Selecione a planilha
- Escolha a aba e range

**Nó 3: IF (Verificar condição)**
- Condição: Se faturamento < 1000
- True: Continua pro próximo nó
- False: Para aqui (não faz nada)

**Nó 4: HTTP Request (Enviar WhatsApp)**
- Método: POST
- URL: Sua Evolution API
- Body: Mensagem de alerta

```
[DIAGRAMA: Workflow n8n]

┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   ⏰ TRIGGER │───▶│ 📊 SHEETS   │───▶│  ❓ IF      │───▶│  📱 WHATSAPP │
│  (Todo dia)  │    │ (Busca dado) │    │ (Verifica)  │    │  (Envia)     │
└──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
                                               │
                                         < R$1K?
                                               │
                                        ┌──────┴──────┐
                                       SIM           NÃO
                                        │             │
                                        ▼             ▼
                                   Envia msg      Não faz nada
```

---

### Passo 3: Configurando a Mensagem

**Formato da mensagem:**

```
🚨 ALERTA DE FATURAMENTO

📅 Data: {{data}}
💰 Faturamento: R$ {{valor}}
⚠️ Abaixo do mínimo (R$ 1.000)

Ação recomendada: Verificar vendas do dia.
```

**No n8n:**
- Use variáveis entre {{ }} para dados dinâmicos
- Data e valor vêm do Google Sheets

---

### Passo 4: Testando o Alerta

**Teste manual:**
1. Clique em "Execute Workflow"
2. Veja cada nó executar
3. Verifique se a mensagem chegou

**Teste de condição:**
1. Coloque um valor < R$1.000 na planilha
2. Execute o workflow
3. Confirme que o alerta disparou

**Teste negativo:**
1. Coloque um valor > R$1.000
2. Execute novamente
3. Confirme que NÃO disparou

---

### Passo 5: Ativando o Agendamento

**No n8n:**
1. Clique em "Active" (canto superior direito)
2. O workflow agora roda automaticamente
3. Todo dia às 9h ele verifica

**Confirmação:**
- Workflow ativo = botão verde
- Verifica no horário configurado
- Você não precisa fazer nada

---

### 🤔 Pergunta Reflexiva

> "Você conseguiu acompanhar a lógica?"
>
> Trigger → Busca → Verifica → Envia (se necessário)
>
> Na próxima aula, você vai fazer o seu próprio.

---

### Resumo Visual

```
[DIAGRAMA: Fluxo Completo]

     CONFIGURAÇÃO (uma vez)
            │
            ▼
    ┌───────────────┐
    │ Planilha OK   │
    │ n8n conectado │
    │ Evolution API │
    └───────┬───────┘
            │
            ▼
     EXECUÇÃO (diária)
            │
            ▼
    ┌───────────────┐
    │   9h: Trigger │
    │   ↓           │
    │   Busca dado  │
    │   ↓           │
    │   Verifica    │───── > R$1K? → Nada
    │   ↓           │
    │   < R$1K?     │
    │   ↓           │
    │   📱 WhatsApp │
    └───────────────┘
```

---

## 💡 Revisão

**Os 2 Insights:**

1. **4 nós = 1 alerta completo** — Trigger → Busca → Verifica → Envia. Simples assim.

2. **Teste antes de ativar** — Sempre simule com valores altos e baixos pra garantir que funciona.

**A Transformação:**
- **Antes:** "Não sei nem por onde começar"
- **Depois:** "Sei exatamente os 4 passos"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Reveja o diagrama do workflow
2. Anote: Trigger → Sheets → IF → WhatsApp
3. Se tiver conta no n8n, abra e explore a interface

**Funcionou se:** Você consegue explicar o fluxo pra alguém.

---

## 🎬 HOOK - Próxima Aula

> Você viu como funciona.
>
> Agora é sua vez.
>
> Na próxima aula, você vai configurar 3 alertas — um de cada tipo (Crise, Tendência, Meta).
>
> Vou te guiar passo a passo.
>
> **Próxima aula: 3.6 - Seu Turno: Configure 3 Alertas**

---

*Aula 3.5 - Trilha 3 - Academia Lendária*
