# Architecture

![HARC Architecture](../assets/harc_architecture_with_agents_v2.svg)

## System Context

HARC (Human Agentic Readable Context) is a framework, not an application. It defines:
1. A directory structure for AI-accessible project context
2. File formats and templates for context documents
3. Tooling conventions for AI agents and Backstage integration

```mermaid
C4Context
  title HARC Framework — System Context

  Person(dev, "Developer", "Writes code, updates context")
  Person(aiagent, "AI Agent", "Claude Code, GitHub Copilot, OpenCode")
  
  System(repo, "Git Repository", "Source code + docs/context/ + CLAUDE.md")
  System_Ext(backstage, "Backstage IDP", "Service catalog, TechDocs, scorecards (optional)")
  System_Ext(github, "GitHub/GitLab", "Hosting, Issues, Actions/CI")
  
  Rel(dev, repo, "commits code + context")
  Rel(aiagent, repo, "reads CLAUDE.md, AGENTS.md, docs/context/")
  Rel(repo, backstage, "syncs via catalog-info.yaml")
  Rel(repo, github, "tickets branch syncs with Issues")
```

## Component Overview

| Component                          | Responsibility                                              |
| ---------------------------------- | ----------------------------------------------------------- |
| `CLAUDE.md`                        | Claude Code entry point (navigation doc, <80 lines)         |
| `AGENTS.md`                        | OpenCode entry point (navigation doc, synced with CLAUDE.md)|
| `.github/copilot-instructions.md`  | GitHub Copilot workspace instructions                       |
| `docs/context/`                        | Persistent project memory (requirements, architecture, etc) |
| `docs/context/decisions/`              | Architecture Decision Records (ADRs)                        |
| `docs/context/features/`               | Feature specifications with acceptance criteria             |
| `.claude/commands/`                | Claude Code slash commands                                  |
| `CHANGELOG.md`                     | Living changelog (auto-updated by AI agents)                |
| `catalog-info.yaml`                | Backstage component descriptor (optional)                   |
| `docs/`                            | Human documentation (TechDocs source)                       |
| `tickets` branch                   | In-git agile ticket system (orphan branch)                  |

## Layered Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│  Layer 1: IDP / Backstage (Optional)                                    │
│  ─────────────────────────────────────────────────────────────────────  │
│  catalog-info.yaml → Software Catalog (if using Backstage)              │
│  docs/ + docs/context/ → TechDocs                                       │
│  Scorecard rules → Context quality enforcement                      │
└────────────────────────────────┬────────────────────────────────────┘
                                 │ syncs from repo
┌────────────────────────────────▼────────────────────────────────────┐
│  Layer 2: Repo Root — Machine-Readable Context                      │
│  ─────────────────────────────────────────────────────────────────  │
│  CLAUDE.md ─────────────────→ Claude Code reads first               │
│  AGENTS.md ─────────────────→ OpenCode reads first                  │
│  .github/copilot-instructions.md → GitHub Copilot reads             │
│  catalog-info.yaml ─────────→ Backstage registration (optional)     │
└────────────────────────────────┬────────────────────────────────────┘
                                 │
         ┌───────────────────────┴───────────────────────┐
         │                                               │
┌────────▼────────────────┐         ┌───────────────────▼─────────────┐
│  Layer 3a: Requirements │         │  Layer 3b: Architecture        │
│  ───────────────────────│         │  ─────────────────────────────  │
│  docs/context/requirements.md         │  docs/context/architecture.md      │
│  docs/context/features/     │         │  docs/context/decisions/           │
│  docs/context/glossary.md   │         │  OpenAPI specs, schemas        │
└────────────────────────┬┘         └──────────────────┬──────────────┘
                         │                             │
                         └──────────────┬──────────────┘
                                        │ informs
┌───────────────────────────────────────▼─────────────────────────────┐
│  Layer 4: AI Agent Entry Points                                     │
│  ─────────────────────────────────────────────────────────────────  │
│  CLAUDE.md (root) + CLAUDE.md (per-module)                          │
│  AGENTS.md (root) — OpenCode entry point                            │
│  .claude/commands/ (slash commands)                                 │
│  .github/copilot-instructions.md                                    │
└───────────────────────────────────────┬─────────────────────────────┘
                                        │ produces + updates
