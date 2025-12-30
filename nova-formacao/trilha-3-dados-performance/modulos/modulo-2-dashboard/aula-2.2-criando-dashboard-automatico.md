# Aula 2.2: Criando Dashboard que se Atualiza Sozinho

## Metadados da Aula

| Campo | Valor |
|-------|-------|
| **Módulo** | 2 - Dashboard Automatizado |
| **Aula** | 2.2 |
| **Tipo** | Prática (hands-on) |
| **Duração** | 60 minutos |
| **Formato** | Screencast + Demonstração |
| **Entregável** | Dashboard com 5-7 métricas funcionando |

---

## Objetivos da Aula

Ao final desta aula, o aluno terá:
1. Dashboard criado no Looker Studio (ou alternativa)
2. 5-7 métricas configuradas com metas
3. Cores condicionais funcionando (verde/amarelo/vermelho)
4. Pelo menos 1 fonte de dados automática

---

## Materiais Necessários

- [ ] Conta Google (para Looker Studio)
- [ ] Template: modulo-2-dashboard.md
- [ ] Mapa de Dados do Módulo 1 (para selecionar métricas)
- [ ] Google Sheets com dados do negócio

---

## Roteiro de Fala

### ABERTURA (3 min)

**[TELA: Looker Studio aberto]**

> "Hora de colocar a mão na massa."
>
> "Nesta aula, você vai criar seu dashboard do zero. Vai demorar 60 minutos. E no final você vai ter algo que funciona DE VERDADE."
>
> "Vou fazer junto com você. Meu dashboard, meus dados. Assim você vê o processo real, não uma demonstração ensaiada."
>
> "Antes de começar, abre seu Mapa de Dados do Módulo 1. Você vai precisar dele pra escolher as métricas."

---

### PARTE 1: ESCOLHENDO AS MÉTRICAS (10 min)

**[TELA: Template de métricas]**

> "Primeiro passo: escolher quais métricas vão pro dashboard."
>
> "Regra de ouro: 5 a 7 métricas. Não mais."
>
> "Como escolher? Vou te dar um framework."

**[SLIDE: Framework de Seleção]**

> "Você precisa de pelo menos uma métrica em cada categoria:"
>
> "1. FINANCEIRO — Como está a saúde do caixa?"
>    "Sugestão: Faturamento mensal"
>
> "2. COMERCIAL — Como estão as vendas?"
>    "Sugestão: Leads ou Taxa de Conversão"
>
> "3. CLIENTE — Como está a base?"
>    "Sugestão: Churn ou NPS"
>
> "4. EFICIÊNCIA — Quanto estamos gastando pra crescer?"
>    "Sugestão: CAC ou Ticket Médio"

**[TELA: Meu Mapa de Dados]**

> "Vou olhar meu Mapa de Dados e escolher as minhas 6 métricas:"
>
> [Demonstração ao vivo]
>
> "1. Faturamento do mês — financeiro"
> "2. Margem líquida — financeiro"
> "3. Leads do mês — comercial"
> "4. Taxa de conversão — comercial"
> "5. Clientes ativos — cliente"
> "6. Ticket médio — eficiência"
>
> "6 métricas. Uma tela. É isso que eu quero."

**[PAUSA PARA ALUNO]**

> "Agora você: olha seu Mapa de Dados e escolhe suas 5-7 métricas."
>
> "Anota em algum lugar. Vou te dar 2 minutos."
>
> [PAUSA: 2 minutos]

---

### PARTE 2: PREPARANDO OS DADOS (10 min)

**[TELA: Google Sheets]**

> "Agora vamos garantir que seus dados estão prontos pra conectar."
>
> "Se você já tem uma planilha com os dados, ótimo. Vamos usar ela."
>
> "Se não tem, vamos criar uma estrutura básica agora."

**[TELA: Estrutura de Planilha]**

> "A estrutura mais simples que funciona:"
>
> "Aba 1: Dados_Diarios"
> "Colunas: Data | Faturamento | Leads | Conversões | Vendas | Ticket"
>
> "Aba 2: Metas"
> "Colunas: Métrica | Meta_Mensal | Meta_Diária"
>
> "Aba 3: Calculado"
> "Aqui ficam as fórmulas que consolidam tudo"

**[Demonstração criando/ajustando planilha]**

