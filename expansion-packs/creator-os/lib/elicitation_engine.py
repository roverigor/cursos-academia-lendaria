#!/usr/bin/env python3
"""
Elicitation Engine for CreatorOS Smart Question Flow

This module implements interactive elicitation with intelligent question skipping.
Part of Story 3.6: Gap Analysis & Smart Elicitation (EPIC-3: Intelligent Workflow)

Key Features:
- Interactive CLI question flow
- Three-tier display (Complete/Confirmation/Missing sections)
- Question validation with input types (text, multiple choice, confirmation)
- Progress tracking during elicitation
- Summary display (questions saved vs total baseline)
- Answer collection and validation

Question Types:
1. Confirmation: Show extracted data, ask yes/no/show_source
2. Elicitation: Ask for missing data with options
3. Multiple choice: Single selection from options
4. Multiple select: Multiple selections from options
5. Text input: Free-form text answer

Usage:
    from lib.elicitation_engine import ElicitationEngine
    from lib.gap_analyzer import GapAnalyzer

    analyzer = GapAnalyzer("dominando-obsidian")
    completeness = analyzer.analyze_completeness()
    questions = analyzer.generate_questions(completeness)

    engine = ElicitationEngine(questions)
    engine.display_summary(completeness)
    answers = engine.run_interactive_flow()
"""

import sys
from typing import List, Dict, Optional
from dataclasses import dataclass
from datetime import datetime

# Import from gap_analyzer
from .gap_analyzer import Question, Answer, CompletenessMap, SectionStatus


