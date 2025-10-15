# Quando Usar IRB-Compliant Consent - InnerLens Lite

**Documento:** Guia de decisão para escolher MVP testing vs Production testing
**Versão:** 1.0
**Data:** 2025-01-15

---

## 🤔 Resumo Executivo

**Pergunta:** Quando eu preciso do formulário IRB-compliant de 50 páginas vs acordo informal por email?

**Resposta rápida:**

| Cenário | Use |
|---------|-----|
| Testando com 5-10 amigos/colegas | ✅ **MVP** (email informal) |
| Lançando app público | ❌ **IRB** (consent formal) |
| Cobrando usuários | ❌ **IRB** (consent formal) |
| Publicando paper acadêmico | ❌ **IRB** (consent formal + aprovação comitê) |
| Parceria com universidade | ❌ **IRB** (consent formal + aprovação comitê) |

---

## 📋 Decision Matrix

### Use MVP Approach (Email Informal)

✅ **SIM, se TODOS forem verdadeiros:**
- [ ] < 10 participantes
- [ ] Todos são conhecidos pessoais (amigos, família, colegas)
- [ ] Teste interno (não público)
- [ ] Sem compensação financeira (ou simbólica <$10)
- [ ] Sem publicação acadêmica planejada
- [ ] Sem comercialização planejada
- [ ] Dados não-sensíveis (apenas personality, não saúde mental)
- [ ] Você tem relação de confiança com participantes

**Localização docs:** `testing/MVP-TESTING-GUIDE.md`

**Exemplo:**
> "Estou testando meu MVP com 7 amigos da faculdade. Vou pedir por WhatsApp, eles confiam em mim, não vou publicar nem vender nada. Só quero validar que funciona."

---

### Use IRB-Compliant Approach (Formal Consent)

❌ **SIM, se QUALQUER UM for verdadeiro:**
- [ ] ≥ 10 participantes
- [ ] Recrutamento público (Reddit, Discord, ads, mailing list)
- [ ] App/website público (qualquer pessoa pode usar)
- [ ] Cobrança de usuários (free trial, freemium, pago)
- [ ] Publicação acadêmica (conference, journal, arXiv)
- [ ] Parceria institucional (universidade, empresa, ONG)
- [ ] Compensação significativa (>$10 por participante)
- [ ] Dados sensíveis (saúde mental, crianças, populações vulneráveis)
- [ ] Comercialização futura (mesmo que gratuito agora)
- [ ] Conformidade legal obrigatória (GDPR, LGPD, HIPAA)

**Localização docs:** `testing/future-production/informed-consent-form-PRODUCTION-ONLY.md`

**Exemplo:**
> "Vou lançar o InnerLens Lite no Product Hunt e deixar qualquer pessoa testar. Preciso de consent formal para proteger legalmente e respeitar privacidade de desconhecidos."

---

## 🚦 Casos Comuns

### Caso 1: MVP com Amigos (5-10 pessoas)

**Situação:**
- Quero testar com 7 amigos da universidade
- Vou pedir por WhatsApp
- Eles me conhecem e confiam
- Não vou publicar nem vender

**Decisão:** ✅ **MVP Approach (Email Informal)**

**Por quê:**
- Relação de confiança existente
- Sample size pequeno (<10)
- Sem fins comerciais/acadêmicos
- Baixo risco

**Documento a usar:** `testing/MVP-TESTING-GUIDE.md`

**Email:**
```
Oi João, tá topando testar meu app de análise de personalidade?
Leva 20 min, tu recebe relatório grátis. Me avisa!
```

---

### Caso 2: Post no Reddit (público desconhecido)

**Situação:**
- Quero postar em r/psychology pedindo voluntários
- Não conheço os participantes
- Posso ter 20-50 respostas
- Sem fins comerciais (por enquanto)

**Decisão:** ❌ **IRB-Compliant Approach**

**Por quê:**
- Recrutamento público
- Participantes desconhecidos
- Sample size grande (>10)
- Pode virar publicação acadêmica no futuro

**Documento a usar:** `testing/future-production/informed-consent-form-PRODUCTION-ONLY.md`

