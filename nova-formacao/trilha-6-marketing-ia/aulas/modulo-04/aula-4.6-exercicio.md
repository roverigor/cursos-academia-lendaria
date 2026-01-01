# Aula 4.6: Seu Turno - Automacao Funcionando

## Metadados

| Campo | Valor |
|-------|-------|
| **Modulo** | 4 - Automacoes do Funil |
| **Aula** | 4.6 |
| **Tipo** | Exercicio |
| **Duracao** | 20 minutos |
| **Conceitos** | 1 (Execucao guiada) |

---

## 🎯 G - GOAL (Destino)

> **Ao final desta aula, voce vai ter sua automacao de funil funcionando.**

---

## 🗺️ P - POSITION (Origem)

> Voce viu. Agora e implementar.
>
> 20 minutos para ter automacao rodando.

---

## 🛤️ S - STEPS (Rota)

### Preparacao (2 min)

**Checklist:**
- [ ] Make.com aberto
- [ ] URL do form que quer automatizar
- [ ] Planilha de destino criada
- [ ] Modelo de scoring definido

---

### BLOCO 1: Webhook + Teste (5 min)

1. Crie cenario novo
2. Adicione Webhook
3. Copie URL
4. Configure no seu form
5. Teste: preencha o form e veja dados chegando

**[PAUSA: 5 minutos]**

---

### BLOCO 2: Calcular Score (5 min)

1. Adicione modulo "Set Variable"
2. Crie variavel "score"
3. Monte formula baseada em:
   - Cargo/funcao
   - Tamanho empresa/faturamento
   - Acao realizada

**Formula exemplo:**
```
{{if(1.cargo = "Dono", 30, 10)}} + {{if(1.faturamento > 50000, 20, 0)}}
```

**[PAUSA: 5 minutos]**

---

### BLOCO 3: Salvar + Rotear (8 min)

1. Adicione Google Sheets > Add Row
2. Mapeie campos: nome, email, score, data
3. Adicione Router
4. Configure 2 rotas por score
5. Adicione acoes (email/slack)

**[PAUSA: 8 minutos]**

---

### BLOCO 4: Ativar + Testar (2 min)

1. Ative o cenario
2. Faca teste completo
3. Verifique se lead chegou na planilha
4. Verifique se acao correta disparou

---

## 💡 Revisao

**O Insight:**
- Automacao funcionando em 20 minutos. Agora roda sozinha.

---

## ⚡ ACAO RAPIDA (2 min)

**Faca agora:**
1. Confirme que cenario esta ativo
2. Faca um teste real
3. Monitore por 24h

**Funcionou se:** Lead de teste passou pelo funil corretamente.

---

## 🎬 HOOK - Proxima Aula

> Automacao criada. Na proxima: validacao.
>
> **Proxima aula: 4.7 - Checklist de Automacao Funcionando**

---

*Aula 4.6 - Trilha 6 - Marketing com IA e Automacoes - Academia Lendaria*
