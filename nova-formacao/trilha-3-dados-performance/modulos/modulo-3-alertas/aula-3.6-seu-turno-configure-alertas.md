# Aula 3.6: Seu Turno - Configure 3 Alertas

## Metadados

| Campo | Valor |
|-------|-------|
| **Módulo** | 3 - Alertas Inteligentes |
| **Aula** | 3.6 |
| **Tipo** | Exercício |
| **Duração** | 20 minutos |
| **Conceitos** | 2 (Prática guiada + 3 tipos de alerta) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, você vai ter 3 alertas configurados e funcionando — prontos pra te avisar quando algo sair do normal.**
>
> Não é teoria. É seu sistema de alertas real.

---

## 🗺️ P - POSITION (Origem)

> "Consigo fazer sozinho?"
>
> Sim. Você viu a demo.
>
> Agora vou te guiar passo a passo.
>
> Se travar, volta na aula 3.5.
>
> Mas tenta primeiro. Você vai se surpreender.

---

## 🛤️ S - STEPS (Rota)

### Antes de Começar

**Checklist de preparação:**

| Item | ✅ / ❌ |
|------|--------|
| Conta no n8n (cloud ou self-hosted) | |
| Planilha Google Sheets com dados | |
| Evolution API configurada (ou Twilio/outro) | |
| 3 métricas definidas (aula 3.3) | |

**Se não tem Evolution API:** Use e-mail como alternativa. A lógica é a mesma.

---

### Exercício 1: Alerta de CRISE (5 min)

**Objetivo:** Criar alerta que dispara quando algo crítico acontece.

**Sua métrica de crise:**
- Exemplo: Faturamento diário < R$500
- Ou: Churn diário > 2 clientes
- Ou: [Sua métrica da aula 3.3]

**Passo a passo:**

1. **Crie novo workflow no n8n**
   - Nome: "Alerta Crise - [Sua Métrica]"

2. **Adicione Trigger**
   - Schedule: A cada hora (ou quando fizer sentido)

3. **Adicione Google Sheets**
   - Conecte sua planilha
   - Selecione a coluna da métrica

4. **Adicione IF**
   - Condição: Métrica < [seu limite]

5. **Adicione HTTP Request (ou Email)**
   - Configure mensagem: "🚨 CRISE: [descrição]"

6. **Teste**
   - Coloque valor crítico na planilha
   - Execute e confirme recebimento

**Template de mensagem:**
```
🚨 ALERTA DE CRISE

📊 Métrica: [nome]
📉 Valor atual: [valor]
⚠️ Limite: [limite]

🏃 Ação: Verificar AGORA
```

---

### Exercício 2: Alerta de TENDÊNCIA (7 min)

**Objetivo:** Criar alerta que detecta padrões ruins.

**Sua métrica de tendência:**
- Exemplo: 3 dias consecutivos abaixo da média
- Ou: Conversão caindo há 3 dias
- Ou: [Sua métrica da aula 3.3]

**Passo a passo:**

1. **Crie novo workflow**
   - Nome: "Alerta Tendência - [Sua Métrica]"

2. **Adicione Trigger**
   - Schedule: Diário às 9h

3. **Adicione Google Sheets**
   - Busque os últimos 3-5 dias

4. **Adicione Code node (JavaScript simples)**
   ```javascript
   // Verifica se todos os dias estão abaixo da média
   const dados = $input.all();
   const media = 1000; // sua média
   const todosBaixos = dados.every(d => d.json.valor < media);
   return [{ json: { alerta: todosBaixos } }];
   ```

5. **Adicione IF**
   - Condição: alerta = true

6. **Adicione HTTP Request/Email**
   - Mensagem: "⚠️ TENDÊNCIA: [descrição]"

7. **Teste**
   - Coloque 3 dias ruins na planilha
   - Execute e confirme

**Template de mensagem:**
```
⚠️ ALERTA DE TENDÊNCIA

📊 Métrica: [nome]
📉 Situação: [X] dias abaixo da média
📈 Média esperada: [valor]

🔍 Ação: Investigar causa
```

