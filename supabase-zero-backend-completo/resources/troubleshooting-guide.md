# Troubleshooting Guide - Supabase do Zero

**Erros Comuns e Soluções Rápidas**

---

## 🔧 ERROS COMUNS DE INICIANTES

### 1. "relation 'public.table_name' does not exist"

**O que significa:**
Você tá tentando acessar uma tabela que não existe (ou tá com nome errado).

**Solução:**
- Verifica o nome da tabela no Table Editor
- SQL é case-sensitive: `users` ≠ `Users`
- Esquema correto: `public.users` (não só `users`)

---

### 2. "row-level security policy violation"

**O que significa:**
RLS (Row Level Security) tá habilitado, mas você não configurou políticas.

**Solução:**
```sql
-- Desabilita RLS temporariamente (só pra testar)
ALTER TABLE tasks DISABLE ROW LEVEL SECURITY;

-- OU cria política permissiva (todos podem ver tudo)
CREATE POLICY "Enable read for all" ON tasks
  FOR SELECT
  USING (true);
```

**Atenção:** Em produção, SEMPRE configure RLS direito (aula 7.2).

---

### 3. "duplicate key value violates unique constraint"

**O que significa:**
Você tá tentando inserir um ID que JÁ EXISTE.

**Solução:**
- Deixa campo `id` vazio ao inserir (gera automaticamente)
- Se tiver especificando ID manual, usa número único

---

### 4. "Failed to fetch" ou "Network error"

**O que significa:**
App não consegue conectar com Supabase.

**Checklist:**
- [ ] Credenciais (URL + anon key) estão corretas?
- [ ] Copiou a anon key COMPLETA? (é longa, tipo 200 caracteres)
- [ ] Projeto tá pausado? (free tier pausa após inatividade)
- [ ] CORS configurado? (se tá rodando localhost)

**Solução rápida:**
```javascript
// Verifica se credenciais tão corretas
console.log('URL:', process.env.SUPABASE_URL);
console.log('Key:', process.env.SUPABASE_ANON_KEY?.substring(0, 20) + '...');
```

---

### 5. "Invalid API key"

**O que significa:**
Anon key errada ou expirada.

**Solução:**
1. Vai em Settings → API
2. Copia anon key de novo
3. Cola no código (SEM espaços extras no início/fim)

---

## 📧 PROBLEMAS COM AUTENTICAÇÃO

### 6. "User already registered"

**O que significa:**
Email já existe no sistema.

**Solução:**
- Usa outro email
- OU deleta usuário antigo em Authentication → Users

---

### 7. Email de confirmação não chega

**Checklist:**
- [ ] Tá na caixa de spam?
- [ ] Email tá correto?
- [ ] Projeto configurou SMTP? (free tier usa email padrão)

**Solução pra DEV (NUNCA EM PRODUÇÃO):**
1. Vai em Authentication → Settings
2. Desabilita "Enable email confirmations"
3. Usuário consegue logar sem confirmar email

---

### 8. "Invalid login credentials"

**O que significa:**
Email ou senha errados.

**Solução:**
- Verifica se usuário TÁ CONFIRMADO (Authentication → Users → coluna "confirmed_at")
- Testa reset de senha

---

## 🗄️ PROBLEMAS COM STORAGE

### 9. "Bucket not found"

**Solução:**
1. Vai em Storage
2. Verifica nome do bucket (ex: `avatars`)
3. Nome no código TEM que ser EXATAMENTE igual

---

### 10. "Upload failed" (403 Forbidden)

**O que significa:**
Sem permissão pra fazer upload.

**Solução:**
```sql
-- Cria política permitindo uploads
CREATE POLICY "Allow uploads for authenticated users"
  ON storage.objects
  FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'avatars');
```

---

## 🐛 DEBUGGING GERAL

### Como Debug Eficiente

**1. Console do Navegador**
```javascript
console.log('Dados:', data);
console.error('Erro:', error);
```

**2. Network Tab**
- Abre DevTools (F12)
- Aba "Network"
- Vê requests pro Supabase
- Clica no request → Preview → vê resposta

**3. SQL Editor**
- Testa queries direto no SQL Editor antes de usar no código
```sql
SELECT * FROM tasks WHERE id = 1;
```

**4. Logs do Supabase**
- Dashboard → Logs
- Filtra por erro
- Vê stack trace completo

---

## 🤖 COMO PEDIR AJUDA PRA IA

**Prompt eficiente:**
```
Estou usando Supabase e recebi este erro:

[Cola erro completo aqui]

Contexto:
- Tabela: users
- Operação: INSERT
- Código: [cola o código]

O que pode estar errado?
```

**❌ Prompt ruim:**
```
"Deu erro no Supabase, help"
```

**✅ Prompt bom:**
```
"Estou tentando fazer INSERT na tabela 'users' e recebo erro
'duplicate key value'. Meu código:

INSERT INTO users (id, name) VALUES (1, 'João');

O que tá errado?"
```

---

## 📚 ONDE BUSCAR AJUDA

**1. Documentação Oficial**
https://supabase.com/docs

**2. ChatGPT/Claude**
Cole erro + contexto

**3. Discord Supabase**
https://discord.supabase.com

**4. Comunidade do Curso**
Grupo exclusivo Telegram/Discord

**5. Stack Overflow**
Tag: `supabase`

---

## ✅ CHECKLIST ANTES DE PEDIR AJUDA

Antes de pedir ajuda, SEMPRE:

- [ ] Li a mensagem de erro completa?
- [ ] Procurei erro no Google?
- [ ] Testei query no SQL Editor?
- [ ] Verifiquei credenciais (URL + key)?
- [ ] Olhei tab Network no DevTools?
- [ ] Tentei desabilitar RLS (só pra testar)?
- [ ] Li docs do Supabase sobre o tópico?

Se marcou 7/7 e ainda tá travado → PEÇA AJUDA SEM CULPA.

---

*Guia criado por José Amorim*
*Supabase do Zero - CreatorOS v3.0*
