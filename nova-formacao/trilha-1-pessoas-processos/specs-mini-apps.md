# Specs: Mini-Apps Trilha 1 - Pessoas & Processos

## Documento de Especificacao Funcional

**Versao:** 1.0
**Data:** 2025-01-03
**Autor:** Course Architect Agent
**Para:** @architect (stack/arquitetura) + @dev (implementacao)

---

## Visao Geral

### Contexto
A Academia Lendaria precisa entregar os entregaveis da Trilha 1 como **mini-apps** ao inves de templates estaticos (Excel/PDF). O aluno deve poder:
- Usar o app online durante o curso
- Fazer fork/download do codigo
- Hospedar em sua propria infra se quiser

### Requisitos Globais (Todos os Apps)

| Requisito | Descricao |
|-----------|-----------|
| **Self-contained** | App funciona standalone, sem backend obrigatorio |
| **Exportavel** | Dados podem ser exportados (JSON, PDF) |
| **Responsivo** | Funciona em desktop e mobile |
| **Offline-first** | Dados salvos em localStorage |
| **Open-source friendly** | Codigo limpo, documentado, forkavel |
| **IA Integrada** | Botao para gerar prompt pre-preenchido para ChatGPT/Claude |
| **Sem login obrigatorio** | Funciona anonimo (login opcional para sync) |

### Stack Sugerida (para @architect validar)

| Camada | Opcao Recomendada | Alternativas |
|--------|-------------------|--------------|
| Frontend | Next.js + Tailwind | Bolt/Lovable (no-code) |
| State | Zustand + localStorage | Redux, Jotai |
| UI Components | shadcn/ui | Radix, Chakra |
| Export PDF | react-pdf | jsPDF |
| IA Integration | Copy-to-clipboard prompt | API call (opcional) |
| Deploy | Vercel | Netlify, GitHub Pages |

---

# MINI-APP 1: Mapa de Dependencia Humana

## 1.1 Objetivo
Permitir que o empresario mapeie todas as funcoes/cargos da empresa, identifique riscos de dependencia humana e calcule o custo potencial de exposicao.

## 1.2 Telas

### Tela 1: Informacoes da Empresa
```
+------------------------------------------+
|  MAPA DE DEPENDENCIA HUMANA              |
|  ────────────────────────────────────    |
|                                          |
|  Nome da Empresa: [___________________]  |
|  Faturamento Mensal: R$ [___________]    |
|  Total de Funcionarios: [____]           |
|  Data: [auto-preenchido]                 |
|  Responsavel: [___________________]      |
|                                          |
|  [Proximo ->]                            |
+------------------------------------------+
```

### Tela 2: Mapeamento de Funcoes
```
+----------------------------------------------------------+
|  FUNCOES DA EMPRESA                          [+ Adicionar] |
|  ──────────────────────────────────────────────────────── |
|                                                           |
|  | Funcao | Pessoa | Se Sair... | Horas | Doc? | Backup | Risco |
|  |--------|--------|------------|-------|------|--------|-------|
|  | [____] | [____] | [________] | [__]  | [v]  | [v]    | [v]   |
|  | [____] | [____] | [________] | [__]  | [v]  | [v]    | [v]   |
|  | ... (dinamico, max 20 linhas)                         |
|                                                           |
|  [<- Voltar]                          [Calcular Riscos ->]|
+----------------------------------------------------------+
```

### Tela 3: Analise de Riscos
```
+----------------------------------------------------------+
|  ANALISE DE RISCOS                                        |
|  ──────────────────────────────────────────────────────── |
|                                                           |
|  RESUMO EXECUTIVO                                         |
|  ┌──────────────────────────────────────────────────────┐ |
|  │ Riscos ALTOS: 3    Riscos MEDIOS: 4   Riscos BAIXOS: 2│ |
|  │ Funcoes sem documentacao: 5                           │ |
|  │ Funcoes sem backup: 6                                 │ |
|  │ CUSTO POTENCIAL DE EXPOSICAO: R$ 45.000/mes          │ |
|  └──────────────────────────────────────────────────────┘ |
|                                                           |
|  TOP 3 RISCOS CRITICOS                                    |
|  ┌──────────────────────────────────────────────────────┐ |
|  │ 1. [Vendas] Maria - R$ 20.000/mes                    │ |
|  │ 2. [TI] Carlos - R$ 15.000/mes                       │ |
|  │ 3. [Financeiro] Joao - R$ 10.000/mes                 │ |
|  └──────────────────────────────────────────────────────┘ |
|                                                           |
|  [Validar com IA]  [Exportar PDF]  [Exportar JSON]        |
+----------------------------------------------------------+
```

### Tela 4: Plano de Acao (por risco)
```
+----------------------------------------------------------+
|  PLANO DE ACAO - Risco #1: Vendas (Maria)                 |
|  ──────────────────────────────────────────────────────── |
|                                                           |
|  Impacto se sair: [________________________________]      |
|  Custo estimado: R$ [________]/mes                        |
|                                                           |
|  Acao imediata: [________________________________]        |
|  Prazo: [____] dias                                       |
|                                                           |
|  [<- Risco Anterior]  [Salvar]  [Proximo Risco ->]        |
+----------------------------------------------------------+
```

## 1.3 Campos e Tipos

