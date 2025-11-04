# Biblioteca de Prompts - Vibecoding

Prompts testados e otimizados para criação de apps no-code com Claude, Bolt.new e outras IAs.

---

## 📋 Como Usar Esta Biblioteca

1. **Copie o prompt completo** (não modifique muito, eles foram testados)
2. **Substitua** as partes entre `[colchetes]` pelas suas informações
3. **Cole** no Claude/Bolt
4. **Itere** se necessário (mas dê uma chance pro prompt original primeiro!)

---

## 🎨 CATEGORIA: Landing Pages

### **Prompt 1: Landing Page Completa (Bolt.new)**

```
Quero construir uma landing page para vender [TIPO DE PRODUTO/SERVIÇO].

Estrutura:
- Header com logo "[NOME DA MARCA]" e menu: Início / Sobre / Contato
- Hero section com:
  - Título impactante sobre [BENEFÍCIO PRINCIPAL]
  - Subtítulo explicando [O QUE É]
  - Botão CTA: "[TEXTO DO BOTÃO]"
- Seção "Benefícios" com 3 cards:
  1. [BENEFÍCIO 1]
  2. [BENEFÍCIO 2]
  3. [BENEFÍCIO 3]
- Seção "Como Funciona" com 3 passos
- Seção "Depoimentos" com 2-3 depoimentos (pode ser placeholder por enquanto)
- Seção "FAQ" com 5 perguntas frequentes
- Footer com redes sociais e copyright

Design:
- Cores primária: [COR HEX] e secundária: [COR HEX]
- Estilo: [moderno/minimalista/bold/elegante]
- Responsivo (mobile + desktop)
- Animações suaves ao rolar

Funcionalidades:
- Botão CTA leva para formulário de contato
- Formulário captura: Nome, E-mail, Mensagem
- Validação de campos obrigatórios
```

**Quando usar:** Criar landing page completa do zero no Bolt.new

---

### **Prompt 2: Landing Page de Alta Conversão (Otimizada)**

```
Crie uma landing page otimizada para conversão para vender [PRODUTO/SERVIÇO] por [R$ VALOR].

ICP (Ideal Customer Profile):
- [Quem é]: [ex: Empreendedores digitais 30-45 anos]
- [Dor principal]: [ex: Não tem tempo para criar conteúdo]
- [Desejo]: [ex: Automatizar criação de posts]

Estrutura PAS (Problem-Agitate-Solution):
- Hero: Destaque a dor principal
- Agitação: Mostre consequências de não resolver
- Solução: Apresente o produto como salvação

Sections obrigatórias:
- Hero com CTA acima da dobra
- Prova social (números, logos, depoimentos)
- Comparação "Antes vs. Depois"
- Garantia (30 dias de devolução)
- Escassez (vagas limitadas / oferta expira)
- FAQ antecipando objeções
- CTA final irresistível

Design:
- Cores que geram urgência: [Laranja/Vermelho] + [Preto/Branco]
- CTAs destacados com contraste alto
- Tipografia hierárquica (títulos chamam atenção)
```

**Quando usar:** Criar landing page focada em venda/conversão

---

## 🤖 CATEGORIA: Integração com IA

### **Prompt 3: Adicionar ChatGPT num App (Bolt.new)**

```
Quero adicionar um chatbot com ChatGPT-4 na minha aplicação.

Funcionalidades:
- Botão flutuante no canto inferior direito (ícone de chat)
- Ao clicar, abre janela de chat
- Usuário digita mensagem → envia pro ChatGPT → resposta aparece
- Histórico da conversa visível

Configuração:
- Use OpenAI API (GPT-4)
- Persona do assistente: [DESCREVA COMO A IA DEVE SE COMPORTAR]
- Exemplo: "Você é um assistente especializado em [ÁREA]. Responda de forma [TOM: amigável/profissional/técnica]."

UI/UX:
- Botão: cor [COR HEX], ícone de chat
- Janela: altura 500px, largura 350px
- Mensagens do usuário: balão azul (direita)
- Mensagens da IA: balão cinza (esquerda)

Me guie para adicionar a API key da OpenAI no arquivo .env
```

