# Changelog

Notable changes to Conventional Context. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow
[Semantic Versioning](https://semver.org/). Versions 0.x are an early
release: the schema and templates may still change. 1.0.0 comes when they
are stable and used by real projects.

## Unreleased

### Added

- The `conventional-context` schema for OpenSpec, in
  `openspec/schemas/conventional-context/`: OpenSpec's `spec-driven` steps
  plus a `context` step. The first change writes `docs/context/` with the
  user (on an existing project, the agent drafts from the code and the user
  confirms); later changes are checked against the project's rules and
  accepted decisions.
- Templates for `docs/context/`, inside the schema folder.
- A Backstage TechDocs example in `examples/techdocs/`.
- The conventionalcontext.org website in `docs/website/`, published with
  GitHub Pages.
- This project's own `docs/context/` and OpenSpec setup, written with its own
  schema.
- `CODEOWNERS`, assigning every file to the maintainers team.
- MIT license.
