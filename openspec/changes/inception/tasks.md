# Tasks

## 1. Schema

- [x] 1.1 Validate the schema with the installed OpenSpec release and verify `openspec schema validate conventional-context` reports it valid
- [x] 1.2 Validate this change and verify `openspec validate inception --strict` reports it valid
- [x] 1.3 Install the schema from a release-shaped tarball into a fresh project with the README command and verify OpenSpec resolves and validates it there

## 2. Publishing

- [x] 2.1 Build this repository's `docs/context/` with `mkdocs-techdocs-core` and `examples/techdocs/mkdocs.yml`, and verify the build reports no warnings or errors (NFR-003)
- [x] 2.2 Build the website and verify `zensical build --strict -f docs/website/mkdocs.yml` passes
- [x] 2.3 Check every relative link in `README.md`, `AGENTS.md`, `CHANGELOG.md`, `docs/context/`, `examples/`, and this change, and verify none is broken

## 3. Context updates

- [x] 3.1 `docs/context/README.md`: index and decisions table; verified by a row for each of 0001 to 0009
- [x] 3.2 `docs/context/requirements.md`: purpose, users and stakeholders, scope, NFR-001 to NFR-003; verified by its behavior section linking to `openspec/specs/`
- [x] 3.3 `docs/context/constraints.md`: C-001 to C-008; verified by a reason for each
- [x] 3.4 `docs/context/architecture.md`: context, strategy, building blocks, distribution, checks; verified by the building blocks table
- [x] 3.5 `docs/context/decisions/0001` to `0009`: verified by status `accepted` and decision-makers andreouellet and Hamed Minaee
- [x] 3.6 `docs/context/glossary.md`: agents and context, Conventional Context, and OpenSpec terms quoted from OpenSpec's glossary; verified by the link to it
- [x] 3.7 `docs/context/roadmap.md`: this change under Now; verified by the link to `openspec/changes/inception/`

## Workflow follow-up

- Open the pull request; Hamed Minaee reviews and approves it (C-008).
- Archive the change after approval, so the specs move to `openspec/specs/`.
- Tag `v0.1.0` after merge, so the install command in the README works.