class ElicitationEngine:
    """
    Interactive elicitation engine for smart question flow.

    Presents questions to user in CLI, validates answers, and collects responses.
    """

    def __init__(self, questions: List[Question]):
        """
        Initialize ElicitationEngine with questions to ask.

        Args:
            questions: List of Question objects from GapAnalyzer
        """
        self.questions = questions
        self.answers: Dict[str, Answer] = {}

    def display_summary(self, completeness_map: CompletenessMap):
        """
        Display completeness summary in three-tier format.

        Shows:
        1. ✅ COMPLETE sections (no action needed)
        2. 🔄 NEEDS CONFIRMATION sections (review extracted data)
        3. ❓ MISSING sections (need your input)

        Args:
            completeness_map: Result from GapAnalyzer.analyze_completeness()
        """
        print("\n" + "=" * 70)
        print("📊 BRIEF ANALYSIS COMPLETE")
        print("=" * 70)
        print("\nI analyzed your existing materials and auto-filled these sections:\n")

        # 1. Complete sections
        complete_sections = [s for s in completeness_map.sections.values() if s.status == "🟢"]
        if complete_sections:
            print("=" * 70)
            print("✅ COMPLETE (No action needed):\n")

            for section in complete_sections:
                print(f"🟢 {section.section_name}")

                # Show what was extracted
                if section.section_id == "section_2_icp":
                    print("   ✓ Demographics extracted from legacy materials")
                    print("   ✓ Psychographics extracted")
                    if section.subsections.get("pain_points") == "🟢":
                        print("   ✓ Pain points extracted")
                    if section.subsections.get("goals") == "🟢":
                        print("   ✓ Goals extracted")

                elif section.section_id == "section_4_voice":
                    print("   ✓ Analyzed transcripts")
                    print("   ✓ Signature greeting identified")
                    print("   ✓ Tone & style extracted")
                    print("   ✓ Recurring phrases identified")

                elif section.section_id == "section_3_content":
                    if section.fields.get("objectives") == "🟢":
                        print("   ✓ Learning objectives inferred from lessons")

                elif section.section_id == "section_7_context":
                    print("   ✓ Auto-generated links to legacy materials")

                print()

        # 2. Needs confirmation sections
        confirmation_sections = [s for s in completeness_map.sections.values() if s.status == "🟡"]
        if confirmation_sections:
            print("=" * 70)
            print("🔄 NEEDS CONFIRMATION (Please review):\n")

            for section in confirmation_sections:
                print(f"🟡 {section.section_name}")
                print(f"   Extracted with {section.completeness}% completeness")
                print(f"   → Please confirm accuracy\n")

        # 3. Missing sections
        missing_sections = [s for s in completeness_map.sections.values() if s.status == "🔴"]
        if missing_sections:
            print("=" * 70)
            print("❓ MISSING (Need your input):\n")

            for section in missing_sections:
                print(f"🔴 {section.section_name}")
                print(f"   → {len([q for q in self.questions if q.section_id == section.section_id])} question(s)\n")

        # Summary
        print("=" * 70)
        print("📋 SUMMARY:")
        print(f"   Complete sections: {len(complete_sections)}/{len(completeness_map.sections)}")
        print(f"   Needs confirmation: {len(confirmation_sections)}")
        print(f"   Missing data: {len(missing_sections)}")
        print(f"\n   Total questions: {len(self.questions)}")

        # Calculate saved questions
        baseline_questions = 15  # Baseline for greenfield
        saved_questions = baseline_questions - len(self.questions)
        if saved_questions > 0:
            print(f"   💡 Saved you {saved_questions} question(s) with smart extraction!")

        # Time estimate
        estimated_minutes = max(3, len(self.questions) * 2)  # 2 min per question, min 3
        print(f"\n   Estimated time: {estimated_minutes}-{estimated_minutes + 2} minutes")

        print("=" * 70)
        print("\nLet's fill in the gaps...\n")

    def run_interactive_flow(self) -> Dict[str, Answer]:
        """
        Run interactive question flow in CLI.

        Returns:
            Dict of question_id → Answer objects
        """
        if not self.questions:
            print("✅ No questions needed - all sections are complete!\n")
            return {}

        print(f"📝 Answering {len(self.questions)} question(s)...\n")

        for i, question in enumerate(self.questions, 1):
            print(f"\n{'─' * 70}")
            print(f"Question {i}/{len(self.questions)}")
            print(f"{'─' * 70}\n")

            answer = self.ask_question(question)
            self.answers[question.question_id] = answer

        print("\n" + "=" * 70)
        print("✅ All questions answered!")
        print("=" * 70)

        return self.answers

    def ask_question(self, question: Question) -> Answer:
        """
        Ask a single question and collect answer.

        Args:
            question: Question object

        Returns:
            Answer object with validated response
        """
        # Display question prompt
        print(question.prompt)
        print()

        # Handle different input types
        if question.input_type == "confirmation":
            answer_value = self._ask_confirmation(question)

        elif question.input_type == "multiple_choice":
            answer_value = self._ask_multiple_choice(question)

        elif question.input_type == "multiple_select":
            answer_value = self._ask_multiple_select(question)

        elif question.input_type == "text":
            answer_value = self._ask_text(question)

        else:
            raise ValueError(f"Unknown input type: {question.input_type}")

        # Create Answer object
        return Answer(
            question_id=question.question_id,
            answer_type=question.question_type,
            value=answer_value,
            timestamp=datetime.now().isoformat()
        )

    def _ask_confirmation(self, question: Question) -> str:
        """Ask confirmation question (yes/no/show_source)."""
        # Display options
        for i, option in enumerate(question.options, 1):
            print(f"  [{i}] {option['label']}")

        print()

        while True:
            choice = input(f"Your choice (1-{len(question.options)}): ").strip()

            try:
                choice_index = int(choice) - 1
                if 0 <= choice_index < len(question.options):
                    selected_option = question.options[choice_index]
                    return selected_option['value']
                else:
                    print(f"❌ Please enter a number between 1 and {len(question.options)}\n")
            except ValueError:
                print(f"❌ Please enter a valid number\n")

    def _ask_multiple_choice(self, question: Question) -> str:
        """Ask multiple choice question (single selection)."""
        # Display options with descriptions
        for i, option in enumerate(question.options, 1):
            label = option['label']
            description = option.get('description', '')

            if description:
                print(f"  [{i}] {label}")
                print(f"      {description}")
            else:
                print(f"  [{i}] {label}")

        print()

        while True:
            choice = input(f"Your choice (1-{len(question.options)}): ").strip()

            try:
                choice_index = int(choice) - 1
                if 0 <= choice_index < len(question.options):
                    selected_option = question.options[choice_index]
                    return selected_option['value']
                else:
                    print(f"❌ Please enter a number between 1 and {len(question.options)}\n")
            except ValueError:
                print(f"❌ Please enter a valid number\n")

    def _ask_multiple_select(self, question: Question) -> str:
        """Ask multiple select question (multiple selections allowed)."""
        # Display options with descriptions
        for i, option in enumerate(question.options, 1):
            label = option['label']
            description = option.get('description', '')

            if description:
                print(f"  [{i}] {label}")
                print(f"      {description}")
            else:
                print(f"  [{i}] {label}")

        print()

        while True:
            choices = input(f"Your choices (comma-separated, e.g., 1,2,5): ").strip()

            try:
                # Parse comma-separated choices
                choice_indices = [int(c.strip()) - 1 for c in choices.split(',') if c.strip()]

                # Validate all choices
                if all(0 <= idx < len(question.options) for idx in choice_indices):
                    selected_values = [question.options[idx]['value'] for idx in choice_indices]
                    return ','.join(selected_values)
                else:
                    print(f"❌ Please enter numbers between 1 and {len(question.options)}\n")
            except ValueError:
                print(f"❌ Please enter valid numbers separated by commas\n")

    def _ask_text(self, question: Question) -> str:
        """Ask free-form text question."""
        while True:
            answer = input("Your answer: ").strip()

            if answer:
                # Optionally validate minimum length
                if len(answer) >= 3:
                    return answer
                else:
                    print("❌ Answer too short (minimum 3 characters)\n")
            else:
                print("❌ Answer cannot be empty\n")

    def validate_answer(self, question: Question, raw_answer: str) -> Answer:
        """
        Validate and parse user input.

        Args:
            question: Question being answered
            raw_answer: Raw user input

        Returns:
            Validated Answer object
        """
        # Basic validation (can be extended)
        if not raw_answer or not raw_answer.strip():
            raise ValueError("Answer cannot be empty")

        return Answer(
            question_id=question.question_id,
            answer_type=question.question_type,
            value=raw_answer.strip(),
            timestamp=datetime.now().isoformat()
        )

    def display_completion_summary(self, initial_completeness: CompletenessMap, final_completeness: CompletenessMap):
        """
        Display summary after all answers persisted.

        Shows before/after completeness scores.

        Args:
            initial_completeness: Completeness before elicitation
            final_completeness: Completeness after elicitation
        """
        print("\n" + "=" * 70)
        print("📊 ELICITATION COMPLETE")
        print("=" * 70)

        print(f"\nCompleteness Score:")
        print(f"  Before: {initial_completeness.overall_score}%")
        print(f"  After:  {final_completeness.overall_score}%")
        print(f"  Improvement: +{final_completeness.overall_score - initial_completeness.overall_score}%")

        # Section-by-section comparison
        print(f"\nSection Status Updates:")

        for section_id, final_section in final_completeness.sections.items():
            initial_section = initial_completeness.sections[section_id]

            if initial_section.status != final_section.status:
                print(f"  {initial_section.status} → {final_section.status}  {final_section.section_name}")

        print("\n" + "=" * 70)
        print("✅ COURSE-BRIEF.md updated successfully")
        print("=" * 70)


def main():
    """
    Example usage and testing.
    """
    from lib.gap_analyzer import GapAnalyzer

    # Test with a course
    course_slug = "test-course"

    try:
        # Analyze completeness
        analyzer = GapAnalyzer(course_slug)
        initial_completeness = analyzer.analyze_completeness()

        # Generate questions
        questions = analyzer.generate_questions(initial_completeness)

        # Run elicitation
        engine = ElicitationEngine(questions)
        engine.display_summary(initial_completeness)
        answers = engine.run_interactive_flow()

        # Persist answers
        final_completeness = analyzer.persist_answers(answers)

        # Display results
        engine.display_completion_summary(initial_completeness, final_completeness)

        # Final validation
        analyzer.validate_brief_complete()

        print("\n✅ All sections complete! Ready to generate course.")

    except FileNotFoundError as e:
        print(f"❌ Error: {e}")
    except ValueError as e:
        print(f"❌ Validation Error: {e}")
    except Exception as e:
        print(f"❌ Unexpected Error: {e}")
        import traceback
        traceback.print_exc()


if __name__ == "__main__":
    main()
