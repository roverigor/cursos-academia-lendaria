-- ════════════════════════════════════════════════════════════════════════════════
-- SCRIPT: Expandir Curso "Dominando Obsidian" - Lições 1.2 até 3.5
-- ════════════════════════════════════════════════════════════════════════════════
-- Objetivo: Inserir todas as lições faltantes do curso
-- UUIDs conhecidos:
--   Professor: 4fd9fb2c-a0ed-436d-9500-47692cd53792 (Adriano Marqui)
--   Projeto: 2518103d-93af-4d0a-874b-9b164974fb0e (Dominando Obsidian)
--   Outline: c7299a8c-6e98-4a1a-b79f-792df1cbeb1f
--   Módulo 1: b39fd32c-d42d-4532-b7fe-0328bffff2d2
--   Lição 1.1: 5ef6b3bf-139e-463e-ab0e-69feb55301ac

BEGIN;

DO $$
DECLARE
  v_professor_id UUID := '4fd9fb2c-a0ed-436d-9500-47692cd53792';
  v_project_id UUID := '2518103d-93af-4d0a-874b-9b164974fb0e';
  v_outline_id UUID := 'c7299a8c-6e98-4a1a-b79f-792df1cbeb1f';
  v_modulo1_id UUID := 'b39fd32c-d42d-4532-b7fe-0328bffff2d2';
  v_modulo2_id UUID;
  v_modulo3_id UUID;
  v_licao_id UUID;
BEGIN
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Expandindo Curso: Dominando Obsidian';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';

  -- ════════════════════════════════════════════════════════════════════════════════
  -- MÓDULO 1: Complementar com Lições 1.2, 1.3, 1.4
  -- ════════════════════════════════════════════════════════════════════════════════

  RAISE NOTICE '';
  RAISE NOTICE '─── Inserindo Lições do Módulo 1 ───';

  -- Lição 1.2: Por que usar Obsidian
  RAISE NOTICE 'Criando Lição 1.2...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-1-2-por-que-usar-obsidian',
    'Lição 1.2: Por Que Usar Obsidian?',
    'course_lesson',
    true,
    '# Lição 1.2: Por Que Usar Obsidian?

## Gancho
Você talvez se pergunta: "Será que vou começar a usar mais uma ferramenta?" Isso é legítimo. Mas nessa aula vou te mostrar por que Obsidian é a MELHOR escolha para seu segundo cérebro.

## Promessa
Nesta lição você vai entender:
- Comparativo entre as melhores ferramentas de PKM
- Os 6 critérios que tornam Obsidian superior
- Por que não precisa testar tudo sozinho

## Solução

### As Ferramentas Disponíveis
Existem muitas opções: Evernote, Rowan, Notion, OneNote, Apple Notes, Google Keep, Tana...

O problema? Você gastaria MESES ou ANOS testando cada uma para entender:
- Todas as funcionalidades
- Como se adequam ao seu estilo
- Qual realmente é a melhor

### Por Que Obsidian é Melhor

**1. Grande comunidade construindo plugins e evoluindo a ferramenta**
- Sempre melhorando
- Suporte da comunidade
- Recursos em português

**2. Ferramenta gratuita**
- Sem mensalidades
- Sem preocupação: "Se parar de pagar, o que acontece com meus dados?"

**3. Dados 100% locais**
- Seus arquivos estão no seu computador
- Você é dono dos dados
- Não depende de servidores de terceiros

**4. Formato Markdown**
- Dados salvos em .md (formato universal)
- Markdown é a base para IA moderna
- Você pode exportar para qualquer lugar

**5. Links bidirecionais + Graph View**
- Conecta notas como seu cérebro trabalha
- Visualize as conexões graficamente
- Crítico para PKM efetivo

**6. Extensível com plugins**
- Comunidade desenvolvendo plugins constantemente
- Personalize totalmente
- Crie workflows únicos

### O 80/20 do Obsidian
Aqui na academia, estudamos MUITAS ferramentas em inglês, português e outras línguas.

Condensamos TUDO em este curso para você:
- Conhecimento prático e imediato
- Economiza meses/anos de estudo
- Vai à frente de quem está garimpando tutoriais

## Exercício Prático
1. Liste 3 ferramentas que você usava antes
2. Identifique seus pain points
3. Veja como Obsidian resolve cada um

## Próxima Lição
Na próxima aula: O que exatamente é Obsidian? Vamos entender a fundo!',
    v_project_id,
    v_modulo1_id,
    2,
    'published',
    0.92,
    '{"duration_minutes": 15, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "01_porque_usar_obsidian-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 1.2 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 1.3: O que é Obsidian
  RAISE NOTICE 'Criando Lição 1.3...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-1-3-o-que-e-obsidian-fundo',
    'Lição 1.3: O Que É Obsidian?',
    'course_lesson',
    true,
    '# Lição 1.3: O Que É Obsidian?

