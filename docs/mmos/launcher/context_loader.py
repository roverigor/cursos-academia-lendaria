"""
Context Loader Module

Loads context files for prompt injection
"""

from pathlib import Path
from typing import Dict, List, Optional
import glob


class ContextLoader:
    """Loads context files from minds/{mind}/ directory"""

    def __init__(self, mind_dir: Path):
        """
        Initialize the ContextLoader

        Args:
            mind_dir: Path to minds/{mind}/ directory
        """
        self.mind_dir = Path(mind_dir)

    def load_mind_brief(self) -> Optional[str]:
        """
        Load MIND_BRIEF.md (required context file)

        Returns:
            Content of MIND_BRIEF.md or None if not found
        """
        brief_path = self.mind_dir / "MIND_BRIEF.md"
        if brief_path.exists():
            try:
                with open(brief_path, 'r', encoding='utf-8') as f:
                    return f.read()
            except UnicodeDecodeError:
                # Fallback to latin-1 for legacy files
                with open(brief_path, 'r', encoding='latin-1') as f:
                    return f.read()
        return None

    def load_prd(self) -> Optional[str]:
        """
        Load PRD.md (optional context file)

        Returns:
            Content of docs/PRD.md or None if not found
        """
        prd_path = self.mind_dir / "docs" / "PRD.md"
        if prd_path.exists():
            try:
                with open(prd_path, 'r', encoding='utf-8') as f:
                    return f.read()
            except UnicodeDecodeError:
                # Fallback to latin-1 for legacy files
                with open(prd_path, 'r', encoding='latin-1') as f:
                    return f.read()
        return None

    def load_sources(self, max_files: int = 5) -> List[Dict[str, str]]:
        """
        Load recent source files from sources/ directory

        Args:
            max_files: Maximum number of source files to load

        Returns:
            List of dicts with 'filename' and 'content' keys
        """
        sources_dir = self.mind_dir / "sources"
        if not sources_dir.exists():
            return []

        # Get all markdown files, sorted by modification time (newest first)
        source_files = sorted(
            sources_dir.glob("*.md"),
            key=lambda p: p.stat().st_mtime,
            reverse=True
        )

        sources = []
        for source_file in source_files[:max_files]:
            try:
                with open(source_file, 'r', encoding='utf-8') as f:
                    sources.append({
                        'filename': source_file.name,
                        'content': f.read()
                    })
            except UnicodeDecodeError:
                # Fallback to latin-1 for legacy files
                try:
                    with open(source_file, 'r', encoding='latin-1') as f:
                        sources.append({
                            'filename': source_file.name,
                            'content': f.read()
                        })
                except Exception as e:
                    print(f"Warning: Could not load {source_file.name}: {e}")
            except Exception as e:
                print(f"Warning: Could not load {source_file.name}: {e}")

        return sources

    def load_recent_logs(self, max_files: int = 3) -> List[Dict[str, str]]:
        """
        Load recent log files from docs/logs/

        Args:
            max_files: Maximum number of log files to load

        Returns:
            List of dicts with 'filename' and 'content' keys
        """
        logs_dir = self.mind_dir / "docs" / "logs"
        if not logs_dir.exists():
            return []

        # Get all log files, sorted by modification time (newest first)
        log_files = sorted(
            logs_dir.glob("*"),
            key=lambda p: p.stat().st_mtime,
            reverse=True
        )

        logs = []
        for log_file in log_files[:max_files]:
            if log_file.is_file():
                try:
                    with open(log_file, 'r', encoding='utf-8') as f:
                        logs.append({
                            'filename': log_file.name,
                            'content': f.read()
                        })
                except UnicodeDecodeError:
                    # Fallback to latin-1 for legacy files
                    try:
                        with open(log_file, 'r', encoding='latin-1') as f:
                            logs.append({
                                'filename': log_file.name,
                                'content': f.read()
                            })
                    except Exception as e:
                        print(f"Warning: Could not load {log_file.name}: {e}")
                except Exception as e:
                    print(f"Warning: Could not load {log_file.name}: {e}")

        return logs

    def load_all_context(
        self,
        include_sources: bool = True,
        include_logs: bool = True,
        max_sources: int = 5,
        max_logs: int = 3
    ) -> Dict[str, any]:
        """
        Load all available context files

        Args:
            include_sources: Whether to include sources
            include_logs: Whether to include logs
            max_sources: Max number of source files
            max_logs: Max number of log files

        Returns:
            Dict with all context data
        """
        context = {
            'mind_brief': self.load_mind_brief(),
            'prd': self.load_prd(),
            'sources': [],
            'logs': []
        }

        if include_sources:
            context['sources'] = self.load_sources(max_files=max_sources)

        if include_logs:
            context['logs'] = self.load_recent_logs(max_files=max_logs)

        return context

    def format_context_for_display(self, context: Dict[str, any]) -> str:
        """
        Format context for CLI display

        Args:
            context: Context dict from load_all_context()

        Returns:
            Formatted string for display
        """
        lines = []

        if context['mind_brief']:
            lines.append("📄 MIND_BRIEF.md found")
        else:
            lines.append("⚠️  MIND_BRIEF.md NOT FOUND")

        if context['prd']:
            lines.append("📄 PRD.md found")

        if context['sources']:
            lines.append(f"📚 {len(context['sources'])} source file(s) loaded")

        if context['logs']:
            lines.append(f"📋 {len(context['logs'])} recent log(s) loaded")

        return "\n".join(lines)
