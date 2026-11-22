---
type: decision
status: accepted
date: 2026-11-22
decision-makers: andreouellet, Hamed Minaee
---

# Publish the schema at openspec/schemas/conventional-context/; adopters copy it

## Context and Problem Statement

OpenSpec finds a custom schema in a project's `openspec/schemas/<name>/`, or
in the user's `~/.local/share/openspec/schemas/<name>/`. It has no command to
install a schema from a URL. This repository needs to publish the schema so
other projects can use it, and also use the schema itself. Where should the
schema live, and how do other projects get it?

## Considered Options

* The schema lives at `openspec/schemas/conventional-context/`; adopters copy that folder into the same path and commit it
* The schema lives in a separate `schema/` folder, with a symlink from `openspec/schemas/`
* Adopters install it per user in `~/.local/share/openspec/schemas/`

## Decision Outcome

Chosen option: "The schema lives at `openspec/schemas/conventional-context/`", because it is where OpenSpec looks, it matches how other community schemas are published (for example `intent-driven`), and this repository then uses its own schema with no symlink.

* Adopters copy the folder from a tagged release into
  `openspec/schemas/conventional-context/` and commit it, so the version is
  pinned and teammates and CI have it. The README gives a one-line command.
* The per-user location is documented for trying it out, not recommended for
  teams.

### Consequences

* Good, because adopters copy from and to the same path.
* Good, because nothing depends on symlinks, which break on some Windows
  checkouts.
* Bad, because the published schema sits in the same folder as this
  repository's own OpenSpec specs and changes; the README and architecture
  say which is which.
* Bad, because each project holds its own copy; upgrading means copying a
  newer release.