| Campo | Tipo | Validacao | Obrigatorio |
|-------|------|-----------|-------------|
| empresa | string | max 100 chars | Sim |
| faturamento | number | > 0 | Sim |
| total_funcionarios | number | 1-500 | Sim |
| data | date | auto | Sim |
| responsavel | string | max 50 | Nao |
| funcoes[] | array | min 1, max 20 | Sim |
| funcoes[].cargo | string | max 50 | Sim |
| funcoes[].pessoa | string | max 50 | Sim |
| funcoes[].impacto | string | max 200 | Sim |
| funcoes[].horas_semana | number | 1-80 | Sim |
| funcoes[].documentado | enum | Sim/Nao/Parcial | Sim |
| funcoes[].backup | boolean | - | Sim |
| funcoes[].risco | enum | Alto/Medio/Baixo | Sim |
| funcoes[].custo_risco | number | calculado | Auto |
| funcoes[].acao | string | max 200 | Nao |
| funcoes[].prazo | number | dias | Nao |

## 1.4 Logica de Negocio

### Calculo de Custo de Risco
```javascript
function calcularCustoRisco(funcao, faturamento) {
  const multiplicadores = {
    'Alto': 0.4,   // 40% do faturamento
    'Medio': 0.15, // 15% do faturamento
    'Baixo': 0.05  // 5% do faturamento
  };

  return faturamento * multiplicadores[funcao.risco];
}
```

### Classificacao Automatica de Risco (sugestao)
```javascript
function sugerirRisco(funcao) {
  let score = 0;

  if (funcao.documentado === 'Nao') score += 3;
  if (funcao.documentado === 'Parcial') score += 1;
  if (!funcao.backup) score += 3;
  if (funcao.horas_semana > 30) score += 2;

  // Palavras-chave no impacto
  const palavrasAlto = ['para', 'perde', 'cai', 'ninguem'];
  const impactoLower = funcao.impacto.toLowerCase();
  if (palavrasAlto.some(p => impactoLower.includes(p))) score += 2;

  if (score >= 6) return 'Alto';
  if (score >= 3) return 'Medio';
  return 'Baixo';
}
```

### Resumo Executivo (calculado)
```javascript
function calcularResumo(funcoes, faturamento) {
  return {
    riscos_altos: funcoes.filter(f => f.risco === 'Alto').length,
    riscos_medios: funcoes.filter(f => f.risco === 'Medio').length,
    riscos_baixos: funcoes.filter(f => f.risco === 'Baixo').length,
    sem_documentacao: funcoes.filter(f => f.documentado === 'Nao').length,
    sem_backup: funcoes.filter(f => !f.backup).length,
    custo_total: funcoes.reduce((sum, f) => sum + calcularCustoRisco(f, faturamento), 0),
    top_3_riscos: funcoes
      .filter(f => f.risco === 'Alto')
      .sort((a, b) => b.custo_risco - a.custo_risco)
      .slice(0, 3)
  };
}
```

## 1.5 Integracao com IA

### Botao "Validar com IA"
Gera prompt pre-preenchido e copia para clipboard:

```javascript
function gerarPromptValidacao(dados) {
  return `Voce e um consultor de gestao de riscos organizacionais.

Analise o seguinte Mapa de Dependencia Humana:

---
Empresa: ${dados.empresa}
Faturamento: R$ ${dados.faturamento}/mes
Total de funcionarios: ${dados.total_funcionarios}

FUNCOES MAPEADAS:
${dados.funcoes.map(f =>
  `- ${f.cargo} (${f.pessoa}): ${f.impacto} | ${f.horas_semana}h/sem | Doc: ${f.documentado} | Backup: ${f.backup ? 'Sim' : 'Nao'} | Risco: ${f.risco}`
).join('\n')}
---

Para cada funcao, avalie:
1. O nivel de risco esta correto?
2. Qual o custo estimado se essa pessoa sair?
3. Qual a prioridade de mitigacao (1-5)?

Entregue:
- Lista ordenada por prioridade
- TOP 3 riscos criticos com plano de acao imediata
- Estimativa de custo total de exposicao`;
}
```

## 1.6 Exports

| Formato | Conteudo |
|---------|----------|
| **JSON** | Dados completos para backup/importacao |
| **PDF** | Relatorio formatado com graficos |
| **Markdown** | Para colar em docs/notion |

## 1.7 Persistencia

- **localStorage**: Salva automaticamente a cada alteracao
- **Key**: `mapa_dependencia_v1`
- **Opcional**: Sync com Supabase se logado

---

# MINI-APP 2: Matriz Funcao x Decisao

## 2.1 Objetivo
Mapear as decisoes que a equipe toma (nao tarefas), classificar por tipo e potencial de automacao, e priorizar as TOP 3 para automatizar com IA.

## 2.2 Telas

### Tela 1: Setup
```
+------------------------------------------+
|  MATRIZ FUNCAO x DECISAO                 |
|  ────────────────────────────────────    |
|                                          |
|  Empresa: [___________________]          |
|  Departamento/Area: [_______________]    |
|  Data: [auto]                            |
|                                          |
|  [Comecar Mapeamento ->]                 |
+------------------------------------------+
```

### Tela 2: Mapeamento de Decisoes
```
+------------------------------------------------------------------+
|  DECISOES DO NEGOCIO                               [+ Adicionar]  |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  | Decisao | Quem Decide | Freq | Impacto | Tipo | Regra? | IA? |
|  |---------|-------------|------|---------|------|--------|-----|
|  | [_____] | [_________] | [v]  | [v]     | [v]  | [v]    | [v] |
|  | [_____] | [_________] | [v]  | [v]     | [v]  | [v]    | [v] |
|  | ... (dinamico)                                                |
|                                                                   |
|  [<- Voltar]                              [Analisar Automacao ->] |
+------------------------------------------------------------------+
```

