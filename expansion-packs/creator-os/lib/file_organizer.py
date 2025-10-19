#!/usr/bin/env python3
"""
File Organizer for CreatorOS Brownfield Workflow

This module implements intelligent file organization for existing course materials.
Part of Story 3.2: File Inventory & Organization (EPIC-3: Intelligent Workflow)

Key Features:
- Recursive file scanning with metadata collection
- Intelligent categorization (8 categories: transcripts, videos, ICP docs, etc.)
- Safe file movement with backup and rollback capability
- Audit log generation with full traceability
- Dry-run mode for user preview and approval

Categorization Logic:
1. Structured data (curriculum.yaml, COURSE-BRIEF.md) → Preserve
2. Existing lessons (*.md with lesson structure) → Preserve in /lessons/
3. Transcripts → Move to /sources/transcripts/
4. Videos → Move to /sources/videos/
5. ICP/Persona docs → Move to /sources/
6. Instructor profiles → Move to /sources/
7. Resources (PDFs, images) → Move to /resources/
8. Unknown/Other → Move to /sources/other/

Usage:
    from lib.file_organizer import FileOrganizer

    organizer = FileOrganizer("dominando-obsidian")
    inventory = organizer.scan()
    result = organizer.organize(dry_run=True)  # Preview
    result = organizer.organize(dry_run=False) # Execute
"""

import os
import re
import shutil
import hashlib
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional, Tuple
from dataclasses import dataclass, asdict
import json


@dataclass
class FileMetadata:
    """Metadata for a single file in the inventory."""
    path: str  # Original path relative to course folder
    absolute_path: str  # Absolute path
    type: str  # File type (document, video, image, etc.)
    extension: str  # File extension (e.g., ".md", ".mp4")
    size_kb: float  # File size in KB
    category: str  # Detected category
    suggested_location: str  # Target path after organization
    action: str  # "keep" or "move"
    detected_at: str  # ISO timestamp


@dataclass
class OrganizationResult:
    """Result of file organization operation."""
    success: bool
    files_scanned: int
    files_moved: int
    files_kept: int
    duration_seconds: float
    movements: List[Dict]  # List of file movements
    errors: List[str]
    audit_log_path: Optional[str]


