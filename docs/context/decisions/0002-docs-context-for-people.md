---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet, Hamed Minaee
---

# Write docs/context/ for people, not for agent routing

## Context and Problem Statement

The previous version (tag `archive/cc-spec`) told every agent, through `AGENTS.md`, to read
`docs/context/` before any task. Studies of repository context files found
that they do not improve agents' task success and raise cost by more than
20% (Gloaguen et al., 2026), that context strategy does not measurably
change correctness (Khatri, 2026), and that specific instructions are
followed while general overviews do not help. Who is `docs/context/` for,
and what should agents read?

## Considered Options

* Write it for people; agents read only constraints and decisions while planning
* Route every agent to `docs/context/` through `AGENTS.md`
* Agents never read it

## Decision Outcome

Chosen option: "Write it for people; agents read only constraints and decisions while planning", because constraints and decisions are project-specific rules an agent cannot infer from the code, which is the kind of content the studies found agents use, while the rest serves review, onboarding, and documentation.

* The schema's `context` step reads `constraints.md`, current decision records, and needed glossary terms, only when a change is planned (NFR-002).
* No `AGENTS.md` instructions point to `docs/context/`.

### Consequences

* Good, because agents spend tokens only on content likely to change their work.
* Good, because the value claimed for people (review, onboarding, documentation) does not depend on unproven agent benefits.
* Bad, because the benefit of the constraints and decisions check is not yet measured; it is on the roadmap.

## More Information

* Gloaguen et al., 2026: <https://arxiv.org/abs/2602.11988>
* Khatri, 2026: <https://arxiv.org/abs/2607.27250>
* Lulla et al., 2026: <https://arxiv.org/abs/2601.20404>
