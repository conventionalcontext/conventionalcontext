# AGENTS.md

Instructions for AI coding agents working in this repository.

## Start with the project's intent

This repository follows its own specification. Its intent (requirements,
constraints, architecture, decisions, roadmap) lives in `docs/context/`.
Read `docs/context/README.md` first, then the files it points to that are
relevant to your task, before changing anything.

Where `docs/context/` does not cover something, ask rather than guess.

## Conventions

Choices that affect how context files are written in this repository. Follow
them when you create or edit files in `docs/context/`.

- Diagrams: none. Describe structure with tables and directory trees.
- Requirement keywords: BCP 14 (MUST, SHOULD, MAY) in uppercase.
- Requirements and scenarios: the format in
  `docs/context/decisions/0007-requirement-format.md`.
- Decision records: MADR 4, numbered `NNNN-title-in-kebab-case.md`. To
  change a decision, first move its current file unchanged (status
  `superseded`) to `decisions/archive/NNNN-title-YYYY-MM-DD.md`, then update
  it in place and list the archived version under `## Previous decisions`
  (`docs/context/decisions/0015-archive-previous-decisions.md`).

## What each directory is

| Path | What it is | Notes |
|---|---|---|
| `spec/` | The specification. **Normative**: every word is a commitment to adopters. | Change only when asked. Never edit a published version; changes go into a new version. |
| `schema/` | JSON Schema for context-file frontmatter | Must match the specification. |
| `templates/` | The blank `docs/context/` adopters copy | Keep it blank: structure and guidance, never this project's content. |
| `profiles/`, `adapters/` | Guidance prose | Not normative. |
| `examples/` | Filled-in examples | |
| `tools/` | Optional scaffold script and linter | |
| `docs/context/` | This project's own intent | Real content, not a template. Do not copy it into `templates/`. |
| `docs/website/` | The conventionalcontext.org website (Zensical) | Explains the specification; never adds rules of its own. Keep it consistent with `README.md`. Check with `uv run --no-project --with-requirements docs/website/requirements.txt zensical build --strict -f docs/website/mkdocs.yml`. Use `uv`, never `pip`. |

## Working rules

- Keep `docs/context/` in step with your change. If a change alters a
  requirement, constraint, or decision, update the matching file, or add a
  record under `docs/context/decisions/`.
- Record notable changes in `CHANGELOG.md` under `Unreleased`.
- Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/),
  e.g. `docs: ...`, `feat(schema): ...`, `fix(spec): ...`.
- Files are licensed by directory (see the License section of `README.md`).
  Do not move content between `spec/`, `templates/`, and the rest without
  checking its license.
