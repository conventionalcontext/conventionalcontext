# Command: /create-adr

<!-- ============================================================
  .claude/commands/create-adr.md — Slash Command Definition
  ============================================================
  USAGE:
    /create-adr [topic]

  PURPOSE:
    Creates a new Architecture Decision Record with correct sequential
    numbering and the standard template pre-filled based on context.

  WHEN TO USE:
    - Adding a new third-party dependency (required per [C-040])
    - Making a significant architectural change
    - Choosing between two viable technical approaches
    - Reversing or superseding a previous decision
  ============================================================ -->

## Steps

When the engineer runs `/create-adr [topic]`:

1. **Determine the next ADR number**
   - List all files in `docs/context/decisions/`
   - Find the highest NNNN prefix
   - New ADR number = highest + 1 (zero-padded to 4 digits)

2. **Gather context**
   - Ask: "What situation or problem is driving this decision?"
   - Ask: "What are the options you considered?"
   - Ask: "What did you decide and why?"
   - If this supersedes a previous ADR: ask which one

3. **Create the ADR**
   - Create `docs/context/decisions/[NNNN]-[kebab-case-topic].md`
   - Use the template from `docs/context/decisions/0001-example-decision.md`
   - Fill in Context, Decision, and Consequences from the answers above
   - Set status to `Proposed` (engineer changes to `Accepted` after review)

4. **Update references**
   - If this ADR relates to an active feature, add the ADR link to the feature spec
   - If this ADR changes the architecture, note it in `docs/context/architecture.md` Key Design Decisions table

5. **Confirm**
   - Show the created ADR path and summarise the decision in 2 sentences
   - Remind the engineer to change status from Proposed to Accepted after team review
