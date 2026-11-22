---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet, Hamed Minaee
---

# Website with Zensical on GitHub Pages

## Context and Problem Statement

conventionalcontext.org should explain the project in a minute, like
conventionalcommits.org. The `alpha` branch built a website with Zensical
(the maintained successor of Material for MkDocs, which reaches end of life
in 2027), a blue-to-teal theme from the logo, and a GitHub Pages workflow.

## Considered Options

* Zensical on GitHub Pages, reusing the `alpha` theme
* No website; the README is enough

## Decision Outcome

Chosen option: "Zensical on GitHub Pages, reusing the `alpha` theme", because it is already built and maintained, builds Markdown with `uv` only, and costs nothing to host.

* Pages: Quick Summary, How it works, Contribute.
* Built with `zensical build --strict` in `.github/workflows/website.yml`; deployed on push to `main`.

### Consequences

* Good, because the project has a short page to share.
* Bad, because Zensical is young (0.1.x); the version is pinned.
