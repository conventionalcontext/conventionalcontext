# Conventional Context

**Keep people aware and in charge of what AI agents build.**

AI coding agents can now write most of a project's code. Conventional Context
keeps the people behind the project in control. It records what the project
is for, the rules it must follow, and the decisions behind it, in plain
Markdown files that anyone can read and review.

> **Status:** early (0.x). Not released yet. See the [changelog](CHANGELOG.md).

## Why

When agents build a project, the reasons behind it often stay in one
person's head, or in an agent's chat history that nobody else can see. Then:

- reviewers cannot check the plan before agents build, or the result after;
- newcomers cannot learn why the project is the way it is;
- the project's documentation shows its code, but not its intent.

Conventional Context supports **human agency**: people stay **aware** of what
is being built and why, and **in charge** of what gets built.

- **Aware:** what the project is for, its rules, and its decisions are
  written down where everyone can read them.
- **In charge:** you write that down and review it before any code exists.
  When a change conflicts with a rule or a decision, the agent stops and asks
  you. Agents never change the rules without a person's approval.

The schema guides agents; a **GitOps workflow** is what keeps people in
charge. Everything (code, specs, and `docs/context/`) lives in git, every
change arrives as a pull request, and a protected `main` branch lets nothing
merge until a person has reviewed and approved it. Git's history then shows
who changed what, and why.

## How it works

Conventional Context adds to [OpenSpec](https://github.com/Fission-AI/OpenSpec),
a popular tool for spec-driven development: you describe a change, an agent
writes down what it will do and how, and then builds it.

1. **Start.** The first change asks you about the project and writes
   `docs/context/`. You review it before any code is written.
2. **Every change after that.** The agent checks the change against your
   rules and decisions. If they conflict, it asks you. Anything that will
   still matter later (a new decision, rule, or term) is added to
   `docs/context/` in the same pull request.
3. **Publish.** `docs/context/` is plain Markdown in `docs/`, so your
   documentation site or developer portal (such as Backstage) shows it with
   the rest. See [examples/techdocs/](examples/techdocs/).

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

What the system *does* stays in OpenSpec's specs (`openspec/specs/`).
Nothing is written twice. This repository's own
[`docs/context/`](docs/context/) is a complete example.

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

More on the website, [conventionalcontext.org](https://conventionalcontext.org).

## Contributing

Issues and pull requests are welcome. See the
[contribution guide](docs/website/src/contribute.md).

## License

[MIT](LICENSE)
