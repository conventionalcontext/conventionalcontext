---
type: decision
status: accepted
date: 2026-11-16
decision-makers: andreouellet
---

# Keep only current decisions in `decisions/`; archive previous versions

## Context and Problem Statement

The usual ADR practice, and this project's first rule (C-023), is that an
accepted decision record is never rewritten. A changed decision gets a new
record that supersedes the old one, and both stay in `decisions/`.

Over time that fills `decisions/` with records that no longer hold. A reader
new to the project, person or agent, must follow "superseded by" links to
find what is true today, and an agent that reads an old record may act on
it. How should changed decisions be recorded so that `decisions/` is easy to
read, while the history is kept?

## Decision Drivers

* A reader should see only what holds today in `decisions/`.
* The reasoning behind earlier versions must not be lost.
* Links to a decision should keep working when it changes.
* Agents should not have to work out which records are still valid.

## Considered Options

* Archive previous versions: `decisions/` holds the current version of each
  decision; previous versions move to `decisions/archive/`
* Supersede with a new record (MADR practice); all records stay in
  `decisions/`
* Edit records in place and rely on git history

## Decision Outcome

Chosen option: "Archive previous versions", because `decisions/` then answers
"what holds today?" directly, and the archive answers "what did we decide
before, and why?".

When a decision changes:

1. Move the current file to
   `decisions/archive/NNNN-title-in-kebab-case-YYYY-MM-DD.md`, where the date
   is that version's `date`. Change only its `status`, to `superseded`.
2. Update `decisions/NNNN-title-in-kebab-case.md` in place with the new
   decision and a new `date`. It keeps its number and file name, so links to
   it keep working.
3. Add or extend a `## Previous decisions` section at the end of the current
   file, linking each archived version with one line on what changed.

Rules:

* `decisions/` holds decisions with status `proposed`, `accepted`,
  `rejected`, or `deprecated`. `decisions/archive/` holds only `superseded`
  versions.
* Archived files are never edited again, except that relative links to
  other decision records get a `../` prefix when the file is moved, so
  they keep working.
* Corrections that do not change a decision (typos, broken links, clearer
  wording) are made in place without archiving.
* A new, unrelated decision still gets the next number.

This replaces the "never rewrite, supersede" part of C-023 and FR-006.

### Consequences

* Good, because `decisions/` reads as the current set of decisions.
* Good, because links stay stable and the full history is one click away.
* Bad, because it differs from common ADR practice, so the specification and
  the templates must explain it.
* Bad, because ADR tools that expect "superseded by" links may not follow the
  archive.

## More Information

* First applied to [0011](0011-repository-layout.md).
* MADR: <https://adr.github.io/madr/>
