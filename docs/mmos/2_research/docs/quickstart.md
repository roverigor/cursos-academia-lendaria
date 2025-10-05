# ⚡ Research Quick Start

Guia rápido para começar research com ferramentas nativas.

---

## 🚀 Ferramentas Disponíveis (Zero Setup)

```
✅ WebSearch  → busca web
✅ WebFetch   → scraping e fetch
✅ Bash       → comandos sistema
✅ yt-dlp     → YouTube (provavelmente já instalado)
```

---

## 📋 Comandos Copy-Paste

### Source Discovery

```
"Use WebSearch para buscar livros escritos por [NOME]"
"Use WebSearch para encontrar entrevistas longas (>30min) com [NOME]"
"Use WebSearch para descobrir podcasts principais de [NOME]"
```

### Source Collection - Web

```
"Use WebFetch para extrair o conteúdo de [URL]"
"Use WebFetch para coletar posts de [BLOG_URL]"
```

### Source Collection - YouTube

```bash
# Baixar legendas/transcrição
yt-dlp --write-auto-sub --skip-download [VIDEO_URL]

# Baixar áudio
yt-dlp -x --audio-format mp3 [VIDEO_URL]
```

### Organização

```
"Use Bash para criar estrutura: sources/{books,interviews,articles,videos}"
"Use Write para criar metadata.yaml para cada fonte com: titulo, data, url, tipo"
```

---

## ✅ Checklist Novo Computador

Ao abrir projeto em outra máquina:

- [ ] WebSearch funciona (nativo)
- [ ] WebFetch funciona (nativo)
- [ ] yt-dlp instalado? `yt-dlp --version`
  - Se não: `brew install yt-dlp` (macOS) ou `pip3 install yt-dlp`

**Tempo**: ~1 minuto

---

## 🔧 Troubleshooting

**WebSearch sem resultados:**
- Adicione aspas: `"Naval Ravikant"`
- Use operadores: `Naval Ravikant AND (book OR podcast)`

**WebFetch bloqueado:**
- Alguns sites bloqueiam bots
- Tente URL alternativa
- Ou download manual + Read

**yt-dlp legendas indisponíveis:**
```bash
# Verificar legendas disponíveis
yt-dlp --list-subs [VIDEO_URL]

# Tentar idioma específico
yt-dlp --write-sub --sub-lang en --skip-download [VIDEO_URL]
```

---

*Quick Start - v1.0*
