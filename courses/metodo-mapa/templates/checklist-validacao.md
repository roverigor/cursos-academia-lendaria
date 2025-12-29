# ✅ CHECKLIST DE VALIDAÇÃO M.A.P.A.™

**Projeto:** [NOME DO PROJETO]
**Entrega:** [X.X - NOME]
**Data Validação:** [DATA]
**Validador:** [IA ou Humano]

---

## 🎯 VALIDAÇÃO RÁPIDA (2 minutos)

### Smoke Test - Funciona?
- [ ] **Código executa sem erros?** (npm start, python run, etc)
- [ ] **Feature principal funciona?** (teste manual básico)
- [ ] **Sem erros no console?** (browser e terminal)

**🔴 Se qualquer um falhar = REPROVAR e corrigir primeiro**

---

## 📋 VALIDAÇÃO FUNCIONAL (10 minutos)

### Requisitos Atendidos
- [ ] Todos os requisitos do briefing foram implementados
- [ ] Funcionalidade testada com casos normais
- [ ] Edge cases básicos tratados (campos vazios, valores extremos)
- [ ] Mensagens de erro apropriadas

### Testes de Integração
- [ ] Integra corretamente com código existente
- [ ] APIs retornam status codes corretos (200, 201, 400, 404, 500)
- [ ] Dados persistem corretamente no banco
- [ ] Frontend consome backend sem problemas (se aplicável)

### Comportamento Esperado
```bash
# Comandos de teste - CUSTOMIZE para seu projeto
curl -X GET http://localhost:3000/api/health  # Deve retornar 200 OK
npm test -- --coverage                         # Deve passar todos os testes
```

**Score Funcional: ___/100**

---

## 🔍 VALIDAÇÃO DE QUALIDADE (10 minutos)

### Código
- [ ] **Legibilidade:** Código é compreensível sem comentários excessivos
- [ ] **Nomenclatura:** Variáveis e funções com nomes descritivos
- [ ] **DRY:** Sem duplicação óbvia de código
- [ ] **Modularidade:** Funções pequenas e focadas (<50 linhas)
- [ ] **Comentários:** Presentes onde necessário, ausentes onde óbvio

### Padrões e Convenções
- [ ] Segue style guide definido no projeto
- [ ] Indentação consistente
- [ ] Sem código comentado ou console.logs de debug
- [ ] Imports organizados e sem unused
- [ ] Naming conventions respeitadas (camelCase, PascalCase, etc)

### Segurança Básica
- [ ] Sem credenciais hardcoded
- [ ] Inputs sanitizados (prevenção SQL injection, XSS)
- [ ] Variáveis de ambiente usadas para configs sensíveis
- [ ] Sem exposição de stack traces em produção
- [ ] Rate limiting implementado (se aplicável)

**Score Qualidade: ___/100**

---

## ⚡ VALIDAÇÃO DE PERFORMANCE (5 minutos)

### Métricas
- [ ] **Response time:** < 200ms para operações simples
- [ ] **Response time:** < 2s para operações complexas
- [ ] **Memory usage:** Sem memory leaks óbvios
- [ ] **CPU usage:** Sem loops infinitos ou processamento desnecessário
- [ ] **Database queries:** Sem N+1 problems

### Testes de Carga (se aplicável)
```bash
# Exemplo com curl em loop
for i in {1..100}; do
  time curl -X GET http://localhost:3000/api/resource &
done
wait
```

- [ ] Suporta carga esperada sem degradação
- [ ] Graceful degradation sob alta carga
- [ ] Erro handling apropriado quando sobrecarregado

**Score Performance: ___/100**

---

## 📚 VALIDAÇÃO DE DOCUMENTAÇÃO (5 minutos)

### Código
- [ ] Funções complexas documentadas
- [ ] APIs com exemplos de request/response
- [ ] TODOs marcados claramente
- [ ] FIXME com explicação

### Projeto
- [ ] README atualizado (se necessário)
- [ ] CHANGELOG com mudanças desta entrega
- [ ] .env.example atualizado com novas variáveis
- [ ] Documentação de APIs atualizada (Swagger/Postman)

### Instruções
- [ ] Como testar as novas features
- [ ] Dependências novas documentadas
- [ ] Breaking changes destacadas (se houver)

**Score Documentação: ___/100**

---

## 🧪 VALIDAÇÃO DE TESTES (5 minutos)

### Coverage
- [ ] Testes unitários para lógica crítica
- [ ] Coverage >= 70% para código novo
- [ ] Testes de integração para APIs
- [ ] Testes E2E para fluxos principais (se aplicável)

### Qualidade dos Testes
- [ ] Testes são compreensíveis
- [ ] Testam comportamento, não implementação
- [ ] Incluem casos de sucesso e falha
- [ ] Rodam rapidamente (< 30s total)

```bash
# Rodar testes
npm test
# ou
pytest
# ou
go test ./...

# Ver coverage
npm test -- --coverage
```

**Score Testes: ___/100**

---

## ⚠️ PROBLEMAS ENCONTRADOS

### Críticos (Bloqueiam aprovação)
1. ❌ [Descreva problema crítico]
2. ❌ [Descreva problema crítico]

### Importantes (Devem ser corrigidos em breve)
1. ⚠️ [Descreva problema importante]
2. ⚠️ [Descreva problema importante]

### Menores (Nice to fix)
1. 💡 [Sugestão de melhoria]
2. 💡 [Sugestão de melhoria]

---

## 📊 SCORE FINAL

| Categoria | Peso | Score | Ponderado |
|-----------|------|-------|-----------|
| Funcional | 40% | __/100 | __ |
| Qualidade | 25% | __/100 | __ |
| Performance | 15% | __/100 | __ |
| Documentação | 10% | __/100 | __ |
| Testes | 10% | __/100 | __ |
| **TOTAL** | 100% | | **__/100** |

### Critérios de Aprovação
- ✅ **APROVADO:** Score >= 80
- ⚠️ **APROVADO COM RESSALVAS:** Score 65-79
- ❌ **REPROVADO:** Score < 65

**RESULTADO FINAL:** [APROVADO | APROVADO COM RESSALVAS | REPROVADO]

---

## 📝 FEEDBACK PARA IA/DESENVOLVEDOR

### O que foi bem feito
- ✅ [Ponto positivo]
- ✅ [Ponto positivo]
- ✅ [Ponto positivo]

### O que precisa melhorar
- ⚠️ [Ponto de melhoria]
- ⚠️ [Ponto de melhoria]

### Sugestões para próxima entrega
- 💡 [Sugestão]
- 💡 [Sugestão]

---

## 🔄 AÇÕES DE FOLLOW-UP

### Correções Imediatas (se reprovado)
- [ ] [Ação específica]
- [ ] [Ação específica]
- [ ] [Prazo: ___]

### Melhorias Futuras
- [ ] [Melhoria planejada]
- [ ] [Melhoria planejada]

### Próxima Entrega
- **Número:** [X.X]
- **Nome:** [Nome da próxima entrega]
- **Dependências desta entrega:** [Liste o que será usado]

---

## ASSINATURAS

**Validado por:** _________________
**Tipo:** [ ] IA Automática [ ] Humana [ ] Híbrida
**Data/Hora:** _________________
**Tempo de validação:** ___ minutos

---

## ANEXOS

### Logs de Teste
```
[Cole aqui outputs relevantes dos testes]
```

### Screenshots (se aplicável)
```
[Links ou descrições de evidências visuais]
```

### Métricas de Performance
```
[Dados específicos de performance]
```

---

*Checklist de Validação M.A.P.A.™ v2.0*
*"Medir é saber. Validar é garantir."*