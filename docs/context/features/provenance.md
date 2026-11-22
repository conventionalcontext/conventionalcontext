---
type: feature
status: draft
---

# Provenance (Level 2)

## Summary

Level 2 of the specification: recording where intent came from and how it
changed, so readers can trust it. Deferred to 0.2
([decision 0012](../decisions/0012-defer-level-2-provenance.md)).

## User scenarios

### Scenario: Reviewer asks why a constraint exists

- **GIVEN** a constraint in `constraints.md`
- **WHEN** a reviewer wants to know where it came from
- **THEN** provenance leads them to its source (a decision record, an
  incident, a discussion)

## Requirements

To be written for 0.2.

## Success criteria

- **SC-001:** A decision record chooses the provenance approach.
- **SC-002:** The 0.2 specification defines Level 2 and how it is checked.

## Open questions

- Commit trailers that link commits to context files (for example
  `Context: docs/context/decisions/0007-...md`), provenance fields in
  frontmatter, or both?
- How does provenance relate to MADR's `consulted` and `informed` fields?
