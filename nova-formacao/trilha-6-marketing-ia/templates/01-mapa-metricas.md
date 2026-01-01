# Template: Mapa de Metricas de Marketing

## Trilha 6 - Marketing com IA | Modulo 1

---

## Instrucoes de Uso

1. Defina suas metricas por etapa do funil
2. Identifique onde buscar cada dado
3. Estabeleca metas e benchmarks
4. Configure tracking (GA4/UTMs)
5. Acompanhe semanalmente

---

## 1. IDENTIFICACAO

| Campo | Valor |
|-------|-------|
| **Empresa** | |
| **Responsavel** | |
| **Data** | |
| **Periodo de Referencia** | Mes ___/___ |

---

## 2. FUNIL DE MARKETING

### Visao Geral

```
TOPO (Awareness)          MEIO (Consideracao)        FUNDO (Conversao)
────────────────          ───────────────────        ─────────────────
Visitantes                Leads                      Clientes
    ↓                         ↓                          ↓
[________]                [________]                 [________]
    ↓ ___% conversao          ↓ ___% conversao
```

---

## 3. METRICAS POR ETAPA

### TOPO DO FUNIL (Awareness)

| Metrica | Valor Atual | Meta | Fonte |
|---------|-------------|------|-------|
| **Visitantes unicos/mes** | | | GA4 |
| **Impressoes (Ads)** | | | Meta/Google |
| **Alcance organico** | | | Redes sociais |
| **Seguidores totais** | | | Redes sociais |
| **Mencoes da marca** | | | Listening |

### MEIO DO FUNIL (Consideracao)

| Metrica | Valor Atual | Meta | Fonte |
|---------|-------------|------|-------|
| **Leads gerados/mes** | | | CRM |
| **Taxa conversao visitante→lead** | ___% | ___% | GA4/CRM |
| **CPL (Custo por Lead)** | R$ | R$ | Ads |
| **Engajamento (likes, comments)** | | | Redes |
| **Downloads de material** | | | LP/Site |

### FUNDO DO FUNIL (Conversao)

| Metrica | Valor Atual | Meta | Fonte |
|---------|-------------|------|-------|
| **Vendas/mes** | | | CRM |
| **Taxa conversao lead→cliente** | ___% | ___% | CRM |
| **CAC (Custo por Aquisicao)** | R$ | R$ | Total/Clientes |
| **Ticket medio** | R$ | R$ | Sistema |
| **ROI de Marketing** | ___x | ___x | Calculo |

---

## 4. METRICAS DE CANAIS

### Trafego Pago

| Canal | Investimento | Leads | CPL | Vendas | CAC | ROI |
|-------|--------------|-------|-----|--------|-----|-----|
| Meta Ads | R$ | | R$ | | R$ | x |
| Google Ads | R$ | | R$ | | R$ | x |
| LinkedIn | R$ | | R$ | | R$ | x |
| TikTok | R$ | | R$ | | R$ | x |
| **TOTAL PAGO** | **R$** | | **R$** | | **R$** | **x** |

### Trafego Organico

| Canal | Visitantes | Leads | Vendas | Custo |
|-------|------------|-------|--------|-------|
| SEO/Blog | | | | R$ |
| Instagram | | | | R$ |
| LinkedIn | | | | R$ |
| YouTube | | | | R$ |
| Email | | | | R$ |
| Indicacao | | | | R$ |
| **TOTAL ORGANICO** | | | | **R$** |

---

## 5. CALCULO DE ROI

### Formula

```
ROI = (Receita gerada - Investimento) / Investimento

Exemplo:
Investimento: R$ 10.000
Receita gerada: R$ 50.000
ROI = (50.000 - 10.000) / 10.000 = 4x
```

### Seu Calculo

| Campo | Valor |
|-------|-------|
| Investimento em Marketing | R$ /mes |
| Receita atribuida | R$ /mes |
| ROI | x |

