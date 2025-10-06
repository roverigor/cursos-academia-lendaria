"""
DiffDetector - Detect source changes for brownfield updates

Compares sources/ directory with sources_master.yaml to identify:
- New sources (need processing)
- Modified sources (need reprocessing)
- Missing sources (in master but not on disk)
"""

import hashlib
import yaml
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Any
from datetime import datetime


@dataclass
class SourceInfo:
    """Information about a source file"""
    path: str
    type: str  # book, interview, article, etc.
    size: int
    hash: Optional[str] = None
    title: Optional[str] = None
    year: Optional[int] = None


@dataclass
class SourceDiff:
    """Represents a difference in sources"""
    path: str
    type: str  # 'new' | 'modified' | 'missing'
    details: Dict[str, Any] = field(default_factory=dict)
    priority: str = 'medium'  # 'high' | 'medium' | 'low'


class DiffDetector:
    """Detects differences between sources/ directory and sources_master.yaml"""

    def __init__(self, mind_dir: Path):
        self.mind_dir = Path(mind_dir)
        self.sources_dir = self.mind_dir / "sources"
        self.master_file = self.sources_dir / "sources_master.yaml"

        # Source type to priority mapping
        self.type_priority = {
            'interview': 'high',
            'book': 'high',
            'article': 'medium',
            'podcast': 'high',
            'video': 'medium',
            'social_media': 'low'
        }

    def detect(self) -> Dict[str, List[SourceDiff]]:
        """
        Detect source differences

        Returns:
            {
                'new_sources': [...],
                'modified_sources': [...],
                'missing_sources': [...]
            }
        """
        # Scan sources directory
        disk_sources = self._scan_directory()

        # Load sources_master.yaml (or create if missing)
        master_sources = self._load_master_yaml()

        # Compare and identify diffs
        return self._compare(disk_sources, master_sources)

    def _scan_directory(self) -> Dict[str, SourceInfo]:
        """Recursively scan sources/ directory"""
        sources = {}

        if not self.sources_dir.exists():
            return sources

        # Scan all files recursively
        for file_path in self.sources_dir.rglob('*'):
            if file_path.is_file() and file_path.name != 'sources_master.yaml':
                # Determine source type from directory structure
                relative_path = file_path.relative_to(self.sources_dir)
                source_type = self._infer_type(relative_path)

                sources[str(relative_path)] = SourceInfo(
                    path=str(relative_path),
                    type=source_type,
                    size=file_path.stat().st_size,
                    hash=self._compute_hash(file_path),
                    title=file_path.stem
                )

        return sources

    def _load_master_yaml(self) -> Dict[str, SourceInfo]:
        """Load and parse sources_master.yaml"""
        if not self.master_file.exists():
            print(f"[WARN] {self.master_file} not found")
            print("[INFO] Generating sources_master.yaml from current state...")
            self._generate_master_from_disk()
            return {}

        try:
            with open(self.master_file, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f) or {}
        except UnicodeDecodeError:
            # Fallback to latin-1 for legacy files
            with open(self.master_file, 'r', encoding='latin-1') as f:
                data = yaml.safe_load(f) or {}

        sources = {}
        for entry in data.get('sources', []):
            sources[entry['path']] = SourceInfo(
                path=entry['path'],
                type=entry.get('type', 'unknown'),
                size=entry.get('size', 0),
                hash=entry.get('hash'),
                title=entry.get('title'),
                year=entry.get('year')
            )

        return sources

    def _compare(self, disk_sources: Dict[str, SourceInfo],
                 master_sources: Dict[str, SourceInfo]) -> Dict[str, List[SourceDiff]]:
        """Compare disk vs master, identify new/modified/missing"""
        result = {
            'new_sources': [],
            'modified_sources': [],
            'missing_sources': []
        }

        # Find new and modified sources
        for path, disk_info in disk_sources.items():
            if path not in master_sources:
                # New source
                priority = self.type_priority.get(disk_info.type, 'medium')
                result['new_sources'].append(SourceDiff(
                    path=path,
                    type='new',
                    details={
                        'source_type': disk_info.type,
                        'size': disk_info.size,
                        'hash': disk_info.hash,
                        'title': disk_info.title
                    },
                    priority=priority
                ))
            else:
                master_info = master_sources[path]
                # Check if modified (size or hash different)
                if disk_info.size != master_info.size or (
                    disk_info.hash and master_info.hash and disk_info.hash != master_info.hash
                ):
                    priority = self.type_priority.get(disk_info.type, 'medium')
                    result['modified_sources'].append(SourceDiff(
                        path=path,
                        type='modified',
                        details={
                            'source_type': disk_info.type,
                            'old_size': master_info.size,
                            'new_size': disk_info.size,
                            'old_hash': master_info.hash,
                            'new_hash': disk_info.hash
                        },
                        priority=priority
                    ))

        # Find missing sources
        for path, master_info in master_sources.items():
            if path not in disk_sources:
                result['missing_sources'].append(SourceDiff(
                    path=path,
                    type='missing',
                    details={
                        'source_type': master_info.type,
                        'last_size': master_info.size,
                        'status': 'not_found'
                    },
                    priority='low'
                ))

        return result

    def _infer_type(self, relative_path: Path) -> str:
        """Infer source type from directory structure"""
        parts = relative_path.parts
        if len(parts) > 0:
            parent_dir = parts[0].lower()
            if 'book' in parent_dir:
                return 'book'
            elif 'interview' in parent_dir:
                return 'interview'
            elif 'article' in parent_dir:
                return 'article'
            elif 'podcast' in parent_dir:
                return 'podcast'
            elif 'video' in parent_dir:
                return 'video'
            elif 'social' in parent_dir:
                return 'social_media'

        return 'unknown'

    def _compute_hash(self, file_path: Path) -> str:
        """Compute SHA256 hash of file (first 1MB only for performance)"""
        sha256 = hashlib.sha256()
        try:
            with open(file_path, 'rb') as f:
                # Read first 1MB only
                chunk = f.read(1024 * 1024)
                sha256.update(chunk)
            return f"sha256:{sha256.hexdigest()[:16]}"  # Short hash
        except Exception as e:
            print(f"[WARN] Could not compute hash for {file_path}: {e}")
            return None

    def _generate_master_from_disk(self):
        """Generate sources_master.yaml from current disk state"""
        disk_sources = self._scan_directory()

        data = {
            'schema_version': '1.0',
            'generated_at': datetime.now().isoformat(),
            'note': 'Auto-generated from current sources/ state',
            'sources': []
        }

        for path, info in disk_sources.items():
            data['sources'].append({
                'path': info.path,
                'type': info.type,
                'size': info.size,
                'hash': info.hash,
                'title': info.title
            })

        with open(self.master_file, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, allow_unicode=True, sort_keys=False)

        print(f"[INFO] Created {self.master_file}")

    def save_report(self, diff_result: Dict[str, List[SourceDiff]], output_path: Path):
        """Save diff report to YAML"""
        data = {
            'schema_version': '1.0',
            'scan_timestamp': datetime.now().isoformat(),
            'mind': self.mind_dir.name,
            'new_sources': [],
            'modified_sources': [],
            'missing_sources': []
        }

        for diff in diff_result['new_sources']:
            data['new_sources'].append({
                'path': diff.path,
                'type': diff.details['source_type'],
                'size': diff.details['size'],
                'hash': diff.details.get('hash'),
                'priority': diff.priority
            })

        for diff in diff_result['modified_sources']:
            data['modified_sources'].append({
                'path': diff.path,
                'type': diff.details['source_type'],
                'old_size': diff.details['old_size'],
                'new_size': diff.details['new_size'],
                'old_hash': diff.details.get('old_hash'),
                'new_hash': diff.details.get('new_hash'),
                'priority': diff.priority
            })

        for diff in diff_result['missing_sources']:
            data['missing_sources'].append({
                'path': diff.path,
                'type': diff.details['source_type'],
                'status': 'not_found'
            })

        with open(output_path, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, allow_unicode=True, sort_keys=False)

        print(f"[INFO] Diff report saved to {output_path}")
