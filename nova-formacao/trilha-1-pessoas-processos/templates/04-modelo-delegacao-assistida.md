# Template: Modelo de Delegacao Assistida

## Trilha 1 - Modulo 4 | Pessoas & Processos

---

## Instrucoes de Uso

1. Escolha 1 tarefa que voce FAZ mas NAO deveria fazer
2. Defina o nivel de autonomia desejado
3. Configure os checkpoints de validacao com IA
4. Treine a pessoa + IA juntos
5. Monitore por 7 dias, depois solte

---

## Por Que Delegacao Tradicional Falha

| Delegacao Tradicional | Delegacao Assistida |
|-----------------------|---------------------|
| "Faz isso pra mim" | "Faz isso COM a IA validando" |
| Microgestao constante | Checkpoints automaticos |
| Erro descoberto no final | Erro corrigido no passo |
| Dependencia do delegador | Autonomia progressiva |
| "Nao ficou bom, refaz" | "IA ja validou, pode seguir" |

---

## Os 5 Niveis de Autonomia

| Nivel | Nome | Descricao | Quando Usar |
|-------|------|-----------|-------------|
| **1** | Esperar Comando | Nao faz nada sem pedir | Tarefas criticas, pessoa nova |
| **2** | Fazer e Reportar | Executa, depois mostra | Tarefas recorrentes, confiavel |
| **3** | Fazer e Avisar se Problema | So avisa se algo der errado | Processos padronizados |
| **4** | Fazer e Validar com IA | IA valida antes de entregar | SOPs com criterios claros |
| **5** | Autonomia Total | Faz do inicio ao fim | Pessoa senior, alta confianca |

---

## Template Principal

### Informacoes

| Campo | Valor |
|-------|-------|
| **Empresa** | |
| **Tarefa a Delegar** | |
| **Delegante (quem delega)** | |
| **Delegado (quem recebe)** | |
| **Data de Inicio** | |
| **Meta de Nivel** | De __ para __ em __ dias |

---

### 1. ANALISE DA TAREFA

#### 1.1 Por Que Esta Tarefa Esta Comigo?

- [ ] Ninguem mais sabe fazer
- [ ] Eu faco mais rapido
- [ ] E critica demais para delegar
- [ ] Nao confio em ninguem
- [ ] Nunca tentei delegar
- [ ] Outro: ___

#### 1.2 Decomposicao da Tarefa

| Etapa | Descricao | Tempo | Decisao Envolvida? | Delegavel? |
|-------|-----------|-------|-------------------|------------|
| 1 | | min | Sim / Nao | Sim / Nao |
| 2 | | min | Sim / Nao | Sim / Nao |
| 3 | | min | Sim / Nao | Sim / Nao |
| 4 | | min | Sim / Nao | Sim / Nao |
| 5 | | min | Sim / Nao | Sim / Nao |

**Tempo total:** ___ minutos

**Etapas delegaveis:** ___ de ___

---

### 2. PERFIL DO DELEGADO

| Campo | Avaliacao |
|-------|-----------|
| **Nome** | |
| **Cargo/Funcao** | |
| **Tempo na empresa** | |
| **Experiencia com tarefas similares** | Nenhuma / Pouca / Media / Alta |
| **Nivel de autonomia atual** | 1 / 2 / 3 / 4 / 5 |
| **Nivel de autonomia desejado** | 1 / 2 / 3 / 4 / 5 |
| **Pontos fortes** | |
| **Pontos de atencao** | |

---

### 3. MATRIZ DE DELEGACAO

| Etapa | Delegado Faz | IA Faz | Delegante Faz | Checkpoint |
|-------|--------------|--------|---------------|------------|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |

**Legenda:**
- **Delegado Faz:** Execucao principal
- **IA Faz:** Validacao, sugestao, revisao
- **Delegante Faz:** Aprovacao final (se necessario)
- **Checkpoint:** Quando e como validar

---

### 4. CHECKPOINTS DE VALIDACAO

#### Checkpoint #1

| Campo | Valor |
|-------|-------|
| **Apos qual etapa** | |
| **O que validar** | |
| **Quem valida** | IA / Delegante / Ambos |
| **Criterio de sucesso** | |
| **Se falhar** | Refazer / Escalar / Pausar |

#### Checkpoint #2

| Campo | Valor |
|-------|-------|
| **Apos qual etapa** | |
| **O que validar** | |
| **Quem valida** | IA / Delegante / Ambos |
| **Criterio de sucesso** | |
| **Se falhar** | Refazer / Escalar / Pausar |

#### Checkpoint Final

| Campo | Valor |
|-------|-------|
| **Apos qual etapa** | |
| **O que validar** | |
| **Quem valida** | IA / Delegante / Ambos |
| **Criterio de sucesso** | |
| **Se falhar** | Refazer / Escalar / Pausar |

---

### 5. PROMPT DE ASSISTENCIA (Para o Delegado)

```
Voce e um assistente de execucao para [NOME DO DELEGADO].

Tarefa atual: [NOME DA TAREFA]

Sua funcao:
1. Guiar passo a passo pela execucao
2. Validar cada etapa antes de avancar
3. Alertar se algo estiver fora do padrao
4. Sugerir correcoes quando necessario

Etapas da tarefa:
1. [ETAPA 1]
2. [ETAPA 2]
3. [ETAPA 3]

Criterios de qualidade:
- [CRITERIO 1]
- [CRITERIO 2]
- [CRITERIO 3]

Regras:
- Se o delegado pular uma etapa, avise
- Se o resultado nao atender criterios, sugira correcao
- Se houver duvida critica, oriente a consultar [DELEGANTE]

Formato de resposta:
✅ Etapa X: [OK / Precisa ajuste]
💡 Sugestao: [Se aplicavel]
➡️ Proxima etapa: [Instrucao]
```

