# Cheatsheet de Comandos Git/GitHub

Referência rápida de todos os comandos essenciais do curso GitHub Essencial para Devs.

---

## Configuração Inicial

```bash
# Configurar identidade
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"

# Configurar editor
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "nano"          # Nano

# Configurar branch padrão
git config --global init.defaultBranch main

# Configurar pull com rebase
git config --global pull.rebase true

# Ver todas configurações
git config --list

# Ver configuração específica
git config user.name
```

---

## SSH Setup

```bash
# Gerar chave SSH Ed25519
ssh-keygen -t ed25519 -C "seu@email.com"

# Iniciar SSH agent
eval "$(ssh-agent -s)"

# Adicionar chave ao agent
ssh-add ~/.ssh/id_ed25519

# Copiar chave pública (macOS)
pbcopy < ~/.ssh/id_ed25519.pub

# Copiar chave pública (Linux)
cat ~/.ssh/id_ed25519.pub

# Testar conexão com GitHub
ssh -T git@github.com
```

---

## Repositórios

```bash
# Inicializar repositório local
git init

# Clonar repositório remoto
git clone git@github.com:username/repo.git

# Clonar para diretório específico
git clone git@github.com:username/repo.git nome-pasta

# Ver remotes
git remote -v

# Adicionar remote
git remote add origin git@github.com:username/repo.git

# Mudar URL do remote
git remote set-url origin git@github.com:username/novo-repo.git

# Remover remote
git remote remove origin
```

---

## Status e Informações

```bash
# Ver status atual
git status

# Status resumido
git status -s

# Ver diferenças não staged
git diff

# Ver diferenças staged
git diff --staged

# Ver histórico de commits
git log

# Histórico compacto
git log --oneline

# Histórico com gráfico
git log --oneline --graph --all

# Últimos N commits
git log --oneline -5

# Ver commit específico
git show abc1234

# Ver quem mudou cada linha (blame)
git blame arquivo.js
```

---

## Ciclo Básico (Add, Commit, Push)

```bash
# Adicionar arquivo específico
git add arquivo.js

# Adicionar todos arquivos
git add .

# Adicionar interativamente
git add -p

# Commit com mensagem
git commit -m "Add feature X"

# Commit com mensagem detalhada (abre editor)
git commit

# Add + commit (só arquivos já rastreados)
git commit -am "Update files"

# Emendrar último commit
git commit --amend

# Emendrar sem mudar mensagem
git commit --amend --no-edit

# Push para remote
git push

# Push primeira vez (set upstream)
git push -u origin main

# Push branch específica
git push origin feature/nome

# Push forçado (CUIDADO!)
git push --force

# Push forçado com lease (mais seguro)
git push --force-with-lease

# Pull do remote
git pull

# Pull com rebase
git pull --rebase

# Fetch (baixar sem merge)
git fetch

# Fetch branch específica
git fetch origin main
```

---

## Branches

```bash
# Listar branches locais
git branch

# Listar todas (locais + remotas)
git branch -a

# Criar branch
git branch feature/nome

# Criar e mudar para branch
git checkout -b feature/nome
# OU (Git 2.23+)
git switch -c feature/nome

# Mudar de branch
git checkout main
# OU
git switch main

# Renomear branch atual
git branch -m novo-nome

# Deletar branch local
git branch -d feature/nome

# Forçar delete (mesmo sem merge)
git branch -D feature/nome

# Deletar branch remota
git push origin --delete feature/nome

# Ver branches merged
git branch --merged

# Ver branches não merged
git branch --no-merged
```

---

## Merge e Rebase

```bash
# Merge branch em branch atual
git merge feature/nome

# Merge sem fast-forward (sempre cria commit de merge)
git merge --no-ff feature/nome

# Abortar merge
git merge --abort

# Rebase branch atual sobre outra
git rebase main

# Rebase interativo (últimos 3 commits)
git rebase -i HEAD~3

# Continuar rebase após resolver conflito
git add arquivo.js
git rebase --continue

# Pular commit durante rebase
git rebase --skip

# Abortar rebase
git rebase --abort

# Cherry-pick commit específico
git cherry-pick abc1234
```

---

## Desfazendo Mudanças

```bash
# Descartar mudanças em arquivo (restore)
git restore arquivo.js

# Descartar todas mudanças
git restore .

# Unstage arquivo (tirar de staging)
git restore --staged arquivo.js

# Desfazer último commit (mantém mudanças staged)
git reset --soft HEAD~1

# Desfazer último commit (mudanças unstaged)
git reset HEAD~1
# OU
git reset --mixed HEAD~1

# Desfazer último commit (DESCARTA mudanças)
git reset --hard HEAD~1

# Voltar para commit específico
git reset --hard abc1234

# Reverter commit (cria novo commit inverso)
git revert HEAD

# Reverter commit específico
git revert abc1234

# Reverter sem commit automático
git revert --no-commit HEAD

# Ver histórico de movimentos (reflog)
git reflog

# Voltar para estado anterior via reflog
git reset --hard HEAD@{2}
```

---

## Stash (Guardar Temporariamente)

```bash
# Guardar mudanças
git stash

# Stash com mensagem
git stash save "WIP: working on feature"

# Stash incluindo arquivos não rastreados
git stash -u

# Listar stashes
git stash list

# Ver conteúdo do stash
git stash show
git stash show -p  # Diff completo

# Aplicar último stash (e remove)
git stash pop

# Aplicar stash específico
git stash pop stash@{1}

# Aplicar stash (sem remover)
git stash apply

# Deletar último stash
git stash drop

# Deletar stash específico
git stash drop stash@{1}

# Deletar todos stashes
git stash clear
```

