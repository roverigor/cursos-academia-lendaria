# Troubleshooting Guide: 20+ Erros Comuns

**Guia rápido de soluções** para os erros mais frequentes do curso.

---

## 🐍 ERROS DE PYTHON

### 1. `ModuleNotFoundError: No module named 'X'`

**Causa:** Biblioteca não instalada

**Solução:**
```bash
pip3 install X

# ou se o nome do pacote é diferente:
pip3 install beautifulsoup4  # para bs4
pip3 install pillow  # para PIL
```

**Caso especial (Mac com múltiplos Pythons):**
```bash
python3 -m pip install X
```

---

### 2. `SyntaxError: invalid syntax`

**Causa:** Erro de digitação no código

**Verificar:**
- Faltou `:` no final de `if/for/def/class`
- Parênteses/colchetes não fechados
- Aspas não fechadas
- Indentação misturada (tabs vs spaces)

**Exemplo:**
```python
# ❌ Errado
if x > 5
    print("maior")

# ✅ Certo
if x > 5:  # ← faltava :
    print("maior")
```

---

### 3. `IndentationError: expected an indented block`

**Causa:** Bloco de código sem indentação

**Solução:**
```python
# ❌ Errado
def funcao():
print("oi")  # ← sem indentação

# ✅ Certo
def funcao():
    print("oi")  # ← 4 espaços
```

**Dica:** Configurar editor para usar 4 espaços (não Tab)

---

### 4. `NameError: name 'X' is not defined`

**Causa:** Usando variável antes de definir

**Solução:**
```python
# ❌ Errado
print(resultado)  # resultado não existe ainda
resultado = 42

# ✅ Certo
resultado = 42
print(resultado)
```

**Também pode ser:** Typo no nome
```python
resultados = 42
print(resultado)  # ← faltou 's'
```

---

### 5. `AttributeError: 'NoneType' object has no attribute 'X'`

**Causa:** Variável é `None`, não o objeto esperado

**Onde acontece:**
```python
# API retornou None mas você esperava dict
resposta = fazer_request()  # Retorna None se falhar
dados = resposta.json()  # ❌ AttributeError
```

**Solução:**
```python
resposta = fazer_request()

if resposta is not None:
    dados = resposta.json()
else:
    logger.error("Request falhou, resposta é None")
```

---

### 6. `KeyError: 'chave'`

**Causa:** Chave não existe no dicionário

**Solução:**
```python
# ❌ Errado
nome = dados['nome']  # Se 'nome' não existe → KeyError

# ✅ Certo (opção 1)
nome = dados.get('nome', 'Desconhecido')  # Default se não existir

# ✅ Certo (opção 2)
if 'nome' in dados:
    nome = dados['nome']
else:
    nome = 'Desconhecido'
```

---

### 7. `IndexError: list index out of range`

**Causa:** Acessando índice que não existe na lista

**Solução:**
```python
lista = [1, 2, 3]

# ❌ Errado
print(lista[5])  # Lista só tem 3 items (índices 0, 1, 2)

# ✅ Certo
if len(lista) > 5:
    print(lista[5])
else:
    print("Lista não tem índice 5")
```

---

### 8. `TypeError: unsupported operand type(s) for +: 'int' and 'str'`

**Causa:** Operação com tipos incompatíveis

**Solução:**
```python
# ❌ Errado
numero = 5
texto = "10"
soma = numero + texto  # Não pode somar int + str

# ✅ Certo
soma = numero + int(texto)  # Converte str para int
# ou
concatenacao = str(numero) + texto  # Ambos str
```

---

## 🌐 ERROS DE REQUESTS/HTTP

### 9. `requests.exceptions.ConnectionError`

**Causa:** Sem internet ou servidor offline

**Solução:**
```python
import requests

try:
    resposta = requests.get(url, timeout=10)
except requests.exceptions.ConnectionError:
    print("❌ Sem conexão. Verifique internet.")
except requests.exceptions.Timeout:
    print("❌ Timeout. Servidor demorou muito.")
```