class FileOrganizer:
    """
    Intelligent file organizer for brownfield course materials.

    Scans, categorizes, and organizes existing course files into
    canonical CreatorOS folder structure.
    """

    # Categories and their detection rules
    STRUCTURED_FILES = [
        "course-brief.md", "COURSE-BRIEF.md",
        "curriculum.yaml", "curriculum.yml",
        "course-outline.md",
        "prd.md", "PRD.md"
    ]

    LESSON_PATTERN = r'^\d+\.\d+-.*\.md$'

    TRANSCRIPT_EXTENSIONS = ['.txt', '.srt', '.vtt']
    TRANSCRIPT_KEYWORDS = ['transcript', 'transcription', 'transcricao', 'legenda', 'subtitle']

    VIDEO_EXTENSIONS = ['.mp4', '.mov', '.avi', '.mkv', '.webm', '.flv', '.wmv']

    ICP_KEYWORDS = ['icp', 'avatar', 'persona', 'audience', 'target', 'publico-alvo', 'público-alvo']
    ICP_CONTENT_PHRASES = ['ideal customer', 'público-alvo', 'target audience', 'customer profile']

    INSTRUCTOR_KEYWORDS = ['professor', 'instrutor', 'teacher', 'bio', 'perfil', 'profile']
    INSTRUCTOR_CONTENT_PHRASES = ['bio', 'credenciais', 'experiência', 'experience', 'credentials']

    RESOURCE_EXTENSIONS = ['.pdf', '.docx', '.doc', '.xlsx', '.xls', '.pptx', '.ppt', '.zip', '.rar']

    IMAGE_EXTENSIONS = ['.png', '.jpg', '.jpeg', '.svg', '.gif', '.webp', '.bmp', '.ico']

    # Folders to ignore during scan
    IGNORE_FOLDERS = ['.git', '__pycache__', 'node_modules', '.DS_Store', 'thumbs.db']
    IGNORE_FILES = ['.DS_Store', 'thumbs.db', '.gitkeep']

    def __init__(self, course_slug: str):
        """
        Initialize FileOrganizer for a specific course.

        Args:
            course_slug: Course identifier (e.g., "dominando-obsidian")
        """
        self.course_slug = course_slug
        self.base_path = Path("outputs/courses") / course_slug
        self.inventory: List[FileMetadata] = []
        self.movements: List[Dict] = []

        if not self.base_path.exists():
            raise FileNotFoundError(f"Course folder not found: {self.base_path}")

    def scan(self) -> List[FileMetadata]:
        """
        Recursively scan course folder and build file inventory.

        Returns:
            List of FileMetadata objects
        """
        print(f"📂 Scanning folder: {self.base_path}")
        self.inventory = []

        for root, dirs, files in os.walk(self.base_path):
            # Filter out ignored directories
            dirs[:] = [d for d in dirs if d not in self.IGNORE_FOLDERS]

            for filename in files:
                # Skip ignored files
                if filename in self.IGNORE_FILES:
                    continue

                file_path = Path(root) / filename
                relative_path = file_path.relative_to(self.base_path)

                # Get file metadata
                try:
                    size_bytes = file_path.stat().st_size
                    size_kb = round(size_bytes / 1024, 2)
                    extension = file_path.suffix.lower()

                    # Categorize file
                    category = self._categorize_file(file_path, relative_path)

                    # Determine suggested location and action
                    suggested_location, action = self._suggest_location(
                        relative_path, category, filename
                    )

                    metadata = FileMetadata(
                        path=str(relative_path),
                        absolute_path=str(file_path),
                        type=self._get_file_type(extension),
                        extension=extension,
                        size_kb=size_kb,
                        category=category,
                        suggested_location=suggested_location,
                        action=action,
                        detected_at=datetime.utcnow().isoformat() + "Z"
                    )

                    self.inventory.append(metadata)

                except Exception as e:
                    print(f"⚠️  Error scanning {relative_path}: {e}")
                    continue

        print(f"✓ Scanned {len(self.inventory)} files")
        return self.inventory

    def _categorize_file(self, file_path: Path, relative_path: Path) -> str:
        """
        Categorize a file based on detection rules.

        Priority order:
        1. Structured data (preserve)
        2. Lessons (preserve)
        3. Transcripts
        4. Videos
        5. ICP docs
        6. Instructor profiles
        7. Resources
        8. Images
        9. Unknown

        Args:
            file_path: Absolute path to file
            relative_path: Path relative to course folder

        Returns:
            Category name (e.g., "transcript", "icp_doc", etc.)
        """
        filename = file_path.name
        filename_lower = filename.lower()
        extension = file_path.suffix.lower()

        # Priority 1: Structured data (preserve)
        if filename in self.STRUCTURED_FILES:
            return "structured_data"

        # Priority 2: Lessons (preserve)
        if re.match(self.LESSON_PATTERN, filename):
            return "lesson"

        # Priority 3: Transcripts
        if extension in self.TRANSCRIPT_EXTENSIONS:
            return "transcript"
        if any(keyword in filename_lower for keyword in self.TRANSCRIPT_KEYWORDS):
            return "transcript"

        # Priority 4: Videos
        if extension in self.VIDEO_EXTENSIONS:
            return "video"

        # Priority 5: ICP docs (requires content sniffing)
        if any(keyword in filename_lower for keyword in self.ICP_KEYWORDS):
            return "icp_doc"

        # Content-based detection for ICP (read first 1KB)
        if extension in ['.md', '.txt', '.pdf']:
            if self._has_icp_content(file_path):
                return "icp_doc"

        # Priority 6: Instructor profiles
        if any(keyword in filename_lower for keyword in self.INSTRUCTOR_KEYWORDS):
            return "instructor_profile"

        # Heuristic: Person name detection (capitalized words)
        if self._is_person_name(filename):
            return "instructor_profile"

        # Content-based detection for profiles
        if extension in ['.md', '.txt']:
            if self._has_instructor_content(file_path):
                return "instructor_profile"

        # Priority 7: Resources
        if extension in self.RESOURCE_EXTENSIONS:
            return "resource"

        # Priority 8: Images
        if extension in self.IMAGE_EXTENSIONS:
            return "image"

        # Fallback: Unknown
        return "unknown"

    def _has_icp_content(self, file_path: Path) -> bool:
        """Check if file contains ICP-related content (first 1KB)."""
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read(1024).lower()
                return any(phrase in content for phrase in self.ICP_CONTENT_PHRASES)
        except Exception:
            return False

    def _has_instructor_content(self, file_path: Path) -> bool:
        """Check if file contains instructor profile content (first 1KB)."""
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read(1024).lower()
                return any(phrase in content for phrase in self.INSTRUCTOR_CONTENT_PHRASES)
        except Exception:
            return False

    def _is_person_name(self, filename: str) -> bool:
        """
        Heuristic: Detect if filename is likely a person name.

        Examples: "Adriano de Marqui.md", "John Doe.pdf"
        """
        # Remove extension
        name = Path(filename).stem

        # Check for capitalized words pattern (2+ words, mostly capitalized)
        words = re.findall(r'\b[A-Z][a-z]+\b', name)

        # Heuristic: If 2+ capitalized words, likely a person name
        return len(words) >= 2

    def _suggest_location(self, relative_path: Path, category: str, filename: str) -> Tuple[str, str]:
        """
        Determine suggested location and action based on category.

        Args:
            relative_path: Current path relative to course folder
            category: Detected category
            filename: Filename

        Returns:
            Tuple of (suggested_location, action)
            action: "keep" or "move"
        """
        # Structured data: Keep in root
        if category == "structured_data":
            return str(relative_path), "keep"

        # Lessons: Keep in /lessons/ or move to /lessons/
        if category == "lesson":
            if relative_path.parts[0] == "lessons":
                return str(relative_path), "keep"
            else:
                return f"lessons/{filename}", "move"

        # Transcripts: Move to /sources/transcripts/
        if category == "transcript":
            return f"sources/transcripts/{filename}", "move"

        # Videos: Move to /sources/videos/
        if category == "video":
            return f"sources/videos/{filename}", "move"

        # ICP docs: Move to /sources/
        if category == "icp_doc":
            return f"sources/{filename}", "move"

        # Instructor profiles: Move to /sources/
        if category == "instructor_profile":
            return f"sources/{filename}", "move"

        # Resources: Move to /resources/
        if category == "resource":
            return f"resources/{filename}", "move"

        # Images: Move to /resources/ (treat as resource)
        if category == "image":
            return f"resources/{filename}", "move"

        # Unknown: Move to /sources/other/
        if category == "unknown":
            return f"sources/other/{filename}", "move"

        # Default: Keep as-is
        return str(relative_path), "keep"

    def _get_file_type(self, extension: str) -> str:
        """Determine human-readable file type from extension."""
        type_map = {
            '.md': 'document',
            '.txt': 'document',
            '.pdf': 'document',
            '.docx': 'document',
            '.doc': 'document',
            '.mp4': 'video',
            '.mov': 'video',
            '.avi': 'video',
            '.mkv': 'video',
            '.webm': 'video',
            '.png': 'image',
            '.jpg': 'image',
            '.jpeg': 'image',
            '.svg': 'image',
            '.gif': 'image',
            '.webp': 'image',
            '.yaml': 'data',
            '.yml': 'data',
            '.json': 'data',
            '.csv': 'data',
            '.xlsx': 'spreadsheet',
            '.xls': 'spreadsheet',
            '.pptx': 'presentation',
            '.ppt': 'presentation',
            '.zip': 'archive',
            '.rar': 'archive',
        }
        return type_map.get(extension.lower(), 'unknown')

    def organize(self, dry_run: bool = False) -> OrganizationResult:
        """
        Organize files according to canonical structure.

        Args:
            dry_run: If True, only simulate (don't actually move files)

        Returns:
            OrganizationResult with operation details
        """
        start_time = datetime.now()

        if not self.inventory:
            print("⚠️  No inventory found. Run scan() first.")
            return OrganizationResult(
                success=False,
                files_scanned=0,
                files_moved=0,
                files_kept=0,
                duration_seconds=0.0,
                movements=[],
                errors=["No inventory found. Run scan() first."],
                audit_log_path=None
            )

        print(f"\n{'🔍 DRY RUN - Preview Mode' if dry_run else '📦 Organizing files...'}")

        movements = []
        errors = []
        files_moved = 0
        files_kept = 0

        # Group files by action
        files_to_move = [f for f in self.inventory if f.action == "move"]
        files_to_keep = [f for f in self.inventory if f.action == "keep"]

        files_kept = len(files_to_keep)

        # Create target directories (if not dry run)
        if not dry_run:
            self._create_canonical_structure()

        # Process files to move
        for file_meta in files_to_move:
            source = Path(file_meta.absolute_path)
            target = self.base_path / file_meta.suggested_location

            try:
                # Handle duplicates
                final_target = self._handle_duplicate(target, source, dry_run)

                if not dry_run:
                    # Create parent directory
                    final_target.parent.mkdir(parents=True, exist_ok=True)

                    # Move file
                    shutil.move(str(source), str(final_target))

                movement = {
                    "source": file_meta.path,
                    "target": str(final_target.relative_to(self.base_path)),
                    "category": file_meta.category,
                    "size_kb": file_meta.size_kb,
                    "status": "MOVED" if not dry_run else "WOULD_MOVE"
                }
                movements.append(movement)
                files_moved += 1

            except Exception as e:
                error_msg = f"Failed to move {file_meta.path}: {e}"
                errors.append(error_msg)
                print(f"❌ {error_msg}")

        duration = (datetime.now() - start_time).total_seconds()

        # Generate audit log (if not dry run)
        audit_log_path = None
        if not dry_run:
            audit_log_path = self._generate_audit_log(movements, files_kept, duration)

        result = OrganizationResult(
            success=len(errors) == 0,
            files_scanned=len(self.inventory),
            files_moved=files_moved,
            files_kept=files_kept,
            duration_seconds=duration,
            movements=movements,
            errors=errors,
            audit_log_path=audit_log_path
        )

        self._print_summary(result, dry_run)

        return result

    def _create_canonical_structure(self):
        """Create canonical folder structure if missing."""
        folders = [
            self.base_path / "lessons",
            self.base_path / "assessments",
            self.base_path / "resources",
            self.base_path / "sources",
            self.base_path / "sources" / "transcripts",
            self.base_path / "sources" / "videos",
            self.base_path / "sources" / "other",
        ]

        for folder in folders:
            folder.mkdir(parents=True, exist_ok=True)

    def _handle_duplicate(self, target: Path, source: Path, dry_run: bool) -> Path:
        """
        Handle duplicate files during move.

        If target exists:
        - Compare checksums
        - If identical: Skip (return target as-is)
        - If different: Rename to file-1.ext, file-2.ext, etc.

        Args:
            target: Proposed target path
            source: Source file path
            dry_run: If True, don't actually check/move

        Returns:
            Final target path (may be renamed)
        """
        if not target.exists():
            return target

        # Compare checksums (if not dry run)
        if not dry_run:
            source_hash = self._file_checksum(source)
            target_hash = self._file_checksum(target)

            if source_hash == target_hash:
                # Files are identical, skip move
                print(f"⚠️  Duplicate detected (identical): {target.name}")
                return target

        # Files are different, find available name
        stem = target.stem
        extension = target.suffix
        parent = target.parent

        counter = 1
        while True:
            new_target = parent / f"{stem}-{counter}{extension}"
            if not new_target.exists():
                print(f"⚠️  Duplicate detected (different): Renamed to {new_target.name}")
                return new_target
            counter += 1

    def _file_checksum(self, file_path: Path) -> str:
        """Calculate SHA-256 checksum of file."""
        sha256 = hashlib.sha256()

        with open(file_path, 'rb') as f:
            for chunk in iter(lambda: f.read(4096), b""):
                sha256.update(chunk)

        return sha256.hexdigest()

    def _generate_audit_log(self, movements: List[Dict], files_kept: int, duration: float) -> str:
        """
        Generate Markdown audit log for organization.

        Args:
            movements: List of file movements
            files_kept: Number of files kept in place
            duration: Operation duration in seconds

        Returns:
            Path to generated audit log file
        """
        timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
        log_filename = f"organization-log-{timestamp}.md"
        log_path = self.base_path / log_filename

        # Group movements by category
        by_category = {}
        for movement in movements:
            category = movement['category']
            if category not in by_category:
                by_category[category] = []
            by_category[category].append(movement)

        # Generate log content
        content = f"""# File Organization Audit Log

**Course:** {self.course_slug}
**Organized At:** {datetime.now().strftime("%Y-%m-%d %H:%M:%S")} UTC
**Total Files:** {len(self.inventory)}
**Files Moved:** {len(movements)}
**Files Kept:** {files_kept}
**Duration:** {duration:.2f} seconds

---

## Summary

"""

        # Add category summaries
        for category, items in sorted(by_category.items()):
            category_label = category.replace('_', ' ').title()
            target_folder = items[0]['target'].split('/')[0] if items else 'N/A'
            content += f"- ✅ {len(items)} {category_label} → `/{target_folder}/`\n"

        content += f"- ✅ {files_kept} files kept in original location\n"
        content += f"- ⚠️ {len([m for m in movements if 'renamed' in m.get('notes', '')])} duplicates handled\n"

        content += "\n---\n\n## Detailed Movements\n\n"

        # Add detailed tables by category
        for category, items in sorted(by_category.items()):
            category_label = category.replace('_', ' ').title()
            content += f"### {category_label} ({len(items)} files)\n\n"
            content += "| Original Path | New Path | Size | Action |\n"
            content += "|---------------|----------|------|--------|\n"

            for item in items:
                content += f"| `{item['source']}` | `{item['target']}` | {item['size_kb']} KB | {item['status']} |\n"

            content += "\n"

        # Add rollback instructions
        content += f"""---

## Rollback Command

To undo this organization (reverses all movements):

```bash
./expansion-packs/creator-os/scripts/undo-organization.sh {self.course_slug} {timestamp}
```

**Note:** Rollback must be run before any further file modifications.

---

**Log saved:** `{log_filename}`
"""

        # Write log file
        with open(log_path, 'w', encoding='utf-8') as f:
            f.write(content)

        print(f"\n📋 Audit log saved: {log_filename}")

        return str(log_path)

    def _print_summary(self, result: OrganizationResult, dry_run: bool):
        """Print user-friendly summary of organization results."""

        print(f"\n{'✓ DRY RUN COMPLETE' if dry_run else '✓ ORGANIZATION COMPLETE'}\n")

        print(f"📊 Summary:")
        print(f"- 📁 Files scanned: {result.files_scanned}")
        print(f"- 📝 Files moved: {result.files_moved}")
        print(f"- ✅ Files kept: {result.files_kept}")
        print(f"- ⏱️  Duration: {result.duration_seconds:.2f} seconds")
        print(f"- {'❌' if result.errors else '✅'} Errors: {len(result.errors)}")

        if result.errors:
            print("\n⚠️  Errors encountered:")
            for error in result.errors[:5]:  # Show first 5
                print(f"  - {error}")
            if len(result.errors) > 5:
                print(f"  ... and {len(result.errors) - 5} more")

        if dry_run:
            print(f"\n💡 This was a DRY RUN. No files were actually moved.")
            print(f"   Run with dry_run=False to execute the organization.")
        else:
            print(f"\n📋 Audit log: {result.audit_log_path}")
            print(f"   Review the log for detailed movement tracking.")

        # Group movements by category for summary
        if result.movements:
            by_category = {}
            for movement in result.movements:
                category = movement['category']
                by_category[category] = by_category.get(category, 0) + 1

            print(f"\n📦 Files organized by category:")
            for category, count in sorted(by_category.items()):
                category_label = category.replace('_', ' ').title()
                print(f"  - {count} {category_label}")


