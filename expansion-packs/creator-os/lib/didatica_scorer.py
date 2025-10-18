#!/usr/bin/env python3
"""
Didática Lendária Scorer for CreatorOS

This module scores lessons based on the 7 Elements of Didática Lendária:
1. Hook Emocional (emotional hook)
2. Conceitos Primordiais (foundational concepts)
3. Link de Transição (transition links between concepts)
4. Pergunta Reflexiva (reflective questions)
5. Analogias/Diagramas (semiotic elements)
6. Revisão Estruturada (structured review)
7. Ação Rápida (quick action - 2 min exercise)

Story: STORY-3.9 - Lesson Generation with GPS + Didática Lendária
Epic: EPIC-3 - Intelligent Workflow System

Scoring System:
- Each element contributes points (weighted by importance)
- Total score: 0-100
- Pass threshold: 70/100
- Excellent: 85+/100

Usage:
    from lib.didatica_scorer import DidaticaScorer

    scorer = DidaticaScorer()
    result = scorer.score_lesson(lesson_content)

    if result.score >= 70:
        print(f"✅ Didática Lendária compliant ({result.score}/100)")
    else:
        print(f"❌ Below threshold: {result.score}/100")
"""

import re
from dataclasses import dataclass, field
from typing import List, Dict, Optional


@dataclass
class DidaticaScore:
    """Result of Didática Lendária scoring."""
    score: int  # 0-100
    passed: bool  # >= 70
    element_scores: Dict[str, int]  # Element → points
    details: Dict = field(default_factory=dict)
    recommendations: List[str] = field(default_factory=list)


