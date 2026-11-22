---
type: architecture
status: draft
---

# Architecture

## What it works with

| Who or what | How |
|---|---|
| OpenSpec | Loads the schema from a project's `openspec/schemas/` and gives its instructions to the agent |
| AI coding agents (Claude Code, GitHub Copilot, Google Antigravity, ...) | Follow the schema's instructions |
| Developer portals (Backstage, Port) | Publish a project's `docs/`, including `docs/context/` |
| GitHub Pages | Hosts conventionalcontext.org |

## Main choices

- A schema for OpenSpec, built on OpenSpec's own steps
  ([0001](decisions/0001-extend-openspec-with-a-schema.md)).
- Written for people, with GitOps keeping them in charge
  ([0002](decisions/0002-human-agency-enforced-by-gitops.md)).
- What the system does stays in OpenSpec
  ([0003](decisions/0003-behavior-stays-in-openspec.md)), and
  `docs/context/` is plain Markdown
  ([0005](decisions/0005-publish-as-plain-markdown.md)).

## Parts

| Part | What it is | Where |
|---|---|---|
| Schema | The steps of a change: proposal → context → specs → design → tasks | `openspec/schemas/conventional-context/schema.yaml` |
| Step templates | The outline of each step's document | `openspec/schemas/conventional-context/templates/` |
| `docs/context/` templates | Copied into a project at its first change | `openspec/schemas/conventional-context/docs-context/` |
| TechDocs example | `mkdocs.yml` and `catalog-info.yaml` for Backstage | `examples/techdocs/` |
| Website | conventionalcontext.org ([0007](decisions/0007-website-with-zensical.md)) | `docs/website/` |
| This project's intent | Written with its own schema | `docs/context/` |
| This project's specs and changes | The schema lives in the same folder, so this repository uses what it publishes | `openspec/specs/`, `openspec/changes/` |

Projects copy `openspec/schemas/conventional-context/` from a release into
the same path and commit it
([0006](decisions/0006-publish-schema-in-openspec-schemas.md)).

## Checks before a pull request

- `openspec schema validate conventional-context`
- `openspec validate <change> --strict`
- A TechDocs build of `docs/context/` (NFR-003)
- `zensical build --strict` for the website
