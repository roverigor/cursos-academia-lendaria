# 📖 Glossário do Módulo 3: Sistema de Artifacts

**Curso:** Google Antigravity Essencial
**Professor:** Lucas Charao
**Uso:** Referência rápida durante e depois das aulas

---

## 📌 Como Usar Este Glossário

- **Durante a aula:** Consulte quando o professor mencionar um termo novo
- **Depois da aula:** Use como referência ao revisar trabalhos do agente
- **Nos estudos:** Imprima ou salve para consulta rápida

**Organização:** Alfabética (A-Z)

---

## A

### Artifact (Artefato)
Entrega tangível que o agente gera pra você verificar o trabalho dele. São os "relatórios de progresso" visuais e textuais.

**Os 6 tipos:**
1. Task List
2. Implementation Plan
3. Code Diff
4. Walkthrough
5. Screenshot
6. Browser Recording

**Analogia:** Como um funcionário que não só diz "terminei" mas te mostra plano, mudanças, fotos e vídeos do trabalho.

**Ver também:** Task List, Code Diff, Screenshot

---

### Auditar
Verificar se o trabalho foi feito corretamente. No contexto do Antigravity, significa revisar os Artifacts pra garantir que o agente fez o que você pediu.

**Como fazer:** Leia o Walkthrough, olhe o Code Diff, assista o Recording.

---

## B

### Browser Recording (Gravação do Navegador)
Vídeo que o agente grava mostrando ele testando sua criação no navegador.

**O que você vê no vídeo:**
- O agente abrindo páginas
- Clicando em botões
- Preenchendo formulários
- O resultado de cada ação

**Quando aparece:** Quando você pede um teste, quando o agente quer provar que funciona.

**Pra que serve:** Ver se o fluxo funciona, identificar bugs, ter prova visual.

**Ver também:** Screenshot, Browser Integrado

---

## C

### Code Diff (Diferença de Código)
Artifact que mostra EXATAMENTE o que foi adicionado ou removido nos arquivos.

**Como interpretar:**
- 🟢 Linha verde (+) = foi ADICIONADA
- 🔴 Linha vermelha (-) = foi REMOVIDA
- ⚪ Linha branca = não mudou (contexto)

**Exemplo:**
```diff
- Título antigo
+ Título novo
+ <botão novo>
```

**Pra que serve:** Verificar mudanças específicas, auditar o trabalho, identificar alterações não solicitadas.

**Ver também:** Walkthrough, Linha Adicionada, Linha Removida

---

### Comentário
Feedback que você deixa diretamente em um Artifact. Funciona como comentários no Google Docs.

**Como fazer:**
1. Expande o Artifact
2. Seleciona um trecho
3. Escreve seu comentário
4. O agente lê e ajusta

**Bons comentários são:** Específicos, acionáveis, claros.

**Ver também:** Feedback

---

## D

### Debugging (Depuração)
Processo de encontrar e corrigir erros. Com Artifacts visuais, você pode debugar sem entender código.

**Como debugar com Artifacts:**
1. Pede um teste com Recording
2. Assiste o vídeo
3. Identifica onde deu errado
4. Dá feedback específico pro agente corrigir

**Ver também:** Screenshot, Browser Recording

---

## E

### Evidência Visual
Prova em forma de imagem ou vídeo de que algo foi criado ou funciona.

**Tipos no Antigravity:**
- Screenshot = foto do resultado
- Recording = vídeo do teste

**Por que importa:** Você não precisa confiar cegamente. Você VÊ.

---

### Expandir (Artifact)
Clicar em um Artifact pra ver mais detalhes. Artifacts aparecem "fechados" e você clica pra abrir.

**Como fazer:** Clica no Artifact na conversa. Ele expande mostrando detalhes.

---

## F

### Feedback
Retorno que você dá ao agente sobre o trabalho dele. Pode ser através de comentários em Artifacts ou mensagens na conversa.

**Feedback efetivo:**
- ✅ "Muda o botão de verde pra azul"
- ✅ "Remove o campo de telefone"
- ❌ "Não gostei" (vago)
- ❌ "Tá errado" (não ajuda)

**Regra:** Seja específico. Diga O QUE mudar e COMO.

**Ver também:** Comentário

---

## I

### Implementation Plan (Plano de Implementação)
Artifact que mostra os detalhes TÉCNICOS do que o agente planeja fazer.

**Diferença da Task List:**
- Task List = lista simples de tarefas
- Implementation Plan = como cada tarefa será executada

