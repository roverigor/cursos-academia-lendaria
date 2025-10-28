# 📢 IMPORTANTE: Como Resolver o Erro de Conexão

**Para:** Estagiário
**De:** Time de Database
**Data:** 2025-10-28

---

## 🎯 O Que Está Acontecendo

Você está tentando conectar ao banco de dados **dentro do Claude Code**, mas o Claude Code está **bloqueado (sandbox)** e **não consegue conectar** ao Supabase.

**Isso NÃO é culpa sua. É uma limitação do ambiente.**

---

## ✅ Solução Simples (2 opções)

### Opção 1: Usar Claude Code (Mais Fácil) ⭐

**Basta pedir para desabilitar o sandbox:**

```
"Por favor, rode este comando com dangerouslyDisableSandbox: true"
```

Então o Claude Code vai executar:
```bash
psql "$SUPABASE_DB_URL" -f expansion-packs/creator-os/database/schema.sql
```

**Exemplo de mensagem completa:**
```
"Por favor, rode este comando com dangerouslyDisableSandbox: true:
psql "$SUPABASE_DB_URL" -f expansion-packs/creator-os/database/schema.sql"
```

### Opção 2: Usar Terminal.app (Mais Seguro)

```bash
# 1. Pressione: Cmd + Space → Digite "Terminal" → Enter

# 2. Navegar para o projeto:
cd "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria"

# 3. Validar ambiente:
./supabase/db-env-check.sh

# 4. Rodar comando:
source .env
psql "$SUPABASE_DB_URL" -f expansion-packs/creator-os/database/schema.sql
```

---

## 🤔 Qual Opção Usar?

| Situação | Use |
|----------|-----|
| Comando único, já sabe o que está fazendo | Opção 1 (Claude Code com sandbox desabilitado) |
| Múltiplos comandos, exploração | Opção 2 (Terminal.app) |
| Primeira vez, aprendendo | Opção 2 (Terminal.app) |
| Produção, mudanças críticas | Opção 2 (Terminal.app) |

---

## 🤔 Por Que Isso Acontece?

**Claude Code = Bloqueado para Conexões Externas**
- O Claude Code roda em um "sandbox" (ambiente isolado)
- Ele SÓ pode conectar a alguns sites específicos:
  - github.com ✅
  - claude.ai ✅
  - Supabase ❌ (bloqueado)

**Terminal.app = Sem Bloqueios**
- O terminal normal do macOS não tem essas restrições
- Ele pode conectar ao Supabase normalmente

---

## 📋 Regra Simples

```
Claude Code → Planejar, escrever código, documentar
Terminal.app → Executar comandos de banco de dados
```

### Use Claude Code Para:
- ✅ Escrever SQL
- ✅ Criar migrations
- ✅ Planejar schema
- ✅ Gerar documentação
- ✅ Revisar código

### Use Terminal.app Para:
- ✅ Conectar ao banco
- ✅ Rodar migrations
- ✅ Executar queries
- ✅ Testar conexão
- ✅ Fazer backup

---

## 🎯 Exemplo Prático

**Você quer aplicar uma migration:**

### ❌ Jeito Errado (Não Vai Funcionar):
```bash
# No Claude Code:
# Bash command: psql "$SUPABASE_DB_URL" -f migration.sql
# → Resultado: DNS error ❌
```

### ✅ Jeito Certo (Vai Funcionar):
```bash
# 1. Abrir Terminal.app (Cmd+Space → "Terminal")

# 2. Ir para o projeto:
cd "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria"

# 3. Validar ambiente:
./supabase/db-env-check.sh

# 4. Rodar comando:
source .env
psql "$SUPABASE_DB_URL" -f expansion-packs/creator-os/database/schema.sql
```

---

## 💡 Workflow Recomendado

```
1. Claude Code (Planejamento)
   ↓
   "DB Sage, me ajuda a criar uma migration para X"
   → Gera o arquivo SQL

2. Terminal.app (Execução)
   ↓
   cd "/caminho/do/projeto"
   ./supabase/db-env-check.sh
   psql "$SUPABASE_DB_URL" -f migration.sql

3. Claude Code (Documentação)
   ↓
   "Atualizar docs com a migration aplicada"
   → Atualiza changelog
```

---

## 🆘 Se Ainda Não Funcionar

### Se der erro no Terminal.app também:

1. **Verifique se está no terminal certo:**
   - Deve ser Terminal.app
   - NÃO deve ser o terminal do Claude Code

2. **Rode o script de validação:**
   ```bash
   ./supabase/db-env-check.sh
   ```

3. **Se mostrar erros em vermelho:**
   - Leia a mensagem de erro
   - Abra: `docs/database/TROUBLESHOOTING.md`
   - Siga as instruções

4. **Se ainda tiver problemas depois de 5 minutos:**
   - Chame o Alan ou time lead
   - Mostre a saída do script de validação
   - Mostre o erro exato

---

## 📚 Documentos Úteis

| Documento | Para Que Serve |
|-----------|----------------|
| `supabase/PRE-FLIGHT-CHECKLIST.md` | Checklist antes de trabalhar |
| `docs/database/TROUBLESHOOTING.md` | Resolver erros |
| `supabase/QUICK-REFERENCE.md` | Referência rápida |
| `docs/database/CLAUDE-CODE-SANDBOX-ISSUE.md` | Entender o sandbox |

---

## ✅ Checklist Rápido

Antes de rodar qualquer comando de banco de dados:

- [ ] Estou no Terminal.app? (NÃO no Claude Code)
- [ ] Rodei `./supabase/db-env-check.sh`?
- [ ] Todos os checks passaram (verde ✅)?
- [ ] Tenho o `.env` configurado?

Se todas as respostas forem SIM → Pode rodar o comando!

---

## 🎯 Resumo Ultra-Simplificado

**Problema:**
Claude Code não conecta ao Supabase (é bloqueado)

**Solução:**
Use Terminal.app em vez de Claude Code

**Como:**
1. Cmd+Space → "Terminal"
2. `cd "/caminho/do/projeto"`
3. `./supabase/db-env-check.sh`
4. `psql "$SUPABASE_DB_URL" ...`

---

## 💬 Perguntas Frequentes

**P: Por que o Claude Code não avisa que está bloqueado?**
R: Porque ele tenta fazer a conexão normalmente, mas o sistema operacional bloqueia. O erro de DNS é o sintoma disso.

**P: Posso desbloquear o Claude Code?**
R: Tecnicamente sim (com `dangerouslyDisableSandbox: true`), mas é mais fácil e seguro usar Terminal.app.

**P: Vou ter que fazer isso sempre?**
R: Sim, para operações de banco. Claude Code = código. Terminal.app = banco de dados.

**P: Mas é chato ter que trocar de terminal...**
R: Sim, mas é por segurança. E você se acostuma rápido. O workflow fica natural depois de 2-3 vezes.

---

**Se tiver qualquer dúvida, pergunte! Ninguém nasce sabendo. 😊**

---

**Criado em:** 2025-10-28
**Para:** Onboarding e troubleshooting
**Status:** ✅ Pronto para uso
