# /delegar - Sistema de Delegação Inteligente

> Comando para passar o bastão entre modelos Claude, criando documentação completa para continuidade

## 🎯 Objetivo

Facilitar a delegação de tarefas entre modelos Claude (Opus → Sonnet → Haiku), criando automaticamente:
1. Guia completo para o próximo modelo
2. Prompt de inicialização
3. Resumo executivo
4. Instruções de passagem

## 🔄 Hierarquia de Delegação

```
Opus 4.1 → Sonnet 4.5 → Haiku
```

## 📝 Como Usar

1. **Execute**: `/delegar`
2. **Informe**:
   - Tarefa atual sendo realizada
   - Estado atual (o que já foi feito)
   - Próximos passos necessários
3. **Receba**: 4 arquivos de delegação prontos

## 🎨 Template de Delegação

### Arquivo 1: `{MODELO}_START_HERE.md`

```markdown
# 🚀 GUIA COMPLETO PARA {MODELO}

## 📋 Contexto Rápido

**Tarefa**: {TAREFA}
**Delegado por**: {MODELO_ANTERIOR}
**Data**: {DATA}

## ✅ O que já foi feito

{LISTA_DO_QUE_FOI_FEITO}

## 🎯 Sua Missão

{DESCRIÇÃO_CLARA_DA_MISSÃO}

## 📂 Arquivos Importantes

| Arquivo | Descrição | Status |
|---------|-----------|--------|
{TABELA_DE_ARQUIVOS}

## 🔧 Comandos Essenciais

### Teste Rápido (Execute Primeiro!)
\`\`\`bash
{COMANDOS_DE_TESTE}
\`\`\`

### Opções de Trabalho

#### OPÇÃO 1: {TAREFA_PRINCIPAL} ⭐ RECOMENDADA
{DETALHES_OPÇÃO_1}

#### OPÇÃO 2: {TAREFA_ALTERNATIVA}
{DETALHES_OPÇÃO_2}

#### OPÇÃO 3: {TAREFA_EXPLORATÓRIA}
{DETALHES_OPÇÃO_3}

## 📝 Templates Copy/Paste

### Template para {AÇÃO_PRINCIPAL}
\`\`\`{LINGUAGEM}
{TEMPLATE_PRONTO}
\`\`\`

## ⚠️ Erros Comuns e Soluções

| Erro | Solução |
|------|---------|
{TABELA_ERROS}

## ✅ Checklist de Início

- [ ] Li este documento completo
- [ ] Executei o teste rápido
- [ ] Verifiquei os arquivos importantes
- [ ] Escolhi uma opção de trabalho
- [ ] Tenho os templates necessários

## 📊 Métricas Atuais

{MÉTRICAS_DO_PROJETO}

## 🎯 Meta Final

{DESCRIÇÃO_DA_META_FINAL}

---
*Documento criado por {MODELO_ANTERIOR} para {MODELO}*
*Data: {DATA}*
```

### Arquivo 2: `PROMPT_PARA_{MODELO}.md`

```markdown
# Prompt para Iniciar {MODELO}

## Após /clear, cole isto:

Olá! Você é o {MODELO} e vai continuar o trabalho do seu irmão {MODELO_ANTERIOR} em {PROJETO}.

**Contexto rápido:**
{LISTA_CONTEXTO}

**Sua missão:**
{MISSÃO_RESUMIDA}

**LEIA ESTE ARQUIVO PRIMEIRO:**
{CAMINHO_DO_START_HERE}

**Comece executando:**
1. Leia {START_HERE}.md completo
2. Execute o "Teste Rápido"
3. Escolha OPÇÃO 1 (recomendada)
4. Use os templates fornecidos

**Confirme:** "Li {START_HERE}.md e executei o teste rápido com sucesso. Pronto para começar!"
```

### Arquivo 3: `EXECUTIVE_SUMMARY.md`

```markdown
# Resumo Executivo - Delegação para {MODELO}

## 📊 Estado Atual

| Componente | Status | Detalhes |
|------------|--------|----------|
{TABELA_STATUS}

## ✅ Completado por {MODELO_ANTERIOR}

{LISTA_COMPLETO}

## 🎯 Pendente para {MODELO}

{LISTA_PENDENTE}

## 📈 Métricas

- **Progresso Total**: {PORCENTAGEM}%
- **Tempo Estimado Restante**: {TEMPO}
- **Complexidade**: {NÍVEL}

## 🔑 IDs/Referências Importantes

{LISTA_IDS}

## 📝 Notas Especiais

{NOTAS}

---
*Resumo criado: {DATA}*
*Por: {MODELO_ANTERIOR}*
*Para: {USUÁRIO}*
```

