# Aula 5A.2: Comunicação Técnica para Não-Técnicos

## Tipo: Teoria | Duração: 15 minutos

---

## GPS

### Goal (30s)
Dominar o vocabulário técnico essencial para se comunicar com desenvolvedores sem parecer perdido.

### Position (60s)
Você não precisa saber programar. Precisa saber pedir e avaliar.

### Steps
1. Glossário essencial (6 min)
2. Como pedir certo (5 min)
3. Como avaliar entregas (4 min)

---

## Glossário Técnico Essencial

### Arquitetura

| Termo | Tradução | Exemplo |
|-------|----------|---------|
| **Frontend** | O que usuário vê | Site, app, interface |
| **Backend** | O que roda "por trás" | Servidor, banco, lógica |
| **Full-stack** | Front + Back | Dev que faz os dois |
| **API** | "Ponte" entre sistemas | Instagram → Seu site |
| **Database (Banco)** | Onde dados ficam salvos | Clientes, vendas, etc. |

### Tipos de Projeto

| Termo | O que é | Quando usar |
|-------|---------|-------------|
| **MVP** | Versão mínima que funciona | Validar ideia |
| **POC** | Prova de conceito | Testar se é possível |
| **SaaS** | Software como serviço | Produto com mensalidade |
| **Landing Page** | Página única | Captura, vendas |
| **Web App** | Aplicação no navegador | Sistemas, dashboards |

### Deploy e Infraestrutura

| Termo | O que é | Analogia |
|-------|---------|----------|
| **Deploy** | Colocar no ar | Abrir a loja |
| **Hosting** | Onde o site fica | Aluguel do ponto |
| **Domínio** | Endereço (URL) | Nome da rua |
| **SSL** | Cadeado verde | Segurança |
| **CDN** | Entrega rápida | Distribuidora |

### Processo

| Termo | O que é | Você deve pedir |
|-------|---------|-----------------|
| **Repositório** | Onde código fica salvo | Acesso ao GitHub |
| **Versionamento** | Histórico de mudanças | Git configurado |
| **Ambiente de teste** | Versão para testar | Link de homologação |
| **Documentação** | Manual do sistema | README + comentários |

---

## Como Pedir Certo

### A Fórmula OQUÊ-PARA-COMO

**O QUÊ:** O que precisa existir/funcionar
**PARA:** Qual problema resolve
**COMO:** Comportamento esperado

### Exemplo Ruim vs Bom

**Ruim:**
```
Quero um sistema de agendamento.
```

**Bom:**
```
O QUÊ: Sistema de agendamento online

PARA: Clientes marcarem consultas sem ligar/WhatsApp

COMO:
- Cliente escolhe serviço
- Vê horários disponíveis (integra com Google Calendar)
- Preenche nome, telefone, email
- Recebe confirmação por email
- Recebe lembrete 24h antes
- Pode cancelar/reagendar pelo link

RESTRIÇÕES:
- Máximo 3 agendamentos por dia por cliente
- Não agendar com menos de 2h de antecedência
```

### Template de Solicitação

```
## PROJETO: [Nome]

### O QUE PRECISA FAZER
[Descrição em 2-3 frases]

### FUNCIONALIDADES
1. [Funcionalidade 1 + comportamento]
2. [Funcionalidade 2 + comportamento]
3. [Funcionalidade 3 + comportamento]

### INTEGRAÇÕES
- [ ] Google Calendar
- [ ] WhatsApp
- [ ] Email
- [ ] Pagamento: [qual gateway]
- [ ] Outro: ___

### USUÁRIOS
- Perfil 1: [quem é, o que faz]
- Perfil 2: [quem é, o que faz]

### RESTRIÇÕES / REGRAS DE NEGÓCIO
- [Regra 1]
- [Regra 2]

### NÃO PRECISA (por enquanto)
- [O que pode ficar pra depois]

### REFERÊNCIAS
- [Site que gosta do visual]
- [Funcionalidade que viu em X]
```

---

## Como Avaliar Entregas

### Checklist de Aceitação

| Categoria | Verificar | Status |
|-----------|-----------|--------|
| **Funciona** | Todas as features funcionam? | [ ] |
| **Mobile** | Funciona no celular? | [ ] |
| **Performance** | Carrega em <3 segundos? | [ ] |
| **Dados** | Salva e recupera corretamente? | [ ] |
| **Erros** | Mensagens claras quando algo dá errado? | [ ] |

### Checklist de Entrega

| Item | O que é | Você precisa ter |
|------|---------|------------------|
| **Código fonte** | O projeto todo | Acesso ao repositório |
| **Credenciais** | Senhas e acessos | Documento com tudo |
| **Documentação** | Como funciona | README pelo menos |
| **Ambiente** | Onde está rodando | Acesso ao servidor |
| **Backup** | Cópia de segurança | Configurado e testado |

### Perguntas na Entrega

1. "Me mostra funcionando em produção"
2. "Faz login com usuário de teste"
3. "O que acontece se eu fizer [cenário de erro]?"
4. "Como faço para mudar [configuração comum]?"
5. "Se precisar de manutenção, como funciona?"

---

## Red Flags na Entrega

| Sinal | O que significa | O que fazer |
|-------|-----------------|-------------|
| "Está funcionando na minha máquina" | Não testou em produção | Exija ver no ar |
| Sem acesso ao código | Você fica refém | Não aceite |
| Não explica como usar | Vai te dar trabalho | Peça documentação |
| Muitos "depois eu arrumo" | Dívida técnica | Negocie antes de pagar |
| Funciona mas é lento | Problema de arquitetura | Questione |

---

## Matriz de Decisão: Fazer vs Delegar

```
Faça você mesmo (Vibe Coding):
├── Landing pages simples
├── MVPs para validar
├── Protótipos rápidos
├── Automações pontuais
└── Dashboards internos

Delegue para profissional:
├── Sistemas críticos
├── Integrações complexas
├── Apps com muitos usuários
├── Segurança sensível (pagamentos, dados pessoais)
└── Manutenção de longo prazo
```

---

## Checklist de Entendimento

- [ ] Sei a diferença entre frontend e backend
- [ ] Entendo o que é API e banco de dados
- [ ] Consigo estruturar um pedido claro
- [ ] Sei o que pedir na entrega
- [ ] Identifico red flags básicos

---

## Próximo Passo

Agora vamos criar um briefing técnico completo para um projeto real.
