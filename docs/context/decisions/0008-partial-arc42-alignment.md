---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Partial arc42 alignment

## Context and Problem Statement

arc42 is a widely used template for architecture documentation with twelve
sections. Several overlap with `docs/context/` files. Aligning helps teams
that already use arc42, but adopting all of it would make the specification
heavy. Which parts should Conventional Context align with?

## Considered Options

* Align with selected sections, agreed one by one
* Adopt arc42 as a whole
* Ignore arc42

## Decision Outcome

Chosen option: "Align with selected sections", each agreed explicitly by a
maintainer. Further sections need agreement and a new decision record
(C-013).

| arc42 section | Used for |
|---|---|
| 2 Architecture constraints | `constraints.md`: technical, organizational, conventions tables. arc42 suggests no IDs, so ours are `C-NNN`. |
| 3 Context and scope | `architecture.md` |
| 4 Solution strategy | `architecture.md` |
| 5 Building block view | `architecture.md` |
| 8 Crosscutting concepts | `architecture.md` |
| 10 Quality requirements (lightly) | Non-functional requirements as `NFR-NNN`, grouped by ISO/IEC 25010 quality characteristics; no quality tree or quality scenarios |
| 12 Glossary | `glossary.md` as a Term / Definition table |

Not used: sections 1 (covered by `requirements.md`), 6 (runtime view), 7
(deployment view), 9 (covered by `decisions/` with MADR), 11 (risks and
technical debt).

### Consequences

* Good, because arc42 users recognize the structure.
* Bad, because the mapping must be kept explicit as the specification grows.
