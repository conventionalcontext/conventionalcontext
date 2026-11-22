# ADR-0002: In-Git Agile Ticket System for Agentic Development

## Status

**Draft** — Custom HARC Ticket System selected; awaiting implementation validation.

## Date

2026-03-18

## Authors

@andreouellet, @claude-agent

## Context

Modern AI-assisted development with agents like Claude Code and GitHub Copilot requires that project context—including backlog, tickets, and work coordination—be accessible within the repository. Traditional ticket systems (Jira, GitHub Issues, GitLab Issues) store data externally, making it invisible to AI agents during development sessions.

### Problem Statement

AI agents working on a codebase cannot:
1. See the backlog or prioritized work items
2. Understand dependencies between tickets
3. Coordinate with other agents to avoid conflicts
4. Know what work is in progress, blocked, or available

### Requirements

**MVP Requirements:**
- Tickets stored as markdown files in git (AI and human readable)
- Fields: title, description, status, reporter, assignee, labels, story_points, epic, sprint, time tracking, components
- Orphan branch (`tickets`) to avoid polluting main history
- Sync with GitHub Issues (bidirectional via GitHub Actions)
- Shell or Python tooling (no Go, for portability)
- Renderable as static site (MkDocs or similar) with search
- Support both human and agent interaction
- BMAD Method / beads-style agent coordination compatibility

**Future Requirements:**
- GitLab Issues sync
- Jira sync (bidirectional)
- Milestones, due dates, fix versions, linked tickets

### Constraints

- Must work offline (git-native)
- Must be readable without special tooling (plain markdown)
- Must support concurrent agent work without conflicts
- Branch protection must allow both direct push (for status changes) and PR workflows (for structural changes)

## Options Considered

### Option 1: git-bug

**Description:** Distributed, offline-first bug tracker embedded in git using git objects (not files). Written in Go.

**Pros:**
- Active project with community (9.7k stars, March 2026)
- Native GitHub/GitLab bidirectional sync via bridges
- No working tree pollution (uses git refs)
- Fast (milliseconds to list issues)
- GraphQL API for automation
- TUI, CLI, and Web UI interfaces

**Cons:**
- Requires Go binary installation (violates portability requirement)
- Git objects are not directly readable by AI agents (requires CLI extraction)
- No Jira bridge (would require custom development)
- Less control over ticket format/fields

**Verdict:** Rejected — Go dependency and non-readable storage format.

### Option 2: git-issue

**Description:** Minimalist shell-based issue tracker. Stores tickets as plain text files in `.issues/` directory with its own git repository.

**Pros:**
- Plain text files (AI agents can read directly)
- Shell-only implementation (no binary dependencies)
- GitHub/GitLab import/export capability
- Mature project (11 years)
- Supports tags, milestones, assignees, time tracking, due dates, weights, attachments

**Cons:**
- Less active development
- `.issues/` directory in working tree (needs .gitignore coordination or separate repo)
- Manual sync (no automatic bidirectional with GitHub/GitLab)
- No Jira support
- Fixed format (less customizable for HARC/BMAD needs)
- Does not support orphan branch model natively

**Verdict:** Rejected — Working tree pollution and limited customization.

### Option 3: Custom HARC Ticket System (Selected)

**Description:** Purpose-built ticket system using markdown files with YAML frontmatter, stored on an orphan `tickets` branch, with Python/Shell CLI tooling and GitHub Actions for sync.

**Pros:**
- Full control over format and fields
- BMAD/beads compatible by design (agent coordination fields)
- AI agents can read markdown directly
- Customizable to exact requirements
- Orphan branch = no history pollution
- Renderable as static site (MkDocs) with search and live reload
- GitHub UI provides read-only rendered view + edit capability
- Shell/Python = portable, no binary dependencies
- Can implement exact sync logic needed for GitHub/GitLab/Jira

**Cons:**
- Requires building sync automation
- More initial development effort
- Must maintain CLI tooling and sync logic
- No existing community (greenfield)

**Verdict:** Selected — Best alignment with all requirements.

## Decision

We will implement a **Custom HARC Ticket System** with the following architecture:

### Storage Format

Tickets stored as markdown files with YAML frontmatter on orphan `tickets` branch:

