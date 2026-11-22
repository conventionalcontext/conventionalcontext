# Project: HARC Framework

<!-- SYNC NOTICE: This file must stay synchronized with CLAUDE.md and .github/copilot-instructions.md
     When updating rules here, also update the corresponding sections in both files.
     The source of truth for constraints is docs/context/constraints.md -->

> Human Agentic Readable Context — A framework for structuring AI-accessible project context in git repositories.

## What this project does

HARC defines a standard structure for project requirements, architecture, decisions, and constraints that AI coding assistants (Claude Code, GitHub Copilot, OpenCode) can read to work effectively. It enables context to evolve with code rather than becoming stale documentation.

## Stack

- **Type:** Framework/documentation structure (not an application)
- **Languages:** Markdown, YAML, Shell, Python (for tooling)
- **Integrations:** Backstage IDP (optional), GitHub Actions, GitLab CI
- **Rendering:** MkDocs for static site generation

## Key context files

| File                                  | Contents                                     |
| ------------------------------------- | -------------------------------------------- |
| `docs/context/requirements.md`            | HARC framework requirements                  |
| `docs/context/architecture.md`            | Layered architecture and component diagram   |
| `docs/context/constraints.md`             | Rules for context files and ADRs             |
| `docs/context/glossary.md`                | Domain terms (HARC, ADR, Entry Point, etc.)  |
| `docs/context/decisions/`                 | ADRs for HARC design decisions               |
| `docs/context/features/ticket-system.md`  | In-git ticket system feature spec            |
| `docs/context/roadmap.md`                 | Project roadmap and planned milestones       |
| `CHANGELOG.md`                        | Living changelog (update on changes)         |

## Rules this agent must follow

- Context files MUST be updated in the same PR as related changes
- ADRs are APPEND-ONLY — never edit past decisions; create superseding ADRs
- All changes here MUST be mirrored in `CLAUDE.md` and `.github/copilot-instructions.md`
- Tables MUST use proper column-aligned formatting
- Feature specs MUST be created before implementation
- After completing features or significant changes, append entry to `CHANGELOG.md` under `[Unreleased]`
- `README.md` MUST include a bullet-point list of project features just below the project title and description, linking to the corresponding `docs/context/features/` spec files — update this list when features are added, removed, or renamed
- Any change to framework files, templates, or structure MUST be reflected in `scripts/bootstrap.sh` — the bootstrap script must always produce output consistent with the current framework design

## Current sprint focus

Sprint: 2026-Q1-S2
Focus: In-git ticket system MVP — see `docs/context/features/ticket-system.md`
Active ADRs:
- [ADR-0001](docs/context/decisions/0001-harc-framework-adoption.md) — Framework adoption
- [ADR-0002](docs/context/decisions/0002-in-git-ticket-system.md) — Ticket system design
- [ADR-0003](docs/context/decisions/0003-ai-instruction-sync.md) — Instruction file sync
- [ADR-0004](docs/context/decisions/0004-opencode-support.md) — OpenCode support

## How to run common tasks

- **New feature** — create spec in `docs/context/features/[name].md` using the template
- **New ADR** — create record in `docs/context/decisions/[NNNN]-[topic].md`
- **Update context** — sync `docs/context/` files after a significant change
- **Review PR** — run pre-merge checklist against `docs/context/constraints.md`
