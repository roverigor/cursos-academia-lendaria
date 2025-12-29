# Glossário Completo: Git e GitHub

## Índice Alfabético

[A](#a) | [B](#b) | [C](#c) | [D](#d) | [E](#e) | [F](#f) | [G](#g) | [H](#h) | [I](#i) | [K](#k) | [L](#l) | [M](#m) | [N](#n) | [O](#o) | [P](#p) | [R](#r) | [S](#s) | [T](#t) | [U](#u) | [V](#v) | [W](#w)

---

## A

### add
**Termo em inglês:** add
**Tradução literal:** adicionar
**Definição:** Comando que move arquivos do Working Directory para Staging Area, preparando-os para o próximo commit.

**Exemplo de uso:**
```bash
git add index.js
git add .  # Adiciona todos os arquivos modificados
```

**Termos relacionados:** commit, staging area, working directory

---

### amend
**Termo em inglês:** amend
**Tradução literal:** emendar, corrigir
**Definição:** Opção do comando commit que permite modificar o último commit, seja alterando a mensagem ou adicionando arquivos esquecidos.

**Exemplo de uso:**
```bash
git commit --amend -m "Nova mensagem"
git commit --amend --no-edit  # Mantém mensagem atual
```

**Termos relacionados:** commit, reset

---

## B

### branch
**Termo em inglês:** branch
**Tradução literal:** ramo, galho
**Definição:** Linha independente de desenvolvimento que permite trabalhar em features isoladamente sem afetar o código principal.

**Exemplo de uso:**
```bash
git branch feature/login
git checkout -b feature/dashboard  # Criar e mudar
```

**Termos relacionados:** main, merge, checkout, switch

---

### bisect
**Termo em inglês:** bisect
**Tradução literal:** bissetar, dividir ao meio
**Definição:** Comando que usa busca binária para encontrar o commit exato que introduziu um bug.

**Exemplo de uso:**
```bash
git bisect start
git bisect bad  # Commit atual tem bug
git bisect good abc1234  # Commit abc1234 estava bom
```

**Termos relacionados:** log, commit

---

## C

### checkout
**Termo em inglês:** checkout
**Tradução literal:** fazer checkout, mudar para
**Definição:** Comando que alterna entre branches ou restaura arquivos de commits anteriores.

**Exemplo de uso:**
```bash
git checkout main
git checkout -b feature/nova  # Criar e mudar de branch
git checkout -- arquivo.js  # Restaurar arquivo (antigo)
```

**Termos relacionados:** switch, branch, restore

---

### cherry-pick
**Termo em inglês:** cherry-pick
**Tradução literal:** escolher a dedo, selecionar
**Definição:** Comando que aplica as mudanças de um commit específico em outra branch.

**Exemplo de uso:**
```bash
git cherry-pick abc1234
```

**Termos relacionados:** commit, merge, rebase

---

### clean
**Termo em inglês:** clean
**Tradução literal:** limpar
**Definição:** Comando que remove arquivos não rastreados (untracked) do working directory.

**Exemplo de uso:**
```bash
git clean -n  # Dry-run, mostra o que seria deletado
git clean -fd  # Deleta arquivos e diretórios
```

**Termos relacionados:** status, restore

---

### clone
**Termo em inglês:** clone
**Tradução literal:** clonar
**Definição:** Comando que cria uma cópia local completa de um repositório remoto.

**Exemplo de uso:**
```bash
git clone git@github.com:usuario/repo.git
git clone https://github.com/usuario/repo.git
```

**Termos relacionados:** pull, fetch, remote

---

### commit
**Termo em inglês:** commit
**Tradução literal:** comprometer-se, confirmar
**Definição:** Snapshot (foto) do código em um determinado momento. Salva permanentemente as mudanças no histórico do repositório.

**Exemplo de uso:**
```bash
git commit -m "Add login feature"
git commit --amend  # Modificar último commit
```

**Termos relacionados:** add, push, message, hash

---

### conflict
**Termo em inglês:** conflict
**Tradução literal:** conflito
**Definição:** Situação onde Git não consegue mesclar automaticamente mudanças porque a mesma parte de um arquivo foi modificada de formas diferentes.

**Exemplo de uso:**
```
<<<<<<< HEAD
versão atual
=======
versão da outra branch
>>>>>>> feature-branch
```

**Termos relacionados:** merge, rebase, resolve

---

### Conventional Commits
**Termo em inglês:** Conventional Commits
**Tradução:** Commits Convencionais
**Definição:** Especificação para mensagens de commit que segue padrão estruturado: `tipo: descrição`.

**Exemplo de uso:**
```bash
git commit -m "feat: add user authentication"
git commit -m "fix: resolve memory leak"
git commit -m "docs: update API documentation"
```

**Tipos comuns:** feat, fix, docs, style, refactor, test, chore

**Termos relacionados:** commit, message

---

## D

### diff
**Termo em inglês:** diff
**Tradução literal:** diferença
**Definição:** Comando que mostra as diferenças entre arquivos, commits, branches ou working directory.

**Exemplo de uso:**
```bash
git diff  # Mudanças não staged
git diff --staged  # Mudanças staged
git diff main..feature  # Diferença entre branches
```

**Termos relacionados:** status, log, show

---

## E

### Ed25519
**Termo em inglês:** Ed25519
**Tradução:** Nome do algoritmo
**Definição:** Algoritmo de criptografia moderno para chaves SSH, recomendado pelo GitHub desde 2022. Mais rápido e seguro que RSA.

**Exemplo de uso:**
```bash
ssh-keygen -t ed25519 -C "seu@email.com"
```

**Termos relacionados:** SSH, key, authentication

---

## F

### fast-forward
**Termo em inglês:** fast-forward
**Tradução literal:** avanço rápido
**Definição:** Tipo de merge onde Git simplesmente move o ponteiro da branch para frente, sem criar commit de merge.

**Exemplo de uso:**
```bash
# Acontece automaticamente quando main não teve commits novos
git merge feature-branch
```

**Termos relacionados:** merge, branch

---

### fetch
**Termo em inglês:** fetch
**Tradução literal:** buscar
**Definição:** Comando que baixa commits do repositório remoto mas NÃO os integra automaticamente (diferente de pull).

**Exemplo de uso:**
```bash
git fetch origin
git fetch --all  # Todos os remotes
```

**Termos relacionados:** pull, push, remote

---

### fork
**Termo em inglês:** fork
**Tradução literal:** bifurcação, garfo
**Definição:** Cópia completa de um repositório para sua conta no GitHub, permitindo fazer mudanças sem afetar o projeto original.

**Exemplo de uso:**
- Clicar "Fork" no GitHub
- Clonar seu fork: `git clone git@github.com:SEU-USER/repo.git`

**Termos relacionados:** pull request, upstream, clone

---

## G

### .gitignore
**Termo em inglês:** .gitignore
**Tradução:** git ignorar
**Definição:** Arquivo que especifica quais arquivos/diretórios Git deve ignorar e não versionar.

**Exemplo de uso:**
```gitignore
node_modules/
.env
*.log
.DS_Store
```

**Termos relacionados:** add, status, untracked

---

### Git Flow
**Termo em inglês:** Git Flow
**Tradução:** Fluxo Git
**Definição:** Modelo de branching que define estrutura específica de branches (main, develop, feature, release, hotfix).

**Exemplo de uso:**
```
main (produção)
 └─ develop (integração)
     ├─ feature/* (features)
     ├─ release/* (preparação release)
     └─ hotfix/* (correções urgentes)
```

**Termos relacionados:** branch, workflow, GitHub Flow

---

### GitHub
**Termo em inglês:** GitHub
**Tradução:** GitHub (nome próprio)
**Definição:** Plataforma de hospedagem de código baseada em Git, adquirida pela Microsoft em 2018.

**Funcionalidades:** Repositórios remotos, Pull Requests, Issues, Actions, Pages

**Termos relacionados:** Git, remote, origin

---

### GitHub Actions
**Termo em inglês:** GitHub Actions
**Tradução:** Ações do GitHub
**Definição:** Plataforma de CI/CD do GitHub que automatiza workflows como testes, builds e deploys.

**Exemplo de uso:**
```yaml
# .github/workflows/test.yml
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm test
```

**Termos relacionados:** CI/CD, workflow, automation

---

### GitHub Copilot
**Termo em inglês:** GitHub Copilot
**Tradução:** Copiloto do GitHub
**Definição:** Assistente de IA que sugere código enquanto você programa.

**Termos relacionados:** AI, autocomplete

---

### GitHub Flow
**Termo em inglês:** GitHub Flow
**Tradução:** Fluxo GitHub
**Definição:** Workflow simplificado onde tudo sai de main via branches de feature, merged via Pull Requests.

**Passos:**
1. Branch de main
2. Commits
3. Pull Request
4. Review
5. Merge para main
6. Delete branch

**Termos relacionados:** branch, pull request, workflow

---

## H

### hash
**Termo em inglês:** hash
**Tradução:** hash, código hash
**Definição:** Identificador único (SHA-1 ou SHA-256) de 40 caracteres hexadecimais para cada commit.

**Exemplo:** `abc1234def5678901234567890abcdef12345678`

**Forma curta:** `abc1234` (primeiros 7 caracteres)

**Termos relacionados:** commit, SHA, log

---

### HEAD
**Termo em inglês:** HEAD
**Tradução:** cabeça, ponta
**Definição:** Ponteiro que indica o commit atual em que você está trabalhando.

**Exemplo de uso:**
```bash
git reset HEAD~1  # Voltar 1 commit
git diff HEAD  # Comparar com commit atual
```

**Termos relacionados:** branch, commit, checkout

---

### hook
**Termo em inglês:** hook
**Tradução literal:** gancho
**Definição:** Scripts que rodam automaticamente em eventos Git (pre-commit, post-commit, pre-push).

**Exemplo de uso:**
```bash
# .git/hooks/pre-commit
#!/bin/bash
npm run lint
```

**Termos relacionados:** automation, script

---

## I

### init
**Termo em inglês:** init
**Tradução:** inicializar
**Definição:** Comando que cria novo repositório Git local.

**Exemplo de uso:**
```bash
git init
git init --initial-branch=main
```

**Termos relacionados:** clone, repository

---

### issue
**Termo em inglês:** issue
**Tradução:** problema, questão
**Definição:** Sistema de rastreamento de bugs, features e tarefas no GitHub.

**Exemplo de uso:**
- Criar issue no GitHub
- Referenciar: `Closes #123` em commit/PR

**Termos relacionados:** pull request, label, milestone

---

## K

### key (SSH)
**Termo em inglês:** key
**Tradução:** chave
**Definição:** Par de chaves criptográficas (pública e privada) usadas para autenticação SSH.

**Tipos:**
- **Private key** (~/.ssh/id_ed25519): Nunca compartilhar
- **Public key** (~/.ssh/id_ed25519.pub): Adicionar no GitHub

**Exemplo de uso:**
```bash
ssh-keygen -t ed25519 -C "email@exemplo.com"
```

**Termos relacionados:** SSH, Ed25519, authentication

---

## L

### label
**Termo em inglês:** label
**Tradução:** etiqueta, rótulo
**Definição:** Tags categorizando Issues e Pull Requests (bug, enhancement, documentation).

**Exemplos:** `good first issue`, `bug`, `enhancement`, `help wanted`

**Termos relacionados:** issue, pull request

---

### LICENSE
**Termo em inglês:** LICENSE
**Tradução:** LICENÇA
**Definição:** Arquivo que define como outras pessoas podem usar, modificar e distribuir seu código.

**Licenças comuns:**
- **MIT**: Permissiva, popular para portfólio
- **Apache 2.0**: Corporativa, inclui proteção de patentes
- **GPL 3.0**: Copyleft, código derivado deve ser GPL também

**Termos relacionados:** open source, repository

---

### log
**Termo em inglês:** log
**Tradução:** registro, histórico
**Definição:** Comando que mostra histórico de commits.

**Exemplo de uso:**
```bash
git log
git log --oneline  # Compacto
git log --graph --all  # Com visualização de branches
git log -5  # Últimos 5 commits
```

**Termos relacionados:** commit, hash, diff

---

## M

### main
**Termo em inglês:** main
**Tradução:** principal
**Definição:** Nome padrão atual da branch principal (substituiu `master` em 2020).

**Exemplo de uso:**
```bash
git branch -M main  # Renomear para main
git push -u origin main
```

**Termos relacionados:** master, branch, origin

---

### master
**Termo em inglês:** master
**Tradução:** mestre, principal
**Definição:** Nome antigo da branch principal, substituído por `main` por questões de inclusividade.

**Nota:** Projetos antigos ainda podem usar `master`, mas novos projetos usam `main`.

**Termos relacionados:** main, branch

---

### merge
**Termo em inglês:** merge
**Tradução:** mesclar, juntar
**Definição:** Comando que integra mudanças de uma branch em outra.

**Exemplo de uso:**
```bash
git checkout main
git merge feature/login
```

**Tipos:**
- **Fast-forward**: Move ponteiro, sem commit de merge
- **Three-way merge**: Cria commit de merge

**Termos relacionados:** branch, conflict, rebase

---

### merge commit
**Termo em inglês:** merge commit
**Tradução:** commit de mesclagem
**Definição:** Commit especial criado ao mesclar duas branches, tem dois commits pais.

**Exemplo de mensagem:** `Merge branch 'feature/login' into main`

**Termos relacionados:** merge, commit

---

### milestone
**Termo em inglês:** milestone
**Tradução:** marco, etapa
**Definição:** Agrupamento de Issues e PRs relacionados a uma release ou objetivo específico no GitHub.

**Exemplo:** "v1.0 Release", "Sprint 5"

**Termos relacionados:** issue, pull request, project

---

## N

### nit (nitpick)
**Termo em inglês:** nit, nitpick
**Tradução:** detalhe mínimo, preciosismo
**Definição:** Comentário em code review sobre detalhe pequeno e não-crítico.

**Exemplo de uso:**
```
Nit: Pequeno typo no comentário: "recieve" → "receive"
```

**Termos relacionados:** code review, pull request

---

## O

### open source
**Termo em inglês:** open source
**Tradução:** código aberto
**Definição:** Software cujo código-fonte é publicamente acessível e pode ser modificado/distribuído conforme a licença.

**Exemplos:** Linux, React, VS Code

**Termos relacionados:** LICENSE, fork, contribution

---

### origin
**Termo em inglês:** origin
**Tradução:** origem
**Definição:** Nome padrão do repositório remoto principal (geralmente no GitHub).

**Exemplo de uso:**
```bash
git remote -v  # Ver URL do origin
git push origin main
git pull origin main
```

**Termos relacionados:** remote, push, pull

---

## P

### pull
**Termo em inglês:** pull
**Tradução:** puxar
**Definição:** Comando que baixa commits do repositório remoto e os integra na branch atual.

**Equivalente a:** `git fetch` + `git merge`

**Exemplo de uso:**
```bash
git pull
git pull --rebase  # Com rebase em vez de merge
git pull origin main
```

**Termos relacionados:** fetch, push, merge

---

### pull request (PR)
**Termo em inglês:** pull request
**Tradução:** requisição de pull, pedido de integração
**Definição:** Proposta de mudança no código que passa por revisão antes de ser integrada.

**Fluxo:**
1. Branch → Commits → Push
2. Criar PR no GitHub
3. Code review
4. Aprovação
5. Merge

**Termos relacionados:** code review, merge, branch

---

### push
**Termo em inglês:** push
**Tradução:** empurrar
**Definição:** Comando que envia commits locais para repositório remoto.

**Exemplo de uso:**
```bash
git push
git push -u origin main  # Primeira vez
git push --force  # Forçado (cuidado!)
```

**Termos relacionados:** pull, commit, origin

---

## R

### README
**Termo em inglês:** README
**Tradução:** LEIA-ME
**Definição:** Arquivo Markdown que documenta o projeto, explicando o que faz, como instalar e usar.

**Estrutura típica:**
- Título e descrição
- Tecnologias
- Instalação
- Uso
- Licença

**Termos relacionados:** documentation, Markdown

---

### rebase
**Termo em inglês:** rebase
**Tradução:** rebasear
**Definição:** Comando que reaplica commits de uma branch sobre outra, criando histórico linear.

**Exemplo de uso:**
```bash
git checkout feature
git rebase main  # Reaplica feature sobre main atualizado
```

**Diferença de merge:** Não cria commit de merge, altera histórico

**Termos relacionados:** merge, commit, interactive rebase

---

### reflog
**Termo em inglês:** reflog
**Tradução:** log de referências
**Definição:** Histórico completo de todas as mudanças de HEAD, útil para recuperar commits "perdidos".

**Exemplo de uso:**
```bash
git reflog
git reset --hard HEAD@{5}  # Voltar para estado anterior
```

**Termos relacionados:** reset, HEAD, log

---

### remote
**Termo em inglês:** remote
**Tradução:** remoto
**Definição:** Versão do repositório hospedada em servidor (GitHub, GitLab, etc).

**Exemplo de uso:**
```bash
git remote -v  # Ver remotes configurados
git remote add upstream git@github.com:original/repo.git
git remote remove origin
```

**Termos relacionados:** origin, push, pull

---

### repository (repo)
**Termo em inglês:** repository
**Tradução:** repositório
**Definição:** Projeto versionado com Git, contendo código, histórico de commits e configuração.

**Tipos:**
- **Local**: No seu computador
- **Remote**: No GitHub/servidor

**Termos relacionados:** clone, init, remote

---

### reset
**Termo em inglês:** reset
**Tradução:** resetar, reverter
**Definição:** Comando que desfaz commits movendo o ponteiro de branch para trás.

**Modos:**
- `--soft`: Mantém mudanças staged
- `--mixed`: Mantém mudanças unstaged (padrão)
- `--hard`: Descarta todas mudanças (⚠️ PERIGOSO)

**Exemplo de uso:**
```bash
git reset --soft HEAD~1
git reset --hard abc1234
```

**Termos relacionados:** revert, commit, HEAD

---

### restore
**Termo em inglês:** restore
**Tradução:** restaurar
**Definição:** Comando que descarta mudanças em arquivos não commitados.

**Exemplo de uso:**
```bash
git restore arquivo.js  # Descartar mudanças
git restore --staged arquivo.js  # Unstage
```

**Substituiu:** `git checkout -- arquivo`

**Termos relacionados:** checkout, reset

---

### revert
**Termo em inglês:** revert
**Tradução:** reverter
**Definição:** Comando que desfaz um commit criando um NOVO commit inverso (não altera histórico).

**Exemplo de uso:**
```bash
git revert HEAD  # Desfaz último commit
git revert abc1234  # Desfaz commit específico
```

**Diferença de reset:** Não reescreve histórico, seguro para commits já pushed

**Termos relacionados:** reset, commit

---

### review
**Termo em inglês:** review
**Tradução:** revisão
**Definição:** Processo de análise de código por colegas antes de integrar mudanças.

**Tipos de review:**
- **Approve**: Código aprovado
- **Request changes**: Precisa ajustes
- **Comment**: Apenas comentário

**Termos relacionados:** pull request, code review, comment

---

## S

### SHA (SHA-1, SHA-256)
**Termo em inglês:** SHA (Secure Hash Algorithm)
**Tradução:** Algoritmo de Hash Seguro
**Definição:** Algoritmo que gera o hash único de cada commit.

**Exemplo:** `abc1234def5678901234567890abcdef12345678`

**Termos relacionados:** hash, commit

---

### show
**Termo em inglês:** show
**Tradução:** mostrar
**Definição:** Comando que mostra detalhes de um commit específico.

**Exemplo de uso:**
```bash
git show  # Último commit
git show abc1234  # Commit específico
git show HEAD~2  # 2 commits atrás
```

**Termos relacionados:** log, diff, commit

---

### squash
**Termo em inglês:** squash
**Tradução:** esmagar, comprimir
**Definição:** Combinar múltiplos commits em um único commit.

**Exemplo de uso:**
```bash
git rebase -i HEAD~3  # Interativo, escolhe squash
# Ou no GitHub: "Squash and merge"
```

**Termos relacionados:** rebase, merge, commit

---

### SSH (Secure Shell)
**Termo em inglês:** SSH
**Tradução:** Shell Seguro
**Definição:** Protocolo de comunicação criptografada usado para autenticação com GitHub.

**Exemplo de uso:**
```bash
ssh-keygen -t ed25519 -C "email@exemplo.com"
ssh -T git@github.com  # Testar conexão
```

**Termos relacionados:** Ed25519, key, authentication

---

### stage / staging area
**Termo em inglês:** stage, staging area
**Tradução:** área de preparação
**Definição:** Área intermediária onde arquivos são marcados para o próximo commit.

**Fluxo:**
Working Directory → **Staging Area** → Repository

**Exemplo de uso:**
```bash
git add arquivo.js  # Move para staging
git status  # Ver o que está staged
```

**Termos relacionados:** add, commit, working directory

---

### stash
**Termo em inglês:** stash
**Tradução:** guardar, esconder
**Definição:** Comando que guarda mudanças temporariamente sem commitar.

**Exemplo de uso:**
```bash
git stash  # Guardar
git stash save "WIP: feature"  # Com mensagem
git stash list  # Ver stashes
git stash pop  # Recuperar último
git stash apply stash@{1}  # Aplicar específico
```

**Termos relacionados:** commit, working directory

---

### status
**Termo em inglês:** status
**Tradução:** estado, situação
**Definição:** Comando que mostra estado atual do repositório (arquivos modificados, staged, untracked).

**Exemplo de uso:**
```bash
git status
git status -s  # Formato curto
git status --ignored  # Incluir ignorados
```

**Termos relacionados:** add, commit, diff

---

### submodule
**Termo em inglês:** submodule
**Tradução:** submódulo
**Definição:** Repositório Git incluído dentro de outro repositório.

**Exemplo de uso:**
```bash
git submodule add git@github.com:user/lib.git libs/lib
git submodule update --init --recursive
```

**Termos relacionados:** repository, clone

---

### switch
**Termo em inglês:** switch
**Tradução:** trocar, mudar
**Definição:** Comando moderno (Git 2.23+) para mudar de branch, mais claro que `checkout`.

**Exemplo de uso:**
```bash
git switch main
git switch -c feature/nova  # Criar e mudar
```

**Substituiu:** `git checkout` (para mudar de branch)

**Termos relacionados:** checkout, branch

---

## T

### tag
**Termo em inglês:** tag
**Tradução:** etiqueta, marcação
**Definição:** Marcação de commit específico, geralmente usado para releases (v1.0, v2.0).

**Exemplo de uso:**
```bash
git tag v1.0.0
git tag -a v1.0.0 -m "Release version 1.0"
git push origin v1.0.0
```

**Termos relacionados:** commit, release

---

### track
**Termo em inglês:** track
**Tradução:** rastrear, acompanhar
**Definição:** Estado de arquivo que Git está monitorando mudanças.

**Estados:**
- **Tracked**: Git rastreia mudanças
- **Untracked**: Arquivo novo, Git ignora

**Termos relacionados:** add, status, .gitignore

---

## U

### unstage
**Termo em inglês:** unstage
**Tradução:** remover do stage
**Definição:** Remover arquivo da staging area, voltando para working directory.

**Exemplo de uso:**
```bash
git restore --staged arquivo.js
git reset HEAD arquivo.js  # Antigo
```

**Termos relacionados:** stage, restore, reset

---

### untracked
**Termo em inglês:** untracked
**Tradução:** não rastreado
**Definição:** Arquivo que Git ainda não está monitorando.

**Exemplo:** Arquivo recém-criado antes do primeiro `git add`

**Termos relacionados:** track, add, status

---

### upstream
**Termo em inglês:** upstream
**Tradução:** rio acima, fonte original
**Definição:** Repositório original de onde foi feito fork.

**Exemplo de uso:**
```bash
git remote add upstream git@github.com:original/repo.git
git pull upstream main
```

**Termos relacionados:** fork, remote, origin

---

## V

### version control
**Termo em inglês:** version control
**Tradução:** controle de versão
**Definição:** Sistema que rastreia mudanças em arquivos ao longo do tempo (Git é um sistema de controle de versão).

**Termos relacionados:** Git, repository, commit

---

## W

### working directory (working tree)
**Termo em inglês:** working directory
**Tradução:** diretório de trabalho
**Definição:** Diretório onde você edita arquivos, antes de adicionar ao staging area.

**Fluxo:**
**Working Directory** → Staging Area → Repository

**Termos relacionados:** staging area, add, status

---

### workflow
**Termo em inglês:** workflow
**Tradução:** fluxo de trabalho
**Definição:** Processo estruturado de desenvolvimento com Git (Git Flow, GitHub Flow, etc).

**Exemplos:**
- **GitHub Flow**: main → feature branch → PR → merge
- **Git Flow**: main + develop + feature/release/hotfix branches

**Termos relacionados:** branch, merge, pull request

---

## Comandos Git por Categoria

### Básicos
- `git init` - Criar repositório
- `git clone` - Clonar repositório
- `git status` - Ver estado
- `git add` - Adicionar ao stage
- `git commit` - Salvar versão
- `git log` - Ver histórico

### Sincronização
- `git push` - Enviar para remoto
- `git pull` - Receber de remoto
- `git fetch` - Baixar sem integrar
- `git remote` - Gerenciar remotos

### Branches
- `git branch` - Listar/criar branches
- `git checkout` - Mudar de branch
- `git switch` - Mudar de branch (novo)
- `git merge` - Mesclar branches
- `git rebase` - Rebasear commits

### Desfazer
- `git restore` - Descartar mudanças
- `git reset` - Desfazer commits
- `git revert` - Reverter commit (seguro)
- `git stash` - Guardar temporariamente
- `git clean` - Limpar não rastreados

### Inspeção
- `git diff` - Ver diferenças
- `git show` - Ver commit
- `git log` - Ver histórico
- `git reflog` - Histórico completo
- `git blame` - Ver quem mudou cada linha

### Avançados
- `git cherry-pick` - Aplicar commit específico
- `git bisect` - Encontrar bug
- `git submodule` - Repos aninhados
- `git tag` - Marcar releases

---

## Atalhos e Abreviações Comuns

- **PR** - Pull Request
- **CI/CD** - Continuous Integration/Continuous Deployment
- **LGTM** - Looks Good To Me (em code review)
- **WIP** - Work In Progress
- **HEAD** - Ponteiro do commit atual
- **SHA** - Hash do commit
- **SSH** - Secure Shell
- **HTTPS** - Protocolo alternativo ao SSH

---

## Emojis Comuns em Commits (Gitmoji)

- ✨ feat - Nova feature
- 🐛 fix - Correção de bug
- 📝 docs - Documentação
- 💄 style - Formatação
- ♻️ refactor - Refatoração
- ✅ test - Testes
- 🔧 chore - Manutenção
- 🚀 deploy - Deploy
- 🔥 remove - Remover código
- 💚 ci - CI/CD

---

**Versão:** 1.0
**Última atualização:** 2025-12-25
**Curso:** GitHub Essencial para Devs
