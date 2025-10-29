#!/usr/bin/env python3
"""Simple schema checker using only standard library."""

import os
import json
import urllib.request
import urllib.error

# Read from .env file
def load_env():
    env_vars = {}
    try:
        with open('.env', 'r') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#') and '=' in line:
                    key, value = line.split('=', 1)
                    env_vars[key] = value
    except FileNotFoundError:
        pass
    return env_vars

env = load_env()
SUPABASE_URL = env.get('SUPABASE_URL', '').strip()
SUPABASE_KEY = env.get('SUPABASE_ANON_KEY', '').strip()

if not SUPABASE_URL or not SUPABASE_KEY:
    print("❌ Missing SUPABASE_URL or SUPABASE_ANON_KEY in .env")
    exit(1)

print(f"✓ Connecting to: {SUPABASE_URL}\n")
print("="*70)
print("CHECKING CREATOR OS TABLES IN SUPABASE")
print("="*70 + "\n")

tables_to_check = [
    "content_pieces",
    "course_metadata",
    "course_lessons",
    "market_research",
    "content_performance"
]

results = {}

for table in tables_to_check:
    url = f"{SUPABASE_URL}/rest/v1/{table}?select=*&limit=0"

    req = urllib.request.Request(url)
    req.add_header('apikey', SUPABASE_KEY)
    req.add_header('Authorization', f'Bearer {SUPABASE_KEY}')

    try:
        with urllib.request.urlopen(req, timeout=10) as response:
            data = json.loads(response.read().decode())
            results[table] = {
                "exists": True,
                "response": "OK"
            }
            print(f"✅ {table:30} EXISTS")
    except urllib.error.HTTPError as e:
        results[table] = {
            "exists": False,
            "error": f"HTTP {e.code}: {e.reason}"
        }
        print(f"❌ {table:30} NOT FOUND (HTTP {e.code})")
    except Exception as e:
        results[table] = {
            "exists": False,
            "error": str(e)
        }
        print(f"❌ {table:30} ERROR: {str(e)[:40]}")

# Summary
print("\n" + "="*70)
print("SUMMARY")
print("="*70)

exists_count = sum(1 for r in results.values() if r["exists"])
total_count = len(tables_to_check)

print(f"\n📊 Tables found: {exists_count}/{total_count}\n")

if exists_count == 0:
    print("⚠️  NO CREATOR OS TABLES FOUND IN SUPABASE!")
    print("\n   This means:")
    print("   • Database schema NOT created yet")
    print("   • Need to run migrations to create tables")
    print("   • Python code integration NOT implemented")
    print("\n   Next steps:")
    print("   1. Create Supabase migration SQL")
    print("   2. Run migration to create tables")
    print("   3. Implement Python integration code")

elif exists_count == total_count:
    print("✅ ALL CREATOR OS TABLES EXIST IN SUPABASE!")
    print("\n   Schema is complete. Checking Python integration next...")

else:
    print(f"⚠️  PARTIAL IMPLEMENTATION ({exists_count}/{total_count} tables)")
    print("\n   Found tables:")
    for table, result in results.items():
        if result["exists"]:
            print(f"   ✓ {table}")
    print("\n   Missing tables:")
    for table, result in results.items():
        if not result["exists"]:
            print(f"   ✗ {table}")

print("\n" + "="*70)