**Quando usar:** Adicionar chatbot GPT em qualquer app do Bolt

---

### **Prompt 4: Processar Formulário com Claude (Artifacts)**

```
Crie um formulário que processa input do usuário com a API do Claude.

Campos do formulário:
- [CAMPO 1]: [tipo]
- [CAMPO 2]: [tipo]
- [CAMPO 3]: [tipo]

Ao clicar em "Processar":
1. Captura os dados do formulário
2. Envia para API do Claude (Anthropic)
3. Prompt para a IA: "[SEU PROMPT AQUI]"
4. Exibe resultado formatado na tela

Exemplo de processamento:
- Entrada: Texto descritivo do usuário
- Saída: Análise categorizada em [CATEGORIAS]

Use minha API key: [SUA-API-KEY-ANTHROPIC]

Design:
- Formulário limpo e intuitivo
- Loading spinner enquanto processa
- Resultado em card destacado
```

**Quando usar:** Criar apps que processam dados com Claude (tipo Mapa da Clareza)

---

## 💾 CATEGORIA: Banco de Dados (Supabase)

### **Prompt 5: Adicionar Supabase ao App (Bolt.new)**

```
Quero adicionar Supabase como banco de dados no meu app para salvar [O QUE VOCÊ QUER SALVAR].

Funcionalidades:
- Criar tabela "[NOME_TABELA]" com colunas:
  - id (UUID, primary key)
  - [coluna1]: [tipo - text/integer/boolean/timestamp]
  - [coluna2]: [tipo]
  - created_at (timestamp)

Operações CRUD:
- CREATE: Formulário adiciona novo registro
- READ: Lista todos os registros em tabela
- UPDATE (opcional): Editar registro existente
- DELETE: Botão para remover registro

Me guie para:
1. Criar projeto no Supabase
2. Gerar SQL para criar a tabela
3. Adicionar URL e API key no .env do Bolt
4. Testar conexão
```

**Quando usar:** Adicionar persistência de dados em apps Bolt

---

### **Prompt 6: Supabase + Autenticação (Bolt.new)**

```
Adicione sistema de autenticação com Supabase Auth ao meu app.

Funcionalidades:
- Tela de cadastro (email + senha)
- Tela de login (email + senha)
- Logout
- Proteção de rotas: apenas usuários logados acessam [PÁGINA/ÁREA]
- Exibir nome do usuário logado no header

Fluxo:
1. Usuário acessa app → redireciona para /login
2. Se não tem conta → vai para /signup
3. Após login bem-sucedido → redireciona para /dashboard
4. Dashboard mostra conteúdo protegido

Validações:
- Email válido
- Senha mínima 6 caracteres
- Mensagens de erro amigáveis

Me guie para configurar Supabase Auth.
```

**Quando usar:** Adicionar login/autenticação em apps Bolt

---

## 💳 CATEGORIA: Pagamentos (Stripe)

### **Prompt 7: Integrar Stripe (Modo Teste)**

```
Quero integrar pagamento com Stripe no meu app.

Produto/Serviço:
- Nome: [NOME DO PRODUTO]
- Preço: R$ [VALOR]
- Tipo: [único/recorrente mensal]

Fluxo:
1. Usuário clica em "Comprar"
2. Redireciona para Checkout do Stripe
3. Após pagamento bem-sucedido → redireciona para /sucesso
4. Se cancelar → redireciona para /cancelado
5. Salva compra no Supabase (tabela "purchases")

Modo: TESTE (não cobrar de verdade ainda)

Me guie para:
1. Criar conta Stripe
2. Configurar produto no Stripe Dashboard
3. Adicionar chaves API (modo teste) no .env
4. Testar compra com cartão de teste
```

**Quando usar:** Adicionar sistema de pagamento em MicroSaaS

---

## 🎨 CATEGORIA: Design & Estilização

### **Prompt 8: Melhorar Design (Bolt.new)**

