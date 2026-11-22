---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Align with existing community conventions

## Context and Problem Statement

Every format the specification defines (decision records, requirements,
scenarios, changelogs, entry files) could be invented or borrowed. HARC
invented most of its own. Each invented format is something adopters must
learn and tools must support. How should formats be chosen?

## Decision Drivers

* Adopters should recognize formats they already use.
* Agents should already have seen the formats in their training data.
* The specification should stay small.

## Considered Options

* Reuse existing conventions with moderate to good adoption; invent only
  where none exists
* Design our own formats for consistency

## Decision Outcome

Chosen option: "Reuse existing conventions", because it lowers the cost of
adoption and lets agents and tools work with familiar formats.

Applied so far:

| Area | Convention |
|---|---|
| Decision records | MADR 4 ([0001](0001-record-decisions-with-madr.md)) |
| Requirement keywords | BCP 14 (RFC 2119, RFC 8174) |
| Requirement IDs, scenarios | GitHub Spec Kit IDs, OpenSpec headings, Given/When/Then ([0007](0007-requirement-format.md)) |
| Constraints, architecture, quality, glossary | Selected arc42 sections, ISO/IEC 25010 ([0008](0008-partial-arc42-alignment.md)) |
| Agent entry file | AGENTS.md ([0005](0005-route-agents-through-agents-md.md)) |
| Changelog, versions, commits | Keep a Changelog, SemVer, Conventional Commits |
| Roadmap | Now / Next / Later |

Where no convention exists, the decision introducing our own says so (for
example `C-NNN` constraint IDs in [0008](0008-partial-arc42-alignment.md)).

### Consequences

* Good, because most of the specification is already familiar.
* Bad, because borrowed formats differ in style, so the specification must
  explain how they fit together.
* Bad, because a convention can lose adoption; that needs a new decision
  record when it happens.
