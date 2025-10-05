#!/bin/bash

# Script de Validação de Logs - Clones Lendário.ai
# Verifica se a convenção de logs está sendo seguida

echo "🔍 Validando Convenção de Logs..."
echo "=================================="

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contador de erros
ERRORS=0

# 1. Verificar se pasta logs existe
if [ ! -d "logs" ]; then
    echo -e "${RED}❌ ERRO: Pasta 'logs/' não existe${NC}"
    ((ERRORS++))
else
    echo -e "${GREEN}✅ Pasta 'logs/' existe${NC}"
fi

# 2. Verificar arquivos não permitidos em clones/
echo ""
echo "🔍 Verificando pasta clones/..."

FORBIDDEN_FILES=$(find clones/ -maxdepth 1 -name "*.md" | grep -v "README\|CHANGELOG" | wc -l)
if [ $FORBIDDEN_FILES -gt 0 ]; then
    echo -e "${RED}❌ ERRO: Arquivos não permitidos em clones/:${NC}"
    find clones/ -maxdepth 1 -name "*.md" | grep -v "README\|CHANGELOG" | while read file; do
        echo -e "${RED}   - $(basename "$file")${NC}"
    done
    ((ERRORS++))
else
    echo -e "${GREEN}✅ Pasta clones/ está limpa${NC}"
fi

# 3. Verificar formato dos logs
echo ""
echo "🔍 Verificando formato dos logs..."

if [ -d "logs" ]; then
    LOG_COUNT=0
    INVALID_LOG_COUNT=0

    for logfile in logs/*.md; do
        if [ -f "$logfile" ]; then
            LOG_COUNT=$((LOG_COUNT + 1))
            filename=$(basename "$logfile")

            # Verificar formato YYYYMMDD-HHMM-NOME.md
            if [[ ! $filename =~ ^[0-9]{8}-[0-9]{4}-.*\.md$ ]]; then
                echo -e "${RED}❌ Formato inválido: $filename${NC}"
                echo -e "${YELLOW}   Deve ser: YYYYMMDD-HHMM-NOME.md${NC}"
                INVALID_LOG_COUNT=$((INVALID_LOG_COUNT + 1))
                ((ERRORS++))
            fi
        fi
    done

    if [ $INVALID_LOG_COUNT -eq 0 ] && [ $LOG_COUNT -gt 0 ]; then
        echo -e "${GREEN}✅ Todos os $LOG_COUNT logs seguem o formato correto${NC}"
    elif [ $LOG_COUNT -eq 0 ]; then
        echo -e "${YELLOW}⚠️  Nenhum log encontrado${NC}"
    fi
fi

# 4. Verificar arquivos permitidos em clones/
echo ""
echo "🔍 Verificando arquivos permitidos em clones/..."

ALLOWED_FILES=0
if [ -f "clones/README.md" ]; then
    echo -e "${GREEN}✅ README.md presente${NC}"
    ((ALLOWED_FILES++))
fi

if [ -f "clones/CHANGELOG.md" ]; then
    echo -e "${GREEN}✅ CHANGELOG.md presente${NC}"
    ((ALLOWED_FILES++))
fi

# 5. Resultado final
echo ""
echo "=================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}🎉 VALIDAÇÃO PASSOU! Convenção de logs OK${NC}"
    echo -e "${GREEN}   - Pasta clones/ limpa${NC}"
    echo -e "${GREEN}   - Logs em formato correto${NC}"
    echo -e "${GREEN}   - Estrutura conforme${NC}"
    exit 0
else
    echo -e "${RED}❌ VALIDAÇÃO FALHOU! $ERRORS erro(s) encontrado(s)${NC}"
    echo -e "${YELLOW}   Corrija os erros antes de continuar${NC}"
    exit 1
fi