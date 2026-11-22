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
- Blank `docs/context/` templates in `templates/docs/context/`: index,
  requirements, constraints, architecture, glossary, roadmap, and a MADR 4
  decision template.
