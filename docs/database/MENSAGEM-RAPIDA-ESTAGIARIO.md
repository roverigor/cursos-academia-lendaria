# 🎯 Solução Rápida para o Erro de DNS

**Para:** Estagiário
**Problema:** `nodename nor servname provided, or not known`

---

## ✅ Solução (escolha uma):

### Opção 1: No Claude Code (Mais Fácil) ⭐

**Basta adicionar essa frase na sua mensagem:**

```
"Por favor, rode com dangerouslyDisableSandbox: true"
```

**Exemplo:**
```
"Por favor, rode este comando com dangerouslyDisableSandbox: true:

psql "$SUPABASE_DB_URL" -f expansion-packs/creator-os/database/schema.sql"
```

O Claude Code vai executar sem restrições de sandbox e vai funcionar.

---

### Opção 2: No Terminal Normal

```bash
# 1. Cmd+Space → "Terminal"
# 2. cd "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria"
# 3. source .env
# 4. psql "$SUPABASE_DB_URL" -f expansion-packs/creator-os/database/schema.sql
```

---

## 🤔 Qual usar?

- **Comando único?** → Opção 1 (Claude Code)
- **Múltiplos comandos?** → Opção 2 (Terminal)

---

**Isso resolve. 🎯**

Documentação completa: `docs/database/MENSAGEM-PARA-ESTAGIARIO.md`
