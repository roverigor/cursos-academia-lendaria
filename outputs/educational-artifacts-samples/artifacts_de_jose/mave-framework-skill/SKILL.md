---
name: mave-framework
description: Framework completo de democratização de conhecimento através de visualização educacional. Use quando precisar transformar conceitos técnicos complexos em experiências de aprendizagem interativas, acessíveis e memoráveis. Ideal para criar conteúdo educacional, explicar sistemas abstratos ou desenvolver materiais didáticos visuais.
---

# 🎨 MAVE Framework - Método Amorim de Visualização Educacional

## Visão Geral

O MAVE Framework é uma metodologia completa para transformar conhecimento complexo em experiências de aprendizagem simples, visuais e interativas. Desenvolvido por José Carlos Amorim, este framework democratiza conceitos técnicos através de 4 pilares fundamentais.

**Quando usar esta Skill:**
- Explicar conceitos técnicos abstratos (APIs, IA, blockchain, arquiteturas)
- Criar materiais educacionais para públicos não-técnicos
- Desenvolver documentação interativa e didática
- Transformar whitepapers em experiências visuais
- Criar demos e POCs educacionais

## 🎯 Os 4 Pilares do MAVE

### **M - Metáfora Universal**
Conecte o desconhecido ao conhecido através de experiências cotidianas.

**Princípio:** Todo conceito abstrato tem um equivalente no mundo real.

**Exemplos comprovados:**
- Skills System → Chef de Restaurante
- APIs → Garçom entre cozinha e cliente
- Blockchain → Livro-razão de padaria
- Progressive Disclosure → Cardápio → Livro → Gaveta
- Context Window → Memória ativa do Chef
- RAG → Chef consultando livros antigos
- Databases → Arquivo de receitas organizadas

**Como criar metáforas eficazes:**
1. Identifique a **estrutura** do conceito técnico
2. Busque atividades **universais** (cozinha, esportes, mercado)
3. Mapeie componente por componente
4. Teste: "minha avó entenderia?"

📚 *Veja mais em: [metaforas.md](metaforas.md)*

---

### **A - Animação Temporal**
Revele complexidade progressivamente através do tempo.

**Princípio:** O cérebro processa melhor informação sequencial do que simultânea.

**Técnicas:**
- **Step-by-step**: Botões numerados (1→2→3→4→5)
- **Play automático**: Animação contínua com pausas
- **Highlight dinâmico**: Destaque visual do elemento ativo
- **Transições suaves**: 300-500ms (não muito rápido, não muito lento)

**Padrão de revelação:**
```
Etapa 1: Contexto geral (O que é?)
    ↓ 2s
Etapa 2: Componentes principais (Quais partes?)
    ↓ 2s
Etapa 3: Interações (Como se conectam?)
    ↓ 2s
Etapa 4: Detalhes específicos (Como funciona?)
    ↓ 2s
Etapa 5: Resultado final (O que acontece?)
```

📚 *Veja mais em: [animacoes.md](animacoes.md)*

---

### **V - Visualização Espacial**
Organize informação no espaço 2D com significado semântico.

**Princípio:** Posição = Significado. Layout é linguagem.

**Padrões espaciais:**

**Esquerda → Direita = Fluxo temporal/processual**
```
[Input] → [Processamento] → [Output]
[User] → [Sistema] → [Resposta]
```

**Cima → Baixo = Hierarquia/Abstração**
```
[Conceito Alto Nível]
        ↓
[Implementação]
        ↓
[Detalhes Técnicos]
```

**Centro = Protagonista**
```
    [Componentes]
         ↓
   [ELEMENTO PRINCIPAL]
         ↓
    [Resultados]
```

**Grid 2x2 = Comparação/Categorização**
```
[Antes] | [Depois]
--------|--------
[Problema] | [Solução]
```

📚 *Veja mais em: [layouts.md](layouts.md)*

---

### **E - Experimentação Ativa**
Transforme espectadores em participantes através de interatividade.

**Princípio:** Learn by Doing > Learn by Reading.

**Tipos de interação:**

1. **Toggles ON/OFF** → Controle de estado
2. **Inputs de texto** → Experimentação livre
3. **Botões de ação** → Gatilhos de eventos
4. **Sliders** → Ajuste de parâmetros
5. **Drag & Drop** → Montagem/organização

**Feedback Loop:**
```
Ação do Usuário
    ↓
Mudança Visual Imediata
    ↓
Explicação Contextual
    ↓
Novo Aprendizado
    ↓
Próxima Ação
```

