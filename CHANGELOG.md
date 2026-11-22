# Changelog

Notable changes to the Conventional Context specification and this
repository. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Specification versions are listed as they are published.

## Unreleased

Part of 0.1.0. v0.1.0 is released once `spec/v0.1/SPEC.md` is approved (see
`docs/context/roadmap.md`).

### Added

- README describing the project, where it fits in agent-assisted development
  (Intent → Spec → Plan → Build → Test → Deploy), how to start, its planned
  contents, and how each part is licensed.
- License files for the specification (`spec/LICENSE`, CC-BY-4.0) and the
  templates (`templates/LICENSE`, CC0-1.0).
- `AGENTS.md` with instructions for AI coding agents, including a
  `## Conventions` section.
- `.github/CODEOWNERS` assigning every file to the maintainers team.
- `docs/context/` for this project: index, requirements, constraints,
  glossary, architecture, roadmap, 18 decision records (MADR 4; 16 accepted,
  2 proposed) with three archived previous versions, and 11 feature files.
- Project website in `docs/website/` (Zensical) with a
  quick summary, a draft specification page, and a contribution guide, and
  `.github/workflows/website.yml` to build it and deploy it to GitHub Pages.