## Gancho
Você já se sentiu sobrecarregado de tanta informação? Já tentou encontrar uma informação que anotou em mil lugares diferentes?

## Promessa
Nesta lição você vai entender:
- O que exatamente é Obsidian
- Como ele funciona diferente de outras ferramentas
- Por que ele é um "segundo cérebro" de verdade

## Solução

### O Problema Real
Seu cérebro biológico NÃO consegue:
- Organizar tudo que aprende
- Lembrar de tudo
- Conectar ideias dispersas
- Recapitular tudo quando precisa

Resultado? FOMO, sensação de estar perdendo coisas, informação perdida.

### A Solução: Obsidian como Segundo Cérebro

Obsidian é uma ferramenta PKM (Personal Knowledge Management) que funciona como seu **segundo cérebro digital**.

**Como funciona:**
1. Você anota tudo (mesmos seus pensamentos)
2. Obsidian organiza e conecta automaticamente
3. Você acessa quando precisa
4. Aproveita todas as conexões emergentes

### Obsidian vs Outros Aplicativos

| Critério | Obsidian | Notion | Evernote | OneNote |
|----------|----------|--------|----------|---------|
| Dados Locais | ✅ | ❌ | ❌ | ⚠️ |
| Links Bidirecionais | ✅ | ✅ | ❌ | ❌ |
| Graph View | ✅ | ❌ | ❌ | ❌ |
| Offline-first | ✅ | ❌ | ⚠️ | ✅ |
| Markdown nativo | ✅ | ⚠️ | ❌ | ❌ |
| Extensível | ✅ | ✅ | ⚠️ | ⚠️ |

### Conceito de Segundo Cérebro
Uma ferramenta PKM precisa ter:
- ✅ Local para anotar
- ✅ Forma de organizar
- ✅ Jeito de recuperar
- ✅ Capacidade de conectar

**Obsidian tem TUDO isso.**

## Exercício Prático
1. Acesse obsidian.md
2. Explore a demo online
3. Observe o graph view interativo
4. Tente criar uma nota e fazer um link

## Próxima Lição
Próxima: Conceitos do segundo cérebro (Vault, Notas, Markdown, Links)',
    v_project_id,
    v_modulo1_id,
    3,
    'published',
    0.93,
    '{"duration_minutes": 14, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "02_o_que_e_obsidian-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 1.3 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 1.4: Conceitos do Segundo Cérebro
  RAISE NOTICE 'Criando Lição 1.4...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-1-4-conceitos-segundo-cerebro',
    'Lição 1.4: Conceitos do Segundo Cérebro',
    'course_lesson',
    true,
    '# Lição 1.4: Conceitos do Segundo Cérebro

## Gancho
Antes de começar a usar, você precisa entender 4 conceitos fundamentais. Sem eles, você usaria Obsidian errado.

## Promessa
Nesta lição você vai aprender:
- Vault (seu segundo cérebro)
- Notas (unidades de conhecimento)
- Markdown (linguagem de escrita)
- Links bidirecionais (conexões)

## Solução

### 1. Vault: Seu Segundo Cérebro
Um **Vault** é uma pasta no seu computador contendo:
- Todas as suas notas (.md)
- Configurações
- Plugins
- Tudo que você precisa

**É seu segundo cérebro em um lugar.**

### 2. Notas: Unidades de Conhecimento
Uma **nota** é um arquivo .md com uma ideia, conceito ou informação.

Características:
- Simples (texto puro)
- Conectável (pode linkar com outras)
- Sincronizável (opcional)
- Exportável (você é dono)

**Tudo em Obsidian gira em torno de notas.**

### 3. Markdown: Linguagem de Escrita
**Markdown** é um formato de escrita simples que:
- Completa 20 anos agora
- É a base para IA moderna
- Funciona em qualquer lugar
- É legível mesmo em texto puro

Exemplos:
```
# Título
## Subtítulo
**negrito**
*itálico*
- lista
```

### 4. Links Bidirecionais: Conexões
Um **link bidirecional** conecta duas notas:

Nota A → Nota B
Nota B também sabe que está linkada a Nota A

Isso permite:
- Visualizar conexões
- Navegar entre ideias
- Emergir novos insights
- Replicar como o cérebro trabalha

## Caso Prático
Você anota:
- Nota: "Método Zettelkasten"
- Nota: "Notas conectadas"
- Nota: "PKM Pessoal"

Com links bidirecionais, quando você abre uma, vê as outras conectadas.

Seu cérebro vê conexões emergindo naturalmente.

## Exercício Prático
1. Crie 3 notas simples
2. Linke elas uma com a outra
3. Abra o Graph View
4. Observe como aparecem as conexões

