#!/bin/bash

# Script wrapper para limpeza de taxonomia YAML
# Uso: ./clean-taxonomy.sh <arquivo_entrada> [arquivo_saída]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="${SCRIPT_DIR}/clean_taxonomy_yaml.py"

if [ ! -f "$PYTHON_SCRIPT" ]; then
  echo "❌ Erro: clean_taxonomy_yaml.py não encontrado em $PYTHON_SCRIPT"
  exit 1
fi

if ! command -v python3 &> /dev/null; then
  echo "❌ Erro: python3 não está instalado"
  exit 1
fi

# Verificar dependência PyYAML
if ! python3 -c "import yaml" 2>/dev/null; then
  echo "⚠️  Instalando PyYAML..."
  pip install pyyaml
fi

python3 "$PYTHON_SCRIPT" "$@"
