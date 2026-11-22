#!/usr/bin/env bash
# =============================================================================
# bootstrap.sh — HARC Framework Bootstrap Script
#
# PURPOSE:
#   Scaffolds the Platform Engineering / AI-Assisted development context
#   structure for a new (or existing) repository. Creates all files needed
#   for AI coding assistants (Claude Code, GitHub Copilot, OpenCode),
#   Backstage IDP (optional), and human developers to share a single
#   source of truth about the project.
#
# USAGE:
#   ./scripts/bootstrap.sh [--agent claude,copilot,opencode]
#
# OPTIONS:
#   --agent <list>  Comma-separated list of AI agents to configure.
#                   Supported values: claude, copilot, opencode
#                   Default: claude
#                   Example: --agent claude,copilot
#                   Example: --agent claude,copilot,opencode
#
# Run this from the ROOT of your repository. Safe to re-run at any time:
#   - New files are created directly
#   - Existing files get a <basename>-HARC.<ext> template alongside them
#     (e.g. CHANGELOG.md exists → creates CHANGELOG-HARC.md)
#
# This means the same command works for both new repos and upgrades.
# Re-running after a HARC framework update gives you -HARC templates
# showing the latest format, which you can diff or ask your AI agent
# to merge into your existing files.
#
# WHAT IT CREATES:
#   CLAUDE.md                     — Claude Code entry point (--agent claude)
#   AGENTS.md                     — OpenCode entry point (--agent opencode)
#   .github/copilot-instructions.md — GitHub Copilot entry point (--agent copilot)
#   catalog-info.yaml             — Backstage component descriptor (optional)
#   CHANGELOG.md                  — Living changelog
#   docs/context/requirements.md      — Functional + non-functional requirements
#   docs/context/architecture.md      — System design and component overview
#   docs/context/constraints.md       — Rules AI agents and engineers must follow
#   docs/context/glossary.md          — Domain language reference
#   docs/context/decisions/0001-*.md  — First ADR template
#   docs/context/features/example.md  — Feature spec template
#   .claude/commands/*.md         — Slash commands for Claude Code (--agent claude)
#   .github/copilot/commands/*.md — Slash commands for GitHub Copilot (--agent copilot)
#   .opencode/commands/*.md       — Slash commands for OpenCode (--agent opencode)
#   docs/mkdocs.yml               — Backstage TechDocs configuration (optional)
#   docs/index.md                 — TechDocs landing page (optional)
#
# AFTER RUNNING:
#   For a new repo:
#     1. Replace all [PLACEHOLDER] values with your project's real information
#     2. git add docs/ .claude/ .github/ CLAUDE.md AGENTS.md catalog-info.yaml CHANGELOG.md
#     3. git commit -m "chore: initialise platform context architecture"
#     4. (Optional) Register in Backstage by importing catalog-info.yaml
#
#   For an existing repo (upgrade):
#     1. Find -HARC files: find . -name "*-HARC*" -type f
#     2. Ask your AI agent to refactor each original into the HARC format
#        using the -HARC file as reference
#     3. Delete the -HARC template files: find . -name "*-HARC*" -type f -delete
#     4. Commit: git commit -m "chore: upgrade to latest HARC structure"
# =============================================================================

set -euo pipefail

# ── Parse arguments ──────────────────────────────────────────────────────────
AGENTS="claude"  # Default: claude only

while [ $# -gt 0 ]; do
  case "$1" in
    --agent)
      shift
      if [ -z "${1:-}" ]; then
        echo "ERROR: --agent requires a comma-separated list (e.g. --agent claude,copilot,opencode)"
        exit 1
      fi
      AGENTS="$1"
      # Validate agent names
      IFS=',' read -ra agent_list <<< "$AGENTS"
      for a in "${agent_list[@]}"; do
        case "$a" in
          claude|copilot|opencode) ;;
          *) echo "ERROR: Unknown agent '$a'. Supported: claude, copilot, opencode"; exit 1 ;;
        esac
      done
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [--agent claude,copilot,opencode]"
      echo ""
      echo "  Bootstraps the HARC framework structure in the current directory."
      echo "  New files are created directly. If a file already exists, a"
      echo "  -HARC template is created alongside it for comparison."
      echo ""
      echo "  Safe to re-run after HARC framework upgrades — existing files"
      echo "  are never overwritten."
      echo ""
      echo "Options:"
      echo "  --agent <list>  Comma-separated list of AI agents to configure."
      echo "                  Supported: claude, copilot, opencode"
      echo "                  Default: claude"
      echo "                  Example: --agent claude,copilot,opencode"
      exit 0
      ;;
    *) echo "Unknown argument: $1"; exit 1 ;;
  esac
done

# ── Agent selection helpers ──────────────────────────────────────────────────
has_agent() {
  [[ ",$AGENTS," == *",$1,"* ]]
}

# ── Colours for terminal output ──────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
RESET='\033[0m'

created=0
migrated=0

