---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Requirement and scenario format

## Context and Problem Statement

Requirements and feature files need a format that people, agents, and tools
can read, and that teams using spec-driven development tools recognize. The
popular tools differ: GitHub Spec Kit uses `FR-001: System MUST ...` with
Given/When/Then acceptance scenarios and `SC-001` success criteria; OpenSpec
uses `### Requirement: <name>` headings, SHALL statements, and `#### Scenario:`
blocks with WHEN/THEN bullets and no IDs; Kiro uses EARS ("WHEN ... THE SYSTEM
SHALL ...").

## Considered Options

* Combined: Spec Kit IDs, OpenSpec-style headings, Given/When/Then scenarios,
  BCP 14 MUST
* Spec Kit style only
* OpenSpec style only
* EARS (Kiro)

## Decision Outcome

Chosen option: "Combined", because it reads naturally to users of both Spec
Kit and OpenSpec and keeps IDs for referencing.

```markdown
### FR-001: Standard location for project intent

The specification MUST define `docs/context/` as ...

#### Scenario: Agent looks for intent in an unfamiliar repository

- **GIVEN** an adopting repository the agent has never seen
- **WHEN** the agent needs the project's requirements
- **THEN** it finds them at `docs/context/requirements.md`
```

* IDs: `FR-NNN` functional, `NFR-NNN` non-functional, `SC-NNN` success
  criteria. Recommended, not required.
* Keywords: BCP 14 in uppercase; MUST rather than SHALL (equivalent in RFC
  2119; MUST matches Spec Kit and most specifications).
* Scenarios: optional; Given/When/Then from behaviour-driven development,
  a superset of OpenSpec's WHEN/THEN.

### Consequences

* Good, because requirements can be lifted into Spec Kit or OpenSpec specs
  with little change.
* Bad, because EARS users (Kiro) see a different sentence pattern; the
  planned AI-DLC/Kiro adapter will map it.
