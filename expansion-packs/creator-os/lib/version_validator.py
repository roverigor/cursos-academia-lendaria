"""
Version Validator Module for CreatorOS

Implements version compatibility checking for tasks and agents to prevent
execution errors from version mismatches (e.g., v1.0 agent + v2.0 task).

Usage:
    from lib.version_validator import VersionValidator

    validator = VersionValidator()
    validator.validate_compatibility(task_path, agent_path)
"""

import re
import yaml
from pathlib import Path
from typing import Dict, Optional, List


class VersionMismatchError(Exception):
    """Raised when agent version doesn't satisfy task requirements"""
    pass


class VersionValidator:
    """
    Validates version compatibility between tasks and agents.

    Ensures:
    1. Agent version satisfies task requirement (>=, ==, <, >)
    2. Task version is in agent's compatibility list
    """

    def __init__(self):
        pass

    def validate_compatibility(
        self,
        task_path: str,
        agent_path: str,
        force: bool = False
    ) -> bool:
        """
        Check if agent version satisfies task requirements

        Args:
            task_path: Path to task file
            agent_path: Path to agent file
            force: If True, bypass version check (debug only)

        Returns:
            True if compatible

        Raises:
            VersionMismatchError: If versions incompatible
        """
        if force:
            print(
                "⚠️  VERSION CHECK BYPASSED (--force-version flag)\n"
                "   This may cause unexpected errors or silent failures.\n"
                "   Only use this flag for debugging."
            )
            return True

        # Parse metadata
        task_meta = self.parse_frontmatter(task_path)
        agent_meta = self.parse_frontmatter(agent_path)

        # Extract version info
        task_version = task_meta.get("task_version")
        required_agent_version = task_meta.get("required_agent_version")
        agent_version = agent_meta.get("agent_version")
        compatible_tasks = agent_meta.get("compatible_task_versions", [])

        # Validate fields exist
        if not task_version:
            raise ValueError(f"Task missing 'task_version' in frontmatter: {task_path}")
        if not required_agent_version:
            raise ValueError(f"Task missing 'required_agent_version' in frontmatter: {task_path}")
        if not agent_version:
            raise ValueError(f"Agent missing 'agent_version' in frontmatter: {agent_path}")
        if not compatible_tasks:
            raise ValueError(f"Agent missing 'compatible_task_versions' in frontmatter: {agent_path}")

        # Check 1: Agent version satisfies requirement
        if not self.version_satisfies(agent_version, required_agent_version):
            error_msg = self.format_error_message(
                task_meta, agent_meta, task_path, agent_path
            )
            raise VersionMismatchError(error_msg)

        # Check 2: Task version in agent's compatibility list
        if task_version not in compatible_tasks:
            error_msg = self.format_error_message(
                task_meta, agent_meta, task_path, agent_path
            )
            raise VersionMismatchError(error_msg)

        # Check backward compatibility mode (optional)
        backward_compat = task_meta.get("backward_compatible", [])
        if backward_compat and agent_version in backward_compat:
            degraded_features = task_meta.get("degraded_features", [])
            print(
                f"⚠️  Running in COMPATIBILITY MODE\n"
                f"   Agent v{agent_version} is older than required ({required_agent_version})\n"
                f"   Some features will be disabled:\n"
                + "\n".join(f"   - {feature}" for feature in degraded_features)
            )

        print(f"✅ Version check passed: Agent {agent_version} compatible with Task {task_version}")
        return True

    def parse_frontmatter(self, file_path: str) -> Dict:
        """
        Extract YAML frontmatter from Markdown file

        Args:
            file_path: Path to file

        Returns:
            Dictionary of frontmatter fields
        """
        path = Path(file_path)

        if not path.exists():
            raise FileNotFoundError(f"File not found: {file_path}")

        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Match YAML frontmatter (between --- delimiters)
        match = re.match(r'^---\s*\n(.*?)\n---\s*\n', content, re.DOTALL)

        if not match:
            return {}

        frontmatter_str = match.group(1)

        try:
            frontmatter = yaml.safe_load(frontmatter_str)
            return frontmatter or {}
        except yaml.YAMLError as e:
            raise ValueError(f"Invalid YAML frontmatter in {file_path}: {e}")

    def version_satisfies(self, version: str, requirement: str) -> bool:
        """
        Check if version satisfies requirement (supports >=, ==, <, >)

        Args:
            version: Version string (e.g., "3.0")
            requirement: Requirement string (e.g., ">=3.0")

        Returns:
            True if version satisfies requirement
        """
        # Parse requirement operator
        if requirement.startswith(">="):
            min_version = requirement[2:].strip()
            return self.version_compare(version, min_version) >= 0
        elif requirement.startswith(">"):
            min_version = requirement[1:].strip()
            return self.version_compare(version, min_version) > 0
        elif requirement.startswith("<="):
            max_version = requirement[2:].strip()
            return self.version_compare(version, max_version) <= 0
        elif requirement.startswith("<"):
            max_version = requirement[1:].strip()
            return self.version_compare(version, max_version) < 0
        elif requirement.startswith("=="):
            exact_version = requirement[2:].strip()
            return version == exact_version
        else:
            # Default: Exact match
            return version == requirement

    def version_compare(self, v1: str, v2: str) -> int:
        """
        Compare semantic versions: 0 if equal, >0 if v1 > v2, <0 if v1 < v2

        Args:
            v1: First version (e.g., "3.0")
            v2: Second version (e.g., "2.5")

        Returns:
            0 if equal, positive if v1 > v2, negative if v1 < v2
        """
        v1_parts = [int(x) for x in v1.split(".")]
        v2_parts = [int(x) for x in v2.split(".")]

        # Pad shorter version with zeros
        max_len = max(len(v1_parts), len(v2_parts))
        v1_parts += [0] * (max_len - len(v1_parts))
        v2_parts += [0] * (max_len - len(v2_parts))

        # Compare major, then minor, then patch
        for a, b in zip(v1_parts, v2_parts):
            if a != b:
                return a - b

        return 0  # Equal

    def format_error_message(
        self,
        task_meta: Dict,
        agent_meta: Dict,
        task_path: str,
        agent_path: str
    ) -> str:
        """
        Generate user-friendly error message for version mismatch

        Args:
            task_meta: Task frontmatter
            agent_meta: Agent frontmatter
            task_path: Path to task file
            agent_path: Path to agent file

        Returns:
            Formatted error message with fix instructions
        """
        task_name = task_meta.get("task_name", Path(task_path).stem)
        task_version = task_meta.get("task_version", "unknown")
        required_version = task_meta.get("required_agent_version", "unknown")

        agent_name = agent_meta.get("agent_name", Path(agent_path).stem)
        agent_version = agent_meta.get("agent_version", "unknown")

        message = f"""
════════════════════════════════════════════════════════════
❌ VERSION MISMATCH
════════════════════════════════════════════════════════════

Task: {task_name} (v{task_version})
Agent: {agent_name} (v{agent_version})

The current agent is outdated and incompatible with this task.

────────────────────────────────────────────────────────────

REQUIRED: {agent_name} {required_version}
INSTALLED: {agent_name} v{agent_version}

────────────────────────────────────────────────────────────

HOW TO FIX:

Option A: Update Agent to Latest Version
  1. Check for latest agent version in:
     {agent_path}

  2. Ensure agent file has correct version metadata

  3. Restart task:
     *{task_name}

Option B: Use Compatible Task Version (if available)
  Check if older task versions are available that support
  agent v{agent_version}.

  ⚠️  Note: Older task versions may lack newer features.

────────────────────────────────────────────────────────────

📚 DOCS: docs/guides/version-management.md

════════════════════════════════════════════════════════════
"""
        return message


