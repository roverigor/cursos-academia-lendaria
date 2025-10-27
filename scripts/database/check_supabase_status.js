#!/usr/bin/env node
/**
 * Check Supabase database status
 * Shows counts for all MMOS-related tables
 */

const { Client } = require('pg');
require('dotenv').config();

const SUPABASE_DB_URL = process.env.SUPABASE_DB_URL;

if (!SUPABASE_DB_URL) {
  console.error('❌ SUPABASE_DB_URL not set in .env');
  process.exit(1);
}

async function checkSupabaseStatus() {
  const client = new Client({
    connectionString: SUPABASE_DB_URL.replace(/\?sslmode=require/, ''),
    ssl: { rejectUnauthorized: false }
  });

  try {
    await client.connect();
    console.log('✅ Connected to Supabase\n');

    const tables = [
      'minds',
      'sources',
      'fragments',
      'domains',
      'specializations',
      'skills',
      'traits',
      'trait_scores',
      'tags',
      'categories',
      'mmos_id_mappings',
      'mind_profiles',
      'mind_proficiencies'
    ];

    console.log('📊 Table Counts:');
    console.log('─'.repeat(50));

    for (const table of tables) {
      try {
        const result = await client.query(`SELECT COUNT(*) as count FROM ${table}`);
        const count = parseInt(result.rows[0].count);
        const icon = count > 0 ? '✅' : '⚪';
        console.log(`${icon} ${table.padEnd(25)} ${count.toString().padStart(6)} rows`);
      } catch (err) {
        console.log(`❌ ${table.padEnd(25)} (table not found)`);
      }
    }

    console.log('─'.repeat(50));
    console.log('\n✅ Status check complete');

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  } finally {
    await client.end();
  }
}

checkSupabaseStatus();
