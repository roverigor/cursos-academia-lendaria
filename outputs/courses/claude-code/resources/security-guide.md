# Security Guide: API Keys e Secrets

**Objetivo:** Proteger credenciais e dados sensíveis nas suas automações

**Nível:** Essencial para qualquer projeto

---

## 🔐 PRINCÍPIO FUNDAMENTAL

**NUNCA hardcode secrets no código!**

```python
# ❌ NUNCA FAÇA ISSO
API_KEY = "sk-abc123xyz789"  # ← Visível para qualquer um que veja o código

# ✅ SEMPRE FAÇA ISSO
API_KEY = os.getenv('API_KEY')  # ← Carrega de .env (não commitado)
```

**Por quê?**
- Código vai pro git → git é público/compartilhado → secrets vazam
- Alguém com acesso ao código tem acesso às suas credentials
- Se key vazar, precisa trocar e atualizar em 100 lugares

---

## 🗂️ ARMAZENAMENTO CORRETO

### 1. Usar Arquivo `.env`

**Estrutura:**
```
projeto/
├── .env              # SUAS credentials (NÃO commitar)
├── .env.example      # Template PÚBLICO (sem valores reais)
├── .gitignore        # Incluir .env aqui
└── script.py
```

**`.env` (privado):**
```env
API_KEY=sk-abc123xyz789
CLEARBIT_KEY=pk_def456uvw012
DATABASE_URL=postgresql://user:pass@localhost/db
```

**`.env.example` (público):**
```env
API_KEY=sua_chave_aqui
CLEARBIT_KEY=sua_chave_clearbit
DATABASE_URL=postgresql://user:senha@localhost/nome_db
```

---

### 2. Configurar `.gitignore`

**`.gitignore`:**
```
# Secrets
.env
.env.local
*.key
*.pem
*.p12
secrets.json

# Dados sensíveis
database.db
*.sqlite3
backups/
```

**Verificar se funciona:**
```bash
git status
# .env NÃO deve aparecer na lista
```

---

### 3. Carregar no Código

**Python:**
```python
from dotenv import load_dotenv
import os

# Carregar .env
load_dotenv()

# Usar
API_KEY = os.getenv('API_KEY')

# Validar
if not API_KEY:
    raise ValueError("❌ API_KEY não configurada no .env")
```

---

## 🚨 EMERGÊNCIA: KEY VAZOU

### Se você COMMITT OUsuário .env sem querer:

**1. Revogar key IMEDIATAMENTE**
- Acessar dashboard do provider (OpenAI, Clearbit, etc)
- Revogar/deletar key comprometida
- Gerar nova key

**2. Remover do histórico git**
```bash
# Remover arquivo do histórico
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .env" \
  --prune-empty --tag-name-filter cat -- --all

# Forçar push (sobrescrever histórico remoto)
git push origin --force --all
```

**⚠️ CUIDADO:** Isso reescreve histórico. Avise time se repositório compartilhado.

**3. Alternativa mais moderna (git-filter-repo):**
```bash
# Instalar
pip install git-filter-repo

# Remover arquivo
git filter-repo --path .env --invert-paths
```

**4. Verificar vazamento público**
- Buscar key no GitHub: `"sk-abc123xyz789"`
- Se encontrar em repo público → key está comprometida
- Revogar imediatamente

---

## 🔒 BOAS PRÁTICAS

### 1. Permissões Mínimas

**Ao criar API keys, dar APENAS permissões necessárias**

**Exemplo OpenAI:**
- ❌ Admin access (desnecessário)
- ✅ Read/Write apenas nos endpoints que usa

**Exemplo AWS:**
- ❌ FullAccess policies
- ✅ Policies específicas (S3ReadOnly, LambdaExecute, etc)

---

### 2. Rotation de Keys

**Trocar keys periodicamente:**
- Keys críticas: A cada 90 dias
- Keys de teste: A cada 6 meses
- Keys de produção: A cada 30 dias

