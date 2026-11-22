# ADR-0006: HARC as a Spec Kit Extension

## Status

Draft

## Date

2026-03-22

## Context

ADR-0005 established that HARC and GitHub Spec Kit are complementary — HARC provides persistent project memory while Spec Kit provides spec-driven development workflows. A natural integration point is a Spec Kit extension that bridges the two: automatically populating or updating `docs/context/` from `.specify/` artifacts.

Teams using both tools currently must manually keep context files in sync with specs. A HARC extension for Spec Kit would automate this mapping.

## Decision

We will design (but not yet build) a Spec Kit extension called `specify-extension-harc` that:

1. **Maps Spec Kit artifacts to HARC context files:**
   - `.specify/specs/*.md` → updates `docs/context/features/` (feature specs)
   - `.specify/constitution.md` → informs `docs/context/constraints.md` (project rules)
   - `.specify/plans/*.md` → referenced in `docs/context/architecture.md` (design decisions)

2. **Adds HARC-aware commands to Spec Kit:**
   - `speckit.harc-sync` — sync Spec Kit artifacts into HARC context structure
   - `speckit.harc-init` — bootstrap HARC alongside an existing Spec Kit project

3. **Respects both directory conventions:**
   - HARC files stay in `docs/context/` (compatible with MkDocs/TechDocs)
   - Spec Kit files stay in `.specify/` (Spec Kit's expected location)
   - The extension creates cross-references, not duplicates

4. **Avoids feature overlap documented in ADR-0005:**
   - Does NOT replicate Spec Kit's constitution/specify/plan/tasks pipeline
   - Does NOT replicate HARC's ADR system in Spec Kit
   - Acts as a bridge, not a replacement for either tool

## Consequences

### Positive
- Teams get the best of both tools with minimal manual overhead
- HARC gains exposure through the Spec Kit extension ecosystem
- Validates the complementary positioning from ADR-0005

### Negative / Trade-offs
- Extension must track both HARC and Spec Kit schema changes
- Additional maintenance burden for a two-project dependency
- Risk of Spec Kit API changes breaking the extension

### Risks
- Spec Kit may add native context features that overlap with HARC
- Extension adoption may be low if teams prefer one tool over both

## Alternatives Considered

### Manual sync (current state)

Teams manually update `docs/context/` after running Spec Kit commands. Works but is error-prone and adds friction.

### Merge the projects

Combining HARC into Spec Kit would eliminate the sync problem but would lose HARC's zero-dependency, Backstage-integrated, multi-agent design. Rejected per ADR-0005.

## References

- [ADR-0005: HARC vs Spec Kit vs BMAD Comparison](0005-harc-vs-spec-kit-comparison.md)
- [GitHub Spec Kit Extension Docs](https://github.com/github/spec-kit#extensions)
- [HARC Roadmap — Spec Kit Extension](../roadmap.md)
