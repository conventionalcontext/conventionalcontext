---
type: decision
status: superseded
date: 2026-10-08
decision-makers: andreouellet
---

# Repository layout

## Context and Problem Statement

This repository holds the specification, the artifacts that support it, and
its own project context. HARC mixed framework documentation, Backstage
templates, and its own context under `docs/`. How should the parts be laid
out so that this repository's `docs/` looks exactly like an adopter's?

## Decision Outcome

Chosen option: the layout below.

```
spec/vX.Y/SPEC.md        the specification: the product, at the top level
schema/                  frontmatter JSON Schema
templates/docs/context/  blank context files, mirroring where they land
profiles/                opinions per kind of project
adapters/                how Conventional Context fits other tools
examples/                filled-in docs/context/ directories
tools/                   optional scaffold and linter
docs/context/            this project's own intent (dogfood)
AGENTS.md                routes agents to docs/context/
```

Rules:

* `docs/` holds only `docs/context/`, so this repository is a reference
  example of an adopting repository.
* Templates never live in `docs/context/`; that path is this project's real
  intent (C-028).
* The specification is at the top level because it is the product, not this
  repository's documentation.
* A directory is created only when its content is ready; no placeholder files.

### Consequences

* Good, because adopters can compare their repository with this one directly.
* Bad, because the specification is not under `docs/`, where some readers
  look first; the README links to it.
