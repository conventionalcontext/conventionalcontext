---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet
---

# Feature files only when no spec-driven development tool tracks features

## Context and Problem Statement

`features/` is a recommended part of `docs/context/` (FR-003, FR-008): one
file per feature, with status, Given/When/Then scenarios, related
requirements, and success criteria.

Spec-driven development (SDD) tools do the same job. GitHub Spec Kit (v1.4.3)
writes `specs/NNN-feature-name/spec.md` for each feature, with user stories,
Given/When/Then acceptance scenarios, `FR-001` requirements, and `SC-001`
success criteria, then a plan, tasks, and code. OpenSpec and Kiro do the same
in `openspec/` and `.kiro/`. A repository that uses one of these tools and
also keeps `docs/context/features/` writes every feature twice, and the two
copies drift apart.

Spec Kit also has a project-wide file, `.specify/memory/constitution.md`
(principles and governance), which overlaps with `constraints.md` and
`decisions/`. What Spec Kit does not have is one current, project-wide view of
requirements, decisions with their reasons, and terms: each feature keeps its
own folder, and earlier feature specs are not updated when later features
change behaviour.

How should `features/` relate to SDD tools, so that Conventional Context adds
the project-wide intent without duplicating feature specs?

## Decision Drivers

* Write each fact once (FR-013: adapters do not duplicate other tools' files).
* Projects without an SDD tool still need a light place for acceptance
  criteria.
* Agents should find one answer, not two that disagree.
* The specification must stay tool-agnostic (NFR-005).

## Considered Options

* Feature files only when no SDD tool tracks features
* Remove `features/` from the specification
* Keep `features/` as a thin index that links to the tool's specs
* Keep `features/` unchanged and let both coexist

## Decision Outcome

Chosen option: "Feature files only when no SDD tool tracks features",
because projects without a tool keep a simple option, and projects with a
tool get no duplication.

* `features/` stays recommended for repositories where no SDD tool manages
  feature specs. Where one does (Spec Kit, OpenSpec, Kiro), the repository
  does not use `features/`; `roadmap.md` links to the tool's feature specs
  instead.
* `docs/context/` keeps the project-wide, current intent: requirements,
  constraints, architecture, decisions, glossary, and roadmap. The SDD tool
  keeps the per-feature work: spec, plan, tasks.
* When a feature spec settles something that holds beyond the feature (a
  lasting requirement, a constraint, a significant decision), it is added to
  `requirements.md`, `constraints.md`, or `decisions/` in the same pull
  request.
* Requirement IDs in an SDD tool's feature spec are local to that spec (Spec
  Kit restarts at `FR-001` in each one). When cited outside the spec, they
  are cited with the spec's path, for example
  `specs/003-user-auth/spec.md FR-002`. Bare `FR-NNN` means
  `requirements.md`.
* With Spec Kit, the constitution stays short and points to `docs/context/`
  for constraints and decisions, instead of repeating them.
* `docs/context/` uses neither `.specify/`, `specs/`, `openspec/`, nor
  `.kiro/` (NFR-006).

The adapters ([features/adapters.md](../features/adapters.md)) describe this
for each tool. This repository has no SDD tool, so it keeps `features/`.

### Consequences

* Good, because each feature is written once.
* Good, because the roles are clear: Conventional Context for the Intent
  stage, SDD tools for Spec to Build.
* Good, because projects without a tool lose nothing.
* Bad, because `features/` now depends on whether a tool is used, which the
  specification and templates must explain.
* Bad, because lasting facts must be copied up from a feature spec by hand
  (or by an agent) when the feature is done.

## More Information

* GitHub Spec Kit: <https://github.com/github/spec-kit>
* Related: [0003](0003-align-with-existing-conventions.md),
  [0007](0007-requirement-format.md)
