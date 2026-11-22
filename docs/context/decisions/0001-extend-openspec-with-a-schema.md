---
type: decision
status: accepted
date: 2026-11-21
decision-makers: andreouellet, Hamed Minaee
---

# Extend OpenSpec with a schema

## Context and Problem Statement

The first version of Conventional Context (kept on the `alpha` branch) was a
standalone specification for `docs/context/`, with its own versioned text,
agent routing, and feature files. Research in November 2026 showed that
spec-driven development tools already cover much of it: Spec Kit's community
extensions, OpenSpec's living specs, and Kiro's steering files. OpenSpec is
the lightest of these and is growing fast (npm downloads went from about
70,000 a month in January 2026 to about 3.3 million in October). How should
Conventional Context add what these tools lack without competing with them?

## Considered Options

* Extend OpenSpec with a schema
* Standalone specification (the `alpha` approach)
* Fork OpenSpec or Spec Kit
* Contribute the features upstream to OpenSpec or Spec Kit

## Decision Outcome

Chosen option: "Extend OpenSpec with a schema", because a schema is OpenSpec's supported extension point, reaches its users without a new tool, and costs little to maintain.

* Support for other tools (a Spec Kit extension, a Kiro steering file) is on the roadmap.

### Consequences

* Good, because users install one folder into a tool they already use.
* Good, because there is no CLI or fork to maintain.
* Bad, because Conventional Context depends on OpenSpec's schema format, which is marked experimental.
* Bad, because projects that do not use OpenSpec cannot use it yet.

## More Information

* OpenSpec: <https://github.com/Fission-AI/OpenSpec>
* Earlier approach: the `alpha` branch of this repository
