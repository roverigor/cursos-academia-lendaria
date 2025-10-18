# 📸 GUIA RÁPIDO - CAPTURA DE SCREENSHOTS

**Objetivo:** Facilitar a captura organizada de todos os screenshots necessários

---

## 🚀 SETUP INICIAL

### 1. Criar Pasta de Assets
```bash
cd outputs/courses/dominando-obsidian
mkdir -p assets
```

### 2. Instalar Obsidian (se ainda não tem)
- **Mac:** https://obsidian.md/download
- **Windows:** https://obsidian.md/download
- **iOS:** App Store
- **Android:** Play Store

### 3. Criar Vault de Demonstração
```bash
# Criar vault com estrutura PARA para screenshots
mkdir -p ~/obsidian-demo-vault
```

---

## 📋 CHECKLIST DE CAPTURAS (42 Total)

### MÓDULO 1 - INSTALAÇÃO E INTERFACE (19 screenshots)

#### Lição 1.3 - Instalação (8 screenshots)
```
[ ] 1.3-download-page.png         - https://obsidian.md/download
[ ] 1.3-mac-dmg.png                - Janela DMG aberta
[ ] 1.3-mac-security.png           - Dialog de segurança macOS
[ ] 1.3-windows-install.png        - Instalador Windows
[ ] 1.3-create-vault.png           - Dialog de criar vault
[ ] 1.3-ios-appstore.png           - Obsidian na App Store
[ ] 1.3-android-playstore.png      - Obsidian no Play Store
[ ] 1.3-mobile-sync.png            - Config sync no mobile
```

**Como capturar:**
1. Abrir https://obsidian.md/download
2. Cmd+Shift+4 (Mac) ou Win+Shift+S (Windows)
3. Salvar como `1.3-download-page.png` na pasta assets/
4. Repetir para cada item

#### Lição 1.4 - Interface (11 screenshots)
```
[ ] 1.4-desktop-layout.png         - Interface completa (criar diagrama)
[ ] 1.4-mobile-layout.png          - Interface mobile (criar diagrama)
[ ] 1.4-settings-menu.png          - Settings aberto
[ ] 1.4-editor-settings.png        - Settings > Editor
[ ] 1.4-files-links.png            - Settings > Files & Links
[ ] 1.4-appearance.png             - Settings > Appearance
[ ] 1.4-hotkeys.png                - Settings > Hotkeys (buscar "quick")
[ ] 1.4-ribbon-icons.png           - Ribbon vertical esquerdo
[ ] 1.4-sidebar-tabs.png           - Files/Search/Bookmarks tabs
[ ] 1.4-split-editor.png           - Editor dividido (Cmd+P > "split")
[ ] 1.4-mobile-gestures.png        - Diagrama de gestos (criar)
```

**Como capturar:**
1. Abrir Obsidian
2. Cmd+, (abrir Settings)
3. Navegar para cada seção
4. Capturar screenshot de cada painel
5. Para split: Cmd+P > "split vertical" > capturar

---

### MÓDULO 2 - MARKDOWN (9 screenshots/imagens)

#### Lição 2.1 - Markdown (9 exemplos visuais)
```
[ ] 2.1-headers.png                - Edit vs Preview de headers
[ ] 2.1-emphasis.png               - Bold, italic, highlight
[ ] 2.1-lists.png                  - Listas bullet e numeradas
[ ] 2.1-links.png                  - Links externos e [[internos]]
[ ] 2.1-code.png                   - Inline code e code blocks
[ ] 2.1-tables.png                 - Sintaxe vs tabela renderizada
[ ] 2.1-checkboxes.png             - [ ] e [x] checkboxes
[ ] 2.1-callouts.png               - [!note], [!warning], etc
[ ] 2.1-cheatsheet.png             - Infográfico resumo (criar)
```

**Como capturar:**
1. Criar nota `Markdown Examples.md`
2. Escrever cada sintaxe
3. Cmd+E (toggle preview)
4. Capturar split view mostrando Edit | Preview lado a lado
5. Para cheatsheet: criar no Figma/Canva

---

### MÓDULO 3 - ORGANIZAÇÃO (5 diagramas/screenshots)

#### Lição 3.1 - Estrutura PARA (5 diagramas)
```
[ ] 3.1-para-structure.png         - Árvore de 7 pastas (criar)
[ ] 3.1-anti-patterns.png          - Exemplo ruim (criar)
[ ] 3.1-para-empreendedor.png      - PARA para empreendedor (criar)
[ ] 3.1-para-estudante.png         - PARA para estudante (criar)
[ ] 3.1-file-explorer.png          - Sidebar com PARA montado
```

**Como capturar:**
1. Criar vault demo com estrutura PARA:
   ```
   Inbox/
   Projects/
   Areas/
   Resources/
   Archives/
   Attachments/
   Templates/
   ```
2. Capturar sidebar esquerdo (Files pane)
3. Para diagramas: criar no Excalidraw ou Figma

#### Lição 3.2 - Tags (1 screenshot)
```
[ ] 3.2-tags.png                   - Tag pane + nested tags
```

#### Lição 3.3 - Properties (1 screenshot)
```
[ ] 3.3-properties.png             - Properties editor
```

---

### MÓDULO 4 - CONEXÕES E GRAFO (10 screenshots)

#### Lição 4.1 - Links (2 screenshots)
```
[ ] 4.1-links-autocomplete.png     - [[ dropdown suggestions
[ ] 4.1-backlinks.png              - Backlinks panel
```

