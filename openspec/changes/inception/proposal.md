# Proposal

## Why

Conventional Context helps people settle and record a project's intent (requirements, constraints, architecture, decisions) before AI coding agents build it, and keeps that record current and readable for maintainers, reviewers, newcomers, and developer portals. It does this as an OpenSpec schema plus the `docs/context/` convention, adding what OpenSpec does not keep, without repeating what it does.

This is the project's inception change. The first version of the schema and templates already exists on this branch, so this change records the project's own intent with its own schema, and specifies the behavior that is already built.

## What Changes

- `docs/context/` for this project: purpose, users, scope, quality requirements, constraints, architecture, decisions, glossary, roadmap.
- Behavior specs for the three capabilities of the schema and convention.

## Capabilities

### New Capabilities

- `inception`: on a project without `docs/context/`, the schema creates it from the templates with the user, and records the choices already made as decisions.
- `change-review`: on every later change, the schema checks the change against the recorded constraints and decisions, resolves conflicts with the user, and plans `docs/context/` updates as tasks.
- `docs-context-format`: the files in `docs/context/`, their frontmatter, how they link to OpenSpec instead of copying it, and how changed decisions are archived.

### Modified Capabilities

None.

## Impact

- New `docs/context/` and `openspec/specs/` in this repository.
- No change to the schema or templates themselves.
