# Command: /update-context

<!-- ============================================================
  .claude/commands/update-context.md — Slash Command Definition
  ============================================================
  USAGE:
    /update-context

  PURPOSE:
    Syncs docs/context/ files after a significant change. Run this at the
    end of a feature, refactor, or any change that affects the architecture,
    data model, API, or dependencies.

  THIS IS THE MECHANISM THAT KEEPS CONTEXT CURRENT.
  Running this command is what separates a context-driven project from
  one where the docs rot. Make it a habit.
  ============================================================ -->

## Steps

When the engineer runs `/update-context`:

1. **Review what changed**
   - Review the git diff since the last context update commit
   - Identify: new files, deleted files, changed dependencies, schema changes, API changes, new patterns

2. **Update feature specs**
   - For any completed acceptance criteria, tick the checkboxes in the relevant `docs/context/features/` file
   - Update feature status to `complete` if all criteria are met

3. **Update architecture.md (if needed)**
   - If new components were added, update the Component Overview table
   - If the data model changed, update the ER diagram
   - If new external dependencies were added, update the External Dependencies table
   - If the deployment topology changed, update Infrastructure and Deployment

4. **Update CLAUDE.md (if needed)**
   - If new dependencies were added to package.json/requirements.txt, update the Stack section
   - If new constraints were identified, add them to `docs/context/constraints.md` and reference from CLAUDE.md

5. **Update CHANGELOG.md**
   - Add a bullet under `[Unreleased]` for each significant change
   - Use the Keep a Changelog format: Added / Changed / Fixed / Removed

6. **Update constraints.md (if needed)**
   - If a new coding pattern was established that should be enforced, add it as a constraint with a [C-NNN] code

7. **Summarise**
   - Report which files were updated and what changed in each
   - Flag any open questions or areas where the context could not be updated without more information
