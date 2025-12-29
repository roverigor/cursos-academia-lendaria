# 🚀 CHECKLIST DE ATIVAÇÃO M.A.P.A.™

**Projeto:** [NOME DO PROJETO]
**Versão:** [X.Y.Z]
**Data Deploy:** [DATA]
**Responsável:** [NOME]
**Ambiente:** [ ] Development [ ] Staging [ ] Production

---

## ⚡ PRÉ-FLIGHT CHECK (5 minutos)

### Básico - Sem isso nem começa
- [ ] **Código na branch correta** (main/master/production)
- [ ] **Todos os testes passando** (unit, integration, e2e)
- [ ] **Build funcionando** sem warnings críticos
- [ ] **Variáveis de ambiente** configuradas para produção
- [ ] **Backup do banco** realizado (se aplicável)

**🔴 STOP! Se algum falhar, NÃO prossiga**

---

## 1️⃣ CÓDIGO E QUALIDADE

### Versionamento
- [ ] Tag de versão criada (vX.Y.Z)
- [ ] CHANGELOG atualizado com mudanças
- [ ] Commits com mensagens descritivas
- [ ] Branch de produção atualizada
- [ ] PR aprovado (se aplicável)

### Qualidade de Código
- [ ] Linting passando 100%
- [ ] Sem console.logs de debug
- [ ] Sem código comentado
- [ ] Sem TODOs críticos
- [ ] Coverage de testes >= 70%

### Segurança
- [ ] Sem secrets/credenciais no código
- [ ] Dependências atualizadas (npm audit)
- [ ] CORS configurado corretamente
- [ ] Rate limiting implementado
- [ ] Input validation ativa

---

## 2️⃣ INFRAESTRUTURA

### Servidor/Hosting
- [ ] Servidor com recursos adequados (CPU, RAM, Disk)
- [ ] Sistema operacional atualizado
- [ ] Firewall configurado
- [ ] SSH com key-based auth apenas
- [ ] Fail2ban ou similar ativo

### Banco de Dados
- [ ] Migrations executadas com sucesso
- [ ] Índices criados para queries principais
- [ ] Backup automático configurado
- [ ] Replicação configurada (se aplicável)
- [ ] Connection pooling otimizado

