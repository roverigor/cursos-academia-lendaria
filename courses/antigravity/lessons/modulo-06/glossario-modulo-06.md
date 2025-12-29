# 📖 Glossário do Módulo 6: Segurança Básica

**Curso:** Google Antigravity Essencial
**Professor:** Lucas Charao
**Uso:** Referência rápida durante e depois das aulas

---

## 📌 Como Usar Este Glossário

- **Durante a aula:** Consulte quando o professor mencionar um termo novo
- **Depois da aula:** Use como referência ao configurar segurança
- **Nos estudos:** Imprima o checklist e cole do lado do monitor

**Organização:** Alfabética (A-Z)

---

## A

### Allow List (Lista de Permissão)
Lista de itens que são PERMITIDOS. Tudo que não está na lista é bloqueado automaticamente.

**No Antigravity:**
- URL Allowlist = lista de sites que o agente pode acessar
- Tudo fora da lista é bloqueado

**Quando usar:** Quando você quer máximo controle. Só libera o necessário.

**Ver também:** Deny List, URL Allowlist

---

### Arquivo Sensível
Qualquer arquivo que contém informações que não devem ser expostas: senhas, chaves de API, dados de clientes, configurações de produção.

**Exemplos:**
- `.env` - variáveis de ambiente com senhas
- `secrets/` - pasta com segredos
- `dados-clientes.json` - informações pessoais
- `*.production.*` - configurações de produção

**O que fazer:** Adicionar na Deny List pra proteger do agente.

**Ver também:** Deny List

---

## B

### Backup
Cópia de segurança dos seus arquivos pra poder restaurar se algo der errado.

**Formas de backup:**
- Git (recomendado) - histórico completo de mudanças
- Cópia manual - duplicar a pasta
- Serviços de nuvem - Google Drive, Dropbox

**Por que é crítico:** Se o agente fizer algo errado, você pode voltar atrás.

**Regra:** SEMPRE tenha backup antes de pedir mudanças grandes.

---

## C

### Camadas de Segurança
Conceito de usar MÚLTIPLAS proteções, não só uma. Se uma falhar, as outras ainda protegem.

**No Antigravity:**
1. Controle de Execução (políticas)
2. Proteção de Arquivos (Deny List)
3. Controle de Navegação (URL Allowlist)

**Analogia:** É como ter fechadura, alarme E câmera em casa. Uma camada reforça a outra.

---

### Checklist
Lista de verificação pra garantir que você não esqueceu nada importante.

**Quando usar:**
- Projeto novo → checklist completo
- Tarefa importante → checklist rápido
- Mensalmente → revisão de configurações

**Por que usar:** Profissionais usam checklists. Pilotos, médicos, engenheiros...

---

### Credenciais
Informações usadas pra autenticação: senhas, chaves de API, tokens de acesso.

**Onde ficam:**
- Arquivos `.env`
- Arquivos de configuração
- Variáveis de ambiente

**NUNCA:** Deixe credenciais acessíveis ao agente. SEMPRE adicione na Deny List.

**Ver também:** Arquivo Sensível

---

## D

### Deny List (Lista de Bloqueio)
Lista de itens que são BLOQUEADOS. Tudo que não está na lista é permitido.

**No Antigravity:**
- Deny List de comandos = comandos que o agente não pode executar
- Deny List de arquivos = arquivos que o agente não pode acessar

**Quando usar:** Quando você quer liberdade com exceções específicas.

**Ver também:** Allow List

---

## L

### Localhost
Endereço que representa "este computador". Usado pra desenvolvimento local.

**Endereços localhost:**
- `localhost`
- `127.0.0.1`
- `localhost:3000` (com porta)

**Na URL Allowlist:** Sempre inclua localhost pra testar seu site local.

---

## P

### Proteção em Profundidade
Mesmo que "Camadas de Segurança". Usar várias proteções sobrepostas.

**Filosofia:** Não confie em uma única proteção. Use várias.

**Ver também:** Camadas de Segurança

---

## R

### Ritual de Verificação
Rotina rápida que você faz antes de tarefas importantes pra garantir segurança.

**Ritual de 30 segundos:**
1. É complexo? → Planning Mode
2. Vou ler o plano antes de aprovar
3. Vou ver o Code Diff antes de aceitar

**Por que funciona:** Consistência previne erros.

---

## S

### Subdomínio
Parte que vem antes do domínio principal. Permite organizar um site em seções.

**Exemplos:**
- `admin.meunegocio.com.br` → subdomínio "admin"
- `api.meunegocio.com.br` → subdomínio "api"
- `loja.meunegocio.com.br` → subdomínio "loja"

**Na URL Allowlist:** Use `*.meunegocio.com.br` pra liberar todos os subdomínios.

---

## U

### URL Allowlist
Lista de URLs (endereços de sites) que o agente pode acessar no Browser Integrado.

**Onde configurar:** Settings > Browser Security > URL Allowlist

**Exemplo de lista:**
```
localhost
127.0.0.1
meunegocio.com.br
*.meunegocio.com.br
```

**Ver também:** Allow List, Wildcard

---

## W

### Wildcard (*)
Caractere especial que significa "qualquer coisa". Usado pra criar padrões flexíveis.

**Exemplos:**
- `*.env*` → qualquer arquivo com "env" no nome
- `*.production.*` → qualquer arquivo com "production" no nome
- `*.meunegocio.com.br` → qualquer subdomínio do site

**Cuidado:** Wildcards muito amplos podem liberar/bloquear mais do que você quer.

---

## 📊 Comparativo Allow List vs Deny List

| Aspecto | Allow List | Deny List |
|---------|------------|-----------|
| **Padrão** | Tudo bloqueado | Tudo liberado |
| **Exceções** | Lista o que PODE | Lista o que NÃO PODE |
| **Segurança** | Mais restritivo | Mais flexível |
| **Uso comum** | URLs (sites) | Arquivos, comandos |
| **Manutenção** | Adiciona conforme precisa | Remove conforme confia |

---

## 📁 Resumo das Configurações de Segurança

```
CONFIGURAÇÕES DE SEGURANÇA - ONDE ENCONTRAR:

Settings > Execution
├── Terminal Policy        ← OFF/AUTO/TURBO
└── Command Deny List      ← Comandos bloqueados

Settings > File Access
└── File Deny List         ← Arquivos bloqueados

Settings > Browser Security
└── URL Allowlist          ← Sites permitidos
```

---

## 💡 Dicas de Segurança

1. **Comece restritivo:** Bloqueie mais, libere depois conforme precisar.

2. **Use Git:** É seu melhor backup e permite voltar atrás facilmente.

3. **Revise mensalmente:** Suas necessidades mudam, suas configurações também.

4. **Não confie só em uma camada:** Use políticas + Deny List + Allowlist juntas.

5. **Planning Mode pra mudanças grandes:** Sempre revise o plano antes de executar.

---

## 📚 Glossários Relacionados

- **Módulo 1:** Termos básicos (Agent Manager, Editor View)
- **Módulo 2:** Termos de controle (Planning Mode, Políticas)
- **Módulo 3:** Termos sobre Artifacts
- **Módulo 4:** Termos sobre Atalhos
- **Módulo 5:** Termos sobre Rules e Workflows

---

**Última atualização:** 2025-12-17
**Criado por:** Course Architect Agent

---

**Imprima o checklist e cole do lado do monitor! 📖**
