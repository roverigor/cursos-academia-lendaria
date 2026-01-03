# Aula 4B.4: Deploy e Compromisso 48h

## Tipo: Validação | Duração: 10 minutos

---

## GPS

### Goal (30s)
Publicar seu projeto e definir como vai incorporar IDEs com IA no dia a dia.

### Position (60s)
Projeto no localhost é exercício. Projeto no ar é portfólio.

### Steps
1. Deploy (4 min)
2. Plano de adoção (3 min)
3. Compromisso 48h (3 min)

---

## Deploy do Projeto

### Backend: Railway ou Render

**Railway (mais fácil):**
1. Acesse: https://railway.app
2. Login com GitHub
3. "New Project" → "Deploy from GitHub"
4. Selecione seu repositório
5. Railway detecta e configura automaticamente
6. Copie a URL gerada

**Render:**
1. Acesse: https://render.com
2. Login com GitHub
3. "New Web Service"
4. Conecte repositório
5. Configure:
   - Build: `npm install && npm run build`
   - Start: `npm start`

### Frontend: Vercel ou Netlify

**Vercel (recomendado para React):**
1. Acesse: https://vercel.com
2. Login com GitHub
3. "Import Project"
4. Selecione repositório do frontend
5. Deploy automático

**Netlify:**
1. Acesse: https://netlify.com
2. Arraste a pasta `dist/build` para o site
3. Ou conecte GitHub para deploy automático

### Checklist de Deploy

- [ ] Backend no ar (URL: _____________)
- [ ] Frontend no ar (URL: _____________)
- [ ] Frontend conectado ao backend (ajustar URL da API)
- [ ] Testei as funcionalidades em produção

---

## Plano de Adoção

### Quando Usar IA na IDE

| Situação | Usar IA? | Como |
|----------|----------|------|
| Código novo | ✅ Sempre | Cmd+K para gerar |
| Entender código | ✅ Sempre | Selecionar + Cmd+L |
| Debug | ✅ Sempre | Colar erro no chat |
| Refatorar | ✅ Na maioria | Selecionar + "Refatore" |
| Código crítico | ⚠️ Com revisão | Gerar + revisar cuidadosamente |
| Código sensível | ⚠️ Cuidado | Não colar dados reais |

### Workflows para Adotar

**Workflow 1: Início do dia**
```
1. Abrir projeto no Cursor
2. Cmd+L: "O que eu estava fazendo ontem? Resuma os últimos commits"
3. Cmd+L: "O que ainda precisa ser feito?"
```

**Workflow 2: Nova feature**
```
1. Cmd+K: "Crie estrutura para [feature]"
2. Iterar com instruções específicas
3. Cmd+L: "Revise esse código"
4. Cmd+K: "Adicione testes"
```

**Workflow 3: Bug fix**
```
1. Reproduzir bug
2. Cmd+L: "Estou tendo esse problema: [descreva]"
3. Cmd+L: "O erro é [cole o erro]"
4. Aplicar sugestão
5. Testar
```

---

## Métricas de Sucesso

### Antes vs Depois

| Métrica | Antes (sem IA) | Depois (com IA) |
|---------|----------------|-----------------|
| Tempo para feature simples | ___ horas | ___ minutos |
| Tempo para entender código novo | ___ horas | ___ minutos |
| Erros de sintaxe por dia | ___ | ___ |
| Pesquisas no Stack Overflow | ___/dia | ___/dia |

### Como Medir

1. **Timer:** Use Toggl ou similar para trackear tempo
2. **Commits:** Compare quantidade antes/depois
3. **Bugs:** Conte erros pegos em review
4. **Satisfação:** Como você se sente programando?

---

## Compromisso 48h

**Eu, _______________, me comprometo a:**

- [ ] Usar Cursor/Antigravity como IDE principal
- [ ] Usar IA para todo código novo
- [ ] Usar IA para debug de pelo menos 3 erros
- [ ] Documentar tempo economizado
- [ ] Não voltar para IDE sem IA

**Data limite:** ___/___/___

### Diário de Uso

| Dia | Tarefa | Usei IA? | Tempo com IA | Tempo estimado sem |
|-----|--------|----------|--------------|-------------------|
| 1 | | [ ] | ___ min | ___ min |
| 1 | | [ ] | ___ min | ___ min |
| 2 | | [ ] | ___ min | ___ min |
| 2 | | [ ] | ___ min | ___ min |

---

## Reflexão Final do Módulo

| Pergunta | Resposta |
|----------|----------|
| O que mais me impressionou? | |
| Qual funcionalidade mais uso? | |
| Onde a IA ainda erra? | |
| Vou continuar usando? | Sim / Não / Parcialmente |

---

## Próximo Módulo

No **Módulo 5B**, você vai aprender **Claude Code CLI** — programar direto do terminal com IA, para automações e scripts avançados.

---

## Entregável Final do Módulo 4B

- [x] Projeto criado com IDE + IA
- [x] Backend funcionando
- [x] Frontend funcionando
- [x] Testes incluídos
- [ ] Deploy realizado
- [ ] Usado em produção por 48h

### Prova de Conclusão

**Links do projeto:**
- Backend: _______________
- Frontend: _______________
- Repositório: _______________

**Screenshot do projeto funcionando:**
```
[Descreva ou anexe]
```

**Tempo total de desenvolvimento:**
```
___ horas
```
