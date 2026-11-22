---
type: glossary
status: draft
---

# Glossary

## AI agents

| Term | Meaning |
|---|---|
| AI coding agent | A tool, built on a large language model, that reads a repository, plans, writes and runs code, and opens pull requests. Examples: Claude Code, GitHub Copilot, Google Antigravity. |
| Context (of an agent) | Everything an agent has in front of it while it works: its instructions, your prompt, the files it read, and the output of the commands it ran. An agent knows nothing about a project beyond its context, and starts each session with an empty one. Everything in it costs time and money. |
| Context file | A file an agent loads at the start of every session, such as `AGENTS.md` or `CLAUDE.md`. |
| Agentic development | Building software with AI agents doing much of the work at every stage (Intent → Spec → Plan → Build → Test → Deploy), while people decide what to build and review the results. |
| Intent | Why a project exists, who it is for, the rules it must follow, and the decisions behind it. Recorded in `docs/context/`. |
| Spec-driven development | Writing down what a change should do before agents plan, build, and test it. OpenSpec, Spec Kit, and Kiro are tools for it. |

## Human agency

| Term | Meaning |
|---|---|
| Human agency | People staying **aware** of what is being built and why, and **in charge** of what gets built ([0002](decisions/0002-human-agency-enforced-by-gitops.md)). |
| Human in the loop | A person must review and approve at set points before an agent's work goes further. |
| Automation bias | Trusting an automated system's output without checking it; in practice, approving agents' pull requests without reading them. The main risk to human agency. |
| GitOps workflow | Working through git: everything lives in a repository, every change is a pull request, and nothing merges until a person approves it. Git's history records who changed what, and why. |
| Pull request | A proposed change that people review and approve before it is merged. Called a merge request on GitLab. |
| Protected branch | A branch, usually `main`, that accepts changes only through approved pull requests. |
| Code owners | The people or teams who must approve changes to certain files, listed in a `CODEOWNERS` file. |

## Conventional Context

| Term | Meaning |
|---|---|
| `docs/context/` | The folder with a project's intent: requirements, constraints, architecture, decisions, glossary, and roadmap. Written for people. |
| First change (inception) | The first change in a project that uses the schema. It creates `docs/context/` with you, before agents build or change anything. |
| Context review | The `context.md` document of a change: which rules and decisions apply, any conflicts, and what the change adds to `docs/context/`. |
| Constraint | A rule the project must follow that cannot be seen in the code, with the reason for it. Listed as `C-NNN` in `constraints.md`. |
| Quality requirement | How well the project must work (speed, availability, security, cost), measurable, listed as `NFR-NNN`. |
| Decision record | One file in `docs/context/decisions/`: the problem, the options, the choice, and its consequences, in [MADR](https://adr.github.io/madr/) format. |
| Proposed decision | A decision not yet approved by people, for example one an agent inferred from existing code. Agents never treat it as a rule. |
| Accepted decision | A decision approved by people. Only accepted decisions bind agents. |
| Decision archive | `docs/context/decisions/archive/`: earlier versions of decisions that have since changed. |
| Developer portal | An internal website, such as Backstage or Port, that lists a company's projects and shows their documentation. |

## OpenSpec

Definitions quoted from the
[OpenSpec glossary](https://github.com/Fission-AI/OpenSpec/blob/main/docs/glossary.md).

| Term | Meaning |
|---|---|
| Spec | "A document describing how part of your system behaves." Specs live in `openspec/specs/`. |
| Capability | What one spec covers: one lasting behavior of the system, such as `user-auth`. |
| Change | "One unit of work, packaged as a folder under `openspec/changes/<name>/`." |
| Schema | "The definition of which artifacts a workflow has and how they depend on one another." Conventional Context is a schema. |
| Artifact | "A document inside a change": here, the proposal, context review, specs, design, and tasks. |
| Delta spec | "A spec inside a change that describes only what's changing." |
| Archive | "The act of finishing a change." Its specs move into `openspec/specs/`. |
