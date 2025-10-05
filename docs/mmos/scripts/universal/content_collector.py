#!/usr/bin/env python3
"""
Content Collector Universal - Sistema principal para coletar conteúdo de qualquer persona
"""

import os
import sys
import json
import argparse
from datetime import datetime
from youtube_downloader import YouTubeDownloader
from blog_downloader import BlogDownloader

class ContentCollector:
    def __init__(self, persona_name):
        self.persona_name = persona_name
        self.base_dir = f"../../{persona_name}"
        self.config = self.load_config()
        self.report = []

    def load_config(self):
        """Carrega configuração da persona da sua própria pasta"""
        config_path = f"{self.base_dir}/config.json"

        if not os.path.exists(config_path):
            print(f"❌ Arquivo config.json não encontrado em: {config_path}")
            print(f"💡 Crie um config.json na pasta da persona usando o config_template.json como base")
            sys.exit(1)

        with open(config_path, 'r', encoding='utf-8') as f:
            config = json.load(f)

        # Valida se tem os campos mínimos
        if 'name' not in config:
            print(f"❌ Config inválido: campo 'name' obrigatório")
            sys.exit(1)

        return config

    def setup_directories(self):
        """Cria estrutura de diretórios para a persona"""
        dirs = [
            f"{self.base_dir}/content/articles",
            f"{self.base_dir}/content/videos",
            f"{self.base_dir}/content/podcasts",
            f"{self.base_dir}/content/books",
            f"{self.base_dir}/content/social",
            f"{self.base_dir}/analysis",
            f"{self.base_dir}/prompts"
        ]

        for dir_path in dirs:
            os.makedirs(dir_path, exist_ok=True)

        print(f"✅ Estrutura de diretórios criada para {self.config['name']}")

    def download_youtube(self, max_videos=10):
        """Baixa conteúdo do YouTube"""
        print("\n" + "="*60)
        print("🎬 COLETANDO YOUTUBE")
        print("="*60)

        try:
            downloader = YouTubeDownloader(self.persona_name)
            downloader.run(max_videos=max_videos)

            self.report.append(f"## YouTube: {downloader.stats['success']} vídeos baixados")
            return True
        except Exception as e:
            print(f"❌ Erro no YouTube: {e}")
            self.report.append(f"## YouTube: ERRO - {str(e)}")
            return False

    def download_blog(self, max_articles=10):
        """Baixa conteúdo do blog"""
        print("\n" + "="*60)
        print("📝 COLETANDO BLOG")
        print("="*60)

        try:
            downloader = BlogDownloader(self.persona_name)
            downloader.run(max_articles=max_articles)

            self.report.append(f"## Blog: {downloader.stats['success']} artigos baixados")
            return True
        except Exception as e:
            print(f"❌ Erro no Blog: {e}")
            self.report.append(f"## Blog: ERRO - {str(e)}")
            return False

    def analyze_content(self):
        """Analisa todo conteúdo coletado"""
        print("\n" + "="*60)
        print("🔍 ANALISANDO CONTEÚDO")
        print("="*60)

        analysis = {
            "persona": self.persona_name,
            "name": self.config['name'],
            "date": datetime.now().isoformat(),
            "content_stats": {},
            "patterns": {},
            "vocabulary": {}
        }

        # Conta arquivos em cada pasta
        content_dirs = {
            "articles": f"{self.base_dir}/content/articles",
            "videos": f"{self.base_dir}/content/videos",
            "podcasts": f"{self.base_dir}/content/podcasts",
            "books": f"{self.base_dir}/content/books"
        }

        total_files = 0
        for category, path in content_dirs.items():
            if os.path.exists(path):
                json_files = [f for f in os.listdir(path) if f.endswith('.json')]
                analysis["content_stats"][category] = len(json_files)
                total_files += len(json_files)

                # Analisa padrões dos JSONs
                if json_files and category in ['articles', 'videos']:
                    self.analyze_json_files(path, json_files, analysis)

        analysis["content_stats"]["total"] = total_files

        # Salva análise
        analysis_path = f"{self.base_dir}/analysis/content_analysis.json"
        with open(analysis_path, 'w', encoding='utf-8') as f:
            json.dump(analysis, f, ensure_ascii=False, indent=2)

        print(f"✅ Análise salva em: {analysis_path}")
        self.report.append(f"## Análise: {total_files} arquivos analisados")

        return analysis

    def analyze_json_files(self, path, files, analysis):
        """Analisa arquivos JSON para extrair padrões"""
        all_patterns = {}
        word_freq = {}

        for file in files[:20]:  # Analisa até 20 arquivos
            filepath = os.path.join(path, file)
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    data = json.load(f)

                # Agrega padrões
                if 'analysis' in data and 'patterns' in data['analysis']:
                    for pattern, count in data['analysis']['patterns'].items():
                        all_patterns[pattern] = all_patterns.get(pattern, 0) + count

                # Análise de vocabulário se configurado
                if 'patterns' in self.config and 'signature_words' in self.config['patterns']:
                    for word in self.config['patterns']['signature_words']:
                        # Busca no título
                        if 'title' in data and word.lower() in data.get('title', '').lower():
                            word_freq[word] = word_freq.get(word, 0) + 1

            except Exception as e:
                print(f"⚠️ Erro ao analisar {file}: {e}")

        analysis["patterns"] = all_patterns
        analysis["vocabulary"] = word_freq

    def generate_report(self):
        """Gera relatório final"""
        print("\n" + "="*60)
        print("📊 GERANDO RELATÓRIO")
        print("="*60)

        report_content = f"""# RELATÓRIO DE COLETA - {self.config['name']}

**Data**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
**Persona ID**: {self.persona_name}

## Configuração Utilizada

### YouTube
- Canal: {self.config.get('youtube', {}).get('channel_url', 'N/A')}
- Channel ID: {self.config.get('youtube', {}).get('channel_id', 'N/A')}

### Blog
- URL Base: {self.config.get('blog', {}).get('base_url', 'N/A')}
- Archive: {self.config.get('blog', {}).get('archive_url', 'N/A')}

### Padrões Rastreados
- Palavras Signature: {', '.join(self.config.get('patterns', {}).get('signature_words', []))}
- Rastrear Profanidade: {self.config.get('patterns', {}).get('track_profanity', False)}
- Rastrear Perguntas: {self.config.get('patterns', {}).get('track_questions', False)}

## Resultados da Coleta

"""
        report_content += '\n'.join(self.report)

        # Adiciona estatísticas de arquivos
        report_content += "\n\n## Arquivos Coletados\n\n"

        content_dirs = {
            "Artigos": f"{self.base_dir}/content/articles",
            "Vídeos": f"{self.base_dir}/content/videos",
            "Podcasts": f"{self.base_dir}/content/podcasts",
            "Livros": f"{self.base_dir}/content/books"
        }

        for category, path in content_dirs.items():
            if os.path.exists(path):
                files = [f for f in os.listdir(path) if f.endswith('.md')]
                if files:
                    report_content += f"\n### {category} ({len(files)} arquivos)\n"
                    for f in files[:5]:
                        report_content += f"- {f}\n"
                    if len(files) > 5:
                        report_content += f"- ... e mais {len(files)-5} arquivos\n"

        report_content += f"""
---

## Próximos Passos

1. Revisar conteúdo coletado em `/{self.persona_name}/content/`
2. Analisar padrões em `/analysis/content_analysis.json`
3. Criar inferências baseadas nos dados
4. Desenvolver prompt system final

---

*Relatório gerado automaticamente pelo Content Collector Universal*
"""

        # Salva relatório
        report_path = f"{self.base_dir}/RELATORIO_COLETA.md"
        with open(report_path, 'w', encoding='utf-8') as f:
            f.write(report_content)

        print(f"✅ Relatório salvo em: {report_path}")
        print("\n" + report_content)

    def run(self, youtube=True, blog=True, max_items=10):
        """Executa coleta completa"""
        print(f"\n{'='*70}")
        print(f"🚀 CONTENT COLLECTOR - {self.config['name']}")
        print(f"{'='*70}")

        # Setup
        self.setup_directories()

        # Coleta
        if youtube and self.config.get('youtube', {}).get('channel_url'):
            self.download_youtube(max_items)

        if blog and self.config.get('blog', {}).get('base_url'):
            self.download_blog(max_items)

        # Análise
        self.analyze_content()

        # Relatório
        self.generate_report()

        print(f"\n{'='*70}")
        print("✅ COLETA CONCLUÍDA!")
        print(f"{'='*70}")


