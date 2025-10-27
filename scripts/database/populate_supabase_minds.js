#!/usr/bin/env node
/**
 * Supabase Database - Populate Minds
 * Populates Supabase minds table directly from outputs/minds/
 *
 * Based on: scripts/database/populate_minds.js (SQLite version)
 * Adapted for: Supabase PostgreSQL with UUID PKs
 */

const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
require('dotenv').config();

const MINDS_DIR = path.join(__dirname, '../../outputs/minds');
const SUPABASE_DB_URL = process.env.SUPABASE_DB_URL;

if (!SUPABASE_DB_URL) {
  console.error('❌ Error: SUPABASE_DB_URL not found in environment');
  console.error('   Run: source .env');
  process.exit(1);
}

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
    primary_language: 'pt',
    version: '1.0.0'
  };

  // Check if metadata.yaml exists
  if (fs.existsSync(metadataPath)) {
    const yaml = fs.readFileSync(metadataPath, 'utf8');
    // Simple YAML parsing
    const displayMatch = yaml.match(/display_name:\s*(.+)/);
    if (displayMatch) {
      metadata.display_name = displayMatch[1].trim();
    }
  }

  // Check for sources
  const sourcesDir = path.join(mindDir, 'sources');
  const kbDir = path.join(mindDir, 'kb');
  const promptsDir = path.join(mindDir, 'system_prompts');

  // Build MMOS metadata JSONB
  metadata.mmos_metadata = {
    subject_type: metadata.subject_type,
    status: metadata.status,
    version: metadata.version,
    has_sources: fs.existsSync(sourcesDir),
    has_kb: fs.existsSync(kbDir),
    has_prompts: fs.existsSync(promptsDir),
    populated_from: 'outputs/minds',
    populated_at: new Date().toISOString()
  };

  return metadata;
}

async function populateMinds() {
  console.log('═══════════════════════════════════════════════════════════');
  console.log('  Supabase Database - Populate Minds');
  console.log('═══════════════════════════════════════════════════════════\n');

  // Connect to Supabase
  // Remove sslmode from URL and let pg client handle SSL
  const connectionString = SUPABASE_DB_URL.replace(/\?sslmode=require/, '');
  const client = new Client({
    connectionString,
    ssl: {
      rejectUnauthorized: false
    }
  });
  await client.connect();
  console.log('✅ Connected to Supabase\n');

  // Check if mmos_metadata column exists
  const hasMetadataCol = await client.query(`
    SELECT column_name
    FROM information_schema.columns
    WHERE table_name = 'minds' AND column_name = 'mmos_metadata'
  `);

  if (hasMetadataCol.rows.length === 0) {
    console.log('⚠️  Column mmos_metadata not found. Creating...');
    await client.query(`
      ALTER TABLE minds
      ADD COLUMN IF NOT EXISTS mmos_metadata JSONB DEFAULT '{}'::jsonb
    `);
    console.log('✅ Column mmos_metadata created\n');
  }

  // Get all minds
  const minds = getMinds();
  console.log(`📊 Found ${minds.length} minds in ${MINDS_DIR}\n`);

  // Insert/update all minds
  let inserted = 0;
  let updated = 0;

  for (const mindSlug of minds) {
    const metadata = getMindMetadata(mindSlug);

    try {
      // Check if exists
      const existing = await client.query(
        'SELECT id FROM minds WHERE slug = $1',
        [mindSlug]
      );

      if (existing.rows.length > 0) {
        // Update
        await client.query(`
          UPDATE minds
          SET
            display_name = $1,
            primary_language = $2,
            mmos_metadata = $3,
            updated_at = now()
          WHERE slug = $4
        `, [
          metadata.display_name,
          metadata.primary_language,
          JSON.stringify(metadata.mmos_metadata),
          mindSlug
        ]);
        updated++;
        console.log(`  ✓ Updated: ${metadata.display_name} (${mindSlug})`);
      } else {
        // Insert
        await client.query(`
          INSERT INTO minds (
            slug,
            display_name,
            primary_language,
            privacy_level,
            apex_score,
            mmos_metadata,
            created_at,
            updated_at
          ) VALUES (
            $1, $2, $3, $4, $5, $6, now(), now()
          )
        `, [
          mindSlug,
          metadata.display_name,
          metadata.primary_language,
          metadata.privacy_level,
          0.00, // Default apex_score
          JSON.stringify(metadata.mmos_metadata)
        ]);
        inserted++;
        console.log(`  ✓ Inserted: ${metadata.display_name} (${mindSlug})`);
      }
    } catch (error) {
      console.error(`  ❌ Error with ${mindSlug}:`, error.message);
    }
  }

  // Summary
  console.log('\n═══════════════════════════════════════════════════════════');
  console.log('  Summary');
  console.log('═══════════════════════════════════════════════════════════');
  console.log(`  • New minds inserted: ${inserted}`);
  console.log(`  • Existing minds updated: ${updated}`);
  console.log(`  • Total processed: ${inserted + updated}`);

  // Validation
  const count = await client.query('SELECT COUNT(*) as count FROM minds');
  console.log(`\n✅ Database verification: ${count.rows[0].count} minds in Supabase\n`);

  await client.end();
}

// Run
populateMinds().catch(error => {
  console.error('❌ Error:', error.message);
  process.exit(1);
});
