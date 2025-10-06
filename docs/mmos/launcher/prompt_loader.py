"""
Prompt Loader Module

Loads and validates prompts from prompts.yaml
"""

import yaml
from pathlib import Path
from typing import Dict, List, Optional


class PromptNotFoundError(Exception):
    """Raised when a prompt is not found in prompts.yaml"""
    pass


class PromptLoader:
    """Loads prompts from prompts.yaml"""

    def __init__(self, prompts_file: str = "docs/mmos/prompts.yaml"):
        """
        Initialize the PromptLoader

        Args:
            prompts_file: Path to prompts.yaml (relative to project root)
        """
        self.prompts_file = Path(prompts_file)
        self._prompts: Optional[List[Dict]] = None

    def _load_prompts(self) -> List[Dict]:
        """Load prompts from YAML file (cached)"""
        if self._prompts is None:
            if not self.prompts_file.exists():
                raise FileNotFoundError(
                    f"prompts.yaml not found at: {self.prompts_file}"
                )

            with open(self.prompts_file, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f)
                self._prompts = data.get('prompts', [])

        return self._prompts

    def get_prompt(self, prompt_id: str) -> Dict:
        """
        Get prompt by ID

        Args:
            prompt_id: The prompt ID (e.g., 'analysis_mental_models')

        Returns:
            Dict with prompt metadata

        Raises:
            PromptNotFoundError: If prompt ID is not found
        """
        prompts = self._load_prompts()

        for prompt in prompts:
            if prompt.get('id') == prompt_id:
                return prompt

        raise PromptNotFoundError(
            f"Prompt '{prompt_id}' not found in {self.prompts_file}"
        )

    def get_prompts_by_phase(self, phase: str) -> List[Dict]:
        """
        Get all prompts for a given phase

        Args:
            phase: The phase name (e.g., 'analysis')

        Returns:
            List of prompt dicts for that phase
        """
        prompts = self._load_prompts()
        return [p for p in prompts if p.get('phase') == phase]

    def list_phases(self) -> List[str]:
        """
        List all unique phases

        Returns:
            List of phase names
        """
        prompts = self._load_prompts()
        phases = sorted(set(p.get('phase') for p in prompts if p.get('phase')))
        return phases

    def validate_prompt(self, prompt: Dict) -> bool:
        """
        Validate that a prompt has all required fields

        Args:
            prompt: Prompt dict to validate

        Returns:
            True if valid, False otherwise
        """
        required_fields = ['id', 'file', 'phase', 'title', 'agent', 'outputs']
        return all(field in prompt for field in required_fields)
