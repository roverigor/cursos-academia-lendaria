#!/usr/bin/env node
/**
 * Validador de Cores - MAVE Framework
 * Verifica se as cores usadas seguem o design system minimal-brand
 */

const fs = require('fs');
const path = require('path');

// Paleta oficial do design system
const CORES_PERMITIDAS = {
  // Cores base
  dark: '#141413',
  light: '#faf9f5',
  midGray: '#b0aea5',
  lightGray: '#e8e6dc',
  
  // Cores de acento
  orange: '#d97757',
  blue: '#6a9bcc',
  green: '#788c5d',
  
  // Cores pastéis
  beige: '#e8e4da',
  mint: '#a8cec5',
  lavender: '#b8b8d6',
  skyBlue: '#6a9bcc',
  softGray: '#c8c6bc',
  
  // Cores auxiliares permitidas
  white: '#ffffff',
  black: '#000000',
  transparent: 'transparent'
};

// Converter para array de hexadecimais
const coresPermitidas = Object.values(CORES_PERMITIDAS)
  .filter(cor => cor.startsWith('#'))
  .map(cor => cor.toLowerCase());

/**
 * Extrai todas as cores hexadecimais de um arquivo
 */
function extrairCores(conteudo) {
  const regex = /#([0-9a-f]{3}|[0-9a-f]{6})\b/gi;
  const matches = conteudo.match(regex) || [];
  return matches.map(cor => cor.toLowerCase());
}

/**
 * Normaliza cores de 3 dígitos para 6 dígitos
 */
function normalizarCor(cor) {
  if (cor.length === 4) { // #abc
    return '#' + cor[1] + cor[1] + cor[2] + cor[2] + cor[3] + cor[3];
  }
  return cor;
}

/**
 * Valida se uma cor está na paleta
 */
function validarCor(cor) {
  const corNormalizada = normalizarCor(cor);
  return coresPermitidas.includes(corNormalizada);
}

/**
 * Analisa arquivo e retorna relatório
 */
function analisarArquivo(caminhoArquivo) {
  if (!fs.existsSync(caminhoArquivo)) {
    console.error(`❌ Arquivo não encontrado: ${caminhoArquivo}`);
    process.exit(1);
  }

  const conteudo = fs.readFileSync(caminhoArquivo, 'utf-8');
  const cores = extrairCores(conteudo);
  const coresUnicas = [...new Set(cores)];
  
  const coresValidas = [];
  const coresInvalidas = [];
  
  coresUnicas.forEach(cor => {
    if (validarCor(cor)) {
      coresValidas.push(cor);
    } else {
      coresInvalidas.push(cor);
    }
  });
  
  return {
    total: coresUnicas.length,
    validas: coresValidas,
    invalidas: coresInvalidas,
    aprovado: coresInvalidas.length === 0
  };
}

/**
 * Formata saída do relatório
 */
function formatarRelatorio(arquivo, resultado) {
  const linhas = [
    '',
    `🎨 Validação de Cores - ${path.basename(arquivo)}`,
    '='.repeat(60),
    ''
  ];
  
  if (resultado.aprovado) {
    linhas.push('✅ APROVADO - Todas as cores seguem o design system!');
    linhas.push('');
    linhas.push(`Total de cores encontradas: ${resultado.total}`);
    
    if (resultado.validas.length > 0) {
      linhas.push('');
      linhas.push('Cores válidas usadas:');
      resultado.validas.forEach(cor => {
        const nomeCor = Object.keys(CORES_PERMITIDAS).find(
          key => CORES_PERMITIDAS[key].toLowerCase() === normalizarCor(cor)
        );
        linhas.push(`  ${cor} ${nomeCor ? `(var(--${nomeCor}))` : ''}`);
      });
    }
  } else {
    linhas.push('❌ REPROVADO - Cores fora do design system detectadas!');
    linhas.push('');
    linhas.push(`Total de cores: ${resultado.total}`);
    linhas.push(`Cores válidas: ${resultado.validas.length}`);
    linhas.push(`Cores inválidas: ${resultado.invalidas.length}`);
    linhas.push('');
    linhas.push('⚠️  Cores fora do padrão:');
    resultado.invalidas.forEach(cor => {
      linhas.push(`  ${cor}`);
    });
    linhas.push('');
    linhas.push('💡 Sugestão: Substitua por cores da paleta minimal-brand:');
    linhas.push('   --dark, --light, --orange, --blue, --green, --beige, --mint, --lavender');
  }
  
  linhas.push('');
  
  return linhas.join('\n');
}

/**
 * Função principal
 */
function main() {
  const args = process.argv.slice(2);
  
  if (args.length === 0) {
    console.log('Uso: node validar_cores.js <arquivo.html>');
    console.log('');
    console.log('Exemplos:');
    console.log('  node validar_cores.js index.html');
    console.log('  node validar_cores.js styles.css');
    process.exit(1);
  }
  
  const arquivo = args[0];
  const resultado = analisarArquivo(arquivo);
  
  console.log(formatarRelatorio(arquivo, resultado));
  
  // Exit code: 0 = sucesso, 1 = falha
  process.exit(resultado.aprovado ? 0 : 1);
}

main();
