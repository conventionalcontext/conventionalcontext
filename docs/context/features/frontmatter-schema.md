---
type: feature
status: planned
---

# Frontmatter and schema

## Summary

A JSON Schema for context-file frontmatter, so tools can check `type`,
`status`, the index's `conventionalcontext` version, and MADR's decision
fields. See [decision 0006](../decisions/0006-minimal-yaml-frontmatter.md).

## User scenarios

### Scenario: CI rejects an unknown status

- **GIVEN** a feature file with `status: finished`
- **WHEN** CI validates frontmatter against the schema
- **THEN** it fails and names the allowed values

## Requirements

FR-005, FR-012 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** `schema/context-file.schema.json` exists with an `$id` under
  `https://conventionalcontext.org/`.
- **SC-002:** Every file in this repository's `docs/context/` validates
  against it.

## Open questions

- Should the `$id` URL resolve (the domain currently redirects to the
  repository)?
- One schema with conditional rules per `type`, or one schema per type?
