# Checklist: Debugging Sistemático

**Framework:** OBSERVE → SEARCH → ASK → ITERATE

**Quando usar:** Sempre que algo não funcionar como esperado

---

## 🔍 FASE 1: OBSERVE (Coletar Evidências)

### 1.1 Ler mensagem de erro COMPLETA

- [ ] Copiei mensagem de erro completa (não só primeira linha)
- [ ] Identifiquei tipo de erro (SyntaxError, NameError, etc)
- [ ] Identifiquei arquivo e linha (`File "x.py", line 42`)

**Exemplo de erro bem documentado:**
```
Traceback (most recent call last):
  File "scraper.py", line 23, in <module>
    dados = processar(resposta)
  File "scraper.py", line 15, in processar
    return resposta.json()
AttributeError: 'NoneType' object has no attribute 'json'
```

**O que este erro me diz:**
- Tipo: `AttributeError`
- Local: `scraper.py`, linha 15
- Problema: `resposta` é `None` (não é o que esperava)

---

### 1.2 Reproduzir erro consistentemente

- [ ] Erro acontece toda vez que rodo script?
- [ ] Ou só às vezes? (erro intermitente)
- [ ] Consigo isolar comando específico que falha?

**Teste de reprodução:**
```bash
# Rodar 3 vezes seguidas
python3 script.py
python3 script.py
python3 script.py

# Erro em todas? → Consistente (mais fácil debugar)
# Erro só em algumas? → Intermitente (race condition, timeout, rate limit)
```

---

### 1.3 Isolar problema (binary search)

- [ ] Comentei metade do código
- [ ] Erro ainda acontece?
- [ ] Repeti até encontrar linha problemática

**Técnica de binary search:**
```python
# Script original (30 linhas, erro em algum lugar)

# Teste 1: Comentar linhas 15-30
# Se erro desaparece → problema está nas linhas 15-30
# Se erro persiste → problema está nas linhas 1-14

# Teste 2: Comentar linhas 15-22 (metade do problema)
# Continuar dividindo até encontrar linha exata
```

---

### 1.4 Adicionar prints de debug

- [ ] Adicionei `print()` antes da linha que falha
- [ ] Printei valores de variáveis críticas
- [ ] Confirmei se valor está correto

**Debug prints estratégicos:**
```python
def processar_dados(url):
    print(f"🔍 DEBUG: URL recebida = {url}")  # Validar input
    
    resposta = requests.get(url)
    print(f"🔍 DEBUG: Status code = {resposta.status_code}")  # Validar resposta
    print(f"🔍 DEBUG: Tipo resposta = {type(resposta)}")
    
    dados = resposta.json()
    print(f"🔍 DEBUG: Dados = {dados[:100]}")  # Primeiros 100 chars
    
    return dados
```

---

## 🔎 FASE 2: SEARCH (Buscar Soluções)

### 2.1 Google o erro EXATO

- [ ] Copiei mensagem de erro completa no Google
- [ ] Adicionei contexto (Python, biblioteca usada)
- [ ] Encontrei Stack Overflow, GitHub Issues, ou docs

**Query eficaz:**
```
"AttributeError: 'NoneType' object has no attribute 'json'" python requests
```

**Sites úteis:**
- Stack Overflow (99% dos erros já foram resolvidos)
- GitHub Issues (do pacote que está dando erro)
- Documentação oficial da biblioteca

---

### 2.2 Ler documentação oficial

- [ ] Acessei docs da biblioteca problemática
- [ ] Procurei exemplo de uso correto
- [ ] Comparei com meu código

**Exemplo:**
```python
# Meu código (errado):
resposta = requests.get(url)
dados = resposta.json()  # ❌ Pode falhar se status != 200

# Docs recomendam (certo):
resposta = requests.get(url)
resposta.raise_for_status()  # ✅ Lança erro claro se status != 200
dados = resposta.json()
```

---

### 2.3 Verificar versões

- [ ] Checquei versão da biblioteca (`pip show requests`)
- [ ] Versão é compatível com exemplo que encontrei?
- [ ] Preciso atualizar? (`pip install --upgrade requests`)

**Problema comum:**
```bash
# Tutorial usa requests 2.28 (2023)
# Você tem requests 2.18 (2019)
# Algumas features não existem na versão antiga

# Solução:
pip install --upgrade requests
```

---

## 🤖 FASE 3: ASK (Pedir Ajuda)

### 3.1 Perguntar ao Claude Code

- [ ] Copiei código problemático no Claude
- [ ] Copiei mensagem de erro completa
- [ ] Expliquei o que EU espero que aconteça vs o que ESTÁ acontecendo

**Prompt eficaz para Claude:**
```
Estou com erro no seguinte código Python:

[COLAR CÓDIGO AQUI]

Erro que recebo:
[COLAR ERRO COMPLETO AQUI]

Contexto:
- Estou tentando fazer scraping de https://exemplo.com
- Espero receber JSON com lista de produtos
- Mas recebo AttributeError na linha X

O que pode estar errado e como corrigir?
```

---

### 3.2 Perguntar na comunidade

