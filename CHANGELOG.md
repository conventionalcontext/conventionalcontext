# Changelog

Notable changes to Conventional Context. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow
[Semantic Versioning](https://semver.org/).

## Unreleased

### Changed

- New direction: Conventional Context is now an OpenSpec schema plus the
  `docs/context/` convention, written for people (review, onboarding, and
  developer portals). It no longer defines its own specification text,
  agent routing through `AGENTS.md`, or feature files; OpenSpec manages
  behavior specs and changes.
- License: MIT for the whole repository.

### Added

- README describing the new direction.
- `docs/context/` templates (structure and guidance, no content): index,
  requirements, constraints, architecture, glossary, roadmap, and a MADR 4
  decision template. They ship inside the schema, in
  `schema/conventional-context/docs-context/`.
- OpenSpec schema `conventional-context`: OpenSpec's `spec-driven` workflow
  plus a `context` artifact (proposal → context → specs → design → tasks).
  At inception it writes `docs/context/` with the user; on later changes it
  checks the change against constraints and decisions and plans the
  `docs/context/` updates as tasks.
- `examples/techdocs/`: a minimal `mkdocs.yml` and `catalog-info.yaml` for
  publishing `docs/context/` with Backstage TechDocs, tested with
  `mkdocs-techdocs-core`.
- Website for conventionalcontext.org in `docs/website/` (Zensical, the
  blue-to-teal theme from the earlier version): quick summary, how it works,
  and contribute pages, with `.github/workflows/website.yml` to build it and
  deploy it to GitHub Pages.
