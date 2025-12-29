# Template: API REST Simples

**Descrição:** Flask API com 4 endpoints prontos (GET, POST, PUT, DELETE) - pronto para customizar.

**Use este template para:** APIs de integração, webhooks, microserviços

---

## 🔧 CÓDIGO TEMPLATE

```python
#!/usr/bin/env python3
"""
API REST Básica com Flask
=========================

API simples com CRUD completo (Create, Read, Update, Delete)

Uso:
    python api.py

Endpoints:
    GET    /api/items          - Lista todos items
    GET    /api/items/<id>     - Busca item específico
    POST   /api/items          - Cria novo item
    PUT    /api/items/<id>     - Atualiza item
    DELETE /api/items/<id>     - Remove item

Dependências:
    pip install flask flask-cors

Autor: Claude Code Template
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
from datetime import datetime
import os

#

 ===== CONFIGURAÇÃO =====

app = Flask(__name__)
CORS(app)  # Permite requests de outros domínios

# Porta da API
PORT = int(os.getenv('PORT', 5000))

# Debug mode
DEBUG = os.getenv('DEBUG', 'True') == 'True'


# ===== BANCO DE DADOS MOCK =====
# Em produção, substituir por PostgreSQL/MongoDB/etc

items = [
    {'id': 1, 'nome': 'Item 1', 'descricao': 'Primeiro item', 'ativo': True, 'criado_em': '2025-01-01'},
    {'id': 2, 'nome': 'Item 2', 'descricao': 'Segundo item', 'ativo': True, 'criado_em': '2025-01-02'},
]

contador_id = 3  # Próximo ID disponível


# ===== HELPERS =====

def encontrar_item(item_id):
    """Busca item por ID"""
    return next((item for item in items if item['id'] == item_id), None)


def validar_item_data(data, obrigatorio=True):
    """Valida dados do item"""
    erros = []
    
    if obrigatorio and not data.get('nome'):
        erros.append('Campo "nome" é obrigatório')
    
    if 'nome' in data and len(data['nome']) < 3:
        erros.append('Campo "nome" deve ter pelo menos 3 caracteres')
    
    return erros


# ===== ENDPOINTS =====

@app.route('/')
def home():
    """Homepage da API"""
    return jsonify({
        'api': 'API REST Básica',
        'versao': '1.0',
        'status': 'online',
        'endpoints': {
            'GET /api/items': 'Lista todos items',
            'GET /api/items/<id>': 'Busca item específico',
            'POST /api/items': 'Cria novo item',
            'PUT /api/items/<id>': 'Atualiza item',
            'DELETE /api/items/<id>': 'Remove item',
        }
    })


# ----- GET (Read) -----

@app.route('/api/items', methods=['GET'])
def get_items():
    """Lista todos items com filtros opcionais"""
    
    # Filtro: ?ativo=true
    filtro_ativo = request.args.get('ativo')
    
    if filtro_ativo is not None:
        ativo = filtro_ativo.lower() == 'true'
        items_filtrados = [item for item in items if item.get('ativo') == ativo]
    else:
        items_filtrados = items
    
    return jsonify({
        'total': len(items_filtrados),
        'items': items_filtrados
    }), 200


@app.route('/api/items/<int:item_id>', methods=['GET'])
def get_item(item_id):
    """Busca item específico por ID"""
    
    item = encontrar_item(item_id)
    
    if item:
        return jsonify(item), 200
    else:
        return jsonify({'erro': f'Item {item_id} não encontrado'}), 404


# ----- POST (Create) -----

@app.route('/api/items', methods=['POST'])
def create_item():
    """Cria novo item"""
    global contador_id
    
    data = request.json
    
    if not data:
        return jsonify({'erro': 'Body JSON é obrigatório'}), 400
    
    # Validação
    erros = validar_item_data(data, obrigatorio=True)
    if erros:
        return jsonify({'erros': erros}), 400
    
    # Criar novo item
    novo_item = {
        'id': contador_id,
        'nome': data['nome'],
        'descricao': data.get('descricao', ''),
        'ativo': data.get('ativo', True),
        'criado_em': datetime.now().strftime('%Y-%m-%d'),
        'atualizado_em': None
    }
    
    items.append(novo_item)
    contador_id += 1
    
    return jsonify({
        'mensagem': 'Item criado com sucesso',
        'item': novo_item
    }), 201


# ----- PUT (Update) -----

@app.route('/api/items/<int:item_id>', methods=['PUT'])
def update_item(item_id):
    """Atualiza item existente"""
    
    item = encontrar_item(item_id)
    
    if not item:
        return jsonify({'erro': f'Item {item_id} não encontrado'}), 404
    
    data = request.json
    
    if not data:
        return jsonify({'erro': 'Body JSON é obrigatório'}), 400
    
    # Validação
    erros = validar_item_data(data, obrigatorio=False)
    if erros:
        return jsonify({'erros': erros}), 400
    
    # Atualizar campos (apenas os enviados)
    if 'nome' in data:
        item['nome'] = data['nome']
    if 'descricao' in data:
        item['descricao'] = data['descricao']
    if 'ativo' in data:
        item['ativo'] = data['ativo']
    
    item['atualizado_em'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    return jsonify({
        'mensagem': 'Item atualizado com sucesso',
        'item': item
    }), 200


# ----- DELETE (Delete) -----

@app.route('/api/items/<int:item_id>', methods=['DELETE'])
def delete_item(item_id):
    """Remove item"""
    
    item = encontrar_item(item_id)
    
    if not item:
        return jsonify({'erro': f'Item {item_id} não encontrado'}), 404
    
    items.remove(item)
    
    return jsonify({
        'mensagem': f'Item {item_id} removido com sucesso'
    }), 200


# ----- WEBHOOK (exemplo) -----

@app.route('/webhook/zapier', methods=['POST'])
def webhook_zapier():
    """Endpoint webhook para integração Zapier"""
    
    data = request.json
    
    # Processar dados do webhook
    print(f"📥 Webhook recebido: {data}")
    
    # Sua lógica customizada aqui
    resultado = {
        'status': 'processado',
        'recebido_em': datetime.now().isoformat(),
        'dados': data
    }
    
    return jsonify(resultado), 200


# ----- ERROR HANDLERS -----

@app.errorhandler(404)
def not_found(error):
    """Handler para 404"""
    return jsonify({'erro': 'Endpoint não encontrado'}), 404


@app.errorhandler(500)
def internal_error(error):
    """Handler para 500"""
    return jsonify({'erro': 'Erro interno do servidor'}), 500


# ===== MAIN =====

if __name__ == '__main__':
    print("=" * 60)
    print(f"🚀 API REST rodando em http://localhost:{PORT}")
    print("=" * 60)
    print("\nEndpoints disponíveis:")
    print(f"  GET    http://localhost:{PORT}/api/items")
    print(f"  GET    http://localhost:{PORT}/api/items/<id>")
    print(f"  POST   http://localhost:{PORT}/api/items")
    print(f"  PUT    http://localhost:{PORT}/api/items/<id>")
    print(f"  DELETE http://localhost:{PORT}/api/items/<id>")
    print(f"\n  Webhook: POST http://localhost:{PORT}/webhook/zapier")
    print("=" * 60)
    
    app.run(host='0.0.0.0', port=PORT, debug=DEBUG)
```

