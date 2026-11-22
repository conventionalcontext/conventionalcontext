---
type: roadmap
status: current
---

# Roadmap

Where the project is heading, as Now / Next / Later. The specification, the
templates, and this repository's own `docs/context/` evolve together through
the 0.x versions. Items link to feature files where they exist.

## Now: 0.1.0

The project's own intent, written down and agreed, then the Level 1
specification text built on it. **v0.1.0 is tagged and released only when
`spec/v0.1/SPEC.md` has been written, reviewed, and approved.** Until then,
changes are listed under `Unreleased` in `CHANGELOG.md`.

Foundation (done):

- [x] Repository foundation: README, licenses by directory, CODEOWNERS,
  AGENTS.md, CHANGELOG
- [x] `docs/context/` for this project: requirements, constraints, glossary,
  architecture, roadmap, decision records, feature files
- [x] `## Conventions` section in this repository's `AGENTS.md`
- [x] Archive for previous decisions
  ([decision 0015](decisions/0015-archive-previous-decisions.md))
- [x] [Project website](features/website.md) in `docs/website/`, deployed
  to GitHub Pages

Release gate:

- [ ] Specification text for Level 1 in `spec/v0.1/SPEC.md`:
  [context structure](features/context-structure.md) and
  [agent routing](features/agent-routing.md), written, reviewed, and approved
- [ ] Website specification page updated from draft summary to the approved
  text

## Next

- Point `conventionalcontext.org` at the GitHub Pages site (CNAME and DNS),
  replacing the redirect to the repository
- [Frontmatter schema](features/frontmatter-schema.md) with `$id` under
  conventionalcontext.org
- [Templates](features/templates.md) in `templates/docs/context/`
- [Adapters](features/adapters.md) for AGENTS.md, GitHub Spec Kit, and
  OpenSpec
- [Platform profile](features/platform-profile.md) and a filled-in
  platform example in `examples/platform/`
- Define Level 2, [provenance](features/provenance.md), for 0.2
  ([decision 0012](decisions/0012-defer-level-2-provenance.md))
- [Agent skills](features/agent-skills.md) `new-decision`, `new-feature`,
  and `check-context` in `skills/`, after the specification and templates
  ([decision 0018](decisions/0018-agent-skills-for-context-actions.md),
  proposed)
- `CONTRIBUTING.md`: how to propose specification changes and decision
  records
- Decide changelog generation and release automation for this repository
  ([decision 0014](decisions/0014-changelog-and-release-automation.md),
  proposed): Keep a Changelog, conventional-changelog, or a hybrid; and
  release-please, semantic-release, or manual releases

## Later

- Decision record: choose the language and packaging for tooling (C-004)
- [Lint](features/lint.md): check context files against the specification
  and schema, and a CI workflow for this repository
- [Init](features/init.md): scaffold `docs/context/` from the templates
- **Optional upgrade path for adopters** (FR-015). Not a sync tool. Idea:
  publish a specification for each context file type and for the expected
  structure of `AGENTS.md`, and give adopters a prompt or agent skill that
  compares their files against a newer specification version and shows the
  changes an upgrade would make. Agents (Claude Code, GitHub Copilot, ...) do
  the work in the adopter's repository; adopters review and accept.
- Adapter for AWS AI-DLC and Kiro (`requirements.md`, `design.md`,
  `tasks.md`)
- Choose a diagram approach for this repository's own documentation
  ([decision 0009](decisions/0009-no-prescribed-diagram-tool.md))
- More profiles and examples

## Parked

Kept for later consideration; not planned.

- **In-git ticket system:** backlog items as Markdown files with frontmatter
  on an orphan `tickets` branch, synced with GitHub Issues, with claim and
  lock fields for coordinating several agents. Carried over from HARC.

## Out of scope

Decided against; see [decision 0002](decisions/0002-grow-out-of-harc.md) and
[constraints.md](constraints.md).

- BMAD Method compatibility (C-012)
- Backstage, TechDocs, catalog annotations, and scorecards
- One instruction file per agent tool kept in sync (replaced by AGENTS.md)
- A re-runnable bootstrap that writes side-by-side template copies into
  adopting repositories
