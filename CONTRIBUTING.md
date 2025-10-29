# Contributing to Mente Lendária

Thank you for your interest in contributing to Mente Lendária! This document provides guidelines and instructions for contributing to the project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Project Structure](#project-structure)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Documentation](#documentation)

---

## Code of Conduct

This project adheres to a professional and respectful development environment. Please:

- Be respectful and inclusive in all interactions
- Focus on constructive feedback
- Welcome newcomers and help them get started
- Prioritize technical accuracy and objective discussion

---

## Getting Started

### Prerequisites

- **Python 3.11+**
- **Node.js 18+**
- **Git**
- **GitHub CLI** (optional but recommended)

### Initial Setup

1. **Fork and clone the repository:**
   ```bash
   gh repo fork alan/mente_lendaria --clone
   cd mente_lendaria
   ```

2. **Set up Python environment:**
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r expansion-packs/mmos/requirements.txt
   pip install -r expansion-packs/creator-os/requirements.txt
   ```

3. **Install Node dependencies:**
   ```bash
   npm install
   ```

4. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your API keys (see .env.example for details)
   ```

5. **Verify setup:**
   ```bash
   npm test
   pytest
   ```

---

## Development Workflow

### Story-Driven Development

This project follows a **story-driven development** approach:

1. **Find a story** in `docs/stories/` or create a new one
2. **Update progress** by marking checkboxes: `[ ]` → `[x]`
3. **Track changes** in the File List section of the story
4. **Follow acceptance criteria** exactly as specified

### Branch Strategy

- `main` - Production-ready code
- `feature/{story-id}-{description}` - Feature branches
- `fix/{issue-number}-{description}` - Bug fixes

Example:
```bash
git checkout -b feature/2.1-ide-detection
```

### Commit Conventions

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]
[optional footer]
```

**Types:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `chore:` - Maintenance tasks
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `perf:` - Performance improvements

**Examples:**
```bash
git commit -m "feat(mmos): add cognitive layer analysis"
git commit -m "fix(creator-os): resolve curriculum generation bug"
git commit -m "docs: update MMOS workflow guide"
```

---

## Project Structure

### CRITICAL: Framework vs. Project Separation

```
.aios-core/          # ❌ READ-ONLY - Never modify!
expansion-packs/     # ✅ Your code goes here
docs/                # ✅ Documentation
outputs/             # ⚠️  Generated artifacts (not versioned)
```

**Rules:**
- **NEVER** modify `.aios-core/` - it's the AIOS framework base
- **ALWAYS** put project code in `expansion-packs/`
- **ALWAYS** put documentation in `docs/`
- **NEVER** commit `outputs/` - it's for generated artifacts

### Expansion Packs

Each expansion pack follows this structure:

```
expansion-packs/{pack-name}/
├── agents/          # Agent definitions (YAML)
├── tasks/           # Task workflows (Markdown)
├── templates/       # Document templates
├── checklists/      # Validation checklists
├── workflows/       # Multi-step workflows
├── lib/             # Core logic (Python/JS)
├── scripts/         # Executable scripts
└── README.md        # Pack documentation
```

### Documentation Structure

```
docs/
├── prd/             # Product requirements
├── methodology/     # Frameworks and methodologies
├── guides/          # User/developer guides
├── architecture/    # System architecture
├── stories/         # Development stories
├── logs/            # Execution logs (versioned!)
└── mmos/            # MMOS-specific docs
```

---

## Coding Standards

### Python

- **Style Guide:** PEP 8
- **Type Hints:** Required for public APIs
- **Docstrings:** Google style for modules, classes, and functions

Example:
```python
def analyze_cognitive_layer(data: dict[str, Any]) -> CognitiveAnalysis:
    """Analyze cognitive patterns from source data.

    Args:
        data: Dictionary containing source materials and metadata

    Returns:
        CognitiveAnalysis object with extracted patterns

    Raises:
        ValueError: If data is malformed or missing required fields
    """
    # Implementation
