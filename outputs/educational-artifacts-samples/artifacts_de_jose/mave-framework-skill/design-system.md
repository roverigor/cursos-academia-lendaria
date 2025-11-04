# 🎨 Design System Minimal Brand - MAVE Framework

## Filosofia do Design

**"Sofisticação vem da simplicidade, não da ornamentação"**

Este design system captura minimalismo sofisticado através de:
- Tipografia serifada elegante
- Cores pastéis sutis
- Estrutura geométrica limpa
- Espaçamento generoso

---

## 🌈 Paleta de Cores Completa

### **Cores Base (Uso Estrutural)**

```css
:root {
  /* Texto e estrutura principal */
  --dark: #141413;
  
  /* Background principal - usar em 90%+ da interface */
  --light: #faf9f5;
  
  /* Texto secundário e elementos desabilitados */
  --mid-gray: #b0aea5;
  
  /* Backgrounds sutis e separadores */
  --light-gray: #e8e6dc;
}
```

**Quando usar:**
- `--dark`: Textos principais, bordas, botões primários
- `--light`: Background de body, cards neutros
- `--mid-gray`: Labels, captions, disabled states
- `--light-gray`: Separadores, backgrounds de inputs

---

### **Cores de Acento (Uso Pontual)**

```css
:root {
  /* Acento primário - alertas, destaques */
  --orange: #d97757;
  
  /* Acento secundário - informação */
  --blue: #6a9bcc;
  
  /* Acento terciário - sucesso */
  --green: #788c5d;
}
```

**Aplicações específicas:**
- Border-left de cards (3px)
- Badges/tags pequenos (background)
- Ícones pontuais
- Estados de hover (subtle)
- Highlight de elementos ativos

**❌ NÃO use para:**
- Backgrounds grandes
- Texto corrido
- Gradientes
- Múltiplas cores no mesmo elemento

---

### **Cores Pastéis (Backgrounds de Seções Específicas)**

```css
:root {
  /* Hero sections, cards neutros */
  --beige: #e8e4da;
  
  /* Seções informativas, cards tech */
  --mint: #a8cec5;
  
  /* Seções de aprendizado, academia */
  --lavender: #b8b8d6;
  
  /* Seções de produto, CTAs (mesma do blue) */
  --sky-blue: #6a9bcc;
  
  /* Cards secundários */
  --soft-gray: #c8c6bc;
}
```

**Quando usar:**
- Hero sections full-width
- Cards com contexto específico
- Seções destacadas na página
- Backgrounds de mensagens (chat)

**Regra:** Máximo 2 cores pastéis por tela.

---

## 📝 Tipografia

### **Famílias de Fontes**

```html
<!-- No <head> do HTML -->
<link href="https://fonts.googleapis.com/css2?family=Lora:wght@400;500;600&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
```

```css
/* Títulos e conteúdo emotivo/narrativo */
font-family: 'Lora', Georgia, serif;

/* UI elements (botões, labels, tabs) */
font-family: 'Poppins', Arial, sans-serif;

/* Código e dados técnicos */
font-family: 'Courier New', monospace;
```

---

### **Hierarquia Tipográfica**

```css
/* Hero Title - Extra Large */
.hero-title {
  font-family: 'Lora', Georgia, serif;
  font-size: 3.5rem;      /* 56px */
  font-weight: 500;
  line-height: 1.1;
  letter-spacing: -1px;
}

/* Section Title - Large */
.section-title {
  font-family: 'Lora', Georgia, serif;
  font-size: 2.5rem;      /* 40px */
  font-weight: 500;
  line-height: 1.2;
  letter-spacing: -0.5px;
}

/* Card Title - Medium */
.card-title {
  font-family: 'Poppins', Arial, sans-serif;
  font-size: 1.5rem;      /* 24px */
  font-weight: 600;
  line-height: 1.3;
}

/* Body Large */
.body-large {
  font-family: 'Lora', Georgia, serif;
  font-size: 1.125rem;    /* 18px */
  line-height: 1.7;
}

/* Body Regular */
.body-regular {
  font-family: 'Lora', Georgia, serif;
  font-size: 1rem;        /* 16px */
  line-height: 1.7;
}

/* Small / UI Text */
.small-text {
  font-family: 'Poppins', Arial, sans-serif;
  font-size: 0.875rem;    /* 14px */
  line-height: 1.5;
}
```

**Regras:**
- ✅ Usar pesos 400-600 apenas
- ✅ Letter-spacing negativo em títulos grandes
- ✅ Line-height generoso (1.6-1.8) no corpo
- ❌ Nunca font-weight 700+ (bold pesado)
- ❌ Nunca all-caps em textos longos

