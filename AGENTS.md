# AGENTS.md

Instructions for AI coding agents working on this repository.

- `openspec/schemas/conventional-context/` is the product: an OpenSpec schema. Follow OpenSpec's schema format (`schema.yaml` with `artifacts`, each with `id`, `generates`, `template`, `instruction`, `requires`). Do not invent fields.
- `openspec/schemas/conventional-context/docs-context/` holds the `docs/context/` templates that adopters fill in. Keep them to structure and short guidance, never example content: leftover examples get published and enforced.
- Never duplicate what OpenSpec manages. Behavior belongs in `openspec/specs/`; `docs/context/` links to it.
- Decision records: when a decision changes, move the current file unchanged (status `superseded`) to `decisions/archive/NNNN-title-YYYY-MM-DD.md`, then update the original in place and list the archived version under `## Previous decisions`.
- This repository uses its own schema: propose changes with OpenSpec (`openspec/changes/`). Agent skills come from `openspec init` and are not committed (`.agents/` and `.claude/` are ignored).
- Run Python tooling with `uv`, never `pip`.
- Markdown: write each paragraph and list item on one line; do not hard-wrap text (as OpenSpec does). HTML comments in templates may wrap.
- Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/). Record notable changes in `CHANGELOG.md` under `Unreleased`.
