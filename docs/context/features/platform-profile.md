---
type: feature
status: planned
---

# Platform profile

## Summary

The first profile: opinions for platform engineering repositories
(infrastructure as code, GitOps, cloud foundations) on what their context
files should cover, with a filled-in example in `examples/platform/`.

## User scenarios

### Scenario: Infrastructure team writes constraints

- **GIVEN** an infrastructure-as-code repository adopting Conventional Context
- **WHEN** the team follows the platform profile
- **THEN** its `constraints.md` covers the topics the profile names (for
  example environments, state, change approval, drift)

## Requirements

FR-014 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** `profiles/platform.md` exists and never contradicts the
  specification.
- **SC-002:** `examples/platform/` contains a complete `docs/context/` drawn
  from a real infrastructure repository.

## Open questions

- Which real repository should the example be based on?
- Which topics are common enough across platform teams to recommend?
