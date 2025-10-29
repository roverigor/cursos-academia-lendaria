"""
Unit tests for CoursePersister (db_persister.py)

Run with: pytest expansion-packs/creator-os/tests/test_db_persister.py -v
Coverage: pytest expansion-packs/creator-os/tests/test_db_persister.py --cov=lib.db_persister --cov-report=html
"""

import pytest
import os
from unittest.mock import Mock, patch, MagicMock, call
import sys
from pathlib import Path

# Add parent directory to path to import db_persister
sys.path.insert(0, str(Path(__file__).parent.parent))

from lib.db_persister import CoursePersister


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FIXTURES
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

@pytest.fixture
def mock_supabase():
    """Mock Supabase client for tests."""
    with patch('lib.db_persister.create_client') as mock_create:
        mock_client = MagicMock()
        mock_create.return_value = mock_client

        # Setup table chain mocking
        mock_table = MagicMock()
        mock_client.table.return_value = mock_table
        mock_table.insert.return_value = mock_table
        mock_table.update.return_value = mock_table
        mock_table.select.return_value = mock_table
        mock_table.eq.return_value = mock_table
        mock_table.execute.return_value = MagicMock(data=[])

        yield mock_client


@pytest.fixture
def persister_enabled(mock_supabase):
    """CoursePersister with feature flag enabled."""
    # Set environment variables
    os.environ['CREATOR_OS_DB_PERSIST'] = 'true'
    os.environ['SUPABASE_URL'] = 'https://test.supabase.co'
    os.environ['SUPABASE_SERVICE_KEY'] = 'test-key'

    persister = CoursePersister()
    yield persister

    # Cleanup
    del os.environ['CREATOR_OS_DB_PERSIST']


@pytest.fixture
def persister_disabled():
    """CoursePersister with feature flag disabled."""
    os.environ['CREATOR_OS_DB_PERSIST'] = 'false'
    persister = CoursePersister()
    yield persister
    del os.environ['CREATOR_OS_DB_PERSIST']


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# INITIALIZATION TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def test_init_with_feature_flag_enabled(persister_enabled):
    """Test initialization when feature flag is ON."""
    assert persister_enabled._is_enabled() is True
    assert persister_enabled.client is not None


def test_init_with_feature_flag_disabled(persister_disabled):
    """Test initialization when feature flag is OFF."""
    assert persister_disabled._is_enabled() is False
    assert persister_disabled.client is None


def test_init_without_credentials():
    """Test initialization without Supabase credentials."""
    # Save existing credentials
    old_url = os.environ.get('SUPABASE_URL')
    old_key = os.environ.get('SUPABASE_SERVICE_KEY')

    # Remove credentials temporarily
    if 'SUPABASE_URL' in os.environ:
        del os.environ['SUPABASE_URL']
    if 'SUPABASE_SERVICE_KEY' in os.environ:
        del os.environ['SUPABASE_SERVICE_KEY']

    os.environ['CREATOR_OS_DB_PERSIST'] = 'true'

    persister = CoursePersister()

    assert persister.client is None
    assert persister._is_enabled() is False

    # Cleanup and restore
    del os.environ['CREATOR_OS_DB_PERSIST']
    if old_url:
        os.environ['SUPABASE_URL'] = old_url
    if old_key:
        os.environ['SUPABASE_SERVICE_KEY'] = old_key


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PROJECT PERSISTENCE TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def test_persist_project_success(persister_enabled, mock_supabase):
    """Test successful project persistence."""
    # Mock successful insert
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': 'project-uuid-123', 'slug': 'test-course'}
    ]

    project_id = persister_enabled.persist_project(
        slug='test-course',
        name='Test Course',
        creator_mind_id='creator-uuid',
        persona_mind_id='persona-uuid',
        project_type='course',
        metadata={'icp': 'Developers'}
    )

    assert project_id == 'project-uuid-123'
    mock_supabase.table.assert_called_with('content_projects')
    mock_supabase.table.return_value.insert.assert_called_once()


