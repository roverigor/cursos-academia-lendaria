# Checklist: Projeto Pronto para Produção

**Objetivo:** Validar que automação está production-ready (não é mais "script de teste")

**Tempo:** 20-30 minutos

---

## 🎯 CONTEXTO

**Diferença entre Script de Teste vs Produção:**

| Aspecto | Teste | Produção |
|---------|-------|----------|
| Error handling | Quebra | Trata e continua |
| Logging | `print()` | Logs estruturados |
| Configuração | Hardcoded | `.env` |
| Documentação | Nenhuma | README completo |
| Validação | Manual | Automática |
| Monitoramento | Nenhum | Alertas configurados |

---

## ✅ CHECKLIST DE PRODUÇÃO

### 1️⃣ CÓDIGO

#### 1.1 Error Handling Robusto

- [ ] Todo `requests.get()` tem `try/except`
- [ ] Todo `file.open()` tem `try/except`
- [ ] Erros não travam script inteiro (continua processando)
- [ ] Erros críticos travam com mensagem clara

**Exemplo:**
```python
# ❌ Script de teste
dados = requests.get(url).json()

# ✅ Produção
try:
    resposta = requests.get(url, timeout=30)
    resposta.raise_for_status()
    dados = resposta.json()
except requests.exceptions.Timeout:
    logger.error(f"Timeout ao acessar {url}")
    dados = None
except requests.exceptions.HTTPError as e:
    logger.error(f"HTTP Error {e.response.status_code}: {url}")
    dados = None
except Exception as e:
    logger.error(f"Erro inesperado: {e}")
    dados = None
```

---

#### 1.2 Logging Estruturado

- [ ] Uso `logging` (não `print()`)
- [ ] Logs salvos em arquivo
- [ ] Níveis corretos (INFO, WARNING, ERROR)
- [ ] Timestamp automático

**Configuração mínima:**
```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('logs/app.log'),
        logging.StreamHandler()  # Console também
    ]
)

logger = logging.getLogger(__name__)
```

---

#### 1.3 Validação de Inputs

- [ ] Valido parâmetros antes de processar
- [ ] Valido estrutura de arquivos input
- [ ] Valido credenciais/API keys antes de começar

**Exemplo:**
```python
def validar_config():
    """Valida que todas configs necessárias existem"""
    erros = []
    
    if not os.getenv('API_KEY'):
        erros.append("API_KEY não configurada no .env")
    
    if not Path('data/input.csv').exists():
        erros.append("Arquivo data/input.csv não encontrado")
    
    if erros:
        for erro in erros:
            logger.error(f"❌ {erro}")
        sys.exit(1)
    
    logger.info("✅ Todas validações passaram")
```

---

### 2️⃣ CONFIGURAÇÃO

#### 2.1 Variáveis de Ambiente

- [ ] Todos secrets estão em `.env` (não hardcoded)
- [ ] Criei `.env.example` (template sem secrets)
- [ ] `.env` está no `.gitignore`

**Estrutura:**
```
projeto/
├── .env              # Suas credenciais (gitignored)
├── .env.example      # Template público
└── .gitignore        # Inclui .env
```

**`.env.example`:**
```env
# API Keys
API_KEY=sua_chave_aqui
CLEARBIT_KEY=

# Configurações
MAX_ITEMS=100
TIMEOUT_SECONDS=30
DEBUG=False
```

---

#### 2.2 .gitignore Completo

- [ ] `.env` ignorado
- [ ] Pastas de output ignoradas
- [ ] Logs ignorados
- [ ] Cache Python ignorado

**`.gitignore` mínimo:**
```
# Secrets
.env
*.key
*.pem

# Outputs
output/
data/
logs/

# Python
__pycache__/
*.pyc
.pytest_cache/

# OS
.DS_Store
Thumbs.db
```

---

### 3️⃣ DOCUMENTAÇÃO

#### 3.1 README.md Completo

- [ ] Descrição do que projeto faz
- [ ] Instruções de instalação
- [ ] Exemplo de uso
- [ ] Seção troubleshooting

**Usar template:** `resources/template-readme-projeto.md`

---

#### 3.2 Comentários no Código

- [ ] Funções têm docstrings
- [ ] Lógica complexa tem comentários
- [ ] TODOs documentados

**Exemplo:**
```python
def processar_leads(leads: list) -> dict:
    """
    Processa lista de leads aplicando score e classificação.
    
    Args:
        leads: Lista de dicts com dados dos leads
        
    Returns:
        Dict com resultados: {
            'processados': int,
            'hot_leads': list,
            'cold_leads': list
        }
        
    Raises:
        ValueError: Se leads não for lista
    """
    # ... implementação
```

