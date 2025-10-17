#!/usr/bin/env node
/**
 * MMOS Database - Populate Minds
 * Populates the minds table with basic information from docs/minds/
 */

const fs = require('fs');
const path = require('path');
const Database = require('better-sqlite3');

const MINDS_DIR = path.join(__dirname, '../../docs/minds');
const DB_PATH = path.join(__dirname, '../../outputs/database/mmos.db');

function getMinds() {
  const entries = fs.readdirSync(MINDS_DIR, { withFileTypes: true });
  return entries
    .filter(entry => entry.isDirectory())
    .map(entry => entry.name)
    .sort();
}

function slugToDisplayName(slug) {
  return slug
    .split('_')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
}

function getMindMetadata(mindSlug) {
  const mindDir = path.join(MINDS_DIR, mindSlug);
  const metadataPath = path.join(mindDir, 'metadata.yaml');

  // Basic metadata
  const metadata = {
    slug: mindSlug,
    display_name: slugToDisplayName(mindSlug),
    subject_type: 'public_figure',
    privacy_level: 'public',
    status: 'active',
    version: '1.0.0'
  };

  // Check if metadata.yaml exists (Story 3.1 migrated minds)
  if (fs.existsSync(metadataPath)) {
    const yaml = fs.readFileSync(metadataPath, 'utf8');
    // Simple YAML parsing for our needs
    const displayMatch = yaml.match(/display_name:\s*(.+)/);
    if (displayMatch) {
      metadata.display_name = displayMatch[1].trim();
    }
  }

  // Check for sources
  const sourcesDir = path.join(mindDir, 'sources');
  metadata.has_sources = fs.existsSync(sourcesDir);

  // Check for kb
  const kbDir = path.join(mindDir, 'kb');
  metadata.has_kb = fs.existsSync(kbDir);

  // Check for system_prompts
  const promptsDir = path.join(mindDir, 'system_prompts');
  metadata.has_prompts = fs.existsSync(promptsDir);

  return metadata;
}

function populateMinds() {
  console.log('═══════════════════════════════════════════════════════════');
  console.log('  MMOS Database - Populate Minds');
  console.log('═══════════════════════════════════════════════════════════\n');

  // Connect to database
  const db = new Database(DB_PATH);

  // Get all minds
  const minds = getMinds();
  console.log(`📊 Found ${minds.length} minds in ${MINDS_DIR}\n`);

  // Prepare insert statement
  const insert = db.prepare(`
    INSERT INTO minds (
      slug,
      display_name,
      subject_type,
      privacy_level,
      status,
      version,
      created_at,
      updated_at
    ) VALUES (
      @slug,
      @display_name,
      @subject_type,
      @privacy_level,
      @status,
      @version,
      datetime('now'),
      datetime('now')
    )
    ON CONFLICT(slug) DO UPDATE SET
      display_name = @display_name,
      updated_at = datetime('now')
  `);

  // Insert all minds
  let inserted = 0;
  let updated = 0;

  const transaction = db.transaction((minds) => {
    for (const mindSlug of minds) {
      const metadata = getMindMetadata(mindSlug);

      // Check if exists
      const existing = db.prepare('SELECT id FROM minds WHERE slug = ?').get(mindSlug);

      const result = insert.run(metadata);

      if (existing) {
        updated++;
        console.log(`  ✓ Updated: ${metadata.display_name} (${mindSlug})`);
      } else {
        inserted++;
        console.log(`  ✓ Inserted: ${metadata.display_name} (${mindSlug})`);
      }
    }
  });

  transaction(minds);

  // Summary
  console.log('\n═══════════════════════════════════════════════════════════');
  console.log('  Summary');
  console.log('═══════════════════════════════════════════════════════════');
  console.log(`  • New minds inserted: ${inserted}`);
  console.log(`  • Existing minds updated: ${updated}`);
  console.log(`  • Total minds in database: ${inserted + updated}`);

  // Validation
  const count = db.prepare('SELECT COUNT(*) as count FROM minds').get();
  console.log(`\n✅ Database verification: ${count.count} minds\n`);

  db.close();
}

// Run
try {
  populateMinds();
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
}
