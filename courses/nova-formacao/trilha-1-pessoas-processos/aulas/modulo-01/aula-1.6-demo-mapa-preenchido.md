# AULA 1.6 | Demonstracao: Mapa Preenchido

## Modulo 1 - Onde Sua Empresa Depende de Pessoas | Trilha 1

---

## FICHA DA AULA

| Campo | Valor |
|-------|-------|
| **Duracao** | 6 minutos |
| **Tipo** | Demo |
| **Formato** | Video |
| **Entregavel** | Ver mapa completo preenchido |

---

## OBJETIVO DA AULA

Aluno ve:
- Mapa sendo preenchido em tempo real
- Exemplo concreto com empresa real
- Padroes que emergem do mapa
- Como identificar acoes prioritarias

---

## ROTEIRO DE GRAVACAO

[TELA: Mapa sendo preenchido em tempo real]

[CONTEXTO - 30s]
Locucao: "Empresa exemplo: Loja de eletronicos.
R$ 200K/mes. 8 pessoas.
Vou preencher linha por linha."

---

[TELA: Cada linha aparece conforme narrada]

[PREENCHIMENTO - 4 min]
Locucao: "FUNCAO: Vendas
PESSOA: Maria
SE SAIR: Pipeline para, leads esfriam, perco R$ 30K/mes
HORAS: 40h/semana
DOCUMENTADO: Nao
BACKUP: Nao
RISCO: ALTO

FUNCAO: Financeiro
PESSOA: Joao
SE SAIR: Pagamentos atrasam, multas
HORAS: 25h/semana
DOCUMENTADO: Parcial - tem planilha, mas nao tem processo
BACKUP: Nao
RISCO: ALTO

FUNCAO: Atendimento
PESSOA: Ana
SE SAIR: Clientes sem resposta rapida
HORAS: 40h/semana
DOCUMENTADO: Nao
BACKUP: Sim - Carla sabe fazer
RISCO: MEDIO

FUNCAO: TI
PESSOA: Carlos
SE SAIR: Sistemas fora, ninguem resolve
HORAS: 20h/semana
DOCUMENTADO: Nao
BACKUP: Nao
RISCO: ALTO

FUNCAO: Dono
PESSOA: Eu
SE SAIR: Decisoes param, empresa estagna
HORAS: 50h/semana
DOCUMENTADO: Nao
BACKUP: Nao
RISCO: ALTO"

---

[TELA: Destaques visuais nos padroes]

[ANALISE - 1 min]
Locucao: "Olha o padrao que aparece:
- 4 funcoes com risco ALTO
- Todas com DOCUMENTADO = Nao
- Quase todas sem BACKUP

A solucao fica obvia:
1. Documentar Maria, Carlos, Joao
2. Criar backup para cada um

Isso e o trabalho dos proximos modulos."

---

[TRANSICAO - 30s]
Locucao: "Agora e sua vez de fazer o mapa completo."

---

## MAPA PREENCHIDO (EXEMPLO)

| Funcao | Pessoa | Se Sair... | Horas | Doc? | Backup? | Risco |
|--------|--------|------------|-------|------|---------|-------|
| Vendas | Maria | Pipeline para, -R$ 30K/mes | 40h | N | N | **ALTO** |
| Financeiro | Joao | Pagamentos atrasam, multas | 25h | P | N | **ALTO** |
| Atendimento | Ana | Clientes sem resposta | 40h | N | S | MEDIO |
| TI | Carlos | Sistemas fora | 20h | N | N | **ALTO** |
| Dono | Eu | Decisoes param | 50h | N | N | **ALTO** |

**Padroes Identificados:**
- 4 de 5 funcoes em risco ALTO
- 100% sem documentacao completa
- 80% sem backup

**Acoes Prioritarias:**
1. Documentar vendas (Maria)
2. Documentar TI (Carlos)
3. Criar backup para financeiro (Joao)

---

## ARTEFATO DA AULA: Análise de Padrões do Mapa

### O Que Você Vai Criar
Anotações dos padrões que você identificar ao assistir o preenchimento do mapa-exemplo, aplicados à sua realidade.

### Por Que Isso Importa
A ANÁLISE é mais importante que o mapa em si:
- Padrão "todos sem documentação" = problema de processo
- Padrão "todos sem backup" = problema de dependência
- Padrão "tudo concentrado em 1 pessoa" = gargalo único

**Linha do DRE:** Custo de Análise Errada (agir no sintoma, não na causa)

### Quando Usar
- Depois de preencher seu próprio mapa
- Ao revisar mapas de outros setores
- Para justificar investimento em documentação

### Como Criar
1. Assista a demo prestando atenção nos padrões
2. Anote: qual padrão aparece no exemplo?
3. Compare: esse padrão existe na minha empresa?
4. Defina: qual seria minha primeira ação?

### Template

| Padrão Observado na Demo | Existe na Minha Empresa? | Primeira Ação |
|--------------------------|--------------------------|---------------|
| Todos ALTO sem documentação | [ ] Sim [ ] Não | _____________ |
| Sem backup em funções críticas | [ ] Sim [ ] Não | _____________ |
| Concentração em 1-2 pessoas | [ ] Sim [ ] Não | _____________ |

**Insight principal:** _____________

---

**Criar agora?** 📋 Durante a aula, enquanto assiste a demo.
**Tempo estimado:** 6 minutos (durante o vídeo)
**Onde salvar:** Junto com seu template do Mapa

---

## NOTAS DE PRODUCAO

### Elementos Visuais
- Mapa aparecendo linha por linha
- Destaques em vermelho para ALTO
- Setas conectando padroes
- Resumo visual no final

### Orientacoes
- Preencher em tempo real (nao slide pronto)
- Pausar para enfatizar padroes
- Deixar claro que e exemplo, aluno fara o dele

---

**Proxima Aula:** 1.7 - Exercicio: Seu Mapa Completo
