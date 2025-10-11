#!/usr/bin/env node
/**
 * ETL Collection Runner - Sam Altman Tier 1 Sources
 * Simple CLI to execute parallel collection
 */

import { ParallelCollector } from './scripts/orchestrator/parallel-collector.js';
import { getLogPath, getSourcesMasterPath, getDownloadsDir } from './scripts/utils/path-helpers.js';
import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function main() {
  console.log('🚀 ETL Data Collector - Sam Altman Tier 1 Collection\n');

  // Use standard paths - mind directory is the root for all paths
  const mindDir = path.join(__dirname, '../../docs/minds/sam_altman');
  const sourcesPath = getSourcesMasterPath(mindDir);
  const outputDir = getDownloadsDir(mindDir);
  const configPath = path.join(__dirname, 'config/download-rules.yaml');

  // Check if sources file exists
  try {
    await fs.access(sourcesPath);
  } catch (error) {
    console.error(`❌ Sources file not found: ${sourcesPath}`);
    process.exit(1);
  }

  // Create output directory if it doesn't exist
  try {
    await fs.mkdir(outputDir, { recursive: true });
  } catch (error) {
    console.warn(`⚠️  Could not create output directory: ${error.message}`);
  }

  // Initialize collector
  console.log('📋 Configuration:');
  console.log(`   Sources: ${sourcesPath}`);
  console.log(`   Output:  ${outputDir}`);
  console.log(`   Config:  ${configPath}\n`);

  const collector = new ParallelCollector(configPath, {
    mindDir,
    maxConcurrent: 3,
    allowResume: true
  });

  try {
    await collector.initialize();
    console.log('✅ Collector initialized\n');

    console.log('⏳ Starting parallel collection...\n');
    const report = await collector.collectAll(sourcesPath, outputDir);

    console.log('\n📊 Collection Report:');
    console.log(`   Total:      ${report.totals.total}`);
    console.log(`   Successful: ${report.totals.successful} (${report.totals.successRate}%)`);
    console.log(`   Failed:     ${report.totals.failed}`);
    console.log(`   Skipped:    ${report.totals.skipped}`);
    console.log(`   Duration:   ${report.duration_human}\n`);

    // Save report to docs/logs/ with timestamp (NOT in downloads/)
    const reportPath = getLogPath(mindDir, 'collection-report', 'json');
    await fs.writeFile(reportPath, JSON.stringify(report, null, 2));
    console.log(`💾 Report saved: ${reportPath}\n`);

    if (report.totals.failed > 0) {
      console.log('⚠️  Some sources failed to collect:');
      for (const failed of report.results.failed) {
        console.log(`   - ${failed.id}: ${failed.error || 'Unknown error'}`);
      }
      console.log('');
    }

    console.log('✅ Collection complete!\n');
    process.exit(0);

  } catch (error) {
    console.error(`\n❌ Collection failed: ${error.message}`);
    console.error(error.stack);
    process.exit(1);
  }
}

main().catch((error) => {
  console.error('Fatal error:', error);
  process.exit(1);
});
