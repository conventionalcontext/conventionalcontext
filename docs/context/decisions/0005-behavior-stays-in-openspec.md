---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet, Hamed Minaee
---

# Behavior stays in OpenSpec; no feature files

## Context and Problem Statement

OpenSpec keeps the current behavior of a system in `openspec/specs/` and
work in progress in `openspec/changes/`. The previous version (tag `archive/cc-spec`) also had
`features/` and functional requirements in `docs/context/`. What belongs
where?

## Considered Options

* Behavior only in OpenSpec; `docs/context/` keeps what OpenSpec does not
* Keep feature files and functional requirements in `docs/context/` too

## Decision Outcome

Chosen option: "Behavior only in OpenSpec; `docs/context/` keeps what OpenSpec does not", because each fact is written once, and OpenSpec already keeps behavior current when changes are archived.

* `requirements.md` holds purpose, users, scope, and quality requirements, and links to `openspec/specs/`.
* There is no `features/` folder; `roadmap.md` links to OpenSpec changes.

### Consequences

* Good, because nothing drifts between two copies.
* Bad, because a portal reader follows a link to the repository to read behavior specs.
