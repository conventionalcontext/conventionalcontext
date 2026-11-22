---
title: How it works
hide:
  - navigation
---

# How it works

Conventional Context is an OpenSpec schema named `conventional-context`. It
is OpenSpec's default `spec-driven` workflow with one extra step, `context`,
between the proposal and the specs:

<ul class="cc-flow" aria-label="Schema steps">
  <li>proposal</li><li class="cc-flow__arrow">→</li>
  <li class="cc-flow__here">context</li><li class="cc-flow__arrow">→</li>
  <li>specs</li><li class="cc-flow__arrow">→</li>
  <li>design</li><li class="cc-flow__arrow">→</li>
  <li>tasks</li>
</ul>

Every other step is OpenSpec's own, unchanged except for a few lines that
connect it to `docs/context/`.

## Inception: the first change

When `docs/context/` does not exist yet, the `context` step:

1. Copies the templates into `docs/context/`.
2. Asks you, a few questions at a time, about users and stakeholders, scope,
   measurable quality requirements, constraints and the reason for each, the
   main architecture choices, and project-specific terms. It does not guess:
   a wrong constraint is worse than a missing one.
3. Fills in the files, and records each choice you have already made
   (language, platform, hosting) as a decision.
4. Links to `openspec/specs/` and to the change instead of restating
   behavior.
5. Asks you to review `docs/context/` before the specs, design, and tasks
   are written.

## Every later change

When `docs/context/` exists, the `context` step:

1. Reads only `constraints.md`, the current decision records, and the
   glossary terms the change uses.
2. Lists, in the change's `context.md`, the constraints and decisions that
   apply.
3. Stops and asks you about any conflict: change the proposal, or change the
   constraint or decision.
4. Lists what outlasts the change. The tasks step turns each item into a task
   in a final "Context updates" group, so the updates land in the same pull
   request as the code, and are reviewed with it.

In the design step, a decision that will guide future changes is marked
"(record)" and becomes a decision record. Decisions that only matter for one
change stay in that change's `design.md`.

## Decision records

Decisions use [MADR 4](https://adr.github.io/madr/), one file per decision in
`docs/context/decisions/`. When a decision changes:

1. The current file moves, unchanged and with status `superseded`, to
   `decisions/archive/NNNN-title-YYYY-MM-DD.md`.
2. The original file is updated in place, so links to it keep working.
3. It lists the archived version under `## Previous decisions`.

`decisions/` then shows only what holds today, which is what a reader in a
developer portal needs.

## Publishing

`docs/context/` is plain Markdown with a few lines of YAML frontmatter
(`type`, `status`). Any documentation site or portal can publish it.

For Backstage TechDocs, the repository has an
[example](https://github.com/conventionalcontext/conventionalcontext/tree/main/examples/techdocs):
a minimal `mkdocs.yml` and the `catalog-info.yaml` annotation. Links from
`docs/context/` into `openspec/` point readers to the repository, so nothing
is copied.