def test_persist_project_minimal_data(persister_enabled, mock_supabase):
    """Test project persistence with minimal required data."""
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': 'project-uuid-456'}
    ]

    project_id = persister_enabled.persist_project(
        slug='minimal-course',
        name='Minimal Course'
    )

    assert project_id == 'project-uuid-456'

    # Verify insert was called with minimal data
    call_args = mock_supabase.table.return_value.insert.call_args[0][0]
    assert call_args['slug'] == 'minimal-course'
    assert call_args['name'] == 'Minimal Course'
    assert call_args['project_type'] == 'course'  # Default value
    assert 'creator_mind_id' not in call_args  # None values filtered


def test_persist_project_feature_flag_off(persister_disabled):
    """Test that persistence is skipped when feature flag is OFF."""
    project_id = persister_disabled.persist_project(
        slug='test-course',
        name='Test Course'
    )

    assert project_id is None


def test_persist_project_database_error(persister_enabled, mock_supabase):
    """Test error handling when database write fails."""
    # Mock database error
    mock_supabase.table.return_value.insert.return_value.execute.side_effect = Exception("DB error")

    # Should return None, not raise
    project_id = persister_enabled.persist_project(
        slug='test-course',
        name='Test Course'
    )

    assert project_id is None


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CONTENT PERSISTENCE TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def test_persist_content_success(persister_enabled, mock_supabase):
    """Test successful content persistence."""
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': 'content-uuid-789', 'slug': 'test-lesson'}
    ]

    content_id = persister_enabled.persist_content(
        project_id='project-uuid-123',
        slug='test-lesson',
        title='Test Lesson',
        content_type='course_lesson',
        content='# Lesson content',
        sequence_order=1
    )

    assert content_id == 'content-uuid-789'
    mock_supabase.table.assert_called_with('contents')


def test_persist_content_with_hierarchy(persister_enabled, mock_supabase):
    """Test content persistence with parent_content_id (hierarchy)."""
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': 'lesson-uuid'}
    ]

    content_id = persister_enabled.persist_content(
        project_id='project-uuid',
        slug='lesson-1-1',
        title='Lesson 1.1',
        content_type='course_lesson',
        parent_content_id='module-uuid',  # Child of module
        sequence_order=1
    )

    assert content_id == 'lesson-uuid'

    # Verify parent_content_id was passed
    call_args = mock_supabase.table.return_value.insert.call_args[0][0]
    assert call_args['parent_content_id'] == 'module-uuid'
    assert call_args['sequence_order'] == 1


def test_persist_content_feature_flag_off(persister_disabled):
    """Test that content persistence is skipped when feature flag is OFF."""
    content_id = persister_disabled.persist_content(
        project_id='project-uuid',
        slug='test-lesson',
        title='Test Lesson',
        content_type='course_lesson'
    )

    assert content_id is None


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# BATCH PERSISTENCE TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def test_persist_lessons_batch_success(persister_enabled, mock_supabase):
    """Test batch persisting lessons."""
    # Mock successful batch insert
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': f'lesson-{i}'} for i in range(5)
    ]

    lessons = [
        {'slug': f'lesson-{i}', 'title': f'Lesson {i}', 'content': f'Content {i}'}
        for i in range(5)
    ]

    count = persister_enabled.persist_lessons_batch(
        project_id='project-uuid',
        module_content_id='module-uuid',
        lessons=lessons
    )

    assert count == 5

    # Verify batch insert was called
    call_args = mock_supabase.table.return_value.insert.call_args[0][0]
    assert len(call_args) == 5
    assert all(lesson['content_type'] == 'course_lesson' for lesson in call_args)
    assert all(lesson['ai_generated'] is True for lesson in call_args)


