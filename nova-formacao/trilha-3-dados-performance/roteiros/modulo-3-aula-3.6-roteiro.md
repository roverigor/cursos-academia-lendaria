# ROTEIRO DE FALA - AULA 3.6

**Aula:** Seu Turno: Configure 3 Alertas
**Módulo:** 3 - Alertas Inteligentes
**Duração:** 20 minutos
**Tipo:** Exercício (Prática Guiada)

---

## [ABERTURA] - 30 segundos

**[PROFESSOR DIZ:]**

> Chegou sua hora.
>
> São 20 minutos pra configurar seus 3 alertas.
>
> 1 de Crise. 1 de Tendência. 1 de Meta.
>
> Abre o n8n e vamos.

---

## [PREPARAÇÃO] - 1 minuto

**[PROFESSOR DIZ:]**

> Antes de começar, checa 3 coisas:
>
> **1.** n8n está funcionando?
>
> **2.** Evolution API está conectada?
>
> **3.** Você tem sua lista de 3 alertas definida?
>
> Se faltou algo, pausa e resolve antes de continuar.

---

## [ALERTA 1: CRISE] - 6 minutos

**[PROFESSOR DIZ:]**

> Primeiro, o alerta de Crise.
>
> Esse é o mais importante. Ação imediata quando algo grave acontece.
>
> Pensa: qual situação exige que você saiba NA HORA?

**[MOSTRAR NA TELA:]**

```
EXEMPLOS DE ALERTA DE CRISE

- Faturamento zerou
- Churn passou de 10% no mês
- Sistema fora do ar
- Cliente VIP reclamou
- Estoque de produto chave zerou
```

**[PROFESSOR DIZ:]**

> Escolhe UM.
>
> Abre o n8n.
>
> Cria um workflow novo: "Alerta de Crise - [seu tema]".
>
> Configura o trigger pra rodar a cada hora ou todo dia de manhã.
>
> Adiciona o node do Google Sheets pra buscar dados.
>
> Adiciona a lógica de verificação.
>
> Adiciona o IF: se condição de crise, manda WhatsApp.
>
> Pausa o vídeo e faz agora.
>
> (pausa de 5 segundos)
>
> Quando terminar, testa. Verifica se a mensagem chega.
>
> Funcionou? Próximo alerta.

---

## [ALERTA 2: TENDÊNCIA] - 6 minutos

**[PROFESSOR DIZ:]**

> Agora o alerta de Tendência.
>
> Esse te avisa ANTES de virar crise. Padrão preocupante.

**[MOSTRAR NA TELA:]**

```
EXEMPLOS DE ALERTA DE TENDÊNCIA

- 3 dias seguidos de queda de vendas
- Churn subindo há 2 semanas
- Conversão caiu 20% na última semana
- Tempo de resposta ao cliente aumentando
- Reclamações subindo no mês
```

**[PROFESSOR DIZ:]**

> A diferença do de crise: aqui você olha TENDÊNCIA, não só um número.
>
> Precisa comparar com dias anteriores.
>
> Escolhe um.
>
> Cria o workflow.
>
> A lógica vai ser parecida, mas olhando padrão de vários dias.
>
> Exemplo: se caiu 3 dias seguidos.
>
> Pausa e faz.
>
> (pausa de 5 segundos)

---

## [ALERTA 3: META] - 5 minutos

**[PROFESSOR DIZ:]**

> Por fim, o alerta de Meta.
>
> Esse é positivo. Te avisa do progresso.

**[MOSTRAR NA TELA:]**

```
EXEMPLOS DE ALERTA DE META

- Batemos 80% da meta do mês
- Recorde de vendas no dia
- 100 clientes novos no mês
- Faturamento passou de R$ X
- NPS acima de 70
```

**[PROFESSOR DIZ:]**

> Esse é o mais simples.
>
> Se número X for maior que meta Y, avisa.
>
> A mensagem pode ser celebratória.
>
> "🎉 Parabéns! Batemos 80% da meta com 10 dias de antecedência!"
>
> Cria o workflow e testa.
>
> (pausa de 5 segundos)

---

## [REVISÃO] - 1 minuto

**[PROFESSOR DIZ:]**

> Terminou os 3?
>
> Vamos checar.

**[MOSTRAR NA TELA:]**

```
CHECKLIST DOS ALERTAS

□ Alerta de CRISE configurado e testado?
□ Alerta de TENDÊNCIA configurado e testado?
□ Alerta de META configurado e testado?
□ Todos os 3 estão ativos no n8n?
□ Você recebeu mensagem de teste em cada um?
```

**[PROFESSOR DIZ:]**

> Se marcou tudo, parabéns.
>
> Você tem um sistema de alertas funcionando.
>
> Se faltou algo, completa antes da próxima aula.

---

## [AÇÃO RÁPIDA] - 30 segundos

**[PROFESSOR DIZ:]**

> Sua ação rápida.
>
> Tira um print dos seus 3 workflows ativos.
>
> Guarda como prova de que você fez.
>
> Isso é seu sistema de alerta funcionando.

---

## [HOOK PRÓXIMA AULA] - 30 segundos

**[PROFESSOR DIZ:]**

> Você configurou os alertas.
>
> Mas como saber se estão funcionando de verdade?
>
> Na próxima aula, vamos testar cada um.
>
> Vou te mostrar como simular cenários de crise pra ver o alerta funcionar.
>
> E depois, vamos pro Módulo 4: IA como seu analista de dados.
>
> Te vejo lá.

---

## NOTAS DE PRODUÇÃO

- **Formato:** Tela dividida (instruções + n8n)
- **Slides:** Exemplos por tipo de alerta
- **Recursos:** n8n, Evolution API
- **Tom:** Coach, motivador
- **Energia:** Alta

---

*Roteiro Aula 3.6 - Trilha 3 - Academia Lendária*
