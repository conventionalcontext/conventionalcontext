# Feature: Spec Kit Interoperability

## Status

`draft`

## ADR

[ADR-0005](../decisions/0005-harc-vs-spec-kit-comparison.md), [ADR-0006](../decisions/0006-harc-spec-kit-extension.md)

## Problem Statement

Teams may want to use HARC's persistent context alongside GitHub Spec Kit's spec-driven development pipeline. Both tools store structured documents in git, so they must coexist without conflict, confusion, or duplication.

## Acceptance Criteria

### File Layout Compatibility

- [ ] [AC-001] HARC's `docs/context/` does not conflict with Spec Kit's `.specify/` directory
- [ ] [AC-002] Bootstrap script does not modify or interfere with `.specify/` if it exists
- [ ] [AC-003] Spec Kit's `specify init` does not conflict with HARC's `docs/context/` structure
- [ ] [AC-004] Both can be bootstrapped in the same repo without errors

### Avoiding Overlap

- [ ] [AC-010] HARC does not implement a constitution/specify/plan/tasks pipeline (Spec Kit's domain)
- [ ] [AC-011] HARC's feature specs in `docs/context/features/` complement, not duplicate, Spec Kit's `.specify/specs/`
- [ ] [AC-012] Documentation clearly explains when to use HARC context vs Spec Kit specs

### Concept Mapping

- [ ] [AC-020] HARC `docs/context/requirements.md` maps to Spec Kit constitution (project-level rules)
- [ ] [AC-021] HARC `docs/context/features/*.md` maps to Spec Kit `.specify/specs/*.md` (feature-level)
- [ ] [AC-022] HARC `docs/context/decisions/` has no direct Spec Kit equivalent (HARC-exclusive)
- [ ] [AC-023] HARC `docs/context/constraints.md` has partial overlap with Spec Kit constitution guardrails

### Extension Design (Future)

- [ ] [AC-030] Spec Kit extension spec documented in [ADR-0006](../decisions/0006-harc-spec-kit-extension.md)
- [ ] [AC-031] Extension maps `.specify/specs/` → `docs/context/features/` without duplication
- [ ] [AC-032] Extension adds `speckit.harc-sync` and `speckit.harc-init` commands

## Data Model Changes

None — this is a compatibility convention. File layouts use separate directories:
- HARC: `docs/context/`
- Spec Kit: `.specify/`

## API Contract

Not applicable — this is a file layout and documentation convention.

## Non-Functional Requirements

- HARC MUST NOT require Spec Kit to function (Spec Kit is opt-in compatibility)
- Spec Kit users MUST be able to adopt HARC incrementally without restructuring `.specify/`
- Both tools MUST be independently removable without breaking the other

## Out of Scope

- Building the actual Spec Kit extension (tracked in roadmap)
- Automated migration from Spec Kit to HARC or vice versa
- Runtime integration between the two tools

## Open Questions

- [ ] Should HARC bootstrap detect `.specify/` and suggest interoperability docs?
- [ ] Should the extension sync be one-way (Spec Kit → HARC) or bidirectional?
