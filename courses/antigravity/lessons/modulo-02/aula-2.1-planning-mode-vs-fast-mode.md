# AULA 2.1: Planning Mode vs Fast Mode

**Módulo:** 2 - Controlando o Agente
**Duração:** 8 minutos
**Tipo:** Conceitual
**Professor:** Lucas Charao

---

## GPS DA AULA

### DESTINO (Goal)
Ao final desta aula, você vai:
- Entender a diferença entre Planning Mode e Fast Mode
- Saber quando usar cada um
- Conseguir alternar entre os modos conforme a situação

### ORIGEM (Position)
Você provavelmente:
- Já usou o agente pra criar coisas simples
- Não sabia que existem modos diferentes de trabalho
- Às vezes quer mais controle, às vezes quer mais velocidade
- Quer evitar que o agente faça coisas erradas em projetos importantes

### ROTA (Steps)
1. Entender a metáfora: arquiteto vs pedreiro
2. Conhecer as diferenças entre os dois modos
3. Aprender a regra prática de quando usar cada um
4. Ver como alternar entre modos

---

## ROTEIRO COMPLETO

### [ABERTURA] - 30 segundos

**[LUCAS DIZ:]**

> Bem-vindo ao Módulo 2! Lucas Charao aqui.
>
> No módulo anterior, você aprendeu a navegar pelo Antigravity. Agora vamos aprender a CONTROLAR o agente. Fazer ele trabalhar do jeito que você precisa.
>
> E a primeira coisa que você precisa saber: existem dois modos de trabalho. Vem entender.

---

### [GANCHO EMOCIONAL] - 1 minuto

**[LUCAS DIZ:]**

> Te pergunto uma coisa: quando você vai fazer algo importante — tipo uma apresentação pro chefe, ou um orçamento pra um cliente grande — você prefere ir direto fazendo ou prefere planejar antes?
>
> (pausa)
>
> Agora, quando é algo simples — tipo responder um email rápido ou corrigir um errinho — você para pra planejar ou só faz?
>
> Pois é. Depende da situação.
>
> O Antigravity entende isso. Por isso ele tem dois modos:
> - Um pra quando você quer CONTROLE (Planning Mode)
> - Outro pra quando você quer VELOCIDADE (Fast Mode)
>
> Saber quando usar cada um vai mudar completamente sua experiência.

---

### [METÁFORA VISUAL] - 1.5 minutos

**[LUCAS DIZ:]**

> Pensa assim:
>
> **Planning Mode** = Arquiteto antes de construir
>
> Você quer construir uma casa. Antes de levantar qualquer parede, o arquiteto senta, desenha a planta, pensa na estrutura, te mostra o projeto pra você aprovar. Só DEPOIS começa a obra.
>
> **Fast Mode** = Pedreiro que já sabe o que fazer
>
> Você quer trocar uma tomada. Não precisa de arquiteto. O pedreiro chega, troca a tomada, pronto. Rápido e direto.

**[MOSTRAR TABELA NO SLIDE:]**

```
┌─────────────────────────────────────────────────────────┐
│              PLANNING MODE    │    FAST MODE            │
├─────────────────────────────────────────────────────────┤
│  Mostra o plano ANTES        │  Executa DIRETO          │
│  de executar                 │                          │
├─────────────────────────────────────────────────────────┤
│  Você revisa e aprova        │  Você vê o resultado     │
│  cada etapa                  │  final                   │
├─────────────────────────────────────────────────────────┤
│  Mais lento                  │  Mais rápido             │
├─────────────────────────────────────────────────────────┤
│  Mais controle               │  Menos controle          │
├─────────────────────────────────────────────────────────┤
│  IDEAL PARA:                 │  IDEAL PARA:             │
│  - Criar algo novo           │  - Ajustes pequenos      │
│  - Projetos importantes      │  - Correções rápidas     │
│  - Quando você não tem       │  - Quando você sabe      │
│    certeza do resultado      │    exatamente o que quer │
└─────────────────────────────────────────────────────────┘
```

---

### [FUNDAMENTO CONCEITUAL] - 1.5 minutos

**[LUCAS DIZ:]**

> O que acontece em cada modo:
>
> **No Planning Mode:**
> 1. Você pede algo
> 2. O agente cria um PLANO (Task List)
> 3. Você vê o plano e pode comentar
> 4. Você aprova
> 5. Aí sim ele executa
>
> **No Fast Mode:**
> 1. Você pede algo
> 2. O agente executa direto
> 3. Você vê o resultado
>
> Qual é melhor? Nenhum. Depende da situação.
>
> Se o agente fizer algo errado no Fast Mode, você só descobre DEPOIS. No Planning Mode, você vê o plano ANTES e pode corrigir.
>
> Mas se você precisa de velocidade pra ajustes pequenos, Planning Mode é lento demais.