## Próxima Lição
Próxima: Preparando a instalação (vamos praticar de verdade!)',
    v_project_id,
    v_modulo1_id,
    4,
    'published',
    0.91,
    '{"duration_minutes": 16, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "04_conceitos_do_segundo_cerebro-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 1.4 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  RAISE NOTICE '✅ Módulo 1 completo com 4 lições!';

  -- ════════════════════════════════════════════════════════════════════════════════
  -- MÓDULO 2: Instalação e Configuração
  -- ════════════════════════════════════════════════════════════════════════════════

  RAISE NOTICE '';
  RAISE NOTICE '─── Criando Módulo 2: Instalação e Configuração ───';

  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'modulo-2-instalacao-configuracao',
    'Módulo 2: Instalação e Configuração',
    'course_module',
    true,
    '# Módulo 2: Instalação e Configuração

## O que você vai aprender
- Preparar seu ambiente (requisitos)
- Instalar em iOS/Android
- Instalar em Mac/Windows
- Configurar sincronização

## Lições
1. Preparando a instalação
2. Instalação e ajuste iOS
3. Instalação Android
4. Instalação Mac e Windows

## Objetivo
Ter Obsidian pronto em todos seus dispositivos com sincronização configurada.',
    v_project_id,
    v_outline_id,
    2,
    'published',
    '{"lessons_count": 4, "duration_minutes": 60, "difficulty": "beginner"}'::jsonb
  ) RETURNING id INTO v_modulo2_id;
  RAISE NOTICE '✅ Módulo 2 criado: %', v_modulo2_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_modulo2_id, v_professor_id, 'creator');

  -- Lição 2.1
  RAISE NOTICE 'Criando Lição 2.1...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-2-1-preparando-instalacao',
    'Lição 2.1: Preparando a Instalação',
    'course_lesson',
    true,
    '# Lição 2.1: Preparando a Instalação

## Gancho
Antes de instalar, você precisa se preparar. Alguns passos simples economizam horas de problema depois.

## Promessa
Nesta lição você vai:
- Entender os requisitos do Obsidian
- Preparar seu dispositivo
- Evitar erros comuns

## Solução

### Requisitos de Sistema
**Mac:**
- OS X 10.12+
- 2GB RAM mínimo
- 500MB de espaço

**Windows:**
- Windows 7+
- 2GB RAM mínimo
- 500MB de espaço

**iOS:**
- iOS 12.4+
- iPhone 6S+ ou melhor
- 500MB livre

**Android:**
- Android 5.0+
- 2GB RAM mínimo
- 500MB livre

### Passos de Preparação
1. Verificar requisitos
2. Liberar espaço no dispositivo
3. Ter seu email pronto
4. Pensar em uma senha forte para o vault

### Criar Conta (Opcional mas Recomendado)
Para sincronização e backup:
1. Visite obsidian.md
2. Clique em "Sign up"
3. Use seu email
4. Configure senha forte
5. Confirme email

### Próximos Passos
Agora você está preparado para instalar!

## Exercício Prático
1. Verifique seus requisitos
2. Crie conta em obsidian.md (se quiser sincronizar)
3. Teste seu email

## Próxima Lição
Próxima: Instalação em iOS e Android',
    v_project_id,
    v_modulo2_id,
    1,
    'published',
    0.90,
    '{"duration_minutes": 10, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 1, "source_file": "06_preparando_a_instalacao-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 2.1 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 2.2
  RAISE NOTICE 'Criando Lição 2.2...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-2-2-instalacao-ios',
    'Lição 2.2: Instalação em iOS',
    'course_lesson',
    true,
    '# Lição 2.2: Instalação e Ajuste em iOS

## Gancho
Seu iPhone é poderoso. Vamos colocar Obsidian nele corretamente.

## Promessa
Nesta lição você vai:
- Instalar Obsidian no iPhone
- Fazer primeiras configurações
- Conectar ao seu vault

## Solução

### Passo 1: Baixar do App Store
1. Abra App Store
2. Busque por "Obsidian"
3. Clique em "Obter"
4. Confirme com Face ID/Touch ID
5. Aguarde download

### Passo 2: Primeiro Acesso
1. Abra Obsidian
2. Veja opções: "Create vault" ou "Open vault"
3. Se você criou conta: faça login

### Passo 3: Conectar ao Seu Vault
1. Faça login com sua conta
2. Escolha seu vault
3. Espere sincronizar

### Passo 4: Configurações Essenciais
1. Vá para Settings
2. Display: escolha seu tema preferido
3. Files & Links: ative "Strict line breaks"
4. Editor: configure fonte do seu gosto

### Pronto!
Você pode começar a anotar no iPhone.

## Exercício Prático
1. Instale Obsidian no seu iPhone
2. Crie ou acesse seu vault
3. Crie uma nota de teste
4. Vá para Mac e veja sincronizar

## Próxima Lição
Próxima: Instalação em Android',
    v_project_id,
    v_modulo2_id,
    2,
    'published',
    0.91,
    '{"duration_minutes": 12, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 2, "source_file": "07_instalacao_e_ajuste_iphone_corrigida-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 2.2 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 2.3
  RAISE NOTICE 'Criando Lição 2.3...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-2-3-instalacao-android',
    'Lição 2.3: Instalação em Android',
    'course_lesson',
    true,
    '# Lição 2.3: Instalação em Android

