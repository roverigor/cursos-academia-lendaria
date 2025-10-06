"""
Path Resolver Module

Resolves template paths with dynamic placeholders
"""

from datetime import datetime
from pathlib import Path
from typing import Dict, Optional


class PathResolver:
    """Resolves template paths with {mind}, {timestamp}, etc."""

    def __init__(self, mind: str, base_dir: str = "docs/minds"):
        """
        Initialize the PathResolver

        Args:
            mind: Mind name (e.g., 'steve_jobs')
            base_dir: Base directory for minds (default: 'docs/minds')
        """
        self.mind = mind
        self.base_dir = Path(base_dir)
        self.timestamp = datetime.now().strftime("%Y%m%d-%H%M")

    def resolve(
        self,
        template_path: str,
        version: Optional[str] = None,
        specialist: Optional[str] = None,
        topic: Optional[str] = None,
        index: Optional[int] = None,
    ) -> str:
        """
        Resolve a template path with placeholders

        Args:
            template_path: Path with {placeholders}
            version: Version number for {version}
            specialist: Specialist name for {specialist}
            topic: Topic name for {topic}
            index: Index number for {index}

        Returns:
            Resolved path string

        Example:
            >>> resolver = PathResolver('steve_jobs')
            >>> resolver.resolve('minds/{mind}/artifacts/{timestamp}-mental_models.md')
            'minds/steve_jobs/artifacts/20251005-1530-mental_models.md'
        """
        replacements = {
            '{mind}': self.mind,
            '{timestamp}': self.timestamp,
        }

        if version is not None:
            replacements['{version}'] = str(version)

        if specialist is not None:
            replacements['{specialist}'] = specialist

        if topic is not None:
            replacements['{topic}'] = topic

        if index is not None:
            replacements['{index}'] = str(index)

        resolved = template_path
        for placeholder, value in replacements.items():
            resolved = resolved.replace(placeholder, value)

        return resolved

    def get_mind_dir(self) -> Path:
        """
        Get the full path to the mind's directory

        Returns:
            Path to minds/{mind}/
        """
        return self.base_dir / self.mind

    def file_exists(self, template_path: str, **kwargs) -> bool:
        """
        Check if a resolved template path exists

        Args:
            template_path: Path with {placeholders}
            **kwargs: Additional replacements (version, specialist, etc.)

        Returns:
            True if file exists, False otherwise
        """
        resolved = self.resolve(template_path, **kwargs)
        return Path(resolved).exists()

    def ensure_dir(self, template_path: str, **kwargs) -> Path:
        """
        Ensure directory exists for a template path

        Args:
            template_path: Path with {placeholders}
            **kwargs: Additional replacements (version, specialist, etc.)

        Returns:
            Path to the directory (created if needed)
        """
        resolved = self.resolve(template_path, **kwargs)
        path = Path(resolved)
        path.parent.mkdir(parents=True, exist_ok=True)
        return path.parent