> "Vou mostrar minha planilha. Não é perfeita, mas funciona."
>
> [Mostra planilha real com dados]
>
> "O importante: os dados precisam estar em formato tabular. Linha por linha, coluna por coluna. Sem células mescladas, sem formatação maluca."

**[PAUSA PARA ALUNO]**

> "Se sua planilha não está assim, pausa o vídeo e arruma."
>
> "Não precisa ser perfeita. Precisa ser conectável."
>
> [PAUSA: 3 minutos]

---

### PARTE 3: CRIANDO O DASHBOARD (25 min)

**[TELA: Looker Studio - Início]**

> "Agora vamos pro Looker Studio."
>
> "Abre lookerstudio.google.com"
>
> "Se nunca usou, vai pedir pra aceitar termos. Aceita."

#### Passo 1: Conectar Fonte de Dados (5 min)

**[TELA: Criar Fonte de Dados]**

> "Primeiro: conectar sua planilha."
>
> "Clica em 'Criar' → 'Fonte de dados'"
> "Escolhe 'Google Sheets'"
> "Seleciona sua planilha"
> "Escolhe a aba com os dados"
> "Clica 'Conectar'"
>
> [Demonstração ao vivo]
>
> "Pronto. Agora o Looker Studio sabe de onde puxar os dados."

#### Passo 2: Criar o Relatório (5 min)

**[TELA: Criar Relatório]**

> "Agora vamos criar o dashboard propriamente dito."
>
> "Clica em 'Criar' → 'Relatório'"
> "Escolhe a fonte de dados que acabou de criar"
> "Começa com uma página em branco"
>
> [Demonstração]
>
> "Você vai ver uma tela vazia. Normal. Vamos popular."

#### Passo 3: Adicionar Métricas (10 min)

**[TELA: Adicionando Scorecards]**

> "Pra cada métrica, vamos usar um SCORECARD — aquele número grande que mostra o valor."
>
> "Clica em 'Inserir' → 'Cartão de métricas'"
> "Arrasta pro lugar que você quer"
> "Na lateral direita, escolhe qual coluna da planilha vai mostrar"
>
> [Demonstração adicionando 1 scorecard]
>
> "Vou adicionar minhas 6 métricas. Você faz junto."
>
> [Demonstração adicionando todas as métricas]
>
> "Repete o processo pra cada métrica."
>
> [PAUSA: 5 minutos para aluno fazer]

#### Passo 4: Configurar Cores Condicionais (5 min)

**[TELA: Formatação Condicional]**

> "Agora a parte mais importante: as cores."
>
> "Clica no scorecard"
> "Vai em 'Estilo' na lateral direita"
> "Ativa 'Formatação condicional'"
>
> "Configura:"
> "- Se valor >= meta → Verde"
> "- Se valor >= 80% da meta → Amarelo"
> "- Se valor < 80% da meta → Vermelho"
>
> [Demonstração]
>
> "Agora quando você abrir o dashboard, em 5 segundos sabe se tá tudo bem."
>
> [PAUSA: 3 minutos para aluno configurar]

---

### PARTE 4: CONFIGURANDO ATUALIZAÇÃO (7 min)

**[TELA: Configurações de Fonte]**

> "De nada adianta um dashboard bonito se o dado não atualiza."
>
> "Vamos configurar a atualização automática."

**[TELA: Editar Conexão]**

> "Volta pra sua fonte de dados (não o relatório)"
> "Clica em 'Editar conexão'"
> "Em 'Atualização de dados', escolhe a frequência:"
> "- 'A cada hora' pra dados que mudam muito"
> "- 'Diariamente' pra maioria dos casos"
>
> [Demonstração]
>
> "Pronto. O Looker Studio vai buscar dados novos automaticamente."

**[SLIDE: "E se minha planilha não atualiza sozinha?"]**

> "Agora, uma observação importante:"
>
> "O Looker Studio puxa da planilha. Mas se a planilha não atualiza, o dado continua velho."
>
> "Como resolver isso?"
>
> "Opção 1: Alguém atualiza a planilha manualmente (funciona, mas é frágil)"
>
> "Opção 2: Conectar a planilha direto no sistema (via API, integração)"
>
> "Opção 3: Usar automação (n8n, Zapier) pra puxar dados automaticamente"
>
> "No Módulo 3 vamos falar de automação. Por agora, garanta que pelo menos 1 dado atualiza sozinho."

