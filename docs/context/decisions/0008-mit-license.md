---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# MIT license

## Context and Problem Statement

Projects copy the schema and templates into their own repositories. The
schema text comes from OpenSpec, which uses the MIT license.

## Considered Options

* MIT for everything
* Apache-2.0 for everything
* Different licenses for different folders

## Decision Outcome

Chosen option: "MIT for everything", because it matches OpenSpec and lets projects copy the files freely.

### Consequences

* Good, because one license is simple to apply and explain.
* Bad, because MIT has no explicit patent grant, unlike Apache-2.0.
