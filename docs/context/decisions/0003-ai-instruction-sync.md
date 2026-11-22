# ADR-0003: AI Agent Instruction File Synchronization

## Status

**Proposed** — Strategy defined; cross-reference pattern selected.

## Date

2026-03-18

## Authors

@andreouellet, @claude-agent

## Context

The HARC Framework requires providing instructions to multiple AI coding tools:

| Tool           | Instruction File                  | When Read                    |
| -------------- | --------------------------------- | ---------------------------- |
| Claude Code    | `CLAUDE.md`                       | Start of each session        |
| GitHub Copilot | `.github/copilot-instructions.md` | Loaded at workspace open     |
| OpenCode       | `AGENTS.md`                       | Start of each session        |

These files serve the same purpose (guiding AI behavior) but for different tools, creating a synchronization challenge.

### Problem

If CLAUDE.md, copilot-instructions.md, and AGENTS.md diverge:
- Different agents may follow different rules
- Constraints added to one are not enforced by the other
- Maintenance burden doubles

### Options Considered

1. **Single file symlink** — One file symlinks to the other
2. **Generated from template** — Both generated from single source during CI
3. **Cross-reference with sync instruction** — Each file instructs agents to keep the other updated
4. **Accept divergence** — Allow different rules for different tools

## Decision

We will use **Option 3: Cross-reference with sync instruction**.

Each file will:
1. Contain full instructions for its respective tool
2. Include an explicit instruction to update the other two files when edited
3. Reference `docs/context/` as the source of truth for detailed rules

### Implementation

**CLAUDE.md header:**
```markdown
<!-- SYNC NOTICE: This file must stay synchronized with .github/copilot-instructions.md and AGENTS.md
     When updating rules here, also update the corresponding sections in both files.
     The source of truth for constraints is docs/context/constraints.md -->
```

**copilot-instructions.md header:**
```markdown
<!-- SYNC NOTICE: This file must stay synchronized with CLAUDE.md and AGENTS.md
     When updating rules here, also update the corresponding sections in both files.
     The source of truth for constraints is docs/context/constraints.md -->
```

**AGENTS.md header:**
```markdown
<!-- SYNC NOTICE: This file must stay synchronized with CLAUDE.md and .github/copilot-instructions.md
     When updating rules here, also update the corresponding sections in both files.
     The source of truth for constraints is docs/context/constraints.md -->
```

### Shared Content Strategy

| Content Type           | Location                      | Sync Method                |
| ---------------------- | ----------------------------- | -------------------------- |
| Project description    | Both files                    | Manual (short, rarely changes) |
| Stack/tech details     | Both files                    | Manual (rarely changes)    |
| Constraints/rules      | `docs/context/constraints.md`     | Referenced by both files   |
| ADRs                   | `docs/context/decisions/`         | Referenced by both files   |
| Feature specs          | `docs/context/features/`          | Referenced by both files   |
| Formatting standards   | Both files                    | Manual sync                |

### CI Validation (Optional)

A CI check can compare key sections:
```yaml
- name: Check instruction file sync
  run: |
    # Extract Rules sections and compare across all three files
    diff <(sed -n '/## Rules/,/## /p' CLAUDE.md) \
         <(sed -n '/## Rules/,/## /p' .github/copilot-instructions.md)
    diff <(sed -n '/## Rules/,/## /p' CLAUDE.md) \
         <(sed -n '/## Rules/,/## /p' AGENTS.md)
```

## Consequences

### Positive

- All three tools receive appropriate instructions
- Explicit sync notice reminds maintainers
- `docs/context/` remains single source of truth for details
- No build step or generation required

### Negative

- Manual sync required for shared sections across three files
- Potential for drift if notice is ignored

### Mitigations

- Keep shared content minimal in both files
- Point to `docs/context/` for all detailed rules
- PR review checklist includes "Did you update all three instruction files?"

## References

- [GitHub Copilot Instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
- [Claude Code CLAUDE.md](https://docs.anthropic.com/en/docs/claude-code)
