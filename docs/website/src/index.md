---
title: Quick Summary
template: home.html
hide:
  - navigation
---

# Quick summary

AI coding agents can now write most of a project's code. **Conventional
Context** keeps the people behind the project in control. It records what
the project is for, the rules it must follow, and the decisions behind it, in
plain Markdown files that anyone can read and review.

## Why it matters

When agents build a project, the reasons behind it often stay in one
person's head, or in an agent's chat history that nobody else can see. Then:

- reviewers cannot check the plan before agents build, or the result after;
- newcomers cannot learn why the project is the way it is;
- the project's documentation shows its code, but not its intent.

### Human agency

Conventional Context supports **human agency**: people stay **aware** of what
is being built and why, and **in charge** of what gets built.

| | What it means | How Conventional Context does it |
|---|---|---|
| **Aware** | People can see what the project is for and why it is built the way it is | Purpose, rules, and decisions are written down in `docs/context/`, where everyone can read them |
| **In charge** | People decide; agents follow | You write the intent and review it before any code exists. When a change conflicts with a rule or decision, the agent stops and asks you. Agents never change the rules without a person's approval |
| **Enforced by GitOps** | Nothing changes without a person's approval | Everything (code, specs, and `docs/context/`) lives in git. Every change arrives as a pull request, and a protected `main` branch lets nothing merge until a person has reviewed and approved it. Git's history shows who changed what, and why |

The schema guides agents; the GitOps workflow is what keeps people in
charge.

### Where it fits

Building with AI agents goes through the same stages as any software
project. Conventional Context covers the first one:

<ul class="cc-flow" aria-label="Stages of agentic development">
  <li class="cc-flow__here">Intent</li><li class="cc-flow__arrow">→</li>
  <li>Spec</li><li class="cc-flow__arrow">→</li>
  <li>Plan</li><li class="cc-flow__arrow">→</li>
  <li>Build</li><li class="cc-flow__arrow">→</li>
  <li>Test</li><li class="cc-flow__arrow">→</li>
  <li>Deploy</li>
</ul>

| Stage | The question it answers | Who writes it, and where |
|---|---|---|
| **Intent** | Why does this project exist? What rules must it follow? What was decided, and why? | **People, in `docs/context/` (Conventional Context)** |
| Spec | What exactly should the system do? | An agent, reviewed by people, in `openspec/specs/` ([OpenSpec](https://github.com/Fission-AI/OpenSpec)) |
| Plan | How will this change be built? | An agent, reviewed by people, in `openspec/changes/` (OpenSpec) |
| Build, Test | The code and its tests | An agent, reviewed by people |
| Deploy | Ship it | Your CI/CD pipeline |

Every later stage is checked against the first: before an agent writes a
spec or a plan, it checks the change against your rules and decisions.

## How it works

1. **Start.** The first change asks you about the project and writes
   `docs/context/`. You review it before any code is written.
2. **Every change after that.** The agent checks the change against your
   rules and decisions. If they conflict, it asks you. Anything that will
   still matter later (a new decision, rule, or term) is added to
   `docs/context/` in the same pull request.
3. **Publish.** `docs/context/` is plain Markdown in `docs/`, so your
   documentation site or developer portal (such as Backstage) shows it with
   the rest.

[How it works, in detail](how-it-works.md)

## What is in docs/context/

| File | What it tells you |
|---|---|
| `README.md` | What the project is, and where to find the rest |
| `requirements.md` | Why the project exists, who it is for, and how well it must work |
| `constraints.md` | The rules it must follow, and why |
| `architecture.md` | How it is built |
| `decisions/` | What was decided, and why |
| `glossary.md` | What its words mean |
| `roadmap.md` | Where it is heading |

What the system *does* stays in OpenSpec's specs. Nothing is written twice.

## Get started

Once `v0.1.0` is released:

1. Install [OpenSpec](https://github.com/Fission-AI/OpenSpec) and run
   `openspec init` in your repository.
2. Copy the schema into your repository and commit it:

    ```bash
    mkdir -p openspec/schemas && curl -fsSL \
      https://github.com/conventionalcontext/conventionalcontext/archive/refs/tags/v0.1.0.tar.gz \
      | tar -xz --strip-components=3 -C openspec/schemas \
        conventionalcontext-0.1.0/openspec/schemas/conventional-context
    ```

3. Set `schema: conventional-context` in `openspec/config.yaml`.
4. Ask your agent to start, for example `/openspec-propose inception`, and
   review `docs/context/` before anything is built.

## FAQ

??? question "Do agents read all of docs/context/?"
    No. Studies found that giving agents general project overviews does not
    improve their work and adds cost
    ([Gloaguen et al., 2026](https://arxiv.org/abs/2602.11988)). So agents
    read only your rules and decisions, and only when they plan a change.
    The rest of `docs/context/` is written for people.

??? question "Do I need OpenSpec?"
    Yes. Conventional Context adds to OpenSpec rather than replacing it.
    Versions for other tools (Spec Kit, Kiro) are on the roadmap.

??? question "Can I use it on an existing project?"
    It is designed for new projects. You can run it on an existing one, and
    the agent will ask you about what is already there. Having the agent
    draft `docs/context/` from existing code, for you to confirm, is
    planned.

??? question "Does it guarantee that agents follow the rules?"
    Not on its own. Agents are instructed to check the rules and ask you
    about conflicts. The guarantee comes from your GitOps workflow: agents
    work in pull requests, and a protected `main` branch merges nothing a
    person has not approved.
