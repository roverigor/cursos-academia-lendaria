#!/usr/bin/env python3
"""
Gerador de Metáforas - MAVE Framework
Sugere metáforas do cotidiano baseadas na estrutura de conceitos técnicos
"""

import sys
import json
from typing import List, Dict

# Banco de dados de metáforas por categoria
METAFORA_DB = {
    "hierarquia": [
        {
            "nome": "Restaurante (Chef → Estação → Receita)",
            "componentes": ["líder/decisor", "especialidades", "instruções"],
            "score": 0.9
        },
        {
            "nome": "Hospital (Médico → Departamento → Protocolo)",
            "componentes": ["especialista", "áreas", "procedimentos"],
            "score": 0.8
        }
    ],
    "fluxo": [
        {
            "nome": "Garçom (Cliente → Garçom → Cozinha)",
            "componentes": ["origem", "mediador", "destino"],
            "score": 0.9
        },
        {
            "nome": "Correios (Remetente → Carteiro → Destinatário)",
            "componentes": ["origem", "transporte", "destino"],
            "score": 0.85
        }
    ],
    "armazenamento": [
        {
            "nome": "Arquivo de Receitas (Arquivo → Pastas → Fichas)",
            "componentes": ["container", "categorias", "registros"],
            "score": 0.9
        },
        {
            "nome": "Biblioteca (Prédio → Seções → Livros)",
            "componentes": ["estrutura", "organização", "itens"],
            "score": 0.85
        }
    ],
    "processamento": [
        {
            "nome": "Cozinha (Ingredientes → Preparo → Prato)",
            "componentes": ["input", "transformação", "output"],
            "score": 0.9
        },
        {
            "nome": "Fábrica (Matéria-prima → Produção → Produto)",
            "componentes": ["input", "processo", "output"],
            "score": 0.85
        }
    ],
    "distribuido": [
        {
            "nome": "Franquia de Restaurantes (Filiais independentes)",
            "componentes": ["unidades", "autonomia", "padrão compartilhado"],
            "score": 0.85
        },
        {
            "nome": "Prédio de Apartamentos (Unidades independentes)",
            "componentes": ["módulos", "independência", "infraestrutura comum"],
            "score": 0.8
        }
    ]
}

def analisar_conceito(conceito: str) -> List[str]:
    """
    Analisa o conceito e identifica suas características estruturais
    """
    conceito_lower = conceito.lower()
    caracteristicas = []
    
    # Detectar hierarquia
    palavras_hierarquia = ["sistema", "agente", "skill", "componente", "módulo", "class"]
    if any(palavra in conceito_lower for palavra in palavras_hierarquia):
        caracteristicas.append("hierarquia")
    
    # Detectar fluxo
    palavras_fluxo = ["api", "request", "comunicação", "transmissão", "envio"]
    if any(palavra in conceito_lower for palavra in palavras_fluxo):
        caracteristicas.append("fluxo")
    
    # Detectar armazenamento
    palavras_armazenamento = ["database", "banco", "arquivo", "storage", "cache"]
    if any(palavra in conceito_lower for palavra in palavras_armazenamento):
        caracteristicas.append("armazenamento")
    
    # Detectar processamento
    palavras_processamento = ["processar", "transformar", "computar", "executar"]
    if any(palavra in conceito_lower for palavra in palavras_processamento):
        caracteristicas.append("processamento")
    
    # Detectar distribuído
    palavras_distribuido = ["distribuído", "microservice", "cluster", "node"]
    if any(palavra in conceito_lower for palavra in palavras_distribuido):
        caracteristicas.append("distribuido")
    
    return caracteristicas if caracteristicas else ["hierarquia"]  # default

def sugerir_metaforas(conceito: str, max_sugestoes: int = 5) -> List[Dict]:
    """
    Sugere metáforas baseadas no conceito técnico
    """
    caracteristicas = analisar_conceito(conceito)
    sugestoes = []
    
    for caract in caracteristicas:
        if caract in METAFORA_DB:
            sugestoes.extend(METAFORA_DB[caract])
    
    # Ordenar por score e limitar
    sugestoes.sort(key=lambda x: x["score"], reverse=True)
    return sugestoes[:max_sugestoes]

def formatar_saida(conceito: str, metaforas: List[Dict]) -> str:
    """
    Formata a saída de forma legível
    """
    output = [
        f"\n🎭 Metáforas sugeridas para: '{conceito}'",
        "=" * 60,
        ""
    ]
    
    for i, metafora in enumerate(metaforas, 1):
        output.append(f"{i}. {metafora['nome']}")
        output.append(f"   Componentes: {', '.join(metafora['componentes'])}")
        output.append(f"   Score de adequação: {metafora['score'] * 100:.0f}%")
        output.append("")
    
    output.append("💡 Dica: Escolha a metáfora cujos componentes melhor mapeiam")
    output.append("   para os componentes do seu conceito técnico.")
    output.append("")
    
    return "\n".join(output)

def main():
    if len(sys.argv) < 2:
        print("Uso: python gerar_metafora.py \"conceito técnico\"")
        print("\nExemplos:")
        print("  python gerar_metafora.py \"Skills System\"")
        print("  python gerar_metafora.py \"REST API\"")
        print("  python gerar_metafora.py \"Database com cache\"")
        sys.exit(1)
    
    conceito = " ".join(sys.argv[1:])
    metaforas = sugerir_metaforas(conceito)
    
    if not metaforas:
        print(f"❌ Não foi possível sugerir metáforas para: {conceito}")
        print("Tente descrever o conceito de forma diferente.")
        sys.exit(1)
    
    print(formatar_saida(conceito, metaforas))

if __name__ == "__main__":
    main()
