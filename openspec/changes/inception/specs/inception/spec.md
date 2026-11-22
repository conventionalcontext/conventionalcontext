# Spec Delta

## Purpose

Creates a project's `docs/context/` with the user, before any code is
written, so the project's intent can be reviewed before agents build it.

## ADDED Requirements

### Requirement: Inception mode
The schema SHALL treat a change as an inception change when `docs/context/README.md` does not exist in the repository.

#### Scenario: New repository
- **GIVEN** a repository with no `docs/context/README.md`
- **WHEN** the agent creates the context artifact of a change
- **THEN** it follows the inception steps and writes `context.md` with mode `inception`

#### Scenario: Repository already has docs/context
- **GIVEN** a repository with `docs/context/README.md`
- **WHEN** the agent creates the context artifact of a change
- **THEN** it follows the change-review steps instead

### Requirement: Templates copied into docs/context
In inception mode, the agent SHALL copy the templates from `openspec/schemas/conventional-context/docs-context/` into `docs/context/`, keeping their file names and frontmatter.

#### Scenario: Templates in place
- **WHEN** an inception change creates its context artifact
- **THEN** `docs/context/` contains README.md, requirements.md, constraints.md, architecture.md, glossary.md, roadmap.md, and decisions/

### Requirement: Intent comes from the user
In inception mode, the agent MUST ask the user, in small groups of questions, for users and stakeholders, scope, quality requirements, constraints with reasons, architecture choices, and terms. It MUST NOT invent answers.

#### Scenario: User has no answer yet
- **WHEN** the user has no answer for a section
- **THEN** the agent leaves that section empty with its guidance comment

#### Scenario: Answer not given
- **WHEN** the agent has not asked about a constraint
- **THEN** no such constraint appears in `constraints.md`

### Requirement: Existing choices recorded as decisions
In inception mode, the agent SHALL record each significant choice the user has already made as an accepted decision record, numbered from 0001, listed in the decisions table of `docs/context/README.md`, and SHALL then remove the decision template from `docs/context/`.

#### Scenario: Language already chosen
- **WHEN** the user says the project is written in Go
- **THEN** a decision record for the language exists with status `accepted` and a row in the decisions table

### Requirement: Behavior is linked, not restated
In inception mode, `requirements.md` and `roadmap.md` SHALL link to `openspec/specs/` and to the change instead of describing behavior, and `roadmap.md` SHALL list the inception change under Now.

#### Scenario: Roadmap after inception
- **WHEN** the inception context artifact is complete
- **THEN** `roadmap.md` lists the inception change under Now, with a link to it

### Requirement: Review before building
At the end of the inception context artifact, the agent SHALL ask the user to review `docs/context/` before the specs, design, and tasks are written.

#### Scenario: Review gate
- **WHEN** the agent finishes the inception context artifact
- **THEN** it tells the user to review `docs/context/` and waits before continuing
