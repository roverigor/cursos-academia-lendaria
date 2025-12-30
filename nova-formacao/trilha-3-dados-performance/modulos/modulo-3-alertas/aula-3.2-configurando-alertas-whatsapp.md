# Aula 3.2: Configurando Alertas no WhatsApp

## Metadados da Aula

| Campo | Valor |
|-------|-------|
| **Módulo** | 3 - Alertas Inteligentes |
| **Aula** | 3.2 |
| **Tipo** | Prática (hands-on) |
| **Duração** | 60 minutos |
| **Formato** | Screencast + Demonstração |
| **Entregável** | 3-5 alertas configurados no WhatsApp |

---

## Objetivos da Aula

Ao final desta aula, o aluno terá:
1. n8n funcionando (hospedado ou local)
2. Conexão WhatsApp configurada
3. 3-5 alertas ativos e testados
4. Mensagens de alerta formatadas

---

## Materiais Necessários

- [ ] Template: modulo-3-alertas.md
- [ ] Conta Render ou Railway (para hospedar n8n)
- [ ] Celular com WhatsApp (número dedicado para alertas)
- [ ] Planilha do Dashboard (Módulo 2)

---

## Roteiro de Fala

### ABERTURA (3 min)

**[TELA: n8n dashboard]**

> "Hora de colocar os alertas pra funcionar."
>
> "Nesta aula, você vai sair com pelo menos 1 alerta funcionando no WhatsApp. Se tiver tempo e disposição, faz os 5."
>
> "Vou fazer ao vivo com você. Minha tela, meus erros, meus acertos."
>
> "Antes de começar, uma escolha importante:"
>
> "Se você quer a opção GRÁTIS: vamos usar n8n + Evolution API"
> "Se você quer a opção FÁCIL: pode usar n8n + Z-API (R$ 50-100/mês)"
> "Se você quer a opção SEM HOSPEDAR: pode usar Make (R$ 50-200/mês)"
>
> "Eu vou demonstrar com n8n + Evolution API. Mas a lógica é a mesma pra qualquer opção."

---

### PARTE 1: CONFIGURANDO O N8N (15 min)

**[TELA: Render.com]**

> "Primeiro: colocar o n8n no ar."
>
> "Você tem duas opções:"
> "1. Rodar localmente (mais fácil pra testar)"
> "2. Hospedar na nuvem (pra funcionar 24/7)"
>
> "Vou mostrar a hospedagem no Render, porque você quer que os alertas funcionem mesmo quando seu computador está desligado."

#### Passo 1: Criar conta no Render (3 min)

**[TELA: Render signup]**

> "Acessa render.com"
> "Cria conta com Google ou GitHub"
> "É grátis pra começar"
>
> [Demonstração ao vivo]

#### Passo 2: Deploy do n8n (7 min)

**[TELA: Render dashboard]**

> "Agora vamos subir o n8n:"
>
> "1. Clica em 'New' → 'Web Service'"
> "2. Escolhe 'Deploy an existing image from a registry'"
> "3. Image URL: docker.n8n.io/n8nio/n8n"
> "4. Nome: meu-n8n"
> "5. Instance Type: Free (pra começar)"
>
> [Demonstração ao vivo]
>
> "Vai demorar uns 2-3 minutos pra subir. Enquanto isso..."

**[SLIDE: "Variáveis de Ambiente"]**

> "Precisa configurar algumas variáveis de ambiente:"
>
> "N8N_BASIC_AUTH_ACTIVE: true"
> "N8N_BASIC_AUTH_USER: admin"
> "N8N_BASIC_AUTH_PASSWORD: [sua senha]"
>
> [Demonstração adicionando variáveis]

#### Passo 3: Acessar n8n (5 min)

**[TELA: n8n login]**

> "Depois que subiu, acessa a URL que o Render te deu."
> "Faz login com usuário e senha que você definiu."
> "Você está dentro do n8n!"
>
> [Demonstração]
>
> "Se você prefere rodar localmente primeiro pra testar, pode baixar o n8n desktop ou usar Docker no seu computador."

**[PAUSA PARA ALUNO]**

