#!/usr/bin/env bash
# =============================================================================
# tests/test-bootstrap.sh — Bootstrap Script Test Runner
#
# PURPOSE:
#   Tests the HARC bootstrap script across three scenarios:
#     1. Fresh repo    — empty directory, all files created from scratch
#     2. Existing repo — pre-populated with realistic project files,
#                        verifies -HARC templates are created alongside
#     3. Upgrade       — runs bootstrap twice (simulating a HARC version
#                        upgrade), verifies -HARC templates appear for
#                        all previously-created files on the second run
#
#   Uses a realistic test dataset (README, CHANGELOG, docs, docs/context/)
#   to simulate a real-world project.
#
# USAGE:
#   ./tests/test-bootstrap.sh              # Run all three scenarios (default)
#   ./tests/test-bootstrap.sh --fresh      # Test fresh repo only
#   ./tests/test-bootstrap.sh --existing   # Test existing repo only
#   ./tests/test-bootstrap.sh --upgrade    # Test upgrade scenario only
#
# Run from the ROOT of the aipk-framework-harc repository.
# Output goes to test-results/bootstrap/ (gitignored).
# =============================================================================

set -euo pipefail

# ── Colours ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BOOTSTRAP_SCRIPT="${SCRIPT_DIR}/scripts/bootstrap.sh"
TEST_DIR="${SCRIPT_DIR}/test-results/bootstrap"

# ── Parse arguments ──────────────────────────────────────────────────────────
MODE="all"
for arg in "$@"; do
  case "$arg" in
    --fresh)    MODE="fresh" ;;
    --existing) MODE="existing" ;;
    --upgrade)  MODE="upgrade" ;;
    --all)      MODE="all" ;;
    --help|-h)
      echo "Usage: $0 [--fresh|--existing|--upgrade]"
      echo ""
      echo "  (no args)    Run all three test scenarios (default)"
      echo "  --fresh      Test bootstrap on a fresh repo only"
      echo "  --existing   Test bootstrap on a repo with pre-existing project files only"
      echo "  --upgrade    Test re-running bootstrap (simulates HARC version upgrade) only"
      exit 0
      ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

# ── Verify bootstrap script exists ──────────────────────────────────────────
if [ ! -f "$BOOTSTRAP_SCRIPT" ]; then
  echo -e "${RED}ERROR:${RESET} Bootstrap script not found at: $BOOTSTRAP_SCRIPT"
  echo "  Run this script from the root of the aipk-framework-harc repository."
  exit 1
fi

# ── Expected files list ─────────────────────────────────────────────────────
# When testing with --agent claude,copilot,opencode (all agents)
EXPECTED_FILES=(
  "CLAUDE.md"
  "AGENTS.md"
  ".github/copilot-instructions.md"
  "catalog-info.yaml"
  "CHANGELOG.md"
  "docs/context/requirements.md"
  "docs/context/architecture.md"
  "docs/context/constraints.md"
  "docs/context/glossary.md"
  "docs/context/roadmap.md"
  "docs/context/decisions/0001-example-decision.md"
  "docs/context/features/example-feature.md"
  ".claude/commands/new-feature.md"
  ".claude/commands/create-adr.md"
  ".claude/commands/update-context.md"
  ".claude/commands/review-pr.md"
  ".github/copilot/commands/new-feature.md"
  ".github/copilot/commands/create-adr.md"
  ".github/copilot/commands/update-context.md"
  ".github/copilot/commands/review-pr.md"
  ".opencode/commands/new-feature.md"
  ".opencode/commands/create-adr.md"
  ".opencode/commands/update-context.md"
  ".opencode/commands/review-pr.md"
  "docs/mkdocs.yml"
  "docs/index.md"
  "docs/development.md"
)

# Bootstrap args for all-agent tests
ALL_AGENTS="--agent claude,copilot,opencode"

