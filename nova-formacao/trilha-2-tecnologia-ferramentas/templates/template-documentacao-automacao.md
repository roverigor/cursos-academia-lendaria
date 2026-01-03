# Template: Documentação de Automação

## Módulo 2 - Automação com n8n

---

## Informações da Automação

| Campo | Valor |
|-------|-------|
| **Nome** | |
| **Versão** | 1.0 |
| **Data criação** | |
| **Autor** | |
| **Status** | [ ] Desenvolvimento [ ] Teste [ ] Produção |

---

## Resumo

**O que faz:**
[Descreva em 2-3 frases o propósito da automação]

**Problema que resolve:**
[Qual problema de negócio essa automação resolve?]

**Resultado esperado:**
[O que acontece quando a automação funciona corretamente?]

---

## Diagrama do Fluxo

```
[Trigger] → [Ação 1] → [Ação 2] → [Resultado]
              ↓
          [Condição]
          ↙       ↘
      [Sim]       [Não]
```

---

## Detalhamento

### Trigger

| Campo | Valor |
|-------|-------|
| **Tipo** | Webhook / Schedule / App Event |
| **Node** | |
| **Configuração** | |

**Detalhes:**
```
[Configurações específicas do trigger]
```

### Nodes

| # | Node | Função | Configuração |
|---|------|--------|--------------|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |

### Condições (se houver)

| Condição | Se TRUE | Se FALSE |
|----------|---------|----------|
| | | |

---

## Integrações

### Sistemas Conectados

| Sistema | Função | Credencial |
|---------|--------|------------|
| | | [Nome da credencial no n8n] |
| | | |

### APIs Utilizadas

| API | Endpoint | Método |
|-----|----------|--------|
| | | GET/POST/PUT/DELETE |
| | | |

---

## Dados

### Entrada

```json
{
  "exemplo": "estrutura dos dados de entrada"
}
```

### Saída

```json
{
  "exemplo": "estrutura dos dados de saída"
}
```

### Transformações

| Campo Original | Transformação | Campo Final |
|----------------|---------------|-------------|
| | | |

---

## Tratamento de Erros

### Erros Conhecidos

| Erro | Causa | Solução |
|------|-------|---------|
| | | |
| | | |

### Configurações de Retry

| Node | Retry on Fail | Max Tries | Wait Between |
|------|---------------|-----------|--------------|
| | Sim/Não | | ms |

### Workflow de Erro

- [ ] Configurado Error Workflow
- Nome: _______________
- Notifica: _______________

---

## Monitoramento

### Métricas

| Métrica | Como medir | Meta |
|---------|------------|------|
| Execuções/dia | n8n dashboard | |
| Taxa de sucesso | n8n dashboard | >95% |
| Tempo médio execução | n8n dashboard | <5s |

### Alertas

| Condição | Ação | Destino |
|----------|------|---------|
| Falha na execução | Email/Slack | |
| >10 erros/hora | | |

---

## Testes

### Cenários de Teste

| # | Cenário | Dados de Teste | Resultado Esperado | Status |
|---|---------|----------------|-------------------|--------|
| 1 | Sucesso normal | | | [ ] OK |
| 2 | Dados inválidos | | | [ ] OK |
| 3 | API indisponível | | | [ ] OK |
| 4 | Timeout | | | [ ] OK |

### Comandos de Teste

```bash
# Teste via curl (se webhook)
curl -X POST [URL] \
  -H "Content-Type: application/json" \
  -d '[DADOS]'
```

---

## Deploy

### Checklist Pré-Deploy

- [ ] Testado em ambiente de desenvolvimento
- [ ] Credenciais de produção configuradas
- [ ] Error workflow configurado
- [ ] Alertas configurados
- [ ] Documentação atualizada

### Histórico de Versões

| Versão | Data | Mudanças | Autor |
|--------|------|----------|-------|
| 1.0 | | Versão inicial | |
| | | | |

---

## Manutenção

### Dependências

| Dependência | Versão | Última Atualização |
|-------------|--------|-------------------|
| n8n | | |
| | | |

### Responsáveis

| Papel | Nome | Contato |
|-------|------|---------|
| Owner | | |
| Backup | | |

### Próxima Revisão

**Data:** ___/___/___

---

## Anexos

- [ ] Print do workflow
- [ ] Export JSON do workflow
- [ ] Credenciais (em local seguro)

---

*Template Trilha 02 - Ferramentas e Tecnologia*
