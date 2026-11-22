---
type: decision
status: proposed
date: 2026-11-21
decision-makers: andreouellet
---

# Agent Skills for context actions, in `.agents/skills/`

## Context and Problem Statement

Agents working in a repository that follows Conventional Context repeat a few
actions: record a new decision, change an existing one (with the archive
procedure of [0015](0015-archive-previous-decisions.md)), add a feature, and
keep `docs/context/` in step with a code change. Done by hand, each needs the
right template, the next number, an index row, and, for a changed decision,
the archive steps, which differ from usual ADR practice and which an agent
will not guess.

Adopters use different agents: Claude Code, GitHub Copilot, Google
Antigravity, and others. Each has its own command or prompt-file format, so
writing one command per agent means several copies that drift apart. How
should this project give agents guidance for these actions, defined once and
usable by any agent?

## Decision Drivers

* Write each procedure once, for every agent (NFR-005).
* The rules live in the specification; guidance implements them and adds no
  rules of its own.
* Keep what every agent loads on every task small.
* Optional for adopters: nothing in the specification may depend on it.

## Considered Options

* Standing rule in `AGENTS.md`, plus Agent Skills for multi-step actions
* One command file per agent (`.claude/commands/`, `.github/prompts/`, ...)
* Everything in `AGENTS.md`
* No agent guidance; the specification and templates are enough

## Decision Outcome

Chosen option: "Standing rule in `AGENTS.md`, plus Agent Skills", because
Agent Skills is an open format that Claude Code, GitHub Copilot, and Google
Antigravity all read, and agents load only a skill's name and description
until the skill is needed.

* **Specification:** defines what a valid decision record, feature file, and
  index are, and the archive procedure. Skills follow it.
* **`AGENTS.md`:** a short standing rule that every agent reads: when a
  change alters a requirement, constraint, or decision, update
  `docs/context/` in the same pull request. Updating context is not a
  command someone must remember to run.
* **Skills** ([Agent Skills](https://agentskills.io) format: a folder with a
  `SKILL.md`), one per multi-step action:
  * `new-decision`: a new decision record, or a change to an existing one
    with the archive procedure, and the index row.
  * `new-feature`: a feature file and index row; if an SDD tool tracks
    features, a roadmap link instead
    ([0017](0017-feature-files-and-sdd-tools.md)).
  * `check-context`: before merge, read the change and report which context
    files should change (new terms, constraints, missing decisions).
* **Location in this repository:** `skills/`, one directory per skill. Skills
  refer to the templates in `templates/` rather than copying them.
* **Location in an adopting repository:** `.agents/skills/`, read by GitHub
  Copilot and Google Antigravity. Claude Code reads only `.claude/skills/`
  (support for `.agents/skills/` is requested in
  [anthropics/claude-code#31005](https://github.com/anthropics/claude-code/issues/31005),
  open as of 2026-11-21; the earlier
  [#16345](https://github.com/anthropics/claude-code/issues/16345) was closed
  as its duplicate). Until it is supported, `.claude/skills/` is a symlink to
  `.agents/skills/`, or a copy where symlinks are not available (Windows).
* The specification MAY mention skills, and MUST NOT require them.

### Consequences

* Good, because each procedure is written once and works across agents.
* Good, because skills cost about a hundred tokens each until used, so
  `AGENTS.md` stays short.
* Good, because agents can invoke a skill by name (for example
  `/new-decision`), so no per-agent command files are needed.
* Bad, because Claude Code needs a symlink or copy until it reads
  `.agents/skills/`; a symlinked skills directory may also load a skill twice
  in some versions
  ([anthropics/claude-code#109687](https://github.com/anthropics/claude-code/issues/109687)).
* Bad, because the skills must be kept in step with the specification and
  templates.
* Neutral: when accepted, [0010](0010-license-by-directory.md) gains
  `skills/` (CC0-1.0, like `templates/`, because adopters copy it), and
  [0011](0011-repository-layout.md) gains the directory.

## More Information

* Agent Skills specification: <https://agentskills.io>
* GitHub Copilot: <https://docs.github.com/en/copilot/concepts/agents/about-agent-skills>
  (`.github/skills/`, `.claude/skills/`, `.agents/skills/`)
* Google Antigravity: <https://antigravity.google/docs/skills>
  (`.agents/skills/`)
* Claude Code: <https://code.claude.com/docs/en/skills> (`.claude/skills/`)
* Feature: [agent skills](../features/agent-skills.md)
