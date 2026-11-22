---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet, Hamed Minaee
---

# Decision records in MADR 4, with an archive for previous versions

## Context and Problem Statement

Decision records are read in developer portals by people who want to know
what holds today. The usual ADR practice (immutable records, superseded by
new ones) makes readers follow chains of links. How should changed decisions
be recorded?

## Considered Options

* MADR 4, updated in place, previous versions moved to `decisions/archive/`
* Immutable records superseded by new ones (standard ADR practice)
* Edit in place and rely on git history

## Decision Outcome

Chosen option: "MADR 4, updated in place, previous versions moved to `decisions/archive/`", because `decisions/` then shows only what holds today, links stay stable, and the history is one click away.

* To change a decision: move the current file unchanged, with status `superseded`, to `decisions/archive/NNNN-title-YYYY-MM-DD.md`; update the original in place; list the archived version under `## Previous decisions`.
* Corrections that do not change a decision are made in place.

### Consequences

* Good, because portal readers see only current decisions.
* Bad, because it differs from common ADR practice, so the schema and templates explain it.

## More Information

* MADR: <https://adr.github.io/madr/>
