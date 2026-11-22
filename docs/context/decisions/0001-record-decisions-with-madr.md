---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# Record decisions with MADR 4

## Context and Problem Statement

The project needs a format for decision records, both for its own decisions
and as the format the specification recommends to adopters. HARC used a
home-grown template. Which format should be used?

## Considered Options

* MADR 4 (Markdown Architectural Decision Records)
* Michael Nygard's original ADR format
* HARC's own template

## Decision Outcome

Chosen option: "MADR 4", because it is the most widely used Markdown
decision-record template, already uses `NNNN-title.md` numbering and YAML
frontmatter (`status`, `date`, `decision-makers`), and scales from a short
record to a detailed one.

### Consequences

* Good, because adopters likely know it, and existing ADR tooling reads it.
* Good, because its frontmatter covers what decision records need, so no
  extra fields are invented (see [0006](0006-minimal-yaml-frontmatter.md)).
* Bad, because MADR's section names are longer than Nygard's.

## More Information

* MADR: <https://adr.github.io/madr/>
* Numbering is required (C-022). When a decision changes, its previous
  version is archived ([0015](0015-archive-previous-decisions.md), C-023).
