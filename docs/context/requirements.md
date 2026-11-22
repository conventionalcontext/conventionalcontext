---
type: requirements
status: current
---

# Requirements

## Purpose

AI coding agents can build a working project from a few prompts, but what
they build is only as good as the intent behind it, and that intent usually
stays in the creator's head or in an agent session no one else can see.
Conventional Context helps people settle a new project's intent before
agents build it, and keeps it current and readable for maintainers,
reviewers, newcomers, and developer portals. It works as an OpenSpec schema
and adds what OpenSpec does not keep, without repeating what it does.

## Users and stakeholders

| Who | What they need from it |
|---|---|
| Project creators starting a new repository with AI agents | A guided way to settle intent before agents build |
| Maintainers and reviewers | To check the plan before the build, and agent output against intent |
| Newcomers to a project | To learn why the project is the way it is |
| Platform teams running a developer portal (Backstage, Port) | Plain-Markdown project intent to publish next to each repository |
| OpenSpec users | An add-on schema, not a new tool |

Decisions about this project are made by its maintainers, andreouellet and
Hamed Minaee. A change reaches `main` through a pull request approved by a
maintainer other than its author (C-008).

## Scope

**In scope:**

- The `conventional-context` OpenSpec schema and its templates
- The `docs/context/` convention, including the decision archive rule
- Publishing examples (Backstage TechDocs)
- The conventionalcontext.org website

**Out of scope:**

- Routing agents to `docs/context/` through `AGENTS.md`
  ([0002](decisions/0002-docs-context-for-people.md))
- Behavior specs and feature files; OpenSpec owns them
  ([0005](decisions/0005-behavior-stays-in-openspec.md))
- A separate CLI or tool, or a fork of OpenSpec
  ([0001](decisions/0001-extend-openspec-with-a-schema.md))
- A convention for agent skill directories (`openspec init` already installs
  skills for each agent)
- Making Spec Kit, OpenSpec, and Kiro interchangeable
- Portal-specific files beyond examples

## Quality requirements

| ID | Requirement | How it is checked |
|---|---|---|
| NFR-001 | The schema is valid for the latest OpenSpec release. | `openspec schema validate conventional-context` passes |
| NFR-002 | In a change (not inception), the agent reads at most `constraints.md`, the current decision records, and the glossary terms the change uses from `docs/context/`. | Review of the schema's `context` instruction; observed in test changes |
| NFR-003 | A filled-in `docs/context/` builds with Backstage TechDocs without errors. | `mkdocs build` with `mkdocs-techdocs-core` and `examples/techdocs/mkdocs.yml` |

## Behavior

What the schema does is specified per capability in
[`openspec/specs/`](../../openspec/specs/).