# ── Helper: populate a directory with realistic project files ────────────────
# Simulates a real project that already has common files before HARC is added.
seed_existing_project() {
  local dir="$1"

  # README with real content
  cat > "$dir/README.md" << 'SEED'
# Acme Billing Service

Handles subscription lifecycle for B2B customers. Processes payments via Stripe,
emits billing events to the data platform, and exposes a REST API consumed by
the web application.

## Getting Started

```bash
npm install
npm run dev
```

## Testing

```bash
npm test
```

## License

MIT
SEED

  # CHANGELOG with real entries
  cat > "$dir/CHANGELOG.md" << 'SEED'
# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2025-11-15

### Added
- Stripe webhook handler for subscription cancellations
- Rate limiting middleware on billing endpoints

### Fixed
- Incorrect tax calculation for EU customers

## [1.1.0] - 2025-09-01

### Added
- Multi-currency support (EUR, GBP, CAD)
- Invoice PDF generation

## [1.0.0] - 2025-06-01

### Added
- Initial release with Stripe integration
- REST API for subscription management
SEED

  # docs/ with existing content
  mkdir -p "$dir/docs"
  cat > "$dir/docs/index.md" << 'SEED'
# Acme Billing Service

Welcome to the Acme Billing Service documentation.

## Architecture

The billing service is a Node.js application that connects to PostgreSQL
and communicates with Stripe's API for payment processing.

## API Reference

See [API docs](api.md) for endpoint documentation.
SEED

  cat > "$dir/docs/development.md" << 'SEED'
# Development Guide

## Prerequisites

- Node.js 20+
- PostgreSQL 16
- Stripe test API key

## Local Setup

```bash
cp .env.example .env
npm install
npm run db:migrate
npm run dev
```

## Running Tests

```bash
npm test              # Unit tests
npm run test:e2e      # End-to-end tests
```
SEED

  # .github/ with existing CI config
  mkdir -p "$dir/.github"
  cat > "$dir/.github/copilot-instructions.md" << 'SEED'
# Acme Billing Service

This is a Node.js billing service. Use TypeScript for all new code.
Follow existing patterns in src/handlers/ for new endpoints.
SEED

  # catalog-info.yaml (already using Backstage)
  cat > "$dir/catalog-info.yaml" << 'SEED'
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: acme-billing
  description: Subscription billing for B2B customers
spec:
  type: service
  lifecycle: production
  owner: billing-team
SEED
}

# ── Helper: validate expected files exist ────────────────────────────────────
validate_expected_files() {
  local dir="$1"
  local errors=0

  for f in "${EXPECTED_FILES[@]}"; do
    if [ -f "$dir/$f" ]; then
      echo -e "  ${GREEN}✓${RESET} $f"
    else
      echo -e "  ${RED}✗${RESET} $f (MISSING)"
      ((errors++)) || true
    fi
  done

  return "$errors"
}

# ── Test function: fresh repo ────────────────────────────────────────────────
test_fresh() {
  echo ""
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo -e "${CYAN}  Testing: Fresh Repo Bootstrap${RESET}"
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

  # Clean and recreate
  rm -rf "$TEST_DIR"
  mkdir -p "$TEST_DIR"

  # Run bootstrap with all agents
  pushd "$TEST_DIR" > /dev/null
  bash "$BOOTSTRAP_SCRIPT" $ALL_AGENTS
  popd > /dev/null

  # Report
  echo ""
  echo -e "${CYAN}  Files created:${RESET}"
  (cd "$TEST_DIR" && find . -type f | sort | sed 's/^/    /')
  echo ""

  # Validate all expected files
  local errors=0
  validate_expected_files "$TEST_DIR" || errors=$?

  # Verify NO -HARC files exist (fresh repo should have none)
  echo ""
  local harc_count
  harc_count=$(cd "$TEST_DIR" && find . -name "*-HARC*" -type f | wc -l | tr -d ' ')
  if [ "$harc_count" -eq 0 ]; then
    echo -e "  ${GREEN}✓${RESET} No -HARC files created (correct for fresh repo)"
  else
    echo -e "  ${RED}✗${RESET} Found $harc_count unexpected -HARC files in fresh repo!"
    (cd "$TEST_DIR" && find . -name "*-HARC*" -type f | sed 's/^/      /')
    ((errors++)) || true
  fi

  # Verify files contain expected template content
  echo ""
  echo -e "  ${CYAN}Checking template content:${RESET}"
  if grep -q '\[PLACEHOLDER' "$TEST_DIR/CLAUDE.md"; then
    echo -e "  ${GREEN}✓${RESET} CLAUDE.md contains [PLACEHOLDER] markers"
  else
    echo -e "  ${RED}✗${RESET} CLAUDE.md missing [PLACEHOLDER] markers"
    ((errors++)) || true
  fi
  if grep -q '\[Unreleased\]' "$TEST_DIR/CHANGELOG.md"; then
    echo -e "  ${GREEN}✓${RESET} CHANGELOG.md contains [Unreleased] section"
  else
    echo -e "  ${RED}✗${RESET} CHANGELOG.md missing [Unreleased] section"
    ((errors++)) || true
  fi

  echo ""
  if [ "$errors" -eq 0 ]; then
    echo -e "  ${GREEN}Fresh repo test passed.${RESET}"
  else
    echo -e "  ${RED}$errors issue(s) found in fresh repo test!${RESET}"
  fi

  echo ""
  echo -e "  ${YELLOW}Inspect results:${RESET} test-results/bootstrap/"
  return "$errors"
}

