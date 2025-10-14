#!/usr/bin/env node
/**
 * MMOS Pipeline - Integration Validation Module
 * Validates referential integrity and data quality across pipeline outputs
 *
 * Usage:
 *   node scripts/pipeline/validate-integration.js \
 *     --mind sam_altman \
 *     --db docs/mmos/mmos.db \
 *     [--strict]
 */

const Database = require('better-sqlite3');

// Parse command line arguments
function parseArgs() {
  const args = process.argv.slice(2);
  const options = {
    strict: false // Default to warnings, not errors
  };

  for (let i = 0; i < args.length; i += 2) {
    const key = args[i].replace('--', '');
    if (key === 'strict') {
      options.strict = true;
      i--; // No value for boolean flag
    } else {
      options[key] = args[i + 1];
    }
  }

  // Validate required arguments
  if (!options.mind || !options.db) {
    console.error('❌ Missing required arguments');
    console.error('Usage: node validate-integration.js --mind <slug> --db <db_path> [--strict]');
    process.exit(1);
  }

  return options;
}

// Validation checks
function validateIntegration(options) {
  console.log(`\n🔍 Validating integration for: ${options.mind}`);
  console.log(`Strict mode: ${options.strict ? 'ON' : 'OFF'}\n`);

  const db = new Database(options.db);
  db.pragma('foreign_keys = ON');

  let errors = 0;
  let warnings = 0;
  const results = {
    checks: [],
    summary: {}
  };

  // Get mind_id
  const mind = db.prepare('SELECT id FROM minds WHERE slug = ?').get(options.mind);

  if (!mind) {
    console.error(`❌ Mind not found: ${options.mind}`);
    db.close();
    process.exit(1);
  }

  const mind_id = mind.id;
  console.log(`✓ Found mind (ID: ${mind_id})\n`);

  // ==========================================================================
  // CHECK 1: Mind exists in all expected tables
  // ==========================================================================
  console.log('📋 CHECK 1: Mind existence across tables');

  const tables = ['sources', 'fragments', 'analysis', 'prompts', 'prompt_sequences'];
  const mindPresence = {};

  for (const table of tables) {
    try {
      const count = db.prepare(`SELECT COUNT(*) as count FROM ${table} WHERE mind_id = ?`).get(mind_id);
      mindPresence[table] = count.count;

      if (count.count > 0) {
        console.log(`  ✓ ${table}: ${count.count} records`);
      } else {
        console.log(`  ⚠️  ${table}: 0 records`);
        warnings++;
        results.checks.push({
          check: 'mind_presence',
          table: table,
          status: 'warning',
          message: `No records for mind in ${table}`
        });
      }
    } catch (error) {
      console.log(`  ⚠️  ${table}: Table check failed (${error.message})`);
    }
  }

  // ==========================================================================
  // CHECK 2: Source integrity
  // ==========================================================================
  console.log('\n📋 CHECK 2: Source data integrity');

  const sources = db.prepare('SELECT * FROM sources WHERE mind_id = ?').all(mind_id);
  console.log(`  Found ${sources.length} sources`);

  let invalidSources = 0;
  for (const source of sources) {
    const issues = [];

    // Check required fields
    if (!source.title || source.title.trim() === '') {
      issues.push('Missing title');
    }
    if (!source.type) {
      issues.push('Missing type');
    }
    if (!source.source_url && !source.file_path) {
      issues.push('Missing both URL and file_path');
    }
    if (source.word_count === 0) {
      issues.push('Zero word count');
    }

    // Check metadata is valid JSON
    if (source.metadata) {
      try {
        JSON.parse(source.metadata);
      } catch (error) {
        issues.push('Invalid metadata JSON');
      }
    }

    if (issues.length > 0) {
      invalidSources++;
      const severity = options.strict ? '❌' : '⚠️';
      console.log(`  ${severity} Source "${source.title}": ${issues.join(', ')}`);

      results.checks.push({
        check: 'source_integrity',
        source_id: source.source_id,
        status: options.strict ? 'error' : 'warning',
        issues: issues
      });

      if (options.strict) errors++;
      else warnings++;
    }
  }

  if (invalidSources === 0) {
    console.log('  ✓ All sources have valid data');
  } else {
    console.log(`  ${options.strict ? '❌' : '⚠️'} ${invalidSources} sources with issues`);
  }

  // ==========================================================================
  // CHECK 3: Analysis integrity
  // ==========================================================================
  console.log('\n📋 CHECK 3: Analysis data integrity');

  const analyses = db.prepare('SELECT * FROM analysis WHERE mind_id = ?').all(mind_id);
  console.log(`  Found ${analyses.length} analysis records`);

  let invalidAnalyses = 0;
  for (const analysis of analyses) {
    const issues = [];

    // Check required fields
    if (!analysis.title || analysis.title.trim() === '') {
      issues.push('Missing title');
    }
    if (!analysis.content || analysis.content.trim() === '') {
      issues.push('Missing content');
    }
    if (!analysis.analysis_type) {
      issues.push('Missing analysis_type');
    }

    // Check content is valid JSON
    if (analysis.content) {
      try {
        const parsed = JSON.parse(analysis.content);

        // If it has parse error, it's a known issue (not critical)
        if (parsed._parse_error) {
          issues.push(`YAML parse error: ${parsed._parse_error}`);
        }
      } catch (error) {
        issues.push('Invalid content JSON');
      }
    }

    // Check structured_data is valid JSON if present
    if (analysis.structured_data) {
      try {
        JSON.parse(analysis.structured_data);
      } catch (error) {
        issues.push('Invalid structured_data JSON');
      }
    }

    // Check confidence range
    if (analysis.confidence !== null && (analysis.confidence < 0 || analysis.confidence > 1)) {
      issues.push(`Invalid confidence: ${analysis.confidence} (should be 0-1)`);
    }

    if (issues.length > 0) {
      invalidAnalyses++;
      const severity = options.strict ? '❌' : '⚠️';
      console.log(`  ${severity} Analysis "${analysis.title}": ${issues.join(', ')}`);

      results.checks.push({
        check: 'analysis_integrity',
        analysis_id: analysis.id,
        status: options.strict ? 'error' : 'warning',
        issues: issues
      });

      if (options.strict) errors++;
      else warnings++;
    }
  }

  if (invalidAnalyses === 0) {
    console.log('  ✓ All analysis records have valid data');
  } else {
    console.log(`  ${options.strict ? '❌' : '⚠️'} ${invalidAnalyses} analysis records with issues`);
  }

  // ==========================================================================
  // CHECK 4: Referential integrity (when fragments exist)
  // ==========================================================================
  console.log('\n📋 CHECK 4: Referential integrity');

  const fragments = db.prepare('SELECT * FROM fragments WHERE mind_id = ?').all(mind_id);
  console.log(`  Found ${fragments.length} fragments`);

  if (fragments.length > 0) {
    let orphanedFragments = 0;

    for (const fragment of fragments) {
      // Check if source_id exists (if not null)
      if (fragment.source_id) {
        const source = db.prepare('SELECT source_id FROM sources WHERE source_id = ?').get(fragment.source_id);
        if (!source) {
          orphanedFragments++;
          const severity = options.strict ? '❌' : '⚠️';
          console.log(`  ${severity} Fragment ${fragment.id}: references non-existent source ${fragment.source_id}`);

          results.checks.push({
            check: 'referential_integrity',
            fragment_id: fragment.id,
            status: options.strict ? 'error' : 'warning',
            message: `Orphaned fragment (source_id ${fragment.source_id} not found)`
          });

          if (options.strict) errors++;
          else warnings++;
        }
      }
    }

    if (orphanedFragments === 0) {
      console.log('  ✓ All fragments have valid source references');
    } else {
      console.log(`  ${options.strict ? '❌' : '⚠️'} ${orphanedFragments} orphaned fragments`);
    }
  } else {
    console.log('  ℹ️  No fragments to validate (expected - InnerLens expansion not yet implemented)');
  }

  // ==========================================================================
  // CHECK 5: Data completeness for pipeline
  // ==========================================================================
  console.log('\n📋 CHECK 5: Pipeline data completeness');

  const completeness = {
    has_sources: sources.length > 0,
    has_analysis: analyses.length > 0,
    has_fragments: fragments.length > 0,
    sources_with_files: sources.filter(s => s.file_path).length,
    sources_with_urls: sources.filter(s => s.source_url).length,
    analysis_with_high_confidence: analyses.filter(a => a.confidence && a.confidence > 0.8).length
  };

  console.log(`  Sources: ${sources.length} (${completeness.sources_with_files} with files, ${completeness.sources_with_urls} with URLs)`);
  console.log(`  Analysis: ${analyses.length} (${completeness.analysis_with_high_confidence} with confidence > 80%)`);
  console.log(`  Fragments: ${fragments.length}`);

  // Warning if no high-confidence analysis
  if (analyses.length > 0 && completeness.analysis_with_high_confidence === 0) {
    console.log('  ⚠️  No high-confidence analysis found (may indicate YAML parsing issues)');
    warnings++;
    results.checks.push({
      check: 'data_completeness',
      status: 'warning',
      message: 'No high-confidence analysis'
    });
  }

  // ==========================================================================
  // Summary
  // ==========================================================================
  console.log('\n' + '='.repeat(70));
  console.log('📊 VALIDATION SUMMARY');
  console.log('='.repeat(70));

  results.summary = {
    mind_id: mind_id,
    mind_slug: options.mind,
    total_sources: sources.length,
    total_analysis: analyses.length,
    total_fragments: fragments.length,
    errors: errors,
    warnings: warnings,
    status: errors > 0 ? 'FAILED' : (warnings > 0 ? 'PASSED_WITH_WARNINGS' : 'PASSED')
  };

  console.log(`Mind: ${options.mind} (ID: ${mind_id})`);
  console.log(`Sources: ${sources.length}`);
  console.log(`Analysis: ${analyses.length}`);
  console.log(`Fragments: ${fragments.length}`);
  console.log('');
  console.log(`Errors: ${errors}`);
  console.log(`Warnings: ${warnings}`);
  console.log('');

  if (errors > 0) {
    console.log('❌ VALIDATION FAILED');
    console.log('   Fix errors before proceeding to next pipeline stage');
  } else if (warnings > 0) {
    console.log('⚠️  VALIDATION PASSED WITH WARNINGS');
    console.log('   Review warnings but safe to proceed');
  } else {
    console.log('✅ VALIDATION PASSED');
    console.log('   All checks passed successfully');
  }

  console.log('');

  db.close();

  // Exit with appropriate code
  if (errors > 0) {
    process.exit(1);
  }
}

// Main execution
if (require.main === module) {
  const options = parseArgs();
  validateIntegration(options);
}

module.exports = { validateIntegration };