```

### JavaScript/TypeScript

- **Style Guide:** StandardJS
- **Type Safety:** Use TypeScript where possible
- **Error Handling:** Always handle errors explicitly

Example:
```typescript
async function syncExpansionPack(packName: string): Promise<SyncResult> {
  try {
    const files = await readPackFiles(packName)
    return await syncToClaudeCommands(files)
  } catch (error) {
    console.error(`Sync failed for ${packName}:`, error)
    throw new Error(`Failed to sync ${packName}: ${error.message}`)
  }
}
```

### General Principles

1. **Keep functions focused** - Single responsibility principle
2. **Write self-documenting code** - Clear variable/function names
3. **Handle errors gracefully** - Never fail silently
4. **Add tests for all new features** - No exceptions
5. **Comment complex logic** - Explain the "why", not the "what"

---

## Testing

### Running Tests

```bash
# Python tests
pytest

# Python tests with coverage
pytest --cov=expansion-packs --cov-report=html

# JavaScript tests
npm test

# JavaScript tests with coverage
npm run test:coverage

# Linting
npm run lint
```

### Writing Tests

**Python (pytest):**
```python
# expansion-packs/mmos/tests/test_analysis.py
def test_cognitive_layer_analysis():
    """Test cognitive layer extraction from sample data."""
    data = load_test_fixture("sample_transcript.json")
    result = analyze_cognitive_layer(data)

    assert result.patterns is not None
    assert len(result.patterns) > 0
    assert result.confidence > 0.8
```

**JavaScript (Jest):**
```javascript
// expansion-packs/creator-os/tests/curriculum.test.js
describe('Curriculum Generator', () => {
  test('generates valid curriculum structure', async () => {
    const course = await generateCurriculum(testData)

    expect(course.modules).toBeDefined()
    expect(course.modules.length).toBeGreaterThan(0)
    expect(course.metadata.duration).toBeGreaterThan(0)
  })
})
```

### Test Coverage Requirements

- **Critical code (lib/):** 80%+ coverage required
- **Scripts:** 60%+ coverage recommended
- **New features:** Must include tests

---

## Submitting Changes

### Pull Request Process

1. **Create feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes and commit:**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

3. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create Pull Request:**
   ```bash
   gh pr create --title "feat: your feature" --body "Description of changes"
   ```

### PR Checklist

Before submitting, ensure:

- [ ] All tests pass (`npm test && pytest`)
- [ ] Code follows style guidelines (`npm run lint`)
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated (under `[Unreleased]`)
- [ ] Commit messages follow conventional commits format
- [ ] No merge conflicts with `main`
- [ ] Story is updated (if applicable)

### PR Description Template

```markdown
## Summary
Brief description of changes

## Related Story/Issue
- Story: #123
- Fixes: #456

## Changes Made
- Added X feature
- Fixed Y bug
- Updated Z documentation

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Manual testing completed

## Screenshots (if applicable)
[Add screenshots here]

## Checklist
- [ ] Tests pass
- [ ] Documentation updated
- [ ] CHANGELOG updated
```

---

## Documentation

### When to Update Docs

Always update documentation when:

- Adding new features or expansion packs
- Changing APIs or interfaces
- Modifying workflows or processes
- Fixing bugs that affect usage

### Documentation Standards

1. **Use clear, concise language**
2. **Include code examples** for technical concepts
3. **Add diagrams** for complex architectures
4. **Keep docs synchronized** with code changes
5. **Version large changes** in docs/logs/

### Documentation Locations

| Content Type | Location |
|--------------|----------|
| API documentation | Inline docstrings + `docs/architecture/` |
| User guides | `docs/guides/` |
| Architecture docs | `docs/architecture/` |
| Process docs | `docs/methodology/` |
| Execution logs | `docs/logs/` |

---

## Questions or Issues?

- **Technical questions:** Open an issue with the `question` label
- **Bug reports:** Use the bug report template
- **Feature requests:** Use the feature request template
- **Security issues:** Email maintainers directly (see SECURITY.md)

---

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

## Thank You! 🙏

Your contributions help make Mente Lendária better for everyone. We appreciate your time and effort!

**Happy coding!** 🚀
