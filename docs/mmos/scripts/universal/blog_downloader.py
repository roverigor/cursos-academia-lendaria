#!/usr/bin/env python3
"""
Blog Downloader Universal - Funciona para qualquer persona
"""

import os
import json
import time
import re
import argparse
from datetime import datetime
import requests
from bs4 import BeautifulSoup
import markdownify

class BlogDownloader:
    def __init__(self, persona_name):
        self.persona_name = persona_name
        self.config = self.load_config()
        self.output_dir = f"../../{self.persona_name}/content/articles"
        self.stats = {"success": 0, "failed": 0, "total": 0}
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'
        }

    def load_config(self):
        """Carrega configuração da persona da sua própria pasta"""
        config_path = f"../../{self.persona_name}/config.json"

        if not os.path.exists(config_path):
            raise ValueError(f"Config não encontrado em: {config_path}\nCrie um config.json usando o template")

        with open(config_path, 'r', encoding='utf-8') as f:
            config = json.load(f)

        if 'name' not in config:
            raise ValueError("Config inválido: campo 'name' obrigatório")

        return config

    def create_output_dir(self):
        """Cria diretório de output"""
        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)
            print(f"✅ Diretório {self.output_dir} criado")

    def extract_article_content(self, url):
        """Extrai conteúdo de um artigo"""
        try:
            response = requests.get(url, headers=self.headers, timeout=10)
            response.raise_for_status()

            soup = BeautifulSoup(response.content, 'html.parser')

            # Usa seletores da config ou padrão
            blog_config = self.config.get('blog', {})

            # Tenta seletores customizados primeiro
            content_selectors = []
            if blog_config.get('content_selector'):
                content_selectors.append(blog_config['content_selector'])
            if blog_config.get('article_selector'):
                content_selectors.append(blog_config['article_selector'])

            # Adiciona seletores padrão
            content_selectors.extend([
                'article',
                '.post-content',
                '.entry-content',
                '.article-content',
                '[class*="content"]',
                'main',
                '[role="main"]'
            ])

            article_content = None
            for selector in content_selectors:
                try:
                    article_content = soup.select_one(selector)
                    if article_content:
                        break
                except:
                    continue

            if not article_content:
                # Tenta regex como última opção
                article_content = soup.find('div', class_=re.compile('content|article|post|entry'))

            if not article_content:
                print(f"⚠️ Conteúdo não encontrado")
                return None

            # Extrai metadata
            metadata = self.extract_metadata(soup)

            # Remove elementos desnecessários
            for elem in article_content.find_all(['script', 'style', 'aside', 'nav', 'header', 'footer']):
                elem.decompose()

            # Extrai estrutura
            structure = self.analyze_article_structure(article_content)

            # Converte para markdown (limitado para não violar copyright)
            text_content = article_content.get_text(separator='\n', strip=True)

            # Extrai apenas trechos para análise
            excerpts = self.extract_excerpts(text_content)

            return {
                "url": url,
                "metadata": metadata,
                "structure": structure,
                "excerpts": excerpts,
                "word_count": len(text_content.split())
            }

        except requests.RequestException as e:
            print(f"❌ Erro de requisição: {e}")
            return None
        except Exception as e:
            print(f"❌ Erro ao processar: {e}")
            return None

    def extract_metadata(self, soup):
        """Extrai metadata da página"""
        metadata = {
            "title": None,
            "author": self.config.get('name', 'Unknown'),
            "date": None,
            "description": None,
            "keywords": [],
            "categories": []
        }

        # Título
        title_elem = soup.find('h1')
        if not title_elem:
            title_elem = soup.find('title')
        if title_elem:
            metadata["title"] = title_elem.get_text().strip()

        # Data
        date_selectors = [
            'time[datetime]',
            '.date',
            '.publish-date',
            '.post-date',
            '[class*="date"]'
        ]
        for selector in date_selectors:
            date_elem = soup.select_one(selector)
            if date_elem:
                metadata["date"] = date_elem.get('datetime') or date_elem.get_text().strip()
                break

        # Description
        meta_desc = soup.find('meta', {'name': 'description'}) or \
                   soup.find('meta', {'property': 'og:description'})
        if meta_desc:
            metadata["description"] = meta_desc.get('content', '')[:500]

        # Keywords
        meta_keywords = soup.find('meta', {'name': 'keywords'})
        if meta_keywords:
            metadata["keywords"] = [k.strip() for k in meta_keywords.get('content', '').split(',')][:10]

        # Categorias/Tags
        tags = soup.find_all('a', {'rel': 'tag'}) or \
               soup.find_all('a', href=re.compile('/tag/|/category/'))
        metadata["categories"] = [tag.get_text().strip() for tag in tags[:10]]

        return metadata

    def analyze_article_structure(self, content):
        """Analisa estrutura do artigo"""
        structure = {
            "headings": [],
            "paragraphs": 0,
            "lists": 0,
            "quotes": 0,
            "links": 0,
            "images": 0,
            "patterns": {}
        }

        # Headings
        for h in content.find_all(['h1', 'h2', 'h3', 'h4'])[:20]:  # Limita a 20
            structure["headings"].append({
                "level": h.name,
                "text": h.get_text().strip()[:100]
            })

        # Contadores
        structure["paragraphs"] = len(content.find_all('p'))
        structure["lists"] = len(content.find_all(['ul', 'ol']))
        structure["quotes"] = len(content.find_all('blockquote'))
        structure["links"] = len(content.find_all('a'))
        structure["images"] = len(content.find_all('img'))

        # Análise de padrões baseada na persona
        if "patterns" in self.config:
            text = content.get_text().lower()
            patterns = self.config["patterns"]

            # Palavras signature
            if "signature_words" in patterns:
                for word in patterns["signature_words"]:
                    count = text.count(word.lower())
                    if count > 0:
                        structure["patterns"][word] = count

            # Profanidade se configurado
            if patterns.get("track_profanity", False):
                profanity_count = sum(text.count(w) for w in ["fuck", "shit", "damn"])
                if profanity_count > 0:
                    structure["patterns"]["profanity"] = profanity_count

            # Perguntas se configurado
            if patterns.get("track_questions", False):
                structure["patterns"]["questions"] = content.get_text().count("?")

        return structure

    def extract_excerpts(self, text, max_length=2000):
        """Extrai trechos representativos do texto"""
        excerpts = {
            "opening": "",
            "middle": "",
            "closing": ""
        }

        lines = text.split('\n')
        total_lines = len(lines)

        if total_lines > 0:
            # Abertura (primeiras linhas)
            opening_lines = lines[:min(10, total_lines)]
            excerpts["opening"] = '\n'.join(opening_lines)[:max_length//3]

            # Meio (linhas do meio)
            if total_lines > 20:
                middle_start = total_lines // 2 - 5
                middle_end = middle_start + 10
                middle_lines = lines[middle_start:middle_end]
                excerpts["middle"] = '\n'.join(middle_lines)[:max_length//3]

            # Fechamento (últimas linhas)
            if total_lines > 10:
                closing_lines = lines[-10:]
                excerpts["closing"] = '\n'.join(closing_lines)[:max_length//3]

        return excerpts

    def save_article(self, article_data, slug):
        """Salva artigo em arquivo"""
        if not article_data:
            return False

        # Nome do arquivo
        title = article_data['metadata'].get('title', slug)
        safe_title = "".join(c for c in title if c.isalnum() or c in (' ', '-', '_')).rstrip()[:80]

        # Prepara conteúdo
        content = f"""# {article_data['metadata'].get('title', 'Untitled')}

## Metadata
- **Persona**: {self.config['name']}
- **URL**: {article_data['url']}
- **Autor**: {article_data['metadata'].get('author', 'N/A')}
- **Data**: {article_data['metadata'].get('date', 'N/A')}
- **Palavras**: {article_data.get('word_count', 0):,}
- **Tempo de leitura**: ~{article_data.get('word_count', 0)//200} minutos

## Descrição
{article_data['metadata'].get('description', 'N/A')}

## Keywords/Tags
{', '.join(article_data['metadata'].get('keywords', [])) or 'N/A'}

## Categorias
{', '.join(article_data['metadata'].get('categories', [])) or 'N/A'}

---

## Análise Estrutural

### Estatísticas
- **Parágrafos**: {article_data['structure']['paragraphs']}
- **Headings**: {len(article_data['structure']['headings'])}
- **Listas**: {article_data['structure']['lists']}
- **Citações**: {article_data['structure']['quotes']}
- **Links**: {article_data['structure']['links']}
- **Imagens**: {article_data['structure']['images']}

### Padrões Identificados
"""

        if article_data['structure'].get('patterns'):
            for pattern, count in article_data['structure']['patterns'].items():
                content += f"- **{pattern}**: {count} ocorrências\n"
        else:
            content += "- Nenhum padrão específico identificado\n"

        content += f"""
### Estrutura de Headings
"""
        for h in article_data['structure']['headings'][:10]:
            content += f"- {h['level'].upper()}: {h['text']}\n"

        content += f"""
---

## Trechos Representativos

### Abertura
{article_data['excerpts']['opening']}

### Meio
{article_data['excerpts']['middle']}

### Fechamento
{article_data['excerpts']['closing']}

---

[NOTA: Análise estrutural para estudo de padrões. Conteúdo completo não reproduzido por copyright.]

*Análise: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*
"""

        # Salva markdown
        filename = f"{safe_title}.md"
        filepath = os.path.join(self.output_dir, filename)

        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)

        print(f"✅ Salvo: {filename}")

        # Salva JSON
        json_data = {
            "persona": self.persona_name,
            "url": article_data['url'],
            "metadata": article_data['metadata'],
            "structure": article_data['structure'],
            "word_count": article_data.get('word_count', 0),
            "download_date": datetime.now().isoformat()
        }

        json_filename = f"{safe_title}.json"
        json_filepath = os.path.join(self.output_dir, json_filename)

        with open(json_filepath, 'w', encoding='utf-8') as f:
            json.dump(json_data, f, ensure_ascii=False, indent=2)

        return True

    def get_article_links(self):
        """Obtém links de artigos"""
        blog_config = self.config.get('blog', {})
        base_url = blog_config.get('base_url')
        archive_url = blog_config.get('archive_url', '/blog')

        if not base_url:
            print("⚠️ Blog não configurado para esta persona")
            return blog_config.get('main_articles', [])

        try:
            url = base_url + archive_url
            print(f"🔍 Buscando artigos em {url}...")

            response = requests.get(url, headers=self.headers, timeout=10)
            response.raise_for_status()

            soup = BeautifulSoup(response.content, 'html.parser')

            # Busca links
            article_links = []
            for link in soup.find_all('a', href=True):
                href = link['href']
                # Filtra links válidos
                if href.startswith('/') and len(href) > 1:
                    if not any(skip in href for skip in ['/tag/', '/category/', '/page/', '#', '.pdf', '/wp-']):
                        article_links.append(href)

            # Remove duplicatas
            article_links = list(set(article_links))[:50]  # Limita a 50
            print(f"📚 Encontrados {len(article_links)} links")

            return article_links

        except Exception as e:
            print(f"⚠️ Erro ao buscar links: {e}")
            # Retorna artigos principais da config
            return blog_config.get('main_articles', [])

    def process_article(self, slug):
        """Processa um artigo"""
        blog_config = self.config.get('blog', {})
        base_url = blog_config.get('base_url', '')

        # Constrói URL completa
        if slug.startswith('http'):
            url = slug
        else:
            url = base_url + slug

        print(f"📝 Processando: {url}")

        # Extrai conteúdo
        article_data = self.extract_article_content(url)

        if article_data:
            return self.save_article(article_data, slug.replace('/', '_'))
        return False

    def run(self, article_slugs=None, max_articles=10):
        """Executa o download"""
        print(f"\n{'='*60}")
        print(f"📝 BLOG DOWNLOADER - {self.config['name']}")
        print(f"{'='*60}\n")

        self.create_output_dir()

        # Obtém artigos
        if not article_slugs:
            article_slugs = self.get_article_links()

        if not article_slugs:
            print("❌ Nenhum artigo para processar")
            return

        # Limita quantidade
        article_slugs = article_slugs[:max_articles]

        # Processa cada artigo
        for i, slug in enumerate(article_slugs, 1):
            print(f"\n[{i}/{len(article_slugs)}]")
            self.stats["total"] += 1

            if self.process_article(slug):
                self.stats["success"] += 1
            else:
                self.stats["failed"] += 1

            time.sleep(3)  # Delay entre downloads

        # Relatório final
        self.print_report()

    def print_report(self):
        """Imprime relatório final"""
        print(f"\n{'='*60}")
        print("📊 RELATÓRIO FINAL")
        print(f"{'='*60}")
        print(f"✅ Sucesso: {self.stats['success']}")
        print(f"❌ Falhou: {self.stats['failed']}")
        print(f"📁 Total: {self.stats['total']}")
        print(f"📂 Salvos em: {self.output_dir}")


def main():
    parser = argparse.ArgumentParser(description='Blog Downloader Universal')
    parser.add_argument('persona', help='Nome da persona (ex: mark_manson, dan_koe)')
    parser.add_argument('--articles', type=int, default=10, help='Número de artigos (padrão: 10)')
    parser.add_argument('--urls', nargs='+', help='URLs específicas dos artigos')

    args = parser.parse_args()

    # Inicializa downloader
    downloader = BlogDownloader(args.persona)

    # Executa
    if args.urls:
        downloader.run(article_slugs=args.urls)
    else:
        downloader.run(max_articles=args.articles)


if __name__ == "__main__":
    main()