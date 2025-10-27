#!/usr/bin/env python3
"""
Market Research Runner Script for CreatorOS
Wrapper script that integrates MarketResearcher with Claude Code agent execution

This script provides a bridge between:
1. Python lib/market_researcher.py (data structures, analysis, report generation)
2. Claude Code agent (WebSearch/WebFetch tool execution)

Usage (Agent-based):
    1. Agent calls this script with course slug
    2. Script loads course context and generates queries
    3. Agent executes WebSearch/WebFetch for each query
    4. Agent passes results back to script
    5. Script analyzes and generates reports

Usage (CLI):
    python scripts/run_market_research.py <course-slug>

Author: CreatorOS Team
Version: 1.0.0
"""

import sys
import json
from pathlib import Path

# Add lib to path
sys.path.insert(0, str(Path(__file__).parent.parent / "lib"))

from market_researcher import (
    MarketResearcher,
    CourseMetadata,
    SearchQuery
)


def run_research_interactive(course_slug: str) -> int:
    """
    Run market research in interactive mode.

    This mode:
    1. Generates search queries
    2. Prints queries for agent to execute
    3. Waits for agent to provide results
    4. Processes results and generates reports

    Args:
        course_slug: Course identifier

    Returns:
        Exit code (0 = success, 1 = error)
    """
    course_path = f"outputs/courses/{course_slug}"

    print(f"\n{'='*70}")
    print(f"CreatorOS Market Research - Interactive Agent Mode")
    print(f"{'='*70}\n")

    try:
        # Initialize researcher
        researcher = MarketResearcher(
            course_path=course_path,
            depth="medium",
            focus="balanced"
        )

        # Load course context
        print("📋 Step 1: Loading course context...")
        researcher._load_course_context()

        # Generate search queries
        print("\n🔍 Step 2: Generating search queries...")
        queries = researcher._generate_search_queries()

        print("\n" + "="*70)
        print("📤 AGENT ACTION REQUIRED: Execute these searches")
        print("="*70 + "\n")

        for i, query in enumerate(queries, 1):
            print(f"{i}. Query: \"{query.query}\"")
            print(f"   Category: {query.category}")
            print(f"   Priority: P{query.priority}")
            print()

        print("Instructions for Agent:")
        print("1. For each query above, use WebSearch tool")
        print("2. Collect top 10-15 results per query")
        print("3. For top 8-12 courses, use WebFetch to extract:")
        print("   - Course title, URL, platform")
        print("   - Duration, price, rating")
        print("   - Curriculum structure (if available)")
        print("   - Student reviews/feedback")
        print()
        print("4. Save results to JSON format:")
        print(f"   outputs/courses/{course_slug}/research/web-search-results.json")
        print()
        print("Expected JSON structure:")
        print(json.dumps({
            "queries_executed": len(queries),
            "courses_found": [
                {
                    "title": "Example Course",
                    "url": "https://example.com/course",
                    "platform": "Udemy",
                    "duration_hours": 10.0,
                    "price": "$89",
                    "rating": 4.5,
                    "review_count": 1000,
                    "is_free": False,
                    "has_certificate": True
                }
            ]
        }, indent=2))

        print("\n" + "="*70)
        print("⏸️  Pausing for agent execution...")
        print("="*70)
        print("\nAfter agent completes searches, run:")
        print(f"  python scripts/run_market_research.py {course_slug} --process-results")
        print()

        # Save queries for reference
        queries_path = Path(course_path) / "research" / "generated-queries.json"
        queries_path.parent.mkdir(parents=True, exist_ok=True)

        queries_data = [
            {
                "query": q.query,
                "category": q.category,
                "priority": q.priority
            }
            for q in queries
        ]

        queries_path.write_text(json.dumps(queries_data, indent=2))
        print(f"✓ Saved queries to: {queries_path}")

        return 0

    except Exception as e:
        print(f"\n❌ ERROR: {e}")
        import traceback
        traceback.print_exc()
        return 1


