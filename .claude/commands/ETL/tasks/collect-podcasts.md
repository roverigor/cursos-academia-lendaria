# /collect-podcasts Task

```yaml
purpose: "Coletar episódios de podcast via RSS ou URL direto"
prerequisites:
  - URL de feed/episódio
  - ASSEMBLYAI_API_KEY
  - Dependências Node instaladas
interactive: true
```

## Elicitação
```
1. Forneça URL do feed ou episódio
2. Limitar por data/episódios? (ex.: últimos 3)
3. Pasta de saída (default: {outputDir}/podcasts)
```

## Execução
1. Parsear RSS com `rss-parser`
2. Download de áudio (salvar .mp3)
3. Transcrever com AssemblyAI e gerar markdown filtered/full
4. Salvar metadata (título, duração, feed info)
```
