#!/usr/bin/env python3
"""
Course Initialization Script
Implements greenfield/brownfield detection and course setup

Usage:
    python scripts/init_course.py

Interactive workflow that guides user through:
- Course slug selection
- Greenfield vs Brownfield mode detection
- Mode validation (4 scenarios)
- Folder structure creation (greenfield)
- File organization (brownfield)
- MMOS persona selection
- Next steps guidance

Story: Story 3.1 - Greenfield/Brownfield Detection
Story: Story 3.2 - File Organization
Story: Story 3.7 - MMOS Persona Integration
"""

import sys
import os
import re
from pathlib import Path
import shutil
import yaml

# Add lib directory to path
sys.path.insert(0, str(Path(__file__).parent.parent / "lib"))


def validate_slug(slug: str) -> bool:
    """Validate course slug format."""
    pattern = r'^[a-z0-9-]{3,50}$'
    return bool(re.match(pattern, slug))


def detect_folder_state(course_path: Path) -> str:
    """
    Detect folder state for mode validation.

    Returns:
        "not_exists", "empty", "has_brief", "has_files"
    """
    if not course_path.exists():
        return "not_exists"

    files = list(course_path.iterdir())

    if len(files) == 0:
        return "empty"

    # Check for COURSE-BRIEF.md
    brief_path = course_path / "COURSE-BRIEF.md"
    if brief_path.exists():
        return "has_brief"

    # Has other files
    if len(files) > 0:
        return "has_files"

    return "empty"


def validate_mode_against_state(mode: str, folder_state: str) -> tuple[bool, str]:
    """
    Validate creation mode against folder state.

    Returns:
        (valid, message)
    """
    # Scenario 1: Greenfield + folder doesn't exist
    if mode == "greenfield" and folder_state == "not_exists":
        return (True, "✅ Valid: Greenfield mode, folder will be created")

    # Scenario 2: Greenfield + folder exists with files
    elif mode == "greenfield" and folder_state in ["has_files", "has_brief"]:
        return (False, "❌ Conflict: Greenfield mode but folder already exists with files")

    # Scenario 3: Brownfield + folder exists with files
    elif mode == "brownfield" and folder_state in ["has_files"]:
        return (True, "✅ Valid: Brownfield mode, files detected for organization")

    # Scenario 4: Brownfield + folder doesn't exist
    elif mode == "brownfield" and folder_state == "not_exists":
        return (False, "❌ Conflict: Brownfield mode but no existing folder found")

    # Edge cases
    elif mode == "greenfield" and folder_state == "empty":
        return (True, "✅ Valid: Greenfield mode, empty folder will be used")

    elif mode == "brownfield" and folder_state == "empty":
        return (False, "⚠️  Warning: Brownfield mode but folder is empty (no files to organize)")

    elif mode == "brownfield" and folder_state == "has_brief":
        return (True, "✅ Valid: Brownfield mode, resuming existing course")

    else:
        return (False, f"❌ Unknown combination: {mode} + {folder_state}")


