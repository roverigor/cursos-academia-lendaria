# Template: Script de Automação Base

**Descrição:** Estrutura base para qualquer script Python com error handling e logs profissionais.

**Use este template para:** Qualquer automação (scraping, processamento, API calls)

---

## 📋 COMO USAR

1. Copie este template
2. Substitua `NOME_TAREFA` e `funcao_principal()` pela sua lógica
3. Customize as configurações no topo
4. Execute e ajuste conforme necessário

---

## 🔧 CÓDIGO TEMPLATE

```python
#!/usr/bin/env python3
"""
NOME DA AUTOMAÇÃO
==================

Descrição: [Descreva o que este script faz]

Uso:
    python script.py

Dependências:
    pip install [lista de pacotes]

Autor: [Seu nome]
Data: [Data criação]
"""

import sys
import logging
from datetime import datetime
from pathlib import Path

# ===== CONFIGURAÇÕES =====

# Caminhos
BASE_DIR = Path(__file__).parent
DATA_DIR = BASE_DIR / "data"
LOGS_DIR = BASE_DIR / "logs"
OUTPUT_DIR = BASE_DIR / "output"

# Criar diretórios se não existem
DATA_DIR.mkdir(exist_ok=True)
LOGS_DIR.mkdir(exist_ok=True)
OUTPUT_DIR.mkdir(exist_ok=True)

# Configuração de logs
LOG_FILE = LOGS_DIR / f"automacao_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
LOG_LEVEL = logging.INFO  # DEBUG, INFO, WARNING, ERROR, CRITICAL

# Configurações específicas da automação
CONFIG = {
    'max_tentativas': 3,
    'timeout_segundos': 30,
    'modo_debug': False,
}


# ===== SETUP DE LOGGING =====

def setup_logging():
    """Configura sistema de logs (console + arquivo)"""
    logging.basicConfig(
        level=LOG_LEVEL,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(LOG_FILE, encoding='utf-8'),
            logging.StreamHandler(sys.stdout)
        ]
    )
    return logging.getLogger(__name__)


logger = setup_logging()


# ===== FUNÇÕES AUXILIARES =====

def validar_prerequisites():
    """Valida que todos pré-requisitos estão atendidos"""
    logger.info("🔍 Validando pré-requisitos...")
    
    # Exemplo: Verificar se arquivo existe
    # if not (DATA_DIR / "input.csv").exists():
    #     logger.error("❌ Arquivo input.csv não encontrado!")
    #     return False
    
    # Exemplo: Verificar variáveis de ambiente
    # if not os.getenv('API_KEY'):
    #     logger.error("❌ API_KEY não configurada!")
    #     return False
    
    logger.info("✅ Todos pré-requisitos atendidos")
    return True


def retry_on_error(func, max_tentativas=3, delay=2):
    """
    Executa função com retry automático em caso de erro
    
    Args:
        func: Função a ser executada
        max_tentativas: Número máximo de tentativas
        delay: Segundos entre tentativas
    
    Returns:
        Resultado da função ou None se todas tentativas falharem
    """
    import time
    
    for tentativa in range(1, max_tentativas + 1):
        try:
            logger.debug(f"Tentativa {tentativa}/{max_tentativas}...")
            resultado = func()
            return resultado
        
        except Exception as e:
            logger.warning(f"⚠️ Tentativa {tentativa} falhou: {e}")
            
            if tentativa < max_tentativas:
                logger.info(f"⏳ Aguardando {delay}s antes de tentar novamente...")
                time.sleep(delay)
            else:
                logger.error(f"❌ Todas {max_tentativas} tentativas falharam")
                return None


def salvar_resultado(dados, nome_arquivo):
    """
    Salva resultado em arquivo
    
    Args:
        dados: Dados a serem salvos (dict, list, str)
        nome_arquivo: Nome do arquivo de output
    """
    import json
    
    output_path = OUTPUT_DIR / nome_arquivo
    
    try:
        # Se for dict/list, salva como JSON
        if isinstance(dados, (dict, list)):
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(dados, f, indent=2, ensure_ascii=False)
        
        # Se for string, salva como texto
        else:
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(str(dados))
        
        logger.info(f"💾 Resultado salvo: {output_path}")
        return True
    
    except Exception as e:
        logger.error(f"❌ Erro ao salvar resultado: {e}")
        return False


# ===== FUNÇÃO PRINCIPAL =====

def executar_automacao():
    """
    LÓGICA PRINCIPAL DA AUTOMAÇÃO
    
    Substitua este conteúdo pela sua automação específica
    """
    logger.info("🚀 Iniciando automação...")
    
    try:
        # ===== ETAPA 1: Preparação =====
        logger.info("📋 Etapa 1: Preparação")
        
        # Sua lógica aqui
        # Exemplo: Carregar dados
        # dados = carregar_dados_fonte()
        
        
        # ===== ETAPA 2: Processamento =====
        logger.info("⚙️ Etapa 2: Processamento")
        
        # Sua lógica aqui
        # Exemplo: Processar dados
        # resultado = processar_dados(dados)
        
        resultado = {"status": "sucesso", "exemplo": True}
        
        
        # ===== ETAPA 3: Finalização =====
        logger.info("💾 Etapa 3: Salvando resultados")
        
        salvar_resultado(
            resultado,
            f"resultado_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        )
        
        
        # ===== RESUMO =====
        logger.info("=" * 60)
        logger.info("✅ AUTOMAÇÃO CONCLUÍDA COM SUCESSO!")
        logger.info(f"📊 Resultados salvos em: {OUTPUT_DIR}")
        logger.info(f"📝 Logs salvos em: {LOG_FILE}")
        logger.info("=" * 60)
        
        return True
    
    except KeyboardInterrupt:
        logger.warning("⚠️ Automação interrompida pelo usuário (Ctrl+C)")
        return False
    
    except Exception as e:
        logger.error(f"❌ ERRO CRÍTICO: {e}", exc_info=True)
        return False


# ===== ENTRY POINT =====

def main():
    """Entry point principal do script"""
    inicio = datetime.now()
    
    logger.info("=" * 60)
    logger.info("🤖 AUTOMAÇÃO INICIADA")
    logger.info(f"⏰ Data/Hora: {inicio.strftime('%Y-%m-%d %H:%M:%S')}")
    logger.info("=" * 60)
    
    # Validar pré-requisitos
    if not validar_prerequisites():
        logger.error("❌ Pré-requisitos não atendidos. Encerrando.")
        sys.exit(1)
    
    # Executar automação
    sucesso = executar_automacao()
    
    # Calcular duração
    duracao = datetime.now() - inicio
    
    logger.info("=" * 60)
    logger.info(f"⏱️ Duração total: {duracao}")
    logger.info("=" * 60)
    
    # Exit code
    sys.exit(0 if sucesso else 1)


if __name__ == "__main__":
    main()
```