---

### 10. `requests.exceptions.Timeout`

**Causa:** Request demorou mais que timeout definido

**Solução:**
```python
# Aumentar timeout
resposta = requests.get(url, timeout=30)  # 30 segundos

# Ou implementar retry
for tentativa in range(3):
    try:
        resposta = requests.get(url, timeout=10)
        break
    except requests.exceptions.Timeout:
        if tentativa < 2:
            time.sleep(5)
            continue
        else:
            raise
```

---

### 11. `HTTP Error 401: Unauthorized`

**Causa:** API key inválida ou expirada

**Solução:**
1. Verificar se `.env` tem `API_KEY=...`
2. Verificar se key não expirou no dashboard do provider
3. Verificar formato do header:
```python
headers = {'Authorization': f'Bearer {API_KEY}'}  # Não esquecer 'Bearer '
```

---

### 12. `HTTP Error 403: Forbidden`

**Causa:** Sem permissão para acessar recurso

**Possibilidades:**
- API key sem permissões necessárias
- IP bloqueado
- Plano free não tem acesso a esse endpoint

**Solução:** Verificar documentação da API e permissões da key

---

### 13. `HTTP Error 404: Not Found`

**Causa:** URL errada ou recurso não existe

**Verificar:**
```python
url = f"https://api.exemplo.com/users/{user_id}"
# user_id existe? URL está correta?
```

---

### 14. `HTTP Error 429: Too Many Requests`

**Causa:** Rate limit excedido

**Solução:**
```python
# Adicionar delay entre requests
import time

for item in lista:
    processar(item)
    time.sleep(1)  # 1 segundo entre requests

# Ou usar exponential backoff
tentativas = 0
while tentativas < 5:
    resposta = requests.get(url)
    if resposta.status_code == 429:
        wait_time = 2 ** tentativas  # 1s, 2s, 4s, 8s, 16s
        time.sleep(wait_time)
        tentativas += 1
    else:
        break
```

---

### 15. `HTTP Error 500: Internal Server Error`

**Causa:** Erro no servidor (não é culpa sua)

**Solução:**
- Aguardar e tentar novamente
- Verificar status da API em status.exemplo.com
- Reportar para suporte se persistir

---

## 📦 ERROS DE BIBLIOTECAS ESPECÍFICAS

### 16. BeautifulSoup: `AttributeError: 'NoneType'`

**Causa:** `.find()` não encontrou elemento

**Solução:**
```python
# ❌ Errado
titulo = soup.find('h1').text  # Se não achar h1 → AttributeError

# ✅ Certo
titulo_element = soup.find('h1')
if titulo_element:
    titulo = titulo_element.text
else:
    titulo = 'Título não encontrado'
```

---

### 17. Selenium: `NoSuchElementException`

**Causa:** Elemento não existe ou ainda não carregou

**Solução:**
```python
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Aguardar até elemento existir (max 10s)
elemento = WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, '.minha-classe'))
)
```

---

### 18. Pandas: `KeyError: 'coluna'`

**Causa:** Coluna não existe no DataFrame

**Solução:**
```python
# Verificar colunas disponíveis
print(df.columns.tolist())

# Verificar se coluna existe antes de acessar
if 'coluna' in df.columns:
    valores = df['coluna']
else:
    print("Coluna 'coluna' não existe")
```

---

## 🗂️ ERROS DE ARQUIVO/PATH

### 19. `FileNotFoundError: [Errno 2] No such file or directory`

**Causa:** Arquivo/pasta não existe

**Solução:**
```python
from pathlib import Path

arquivo = Path('data/input.csv')

if arquivo.exists():
    with open(arquivo) as f:
        dados = f.read()
else:
    print(f"❌ Arquivo não encontrado: {arquivo}")
    print(f"   Caminho absoluto: {arquivo.absolute()}")
```

**Verificar working directory:**
```python
import os
print(f"Working directory: {os.getcwd()}")
```

