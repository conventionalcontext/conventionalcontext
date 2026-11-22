# Publishing docs/context/ with Backstage TechDocs

`docs/context/` is plain Markdown, so any documentation site or developer
portal can publish it. This example shows the two files Backstage TechDocs
needs in an adopting repository. Conventional Context does not require them.

| File | Put it at | What it does |
|---|---|---|
| [`mkdocs.yml`](mkdocs.yml) | repository root | Builds `docs/`, including `docs/context/`, with the `techdocs-core` plugin |
| [`catalog-info.yaml`](catalog-info.yaml) | repository root | Registers the component and points TechDocs at the repository (`backstage.io/techdocs-ref: dir:.`) |

Two things to know:

- **Links to OpenSpec.** `docs/context/` links to `openspec/specs/` and
  `openspec/changes/`, which are outside `docs/`. The `validation` setting in
  `mkdocs.yml` reports these links instead of failing the build. Readers
  follow them to the repository, where the specs live. Nothing is copied.
- **Frontmatter.** Each file starts with a few lines of YAML (`type`,
  `status`). TechDocs ignores them; portals that ingest Markdown (such as
  Port) can use them to tell context files apart.

Other portals: point their documentation or file ingestion at `docs/`. No
other setup is specific to Conventional Context.
