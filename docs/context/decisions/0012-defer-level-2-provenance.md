---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Defer Level 2 provenance to 0.2

## Context and Problem Statement

The specification is planned in two levels: Level 1, structure (which files,
where, what they contain), and Level 2, provenance (where intent came from and
how it changed). Level 2 could use commit trailers that link commits to
context files, provenance fields in frontmatter, or both. Neither has been
designed. Should 0.1 define it?

## Considered Options

* Defer Level 2 to 0.2; describe it as planned
* Define commit trailers in 0.1
* Define frontmatter provenance fields in 0.1

## Decision Outcome

Chosen option: "Defer to 0.2", because Level 1 must settle first, and the
approach needs its own design and decision record.

### Consequences

* Good, because 0.1 stays small and focused on structure.
* Bad, because adopters have no standard way to record provenance yet.

## More Information

See the [provenance feature](../features/provenance.md) for the open
questions.
