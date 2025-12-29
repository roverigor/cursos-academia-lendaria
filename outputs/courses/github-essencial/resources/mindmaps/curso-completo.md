# Mapa Mental: GitHub Essencial para Devs

## Visão Geral

Este mapa mental apresenta a estrutura completa do curso GitHub Essencial para Devs, conectando conceitos fundamentais de Git e GitHub desde o setup inicial até práticas avançadas de colaboração profissional.

## Estrutura do Mapa

```
🎯 GITHUB ESSENCIAL PARA DEVS (150 min)
│
├── 📦 MÓDULO 1: SETUP MODERNO (25 min)
│   ├── 1.1 Git vs GitHub (5 min)
│   │   ├── Git = Sistema local de controle de versão
│   │   │   ├── Funciona offline
│   │   │   ├── Rastreia mudanças
│   │   │   ├── Criado por Linus Torvalds (2005)
│   │   │   └── Comandos: init, add, commit
│   │   ├── GitHub = Plataforma de colaboração na nuvem
│   │   │   ├── Hospeda repositórios
│   │   │   ├── Pull Requests
│   │   │   ├── Issues e Actions
│   │   │   └── Comprado pela Microsoft (2018)
│   │   ├── Relação: Local ↔ Nuvem (push/pull)
│   │   ├── Por que empresas exigem
│   │   │   ├── Colaboração distribuída
│   │   │   ├── Portfólio vivo
│   │   │   └── Workflow padronizado
│   │   └── Alternativas: GitLab, Bitbucket, Gitea
│   │
│   ├── 1.2 Instalação + Config (10 min)
│   │   ├── Instalação por SO
│   │   │   ├── Windows → Git for Windows
│   │   │   ├── macOS → Homebrew ou Xcode CLI
│   │   │   └── Linux → apt/dnf install git
│   │   ├── Configuração essencial
│   │   │   ├── user.name (nome real)
│   │   │   ├── user.email (mesmo do GitHub)
│   │   │   ├── core.editor (VS Code, Nano, Vim)
│   │   │   ├── init.defaultBranch = main
│   │   │   └── color.ui = auto
│   │   ├── Verificação: git config --list
│   │   ├── Arquivo: ~/.gitconfig (global)
│   │   └── Configs extras: pull.rebase, credential.helper
│   │
│   └── 1.3 SSH com Ed25519 (10 min)
│       ├── O que é SSH
│       │   ├── Protocolo criptografado
│       │   ├── Par de chaves (pública/privada)
│       │   └── GitHub removeu senha em 2021
│       ├── Por que Ed25519
│       │   ├── 256 bits (vs RSA 2048+)
│       │   ├── Mais rápido
│       │   ├── Mais seguro
│       │   └── Recomendado pelo GitHub (2022+)
│       ├── Passos
│       │   ├── ssh-keygen -t ed25519 -C "email"
│       │   ├── ssh-add ~/.ssh/id_ed25519
│       │   ├── Copiar chave pública (.pub)
│       │   ├── Adicionar no GitHub (Settings → SSH keys)
│       │   └── Testar: ssh -T git@github.com
│       └── SSH vs HTTPS: Sempre prefira SSH
│
├── 📦 MÓDULO 2: SEU PRIMEIRO REPO REAL (50 min)
│   ├── 2.1 Criando repo certo (10 min)
│   │   ├── Anatomia de repo profissional
│   │   │   ├── README.md → O que é, como usar
│   │   │   ├── .gitignore → O que NÃO versionar
│   │   │   └── LICENSE → Como usar o código
│   │   ├── Criar no GitHub
│   │   │   ├── Nome em kebab-case
│   │   │   ├── Descrição clara
│   │   │   ├── Public vs Private
│   │   │   └── ✅ Initialize com README, .gitignore, License
│   │   ├── README profissional
│   │   │   ├── Título + Descrição
│   │   │   ├── Tecnologias usadas
│   │   │   ├── Instalação
│   │   │   ├── Uso e exemplos
│   │   │   └── Screenshots (se UI)
│   │   └── Licenças
│   │       ├── MIT → Portfólio, open source
│   │       ├── Apache 2.0 → Corporativo
│   │       └── GPL 3.0 → Software livre
│   │
│   ├── 2.2 O ciclo básico (15 min)
│   │   ├── Modelo mental do Git
│   │   │   ├── Working Directory → Arquivos editáveis
│   │   │   ├── Staging Area → Preparação para commit
│   │   │   └── Repository → Histórico de versões
│   │   ├── git clone
│   │   │   ├── Copia repo remoto
│   │   │   ├── SSH: git@github.com:user/repo.git
│   │   │   └── Só clona uma vez
│   │   ├── git status
│   │   │   ├── Mostra situação atual
│   │   │   ├── Arquivos modified/untracked
│   │   │   └── Use antes/depois de tudo
│   │   ├── git add
│   │   │   ├── Move para staging
│   │   │   ├── git add arquivo.js (específico)
│   │   │   ├── git add . (tudo)
│   │   │   └── git add -p (interativo)
│   │   ├── git commit
│   │   │   ├── Salva snapshot
│   │   │   ├── git commit -m "mensagem"
│   │   │   ├── Mensagem em imperativo
│   │   │   └── git commit -am (add + commit de rastreados)
│   │   └── Histórico: git log --oneline
│   │
│   ├── 2.3 Push e Pull (10 min)
│   │   ├── Local ↔ Remoto
│   │   ├── git push
│   │   │   ├── Envia commits locais
│   │   │   ├── git push -u origin main (primeira vez)
│   │   │   ├── git push (pushes seguintes)
│   │   │   └── ⚠️ --force só em branches pessoais
│   │   ├── git pull
│   │   │   ├── Recebe mudanças do GitHub
│   │   │   ├── pull = fetch + merge
│   │   │   ├── git pull --rebase (histórico limpo)
│   │   │   └── Pull no início do dia
│   │   ├── Quando usar
│   │   │   ├── Push após commit
│   │   │   ├── Pull antes de começar trabalho
│   │   │   └── Pull antes de criar PR
│   │   └── Troubleshooting
│   │       ├── Rejected → git pull primeiro
│   │       └── Uncommitted changes → commit ou stash
│   │
│   ├── 2.4 Commits que comunicam (10 min)
│   │   ├── Commits profissionais
│   │   │   ├── Atômicos (uma mudança lógica)
│   │   │   ├── Mensagem clara
│   │   │   └── Mudanças relacionadas
│   │   ├── Formato imperativo
│   │   │   ├── Add, Fix, Update
│   │   │   ├── Não Added, Fixing
│   │   │   └── "If applied, this commit will..."
│   │   ├── Conventional Commits
│   │   │   ├── feat: Nova funcionalidade
│   │   │   ├── fix: Correção de bug
│   │   │   ├── docs: Documentação
│   │   │   ├── style: Formatação
│   │   │   ├── refactor: Reescrita sem mudar comportamento
│   │   │   ├── test: Testes
│   │   │   └── chore: Manutenção
│   │   ├── Tamanho
│   │   │   ├── Título: max 50 caracteres
│   │   │   ├── Corpo: wrap 72 caracteres
│   │   │   └── Corpo para contexto adicional
│   │   └── Referências
│   │       ├── Closes #123 (fecha issue)
│   │       ├── Fixes #456 (correção)
│   │       └── @username (menciona pessoa)
│   │
│   └── 2.5 .gitignore essencial (5 min)
│       ├── O que NUNCA versionar
│       │   ├── Credenciais (.env, *.pem, *.key)
│       │   ├── Dependências (node_modules/, venv/)
│       │   ├── Build (dist/, build/, *.min.js)
│       │   ├── IDEs (.vscode/, .idea/, *.swp)
│       │   ├── Sistema (.DS_Store, Thumbs.db)
│       │   └── Temporários (*.tmp, *.log, *.cache)
│       ├── Templates prontos
│       │   ├── github.com/github/gitignore
│       │   └── gitignore.io (gerador)
│       ├── Sintaxe
│       │   ├── *.log → Todos com extensão
│       │   ├── node_modules/ → Diretório
│       │   ├── !importante.log → Exceção
│       │   └── /root-only.txt → Só no root
│       ├── .env.example pattern
│       │   ├── .env → não versiona (tem senhas)
│       │   ├── .env.example → versiona (template)
│       │   └── README explica: cp .env.example .env
│       └── Arquivo já commitado
│           ├── git rm --cached arquivo
│           └── Adicionar ao .gitignore
│
├── 📦 MÓDULO 3: COLABORAÇÃO PROFISSIONAL (55 min)
│   ├── 3.1 Branches (12 min)
│   │   ├── O que são branches
│   │   │   ├── Linha independente de desenvolvimento
│   │   │   ├── main = Rodovia principal (estável)
│   │   │   └── Branches = Vias paralelas (experimentos)
│   │   ├── Por que usar
│   │   │   ├── Proteção do código estável
│   │   │   ├── Trabalho paralelo do time
│   │   │   ├── Code review antes de integrar
│   │   │   └── Experimentos seguros
│   │   ├── Comandos básicos
│   │   │   ├── git branch (listar)
│   │   │   ├── git checkout -b nome (criar e mudar)
│   │   │   ├── git switch nome (mudar, Git 2.23+)
│   │   │   ├── git branch -d nome (deletar)
│   │   │   └── git push origin --delete nome (deletar remota)
│   │   ├── Convenções de nomenclatura
│   │   │   ├── feature/descricao
│   │   │   ├── fix/bug-descricao
│   │   │   ├── hotfix/urgente
│   │   │   ├── refactor/melhoria
│   │   │   └── Kebab-case, inglês
│   │   ├── Workflow
│   │   │   ├── git checkout main && git pull
│   │   │   ├── git checkout -b feature/nova
│   │   │   ├── Trabalhar + commits
│   │   │   ├── git push -u origin feature/nova
│   │   │   └── Após merge: git branch -d feature/nova
│   │   ├── main vs master
│   │   │   ├── master = antigo (até 2020)
│   │   │   └── main = padrão atual (2020+)
│   │   └── Sincronização
│   │       ├── git merge main (método 1)
│   │       └── git rebase main (método 2, histórico limpo)
│   │
│   ├── 3.2 Pull Request (15 min)
│   │   ├── O que é PR
│   │   │   ├── Proposta de mudança
│   │   │   ├── Fluxo: PR → Review → Ajustes → Approve → Merge
│   │   │   └── Regra: Nada em main sem PR
│   │   ├── Anatomia de PR profissional
│   │   │   ├── 📝 Descrição (o que faz)
│   │   │   ├── 🎯 Motivação (por que, closes #issue)
│   │   │   ├── ✨ Mudanças (lista detalhada)
│   │   │   ├── 🧪 Como testar (passos)
│   │   │   ├── 📸 Screenshots (se UI)
│   │   │   └── ✅ Checklist (code style, testes, docs)
│   │   ├── Criando PR
│   │   │   ├── git push -u origin branch
│   │   │   ├── GitHub → Compare & pull request
│   │   │   ├── Preencher título e descrição
│   │   │   ├── Selecionar reviewers
│   │   │   └── Add labels (enhancement, bug, docs)
│   │   ├── Tipos de PR
│   │   │   ├── Feature → Nova funcionalidade
│   │   │   ├── Bug fix → Correção
│   │   │   ├── Docs → Documentação
│   │   │   └── Refactor → Melhoria sem mudança de comportamento
│   │   ├── Draft PR
│   │   │   ├── WIP, não pronto para merge
│   │   │   ├── Marca como Draft
│   │   │   └── Ready for review quando pronto
│   │   ├── Linkando issues
│   │   │   ├── Closes #123 (fecha automaticamente)
│   │   │   ├── Fixes #456
│   │   │   └── Resolves #789
│   │   ├── PR Template
│   │   │   └── .github/pull_request_template.md
│   │   ├── Atualizar PR
│   │   │   └── Novos commits automaticamente atualizam
│   │   ├── Merge strategies
│   │   │   ├── Merge commit (preserva histórico completo)
│   │   │   ├── Squash and merge (1 commit em main)
│   │   │   └── Rebase and merge (histórico linear)
│   │   └── Boas práticas
│   │       ├── PRs pequenos (max 400 linhas)
│   │       ├── Um propósito por PR
│   │       ├── Self-review antes de pedir review
│   │       └── Responder feedback rapidamente
│   │
│   ├── 3.3 Code Review (13 min)
│   │   ├── O que é
│   │   │   ├── Análise de código por colegas
│   │   │   ├── Objetivos: qualidade, conhecimento, padrões, mentoria
│   │   │   └── Não é fiscalização ou crítica pessoal
│   │   ├── Mentalidade do revisor
│   │   │   ├── Colaborativa, não confrontacional
│   │   │   ├── Ensina e aprende
│   │   │   └── Foca em código, não em pessoa
│   │   ├── Processo no GitHub
│   │   │   ├── PR → Files changed
│   │   │   ├── Comentário em linha (+)
│   │   │   └── Review changes (geral)
│   │   ├── Tipos de comentários
│   │   │   ├── Questões → "Pode explicar por que...?"
│   │   │   ├── Sugestões → "Que tal renomear..."
│   │   │   ├── Problemas → "⚠️ Potencial bug..."
│   │   │   ├── Elogios → "🎯 Excelente uso de..."
│   │   │   └── Nitpicks → "Nit: typo pequeno..."
│   │   ├── Estrutura profissional
│   │   │   ├── [Tipo] Observação clara
│   │   │   ├── [Contexto] Por que importa
│   │   │   └── [Sugestão] Como melhorar
│   │   ├── Checklist de review
│   │   │   ├── Funcionalidade (faz o que promete?)
│   │   │   ├── Qualidade (legível, nomes claros)
│   │   │   ├── Segurança (validação, sem secrets)
│   │   │   ├── Performance (sem loops desnecessários)
│   │   │   ├── Testes (cobertura adequada)
│   │   │   └── Documentação (código complexo comentado)
│   │   ├── Tipos de review
│   │   │   ├── Approve → Código bom, pode mergear
│   │   │   ├── Request changes → Precisa ajustes
│   │   │   └── Comment → Feedback sem decisão
│   │   ├── Tom e linguagem
│   │   │   ├── Use: "Podemos melhorar...", "Sugiro..."
│   │   │   ├── Evite: "Obviamente...", "Você fez errado"
│   │   │   ├── Perguntas, não ordens
│   │   │   └── Específico, não vago
│   │   └── Boas práticas
│   │       ├── Revisar em até 24h
│   │       ├── Elogiar bom código
│   │       ├── Explicar o "por quê"
│   │       └── Ser educado sempre
│   │
│   └── 3.4 Merge + Conflitos (15 min)
│       ├── O que é merge
│       │   └── Integrar mudanças de uma branch em outra
│       ├── Fast-forward merge
│       │   ├── main não mudou
│       │   ├── Apenas avança ponteiro
│       │   └── Histórico linear
│       ├── Merge com conflitos
│       │   ├── Causa: mesma parte do mesmo arquivo mudada
│       │   └── Git não sabe qual manter
│       ├── Anatomia do conflito
│       │   ├── <<<<<<< HEAD (versão atual)
│       │   ├── ======= (separador)
│       │   └── >>>>>>> branch (versão da outra branch)
│       ├── Resolvendo conflitos
│       │   ├── 1. git status (ver arquivos com conflito)
│       │   ├── 2. Abrir arquivo, escolher versão
│       │   ├── 3. Deletar marcadores (<<<<, ====, >>>>)
│       │   ├── 4. Testar código (npm test)
│       │   ├── 5. git add arquivo.js (marcar resolvido)
│       │   ├── 6. git commit (completar merge)
│       │   └── ⚠️ NUNCA commitar sem testar!
│       ├── Ferramentas de merge
│       │   ├── VS Code (botões inline)
│       │   ├── git mergetool
│       │   └── Meld, KDiff3, Beyond Compare
│       ├── Tipos de conflito
│       │   ├── Conteúdo (mesma linha modificada)
│       │   ├── Rename (arquivo renomeado diferentemente)
│       │   └── Delete (um deletou, outro modificou)
│       ├── Prevenindo conflitos
│       │   ├── Sync frequente com main
│       │   ├── PRs pequenos
│       │   ├── Comunicar mudanças grandes
│       │   └── Dividir responsabilidades
│       ├── Abortar merge
│       │   └── git merge --abort
│       ├── Conflitos em PR
│       │   ├── Resolver localmente (recomendado)
│       │   └── git checkout main → git pull → git checkout feature → git merge main
│       └── Merge vs Rebase
│           ├── Merge → preserva histórico completo
│           ├── Rebase → histórico linear
│           └── Usar rebase em branch pessoal
│
└── 📦 MÓDULO 4: SOBREVIVÊNCIA + PRÓXIMOS PASSOS (20 min)
    ├── 4.1 Desfazendo erros (10 min)
    │   ├── git restore
    │   │   ├── Desfazer mudanças não commitadas
    │   │   ├── git restore arquivo.js
    │   │   ├── git restore . (tudo)
    │   │   └── git restore --staged (unstage)
    │   ├── git reset
    │   │   ├── Desfazer commits
    │   │   ├── --soft → mantém mudanças staged
    │   │   ├── --mixed → mantém mudanças unstaged (padrão)
    │   │   ├── --hard → descarta tudo (⚠️ PERIGOSO)
    │   │   ├── HEAD~1 (último commit)
    │   │   └── ⚠️ Não usar em commits já pushed
    │   ├── git revert
    │   │   ├── Desfazer commit publicamente
    │   │   ├── Cria novo commit que desfaz
    │   │   ├── Preserva histórico
    │   │   └── Use em commits já pushed
    │   ├── git stash
    │   │   ├── Guardar mudanças temporariamente
    │   │   ├── git stash save "mensagem"
    │   │   ├── git stash list
    │   │   ├── git stash pop (recupera último)
    │   │   ├── git stash apply (aplica sem remover)
    │   │   └── git stash -u (inclui untracked)
    │   ├── git commit --amend
    │   │   ├── Corrigir último commit
    │   │   ├── Editar mensagem
    │   │   ├── Adicionar arquivo esquecido
    │   │   └── --no-edit (mantém mensagem)
    │   ├── git clean
    │   │   ├── Remover arquivos não rastreados
    │   │   ├── git clean -n (dry-run)
    │   │   ├── git clean -f (arquivos)
    │   │   └── git clean -fd (arquivos + diretórios)
    │   ├── git reflog
    │   │   ├── Histórico completo de movimentos
    │   │   └── Recuperar commits "perdidos"
    │   └── Árvore de decisão
    │       ├── Não commitou → restore ou stash
    │       ├── Commitou localmente → reset ou amend
    │       └── Já pushed → revert (nunca reset!)
    │
    ├── 4.2 Perfil profissional (5 min)
    │   ├── O que recrutadores procuram
    │   │   ├── Perfil completo (foto, bio)
    │   │   ├── Atividade consistente
    │   │   ├── READMEs claros
    │   │   ├── Código de qualidade
    │   │   └── Projetos reais
    │   ├── Configuração básica
    │   │   ├── Foto profissional
    │   │   ├── Bio (160 chars): Função | Techs | Diferencial
    │   │   └── Localização + links (portfolio, LinkedIn)
    │   ├── README de perfil
    │   │   ├── Criar repo com nome = username
    │   │   ├── Sobre mim
    │   │   ├── Tecnologias que uso
    │   │   ├── Estatísticas GitHub
    │   │   └── Como me encontrar
    │   ├── Pinned repositories (max 6)
    │   │   ├── Projeto mais impressionante
    │   │   ├── Diferentes tecnologias
    │   │   ├── Contribuições open source
    │   │   └── Código de qualidade
    │   ├── Contribution graph
    │   │   ├── Commit regularmente
    │   │   └── Trabalho consistente > bursts
    │   └── Checklist
    │       ├── ✅ Foto, bio, localização
    │       ├── ✅ README de perfil
    │       ├── ✅ 3-6 repos pinados
    │       ├── ✅ READMEs profissionais
    │       └── ✅ Código de qualidade
    │
    └── 4.3 O que vem depois (5 min)
        ├── Você já sabe o essencial
        │   ├── Git local (80% do uso diário)
        │   ├── GitHub remoto
        │   ├── Branches e workflow
        │   ├── PRs e code review
        │   └── Merge e conflitos
        ├── GitHub Actions
        │   ├── Automatizar workflows
        │   ├── CI/CD (rodar testes, deploy)
        │   └── .github/workflows/test.yml
        ├── GitHub Copilot
        │   ├── IA que sugere código
        │   ├── Grátis para estudantes
        │   └── Acelera desenvolvimento
        ├── Contribuindo em open source
        │   ├── Buscar "good first issue"
        │   ├── Fork → Branch → PR
        │   ├── Seguir CONTRIBUTING.md
        │   └── Aprender com código de qualidade
        ├── Recursos avançados
        │   ├── git rebase -i (reescrever histórico)
        │   ├── git bisect (encontrar bug)
        │   ├── git submodules (repos aninhados)
        │   └── git hooks (automatizar ações)
        ├── Ferramentas CLI
        │   ├── GitHub CLI (gh)
        │   └── lazygit (TUI)
        ├── Roadmap de evolução
        │   ├── 1-3 meses: Open source + Actions + rebase -i
        │   ├── 3-6 meses: CI/CD + mentoria
        │   └── 6-12 meses: Git internals + monorepo + maintainer
        └── Recursos de aprendizado
            ├── Docs oficiais (Git, GitHub)
            ├── Livro: Pro Git (gratuito)
            ├── Prática: learngitbranching.js.org
            └── Comunidades: GitHub Community, Dev.to
```

