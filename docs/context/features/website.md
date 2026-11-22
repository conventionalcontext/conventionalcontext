---
type: feature
status: in-progress
---

# Project website

## Summary

conventionalcontext.org, built with Zensical from `docs/website/` and deployed
to GitHub Pages. Like conventionalcommits.org it has a one-sentence
description and three entry points: **Quick Summary**, **Full
Specification**, and **Contribute**. See
[decision 0016](../decisions/0016-project-website.md).

## User scenarios

### Scenario: Newcomer learns what it is

- **GIVEN** a person new to agent-assisted development
- **WHEN** they open the home page
- **THEN** the quick summary tells them what Conventional Context is, why it
  matters, where it fits in the agentic SDLC, and how to start

### Scenario: Maintainer previews a change

- **GIVEN** a pull request that changes `docs/website/`
- **WHEN** CI runs
- **THEN** the site builds with `zensical build --strict`, and the pull request
  fails if it does not

## Requirements

FR-017 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** The home page has the one-sentence description and the three
  entry points.
- **SC-002:** The site builds with `--strict` and deploys on push to `main`.
- **SC-003:** The quick summary, README, and specification say the same
  thing.
- **SC-004:** conventionalcontext.org serves the site (needs CNAME and DNS).

## Open questions

- Should the specification page render `spec/vX.Y/SPEC.md` directly once it
  exists, instead of a hand-written summary?