---

### Exercício 3: Alerta de META (5 min)

**Objetivo:** Criar alerta que avisa se está longe da meta.

**Sua métrica de meta:**
- Exemplo: Dia 15 com menos de 40% da meta
- Ou: Semana 2 com menos de 50%
- Ou: [Sua métrica da aula 3.3]

**Passo a passo:**

1. **Crie novo workflow**
   - Nome: "Alerta Meta - [Período]"

2. **Adicione Trigger**
   - Schedule: Semanal (segunda às 9h)

3. **Adicione Google Sheets**
   - Busque faturamento acumulado do mês

4. **Adicione Code node**
   ```javascript
   // Verifica % da meta atingida
   const acumulado = $input.first().json.acumulado;
   const meta = 10000; // sua meta mensal
   const diaDoMes = new Date().getDate();
   const esperado = (meta / 30) * diaDoMes;
   const percentual = (acumulado / esperado) * 100;
   return [{ json: { percentual, abaixo: percentual < 70 } }];
   ```

5. **Adicione IF**
   - Condição: abaixo = true

6. **Adicione HTTP Request/Email**
   - Mensagem: "📊 META: [descrição]"

7. **Teste**
   - Simule valor baixo
   - Execute e confirme

**Template de mensagem:**
```
📊 ALERTA DE META

🎯 Meta do mês: R$ [valor]
📅 Acumulado: R$ [valor]
📉 Percentual: [X]% do esperado

📋 Ação: Revisar estratégia
```

---

### Checklist de Validação

| Alerta | Criado | Testado | Ativo |
|--------|--------|---------|-------|
| 🚨 Crise | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |
| ⚠️ Tendência | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |
| 📊 Meta | ✅ / ❌ | ✅ / ❌ | ✅ / ❌ |

**Resultado:**
- 3/3 ativos → **COMPLETO** - Parabéns!
- 2/3 ativos → **QUASE** - Finalize o último
- 1/3 ativo → **EM PROGRESSO** - Continue tentando
- 0/3 → **INÍCIO** - Volte na aula 3.5

---

### 🤔 Pergunta Reflexiva

> "Qual alerta você mais quer receber?"
>
> O de crise (urgência)?
> O de tendência (prevenção)?
> O de meta (acompanhamento)?
>
> Esse é o primeiro que você deve testar de verdade.

---

### Dicas de Troubleshooting

| Problema | Solução |
|----------|---------|
| "Não consigo conectar Google Sheets" | Verifique permissões da conta Google |
| "Workflow não executa" | Confirme que está "Active" (verde) |
| "Mensagem não chega" | Teste o nó de envio isoladamente |
| "Condição sempre falha" | Verifique tipos de dados (string vs number) |
| "Código JavaScript dá erro" | Copie exatamente como está acima |

---

## 💡 Revisão

**Os 2 Insights:**

1. **Fazer é mais fácil que parecer** — Seguindo o passo a passo, qualquer um consegue.

2. **3 alertas cobrem o essencial** — Crise (urgente), Tendência (atenção), Meta (acompanhamento).

**A Transformação:**
- **Antes:** "Não sei configurar automação"
- **Depois:** "Tenho 3 alertas funcionando no meu negócio"

---

## ⚡ AÇÃO RÁPIDA (3 min)

**Faça agora:**
1. Ative pelo menos 1 alerta de verdade
2. Coloque um valor que dispara o alerta
3. Confirme que recebeu a mensagem

**Funcionou se:** Você recebeu uma mensagem de alerta no seu celular/e-mail.

---

## 🎬 HOOK - Próxima Aula

> Você tem alertas configurados.
>
> Mas como saber se estão funcionando direito?
>
> Na próxima aula, vamos testar tudo e preparar você pro próximo módulo.
>
> Spoiler: Vamos colocar INTELIGÊNCIA nos seus dados.
>
> **Próxima aula: 3.7 - Testando e Próximos Passos**

---

*Aula 3.6 - Trilha 3 - Academia Lendária*
