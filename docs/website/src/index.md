---
title: Quick Summary
template: home.html
hide:
  - navigation
---

# Quick summary

**Conventional Context** helps you settle what a new project is *for* before
AI coding agents build it: who it is for, what is in and out of scope, the
rules it must work within, how it is built, and the decisions behind it. It
records all of that in `docs/context/`, as plain Markdown, and keeps it
current as the project changes.

It is an [OpenSpec](https://github.com/Fission-AI/OpenSpec) schema, not a new
tool. OpenSpec keeps track of *what the system does*. Conventional Context
adds *why, and within what limits*, without repeating anything OpenSpec
keeps.

## Why it matters

AI coding agents can build a working project from a few prompts. What they
build is only as good as the intent behind it, and that intent usually lives
in the creator's head, or in an agent session only they can see.

- **Review.** A maintainer can check the plan before agents build, and check
  the result against what was intended.
- **Onboarding.** A new person can learn why the project is the way it is.
- **Documentation.** A developer portal (Backstage, Port) can publish the
  project's intent next to its code, because it is in `docs/`.

### Where it fits

<ul class="cc-flow" aria-label="Agentic development stages">
  <li class="cc-flow__here">Intent</li><li class="cc-flow__arrow">→</li>
  <li>Spec</li><li class="cc-flow__arrow">→</li>
  <li>Plan</li><li class="cc-flow__arrow">→</li>
  <li>Build</li><li class="cc-flow__arrow">→</li>
  <li>Test</li><li class="cc-flow__arrow">→</li>
  <li>Deploy</li>
</ul>

| Stage | The question it answers | Where it lives |
|---|---|---|
| **Intent** | Why does this project exist? What must always hold? What was decided, and why? | **`docs/context/` (Conventional Context)** |
| Spec | What exactly does the system do? | `openspec/specs/` (OpenSpec) |
| Plan | How will this change be built? | `openspec/changes/` (OpenSpec) |
| Build, Test | The code and its tests | The agent, reviewed by a person |
| Deploy | Ship it | CI/CD |

## How it works

1. **Inception.** Your first OpenSpec change uses the `conventional-context`
   schema. The agent asks you about the project and writes `docs/context/`.
   You review it before any code is written.
2. **Every later change.** The agent checks the change against your
   constraints and decisions while planning, and asks you about any
   conflict. Anything that outlasts the change (a decision, a constraint, a
   term) becomes a task, so it lands in the same pull request.
3. **Publishing.** `docs/context/` is plain Markdown in `docs/`, so your
   documentation site or developer portal publishes it with the rest.

[More detail](how-it-works.md)

## What goes where

```text
docs/context/
  README.md          index: what the project is, and links to everything below
  requirements.md    purpose, users, scope, quality requirements
  constraints.md     rules the project must work within, and why
  architecture.md    the main parts and how they fit together
  decisions/         one record per significant decision
  glossary.md        terms with a project-specific meaning
  roadmap.md         Now / Next / Later, linking to OpenSpec changes
openspec/
  specs/             what the system does (OpenSpec)
  changes/           work in progress (OpenSpec)
```

Each fact is written once. `docs/context/` links to `openspec/specs/` instead
of copying behavior.

## Get started

The schema is being written and is not released yet. The intended setup:

1. Install [OpenSpec](https://github.com/Fission-AI/OpenSpec) and run
   `openspec init` in your repository.
2. Copy `schema/conventional-context/` from the
   [repository](https://github.com/conventionalcontext/conventionalcontext)
   into `openspec/schemas/conventional-context/`.
3. Set `schema: conventional-context` in `openspec/config.yaml`.
4. Ask your agent to propose the first change, for example
   `/openspec-propose inception`, and review `docs/context/` before you build.

## FAQ

??? question "Do agents read docs/context/ on every task?"
    No. Studies of repository context files found that general overviews do
    not help agents and add cost
    ([Gloaguen et al., 2026](https://arxiv.org/abs/2602.11988)). The schema
    has agents read only your constraints and decisions, and only when they
    plan a change, because those are rules they cannot infer from the code.
    The rest of `docs/context/` is written for people.

??? question "Do I need OpenSpec?"
    Yes. Conventional Context extends OpenSpec rather than replacing it.
    Support for other tools (a Spec Kit extension, a Kiro steering file) is
    on the roadmap.

??? question "Does it duplicate OpenSpec's specs?"
    No. Behavior stays in `openspec/specs/`. `docs/context/` holds what
    OpenSpec does not: purpose, scope, quality requirements, constraints,
    architecture, decisions, terms, and the roadmap.

??? question "Is it only for new projects?"
    It is designed for the start of a project, when intent is easiest to
    settle and review. You can run the inception change on an existing
    repository too; the agent will ask about what is already there.
