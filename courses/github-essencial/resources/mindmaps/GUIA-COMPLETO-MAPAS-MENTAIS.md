# Guia Completo de Mapas Mentais - GitHub Essencial para Devs

## Índice

1. [Mapa Completo do Curso](#mapa-completo-do-curso)
2. [Módulo 1: Setup Moderno](#módulo-1-setup-moderno)
3. [Módulo 2: Seu Primeiro Repo Real](#módulo-2-seu-primeiro-repo-real)
4. [Módulo 3: Colaboração Profissional](#módulo-3-colaboração-profissional)
5. [Módulo 4: Sobrevivência + Próximos Passos](#módulo-4-sobrevivência--próximos-passos)
6. [Mapas Detalhados por Lição](#mapas-detalhados-por-lição)
7. [Fluxos de Trabalho](#fluxos-de-trabalho)
8. [Comandos Essenciais](#comandos-essenciais)

---

## Como Usar Este Guia

Este documento contém **todos os mapas mentais do curso** em formato texto. Cada mapa mental:
- **Estrutura hierárquica** com indentação visual
- **Emojis** para facilitar escaneabilidade
- **Conexões** entre conceitos marcadas
- **Comandos** com exemplos práticos
- **Conceitos-chave** destacados

**Dica de estudo:** Imprima ou visualize em tela cheia para revisar antes/depois de cada lição.

---

## Mapa Completo do Curso

Ver arquivo: `/home/igorr/mmos/outputs/courses/github-essencial/resources/mindmaps/curso-completo.md`

---

## Módulo 1: Setup Moderno

Ver arquivo: `/home/igorr/mmos/outputs/courses/github-essencial/resources/mindmaps/modulo-1-setup.md`

---

## Módulo 2: Seu Primeiro Repo Real

```
📦 MÓDULO 2: SEU PRIMEIRO REPO REAL (50 min)
│
├── 📄 LIÇÃO 2.1: CRIANDO REPO CERTO (10 min)
│   ├── 🎯 Objetivo Central
│   │   └── Criar repositórios profissionais desde o início
│   ├── 🏗️ Anatomia de Repo Profissional
│   │   ├── README.md
│   │   │   ├── O que é o projeto
│   │   │   ├── Como usar
│   │   │   ├── Por que existe
│   │   │   ├── Tecnologias usadas
│   │   │   └── Como instalar
│   │   ├── .gitignore
│   │   │   ├── O que NÃO versionar
│   │   │   ├── Templates por linguagem
│   │   │   └── Regra: dependências, secrets, builds
│   │   └── LICENSE
│   │       ├── Como outros podem usar
│   │       ├── MIT → Portfólio, open source
│   │       ├── Apache 2.0 → Corporativo
│   │       └── GPL 3.0 → Software livre
│   ├── 🚀 Criando no GitHub
│   │   ├── Nome em kebab-case
│   │   ├── Descrição clara (1 frase)
│   │   ├── Public vs Private
│   │   └── ✅ Initialize com README, .gitignore, License
│   ├── 📋 Estrutura de README Profissional
│   │   ├── # Título
│   │   ├── Descrição (1-2 frases)
│   │   ├── ## Sobre
│   │   ├── ## Tecnologias
│   │   ├── ## Instalação
│   │   ├── ## Uso
│   │   ├── ## Screenshots (se UI)
│   │   └── ## License
│   └── ✅ Checklist
│       ├── README completo
│       ├── .gitignore apropriado
│       ├── LICENSE clara
│       └── Nome descritivo
│
├── 🔄 LIÇÃO 2.2: O CICLO BÁSICO (15 min)
│   ├── 🧠 Modelo Mental do Git
│   │   ├── Working Directory
│   │   │   ├── Arquivos que você edita
│   │   │   └── Mudanças não salvas
│   │   ├── ↓ git add
│   │   ├── Staging Area
│   │   │   ├── Arquivos marcados para commit
│   │   │   └── "Envelope pronto para selar"
│   │   ├── ↓ git commit
│   │   └── Repository (Local)
│   │       ├── Histórico de versões salvas
│   │       └── Commits permanentes
│   ├── 📥 git clone
│   │   ├── Função: Copia repo remoto
│   │   ├── SSH: git@github.com:user/repo.git
│   │   ├── HTTPS: https://github.com/user/repo.git
│   │   ├── Só clona uma vez por projeto
│   │   └── Cria conexão automática (origin)
│   ├── 📊 git status
│   │   ├── Mostra situação atual
│   │   ├── Arquivos modified/untracked
│   │   ├── Estado de staging
│   │   └── Use SEMPRE antes/depois de comandos
│   ├── ➕ git add
│   │   ├── Move para staging
│   │   ├── git add arquivo.js (específico)
│   │   ├── git add . (tudo no diretório)
│   │   ├── git add --all (todo o repo)
│   │   └── git add -p (interativo)
│   ├── 💾 git commit
│   │   ├── Salva snapshot
│   │   ├── git commit -m "mensagem"
│   │   ├── Mensagem em imperativo
│   │   ├── Max 50 caracteres no título
│   │   └── git commit -am (add + commit rastreados)
│   ├── 📜 git log
│   │   ├── Ver histórico
│   │   ├── git log --oneline (compacto)
│   │   ├── git log --graph (visual)
│   │   └── git log -5 (últimos 5)
│   └── 🔁 Ciclo Completo
│       ├── 1. git status (verificar)
│       ├── 2. Editar arquivos
│       ├── 3. git status (ver mudanças)
│       ├── 4. git add . (preparar)
│       ├── 5. git status (confirmar)
│       ├── 6. git commit -m "msg"
│       └── 7. git status (working tree clean ✓)
│
├── 🌐 LIÇÃO 2.3: PUSH E PULL (10 min)
│   ├── 🔄 Local ↔ Remoto
│   │   ├── Local Repository (seu PC)
│   │   ├── ↕ push/pull
│   │   └── Remote Repository (GitHub)
│   ├── ⬆️ git push
│   │   ├── Envia commits locais para GitHub
│   │   ├── git push (simples)
│   │   ├── git push -u origin main (primeira vez)
│   │   ├── git push --force (⚠️ CUIDADO!)
│   │   └── Quando usar
│   │       ├── Após commit
│   │       ├── Fim do dia
│   │       └── Antes de desligar PC
│   ├── ⬇️ git pull
│   │   ├── Recebe mudanças do GitHub
│   │   ├── pull = fetch + merge
│   │   ├── git pull --rebase (histórico limpo)
│   │   └── Quando usar
│   │       ├── Início do dia
│   │       ├── Antes de começar trabalho
│   │       └── Antes de criar PR
│   ├── 📊 Ver Status de Sync
│   │   ├── git remote -v
│   │   ├── "ahead by X commits" → push
│   │   ├── "behind by X commits" → pull
│   │   └── "diverged" → pull primeiro
│   └── 🔧 Troubleshooting
│       ├── Rejected → git pull primeiro
│       ├── Uncommitted changes → commit ou stash
│       └── Permission denied → SSH não configurado
│
├── 📝 LIÇÃO 2.4: COMMITS QUE COMUNICAM (10 min)
│   ├── 🎯 Commits Profissionais
│   │   ├── Atômicos (uma mudança lógica)
│   │   ├── Mensagem clara
│   │   └── Mudanças relacionadas
│   ├── 📐 Formato Imperativo
│   │   ├── "If applied, this commit will..."
│   │   ├── ✅ Add, Fix, Update
│   │   ├── ❌ Added, Fixing, Updates
│   │   └── Em inglês (padrão indústria)
│   ├── 🏷️ Conventional Commits
│   │   ├── feat: Nova funcionalidade
│   │   ├── fix: Correção de bug
│   │   ├── docs: Documentação
│   │   ├── style: Formatação (não muda lógica)
│   │   ├── refactor: Reescrita sem mudar comportamento
│   │   ├── test: Testes
│   │   └── chore: Manutenção (deps, build)
│   ├── 📏 Tamanho
│   │   ├── Título: max 50 caracteres
│   │   ├── Corpo: wrap 72 caracteres
│   │   └── Corpo para contexto adicional
│   ├── 🔗 Referências
│   │   ├── Closes #123 (fecha issue)
│   │   ├── Fixes #456
│   │   ├── Resolves #789
│   │   └── @username (mencionar pessoa)
│   └── ✅ Exemplos
│       ├── ✅ "feat: add user authentication with JWT"
│       ├── ✅ "fix: resolve memory leak in image upload"
│       ├── ✅ "docs: update API documentation"
│       ├── ❌ "updates" (vago)
│       ├── ❌ "fix bug" (qual bug?)
│       └── ❌ "Added stuff" (passado)
│
└── 🚫 LIÇÃO 2.5: .GITIGNORE ESSENCIAL (5 min)
    ├── 🔒 O que NUNCA Versionar
    │   ├── Credenciais
    │   │   ├── .env, .env.local
    │   │   ├── credentials.json
    │   │   ├── *.pem, *.key
    │   │   └── id_rsa, id_ed25519
    │   ├── Dependências
    │   │   ├── node_modules/
    │   │   ├── venv/, env/
    │   │   ├── vendor/bundle/
    │   │   └── target/
    │   ├── Build
    │   │   ├── dist/, build/, out/
    │   │   ├── *.min.js
    │   │   └── *.bundle.js
    │   ├── IDEs
    │   │   ├── .vscode/, .idea/
    │   │   ├── *.swp
    │   │   └── *.sublime-workspace
    │   ├── Sistema
    │   │   ├── .DS_Store (macOS)
    │   │   ├── Thumbs.db (Windows)
    │   │   └── *~ (backups)
    │   └── Temporários
    │       ├── *.tmp, *.log
    │       └── .cache/
    ├── 📚 Templates Prontos
    │   ├── github.com/github/gitignore
    │   └── gitignore.io (gerador)
    ├── 📐 Sintaxe
    │   ├── *.log → Todos com extensão
    │   ├── node_modules/ → Diretório
    │   ├── !importante.log → Exceção
    │   ├── /root-only.txt → Só no root
    │   └── **/temp/ → Em qualquer nível
    ├── 💡 Pattern .env.example
    │   ├── .env → NÃO versionar (tem senhas)
    │   ├── .env.example → Versionar (template)
    │   └── README: "cp .env.example .env"
    └── 🔧 Arquivo Já Commitado
        ├── git rm --cached arquivo
        ├── Adicionar ao .gitignore
        └── git commit -m "Remove sensitive file"
```

---

## Módulo 3: Colaboração Profissional

```
🤝 MÓDULO 3: COLABORAÇÃO PROFISSIONAL (55 min)
│
├── 🌿 LIÇÃO 3.1: BRANCHES (12 min)
│   ├── 💡 O que são Branches
│   │   ├── Linha independente de desenvolvimento
│   │   ├── Analogia: Rodovia
│   │   │   ├── main = Rodovia principal (estável)
│   │   │   ├── Branches = Vias paralelas (experimentos)
│   │   │   └── Merge = Retornar à rodovia principal
│   │   └── Isolamento: mudanças não afetam main
│   ├── 🎯 Por que Usar
│   │   ├── Proteção do código estável
│   │   ├── Trabalho paralelo (múltiplos devs)
│   │   ├── Code review antes de integrar
│   │   └── Experimentos seguros
│   ├── 🔧 Comandos Básicos
│   │   ├── git branch (listar)
│   │   ├── git branch -a (todas, incluindo remotas)
│   │   ├── git checkout -b nome (criar e mudar)
│   │   ├── git switch nome (mudar, Git 2.23+)
│   │   ├── git branch -d nome (deletar local)
│   │   └── git push origin --delete nome (deletar remota)
│   ├── 🏷️ Convenções de Nomenclatura
│   │   ├── feature/descricao
│   │   ├── fix/bug-descricao
│   │   ├── hotfix/urgente
│   │   ├── refactor/melhoria
│   │   ├── docs/atualizacao
│   │   ├── test/adicionar-testes
│   │   └── Regras:
│   │       ├── kebab-case
│   │       ├── Inglês
│   │       ├── Descritivo mas conciso
│   │       └── Sem espaços ou caracteres especiais
│   ├── 🔄 Workflow de Branch
│   │   ├── 1. git checkout main && git pull
│   │   ├── 2. git checkout -b feature/nova
│   │   ├── 3. Trabalhar + commits
│   │   ├── 4. git push -u origin feature/nova
│   │   ├── 5. Abrir Pull Request
│   │   └── 6. Após merge: git branch -d feature/nova
│   ├── 🔀 main vs master
│   │   ├── master = Antigo (até 2020)
│   │   ├── main = Padrão atual (2020+)
│   │   └── Renomear: git branch -m master main
│   ├── 🔄 Sincronização
│   │   ├── git merge main (método 1)
│   │   └── git rebase main (método 2, histórico limpo)
│   └── 📊 Estratégias
│       ├── Git Flow (tradicional)
│       │   ├── main + develop + feature/release/hotfix
│       │   └── Para: Times grandes, releases planejados
│       └── GitHub Flow (simples)
│           ├── main + feature branches
│           └── Para: Deploy contínuo, times pequenos
│
├── 🔄 LIÇÃO 3.2: PULL REQUEST (15 min)
│   ├── 💡 O que é PR
│   │   ├── Proposta de mudança no código
│   │   ├── Fluxo: PR → Review → Ajustes → Approve → Merge
│   │   └── Regra de ouro: Nada em main sem PR
│   ├── 📋 Anatomia de PR Profissional
│   │   ├── 📝 Descrição
│   │   │   └── O que faz, resumo claro
│   │   ├── 🎯 Motivação
│   │   │   └── Por que, closes #issue
│   │   ├── ✨ Mudanças
│   │   │   └── Lista detalhada de alterações
│   │   ├── 🧪 Como Testar
│   │   │   └── Passos para revisor validar
│   │   ├── 📸 Screenshots
│   │   │   └── Se tiver UI
│   │   └── ✅ Checklist
│   │       ├── Code style
│   │       ├── Testes passam
│   │       ├── Docs atualizadas
│   │       └── Sem breaking changes
│   ├── 🚀 Criando PR
│   │   ├── 1. git push -u origin branch
│   │   ├── 2. GitHub → "Compare & pull request"
│   │   ├── 3. Preencher título e descrição
│   │   ├── 4. Selecionar reviewers
│   │   ├── 5. Add labels (enhancement, bug)
│   │   └── 6. "Create pull request"
│   ├── 🏷️ Tipos de PR
│   │   ├── Feature → Nova funcionalidade
│   │   ├── Bug fix → Correção
│   │   ├── Docs → Documentação
│   │   └── Refactor → Melhoria sem mudança de comportamento
│   ├── 📝 Draft PR
│   │   ├── WIP, não pronto
│   │   ├── Marca como Draft
│   │   └── "Ready for review" quando pronto
│   ├── 🔗 Linkando Issues
│   │   ├── Closes #123 (fecha automaticamente)
│   │   ├── Fixes #456
│   │   ├── Resolves #789
│   │   └── Related to #999 (apenas referência)
│   ├── 📄 PR Template
│   │   └── .github/pull_request_template.md
│   ├── 🔄 Atualizar PR
│   │   └── Novos commits automaticamente atualizam
│   ├── 🔀 Merge Strategies
│   │   ├── Merge commit → Preserva histórico completo
│   │   ├── Squash and merge → 1 commit em main (recomendado)
│   │   └── Rebase and merge → Histórico linear
│   └── ✅ Boas Práticas
│       ├── PRs pequenos (max 400 linhas)
│       ├── Um propósito por PR
│       ├── Self-review antes de pedir review
│       └── Responder feedback rapidamente
│
├── 👀 LIÇÃO 3.3: CODE REVIEW (13 min)
│   ├── 💡 O que é
│   │   ├── Análise de código por colegas
│   │   ├── Objetivos:
│   │   │   ├── Qualidade (bugs, melhorias)
│   │   │   ├── Conhecimento (time aprende)
│   │   │   ├── Padrões (consistência)
│   │   │   └── Mentoria (seniores guiam)
│   │   └── NÃO é: fiscalização ou crítica pessoal
│   ├── 🧠 Mentalidade do Revisor
│   │   ├── ✅ Colaborativa, não confrontacional
│   │   ├── ✅ Ensina e aprende
│   │   ├── ✅ Foca em código, não em pessoa
│   │   └── ❌ Evitar: superioridade, perfeccionismo, pressa
│   ├── 🔍 Processo no GitHub
│   │   ├── 1. PR → Files changed
│   │   ├── 2. Comentário em linha (+)
│   │   └── 3. Review changes (geral)
│   ├── 💬 Tipos de Comentários
│   │   ├── Questões
│   │   │   └── "Pode explicar por que...?"
│   │   ├── Sugestões
│   │   │   └── "Que tal renomear para X?"
│   │   ├── Problemas
│   │   │   └── "⚠️ Potencial bug se X for null"
│   │   ├── Elogios
│   │   │   └── "🎯 Excelente uso de Promise.all!"
│   │   └── Nitpicks
│   │       └── "Nit: typo pequeno"
│   ├── 📐 Estrutura Profissional
│   │   ├── [Tipo] Observação clara
│   │   ├── [Contexto] Por que importa
│   │   └── [Sugestão] Como melhorar
│   ├── ✅ Checklist de Review
│   │   ├── Funcionalidade (faz o que promete?)
│   │   ├── Qualidade (legível, nomes claros)
│   │   ├── Segurança (validação, sem secrets)
│   │   ├── Performance (sem loops desnecessários)
│   │   ├── Testes (cobertura adequada)
│   │   └── Documentação (código complexo comentado)
│   ├── 🏷️ Tipos de Review
│   │   ├── Approve → Código bom, pode mergear
│   │   ├── Request changes → Precisa ajustes
│   │   └── Comment → Feedback sem decisão
│   ├── 💬 Tom e Linguagem
│   │   ├── ✅ "Podemos melhorar...", "Sugiro..."
│   │   ├── ❌ "Obviamente...", "Você fez errado"
│   │   ├── Perguntas, não ordens
│   │   └── Específico, não vago
│   └── ✅ Boas Práticas
│       ├── Revisar em até 24h
│       ├── Elogiar bom código
│       ├── Explicar o "por quê"
│       └── Ser educado sempre
│
└── 🔀 LIÇÃO 3.4: MERGE + CONFLITOS (15 min)
    ├── 💡 O que é Merge
    │   └── Integrar mudanças de uma branch em outra
    ├── ⚡ Fast-forward Merge
    │   ├── main não mudou
    │   ├── Apenas avança ponteiro
    │   └── Histórico linear
    ├── ⚠️ Merge com Conflitos
    │   ├── Causa: mesma parte do mesmo arquivo mudada
    │   └── Git não sabe qual manter
    ├── 📐 Anatomia do Conflito
    │   ├── <<<<<<< HEAD (versão atual)
    │   ├── ======= (separador)
    │   └── >>>>>>> branch (versão da outra branch)
    ├── 🛠️ Resolvendo Conflitos
    │   ├── 1. git status (ver conflitos)
    │   ├── 2. Abrir arquivo, escolher versão
    │   │   ├── Opção 1: Manter sua versão
    │   │   ├── Opção 2: Manter versão deles
    │   │   ├── Opção 3: Combinar ambas
    │   │   └── Opção 4: Solução nova
    │   ├── 3. Deletar marcadores (<<<<, ====, >>>>)
    │   ├── 4. Testar código (⚠️ NUNCA commitar sem testar!)
    │   ├── 5. git add arquivo.js (marcar resolvido)
    │   ├── 6. git commit (completar merge)
    │   └── 7. git push
    ├── 🔧 Ferramentas de Merge
    │   ├── VS Code (botões inline)
    │   ├── git mergetool
    │   └── Meld, KDiff3, Beyond Compare
    ├── 🔄 Tipos de Conflito
    │   ├── Conteúdo (mesma linha modificada)
    │   ├── Rename (arquivo renomeado diferentemente)
    │   └── Delete (um deletou, outro modificou)
    ├── 🛡️ Prevenindo Conflitos
    │   ├── Sync frequente com main
    │   ├── PRs pequenos
    │   ├── Comunicar mudanças grandes
    │   └── Dividir responsabilidades
    ├── 🚫 Abortar Merge
    │   └── git merge --abort
    ├── 🔄 Conflitos em PR
    │   ├── Resolver localmente (recomendado)
    │   ├── git checkout main → git pull
    │   ├── git checkout feature → git merge main
    │   └── Resolver, testar, push
    └── 🆚 Merge vs Rebase
        ├── Merge
        │   ├── Preserva histórico completo
        │   └── Cria commit de merge
        └── Rebase
            ├── Histórico linear
            └── Reaplica commits sobre base atualizada
```

---

## Módulo 4: Sobrevivência + Próximos Passos

```
🆘 MÓDULO 4: SOBREVIVÊNCIA + PRÓXIMOS PASSOS (20 min)
│
├── ↩️ LIÇÃO 4.1: DESFAZENDO ERROS (10 min)
│   ├── 🔄 git restore
│   │   ├── Desfazer mudanças não commitadas
│   │   ├── git restore arquivo.js
│   │   ├── git restore . (tudo)
│   │   ├── git restore --staged (unstage)
│   │   └── ⚠️ Mudanças perdidas permanentemente!
│   ├── ⏮️ git reset
│   │   ├── Desfazer commits
│   │   ├── Modos:
│   │   │   ├── --soft → Mantém mudanças staged
│   │   │   ├── --mixed → Mantém mudanças unstaged (padrão)
│   │   │   └── --hard → Descarta tudo (⚠️ PERIGOSO)
│   │   ├── HEAD~1 (último commit)
│   │   ├── HEAD~3 (3 commits atrás)
│   │   └── ⚠️ NÃO usar em commits já pushed
│   ├── 🔄 git revert
│   │   ├── Desfazer commit publicamente
│   │   ├── Cria novo commit que desfaz
│   │   ├── Preserva histórico (seguro)
│   │   ├── git revert HEAD
│   │   └── Use em commits já pushed
│   ├── 📦 git stash
│   │   ├── Guardar mudanças temporariamente
│   │   ├── git stash save "mensagem"
│   │   ├── git stash list
│   │   ├── git stash pop (recupera último)
│   │   ├── git stash apply (aplica sem remover)
│   │   └── git stash -u (inclui untracked)
│   ├── ✏️ git commit --amend
│   │   ├── Corrigir último commit
│   │   ├── Editar mensagem
│   │   ├── Adicionar arquivo esquecido
│   │   └── --no-edit (mantém mensagem)
│   ├── 🧹 git clean
│   │   ├── Remover arquivos não rastreados
│   │   ├── git clean -n (dry-run)
│   │   ├── git clean -f (arquivos)
│   │   └── git clean -fd (arquivos + diretórios)
│   ├── 📜 git reflog
│   │   ├── Histórico completo de movimentos
│   │   ├── Recuperar commits "perdidos"
│   │   └── git reset --hard HEAD@{X}
│   └── 🧭 Árvore de Decisão
│       ├── Não commitou?
│       │   ├── Descartar → restore
│       │   ├── Guardar → stash
│       │   └── Limpar → clean
│       ├── Commitou localmente?
│       │   ├── Editar último → amend
│       │   ├── Desfazer mantendo → reset --soft
│       │   └── Desfazer descartando → reset --hard
│       └── Já pushed?
│           └── Desfazer → revert (NUNCA reset!)
│
├── 👤 LIÇÃO 4.2: PERFIL PROFISSIONAL (5 min)
│   ├── 🎯 O que Recrutadores Procuram
│   │   ├── Perfil completo (foto, bio)
│   │   ├── Atividade consistente
│   │   ├── READMEs claros
│   │   ├── Código de qualidade
│   │   └── Projetos reais
│   ├── ⚙️ Configuração Básica
│   │   ├── Foto profissional
│   │   ├── Bio (160 chars)
│   │   │   └── Função | Techs | Diferencial
│   │   └── Localização + links
│   ├── 📄 README de Perfil
│   │   ├── Criar repo nome = username
│   │   ├── Sobre mim
│   │   ├── Tecnologias que uso
│   │   ├── Estatísticas GitHub
│   │   └── Como me encontrar
│   ├── 📌 Pinned Repositories (max 6)
│   │   ├── Projeto mais impressionante
│   │   ├── Diferentes tecnologias
│   │   ├── Contribuições open source
│   │   └── Código de qualidade
│   ├── 📊 Contribution Graph
│   │   ├── Commit regularmente
│   │   └── Trabalho consistente > bursts
│   └── ✅ Checklist
│       ├── Foto, bio, localização
│       ├── README de perfil
│       ├── 3-6 repos pinados
│       ├── READMEs profissionais
│       └── Código de qualidade
│
└── 🚀 LIÇÃO 4.3: O QUE VEM DEPOIS (5 min)
    ├── 🎓 Você Já Sabe o Essencial
    │   ├── Git local (80% do uso diário)
    │   ├── GitHub remoto
    │   ├── Branches e workflow
    │   ├── PRs e code review
    │   └── Merge e conflitos
    ├── ⚙️ GitHub Actions
    │   ├── Automatizar workflows
    │   ├── CI/CD (rodar testes, deploy)
    │   └── .github/workflows/test.yml
    ├── 🤖 GitHub Copilot
    │   ├── IA que sugere código
    │   ├── Grátis para estudantes
    │   └── Acelera desenvolvimento
    ├── 🌍 Contribuindo em Open Source
    │   ├── Buscar "good first issue"
    │   ├── Fork → Branch → PR
    │   ├── Seguir CONTRIBUTING.md
    │   └── Aprender com código de qualidade
    ├── 🔧 Recursos Avançados
    │   ├── git rebase -i (reescrever histórico)
    │   ├── git bisect (encontrar bug)
    │   ├── git submodules (repos aninhados)
    │   └── git hooks (automatizar ações)
    ├── 💻 Ferramentas CLI
    │   ├── GitHub CLI (gh)
    │   └── lazygit (TUI)
    ├── 🗺️ Roadmap de Evolução
    │   ├── 1-3 meses
    │   │   ├── Open source contribution
    │   │   ├── GitHub Actions
    │   │   └── Rebase interativo
    │   ├── 3-6 meses
    │   │   ├── CI/CD completo
    │   │   └── Mentoria
    │   └── 6-12 meses
    │       ├── Git internals
    │       ├── Monorepo
    │       └── Maintainer
    └── 📚 Recursos de Aprendizado
        ├── Docs oficiais (Git, GitHub)
        ├── Livro: Pro Git (gratuito)
        ├── Prática: learngitbranching.js.org
        └── Comunidades: GitHub Community, Dev.to
```

---

## Fluxos de Trabalho

### Workflow Individual Básico

```
📝 WORKFLOW INDIVIDUAL
│
1️⃣ SETUP (uma vez)
   ├── git clone repo
   └── cd repo

2️⃣ INÍCIO DO DIA
   └── git pull

3️⃣ TRABALHAR
   ├── Editar arquivos
   ├── git status (ver mudanças)
   ├── git add . (preparar)
   ├── git commit -m "mensagem" (salvar)
   └── git push (enviar)

4️⃣ FIM DO DIA
   └── git push (garantir que está no GitHub)
```

### Workflow de Feature Branch

```
🌿 FEATURE BRANCH WORKFLOW
│
1️⃣ PREPARAR
   ├── git checkout main
   └── git pull

2️⃣ CRIAR BRANCH
   └── git checkout -b feature/nome-descritivo

3️⃣ DESENVOLVER
   ├── Editar arquivos
   ├── git add .
   ├── git commit -m "feat: descrição"
   └── Repetir

4️⃣ PUSH
   └── git push -u origin feature/nome-descritivo

5️⃣ PULL REQUEST
   ├── Abrir PR no GitHub
   ├── Preencher descrição
   └── Selecionar reviewers

6️⃣ CODE REVIEW
   ├── Receber feedback
   ├── Fazer ajustes (commits adicionais)
   └── Push automaticamente atualiza PR

7️⃣ MERGE
   ├── Aprovação
   ├── Merge (Squash recomendado)
   └── Delete branch

8️⃣ CLEANUP
   ├── git checkout main
   ├── git pull (atualiza com merge)
   └── git branch -d feature/nome-descritivo
```

### Workflow de Code Review

```
👀 CODE REVIEW WORKFLOW
│
1️⃣ ACESSAR PR
   └── GitHub → Pull Requests → Selecionar PR

2️⃣ ANALISAR
   ├── Ler descrição
   ├── Files changed (ver código)
   └── Commits (ver histórico)

3️⃣ COMENTAR
   ├── Linha específica (+)
   ├── Tipo de comentário:
   │   ├── Questão
   │   ├── Sugestão
   │   ├── Problema
   │   ├── Elogio
   │   └── Nit
   └── Ser construtivo e específico

4️⃣ REVIEW GERAL
   ├── Review changes
   ├── Escolher tipo:
   │   ├── Approve
   │   ├── Request changes
   │   └── Comment
   └── Submit review

5️⃣ ACOMPANHAR
   ├── Autor faz ajustes
   ├── Revisar novamente
   └── Aprovar quando pronto
```

### Workflow de Resolução de Conflitos

```
⚠️ RESOLUÇÃO DE CONFLITOS
│
1️⃣ DETECTAR
   ├── git merge feature
   └── CONFLICT: Merge conflict in arquivo.js

2️⃣ IDENTIFICAR
   └── git status (ver "both modified")

3️⃣ ABRIR ARQUIVO
   ├── Encontrar marcadores:
   │   ├── <<<<<<< HEAD
   │   ├── =======
   │   └── >>>>>>> feature
   └── Entender versões

4️⃣ ESCOLHER SOLUÇÃO
   ├── Opção 1: Manter HEAD
   ├── Opção 2: Manter feature
   ├── Opção 3: Combinar ambas
   └── Opção 4: Solução nova

5️⃣ EDITAR
   ├── Implementar solução
   └── Deletar TODOS marcadores

6️⃣ TESTAR
   ├── npm test (ou testar manualmente)
   └── ⚠️ NUNCA commitar sem testar!

7️⃣ MARCAR RESOLVIDO
   └── git add arquivo.js

8️⃣ COMPLETAR MERGE
   ├── git commit (mensagem já preenchida)
   └── git push
```

---

## Comandos Essenciais

### Comandos por Categoria

```bash
# ========================================
# SETUP E CONFIGURAÇÃO
# ========================================

# Instalação
git --version

# Config inicial
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
git config --global init.defaultBranch main

# SSH
ssh-keygen -t ed25519 -C "seu@email.com"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com

# Ver configs
git config --list

# ========================================
# CRIAR/CLONAR REPOSITÓRIOS
# ========================================

# Criar repo local
git init

# Clonar repo remoto
git clone git@github.com:user/repo.git

# ========================================
# TRABALHO DIÁRIO
# ========================================

# Ver status
git status
git status -s  # Formato curto

# Adicionar arquivos
git add arquivo.js
git add .  # Tudo no diretório
git add --all  # Todo o repo

# Commit
git commit -m "mensagem"
git commit -am "mensagem"  # Add + commit (só rastreados)

# Ver histórico
git log
git log --oneline
git log --graph --all

# Ver diferenças
git diff  # Mudanças não staged
git diff --staged  # Mudanças staged

# ========================================
# SINCRONIZAÇÃO
# ========================================

# Push
git push
git push -u origin main  # Primeira vez

# Pull
git pull
git pull --rebase  # Com rebase

# Ver remotes
git remote -v

# ========================================
# BRANCHES
# ========================================

# Listar branches
git branch
git branch -a  # Incluindo remotas

# Criar branch
git branch feature/nome
git checkout -b feature/nome  # Criar e mudar
git switch -c feature/nome  # Novo comando

# Mudar de branch
git checkout main
git switch main  # Novo comando

# Deletar branch
git branch -d feature/nome  # Local
git push origin --delete feature/nome  # Remota

# Merge
git merge feature/nome

# Rebase
git rebase main

# ========================================
# DESFAZER ERROS
# ========================================

# Descartar mudanças locais
git restore arquivo.js
git restore .  # Tudo

# Unstage
git restore --staged arquivo.js

# Desfazer commits (local)
git reset --soft HEAD~1  # Mantém mudanças staged
git reset HEAD~1  # Mantém mudanças unstaged
git reset --hard HEAD~1  # Descarta tudo (CUIDADO!)

# Desfazer commit (já pushed)
git revert HEAD

# Stash (guardar temporariamente)
git stash
git stash save "mensagem"
git stash list
git stash pop
git stash apply

# Amend (corrigir último commit)
git commit --amend -m "nova mensagem"
git commit --amend --no-edit  # Mantém mensagem

# Clean (remover não rastreados)
git clean -n  # Dry-run
git clean -fd  # Arquivos + diretórios

# Reflog (recuperar commits)
git reflog
git reset --hard HEAD@{3}

# ========================================
# RESOLUÇÃO DE CONFLITOS
# ========================================

# Abortar merge
git merge --abort

# Marcar como resolvido
git add arquivo-resolvido.js

# ========================================
# INSPEÇÃO
# ========================================

# Ver commit específico
git show abc1234

# Ver diferença entre branches
git diff main..feature

# Ver arquivos mudados
git diff --name-only

# Ver quem mudou cada linha
git blame arquivo.js

# ========================================
# AVANÇADOS
# ========================================

# Rebase interativo
git rebase -i HEAD~3

# Cherry-pick (aplicar commit específico)
git cherry-pick abc1234

# Bisect (encontrar bug)
git bisect start
git bisect bad
git bisect good abc1234
```

### Atalhos Úteis

```bash
# Alias úteis para adicionar ao ~/.gitconfig

[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = restore --staged
    last = log -1 HEAD
    visual = log --graph --oneline --all
    amend = commit --amend --no-edit
```

---

## Referência Rápida por Situação

### "Cometi na branch errada!"

```bash
# Ver hash do commit
git log --oneline

# Desfazer commit na branch errada
git reset --soft HEAD~1

# Guardar mudanças
git stash

# Mudar para branch certa
git checkout branch-certa

# Recuperar mudanças
git stash pop

# Commitar novamente
git commit -m "mensagem"
```

### "Quero editar mensagem do último commit"

```bash
git commit --amend -m "nova mensagem"
```

### "Esqueci de adicionar arquivo no commit"

```bash
git add arquivo-esquecido.js
git commit --amend --no-edit
```

### "Quero desfazer último commit mas manter mudanças"

```bash
git reset --soft HEAD~1
```

### "Commitei senha por engano!"

```bash
# 1. Remover do Git
git rm --cached .env
echo ".env" >> .gitignore

# 2. Commit
git commit -m "Remove sensitive file"

# 3. Force push (se já pushed)
git push --force

# 4. IMPORTANTE: Revocar credencial imediatamente!
```

### "GitHub diz que tenho conflitos no PR"

```bash
# 1. Atualizar main local
git checkout main
git pull

# 2. Voltar para feature e merge main
git checkout feature/minha-branch
git merge main

# 3. Resolver conflitos (editar arquivos)
# ... resolver ...

# 4. Marcar como resolvido
git add .
git commit

# 5. Push
git push
```

---

## Checklist Final

### Antes de Commitar
- [ ] `git status` - Ver o que vai ser commitado
- [ ] `git diff` - Revisar mudanças
- [ ] Testes passam (se tiver)
- [ ] Mensagem de commit clara e específica
- [ ] Commit é atômico (uma mudança lógica)

### Antes de Push
- [ ] Todos commits têm mensagens profissionais
- [ ] Código funciona (testado)
- [ ] Sem `console.log` ou debug code
- [ ] Sem credenciais ou dados sensíveis

### Antes de Criar PR
- [ ] Branch atualizada com main (`git pull origin main`)
- [ ] Testes passam
- [ ] README atualizado (se necessário)
- [ ] Self-review completo
- [ ] Descrição de PR preparada

### Antes de Merge PR
- [ ] Code review aprovado
- [ ] CI/CD checks passando (se tiver)
- [ ] Conflitos resolvidos
- [ ] Testes passam

---

**Última atualização:** 2025-12-25
**Versão:** 1.0
**Curso:** GitHub Essencial para Devs
