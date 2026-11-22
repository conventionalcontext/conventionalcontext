# Design

## Context

The schema, templates, TechDocs example, and website already exist on this branch. This change records the project's intent and specifies the behavior already built. See proposal.md for why.

## Goals / Non-Goals

**Goals:**
- Specify the three capabilities as they are built, so later changes have a baseline to modify.
- Show that the schema can describe its own project.

**Non-Goals:**
- Changing the schema or templates.
- Testing with a fresh agent; that is on the roadmap.

## Decisions

Every lasting decision made for this design is recorded in `docs/context/decisions/` by this change's context step, so none is marked "(record)" here:

- Extend OpenSpec with a schema built on `spec-driven`, OpenSpec's text unchanged: [0001](../../../docs/context/decisions/0001-extend-openspec-with-a-schema.md)
- Human agency, enforced by GitOps; agents read only rules and accepted decisions while planning: [0002](../../../docs/context/decisions/0002-human-agency-enforced-by-gitops.md)
- Where the schema lives, and how projects get it: [0006](../../../docs/context/decisions/0006-publish-schema-in-openspec-schemas.md)

Two choices follow from OpenSpec's format and are specified rather than recorded as decisions:

- Updates to `docs/context/` are planned in the context step and done as tasks, because a schema cannot add steps to OpenSpec's archive. As tasks, they also land in the same pull request as the code (`change-review`).
- On an existing project, the agent drafts from the code, but what it infers stays `proposed`, only `accepted` decisions bind later changes, and no rule is written from the code alone, so a guess never becomes a rule without a person (`inception`, `change-review`).

## Risks / Trade-offs

- [OpenSpec marks schema commands as experimental; the format may change] → Upstream text is kept unchanged so a refresh is mechanical (C-003); `openspec schema validate` runs before each pull request.
- [The author of the instructions also ran this inception, so the test is biased] → A test with a fresh agent in three tools is on the roadmap.
