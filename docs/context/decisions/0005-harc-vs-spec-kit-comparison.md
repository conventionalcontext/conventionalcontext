# ADR-0005: HARC Framework vs GitHub Spec Kit vs BMAD Method — Positioning & Comparison

## Status

Proposed

## Date

2026-03-22

## Context

[GitHub Spec Kit](https://github.com/github/spec-kit) (80k+ stars, MIT license) and the [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD) (41k+ stars, MIT license) both represent significant open-source efforts in the AI-assisted development space. As HARC also operates in the structured-context-for-AI-agents domain, we need to clearly understand where the three overlap, where they diverge, and how HARC should position itself relative to both.

This ADR documents the comparison so the team can make informed decisions about HARC's roadmap, avoid reinventing what Spec Kit or BMAD does well, and double down on HARC's unique strengths.

## Comparison

### Philosophy

| Dimension | HARC | GitHub Spec Kit | BMAD Method |
| --------- | ---- | --------------- | ----------- |
| **Core thesis** | AI agents need persistent project context (requirements, architecture, constraints, decisions) stored in git to work effectively across sessions | Specifications are the primary artifact; code is generated from specs rather than being hand-crafted with AI assistance | AI agents should act as expert collaborators guiding developers through structured agile workflows, not doing the thinking for them |
| **Approach** | Context-first: structure the knowledge, let AI agents read it naturally | Spec-first: define specs → plan → tasks → implement in a strict pipeline | Agent-first: 12+ specialized agent personas (PM, Architect, Developer, etc.) facilitate structured conversations and workflows |
| **Developer workflow** | AI agents work alongside you with full project context; you drive development naturally | Multi-step command pipeline: constitution → specify → plan → tasks → implement | Scale-adaptive facilitated workflows: agents guide you through analysis, planning, architecture, and implementation |
| **When to use** | Any project, any phase — new or existing repos, any workflow style | Best suited for greenfield projects or well-defined feature additions following the SDD pipeline | Any project complexity — automatically adjusts planning depth from bug fixes to enterprise systems |

### Agent Support

| Dimension | HARC | GitHub Spec Kit | BMAD Method |
| --------- | ---- | --------------- | ----------- |
| **Supported agents** | Claude Code, GitHub Copilot, OpenCode (3 agents, extensible) | 25+ agents (Claude, Copilot, Codex, Cursor, Gemini, Windsurf, Kilo Code, Roo Code, etc.) | Claude Code, Cursor, and other AI IDEs — agent-agnostic via skills and markdown prompts |
| **Agent integration** | Static entry point files (CLAUDE.md, copilot-instructions.md, AGENTS.md) — agents read them directly | CLI-generated slash command files placed in agent-specific directories | npx installer places agent personas, skills, and workflows in `.bmad/` directory; agents read them as context |
| **Agent switching** | All three files always present; agent picks its own entry point | `specify init --ai <agent>` generates files for one agent at a time | Agent-agnostic — works with any AI that can read markdown files |
| **Multi-agent** | All agents share the same context simultaneously (three-file sync) | Primarily single-agent per project init (can re-run for different agents) | "Party Mode" — multiple agent personas in one session to collaborate and discuss |

### What Gets Created

| Artifact | HARC | GitHub Spec Kit | BMAD Method |
| -------- | ---- | --------------- | ----------- |
| **Project structure** | `docs/context/` directory with requirements, architecture, constraints, glossary, decisions, features | `.specify/` directory with specs, plans, tasks, implementation notes | `.bmad/` directory with agent personas, skills, workflows, and project documents (PRD, architecture, etc.) |
| **Entry points** | CLAUDE.md, AGENTS.md, .github/copilot-instructions.md | Agent-specific command directories (e.g. `.claude/commands/`, `.github/copilot/`) | AGENTS.md + `.bmad/` directory read by all AI IDEs |
| **ADRs** | First-class concept in `docs/context/decisions/` with templates | Not a core concept (could be added via extensions) | Not a core concept — architectural decisions captured in architecture documents |
| **Feature specs** | First-class in `docs/context/features/` with acceptance criteria checkboxes | Specs created via `/speckit.specify` command, stored in `.specify/` | PRD and story documents created through facilitated PM agent workflow |
| **Slash commands** | 4 commands per agent (new-feature, create-adr, update-context, review-pr) | 5+ core commands (constitution, specify, plan, tasks, implement) + optional commands (clarify, analyze, checklist) | 34+ workflows (skills) including `bmad-help`, story creation, architecture, testing, dev-loop, and more |
| **IDP integration** | Backstage catalog-info.yaml + TechDocs (optional) | Not included | Not included |
| **CI/CD templates** | Not included (by design — project-specific) | Not included | Not included |
| **Specialized agents** | None — agent entry points share the same context | None — agent is the user's AI tool | 12+ agent personas (PM, Architect, Developer, UX, Scrum Master, QA, etc.) |

### Tooling

| Dimension | HARC | GitHub Spec Kit | BMAD Method |
| --------- | ---- | --------------- | ----------- |
| **Installation** | `curl | bash` — single shell script, zero dependencies | Python CLI via `uv tool install` (requires Python 3.11+, uv, git) | `npx bmad-method install` — Node.js CLI (requires Node.js 20+) |
| **CLI tool** | `scripts/bootstrap.sh` (bash) | `specify` CLI (Python package) | `bmad-method` CLI (npm package) with interactive module selection |
| **Extensibility** | Manual — add files to `docs/context/`, agent command dirs | Extension system (`specify extension add`) + presets (`specify preset add`) | Module ecosystem — BMad Builder (BMB), Test Architect (TEA), Game Dev Studio (BMGD), Creative Intelligence Suite (CIS) |
| **Customization** | Edit templates directly; -HARC files for comparison on upgrade | Presets override templates and commands; extensions add new capabilities | BMad Builder module for creating custom agents and workflows |
| **Upgrade path** | Re-run bootstrap → -HARC templates alongside existing files → diff and merge | Re-run `specify init --force` or fetch new templates | Re-run `npx bmad-method install` — versioned releases with migration guides |

### Documentation & Rendering

| Dimension | HARC | GitHub Spec Kit | BMAD Method |
| --------- | ---- | --------------- | ----------- |
| **Docs approach** | Context files live in `docs/context/` — automatically rendered by MkDocs / TechDocs | Specs live in `.specify/` — not automatically tied to a docs framework | Docs site at docs.bmad-method.org; project documents live in `.bmad/docs/` |
| **Static site** | MkDocs Material config included; context files appear in project docs site | Not included (separate concern) | Astro-based docs site for the framework; no per-project static site generation |
| **Backstage/IDP** | Built-in optional integration (catalog-info.yaml, TechDocs annotations) | Not included | Not included |
| **Living artifacts** | CHANGELOG.md + README.md feature list automatically maintained by AI agents | Specs evolve through the SDD pipeline; changelog not a core concept | Project documents (PRD, architecture) updated through facilitated agent workflows |

### Project Maturity & Ecosystem

| Dimension | HARC | GitHub Spec Kit | BMAD Method |
| --------- | ---- | --------------- | ----------- |
| **Maturity** | Early stage, pre-1.0 | Active development with 117 releases, 125 contributors | Active development at v6.2, 26 releases, 129 contributors |
| **GitHub stars** | New | 80,000+ | 41,800+ |
| **License** | Apache 2.0 | MIT | MIT |
| **Maintainer** | Community (OpenCPK) | GitHub (official) | BMad Code community |
| **Extension ecosystem** | None yet | Growing catalog of extensions and presets | Module ecosystem: BMB, TEA, BMGD, CIS |
| **Enterprise features** | Backstage integration | Air-gapped installation, enterprise deployment guides | Scale-adaptive intelligence adjusts to project complexity |

### Key Differentiators

#### HARC Strengths (things Spec Kit doesn't do)

1. **Persistent project memory** — HARC's `docs/context/` is designed to be the long-term, evolving source of truth about a project. Spec Kit's `.specify/` is more focused on the current development cycle.
2. **ADRs as first-class citizens** — Decision records with append-only semantics, superseding chains, and templates are core to HARC. Spec Kit doesn't include ADR support.
3. **Backstage/IDP integration** — Optional catalog-info.yaml, TechDocs rendering, and scorecard annotations. Spec Kit doesn't address the IDP layer.
4. **Multi-agent by default** — All three entry point files are always present and synchronized. Agents share the same context.
5. **Zero dependencies** — Single bash script, no Python runtime, no package manager.
6. **Living artifacts** — CHANGELOG.md and README.md feature list are explicitly maintained by AI agents as part of their workflow.
7. **Context in docs/** — Context files render as part of the project's documentation site automatically.

#### Spec Kit Strengths (things HARC doesn't do)

1. **Spec-Driven Development pipeline** — Structured constitution → specify → plan → tasks → implement workflow for disciplined feature development.
2. **Massive agent support** — 25+ agents supported with agent-specific command generation.
3. **Extension & preset ecosystem** — Pluggable architecture for adding new commands, overriding templates, and customizing workflows.
4. **Constitution concept** — Project-level governing principles that guide all subsequent development decisions.
5. **Task breakdown & implementation** — Automated decomposition of plans into trackable tasks with execution.
6. **Cross-artifact analysis** — `/speckit.analyze` checks consistency across specs, plans, and tasks.
7. **Brownfield walkthroughs** — Documented patterns for adding Spec Kit to large existing codebases.

#### BMAD Method Strengths (things HARC doesn't do)

1. **Specialized agent personas** — 12+ domain expert agents (PM, Architect, Developer, UX, Scrum Master, QA) with distinct expertise and facilitation styles.
2. **Scale-adaptive intelligence** — Automatically adjusts planning depth based on project complexity, from bug fixes to enterprise systems.
3. **Party Mode** — Multiple agent personas collaborate in a single session, discussing and debating approaches.
4. **Module ecosystem** — Extensible via official modules: Test Architect (TEA), Game Dev Studio (BMGD), Creative Intelligence Suite (CIS), BMad Builder (BMB).
5. **34+ facilitated workflows** — Comprehensive skill library covering analysis, planning, architecture, testing, and implementation.
6. **BMad Builder** — Create custom agents and workflows tailored to specific domains or team needs.
7. **Built-in help system** — `bmad-help` skill provides contextual guidance on what to do next at any point in the development process.

## Decision

HARC, Spec Kit, and BMAD are **complementary, not competing**. They address different layers of the AI-assisted development stack:

- **Spec Kit** is a **development workflow tool** — it structures *how you build features* (specify → plan → tasks → implement)
- **BMAD Method** is an **agent-facilitated agile framework** — it structures *how you think and collaborate with AI* (specialized agent personas guiding workflows)
- **HARC** is a **project memory framework** — it structures *what your project knows about itself* (requirements, architecture, constraints, decisions)

A project could use all three:
- HARC provides the persistent context layer (`docs/context/`) that AI agents read on every session
- Spec Kit provides the feature development pipeline (`.specify/`) for structured implementation workflow
- BMAD provides facilitated agile workflows (`.bmad/`) with specialized agent personas for planning and architecture

We should:
1. **Not duplicate Spec Kit's workflow features** — avoid building a constitution/specify/plan/tasks pipeline
2. **Not duplicate BMAD's agent persona system** — avoid building specialized agent roles
3. **Ensure compatibility** — HARC's file layout should not conflict with Spec Kit's `.specify/` or BMAD's `.bmad/` directories
4. **Consider a Spec Kit extension** — a HARC extension for Spec Kit could auto-populate `docs/context/` from spec artifacts
5. **Maintain BMAD interoperability** — HARC's concept mapping to BMAD is documented in the [bmad-compatibility feature spec](../features/bmad-compatibility.md)
6. **Document interoperability** — clear guidance on using HARC alongside either or both tools

## Consequences

### Positive
- Clear positioning: HARC = persistent project memory, Spec Kit = development workflow, BMAD = agent-facilitated agile
- Avoids feature duplication with two larger projects
- Opens collaboration opportunities (HARC as a Spec Kit extension, BMAD concept mapping)
- Validates HARC's unique value in areas neither tool addresses (ADRs, Backstage, multi-agent sync, living artifacts)

### Negative
- Spec Kit's and BMAD's rapid growth may lead users to assume they cover HARC's use cases (need clear messaging)
- If either tool adds ADR/context features, HARC's differentiators narrow

### Neutral
- All three projects are evolving — this comparison may need revisiting
- The specific file layouts (`.specify/` vs `docs/context/` vs `.bmad/`) mean they coexist cleanly in a repo
