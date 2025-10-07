# /collect-all-sources Task

Execute o workflow completo de coleta paralela do ETL Data Collector.

```yaml
purpose: "Rodar parallel-collector em modo batching, respeitando regras e checkpoints"
prerequisites:
  - ASSEMBLYAI_API_KEY exportada
  - Credenciais de redes sociais configuradas conforme download-rules
  - Arquivo de fontes (sources.yaml ou sources_master.yaml transformado)
  - Dependências Node instaladas (npm install executado na pasta do pack)
  - Cursor Agent e Claude CLI disponíveis no PATH
interactive: true
```

## Elicitação
```
1. Qual arquivo de fontes devemos usar? (ex.: docs/minds/sam_altman/sources/sources.yaml)
2. Deseja executar apenas Tier 1 ou todos os tiers? (tier1|all)
3. Confirmar diretório de output (padrão: docs/minds/{mind}/sources)
4. Deseja permitir scraping de Twitter? (sim/não)
```

## Passos de Execução
1. Validar respostas e atualizar `integration-mm.yaml` ou `download-rules.yaml` temporariamente se necessário
2. Gerar arquivo temporário `_etl_sources.yaml` se entrada for `sources_master.yaml`
3. Rodar comando via Claude CLI:
   ```bash
   claude --print --model sonnet "Execute parallel collector" --allowed-tools "Bash(node:*)" --mcp-config expansion-packs/etl-data-collector/config/mcp-config.yaml
   ```
   ou usar `cursor-agent` quando preferir automação CLI
4. Monitorar progresso, coletar relatório final (stdout JSON)
5. Persistir relatório em `{outputDir}/etl-report.json`
6. Registrar resultados no `sources_master.yaml` (status: COLLECTED/FAILED)
7. Limpar arquivos temporários

## Validação
- [ ] Todas as fontes processadas (success+fail = total)
- [ ] Relatório JSON salvo no output
- [ ] Falhas documentadas com motivo (URL inválida, 404, rate limit)
- [ ] Custos estimados reportados quando houve transcrição
- [ ] Arquivo `sources_master.yaml` atualizado

## Erros Comuns
- Vídeos indisponíveis (resolver com mirror URL ou download manual)
- Twitter scraping bloqueado (habilitar allow_scrape e fornecer cookies/API)
- Falhas em PDF OCR (instalar tesseract dependências)
- Ausência de dependências Node (rodar `npm install` na pasta do pack)

## Resultado Esperado
```
✅ Coleta concluída
- 12 fontes processadas (4 sucesso, 8 falhas registradas)
- Relatório salvo em docs/minds/sam_altman/sources/etl-report.json
- Custos AssemblyAI: $12.34 (estimativa)
```