## Gancho
Android é poderoso demais! Obsidian no Android funciona impecavelmente.

## Promessa
Nesta lição você vai:
- Instalar Obsidian no Android
- Configurar primeiras opções
- Sincronizar com seu vault

## Solução

### Passo 1: Baixar do Google Play
1. Abra Google Play Store
2. Busque por "Obsidian"
3. Clique em "Install"
4. Aguarde conclusão

### Passo 2: Permitir Permissões
Android pedirá:
- Acesso a arquivos ✅ (necessário)
- Acesso à câmera (opcional)

Conceda permissões necessárias.

### Passo 3: Conectar ao Seu Vault
1. Abra Obsidian
2. Se tiver conta: faça login
3. Escolha seu vault
4. Espere sincronizar

### Passo 4: Configurações Essenciais
1. Menu → Settings
2. Escolher tema (light/dark)
3. Editor: preferências de fonte
4. File & Links: ativar strict mode

### Dica Importante
No Android, a sincronização é via WiFi por padrão. Verifique se está conectado.

## Exercício Prático
1. Instale no seu Android
2. Acesse o vault
3. Crie uma nota
4. Veja sincronizar em tempo real

## Próxima Lição
Próxima: Instalação em Mac e Windows',
    v_project_id,
    v_modulo2_id,
    3,
    'published',
    0.90,
    '{"duration_minutes": 11, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "08_instalacao_android-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 2.3 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 2.4
  RAISE NOTICE 'Criando Lição 2.4...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-2-4-instalacao-mac-windows',
    'Lição 2.4: Instalação em Mac e Windows',
    'course_lesson',
    true,
    '# Lição 2.4: Instalação em Mac e Windows

## Gancho
Seu computador é a base do seu segundo cérebro. Instalar certo aqui é essencial.

## Promessa
Nesta lição você vai:
- Instalar Obsidian no Mac
- Instalar Obsidian no Windows
- Configurar sincronização
- Terá seu segundo cérebro operacional

## Solução

### Instalação no MAC

**Passo 1: Download**
1. Visite obsidian.md
2. Clique "Download"
3. Escolha "Mac (Intel)" ou "Mac (Apple Silicon)"
4. Baixe o .dmg

**Passo 2: Instalar**
1. Abra o arquivo .dmg
2. Arraste "Obsidian" para "Applications"
3. Espere copiar

**Passo 3: Abrir**
1. Abra Applications
2. Encontre Obsidian
3. Clique 2x para abrir

**Passo 4: Criar ou Abrir Vault**
- Se é primeira vez: "Create vault"
- Se tem vault em outro dispositivo: "Open vault" e faça login

### Instalação no WINDOWS

**Passo 1: Download**
1. Visite obsidian.md
2. Clique "Download"
3. Escolha "Windows"
4. Baixe o instalador

**Passo 2: Instalar**
1. Execute o instalador
2. Siga as telas
3. Escolha onde instalar
4. Clique "Install"

**Passo 3: Abrir**
1. Procure por Obsidian
2. Clique para abrir

**Passo 4: Configurar Vault**
1. Login ou criar novo vault
2. Se tem em outro lugar: faça login

### Configurações Importantes (Mac e Windows)

1. **About → Enable automatic updates** (recomendado)
2. **Editor → Preferences** (sua escolha)
3. **Files & Links → Strict line breaks** (ativar)
4. **Themes → Escolher seu favorito**

### Sincronização (IMPORTANTE!)

Para sincronizar entre dispositivos:

**Opção 1: Obsidian Sync (pago, mas simples)**
- Automático
- Seguro
- Multiplataforma

**Opção 2: iCloud/OneDrive/Google Drive (gratuito)**
- Crie vault em pasta sincronizada
- Funciona bem
- Precisa configurar

**Opção 3: Nenhum (tudo local)**
- Funciona
- Sem sincronização
- Dados só no seu PC

## Exercício Prático
1. Instale no seu Mac ou Windows
2. Crie seu vault
3. Configure sincronização
4. Crie 3 notas de teste
5. Veja sincronizar em outro dispositivo

## Próxima Lição
Próxima: Iniciando Obsidian no Mac (customizações)',
    v_project_id,
    v_modulo2_id,
    4,
    'published',
    0.92,
    '{"duration_minutes": 18, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 2, "source_file": "09_instalacao_mac_e_windows-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 2.4 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  RAISE NOTICE '✅ Módulo 2 completo com 4 lições!';

  -- ════════════════════════════════════════════════════════════════════════════════
  -- MÓDULO 3: Iniciando Obsidian
  -- ════════════════════════════════════════════════════════════════════════════════

  RAISE NOTICE '';
  RAISE NOTICE '─── Criando Módulo 3: Iniciando Obsidian ───';

  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    'modulo-3-iniciando-obsidian',
    'Módulo 3: Iniciando Obsidian',
    'course_module',
    true,
    '# Módulo 3: Iniciando Obsidian

