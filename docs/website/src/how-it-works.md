---
title: How it works
hide:
  - navigation
---

# How it works

Conventional Context is a *schema* for [OpenSpec](https://github.com/Fission-AI/OpenSpec):
a set of steps an agent follows for every change. It is OpenSpec's standard
set of steps with one more, **context**, added after the proposal:

<ul class="cc-flow" aria-label="Steps of a change">
  <li>proposal</li><li class="cc-flow__arrow">→</li>
  <li class="cc-flow__here">context</li><li class="cc-flow__arrow">→</li>
  <li>specs</li><li class="cc-flow__arrow">→</li>
  <li>design</li><li class="cc-flow__arrow">→</li>
  <li>tasks</li>
</ul>

| Step | What the agent writes |
|---|---|
| proposal | Why the change is needed, and what it changes |
| **context** | **Which of your rules and decisions apply, and what the change adds to `docs/context/`** |
| specs | What the system will do, with examples that can be tested |
| design | How it will be built |
| tasks | A checklist the agent works through |

## The first change

When `docs/context/` does not exist yet, the context step:

1. Copies the templates into `docs/context/`.
2. Asks you, a few questions at a time, who the project is for, what is in
   and out of scope, how well it must work, which rules it must follow and
   why, how it will be built, and which words have a special meaning. It
   does not guess: a wrong rule is worse than a missing one.
3. Writes your answers into the files, and records each choice you have
   already made (language, platform, hosting) as a decision.
4. Asks you to review `docs/context/` before anything is built.

## Every change after that

When `docs/context/` exists, the context step:

1. Reads only your rules (`constraints.md`) and decisions (`decisions/`).
2. Lists which of them apply to the change.
3. Stops and asks you if the change conflicts with one: change the plan, or
   change the rule.
4. Lists what the change adds that will still matter later: a decision, a
   rule, a term. Each becomes a task, so it lands in the same pull request as
   the code.

## Pull requests keep people in charge

The schema guides agents. Your **GitOps workflow** is what makes sure a
person approves every change, to the code and to `docs/context/`:

- Agents work on a branch and open a pull request. They never change `main`
  directly.
- A protected `main` branch merges nothing until a person has approved it.
- Git's history records who changed what, and why.

Settings to turn on for `main` (GitHub calls this a *ruleset* or *branch
protection*; other hosts have the same idea):

| Setting | Why |
|---|---|
| Require a pull request before merging | Nothing reaches `main` without review |
| Require at least one approval, from someone other than the author | An agent, or the person running it, cannot approve its own work |
| Require review from code owners (a `CODEOWNERS` file) | The right people approve changes to `docs/context/` |
| Block force pushes and deletion | History cannot be rewritten |

## Decisions

Each decision is one file in `docs/context/decisions/`. When a decision
changes, the old version moves to `decisions/archive/` and the file is
updated in place. So `decisions/` always shows what holds today, and earlier
versions are one click away.

## Publishing

`docs/context/` is plain Markdown in `docs/`, so any documentation site or
developer portal can show it. For Backstage, the repository has an
[example](https://github.com/conventionalcontext/conventionalcontext/tree/main/examples/techdocs).
