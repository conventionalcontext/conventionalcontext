---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# Decision records, with an archive for earlier versions

## Context

Decision records explain what was decided, and why. They are read by people who want to know what holds today: reviewers, newcomers, and agents planning a change. The usual practice is that records never change: a new record replaces an old one, and the old one is marked superseded.

## Problem Statement

That practice makes readers follow chains of links to find what holds today, and the folder fills with records that no longer apply. Editing a record in place keeps it current, but hides the earlier version in git history. How should a changed decision be recorded, so that current decisions are easy to find and earlier ones are not lost?

## Considered Options

* MADR 4 records, updated in place, with earlier versions moved to `decisions/archive/`
* Records never change, and a new record replaces an old one
* Edit in place and rely on git history

## Decision Outcome

Chosen option: "Updated in place, with an archive", because `decisions/` then shows only what holds today, links keep working, and earlier versions are one click away.

* To change a decision: move the current file unchanged, with status `superseded`, to `decisions/archive/NNNN-title-YYYY-MM-DD.md`; update the original in place; list the archived version under `## Previous decisions`.
* Corrections that do not change a decision are made in place.

### Consequences

* Good, because readers see only current decisions.
* Bad, because it differs from common practice, so the schema and templates explain it.

## More Information

* MADR: <https://adr.github.io/madr/>
