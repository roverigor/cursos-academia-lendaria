# MMOS Loading - Como Funciona

## 📁 Config: `config/mmos-paths.yaml`

```yaml
paths:
  identity_core:
    - "artifacts/identity_core.yaml"

  cognitive_architecture:
    - "artifacts/cognitive_architecture.yaml"
    - "artifacts/cognitive-spec.yaml"  # Fallback

  communication_style:
    - "artifacts/communication_templates.md"
    - "kb/communication_style_final.md"  # Fallback

  frameworks:
    - "artifacts/frameworks_synthesized.md"
    - "kb/frameworks_final.md"  # Fallback

  system_prompts:
    - "system_prompts/generalista.md"
    - "system_prompts/system-prompt-generalista.md"  # Fallback

  metadata:
    - "metadata.yaml"
```

**Como editar:** Apenas mude os caminhos. Primeiro da lista = tentado primeiro.

---

## 🔧 Como o Código Usa (lib/mmos_integrator.py)

### **1. Inicialização**
```python
def __init__(self):
    # Carrega mmos-paths.yaml
    config_path = Path(__file__).parent.parent / "config" / "mmos-paths.yaml"
    self.paths = self._load_paths(config_path)
    # self.paths = {
    #   "identity_core": ["artifacts/identity_core.yaml"],
    #   "cognitive_architecture": ["artifacts/cognitive_architecture.yaml", ...],
    #   ...
    # }
```

### **2. Buscar Arquivo (Primeiro que Existir)**
```python
def _find_file(self, mind_path: Path, path_key: str):
    # Exemplo: path_key = "identity_core"
    paths = self.paths["identity_core"]  # ["artifacts/identity_core.yaml"]

    for rel_path in paths:
        full_path = mind_path / rel_path
        # Ex: outputs/minds/joao_lozano/artifacts/identity_core.yaml

        if full_path.exists():
            return full_path  # ✅ Retorna primeiro encontrado

    return None  # ❌ Nenhum encontrado
```

### **3. Validar Mind**
```python
def _is_valid_mmos_mind(self, mind_path: Path):
    # Precisa ter identity OU cognitive
    has_identity = (
        self._find_file(mind_path, "identity_core") is not None or
        self._find_file(mind_path, "cognitive_architecture") is not None
    )

    if not has_identity:
        return False

    # Precisa ter communication OU system_prompts
    has_comm = self._find_file(mind_path, "communication_style") is not None
    has_prompts = self._find_file(mind_path, "system_prompts") is not None

    return has_comm or has_prompts
```

### **4. Carregar Dados**
```python
def load_voice_profile(self, mind_metadata):
    mind_path = Path(mind_metadata.path)

    # Usa _find_file para cada tipo
    identity_path = self._find_file(mind_path, "identity_core")
    if identity_path:
        with open(identity_path, 'r') as f:
            identity_core = yaml.safe_load(f)

    cognitive_path = self._find_file(mind_path, "cognitive_architecture")
    # ... etc
```

---

## 📊 Fluxo Completo

```
1. INIT
   └─> Carrega config/mmos-paths.yaml
   └─> self.paths = {...}

2. SCAN (detect_available_minds)
   └─> Para cada pasta em outputs/minds/
       └─> _is_valid_mmos_mind(mind_path)
           └─> _find_file(mind_path, "identity_core")
               └─> Tenta: artifacts/identity_core.yaml
               └─> Se existe: ✅ Retorna path
               └─> Se não: ❌ Retorna None
           └─> _find_file(mind_path, "cognitive_architecture")
               └─> Tenta: artifacts/cognitive_architecture.yaml
               └─> Tenta: artifacts/cognitive-spec.yaml (fallback)
           └─> Se tem (identity OR cognitive) AND (comm OR prompts):
               └─> ✅ Mind válido
           └─> Senão:
               └─> ❌ Ignora

3. LOAD (load_voice_profile)
   └─> _find_file para cada tipo (identity, cognitive, comm, frameworks)
   └─> Abre arquivo encontrado
   └─> Extrai dados (nome, tom, frases, etc.)
   └─> Retorna MMOSVoiceProfile
```

---

## 🎯 Exemplo Real

**Mind:** `outputs/minds/joao_lozano/`

**Config:**
```yaml
paths:
  identity_core:
    - "artifacts/identity_core.yaml"
```

**Validação:**
```python
_find_file(Path("outputs/minds/joao_lozano"), "identity_core")

# Tenta:
full_path = Path("outputs/minds/joao_lozano/artifacts/identity_core.yaml")

if full_path.exists():  # ✅ Existe!
    return full_path

# Resultado:
# Path("outputs/minds/joao_lozano/artifacts/identity_core.yaml")
```

**Load:**
```python
identity_path = _find_file(..., "identity_core")
# = Path("outputs/minds/joao_lozano/artifacts/identity_core.yaml")

with open(identity_path, 'r') as f:
    identity_core = yaml.safe_load(f)

name = identity_core["nome_completo"]  # "João Lozano"
traits = identity_core["tracos_personalidade"]  # ["Pragmático", "Direto"]
```

---

## ✏️ Como Customizar

### **Exemplo 1: Mudar caminho identity_core**

**Antes:**
```yaml
identity_core:
  - "artifacts/identity_core.yaml"
```

**Depois (seu caminho custom):**
```yaml
identity_core:
  - "meu_dir/identidade.yaml"
  - "artifacts/identity_core.yaml"  # Fallback
```

**Resultado:** Tenta `meu_dir/identidade.yaml` primeiro, depois `artifacts/identity_core.yaml`.

### **Exemplo 2: Adicionar mais fallbacks**

```yaml
cognitive_architecture:
  - "artifacts/cognitive_architecture.yaml"
  - "artifacts/cognitive-spec.yaml"
  - "analysis/cognitive-spec.yaml"  # MMOS v2.x
  - "custom/my-cognitive.yaml"       # Custom
```

**Resultado:** Tenta na ordem, usa primeiro que existir.

---

## 🧪 Testar

```bash
cd expansion-packs/creator-os
python lib/mmos_integrator.py
```

**Output esperado:**
```
Scanning for MMOS minds...

✓ Found 2 MMOS minds:

  - João Lozano (joao_lozano)
    Version: 3.0
    Has system prompt: ✅
    Has frameworks: ✅
    System prompt: /path/to/system_prompts/generalista.md
```

---

**Última atualização:** 2025-10-20
