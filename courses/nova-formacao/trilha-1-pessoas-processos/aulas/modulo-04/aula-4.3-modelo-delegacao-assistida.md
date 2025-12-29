# AULA 4.3 | O Modelo de Delegacao Assistida

## Modulo 4 - Delegar Sem Virar Gargalo | Trilha 1

---

## FICHA DA AULA

| Campo | Valor |
|-------|-------|
| **Duracao** | 8 minutos |
| **Tipo** | Framework |
| **Formato** | Video |
| **Entregavel** | Conhecer os 5 componentes e niveis de autonomia |

---

## OBJETIVO DA AULA

Aluno conhece:
- O fluxo da Delegacao Assistida
- Os 5 componentes do modelo
- Os 4 niveis de autonomia
- Como evoluir a pessoa de nivel

---

## ROTEIRO DE GRAVACAO

[TELA: Fluxograma do modelo]

[VISAO GERAL - 1 min]
Locucao: "O fluxo da Delegacao Assistida:

TAREFA
  ↓
BRIEFING (voce escreve 1 vez)
  ↓
PESSOA EXECUTA
  ↓
IA VALIDA (prompt)
  ↓
Se passou → ENTREGA
Se falhou → PESSOA AJUSTA → IA VALIDA de novo
  ↓
Voce so ve o que PASSOU"

---

[TELA: Os 5 componentes em cards]

[COMPONENTES - 5 min]
Locucao: "O modelo tem 5 componentes:

1. TAREFA
   - Descricao clara do que fazer
   - Nao o 'como', mas o 'o que'

2. BRIEFING
   - O que, por que, pra quando
   - Restricoes (o que NAO pode)
   - Onde achar informacao

3. CHECKLIST DE QUALIDADE
   - 3-5 criterios mensuraveis
   - Sim/nao, nao 'mais ou menos'

4. PROMPT DE VALIDACAO
   - IA checa os criterios
   - Aprova ou lista correcoes
   - Pessoa so entrega se aprovar

5. OUTPUT ESPERADO
   - Exemplo do resultado certo
   - Referencia visual ou texto"

---

[TELA: Escada de autonomia - Niveis 1 a 4]

[NIVEIS DE AUTONOMIA - 1min30s]
Locucao: "A pessoa pode ter diferentes niveis:

NIVEL 1: Fazer e mostrar tudo
→ Voce revisa 100%

NIVEL 2: IA valida, voce revisa alguns
→ Voce ve 30%

NIVEL 3: IA valida, voce ve excecoes
→ Voce ve 10%

NIVEL 4: IA valida, voce monitora metricas
→ Voce ve 0% (so dashboard)

Meta: ir subindo de nivel conforme confianca."

---

[TRANSICAO - 30s]
Locucao: "Na proxima aula, um modelo completo preenchido."

---

## FRAMEWORK: FLUXO DA DELEGACAO ASSISTIDA

```
┌─────────────────────────────────┐
│           TAREFA                │
└─────────────┬───────────────────┘
              ↓
┌─────────────────────────────────┐
│   BRIEFING (voce escreve 1x)   │
└─────────────┬───────────────────┘
              ↓
┌─────────────────────────────────┐
│       PESSOA EXECUTA            │
└─────────────┬───────────────────┘
              ↓
┌─────────────────────────────────┐
│       IA VALIDA (prompt)        │
└─────────────┬───────────────────┘
              ↓
        ┌─────┴─────┐
        ↓           ↓
   [PASSOU]    [FALHOU]
        ↓           ↓
   ENTREGA   PESSOA AJUSTA
                    ↓
             IA VALIDA de novo
              ↓
        VOCE SO VE O QUE PASSOU
```

---

## OS 5 COMPONENTES

| # | Componente | Funcao | Quem faz |
|---|------------|--------|----------|
| 1 | Tarefa | Define o que fazer | Voce |
| 2 | Briefing | Contexto e restricoes | Voce |
| 3 | Checklist | Criterios de qualidade | Voce |
| 4 | Prompt | IA valida antes de entregar | IA |
| 5 | Output | Exemplo do certo | Voce |

---

## ESCADA DE AUTONOMIA

| Nivel | Descricao | % que voce revisa |
|-------|-----------|-------------------|
| 1 | Fazer e mostrar tudo | 100% |
| 2 | IA valida, voce amostra | 30% |
| 3 | IA valida, voce ve excecoes | 10% |
| 4 | IA valida, voce monitora metricas | 0% |

**Meta:** Subir de nivel conforme a confianca aumenta.

---

## ARTEFATO DA AULA: Template do Modelo de Delegação Assistida

### O Que Você Vai Criar
Template configurado do Modelo de Delegação Assistida com os 5 componentes e escada de autonomia, pronto para preenchimento no exercício da aula 4.5.

### Por Que Isso Importa
O modelo resolve os 4 erros fatais:
- Tarefa clara → evita ambiguidade
- Briefing completo → evita "você sabe"
- Checklist → evita subjetividade
- Prompt IA → evita revisão manual
- Output → evita "não era assim"

**Linha do DRE:** Custo de Escala (quanto você economiza delegando sem virar gargalo)

### Quando Usar
- Ao delegar qualquer tarefa repetitiva
- Ao treinar novos funcionários
- Ao criar padrões para equipe
- Ao evoluir pessoa de nível

### Como Criar
1. Copie o template de 5 componentes
2. Defina o nível de autonomia inicial
3. Preencha no exercício da aula 4.5

### Template

```
MODELO DE DELEGAÇÃO ASSISTIDA: [TAREFA]

1. TAREFA
Descrição + Escopo + O que NÃO inclui

2. BRIEFING
O QUE | POR QUE | PRA QUANDO | NÃO PODE | RECURSOS

3. CHECKLIST DE QUALIDADE
3-5 critérios mensuráveis (sim/não)

4. PROMPT DE VALIDAÇÃO
IA confere antes de entregar

5. OUTPUT ESPERADO
Exemplo do resultado correto

NÍVEL DE AUTONOMIA ATUAL: [ ]1 [ ]2 [ ]3 [ ]4
```

**Escada de Autonomia:**
- Nível 1: Você revisa 100%
- Nível 2: IA valida, você revisa 30%
- Nível 3: IA valida, você vê exceções (10%)
- Nível 4: IA valida, você monitora métricas (0%)

---

**Criar agora?** 📋 Copiar template apenas. Preenchimento na aula 4.5.
**Tempo estimado:** 2 minutos (copiar e configurar)
**Onde salvar:** Notion ou Google Docs

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Fluxograma animado
- Cards dos 5 componentes
- Escada de niveis com cores
- Percentuais de revisao

### Orientacoes
- Explicar o fluxo antes dos componentes
- Enfatizar os niveis de autonomia
- Preparar para a demo

---

**Proxima Aula:** 4.4 - Demonstracao: Modelo Completo