---

### 6. PROMPT DE VALIDACAO (Para IA)

```
Voce e um validador de qualidade para a tarefa: [NOME DA TAREFA]

Revise o seguinte resultado:

---
[COLAR RESULTADO AQUI]
---

Verifique os criterios:
1. [CRITERIO 1]
2. [CRITERIO 2]
3. [CRITERIO 3]

Para cada criterio:
✅ OK - Atende completamente
⚠️ PARCIAL - Atende com ressalvas
❌ FALHA - Nao atende

Veredicto final:
- Se todos ✅: "APROVADO - Pode entregar"
- Se algum ⚠️: "APROVADO COM RESSALVAS - Melhorias sugeridas: [lista]"
- Se algum ❌: "REPROVADO - Refazer: [lista do que corrigir]"
```

---

### 7. PLANO DE TREINAMENTO

| Dia | Atividade | Nivel de Supervisao | Objetivo |
|-----|-----------|---------------------|----------|
| 1 | Observar delegante fazer | 100% | Entender o processo |
| 2 | Fazer junto com delegante | 80% | Praticar com suporte |
| 3 | Fazer com IA assistindo | 50% | Validacao automatica |
| 4 | Fazer e reportar | 30% | Aumentar autonomia |
| 5 | Fazer e avisar se problema | 10% | Quase independente |
| 6-7 | Monitorar indicadores | 5% | Validar qualidade |

---

### 8. ESCALA DE ESCALACAO

| Situacao | Acao | Tempo de Resposta |
|----------|------|-------------------|
| Duvida simples | Consultar prompt da IA | Imediato |
| Duvida complexa | Perguntar ao delegante via chat | 1 hora |
| Erro reversivel | Corrigir com orientacao da IA | Imediato |
| Erro irreversivel | Parar e escalar ao delegante | Imediato |
| Cliente insatisfeito | Escalar ao delegante | Imediato |
| Decisao fora do escopo | Parar e consultar | 30 min |

---

### 9. METRICAS DE ACOMPANHAMENTO

| Metrica | Semana 1 | Semana 2 | Semana 3 | Semana 4 |
|---------|----------|----------|----------|----------|
| Tarefas concluidas | | | | |
| Tarefas com erro | | | | |
| Escalacoes ao delegante | | | | |
| Tempo medio por tarefa | | | | |
| Nivel de autonomia | | | | |
| Satisfacao do delegante (1-5) | | | | |

---

### 10. CHECKLIST DE DELEGACAO

#### Antes de Delegar
- [ ] Tarefa documentada (SOP ou instrucao clara)
- [ ] Criterios de qualidade definidos
- [ ] Prompt de assistencia configurado
- [ ] Prompt de validacao configurado
- [ ] Delegado treinado (min 2 dias)
- [ ] Escala de escalacao combinada

#### Durante a Delegacao (Semana 1)
- [ ] Checkpoint diario de 15 min
- [ ] Revisar primeiras 3 entregas
- [ ] Ajustar prompts se necessario
- [ ] Registrar duvidas frequentes

#### Apos Estabilizar (Semana 2+)
- [ ] Checkpoint semanal de 30 min
- [ ] Revisar metricas
- [ ] Aumentar nivel de autonomia
- [ ] Adicionar novas tarefas gradualmente

---

## Exemplo Preenchido

### Tarefa: Responder E-mails de Suporte Nivel 1

| Campo | Valor |
|-------|-------|
| **Delegante** | Maria (CEO) |
| **Delegado** | Joao (Assistente) |
| **Meta** | De nivel 2 para nivel 4 em 14 dias |

#### Matriz de Delegacao

| Etapa | Joao Faz | IA Faz | Maria Faz |
|-------|----------|--------|-----------|
| Ler email | X | Classificar urgencia | - |
| Buscar resposta | X | Sugerir da KB | - |
| Redigir resposta | X | Revisar tom/clareza | - |
| Enviar | X | Validar antes de enviar | - |
| Escalar se complexo | X | Identificar quando | Resolver |

#### Prompt de Assistencia

```
Voce e um assistente de suporte para Joao.

Ao receber um email:
1. Classifique: Duvida / Reclamacao / Solicitacao / Urgente
2. Busque resposta na base de conhecimento
3. Sugira resposta
4. Revise tom (profissional, empatico)
5. Se nao encontrar resposta ou for reclamacao grave: "ESCALAR PARA MARIA"

Exemplo de resposta:
[Modelo de resposta padrao aqui]
```

---

## Armadilhas Comuns

| Armadilha | Por Que Acontece | Como Evitar |
|-----------|------------------|-------------|
| Delegar sem treinar | Pressa | Min 2 dias de treinamento |
| Voltar a fazer | "E mais rapido" | Investir tempo no inicio |
| Checkpoints demais | Medo de erro | Maximo 3 checkpoints |
| Checkpoints de menos | Excesso de confianca | Minimo 1 checkpoint |
| Nao usar a IA | Esquecimento | Incluir no fluxo obrigatorio |

---

## Proximos Passos

Apos configurar a delegacao:

1. **Dia 1-2:** Treinar delegado + IA juntos
2. **Dia 3-5:** Supervisionar primeiras execucoes
3. **Dia 6-14:** Monitorar metricas, reduzir supervisao
4. **Apos 14 dias:** Avaliar nivel de autonomia alcancado
5. **Avance para o Modulo 5** (ROI de Pessoas)

---

**Template versao:** 1.0
**Trilha:** Pessoas & Processos
**Modulo:** 4 - Delegacao Assistida