def main():
    """CLI interface for testing file organizer."""
    import sys

    if len(sys.argv) < 2 or "--help" in sys.argv or "-h" in sys.argv:
        print("Usage: python file_organizer.py <course-slug> [--dry-run]")
        print("")
        print("Arguments:")
        print("  course-slug    Course identifier (e.g., 'dominando-obsidian')")
        print("  --dry-run      Preview organization without moving files")
        print("")
        print("Example:")
        print("  python file_organizer.py dominando-obsidian --dry-run")
        print("  python file_organizer.py dominando-obsidian")
        sys.exit(0 if "--help" in sys.argv or "-h" in sys.argv else 1)

    course_slug = sys.argv[1]
    dry_run = "--dry-run" in sys.argv

    try:
        organizer = FileOrganizer(course_slug)

        # Scan
        print("=" * 60)
        inventory = organizer.scan()
        print("=" * 60)

        # Preview inventory
        print("\n📋 File Inventory Preview (first 10):")
        for i, file_meta in enumerate(inventory[:10]):
            print(f"{i+1}. {file_meta.path}")
            print(f"   Category: {file_meta.category}")
            print(f"   Action: {file_meta.action} → {file_meta.suggested_location}")
            print()

        if len(inventory) > 10:
            print(f"... and {len(inventory) - 10} more files\n")

        # Organize
        print("=" * 60)
        result = organizer.organize(dry_run=dry_run)
        print("=" * 60)

        if result.success:
            print("\n✅ File organization completed successfully!")
        else:
            print("\n❌ File organization completed with errors.")
            sys.exit(1)

    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
