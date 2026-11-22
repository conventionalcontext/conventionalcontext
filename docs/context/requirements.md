# Requirements

## Business Context

AI-assisted development has become mainstream, with tools like Claude Code, GitHub Copilot, and Cursor transforming how software is built. However, these AI agents suffer from a fundamental limitation: **session amnesia**. Each conversation starts from zero, requiring developers to repeatedly explain project context, constraints, and conventions.

Platform engineering teams building Internal Developer Platforms (IDPs) on Backstage face a similar challenge: ensuring consistent documentation across services. HARC unifies these needs by providing a structured context layer that serves both AI agents and human consumers.

## Problem Statement

Without structured, in-repo context:
- AI agents generate code that conflicts with project conventions
- Developers waste time re-explaining the project in every AI session
- Documentation lives in Confluence/Notion (invisible to AI agents)
- Architecture decisions are made but not recorded
- New team members (human or AI) have no clear onboarding path
- Context quality varies wildly between repositories

## Functional Requirements

### Context Structure

- [x] [FR-001] The framework MUST provide a standard directory structure (`docs/context/`) for project metadata
- [x] [FR-002] The framework MUST include an AI entry point file (`CLAUDE.md`) under 80 lines
- [x] [FR-003] The framework MUST support GitHub Copilot via `.github/copilot-instructions.md`
- [x] [FR-003a] The framework MUST support OpenCode via `AGENTS.md`
- [x] [FR-004] The framework MUST include templates for requirements, architecture, constraints, and glossary
- [x] [FR-005] The framework MUST support Architecture Decision Records (ADRs) in `docs/context/decisions/`
- [x] [FR-006] The framework MUST support feature specifications in `docs/context/features/`

### Backstage Integration (Optional)

- [x] [FR-010] The framework MUST include a `catalog-info.yaml` template for Backstage registration
- [ ] [FR-011] The framework SHOULD support TechDocs rendering from `docs/context/` + `docs/`
- [ ] [FR-012] The framework MAY support Backstage scorecard rules for context quality
- [FR-013] Backstage integration MUST be optional — HARC works without Backstage

### Bootstrap and Tooling

- [x] [FR-020] The framework MUST provide a bootstrap script (`scripts/bootstrap.sh`) for new repos
- [x] [FR-021] The framework MUST provide Claude Code slash commands in `.claude/commands/`
- [ ] [FR-022] The framework SHOULD provide a template repository for forking
- [x] [FR-023] The bootstrap script MUST handle existing repos by creating `-HARC` template files alongside existing files
- [x] [FR-024] The bootstrap script MUST never overwrite existing files
- [x] [FR-025] The framework MUST provide a test script (`tests/test-bootstrap.sh`) for bootstrap verification

### Ticket System (See ADR-0002)

- [ ] [FR-030] The framework MUST support an in-git ticket system on orphan branch
- [ ] [FR-031] The framework MUST sync tickets with GitHub Issues
- [ ] [FR-032] The framework SHOULD support GitLab Issues sync (future)
- [ ] [FR-033] The framework MAY support Jira sync (future)
- [ ] [FR-034] The framework MUST support agent coordination (lock/claim/release)

### Living Artifacts

- [x] [FR-050] The framework MUST include a `CHANGELOG.md` following Keep a Changelog format
- [x] [FR-051] AI agents MUST be instructed to update `CHANGELOG.md` after completing features
- [x] [FR-052] All three AI entry point files MUST instruct agents to update `CHANGELOG.md`

### BMAD Method Compatibility

- [x] [FR-040] The framework MUST be compatible with BMAD Method workflows
- [x] [FR-041] The framework MUST support beads-style agent coordination patterns
- [ ] [FR-042] The framework SHOULD interoperate with BMAD sprint-status.yaml

## Non-Functional Requirements

### Usability

- [NFR-U01] Context files MUST be readable without special tooling (plain markdown)
- [NFR-U02] AI agents MUST be able to understand context within their context window limits
- [NFR-U03] CLAUDE.md MUST be under 80 lines to avoid context window waste
- [NFR-U04] Developers MUST be able to update context in under 5 minutes per PR

### Portability

- [NFR-P01] The framework MUST work with any git hosting (GitHub, GitLab, Bitbucket)
- [NFR-P02] Tooling MUST use shell or Python (no compiled binaries required)
- [NFR-P03] The framework MUST not require external services beyond git

### Compatibility

- [NFR-C01] The framework MUST work with Claude Code
- [NFR-C02] The framework MUST work with GitHub Copilot
- [NFR-C02a] The framework MUST work with OpenCode
- [NFR-C03] The framework SHOULD work with Cursor, Windsurf, and other AI IDEs
- [NFR-C04] The framework SHOULD integrate with Backstage 1.x (optional)

### Maintainability

- [NFR-M01] Context files MUST be updated in the same PR as code changes
- [NFR-M02] ADRs MUST be append-only (never edit past decisions)
- [NFR-M03] The framework MUST support context validation via CI

## Known Constraints

- Must work offline (git-native, no external API dependencies for core functionality)
- Must fit within AI agent context windows (~100-200k tokens)
- Must render correctly in GitHub/GitLab markdown preview
- Must be adoptable incrementally (not all-or-nothing)

## Out of Scope

- IDE plugins or extensions (rely on built-in file reading)
- Real-time collaboration features (use git workflows)
- Authentication/authorization (handled by git hosting)
- Hosting or deployment of context (it lives in the repo)