#### Lição 4.2 - Graph View (7 screenshots) ⭐ PRIORIDADE
```
[ ] 4.2-graph-empty.png            - Grafo com 5-10 notas
[ ] 4.2-graph-connected.png        - Grafo denso 50+ notas
[ ] 4.2-graph-filters.png          - Painel de filtros
[ ] 4.2-graph-colors.png           - Color groups ativos
[ ] 4.2-local-graph.png            - Local graph de uma nota
[ ] 4.2-graph-analysis.png         - Diagram anotado (criar)
[ ] 4.2-graph-evolution.png        - Dia 1 | Mês 1 | Mês 6 (criar)
```

**Como capturar Graph:**
1. Criar vault demo com:
   - Versão 1: 5 notas sem links (empty)
   - Versão 2: 50+ notas com links (connected)
2. Abrir Graph View (Cmd+G)
3. Capturar diferentes estados
4. Para filtros: abrir sidebar de filtros
5. Para colors: Settings > Graph View > Color groups

#### Lição 4.3 - Canvas (1 screenshot)
```
[ ] 4.3-canvas.png                 - Canvas com cards conectados
```

---

### MÓDULO 5 - PLUGINS (7 screenshots)

#### Lição 5.1 - Plugins Essenciais (7 screenshots)
```
[ ] 5.1-enable-plugins.png         - "Turn off safe mode" dialog
[ ] 5.1-browse-plugins.png         - Browse community plugins
[ ] 5.1-calendar.png               - Calendar sidebar ativo
[ ] 5.1-dataview.png               - Query + tabela renderizada
[ ] 5.1-templater.png              - Template com campos dinâmicos
[ ] 5.1-excalidraw.png             - Drawing exemplo
[ ] 5.1-plugins-list.png           - Lista de instalados
```

**Como capturar Plugins:**
1. Settings > Community Plugins
2. Clicar "Turn off safe mode" (capturar dialog)
3. Browse > procurar cada plugin
4. Instalar: Calendar, Dataview, Templater, Excalidraw
5. Usar cada um e capturar em ação

---

## 🎨 FERRAMENTAS PARA DIAGRAMAS

### Excalidraw (Recomendado)
```
1. Abrir https://excalidraw.com
2. Criar diagrama
3. Export > PNG (2x resolution)
4. Salvar na pasta assets/
```

### Exemplo de Árvore PARA:
```
Usar emojis:
📁 Vault/
├── 📥 Inbox/
├── 📋 Projects/
├── 🏢 Areas/
├── 📚 Resources/
├── 🗄️ Archives/
├── 📎 Attachments/
└── 📝 Templates/
```

---

## ⚙️ CONFIGURAÇÕES DE CAPTURA

### Mac:
```bash
# Screenshot de região selecionada
Cmd + Shift + 4

# Screenshot de janela específica
Cmd + Shift + 4, depois Space

# Configurar para salvar em área de trabalho:
defaults write com.apple.screencapture location ~/Desktop
```

### Windows:
```
Win + Shift + S    # Snipping Tool
Alt + PrtScn       # Janela ativa
```

### Qualidade:
- Resolução mínima: 1920x1080
- Formato: PNG (sem compressão)
- Depois: comprimir com TinyPNG

---

## 📊 PROGRESSO

### Por Módulo:
```
[ ] Módulo 1: 0/19 screenshots
[ ] Módulo 2: 0/9 imagens
[ ] Módulo 3: 0/7 diagramas
[ ] Módulo 4: 0/10 screenshots
[ ] Módulo 5: 0/7 screenshots

Total: 0/52 elementos visuais
```

### Estimativa de Tempo:
- **Screenshots simples:** ~30 min
- **Screenshots com setup:** ~60 min
- **Diagramas:** ~90 min
- **Total:** ~3 horas

---

## 🚦 PRIORIDADE DE EXECUÇÃO

### Fase 1: Quick Wins (30 min)
Capturas simples sem setup:
1. 1.3-download-page.png (website)
2. 1.4-settings-menu.png
3. 1.4-ribbon-icons.png
4. 5.1-enable-plugins.png
5. 5.1-browse-plugins.png

### Fase 2: Com Setup (60 min)
Requer configurar Obsidian:
1. Todos de 1.4 (Settings)
2. Todos de 5.1 (Plugins)
3. 3.1-file-explorer.png (montar PARA)

### Fase 3: Diagramas (90 min)
Criar do zero:
1. 3.1-para-structure.png
2. 3.1-anti-patterns.png
3. 4.2-graph-analysis.png
4. 2.1-cheatsheet.png

### Fase 4: Graph View (30 min)
Requer vault com conteúdo:
1. Todos de 4.2

---

## ✅ APÓS CAPTURA

1. **Organizar:**
   ```bash
   ls assets/ | wc -l  # Conferir se tem 52 arquivos
   ```

2. **Comprimir:**
   - Upload em lote no https://tinypng.com
   - Ou usar ImageOptim (Mac)
   - Objetivo: < 500KB por imagem

3. **Inserir nas Lições:**
   - Abrir `GUIA-ELEMENTOS-VISUAIS.md`
   - Seguir indicações de onde inserir cada imagem
   - Usar sintaxe:
     ```markdown
     ![Descrição](assets/nome-arquivo.png)
     *Legenda explicativa*
     ```

4. **Testar Renderização:**
   - Abrir lições em Obsidian ou Typora
   - Verificar se imagens carregam
   - Ajustar paths se necessário

---

**Última Atualização:** 2025-01-18
**Criado por:** Content Orchestrator Agent