> "Se você está acompanhando, pausa aqui e coloca seu n8n no ar."
> "Pode demorar até 5 minutos. Volta quando estiver funcionando."
>
> [PAUSA: 5 minutos]

---

### PARTE 2: CONECTANDO WHATSAPP (15 min)

**[TELA: Evolution API]**

> "Agora vamos conectar o WhatsApp."
>
> "Existem várias formas de fazer isso. Vou mostrar com Evolution API porque é grátis."

#### Opção A: Evolution API (Grátis)

**[TELA: Deploy Evolution API]**

> "Evolution API é um projeto open source que conecta WhatsApp."
>
> "Você pode hospedar no mesmo Render:"
>
> "1. Novo Web Service"
> "2. Image: atendai/evolution-api"
> "3. Configurar variáveis de ambiente"
>
> [Demonstração das configurações]
>
> "Depois de subir, você conecta o n8n com Evolution API."

#### No n8n: Configurar Credencial

**[TELA: n8n credentials]**

> "Volta pro n8n:"
>
> "1. Vai em Settings → Credentials"
> "2. Adiciona nova credencial"
> "3. Escolhe 'HTTP Request' (pra conectar com Evolution API)"
> "4. Configura a URL e token da Evolution API"
>
> [Demonstração]

#### Conectar WhatsApp

**[TELA: QR Code]**

> "Agora precisa escanear o QR Code com o WhatsApp que vai enviar os alertas."
>
> "IMPORTANTE: use um número DEDICADO pra alertas. Não use seu número pessoal."
>
> "Por quê? Porque se der problema, você pode resetar sem perder suas conversas."
>
> [Demonstração escaneando QR]

**[PAUSA PARA ALUNO]**

> "Se você está usando Evolution API, pausa aqui e configura."
> "Se preferir Z-API (mais fácil), vai em z-api.io, cria conta, e copia o token."
>
> [PAUSA: 5 minutos]

---

### PARTE 3: CRIANDO O PRIMEIRO ALERTA (20 min)

**[TELA: n8n workflow vazio]**

> "Agora vem a parte boa: criar o alerta."
>
> "Vamos fazer o alerta mais básico: 'Se faturamento do dia for menor que X, me avisa'."

#### Passo 1: Trigger (5 min)

**[TELA: Schedule Trigger]**

> "Todo alerta precisa de um TRIGGER — o que dispara a verificação."
>
> "Clica em '+' → 'Schedule Trigger'"
>
> "Configura:"
> "- Trigger Times: Every hour (ou Every day às 18h)"
> "- Mode: At Regular Intervals"
>
> "Isso significa: a cada hora, o n8n vai checar se precisa mandar alerta."
>
> [Demonstração]

#### Passo 2: Ler Dados (5 min)

**[TELA: Google Sheets node]**

> "Próximo passo: buscar os dados da sua planilha."
>
> "Clica em '+' → 'Google Sheets'"
>
> "Configura:"
> "- Operation: Read Rows"
> "- Spreadsheet: [sua planilha do dashboard]"
> "- Sheet: [aba com dados]"
>
> [Demonstração conectando Google Sheets]
>
> "Agora o n8n consegue ler seus dados automaticamente."

#### Passo 3: Condição (5 min)

**[TELA: IF node]**

> "Agora a lógica: SE faturamento < X, ENTÃO manda alerta."
>
> "Clica em '+' → 'IF'"
>
> "Configura:"
> "- Condition: Number"
> "- Value 1: {{$json.faturamento}} (seu campo)"
> "- Operation: Smaller"
> "- Value 2: 3000 (seu limite)"
>
> [Demonstração]
>
> "Se a condição for verdadeira, segue pro próximo nó. Se não, para aqui."

#### Passo 4: Enviar WhatsApp (5 min)

**[TELA: HTTP Request node]**

> "Último passo: mandar a mensagem."
>
> "Clica em '+' → 'HTTP Request'"
>
> "Configura:"
> "- Method: POST"
> "- URL: [URL da Evolution API]/message/sendText/[instância]"
> "- Body:"

```json
{
  "number": "5511999999999",
  "text": "🔴 ALERTA: Faturamento hoje R$ {{$json.faturamento}} (abaixo do esperado)"
}
```

