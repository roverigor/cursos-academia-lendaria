# MÓDULO 13: EDGE FUNCTIONS - SEU MINI-BACKEND INVISÍVEL

**Duração Total:** 78 minutos  
**Aulas:** 6  
**Nível de Bloom's:** Apply → Analyze → Create  
**Objetivo do Módulo:** Eliminar a dependência de desenvolvedores para integrações e lógica complexa

---

## VISÃO GERAL DO MÓDULO

**Transformação:**
- ANTES: "Preciso de um dev para integrar com Stripe/enviar email/processar dados"
- DEPOIS: "Consigo criar qualquer integração sozinho em 30 minutos"

**Anti-Impostor Check:** 
"Se você consegue copiar e colar, você consegue criar Edge Functions. É sério."

---

## ESTRUTURA DETALHADA DAS AULAS

### 13.1 - Edge Functions: Seu Garçom Digital Que Nunca Dorme (10 min)
**Bloom's Level:** Understand (2)  
**Hook:** "Sabe quando você pede comida no app e em segundos o restaurante recebe? Tem um 'garçom digital' fazendo isso. Hoje você vai contratar o seu."

**Metáfora Principal:**
- Edge Function = Garçom digital
- Sempre disponível (24/7)
- Entende vários "idiomas" (APIs)
- Entrega mensagens entre serviços
- Não precisa de gorjeta

**Conceitos-Chave:**
1. **Serverless** = "Você não gerencia o restaurante, só treina o garçom"
2. **Edge** = "Ele está em todos os lugares ao mesmo tempo"
3. **TypeScript** = "JavaScript com gramática melhor (mas você nem vai escrever)"

**Desmistificação:**
- "Mas eu não sei programar!" → "Você vai copiar, colar e trocar 3 palavras"
- "TypeScript é difícil!" → "É JavaScript fantasiado. Ignore a fantasia"
- "Parece complexo!" → "WhatsApp também parecia. Olha você agora"

**Quando Usar:**
- ✅ Receber pagamento do Stripe → Atualizar banco
- ✅ Novo cadastro → Enviar email de boas-vindas  
- ✅ Upload de imagem → Redimensionar automaticamente
- ✅ Chamar ChatGPT → Responder cliente
- ❌ Operações simples de banco (use triggers)

**Checkpoint Emocional:**
"Se você chegou até aqui no curso, Edge Functions é só mais uma ferramenta na sua caixa. Respira."

---

### 13.2 - Criando Edge Function em 5 Cliques (Sério, Contei) (12 min)
**Bloom's Level:** Apply (3)  
**Hook:** "Vamos criar sua primeira Edge Function sem escrever UMA linha de código. Cronômetro na mão?"

**Passo a Passo Visual:**
1. **Dashboard → Edge Functions → New Function**
2. **Escolher Template:** "Hello World" 
3. **Nome:** minha-primeira-function
4. **Deploy** (sim, já acabou)
5. **Testar** no próprio dashboard

**A Mágica do Dashboard:**
```typescript
// ISTO JÁ VEM PRONTO - NÃO PRECISA ENTENDER AINDA
Deno.serve(async (req) => {
  const { name } = await req.json()
  return new Response(
    JSON.stringify({ message: `Olá ${name}!` }),
    { headers: { "Content-Type": "application/json" } }
  )
})
```

**Exercício Guiado:**
- Modificar mensagem (trocar "Olá" por "Bem-vindo")
- Testar com seu nome
- Ver logs em tempo real

**Templates Disponíveis:**
1. Stripe Webhook (pagamentos)
2. Send Email (Resend/SendGrid)
3. OpenAI Integration
4. Image Processing
5. Scheduled Tasks

**Anti-Impostor Moment:**
"Você acabou de fazer deploy de código TypeScript para 29 regiões globais. Quando foi que você virou dev? 😏"

**Troubleshooting Preventivo:**
- Erro 500? → Check dos logs (botão View Logs)
- Não funciona? → Verify das variáveis de ambiente
- Demora? → Normal na primeira execução (cold start)

---

### 13.3 - Variáveis de Ambiente: O Cofre dos Seus Segredos (8 min)
**Bloom's Level:** Apply (3)  
**Hook:** "Você não escreve sua senha do banco no espelho do banheiro, né? Então..."

