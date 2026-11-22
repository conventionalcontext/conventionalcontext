---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Keep project intent in `docs/context/`

## Context and Problem Statement

Agents and people need to find a repository's intent without searching.
Where should it live, which files must exist, and does adoption need tooling?

## Considered Options

* `docs/context/` with a fixed file set: core required, rest recommended
* `docs/context/` with every file required
* A hidden directory (`.context/`)
* Only `docs/context/README.md` required, everything else optional

## Decision Outcome

Chosen option: "`docs/context/` with core required, rest recommended".

* Required at Level 1: `README.md` (index), `requirements.md`,
  `architecture.md`, `decisions/`.
* Recommended: `constraints.md`, `glossary.md`, `roadmap.md`, `features/`.
* Reading and writing context needs no tool; tooling stays optional.

`docs/` is visible and renders in every git host and documentation tool;
HARC moved from `.context/` to `docs/context/` for the same reason. A small
required core lets teams adopt in steps.

### Consequences

* Good, because the location is predictable across repositories.
* Good, because a team can adopt the core in an hour and grow from there.
* Bad, because `docs/` may already be used by a documentation site; the
  `context/` subdirectory avoids conflicts but shares the parent.
