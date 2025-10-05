#!/usr/bin/env python3
"""
YouTube Channel Transcript Downloader
Downloads transcripts from all videos of a YouTube channel
"""

import sys
import os
import re
import logging
import argparse
from pathlib import Path
from typing import List, Tuple, Optional
from tqdm import tqdm

from youtube_transcript_api import (
    YouTubeTranscriptApi,
    TranscriptsDisabled,
    NoTranscriptFound,
    VideoUnavailable
)
from youtube_transcript_api.formatters import TextFormatter
from yt_dlp import YoutubeDL

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('transcript_download.log', encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)


def sanitize_filename(filename: str, max_length: int = 200) -> str:
    """
    Sanitize filename for filesystem compatibility

    Args:
        filename: Raw filename string
        max_length: Maximum filename length

    Returns:
        Sanitized filename string
    """
    # Remove invalid characters
    filename = re.sub(r'[<>:"/\\|?*]', '-', filename)
    # Remove control characters
    filename = ''.join(char for char in filename if ord(char) >= 32)
    # Remove extra spaces and dots
    filename = re.sub(r'\s+', ' ', filename).strip()
    filename = re.sub(r'\.+$', '', filename)
    # Limit length
    if len(filename) > max_length:
        filename = filename[:max_length].rsplit(' ', 1)[0] + '...'
    return filename


def get_channel_videos(channel_url: str, max_videos: Optional[int] = None) -> List[Tuple[str, str]]:
    """
    Get list of videos from a YouTube channel

    Args:
        channel_url: URL of the YouTube channel
        max_videos: Maximum number of videos to fetch

    Returns:
        List of tuples (video_id, video_title)
    """
    ydl_opts = {
        'skip_download': True,
        'quiet': True,
        'no_warnings': True,
        'extract_flat': False,
        'playlistend': max_videos if max_videos else None,
    }

    videos_info = []

    try:
        logger.info(f"Fetching videos from: {channel_url}")
        with YoutubeDL(ydl_opts) as ydl:
            info_dict = ydl.extract_info(channel_url, download=False)

            if 'entries' not in info_dict:
                logger.error("No videos found in channel")
                return videos_info

            for video in info_dict['entries']:
                if video and 'id' in video and 'title' in video:
                    videos_info.append((video['id'], video['title']))

            logger.info(f"Found {len(videos_info)} videos")
            return videos_info

    except Exception as e:
        logger.error(f"Error fetching channel videos: {e}")
        raise


def download_transcript(
    video_id: str,
    video_title: str,
    language: str,
    output_dir: Path,
    skip_existing: bool = True
) -> bool:
    """
    Download transcript for a single video

    Args:
        video_id: YouTube video ID
        video_title: Video title for filename
        language: Language code for transcript
        output_dir: Directory to save transcript
        skip_existing: Skip if file already exists

    Returns:
        True if successful, False otherwise
    """
    # Prepare filename
    safe_title = sanitize_filename(video_title)
    output_path = output_dir / f"{safe_title}.txt"

    # Skip if exists
    if skip_existing and output_path.exists():
        logger.debug(f"Skipping existing: {safe_title}")
        return True

    try:
        # Get transcript
        transcript_list = YouTubeTranscriptApi.list_transcripts(video_id)

        # Try to find transcript in preferred language
        try:
            transcript = transcript_list.find_transcript([language])
        except:
            # Fallback to any available transcript
            logger.warning(f"Language '{language}' not available for {video_id}, trying alternatives")
            transcript = transcript_list.find_generated_transcript([language])

        # Format and save
        formatter = TextFormatter()
        formatted_transcript = formatter.format_transcript(transcript.fetch())

        output_path.write_text(formatted_transcript, encoding='utf-8')
        logger.info(f"✓ Saved: {safe_title}")
        return True

    except TranscriptsDisabled:
        logger.warning(f"Transcripts disabled: {video_id} - {video_title}")
    except NoTranscriptFound:
        logger.warning(f"No transcript found: {video_id} - {video_title}")
    except VideoUnavailable:
        logger.warning(f"Video unavailable: {video_id} - {video_title}")
    except Exception as e:
        logger.error(f"Error processing {video_id}: {e}")

    return False


def main():
    """Main function"""
    parser = argparse.ArgumentParser(
        description='Download transcripts from YouTube channel'
    )
    parser.add_argument('channel', help='YouTube channel name (without @)')
    parser.add_argument('-l', '--language', default='pt', help='Transcript language (default: pt)')
    parser.add_argument('-m', '--max-videos', type=int, help='Maximum number of videos to process')
    parser.add_argument('-o', '--output', help='Output directory (default: channel name)')
    parser.add_argument('--force', action='store_true', help='Overwrite existing transcripts')
    parser.add_argument('-v', '--verbose', action='store_true', help='Enable verbose logging')

    args = parser.parse_args()

    # Set log level
    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    # Prepare channel URL
    channel_name = args.channel.lstrip('@')
    channel_url = f'https://www.youtube.com/@{channel_name}/videos'

    # Create output directory
    output_dir = Path(args.output if args.output else channel_name)
    output_dir.mkdir(exist_ok=True)
    logger.info(f"Output directory: {output_dir}")

    # Get videos
    try:
        videos = get_channel_videos(channel_url, args.max_videos)

        if not videos:
            logger.error("No videos found")
            return 1

    except Exception as e:
        logger.error(f"Failed to get videos: {e}")
        return 1

    # Download transcripts
    success_count = 0
    failed_count = 0

    logger.info(f"Processing {len(videos)} videos...")

    for video_id, video_title in tqdm(videos, desc="Downloading transcripts"):
        success = download_transcript(
            video_id,
            video_title,
            args.language,
            output_dir,
            skip_existing=not args.force
        )

        if success:
            success_count += 1
        else:
            failed_count += 1

    # Summary
    logger.info(f"\n{'='*50}")
    logger.info(f"✓ Successfully downloaded: {success_count}")
    logger.info(f"✗ Failed/Skipped: {failed_count}")
    logger.info(f"Total processed: {len(videos)}")

    return 0


if __name__ == '__main__':
    sys.exit(main())