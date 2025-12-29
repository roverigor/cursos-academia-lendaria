# SQL Cheat Sheet + Prompts para IA

**Como usar ChatGPT/Claude para escrever SQL por você**

---

## 🎯 REGRA DE OURO

**Você NÃO precisa decorar SQL.**

Você precisa saber:
1. O que você quer fazer (buscar, criar, atualizar, deletar)
2. Como pedir pra IA

A IA escreve o SQL. Você só usa.

---

## 🤖 TEMPLATES DE PROMPTS

### 1. BUSCAR DADOS (SELECT)

**Prompt:**
```
Preciso de SQL para buscar [o quê] da tabela [nome]
onde [condição].

Exemplo:
- Todos clientes de São Paulo
- Usuários criados nos últimos 7 dias
- Produtos com preço acima de R$ 100
```

**Exemplo Real:**
```
Preciso de SQL para buscar todos pedidos da tabela 'orders'
onde status = 'pending' e valor > 100.
```

**IA vai gerar:**
```sql
SELECT *
FROM orders
WHERE status = 'pending'
  AND valor > 100;
```

---

### 2. CRIAR REGISTRO (INSERT)

**Prompt:**
```
Preciso de SQL para inserir [dados] na tabela [nome].

Campos:
- campo1: valor1
- campo2: valor2
```

**Exemplo Real:**
```
Preciso de SQL para inserir novo cliente na tabela 'clients'.

Campos:
- name: "João Silva"
- email: "joao@email.com"
- city: "São Paulo"
```

**IA vai gerar:**
```sql
INSERT INTO clients (name, email, city)
VALUES ('João Silva', 'joao@email.com', 'São Paulo');
```

---

### 3. ATUALIZAR DADOS (UPDATE)

**Prompt:**
```
Preciso de SQL para atualizar [o quê] na tabela [nome]
onde [condição].
```

**Exemplo Real:**
```
Preciso de SQL para atualizar o status para 'completed'
na tabela 'orders' onde id = 123.
```

**IA vai gerar:**
```sql
UPDATE orders
SET status = 'completed'
WHERE id = 123;
```

---

### 4. DELETAR DADOS (DELETE)

**Prompt:**
```
Preciso de SQL para deletar [o quê] da tabela [nome]
onde [condição].

⚠️ Sempre especifica WHERE (se não, deleta TUDO!)
```

**Exemplo Real:**
```
Preciso de SQL para deletar pedidos da tabela 'orders'
onde status = 'cancelled' e created_at < '2024-01-01'.
```

**IA vai gerar:**
```sql
DELETE FROM orders
WHERE status = 'cancelled'
  AND created_at < '2024-01-01';
```

---

### 5. JOINS (Conectar Tabelas)

**Prompt:**
```
Preciso de SQL para buscar [dados] juntando tabelas [A] e [B]
através de [campo comum].
```

**Exemplo Real:**
```
Preciso de SQL para buscar nome do cliente + valor do pedido
juntando tabelas 'clients' e 'orders'
através de client_id.
```

**IA vai gerar:**
```sql
SELECT
  clients.name,
  orders.valor
FROM orders
JOIN clients ON orders.client_id = clients.id;
```

---

### 6. AGREGAÇÕES (Somar, Contar, Média)

**Prompt:**
```
Preciso de SQL para calcular [SUM/COUNT/AVG] de [campo]
na tabela [nome] agrupado por [campo].
```

**Exemplo Real:**
```
Preciso de SQL para calcular total de vendas (SUM de valor)
na tabela 'orders' agrupado por client_id.
```

**IA vai gerar:**
```sql
SELECT
  client_id,
  SUM(valor) as total_vendas
FROM orders
GROUP BY client_id;
```

---

### 7. CRIAR TABELA

**Prompt:**
```
Preciso de SQL para criar tabela [nome] com campos:
- campo1: tipo (descrição)
- campo2: tipo (descrição)

Tipos: text, integer, boolean, timestamp, uuid
```

**Exemplo Real:**
```
Preciso de SQL para criar tabela 'products' com campos:
- id: uuid (chave primária)
- name: text (nome do produto)
- price: numeric (preço em reais)
- in_stock: boolean (disponível?)
- created_at: timestamp (data de criação)
```

