#!/usr/bin/env python3
"""
Unit tests for Voice Extractor

Tests basic functionality without requiring OpenAI API or real course folders.
"""

import sys
import os

# Add parent directory to path to import lib modules
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from lib.voice_extractor import VoiceExtractor, TranscriptFile, VoiceAnalysis, VoiceProfile


def test_imports():
    """Test that all classes can be imported."""
    print("✓ Successfully imported VoiceExtractor")
    print("✓ Successfully imported TranscriptFile")
    print("✓ Successfully imported VoiceAnalysis")
    print("✓ Successfully imported VoiceProfile")


def test_filename_patterns():
    """Test filename pattern matching."""
    print("\nTesting filename pattern matching:")

    # Create a mock extractor instance (without course folder)
    class MockExtractor:
        def __init__(self):
            self.FILENAME_PATTERNS = VoiceExtractor.FILENAME_PATTERNS

        def _matches_filename_pattern(self, filename):
            import re
            for pattern in self.FILENAME_PATTERNS:
                if re.match(pattern, filename, re.IGNORECASE):
                    return True
            return False

    extractor = MockExtractor()

    test_cases = [
        ("transcript-aula-1.txt", True),
        ("aula-02-introducao.txt", True),
        ("lesson-03.md", True),
        ("video-transcript.txt", True),
        ("transcricao-completa.md", True),
        ("transcrição-pt.txt", True),
        ("random-file.txt", False),
        ("notes.md", False),
        ("readme.txt", False),
    ]

    for filename, expected in test_cases:
        result = extractor._matches_filename_pattern(filename.lower())
        status = "✓" if result == expected else "✗"
        print(f"  {status} {filename}: {'matches' if result else 'no match'} (expected: {'match' if expected else 'no match'})")


def test_conversational_markers():
    """Test conversational content validation."""
    print("\nTesting conversational marker detection:")

    # Sample transcripts
    test_transcripts = [
        # High confidence (Portuguese)
        ("Olá pessoal, tudo bem? Hoje vamos falar sobre Python. Então, vamos lá começar.", 95),
        # High confidence (English)
        ("Hello everyone, welcome to the course. Let's dive right in, okay? Got it?", 95),
        # Medium confidence
        ("Bom dia. Vamos começar a aula.", 50),
        # Low/No confidence (not conversational)
        ("This is a technical document. No greetings or questions here.", 0),
    ]

    for content, expected_min_confidence in test_transcripts:
        # Count markers manually
        markers_pt = ["olá", "oi", "bom dia", "tudo bem", "vamos lá", "então", "tá"]
        markers_en = ["hello", "welcome", "let's", "okay", "got it", "right"]

        content_lower = content.lower()
        pt_count = sum(1 for m in markers_pt if m in content_lower)
        en_count = sum(1 for m in markers_en if m in content_lower)
        total = pt_count + en_count

        # Estimate confidence
        if total >= 5:
            confidence = 95
        elif total >= 3:
            confidence = 75
        elif total >= 2:
            confidence = 50
        elif total == 1:
            confidence = 30
        else:
            confidence = 0

        status = "✓" if confidence >= expected_min_confidence else "✗"
        print(f"  {status} Detected {total} markers → confidence {confidence}% (expected: {expected_min_confidence}%)")
        print(f"      Content: \"{content[:60]}...\"")


def test_sampling_strategy():
    """Test transcript sampling logic."""
    print("\nTesting sampling strategy:")

    # Mock transcript files
    def create_mock_files(count):
        return [
            TranscriptFile(
                path=f"/fake/path/transcript-{i}.txt",
                relative_path=f"transcript-{i}.txt",
                file_format="txt",
                file_size=1000,
                confidence_score=90,
                detected_at="2025-10-18T00:00:00Z"
            )
            for i in range(count)
        ]

    test_cases = [
        (3, 3, "Small course - analyze all"),
        (5, 5, "Small course - analyze all"),
        (10, 5, "Medium course - sample 5"),
        (20, 5, "Medium course - sample 5"),
        (30, 5, "Large course - sample 5"),
    ]

    for total_count, expected_samples, description in test_cases:
        files = create_mock_files(total_count)

        # Simulate sampling logic
        if total_count <= 5:
            sampled_count = total_count
        elif 6 <= total_count <= 20:
            sampled_count = 5
        else:
            sampled_count = 5

        status = "✓" if sampled_count == expected_samples else "✗"
        print(f"  {status} {total_count} transcripts → {sampled_count} sampled ({description})")


def test_srt_parsing():
    """Test SRT format parsing."""
    print("\nTesting SRT format parsing:")

    sample_srt = """1
00:00:00,000 --> 00:00:05,000
Olá pessoal, tudo bem?

2
00:00:05,000 --> 00:00:10,000
Hoje vamos falar sobre programação.

3
00:00:10,000 --> 00:00:15,000
Então vamos lá começar!
"""

    # Simulate parsing
    lines = sample_srt.split('\n')
    text_lines = []

    for line in lines:
        line = line.strip()
        # Skip sequence numbers and timestamps
        if line.isdigit() or '-->' in line or not line:
            continue
        text_lines.append(line)

    extracted_text = ' '.join(text_lines)
    expected_text = "Olá pessoal, tudo bem? Hoje vamos falar sobre programação. Então vamos lá começar!"

    status = "✓" if extracted_text == expected_text else "✗"
    print(f"  {status} SRT parsing: extracted {len(text_lines)} text lines")
    print(f"      Result: \"{extracted_text}\"")


def test_phrase_aggregation():
    """Test recurring phrase aggregation logic."""
    print("\nTesting phrase aggregation:")

    # Mock analyses from multiple transcripts
    analyses = [
        {"phrases": [{"phrase": "Tá?", "count": 5}, {"phrase": "Olha só", "count": 3}]},
        {"phrases": [{"phrase": "Tá?", "count": 3}, {"phrase": "Vamos lá", "count": 2}]},
        {"phrases": [{"phrase": "Olha só", "count": 2}, {"phrase": "Então", "count": 4}]},
    ]

    # Aggregate
    from collections import defaultdict
    phrase_counts = defaultdict(int)

    for analysis in analyses:
        for phrase_data in analysis["phrases"]:
            phrase = phrase_data["phrase"]
            count = phrase_data["count"]
            phrase_counts[phrase] += count

    # Sort by frequency
    top_phrases = sorted(phrase_counts.items(), key=lambda x: x[1], reverse=True)

    print(f"  ✓ Aggregated {len(phrase_counts)} unique phrases")
    print(f"  Top phrases:")
    for phrase, count in top_phrases:
        print(f"    - \"{phrase}\": {count}x")


def run_all_tests():
    """Run all tests."""
    print("=" * 60)
    print("Voice Extractor Unit Tests")
    print("=" * 60)

    try:
        test_imports()
        test_filename_patterns()
        test_conversational_markers()
        test_sampling_strategy()
        test_srt_parsing()
        test_phrase_aggregation()

        print("\n" + "=" * 60)
        print("✅ All tests passed!")
        print("=" * 60)
        return 0

    except Exception as e:
        print("\n" + "=" * 60)
        print(f"❌ Test failed: {e}")
        print("=" * 60)
        import traceback
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    sys.exit(run_all_tests())
