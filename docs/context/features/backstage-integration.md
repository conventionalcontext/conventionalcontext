# Feature: Backstage Integration

## Status

`in-progress`

## ADR

[ADR-0001](../decisions/0001-harc-framework-adoption.md)

## Problem Statement

Platform engineering teams using Backstage as their IDP need HARC context files to surface in the software catalog, TechDocs, and scorecards — without duplicating content. The integration must be optional so that teams not using Backstage can still use HARC.

## Acceptance Criteria

### Catalog Registration

- [x] [AC-001] `catalog-info.yaml` template exists at repo root with HARC-specific annotations
- [x] [AC-002] Annotations include `harc.dev/context-path: docs/context/` and `harc.dev/entry-point: CLAUDE.md`
- [x] [AC-003] `catalog-info.yaml` can be safely deleted if Backstage is not used

### TechDocs

- [ ] [AC-010] `docs/mkdocs.yml` maps `docs/context/` files into TechDocs navigation
- [ ] [AC-011] `docs/context/` files render correctly as TechDocs pages in Backstage
- [ ] [AC-012] TechDocs template files available in `templates/docs/` for bootstrap

### Scorecards

- [ ] [AC-020] Scorecard rules documented for context quality enforcement
- [ ] [AC-021] Rules include: CLAUDE.md modified in last 90 days, architecture.md exists, at least one ADR exists
- [ ] [AC-022] Scorecard rules are opt-in (not enforced by default)

### Optional by Design

- [x] [AC-030] All documentation marks Backstage as "optional"
- [x] [AC-031] Constraints use SHOULD/MAY (not MUST) for Backstage-related rules — see [C-050] through [C-053]
- [x] [AC-032] Getting started guide includes instructions for removing Backstage files

## Data Model Changes

None — Backstage reads existing files via annotations.

## API Contract

```yaml
# catalog-info.yaml annotations for HARC
annotations:
  backstage.io/techdocs-ref: dir:.
  harc.dev/context-path: docs/context/
  harc.dev/entry-point: CLAUDE.md
```

## Non-Functional Requirements

- Backstage integration SHOULD work with Backstage 1.x — see [NFR-C04]
- TechDocs SHOULD render `docs/context/` files without modification
- Removing Backstage files MUST NOT break HARC functionality

## Out of Scope

- Custom Backstage plugins for HARC
- Backstage Software Templates for HARC
- Backstage search indexing of `docs/context/` files

## Open Questions

- [ ] Should TechDocs nav be auto-generated from `docs/context/` directory listing?
- [ ] What Backstage version(s) should be tested against?
