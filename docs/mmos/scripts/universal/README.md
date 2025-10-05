# 🚀 Content Collector Universal

Sistema modular para coletar conteúdo de QUALQUER persona/influencer de forma automatizada.

**IMPORTANTE**: Este sistema é UNIVERSAL e não contém dados específicos de nenhuma persona. Cada persona deve ter sua configuração em sua própria pasta.

## 📋 Características

- ✅ **Modular**: Funciona para qualquer persona
- ✅ **Configurável**: JSON único com todas as configurações
- ✅ **Escalável**: Adicione novas personas facilmente
- ✅ **Análise Automática**: Identifica padrões linguísticos
- ✅ **Multi-fonte**: YouTube, Blog, Podcast (futuro)

## 📁 Estrutura Necessária

Cada persona deve ter sua própria pasta com um arquivo `config.json`:

```
[Nome da Persona]/
├── config.json           # Configuração específica
├── content/              # Conteúdo baixado
├── sources/              # Materiais fonte
└── ...

## 🔧 Instalação

```bash
# 1. Navegue até a pasta
cd 0_Claude_Code/scripts/universal/

# 2. Instale dependências
pip install -r requirements.txt
```

## 🎮 Como Usar

### Comando Principal

```bash
# Coletar tudo de uma persona (10 items padrão)
python content_collector.py mark_manson

# Coletar com quantidade específica
python content_collector.py dan_koe --items 20

# Coletar apenas YouTube
python content_collector.py alex_hormozi --youtube

# Coletar apenas Blog
python content_collector.py naval_ravikant --blog

# Listar personas disponíveis
python content_collector.py --list
```

### Scripts Individuais

```bash
# YouTube específico
python youtube_downloader.py mark_manson --videos 10

# Blog específico
python blog_downloader.py dan_koe --articles 15

# Com URLs específicas
python youtube_downloader.py alex_hormozi --urls "url1" "url2"
```

## ⚙️ Configuração de Nova Persona

1. Crie uma pasta para a persona: `mkdir "Nome da Persona"`
2. Copie o template: `cp config_template.json "../Nome da Persona/config.json"`
3. Edite o `config.json` com as informações específicas:

```json
{
  "name": "Nome Completo",
  "id": "identificador_unico",
  "youtube": {
    "channel_url": "https://youtube.com/@canal",
    "channel_id": "UCxxxxxx",
    "known_videos": []
  },
  "blog": {
    "base_url": "https://site.com",
    "article_selector": "article",
    "content_selector": ".post-content",
    "archive_url": "/blog",
    "main_articles": ["/artigo1", "/artigo2"]
  },
  "patterns": {
    "signature_words": ["palavra1", "palavra2"],
    "track_profanity": false,
    "track_questions": true
  }
}
```

## 📁 Estrutura de Output

```
[Persona Name]/
├── content/
│   ├── articles/     # Artigos do blog (.md + .json)
│   ├── videos/       # Transcrições YouTube (.md + .json)
│   ├── podcasts/     # Podcasts (futuro)
│   ├── books/        # Livros processados
│   └── social/       # Redes sociais (futuro)
├── analysis/
│   └── content_analysis.json  # Análise de padrões
├── prompts/          # Prompts gerados (futuro)
└── RELATORIO_COLETA.md  # Relatório da coleta
```

## 📊 Análise Automática

O sistema analisa automaticamente:

- **Padrões Linguísticos**: Palavras signature da persona
- **Estrutura de Conteúdo**: Headers, parágrafos, listas
- **Métricas**: Word count, tempo de leitura
- **Vocabulário**: Frequência de termos importantes
- **Questões**: Contagem de perguntas (se configurado)
- **Profanidade**: Tracking de palavrões (se configurado)

## 🔍 Formatos de Saída

### Markdown (.md)
- Formato legível humano
- Metadata estruturada
- Trechos representativos
- Análise de padrões

### JSON (.json)
- Dados estruturados
- Metadata completa
- Análise quantitativa
- Pronto para processamento

## 🛠️ Troubleshooting

### YouTube não baixa transcrições
```bash
# Verifique se o vídeo tem legendas
# Use URLs específicas em vez do canal
python youtube_downloader.py persona --urls "url_do_video"
```

### Blog retorna vazio
```bash
# Ajuste seletores no config_personas.json
"content_selector": ".entry-content",  # Tente diferentes seletores
"article_selector": "main"
```

### Erro de importação
```bash
pip install --upgrade -r requirements.txt
```

## 📝 Workflow Completo

1. **Configurar Persona** → `config_personas.json`
2. **Coletar Conteúdo** → `python content_collector.py persona`
3. **Revisar Relatório** → `[Persona]/RELATORIO_COLETA.md`
4. **Analisar Padrões** → `[Persona]/analysis/content_analysis.json`
5. **Criar Inferências** → Usar dados para criar clone

## 🚦 Status dos Scripts

| Script | Status | Descrição |
|--------|--------|-----------|
| content_collector.py | ✅ Pronto | Coordenador principal |
| youtube_downloader.py | ✅ Pronto | Download YouTube universal |
| blog_downloader.py | ✅ Pronto | Download blog universal |
| config_personas.json | ✅ Pronto | Configurações de personas |

## 🔄 Atualizações Futuras

- [ ] Twitter/X downloader
- [ ] Podcast transcript downloader
- [ ] Instagram content analyzer
- [ ] Book PDF processor
- [ ] Auto-prompt generator
- [ ] Pattern inference engine

## 💡 Dicas

1. **Comece pequeno**: Teste com 5-10 items primeiro
2. **Verifique configuração**: Use `--list` para confirmar
3. **Analise padrões**: Revise `/analysis/` após coleta
4. **Itere**: Ajuste configuração baseado nos resultados

## 📄 Licença

Projeto interno - Academia Lendar[IA]

---

**Última atualização**: 25/09/2025
**Versão**: 1.0.0