#!/usr/bin/env node
/**
 * Generate OpenAI embeddings for all fragments
 *
 * Uses text-embedding-3-small (1536 dimensions)
 * Processes in batches to handle API rate limits
 */

const { Client } = require('pg');
const OpenAI = require('openai');
require('dotenv').config();

const SUPABASE_DB_URL = process.env.SUPABASE_DB_URL;
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;

if (!SUPABASE_DB_URL) {
  console.error('❌ SUPABASE_DB_URL not set in .env');
  process.exit(1);
}

if (!OPENAI_API_KEY) {
  console.error('❌ OPENAI_API_KEY not set in .env');
  process.exit(1);
}

const openai = new OpenAI({ apiKey: OPENAI_API_KEY });

// Configuration
const EMBEDDING_MODEL = 'text-embedding-3-small'; // 1536 dimensions
const BATCH_SIZE = 50; // Process 50 fragments at a time
const RATE_LIMIT_DELAY = 1000; // 1 second between batches

// ===========================
// UTILITIES
// ===========================

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function truncateText(text, maxTokens = 8000) {
  // text-embedding-3-small supports 8191 tokens
  // Rough estimate: 1 token ≈ 4 characters
  const maxChars = maxTokens * 4;

  if (text.length <= maxChars) {
    return text;
  }

  return text.substring(0, maxChars) + '...';
}

// ===========================
// EMBEDDING GENERATION
// ===========================

async function generateEmbedding(text) {
  try {
    const truncated = truncateText(text);

    const response = await openai.embeddings.create({
      model: EMBEDDING_MODEL,
      input: truncated,
      encoding_format: 'float'
    });

    return response.data[0].embedding;
  } catch (err) {
    console.error(`  ❌ OpenAI API error: ${err.message}`);
    return null;
  }
}

async function generateEmbeddingsBatch(fragments) {
  const embeddings = [];

  for (const fragment of fragments) {
    // Combine title + content for better semantic representation
    const text = fragment.title
      ? `${fragment.title}\n\n${fragment.content}`
      : fragment.content;

    const embedding = await generateEmbedding(text);

    embeddings.push({
      id: fragment.id,
      embedding
    });

    // Small delay to avoid overwhelming API
    await sleep(50);
  }

  return embeddings;
}

// ===========================
// DATABASE OPERATIONS
// ===========================

async function getFragmentsWithoutEmbeddings(client, limit = null) {
  let query = `
    SELECT
      f.id,
      f.title,
      f.content,
      m.slug as mind_slug
    FROM fragments f
    INNER JOIN minds m ON m.id = f.mind_id
    WHERE f.embedding IS NULL
    ORDER BY f.created_at
  `;

  if (limit) {
    query += ` LIMIT ${limit}`;
  }

  const result = await client.query(query);
  return result.rows;
}

async function updateFragmentEmbedding(client, fragmentId, embedding) {
  if (!embedding) {
    return false;
  }

  const query = `
    UPDATE fragments
    SET embedding = $1, updated_at = now()
    WHERE id = $2
  `;

  try {
    await client.query(query, [`[${embedding.join(',')}]`, fragmentId]);
    return true;
  } catch (err) {
    console.error(`  ❌ Failed to update embedding: ${err.message}`);
    return false;
  }
}

// ===========================
// PROGRESS TRACKING
// ===========================

function displayProgress(current, total, startTime) {
  const elapsed = Date.now() - startTime;
  const rate = current / (elapsed / 1000); // fragments per second
  const remaining = (total - current) / rate;

  const percent = ((current / total) * 100).toFixed(1);
  const elapsedMin = (elapsed / 60000).toFixed(1);
  const remainingMin = (remaining / 60).toFixed(1);

  process.stdout.write(
    `  Progress: ${current}/${total} (${percent}%) | ` +
    `Elapsed: ${elapsedMin}m | ` +
    `Remaining: ~${remainingMin}m | ` +
    `Rate: ${rate.toFixed(1)}/s\r`
  );
}

// ===========================
// MAIN
// ===========================

