---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# Publish docs/context/ as plain Markdown

## Context

Teams often publish documentation in a developer portal, such as Backstage or Port, next to the rest of a repository's documentation. Backstage TechDocs needs a `mkdocs.yml` and a `catalog-info.yaml` entry; Port reads Markdown files. OpenSpec's specs live outside `docs/`, in `openspec/specs/`.

## Problem Statement

`docs/context/` should appear in these portals with little extra work. How far should Conventional Context go: plain Markdown only, files for each portal, or copies of OpenSpec's specs in the published documentation? Every portal-specific file is one more file each project must maintain.

## Considered Options

* Plain Markdown, with an optional TechDocs example, linking to OpenSpec's specs
* Portal-specific files as part of the convention
* Copy OpenSpec's specs into the published documentation

## Decision Outcome

Chosen option: "Plain Markdown, with an optional TechDocs example", because it works in any portal, and copies nothing.

* `examples/techdocs/` has a minimal `mkdocs.yml` and the `catalog-info.yaml` entry.

### Consequences

* Good, because no portal is required.
* Bad, because OpenSpec's specs are not shown in the portal itself; readers follow a link.
