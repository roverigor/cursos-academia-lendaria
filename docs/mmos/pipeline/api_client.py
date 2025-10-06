"""
APIClient - Anthropic API integration with retries and context injection

Features:
- Anthropic Claude API calls
- Exponential backoff retry (3x)
- Rate limit handling
- Context injection from multiple sources
- Error logging
"""

import os
import time
import anthropic
from pathlib import Path
from typing import Dict, List, Optional
from dataclasses import dataclass

@dataclass
class APIResponse:
    """Response from API call"""
    success: bool
    content: Optional[str] = None
    error: Optional[str] = None
    retry_count: int = 0
    duration_ms: int = 0

class AnthropicAPIClient:
    """
    Client for Anthropic Claude API with retry logic

    Features:
    - Automatic context injection
    - Exponential backoff
    - Rate limit handling
    """

    def __init__(self, api_key: Optional[str] = None, model: str = 'claude-sonnet-4-5-20250929', max_tokens: int = 100000):
        """
        Initialize API client

        Args:
            api_key: Anthropic API key (defaults to ANTHROPIC_API_KEY env var)
            model: Claude model to use
            max_tokens: Maximum tokens for response
        """
        self.api_key = api_key or os.getenv('ANTHROPIC_API_KEY')
        if not self.api_key:
            raise ValueError("ANTHROPIC_API_KEY environment variable not set")

        self.model = model
        self.max_tokens = max_tokens
        self.client = anthropic.Anthropic(api_key=self.api_key)
        self.max_retries = 3

    def _load_context(self, mind: str) -> Dict[str, str]:
        """
        Load context for a mind

        Priority order:
        1. MIND_BRIEF.md (highest priority)
        2. PRD.md
        3. Recent sources (up to 5 most recent)
        4. Recent logs (up to 3 most recent)

        Args:
            mind: Mind name

        Returns:
            Dict of {filename: content}
        """
        context = {}
        mind_dir = Path(f"docs/minds/{mind}")

        # 1. Mind Brief (required)
        mind_brief_path = mind_dir / "MIND_BRIEF.md"
        if mind_brief_path.exists():
            with open(mind_brief_path, 'r', encoding='utf-8') as f:
                context['MIND_BRIEF.md'] = f.read()
        else:
            print(f"[WARN] Missing MIND_BRIEF.md for {mind}")

        # 2. PRD (optional)
        prd_path = mind_dir / "docs" / "PRD.md"
        if prd_path.exists():
            with open(prd_path, 'r', encoding='utf-8') as f:
                context['PRD.md'] = f.read()

        # 3. Recent sources (up to 5)
        sources_dir = mind_dir / "sources"
        if sources_dir.exists():
            source_files = [
                f for f in sources_dir.rglob('*')
                if f.is_file() and f.suffix in ['.md', '.txt', '.yaml']
            ]
            # Sort by modification time, most recent first
            source_files.sort(key=lambda f: f.stat().st_mtime, reverse=True)
            for source_file in source_files[:5]:
                rel_path = source_file.relative_to(mind_dir)
                try:
                    with open(source_file, 'r', encoding='utf-8') as f:
                        context[str(rel_path)] = f.read()
                except Exception as e:
                    print(f"[WARN] Could not read {rel_path}: {e}")

        # 4. Recent logs (up to 3)
        logs_dir = mind_dir / "docs" / "logs"
        if logs_dir.exists():
            log_files = list(logs_dir.glob('*.yaml'))
            log_files.sort(key=lambda f: f.stat().st_mtime, reverse=True)
            for log_file in log_files[:3]:
                rel_path = log_file.relative_to(mind_dir)
                try:
                    with open(log_file, 'r', encoding='utf-8') as f:
                        context[str(rel_path)] = f.read()
                except Exception as e:
                    print(f"[WARN] Could not read {rel_path}: {e}")

        return context

    def _build_prompt_with_context(self, prompt_text: str, context: Dict[str, str]) -> str:
        """
        Build full prompt with injected context

        Args:
            prompt_text: The actual prompt
            context: Dict of {filename: content}

        Returns:
            Full prompt with context
        """
        context_text = "\n\n".join([
            f"=== {filename} ===\n{content}"
            for filename, content in context.items()
        ])

        full_prompt = f"""You are working with the following context for this mind:

{context_text}

===== TASK =====

{prompt_text}
"""
        return full_prompt

    def _execute_with_retry(self, prompt: str) -> APIResponse:
        """
        Execute API call with exponential backoff retry

        Args:
            prompt: Full prompt text

        Returns:
            APIResponse
        """
        retry_count = 0
        last_error = None

        while retry_count <= self.max_retries:
            try:
                start_time = time.time()

                # Call Anthropic API
                message = self.client.messages.create(
                    model=self.model,
                    max_tokens=self.max_tokens,
                    messages=[
                        {"role": "user", "content": prompt}
                    ]
                )

                duration_ms = int((time.time() - start_time) * 1000)

                # Extract text content
                content = message.content[0].text if message.content else ""

                return APIResponse(
                    success=True,
                    content=content,
                    retry_count=retry_count,
                    duration_ms=duration_ms
                )

            except anthropic.RateLimitError as e:
                retry_count += 1
                last_error = f"Rate limit error: {str(e)}"
                if retry_count <= self.max_retries:
                    wait_time = 2 ** retry_count  # Exponential backoff: 2s, 4s, 8s
                    print(f"[RETRY {retry_count}/{self.max_retries}] Rate limit hit, waiting {wait_time}s...")
                    time.sleep(wait_time)
                else:
                    print(f"[ERROR] Max retries exceeded: {last_error}")

            except anthropic.APITimeoutError as e:
                retry_count += 1
                last_error = f"API timeout: {str(e)}"
                if retry_count <= self.max_retries:
                    wait_time = 2 ** retry_count
                    print(f"[RETRY {retry_count}/{self.max_retries}] Timeout, waiting {wait_time}s...")
                    time.sleep(wait_time)
                else:
                    print(f"[ERROR] Max retries exceeded: {last_error}")

            except Exception as e:
                # For other errors, fail immediately
                return APIResponse(
                    success=False,
                    error=f"API error: {str(e)}",
                    retry_count=retry_count
                )

        # Max retries exceeded
        return APIResponse(
            success=False,
            error=last_error or "Unknown error",
            retry_count=retry_count
        )

    def execute_prompt(self, mind: str, prompt_text: str) -> APIResponse:
        """
        Execute a prompt with context injection

        Args:
            mind: Mind name
            prompt_text: Prompt text from prompts.yaml

        Returns:
            APIResponse with result or error
        """
        # 1. Load context
        context = self._load_context(mind)

        # 2. Build full prompt
        full_prompt = self._build_prompt_with_context(prompt_text, context)

        # 3. Execute with retry
        response = self._execute_with_retry(full_prompt)

        return response


# CLI-friendly function
def execute_prompt(mind: str, prompt_text: str, api_key: Optional[str] = None) -> APIResponse:
    """
    Execute a single prompt with Anthropic API

    Args:
        mind: Mind name
        prompt_text: Prompt text
        api_key: Optional API key (defaults to env var)

    Returns:
        APIResponse

    Example:
        >>> response = execute_prompt('nassim_taleb', 'Analyze the ICP match...')
        >>> if response.success:
        ...     print(f"Response: {response.content}")
        ... else:
        ...     print(f"Error: {response.error}")
    """
    client = AnthropicAPIClient(api_key=api_key)
    return client.execute_prompt(mind, prompt_text)
