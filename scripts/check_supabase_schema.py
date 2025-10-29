#!/usr/bin/env python3
"""
Quick script to check Supabase schema for CreatorOS tables.
"""

import os
import sys
from supabase import create_client, Client

def check_schema():
    """Check if CreatorOS tables exist in Supabase."""

    # Get credentials from environment
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_ANON_KEY")

    if not url or not key:
        print("❌ SUPABASE_URL or SUPABASE_ANON_KEY not found in environment")
        sys.exit(1)

    print(f"✓ Connecting to Supabase: {url}")

    try:
        supabase: Client = create_client(url, key)

        # Tables to check
        creator_os_tables = [
            "content_pieces",
            "course_metadata",
            "course_lessons",
            "market_research",
            "content_performance"
        ]

        print("\n" + "="*60)
        print("CHECKING CREATOR OS TABLES")
        print("="*60 + "\n")

        results = {}

        for table in creator_os_tables:
            try:
                # Try to query the table (limit 0 to avoid loading data)
                response = supabase.table(table).select("*").limit(0).execute()
                results[table] = {
                    "exists": True,
                    "columns": list(response.data[0].keys()) if response.data else []
                }
                print(f"✅ {table:25} EXISTS")

            except Exception as e:
                results[table] = {
                    "exists": False,
                    "error": str(e)
                }
                print(f"❌ {table:25} NOT FOUND")
                print(f"   Error: {str(e)[:80]}")

        # Summary
        print("\n" + "="*60)
        print("SUMMARY")
        print("="*60)

        exists_count = sum(1 for r in results.values() if r["exists"])
        total_count = len(creator_os_tables)

        print(f"\nTables found: {exists_count}/{total_count}")

        if exists_count == 0:
            print("\n⚠️  NO CREATOR OS TABLES FOUND!")
            print("    The database integration is NOT implemented yet.")
            print("    Need to create migration and implement db_persister.py")
        elif exists_count == total_count:
            print("\n✅ ALL CREATOR OS TABLES EXIST!")
            print("    Schema is ready. Code integration may be missing.")
        else:
            print("\n⚠️  PARTIAL IMPLEMENTATION")
            print(f"    Missing {total_count - exists_count} tables")

        # Check content_pieces structure if it exists
        if results.get("content_pieces", {}).get("exists"):
            print("\n" + "="*60)
            print("CHECKING content_pieces STRUCTURE")
            print("="*60)

            try:
                response = supabase.table("content_pieces").select("*").limit(1).execute()
                if response.data:
                    columns = list(response.data[0].keys())
                    print(f"\nColumns found ({len(columns)}):")
                    for col in sorted(columns):
                        print(f"  - {col}")

                    # Check for CreatorOS-specific columns
                    creator_columns = ["piece_slug", "persona_mind_id", "keywords"]
                    missing = [c for c in creator_columns if c not in columns]

                    if missing:
                        print(f"\n⚠️  Missing CreatorOS columns: {', '.join(missing)}")
                    else:
                        print("\n✅ All CreatorOS columns present")
                else:
                    print("\nTable is empty, fetching schema from first insert attempt...")

            except Exception as e:
                print(f"\n❌ Error checking structure: {e}")

        return results

    except Exception as e:
        print(f"\n❌ Connection failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    check_schema()