## O que você vai aprender
- Iniciando em Mac (customizações)
- Iniciando em Windows (customizações)
- Conceito de vault em profundidade
- Como funcionam os arquivos

## Lições
1. Iniciando no Mac (customizações)
2. Iniciando no Windows (customizações)
3. Usando Mac (não pule!)
4. Usando OneDrive/GoogleDrive (não pule!)
5. Conceito de cofre

## Objetivo
Estar totalmente familiar com a interface e configurações do Obsidian em seu sistema.',
    v_project_id,
    v_outline_id,
    3,
    'published',
    '{"lessons_count": 5, "duration_minutes": 75, "difficulty": "intermediate"}'::jsonb
  ) RETURNING id INTO v_modulo3_id;
  RAISE NOTICE '✅ Módulo 3 criado: %', v_modulo3_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_modulo3_id, v_professor_id, 'creator');

  -- Lição 3.1
  RAISE NOTICE 'Criando Lição 3.1...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-3-1-iniciando-mac',
    'Lição 3.1: Iniciando no Mac - Customizações',
    'course_lesson',
    true,
    '# Lição 3.1: Iniciando no Mac - Customizações

## Gancho
Seu Obsidian no Mac pode ser totalmente customizado. Vamos fazer isso agora.

## Promessa
Nesta lição você vai:
- Customizar interface do Mac
- Configurar atalhos
- Optimizar seu ambiente
- Estar pronto para trabalhar

## Solução

### Interface & Themes

1. **Sidebar Layout**
   - Left: File explorer + Tags
   - Right: Backlinks + Outgoing links

2. **Escolher Tema**
   - Settings → Appearance
   - Escolha "Light" ou "Dark"
   - Teste diferentes temas da comunidade

3. **Fonte & Tamanho**
   - Settings → Editor
   - Font size: recomendo 16px
   - Line width: ~70 caracteres (confortável para ler)

### Atalhos Essenciais para Mac

| Ação | Atalho |
|------|--------|
| Paleta de comandos | Cmd+P |
| Nova nota | Cmd+N |
| Pesquisa | Cmd+F |
| Buscar em todas as notas | Cmd+Shift+F |
| Graph view | Cmd+G |
| Fechar painel | Cmd+W |

Configure seus próprios em:
Settings → Hotkeys

### Plugins Recomendados para Começar

1. **Core plugins** (já vem)
   - Backlinks pane
   - Tag pane
   - Graph view
   - Outline

2. **Community plugins**
   - Dataview (criar queries sobre suas notas)
   - Quick Capture (anotar rápido)
   - Calendar (organizar por datas)

Como instalar:
Settings → Community plugins → Browse → Procure → Install

### Primeiras Configurações

1. **Files & Links**
   - Strict line breaks: ativar
   - New note location: ativa onde criar

2. **Display**
   - Show inline title: ativar
   - Fold heading: ativar

3. **Hotkeys**
   - Configure seus mais usados

## Exercício Prático
1. Customize seu tema
2. Configure 3 atalhos que mais usa
3. Instale 1 community plugin
4. Crie uma nota com um link bidirecional

## Próxima Lição
Próxima: Iniciando no Windows (customizações)',
    v_project_id,
    v_modulo3_id,
    1,
    'published',
    0.90,
    '{"duration_minutes": 14, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "10_iniciando_obsidian_no_mac-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 3.1 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 3.2
  RAISE NOTICE 'Criando Lição 3.2...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-3-2-iniciando-windows',
    'Lição 3.2: Iniciando no Windows - Customizações',
    'course_lesson',
    true,
    '# Lição 3.2: Iniciando no Windows - Customizações

## Gancho
Windows é tão customizável quanto Mac. Vamos otimizar seu Obsidian para Windows.

## Promessa
Nesta lição você vai:
- Customizar interface do Windows
- Configurar atalhos do sistema
- Optimizar performance
- Estar 100% pronto

## Solução

### Interface & Themes

1. **Sidebar**
   - Left: File tree
   - Right: Backlinks + Graph

2. **Temas**
   - Settings → Appearance
   - Escolha Light ou Dark
   - Community themes disponíveis

3. **Fonte**
   - Editor → Font size: 14-16px
   - Font family: Fira Code ou Cascadia Code
   - Line width: 70-80 caracteres

### Atalhos Importantes para Windows

| Ação | Atalho |
|------|--------|
| Command palette | Ctrl+P |
| Nova nota | Ctrl+N |
| Buscar | Ctrl+F |
| Buscar global | Ctrl+Shift+F |
| Graph view | Ctrl+G |
| Fechar painel | Ctrl+W |

Customize em Settings → Hotkeys

### Performance no Windows

1. **Memory usage**
   - Feche abas não usadas
   - Limpe cache: Settings → About → Cache

2. **Plugins**
   - Instale apenas necessários
   - Desative plugins pesados

