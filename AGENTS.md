# AGENTS.md

Instructions for AI coding agents working in this repository.

## Start with the project's intent

This repository follows its own specification. Its intent (requirements,
constraints, architecture, decisions, roadmap) lives in `docs/context/`.
Read `docs/context/README.md` first, then the files it points to that are
relevant to your task, before changing anything.

`docs/context/` is being written. Where it does not yet cover something,
ask rather than guess.

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