---

### 4️⃣ TESTES & VALIDAÇÃO

#### 4.1 Testes Básicos

- [ ] Testei com input válido
- [ ] Testei com input vazio
- [ ] Testei com input inválido/corrompido
- [ ] Testei com API offline/lenta

**Script de teste:**
```python
def test_producao():
    """Testes de validação antes de deploy"""
    
    # Teste 1: Input válido
    resultado = processar('data/test_valido.csv')
    assert resultado['status'] == 'sucesso'
    
    # Teste 2: Input vazio
    resultado = processar('data/test_vazio.csv')
    assert resultado['status'] == 'vazio'  # Não deve travar
    
    # Teste 3: Timeout (mock)
    with mock_timeout():
        resultado = processar('data/test.csv')
        assert 'erro' in resultado  # Deve capturar timeout
    
    print("✅ Todos testes passaram")
```

---

#### 4.2 Dry-Run Mode

- [ ] Implementei flag `--dry-run` para testar sem executar ações reais
- [ ] Dry-run valida toda lógica sem side-effects

**Exemplo:**
```python
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--dry-run', action='store_true', help='Testar sem executar')
args = parser.parse_args()

def enviar_email(destinatario, mensagem):
    if args.dry_run:
        logger.info(f"[DRY-RUN] Enviaria email para: {destinatario}")
        return
    
    # Código real de envio
    smtp.send(destinatario, mensagem)
```

---

### 5️⃣ MONITORAMENTO

#### 5.1 Alertas de Erro

- [ ] Script envia notificação se erro crítico
- [ ] Notificação vai para Slack/Email/SMS
- [ ] Notificação inclui contexto útil (não só "erro")

**Exemplo Slack:**
```python
def notificar_erro_critico(erro: Exception):
    """Envia alerta Slack para erros críticos"""
    import requests
    
    webhook_url = os.getenv('SLACK_WEBHOOK_URL')
    
    if not webhook_url:
        logger.warning("Slack webhook não configurado")
        return
    
    mensagem = {
        'text': f'🚨 ERRO CRÍTICO em {os.path.basename(__file__)}',
        'blocks': [
            {
                'type': 'section',
                'text': {'type': 'mrkdwn', 'text': f'*Erro:* `{type(erro).__name__}`'}
            },
            {
                'type': 'section',
                'text': {'type': 'mrkdwn', 'text': f'*Mensagem:* {str(erro)}'}
            }
        ]
    }
    
    requests.post(webhook_url, json=mensagem)
```

---

#### 5.2 Métricas de Sucesso

- [ ] Script loga métricas de cada execução
- [ ] Métricas incluem: items processados, taxa sucesso, duração
- [ ] Posso ver histórico de execuções

**Exemplo:**
```python
def salvar_metricas(metricas: dict):
    """Salva métricas de execução para análise futura"""
    timestamp = datetime.now().isoformat()
    
    registro = {
        'timestamp': timestamp,
        'items_processados': metricas['total'],
        'sucessos': metricas['sucessos'],
        'falhas': metricas['falhas'],
        'taxa_sucesso': metricas['sucessos'] / metricas['total'],
        'duracao_segundos': metricas['duracao']
    }
    
    # Append em arquivo JSONL (1 linha = 1 execução)
    with open('logs/metricas.jsonl', 'a') as f:
        f.write(json.dumps(registro) + '\n')
```

---

### 6️⃣ SEGURANÇA

#### 6.1 Secrets Management

- [ ] Nenhum secret hardcoded no código
- [ ] `.env` nunca foi committado no git
- [ ] Keys têm permissões mínimas (não admin desnecessário)

**Verificar histórico git:**
```bash
# Buscar se .env foi committado por engano
git log --all --full-history -- .env

# Se encontrou, remover do histórico:
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .env" \
  --prune-empty --tag-name-filter cat -- --all
```

---

#### 6.2 Input Validation (Security)

- [ ] Valido inputs de usuário (prevenir injection)
- [ ] Sanitizo dados antes de executar comandos shell
- [ ] Limito tamanho de inputs (prevenir DoS)

**Exemplo:**
```python
import re

def validar_input_seguro(user_input: str) -> bool:
    """Valida que input não contém caracteres perigosos"""
    
    # Permitir apenas alfanuméricos, hífen, underscore
    if not re.match(r'^[a-zA-Z0-9_-]+$', user_input):
        logger.warning(f"Input rejeitado (caracteres inválidos): {user_input}")
        return False
    
    # Limitar tamanho
    if len(user_input) > 100:
        logger.warning(f"Input rejeitado (muito longo): {len(user_input)} chars")
        return False
    
    return True
```

