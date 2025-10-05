#!/bin/bash
# Script to create standard structure for a new mind
# Usage: ./create-mind-structure.sh mind_name

if [ -z "\$1" ]; then
    echo "❌ Error: Mind name is required"
    echo "Usage: ./create-mind-structure.sh mind_name"
    exit 1
fi

MIND_NAME=\$1
TIMESTAMP=\$(date +"%Y%m%d-%H%M")

echo "🤖 Creating structure for mind: \$MIND_NAME"
echo "📅 Timestamp: \$TIMESTAMP"
echo

# Create main folder
mkdir -p "\$MIND_NAME"
cd "\$MIND_NAME"

# Create required folder structure
echo "📁 Creating folder structure..."
mkdir -p analysis
mkdir -p docs  
mkdir -p frameworks
mkdir -p logs
mkdir -p sources/{books,interviews,speeches,articles,social-media,videos}
mkdir -p templates

# Criar README na pasta logs
cat > logs/README.md << EOF
# 📋 Logs Directory - \$MIND_NAME

Este diretório contém relatórios temporários seguindo convenção timestamp.

## Formato: YYYYMMDD-HHMM-nome-arquivo.md

Criado em: \$(date)
EOF

# Criar README principal do mind
cat > docs/README.md << EOF
# 🤖 Mind: \${MIND_NAME^}

**Status:** 🔄 Em desenvolvimento  
**Criado:** \$(date)  
**Última atualização:** \$(date)

## 📊 Resumo

[Descrição da personalidade e propósito do mind]

## 🎯 Objetivos

- [ ] Coleta de material fonte
- [ ] Análise de personalidade
- [ ] Extração de templates
- [ ] Documentação completa
- [ ] Validação de qualidade

## 📚 Fontes Principais

[Lista das principais fontes de material]

## 🔧 Templates Extraídos

[Lista dos templates e frameworks identificados]

## 📈 Progresso

- **Estrutura:** ✅ Completa
- **Coleta:** 🔄 Em andamento
- **Análise:** ⏳ Pendente
- **Templates:** ⏳ Pendente
- **Documentação:** 🔄 Em andamento

---

*Mind criado seguindo as boas práticas da Academia Lendar[IA]*
EOF

# Criar PRD básico
cat > docs/PRD.md << EOF
# 📋 Product Requirements Document - \${MIND_NAME^}

**Versão:** 1.0  
**Data:** \$(date)  
**Status:** Draft

## 🎯 Visão Geral

### Objetivo
[Definir o propósito do mind]

### Personalidade Alvo
**Nome:** \${MIND_NAME^}  
**Área:** [Área de atuação]  
**Características:** [Principais características]

## 📊 Requisitos Funcionais

### RF001 - Análise de Personalidade
- Extrair padrões comportamentais
- Identificar estilo de comunicação
- Mapear frameworks mentais

### RF002 - Extração de Templates
- Templates de comunicação
- Frameworks de decisão
- Padrões de resposta

### RF003 - Validação de Qualidade
- Teste de fidelidade
- Validação de autenticidade
- Métricas de performance

## 📋 Requisitos Não Funcionais

### RNF001 - Qualidade
- Fidelidade >92% ao estilo original
- Templates funcionais e testados
- Documentação completa

### RNF002 - Organização
- Estrutura padrão de pastas
- Nomenclatura consistente
- Logs organizados

## 🎯 Critérios de Sucesso

- [ ] Material fonte coletado e verificado
- [ ] Análise de personalidade completa
- [ ] Templates extraídos e funcionais
- [ ] Documentação 100% completa
- [ ] Validação de qualidade aprovada

## 📈 Roadmap

### Fase 1: Coleta (Semana 1)
- [ ] Research e coleta de fontes
- [ ] Organização do material
- [ ] Verificação de qualidade

### Fase 2: Análise (Semana 2)  
- [ ] Análise de personalidade
- [ ] Mapeamento de padrões
- [ ] Identificação de frameworks

### Fase 3: Extração (Semana 3)
- [ ] Extração de templates
- [ ] Criação de frameworks
- [ ] Teste de funcionalidade

### Fase 4: Validação (Semana 4)
- [ ] Teste de fidelidade
- [ ] Validação de qualidade
- [ ] Documentação final

---

*PRD criado seguindo padrões da Academia Lendar[IA]*
EOF

# Criar arquivo de análise inicial
cat > analysis/personality-profile.json << EOF
{
  "mind_name": "\$MIND_NAME",
  "created_at": "\$(date -Iseconds)",
  "status": "initial_structure",
  "personality_analysis": {
    "communication_style": "",
    "decision_patterns": "",
    "core_values": [],
    "signature_phrases": [],
    "behavioral_traits": []
  },
  "extracted_templates": {
    "communication": [],
    "frameworks": [],
    "decision_trees": []
  },
  "quality_metrics": {
    "source_verification": 0,
    "template_count": 0,
    "fidelity_score": 0
  },
  "sources": {
    "books": [],
    "interviews": [],
    "speeches": [],
    "articles": [],
    "social_media": [],
    "videos": []
  }
}
EOF

# Criar log inicial
cat > "logs/\${TIMESTAMP}-mind-created.md" << EOF
# 🤖 Mind Creation Log

**Mind:** \$MIND_NAME  
**Data:** \$(date)  
**Timestamp:** \$TIMESTAMP  
**Status:** ✅ Estrutura criada

---

## 📁 Estrutura Criada

- ✅ analysis/ (com personality-profile.json)
- ✅ docs/ (com README.md e PRD.md)
- ✅ frameworks/ (vazio, pronto para frameworks)
- ✅ logs/ (com README.md e este log)
- ✅ sources/ (com subpastas organizadas)
- ✅ templates/ (vazio, pronto para templates)

## 🎯 Próximos Passos

1. [ ] Iniciar coleta de material fonte
2. [ ] Atualizar README com informações específicas
3. [ ] Completar PRD com requisitos detalhados
4. [ ] Começar análise de personalidade

---

**Mind pronto para desenvolvimento!**
EOF

echo "✅ Estrutura criada com sucesso!"
echo "📁 Pastas: analysis, docs, frameworks, logs, sources, templates"
echo "📄 Arquivos: README.md, PRD.md, personality-profile.json"
echo "📋 Log inicial: \${TIMESTAMP}-mind-created.md"
echo
echo "🚀 Próximo passo: Editar docs/README.md com informações específicas"
echo "📊 Verificar: Estrutura está 100% conforme boas práticas"