---

## 📚 RECURSOS DO TEMPLATE

### ✅ O QUE JÁ ESTÁ INCLUÍDO

1. **Logging profissional**
   - Console + arquivo
   - Timestamp automático
   - Níveis de log (INFO, WARNING, ERROR)

2. **Estrutura de pastas**
   - `data/` → inputs
   - `logs/` → logs de execução
   - `output/` → resultados
   - Criação automática se não existem

3. **Error handling robusto**
   - Try/except em função principal
   - Retry automático com `retry_on_error()`
   - Validação de pré-requisitos

4. **Helpers úteis**
   - `salvar_resultado()` → salva JSON/texto
   - `validar_prerequisites()` → checagens iniciais
   - `retry_on_error()` → tentativas múltiplas

5. **Boas práticas**
   - Docstrings
   - Type hints (opcional)
   - Configurações centralizadas
   - Exit codes corretos

---

## 🎯 EXEMPLOS DE USO

### Exemplo 1: Scraping

```python
def executar_automacao():
    logger.info("🕷️ Iniciando scraping...")
    
    urls = [
        'https://exemplo1.com',
        'https://exemplo2.com',
    ]
    
    resultados = []
    for url in urls:
        logger.info(f"🔍 Processando: {url}")
        
        # Usar retry automático
        dados = retry_on_error(
            lambda: fazer_scraping(url),
            max_tentativas=3
        )
        
        if dados:
            resultados.append(dados)
    
    salvar_resultado(resultados, 'scraping_resultado.json')
    return True
```

### Exemplo 2: Processamento Batch

```python
def executar_automacao():
    logger.info("📦 Processamento em massa...")
    
    arquivos_pdf = list(DATA_DIR.glob("*.pdf"))
    logger.info(f"📄 {len(arquivos_pdf)} PDFs encontrados")
    
    resultados = []
    for pdf in arquivos_pdf:
        try:
            dados = extrair_dados_pdf(pdf)
            resultados.append(dados)
            logger.info(f"✅ {pdf.name} processado")
        except Exception as e:
            logger.error(f"❌ Erro em {pdf.name}: {e}")
    
    salvar_resultado(resultados, 'batch_resultado.csv')
    return True
```

---

## 💡 DICAS PRO

### Adicionar Progress Bar

```python
from tqdm import tqdm

for item in tqdm(lista, desc="Processando"):
    # seu código
    pass
```

### Usar Variáveis de Ambiente

```python
import os
from dotenv import load_dotenv

load_dotenv()  # Carrega .env file

API_KEY = os.getenv('API_KEY')
if not API_KEY:
    logger.error("❌ API_KEY não configurada no .env")
    sys.exit(1)
```

### Enviar Notificação ao Finalizar

```python
def enviar_notificacao_slack(mensagem):
    import requests
    webhook_url = os.getenv('SLACK_WEBHOOK_URL')
    requests.post(webhook_url, json={'text': mensagem})

# No final da automação
enviar_notificacao_slack(f"✅ Automação concluída em {duracao}")
```

---

## 🐛 TROUBLESHOOTING

**Problema:** Script não encontra módulos  
**Solução:** `pip install -r requirements.txt`

**Problema:** Permissões negadas ao salvar arquivo  
**Solução:** Verificar permissões da pasta output/

**Problema:** Logs não aparecem no console  
**Solução:** Mudar `LOG_LEVEL = logging.DEBUG`

---

**Template criado por:** José Carlos Amorim  
**Curso:** Claude Code Expert  
**Versão:** 1.0

