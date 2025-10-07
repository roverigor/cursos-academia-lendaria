# /collect-youtube Task

```yaml
purpose: "Rodar o YouTubeCollector para baixar áudio, gerar transcrição e aplicar filtro de entrevistado"
prerequisites:
  - URL ou ID válido do YouTube
  - ASSEMBLYAI_API_KEY configurado
  - Dependências Node instaladas
  - ytdl-core funcional (ou fallback MCP YouTube Transcript)
interactive: true
```

## Elicitação
```
1. Informe o URL/ID do vídeo
2. Deseja salvar áudio além das transcrições? (sim/não)
3. Quer usar diarização/filtro de entrevistado? (sim/não)
4. Pasta de destino (default: {outputDir}/youtube/{videoId})
```

## Execução
1. Validar URL via `YouTubeCollector._isValidUrl`
2. Download com `ytdl-core`; se falhar, tentar fallback (annotation)
3. Chamar `AssemblyAIMCP.transcribe` com opções de diarização/filtro
4. Gerar markdowns (filtered, full) + metadata JSON
5. Persistir arquivos e limpar temporários

## Validação
- [ ] Markdown salvo e contém frontmatter + estatísticas de diarização
- [ ] Metadata JSON com duração e custo
- [ ] Registro em relatório cumulativo
```
