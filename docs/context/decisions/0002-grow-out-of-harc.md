---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Grow Conventional Context out of HARC

## Context and Problem Statement

Conventional Context started as HARC (Human Agentic Readable Context), an
internal framework with a `docs/context/` directory, three synchronized agent
entry files, a bootstrap script, slash commands, Backstage integration, BMAD
compatibility, and a designed in-git ticket system. Starting a public
specification, what should carry over, and how should HARC's own decision
records be treated?

## Considered Options

* Start fresh, record the lineage in one decision, carry over only what fits
* Start fresh without mentioning HARC
* Copy HARC's decision records in and supersede the outdated ones

## Decision Outcome

Chosen option: "Start fresh, record the lineage", because the scope changed
enough that HARC's records would mostly be superseded, while the reasons for
keeping or dropping each part are worth keeping.

| HARC part | Outcome |
|---|---|
| `docs/context/` with requirements, architecture, constraints, glossary, roadmap, decisions, features | Kept: the core of Level 1 |
| Append-only decision records, feature files with acceptance criteria | Kept, aligned with MADR and Spec Kit/OpenSpec formats |
| Three synchronized entry files (`CLAUDE.md`, `.github/copilot-instructions.md`, `AGENTS.md`) | Replaced by one `AGENTS.md` ([0005](0005-route-agents-through-agents-md.md)) |
| Re-runnable bootstrap writing `-HARC` side-by-side copies | Dropped; an optional agent-assisted upgrade path is on the roadmap |
| Slash commands per agent tool | Moved to Later as an optional agent plugin or skills |
| Backstage, TechDocs, `catalog-info.yaml`, scorecards | Out of scope |
| BMAD Method compatibility | Out of scope (C-012) |
| In-git ticket system on an orphan branch | Parked |
| Mermaid as the required diagram format | Dropped ([0009](0009-no-prescribed-diagram-tool.md)) |

### Consequences

* Good, because the record numbering starts clean at 0001 for the public
  project.
* Good, because the reasons behind HARC's choices are not lost.
* Bad, because HARC's detailed designs (for example the ticket system) live
  only in the internal HARC repository until revisited.
