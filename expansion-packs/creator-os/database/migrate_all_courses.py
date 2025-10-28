#!/usr/bin/env python3
"""
Migrate all courses from outputs/courses/ to Supabase database.
Excludes: dominando-obsidian (already done), no-migration (marked skip)

NO EXTERNAL DEPENDENCIES - Uses only Python stdlib
Generates SQL file that can be executed with psql
"""

import os
import re
import json
from pathlib import Path
from typing import Dict, List, Optional
import sys
import subprocess

def load_curriculum(course_path: Path) -> Dict:
    """Load curriculum.yaml for a course (parse as simple YAML subset)."""
    yaml_path = course_path / "curriculum.yaml"
    if not yaml_path.exists():
        return None

    # Simple YAML parser for our curriculum structure
    with open(yaml_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Convert YAML to JSON-like dict (simple key: value parsing)
    result = {}
    current_section = None
    current_key = None
    current_multiline = []
    current_module = None
    modules = []
    lessons = []

    for line in content.split('\n'):
        line_stripped = line.strip()
        if not line_stripped or line_stripped.startswith('#') or line_stripped.startswith('---'):
            continue

        indent = len(line) - len(line.lstrip())

        # Check if it's a key: value line
        if ':' in line and not line_stripped.startswith('-'):
            # Save previous multiline content if any
            if current_multiline and current_key and current_section:
                target_key = 'professor' if current_section == 'instructor' else current_section
                if target_key not in result:
                    result[target_key] = {}
                result[target_key][current_key] = ' '.join(current_multiline).strip()
                current_multiline = []
                current_key = None

            key, value = line.split(':', 1)
            key = key.strip()
            value = value.strip()

            if indent == 0:
                if key in ['course', 'professor', 'instructor', 'metadata']:
                    current_section = key
                    if key == 'instructor':
                        key = 'professor'  # Normalize
                    if key not in result:
                        result[key] = {}
                elif key == 'modules':
                    current_section = 'modules'
                    modules = []
                elif key not in ['modules', 'lessons']:
                    # Root level fields
                    result[key] = value.strip('"\'').strip('|')
            elif current_section in ['course', 'professor', 'instructor', 'metadata']:
                # Check if it's multiline value indicator
                if value in ['|', '>']:
                    current_key = key
                    current_multiline = []
                else:
                    target_key = 'professor' if current_section == 'instructor' else current_section
                    if target_key not in result:
                        result[target_key] = {}
                    result[target_key][key] = value.strip('"\'')
        elif current_key and indent > 0:
            # Multiline content
            current_multiline.append(line_stripped)
        elif current_section == 'modules':
            if '- title:' in line or indent == 2 and line.strip().startswith('- '):
                if current_module and lessons:
                    current_module['lessons'] = lessons
                if current_module:
                    modules.append(current_module)
                current_module = {}
                lessons = []
                if 'title:' in line:
                    current_module['title'] = line.split('title:')[1].strip().strip('"\'')
            elif current_module and ':' in line:
                key, value = line.split(':', 1)
                key = key.strip()
                value = value.strip().strip('"\'')
                if key == 'lessons':
                    continue
                elif key == 'title' and indent > 4:  # Lesson title
                    lessons.append({'title': value})
                elif lessons and key in ['duration_minutes', 'description', 'content']:
                    lessons[-1][key] = value
                else:
                    current_module[key] = value

    if current_module:
        if lessons:
            current_module['lessons'] = lessons
        modules.append(current_module)

    if modules:
        result['modules'] = modules

    return result if result else None

def slugify(text: str) -> str:
    """Convert text to slug."""
    import re
    text = text.lower()
    text = re.sub(r'[àáâãäå]', 'a', text)
    text = re.sub(r'[èéêë]', 'e', text)
    text = re.sub(r'[ìíîï]', 'i', text)
    text = re.sub(r'[òóôõö]', 'o', text)
    text = re.sub(r'[ùúûü]', 'u', text)
    text = re.sub(r'[ç]', 'c', text)
    text = re.sub(r'[^a-z0-9]+', '-', text)
    return text.strip('-')

def sql_escape(text: str) -> str:
    """Escape text for SQL (replace ' with '')."""
    if not text:
        return ''
    return text.replace("'", "''")

def generate_sql_for_course(course_path: Path, curriculum: Dict) -> str:
    """Generate SQL for a single course."""
    course_slug = course_path.name

    # Try to get title from multiple locations
    course_title = (
        curriculum.get('title') or
        curriculum.get('course', {}).get('title') or
        course_slug
    )

    # Try to get description from multiple locations
    course_desc = (
        curriculum.get('description') or
        curriculum.get('course', {}).get('description') or
        curriculum.get('metadata', {}).get('description') or
        ''
    )

    professor_info = curriculum.get('professor', {})

    prof_slug = slugify(professor_info.get('name', 'unknown'))
    prof_name = sql_escape(professor_info.get('name', 'Unknown'))
    prof_bio = sql_escape(professor_info.get('bio', ''))

    course_title = sql_escape(course_title)
    course_desc = sql_escape(course_desc)

    modules = curriculum.get('modules', [])

    sql = f"""
-- ═══════════════════════════════════════════════════════════════════
-- Course: {course_title}
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  v_professor_id UUID;
  v_project_id UUID;
  v_outline_id UUID;
  v_module_id UUID;
  v_lesson_id UUID;
BEGIN

  -- Get or create professor
  SELECT id INTO v_professor_id FROM minds WHERE slug = '{prof_slug}';

  IF v_professor_id IS NULL THEN
    INSERT INTO minds (slug, display_name, short_bio)
    VALUES ('{prof_slug}', '{prof_name}', '{prof_bio}')
    RETURNING id INTO v_professor_id;
  END IF;

  -- Create or update project
  INSERT INTO content_projects (slug, name, description, status)
  VALUES ('{course_slug}', '{course_title}', '{course_desc}', 'completed')
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO v_project_id;

  -- Create outline
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, sequence_order, status, metadata
  )
  VALUES (
    '{course_slug}-outline',
    '{course_title} - Outline',
    'course_outline',
    true,
    '# {course_title}

{course_desc}',
    v_project_id,
    1,
    'published',
    '{{"total_modules": {len(modules)}}}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_outline_id;

  -- Link professor
  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_outline_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

"""

    # Generate modules and lessons
    for mod_idx, module in enumerate(modules, 1):
        mod_title = sql_escape(module.get('title', f'Módulo {mod_idx}'))
        mod_desc = sql_escape(module.get('description', ''))
        lessons = module.get('lessons', [])

        sql += f"""
  -- Module {mod_idx}
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status, metadata
  )
  VALUES (
    '{course_slug}-modulo-{mod_idx}',
    '{mod_title}',
    'course_module',
    true,
    '# {mod_title}

{mod_desc}',
    v_project_id,
    v_outline_id,
    {mod_idx},
    'published',
    '{{"lessons_count": {len(lessons)}}}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_module_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_module_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

"""

        # Generate lessons
        for lesson_idx, lesson in enumerate(lessons, 1):
            lesson_title = sql_escape(lesson.get('title', f'Lição {mod_idx}.{lesson_idx}'))
            lesson_content = sql_escape(lesson.get('content', lesson.get('description', '')))
            duration = lesson.get('duration_minutes', 15)

            sql += f"""  -- Lesson {mod_idx}.{lesson_idx}
  INSERT INTO contents (
    slug, title, content_type, ai_generated, content,
    project_id, parent_content_id, sequence_order, status,
    fidelity_score, metadata
  )
  VALUES (
    '{course_slug}-licao-{mod_idx}-{lesson_idx}',
    '{lesson_title}',
    'course_lesson',
    true,
    '# {lesson_title}

{lesson_content}',
    v_project_id,
    v_module_id,
    {lesson_idx},
    'published',
    0.90,
    '{{"duration_minutes": {duration}}}'::jsonb
  )
  ON CONFLICT (slug) DO UPDATE SET title = EXCLUDED.title
  RETURNING id INTO v_lesson_id;

  INSERT INTO content_minds (content_id, mind_id, role)
  VALUES (v_lesson_id, v_professor_id, 'creator')
  ON CONFLICT DO NOTHING;

"""

    sql += "END $$;\n\n"
    return sql

def main():
    """Main migration script - generates SQL file."""
    courses_dir = Path("outputs/courses")

    # Get all course directories
    course_dirs = [
        d for d in courses_dir.iterdir()
        if d.is_dir()
        and d.name not in ['dominando-obsidian', 'no-migration']
        and (d / 'curriculum.yaml').exists()
    ]

    print(f"🚀 Generating SQL for {len(course_dirs)} courses...")

    sql_output = "BEGIN;\n\n"

    for course_dir in sorted(course_dirs):
        curriculum = load_curriculum(course_dir)
        if curriculum:
            course_title = curriculum.get('course', {}).get('title', course_dir.name)
            print(f"  ✓ {course_title}")
            sql_output += generate_sql_for_course(course_dir, curriculum)
        else:
            print(f"  ⚠️  Skipping {course_dir.name}: No curriculum.yaml")

    sql_output += "COMMIT;\n"

    # Write SQL to file
    output_file = Path("expansion-packs/creator-os/database/MIGRATE_ALL_COURSES.sql")
    output_file.write_text(sql_output, encoding='utf-8')

    print(f"\n✅ SQL generated: {output_file}")
    print(f"\nTo execute:")
    print(f"  source .env")
    print(f"  psql \"$SUPABASE_DB_URL\" -f {output_file}")

if __name__ == "__main__":
    main()
