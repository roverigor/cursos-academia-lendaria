# Integração ETL ↔ MMOS - Arquitetura AIOS

**Criado:** 2025-10-11
**Status:** Documento de arquitetura
**Problema identificado:** Dependência circular incorreta

---

## 🎯 Problema Identificado

### Estado Atual (Incorreto)
```
MMOS → ETL (correto: MMOS depende de ETL)
ETL → MMOS (incorreto: ETL conhece estrutura interna do MMOS)
```

**Implementação problemática em `run-collection.js:20-21`:**
```javascript
// HARDCODED - viola princípio de independência
const mindDir = path.join(__dirname, '../../docs/minds/sam_altman');
```

---

## ✅ Arquitetura Correta (Padrão AIOS)

### Princípios
1. **ETL é expansion pack independente** - não conhece MMOS
2. **MMOS depende de ETL** - invoca via task com parâmetros
3. **Comunicação via contrato** - parâmetros explícitos, não paths hardcoded
4. **Sem dependências circulares** - fluxo unidirecional

### Diagrama de Dependência

```
┌─────────────────────────────────────────────────┐
│  Core AIOS                                       │
│  - Task orchestration                            │
│  - Agent system                                  │
│  - Template engine                               │
└──────────────┬──────────────────────────────────┘
               │
      ┌────────┴─────────┐
      │                  │
      ▼                  ▼
┌──────────────┐   ┌──────────────────┐
│ ETL Pack     │   │ MMOS Pack        │
│ (indepen-    │◄──┤ (depende de ETL) │
│  dente)      │   │                  │
└──────────────┘   └──────────────────┘

Fluxo correto:
1. MMOS gera sources list
2. MMOS invoca ETL task com parâmetros
3. ETL coleta dados (sem conhecer MMOS)
4. ETL retorna report
5. MMOS processa resultado
```

---

## 📋 Contrato de Integração

### Interface: `collect-all-sources` Task

**Inputs (parâmetros obrigatórios):**
```yaml
sources_path: string          # Path absoluto para sources list
output_dir: string            # Path absoluto para output
tiers: array[int]            # [1, 2, 3] quais tiers coletar
mode: enum                   # "fast" | "standard" | "careful"
```

**Outputs (retorno esperado):**
```yaml
COLLECTION_SUMMARY.yaml:
  total_sources: int
  successful: int
  failed: int
  success_rate: float
  by_type: object
  errors: array

COLLECTION_LOG.md: markdown
downloads/: directory (estrutura por tipo)
```

**Contrato:**
- ETL **NÃO** assume estrutura de diretórios
- ETL **NÃO** conhece "minds/{name}"
- ETL recebe paths absolutos como parâmetros
- ETL retorna report estruturado
- MMOS interpreta resultado

---

## 🔧 Correção Necessária

### 1. `run-collection.js` (ETL)

**Antes (hardcoded - ERRADO):**
```javascript
const mindDir = path.join(__dirname, '../../docs/minds/sam_altman');
const sourcesPath = getSourcesMasterPath(mindDir);
const outputDir = getDownloadsDir(mindDir);
```

**Depois (parametrizado - CORRETO):**
```javascript
// Parse arguments (CLI ou task invocation)
const sourcesPath = process.argv[2] || promptForSourcesPath();
const outputDir = process.argv[3] || promptForOutputDir();
const configPath = process.argv[4] || path.join(__dirname, 'config/download-rules.yaml');

if (!sourcesPath || !outputDir) {
  console.error('Usage: node run-collection.js <sources-path> <output-dir> [config-path]');
  process.exit(1);
}

// Validate arguments
await fs.access(sourcesPath);  // Verifica se existe
await fs.mkdir(outputDir, { recursive: true });  // Cria se não existe
```

### 2. `research-collection.md` (MMOS)

**Task MMOS deve passar parâmetros explícitos:**
```yaml
# Passo 4 do research-collection.md
execute_etl_collection:
  task: /ETL:tasks:collect-all-sources
  parameters:
    sources_path: "{mindDir}/sources/sources_master.yaml"
    output_dir: "{mindDir}/sources/downloads"
    tiers: [1, 2]  # Tier 1 + 2
    mode: "standard"

  context_vars:
    mindDir: "docs/minds/{mind_name}"
    mind_name: "sam_altman"  # from elicitation
```