async function main() {
  console.log('🚀 Generating embeddings for fragments\n');

  // 1. Connect to Supabase
  console.log('🔌 Connecting to Supabase...');

  const client = new Client({
    connectionString: SUPABASE_DB_URL.replace(/\?sslmode=require/, ''),
    ssl: { rejectUnauthorized: false }
  });

  await client.connect();
  console.log('✅ Connected\n');

  // 2. Count fragments without embeddings
  console.log('🔍 Checking fragments...');

  const fragments = await getFragmentsWithoutEmbeddings(client);
  const totalFragments = fragments.length;

  console.log(`   Found ${totalFragments} fragments without embeddings\n`);

  if (totalFragments === 0) {
    console.log('✅ All fragments already have embeddings!');
    await client.end();
    return;
  }

  // 3. Estimate cost
  const avgTokensPerFragment = 200; // Conservative estimate
  const totalTokens = totalFragments * avgTokensPerFragment;
  const costPer1MTokens = 0.02; // $0.020 / 1M tokens for text-embedding-3-small
  const estimatedCost = (totalTokens / 1000000) * costPer1MTokens;

  console.log('💰 Cost Estimate:');
  console.log(`   Model: ${EMBEDDING_MODEL}`);
  console.log(`   Fragments: ${totalFragments}`);
  console.log(`   Est. tokens: ${totalTokens.toLocaleString()}`);
  console.log(`   Est. cost: $${estimatedCost.toFixed(4)}\n`);

  // 4. Confirm
  if (process.argv.includes('--dry-run')) {
    console.log('🏃 Dry run mode - exiting without generating embeddings');
    await client.end();
    return;
  }

  console.log('🤖 Generating embeddings...\n');

  const startTime = Date.now();
  let processed = 0;
  let succeeded = 0;
  let failed = 0;

  // Process in batches
  for (let i = 0; i < totalFragments; i += BATCH_SIZE) {
    const batch = fragments.slice(i, i + BATCH_SIZE);

    // Generate embeddings for batch
    const embeddings = await generateEmbeddingsBatch(batch);

    // Update database
    for (const { id, embedding } of embeddings) {
      const success = await updateFragmentEmbedding(client, id, embedding);

      if (success) {
        succeeded++;
      } else {
        failed++;
      }

      processed++;
      displayProgress(processed, totalFragments, startTime);
    }

    // Rate limit delay between batches
    if (i + BATCH_SIZE < totalFragments) {
      await sleep(RATE_LIMIT_DELAY);
    }
  }

  console.log('\n');

  // 5. Final stats
  const elapsed = Date.now() - startTime;

  console.log('✅ Embedding generation complete!\n');
  console.log('📊 Stats:');
  console.log(`   Total processed: ${processed}`);
  console.log(`   Succeeded: ${succeeded}`);
  console.log(`   Failed: ${failed}`);
  console.log(`   Time: ${(elapsed / 60000).toFixed(1)} minutes`);
  console.log(`   Rate: ${(processed / (elapsed / 1000)).toFixed(1)} fragments/sec\n`);

  // 6. Validation
  console.log('🔍 Validating embeddings...');

  const validation = await client.query(`
    SELECT
      COUNT(*) as total,
      COUNT(embedding) as with_embeddings,
      COUNT(*) - COUNT(embedding) as missing_embeddings
    FROM fragments
  `);

  const stats = validation.rows[0];

  console.log(`   Total fragments: ${stats.total}`);
  console.log(`   With embeddings: ${stats.with_embeddings}`);
  console.log(`   Missing embeddings: ${stats.missing_embeddings}`);

  if (parseInt(stats.missing_embeddings) === 0) {
    console.log('\n✅ All fragments have embeddings!');
  } else {
    console.log(`\n⚠️ ${stats.missing_embeddings} fragments still missing embeddings`);
  }

  await client.end();

  console.log('\n🎉 Done! Fragments are RAG-ready.\n');
  console.log('Next step: Test RAG search');
  console.log('  node scripts/database/test_rag_search.js');
}

main().catch(err => {
  console.error('❌ Fatal error:', err);
  process.exit(1);
});
