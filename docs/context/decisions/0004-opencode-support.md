# ADR-0004: Add OpenCode as Supported AI Agent

## Status

**Proposed**

## Date

2026-03-19

## Authors

@andreouellet

## Context

HARC Framework currently supports two AI coding assistants:

| Tool           | Entry Point                       |
| -------------- | --------------------------------- |
| Claude Code    | `CLAUDE.md`                       |
| GitHub Copilot | `.github/copilot-instructions.md` |

[OpenCode](https://github.com/opencode-ai/opencode) is an open-source terminal-based AI coding agent that reads `AGENTS.md` or project-level instruction files. It provides similar capabilities to Claude Code and GitHub Copilot but with a focus on open-source, local-first operation.

Adding OpenCode support expands HARC's reach to developers who prefer open-source tooling or who use multiple AI agents on the same project.

### Requirements

1. OpenCode must have access to the same project context as other agents
2. OpenCode instructions must stay synchronized with CLAUDE.md and copilot-instructions.md
3. Adding OpenCode must not break existing Claude Code or GitHub Copilot workflows

## Decision

We will add **OpenCode** as a third supported AI coding agent in the HARC Framework.

### Implementation

**Entry Point:** `AGENTS.md` (repo root)

OpenCode reads `AGENTS.md` as its primary project instruction file. This file will follow the same structure as `CLAUDE.md` and `.github/copilot-instructions.md`:

- Project description
- Stack information
- Key context file references
- Rules the agent must follow
- Current sprint focus

**Sync Strategy:** All three files (`CLAUDE.md`, `.github/copilot-instructions.md`, `AGENTS.md`) will:
1. Contain a sync notice referencing the other two files
2. Reference `docs/context/` as the source of truth for detailed rules
3. Be included in PR review checklists for sync verification

**Bootstrap Script:** The `scripts/bootstrap.sh` script will be updated to generate `AGENTS.md` alongside the other entry points.

### Updated Tool Support Matrix

| Tool           | Entry Point                       | How It Works              |
| -------------- | --------------------------------- | ------------------------- |
| Claude Code    | `CLAUDE.md`                       | Reads at session start    |
| GitHub Copilot | `.github/copilot-instructions.md` | Reads at workspace open   |
| OpenCode       | `AGENTS.md`                       | Reads at session start    |
| Cursor         | `CLAUDE.md` or `.cursorrules`     | Configure in settings     |
| Backstage      | `catalog-info.yaml`               | Software catalog + TechDocs |

## Consequences

### Positive

- Broader AI tool support increases HARC adoption
- Open-source agent option for teams that prefer or require it
- Same `docs/context/` files serve all agents — no duplication of context

### Negative

- Third file to keep synchronized (manageable with cross-reference sync pattern from ADR-0003)
- `AGENTS.md` filename is also used by BMAD Method; need to ensure compatibility

### Risks

- OpenCode is newer and its instruction file format may evolve; monitor for breaking changes

## Alternatives Considered

### Use CLAUDE.md for OpenCode too

OpenCode can be configured to read custom files, but `AGENTS.md` is its canonical entry point. Following convention reduces friction for OpenCode users.

**Verdict:** Rejected — convention over configuration.

### Skip OpenCode support

Wait until user demand is clearer.

**Verdict:** Rejected — low effort to add now; supports open-source-first principle.

## References

- [OpenCode GitHub](https://github.com/opencode-ai/opencode)
- [ADR-0003](0003-ai-instruction-sync.md) — Instruction file sync strategy
