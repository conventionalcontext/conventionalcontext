---
type: constraints
status: current
---

# Constraints

Rules that limit how the specification, this repository, and its tooling are
designed and changed. They are grouped as in
[arc42 section 2](https://docs.arc42.org/section-2/) (technical,
organizational, conventions). arc42 suggests no ID scheme, so constraints use
`C-NNN`. Changing or removing a constraint needs a decision record.

## Technical constraints

| ID | Constraint | Background |
|---|---|---|
| C-001 | Context files are Markdown with YAML frontmatter. | Readable everywhere, rendered by every git host, parseable by tools (NFR-001). |
| C-002 | No context file may require a diagram tool to be understood. Diagrams are optional, and the repository declares its tool in `AGENTS.md`. | Diagram tools differ in support and quality; text must stand on its own ([0009](decisions/0009-no-prescribed-diagram-tool.md)). |
| C-003 | Nothing in the specification may require a runtime, package, or service to read or write context. | Tooling is optional (NFR-008). |
| C-004 | The language for any tooling (linter, init) is not yet chosen and must be decided in a decision record before tooling is built. | Avoid committing to a stack by default. |

## Organizational constraints

| ID | Constraint | Background |
|---|---|---|
| C-010 | Every change merges through a pull request reviewed by a maintainer other than its author, once there are two maintainers. | Shared ownership; the `protect-main` ruleset enforces it. |
| C-011 | Licenses follow the directory: `spec/`, `profiles/`, `adapters/` CC-BY-4.0; `templates/` CC0-1.0; everything else Apache-2.0. | [0010](decisions/0010-license-by-directory.md) |
| C-012 | The BMAD Method is out of scope: no adapter, mapping, or terminology from it. | Its size makes it a context and usage cost the project does not want to carry. |
| C-013 | Adopting further sections of arc42 needs a maintainer's explicit agreement and a decision record. | Keep track of which parts of arc42 the project aligns with ([0008](decisions/0008-partial-arc42-alignment.md)). |

## Conventions

| ID | Constraint | Background |
|---|---|---|
| C-020 | Prefer an existing community convention with moderate to good adoption over a new one. When none exists, say so in the decision that introduces ours. | [0003](decisions/0003-align-with-existing-conventions.md) |
| C-021 | Requirement keywords follow BCP 14 (RFC 2119, RFC 8174): they carry their meaning only in uppercase. | Precise, widely understood normative language. |
| C-022 | Decision records follow MADR 4 and are numbered `NNNN-title-in-kebab-case.md`. | [0001](decisions/0001-record-decisions-with-madr.md) |
| C-023 | `decisions/` holds only current decisions. When a decision changes, its previous version moves unchanged (status `superseded`) to `decisions/archive/NNNN-title-YYYY-MM-DD.md`, and the current file links to it. Archived files are never edited. | `decisions/` shows what holds today; the reasoning history stays intact ([0015](decisions/0015-archive-previous-decisions.md)). |
| C-024 | Requirements and scenarios use the format in [0007](decisions/0007-requirement-format.md). | Readable by Spec Kit and OpenSpec users alike. |
| C-025 | Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/). | Consistent history; the project's namesake convention. |
| C-026 | `CHANGELOG.md` follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and releases follow [SemVer](https://semver.org/). | [0013](decisions/0013-versioning.md) |
| C-027 | `docs/context/` is updated in the same pull request as the change it describes. | Context that lags the code stops being trusted. |
| C-028 | `templates/` holds blank structure and guidance only, never this project's own content; `docs/context/` holds only this project's content. | [0011](decisions/0011-repository-layout.md) |
