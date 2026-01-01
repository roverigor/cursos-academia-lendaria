# Aula 4.5: Automacao Completa ao Vivo

## Metadados

| Campo | Valor |
|-------|-------|
| **Modulo** | 4 - Automacoes do Funil |
| **Aula** | 4.5 |
| **Tipo** | Demo |
| **Duracao** | 15 minutos |
| **Conceitos** | 1 (Execucao pratica) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, voce vai ter visto uma automacao de funil completa sendo criada do zero.**

---

## 🗺️ P - POSITION (Origem)

> Voce conhece os modulos.
>
> Agora vou montar a automacao completa ao vivo.

---

## 🛤️ S - STEPS (Rota)

### O Caso

**Contexto:**
- LP de consultoria
- Form com: nome, email, telefone, faturamento
- Objetivo: qualificar e rotear automaticamente

---

### [DEMO AO VIVO]

**[Momento 1 - Webhook] (~2 min)**

> "Primeiro, crio o webhook..."

1. Novo cenario
2. Adicionar Webhooks > Custom Webhook
3. Copiar URL
4. Conectar ao form

---

**[Momento 2 - Calcular Score] (~3 min)**

> "Agora calculo o score..."

```
Set Variable: score

Formula:
{{if(contains(1.faturamento, "50-100k"), 30, 0)}}
+ {{if(contains(1.cargo, "CEO"), 25, 0)}}
+ 10 (por baixar material)
```

---

**[Momento 3 - Salvar Lead] (~2 min)**

> "Salvo na planilha antes de rotear..."

- Google Sheets > Add Row
- Colunas: nome, email, telefone, score, data

---

**[Momento 4 - Router] (~3 min)**

> "Agora o roteamento por score..."

- Router com 2 rotas:
  - Rota 1: score < 60 → Email nurturing
  - Rota 2: score >= 60 → Slack + Email SDR

---

**[Momento 5 - Teste] (~3 min)**

> "Testando o fluxo completo..."

1. Preencho form de teste
2. Webhook recebe
3. Score calculado: 55
4. Lead salvo na planilha
5. Email nurturing disparado

---

**[Momento 6 - Ativar] (~2 min)**

> "Ativando o cenario..."

- Scheduling: On
- Erro handling: Email de alerta

---

### Fluxo Final

```
[Webhook LP] → [Calcular Score] → [Salvar Sheets] → [Router]
                                                        ↓
                                    ┌───────────────────┼───────────────────┐
                                    ↓                                       ↓
                            [Score < 60]                            [Score >= 60]
                                    ↓                                       ↓
                            [Email Nurturing]                   [Slack + Email SDR]
```

---

## 💡 Revisao

**O Insight:**
- Automacao de funil completa em 15 minutos. Funciona 24/7.

---

## ⚡ ACAO RAPIDA (2 min)

**Faca agora:**
1. Anote a estrutura do fluxo
2. Identifique adaptacoes pro seu caso
3. Prepare ambiente pro exercicio

**Funcionou se:** Voce sabe o que vai implementar.

---

## 🎬 HOOK - Proxima Aula

> Sua vez de criar.
>
> **Proxima aula: 4.6 - Implementar Automacao no Seu Negocio**

---

*Aula 4.5 - Trilha 6 - Marketing com IA e Automacoes - Academia Lendaria*
