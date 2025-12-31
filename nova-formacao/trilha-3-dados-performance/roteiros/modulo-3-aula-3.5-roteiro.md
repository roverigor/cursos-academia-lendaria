# ROTEIRO DE FALA - AULA 3.5

**Aula:** Configurando Seu Primeiro Alerta
**Módulo:** 3 - Alertas Inteligentes
**Duração:** 15 minutos
**Tipo:** Demo (Demonstração ao Vivo)

---

## [ABERTURA] - 30 segundos

**[PROFESSOR DIZ:]**

> Essa é a aula mais técnica do módulo.
>
> Você vai me ver configurando um alerta do zero até funcionar.
>
> Da planilha até a mensagem chegando no WhatsApp.
>
> Cada clique. Cada configuração.

---

## [SETUP] - 1 minuto

**[MOSTRAR NA TELA:]**
n8n aberto + planilha de exemplo

**[PROFESSOR DIZ:]**

> Vou criar um alerta de crise.
>
> Quando o faturamento diário cair mais de 30% comparado com a média, quero ser avisado.
>
> Tenho uma planilha com faturamento dos últimos 30 dias.
>
> Tenho o n8n instalado e conectado na Evolution API.
>
> Vamos lá.

---

## [PASSO 1: CRIAR WORKFLOW] - 2 minutos

**[PROFESSOR DIZ:]**

> No n8n, clico em "Add workflow".
>
> Dou um nome: "Alerta de Crise - Faturamento".
>
> O workflow começa com um trigger. O que dispara a verificação.
>
> Vou usar "Schedule Trigger" — roda de tempos em tempos.
>
> Configuro pra rodar todo dia às 10h.
>
> Assim, todo dia de manhã ele verifica.

**[MOSTRAR NA TELA:]**
Configuração do trigger

---

## [PASSO 2: BUSCAR DADOS] - 3 minutos

**[PROFESSOR DIZ:]**

> Próximo passo: buscar os dados da planilha.
>
> Adiciono um node "Google Sheets".
>
> Operação: "Read rows".
>
> Seleciono minha planilha, seleciono a aba.
>
> Ele vai trazer todas as linhas.
>
> (pausa de 2 segundos)
>
> Agora preciso calcular a média e comparar com hoje.
>
> Adiciono um node "Code" pra fazer a lógica.

**[MOSTRAR NA TELA:]**
```javascript
// Pega faturamento de hoje
const hoje = $input.all()[0].json.faturamento;

// Calcula média dos últimos 30 dias
const todos = $input.all();
const soma = todos.reduce((acc, item) => acc + item.json.faturamento, 0);
const media = soma / todos.length;

// Calcula variação
const variacao = ((hoje - media) / media) * 100;

// Retorna se precisa alertar
return [{
  json: {
    precisa_alertar: variacao < -30,
    hoje: hoje,
    media: media,
    variacao: variacao.toFixed(1)
  }
}];
```

**[PROFESSOR DIZ:]**

> Esse código pega o faturamento de hoje, calcula a média, e vê se caiu mais de 30%.
>
> Se caiu, retorna "precisa_alertar: true".

---

## [PASSO 3: CONDIÇÃO] - 2 minutos

**[PROFESSOR DIZ:]**

> Agora adiciono um "IF" node.
>
> Condição: se precisa_alertar for verdadeiro.
>
> Se sim, segue pro WhatsApp.
>
> Se não, para aqui. Não faz nada.

**[MOSTRAR NA TELA:]**
Configuração do IF

---

## [PASSO 4: ENVIAR WHATSAPP] - 3 minutos

**[PROFESSOR DIZ:]**

> No caminho do "sim", adiciono o node da Evolution API.
>
> Operação: "Send Message".
>
> Número: meu celular.
>
> Mensagem: vou montar dinâmica.

**[MOSTRAR NA TELA:]**
```
🚨 ALERTA DE CRISE - FATURAMENTO

Faturamento de hoje: R$ {{ $json.hoje }}
Média dos últimos 30 dias: R$ {{ $json.media }}
Variação: {{ $json.variacao }}%

⚠️ Faturamento está 30% abaixo da média!
```

**[PROFESSOR DIZ:]**

> Olha só. A mensagem usa os dados que calculamos.
>
> Vai chegar no meu WhatsApp com os números reais.

---

## [PASSO 5: TESTAR] - 2 minutos

**[PROFESSOR DIZ:]**

> Agora o teste.
>
> Clico em "Execute workflow".
>
> Ele roda todos os passos.
>
> (pausa de 3 segundos)
>
> Olha o meu celular.

**[MOSTRAR NA TELA:]**
Celular com mensagem recebida

**[PROFESSOR DIZ:]**

> Chegou!
>
> "Alerta de Crise - Faturamento. Faturamento está 30% abaixo da média."
>
> Funcionou.
>
> Agora todo dia às 10h, o n8n vai verificar.
>
> Se cair, eu recebo mensagem.
>
> Se estiver normal, silêncio.

---

## [AÇÃO RÁPIDA] - 30 segundos

**[PROFESSOR DIZ:]**

> Sua ação rápida.
>
> Cria um workflow simples no n8n.
>
> Pode ser só um trigger que manda "teste" pro seu WhatsApp.
>
> O objetivo é ver a mensagem chegando.
>
> Se funcionar, você está pronto pra criar alertas de verdade.

---

## [HOOK PRÓXIMA AULA] - 30 segundos

**[PROFESSOR DIZ:]**

> Você viu como criar um alerta.
>
> Agora é sua vez de criar os 3.
>
> Na próxima aula, você vai configurar seus 3 alertas: Crise, Tendência e Meta.
>
> Eu vou te guiar passo a passo.
>
> Te vejo lá.

---

## NOTAS DE PRODUÇÃO

- **Formato:** Screencast ao vivo
- **Slides:** Nenhum (tudo no n8n)
- **Recursos:** n8n, planilha de exemplo, Evolution API
- **Tom:** Técnico mas acessível
- **Energia:** Alta

---

*Roteiro Aula 3.5 - Trilha 3 - Academia Lendária*
