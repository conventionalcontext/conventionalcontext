---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet, Hamed Minaee
---

# Own schema, based on OpenSpec's spec-driven schema

## Context and Problem Statement

OpenSpec's community already has an `intent-driven` schema that records
durable decisions as immutable ADRs in a top-level `adr/` folder. Conventional
Context needs the whole `docs/context/` set, decisions in
`docs/context/decisions/`, and its own archive rule. Which schema should it
build on?

## Considered Options

* Own schema based on OpenSpec's built-in `spec-driven` schema
* Build on the `intent-driven` community schema
* Contribute `docs/context/` support to `intent-driven`

## Decision Outcome

Chosen option: "Own schema based on OpenSpec's built-in `spec-driven` schema", because it keeps OpenSpec's default workflow that users already know, and gives full control over the `docs/context/` layout and the decision archive rule.

* Upstream text is kept unchanged; additions start with "Conventional Context:" (C-003).
* One artifact is added: `context`, between proposal and specs.
* `intent-driven` is credited as prior art.

### Consequences

* Good, because upstream improvements are easy to merge.
* Good, because the workflow differs from OpenSpec's default by one step.
* Bad, because each OpenSpec release may need the upstream text refreshed.

## More Information

* intent-driven schema: <https://github.com/intent-driven-dev/openspec-schemas>
