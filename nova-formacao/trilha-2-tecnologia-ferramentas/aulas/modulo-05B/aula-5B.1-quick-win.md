# Aula 5B.1: Claude Code em 10 Minutos

## Tipo: Quick Win | Duração: 10 minutos

---

## GPS

### Goal (30s)
Instalar e usar Claude Code CLI para criar um projeto do terminal.

### Position (60s)
IDE com IA é poderoso. CLI com IA é poder absoluto sobre sua máquina.

### Steps
1. Instalar Claude Code (2 min)
2. Primeiro comando (3 min)
3. Criar projeto (5 min)

---

## O que é Claude Code?

```
Terminal normal:         Terminal com Claude:
$ mkdir projeto         $ "crie projeto node com express e typescript"
$ cd projeto           (Claude cria tudo automaticamente)
$ npm init
$ npm install express
$ npm install typescript
$ touch tsconfig.json
$ touch src/index.ts
...
```

**Claude Code = conversar com seu computador.**

---

## Passo 1: Instalação

### Requisitos
- Node.js 18+
- Conta Anthropic (para API key)

### Instalar

```bash
npm install -g @anthropic-ai/claude-code
```

### Configurar API Key

```bash
export ANTHROPIC_API_KEY="sua-chave-aqui"
```

Para pegar a chave: https://console.anthropic.com

### Verificar Instalação

```bash
claude --version
```

---

## Passo 2: Primeiro Comando

### Modo Interativo

```bash
claude
```

Você entra no modo de conversa. Digite:

```
Qual é a data de hoje?
```

Claude responde usando comandos do sistema.

### Modo Direto

```bash
claude "liste os arquivos desta pasta ordenados por tamanho"
```

Claude executa `ls -lhS` ou equivalente.

---

## Passo 3: Criar Projeto

### O Poder Real

Digite no terminal:

```bash
claude
```

Depois peça:

```
Crie um projeto Node.js com:
- Express
- TypeScript
- Endpoint GET /api/health que retorna status
- Endpoint GET /api/users que retorna lista mockada
- README.md com instruções
- Script de dev com nodemon
```

### O que Claude faz:

1. Cria pasta do projeto
2. Inicializa package.json
3. Instala dependências
4. Cria tsconfig.json
5. Cria arquivos de código
6. Cria README.md
7. Configura scripts

**Tudo conversando em português.**

---

## Comparativo: CLI vs IDE

| Situação | Melhor Ferramenta |
|----------|-------------------|
| Escrever código em arquivo | IDE (Cursor) |
| Criar estrutura de projeto | CLI (Claude Code) |
| Refatorar código existente | IDE (Cursor) |
| Automações e scripts | CLI (Claude Code) |
| Debug visual | IDE (Cursor) |
| Tarefas de sistema | CLI (Claude Code) |
| Editar múltiplos arquivos | Ambos |

### Regra Simples

```
Precisa de interface visual? → IDE
Quer automatizar ou operar sistema? → CLI
```

---

## Exemplos de Uso Real

### Automações

```
"A cada arquivo .md nesta pasta, crie um arquivo .pdf correspondente"
```

```
"Renomeie todos os arquivos .jpeg para .jpg"
```

```
"Encontre todos os TODOs no código e liste em um arquivo todo.md"
```

### Análise

```
"Analise o package.json e me diga se tem dependências desatualizadas"
```

```
"Qual é a estrutura deste projeto? Desenhe uma árvore"
```

```
"Tem algum problema de segurança nos arquivos de configuração?"
```

### Código

```
"Crie um script Python que faz backup desta pasta para S3"
```

```
"Crie uma CLI em Node que converte CSV para JSON"
```

```
"Adicione eslint e prettier a este projeto com configuração padrão"
```

---

## Atalhos Úteis

| Comando | O que faz |
|---------|-----------|
| `claude` | Modo interativo |
| `claude "..."` | Executa e sai |
| `claude --help` | Ajuda |
| `Ctrl + C` | Cancelar |
| `exit` | Sair do modo interativo |

---

## Seu Primeiro Projeto

### Crie agora:

```bash
claude
```

```
Crie um CLI em Node.js que:
- Recebe um número como argumento
- Calcula fatorial
- Mostra resultado formatado
- Trata erro se não for número

Nome do projeto: meu-cli
```

### Teste:

```bash
cd meu-cli
npm install
node index.js 5
# Resultado: 5! = 120
```

---

## Reflexão

| Pergunta | Resposta |
|----------|----------|
| O que mais te impressionou? | |
| Onde você usaria isso? | |
| É mais fácil que IDE? | Sim / Não / Depende |

---

## Próximo Passo

Na próxima aula, vamos combinar Claude Code com Supabase para criar stack full profissional.