3. **Vault Size**
   - Mantenha vault pequeno no começo
   - Archive notas antigas

### Setup Inicial Recomendado

1. Vault em pasta sincronizada (OneDrive/Google Drive)
2. Enable auto-save
3. Backup automático
4. Temas: escolha um e mantenha

### Plugins Essenciais

1. **Core**
   - Backlinks
   - Tags
   - Graph
   - Outline

2. **Community** (comece com pouco!)
   - Quick Capture
   - Calendar
   - Dataview

## Exercício Prático
1. Customize seu tema
2. Configure atalhos
3. Instale 1-2 plugins comunitários
4. Crie 5 notas de teste com links

## Próxima Lição
Próxima: Usando Mac - não pule essa aula!',
    v_project_id,
    v_modulo3_id,
    2,
    'published',
    0.91,
    '{"duration_minutes": 16, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 2, "source_file": "11_iniciando_obsidian_no_windows-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 3.2 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 3.3
  RAISE NOTICE 'Criando Lição 3.3...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-3-3-usando-mac',
    'Lição 3.3: Usando Mac - Não Pule!',
    'course_lesson',
    true,
    '# Lição 3.3: Usando Mac - Não Pule Essa!

## Gancho
Há algumas coisas ESPECÍFICAS do Mac que você PRECISA saber ou vai se ferrar depois.

## Promessa
Nesta lição você vai aprender:
- Quirks do Obsidian no Mac
- Como evitar problemas
- Performance otimizada
- Troubleshooting

## Solução

### Problemas Comuns no Mac (e soluções)

**Problema 1: Obsidian lento com vault grande**
- Solução: Desative plugins não usados
- Check: Editor → Disable HTML rendering

**Problema 2: Vault travando ao sincronizar**
- Solução: Verifique iCloud/Dropbox status
- Aguarde sincronização completar
- Não abra múltiplas janelas

**Problema 3: Atalhos conflitam com OS**
- Solução: Customizar em Settings → Hotkeys
- Evite Cmd+Space (Spotlight)
- Evite Cmd+Tab (App Switcher)

### Features Exclusivas do Mac

1. **Native window management**
   - Split view: arraste abas
   - Multi-window: Cmd+N abre nova

2. **Spotlight integration** (com plugins)
   - Quick note capture
   - Rápido acesso

3. **iCloud sync**
   - Automático
   - Não precisa configurar

### Otimizações de Performance

1. **Disable**
   - Syntax highlighting em vaults grandes
   - Inline editors (Settings → Editor)

2. **Enable**
   - Hardware acceleration (se tiver GPU)
   - Auto-save
   - Spell check

3. **Monitor**
   - Activity Monitor: veja CPU/Memory
   - Feche plugins pesados

### Backup Essencial

**Método 1: Time Machine (recomendado)**
```
Vault em pasta sincronizada
Time Machine automaticamente faz backup
```

**Método 2: Manual**
```
Cp -r ~/Obsidian-Vault ~/Backups/vault-backup
```

## Exercício Prático
1. Abra Activity Monitor
2. Veja quanto Obsidian consome
3. Configure Time Machine para seu vault
4. Crie estrutura de pastas no Mac

## Próxima Lição
Próxima: Usando OneDrive/Google Drive - não pule!',
    v_project_id,
    v_modulo3_id,
    3,
    'published',
    0.89,
    '{"duration_minutes": 12, "frameworks_applied": ["gps", "blooms_taxonomy"], "bloom_level": 3, "source_file": "12_usando_mac_nao_pule_essa_aula-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 3.3 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 3.4
  RAISE NOTICE 'Criando Lição 3.4...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-3-4-sincronizacao-onedrive',
    'Lição 3.4: Sincronização OneDrive/GoogleDrive - Não Pule!',
    'course_lesson',
    true,
    '# Lição 3.4: Sincronização com OneDrive/GoogleDrive - Não Pule!

## Gancho
Quer sincronizar com nuvem GRÁTIS? Precisa saber o jeito certo ou vai perder dados.

## Promessa
Nesta lição você vai:
- Entender sincronização grátis
- Configurar OneDrive ou GoogleDrive
- Evitar conflitos e perda de dados
- Estar 100% seguro

## Solução

### Por Que Sincronizar em Nuvem?

- ✅ Backup automático
- ✅ Acesso de múltiplos PCs
- ✅ Não pagar mensalidade
- ✅ Controle total dos dados

### Opção 1: OneDrive (Recomendado)

**Passo 1: Criar folder no OneDrive**
1. Abra OneDrive.com
2. Crie pasta: "Obsidian-Vault"
3. Anote o caminho: /OneDrive/Obsidian-Vault

**Passo 2: Mover seu vault**
1. Feche Obsidian
2. No Finder: crie vault aqui
3. Ou mova vault existente para lá

**Passo 3: Abrir no Obsidian**
1. Obsidian → Open vault
2. Navegue até OneDrive folder
3. Abra seu vault

