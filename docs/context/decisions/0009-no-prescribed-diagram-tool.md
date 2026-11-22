---
type: decision
status: accepted
date: 2026-10-08
decision-makers: andreouellet
---

# No prescribed diagram tool

## Context and Problem Statement

HARC required Mermaid diagrams because GitHub and GitLab render them. In
practice Mermaid's results were disappointing, and teams prefer different
tools (Mermaid, D2, PlantUML, draw.io, Excalidraw). Should the specification
prescribe a diagram format, and what should this repository use?

## Considered Options

* No prescribed tool; diagrams optional; each repository declares its choice
  in `AGENTS.md`
* Require Mermaid
* Require images in a fixed directory

## Decision Outcome

Chosen option: "No prescribed tool". Context files must be understandable
without diagrams (C-002). A repository declares its choice in the
`## Conventions` section of `AGENTS.md`, for example
`- Diagrams: none | mermaid | d2 | images in assets/`, and agents follow it.

This repository uses no diagrams in 0.1. Structure is described with tables
and directory trees. Choosing a diagram approach for this repository is on the
roadmap.

### Consequences

* Good, because adopters keep their existing diagram tooling.
* Good, because agents know which format to produce.
* Bad, because tools cannot assume a diagram format when checking files.
