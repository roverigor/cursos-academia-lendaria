#!/bin/bash
# Analisador de Complexidade - MAVE Framework
# Calcula score de complexidade e sugere quantas camadas de progressive disclosure usar

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para contar conceitos técnicos
contar_conceitos() {
    local arquivo=$1
    local count=0
    
    # Termos técnicos que indicam complexidade
    termos=("API" "database" "server" "client" "cache" "queue" "microservice" 
            "container" "cluster" "node" "endpoint" "protocol" "algorithm"
            "function" "class" "method" "interface" "abstract" "inheritance")
    
    for termo in "${termos[@]}"; do
        matches=$(grep -io "$termo" "$arquivo" | wc -l)
        count=$((count + matches))
    done
    
    echo $count
}

# Função para contar componentes estruturais
contar_componentes() {
    local arquivo=$1
    
    # Contar níveis de hierarquia (indentação, bullets, números)
    niveis=$(grep -E "^(#{1,6}|[*-]|\d+\.)" "$arquivo" | wc -l)
    
    echo $niveis
}

# Função para calcular score de complexidade
calcular_score() {
    local conceitos=$1
    local componentes=$2
    local palavras=$3
    
    # Fórmula: (conceitos * 2) + (componentes * 1.5) + (palavras / 100)
    score=$(echo "scale=2; ($conceitos * 2) + ($componentes * 1.5) + ($palavras / 100)" | bc)
    
    echo $score
}

# Função para sugerir número de camadas
sugerir_camadas() {
    local score=$1
    
    if (( $(echo "$score < 10" | bc -l) )); then
        echo "2-3"
    elif (( $(echo "$score < 20" | bc -l) )); then
        echo "3-4"
    elif (( $(echo "$score < 30" | bc -l) )); then
        echo "4-5"
    else
        echo "5-7"
    fi
}

# Função para sugerir padrões MAVE
sugerir_padroes() {
    local score=$1
    
    echo -e "\n${BLUE}📋 Recomendações MAVE:${NC}\n"
    
    if (( $(echo "$score < 10" | bc -l) )); then
        echo "  M - Metáfora simples (1 conceito do cotidiano)"
        echo "  A - Animação básica (2-3 steps)"
        echo "  V - Layout linear (top-to-bottom)"
        echo "  E - Interação mínima (1-2 botões)"
    elif (( $(echo "$score < 20" | bc -l) )); then
        echo "  M - Metáfora com 2-3 componentes"
        echo "  A - Animação step-by-step (3-4 steps)"
        echo "  V - Layout grid 2 colunas"
        echo "  E - Toggles + 1 input interativo"
    elif (( $(echo "$score < 30" | bc -l) )); then
        echo "  M - Metáfora detalhada (4-5 componentes)"
        echo "  A - Animação com highlight (4-5 steps)"
        echo "  V - Layout complexo (múltiplos grids)"
        echo "  E - Chat + toggles + visualização de contexto"
    else
        echo "  M - Metáfora elaborada (6+ componentes)"
        echo "  A - Animação multinível (5-7 steps)"
        echo "  V - Layout hierárquico com zoom"
        echo "  E - Interface completa (chat + forms + drag&drop)"
    fi
}

# Função principal
main() {
    if [ $# -eq 0 ]; then
        echo -e "${YELLOW}Uso:${NC} bash analisar_complexidade.sh <arquivo.md>"
        echo ""
        echo -e "${YELLOW}Exemplos:${NC}"
        echo "  bash analisar_complexidade.sh conceito.md"
        echo "  bash analisar_complexidade.sh explicacao.txt"
        exit 1
    fi
    
    arquivo=$1
    
    if [ ! -f "$arquivo" ]; then
        echo -e "${RED}❌ Arquivo não encontrado:${NC} $arquivo"
        exit 1
    fi
    
    echo ""
    echo -e "${GREEN}🔬 Analisando complexidade de:${NC} $(basename $arquivo)"
    echo "================================================================"
    echo ""
    
    # Coletar métricas
    conceitos=$(contar_conceitos "$arquivo")
    componentes=$(contar_componentes "$arquivo")
    palavras=$(wc -w < "$arquivo")
    score=$(calcular_score $conceitos $componentes $palavras)
    camadas=$(sugerir_camadas $score)
    
    # Exibir resultados
    echo -e "${BLUE}📊 Métricas:${NC}"
    echo "  Conceitos técnicos encontrados: $conceitos"
    echo "  Componentes estruturais: $componentes"
    echo "  Total de palavras: $palavras"
    echo ""
    echo -e "${BLUE}🎯 Score de Complexidade:${NC} $score"
    echo ""
    
    # Classificação
    if (( $(echo "$score < 10" | bc -l) )); then
        echo -e "${GREEN}✅ BAIXA COMPLEXIDADE${NC}"
        echo "   Este conceito é relativamente simples."
    elif (( $(echo "$score < 20" | bc -l) )); then
        echo -e "${YELLOW}⚠️  COMPLEXIDADE MÉDIA${NC}"
        echo "   Este conceito requer explicação estruturada."
    elif (( $(echo "$score < 30" | bc -l) )); then
        echo -e "${RED}⚠️  ALTA COMPLEXIDADE${NC}"
        echo "   Este conceito precisa de progressive disclosure robusto."
    else
        echo -e "${RED}🔥 COMPLEXIDADE MUITO ALTA${NC}"
        echo "   Este conceito exige abordagem multinível completa."
    fi
    
    echo ""
    echo -e "${BLUE}🎨 Progressive Disclosure sugerido:${NC}"
    echo "   Usar $camadas camadas de revelação"
    echo ""
    
    sugerir_padroes $score
    
    echo ""
    echo -e "${BLUE}💡 Próximos passos:${NC}"
    echo "  1. Escolher metáfora apropriada (use: python gerar_metafora.py)"
    echo "  2. Criar wireframe com $camadas camadas"
    echo "  3. Aplicar design system minimal-brand"
    echo "  4. Validar cores (use: node validar_cores.js)"
    echo ""
}

main "$@"