---

### 20. `PermissionError: [Errno 13] Permission denied`

**Causa:** Sem permissão para ler/escrever arquivo

**Soluções:**
```bash
# Mac/Linux: Dar permissão
chmod +rw arquivo.txt

# Verificar se arquivo está aberto em outro programa
# Fechar Excel/Word/etc antes de processar
```

---

## ⚙️ ERROS DE AMBIENTE

### 21. `python3: command not found`

**Causa:** Python não instalado ou não no PATH

**Solução:**
```bash
# Mac
brew install python3

# Windows
# Baixar de python.org e marcar "Add to PATH" no instalador

# Linux
sudo apt install python3
```

---

### 22. `pip3: command not found`

**Solução:**
```bash
python3 -m ensurepip --upgrade
# ou
python3 -m pip install --upgrade pip
```

---

### 23. Múltiplas versões Python causando confusão

**Identificar versões:**
```bash
which python
which python3
python --version
python3 --version
```

**Solução:** Usar sempre caminho completo
```bash
/usr/bin/python3 script.py
# ou criar alias no .bashrc/.zshrc
alias py="/usr/bin/python3"
```

---

## 🔐 ERROS DE .ENV

### 24. `os.getenv('API_KEY')` retorna `None`

**Causas:**
1. Arquivo `.env` não existe
2. Arquivo se chama `.env.example` (sem carregar)
3. Não chamou `load_dotenv()`

**Solução:**
```python
from dotenv import load_dotenv
import os

# Carregar .env ANTES de usar getenv()
load_dotenv()

API_KEY = os.getenv('API_KEY')
if not API_KEY:
    print("❌ API_KEY não encontrada no .env")
```

---

### 25. `.env` não funciona (mesmo com `load_dotenv()`)

**Verificar:**
```bash
# Arquivo existe?
ls -la .env

# Conteúdo correto? (sem espaços extras)
cat .env
```

**Formato correto:**
```env
API_KEY=abc123  # ← sem espaços ao redor do =
DEBUG=True
```

**Formato ERRADO:**
```env
API_KEY = abc123  # ← espaços causam problemas
DEBUG = True
```

---

## 🎯 DEBUGGING GERAL

**Se nada acima funcionou:**

1. **Ativar debug mode:**
```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

2. **Adicionar prints estratégicos:**
```python
print(f"🔍 DEBUG: Tipo da variável = {type(variavel)}")
print(f"🔍 DEBUG: Valor = {variavel}")
```

3. **Usar debugger interativo:**
```python
# Inserir breakpoint
import pdb; pdb.set_trace()

# Ou no Python 3.7+
breakpoint()
```

4. **Isolar problema (binary search):**
- Comentar metade do código
- Erro ainda acontece? Problema está na outra metade
- Repetir até encontrar linha exata

5. **Perguntar ao Claude Code:**
```
Estou com erro no seguinte código:

[COLAR CÓDIGO]

Erro:
[COLAR ERRO COMPLETO]

O que pode estar errado?
```

---

## 📞 QUANDO PEDIR AJUDA

**Antes de postar na comunidade, inclua:**

1. **Sistema operacional:** Mac/Windows/Linux
2. **Versão Python:** `python3 --version`
3. **Código mínimo que reproduz erro**
4. **Erro COMPLETO** (não só primeira linha)
5. **O que você já tentou**

**Template:**
```
**Problema:** [Título curto]

**Ambiente:**
- OS: macOS Sonoma
- Python: 3.11.5
- Biblioteca: requests 2.31.0

**Código:**
```python
[CÓDIGO MÍNIMO]
```

**Erro:**
```
[ERRO COMPLETO COM TRACEBACK]
```

**Tentei:**
1. [Solução 1] - Não funcionou porque...
2. [Solução 2] - Não funcionou porque...
```

---

**99% dos erros do curso estão neste guide. Se não, vem pro próximo nível: comunidade!** 🚀

