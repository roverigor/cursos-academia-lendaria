#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"
MMOS_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CATALOG="${MMOS_ROOT}/prompts.yaml"
LOG_DIR="${MMOS_ROOT}/logs"

usage() {
  cat <<USAGE
Uso: aios-launcher.sh --prompt <id> [--mind <nome>] [--user <operador>] [--dry-run] [--list]

Opções:
  --prompt <id>   Identificador do prompt (por exemplo, analysis_core_obsessions)
  --mind <nome>   Nome do mind existente em minds/<nome>
  --user <nome>   Operador que está executando o launcher (default: usuário atual)
  --dry-run       Não grava log, apenas exibe briefing
  --list          Lista todos os prompts disponíveis
  -h, --help      Exibe esta ajuda
USAGE
}

LIST=false
PROMPT_ID=""
MIND=""
USER_NAME="${USER:-$(whoami)}"
DRY_RUN=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --prompt)
      PROMPT_ID="$2"
      shift 2
      ;;
    --mind)
      MIND="$2"
      shift 2
      ;;
    --user)
      USER_NAME="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --list)
      LIST=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Parâmetro desconhecido: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ ! -f "$CATALOG" ]]; then
  echo "Catálogo de prompts não encontrado em $CATALOG" >&2
  exit 1
fi

if [[ "$LIST" == true || -z "$PROMPT_ID" ]]; then
  python - "$CATALOG" <<'PY'
import sys, yaml
from collections import defaultdict

catalog_path = sys.argv[1]
with open(catalog_path) as fh:
    data = yaml.safe_load(fh)
entries = data.get('prompts', [])
phases = defaultdict(list)
for entry in entries:
    phases[entry.get('phase', 'desconhecido')].append(entry['id'])

for phase in sorted(phases.keys()):
    print(f"{phase.capitalize()}:")
    for pid in sorted(phases[phase]):
        print(f"  - {pid}")
PY
  exit 0
fi

# Recuperar metadados do prompt
metadata_json=$(python - "$PROMPT_ID" "$CATALOG" <<'PY'
import sys, yaml, json, difflib, pathlib

prompt_id = sys.argv[1]
catalog_path = sys.argv[2]

with open(catalog_path) as fh:
    entries = yaml.safe_load(fh).get('prompts', [])

normal = prompt_id.replace('-', '_')
base = normal.split('/')[-1].replace('.md', '')

matches = [e for e in entries if e['id'] == prompt_id]
if not matches:
    matches = [e for e in entries if e['id'] == normal]
if not matches:
    matches = [e for e in entries if e['id'] == base]
if not matches:
    matches = [e for e in entries if e['file'].split('/')[-1].replace('.md', '') == base]
if not matches:
    matches = [e for e in entries if e['id'].startswith(base)]

if len(matches) == 1:
    print(json.dumps({"status": "ok", "entry": matches[0]}))
    sys.exit(0)
elif len(matches) > 1:
    print(json.dumps({"status": "multi", "matches": [e['id'] for e in matches]}))
    sys.exit(0)
else:
    ids = [e['id'] for e in entries]
    suggestions = difflib.get_close_matches(base, ids, n=8)
    print(json.dumps({"status": "missing", "matches": suggestions or ids[:8]}))
PY)

status=$(python - "$metadata_json" <<'PY'
import json, sys
payload = json.loads(sys.argv[1])
print(payload["status"])
PY)

if [[ "$status" == "multi" ]]; then
  echo "Mais de um prompt corresponde ao identificador '$PROMPT_ID'. Escolha um dos seguintes:" >&2
  python - "$metadata_json" <<'PY'
import json, sys
payload = json.loads(sys.argv[1])
for pid in payload.get("matches", []):
    print(f"  - {pid}")
PY
  exit 1
elif [[ "$status" == "missing" ]]; then
  echo "Prompt '$PROMPT_ID' não encontrado. Sugestões:" >&2
  python - "$metadata_json" <<'PY'
import json, sys
payload = json.loads(sys.argv[1])
for pid in payload.get("matches", []):
    print(f"  - {pid}")
PY
  exit 1
fi

# Extrair campos do entry
eval "$(python - "$metadata_json" <<'PY'
import json, sys
payload = json.loads(sys.argv[1])
entry = payload["entry"]

def esc(value):
    return value.replace('\\', r'\\').replace('"', r'\"')

