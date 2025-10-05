#!/bin/bash
# Mind validation script
# Usage: ./validate-mind.sh mind_name

if [ -z "\$1" ]; then
    echo "❌ Error: Mind name is required"
    echo "Usage: ./validate-mind.sh mind_name"
    exit 1
fi

MIND_NAME=\$1
MIND_PATH="./\$MIND_NAME"

if [ ! -d "\$MIND_PATH" ]; then
    echo "❌ Erro: Mind $MIND_NAME não encontrado"
    exit 1
fi

echo "🔍 Validando mind: \$MIND_NAME"
echo "📁 Caminho: \$MIND_PATH"
echo

ERRORS=0
WARNINGS=0

# Função para check obrigatório
check_required() {
    if [ -e "\$MIND_PATH/\$1" ]; then
        echo "✅ \$1"
    else
        echo "❌ \$1 (OBRIGATÓRIO)"
        ((ERRORS++))
    fi
}

# Função para check recomendado
check_recommended() {
    if [ -e "\$MIND_PATH/\$1" ]; then
        echo "✅ \$1"
    else
        echo "⚠️  \$1 (RECOMENDADO)"
        ((WARNINGS++))
    fi
}

# Função para check proibido
check_forbidden() {
    if find "\$MIND_PATH" -name "\$1" 2>/dev/null | grep -q .; then
        echo "❌ Encontrado arquivo proibido: \$1"
        ((ERRORS++))
    else
        echo "✅ Sem arquivos \$1"
    fi
}

echo "📁 ESTRUTURA DE PASTAS"
echo "====================="
check_required "analysis"
check_required "docs"
check_required "frameworks"
check_required "logs"
check_required "sources"
check_required "templates"
check_required "sources/books"
check_required "sources/interviews"
check_required "sources/speeches"
check_required "sources/articles"
check_required "sources/social-media"
check_required "sources/videos"

echo
echo "📄 ARQUIVOS OBRIGATÓRIOS"
echo "========================"
check_required "docs/README.md"
check_required "docs/PRD.md"
check_required "logs/README.md"
check_recommended "analysis/personality-profile.json"

echo
echo "🚫 VERIFICAÇÃO DE ARQUIVOS PROIBIDOS"
echo "===================================="
check_forbidden "*.py"
check_forbidden "*.js"
check_forbidden "*.sh"
check_forbidden "*.bat"

# Verificar logs na pasta raiz
if find "\$MIND_PATH" -maxdepth 1 -name "*REPORT*" -o -name "*LOG*" -o -name "*PLAN*" 2>/dev/null | grep -q .; then
    echo "❌ Encontrados logs na pasta raiz"
    ((ERRORS++))
else
    echo "✅ Sem logs na pasta raiz"
fi

echo
echo "📋 VERIFICAÇÃO DE CONVENÇÕES"  
echo "============================="

# Verificar nomenclatura de logs
if [ -d "\$MIND_PATH/logs" ]; then
    INVALID_LOGS=\$(find "\$MIND_PATH/logs" -name "*.md" ! -name "README.md" ! -name "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-*.md" 2>/dev/null)
    if [ -n "\$INVALID_LOGS" ]; then
        echo "⚠️  Logs sem convenção timestamp:"
        echo "\$INVALID_LOGS"
        ((WARNINGS++))
    else
        echo "✅ Convenção de logs respeitada"
    fi
fi

# Verificar se README tem conteúdo
if [ -f "\$MIND_PATH/docs/README.md" ]; then
    if [ \$(wc -l < "\$MIND_PATH/docs/README.md") -gt 10 ]; then
        echo "✅ README com conteúdo adequado"
    else
        echo "⚠️  README muito simples"
        ((WARNINGS++))
    fi
fi

echo
echo "📊 RESUMO DA VALIDAÇÃO"
echo "====================="
echo "Mind: \$MIND_NAME"
echo "Erros: \$ERRORS"
echo "Avisos: \$WARNINGS"

if [ \$ERRORS -eq 0 ] && [ \$WARNINGS -eq 0 ]; then
    echo "🎉 Mind PERFEITO! Segue todas as boas práticas."
    exit 0
elif [ \$ERRORS -eq 0 ]; then
    echo "✅ Mind VÁLIDO com pequenos avisos."
    exit 0
else
    echo "❌ Mind tem ERROS que precisam ser corrigidos."
    exit 1
fi

