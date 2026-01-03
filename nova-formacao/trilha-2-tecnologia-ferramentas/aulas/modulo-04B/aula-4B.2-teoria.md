# Aula 4B.2: Dominando IDEs com IA

## Tipo: Teoria | Duração: 15 minutos

---

## GPS

### Goal (30s)
Entender todas as funcionalidades das IDEs com IA e quando usar cada uma.

### Position (60s)
Você usou o básico. Agora vai aprender os superpoderes.

### Steps
1. Funcionalidades essenciais (5 min)
2. Comparativo de IDEs (4 min)
3. Workflows avançados (6 min)

---

## Funcionalidades Essenciais

### 1. Autocomplete Inteligente

```
Você digita:    function calcular
IA sugere:      function calcularImpostoRenda(salarioBruto: number): number {
                  const faixas = [
                    { limite: 1903.98, aliquota: 0, deducao: 0 },
                    ...
                  ]
                }
```

**Quando usar:** Sempre. Deixe ligado.

**Dica:** Quanto mais contexto (arquivos abertos, código existente), melhor a sugestão.

---

### 2. Chat Inline (Cmd/Ctrl + K)

**O que faz:** Gera ou modifica código no lugar

**Exemplos de uso:**

| Situação | Comando |
|----------|---------|
| Criar função | "Crie função que valida CPF" |
| Modificar | "Adicione tratamento de erro aqui" |
| Converter | "Converta isso para async/await" |
| Otimizar | "Otimize essa query SQL" |

**Dica:** Selecione código antes de Cmd+K para modificar especificamente aquele trecho.

---

### 3. Chat Lateral (Cmd/Ctrl + L)

**O que faz:** Conversa sobre código sem modificar

**Exemplos de uso:**

| Situação | Pergunta |
|----------|----------|
| Entender | "Explique o que esse código faz" |
| Debug | "Por que está dando esse erro?" |
| Arquitetura | "Qual a melhor forma de organizar isso?" |
| Segurança | "Tem vulnerabilidade nesse código?" |

**Dica:** Cole mensagens de erro para diagnóstico rápido.

---

### 4. Seleção + Comando

Selecione código e peça:

| Comando | Resultado |
|---------|-----------|
| "Refatore" | Código mais limpo |
| "Adicione testes" | Testes unitários |
| "Documente" | Comentários e docstrings |
| "Simplifique" | Remove complexidade |
| "Adicione tipos" | TypeScript types |

---

### 5. Geração de Testes

```
Selecione a função → Cmd/Ctrl + K:
"Gere testes unitários com Jest cobrindo casos de sucesso e erro"
```

**Resultado:**
```javascript
describe('calcularImpostoRenda', () => {
  test('retorna 0 para salário isento', () => {
    expect(calcularImpostoRenda(1500)).toBe(0);
  });

  test('calcula corretamente faixa de 7.5%', () => {
    expect(calcularImpostoRenda(2500)).toBeCloseTo(44.70);
  });

  test('lança erro para valor negativo', () => {
    expect(() => calcularImpostoRenda(-100)).toThrow();
  });
});
```

---

### 6. Debug Assistido

**Cenário:** Código dá erro

**Fluxo:**
1. Copie a mensagem de erro
2. Abra chat lateral (Cmd/Ctrl + L)
3. Cole: "Esse erro está acontecendo: [erro]. Por quê?"
4. IA explica e sugere correção
5. Se fizer sentido, peça: "Corrija no código"

---

## Comparativo de IDEs

### Cursor vs Antigravity vs VS Code

| Feature | Cursor | Antigravity | VS Code + Copilot |
|---------|--------|-------------|-------------------|
| **Setup** | Pronto | Pronto | Precisa configurar |
| **Modelos** | Claude + GPT | Multi-modelo | GPT (GitHub) |
| **Chat inline** | ✅ Excelente | ✅ Excelente | ⚠️ Limitado |
| **Chat lateral** | ✅ | ✅ | ✅ |
| **Composer (multi-file)** | ✅ | ✅ | ❌ |
| **Preço** | Free + Pro | Free + Pro | Copilot $10/mês |
| **Base** | VS Code | Própria | VS Code |

### Quando usar cada uma

```
Está começando?
└── Cursor (mais fácil)

Precisa de múltiplos modelos?
└── Antigravity

Já tem VS Code configurado?
└── VS Code + Continue (extensão free)

Empresa paga GitHub Copilot?
└── VS Code + Copilot
```

---

## Workflows Avançados

### Workflow 1: Projeto do Zero

```
1. Criar pasta e abrir no Cursor
2. Cmd/Ctrl + K: "Crie estrutura de projeto Node.js com Express,
   TypeScript, e Prisma para API REST"
3. IA cria arquivos base
4. Iterar: "Adicione endpoint de usuários com CRUD"
5. Iterar: "Adicione autenticação JWT"
6. Iterar: "Adicione testes"
```

### Workflow 2: Entender Código Legado

```
1. Abrir projeto no Cursor
2. Cmd/Ctrl + L: "Explique a arquitetura desse projeto"
3. Navegar para função confusa
4. Selecionar → "O que isso faz em linguagem simples?"
5. Se necessário: "Refatore para ficar mais legível"
```

### Workflow 3: Migração de Código

```
1. Abrir arquivo JavaScript
2. Selecionar tudo → Cmd/Ctrl + K
3. "Converta para TypeScript com tipos estritos"
4. Revisar sugestões
5. "Adicione validação com Zod para inputs"
```

### Workflow 4: Code Review com IA

```
1. Selecionar código a revisar
2. Cmd/Ctrl + L: "Faça code review focando em:
   - Bugs potenciais
   - Performance
   - Segurança
   - Legibilidade"
3. IA lista problemas
4. Para cada: "Corrija o problema X"
```

---

## Dicas de Produtividade

### Boas Práticas

| Faça | Não Faça |
|------|----------|
| Peça uma coisa por vez | Pedir tudo junto |
| Revise antes de aceitar | Aceitar cegamente |
| Mantenha contexto aberto | Trabalhar em arquivo isolado |
| Itere até ficar bom | Aceitar primeira versão |

### Atalhos para Decorar

| Ação | Mac | Windows |
|------|-----|---------|
| Chat inline | Cmd + K | Ctrl + K |
| Chat lateral | Cmd + L | Ctrl + L |
| Aceitar sugestão | Tab | Tab |
| Rejeitar | Esc | Esc |
| Selecionar linha | Cmd + Shift + K | Ctrl + Shift + K |

---

## Checklist de Entendimento

- [ ] Sei usar autocomplete inteligente
- [ ] Domino chat inline (Cmd/Ctrl + K)
- [ ] Domino chat lateral (Cmd/Ctrl + L)
- [ ] Consigo gerar testes automaticamente
- [ ] Sei fazer debug assistido
- [ ] Conheço as diferenças entre IDEs

---

## Próximo Passo

Agora vamos construir um projeto completo usando todas essas funcionalidades.
