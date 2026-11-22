# Feature: Living Artifacts

## Status

`complete`

## ADR

None required — this is a convention, not an architectural decision.

## Problem Statement

Documentation rots when it's treated as a one-time deliverable. HARC needs a mechanism to ensure certain files are automatically and routinely updated as the project evolves, particularly the changelog and README feature list. AI agents should update these artifacts as part of their development workflow without being asked.

## Acceptance Criteria

### CHANGELOG.md

- [x] [AC-001] `CHANGELOG.md` exists at repo root following [Keep a Changelog](https://keepachangelog.com/) format
- [x] [AC-002] `CHANGELOG.md` includes `[Unreleased]` section for in-progress changes
- [x] [AC-003] `CLAUDE.md` instructs Claude Code to update `CHANGELOG.md` after completing features
- [x] [AC-004] `.github/copilot-instructions.md` instructs GitHub Copilot to update `CHANGELOG.md`
- [x] [AC-005] `AGENTS.md` instructs OpenCode to update `CHANGELOG.md`
- [x] [AC-006] The `/update-context` Claude Code slash command includes CHANGELOG.md update step
- [x] [AC-007] Bootstrap script generates `CHANGELOG.md` template with correct format
- [x] [AC-008] CHANGELOG.md is listed in the key context files table of all three entry points

### README.md Feature List

- [x] [AC-020] `README.md` includes a bullet-point list of project features just below the project title and description
- [x] [AC-021] Each feature in the list links to its corresponding `docs/context/features/` spec file
- [x] [AC-022] All three AI entry points (CLAUDE.md, copilot-instructions.md, AGENTS.md) instruct agents to keep the README feature list updated when features are added, removed, or renamed
- [x] [AC-023] Bootstrap entry point templates include the README feature-list rule
- [x] [AC-024] Feature list entries show status indicators for non-complete features (e.g. *in progress*, *draft*)

## Data Model Changes

None.

## API Contract

```markdown
# Changelog format (Keep a Changelog)
## [Unreleased]
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security
```

## Non-Functional Requirements

- CHANGELOG.md MUST be human-readable without tooling
- AI agents MUST append entries (never rewrite history)
- Format MUST follow keepachangelog.com convention for tooling compatibility

## Out of Scope

- Automated version bumping (manual or CI-driven)
- Auto-generated changelogs from git commits (this is curated)
- Dependency maps, test coverage reports, API diffs (future living artifacts)
- Auto-generating the feature list from filesystem (manual curation is intentional)

## Open Questions

None — this feature is complete.
