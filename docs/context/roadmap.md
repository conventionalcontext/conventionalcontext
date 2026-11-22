# HARC Framework Roadmap

<!-- ============================================================
  docs/context/roadmap.md — Living Roadmap
  ============================================================
  PURPOSE:
    Tracks the planned evolution of the HARC framework. This is a living
    document — update it as priorities shift and items are completed.

  HOW TO MAINTAIN:
    - Move items to "Completed" when merged
    - Add new items under the appropriate phase
    - Re-prioritize at the start of each sprint
    - Link to feature specs and ADRs where they exist
  ============================================================ -->

## Vision

HARC provides the persistent project memory layer that AI coding assistants need to work effectively. The roadmap below tracks the framework's evolution from core context structure through advanced features like in-git ticket systems and ecosystem integrations.

## Current Phase: Foundation (v0.x)

### Completed

- [x] Core context structure (`docs/context/` with requirements, architecture, constraints, glossary)
- [x] Multi-agent entry points (CLAUDE.md, copilot-instructions.md, AGENTS.md)
- [x] Entry point synchronization (ADR-0003)
- [x] Bootstrap script with fresh/existing/upgrade support
- [x] Agent-specific slash command directories (`--agent` flag)
- [x] ADR system with append-only semantics
- [x] Feature spec templates with acceptance criteria
- [x] Living artifacts (CHANGELOG.md, README.md feature list)
- [x] Backstage integration (catalog-info.yaml, TechDocs)
- [x] BMAD Method compatibility mapping
- [x] Competitive positioning (ADR-0005: HARC vs Spec Kit vs BMAD)

### In Progress

- [ ] In-git ticket system MVP — see [ticket-system.md](features/ticket-system.md)
- [ ] Spec Kit interoperability documentation — see [ADR-0005](decisions/0005-harc-vs-spec-kit-comparison.md)

### Next Up

- [ ] HARC Spec Kit extension (auto-populate `docs/context/` from `.specify/` artifacts)
- [ ] Context validation CLI (check for stale context, missing ADRs, orphaned feature specs)
- [ ] GitHub Actions workflow for context freshness checks
- [ ] Template repository for new projects (aipk-template-base)

## Phase 2: Ticket System & Workflow

- [ ] In-git ticket system on orphan branch — see [ticket-system.md](features/ticket-system.md)
- [ ] GitHub Issues sync (bidirectional)
- [ ] BMAD sprint-status.yaml interoperability
- [ ] Ticket-driven development workflow commands
- [ ] Agent claim/release locking for multi-agent coordination

## Phase 3: Ecosystem & Integrations

- [ ] Spec Kit extension: HARC context auto-population from specs
- [ ] BMAD module: HARC context as BMAD document source
- [ ] GitLab integration (GitLab-specific entry points and CI templates)
- [ ] VS Code extension for context navigation
- [ ] Context diff tooling (visualize what changed between versions)

## Phase 4: Enterprise & Scale

- [ ] Multi-repo context federation (shared context across microservices)
- [ ] Context inheritance (org-level defaults that repos can override)
- [ ] Scorecard integration (Backstage scorecards for context quality)
- [ ] Compliance templates (SOC2, HIPAA, PCI-DSS constraint sets)
- [ ] Air-gapped installation support

## Ideas & Exploration

Items here are not committed — they represent potential future directions.

- Context-aware code review (AI uses `docs/context/` to review PRs)
- Automated context generation from existing codebases
- Context analytics (track how often context files are read/updated)
- LLM-powered context freshness detection
- Cross-project dependency context (what upstream/downstream services know)
