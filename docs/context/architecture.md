---
type: architecture
status: current
---

# Architecture

Conventional Context is a specification, not an application. Its
"architecture" is the set of documents, schemas, templates, and optional
tools in this repository, and how adopting repositories, people, and agents
use them. The sections follow arc42 sections 3, 4, 5, and 8
([decision 0008](decisions/0008-partial-arc42-alignment.md)). There are no
diagrams in 0.1 ([decision 0009](decisions/0009-no-prescribed-diagram-tool.md)).

## Context and scope (arc42 section 3)

### Inside the scope

- The specification text: what an adopting repository's `docs/context/` and
  `AGENTS.md` must and should contain.
- The frontmatter schema, templates, profiles, adapters, and examples that
  make the specification easy to adopt and check.
- Optional tooling: a scaffold and a linter.
- This repository's own `docs/context/`.
- The project website, conventionalcontext.org.

### Outside the scope

- Generating or running code (spec-driven development tools do that).
- Storing tickets or backlogs (parked; see [roadmap.md](roadmap.md)).
- Hosting or rendering adopters' context (git hosts render Markdown).

### Who and what interacts with it

| Party | Interaction |
|---|---|
| Maintainers | Write and version the specification, decide changes through decision records. |
| Adopting teams | Copy the templates into their repository, fill them in, and keep them current in pull requests. |
| AI coding agents | Read `AGENTS.md`, then `docs/context/README.md` and the files relevant to the task; update context files as part of a change. |
| SDD tools (Spec Kit, OpenSpec, Kiro) | Keep their own feature-level specs in their own directories; adapters describe how those relate to `docs/context/`. |
| Git hosts (GitHub, GitLab, ...) | Store and render context files; run optional checks in CI. |
| Newcomers | Read the website's quick summary to learn what Conventional Context is and how to start. |
| Linter (planned) | Checks an adopting repository's context files against the specification and schema. |

## Solution strategy (arc42 section 4)

The fundamental choices, each with its decision record:

| Choice | Why | Decision |
|---|---|---|
| A fixed location and file set, `docs/context/` | Predictability: whoever has seen one adopting repository knows where to look in the next. | [0004](decisions/0004-keep-intent-in-docs-context.md) |
| Plain Markdown with minimal YAML frontmatter | Readable by people and agents without tools; checkable by machines. | [0006](decisions/0006-minimal-yaml-frontmatter.md) |
| Reuse existing conventions | Less to learn; works with what teams already use (MADR, BCP 14, Spec Kit and OpenSpec formats, arc42 sections, AGENTS.md, SemVer). | [0003](decisions/0003-align-with-existing-conventions.md) |
| One entry file, `AGENTS.md` | One open format most agents already read, instead of one file per tool kept in sync. | [0005](decisions/0005-route-agents-through-agents-md.md) |
| Convention first, tooling optional | Adoption must not depend on installing anything. | [0004](decisions/0004-keep-intent-in-docs-context.md) |
| Grow in versions, dogfood each one | This repository's own `docs/context/` evolves with the specification and proves it works. | [0013](decisions/0013-versioning.md) |

## Building blocks (arc42 section 5)

The parts of this repository. Each is added when it is ready; nothing is
created ahead of its content.

| Building block | Path | Purpose | License | Status |
|---|---|---|---|---|
| Specification | `spec/vX.Y/SPEC.md` | The normative text, one directory per minor version | CC-BY-4.0 | planned |
| Schema | `schema/` | JSON Schema for context-file frontmatter | Apache-2.0 | planned |
| Templates | `templates/docs/context/` | Blank context files that adopters copy | CC0-1.0 | planned |
| Profiles | `profiles/` | Opinions for a kind of project, platform engineering first | CC-BY-4.0 | planned |
| Adapters | `adapters/` | How Conventional Context sits alongside AGENTS.md, Spec Kit, OpenSpec | CC-BY-4.0 | planned |
| Examples | `examples/` | Filled-in `docs/context/` directories | Apache-2.0 | planned |
| Tools | `tools/` | Optional scaffold (init) and linter | Apache-2.0 | draft |
| Skills | `skills/` | Optional Agent Skills for context actions ([0018](decisions/0018-agent-skills-for-context-actions.md), proposed) | CC0-1.0 | draft |
| Project context | `docs/context/` | This project's own intent (dogfood) | Apache-2.0 | exists |
| Website | `docs/website/` | conventionalcontext.org, built with Zensical ([0016](decisions/0016-project-website.md)) | Apache-2.0 | exists |
| Agent entry file | `AGENTS.md` | Routes agents to `docs/context/` | Apache-2.0 | exists |

How they relate:

- The **specification** is the source of truth. The **schema** encodes its
  frontmatter rules; the **templates** are its blank form; the **linter**
  checks repositories against both.
- **Profiles** add opinions on top of the specification; they never
  contradict it.
- **Adapters** map other tools' files to the specification; they never
  redefine it.
- **Examples** and this repository's **project context** show the
  specification filled in.
- The **website** explains the specification to newcomers; it never adds
  rules of its own.

An adopting repository receives only the template files (and, if it
chooses, a linter run in CI):

```
adopting-repo/
  AGENTS.md                 routes agents to docs/context/README.md
  docs/
    context/
      README.md             index; declares the specification version
      requirements.md       required
      architecture.md       required
      decisions/            required
      constraints.md        recommended
      glossary.md           recommended
      roadmap.md            recommended
      features/             recommended, unless an SDD tool tracks features
```

## Crosscutting concepts (arc42 section 8)

Rules that apply across every building block.

### Frontmatter

Every context file starts with YAML frontmatter with `type` and `status`.
Decision records use MADR 4's fields (`status`, `date`, `decision-makers`,
...) plus `type: decision`. The index also declares the specification version
(`conventionalcontext: "0.1"`). See
[0006](decisions/0006-minimal-yaml-frontmatter.md).

| File | `type` | `status` values |
|---|---|---|
| `README.md` | `index` | `draft`, `current` |
| `requirements.md`, `architecture.md`, `constraints.md`, `glossary.md`, `roadmap.md` | the file's name: `requirements`, `architecture`, ... | `draft`, `current` |
| `decisions/NNNN-*.md` | `decision` | `proposed`, `accepted`, `rejected`, `deprecated` |
| `decisions/archive/NNNN-*-YYYY-MM-DD.md` | `decision` | `superseded` |
| `features/*.md` | `feature` | `draft`, `planned`, `in-progress`, `done`, `deprecated` |

### Identifiers

`FR-NNN` and `NFR-NNN` for requirements, `C-NNN` for constraints, `SC-NNN` for
feature success criteria, `NNNN` for decisions. Decision numbers are required;
the others are recommended. IDs are never reused.

### Requirement language

BCP 14 keywords in uppercase, requirement and scenario format per
[0007](decisions/0007-requirement-format.md).

### Conventions declared in AGENTS.md

Choices that affect how context is written, such as the diagram tool, are
declared in the `## Conventions` section of `AGENTS.md`, and agents follow
them. See [0005](decisions/0005-route-agents-through-agents-md.md).

### Versioning

The specification and this repository are released together with SemVer.
Each minor version's specification text is frozen in `spec/vX.Y/`. See
[0013](decisions/0013-versioning.md).

### Licensing

By directory, stated in the README's License section. See
[0010](decisions/0010-license-by-directory.md).

### Keeping context current

Context changes go in the same pull request as the change they describe
(C-027). When a decision changes, its previous version is archived in
`decisions/archive/` and the current file links to it (C-023,
[0015](decisions/0015-archive-previous-decisions.md)).
