# AULA 6.7 | Automatizacao de Rotinas Tributarias

## Modulo 6 - IA para Gestao Tributaria | Trilha 4

---

## FICHA DA AULA

| Campo | Valor |
|-------|-------|
| **Duracao** | 12 minutos |
| **Tipo** | Pratico |
| **Formato** | Video |
| **Entregavel** | Lista de rotinas para automatizar + prompts prontos |

---

## OBJETIVO DA AULA

Aluno aprende:
- Quais rotinas tributarias podem ser automatizadas com IA
- Como criar prompts reutilizaveis
- Integracao IA + planilhas + ferramentas
- Economia de tempo real

---

## ROTEIRO DE GRAVACAO

[TELA: "AUTOMATIZACAO DE ROTINAS"]

[INTRODUCAO - 2 min]
Locucao: "IA nao e so para decisoes grandes.
Pode automatizar tarefas do dia a dia:
- Calculos repetitivos
- Analises mensais
- Relatorios padrao
- Revisoes de documentos"

---

[TELA: Rotinas automatizaveis]

[ROTINAS - 4 min]
Locucao: "Rotinas que voce pode automatizar:

1. ANALISE MENSAL DE DRE
   'Analise meu DRE do mes:
   [colar numeros]
   Identifique: anomalias, oportunidades, riscos'

2. CALCULO DE FATOR R
   'Calcule meu Fator R:
   Folha: R$ X, Faturamento: R$ Y
   Estou em qual anexo? Quanto falta para mudar?'

3. SIMULACAO DE CENARIOS
   'Se meu faturamento aumentar X%, quanto pago de imposto?'

4. REVISAO DE CONTRATOS
   'Revise este contrato e identifique riscos tributarios.'

5. GERACAO DE RELATORIOS
   'Gere relatorio mensal de metricas tributarias.'"

---

[TELA: Biblioteca de prompts]

[BIBLIOTECA - 4 min]
Locucao: "Crie sua biblioteca de prompts:

Salve os prompts que funcionam.
Personalize para seu contexto.
Reuse todo mes.

Exemplo de biblioteca:
- PROMPT_DRE_MENSAL
- PROMPT_FATOR_R
- PROMPT_SIMULACAO
- PROMPT_REVISAO_CONTRATO
- PROMPT_RELATORIO

Cada um ja com seus dados fixos preenchidos."

---

[TELA: Economia de tempo]

[ECONOMIA - 2 min]
Locucao: "Economia de tempo real:

| Tarefa | Tempo Manual | Tempo com IA | Economia |
|--------|--------------|--------------|----------|
| Analise DRE | 2h | 10min | 1h50 |
| Calculo Fator R | 30min | 2min | 28min |
| Simulacao | 1h | 5min | 55min |
| Revisao contrato | 1h | 15min | 45min |

Total por mes: 5-10 horas economizadas."

---

## ROTINAS AUTOMATIZAVEIS

| Rotina | Frequencia | Prompt Base |
|--------|------------|-------------|
| Analise de DRE | Mensal | PROMPT_DRE |
| Calculo Fator R | Mensal | PROMPT_FATOR_R |
| Simulacao cenarios | Trimestral | PROMPT_SIMULACAO |
| Revisao compliance | Mensal | PROMPT_COMPLIANCE |
| Relatorio gerencial | Mensal | PROMPT_RELATORIO |

---

## PROMPT DE ANALISE MENSAL DE DRE

```
Atue como controller financeiro. Analise meu DRE do mes:

MES: [mes/ano]

DRE:
- Receita Bruta: R$ [valor]
- Deducoes: R$ [valor]
- Receita Liquida: R$ [valor]
- CMV/CSV: R$ [valor]
- Lucro Bruto: R$ [valor]
- Despesas Operacionais: R$ [valor]
- Despesas Tributarias: R$ [valor]
- Lucro Operacional: R$ [valor]
- Lucro Liquido: R$ [valor]

MES ANTERIOR (para comparacao):
- Receita: R$ [valor]
- Lucro Liquido: R$ [valor]
- Carga tributaria: ___%

ANALISE:

1. PERFORMANCE DO MES:
   | Metrica | Valor | Variacao vs Anterior | Status |
   |---------|-------|---------------------|--------|
   | Receita | R$ | % | |
   | Margem bruta | % | pp | |
   | Margem liquida | % | pp | |
   | Carga tributaria | % | pp | |

2. ANOMALIAS IDENTIFICADAS:
   - ___
   - ___

3. OPORTUNIDADES:
   - ___
   - ___

4. ALERTAS:
   - ___
   - ___

5. ACOES RECOMENDADAS PARA PROXIMO MES:
   1. ___
   2. ___
   3. ___
```

