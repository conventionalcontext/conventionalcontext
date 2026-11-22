---
type: index
---

# Conventional Context

Keep people aware and in charge of what AI agents build. 

Conventional Context is a schema for [OpenSpec](https://github.com/Fission-AI/OpenSpec) and a folder, `docs/context/`, where people write down a project's purpose, rules, and decisions. Agents check every change against them, and a GitOps workflow makes sure a person approves every change.

This folder is Conventional Context's own `docs/context/`, written with its own schema.

| File | What it tells you |
|---|---|
| [requirements.md](requirements.md) | Why the project exists, who it is for, and how well it must work |
| [constraints.md](constraints.md) | The rules it must follow, and why |
| [architecture.md](architecture.md) | How it is built |
| [decisions/](decisions/) | What was decided, and why |
| [glossary.md](glossary.md) | What its words mean |
| [roadmap.md](roadmap.md) | Where it is heading |

What the schema does is specified in [`openspec/specs/`](../../openspec/specs/); work in progress is in [`openspec/changes/`](../../openspec/changes/).

## Decisions

All decisions are `proposed` until the maintainers approve the first release.

| # | Decision | Status |
|---|---|---|
| [0001](decisions/0001-extend-openspec-with-a-schema.md) | Extend OpenSpec with a schema | proposed |
| [0002](decisions/0002-human-agency-enforced-by-gitops.md) | Human agency, enforced by a GitOps workflow | proposed |
| [0003](decisions/0003-behavior-stays-in-openspec.md) | What the system does stays in OpenSpec | proposed |
| [0004](decisions/0004-decision-records-with-archive.md) | Decision records, with an archive for earlier versions | proposed |
| [0005](decisions/0005-publish-as-plain-markdown.md) | Publish docs/context/ as plain Markdown | proposed |
| [0006](decisions/0006-publish-schema-in-openspec-schemas.md) | Publish the schema where OpenSpec looks for it | proposed |
| [0007](decisions/0007-website-with-zensical.md) | Website with Zensical on GitHub Pages | proposed |
| [0008](decisions/0008-mit-license.md) | MIT license | proposed |
