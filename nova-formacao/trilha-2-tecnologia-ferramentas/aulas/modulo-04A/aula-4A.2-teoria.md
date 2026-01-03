# Aula 4A.2: Dominando Vibe Coding

## Tipo: Teoria | Duração: 15 minutos

---

## GPS

### Goal (30s)
Entender quando usar cada ferramenta e como extrair o máximo do vibe coding.

### Position (60s)
Você criou um app. Agora precisa saber escolher a ferramenta certa para cada projeto.

### Steps
1. Comparativo de ferramentas (5 min)
2. Limites do vibe coding (4 min)
3. Padrões de prompts eficazes (6 min)

---

## Comparativo de Ferramentas

### Visão Geral

| Ferramenta | Força | Fraqueza | Preço |
|------------|-------|----------|-------|
| **Bolt** | Full-stack rápido | Menos customização visual | Free + Paid |
| **Lovable** | Design bonito | Limitado em lógica complexa | Free + Paid |
| **v0** | Componentes perfeitos | Não faz apps completos | Free + Paid |
| **Replit** | Flexibilidade | Curva de aprendizado | Free + Paid |

### Quando Usar Cada Uma

```
Quero criar um MVP completo?
└── Bolt

Quero algo visualmente impressionante?
└── Lovable

Preciso só de um componente específico?
└── v0

Quero iterar muito e ter controle?
└── Replit Agent
```

---

## Bolt — Full-Stack Rápido

### Melhor Para
- MVPs de SaaS
- Apps com banco de dados
- Projetos que precisam de backend

### Exemplo de Prompt Ideal

```
Crie um sistema de agendamento de consultas:

Funcionalidades:
- Cadastro de profissionais (nome, especialidade, horários)
- Clientes escolhem profissional e horário
- Confirmação por email
- Painel admin com agenda

Stack: React + Supabase
Design: Clean, cores neutras
```

### Resultado Típico
- Frontend React funcional
- Backend conectado
- Autenticação pronta
- Deploy em 1 clique

---

## Lovable — Apps Bonitos

### Melhor Para
- Landing pages premium
- Dashboards visuais
- Apps que impressionam cliente

### Exemplo de Prompt Ideal

```
Crie uma landing page para curso online de marketing digital:

Seções:
1. Hero com headline impactante e CTA
2. Benefícios (3 cards)
3. Módulos do curso (accordion)
4. Depoimentos (carrossel)
5. FAQ
6. Formulário de interesse

Visual: Moderno, gradientes suaves, animações sutis
Cores: Roxo (#7C3AED) e branco
```

### Resultado Típico
- Design profissional
- Animações incluídas
- Responsivo perfeito
- Código limpo

---

## v0 (Vercel) — Componentes Perfeitos

### Melhor Para
- Componentes de UI específicos
- Tabelas de preços
- Cards de produto
- Elementos isolados

### Exemplo de Prompt Ideal

```
Crie um componente de pricing table com 3 planos:

Plano Básico: R$97/mês
- 5 usuários
- 10GB storage
- Email support

Plano Pro: R$197/mês (destacado)
- 25 usuários
- 100GB storage
- Priority support
- API access

Plano Enterprise: Sob consulta
- Ilimitado
- Dedicated support
- Custom integrations

Estilo: Cards com sombra, hover effect, badge "Mais popular" no Pro
```

### Resultado Típico
- Componente React pronto
- Código copiável
- Fácil de integrar

---

## Replit Agent — Flexibilidade Total

### Melhor Para
- Protótipos rápidos para testar ideia
- Projetos que você quer iterar muito
- Quando precisa de linguagens específicas

### Exemplo de Prompt Ideal

```
Crie um bot de Telegram que:
- Recebe mensagens
- Consulta uma API de clima
- Responde com previsão formatada

Use Python com python-telegram-bot
```

### Resultado Típico
- Código funcional
- Ambiente pronto
- Deploy fácil

---

## Limites do Vibe Coding

### O que NÃO consegue fazer bem

| Limitação | Exemplo | Alternativa |
|-----------|---------|-------------|
| **Lógica muito complexa** | Algoritmo de ML customizado | Desenvolvedor |
| **Integrações raras** | API legada proprietária | Desenvolvedor |
| **Performance crítica** | App com milhões de usuários | Time técnico |
| **Segurança avançada** | Sistema bancário | Especialista |

### Quando Parar e Delegar

Sinais de que vibe coding não é suficiente:

- [ ] IA está gerando código com muitos erros
- [ ] Você está iterando mais de 20 vezes sem resultado
- [ ] Precisa de algo que nenhuma ferramenta oferece
- [ ] O projeto é crítico para o negócio

**Regra:** Se está gastando mais tempo corrigindo do que criando, delegue.

---

## Padrões de Prompts Eficazes

### Estrutura Vencedora

```
1. CONTEXTO: O que é o projeto
2. FUNCIONALIDADES: Lista clara do que precisa
3. VISUAL: Como deve parecer
4. TECH: Preferências técnicas (opcional)
5. RESTRIÇÕES: O que NÃO quer
```

### Exemplo Completo

```
CONTEXTO:
Dashboard para acompanhar métricas de vendas de e-commerce.

FUNCIONALIDADES:
- Gráfico de vendas diárias (últimos 30 dias)
- Cards com: receita total, ticket médio, conversão
- Tabela com top 10 produtos
- Filtro por período

VISUAL:
- Dark mode
- Cores: azul (#3B82F6) como principal
- Layout em grid
- Gráficos com animação

TECH:
- React + Recharts para gráficos
- Dados mockados (vou conectar depois)

RESTRIÇÕES:
- Sem login (por enquanto)
- Sem backend
- Máximo 3 páginas
```

---

## Checklist de Entendimento

- [ ] Sei quando usar Bolt vs Lovable vs v0
- [ ] Entendo os limites do vibe coding
- [ ] Consigo estruturar prompts eficazes
- [ ] Sei quando devo delegar para desenvolvedor

---

## Próximo Passo

Agora vamos criar um projeto mais elaborado: do prompt ao produto publicado.
