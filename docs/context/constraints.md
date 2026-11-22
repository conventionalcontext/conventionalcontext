---
type: constraints
status: draft
---

# Constraints

| ID | Rule | Why |
|---|---|---|
| C-001 | Extend OpenSpec; do not build a separate tool or fork OpenSpec. | People get Conventional Context inside a tool they may already use, and there is nothing extra to maintain ([0001](decisions/0001-extend-openspec-with-a-schema.md)). |
| C-002 | Never repeat what OpenSpec records. What the system does lives only in `openspec/specs/`. | Two copies drift apart ([0003](decisions/0003-behavior-stays-in-openspec.md)). |
| C-003 | Keep the text taken from OpenSpec's schema unchanged, and mark every addition "Conventional Context:". | New OpenSpec releases stay easy to take in ([0001](decisions/0001-extend-openspec-with-a-schema.md)). |
| C-004 | Do not tell agents to read `docs/context/` for every task. | General context files do not improve agents' results and add cost ([0002](decisions/0002-human-agency-enforced-by-gitops.md)). |
| C-005 | Templates hold structure and guidance only, never example content. | Leftover examples get published, and followed, as if they were real. |
| C-006 | `docs/context/` is plain Markdown; no portal-specific file is required. | It must work in any documentation site or portal ([0005](decisions/0005-publish-as-plain-markdown.md)). |
| C-007 | Python tools run with `uv`, never `pip`. | The maintainers' setup. |
| C-008 | Changes reach `main` only through a pull request approved by a maintainer other than its author. | Every change gets a second pair of eyes. |
| C-009 | Agents never change rules or decisions without a person's approval. | People stay in charge of the rules agents follow ([0002](decisions/0002-human-agency-enforced-by-gitops.md)). |
