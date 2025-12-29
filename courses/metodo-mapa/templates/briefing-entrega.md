# BRIEFING M.A.P.A.™ - Template para Delegar Entregas à IA

**Projeto:** [NOME DO PROJETO]
**Bloco:** [NÚMERO E NOME]
**Entrega:** [NÚMERO E NOME]
**Data:** [DATA]
**Tempo Máximo:** [2-4 horas]

---

## 🎯 COMANDO RÁPIDO PARA IA

```
Execute a Entrega [X.X] conforme este briefing. Trabalhe de forma autônoma,
documente cada decisão importante, e quando terminar, execute os testes de
validação listados nos critérios de conclusão. Você tem [X] horas.
```

---

## 📋 CONTEXTO DO PROJETO

### Blueprint Resumido
[Cole aqui as seções relevantes do Blueprint principal, especialmente:]
- Visão Geral (O quê, Para quem, Por quê)
- Tech Stack definida
- Restrições principais

### Estado Atual
- **Blocos Completos:** [Liste quais blocos já foram finalizados]
- **Entregas Anteriores:** [Liste entregas relacionadas já feitas]
- **Dependências Disponíveis:** [O que já existe que esta entrega precisa]

### Arquivos Relevantes
```
/src/[...]  - [Descrição]
/config/[...] - [Descrição]
/docs/[...] - [Descrição]
```

---

## 🎯 TAREFA ESPECÍFICA

### Objetivo desta Entrega
[Descreva em 1-2 frases claras qual é o objetivo final desta entrega]

### Escopo Detalhado

**O QUE FAZER (em ordem):**

1. **[Primeira tarefa específica]**
   - Subtarefa detalhada
   - Subtarefa detalhada
   - Resultado esperado: [descreva]

2. **[Segunda tarefa específica]**
   - Subtarefa detalhada
   - Subtarefa detalhada
   - Resultado esperado: [descreva]

3. **[Terceira tarefa específica]**
   - Subtarefa detalhada
   - Subtarefa detalhada
   - Resultado esperado: [descreva]

[Continue numerando todas as tarefas necessárias]

### Exemplo Concreto

```javascript
// Exemplo do resultado esperado (se aplicável)
// Mostre um snippet de código, estrutura de arquivo,
// ou output esperado para deixar SUPER claro
```

---

## 🛠️ ESPECIFICAÇÕES TÉCNICAS

### Stack/Ferramentas para esta Entrega
- **Linguagem:** [específica]
- **Framework:** [específico]
- **Bibliotecas:** [liste todas necessárias]
- **Banco de Dados:** [se aplicável]
- **APIs Externas:** [se aplicável]

### Padrões a Seguir
- [ ] Convenção de nomenclatura: [camelCase, snake_case, etc]
- [ ] Estrutura de arquivos: [onde criar novos arquivos]
- [ ] Padrão de commits: [feat:, fix:, etc]
- [ ] Estilo de código: [link para styleguide se houver]

### Configurações Específicas
```env
# Variáveis de ambiente necessárias
API_KEY=
DATABASE_URL=
[...]
```

---

## ✅ CRITÉRIOS DE CONCLUSÃO

### Funcionalidades (O que deve funcionar)
- [ ] [Critério objetivo e testável]
- [ ] [Critério objetivo e testável]
- [ ] [Critério objetivo e testável]

*Exemplo:*
- [ ] Endpoint POST /api/users retorna 201 com usuário criado
- [ ] Validação de email rejeita formatos inválidos
- [ ] Senha é hasheada com bcrypt antes de salvar

### Testes de Validação (Como verificar)
```bash
# Comandos para testar se funcionou
npm test
curl -X POST http://localhost:3000/api/test
[...]
```

### Qualidade de Código
- [ ] Sem erros de linting
- [ ] Sem warnings no console
- [ ] Código comentado onde não é óbvio
- [ ] README atualizado se necessário

### Entregáveis Esperados
- [ ] Arquivo(s): [liste os arquivos que devem ser criados/modificados]
- [ ] Documentação: [se aplicável]
- [ ] Testes: [se aplicável]
- [ ] Migrations: [se aplicável]

---

## 🚫 RESTRIÇÕES (MUITO IMPORTANTE!)

### NÃO FAZER
- ❌ [Coisa que IA não deve fazer]
- ❌ [Feature que não é parte desta entrega]
- ❌ [Overengineering a evitar]
- ❌ [Decisão que não deve tomar sozinha]

