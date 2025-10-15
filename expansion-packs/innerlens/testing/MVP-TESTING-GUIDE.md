# MVP Testing Guide - InnerLens Lite (Simplified)

**Version:** 1.0-MVP
**Purpose:** Quick validation with 5-10 friends/colleagues (informal, no IRB)
**Timeline:** 3-5 days
**Cost:** ~$2-4 total (10 analyses × $0.20)

---

## ⚡ Quick Summary

**MVP Approach = Super Simples:**
- Testar com 5-10 pessoas próximas (amigos, família, colegas)
- Acordo informal por email/WhatsApp (sem formulário IRB)
- Foco: Validar que o sistema funciona basicamente bem
- Target: 70%+ accuracy (não 75%+ - MVP menos rigoroso)

**IRB-Compliant Consent = Movido para Produção:**
- Localizado em: `testing/future-production/`
- Usar quando: Lançar publicamente, comercializar, publicar academicamente
- **NÃO NECESSÁRIO AGORA**

---

## 🎯 Objetivo do MVP Testing

**O que queremos validar:**
1. ✅ Sistema roda end-to-end sem erros
2. ✅ Accuracy razoável (70%+ correlation - target relaxado)
3. ✅ Performance aceitável (<3 min - target relaxado)
4. ✅ Outputs fazem sentido (não são nonsense)
5. ✅ Identificar bugs óbvios

**O que NÃO estamos validando:**
- ❌ Rigor científico completo (isso é para produção)
- ❌ Amostra estatisticamente representativa
- ❌ Conformidade ética formal (IRB/CEP)
- ❌ Publicação acadêmica

---

## 👥 Recrutamento MVP (5-10 pessoas)

### Quem Recrutar?

**Ideal:**
- Amigos próximos que confiam em você
- Colegas de trabalho/faculdade
- Familiares (se tiverem text samples)
- Comunidade AIOS Discord (voluntários informais)

**Requisitos mínimos:**
- 18+ anos
- Fluente em inglês (text samples)
- Tem 500-1000 palavras de texto pessoal
- Disposto a fazer questionário de 10 min

### Como Recrutar?

**Mensagem simplificada (WhatsApp/Email):**

```
Oi [Nome]!

Estou testando uma ferramenta de IA que analisa personalidade a partir de
texto escrito (Big Five). Preciso de 5-10 voluntários para validar.

**Você faria:**
1. Questionário de 10 min (auto-avaliação Big Five)
2. Enviar 500-1000 palavras suas (essay, emails, blog post)
3. Receber relatório grátis de personalidade

**Tempo:** 20-30 min total
**Privacidade:** Seus dados ficam anônimos ("subject_001"), deletados após teste
**Compensação:** Relatório grátis + minha eterna gratidão 😊

Interesse? Responde "sim" e eu te passo os detalhes!

Abs,
[Seu Nome]
```

**Resposta esperada:** "Sim, topo!" → Enviar instruções

---

## 📋 Acordo Informal (Substitui IRB Consent)

**Email de confirmação simples:**

```
Subject: InnerLens Testing - Instruções

Oi [Nome]!

Valeu por topar ajudar! Aqui vão os próximos passos:

## PRIVACIDADE & USO DOS DADOS

Antes de começar, confirma que tá ok:
✅ Vou analisar seu texto usando IA (Big Five personality)
✅ Seus dados ficam anônimos (você vira "subject_001")
✅ Uso só para testar o sistema (não publico, não vendo)
✅ Deleto tudo após validação (30 dias máx)
✅ Você pode desistir a qualquer momento

**Se tá ok, responde "CONFIRMO" e prossiga para os passos abaixo.**

---

## PASSO 1: AUTO-AVALIAÇÃO (10 min)

Acesse: https://ipip.ori.org/New_IPIP-50-item-scale.htm

Complete o questionário (50 perguntas).

Ao final, tire screenshot ou anote seus scores:
- Openness: __
- Conscientiousness: __
- Extraversion: __
- Agreeableness: __
- Neuroticism: __

Envie os scores para mim (email ou WhatsApp).

---

## PASSO 2: TEXTO PESSOAL (5-15 min)

Envie 500-1000 palavras de texto SEU (inglês):

**Opções:**
- Essay pessoal sobre qualquer assunto
- Transcrição de entrevista
- Posts de blog
- Emails pessoais (remova nomes/info sensível)
- Conversas do WhatsApp (copie suas mensagens)

**Formato:** .txt (texto simples)

**Privacidade:**
- Remova nomes, emails, endereços, telefones
- Pode deixar: opiniões, sentimentos, comportamentos

Envie por email ou compartilhe via Google Drive/Dropbox.

---

## PASSO 3: AGUARDE RESULTADOS (3-5 dias)

Vou rodar a análise e te enviar:
- Relatório Big Five completo
- Comparação: Seus scores vs IA
- Feedback se você quiser (opcional)

---

Dúvidas? Só me avisar!

Abs,
[Seu Nome]
```