### Tela 3: Analise de Automacao
```
+------------------------------------------------------------------+
|  POTENCIAL DE AUTOMACAO                                           |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  RESUMO                                                           |
|  ┌────────────────────────────────────────────────────────────┐  |
|  │ Decisoes Operacionais: 6 (automatizaveis)                  │  |
|  │ Decisoes Taticas: 3 (parcialmente automatizaveis)          │  |
|  │ Decisoes Estrategicas: 1 (manter humano)                   │  |
|  │ ECONOMIA POTENCIAL: 45 horas/mes                           │  |
|  └────────────────────────────────────────────────────────────┘  |
|                                                                   |
|  TOP 3 PARA AUTOMATIZAR                                           |
|  ┌────────────────────────────────────────────────────────────┐  |
|  │ 1. Aprovar desconto < 10% - 8h/mes - [Criar Regra]         │  |
|  │ 2. Classificar lead - 12h/mes - [Criar Regra]              │  |
|  │ 3. Responder FAQ - 15h/mes - [Criar Regra]                 │  |
|  └────────────────────────────────────────────────────────────┘  |
|                                                                   |
|  [Validar com IA]  [Exportar]                                     |
+------------------------------------------------------------------+
```

### Tela 4: Criar Regra de Automacao
```
+------------------------------------------------------------------+
|  REGRA DE AUTOMACAO: Aprovar desconto                             |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  GATILHO                                                          |
|  O que dispara: [Cliente solicita desconto_______________]        |
|  Dados necessarios: [Valor do pedido, historico do cliente]       |
|                                                                   |
|  REGRA                                                            |
|  SE [desconto <= 10%] E [cliente ativo > 6 meses]                 |
|  ENTAO [Aprovar automaticamente]                                  |
|  SENAO [Escalar para gerente]                                     |
|                                                                   |
|  EXCECOES                                                         |
|  - Valor do pedido > R$ 10.000                                    |
|  - Cliente com inadimplencia                                      |
|                                                                   |
|  [Gerar Prompt de Automacao]  [Salvar Regra]                      |
+------------------------------------------------------------------+
```

## 2.3 Campos e Tipos

| Campo | Tipo | Validacao | Obrigatorio |
|-------|------|-----------|-------------|
| empresa | string | max 100 | Sim |
| departamento | string | max 50 | Nao |
| decisoes[] | array | min 3, max 20 | Sim |
| decisoes[].descricao | string | max 100 | Sim |
| decisoes[].quem_decide | string | max 50 | Sim |
| decisoes[].frequencia | enum | Diaria/Semanal/Mensal | Sim |
| decisoes[].impacto | enum | Baixo/Medio/Alto | Sim |
| decisoes[].tipo | enum | Estrategica/Tatica/Operacional | Sim |
| decisoes[].regra_clara | enum | Sim/Nao/Parcial | Sim |
| decisoes[].ia_pode | enum | Sim/Nao/Parcial | Sim |
| decisoes[].tempo_por_vez | number | minutos | Nao |
| decisoes[].vezes_por_periodo | number | - | Nao |
| decisoes[].regra_se_entao | string | max 500 | Nao |

## 2.4 Logica de Negocio

### Calculo de Tempo Mensal
```javascript
function calcularTempoMensal(decisao) {
  const multiplicadores = {
    'Diaria': 22,    // dias uteis
    'Semanal': 4,    // semanas
    'Mensal': 1
  };

  return decisao.tempo_por_vez * decisao.vezes_por_periodo * multiplicadores[decisao.frequencia];
}
```

### Score de Automatizabilidade
```javascript
function calcularScoreAutomacao(decisao) {
  let score = 0;

  if (decisao.tipo === 'Operacional') score += 40;
  if (decisao.tipo === 'Tatica') score += 20;
  // Estrategica = 0

  if (decisao.regra_clara === 'Sim') score += 30;
  if (decisao.regra_clara === 'Parcial') score += 15;

  if (decisao.ia_pode === 'Sim') score += 30;
  if (decisao.ia_pode === 'Parcial') score += 15;

  return score; // 0-100
}
```

### Priorizacao TOP 3
```javascript
function priorizarAutomacao(decisoes) {
  return decisoes
    .map(d => ({
      ...d,
      score: calcularScoreAutomacao(d),
      tempo_mensal: calcularTempoMensal(d)
    }))
    .filter(d => d.score >= 50)
    .sort((a, b) => (b.score * b.tempo_mensal) - (a.score * a.tempo_mensal))
    .slice(0, 3);
}
```

## 2.5 Integracao com IA

### Botao "Criar Regra com IA"
```javascript
function gerarPromptRegra(decisao) {
  return `Voce e um arquiteto de automacao.

Para a seguinte decisao:

---
Decisao: ${decisao.descricao}
Frequencia: ${decisao.frequencia}
Quem decide hoje: ${decisao.quem_decide}
Tempo por decisao: ${decisao.tempo_por_vez} minutos
---

Crie a regra de automacao:

1. GATILHO: O que dispara esta decisao?
2. CONDICOES: SE [X] E [Y] ENTAO [Z] SENAO [W]
3. EXCECOES: Quando NAO aplicar a regra?
4. VALIDACAO: Como saber se a decisao esta correta?
5. IMPLEMENTACAO: Ferramenta sugerida (ChatGPT/n8n/Zapier)`;
}
```

