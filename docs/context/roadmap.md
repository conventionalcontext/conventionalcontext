---
type: roadmap
status: current
---

# Roadmap

## Now

- [Inception change](../../openspec/changes/inception/): this project's
  `docs/context/` and the specs for its three capabilities
- First release of the schema: tag `v0.1.0` after the pull request is
  approved, so the install command in the README works
- Point conventionalcontext.org at the GitHub Pages website

## Next

- Test the schema with a fresh agent on a new project, in Claude Code,
  GitHub Copilot, and Google Antigravity
- Check with OpenSpec in CI: `openspec schema validate` and a TechDocs build
  of the templates
- List the schema in OpenSpec's community schemas
- Measure whether the constraints and decisions check changes agents'
  results, on tasks that depend on a recorded decision

## Later

- Spec Kit extension that brings the same `docs/context/` to Spec Kit
  projects
- Kiro steering file that points Kiro at `docs/context/`

## Out of scope

- Agent routing through `AGENTS.md`
  ([0002](decisions/0002-docs-context-for-people.md))
- Feature files in `docs/context/`
  ([0005](decisions/0005-behavior-stays-in-openspec.md))
- A separate CLI or a fork of OpenSpec
  ([0001](decisions/0001-extend-openspec-with-a-schema.md))
