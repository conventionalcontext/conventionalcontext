---
type: decision
status: accepted
date: 2026-11-22
decision-makers: andreouellet, Hamed Minaee
---

# Human agency as the core principle, enforced by a GitOps workflow

## Context and Problem Statement

AI coding agents can write most of a project's code. The risk for people is
not only bad code, but losing track of what is being built and why, and
losing the say over it. Conventional Context's schema can instruct agents to
check rules and ask about conflicts, but instructions are not enforcement:
an agent can ignore them. What should the project promise, and what makes
that promise hold?

## Considered Options

* Human agency (people stay aware and in charge), enforced by a GitOps workflow
* Promise better agent results
* Rely on the schema's instructions alone

## Decision Outcome

Chosen option: "Human agency, enforced by a GitOps workflow", because it is
a promise the project can keep: the schema keeps people aware and gives them
the decisions, and git keeps them in charge.

* **Aware:** purpose, rules, and decisions are written down in
  `docs/context/` for people to read and review.
* **In charge:** people write the intent and review it before code exists;
  agents stop and ask when a change conflicts with a rule or decision; agents
  never change rules or decisions without a person's approval (C-009).
* **Enforced:** everything lives in git, every change is a pull request, and
  a protected `main` branch merges nothing a person has not approved. The
  website lists the branch settings to turn on.
* The project does not claim to improve agents' results
  ([0002](0002-docs-context-for-people.md)).
* Slug: "Keep people aware and in charge of what AI agents build."

### Consequences

* Good, because the claim is backed by a mechanism people already use and
  trust: pull requests and branch protection.
* Good, because it works for any agent, and the schema does not need to
  enforce anything.
* Bad, because it depends on people reviewing for real; rubber-stamped
  pull requests give no agency.