---

### 7️⃣ PERFORMANCE

#### 7.1 Rate Limiting

- [ ] Respeito limites de API (não faço 1000 requests/segundo)
- [ ] Implementei delays entre requests
- [ ] Implementei backoff exponencial se rate limit

**Exemplo:**
```python
import time

def fazer_request_com_rate_limit(url):
    """Request com rate limiting (max 10/min)"""
    time.sleep(6)  # 60s / 10 requests = 6s entre requests
    return requests.get(url)

# Ou usar biblioteca ratelimit:
from ratelimit import limits, sleep_and_retry

@sleep_and_retry
@limits(calls=10, period=60)  # 10 calls por 60 segundos
def fazer_request_limitado(url):
    return requests.get(url)
```

---

#### 7.2 Otimização

- [ ] Uso batch processing (não processar 1 por 1)
- [ ] Implementei cache se aplicável
- [ ] Processos longos têm progress bar

**Progress bar:**
```python
from tqdm import tqdm

for item in tqdm(lista_grande, desc="Processando"):
    processar(item)
```

---

### 8️⃣ MANUTENÇÃO

#### 8.1 Versionamento

- [ ] Código está no git
- [ ] Commits têm mensagens descritivas
- [ ] Tags nas versões estáveis (`git tag v1.0.0`)

---

#### 8.2 Dependências Documentadas

- [ ] Criei `requirements.txt`
- [ ] Incluí versões específicas (não `requests>=2.0`)
- [ ] Testei instalação limpa

**Gerar requirements.txt:**
```bash
pip freeze > requirements.txt
```

**Testar em ambiente limpo:**
```bash
python3 -m venv venv_teste
source venv_teste/bin/activate
pip install -r requirements.txt
python3 main.py
```

---

### 9️⃣ DEPLOY

#### 9.1 Ambiente de Produção

- [ ] Sei onde script vai rodar (servidor, cloud, local)
- [ ] Ambiente tem todas dependências
- [ ] Script está agendado (cron, scheduler)

---

#### 9.2 Rollback Plan

- [ ] Sei como reverter para versão anterior se algo quebrar
- [ ] Tenho backup dos dados críticos
- [ ] Documentei processo de rollback

**Rollback simples:**
```bash
# Manter versões anteriores
cp main.py main.py.v1.0.0

# Se v1.1.0 quebrar:
cp main.py.v1.0.0 main.py
```

---

### 🔟 DOCUMENTAÇÃO OPERACIONAL

#### 10.1 Runbook

- [ ] Documentei como iniciar script
- [ ] Documentei como parar script
- [ ] Documentei como debugar problemas comuns

**Exemplo Runbook:**
```markdown
## Como Iniciar
```bash
cd /caminho/projeto
source venv/bin/activate
python3 main.py
```

## Como Parar
```bash
# Encontrar PID
ps aux | grep main.py

# Matar processo
kill [PID]
```

## Troubleshooting
- Se erro "API key invalid": Verificar .env
- Se timeout: Aumentar TIMEOUT_SECONDS no .env
- Se memória alta: Reduzir MAX_ITEMS no .env
```

---

## ✅ CHECKLIST FINAL

### Código
- [ ] Error handling robusto
- [ ] Logging estruturado
- [ ] Validação de inputs

### Configuração
- [ ] Variáveis em `.env`
- [ ] `.gitignore` completo

### Documentação
- [ ] README.md
- [ ] Docstrings
- [ ] Runbook

### Testes
- [ ] Testado com inputs variados
- [ ] Dry-run mode

### Monitoramento
- [ ] Alertas de erro
- [ ] Métricas logadas

### Segurança
- [ ] Secrets management
- [ ] Input validation

### Performance
- [ ] Rate limiting
- [ ] Progress bars

### Manutenção
- [ ] Git versionado
- [ ] requirements.txt

### Deploy
- [ ] Ambiente configurado
- [ ] Rollback plan

### Operacional
- [ ] Runbook documentado

---

**Se TODOS marcados:** ✅ **Projeto PRODUCTION-READY!**

**Se < 80% marcados:** ⚠️ **Melhorar antes de deploy**

**Se < 50% marcados:** ❌ **Ainda é script de teste**

---

**Lembre-se:** Produção não significa perfeito. Significa **confiável, documentado e mantível**. 🚀