---

## 🚀 Coleta de Dados (Procedimento)

### 1. Organizar Respostas

```bash
# Para cada participante que confirmar:

# Criar entry
echo "subject_001,João,joao@email.com,2025-01-16,confirmed" >> testing/data/participants.csv

# Receber scores
cat > testing/data/subject_001_selfassessment.csv << 'EOF'
trait,score
Openness,78
Conscientiousness,65
Extraversion,42
Agreeableness,58
Neuroticism,35
EOF

# Receber texto
# Salvar como: testing/data/subject_001_essay.txt
# (renomear arquivo enviado)
```

### 2. Verificar Qualidade

```bash
# Word count
wc -w testing/data/subject_001_essay.txt
# Mínimo: 500 palavras

# Encoding
file -I testing/data/subject_001_essay.txt
# Deve ser: UTF-8

# Conteúdo (manual)
head -n 10 testing/data/subject_001_essay.txt
# Verificar: tem opiniões/comportamentos? Ou só fatos?
```

### 3. Rodar Análise

```bash
cd /path/to/innerlens

# Run pipeline
*detect-traits-quick \
  --input testing/data/subject_001_essay.txt \
  --subject-id subject_001

# Salvar outputs
cp fragments.json testing/results/subject_001_fragments.json
cp bigfive-raw.yaml testing/results/subject_001_bigfive_raw.yaml
cp bigfive-profile.yaml testing/results/subject_001_bigfive_profile.yaml

# Log performance
echo "subject_001,[word_count],[time_seconds],[cost_usd]" >> testing/results/performance_log.csv
```

### 4. Enviar Resultados

```bash
# Email para participante:

Subject: Seu Relatório Big Five - InnerLens

Oi [Nome]!

Análise concluída! Segue seu relatório em anexo (bigfive-profile.yaml).

**Resumo:**
- Openness: [SCORE] (você: [SELF_SCORE])
- Conscientiousness: [SCORE] (você: [SELF_SCORE])
- Extraversion: [SCORE] (você: [SELF_SCORE])
- Agreeableness: [SCORE] (você: [SELF_SCORE])
- Neuroticism: [SCORE] (você: [SELF_SCORE])

Diferença média: [AVG_ERROR] pontos

**Feedback (opcional):**
Os scores fazem sentido? Alguma coisa te surpreendeu?

Valeu pela ajuda! 🙏

Abs,
[Seu Nome]
```

---

## 📊 Validação MVP (Critérios Relaxados)

### Target MVP vs Produção

| Métrica | MVP (Informal) | Produção (Formal) |
|---------|---------------|-------------------|
| **Sample size** | 5-10 pessoas | 10-20 pessoas |
| **Accuracy** | 70%+ correlation | 75%+ correlation |
| **Performance** | <3 min (95º percentil) | <2 min (90º percentil) |
| **Cost** | <$0.30 | <$0.20 |
| **Consent** | Email informal | IRB-compliant form |
| **Report** | Google Doc simples | Relatório formal 30+ páginas |

### Análise Rápida

```bash
# Usar scripts Python (mesmos)
python testing/scripts/calculate_accuracy.py \
  --input testing/results/accuracy-matrix-mvp.csv \
  --output testing/results/mvp-accuracy-report.md

# Decisão:
# - r >= 0.70: ✅ MVP validado, pode avançar
# - r = 0.65-0.69: ⚠️ Funciona mas precisa melhorias
# - r < 0.65: ❌ Problemas sérios, debugar
```

---

## ✅ Checklist MVP Testing

### Preparação
- [ ] Identificar 5-10 amigos/colegas potenciais
- [ ] Criar participants tracking (CSV simples)
- [ ] Preparar templates de email

### Recrutamento (Dia 1)
- [ ] Enviar mensagem de recrutamento
- [ ] Receber "sim" de 5-10 pessoas
- [ ] Enviar instruções + link questionário

### Coleta (Dias 2-3)
- [ ] Receber self-assessments
- [ ] Receber text samples
- [ ] Verificar qualidade (word count, encoding)
- [ ] Organizar em testing/data/

