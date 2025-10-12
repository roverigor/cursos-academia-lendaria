"""
Structured logging for MMOS migration scripts.
Provides consistent logging format across all migration scripts.
"""

import logging
import sys
from pathlib import Path
from datetime import datetime
from typing import Optional


class MigrationLogger:
    """Structured logger for migration scripts."""

    def __init__(self, script_name: str, log_file: Optional[str] = None):
        """
        Initialize migration logger.

        Args:
            script_name: Name of the migration script
            log_file: Optional log file path (will also log to console)
        """
        self.script_name = script_name
        self.logger = logging.getLogger(script_name)
        self.logger.setLevel(logging.INFO)

        # Prevent duplicate handlers
        if self.logger.handlers:
            self.logger.handlers.clear()

        # Console handler (always)
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(logging.INFO)
        console_format = logging.Formatter(
            '%(levelname)s: %(message)s'
        )
        console_handler.setFormatter(console_format)
        self.logger.addHandler(console_handler)

        # File handler (if specified)
        if log_file:
            Path(log_file).parent.mkdir(parents=True, exist_ok=True)
            file_handler = logging.FileHandler(log_file, mode='a', encoding='utf-8')
            file_handler.setLevel(logging.DEBUG)
            file_format = logging.Formatter(
                '%(asctime)s [%(name)s] %(levelname)s: %(message)s',
                datefmt='%Y-%m-%d %H:%M:%S'
            )
            file_handler.setFormatter(file_format)
            self.logger.addHandler(file_handler)

        self.stats = {
            'success': 0,
            'skipped': 0,
            'failed': 0,
            'warnings': 0
        }

    def info(self, message: str):
        """Log info message."""
        self.logger.info(message)

    def success(self, message: str):
        """Log success message."""
        self.logger.info(f"✓ {message}")
        self.stats['success'] += 1

    def skip(self, message: str):
        """Log skip message."""
        self.logger.info(f"⊘ {message}")
        self.stats['skipped'] += 1

    def warning(self, message: str):
        """Log warning message."""
        self.logger.warning(f"⚠ {message}")
        self.stats['warnings'] += 1

    def error(self, message: str):
        """Log error message."""
        self.logger.error(f"✗ {message}")
        self.stats['failed'] += 1

    def debug(self, message: str):
        """Log debug message."""
        self.logger.debug(message)

    def section(self, title: str):
        """Log section header."""
        self.logger.info("")
        self.logger.info(f"{'=' * 60}")
        self.logger.info(f"  {title}")
        self.logger.info(f"{'=' * 60}")

    def summary(self):
        """Print summary statistics."""
        self.logger.info("")
        self.logger.info(f"{'=' * 60}")
        self.logger.info(f"  Migration Summary - {self.script_name}")
        self.logger.info(f"{'=' * 60}")
        self.logger.info(f"  Success: {self.stats['success']}")
        self.logger.info(f"  Skipped: {self.stats['skipped']}")
        self.logger.info(f"  Warnings: {self.stats['warnings']}")
        self.logger.info(f"  Failed: {self.stats['failed']}")
        self.logger.info(f"{'=' * 60}")
        self.logger.info("")

        # Return exit code (0 if no failures, 1 otherwise)
        return 0 if self.stats['failed'] == 0 else 1


def setup_logging(script_name: str, log_dir: str = "logs") -> MigrationLogger:
    """
    Setup logging for migration script.

    Args:
        script_name: Name of the migration script
        log_dir: Directory for log files

    Returns:
        Configured MigrationLogger instance
    """
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    log_file = f"{log_dir}/migration_{script_name}_{timestamp}.log"

    return MigrationLogger(script_name, log_file)