**IA vai gerar:**
```sql
CREATE TABLE products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  in_stock BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

### 8. ADICIONAR RELACIONAMENTO

**Prompt:**
```
Preciso de SQL para adicionar foreign key em [tabela A]
referenciando [tabela B] através de [campo].
```

**Exemplo Real:**
```
Preciso de SQL para adicionar foreign key em 'orders'
referenciando 'clients' através de client_id.
```

**IA vai gerar:**
```sql
ALTER TABLE orders
ADD CONSTRAINT fk_client
FOREIGN KEY (client_id)
REFERENCES clients(id)
ON DELETE CASCADE;
```

---

## 📝 CHEAT SHEET RÁPIDO

### Comandos Essenciais

**BUSCAR:**
```sql
SELECT * FROM tabela WHERE condição;
```

**BUSCAR ESPECÍFICO:**
```sql
SELECT campo1, campo2 FROM tabela WHERE id = 1;
```

**CRIAR:**
```sql
INSERT INTO tabela (campo1, campo2)
VALUES ('valor1', 'valor2');
```

**ATUALIZAR:**
```sql
UPDATE tabela
SET campo = 'novo_valor'
WHERE id = 1;
```

**DELETAR:**
```sql
DELETE FROM tabela WHERE id = 1;
```

**CONTAR:**
```sql
SELECT COUNT(*) FROM tabela;
```

**SOMAR:**
```sql
SELECT SUM(valor) FROM pedidos;
```

**MÉDIA:**
```sql
SELECT AVG(preco) FROM produtos;
```

**ORDENAR:**
```sql
SELECT * FROM tabela ORDER BY campo DESC;
```

**LIMITAR:**
```sql
SELECT * FROM tabela LIMIT 10;
```

---

## 🔍 FILTROS COMUNS

**Igual:**
```sql
WHERE status = 'active'
```

**Diferente:**
```sql
WHERE status != 'deleted'
-- ou
WHERE status <> 'deleted'
```

**Maior/Menor:**
```sql
WHERE price > 100
WHERE created_at < '2024-01-01'
```

**Entre (range):**
```sql
WHERE price BETWEEN 50 AND 200
```

**Lista (IN):**
```sql
WHERE status IN ('pending', 'processing')
```

**Contém (LIKE):**
```sql
WHERE name LIKE '%Silva%'  -- contém "Silva"
WHERE email LIKE '%@gmail.com'  -- termina com @gmail.com
```

**NULL:**
```sql
WHERE campo IS NULL
WHERE campo IS NOT NULL
```

**E / OU:**
```sql
WHERE status = 'active' AND price > 100
WHERE city = 'SP' OR city = 'RJ'
```

---

## 🎓 DICAS PRO

### 1. Sempre teste SELECT antes de UPDATE/DELETE

**❌ NÃO FAÇA:**
```sql
DELETE FROM orders WHERE status = 'old';
```

**✅ FAÇA:**
```sql
-- Primeiro: VÊ o que vai deletar
SELECT * FROM orders WHERE status = 'old';

-- Se tá certo, AÍDELETE
DELETE FROM orders WHERE status = 'old';
```

---

### 2. Use LIMIT em queries exploratórias

```sql
-- Em vez de buscar 1 milhão de linhas:
SELECT * FROM huge_table;

-- Busca só 10 pra ver estrutura:
SELECT * FROM huge_table LIMIT 10;
```

---

### 3. Comente seu SQL

```sql
-- Busca clientes ativos de São Paulo
SELECT *
FROM clients
WHERE status = 'active'  -- só ativos
  AND city = 'São Paulo';  -- só SP
```

---

### 4. Use aliases para legibilidade

```sql
SELECT
  c.name AS cliente,
  o.valor AS total_pedido
FROM orders AS o
JOIN clients AS c ON o.client_id = c.id;
```

---

## 🤖 QUANDO USAR IA vs ESCREVER VOCÊ MESMO

**Use IA quando:**
- ✅ Query complexa com JOINs
- ✅ Não lembra sintaxe exata
- ✅ Precisa de algo rápido

**Escreva você mesmo quando:**
- ✅ Query simples (`SELECT * FROM users`)
- ✅ Quer praticar e aprender
- ✅ Precisa entender cada parte

---

## 💡 EXEMPLO COMPLETO: DO PROBLEMA À SOLUÇÃO

**Problema:**
> "Preciso listar os 10 clientes que mais compraram no último mês,
> mostrando nome + total gasto."

**1. Prompt pra IA:**
```
Preciso de SQL para:
- Buscar nome do cliente + total gasto (soma de order.value)
- Juntar tabelas 'clients' e 'orders' por client_id
- Filtrar orders.created_at dos últimos 30 dias
- Agrupar por cliente
- Ordenar por total gasto (maior primeiro)
- Limitar 10 resultados

Tabelas:
- clients (id, name)
- orders (id, client_id, value, created_at)
```

**2. SQL gerado pela IA:**
```sql
SELECT
  c.name AS cliente,
  SUM(o.value) AS total_gasto
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE o.created_at >= NOW() - INTERVAL '30 days'
GROUP BY c.id, c.name
ORDER BY total_gasto DESC
LIMIT 10;
```

**3. Você testa no SQL Editor**

**4. Se funcionar → usa no código**

---

## ✅ CHECKLIST: SQL PRODUCTION-READY

Antes de usar SQL em produção:

- [ ] Testei no SQL Editor?
- [ ] Funciona com dados reais?
- [ ] Performance é aceitável (<1s)?
- [ ] Tem WHERE quando UPDATE/DELETE?
- [ ] Protegido contra SQL injection? (use prepared statements)
- [ ] RLS configurado na tabela?

---

*Cheat Sheet por José Amorim*
*Supabase do Zero - CreatorOS v3.0*
