# Arquitetura de Camadas: Negócio vs Técnica

**Data:** 2025-01-01
**Status:** Em planejamento
**Referência:** `../melhorias-formacao/plano-separacao-estrategia-tecnica.md`

---

## Visão Geral

A Nova Formação adota uma arquitetura de **duas camadas** para separar conteúdo estratégico (uso de IA) de conteúdo técnico (implementação de automações).

**Princípio:** O empresário quer resultado, não quer virar programador.

---

## Camada 1: Trilhas de Negócio

**Público:** Empresário, gestor, decisor

**Características:**
- Foco em prompts prontos, templates, decisão
- Zero técnica (só copiar/colar)
- 4-7h por trilha
- Resultado: usa IA no dia seguinte

**Trilhas:**
- Trilha 1: Pessoas & Processos
- Trilha 3: Dados & Performance
- Trilha 4: Tributário & Compliance
- Trilha 5: Gestão com IA
- Trilha 6: Marketing com IA
- Trilha 7: Vendas com IA
- Trilha 8: CS & Atendimento
- Trilha 9: Social Media
- Trilha 10: Prospecção & Fechamento

---

## Camada 2: Trilha Técnica

**Público:** Time técnico, estagiário, analista, freelancer, empresário tech-savvy

**Características:**
- Foco em automações, APIs, integrações, RAG
- Pré-requisito: ter feito pelo menos 1 trilha de negócio
- 9-15h
- Resultado: sistema automatizado rodando

**Trilha:**
- Trilha 11: Automação IA para Negócios (em desenvolvimento)

---

## Conexão Entre Camadas

```
TRILHA DE NEGÓCIO                    TRILHA TÉCNICA
(Empresário aprende a usar)          (Time implementa automação)
─────────────────────────            ─────────────────────────

Trilha 7: Vendas                     Trilha 11: Automação
├── Prompts de qualificação    ───→  ├── Workflow SDR automático
├── Templates de follow-up     ───→  ├── Cadência WhatsApp n8n
└── "Ponte" para Trilha 11           └── Integração CRM

Trilha 8: CS & Atendimento           Trilha 11: Automação
├── Prompts de triagem         ───→  ├── Classificador automático
├── Health Score manual        ───→  ├── Alertas proativos
└── "Ponte" para Trilha 11           └── Motor IA + Chatwoot
```

---

## Documentação Relacionada

- **Plano detalhado:** `../melhorias-formacao/plano-separacao-estrategia-tecnica.md`
- **Trilhas existentes:** `trilhas-formacao.md`
- **Metodologia:** `Metodologia-gps.md`

---

## Status de Implementação

| Fase | Descrição | Status |
|------|-----------|--------|
| 1 | Auditoria de trilhas (identificar conteúdo técnico) | Pendente |
| 2 | Criação estrutura Trilha 11 | Pendente |
| 3 | Extração de conteúdo técnico | Pendente |
| 4 | Criação de "pontes" nas trilhas originais | Pendente |
| 5 | Testes e validação | Pendente |

---

*Documento criado em: 2025-01-01*
*Última atualização: 2025-01-01*
