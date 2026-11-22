# Feature: Bootstrap & Migration

## Status

`complete`

## ADR

[ADR-0001](../decisions/0001-harc-framework-adoption.md)

## Problem Statement

Developers need a zero-friction way to adopt HARC in both new and existing repositories. New repos need the full structure scaffolded. Existing repos already have files like `CHANGELOG.md` or `README.md` that shouldn't be overwritten — they need a migration path that creates HARC templates alongside existing files for comparison and refactoring.

## Acceptance Criteria

### Bootstrap

- [x] [AC-001] `scripts/bootstrap.sh` exists and is executable
- [x] [AC-002] Running creates all HARC files with `[PLACEHOLDER]` values
- [x] [AC-003] When a file already exists, creates `<basename>-HARC.<ext>` alongside it (never overwrites)
- [x] [AC-004] The script creates all three AI entry point files (CLAUDE.md, copilot-instructions.md, AGENTS.md)
- [x] [AC-005] The script creates `docs/context/` with requirements, architecture, constraints, glossary, decisions, features
- [x] [AC-006] The script creates `.claude/commands/` with slash commands
- [x] [AC-007] The script creates `catalog-info.yaml`, `CHANGELOG.md`, and `docs/` files
- [x] [AC-008] The script prints a summary of created/template files and next steps
- [x] [AC-009] The script supports `--help` flag
- [x] [AC-010] Same command works for both new repos (all created) and existing repos (-HARC templates)
- [x] [AC-011] Original files are never modified or overwritten
- [x] [AC-012] Next steps dynamically show -HARC instructions when templates were created

### Test Script

- [x] [AC-016] `tests/test-bootstrap.sh` exists and validates bootstrap output
- [x] [AC-017] Test script supports `--existing`, `--upgrade`, and `--all` modes
- [x] [AC-018] Test output goes to `test-results/bootstrap/` (gitignored)
- [x] [AC-019] Test validates all expected files are created
- [x] [AC-020] Test validates existing files get `-HARC` templates and originals are preserved
- [x] [AC-021] Upgrade test runs bootstrap twice, verifies -HARC templates appear for all files on second run
- [x] [AC-022] Upgrade test verifies user-customized content is preserved after re-run
- [x] [AC-023] Tests use realistic project data (not one-line stubs)

## Data Model Changes

None.

## API Contract

```bash
# Bootstrap (works for new and existing repos):
./scripts/bootstrap.sh

# Help:
./scripts/bootstrap.sh --help

# Test:
./tests/test-bootstrap.sh [--fresh|--existing|--upgrade]
```

## Non-Functional Requirements

- Script MUST use shell only (no compiled binaries) — see [NFR-P02]
- Script MUST work on macOS and Linux
- Script MUST be downloadable via `curl` and run standalone

## Out of Scope

- Interactive prompts for `[PLACEHOLDER]` values (manual fill-in)
- Automatic detection of project language/framework
- Git operations (user commits manually)

## Open Questions

None — this feature is complete.
