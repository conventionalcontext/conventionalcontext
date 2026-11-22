---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Versioning of releases and specification text

## Context and Problem Statement

Adopters need to know which version of the specification they follow, and
the specification must be able to change without breaking repositories that
followed an earlier version. How are releases and the specification text
versioned?

## Considered Options

* SemVer releases; specification text frozen per minor version in
  `spec/vX.Y/`; the index declares the version followed
* One living specification file with version history in the changelog

## Decision Outcome

Chosen option: "SemVer releases, frozen text per minor version".

* Releases are tagged `vMAJOR.MINOR.PATCH` (SemVer) and described in
  `CHANGELOG.md` (Keep a Changelog).
* The specification text for each minor version lives in `spec/vX.Y/SPEC.md`
  and is not edited after release, except for typo-level fixes in patch
  releases.
* An adopting repository declares the version it follows in its index
  frontmatter, as `MAJOR.MINOR` (for example `conventionalcontext: "0.1"`).
* Through 0.x, the specification, templates, and this repository's
  `docs/context/` evolve together, and minor versions may change the
  specification incompatibly.

### Consequences

* Good, because a repository's declared version always points to unchanging
  text.
* Good, because the optional upgrade path (FR-015) can compare one version's
  text with another's.
* Bad, because each minor version adds a directory of specification text.
