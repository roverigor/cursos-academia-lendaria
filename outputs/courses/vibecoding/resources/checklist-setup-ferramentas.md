# Checklist: Setup Completo de Ferramentas

**Curso:** Vibecoding
**Tempo Estimado:** 30-45 minutos
**Objetivo:** Ter todas as contas criadas e configuradas ANTES de começar o curso

---

## 🎯 Por Que Fazer Isso Agora?

Olha só, nada pior do que tá no meio da aula, empolgado pra criar um app, e ter que parar pra criar conta, confirmar e-mail, adicionar cartão...

Essa preparação evita **interrupções** e te deixa focado 100% no aprendizado.

Vem comigo, vamos configurar tudo em meia hora!

---

## ✅ Checklist Rápida (Marque Conforme Completa)

### **Essenciais (Obrigatórias)**
- [ ] Claude.ai (grátis)
- [ ] Bolt.new (grátis)
- [ ] Supabase (grátis)
- [ ] GitHub (grátis)

### **Para Módulo 3 (MicroSaaS)**
- [ ] OpenAI Platform (precisa adicionar $5 mínimo)
- [ ] Stripe (grátis, modo teste)

---

## 1️⃣ Claude.ai (Artifacts)

**O que é:** IA da Anthropic que cria apps em tempo real (protótipos).

**Usado em:** Lesson 1.2 (Mapa da Clareza)

---

### **Passo a Passo:**

