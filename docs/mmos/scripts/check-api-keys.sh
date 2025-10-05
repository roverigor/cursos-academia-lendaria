#!/bin/bash

# =============================================================================
# CHECK API KEYS - Verifica quais APIs estão configuradas
# =============================================================================

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Caminho do .env
ENV_FILE="$(dirname "$0")/../.env"

echo -e "${BLUE}==============================================================================${NC}"
echo -e "${BLUE}   VERIFICAÇÃO DE API KEYS - Clones Lendário.ai${NC}"
echo -e "${BLUE}==============================================================================${NC}"
echo ""

# Verificar se .env existe
if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}❌ Arquivo .env não encontrado!${NC}"
    echo -e "${YELLOW}   Execute: cp .env.example .env${NC}"
    exit 1
fi

# Função para verificar se uma key está configurada
check_key() {
    local key_name=$1
    local key_value=$(grep "^${key_name}=" "$ENV_FILE" | cut -d'=' -f2)

    if [ -z "$key_value" ] || [[ "$key_value" == *"your-"* ]]; then
        echo -e "${RED}❌${NC} $key_name"
        return 1
    else
        # Mostrar apenas primeiros/últimos chars
        local masked="${key_value:0:8}...${key_value: -4}"
        echo -e "${GREEN}✅${NC} $key_name ${BLUE}($masked)${NC}"
        return 0
    fi
}

echo -e "${YELLOW}🔴 APIS CRÍTICAS:${NC}"
check_key "ANTHROPIC_API_KEY"
echo ""

echo -e "${YELLOW}🟡 APIS IMPORTANTES:${NC}"
check_key "BRAVE_API_KEY"
check_key "YOUTUBE_API_KEY"
check_key "ASSEMBLYAI_API_KEY"
check_key "GITHUB_TOKEN"
echo ""

echo -e "${YELLOW}🟢 APIS OPCIONAIS (LLMs Alternativos):${NC}"
check_key "OPENAI_API_KEY"
check_key "PERPLEXITY_API_KEY"
check_key "GOOGLE_API_KEY"
echo ""

echo -e "${YELLOW}🔍 APIS OPCIONAIS (Research):${NC}"
check_key "EXA_API_KEY"
check_key "SERPAPI_KEY"
echo ""

echo -e "${YELLOW}🗄️ APIS OPCIONAIS (Database):${NC}"
check_key "SUPABASE_URL"
check_key "PINECONE_API_KEY"
echo ""

echo -e "${BLUE}==============================================================================${NC}"
echo -e "${BLUE}   RESUMO${NC}"
echo -e "${BLUE}==============================================================================${NC}"

# Contar keys configuradas
total_keys=$(grep -c "^[A-Z].*_KEY=" "$ENV_FILE")
configured_keys=$(grep "^[A-Z].*_KEY=" "$ENV_FILE" | grep -v "your-" | wc -l | tr -d ' ')

echo ""
echo -e "📊 APIs Configuradas: ${GREEN}${configured_keys}${NC} de ${total_keys}"
echo ""

# Recomendações
if [ "$configured_keys" -eq 0 ]; then
    echo -e "${RED}⚠️  NENHUMA API CONFIGURADA!${NC}"
    echo -e "${YELLOW}   Consulte: docs/API_SETUP_GUIDE.md${NC}"
elif [ "$configured_keys" -lt 3 ]; then
    echo -e "${YELLOW}⚠️  Mínimo recomendado: ANTHROPIC + BRAVE + GITHUB${NC}"
    echo -e "${YELLOW}   Consulte: docs/API_SETUP_GUIDE.md${NC}"
else
    echo -e "${GREEN}✅ Configuração mínima OK!${NC}"
fi

echo ""
echo -e "${BLUE}==============================================================================${NC}"
