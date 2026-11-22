---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet, Hamed Minaee
---

# Publish docs/context/ as plain Markdown, with a TechDocs example

## Context and Problem Statement

`docs/context/` should appear in developer portals with the rest of a
repository's documentation. Backstage TechDocs needs `mkdocs.yml` and a
`catalog-info.yaml` annotation; Port ingests Markdown files. OpenSpec's specs
live outside `docs/`. How far should Conventional Context go?

## Considered Options

* Plain Markdown, with an optional TechDocs example; link to OpenSpec specs
* Define `catalog-info.yaml` and `mkdocs.yml` as part of the convention
* Pull `openspec/specs/` into the TechDocs build

## Decision Outcome

Chosen option: "Plain Markdown, with an optional TechDocs example; link to OpenSpec specs", because it works in any portal, and copies nothing.

* `examples/techdocs/` has a minimal `mkdocs.yml` (links outside `docs/` reported as info) and the `backstage.io/techdocs-ref` annotation.

### Consequences

* Good, because no portal is required or favoured.
* Bad, because OpenSpec specs are not rendered in the portal itself.
