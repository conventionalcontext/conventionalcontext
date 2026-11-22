---
title: Quick Summary
template: home.html
hide:
  - navigation
---

# Quick summary

**Conventional Context** is a small set of Markdown files, always in
`docs/context/`, that write down what a project is *for*: what it must do,
what it must work within, the decisions behind it, and the words it uses.
People read them to understand the project. AI coding agents read them
before they build or change any code.

```text
docs/context/
  README.md         start here: what this project is, and what is in this folder
  requirements.md   what it must do
  architecture.md   how it is built, and why
  decisions/        one short record per significant decision
  constraints.md    what it must work within          (recommended)
  glossary.md       the words it uses, and what they mean  (recommended)
  roadmap.md        where it is heading               (recommended)
  features/         one file per feature              (recommended, if no SDD tool)
```

[Conventional Commits](https://www.conventionalcommits.org/) made commit
messages predictable enough for people and tools to build on. Conventional
Context does the same for a project's **intent**.

## Why it matters

### Agentic development starts with intent

In agent-assisted development, an AI coding agent such as Claude Code, GitHub
Copilot, Cursor, or Codex writes much of the code. A person still decides
*what* should exist and *why*. The work moves through the same stages as any
software development lifecycle (SDLC), with agents doing more of each one:

<ul class="cc-flow" aria-label="Agentic SDLC stages">
  <li class="cc-flow__here">Intent</li><li class="cc-flow__arrow">→</li>
  <li>Spec</li><li class="cc-flow__arrow">→</li>
  <li>Plan</li><li class="cc-flow__arrow">→</li>
  <li>Build</li><li class="cc-flow__arrow">→</li>
  <li>Test</li><li class="cc-flow__arrow">→</li>
  <li>Deploy</li>
</ul>

| Stage | The question it answers | Where it lives |
|---|---|---|
| **Intent** | Why does this project exist? What must always hold true? What was decided, and why? | **`docs/context/` (Conventional Context)** |
| Spec | What exactly should this one feature do? | Spec-driven development tools: [Spec Kit](https://github.com/github/spec-kit), [OpenSpec](https://github.com/Fission-AI/OpenSpec), [Kiro](https://kiro.dev/) |
| Plan | How will we build it? | The agent's plan, reviewed by a person |
| Build | The code | The agent, reviewed by a person |
| Test | Does it do what the spec says? | Tests and CI |
| Deploy | Ship it | CI/CD |

Each stage builds on the one before it. **Spec-driven development** (SDD)
tools made the *Spec* stage explicit: write down what a feature should do,
then let agents plan, build, and test it. But every feature spec quietly
assumes the project's intent: who the project is for, the rules it must
follow, the decisions already made, and what its words mean.

That intent usually lives in someone's head, a wiki, a chat thread, or the
agent session that created the code. Even that session's memory stays with
its creator: in their agent account, on their machine. Another agent, a new
session, or a teammate cannot see any of it. An agent sees only the
repository and your prompt, so it guesses, asks, or needs to be told again
in every session.

**Conventional Context gives the Intent stage a home in the repository**, in
the same place and shape every time. The intent lives on beyond the session
that created it, and any agent, in any session, on anyone's machine, can
read it.

### What you get

- **Fewer prompts and clarifications.** The agent reads the requirements,
  constraints, and decisions before it starts, instead of asking you, or
  guessing wrong and needing to be corrected.
- **A shared language.** The person who declared the intent and the agents
  that build it use the same words with the same meaning, defined once in
  the glossary.
- **Decisions stay decided.** Decision records explain *why*, so agents and
  new people do not reopen settled debates or undo deliberate choices.
- **Faster onboarding.** A new maintainer, contributor, or user of the
  project reads one folder to understand what it is for and how it got here.
- **The same place everywhere.** Once you have seen one repository, you know
  where to look in the next, and so do agents and tools.

## Example

In a fictional repository that uses Conventional Context, here is one request
per role, with and without context. The agent is the same; only the context
differs.

=== "Backend"

    > **You:** Add an endpoint that returns a customer's order history,
    > grouped by month.

    **Without context.** The agent queries the orders table straight from the
    handler, returns every row in one response, sends totals as floats, and
    calls the field `purchases`. You spend three review rounds on pagination,
    money format, and naming, and a different agent repeats the mistakes next
    week.

    **With context.** The agent reads `docs/context/` first and finds:

    - `constraints.md`: **C-005**\* *Data is read only through the service
      layer, never straight from the database in a handler.*
    - `decisions/0007-list-endpoints.md`: *List endpoints use cursor
      pagination; money is integer cents; timestamps are ISO 8601 UTC.*
    - `glossary.md`: *Order* is the term, not "purchase".

    It adds a service method and a thin handler, paginates by cursor, returns
    cents and UTC, and cites C-005\* and decision 0007\* in the pull request.
    One prompt.

=== "DevOps"

    > **You:** Add a step that runs the database migration before each
    > release.

    **Without context.** The agent writes a custom shell script step with a
    long-lived cloud access key stored as a secret, and runs it on every
    branch build, including pull requests.

    **With context.** The agent finds:

    - `constraints.md`: **C-012**\* *Pipelines use the shared workflow
      templates; no custom deploy scripts.* **C-013**\* *Cloud access uses
      short-lived OIDC credentials, never stored keys.*
    - `decisions/0011-migrations.md`: *Migrations run once, from `main`,
      before the rollout, with a rollback step.*

    It calls the shared migration template with OIDC, on `main` only, with
    the rollback step, and cites C-012\*, C-013\*, and decision 0011\*.

=== "Platform"

    > **You:** Add a queue for the notifications service.

    **Without context.** The agent hand-writes a resource in the default
    region with no tags and a public endpoint, and skips the shared module.

    **With context.** The agent finds:

    - `constraints.md`: **C-009**\* *All infrastructure is Terraform, from the
      approved modules.* **C-010**\* *Approved regions only; a cost-center tag
      is required.*
    - `decisions/0004-shared-queue-module.md`: *Use the shared `queue`
      module: encrypted, private, with a dead-letter queue by default.*

    It uses the module with an approved region and the required tag, and
    cites C-009\*, C-010\*, and decision 0004\*.

\* *The IDs and file names in these examples are made up, from a
fictional repository. In your own repository, numbering starts at C-001 and
0001.*

### What the files look like

Plain Markdown with a few lines of YAML at the top. Some short extracts from
the same fictional repository:

=== "requirements.md"

    ```markdown
    ### FR-004: Order history by month

    The API MUST return a customer's orders grouped by calendar month.

    #### Scenario: Customer with orders in two months

    - **GIVEN** a customer with orders in March and April
    - **WHEN** the client requests the order history
    - **THEN** the response has one group per month, newest first
    ```

=== "constraints.md"

    ```markdown
    | ID | Constraint | Background |
    |---|---|---|
    | C-005* | Data is read only through the service layer. | Access rules and auditing live there. |
    | C-009* | All infrastructure is Terraform, from the approved modules. | Reviewed once, reused everywhere. |
    | C-013* | Cloud access uses short-lived OIDC credentials. | A leaked stored key was an incident in 2025. |
    ```

=== "decisions/0007-list-endpoints.md"

    ```markdown
    ---
    type: decision
    status: accepted
    date: 2026-09-14
    decision-makers: backend-team
    ---

    # List endpoints use cursor pagination

    ## Context and Problem Statement
    Offset pagination skipped and repeated rows when data changed. ...

    ## Decision Outcome
    Chosen option: "Cursor pagination", because ...
    ```

=== "AGENTS.md"

    ```markdown
    ## Start with the project's intent

    Read `docs/context/README.md` first, then the files it points to that
    are relevant to your task. Where `docs/context/` does not cover
    something, ask rather than guess. Update it in the same pull request
    as your change.

    ## Conventions

    - Diagrams: mermaid
    ```

\* *As above, the IDs and file names in these extracts are made up.*

## Get started

The v0.1 specification and templates are being written. You can start today
by hand; it takes less than an hour.

1. Create `docs/context/README.md`: two sentences on what the project is,
   and a list of the files below. Put `conventionalcontext: "0.1"` in its
   frontmatter.
2. Write `requirements.md`: what the project must do. A short list is fine.
3. Write `architecture.md`: how it is built, and why.
4. Add `decisions/` with one short record for each significant decision
   already made, using [MADR](https://adr.github.io/madr/).
5. Add the *Start with the project's intent* lines above to `AGENTS.md`, so
   agents read `docs/context/` before they change anything.

Add `constraints.md`, `glossary.md`, `roadmap.md`, and `features/` when you
need them. Skip `features/` if a tool such as Spec Kit already tracks your
features. This project's own
[`docs/context/`](https://github.com/conventionalcontext/conventionalcontext/tree/main/docs/context)
is a complete example.

!!! tip "Let an agent draft it, then correct it"
    Ask your agent: *"Read this repository and draft `docs/context/`
    following conventionalcontext.org."* Then review every line. An agent can
    describe what the code **does**; only you know what it is **for**.

## How it fits with other tools

Conventional Context reuses conventions you may already know, and sits next
to them rather than replacing them.

| Tool or convention | What it covers | With Conventional Context |
|---|---|---|
| [AGENTS.md](https://agents.md/) | Instructions that coding agents read first | Points agents to `docs/context/` |
| [Spec Kit](https://github.com/github/spec-kit), [OpenSpec](https://github.com/Fission-AI/OpenSpec), [Kiro](https://kiro.dev/) | Specs for one feature or change at a time | Keep their own folders; `docs/context/` holds the project-wide intent their specs build on |
| [MADR](https://adr.github.io/madr/) | Architecture decision records | The format of `decisions/` |
| [arc42](https://arc42.org/) | Architecture documentation | Selected sections shape `constraints.md`, `architecture.md`, and `glossary.md` |

### One entry file for every agent

Conventional Context uses [AGENTS.md](https://agents.md/) as its only agent
entry file, so one standard works with every coding agent that reads it.
Recent versions of Claude Code do too: they read `AGENTS.md` when a
repository has no `CLAUDE.md`. If you keep a `CLAUDE.md`
as well, it takes precedence, so make it a one-line pointer to `AGENTS.md`
rather than a second copy to keep in sync.

## FAQ

??? question "Do I need to install anything?"
    No. It is Markdown files in a folder. Optional tooling (a scaffold and a
    linter) is planned, and will stay optional.

??? question "Is this only for AI agents?"
    No. Everything an agent needs to know is also what a new team member needs
    to know. Agents simply make the gap more visible, because they start every
    session knowing nothing beyond the repository.

??? question "Does it replace Spec Kit, OpenSpec, or Kiro?"
    No. Those tools describe one feature or change at a time. Conventional
    Context describes the whole project, and stays true across all features.
    If you use one of them, keep your feature specs there and skip
    `docs/context/features/`: write each feature once. Keep Spec Kit's
    constitution short and point it to `docs/context/` for constraints and
    decisions.

??? question "How much do I have to write?"
    Four things to start: the index, requirements, architecture, and
    decisions. Each can be short. Add more as the project needs it.

??? question "How does it stay up to date?"
    Context changes go in the same pull request as the code change they
    describe. With the `AGENTS.md` lines above, agents do this as part of
    their work, and reviewers check it like any other change.

??? question "What is the status?"
    Version 0.1 is in progress. The project's own intent is written down in
    its [`docs/context/`](https://github.com/conventionalcontext/conventionalcontext/tree/main/docs/context);
    the specification text and templates come next. Follow along or join in
    on [GitHub](https://github.com/conventionalcontext/conventionalcontext).
