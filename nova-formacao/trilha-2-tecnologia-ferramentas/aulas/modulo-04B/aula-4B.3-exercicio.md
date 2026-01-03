# Aula 4B.3: Projeto Prático Completo

## Tipo: Exercício | Duração: 20 minutos

---

## GPS

### Goal (30s)
Construir um projeto completo usando IDE com IA: API + Frontend + Testes.

### Position (60s)
Você aprendeu as ferramentas. Agora vai usar todas juntas em um projeto real.

### Steps
1. Definir projeto (2 min)
2. Criar backend (8 min)
3. Criar frontend (6 min)
4. Adicionar testes (4 min)

---

## Passo 1: Escolha seu Projeto

### Opções

| Projeto | Stack | Complexidade |
|---------|-------|--------------|
| API de Tarefas | Node + Express | Básica |
| Sistema de Notas | Python + FastAPI | Básica |
| Dashboard de Vendas | React + Chart.js | Média |
| Chat em Tempo Real | Node + Socket.io | Média |

### Meu Projeto

**Nome:** _______________
**Stack:** _______________

---

## Passo 2: Criar Backend

### 2.1 Estrutura Inicial

Abra Cursor, crie pasta e use `Cmd/Ctrl + K`:

```
Crie estrutura de projeto Node.js com:
- Express para API REST
- TypeScript
- Estrutura de pastas organizada (src/routes, src/controllers, src/services)
- Package.json com scripts de dev e build
- Tsconfig.json configurado
```

### 2.2 Endpoints

Após criar estrutura, no arquivo de rotas:

```
Crie endpoints REST para gerenciar [seu recurso]:
- GET /[recursos] - listar todos
- GET /[recursos]/:id - buscar um
- POST /[recursos] - criar
- PUT /[recursos]/:id - atualizar
- DELETE /[recursos]/:id - deletar

Inclua validação de dados e tratamento de erros.
Use array em memória como "banco de dados" temporário.
```

### 2.3 Documentação

```
Adicione comentários JSDoc em todas as funções
e crie um README.md explicando como rodar o projeto.
```

### Checklist Backend

- [ ] Estrutura de pastas criada
- [ ] Endpoints funcionando
- [ ] Validação implementada
- [ ] Tratamento de erros
- [ ] Documentação básica

---

## Passo 3: Criar Frontend

### 3.1 Estrutura

Em nova pasta (ou subpasta `frontend/`):

```
Crie aplicação React com Vite que:
- Consome a API criada
- Lista [recursos]
- Formulário para criar novo
- Botões para editar/deletar
- Estilo com Tailwind CSS
- Responsivo
```

### 3.2 Componentes

```
Crie componentes separados para:
- Header com título
- Lista de [recursos] com cards
- Formulário de criação/edição
- Modal de confirmação para deletar
```

### 3.3 Integração

```
Configure axios para consumir a API em http://localhost:3000
Adicione loading states e tratamento de erros nas chamadas
```

### Checklist Frontend

- [ ] App React funcionando
- [ ] Lista renderizando dados
- [ ] Formulário criando novos itens
- [ ] Edição funcionando
- [ ] Delete com confirmação
- [ ] Responsivo

---

## Passo 4: Adicionar Testes

### 4.1 Testes do Backend

Selecione seu arquivo de controller/service e:

```
Gere testes unitários com Jest para todas as funções:
- Teste de sucesso para cada operação
- Teste de erro (item não encontrado)
- Teste de validação (dados inválidos)
```

### 4.2 Testes do Frontend

Selecione um componente e:

```
Gere testes com React Testing Library:
- Teste se renderiza corretamente
- Teste interação do usuário (click, submit)
- Teste estado de loading
```

### 4.3 Rodar Testes

```bash
npm test
```

### Checklist Testes

- [ ] Testes do backend criados
- [ ] Testes do frontend criados
- [ ] Todos passando

---

## Documentação do Projeto

### Arquivos Criados

| Pasta/Arquivo | Propósito |
|---------------|-----------|
| `backend/` | |
| `frontend/` | |
| `README.md` | |

### Comandos Usados

| # | Comando dado à IA | Resultado |
|---|-------------------|-----------|
| 1 | | |
| 2 | | |
| 3 | | |
| 4 | | |
| 5 | | |

### Tempo Total

| Etapa | Tempo |
|-------|-------|
| Estrutura | ___ min |
| Backend | ___ min |
| Frontend | ___ min |
| Testes | ___ min |
| **Total** | ___ min |

---

## Métricas de Produtividade

### Compare com desenvolvimento tradicional

| Métrica | Com IA | Sem IA (estimado) |
|---------|--------|-------------------|
| Linhas de código | ___ | ___ |
| Tempo total | ___ min | ___ horas |
| Pesquisas no Google | ___ | ___ |
| Erros de sintaxe | ___ | ___ |

---

## Troubleshooting

### Se algo não funcionar

1. **Erro de sintaxe:**
   - Cmd/Ctrl + L: "Esse erro está acontecendo: [cole o erro]"

2. **Lógica errada:**
   - Selecione o código → "Isso deveria fazer X, mas faz Y. Corrija."

3. **Integração falhou:**
   - "A API retorna 404. O endpoint está em /api/recursos. O que pode estar errado?"

4. **Teste falhando:**
   - Cole o output do teste: "Por que esse teste está falhando?"

---

## Próximo Passo

Deploy do projeto e compromisso de 48h para usar IDE com IA no dia a dia.
