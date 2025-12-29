# Mapa Mental: Módulo 1 - Setup Moderno

## Conceito Central

**SETUP MODERNO PARA GIT E GITHUB**
Fundação profissional para trabalhar com controle de versão e colaboração em código

## Estrutura do Mapa

```
🛠️ MÓDULO 1: SETUP MODERNO (25 min)
│
├── 💡 LIÇÃO 1.1: GIT VS GITHUB (5 min)
│   │
│   ├── 🔧 GIT - Sistema Local
│   │   ├── O que é
│   │   │   ├── Software de controle de versão
│   │   │   ├── Roda no seu computador
│   │   │   ├── 100% offline
│   │   │   └── Criado por Linus Torvalds (2005)
│   │   ├── Analogia
│   │   │   └── Super "Ctrl+Z" infinito
│   │   ├── Funcionalidades
│   │   │   ├── Guarda todas as versões
│   │   │   ├── Permite voltar no tempo
│   │   │   ├── Rastreia mudanças
│   │   │   └── Histórico completo local
│   │   └── Comandos básicos
│   │       ├── git init (criar repositório)
│   │       ├── git add (marcar mudanças)
│   │       └── git commit (salvar versão)
│   │
│   ├── ☁️ GITHUB - Plataforma Nuvem
│   │   ├── O que é
│   │   │   ├── Site (github.com)
│   │   │   ├── Hospeda repos Git na nuvem
│   │   │   ├── Ferramentas de colaboração
│   │   │   └── Comprado pela Microsoft (2018, $7.5B)
│   │   ├── Analogia
│   │   │   └── Google Drive do código com superpoderes
│   │   ├── Funcionalidades
│   │   │   ├── Backup na nuvem
│   │   │   ├── Colaboração em equipe
│   │   │   ├── Pull Requests
│   │   │   ├── Issues
│   │   │   ├── GitHub Actions (CI/CD)
│   │   │   └── Portfólio profissional
│   │   └── Comando de integração
│   │       └── git push origin main (envia para nuvem)
│   │
│   ├── 🔗 RELAÇÃO ENTRE ELES
│   │   ├── Fluxo de trabalho
│   │   │   ├── Git (local) → trabalho offline
│   │   │   ├── push → enviar para GitHub
│   │   │   ├── pull → receber do GitHub
│   │   │   └── GitHub (nuvem) → colaboração e backup
│   │   └── Diagrama
│   │       ├── Seu Computador (Git local)
│   │       │   ├── commits
│   │       │   ├── branches
│   │       │   └── histórico
│   │       ├── ⬍ push/pull ⬍
│   │       └── GitHub (Nuvem)
│   │           ├── backup
│   │           ├── colaboração
│   │           └── portfólio
│   │
│   ├── 🏢 POR QUE EMPRESAS EXIGEM
│   │   ├── Colaboração distribuída
│   │   │   ├── Times globais
│   │   │   ├── Code review antes de aceitar
│   │   │   └── Histórico completo (quem fez o quê)
│   │   ├── Portfólio vivo
│   │   │   ├── Recrutadores checam GitHub
│   │   │   ├── Contribuições open source = experiência
│   │   │   └── Código público demonstra habilidades
│   │   ├── Workflow padronizado
│   │   │   ├── Git Flow é padrão industrial
│   │   │   ├── Pull Requests universais
│   │   │   └── CI/CD integrado (Actions)
│   │   └── Dados do mercado
│   │       ├── 100+ milhões de devs no GitHub (2024)
│   │       ├── 90% empresas tech usam Git
│   │       └── 70% vagas junior pedem GitHub
│   │
│   └── 🔄 ALTERNATIVAS AO GITHUB
│       ├── GitLab (CI/CD forte, popular em empresas)
│       ├── Bitbucket (integra com Jira)
│       ├── Gitea (self-hosted, open source)
│       └── ✅ Aprenda GitHub primeiro
│           ├── Maior comunidade
│           ├── Melhor para portfólio
│           └── Mais vagas exigem
│
├── ⚙️ LIÇÃO 1.2: INSTALAÇÃO + CONFIG (10 min)
│   │
│   ├── 📥 INSTALAÇÃO POR SO
│   │   ├── Windows
│   │   │   ├── Git for Windows (git-scm.com)
│   │   │   ├── 64-bit installer
│   │   │   ├── Opções importantes
│   │   │   │   ├── Editor: VS Code ou Nano
│   │   │   │   ├── Branch inicial: main
│   │   │   │   └── Terminal: Git Bash
│   │   │   └── Verificar: git --version
│   │   ├── macOS
│   │   │   ├── Opção 1: brew install git (Homebrew)
│   │   │   ├── Opção 2: xcode-select --install
│   │   │   └── Verificar: git --version (2.39+)
│   │   └── Linux
│   │       ├── Ubuntu/Debian: sudo apt install git
│   │       ├── Fedora: sudo dnf install git
│   │       └── Verificar: git --version
│   │
│   ├── 🔧 CONFIGURAÇÃO ESSENCIAL
│   │   ├── 1. Nome e Email
│   │   │   ├── git config --global user.name "Maria Silva"
│   │   │   ├── git config --global user.email "maria@email.com"
│   │   │   ├── ⚠️ Use nome real (empresas valorizam)
│   │   │   ├── ⚠️ Mesmo email do GitHub
│   │   │   └── Email privado: username@users.noreply.github.com
│   │   ├── 2. Editor Padrão
│   │   │   ├── VS Code: git config --global core.editor "code --wait"
│   │   │   ├── Nano: git config --global core.editor "nano"
│   │   │   └── Vim: git config --global core.editor "vim"
│   │   ├── 3. Branch Padrão
│   │   │   └── git config --global init.defaultBranch main
│   │   └── 4. Cores no Terminal
│   │       └── git config --global color.ui auto
│   │
│   ├── ✅ VERIFICAÇÃO
│   │   ├── Listar todas configs
│   │   │   └── git config --list
│   │   ├── Ver config específica
│   │   │   └── git config user.name
│   │   └── Saída esperada
│   │       ├── user.name=Maria Silva
│   │       ├── user.email=maria@email.com
│   │       ├── core.editor=code --wait
│   │       ├── init.defaultbranch=main
│   │       └── color.ui=auto
│   │
│   ├── 📁 ONDE FICA SALVO
│   │   ├── Global: ~/.gitconfig (todos os repos)
│   │   ├── Local: .git/config (repo específico)
│   │   └── Ver arquivo: cat ~/.gitconfig
│   │
│   └── ➕ CONFIGS EXTRAS (Opcional)
│       ├── git config --global pull.rebase true
│       │   └── Pull com rebase (evita merge commits)
│       └── Credential helper
│           ├── Windows: git config --global credential.helper wincred
│           ├── macOS: git config --global credential.helper osxkeychain
│           └── Linux: git config --global credential.helper cache
│
└── 🔐 LIÇÃO 1.3: SSH COM ED25519 (10 min)
    │
    ├── 🔑 O QUE É SSH
    │   ├── Definição
    │   │   ├── Secure Shell
    │   │   ├── Protocolo de comunicação criptografado
    │   │   └── Par de chaves (pública + privada)
    │   ├── Analogia
    │   │   ├── Chave privada = sua chave (NUNCA compartilhe)
    │   │   └── Chave pública = cadeado no GitHub
    │   └── Por que SSH
    │       ├── GitHub removeu senha em 2021
    │       └── Método mais seguro e prático
    │
    ├── 🚀 POR QUE ED25519
    │   ├── Comparação de algoritmos
    │   │   ├── RSA: 2048-4096 bits, lento, antigo
    │   │   └── Ed25519: 256 bits, rápido, recomendado 2024
    │   ├── Vantagens
    │   │   ├── Menor e mais rápido
    │   │   ├── Segurança excelente
    │   │   └── Recomendado pelo GitHub (desde 2022)
    │   └── Status: Padrão moderno
    │
    ├── 📋 PASSO A PASSO
    │   ├── 1. Verificar chave existente
    │   │   ├── ls -la ~/.ssh/id_ed25519.pub
    │   │   ├── Se existir → Pular para Passo 3
    │   │   └── Se não existir → Continuar
    │   ├── 2. Gerar nova chave
    │   │   ├── ssh-keygen -t ed25519 -C "seu@email.com"
    │   │   ├── Perguntas
    │   │   │   ├── "File to save" → ENTER (padrão)
    │   │   │   └── "Passphrase" → ENTER (vazio) ou senha forte
    │   │   └── Saída
    │   │       ├── ~/.ssh/id_ed25519 (privada)
    │   │       └── ~/.ssh/id_ed25519.pub (pública)
    │   ├── 3. Adicionar ao SSH Agent
    │   │   ├── eval "$(ssh-agent -s)" (iniciar agent)
    │   │   └── ssh-add ~/.ssh/id_ed25519 (adicionar chave)
    │   ├── 4. Copiar chave pública
    │   │   ├── macOS: pbcopy < ~/.ssh/id_ed25519.pub
    │   │   ├── Linux: cat ~/.ssh/id_ed25519.pub (copiar manualmente)
    │   │   ├── Windows: cat ~/.ssh/id_ed25519.pub | clip
    │   │   └── Formato: ssh-ed25519 AAA... email@exemplo.com
    │   ├── 5. Adicionar no GitHub
    │   │   ├── github.com/settings/keys
    │   │   ├── "New SSH key"
    │   │   ├── Title: "Notebook Pessoal" (descritivo)
    │   │   ├── Key type: Authentication Key
    │   │   └── Cole chave pública
    │   └── 6. Testar conexão
    │       ├── ssh -T git@github.com
    │       ├── Primeira vez: digite "yes"
    │       └── Sucesso: "Hi username! You've successfully authenticated..."
    │
    ├── 🔧 CONFIG AUTOMÁTICA (Opcional)
    │   ├── macOS: Criar ~/.ssh/config
    │   │   ├── Host github.com
    │   │   ├──   AddKeysToAgent yes
    │   │   ├──   UseKeychain yes
    │   │   └──   IdentityFile ~/.ssh/id_ed25519
    │   └── Linux: Adicionar ao ~/.bashrc
    │       └── Auto-start ssh-agent
    │
    ├── 🆚 SSH VS HTTPS
    │   ├── SSH (Recomendado)
    │   │   ├── git@github.com:user/repo.git
    │   │   ├── Não pede senha
    │   │   ├── Mais seguro
    │   │   └── Use quando: computador é seu
    │   └── HTTPS
    │       ├── https://github.com/user/repo.git
    │       ├── Requer token
    │       └── Use quando: computador compartilhado, CI/CD
    │
    └── 🔧 TROUBLESHOOTING
        ├── "Permission denied (publickey)"
        │   ├── Chave não adicionada no GitHub
        │   └── Ou usando HTTPS em vez de SSH
        └── "Could not open connection"
            ├── ssh-agent não está rodando
            └── Solução: eval "$(ssh-agent -s)" + ssh-add
```