**Metáfora do Cofre:**
- Variáveis de ambiente = Cofre digital
- API Keys = Joias valiosas
- Edge Functions = Só sabem a combinação

**Setup Prático:**
1. **Settings → Edge Functions → Secrets**
2. **Adicionar:**
   - OPENAI_API_KEY = sk-...
   - RESEND_API_KEY = re_...
   - STRIPE_WEBHOOK_SECRET = whsec_...

**Como Usar no Código:**
```typescript
// ANTES (PÉSSIMO - NUNCA FAÇA)
const apiKey = "sk-proj-12345" // 🚨 PERIGO

// DEPOIS (PERFEITO)
const apiKey = Deno.env.get("OPENAI_API_KEY") // ✅ SEGURO
```

**Regra de Ouro:**
"Se tem 'key', 'secret', 'password' ou 'token' no nome, VAI PRO COFRE."

**Checklist de Segurança:**
- [ ] Nunca commitar keys no código
- [ ] Sempre usar variáveis de ambiente
- [ ] Diferentes keys para dev/prod
- [ ] Rotacionar keys periodicamente

---

### 13.4 - Integrando com OpenAI: Seu Clone IA em 15 Minutos (15 min)
**Bloom's Level:** Apply (3)  
**Hook:** "ChatGPT que responde com o conhecimento da SUA empresa? Bora criar."

**Template Pronto para Copiar:**
```typescript
// edge-function: responder-cliente

import { createClient } from '@supabase/supabase-js'

Deno.serve(async (req) => {
  // 1. Recebe pergunta do cliente
  const { pergunta } = await req.json()
  
  // 2. Busca contexto no seu banco
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  )
  
  const { data: contexto } = await supabase
    .from('conhecimento_empresa')
    .select('*')
    .textSearch('conteudo', pergunta)
    .limit(3)
  
  // 3. Monta prompt com seu contexto
  const prompt = `
    Você é assistente da empresa XYZ.
    Use este conhecimento: ${JSON.stringify(contexto)}
    Pergunta do cliente: ${pergunta}
    Responda de forma útil e precisa.
  `
  
  // 4. Chama OpenAI
  const response = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${Deno.env.get('OPENAI_API_KEY')}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: 'gpt-3.5-turbo',
      messages: [{ role: 'user', content: prompt }],
      max_tokens: 500
    })
  })
  
  const data = await response.json()
  
  // 5. Retorna resposta
  return new Response(
    JSON.stringify({ 
      resposta: data.choices[0].message.content 
    }),
    { headers: { "Content-Type": "application/json" } }
  )
})
```

**O Que Modificar:**
1. Nome da tabela ('conhecimento_empresa' → sua tabela)
2. Prompt (adicione personalidade da marca)
3. Modelo GPT (3.5 = barato, 4 = inteligente)

**Custo Real:**
- GPT-3.5: ~R$ 0,01 por resposta
- GPT-4: ~R$ 0,10 por resposta
- Cliente feliz: Não tem preço

**Exercício:**
"Configure para responder como se fosse você. Teste 3 perguntas sobre seu negócio."

---

### 13.5 - Webhook do Stripe: Dinheiro Caindo na Conta (15 min)
**Bloom's Level:** Analyze (4)  
**Hook:** "Cliente pagou. Em 2 segundos, sistema atualizado. Sem você mover um dedo. Vamos?"

**O Fluxo do Dinheiro:**
1. Cliente paga no Stripe
2. Stripe avisa sua Edge Function
3. Function valida pagamento
4. Atualiza status no Supabase
5. Cliente recebe acesso

