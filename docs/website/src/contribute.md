---
title: Contribute
hide:
  - navigation
---

# Contribute

Conventional Context is an open specification, developed in the open on
[GitHub](https://github.com/conventionalcontext/conventionalcontext).
Questions, ideas, and examples from real repositories are all welcome.

## Ways to help

- **Ask or suggest** in
  [issues](https://github.com/conventionalcontext/conventionalcontext/issues):
  anything unclear, missing, or that does not fit how your team works.
- **Try it** on one of your repositories, and tell us what was hard.
- **Share an example** of a filled-in `docs/context/` we can learn from.
- **Propose a change** to the specification or this website through a pull
  request.

## How a change is made

This project keeps its own intent in its
[`docs/context/`](https://github.com/conventionalcontext/conventionalcontext/tree/main/docs/context),
following its own specification. Read it first, starting with the
[index](https://github.com/conventionalcontext/conventionalcontext/blob/main/docs/context/README.md).

1. **Open an issue** for anything beyond a small fix, so the change can be
   discussed before work starts.
2. **Record significant decisions** as a new file in
   `docs/context/decisions/` ([MADR 4](https://adr.github.io/madr/)).
3. **Update `docs/context/`** in the same pull request as the change it
   describes.
4. **Add a line to `CHANGELOG.md`** under `Unreleased`
   ([Keep a Changelog](https://keepachangelog.com/en/1.1.0/)).
5. **Write commit messages** in
   [Conventional Commits](https://www.conventionalcommits.org/) form, for
   example `docs(spec): clarify index frontmatter`.

Every pull request is reviewed by a maintainer before it merges. A full
`CONTRIBUTING.md` is on the roadmap.

## Licenses

| Part | License |
|---|---|
| Specification, profiles, adapters | [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/): share and adapt with attribution |
| Templates | [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/): copy freely, no conditions |
| Everything else (schema, tools, examples, this website) | [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0) |

By contributing, you agree that your contribution is licensed under the
license of the part you change.

## Work on this website

The site is built with [Zensical](https://zensical.org/) from
`docs/website/`. With [uv](https://docs.astral.sh/uv/) installed, run this from
the repository root; it fetches the pinned tools on first use, so there is
nothing to install first:

```bash
uv run --no-project --with-requirements docs/website/requirements.txt \
  zensical serve -f docs/website/mkdocs.yml    # preview at http://127.0.0.1:8000
```

Before opening a pull request, check that it builds without warnings:

```bash
uv run --no-project --with-requirements docs/website/requirements.txt \
  zensical build --strict -f docs/website/mkdocs.yml
```
