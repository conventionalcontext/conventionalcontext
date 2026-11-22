---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# MIT license

## Context

Projects copy the schema and templates into their own repositories, and may change them. The schema text comes from OpenSpec, which uses the MIT license, and is kept unchanged.

## Problem Statement

Which license, or licenses, should cover this repository? The license should let projects copy and change the files freely, and be compatible with OpenSpec's. A different license per folder is possible, but harder to apply and explain.

## Considered Options

* MIT for everything
* Apache-2.0 for everything
* Different licenses for different folders

## Decision Outcome

Chosen option: "MIT for everything", because it matches OpenSpec and lets projects copy the files freely.

### Consequences

* Good, because one license is simple to apply and explain.
* Bad, because MIT has no explicit patent grant, unlike Apache-2.0.
