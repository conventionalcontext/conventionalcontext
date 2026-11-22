# Feature: In-Git Ticket System

## Status

`draft`

## ADR

[ADR-0002](../decisions/0002-in-git-ticket-system.md)

## Problem Statement

AI agents working on codebases cannot see the project backlog, prioritized work items, or coordinate with other agents to avoid conflicts. Traditional ticket systems (Jira, GitHub Issues) store data externally, invisible to AI during development sessions.

## Acceptance Criteria

### MVP Phase

- [ ] [AC-001] Orphan `tickets` branch can be initialized with `harc-tickets init`
- [ ] [AC-002] Tickets can be created via CLI: `harc-tickets create story "title" --epic EPIC-0001`
- [ ] [AC-003] Tickets are stored as markdown files with YAML frontmatter
- [ ] [AC-004] Tickets can be listed and filtered: `harc-tickets list --status ready`
- [ ] [AC-005] Tickets can be claimed by agents: `harc-tickets claim TICK-0001 --agent @session`
- [ ] [AC-006] Ticket locks expire after configurable timeout
- [ ] [AC-007] GitHub Actions syncs tickets → GitHub Issues on push
- [ ] [AC-008] GitHub Actions syncs GitHub Issues → tickets on issue events

### Static Site Phase

- [ ] [AC-010] Tickets branch is a valid MkDocs source
- [ ] [AC-011] `harc-tickets serve` starts local MkDocs with live reload
- [ ] [AC-012] `harc-tickets build` generates static site
- [ ] [AC-013] Site includes search functionality
- [ ] [AC-014] Site can be deployed to GitHub Pages

### Future Phase

- [ ] [AC-020] GitLab CI syncs tickets ↔ GitLab Issues
- [ ] [AC-021] Jira sync via API

## Data Model

```yaml
# stories/TICK-0001-example.md
---
id: TICK-0001
title: Example ticket
type: story           # epic | story | task | bug | spike
status: ready         # backlog | ready | in-progress | review | done | blocked
priority: medium      # critical | high | medium | low
reporter: "@user"
assignee: null
labels: []
story_points: 3
epic: null
sprint: null
components: []
time_estimate: null
time_spent: null
created: 2026-03-18
updated: 2026-03-18
github_issue: null
locked_by: null
lock_timestamp: null
work_session: null
---

## Description

Ticket description here.

## Acceptance Criteria

- [ ] [AC-001] Criteria here
```

## API Contract

CLI commands (not HTTP API):

```bash
# Initialization
harc-tickets init                            # Create tickets branch

# CRUD
harc-tickets create <type> "<title>" [opts]  # Create ticket
harc-tickets show TICK-0001                  # Show ticket details
harc-tickets update TICK-0001 --status X     # Update fields
harc-tickets delete TICK-0001                # Delete (via PR)

# Workflow
harc-tickets list [filters]                  # List tickets
harc-tickets claim TICK-0001 --agent @id     # Claim ticket
harc-tickets release TICK-0001               # Release lock
harc-tickets complete TICK-0001              # Mark done + release

# Sync
harc-tickets sync github                     # Bidirectional sync
harc-tickets sync gitlab                     # Future
harc-tickets sync jira                       # Future

# Static site
harc-tickets serve                           # Local preview
harc-tickets build                           # Build site
```

## Non-Functional Requirements

- [NFR-001] CLI must be Python or shell (no compiled binaries)
- [NFR-002] Must work offline (sync deferred until online)
- [NFR-003] Ticket listing must complete in <500ms for 1000 tickets
- [NFR-004] Must render correctly in GitHub markdown preview

## Out of Scope

- Web UI for editing tickets (use CLI or GitHub file editor)
- Real-time collaboration (use git workflows)
- Permissions beyond git branch protection

## Open Questions

- [ ] Should ticket IDs be globally unique (UUID) or sequential per repo?
- [ ] How to handle merge conflicts in ticket files during sync?
- [ ] Should sprint definitions live in `.harc/sprints.yaml` or elsewhere?
