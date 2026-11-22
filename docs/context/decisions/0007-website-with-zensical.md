---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# Website with Zensical on GitHub Pages

## Context and Problem Statement

conventionalcontext.org should explain the project in a minute, the way
conventionalcommits.org does.

## Considered Options

* Zensical, hosted on GitHub Pages
* No website; the README is enough

## Decision Outcome

Chosen option: "Zensical on GitHub Pages", because it builds the site from Markdown, runs with `uv` only, is actively maintained, and costs nothing to host.

* Pages: Quick Summary, How it works, Contribute.
* `.github/workflows/website.yml` builds it with `--strict` and deploys it on push to `main`.

### Consequences

* Good, because the project has a short page to share.
* Bad, because Zensical is young (0.1.x), so its version is pinned.