**Template Webhook Stripe:**
```typescript
// edge-function: stripe-webhook

import { createClient } from '@supabase/supabase-js'
import { Stripe } from 'https://esm.sh/stripe@12.0.0'

Deno.serve(async (req) => {
  try {
    // 1. Recebe dados do Stripe
    const signature = req.headers.get('stripe-signature')!
    const body = await req.text()
    
    // 2. Valida que é o Stripe mesmo (segurança)
    const stripe = new Stripe(Deno.env.get('STRIPE_SECRET_KEY')!)
    const webhookSecret = Deno.env.get('STRIPE_WEBHOOK_SECRET')!
    
    const event = stripe.webhooks.constructEvent(
      body,
      signature,
      webhookSecret
    )
    
    // 3. Processa baseado no tipo de evento
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    )
    
    switch (event.type) {
      case 'payment_intent.succeeded':
        // Pagamento aprovado!
        const payment = event.data.object
        
        // Atualiza no banco
        await supabase
          .from('pedidos')
          .update({ 
            status: 'pago',
            stripe_payment_id: payment.id,
            valor_pago: payment.amount / 100
          })
          .eq('id', payment.metadata.pedido_id)
        
        // Libera acesso
        await supabase
          .from('usuarios')
          .update({ plano: 'premium' })
          .eq('email', payment.receipt_email)
        
        break
        
      case 'payment_intent.payment_failed':
        // Pagamento falhou
        console.log('Pagamento falhou:', payment.id)
        // Enviar email, notificar, etc
        break
    }
    
    // 4. Confirma pro Stripe que recebeu
    return new Response(JSON.stringify({ received: true }), {
      headers: { "Content-Type": "application/json" },
      status: 200
    })
    
  } catch (err) {
    console.error('Erro no webhook:', err)
    return new Response('Webhook Error', { status: 400 })
  }
})
```

**Setup no Stripe:**
1. Stripe Dashboard → Webhooks
2. Add Endpoint
3. URL: `https://[seu-projeto].supabase.co/functions/v1/stripe-webhook`
4. Events: payment_intent.succeeded, payment_intent.failed

**Casos de Uso Reais:**
- Assinatura mensal (subscription.updated)
- Carrinho abandonado (checkout.session.expired)
- Reembolso (charge.refunded)
- Trial acabando (customer.subscription.trial_will_end)

**Debug Tips:**
- Use Stripe CLI para testar local
- Logs no Supabase Dashboard
- Webhook sempre retorna 200 (mesmo com erro interno)

---

### 13.6 - Enviando Emails Automáticos com Resend (10 min)
**Bloom's Level:** Apply (3)  
**Hook:** "Email de boas-vindas, recuperação de senha, notificações... Tudo automático. Zero trabalho."

**Template Email com Resend:**
```typescript
// edge-function: enviar-email

Deno.serve(async (req) => {
  const { para, assunto, nome, tipo } = await req.json()
  
  // Templates de email prontos
  const templates = {
    boas_vindas: `
      <h1>Bem-vindo(a), ${nome}! 🎉</h1>
      <p>Que alegria ter você aqui!</p>
      <p>Seus próximos passos:</p>
      <ul>
        <li>Complete seu perfil</li>
        <li>Explore o dashboard</li>
        <li>Faça seu primeiro projeto</li>
      </ul>
      <a href="https://app.exemplo.com/dashboard" 
         style="background: #4F46E5; color: white; padding: 12px 24px; 
                border-radius: 6px; text-decoration: none;">
        Acessar Dashboard
      </a>
    `,
    
    senha_recuperacao: `
      <h1>Recuperação de Senha</h1>
      <p>Oi ${nome},</p>
      <p>Clique no link abaixo para criar uma nova senha:</p>
      <a href="https://app.exemplo.com/reset-password">Redefinir Senha</a>
      <p>Link válido por 1 hora.</p>
    `,
    
    compra_confirmada: `
      <h1>Pagamento Confirmado! ✅</h1>
      <p>Oi ${nome},</p>
      <p>Recebemos seu pagamento. Você já pode acessar!</p>
      <a href="https://app.exemplo.com/login">Fazer Login</a>
    `
  }
  
  // Enviar via Resend
  const response = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${Deno.env.get('RESEND_API_KEY')}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      from: 'Equipe <noreply@seudominio.com>',
      to: para,
      subject: assunto,
      html: templates[tipo] || templates.boas_vindas
    })
  })
  
  const data = await response.json()
  
  return new Response(
    JSON.stringify({ enviado: true, id: data.id }),
    { headers: { "Content-Type": "application/json" } }
  )
})
```

**Configurar Resend:**
1. Criar conta em resend.com
2. Verificar domínio (DNS)
3. Pegar API Key
4. Adicionar em Secrets

**Triggers Automáticos:**
- Novo usuário → Email boas-vindas
- Pagamento → Confirmação
- 7 dias inativo → Reengajamento
- Carrinho abandonado → Lembrete