**Passo 4: Sincronização**
- OneDrive sincroniza automaticamente
- Veja ícones no Finder: ✓ (sincronizado)
- ⚙️ = sincronizando
- ⚠️ = conflito

### Opção 2: Google Drive

**Passo 1: Google Drive Sync**
1. Instale Google Drive para Mac
2. Escolha pasta: "Obsidian"
3. Aguarde sincronizar

**Passo 2: Abrir no Obsidian**
1. Open vault
2. Escolha pasta em Google Drive
3. Pronto!

**Passo 3: Configurar bem**
- Google Drive é MAIS lento
- Use para backup, não produção
- Adicione delay: 5 segundos entre mudanças

### Problemas Comuns & Soluções

**Conflito de sincronização**
- Causa: Editar em 2 PCs simultaneamente
- Solução: Feche Obsidian em um PC antes
- OneDrive cria ".conflicted copy" - delete depois

**Arquivo travado**
- Causa: PC outra sincronizando
- Solução: Aguarde sincronização completar
- Feche Obsidian durante sincronização

**Perdeu arquivo**
- Cause: Conflito não resolvido
- Solução: Recupere de trash (se recente)
- Sempre tenha backup manual

### Best Practices

1. **Uma máquina por vez**
   - Feche Obsidian antes de trocar PC
   - Aguarde sincronização
   - Espere 5 segundos antes de abrir no outro

2. **Backup local**
   - Além de nuvem
   - Time Machine ou clone de disco
   - Backup mensal

3. **Versionamento**
   - OneDrive mantém histórico (último mês)
   - Clique direito → Version history
   - Restaure versão antiga se necessário

## Exercício Prático
1. Crie folder no OneDrive
2. Mova seu vault
3. Verifique sincronização
4. Abra no outro PC
5. Edite uma nota
6. Veja sincronizar

## Próxima Lição
Próxima: Conceito de Cofre em profundidade',
    v_project_id,
    v_modulo3_id,
    4,
    'published',
    0.92,
    '{"duration_minutes": 19, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "13_usando_onedrive_ou_googledrive_nao_pule_essa_aula-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 3.4 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  -- Lição 3.5
  RAISE NOTICE 'Criando Lição 3.5...';
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    'licao-3-5-conceito-cofre',
    'Lição 3.5: O Conceito de Cofre em Profundidade',
    'course_lesson',
    true,
    '# Lição 3.5: O Conceito de Cofre em Profundidade

## Gancho
Um vault é MUITO mais que uma pasta. Entender bem isso muda tudo.

## Promessa
Nesta lição você vai aprender:
- O que é um vault de verdade
- Arquitetura interna
- Quando criar múltiplos vaults
- Como gerenciar seus dados

## Solução

### O que É Um Vault?

Um **vault** é uma pasta contendo:
```
seu-vault/
├── .obsidian/          ← Configurações
│   ├── app.json
│   ├── themes/
│   └── plugins/
├── attachments/        ← Imagens, PDFs, etc
│   └── [seus arquivos]
├── notas/              ← Suas notas
│   ├── nota1.md
│   ├── nota2.md
│   └── subfolder/
└── .gitignore         ← Se usar Git
```

### A Pasta .obsidian (Importante!)

