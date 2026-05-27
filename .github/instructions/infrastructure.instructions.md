---
description: 'Use when working on the homelab infrastructure: authentication, oauth2-proxy, Pocket ID, OIDC, services, ports, Docker compose, Caddy reverse proxy, or networking'
applyTo: 'src/architecture/**, src/configuration/**, src/services/**, src/operations/**'
---

# Infrastructure Spec

## Stack

- **Reverse proxy:** Caddy 2.9+ with `caddy-dns/cloudflare` plugin
- **Auth:** oauth2-proxy v7.6.0 (`localhost:4180`) → Pocket ID v2 (`login.mmastro.dev`, passkey-only)
- **TLS:** All via Caddy, DNS-01 challenge through Cloudflare API. No containers expose HTTPS.
- **Docker network:** `homenet` (external, shared across all stacks)
- **Storage:** ZFS at `/tank`, documents at `/tank/docs/paperless/`
- **Static site:** `/var/www/html/mastrosite/`
- **DNS (split):** AdGuard Home rewrites `*.mmastro.dev` → server LAN IP for local clients

## Auth Tiers

| Tier | Caddy snippet | Requirement |
|---|---|---|
| None | — | Public or self-authenticated |
| Standard | `import require_auth` | oauth2-proxy OIDC session |
| Admin | `import require_auth_admin` | OIDC session + LAN/VPN IP (`192.168.178.0/24`) |

Admin tier: IP check runs first → 403 for untrusted IPs before showing login.

## Services and Ports

| Subdomain | Service | Port | Auth |
|---|---|---|---|
| `login.mmastro.dev` | Pocket ID | 1411 | None |
| `auth.mmastro.dev` | oauth2-proxy | 4180 | None |
| `mmastro.dev` | Static site | files | None |
| `blog.mmastro.dev` | Hugo blog | 8000 | None |
| `cv.mmastro.dev` | CV (Hugo) | 8001 | None |
| `git.mmastro.dev` | Gitea | 3000 | Admin |
| `photos.mmastro.dev` | Immich | 2283 | Standard |
| `budget.mmastro.dev` | Actual Budget | 5006 | Standard |
| `mail.mmastro.dev` | MailHog | 8025 | Admin |
| `memos.mmastro.dev` | Memos | 5230 | Standard |
| `drive.mmastro.dev` | Paperless-ngx | 8010 | Standard |
| `wiki.mmastro.dev` | mdBook wiki | 1240 | Admin |
| `dns.mmastro.dev` | AdGuard Home | 8088 | Admin |

## Container Conventions

- Bind all ports to `127.0.0.1` (exceptions: DNS 53, Gitea SSH 222)
- Join the external `homenet` network
- Set `restart: unless-stopped`
- Compose file at `/srv/<service>/docker-compose.yml`
