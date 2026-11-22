---
type: constraints
status: current
---

# Constraints

| ID | Constraint | Why |
|---|---|---|
| C-001 | Extend OpenSpec; do not build a separate CLI or fork OpenSpec. | One maintainer cannot keep a fork current, and OpenSpec users get Conventional Context as an add-on ([0001](decisions/0001-extend-openspec-with-a-schema.md)). |
| C-002 | Never duplicate what OpenSpec keeps. Behavior lives only in `openspec/specs/`; `docs/context/` links to it. | Two copies drift apart ([0005](decisions/0005-behavior-stays-in-openspec.md)). |
| C-003 | Keep OpenSpec's upstream schema text unchanged, and mark every addition with "Conventional Context:". | Upstream changes stay easy to merge ([0003](decisions/0003-own-schema-based-on-spec-driven.md)). |
| C-004 | Do not route agents to `docs/context/`. The schema has agents read only constraints and decisions, and only when they plan a change. | Studies found that general context files do not help agents and add cost ([0002](decisions/0002-docs-context-for-people.md)). |
| C-005 | Templates hold structure and guidance only, never example content. | Leftover examples get published and enforced as if they were real. |
| C-006 | `docs/context/` is plain Markdown with minimal frontmatter; no portal-specific file is required. | It must work in any documentation site or developer portal ([0006](decisions/0006-publish-as-plain-markdown.md)). |
| C-007 | Python tooling runs with `uv`, never `pip`. | The maintainers' setup; `pip` is not installed. |
| C-008 | Changes reach `main` through a pull request approved by a maintainer other than its author. | Every change gets a second pair of eyes. |
