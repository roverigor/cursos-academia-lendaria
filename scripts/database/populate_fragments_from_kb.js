#!/usr/bin/env node
/**
 * Populate Supabase fragments table from outputs/minds/*/kb/
 *
 * Reads KB files (Markdown + YAML) and inserts as fragments
 * Supports both formats:
 *   - Markdown files with YAML frontmatter (chunk-01-identity-core.md)
 *   - Pure YAML files (pc-001-valores-fundamentais.yaml)
 */

const { Client } = require('pg');
const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');
require('dotenv').config();

const SUPABASE_DB_URL = process.env.SUPABASE_DB_URL;
const OUTPUTS_MINDS_DIR = path.join(__dirname, '../../outputs/minds');

if (!SUPABASE_DB_URL) {
  console.error('❌ SUPABASE_DB_URL not set in .env');
  process.exit(1);
}

// ===========================
// UTILITIES
// ===========================

function countWords(text) {
  if (!text) return 0;
  return text.split(/\s+/).filter(w => w.length > 0).length;
}

function parseMarkdownWithYAML(content) {
  // Extract YAML frontmatter from Markdown
  const yamlMatch = content.match(/^```yaml\n([\s\S]*?)\n```/);

  let metadata = {};
  let markdownContent = content;

  if (yamlMatch) {
    try {
      metadata = yaml.load(yamlMatch[1]);
      // Remove YAML block from content
      markdownContent = content.replace(yamlMatch[0], '').trim();
    } catch (err) {
      console.warn('  ⚠️ Failed to parse YAML frontmatter:', err.message);
    }
  }

  return { metadata, content: markdownContent };
}

function parseYAMLFile(content) {
  try {
    const data = yaml.load(content);

    // YAML format: has chunk_metadata and content fields
    if (data.chunk_metadata && data.content) {
      return {
        metadata: data.chunk_metadata,
        content: data.content,
        summary: data.summary || '',
        tags: data.chunk_metadata.tags || [],
        crossRefs: data.chunk_metadata.cross_references || {}
      };
    }

    return null;
  } catch (err) {
    console.warn('  ⚠️ Failed to parse YAML:', err.message);
    return null;
  }
}

// ===========================
// FRAGMENT EXTRACTION
// ===========================

async function findKBFiles(mindsDir) {
  const fragments = [];

  const mindDirs = fs.readdirSync(mindsDir, { withFileTypes: true })
    .filter(d => d.isDirectory())
    .map(d => d.name);

  console.log(`📂 Found ${mindDirs.length} mind directories\n`);

  for (const mindSlug of mindDirs) {
    const kbDir = path.join(mindsDir, mindSlug, 'kb');

    if (!fs.existsSync(kbDir)) {
      continue;
    }

    console.log(`📖 Processing: ${mindSlug}/kb/`);

    const files = [];

    // Recursive file search
    function scanDirectory(dir) {
      const entries = fs.readdirSync(dir, { withFileTypes: true });

      for (const entry of entries) {
        const fullPath = path.join(dir, entry.name);

        if (entry.isDirectory()) {
          scanDirectory(fullPath);
        } else if (entry.name.endsWith('.md') || entry.name.endsWith('.yaml')) {
          // Skip manifest files
          if (entry.name.includes('manifest') || entry.name.includes('index')) {
            continue;
          }
          files.push(fullPath);
        }
      }
    }

    scanDirectory(kbDir);

    console.log(`  Found ${files.length} KB files`);

    for (const filePath of files) {
      const fileName = path.basename(filePath);
      const ext = path.extname(filePath);
      const content = fs.readFileSync(filePath, 'utf-8');

      let fragment = null;

      if (ext === '.md') {
        // Markdown with YAML frontmatter
        const { metadata, content: markdownContent } = parseMarkdownWithYAML(content);

        fragment = {
          mindSlug,
          fileName,
          type: metadata.category || 'knowledge_chunk',
          title: metadata.title || fileName.replace('.md', ''),
          content: markdownContent,
          layer: metadata.source_layers ? metadata.source_layers[0] : null,
          confidence: metadata.confidence ? metadata.confidence / 100 : null,
          tags: Array.isArray(metadata.tags?.primary)
            ? metadata.tags.primary
            : (Array.isArray(metadata.tags) ? metadata.tags : []),
          relatedFragments: metadata.related_chunks || [],
          metadata: {
            chunk_id: metadata.chunk_id,
            priority: metadata.priority,
            use_cases: metadata.use_cases,
            fidelity_importance: metadata.fidelity_importance,
            temporal_relevance: metadata.temporal_relevance
          }
        };
      } else if (ext === '.yaml') {
        // Pure YAML file
        const parsed = parseYAMLFile(content);

        if (!parsed) {
          console.warn(`  ⚠️ Skipping invalid YAML: ${fileName}`);
          continue;
        }

        const meta = parsed.metadata;

        fragment = {
          mindSlug,
          fileName,
          type: meta.domain || 'knowledge_chunk',
          title: meta.id || fileName.replace('.yaml', ''),
          content: parsed.content,
          layer: meta.source?.tier || null,
          confidence: meta.source?.confidence || null,
          tags: Array.isArray(meta.tags?.primary)
            ? meta.tags.primary
            : (Array.isArray(meta.tags) ? meta.tags : []),
          relatedFragments: meta.cross_references?.related_chunks || [],
          metadata: {
            chunk_id: meta.id,
            priority: meta.fidelity_importance,
            persona: meta.persona,
            temporal_relevance: meta.temporal_relevance,
            cross_references: parsed.crossRefs
          }
        };
      }

      if (fragment) {
        fragment.wordCount = countWords(fragment.content);
        fragments.push(fragment);
      }
    }

    console.log(`  ✅ Extracted ${files.length} fragments\n`);
  }

  return fragments;
}

