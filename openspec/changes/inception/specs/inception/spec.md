# Spec Delta

## Purpose

Creates a project's `docs/context/` with the user, so people can review the project's intent before agents build: before any code is written in a new project, or before agents change an existing one.

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
In inception mode, the agent MUST ask the user, in small groups of questions, for users and stakeholders, scope, quality requirements, constraints with reasons, architecture choices, and terms. It MUST NOT present a guess as the user's answer.

#### Scenario: User has no answer yet
- **WHEN** the user has no answer for a section
- **THEN** the agent leaves that section empty with its guidance comment

#### Scenario: Answer not given
- **WHEN** the agent has not asked about a constraint
- **THEN** no such constraint appears in `constraints.md`

### Requirement: Existing choices recorded as decisions
In inception mode, the agent SHALL record each significant choice the user has made or confirmed as an accepted decision record with the user's reason, numbered from 0001, listed with its status in the decisions table of `docs/context/README.md`, and SHALL then remove the decision template from `docs/context/`.

#### Scenario: Language already chosen
- **WHEN** the user says the project is written in Go
- **THEN** a decision record for the language exists with status `accepted` and a row in the decisions table

### Requirement: Drafting from an existing codebase
When the repository already has application code, the agent SHALL draft from the code and existing docs, before asking: architecture, one `proposed` decision record per technology choice already made (reason marked as to confirm), glossary terms, and the purpose if the docs state it. Drafted files keep `status: draft` until the user confirms them.

#### Scenario: Inferred technology choice
- **GIVEN** an existing repository built with PostgreSQL
- **WHEN** the inception context artifact is created
- **THEN** a decision record for PostgreSQL exists with status `proposed` and its reason marked as to confirm, until the user confirms it

#### Scenario: User confirms a drafted decision
- **WHEN** the user confirms the PostgreSQL decision and gives the reason
- **THEN** its status becomes `accepted` and it records the user's reason

#### Scenario: User rejects a drafted decision
- **WHEN** the user says a drafted decision is wrong
- **THEN** the record is deleted

### Requirement: No constraints from code alone
The agent MUST NOT write a constraint into `constraints.md` because the code seems to follow it; it SHALL ask the user about it instead, and record it only if the user confirms it and gives a reason.

#### Scenario: Pattern seen in the code
- **GIVEN** every service in an existing repository runs in one cloud region
- **WHEN** the agent drafts `docs/context/`
- **THEN** it asks the user whether one region is a rule, and `constraints.md` gets a row only if the user confirms it with a reason

### Requirement: Existing codebase inception changes no behavior
On an existing codebase, the inception change SHALL list no capabilities and SHALL set `skip_specs: true` in its `.openspec.yaml`, unless the user asks to specify existing capabilities in it.

#### Scenario: Inception on an existing repository
- **WHEN** an agent proposes the inception change for an existing repository
- **THEN** the change's `.openspec.yaml` has `skip_specs: true` and `openspec validate` accepts the change

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