```
tickets/                        # Orphan branch root
├── .harc/
│   ├── config.yaml            # Project ticket configuration
│   ├── components.yaml        # Component definitions
│   ├── labels.yaml            # Label definitions
│   └── sprints.yaml           # Sprint definitions
├── epics/
│   ├── EPIC-0001-user-auth.md
│   └── EPIC-0002-billing.md
├── stories/
│   ├── TICK-0001-login-flow.md
│   ├── TICK-0002-password-reset.md
│   └── ...
├── bugs/
│   └── BUG-0001-login-timeout.md
├── tasks/
│   └── TASK-0001-setup-ci.md
└── docs/
    ├── mkdocs.yml             # Static site config
    └── index.md               # Ticket system overview
```

### Ticket File Format

```yaml
# stories/TICK-0001-login-flow.md
---
id: TICK-0001
title: Implement Login Flow
type: story                    # epic | story | task | bug | spike
status: ready                  # backlog | ready | in-progress | review | done | blocked
priority: high                 # critical | high | medium | low
reporter: "@andreouellet"
assignee: null                 # "@username" or null
labels: [auth, security, mvp]
story_points: 5
epic: EPIC-0001
sprint: "2026-Q1-S2"
components: [api, auth-service]

# Time tracking
time_estimate: "8h"
time_spent: "0h"

# Dates
created: 2026-03-15
updated: 2026-03-18
due_date: null

# Sync references (populated by automation)
github_issue: null             # GitHub issue number
gitlab_issue: null             # GitLab issue ID
jira_key: null                 # Jira ticket key

# Agent coordination (BMAD/beads compatible)
locked_by: null                # Agent/user ID currently working
lock_timestamp: null           # ISO timestamp of lock
work_session: null             # Session ID for conflict detection
---

## Description

As a user, I want to log in with email and password so that I can access my account.

## Acceptance Criteria

- [ ] [AC-001] User can enter email and password on login form
- [ ] [AC-002] Valid credentials redirect to dashboard
- [ ] [AC-003] Invalid credentials show error message
- [ ] [AC-004] Failed attempts are rate-limited (5 per minute)

## Technical Notes

- Use JWT tokens (see ADR-0003)
- Store refresh tokens in httpOnly cookies
- Rate limiting via Redis

## Dependencies

requires:
  - TICK-0002  # Database schema for users

blocks:
  - TICK-0015  # Password reset (needs login first)
  - TICK-0016  # Profile management

## Comments

<!-- Agent and human comments appended here -->
```

### CLI Tooling (Python/Shell)

```bash
# Initialize tickets branch in existing repo
harc-tickets init

# Create tickets
harc-tickets create story "Implement login flow" --epic EPIC-0001 --points 5
harc-tickets create bug "Login timeout on slow networks" --priority high

# List and filter
harc-tickets list                           # All open tickets
harc-tickets list --status ready            # Ready for work
harc-tickets list --assignee @claude        # Assigned to agent
harc-tickets list --sprint "2026-Q1-S2"     # Current sprint

# Workflow
harc-tickets claim TICK-0001 --agent @claude-session-123
harc-tickets update TICK-0001 --status in-progress
harc-tickets release TICK-0001              # Release lock
harc-tickets complete TICK-0001             # Mark done, release lock

# Time tracking
harc-tickets log TICK-0001 "2h"             # Log time spent

# Sync
harc-tickets sync github                    # Bidirectional sync
harc-tickets sync gitlab                    # Future
harc-tickets sync jira                      # Future

# Static site
harc-tickets serve                          # Local MkDocs server with live reload
harc-tickets build                          # Build static site
```

### Agent Coordination Protocol

For BMAD/beads compatibility, agents follow this protocol:

1. **Query available work:**
   ```bash
   harc-tickets list --status ready --locked-by null --sprint current
   ```

2. **Claim ticket (atomic):**
   ```bash
   harc-tickets claim TICK-0001 --agent @claude-session-abc123
   # Fails if already locked
   ```

3. **Check dependencies before starting:**
   ```bash
   harc-tickets deps TICK-0001
   # Shows: requires (must be done), blocks (will unblock)
   ```

4. **Update status:**
   ```bash
   harc-tickets update TICK-0001 --status in-progress
   ```

