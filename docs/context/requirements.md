---
type: requirements
status: draft
---

# Requirements

## Purpose

Keep people aware and in charge of what AI agents build. AI coding agents
can write most of a project's code, but the intent behind it often stays in
one person's head or in an agent session nobody else can see. Conventional
Context has people write that intent down and review it before agents
build; agents check every change against it and ask when something
conflicts; and a GitOps workflow makes sure a person approves every change
([0002](decisions/0002-human-agency-enforced-by-gitops.md)).

## Users

| Who | What they need |
|---|---|
| People starting a new project with AI agents | A guided way to settle what the project is for before agents build |
| Teams whose existing project agents work on | A drafted record of the project's intent to confirm, so agents follow what people decided |
| Maintainers and reviewers | To check the plan before agents build, and the result after |
| Newcomers | To learn why the project is the way it is |
| Teams running a developer portal (Backstage, Port) | The project's intent, in Markdown, to publish next to its code |
| OpenSpec users | An add-on, not a new tool |

Decisions about Conventional Context are made by its maintainers,
andreouellet and hamed-minaee.

## Scope

**In scope:** the `conventional-context` schema for OpenSpec and its
templates; the `docs/context/` folder and its rules; a Backstage TechDocs
example; the conventionalcontext.org website.

**Out of scope:**

- Telling agents to read `docs/context/` for every task
  ([0002](decisions/0002-human-agency-enforced-by-gitops.md))
- Describing what the system does; OpenSpec does that
  ([0003](decisions/0003-behavior-stays-in-openspec.md))
- A separate tool, or a fork of OpenSpec
  ([0001](decisions/0001-extend-openspec-with-a-schema.md))

## Quality requirements

| ID | Requirement | How it is checked |
|---|---|---|
| NFR-001 | The schema works with the latest OpenSpec release. | `openspec schema validate conventional-context` passes |
| NFR-002 | When planning a change, agents read from `docs/context/` only the rules, the accepted decisions, and the glossary terms they need. | Review of the schema's instructions |
| NFR-003 | A filled-in `docs/context/` builds with Backstage TechDocs without errors. | `mkdocs build` with `mkdocs-techdocs-core` and `examples/techdocs/mkdocs.yml` |

## What the system does

See [`openspec/specs/`](../../openspec/specs/).