1. **Acessa:** [claude.ai](https://claude.ai)

2. **Clica em "Sign Up"**

3. **Duas opções:**
   - Login com Google (mais rápido)
   - Login com e-mail

4. **Confirma e-mail** (se escolheu e-mail)

5. **IMPORTANTE:** Pega a **API Key**
   - Vai em: [console.anthropic.com](https://console.anthropic.com)
   - Clica em **"Get API Keys"**
   - Clica em **"Create Key"**
   - Dá um nome: "Vibecoding"
   - **COPIA** (você só vê uma vez!)
   - Cola num arquivo de texto seguro (vamos usar depois)

---

### **O Que Testar Agora:**

Pergunta pro Claude:

```
Crie um contador simples em React com botões + e - e um display mostrando o número.
```

Se aparecer um preview interativo com botões funcionando → **Tá pronto!** ✅

---

### **Troubleshooting:**

**Problema:** "Não aparece o preview, só texto."

**Solução:**
- Pede explicitamente: "Me mostre no Artifacts"
- Ou usa o comando: "Crie um app visual"

---

## 2️⃣ Bolt.new (Lovable)

**O que é:** IDE no-code que cria apps full-stack e publica online.

**Usado em:** Lessons 2.1, 2.2, 2.3, 3.1, 3.2

---

### **Passo a Passo:**

1. **Acessa:** [bolt.new](https://bolt.new)

2. **Clica em "Start Building"**

3. **Login:**
   - Login com GitHub (RECOMENDADO - facilita deploy)
   - Ou login com Google

4. **Autoriza acesso** (se escolheu GitHub)

5. **Pronto!** Interface aberta.

---

### **O Que Testar Agora:**

No chat do Bolt, digita:

```
Crie uma landing page para um curso de IA.
Inclua header, hero section com título "Aprenda IA em 30 Dias", e botão "Começar Agora".
```

Espera 1-2 min.

**Resultado esperado:** Preview ao vivo de uma landing page funcional.

---

### **Troubleshooting:**

**Problema:** "Erro ao carregar preview."

**Solução:**
- Recarrega a página (Ctrl+R / Cmd+R)
- Se persistir, tenta em navegador incógnito

---

## 3️⃣ Supabase

**O que é:** Backend-as-a-Service (banco de dados + auth + storage).

**Usado em:** Lessons 2.2, 2.3, 3.1, 3.2

---

### **Passo a Passo:**

1. **Acessa:** [supabase.com](https://supabase.com)

2. **Clica em "Start your project"**

3. **Login com GitHub** (RECOMENDADO)

4. **Cria Nova Organização:**
   - Nome: "Vibecoding" (ou teu nome)
   - Plano: **Free** (suficiente pro curso!)

5. **Cria Novo Projeto:**
   - Nome do projeto: `vibecoding-hub` (ou outro)
   - Database Password: **Cria uma senha FORTE** e **SALVA** (vai precisar!)
   - Região: **South America (São Paulo)** (mais rápido pra você)

6. **Espera 2 min** (projeto sendo criado)

7. **PEGA AS CREDENCIAIS:**
   - Vai em **Settings** → **API**
   - **COPIA E SALVA:**
     - **Project URL** (tipo: `https://abc123.supabase.co`)
     - **anon public key** (começa com `eyJ...`)

Cola num arquivo de texto seguro.

---

### **O Que Testar Agora:**

1. Vai em **Table Editor** (menu lateral)
2. Clica em **"Create a new table"**
3. Nome: `test`
4. Adiciona coluna:
   - Nome: `name`
   - Type: `text`
5. Clica em **Save**

**Se a tabela apareceu** → **Tá pronto!** ✅

Pode apagar essa tabela teste depois (botão de lixeira).

---

### **Troubleshooting:**

**Problema:** "Projeto não carrega."

**Solução:**
- Espera mais 2-3 min (às vezes demora)
- Recarrega a página

---

## 4️⃣ GitHub

**O que é:** Plataforma de versionamento de código (vai usar pra login no Bolt).

**Usado em:** Integração com Bolt.new

---

### **Passo a Passo:**

1. **Acessa:** [github.com](https://github.com)

2. **Clica em "Sign up"**

3. **Preenche:**
   - E-mail
   - Senha
   - Username (escolhe algo profissional, tipo: `jose-dev`)

4. **Verifica e-mail**

5. **Pula as perguntas iniciais** (pode responder depois)

6. **Pronto!**

---

### **O Que Testar Agora:**

Vai em: [github.com/settings/profile](https://github.com/settings/profile)

**Se abriu tua página de perfil** → **Tá pronto!** ✅

---

## 5️⃣ OpenAI Platform (Para Módulo 3)

**O que é:** API pra integrar GPT-4 e Assistants nos apps.

**Usado em:** Lesson 3.1 (Hub de GPTs)

---

### **Passo a Passo:**

1. **Acessa:** [platform.openai.com](https://platform.openai.com)

2. **Clica em "Sign up"** (ou "Log in" se já tem conta ChatGPT)

3. **Login:**
   - Pode usar mesma conta do ChatGPT
   - Ou criar nova

4. **IMPORTANTE: Adiciona Crédito**
   - Vai em: [platform.openai.com/account/billing](https://platform.openai.com/account/billing)
   - Clica em **"Add payment method"**
   - Adiciona cartão
   - Compra **$5** de crédito (mínimo)
   - **Por quê?** API só funciona com crédito. $5 dura MUITO (centenas de requests).

5. **PEGA A API KEY:**
   - Vai em: [platform.openai.com/api-keys](https://platform.openai.com/api-keys)
   - Clica em **"Create new secret key"**
   - Nome: "Vibecoding Hub"
   - **COPIA** (você só vê uma vez!)
   - Cola num arquivo seguro

---

### **O Que Testar Agora:**

1. Vai em: [platform.openai.com/playground](https://platform.openai.com/playground)
2. Digita: "Oi, tudo bem?"
3. Clica em **Submit**

**Se o GPT respondeu** → **Tá pronto!** ✅

---

### **Troubleshooting:**

**Problema:** "You exceeded your current quota."

**Solução:**
- Você não adicionou crédito ainda.
- Vai em Billing e adiciona $5.

---

## 6️⃣ Stripe (Para Módulo 3)

**O que é:** Plataforma de pagamentos online (assinaturas, checkout).

**Usado em:** Lesson 3.1 (pagamento recorrente do MicroSaaS)

---

### **Passo a Passo:**

1. **Acessa:** [stripe.com](https://stripe.com)

2. **Clica em "Sign up"**

3. **Preenche:**
   - E-mail
   - Nome completo
   - Senha

4. **Verifica e-mail**

5. **Pula as perguntas de setup** (pode responder depois)

6. **ATIVA O MODO TESTE:**
   - No dashboard, tem um botão **"Test mode"** (canto superior direito)
   - **DEIXA ATIVADO** durante o curso (não vai processar pagamentos reais)

7. **PEGA AS API KEYS (Modo Teste):**
   - Vai em: **Developers** → **API Keys**
   - **COPIA E SALVA:**
     - **Publishable key** (começa com `pk_test_...`)
     - **Secret key** (começa com `sk_test_...` - clica em "Reveal")

Cola num arquivo seguro.

---

### **O Que Testar Agora:**

1. Vai em **Products** (menu lateral)
2. Clica em **"Add product"**
3. Preenche:
   - Name: "Teste"
   - Price: R$ 10
   - Recurring: Monthly
4. Clica em **Save**

**Se o produto foi criado** → **Tá pronto!** ✅

Pode apagar esse produto teste depois.

---

### **Troubleshooting:**

**Problema:** "Não acho o modo teste."

**Solução:**
- Olha no canto superior direito do dashboard.
- Tem um switch escrito "Test mode" / "Live mode".
- Clica até ficar em **Test mode**.

---

## 🎉 Checklist Final: Tá Tudo Pronto?

Antes de começar o curso, confirma que você tem:

### **Credenciais Essenciais Salvas:**
- [ ] Claude.ai API Key
- [ ] Supabase Project URL
- [ ] Supabase anon key
- [ ] OpenAI API Key (se for fazer Módulo 3)
- [ ] Stripe Publishable key (modo teste)
- [ ] Stripe Secret key (modo teste)

### **Contas Acessíveis:**
- [ ] Consigo logar no Claude.ai
- [ ] Consigo logar no Bolt.new
- [ ] Consigo logar no Supabase
- [ ] Consigo logar no GitHub
- [ ] Consigo logar no OpenAI Platform
- [ ] Consigo logar no Stripe

### **Testei Funcionalidades Básicas:**
- [ ] Claude gerou um app no Artifacts
- [ ] Bolt gerou um preview de landing page
- [ ] Supabase criou uma tabela teste
- [ ] OpenAI Playground respondeu (se aplicável)
- [ ] Stripe criou um produto teste (se aplicável)

---

## 📝 Template de Credenciais (Salve Esse Arquivo!)

Copia isso e preenche com TEUS dados. Salva como `credenciais-vibecoding.txt` (num lugar seguro, NÃO compartilha!):

```
=== CREDENCIAIS VIBECODING ===

CLAUDE.AI
API Key: sk-ant-xxxxxxxx

SUPABASE
Project URL: https://xxxxxx.supabase.co
Anon Key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.xxxxxx
Database Password: xxxxxxxx

OPENAI
API Key: sk-xxxxxxxxxxxxxxxx

STRIPE (MODO TESTE)
Publishable Key: pk_test_xxxxxxxx
Secret Key: sk_test_xxxxxxxx

GITHUB
Username: seu-username
```

---

## 🚨 Segurança: NÃO FAÇA ISSO!

- ❌ **NÃO** compartilha API Keys publicamente
- ❌ **NÃO** commita credenciais no GitHub (usa `.env` ou `.env.local`)
- ❌ **NÃO** põe credenciais em prints de tela
- ❌ **NÃO** usa as mesmas senhas em todas as contas

**Se você acidentalmente expôs uma key:**
1. Vai na plataforma (ex: Supabase, OpenAI)
2. **Revoke** (revoga) a key antiga
3. Cria uma nova

---

## 💰 Custos (Transparência Total)

Aqui tá EXATAMENTE quanto você vai gastar:

| Ferramenta | Custo no Curso | Custo Mensal em Produção |
|------------|----------------|--------------------------|
| Claude.ai | **R$ 0** (Free tier suficiente) | R$ 0-100 (só se usar muito) |
| Bolt.new | **R$ 0** (Free tier suficiente) | R$ 0-150 (se quiser domínio custom) |
| Supabase | **R$ 0** (Free tier: 500MB DB + 50k usuários) | R$ 0-100 (só se passar limites) |
| GitHub | **R$ 0** | R$ 0 |
| OpenAI | **~R$ 25** ($5 inicial) | R$ 50-200 (depende de uso) |
| Stripe | **R$ 0** (modo teste) | 3,99% + R$ 0,39 por transação |

**TOTAL PRA FAZER O CURSO:** ~R$ 25 (só os $5 da OpenAI)

**TOTAL PRA RODAR UM MICROSAAS EM PRODUÇÃO:** R$ 50-200/mês (dependendo de tráfego)

---

## 🎓 Pronto! Agora é Só Começar o Curso!

Marcou tudo? Salvou as credenciais?

**SHOW! Você tá preparado!**

Agora vai lá na **Lesson 1.1** e bora criar apps! 🚀

---

**Dúvida ou travou em algum setup?**

Posta no grupo/fórum do curso com:
1. Qual ferramenta
2. Qual o erro (print se possível)
3. O que você já tentou

A galera (e eu) ajuda rapidinho!

---

**Criado por:** José Carlos Amorim
**Atualizado em:** 2025
**Versão:** 1.0

---

*Checklist de Setup | Vibecoding Course*
