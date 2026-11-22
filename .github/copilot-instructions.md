# Project: HARC Framework

<!-- ============================================================
  .github/copilot-instructions.md — Entry point for GitHub Copilot
  ============================================================
  This is the FIRST file GitHub Copilot reads. Keep it under 80 lines.
  Use it to navigate, not to explain.

  HOW TO MAINTAIN THIS FILE:
  - Update "Current sprint focus" at the start of each sprint
  - Update "Stack" when dependencies change
  - Update "Rules" when new constraints are identified (needs team review)
  - Do NOT write requirements or architecture detail here — use docs/context/

  SYNC REQUIREMENT:
  - This file, CLAUDE.md, and AGENTS.md share the same project context.
    When you update this file, also update CLAUDE.md and AGENTS.md to keep
    all AI assistant entry points in sync.
  ============================================================ -->

> Human Agentic Readable Context — A framework for structuring AI-accessible project context in git repositories.

## What this project does

HARC defines a standard structure for project requirements, architecture, decisions, and constraints that AI coding assistants (Claude Code, GitHub Copilot, OpenCode) can read to work effectively. It enables context to evolve with code rather than becoming stale documentation.

## Stack

- **Type:** Framework/documentation structure (not an application)
- **Languages:** Markdown, YAML, Shell, Python (for tooling)
- **Integrations:** Backstage IDP (optional), GitHub Actions, GitLab CI
- **Rendering:** MkDocs for static site generation

## Key context files

<!-- The AI assistant reads these for depth. Keep paths accurate. -->

| File                                    | Contents                                    |
| --------------------------------------- | ------------------------------------------- |
| `docs/context/requirements.md`              | HARC framework requirements                 |
| `docs/context/architecture.md`              | Layered architecture and component diagram  |
| `docs/context/constraints.md`               | Rules for context files and ADRs            |
| `docs/context/glossary.md`                  | Domain terms (HARC, ADR, Entry Point, etc.) |
| `docs/context/decisions/`                   | ADRs for HARC design decisions              |
| `docs/context/features/ticket-system.md`    | In-git ticket system feature spec           |
| `docs/context/roadmap.md`                   | Project roadmap and planned milestones      |
| `CHANGELOG.md`                           | Living changelog (update on changes)        |

## Rules the AI assistant must follow

<!-- Non-negotiable. Treat these as hard constraints.
     SYNC: Keep CLAUDE.md rules in sync with these. -->

- Context files MUST be updated in the same PR as related changes
- ADRs are APPEND-ONLY — never edit past decisions; create new ADRs that supersede
- ADRs MUST be named `NNNN-kebab-case-title.md` with sequential numbering
- ADRs MUST include: Status, Date, Context, Decision, Consequences
- To reverse a decision, create a new ADR with status "Supersedes ADR-NNNN"
- Feature specs MUST be created before implementation begins
- Acceptance criteria MUST use checkbox format: `- [ ] [AC-NNN] description`
- Tables MUST use proper column-aligned formatting
- When updating this file, also update `CLAUDE.md` and `AGENTS.md` to keep all AI assistant entry points in sync
- After completing features or significant changes, append entry to `CHANGELOG.md` under `[Unreleased]`
- `README.md` MUST include a bullet-point list of project features just below the project title and description, linking to the corresponding `docs/context/features/` spec files — update this list when features are added, removed, or renamed
- Any change to framework files, templates, or structure MUST be reflected in `scripts/bootstrap.sh` — the bootstrap script must always produce output consistent with the current framework design

## Current sprint focus

<!-- Update this at the start of each sprint. The AI assistant uses it to
     understand what is actively being worked on and what to prioritise. -->

Sprint: 2026-Q1-S2
Focus: In-git ticket system MVP — see `docs/context/features/ticket-system.md`
Active features:
- [ADR-0001](docs/context/decisions/0001-harc-framework-adoption.md) — Framework adoption
- [ADR-0002](docs/context/decisions/0002-in-git-ticket-system.md) — Ticket system design
- [ADR-0003](docs/context/decisions/0003-ai-instruction-sync.md) — Instruction file sync
- [ADR-0004](docs/context/decisions/0004-opencode-support.md) — OpenCode support
- [Feature: Ticket System](docs/context/features/ticket-system.md) — In-git tickets

## How to run common tasks

<!-- Key workflows for this project -->

- **New feature** — create spec in `docs/context/features/[name].md` using the template
- **New ADR** — create record in `docs/context/decisions/[NNNN]-[topic].md`
- **Update context** — sync `docs/context/` files after a significant change
- **Review PR** — run pre-merge checklist against `docs/context/constraints.md`

## Markdown Formatting Standards

When generating markdown tables, always format them with proper column alignment in the source:

```markdown
| Column 1 | Column 2 | Column 3 |
| -------- | -------- | -------- |
| Value 1  | Value 2  | Value 3  |
| Value 4  | Value 5  | Value 6  |
```

NOT like this:

```markdown
| Column 1 | Column 2 | Column 3 |
|---|---|---|
| Value 1 | Value 2 | Value 3 |
```