### Domínio e SSL
- [ ] Domínio apontando corretamente
- [ ] SSL certificado válido (Let's Encrypt ou similar)
- [ ] Redirect HTTP → HTTPS ativo
- [ ] www → non-www (ou vice-versa) configurado
- [ ] DNS com TTL apropriado

---

## 3️⃣ APLICAÇÃO

### Backend
- [ ] API respondendo no healthcheck
- [ ] Todas rotas testadas manualmente
- [ ] Autenticação funcionando
- [ ] Rate limiting ativo
- [ ] Logs estruturados configurados

### Frontend
- [ ] Build de produção otimizado
- [ ] Assets minificados
- [ ] Imagens otimizadas
- [ ] Lazy loading implementado
- [ ] SEO meta tags configuradas

### Integrações
- [ ] APIs externas com keys de produção
- [ ] Webhooks testados e funcionando
- [ ] Email service configurado (SendGrid, SES, etc)
- [ ] Payment gateway em modo produção (se aplicável)
- [ ] Analytics instalado (GA, Plausible, etc)

---

## 4️⃣ PERFORMANCE

### Métricas Web
- [ ] Lighthouse score > 85
- [ ] Time to First Byte < 600ms
- [ ] First Contentful Paint < 2s
- [ ] Largest Contentful Paint < 3s
- [ ] Bundle size < 500KB (gzipped)

### Backend Performance
- [ ] Response time p95 < 500ms
- [ ] Database queries otimizadas
- [ ] Caching implementado (Redis, etc)
- [ ] CDN configurado para assets
- [ ] Gzip/Brotli compression ativa

### Load Testing
```bash
# Teste básico com curl
for i in {1..100}; do
  curl -o /dev/null -s -w "%{time_total}\n" https://seu-site.com &
done
wait
```
- [ ] Suporta carga esperada
- [ ] Sem memory leaks sob carga
- [ ] Graceful degradation implementado

---

## 5️⃣ MONITORAMENTO

### Logs e Observabilidade
- [ ] Logs centralizados (CloudWatch, Papertrail, etc)
- [ ] Error tracking (Sentry, Rollbar)
- [ ] APM configurado (New Relic, DataDog)
- [ ] Custom metrics definidas
- [ ] Alertas configurados

### Uptime Monitoring
- [ ] Uptime monitor ativo (UptimeRobot, Pingdom)
- [ ] Healthcheck endpoint funcionando
- [ ] Alertas para downtime configurados
- [ ] Status page configurada (opcional)
- [ ] SLA definido e comunicado

### Analytics
- [ ] Google Analytics ou alternativa
- [ ] Eventos customizados trackados
- [ ] Conversion tracking configurado
- [ ] Heatmaps instalados (Hotjar, etc)
- [ ] User session recording (se aplicável)

---

## 6️⃣ SEGURANÇA E COMPLIANCE

### Segurança Básica
- [ ] Headers de segurança (CSP, X-Frame-Options, etc)
- [ ] HTTPS apenas (HSTS ativo)
- [ ] Cookies seguros (Secure, HttpOnly, SameSite)
- [ ] Secrets em variáveis de ambiente
- [ ] Princípio do menor privilégio aplicado

### Compliance
- [ ] LGPD/GDPR compliance (se aplicável)
- [ ] Política de Privacidade atualizada
- [ ] Termos de Uso atualizados
- [ ] Cookie consent implementado
- [ ] Data retention policy definida

### Backup e Recovery
- [ ] Backup automático diário
- [ ] Backup testado (restore funciona)
- [ ] Backup offsite configurado
- [ ] RTO/RPO definidos
- [ ] Disaster recovery plan documentado

---

## 7️⃣ DOCUMENTAÇÃO

### Técnica
- [ ] README de produção atualizado
- [ ] Runbook de operações criado
- [ ] Troubleshooting guide documentado
- [ ] API documentation atualizada
- [ ] Architecture diagram atual

### Usuário
- [ ] FAQ atualizado
- [ ] Help/documentação disponível
- [ ] Vídeos tutoriais (se aplicável)
- [ ] Changelog público
- [ ] Known issues documentados

### Time
- [ ] Handoff document criado
- [ ] Credenciais no password manager
- [ ] Contatos de emergência listados
- [ ] Escalation process definido
- [ ] On-call rotation (se aplicável)

---

## 8️⃣ COMUNICAÇÃO

### Interna
- [ ] Time notificado do deploy
- [ ] Stakeholders informados
- [ ] Demo agendada (se aplicável)
- [ ] Retrospectiva marcada
- [ ] Documentação no Notion/Wiki

### Externa
- [ ] Changelog público atualizado
- [ ] Email para usuários (se breaking changes)
- [ ] Social media posts preparados
- [ ] Blog post (se major release)
- [ ] Press release (se aplicável)

---

## 9️⃣ ROLLBACK PLAN

### Preparação
- [ ] Versão anterior disponível
- [ ] Scripts de rollback testados
- [ ] Backup do banco pré-deploy
- [ ] Time de standby alertado
- [ ] Critérios de rollback definidos

### Triggers de Rollback
- 🔴 Error rate > 5%
- 🔴 Response time > 2x normal
- 🔴 Funcionalidade crítica quebrada
- 🔴 Data corruption detectada
- 🔴 Security breach identificado

### Procedimento
```bash
# Comandos de rollback - CUSTOMIZE
git checkout v[PREVIOUS_VERSION]
npm run build
pm2 restart app
# ou
kubectl rollout undo deployment/app
```

---

## 🎯 DEPLOYMENT CHECKLIST

### Sequência de Deploy

1. **[-30min] Preparação**
   - [ ] Notificar time
   - [ ] Verificar métricas atuais
   - [ ] Backup final

2. **[0min] Início do Deploy**
   - [ ] Maintenance mode ON (se aplicável)
   - [ ] Stop application servers
   - [ ] Deploy novo código

3. **[+15min] Ativação**
   - [ ] Start application servers
   - [ ] Run smoke tests
   - [ ] Maintenance mode OFF

4. **[+30min] Validação**
   - [ ] Verificar logs por erros
   - [ ] Testar funcionalidades críticas
   - [ ] Monitorar métricas

5. **[+60min] Estabilização**
   - [ ] Confirmar estabilidade
   - [ ] Notificar sucesso
   - [ ] Documentar issues

---

## ✅ CRITÉRIOS DE SUCESSO

### Imediato (Primeiros 30 min)
- [ ] Zero erros críticos nos logs
- [ ] Todas funcionalidades core operacionais
- [ ] Performance dentro do esperado
- [ ] Nenhum rollback necessário

### Curto Prazo (Primeiras 24h)
- [ ] Error rate < 0.1%
- [ ] Uptime > 99.9%
- [ ] Sem reclamações críticas de usuários
- [ ] Métricas de negócio normais

### Médio Prazo (Primeira semana)
- [ ] SLA mantido
- [ ] Adoption rate conforme esperado
- [ ] Feedback positivo > negativo
- [ ] ROI mensurável (se aplicável)

---

## 📊 SCORE FINAL DE PRONTIDÃO

| Categoria | Itens | Completos | % |
|-----------|-------|-----------|---|
| Pré-flight | 5 | ___ | ___% |
| Código | 15 | ___ | ___% |
| Infraestrutura | 15 | ___ | ___% |
| Aplicação | 15 | ___ | ___% |
| Performance | 10 | ___ | ___% |
| Monitoramento | 10 | ___ | ___% |
| Segurança | 10 | ___ | ___% |
| Documentação | 10 | ___ | ___% |
| Comunicação | 10 | ___ | ___% |
| **TOTAL** | **100** | **___** | **___%** |

### Go/No-Go Decision
- ✅ **GO:** Score >= 90%
- ⚠️ **GO WITH RISK:** Score 80-89%
- ❌ **NO-GO:** Score < 80%

**DECISÃO FINAL:** [GO | GO WITH RISK | NO-GO]

---

## 🚨 CONTATOS DE EMERGÊNCIA

| Papel | Nome | Contato | Disponibilidade |
|-------|------|---------|-----------------|
| Tech Lead | | | |
| DevOps | | | |
| DBA | | | |
| Security | | | |
| Business Owner | | | |

---

## 📝 NOTAS DO DEPLOY

### Issues Encontradas
```
[Documente problemas e soluções durante deploy]
```

### Lições Aprendidas
```
[O que melhorar para próximo deploy]
```

### Métricas Pós-Deploy
```
Tempo total de deploy: _____ minutos
Downtime (se houver): _____ minutos
Rollbacks necessários: _____
Issues críticas: _____
```

---

## APROVAÇÕES

### Sign-offs Necessários

- [ ] **Tech Lead:** _________________ Data: _____
- [ ] **Product Owner:** _________________ Data: _____
- [ ] **Security:** _________________ Data: _____
- [ ] **DevOps:** _________________ Data: _____
- [ ] **Business:** _________________ Data: _____

### Deploy Executado

**Executado por:** _________________
**Data/Hora Início:** _________________
**Data/Hora Fim:** _________________
**Status Final:** [ ] Sucesso [ ] Sucesso Parcial [ ] Rollback

---

*Checklist de Ativação M.A.P.A.™ v2.0*
*"Deploy sem checklist é roleta russa com 5 balas no tambor."*