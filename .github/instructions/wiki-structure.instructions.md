---
description: 'Use when editing or creating wiki documentation pages, updating SUMMARY.md, or working on mdBook content for the homelab knowledge base'
applyTo: 'src/**'
---

# Wiki Structure

The wiki lives in `src/`, built with mdBook (`book.toml` at repo root). The authoritative reference document is `src/constitution.md` — keep it updated when infrastructure changes.

## Layout

- **`src/SUMMARY.md`** — table of contents. Every new page must be linked here.
- **`src/architecture/`** — system-level docs:
  - `overview.md` — server topology, service inventory, port map
  - `auth-sso.md` — oauth2-proxy, Pocket ID, OIDC, auth tiers
  - `network.md` — firewall, Cloudflare DNS, split-DNS
- **`src/configuration/`** — config-file deep-dives:
  - `caddy.md` — Caddyfile structure, snippets, TLS
- **`src/services/`** — one file per deployed service. Each follows: purpose → ports → auth tier → compose snippet → notes
- **`src/operations/`** — runbooks:
  - `maintenance.md` — routine tasks, updates, backups, Docker cleanup
  - `adding-a-service.md` — public-facing version of the checklist
  - `secret-rotation.md` — credential management procedures

## Conventions

- One service per file in `src/services/`
- Cross-link related pages with relative markdown links
- Keep architecture docs technology-neutral where possible; put product specifics in `services/`
- Update `SUMMARY.md` whenever adding or renaming a page
