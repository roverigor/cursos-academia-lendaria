# Aula 5B.2: Stack Full: Supabase + Claude

## Tipo: Teoria | Duração: 15 minutos

---

## GPS

### Goal (30s)
Entender a stack moderna para criar produtos profissionais rapidamente.

### Position (60s)
Saber programar é uma coisa. Saber montar uma stack produtiva é outra. Vamos resolver isso.

### Steps
1. Por que Supabase (4 min)
2. Arquitetura moderna (5 min)
3. Claude + Supabase (6 min)

---

## Por que Supabase?

### O Problema

```
Antes você precisava:
├── Servidor (AWS/GCP/Azure)
├── Banco de dados (PostgreSQL/MySQL)
├── Sistema de autenticação (código próprio ou Auth0)
├── Storage (S3)
├── API (Express/FastAPI)
├── Realtime (Socket.io)
└── DevOps (deploy, CI/CD)

Semanas de setup. Milhares de linhas de código.
```

### A Solução

```
Supabase = Tudo em um lugar
├── PostgreSQL gerenciado (banco)
├── Auth pronto (email, social, magic link)
├── Storage (arquivos)
├── Realtime (websockets)
├── Edge Functions (API serverless)
├── Row Level Security (segurança)
└── Dashboard visual

Setup em minutos. Código mínimo.
```

---

## O que Supabase Oferece

| Componente | O que é | Substitui |
|------------|---------|-----------|
| **Database** | PostgreSQL completo | RDS, Cloud SQL |
| **Auth** | Autenticação pronta | Auth0, Firebase Auth |
| **Storage** | Upload de arquivos | S3, Cloud Storage |
| **Realtime** | Websockets | Socket.io, Pusher |
| **Edge Functions** | Serverless | Lambda, Cloud Functions |
| **Vector** | Embeddings | Pinecone, Weaviate |

### Preço

| Tier | Preço | Recursos |
|------|-------|----------|
| Free | $0 | 500MB DB, 1GB storage |
| Pro | $25/mês | 8GB DB, 100GB storage |
| Team | $599/mês | Enterprise features |

**Para 90% dos projetos, Free é suficiente para começar.**

---

## Arquitetura Moderna

### Stack Recomendada

```
Frontend:        Next.js ou React + Vite
Estilo:          Tailwind CSS
Backend:         Supabase
Auth:            Supabase Auth
Database:        Supabase (PostgreSQL)
Deploy Frontend: Vercel
Deploy Backend:  Supabase (managed)
```

### Fluxo de Dados

```
[Usuário] → [Next.js Frontend]
                ↓
          [Supabase Client SDK]
                ↓
          [Supabase Backend]
          ├── Auth (quem é?)
          ├── Database (o que pode?)
          ├── Storage (arquivos)
          └── Realtime (atualizações)
```

---

## Conceitos Essenciais

### 1. Row Level Security (RLS)

Segurança a nível de linha no banco:

```sql
-- Usuário só vê seus próprios dados
CREATE POLICY "Users can view own data"
ON todos FOR SELECT
USING (auth.uid() = user_id);

-- Usuário só edita seus próprios dados
CREATE POLICY "Users can update own data"
ON todos FOR UPDATE
USING (auth.uid() = user_id);
```

**Por que importa:** Segurança no banco, não no código. Impossível burlar.

### 2. Realtime

```javascript
// Frontend recebe atualizações automaticamente
supabase
  .channel('todos')
  .on('postgres_changes',
      { event: '*', schema: 'public', table: 'todos' },
      (payload) => {
        console.log('Mudança:', payload)
      }
  )
  .subscribe()
```

**Por que importa:** Múltiplos usuários veem mesmos dados em tempo real.

### 3. Auth Pronto

```javascript
// Login com email
await supabase.auth.signInWithPassword({
  email: 'user@email.com',
  password: 'senha123'
})

// Login com Google
await supabase.auth.signInWithOAuth({
  provider: 'google'
})

// Magic Link
await supabase.auth.signInWithOtp({
  email: 'user@email.com'
})
```

**Por que importa:** Auth seguro sem escrever código de autenticação.

---

## Claude Code + Supabase

### Workflow Poderoso

```bash
claude
```

```
Crie um projeto Next.js com Supabase para gerenciar tarefas:

1. Setup Next.js com TypeScript e Tailwind
2. Configure Supabase client
3. Crie tabela 'todos' com: id, title, completed, user_id, created_at
4. Adicione RLS para usuários só verem suas tarefas
5. Crie páginas: login, lista de tarefas, criar tarefa
6. Implemente autenticação com magic link
7. Adicione realtime para atualizações automáticas

Use minhas variáveis de ambiente:
NEXT_PUBLIC_SUPABASE_URL=xxx
NEXT_PUBLIC_SUPABASE_ANON_KEY=xxx
```

### O que Claude faz:

1. Cria estrutura Next.js
2. Instala dependências
3. Configura Supabase client
4. Gera SQL para tabelas e policies
5. Cria componentes React
6. Implementa lógica de auth
7. Configura realtime

**Projeto completo em minutos.**

---

## Quando Usar Cada Ferramenta

### Claude Code (CLI)

```
✅ Criar projeto do zero
✅ Setup de configurações
✅ Gerar boilerplate
✅ Scripts de automação
✅ Análise de código
```

### Cursor/IDE

```
✅ Editar código existente
✅ Debug visual
✅ Refatoração
✅ Code review
✅ Trabalho detalhado
```

### Workflow Ideal

```
1. Claude CLI: Cria projeto e estrutura
2. Cursor: Desenvolve features
3. Claude CLI: Gera scripts de deploy
4. Cursor: Ajustes finais
5. Claude CLI: Automações de CI/CD
```

---

## Checklist de Entendimento

- [ ] Entendo o que Supabase oferece
- [ ] Sei o que é Row Level Security
- [ ] Entendo a arquitetura moderna
- [ ] Sei quando usar CLI vs IDE
- [ ] Consigo visualizar o workflow

---

## Próximo Passo

Agora vamos construir um projeto full-stack completo usando tudo isso.
