---
type: feature
status: draft
---

# Init

## Summary

An optional scaffold that creates `docs/context/` and an `AGENTS.md` snippet
in a repository from the templates. Status draft: the tooling language is
not chosen yet (C-004), and it may be replaced by an agent prompt or skill.

## User scenarios

### Scenario: Scaffold into a repository without context

- **GIVEN** a repository without `docs/context/`
- **WHEN** a maintainer runs the scaffold
- **THEN** the template files are created and nothing existing is changed

## Requirements

FR-011, NFR-008 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** Running the scaffold never overwrites an existing file.

## Open questions

- Script, package, or agent prompt/skill?
- How does it relate to the optional upgrade path (FR-015)?
