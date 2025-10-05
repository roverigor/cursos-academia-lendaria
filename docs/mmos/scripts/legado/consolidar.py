import os

def consolidar_md():
    pasta_atual = os.getcwd()
    nome_pasta = os.path.basename(pasta_atual)
    arquivo_saida = f"{nome_pasta}.md"

    arquivos_md = sorted([
        f for f in os.listdir(pasta_atual)
        if f.endswith(".md") and f != arquivo_saida
    ])

    if not arquivos_md:
        print("Nenhum arquivo .md encontrado na pasta.")
        return

    print(f"{len(arquivos_md)} arquivos encontrados:")
    for f in arquivos_md:
        print(f" - {f}")

    try:
        with open(arquivo_saida, 'w', encoding='utf-8') as saida:
            for nome_arquivo in arquivos_md:
                try:
                    with open(nome_arquivo, 'r', encoding='utf-8') as entrada:
                        conteudo = entrada.read()
                        saida.write(f"# {nome_arquivo}\n\n")
                        saida.write(conteudo)
                        saida.write("\n\n---\n\n")
                except Exception as e:
                    print(f"Erro ao ler {nome_arquivo}: {e}")
        print(f"\n✅ Todos os arquivos .md foram consolidados em: {arquivo_saida}")
    except Exception as e:
        print(f"❌ Erro ao criar arquivo de saída: {e}")

if __name__ == "__main__":
    consolidar_md()
