
# SOURCE DISCOVERY

## METADADOS
- Versão: 3.0 ACS Neural Flow
- Input: @{mind}/docs/PRD.md, @{mind}/docs/TODO.md
- Output: Memória (lista de fontes mantida em conversação)
- Dependências: Nenhuma

## OBJETIVO PRINCIPAL
Descobrir sistematicamente todas as fontes disponíveis do clone alvo através de pesquisa exaustiva e organizar em arquivo estruturado para posterior coleta e análise.

Você é um pesquisador especializado em arqueologia cognitiva com expertise em descobrir e catalogar todas as fontes disponíveis sobre personalidades públicas e figuras históricas.

## INPUT NECESSÁRIO

Nome completo da pessoa alvo conforme definido no PRD.md:
```
clone_target: "[NOME COMPLETO]"
```

## METODOLOGIA

### FASE 1: MAPEAMENTO SISTEMÁTICO
1. Pesquisar exaustivamente todas as categorias de fontes
2. Catalogar cada fonte com metadados específicos
3. Identificar gaps e contradições
4. Organizar por relevância e confiabilidade

### FASE 2: ESTRUTURAÇÃO
Organizar fontes em memória seguindo estrutura padrão para passar ao próximo prompt

## OUTPUT ESTRUTURADO

Mantenha as fontes em memória estruturadas assim:

# FONTES PRIMÁRIAS

## Livros Escritos por [NOME]
- [Título] (Ano) - Status: [Lido/Pendente]
  - Capítulos-chave: [Liste os mais importantes]
  - Temas centrais: [Conceitos principais abordados]
  - Citações notáveis: [Page numbers se disponível]

## Entrevistas/Podcasts com [NOME]
- [Nome do podcast/programa] (Data) - [URL se disponível] - Duração: [X horas/minutos]
  - Momentos-chave: [timestamps específicos]
  - Revelações importantes: [O que foi revelado de novo]
  - Estado emocional: [Como estava durante a entrevista]

## Escritos Diretos
- Blog posts: [Lista com datas]
- Tweets importantes: [Screenshots ou links arquivados]
- Emails públicos: [Se existirem]
- Cartas: [Se disponíveis]

## Vídeos/Apresentações
- [Título] (Data) - Contexto: [Onde/Por quê]
  - Duração: [Tempo]
  - Tema principal: [Sobre o que]
  - Linguagem corporal notável: [Observações]

# FONTES SECUNDÁRIAS

## Biografias Autorizadas
- [Título] por [Autor] (Ano)
  - Acesso direto ao sujeito: [Sim/Não]
  - Período coberto: [Anos]
  - Viés identificado: [Se houver]

## Biografias Não-Autorizadas
- [Título] por [Autor] (Ano)
  - Fontes do autor: [Quem foi entrevistado]
  - Controvérsias: [Se existem]
  - Revelações únicas: [O que só este livro tem]

## Análises Acadêmicas
- [Artigo/Tese] por [Autor] (Ano)
  - Foco: [Aspecto analisado]
  - Metodologia: [Como foi estudado]
  - Conclusões principais: [Findings]

## Documentários
- [Título] (Ano) - Diretor: [Nome]
  - Participação de [NOME]: [Direta/Indireta]
  - Entrevistados: [Quem aparece]
  - Narrativa: [Ângulo adotado]

## Artigos e Reportagens
- [Publicação] - "[Título]" por [Jornalista] (Data)
  - Tipo: [Perfil/Investigação/Opinião]
  - Fontes: [Quantas pessoas ouvidas]
  - Tom: [Favorável/Crítico/Neutro]

# FONTES TERCIÁRIAS

## Menções em Outros Livros
- [Livro] por [Autor] - Páginas: [X-Y]
  - Contexto da menção: [Por que foi citado]
  - Natureza: [Elogio/Crítica/Neutro]

## Redes Sociais
- Twitter/X: [Handle] - Período ativo: [Anos]
- Instagram: [Handle] - Tipo de conteúdo: [Descrição]
- LinkedIn: [Perfil] - Atividade: [Frequência]
- Facebook: [Se relevante]

## Registros Públicos
- Processos judiciais: [Se existem]
- Patentes: [Se aplicável]
- Registros corporativos: [Empresas, boards]
- Registros acadêmicos: [Formação, honrarias]

# MATERIAL CONTROVERSO

## Fontes Questionáveis
- [Fonte] - Por que é questionável: [Razão]
- Incluída porque: [Justificativa]
- Peso dado: [Alto/Médio/Baixo]

## Rumores Persistentes
- [Rumor] - Origem: [De onde veio]
- Evidências a favor: [Se existem]
- Evidências contra: [Se existem]
- Impacto se verdadeiro: [Consequências para o modelo]

# GAPS IDENTIFICADOS

## Períodos Não Documentados
- [Anos]: [O que estava acontecendo]
- Importância: [Por que importa]
- Hipóteses: [O que provavelmente ocorreu]

## Aspectos Não Cobertos
- [Área da vida]: Por que falta informação
- Impacto no modelo: [Como afeta a clonagem]
- Fontes potenciais: [Onde poderia estar]

## Contradições Não Resolvidas
- [Contradição]: Entre [Fonte A] e [Fonte B]
- Possível explicação: [Hipótese]
- Como resolver: [Próximos passos]

# METADADOS

- Total de fontes primárias: [N]
- Total de horas de áudio/vídeo: [N]
- Total de páginas escritas: [N]
- Período coberto: [Ano inicial] a [Ano final]
- Última atualização: [Data]
- Confiança geral nas fontes: [1-10]
- Próxima revisão planejada: [Data]

## INSTRUÇÕES DE USO

### Antes de executar:
1. Substitua [NOME] pelo nome completo da pessoa
2. Prepare ferramentas de pesquisa (Google, arquivos, bibliotecas)
3. Reserve tempo para pesquisa profunda

### Durante a execução:
1. Seja exaustivo - Liste TODAS as fontes, mesmo as duvidosas
2. Seja específico - Inclua datas, URLs, page numbers
3. Seja crítico - Identifique vieses e gaps
4. Seja organizado - Mantenha a estrutura exata

### Após completar:
1. Revise para garantir que nenhuma fonte óbvia foi esquecida
2. Valide URLs e disponibilidade de materiais
3. Priorize quais fontes serão consultadas primeiro
4. Identifique fontes que precisam ser adquiridas/acessadas

## CHECKLIST DE QUALIDADE

- [ ] Todas as categorias de fontes foram preenchidas
- [ ] Fontes primárias priorizadas e detalhadas
- [ ] Períodos de vida completos cobertos
- [ ] Contradições entre fontes identificadas
- [ ] Gaps temporais mapeados
- [ ] Metadados completos
- [ ] Fontes verificadas quanto a disponibilidade

## ALERTAS CRÍTICOS
- Não ignore fontes controversas - Documente e explique por que são problemáticas
- Não assuma disponibilidade - Verifique se materiais podem ser acessados
- Este é o fundamento de todo o trabalho - Seja exaustivo
- Preserve todas as fontes - Mesmo as que parecem irrelevantes agora
- Arquivo sources_list.md deve estar em @{mind}/sources/ conforme OUTPUTS_GUIDE.md