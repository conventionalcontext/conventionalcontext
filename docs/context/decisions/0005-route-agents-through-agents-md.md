---
type: decision
status: accepted
date: 2026-11-16
decision-makers: andreouellet
---

# Route agents through AGENTS.md

## Context and Problem Statement

Each agent tool reads its own instruction file. HARC kept three files
(`CLAUDE.md`, `.github/copilot-instructions.md`, `AGENTS.md`) with the same
content and a rule to keep them synchronized, which was easy to break. How
should agents be routed to `docs/context/`, and where should a repository
declare choices such as its diagram tool?

## Considered Options

* `AGENTS.md` only; tool-specific files optional one-line pointers
* `AGENTS.md` plus a required `CLAUDE.md`
* No named entry file; whatever the tool reads must point to `docs/context/`
* HARC's three synchronized files

## Decision Outcome

Chosen option: "`AGENTS.md` only", because AGENTS.md is an open format read
by most coding agents, and one file cannot drift out of sync with itself.

* `AGENTS.md` routes agents to `docs/context/README.md` first.
* `AGENTS.md` has a `## Conventions` section declaring choices that affect how
  context is written, for example `- Diagrams: none`. It is a free-form list,
  not a schema.
* A tool that does not read `AGENTS.md` gets a one-line pointer file (for
  example a `CLAUDE.md` that references `AGENTS.md`), described in the
  AGENTS.md adapter.
* Claude Code, the best-known tool that needed such a pointer, now reads
  `AGENTS.md` in recent versions when a repository has no `CLAUDE.md`. A
  repository that keeps a `CLAUDE.md` should still make it a one-line pointer,
  because `CLAUDE.md` takes precedence over `AGENTS.md`.

### Consequences

* Good, because there is nothing to synchronize.
* Good, because conventions are declared where agents already look.
* Good, because the most widely used agents now read `AGENTS.md` directly, so
  pointer files are the exception.
* Bad, because tools that do not read `AGENTS.md` still need a pointer file.

## More Information

* AGENTS.md: <https://agents.md/>

## Previous decisions

* [2026-10-08](archive/0005-route-agents-through-agents-md-2026-10-08.md):
  tools that do not read `AGENTS.md`, with Claude Code as the example, need a
  pointer file. Updated because Claude Code now reads `AGENTS.md` itself.
