# 🚨 Riscos e Mitigações

## Risco 1: Links Quebrados

**Impacto:** Documentação inacessível, onboarding quebrado

**Mitigação:**
- Executar script de validação de links ANTES do commit
- Usar find/replace em massa com confirmação
- Manter backup da estrutura antiga

## Risco 2: Scripts Dependentes de Paths

**Impacto:** Scripts operacionais param de funcionar

**Mitigação:**
- Verificar todos os scripts em `scripts/` ANTES da migração
- Atualizar hardcoded paths
- Testar scripts após migração

## Risco 3: Expansion Packs com Paths Hardcoded

**Impacto:** Tasks de expansion packs quebram

**Mitigação:**
- Verificar todos os tasks em `expansion-packs/*/tasks/`
- Atualizar templates em `expansion-packs/*/templates/`
- Testar pelo menos 1 task de cada pack

## Risco 4: Database Path Mudado

**Impacto:** Scripts de population/import param de funcionar

**Mitigação:**
- Criar symlink temporário: `ln -s outputs/database/mmos.db outputs/database/mmos.db`
- Manter por 1-2 semanas para backward compatibility
- Adicionar warning deprecation em scripts

---
