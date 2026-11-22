---
type: feature
status: planned
---

# Adapters

## Summary

Documents in `adapters/` explaining how Conventional Context sits alongside
other tools, mapping their files to `docs/context/` without duplicating or
replacing them. Next: AGENTS.md, GitHub Spec Kit, OpenSpec. Later: AWS
AI-DLC and Kiro.

## User scenarios

### Scenario: Spec Kit team adopts Conventional Context

- **GIVEN** a repository that uses Spec Kit (`.specify/`)
- **WHEN** the team reads the Spec Kit adapter
- **THEN** it knows which intent goes in `docs/context/` (project-wide) and
  which stays in `specs/` (per feature), and that it does not use
  `docs/context/features/`
  ([decision 0017](../decisions/0017-feature-files-and-sdd-tools.md))

The Spec Kit adapter covers:

- `.specify/memory/constitution.md` stays short and points to
  `constraints.md` and `decisions/` instead of repeating them.
- `roadmap.md` links to `specs/NNN-feature-name/spec.md` for each feature.
- When a feature is done, anything that holds beyond it (a lasting
  requirement, constraint, or decision) moves up into `requirements.md`,
  `constraints.md`, or `decisions/` in the same pull request.
- Spec Kit's `FR-001` IDs are local to each spec. Outside the spec, cite them
  with the path (`specs/003-user-auth/spec.md FR-002`); a bare `FR-NNN`
  means `requirements.md`.
- If the optional `agent-context` extension is used, its managed block
  (between `<!-- SPECKIT START -->` and `<!-- SPECKIT END -->`) sits in
  `AGENTS.md` next to the *Start with the project's intent* section and
  does not replace it.

### Scenario: OpenSpec team adopts Conventional Context

- **GIVEN** a repository that uses OpenSpec (`openspec/`)
- **WHEN** the team reads the OpenSpec adapter
- **THEN** it knows how `openspec/specs/` relates to `requirements.md`, and
  that it does not use `docs/context/features/`

## Requirements

FR-003, FR-013, NFR-006 ([requirements.md](../requirements.md)).
Decision [0017](../decisions/0017-feature-files-and-sdd-tools.md).

## Success criteria

- **SC-001:** `adapters/agents-md.md`, `adapters/spec-kit.md`, and
  `adapters/openspec.md` exist.
- **SC-002:** No adapter asks an adopter to copy content between the two
  tools' directories.

## Open questions

- Should a tool's feature spec link back to the `docs/context/` files it
  relies on (for example a "Context" line in `spec.md`)?