# ── Test function: existing repo ─────────────────────────────────────────────
test_existing() {
  echo ""
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo -e "${CYAN}  Testing: Existing Repo Bootstrap (-HARC templates)${RESET}"
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

  # Clean and recreate
  rm -rf "$TEST_DIR"
  mkdir -p "$TEST_DIR"

  # Populate with realistic project files
  seed_existing_project "$TEST_DIR"

  echo ""
  echo -e "  ${YELLOW}Pre-existing files (realistic project data):${RESET}"
  (cd "$TEST_DIR" && find . -type f | sort | sed 's/^/    /')
  echo ""

  # Run bootstrap with all agents
  pushd "$TEST_DIR" > /dev/null
  bash "$BOOTSTRAP_SCRIPT" $ALL_AGENTS
  popd > /dev/null

  # Report
  echo ""
  echo -e "${CYAN}  All files after bootstrap:${RESET}"
  (cd "$TEST_DIR" && find . -type f | sort | sed 's/^/    /')
  echo ""

  local errors=0

  # -HARC files expected for each pre-existing file that bootstrap also generates
  local expected_harc_files=(
    "CHANGELOG-HARC.md"
    ".github/copilot-instructions-HARC.md"
    "catalog-info-HARC.yaml"
    "docs/index-HARC.md"
    "docs/development-HARC.md"
  )

  echo -e "  ${CYAN}Checking -HARC template files:${RESET}"
  for f in "${expected_harc_files[@]}"; do
    if [ -f "$TEST_DIR/$f" ]; then
      echo -e "  ${GREEN}✓${RESET} $f"
    else
      echo -e "  ${RED}✗${RESET} $f (MISSING — should have been created)"
      ((errors++)) || true
    fi
  done

  # Verify originals are preserved (not overwritten)
  echo ""
  echo -e "  ${CYAN}Checking originals preserved:${RESET}"
  if grep -q "Acme Billing Service" "$TEST_DIR/README.md"; then
    echo -e "  ${GREEN}✓${RESET} README.md preserved (original content intact)"
  else
    echo -e "  ${RED}✗${RESET} README.md was overwritten!"
    ((errors++)) || true
  fi
  if grep -q "Stripe webhook handler" "$TEST_DIR/CHANGELOG.md"; then
    echo -e "  ${GREEN}✓${RESET} CHANGELOG.md preserved (original content intact)"
  else
    echo -e "  ${RED}✗${RESET} CHANGELOG.md was overwritten!"
    ((errors++)) || true
  fi
  if grep -q "acme-billing" "$TEST_DIR/catalog-info.yaml"; then
    echo -e "  ${GREEN}✓${RESET} catalog-info.yaml preserved (original content intact)"
  else
    echo -e "  ${RED}✗${RESET} catalog-info.yaml was overwritten!"
    ((errors++)) || true
  fi
  if grep -q "Acme Billing Service documentation" "$TEST_DIR/docs/index.md"; then
    echo -e "  ${GREEN}✓${RESET} docs/index.md preserved (original content intact)"
  else
    echo -e "  ${RED}✗${RESET} docs/index.md was overwritten!"
    ((errors++)) || true
  fi
  if grep -q "Node.js 20" "$TEST_DIR/docs/development.md"; then
    echo -e "  ${GREEN}✓${RESET} docs/development.md preserved (original content intact)"
  else
    echo -e "  ${RED}✗${RESET} docs/development.md was overwritten!"
    ((errors++)) || true
  fi

  # -HARC files should contain HARC template content (not the original)
  echo ""
  echo -e "  ${CYAN}Checking -HARC files contain template content:${RESET}"
  if grep -q '\[Unreleased\]' "$TEST_DIR/CHANGELOG-HARC.md"; then
    echo -e "  ${GREEN}✓${RESET} CHANGELOG-HARC.md has HARC template content"
  else
    echo -e "  ${RED}✗${RESET} CHANGELOG-HARC.md doesn't have HARC template content"
    ((errors++)) || true
  fi
  if grep -q 'SYNC REQUIREMENT\|SYNC NOTICE\|copilot-instructions.md' "$TEST_DIR/.github/copilot-instructions-HARC.md"; then
    echo -e "  ${GREEN}✓${RESET} copilot-instructions-HARC.md has HARC template content"
  else
    echo -e "  ${RED}✗${RESET} copilot-instructions-HARC.md doesn't have HARC template content"
    ((errors++)) || true
  fi

  # New files should be created directly (no -HARC suffix)
  echo ""
  echo -e "  ${CYAN}Checking new files created directly:${RESET}"
  if [ -f "$TEST_DIR/CLAUDE.md" ]; then
    echo -e "  ${GREEN}✓${RESET} CLAUDE.md created (no conflict)"
  else
    echo -e "  ${RED}✗${RESET} CLAUDE.md missing"
    ((errors++)) || true
  fi
  if [ -f "$TEST_DIR/AGENTS.md" ]; then
    echo -e "  ${GREEN}✓${RESET} AGENTS.md created (no conflict)"
  else
    echo -e "  ${RED}✗${RESET} AGENTS.md missing"
    ((errors++)) || true
  fi
  if [ -f "$TEST_DIR/docs/context/requirements.md" ]; then
    echo -e "  ${GREEN}✓${RESET} docs/context/requirements.md created (new directory)"
  else
    echo -e "  ${RED}✗${RESET} docs/context/requirements.md missing"
    ((errors++)) || true
  fi

  echo ""
  if [ "$errors" -eq 0 ]; then
    echo -e "  ${GREEN}Existing repo test passed.${RESET}"
  else
    echo -e "  ${RED}$errors issue(s) found in existing repo test!${RESET}"
  fi

  echo ""
  echo -e "  ${YELLOW}Inspect results:${RESET} test-results/bootstrap/"
  return "$errors"
}