class DidaticaScorer:
    """
    Didática Lendária 7 Elements scorer.

    Analyzes lesson content and scores based on pedagogical depth
    using the 7 Elements framework.
    """

    def __init__(self, pass_threshold: int = 70):
        """
        Initialize Didática Lendária scorer.

        Args:
            pass_threshold: Minimum score to pass (default: 70/100)
        """
        self.pass_threshold = pass_threshold

        # Element weights (total: 100 points)
        self.weights = {
            "hook_emocional": 15,  # Emotional hook
            "conceitos_primordiais": 20,  # Core concepts
            "link_transicao": 10,  # Transition links
            "pergunta_reflexiva": 15,  # Reflective questions
            "analogias_diagramas": 20,  # Semiotic elements
            "revisao_estruturada": 10,  # Structured review
            "acao_rapida": 10  # Quick action
        }

    def score_lesson(self, content: str) -> DidaticaScore:
        """
        Score lesson based on Didática Lendária 7 Elements.

        Args:
            content: Lesson content (Markdown)

        Returns:
            DidaticaScore with overall score and element breakdown
        """
        element_scores = {}
        details = {}
        recommendations = []

        # Element 1: Hook Emocional
        hook_score, hook_details = self._score_hook_emocional(content)
        element_scores["hook_emocional"] = hook_score
        details["hook_emocional"] = hook_details
        if hook_score < self.weights["hook_emocional"]:
            recommendations.append("Add stronger emotional hook in Goal section")

        # Element 2: Conceitos Primordiais
        conceitos_score, conceitos_details = self._score_conceitos_primordiais(content)
        element_scores["conceitos_primordiais"] = conceitos_score
        details["conceitos_primordiais"] = conceitos_details
        if conceitos_score < self.weights["conceitos_primordiais"]:
            recommendations.append("Add clearer foundational concept explanations")

        # Element 3: Link de Transição
        link_score, link_details = self._score_link_transicao(content)
        element_scores["link_transicao"] = link_score
        details["link_transicao"] = link_details
        if link_score < self.weights["link_transicao"]:
            recommendations.append("Add explicit transition links between concepts")

        # Element 4: Pergunta Reflexiva
        pergunta_score, pergunta_details = self._score_pergunta_reflexiva(content)
        element_scores["pergunta_reflexiva"] = pergunta_score
        details["pergunta_reflexiva"] = pergunta_details
        if pergunta_score < self.weights["pergunta_reflexiva"]:
            recommendations.append("Add more reflective questions (target: 2-3)")

        # Element 5: Analogias/Diagramas
        analogias_score, analogias_details = self._score_analogias_diagramas(content)
        element_scores["analogias_diagramas"] = analogias_score
        details["analogias_diagramas"] = analogias_details
        if analogias_score < self.weights["analogias_diagramas"]:
            recommendations.append("Add analogies and diagram descriptions")

        # Element 6: Revisão Estruturada
        revisao_score, revisao_details = self._score_revisao_estruturada(content)
        element_scores["revisao_estruturada"] = revisao_score
        details["revisao_estruturada"] = revisao_details
        if revisao_score < self.weights["revisao_estruturada"]:
            recommendations.append("Add structured review (Before → After transformation)")

        # Element 7: Ação Rápida
        acao_score, acao_details = self._score_acao_rapida(content)
        element_scores["acao_rapida"] = acao_score
        details["acao_rapida"] = acao_details
        if acao_score < self.weights["acao_rapida"]:
            recommendations.append("Add 2-minute quick action exercise")

        # Calculate total score
        total_score = sum(element_scores.values())
        passed = total_score >= self.pass_threshold

        return DidaticaScore(
            score=total_score,
            passed=passed,
            element_scores=element_scores,
            details=details,
            recommendations=recommendations if not passed else []
        )

    def _score_hook_emocional(self, content: str) -> tuple[int, Dict]:
        """
        Score Element 1: Hook Emocional (Emotional Hook).

        Checks for:
        - Compelling promise in Goal section
        - Tangible outcomes (checkmarks)
        - Emotional/motivational language

        Returns:
            Tuple of (score, details)
        """
        max_points = self.weights["hook_emocional"]  # 15 points

        # Find Goal section
        goal_section = re.search(
            r'##\s*(G|GOAL|🎯).*?\n(.*?)(?=\n##|\Z)',
            content,
            re.DOTALL | re.IGNORECASE
        )

        if not goal_section:
            return (0, {"present": False, "reason": "No Goal section found"})

        goal_content = goal_section.group(2)

        score = 0
        details = {"present": True}

        # Check for tangible outcomes (5 points)
        outcomes = re.findall(r'(✅|✓|\[x\])', goal_content)
        if len(outcomes) >= 3:
            score += 5
            details["has_outcomes"] = True
        elif len(outcomes) > 0:
            score += 3
            details["has_outcomes"] = "partial"

        # Check for emotional/motivational language (5 points)
        emotional_keywords = [
            r'economizar',
            r'transformar',
            r'dominar',
            r'melhorar',
            r'save',
            r'transform',
            r'master',
            r'improve'
        ]
        emotional_count = sum(
            1 for keyword in emotional_keywords
            if re.search(keyword, goal_content, re.IGNORECASE)
        )
        if emotional_count >= 2:
            score += 5
            details["has_emotional_language"] = True
        elif emotional_count > 0:
            score += 2
            details["has_emotional_language"] = "partial"

        # Check for "why this matters" statement (5 points)
        why_patterns = [
            r'por que.*?(importa|matters)',
            r'isso (vai|irá)',
            r'this (will|is going to)'
        ]
        if any(re.search(pattern, goal_content, re.IGNORECASE) for pattern in why_patterns):
            score += 5
            details["has_why_statement"] = True

        return (min(score, max_points), details)

    def _score_conceitos_primordiais(self, content: str) -> tuple[int, Dict]:
        """
        Score Element 2: Conceitos Primordiais (Foundational Concepts).

        Checks for:
        - Clear concept explanations
        - Structured subsections in Steps
        - "What" before "How"

        Returns:
            Tuple of (score, details)
        """
        max_points = self.weights["conceitos_primordiais"]  # 20 points

        score = 0
        details = {}

        # Count subsections in Steps (###)
        subsections = re.findall(r'###\s+(.+)', content)
        subsection_count = len(subsections)

        if subsection_count >= 3:
            score += 10
            details["subsection_count"] = subsection_count
        elif subsection_count >= 2:
            score += 6
            details["subsection_count"] = subsection_count
        elif subsection_count >= 1:
            score += 3
            details["subsection_count"] = subsection_count

        # Check for "why before what" pattern
        why_patterns = [
            r'por que.*?funciona',
            r'why.*?works',
            r'antes do como',
            r'before.*?how'
        ]
        if any(re.search(pattern, content, re.IGNORECASE) for pattern in why_patterns):
            score += 5
            details["has_why_before_what"] = True

        # Check for clear definitions/explanations
        definition_patterns = [
            r'é (como|que)',
            r'significa',
            r'is (like|that)',
            r'means'
        ]
        definition_count = sum(
            1 for pattern in definition_patterns
            if re.search(pattern, content, re.IGNORECASE)
        )
        if definition_count >= 2:
            score += 5
            details["has_definitions"] = True
        elif definition_count > 0:
            score += 2
            details["has_definitions"] = "partial"

        return (min(score, max_points), details)

    def _score_link_transicao(self, content: str) -> tuple[int, Dict]:
        """
        Score Element 3: Link de Transição (Transition Links).

        Checks for:
        - Explicit transitions between concepts
        - "Now that... next..." pattern
        - Connecting words/phrases

        Returns:
            Tuple of (score, details)
        """
        max_points = self.weights["link_transicao"]  # 10 points

        score = 0
        details = {}

        # Look for transition link section or explicit transitions
        transition_patterns = [
            r'🔗.*?(link|conectando)',
            r'agora que.*?você',
            r'now that.*?you',
            r'na próxima',
            r'next (we|you)',
            r'isso (nos )?leva',
            r'(this|that) leads'
        ]

        transition_count = sum(
            1 for pattern in transition_patterns
            if re.search(pattern, content, re.IGNORECASE)
        )

        if transition_count >= 2:
            score = max_points
            details["transition_count"] = transition_count
        elif transition_count >= 1:
            score = max_points // 2
            details["transition_count"] = transition_count
        else:
            details["transition_count"] = 0

        return (score, details)

    def _score_pergunta_reflexiva(self, content: str) -> tuple[int, Dict]:
        """
        Score Element 4: Pergunta Reflexiva (Reflective Questions).

        Checks for:
        - Reflective questions (🤔 or direct questions)
        - Minimum 2 questions
        - Quality (not just factual recall)

        Returns:
            Tuple of (score, details)
        """
        max_points = self.weights["pergunta_reflexiva"]  # 15 points

        score = 0
        details = {}

        # Find reflective questions
        reflective_indicators = [
            r'🤔.*?\?',
            r'pense:.*?\?',
            r'think:.*?\?',
            r'pause.*?\?',
            r'reflect.*?\?',
            r'como (isso|você).*?\?',
            r'how (this|you).*?\?',
            r'o que você.*?\?',
            r'what (do|would) you.*?\?'
        ]

        question_count = sum(
            len(re.findall(pattern, content, re.IGNORECASE | re.DOTALL))
            for pattern in reflective_indicators
        )

        # Also count simple questions that might be reflective
        simple_questions = re.findall(r'[A-Z][^.!?]*?\?', content)
        total_questions = question_count + len(simple_questions)

        if total_questions >= 3:
            score = max_points
            details["question_count"] = total_questions
        elif total_questions >= 2:
            score = int(max_points * 0.75)
            details["question_count"] = total_questions
        elif total_questions >= 1:
            score = int(max_points * 0.5)
            details["question_count"] = total_questions
        else:
            details["question_count"] = 0

        return (score, details)

    def _score_analogias_diagramas(self, content: str) -> tuple[int, Dict]:
        """
        Score Element 5: Analogias/Diagramas (Semiotic Elements).

        Checks for:
        - Analogies ("é como", "is like")
        - Diagram descriptions ([DIAGRAM:...])
        - Visual metaphors

        Returns:
            Tuple of (score, details)
        """
        max_points = self.weights["analogias_diagramas"]  # 20 points

        score = 0
        details = {}

        # Find analogies
        analogy_patterns = [
            r'é como',
            r'is like',
            r'imagine que',
            r'imagine that',
            r'pensa(r)? (em|no)',
            r'think (of|about)',
            r'similar a',
            r'similar to'
        ]

        analogy_count = sum(
            len(re.findall(pattern, content, re.IGNORECASE))
            for pattern in analogy_patterns
        )

        if analogy_count >= 2:
            score += 10
            details["analogy_count"] = analogy_count
        elif analogy_count >= 1:
            score += 5
            details["analogy_count"] = analogy_count
        else:
            details["analogy_count"] = 0

        # Find diagram descriptions
        diagram_patterns = [
            r'\[DIAGRAM:',
            r'\[VISUAL:',
            r'\[IMAGE:',
            r'flowchart',
            r'diagrama',
            r'gráfico'
        ]

        diagram_count = sum(
            len(re.findall(pattern, content, re.IGNORECASE))
            for pattern in diagram_patterns
        )

        if diagram_count >= 1:
            score += 10
            details["diagram_count"] = diagram_count
        elif re.search(r'(visual|imagem|screenshot)', content, re.IGNORECASE):
            score += 5
            details["diagram_count"] = "implicit"
        else:
            details["diagram_count"] = 0

        return (min(score, max_points), details)

    def _score_revisao_estruturada(self, content: str) -> tuple[int, Dict]:
        """
        Score Element 6: Revisão Estruturada (Structured Review).

        Checks for:
        - Review section (💡 or "Revisão")
        - Before → After transformation
        - Key takeaways

        Returns:
            Tuple of (score, details)
        """
        max_points = self.weights["revisao_estruturada"]  # 10 points

        score = 0
        details = {}

        # Find review section
        review_patterns = [
            r'##\s*💡',
            r'##\s*REVISÃO',
            r'##\s*REVIEW',
            r'##\s*(O QUE|WHAT).*?(DOMINOU|LEARNED)',
            r'takeaways',
            r'principais.*?aprendizados'
        ]

        has_review_section = any(
            re.search(pattern, content, re.IGNORECASE)
            for pattern in review_patterns
        )

        if has_review_section:
            score += 5
            details["has_review_section"] = True

        # Check for before → after transformation
        transformation_patterns = [
            r'(você entrou|you entered).*?(achando|thinking)',
            r'agora (você sabe|you know)',
            r'before.*?after',
            r'transformação'
        ]

        has_transformation = any(
            re.search(pattern, content, re.IGNORECASE)
            for pattern in transformation_patterns
        )

        if has_transformation:
            score += 5
            details["has_transformation"] = True

        return (score, details)

    def _score_acao_rapida(self, content: str) -> tuple[int, Dict]:
        """
        Score Element 7: Ação Rápida (Quick Action).

        Checks for:
        - Quick action section (⚡ or "FAÇA AGORA")
        - 2-minute time constraint
        - Specific, achievable action

        Returns:
            Tuple of (score, details)
        """
        max_points = self.weights["acao_rapida"]  # 10 points

        score = 0
        details = {}

        # Find quick action section
        action_patterns = [
            r'##\s*⚡',
            r'##\s*AÇÃO RÁPIDA',
            r'##\s*FAÇA AGORA',
            r'##\s*QUICK ACTION',
            r'##\s*DO NOW'
        ]

        has_action_section = any(
            re.search(pattern, content, re.IGNORECASE)
            for pattern in action_patterns
        )

        if has_action_section:
            score += 5
            details["has_action_section"] = True

        # Check for time constraint (2 min)
        time_patterns = [
            r'2 minutos',
            r'2 min\b',
            r'2-minute',
            r'dois minutos'
        ]

        has_time_constraint = any(
            re.search(pattern, content, re.IGNORECASE)
            for pattern in time_patterns
        )

        if has_time_constraint:
            score += 2
            details["has_time_constraint"] = True

        # Check for specific steps/checklist
        if re.search(r'✓|✅|\[.*?\]', content):
            score += 3
            details["has_checklist"] = True

        return (min(score, max_points), details)

    def validate_semiotic_elements(self, content: str) -> Dict:
        """
        Validate minimum semiotic elements requirement.

        Requirements:
        - 1+ analogy
        - 1+ diagram
        - 2+ reflective questions

        Returns:
            Dict with counts and pass/fail
        """
        # Count analogies
        analogy_patterns = [r'é como', r'is like', r'imagine', r'pensa em', r'think of']
        analogy_count = sum(
            len(re.findall(pattern, content, re.IGNORECASE))
            for pattern in analogy_patterns
        )

        # Count diagrams
        diagram_patterns = [r'\[DIAGRAM:', r'\[VISUAL:', r'flowchart', r'diagrama']
        diagram_count = sum(
            len(re.findall(pattern, content, re.IGNORECASE))
            for pattern in diagram_patterns
        )

        # Count reflective questions
        question_patterns = [r'🤔.*?\?', r'pense:.*?\?', r'como você.*?\?']
        question_count = sum(
            len(re.findall(pattern, content, re.IGNORECASE | re.DOTALL))
            for pattern in question_patterns
        )

        passed = (analogy_count >= 1 and diagram_count >= 1 and question_count >= 2)

        return {
            "analogy_count": analogy_count,
            "diagram_count": diagram_count,
            "question_count": question_count,
            "passed": passed,
            "min_analogy": 1,
            "min_diagram": 1,
            "min_questions": 2
        }


