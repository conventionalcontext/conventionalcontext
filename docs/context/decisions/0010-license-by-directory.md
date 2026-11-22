---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# License by directory

## Context and Problem Statement

The repository mixes prose meant to be shared and adapted (the
specification, profiles, adapters), templates meant to be copied into any
repository, and code and schema. One license does not fit all three. How
should each part be licensed, and how should that be stated?

## Considered Options

* License by directory, stated in the README's License section, with
  `LICENSE` files only at the root, `spec/`, and `templates/`
* A `LICENSE` file in every differently licensed directory
* One license for everything

## Decision Outcome

Chosen option: "License by directory, stated in the README".

| Path | License | Why |
|---|---|---|
| `spec/`, `profiles/`, `adapters/` | CC-BY-4.0 | Prose to share and adapt with attribution |
| `templates/` | CC0-1.0 | Copied into any repository with no conditions |
| Everything else (schema, tools, examples, project files) | Apache-2.0 | Code and schema; patent grant |

`profiles/` and `adapters/` have no `LICENSE` file; the README's License
section places them under CC-BY-4.0.

### Consequences

* Good, because adopters can copy templates without attribution.
* Bad, because a reader of `profiles/` must look at the README to find its
  license.
