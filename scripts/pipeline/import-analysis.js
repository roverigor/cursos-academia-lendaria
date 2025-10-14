#!/usr/bin/env node
/**
 * MMOS Pipeline - Analysis Import Module
 * Reads cognitive-spec.yaml and stores it in the analysis table
 *
 * Usage:
 *   node scripts/pipeline/import-analysis.js \
 *     --mind sam_altman \
 *     --file docs/minds/sam_altman/analysis/cognitive-spec.yaml \
 *     --db docs/mmos/mmos.db \
 *     [--mode fresh|update|skip]
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');
const Database = require('better-sqlite3');

// Parse command line arguments
function parseArgs() {
  const args = process.argv.slice(2);
  const options = {
    mode: 'skip' // Default safe mode
  };

  for (let i = 0; i < args.length; i += 2) {
    const key = args[i].replace('--', '');
    const value = args[i + 1];
    options[key] = value;
  }

  // Validate required arguments
  if (!options.mind || !options.file || !options.db) {
    console.error('❌ Missing required arguments');
    console.error('Usage: node import-analysis.js --mind <slug> --file <yaml_path> --db <db_path> [--mode fresh|update|skip]');
    process.exit(1);
  }

  // Validate file exists
  if (!fs.existsSync(options.file)) {
    console.error(`❌ File not found: ${options.file}`);
    process.exit(1);
  }

  // Validate database exists
  if (!fs.existsSync(options.db)) {
    console.error(`❌ Database not found: ${options.db}`);
    process.exit(1);
  }

  return options;
}

// Extract confidence scores from cognitive-spec
function extractConfidenceScores(cognitiveSpec) {
  const scores = {
    overall: 0,
    layers: {}
  };

  // Extract per-layer confidence
  for (let i = 1; i <= 8; i++) {
    const layerKey = `layer_${i}_`;
    for (const key in cognitiveSpec) {
      if (key.startsWith(layerKey) && cognitiveSpec[key]?.confidence_level) {
        scores.layers[`layer_${i}`] = cognitiveSpec[key].confidence_level;
        break;
      }
    }
  }

  // Calculate overall confidence (average of all layers)
  const layerScores = Object.values(scores.layers);
  if (layerScores.length > 0) {
    scores.overall = layerScores.reduce((sum, score) => sum + score, 0) / layerScores.length;
  }

  // Also check for overall_confidence field
  if (cognitiveSpec.metadata?.overall_confidence) {
    scores.overall = cognitiveSpec.metadata.overall_confidence;
  }

  return scores;
}

// Count evidence points across all layers
function countEvidencePoints(cognitiveSpec) {
  let totalEvidence = 0;

  for (const key in cognitiveSpec) {
    const value = cognitiveSpec[key];

    if (typeof value === 'object' && value !== null) {
      // Count evidence arrays
      if (Array.isArray(value)) {
        value.forEach(item => {
          if (item?.evidence && Array.isArray(item.evidence)) {
            totalEvidence += item.evidence.length;
          }
        });
      } else {
        // Count nested evidence
        for (const nestedKey in value) {
          const nestedValue = value[nestedKey];
          if (Array.isArray(nestedValue)) {
            nestedValue.forEach(item => {
              if (item?.evidence && Array.isArray(item.evidence)) {
                totalEvidence += item.evidence.length;
              }
            });
          }
        }
      }
    }
  }

  return totalEvidence;
}

// Import analysis from cognitive-spec
function importAnalysis(options) {
  console.log(`\n📊 Importing DNA Mental™ analysis for: ${options.mind}`);
  console.log(`Mode: ${options.mode}\n`);

  // Read and parse YAML
  let cognitiveSpec;
  let rawYaml;
  try {
    rawYaml = fs.readFileSync(options.file, 'utf8');
    cognitiveSpec = yaml.load(rawYaml, {
      json: true,
      onWarning: (warning) => console.warn(`⚠️  YAML Warning: ${warning}`)
    });
  } catch (error) {
    console.error(`❌ Failed to parse YAML: ${error.message}`);
    console.error(`\n💡 Attempting to store raw content as fallback...`);

    // Fallback: store as raw YAML string if parsing fails
    cognitiveSpec = {
      _raw_yaml: rawYaml,
      _parse_error: error.message,
      mind_name: options.mind,
      specification_version: '1.0',
      status: 'PARSE_ERROR'
    };
  }

  // Connect to database
  const db = new Database(options.db);
  db.pragma('foreign_keys = ON');

  // Get mind_id
  const mind = db.prepare('SELECT id FROM minds WHERE slug = ?').get(options.mind);

  if (!mind) {
    console.error(`❌ Mind not found in database: ${options.mind}`);
    db.close();
    process.exit(1);
  }

  const mind_id = mind.id;
  console.log(`✓ Found mind in database (ID: ${mind_id})\n`);

  // Handle fresh mode - delete existing analysis
  if (options.mode === 'fresh') {
    console.log('🗑️  Fresh mode: Deleting existing analysis...');
    const deleteResult = db.prepare('DELETE FROM analysis WHERE mind_id = ?').run(mind_id);
    console.log(`✓ Deleted ${deleteResult.changes} existing analysis entries\n`);
  }

  // Extract metadata
  const confidenceScores = extractConfidenceScores(cognitiveSpec);
  const evidenceCount = countEvidencePoints(cognitiveSpec);
  const layersAnalyzed = Object.keys(confidenceScores.layers).length;

  // Check if analysis already exists
  const existing = db.prepare(
    'SELECT id FROM analysis WHERE mind_id = ? AND analysis_type = ? AND title LIKE ?'
  ).get(mind_id, 'worldview', '%DNA Mental%');

  // Skip mode: skip if exists
  if (options.mode === 'skip' && existing) {
    console.log('⏭️  Analysis already exists, skipping...');
    console.log(`\n✅ Analysis import complete for: ${options.mind}`);
    db.close();
    return;
  }

  // Prepare analysis data
  const analysisData = {
    mind_id: mind_id,
    analysis_type: 'worldview', // DNA Mental encompasses worldview/personality
    layer: null, // Full spec encompasses all layers
    phase: 'complete',
    title: `DNA Mental™ Cognitive Architecture - ${cognitiveSpec.mind_name || options.mind}`,
    content: JSON.stringify(cognitiveSpec, null, 2),
    structured_data: JSON.stringify({
      version: cognitiveSpec.specification_version || '1.0',
      status: cognitiveSpec.status || 'DRAFT',
      created_date: cognitiveSpec.created_date,
      last_updated: cognitiveSpec.last_updated,
      architect: cognitiveSpec.architect,
      layers_analyzed: layersAnalyzed,
      total_evidence_points: evidenceCount,
      confidence_scores: confidenceScores,
      metadata: cognitiveSpec.metadata || {}
    }),
    source_fragment_ids: null,
    confidence: confidenceScores.overall / 100, // Convert to 0-1 scale
    completeness: layersAnalyzed / 8, // 8 layers total
    agent_name: cognitiveSpec.architect || 'Unknown',
    agent_version: cognitiveSpec.metadata?.dna_mental_version || '3.0'
  };

  try {
    if (existing && (options.mode === 'update' || options.mode === 'fresh')) {
      // Update existing analysis
      const updateStmt = db.prepare(`
        UPDATE analysis
        SET content = @content,
            structured_data = @structured_data,
            confidence = @confidence,
            completeness = @completeness,
            agent_name = @agent_name,
            agent_version = @agent_version,
            updated_at = datetime('now')
        WHERE id = ?
      `);
      updateStmt.run({ ...analysisData, id: existing.id });
      console.log('✓ Updated existing analysis entry');
    } else if (!existing) {
      // Insert new analysis
      const insertStmt = db.prepare(`
        INSERT INTO analysis (
          mind_id, analysis_type, layer, phase, title, content,
          structured_data, source_fragment_ids, confidence, completeness,
          agent_name, agent_version, created_at, updated_at
        ) VALUES (
          @mind_id, @analysis_type, @layer, @phase, @title, @content,
          @structured_data, @source_fragment_ids, @confidence, @completeness,
          @agent_name, @agent_version, datetime('now'), datetime('now')
        )
      `);
      insertStmt.run(analysisData);
      console.log('✓ Inserted new analysis entry');
    }
  } catch (error) {
    console.error(`❌ Error importing analysis: ${error.message}`);
    db.close();
    process.exit(1);
  }

  // Summary
  console.log('\n📊 Analysis Summary:');
  console.log(`  • Overall confidence: ${confidenceScores.overall.toFixed(1)}%`);
  console.log(`  • Layers analyzed: ${layersAnalyzed}/8`);
  console.log(`  • Total evidence points: ${evidenceCount}`);
  console.log(`  • Completeness: ${(analysisData.completeness * 100).toFixed(1)}%`);
  console.log(`  • Status: ${cognitiveSpec.status || 'DRAFT'}`);

  // Validate import
  const count = db.prepare('SELECT COUNT(*) as count FROM analysis WHERE mind_id = ?').get(mind_id);
  console.log(`  • Total analysis entries: ${count.count}\n`);

  console.log(`✅ DNA Mental™ analysis imported for: ${options.mind}`);

  db.close();
}

// Main execution
if (require.main === module) {
  const options = parseArgs();
  importAnalysis(options);
}

module.exports = { importAnalysis, extractConfidenceScores, countEvidencePoints };
