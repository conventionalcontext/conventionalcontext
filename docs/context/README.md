---
type: index
---

# Conventional Context

Keep people aware and in charge of what AI agents build. An
[OpenSpec](https://github.com/Fission-AI/OpenSpec) schema and the
`docs/context/` convention: people write down a project's purpose, rules, and
decisions, agents check every change against them, and a GitOps workflow
makes sure a person approves every change.

## Contents

| File | What it answers |
|---|---|
| [requirements.md](requirements.md) | Why the project exists, for whom, and how well it must work |
| [constraints.md](constraints.md) | What must always hold, and why |
| [architecture.md](architecture.md) | How it is built |
| [decisions/](decisions/) | What was decided, and why |
| [glossary.md](glossary.md) | Terms with a project-specific meaning |
| [roadmap.md](roadmap.md) | Where it is heading |

What the schema does, capability by capability, is in
[`openspec/specs/`](../../openspec/specs/). Work in progress is in
[`openspec/changes/`](../../openspec/changes/).

## Decisions

| # | Decision | Status |
|---|---|---|
| [0001](decisions/0001-extend-openspec-with-a-schema.md) | Extend OpenSpec with a schema | accepted |
| [0002](decisions/0002-docs-context-for-people.md) | Write docs/context/ for people, not for agent routing | accepted |
| [0003](decisions/0003-own-schema-based-on-spec-driven.md) | Own schema, based on OpenSpec's spec-driven schema | accepted |
| [0004](decisions/0004-madr-with-archive-rule.md) | Decision records in MADR 4, with an archive for previous versions | accepted |
| [0005](decisions/0005-behavior-stays-in-openspec.md) | Behavior stays in OpenSpec; no feature files | accepted |
| [0006](decisions/0006-publish-as-plain-markdown.md) | Publish docs/context/ as plain Markdown, with a TechDocs example | accepted |
| [0007](decisions/0007-website-with-zensical.md) | Website with Zensical on GitHub Pages | accepted |
| [0008](decisions/0008-mit-license.md) | MIT license for the whole repository | accepted |
| [0009](decisions/0009-publish-schema-in-openspec-schemas.md) | Publish the schema at openspec/schemas/conventional-context/; adopters copy it | accepted |
| [0010](decisions/0010-human-agency-enforced-by-gitops.md) | Human agency as the core principle, enforced by a GitOps workflow | accepted |
