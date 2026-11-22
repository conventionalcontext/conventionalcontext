---
type: glossary
status: current
---

# Glossary

Terms with a specific meaning in this project, written for readers new to
agent-assisted development. Two-column form of
[arc42 section 12](https://docs.arc42.org/section-12/). Alphabetical.

| Term | Definition |
|---|---|
| ADR | Architecture decision record. See *Decision record*. |
| Adapter | A document describing how Conventional Context sits alongside another tool or convention (AGENTS.md, Spec Kit, OpenSpec), mapping their files to `docs/context/` without duplicating them. Lives in `adapters/`. |
| Adopting repository | Any repository that follows the Conventional Context specification. |
| Agent | An AI coding agent: a tool built on a large language model that reads a repository, plans changes, edits code, and runs commands, for example Claude Code, GitHub Copilot, Cursor, or Codex. It knows only what is in its context. |
| Agent Skill | An open format ([agentskills.io](https://agentskills.io)) for packaging instructions an agent loads when needed: a folder with a `SKILL.md` file and optional supporting files. Read by Claude Code, GitHub Copilot, Google Antigravity, and others; a skill can usually also be invoked by name, like a command. See [decision 0018](decisions/0018-agent-skills-for-context-actions.md). |
| Agentic SDLC | A software development lifecycle (SDLC) in which agents do much of the work. Its stages are **Intent → Spec → Plan → Build → Test → Deploy**. Conventional Context covers the Intent stage. |
| AGENTS.md | An open format ([agents.md](https://agents.md/)): a Markdown file at the repository root that coding agents read for instructions. Conventional Context uses it to route agents to `docs/context/`. |
| AI-DLC | AWS's AI-Driven Development Lifecycle, a method for agent-assisted development. A future adapter is planned. |
| arc42 | A widely used template for architecture documentation ([arc42.org](https://arc42.org/)). This project aligns with selected sections only; see [0008](decisions/0008-partial-arc42-alignment.md). |
| Archive (decisions) | `docs/context/decisions/archive/`: previous versions of decisions that have changed, kept unchanged with their date in the file name. See [0015](decisions/0015-archive-previous-decisions.md). |
| BCP 14 | The IETF definition of requirement keywords: RFC 2119 as clarified by RFC 8174. In uppercase, MUST means required, SHOULD means expected unless there is a good reason not to, and MAY means optional. |
| Context (LLM) | Everything passed to a large language model when it runs: instructions, the files and code it has read, tool definitions, and the conversation so far. The model's training does not change while it works, so its context is its working memory: what it knows about the project, the code in front of it, and what it just did. |
| Context (project) | Short for project context: the project's intent, as kept in `docs/context/`. Agents load it into their LLM context, so it shapes everything they do. |
| Context file | A Markdown file with YAML frontmatter in `docs/context/`, including decision records and feature files. |
| Context window | The maximum amount of context an LLM can take in at once. Context files are kept short so an agent can read the ones it needs and still have room for the code (NFR-002). |
| Conventional Commits | A specification for commit messages (`feat:`, `fix:`, `docs:` ...) ([conventionalcommits.org](https://www.conventionalcommits.org/)). Used by this repository, and the model Conventional Context follows for project intent. |
| Conventions section | The `## Conventions` section of `AGENTS.md`, where a repository declares choices that affect how context is written, such as its diagram tool. |
| Decision record | A file in `docs/context/decisions/` recording one significant decision: its context, the options considered, the choice, and its consequences. Also called an ADR (architecture decision record). Uses MADR 4. |
| Dogfooding | A project using its own product. Here: this repository keeping its own intent in `docs/context/`, following its own specification. |
| EARS | Easy Approach to Requirements Syntax: requirements written as "WHEN ... THE SYSTEM SHALL ...". Used by Kiro. |
| Feature file | A file in `docs/context/features/` describing one feature: status, scenarios, related requirements, success criteria. Used only when no spec-driven development tool tracks features ([decision 0017](decisions/0017-feature-files-and-sdd-tools.md)). |
| FR | Functional requirement, `FR-NNN`: *what* the system must do. |
| Frontmatter | The YAML block between `---` lines at the top of a Markdown file. Carries a context file's `type` and `status`. |
| Gherkin | The plain-language format for Given/When/Then scenarios used by behaviour-driven development tools such as Cucumber ([cucumber.io/docs/gherkin](https://cucumber.io/docs/gherkin/)). |
| Given/When/Then | A way to write a scenario: a starting situation (Given), an event (When), and the expected outcome (Then). From behaviour-driven development; used by Gherkin, Spec Kit, and (as WHEN/THEN) OpenSpec. |
| HARC | Human Agentic Readable Context: the internal framework Conventional Context grew out of. See [0002](decisions/0002-grow-out-of-harc.md). |
| Index | `docs/context/README.md`: what the project is, the context files present, and the specification version followed. Read first. |
| Intent | Why a system is the way it is: what it is for, its requirements, constraints, decisions, and direction, as opposed to what the code does. The first stage of the agentic SDLC. |
| ISO/IEC 25010 | The international standard model of software quality characteristics (interaction capability, compatibility, flexibility, maintainability, security, ...). Groups non-functional requirements. |
| Keep a Changelog | A convention for writing `CHANGELOG.md` by hand, for people ([keepachangelog.com](https://keepachangelog.com/en/1.1.0/)). |
| Kiro | An AWS agentic development environment ([kiro.dev](https://kiro.dev/)) that writes `requirements.md`, `design.md`, and `tasks.md` per feature in `.kiro/`, using EARS. |
| Level 1 | The structure part of the specification: which files exist, where, what they contain, and their frontmatter. |
| Level 2 | The planned provenance part of the specification: how intent is traced to its sources and changes. Deferred to 0.2; see [0012](decisions/0012-defer-level-2-provenance.md). |
| LLM | Large language model: the kind of AI model that agents are built on. |
| MADR | Markdown Architectural Decision Records ([adr.github.io/madr](https://adr.github.io/madr/)), a widely used decision-record template. Version 4 is used here. |
| NFR | Non-functional requirement, `NFR-NNN`: *how well* the system must work (a quality such as usability, compatibility, or security), rather than what it does. |
| Now / Next / Later | A roadmap format that orders work by time horizon instead of dates. Used in `roadmap.md`. |
| OpenSpec | A spec-driven development tool ([github.com/Fission-AI/OpenSpec](https://github.com/Fission-AI/OpenSpec)) that keeps specs in `openspec/specs/` and changes in `openspec/changes/`, with `Requirement:` headings and WHEN/THEN scenarios. |
| Profile | A set of opinions for a kind of project (for example platform engineering) layered on the specification. Lives in `profiles/`. |
| Provenance | Where a piece of intent came from (a discussion, an incident, a decision) and how it changed over time. The subject of Level 2. |
| Scenario | A concrete example of a requirement or feature, written as Given/When/Then. |
| SemVer | Semantic Versioning, `MAJOR.MINOR.PATCH` ([semver.org](https://semver.org/)). Used for releases. |
| Spec Kit | GitHub's spec-driven development toolkit ([github.com/github/spec-kit](https://github.com/github/spec-kit)); writes one spec per feature in `specs/NNN-feature-name/`, keeps its templates and project constitution in `.specify/`, and uses `FR-001` requirements, `SC-001` success criteria, and Given/When/Then scenarios. |
| Spec-driven development (SDD) | Writing a specification for a feature first, then having agents plan, build, and test from it. Spec Kit, OpenSpec, and Kiro are SDD tools. They cover the Spec to Build stages one feature at a time; Conventional Context holds the project-wide intent those specs build on. |
| Specification | The normative Conventional Context text in `spec/vX.Y/SPEC.md`. |
| Success criterion | A measurable outcome that shows a feature is done, with an `SC-NNN` ID. |
| Template | A starter context file in `templates/docs/context/`, copied into adopting repositories. Not an empty file: it has the frontmatter, the headings, and placeholders with short guidance to replace with the project's own content. |
| Website | conventionalcontext.org, built from `docs/website/`. See [0016](decisions/0016-project-website.md). |
