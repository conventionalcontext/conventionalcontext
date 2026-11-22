# Conventional Context

A specification for putting a project's intent in its repository, where people and AI agents can read it.

**[Quick Summary](https://conventionalcontext.org/) · [Specification](https://conventionalcontext.org/specification/) · [Contribute](https://conventionalcontext.org/contribute/)**

> **Status: v0.1 in progress.** This project's own intent is written down in
> [`docs/context/`](docs/context/README.md); the specification text comes
> next. Nothing is stable yet, and feedback is welcome in
> [issues](https://github.com/conventionalcontext/conventionalcontext/issues).

## What it is

A small set of Markdown files, always in `docs/context/`, that write down
what a project is *for*: what it must do, what it must work within, the
decisions behind it, and the words it uses. People read them to understand
the project. AI coding agents read them before they build or change any code.

```
docs/context/
  README.md          start here: what this project is, and what is in this folder
  requirements.md    what it must do
  architecture.md    how it is built, and why
  decisions/         one short record per significant decision
  constraints.md     what it must work within          (recommended)
  glossary.md        the words it uses, and what they mean  (recommended)
  roadmap.md         where it is heading               (recommended)
  features/          one file per feature              (recommended, if no SDD tool)
```

[Conventional Commits](https://www.conventionalcommits.org/) made commit
messages predictable enough for people and tools to build on. Conventional
Context does the same for a project's intent.

## Why it matters

In agent-assisted development, AI coding agents (Claude Code, GitHub Copilot,
Cursor, Codex, ...) write much of the code, and work moves through these
stages:

**Intent** → Spec → Plan → Build → Test → Deploy

Spec-driven development tools such as [Spec Kit](https://github.com/github/spec-kit),
[OpenSpec](https://github.com/Fission-AI/OpenSpec), and [Kiro](https://kiro.dev/)
cover *Spec* to *Build*, one feature at a time. But every feature spec
relies on the project's **intent**: who it is for, the rules it must follow,
the decisions already made, and what its words mean. That usually lives in
someone's head, a wiki, a chat thread, or the agent session that created
the code, whose memory stays in its creator's account and machine. Other
agents and people cannot see it. So they guess, ask, or need to be told again
in every session.

Conventional Context gives intent a home in the repository, where any agent,
in any session, on anyone's machine, can read it. With it:

- **Fewer prompts and clarifications.** Agents read the requirements,
  constraints, and decisions before they start, instead of asking or guessing.
- **A shared language.** The person who declared the intent and the agents
  that build it mean the same thing by the same words.
- **Decisions stay decided.** Decision records explain *why*, so nobody
  reopens settled debates or undoes deliberate choices.
- **Faster onboarding.** New maintainers and users read one folder to learn
  what the project is for and how it got here.
- **The same place everywhere.** People, agents, and tools know where to look
  in every repository that adopts it.

## Get started

The templates are not published yet. You can start by hand in under an hour:

1. Create `docs/context/README.md`: two sentences on what the project is, a
   list of the files below, and `conventionalcontext: "0.1"` in its YAML
   frontmatter.
2. Write `requirements.md` (what it must do) and `architecture.md` (how it is
   built, and why). Short is fine.
3. Add `decisions/` with one record per significant decision, using
   [MADR](https://adr.github.io/madr/).
4. Tell agents to read it, in [`AGENTS.md`](https://agents.md/):

   ```markdown
   ## Start with the project's intent

   Read `docs/context/README.md` first, then the files it points to that are
   relevant to your task. Where `docs/context/` does not cover something, ask
   rather than guess. Update it in the same pull request as your change.
   ```

`AGENTS.md` is the one entry file Conventional Context uses, so a single
standard works with every coding agent that reads it. Claude Code reads it
too in recent versions, when a repository has no `CLAUDE.md`; if you keep
a `CLAUDE.md`, make it a one-line pointer to `AGENTS.md`.

This repository's own [`docs/context/`](docs/context/README.md) is a complete
example. The [quick summary](https://conventionalcontext.org/) has a worked
example of an agent with and without context.

## What this repository contains

Each part is added when it is ready; until then it is not here.

| Path | What it is | License |
|---|---|---|
| `spec/` | The specification itself, versioned (`spec/v0.1/SPEC.md`) | CC-BY-4.0 |
| `schema/` | JSON Schema for the frontmatter of context files | Apache-2.0 |
| `templates/` | The starter `docs/context/` that adopters copy into their repository | CC0-1.0 |
| `profiles/` | Opinions for a kind of project, starting with platform engineering: infrastructure as code, GitOps, cloud foundations | CC-BY-4.0 |
| `adapters/` | How Conventional Context fits alongside `AGENTS.md`, Spec Kit, OpenSpec, and later AI-DLC and Kiro | CC-BY-4.0 |
| `examples/` | Filled-in `docs/context/` directories from real repositories | Apache-2.0 |
| `tools/` | Optional tooling: a one-time scaffold script and a linter | Apache-2.0 |
| `docs/context/` | This project's own intent, written to its own specification | Apache-2.0 |
| `docs/website/` | The [conventionalcontext.org](https://conventionalcontext.org) website (Zensical) | Apache-2.0 |

Present today: `docs/context/`, `docs/website/`, and the license files.

## Contributing

Issues are open for questions, ideas, and proposed changes. See
[Contribute](https://conventionalcontext.org/contribute/) for how changes are
made; a `CONTRIBUTING.md` will follow.

## License

Different parts of this repository are licensed differently, according to
how they are meant to be used:

- **Specification and prose** (`spec/`, `profiles/`, `adapters/`):
  [CC-BY-4.0](spec/LICENSE). Share and adapt them, with attribution.
- **Templates** (`templates/`): [CC0-1.0](templates/LICENSE), public domain.
  Copy them into your repository with no attribution and no conditions.
- **Everything else** (schema, tools, examples, the website, and this
  repository's own files): [Apache-2.0](LICENSE).

`profiles/` and `adapters/` have no `LICENSE` file of their own; this section
is what places them under CC-BY-4.0.

## Links

- Website: [conventionalcontext.org](https://conventionalcontext.org)
- Organization: [github.com/conventionalcontext](https://github.com/conventionalcontext)