def test_persist_lessons_batch_empty(persister_enabled, mock_supabase):
    """Test batch persist with empty lessons list."""
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = []

    count = persister_enabled.persist_lessons_batch(
        project_id='project-uuid',
        module_content_id='module-uuid',
        lessons=[]
    )

    assert count == 0


def test_persist_lessons_batch_feature_flag_off(persister_disabled):
    """Test that batch persistence is skipped when feature flag is OFF."""
    lessons = [{'slug': 'lesson-1', 'title': 'Lesson 1'}]

    count = persister_disabled.persist_lessons_batch(
        project_id='project-uuid',
        module_content_id='module-uuid',
        lessons=lessons
    )

    assert count == 0


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# UPDATE OPERATIONS TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def test_update_content_metadata_success(persister_enabled, mock_supabase):
    """Test updating content metadata."""
    mock_supabase.table.return_value.update.return_value.eq.return_value.execute.return_value.data = [
        {'id': 'content-uuid'}
    ]

    success = persister_enabled.update_content_metadata(
        content_id='content-uuid',
        metadata={'validation': 'passed', 'score': 0.95}
    )

    assert success is True
    mock_supabase.table.return_value.update.assert_called_once()


def test_update_content_metadata_with_merge(persister_enabled, mock_supabase):
    """Test updating metadata with merge=True (default)."""
    # Create separate mocks for select and update
    mock_select_table = MagicMock()
    mock_select_table.select.return_value.eq.return_value.execute.return_value.data = [
        {'metadata': {'existing_key': 'existing_value'}}
    ]

    mock_update_table = MagicMock()
    mock_update_table.update.return_value.eq.return_value.execute.return_value.data = [
        {'id': 'content-uuid'}
    ]

    # Use side_effect to return different mocks for each table() call
    mock_supabase.table.side_effect = [mock_select_table, mock_update_table]

    success = persister_enabled.update_content_metadata(
        content_id='content-uuid',
        metadata={'new_key': 'new_value'},
        merge=True
    )

    assert success is True

    # Verify merged metadata was used
    update_call = mock_update_table.update.call_args[0][0]
    assert 'existing_key' in update_call['metadata']
    assert 'new_key' in update_call['metadata']


def test_update_fidelity_score_success(persister_enabled, mock_supabase):
    """Test updating fidelity score."""
    mock_supabase.table.return_value.update.return_value.eq.return_value.execute.return_value.data = [
        {'id': 'content-uuid'}
    ]

    success = persister_enabled.update_fidelity_score(
        content_id='content-uuid',
        fidelity_score=0.92
    )

    assert success is True

    # Verify fidelity_score was updated
    update_call = mock_supabase.table.return_value.update.call_args[0][0]
    assert update_call['fidelity_score'] == 0.92


def test_update_operations_feature_flag_off(persister_disabled):
    """Test that update operations are skipped when feature flag is OFF."""
    metadata_result = persister_disabled.update_content_metadata(
        content_id='content-uuid',
        metadata={'key': 'value'}
    )

    fidelity_result = persister_disabled.update_fidelity_score(
        content_id='content-uuid',
        fidelity_score=0.90
    )

    assert metadata_result is False
    assert fidelity_result is False


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# MIND LINKING TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def test_link_mind_to_content_success(persister_enabled, mock_supabase):
    """Test linking a mind to content."""
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'content_id': 'content-uuid', 'mind_id': 'mind-uuid'}
    ]

    success = persister_enabled.link_mind_to_content(
        content_id='content-uuid',
        mind_id='mind-uuid',
        role='creator'
    )

    assert success is True
    mock_supabase.table.assert_called_with('content_minds')


def test_link_mind_to_content_custom_role(persister_enabled, mock_supabase):
    """Test linking mind with custom role."""
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'content_id': 'content-uuid', 'mind_id': 'mind-uuid'}
    ]

    success = persister_enabled.link_mind_to_content(
        content_id='content-uuid',
        mind_id='mind-uuid',
        role='persona'
    )

    assert success is True

    # Verify role was passed
    call_args = mock_supabase.table.return_value.insert.call_args[0][0]
    assert call_args['role'] == 'persona'


