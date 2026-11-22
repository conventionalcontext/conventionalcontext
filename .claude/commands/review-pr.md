# Command: /review-pr

<!-- ============================================================
  .claude/commands/review-pr.md — Slash Command Definition
  ============================================================
  USAGE:
    /review-pr

  PURPOSE:
    Runs a pre-merge checklist to ensure the PR is complete:
    code is consistent with context files, context files are updated,
    and constraints are respected.

  RUN THIS BEFORE:
    - Requesting review from a teammate
    - Merging a PR
  ============================================================ -->

## Checklist

When the engineer runs `/review-pr`:

### Context completeness
- [ ] If the architecture changed → `architecture.md` has been updated
- [ ] If a new dependency was added → an ADR exists in `docs/context/decisions/`
- [ ] If a feature is complete → acceptance criteria are checked off in the feature spec
- [ ] If a new constraint was identified → it is in `constraints.md`
- [ ] `CLAUDE.md` stack section reflects the current state of `package.json` (or equivalent)
- [ ] `CHANGELOG.md` has an entry for this change under `[Unreleased]`

### Code quality
- [ ] No violations of the constraints in `docs/context/constraints.md`
- [ ] New code follows the patterns established in `architecture.md`
- [ ] Tests cover the acceptance criteria in the feature spec

### Security
- [ ] No secrets or credentials committed
- [ ] User input is validated per [C-031]
- [ ] Authentication checks follow [C-033]

### API (if applicable)
- [ ] New endpoints have OpenAPI annotations per [C-020]
- [ ] Breaking changes have a versioning strategy per [C-021]

## Report

After running the checklist:
- List any items that FAIL with a brief explanation
- List any items that could not be verified
- If all items pass: confirm the PR is ready for review
