#!/usr/bin/env node
/**
 * MMOS Pipeline - Source Population Module
 * Reads sources_master.yaml and populates the sources table
 *
 * Usage:
 *   node scripts/pipeline/populate-sources.js \
 *     --mind sam_altman \
 *     --file docs/minds/sam_altman/sources/sources_master.yaml \
 *     --db outputs/database/mmos.db \
 *     [--mode fresh|update|skip]
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');
const Database = require('better-sqlite3');
const { v4: uuidv4 } = require('uuid');

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
    console.error('Usage: node populate-sources.js --mind <slug> --file <yaml_path> --db <db_path> [--mode fresh|update|skip]');
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

// Map source types from YAML to database schema
// Database accepts: interview, article, book, essay, podcast_transcript,
// video_transcript, speech, social_media, email, conversation, other
function mapSourceType(yamlType) {
  const typeMap = {
    'blog': 'article',
    'youtube': 'video_transcript',
    'pdf': 'essay',
    'article': 'article',
    'testimony': 'speech',
    'interview': 'interview'
  };

  return typeMap[yamlType] || 'other'; // Default to other
}

// Map confidence levels
function mapConfidence(yamlConfidence) {
  const confidenceMap = {
    'high': 0.9,
    'medium': 0.7,
    'low': 0.5
  };

  if (typeof yamlConfidence === 'number') {
    return yamlConfidence;
  }

  return confidenceMap[yamlConfidence] || 0.7; // Default to medium
}

// Populate sources from YAML
function populateSources(options) {
  console.log(`\n📊 Populating sources for: ${options.mind}`);
  console.log(`Mode: ${options.mode}\n`);

  // Read and parse YAML
  let yamlContent;
  try {
    yamlContent = yaml.load(fs.readFileSync(options.file, 'utf8'));
  } catch (error) {
    console.error(`❌ Failed to parse YAML: ${error.message}`);
    process.exit(1);
  }

  if (!yamlContent.sources || !Array.isArray(yamlContent.sources)) {
    console.error('❌ Invalid YAML structure: missing "sources" array');
    process.exit(1);
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

  // Handle fresh mode - delete existing sources
  if (options.mode === 'fresh') {
    console.log('🗑️  Fresh mode: Deleting existing sources...');
    const deleteResult = db.prepare('DELETE FROM sources WHERE mind_id = ?').run(mind_id);
    console.log(`✓ Deleted ${deleteResult.changes} existing sources\n`);
  }

  // Prepare statements
  const checkStmt = db.prepare('SELECT id FROM sources WHERE source_id = ?');
  const insertStmt = db.prepare(`
    INSERT INTO sources (
      source_id, mind_id, type, title, source_url, file_path,
      word_count, metadata, created_at, updated_at
    ) VALUES (
      @source_id, @mind_id, @type, @title, @source_url, @file_path,
      @word_count, @metadata, datetime('now'), datetime('now')
    )
  `);
  const updateStmt = db.prepare(`
    UPDATE sources
    SET type = @type,
        title = @title,
        source_url = @source_url,
        file_path = @file_path,
        word_count = @word_count,
        metadata = @metadata,
        updated_at = datetime('now')
    WHERE source_id = @source_id
  `);

  // Process sources
  let inserted = 0;
  let updated = 0;
  let skipped = 0;

  const transaction = db.transaction((sources) => {
    for (const source of sources) {
      // Generate source ID (use YAML id or generate UUID)
      const sourceId = source.id || uuidv4();

      // Check if source already exists
      const existing = checkStmt.get(sourceId);

      // Skip mode: skip if exists
      if (options.mode === 'skip' && existing) {
        skipped++;
        continue;
      }

      // Prepare source data
      const sourceData = {
        source_id: sourceId,
        mind_id: mind_id,
        type: mapSourceType(source.type),
        title: source.title || 'Untitled',
        source_url: source.url || null,
        file_path: source.file_path || null,
        word_count: source.word_count || 0,
        metadata: JSON.stringify({
          status: source.status,
          priority: source.priority,
          confidence: mapConfidence(source.confidence),
          processed_at: source.processed_at,
          notes: source._notes
        })
      };

      try {
        if (existing && (options.mode === 'update' || options.mode === 'fresh')) {
          updateStmt.run(sourceData);
          updated++;
        } else if (!existing) {
          insertStmt.run(sourceData);
          inserted++;
        }
      } catch (error) {
        console.error(`❌ Error processing source "${source.title}": ${error.message}`);
        throw error; // Rollback transaction
      }
    }
  });

  try {
    transaction(yamlContent.sources);
  } catch (error) {
    console.error(`\n❌ Transaction failed: ${error.message}`);
    db.close();
    process.exit(1);
  }

  // Summary
  console.log('📊 Summary:');
  console.log(`  • Inserted: ${inserted} new sources`);
  console.log(`  • Updated: ${updated} existing sources`);
  console.log(`  • Skipped: ${skipped} existing sources`);
  console.log(`  • Total in YAML: ${yamlContent.sources.length}`);

  // Validate total
  const totalInDb = db.prepare('SELECT COUNT(*) as count FROM sources WHERE mind_id = ?').get(mind_id);
  console.log(`  • Total in database: ${totalInDb.count}\n`);

  console.log(`✅ Source population complete for: ${options.mind}`);

  db.close();
}

// Main execution
if (require.main === module) {
  const options = parseArgs();
  populateSources(options);
}

module.exports = { populateSources, mapSourceType, mapConfidence };
