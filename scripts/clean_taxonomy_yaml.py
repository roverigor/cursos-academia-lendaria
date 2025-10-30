#!/usr/bin/env python3
"""
Script para limpar YAML de taxonomia removendo campos específicos.

Uso:
  python3 clean_taxonomy_yaml.py <arquivo_entrada> [arquivo_saída]

Campos removidos:
  - score_* (qualquer campo começando com score_)
  - classificacao
  - arquetipo
  - reconhecimento
  - densidade_fontes
  - aplicabilidade
"""

import yaml
import sys
from pathlib import Path
from typing import Any, Dict, List

FIELDS_TO_REMOVE = {
    'classificacao',
    'arquetipo',
    'reconhecimento',
    'densidade_fontes',
    'aplicabilidade',
}

def should_remove_field(field_name: str) -> bool:
    """Verifica se um campo deve ser removido."""
    if field_name in FIELDS_TO_REMOVE:
        return True
    if field_name.startswith('score_'):
        return True
    return False

def clean_dict(obj: Any) -> Any:
    """Remove campos indesejados recursivamente."""
    if isinstance(obj, dict):
        cleaned = {}
        for key, value in obj.items():
            if not should_remove_field(key):
                cleaned[key] = clean_dict(value)
        return cleaned
    elif isinstance(obj, list):
        return [clean_dict(item) for item in obj]
    else:
        return obj

def load_yaml(filepath: str) -> Any:
    """Carrega arquivo YAML."""
    with open(filepath, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

def save_yaml(data: Any, filepath: str) -> None:
    """Salva arquivo YAML com formatação limpa."""
    with open(filepath, 'w', encoding='utf-8') as f:
        yaml.dump(
            data,
            f,
            default_flow_style=False,
            allow_unicode=True,
            sort_keys=False,
            indent=2
        )

def count_removals(original: Any, cleaned: Any, prefix: str = '') -> Dict[str, int]:
    """Conta quantos campos foram removidos."""
    removed_count = {}

    if isinstance(original, dict):
        for key in original.keys():
            if should_remove_field(key):
                removed_count[key] = removed_count.get(key, 0) + 1

    return removed_count

def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else f"{Path(input_file).stem}_cleaned.yaml"

    # Validar arquivo de entrada
    input_path = Path(input_file)
    if not input_path.exists():
        print(f"❌ Arquivo não encontrado: {input_file}")
        sys.exit(1)

    print(f"📖 Carregando: {input_file}")
    try:
        data = load_yaml(input_file)
    except Exception as e:
        print(f"❌ Erro ao carregar YAML: {e}")
        sys.exit(1)

    # Limpeza
    print("🧹 Removendo campos...")
    cleaned_data = clean_dict(data)

    # Salvar
    print(f"💾 Salvando em: {output_file}")
    try:
        save_yaml(cleaned_data, output_file)
        print(f"✅ Arquivo limpo salvo com sucesso!")

        # Estatísticas
        if isinstance(data, dict):
            original_keys = set()
            cleaned_keys = set()

            def collect_keys(obj, keys_set):
                if isinstance(obj, dict):
                    keys_set.update(obj.keys())
                    for v in obj.values():
                        collect_keys(v, keys_set)
                elif isinstance(obj, list):
                    for item in obj:
                        collect_keys(item, keys_set)

            collect_keys(data, original_keys)
            collect_keys(cleaned_data, cleaned_keys)

            removed_keys = original_keys - cleaned_keys
            print(f"\n📊 Estatísticas:")
            print(f"   Campos únicos removidos: {len(removed_keys)}")
            if removed_keys:
                print(f"   Campos: {', '.join(sorted(removed_keys))}")

    except Exception as e:
        print(f"❌ Erro ao salvar YAML: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main()
