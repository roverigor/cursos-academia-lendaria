# Template: Projeto Full-Stack

## Módulo 5B - Claude Code + Stack Full

---

# [NOME DO PROJETO]

## Visão Geral

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0.0 |
| **Stack** | Next.js + Supabase + Vercel |
| **Status** | [ ] Dev [ ] Staging [ ] Produção |
| **Autor** | |
| **Data início** | |

---

## Links

| Ambiente | URL | Status |
|----------|-----|--------|
| Produção | | 🟢 / 🔴 |
| Staging | | 🟢 / 🔴 |
| Local | http://localhost:3000 | |
| Supabase | | |
| GitHub | | |

---

## Arquitetura

### Stack

```
┌─────────────────────────────────────┐
│           Frontend                   │
│    Next.js 14 + TypeScript          │
│    Tailwind CSS                      │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│           Backend                    │
│    Supabase                          │
│    ├── PostgreSQL (Database)        │
│    ├── Auth (Autenticação)          │
│    ├── Storage (Arquivos)           │
│    └── Realtime (WebSockets)        │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│           Deploy                     │
│    Vercel (Frontend)                │
│    Supabase (Backend)               │
└─────────────────────────────────────┘
```

### Estrutura de Pastas

```
projeto/
├── app/
│   ├── (auth)/
│   │   ├── login/
│   │   └── register/
│   ├── (protected)/
│   │   ├── dashboard/
│   │   └── settings/
│   ├── api/
│   ├── layout.tsx
│   └── page.tsx
├── components/
│   ├── ui/
│   └── features/
├── lib/
│   ├── supabase.ts
│   └── utils.ts
├── types/
└── public/
```

---

## Database

### Tabelas

#### Tabela: `[nome]`

| Coluna | Tipo | Nullable | Default | Descrição |
|--------|------|----------|---------|-----------|
| id | UUID | NO | gen_random_uuid() | PK |
| user_id | UUID | NO | - | FK → auth.users |
| created_at | TIMESTAMPTZ | NO | NOW() | |
| | | | | |

#### SQL de Criação

```sql
CREATE TABLE [nome] (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users NOT NULL,
  -- adicionar colunas
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- RLS
ALTER TABLE [nome] ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can view own data"
ON [nome] FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own data"
ON [nome] FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own data"
ON [nome] FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own data"
ON [nome] FOR DELETE
USING (auth.uid() = user_id);
```

---

## Autenticação

### Métodos Habilitados

- [ ] Email + Password
- [ ] Magic Link
- [ ] Google OAuth
- [ ] GitHub OAuth
- [ ] Outro: ___

### Configuração Supabase

```
Dashboard → Authentication → Providers
```

### Redirect URLs

| Ambiente | URL |
|----------|-----|
| Local | http://localhost:3000/auth/callback |
| Staging | https://staging.meusite.com/auth/callback |
| Produção | https://meusite.com/auth/callback |

---

## Variáveis de Ambiente

### Local (.env.local)

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# Outros
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

### Produção (Vercel)

| Variável | Valor | Ambiente |
|----------|-------|----------|
| NEXT_PUBLIC_SUPABASE_URL | [valor] | Production, Preview |
| NEXT_PUBLIC_SUPABASE_ANON_KEY | [valor] | Production, Preview |
| SUPABASE_SERVICE_ROLE_KEY | [valor] | Production |

---

## Funcionalidades

### Core

| Feature | Status | Notas |
|---------|--------|-------|
| Auth - Login | [ ] | |
| Auth - Register | [ ] | |
| Auth - Logout | [ ] | |
| CRUD - Create | [ ] | |
| CRUD - Read | [ ] | |
| CRUD - Update | [ ] | |
| CRUD - Delete | [ ] | |

### Extras

| Feature | Status | Notas |
|---------|--------|-------|
| Realtime | [ ] | |
| File Upload | [ ] | |
| Search | [ ] | |
| Pagination | [ ] | |
| Dark Mode | [ ] | |

---

## API Endpoints

### Supabase (Client-side)

| Operação | Código |
|----------|--------|
| Listar | `supabase.from('tabela').select('*')` |
| Buscar | `supabase.from('tabela').select('*').eq('id', id)` |
| Criar | `supabase.from('tabela').insert({ ... })` |
| Atualizar | `supabase.from('tabela').update({ ... }).eq('id', id)` |
| Deletar | `supabase.from('tabela').delete().eq('id', id)` |

### Edge Functions (se usar)

| Função | Endpoint | Método |
|--------|----------|--------|
| | /functions/v1/[nome] | POST |

---

## Deploy

### Checklist Pré-Deploy

- [ ] Testes passando localmente
- [ ] Env vars configuradas no Vercel
- [ ] Supabase URLs de redirect configuradas
- [ ] RLS habilitado em todas as tabelas
- [ ] Código commitado e pushado

### Deploy Frontend (Vercel)

```bash
# Automático via GitHub
git push origin main

# Ou manual
vercel --prod
```

### Deploy Database (Supabase)

```bash
# Via Dashboard ou CLI
supabase db push
```

---

## Monitoramento

### Supabase

- [ ] Alertas de uso configurados
- [ ] Logs habilitados

### Vercel

- [ ] Analytics habilitado
- [ ] Logs de função

### Uptime

| Serviço | URL de Monitoramento |
|---------|---------------------|
| | |

---

## Comandos Úteis

### Desenvolvimento

```bash
# Instalar dependências
npm install

# Rodar localmente
npm run dev

# Build
npm run build

# Lint
npm run lint

# Type check
npm run typecheck
```

### Supabase CLI

```bash
# Login
supabase login

# Link ao projeto
supabase link --project-ref [ref]

# Gerar tipos TypeScript
supabase gen types typescript --project-id [id] > types/database.ts

# Migrations
supabase migration new [nome]
supabase db push
```

---

## Troubleshooting

### Erros Comuns

| Erro | Causa | Solução |
|------|-------|---------|
| "Invalid API key" | Env var errada | Verificar .env.local |
| "RLS policy violation" | Usuário sem permissão | Verificar policies |
| "CORS error" | URL não autorizada | Adicionar em Supabase |
| "Hydration mismatch" | SSR/CSR conflito | Usar 'use client' |

---

## Backlog

### Próximas Features

| Prioridade | Feature | Estimativa |
|------------|---------|------------|
| Alta | | |
| Média | | |
| Baixa | | |

### Melhorias Técnicas

| Item | Motivo |
|------|--------|
| | |
| | |

---

## Histórico de Versões

| Versão | Data | Mudanças |
|--------|------|----------|
| 1.0.0 | | Versão inicial |
| | | |

---

## Contatos

| Papel | Nome | Contato |
|-------|------|---------|
| Dev | | |
| PO | | |

---

*Template Trilha 02 - Ferramentas e Tecnologia*
