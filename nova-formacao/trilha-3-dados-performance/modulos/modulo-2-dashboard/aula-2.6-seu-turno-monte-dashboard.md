# Aula 2.6: Seu Turno - Monte Seu Dashboard

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 2 - Dashboard Automatizado |
| **Aula** | 2.6 |
| **Tipo** | Exercício |
| **Duração** | 20 minutos |
| **Conceitos** | 1 (Execução guiada) |
| **Formato** | Prática com orientação |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter seu Dashboard COMPLETO — suas 5-7 métricas visualizadas com cores indicando ação.**
>
> Este é o entregável do módulo. Quando terminar, você tem uma ferramenta que vai usar todo dia.

---

## 🗺️ P - POSITION (Origem)

> Chegou a hora de fazer.
>
> Não precisa ficar perfeito. Precisa ficar FUNCIONAL.
>
> Você pode ajustar cores e layout depois. O importante é ter os dados aparecendo.
>
> 20 minutos. Vamos.

---

## 🛤️ S - STEPS (Rota)

### Preparação (2 min)

**Antes de começar, confirme:**

- [ ] Looker Studio aberto
- [ ] Planilha de dados organizada (pelo menos 1 mês de dados)
- [ ] Lista das 5-7 métricas (da aula 2.3)
- [ ] Metas definidas (verde/amarelo/vermelho)

> "Se sua planilha não está organizada ainda, faça isso primeiro."
>
> "Dashboard sem dados = nada."

---

### BLOCO 1: Conectar Dados (3 min)

**[CRONÔMETRO: 3:00]**

**Passo a passo:**
1. Looker Studio → "Criar" → "Relatório"
2. "Adicionar dados"
3. Escolha sua fonte:
   - Google Sheets → Selecione a planilha
   - Excel → Faça upload primeiro
4. Confirme a conexão

**Troubleshooting:**
| Problema | Solução |
|----------|---------|
| "Não aparece minha planilha" | Verifique se está logado na mesma conta Google |
| "Dados não carregam" | A primeira linha deve ser cabeçalho |
| "Números aparecem como texto" | Formate a coluna como número no Sheets |

**[PAUSA: 3 minutos]**

---

### BLOCO 2: Criar Scorecards (7 min)

**[CRONÔMETRO: 7:00]**

> "Crie 1 scorecard por métrica."

**Para cada métrica:**
1. Inserir → Scorecard
2. Arraste o campo da métrica
3. Dê um título claro
4. Formate (moeda, porcentagem, número)

**Exemplo de formatação:**
| Métrica | Formato | Exemplo |
|---------|---------|---------|
| Faturamento | Moeda (R$) | R$ 150.000 |
| Leads | Número inteiro | 120 |
| Conversão | Porcentagem | 8,5% |
| Ticket | Moeda (R$) | R$ 2.800 |
| Churn | Porcentagem | 3,2% |

> "Crie os 5-7 scorecards agora."

**[PAUSA: 7 minutos]**

---

### BLOCO 3: Configurar Cores (5 min)

**[CRONÔMETRO: 5:00]**

> "Cores são o que transformam números em ação."

**Para cada scorecard:**
1. Selecione → "Estilo"
2. "Formatação condicional"
3. Adicione regras:

**Exemplo para Conversão (meta 8%):**
- Se < 5% → Vermelho
- Se 5-8% → Amarelo
- Se > 8% → Verde

**Exemplo para Churn (meta <3%):**
- Se > 5% → Vermelho
- Se 3-5% → Amarelo
- Se < 3% → Verde

> "Configure cores para pelo menos 3 métricas."

**[PAUSA: 5 minutos]**

---

### BLOCO 4: Adicionar Gráfico (3 min)

**[CRONÔMETRO: 3:00]**

> "Um gráfico de linha mostra tendência."

1. Inserir → Gráfico de série temporal
2. Dimensão: Data/Mês
3. Métrica: Faturamento (ou sua métrica principal)
4. Opcional: Adicione linha de meta

**Dica:** Se você tem poucos dados (1-2 meses), o gráfico vai parecer vazio. Tudo bem — ele vai se preencher com o tempo.

**[PAUSA: 3 minutos]**

---

### Consolidação (2 min)

**Revise seu dashboard:**

| Checklist | ✅ / ❌ |
|-----------|--------|
| Dados conectados | |
| 5-7 scorecards criados | |
| Pelo menos 3 com cores condicionais | |
| 1 gráfico de tendência | |
| Filtro de data (opcional) | |

> "Salve o dashboard."
>
> "Abra no celular (menu → visualizar) pra ver como fica em mobile."

---

## 💡 Revisão

**O Insight:**
- Um dashboard imperfeito que você usa é melhor que um dashboard perfeito que você nunca termina.

**A Transformação:**
- **Antes:** "Preciso ver vários sistemas pra entender meu negócio"
- **Depois:** "Abro UMA tela e vejo tudo"

---

## ⚡ AÇÃO RÁPIDA (2 min)

**Faça agora:**
1. Salve o link do dashboard
2. Adicione aos favoritos do navegador
3. Defina lembrete pra abrir amanhã de manhã

**Funcionou se:** Você tem acesso rápido ao dashboard.

---

## 🎬 HOOK - Próxima Aula

> Seu dashboard está pronto.
>
> Mas ele só é útil se os dados chegarem nele.
>
> Na próxima aula, vou te mostrar como automatizar a alimentação — pra você nunca mais precisar preencher manualmente.
>
> Google Sheets + automação = dados sempre atualizados.
>
> **Próxima aula: 2.7 - Automatização e Próximos Passos**

---

*Aula 2.6 - Trilha 3 - Academia Lendária*
