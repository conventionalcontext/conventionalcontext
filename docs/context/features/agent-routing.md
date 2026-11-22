---
type: feature
status: in-progress
---

# Agent routing via AGENTS.md

## Summary

`AGENTS.md` sends agents to `docs/context/README.md` before they change
anything, and declares the repository's conventions for writing context in a
`## Conventions` section. This repository's `AGENTS.md` already routes agents;
its conventions section is part of 0.1.0. See
[decision 0005](../decisions/0005-route-agents-through-agents-md.md).

## User scenarios

### Scenario: Agent starts a session

- **GIVEN** an adopting repository with an `AGENTS.md`
- **WHEN** an agent starts a session
- **THEN** it reads `docs/context/README.md` and the files relevant to its
  task before editing

### Scenario: Agent writes an architecture change

- **GIVEN** `AGENTS.md` declares `- Diagrams: d2`
- **WHEN** an agent updates `architecture.md`
- **THEN** any diagram it adds is a D2 source, not Mermaid

### Scenario: Tool that does not read AGENTS.md

- **GIVEN** a tool that reads only its own instruction file
- **WHEN** the repository adds a one-line pointer file for it
- **THEN** the tool reaches `AGENTS.md` and follows the same routing

## Requirements

FR-009, FR-010, NFR-005 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** The specification defines the routing and the
  `## Conventions` section in a few lines an adopter can copy.
- **SC-002:** This repository's `AGENTS.md` has a `## Conventions` section.
- **SC-003:** The AGENTS.md adapter lists pointer files for common tools that
  do not read `AGENTS.md`.

## Open questions

- Which convention keys should the specification name (diagrams, others)?
