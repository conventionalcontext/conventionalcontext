# Conventional Context

**Write down what a project is for before agents build it, and keep it where
people can read it.**

Conventional Context is an [OpenSpec](https://github.com/Fission-AI/OpenSpec)
schema and a small folder convention, `docs/context/`. When you start a new
project, it helps you settle and record the project's requirements,
constraints, architecture, and decisions. Then you let AI coding agents build
it. As the project changes, it keeps that record current.

> **Status:** early. The schema and templates are being written in this
> repository and are not released yet. See the [changelog](CHANGELOG.md).

## Why

AI coding agents can build a working project from a few prompts. What they
build is only as good as the intent behind it, and that intent usually lives
in the creator's head or in an agent session that nobody else can see. That
causes three problems:

- **Review.** A maintainer cannot check that the plan is right before agents
  start building, or check the result against what was intended.
- **Onboarding.** A new person cannot learn why the project is the way it is.
- **Documentation.** An internal developer portal has nothing to show about
  the project beyond its code.

Conventional Context puts that intent in `docs/context/`, as plain Markdown,
written for people: maintainers, reviewers, newcomers, and the portal that
publishes a repository's `docs/`.

It does **not** try to make agents better by giving them more to read.
Studies of repository context files found that general overviews do not help
agents and add cost
([Gloaguen et al., 2026](https://arxiv.org/abs/2602.11988)). So agents are not
told to read `docs/context/` for every task. The schema has them check
constraints and decisions only when they plan a change, because those are
project-specific rules that cannot be inferred from the code.

## How it works

OpenSpec already manages **what the system does**: one spec per capability in
`openspec/specs/`, and one folder per change in `openspec/changes/`.
Conventional Context adds **why, and within what limits**, without repeating
anything OpenSpec keeps.

1. **Inception.** Your first OpenSpec change uses the `conventional-context`
   schema. It asks about the project and writes `docs/context/`: purpose and
   users, constraints, architecture, decisions, terms, and roadmap. You review
   it before any code is written. The first behavior specs go to
   `openspec/specs/` as usual.
2. **Every later change.** The schema checks the change against
   `constraints.md` and `decisions/` while planning. It adds to
   `docs/context/` only what outlasts the change: a new decision, constraint,
   or term, or a roadmap update.
3. **Publishing.** `docs/context/` is plain Markdown, so a documentation site
   or developer portal (for example Backstage TechDocs) can publish it with
   the rest of `docs/`.

## What goes where

```text
docs/context/
  README.md          index: what the project is, and links to everything below
  requirements.md    purpose, users, scope, quality requirements
  constraints.md     rules the project must work within, and why
  architecture.md    the main parts and how they fit together
  decisions/         one record per significant decision (MADR)
  glossary.md        terms with a project-specific meaning
  roadmap.md         Now / Next / Later, linking to OpenSpec changes
openspec/
  specs/             what the system does: behavior, with scenarios (OpenSpec)
  changes/           work in progress, one folder per change (OpenSpec)
```

| Question | Answered in |
|---|---|
| Why does this project exist, and for whom? | `docs/context/requirements.md` |
| What must always hold? | `docs/context/constraints.md` |
| How is it built? | `docs/context/architecture.md` |
| What was decided, and why? | `docs/context/decisions/` |
| What does the system do? | `openspec/specs/` |
| What is being changed right now? | `openspec/changes/` |

Each fact is written once. `docs/context/` links to `openspec/specs/` instead
of copying behavior. When a decision changes, its record is updated in place
and the previous version moves to `decisions/archive/`, so `decisions/` shows
only what holds today.

## Getting started

Not released yet. The intended setup:

1. Install OpenSpec and run `openspec init` in your repository.
2. Copy `schema/conventional-context/` from this repository into
   `openspec/schemas/conventional-context/`. It holds the schema, its
   artifact templates, and the blank `docs/context/` files (`docs-context/`)
   that the first change fills in.
3. Set `schema: conventional-context` in `openspec/config.yaml`.
4. Ask your agent to propose the first change, for example
   `/openspec-propose inception`, and review `docs/context/` before you build.

## Contributing

Issues and pull requests are welcome. See [AGENTS.md](AGENTS.md) for the
conventions this repository follows.

## License

[MIT](LICENSE).
