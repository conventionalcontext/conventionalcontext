---
type: index
status: current
conventionalcontext: "0.1"
---

# Conventional Context: project context

This directory holds the intent of the Conventional Context project: what it
must do, what it must work within, how it is built, the decisions behind it,
and where it is heading. It follows the Conventional Context specification
itself (version 0.1, shown in the frontmatter above), so it is also the
reference example of a `docs/context/` directory.

People and AI agents should read this file first, then the files below that
are relevant to the task.

**New to this?** Conventional Context covers the first stage of agent-assisted
development, **Intent** → Spec → Plan → Build → Test → Deploy: writing down
what a project is for, so that people and AI coding agents build the same
thing. The [quick summary](https://conventionalcontext.org/) explains it in a
few minutes, and the [glossary](glossary.md) explains every term used here.

## Files

In reading order, which is also the order to fill them in when starting out.
File names carry no numbers, so links stay stable if the order changes.

| # | File | What it holds | Read when | Required at Level 1 |
|---|---|---|---|---|
| 1 | README.md (this file) | Index: files present, specification version, conventions | Always, first | Yes |
| 2 | [requirements.md](requirements.md) | What the specification and this repository must provide (FR-NNN, NFR-NNN) | Starting any work, to know what must hold | Yes |
| 3 | [constraints.md](constraints.md) | Technical, organizational, and convention constraints (C-NNN) | Before designing or changing anything | Recommended |
| 4 | [architecture.md](architecture.md) | Scope, solution strategy, building blocks, crosscutting concepts | Before changing structure or adding a building block | Yes |
| 5 | [decisions/](decisions/) | Decision records, MADR 4 format, numbered `NNNN-title.md` | When asking why something is the way it is, or before reversing it | Yes |
| 6 | [features/](features/) | One file per feature: scenarios, requirements, success criteria, status | When working on a specific feature | Recommended |
| 7 | [roadmap.md](roadmap.md) | Now, Next, Later, Parked, and Out of scope | When choosing what to work on next, or checking whether something is planned | Recommended |
| 8 | [glossary.md](glossary.md) | Terms with a specific meaning in this project | Whenever a term is unclear; grows alongside the other files | Recommended |

## Decisions

Each decision record answers one question in the same order: the **context
and problem**, the **options considered**, the **decision** and why, and its
**consequences** (good and bad). `decisions/` holds only decisions that apply
today. When a decision changes, its previous version moves to
[decisions/archive/](decisions/archive/) and is listed at the end of the
current record ([0015](decisions/0015-archive-previous-decisions.md)).

| # | Decision | In short | Status |
|---|---|---|---|
| [0001](decisions/0001-record-decisions-with-madr.md) | Record decisions with MADR 4 | Use the most common decision-record template instead of our own. | accepted |
| [0002](decisions/0002-grow-out-of-harc.md) | Grow Conventional Context out of HARC | Start fresh from the internal HARC framework; keep what worked, drop the rest. | accepted |
| [0003](decisions/0003-align-with-existing-conventions.md) | Align with existing community conventions | Reuse formats people and agents already know; invent only where nothing exists. | accepted |
| [0004](decisions/0004-keep-intent-in-docs-context.md) | Keep project intent in `docs/context/` | One fixed, visible folder; four files required, the rest recommended. | accepted |
| [0005](decisions/0005-route-agents-through-agents-md.md) | Route agents through AGENTS.md | One open entry file for every agent, instead of one file per tool. | accepted |
| [0006](decisions/0006-minimal-yaml-frontmatter.md) | Minimal YAML frontmatter | Two fields, `type` and `status`, so tools can check files. | accepted |
| [0007](decisions/0007-requirement-format.md) | Requirement and scenario format | IDs from Spec Kit, headings from OpenSpec, Given/When/Then scenarios. | accepted |
| [0008](decisions/0008-partial-arc42-alignment.md) | Partial arc42 alignment | Borrow only the arc42 sections that fit. | accepted |
| [0009](decisions/0009-no-prescribed-diagram-tool.md) | No prescribed diagram tool | Diagrams optional; each repository names its tool in AGENTS.md. | accepted |
| [0010](decisions/0010-license-by-directory.md) | License by directory | Spec CC-BY-4.0, templates CC0-1.0, everything else Apache-2.0. | accepted |
| [0011](decisions/0011-repository-layout.md) | Repository layout | Where each part of this repository lives. | accepted |
| [0012](decisions/0012-defer-level-2-provenance.md) | Defer Level 2 provenance to 0.2 | Settle the structure first; tracing where intent came from comes later. | accepted |
| [0013](decisions/0013-versioning.md) | Versioning of releases and specification text | SemVer releases; each minor version's spec text is frozen once released. | accepted |
| [0014](decisions/0014-changelog-and-release-automation.md) | Changelog and release automation | Open: generate the changelog and automate releases, or keep them manual? | proposed |
| [0015](decisions/0015-archive-previous-decisions.md) | Keep only current decisions; archive previous versions | `decisions/` shows what holds today; history moves to `archive/`. | accepted |
| [0016](decisions/0016-project-website.md) | Project website with Zensical | conventionalcontext.org built from `docs/website/`, hosted on GitHub Pages. | accepted |
| [0017](decisions/0017-feature-files-and-sdd-tools.md) | Feature files only without an SDD tool | With Spec Kit, OpenSpec, or Kiro, features live in the tool; `docs/context/` keeps project-wide intent. | accepted |
| [0018](decisions/0018-agent-skills-for-context-actions.md) | Agent Skills for context actions | A standing rule in `AGENTS.md`, plus skills in `.agents/skills/` for new decisions, new features, and context checks. | proposed |

## Features

Each feature file has a **status**, **scenarios** that show it in use,
the **requirements** it serves, and **success criteria** that show it is done.
This project uses no spec-driven development tool, so it keeps feature files
here ([decision 0017](decisions/0017-feature-files-and-sdd-tools.md)).

| Feature | Status |
|---|---|
| [Context structure (Level 1)](features/context-structure.md) | in-progress |
| [Agent routing via AGENTS.md](features/agent-routing.md) | in-progress |
| [Project website](features/website.md) | in-progress |
| [Frontmatter and schema](features/frontmatter-schema.md) | planned |
| [Templates](features/templates.md) | planned |
| [Adapters](features/adapters.md) | planned |
| [Platform profile](features/platform-profile.md) | planned |
| [Init](features/init.md) | draft |
| [Lint](features/lint.md) | draft |
| [Provenance (Level 2)](features/provenance.md) | draft |
| [Agent skills](features/agent-skills.md) | draft |

## Conventions used here

- Requirement keywords (MUST, SHOULD, MAY, ...) follow BCP 14
  ([RFC 2119](https://www.rfc-editor.org/rfc/rfc2119),
  [RFC 8174](https://www.rfc-editor.org/rfc/rfc8174)) when in uppercase.
- Diagrams: none in 0.1 (see [0009](decisions/0009-no-prescribed-diagram-tool.md)).
- Update these files in the same pull request as the change they describe.