---

# MINI-APP 3: SOP Inteligente

## 3.1 Objetivo
Criar SOPs com os 5 componentes obrigatorios + prompts de validacao com IA integrados. O SOP deve ser "auto-validavel".

## 3.2 Telas

### Tela 1: Cabecalho do SOP
```
+------------------------------------------+
|  SOP INTELIGENTE                         |
|  ────────────────────────────────────    |
|                                          |
|  Nome do Processo: [_________________]   |
|  Codigo: SOP-[____]                      |
|  Departamento: [_________________]       |
|  Responsavel: [_________________]        |
|                                          |
|  [Proximo: Objetivo ->]                  |
+------------------------------------------+
```

### Tela 2: Objetivo e Contexto
```
+----------------------------------------------------------+
|  OBJETIVO DO PROCESSO                                     |
|  ────────────────────────────────────────────────────────|
|                                                           |
|  Este processo entrega:                                   |
|  [__________________________________________________]    |
|                                                           |
|  Para quem (cliente/area):                                |
|  [__________________________________________________]    |
|                                                           |
|  Em quanto tempo:                                         |
|  [____] minutos/horas                                     |
|                                                           |
|  Iniciar quando: [________________________________]       |
|  NAO usar quando: [________________________________]      |
|  Frequencia: [v] Diaria/Semanal/Mensal/Sob demanda        |
|                                                           |
|  [<- Voltar]                    [Proximo: Passo a Passo]  |
+----------------------------------------------------------+
```

### Tela 3: Passo a Passo (Builder)
```
+------------------------------------------------------------------+
|  PASSO A PASSO                                    [+ Adicionar]   |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  | # | Acao | Responsavel | Tempo | Output |                     |
|  |---|------|-------------|-------|--------|                     |
|  | 1 | [__] | [_________] | [__]m | [____] | [Excluir]           |
|  | 2 | [__] | [_________] | [__]m | [____] | [Excluir]           |
|  | ...                                                            |
|                                                                   |
|  TEMPO TOTAL ESTIMADO: 45 minutos                                 |
|                                                                   |
|  [<- Voltar]                          [Proximo: Criterios ->]     |
+------------------------------------------------------------------+
```

### Tela 4: Criterios de Qualidade
```
+------------------------------------------------------------------+
|  CRITERIOS DE QUALIDADE                           [+ Adicionar]   |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  Como saber se o resultado esta correto?                          |
|                                                                   |
|  | # | Criterio | Como Verificar | Obrigatorio |                 |
|  |---|----------|----------------|-------------|                 |
|  | 1 | [______] | [____________] | [v]         |                 |
|  | 2 | [______] | [____________] | [v]         |                 |
|  | 3 | [______] | [____________] | [v]         |                 |
|                                                                   |
|  ERROS COMUNS                                     [+ Adicionar]   |
|  | Erro | Por Que Acontece | Como Evitar |                       |
|  |------|------------------|-------------|                       |
|  | [__] | [______________] | [_________] |                       |
|                                                                   |
|  [<- Voltar]                          [Proximo: Prompts IA ->]    |
+------------------------------------------------------------------+
```

### Tela 5: Prompts de IA (Auto-gerados)
```
+------------------------------------------------------------------+
|  PROMPTS DE IA                                                    |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  PROMPT DE VALIDACAO (gerado automaticamente)                     |
|  ┌────────────────────────────────────────────────────────────┐  |
|  │ Voce e um validador de qualidade. Revise o seguinte        │  |
|  │ [Nome do Processo]:                                         │  |
|  │ ---                                                         │  |
|  │ [COLAR RESULTADO AQUI]                                      │  |
|  │ ---                                                         │  |
|  │ Verifique os criterios:                                     │  |
|  │ 1. [Criterio 1]                                             │  |
|  │ 2. [Criterio 2]                                             │  |
|  │ ...                                                         │  |
|  └────────────────────────────────────────────────────────────┘  |
|  [Copiar Prompt]  [Editar]                                        |
|                                                                   |
|  PROMPT DE EXECUCAO (opcional)                                    |
|  [+ Criar Prompt de Execucao]                                     |
|                                                                   |
|  [<- Voltar]                          [Finalizar SOP ->]          |
+------------------------------------------------------------------+
```

### Tela 6: SOP Completo (Preview/Export)
```
+------------------------------------------------------------------+
|  SOP COMPLETO: [Nome do Processo]                                 |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  [Preview do SOP formatado]                                       |
|                                                                   |
|  CHECKLIST DE VALIDACAO                                           |
|  [ ] Objetivo claro em 1-2 frases                                 |
|  [ ] Passo a passo com max 10 passos                              |
|  [ ] Cada passo tem tempo estimado                                |
|  [ ] Criterios de qualidade mensuraveis (3-5)                     |
|  [ ] Erros comuns documentados                                    |
|  [ ] Prompt de validacao criado                                   |
|                                                                   |
|  [Validar com IA]  [Exportar PDF]  [Exportar Markdown]            |
+------------------------------------------------------------------+
```

## 3.3 Campos e Tipos

