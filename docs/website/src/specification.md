---
title: Specification
hide:
  - navigation
---

# Specification (v0.1 draft)

!!! warning "Draft: not yet normative"
    The normative v0.1 text is being written in `spec/v0.1/SPEC.md`. This page
    summarises what it will define, drawn from the project's agreed
    [requirements](https://github.com/conventionalcontext/conventionalcontext/blob/main/docs/context/requirements.md).
    Details may change before v0.1.0 is released.

The key words MUST, MUST NOT, SHOULD, and MAY are to be read as described in
[BCP 14](https://www.rfc-editor.org/info/bcp14) (RFC 2119, RFC 8174) when, and
only when, they appear in uppercase.

## Levels

| Level | Covers | Status |
|---|---|---|
| **Level 1: structure** | Which files exist, where, what they contain, and the frontmatter that makes them machine-checkable | v0.1 |
| **Level 2: provenance** | Where intent came from and how it changed, so readers can trust it | Planned for v0.2 |

A repository can adopt Level 1 on its own.

## Location

An adopting repository MUST keep its project intent in `docs/context/` at the
repository root.

## Files

| Path | Holds | Level 1 |
|---|---|---|
| `README.md` | The index: what the project is, which context files exist, the specification version followed | Required |
| `requirements.md` | What the project must do (functional) and how well (non-functional) | Required |
| `architecture.md` | Scope, solution strategy, building blocks, crosscutting concepts | Required |
| `decisions/` | One record per significant decision | Required |
| `constraints.md` | Technical, organizational, and convention constraints | Recommended |
| `glossary.md` | Terms with a specific meaning in the project | Recommended |
| `roadmap.md` | Now, Next, Later | Recommended |
| `features/` | One file per feature | Recommended, unless a spec-driven development tool tracks features |

A required file MAY be short. A repository can adopt the required files first
and add recommended ones later without restructuring.

## Index

`docs/context/README.md` MUST list the context files present and MUST declare
the specification version it follows in its frontmatter:

```yaml
---
type: index
status: current
conventionalcontext: "0.1"
---
```

## Frontmatter

Every context file MUST start with YAML frontmatter carrying at least `type`
and `status`.

| File | `type` | `status` values |
|---|---|---|
| `README.md` | `index` | `draft`, `current` |
| `requirements.md`, `architecture.md`, `constraints.md`, `glossary.md`, `roadmap.md` | The file's name: `requirements`, `architecture`, ... | `draft`, `current` |
| `decisions/NNNN-*.md` | `decision` | `proposed`, `accepted`, `rejected`, `deprecated` |
| `decisions/archive/*.md` | `decision` | `superseded` |
| `features/*.md` | `feature` | `draft`, `planned`, `in-progress`, `done`, `deprecated` |

Decision records also use the frontmatter fields of
[MADR 4](https://adr.github.io/madr/): `date`, `decision-makers`, and
optionally `consulted` and `informed`.

## Decision records

- Decision records MUST follow [MADR 4](https://adr.github.io/madr/) and be
  named `NNNN-title-in-kebab-case.md`, with sequential four-digit numbers.
- `decisions/` holds only current decisions, so a reader sees what holds
  today.
- When a decision changes, the previous version is moved unchanged to
  `decisions/archive/NNNN-title-YYYY-MM-DD.md` (the date of that version),
  and the current file is updated in place, keeping its number and name. It
  lists its previous versions under `## Previous decisions`.

## Requirements and identifiers

Requirements use a short ID and name, one statement with a BCP 14 keyword,
and optional scenarios:

```markdown
### FR-001: Standard location for project intent

The specification MUST define `docs/context/` as ...

#### Scenario: Agent looks for intent in an unfamiliar repository

- **GIVEN** an adopting repository the agent has never seen
- **WHEN** the agent needs the project's requirements
- **THEN** it finds them at `docs/context/requirements.md`
```

IDs SHOULD be used so that pull requests, commits, and other files can refer
to them: `FR-NNN` (functional requirement), `NFR-NNN` (non-functional
requirement), `C-NNN` (constraint), `SC-NNN` (feature success criterion).
Decision numbers (`NNNN`) are required. IDs are never reused.

## Feature files

A feature file has a status, user scenarios in Given/When/Then form, the
requirements it relates to, and measurable success criteria.

## Agent routing

`AGENTS.md` routes agents to `docs/context/README.md` before they change
anything. No other agent-specific file is required; a tool that reads only
its own file (for example `CLAUDE.md`) MAY get a one-line pointer to
`AGENTS.md`.

`AGENTS.md` SHOULD have a `## Conventions` section declaring choices that
affect how context is written, such as the diagram tool. Agents MUST follow
declared conventions when writing context files.

```markdown
## Conventions

- Diagrams: none | mermaid | d2 | images in assets/
```

## Versioning

The specification is versioned with [SemVer](https://semver.org/). Each
minor version's text is frozen in `spec/vX.Y/SPEC.md` once released. An
adopting repository declares the `MAJOR.MINOR` version it follows in its
index. Through 0.x, a minor version may change the specification
incompatibly.
