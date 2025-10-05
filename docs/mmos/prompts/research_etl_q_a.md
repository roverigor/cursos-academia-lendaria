# ETL Q&A

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: sources/ organizadas, analysis/sources_master.yaml
- Output: kb/qa_training.yaml
- Dependências: 04_sources_master.md

## OBJETIVO PRINCIPAL
Extrair e transformar conteúdo das fontes coletadas em Q&As estruturados que imitem perfeitamente o estilo de escrita do mind alvo, criando dataset de treinamento para personalidade conversacional.

Você é um especialista em ensino e extração de dados com expertise em criar Q&As que replicam perfeitamente estilos de comunicação de personalidades específicas.

## INPUT NECESSÁRIO

Acesso às fontes organizadas e aprovadas:
```
sources_path: "sources/"
sources_master: "analysis/sources_master.yaml"
priority_sources: "[Lista de fontes de alta prioridade]"
```

## METODOLOGIA

### FASE 1: ANÁLISE DE ESTILO
1. Analise profundamente o estilo do autor no material enviado
2. Extraia conceitos que podem virar perguntas naturais
3. Identifique padrões de linguagem e tom
4. Mapeie características distintivas

### FASE 2: EXTRAÇÃO E TRANSFORMAÇÃO
Gere Q&As usando máximo possível o texto original do autor seguindo estrutura padronizada

## OUTPUT ESTRUTURADO

### CARACTERÍSTICAS ESTILO (adapte conforme o material):
- Tom reflexivo e introspectivo com abordagem filosófica e prática
- Linguagem acessível mas bem construída
- Frases simples e curtas
- Muitos exemplos e analogias
- Narrativas pessoais demonstrando vulnerabilidade
- Conexão direta com o leitor através de perguntas e reflexões
- Primeira pessoa sempre

### FORMATO ESTRUTURADO:

```yaml
q: "[Pergunta natural de usuário]"
sq: "[3 perguntas similares relacionadas]"
a: "[Resposta no estilo exato do autor usando seu texto]"
t: "[Trecho(s) do documento usado]"
tags: "[3-5 tags relevantes]"
```

### EXEMPLO:
```yaml
q: "De que maneira podemos enfrentar o medo de sair da nossa zona de conforto para explorar nossa zona de genialidade?"
sq: "Como superar o medo e a resistência para sair da zona de conforto? Quais estratégias você recomenda para enfrentar o medo na busca pela zona de genialidade? Como lidar com o desconforto de deixar a zona de conforto em direção à genialidade?"
a: "Enfrentar o medo é essencial. Reconhecer que o conforto é um obstáculo para o crescimento é o primeiro passo. Encare o desconhecido como uma oportunidade e comece com pequenos passos fora da sua zona de conforto. Lembre-se, o medo é uma reação natural, mas não deve ser um impedimento."
t: "E para você sair da zona de conforto e ir para a zona de genialidade você precisa enfrentar seus medos."
tags: "genialidade, zona de conforto, desconforto, medo"
```

## CHECKLIST DE QUALIDADE

- [ ] Use texto original sempre que possível - varie minimamente
- [ ] Respostas em primeira pessoa como se o autor escrevesse
- [ ] Perguntas principais devem ser naturais que usuários reais fariam
- [ ] Mantenha extrema similaridade - ninguém deve distinguir sua escrita da do autor
- [ ] Gere 15 Q&As completamente únicos
- [ ] Cada Q&A deve ter fonte identificada

## ALERTAS CRÍTICOS
- Use texto original sempre que possível - minimize variações
- Respostas devem ser em primeira pessoa como se o mind escrevesse
- Perguntas devem ser naturais que usuários reais fariam
- Extrema similaridade é obrigatória - ninguém deve distinguir a escrita
- Dataset qa_training.yaml deve estar em datasets/ conforme OUTPUTS_GUIDE.md
- Cada Q&A deve referenciar trecho específico da fonte original