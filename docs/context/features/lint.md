---
type: feature
status: draft
---

# Lint

## Summary

An optional checker that validates a repository's `docs/context/` against the
specification and the frontmatter schema, runnable locally and in CI. This
repository will run it on its own `docs/context/`. Status draft: the tooling
language is not chosen yet (C-004).

## User scenarios

### Scenario: Pull request misses a required file

- **GIVEN** a repository that declares `conventionalcontext: "0.1"`
- **WHEN** a pull request deletes `architecture.md`
- **THEN** the CI check fails and names the missing required file

## Requirements

FR-012, NFR-008 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** Checks required files, frontmatter against the schema, and
  decision-record numbering.
- **SC-002:** Runs in this repository's CI on every pull request.

## Open questions

- Language and distribution (decision record needed).
- Should it warn on stale context (for example code changed, context not)?