**Métricas para Acompanhar:**
- Taxa de abertura (>20% é bom)
- Taxa de clique (>2% é bom)
- Bounce rate (<5% é aceitável)

---

### 13.7 - Cron Jobs: Tarefas no Piloto Automático (10 min)
**Bloom's Level:** Analyze (4)  
**Hook:** "Todo dia às 9h, relatório enviado. Toda segunda, backup feito. Você? Dormindo."

**Setup com pg_cron:**
```sql
-- No SQL Editor do Supabase

-- 1. Habilitar pg_cron
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- 2. Agendar Edge Function
SELECT cron.schedule(
  'enviar-relatorio-diario', -- nome do job
  '0 9 * * *', -- todo dia às 9h
  $$
  SELECT net.http_post(
    url := 'https://[seu-projeto].supabase.co/functions/v1/gerar-relatorio',
    body := '{"tipo": "diario"}'::jsonb,
    headers := '{"Authorization": "Bearer [seu-anon-key]"}'::jsonb
  );
  $$
);

-- 3. Outros exemplos úteis
-- Todo domingo às 22h - Backup
SELECT cron.schedule(
  'backup-semanal', 
  '0 22 * * 0',
  $$ SELECT net.http_post(...) $$
);

-- A cada 6 horas - Sincronizar dados
SELECT cron.schedule(
  'sync-dados', 
  '0 */6 * * *',
  $$ SELECT net.http_post(...) $$
);

-- Todo dia 1 às 00:01 - Fechar mês
SELECT cron.schedule(
  'fechamento-mensal', 
  '1 0 1 * *',
  $$ SELECT net.http_post(...) $$
);
```

**Expressões Cron Decodificadas:**
```
* * * * *
│ │ │ │ │
│ │ │ │ └─ Dia da semana (0-7, 0=domingo)
│ │ │ └─── Mês (1-12)
│ │ └───── Dia do mês (1-31)
│ └─────── Hora (0-23)
└───────── Minuto (0-59)
```

**Casos de Uso Matadores:**
- Relatório de vendas diário
- Limpeza de dados antigos
- Backup automático
- Cobranças recorrentes
- Lembretes de renovação
- Sincronização com sistemas externos

**Monitoramento:**
```sql
-- Ver jobs agendados
SELECT * FROM cron.job;

-- Ver histórico de execução
SELECT * FROM cron.job_run_details 
ORDER BY start_time DESC 
LIMIT 10;
```

---

## PROJETO FINAL DO MÓDULO: Sistema de Onboarding Automático

**Tempo:** 20 minutos  
**Complexidade:** Intermediate  
**Bloom's Level:** Create (6)

### O Que Vamos Construir:
Sistema completo que quando usuário se cadastra:
1. Envia email de boas-vindas
2. Cria registro de onboarding
3. Agenda follow-up em 3 dias
4. Se pagar, atualiza status

### Arquitetura:
```
Novo Usuário
    ↓
[Database Trigger]
    ↓
[Edge Function: onboarding]
    ├── Envia email (Resend)
    ├── Cria checklist
    ├── Agenda follow-up (pg_cron)
    └── Notifica admin (opcional)
```

### Implementação Guiada:

**Passo 1: Edge Function Principal**
```typescript
// função: usuario-onboarding

Deno.serve(async (req) => {
  const { user_id, email, nome } = await req.json()
  
  // Supabase client
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  )
  
  // 1. Criar registro de onboarding
  await supabase.from('onboarding').insert({
    user_id,
    status: 'iniciado',
    checklist: {
      email_enviado: false,
      perfil_completo: false,
      primeiro_projeto: false,
      pagamento: false
    }
  })
  
  // 2. Enviar email de boas-vindas
  await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${Deno.env.get('RESEND_API_KEY')}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      from: 'Time <oi@exemplo.com>',
      to: email,
      subject: `Bem-vindo, ${nome}! 🎉`,
      html: `[template HTML aqui]`
    })
  })
  
  // 3. Atualizar checklist
  await supabase
    .from('onboarding')
    .update({ 
      'checklist.email_enviado': true 
    })
    .eq('user_id', user_id)
  
  // 4. Agendar follow-up
  // (isso seria via pg_cron, configurado separadamente)
  
  return new Response(
    JSON.stringify({ success: true }),
    { headers: { "Content-Type": "application/json" } }
  )
})
```

