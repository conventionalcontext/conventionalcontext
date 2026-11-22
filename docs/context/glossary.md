---
type: glossary
status: current
---

# Glossary

Terms marked *(OpenSpec)* use OpenSpec's definitions, quoted from the
[OpenSpec glossary](https://github.com/Fission-AI/OpenSpec/blob/main/docs/glossary.md).

## Agents and context

| Term | Meaning |
|---|---|
| AI coding agent | A tool built on a large language model that reads a repository, plans, writes and runs code, and opens pull requests. Examples: Claude Code, GitHub Copilot, Google Antigravity, Codex. |
| Context (of an agent) | Everything an agent has in front of it while it works: its instructions, your prompt, the files it has read, and the output of the commands it ran. An agent knows nothing about a project beyond its context, and starts each session with an empty one. |
| Context window | The limit on how much text an agent can hold in its context at once. Everything read into it costs time and money (tokens), so what goes in should earn its place. |
| Context file | A file an agent loads into its context automatically at the start of every session, such as `AGENTS.md` or `CLAUDE.md`. Studies found that general project overviews in context files do not improve agents' results and add cost; specific rules the agent cannot infer from the code are what help. |
| Agentic development | Software development in which AI agents do much of the work at every stage (Intent → Spec → Plan → Build → Test → Deploy), while people decide what to build and review the results. Also called the agentic SDLC (software development lifecycle). |
| Intent | Why a project exists, for whom, what it must and must not do, the rules it works within, and the decisions behind it. The first stage of agentic development. In this project, recorded in `docs/context/`. |
| Spec-driven development | Writing down what a feature or change should do before agents plan, build, and test it. OpenSpec, Spec Kit, and Kiro are spec-driven development tools. |

## Conventional Context

| Term | Meaning |
|---|---|
| `docs/context/` | The folder holding a project's recorded intent: requirements (purpose, users, scope, quality requirements), constraints, architecture, decisions, glossary, and roadmap. Written for people. |
| Inception change | The first OpenSpec change in a project that uses the `conventional-context` schema. It creates `docs/context/` with the user before any code is written. |
| Context review | The `context.md` artifact of a change: which constraints and decisions apply, any conflicts, and the context updates the change makes. |
| Context updates | What a change adds to or changes in `docs/context/` because it outlasts the change. Planned in `context.md`, done as tasks, reviewed in the same pull request. |
| Constraint | A rule the project must work within that cannot be inferred from the code, with the reason for it. Listed with a `C-NNN` ID in `constraints.md`. |
| Quality requirement | How well the project must work (performance, availability, security, cost), measurable, with an `NFR-NNN` ID. Behavior is not a quality requirement; it belongs in a spec. |
| Decision record | One file in `docs/context/decisions/` describing a significant decision: the problem, the options, the choice, and its consequences, in [MADR 4](https://adr.github.io/madr/) format. |
| Decision archive | `docs/context/decisions/archive/`: previous versions of decisions that have since changed, with status `superseded`. Not to be confused with OpenSpec's *archive*. |
| Developer portal (IDP) | An internal developer portal, such as Backstage or Port, that lists a company's projects and publishes their documentation. |
| TechDocs | Backstage's documentation feature. It builds a repository's `docs/` with MkDocs and shows it in the portal. |

## OpenSpec

| Term | Meaning |
|---|---|
| Spec *(OpenSpec)* | "A document describing how part of your system behaves. Specs live in `openspec/specs/`, are organized by domain, and are made of requirements and scenarios." |
| Capability | What a spec covers: one durable system behavior, such as `user-auth`, with its own `openspec/specs/<capability>/spec.md`. Named in a change's proposal. |
| Change *(OpenSpec)* | "One unit of work, packaged as a folder under `openspec/changes/<name>/`. A change holds everything about that work: its proposal, design, tasks, and the spec edits it introduces." |
| Artifact *(OpenSpec)* | "A document inside a change." The `conventional-context` schema's artifacts are the proposal, context review, delta specs, design, and tasks. |
| Delta spec *(OpenSpec)* | "A spec inside a change that describes only what's changing, using `ADDED`, `MODIFIED`, and `REMOVED` sections." |
| Requirement *(OpenSpec)* | "A single behavior the system must have, usually written with an RFC 2119 keyword." |
| Scenario *(OpenSpec)* | "A concrete, testable example of a requirement in action, typically in Given/When/Then form." |
| Archive *(OpenSpec)* | "The act of finishing a change. Its delta specs merge into the main specs, and the change folder moves to `openspec/changes/archive/YYYY-MM-DD-<name>/`." |
| Schema *(OpenSpec)* | "The definition of which artifacts a workflow has and how they depend on one another." |
