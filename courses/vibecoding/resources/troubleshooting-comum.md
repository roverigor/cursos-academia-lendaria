# Troubleshooting Comum - Soluções Rápidas

**Curso:** Vibecoding
**Objetivo:** Resolver os 20 problemas mais comuns SEM perder tempo

---

## 🎯 Como Usar Este Guia

Travou em algum erro? **CALMA!** 90% dos problemas já aconteceram com alguém antes.

**Estrutura:**
1. **Busca pelo erro** (Ctrl+F / Cmd+F)
2. **Lê a solução**
3. **Testa**
4. **Funcinou? Bora continuar!**
5. **Não funcionou? Posta no grupo com print do erro**

---

## 📑 Índice por Ferramenta

**[Claude.ai / Artifacts](#claudeai--artifacts)**
- Artifacts não aparece
- API Key inválida
- Rate limit exceeded

**[Bolt.new](#boltnew)**
- Preview não carrega
- Deploy falha
- Erro ao conectar Supabase

**[Supabase](#supabase)**
- Projeto não carrega
- Tabela não salva dados
- RLS policies bloqueiam tudo
- Erro 401 Unauthorized

**[Autenticação (Supabase Auth)](#autenticação-supabase-auth)**
- Login não funciona
- E-mail de confirmação não chega
- Redirecionamento quebra após login

**[OpenAI API](#openai-api)**
- "You exceeded your current quota"
- Assistants não respondem
- Erro 429 Rate Limit

**[Stripe](#stripe)**
- Checkout não redireciona
- Webhook não dispara
- Plano não atualiza após pagamento

**[Geral](#geral)**
- Variáveis de ambiente não carregam
- CORS errors
- Deploy funciona local mas não em produção

---

# Claude.ai / Artifacts

---

## ❌ Problema 1: "Artifacts não aparece, só texto"

**Sintomas:**
- Claude responde normalmente, mas não mostra preview interativo
- Aparece código, mas sem interface visual

**Causa:**
Claude não entendeu que você quer um preview visual.

**Solução:**

Seja **explícito** no prompt:

```
Crie um [APP/COMPONENTE] E MOSTRE NO ARTIFACTS.

[Descrição do que você quer]
```

**Exemplo:**

```
Crie um contador com botões + e - E MOSTRE NO ARTIFACTS.
```

Ou usa comando direto:

```
Mostre isso em modo Artifacts
```

---

## ❌ Problema 2: "API Key inválida"

**Sintomas:**
- Erro ao tentar integrar Anthropic API no Bolt
- "Invalid API Key" ou "Authentication failed"

**Causa:**
- Key copiada errado (espaço extra, faltou caractere)
- Usando key do ChatGPT (é OpenAI, não Anthropic!)
- Key revogada

**Solução:**

1. **Vai em:** [console.anthropic.com/settings/keys](https://console.anthropic.com/settings/keys)
2. **Revoga** a key antiga (se tiver)
3. **Cria nova:**
   - Clica em "Create Key"
   - Nome: "Vibecoding"
   - **COPIA** (sem espaços extras!)
4. **Cola no `.env.local`:**

```env
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxxxx
```

5. **Reinicia o servidor** (se tá rodando local):

```bash
npm run dev
```

---

## ❌ Problema 3: "Rate limit exceeded"

**Sintomas:**
- "You exceeded your rate limit"
- API para de responder após várias requisições

**Causa:**
Você fez muitas requisições num curto período (limite do free tier).

**Solução:**

**Curto prazo:**
- Espera 1 minuto e tenta de novo
- Reduz frequência de chamadas (não spamma requests)

**Longo prazo:**
- Adiciona crédito em [console.anthropic.com](https://console.anthropic.com)
- Tier pago tem limites maiores

---

# Bolt.new

---

## ❌ Problema 4: "Preview não carrega / tela branca"

**Sintomas:**
- Bolt gerou o código, mas preview fica em branco
- Loading infinito

**Causa:**
- Erro de sintaxe no código gerado
- Dependência faltando
- Cache travado

**Solução:**

**Passo 1:** Abre o **Console do navegador**
- No preview, clica com botão direito → **Inspecionar**
- Vai na aba **Console**
- **Tem erro vermelho?**

**Passo 2:** Mostra o erro pro Bolt:

```
O preview não carrega. Erro no console:

[COLA O ERRO AQUI]

Corrige isso.
```

**Passo 3:** Se não tem erro, força refresh:
- **Ctrl+Shift+R** (Windows/Linux)
- **Cmd+Shift+R** (Mac)

---

## ❌ Problema 5: "Deploy falha / não consigo publicar"

**Sintomas:**
- Clica em "Deploy" mas dá erro
- "Deployment failed"

**Causa:**
- Não tá logado no GitHub
- Build errors (erro de compilação)
- Limites do Vercel atingidos

**Solução:**

**1. Verifica se tá logado:**
- Olha no canto superior direito do Bolt
- Tem tua foto do GitHub? Se sim, tá logado.
- Se não, clica em "Sign in" → GitHub

**2. Lê o log de erro:**
- No modal de deploy, tem um "View logs"
- Procura a última linha com "ERROR"
- Mostra pro Bolt:

```
Deploy falhou com esse erro:

[COLA O LOG AQUI]

Como resolvo?
```

**3. Se diz "build failed":**

Pede pro Bolt:

```
Corrige os erros de build e tenta deploy novamente.
```

---

## ❌ Problema 6: "Erro ao conectar Supabase"

**Sintomas:**
- "Failed to connect to Supabase"
- Dados não salvam
- Tabelas não aparecem

**Causa:**
- URL ou key do Supabase errados
- Projeto Supabase pausado (inatividade)

**Solução:**

**1. Verifica credenciais:**

No Supabase, vai em **Settings** → **API**

Confirma:
- **Project URL:** `https://xxxxxx.supabase.co`
- **anon public key:** `eyJhbGciOi...` (key longa!)

**2. No Bolt, verifica `.env.local`:**

```env
VITE_SUPABASE_URL=https://xxxxxx.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOi...
```

**Atenção:**
- **Prefixo:** Em Vite (Bolt usa isso), variáveis precisam começar com `VITE_`
- **Sem espaços** antes ou depois do `=`
- **Sem aspas** ao redor dos valores

**3. Reinicia o dev server:**

No terminal do Bolt (se tiver acesso), ou clica em "Restart" no preview.

**4. Projeto pausado?**

Vai no dashboard do Supabase. Se o projeto tiver pausado (ícone de pause), clica em **"Resume"**.

---

# Supabase

---

## ❌ Problema 7: "Projeto não carrega / travado em 'Setting up'"

**Sintomas:**
- Criou projeto, mas fica eternamente em "Setting up your project"
- Dashboard não abre

**Causa:**
- Servidor sobrecarregado (raro)
- Problema temporário de rede

**Solução:**

**1. Espera 2-3 minutos** (sério! Às vezes demora)

**2. Recarrega a página** (Ctrl+R / Cmd+R)

**3. Se após 5 min não carregou:**
- Abre em **navegador incógnito**
- Ou troca de navegador (ex: Chrome → Firefox)

**4. Ainda não funciona?**
- Deleta o projeto (ícone de lixeira)
- Cria novamente (com nome diferente)

---

## ❌ Problema 8: "Tabela não salva dados / INSERT não funciona"

**Sintomas:**
- Executa `INSERT` no SQL Editor, diz "Success", mas tabela tá vazia
- Form no app envia dados, mas não aparecem no Supabase

**Causa:**
**RLS (Row Level Security)** tá bloqueando inserts.

**Solução:**

**Opção 1: Desabilita RLS (só pra testes!)**

```sql
ALTER TABLE nome_da_tabela DISABLE ROW LEVEL SECURITY;
```

**⚠️ CUIDADO:** Isso deixa a tabela pública. **NÃO faz isso em produção.**

---

**Opção 2: Cria policy que permite inserts (recomendado):**

```sql
CREATE POLICY "Allow public inserts" ON nome_da_tabela
FOR INSERT TO anon, authenticated
WITH CHECK (true);
```

**Explica:**
- **anon:** Usuários não logados
- **authenticated:** Usuários logados
- **WITH CHECK (true):** Permite qualquer insert

---

**Opção 3: Policy só pra usuário logado:**

```sql
CREATE POLICY "Users can insert their own data" ON nome_da_tabela
FOR INSERT TO authenticated
WITH CHECK (auth.uid() = user_id);
```

**Explica:**
- Só usuários logados podem inserir
- E só se o `user_id` na tabela bater com `auth.uid()` (ID do usuário logado)

---

## ❌ Problema 9: "RLS policies bloqueiam TUDO"

**Sintomas:**
- Criou policies, mas nada funciona
- Erro "new row violates row-level security policy"

**Causa:**
Policies muito restritivas ou configuradas errado.

**Solução Rápida (DEBUG):**

**1. Desabilita RLS temporariamente:**

```sql
ALTER TABLE nome_da_tabela DISABLE ROW LEVEL SECURITY;
```

**2. Testa se os dados salvam.**

**3. Se salvar:** Problema era nas policies. Recria elas.

**4. Reabilita RLS:**

```sql
ALTER TABLE nome_da_tabela ENABLE ROW LEVEL SECURITY;
```

**5. Cria policies corretas** (ver Problema 8).

---

## ❌ Problema 10: "Erro 401 Unauthorized"

**Sintomas:**
- Requisições do app pro Supabase retornam 401
- Console mostra "Failed to fetch" ou "Unauthorized"

**Causa:**
- `anon key` errada
- Token de autenticação expirado
- Policy exige `authenticated`, mas usuário não tá logado

**Solução:**

**1. Verifica a `anon key`:**

Supabase → **Settings** → **API** → **anon public**

Compara com a key no `.env.local` do Bolt. Tem que ser **IDÊNTICA**.

**2. Se tá usando auth:**

Verifica se o usuário TÁ LOGADO antes de fazer a request:

```javascript
const { data: user } = await supabase.auth.getUser();
if (!user) {
  console.log("Usuário não logado!");
  // Redireciona pra /login
}
```

**3. Policy exige autenticação?**

Se a policy é assim:

```sql
FOR SELECT TO authenticated
```

E você tenta acessar SEM estar logado → 401.

**Solução:** Ou faz login, ou muda policy pra `anon`.

---

# Autenticação (Supabase Auth)

---

## ❌ Problema 11: "Login não funciona / 'Invalid credentials'"

**Sintomas:**
- Digita e-mail e senha corretos, mas dá "Invalid login credentials"

**Causa:**
- Senha errada (óbvio, mas acontece!)
- E-mail não confirmado
- Usuário não existe

**Solução:**

**1. Confirma que o usuário EXISTE:**

Supabase → **Authentication** → **Users**

Procura o e-mail. Tá lá?

**2. E-mail confirmado?**

Na lista de usuários, olha a coluna **"Confirmed"**.

- Se tá ✅ → Confirmado
- Se tá ❌ → **NÃO confirmado** (precisa confirmar via e-mail)

**Como forçar confirmação (pra testes):**

Na lista de users, clica no usuário → **Options** → **Confirm email**

---

**3. Senha errada?**

Reseta a senha:

```javascript
await supabase.auth.resetPasswordForEmail('email@example.com');
```

Usuário recebe e-mail com link de reset.

---

## ❌ Problema 12: "E-mail de confirmação não chega"

**Sintomas:**
- Cadastrou, mas e-mail de confirmação não chegou
- Caixa de entrada vazia

**Causa:**
- E-mail foi pra **spam**
- Provedor de e-mail bloqueou (ex: alguns e-mails corporativos)
- Config de SMTP não tá configurada (Supabase free usa SMTP genérico)

**Solução:**

**1. OLHA NO SPAM!** (90% das vezes tá lá)

**2. Confirma manualmente (pra testes):**

Supabase → **Authentication** → **Users** → Clica no user → **Confirm email**

**3. Testa com outro e-mail:**
- Gmail costuma funcionar melhor
- Evita e-mails corporativos com filtros agressivos

---

## ❌ Problema 13: "Redirecionamento quebra após login"

**Sintomas:**
- Login funciona, mas não redireciona pro dashboard
- Fica na tela de login ou vai pra página errada

**Causa:**
- Redirect URL não configurada
- Lógica de redirecionamento no código tá errada

**Solução:**

**1. Verifica redirect no Supabase:**

Supabase → **Authentication** → **URL Configuration**

**Site URL:** `https://seu-app.bolt.new` (ou domínio custom)
**Redirect URLs:** Adiciona:
```
https://seu-app.bolt.new/dashboard
https://seu-app.bolt.new/*
```

**2. No código (Bolt), pede pro Bolt:**

```
Após login bem-sucedido, redirecione o usuário para /dashboard.

Código atual de login:

[COLA O CÓDIGO DA FUNÇÃO DE LOGIN]

Adiciona o redirect.
```

**Exemplo de código correto:**

```javascript
const { data, error } = await supabase.auth.signInWithPassword({
  email,
  password
});

if (error) {
  console.error(error);
} else {
  window.location.href = '/dashboard'; // ← Redirect!
}
```

---

# OpenAI API

---

## ❌ Problema 14: "You exceeded your current quota"

**Sintomas:**
- Erro ao tentar usar OpenAI API
- "You exceeded your current quota, please check your plan and billing details"

**Causa:**
**Você não tem crédito** na conta OpenAI.

**Solução:**

**1. Adiciona crédito:**

Vai em: [platform.openai.com/account/billing](https://platform.openai.com/account/billing)

Clica em **"Add payment method"** → Adiciona cartão → Compra **$5** (mínimo)

**2. Verifica se o crédito entrou:**

Na mesma página, olha "Balance". Deve mostrar `$5.00`.

**3. Tenta de novo.**

---

## ❌ Problema 15: "Assistants não respondem / Timeout"

**Sintomas:**
- Chat do Assistant fica carregando infinitamente
- Timeout error
- No response após 30s+

**Causa:**
- Assistant travado processando
- Thread ID errado
- Prompt muito complexo

**Solução:**

**1. Recria a thread (conversa):**

No código, ao invés de reusar a mesma thread, cria nova:

```javascript
const thread = await openai.beta.threads.create();
```

**2. Simplifica o prompt:**

Se o Assistant tá tentando processar algo muito complexo (ex: "analisa 50 páginas"), quebra em partes menores.

**3. Aumenta timeout:**

No fetch (se tá usando custom):

```javascript
fetch(url, {
  timeout: 60000 // 60 segundos
})
```

---

## ❌ Problema 16: "Erro 429 Rate Limit"

**Sintomas:**
- "Rate limit exceeded"
- Depois de algumas requisições, para de funcionar

**Causa:**
Muitas requisições num curto período (limite de RPM - requests per minute).

**Solução:**

**1. Adiciona delay entre requests:**

```javascript
await new Promise(resolve => setTimeout(resolve, 1000)); // 1 segundo
```

**2. Implementa retry com backoff:**

```javascript
async function callOpenAI() {
  let retries = 3;
  while (retries > 0) {
    try {
      return await openai.chat.completions.create({...});
    } catch (error) {
      if (error.status === 429) {
        retries--;
        await new Promise(resolve => setTimeout(resolve, 2000)); // Espera 2s
      } else {
        throw error;
      }
    }
  }
}
```

**3. Upgrade pra tier maior** (se precisar de mais RPM):

Platform OpenAI → **Settings** → **Limits** → Vê teu limite atual.

---

# Stripe

---

## ❌ Problema 17: "Checkout não redireciona após pagamento"

**Sintomas:**
- Pagamento processa, mas fica na tela do Stripe
- Não volta pro app

**Causa:**
**Success URL** e **Cancel URL** não configuradas.

**Solução:**

No código do Stripe Checkout, garante que tem:

```javascript
const session = await stripe.checkout.sessions.create({
  // ... outros parâmetros
  success_url: 'https://seu-app.bolt.new/dashboard?success=true',
  cancel_url: 'https://seu-app.bolt.new/pricing?canceled=true',
});
```

**Importante:**
- URLs **COMPLETAS** (com `https://`)
- Query params (`?success=true`) ajudam a mostrar mensagem de sucesso

---

## ❌ Problema 18: "Webhook não dispara"

**Sintomas:**
- Pagamento funciona, mas plano do usuário não atualiza no Supabase
- Webhook nunca é chamado

**Causa:**
- Webhook URL não configurada no Stripe
- Endpoint não existe ou retorna erro
- Assinatura de webhook (signing secret) errada

**Solução:**

**1. Configura o webhook no Stripe:**

Stripe Dashboard → **Developers** → **Webhooks** → **Add endpoint**

**Endpoint URL:** `https://seu-app.bolt.new/api/stripe-webhook`

**Events to send:**
- `checkout.session.completed`
- `invoice.payment_succeeded`
- `customer.subscription.deleted`

**2. Copia o Signing Secret:**

Após criar o webhook, Stripe mostra um **"Signing secret"** (começa com `whsec_`).

**COPIA** e põe no `.env.local`:

```env
STRIPE_WEBHOOK_SECRET=whsec_xxxxxxxxxxxxxx
```

**3. Testa o webhook:**

Stripe tem ferramenta de teste:

**Developers** → **Webhooks** → Clica no teu webhook → **Send test webhook**

Escolhe evento: `checkout.session.completed`

Se retornar **200 OK** → Tá funcionando! ✅

---

## ❌ Problema 19: "Plano não atualiza no Supabase após pagamento"

**Sintomas:**
- Webhook dispara (vê no log do Stripe), mas plano no Supabase continua "free"

**Causa:**
- Lógica do webhook não atualiza o Supabase
- E-mail do cliente não bate com e-mail no Supabase

**Solução:**

**1. Verifica log do webhook:**

No código do endpoint `/api/stripe-webhook`, adiciona logs:

```javascript
export async function POST(req) {
  const event = // ... verifica assinatura

  console.log('Webhook recebido:', event.type);

  if (event.type === 'checkout.session.completed') {
    const session = event.data.object;
    console.log('E-mail do cliente:', session.customer_email);

    // Atualiza Supabase
    const { data, error } = await supabase
      .from('users')
      .update({ plan: 'pro' })
      .eq('email', session.customer_email);

    console.log('Update Supabase:', data, error);
  }

  return new Response(JSON.stringify({ received: true }), { status: 200 });
}
```

**2. Testa novamente** e olha os logs.

**3. E-mail não bate?**

Certifica que o e-mail usado no checkout é o **MESMO** cadastrado no Supabase.

---

# Geral

---

## ❌ Problema 20: "Variáveis de ambiente não carregam"

**Sintomas:**
- `.env.local` preenchido, mas app não vê as variáveis
- `undefined` quando tenta acessar `process.env.X`

**Causa:**
- Servidor não reiniciou após adicionar `.env`
- Variáveis sem prefixo `VITE_` (se usando Vite/Bolt)
- Arquivo `.env` no lugar errado

**Solução:**

**1. Prefixo `VITE_`:**

Em Bolt (usa Vite), variáveis **públicas** precisam de prefixo:

```env
VITE_SUPABASE_URL=https://...
VITE_SUPABASE_ANON_KEY=eyJ...
```

**2. Reinicia o servidor:**

Se tá rodando `npm run dev`, mata (Ctrl+C) e roda de novo.

**3. Verifica localização do `.env`:**

Deve estar na **raiz do projeto**, não dentro de `src/` ou `public/`.

---

## ❌ Problema 21: "CORS errors"

**Sintomas:**
- Console mostra: "Access to fetch at '...' has been blocked by CORS policy"
- Requisições de API falham

**Causa:**
Backend (API) não permite requisições do teu frontend (domínio diferente).

**Solução:**

**No Supabase:**
- CORS já tá configurado por padrão. Se dá erro, verifica se a `anon key` tá certa.

**Se tiver API própria:**

Adiciona headers CORS:

```javascript
export async function GET(req) {
  return new Response(JSON.stringify({ data: '...' }), {
    status: 200,
    headers: {
      'Access-Control-Allow-Origin': '*', // ou domínio específico
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization'
    }
  });
}
```

---

## ❌ Problema 22: "App funciona localmente mas quebra em produção"

**Sintomas:**
- `npm run dev` funciona
- Deploy no Vercel/Bolt funciona, mas app não funciona (tela branca, erros)

**Causa:**
- Variáveis de ambiente não configuradas no Vercel
- Build errors ignorados localmente
- Hardcoded `localhost` no código

**Solução:**

**1. Configura variáveis no Vercel:**

Vercel Dashboard → Teu projeto → **Settings** → **Environment Variables**

Adiciona **TODAS** as variáveis do `.env.local`:

```
VITE_SUPABASE_URL
VITE_SUPABASE_ANON_KEY
VITE_OPENAI_API_KEY
etc.
```

**2. Redeploy:**

Após adicionar variáveis, faz novo deploy (ou clica em "Redeploy" no Vercel).

**3. Procura `localhost` no código:**

Busca por "localhost" ou "127.0.0.1" no código. Se encontrar, substitui por variável de ambiente ou URL de produção.

---

## 🚨 Ainda Não Resolveu?

Se nenhuma dessas soluções funcionou:

**1. Posta no grupo do curso com:**
- [ ] Qual o erro exato (mensagem completa)
- [ ] Print da tela (ou do console)
- [ ] O que você já tentou
- [ ] Qual lesson você tá fazendo

**2. Copia o erro completo:**

Console do navegador:
- Clica com botão direito na página → **Inspecionar** → Aba **Console**
- Print de **TODO** o erro (não só a primeira linha)

**3. Verifica status das plataformas:**

Às vezes o problema não é com você!

- Supabase Status: [status.supabase.com](https://status.supabase.com)
- OpenAI Status: [status.openai.com](https://status.openai.com)
- Vercel Status: [www.vercel-status.com](https://www.vercel-status.com)

Se tiver incidente, é só esperar resolverem.

---

## 💡 Dicas Gerais de Debug

**"O erro tá te dizendo o que tá errado. Aprende a ler ele."**

Eu sei, mensagens de erro são CHATAS. Mas elas quase sempre têm a resposta.

**Exemplo:**

```
Error: Invalid API key provided
```

**O erro TÁ FALANDO:** "Sua API key tá errada."

**Solução:** Verifica a key.

---

**Fluxo de debug:**

1. **Lê o erro** (por completo, não só o começo)
2. **Googla o erro** (literalmente copia e cola no Google)
3. **Testa a solução mais comum** (geralmente é reiniciar, verificar credenciais, ou limpar cache)
4. **Se não resolver:** Posta no grupo

**90% dos problemas se resolvem nos passos 1-3.**

---

**Criado por:** José Carlos Amorim
**Atualizado em:** 2025
**Versão:** 1.0

---

*Troubleshooting Guide | Vibecoding Course*