**Passo 2: Trigger no Banco**
```sql
-- Trigger para chamar Edge Function quando usuário criado
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger AS $$
BEGIN
  -- Chama Edge Function
  PERFORM net.http_post(
    url := 'https://[projeto].supabase.co/functions/v1/usuario-onboarding',
    body := json_build_object(
      'user_id', NEW.id,
      'email', NEW.email,
      'nome', NEW.raw_user_meta_data->>'nome'
    )::jsonb,
    headers := '{"Authorization": "Bearer [anon-key]"}'::jsonb
  );
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Conecta trigger à tabela
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_user();
```

**Passo 3: Dashboard de Acompanhamento**
```sql
-- View para dashboard
CREATE VIEW onboarding_dashboard AS
SELECT 
  u.email,
  o.status,
  o.created_at,
  o.checklist,
  CASE 
    WHEN o.checklist->>'pagamento' = 'true' THEN 'CLIENTE'
    WHEN o.checklist->>'primeiro_projeto' = 'true' THEN 'ENGAJADO'
    WHEN o.checklist->>'perfil_completo' = 'true' THEN 'ATIVO'
    ELSE 'NOVO'
  END as fase
FROM onboarding o
JOIN auth.users u ON u.id = o.user_id
ORDER BY o.created_at DESC;
```

---

## RECURSOS DO MÓDULO

### Templates Prontos para Download:
1. **stripe-webhook.ts** - Processamento de pagamentos
2. **email-sender.ts** - Envio de emails com templates
3. **openai-rag.ts** - ChatGPT com contexto
4. **image-processor.ts** - Redimensionar imagens
5. **scheduled-report.ts** - Relatórios automáticos

### Cheat Sheet:
```typescript
// ESTRUTURA BÁSICA DE TODA EDGE FUNCTION
Deno.serve(async (req) => {
  // 1. Receber dados
  const dados = await req.json()
  
  // 2. Fazer algo útil
  // - Chamar API externa
  // - Processar dados
  // - Salvar no banco
  
  // 3. Retornar resposta
  return new Response(
    JSON.stringify({ resultado: "sucesso" }),
    { headers: { "Content-Type": "application/json" } }
  )
})
```

### Troubleshooting Guide:

**Erro 500:**
- Check: Logs no dashboard
- Fix: Variáveis de ambiente

**Erro 401:**
- Check: Authorization header
- Fix: Anon key correto

**Timeout:**
- Check: Função demora >10s
- Fix: Otimizar ou aumentar timeout

**Não funciona local:**
- Check: Supabase CLI atualizado
- Fix: `supabase functions serve`

---

## MÉTRICAS DE SUCESSO DO MÓDULO

### O aluno será capaz de:
- ✅ Criar Edge Function via Dashboard em <5 min
- ✅ Integrar com API externa (OpenAI, Stripe, etc)
- ✅ Processar webhooks de pagamento
- ✅ Enviar emails automáticos
- ✅ Agendar tarefas recorrentes
- ✅ Debugar com logs

### KPIs do Módulo:
- Taxa de conclusão: >85% (target)
- Primeira function funcionando: <30 min
- Integração completa: <2h
- Confiança pós-módulo: 8/10

---

## NARRATIVA FILOSÓFICA DO JOSÉ AMORIM

"Edge Functions são como ter um exército de assistentes invisíveis. Você não os vê, mas eles estão lá, 24/7, em 29 países, prontos para executar suas ordens. 

Não é sobre código. É sobre AUTONOMIA. 

Cada Edge Function que você cria é um passo para longe da dependência. Cada integração que você domina é uma porta que se abre. 

Você não está aprendendo TypeScript. Você está aprendendo a comandar robôs. E esses robôs vão trabalhar para você enquanto você dorme, enquanto você viaja, enquanto você vive.

Isso não é tecnologia. É LIBERDADE."

---

## ANTI-IMPOSTOR FINAL

**Lembre-se:**
- Você criou backends funcionais
- Dominou bancos de dados
- Implementou segurança
- E agora, controla Edge Functions

**Você não é mais "não-técnico".**
**Você é um Founder Técnico.**
**Próprio. Suficiente. Capaz.**

---

*Fim do Módulo 13 - Edge Functions*