📚 *Veja mais em: [interatividade.md](interatividade.md)*

---

## 🎨 Design System Minimal Brand

O MAVE Framework usa um design system minimalista e sofisticado.

### **Paleta de Cores**

**Cores Base:**
```css
--dark: #141413        /* Texto e estrutura */
--light: #faf9f5       /* Background principal (90%) */
--mid-gray: #b0aea5    /* Texto secundário */
--light-gray: #e8e6dc  /* Separadores */
```

**Cores de Acento (uso pontual):**
```css
--orange: #d97757      /* Alertas, destaques */
--blue: #6a9bcc        /* Informação */
--green: #788c5d       /* Sucesso */
```

**Cores Pastéis (backgrounds de seções):**
```css
--beige: #e8e4da       /* Hero sections */
--mint: #a8cec5        /* Seções técnicas */
--lavender: #b8b8d6    /* Seções educacionais */
```

### **Tipografia**

**Títulos e conteúdo emotivo:**
```css
font-family: 'Lora', Georgia, serif;
font-weight: 400-600;
letter-spacing: -1px (títulos grandes);
```

**UI e elementos funcionais:**
```css
font-family: 'Poppins', Arial, sans-serif;
font-weight: 500-600;
```

### **Componentes Visuais**

**Cards:**
- Border-left: 3px colorido (semântico)
- Padding: 2rem
- Border-radius: 8-12px
- Box-shadow: none (sempre flat)

**Botões:**
- Primary: background dark, texto light
- Secondary: border dark, background transparent
- Hover: opacity 0.85 (nunca transform)

**Animações:**
- Duração: 300-500ms
- Easing: ease ou cubic-bezier(0.68, -0.55, 0.265, 1.55)
- Propriedades: opacity, transform (translateY/X)

📚 *Veja detalhes completos em: [design-system.md](design-system.md)*

---

## 🔧 Princípios de Implementação

### **1. Progressive Disclosure (Meta!)**
Use progressive disclosure para ensinar progressive disclosure!

```
Camada 1: Título + Emoji (contexto emocional)
Camada 2: Metáfora visual (framework mental)
Camada 3: Código real (implementação)
Camada 4: Interação (experimentação)
Camada 5: Visualização interna (metacognição)
```

### **2. Ponte Metáfora ↔ Realidade**
Sempre faça a transição suave:

```
🍽️ Conceito do Mundo Real
    ↓
🔄 Mapeamento explícito
    ↓
💻 Implementação técnica
    ↓
📄 Código real
    ↓
🎯 Aplicação prática
```

### **3. Redundância Pedagógica**
Explique o mesmo conceito de 3 formas:
1. **Textual** - Descrição escrita
2. **Visual** - Diagrama/animação
3. **Interativa** - Experimentação hands-on

### **4. Orquestração do "Momento Aha!"**
Não EXPLIQUE. Faça a pessoa DESCOBRIR.

```javascript
// ❌ Ruim
alert("Skills são ativadas baseado no contexto!");

// ✅ Bom
// Usuário digita → Sistema decide → Visualização mostra
// "AHHH! Então é assim que funciona!"
```

---

## 📋 Checklist de Qualidade MAVE

Use este checklist para validar se sua experiência educacional está seguindo o framework:

### **Metáfora (M)**
- [ ] Usa conceito do cotidiano universal?
- [ ] Mapeamento 1:1 entre componentes?
- [ ] "Minha avó entenderia"?
- [ ] Mantém coerência até o fim?

### **Animação (A)**
- [ ] Revela informação progressivamente?
- [ ] Tem controles step-by-step?
- [ ] Transições suaves (300-500ms)?
- [ ] Highlight visual no elemento ativo?

### **Visualização (V)**
- [ ] Layout tem significado semântico?
- [ ] Usa posição espacial (esquerda/direita)?
- [ ] Cores têm significado consistente?
- [ ] Design clean e minimalista?

### **Experimentação (E)**
- [ ] Tem elementos interativos?
- [ ] Feedback imediato visível?
- [ ] Permite exploração livre?
- [ ] Consequências claras das ações?

### **Design System**
- [ ] Usa paleta minimal-brand?
- [ ] Tipografia Lora + Poppins?
- [ ] Border-radius entre 6-12px?
- [ ] Sem gradientes ou sombras pesadas?

### **Pedagogia**
- [ ] Ensina por descoberta, não explicação?
- [ ] Tem redundância pedagógica (3 formas)?
- [ ] Faz transição metáfora → código?
- [ ] Provoca "momento Aha!"?

