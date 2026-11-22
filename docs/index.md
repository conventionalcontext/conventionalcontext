# HARC Framework

**Human Agentic Readable Context**

Give AI coding assistants the context they need to work effectively on your projects.

---

## What is HARC?

HARC is a framework that provides a standard structure for project requirements, architecture, decisions, and constraints — readable by both humans and AI agents like Claude Code, GitHub Copilot, and OpenCode.

Without HARC, every AI coding session starts from zero. With HARC, your AI assistant understands the project like a team member who has read the docs.

## Quick Start

See the [Getting Started](getting-started.md) guide.

```bash
# Bootstrap HARC into an existing repo
curl -sL https://raw.githubusercontent.com/opencpk/aipk-framework-harc/main/scripts/bootstrap.sh | bash

# Safe for existing repos — creates -HARC templates alongside existing files
curl -sL https://raw.githubusercontent.com/opencpk/aipk-framework-harc/main/scripts/bootstrap.sh -o bootstrap.sh
chmod +x bootstrap.sh && ./bootstrap.sh
```

## Documentation

| Page                                      | What You'll Learn                           |
| ----------------------------------------- | ------------------------------------------- |
| [Getting Started](getting-started.md)     | Install HARC, first steps, what gets created |
| [HARC Guide](harc-guide.md)              | Deep reference: layers, evolution, anti-patterns |
| [Requirements](context/requirements.md) | Framework functional & non-functional requirements |
| [Architecture](context/architecture.md) | Layered architecture with diagrams         |

## Supported AI Tools

| Tool           | Entry Point                       | How It Works              |
| -------------- | --------------------------------- | ------------------------- |
| Claude Code    | `CLAUDE.md`                       | Reads at session start    |
| GitHub Copilot | `.github/copilot-instructions.md` | Reads at workspace open   |
| OpenCode       | `AGENTS.md`                       | Reads at session start    |
| Cursor         | `CLAUDE.md` or `.cursorrules`     | Configure in settings     |

## Links

- [Template Repo](https://github.com/opencpk/aipk-template-base) — Fork to get started
- [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD) — AI-driven agile development
- [Backstage](https://backstage.io/) — IDP framework (optional integration)
