---
type: decision
status: accepted
date: 2026-11-16
decision-makers: andreouellet
---

# Repository layout

## Context and Problem Statement

This repository holds the specification, the artifacts that support it, its
own project context, and the project website. HARC mixed framework
documentation, Backstage templates, and its own context under `docs/`. How
should the parts be laid out so that this repository's `docs/context/` looks
exactly like an adopter's?

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
docs/website/            the conventionalcontext.org website
AGENTS.md                routes agents to docs/context/
```

Rules:

* `docs/context/` holds only this project's own intent, laid out exactly as
  in an adopting repository, so this repository is a reference example.
* `docs/website/` holds the project website and nothing else
  ([0016](0016-project-website.md)). Adopters do not need a website.
* Templates never live in `docs/context/`; that path is this project's real
  intent (C-028).
* The specification is at the top level because it is the product, not this
  repository's documentation.
* A directory is created only when its content is ready; no placeholder files.

### Consequences

* Good, because adopters can compare their `docs/context/` with this one
  directly.
* Good, because the website sits under `docs/`, where documentation tools and
  readers expect it, without mixing into `docs/context/`.
* Bad, because the specification is not under `docs/`, where some readers
  look first; the README and website link to it.

## Previous decisions

* [2026-10-08](archive/0011-repository-layout-2026-10-08.md): `docs/` held
  only `docs/context/`. Changed to add `docs/website/`.
