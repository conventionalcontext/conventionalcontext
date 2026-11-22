# Spec Delta

## Purpose

Checks every change after inception against the project's recorded
constraints and decisions, and keeps `docs/context/` current with what the
change adds that outlasts it.

## ADDED Requirements

### Requirement: Limited reading
In a change that is not an inception change, the agent SHALL read from `docs/context/` only `constraints.md`, the decision records outside `decisions/archive/`, and the glossary terms the change uses, unless the proposal touches another file.

#### Scenario: Ordinary change
- **GIVEN** a proposal that touches no architecture or scope
- **WHEN** the agent creates the context artifact
- **THEN** it reads `constraints.md` and the current decision records, and not `architecture.md`, `requirements.md`, or `decisions/archive/`

### Requirement: Applicable constraints and decisions listed
The context artifact SHALL list each constraint and `accepted` decision that applies to the change, by ID or number, with one line on how it applies.

#### Scenario: Constraint applies
- **GIVEN** constraint C-003 says cloud access uses short-lived credentials
- **WHEN** a change adds a deployment step
- **THEN** `context.md` lists C-003 and how the step must respect it

### Requirement: Only accepted decisions bind
Decisions with status `proposed` MUST NOT be treated as rules. The context artifact SHALL list proposed decisions that touch the change separately, as unconfirmed, and ask the user whether to follow them.

#### Scenario: Unconfirmed inferred decision
- **GIVEN** a `proposed` decision, drafted from existing code, that says the project uses REST
- **WHEN** a change adds a GraphQL endpoint
- **THEN** `context.md` lists the decision as unconfirmed and asks the user, and does not report it as a conflict

### Requirement: Conflicts resolved before specs
When a proposal contradicts a constraint or an accepted decision, the agent MUST list the conflict in `context.md` and resolve it with the user before writing specs or design.

#### Scenario: Proposal contradicts a decision
- **GIVEN** decision 0004 chooses cursor pagination
- **WHEN** a proposal adds an endpoint with offset pagination
- **THEN** the agent lists the conflict and asks the user to change the proposal or the decision before continuing

### Requirement: Context updates planned, not done, during planning
The context artifact SHALL list under Context updates only what outlasts the change, and the agent MUST NOT edit `docs/context/` while creating the context artifact.

#### Scenario: Nothing outlasts the change
- **WHEN** a change adds no decision, constraint, term, architecture change, or roadmap entry
- **THEN** Context updates says "None"

### Requirement: Lasting design decisions marked
In the design artifact, the agent SHALL mark with "(record)" each decision that will guide future changes; decisions that only matter for the change stay unmarked.

#### Scenario: Lasting decision
- **WHEN** the design chooses a message queue that other services will use
- **THEN** that decision is marked "(record)"

### Requirement: Context updates become tasks
The tasks artifact SHALL end with a "Context updates" group, with one task per Context updates item and per "(record)" decision, each naming the `docs/context/` file it changes. The group SHALL be omitted when there is nothing to update.

#### Scenario: New decision to record
- **GIVEN** a design decision marked "(record)"
- **WHEN** the agent writes the tasks
- **THEN** the Context updates group has a task to add the decision record with the next number and a row in the decisions table

#### Scenario: Changed decision
- **GIVEN** a change that changes decision 0004
- **WHEN** the task is done
- **THEN** the previous version is in `decisions/archive/` with status `superseded`, `0004` is updated in place, and it lists the archived version under Previous decisions
