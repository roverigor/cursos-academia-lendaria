# 🔧 Tools Guide - Clone System

Guia de ferramentas disponíveis para todas as etapas do pipeline de clonagem.

---

## 🚀 Ferramentas Nativas Claude Code (Zero Setup)

Estas ferramentas estão **sempre disponíveis** em qualquer computador com Claude Code:

### WebSearch
**Função**: Busca web
**Uso em**:
- Etapa 1 (Viability): Avaliar disponibilidade de fontes
- Etapa 2 (Research): Descobrir fontes primárias
- Todas as etapas: Pesquisa contextual

**Exemplo**:
```
"Use WebSearch para buscar livros escritos por Naval Ravikant"
"Search for 'Tim Ferriss podcast interviews'"
```

---

### WebFetch
**Função**: HTTP requests e extração de conteúdo web
**Uso em**:
- Etapa 2 (Research): Coletar artigos e blog posts
- Etapa 3 (Analysis): Acessar fontes online
- Todas as etapas: Fetch de conteúdo

**Exemplo**:
```
"Use WebFetch para extrair o conteúdo de https://nav.al"
"Fetch https://example.com/article.html"
```

---

### Bash
**Função**: Comandos sistema e automação
**Uso em**:
- Todas as etapas: Organização de arquivos, processamento
- Etapa 2 (Research): yt-dlp, estrutura de pastas
- Etapa 4 (Synthesis): Processamento de KB

**Exemplo**:
```bash
# Criar estrutura
mkdir -p sources/{books,interviews,articles}

# YouTube
yt-dlp --write-auto-sub --skip-download VIDEO_URL

# Processar
find sources/ -name "*.txt" -exec wc -l {} \;
```

---

### Read/Write/Edit
**Função**: Manipulação de arquivos
**Uso em**:
- Todas as etapas: Leitura e escrita de arquivos
- Etapa 3 (Analysis): Análise de fontes
- Etapa 5 (Implementation): Criação de system prompts

**Exemplo**:
```
"Use Read para ler sources/interviews/*/transcript.txt"
"Use Write para criar metadata.yaml"
"Use Edit para atualizar PRD.md"
```

---

## 📦 Ferramentas Externas (Requer Instalação)

### yt-dlp
**Status**: Provavelmente já instalado
**Função**: Download de vídeos/áudio do YouTube

**Instalação** (se necessário):
```bash
# macOS
brew install yt-dlp

# Linux/Windows
pip3 install yt-dlp
```

**Verificar**:
```bash
yt-dlp --version
```

**Uso comum**:
```bash
# Apenas legendas
yt-dlp --write-auto-sub --skip-download VIDEO_URL

# Apenas áudio
yt-dlp -x --audio-format mp3 VIDEO_URL

# Listar legendas disponíveis
yt-dlp --list-subs VIDEO_URL
```

---

## 🔌 MCPs Opcionais (Avançado)

Model Context Protocol servers para recursos avançados.

### Filesystem MCP
**Status**: ✅ Mantido e atual
**Função**: Operações avançadas de sistema de arquivos

**Instalação**:
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**Configuração** (`claude_desktop_config.json`):
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"],
      "env": {
        "ALLOWED_DIRECTORIES": "/path/to/project"
      }
    }
  }
}
```

**Uso**: Operações complexas de arquivos quando ferramentas nativas não são suficientes

---

## 📊 Tabela de Uso por Etapa

| Etapa | Ferramentas Principais | Opcional |
|-------|----------------------|----------|
| **1. Viability** | WebSearch, Read/Write | - |
| **2. Research** | WebSearch, WebFetch, Bash, yt-dlp | Filesystem MCP |
| **3. Analysis** | Read, WebFetch | - |
| **4. Synthesis** | Read, Write, Bash | Filesystem MCP |
| **5. Implementation** | Write, Edit | - |
| **6. Testing** | Read, Bash | - |

---

## 🎯 Recomendações

### Para Iniciantes
Use **apenas ferramentas nativas**:
- WebSearch
- WebFetch
- Bash
- Read/Write/Edit

**Vantagem**: Zero configuração, funciona em qualquer máquina.

### Para Avançados
Adicione **yt-dlp** quando precisar de YouTube:
```bash
brew install yt-dlp  # ou pip3 install yt-dlp
```

### Para Power Users
Configure **MCPs** para automação avançada (opcional).

---

## 🔧 Setup em Novo Computador

**Mínimo** (0 minutos):
- ✅ WebSearch (já disponível)
- ✅ WebFetch (já disponível)
- ✅ Bash (já disponível)
- ✅ Read/Write (já disponível)

**Recomendado** (~1 minuto):
```bash
# Adicionar yt-dlp
brew install yt-dlp
# ou
pip3 install yt-dlp
```

**Avançado** (opcional):
- Configurar MCPs conforme necessidade

---

## 📚 Documentação Específica

- **Research detalhado**: [2_research/docs/](../2_research/docs/)
- **AIOS Workflow**: [AIOS_WORKFLOW.md](AIOS_WORKFLOW.md)
- **Outputs Guide**: [OUTPUTS_GUIDE.md](OUTPUTS_GUIDE.md)

---

*Tools Guide - Transversal - v1.0*
*Criado em 04/10/2025*
