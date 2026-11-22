# Spec Delta

## Purpose

Defines what `docs/context/` contains and how it is written, so people and
developer portals find the same files in every project, with nothing
duplicated from OpenSpec.

## ADDED Requirements

### Requirement: File set
`docs/context/` SHALL contain README.md, requirements.md, constraints.md, architecture.md, glossary.md, roadmap.md, and a decisions/ folder.

#### Scenario: Index lists the files
- **WHEN** a reader opens `docs/context/README.md`
- **THEN** it links to every other file in `docs/context/` and to `openspec/specs/` and `openspec/changes/`

### Requirement: Frontmatter
Each file in `docs/context/` SHALL start with YAML frontmatter that has a `type` field; files other than the index and decision records SHALL also have a `status` field.

#### Scenario: Decision record frontmatter
- **WHEN** a decision record is created
- **THEN** its frontmatter has `type: decision`, `status`, `date`, and `decision-makers`

### Requirement: No behavior in docs/context
`docs/context/` MUST NOT describe what the system does; `requirements.md` SHALL hold purpose, users and stakeholders, scope, and quality requirements, and link to `openspec/specs/` for behavior.

#### Scenario: Functional requirement offered
- **WHEN** a functional requirement comes up during inception
- **THEN** it goes into a spec under `openspec/specs/`, not into `requirements.md`

### Requirement: Constraints have reasons
Each constraint in `constraints.md` SHALL have an ID of the form `C-NNN` and a reason.

#### Scenario: Constraint without a reason
- **WHEN** the user gives a constraint without a reason
- **THEN** the agent asks for the reason before recording it

### Requirement: Decision archive
When a decision changes, its current file SHALL move unchanged, with status `superseded`, to `decisions/archive/NNNN-title-YYYY-MM-DD.md`; the original file SHALL be updated in place and list the archived version under Previous decisions. `decisions/` SHALL hold no `superseded` records.

#### Scenario: Reader in a portal
- **WHEN** a reader browses `docs/context/decisions/`
- **THEN** every record there is current, and earlier versions are one link away

### Requirement: Templates without example content
The templates in `openspec/schemas/conventional-context/docs-context/` SHALL contain only structure and guidance in HTML comments, and no example content.

#### Scenario: Unfilled section published
- **WHEN** a portal publishes a section the user left unfilled
- **THEN** the section shows only its heading, with no example text
