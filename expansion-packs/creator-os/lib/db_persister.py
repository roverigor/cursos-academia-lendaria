"""
CreatorOS Database Persister

Handles all database writes for CreatorOS using existing Supabase schema.
Uses dual-write pattern: filesystem (primary) + database (secondary).

Tables used:
- content_projects: Course/book projects
- contents: All content (courses, modules, lessons) with hierarchy
- content_minds: Mind attribution (creator/persona)
- audience_profiles: Target audience definitions

Author: CreatorOS Team
Created: 2025-10-28
"""

import os
import logging
from typing import Dict, List, Optional, Any
from datetime import datetime, UTC
from supabase import create_client, Client
from contextlib import contextmanager

logger = logging.getLogger(__name__)


class CoursePersister:
    """
    Handles persistence of CreatorOS outputs to Supabase.

    Usage:
        persister = CoursePersister()
        project_id = persister.persist_project(slug='my-course', ...)
        content_id = persister.persist_content(
            project_id=project_id,
            content_type='course_outline',
            ...
        )
    """

    def __init__(self):
        """Initialize Supabase client."""
        # Check feature flag dynamically (for testing support)
        feature_flag_enabled = os.getenv('CREATOR_OS_DB_PERSIST', 'false').lower() == 'true'

        if not feature_flag_enabled:
            logger.info("Database persistence DISABLED (feature flag off)")
            self.client = None
            return

        supabase_url = os.getenv('SUPABASE_URL')
        supabase_key = os.getenv('SUPABASE_SERVICE_KEY')  # Use service key for writes

        if not supabase_url or not supabase_key:
            logger.warning(
                "SUPABASE_URL or SUPABASE_SERVICE_KEY not set. "
                "Database persistence will be skipped."
            )
            self.client = None
        else:
            self.client = create_client(supabase_url, supabase_key)
            logger.info("Database persister initialized")

    def _is_enabled(self) -> bool:
        """Check if database persistence is enabled."""
        feature_flag_enabled = os.getenv('CREATOR_OS_DB_PERSIST', 'false').lower() == 'true'
        return feature_flag_enabled and self.client is not None

    @contextmanager
    def _safe_write(self):
        """
        Context manager for safe database writes.
        Logs errors but doesn't raise (filesystem is source of truth).
        """
        try:
            yield
        except Exception as e:
            logger.error(f"Database write failed: {e}", exc_info=True)
            # Don't raise - filesystem write is primary

    def persist_project(
        self,
        slug: str,
        name: str,
        creator_mind_id: Optional[str] = None,
        persona_mind_id: Optional[str] = None,
        project_type: str = 'course',
        description: Optional[str] = None,
        metadata: Optional[Dict[str, Any]] = None,
        **kwargs
    ) -> Optional[str]:
        """
        Persist content project to database.

        Args:
            slug: Unique project slug
            name: Project name/title
            creator_mind_id: UUID of creating mind
            persona_mind_id: UUID of persona mind (voice to emulate)
            project_type: 'course', 'book', 'blog_series', etc.
            description: Optional project description
            metadata: Optional metadata dict (curriculum, ICP, etc.)

        Returns:
            Project UUID if successful, None if failed/disabled
        """
        if not self._is_enabled():
            return None

        with self._safe_write():
            data = {
                'slug': slug,
                'name': name,
                'project_type': project_type,
                'creator_mind_id': creator_mind_id,
                'persona_mind_id': persona_mind_id,
                'description': description,
                'project_metadata': metadata or {},
                'status': 'in_progress'
            }

            # Filter None values
            data = {k: v for k, v in data.items() if v is not None}

            result = self.client.table('content_projects').insert(data).execute()

            if result.data and len(result.data) > 0:
                project_id = result.data[0]['id']
                logger.info(f"✓ Persisted project: {slug} (id={project_id})")
                return project_id
            else:
                logger.warning(f"✗ Failed to persist project: {slug}")
                return None

    def persist_content(
        self,
        project_id: str,
        slug: str,
        title: str,
        content_type: str,
        content: Optional[str] = None,
        parent_content_id: Optional[str] = None,
        sequence_order: Optional[int] = None,
        metadata: Optional[Dict[str, Any]] = None,
        fidelity_score: Optional[float] = None,
        generation_execution_id: Optional[str] = None,
        **kwargs
    ) -> Optional[str]:
        """
        Persist content piece to database (course, module, lesson, etc.).

        Supports hierarchical content via parent_content_id:
        - course_outline (parent=None)
          └ course_module (parent=course_id, order=1)
            └ course_lesson (parent=module_id, order=1)

        Args:
            project_id: UUID of parent project
            slug: Unique content slug
            title: Content title
            content_type: 'course_outline', 'course_module', 'course_lesson', etc.
            content: Actual content (markdown, HTML, etc.)
            parent_content_id: UUID of parent content (for hierarchy)
            sequence_order: Order within parent (1, 2, 3...)
            metadata: Optional metadata dict
            fidelity_score: Voice fidelity score (0-1)
            generation_execution_id: UUID of job that generated this

        Returns:
            Content UUID if successful, None if failed/disabled
        """
        if not self._is_enabled():
            return None

        with self._safe_write():
            data = {
                'project_id': project_id,
                'slug': slug,
                'title': title,
                'content_type': content_type,
                'content': content,
                'parent_content_id': parent_content_id,
                'sequence_order': sequence_order,
                'metadata': metadata or {},
                'ai_generated': True,
                'fidelity_score': fidelity_score,
                'generation_execution_id': generation_execution_id,
                'status': 'draft'
            }

            # Filter None values
            data = {k: v for k, v in data.items() if v is not None}

            result = self.client.table('contents').insert(data).execute()

            if result.data and len(result.data) > 0:
                content_id = result.data[0]['id']
                logger.info(f"✓ Persisted content: {slug} ({content_type}, id={content_id})")
                return content_id
            else:
                logger.warning(f"✗ Failed to persist content: {slug}")
                return None

    def persist_lessons_batch(
        self,
        project_id: str,
        module_content_id: str,
        lessons: List[Dict[str, Any]]
    ) -> int:
        """
        Batch persist multiple lessons (more efficient than one-by-one).

        Args:
            project_id: UUID of parent project
            module_content_id: UUID of parent module
            lessons: List of lesson dicts with keys:
                - slug (required)
                - title (required)
                - content (optional)
                - sequence_order (optional)
                - metadata (optional)
                - fidelity_score (optional)

        Returns:
            Number of lessons successfully persisted
        """
        if not self._is_enabled():
            return 0

        try:
            lesson_records = []
            for lesson in lessons:
                record = {
                    'project_id': project_id,
                    'parent_content_id': module_content_id,
                    'content_type': 'course_lesson',
                    'ai_generated': True,
                    'status': 'draft',
                    **lesson  # Spread lesson dict
                }
                # Ensure metadata is dict
                if 'metadata' not in record:
                    record['metadata'] = {}
                lesson_records.append(record)

            result = self.client.table('contents').insert(lesson_records).execute()

            count = len(result.data) if result.data else 0
            logger.info(f"✓ Batch persisted {count}/{len(lessons)} lessons")
            return count
        except Exception as e:
            logger.error(f"Database write failed: {e}", exc_info=True)
            return 0

    def update_content_metadata(
        self,
        content_id: str,
        metadata: Dict[str, Any],
        merge: bool = True
    ) -> bool:
        """
        Update content metadata (curriculum, ICP, validation results, etc.).

        Args:
            content_id: UUID of content to update
            metadata: Metadata dict to save
            merge: If True, merge with existing metadata; if False, replace

        Returns:
            True if successful, False if failed/disabled
        """
        if not self._is_enabled():
            return False

        with self._safe_write():
            if merge:
                # Fetch existing metadata first
                existing = self.client.table('contents').select('metadata').eq('id', content_id).execute()
                if existing.data and len(existing.data) > 0:
                    current_metadata = existing.data[0].get('metadata', {})
                    metadata = {**current_metadata, **metadata}

            result = self.client.table('contents').update({
                'metadata': metadata,
                'updated_at': datetime.now(UTC).isoformat()
            }).eq('id', content_id).execute()

            success = result.data and len(result.data) > 0
            if success:
                logger.info(f"✓ Updated metadata for content: {content_id}")
            else:
                logger.warning(f"✗ Failed to update metadata for content: {content_id}")
            return success

    def update_fidelity_score(
        self,
        content_id: str,
        fidelity_score: float
    ) -> bool:
        """
        Update voice fidelity score after validation.

        Args:
            content_id: UUID of content to update
            fidelity_score: Score from 0.0 to 1.0

        Returns:
            True if successful, False if failed/disabled
        """
        if not self._is_enabled():
            return False

        with self._safe_write():
            result = self.client.table('contents').update({
                'fidelity_score': fidelity_score,
                'updated_at': datetime.now(UTC).isoformat()
            }).eq('id', content_id).execute()

            success = result.data and len(result.data) > 0
            if success:
                logger.info(f"✓ Updated fidelity score: {content_id} = {fidelity_score}")
            else:
                logger.warning(f"✗ Failed to update fidelity score: {content_id}")
            return success

    def link_mind_to_content(
        self,
        content_id: str,
        mind_id: str,
        role: str = 'creator'
    ) -> bool:
        """
        Link a mind to content (creator, author, persona, etc.).

        Args:
            content_id: UUID of content
            mind_id: UUID of mind
            role: Mind's role (creator, author, persona, etc.)

        Returns:
            True if successful, False if failed/disabled
        """
        if not self._is_enabled():
            return False

        with self._safe_write():
            result = self.client.table('content_minds').insert({
                'content_id': content_id,
                'mind_id': mind_id,
                'role': role
            }).execute()

            success = result.data and len(result.data) > 0
            if success:
                logger.info(f"✓ Linked mind {mind_id} to content {content_id} as {role}")
            else:
                logger.warning(f"✗ Failed to link mind to content")
            return success


# Example usage
if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)

    persister = CoursePersister()

    # Create project
    project_id = persister.persist_project(
        slug='my-test-course',
        name='My Test Course',
        creator_mind_id='some-uuid',
        persona_mind_id='some-other-uuid',
        project_type='course',
        metadata={'icp': 'Developers learning Python'}
    )

    if project_id:
        # Create course outline
        course_id = persister.persist_content(
            project_id=project_id,
            slug='my-test-course-outline',
            title='My Test Course',
            content_type='course_outline',
            content='# Course Outline\n\n...',
            metadata={'total_modules': 3}
        )

        # Create module
        module_id = persister.persist_content(
            project_id=project_id,
            parent_content_id=course_id,
            slug='module-1-intro',
            title='Module 1: Introduction',
            content_type='course_module',
            sequence_order=1
        )

        # Batch create lessons
        lessons = [
            {
                'slug': f'lesson-1-{i}',
                'title': f'Lesson 1.{i}',
                'content': f'# Lesson content {i}',
                'sequence_order': i,
                'fidelity_score': 0.85
            }
            for i in range(1, 6)
        ]
        persister.persist_lessons_batch(project_id, module_id, lessons)