---

## 🧪 TESTANDO A API

### Com curl (Terminal)

```bash
# 1. GET - Lista todos
curl http://localhost:5000/api/items

# 2. GET - Item específico
curl http://localhost:5000/api/items/1

# 3. POST - Criar novo
curl -X POST http://localhost:5000/api/items \
  -H "Content-Type: application/json" \
  -d '{"nome": "Novo Item", "descricao": "Teste"}'

# 4. PUT - Atualizar
curl -X PUT http://localhost:5000/api/items/1 \
  -H "Content-Type: application/json" \
  -d '{"nome": "Item Atualizado"}'

# 5. DELETE - Remover
curl -X DELETE http://localhost:5000/api/items/2
```

### Com Python (requests)

```python
import requests

BASE_URL = "http://localhost:5000/api"

# GET
response = requests.get(f"{BASE_URL}/items")
print(response.json())

# POST
novo_item = {"nome": "Item Python", "descricao": "Criado via Python"}
response = requests.post(f"{BASE_URL}/items", json=novo_item)
print(response.json())

# PUT
response = requests.put(f"{BASE_URL}/items/1", json={"ativo": False})
print(response.json())

# DELETE
response = requests.delete(f"{BASE_URL}/items/2")
print(response.json())
```

---

## 🔌 INTEGRAÇÃO ZAPIER

```
Trigger: Typeform "New Entry"
↓
Action: Webhooks → POST
URL: http://sua-api.com/webhook/zapier
Body: {"nome": "{{nome}}", "email": "{{email}}"}
↓
Sua API processa
↓
Action 2: Notion → Create Database Item
Mapear response da API
```

---

## 💡 CUSTOMIZAÇÕES COMUNS

### Adicionar Autenticação

```python
from functools import wraps

def requer_api_key(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        api_key = request.headers.get('X-API-Key')
        
        if api_key != os.getenv('API_KEY'):
            return jsonify({'erro': 'API key inválida'}), 401
        
        return f(*args, **kwargs)
    return decorated

@app.route('/api/items', methods=['POST'])
@requer_api_key  # Protege endpoint
def create_item():
    ...
```

### Conectar Banco Real (PostgreSQL)

```python
import psycopg2
from psycopg2.extras import RealDictCursor

def get_db():
    return psycopg2.connect(
        os.getenv('DATABASE_URL'),
        cursor_factory=RealDictCursor
    )

@app.route('/api/items', methods=['GET'])
def get_items():
    with get_db() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM items")
            items = cur.fetchall()
    
    return jsonify({'items': items})
```

### Rate Limiting

```python
from flask_limiter import Limiter

limiter = Limiter(app, key_func=lambda: request.remote_addr)

@app.route('/api/items', methods=['POST'])
@limiter.limit("10 per minute")  # Max 10 requests/min
def create_item():
    ...
```

---

**Template:** José Carlos Amorim  
**Curso:** Claude Code Expert

