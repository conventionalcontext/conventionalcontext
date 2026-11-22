# Getting Started with HARC

## Prerequisites

- A git repository (new or existing)
- An AI coding assistant (Claude Code, GitHub Copilot, or OpenCode)
- Optionally: Backstage IDP for catalog integration

## Installation

### Option A: Fork the Template

```bash
# Fork from: github.com/opencpk/aipk-template-base
```

### Option B: Bootstrap into Existing Repo

```bash
curl -sL https://raw.githubusercontent.com/opencpk/aipk-framework-harc/main/scripts/bootstrap.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/opencpk/aipk-framework-harc.git
cp aipk-framework-harc/scripts/bootstrap.sh ./
chmod +x bootstrap.sh
./bootstrap.sh
```

### Existing Repos

The same bootstrap command works for existing repos. When a file already exists, a `-HARC` template is created alongside it — your existing files are never overwritten:

```bash
curl -sL https://raw.githubusercontent.com/opencpk/aipk-framework-harc/main/scripts/bootstrap.sh -o bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh
```

After running:

1. **Find `-HARC` template files**: `find . -name '*-HARC*' -type f`
2. **Refactor** — For each `-HARC` file, ask your AI agent to refactor the original file into the HARC format using the `-HARC` file as a reference template
3. **Clean up** — Delete the `-HARC` files when done: `find . -name '*-HARC*' -type f -delete`
4. **Fill in** remaining `[PLACEHOLDER]` values
5. **Commit**: `git commit -m "chore: adopt HARC context structure"`

## What Gets Created

```
your-repo/
├── CLAUDE.md                    # Claude Code entry point (<80 lines)
├── AGENTS.md                    # OpenCode entry point
├── .github/
│   └── copilot-instructions.md  # GitHub Copilot instructions
├── catalog-info.yaml            # Backstage component descriptor (optional)
├── CHANGELOG.md                 # Living changelog (auto-updated by AI agents)
│
├── docs/context/                    # Persistent project memory
│   ├── requirements.md          # What the system must do
│   ├── architecture.md          # How the system is designed
│   ├── constraints.md           # Rules that must not be broken
│   ├── glossary.md              # Domain language reference
│   ├── roadmap.md               # Project roadmap and planned milestones
│   ├── decisions/               # Architecture Decision Records
│   │   └── 0001-example.md
│   └── features/                # Feature specifications
│       └── example-feature.md
│
├── .claude/                     # Claude Code extensions
│   └── commands/                # Slash commands
│       ├── new-feature.md
│       ├── create-adr.md
│       ├── update-context.md
│       └── review-pr.md
│
└── docs/                        # Human docs (optional: Backstage TechDocs source)
    ├── mkdocs.yml
    └── index.md
```

## First Steps After Bootstrap

1. **Fill in `[PLACEHOLDER]` values** — Start with `CLAUDE.md`, then `docs/context/requirements.md`
2. **Create your first real ADR** — Replace `0001-example-decision.md` with your first real decision
3. **Review `docs/context/constraints.md`** — Add your project's coding standards and rules
4. **Remove Backstage files if not needed** — Delete `catalog-info.yaml` and `docs/mkdocs.yml` if you don't use Backstage
5. **Commit** — `git commit -m "chore: initialize HARC context"`

## Keeping Context Fresh

The key to HARC is that context evolves with the code:

- When you complete a feature, check off acceptance criteria in the feature spec
- When architecture changes, update `docs/context/architecture.md` in the same PR
- When a new dependency is added, create an ADR
- When a sprint starts, update the "Current sprint focus" in `CLAUDE.md`
- When significant changes are merged, update `CHANGELOG.md`

AI agents (Claude Code, GitHub Copilot, OpenCode) can be instructed to do this automatically — and the `/update-context` slash command in Claude Code automates the process.

## CHANGELOG.md

The `CHANGELOG.md` file follows [Keep a Changelog](https://keepachangelog.com/) format. AI agents update it as part of their development workflow:

- **Claude Code** updates it via the `/update-context` slash command
- **GitHub Copilot** and **OpenCode** are instructed in their entry point files to append entries under `[Unreleased]`
- On release, rename `[Unreleased]` to the version number and date

## Backstage Integration (Optional)

If your team uses Backstage as an Internal Developer Platform:

1. Fill in `catalog-info.yaml` with your component details
2. Ensure `docs/mkdocs.yml` points to your `docs/context/` files
3. Import the component into Backstage via the catalog
4. Add scorecard rules to enforce context quality

If you **don't use Backstage**, you can safely delete `catalog-info.yaml` and `docs/mkdocs.yml`. HARC works without Backstage — the `docs/context/` files and AI entry points are what matter.

## Testing the Bootstrap Script

The framework includes a test script to verify the bootstrap works correctly:

```bash
# Run all tests (default):
./tests/test-bootstrap.sh

# Test fresh repo only:
./tests/test-bootstrap.sh --fresh

# Test existing repo only:
./tests/test-bootstrap.sh --existing

# Test upgrade scenario only:
./tests/test-bootstrap.sh --upgrade
```

Test output goes to `test-results/bootstrap/` (gitignored). Inspect the generated files to verify the bootstrap produces the expected structure.

## Next Steps

- Read the [HARC Guide](harc-guide.md) for the comprehensive reference
- Set up the [In-Git Ticket System](docs/context/features/ticket-system.md) (optional)
- Explore [BMAD Method compatibility](https://github.com/bmad-code-org/BMAD-METHOD)