**Quando aparece:** No Planning Mode, junto com a Task List.

**Ver também:** Task List, Planning Mode

---

## L

### Linha Adicionada
No Code Diff, linha marcada em VERDE com símbolo +. Significa que essa linha foi CRIADA (não existia antes).

**Exemplo:** `+ <botão>Enviar</botão>`

**Ver também:** Code Diff, Linha Removida

---

### Linha Removida
No Code Diff, linha marcada em VERMELHO com símbolo -. Significa que essa linha foi APAGADA.

**Exemplo:** `- Título antigo`

**Ver também:** Code Diff, Linha Adicionada

---

## R

### Relatório de Progresso
Forma de descrever os Artifacts. São os "relatórios" que o agente entrega mostrando o que fez.

**Analogia:** Funcionário que entrega relatório mostrando planejamento, execução e resultado.

**Ver também:** Artifact

---

## S

### Screenshot (Captura de Tela)
Foto da tela que o agente tira, geralmente mostrando o resultado visual de uma criação.

**Quando aparece:**
- Quando o agente testa no browser
- Quando você pede "tira um screenshot"
- Quando ele quer mostrar como ficou

**Pra que serve:**
- Ver se o design ficou certo
- Verificar posição dos elementos
- Ter prova visual

**Ver também:** Browser Recording, Evidência Visual

---

## T

### Task List (Lista de Tarefas)
Artifact que mostra o PLANO do agente — o que ele pretende fazer, em formato de lista.

**Exemplo:**
```
1. Criar arquivo index.html
2. Adicionar formulário de contato
3. Estilizar com CSS
4. Testar no browser
```

**Quando aparece:** No Planning Mode, ANTES de executar.

**O que você pode fazer:** Ler, comentar, pedir mudanças antes de aprovar.

**Ver também:** Planning Mode, Implementation Plan

---

### Transparência
Princípio de que você pode VER o que o agente está fazendo. Os Artifacts são a ferramenta de transparência.

**Oposto de:** Caixa preta (não saber o que acontece por dentro).

---

## V

### Verificar
Conferir se o trabalho do agente está correto usando os Artifacts.

**Ordem recomendada:**
1. Walkthrough (visão geral)
2. Code Diff (detalhes)
3. Screenshot/Recording (prova visual)

---

## W

### Walkthrough (Passo a Passo)
Artifact que resume em PORTUGUÊS SIMPLES o que o agente fez.

**Exemplo:**
```
Nesta sessão, eu:
1. Criei a página de contato
2. Adicionei formulário com 3 campos
3. Estilizei com cores azul e branco
4. Testei e funcionou
```

**Pra que serve:** Entender rapidamente o que foi feito, sem precisar ler código.

**Quando usar:** SEMPRE leia primeiro, antes do Code Diff.

**Ver também:** Code Diff

---

## 📊 Tabela de Artifacts (Resumo)

### Quando Cada Artifact Aparece

| Artifact | Quando | Pra que |
|----------|--------|---------|
| **Task List** | Antes de executar | Ver o plano |
| **Implementation Plan** | Antes de executar | Ver detalhes técnicos |
| **Code Diff** | Depois de executar | Ver o que mudou |
| **Walkthrough** | Depois de executar | Resumo em português |
| **Screenshot** | Depois de testar | Ver resultado visual |
| **Recording** | Depois de testar | Ver funcionamento |

### Como Interpretar Code Diff

| Símbolo | Cor | Significado |
|---------|-----|-------------|
| + | Verde | Linha adicionada |
| - | Vermelho | Linha removida |
| (nenhum) | Branco | Não mudou |

---

## 💡 Dicas de Uso

1. **Walkthrough primeiro:** Sempre leia o Walkthrough antes do Code Diff. Dá visão geral.

2. **Feedback específico:** Em vez de "tá errado", diga exatamente o que mudar.

3. **Use visuais pra debugging:** Se algo não funciona, peça Recording e assista pra identificar o problema.

4. **Expanda sempre:** Clique nos Artifacts pra ver detalhes. Muita informação útil fica escondida.

5. **Comente nos Artifacts:** É mais efetivo que explicar tudo na conversa.

---

## 📚 Glossários Relacionados

- **Módulo 1:** Termos básicos (Agent Manager, Editor View)
- **Módulo 2:** Termos de controle (Planning Mode, Políticas)
- **Módulo 4:** Termos sobre Atalhos

---

**Última atualização:** 2025-12-16
**Criado por:** Course Architect Agent

---

**Imprima ou salve este glossário para referência rápida! 📖**
