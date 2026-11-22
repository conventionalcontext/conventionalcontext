---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# Publish the schema where OpenSpec looks for it

## Context and Problem Statement

OpenSpec finds a custom schema in a project's `openspec/schemas/<name>/`. It
has no command to install a schema from the internet. Where should the
schema live, and how do other projects get it?

## Considered Options

* In `openspec/schemas/conventional-context/`; projects copy that folder from a release and commit it
* In a separate folder, linked into `openspec/schemas/`
* Installed per user, in `~/.local/share/openspec/schemas/`

## Decision Outcome

Chosen option: "In `openspec/schemas/conventional-context/`, copied from a release", because it is where OpenSpec looks, projects copy from and to the same path, and this repository uses its own schema with no extra setup.

* The README has a one-line command that copies the folder from a tagged release.
* Committing the copy pins the version for the whole team and for CI.

### Consequences

* Good, because nothing depends on symbolic links, which break on some systems.
* Bad, because each project holds its own copy, so upgrading means copying a newer release.
