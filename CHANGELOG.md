# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Python environment setup guide (`docs/guides/python-environment-setup.md`)
- Comprehensive MMOS Admin Dashboard architecture documentation
- Mind context pattern explanation for dashboard
- Automated IDE sync system for expansion packs
- Token estimation system for expansion pack operations
- Artifact analysis tooling for design system

### Changed
- Centralized expansion pack documentation structure
- Reorganized `docs/stories/` for better structure
- Improved course migration parser with better description handling
- Enhanced token estimation guidelines with command-specific estimates

### Fixed
- QA review concerns for IDE sync system
- Empty descriptions in CreatorOS course migrations
- Missing project data (audience, frameworks, metadata) in CreatorOS

## [3.0.0] - 2025-10-27

### AIOS Framework Integration (@oalanicolas)

#### Added
- AIOS Framework v4.31.0 integration (framework by @pedro)
- Configured core agent system infrastructure (22+ specialized agents)
- Integrated task execution engine
- Set up CLI infrastructure and tooling

#### Changed
- Major refactoring: Separated framework (`.aios-core/`) from project code (`expansion-packs/`)

### Expansion Packs & Business Logic (@oalanicolas)

#### Added
- CreatorOS expansion pack with database persistence
- MMOS expansion pack for cognitive clone creation
- InnerLens expansion pack for psychometric profiling
- Fragments expansion pack for data extraction
- Automatic sync between `expansion-packs/` and `.claude/commands/`
- Pre-commit hooks for IDE sync and versioned tables check
- Comprehensive documentation system (423+ markdown files)
- DNA Mental methodology framework
- Token estimation system for expansion pack operations
- Project governance (CHANGELOG, CONTRIBUTING)

#### Changed
- Outputs moved to dedicated `outputs/` directory (not versioned)
- Documentation reorganized into clear categories (`docs/architecture/`, `docs/methodology/`, etc.)
- Git history cleanup (removed large binaries)

#### Removed
- ETL data collector (partially deprecated, functionality moved to fragments)
- Legacy `node_modules/` from Git tracking
- Backup files (`.bak`) from repository

## [2.0.0] - 2025-09-XX

### Architecture (@oalanicolas)

#### Changed
- Migrated from monolithic to modular architecture
- Adopted expansion pack system

### Features (@oalanicolas)

#### Added
- Initial MMOS (Mind Mapper Operating System) implementation
- DNA Mental methodology framework
- Course generation capabilities (CreatorOS)
- Supabase integration for persistent storage

## [1.0.0] - 2025-08-XX

### Initial Release (@oalanicolas)

#### Added
- Initial project setup
- Basic agent system
- Core documentation structure

---

## Version History Summary

| Version | Release Date | Key Features |
|---------|-------------|--------------|
| 3.0.0   | 2025-10-27  | AIOS integration, expansion packs, full modularity |
| 2.0.0   | 2025-09-XX  | MMOS pipeline, CreatorOS, DNA Mental |
| 1.0.0   | 2025-08-XX  | Initial release, agent system |

---

## How to Update This Changelog

When making changes, add entries under `[Unreleased]` in the appropriate category:

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** for vulnerability fixes

When releasing a new version:
1. Move `[Unreleased]` items to new version section
2. Add release date
3. Create new empty `[Unreleased]` section
4. Update version in relevant files (`package.json`, etc.)

---

**Legend:**
- 🎉 Major milestone
- ⚡ Performance improvement
- 🔒 Security fix
- 📝 Documentation
- 🐛 Bug fix
- ✨ New feature