### Arquivo 4: `COMO_INICIAR_{MODELO}.txt`

```
========================================
INSTRUÇÕES PARA PASSAR O BASTÃO
========================================

PASSO 1: Dê /clear
-----------------
Limpa a conversa atual

PASSO 2: Troque o Modelo
------------------------
/model
Selecione: {MODELO_SELEÇÃO}

PASSO 3: Cole o Prompt
----------------------
[Copie o conteúdo de PROMPT_PARA_{MODELO}.md]

PASSO 4: Deixe {MODELO} trabalhar!
----------------------------------

========================================
VALIDAÇÃO RÁPIDA
========================================

Execute estes comandos para verificar:

{COMANDOS_VALIDAÇÃO}

========================================
ARQUIVOS CRIADOS
========================================

1. {MODELO}_START_HERE.md - Guia principal
2. PROMPT_PARA_{MODELO}.md - Prompt inicial
3. EXECUTIVE_SUMMARY.md - Resumo executivo
4. COMO_INICIAR_{MODELO}.txt - Este arquivo

========================================
```

## 🚀 Exemplo de Uso Atual

### Para o Scan System:

```bash
/delegar

# Sistema pergunta (apenas se a documentação e as informações não estiverem claras no contexto da conversa):
> Qual tarefa está sendo delegada?
"Implementação do Scan System para Design System Agent"

> Qual o estado atual?
"Documentação completa criada, falta apenas executar os comandos"

> Quais os próximos passos?
"Executar SCAN-SYSTEM-ALL-IN-ONE-SETUP.sh e testar o sistema"
```

### Resultado: 4 arquivos criados

1. **SONNET_START_HERE.md** - Com toda a documentação do Scan System
2. **PROMPT_PARA_SONNET.md** - Prompt para iniciar Sonnet 3.5
3. **EXECUTIVE_SUMMARY.md** - Resumo do que foi planejado
4. **COMO_INICIAR_SONNET.txt** - Instruções de passagem

## 🔧 Implementação

O comando automaticamente:

1. **Detecta o modelo atual** (via contexto)
2. **Determina o próximo modelo** na hierarquia
3. **Coleta informações** sobre a tarefa
4. **Gera os 4 arquivos** de delegação
5. **Salva em local apropriado** (pasta do projeto)

## 📂 Onde os Arquivos São Salvos

```
docs/{projeto}/delegation/
├── {MODELO}_START_HERE.md
├── PROMPT_PARA_{MODELO}.md
├── EXECUTIVE_SUMMARY.md
└── COMO_INICIAR_{MODELO}.txt
```

## ⚙️ Configurações

### Modelos e Suas Características

```yaml
opus_4_1:
  nome: "Opus 4.1"
  delegado: "sonnet_4_5"
  foco: "Arquitetura, planejamento, documentação complexa"

sonnet_4_5:
  nome: "Sonnet 4.5"
  delegado: "haiku"
  foco: "Implementação, codificação, execução"

haiku:
  nome: "Haiku"
  delegado: null
  foco: "Tarefas repetitivas, inserção de dados, testes"
```

## 📋 Checklist de Delegação

Antes de delegar, verifique:

- [ ] Tarefa está bem documentada
- [ ] Estado atual está claro
- [ ] Próximos passos estão definidos
- [ ] Templates necessários foram criados
- [ ] Comandos de teste estão prontos

## 🎯 Benefícios

1. **Economia de Tokens**: Modelo mais barato para tarefas simples
2. **Continuidade**: Sem perda de contexto
3. **Eficiência**: Cada modelo no seu melhor uso
4. **Documentação**: Tudo registrado automaticamente

## 💡 Dicas

- **Opus**: Use para planejar e documentar
- **Sonnet**: Use para implementar e codificar
- **Haiku**: Use para executar e testar

## 🔄 Fluxo Completo

```mermaid
graph LR
    A[Opus planeja] --> B[/delegar]
    B --> C[Sonnet implementa]
    C --> D[/delegar]
    D --> E[Haiku executa]
```

---

*Comando criado para otimizar o uso dos modelos Claude*
*Versão: 1.0.0*
*Data: 2025-10-28*