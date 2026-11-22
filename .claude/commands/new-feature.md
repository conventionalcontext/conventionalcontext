# Command: /new-feature

<!-- ============================================================
  .claude/commands/new-feature.md — Slash Command Definition
  ============================================================
  USAGE:
    /new-feature [feature-name]

  PURPOSE:
    Scaffolds a new feature: creates the spec, boilerplate module,
    test skeleton, and updates CLAUDE.md sprint focus.

  HOW CLAUDE CODE USES THIS:
    When the engineer types /new-feature [name], Claude Code reads
    this file and executes the steps below.

  HOW TO CUSTOMISE:
    Modify the steps to match your project structure, naming conventions,
    and scaffolding preferences.
  ============================================================ -->

## Steps

When the engineer runs `/new-feature [name]`:

1. **Read context first**
   - Read `docs/context/requirements.md` to understand the problem domain
   - Read `docs/context/architecture.md` to understand existing patterns
   - Read `docs/context/constraints.md` to know what rules apply

2. **Create the feature spec**
   - Copy `docs/context/features/example-feature.md` to `docs/context/features/[name].md`
   - Set status to `draft`
   - Ask the engineer: "What problem does this feature solve?" and "What are the acceptance criteria?"
   - Fill in the spec based on the answers — do not start coding until the spec has at least a problem statement and at least 2 acceptance criteria

3. **Check for architectural decisions**
   - If the feature requires a new third-party dependency → stop and ask before proceeding
   - If the feature requires a schema change → confirm the migration approach per [C-010]
   - If the feature changes the API surface → confirm the versioning strategy per [C-021]

4. **Scaffold the module**
   - Create `src/[PLACEHOLDER: your module path]/[name]/` with:
     - `index.ts` — public exports only
     - `[name].service.ts` — business logic
     - `[name].types.ts` — TypeScript types and Zod schemas
     - `[name].routes.ts` — HTTP route handlers (if applicable)
     - `[name].test.ts` — test skeleton with describe blocks matching acceptance criteria

5. **Update CLAUDE.md**
   - Add the feature spec path to "Active features" in the "Current sprint focus" section

6. **Confirm with the engineer**
   - Report what was created
   - List the acceptance criteria from the spec
   - Ask: "Ready to start implementing? Any changes to the spec before I begin?"