**Por quê precisa de IRB:**
1. **Proteção legal:** Desconhecidos podem processar ("não autorizei análise de personalidade")
2. **Ética profissional:** Padrão esperado para recrutamento público
3. **Credibilidade:** Demonstra seriedade e respeito

---

### Caso 3: App Público (mesmo gratuito)

**Situação:**
- Lancei InnerLens Lite como web app
- Qualquer pessoa pode criar conta e usar
- Gratuito (por enquanto)
- Apenas Big Five (não saúde mental)

**Decisão:** ❌ **IRB-Compliant Approach**

**Por quê:**
- Usuários desconhecidos
- Escala potencialmente grande (>10)
- Dados de personalidade são sensíveis (GDPR: "dados pessoais")
- Risco legal se não houver consent claro

**Documento a usar:** `testing/future-production/informed-consent-form-PRODUCTION-ONLY.md`

**Implementação:**
- Página "Terms of Service" com seções do consent
- Checkbox obrigatório antes de análise: "I consent to personality analysis"
- Download do relatório: "Read our Privacy Policy and Consent Form"

---

### Caso 4: Publicação Acadêmica

**Situação:**
- Quero publicar paper em CHI/NeurIPS
- Preciso validar com N=20-50
- Vou recrutar em universidade

**Decisão:** ❌ **IRB-Compliant + Aprovação de Comitê**

**Por quê:**
- Publicação acadêmica **exige** aprovação de IRB/CEP
- Reviewers vão checar "Ethics Statement"
- Rejeição automática se não tiver IRB approval number

**Documentos a usar:**
1. `testing/future-production/informed-consent-form-PRODUCTION-ONLY.md`
2. Submeter ao IRB/CEP da sua instituição (universidade)
3. Aguardar aprovação (2-8 semanas)
4. Incluir no paper: "This study was approved by [Institution] IRB (Protocol #XXXX)"

---

### Caso 5: Parceria com Empresa

**Situação:**
- Empresa X quer usar InnerLens para screening de candidatos
- Vou coletar dados de 100+ pessoas
- Há compensação financeira (contrato)

**Decisão:** ❌ **IRB-Compliant + Revisão Jurídica**

**Por quê:**
- Uso comercial (mesmo que você não cobre, a empresa usa para lucro)
- Dados de employment são sensíveis (discriminação potencial)
- Responsabilidade legal alta
- Conformidade com leis trabalhistas

**Documentos a usar:**
1. `testing/future-production/informed-consent-form-PRODUCTION-ONLY.md`
2. Revisão por advogado (employment law)
3. Adicionar disclaimers específicos:
   - "Not for hiring decisions alone"
   - "Scores are informational, not diagnostic"
   - "Comply with EEOC/labor laws"

---

## 📊 Flowchart de Decisão

```
Início
  │
  ├─> Vou publicar academicamente?
  │     ├─> SIM → IRB-Compliant + Aprovação Comitê
  │     └─> NÃO ↓
  │
  ├─> Vou cobrar usuários (agora ou futuro)?
  │     ├─> SIM → IRB-Compliant
  │     └─> NÃO ↓
  │
  ├─> Vou recrutar >10 pessoas desconhecidas?
  │     ├─> SIM → IRB-Compliant
  │     └─> NÃO ↓
  │
  ├─> É app/website público?
  │     ├─> SIM → IRB-Compliant
  │     └─> NÃO ↓
  │
  ├─> Há parceria institucional?
  │     ├─> SIM → IRB-Compliant
  │     └─> NÃO ↓
  │
  └─> MVP Approach (Email Informal) ✅
```

---

## 🌍 Conformidade Legal por Região

### Estados Unidos

**Quando IRB é obrigatório:**
- Pesquisa financiada por federal government (NIH, NSF)
- Pesquisa em universidade (todas têm IRB)
- Ensaios clínicos (FDA-regulated)

**Quando IRB é fortemente recomendado:**
- App/produto comercial (proteção legal)
- Recrutamento público (>10 pessoas)
- Publicação acadêmica (exigência de journals)

**Lei relevante:** Common Rule (45 CFR 46)

---

### Brasil

**Quando CEP (Comitê de Ética em Pesquisa) é obrigatório:**
- Pesquisa em universidade pública/privada
- Pesquisa em hospital/clínica
- Pesquisa com financiamento público (CNPq, FAPESP)

