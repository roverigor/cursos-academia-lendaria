# Checklist: Setup Completo Claude Code

**Objetivo:** Validar que seu ambiente está 100% pronto para automações

**Tempo estimado:** 10-15 minutos

---

## ✅ CHECKLIST DE VALIDAÇÃO

### 1️⃣ Claude Pro Ativo

- [ ] Tenho conta Claude Pro ativa (não é o plano gratuito)
- [ ] Consigo acessar https://claude.ai
- [ ] Posso criar novos chats sem limite
- [ ] Consigo fazer upload de arquivos

**Validação:**
```
Acesse: https://claude.ai
Clique em: Settings → Subscription
Status deve ser: "Pro" ou "Team"
```

**❌ Se não tiver:**
- Fazer upgrade em: https://claude.ai/upgrade
- Custo: ~USD 20/mês

---

### 2️⃣ Python Instalado

- [ ] Python 3.8+ instalado
- [ ] `python3 --version` funciona no terminal
- [ ] `pip3 --version` funciona no terminal

**Validação:**
```bash
python3 --version
# Output esperado: Python 3.8.x ou superior

pip3 --version
# Output esperado: pip 21.x ou superior
```

**❌ Se não tiver (Mac):**
```bash
brew install python3
```

**❌ Se não tiver (Windows):**
1. Baixar: https://python.org/downloads
2. Executar instalador
3. ☑️ Marcar "Add Python to PATH"

**❌ Se não tiver (Linux):**
```bash
sudo apt update
sudo apt install python3 python3-pip
```

---

### 3️⃣ Terminal Funcional

- [ ] Consigo abrir terminal
- [ ] Consigo navegar entre pastas (`cd`)
- [ ] Consigo executar comandos básicos

**Validação:**
```bash
# Testar comandos básicos
cd ~
pwd
ls
```

**Terminal recomendado:**
- **Mac:** Terminal nativo ou iTerm2
- **Windows:** PowerShell ou Windows Terminal
- **Linux:** Terminal nativo

---

### 4️⃣ Editor de Código

- [ ] VS Code instalado (recomendado)
- [ ] Consigo abrir arquivos `.py`
- [ ] Syntax highlighting funcionando

**Validação:**
```bash
# Abrir VS Code
code --version
```

**❌ Se não tiver:**
- Baixar: https://code.visualstudio.com
- Instalar extensão Python (Microsoft)

**Alternativas:**
- PyCharm Community (mais pesado)
- Sublime Text
- Notepad++ (Windows)
- Vim/Nano (Linux)

---

### 5️⃣ Git (Opcional mas Recomendado)

- [ ] Git instalado
- [ ] `git --version` funciona

**Validação:**
```bash
git --version
# Output esperado: git version 2.x
```

**Por que precisar:**
- Controle de versão
- Backup de código
- Colaboração
- Deploy (Heroku, Render, etc)

**❌ Se não tiver:**
```bash
# Mac
brew install git

# Windows
# Baixar: https://git-scm.com/download/win

# Linux
sudo apt install git
```

---

### 6️⃣ Bibliotecas Python Essenciais

- [ ] `requests` instalado
- [ ] `beautifulsoup4` instalado
- [ ] `pandas` instalado (opcional)

**Validação:**
```bash
pip3 list | grep requests
pip3 list | grep beautifulsoup4
```

**Instalar tudo de uma vez:**
```bash
pip3 install requests beautifulsoup4 pandas flask selenium tqdm python-dotenv
```

---

### 7️⃣ Estrutura de Pastas

- [ ] Criei pasta para projetos
- [ ] Consigo navegar até ela no terminal

**Criar estrutura:**
```bash
# Mac/Linux
mkdir -p ~/projetos/automacoes
cd ~/projetos/automacoes

# Windows
mkdir C:\projetos\automacoes
cd C:\projetos\automacoes
```

**Estrutura recomendada:**
```
~/projetos/
├── automacoes/
│   ├── scraping/
│   ├── apis/
│   ├── dashboards/
│   └── scripts/
└── templates/
```

---