---

## PROMPT DE CALCULO FATOR R MENSAL

```
Calcule meu Fator R do mes e projete proximo trimestre:

DADOS DO MES:
- Faturamento bruto: R$ [valor]
- Folha de pagamento (incluindo pro-labore): R$ [valor]
- Pro-labore dos socios: R$ [valor]

HISTORICO (ultimos 12 meses):
| Mes | Faturamento | Folha | Fator R |
|-----|-------------|-------|---------|
| -12 | R$ | R$ | % |
| -11 | R$ | R$ | % |
| ... | | | |
| Atual | R$ | R$ | % |

CALCULE:

1. FATOR R ATUAL:
   Fator R = Folha / Faturamento = ___%

2. ANEXO ATUAL:
   [ ] Anexo III (Fator R >= 28%)
   [ ] Anexo V (Fator R < 28%)

3. PROJECAO PROXIMOS 3 MESES:
   | Mes | Faturamento Proj. | Folha Proj. | Fator R | Anexo |
   |-----|-------------------|-------------|---------|-------|
   | +1 | R$ | R$ | % | |
   | +2 | R$ | R$ | % | |
   | +3 | R$ | R$ | % | |

4. ALERTA DE MUDANCA DE ANEXO:
   - Distancia para 28%: ___pp
   - Risco de cair para Anexo V: [ ] Alto [ ] Medio [ ] Baixo
   - Para manter Anexo III, folha minima: R$ ___

5. RECOMENDACAO:
   - [ ] Manter atual
   - [ ] Ajustar pro-labore para R$ ___
   - [ ] Considerar contratacao
   - [ ] Reavaliar estrategia
```

---

## ARTEFATO DA AULA: Biblioteca de Prompts Reutilizaveis

### O Que Voce Vai Criar
Colecao de prompts prontos para rotinas tributarias mensais, personalizados para sua empresa e prontos para reuso.

### Por Que Isso Importa
Rotinas com IA:
- Economizam 5-10h/mes
- Padronizam analises
- Reduzem erros
- Liberam tempo para decisoes

**Linha do DRE:** Custo Operacional (menos tempo = menos custo)

### Quando Usar
- Todo inicio de mes
- Ao fechar DRE
- Ao calcular Fator R
- Ao revisar compliance

### Como Criar
1. Identifique suas rotinas mensais
2. Crie prompt para cada uma
3. Personalize com dados fixos
4. Salve em documento organizado
5. Reuse mensalmente

### Template de Biblioteca

```
BIBLIOTECA DE PROMPTS - ROTINAS TRIBUTARIAS

===========================================
PROMPT_DRE_MENSAL
===========================================
[Colar prompt de analise de DRE personalizado]

Dados fixos da minha empresa:
- Regime: ___
- Meta de margem: ___%
- Limite de carga: ___%

===========================================
PROMPT_FATOR_R
===========================================
[Colar prompt de Fator R personalizado]

Dados fixos:
- Fator R ideal: >= 28%
- Pro-labore minimo: R$ ___

===========================================
PROMPT_COMPLIANCE_MENSAL
===========================================
[Colar prompt de verificacao de compliance]

Itens a verificar:
- [ ] Obrigacoes fiscais
- [ ] Ferias
- [ ] Contratos

===========================================
PROMPT_SIMULACAO
===========================================
[Colar prompt de simulacao de cenarios]

Cenarios padrao:
- Atual
- +20%
- +50%

===========================================
PROMPT_RELATORIO
===========================================
[Colar prompt de relatorio gerencial]

Formato: Para socios/diretoria

===========================================

CALENDARIO DE USO:
| Prompt | Quando Usar | Tempo Estimado |
|--------|-------------|----------------|
| DRE | Dia 5 | 10 min |
| Fator R | Dia 5 | 5 min |
| Compliance | Dia 10 | 15 min |
| Relatorio | Dia 15 | 10 min |
```