# ── Test function: upgrade (re-run bootstrap) ────────────────────────────────
test_upgrade() {
  echo ""
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  echo -e "${CYAN}  Testing: Upgrade Scenario (re-run bootstrap)${RESET}"
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

  # Clean and recreate
  rm -rf "$TEST_DIR"
  mkdir -p "$TEST_DIR"

  # First run — fresh bootstrap
  echo ""
  echo -e "  ${YELLOW}Step 1: Initial bootstrap (fresh repo)${RESET}"
  pushd "$TEST_DIR" > /dev/null
  bash "$BOOTSTRAP_SCRIPT" $ALL_AGENTS
  popd > /dev/null

  # Simulate user customization: replace placeholders in a few files
  echo ""
  echo -e "  ${YELLOW}Step 2: Simulating user customization...${RESET}"
  sed -i '' 's/\[PLACEHOLDER — project name\]/Acme Billing/' "$TEST_DIR/CLAUDE.md" 2>/dev/null || \
    sed -i 's/\[PLACEHOLDER — project name\]/Acme Billing/' "$TEST_DIR/CLAUDE.md"
  echo "  Custom content added to CLAUDE.md" >> "$TEST_DIR/CLAUDE.md"

  sed -i '' 's/\[PLACEHOLDER — project name\]/Acme Billing/' "$TEST_DIR/AGENTS.md" 2>/dev/null || \
    sed -i 's/\[PLACEHOLDER — project name\]/Acme Billing/' "$TEST_DIR/AGENTS.md"

  # Add a real feature spec
  cat > "$TEST_DIR/docs/context/features/billing-engine.md" << 'SEED'
# Feature: Billing Engine

## Status
`in-progress`

## Problem Statement
Process subscription payments via Stripe.

## Acceptance Criteria
- [x] [AC-001] Accept credit card payments
- [ ] [AC-002] Support multi-currency billing
SEED

  # Add a custom ADR
  cat > "$TEST_DIR/docs/context/decisions/0002-use-stripe.md" << 'SEED'
# ADR-0002: Use Stripe for Payment Processing

## Status
Accepted

## Date
2025-06-01

## Context
We need a payment processor that supports subscriptions and multi-currency.

## Decision
We will use Stripe.

## Consequences
- Positive: Best-in-class subscription support
- Negative: Transaction fees
SEED

  # Modify CHANGELOG to simulate real usage
  cat > "$TEST_DIR/CHANGELOG.md" << 'SEED'
# Changelog

## [Unreleased]

### Added
- Billing engine feature spec
- ADR-0002: Use Stripe

## [0.1.0] - 2025-06-01

### Added
- Initial HARC context structure
SEED

  local first_run_files
  first_run_files=$(cd "$TEST_DIR" && find . -type f | sort)

  echo ""
  echo -e "  ${YELLOW}Step 3: Re-running bootstrap (simulating upgrade)${RESET}"
  pushd "$TEST_DIR" > /dev/null
  bash "$BOOTSTRAP_SCRIPT" $ALL_AGENTS
  popd > /dev/null

  # Report
  echo ""
  echo -e "${CYAN}  All files after upgrade:${RESET}"
  (cd "$TEST_DIR" && find . -type f | sort | sed 's/^/    /')
  echo ""

  local errors=0

  # Every file the bootstrap generates should now have a -HARC variant
  # (since they all existed from the first run)
  local expected_harc_files=(
    "CLAUDE-HARC.md"
    "AGENTS-HARC.md"
    ".github/copilot-instructions-HARC.md"
    "catalog-info-HARC.yaml"
    "CHANGELOG-HARC.md"
    "docs/context/requirements-HARC.md"
    "docs/context/architecture-HARC.md"
    "docs/context/constraints-HARC.md"
    "docs/context/glossary-HARC.md"
    "docs/context/roadmap-HARC.md"
    "docs/context/decisions/0001-example-decision-HARC.md"
    "docs/context/features/example-feature-HARC.md"
    ".claude/commands/new-feature-HARC.md"
    ".claude/commands/create-adr-HARC.md"
    ".claude/commands/update-context-HARC.md"
    ".claude/commands/review-pr-HARC.md"
    ".github/copilot/commands/new-feature-HARC.md"
    ".github/copilot/commands/create-adr-HARC.md"
    ".github/copilot/commands/update-context-HARC.md"
    ".github/copilot/commands/review-pr-HARC.md"
    ".opencode/commands/new-feature-HARC.md"
    ".opencode/commands/create-adr-HARC.md"
    ".opencode/commands/update-context-HARC.md"
    ".opencode/commands/review-pr-HARC.md"
    "docs/mkdocs-HARC.yml"
    "docs/index-HARC.md"
    "docs/development-HARC.md"
  )

  echo -e "  ${CYAN}Checking -HARC templates created for all bootstrap files:${RESET}"
  for f in "${expected_harc_files[@]}"; do
    if [ -f "$TEST_DIR/$f" ]; then
      echo -e "  ${GREEN}✓${RESET} $f"
    else
      echo -e "  ${RED}✗${RESET} $f (MISSING)"
      ((errors++)) || true
    fi
  done

  # User's custom files should NOT have -HARC variants (bootstrap doesn't know about them)
  echo ""
  echo -e "  ${CYAN}Checking user-created files unaffected:${RESET}"
  if [ -f "$TEST_DIR/docs/context/features/billing-engine.md" ] && ! [ -f "$TEST_DIR/docs/context/features/billing-engine-HARC.md" ]; then
    echo -e "  ${GREEN}✓${RESET} billing-engine.md preserved, no -HARC variant (correct)"
  else
    echo -e "  ${RED}✗${RESET} billing-engine.md handling incorrect"
    ((errors++)) || true
  fi
  if [ -f "$TEST_DIR/docs/context/decisions/0002-use-stripe.md" ] && ! [ -f "$TEST_DIR/docs/context/decisions/0002-use-stripe-HARC.md" ]; then
    echo -e "  ${GREEN}✓${RESET} 0002-use-stripe.md preserved, no -HARC variant (correct)"
  else
    echo -e "  ${RED}✗${RESET} 0002-use-stripe.md handling incorrect"
    ((errors++)) || true
  fi

  # Verify customized content is preserved
  echo ""
  echo -e "  ${CYAN}Checking customized content preserved:${RESET}"
  if grep -q "Acme Billing" "$TEST_DIR/CLAUDE.md"; then
    echo -e "  ${GREEN}✓${RESET} CLAUDE.md customizations preserved"
  else
    echo -e "  ${RED}✗${RESET} CLAUDE.md customizations lost!"
    ((errors++)) || true
  fi
  if grep -q "Billing engine feature spec" "$TEST_DIR/CHANGELOG.md"; then
    echo -e "  ${GREEN}✓${RESET} CHANGELOG.md customizations preserved"
  else
    echo -e "  ${RED}✗${RESET} CHANGELOG.md customizations lost!"
    ((errors++)) || true
  fi

  # Verify -HARC files have fresh template content
  echo ""
  echo -e "  ${CYAN}Checking -HARC files contain latest template content:${RESET}"
  if grep -q '\[PLACEHOLDER' "$TEST_DIR/CLAUDE-HARC.md"; then
    echo -e "  ${GREEN}✓${RESET} CLAUDE-HARC.md has fresh template with [PLACEHOLDER]"
  else
    echo -e "  ${RED}✗${RESET} CLAUDE-HARC.md doesn't have template content"
    ((errors++)) || true
  fi
  if grep -q 'keepachangelog\|CHANGELOG.*Living artifact' "$TEST_DIR/CHANGELOG-HARC.md"; then
    echo -e "  ${GREEN}✓${RESET} CHANGELOG-HARC.md has fresh template content"
  else
    echo -e "  ${RED}✗${RESET} CHANGELOG-HARC.md doesn't have template content"
    ((errors++)) || true
  fi

  echo ""
  if [ "$errors" -eq 0 ]; then
    echo -e "  ${GREEN}Upgrade test passed.${RESET}"
  else
    echo -e "  ${RED}$errors issue(s) found in upgrade test!${RESET}"
  fi

  echo ""
  echo -e "  ${YELLOW}Inspect results:${RESET} test-results/bootstrap/"
  return "$errors"
}

