"""
RegressionTester - Orchestrate regression tests

Runs focused tests to ensure brownfield updates don't break existing behavior:
- Personality consistency
- Knowledge retention
- New content integration
"""

import yaml
import difflib
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Dict, List, Optional
from datetime import datetime


@dataclass
class RegressionTest:
    """A single regression test result"""
    test_id: str
    category: str  # 'personality' | 'knowledge' | 'new_content' | 'edge_case'
    prompt: str
    baseline_response: str
    updated_response: str
    status: str  # 'pass' | 'warning' | 'critical'
    similarity_score: float
    notes: str = ''


class RegressionTester:
    """Orchestrate regression tests for brownfield updates"""

    # Test suite templates
    DEFAULT_PERSONALITY_TESTS = [
        "What's your view on randomness in markets?",
        "How do you approach decision-making under uncertainty?",
        "What's your communication style?",
    ]

    DEFAULT_KNOWLEDGE_TESTS = [
        "What's the ludic fallacy?",
        "Explain antifragility in one sentence.",
        "What are your core mental models?",
    ]

    # Similarity thresholds
    THRESHOLDS = {
        'personality': {
            'pass': 0.90,
            'warning': 0.80
        },
        'knowledge': {
            'pass': 0.95,
            'warning': 0.90
        },
        'new_content': {
            'pass': 0.0,  # Any response is pass (expected to change)
            'warning': 0.0
        }
    }

    def __init__(self, mind_dir: Path, execution_id: str):
        self.mind_dir = Path(mind_dir)
        self.execution_id = execution_id
        self.baseline_version = self._get_baseline_version()
        self.updated_version = self._get_current_version()

    def _get_baseline_version(self) -> Dict:
        """Get baseline version info (before brownfield)"""
        # Find most recent system prompt before brownfield
        system_prompts_dir = self.mind_dir / "system_prompts"
        if system_prompts_dir.exists():
            prompts = sorted(system_prompts_dir.glob("*-generalista.md"))
            if prompts:
                latest = prompts[-1]
                return {
                    'system_prompt': latest.name,
                    'kb_chunks': len(list((self.mind_dir / "kb").glob("*.md"))) if (self.mind_dir / "kb").exists() else 0,
                    'last_update': datetime.fromtimestamp(latest.stat().st_mtime).isoformat()
                }

        return {
            'system_prompt': 'unknown',
            'kb_chunks': 0,
            'last_update': 'unknown'
        }

    def _get_current_version(self) -> Dict:
        """Get current version info (after brownfield)"""
        system_prompts_dir = self.mind_dir / "system_prompts"
        if system_prompts_dir.exists():
            prompts = sorted(system_prompts_dir.glob("*-generalista.md"))
            if prompts:
                latest = prompts[-1]
                return {
                    'system_prompt': latest.name,
                    'kb_chunks': len(list((self.mind_dir / "kb").glob("*.md"))) if (self.mind_dir / "kb").exists() else 0,
                    'last_update': datetime.now().isoformat()
                }

        return {
            'system_prompt': 'unknown',
            'kb_chunks': 0,
            'last_update': datetime.now().isoformat()
        }

    def run_tests(self, test_suite: Optional[Dict[str, List[str]]] = None) -> List[RegressionTest]:
        """
        Run regression test suite

        Args:
            test_suite: Optional custom test suite
                        Format: {'personality': [...], 'knowledge': [...]}

        Returns:
            List of RegressionTest results
        """
        if test_suite is None:
            test_suite = {
                'personality': self.DEFAULT_PERSONALITY_TESTS,
                'knowledge': self.DEFAULT_KNOWLEDGE_TESTS
            }

        results = []

        # Run personality tests
        for prompt in test_suite.get('personality', []):
            result = self._run_test(
                category='personality',
                prompt=prompt,
                baseline="[Baseline response would be loaded from previous test logs]",
                updated="[Updated response would come from current mind]"
            )
            results.append(result)

        # Run knowledge tests
        for prompt in test_suite.get('knowledge', []):
            result = self._run_test(
                category='knowledge',
                prompt=prompt,
                baseline="[Baseline response would be loaded from previous test logs]",
                updated="[Updated response would come from current mind]"
            )
            results.append(result)

        return results

    def _run_test(self, category: str, prompt: str, baseline: str, updated: str) -> RegressionTest:
        """
        Run a single regression test

        NOTE: In a real implementation, baseline/updated responses would come from:
        - Baseline: Previous test logs or baseline snapshot
        - Updated: Current mind execution via launcher/agent
        """
        # Compute similarity
        similarity = self._compare_responses(baseline, updated)

        # Determine status based on thresholds
        status = self._determine_status(similarity, category)

        # Generate notes
        notes = self._generate_notes(similarity, category, status)

        return RegressionTest(
            test_id=f"{category}_{len(prompt.split()[:3])}",
            category=category,
            prompt=prompt,
            baseline_response=baseline,
            updated_response=updated,
            status=status,
            similarity_score=similarity,
            notes=notes
        )

    def _compare_responses(self, baseline: str, updated: str) -> float:
        """
        Compare two responses and return similarity score (0.0 - 1.0)

        Uses difflib SequenceMatcher for text similarity
        Future: Could use embeddings for semantic similarity
        """
        if not baseline or not updated:
            return 0.0

        similarity = difflib.SequenceMatcher(None, baseline, updated).ratio()
        return round(similarity, 2)

    def _determine_status(self, similarity: float, category: str) -> str:
        """Determine test status based on similarity and category"""
        thresholds = self.THRESHOLDS.get(category, self.THRESHOLDS['knowledge'])

        if similarity >= thresholds['pass']:
            return 'pass'
        elif similarity >= thresholds['warning']:
            return 'warning'
        else:
            return 'critical'

    def _generate_notes(self, similarity: float, category: str, status: str) -> str:
        """Generate explanatory notes for test result"""
        if status == 'pass':
            if category == 'new_content':
                return "New content successfully integrated"
            else:
                return "Consistent with baseline, no regression detected"
        elif status == 'warning':
            return f"Slight change detected ({similarity:.0%} similarity), review recommended"
        else:
            return f"Significant change detected ({similarity:.0%} similarity), potential regression"

    def save_results(self, tests: List[RegressionTest], output_path: Path):
        """Save regression test results to YAML"""
        # Calculate summary
        summary = {
            'total_tests': len(tests),
            'passed': sum(1 for t in tests if t.status == 'pass'),
            'warnings': sum(1 for t in tests if t.status == 'warning'),
            'critical': sum(1 for t in tests if t.status == 'critical')
        }

        # Determine recommendation
        if summary['critical'] > 0:
            recommendation = 'rollback'
        elif summary['warnings'] > len(tests) // 2:
            recommendation = 'revise'
        else:
            recommendation = 'approve'

        summary['recommendation'] = recommendation

        data = {
            'schema_version': '1.0',
            'test_timestamp': datetime.now().isoformat(),
            'mind': self.mind_dir.name,
            'execution_id': self.execution_id,
            'baseline_version': self.baseline_version,
            'updated_version': self.updated_version,
            'tests': [
                {
                    'test_id': t.test_id,
                    'category': t.category,
                    'prompt': t.prompt,
                    'baseline_response': t.baseline_response,
                    'updated_response': t.updated_response,
                    'status': t.status,
                    'similarity_score': t.similarity_score,
                    'notes': t.notes
                }
                for t in tests
            ],
            'summary': summary
        }

        with open(output_path, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, allow_unicode=True, sort_keys=False)

        print(f"\n[INFO] Regression test results saved to {output_path}")
        print(f"\n=== Test Summary ===")
        print(f"Total: {summary['total_tests']}")
        print(f"Passed: {summary['passed']}")
        print(f"Warnings: {summary['warnings']}")
        print(f"Critical: {summary['critical']}")
        print(f"\nRecommendation: {recommendation.upper()}")

        return summary
