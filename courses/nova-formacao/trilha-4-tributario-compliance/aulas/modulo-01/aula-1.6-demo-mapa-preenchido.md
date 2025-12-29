# Aula 1.6: Demo - Mapa Tributario Preenchido

## Trilha 4 | Modulo 1 | Diagnostico Tributario

---

> **Duracao:** 10 minutos
> **Tipo:** Demo
> **Exemplo:** Empresa de servicos de marketing digital

---

## Caso de Estudo

### Perfil da Empresa

| Dado | Valor |
|------|-------|
| **Nome ficticio** | Marketing Digital ABC |
| **Atividade** | Agencia de marketing |
| **CNAE** | 7311-4/00 - Agencias de publicidade |
| **Regime** | Simples Nacional |
| **Faturamento** | R$ 120.000/mes |
| **Funcionarios** | 8 pessoas |
| **Folha bruta** | R$ 45.000/mes |

---

## Mapa Tributario Preenchido

### Secao 1: Dados Gerais

```
DADOS DA EMPRESA
================
Razao Social: Marketing Digital ABC Ltda
CNPJ: 12.345.678/0001-90
CNAE Principal: 7311-4/00 - Agencias de publicidade
Regime Tributario: [X] Simples [ ] Presumido [ ] Real
Faturamento Mensal Medio: R$ 120.000
Numero de Funcionarios: 8
```

### Secao 2: Tributos (Simples Nacional)

```
SIMPLES NACIONAL (DAS)
======================
Anexo: III (servicos)
Faixa: 3a faixa (RBT12 = R$ 1.440.000)
Aliquota efetiva: 11.2%

| Componente do DAS | % | Valor/Mes |
|-------------------|---|-----------|
| IRPJ | 0.84% | R$ 1.008 |
| CSLL | 0.50% | R$ 600 |
| COFINS | 2.42% | R$ 2.904 |
| PIS | 0.52% | R$ 624 |
| CPP | 4.92% | R$ 5.904 |
| ISS | 2.00% | R$ 2.400 |
| TOTAL DAS | 11.2% | R$ 13.440 |

Observacao: No Simples, tudo vem junto no DAS.
Por isso parece "simples" mas esconde a complexidade.
```

### Secao 3: Carga Implicita (Folha)

```
ENCARGOS SOBRE FOLHA
====================
Folha bruta mensal: R$ 45.000

| Item | % | Valor/Mes |
|------|---|-----------|
| FGTS | 8% | R$ 3.600 |
| Provisao Ferias + 1/3 | 11% | R$ 4.950 |
| Provisao 13o | 8% | R$ 3.600 |
| FGTS sobre provisoes | 8% | R$ 684 |
| TOTAL ENCARGOS | | R$ 12.834 |

Obs: INSS patronal ja esta incluso no CPP do Simples.
```

### Secao 4: Carga Oculta (ultimos 12 meses)

```
CUSTOS OCULTOS
==============
| Item | Valor Total | Valor/Mes |
|------|-------------|-----------|
| Multa GFIP atrasada | R$ 1.200 | R$ 100 |
| Juros DAS atrasado | R$ 800 | R$ 67 |
| Honorario extra contador | R$ 2.400 | R$ 200 |
| Tempo reunioes fiscais | 24h | 2h/mes |
| TOTAL OCULTO ($/mes) | | R$ 367 |
```

### Secao 5: Resumo Consolidado

```
RESUMO - CARGA TRIBUTARIA TOTAL
===============================
Faturamento: R$ 120.000/mes

| Tipo | Valor/Mes | Valor/Ano | % Faturamento |
|------|-----------|-----------|---------------|
| Explicita (DAS) | R$ 13.440 | R$ 161.280 | 11.2% |
| Implicita (Encargos) | R$ 12.834 | R$ 154.008 | 10.7% |
| Oculta (Estimada) | R$ 367 | R$ 4.404 | 0.3% |
| TOTAL | R$ 26.641 | R$ 319.692 | 22.2% |

Lucro mensal estimado: R$ 30.000
Carga sobre LUCRO: 88.8% (R$ 26.641 / R$ 30.000)
```

---

## Analise do Caso

### O que o empresario achava:
> "Pago 11% de imposto no Simples. E razoavel."

### O que a realidade mostra:
> "Carga TOTAL e 22.2% do faturamento. Quase 90% do lucro vai para tributos e encargos."

### Insights do Mapa:

| Descoberta | Implicacao |
|------------|------------|
| CPP (INSS) e o maior componente | 4.92% so de previdencia |
| Encargos sao quase iguais ao DAS | R$ 12.834 vs R$ 13.440 |
| Multas recorrentes | Processo de pagamento falho |
| Carga sobre lucro e 88.8% | Margem real minuscula |

---

## Perguntas Que Este Mapa Gera

### Para o contador:

1. "Estamos no anexo correto do Simples?"
2. "Lucro Presumido seria mais vantajoso com essa folha?"
3. "O que podemos fazer sobre as multas recorrentes?"

### Para si mesmo:

1. "Preciso de 8 CLT ou poderia ter PJ?"
2. "Minha margem justifica esses encargos?"
3. "Onde posso otimizar SEM sonegar?"

---

## Comparativo Com Benchmark

| Metrica | Esta Empresa | Benchmark Setor |
|---------|--------------|-----------------|
| Carga explicita | 11.2% | 9-13% |
| Carga total | 22.2% | 18-25% |
| Carga sobre lucro | 88.8% | 60-80% |

