# Changelog

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
- OpenCode support via AGENTS.md entry point (ADR-0004)
- CHANGELOG.md maintenance instructions in all AI entry point files
- Getting started guide at docs/getting-started.md
- HARC framework documentation site structure (docs/mkdocs.yml)
- `scripts/bootstrap.sh` — bootstrap script that safely handles both new and existing repos
- `-HARC` template behavior — when a file already exists, creates `<basename>-HARC.<ext>` alongside it
- `tests/test-bootstrap.sh` — automated test runner for bootstrap (fresh + existing + upgrade scenarios)
- Upgrade test scenario — verifies re-running bootstrap creates -HARC templates for all previously-created files
- Realistic test dataset for existing-repo and upgrade tests (simulates an Acme Billing project)
- README.md feature list — bullet-point list of features linking to `docs/context/features/` specs
- Living artifact rule: AI agents must keep `README.md` feature list updated when features change
- AC-020 through AC-024 in living-artifacts.md for README feature list
- ADR-0005: HARC vs GitHub Spec Kit vs BMAD Method comparison and positioning
- ADR-0006: HARC as a Spec Kit extension (draft)
- LICENSE file (Apache License 2.0)
- Feature spec: context-structure.md (status: complete)
- Feature spec: agent-entry-points.md (status: complete)
- Feature spec: bootstrap-migration.md (status: complete)
- Feature spec: backstage-integration.md (status: in-progress)
- Feature spec: living-artifacts.md (status: complete)
- Feature spec: bmad-compatibility.md (status: in-progress)
- Feature spec: spec-kit-interoperability.md (status: draft)
- `--agent` flag for bootstrap script — select which agents to configure (claude, copilot, opencode; default: claude)
- Agent-specific slash command directories (`.claude/commands/`, `.github/copilot/commands/`, `.opencode/commands/`)
- `docs/context/roadmap.md` — living roadmap with phased feature plan
- `.gitignore` — ignores `test-results/` and `.DS_Store`
- Architecture diagram image in README.md, docs/harc-guide.md, and docs/context/architecture.md (`assets/harc_architecture_with_agents_v2.svg`)
- Generated `assets/harc_architecture_with_agents_v2.png` from SVG
- Migration process documented in README.md, docs/getting-started.md, and docs/harc-guide.md
- Bootstrap test constraint (C-094) — tests must pass before merging bootstrap changes
- Requirements FR-023 through FR-025 for bootstrap and test script

### Changed
- **Moved `.context/` to `docs/context/`** — context files now render automatically in MkDocs/TechDocs alongside project documentation
- **Bootstrap script now uses `--agent` flag** — default creates claude-only; use `--agent claude,copilot,opencode` for all agents
- Test script default changed from fresh-only to running all scenarios (use `--fresh`, `--existing`, or `--upgrade` to run one)
- Fixed template mkdocs.yml nav paths from `../docs/context/` to `context/` (correct relative paths)
- Fixed template docs/index.md links from `../docs/context/` to `context/` (correct relative paths)
- Backstage integration is now optional throughout all documentation
- AI entry point files now sync across three files (CLAUDE.md, copilot-instructions.md, AGENTS.md)
- Moved HARC.md to docs/harc-guide.md (comprehensive reference)
- Moved Backstage TechDocs templates to templates/docs/
- Separated docs/ (HARC framework docs) from templates/docs/ (Backstage templates)
- Updated all docs/context/ files with OpenCode references
- Updated constraints to reflect three-file sync requirement (C-030 through C-034)
- AI tool support table now includes OpenCode in README.md
- Bootstrap script now creates AGENTS.md (OpenCode entry point)
- Bootstrap script templates updated for three-file sync (CLAUDE.md, copilot-instructions.md, AGENTS.md)
- Bootstrap script templates include CHANGELOG.md in key files table
- Bootstrap script docs/development.md template lists all three AI tools
- Bootstrap script header, summary output, and next steps include AGENTS.md
- Backstage marked optional in bootstrap script header and next steps
- Added bootstrap script sync constraint (C-090 through C-093) to docs/context/constraints.md
- Added bootstrap script sync rule to CLAUDE.md, AGENTS.md, and copilot-instructions.md
- Renamed `bootstrap-aipk-framework-harc.sh` → `scripts/bootstrap.sh`
- Updated all docs to reference `scripts/bootstrap.sh` instead of legacy filename
- Updated all `curl` download URLs to use `aipk-framework-harc` repo path
- License changed from MIT to Apache License 2.0
- ADR-0002 (in-git ticket system) status changed from Proposed to Draft

### Deprecated

### Removed

### Fixed

### Security

---

## [0.1.0] - [PLACEHOLDER-date]

### Added
- Initial project scaffold