| Campo | Tipo | Validacao |
|-------|------|-----------|
| nome | string | max 100 |
| codigo | string | SOP-XXX |
| departamento | string | max 50 |
| responsavel | string | max 50 |
| objetivo.entrega | string | max 200 |
| objetivo.para_quem | string | max 100 |
| objetivo.tempo | number + enum | min/hora |
| contexto.iniciar_quando | string | max 200 |
| contexto.nao_usar_quando | string | max 200 |
| contexto.frequencia | enum | - |
| passos[] | array | min 3, max 10 |
| passos[].acao | string | max 200 |
| passos[].responsavel | string | max 50 |
| passos[].tempo | number | minutos |
| passos[].output | string | max 100 |
| criterios[] | array | min 3, max 5 |
| criterios[].descricao | string | max 200 |
| criterios[].como_verificar | string | max 200 |
| criterios[].obrigatorio | boolean | - |
| erros[] | array | max 5 |
| prompt_validacao | string | auto-gerado |
| prompt_execucao | string | opcional |

## 3.4 Logica de Negocio

### Geracao Automatica de Prompt de Validacao
```javascript
function gerarPromptValidacao(sop) {
  return `Voce e um validador de qualidade. Revise o seguinte ${sop.nome}:

---
[COLAR RESULTADO AQUI]
---

Verifique os seguintes criterios:

${sop.criterios.map((c, i) => `${i + 1}. ${c.descricao} - Como verificar: ${c.como_verificar}`).join('\n')}

Para cada criterio, responda:
- OK: Se atende completamente
- PARCIAL: Se atende mas pode melhorar
- FALHA: Se nao atende

Ao final:
- Se TODOS forem OK: Responda "APROVADO - Pode entregar"
- Se algum for PARCIAL: Liste sugestoes de melhoria
- Se algum for FALHA: Liste o que precisa ser refeito ANTES de entregar

Seja objetivo e especifico.`;
}
```

### Calculo de Tempo Total
```javascript
function calcularTempoTotal(passos) {
  return passos.reduce((sum, p) => sum + p.tempo, 0);
}
```

### Validacao do SOP
```javascript
function validarSOP(sop) {
  const checks = [
    { ok: sop.objetivo.entrega.length <= 200, msg: 'Objetivo claro' },
    { ok: sop.passos.length >= 3 && sop.passos.length <= 10, msg: 'Passos entre 3-10' },
    { ok: sop.passos.every(p => p.tempo > 0), msg: 'Todos passos com tempo' },
    { ok: sop.criterios.length >= 3 && sop.criterios.length <= 5, msg: 'Criterios entre 3-5' },
    { ok: sop.erros.length > 0, msg: 'Erros comuns documentados' },
    { ok: sop.prompt_validacao.length > 100, msg: 'Prompt de validacao criado' }
  ];

  return {
    completo: checks.every(c => c.ok),
    checks: checks
  };
}
```

---

# MINI-APP 4: Modelo de Delegacao Assistida

## 4.1 Objetivo
Configurar delegacao de tarefas com checkpoints de validacao por IA, permitindo evolucao de nivel de autonomia do delegado.

## 4.2 Telas

### Tela 1: Definicao da Delegacao
```
+----------------------------------------------------------+
|  DELEGACAO ASSISTIDA                                      |
|  ────────────────────────────────────────────────────────|
|                                                           |
|  Tarefa a delegar: [________________________________]     |
|                                                           |
|  Delegante (quem delega): [____________________]          |
|  Delegado (quem recebe): [____________________]           |
|                                                           |
|  Por que esta tarefa esta comigo?                         |
|  [ ] Ninguem mais sabe fazer                              |
|  [ ] Eu faco mais rapido                                  |
|  [ ] E critica demais para delegar                        |
|  [ ] Nao confio em ninguem                                |
|  [ ] Nunca tentei delegar                                 |
|                                                           |
|  [Proximo: Decompor Tarefa ->]                            |
+----------------------------------------------------------+
```

### Tela 2: Decomposicao da Tarefa
```
+------------------------------------------------------------------+
|  DECOMPOSICAO DA TAREFA                           [+ Adicionar]   |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  | # | Etapa | Tempo | Decisao? | Delegavel? |                   |
|  |---|-------|-------|----------|------------|                   |
|  | 1 | [___] | [__]m | [v]      | [v]        |                   |
|  | 2 | [___] | [__]m | [v]      | [v]        |                   |
|  | 3 | [___] | [__]m | [v]      | [v]        |                   |
|                                                                   |
|  TEMPO TOTAL: 45 min                                              |
|  ETAPAS DELEGAVEIS: 4 de 5                                        |
|                                                                   |
|  [<- Voltar]                    [Proximo: Matriz de Delegacao ->] |
+------------------------------------------------------------------+
```

### Tela 3: Matriz de Delegacao
```
+------------------------------------------------------------------+
|  MATRIZ DE DELEGACAO                                              |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  | Etapa | Delegado Faz | IA Faz | Delegante Faz | Checkpoint |  |
|  |-------|--------------|--------|---------------|------------|  |
|  | 1     | [__________] | [____] | [___________] | [________] |  |
|  | 2     | [__________] | [____] | [___________] | [________] |  |
|  | 3     | [__________] | [____] | [___________] | [________] |  |
|                                                                   |
|  NIVEL DE AUTONOMIA ATUAL: [v] 1/2/3/4/5                          |
|  NIVEL DE AUTONOMIA META: [v] 1/2/3/4/5                           |
|  PRAZO PARA META: [__] dias                                       |
|                                                                   |
|  [<- Voltar]                    [Proximo: Checkpoints ->]         |
+------------------------------------------------------------------+
```

