---
type: feature
status: planned
---

# Templates

## Summary

Blank versions of every context file in `templates/docs/context/`, with short
guidance comments, which adopters copy into their repository. Licensed
CC0-1.0 so they can be copied without conditions.

## User scenarios

### Scenario: Team starts from the templates

- **GIVEN** a repository without `docs/context/`
- **WHEN** the team copies `templates/docs/context/` into it
- **THEN** every file has valid frontmatter and guidance on what to write

## Requirements

FR-011, NFR-004 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** A template exists for the index, every required and recommended
  file, a decision record (MADR 4), and a feature file.
- **SC-002:** Templates contain only structure and guidance, never this
  project's content (C-028).
- **SC-003:** An `AGENTS.md` snippet with routing and a `## Conventions`
  section is included.

## Open questions

- How much guidance belongs in the template comments versus the specification?
