---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# Extend OpenSpec with a schema

## Context and Problem Statement

Spec-driven development tools (OpenSpec, Spec Kit, Kiro) already record
what a system should do, one change at a time. What they do not record well
is the project's intent: who it is for, its rules, and the decisions behind
it. How should Conventional Context add that?

## Considered Options

* A schema for OpenSpec, based on OpenSpec's default `spec-driven` schema
* A standalone specification with its own tools
* A fork of OpenSpec or Spec Kit
* Building on the `intent-driven` community schema for OpenSpec

## Decision Outcome

Chosen option: "A schema for OpenSpec, based on `spec-driven`", because a schema is OpenSpec's own way to extend it, so OpenSpec users get Conventional Context without a new tool, and OpenSpec is lightweight and widely used.

* The schema is OpenSpec's `spec-driven` steps plus one step, `context`. OpenSpec's text is kept unchanged, and every addition is marked "Conventional Context:" (C-003), so new OpenSpec releases are easy to take in.
* Versions for other tools (Spec Kit, Kiro) are on the roadmap.

### Consequences

* Good, because people use a tool they may already know.
* Good, because there is no tool or fork to maintain.
* Bad, because it depends on OpenSpec's schema format, which OpenSpec still calls experimental.
* Bad, because projects without OpenSpec cannot use it yet.

## More Information

* OpenSpec: <https://github.com/Fission-AI/OpenSpec>
* `intent-driven` schema: <https://github.com/intent-driven-dev/openspec-schemas>
