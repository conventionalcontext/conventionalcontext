# Feature: BMAD Method Compatibility

## Status

`in-progress`

## ADR

[ADR-0001](../decisions/0001-harc-framework-adoption.md)

## Problem Statement

The BMAD Method (Build More Architect Dreams) is a popular AI-driven agile development framework with specialized agents, guided workflows, and sprint planning. Teams using BMAD should be able to adopt HARC without conflict, and HARC's structures should map cleanly to BMAD concepts.

## Acceptance Criteria

### Concept Mapping

- [x] [AC-001] HARC `docs/context/requirements.md` maps to BMAD PRD concept
- [x] [AC-002] HARC `docs/context/architecture.md` maps to BMAD architecture document
- [x] [AC-003] HARC `docs/context/decisions/` maps to BMAD ADR concept
- [x] [AC-004] HARC ticket system (when implemented) maps to BMAD sprint-status concept
- [x] [AC-005] HARC `CLAUDE.md` + `docs/context/constraints.md` maps to BMAD project context

### Beads Compatibility

- [x] [AC-010] HARC ticket system design supports beads-style agent coordination patterns
- [x] [AC-011] Ticket fields include `locked_by`, `lock_timestamp` for agent claim/release
- [x] [AC-012] Work session tracking supports multi-agent coordination without conflicts

### Sprint Integration

- [ ] [AC-020] HARC ticket system can interoperate with BMAD `sprint-status.yaml`
- [ ] [AC-021] Sprint status can be represented on the tickets branch or as BMAD YAML (not both)
- [ ] [AC-022] Documentation explains how to use HARC with an existing BMAD workflow

## Data Model Changes

None for the mapping. Ticket system data model (when implemented) must include beads-compatible fields — see [ticket-system.md](ticket-system.md).

## API Contract

Not applicable — this is a compatibility convention, not an interface.

## Non-Functional Requirements

- HARC MUST NOT require BMAD to function (BMAD is opt-in compatibility)
- BMAD users MUST be able to adopt HARC incrementally without restructuring

## Out of Scope

- Implementing BMAD agents or workflows within HARC
- BMAD plugin or template development
- Automated BMAD-to-HARC migration tooling

## Open Questions

- [ ] Should HARC provide a BMAD-to-HARC migration guide?
- [ ] How should `sprint-status.yaml` coexist with the tickets branch?