### Tela 4: Configurar Checkpoints
```
+------------------------------------------------------------------+
|  CHECKPOINTS DE VALIDACAO                         [+ Adicionar]   |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  CHECKPOINT #1                                                    |
|  Apos qual etapa: [v]                                             |
|  O que validar: [________________________________]                |
|  Quem valida: [v] IA / Delegante / Ambos                          |
|  Criterio de sucesso: [________________________________]          |
|  Se falhar: [v] Refazer / Escalar / Pausar                        |
|                                                                   |
|  CHECKPOINT #2                                                    |
|  ...                                                              |
|                                                                   |
|  [<- Voltar]                    [Proximo: Gerar Prompts ->]       |
+------------------------------------------------------------------+
```

### Tela 5: Prompts de Delegacao
```
+------------------------------------------------------------------+
|  PROMPTS DE DELEGACAO                                             |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  PROMPT DE ASSISTENCIA (para o delegado usar)                     |
|  ┌────────────────────────────────────────────────────────────┐  |
|  │ [Prompt auto-gerado baseado nas etapas e criterios]        │  |
|  └────────────────────────────────────────────────────────────┘  |
|  [Copiar]  [Editar]                                               |
|                                                                   |
|  PROMPT DE VALIDACAO (para checkpoints)                           |
|  ┌────────────────────────────────────────────────────────────┐  |
|  │ [Prompt auto-gerado baseado nos criterios]                 │  |
|  └────────────────────────────────────────────────────────────┘  |
|  [Copiar]  [Editar]                                               |
|                                                                   |
|  [<- Voltar]                    [Proximo: Plano de Treinamento]   |
+------------------------------------------------------------------+
```

### Tela 6: Plano de Treinamento
```
+------------------------------------------------------------------+
|  PLANO DE TREINAMENTO (7 DIAS)                                    |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  | Dia | Atividade | Supervisao | Objetivo |                     |
|  |-----|-----------|------------|----------|                     |
|  | 1   | Observar  | 100%       | Entender |                     |
|  | 2   | Fazer junto| 80%       | Praticar |                     |
|  | 3   | Fazer + IA | 50%       | Validar  |                     |
|  | 4   | Reportar  | 30%        | Autonomia|                     |
|  | 5   | Avisar se erro| 10%    | Independ.|                     |
|  | 6-7 | Monitorar | 5%         | Estabilizar|                   |
|                                                                   |
|  METRICAS DE ACOMPANHAMENTO                                       |
|  [ ] Tarefas concluidas                                           |
|  [ ] Tarefas com erro                                             |
|  [ ] Escalacoes                                                   |
|  [ ] Tempo medio                                                  |
|                                                                   |
|  [Exportar PDF]  [Exportar para Notion]                           |
+------------------------------------------------------------------+
```

## 4.3 Campos e Tipos

| Campo | Tipo |
|-------|------|
| tarefa | string |
| delegante | string |
| delegado | string |
| motivos[] | string[] |
| etapas[] | { descricao, tempo, tem_decisao, delegavel } |
| matriz[] | { etapa, delegado_faz, ia_faz, delegante_faz, checkpoint } |
| nivel_atual | number 1-5 |
| nivel_meta | number 1-5 |
| prazo_dias | number |
| checkpoints[] | { apos_etapa, o_que, quem_valida, criterio, se_falhar } |
| prompt_assistencia | string |
| prompt_validacao | string |
| plano_treinamento[] | { dia, atividade, supervisao, objetivo } |

## 4.4 Logica de Negocio

### Geracao de Prompt de Assistencia
```javascript
function gerarPromptAssistencia(delegacao) {
  return `Voce e um assistente de execucao para ${delegacao.delegado}.

Tarefa atual: ${delegacao.tarefa}

Sua funcao:
1. Guiar passo a passo pela execucao
2. Validar cada etapa antes de avancar
3. Alertar se algo estiver fora do padrao
4. Sugerir correcoes quando necessario

Etapas da tarefa:
${delegacao.etapas.map((e, i) => `${i + 1}. ${e.descricao}`).join('\n')}

Criterios de qualidade:
${delegacao.checkpoints.map(c => `- ${c.criterio}`).join('\n')}

Regras:
- Se o delegado pular uma etapa, avise
- Se o resultado nao atender criterios, sugira correcao
- Se houver duvida critica, oriente a consultar ${delegacao.delegante}

Formato de resposta:
OK Etapa X: [OK / Precisa ajuste]
SUGESTAO: [Se aplicavel]
PROXIMA: [Instrucao]`;
}
```

---

# MINI-APP 5: Analise de ROI de Pessoas

## 5.1 Objetivo
Calcular o custo REAL de cada funcao (salario + encargos + ferramentas), estimar valor gerado, calcular ROI e decidir: Manter / Automatizar / Reestruturar.

## 5.2 Telas

### Tela 1: Dados da Empresa
```
+------------------------------------------+
|  ANALISE DE ROI DE PESSOAS               |
|  ────────────────────────────────────    |
|                                          |
|  Empresa: [___________________]          |
|  Faturamento Mensal: R$ [___________]    |
|  Folha de Pagamento Total: R$ [______]   |
|  % Folha/Faturamento: [auto] %           |
|                                          |
|  [Proximo: Adicionar Funcoes ->]         |
+------------------------------------------+
```

