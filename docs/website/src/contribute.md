---
title: Contribute
hide:
  - navigation
---

# Contribute

Conventional Context is developed in the open on
[GitHub](https://github.com/conventionalcontext/conventionalcontext).
Questions, ideas, and reports from real projects are all welcome.

## Ways to help

- **Try it** on a new project, and tell us what was unclear or slow.
- **Ask or suggest** in
  [issues](https://github.com/conventionalcontext/conventionalcontext/issues).
- **Share** a `docs/context/` from a real project that we can learn from.
- **Propose a change** to the schema, the templates, or this website through
  a pull request.

## How a change is made

This repository uses its own schema. Its intent is in
[`docs/context/`](https://github.com/conventionalcontext/conventionalcontext/tree/main/docs/context),
and its behavior specs are in `openspec/specs/`.

1. **Open an issue** for anything beyond a small fix, so it can be discussed
   first.
2. **Propose the change with OpenSpec** (`/openspec-propose`), so it is
   checked against the project's constraints and decisions.
3. **Add a line to `CHANGELOG.md`** under `Unreleased`
   ([Keep a Changelog](https://keepachangelog.com/en/1.1.0/)).
4. **Write commit messages** in
   [Conventional Commits](https://www.conventionalcommits.org/) form.

Every pull request is reviewed and approved by a maintainer before it
merges. Contributions are licensed under the [MIT License](https://github.com/conventionalcontext/conventionalcontext/blob/main/LICENSE).

## Work on this website

The site is built with [Zensical](https://zensical.org/) from
`docs/website/`. With [uv](https://docs.astral.sh/uv/) installed, run this from
the repository root; it fetches the pinned tools on first use:

```bash
uv run --no-project --with-requirements docs/website/requirements.txt \
  zensical serve -f docs/website/mkdocs.yml    # preview at http://127.0.0.1:8000
```

Before opening a pull request, check that it builds without warnings:

```bash
uv run --no-project --with-requirements docs/website/requirements.txt \
  zensical build --strict -f docs/website/mkdocs.yml
```