### Análise (Dia 3)
- [ ] Rodar pipeline para todos
- [ ] Salvar outputs em testing/results/
- [ ] Criar accuracy matrix CSV
- [ ] Logar performance metrics

### Validação (Dia 4)
- [ ] Rodar calculate_accuracy.py
- [ ] Revisar: r >= 0.70?
- [ ] Identificar problemas (se houver)
- [ ] Decisão: MVP válido? Ou debugar?

### Fechamento (Dia 5)
- [ ] Enviar relatórios para participantes
- [ ] Agradecer feedback (opcional)
- [ ] Deletar dados pessoais (após 30 dias)
- [ ] Documentar learnings

---

## 🔥 Diferenças do MVP vs Produção

| Aspecto | MVP (Agora) | Produção (Futuro) |
|---------|-------------|-------------------|
| **Consentimento** | Email informal | IRB-compliant form (50+ páginas) |
| **Recrutamento** | Amigos/conhecidos | Público geral (Reddit, Discord, ads) |
| **Sample size** | 5-10 | 20-50 |
| **Rigor estatístico** | Baixo (exploratório) | Alto (publicável) |
| **Documentação** | Google Doc simples | Relatório formal + appendices |
| **Privacy compliance** | Básico (anonimização) | Full GDPR/LGPD compliance |
| **Compensação** | Nenhuma ou simbólica | Gift cards ($10-20) |
| **Timeline** | 3-5 dias | 2-4 semanas |
| **Custo** | $2-4 | $50-100 |

---

## 📞 Quando Mudar para Produção?

**Use MVP approach (este documento) SE:**
- ✅ Testando internamente (equipe/amigos)
- ✅ Proof-of-concept rápido
- ✅ < 10 participantes
- ✅ Sem publicação acadêmica planejada
- ✅ Sem comercialização

**Mude para Produção (IRB-compliant) SE:**
- ❌ Lançar publicamente (website, app store)
- ❌ Cobrar usuários (freemium ou pago)
- ❌ Publicar paper acadêmico
- ❌ Recrutar >20 participantes
- ❌ Dados sensíveis (saúde mental, crianças)
- ❌ Parceria com empresa/universidade

**Localização docs produção:**
- `testing/future-production/informed-consent-form-PRODUCTION-ONLY.md`
- `testing/future-production/WHEN-TO-USE-IRB.md` (criar)
- `testing/TESTING-PLAN-EPIC-0.md` (versão completa - 60 páginas)

---

## 📝 Template: Tracking Simples

**File:** `testing/data/mvp-tracking.csv`

```csv
subject_id,name,email,recruited_date,confirmed,selfassessment_received,text_received,analysis_complete,report_sent,notes
001,João,joao@email.com,2025-01-16,yes,2025-01-16,2025-01-17,2025-01-17,2025-01-18,Ótimo feedback
002,Maria,maria@email.com,2025-01-16,yes,2025-01-17,pending,no,no,Aguardando texto
003,Pedro,pedro@email.com,2025-01-16,no,no,no,no,no,Desistiu
...
```

---

## 🎓 Learnings para Documentar

Após MVP testing, documente:

**O que funcionou:**
- [X] funcionou bem
- [Y] foi mais fácil que esperado

**O que não funcionou:**
- [A] teve problema [descrição]
- [B] precisa melhorar [sugestão]

**Mudanças para Epic 1:**
- Priorizar [feature] porque [razão]
- Ajustar [parâmetro] de X para Y

**Quando usar produção:**
- IRB necessário quando [cenário específico baseado em aprendizado]

---

## 🚀 Quick Start (TL;DR)

```bash
# 1. Recrutar (1 dia)
# Mensagem WhatsApp/Email para 10 amigos
# Target: 5-10 "sim"

# 2. Coletar (2 dias)
# Receber self-assessments + text samples
# Organizar em testing/data/

# 3. Analisar (1 dia)
# Rodar pipeline para todos
# Criar accuracy matrix

# 4. Validar (1 dia)
# python testing/scripts/calculate_accuracy.py ...
# Decisão: r >= 0.70? ✅ MVP OK

# 5. Fechar (1 dia)
# Enviar relatórios
# Deletar dados (após 30 dias)
# Documentar learnings
```

**Total:** 3-5 dias, $2-4, zero burocracia IRB

---

**MVP Testing Guide Version:** 1.0
**Status:** ✅ Ready to Use
**Última Atualização:** 2025-01-15

**Próximo passo:** Recrutar 5-10 amigos e começar!

© 2025 Academia Lendar[IA] - InnerLens Lite MVP Testing (Simplified)
