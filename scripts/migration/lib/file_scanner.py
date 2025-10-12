"""
File scanning utilities for MMOS migration scripts.
Provides directory traversal and file discovery functions.
"""

from pathlib import Path
from typing import List, Set, Optional
import os


def scan_directory(directory: str, extensions: Optional[List[str]] = None,
                   recursive: bool = True, exclude_dirs: Optional[Set[str]] = None) -> List[Path]:
    """
    Scan directory for files with specified extensions.

    Args:
        directory: Directory path to scan
        extensions: List of file extensions to include (e.g., ['.md', '.yaml'])
                   If None, includes all files
        recursive: If True, scan subdirectories
        exclude_dirs: Set of directory names to exclude (e.g., {'node_modules', '.git'})

    Returns:
        List of Path objects for matching files
    """
    path = Path(directory)

    if not path.exists() or not path.is_dir():
        return []

    if exclude_dirs is None:
        exclude_dirs = {'.git', 'node_modules', '__pycache__', '.DS_Store'}

    files = []

    if recursive:
        for root, dirs, filenames in os.walk(path):
            # Filter out excluded directories
            dirs[:] = [d for d in dirs if d not in exclude_dirs]

            for filename in filenames:
                file_path = Path(root) / filename

                # Check extension if specified
                if extensions is None or file_path.suffix in extensions:
                    files.append(file_path)
    else:
        for file_path in path.iterdir():
            if file_path.is_file():
                if extensions is None or file_path.suffix in extensions:
                    files.append(file_path)

    return sorted(files)


def find_file(directory: str, filename: str, recursive: bool = True) -> Optional[Path]:
    """
    Find first file matching name in directory.

    Args:
        directory: Directory to search
        filename: Filename to find
        recursive: If True, search subdirectories

    Returns:
        Path to first matching file, or None if not found
    """
    path = Path(directory)

    if not path.exists():
        return None

    if recursive:
        for file_path in path.rglob(filename):
            if file_path.is_file():
                return file_path
    else:
        file_path = path / filename
        if file_path.is_file():
            return file_path

    return None


def count_words(file_path: str) -> int:
    """
    Count words in text file.

    Args:
        file_path: Path to file

    Returns:
        Word count, or 0 if file can't be read
    """
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
            return len(content.split())
    except Exception:
        return 0


def get_file_info(file_path: str) -> dict:
    """
    Get file metadata.

    Args:
        file_path: Path to file

    Returns:
        Dictionary with file info (size, created_at, modified_at)
    """
    path = Path(file_path)

    if not path.exists():
        return {}

    stat = path.stat()

    return {
        'size_bytes': stat.st_size,
        'created_at': stat.st_ctime,
        'modified_at': stat.st_mtime,
        'extension': path.suffix,
        'name': path.name,
        'stem': path.stem
    }


def ensure_directory(directory: str) -> bool:
    """
    Ensure directory exists (create if needed).

    Args:
        directory: Directory path

    Returns:
        True if directory exists or was created, False on error
    """
    try:
        Path(directory).mkdir(parents=True, exist_ok=True)
        return True
    except Exception:
        return False


def get_relative_path(file_path: str, base_path: str) -> str:
    """
    Get relative path from base path.

    Args:
        file_path: Full file path
        base_path: Base path to calculate relative to

    Returns:
        Relative path as string
    """
    try:
        return str(Path(file_path).relative_to(Path(base_path)))
    except ValueError:
        # If paths don't share common base, return full path
        return str(Path(file_path))


def list_directories(parent_dir: str, exclude: Optional[Set[str]] = None) -> List[Path]:
    """
    List all immediate subdirectories.

    Args:
        parent_dir: Parent directory path
        exclude: Set of directory names to exclude

    Returns:
        List of subdirectory Path objects
    """
    path = Path(parent_dir)

    if not path.exists() or not path.is_dir():
        return []

    if exclude is None:
        exclude = {'.git', 'node_modules', '__pycache__'}

    dirs = [
        p for p in path.iterdir()
        if p.is_dir() and p.name not in exclude and not p.name.startswith('.')
    ]

    return sorted(dirs)
