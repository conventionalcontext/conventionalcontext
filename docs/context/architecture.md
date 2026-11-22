---
type: architecture
status: current
---

# Architecture

## Context

| Who or what | Relationship |
|---|---|
| OpenSpec CLI | Loads the schema from an adopting repository's `openspec/schemas/` and gives its instructions to the agent |
| AI coding agents (Claude Code, GitHub Copilot, Google Antigravity, ...) | Follow the schema's instructions through OpenSpec's skills |
| Developer portals (Backstage TechDocs, Port) | Publish an adopting repository's `docs/`, including `docs/context/` |
| GitHub Pages | Hosts conventionalcontext.org |

## Solution strategy

- An OpenSpec schema, not a tool
  ([0001](decisions/0001-extend-openspec-with-a-schema.md)), built on
  OpenSpec's `spec-driven` schema with additions marked
  ([0003](decisions/0003-own-schema-based-on-spec-driven.md)).
- `docs/context/` is written for people; agents read only constraints and
  decisions while planning
  ([0002](decisions/0002-docs-context-for-people.md)).
- Behavior stays in OpenSpec
  ([0005](decisions/0005-behavior-stays-in-openspec.md)); `docs/context/`
  is published as plain Markdown
  ([0006](decisions/0006-publish-as-plain-markdown.md)).

## Building blocks

| Part | Purpose | Location |
|---|---|---|
| Schema | Workflow definition: proposal → context → specs → design → tasks | `openspec/schemas/conventional-context/schema.yaml` |
| Artifact templates | Structure for each artifact in a change | `openspec/schemas/conventional-context/templates/` |
| `docs/context/` templates | Copied into an adopting repository at inception | `openspec/schemas/conventional-context/docs-context/` |
| TechDocs example | `mkdocs.yml` and `catalog-info.yaml` for Backstage | `examples/techdocs/` |
| Website | conventionalcontext.org ([0007](decisions/0007-website-with-zensical.md)) | `docs/website/` |
| This project's intent | Written with its own schema | `docs/context/` |
| This project's OpenSpec | This project's own specs and changes. The schema above lives in the same folder, where OpenSpec finds it, so this repository uses the schema it publishes | `openspec/specs/`, `openspec/changes/` |
| Agent skills | Installed by each contributor with `openspec init`; not committed | `.agents/skills/`, `.claude/skills/` (ignored) |

## Crosscutting concepts

- **Distribution.** Adopters copy `openspec/schemas/conventional-context/`
  from a tagged release into the same path in their repository and commit
  it ([0009](decisions/0009-publish-schema-in-openspec-schemas.md)).
- **Upstream text.** Text copied from OpenSpec's `spec-driven` schema stays
  unchanged (C-003). To update, take the new upstream text and re-apply the
  marked additions.
- **Checks before a pull request:** `openspec schema validate
  conventional-context`; a TechDocs build of the templates (NFR-003); and
  `zensical build --strict` for the website.
