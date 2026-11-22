# Design

## Context

The schema, templates, TechDocs example, and website already exist on this
branch. This change records the project's intent and specifies the behavior
already built. See proposal.md for why.

## Goals / Non-Goals

**Goals:**
- Specify the three capabilities as they are built, so later changes have a
  baseline to modify.
- Show that the schema can describe its own project.

**Non-Goals:**
- Changing the schema or templates.
- Testing with a fresh agent; that is on the roadmap.

## Decisions

Every lasting decision made for this design is already recorded in
`docs/context/decisions/` by this change's context artifact, so none is
marked "(record)" here:

- Extend OpenSpec with a schema: [0001](../../../docs/context/decisions/0001-extend-openspec-with-a-schema.md)
- `docs/context/` for people; agents read only constraints and decisions
  while planning: [0002](../../../docs/context/decisions/0002-docs-context-for-people.md)
- Schema based on `spec-driven`, upstream text unchanged:
  [0003](../../../docs/context/decisions/0003-own-schema-based-on-spec-driven.md)
- Context updates are planned in the context artifact and done as tasks,
  not at archive, because OpenSpec only allows archive guidance in project
  configuration, not in a schema. Doing them as tasks also puts them in the
  same pull request as the code. This follows from the schema format, so it
  is specified in `change-review` rather than recorded as a decision.
- Existing codebases: the agent drafts from the code, but inferred decisions
  stay `proposed` and only `accepted` decisions bind later changes, and no
  constraint is written from the code alone. Agent-generated context made
  agents worse in Gloaguen et al. (2026), so a guess must never become a
  rule without a person (C-009,
  [0010](../../../docs/context/decisions/0010-human-agency-enforced-by-gitops.md)).
  Specified in `inception` and `change-review`.
- Schema location and distribution:
  [0009](../../../docs/context/decisions/0009-publish-schema-in-openspec-schemas.md)

## Risks / Trade-offs

- [OpenSpec marks schema commands as experimental; the format may change]
  → Upstream text is kept unchanged so a refresh is mechanical (C-003);
  `openspec schema validate` runs before each pull request.
- [The author of the instructions also ran this inception, so the test is
  biased] → A test with a fresh agent in three tools is on the roadmap.
