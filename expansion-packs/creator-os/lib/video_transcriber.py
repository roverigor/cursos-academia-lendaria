#!/usr/bin/env python3
"""
Video → Audio → Transcript automation for CreatorOS brownfield workflows.

This helper scans `outputs/courses/{slug}/sources/videos/`, converts each video
to MP3 using ffmpeg, generates transcripts with AssemblyAI, and standardizes
filenames using the `lesson{index}` convention expected by downstream tooling.
"""

from __future__ import annotations

import os
import shutil
import subprocess
import time
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Iterable, List, Optional

import requests


class VideoProcessingError(Exception):
    """Base exception for media automation errors."""


class MissingDependencyError(VideoProcessingError):
    """Raised when ffmpeg/whisper are not installed."""

    def __init__(self, dependency: str, instructions: str):
        self.dependency = dependency
        self.instructions = instructions
        super().__init__(f"{dependency} not available: {instructions}")


@dataclass
class VideoProcessingSummary:
    """Report returned after processing videos."""

    videos_found: int = 0
    converted: int = 0
    transcribed: int = 0
    renamed: int = 0
    skipped_existing: int = 0
    errors: List[str] = field(default_factory=list)
    audio_dir: Optional[str] = None
    transcript_dir: Optional[str] = None


class VideoTranscriber:
    """
    Convert videos to MP3 and generate transcripts for brownfield courses.
    """

    VIDEO_EXTENSIONS = {
        ".mp4",
        ".mov",
        ".avi",
        ".mkv",
        ".webm",
        ".flv",
        ".wmv",
    }

    def __init__(
        self,
        course_slug: str,
        *,
        language: Optional[str] = None,
        model_name: Optional[str] = None,
        rename_videos: bool = True,
        force: bool = False,
    ):
        self.course_slug = course_slug
        self.base_path = Path("outputs/courses") / course_slug
        self.video_dir = self.base_path / "sources" / "videos"
        self.audio_dir = self.base_path / "sources" / "audio"
        self.transcript_dir = self.base_path / "sources" / "transcripts"
        self.language = language or os.getenv("CREATOROS_TRANSCRIPTION_LANGUAGE", "pt-BR")
        self.model_name = model_name or os.getenv("CREATOROS_ASSEMBLY_MODEL", "best")
        self.rename_videos = rename_videos
        self.force = force
        self._ffmpeg = shutil.which("ffmpeg")
        self._api_key = os.getenv("ASSEMBLYAI_API_KEY")

    def process(self) -> VideoProcessingSummary:
        """
        Convert and transcribe every video found under sources/videos.
        """
        summary = VideoProcessingSummary()

        if not self.video_dir.exists():
            return summary

        videos = sorted(
            [
                path
                for path in self.video_dir.iterdir()
                if path.is_file() and path.suffix.lower() in self.VIDEO_EXTENSIONS
            ],
            key=lambda p: p.name.lower(),
        )

        summary.videos_found = len(videos)

        if not videos:
            return summary

        if not self._ffmpeg:
            raise MissingDependencyError(
                "ffmpeg",
                "Install it via `brew install ffmpeg` or `sudo apt install ffmpeg`.",
            )

        if not self._api_key:
            raise MissingDependencyError(
                "ASSEMBLYAI_API_KEY",
                "Define ASSEMBLYAI_API_KEY in your environment (.env) to enable transcription.",
            )

        self.audio_dir.mkdir(parents=True, exist_ok=True)
        self.transcript_dir.mkdir(parents=True, exist_ok=True)

        for index, video_path in enumerate(videos, 1):
            base_name = f"lesson{index}"
            current_video = video_path

            try:
                if self.rename_videos:
                    current_video = self._rename_video(video_path, base_name, summary)

                mp3_path = self.audio_dir / f"{base_name}.mp3"
                transcript_path = self.transcript_dir / f"{base_name}.transcript.md"

                if not mp3_path.exists() or self.force:
                    self._convert_video_to_mp3(current_video, mp3_path)
                    summary.converted += 1
                else:
                    summary.skipped_existing += 1

                if not transcript_path.exists() or self.force:
                    try:
                        relative_video = current_video.relative_to(self.base_path)
                    except ValueError:
                        relative_video = Path(current_video.name)

                    text = self._transcribe_audio(mp3_path)
                    self._write_transcript(
                        transcript_path,
                        text,
                        base_name,
                        relative_video,
                    )
                    summary.transcribed += 1
                else:
                    summary.skipped_existing += 1

            except MissingDependencyError:
                raise
            except VideoProcessingError as exc:
                summary.errors.append(str(exc))
            except Exception as exc:  # noqa: BLE001
                summary.errors.append(f"{current_video.name}: {exc}")

        summary.audio_dir = str(self.audio_dir)
        summary.transcript_dir = str(self.transcript_dir)
        return summary

    def _rename_video(
        self, path: Path, base_name: str, summary: VideoProcessingSummary
    ) -> Path:
        """Rename video to lesson{n}.ext (if possible)."""
        target = path.with_name(f"{base_name}{path.suffix.lower()}")

        if target == path:
            return path

        if target.exists():
            return path  # Avoid accidental overwrite

        path.rename(target)
        summary.renamed += 1
        return target

    def _convert_video_to_mp3(self, video_path: Path, mp3_path: Path) -> None:
        """Use ffmpeg to extract audio."""
        cmd = [
            self._ffmpeg,
            "-y",
            "-i",
            str(video_path),
            "-vn",
            "-acodec",
            "mp3",
            str(mp3_path),
        ]

        result = subprocess.run(  # noqa: PLW1510
            cmd, capture_output=True, text=True, check=False
        )

        if result.returncode != 0:
            raise VideoProcessingError(
                f"{video_path.name}: ffmpeg failed ({result.stderr.strip()})"
            )

    def _transcribe_audio(self, mp3_path: Path) -> str:
        """Transcribe audio using AssemblyAI."""
        if not mp3_path.exists():
            raise VideoProcessingError(
                f"Audio file not found for transcription: {mp3_path}"
            )

        upload_url = self._upload_audio(mp3_path)
        transcript_id = self._request_transcription(upload_url)
        return self._poll_transcription(transcript_id)

    def _upload_audio(self, mp3_path: Path) -> str:
        headers = {
            "authorization": self._api_key,
            "content-type": "application/octet-stream",
        }

        def read_file() -> Iterable[bytes]:
            with open(mp3_path, "rb") as f:
                while True:
                    data = f.read(5 * 1024 * 1024)
                    if not data:
                        break
                    yield data

        response = requests.post(
            "https://api.assemblyai.com/v2/upload",
            headers=headers,
            data=read_file(),
            timeout=120,
        )
        response.raise_for_status()
        return response.json()["upload_url"]

    def _request_transcription(self, upload_url: str) -> str:
        headers = {
            "authorization": self._api_key,
            "content-type": "application/json",
        }
        payload = {
            "audio_url": upload_url,
            "language_code": self.language,
            "speech_model": self.model_name,
        }

        response = requests.post(
            "https://api.assemblyai.com/v2/transcript",
            json=payload,
            headers=headers,
            timeout=30,
        )
        response.raise_for_status()
        data = response.json()
        return data["id"]

    def _poll_transcription(self, transcript_id: str) -> str:
        headers = {"authorization": self._api_key}
        endpoint = f"https://api.assemblyai.com/v2/transcript/{transcript_id}"

        for _ in range(120):  # ~6 minutes max
            resp = requests.get(endpoint, headers=headers, timeout=15)
            resp.raise_for_status()
            data = resp.json()
            status = data.get("status")

            if status == "completed":
                return data.get("text", "").strip()
            if status == "error":
                raise VideoProcessingError(
                    data.get("error", "Unknown error from AssemblyAI")
                )

            time.sleep(3)

        raise VideoProcessingError(
            "AssemblyAI transcription timed out after waiting several minutes."
        )

    def _write_transcript(
        self,
        transcript_path: Path,
        text: str,
        base_name: str,
        relative_video_path: Path,
    ) -> None:
        """Persist transcript with lightweight metadata header."""
        header = [
            "---",
            f"title: \"{base_name} transcript\"",
            f"source_video: {relative_video_path.as_posix()}",
            f"generated_at: {datetime.utcnow().isoformat()}Z",
            f"whisper_model: {self.model_name}",
            f"language: {self.language or 'auto'}",
            "---",
            "",
        ]

        body = text if text else "(No speech detected in audio track.)"

        transcript_path.write_text("\n".join(header) + body + "\n", encoding="utf-8")
