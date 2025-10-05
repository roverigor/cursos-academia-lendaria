#!/usr/bin/env python3
"""
YouTube Channel Transcript Downloader - Smart Version with Rate Limiting
"""

import sys
import os
import re
import time
import json
import random
from pathlib import Path
from datetime import datetime
from typing import List, Tuple, Optional

from youtube_transcript_api import YouTubeTranscriptApi
from youtube_transcript_api.formatters import TextFormatter
from yt_dlp import YoutubeDL


class TranscriptDownloader:
    def __init__(self, channel_name: str, language: str = 'en'):
        self.channel_name = channel_name.lstrip('@')
        self.language = language
        self.output_dir = Path(self.channel_name)
        self.progress_file = self.output_dir / '_progress.json'
        self.failed_file = self.output_dir / '_failed.json'
        self.output_dir.mkdir(exist_ok=True)

        # Rate limiting settings
        self.min_delay = 3  # minimum seconds between requests
        self.max_delay = 8  # maximum seconds between requests
        self.batch_size = 10  # process videos in batches
        self.batch_delay = 30  # delay between batches

        # Load previous progress
        self.processed = self.load_progress()
        self.failed = self.load_failed()

    def load_progress(self) -> set:
        """Load previously processed videos"""
        if self.progress_file.exists():
            try:
                with open(self.progress_file, 'r') as f:
                    return set(json.load(f))
            except:
                pass
        return set()

    def load_failed(self) -> dict:
        """Load previously failed videos"""
        if self.failed_file.exists():
            try:
                with open(self.failed_file, 'r') as f:
                    return json.load(f)
            except:
                pass
        return {}

    def save_progress(self):
        """Save progress to file"""
        with open(self.progress_file, 'w') as f:
            json.dump(list(self.processed), f)

    def save_failed(self):
        """Save failed videos to file"""
        with open(self.failed_file, 'w') as f:
            json.dump(self.failed, f, indent=2)

    def sanitize_filename(self, filename: str, max_length: int = 200) -> str:
        """Sanitize filename for filesystem"""
        filename = re.sub(r'[<>:"/\\|?*]', '-', filename)
        filename = ''.join(char for char in filename if ord(char) >= 32)
        filename = re.sub(r'\s+', ' ', filename).strip()
        filename = re.sub(r'\.+$', '', filename)
        if len(filename) > max_length:
            filename = filename[:max_length].rsplit(' ', 1)[0]
        return filename

    def get_channel_videos(self) -> List[Tuple[str, str]]:
        """Get all videos from channel"""
        channel_url = f'https://www.youtube.com/@{self.channel_name}/videos'

        ydl_opts = {
            'skip_download': True,
            'quiet': True,
            'no_warnings': True,
        }

        print(f"📥 Fetching videos from @{self.channel_name}...")

        try:
            with YoutubeDL(ydl_opts) as ydl:
                info_dict = ydl.extract_info(channel_url, download=False)

                if 'entries' not in info_dict:
                    print("❌ No videos found")
                    return []

                videos = []
                for video in info_dict['entries']:
                    if video and video.get('id') and video.get('title'):
                        videos.append((video['id'], video['title']))

                print(f"✅ Found {len(videos)} videos")
                return videos

        except Exception as e:
            print(f"❌ Error fetching videos: {e}")
            return []

    def download_transcript(self, video_id: str, video_title: str, retry_count: int = 0) -> bool:
        """Download transcript with retry logic"""

        # Skip if already processed
        if video_id in self.processed:
            return True

        # Skip if failed too many times
        if video_id in self.failed and self.failed[video_id]['retries'] >= 3:
            return False

        safe_title = self.sanitize_filename(video_title)
        output_path = self.output_dir / f"{safe_title}.txt"

        # Skip if file exists
        if output_path.exists():
            self.processed.add(video_id)
            return True

        try:
            # Get transcript with retry logic
            transcript_list = YouTubeTranscriptApi.list_transcripts(video_id)

            # Try to find best transcript
            transcript = None

            # Priority order: manual in preferred language, auto in preferred language, any
            try:
                transcript = transcript_list.find_transcript([self.language])
            except:
                try:
                    transcript = transcript_list.find_generated_transcript([self.language])
                except:
                    # Get first available
                    for t in transcript_list:
                        transcript = t
                        break

            if transcript:
                formatter = TextFormatter()
                transcript_data = transcript.fetch()
                formatted_transcript = formatter.format_transcript(transcript_data)

                # Save transcript
                output_path.write_text(formatted_transcript, encoding='utf-8')
                self.processed.add(video_id)

                # Remove from failed if it was there
                if video_id in self.failed:
                    del self.failed[video_id]

                return True

        except Exception as e:
            error_str = str(e)

            # Handle rate limiting
            if '429' in error_str or 'Too Many Requests' in error_str:
                if retry_count < 3:
                    wait_time = (retry_count + 1) * 60  # exponential backoff
                    print(f"\n⏳ Rate limited. Waiting {wait_time} seconds...")
                    time.sleep(wait_time)
                    return self.download_transcript(video_id, video_title, retry_count + 1)

            # Track failure
            if video_id not in self.failed:
                self.failed[video_id] = {
                    'title': video_title,
                    'error': error_str[:200],
                    'retries': 0,
                    'last_attempt': datetime.now().isoformat()
                }
            else:
                self.failed[video_id]['retries'] += 1
                self.failed[video_id]['last_attempt'] = datetime.now().isoformat()

        return False

    def run(self):
        """Main execution"""
        # Get videos
        videos = self.get_channel_videos()

        if not videos:
            return

        # Filter out already processed
        pending = [(vid, title) for vid, title in videos if vid not in self.processed]

        print(f"\n📊 Status:")
        print(f"  - Total videos: {len(videos)}")
        print(f"  - Already processed: {len(self.processed)}")
        print(f"  - Pending: {len(pending)}")
        print(f"  - Previously failed: {len(self.failed)}")

        if not pending:
            print("\n✅ All videos already processed!")
            return

        print(f"\n🚀 Starting download with smart rate limiting...")
        print(f"  - Delay between videos: {self.min_delay}-{self.max_delay} seconds")
        print(f"  - Batch size: {self.batch_size} videos")
        print(f"  - Batch delay: {self.batch_delay} seconds")

        success_count = 0
        failed_count = 0

        # Process in batches
        for batch_num, i in enumerate(range(0, len(pending), self.batch_size)):
            batch = pending[i:i + self.batch_size]
            print(f"\n📦 Processing batch {batch_num + 1} ({len(batch)} videos)...")

            for j, (video_id, video_title) in enumerate(batch):
                current = i + j + 1
                total = len(pending)

                print(f"[{current}/{total}] 📥 {video_title[:60]}...", end=' ')

                if self.download_transcript(video_id, video_title):
                    print("✅")
                    success_count += 1
                else:
                    print("❌")
                    failed_count += 1

                # Save progress every 5 videos
                if (current % 5) == 0:
                    self.save_progress()
                    self.save_failed()

                # Random delay between videos
                if j < len(batch) - 1:  # Don't delay after last video in batch
                    delay = random.uniform(self.min_delay, self.max_delay)
                    time.sleep(delay)

            # Save after each batch
            self.save_progress()
            self.save_failed()

            # Longer delay between batches
            if i + self.batch_size < len(pending):
                print(f"\n⏳ Batch complete. Waiting {self.batch_delay} seconds before next batch...")
                time.sleep(self.batch_delay)

        # Final save
        self.save_progress()
        self.save_failed()

        # Summary
        print(f"\n{'='*60}")
        print(f"📊 Final Summary:")
        print(f"  ✅ Successfully downloaded: {success_count}")
        print(f"  ❌ Failed: {failed_count}")
        print(f"  📁 Total transcripts: {len(self.processed)}")
        print(f"  📂 Saved to: {self.output_dir}")

        if self.failed:
            print(f"\n⚠️ Failed videos saved to: {self.failed_file}")
            print(f"   Run the script again to retry failed downloads")


def main():
    if len(sys.argv) < 2:
        print("Usage: python canal_smart.py <channel_name> [language]")
        print("Example: python canal_smart.py DanKoeTalks en")
        sys.exit(1)

    channel = sys.argv[1]
    language = sys.argv[2] if len(sys.argv) > 2 else 'en'

    downloader = TranscriptDownloader(channel, language)
    downloader.run()


if __name__ == '__main__':
    main()