*Exemplo:*
- ❌ NÃO implementar autenticação (próxima entrega)
- ❌ NÃO criar interface gráfica ainda
- ❌ NÃO mudar tech stack definida
- ❌ NÃO adicionar features não solicitadas

### Limites Técnicos
- Máximo de [X] arquivos novos
- Máximo de [X] linhas de código
- Máximo de [X] dependências novas

### Se Encontrar Problemas
```
SE erro de dependência:
  1. Tente versão anterior estável
  2. Documente o erro
  3. Continue com próxima tarefa

SE decisão arquitetural necessária:
  1. Documente as opções
  2. Escolha a mais simples
  3. Marque como "REVIEW NEEDED"

SE tarefa maior que esperado:
  1. Complete o essencial
  2. Documente o que falta
  3. Sugira nova entrega para o resto
```

---

## 📝 INSTRUÇÕES ESPECIAIS

### Ordem de Prioridade
1. **Crítico:** [O que DEVE funcionar]
2. **Importante:** [O que DEVERIA funcionar]
3. **Nice to have:** [O que PODERIA ter se sobrar tempo]

### Estilo de Documentação
```javascript
/**
 * Documenter assim funções não-óbvias
 * @param {tipo} nome - descrição
 * @returns {tipo} descrição
 */
```

### Convenções de Commit
```
feat: para novas funcionalidades
fix: para correções
refactor: para melhorias sem mudar funcionalidade
docs: para documentação
test: para testes
```

---

## 🔄 HANDOFF

### Como Entregar

Quando terminar, gere um relatório com:

```markdown
## ENTREGA [X.X] CONCLUÍDA

### ✅ O que foi feito
- [Lista do que foi implementado]

### ⚠️ Observações
- [Decisões tomadas]
- [Problemas encontrados]

### 🔍 Como testar
- [Passo a passo para validar]

### 📝 Próximos passos sugeridos
- [O que fazer na sequência]

### Tempo gasto: [X]h [Y]min
```

### Arquivos Criados/Modificados
```
created: /path/to/new/file.js
modified: /path/to/existing/file.js
deleted: /path/to/removed/file.js
```

---

## ⏱️ GESTÃO DE TEMPO

### Sugestão de Distribuição
- **Setup/Compreensão:** 15 min
- **Implementação Principal:** 60-70% do tempo
- **Testes e Validação:** 20% do tempo
- **Documentação e Cleanup:** 10% do tempo

### Checkpoints
- [ ] 30 min: Setup completo, começando implementação
- [ ] 1h: Funcionalidade core implementada
- [ ] 1h30: Testes rodando
- [ ] 2h: Entrega completa e documentada

---

## 🆘 QUANDO PARAR E PEDIR AJUDA

PARE imediatamente se:
- A tarefa claramente levará >4h
- Precisa tomar decisão de arquitetura maior
- Vai mudar algo do Blueprint original
- Encontrou bug crítico em código existente
- Precisa de credenciais/acessos não fornecidos

---

## EXEMPLO PREENCHIDO (para referência)

<details>
<summary>Clique para ver exemplo real de briefing</summary>

```markdown
# BRIEFING - Entrega 2.1: APIs de Gestão de Leads

**Projeto:** NutriFlow CRM
**Bloco:** 2 - Backend
**Entrega:** 2.1 - APIs de Gestão de Leads
**Tempo Máximo:** 3 horas

## TAREFA ESPECÍFICA

Criar endpoints REST para CRUD completo de leads, incluindo:

1. POST /api/leads - Criar lead
   - Validar email único
   - Gerar score automático
   - Retornar 201 com lead criado

2. GET /api/leads - Listar com paginação
   - Limit/offset params
   - Filtros por status e score
   - Ordenação configurável

3. GET /api/leads/:id - Detalhe do lead
4. PUT /api/leads/:id - Atualizar lead
5. DELETE /api/leads/:id - Soft delete

[... resto do briefing ...]
```

</details>

---

## APROVAÇÃO DO BRIEFING

**Preparado por:** _________________
**Revisado por:** _________________
**IA Designada:** [Claude Code | Cursor | Mind Mapper]

---

*Template de Briefing M.A.P.A.™ v2.0*
*"IA com briefing claro trabalha 10x melhor que dev sem especificação."*