**Quando LGPD se aplica:**
- Qualquer coleta de "dados pessoais" (inclui personality)
- App/website com usuários brasileiros
- Empresa brasileira ou que atua no Brasil

**Leis relevantes:**
- Resolução CNS 466/2012 (ética em pesquisa)
- Resolução CNS 510/2016 (ciências humanas e sociais)
- LGPD - Lei 13.709/2018 (proteção de dados)

**Plataforma:** Sistema CEP/CONEP (Plataforma Brasil)

---

### União Europeia

**Quando aprovação ética é obrigatória:**
- Pesquisa em instituição européia
- Pesquisa com financiamento Horizon Europe
- Dados sensíveis (saúde, biométricos, genéticos)

**Quando GDPR se aplica:**
- Qualquer coleta de dados de cidadãos europeus
- Empresa que opera na UE
- Processing de "personal data" (inclui personality)

**Lei relevante:** GDPR (General Data Protection Regulation)

**Bases legais para processing:**
1. **Consent** (mais comum) - precisa ser:
   - Freely given (voluntário)
   - Specific (para propósito específico)
   - Informed (participante entende tudo)
   - Unambiguous (claro, não implícito)
2. Legitimate interest (mais raro)
3. Contract (se for parte de serviço contratado)

---

## ✅ Checklist: Preciso de IRB?

**Marque SIM ou NÃO:**

- [ ] **SIM/NÃO** - Vou publicar em journal/conference acadêmica?
- [ ] **SIM/NÃO** - Vou recrutar >10 pessoas que não conheço pessoalmente?
- [ ] **SIM/NÃO** - Vou lançar app/website público?
- [ ] **SIM/NÃO** - Vou cobrar usuários (agora ou no futuro)?
- [ ] **SIM/NÃO** - Há parceria com universidade, empresa ou ONG?
- [ ] **SIM/NÃO** - Dados são sensíveis (saúde mental, crianças, vulneráveis)?
- [ ] **SIM/NÃO** - Vou oferecer compensação >$10 por participante?
- [ ] **SIM/NÃO** - Há financiamento externo (grant, investidor)?
- [ ] **SIM/NÃO** - Usuários são de países com GDPR/LGPD?
- [ ] **SIM/NÃO** - Poderia haver risco legal se algo der errado?

**Resultado:**
- **Todas NÃO:** ✅ MVP Approach OK
- **1-2 SIM:** ⚠️ Considere IRB-Compliant (proteção recomendada)
- **3+ SIM:** ❌ IRB-Compliant obrigatório

---

## 📝 Documentos a Usar

### Para MVP Approach

**Arquivo:** `testing/MVP-TESTING-GUIDE.md`

**Contém:**
- Mensagem de recrutamento simplificada (WhatsApp/Email)
- Email de confirmação informal (substitui consent)
- Procedimento de coleta
- Análise rápida (5-10 pessoas)
- Timeline: 3-5 dias
- Custo: $2-4

**Quando usar:** Testing interno, amigos/colegas, <10 pessoas, sem fins comerciais/acadêmicos

---

### Para IRB-Compliant Approach

**Arquivo:** `testing/future-production/informed-consent-form-PRODUCTION-ONLY.md`

**Contém:**
- Formulário de consentimento informado (50+ páginas)
- 11 seções obrigatórias (propósito, procedimentos, riscos, benefícios, privacidade, etc.)
- Conformidade com IRB/CEP/GDPR/LGPD
- Assinatura física ou digital
- Direitos do participante (acesso, correção, exclusão, portabilidade)

**Quando usar:** Lançamento público, comercialização, publicação acadêmica, >10 pessoas desconhecidas

**Adicional para pesquisa acadêmica:**
- Submeter ao IRB/CEP da sua instituição
- Aguardar aprovação (2-8 semanas)
- Incluir approval number no consent form

---

## 🎓 Exemplo de Transição: MVP → Produção

### Fase 1: MVP (Semana 1)

**Objetivo:** Validar que sistema funciona
**Método:** MVP Approach
**Participantes:** 7 amigos da faculdade
**Consent:** Email informal

**Resultado:** r=0.72 accuracy, sistema funciona!

