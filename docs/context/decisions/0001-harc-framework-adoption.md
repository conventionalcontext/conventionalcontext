# ADR-0001: Adopt HARC Framework for AI-Assisted Development

## Status

**Proposed** — Framework defined; implementation in progress.

## Date

2026-03-18

## Authors

@andreouellet

## Context

Modern software development increasingly involves AI coding assistants (Claude Code, GitHub Copilot, Cursor) that can generate, refactor, and review code. However, these AI agents face a fundamental limitation: **they start each session with no project context**.

### The Problem

Without structured context, AI agents:
- Don't understand what the project does or why it exists
- Don't know the architecture, patterns, or constraints
- Can't see requirements, acceptance criteria, or feature specs
- Have no visibility into decisions made and their rationale
- Generate code that may conflict with established patterns
- Require humans to re-explain the project in every session

### The Opportunity

Internal Developer Platforms (IDPs) built on Backstage already solve a similar problem for humans: providing a single pane of glass for service documentation, ownership, dependencies, and standards. The same principles can serve AI agents.

### Requirements

1. Context files must be **machine-readable** (AI agents can parse them)
2. Context files must be **human-readable** (developers can review and update them)
3. Context must **evolve with the code** (updated in the same PR as code changes)
4. Context must integrate with **Backstage/IDP** (single source of truth)
5. Context structure must be **standardized** (consistent across all repos)
6. Context must support **agentic development workflows** (BMAD Method compatibility)

## Decision

We will adopt the **HARC Framework** (Human Agentic Readable Context) as the standard structure for AI-accessible project context.

### Framework Overview

HARC provides a layered architecture where:

```
┌─────────────────────────────────────────────────────────────────┐
│  BACKSTAGE / IDP LAYER                                          │
│  catalog-info.yaml · software templates · TechDocs · scorecards │
└────────────────────────┬────────────────────────────────────────┘
                         │ syncs from repo
┌────────────────────────▼───────────────────────────────────────┐
│  REPO ROOT — machine-readable context layer                    │
│  CLAUDE.md · .github/copilot-instructions.md · docs/context/       │
└────────────┬───────────────────────────────┬───────────────────┘
             │                               │
┌────────────▼──────────┐   ┌───────────────▼───────────────────┐
│  REQUIREMENTS         │   │  ARCHITECTURE                     │
│  docs/context/            │   │  docs/context/architecture.md         │
│  requirements.md      │   │  docs/context/decisions/              │
│  features/            │   │  openapi specs                    │
└────────────┬──────────┘   └───────────────┬───────────────────┘
             │                              │
             └──────────────┬───────────────┘
                            │ informs
┌───────────────────────────▼───────────────────────────────────┐
│  AI AGENT ENTRY POINTS                                        │
│  CLAUDE.md (Claude Code) · copilot-instructions.md (Copilot)  │
│  .claude/commands/ (slash commands)                           │
└───────────────────────────┬───────────────────────────────────┘
                            │ produces + updates
┌───────────────────────────▼───────────────────────────────────┐
│  LIVING ARTIFACTS (auto-updated)                              │
│  CHANGELOG.md · API diff · test coverage · feature flags      │
└───────────────────────────────────────────────────────────────┘
```

### Directory Structure

```
repo-root/
├── CLAUDE.md                    # Claude Code entry point (navigation doc)
├── AGENTS.md                    # OpenCode entry point
├── .github/
│   └── copilot-instructions.md  # GitHub Copilot instructions
├── catalog-info.yaml            # Backstage component descriptor (optional)
├── CHANGELOG.md                 # Living artifact (auto-updated by AI agents)
│
├── docs/context/                    # Persistent project memory
│   ├── requirements.md          # What the system must do
│   ├── architecture.md          # How the system is designed
│   ├── constraints.md           # Rules that must not be broken
│   ├── glossary.md              # Domain language reference
│   ├── decisions/               # Architecture Decision Records
│   │   └── NNNN-title.md
│   └── features/                # Feature specifications
│       └── feature-name.md
│
├── .claude/                     # Claude Code extensions
│   └── commands/                # Slash commands
│       ├── new-feature.md
│       ├── create-adr.md
│       ├── update-context.md
│       └── review-pr.md
│
└── docs/                        # Human docs (optional: Backstage TechDocs source)
    ├── mkdocs.yml
    └── index.md
```

