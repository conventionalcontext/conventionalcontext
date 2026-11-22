---
type: decision
status: superseded
date: 2026-11-16
decision-makers: andreouellet
---

# Project website with MkDocs in `docs/website/`

## Context and Problem Statement

People who hear about Conventional Context need to understand in a minute
what it is, why it matters, and how to start, without reading the
repository. `conventionalcontext.org` currently redirects to the GitHub
repository. Comparable specifications (Conventional Commits, Keep a
Changelog, SemVer) each have a short website with a quick summary and the
full specification. How should this project publish one?

## Decision Drivers

* Written in Markdown, in this repository, reviewed in the same pull
  requests as everything else.
* Cheap to build and host; no server to run.
* Familiar to contributors.

## Considered Options

* MkDocs with Material for MkDocs, built to a static site, hosted on GitHub
  Pages
* A static site generator such as Hugo or Jekyll
* No website; the README is the landing page

## Decision Outcome

Chosen option: "MkDocs with Material for MkDocs on GitHub Pages", because it
builds Markdown into a clean static site with search, light and dark themes,
and no custom code, and it is widely used for documentation.

* The website lives in `docs/website/` ([0011](../0011-repository-layout.md)):
  `mkdocs.yml`, `requirements.txt` with pinned versions, `src/` for pages,
  and `overrides/` for the home page.
* Tooling is run with [uv](https://docs.astral.sh/uv/)
  (`uv run --no-project --with-requirements docs/website/requirements.txt
  mkdocs ...`), locally and in CI. Nothing is installed by hand, and `pip` is
  not used.
* Three entry points, like conventionalcommits.org: **Quick Summary** (the
  home page), **Full Specification**, and **Contribute**.
* Colours come from the logo: a deep blue to blue to teal gradient.
* `.github/workflows/website.yml` builds the site with `--strict` on every
  pull request that touches it, and deploys it to GitHub Pages on push to
  `main`.
* The website is licensed Apache-2.0 with the rest of the repository
  ([0010](../0010-license-by-directory.md)).
* Until `spec/v0.1/SPEC.md` exists, the specification page summarises the
  agreed requirements and is marked as a draft.

### Consequences

* Good, because the project has a short, shareable explanation that matches
  the README.
* Good, because the website is reviewed like any other change.
* Bad, because the README and the website overlap and must be kept
  consistent.
* Bad, because Material for MkDocs reaches end of life in May 2027; its
  maintainers recommend migrating to Zensical, which reads `mkdocs.yml`. That
  needs a new version of this decision before then.

## More Information

* Pointing `conventionalcontext.org` at GitHub Pages (a `CNAME` file and DNS)
  is a separate step, not part of this decision.
* MkDocs: <https://www.mkdocs.org/>
* Material for MkDocs: <https://squidfunk.github.io/mkdocs-material/>
