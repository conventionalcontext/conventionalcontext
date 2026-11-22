---
type: decision
status: accepted
date: 2026-11-16
decision-makers: andreouellet
---

# Project website with Zensical in `docs/website/`

## Context and Problem Statement

People who hear about Conventional Context need to understand in a minute
what it is, why it matters, and how to start, without reading the
repository. `conventionalcontext.org` currently redirects to the GitHub
repository. Comparable specifications (Conventional Commits, Keep a
Changelog, SemVer) each have a short website with a quick summary and the
full specification. How should this project publish one, and with which
tool?

The first version of this decision chose MkDocs with Material for MkDocs.
Building the site then printed this warning: Material for MkDocs reaches end
of life on 5 May 2027, with only critical fixes and security updates until
then, and Zensical, built by the same team, is its maintained successor.
Starting a new website on a tool with a known end of life would mean a
migration within months.

## Decision Drivers

* Written in Markdown, in this repository, reviewed in the same pull
  requests as everything else.
* Cheap to build and host; no server to run.
* A maintained tool, not one with a known end of life.
* Keep the work already done: the theme, the home page template, and the
  Markdown extensions.

## Considered Options

* Zensical, hosted on GitHub Pages
* MkDocs with Material for MkDocs, then migrate to Zensical before May 2027
* A different static site generator such as Hugo or Jekyll
* No website; the README is the landing page

## Decision Outcome

Chosen option: "Zensical on GitHub Pages", because it builds Markdown into a
static site with search and light and dark themes, is maintained, and reads
the existing `mkdocs.yml`, so the site built unchanged when tried. No
migration is needed later.

* The website lives in `docs/website/` ([0011](0011-repository-layout.md)):
  `mkdocs.yml`, `requirements.txt` with the pinned Zensical version, `src/`
  for pages, and `overrides/` for the home page.
* The configuration stays in `mkdocs.yml`, which Zensical reads. Moving it to
  `zensical.toml` is not required, and is not done now.
* The theme uses Zensical's `classic` variant, which keeps the Material look
  and the brand colours. The default `modern` variant ignored the custom
  colours (a near-black header instead of the logo's blue).
* Three entry points, like conventionalcommits.org: **Quick Summary** (the
  home page), **Full Specification**, and **Contribute**.
* Colours come from the logo: a deep blue to blue to teal gradient.
* Tooling is run with [uv](https://docs.astral.sh/uv/)
  (`uv run --no-project --with-requirements docs/website/requirements.txt
  zensical ...`), locally and in CI. Nothing is installed by hand, and `pip`
  is not used.
* `.github/workflows/website.yml` builds the site with `--strict` on every
  pull request that touches it, and deploys it to GitHub Pages on push to
  `main`.
* The website is licensed Apache-2.0 with the rest of the repository
  ([0010](0010-license-by-directory.md)).
* Until `spec/v0.1/SPEC.md` exists, the specification page summarises the
  agreed requirements and is marked as a draft.

### Consequences

* Good, because the project has a short, shareable explanation that matches
  the README.
* Good, because the website is reviewed like any other change.
* Good, because the site does not depend on a tool with a known end of life.
* Bad, because Zensical is new (version 0.1.x when adopted), so its
  behaviour and configuration may still change; the version is pinned, and
  upgrades are checked with `--strict` and by looking at the site.
* Bad, because the README and the website overlap and must be kept
  consistent.
* Bad, because Zensical does not document whether a template that extends
  `main.html` (our home page) is supported; it works in the pinned version,
  so an upgrade must keep it working.

## More Information

* Pointing `conventionalcontext.org` at GitHub Pages (a `CNAME` file and DNS)
  is a separate step, not part of this decision.
* Zensical: <https://zensical.org/>
* Migrating from MkDocs: <https://zensical.org/docs/compatibility/mkdocs/migration/>

## Previous decisions

* [2026-11-16](archive/0016-project-website-2026-11-16.md): MkDocs with
  Material for MkDocs. Changed to Zensical because Material for MkDocs
  reaches end of life on 5 May 2027.