**Processo:**
1. Gerar nova key no dashboard
2. Atualizar `.env` local
3. Testar que tudo funciona
4. Atualizar produção
5. Revogar key antiga (após 24h de grace period)

---

### 3. Ambientes Separados

**Nunca usar mesma key para dev/prod:**

**`.env.dev`:**
```env
API_KEY=sk-dev-abc123  # Key de teste/dev
DATABASE_URL=localhost
```

**`.env.prod`:**
```env
API_KEY=sk-prod-xyz789  # Key de produção
DATABASE_URL=aws-rds-endpoint
```

**Carregar ambiente correto:**
```python
import os
from dotenv import load_dotenv

env = os.getenv('ENVIRONMENT', 'dev')  # default: dev
load_dotenv(f'.env.{env}')
```

---

## 🛡️ VALIDAÇÃO E MONITORAMENTO

### 1. Validar Keys no Início

```python
def validar_credentials():
    """Valida que todas credentials necessárias existem"""
    required_keys = ['API_KEY', 'DATABASE_URL', 'SLACK_WEBHOOK']
    
    missing = []
    for key in required_keys:
        if not os.getenv(key):
            missing.append(key)
    
    if missing:
        raise ValueError(f"❌ Credentials faltando no .env: {', '.join(missing)}")
    
    logger.info("✅ Todas credentials validadas")

# Executar na inicialização
validar_credentials()
```

---

### 2. Nunca Logar Secrets

```python
# ❌ NUNCA
logger.info(f"Usando API key: {API_KEY}")  # ← Vaza no log!

# ✅ SEMPRE
logger.info("Usando API key: ***masked***")

# Ou helper function:
def mask_secret(secret: str, show_chars=4) -> str:
    """Mascara secret mostrando só últimos N chars"""
    if len(secret) <= show_chars:
        return "*" * len(secret)
    return "*" * (len(secret) - show_chars) + secret[-show_chars:]

logger.info(f"API key: {mask_secret(API_KEY)}")
# Output: API key: ************xyz789
```

---

### 3. Monitorar Uso de Keys

**Verificar dashboards dos providers:**
- Requests por dia (detectar uso anormal)
- Custos (spike inesperado = possível vazamento)
- Origem dos requests (IPs desconhecidos)

**Alertas:**
```python
# Se custo > threshold, enviar alerta
if custo_mes_atual > 100:  # USD
    enviar_alerta_slack(f"⚠️ Custo OpenAI: ${custo_mes_atual}")
```

---

## 🔐 SEGURANÇA AVANÇADA

### 1. Criptografar .env (opcional)

**Para projetos ultra-sensíveis:**

```bash
# Instalar
pip install cryptography

# Script de encrypt/decrypt
```

```python
from cryptography.fernet import Fernet

# Gerar chave de criptografia (1x, guardar em local seguro)
key = Fernet.generate_key()
# Salvar em: ~/.secrets/project_key (NUNCA commitar)

cipher = Fernet(key)

# Encriptar .env
with open('.env', 'rb') as f:
    encrypted = cipher.encrypt(f.read())

with open('.env.encrypted', 'wb') as f:
    f.write(encrypted)

# Decriptar no runtime
with open('.env.encrypted', 'rb') as f:
    decrypted = cipher.decrypt(f.read())

# Carregar env variables do decrypted content
```

---

### 2. Usar Secret Managers (Produção)

**Para deploy em produção:**

**AWS Secrets Manager:**
```python
import boto3

def get_secret(secret_name):
    client = boto3.client('secretsmanager', region_name='us-east-1')
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response['SecretString'])

secrets = get_secret('prod/api-keys')
API_KEY = secrets['openai_key']
```

**Google Secret Manager:**
```python
from google.cloud import secretmanager

def get_secret(project_id, secret_id):
    client = secretmanager.SecretManagerServiceClient()
    name = f"projects/{project_id}/secrets/{secret_id}/versions/latest"
    response = client.access_secret_version(request={"name": name})
    return response.payload.data.decode("UTF-8")

API_KEY = get_secret('my-project', 'openai-api-key')
```