---

## 🚀 Scripts Auxiliares

Esta skill inclui scripts para acelerar a criação de experiências MAVE:

### **Gerador de Metáforas**
```bash
python gerar_metafora.py "conceito técnico"
```
Sugere 5 metáforas do cotidiano baseadas na estrutura do conceito.

### **Validador de Paleta**
```bash
node validar_cores.js arquivo.html
```
Verifica se as cores usadas seguem o design system minimal-brand.

### **Analisador de Complexidade**
```bash
bash analisar_complexidade.sh conceito.md
```
Calcula score de complexidade e sugere quantas camadas de progressive disclosure usar.

📚 *Veja documentação completa em: [scripts.md](scripts.md)*

---

## 📚 Casos de Uso Reais

### **Exemplo 1: Explicar Skills System**
- **Metáfora:** Chef de restaurante
- **Animação:** 5 etapas (Setup → Pedido → Ativação → Detalhes → Resposta)
- **Visualização:** Grid 2 colunas (Cozinha | Cliente)
- **Experimentação:** Chat + Toggles ON/OFF
- **Resultado:** 100% de compreensão em teste com usuários não-técnicos

### **Exemplo 2: Ensinar Progressive Disclosure**
- **Metáfora:** Cardápio → Livro de Receitas → Gavetas → Equipamentos
- **Animação:** Revelação temporal dos níveis
- **Visualização:** Layers verticais (camadas do contexto)
- **Experimentação:** Digitar mensagem e ver contexto sendo montado
- **Resultado:** Conceito abstrato se tornou tangível

### **Exemplo 3: Documentar API**
- **Metáfora:** Garçom entre cozinha e mesa
- **Animação:** Request → Processing → Response
- **Visualização:** Fluxo esquerda → direita
- **Experimentação:** Enviar requests reais e ver resposta
- **Resultado:** Onboarding de desenvolvedores 3x mais rápido

📚 *Veja mais casos em: [casos-de-uso.md](casos-de-uso.md)*

---

## 🎯 Anti-Padrões (O que NÃO fazer)

❌ **Evite:**

1. **Metáforas forçadas** - Se não encaixa naturalmente, não force
2. **Animações muito rápidas** - <200ms = imperceptível
3. **Animações muito lentas** - >800ms = frustrante
4. **Sobrecarga de cores** - Mais de 3 cores de acento
5. **Texto sem hierarquia** - Tudo parece igualmente importante
6. **Interatividade falsa** - Botões que não fazem nada
7. **Explicar demais** - Deixe a descoberta acontecer
8. **Pular a ponte** - Metáfora sem transição para código real

---

## 📖 Filosofia do Framework

### **"Democratizar ≠ Simplificar Reduzindo"**

O MAVE não remove complexidade. Ele **reorganiza** a complexidade em camadas digeríveis.

Como um Chef apresentando um prato: os ingredientes são os mesmos, mas a **apresentação** torna o prato acessível.

### **Princípios-Chave:**

1. **"Se não vejo, não entendo"** → Visual Thinking
2. **"Se não mexo, não aprendo"** → Interatividade
3. **"Se não sinto, não lembro"** → Conexão emocional
4. **"Se é complexo demais, não é pra mim"** → Progressive Disclosure

### **Objetivo Final:**

Transformar **espectadores passivos** em **aprendizes ativos** que descobrem o conhecimento através de experiências memoráveis.

---

## 🔗 Arquivos Relacionados

- [metaforas.md](metaforas.md) - Biblioteca de metáforas testadas
- [animacoes.md](animacoes.md) - Padrões de animação temporal
- [layouts.md](layouts.md) - Guia de visualização espacial
- [interatividade.md](interatividade.md) - Tipos de interação
- [design-system.md](design-system.md) - Design system completo
- [scripts.md](scripts.md) - Documentação dos scripts
- [casos-de-uso.md](casos-de-uso.md) - Exemplos reais de aplicação

---

## 📝 Conclusão

O MAVE Framework é uma metodologia completa e testada para democratizar conhecimento técnico. Use-o sempre que precisar tornar o complexo simples, o abstrato tangível, e o técnico acessível.

**Lembre-se:** Você não está apenas criando conteúdo educacional. Você está criando **experiências de aprendizagem**.

---

*Desenvolvido por José Carlos Amorim - O Tradutor Apaixonado*  
*Versão 1.0.0 - Outubro 2025*