print(f'PROMPT_ID_REAL="{esc(entry.get("id", ""))}"')
print(f'PHASE="{esc(entry.get("phase", ""))}"')
print(f'PROMPT_FILE="{esc(entry.get("file", ""))}"')
print(f'PROMPT_TITLE="{esc(entry.get("title", ""))}"')
order = entry.get("order", "")
print(f'PROMPT_ORDER="{order}"')
print(f'PROMPT_AGENT="{esc(entry.get("agent", ""))}"')
print(f'PROMPT_PARALLEL="{"yes" if entry.get("parallelizable") else "no"}"')
depends = entry.get("depends_on", [])
print(f'PROMPT_DEPENDS="{esc(";;".join(depends))}"')
outs = []
for out in entry.get("outputs", []):
    path = esc(out.get("path", ""))
    desc = esc(out.get("description", ""))
    outs.append(f"{path}|{desc}")
print(f'PROMPT_OUTPUTS="{esc(";;".join(outs))}"')
PY)"

TIMESTAMP=$(date +%Y%m%d-%H%M)

printf "\n🚀 Prompt selecionado: %s\n" "$PROMPT_ID_REAL"
[[ -n "$PROMPT_TITLE" ]] && printf "   %s\n" "$PROMPT_TITLE"
printf "   Fase: %s | Ordem: %s | Agente sugerido: #%s\n" "$PHASE" "${PROMPT_ORDER:-N/A}" "$PROMPT_AGENT"
printf "   Paralelizável: %s\n" "$PROMPT_PARALLEL"

if [[ -n "$PROMPT_DEPENDS" ]]; then
  IFS=';;' read -ra deps <<<"$PROMPT_DEPENDS"
  if [[ ${#deps[@]} -gt 0 ]]; then
    printf "   Dependências: %s\n" "${deps[*]}"
  fi
fi

MIND_DIR=""
if [[ -n "$MIND" ]]; then
  MIND_DIR="minds/${MIND}"
  if [[ -d "$MIND_DIR" ]]; then
    printf "\n📁 Mind: %s\n" "$MIND"
    [[ -f "$MIND_DIR/docs/PRD.md" ]] && echo "   ✓ PRD encontrado"
    [[ -f "$MIND_DIR/docs/TODO.md" ]] && echo "   ✓ TODO encontrado"
    if ls "$MIND_DIR/docs/logs"/* >/dev/null 2>&1; then
      echo "   Últimos logs:"
      ls -t "$MIND_DIR/docs/logs"/* | head -3 | while read -r log; do
        printf "     - %s\n" "${log#$MIND_DIR/}"
      done
    fi
    if [[ -d "$MIND_DIR/sources" ]]; then
      count=$(find "$MIND_DIR/sources" -type f | wc -l | tr -d ' ')
      printf "   Fontes coletadas: %s arquivos\n" "$count"
    fi
  else
    printf "\n⚠️  Mind '%s' não encontrado em minds/.\n" "$MIND"
  fi
fi

printf "\n🗂️  Outputs sugeridos:\n"
IFS=';;' read -ra outs <<<"$PROMPT_OUTPUTS"
for item in "${outs[@]}"; do
  path="${item%%|*}"
  desc="${item#*|}"
  resolved="$path"
  if [[ -n "$MIND" ]]; then
    resolved="${resolved//\{mind\}/$MIND}"
  fi
  resolved="${resolved//\{timestamp\}/$TIMESTAMP}"
  resolved="${resolved//\{version\}/v1.0}"
  printf "   - %s\n" "$resolved"
  [[ -n "$desc" && "$desc" != "$path" ]] && printf "     (%s)\n" "$desc"
  if [[ "$resolved" != "$path" ]]; then
    printf "     ↳ template: %s\n" "$path"
  fi
  done

printf "\n📄 Prompt file: %s\n" "$PROMPT_FILE"
printf "👤 Acione o agente #%s com o briefing acima.\n" "$PROMPT_AGENT"

if [[ "$DRY_RUN" == true ]]; then
  printf "\nModo dry-run: nenhum log registrado.\n"
  exit 0
fi

mkdir -p "$LOG_DIR"
LOG_FILE="${LOG_DIR}/${TIMESTAMP}-launcher.log"
python - <<'PY' "$LOG_FILE" "$PROMPT_ID_REAL" "$MIND" "$USER_NAME" "$PROMPT_AGENT" "$PROMPT_FILE" "${metadata_json}"
import sys, json, datetime, os

log_file, prompt_id, mind, user_name, agent, prompt_file, payload = sys.argv[1:8]
os.makedirs(os.path.dirname(log_file), exist_ok=True)
entry = json.loads(payload).get("entry", {})
record = {
    "timestamp": datetime.datetime.utcnow().isoformat() + "Z",
    "prompt_id": prompt_id,
    "phase": entry.get("phase"),
    "agent": agent,
    "mind": mind or None,
    "user": user_name,
    "prompt_file": prompt_file,
    "outputs": entry.get("outputs", []),
}
with open(log_file, "a", encoding="utf-8") as fh:
    fh.write(json.dumps(record, ensure_ascii=False) + "\n")
PY

printf "\n📝 Log registrado em %s\n" "$LOG_FILE"
