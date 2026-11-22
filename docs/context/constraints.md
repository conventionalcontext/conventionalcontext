# Constraints

## Documentation Standards

- **[C-001]** All context files MUST be valid Markdown renderable by GitHub/GitLab
- **[C-002]** CLAUDE.md MUST be under 80 lines (prevents context window bloat)
- **[C-003]** All markdown files MUST use proper column-aligned table formatting
- **[C-004]** Mermaid diagrams MUST be used for architecture visualization (renders natively)

## ADR Rules

- **[C-010]** ADRs MUST be named `NNNN-kebab-case-title.md` with sequential numbering
- **[C-011]** ADRs are APPEND-ONLY — never edit the Decision or Context of a past ADR
- **[C-012]** To reverse a decision, create a new ADR with status "Supersedes ADR-NNNN"
- **[C-013]** ADRs MUST include: Status, Date, Context, Decision, Consequences

## Context File Rules

- **[C-020]** `docs/context/` files MUST be updated in the same PR as related code changes
- **[C-021]** Feature specs MUST be created before implementation begins
- **[C-022]** Acceptance criteria MUST use checkbox format: `- [ ] [AC-NNN] description`
- **[C-023]** Glossary terms MUST be defined when domain language differs from common usage

## AI Instruction Files

- **[C-030]** `CLAUDE.md`, `.github/copilot-instructions.md`, and `AGENTS.md` MUST stay synchronized
- **[C-031]** All three files MUST contain a sync notice referencing the other two
- **[C-032]** Detailed rules MUST live in `docs/context/constraints.md`, not duplicated in entry files
- **[C-033]** Project-specific rules MUST be added here, not in the entry point files
- **[C-034]** All three entry point files MUST instruct agents to update `CHANGELOG.md` after changes

## Ticket System Rules (When Implemented)

- **[C-040]** Tickets MUST live on orphan `tickets` branch (never main branch)
- **[C-041]** Ticket IDs MUST follow pattern: `TICK-NNNN` or `EPIC-NNNN` or `BUG-NNNN`
- **[C-042]** All ticket files MUST have valid YAML frontmatter
- **[C-043]** Agents MUST claim tickets before starting work (set `locked_by`)
- **[C-044]** Locks expire after 4 hours if not released
- **[C-045]** Epic creation MUST go through PR workflow (not direct push)

## Backstage Integration (Optional)

- **[C-050]** If using Backstage, the repo SHOULD have a `catalog-info.yaml` at root
- **[C-051]** If using Backstage, `catalog-info.yaml` SHOULD include `harc.dev/context-path: docs/context/` annotation
- **[C-052]** If using Backstage, TechDocs SHOULD render from `docs/` directory
- **[C-053]** Backstage files (`catalog-info.yaml`, `docs/mkdocs.yml`) MAY be deleted if Backstage is not used

## Git and PR Workflow

- **[C-060]** PRs touching architecture MUST update `docs/context/architecture.md`
- **[C-061]** PRs adding dependencies MUST create an ADR
- **[C-062]** PRs completing features MUST check off acceptance criteria
- **[C-063]** PRs adding constraints MUST update this file

## BMAD Method Compatibility

- **[C-070]** HARC structures MUST map to BMAD concepts where applicable
- **[C-071]** Sprint status MAY be tracked in `tickets` branch or BMAD `sprint-status.yaml`
- **[C-072]** Story files MAY live in `docs/context/features/` or `tickets` branch (not both)

## Bootstrap Script Sync

- **[C-090]** `scripts/bootstrap.sh` MUST be updated whenever framework files, templates, or directory structure change
- **[C-091]** The bootstrap script output MUST match the current framework design — file list, directory structure, template content, and AI entry point files
- **[C-092]** The bootstrap script MUST create all three AI entry point files: `CLAUDE.md`, `.github/copilot-instructions.md`, and `AGENTS.md`
- **[C-093]** PRs that change framework structure without updating the bootstrap script MUST NOT be merged
- **[C-094]** `tests/test-bootstrap.sh` MUST pass before merging bootstrap changes

## Forbidden Patterns

- **[C-080]** Do NOT put requirements in Confluence/Notion (AI agents cannot read them)
- **[C-081]** Do NOT use a single flat README.md for all documentation
- **[C-082]** Do NOT write documentation after the code is complete
- **[C-083]** Do NOT make CLAUDE.md longer than 80 lines (depth belongs in `docs/context/`)
- **[C-084]** Do NOT edit past ADRs — create new ones that supersede
- **[C-085]** Do NOT store context outside version control
- **[C-086]** Do NOT have one CLAUDE.md for an entire monorepo (use per-package files)
