---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet, Hamed Minaee
---

# MIT license for the whole repository

## Context and Problem Statement

The previous version (tag `archive/cc-spec`) licensed parts differently (CC-BY-4.0, CC0-1.0,
Apache-2.0). Adopters copy the schema and templates into their own
repositories, and OpenSpec is MIT-licensed.

## Considered Options

* MIT for everything
* Apache-2.0 for everything
* Licenses by directory

## Decision Outcome

Chosen option: "MIT for everything", because it matches OpenSpec, from which the schema text is copied, and lets adopters copy files freely.

### Consequences

* Good, because one license is simple to apply and explain.
* Bad, because MIT has no explicit patent grant, unlike Apache-2.0.
