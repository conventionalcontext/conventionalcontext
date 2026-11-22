---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# What the system does stays in OpenSpec

## Context

OpenSpec keeps what a system does in `openspec/specs/`, and work in progress in `openspec/changes/`. When a change is finished, OpenSpec merges its specs into `openspec/specs/`, so they stay current. Many documentation conventions also have a section for features or functional requirements.

## Problem Statement

If `docs/context/` also described features or behavior, the same facts would be written twice, and the two copies would drift apart. What belongs in `docs/context/`, and what stays in OpenSpec?

## Considered Options

* Behavior only in OpenSpec; `docs/context/` holds what OpenSpec does not
* Feature files and functional requirements in `docs/context/` as well

## Decision Outcome

Chosen option: "Behavior only in OpenSpec", because each fact is written once, and OpenSpec keeps behavior current as changes are finished.

* `requirements.md` holds purpose, users, scope, and quality requirements, and links to `openspec/specs/`.
* There is no `features/` folder; `roadmap.md` links to OpenSpec changes.

### Consequences

* Good, because nothing drifts between two copies.
* Bad, because a reader in a developer portal follows a link to the repository to read the specs.
