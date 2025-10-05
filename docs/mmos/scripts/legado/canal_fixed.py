#!/usr/bin/env python3
"""
YouTube Channel Transcript Downloader - Fixed Version
Downloads transcripts from all videos of a YouTube channel
"""

import sys
import os
import re
import time
import json
from pathlib import Path
from typing import List, Tuple, Optional

from youtube_transcript_api import YouTubeTranscriptApi
from youtube_transcript_api.formatters import TextFormatter
from yt_dlp import YoutubeDL


def sanitize_filename(filename: str, max_length: int = 200) -> str:
    """Sanitize filename for filesystem compatibility"""
    # Remove invalid characters
    filename = re.sub(r'[<>:"/\\|?*]', '-', filename)
    # Remove control characters
    filename = ''.join(char for char in filename if ord(char) >= 32)
    # Remove extra spaces and dots
    filename = re.sub(r'\s+', ' ', filename).strip()
    filename = re.sub(r'\.+$', '', filename)
    # Limit length
    if len(filename) > max_length:
        filename = filename[:max_length].rsplit(' ', 1)[0]
    return filename


def get_channel_videos(channel_name: str) -> List[Tuple[str, str]]:
    """Get all videos from a YouTube channel"""
    channel_url = f'https://www.youtube.com/@{channel_name}/videos'

    ydl_opts = {
        'skip_download': True,
        'quiet': True,
        'no_warnings': True,
        'extract_flat': False,
    }

    videos_info = []

    try:
        print(f"📥 Fetching videos from @{channel_name}...")
        with YoutubeDL(ydl_opts) as ydl:
            info_dict = ydl.extract_info(channel_url, download=False)

            if 'entries' not in info_dict:
                print("❌ No videos found in channel")
                return videos_info

            for video in info_dict['entries']:
                if video and video.get('id') and video.get('title'):
                    videos_info.append((video['id'], video['title']))

            print(f"✅ Found {len(videos_info)} videos")
            return videos_info

    except Exception as e:
        print(f"❌ Error fetching channel videos: {e}")
        return []


def download_transcript(video_id: str, video_title: str, output_dir: Path) -> bool:
    """Download transcript for a single video"""

    # Prepare filename
    safe_title = sanitize_filename(video_title)
    output_path = output_dir / f"{safe_title}.txt"

    # Skip if exists
    if output_path.exists():
        return True

    try:
        # Get available transcripts
        transcript_list = YouTubeTranscriptApi.list_transcripts(video_id)

        # Try English first, then auto-generated
        transcript = None

        # Try manually created English
        try:
            transcript = transcript_list.find_transcript(['en'])
        except:
            pass

        # Try auto-generated English if manual not found
        if not transcript:
            try:
                transcript = transcript_list.find_generated_transcript(['en'])
            except:
                pass

        # Try any English variant
        if not transcript:
            for t in transcript_list:
                if t.language_code.startswith('en'):
                    transcript = t
                    break

        # Last resort: get first available
        if not transcript:
            transcript = next(iter(transcript_list))

        if transcript:
            # Fetch and format
            formatter = TextFormatter()
            transcript_data = transcript.fetch()
            formatted_transcript = formatter.format_transcript(transcript_data)

            # Save
            output_path.write_text(formatted_transcript, encoding='utf-8')
            return True

    except Exception as e:
        # Silent fail for individual videos
        pass

    return False


def main():
    """Main function"""

    if len(sys.argv) < 2:
        print("Usage: python canal_fixed.py <channel_name>")
        print("Example: python canal_fixed.py DanKoeTalks")
        sys.exit(1)

    channel_name = sys.argv[1].lstrip('@')

    # Create output directory
    output_dir = Path(channel_name)
    output_dir.mkdir(exist_ok=True)
    print(f"📁 Output directory: {output_dir}")

    # Get all videos
    videos = get_channel_videos(channel_name)

    if not videos:
        print("❌ No videos found")
        return 1

    # Track progress
    success = 0
    failed = 0
    total = len(videos)

    print(f"\n🎬 Processing {total} videos...\n")

    # Create progress file
    progress_file = output_dir / "_progress.json"
    processed = set()

    if progress_file.exists():
        try:
            with open(progress_file, 'r') as f:
                processed = set(json.load(f))
        except:
            pass

    # Process videos
    for i, (video_id, video_title) in enumerate(videos, 1):

        # Skip if already processed
        if video_id in processed:
            print(f"[{i}/{total}] ⏭️  Skipping (already processed): {video_title[:50]}...")
            continue

        # Try to download
        print(f"[{i}/{total}] 📥 Processing: {video_title[:50]}...", end=' ')

        if download_transcript(video_id, video_title, output_dir):
            print("✅")
            success += 1
        else:
            print("❌")
            failed += 1

        # Mark as processed
        processed.add(video_id)

        # Save progress periodically
        if i % 10 == 0:
            with open(progress_file, 'w') as f:
                json.dump(list(processed), f)

        # Small delay to be nice to YouTube
        time.sleep(0.5)

    # Save final progress
    with open(progress_file, 'w') as f:
        json.dump(list(processed), f)

    # Summary
    print(f"\n{'='*50}")
    print(f"✅ Successfully downloaded: {success}")
    print(f"❌ Failed/No transcript: {failed}")
    print(f"📊 Total processed: {total}")
    print(f"📁 Saved to: {output_dir}")

    return 0


if __name__ == '__main__':
    sys.exit(main())