### 3. Invocação MMOS → ETL

**Fluxo correto:**
```javascript
// Em research-collection task (MMOS)
const mindName = await elicitMindName();
const mindDir = path.join(process.cwd(), 'docs/minds', mindName);

// Paths absolutos
const sourcesPath = path.join(mindDir, 'sources/sources_master.yaml');
const outputDir = path.join(mindDir, 'sources/downloads');

// Invoca ETL com parâmetros explícitos
await invokeTask('/ETL:tasks:collect-all-sources', {
  sources_path: sourcesPath,
  output_dir: outputDir,
  tiers: [1, 2],
  mode: 'standard'
});

// Aguarda completion
const report = await readCollectionReport(outputDir);

// Processa resultado
if (report.success_rate < 90) {
  console.warn('Collection teve problemas, revisar log');
}
```

---

## 🧪 Teste de Independência

### ETL deve funcionar standalone
```bash
# Sem MMOS - deve funcionar
cd expansion-packs/etl-data-collector

node run-collection.js \
  /path/to/any/sources.yaml \
  /path/to/any/output \
  ./config/download-rules.yaml
```

### MMOS invoca ETL via task
```bash
# Com MMOS - task orchestrator invoca ETL
@mind-mapper
*research-collection

# Internamente executa:
# invokeTask('/ETL:collect-all-sources', params)
```

---

## 📝 Checklist de Correção

### ETL Expansion Pack
- [ ] Remover hardcoded mindDir de `run-collection.js`
- [ ] Adicionar argument parsing (sources_path, output_dir)
- [ ] Validar argumentos obrigatórios
- [ ] Documentar CLI usage no README
- [ ] Testar standalone (sem MMOS)
- [ ] Atualizar `collect-all-sources.md` task

### MMOS Expansion Pack
- [ ] research-collection.md invoca ETL com parâmetros
- [ ] Passa paths absolutos (não relativos)
- [ ] Processa COLLECTION_SUMMARY.yaml
- [ ] Trata erros de collection
- [ ] Atualiza STATUS.md com progresso
- [ ] Documenta integração no README

### Core AIOS
- [ ] Task orchestrator suporta cross-pack invocation
- [ ] Parâmetros passados corretamente
- [ ] Logs centralizados
- [ ] Error handling consistente

---

## 🎯 Benefícios da Correção

1. **ETL reutilizável** - funciona para qualquer projeto, não só MMOS
2. **Testabilidade** - ETL testável standalone
3. **Manutenibilidade** - mudanças em MMOS não quebram ETL
4. **Padrão AIOS** - segue arquitetura de expansion packs
5. **Flexibilidade** - MMOS pode usar outros collectors, ETL pode ser usado por outros sistemas

---

## 🔄 Migration Path

### Fase 1: Quick Fix (Imediato)
```javascript
// run-collection.js - adicionar argumentos CLI
const sourcesPath = process.argv[2] || DEFAULT_PATH;
const outputDir = process.argv[3] || DEFAULT_OUTPUT;
```

### Fase 2: Task Integration (Curto prazo)
- Implementar task invocation em research-collection.md
- Passar parâmetros via task parameters
- Remover defaults hardcoded

### Fase 3: Full Refactor (Médio prazo)
- Criar interface formal ETL <-> MMOS
- Implementar adapter pattern
- Documentar contrato completo

---

## 📚 Referências

- **AIOS Expansion Pack Standard:** `.aios/docs/expansion-packs.md`
- **Task Orchestration:** `.aios/docs/task-system.md`
- **ETL Task Spec:** `expansion-packs/etl-data-collector/tasks/collect-all-sources.md`
- **MMOS Research Task:** `expansion-packs/mmos-mind-mapper/tasks/research-collection.md`

---

**Status:** Documento de arquitetura aprovado
**Próximos passos:** Implementar correções no run-collection.js e research-collection.md
**Owner:** @oalanicolas
