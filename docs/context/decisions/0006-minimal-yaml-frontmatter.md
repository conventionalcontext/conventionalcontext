---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Minimal YAML frontmatter

## Context and Problem Statement

For context files to be checkable by machines, tools need to know what each
file is and what state it is in. HARC kept status in the body text. What
metadata should files carry, and where?

## Considered Options

* Minimal YAML frontmatter: `type` and `status`; decisions use MADR's fields
* Richer frontmatter: also `title`, `updated`, `owners`, supersede links
* Frontmatter only on decisions and features

## Decision Outcome

Chosen option: "Minimal YAML frontmatter", because two fields are easy to
adopt and enough for tools to validate structure, and MADR already defines
decision metadata.

* Every context file: `type` and `status`.
* Decision records: MADR 4 fields (`status`, `date`, `decision-makers`, and
  optionally `consulted`, `informed`) plus `type: decision`.
* The index (`docs/context/README.md`) also carries `conventionalcontext`, the
  specification version the directory follows, for example `"0.1"`.

The allowed `type` and `status` values are listed in
[architecture.md](../architecture.md#frontmatter). A JSON Schema will encode
them (FR-012).

### Consequences

* Good, because adding frontmatter to an existing file takes seconds.
* Good, because the specification version is declared once per repository.
* Bad, because ownership and freshness are not captured yet; they belong to
  Level 2 ([0012](0012-defer-level-2-provenance.md)).
