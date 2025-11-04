# Educational Artifacts Creator

**Developer:** Alan Nicolas
**Method:** José Amorim
**Version:** 1.0.0
**Command Prefix:** `/eduArtifacts`

## 🎯 Purpose

Sistema completo para criação de artefatos educacionais seguindo a metodologia de José Amorim. Transforma conteúdo bruto (conversas, transcrições, textos) em páginas educacionais interativas com progressão pedagógica estruturada, metáforas visuais/textuais e elementos clicáveis que geram efeitos pedagógicos intencionais.

## 📚 Metodologia José Amorim

### Características do Output Ideal
- **Estrutura Progressiva:** Do mais fácil para o mais difícil (vertical e horizontal)
- **Elementos Interativos:** Botões clicáveis com efeito pedagógico
- **Sistema de Metáforas:** Visuais e textuais para facilitar compreensão
- **Templates Diferenciados:** Para iniciantes ("para idiota") e técnicos

### Pipeline de Criação
```
INPUT → Normalização/ETL → Ideação → Referências Internas →
Junção/Playbook → Página.Doc → Validação + Template → ARTEFATO FINAL
```

## 🤖 Agents

### Creator/Analyst Agent (`@eduCreator`)
Responsável pelas fases iniciais do pipeline até a geração da página.doc.

**Commands:**
- `*normalize` - Normaliza o input do usuário
- `*ideate` - Processa ideação do conteúdo
- `*references` - Busca referências internas
- `*create-page-doc` - Gera documento base

### Clone Agent (`@eduClone`)
Aplica o estilo pessoal José Amorim e templates específicos.

**Commands:**
- `*apply-style` - Aplica estilo José Amorim
- `*validate` - Valida contra checklists
- `*apply-template` - Aplica template específico

## 📋 Tasks

### Core Tasks
- `normalization` - ETL e normalização de inputs
- `ideation` - Processamento de ideação
- `internal-references` - Busca de referências internas
- `junction-playbook` - Criação do playbook da página
- `page-doc-creation` - Criação do documento base
- `validation-template` - Validação e aplicação de template

## 📝 Templates

### Available Templates
- `page-for-beginners` - Página simplificada para iniciantes
- `page-for-technicals` - Página com código e detalhes técnicos
- `page-with-interactions` - Página com elementos clicáveis
- `page-with-metaphors` - Página com metáforas visuais/textuais

## ✅ Checklists

- `pedagogical-validation` - Valida progressão e eficácia pedagógica
- `technical-accuracy` - Verifica precisão técnica do conteúdo
- `interaction-effectiveness` - Avalia elementos interativos

## 🚀 Quick Start

### Installation
```bash
npm run install:expansion educational-artifacts
```

### Basic Usage

1. **Start with raw content:**
```bash
@eduCreator
*normalize "Your raw content here"
```

2. **Process ideation:**
```bash
*ideate
```

3. **Apply José Amorim style:**
```bash
@eduClone
*apply-style
```

4. **Generate final artifact:**
```bash
*apply-template page-for-beginners
```

## 📖 Usage Examples

### Example 1: Creating Educational Page from Transcript
```bash
# Activate creator agent
@eduCreator

# Normalize transcript
*normalize "path/to/transcript.txt"

# Process through pipeline
*ideate
*references
*create-page-doc

# Switch to clone agent
@eduClone

# Apply style and template
*apply-style
*apply-template page-for-beginners
```

### Example 2: Technical Documentation with Interactions
```bash
@eduCreator
*normalize "Technical content..."
*ideate --technical
*create-page-doc

@eduClone
*apply-template page-for-technicals
*validate technical-accuracy
```

## 🔧 Configuration

The pack can be configured via `config.yaml`. Key settings:
- `slash_prefix` - Command prefix (default: eduArtifacts)
- `templates` - Available templates
- `agents` - Agent configurations

## 📦 Directory Structure

```
educational-artifacts/
├── agents/           # Agent definitions
│   ├── creator-analyst.md
│   └── clone.md
├── tasks/           # Task workflows
│   ├── normalization.md
│   ├── ideation.md
│   └── ...
├── templates/       # Output templates
│   ├── page-for-beginners.yaml
│   ├── page-for-technicals.yaml
│   └── ...
├── checklists/      # Validation checklists
│   └── pedagogical-validation.md
├── data/           # Knowledge bases
│   └── jose-amorim-methodology.md
├── config.yaml     # Pack configuration
└── README.md       # This file
```

## 🤝 Contributing

To extend this pack:
1. Add new templates in `templates/`
2. Create new tasks in `tasks/`
3. Extend agents with new commands
4. Add validation rules to checklists

## 📄 License

This expansion pack follows the AIOS-FULLSTACK framework license.

---

*Based on the pedagogical methodology of José Amorim*
*Developed by Alan Nicolas*