---

## 6. BENCHMARKS

| Metrica | Seu Valor | Benchmark | Status |
|---------|-----------|-----------|--------|
| Taxa conversao LP | ___% | 2-5% | ✅ ⚠️ ❌ |
| CPL B2B | R$ | R$ 50-200 | ✅ ⚠️ ❌ |
| CPL B2C | R$ | R$ 10-50 | ✅ ⚠️ ❌ |
| CAC | R$ | < LTV/3 | ✅ ⚠️ ❌ |
| ROI Ads | ___x | > 3x | ✅ ⚠️ ❌ |
| Email open rate | ___% | 15-25% | ✅ ⚠️ ❌ |
| Email CTR | ___% | 2-5% | ✅ ⚠️ ❌ |

---

## 7. SETUP DE TRACKING

### UTMs Padronizados

| Parametro | Formato | Exemplo |
|-----------|---------|---------|
| utm_source | plataforma | facebook, google, instagram |
| utm_medium | tipo | cpc, organic, email |
| utm_campaign | nome-campanha | black-friday-2024 |
| utm_content | variacao | video-1, imagem-2 |

### Template de URL

```
https://seusite.com/pagina?utm_source=___&utm_medium=___&utm_campaign=___&utm_content=___
```

### Eventos GA4 Configurados

| Evento | Descricao | Configurado? |
|--------|-----------|--------------|
| page_view | Visualizacao de pagina | ✅ ❌ |
| generate_lead | Lead capturado | ✅ ❌ |
| purchase | Compra realizada | ✅ ❌ |
| scroll | Rolagem da pagina | ✅ ❌ |
| click | Clique em CTA | ✅ ❌ |

---

## 8. DASHBOARD SEMANAL

### Semana de ___/___ a ___/___

| Metrica | Seg | Ter | Qua | Qui | Sex | Sab | Dom | Total |
|---------|-----|-----|-----|-----|-----|-----|-----|-------|
| Visitantes | | | | | | | | |
| Leads | | | | | | | | |
| Vendas | | | | | | | | |
| Investimento | | | | | | | | |

---

## 9. PROMPT DE IA PARA ANALISE

```
Analise minhas metricas de marketing:

TOPO DO FUNIL:
- Visitantes: ___ /mes
- Investimento em ads: R$ ___
- Alcance organico: ___

MEIO DO FUNIL:
- Leads: ___ /mes
- Taxa conversao: ___%
- CPL: R$ ___

FUNDO DO FUNIL:
- Vendas: ___ /mes
- Taxa conversao: ___%
- CAC: R$ ___
- Ticket medio: R$ ___

CANAIS:
- Melhor canal: ___ (ROI: ___x)
- Pior canal: ___ (ROI: ___x)

Perguntas:
1. Meu funil esta saudavel?
2. Qual etapa e o gargalo?
3. Onde investir mais?
4. Onde cortar/pausar?
5. O que testar primeiro?
```

---

## 10. PLANO DE ACAO

### Gargalos Identificados

| Etapa | Problema | Acao | Responsavel | Prazo |
|-------|----------|------|-------------|-------|
| Topo | | | | |
| Meio | | | | |
| Fundo | | | | |

---

## 11. CHECKLIST DE VALIDACAO

- [ ] Todas as metricas mapeadas
- [ ] Fontes de dados identificadas
- [ ] Metas estabelecidas
- [ ] UTMs padronizados
- [ ] GA4 configurado
- [ ] Dashboard criado

---

## 12. COMPROMISSO 48H

**Meu compromisso:**

- [ ] Preencher o mapa com dados reais
- [ ] Configurar tracking (UTM/GA4)
- [ ] Identificar principal gargalo

**Gargalo identificado:** ___
**Acao:** ___

---

**Template versao:** 1.0
**Trilha:** Marketing com IA
**Modulo:** 1 - Mapa de Metricas