def create_greenfield_structure(course_slug: str) -> Path:
    """
    Create folder structure for greenfield course.

    Returns:
        Path to course directory
    """
    course_path = Path(f"outputs/courses/{course_slug}")
    course_path.mkdir(parents=True, exist_ok=True)

    # Create COURSE-BRIEF.md from template
    template_path = Path("expansion-packs/creator-os/templates/course-brief.md")

    if not template_path.exists():
        print(f"⚠️  Template not found: {template_path}")
        print(f"Creating minimal COURSE-BRIEF.md")

        # Create minimal brief
        brief_content = f"""---
title: "Untitled Course"
creation_mode: greenfield
created_at: {__import__('datetime').datetime.now().isoformat()}
mmos_persona:
  enabled: false
---

# COURSE-BRIEF: {course_slug}

## 1. BASIC INFO
[Fill in course title, tagline, duration, etc.]

## 2. ICP (Ideal Customer Profile)
[Fill in target audience demographics and psychographics]

## 3. CONTENT & CURRICULUM
[Fill in learning objectives and preliminary outline]

## 4. VOICE & PERSONALITY
[Fill in instructor voice preferences]

## 5. FORMAT & DELIVERY
[Fill in teaching style and course structure]

## 6. COMMERCIAL GOALS
[Fill in pricing and revenue targets]

## 7. SUCCESS METRICS
[Fill in KPIs and completion targets]

## 8. CONSTRAINTS & REQUIREMENTS
[Fill in limitations and special requirements]
"""
        brief_path = course_path / "COURSE-BRIEF.md"
        with open(brief_path, 'w', encoding='utf-8') as f:
            f.write(brief_content)

    else:
        # Copy template
        brief_path = course_path / "COURSE-BRIEF.md"
        shutil.copy2(template_path, brief_path)

        # Update frontmatter
        with open(brief_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Replace placeholders
        content = content.replace("creation_mode: greenfield", "creation_mode: greenfield")
        content = content.replace("{{course_slug}}", course_slug)

        with open(brief_path, 'w', encoding='utf-8') as f:
            f.write(content)

    print(f"\n✅ Created greenfield structure:")
    print(f"   {course_path}/")
    print(f"   └── COURSE-BRIEF.md")
    print()

    return course_path


def organize_brownfield_files(course_slug: str) -> Path:
    """
    Organize existing files for brownfield course.

    Returns:
        Path to course directory
    """
    course_path = Path(f"outputs/courses/{course_slug}")

    # Import file organizer
    from file_organizer import FileOrganizer

    print(f"\n📁 Organizing existing files...")

    try:
        organizer = FileOrganizer(course_slug)

        # Scan files
        inventory = organizer.scan()

        print(f"\n📊 Scanned {len(inventory)} files")

        # Dry run first (preview)
        print("\n🔍 Preview (dry run):")
        result = organizer.organize(dry_run=True)

        # Ask for confirmation
        print()
        confirm = input("Proceed with file organization? (yes/no): ").strip().lower()

        if confirm == "yes":
            # Execute organization
            result = organizer.organize(dry_run=False)

            print(f"\n✅ Organized {result.files_moved} files")
            print(f"   Audit log: {result.audit_log_path}")
        else:
            print("\n❌ File organization canceled")

    except Exception as e:
        print(f"\n⚠️  File organization failed: {e}")
        print(f"Continuing with manual organization...")

    return course_path


def select_mmos_persona(course_slug: str, course_path: Path) -> dict:
    """
    Interactive MMOS persona selection.

    Returns:
        MMOS persona configuration dict
    """
    print("\n" + "="*64)
    print("MMOS PERSONA SELECTION (Optional)")
    print("="*64)
    print()
    print("Do you want to use an MMOS cognitive clone for instructor voice?")
    print()
    print("Benefits:")
    print("  - 90%+ voice fidelity (students \"hear\" the instructor)")
    print("  - Consistent tone, style, and teaching approach")
    print("  - Authentic personality in every lesson")
    print()
    print("Requirements:")
    print("  - MMOS persona must already exist in outputs/minds/{slug}/")
    print("  - System prompt file must be available")
    print()

    use_mmos = input("Use MMOS persona? (yes/no): ").strip().lower()

    if use_mmos != "yes":
        return {"enabled": False}

    # List available MMOS personas
    minds_path = Path("outputs/minds")

    if not minds_path.exists():
        print("\n⚠️  No MMOS personas found (outputs/minds/ doesn't exist)")
        return {"enabled": False}

    personas = [p.name for p in minds_path.iterdir() if p.is_dir() and not p.name.startswith('.')]

    if not personas:
        print("\n⚠️  No MMOS personas found")
        return {"enabled": False}

    print(f"\n📋 Available MMOS personas:")
    for i, persona in enumerate(personas, 1):
        print(f"   {i}. {persona}")

    print()
    choice = input("Select persona (number or slug): ").strip()

    # Parse choice
    if choice.isdigit():
        idx = int(choice) - 1
        if 0 <= idx < len(personas):
            selected_slug = personas[idx]
        else:
            print("❌ Invalid choice")
            return {"enabled": False}
    else:
        if choice in personas:
            selected_slug = choice
        else:
            print("❌ Persona not found")
            return {"enabled": False}

    # Find system prompt
    persona_path = minds_path / selected_slug
    system_prompt_candidates = [
        persona_path / "system_prompts" / "system-prompt-generalista.md",
        persona_path / "system_prompts" / "system-prompt.md",
        persona_path / "implementation" / "system-prompt-generalista.md",
    ]

    system_prompt_path = None
    for candidate in system_prompt_candidates:
        if candidate.exists():
            system_prompt_path = candidate
            break

    if not system_prompt_path:
        print(f"\n⚠️  System prompt not found for {selected_slug}")
        print(f"Searched in:")
        for candidate in system_prompt_candidates:
            print(f"   - {candidate}")
        return {"enabled": False}

    print(f"\n✅ Selected MMOS persona: {selected_slug}")
    print(f"   System prompt: {system_prompt_path}")

    return {
        "enabled": True,
        "persona_slug": selected_slug,
        "system_prompt_path": str(system_prompt_path),
        "fidelity_target": 0.90
    }


def main():
    """Main interactive workflow."""
    print("="*64)
    print("COURSE INITIALIZATION")
    print("="*64)
    print()

    # Step 1: Get course slug
    print("Step 1: Course Identifier")
    print()
    print("Enter course slug (3-50 chars, lowercase, hyphens only)")
    print("Examples: dominando-obsidian, python-basics, team-onboarding")
    print()

    course_slug = input("Course slug: ").strip()

    if not validate_slug(course_slug):
        print("\n❌ Invalid slug format")
        print("Must be 3-50 characters: lowercase letters, numbers, hyphens only")
        sys.exit(1)

    course_path = Path(f"outputs/courses/{course_slug}")

    # Step 2: Detect folder state
    folder_state = detect_folder_state(course_path)
    print(f"\n📁 Folder state: {folder_state}")

    # Step 3: Ask for creation mode
    print("\n" + "-"*64)
    print("Step 2: Creation Mode")
    print("-"*64)
    print()
    print("1. Greenfield - Creating from scratch (no existing materials)")
    print("   → Folder should NOT exist yet")
    print()
    print("2. Brownfield - Upgrading/migrating existing course materials")
    print("   → Folder should already exist with files")
    print()

    mode_choice = input("Choose mode (1 or 2): ").strip()

    if mode_choice == "1":
        mode = "greenfield"
    elif mode_choice == "2":
        mode = "brownfield"
    else:
        print("\n❌ Invalid choice")
        sys.exit(1)

    # Step 4: Validate mode against state
    valid, message = validate_mode_against_state(mode, folder_state)

    print(f"\n{message}")

    if not valid:
        print()
        print("Resolution options:")
        if mode == "greenfield" and folder_state in ["has_files", "has_brief"]:
            print(f"  1. Delete folder: rm -rf {course_path}")
            print(f"  2. Use brownfield mode instead")
            print(f"  3. Choose different course slug")
        elif mode == "brownfield" and folder_state == "not_exists":
            print(f"  1. Create folder and add existing materials: mkdir -p {course_path}")
            print(f"  2. Use greenfield mode instead")
        sys.exit(1)

    # Step 5: Execute workflow
    print("\n" + "-"*64)
    print("Step 3: Setup")
    print("-"*64)

    if mode == "greenfield":
        course_path = create_greenfield_structure(course_slug)

    else:  # brownfield
        course_path = organize_brownfield_files(course_slug)

    # Step 6: MMOS Persona Selection
    mmos_config = select_mmos_persona(course_slug, course_path)

    # Update COURSE-BRIEF.md with MMOS config
    brief_path = course_path / "COURSE-BRIEF.md"
    if brief_path.exists():
        with open(brief_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Update MMOS persona in frontmatter
        if '---' in content:
            parts = content.split('---', 2)
            if len(parts) >= 3:
                frontmatter = yaml.safe_load(parts[1])
                frontmatter['mmos_persona'] = mmos_config

                # Reconstruct
                new_frontmatter = yaml.dump(frontmatter, default_flow_style=False, allow_unicode=True)
                content = f"---\n{new_frontmatter}---{parts[2]}"

                with open(brief_path, 'w', encoding='utf-8') as f:
                    f.write(content)

    # Step 7: Next steps
    print("\n" + "="*64)
    print("✅ COURSE INITIALIZED!")
    print("="*64)
    print()
    print(f"Course: {course_slug}")
    print(f"Mode: {mode}")
    print(f"Location: {course_path}")
    print()

    if mode == "greenfield":
        print("📝 NEXT STEPS:")
        print()
        print(f"1. Fill COURSE-BRIEF.md:")
        print(f"   → Open: {brief_path}")
        print(f"   → Complete all 8 sections")
        print()
        print(f"2. Generate course:")
        print(f"   → Run: python scripts/generate_course.py {course_slug}")
        print()

    else:  # brownfield
        print("📝 NEXT STEPS:")
        print()
        print(f"1. Review organized files:")
        print(f"   → Check: {course_path}/legado/")
        print()
        print(f"2. Auto-extract content:")
        print(f"   → Run ICP extraction")
        print(f"   → Run voice extraction")
        print(f"   → Run objectives inference")
        print()
        print(f"3. Fill remaining COURSE-BRIEF sections:")
        print(f"   → Open: {brief_path}")
        print()
        print(f"4. Generate course:")
        print(f"   → Run: python scripts/generate_course.py {course_slug}")
        print()

    print("="*64)
    print()


if __name__ == "__main__":
    main()
