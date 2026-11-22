# AGENTS.md

Instructions for AI coding agents working on this repository.

- `openspec/schemas/conventional-context/` is the product: an OpenSpec schema. Follow OpenSpec's
  schema format (`schema.yaml` with `artifacts`, each with `id`,
  `generates`, `template`, `instruction`, `requires`). Do not invent fields.
- `openspec/schemas/conventional-context/docs-context/` holds the `docs/context/`
  templates that adopters fill in. Keep them to structure and short guidance,
  never example content: leftover examples get published and enforced.
- Never duplicate what OpenSpec manages. Behavior belongs in
  `openspec/specs/`; `docs/context/` links to it.
- Decision records: when a decision changes, move the current file unchanged
  (status `superseded`) to `decisions/archive/NNNN-title-YYYY-MM-DD.md`,
  then update the original in place and list the archived version under
  `## Previous decisions`.
- Run Python tooling with `uv`, never `pip`.
- Commit messages follow
  [Conventional Commits](https://www.conventionalcommits.org/). Record
  notable changes in `CHANGELOG.md` under `Unreleased`.