5. **Release on completion:**
   ```bash
   harc-tickets complete TICK-0001 --time-spent "3h"
   ```

6. **Lock timeout:** Locks expire after configurable timeout (default 4 hours). Cron/Action releases stale locks.

### Branch Strategy

```
main branch          ← Source code
tickets branch       ← Orphan branch for tickets (no shared history)
  └── tickets-*      ← Feature branches for PRs (new epics, restructuring)
```

**Branch Protection (Hybrid Model):**

| Change Type               | Method            | Rationale                    |
| ------------------------- | ----------------- | ---------------------------- |
| Status changes            | Direct push       | Fast workflow for agents     |
| Time logging              | Direct push       | Routine updates              |
| New tickets               | Direct push       | Default for velocity         |
| New epics                 | PR from `tickets-*` | Requires planning review   |
| Config changes            | PR from `tickets-*` | Affects all tickets        |
| Delete tickets            | PR from `tickets-*` | Audit trail                |

### GitHub Actions Sync

```yaml
# .github/workflows/tickets-sync.yml
name: Sync Tickets with GitHub Issues

on:
  push:
    branches: [tickets]
  issues:
    types: [opened, edited, closed, reopened, labeled, unlabeled, assigned]

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          ref: tickets
      - name: Sync tickets ↔ GitHub Issues
        run: harc-tickets sync github --bidirectional
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Static Site Generation

The `tickets` branch is also a valid MkDocs site:

```yaml
# tickets/docs/mkdocs.yml
site_name: "Project Backlog"
theme:
  name: material
  features:
    - search.highlight
    - navigation.instant
nav:
  - Overview: index.md
  - Epics: ../epics/
  - Stories: ../stories/
  - Bugs: ../bugs/
  - Tasks: ../tasks/
plugins:
  - search
  - awesome-pages
watch:
  - ../epics
  - ../stories
  - ../bugs
  - ../tasks
```

**Deployment options:**
- GitHub Pages from `tickets` branch
- Netlify/Vercel with branch deploy
- Self-hosted with live reload via `mkdocs serve --watch`

## Consequences

### Positive

- All tickets visible to AI agents as part of repo context
- Human-readable in GitHub UI without tooling
- Full audit trail via git history
- Offline-capable (git-native)
- Customizable to exact workflow needs
- Static site provides searchable, browsable backlog
- Agent coordination prevents conflicts in multi-agent scenarios
- Sync with external systems maintains compatibility with existing workflows

### Negative / Trade-offs

- Development effort to build CLI and sync automation
- Must maintain custom tooling (no community support)
- Learning curve for teams used to Jira/GitHub Issues UI
- Two sources of truth during sync (potential for drift)

### Risks

- Sync conflicts if external system and git diverge
- Lock mechanism could fail, causing agent conflicts
- MkDocs rendering may need customization for ticket format

### Mitigations

- Sync runs frequently (on push + on external change)
- Lock timeout prevents permanent blocks
- CI validates ticket format before merge
- External system marked as "synced from git" to discourage direct edits

## Implementation Plan

### Phase 1: MVP (Target: 2 weeks)
- [ ] Create orphan `tickets` branch bootstrap script
- [ ] Implement Python CLI (`harc-tickets`)
- [ ] Basic CRUD operations
- [ ] Ticket format validation
- [ ] GitHub Actions sync (git → GitHub Issues)

### Phase 2: Full Sync (Target: 2 weeks)
- [ ] Bidirectional GitHub sync
- [ ] Agent coordination (lock/claim/release)
- [ ] MkDocs static site integration
- [ ] Live reload development mode

### Phase 3: Expansion (Future)
- [ ] GitLab CI sync
- [ ] Jira sync
- [ ] Advanced fields (milestones, fix versions, linked tickets)
- [ ] Web UI for non-git users

## References

- [git-bug](https://github.com/git-bug/git-bug) — Distributed bug tracker (Go-based alternative)
- [git-issue](https://github.com/dspinellis/git-issue) — Shell-based issue tracker
- [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD) — AI-driven agile development
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) — Static site generator
- [HARC Framework](./0001-harc-framework-adoption.md) — Parent architecture decision