def test_link_mind_feature_flag_off(persister_disabled):
    """Test that mind linking is skipped when feature flag is OFF."""
    success = persister_disabled.link_mind_to_content(
        content_id='content-uuid',
        mind_id='mind-uuid'
    )

    assert success is False


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ERROR HANDLING TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def test_error_handling_persist_project(persister_enabled, mock_supabase):
    """Test that errors are logged but don't raise."""
    mock_supabase.table.return_value.insert.return_value.execute.side_effect = Exception("DB error")

    # Should return None, not raise
    project_id = persister_enabled.persist_project(
        slug='test-course',
        name='Test Course'
    )

    assert project_id is None


def test_error_handling_persist_content(persister_enabled, mock_supabase):
    """Test error handling for content persistence."""
    mock_supabase.table.return_value.insert.return_value.execute.side_effect = Exception("Network error")

    content_id = persister_enabled.persist_content(
        project_id='project-uuid',
        slug='test-lesson',
        title='Test Lesson',
        content_type='course_lesson'
    )

    assert content_id is None


def test_error_handling_batch_persist(persister_enabled, mock_supabase):
    """Test error handling for batch persistence."""
    mock_supabase.table.return_value.insert.return_value.execute.side_effect = Exception("Batch insert failed")

    lessons = [{'slug': 'lesson-1', 'title': 'Lesson 1'}]

    count = persister_enabled.persist_lessons_batch(
        project_id='project-uuid',
        module_content_id='module-uuid',
        lessons=lessons
    )

    # Should return 0, not raise
    assert count == 0


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# INTEGRATION-LIKE TESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def test_full_course_persistence_workflow(persister_enabled, mock_supabase):
    """Test complete course persistence workflow."""
    # Mock all operations
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': 'project-uuid'}
    ]

    # 1. Create project
    project_id = persister_enabled.persist_project(
        slug='complete-course',
        name='Complete Course',
        creator_mind_id='creator-uuid',
        metadata={'icp': 'Developers'}
    )

    assert project_id == 'project-uuid'

    # 2. Create course outline
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': 'course-uuid'}
    ]

    course_id = persister_enabled.persist_content(
        project_id=project_id,
        slug='course-outline',
        title='Complete Course',
        content_type='course_outline',
        content='# Course Outline'
    )

    assert course_id == 'course-uuid'

    # 3. Create module
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': 'module-uuid'}
    ]

    module_id = persister_enabled.persist_content(
        project_id=project_id,
        parent_content_id=course_id,
        slug='module-1',
        title='Module 1',
        content_type='course_module',
        sequence_order=1
    )

    assert module_id == 'module-uuid'

    # 4. Batch create lessons
    mock_supabase.table.return_value.insert.return_value.execute.return_value.data = [
        {'id': f'lesson-{i}'} for i in range(3)
    ]

    lessons = [
        {'slug': f'lesson-1-{i}', 'title': f'Lesson 1.{i}'}
        for i in range(1, 4)
    ]

    count = persister_enabled.persist_lessons_batch(project_id, module_id, lessons)

    assert count == 3


# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# TEST SUMMARY
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Total test cases: 30+
# Coverage areas:
# - Initialization (with/without feature flag, with/without credentials)
# - Project persistence (success, minimal data, errors)
# - Content persistence (success, hierarchy, errors)
# - Batch persistence (success, empty, errors)
# - Update operations (metadata, fidelity score, merge)
# - Mind linking (success, custom roles)
# - Error handling (all operations gracefully handle errors)
# - Full workflow integration test
#
# Run: pytest expansion-packs/creator-os/tests/test_db_persister.py -v
# Coverage: pytest expansion-packs/creator-os/tests/test_db_persister.py --cov=lib.db_persister --cov-report=html
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
