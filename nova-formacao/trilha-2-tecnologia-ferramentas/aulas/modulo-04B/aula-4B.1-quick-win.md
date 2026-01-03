# Aula 4B.1: Primeiro Código com IA em 10 Minutos

## Tipo: Quick Win | Duração: 10 minutos

---

## GPS

### Goal (30s)
Escrever código funcional usando IA integrada à IDE em 10 minutos.

### Position (60s)
Programar sem IA é como escrever sem corretor ortográfico. Possível, mas desnecessário.

### Steps
1. Instalar IDE (3 min)
2. Configurar IA (2 min)
3. Gerar primeiro código (5 min)

---

## Passo 1: Instale o Cursor

### Por que Cursor?

| Vantagem | Detalhe |
|----------|---------|
| Já vem configurado | IA pronta para usar |
| Baseado no VS Code | Interface familiar |
| Free tier generoso | Começa sem pagar |
| Claude + GPT | Melhor de dois mundos |

### Instalação

1. Acesse: https://cursor.sh
2. Clique em "Download"
3. Instale (Windows/Mac/Linux)
4. Abra o Cursor

**Alternativas:**
- Antigravity: https://antigravity.dev
- VS Code + Continue: extensão gratuita

---

## Passo 2: Configure a IA

### No Cursor

1. Ao abrir, ele pede para fazer login
2. Crie conta (Google ou email)
3. Pronto! IA já está ativa

### Atalhos Essenciais

| Atalho | O que faz |
|--------|-----------|
| `Cmd/Ctrl + K` | Chat inline (escreve código) |
| `Cmd/Ctrl + L` | Chat lateral (explica/ajuda) |
| `Tab` | Aceita sugestão |
| `Esc` | Rejeita sugestão |

---

## Passo 3: Gere Seu Primeiro Código

### Exercício: API Simples

1. Crie uma pasta nova
2. Abra no Cursor (File → Open Folder)
3. Crie arquivo `app.py`
4. Pressione `Cmd/Ctrl + K`
5. Digite:

```
Crie uma API em FastAPI que:
- Endpoint GET /hello retorna {"message": "Olá, mundo!"}
- Endpoint GET /soma/{a}/{b} retorna a soma de dois números
- Inclua documentação automática
```

6. A IA vai gerar o código. Pressione Enter para aceitar.

### Resultado Esperado

```python
from fastapi import FastAPI

app = FastAPI(
    title="Minha Primeira API",
    description="API criada com IA"
)

@app.get("/hello")
def hello():
    return {"message": "Olá, mundo!"}

@app.get("/soma/{a}/{b}")
def soma(a: int, b: int):
    return {"resultado": a + b}
```

### Rode o Código

No terminal do Cursor:
```bash
pip install fastapi uvicorn
uvicorn app:app --reload
```

Acesse: http://localhost:8000/docs

---

## O Que Você Acabou de Fazer

```
1. Pediu em português
2. IA escreveu em Python
3. Código funcional em segundos
```

Isso é programar com IA.

---

## Experimente Mais

### Peça inline (Cmd/Ctrl + K):

```
"Adicione um endpoint POST /usuario que recebe nome e email"
```

```
"Adicione validação: email deve ser válido"
```

```
"Adicione tratamento de erro se soma não receber números"
```

### Pergunte no chat (Cmd/Ctrl + L):

```
"O que esse código faz?"
```

```
"Como faço para adicionar autenticação?"
```

```
"Esse código tem algum problema de segurança?"
```

---

## Reflexão

| Pergunta | Resposta |
|----------|----------|
| Quanto tempo levou? | ___ minutos |
| O código funcionou de primeira? | Sim / Não / Quase |
| Quantas linhas você digitou manualmente? | ___ |
| Você usaria isso todo dia? | Sim / Não |

---

## Comparativo

| Aspecto | Sem IA | Com IA |
|---------|--------|--------|
| Tempo para criar API | 15-30 min | 2 min |
| Pesquisar sintaxe | Google/Docs | Pergunta inline |
| Debug | Console + tentativa | Chat explica erro |
| Documentação | Escreve manual | Gerada automaticamente |

---

## Próximo Passo

Na próxima aula, vamos entender todas as funcionalidades das IDEs com IA.
