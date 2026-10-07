# Conventional Context

A specification for keeping a project's intent in its git repository, in a
form that people can read, AI agents can read, and machines can check.

> **Status: early draft.** The v0.1 specification is being written. Nothing
> here is stable yet, and feedback is welcome in
> [issues](https://github.com/conventionalcontext/conventionalcontext/issues).

## The problem

Code says *what* a system does. It rarely says *why*: the requirements it
serves, the constraints it works within, the decisions that shaped it, and
where it is heading. That intent usually lives in people's heads, in wikis,
in chat threads, and in tickets, all of which drift away from the code.

New contributors pay for that gap. AI coding agents pay for it more: they
read the repository and nothing else, so they work from the code alone and
guess at the rest.

## The idea

Put the intent next to the code, in a predictable place, in a predictable
shape. Conventional Context defines a `docs/context/` directory that every
adopting repository has, with the same files in the same places:

```
docs/
  context/
    README.md          what this project is, and an index of the files below
    requirements.md    what it must do
    constraints.md     what it must work within
    architecture.md    how it is built, and why
    glossary.md        the words it uses, and what they mean
    roadmap.md         where it is heading
    decisions/         one record per significant decision (ADRs)
    features/          one file per feature: intent, scope, status
```

Because the layout is the same everywhere, a person or an agent that has
seen one repository knows where to look in the next. Because the files have
a defined structure, tools can check that they exist, are complete, and are
kept up to date.

[Conventional Commits](https://www.conventionalcommits.org/) made commit
messages predictable enough for tools to build on. Conventional Context aims
to do the same for project intent.

## What the specification covers

- **Level 1: structure.** Which files exist, what each one contains, and the
  frontmatter that makes them machine-checkable.
- **Level 2: provenance.** Recording where intent came from and how it
  changes over time, so a reader can trust what they find.

A repository can adopt Level 1 on its own.

## What this repository will contain

The repository is built up in stages. Each part is added when it is ready;
until then it is not here.

| Path | What it is | License |
|---|---|---|
| `spec/` | The specification itself, versioned (`spec/v0.1/SPEC.md`) | CC-BY-4.0 |
| `schema/` | JSON Schema for the frontmatter of context files | Apache-2.0 |
| `templates/` | The blank `docs/context/` that adopters copy into their repository | CC0-1.0 |
| `profiles/` | Opinions for a kind of project, starting with platform engineering: infrastructure as code, GitOps, cloud foundations | CC-BY-4.0 |
| `adapters/` | How Conventional Context fits alongside `AGENTS.md`, spec-kit, and AI-DLC | CC-BY-4.0 |
| `examples/` | Filled-in `docs/context/` directories from real repositories | Apache-2.0 |
| `tools/` | Optional tooling: a one-time scaffold script and a linter | Apache-2.0 |
| `docs/context/` | This project's own intent, written to its own specification | Apache-2.0 |

## Using it

Not yet: the specification and templates are still being written. Watch or
star the repository to follow along. When v0.1 is published, adopting it
will mean copying `templates/docs/context/` into your repository and filling
it in.

## Contributing

Issues are open for questions, ideas, and proposed changes to the
specification. Guidelines for contributing to the specification itself will
be added in `CONTRIBUTING.md`.

## License

Different parts of this repository are licensed differently, according to
how they are meant to be used:

- **Specification and prose** (`spec/`, `profiles/`, `adapters/`):
  [CC-BY-4.0](spec/LICENSE). Share and adapt them, with attribution.
- **Templates** (`templates/`): [CC0-1.0](templates/LICENSE), public domain.
  Copy them into your repository with no attribution and no conditions.
- **Everything else** (schema, tools, examples, and this repository's own
  files): [Apache-2.0](LICENSE).

`profiles/` and `adapters/` have no `LICENSE` file of their own; this section
is what places them under CC-BY-4.0.

## Links

- Website: [conventionalcontext.org](https://conventionalcontext.org)
- Organization: [github.com/conventionalcontext](https://github.com/conventionalcontext)