# ── Helper: write a file, creating a -HARC template if file already exists ──
write_file() {
  local path="$1"
  local content="$2"
  if [ -f "$path" ]; then
    # Create a -HARC variant alongside the existing file
    local dir ext base harc_path
    dir="$(dirname "$path")"
    base="$(basename "$path")"
    ext="${base##*.}"
    if [ "$ext" = "$base" ]; then
      # No extension
      harc_path="${dir}/${base}-HARC"
    else
      harc_path="${dir}/${base%.*}-HARC.${ext}"
    fi
    mkdir -p "$dir"
    printf '%s' "$content" > "$harc_path"
    echo -e "  ${BLUE}TEMPLATE${RESET} $harc_path (existing $path preserved)"
    ((migrated++)) || true
  else
    mkdir -p "$(dirname "$path")"
    printf '%s' "$content" > "$path"
    echo -e "  ${GREEN}CREATE${RESET}   $path"
    ((created++)) || true
  fi
}

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${CYAN}  HARC Framework Bootstrap${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# =============================================================================
# CLAUDE.md — Claude Code's entry point (conditional on --agent claude)
# =============================================================================
# WHY: This is the FIRST file Claude Code reads at the start of every session.
#      It must be concise (< 80 lines) and act as a navigation document,
#      pointing to docs/context/ files for depth. Think of it as the README for
#      the AI, not a documentation dump.
#
# KEEP IT SHORT. If you find yourself writing more than 80 lines, move the
# detail into docs/context/ and add a link here.
# =============================================================================
if has_agent claude; then
write_file "CLAUDE.md" '# Project: [PLACEHOLDER — project name]

<!-- ============================================================
  CLAUDE.md — Entry point for Claude Code (AI coding assistant)
  ============================================================
  This is the FIRST file Claude Code reads at the start of every
  session. Keep it under 80 lines. Use it to navigate, not to explain.

  HOW TO MAINTAIN THIS FILE:
  - Update "Current sprint focus" at the start of each sprint
  - Update "Stack" when dependencies change
  - Update "Rules" when new constraints are identified (needs team review)
  - Do NOT write requirements or architecture detail here — use docs/context/

  SYNC REQUIREMENT:
  - This file, .github/copilot-instructions.md, and AGENTS.md share the
    same project context. When you update this file, also update both
    .github/copilot-instructions.md and AGENTS.md to keep all AI entry
    points in sync.
  ============================================================ -->

> [PLACEHOLDER — one sentence: what does this service/app do and for whom?]

## What this project does

<!-- 2–3 sentences. Domain context, not technical detail.
     Example: "Handles subscription lifecycle for B2B customers.
     Processes payments via Stripe, emits billing events to the
     data platform, and exposes a REST API consumed by the web app." -->

[PLACEHOLDER]

## Stack

<!-- Be specific. Claude Code uses this to make correct technology choices. -->

- **Runtime:** [e.g. Node 20 / TypeScript 5.x]
- **Framework:** [e.g. Fastify 4 / NestJS 10 / Express]
- **Database:** [e.g. PostgreSQL 16 via Prisma ORM]
- **Message bus:** [e.g. AWS SQS / Kafka / none]
- **Infrastructure:** [e.g. AWS ECS + RDS, managed via Terraform]
- **CI/CD:** [e.g. GitHub Actions → ECR → ECS rolling deploy]
- **Testing:** [e.g. Vitest for unit, Supertest for integration, Playwright for e2e]

## Key context files

<!-- Claude Code reads these for depth. Keep paths accurate. -->

| File | Contents |
|---|---|
| `docs/context/requirements.md` | What the system must do |
| `docs/context/architecture.md` | How the system is designed |
| `docs/context/constraints.md` | Rules that must not be broken |
| `docs/context/glossary.md` | Domain language reference |
| `docs/context/decisions/` | Architecture Decision Records (ADRs) |
| `docs/context/features/` | Feature-level specs and acceptance criteria |
| `docs/context/roadmap.md` | Project roadmap and planned milestones |
| `CHANGELOG.md` | Living changelog (update after changes) |

## Rules Claude must follow

<!-- Non-negotiable. Claude Code treats these as hard constraints.
     Examples below — replace with your actual rules.
     SYNC: Keep .github/copilot-instructions.md and AGENTS.md rules in sync with these. -->

- Never modify database migrations directly — generate them via `[PLACEHOLDER: migration command]`
- All new HTTP endpoints require OpenAPI annotations before the PR can merge
- Feature flags must use `[PLACEHOLDER: path/to/flags.ts]` — no env var conditionals in app code
- A new third-party dependency requires an ADR entry in `docs/context/decisions/`
- [PLACEHOLDER — add your security, compliance, and coding standards rules here]
- When updating this file, also update `.github/copilot-instructions.md` and `AGENTS.md` to keep all AI assistant entry points in sync
- After completing features or significant changes, append entry to `CHANGELOG.md` under `[Unreleased]`
- `README.md` MUST include a bullet-point list of project features just below the project title and description, linking to the corresponding `docs/context/features/` spec files — update this list when features are added, removed, or renamed

## Current sprint focus

<!-- Update this at the start of each sprint. Claude Code uses it to
     understand what is actively being worked on and what to prioritise. -->

Sprint: [PLACEHOLDER — e.g. "2024-Q1-S3"]
Focus: [PLACEHOLDER — e.g. "Billing engine v2 — see docs/context/features/billing-engine-v2.md"]
Active features: [PLACEHOLDER — list feature spec files currently in progress]

## How to run common tasks

<!-- Links to .claude/commands/ slash commands -->

- `/new-feature [name]` — scaffold a new feature spec + module boilerplate
- `/create-adr [topic]` — log an architectural decision
- `/update-context` — sync docs/context/ files after a significant change
- `/review-pr` — run pre-merge checklist
'
fi  # end has_agent claude

# =============================================================================
# .github/copilot-instructions.md — GitHub Copilot's entry point (conditional on --agent copilot)
# =============================================================================
# WHY: This is the FIRST file GitHub Copilot reads in VS Code / GitHub.
#      It mirrors the shared context from CLAUDE.md so that both AI assistants
#      have identical project understanding. Each file contains a sync
#      instruction to keep the others updated.
#
# KEEP IT SHORT. If you find yourself writing more than 80 lines, move the
# detail into docs/context/ and add a link here.
# =============================================================================
if has_agent copilot; then
write_file ".github/copilot-instructions.md" '# Project: [PLACEHOLDER — project name]

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
    When you update this file, also update CLAUDE.md and AGENTS.md to
    keep all AI assistant entry points in sync.
  ============================================================ -->

> [PLACEHOLDER — one sentence: what does this service/app do and for whom?]

## What this project does

<!-- 2–3 sentences. Domain context, not technical detail.
     Example: "Handles subscription lifecycle for B2B customers.
     Processes payments via Stripe, emits billing events to the
     data platform, and exposes a REST API consumed by the web app." -->

[PLACEHOLDER]

## Stack

<!-- Be specific. The AI assistant uses this to make correct technology choices. -->

- **Runtime:** [e.g. Node 20 / TypeScript 5.x]
- **Framework:** [e.g. Fastify 4 / NestJS 10 / Express]
- **Database:** [e.g. PostgreSQL 16 via Prisma ORM]
- **Message bus:** [e.g. AWS SQS / Kafka / none]
- **Infrastructure:** [e.g. AWS ECS + RDS, managed via Terraform]
- **CI/CD:** [e.g. GitHub Actions → ECR → ECS rolling deploy]
- **Testing:** [e.g. Vitest for unit, Supertest for integration, Playwright for e2e]

## Key context files

<!-- The AI assistant reads these for depth. Keep paths accurate. -->

| File | Contents |
|---|---|
| `docs/context/requirements.md` | What the system must do |
| `docs/context/architecture.md` | How the system is designed |
| `docs/context/constraints.md` | Rules that must not be broken |
| `docs/context/glossary.md` | Domain language reference |
| `docs/context/decisions/` | Architecture Decision Records (ADRs) |
| `docs/context/features/` | Feature-level specs and acceptance criteria |
| `docs/context/roadmap.md` | Project roadmap and planned milestones |
| `CHANGELOG.md` | Living changelog (update after changes) |

## Rules the AI assistant must follow

<!-- Non-negotiable. Treat these as hard constraints.
     Examples below — replace with your actual rules.
     SYNC: Keep CLAUDE.md and AGENTS.md rules in sync with these. -->

- Never modify database migrations directly — generate them via `[PLACEHOLDER: migration command]`
- All new HTTP endpoints require OpenAPI annotations before the PR can merge
- Feature flags must use `[PLACEHOLDER: path/to/flags.ts]` — no env var conditionals in app code
- A new third-party dependency requires an ADR entry in `docs/context/decisions/`
- [PLACEHOLDER — add your security, compliance, and coding standards rules here]
- When updating this file, also update `CLAUDE.md` and `AGENTS.md` to keep all AI assistant entry points in sync
- After completing features or significant changes, append entry to `CHANGELOG.md` under `[Unreleased]`
- `README.md` MUST include a bullet-point list of project features just below the project title and description, linking to the corresponding `docs/context/features/` spec files — update this list when features are added, removed, or renamed

## Current sprint focus

<!-- Update this at the start of each sprint. The AI assistant uses it to
     understand what is actively being worked on and what to prioritise. -->

Sprint: [PLACEHOLDER — e.g. "2024-Q1-S3"]
Focus: [PLACEHOLDER — e.g. "Billing engine v2 — see docs/context/features/billing-engine-v2.md"]
Active features: [PLACEHOLDER — list feature spec files currently in progress]

## How to run common tasks

<!-- Key workflows for this project -->

- **New feature** — create spec in `docs/context/features/[name].md` using the template
- **New ADR** — create record in `docs/context/decisions/[NNNN]-[topic].md`
- **Update context** — sync `docs/context/` files after a significant change
- **Review PR** — run pre-merge checklist against `docs/context/constraints.md`
'
fi  # end has_agent copilot

# =============================================================================
# AGENTS.md — OpenCode's entry point (conditional on --agent opencode)
# =============================================================================
# WHY: This is the FIRST file OpenCode reads at the start of every session.
#      It mirrors the shared context from CLAUDE.md and copilot-instructions.md
#      so that all AI assistants have identical project understanding.
#
# KEEP IT SHORT. If you find yourself writing more than 80 lines, move the
# detail into docs/context/ and add a link here.
# =============================================================================
if has_agent opencode; then
write_file "AGENTS.md" '# Project: [PLACEHOLDER — project name]

<!-- ============================================================
  AGENTS.md — Entry point for OpenCode (AI coding assistant)
  ============================================================
  This is the FIRST file OpenCode reads. Keep it under 80 lines.
  Use it to navigate, not to explain.

  HOW TO MAINTAIN THIS FILE:
  - Update "Current sprint focus" at the start of each sprint
  - Update "Stack" when dependencies change
  - Update "Rules" when new constraints are identified (needs team review)
  - Do NOT write requirements or architecture detail here — use docs/context/

  SYNC REQUIREMENT:
  - This file, CLAUDE.md, and .github/copilot-instructions.md share the
    same project context. When you update this file, also update CLAUDE.md
    and .github/copilot-instructions.md to keep all AI entry points in sync.
  ============================================================ -->

> [PLACEHOLDER — one sentence: what does this service/app do and for whom?]

## What this project does

<!-- 2–3 sentences. Domain context, not technical detail. -->

[PLACEHOLDER]

## Stack

<!-- Be specific. The AI assistant uses this to make correct technology choices. -->

- **Runtime:** [e.g. Node 20 / TypeScript 5.x]
- **Framework:** [e.g. Fastify 4 / NestJS 10 / Express]
- **Database:** [e.g. PostgreSQL 16 via Prisma ORM]
- **Message bus:** [e.g. AWS SQS / Kafka / none]
- **Infrastructure:** [e.g. AWS ECS + RDS, managed via Terraform]
- **CI/CD:** [e.g. GitHub Actions → ECR → ECS rolling deploy]
- **Testing:** [e.g. Vitest for unit, Supertest for integration, Playwright for e2e]

## Key context files

| File | Contents |
|---|---|
| `docs/context/requirements.md` | What the system must do |
| `docs/context/architecture.md` | How the system is designed |
| `docs/context/constraints.md` | Rules that must not be broken |
| `docs/context/glossary.md` | Domain language reference |
| `docs/context/decisions/` | Architecture Decision Records (ADRs) |
| `docs/context/features/` | Feature-level specs and acceptance criteria |
| `docs/context/roadmap.md` | Project roadmap and planned milestones |
| `CHANGELOG.md` | Living changelog (update after changes) |

## Rules this agent must follow

<!-- Non-negotiable. Treat these as hard constraints.
     SYNC: Keep CLAUDE.md and .github/copilot-instructions.md rules in sync. -->

- Never modify database migrations directly — generate them via `[PLACEHOLDER: migration command]`
- All new HTTP endpoints require OpenAPI annotations before the PR can merge
- Feature flags must use `[PLACEHOLDER: path/to/flags.ts]` — no env var conditionals in app code
- A new third-party dependency requires an ADR entry in `docs/context/decisions/`
- [PLACEHOLDER — add your security, compliance, and coding standards rules here]
- When updating this file, also update `CLAUDE.md` and `.github/copilot-instructions.md` to keep all AI assistant entry points in sync
- After completing features or significant changes, append entry to `CHANGELOG.md` under `[Unreleased]`
- `README.md` MUST include a bullet-point list of project features just below the project title and description, linking to the corresponding `docs/context/features/` spec files — update this list when features are added, removed, or renamed

## Current sprint focus

Sprint: [PLACEHOLDER — e.g. "2024-Q1-S3"]
Focus: [PLACEHOLDER — e.g. "Billing engine v2 — see docs/context/features/billing-engine-v2.md"]
Active features: [PLACEHOLDER — list feature spec files currently in progress]

## How to run common tasks

- **New feature** — create spec in `docs/context/features/[name].md` using the template
- **New ADR** — create record in `docs/context/decisions/[NNNN]-[topic].md`
- **Update context** — sync `docs/context/` files after a significant change
- **Review PR** — run pre-merge checklist against `docs/context/constraints.md`
'
fi  # end has_agent opencode

# =============================================================================
# catalog-info.yaml — Backstage Component Descriptor
# =============================================================================
# WHY: This file registers the service in the Backstage software catalog.
#      It is the IDP's source of truth for ownership, dependencies, lifecycle,
#      and links to runbooks and dashboards. It also carries annotations that
#      tell Backstage where to find TechDocs and where Claude Code's context
#      files live.
#
# SPEC: https://backstage.io/docs/features/software-catalog/descriptor-format
# =============================================================================
write_file "catalog-info.yaml" '# =============================================================================
# catalog-info.yaml — Backstage Component Descriptor
# =============================================================================
# PURPOSE:
#   Registers this service in the Backstage software catalog. Backstage reads
#   this file to build the service dependency graph, surface ownership,
#   render TechDocs, and run scorecards.
#
# HOW TO MAINTAIN:
#   - Update "owner" when the owning team changes
#   - Update "lifecycle" when the service moves from experimental to production
#   - Keep "dependsOn" current — stale dependencies break the catalog graph
#   - Update "providesApis" when new API contracts are published
#
# REQUIRED ANNOTATIONS:
#   backstage.io/techdocs-ref   — tells Backstage to render docs/ as TechDocs
#   claude.ai/context-path      — tells Claude Code where context files live
#   claude.ai/entry-point       — tells Claude Code which file to read first
# =============================================================================

apiVersion: backstage.io/v1alpha1
kind: Component

metadata:
  # ── Identity ──────────────────────────────────────────────────────────────
  name: [PLACEHOLDER-service-name]          # kebab-case, unique in the catalog
  title: [PLACEHOLDER Human-Readable Name]
  description: >
    [PLACEHOLDER — 1–2 sentences describing what this service does,
    its domain, and the business capability it provides.]

  # ── Annotations ───────────────────────────────────────────────────────────
  annotations:
    # Backstage: source code location
    github.com/project-slug: [PLACEHOLDER-org/repo-name]

    # Backstage: render the docs/ directory as TechDocs in the IDP portal
    backstage.io/techdocs-ref: dir:.

    # Claude Code: where to find context files in this repo
    claude.ai/context-path: docs/context/

    # Claude Code: the first file to read at the start of a session
    claude.ai/entry-point: CLAUDE.md

    # Optional: link to monitoring dashboard
    # grafana/dashboard-url: https://grafana.example.com/d/[dashboard-id]

    # Optional: link to on-call runbook
    # pagerduty/service-id: [PLACEHOLDER]

  # ── Taxonomy tags (used for catalog filtering) ────────────────────────────
  # Common tags: typescript, python, go, postgres, kafka, rest-api,
  #              graphql, grpc, event-driven, batch, cron, frontend, backend
  tags:
    - [PLACEHOLDER-language]               # e.g. typescript
    - [PLACEHOLDER-capability]             # e.g. payments, auth, notifications

  # ── External links ────────────────────────────────────────────────────────
  links:
    - url: https://[PLACEHOLDER-runbook-url]
      title: Runbook
      icon: docs
    - url: https://[PLACEHOLDER-dashboard-url]
      title: Monitoring Dashboard
      icon: dashboard

spec:
  # ── Classification ────────────────────────────────────────────────────────
  type: documentation  # project-properties | service | website | library | documentation
  lifecycle: experimental   # experimental | production | deprecated

  # ── Ownership ─────────────────────────────────────────────────────────────
  # Format: group:[team-name] or user:[username]
  owner: group:[PLACEHOLDER-team-name]

  # ── Custom Fields ─────────────────────────────────────────────────────────
  # Project-specific properties readable by Backstage plugins, scorecards,
  # and other integrations. Add fields as needed for your workflow.
  # custom1: [PLACEHOLDER — e.g. cost-center, compliance-tier, team-slack]
  # custom2: [PLACEHOLDER — e.g. value]

  # ── Relationships (optional) ──────────────────────────────────────────────
  # List services and resources this component depends on.
  # Format: component:[name] or resource:[name]
  # Keep this current — it drives the dependency graph in the IDP.
  # dependsOn:
  #   - component:[PLACEHOLDER-upstream-service]   # e.g. component:auth-service
  #   - resource:[PLACEHOLDER-database]            # e.g. resource:postgres-billing

  # ── API contracts (optional) ──────────────────────────────────────────────
  # APIs this component exposes (must have a matching API entity in the catalog)
  # providesApis:
  #   - [PLACEHOLDER-api-name]                     # e.g. billing-api-v2

  # APIs this component consumes
  # consumesApis:
  #   - [PLACEHOLDER-consumed-api-name]            # e.g. user-api-v1
'

# =============================================================================
# CHANGELOG.md — Living artifact
# =============================================================================
# WHY: Updated by Claude Code via the /update-context command after significant
#      changes. Provides a human-readable history of what changed and when.
# =============================================================================
write_file "CHANGELOG.md" '# Changelog

<!-- ============================================================
  CHANGELOG.md — Living artifact
  ============================================================
  This file is updated by Claude Code (via /update-context command)
  and by engineers when merging significant changes.

  FORMAT: https://keepachangelog.com/en/1.1.0/
  VERSIONING: https://semver.org/

  HOW TO MAINTAIN:
  - Add entries under [Unreleased] as changes are made
  - When releasing, rename [Unreleased] to the version + date
  - Claude Code should append to [Unreleased] after completing features
  ============================================================ -->

All notable changes to this project will be documented here.

## [Unreleased]

### Added
- Initial repository context structure (CLAUDE.md, docs/context/, .claude/)

### Changed

### Deprecated

### Removed

### Fixed

### Security

---

## [0.1.0] - [PLACEHOLDER-date]

### Added
- Initial project scaffold
'

# =============================================================================
# docs/context/requirements.md
# =============================================================================
# WHY: Captures what the system must do. Written before code, updated as
#      understanding evolves. Read by Claude Code before implementing any
#      feature to understand the problem being solved.
#
# RELATIONSHIP TO FEATURES:
#   This file captures high-level requirements. Feature-level detail
#   (acceptance criteria, API contracts, data model changes) lives in
#   docs/context/features/[feature-name].md
# =============================================================================
write_file "docs/context/requirements.md" '# Requirements

<!-- ============================================================
  docs/context/requirements.md
  ============================================================
  PURPOSE:
    Captures what the system must do. This is the high-level requirements
    document. Feature-level acceptance criteria live in docs/context/features/.

  WHO READS THIS:
    - Engineers onboarding to the project
    - Claude Code, before implementing any feature
    - Backstage TechDocs (rendered in the IDP)
    - Product and architecture reviews

  HOW TO MAINTAIN:
    - Update when the scope of the system changes
    - Link to the ADR when a requirement drives an architectural decision
    - Mark requirements as [DEFERRED] if pushed to a future phase
    - Do not delete requirements — mark them as superseded instead
  ============================================================ -->

## Business Context

<!-- Why does this service exist? What business problem does it solve?
     What would break or be impossible without it?
     2–4 sentences. Audience: any engineer in the organisation. -->

[PLACEHOLDER]

## Problem Statement

<!-- What specific problem is this system solving?
     Frame it from the user/business perspective, not the technical one. -->

[PLACEHOLDER]

## Functional Requirements

<!-- What must the system DO? Use "must", "should", "may" for priority.
     Group by capability area. Link to feature specs where they exist. -->

### [PLACEHOLDER — Capability Area 1]

- [ ] [FR-001] The system MUST [PLACEHOLDER]
- [ ] [FR-002] The system MUST [PLACEHOLDER]
- [ ] [FR-003] The system SHOULD [PLACEHOLDER]

### [PLACEHOLDER — Capability Area 2]

- [ ] [FR-010] The system MUST [PLACEHOLDER]

## Non-Functional Requirements

<!-- Performance, availability, security, compliance, scalability targets.
     Be specific — vague NFRs are unenforceable. -->

### Performance

- [NFR-P01] [PLACEHOLDER — e.g. "API p95 response time must be < 200ms under normal load"]
- [NFR-P02] [PLACEHOLDER — e.g. "The system must handle N concurrent users without degradation"]

### Availability

- [NFR-A01] [PLACEHOLDER — e.g. "Target SLA: 99.9% uptime (< 8.7 hours downtime/year)"]
- [NFR-A02] [PLACEHOLDER — e.g. "RTO: 15 minutes, RPO: 1 hour"]

### Security

- [NFR-S01] [PLACEHOLDER — e.g. "All data at rest must be encrypted (AES-256)"]
- [NFR-S02] [PLACEHOLDER — e.g. "All API endpoints require authentication except /health"]

### Compliance

- [NFR-C01] [PLACEHOLDER — e.g. "Must comply with GDPR for EU user data"]

## Known Constraints

<!-- Fixed constraints that are not negotiable: technology mandates,
     regulatory requirements, organisational standards that cannot change. -->

- [PLACEHOLDER — e.g. "Must deploy on AWS (organisational standard)"]
- [PLACEHOLDER — e.g. "Must use the company SSO for authentication (see ADR-0001)"]

## Out of Scope

<!-- Explicit exclusions. Prevents scope creep. Be specific about what
     this service does NOT do so teams know where to look elsewhere. -->

- [PLACEHOLDER — e.g. "User authentication is handled by auth-service, not this service"]
- [PLACEHOLDER — e.g. "Email delivery is out of scope — use the notifications-service"]
'

# =============================================================================
# docs/context/architecture.md
# =============================================================================
# WHY: Captures how the system is designed. Claude Code reads this to
#      understand patterns to follow, avoid duplication, and build new
#      features consistently with the existing design.
#
# TIP: Use Mermaid diagrams — they render in GitHub, GitLab, and Backstage
#      TechDocs without any additional tooling.
# =============================================================================
write_file "docs/context/architecture.md" '# Architecture

<!-- ============================================================
  docs/context/architecture.md
  ============================================================
  PURPOSE:
    Documents how the system is designed. This is the living architecture
    document. It must be updated when the design changes — in the same PR.

  WHO READS THIS:
    - Engineers making design decisions
    - Claude Code, to understand existing patterns and follow them
    - Architecture reviews and onboarding

  HOW TO MAINTAIN:
    - Update diagrams when the component structure changes
    - Add an ADR reference when a significant decision is made
    - Keep the data model section in sync with the actual schema
    - Do NOT document aspirational architecture — only what exists today
  ============================================================ -->

## System Context

<!-- What is this service, and how does it fit into the wider system?
     Use a C4 Context diagram (Mermaid) to show external actors and systems. -->

```mermaid
C4Context
  title System Context — [PLACEHOLDER: Service Name]

  Person(user, "[PLACEHOLDER: User Type]", "[PLACEHOLDER: What they do]")
  System(thisSystem, "[PLACEHOLDER: This Service]", "[PLACEHOLDER: What it does]")
  System_Ext(extSystem1, "[PLACEHOLDER: External System]", "[PLACEHOLDER: Role]")

  Rel(user, thisSystem, "[PLACEHOLDER: interaction]")
  Rel(thisSystem, extSystem1, "[PLACEHOLDER: integration]")
```

## Component Overview

<!-- What are the major internal components of this service?
     Describe each component responsibility in 1-2 sentences. -->

| Component | Responsibility |
|---|---|
| [PLACEHOLDER] | [PLACEHOLDER] |
| [PLACEHOLDER] | [PLACEHOLDER] |

## Key Design Decisions

<!-- Link to ADRs for significant decisions. This section is a summary index.
     Full rationale lives in docs/context/decisions/ -->

| Decision | ADR | Status |
|---|---|---|
| [PLACEHOLDER — e.g. "Use PostgreSQL as primary DB"] | [ADR-0001](decisions/0001-use-postgresql.md) | Accepted |

## Data Model

<!-- High-level description of the primary data entities and their relationships.
     For detailed schema, link to the actual schema file or Prisma schema. -->

```mermaid
erDiagram
  [PLACEHOLDER-ENTITY-A] {
    string id PK
    string [PLACEHOLDER-field]
    timestamp created_at
  }
  [PLACEHOLDER-ENTITY-B] {
    string id PK
    string [PLACEHOLDER-entity-a-id] FK
  }
  [PLACEHOLDER-ENTITY-A] ||--o{ [PLACEHOLDER-ENTITY-B] : "[PLACEHOLDER-relationship]"
```

Full schema: [PLACEHOLDER — link to prisma/schema.prisma or equivalent]

## API Design

<!-- Summary of the API surface. Full spec should be in OpenAPI format.
     Link to the spec file or the published API docs. -->

- **Protocol:** [PLACEHOLDER — REST / GraphQL / gRPC]
- **Auth:** [PLACEHOLDER — e.g. JWT Bearer tokens issued by auth-service]
- **Base path:** [PLACEHOLDER — e.g. /api/v2]
- **OpenAPI spec:** [PLACEHOLDER — link to openapi.yaml or docs URL]

## Infrastructure and Deployment

<!-- How and where is this service deployed?
     Include enough detail for Claude Code to make infrastructure-aware decisions. -->

- **Hosting:** [PLACEHOLDER — e.g. AWS ECS Fargate]
- **Database:** [PLACEHOLDER — e.g. AWS RDS PostgreSQL 16, Multi-AZ]
- **Managed with:** [PLACEHOLDER — e.g. Terraform in /infra]
- **Environments:** [PLACEHOLDER — e.g. dev / staging / production]
- **Deploy process:** [PLACEHOLDER — e.g. GitHub Actions → ECR → ECS rolling update]

## External Dependencies

<!-- Third-party services this system integrates with. -->

| Service | Purpose | Notes |
|---|---|---|
| [PLACEHOLDER] | [PLACEHOLDER] | [PLACEHOLDER — e.g. SDK version, rate limits to be aware of] |
'

# =============================================================================
# docs/context/constraints.md
# =============================================================================
# WHY: The rules file. Claude Code treats these as hard constraints when
#      generating code. Engineers use it as the authoritative reference for
#      what is and is not allowed in this codebase.
#
# IMPORTANT: Be explicit and opinionated. Vague rules are ignored.
# =============================================================================
write_file "docs/context/constraints.md" '# Constraints

<!-- ============================================================
  docs/context/constraints.md
  ============================================================
  PURPOSE:
    The rules that must not be broken. Claude Code treats these as hard
    constraints when generating code. Engineers use this as the reference
    for coding standards, security mandates, and architectural guardrails.

  HOW TO MAINTAIN:
    - Adding a rule: requires team review (this is a policy file)
    - Removing a rule: requires ADR explaining why the constraint no longer applies
    - Rules should be specific enough to be enforceable, not aspirational
    - If a rule has exceptions, document them explicitly

  FORMAT:
    Each rule has a code [C-NNN] so it can be referenced in code reviews,
    PRs, and ADRs without ambiguity.
  ============================================================ -->

## Coding Standards

- **[C-001]** All new code must be written in [PLACEHOLDER — e.g. TypeScript with strict mode]
- **[C-002]** [PLACEHOLDER — e.g. No `any` types — use `unknown` and narrow explicitly]
- **[C-003]** [PLACEHOLDER — e.g. All functions must have explicit return types]
- **[C-004]** [PLACEHOLDER — e.g. Error handling must use the Result pattern in src/lib/result.ts]

## Database Rules

- **[C-010]** Database migrations must NEVER be written by hand — generate via `[PLACEHOLDER: migration command]`
- **[C-011]** [PLACEHOLDER — e.g. No raw SQL in application code — use the ORM query builder]
- **[C-012]** [PLACEHOLDER — e.g. All queries accessing user data must go through the data-access layer in src/dal/]

## API Rules

- **[C-020]** All new HTTP endpoints must have OpenAPI annotations before the PR can merge
- **[C-021]** [PLACEHOLDER — e.g. Breaking API changes require a new API version — never modify v1 contracts]
- **[C-022]** [PLACEHOLDER — e.g. All endpoints must return errors in the RFC 7807 Problem Details format]

## Security Mandates

- **[C-030]** [PLACEHOLDER — e.g. Secrets must never be committed — use the secrets manager via src/lib/secrets.ts]
- **[C-031]** [PLACEHOLDER — e.g. All user-supplied input must be validated with Zod before processing]
- **[C-032]** [PLACEHOLDER — e.g. Tokens must not be stored in localStorage — use httpOnly cookies]
- **[C-033]** [PLACEHOLDER — e.g. All authentication checks must use the middleware in src/middleware/auth.ts]

## Dependency Management

- **[C-040]** Adding a new third-party dependency requires an ADR in `docs/context/decisions/`
- **[C-041]** [PLACEHOLDER — e.g. Dependencies must be pinned to exact versions in package.json]
- **[C-042]** [PLACEHOLDER — e.g. No dependencies with known HIGH or CRITICAL CVEs may be merged]

## Feature Flags

- **[C-050]** Feature flags must use `[PLACEHOLDER: path/to/flags.ts]` — no raw environment variable conditionals in application code
- **[C-051]** [PLACEHOLDER — e.g. All new features behind a flag must have a corresponding cleanup ticket]

## Testing

- **[C-060]** [PLACEHOLDER — e.g. Unit test coverage must not drop below 80% on new code]
- **[C-061]** [PLACEHOLDER — e.g. All public API endpoints must have integration tests]
- **[C-062]** [PLACEHOLDER — e.g. Tests must not make real network calls — use MSW for HTTP mocking]

## Forbidden Patterns

<!-- Things that are explicitly not allowed in this codebase. -->

- **[C-070]** [PLACEHOLDER — e.g. Do not use console.log — use the logger in src/lib/logger.ts]
- **[C-071]** [PLACEHOLDER — e.g. Do not catch and swallow errors silently]
- **[C-072]** [PLACEHOLDER — e.g. Do not use process.env directly — use src/config.ts]
'

# =============================================================================
# docs/context/glossary.md
# =============================================================================
# WHY: Domain language often has specific meaning that differs from everyday
#      usage or from the same word in other services. This file prevents
#      Claude Code from making incorrect assumptions about terminology.
# =============================================================================
write_file "docs/context/glossary.md" '# Glossary

<!-- ============================================================
  docs/context/glossary.md
  ============================================================
  PURPOSE:
    Defines domain terms that have specific meaning in this bounded context.
    Words that mean something different here than in everyday language,
    or differently than in other services, must be defined here.

  WHY THIS MATTERS FOR CLAUDE CODE:
    Without this, Claude Code may use the correct word but the wrong concept.
    For example, "account" might mean a billing account here but a user
    login account elsewhere. Claude Code needs to know which you mean.

  HOW TO MAINTAIN:
    - Add a term when you find yourself explaining it in a PR review
    - Add a term when a new team member gets confused by it in onboarding
    - Terms should be specific to THIS service domain model
    - Alphabetical order for easy scanning
  ============================================================ -->

## Terms

### [PLACEHOLDER — Term A]

> [PLACEHOLDER — Definition. Be specific about what this term means in THIS
> service, and note how it differs from the everyday meaning or from
> usage in other services if relevant.]

### [PLACEHOLDER — Term B]

> [PLACEHOLDER — Definition.]

---

<!-- Example entries — delete these and replace with your actual domain terms:

### Account

> In this service, "account" refers to a BILLING account — a container for
> subscriptions and invoices. It is NOT the same as a user login credential,
> which is managed by auth-service and called a "principal" there.

### Event

> A domain event published to the message bus after a state transition.
> All events are immutable, named in past tense (e.g. PaymentProcessed),
> and conform to the CloudEvents spec. Not to be confused with calendar
> events in the scheduling-service.

-->
'

# =============================================================================
# docs/context/roadmap.md — Project roadmap
# =============================================================================
# WHY: A living roadmap gives AI agents and developers visibility into where
#      the project is heading. It captures planned phases, tracks completed
#      milestones, and surfaces what is next — all in version-controlled
#      markdown that evolves with the project.
# =============================================================================
write_file "docs/context/roadmap.md" '# [PLACEHOLDER — Project Name] Roadmap

<!-- ============================================================
  docs/context/roadmap.md — Living Roadmap
  ============================================================
  PURPOSE:
    Tracks the planned evolution of this project. This is a living
    document — update it as priorities shift and items are completed.

  WHY THIS MATTERS FOR AI AGENTS:
    AI agents read this file to understand what is planned, what is
    in progress, and what has been delivered. This helps them make
    better decisions about where to focus effort and avoid working
    on features that are not yet planned or have been deprioritized.

  HOW TO MAINTAIN:
    - Move items to "Completed" when merged
    - Add new items under the appropriate phase
    - Re-prioritize at the start of each sprint
    - Link to feature specs and ADRs where they exist
  ============================================================ -->

## Vision

[PLACEHOLDER — 2-3 sentences describing the long-term vision for this project.
What does success look like? What problem will be fully solved?]

## Current Phase: [PLACEHOLDER — Phase Name] (v[PLACEHOLDER])

### Completed

- [x] [PLACEHOLDER — milestone or deliverable that has been completed]
- [x] [PLACEHOLDER — another completed item]

### In Progress

- [ ] [PLACEHOLDER — work currently underway, link to feature spec if exists]

### Next Up

- [ ] [PLACEHOLDER — planned work for the near term]
- [ ] [PLACEHOLDER — another planned item]

## Phase 2: [PLACEHOLDER — Phase Name]

- [ ] [PLACEHOLDER — future milestone]
- [ ] [PLACEHOLDER — future milestone]

## Phase 3: [PLACEHOLDER — Phase Name]

- [ ] [PLACEHOLDER — longer-term goal]
- [ ] [PLACEHOLDER — longer-term goal]

## Ideas / Backlog

<!-- Items that are not yet committed to a phase but are worth tracking.
     Move items up to a phase when they are prioritized. -->

- [PLACEHOLDER — potential future work]
- [PLACEHOLDER — exploratory idea]
'

# =============================================================================
# docs/context/decisions/0001-template.md — ADR template
# =============================================================================
# WHY: Architecture Decision Records create an immutable audit trail of WHY
#      decisions were made. Future engineers (and Claude Code) can understand
#      the reasoning without needing to ask the original authors.
#
# RULE: ADRs are append-only. Never edit a past ADR's decision section.
#       If the decision changes, write a new ADR that supersedes it.
# =============================================================================
write_file "docs/context/decisions/0001-example-decision.md" '# ADR-0001: [PLACEHOLDER — Short title of the decision]

<!-- ============================================================
  docs/context/decisions/NNNN-title.md — Architecture Decision Record
  ============================================================
  PURPOSE:
    Records a significant architectural decision: what was decided,
    why, and what the consequences are. Future engineers and Claude Code
    read these to understand why the system is designed as it is.

  NAMING CONVENTION:
    NNNN-short-kebab-case-title.md
    e.g. 0002-use-event-sourcing.md
         0003-replace-rest-with-grpc.md

  RULES:
    - ADRs are APPEND-ONLY. Never edit the Decision or Context of a past ADR.
    - If a decision is reversed, create a new ADR with status "Supersedes ADR-NNNN"
    - Number sequentially — check the highest existing number before creating
    - Write the ADR BEFORE or WITH the code change, not after

  STATUS VALUES:
    Draft       — being written, not yet decided
    Proposed    — ready for review
    Accepted    — decision has been made and implemented
    Superseded  — replaced by a later ADR (link to it)
    Deprecated  — no longer relevant
  ============================================================ -->

## Status

Accepted

## Date

[PLACEHOLDER — YYYY-MM-DD]

## Authors

[PLACEHOLDER — @github-handle, @github-handle]

## Context

<!-- What situation or problem prompted this decision?
     What forces are at play? What constraints existed?
     Write this so someone with no prior context can understand the situation.
     2–5 paragraphs. -->

[PLACEHOLDER]

## Decision

<!-- What was decided? State it clearly and directly.
     "We will use X because Y."
     Be specific enough that there is no ambiguity about what was chosen. -->

[PLACEHOLDER]

## Consequences

<!-- What becomes EASIER as a result of this decision?
     What becomes HARDER or more constrained?
     What new obligations or risks does this introduce?
     Be honest — acknowledge trade-offs. -->

### Positive

- [PLACEHOLDER]

### Negative / Trade-offs

- [PLACEHOLDER]

### Risks

- [PLACEHOLDER]

## Alternatives Considered

<!-- What other options were evaluated and why were they rejected?
     This prevents relitigating the same decision in the future. -->

### [PLACEHOLDER — Alternative 1]

[PLACEHOLDER — why rejected]

### [PLACEHOLDER — Alternative 2]

[PLACEHOLDER — why rejected]

## References

<!-- Links to relevant documentation, issues, RFCs, or prior art. -->

- [PLACEHOLDER — link]
'

# =============================================================================
# docs/context/features/example-feature.md — Feature spec template
# =============================================================================
# WHY: Claude Code reads the relevant feature spec before building a feature.
#      This ensures it builds to spec rather than guessing intent, and that
#      acceptance criteria are tracked in version control.
#
# COPY THIS FILE for each new feature. Name it after the feature.
# =============================================================================
write_file "docs/context/features/example-feature.md" '# Feature: [PLACEHOLDER — Feature Name]

<!-- ============================================================
  docs/context/features/[feature-name].md — Feature Specification
  ============================================================
  PURPOSE:
    The spec for a single feature. Contains everything Claude Code needs
    to build the feature correctly: acceptance criteria, data model,
    API contract, and constraints.

  HOW TO USE:
    1. Copy this file: cp example-feature.md [your-feature-name].md
    2. Fill in all [PLACEHOLDER] sections
    3. Reference this file in CLAUDE.md "Current sprint focus"
    4. As Claude Code completes acceptance criteria, tick the checkboxes
    5. When complete, update Status to "complete"

  STATUS VALUES:
    draft        — being written, not ready for development
    in-progress  — actively being built
    complete     — all acceptance criteria met and merged
    deprecated   — no longer needed, not built
  ============================================================ -->

## Status

`draft`

## ADR

<!-- Link to ADR if this feature required an architectural decision.
     Leave blank if no ADR was needed. -->

[PLACEHOLDER — e.g. [ADR-0002](../decisions/0002-example.md) or "None required"]

## Problem Statement

<!-- What user or business problem does this feature solve?
     1–3 sentences from the user/business perspective. -->

[PLACEHOLDER]

## Acceptance Criteria

<!-- These are the definition of done. Each checkbox is a verifiable outcome.
     Claude Code ticks these off as it implements them.
     Write them as "Given/When/Then" or as direct observable outcomes. -->

- [ ] [AC-001] [PLACEHOLDER — e.g. "A user can submit X and receive Y within Z seconds"]
- [ ] [AC-002] [PLACEHOLDER — e.g. "If X fails, the user receives error message Y"]
- [ ] [AC-003] [PLACEHOLDER — e.g. "The action is logged with fields A, B, C"]
- [ ] [AC-004] [PLACEHOLDER — e.g. "Unit tests cover the happy path and all error cases"]

## Data Model Changes

<!-- Describe any new or modified database entities.
     Use the same syntax as your ORM (e.g. Prisma schema, SQLAlchemy models).
     Leave blank if no schema changes are needed. -->

```
[PLACEHOLDER — paste Prisma model, SQL DDL, or describe the change]
```

## API Contract

<!-- New or modified endpoints. Be specific about request/response shape.
     For REST: METHOD /path → status { response body } | error codes
     For events: EventName { fields } published to [topic] -->

```
[PLACEHOLDER — e.g.
POST /[resource] → 201 { id, createdAt } | 400 { error } | 422 { validationErrors }
GET  /[resource]/:id → 200 { ... } | 404
]
```

## Non-Functional Requirements

<!-- Performance, security, or compliance requirements specific to this feature.
     Reference constraint codes from docs/context/constraints.md where relevant. -->

- [PLACEHOLDER — e.g. "Endpoint p95 must be < 150ms (see NFR-P01)"]
- [PLACEHOLDER — e.g. "User data must be validated per [C-031]"]

## Out of Scope

<!-- What is explicitly NOT included in this feature.
     Prevents scope creep and clarifies where to look for excluded behaviour. -->

- [PLACEHOLDER]

## Open Questions

<!-- Unresolved questions that must be answered before or during development.
     Remove items as they are resolved — add a note about the resolution. -->

- [ ] [PLACEHOLDER — open question]
'

# =============================================================================
# Slash commands — agent-specific command directories
# =============================================================================
# Each agent gets its own command directory structure:
#   claude   → .claude/commands/
#   copilot  → .github/copilot/commands/
#   opencode → .opencode/commands/
#
# Commands are functionally identical across agents — the same 4 core commands
# (new-feature, create-adr, update-context, review-pr) are created in each
# selected agent's directory.
# =============================================================================

# Build list of command directories based on selected agents
COMMAND_DIRS=()
if has_agent claude; then
  COMMAND_DIRS+=(".claude/commands")
fi
if has_agent copilot; then
  COMMAND_DIRS+=(".github/copilot/commands")
fi
if has_agent opencode; then
  COMMAND_DIRS+=(".opencode/commands")
fi

# ── Create command files for each selected agent ─────────────────────────────
for CMD_DIR in "${COMMAND_DIRS[@]}"; do

# =============================================================================
# ${CMD_DIR}/new-feature.md
# =============================================================================
# WHY: Encodes the "start a new feature" workflow as a reusable
#      slash command. Ensures every feature starts with a spec and the right
#      scaffolding, consistently across the team.
# =============================================================================
write_file "${CMD_DIR}/new-feature.md" '# Command: /new-feature

<!-- ============================================================
  .claude/commands/new-feature.md — Slash Command Definition
  ============================================================
  USAGE:
    /new-feature [feature-name]

  PURPOSE:
    Scaffolds a new feature: creates the spec, boilerplate module,
    test skeleton, and updates CLAUDE.md sprint focus.

  HOW CLAUDE CODE USES THIS:
    When the engineer types /new-feature [name], Claude Code reads
    this file and executes the steps below.

  HOW TO CUSTOMISE:
    Modify the steps to match your project structure, naming conventions,
    and scaffolding preferences.
  ============================================================ -->

## Steps

When the engineer runs `/new-feature [name]`:

1. **Read context first**
   - Read `docs/context/requirements.md` to understand the problem domain
   - Read `docs/context/architecture.md` to understand existing patterns
   - Read `docs/context/constraints.md` to know what rules apply

2. **Create the feature spec**
   - Copy `docs/context/features/example-feature.md` to `docs/context/features/[name].md`
   - Set status to `draft`
   - Ask the engineer: "What problem does this feature solve?" and "What are the acceptance criteria?"
   - Fill in the spec based on the answers — do not start coding until the spec has at least a problem statement and at least 2 acceptance criteria

3. **Check for architectural decisions**
   - If the feature requires a new third-party dependency → stop and ask before proceeding
   - If the feature requires a schema change → confirm the migration approach per [C-010]
   - If the feature changes the API surface → confirm the versioning strategy per [C-021]

4. **Scaffold the module**
   - Create `src/[PLACEHOLDER: your module path]/[name]/` with:
     - `index.ts` — public exports only
     - `[name].service.ts` — business logic
     - `[name].types.ts` — TypeScript types and Zod schemas
     - `[name].routes.ts` — HTTP route handlers (if applicable)
     - `[name].test.ts` — test skeleton with describe blocks matching acceptance criteria

5. **Update CLAUDE.md**
   - Add the feature spec path to "Active features" in the "Current sprint focus" section

6. **Confirm with the engineer**
   - Report what was created
   - List the acceptance criteria from the spec
   - Ask: "Ready to start implementing? Any changes to the spec before I begin?"
'

# =============================================================================
# ${CMD_DIR}/create-adr.md
# =============================================================================
write_file "${CMD_DIR}/create-adr.md" '# Command: /create-adr

<!-- ============================================================
  .claude/commands/create-adr.md — Slash Command Definition
  ============================================================
  USAGE:
    /create-adr [topic]

  PURPOSE:
    Creates a new Architecture Decision Record with correct sequential
    numbering and the standard template pre-filled based on context.

  WHEN TO USE:
    - Adding a new third-party dependency (required per [C-040])
    - Making a significant architectural change
    - Choosing between two viable technical approaches
    - Reversing or superseding a previous decision
  ============================================================ -->

## Steps

When the engineer runs `/create-adr [topic]`:

1. **Determine the next ADR number**
   - List all files in `docs/context/decisions/`
   - Find the highest NNNN prefix
   - New ADR number = highest + 1 (zero-padded to 4 digits)

2. **Gather context**
   - Ask: "What situation or problem is driving this decision?"
   - Ask: "What are the options you considered?"
   - Ask: "What did you decide and why?"
   - If this supersedes a previous ADR: ask which one

3. **Create the ADR**
   - Create `docs/context/decisions/[NNNN]-[kebab-case-topic].md`
   - Use the template from `docs/context/decisions/0001-example-decision.md`
   - Fill in Context, Decision, and Consequences from the answers above
   - Set status to `Proposed` (engineer changes to `Accepted` after review)

4. **Update references**
   - If this ADR relates to an active feature, add the ADR link to the feature spec
   - If this ADR changes the architecture, note it in `docs/context/architecture.md` Key Design Decisions table

5. **Confirm**
   - Show the created ADR path and summarise the decision in 2 sentences
   - Remind the engineer to change status from Proposed to Accepted after team review
'

# =============================================================================
# ${CMD_DIR}/update-context.md
# =============================================================================
write_file "${CMD_DIR}/update-context.md" '# Command: /update-context

<!-- ============================================================
  .claude/commands/update-context.md — Slash Command Definition
  ============================================================
  USAGE:
    /update-context

  PURPOSE:
    Syncs docs/context/ files after a significant change. Run this at the
    end of a feature, refactor, or any change that affects the architecture,
    data model, API, or dependencies.

  THIS IS THE MECHANISM THAT KEEPS CONTEXT CURRENT.
  Running this command is what separates a context-driven project from
  one where the docs rot. Make it a habit.
  ============================================================ -->

## Steps

When the engineer runs `/update-context`:

1. **Review what changed**
   - Review the git diff since the last context update commit
   - Identify: new files, deleted files, changed dependencies, schema changes, API changes, new patterns

2. **Update feature specs**
   - For any completed acceptance criteria, tick the checkboxes in the relevant `docs/context/features/` file
   - Update feature status to `complete` if all criteria are met

3. **Update architecture.md (if needed)**
   - If new components were added, update the Component Overview table
   - If the data model changed, update the ER diagram
   - If new external dependencies were added, update the External Dependencies table
   - If the deployment topology changed, update Infrastructure and Deployment

4. **Update CLAUDE.md (if needed)**
   - If new dependencies were added to package.json/requirements.txt, update the Stack section
   - If new constraints were identified, add them to `docs/context/constraints.md` and reference from CLAUDE.md

5. **Update CHANGELOG.md**
   - Add a bullet under `[Unreleased]` for each significant change
   - Use the Keep a Changelog format: Added / Changed / Fixed / Removed

6. **Update constraints.md (if needed)**
   - If a new coding pattern was established that should be enforced, add it as a constraint with a [C-NNN] code

7. **Summarise**
   - Report which files were updated and what changed in each
   - Flag any open questions or areas where the context could not be updated without more information
'

# =============================================================================
# ${CMD_DIR}/review-pr.md
# =============================================================================
write_file "${CMD_DIR}/review-pr.md" '# Command: /review-pr

<!-- ============================================================
  .claude/commands/review-pr.md — Slash Command Definition
  ============================================================
  USAGE:
    /review-pr

  PURPOSE:
    Runs a pre-merge checklist to ensure the PR is complete:
    code is consistent with context files, context files are updated,
    and constraints are respected.

  RUN THIS BEFORE:
    - Requesting review from a teammate
    - Merging a PR
  ============================================================ -->

## Checklist

When the engineer runs `/review-pr`:

### Context completeness
- [ ] If the architecture changed → `architecture.md` has been updated
- [ ] If a new dependency was added → an ADR exists in `docs/context/decisions/`
- [ ] If a feature is complete → acceptance criteria are checked off in the feature spec
- [ ] If a new constraint was identified → it is in `constraints.md`
- [ ] `CLAUDE.md` stack section reflects the current state of `package.json` (or equivalent)
- [ ] `CHANGELOG.md` has an entry for this change under `[Unreleased]`

### Code quality
- [ ] No violations of the constraints in `docs/context/constraints.md`
- [ ] New code follows the patterns established in `architecture.md`
- [ ] Tests cover the acceptance criteria in the feature spec

### Security
- [ ] No secrets or credentials committed
- [ ] User input is validated per [C-031]
- [ ] Authentication checks follow [C-033]

### API (if applicable)
- [ ] New endpoints have OpenAPI annotations per [C-020]
- [ ] Breaking changes have a versioning strategy per [C-021]

## Report

After running the checklist:
- List any items that FAIL with a brief explanation
- List any items that could not be verified
- If all items pass: confirm the PR is ready for review
'

done  # end for CMD_DIR in COMMAND_DIRS

# =============================================================================
# docs/mkdocs.yml — Backstage TechDocs configuration
# =============================================================================
# WHY: Backstage renders the docs/ directory as a TechDocs site in the IDP.
#      This config maps docs/context/ files (the single source of truth) into
#      the TechDocs navigation structure, so the same files appear in both
#      the repo and the IDP without duplication.
# =============================================================================
write_file "docs/mkdocs.yml" '# =============================================================================
# docs/mkdocs.yml — Backstage TechDocs Configuration
# =============================================================================
# PURPOSE:
#   Configures how Backstage renders this component'"'"'s documentation in the
#   Internal Developer Portal (IDP). The nav section maps docs/context/ files
#   into a browsable TechDocs site — the SAME source files, no duplication.
#
# HOW BACKSTAGE USES THIS:
#   The catalog-info.yaml annotation "backstage.io/techdocs-ref: dir:."
#   tells Backstage to look for mkdocs.yml in this directory and render it.
#
# HOW TO MAINTAIN:
#   - Update site_name when the service is renamed
#   - Add nav entries when new docs/context/ files are created
#   - The paths in nav are relative to the docs/ directory
#     (use "../" to reference docs/context/ which is one level up)
#
# DOCS: https://backstage.io/docs/features/techdocs/
# =============================================================================

site_name: "[PLACEHOLDER — Service Name] Documentation"
site_description: "[PLACEHOLDER — One sentence describing this service]"

# ── Theme ─────────────────────────────────────────────────────────────────
# Backstage overrides MkDocs themes with its own renderer.
# Keep this as "material" — it is the Backstage-compatible base.
theme:
  name: material

# ── Plugins ───────────────────────────────────────────────────────────────
plugins:
  - techdocs-core     # Required by Backstage — do not remove

# ── Navigation ────────────────────────────────────────────────────────────
# Map your docs/context/ files into a human-readable structure.
# Paths are relative to the docs/ directory (where mkdocs.yml lives).
nav:
  - Overview: index.md
  - Requirements: context/requirements.md
  - Architecture: context/architecture.md
  - Constraints: context/constraints.md
  - Decisions:
    - Overview: context/decisions/0001-example-decision.md
    # Add new ADRs here as you create them:
    # - "ADR-0002: [title]": context/decisions/0002-title.md
  - Features:
    - Example Feature: context/features/example-feature.md
    # Add new features here as you create them:
    # - "[Feature Name]": context/features/[feature-name].md
  - Glossary: context/glossary.md
  - Roadmap: context/roadmap.md
  - Development Guide: development.md
'

# =============================================================================
# docs/index.md — TechDocs landing page
# =============================================================================
write_file "docs/index.md" '# [PLACEHOLDER — Service Name]

<!-- ============================================================
  docs/index.md — TechDocs Landing Page
  ============================================================
  This is the first page engineers see when they open this service'"'"'s
  documentation in Backstage. Keep it brief and navigational.
  ============================================================ -->

> [PLACEHOLDER — one sentence: what does this service do?]

## Quick Links

| What you need | Where to find it |
|---|---|
| What this service must do | [Requirements](context/requirements.md) |
| How it is designed | [Architecture](context/architecture.md) |
| Rules for contributing | [Constraints](context/constraints.md) |
| Why decisions were made | [ADRs](context/decisions/) |
| Active feature specs | [Features](context/features/) |
| Domain terminology | [Glossary](context/glossary.md) |
| Project roadmap | [Roadmap](context/roadmap.md) |

## Ownership

- **Team:** [PLACEHOLDER — team name]
- **On-call:** [PLACEHOLDER — link to PagerDuty / on-call rotation]
- **Slack channel:** [PLACEHOLDER — #channel-name]

## Running Locally

```bash
[PLACEHOLDER — commands to clone, install, and run this service locally]
```

## Contributing

Before contributing, read:
1. [Constraints](context/constraints.md) — the rules
2. [Architecture](context/architecture.md) — existing patterns to follow
3. [CLAUDE.md](../CLAUDE.md) — AI-assisted workflow and sprint focus
'

# =============================================================================
# docs/development.md — Developer guide
# =============================================================================
write_file "docs/development.md" '# Development Guide

<!-- ============================================================
  docs/development.md — Developer Guide
  ============================================================
  Practical guide for engineers working on this service day to day.
  This is the "how" — procedures, commands, and workflows.
  The "what" and "why" live in docs/context/.
  ============================================================ -->

## Prerequisites

- [PLACEHOLDER — e.g. Node 20+, Docker, AWS CLI configured]

## Setup

```bash
# Clone
git clone [PLACEHOLDER: repo-url]
cd [PLACEHOLDER: repo-name]

# Install dependencies
[PLACEHOLDER: e.g. pnpm install]

# Copy environment config
cp .env.example .env
# Edit .env — see docs/context/constraints.md [C-072] for config approach

# Start local dependencies (database, message bus, etc.)
[PLACEHOLDER: e.g. docker compose up -d]

# Run database migrations
[PLACEHOLDER: e.g. pnpm db:migrate]

# Start the development server
[PLACEHOLDER: e.g. pnpm dev]
```

## Running Tests

```bash
# Unit tests
[PLACEHOLDER: e.g. pnpm test]

# Integration tests
[PLACEHOLDER: e.g. pnpm test:integration]

# All tests with coverage
[PLACEHOLDER: e.g. pnpm test:coverage]
```

## AI-Assisted Development with Claude Code

This repository is configured for AI-assisted development with multiple tools:

- **Claude Code** — reads `CLAUDE.md` as its entry point
- **GitHub Copilot** — reads `.github/copilot-instructions.md` as its entry point
- **OpenCode** — reads `AGENTS.md` as its entry point

All three entry points share the same project context and stay synchronized.

To get started with Claude Code:

1. Open the repo in your terminal
2. Run `claude` to start a session
3. Claude Code will read `CLAUDE.md` and be oriented to the project

### Useful slash commands

| Command | What it does |
|---|---|
| `/new-feature [name]` | Scaffold a new feature spec and module |
| `/create-adr [topic]` | Log an architectural decision |
| `/update-context` | Sync context files after a change |
| `/review-pr` | Pre-merge checklist |

## Deployment

[PLACEHOLDER — describe how to deploy, what environments exist, and who
can trigger deployments. Link to the CI/CD pipeline configuration.]
'

# =============================================================================
# Summary
# =============================================================================
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "  ${GREEN}Done!${RESET} Created: ${GREEN}${created}${RESET} files, templates: ${BLUE}${migrated}${RESET} (-HARC alongside existing)"
echo -e "  Agents: ${CYAN}${AGENTS}${RESET}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo "  Structure created:"
echo ""
if has_agent claude; then
echo "  CLAUDE.md"
fi
if has_agent opencode; then
echo "  AGENTS.md"
fi
if has_agent copilot; then
echo "  .github/"
echo "  └── copilot-instructions.md"
fi
echo "  catalog-info.yaml"
echo "  CHANGELOG.md"
for CMD_DIR in "${COMMAND_DIRS[@]}"; do
  # Pretty-print the command directory tree
  local_parts=(${CMD_DIR//\// })
  echo "  ${CMD_DIR}/"
  echo "      ├── new-feature.md"
  echo "      ├── create-adr.md"
  echo "      ├── update-context.md"
  echo "      └── review-pr.md"
done
echo "  docs/"
echo "  ├── mkdocs.yml"
echo "  ├── index.md"
echo "  ├── development.md"
echo "  └── context/"
echo "      ├── requirements.md"
echo "      ├── architecture.md"
echo "      ├── constraints.md"
echo "      ├── glossary.md"
echo "      ├── roadmap.md"
echo "      ├── decisions/"
echo "      │   └── 0001-example-decision.md"
echo "      └── features/"
echo "          └── example-feature.md"
echo ""
echo -e "  ${YELLOW}Next steps:${RESET}"
if [ "$migrated" -gt 0 ]; then
  echo "  1. Find -HARC template files:"
  echo "     find . -name '*-HARC*' -type f"
  echo "  2. For each -HARC file, ask your AI agent to refactor the original"
  echo "     file into the HARC format using the -HARC file as a template"
  echo "  3. Delete the -HARC files when done:"
  echo "     find . -name '*-HARC*' -type f -delete"
  echo "  4. Fill in remaining [PLACEHOLDER] values"
  echo "  5. git add docs/ .claude/ .github/ CLAUDE.md AGENTS.md CHANGELOG.md"
  echo "  6. git commit -m \"chore: adopt HARC context structure\""
else
  echo "  1. Replace all [PLACEHOLDER] values in the generated files"
  echo "  2. Delete example-feature.md and 0001-example-decision.md"
  echo "     (or rename them for your first real feature/decision)"
  echo "  3. git add docs/ .claude/ .github/ CLAUDE.md AGENTS.md catalog-info.yaml CHANGELOG.md"
  echo "  4. git commit -m \"chore: initialise platform context architecture\""
  echo "  5. (Optional) Import catalog-info.yaml into your Backstage instance"
fi
echo ""
