# Glossary

## Terms

### HARC

> **Human Agentic Readable Context** — A framework defining how to structure AI-accessible project context within a git repository. Provides conventions for CLAUDE.md, AGENTS.md, docs/context/, and optional integration with Backstage/IDP.

### Context (in HARC)

> The structured knowledge about a project that AI agents need to work effectively: requirements, architecture, constraints, decisions, glossary, and feature specs. Stored in `docs/context/` directory.

### Entry Point

> The first file an AI agent reads at the start of a session. For Claude Code: `CLAUDE.md`. For GitHub Copilot: `.github/copilot-instructions.md`. For OpenCode: `AGENTS.md`. Entry points are navigation documents, not comprehensive documentation.

### ADR (Architecture Decision Record)

> A document capturing a significant architectural choice: what was decided, why, and what the consequences are. ADRs are append-only; to reverse a decision, create a new ADR that supersedes.

### Agent Entry Point Files

> The three files that AI coding assistants read first at the start of every session. Each tool has its own entry point, but all three share the same project context and must stay synchronized ([C-030], [ADR-0003](decisions/0003-ai-instruction-sync.md)):
>
> | File                              | Tool           | How It Works                                                                 |
> | --------------------------------- | -------------- | ---------------------------------------------------------------------------- |
> | `CLAUDE.md`                       | Claude Code    | Read automatically at session start. Must be under 80 lines.                 |
> | `.github/copilot-instructions.md` | GitHub Copilot | Read automatically when a workspace is opened in VS Code or on GitHub.       |
> | `AGENTS.md`                       | OpenCode       | Read automatically at session start. Follows the same structure as CLAUDE.md.|
>
> All three are navigation documents — they point to `docs/context/` for depth rather than containing detailed documentation themselves. When any one is updated, the other two must be updated in the same PR to prevent agents from following different rules.

### Feature Spec

> A document in `docs/context/features/` describing a single feature: problem statement, acceptance criteria, data model changes, and API contract. AI agents read the relevant spec before implementing a feature.

### Living Artifact

> A document that is automatically or routinely updated as the project evolves: CHANGELOG.md, test coverage reports, API diffs. Contrast with static documentation.

### Backstage

> An open source Internal Developer Platform (IDP) framework. HARC optionally integrates with Backstage via `catalog-info.yaml` for the software catalog and TechDocs for documentation rendering. Backstage is not required to use HARC.

### IDP (Internal Developer Platform)

> A platform that provides self-service capabilities to developers: service catalogs, golden paths, documentation, and automation. Backstage is a popular IDP framework.

### Tickets Branch

> An orphan git branch (named `tickets` by default) that stores the project backlog as markdown files. Separate from commit history to avoid polluting the main branch.

### Orphan Branch

> A git branch with no commit history shared with other branches. Created with `git checkout --orphan`. Used for the tickets branch to keep backlog separate from code history.

### Agent Coordination

> The mechanism by which multiple AI agents (or humans) can work on the same project without conflicts. In HARC, implemented via `locked_by`, `lock_timestamp`, and `work_session` fields on tickets.

### Claim (Ticket)

> The act of an agent or developer reserving a ticket for work by setting `locked_by` and `status: in-progress`. Other agents see the ticket as unavailable until the lock is released.

### BMAD Method

> "Build More Architect Dreams" — An AI-driven agile development framework with specialized agents, guided workflows, and scale-adaptive intelligence. HARC is designed to be compatible with BMAD workflows. See https://github.com/bmad-code-org/BMAD-METHOD

### Beads

> A task/ticket coordination system for agentic development where agents can identify dependencies, organize work, and coordinate without conflicts. HARC's ticket system is designed for beads compatibility.

### Sprint Status

> A file (typically YAML) tracking the current sprint's epics, stories, and their completion status. In BMAD Method: `sprint-status.yaml`. In HARC: may live on tickets branch.

### Context Window

> The maximum amount of text an AI model can process in a single session. CLAUDE.md is kept under 80 lines to avoid wasting context window on navigation; depth lives in `docs/context/`.

### TechDocs

> Backstage's documentation-as-code solution. Renders markdown from `docs/` directory as a browsable documentation site within the IDP.

### Scorecard (Backstage)

> A Backstage feature that evaluates services against rules and best practices. HARC recommends scorecard rules for context quality (e.g., "CLAUDE.md modified in last 90 days").

### OpenCode

> An open-source terminal-based AI coding agent. Reads `AGENTS.md` as its primary project instruction file. HARC supports OpenCode as a first-class AI tool alongside Claude Code and GitHub Copilot. See [ADR-0004](decisions/0004-opencode-support.md).

### AGENTS.md

> The entry point file for OpenCode. Follows the same structure as `CLAUDE.md` and must stay synchronized with `CLAUDE.md` and `.github/copilot-instructions.md`.

### Slash Command (Claude Code)

> A reusable workflow defined in `.claude/commands/`. When a user types `/command-name`, Claude Code executes the natural-language instructions in the corresponding `.md` file.

### CHANGELOG.md

> A living artifact following [Keep a Changelog](https://keepachangelog.com/) format. AI agents (Claude Code, GitHub Copilot, OpenCode) are instructed to update it after completing features or significant changes. Entries go under `[Unreleased]` until a release is cut.

---

## Acronyms

| Acronym | Full Form                                  |
| ------- | ------------------------------------------ |
| HARC    | Human Agentic Readable Context  |
| ADR     | Architecture Decision Record               |
| IDP     | Internal Developer Platform                |
| BMAD    | Build More Architect Dreams                |
| PRD     | Product Requirements Document              |
| MVP     | Minimum Viable Product                     |
| CI/CD   | Continuous Integration / Continuous Deploy |
| TUI     | Terminal User Interface                    |
| CLI     | Command Line Interface                     |