// ===========================
// DATABASE OPERATIONS
// ===========================

async function getMindUUID(client, slug) {
  const result = await client.query(
    'SELECT id FROM minds WHERE slug = $1',
    [slug]
  );

  if (result.rows.length === 0) {
    throw new Error(`Mind not found: ${slug}`);
  }

  return result.rows[0].id;
}

async function insertFragment(client, fragment, mindId) {
  const query = `
    INSERT INTO fragments (
      mind_id,
      type,
      title,
      content,
      layer,
      confidence,
      tags,
      related_fragments,
      word_count,
      metadata
    ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
    ON CONFLICT DO NOTHING
    RETURNING id
  `;

  const values = [
    mindId,
    fragment.type,
    fragment.title,
    fragment.content,
    fragment.layer,
    fragment.confidence,
    fragment.tags,
    fragment.relatedFragments,
    fragment.wordCount,
    JSON.stringify(fragment.metadata)
  ];

  try {
    const result = await client.query(query, values);
    return result.rows.length > 0 ? result.rows[0].id : null;
  } catch (err) {
    console.error(`  ❌ Failed to insert fragment: ${fragment.title}`);
    console.error(`     Error: ${err.message}`);
    return null;
  }
}

// ===========================
// MAIN
// ===========================

async function main() {
  console.log('🚀 Populating fragments from outputs/minds/*/kb/\n');

  // 1. Find all KB files
  console.log('📂 Scanning KB directories...\n');
  const fragments = await findKBFiles(OUTPUTS_MINDS_DIR);

  console.log(`\n📊 Summary:`);
  console.log(`   Total fragments found: ${fragments.length}`);

  const byMind = {};
  for (const f of fragments) {
    byMind[f.mindSlug] = (byMind[f.mindSlug] || 0) + 1;
  }

  console.log(`   Minds with KB: ${Object.keys(byMind).length}`);
  console.log(`   Average per mind: ${(fragments.length / Object.keys(byMind).length).toFixed(1)}`);

  const totalWords = fragments.reduce((sum, f) => sum + f.wordCount, 0);
  console.log(`   Total words: ${totalWords.toLocaleString()}`);
  console.log(`   Avg words/fragment: ${(totalWords / fragments.length).toFixed(0)}\n`);

  // 2. Connect to Supabase
  console.log('🔌 Connecting to Supabase...');

  const client = new Client({
    connectionString: SUPABASE_DB_URL.replace(/\?sslmode=require/, ''),
    ssl: { rejectUnauthorized: false }
  });

  await client.connect();
  console.log('✅ Connected\n');

  // 3. Insert fragments
  console.log('💾 Inserting fragments...\n');

  let inserted = 0;
  let skipped = 0;

  for (const fragment of fragments) {
    try {
      const mindId = await getMindUUID(client, fragment.mindSlug);
      const fragmentId = await insertFragment(client, fragment, mindId);

      if (fragmentId) {
        inserted++;
        if (inserted % 10 === 0) {
          process.stdout.write(`  Inserted ${inserted}/${fragments.length}...\r`);
        }
      } else {
        skipped++;
      }
    } catch (err) {
      console.error(`  ❌ Error processing ${fragment.mindSlug}/${fragment.fileName}: ${err.message}`);
      skipped++;
    }
  }

  console.log(`\n`);
  console.log('✅ Population complete!\n');

  // 4. Validation
  console.log('🔍 Validating...');

  const result = await client.query(`
    SELECT
      COUNT(*) as total,
      COUNT(DISTINCT mind_id) as unique_minds,
      AVG(word_count) as avg_words,
      MIN(word_count) as min_words,
      MAX(word_count) as max_words,
      SUM(word_count) as total_words
    FROM fragments
    WHERE word_count > 0
  `);

  const stats = result.rows[0];

  console.log(`\n📊 Database Stats:`);
  console.log(`   Total fragments: ${stats.total}`);
  console.log(`   Unique minds: ${stats.unique_minds}`);
  console.log(`   Avg words/fragment: ${Math.round(stats.avg_words)}`);
  console.log(`   Range: ${stats.min_words}-${stats.max_words} words`);
  console.log(`   Total words: ${parseInt(stats.total_words).toLocaleString()}`);

  console.log(`\n✅ Summary:`);
  console.log(`   • New fragments inserted: ${inserted}`);
  console.log(`   • Skipped (duplicates/errors): ${skipped}`);

  await client.end();

  console.log('\n🎉 Done! Fragments ready for embedding generation.\n');
  console.log('Next step: node scripts/database/generate_embeddings.js');
}

main().catch(err => {
  console.error('❌ Fatal error:', err);
  process.exit(1);
});