### 8️⃣ Variáveis de Ambiente (.env)

- [ ] Entendo conceito de `.env`
- [ ] Sei criar arquivo `.env`
- [ ] Instalei `python-dotenv`

**Criar .env de teste:**
```bash
# Criar arquivo
echo "API_KEY=teste123" > .env

# Validar que arquivo foi criado
cat .env
```

**Testar no Python:**
```python
from dotenv import load_dotenv
import os

load_dotenv()
print(os.getenv('API_KEY'))  # Deve printar: teste123
```

---

### 9️⃣ Teste End-to-End

- [ ] Consigo criar script Python
- [ ] Consigo executar script
- [ ] Consigo ver output

**Teste completo:**
```python
# Criar arquivo: teste_setup.py
import sys
import requests
from bs4 import BeautifulSoup

def teste_setup():
    print("=" * 60)
    print("🧪 TESTE DE SETUP")
    print("=" * 60)
    
    # 1. Python version
    print(f"\n✅ Python: {sys.version.split()[0]}")
    
    # 2. Requests
    print("✅ Requests: OK")
    
    # 3. BeautifulSoup
    print("✅ BeautifulSoup: OK")
    
    # 4. Request simples
    try:
        response = requests.get("https://httpbin.org/get", timeout=5)
        print(f"✅ Request HTTP: {response.status_code}")
    except Exception as e:
        print(f"❌ Request falhou: {e}")
    
    print("\n" + "=" * 60)
    print("🎉 SETUP COMPLETO!")
    print("=" * 60)

if __name__ == "__main__":
    teste_setup()
```

**Executar:**
```bash
python3 teste_setup.py
```

**Output esperado:**
```
============================================================
🧪 TESTE DE SETUP
============================================================

✅ Python: 3.11.0
✅ Requests: OK
✅ BeautifulSoup: OK
✅ Request HTTP: 200

============================================================
🎉 SETUP COMPLETO!
============================================================
```

---

## 🎯 RESUMO DE VALIDAÇÃO

**Checklist final:**

- [ ] 1️⃣ Claude Pro ativo
- [ ] 2️⃣ Python 3.8+ instalado
- [ ] 3️⃣ Terminal funcional
- [ ] 4️⃣ Editor de código (VS Code)
- [ ] 5️⃣ Git instalado (opcional)
- [ ] 6️⃣ Bibliotecas Python instaladas
- [ ] 7️⃣ Estrutura de pastas criada
- [ ] 8️⃣ `.env` configurado
- [ ] 9️⃣ Teste end-to-end passou

**Se todos marcados:** ✅ Pronto para começar!

**Se algum falhou:** Revise a seção específica acima

---

## 🐛 TROUBLESHOOTING COMUM

### "python3: command not found"

**Solução:**
- Windows: Usar `python` ao invés de `python3`
- Mac/Linux: Instalar Python (ver seção 2️⃣)

### "pip3: command not found"

**Solução:**
```bash
# Mac/Linux
python3 -m ensurepip --upgrade

# Windows
python -m ensurepip --upgrade
```

### "Permission denied" ao instalar bibliotecas

**Solução:**
```bash
# Mac/Linux (adicionar --user)
pip3 install requests --user

# Ou usar sudo (não recomendado)
sudo pip3 install requests
```

### VS Code não reconhece Python

**Solução:**
1. Instalar extensão "Python" (Microsoft)
2. Ctrl/Cmd + Shift + P → "Python: Select Interpreter"
3. Escolher Python 3.8+

---

## 📞 PRECISA DE AJUDA?

**Se tudo falhou:**

1. Compartilhar screenshot do erro na comunidade
2. Incluir:
   - Sistema operacional (Mac/Windows/Linux)
   - Versão Python (`python3 --version`)
   - Comando que falhou
   - Mensagem de erro completa

**Recursos:**
- Comunidade Discord/Telegram do curso
- Stack Overflow (pesquisar erro específico)
- Documentação oficial Python: https://docs.python.org

---

**✅ Setup validado! Pronto para Aula 1.3 - Primeira Automação**