### Core Principles

1. **Context files are first-class code artifacts** — edited in the same PR as code, reviewed in code review, enforced by CI.

2. **CLAUDE.md is a navigation document** — under 80 lines, points to depth in `docs/context/`, never contains all detail itself.

3. **`docs/context/` is the persistent memory** — requirements, architecture, constraints, decisions, and features live here.

4. **ADRs are append-only** — never edit past decisions; supersede with new ADRs.

5. **Feature specs precede implementation** — Claude Code reads the spec before building.

6. **The feedback loop is continuous** — agents update context as they build, context informs future agents.

### Tool-Specific Entry Points

| Tool                        | Entry Point                       | Purpose                          |
| --------------------------- | --------------------------------- | -------------------------------- |
| Claude Code                 | `CLAUDE.md`                       | First file read each session     |
| GitHub Copilot              | `.github/copilot-instructions.md` | Workspace-level instructions     |
| OpenCode                    | `AGENTS.md`                       | First file read each session     |
| Backstage                   | `catalog-info.yaml`               | Service catalog + TechDocs (opt) |
| Human developers            | `README.md` + `docs/context/`         | Onboarding and reference         |

### BMAD Method Compatibility

HARC is designed to work alongside or integrate with the BMAD Method:

| BMAD Concept            | HARC Equivalent                                        |
| ----------------------- | ------------------------------------------------------ |
| PRD                     | `docs/context/requirements.md` + `docs/context/features/`      |
| Architecture doc        | `docs/context/architecture.md`                             |
| ADRs                    | `docs/context/decisions/`                                  |
| Sprint status           | `tickets` branch (see ADR-0002)                        |
| Story files             | `docs/context/features/` or `tickets` branch               |
| Project context         | `CLAUDE.md` + `docs/context/constraints.md`                |

## Consequences

### Positive

- AI agents have consistent, structured context across all sessions
- Same source files serve humans, AI agents, and optionally Backstage
- Context evolves with code (never stale by design)
- Decisions are recorded and discoverable
- New team members (human or AI) can onboard from repo alone
- Backstage scorecards can enforce context quality

### Negative / Trade-offs

- Additional files to maintain in every repo
- Requires discipline to update context with code changes
- Learning curve for teams unfamiliar with ADRs and structured docs
- Two entry points (CLAUDE.md + copilot-instructions.md) require sync

### Risks

- Context files become stale if process discipline lapses
- Over-documentation — too much in CLAUDE.md wastes context window
- Under-documentation — missing constraints leads to AI mistakes

### Mitigations

- CI checks for context file presence and recency
- Backstage scorecard rules (context freshness < 90 days)
- PR template checklist includes context update verification
- CLAUDE.md and copilot-instructions.md cross-reference each other

## Implementation

### Bootstrap Script

A bootstrap script (`scripts/bootstrap.sh`) creates the full HARC structure with template content:

```bash
# Works for both new and existing repos:
./scripts/bootstrap.sh
```

### Getting Started

1. Run bootstrap script in new or existing repo
2. Fill in `[PLACEHOLDER]` values in generated files
3. Create first ADR for any significant decision already made
4. Add feature specs for current work
5. Register component in Backstage (point to `catalog-info.yaml`)
6. Add CI checks for context validation

### Template Repository

The `aipk-template-base` repo provides:
- Pre-configured directory structure
- Template files with guidance comments
- Bootstrap script for existing repos
- Example ADR and feature spec

## References

- [Backstage](https://backstage.io/) — IDP framework
- [ADR](https://adr.github.io/) — Architecture Decision Records
- [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD) — AI-driven agile development
- [Claude Code](https://claude.ai/code) — AI coding assistant
- [GitHub Copilot](https://github.com/features/copilot) — AI pair programmer