---

## .gitignore

```bash
# Parar de rastrear arquivo (mantém no disco)
git rm --cached arquivo.env

# Parar de rastrear diretório
git rm -r --cached node_modules/

# Ver arquivos ignorados
git status --ignored

# Verificar se arquivo é ignorado
git check-ignore -v arquivo.txt

# Forçar adicionar arquivo ignorado
git add -f arquivo.log
```

---

## Tags

```bash
# Criar tag anotada
git tag -a v1.0.0 -m "Version 1.0.0"

# Criar tag leve
git tag v1.0.0

# Listar tags
git tag

# Ver tag específica
git show v1.0.0

# Push tag
git push origin v1.0.0

# Push todas tags
git push --tags

# Deletar tag local
git tag -d v1.0.0

# Deletar tag remota
git push origin --delete v1.0.0

# Checkout de tag
git checkout v1.0.0
```

---

## Limpeza

```bash
# Ver arquivos não rastreados que seriam deletados
git clean -n

# Deletar arquivos não rastreados
git clean -f

# Deletar arquivos e diretórios
git clean -fd

# Deletar incluindo arquivos ignorados
git clean -fdx
```

---

## Busca e Inspeção

```bash
# Buscar em código
git grep "texto"

# Buscar em commits
git log --all --grep="mensagem"

# Buscar quem introduziu/removeu texto
git log -S "função"

# Ver diferença entre branches
git diff main..feature/nome

# Ver apenas nomes de arquivos diferentes
git diff --name-only main..feature

# Ver commits em branch que não estão em main
git log main..feature/nome

# Encontrar commit que introduziu bug (bisect)
git bisect start
git bisect bad
git bisect good abc1234
# Teste cada commit, marque good/bad
git bisect reset  # Finalizar
```

---

## GitHub CLI (gh)

```bash
# Autenticar
gh auth login

# Criar PR
gh pr create
gh pr create --title "Title" --body "Description"

# Listar PRs
gh pr list

# Ver PR específico
gh pr view 123

# Merge PR
gh pr merge 123 --squash

# Criar issue
gh issue create

# Listar issues
gh issue list

# Ver repo no navegador
gh repo view --web

# Clonar repo
gh repo clone username/repo
```

---

## Atalhos e Aliases

```bash
# Criar alias
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual 'log --oneline --graph --all'

# Usar alias
git st      # = git status
git co main # = git checkout main
git visual  # = git log --oneline --graph --all
```

---

## Troubleshooting Comum

```bash
# Commit na branch errada - mover para branch correta
git log --oneline  # Copie hash
git reset --hard HEAD~1  # Remove da branch errada
git checkout branch-correta
git cherry-pick abc1234  # Aplica na certa

# Desfazer git add (unstage tudo)
git reset

# Arquivo commitado por engano
git rm --cached arquivo
echo "arquivo" >> .gitignore
git commit -m "Remove arquivo and update .gitignore"

# Merge deu conflito, quer desistir
git merge --abort

# Rebase deu conflito, quer desistir
git rebase --abort

# Voltar repo ao estado exato do remote
git fetch origin
git reset --hard origin/main

# Pull rejeitado (remote tem commits novos)
git pull --rebase
git push

# Mudar último commit para branch diferente
git reset --soft HEAD~1  # Desfaz commit
git stash                # Guarda mudanças
git checkout outra-branch
git stash pop
git commit
```

---

## Workflow Típico

```bash
# Início do dia
git checkout main
git pull

# Nova feature
git checkout -b feature/nome
# ... desenvolver ...
git add .
git commit -m "feat: add feature"
git push -u origin feature/nome

# Criar PR no GitHub
# ... review ...
# Após aprovação, merge via GitHub

# Cleanup após merge
git checkout main
git pull
git branch -d feature/nome

# Sincronizar branch com main atualizado
git checkout feature/nome
git rebase main
git push --force-with-lease
```

---

## Convenções de Commit

```
<type>: <subject>

<body>

<footer>
```

**Types:**
- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Apenas documentação
- `style:` Formatação (não muda lógica)
- `refactor:` Refatoração
- `test:` Adicionar/corrigir testes
- `chore:` Manutenção (deps, build)

**Exemplo:**
```
feat: add user authentication

Implements JWT-based authentication for API.
Users can now login and access protected routes.

Closes #42
```

---

## Referências Rápidas

**HEAD:** Commit atual
**HEAD~1:** Commit anterior
**HEAD~2:** Dois commits atrás
**origin:** Remote padrão
**main/master:** Branch principal
**-u:** Set upstream (tracking)
**-f:** Force (forçar)
**-d:** Delete
**-a:** All
**-m:** Message

---

## Links Úteis

- **Documentação Git:** https://git-scm.com/doc
- **GitHub Docs:** https://docs.github.com
- **Git Cheatsheet Oficial:** https://training.github.com/downloads/github-git-cheat-sheet/
- **Learn Git Branching:** https://learngitbranching.js.org
- **Conventional Commits:** https://www.conventionalcommits.org
- **gitignore Templates:** https://github.com/github/gitignore

---

**Imprima este cheatsheet e mantenha perto do seu computador!**