---

**Criar agora?** ✅ Sim, durante a aula (12 min)
**Tempo estimado:** 12 minutos
**Onde salvar:** Documento de referencia permanente

---

## IA NA PRATICA

### Prompt Principal: Criador de Biblioteca Personalizada

```
Atue como consultor de produtividade. Crie uma biblioteca de prompts personalizada para minha rotina tributaria:

MINHA EMPRESA:
- Atividade: [descrever]
- Regime: [Simples/Presumido/Real]
- Faturamento: R$ [valor]/mes
- Funcionarios: [quantidade]

MINHAS ROTINAS ATUAIS:
1. [Rotina 1]: faço [frequencia]
2. [Rotina 2]: faço [frequencia]
3. [Rotina 3]: faço [frequencia]

CRIE BIBLIOTECA COM:

1. PROMPT_[ROTINA_1]:
   [Prompt completo e personalizado]
   Quando usar: ___
   Tempo estimado: ___

2. PROMPT_[ROTINA_2]:
   [Prompt completo e personalizado]
   Quando usar: ___
   Tempo estimado: ___

3. PROMPT_[ROTINA_3]:
   [Prompt completo e personalizado]
   Quando usar: ___
   Tempo estimado: ___

CALENDARIO MENSAL:
| Dia | Prompt | Acao | Responsavel |
|-----|--------|------|-------------|
| | | | |

ECONOMIA ESTIMADA:
- Antes: ___ horas/mes
- Depois: ___ horas/mes
- Economia: ___ horas/mes
- Valor da economia: R$ ___ (se hora vale R$ ___)
```

### Prompt Alternativo: Otimizador de Prompts Existentes

```
Otimize meus prompts atuais para melhores resultados:

PROMPT ATUAL:
[COLAR PROMPT QUE ESTA USANDO]

PROBLEMAS QUE ESTOU TENDO:
[ ] Respostas vagas
[ ] Faltam informacoes
[ ] Muito longo
[ ] Muito curto
[ ] Nao entende meu contexto
[ ] Outro: ___

OTIMIZE:

1. ANALISE DO PROMPT ATUAL:
   - Problemas identificados: ___
   - O que esta faltando: ___
   - O que esta sobrando: ___

2. PROMPT OTIMIZADO:
   [Versao melhorada completa]

3. DIFERENCAS:
   | Aspecto | Antes | Depois |
   |---------|-------|--------|
   | Clareza | | |
   | Contexto | | |
   | Formato | | |
   | Especificidade | | |

4. DICAS DE USO:
   - Quando usar: ___
   - O que personalizar: ___
   - Resultado esperado: ___
```

### Como Usar o Resultado

| Biblioteca Criada | Proxima Acao |
|-------------------|--------------|
| Prompts prontos | Salvar em documento |
| Calendario | Configurar lembretes |
| Tempo estimado | Bloquear agenda |
| Economia calculada | Medir resultado real |

---

## ECONOMIA DE TEMPO

| Tarefa | Manual | Com IA | Economia |
|--------|--------|--------|----------|
| Analise DRE mensal | 2h | 10min | 1h50 |
| Calculo Fator R | 30min | 2min | 28min |
| Simulacao cenarios | 1h | 5min | 55min |
| Revisao compliance | 1h | 15min | 45min |
| Relatorio gerencial | 1h | 10min | 50min |
| **TOTAL/MES** | **5h30** | **42min** | **~5h** |

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Tabela de economia de tempo
- Biblioteca visual de prompts
- Calendario mensal
- Antes/depois

### Orientacoes
- Tom pratico e de produtividade
- Mostrar economia real
- Enfatizar reuso
- Exemplos do dia a dia

---

**Proxima Aula:** 6.8 - O Futuro da IA na Gestao Tributaria