## Conceitos Fundamentais

### Git vs GitHub
- **Git**: Ferramenta (software local)
- **GitHub**: Serviço (plataforma online)
- **Relação**: Git trabalha localmente, GitHub armazena e facilita colaboração

### Configuração Profissional
- **Nome/Email**: Identidade em cada commit
- **Branch padrão**: `main` (padrão atual, não `master`)
- **Editor**: Para mensagens de commit longas

### SSH Moderno
- **Ed25519**: Algoritmo atual (substituiu RSA)
- **Chave privada**: Nunca compartilhar, fica só no seu PC
- **Chave pública**: Pode compartilhar, adiciona no GitHub

## Comandos Essenciais do Módulo

```bash
# Verificar instalação
git --version

# Configuração inicial
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
git config --global init.defaultBranch main

# SSH
ssh-keygen -t ed25519 -C "seu@email.com"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com
```

## Checklist de Setup Completo

- [ ] Git instalado (versão 2.30+)
- [ ] Nome configurado (nome real)
- [ ] Email configurado (mesmo do GitHub)
- [ ] Editor padrão escolhido
- [ ] Branch padrão = main
- [ ] Chave SSH Ed25519 gerada
- [ ] Chave pública no GitHub
- [ ] Teste SSH funcionou
- [ ] Conta no GitHub criada

## Conexões com Próximos Módulos

- **Módulo 2**: Usará Git local (configurado aqui)
- **Módulo 2.3**: Usará SSH para push/pull
- **Módulo 3**: GitHub será central para colaboração
- **Módulo 4**: Perfil GitHub (conta criada aqui)

## Diferenciais 2025

- SSH Ed25519 (não RSA antigo)
- Branch `main` (não `master`)
- Email privado do GitHub (opcional)
- Configuração minimalista mas completa
