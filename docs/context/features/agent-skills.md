---
type: feature
status: draft
---

# Agent skills

## Summary

Optional [Agent Skills](https://agentskills.io) in `skills/` that guide any
agent through the multi-step context actions: `new-decision`,
`new-feature`, and `check-context`. Adopters copy them into
`.agents/skills/`. See
[decision 0018](../decisions/0018-agent-skills-for-context-actions.md)
(proposed).

## User scenarios

### Scenario: Agent changes a decision

- **GIVEN** a repository with `.agents/skills/new-decision/`
- **WHEN** a person asks an agent to change decision 0005
- **THEN** the agent moves the current record to `decisions/archive/` with
  status `superseded`, updates `0005` in place, and adds a line under
  `## Previous decisions`

### Scenario: Agent adds a feature in a Spec Kit repository

- **GIVEN** a repository that uses Spec Kit
- **WHEN** a person runs `/new-feature`
- **THEN** the agent links the Spec Kit spec from `roadmap.md` and does not
  create a file in `docs/context/features/`

### Scenario: Same skill in three agents

- **GIVEN** the skills in `.agents/skills/`, with `.claude/skills/` linked to
  it
- **WHEN** the same request is made in Claude Code, GitHub Copilot, and
  Google Antigravity
- **THEN** each agent uses the same skill

## Requirements

None yet; a requirement is added when decision 0018 is accepted. Relates to
NFR-005 ([requirements.md](../requirements.md)).

## Success criteria

- **SC-001:** `skills/new-decision/`, `skills/new-feature/`, and
  `skills/check-context/` each have a valid `SKILL.md`.
- **SC-002:** The skills add no rule that the specification does not state.
- **SC-003:** The three scenarios above pass in Claude Code, GitHub Copilot,
  and Google Antigravity.

## Open questions

- Should `init` install the skills (and the `.claude/skills/` link)?
- Should skills be published for the `skills` CLI
  (`npx skills add conventionalcontext/...`)?
