---
type: feature
status: in-progress
---

# Context structure (Level 1)

## Summary

The core of the specification: an adopting repository keeps its intent in
`docs/context/`, with an index, required files, recommended files, and the
formats each file uses. This repository already dogfoods the structure. The
specification text in `spec/v0.1/SPEC.md` is the release gate for v0.1.0.

## User scenarios

### Scenario: Team adopts the core

- **GIVEN** a repository with no `docs/context/`
- **WHEN** the team adds `README.md`, `requirements.md`, `architecture.md`,
  and `decisions/` following the specification
- **THEN** the repository meets Level 1 and can add recommended files later

### Scenario: Agent finds a constraint before changing code

- **GIVEN** an adopting repository with `constraints.md`
- **WHEN** an agent plans a change
- **THEN** it reads the index, finds `constraints.md`, and respects the
  constraints it lists

## Requirements

FR-001, FR-002, FR-003, FR-004, FR-006, FR-007, FR-008, FR-016, NFR-001,
NFR-002, NFR-004 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** `spec/v0.1/SPEC.md` defines every required and recommended file,
  its purpose, and its format.
- **SC-002:** This repository's `docs/context/` follows the specification it
  publishes, with no exceptions.
- **SC-003:** A team new to the specification can create the Level 1 core
  from the templates in under an hour.

## Open questions

- Should a monorepo have one `docs/context/` or one per package?