```
Meu app já funciona, mas o design está amador. Melhore a estética.

Problemas atuais:
- Cores sem harmonia
- Espaçamento irregular
- Tipografia inconsistente
- Sem hierarquia visual

Aplique:
- Paleta de cores profissional: [Primária: COR] [Secundária: COR] [Acento: COR]
- Tipografia: Headlines grandes e impactantes, corpo legível
- Espaçamento consistente (padding/margin múltiplos de 8px)
- Sombras suaves para profundidade
- Hover effects nos botões
- Transições suaves (0.3s ease)

Mantenha toda a funcionalidade atual, apenas melhore o visual.
```

**Quando usar:** App funciona, mas precisa de visual mais profissional

---

### **Prompt 9: Adicionar Animações (Bolt.new)**

```
Adicione animações sutis e profissionais ao meu app.

Animações:
- Hero section: Fade in + slide up ao carregar
- Cards: Aparecem com delay sequencial (stagger effect)
- Botões: Hover com scale ligeiro (1.05x)
- Scroll: Elementos aparecem quando entram no viewport
- Transições de página: Fade smooth

Biblioteca recomendada: Framer Motion

Mantenha performance (60fps).
```

**Quando usar:** Adicionar polish e profissionalismo ao app

---

## 🔧 CATEGORIA: Troubleshooting & Fixes

### **Prompt 10: Consertar Erro no Código**

```
Estou tendo um erro no meu app:

Erro: [COPIE A MENSAGEM DE ERRO AQUI]

Contexto:
- O que eu estava tentando fazer: [DESCREVA]
- Quando o erro acontece: [DESCREVA]
- O que eu já tentei: [DESCREVA]

Por favor, identifique o problema e conserte.
```

**Quando usar:** Quando algo quebrou e você não sabe por quê

---

### **Prompt 11: Otimizar Performance**

```
Meu app está lento/pesado. Otimize para melhor performance.

Problemas:
- Carregamento inicial demora [X segundos]
- Navegação entre páginas travando
- [OUTRO PROBLEMA]

Otimize:
- Lazy loading de imagens
- Code splitting
- Reduzir bundle size
- Cachear requisições
- Remover bibliotecas não usadas

Me mostre o before/after de performance.
```

**Quando usar:** App funcional mas lento

---

## 🚀 CATEGORIA: Deploy & Publicação

### **Prompt 12: Preparar para Produção (Bolt.new)**

```
Meu app está pronto. Prepare-o para produção.

Checklist:
- Remover console.logs e código de debug
- Adicionar analytics (Google Analytics ou Plausible)
- Configurar SEO (meta tags, Open Graph)
- Adicionar favicon personalizado
- Configurar variáveis de ambiente para produção
- Otimizar imagens
- Adicionar sitemap.xml

Após preparar, me guie para fazer deploy.
```

**Quando usar:** App pronto para lançar ao público

---

## 📊 DICA DE OURO: Como Iterar com Prompts

**Se o resultado não ficou bom:**

1. **Não refaça tudo do zero!** Diga especificamente o que errou:
   - ❌ "Não gostei, faz de novo"
   - ✅ "A cor do botão (#FF0000) está muito agressiva. Mude para um azul suave (#3B82F6)"

2. **Seja específico nas mudanças:**
   - ❌ "Melhora o design"
   - ✅ "Aumenta o tamanho do título para 48px e adiciona sombra sutil"

3. **Valide funcionalidade antes de design:**
   - Primeiro: faça funcionar
   - Depois: faça ficar bonito

4. **Use linguagem natural, mas clara:**
   - "Olha, quando eu clico no botão ele não faz nada. Adiciona a lógica de clique."

---

## 📚 Recursos Adicionais

**Para criar prompts melhores:**
- [Anthropic Prompt Library](https://docs.anthropic.com/prompts)
- [OpenAI Prompt Engineering Guide](https://platform.openai.com/docs/guides/prompt-engineering)

**Para inspiração de design:**
- [Dribbble](https://dribbble.com) - Interfaces lindas
- [Awwwards](https://awwwards.com) - Sites premiados
- [Land-book](https://land-book.com) - Landing pages de referência

---

*Biblioteca de Prompts v1.0 | Vibecoding | José Carlos Amorim*
