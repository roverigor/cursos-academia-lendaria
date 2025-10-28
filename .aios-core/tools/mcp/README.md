# MCP Tools Configuration

Este diretório contém configurações e scripts para os servidores MCP (Model Context Protocol) usados pelo Claude Code.

## 📦 MCPs Instalados

### Ativos (Prontos para Uso)

1. **Supabase MCP** - `supabase`
   - **Descrição**: Gerenciamento completo de projetos e banco de dados Supabase
   - **Autenticação**: OAuth (autenticação via navegador)
   - **Recursos**:
     - Execução de SQL com validação de segurança
     - Gerenciamento de migrações
     - Políticas RLS (Row Level Security)
     - Assinaturas real-time
     - Edge Functions
   - **URL**: https://mcp.supabase.com/mcp
   - **Documentação**: `supabase.yaml`

2. **Filesystem MCP** - `filesystem`
   - **Descrição**: Operações avançadas de sistema de arquivos
   - **Recursos**:
     - Leitura/escrita de arquivos
     - Listagem de diretórios
     - Operações de busca
     - Gerenciamento de permissões
   - **Escopo**: `/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Code/mente_lendaria`

3. **SQLite MCP** - `sqlite`
   - **Descrição**: Operações em banco de dados SQLite
   - **Recursos**:
     - Execução de queries SQL
     - Gerenciamento de schema
     - Análise de dados
   - **Banco de dados**: `outputs/database/mmos.db`

4. **Git MCP** - `git`
   - **Descrição**: Operações Git no repositório
   - **Recursos**:
     - Status, diff, log
     - Commits e branches
     - Push/pull
     - Histórico e análise
   - **Repositório**: Diretório do projeto

### Requerem Configuração

5. **PostgreSQL MCP** - `postgres` (Desabilitado)
   - **Descrição**: Operações diretas em banco de dados PostgreSQL
   - **Configuração necessária**: String de conexão PostgreSQL
   - **Como ativar**: Execute `./setup-mcp-credentials.sh` ou edite manualmente a configuração

6. **GitHub MCP** - `github` (Desabilitado)
   - **Descrição**: Gerenciamento de repositórios GitHub
   - **Configuração necessária**: GitHub Personal Access Token
   - **Como ativar**: Execute `./setup-mcp-credentials.sh` ou edite manualmente a configuração
   - **Recursos**:
     - Issues e Pull Requests
     - Workflows e Actions
     - Releases
     - Análise de código

7. **Brave Search MCP** - `brave-search` (Desabilitado)
   - **Descrição**: Busca na web via Brave Search API
   - **Configuração necessária**: Brave Search API Key
   - **Como obter**: https://brave.com/search/api/
   - **Como ativar**: Execute `./setup-mcp-credentials.sh` ou edite manualmente a configuração

## 🚀 Configuração Rápida

### Método Automático (Recomendado)

Execute o script auxiliar que irá guiá-lo através da configuração:

```bash
cd .aios-core/tools/mcp
./setup-mcp-credentials.sh
```

O script irá:
1. Detectar credenciais existentes em `.env` e `gh CLI`
2. Atualizar automaticamente a configuração do Claude Desktop
3. Habilitar os MCPs configurados

### Método Manual

1. Abra o arquivo de configuração:
   ```bash
   open "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
   ```

2. Para cada MCP que deseja ativar, atualize as credenciais e mude `"disabled": true` para `"disabled": false`

3. Reinicie o Claude Desktop

## 📁 Estrutura de Arquivos

```
.aios-core/tools/mcp/
├── README.md                      # Este arquivo
├── setup-mcp-credentials.sh       # Script de configuração automática
├── supabase.yaml                  # Especificação completa do Supabase MCP
├── browser.yaml                   # Especificação do Browser MCP
├── clickup.yaml                   # Especificação do ClickUp MCP
├── context7.yaml                  # Especificação do Context7 MCP
├── exa.yaml                       # Especificação do Exa MCP
├── google-workspace.yaml          # Especificação do Google Workspace MCP
└── n8n.yaml                       # Especificação do N8N MCP
```

## 🔐 Segurança

- **Nunca** commite o arquivo `claude_desktop_config.json` com credenciais
- Use variáveis de ambiente para credenciais sensíveis
- Os MCPs rodam localmente via `npx` (exceto Supabase que usa SSE)
- Revise as permissões de cada MCP antes de habilitar

## 🛠️ MCPs Disponíveis Adicionalmente

Outros MCPs que podem ser úteis para este projeto:

### Browser MCP
- **Descrição**: Controle de navegador headless
- **Configuração**: Veja `browser.yaml`
- **Uso**: Scraping, testes E2E, automação web

### ClickUp MCP
- **Descrição**: Integração com ClickUp para gerenciamento de tarefas
- **Configuração**: Veja `clickup.yaml`
- **Uso**: Sincronização de stories e tasks

### Google Workspace MCP
- **Descrição**: Acesso a Google Drive, Docs, Sheets
- **Configuração**: Veja `google-workspace.yaml`
- **Uso**: Documentação colaborativa, planilhas

### N8N MCP
- **Descrição**: Integração com N8N para workflows
- **Configuração**: Veja `n8n.yaml`
- **Uso**: Automação de processos, integrações

Para adicionar qualquer um destes, consulte o respectivo arquivo YAML e adicione a configuração ao `claude_desktop_config.json`.

## 🔄 Atualização de MCPs

Os MCPs são baixados via `npx` e sempre usam a versão mais recente. Para forçar atualização:

```bash
# Limpar cache do npx
npx clear-npx-cache

# Ou usar --yes para forçar reinstalação
npx -y @modelcontextprotocol/server-<nome>
```

## 📚 Recursos

- [MCP Documentation](https://modelcontextprotocol.io)
- [MCP Servers Registry](https://github.com/modelcontextprotocol/servers)
- [Supabase MCP Guide](https://supabase.com/docs/guides/ai/mcp)
- [AIOS-FULLSTACK Documentation](../../README.md)

## 🐛 Troubleshooting

### MCP não aparece no Claude Code

1. Verifique se a configuração está correta:
   ```bash
   cat "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
   ```

2. Verifique os logs do Claude Desktop
3. Reinicie o Claude Desktop completamente
4. Tente executar o comando MCP manualmente para verificar erros

### Erro de autenticação

- **Supabase**: Faça login via navegador quando solicitado
- **GitHub**: Verifique se o token tem as permissões necessárias (repo, workflow)
- **PostgreSQL**: Verifique a string de conexão e credenciais

### Performance lenta

- Desabilite MCPs não utilizados
- Use parâmetros `read_only` quando possível (Supabase)
- Limite o escopo dos MCPs (ex: `project_ref` no Supabase)

## 💡 Dicas de Uso

1. **Supabase MCP**: Use `read_only=true` quando apenas consultando dados
2. **Git MCP**: Combine com GitHub MCP para workflow completo
3. **SQLite MCP**: Útil para análise do banco MMOS sem executar scripts Python
4. **Filesystem MCP**: Combine com Git MCP para operações complexas de arquivo

## 📝 Changelog

- **2025-10-28**: Configuração inicial com 7 MCPs
  - Ativos: Supabase, Filesystem, SQLite, Git
  - Requerem configuração: PostgreSQL, GitHub, Brave Search
  - Script de setup automático criado