### Tela 2: Inventario de Funcoes
```
+------------------------------------------------------------------+
|  FUNCOES DA EMPRESA                               [+ Adicionar]   |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  | Funcao | Pessoa | Tipo | Horas/Sem | Salario Bruto |          |
|  |--------|--------|------|-----------|---------------|          |
|  | [____] | [____] | [v]  | [__]      | R$ [_______]  | [Detalhar]|
|  | [____] | [____] | [v]  | [__]      | R$ [_______]  | [Detalhar]|
|  | ...                                                            |
|                                                                   |
|  [<- Voltar]                    [Calcular Custos Totais ->]       |
+------------------------------------------------------------------+
```

### Tela 3: Calculadora de Custo por Funcao
```
+------------------------------------------------------------------+
|  CUSTO TOTAL: [Nome da Funcao]                                    |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  SALARIO E ENCARGOS                                               |
|  Salario Bruto: R$ [_______]                                      |
|  Tipo de contrato: [v] CLT / PJ / Freelancer                      |
|                                                                   |
|  Se CLT:                                                          |
|  ┌────────────────────────────────────────────────────────────┐  |
|  │ INSS Patronal (20%):        R$ [auto]                      │  |
|  │ FGTS (8%):                  R$ [auto]                      │  |
|  │ Ferias + 1/3 (11%):         R$ [auto]                      │  |
|  │ 13o (8%):                   R$ [auto]                      │  |
|  │ Outros (3%):                R$ [auto]                      │  |
|  │ ─────────────────────────────────────                      │  |
|  │ SUBTOTAL ENCARGOS:          R$ [auto]                      │  |
|  └────────────────────────────────────────────────────────────┘  |
|                                                                   |
|  BENEFICIOS                                                       |
|  Vale Refeicao: R$ [_____]                                        |
|  Vale Transporte: R$ [_____]                                      |
|  Plano de Saude: R$ [_____]                                       |
|  Outros beneficios: R$ [_____]                                    |
|                                                                   |
|  CUSTOS INDIRETOS                                                 |
|  Ferramentas/Software: R$ [_____]                                 |
|  Equipamento (amortizado): R$ [_____]                             |
|  Espaco (% aluguel): R$ [_____]                                   |
|  Tempo de gestao: R$ [_____]                                      |
|                                                                   |
|  ══════════════════════════════════════════════════════════════  |
|  CUSTO TOTAL MENSAL: R$ [auto]                                    |
|  CUSTO POR HORA: R$ [auto]                                        |
|  ══════════════════════════════════════════════════════════════  |
|                                                                   |
|  [<- Voltar]                    [Proximo: Valor Gerado ->]        |
+------------------------------------------------------------------+
```

### Tela 4: Calculadora de Valor Gerado
```
+------------------------------------------------------------------+
|  VALOR GERADO: [Nome da Funcao]                                   |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  TIPO DE FUNCAO: [v] Receita Direta / Suporte / Compliance        |
|                                                                   |
|  Se RECEITA DIRETA (Vendas, Prestacao):                           |
|  Receita mensal gerada: R$ [_________]                            |
|  Como mediu: [________________________________]                   |
|                                                                   |
|  Se RECEITA INFLUENCIADA (Marketing, SDR):                        |
|  Leads gerados: [____] x Taxa conversao: [__]% x Ticket: R$ [___] |
|  = Receita influenciada: R$ [auto]                                |
|                                                                   |
|  Se CUSTO EVITADO (Juridico, Compliance, Financeiro):             |
|  Erros prevenidos: [____] x Custo medio erro: R$ [_____]          |
|  = Custo evitado: R$ [auto]                                       |
|                                                                   |
|  Se HABILITADOR (TI, RH, Operacoes):                              |
|  Horas liberadas de outros: [___] x Valor/hora: R$ [____]         |
|  = Valor habilitado: R$ [auto]                                    |
|                                                                   |
|  ══════════════════════════════════════════════════════════════  |
|  VALOR TOTAL GERADO: R$ [auto]                                    |
|  ══════════════════════════════════════════════════════════════  |
|                                                                   |
|  [<- Voltar]                    [Calcular ROI ->]                 |
+------------------------------------------------------------------+
```

### Tela 5: Matriz de ROI
```
+------------------------------------------------------------------+
|  MATRIZ DE ROI                                                    |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  | Funcao | Custo | Valor | ROI | Status | Acao |                |
|  |--------|-------|-------|-----|--------|------|                |
|  | Vendas | 12K   | 45K   |275% | VERDE  | E    |                |
|  | SDR    | 6K    | 15K   |150% | VERDE  | M    |                |
|  | Atend. | 5K    | 8K    | 60% | AMARELO| O    |                |
|  | Financ.| 7K    | 5K    |-29% | VERMELHO| A   |                |
|                                                                   |
|  LEGENDA                                                          |
|  Status: VERDE (>100%) | AMARELO (0-100%) | VERMELHO (<0%)        |
|  Acao: M=Manter | E=Expandir | O=Otimizar | R=Reestruturar | A=Auto|
|                                                                   |
|  RESUMO                                                           |
|  ┌────────────────────────────────────────────────────────────┐  |
|  │ Custo total da equipe: R$ 30.000/mes                       │  |
|  │ Valor total gerado: R$ 73.000/mes                          │  |
|  │ ROI medio: 143%                                            │  |
|  │ Funcoes para automatizar: 2                                │  |
|  │ Economia potencial: R$ 8.500/mes                           │  |
|  └────────────────────────────────────────────────────────────┘  |
|                                                                   |
|  [Analisar Automacao]  [Gerar Plano de Acao]  [Exportar]          |
+------------------------------------------------------------------+
```