---

### Fase 2: Produção Beta (Semana 4-6)

**Objetivo:** Validar com amostra maior antes de lançar
**Método:** IRB-Compliant Approach
**Participantes:** 20 voluntários do Reddit
**Consent:** Formulário IRB-compliant

**Passos:**
1. Adaptar `informed-consent-form-PRODUCTION-ONLY.md`
2. Criar Google Form com consent embedded
3. Postar no Reddit com link para Form
4. Aguardar respostas (1-2 semanas)
5. Rodar análise completa (TESTING-PLAN-EPIC-0.md - 60 páginas)
6. Gerar relatório formal

**Resultado:** r=0.78 accuracy, validado para lançamento!

---

### Fase 3: Lançamento Público (Semana 8)

**Objetivo:** Usuários reais usando app
**Método:** IRB-Compliant embedded no app
**Participantes:** Público geral
**Consent:** Terms of Service + Privacy Policy + Consent checkbox

**Implementação:**
```html
<!-- Página de análise -->
<form>
  <input type="checkbox" required>
  I have read and agree to the
  <a href="/consent">Informed Consent Form</a>,
  <a href="/privacy">Privacy Policy</a>, and
  <a href="/terms">Terms of Service</a>.

  <button>Analyze My Personality</button>
</form>
```

**Consent Form:** Versão web do `informed-consent-form-PRODUCTION-ONLY.md`

---

## 🚨 Riscos de Não Usar IRB Quando Deveria

### Cenário: Lancei app público sem consent formal

**Riscos legais:**
1. **GDPR/LGPD fines:**
   - GDPR: Até €20 milhões ou 4% do faturamento global
   - LGPD: Até R$ 50 milhões ou 2% do faturamento
2. **Processos individuais:**
   - Usuário alega: "Não autorizei análise de minha personalidade"
   - Custos legais: $10k-$100k mesmo que você ganhe
3. **Danos à reputação:**
   - "InnerLens viola privacidade dos usuários"
   - Perda de confiança, usuários abandonam

**Riscos acadêmicos:**
- Paper rejeitado por falta de ethics approval
- Impossível publicar resultados

**Riscos comerciais:**
- Parceiros corporativos exigem compliance (não tem? Perde contrato)
- Investidores assustados com liability

---

### Cenário: Usei MVP approach corretamente (amigos)

**Resultado:**
- ✅ Zero riscos legais (relação de confiança)
- ✅ Validação rápida (3-5 dias)
- ✅ Feedback honesto (amigos são sinceros)
- ✅ Iteração rápida
- ✅ Custo baixo ($2-4)

**Quando transicionar:**
- Assim que considerar lançar publicamente → Usar IRB
- Assim que recrutar desconhecidos → Usar IRB
- Assim que >10 participantes → Usar IRB

---

## 📚 Recursos Adicionais

**Para MVP:**
- `testing/MVP-TESTING-GUIDE.md` - Guia completo simplificado

**Para Produção:**
- `testing/future-production/informed-consent-form-PRODUCTION-ONLY.md` - Formulário IRB-compliant
- `testing/TESTING-PLAN-EPIC-0.md` - Metodologia completa (60 páginas)

**Para Aprovar em IRB/CEP:**
- Plataforma Brasil: https://plataformabrasil.saude.gov.br/ (Brasil)
- IRB da sua universidade (EUA/Europa)

**Para GDPR/LGPD:**
- GDPR full text: https://gdpr.eu/
- LGPD full text: http://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm

---

## ✅ TL;DR - Decisão em 30 Segundos

**Use MVP (Email Informal) SE:**
- < 10 amigos/colegas
- Testing interno
- Sem comercialização/publicação

**Use IRB (Consent Formal) SE:**
- Lançamento público
- >10 desconhecidos
- Cobrança de usuários
- Publicação acadêmica
- Parceria institucional

**Quando em dúvida:** Use IRB-Compliant (mais seguro, zero downside)

---

**Documento Version:** 1.0
**Status:** ✅ Ready for Reference
**Last Updated:** 2025-01-15

**Próximo passo:** Escolha sua abordagem e comece o testing!

© 2025 Academia Lendar[IA] - InnerLens Lite Testing Documentation