def process_search_results(course_slug: str) -> int:
    """
    Process web search results provided by agent and generate reports.

    Args:
        course_slug: Course identifier

    Returns:
        Exit code (0 = success, 1 = error)
    """
    course_path = f"outputs/courses/{course_slug}"
    results_path = Path(course_path) / "research" / "web-search-results.json"

    print(f"\n{'='*70}")
    print(f"CreatorOS Market Research - Processing Results")
    print(f"{'='*70}\n")

    if not results_path.exists():
        print(f"❌ ERROR: Search results not found at {results_path}")
        print("\nPlease ensure agent has executed searches and saved results.")
        return 1

    try:
        # Load search results
        print(f"📂 Loading search results from {results_path}...")
        results_data = json.loads(results_path.read_text())

        # Convert to CourseMetadata objects
        courses = []
        for course_data in results_data.get("courses_found", []):
            courses.append(CourseMetadata(**course_data))

        print(f"  ✓ Loaded {len(courses)} courses")

        # Initialize researcher
        researcher = MarketResearcher(course_path=course_path)
        researcher._load_course_context()

        # Process results
        print("\n📊 Analyzing course content...")
        curriculum_data, feedback_data = researcher._analyze_course_content(courses)

        print("🎯 Identifying patterns and gaps...")
        patterns, gaps, opportunities = researcher._analyze_patterns_and_gaps(
            curriculum_data,
            feedback_data
        )

        # Build research results object manually
        from market_researcher import MarketResearchResult
        from datetime import datetime

        research_results = MarketResearchResult(
            course_slug=course_slug,
            research_date=datetime.now().strftime("%Y-%m-%d"),
            courses_analyzed=len(courses),
            research_duration_minutes=0,  # Agent execution time not tracked
            courses_found=courses,
            common_patterns=patterns,
            content_gaps=gaps,
            differentiation_opportunities=opportunities,
            market_maturity=researcher._assess_market_maturity(courses),
            average_price=researcher._calculate_average_price(courses),
            average_duration=researcher._calculate_average_duration(courses),
            average_rating=researcher._calculate_average_rating(courses),
            positioning_statement=researcher._generate_positioning_statement(gaps, opportunities)
        )

        # Generate reports
        print("\n📝 Generating reports...")
        reports = researcher.generate_reports(research_results)

        print(f"\n{'='*70}")
        print("✅ MARKET RESEARCH COMPLETE!")
        print(f"{'='*70}\n")

        print(f"📊 Research Summary:")
        print(f"   - Courses Analyzed: {len(courses)}")
        print(f"   - Content Gaps Found: {len(gaps)}")
        print(f"   - Differentiation Opportunities: {len(opportunities)}")
        print(f"   - Market Maturity: {research_results.market_maturity.title()}")

        print(f"\n📂 Research Files Created:")
        for name, path in reports.items():
            print(f"   ✅ {path}")

        print(f"\n🚀 Next Step:")
        print(f"   @course-architect *reformulate-course-brief {course_slug}")

        return 0

    except Exception as e:
        print(f"\n❌ ERROR: {e}")
        import traceback
        traceback.print_exc()
        return 1


def main():
    """Main CLI interface."""
    import argparse

    parser = argparse.ArgumentParser(
        description="CreatorOS Market Research Runner",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Start research (generates queries for agent)
  python scripts/run_market_research.py my-course

  # Process results after agent execution
  python scripts/run_market_research.py my-course --process-results

Agent Workflow:
  1. Run script to generate queries
  2. Agent executes WebSearch/WebFetch for each query
  3. Agent saves results to research/web-search-results.json
  4. Run script with --process-results to analyze and generate reports
        """
    )

    parser.add_argument(
        "course_slug",
        help="Course slug (e.g., 'my-course')"
    )

    parser.add_argument(
        "--process-results",
        action="store_true",
        help="Process existing search results instead of generating queries"
    )

    args = parser.parse_args()

    if args.process_results:
        return process_search_results(args.course_slug)
    else:
        return run_research_interactive(args.course_slug)


if __name__ == "__main__":
    sys.exit(main())
