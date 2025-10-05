import os
import re
import markdown
from weasyprint import HTML, CSS
from weasyprint.text.fonts import FontConfiguration

def get_number_from_filename(filename):
    """Extrai o número do início do nome do arquivo"""
    match = re.search(r'^(\d+)', filename)
    return int(match.group(1)) if match else float('inf')

def merge_md_files():
    """Une todos os arquivos .md em ordem numérica e converte para PDF"""
    # Lista todos os arquivos .md no diretório atual
    md_files = [f for f in os.listdir('.') if f.endswith('.md')]
    
    # Ordena os arquivos pelo número no início do nome
    md_files.sort(key=get_number_from_filename)
    
    # Une o conteúdo de todos os arquivos
    combined_content = []
    
    for md_file in md_files:
        try:
            with open(md_file, 'r', encoding='utf-8') as file:
                # Adiciona o nome do arquivo como título
                title = md_file.replace('.md', '').split(' - ', 1)[-1]
                combined_content.append(f'# {title}\n\n')
                
                # Adiciona o conteúdo do arquivo
                content = file.read()
                combined_content.append(content + '\n\n---\n\n')
        except Exception as e:
            print(f"Erro ao ler {md_file}: {e}")
    
    # Converte markdown para HTML
    html_content = markdown.markdown('\n'.join(combined_content))
    
    # Adiciona estilo CSS básico
    css = CSS(string='''
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 40px;
        }
        h1 {
            color: #333;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
            margin-top: 30px;
        }
        hr {
            margin: 30px 0;
            border: none;
            border-top: 2px solid #eee;
        }
    ''')
    
    # Cria o HTML completo
    html = f'''
        <html>
            <head>
                <meta charset="UTF-8">
            </head>
            <body>
                {html_content}
            </body>
        </html>
    '''
    
    # Configura fontes
    font_config = FontConfiguration()
    
    # Gera o PDF
    HTML(string=html).write_pdf(
        'episodios_unidos.pdf',
        stylesheets=[css],
        font_config=font_config
    )

if __name__ == "__main__":
    merge_md_files()