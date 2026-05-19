# Wiki Guide

The wiki lives in `src/` and is built with mdBook. This file maps what each section covers so you know where to look and what to update.

---

## Structure

```
src/
  SUMMARY.md              ← mdBook table of contents (must be updated when adding pages)
  architecture/
    overview.md            ← Server topology, service inventory table, port assignments
    auth-sso.md            ← oauth2-proxy + Pocket ID flow, OIDC configuration, auth tiers
    network.md             ← Firewall rules, Cloudflare DNS, split-DNS via AdGuard
  configuration/
    caddy.md               ← Caddyfile structure, snippets (require_auth, security_headers), TLS
  operations/
    adding-a-service.md    ← Checklist for adding a new service (compose, Caddy, DNS, Pocket ID)
    maintenance.md         ← Routine tasks: updates, backups, Docker cleanup
    secret-rotation.md     ← How to rotate oauth2-proxy cookies, OIDC secrets, Cloudflare tokens
  services/
    pocket-id.md           ← OIDC provider config, passkey setup, client registration
    oauth2-proxy.md        ← Proxy config, upstream headers, cookie settings
    gitea.md               ← Git hosting, act-runner CI/CD, OIDC login via Pocket ID
    hugo-blog.md           ← Blog build pipeline, Gitea CI/CD → registry → deploy
    immich.md              ← Photo management, ML offload, PostgreSQL, upload paths
    actual-budget.md       ← Budget app, OIDC login
    memos.md               ← Note-taking, API usage
    mailhog.md             ← Email testing, Postfix relay
    paperless.md           ← Document management, consumption paths, PostgreSQL
    adguard.md             ← DNS server, split-DNS rewrites, upstream config
    cv.md                  ← CV Hugo site, build pipeline
    cv-ai.md               ← CV-AI FastAPI agent, Ollama integration, model requirements
    cv-forms.md            ← CV form submission service
    static-site.md         ← Root domain static site
    wiki.md                ← This mdBook wiki, build and deploy
```

---

## What Lives Where

| Topic | File | Key content |
|---|---|---|
| Service inventory (ports, auth, subdomains) | `architecture/overview.md` | The canonical table — update when adding/moving services |
| How auth works end-to-end | `architecture/auth-sso.md` | Caddy → oauth2-proxy → Pocket ID flow |
| Caddy configuration patterns | `configuration/caddy.md` | Snippets, site blocks, `forward_auth` setup |
| Adding a new service | `operations/adding-a-service.md` | Step-by-step: compose → Caddy → DNS → Pocket ID → validate |
| Per-service details | `services/<name>.md` | Docker compose, env vars, volumes, ports, quirks |

---

## When to Update the Wiki

After deploying any change from the notes plans, update:

1. **`architecture/overview.md`** — if services move between servers or new services are added
2. **`services/<name>.md`** — if a service's configuration changes (ports, volumes, env vars)
3. **`configuration/caddy.md`** — if Caddy snippets or site blocks change
4. **`SUMMARY.md`** — if new pages are added to the wiki

---

## Services That Need Wiki Updates After Migration

When the 3-server architecture is deployed, these wiki pages will need updates:

| Page | Change needed |
|---|---|
| `architecture/overview.md` | New server topology diagram, updated service inventory with server assignments |
| `services/immich.md` | Document ML container split (NAS app + AI server ML), new env var |
| `services/cv-ai.md` | Document Ollama on AI server, model configuration, fine-tuning notes |
| `configuration/caddy.md` | Updated reverse_proxy targets (services now on NAS IP, CV-AI on AI server IP) |
| `architecture/network.md` | Firewall rules for 3 servers, inter-server communication |
| *(new page)* | Open WebUI service page if exposed via subdomain |
