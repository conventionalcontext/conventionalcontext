# Changelog

Notable changes to Conventional Context. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow
[Semantic Versioning](https://semver.org/).

## Unreleased

0.x versions are an MVP: the schema and templates may still change in any
release. 1.0.0 comes when they are stable and used by real projects.

### Changed

- New direction: Conventional Context is now an OpenSpec schema plus the
  `docs/context/` convention, written for people (review, onboarding, and
  developer portals). It no longer defines its own specification text,
  agent routing through `AGENTS.md`, or feature files; OpenSpec manages
  behavior specs and changes.
- License: MIT for the whole repository.
- One-line description: "Keep people aware and in charge of what AI agents
  build." Human agency is the core principle, enforced by a GitOps workflow
  (decision 0010, constraint C-009).
- README and website rewritten in plain language for readers new to
  spec-driven development, AI agents, and OpenSpec.

### Added

- README describing the new direction.
- `docs/context/` templates (structure and guidance, no content): index,
  requirements, constraints, architecture, glossary, roadmap, and a MADR 4
  decision template. They ship inside the schema, in
  `openspec/schemas/conventional-context/docs-context/`.
- OpenSpec schema `conventional-context`: OpenSpec's `spec-driven` workflow
  plus a `context` artifact (proposal → context → specs → design → tasks).
  At inception it writes `docs/context/` with the user; on an existing
  codebase it first drafts from the code, marking inferred decisions
  `proposed` until the user confirms them; on later changes it
  checks the change against constraints and decisions and plans the
  `docs/context/` updates as tasks.
- `examples/techdocs/`: a minimal `mkdocs.yml` and `catalog-info.yaml` for
  publishing `docs/context/` with Backstage TechDocs, tested with
  `mkdocs-techdocs-core`.
- This repository's own `docs/context/` and OpenSpec setup, written with
  its own schema in the `inception` change: requirements, constraints C-001
  to C-008, architecture, decisions 0001 to 0009, glossary, roadmap, and
  specs for the `inception`, `change-review`, and `docs-context-format`
  capabilities.
- Website for conventionalcontext.org in `docs/website/` (Zensical, the
  blue-to-teal theme from the earlier version): quick summary, how it works,
  and contribute pages, with `.github/workflows/website.yml` to build it and
  deploy it to GitHub Pages.

## History

Earlier attempts, kept as tags for reference. They are not releases.

- [`archive/cc-spec`](https://github.com/conventionalcontext/conventionalcontext/tree/archive/cc-spec): Conventional Context as a
  standalone specification, with its own specification text, `AGENTS.md`
  routing, and website (October to November 2026). Replaced by the OpenSpec
  schema ([decision 0001](docs/context/decisions/0001-extend-openspec-with-a-schema.md)).
- [`archive/harc`](https://github.com/conventionalcontext/conventionalcontext/tree/archive/harc): HARC (Human Agentic Readable Context),
  the framework Conventional Context grew out of.
