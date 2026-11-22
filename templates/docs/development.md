# Development Guide

<!-- ============================================================
  docs/development.md — Developer Guide
  ============================================================
  Practical guide for engineers working on this service day to day.
  This is the "how" — procedures, commands, and workflows.
  The "what" and "why" live in docs/context/.
  ============================================================ -->

## Prerequisites

- [PLACEHOLDER — e.g. Node 20+, Docker, AWS CLI configured]

## Setup

```bash
# Clone
git clone [PLACEHOLDER: repo-url]
cd [PLACEHOLDER: repo-name]

# Install dependencies
[PLACEHOLDER: e.g. pnpm install]

# Copy environment config
cp .env.example .env
# Edit .env — see docs/context/constraints.md [C-072] for config approach

# Start local dependencies (database, message bus, etc.)
[PLACEHOLDER: e.g. docker compose up -d]

# Run database migrations
[PLACEHOLDER: e.g. pnpm db:migrate]

# Start the development server
[PLACEHOLDER: e.g. pnpm dev]
```

## Running Tests

```bash
# Unit tests
[PLACEHOLDER: e.g. pnpm test]

# Integration tests
[PLACEHOLDER: e.g. pnpm test:integration]

# All tests with coverage
[PLACEHOLDER: e.g. pnpm test:coverage]
```

## AI-Assisted Development with Claude Code

This repository is configured for Claude Code. To get started:

1. Open the repo in your terminal
2. Run `claude` to start a session
3. Claude Code will read `CLAUDE.md` and be oriented to the project

### Useful slash commands

| Command | What it does |
|---|---|
| `/new-feature [name]` | Scaffold a new feature spec and module |
| `/create-adr [topic]` | Log an architectural decision |
| `/update-context` | Sync context files after a change |
| `/review-pr` | Pre-merge checklist |

## Deployment

[PLACEHOLDER — describe how to deploy, what environments exist, and who
can trigger deployments. Link to the CI/CD pipeline configuration.]