---

## 🎨 Componentes

### **Cards**

```css
/* Card Padrão com Border-Left */
.card {
  background: #faf9f5;
  border-left: 3px solid #6a9bcc;  /* ou orange/green */
  padding: 2rem;
  border-radius: 10px;
  transition: all 0.3s ease;
}

.card:hover {
  border-left-color: #d97757;
}

/* Card com Background Colorido */
.card-colored {
  background: #a8cec5;  /* ou outro pastel */
  border-left: 3px solid #788c5d;
  padding: 2.5rem;
  border-radius: 12px;
}

/* Card Ativo/Selecionado */
.card.active {
  background: #a8cec5;
  border-left-width: 4px;
  border-left-color: #788c5d;
}
```

---

### **Botões**

```css
/* Primary Button */
.btn-primary {
  font-family: 'Poppins', Arial, sans-serif;
  background: #141413;
  color: #faf9f5;
  border: none;
  padding: 0.875rem 1.5rem;
  border-radius: 8px;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: opacity 0.2s ease;
}

.btn-primary:hover {
  opacity: 0.85;
}

/* Secondary Button (Outline) */
.btn-secondary {
  background: transparent;
  color: #141413;
  border: 2px solid #141413;
  padding: 0.875rem 1.5rem;
  border-radius: 8px;
  font-weight: 500;
  transition: background 0.2s ease;
}

.btn-secondary:hover {
  background: #e8e6dc;
}

/* Tertiary Button (Ghost) */
.btn-tertiary {
  background: rgba(20, 20, 19, 0.1);
  color: #141413;
  border: none;
  padding: 0.75rem 1.25rem;
  border-radius: 6px;
}

.btn-tertiary:hover {
  background: rgba(20, 20, 19, 0.15);
}
```

---

### **Toggle Switch**

```css
.toggle-switch {
  position: relative;
  width: 60px;
  height: 30px;
  cursor: pointer;
}

.toggle-switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

.toggle-slider {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #b0aea5;
  border-radius: 30px;
  transition: 0.3s;
}

.toggle-slider:before {
  position: absolute;
  content: "";
  height: 22px;
  width: 22px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  border-radius: 50%;
  transition: 0.3s;
}

.toggle-switch input:checked + .toggle-slider {
  background-color: #788c5d;
}

.toggle-switch input:checked + .toggle-slider:before {
  transform: translateX(30px);
}
```

---

### **Inputs e Forms**

```css
.input-field {
  font-family: 'Lora', Georgia, serif;
  border: 2px solid #b0aea5;
  background: #faf9f5;
  padding: 1rem 1.25rem;
  border-radius: 8px;
  font-size: 1rem;
  color: #141413;
  transition: all 0.2s ease;
}

.input-field:focus {
  border-color: #141413;
  outline: none;
  background: white;
}

.input-field:disabled {
  background: #e8e6dc;
  color: #b0aea5;
  cursor: not-allowed;
}
```

---

## 📏 Espaçamento

### **Sistema de Espaçamento**

```css
:root {
  --space-xs: 0.5rem;   /* 8px */
  --space-sm: 1rem;     /* 16px */
  --space-md: 1.5rem;   /* 24px */
  --space-lg: 2rem;     /* 32px */
  --space-xl: 3rem;     /* 48px */
  --space-2xl: 4rem;    /* 64px */
  --space-3xl: 6rem;    /* 96px */
}
```

**Aplicações:**
- Entre elementos no mesmo card: `1rem - 1.5rem`
- Entre cards/seções: `2rem - 4rem`
- Entre seções principais: `4rem - 6rem`
- Padding de cards: `2rem - 2.5rem`
- Padding de seções full-width: `4rem - 6rem`

---

## 🔲 Border Radius

```css
/* Elementos pequenos (badges, tags) */
border-radius: 4px;

/* Inputs, botões, cards padrão */
border-radius: 6px - 8px;

/* Cards médios */
border-radius: 8px - 10px;

/* Seções grandes, hero sections */
border-radius: 12px - 16px;

/* Modals, overlays */
border-radius: 10px - 12px;

/* ❌ NUNCA usar >20px (exceto casos muito específicos) */
```

---

## ✨ Animações e Transições

### **Durações Recomendadas**

```css
/* Micro-interações (hover, focus) */
transition: all 0.2s ease;

/* Elementos médios (cards, modais) */
transition: all 0.3s ease;

/* Elementos grandes (seções, layers) */
transition: all 0.5s ease;

/* Animações complexas */
transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
```