Contém:
- **app.json**: Configurações do app
- **themes/**: Temas customizados
- **plugins/**: Plugins instalados
- **workspace**: Layout de janelas

**NUNCA delete .obsidian!!** Você perde tudo.

### Estrutura de Pastas Recomendada

```
vault/
├── 📚 Sources/      ← Material de referência
│   ├── Articles/
│   ├── Books/
│   └── Videos/
├── 🧠 Brain/        ← Seu segundo cérebro
│   ├── Concepts/
│   ├── Projetos/
│   └── MOCs/        ← Maps of Content
├── 📋 Templates/    ← Templates de notas
│   └── Default.md
├── 🗃️ Archived/      ← Notas antigas
└── 📎 Attachments/  ← Imagens, etc
```

### Um Vault ou Múltiplos?

**Um único vault grande:**
- ✅ Mais simples
- ✅ Tudo conectado
- ✅ Pesquisa global
- ❌ Pode ficar lento com 5000+ notas

**Múltiplos vaults:**
- ✅ Separação clara (Trabalho/Pessoal)
- ✅ Performance melhor
- ❌ Sem links entre vaults
- ❌ Mais para gerenciar

**Recomendação:** Comece com UM.

### Sincronização Entre Dispositivos

A pasta .obsidian SIM ou NÃO sincronizar?

**Sincronizar .obsidian:**
- ✅ Mesmo setup em todos PCs
- ✅ Plugins sincronizam
- ❌ Pode causar conflitos

**NÃO sincronizar:**
- ✅ Cada PC customiza livre
- ❌ Setup diferente em cada um

**Recomendação:** Sincronize, mas com cuidado.

### Performance com Vault Grande

Se seu vault tem 1000+ notas:

1. **Desative plugins desnecessários**
2. **Não abra múltiplas janelas**
3. **Use "Exclude folders"** em Settings para arquivos antigos
4. **Archive notas** que não usa mais

### Backup Automático

Criar backup rotativo:
```bash
#!/bin/bash
# Backup.sh - execute weekly
cp -r ~/OneDrive/Obsidian-Vault ~/Backups/vault-backup-$(date +%Y%m%d)
```

Ou use Time Machine/Backup360.

## Exercício Prático
1. Explore sua pasta .obsidian
2. Crie estrutura de pastas recomendada
3. Organize notas por categoria
4. Configure exclusões se necessário
5. Crie um template padrão

## Próxima Lição
Próxima: Configurações Indispensáveis',
    v_project_id,
    v_modulo3_id,
    5,
    'published',
    0.93,
    '{"duration_minutes": 17, "frameworks_applied": ["gps", "blooms_taxonomy", "didatica_lendaria"], "bloom_level": 3, "source_file": "15_o_conceito_de_cofre_e_como_usa_lo-transcription.txt"}'::jsonb
  ) RETURNING id INTO v_licao_id;
  RAISE NOTICE '✅ Lição 3.5 criada: %', v_licao_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_licao_id, v_professor_id, 'creator');

  RAISE NOTICE '✅ Módulo 3 completo com 5 lições!';

  -- ════════════════════════════════════════════════════════════════════════════════
  -- RESUMO FINAL
  -- ════════════════════════════════════════════════════════════════════════════════

  RAISE NOTICE '';
  RAISE NOTICE '╔═══════════════════════════════════════════════════════════╗';
  RAISE NOTICE '║ ✅ EXPANSÃO COMPLETADA COM SUCESSO!                      ║';
  RAISE NOTICE '╚═══════════════════════════════════════════════════════════╝';
  RAISE NOTICE '';
  RAISE NOTICE '📊 Resumo da Inserção:';
  RAISE NOTICE '  ✅ Módulo 1: 4 lições (1.1 - 1.4)';
  RAISE NOTICE '  ✅ Módulo 2: 4 lições (2.1 - 2.4)';
  RAISE NOTICE '  ✅ Módulo 3: 5 lições (3.1 - 3.5)';
  RAISE NOTICE '  ────────────────────';
  RAISE NOTICE '  📚 Total: 13 lições adicionadas + 3 módulos';
  RAISE NOTICE '  ⏱️  Conteúdo estimado: 3 horas de aula';
  RAISE NOTICE '';
  RAISE NOTICE 'UUIDs importantes:';
  RAISE NOTICE '  Professor: 4fd9fb2c-a0ed-436d-9500-47692cd53792';
  RAISE NOTICE '  Projeto: 2518103d-93af-4d0a-874b-9b164974fb0e';
  RAISE NOTICE '  Outline: c7299a8c-6e98-4a1a-b79f-792df1cbeb1f';
  RAISE NOTICE '';
  RAISE NOTICE 'Próximas fases:';
  RAISE NOTICE '  1. Módulo 4: Notas e Markdown (4 lições)';
  RAISE NOTICE '  2. Módulo 5: Links Bidirecionais (4 lições)';
  RAISE NOTICE '  3. Módulo 6: Plugins Essenciais (4 lições)';
  RAISE NOTICE '  4. Módulo 7: ATLAS Method (4 lições)';
  RAISE NOTICE '  5. Módulo 8: Projeto Final (2 lições)';
  RAISE NOTICE '';

END $$;

COMMIT;

-- ════════════════════════════════════════════════════════════════════════════════
-- QUERIES DE VALIDAÇÃO
-- ════════════════════════════════════════════════════════════════════════════════

-- Ver hierarquia completa
SELECT slug, title, content_type, depth_level, sequence_order
FROM v_content_hierarchy
WHERE root_slug = 'dominando-obsidian-outline'
ORDER BY path;

-- Ver analytics do projeto
SELECT
  project_name,
  total_contents,
  published_contents,
  total_word_count,
  avg_fidelity_score
FROM v_project_performance
WHERE project_slug = 'dominando-obsidian';

-- Ver conteúdos do professor
SELECT
  display_name,
  total_contents,
  total_word_count,
  avg_fidelity_score
FROM v_mind_content_stats
WHERE display_name = 'Adriano Marqui';

-- Contar lições por módulo
SELECT
  parent.title as modulo,
  COUNT(child.id) as num_licoes,
  ROUND(SUM((child.metadata->>'duration_minutes')::numeric), 0) as total_minutos
FROM contents parent
LEFT JOIN contents child ON child.parent_content_id = parent.id
WHERE parent.content_type = 'course_module'
  AND parent.project_id = '2518103d-93af-4d0a-874b-9b164974fb0e'
GROUP BY parent.id, parent.title
ORDER BY parent.sequence_order;

-- ════════════════════════════════════════════════════════════════════════════════
-- FIM DO SCRIPT
-- ════════════════════════════════════════════════════════════════════════════════