## Conexões Principais entre Conceitos

1. **Setup → Workflow → Colaboração**: O curso segue progressão natural desde configuração até trabalho em equipe
2. **Local ↔ Remoto**: Git (local) sincroniza com GitHub (remoto) via push/pull
3. **Branches → PRs → Code Review → Merge**: Fluxo completo de colaboração profissional
4. **Commits → Histórico → Reset/Revert**: Entender commits é fundamental para desfazer erros
5. **Teoria → Prática**: Cada conceito tem exercício prático associado

## Conceitos Transversais

- **Profissionalismo**: Perpassa todo o curso (commits claros, READMEs, code review respeitoso)
- **Boas Práticas**: Destacadas em cada módulo (SSH Ed25519, conventional commits, PRs pequenos)
- **Segurança**: .gitignore, nunca commitar senhas, SSH sobre HTTPS
- **Colaboração**: Tema central do Módulo 3, mas presente em todo curso

## Comandos Git Essenciais Cobertos

- **Básicos**: clone, status, add, commit, push, pull, log
- **Branches**: branch, checkout, switch, merge
- **Desfazer**: restore, reset, revert, stash, clean
- **Avançados**: rebase, cherry-pick, reflog, bisect

## Padrão 2025

O curso enfatiza práticas atuais:
- SSH Ed25519 (não RSA)
- Branch `main` (não `master`)
- Conventional Commits
- Pull request workflow
- Code review colaborativo
