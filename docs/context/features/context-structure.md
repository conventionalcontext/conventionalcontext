# Feature: Context Structure

## Status

`complete`

## ADR

[ADR-0001](../decisions/0001-harc-framework-adoption.md)

## Problem Statement

AI coding assistants start every session with zero project knowledge. Without structured, in-repo context, they generate code that conflicts with conventions, repeat decisions already made, and require developers to re-explain the project every time.

## Acceptance Criteria

- [x] [AC-001] A `docs/context/` directory exists at the repo root containing all structured project knowledge
- [x] [AC-002] `docs/context/requirements.md` captures functional and non-functional requirements with RFC 2119 language (MUST/SHOULD/MAY)
- [x] [AC-003] `docs/context/architecture.md` documents system design with Mermaid diagrams (C4 Context, ER, flowcharts)
- [x] [AC-004] `docs/context/constraints.md` contains numbered rules ([C-NNN]) that AI agents and engineers must follow
- [x] [AC-005] `docs/context/glossary.md` defines domain terms with specific meanings in this bounded context
- [x] [AC-006] `docs/context/decisions/` contains Architecture Decision Records with sequential numbering (NNNN-kebab-case.md)
- [x] [AC-007] `docs/context/features/` contains feature specifications with acceptance criteria in checkbox format
- [x] [AC-008] All context files are valid Markdown renderable by GitHub/GitLab without special tooling
- [x] [AC-009] ADRs are append-only — past decisions are never edited; new ADRs supersede when needed
- [x] [AC-010] Context files are referenced from AI entry point files for navigation

## Data Model Changes

None — this is a file structure convention, not a database schema.

## API Contract

Not applicable — the "API" is the directory structure convention:

```
docs/context/
├── requirements.md
├── architecture.md
├── constraints.md
├── glossary.md
├── decisions/
│   └── NNNN-kebab-case-title.md
└── features/
    └── feature-name.md
```

## Non-Functional Requirements

- Context files MUST be readable without special tooling (plain markdown) — see [NFR-U01]
- Files MUST render correctly in GitHub/GitLab markdown preview
- CLAUDE.md MUST be under 80 lines to avoid context window waste — see [NFR-U03]

## Out of Scope

- Content of individual context files (that's project-specific)
- Enforcement tooling (that's CI validation — see FR-042)
- Rendering in IDP (that's Backstage integration — see backstage-integration feature)

## Open Questions

None — this feature is complete.