**Vantagens:**
- Rotation automática
- Audit logs (quem acessou quando)
- Criptografia at-rest e in-transit
- Sem arquivos `.env` em produção

---

### 3. Rate Limiting por Key

**Se múltiplos usuários compartilham sistema:**

```python
from collections import defaultdict
from datetime import datetime, timedelta

# Track requests per API key
request_count = defaultdict(list)

def rate_limit_check(user_api_key, max_requests=100, window_minutes=60):
    """Limita requests por key (prevenir abuso)"""
    now = datetime.now()
    cutoff = now - timedelta(minutes=window_minutes)
    
    # Remove requests antigos
    request_count[user_api_key] = [
        ts for ts in request_count[user_api_key]
        if ts > cutoff
    ]
    
    # Check limit
    if len(request_count[user_api_key]) >= max_requests:
        raise ValueError(f"❌ Rate limit excedido: {max_requests}/{window_minutes}min")
    
    # Registrar request
    request_count[user_api_key].append(now)
```

---

## 📋 CHECKLIST DE SEGURANÇA

**Antes de commitar/deploy:**

- [ ] `.env` está no `.gitignore`
- [ ] Nenhum secret hardcoded no código
- [ ] Criei `.env.example` (sem valores reais)
- [ ] Testei que `.env` não aparece no `git status`
- [ ] Keys têm permissões mínimas (não admin)
- [ ] Validação de credentials na inicialização
- [ ] Logs não vazam secrets
- [ ] Implementei rate limiting (se aplicável)
- [ ] Sei como revogar keys se vazar
- [ ] Tenho plano de rotation de keys

---

## 🚨 INCIDENTES DE SEGURANÇA

### Se suspeitar de vazamento:

**1. Revogar TODAS as keys imediatamente**
- Não esperar confirmar vazamento
- Melhor safe than sorry

**2. Auditar logs:**
```bash
# Buscar uso anormal
grep "API_KEY" logs/*.log
grep "401 Unauthorized" logs/*.log  # Tentativas de acesso não autorizado
```

**3. Gerar novas keys**
- Usar nomes diferentes (facilita tracking)
- Documentar motivo da troca

**4. Investigar causa raiz:**
- Key foi committada?
- Servidor comprometido?
- Phishing/social engineering?

**5. Implementar controles:**
- GitHub secret scanning (notifica se commitar secret)
- Pre-commit hooks (prevenir commits com secrets)
- 2FA em todos serviços

---

## 🛠️ FERRAMENTAS ÚTEIS

### 1. Git-secrets (prevenir commits)

```bash
# Instalar
brew install git-secrets  # Mac
# ou: https://github.com/awslabs/git-secrets

# Configurar no repo
git secrets --install
git secrets --register-aws  # Padrões AWS
git secrets --add 'sk-[a-zA-Z0-9]{32}'  # Custom pattern

# Testar
echo "sk-abc123xyz789" > test.txt
git add test.txt
git commit -m "test"
# → Bloqueado! "test.txt:1:sk-abc123xyz789"
```

---

### 2. Trufflehog (escanear histórico)

```bash
# Instalar
pip install trufflehog

# Escanear repo
trufflehog filesystem . --json > secrets-found.json

# Review output
cat secrets-found.json
```

---

### 3. GitHub Secret Scanning

**Ativar em Settings → Security → Secret scanning**

- Detecta +200 tipos de tokens
- Notifica automaticamente quando secret é committado
- Parceiros (OpenAI, AWS, Stripe) revogam keys automaticamente

---

## 💡 DICAS FINAIS

1. **Paranoia saudável:** Sempre assume que código pode vazar
2. **Defense in depth:** Múltiplas camadas de proteção
3. **Least privilege:** Menor permissão possível que funciona
4. **Audit everything:** Logs de quem acessa o quê
5. **Automate rotation:** Keys não devem viver para sempre

---

**Segurança não é feature opcional. É requisito fundamental.** 🔐

---

**Recursos:**
- [OWASP Top 10](https://owasp.org/Top10/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)