# Utility functions

def quick_dl_score(content: str) -> int:
    """
    Quick Didática Lendária score (0-100).

    Args:
        content: Lesson content

    Returns:
        Score (0-100)
    """
    scorer = DidaticaScorer()
    result = scorer.score_lesson(content)
    return result.score


def dl_passed(content: str) -> bool:
    """
    Check if lesson passes Didática Lendária threshold.

    Args:
        content: Lesson content

    Returns:
        True if score >= 70
    """
    scorer = DidaticaScorer()
    result = scorer.score_lesson(content)
    return result.passed


# Example usage
if __name__ == "__main__":
    # Test with sample content
    test_lesson = """
# Test Lesson

## 🎯 G - GOAL

Ao final desta aula, você vai:
✅ Dominar links internos
✅ Usar backlinks efetivamente
✅ Ter segundo cérebro funcionando

Por que isso importa? Vai economizar 10+ horas por semana.

## 🗺️ P - POSITION

Eu sei que você pode estar pensando: "Mais uma ferramenta?"

Se você nunca usou Obsidian antes, tudo bem.

## 🛤️ S - STEPS

### Por Que Links Importam

Links são como neurônios do seu cérebro. Imagine que cada nota é uma ideia...

[DIAGRAM: Neurônios conectados]

🤔 Onde você já perdeu tempo procurando uma nota?

### Passo 1: Criar Links

Agora vamos criar...

🤔 Como isso mudaria seu fluxo de trabalho?

## 💡 O QUE VOCÊ DOMINOU

Você entrou achando que links eram organização.
Agora você sabe que são pensamento externalizado.

## ⚡ FAÇA AGORA (2 minutos)

1. Abra uma nota
2. Crie [[link]]
3. Veja backlink

✓ Funcionou se você viu o link
    """

    scorer = DidaticaScorer()
    result = scorer.score_lesson(test_lesson)

    print("Didática Lendária Scoring Results:")
    print(f"  Overall Score: {result.score}/100")
    print(f"  Passed: {result.passed} (threshold: 70)")
    print("\n  Element Breakdown:")
    for element, score in result.element_scores.items():
        print(f"    {element}: {score} points")

    if result.recommendations:
        print("\n  Recommendations:")
        for rec in result.recommendations:
            print(f"    - {rec}")
