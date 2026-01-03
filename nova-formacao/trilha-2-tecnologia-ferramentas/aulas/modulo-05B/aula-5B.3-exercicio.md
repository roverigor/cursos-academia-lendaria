# Aula 5B.3: Projeto Full-Stack Completo

## Tipo: Exercício | Duração: 20 minutos

---

## GPS

### Goal (30s)
Construir um SaaS mínimo funcional: auth + CRUD + deploy.

### Position (60s)
Você tem todas as ferramentas. Agora vai juntar tudo em um produto real.

### Steps
1. Setup Supabase (4 min)
2. Criar projeto (6 min)
3. Implementar features (8 min)
4. Preparar deploy (2 min)

---

## Passo 1: Setup Supabase

### 1.1 Criar Conta

1. Acesse: https://supabase.com
2. "Start your project" (login com GitHub)
3. "New Project"
4. Preencha:
   - Name: `meu-saas`
   - Database Password: (anote!)
   - Region: São Paulo
5. Aguarde criação (~2 min)

### 1.2 Copiar Credenciais

No dashboard:
1. Settings → API
2. Copie:
   - Project URL
   - anon public key

### 1.3 Criar Tabela

No SQL Editor, cole e execute:

```sql
-- Tabela de tarefas
CREATE TABLE todos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  title TEXT NOT NULL,
  completed BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- RLS
ALTER TABLE todos ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can view own todos"
ON todos FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own todos"
ON todos FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own todos"
ON todos FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own todos"
ON todos FOR DELETE
USING (auth.uid() = user_id);
```

### Checklist Supabase

- [ ] Projeto criado
- [ ] Credenciais copiadas
- [ ] Tabela criada
- [ ] RLS configurado

---

## Passo 2: Criar Projeto

### Usando Claude Code

```bash
claude
```

```
Crie um projeto Next.js 14 com App Router para um SaaS de tarefas:

Configurações:
- TypeScript
- Tailwind CSS
- Supabase client configurado

Estrutura:
- app/page.tsx (landing page com CTA para login)
- app/login/page.tsx (login com magic link)
- app/dashboard/page.tsx (lista de tarefas, protegido)
- components/TodoList.tsx
- components/AddTodo.tsx
- lib/supabase.ts (client)

Funcionalidades:
- Login com magic link (email)
- Listar tarefas do usuário logado
- Adicionar nova tarefa
- Marcar como concluída
- Deletar tarefa
- Realtime updates

Use estas variáveis de ambiente:
NEXT_PUBLIC_SUPABASE_URL=<sua_url>
NEXT_PUBLIC_SUPABASE_ANON_KEY=<sua_key>
```

### Após Claude criar

1. Entre na pasta do projeto
2. Crie arquivo `.env.local`:
```
NEXT_PUBLIC_SUPABASE_URL=sua_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=sua_key
```

3. Instale dependências:
```bash
npm install
```

4. Rode o projeto:
```bash
npm run dev
```

### Checklist Projeto

- [ ] Projeto criado
- [ ] .env.local configurado
- [ ] npm install executado
- [ ] Projeto rodando em localhost

---

## Passo 3: Implementar Features

### 3.1 Testar Auth

1. Acesse http://localhost:3000
2. Vá para login
3. Digite seu email
4. Verifique o email (magic link)
5. Clique no link
6. Deve redirecionar para dashboard

### 3.2 Testar CRUD

1. No dashboard, adicione uma tarefa
2. Verifique se aparece na lista
3. Marque como concluída
4. Delete uma tarefa
5. Tudo deve funcionar

### 3.3 Testar Realtime (opcional)

1. Abra duas abas no navegador
2. Adicione tarefa em uma
3. Deve aparecer na outra automaticamente

### Troubleshooting

| Problema | Solução |
|----------|---------|
| Login não funciona | Verifique credenciais no .env |
| Tarefas não aparecem | Verifique RLS no Supabase |
| Erro de CORS | Adicione localhost nas URLs permitidas |

### Se algo não funcionar

No terminal, com projeto aberto:

```bash
claude
```

```
O projeto está dando o seguinte erro: [cole o erro]

Arquivos relevantes:
[liste os arquivos que podem estar envolvidos]

Como corrigir?
```

---

## Documentação do Projeto

### Arquivos Criados

| Arquivo | Função |
|---------|--------|
| app/page.tsx | |
| app/login/page.tsx | |
| app/dashboard/page.tsx | |
| components/TodoList.tsx | |
| components/AddTodo.tsx | |
| lib/supabase.ts | |

### Comandos Usados

| # | Comando/Prompt | Resultado |
|---|----------------|-----------|
| 1 | | |
| 2 | | |
| 3 | | |

---

## Passo 4: Preparar Deploy

### Vercel (Frontend)

1. Push para GitHub:
```bash
git init
git add .
git commit -m "Initial commit"
gh repo create meu-saas --public --push
```

2. Acesse https://vercel.com
3. Import project
4. Adicione env variables
5. Deploy

### Variáveis no Vercel

```
NEXT_PUBLIC_SUPABASE_URL=xxx
NEXT_PUBLIC_SUPABASE_ANON_KEY=xxx
```

### Checklist Deploy

- [ ] Código no GitHub
- [ ] Vercel conectado
- [ ] Env variables configuradas
- [ ] Deploy funcionando

---

## Resultado Final

### O que você construiu:

```
┌─────────────────────────────────────┐
│         Seu SaaS Completo           │
├─────────────────────────────────────┤
│ ✅ Landing page                     │
│ ✅ Sistema de autenticação          │
│ ✅ Dashboard protegido              │
│ ✅ CRUD de tarefas                  │
│ ✅ Row Level Security               │
│ ✅ Realtime updates                 │
│ ✅ Deploy em produção               │
└─────────────────────────────────────┘
```

### Links

- Produção: _______________
- GitHub: _______________
- Supabase Dashboard: _______________

---

## Próximo Passo

Validação final e compromisso de 48h para expandir o projeto.
