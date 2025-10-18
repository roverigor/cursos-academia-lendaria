#!/usr/bin/env python3
"""
Assessment Generator for CreatorOS
Story 3.14: Transformational Assessment Generation (EPIC-3)

Generates application-focused assessments (not memorization):
- Scenario-based quizzes
- Real-world projects
- Portfolio-worthy deliverables
"""

from pathlib import Path
from typing import Dict, List
import yaml


class AssessmentGenerator:
    """Generate transformational assessments"""

    def __init__(self, course_slug: str):
        self.course_slug = course_slug
        self.course_dir = Path(f"outputs/courses/{course_slug}")
        self.assessments_dir = self.course_dir / "assessments"

    def generate_assessments(self, curriculum: Dict) -> List[Path]:
        """Generate all assessments for course"""
        self.assessments_dir.mkdir(parents=True, exist_ok=True)

        generated_files = []

        # Generate quizzes (1 per module)
        for i, module in enumerate(curriculum.get("modules", []), start=1):
            quiz_file = self._generate_module_quiz(module, i)
            if quiz_file:
                generated_files.append(quiz_file)

        # Generate final project
        project_file = self._generate_final_project(curriculum)
        if project_file:
            generated_files.append(project_file)

        print(f"✅ Generated {len(generated_files)} assessments")
        return generated_files

    def _generate_module_quiz(self, module: Dict, module_num: int) -> Path:
        """Generate quiz for module (scenario-based)"""
        quiz_data = {
            "module": module_num,
            "title": f"Quiz - {module.get('title', f'Module {module_num}')}",
            "type": "application",
            "difficulty": "real_world",
            "questions": [
                {
                    "id": f"q{i+1}",
                    "type": "scenario",
                    "scenario": f"Scenario-based question {i+1} (implementation pending)",
                    "correct_answer": "A",
                    "explanation": "Explanation pending"
                }
                for i in range(3)  # 3 questions per quiz
            ]
        }

        quiz_file = self.assessments_dir / f"quiz-module-{module_num}.yaml"
        with open(quiz_file, 'w', encoding='utf-8') as f:
            yaml.dump(quiz_data, f, default_flow_style=False, allow_unicode=True)

        return quiz_file

    def _generate_final_project(self, curriculum: Dict) -> Path:
        """Generate final capstone project"""
        project_content = f"""# Final Project: Portfolio-Worthy Deliverable

## Objective
Create a real-world application of course concepts that demonstrates mastery
and can be added to your professional portfolio.

## Requirements
1. Apply concepts from all modules
2. Solve a real problem (not academic exercise)
3. Document your approach and results
4. Deliverable should be shareable/demonstrable

## Rubric
- **Junior Level (70-79):** Follows instructions, basic implementation
- **Pleno Level (80-89):** Goes beyond basics, shows understanding
- **Senior Level (90-100):** Production-ready, innovative approach

## Submission
Submit your project with:
1. Final deliverable
2. Process documentation
3. Reflection on learnings

---
*This assessment tests application in real scenarios, not memorization.*
"""

        project_file = self.assessments_dir / "final-project.md"
        with open(project_file, 'w', encoding='utf-8') as f:
            f.write(project_content)

        return project_file


# CLI
if __name__ == "__main__":
    import sys
    if len(sys.argv) < 2:
        print("Usage: python assessment_generator.py <course_slug>")
        sys.exit(1)

    course_slug = sys.argv[1]
    curriculum_path = Path(f"outputs/courses/{course_slug}/curriculum.yaml")

    if not curriculum_path.exists():
        print(f"❌ Curriculum not found: {curriculum_path}")
        sys.exit(1)

    with open(curriculum_path, 'r', encoding='utf-8') as f:
        curriculum = yaml.safe_load(f)

    generator = AssessmentGenerator(course_slug)
    files = generator.generate_assessments(curriculum)

    print(f"\n✅ Assessment generation complete:")
    for file in files:
        print(f"   - {file.name}")