---

### [REGRA PRÁTICA] - 1 minuto

**[LUCAS DIZ:]**

> Regra simples pra você decorar:
>
> **"Se der errado, quanto tempo eu perco?"**
>
> - Se a resposta for "muito tempo" → **Planning Mode**
> - Se a resposta for "pouco, é fácil corrigir" → **Fast Mode**
> - Se você tiver em dúvida → **Planning Mode**
>
> Exemplos práticos:
>
> "Cria um sistema de agendamento completo" → **Planning Mode**
> (se der errado, vai dar trabalho corrigir)
>
> "Muda a cor do botão pra azul" → **Fast Mode**
> (se der errado, é só mudar de novo)
>
> "Adiciona um formulário de contato" → **Planning Mode**
> (envolve várias partes, melhor ver o plano antes)
>
> "Corrige o texto que tá errado" → **Fast Mode**
> (correção simples, vai direto)

---

### [COMO ALTERNAR] - 1 minuto

**[LUCAS DIZ:]**

> Pra alternar entre os modos, você tem duas opções:
>
> **Opção 1:** No Agent Panel ou Agent Manager, procure um toggle/botão que diz "Planning Mode" ou "Fast Mode". Clica pra alternar.
>
> **Opção 2:** Escreva direto no seu pedido:
> - "Use planning mode e crie um formulário de contato"
> - "No fast mode, muda a cor do título"
>
> O agente entende e usa o modo que você pediu.
>
> Dica: se você não especificar, o Antigravity vai tentar decidir sozinho baseado na complexidade. Mas é melhor VOCÊ decidir.

---

### [APLICAÇÃO PRÁTICA - AÇÃO RÁPIDA] - 1.5 minutos

**[LUCAS DIZ:]**

> Vamos testar os dois modos. Exercício rápido.
>
> **Teste 1 - Planning Mode:**
>
> Vai no Agent Manager e digita:
> "Use planning mode e crie uma página com formulário de nome e email"
>
> Observa: ele vai te mostrar um PLANO antes de executar. Uma lista do que ele pretende fazer. Você pode comentar, ajustar, e só depois aprovar.
>
> **Teste 2 - Fast Mode:**
>
> Agora digita:
> "No fast mode, adiciona um título dizendo Contato no topo da página"
>
> Observa: ele vai direto executar, sem mostrar plano.
>
> Percebeu a diferença?
>
> No Planning Mode você tem mais controle. No Fast Mode, mais velocidade.

---

### [EXPANSÃO FILOSÓFICA] - 30 segundos

**[LUCAS DIZ:]**

> O ponto aqui é: você é o DIRETOR.
>
> E como diretor, você decide quando quer ver os bastidores (Planning Mode) e quando confia no time pra executar direto (Fast Mode).
>
> Projetos importantes? Revisa o plano. Ajustes pequenos? Vai direto.
>
> Esse controle é o que separa quem USA a ferramenta de quem DOMINA ela.
>
> Na próxima aula, vamos falar sobre Políticas de Execução — como controlar o que o agente pode ou não pode fazer automaticamente.
>
> Te vejo lá!

---

## 📖 GLOSSÁRIO

Consulte o **[Glossário do Módulo 2](glossario-modulo-02.md)** para definições completas dos termos:
- Planning Mode
- Fast Mode
- Task List
- Toggle

---

## CHECKLIST DE ENTENDIMENTO

- [ ] Entendi que Planning Mode mostra o plano ANTES de executar
- [ ] Entendi que Fast Mode executa DIRETO
- [ ] Sei a regra: "se der errado, quanto tempo perco?"
- [ ] Consegui testar os dois modos na prática
- [ ] Sei como alternar entre eles (toggle ou escrevendo no pedido)

---

## TROUBLESHOOTING (Se der problema)

**Problema:** Não encontro o toggle de modo
**Solução:** Procure no Agent Panel ou nas configurações. A posição pode variar. Alternativa: escreva o modo direto no pedido.

**Problema:** O agente ignorou o modo que eu pedi
**Solução:** Seja mais explícito: "IMPORTANTE: use planning mode para esta tarefa"

---

## RECURSOS

- Planning Mode: melhor pra tarefas complexas e projetos novos
- Fast Mode: melhor pra ajustes rápidos e correções simples

---

*Aula 2.1 - Planning Mode vs Fast Mode*
*Duração: 8 minutos*
*Professor: Lucas Charao*
