# Feature: AI Agent Entry Points

## Status

`complete`

## ADR

- [ADR-0003](../decisions/0003-ai-instruction-sync.md) — Instruction file sync strategy
- [ADR-0004](../decisions/0004-opencode-support.md) — OpenCode support

## Problem Statement

Multiple AI coding tools (Claude Code, GitHub Copilot, OpenCode) each read different files as their entry point. Without a synchronization strategy, agents end up following different rules, leading to inconsistent code generation and conflicting conventions.

## Acceptance Criteria

- [x] [AC-001] `CLAUDE.md` exists at repo root as the Claude Code entry point (under 80 lines)
- [x] [AC-002] `.github/copilot-instructions.md` exists as the GitHub Copilot entry point
- [x] [AC-003] `AGENTS.md` exists at repo root as the OpenCode entry point
- [x] [AC-004] All three files contain a sync notice referencing the other two files
- [x] [AC-005] All three files share identical project context (stack, rules, sprint focus)
- [x] [AC-006] All three files point to `docs/context/` for detailed requirements, architecture, and constraints
- [x] [AC-007] Constraint [C-030] enforces that all three files must stay synchronized
- [x] [AC-008] All three files instruct agents to update `CHANGELOG.md` after changes
- [x] [AC-009] All three files instruct agents to update `scripts/bootstrap.sh` when framework changes
- [x] [AC-010] The bootstrap script generates all three entry point files

## Data Model Changes

None — these are markdown files with a defined structure.

## API Contract

Each entry point file follows this structure:

```markdown
# Project: [Name]
<!-- SYNC NOTICE -->
> [One-line description]
## What this project does
## Stack
## Key context files (table)
## Rules [agent] must follow
## Current sprint focus
## How to run common tasks
```

## Non-Functional Requirements

- Entry point files MUST fit within AI context windows — see [NFR-U02]
- `CLAUDE.md` MUST be under 80 lines — see [C-002]
- Files MUST be synchronizable via manual review or CI — see [NFR-M03]

## Out of Scope

- Automated sync validation CI pipeline (future — see [NFR-M03])
- Support for additional AI tools beyond the current three (add via new ADR)

## Open Questions

None — this feature is complete.
