#!/usr/bin/env bash
# Lightweight launcher that mimics Claude's slash-command picker for Codex CLI.
# Lists Markdown commands from `.codex/commands/` (symlinked to `.claude/commands/`)
# and runs Codex with the chosen prompt.

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
commands_dir="$repo_root/.codex/commands"

if [[ ! -d "$commands_dir" ]]; then
  echo "❌ Diretório de comandos não encontrado em $commands_dir" >&2
  exit 1
fi

command_files=()
relative_paths=()
while IFS= read -r file; do
  [[ -z "$file" ]] && continue
  command_files+=("$file")
  relative_paths+=("${file#$commands_dir/}")
done < <(LC_ALL=C find -L "$commands_dir" -type f -name '*.md' | LC_ALL=C sort)

if [[ ${#command_files[@]} -eq 0 ]]; then
  echo "❌ Nenhum comando Markdown localizado em $commands_dir" >&2
  exit 1
fi

launch_codex() {
  local file="$1"
  local rel="${file#$commands_dir/}"
  echo "🚀 Executando Codex com comando: $rel"
  codex "$(cat "$file")"
}

print_usage() {
  cat <<'EOF'
Uso: scripts/codex-command.sh [CAMINHO_RELATIVO]

Sem argumentos, abre um menu interativo listando os comandos encontrados em .codex/commands/.
Você também pode informar o caminho relativo (ex.: MMOS/tasks/execute-mmos-pipeline.md)
para executar diretamente o comando correspondente.
EOF
}

if [[ $# -gt 0 ]]; then
  case "$1" in
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      target="$commands_dir/$1"
      if [[ -f "$target" ]]; then
        launch_codex "$target"
        exit 0
      else
        echo "❌ Comando não encontrado: $1" >&2
        exit 1
      fi
      ;;
  esac
fi

if command -v fzf >/dev/null 2>&1; then
  choice="$(
    printf '%s\n' "${relative_paths[@]}" |
      fzf --prompt='/ ' --header='Digite para filtrar e pressione Enter' \
          --preview-window='down:60%' \
          --preview="sed -n '1,80p' \"$commands_dir/{}\""
  )"
  if [[ -z "${choice:-}" ]]; then
    echo "Nenhum comando selecionado."
    exit 0
  fi
  launch_codex "$commands_dir/$choice"
  exit 0
fi

PS3=$'\nSelecione um comando (0 para sair): '
select choice in "${relative_paths[@]}"; do
  if [[ -z "${choice:-}" ]]; then
    echo "Opção inválida. Tente novamente." >&2
    continue
  fi

  launch_codex "$commands_dir/$choice"
  break
done