# ── Run tests ────────────────────────────────────────────────────────────────
total_errors=0

case "$MODE" in
  fresh)
    test_fresh || total_errors=$?
    ;;
  existing)
    test_existing || total_errors=$?
    ;;
  upgrade)
    test_upgrade || total_errors=$?
    ;;
  all)
    test_fresh || total_errors=$?
    rm -rf "${SCRIPT_DIR}/test-results/bootstrap-fresh"
    mv "$TEST_DIR" "${SCRIPT_DIR}/test-results/bootstrap-fresh"

    test_existing || ((total_errors += $?)) || true
    rm -rf "${SCRIPT_DIR}/test-results/bootstrap-existing"
    mv "$TEST_DIR" "${SCRIPT_DIR}/test-results/bootstrap-existing"

    test_upgrade || ((total_errors += $?)) || true
    rm -rf "${SCRIPT_DIR}/test-results/bootstrap-upgrade"
    mv "$TEST_DIR" "${SCRIPT_DIR}/test-results/bootstrap-upgrade"

    echo ""
    echo -e "  ${CYAN}Results available at:${RESET}"
    echo "    test-results/bootstrap-fresh/     (new repo test)"
    echo "    test-results/bootstrap-existing/  (existing repo test)"
    echo "    test-results/bootstrap-upgrade/   (upgrade/re-run test)"
    ;;
esac

echo ""
if [ "$total_errors" -eq 0 ]; then
  echo -e "${GREEN}All tests passed.${RESET}"
else
  echo -e "${RED}Tests completed with $total_errors error(s).${RESET}"
  exit 1
fi