### Tela 6: Analise de Automacao
```
+------------------------------------------------------------------+
|  ANALISE DE AUTOMACAO: [Nome da Funcao]                           |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  POTENCIAL DE AUTOMACAO                                           |
|  % do tempo repetitivo: [____]%                                   |
|  % segue regras claras: [____]%                                   |
|  % requer julgamento humano: [____]%                              |
|                                                                   |
|  FERRAMENTA SUGERIDA                                              |
|  [v] ChatGPT / n8n / Zapier / Custom / Nao aplicavel              |
|                                                                   |
|  CUSTO DA AUTOMACAO                                               |
|  Setup inicial: R$ [_____]                                        |
|  Custo mensal: R$ [_____]                                         |
|                                                                   |
|  ROI DA AUTOMACAO                                                 |
|  Economia mensal: R$ [auto]                                       |
|  Payback: [auto] meses                                            |
|                                                                   |
|  DECISAO SOBRE A PESSOA                                           |
|  [v] Realocar para funcao maior valor                             |
|  [v] Treinar para nova funcao                                     |
|  [v] Reduzir carga horaria                                        |
|  [v] Descontinuar                                                 |
|                                                                   |
|  [<- Voltar]                    [Adicionar ao Plano de Acao]      |
+------------------------------------------------------------------+
```

### Tela 7: Plano de Acao
```
+------------------------------------------------------------------+
|  PLANO DE ACAO                                                    |
|  ────────────────────────────────────────────────────────────────|
|                                                                   |
|  CENARIO RECOMENDADO: Reestruturar + Automatizar                  |
|                                                                   |
|  | Prioridade | Funcao | Acao | Responsavel | Prazo | Economia | |
|  |------------|--------|------|-------------|-------|----------|  |
|  | 1          | Financ.| Auto | [________]  | [__]d | R$ 5.000 |  |
|  | 2          | Assist.| Auto | [________]  | [__]d | R$ 3.500 |  |
|  | 3          | Atend. | Otim.| [________]  | [__]d | R$ 2.000 |  |
|                                                                   |
|  ECONOMIA TOTAL PROJETADA: R$ 10.500/mes                          |
|  ECONOMIA ANUAL: R$ 126.000                                       |
|                                                                   |
|  [Validar com IA]  [Exportar PDF]  [Exportar Planilha]            |
+------------------------------------------------------------------+
```

## 5.3 Formulas de Calculo

```javascript
// Custo Total CLT
function calcularCustoCLT(salario, beneficios, indiretos) {
  const encargos = {
    inss: salario * 0.20,
    fgts: salario * 0.08,
    ferias: salario * 0.11,
    decimo: salario * 0.08,
    outros: salario * 0.03
  };

  const totalEncargos = Object.values(encargos).reduce((a, b) => a + b, 0);
  const totalBeneficios = Object.values(beneficios).reduce((a, b) => a + b, 0);
  const totalIndiretos = Object.values(indiretos).reduce((a, b) => a + b, 0);

  return {
    encargos,
    totalEncargos,
    totalBeneficios,
    totalIndiretos,
    custoTotal: salario + totalEncargos + totalBeneficios + totalIndiretos,
    custoPorHora: (salario + totalEncargos + totalBeneficios + totalIndiretos) / (44 * 4) // 44h/sem * 4 sem
  };
}

// ROI
function calcularROI(custoTotal, valorGerado) {
  return ((valorGerado - custoTotal) / custoTotal) * 100;
}

// Status baseado no ROI
function getStatus(roi) {
  if (roi > 100) return { cor: 'verde', acao: 'Manter/Expandir' };
  if (roi >= 0) return { cor: 'amarelo', acao: 'Otimizar' };
  return { cor: 'vermelho', acao: 'Automatizar/Reestruturar' };
}

// ROI da Automacao
function calcularROIAutomacao(custoFuncao, custoAutomacaoMensal, custoSetup) {
  const economiaMensal = custoFuncao - custoAutomacaoMensal;
  const paybackMeses = custoSetup / economiaMensal;
  const roiAnual = ((economiaMensal * 12 - custoSetup) / custoSetup) * 100;

  return { economiaMensal, paybackMeses, roiAnual };
}
```

---

# Proximos Passos

## Para @architect
1. Validar stack sugerida (Next.js + Tailwind + shadcn/ui)
2. Definir estrutura de repositorio (monorepo ou repos separados?)
3. Definir estrategia de deploy (Vercel? Self-hosted?)
4. Definir se quer backend opcional (Supabase para sync?)

## Para @dev
1. Criar repo template base com estrutura comum
2. Implementar Mini-App 1 (Mapa de Dependencia) como MVP
3. Validar com stakeholders
4. Replicar para os outros 4 apps

## Prioridade de Implementacao

| Ordem | Mini-App | Complexidade | Impacto |
|-------|----------|--------------|---------|
| 1 | Mapa de Dependencia Humana | Media | Alto |
| 2 | Analise ROI Pessoas | Alta | Alto |
| 3 | SOP Inteligente | Media | Alto |
| 4 | Matriz Funcao x Decisao | Baixa | Medio |
| 5 | Delegacao Assistida | Alta | Medio |

---

**Documento gerado por:** Course Architect Agent
**Data:** 2025-01-03
**Versao:** 1.0