**Diagnostico:** Na media para explicita, ACIMA da media para carga sobre lucro.

**Acao sugerida:** Investigar alternativa de regime e otimizacao de folha.

---

## Seu Turno

Na proxima aula, voce vai preencher SEU Mapa Tributario usando os dados da sua empresa.

### Prepare antes:
- [ ] Ultimas 6 guias de impostos (DAS ou DARFs)
- [ ] Folha de pagamento mensal
- [ ] Historico de multas/juros (se houver)

---

## ARTEFATO DA AULA: Analise de Padroes do Mapa de Referencia

### O Que Voce Vai Criar
Anotacoes sobre os padroes observados no Mapa de Referencia, identificando o que se aplica ao seu caso e o que precisa adaptar.

### Por Que Isso Importa
Aprender por exemplo acelera o preenchimento:
- Ver Mapa real = entender o esperado
- Identificar padroes aplicaveis
- Antecipar dificuldades
- Preparar perguntas para contador

**Linha do DRE:** Custo de Aprendizado (aprender com exemplo vs errar sozinho)

### Quando Usar
- Durante a demo (anotando enquanto assiste)
- Ao iniciar preenchimento do seu Mapa
- Como checklist de qualidade
- Para comparar seu resultado

### Como Criar
1. Assista a demo prestando atencao
2. Anote valores de referencia do exemplo
3. Compare com sua situacao
4. Liste adaptacoes necessarias

### Template

```
ANOTACOES DA DEMO - MAPA TRIBUTARIO
===================================

CASO DE REFERENCIA:
- Regime: Simples Nacional
- Faturamento: R$ 120.000/mes
- Funcionarios: 8
- Folha: R$ 45.000

VALORES DE REFERENCIA:
| Item | Exemplo | Meu Caso |
|------|---------|----------|
| DAS (explicita) | 11.2% | ___% |
| Encargos (implicita) | 10.7% | ___% |
| Ocultos | 0.3% | ___% |
| TOTAL | 22.2% | ___% |
| Carga/Lucro | 88.8% | ___% |

PADROES OBSERVADOS:
1. CPP (INSS) e maior componente do Simples
2. Encargos quase iguais aos tributos
3. Multas indicam processo falho
4. Carga sobre lucro muito alta

APLICA AO MEU CASO?
[ ] Meu regime e similar
[ ] Minha folha proporcional e parecida
[ ] Tenho multas recorrentes
[ ] Carga sobre lucro parece alta

O QUE PRECISO ADAPTAR:
1. _________________________________________
2. _________________________________________
3. _________________________________________
```

---

**Criar agora?** 📋 Sim, durante a demo (10 min)
**Tempo estimado:** 10 minutos (junto com video)
**Onde salvar:** Junto com template do Mapa para referencia

---

## Proximo Passo

Agora e sua vez de criar seu proprio Mapa Tributario.

→ Aula 1.7: Exercicio - Seu Mapa Tributario

---

## IA NA PRATICA

### Prompt Principal: Analisador de Padroes do Exemplo

```
Analise este Mapa Tributario de referencia e identifique padroes aplicaveis ao meu caso:

CASO DE REFERENCIA (da demo):
- Regime: Simples Nacional (Anexo III)
- Faturamento: R$ 120.000/mes
- Funcionarios: 8
- Folha: R$ 45.000/mes
- DAS: R$ 13.440 (11.2%)
- Encargos: R$ 12.834 (10.7%)
- Ocultos: R$ 367 (0.3%)
- TOTAL: R$ 26.641 (22.2%)
- Carga sobre lucro: 88.8%

MEU CASO:
- Regime: [Simples/Presumido/Real]
- Faturamento: R$ [valor]/mes
- Funcionarios: [numero]
- Folha: R$ [valor]/mes

ANALISE:
1. Minha situacao e similar ou diferente da referencia?
2. Quais padroes da demo se aplicam a mim?
3. O que devo esperar de diferente?
4. A proporcao folha/faturamento e parecida?
5. Que insights da demo devo levar para meu Mapa?
```

### Prompt Alternativo: Decompositor de DAS

```
Decomponha o DAS do Simples Nacional para meu caso:

DADOS:
- Faturamento mensal: R$ [valor]
- RBT12 (faturamento ultimos 12 meses): R$ [valor]
- Anexo: [I, II, III, IV ou V]
- CNAE: [codigo]

CALCULE:
1. Faixa do Simples que me enquadro
2. Aliquota nominal e efetiva
3. Decomposicao por tributo:
   - IRPJ: R$ ___ (___%)
   - CSLL: R$ ___ (___%)
   - COFINS: R$ ___ (___%)
   - PIS: R$ ___ (___%)
   - CPP/INSS: R$ ___ (___%)
   - ISS/ICMS: R$ ___ (___%)
4. Valor total do DAS

Mostre o calculo passo a passo.
```

### Como Usar o Resultado

1. **Compare** os padroes da demo com sua situacao
2. **Ajuste** suas expectativas baseado nas diferencas
3. **Identifique** o que precisa calcular diferente
4. **Use a decomposicao** do DAS para preencher seu Mapa

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Mapa sendo preenchido em tempo real
- Decomposicao do DAS por componente
- Calculo de encargos linha a linha
- Comparativo com benchmark no final

### Orientacoes
- Mostrar processo, nao so resultado
- Pausar em pontos importantes
- Explicar raciocinio por tras dos numeros
- Gerar insights aplicaveis

---

**Duracao real:** 10 minutos
**Proximo:** Aula 1.7