> [Demonstração]
>
> "Pronto! Seu primeiro alerta está configurado."

---

### PARTE 4: TESTANDO E ADICIONANDO MAIS (7 min)

**[TELA: Workflow completo]**

> "Vamos testar:"
>
> "Clica em 'Execute Workflow'"
> "Se tudo der certo, você recebe a mensagem no WhatsApp."
>
> [Demonstração do teste]

**[TELA: Mensagem recebida no WhatsApp]**

> "Olha aqui: a mensagem chegou!"
>
> "Agora você pode adicionar mais alertas seguindo a mesma lógica."

**[SLIDE: "Seus 5 Alertas"]**

> "Use o template do Módulo 3 pra configurar os 5 tipos:"
>
> "1. Limite Crítico: Faturamento < X"
> "2. Tendência: 3 dias de queda"
> "3. Anomalia: Churn > 50% acima da média"
> "4. Oportunidade: Lead quente sem contato há 48h"
> "5. Meta em Risco: Dia 15 e < 40% da meta"
>
> "Não precisa fazer todos agora. Começa com 2-3 e vai adicionando."

---

### FECHAMENTO (0 min - transição)

**[TELA: Workflow funcionando]**

> "Se você chegou até aqui, agora você tem:"
>
> "✅ n8n funcionando 24/7"
> "✅ WhatsApp conectado"
> "✅ Pelo menos 1 alerta ativo"
>
> "A partir de agora, você não precisa mais lembrar de checar o dashboard."
> "Os problemas vêm até você."

**[SLIDE: "Mas e se..."]**

> "Mas e quando o alerta chega — o que você faz?"
>
> "'Faturamento caiu 30%' — e agora?"
>
> "Você precisa de um ANALISTA pra interpretar os dados e sugerir ações."
>
> "A boa notícia: você não precisa contratar um. Você pode usar IA."
>
> "No Módulo 4, vamos criar seu Analista de Dados com IA. R$ 100/mês. Disponível 24/7. Nunca reclama."
>
> "Te vejo lá."

---

## Timestamps para Edição

| Tempo | Conteúdo |
|-------|----------|
| 0:00-3:00 | Abertura + escolha de ferramenta |
| 3:00-18:00 | Configurando n8n |
| 18:00-33:00 | Conectando WhatsApp |
| 33:00-53:00 | Criando primeiro alerta |
| 53:00-60:00 | Testando + fechamento |

---

## Alternativas por Ferramenta

### Se usar Z-API (mais fácil)

- Criar conta em z-api.io
- Copiar Instance ID e Token
- No n8n, usar HTTP Request com URL: `https://api.z-api.io/instances/INSTANCE/token/TOKEN/send-text`
- Body mais simples, menos configuração

### Se usar Make (sem hospedar)

- Criar conta em make.com
- Criar Scenario
- Módulos: Google Sheets → Filter → WhatsApp Business
- Interface visual, arrasta e solta

---

## Troubleshooting Comum

| Problema | Solução |
|----------|---------|
| n8n não sobe no Render | Verificar variáveis de ambiente |
| QR Code não aparece | Reiniciar Evolution API |
| Mensagem não chega | Verificar número (com código do país) |
| Erro no HTTP Request | Verificar URL e headers |
| Workflow não executa | Verificar trigger schedule |

---

## Notas de Produção

### Formato
- Screencast com câmera pequena
- Telas reais (não mockups)
- Erros reais e como resolver

### Pausas
- Pausas generosas para aluno configurar
- "Pausa aqui se precisar"
- Mostrar onde cada parte demora mais

### Erros Propositais
- Mostrar um erro comum (token errado, URL errada)
- Explicar como debugar
- "Isso acontece, veja como resolver"

---

## Entregável do Módulo

**O que o aluno deve ter ao final:**

1. n8n funcionando (cloud ou local)
2. Conexão WhatsApp configurada
3. Pelo menos 1 alerta ativo e testado
4. Template de mensagem configurado

**Critério de conclusão:**
- Básico: 1 alerta funcionando
- Completo: 3-5 alertas + mensagens formatadas

---

*Roteiro Aula 3.2 - Trilha 3*
*Academia Lendária*
