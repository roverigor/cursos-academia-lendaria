#!/usr/bin/env python3
"""
Compressor de PDF usando Ghostscript para máxima compressão

Requisitos:
- Ghostscript instalado no sistema 
  (instale com 'brew install ghostscript' no macOS)
- Nenhuma biblioteca Python adicional necessária

Este script usa Ghostscript, que é a ferramenta mais poderosa 
para compressão de PDFs, usada por serviços online profissionais.
"""

import os
import sys
import subprocess
import argparse
from datetime import datetime

def get_file_size_mb(file_path):
    """Retorna o tamanho do arquivo em MB."""
    return os.path.getsize(file_path) / (1024 * 1024)

def check_ghostscript():
    """Verifica se o Ghostscript está instalado."""
    try:
        result = subprocess.run(['gs', '--version'], 
                               stdout=subprocess.PIPE, 
                               stderr=subprocess.PIPE,
                               text=True)
        if result.returncode == 0:
            print(f"Ghostscript encontrado: versão {result.stdout.strip()}")
            return True
    except FileNotFoundError:
        pass
    
    print("Ghostscript não encontrado. Por favor, instale-o:")
    print("  - macOS: brew install ghostscript")
    print("  - Linux: sudo apt-get install ghostscript")
    print("  - Windows: Baixe em https://www.ghostscript.com/download/gsdnld.html")
    return False

def compress_pdf_with_ghostscript(input_path, output_path=None, quality="screen"):
    """
    Comprime um PDF usando Ghostscript com diferentes níveis de qualidade.
    
    Qualidade:
    - "screen": Baixa qualidade, máxima compressão (72 dpi)
    - "ebook": Qualidade média, boa compressão (150 dpi)
    - "printer": Qualidade de impressão, compressão moderada (300 dpi)
    - "prepress": Alta qualidade, compressão mínima (300 dpi, preserva mais)
    """
    if output_path is None:
        file_name = os.path.basename(input_path)
        name, ext = os.path.splitext(file_name)
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_path = os.path.join(os.path.dirname(input_path), f"{name}_compressed_{timestamp}{ext}")
    
    # Verifica o tamanho original
    original_size = get_file_size_mb(input_path)
    print(f"Tamanho original: {original_size:.2f} MB")
    
    # Configuração baseada no nível de qualidade
    if quality == "screen":
        gs_quality = [
            "-dPDFSETTINGS=/screen",
            "-dDownsampleColorImages=true",
            "-dColorImageResolution=72",
            "-dDownsampleGrayImages=true", 
            "-dGrayImageResolution=72",
            "-dDownsampleMonoImages=true",
            "-dMonoImageResolution=72"
        ]
        print("Usando configuração de qualidade BAIXA (máxima compressão)")
    elif quality == "ebook":
        gs_quality = [
            "-dPDFSETTINGS=/ebook",
            "-dDownsampleColorImages=true",
            "-dColorImageResolution=150",
            "-dDownsampleGrayImages=true", 
            "-dGrayImageResolution=150",
            "-dDownsampleMonoImages=true",
            "-dMonoImageResolution=150"
        ]
        print("Usando configuração de qualidade MÉDIA (boa compressão)")
    elif quality == "printer":
        gs_quality = [
            "-dPDFSETTINGS=/printer",
            "-dDownsampleColorImages=true",
            "-dColorImageResolution=300"
        ]
        print("Usando configuração de qualidade IMPRESSÃO (compressão moderada)")
    else:  # prepress
        gs_quality = [
            "-dPDFSETTINGS=/prepress"
        ]
        print("Usando configuração de qualidade MÁXIMA (compressão mínima)")
    
    # Comando base do Ghostscript
    gs_cmd = [
        "gs", 
        "-sDEVICE=pdfwrite", 
        "-dCompatibilityLevel=1.4",
        "-dNOPAUSE", 
        "-dQUIET",
        "-dBATCH",
        "-dAutoRotatePages=/None",
        *gs_quality,
        f"-sOutputFile={output_path}",
        input_path
    ]
    
    print(f"Executando compressão com Ghostscript...")
    
    try:
        process = subprocess.run(gs_cmd, 
                                stdout=subprocess.PIPE, 
                                stderr=subprocess.PIPE,
                                text=True)
        
        if process.returncode != 0:
            print(f"Erro ao executar Ghostscript: {process.stderr}")
            return None
        
        # Verifica o tamanho final
        final_size = get_file_size_mb(output_path)
        reduction = 100 * (1 - final_size / original_size)
        
        print(f"Tamanho final: {final_size:.2f} MB")
        print(f"Redução: {reduction:.2f}%")
        
        return output_path
        
    except Exception as e:
        print(f"Erro durante a compressão: {str(e)}")
        return None

def main():
    parser = argparse.ArgumentParser(description="Compressor de PDF usando Ghostscript")
    parser.add_argument("-i", "--input", help="Arquivo PDF de entrada")
    parser.add_argument("-o", "--output", help="Arquivo PDF de saída")
    parser.add_argument("-q", "--quality", choices=["screen", "ebook", "printer", "prepress"],
                        default="screen", help="Qualidade da compressão (padrão: screen - máxima compressão)")
    args = parser.parse_args()
    
    # Verifica se o Ghostscript está instalado
    if not check_ghostscript():
        return
    
    # Obtém o diretório atual
    current_dir = os.path.dirname(os.path.abspath(__file__)) or os.getcwd()
    
    # Se nenhum arquivo de entrada for especificado, processa todos os PDFs na pasta
    if args.input is None:
        print(f"Buscando PDFs na pasta: {current_dir}")
        pdf_files = [f for f in os.listdir(current_dir) if f.lower().endswith('.pdf')]
        
        if not pdf_files:
            print("Nenhum arquivo PDF encontrado.")
            return
        
        print(f"Encontrados {len(pdf_files)} arquivos PDF:")
        for i, pdf in enumerate(pdf_files, 1):
            print(f"{i}. {pdf}")
        
        # Processa cada arquivo PDF encontrado
        for pdf_file in pdf_files:
            input_path = os.path.join(current_dir, pdf_file)
            print(f"\nProcessando: {pdf_file}")
            try:
                result = compress_pdf_with_ghostscript(input_path, quality=args.quality)
                if result:
                    print(f"Compressão concluída: {os.path.basename(result)}")
                else:
                    print("Falha na compressão.")
            except Exception as e:
                print(f"Erro ao processar {pdf_file}: {str(e)}")
    else:
        # Processa apenas o arquivo especificado
        input_path = args.input
        if not os.path.exists(input_path):
            # Verifica se o arquivo existe na pasta atual
            potential_path = os.path.join(current_dir, input_path)
            if os.path.exists(potential_path):
                input_path = potential_path
            else:
                print(f"Erro: O arquivo {input_path} não existe.")
                return
        
        try:
            result = compress_pdf_with_ghostscript(input_path, args.output, args.quality)
            if result:
                print(f"Compressão concluída: {result}")
            else:
                print("Falha na compressão.")
        except Exception as e:
            print(f"Erro: {str(e)}")

if __name__ == "__main__":
    main()