### **Propriedades Animáveis**

```css
/* ✅ Recomendado */
opacity: 0 → 1;
transform: translateY(20px) → translateY(0);
transform: translateX(-20px) → translateX(0);
transform: scale(0.95) → scale(1);

/* ❌ Evitar */
height: animação de altura (use max-height)
width: animação de largura
background: mudanças bruscas de cor
```

### **Estados de Hover**

```css
/* Cards */
.card:hover {
  border-color: #d97757;
  /* ❌ NÃO: transform: translateY(-4px); */
  /* ❌ NÃO: box-shadow: 0 4px 12px rgba(0,0,0,0.1); */
}

/* Botões */
.btn:hover {
  opacity: 0.85;
  /* ❌ NÃO: transform: scale(1.05); */
}

/* Links */
.link:hover {
  border-bottom: 1px solid #141413;
}
```

---

## 🎭 Estados Visuais

```css
/* Estado Normal */
.element {
  opacity: 1;
  border-color: #e8e6dc;
}

/* Estado Hover */
.element:hover {
  border-color: #b0aea5;
}

/* Estado Ativo/Selecionado */
.element.active {
  background: #a8cec5;
  border-color: #788c5d;
  border-left-width: 4px;
}

/* Estado Disabled */
.element:disabled {
  opacity: 0.4;
  cursor: not-allowed;
  background: #e8e6dc;
  color: #b0aea5;
}

/* Estado Focus */
.element:focus {
  outline: 2px solid #141413;
  outline-offset: 2px;
}
```

---

## 📱 Responsividade

```css
/* Desktop First */
@media (max-width: 1200px) {
  /* Tablet landscape */
  .grid-3-cols {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  /* Tablet portrait / Mobile landscape */
  .grid-3-cols {
    grid-template-columns: 1fr;
  }
  
  h1 {
    font-size: 2.5rem; /* reduz de 3.5rem */
  }
  
  .section-padding {
    padding: 2rem 1rem; /* reduz de 4rem 2rem */
  }
}

@media (max-width: 480px) {
  /* Mobile portrait */
  h1 {
    font-size: 2rem;
  }
  
  .btn {
    width: 100%;
    text-align: center;
  }
}
```

---

## ✅ Checklist de Qualidade

### **Visual**
- [ ] Background principal é `#faf9f5`?
- [ ] Não há gradientes?
- [ ] Cores pastéis apenas em seções específicas?
- [ ] Border-radius entre 6-16px?
- [ ] Visual geométrico, não orgânico?

### **Tipografia**
- [ ] Títulos grandes usam Lora?
- [ ] UI elements usam Poppins?
- [ ] Font-weights são 400-600?
- [ ] Line-height é 1.6-1.8?

### **Layout**
- [ ] Muito espaço em branco?
- [ ] Max-width entre 900-1400px?
- [ ] Padding generoso (2rem+)?
- [ ] Gaps adequados (2-6rem)?

### **Interações**
- [ ] Hover states sutis?
- [ ] Transições 200-500ms?
- [ ] Sem animações exageradas?
- [ ] Focus states visíveis?

---

## 🚫 Anti-Padrões

❌ **Evite:**

1. **Gradientes** - Nunca, em nenhum contexto
2. **Sombras pesadas** - box-shadow com blur >4px
3. **Backgrounds escuros grandes** - Preto apenas em headers/footers pequenos
4. **Border-radius >20px** - Exceto casos específicos
5. **Cores saturadas/vibrantes** - Tudo deve ser sutil
6. **Animações elaboradas** - Só transições simples
7. **Font-weight >700** - Nunca bold pesado
8. **Line-height <1.4** - Texto precisa respirar

---

## 📦 Template HTML Base

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Título da Página</title>
    <link href="https://fonts.googleapis.com/css2?family=Lora:wght@400;500;600&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --dark: #141413;
            --light: #faf9f5;
            --mid-gray: #b0aea5;
            --light-gray: #e8e6dc;
            --orange: #d97757;
            --blue: #6a9bcc;
            --green: #788c5d;
            --beige: #e8e4da;
            --mint: #a8cec5;
            --lavender: #b8b8d6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Lora', Georgia, serif;
            background: var(--light);
            color: var(--dark);
            line-height: 1.7;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Seu conteúdo aqui -->
    </div>
</body>
</html>
```

---

*Design System desenvolvido para o MAVE Framework*  
*Versão 1.0.0 - Outubro 2025*