def validate_version_compatibility_direct(
    task_meta: Dict,
    agent_meta: Dict
) -> bool:
    """
    Validate compatibility from metadata dictionaries (for testing)

    Args:
        task_meta: Task metadata dict
        agent_meta: Agent metadata dict

    Returns:
        True if compatible

    Raises:
        VersionMismatchError: If incompatible
    """
    validator = VersionValidator()

    task_version = task_meta.get("task_version")
    required_agent_version = task_meta.get("required_agent_version")
    agent_version = agent_meta.get("agent_version")
    compatible_tasks = agent_meta.get("compatible_task_versions", [])

    # Check 1: Agent version satisfies requirement
    if not validator.version_satisfies(agent_version, required_agent_version):
        raise VersionMismatchError(
            f"Agent version {agent_version} does not satisfy requirement {required_agent_version}"
        )

    # Check 2: Task version in agent's compatibility list
    if task_version not in compatible_tasks:
        raise VersionMismatchError(
            f"Agent does not support task version {task_version} (supports: {compatible_tasks})"
        )

    return True


def check_backward_compatibility(task_meta: Dict, agent_version: str) -> Optional[str]:
    """
    Check if agent version is backward compatible with task

    Args:
        task_meta: Task metadata dict
        agent_version: Agent version string

    Returns:
        "compatibility_mode" if backward compatible, None otherwise
    """
    backward_compat = task_meta.get("backward_compatible", [])

    if agent_version in backward_compat:
        return "compatibility_mode"

    return None


# CLI usage
if __name__ == "__main__":
    import sys

    if len(sys.argv) < 3:
        print("Usage: python version_validator.py <task_path> <agent_path> [--force]")
        sys.exit(1)

    task_path = sys.argv[1]
    agent_path = sys.argv[2]
    force = "--force" in sys.argv

    validator = VersionValidator()

    try:
        validator.validate_compatibility(task_path, agent_path, force=force)
        print("\n✅ Version compatibility check PASSED")
        sys.exit(0)
    except VersionMismatchError as e:
        print(str(e))
        sys.exit(1)
    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)
