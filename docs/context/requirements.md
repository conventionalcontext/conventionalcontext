---
type: requirements
status: current
---

# Requirements

## Purpose

Code says what a system does, not why. The intent behind it (requirements,
constraints, decisions, direction) usually lives in people's heads, wikis,
chat threads, and tickets, which drift away from the code and are invisible
to AI coding agents. Agents start every session knowing only what is in the
repository and the prompt, so they guess, ask, repeat settled debates, and
break unwritten rules.

In agent-assisted development, work moves through the stages
**Intent → Spec → Plan → Build → Test → Deploy**, with agents doing more of
each stage. Spec-driven development tools (Spec Kit, OpenSpec, Kiro) cover
Spec to Build, one feature at a time. Every feature spec relies on the
project's intent, but no common convention says where that intent lives.

Conventional Context is a specification for keeping that intent in the
repository, in a predictable place and shape, readable by people, readable by
agents, and checkable by machines. When intent is written down there:

- agents need fewer prompts and clarifications to build the right thing;
- the person who declared the intent and the agents that build it use the
  same words with the same meaning;
- new maintainers and users of the project get its full intent and decision
  history in one place.

It aims to do for project intent what
[Conventional Commits](https://www.conventionalcommits.org/) did for commit
messages.

## Audience

- **Primary:** any team that works on a git repository with AI coding agents.
- **First focus:** platform engineering repositories (infrastructure as code,
  GitOps, cloud foundations). The first profile and the first example target
  them.
- **Also:** maintainers of spec-driven development tools (Spec Kit, OpenSpec)
  whose users want project-wide intent next to feature specs.

## How to read this file

- **Functional requirements (`FR-NNN`)** say *what* the specification and
  this repository must provide.
- **Non-functional requirements (`NFR-NNN`)** say *how well* they must do it:
  qualities such as readability, compatibility, and security, rather than
  features.
- **MUST**, **SHOULD**, and **MAY** in uppercase are
  [BCP 14](glossary.md) keywords: MUST is required, SHOULD is expected unless
  there is a good reason not to, MAY is optional.
- A **scenario** is a concrete example written as **GIVEN** a situation,
  **WHEN** something happens, **THEN** the expected outcome.

The format is set in [decision 0007](decisions/0007-requirement-format.md).
"The specification" means the Conventional Context specification text
(`spec/`). "An adopting repository" means any repository that follows it.
Unfamiliar terms are in the [glossary](glossary.md).

## Functional requirements

### FR-001: Standard location for project intent

The specification MUST define `docs/context/` at the repository root as the
one place where an adopting repository keeps its project intent.

#### Scenario: Agent looks for intent in an unfamiliar repository

- **GIVEN** an adopting repository the agent has never seen
- **WHEN** the agent needs the project's requirements
- **THEN** it finds them at `docs/context/requirements.md` without searching

### FR-002: Core files required at Level 1

The specification MUST require these at Level 1: `docs/context/README.md`,
`requirements.md`, `architecture.md`, and the `decisions/` directory. A
required file MAY be short.

### FR-003: Recommended files

The specification MUST name `constraints.md`, `glossary.md`, `roadmap.md`, and
the `features/` directory as recommended, so a repository can adopt the core
first and add the rest over time. `features/` is recommended only where no
spec-driven development tool manages feature specs; where one does, the
repository SHOULD NOT use `features/` and `roadmap.md` SHOULD link to the
tool's feature specs instead
([decision 0017](decisions/0017-feature-files-and-sdd-tools.md)).

### FR-004: Index file

`docs/context/README.md` MUST list the context files present in the
repository and MUST declare, in its frontmatter, the specification version the
directory follows.

#### Scenario: Agent checks which version of the specification applies

- **GIVEN** an adopting repository
- **WHEN** an agent reads `docs/context/README.md`
- **THEN** its frontmatter states the version, e.g. `conventionalcontext: "0.1"`

### FR-005: Minimal frontmatter

Every context file MUST start with YAML frontmatter carrying at least `type`
and `status`. Decision records MUST use the frontmatter fields of MADR 4. See
[decision 0006](decisions/0006-minimal-yaml-frontmatter.md).

### FR-006: Decision records

Decision records MUST follow [MADR 4](https://adr.github.io/madr/) and be
named `NNNN-title-in-kebab-case.md` with sequential four-digit numbers.
`decisions/` MUST hold only current decisions. When a decision changes, its
previous version MUST be moved to `decisions/archive/` with its date in the
file name, and the current file MUST list it under `## Previous decisions`.
See [decision 0015](decisions/0015-archive-previous-decisions.md).

#### Scenario: Reader checks why a decision changed

- **GIVEN** a decision that was changed after it was accepted
- **WHEN** a reader opens it in `decisions/`
- **THEN** they see the decision that holds today, with links to each
  previous version in `decisions/archive/`

### FR-007: Identifiers

Requirements SHOULD carry IDs (`FR-NNN`, `NFR-NNN`), constraints SHOULD carry
IDs (`C-NNN`), and feature success criteria SHOULD carry IDs (`SC-NNN`), so
they can be referenced from pull requests, commits, and other files.

### FR-008: Feature specifications

The specification MUST define a feature file format with a status
(`draft`, `planned`, `in-progress`, `done`, `deprecated`), user scenarios in
Given/When/Then form, the requirements it relates to, and measurable success
criteria. Feature files are for repositories without a spec-driven
development tool (FR-003).

### FR-009: Agent routing

The specification MUST define how `AGENTS.md` routes agents to
`docs/context/README.md`, and MUST NOT require any other agent-specific file.
Tool-specific files (for example `CLAUDE.md`) MAY point to `AGENTS.md`.

#### Scenario: Agent that reads AGENTS.md starts a session

- **GIVEN** an adopting repository with an `AGENTS.md`
- **WHEN** an agent starts a session and reads `AGENTS.md`
- **THEN** it is directed to `docs/context/README.md` before it changes anything

### FR-010: Declared conventions

`AGENTS.md` SHOULD have a `## Conventions` section where a repository declares
its choices that affect how context files are written, such as the diagram
tool (`none`, `mermaid`, `d2`, or images). Agents MUST follow declared
conventions when writing context files.

### FR-011: Templates

The repository MUST provide blank templates of every context file under
`templates/docs/context/`, mirroring where they go in an adopting repository.

### FR-012: Machine-checkable frontmatter

The repository MUST publish a JSON Schema for context-file frontmatter, with
an `$id` under `https://conventionalcontext.org/`.

### FR-013: Adapters for existing tools

The repository SHOULD document how Conventional Context sits alongside
`AGENTS.md`, GitHub Spec Kit, and OpenSpec, without replacing or duplicating
their files.

### FR-014: Profiles

The repository SHOULD provide profiles: opinions for a kind of project. The
first profile MUST cover platform engineering.

### FR-015: Optional upgrade path

The project SHOULD offer adopters an optional way to bring an existing
`docs/context/` up to a newer specification version, for example by giving
agents a per-file-type specification and a prompt or skill that shows the
changes an upgrade would make. Upgrading MUST NOT be required.

### FR-016: Dogfooding

This repository MUST keep its own intent in `docs/context/`, following the
current specification version, and MUST update it in step with the
specification.

### FR-017: Project website

The project SHOULD publish a website at `conventionalcontext.org` with a
quick summary (what Conventional Context is, why it matters, and how to start),
the specification, and how to contribute. See
[decision 0016](decisions/0016-project-website.md).

#### Scenario: Someone hears about the project for the first time

- **GIVEN** a person new to agent-assisted development
- **WHEN** they open conventionalcontext.org
- **THEN** within a few minutes they understand what it is, why it matters,
  and how to apply it to a repository

## Non-functional requirements

Grouped by the quality characteristics of ISO/IEC 25010:2023 (former names in
parentheses). See [decision 0008](decisions/0008-partial-arc42-alignment.md).

### Interaction capability (usability)

#### NFR-001: Readable without tooling

Context files MUST be plain Markdown with YAML frontmatter, readable in any
editor and rendered correctly by GitHub and GitLab.

#### NFR-002: Fits in an agent's context window

The index and each context file SHOULD be short enough that an agent can read
the index plus the files relevant to one task without crowding out the code.

#### NFR-003: Cheap to keep current

Updating context for a typical pull request SHOULD take a few minutes, so it
happens in the same pull request as the change.

#### NFR-004: Incremental adoption

A repository MUST be able to adopt the Level 1 core first and add recommended
files later without restructuring.

### Compatibility

#### NFR-005: Tool-agnostic

The specification MUST work with any agent that can read `AGENTS.md` or plain
Markdown, and MUST NOT depend on a specific agent, editor, or vendor.

#### NFR-006: Coexists with spec-driven development tools

`docs/context/` MUST NOT conflict with the directories of Spec Kit
(`.specify/` and `specs/`), OpenSpec (`openspec/`), or Kiro (`.kiro/`), and
MUST NOT require the same feature to be specified both in `docs/context/`
and in one of those tools.

### Flexibility (portability)

#### NFR-007: Any git host

The specification MUST work on any git host (GitHub, GitLab, Bitbucket, or
self-hosted) and MUST NOT require an external service beyond git.

#### NFR-008: Optional tooling

Reading and writing context MUST NOT require any tool. Tooling (templates
copier, linter) MAY exist but MUST stay optional.

### Maintainability

#### NFR-009: Versioned and documented changes

The specification MUST be versioned with SemVer, and every change MUST be
recorded in `CHANGELOG.md`. See [decision 0013](decisions/0013-versioning.md).

#### NFR-010: Built on existing conventions

The specification SHOULD reuse existing community conventions with moderate
to good adoption instead of inventing new ones. See
[decision 0003](decisions/0003-align-with-existing-conventions.md).

### Security

#### NFR-011: No secrets

Context files MUST NOT contain secrets, credentials, or personal data beyond
public handles.

## Out of scope

- Ticket or backlog management on the main branch (an in-git ticket system is
  parked; see [roadmap.md](roadmap.md))
- BMAD Method compatibility
- Backstage, TechDocs, and IDP catalog integration
- Generating code from specifications (that is what spec-driven development
  tools do)
- Hosting or rendering adopters' context files (git hosts render Markdown;
  this project's own website is FR-017)
- IDE plugins or editor extensions
