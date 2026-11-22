---
type: decision
status: proposed
date: 2026-11-22
decision-makers: andreouellet, hamed-minaee
---

# Human agency, enforced by a GitOps workflow

## Context and Problem Statement

AI coding agents can write most of a project's code. The risk for people is
losing track of what is being built and why, and losing the say over it.
What should Conventional Context promise, who is `docs/context/` for, and
what makes the promise hold?

## Considered Options

* Human agency for people, enforced by a GitOps workflow
* Better results from agents, by having them read all of `docs/context/`
* Rely on the schema's instructions alone

## Decision Outcome

Chosen option: "Human agency for people, enforced by a GitOps workflow", because it is a promise the project can keep: the schema keeps people aware and gives them the decisions, and git keeps them in charge.

* **Aware:** `docs/context/` is written for people: maintainers, reviewers, newcomers, and developer portals.
* **In charge:** people write and review the intent before code exists; agents stop and ask when a change conflicts with a rule or decision; agents never change rules or decisions without a person's approval (C-009).
* **Enforced:** every change is a pull request, and a protected `main` branch merges nothing a person has not approved.
* Agents read only `constraints.md`, accepted decisions, and the glossary terms they need, and only while planning a change. Studies found that general context files do not improve agents' results and add cost (Gloaguen et al., 2026), so the project does not claim better agent results.

### Consequences

* Good, because the promise rests on pull requests and branch protection, which teams already use and trust.
* Good, because it works with any agent.
* Bad, because it depends on people really reviewing; rubber-stamped pull requests give no agency.

## More Information

* Gloaguen et al., 2026: <https://arxiv.org/abs/2602.11988>
