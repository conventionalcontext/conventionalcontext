---
type: decision
status: proposed
date: 2026-10-08
decision-makers: andreouellet
---

# Changelog and release automation

## Context and Problem Statement

This repository writes commit messages in Conventional Commits (C-025) and
keeps `CHANGELOG.md` by hand in the Keep a Changelog format (C-026,
[0013](0013-versioning.md)). Conventional Commits make it possible to
generate the changelog and to automate version bumps and releases. Should
this repository generate its changelog, automate its releases, or both?

This record is not decided. Until it is accepted, `CHANGELOG.md` stays
hand-written in the Keep a Changelog format, and releases are tagged by hand.
0.1.0 is released that way.

This concerns this repository's own workflow only. The specification does
not require adopters to use any of these conventions or tools (NFR-005,
C-003).

## Decision Drivers

* Adopters read the changelog to learn what changed in the specification, so
  it must explain changes to prose clearly, not only list commits.
* Through 0.x, minor versions may change the specification incompatibly
  ([0013](0013-versioning.md)); a breaking change must not force 1.0.0.
* A maintainer decides when a release happens and when a version's
  specification text is frozen in `spec/vX.Y/`.
* Prefer conventions and tools with moderate to good adoption (C-020).
* Keep the workflow cheap to run and to explain.

## Considered Options

Changelog:

* Keep a Changelog, written by hand (current)
* conventional-changelog, generated from Conventional Commits
* Hybrid: generate a draft from commits, curate it into Keep a Changelog
  sections before each release

Release automation:

* None: tag and publish releases by hand (current)
* release-please: opens a release pull request with the version bump and
  changelog; a maintainer merges it to release
* semantic-release: releases automatically on merge, configured for 0.x

## Decision Outcome

Not yet decided.

## Pros and Cons of the Options

### Keep a Changelog, written by hand

* Good, because a maintainer explains what changed for adopters, groups
  related changes, and leaves out noise.
* Good, because it needs no tooling.
* Bad, because it is easy to forget to update.

### conventional-changelog, generated

* Good, because no change is forgotten and there is no manual step.
* Good, because it feeds automatic version bumps.
* Bad, because it is only as good as the commit messages; prose changes
  (`docs:` commits, most of this project) are lumped together or hidden,
  depending on the preset.
* Bad, because it needs Node and a configuration file.

### Hybrid

* Good, because commits provide a complete draft and a maintainer still
  writes for readers.
* Bad, because it keeps a manual step before every release.

### release-please

* Good, because the release pull request keeps a maintainer in control of
  when and what is released.
* Good, because it supports 0.x (breaking changes bump the minor version)
  and runs as a GitHub Action without a `package.json`.
* Bad, because it ties releases to GitHub.

### semantic-release

* Good, because it is widely used and fully automatic.
* Good, because it matches the planned separate template repository.
* Bad, because by default its first release is 1.0.0 and a breaking change in
  0.x bumps to 1.0.0; it needs custom release rules to stay in 0.x.
* Bad, because releasing on every merge removes the maintainer's decision on
  when to release and freeze specification text.

## More Information

* Keep a Changelog: <https://keepachangelog.com/en/1.1.0/>
* conventional-changelog: <https://github.com/conventional-changelog/conventional-changelog>
* release-please: <https://github.com/googleapis/release-please>
* semantic-release: <https://semantic-release.gitbook.io/>
* If accepted with a generated changelog, this record supersedes the
  changelog part of [0013](0013-versioning.md) and changes C-026.
* A commit-message check on pull requests (for example commitlint) can be
  adopted with either changelog option.