┌───────────────────────────────────────▼─────────────────────────────┐
│  Layer 5: Living Artifacts                                          │
│  ─────────────────────────────────────────────────────────────────  │
│  CHANGELOG.md · test coverage · API diff · dependency map           │
└─────────────────────────────────────────────────────────────────────┘
```

## Key Design Decisions

| Decision                               | ADR                                                         | Status   |
| -------------------------------------- | ----------------------------------------------------------- | -------- |
| Adopt HARC Framework                   | [ADR-0001](decisions/0001-harc-framework-adoption.md)       | Proposed |
| In-Git Ticket System                   | [ADR-0002](decisions/0002-in-git-ticket-system.md)          | Proposed |
| AI Instruction File Sync               | [ADR-0003](decisions/0003-ai-instruction-sync.md)           | Proposed |
| Add OpenCode Support                   | [ADR-0004](decisions/0004-opencode-support.md)              | Proposed |

## Data Model

HARC does not define application data models. Instead, it defines **document structures**:

### Context File Structure

```mermaid
erDiagram
    REPO ||--|| CLAUDE_MD : contains
    REPO ||--|| AGENTS_MD : contains
    REPO ||--|| CONTEXT_DIR : contains
    REPO ||--o| TICKETS_BRANCH : "may have"
    
    CONTEXT_DIR ||--|| REQUIREMENTS : contains
    CONTEXT_DIR ||--|| ARCHITECTURE : contains
    CONTEXT_DIR ||--|| CONSTRAINTS : contains
    CONTEXT_DIR ||--|| GLOSSARY : contains
    CONTEXT_DIR ||--o{ DECISIONS : contains
    CONTEXT_DIR ||--o{ FEATURES : contains
    
    DECISIONS {
        string id PK "NNNN"
        string title
        enum status "Draft|Proposed|Accepted|Superseded|Deprecated"
        date date
        text context
        text decision
        text consequences
    }
    
    FEATURES {
        string name PK
        enum status "draft|in-progress|complete|deprecated"
        string adr FK
        text problem_statement
        text acceptance_criteria
        text data_model
        text api_contract
    }
    
    TICKETS_BRANCH ||--o{ TICKET : contains
    TICKET {
        string id PK "TICK-NNNN"
        string title
        enum type "epic|story|task|bug|spike"
        enum status "backlog|ready|in-progress|review|done|blocked"
        string assignee
        string epic FK
        string sprint
        int story_points
    }
```

## Ticket System Architecture

See [ADR-0002](decisions/0002-in-git-ticket-system.md) for full details.

```mermaid
flowchart TB
    subgraph "Main Branch"
        code[Source Code]
        context[docs/context/]
        claude[CLAUDE.md]
    end
    
    subgraph "Tickets Branch (Orphan)"
        config[.harc/config.yaml]
        epics[epics/]
        stories[stories/]
        bugs[bugs/]
        mkdocs[docs/mkdocs.yml]
    end
    
    subgraph "External Systems"
        ghissues[GitHub Issues]
        glissues[GitLab Issues]
        jira[Jira]
    end
    
    subgraph "Tooling"
        cli[harc-tickets CLI]
        actions[GitHub Actions]
        site[Static Site]
    end
    
    cli -->|create/update| stories
    cli -->|sync| ghissues
    actions -->|bidirectional sync| ghissues
    mkdocs -->|build| site
    
    context -.->|references| epics
    claude -.->|points to| context
```

## External Dependencies

| Dependency       | Purpose                     | Required |
| ---------------- | --------------------------- | -------- |
| Git              | Version control             | Yes      |
| GitHub/GitLab    | Hosting, Issues, CI         | Yes      |
| Python 3.x       | CLI tooling                 | Yes (for ticket system) |
| MkDocs           | Static site generation      | Optional |
| Backstage        | IDP integration             | Optional |

## Security Considerations

- No secrets stored in context files
- Ticket files may reference issue numbers but not sensitive data
- Branch protection on `tickets` branch recommended
- `locked_by` field should use opaque session IDs, not credentials