def list_personas():
    """Lista personas disponíveis baseado nas pastas existentes"""
    base_path = "../../"

    print("\n📋 PERSONAS DISPONÍVEIS:")
    print("-" * 40)

    # Lista todas as pastas
    try:
        folders = [f for f in os.listdir(base_path)
                  if os.path.isdir(os.path.join(base_path, f))
                  and not f.startswith('.')
                  and not f.startswith('0_')]

        for folder in sorted(folders):
            config_path = os.path.join(base_path, folder, 'config.json')
            if os.path.exists(config_path):
                with open(config_path, 'r', encoding='utf-8') as f:
                    config = json.load(f)
                print(f"\n🔸 {folder}")
                print(f"   Nome: {config.get('name', 'N/A')}")
                if config.get('youtube', {}).get('channel_url'):
                    print(f"   YouTube: ✅")
                else:
                    print(f"   YouTube: ❌")
                if config.get('blog', {}).get('base_url'):
                    print(f"   Blog: ✅")
                else:
                    print(f"   Blog: ❌")
    except Exception as e:
        print(f"Erro ao listar personas: {e}")

    print("\n" + "-" * 40)


def main():
    parser = argparse.ArgumentParser(
        description='Content Collector Universal - Coleta conteúdo de qualquer persona',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Exemplos de uso:
  python content_collector.py mark_manson              # Coleta tudo do Mark Manson
  python content_collector.py dan_koe --items 20       # Coleta 20 items do Dan Koe
  python content_collector.py alex_hormozi --youtube   # Só YouTube do Hormozi
  python content_collector.py --list                   # Lista personas disponíveis
        """
    )

    parser.add_argument('persona', nargs='?', help='Nome da persona (ex: mark_manson)')
    parser.add_argument('--youtube', action='store_true', help='Coletar apenas YouTube')
    parser.add_argument('--blog', action='store_true', help='Coletar apenas Blog')
    parser.add_argument('--items', type=int, default=10, help='Número de items por fonte (padrão: 10)')
    parser.add_argument('--list', action='store_true', help='Listar personas disponíveis')

    args = parser.parse_args()

    # Lista personas se solicitado
    if args.list:
        list_personas()
        return

    # Verifica se persona foi fornecida
    if not args.persona:
        print("❌ Erro: Especifique uma persona ou use --list para ver opções")
        parser.print_help()
        return

    # Determina o que coletar
    collect_youtube = True
    collect_blog = True

    if args.youtube and not args.blog:
        collect_blog = False
    elif args.blog and not args.youtube:
        collect_youtube = False

    # Executa coleta
    collector = ContentCollector(args.persona)
    collector.run(
        youtube=collect_youtube,
        blog=collect_blog,
        max_items=args.items
    )


if __name__ == "__main__":
    main()