- [ ] Preparei código MÍNIMO que reproduz erro (não script inteiro)
- [ ] Documentei passos para reproduzir
- [ ] Incluí versões (Python, OS, bibliotecas)

**Template post comunidade:**
```
**Problema:** [Descrição curta]

**Ambiente:**
- Python 3.11
- requests 2.28
- macOS Sonoma

**Código:**
```python
[CÓDIGO MÍNIMO QUE REPRODUZ ERRO]
```

**Erro:**
```
[ERRO COMPLETO]
```

**O que tentei:**
1. [Tentativa 1]
2. [Tentativa 2]

**Output esperado:** [Descrever]
**Output atual:** [Descrever]
```

---

## 🔄 FASE 4: ITERATE (Testar Soluções)

### 4.1 Aplicar solução sugerida

- [ ] Li solução completamente antes de aplicar
- [ ] Entendi POR QUE a solução funciona
- [ ] Apliquei mudança

**Não fazer:**
```python
# ❌ Copiar/colar solução sem entender
# ❌ Aplicar 5 soluções diferentes ao mesmo tempo
# ❌ Mudar código em 10 lugares simultaneamente
```

**Fazer:**
```python
# ✅ Aplicar 1 mudança por vez
# ✅ Testar após cada mudança
# ✅ Se funcionar, entender por quê
# ✅ Se não funcionar, reverter e tentar próxima solução
```

---

### 4.2 Validar solução

- [ ] Erro desapareceu?
- [ ] Output está correto?
- [ ] Testei com múltiplos inputs?

**Validação completa:**
```bash
# Teste 1: Input normal
python3 script.py --input normal.csv

# Teste 2: Input vazio
python3 script.py --input vazio.csv

# Teste 3: Input inválido
python3 script.py --input invalido.csv

# Todos passaram? ✅ Solução validada
```

---

### 4.3 Documentar aprendizado

- [ ] Adicionei comentário no código explicando a correção
- [ ] Anotei erro + solução em doc pessoal
- [ ] Evitarei esse erro no futuro

**Comentário útil:**
```python
# CORREÇÃO: Sempre validar status_code antes de .json()
# Erro original: AttributeError quando site retorna 404
# Solução: Adicionar raise_for_status()
resposta = requests.get(url)
resposta.raise_for_status()  # ✅ Lança erro claro se != 200
dados = resposta.json()
```

---

## 🎯 ERROS MAIS COMUNS + SOLUÇÕES RÁPIDAS

### 1. ModuleNotFoundError: No module named 'X'

**Solução:**
```bash
pip3 install X
```

---

### 2. SyntaxError: invalid syntax

**Causas comuns:**
- Faltou `:` no final de `if`/`for`/`def`
- Parênteses não fechados
- Indentação errada (tabs vs spaces)

**Verificar:**
```python
# ❌ Errado
if condicao
    print("oi")

# ✅ Certo
if condicao:  # ← faltava :
    print("oi")
```

---

### 3. IndentationError: unexpected indent

**Solução:**
```python
# Usar SEMPRE 4 espaços (não tabs)
# Configurar editor: Tab = 4 espaços
```

---

### 4. NameError: name 'X' is not defined

**Causas:**
- Variável não foi definida antes de usar
- Typo no nome da variável
- Variável fora do scope

**Verificar:**
```python
# ❌ Errado
print(resultado)  # NameError: resultado não existe ainda

resultado = 42
print(resultado)  # ✅ Agora sim
```

---

### 5. AttributeError: 'NoneType' object has no attribute 'X'

**Causa:** Variável é `None` (não o objeto esperado)

**Solução:**
```python
# Adicionar validação
if variavel is not None:
    variavel.metodo()
else:
    print("Variável é None, investigar por quê")
```

---

### 6. KeyError: 'chave'

**Causa:** Chave não existe no dicionário

**Solução:**
```python
# Opção 1: .get() com default
valor = dicionario.get('chave', 'default')

# Opção 2: Verificar antes
if 'chave' in dicionario:
    valor = dicionario['chave']
```

---

### 7. Timeout / Connection Error

**Causa:** API lenta, internet instável, rate limit

**Solução:**
```python
import time

for tentativa in range(3):
    try:
        resposta = requests.get(url, timeout=30)
        break  # Sucesso, sair do loop
    except requests.exceptions.Timeout:
        if tentativa < 2:  # Última tentativa
            time.sleep(5)  # Aguardar 5s
            continue
        else:
            raise  # Falhou 3x, re-raise erro
```

---

## ✅ CHECKLIST FINAL

Antes de pedir ajuda, validei:

- [ ] Li mensagem de erro completa
- [ ] Isolei linha problemática
- [ ] Adicionei prints de debug
- [ ] Googlei erro exato
- [ ] Li docs da biblioteca
- [ ] Verifiquei versões
- [ ] Perguntei ao Claude com contexto completo
- [ ] Apliquei soluções 1 por vez
- [ ] Validei que solução funciona
- [ ] Documentei aprendizado

**Se todos marcados e AINDA não resolveu:**
→ Problema complexo, post detalhado na comunidade com template acima

---

**Framework OBSERVE → SEARCH → ASK → ITERATE domina 95% dos bugs** 🐛✅

