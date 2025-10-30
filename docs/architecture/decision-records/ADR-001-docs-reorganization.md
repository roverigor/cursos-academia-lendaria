# ADR-001: Docs Reorganization

**Status:** Accepted
**Date:** 2025-10-28

---

## Context

The project's documentation, primarily located within the `docs/mmos/docs` directory, suffered from several structural problems:

1.  **Confusing Nesting:** The path `docs/mmos/docs` was semantically confusing.
2.  **Empty Root `docs`:** The root `docs` directory was nearly empty, with most documentation living under the `mmos` subdirectory.
3.  **Committed Artifacts:** The repository contained committed database files and logs, which should be treated as artifacts and not versioned.
4.  **Duplicated `stories` directories:** It was unclear if `docs/stories` and `docs/mmos/stories` served different purposes.

These issues made navigation difficult, hindered onboarding, and increased repository size unnecessarily.

## Decision

To address these issues, a major reorganization of the `docs` directory was undertaken. The core of the decision is to flatten the structure and separate documentation from generated artifacts.

The new structure is as follows:

```
docs/
├── architecture/
├── guides/
├── methodology/
├── prd/
├── stories/
└── mmos/
    ├── architecture/
    ├── database/
    ├── design/
    ├── epics/
    ├── reports/
    ├── taxonomy/
    ├── validations/
    └── workflows/
```

And for generated artifacts:

```
outputs/
├── courses/
├── minds/
├── database/
└── logs/
```

## Rationale

This new structure provides several benefits:

*   **Improved Navigation:** A flatter hierarchy and clear categorization make it easier to find documents.
*   **Better Cohesion:** Project-wide documentation now has a logical home at the root of `docs`, with MMOS-specific documentation correctly placed within `docs/mmos`.
*   **Reduced Repository Size:** Moving generated artifacts like databases and logs to `outputs/` and adding them to `.gitignore` reduces the size of the repository.
*   **Easier Onboarding:** The new structure is more intuitive for new developers.

## Consequences

*   **Positive:**
    *   Clearer, more intuitive documentation structure.
    *   Reduced repository size.
    *   Easier for developers to find what they need.
*   **Negative:**
    *   Requires a one-time effort to update all existing links and references to the old paths.
    *   Potential for broken links if the migration is not handled carefully.

## Implementation Plan

The migration will be performed in several phases:

1.  **Extract Documentation:** Move documents from `docs/mmos/docs` to the new top-level categories (`prd`, `methodology`, `guides`, etc.).
2.  **Move Artifacts:** Move the SQLite database and logs to the `outputs` directory and update `.gitignore`.
3.  **Create Indexes:** Create `README.md` files in the root of `docs` and `docs/mmos` to serve as indexes.
4.  **Update References:** Run scripts to update all hardcoded paths in the codebase and documentation.
5.  **Validation:** Thoroughly test for broken links and ensure all scripts and tools function correctly.
6.  **Commit:** Commit the changes as a single, atomic refactoring.

This ADR documents the decision to proceed with this reorganization.
