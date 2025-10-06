"""
Dependencies Checker Module

Checks if prompt dependencies have been completed
"""

from typing import Dict, List, Set
from .logger import ExecutionLogger


class DependencyChecker:
    """Checks prompt dependencies against execution history"""

    def __init__(self, logger: ExecutionLogger):
        """
        Initialize the DependencyChecker

        Args:
            logger: ExecutionLogger instance to access history
        """
        self.logger = logger

    def get_completed_prompts(self, mind: str) -> Set[str]:
        """
        Get set of completed prompt IDs for a mind

        Args:
            mind: Mind name

        Returns:
            Set of prompt IDs that have been executed
        """
        executions = self.logger.get_executions_for_mind(mind)
        return set(e.get('prompt_id') for e in executions if not e.get('dry_run', False))

    def check_dependencies(
        self,
        prompt: Dict,
        mind: str,
        strict: bool = False
    ) -> Dict[str, any]:
        """
        Check if all dependencies for a prompt are satisfied

        Args:
            prompt: Prompt dict with 'depends_on' field
            mind: Mind name
            strict: If True, missing deps are errors; if False, they're warnings

        Returns:
            Dict with:
                - satisfied: bool (all deps met)
                - missing: List[str] (missing prompt IDs)
                - message: str (human-readable message)
        """
        depends_on = prompt.get('depends_on', [])

        if not depends_on:
            return {
                'satisfied': True,
                'missing': [],
                'message': 'No dependencies'
            }

        completed = self.get_completed_prompts(mind)
        missing = [dep for dep in depends_on if dep not in completed]

        if not missing:
            return {
                'satisfied': True,
                'missing': [],
                'message': f'All {len(depends_on)} dependencies satisfied'
            }

        severity = 'ERROR' if strict else 'WARNING'
        message = f"{severity}: Missing {len(missing)} dependencies: {', '.join(missing)}"

        return {
            'satisfied': False,
            'missing': missing,
            'message': message
        }

    def get_dependency_tree(self, prompt: Dict, all_prompts: List[Dict]) -> Dict:
        """
        Get full dependency tree for a prompt

        Args:
            prompt: Prompt dict
            all_prompts: List of all available prompts

        Returns:
            Dict representing dependency tree
        """
        prompt_map = {p['id']: p for p in all_prompts}

        def build_tree(prompt_id: str, visited: Set[str] = None) -> Dict:
            if visited is None:
                visited = set()

            if prompt_id in visited:
                return {'id': prompt_id, 'circular': True}

            visited.add(prompt_id)

            prompt = prompt_map.get(prompt_id)
            if not prompt:
                return {'id': prompt_id, 'not_found': True}

            depends_on = prompt.get('depends_on', [])
            children = [build_tree(dep, visited.copy()) for dep in depends_on]

            return {
                'id': prompt_id,
                'title': prompt.get('title'),
                'phase': prompt.get('phase'),
                'dependencies': children
            }

        return build_tree(prompt['id'])

    def format_deps_for_display(self, check_result: Dict) -> str:
        """
        Format dependency check result for CLI display

        Args:
            check_result: Result from check_dependencies()

        Returns:
            Formatted string for display
        """
        if check_result['satisfied']:
            return f"✅ {check_result['message']}"
        else:
            lines = [f"⚠️  {check_result['message']}"]
            lines.append(f"   Missing: {', '.join(check_result['missing'])}")
            return "\n".join(lines)