---

### PARTE 5: TOQUES FINAIS (5 min)

**[TELA: Dashboard quase pronto]**

> "Últimos ajustes pra seu dashboard ficar profissional:"

**[TELA: Filtro de Período]**

> "1. Adicionar filtro de período:"
> "Inserir → Controle de intervalo de datas"
> "Assim você pode ver: hoje, esta semana, este mês"

**[TELA: Título e Layout]**

> "2. Adicionar título:"
> "Inserir → Caixa de texto"
> "Escreve: 'Dashboard - [Nome do Negócio]'"
>
> "3. Organizar layout:"
> "Agrupa métricas relacionadas"
> "Deixa espaço pra respirar"
> "Menos é mais"

**[TELA: Compartilhamento]**

> "4. Compartilhar:"
> "Clica em 'Compartilhar'"
> "Escolhe quem pode ver"
> "Copia o link e salva em algum lugar fácil"

---

### FECHAMENTO (0 min - transição)

**[TELA: Dashboard finalizado]**

> "Se você seguiu até aqui, agora você tem:"
>
> "✅ Dashboard com 5-7 métricas"
> "✅ Cores que mostram status"
> "✅ Dados que atualizam"
> "✅ Link que pode acessar de qualquer lugar"
>
> "Não é o dashboard mais sofisticado do mundo. Mas é um dashboard que FUNCIONA."

**[SLIDE: "Mas e se..."]**

> "Você pode estar pensando: 'Legal, mas ainda preciso abrir o dashboard pra ver se tem problema.'"
>
> "E se o problema vier até você, em vez de você ir até o problema?"
>
> "Isso é o Módulo 3: Alertas Inteligentes."
>
> "Vamos configurar alertas que te avisam no WhatsApp quando algo sai do normal."
>
> "Te vejo lá."

---

## Timestamps para Edição

| Tempo | Conteúdo |
|-------|----------|
| 0:00-3:00 | Abertura |
| 3:00-13:00 | Escolhendo métricas |
| 13:00-23:00 | Preparando dados |
| 23:00-48:00 | Criando dashboard (4 passos) |
| 48:00-55:00 | Configurando atualização |
| 55:00-60:00 | Toques finais + fechamento |

---

## Alternativas por Ferramenta

### Se o aluno usa Power BI

- Conectar via "Obter dados" → "Web" ou "Excel"
- Usar "Cartão" para scorecards
- Formatação condicional em "Formato" → "Cor do fundo"
- Publicar em "Publicar no Power BI Service"

### Se o aluno usa Metabase

- Conectar via "Admin" → "Databases"
- Usar "Number" para métricas individuais
- Criar "Dashboard" e adicionar cards
- Configurar refresh automático

### Se o aluno usa Notion

- Criar tabela com dados
- Usar fórmulas para cálculos
- Emojis para indicar status (🟢🟡🔴)
- Mais simples, menos automação

---

## Notas de Produção

### Formato
- Screencast com câmera pequena
- Zoom em áreas importantes
- Cursor destacado e movimentos lentos

### Erros Comuns a Mostrar
- "Ops, selecionei a coluna errada" → corrigir
- "Aqui não funcionou porque..." → explicar
- Humaniza e ensina troubleshooting

### Pausas
- Pausas generosas para aluno acompanhar
- "Pausa o vídeo se precisar de mais tempo"
- Contador visual para pausas

---

## Entregável do Módulo

**O que o aluno deve ter ao final:**

1. Dashboard funcionando no Looker Studio (ou alternativa)
2. 5-7 métricas visíveis
3. Pelo menos 1 cor condicional configurada
4. Atualização automática ativa
5. Link compartilhável salvo

**Critério de conclusão:**
- Básico: 3 métricas + 1 automática
- Completo: 5-7 métricas + cores + atualização

---

## Troubleshooting Comum

| Problema | Solução |
|----------|---------|
| Dados não aparecem | Verificar se selecionou aba correta |
| Erro de conexão | Reautorizar Google Sheets |
| Número aparece estranho | Verificar formato na planilha |
| Cor não muda | Revisar regra de formatação condicional |
| Dashboard lento | Reduzir período de dados, simplificar |

---

*Roteiro Aula 2.2 - Trilha 3*
*Academia Lendária*
