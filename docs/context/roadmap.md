---
type: roadmap
status: draft
---

# Roadmap

## Now

- [First change](../../openspec/changes/inception/): this project's `docs/context/` and the specs for the schema, including existing projects
- After approval: set all decisions to `accepted`, finish the change, and release `v0.1.0`
- Point conventionalcontext.org at the website

## Next

- Try the schema with a fresh agent, on a new and an existing project, in Claude Code, GitHub Copilot, and Google Antigravity
- Run the checks in CI
- List the schema among OpenSpec's community schemas
- Attach the schema folder to each release as `conventional-context.tar.gz`, so the install command can download the latest release with no version number
- Install with OpenSpec's own command once it has one ([OpenSpec #650](https://github.com/Fission-AI/OpenSpec/issues/650)); until then, the copy command stays
- Measure whether checking rules and decisions changes what agents build

## Later

- A Spec Kit version
- A Kiro version

## Out of scope

- Telling agents to read all of `docs/context/` ([0002](decisions/0002-human-agency-enforced-by-gitops.md))
- Feature files in `docs/context/` ([0003](decisions/0003-behavior-stays-in-openspec.md))
- A separate tool, or a fork of OpenSpec ([0001](decisions/0001-extend-openspec-with-a-schema.md))
