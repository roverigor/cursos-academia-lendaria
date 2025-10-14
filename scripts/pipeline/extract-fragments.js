#!/usr/bin/env node
/**
 * MMOS Pipeline - Fragment Extraction Module
 * Extracts evidence fragments from cognitive-spec.yaml
 *
 * Usage:
 *   node scripts/pipeline/extract-fragments.js \
 *     --mind sam_altman \
 *     --cognitive-spec docs/minds/sam_altman/analysis/cognitive-spec.yaml \
 *     --db docs/mmos/mmos.db \
 *     [--mode fresh|update|skip]
 */

const fs = require('fs');
const yaml = require('js-yaml');
const Database = require('better-sqlite3');
const { v4: uuidv4 } = require('uuid');

// Parse command line arguments
function parseArgs() {
  const args = process.argv.slice(2);
  const options = { mode: 'skip' };

  for (let i = 0; i < args.length; i += 2) {
    const key = args[i].replace('--', '').replace('-', '_');
    options[key] = args[i + 1];
  }

  if (!options.mind || !options.cognitive_spec || !options.db) {
    console.error('❌ Missing required arguments');
    console.error('Usage: node extract-fragments.js --mind <slug> --cognitive-spec <yaml_path> --db <db_path>');
    process.exit(1);
  }

  return options;
}

// Extract fragments from cognitive-spec
function extractFragments(options) {
  console.log(`\n📊 Extracting fragments for: ${options.mind}`);
  console.log(`Mode: ${options.mode}\n`);

  // Read analysis from database (contains the raw YAML)
  const db = new Database(options.db);
  db.pragma('foreign_keys = ON');

  const mind = db.prepare('SELECT id FROM minds WHERE slug = ?').get(options.mind);
  if (!mind) {
    console.error(`❌ Mind not found: ${options.mind}`);
    db.close();
    process.exit(1);
  }

  const mind_id = mind.id;
  console.log(`✓ Found mind (ID: ${mind_id})\n`);

  // Get analysis content
  const analysis = db.prepare(
    'SELECT content FROM analysis WHERE mind_id = ? AND title LIKE ? LIMIT 1'
  ).get(mind_id, '%DNA Mental%');

  if (!analysis) {
    console.error(`❌ No analysis found. Run import-analysis.js first.`);
    db.close();
    process.exit(1);
  }

  let cognitiveSpec;
  try {
    cognitiveSpec = JSON.parse(analysis.content);
  } catch (error) {
    console.error(`❌ Failed to parse analysis content: ${error.message}`);
    db.close();
    process.exit(1);
  }

  // Handle fresh mode
  if (options.mode === 'fresh') {
    console.log('🗑️  Fresh mode: Deleting existing fragments...');
    const deleteResult = db.prepare('DELETE FROM fragments WHERE mind_id = ?').run(mind_id);
    console.log(`✓ Deleted ${deleteResult.changes} fragments\n`);
  }

  // Extract fragments from all layers
  const fragments = [];
  const layerCounts = {};

  for (let layer = 1; layer <= 8; layer++) {
    const layerKey = `layer_${layer}_`;
    layerCounts[`layer_${layer}`] = 0;

    for (const key in cognitiveSpec) {
      if (key.startsWith(layerKey) && typeof cognitiveSpec[key] === 'object') {
        const layerData = cognitiveSpec[key];

        // Extract from arrays
        for (const prop in layerData) {
          const value = layerData[prop];

          if (Array.isArray(value)) {
            value.forEach(item => {
              if (item?.evidence && Array.isArray(item.evidence)) {
                item.evidence.forEach(ev => {
                  if (ev.quote || ev.example) {
                    fragments.push({
                      layer,
                      cognitive_theme: item.framework_name || item.radar_name || item.name || prop,
                      evidence: ev,
                      context: key
                    });
                    layerCounts[`layer_${layer}`]++;
                  }
                });
              }
            });
          }
        }
      }
    }
  }

  console.log(`✓ Extracted ${fragments.length} fragments from cognitive-spec\n`);

  // Insert fragments
  let inserted = 0;
  let skipped = 0;

  const insertStmt = db.prepare(`
    INSERT INTO fragments (
      id, mind_id, source_id, fragment_type, content, cognitive_theme,
      layer, confidence, why_significant, raw_excerpt,
      extraction_method, extraction_version, pipeline_version,
      created_at, updated_at
    ) VALUES (
      @id, @mind_id, @source_id, @fragment_type, @content, @cognitive_theme,
      @layer, @confidence, @why_significant, @raw_excerpt,
      @extraction_method, @extraction_version, @pipeline_version,
      datetime('now'), datetime('now')
    )
  `);

  const transaction = db.transaction((frags) => {
    for (const frag of frags) {
      const ev = frag.evidence;
      const content = ev.quote || ev.example || '';

      const fragmentData = {
        id: uuidv4(),
        mind_id,
        source_id: null, // TODO: match to source
        fragment_type: 'written_thought',
        content: JSON.stringify({ text: content, context: frag.cognitive_theme }),
        cognitive_theme: frag.cognitive_theme,
        layer: frag.layer,
        confidence: 0.7,
        why_significant: ev.description || frag.cognitive_theme,
        raw_excerpt: content,
        extraction_method: 'cognitive_spec_parser',
        extraction_version: '1.0',
        pipeline_version: '3.0'
      };

      try {
        insertStmt.run(fragmentData);
        inserted++;
      } catch (error) {
        // Skip duplicates or constraint errors
        skipped++;
      }
    }
  });

  transaction(fragments);

  // Summary
  console.log('📊 Summary:');
  console.log(`  • Inserted: ${inserted} fragments`);
  console.log(`  • Skipped: ${skipped} fragments`);
  Object.entries(layerCounts).forEach(([layer, count]) => {
    if (count > 0) console.log(`  • ${layer}: ${count} fragments`);
  });

  const total = db.prepare('SELECT COUNT(*) as count FROM fragments WHERE mind_id = ?').get(mind_id);
  console.log(`  • Total in database: ${total.count}\n`);

  console.log(`✅ Fragment extraction complete for: ${options.mind}`);
  db.close();
}

// Main
if (require.main === module) {
  const options = parseArgs();
  extractFragments(options);
}

module.exports = { extractFragments };
